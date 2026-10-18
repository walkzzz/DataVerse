///|
/// # learncore/feature 特征工程算子 / Feature Engineering Operators
///
/// 标准化、归一化、编码。架构 §4.3.5 A（降维与特征）。
/// S1.2 基礎：standardize（Z-score）+ normalize_minmax。
///
/// # Feature engineering operators
///
/// Standardization, normalization, encoding. See architecture §4.3.5 A.

/// 标准化（Z-score）：(x - mean) / std / Standardize (Z-score).
///
/// 退化安全：空数组返回空数组；std = 0 返回全 0。
pub fn standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 {
    return []
  }
  let mean = data.fold(init=0.0, fn(acc, x) { acc + x }) / n.to_double()
  let mut variance = 0.0
  for i = 0; i < n; i = i + 1 {
    let d = data[i] - mean
    variance = variance + d * d
  }
  variance = variance / n.to_double()
  let std = variance.sqrt()
  if std < 0.000000000001 {
    return Array::make(n, 0.0)
  }
  data.map(fn(x) { (x - mean) / std })
}

/// Min-Max 归一化：映射到 [0, 1] / Min-Max normalize to [0, 1].
///
/// 退化安全：空数组返回空数组；所有值相同返回全 0。
pub fn normalize_minmax(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 {
    return []
  }
  let mut lo = data[0]
  let mut hi = data[0]
  for i = 1; i < n; i = i + 1 {
    if data[i] < lo {
      lo = data[i]
    }
    if data[i] > hi {
      hi = data[i]
    }
  }
  let range = hi - lo
  if range < 0.000000000001 {
    return Array::make(n, 0.0)
  }
  data.map(fn(x) { (x - lo) / range })
}

pub fn feature_id() -> String {
  "learncore/feature"
}

// ============================================================
// S6.2 度量地理分布 / Measuring Geographic Distributions
// 对标 ArcGIS Pro: Central Feature / Mean Center / Median Center / Standard Distance / Directional Distribution
// ============================================================

/// 中心要素 / Central Feature.
///
/// 对标 ArcGIS Pro Central Feature 工具。
/// 从点集中找到使到所有其他点距离总和最小的点。
/// 退化安全：空点集返回 (0.0, 0.0)。
pub fn feature_central_feature(points : Array[@proximity.Point]) -> (@proximity.Point, Double) {
  let n = points.length()
  if n == 0 {
    (@proximity.make_point(0.0, 0.0), 0.0)
  } else if n == 1 {
    (points[0], 0.0)
  } else {
    let mut best_idx = 0
    let mut best_dist = -1.0
    for i in 0..<n {
      let mut total = 0.0
      for j in 0..<n {
        if i != j {
          total = total + @proximity.euclidean_distance(points[i], points[j])
        }
      }
      if best_dist < 0.0 || total < best_dist {
        best_dist = total
        best_idx = i
      }
    }
    (points[best_idx], best_dist)
  }
}

/// 平均中心 / Mean Center.
///
/// 对标 ArcGIS Pro Mean Center 工具。
/// 计算所有点坐标的算术平均。
/// 退化安全：空点集返回 (0.0, 0.0)。
pub fn feature_mean_center(points : Array[@proximity.Point]) -> @proximity.Point {
  let n = points.length()
  if n == 0 {
    @proximity.make_point(0.0, 0.0)
  } else {
    let mut sum_x = 0.0
    let mut sum_y = 0.0
    for p in points {
      sum_x = sum_x + p.x
      sum_y = sum_y + p.y
    }
    @proximity.make_point(sum_x / n.to_double(), sum_y / n.to_double())
  }
}

/// 中位数中心 / Median Center (simplified).
///
/// 对标 ArcGIS Pro Median Center 工具。
/// 简化策略：分别对 x 和 y 坐标排序取中位数。
/// 退化安全：空点集返回 (0.0, 0.0)。
pub fn feature_median_center(points : Array[@proximity.Point]) -> @proximity.Point {
  let n = points.length()
  if n == 0 {
    @proximity.make_point(0.0, 0.0)
  } else {
    let xs : Array[Double] = []
    let ys : Array[Double] = []
    for p in points {
      xs.push(p.x)
      ys.push(p.y)
    }
    xs.sort()
    ys.sort()
    let mid = n / 2
    if n % 2 == 1 {
      @proximity.make_point(xs[mid], ys[mid])
    } else {
      @proximity.make_point((xs[mid - 1] + xs[mid]) / 2.0, (ys[mid - 1] + ys[mid]) / 2.0)
    }
  }
}

/// 标准距离 / Standard Distance.
///
/// 对标 ArcGIS Pro Standard Distance 工具。
/// 公式：SD = sqrt(Σ((x_i - x_mean)² + (y_i - y_mean)²) / n)
/// 退化安全：空点集返回 0.0。
pub fn feature_standard_distance(points : Array[@proximity.Point]) -> Double {
  let n = points.length()
  if n == 0 {
    0.0
  } else {
    let center = feature_mean_center(points)
    let mut sum_sq = 0.0
    for p in points {
      let dx = p.x - center.x
      let dy = p.y - center.y
      sum_sq = sum_sq + dx * dx + dy * dy
    }
    (sum_sq / n.to_double()).sqrt()
  }
}

/// 方向分布 / Directional Distribution (Standard Deviational Ellipse).
///
/// 对标 ArcGIS Pro Directional Distribution 工具。
/// 返回 (center_x, center_y, major_axis, minor_axis, rotation_angle)。
/// 退化安全：空点集返回 (0, 0, 0, 0, 0)。
pub fn feature_directional_distribution(points : Array[@proximity.Point]) -> (Double, Double, Double, Double, Double) {
  let n = points.length()
  if n == 0 {
    (0.0, 0.0, 0.0, 0.0, 0.0)
  } else {
    let center = feature_mean_center(points)
    let mut sum_dx_sq = 0.0
    let mut sum_dy_sq = 0.0
    let mut sum_dxdy = 0.0
    for p in points {
      let dx = p.x - center.x
      let dy = p.y - center.y
      sum_dx_sq = sum_dx_sq + dx * dx
      sum_dy_sq = sum_dy_sq + dy * dy
      sum_dxdy = sum_dxdy + dx * dy
    }
    let nd = n.to_double()
    let var_x = sum_dx_sq / nd
    let var_y = sum_dy_sq / nd
    let cov_xy = sum_dxdy / nd
    let diff = var_x - var_y
    let sum_var = var_x + var_y
    let sqrt_term = (diff * diff + 4.0 * cov_xy * cov_xy).sqrt()
    let major = ((sum_var + sqrt_term) / 2.0).sqrt()
    let minor = ((sum_var - sqrt_term) / 2.0).sqrt()
    let rotation = if cov_xy == 0.0 && diff >= 0.0 {
      0.0
    } else {
      let angle = atan_custom(2.0 * cov_xy / (diff + sqrt_term))
      angle * 180.0 / 3.14159265358979323846 / 2.0
    }
    (center.x, center.y, major, minor, rotation)
  }
}
fn atan_custom(x : Double) -> Double {
  let pi = 3.14159265358979323846
  let abs_x = if x < 0.0 { -x } else { x }
  let sign = if x < 0.0 { -1.0 } else { 1.0 }
  if abs_x > 1.0 {
    sign * (pi / 2.0 - atan_taylor(1.0 / abs_x))
  } else {
    sign * atan_taylor(abs_x)
  }
}

fn atan_taylor(x : Double) -> Double {
  let mut result = 0.0
  let mut x_pow = x
  for n in 0..<50 {
    let term = x_pow / (2 * n + 1).to_double()
    if n % 2 == 0 {
      result = result + term
    } else {
      result = result - term
    }
    x_pow = x_pow * x * x
    if term < 0.0000001 && term > -0.0000001 {
      break
    }
  }
  result
}
