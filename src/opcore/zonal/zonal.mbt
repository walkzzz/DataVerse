///|
/// # opcore/zonal 区域分析 / Zonal Analysis
///
/// Zonal Statistics / Zonal Geometry。
/// 对标 ArcGIS Pro 区域分析工具集（6 工具）。
/// S4.8 填充：分区统计 + 分区几何。
///
/// # Zonal analysis
///
/// Zonal Statistics / Zonal Geometry. Aligned with ArcGIS Pro Zonal toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 分区统计类型 / Zonal statistic kind.
pub(all) enum ZonalStat {
  ZonalMean
  ZonalSum
  ZonalMin
  ZonalMax
  ZonalRange
  ZonalCount
  ZonalStd
  ZonalMajority
  ZonalMinority
  ZonalMedian
} derive(Debug, Eq)

pub extend ZonalStat with Eq::{equal, not_equal}
pub extend ZonalStat with Debug::{to_repr}

/// 分区统计结果 / Zone statistics result.
pub struct ZoneResult {
  zone_id : Int
  stat_value : Double
  cell_count : Int
} derive(Debug, Eq)

pub extend ZoneResult with Eq::{equal, not_equal}
pub extend ZoneResult with Debug::{to_repr}

/// 分区几何结果 / Zonal geometry result.
pub struct ZonalGeometryResult {
  zone_id : Int
  area : Double
  perimeter : Double
  thickness : Double
  centroid_x : Double
  centroid_y : Double
} derive(Debug, Eq)

pub extend ZonalGeometryResult with Eq::{equal, not_equal}
pub extend ZonalGeometryResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

/// 构造分区统计结果 / Build a zone result.
pub fn make_zone_result(zone_id : Int, stat_value : Double, cell_count : Int) -> ZoneResult {
  { zone_id, stat_value, cell_count, }
}

/// 构造分区几何结果 / Build a zonal geometry result.
pub fn make_zonal_geometry_result(
  zone_id : Int,
  area : Double,
  perimeter : Double,
  thickness : Double,
  cx : Double,
  cy : Double
) -> ZonalGeometryResult {
  { zone_id, area, perimeter, thickness, centroid_x: cx, centroid_y: cy, }
}

/// 分区统计类型名称 / Zonal stat name.
pub fn zonal_stat_name(s : ZonalStat) -> String {
  match s {
    ZonalMean => "mean"
    ZonalSum => "sum"
    ZonalMin => "min"
    ZonalMax => "max"
    ZonalRange => "range"
    ZonalCount => "count"
    ZonalStd => "std"
    ZonalMajority => "majority"
    ZonalMinority => "minority"
    ZonalMedian => "median"
  }
}

// ============================================================
// 分区统计 / Zonal statistics
// ============================================================

/// 收集分区单元格值 / Collect cell values for a zone.
fn zone_values(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Array[Double] {
  let rows = @hydrology.raster_rows(zone_raster)
  let cols = @hydrology.raster_cols(zone_raster)
  let vrows = @hydrology.raster_rows(value_raster)
  let vcols = @hydrology.raster_cols(value_raster)
  let result : Array[Double] = []
  for i in 0..<rows {
    for j in 0..<cols {
      if @hydrology.raster_get(zone_raster, i, j).to_int() == zone_id {
        if i < vrows && j < vcols {
          result.push(@hydrology.raster_get(value_raster, i, j))
        }
      }
    }
  }
  result
}

/// 分区均值 / Zonal mean.
///
/// 退化安全：空分区返回 0.0。
pub fn zonal_mean(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  let vals = zone_values(value_raster, zone_raster, zone_id)
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

/// 分区求和 / Zonal sum.
pub fn zonal_sum(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  let vals = zone_values(value_raster, zone_raster, zone_id)
  let mut sum = 0.0
  for v in vals {
    sum = sum + v
  }
  sum
}

/// 分区最小值 / Zonal min.
///
/// 退化安全：空分区返回 0.0。
pub fn zonal_min(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  let vals = zone_values(value_raster, zone_raster, zone_id)
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

/// 分区最大值 / Zonal max.
///
/// 退化安全：空分区返回 0.0。
pub fn zonal_max(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  let vals = zone_values(value_raster, zone_raster, zone_id)
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

/// 分区极差 / Zonal range (max - min).
pub fn zonal_range(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  zonal_max(value_raster, zone_raster, zone_id) - zonal_min(value_raster, zone_raster, zone_id)
}

/// 分区计数 / Zonal count.
pub fn zonal_count(zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Int {
  let rows = @hydrology.raster_rows(zone_raster)
  let cols = @hydrology.raster_cols(zone_raster)
  let mut count = 0
  for i in 0..<rows {
    for j in 0..<cols {
      if @hydrology.raster_get(zone_raster, i, j).to_int() == zone_id {
        count += 1
      }
    }
  }
  count
}

/// 分区标准差 / Zonal standard deviation.
///
/// 退化安全：空分区返回 0.0。
pub fn zonal_std(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  let vals = zone_values(value_raster, zone_raster, zone_id)
  let n = vals.length()
  if n <= 1 {
    0.0
  } else {
    let mean = zonal_mean(value_raster, zone_raster, zone_id)
    let mut sum_sq = 0.0
    for v in vals {
      let diff = v - mean
      sum_sq = sum_sq + diff * diff
    }
    (sum_sq / n.to_double()).sqrt()
  }
}

/// 分区众数 / Zonal majority (simplified: first value).
///
/// 退化安全：空分区返回 0.0。
pub fn zonal_majority(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  let vals = zone_values(value_raster, zone_raster, zone_id)
  if vals.length() == 0 {
    0.0
  } else {
    vals[0]
  }
}

/// 分区少数 / Zonal minority (simplified: last value).
///
/// 退化安全：空分区返回 0.0。
pub fn zonal_minority(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  let vals = zone_values(value_raster, zone_raster, zone_id)
  if vals.length() == 0 {
    0.0
  } else {
    vals[vals.length() - 1]
  }
}

/// 分区中位数 / Zonal median (simplified: middle element).
///
/// 退化安全：空分区返回 0.0。
pub fn zonal_median(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int) -> Double {
  let vals = zone_values(value_raster, zone_raster, zone_id)
  let n = vals.length()
  if n == 0 {
    0.0
  } else {
    vals[n / 2]
  }
}

/// 通用分区统计 / Generic zonal statistics.
///
/// 退化安全：空分区返回 0.0。
pub fn zonal_statistics(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int, stat : ZonalStat) -> Double {
  match stat {
    ZonalMean => zonal_mean(value_raster, zone_raster, zone_id)
    ZonalSum => zonal_sum(value_raster, zone_raster, zone_id)
    ZonalMin => zonal_min(value_raster, zone_raster, zone_id)
    ZonalMax => zonal_max(value_raster, zone_raster, zone_id)
    ZonalRange => zonal_range(value_raster, zone_raster, zone_id)
    ZonalCount => zonal_count(zone_raster, zone_id).to_double()
    ZonalStd => zonal_std(value_raster, zone_raster, zone_id)
    ZonalMajority => zonal_majority(value_raster, zone_raster, zone_id)
    ZonalMinority => zonal_minority(value_raster, zone_raster, zone_id)
    ZonalMedian => zonal_median(value_raster, zone_raster, zone_id)
  }
}

// ============================================================
// 分区几何 / Zonal geometry
// ============================================================

/// 分区几何 / Zonal geometry: area, perimeter, thickness, centroid.
///
/// 退化安全：空分区返回 area=0, perimeter=0, thickness=0, centroid=(0,0)。
pub fn zonal_geometry(zone_raster : @hydrology.RasterGrid, zone_id : Int, cell_size : Double) -> ZonalGeometryResult {
  let rows = @hydrology.raster_rows(zone_raster)
  let cols = @hydrology.raster_cols(zone_raster)
  let cs = if cell_size <= 0.0 { 1.0 } else { cell_size }
  let mut cell_count = 0
  let mut boundary_count = 0
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  for i in 0..<rows {
    for j in 0..<cols {
      if @hydrology.raster_get(zone_raster, i, j).to_int() == zone_id {
        cell_count += 1
        sum_x = sum_x + (j.to_double() + 0.5) * cs
        sum_y = sum_y + (i.to_double() + 0.5) * cs
        let is_boundary = (i == 0 || @hydrology.raster_get(zone_raster, i - 1, j).to_int() != zone_id) ||
          (i == rows - 1 || @hydrology.raster_get(zone_raster, i + 1, j).to_int() != zone_id) ||
          (j == 0 || @hydrology.raster_get(zone_raster, i, j - 1).to_int() != zone_id) ||
          (j == cols - 1 || @hydrology.raster_get(zone_raster, i, j + 1).to_int() != zone_id)
        if is_boundary {
          boundary_count += 1
        }
      }
    }
  }
  if cell_count == 0 {
    make_zonal_geometry_result(zone_id, 0.0, 0.0, 0.0, 0.0, 0.0)
  } else {
    let area = cell_count.to_double() * cs * cs
    let perimeter = boundary_count.to_double() * cs
    let thickness = if perimeter > 0.0 { area / perimeter } else { 0.0 }
    let cx = sum_x / cell_count.to_double()
    let cy = sum_y / cell_count.to_double()
    make_zonal_geometry_result(zone_id, area, perimeter, thickness, cx, cy)
  }
}

/// 分区面积 / Zonal area.
pub fn zonal_geometry_area(zone_raster : @hydrology.RasterGrid, zone_id : Int, cell_size : Double) -> Double {
  let result = zonal_geometry(zone_raster, zone_id, cell_size)
  result.area
}

/// 分区周长 / Zonal perimeter.
pub fn zonal_geometry_perimeter(zone_raster : @hydrology.RasterGrid, zone_id : Int, cell_size : Double) -> Double {
  let result = zonal_geometry(zone_raster, zone_id, cell_size)
  result.perimeter
}

/// 分区厚度 / Zonal thickness.
pub fn zonal_geometry_thickness(zone_raster : @hydrology.RasterGrid, zone_id : Int, cell_size : Double) -> Double {
  let result = zonal_geometry(zone_raster, zone_id, cell_size)
  result.thickness
}

// ============================================================
// 分区填充 / Zonal fill
// ============================================================

/// 分区填充 / Zonal fill: fill zone cells with a constant value.
///
/// 退化安全：空分区返回原始栅格。
pub fn zonal_fill(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, zone_id : Int, fill_value : Double) -> @hydrology.RasterGrid {
  let rows = @hydrology.raster_rows(value_raster)
  let cols = @hydrology.raster_cols(value_raster)
  let zrows = @hydrology.raster_rows(zone_raster)
  let zcols = @hydrology.raster_cols(zone_raster)
  let result : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      if i < zrows && j < zcols && @hydrology.raster_get(zone_raster, i, j).to_int() == zone_id {
        row.push(fill_value)
      } else {
        row.push(@hydrology.raster_get(value_raster, i, j))
      }
    }
    result.push(row)
  }
  @hydrology.make_raster(result)
}

// ============================================================
// 全分区统计 / All-zone statistics
// ============================================================

/// 全分区统计 / Zonal statistics for all zones.
///
/// 返回每个分区的 ZoneResult。
/// 退化安全：空栅格返回空数组。
pub fn zonal_stats_all(value_raster : @hydrology.RasterGrid, zone_raster : @hydrology.RasterGrid, stat : ZonalStat) -> Array[ZoneResult] {
  let rows = @hydrology.raster_rows(zone_raster)
  let cols = @hydrology.raster_cols(zone_raster)
  let zone_set : Array[Int] = []
  for i in 0..<rows {
    for j in 0..<cols {
      let z = @hydrology.raster_get(zone_raster, i, j).to_int()
      let mut found = false
      for existing in zone_set {
        if existing == z {
          found = true
        }
      }
      if !found {
        zone_set.push(z)
      }
    }
  }
  let results : Array[ZoneResult] = []
  for z in zone_set {
    let stat_val = zonal_statistics(value_raster, zone_raster, z, stat)
    let count = zonal_count(zone_raster, z)
    results.push(make_zone_result(z, stat_val, count))
  }
  results
}