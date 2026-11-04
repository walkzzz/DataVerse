///|
/// # opcore/local_stats 局部分析 / Local & Focal Statistics
///
/// Local Statistics / Focal Statistics。
/// 对标 ArcGIS Pro 局部分析工具集（10 工具）。
/// S4.8 填充：邻域统计 + 逐单元格运算。
///
/// # Local and focal statistics
///
/// Local Statistics / Focal Statistics. Aligned with ArcGIS Pro Local toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 邻域统计类型 / Focal statistic kind.
pub(all) enum FocalStat {
  FocalMean
  FocalSum
  FocalMin
  FocalMax
  FocalRange
  FocalStd
  FocalCount
  FocalMajority
  FocalMinority
  FocalMedian
} derive(Debug, Eq)

///|
pub extend FocalStat with Eq::{equal, not_equal}

///|
pub extend FocalStat with Debug::{to_repr}

///|
/// 邻域形状 / Neighborhood shape.
pub(all) enum NeighborhoodShape {
  NRectangle
  NCircle
  NAnnulus
  NWedge
} derive(Debug, Eq)

///|
pub extend NeighborhoodShape with Eq::{equal, not_equal}

///|
pub extend NeighborhoodShape with Debug::{to_repr}

///|
/// 邻域统计结果 / Focal result.
pub struct FocalResult {
  value : Double
  row : Int32
  col : Int32
  stat : FocalStat
} derive(Debug, Eq)

///|
pub extend FocalResult with Eq::{equal, not_equal}

///|
pub extend FocalResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

///|
/// 构造邻域统计结果 / Build a focal result.
pub fn local_stats_make_focal_result(
  value : Double,
  row : Int32,
  col : Int32,
  stat : FocalStat,
) -> FocalResult {
  { value, row, col, stat, }
}

///|
/// 邻域统计类型名称 / Focal stat name.
pub fn local_stats_focal_stat_name(s : FocalStat) -> String {
  match s {
    FocalMean => "mean"
    FocalSum => "sum"
    FocalMin => "min"
    FocalMax => "max"
    FocalRange => "range"
    FocalStd => "std"
    FocalCount => "count"
    FocalMajority => "majority"
    FocalMinority => "minority"
    FocalMedian => "median"
  }
}

///|
/// 邻域形状名称 / Neighborhood shape name.
pub fn local_stats_neighborhood_shape_name(s : NeighborhoodShape) -> String {
  match s {
    NRectangle => "rectangle"
    NCircle => "circle"
    NAnnulus => "annulus"
    NWedge => "wedge"
  }
}

// ============================================================
// 邻域窗口 / Neighborhood window
// ============================================================

///|
/// 收集邻域值 / Collect neighborhood values (rectangle radius r).
fn local_stats_neighborhood_values(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Array[Double] {
  let rows = hydrology_raster_rows(raster)
  let cols = hydrology_raster_cols(raster)
  let result : Array[Double] = []
  let r_start = row - radius
  let r_end = row + radius + 1
  let c_start = col - radius
  let c_end = col + radius + 1
  for i in r_start..<r_end {
    for j in c_start..<c_end {
      if i >= 0 && i < rows && j >= 0 && j < cols {
        result.push(hydrology_raster_get(raster, i, j))
      }
    }
  }
  result
}

// ============================================================
// 邻域统计 / Focal statistics
// ============================================================

///|
/// 邻域均值 / Focal mean.
///
/// 退化安全：空邻域返回 0.0。
pub fn local_stats_focal_mean(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  let vals = local_stats_neighborhood_values(raster, row, col, radius)
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
/// 邻域求和 / Focal sum.
pub fn local_stats_focal_sum(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  let vals = local_stats_neighborhood_values(raster, row, col, radius)
  let mut sum = 0.0
  for v in vals {
    sum = sum + v
  }
  sum
}

///|
/// 邻域最小值 / Focal min.
///
/// 退化安全：空邻域返回 0.0。
pub fn local_stats_focal_min(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  let vals = local_stats_neighborhood_values(raster, row, col, radius)
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
/// 邻域最大值 / Focal max.
///
/// 退化安全：空邻域返回 0.0。
pub fn local_stats_focal_max(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  let vals = local_stats_neighborhood_values(raster, row, col, radius)
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
/// 邻域极差 / Focal range.
pub fn local_stats_focal_range(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  local_stats_focal_max(raster, row, col, radius) - local_stats_focal_min(raster, row, col, radius)
}

///|
/// 邻域标准差 / Focal standard deviation.
///
/// 退化安全：空邻域返回 0.0。
pub fn local_stats_focal_std(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  let vals = local_stats_neighborhood_values(raster, row, col, radius)
  let n = vals.length()
  if n <= 1 {
    0.0
  } else {
    let mean = local_stats_focal_mean(raster, row, col, radius)
    let mut sum_sq = 0.0
    for v in vals {
      let diff = v - mean
      sum_sq = sum_sq + diff * diff
    }
    (sum_sq / n.to_double()).sqrt()
  }
}

///|
/// 邻域计数 / Focal count.
pub fn local_stats_focal_count(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Int32 {
  local_stats_neighborhood_values(raster, row, col, radius).length()
}

///|
/// 邻域众数 / Focal majority (simplified: first value).
///
/// 退化安全：空邻域返回 0.0。
pub fn local_stats_focal_majority(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  let vals = local_stats_neighborhood_values(raster, row, col, radius)
  if vals.length() == 0 {
    0.0
  } else {
    vals[0]
  }
}

///|
/// 邻域少数 / Focal minority (simplified: last value).
///
/// 退化安全：空邻域返回 0.0。
pub fn local_stats_focal_minority(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  let vals = local_stats_neighborhood_values(raster, row, col, radius)
  if vals.length() == 0 {
    0.0
  } else {
    vals[vals.length() - 1]
  }
}

///|
/// 邻域中位数 / Focal median (simplified: middle element).
///
/// 退化安全：空邻域返回 0.0。
pub fn local_stats_focal_median(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
) -> Double {
  let vals = local_stats_neighborhood_values(raster, row, col, radius)
  let n = vals.length()
  if n == 0 {
    0.0
  } else {
    vals[n / 2]
  }
}

///|
/// 通用邻域统计 / Generic focal statistics.
///
/// 退化安全：空邻域返回 0.0。
pub fn local_stats_focal_statistics(
  raster : RasterGrid,
  row : Int32,
  col : Int32,
  radius : Int32,
  stat : FocalStat,
) -> Double {
  match stat {
    FocalMean => local_stats_focal_mean(raster, row, col, radius)
    FocalSum => local_stats_focal_sum(raster, row, col, radius)
    FocalMin => local_stats_focal_min(raster, row, col, radius)
    FocalMax => local_stats_focal_max(raster, row, col, radius)
    FocalRange => local_stats_focal_range(raster, row, col, radius)
    FocalStd => local_stats_focal_std(raster, row, col, radius)
    FocalCount => local_stats_focal_count(raster, row, col, radius).to_double()
    FocalMajority => local_stats_focal_majority(raster, row, col, radius)
    FocalMinority => local_stats_focal_minority(raster, row, col, radius)
    FocalMedian => local_stats_focal_median(raster, row, col, radius)
  }
}

// ============================================================
// 邻域滤波 / Focal filter (entire grid)
// ============================================================

///|
/// 邻域滤波 / Focal filter: apply focal stat to entire grid.
///
/// 退化安全：空栅格返回空栅格。
pub fn local_stats_focal_filter(
  raster : RasterGrid,
  radius : Int32,
  stat : FocalStat,
) -> RasterGrid {
  let rows = hydrology_raster_rows(raster)
  let cols = hydrology_raster_cols(raster)
  let result : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      row.push(local_stats_focal_statistics(raster, i, j, radius, stat))
    }
    result.push(row)
  }
  hydrology_make_raster(result)
}

///|
/// 邻域均值滤波 / Focal mean filter grid.
pub fn local_stats_focal_filter_mean(
  raster : RasterGrid,
  radius : Int32,
) -> RasterGrid {
  local_stats_focal_filter(raster, radius, FocalMean)
}

///|
/// 邻域统计结果网格 / Focal results grid.
///
/// 退化安全：空栅格返回空数组。
pub fn local_stats_focal_results_grid(
  raster : RasterGrid,
  radius : Int32,
  stat : FocalStat,
) -> Array[Array[FocalResult]] {
  let rows = hydrology_raster_rows(raster)
  let cols = hydrology_raster_cols(raster)
  let result : Array[Array[FocalResult]] = []
  for i in 0..<rows {
    let row : Array[FocalResult] = []
    for j in 0..<cols {
      row.push(
        local_stats_make_focal_result(
          local_stats_focal_statistics(raster, i, j, radius, stat),
          i,
          j,
          stat,
        ),
      )
    }
    result.push(row)
  }
  result
}

// ============================================================
// 逐单元格运算 / Local operations (cell-by-cell)
// ============================================================

///|
/// 逐单元格加 / Local add: cell-by-cell addition of two rasters.
///
/// 退化安全：尺寸不匹配返回空栅格。
pub fn local_stats_local_add(
  a : RasterGrid,
  b : RasterGrid,
) -> RasterGrid {
  let rows = hydrology_raster_rows(a)
  let cols = hydrology_raster_cols(a)
  let brows = hydrology_raster_rows(b)
  let bcols = hydrology_raster_cols(b)
  if rows != brows || cols != bcols {
    hydrology_make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        row.push(
          hydrology_raster_get(a, i, j) + hydrology_raster_get(b, i, j),
        )
      }
      result.push(row)
    }
    hydrology_make_raster(result)
  }
}

///|
/// 逐单元格减 / Local subtract.
///
/// 退化安全：尺寸不匹配返回空栅格。
pub fn local_stats_local_subtract(
  a : RasterGrid,
  b : RasterGrid,
) -> RasterGrid {
  let rows = hydrology_raster_rows(a)
  let cols = hydrology_raster_cols(a)
  let brows = hydrology_raster_rows(b)
  let bcols = hydrology_raster_cols(b)
  if rows != brows || cols != bcols {
    hydrology_make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        row.push(
          hydrology_raster_get(a, i, j) - hydrology_raster_get(b, i, j),
        )
      }
      result.push(row)
    }
    hydrology_make_raster(result)
  }
}

///|
/// 逐单元格乘 / Local multiply.
///
/// 退化安全：尺寸不匹配返回空栅格。
pub fn local_stats_local_multiply(
  a : RasterGrid,
  b : RasterGrid,
) -> RasterGrid {
  let rows = hydrology_raster_rows(a)
  let cols = hydrology_raster_cols(a)
  let brows = hydrology_raster_rows(b)
  let bcols = hydrology_raster_cols(b)
  if rows != brows || cols != bcols {
    hydrology_make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        row.push(
          hydrology_raster_get(a, i, j) * hydrology_raster_get(b, i, j),
        )
      }
      result.push(row)
    }
    hydrology_make_raster(result)
  }
}

///|
/// 逐单元格标量加 / Local add scalar.
pub fn local_stats_local_add_scalar(
  raster : RasterGrid,
  scalar : Double,
) -> RasterGrid {
  let rows = hydrology_raster_rows(raster)
  let cols = hydrology_raster_cols(raster)
  let result : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      row.push(hydrology_raster_get(raster, i, j) + scalar)
    }
    result.push(row)
  }
  hydrology_make_raster(result)
}
