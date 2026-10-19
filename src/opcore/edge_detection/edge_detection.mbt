///|
/// # opcore/edge_detection 边缘检测算子 / Edge Detection Operators
///
/// 边缘检测算法集合：Sobel/Prewitt/Roberts/Laplacian/Canny/Marr-Hildreth/DoG/相位一致性等。
/// 纯 MoonBit 实现，无外部依赖。

/// 边缘图像 / Edge image (grayscale, Double data).
pub struct EdgeImage {
  width : Int
  height : Int
  data : Array[Double]
} derive(Debug, Eq)

pub extend EdgeImage with Eq::{equal, not_equal}
pub extend EdgeImage with Debug::{to_repr}

/// 边缘配置 / Edge config.
pub struct EdgeConfig {
  method : Int
  low_threshold : Double
  high_threshold : Double
  sigma : Double
  kernel_size : Int
} derive(Debug, Eq)

pub extend EdgeConfig with Eq::{equal, not_equal}
pub extend EdgeConfig with Debug::{to_repr}

fn edge_sqrt(x : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let mut guess = x
  if guess > 1.0 {
    guess = guess / 2.0
  }
  let mut prev = 0.0
  let mut iter = 0
  while (guess - prev).abs() > 0.0000001 && iter < 60 {
    prev = guess
    guess = (guess + x / guess) / 2.0
    iter = iter + 1
  }
  guess
}

fn edge_exp(x : Double) -> Double {
  if x > 50.0 {
    return 5184705528587072.0
  }
  if x < -50.0 {
    return 0.0
  }
  let mut term = 1.0
  let mut sum = 1.0
  for n in 1..<30 {
    term = term * x / n.to_double()
    sum = sum + term
  }
  sum
}

fn edge_atan2(y : Double, x : Double) -> Double {
  let pi = 3.141592653589793
  if x > 0.0 {
    return edge_atan(y / x)
  }
  if x < 0.0 && y >= 0.0 {
    return edge_atan(y / x) + pi
  }
  if x < 0.0 && y < 0.0 {
    return edge_atan(y / x) - pi
  }
  if x == 0.0 && y > 0.0 {
    return pi / 2.0
  }
  if x == 0.0 && y < 0.0 {
    return -pi / 2.0
  }
  0.0
}

fn edge_atan(x : Double) -> Double {
  let mut result = 0.0
  let mut term = x
  let x2 = x * x
  for n in 0..<30 {
    let denom = (2 * n + 1).to_double()
    if n % 2 == 0 {
      result = result + term / denom
    } else {
      result = result - term / denom
    }
    term = term * x2
    if term < 0.0000001 && term > -0.0000001 {
      break
    }
  }
  result
}

fn edge_abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

fn edge_max(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

fn edge_min(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

fn edge_clamp(v : Double, lo : Double, hi : Double) -> Double {
  if v < lo {
    lo
  } else if v > hi {
    hi
  } else {
    v
  }
}

fn edge_empty(w : Int, h : Int) -> EdgeImage {
  let n = w * h
  let data : Array[Double] = []
  for _ in 0..<n {
    data.push(0.0)
  }
  { width: w, height: h, data }
}

fn edge_pixel(img : EdgeImage, x : Int, y : Int) -> Double {
  if x < 0 || x >= img.width || y < 0 || y >= img.height {
    return 0.0
  }
  let idx = y * img.width + x
  if idx < 0 || idx >= img.data.length() {
    return 0.0
  }
  img.data[idx]
}

fn edge_set_pixel(img : EdgeImage, x : Int, y : Int, v : Double) -> Unit {
  if x < 0 || x >= img.width || y < 0 || y >= img.height {
    return
  }
  let idx = y * img.width + x
  if idx >= 0 && idx < img.data.length() {
    img.data[idx] = v
  }
}

/// 构造边缘图像 / Build edge image.
pub fn make_edge_image(width : Int, height : Int, data : Array[Double]) -> EdgeImage {
  { width, height, data }
}

/// 空边缘图像 / Empty edge image.
pub fn edge_empty_image(width : Int, height : Int) -> EdgeImage {
  edge_empty(width, height)
}

/// 克隆边缘图像 / Clone edge image.
pub fn edge_clone(img : EdgeImage) -> EdgeImage {
  let data : Array[Double] = []
  for i in 0..<img.data.length() {
    data.push(img.data[i])
  }
  { width: img.width, height: img.height, data }
}

/// Sobel X 方向 / Sobel X direction.
pub fn edge_sobel_x(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let gx = -edge_pixel(img, x - 1, y - 1) + edge_pixel(img, x + 1, y - 1) - 2.0 * edge_pixel(img, x - 1, y) + 2.0 * edge_pixel(img, x + 1, y) - edge_pixel(img, x - 1, y + 1) + edge_pixel(img, x + 1, y + 1)
      edge_set_pixel(out, x, y, gx)
    }
  }
  out
}

/// Sobel Y 方向 / Sobel Y direction.
pub fn edge_sobel_y(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let gy = -edge_pixel(img, x - 1, y - 1) - 2.0 * edge_pixel(img, x, y - 1) - edge_pixel(img, x + 1, y - 1) + edge_pixel(img, x - 1, y + 1) + 2.0 * edge_pixel(img, x, y + 1) + edge_pixel(img, x + 1, y + 1)
      edge_set_pixel(out, x, y, gy)
    }
  }
  out
}

/// Sobel 幅度 / Sobel magnitude.
pub fn edge_sobel_magnitude(img : EdgeImage) -> EdgeImage {
  let gx = edge_sobel_x(img)
  let gy = edge_sobel_y(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mag = edge_sqrt(edge_pixel(gx, x, y) * edge_pixel(gx, x, y) + edge_pixel(gy, x, y) * edge_pixel(gy, x, y))
      edge_set_pixel(out, x, y, mag)
    }
  }
  out
}

/// Sobel 方向 / Sobel direction.
pub fn edge_sobel_direction(img : EdgeImage) -> EdgeImage {
  let gx = edge_sobel_x(img)
  let gy = edge_sobel_y(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let dir = edge_atan2(edge_pixel(gy, x, y), edge_pixel(gx, x, y))
      edge_set_pixel(out, x, y, dir)
    }
  }
  out
}

/// Prewitt X 方向 / Prewitt X direction.
pub fn edge_prewitt_x(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let gx = -edge_pixel(img, x - 1, y - 1) + edge_pixel(img, x + 1, y - 1) - edge_pixel(img, x - 1, y) + edge_pixel(img, x + 1, y) - edge_pixel(img, x - 1, y + 1) + edge_pixel(img, x + 1, y + 1)
      edge_set_pixel(out, x, y, gx)
    }
  }
  out
}

/// Prewitt Y 方向 / Prewitt Y direction.
pub fn edge_prewitt_y(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let gy = -edge_pixel(img, x - 1, y - 1) - edge_pixel(img, x, y - 1) - edge_pixel(img, x + 1, y - 1) + edge_pixel(img, x - 1, y + 1) + edge_pixel(img, x, y + 1) + edge_pixel(img, x + 1, y + 1)
      edge_set_pixel(out, x, y, gy)
    }
  }
  out
}

/// Prewitt 幅度 / Prewitt magnitude.
pub fn edge_prewitt_magnitude(img : EdgeImage) -> EdgeImage {
  let gx = edge_prewitt_x(img)
  let gy = edge_prewitt_y(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mag = edge_sqrt(edge_pixel(gx, x, y) * edge_pixel(gx, x, y) + edge_pixel(gy, x, y) * edge_pixel(gy, x, y))
      edge_set_pixel(out, x, y, mag)
    }
  }
  out
}

/// Roberts X 方向 / Roberts X direction.
pub fn edge_roberts_x(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let gx = edge_pixel(img, x, y) - edge_pixel(img, x + 1, y + 1)
      edge_set_pixel(out, x, y, gx)
    }
  }
  out
}

/// Roberts Y 方向 / Roberts Y direction.
pub fn edge_roberts_y(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let gy = edge_pixel(img, x + 1, y) - edge_pixel(img, x, y + 1)
      edge_set_pixel(out, x, y, gy)
    }
  }
  out
}

/// Roberts 幅度 / Roberts magnitude.
pub fn edge_roberts_magnitude(img : EdgeImage) -> EdgeImage {
  let gx = edge_roberts_x(img)
  let gy = edge_roberts_y(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mag = edge_sqrt(edge_pixel(gx, x, y) * edge_pixel(gx, x, y) + edge_pixel(gy, x, y) * edge_pixel(gy, x, y))
      edge_set_pixel(out, x, y, mag)
    }
  }
  out
}

/// Laplacian 4 邻域 / Laplacian 4-neighbor.
pub fn edge_laplacian_4(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = 4.0 * edge_pixel(img, x, y) - edge_pixel(img, x - 1, y) - edge_pixel(img, x + 1, y) - edge_pixel(img, x, y - 1) - edge_pixel(img, x, y + 1)
      edge_set_pixel(out, x, y, v)
    }
  }
  out
}

/// Laplacian 8 邻域 / Laplacian 8-neighbor.
pub fn edge_laplacian_8(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = 8.0 * edge_pixel(img, x, y) - edge_pixel(img, x - 1, y - 1) - edge_pixel(img, x, y - 1) - edge_pixel(img, x + 1, y - 1) - edge_pixel(img, x - 1, y) - edge_pixel(img, x + 1, y) - edge_pixel(img, x - 1, y + 1) - edge_pixel(img, x, y + 1) - edge_pixel(img, x + 1, y + 1)
      edge_set_pixel(out, x, y, v)
    }
  }
  out
}

/// Laplacian of Gaussian / Laplacian of Gaussian.
pub fn edge_laplacian_gaussian(img : EdgeImage, sigma : Double) -> EdgeImage {
  if sigma <= 0.0 {
    return edge_laplacian_8(img)
  }
  let radius = (3.0 * sigma).to_int()
  if radius < 1 {
    return edge_laplacian_8(img)
  }
  let size = 2 * radius + 1
  let kernel : Array[Double] = []
  let s2 = sigma * sigma
  for dy in -radius..=radius {
    for dx in -radius..=radius {
      let r2 = (dx * dx + dy * dy).to_double()
      let v = (r2 / s2 - 2.0) * edge_exp(-r2 / (2.0 * s2)) / (s2 * 3.141592653589793)
      kernel.push(v)
    }
  }
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut sum = 0.0
      for ky in 0..<size {
        for kx in 0..<size {
          sum = sum + edge_pixel(img, x + kx - radius, y + ky - radius) * kernel[ky * size + kx]
        }
      }
      edge_set_pixel(out, x, y, sum)
    }
  }
  out
}

/// Canny 高斯平滑 / Canny Gaussian smoothing.
pub fn canny_gaussian(img : EdgeImage, sigma : Double) -> EdgeImage {
  if sigma <= 0.0 {
    return edge_clone(img)
  }
  let radius = (3.0 * sigma).to_int()
  if radius < 1 {
    return edge_clone(img)
  }
  let size = 2 * radius + 1
  let kernel : Array[Double] = []
  let s2 = sigma * sigma
  let mut ksum = 0.0
  for dy in -radius..=radius {
    for dx in -radius..=radius {
      let r2 = (dx * dx + dy * dy).to_double()
      let v = edge_exp(-r2 / (2.0 * s2))
      kernel.push(v)
      ksum = ksum + v
    }
  }
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut sum = 0.0
      for ky in 0..<size {
        for kx in 0..<size {
          sum = sum + edge_pixel(img, x + kx - radius, y + ky - radius) * kernel[ky * size + kx]
        }
      }
      edge_set_pixel(out, x, y, sum / ksum)
    }
  }
  out
}

/// Canny 梯度 / Canny gradient.
pub fn canny_gradient(img : EdgeImage) -> (EdgeImage, EdgeImage) {
  let gx = edge_sobel_x(img)
  let gy = edge_sobel_y(img)
  let mag = edge_empty(img.width, img.height)
  let dir = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let m = edge_sqrt(edge_pixel(gx, x, y) * edge_pixel(gx, x, y) + edge_pixel(gy, x, y) * edge_pixel(gy, x, y))
      edge_set_pixel(mag, x, y, m)
      let d = edge_atan2(edge_pixel(gy, x, y), edge_pixel(gx, x, y))
      edge_set_pixel(dir, x, y, d)
    }
  }
  (mag, dir)
}

/// Canny 非极大值抑制 / Canny non-maximum suppression.
pub fn canney_nms(mag : EdgeImage, dir : EdgeImage) -> EdgeImage {
  let out = edge_empty(mag.width, mag.height)
  for y in 0..<mag.height {
    for x in 0..<mag.width {
      let angle = edge_pixel(dir, x, y) * 180.0 / 3.141592653589793
      let a = if angle < 0.0 { angle + 180.0 } else { angle }
      let m = edge_pixel(mag, x, y)
      let (n1, n2) = if a < 22.5 || a >= 157.5 {
        (edge_pixel(mag, x + 1, y), edge_pixel(mag, x - 1, y))
      } else if a < 67.5 {
        (edge_pixel(mag, x + 1, y + 1), edge_pixel(mag, x - 1, y - 1))
      } else if a < 112.5 {
        (edge_pixel(mag, x, y + 1), edge_pixel(mag, x, y - 1))
      } else {
        (edge_pixel(mag, x - 1, y + 1), edge_pixel(mag, x + 1, y - 1))
      }
      if m >= n1 && m >= n2 {
        edge_set_pixel(out, x, y, m)
      }
    }
  }
  out
}

/// Canny 双阈值 / Canny double threshold.
pub fn canny_threshold(img : EdgeImage, low : Double, high : Double) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = edge_pixel(img, x, y)
      if v >= high {
        edge_set_pixel(out, x, y, 255.0)
      } else if v >= low {
        edge_set_pixel(out, x, y, 128.0)
      }
    }
  }
  out
}

/// 滞后连接 / Hysteresis linking.
pub fn edge_hysteresis(img : EdgeImage) -> EdgeImage {
  let out = edge_clone(img)
  let queue : Array[(Int, Int)] = []
  for y in 0..<out.height {
    for x in 0..<out.width {
      if edge_pixel(out, x, y) == 255.0 {
        queue.push((x, y))
      }
    }
  }
  while queue.length() > 0 {
    let (cx, cy) = queue[queue.length() - 1]
    ignore(        ignore(queue.remove(queue.length() - 1)))
    for dy in -1..=1 {
      for dx in -1..=1 {
        if dx == 0 && dy == 0 {
          continue
        }
        let nx = cx + dx
        let ny = cy + dy
        if nx < 0 || nx >= out.width || ny < 0 || ny >= out.height {
          continue
        }
        if edge_pixel(out, nx, ny) == 128.0 {
          edge_set_pixel(out, nx, ny, 255.0)
          queue.push((nx, ny))
        }
      }
    }
  }
  for y in 0..<out.height {
    for x in 0..<out.width {
      if edge_pixel(out, x, y) == 128.0 {
        edge_set_pixel(out, x, y, 0.0)
      }
    }
  }
  out
}

/// 边缘细化 / Edge thinning.
pub fn edge_thin(img : EdgeImage) -> EdgeImage {
  let mut out = edge_clone(img)
  let mut changed = true
  let mut iter = 0
  while changed && iter < 10 {
    changed = false
    iter = iter + 1
    let next = edge_empty(out.width, out.height)
    for y in 0..<out.height {
      for x in 0..<out.width {
        let v = edge_pixel(out, x, y)
        if v == 0.0 {
          continue
        }
        let p2 = if edge_pixel(out, x, y - 1) > 0.0 { 1 } else { 0 }
        let p3 = if edge_pixel(out, x + 1, y - 1) > 0.0 { 1 } else { 0 }
        let p4 = if edge_pixel(out, x + 1, y) > 0.0 { 1 } else { 0 }
        let p5 = if edge_pixel(out, x + 1, y + 1) > 0.0 { 1 } else { 0 }
        let p6 = if edge_pixel(out, x, y + 1) > 0.0 { 1 } else { 0 }
        let p7 = if edge_pixel(out, x - 1, y + 1) > 0.0 { 1 } else { 0 }
        let p8 = if edge_pixel(out, x - 1, y) > 0.0 { 1 } else { 0 }
        let p9 = if edge_pixel(out, x - 1, y - 1) > 0.0 { 1 } else { 0 }
        let cn = p2 + p4 + p6 + p8
        let seq = (p2 * (1 - p3) * p4) + (p4 * (1 - p5) * p6) + (p6 * (1 - p7) * p8) + (p8 * (1 - p9) * p2)
        if cn >= 2 && cn <= 6 && seq == 1 {
          edge_set_pixel(next, x, y, 0.0)
          changed = true
        } else {
          edge_set_pixel(next, x, y, v)
        }
      }
    }
    out = next
  }
  out
}

/// 边缘连接 / Edge linking.
pub fn edge_link(img : EdgeImage, threshold : Double) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  let visited : Array[Bool] = []
  for _ in 0..<(img.width * img.height) {
    visited.push(false)
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      let idx = y * img.width + x
      if visited[idx] || edge_pixel(img, x, y) < threshold {
        continue
      }
      let queue : Array[(Int, Int)] = []
      queue.push((x, y))
      visited[idx] = true
      while queue.length() > 0 {
        let (cx, cy) = queue[queue.length() - 1]
        ignore(        ignore(queue.remove(queue.length() - 1)))
        edge_set_pixel(out, cx, cy, 255.0)
        for dy in -1..=1 {
          for dx in -1..=1 {
            if dx == 0 && dy == 0 {
              continue
            }
            let nx = cx + dx
            let ny = cy + dy
            if nx < 0 || nx >= img.width || ny < 0 || ny >= img.height {
              continue
            }
            let nidx = ny * img.width + nx
            if visited[nidx] || edge_pixel(img, nx, ny) < threshold {
              continue
            }
            visited[nidx] = true
            queue.push((nx, ny))
          }
        }
      }
    }
  }
  out
}

/// 边缘补全 / Edge completion.
pub fn edge_complete(img : EdgeImage, max_gap : Int) -> EdgeImage {
  let out = edge_clone(img)
  for y in 0..<out.height {
    let mut last_edge = -1
    for x in 0..<out.width {
      if edge_pixel(out, x, y) > 0.0 {
        if last_edge >= 0 && x - last_edge <= max_gap {
          for fx in (last_edge + 1)..<x {
            edge_set_pixel(out, fx, y, 255.0)
          }
        }
        last_edge = x
      }
    }
  }
  out
}

/// 零交叉检测 / Zero crossing detection.
pub fn edge_zero_crossing(img : EdgeImage) -> EdgeImage {
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let v = edge_pixel(img, x, y)
      let vr = edge_pixel(img, x + 1, y)
      let vd = edge_pixel(img, x, y + 1)
      if (v > 0.0 && vr < 0.0) || (v < 0.0 && vr > 0.0) {
        if edge_abs(v) + edge_abs(vr) > 1.0 {
          edge_set_pixel(out, x, y, 255.0)
        }
      }
      if (v > 0.0 && vd < 0.0) || (v < 0.0 && vd > 0.0) {
        if edge_abs(v) + edge_abs(vd) > 1.0 {
          edge_set_pixel(out, x, y, 255.0)
        }
      }
    }
  }
  out
}

/// Marr-Hildreth 边缘检测 / Marr-Hildreth edge detection.
pub fn edge_marr_hildreth(img : EdgeImage, sigma : Double) -> EdgeImage {
  let log = edge_laplacian_gaussian(img, sigma)
  edge_zero_crossing(log)
}

/// DoG 边缘检测 / Difference of Gaussians.
pub fn edge_dog(img : EdgeImage, sigma1 : Double, sigma2 : Double) -> EdgeImage {
  let g1 = canny_gaussian(img, sigma1)
  let g2 = canny_gaussian(img, sigma2)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      edge_set_pixel(out, x, y, edge_pixel(g1, x, y) - edge_pixel(g2, x, y))
    }
  }
  out
}

/// LoG 拉普拉斯 / LoG Laplacian.
pub fn edge_log_laplacian(img : EdgeImage, sigma : Double) -> EdgeImage {
  edge_laplacian_gaussian(img, sigma)
}

/// 相位一致性 / Phase congruency (simplified).
pub fn edge_phase_congruency(img : EdgeImage) -> EdgeImage {
  let gx = edge_sobel_x(img)
  let gy = edge_sobel_y(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let a = edge_pixel(gx, x, y)
      let b = edge_pixel(gy, x, y)
      let mag = edge_sqrt(a * a + b * b)
      let mut sum_even = 0.0
      let mut sum_odd = 0.0
      for dy in -1..=1 {
        for dx in -1..=1 {
          let v = edge_pixel(img, x + dx, y + dy)
          if dx * dx + dy * dy > 0 {
            sum_even = sum_even + v
            sum_odd = sum_odd + v * (dx + dy).to_double()
          }
        }
      }
      let energy = edge_sqrt(sum_even * sum_even + sum_odd * sum_odd)
      let pc = if energy > 0.0 { mag / energy } else { 0.0 }
      edge_set_pixel(out, x, y, pc * 255.0)
    }
  }
  out
}

/// 单ogenic 边缘检测 / Monogenic signal edge detection.
pub fn edge_monogenic(img : EdgeImage) -> EdgeImage {
  let gx = edge_sobel_x(img)
  let gy = edge_sobel_y(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let a = edge_pixel(gx, x, y)
      let b = edge_pixel(gy, x, y)
      let mag = edge_sqrt(a * a + b * b)
      let phase = edge_atan2(b, a)
      let pc = mag * edge_abs(edge_cos(phase))
      edge_set_pixel(out, x, y, pc)
    }
  }
  out
}

fn edge_cos(x : Double) -> Double {
  edge_sin(x + 1.5707963267948966)
}

fn edge_sin(x : Double) -> Double {
  let pi = 3.141592653589793
  let two_pi = 6.283185307179586
  let mut y = x
  while y > pi {
    y = y - two_pi
  }
  while y < -pi {
    y = y + two_pi
  }
  let y2 = y * y
  let mut term = y
  let mut sum = y
  for n in 1..<14 {
    term = -term * y2 / ((2 * n).to_double() * (2 * n + 1).to_double())
    sum = sum + term
  }
  sum
}

/// 非极大值抑制 / Non-maximum suppression.
pub fn edge_non_max_suppress(img : EdgeImage) -> EdgeImage {
  let (mag, dir) = canny_gradient(img)
  canney_nms(mag, dir)
}

/// 双阈值 / Double threshold.
pub fn edge_double_threshold(img : EdgeImage, low : Double, high : Double) -> EdgeImage {
  canny_threshold(img, low, high)
}

/// Canny 边缘检测 / Canny edge detection.
pub fn edge_canny(img : EdgeImage, low : Double, high : Double, sigma : Double) -> EdgeImage {
  let smoothed = canny_gaussian(img, sigma)
  let (mag, dir) = canny_gradient(smoothed)
  let nms = canney_nms(mag, dir)
  let thresh = canny_threshold(nms, low, high)
  edge_hysteresis(thresh)
}

/// 边缘质量 / Edge quality.
pub fn edge_quality(edges : EdgeImage, img : EdgeImage) -> Double {
  let mut sum = 0.0
  let mut count = 0.0
  for y in 0..<edges.height {
    for x in 0..<edges.width {
      if edge_pixel(edges, x, y) > 0.0 {
        let gx = edge_pixel(img, x + 1, y) - edge_pixel(img, x - 1, y)
        let gy = edge_pixel(img, x, y + 1) - edge_pixel(img, x, y - 1)
        let g = edge_sqrt(gx * gx + gy * gy)
        sum = sum + g
        count = count + 1.0
      }
    }
  }
  if count == 0.0 {
    return 0.0
  }
  sum / count
}

/// 边缘连续性 / Edge continuity.
pub fn edge_continuity(edges : EdgeImage) -> Double {
  let mut total_len = 0.0
  let mut num_segments = 0.0
  let visited : Array[Bool] = []
  for _ in 0..<(edges.width * edges.height) {
    visited.push(false)
  }
  for y in 0..<edges.height {
    for x in 0..<edges.width {
      let idx = y * edges.width + x
      if visited[idx] || edge_pixel(edges, x, y) == 0.0 {
        continue

      }
      let queue : Array[(Int, Int)] = []
      queue.push((x, y))
      visited[idx] = true
      let mut seg_len = 0.0
      while queue.length() > 0 {
        let (cx, cy) = queue[queue.length() - 1]
        ignore(        ignore(queue.remove(queue.length() - 1)))
        seg_len = seg_len + 1.0
        for dy in -1..=1 {
          for dx in -1..=1 {
            if dx == 0 && dy == 0 {
              continue
            }
            let nx = cx + dx
            let ny = cy + dy
            if nx < 0 || nx >= edges.width || ny < 0 || ny >= edges.height {
              continue
            }
            let nidx = ny * edges.width + nx
            if visited[nidx] || edge_pixel(edges, nx, ny) == 0.0 {
              continue
            }
            visited[nidx] = true
            queue.push((nx, ny))
          }
        }
      }
      total_len = total_len + seg_len
      num_segments = num_segments + 1.0
    }
  }
  if num_segments == 0.0 {
    return 0.0
  }
  total_len / num_segments
}

/// 边缘强度 / Edge strength.
pub fn edge_strength(edges : EdgeImage) -> Double {
  let mut sum = 0.0
  let mut count = 0.0
  for y in 0..<edges.height {
    for x in 0..<edges.width {
      sum = sum + edge_pixel(edges, x, y)
      count = count + 1.0
    }
  }
  if count == 0.0 {
    return 0.0
  }
  sum / count
}

/// 构造边缘配置 / Build edge config.
pub fn make_edge_config(
  method : Int,
  low_threshold : Double,
  high_threshold : Double,
  sigma : Double,
  kernel_size : Int
) -> EdgeConfig {
  { method, low_threshold, high_threshold, sigma, kernel_size }
}

/// 全边缘检测 / Detect all edges.
pub fn edge_detect_all(img : EdgeImage) -> Array[EdgeImage] {
  let result : Array[EdgeImage] = []
  result.push(edge_sobel_magnitude(img))
  result.push(edge_prewitt_magnitude(img))
  result.push(edge_roberts_magnitude(img))
  result.push(edge_laplacian_4(img))
  result.push(edge_laplacian_8(img))
  result.push(edge_canny(img, 30.0, 80.0, 1.0))
  result.push(edge_marr_hildreth(img, 1.0))
  result
}

/// 边缘剖面 / Edge profile.
pub fn edge_profile(img : EdgeImage, x : Int, y : Int, direction : Int) -> Array[Double] {
  let result : Array[Double] = []
  let length = if direction == 0 { img.width } else { img.height }
  for i in 0..<length {
    let v = if direction == 0 {
      edge_pixel(img, i, y)
    } else {
      edge_pixel(img, x, i)
    }
    result.push(v)
  }
  result
}

/// 转字符串 / Convert to string.
pub fn edge_to_string(img : EdgeImage) -> String {
  let mut s = "EdgeImage(" + img.width.to_string() + "x" + img.height.to_string() + ")["
  let limit = if img.data.length() > 10 { 10 } else { img.data.length() }
  for i in 0..<limit {
    if i > 0 {
      s = s + ", "
    }
    s = s + img.data[i].to_string()
  }
  if img.data.length() > 10 {
    s = s + ", ..."
  }
  s = s + "]"
  s
}

/// Sobel 完整检测 / Sobel full detection.
pub fn edge_sobel(img : EdgeImage, threshold : Double) -> EdgeImage {
  let mag = edge_sobel_magnitude(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      if edge_pixel(mag, x, y) >= threshold {
        edge_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

/// Prewitt 完整检测 / Prewitt full detection.
pub fn edge_prewitt(img : EdgeImage, threshold : Double) -> EdgeImage {
  let mag = edge_prewitt_magnitude(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      if edge_pixel(mag, x, y) >= threshold {
        edge_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

/// Roberts 完整检测 / Roberts full detection.
pub fn edge_roberts(img : EdgeImage, threshold : Double) -> EdgeImage {
  let mag = edge_roberts_magnitude(img)
  let out = edge_empty(img.width, img.height)
  for y in 0..<img.height {
    for x in 0..<img.width {
      if edge_pixel(mag, x, y) >= threshold {
        edge_set_pixel(out, x, y, 255.0)
      }
    }
  }
  out
}

/// 边缘检测 ID / Edge detection operator ID.
pub fn edge_detection_id() -> String {
  "opcore/edge_detection"
}