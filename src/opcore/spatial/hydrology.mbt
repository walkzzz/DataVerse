///|
/// # opcore/hydrology 水文分析 / Hydrology Analysis
///
/// Fill / Flow Direction / Flow Accumulation / Watershed / Sink / Basin / Stream Order。
/// 对标 ArcGIS Pro 水文分析工具集（20 工具）。
/// S4.3 填充：D8 流向算法 + 模拟实现。
///
/// # Hydrology analysis
///
/// Fill / Flow Direction / Flow Accumulation / Watershed. Aligned with ArcGIS Pro Hydrology toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 栅格高程 / Raster elevation grid.
pub struct RasterGrid {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
} derive(Debug, Eq)

///|
pub extend RasterGrid with Eq::{equal, not_equal}

///|
pub extend RasterGrid with Debug::{to_repr}

///|
/// 流向结果 / Flow direction result (D8 encoding).
///
/// D8 编码：1=E, 2=SE, 4=S, 8=SW, 16=W, 32=NW, 64=N, 128=NE, 0=无流向。
pub(all) struct FlowDirResult {
  directions : Array[Array[Int32]]
  rows : Int32
  cols : Int32
} derive(Debug, Eq)

///|
pub extend FlowDirResult with Eq::{equal, not_equal}

///|
pub extend FlowDirResult with Debug::{to_repr}

///|
/// 流向累积结果 / Flow accumulation result.
pub(all) struct FlowAccumResult {
  accumulation : Array[Array[Int32]]
  rows : Int32
  cols : Int32
} derive(Debug, Eq)

///|
pub extend FlowAccumResult with Eq::{equal, not_equal}

///|
pub extend FlowAccumResult with Debug::{to_repr}

///|
/// 水文结果 / Hydrology result: 通用结果容器。
pub struct HydrologyResult {
  kind : String
  cells : Array[(Int32, Int32)]
  count : Int32
} derive(Debug, Eq)

///|
pub extend HydrologyResult with Eq::{equal, not_equal}

///|
pub extend HydrologyResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

///|
/// 构造栅格 / Build a raster grid.
pub fn hydrology_make_raster(data : Array[Array[Double]]) -> RasterGrid {
  let rows = data.length()
  let cols = if rows > 0 { data[0].length() } else { 0 }
  { data, rows, cols, }
}

///|
/// 空栅格 / Empty raster.
pub fn hydrology_empty_raster() -> RasterGrid {
  { data: [], rows: 0, cols: 0, }
}

///|
/// 栅格行数 / Row count.
pub fn hydrology_raster_rows(r : RasterGrid) -> Int32 {
  r.rows
}

///|
/// 栅格列数 / Column count.
pub fn hydrology_raster_cols(r : RasterGrid) -> Int32 {
  r.cols
}

///|
/// 获取像元值 / Get cell value.
///
/// 退化安全：越界返回 0.0。
pub fn hydrology_raster_get(r : RasterGrid, row : Int32, col : Int32) -> Double {
  if row < 0 || row >= r.rows || col < 0 || col >= r.cols {
    0.0
  } else {
    r.data[row][col]
  }
}

// ============================================================
// 洼地填充 / Fill sinks
// ============================================================

///|
/// 查找洼地 / Find sinks (local minima).
///
/// 洼地：像元值低于所有 8 邻域的像元。
/// 退化安全：空栅格返回空数组。
pub fn hydrology_hydrology_find_sinks(raster : RasterGrid) -> Array[(Int32, Int32)] {
  let sinks : Array[(Int32, Int32)] = []
  for i in 0..<raster.rows {
    for j in 0..<raster.cols {
      let center = raster.data[i][j]
      let mut is_sink = true
      for di in [-1, 0, 1] {
        for dj in [-1, 0, 1] {
          if di != 0 || dj != 0 {
            let ni = i + di
            let nj = j + dj
            if ni >= 0 && ni < raster.rows && nj >= 0 && nj < raster.cols {
              if raster.data[ni][nj] <= center {
                is_sink = false
              }
            }
          }
        }
      }
      if is_sink {
        sinks.push((i, j))
      }
    }
  }
  sinks
}

///|
/// 洼地填充 / Fill sinks: 将洼地抬升到邻域最小值。
///
/// 对标 ArcGIS Pro Fill。
/// 模拟策略：单次扫描，将每个洼地抬升到其最小邻域值。
/// 退化安全：空栅格返回空栅格。
pub fn hydrology_hydrology_fill(raster : RasterGrid) -> RasterGrid {
  if raster.rows == 0 || raster.cols == 0 {
    raster
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<raster.rows {
      let row : Array[Double] = []
      for j in 0..<raster.cols {
        let center = raster.data[i][j]
        let mut min_neighbor = 1.7976931348623157e308
        let mut has_lower_neighbor = false
        for di in [-1, 0, 1] {
          for dj in [-1, 0, 1] {
            if di != 0 || dj != 0 {
              let ni = i + di
              let nj = j + dj
              if ni >= 0 && ni < raster.rows && nj >= 0 && nj < raster.cols {
                let nval = raster.data[ni][nj]
                if nval < min_neighbor {
                  min_neighbor = nval
                }
                if nval < center {
                  has_lower_neighbor = true
                }
              }
            }
          }
        }
        if has_lower_neighbor {
          row.push(center)
        } else if min_neighbor < 1.7976931348623157e308 {
          row.push(min_neighbor)
        } else {
          row.push(center)
        }
      }
      result.push(row)
    }
    hydrology_make_raster(result)
  }
}

// ============================================================
// 流向分析 / Flow direction (D8)
// ============================================================

///|
/// D8 流向 / D8 flow direction.
///
/// 对标 ArcGIS Pro Flow Direction。
/// D8 编码：1=E, 2=SE, 4=S, 8=SW, 16=W, 32=NW, 64=N, 128=NE。
/// 规则：最陡下降方向。平坦区域流向 0。
/// 退化安全：空栅格返回空结果。
pub fn hydrology_hydrology_flow_direction(raster : RasterGrid) -> FlowDirResult {
  let dirs : Array[Array[Int32]] = []
  for i in 0..<raster.rows {
    let row : Array[Int32] = []
    for j in 0..<raster.cols {
      let center = raster.data[i][j]
      let mut max_drop = 0.0
      let mut best_dir = 0
      let d8_dirs = [
        (0, 1, 1),
        (1, 1, 2),
        (1, 0, 4),
        (1, -1, 8),
        (0, -1, 16),
        (-1, -1, 32),
        (-1, 0, 64),
        (-1, 1, 128),
      ]
      for item in d8_dirs {
        let (di, dj, code) = item
        let ni = i + di
        let nj = j + dj
        if ni >= 0 && ni < raster.rows && nj >= 0 && nj < raster.cols {
          let drop = center - raster.data[ni][nj]
          if drop > max_drop {
            max_drop = drop
            best_dir = code
          }
        }
      }
      row.push(best_dir)
    }
    dirs.push(row)
  }
  { directions: dirs, rows: raster.rows, cols: raster.cols, }
}

// ============================================================
// 流向累积 / Flow accumulation
// ============================================================

///|
/// 流向累积 / Flow accumulation: 每个像元的上游贡献总数。
///
/// 对标 ArcGIS Pro Flow Accumulation。
/// 模拟策略：反向扫描，统计流入每个像元的上游数。
/// 退化安全：空结果返回空。
pub fn hydrology_hydrology_flow_accumulation(flow_dir : FlowDirResult) -> FlowAccumResult {
  let rows = flow_dir.rows
  let cols = flow_dir.cols
  let accum : Array[Array[Int32]] = []
  for _ in 0..<rows {
    let row : Array[Int32] = []
    for _ in 0..<cols {
      row.push(1)
    }
    accum.push(row)
  }
  let d8_reverse = [
    (0, -1, 1),
    (-1, -1, 2),
    (-1, 0, 4),
    (-1, 1, 8),
    (0, 1, 16),
    (1, 1, 32),
    (1, 0, 64),
    (1, -1, 128),
  ]
  for i in 0..<rows {
    for j in 0..<cols {
      let dir = flow_dir.directions[i][j]
      if dir > 0 {
        for item in d8_reverse {
          let (di, dj, code) = item
          if dir == code {
            let ni = i + di
            let nj = j + dj
            if ni >= 0 && ni < rows && nj >= 0 && nj < cols {
              accum[ni][nj] = accum[ni][nj] + 1
            }
          }
        }
      }
    }
  }
  { accumulation: accum, rows, cols, }
}

// ============================================================
// 流域分析 / Watershed analysis
// ============================================================

///|
/// 流域 / Watershed: 追踪给定倾泻点的所有上游像元。
///
/// 对标 ArcGIS Pro Watershed。
/// 模拟策略：从倾泻点反向追踪所有流向它的像元（BFS）。
/// 退化安全：越界倾泻点返回空数组。
pub fn hydrology_hydrology_watershed(
  flow_dir : FlowDirResult,
  pour_row : Int32,
  pour_col : Int32,
) -> Array[(Int32, Int32)] {
  let rows = flow_dir.rows
  let cols = flow_dir.cols
  if pour_row < 0 || pour_row >= rows || pour_col < 0 || pour_col >= cols {
    []
  } else {
    let visited : Array[Array[Bool]] = []
    for _ in 0..<rows {
      let row : Array[Bool] = []
      for _ in 0..<cols {
        row.push(false)
      }
      visited.push(row)
    }
    let watershed : Array[(Int32, Int32)] = []
    let queue : Array[(Int32, Int32)] = [(pour_row, pour_col)]
    visited[pour_row][pour_col] = true
    watershed.push((pour_row, pour_col))
    let d8_reverse = [
      (0, -1, 1),
      (-1, -1, 2),
      (-1, 0, 4),
      (-1, 1, 8),
      (0, 1, 16),
      (1, 1, 32),
      (1, 0, 64),
      (1, -1, 128),
    ]
    while queue.length() > 0 {
      let (ci, cj) = queue.remove(0)
      ignore((ci, cj))
      for item in d8_reverse {
        let (di, dj, code) = item
        let ni = ci + di
        let nj = cj + dj
        if ni >= 0 && ni < rows && nj >= 0 && nj < cols {
          if !visited[ni][nj] && flow_dir.directions[ni][nj] == code {
            visited[ni][nj] = true
            watershed.push((ni, nj))
            queue.push((ni, nj))
          }
        }
      }
    }
    watershed
  }
}

///|
/// 流域盆地 / Basin: 从倾泻点追踪的完整汇水区。
///
/// 对标 ArcGIS Pro Basin。
/// 模拟策略：与 watershed 相同，返回 HydrologyResult。
pub fn hydrology_hydrology_basin(
  flow_dir : FlowDirResult,
  pour_row : Int32,
  pour_col : Int32,
) -> HydrologyResult {
  let cells = hydrology_hydrology_watershed(flow_dir, pour_row, pour_col)
  { kind: "basin", cells, count: cells.length(), }
}

// ============================================================
// 河流分析 / Stream analysis
// ============================================================

///|
/// 河流像元 / Stream cells: 流向累积超过阈值的像元。
///
/// 对标 ArcGIS Pro Stream Order (简化版)。
/// 退化安全：空结果返回空数组。
pub fn hydrology_hydrology_stream_cells(
  flow_accum : FlowAccumResult,
  threshold : Int32,
) -> Array[(Int32, Int32)] {
  let streams : Array[(Int32, Int32)] = []
  for i in 0..<flow_accum.rows {
    for j in 0..<flow_accum.cols {
      if flow_accum.accumulation[i][j] >= threshold {
        streams.push((i, j))
      }
    }
  }
  streams
}

///|
/// 河流分级 / Stream order: 返回河流像元及其 Strahler 分级（简化为累积值）。
///
/// 对标 ArcGIS Pro Stream Order。
/// 模拟策略：返回 (row, col, accum_value) 三元组。
pub fn hydrology_hydrology_stream_order(
  flow_accum : FlowAccumResult,
  threshold : Int32,
) -> Array[(Int32, Int32, Int32)] {
  let streams : Array[(Int32, Int32, Int32)] = []
  for i in 0..<flow_accum.rows {
    for j in 0..<flow_accum.cols {
      if flow_accum.accumulation[i][j] >= threshold {
        streams.push((i, j, flow_accum.accumulation[i][j]))
      }
    }
  }
  streams
}

// ============================================================
// 流路长度 / Flow path length
// ============================================================

///|
/// 流路长度 / Flow path length: 从给定像元沿流向到边界或洼地的步数。
///
/// 对标 ArcGIS Pro Flow Length。
/// 退化安全：越界返回 0。
pub fn hydrology_hydrology_flow_length(
  flow_dir : FlowDirResult,
  start_row : Int32,
  start_col : Int32,
) -> Int32 {
  let rows = flow_dir.rows
  let cols = flow_dir.cols
  if start_row < 0 || start_row >= rows || start_col < 0 || start_col >= cols {
    0
  } else {
    let d8_forward = [
      (0, 1, 1),
      (1, 1, 2),
      (1, 0, 4),
      (1, -1, 8),
      (0, -1, 16),
      (-1, -1, 32),
      (-1, 0, 64),
      (-1, 1, 128),
    ]
    let mut ci = start_row
    let mut cj = start_col
    let mut length = 0
    let visited_set : Array[(Int32, Int32)] = []
    while true {
      let dir = flow_dir.directions[ci][cj]
      if dir == 0 {
        break
      }
      let mut next_i = -1
      let mut next_j = -1
      let mut found = false
      for item in d8_forward {
        let (di, dj, code) = item
        if dir == code {
          next_i = ci + di
          next_j = cj + dj
          found = true
        }
      }
      if !found || next_i < 0 || next_i >= rows || next_j < 0 || next_j >= cols {
        break
      }
      let mut already = false
      for item in visited_set {
        let (vi, vj) = item
        if vi == ci && vj == cj {
          already = true
        }
      }
      if already {
        break
      }
      visited_set.push((ci, cj))
      ci = next_i
      cj = next_j
      length += 1
      if length > rows * cols {
        break
      }
    }
    length
  }
}

// ============================================================
// 汇总 / Summary
// ============================================================

///|
/// 水文统计 / Hydrology statistics: 返回栅格的最小/最大/平均高程。
///
/// 退化安全：空栅格返回 (0.0, 0.0, 0.0)。
pub fn hydrology_hydrology_stats(raster : RasterGrid) -> (Double, Double, Double) {
  if raster.rows == 0 || raster.cols == 0 {
    (0.0, 0.0, 0.0)
  } else {
    let mut min_val = raster.data[0][0]
    let mut max_val = raster.data[0][0]
    let mut sum = 0.0
    let mut count = 0
    for i in 0..<raster.rows {
      for j in 0..<raster.cols {
        let v = raster.data[i][j]
        if v < min_val {
          min_val = v
        }
        if v > max_val {
          max_val = v
        }
        sum = sum + v
        count += 1
      }
    }
    let avg = if count > 0 { sum / count.to_double() } else { 0.0 }
    (min_val, max_val, avg)
  }
}

///|
/// 倾泻点捕捉 / Snap pour point: 找到累积最高的邻域像元。
///
/// 对标 ArcGIS Pro Snap Pour Point。
/// 退化安全：越界返回原始坐标。
pub fn hydrology_hydrology_snap_pour(
  flow_accum : FlowAccumResult,
  row : Int32,
  col : Int32,
  search_radius : Int32,
) -> (Int32, Int32) {
  let rows = flow_accum.rows
  let cols = flow_accum.cols
  if row < 0 || row >= rows || col < 0 || col >= cols {
    (row, col)
  } else {
    let mut best_row = row
    let mut best_col = col
    let mut best_accum = flow_accum.accumulation[row][col]
    let range_start = -search_radius
    let range_end = search_radius + 1
    for di in range_start..<range_end {
      for dj in range_start..<range_end {
        let ni = row + di
        let nj = col + dj
        if ni >= 0 && ni < rows && nj >= 0 && nj < cols {
          if flow_accum.accumulation[ni][nj] > best_accum {
            best_accum = flow_accum.accumulation[ni][nj]
            best_row = ni
            best_col = nj
          }
        }
      }
    }
    (best_row, best_col)
  }
}
