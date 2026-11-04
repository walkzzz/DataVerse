///|
/// # opcore/density 密度分析 / Density Analysis
///
/// Kernel Density / Point Density / Line Density。
/// 对标 ArcGIS Pro 密度分析工具集（8 工具）。
/// S4.5 填充：二次核函数 + 模拟实现。
///
/// # Density analysis
///
/// Kernel / Point / Line Density. Aligned with ArcGIS Pro Density toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 密度方法 / Density method.
pub(all) enum DensityMethod {
  KernelDensity // 核密度
  PointDensity // 点密度
  LineDensity // 线密度
} derive(Debug, Eq)

///|
pub extend DensityMethod with Eq::{equal, not_equal}

///|
pub extend DensityMethod with Debug::{to_repr}

///|
/// 密度结果 / Density result at a location.
pub struct DensityResult {
  x : Double
  y : Double
  value : Double
} derive(Debug, Eq)

///|
pub extend DensityResult with Eq::{equal, not_equal}

///|
pub extend DensityResult with Debug::{to_repr}

// ============================================================
// 核函数 / Kernel function
// ============================================================

///|
/// 二次核函数 / Quadratic kernel function.
///
/// 公式：`k(d) = 3/π * (1 - (d/r)²)²` for d < r, else 0。
/// 退化安全：r <= 0 返回 0.0。
pub fn density_quadratic_kernel(distance : Double, radius : Double) -> Double {
  if radius <= 0.0 || distance >= radius {
    0.0
  } else {
    let ratio = distance / radius
    let factor = 1.0 - ratio * ratio
    3.0 / 3.141592653589793 * factor * factor
  }
}

///|
/// 高斯核函数 / Gaussian kernel function.
///
/// 公式：`k(d) = 1/(r*sqrt(2π)) * exp(-d²/(2r²))`。
pub fn density_gaussian_kernel(distance : Double, radius : Double) -> Double {
  if radius <= 0.0 {
    0.0
  } else {
    let ratio = distance / radius
    density_exp_custom(-0.5 * ratio * ratio) / (radius * 2.5066282746310002)
  }
}

///|
/// 简易 exp / Simple exp via Taylor series.
fn density_exp_custom(x : Double) -> Double {
  let mut result = 1.0
  let mut term = 1.0
  for n in 1..<20 {
    term = term * x / n.to_double()
    result = result + term
    if term < 0.0000001 && term > -0.0000001 {
      break
    }
  }
  result
}

// ============================================================
// 核密度 / Kernel density
// ============================================================

///|
/// 核密度（单点）/ Kernel density at a point.
///
/// 对标 ArcGIS Pro Kernel Density。
/// 公式：`Σ k(d_i) / r²` for all points within radius。
/// 退化安全：空点集返回 0.0。
pub fn density_density_kernel_at(
  points : Array[Point],
  center : Point,
  radius : Double,
) -> Double {
  if radius <= 0.0 || points.length() == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for p in points {
      let d = proximity_euclidean_distance(center, p)
      if d < radius {
        sum = sum + density_quadratic_kernel(d, radius)
      }
    }
    sum / (radius * radius)
  }
}

///|
/// 核密度栅格 / Kernel density grid.
///
/// 在指定范围内按 cell_size 间隔采样。
/// 退化安全：空点集返回空数组。
pub fn density_density_kernel_grid(
  points : Array[Point],
  radius : Double,
  cell_size : Double,
  extent : (Point, Point),
) -> Array[Array[Double]] {
  if cell_size <= 0.0 || radius <= 0.0 || points.length() == 0 {
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
        row.push(
          density_density_kernel_at(points, proximity_make_point(cx, cy), radius),
        )
      }
      result.push(row)
    }
    result
  }
}

// ============================================================
// 点密度 / Point density
// ============================================================

///|
/// 点计数（单点）/ Point count within radius.
///
/// 对标 ArcGIS Pro Point Density。
/// 退化安全：空点集返回 0。
pub fn density_density_point_count_at(
  points : Array[Point],
  center : Point,
  radius : Double,
) -> Int32 {
  if radius <= 0.0 {
    0
  } else {
    let mut count = 0
    for p in points {
      let d = proximity_euclidean_distance(center, p)
      if d <= radius {
        count += 1
      }
    }
    count
  }
}

///|
/// 点密度（单点）/ Point density at a point.
///
/// 公式：`count / (π * r²)`。
pub fn density_density_point_at(
  points : Array[Point],
  center : Point,
  radius : Double,
) -> Double {
  let count = density_density_point_count_at(points, center, radius)
  if radius <= 0.0 {
    0.0
  } else {
    count.to_double() / (3.141592653589793 * radius * radius)
  }
}

///|
/// 点密度栅格 / Point density grid.
pub fn density_density_point_grid(
  points : Array[Point],
  radius : Double,
  cell_size : Double,
  extent : (Point, Point),
) -> Array[Array[Double]] {
  if cell_size <= 0.0 || radius <= 0.0 || points.length() == 0 {
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
        row.push(
          density_density_point_at(points, proximity_make_point(cx, cy), radius),
        )
      }
      result.push(row)
    }
    result
  }
}

// ============================================================
// 线密度 / Line density
// ============================================================

///|
/// 线段长度 / Line segment length.
fn density_segment_length(line : Array[Point]) -> Double {
  let n = line.length()
  if n < 2 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<(n - 1) {
      total = total + proximity_euclidean_distance(line[i], line[i + 1])
    }
    total
  }
}

///|
/// 线密度（单点）/ Line density at a point.
///
/// 对标 ArcGIS Pro Line Density。
/// 公式：`Σ (L_i * k(d_i)) / (π * r²)` for lines within radius。
/// 退化安全：空线集返回 0.0。
pub fn density_density_line_at(
  lines : Array[Array[Point]],
  center : Point,
  radius : Double,
) -> Double {
  if radius <= 0.0 || lines.length() == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for line in lines {
      let line_len = density_segment_length(line)
      if line_len > 0.0 {
        let (min_p, max_p) = proximity_bounding_box(line)
        let center_box = proximity_make_point(center.x, center.y)
        let bbox_dist = density_bbox_point_distance((min_p, max_p), center_box)
        if bbox_dist <= radius {
          sum = sum + line_len
        }
      }
    }
    sum / (3.141592653589793 * radius * radius)
  }
}

///|
/// 包围盒到点的距离 / Bounding box to point distance.
fn density_bbox_point_distance(
  bbox : (Point, Point),
  p : Point,
) -> Double {
  let (min_p, max_p) = bbox
  let dx = if p.x < min_p.x {
    min_p.x - p.x
  } else if p.x > max_p.x {
    p.x - max_p.x
  } else {
    0.0
  }
  let dy = if p.y < min_p.y {
    min_p.y - p.y
  } else if p.y > max_p.y {
    p.y - max_p.y
  } else {
    0.0
  }
  (dx * dx + dy * dy).sqrt()
}

///|
/// 线密度栅格 / Line density grid.
pub fn density_density_line_grid(
  lines : Array[Array[Point]],
  radius : Double,
  cell_size : Double,
  extent : (Point, Point),
) -> Array[Array[Double]] {
  if cell_size <= 0.0 || radius <= 0.0 || lines.length() == 0 {
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
        row.push(density_density_line_at(lines, proximity_make_point(cx, cy), radius))
      }
      result.push(row)
    }
    result
  }
}

// ============================================================
// 密度统计 / Density statistics
// ============================================================

///|
/// 密度栅格统计 / Density grid statistics: min/max/avg.
///
/// 退化安全：空栅格返回 (0.0, 0.0, 0.0)。
pub fn density_density_stats(grid : Array[Array[Double]]) -> (Double, Double, Double) {
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

///|
/// 密度结果构造 / Build a density result.
pub fn density_make_density_result(
  x : Double,
  y : Double,
  value : Double,
) -> DensityResult {
  { x, y, value, }
}

///|
/// 密度结果列表 / Density results at sample points.
///
/// 在点集位置计算核密度，返回结果列表。
/// 退化安全：空点集返回空数组。
pub fn density_density_kernel_results(
  points : Array[Point],
  radius : Double,
) -> Array[DensityResult] {
  if radius <= 0.0 || points.length() == 0 {
    []
  } else {
    points.map(fn(p) {
      density_make_density_result(p.x, p.y, density_density_kernel_at(points, p, radius))
    })
  }
}

///|
/// 密度方法名称 / Density method name.
pub fn density_density_method_name(m : DensityMethod) -> String {
  match m {
    KernelDensity => "kernel"
    PointDensity => "point"
    LineDensity => "line"
  }
}
