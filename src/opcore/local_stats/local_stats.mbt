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

pub extend FocalStat with Eq::{equal, not_equal}
pub extend FocalStat with Debug::{to_repr}

/// 邻域形状 / Neighborhood shape.
pub(all) enum NeighborhoodShape {
  NRectangle
  NCircle
  NAnnulus
  NWedge
} derive(Debug, Eq)

pub extend NeighborhoodShape with Eq::{equal, not_equal}
pub extend NeighborhoodShape with Debug::{to_repr}

/// 邻域统计结果 / Focal result.
pub struct FocalResult {
  value : Double
  row : Int
  col : Int
  stat : FocalStat
} derive(Debug, Eq)

pub extend FocalResult with Eq::{equal, not_equal}
pub extend FocalResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

/// 构造邻域统计结果 / Build a focal result.
pub fn make_focal_result(value : Double, row : Int, col : Int, stat : FocalStat) -> FocalResult {
  { value, row, col, stat, }
}

/// 邻域统计类型名称 / Focal stat name.
pub fn focal_stat_name(s : FocalStat) -> String {
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

/// 邻域形状名称 / Neighborhood shape name.
pub fn neighborhood_shape_name(s : NeighborhoodShape) -> String {
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

/// 收集邻域值 / Collect neighborhood values (rectangle radius r).
fn neighborhood_values(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Array[Double] {
  let rows = @hydrology.raster_rows(raster)
  let cols = @hydrology.raster_cols(raster)
  let result : Array[Double] = []
  let r_start = row - radius
  let r_end = row + radius + 1
  let c_start = col - radius
  let c_end = col + radius + 1
  for i in r_start..<r_end {
    for j in c_start..<c_end {
      if i >= 0 && i < rows && j >= 0 && j < cols {
        result.push(@hydrology.raster_get(raster, i, j))
      }
    }
  }
  result
}

// ============================================================
// 邻域统计 / Focal statistics
// ============================================================

/// 邻域均值 / Focal mean.
///
/// 退化安全：空邻域返回 0.0。
pub fn focal_mean(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  let vals = neighborhood_values(raster, row, col, radius)
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

/// 邻域求和 / Focal sum.
pub fn focal_sum(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  let vals = neighborhood_values(raster, row, col, radius)
  let mut sum = 0.0
  for v in vals {
    sum = sum + v
  }
  sum
}

/// 邻域最小值 / Focal min.
///
/// 退化安全：空邻域返回 0.0。
pub fn focal_min(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  let vals = neighborhood_values(raster, row, col, radius)
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

/// 邻域最大值 / Focal max.
///
/// 退化安全：空邻域返回 0.0。
pub fn focal_max(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  let vals = neighborhood_values(raster, row, col, radius)
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

/// 邻域极差 / Focal range.
pub fn focal_range(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  focal_max(raster, row, col, radius) - focal_min(raster, row, col, radius)
}

/// 邻域标准差 / Focal standard deviation.
///
/// 退化安全：空邻域返回 0.0。
pub fn focal_std(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  let vals = neighborhood_values(raster, row, col, radius)
  let n = vals.length()
  if n <= 1 {
    0.0
  } else {
    let mean = focal_mean(raster, row, col, radius)
    let mut sum_sq = 0.0
    for v in vals {
      let diff = v - mean
      sum_sq = sum_sq + diff * diff
    }
    (sum_sq / n.to_double()).sqrt()
  }
}

/// 邻域计数 / Focal count.
pub fn focal_count(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Int {
  neighborhood_values(raster, row, col, radius).length()
}

/// 邻域众数 / Focal majority (simplified: first value).
///
/// 退化安全：空邻域返回 0.0。
pub fn focal_majority(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  let vals = neighborhood_values(raster, row, col, radius)
  if vals.length() == 0 {
    0.0
  } else {
    vals[0]
  }
}

/// 邻域少数 / Focal minority (simplified: last value).
///
/// 退化安全：空邻域返回 0.0。
pub fn focal_minority(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  let vals = neighborhood_values(raster, row, col, radius)
  if vals.length() == 0 {
    0.0
  } else {
    vals[vals.length() - 1]
  }
}

/// 邻域中位数 / Focal median (simplified: middle element).
///
/// 退化安全：空邻域返回 0.0。
pub fn focal_median(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int) -> Double {
  let vals = neighborhood_values(raster, row, col, radius)
  let n = vals.length()
  if n == 0 {
    0.0
  } else {
    vals[n / 2]
  }
}

/// 通用邻域统计 / Generic focal statistics.
///
/// 退化安全：空邻域返回 0.0。
pub fn focal_statistics(raster : @hydrology.RasterGrid, row : Int, col : Int, radius : Int, stat : FocalStat) -> Double {
  match stat {
    FocalMean => focal_mean(raster, row, col, radius)
    FocalSum => focal_sum(raster, row, col, radius)
    FocalMin => focal_min(raster, row, col, radius)
    FocalMax => focal_max(raster, row, col, radius)
    FocalRange => focal_range(raster, row, col, radius)
    FocalStd => focal_std(raster, row, col, radius)
    FocalCount => focal_count(raster, row, col, radius).to_double()
    FocalMajority => focal_majority(raster, row, col, radius)
    FocalMinority => focal_minority(raster, row, col, radius)
    FocalMedian => focal_median(raster, row, col, radius)
  }
}

// ============================================================
// 邻域滤波 / Focal filter (entire grid)
// ============================================================

/// 邻域滤波 / Focal filter: apply focal stat to entire grid.
///
/// 退化安全：空栅格返回空栅格。
pub fn focal_filter(raster : @hydrology.RasterGrid, radius : Int, stat : FocalStat) -> @hydrology.RasterGrid {
  let rows = @hydrology.raster_rows(raster)
  let cols = @hydrology.raster_cols(raster)
  let result : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      row.push(focal_statistics(raster, i, j, radius, stat))
    }
    result.push(row)
  }
  @hydrology.make_raster(result)
}

/// 邻域均值滤波 / Focal mean filter grid.
pub fn focal_filter_mean(raster : @hydrology.RasterGrid, radius : Int) -> @hydrology.RasterGrid {
  focal_filter(raster, radius, FocalMean)
}

/// 邻域统计结果网格 / Focal results grid.
///
/// 退化安全：空栅格返回空数组。
pub fn focal_results_grid(raster : @hydrology.RasterGrid, radius : Int, stat : FocalStat) -> Array[Array[FocalResult]] {
  let rows = @hydrology.raster_rows(raster)
  let cols = @hydrology.raster_cols(raster)
  let result : Array[Array[FocalResult]] = []
  for i in 0..<rows {
    let row : Array[FocalResult] = []
    for j in 0..<cols {
      row.push(make_focal_result(focal_statistics(raster, i, j, radius, stat), i, j, stat))
    }
    result.push(row)
  }
  result
}

// ============================================================
// 逐单元格运算 / Local operations (cell-by-cell)
// ============================================================

/// 逐单元格加 / Local add: cell-by-cell addition of two rasters.
///
/// 退化安全：尺寸不匹配返回空栅格。
pub fn local_add(a : @hydrology.RasterGrid, b : @hydrology.RasterGrid) -> @hydrology.RasterGrid {
  let rows = @hydrology.raster_rows(a)
  let cols = @hydrology.raster_cols(a)
  let brows = @hydrology.raster_rows(b)
  let bcols = @hydrology.raster_cols(b)
  if rows != brows || cols != bcols {
    @hydrology.make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        row.push(@hydrology.raster_get(a, i, j) + @hydrology.raster_get(b, i, j))
      }
      result.push(row)
    }
    @hydrology.make_raster(result)
  }
}

/// 逐单元格减 / Local subtract.
///
/// 退化安全：尺寸不匹配返回空栅格。
pub fn local_subtract(a : @hydrology.RasterGrid, b : @hydrology.RasterGrid) -> @hydrology.RasterGrid {
  let rows = @hydrology.raster_rows(a)
  let cols = @hydrology.raster_cols(a)
  let brows = @hydrology.raster_rows(b)
  let bcols = @hydrology.raster_cols(b)
  if rows != brows || cols != bcols {
    @hydrology.make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        row.push(@hydrology.raster_get(a, i, j) - @hydrology.raster_get(b, i, j))
      }
      result.push(row)
    }
    @hydrology.make_raster(result)
  }
}

/// 逐单元格乘 / Local multiply.
///
/// 退化安全：尺寸不匹配返回空栅格。
pub fn local_multiply(a : @hydrology.RasterGrid, b : @hydrology.RasterGrid) -> @hydrology.RasterGrid {
  let rows = @hydrology.raster_rows(a)
  let cols = @hydrology.raster_cols(a)
  let brows = @hydrology.raster_rows(b)
  let bcols = @hydrology.raster_cols(b)
  if rows != brows || cols != bcols {
    @hydrology.make_raster([])
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        row.push(@hydrology.raster_get(a, i, j) * @hydrology.raster_get(b, i, j))
      }
      result.push(row)
    }
    @hydrology.make_raster(result)
  }
}

/// 逐单元格标量加 / Local add scalar.
pub fn local_add_scalar(raster : @hydrology.RasterGrid, scalar : Double) -> @hydrology.RasterGrid {
  let rows = @hydrology.raster_rows(raster)
  let cols = @hydrology.raster_cols(raster)
  let result : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      row.push(@hydrology.raster_get(raster, i, j) + scalar)
    }
    result.push(row)
  }
  @hydrology.make_raster(result)
}