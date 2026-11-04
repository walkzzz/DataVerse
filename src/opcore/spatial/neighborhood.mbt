///|
/// # opcore/neighborhood 邻域分析 / Neighborhood Analysis
///
/// Block Statistics / Line Statistics / Neighborhood。
/// 对标 ArcGIS Pro 邻域分析工具集（12 工具）。
/// S5.1 填充：块统计 + 线统计 + 邻域配置。
///
/// # Neighborhood analysis
///
/// Block / Line / Neighborhood Statistics. Aligned with ArcGIS Pro Neighborhood toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 块统计类型 / Block statistic kind.
pub(all) enum BlockStat {
  BlockMean
  BlockSum
  BlockMin
  BlockMax
  BlockRange
  BlockStd
  BlockCount
  BlockMajority
  BlockMinority
  BlockMedian
} derive(Debug, Eq)

///|
pub extend BlockStat with Eq::{equal, not_equal}

///|
pub extend BlockStat with Debug::{to_repr}

///|
/// 线统计类型 / Line statistic kind.
pub(all) enum LineStat {
  LineMean
  LineSum
  LineMin
  LineMax
  LineCount
  LineRange
  LineStd
} derive(Debug, Eq)

///|
pub extend LineStat with Eq::{equal, not_equal}

///|
pub extend LineStat with Debug::{to_repr}

///|
/// 邻域形状 / Neighborhood shape kind.
pub(all) enum NeighborhoodKind {
  NHRectangle
  NHCircle
  NHAnnulus
  NHWedge
  NHRing
} derive(Debug, Eq)

///|
pub extend NeighborhoodKind with Eq::{equal, not_equal}

///|
pub extend NeighborhoodKind with Debug::{to_repr}

///|
/// 邻域配置 / Neighborhood configuration.
pub struct NeighborhoodConfig {
  kind : NeighborhoodKind
  radius1 : Int32
  radius2 : Int32
} derive(Debug, Eq)

///|
pub extend NeighborhoodConfig with Eq::{equal, not_equal}

///|
pub extend NeighborhoodConfig with Debug::{to_repr}

///|
/// 块统计结果 / Block result.
pub struct BlockResult {
  value : Double
  block_row : Int32
  block_col : Int32
} derive(Debug, Eq)

///|
pub extend BlockResult with Eq::{equal, not_equal}

///|
pub extend BlockResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

///|
/// 构造邻域配置 / Build neighborhood config.
pub fn neighborhood_make_neighborhood_config(
  kind : NeighborhoodKind,
  radius1 : Int32,
  radius2 : Int32,
) -> NeighborhoodConfig {
  { kind, radius1, radius2, }
}

///|
/// 构造块结果 / Build a block result.
pub fn neighborhood_make_block_result(
  value : Double,
  block_row : Int32,
  block_col : Int32,
) -> BlockResult {
  { value, block_row, block_col, }
}

///|
/// 块统计类型名称 / Block stat name.
pub fn neighborhood_block_stat_name(s : BlockStat) -> String {
  match s {
    BlockMean => "mean"
    BlockSum => "sum"
    BlockMin => "min"
    BlockMax => "max"
    BlockRange => "range"
    BlockStd => "std"
    BlockCount => "count"
    BlockMajority => "majority"
    BlockMinority => "minority"
    BlockMedian => "median"
  }
}

///|
/// 线统计类型名称 / Line stat name.
pub fn neighborhood_line_stat_name(s : LineStat) -> String {
  match s {
    LineMean => "mean"
    LineSum => "sum"
    LineMin => "min"
    LineMax => "max"
    LineCount => "count"
    LineRange => "range"
    LineStd => "std"
  }
}

///|
/// 邻域形状名称 / Neighborhood kind name.
pub fn neighborhood_neighborhood_kind_name(k : NeighborhoodKind) -> String {
  match k {
    NHRectangle => "rectangle"
    NHCircle => "circle"
    NHAnnulus => "annulus"
    NHWedge => "wedge"
    NHRing => "ring"
  }
}

// ============================================================
// 块统计 / Block statistics
// ============================================================

///|
/// 收集块内值 / Collect values in a block.
fn neighborhood_block_values(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Array[Double] {
  let rows = hydrology_raster_rows(raster)
  let cols = hydrology_raster_cols(raster)
  let result : Array[Double] = []
  let r_start = block_row * block_size
  let c_start = block_col * block_size
  for i in 0..<block_size {
    for j in 0..<block_size {
      let r = r_start + i
      let c = c_start + j
      if r < rows && c < cols {
        result.push(hydrology_raster_get(raster, r, c))
      }
    }
  }
  result
}

///|
/// 块均值 / Block mean.
///
/// 退化安全：空块返回 0.0。
pub fn neighborhood_block_mean(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  let vals = neighborhood_block_values(raster, block_row, block_col, block_size)
  let n = vals.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for v in vals {
      sum = sum + v
    }
    sum / n.to_double()
  }
}

///|
/// 块求和 / Block sum.
pub fn neighborhood_block_sum(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  let vals = neighborhood_block_values(raster, block_row, block_col, block_size)
  let mut sum = 0.0
  for v in vals {
    sum = sum + v
  }
  sum
}

///|
/// 块最小值 / Block min.
///
/// 退化安全：空块返回 0.0。
pub fn neighborhood_block_min(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  let vals = neighborhood_block_values(raster, block_row, block_col, block_size)
  if vals.length() == 0 {
    0.0
  } else {
    let mut m = vals[0]
    for i in 1..<vals.length() {
      if vals[i] < m {
        m = vals[i]
      }
    }
    m
  }
}

///|
/// 块最大值 / Block max.
///
/// 退化安全：空块返回 0.0。
pub fn neighborhood_block_max(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  let vals = neighborhood_block_values(raster, block_row, block_col, block_size)
  if vals.length() == 0 {
    0.0
  } else {
    let mut m = vals[0]
    for i in 1..<vals.length() {
      if vals[i] > m {
        m = vals[i]
      }
    }
    m
  }
}

///|
/// 块极差 / Block range.
pub fn neighborhood_block_range(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  neighborhood_block_max(raster, block_row, block_col, block_size) -
  neighborhood_block_min(raster, block_row, block_col, block_size)
}

///|
/// 块计数 / Block count.
pub fn neighborhood_block_count(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Int32 {
  neighborhood_block_values(raster, block_row, block_col, block_size).length()
}

///|
/// 块标准差 / Block standard deviation.
///
/// 退化安全：空块返回 0.0。
pub fn neighborhood_block_std(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  let vals = neighborhood_block_values(raster, block_row, block_col, block_size)
  let n = vals.length()
  if n <= 1 {
    0.0
  } else {
    let mean = neighborhood_block_mean(raster, block_row, block_col, block_size)
    let mut sum_sq = 0.0
    for v in vals {
      let diff = v - mean
      sum_sq = sum_sq + diff * diff
    }
    (sum_sq / n.to_double()).sqrt()
  }
}

///|
/// 块众数 / Block majority (simplified: first value).
///
/// 退化安全：空块返回 0.0。
pub fn neighborhood_block_majority(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  let vals = neighborhood_block_values(raster, block_row, block_col, block_size)
  if vals.length() == 0 {
    0.0
  } else {
    vals[0]
  }
}

///|
/// 块少数 / Block minority (simplified: last value).
///
/// 退化安全：空块返回 0.0。
pub fn neighborhood_block_minority(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  let vals = neighborhood_block_values(raster, block_row, block_col, block_size)
  if vals.length() == 0 {
    0.0
  } else {
    vals[vals.length() - 1]
  }
}

///|
/// 块中位数 / Block median (simplified: middle element).
///
/// 退化安全：空块返回 0.0。
pub fn neighborhood_block_median(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
) -> Double {
  let vals = neighborhood_block_values(raster, block_row, block_col, block_size)
  let n = vals.length()
  if n == 0 {
    0.0
  } else {
    vals[n / 2]
  }
}

///|
/// 通用块统计 / Generic block statistics.
///
/// 退化安全：空块返回 0.0。
pub fn neighborhood_block_statistics(
  raster : RasterGrid,
  block_row : Int32,
  block_col : Int32,
  block_size : Int32,
  stat : BlockStat,
) -> Double {
  match stat {
    BlockMean => neighborhood_block_mean(raster, block_row, block_col, block_size)
    BlockSum => neighborhood_block_sum(raster, block_row, block_col, block_size)
    BlockMin => neighborhood_block_min(raster, block_row, block_col, block_size)
    BlockMax => neighborhood_block_max(raster, block_row, block_col, block_size)
    BlockRange => neighborhood_block_range(raster, block_row, block_col, block_size)
    BlockCount =>
      neighborhood_block_count(raster, block_row, block_col, block_size).to_double()
    BlockStd => neighborhood_block_std(raster, block_row, block_col, block_size)
    BlockMajority => neighborhood_block_majority(raster, block_row, block_col, block_size)
    BlockMinority => neighborhood_block_minority(raster, block_row, block_col, block_size)
    BlockMedian => neighborhood_block_median(raster, block_row, block_col, block_size)
  }
}

///|
/// 块统计栅格 / Block statistics grid: apply block stat to entire raster.
///
/// 将栅格分成 block_size × block_size 的块，每块输出一个统计值。
/// 退化安全：空栅格返回空栅格。
pub fn neighborhood_block_statistics_grid(
  raster : RasterGrid,
  block_size : Int32,
  stat : BlockStat,
) -> RasterGrid {
  let rows = hydrology_raster_rows(raster)
  let cols = hydrology_raster_cols(raster)
  if block_size <= 0 || rows == 0 || cols == 0 {
    hydrology_make_raster([])
  } else {
    let n_block_rows = (rows + block_size - 1) / block_size
    let n_block_cols = (cols + block_size - 1) / block_size
    let result : Array[Array[Double]] = []
    for br in 0..<n_block_rows {
      let row : Array[Double] = []
      for bc in 0..<n_block_cols {
        row.push(neighborhood_block_statistics(raster, br, bc, block_size, stat))
      }
      result.push(row)
    }
    hydrology_make_raster(result)
  }
}

// ============================================================
// 线统计 / Line statistics
// ============================================================

///|
/// 沿行收集值 / Collect values along a row (line).
fn neighborhood_line_values_row(
  raster : RasterGrid,
  row : Int32,
) -> Array[Double] {
  let cols = hydrology_raster_cols(raster)
  let result : Array[Double] = []
  for j in 0..<cols {
    result.push(hydrology_raster_get(raster, row, j))
  }
  result
}

///|
/// 沿列收集值 / Collect values along a column (line).
fn neighborhood_line_values_col(
  raster : RasterGrid,
  col : Int32,
) -> Array[Double] {
  let rows = hydrology_raster_rows(raster)
  let result : Array[Double] = []
  for i in 0..<rows {
    result.push(hydrology_raster_get(raster, i, col))
  }
  result
}

///|
/// 线均值 / Line mean along a row.
///
/// 退化安全：空线返回 0.0。
pub fn neighborhood_line_mean(raster : RasterGrid, row : Int32) -> Double {
  let vals = neighborhood_line_values_row(raster, row)
  let n = vals.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for v in vals {
      sum = sum + v
    }
    sum / n.to_double()
  }
}

///|
/// 线求和 / Line sum along a row.
pub fn neighborhood_line_sum(raster : RasterGrid, row : Int32) -> Double {
  let vals = neighborhood_line_values_row(raster, row)
  let mut sum = 0.0
  for v in vals {
    sum = sum + v
  }
  sum
}

///|
/// 线最小值 / Line min along a row.
///
/// 退化安全：空线返回 0.0。
pub fn neighborhood_line_min(raster : RasterGrid, row : Int32) -> Double {
  let vals = neighborhood_line_values_row(raster, row)
  if vals.length() == 0 {
    0.0
  } else {
    let mut m = vals[0]
    for i in 1..<vals.length() {
      if vals[i] < m {
        m = vals[i]
      }
    }
    m
  }
}

///|
/// 线最大值 / Line max along a row.
///
/// 退化安全：空线返回 0.0。
pub fn neighborhood_line_max(raster : RasterGrid, row : Int32) -> Double {
  let vals = neighborhood_line_values_row(raster, row)
  if vals.length() == 0 {
    0.0
  } else {
    let mut m = vals[0]
    for i in 1..<vals.length() {
      if vals[i] > m {
        m = vals[i]
      }
    }
    m
  }
}

///|
/// 线计数 / Line count along a row.
pub fn neighborhood_line_count(raster : RasterGrid, row : Int32) -> Int32 {
  neighborhood_line_values_row(raster, row).length()
}

///|
/// 线极差 / Line range along a row.
pub fn neighborhood_line_range(raster : RasterGrid, row : Int32) -> Double {
  neighborhood_line_max(raster, row) - neighborhood_line_min(raster, row)
}

///|
/// 线标准差 / Line standard deviation along a row.
///
/// 退化安全：空线返回 0.0。
pub fn neighborhood_line_std(raster : RasterGrid, row : Int32) -> Double {
  let vals = neighborhood_line_values_row(raster, row)
  let n = vals.length()
  if n <= 1 {
    0.0
  } else {
    let mean = neighborhood_line_mean(raster, row)
    let mut sum_sq = 0.0
    for v in vals {
      let diff = v - mean
      sum_sq = sum_sq + diff * diff
    }
    (sum_sq / n.to_double()).sqrt()
  }
}

///|
/// 通用线统计 / Generic line statistics along a row.
///
/// 退化安全：空线返回 0.0。
pub fn neighborhood_line_statistics(
  raster : RasterGrid,
  row : Int32,
  stat : LineStat,
) -> Double {
  match stat {
    LineMean => neighborhood_line_mean(raster, row)
    LineSum => neighborhood_line_sum(raster, row)
    LineMin => neighborhood_line_min(raster, row)
    LineMax => neighborhood_line_max(raster, row)
    LineCount => neighborhood_line_count(raster, row).to_double()
    LineRange => neighborhood_line_range(raster, row)
    LineStd => neighborhood_line_std(raster, row)
  }
}

///|
/// 线统计（列方向）/ Line statistics along a column.
///
/// 退化安全：空线返回 0.0。
pub fn neighborhood_line_statistics_col(
  raster : RasterGrid,
  col : Int32,
  stat : LineStat,
) -> Double {
  let vals = neighborhood_line_values_col(raster, col)
  let n = vals.length()
  if n == 0 {
    0.0
  } else {
    match stat {
      LineMean => {
        let mut sum = 0.0
        for v in vals {
          sum = sum + v
        }
        sum / n.to_double()
      }
      LineSum => {
        let mut sum = 0.0
        for v in vals {
          sum = sum + v
        }
        sum
      }
      LineMin => {
        let mut m = vals[0]
        for i in 1..<n {
          if vals[i] < m {
            m = vals[i]
          }
        }
        m
      }
      LineMax => {
        let mut m = vals[0]
        for i in 1..<n {
          if vals[i] > m {
            m = vals[i]
          }
        }
        m
      }
      LineCount => n.to_double()
      LineRange => {
        let mut mn = vals[0]
        let mut mx = vals[0]
        for i in 1..<n {
          if vals[i] < mn {
            mn = vals[i]
          }
          if vals[i] > mx {
            mx = vals[i]
          }
        }
        mx - mn
      }
      LineStd =>
        if n <= 1 {
          0.0
        } else {
          let mut sum = 0.0
          for v in vals {
            sum = sum + v
          }
          let mean = sum / n.to_double()
          let mut sum_sq = 0.0
          for v in vals {
            let diff = v - mean
            sum_sq = sum_sq + diff * diff
          }
          (sum_sq / n.to_double()).sqrt()
        }
    }
  }
}

// ============================================================
// 邻域单元列表 / Neighborhood cell list
// ============================================================

///|
/// 邻域单元列表 / List of neighborhood cell offsets.
///
/// 返回邻域内的相对偏移量列表。
/// 退化安全：radius <= 0 返回 [(0, 0)]。
pub fn neighborhood_neighborhood_cells(config : NeighborhoodConfig) -> Array[(Int32, Int32)] {
  let r1 = config.radius1
  let r2 = config.radius2
  if r1 <= 0 {
    [(0, 0)]
  } else {
    match config.kind {
      NHRectangle => {
        let result : Array[(Int32, Int32)] = []
        let r_start = -r1
        let r_end = r1 + 1
        for di in r_start..<r_end {
          for dj in r_start..<r_end {
            result.push((di, dj))
          }
        }
        result
      }
      NHCircle => {
        let result : Array[(Int32, Int32)] = []
        let r_start = -r1
        let r_end = r1 + 1
        for di in r_start..<r_end {
          for dj in r_start..<r_end {
            if di * di + dj * dj <= r1 * r1 {
              result.push((di, dj))
            }
          }
        }
        result
      }
      NHAnnulus => {
        let inner = if r2 > 0 { r2 } else { 0 }
        let result : Array[(Int32, Int32)] = []
        let r_start = -r1
        let r_end = r1 + 1
        for di in r_start..<r_end {
          for dj in r_start..<r_end {
            let d2 = di * di + dj * dj
            if d2 <= r1 * r1 && d2 >= inner * inner {
              result.push((di, dj))
            }
          }
        }
        result
      }
      NHWedge => {
        let result : Array[(Int32, Int32)] = []
        let r_start = -r1
        let r_end = r1 + 1
        for di in r_start..<r_end {
          for dj in r_start..<r_end {
            if di <= 0 && dj >= 0 {
              result.push((di, dj))
            }
          }
        }
        result
      }
      NHRing => {
        let result : Array[(Int32, Int32)] = []
        let r_start = -r1
        let r_end = r1 + 1
        for di in r_start..<r_end {
          for dj in r_start..<r_end {
            let d2 = di * di + dj * dj
            if d2 == r1 * r1 {
              result.push((di, dj))
            }
          }
        }
        result
      }
    }
  }
}

///|
/// 邻域单元数 / Neighborhood cell count.
pub fn neighborhood_neighborhood_cell_count(config : NeighborhoodConfig) -> Int32 {
  neighborhood_neighborhood_cells(config).length()
}

///|
/// 邻域展开 / Neighborhood expand: apply neighborhood to a cell, collect values.
///
/// 退化安全：越界单元格跳过。
pub fn neighborhood_neighborhood_expand(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  config : NeighborhoodConfig,
) -> Array[Double] {
  let rows = hydrology_raster_rows(raster)
  let cols = hydrology_raster_cols(raster)
  let cells = neighborhood_neighborhood_cells(config)
  let result : Array[Double] = []
  for (di, dj) in cells {
    let r = row + di
    let c = col + dj
    if r >= 0 && r < rows && c >= 0 && c < cols {
      result.push(hydrology_raster_get(raster, r, c))
    }
  }
  result
}

///|
/// 块统计结果列表 / Block results list.
///
/// 退化安全：空栅格返回空数组。
pub fn neighborhood_block_results_grid(
  raster : RasterGrid,
  block_size : Int32,
  stat : BlockStat,
) -> Array[Array[BlockResult]] {
  let rows = hydrology_raster_rows(raster)
  let cols = hydrology_raster_cols(raster)
  if block_size <= 0 || rows == 0 || cols == 0 {
    []
  } else {
    let n_block_rows = (rows + block_size - 1) / block_size
    let n_block_cols = (cols + block_size - 1) / block_size
    let result : Array[Array[BlockResult]] = []
    for br in 0..<n_block_rows {
      let row : Array[BlockResult] = []
      for bc in 0..<n_block_cols {
        row.push(
          neighborhood_make_block_result(
            neighborhood_block_statistics(raster, br, bc, block_size, stat),
            br,
            bc,
          ),
        )
      }
      result.push(row)
    }
    result
  }
}
