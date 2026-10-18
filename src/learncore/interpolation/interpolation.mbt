///|
/// # learncore/interpolation 插值分析 / Interpolation Analysis
///
/// IDW / Kriging / Spline / Natural Neighbor。
/// 对标 ArcGIS Pro 插值分析工具集（7 工具）。
/// S4.7 填充：IDW 权重 + Kriging/Spline 简化模拟。
///
/// # Interpolation analysis
///
/// IDW / Kriging / Spline. Aligned with ArcGIS Pro Interpolation toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 插值方法 / Interpolation method.
pub(all) enum InterpolationMethod {
  IDW             // 反距离加权
  Kriging         // 克里金
  Spline          // 样条
  NaturalNeighbor // 自然邻域
} derive(Debug, Eq)

pub extend InterpolationMethod with Eq::{equal, not_equal}
pub extend InterpolationMethod with Debug::{to_repr}

/// 采样点 / Sample point with value.
pub struct SamplePoint {
  x : Double
  y : Double
  value : Double
} derive(Debug, Eq)

pub extend SamplePoint with Eq::{equal, not_equal}
pub extend SamplePoint with Debug::{to_repr}

/// 插值结果 / Interpolation result.
pub struct InterpolationResult {
  x : Double
  y : Double
  value : Double
  interp_method : InterpolationMethod
} derive(Debug, Eq)

pub extend InterpolationResult with Eq::{equal, not_equal}
pub extend InterpolationResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

/// 构造采样点 / Build a sample point.
pub fn make_sample_point(x : Double, y : Double, value : Double) -> SamplePoint {
  { x, y, value, }
}

/// 构造插值结果 / Build an interpolation result.
pub fn make_interpolation_result(x : Double, y : Double, value : Double, m : InterpolationMethod) -> InterpolationResult {
  { x, y, value, interp_method: m, }
}

/// 插值方法名称 / Interpolation method name.
pub fn interpolation_method_name(m : InterpolationMethod) -> String {
  match m {
    IDW => "idw"
    Kriging => "kriging"
    Spline => "spline"
    NaturalNeighbor => "natural_neighbor"
  }
}

// ============================================================
// 反距离加权 / IDW (Inverse Distance Weighting)
// ============================================================

/// IDW 插值（单点）/ IDW at a point.
///
/// 对标 ArcGIS Pro IDW。
/// 公式：`Σ(v_i / d_i^p) / Σ(1 / d_i^p)`。
/// 退化安全：空采样集返回 0.0；目标与采样点重合返回该采样点值。
pub fn interpolation_idw(samples : Array[SamplePoint], target : @proximity.Point, power : Double) -> Double {
  let n = samples.length()
  if n == 0 {
    0.0
  } else {
    let p = if power <= 0.0 { 2.0 } else { power }
    let mut weighted_sum = 0.0
    let mut weight_total = 0.0
    for s in samples {
      let sp = @proximity.make_point(s.x, s.y)
      let d = @proximity.euclidean_distance(target, sp)
      if d < 0.0000001 {
        return s.value
      }
      let weight = 1.0 / pow_custom(d, p)
      weighted_sum = weighted_sum + s.value * weight
      weight_total = weight_total + weight
    }
    if weight_total > 0.0 {
      weighted_sum / weight_total
    } else {
      0.0
    }
  }
}

/// IDW 插值栅格 / IDW interpolation grid.
///
/// 退化安全：空采样集返回空数组。
pub fn interpolation_idw_grid(
  samples : Array[SamplePoint],
  power : Double,
  cell_size : Double,
  extent : (@proximity.Point, @proximity.Point)
) -> Array[Array[Double]] {
  if cell_size <= 0.0 || samples.length() == 0 {
    []
  } else {
    let (min_p, max_p) = extent
    let cols = ((max_p.x - min_p.x) / cell_size).to_int() + 1
    let rows = ((max_p.y - min_p.y) / cell_size).to_int() + 1
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<cols {
        let cx = min_p.x + j.to_double() * cell_size
        let cy = min_p.y + i.to_double() * cell_size
        row.push(interpolation_idw(samples, @proximity.make_point(cx, cy), power))
      }
      result.push(row)
    }
    result
  }
}

// ============================================================
// 克里金插值 / Kriging (simplified)
// ============================================================

/// 克里金插值（单点，简化）/ Simplified kriging at a point.
///
/// 对标 ArcGIS Pro Kriging。
/// 模拟策略：使用 IDW power=2 作为简化克里金（无变差函数拟合）。
/// 退化安全：空采样集返回 0.0。
pub fn interpolation_kriging(samples : Array[SamplePoint], target : @proximity.Point) -> Double {
  interpolation_idw(samples, target, 2.0)
}

/// 克里金插值栅格 / Kriging interpolation grid.
pub fn interpolation_kriging_grid(
  samples : Array[SamplePoint],
  cell_size : Double,
  extent : (@proximity.Point, @proximity.Point)
) -> Array[Array[Double]] {
  interpolation_idw_grid(samples, 2.0, cell_size, extent)
}

// ============================================================
// 样条插值 / Spline (simplified)
// ============================================================

/// 样条插值（单点，简化）/ Simplified spline at a point.
///
/// 对标 ArcGIS Pro Spline。
/// 模拟策略：使用距离倒数平滑（power=1）作为简化样条。
/// 退化安全：空采样集返回 0.0。
pub fn interpolation_spline(samples : Array[SamplePoint], target : @proximity.Point) -> Double {
  interpolation_idw(samples, target, 1.0)
}

/// 样条插值栅格 / Spline interpolation grid.
pub fn interpolation_spline_grid(
  samples : Array[SamplePoint],
  cell_size : Double,
  extent : (@proximity.Point, @proximity.Point)
) -> Array[Array[Double]] {
  interpolation_idw_grid(samples, 1.0, cell_size, extent)
}

// ============================================================
// 自然邻域插值 / Natural Neighbor (simplified)
// ============================================================

/// 自然邻域插值（单点，简化）/ Simplified natural neighbor at a point.
///
/// 对标 ArcGIS Pro Natural Neighbor。
/// 模拟策略：使用 IDW power=3 模拟（更强调近邻）。
/// 退化安全：空采样集返回 0.0。
pub fn interpolation_natural_neighbor(samples : Array[SamplePoint], target : @proximity.Point) -> Double {
  interpolation_idw(samples, target, 3.0)
}

/// 自然邻域插值栅格 / Natural neighbor interpolation grid.
pub fn interpolation_natural_neighbor_grid(
  samples : Array[SamplePoint],
  cell_size : Double,
  extent : (@proximity.Point, @proximity.Point)
) -> Array[Array[Double]] {
  interpolation_idw_grid(samples, 3.0, cell_size, extent)
}

// ============================================================
// 通用插值接口 / Generic interpolation interface
// ============================================================

/// 通用插值 / Generic interpolation by method.
///
/// 根据 method 选择插值方法。
/// 退化安全：空采样集返回 0.0。
pub fn interpolate(samples : Array[SamplePoint], target : @proximity.Point, m : InterpolationMethod) -> Double {
  match m {
    IDW => interpolation_idw(samples, target, 2.0)
    Kriging => interpolation_kriging(samples, target)
    Spline => interpolation_spline(samples, target)
    NaturalNeighbor => interpolation_natural_neighbor(samples, target)
  }
}

/// 通用插值栅格 / Generic interpolation grid by method.
pub fn interpolate_grid(
  samples : Array[SamplePoint],
  m : InterpolationMethod,
  cell_size : Double,
  extent : (@proximity.Point, @proximity.Point)
) -> Array[Array[Double]] {
  match m {
    IDW => interpolation_idw_grid(samples, 2.0, cell_size, extent)
    Kriging => interpolation_kriging_grid(samples, cell_size, extent)
    Spline => interpolation_spline_grid(samples, cell_size, extent)
    NaturalNeighbor => interpolation_natural_neighbor_grid(samples, cell_size, extent)
  }
}

// ============================================================
// 插值结果列表 / Interpolation results
// ============================================================

/// IDW 插值结果列表 / IDW results at sample locations.
///
/// 退化安全：空采样集返回空数组。
pub fn interpolation_idw_results(samples : Array[SamplePoint], power : Double) -> Array[InterpolationResult] {
  if samples.length() == 0 {
    []
  } else {
    samples.map(fn(s) {
      make_interpolation_result(
        s.x,
        s.y,
        interpolation_idw(samples, @proximity.make_point(s.x, s.y), power),
        IDW
      )
    })
  }
}

/// 插值统计 / Interpolation grid statistics: min/max/avg.
///
/// 退化安全：空栅格返回 (0.0, 0.0, 0.0)。
pub fn interpolation_stats(grid : Array[Array[Double]]) -> (Double, Double, Double) {
  let rows = grid.length()
  if rows == 0 {
    (0.0, 0.0, 0.0)
  } else {
    let mut min_v = grid[0][0]
    let mut max_v = grid[0][0]
    let mut sum = 0.0
    let mut count = 0
    for i in 0..<rows {
      for j in 0..<grid[i].length() {
        let v = grid[i][j]
        if v < min_v {
          min_v = v
        }
        if v > max_v {
          max_v = v
        }
        sum = sum + v
        count += 1
      }
    }
    let avg = if count > 0 { sum / count.to_double() } else { 0.0 }
    (min_v, max_v, avg)
  }
}

// ============================================================
// 辅助函数 / Helper functions
// ============================================================

/// 幂运算 / Power function (positive power only).
fn pow_custom(base : Double, exp : Double) -> Double {
  if exp == 0.0 {
    1.0
  } else if exp == 1.0 {
    base
  } else if exp == 2.0 {
    base * base
  } else if exp == 3.0 {
    base * base * base
  } else {
    let mut result = 1.0
    let n = exp.to_int()
    for _ in 0..<n {
      result = result * base
    }
    result
  }
}