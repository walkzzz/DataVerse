///|
/// # opcore/surface 表面分析 / Surface Analysis
///
/// Slope / Aspect / Hillshade / Contour / Curvature / Viewshed。
/// 对标 ArcGIS Pro 表面分析工具集（15 工具）。
/// S4.4 填充：Horn's method 坡度/坡向 + 模拟实现。
///
/// # Surface analysis
///
/// Slope / Aspect / Hillshade / Contour. Aligned with ArcGIS Pro Surface toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 坡向方向 / Aspect direction.
pub(all) enum AspectDirection {
  Flat    // 平坦
  North   // 北
  Northeast
  East
  Southeast
  South
  Southwest
  West
  Northwest
} derive(Debug, Eq)

pub extend AspectDirection with Eq::{equal, not_equal}
pub extend AspectDirection with Debug::{to_repr}

/// 等高线 / Contour line.
pub struct ContourLine {
  elevation : Double
  points : Array[(Int, Int)]
} derive(Debug, Eq)

pub extend ContourLine with Eq::{equal, not_equal}
pub extend ContourLine with Debug::{to_repr}

/// 表面结果 / Surface result: 通用结果容器。
pub struct SurfaceResult {
  kind : String
  value : Double
  row : Int
  col : Int
} derive(Debug, Eq)

pub extend SurfaceResult with Eq::{equal, not_equal}
pub extend SurfaceResult with Debug::{to_repr}

/// 构造表面结果 / Build a surface result.
pub fn make_surface_result(kind : String, value : Double, row : Int, col : Int) -> SurfaceResult {
  { kind, value, row, col, }
}

/// 坡度结果 / Slope as surface result.
pub fn slope_result(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> SurfaceResult {
  make_surface_result("slope", surface_slope(raster, row, col, cell_size), row, col)
}

/// 坡向结果 / Aspect as surface result.
pub fn aspect_result(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> SurfaceResult {
  make_surface_result("aspect", surface_aspect(raster, row, col, cell_size), row, col)
}

// ============================================================
// Horn's method 核心算子 / Horn's method core
// ============================================================

/// Horn's method dz/dx / Partial derivative in x direction.
///
/// 3x3 窗口: a b c / d e f / g h i
/// 公式：`((c + 2f + i) - (a + 2d + g)) / (8 * cell_size)`
fn horn_dz_dx(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> Double {
  let a = @hydrology.raster_get(raster, row - 1, col - 1)
  let c = @hydrology.raster_get(raster, row - 1, col + 1)
  let d = @hydrology.raster_get(raster, row, col - 1)
  let f = @hydrology.raster_get(raster, row, col + 1)
  let g = @hydrology.raster_get(raster, row + 1, col - 1)
  let i = @hydrology.raster_get(raster, row + 1, col + 1)
  ((c + 2.0 * f + i) - (a + 2.0 * d + g)) / (8.0 * cell_size)
}

/// Horn's method dz/dy / Partial derivative in y direction.
fn horn_dz_dy(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> Double {
  let a = @hydrology.raster_get(raster, row - 1, col - 1)
  let b = @hydrology.raster_get(raster, row - 1, col)
  let c = @hydrology.raster_get(raster, row - 1, col + 1)
  let g = @hydrology.raster_get(raster, row + 1, col - 1)
  let h = @hydrology.raster_get(raster, row + 1, col)
  let i = @hydrology.raster_get(raster, row + 1, col + 1)
  ((g + 2.0 * h + i) - (a + 2.0 * b + c)) / (8.0 * cell_size)
}

// ============================================================
// 坡度 / Slope
// ============================================================

/// 坡度（度）/ Slope in degrees at a cell.
///
/// 对标 ArcGIS Pro Slope。
/// 公式：`atan(sqrt(dz_dx² + dz_dy²)) * 180 / π`。
/// 退化安全：越界返回 0.0。
pub fn surface_slope(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> Double {
  if cell_size <= 0.0 {
    0.0
  } else {
    let dz_dx = horn_dz_dx(raster, row, col, cell_size)
    let dz_dy = horn_dz_dy(raster, row, col, cell_size)
    let slope_rad = (dz_dx * dz_dx + dz_dy * dz_dy).sqrt()
    slope_rad * 180.0 / 3.141592653589793
  }
}

/// 坡度（百分比）/ Slope as percentage.
pub fn surface_slope_percent(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> Double {
  let dz_dx = horn_dz_dx(raster, row, col, cell_size)
  let dz_dy = horn_dz_dy(raster, row, col, cell_size)
  (dz_dx * dz_dx + dz_dy * dz_dy).sqrt() * 100.0
}

/// 坡度栅格 / Slope grid for entire raster.
///
/// 退化安全：空栅格返回空数组。
pub fn surface_slope_grid(raster : @hydrology.RasterGrid, cell_size : Double) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<raster.rows {
    let row : Array[Double] = []
    for j in 0..<raster.cols {
      row.push(surface_slope(raster, i, j, cell_size))
    }
    result.push(row)
  }
  result
}

// ============================================================
// 坡向 / Aspect
// ============================================================

/// 坡向（度）/ Aspect in degrees at a cell.
///
/// 对标 ArcGIS Pro Aspect。
/// 范围：0-360 度，平坦区域返回 -1.0。
/// 退化安全：越界返回 -1.0。
pub fn surface_aspect(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> Double {
  if cell_size <= 0.0 {
    -1.0
  } else {
    let dz_dx = horn_dz_dx(raster, row, col, cell_size)
    let dz_dy = horn_dz_dy(raster, row, col, cell_size)
    if dz_dx == 0.0 && dz_dy == 0.0 {
      -1.0
    } else {
      let aspect_rad = atan2_custom(dz_dy, -dz_dx)
      let mut aspect_deg = aspect_rad * 180.0 / 3.141592653589793
      if aspect_deg < 0.0 {
        aspect_deg = 90.0 - aspect_deg
      } else if aspect_deg > 90.0 {
        aspect_deg = 360.0 - aspect_deg + 90.0
      } else {
        aspect_deg = 90.0 - aspect_deg
      }
      if aspect_deg >= 360.0 {
        aspect_deg - 360.0
      } else if aspect_deg < 0.0 {
        aspect_deg + 360.0
      } else {
        aspect_deg
      }
    }
  }
}

/// 简易 atan2 / Simple atan2 implementation.
fn atan2_custom(y : Double, x : Double) -> Double {
  if x == 0.0 {
    if y > 0.0 {
      1.5707963267948966
    } else if y < 0.0 {
      -1.5707963267948966
    } else {
      0.0
    }
  } else {
    let ratio = y / x
    let atan_ratio = atan_taylor(ratio)
    if x > 0.0 {
      atan_ratio
    } else if y >= 0.0 {
      atan_ratio + 3.141592653589793
    } else {
      atan_ratio - 3.141592653589793
    }
  }
}

/// Taylor 级数 atan / Taylor series atan approximation.
///
/// 对 |x| > 1 使用恒等式 atan(x) = π/2 - atan(1/x)。
fn atan_taylor(x : Double) -> Double {
  if x > 1.0 {
    1.5707963267948966 - atan_taylor(1.0 / x)
  } else if x < -1.0 {
    -1.5707963267948966 - atan_taylor(1.0 / x)
  } else {
    let mut result = 0.0
    let mut term = x
    let x_sq = x * x
    for n in 0..<15 {
      let sign = if n % 2 == 0 { 1.0 } else { -1.0 }
      result = result + sign * term / (2 * n + 1).to_double()
      term = term * x_sq
      if term < 0.0000001 && term > -0.0000001 {
        break
      }
    }
    result
  }
}

/// 坡向方向 / Aspect direction as enum.
pub fn surface_aspect_direction(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> AspectDirection {
  let aspect = surface_aspect(raster, row, col, cell_size)
  if aspect < 0.0 {
    Flat
  } else if aspect >= 337.5 || aspect < 22.5 {
    North
  } else if aspect < 67.5 {
    Northeast
  } else if aspect < 112.5 {
    East
  } else if aspect < 157.5 {
    Southeast
  } else if aspect < 202.5 {
    South
  } else if aspect < 247.5 {
    Southwest
  } else if aspect < 292.5 {
    West
  } else {
    Northwest
  }
}

/// 坡向栅格 / Aspect grid for entire raster.
pub fn surface_aspect_grid(raster : @hydrology.RasterGrid, cell_size : Double) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<raster.rows {
    let row : Array[Double] = []
    for j in 0..<raster.cols {
      row.push(surface_aspect(raster, i, j, cell_size))
    }
    result.push(row)
  }
  result
}

// ============================================================
// 山体阴影 / Hillshade
// ============================================================

/// 山体阴影 / Hillshade value (0-255) at a cell.
///
/// 对标 ArcGIS Pro Hillshade。
/// 参数：azimuth（光源方位角，度）、altitude（光源高度角，度）。
/// 退化安全：越界返回 0。
pub fn surface_hillshade(
  raster : @hydrology.RasterGrid,
  row : Int,
  col : Int,
  cell_size : Double,
  azimuth : Double,
  altitude : Double
) -> Int {
  if cell_size <= 0.0 {
    0
  } else {
    let dz_dx = horn_dz_dx(raster, row, col, cell_size)
    let dz_dy = horn_dz_dy(raster, row, col, cell_size)
    let zenith_rad = (90.0 - altitude) * 3.141592653589793 / 180.0
    let azimuth_rad = (360.0 - azimuth + 90.0) * 3.141592653589793 / 180.0
    let slope_rad = (dz_dx * dz_dx + dz_dy * dz_dy).sqrt()
    let aspect_rad = if dz_dx == 0.0 && dz_dy == 0.0 {
      0.0
    } else {
      atan2_custom(dz_dy, -dz_dx)
    }
    let shade = (cos_custom(zenith_rad) * cos_custom(slope_rad) + sin_custom(zenith_rad) * sin_custom(slope_rad) * cos_custom(azimuth_rad - aspect_rad)) * 254.0 + 1.0
    let clamped = if shade < 0.0 { 0.0 } else if shade > 255.0 { 255.0 } else { shade }
    clamped.to_int()
  }
}

/// 山体阴影栅格 / Hillshade grid for entire raster.
pub fn surface_hillshade_grid(
  raster : @hydrology.RasterGrid,
  cell_size : Double,
  azimuth : Double,
  altitude : Double
) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<raster.rows {
    let row : Array[Int] = []
    for j in 0..<raster.cols {
      row.push(surface_hillshade(raster, i, j, cell_size, azimuth, altitude))
    }
    result.push(row)
  }
  result
}

/// 简易 sin / Simple sin via Taylor series.
fn sin_custom(x : Double) -> Double {
  let pi = 3.141592653589793
  let mut val = x
  while val > pi {
    val = val - 2.0 * pi
  }
  while val < -pi {
    val = val + 2.0 * pi
  }
  let mut result = 0.0
  let mut term = val
  let x_sq = val * val
  for n in 0..<10 {
    let sign = if n % 2 == 0 { 1.0 } else { -1.0 }
    result = result + sign * term
    term = term * x_sq / ((2 * n + 2) * (2 * n + 3)).to_double()
  }
  result
}

/// 简易 cos / Simple cos via Taylor series.
fn cos_custom(x : Double) -> Double {
  sin_custom(x + 1.5707963267948966)
}

// ============================================================
// 等高线 / Contour
// ============================================================

/// 等高线生成 / Generate contour lines.
///
/// 对标 ArcGIS Pro Contour。
/// 按给定间距生成等高线，返回每条等高线的高程值和经过的像元。
/// 退化安全：空栅格返回空数组。
pub fn surface_contour(raster : @hydrology.RasterGrid, interval : Double) -> Array[ContourLine] {
  if interval <= 0.0 || raster.rows == 0 || raster.cols == 0 {
    []
  } else {
    let (min_v, max_v, _) = @hydrology.hydrology_stats(raster)
    let contours : Array[ContourLine] = []
    let mut level = min_v
    while level <= max_v {
      let points : Array[(Int, Int)] = []
      for i in 0..<raster.rows {
        for j in 0..<raster.cols {
          let v = raster.data[i][j]
          if v >= level - interval * 0.01 && v <= level + interval * 0.01 {
            points.push((i, j))
          }
        }
      }
      if points.length() > 0 {
        contours.push({ elevation: level, points, })
      }
      level = level + interval
    }
    contours
  }
}

/// 等高线数量 / Count contour lines.
pub fn surface_contour_count(raster : @hydrology.RasterGrid, interval : Double) -> Int {
  surface_contour(raster, interval).length()
}

// ============================================================
// 曲率 / Curvature
// ============================================================

/// 曲率 / Curvature at a cell.
///
/// 对标 ArcGIS Pro Curvature。
/// 公式：`-2 * (d + e + f + h - 4 * center) / (cell_size² * 100)`。
/// 退化安全：越界返回 0.0。
pub fn surface_curvature(raster : @hydrology.RasterGrid, row : Int, col : Int, cell_size : Double) -> Double {
  if cell_size <= 0.0 {
    0.0
  } else {
    let center = @hydrology.raster_get(raster, row, col)
    let d = @hydrology.raster_get(raster, row, col - 1)
    let e = @hydrology.raster_get(raster, row - 1, col)
    let f = @hydrology.raster_get(raster, row, col + 1)
    let h = @hydrology.raster_get(raster, row + 1, col)
    -2.0 * (d + e + f + h - 4.0 * center) / (cell_size * cell_size * 100.0)
  }
}

/// 曲率栅格 / Curvature grid for entire raster.
pub fn surface_curvature_grid(raster : @hydrology.RasterGrid, cell_size : Double) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<raster.rows {
    let row : Array[Double] = []
    for j in 0..<raster.cols {
      row.push(surface_curvature(raster, i, j, cell_size))
    }
    result.push(row)
  }
  result
}

// ============================================================
// 视域分析 / Viewshed
// ============================================================

/// 视域 / Viewshed: 返回从观察点可见的所有像元。
///
/// 对标 ArcGIS Pro Viewshed。
/// 模拟策略：简单视线检查，观察点到目标点之间无遮挡。
/// 退化安全：越界观察点返回空数组。
pub fn surface_viewshed(raster : @hydrology.RasterGrid, obs_row : Int, obs_col : Int, max_distance : Int) -> Array[(Int, Int)] {
  let rows = raster.rows
  let cols = raster.cols
  if obs_row < 0 || obs_row >= rows || obs_col < 0 || obs_col >= cols {
    []
  } else {
    let obs_elev = raster.data[obs_row][obs_col]
    let visible : Array[(Int, Int)] = [(obs_row, obs_col)]
    for i in 0..<rows {
      for j in 0..<cols {
        if i == obs_row && j == obs_col {
          continue
        }
        let dist = ((i - obs_row) * (i - obs_row) + (j - obs_col) * (j - obs_col)).to_double().sqrt().to_int()
        if dist > max_distance {
          continue
        }
        let target_elev = raster.data[i][j]
        let mut blocked = false
        let steps = if dist > 0 { dist } else { 1 }
        for s in 1..<steps {
          let sr = obs_row + (i - obs_row) * s / steps
          let sc = obs_col + (j - obs_col) * s / steps
          if sr >= 0 && sr < rows && sc >= 0 && sc < cols {
            let interp_elev = obs_elev + (target_elev - obs_elev) * s.to_double() / steps.to_double()
            if raster.data[sr][sc] > interp_elev + 0.001 {
              blocked = true
            }
          }
        }
        if !blocked {
          visible.push((i, j))
        }
      }
    }
    visible
  }
}

/// 视域统计 / Viewshed statistics: 返回可见像元数和总像元数。
pub fn surface_viewshed_stats(raster : @hydrology.RasterGrid, obs_row : Int, obs_col : Int, max_distance : Int) -> (Int, Int) {
  let visible = surface_viewshed(raster, obs_row, obs_col, max_distance)
  let total = raster.rows * raster.cols
  (visible.length(), total)
}

// ============================================================
// 汇总 / Summary
// ============================================================

/// 表面统计 / Surface statistics: 返回平均坡度、平均坡向。
///
/// 退化安全：空栅格返回 (0.0, 0.0)。
pub fn surface_stats(raster : @hydrology.RasterGrid, cell_size : Double) -> (Double, Double) {
  if raster.rows == 0 || raster.cols == 0 {
    (0.0, 0.0)
  } else {
    let slope_grid = surface_slope_grid(raster, cell_size)
    let aspect_grid = surface_aspect_grid(raster, cell_size)
    let mut slope_sum = 0.0
    let mut aspect_sum = 0.0
    let mut count = 0
    for i in 0..<raster.rows {
      for j in 0..<raster.cols {
        slope_sum = slope_sum + slope_grid[i][j]
        if aspect_grid[i][j] >= 0.0 {
          aspect_sum = aspect_sum + aspect_grid[i][j]
        }
        count += 1
      }
    }
    let avg_slope = if count > 0 { slope_sum / count.to_double() } else { 0.0 }
    let avg_aspect = if count > 0 { aspect_sum / count.to_double() } else { 0.0 }
    (avg_slope, avg_aspect)
  }
}