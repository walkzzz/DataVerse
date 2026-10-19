///|
/// # opcore/computer_vision 计算机视觉算子 / Computer Vision Operators
///
/// 图像/视频/特征/几何算子库。架构 §4.3.2 ⑦ Transform（多模态）。
/// 元数据 + 像素驱动（MoonBit 无真实图像解码，?操作 CVImage 结构体）。
///
/// # Computer vision operators
///
/// Image / video / feature / geometry operators. See architecture §4.3.2 ⑦.

/// CV 图像 / CV image (pixel data as Double array).
pub struct CVImage {
  width : Int
  height : Int
  channels : Int
  data : Array[Double]
} derive(Debug, Eq)

pub extend CVImage with Eq::{equal, not_equal}
pub extend CVImage with Debug::{to_repr}

/// 构造 CV 图像 / Build CV image.
pub fn make_image_cv(
  width : Int,
  height : Int,
  channels : Int,
  data : Array[Double]
) -> CVImage {
  { width, height, channels, data }
}

/// 图像宽度 / Image width.
pub fn cv_width(img : CVImage) -> Int {
  img.width
}

/// 图像高度 / Image height.
pub fn cv_height(img : CVImage) -> Int {
  img.height
}

/// 图像通道数 / Image channels.
pub fn cv_channels(img : CVImage) -> Int {
  img.channels
}

/// 读取像素 / Read pixel (x, y, c).
pub fn cv_pixel(img : CVImage, x : Int, y : Int, c : Int) -> Double {
  if x < 0 || x >= img.width || y < 0 || y >= img.height || c < 0 || c >= img.channels {
    return 0.0
  }
  let idx = (y * img.width + x) * img.channels + c
  if idx < 0 || idx >= img.data.length() {
    return 0.0
  }
  img.data[idx]
}

/// 内部写像素 / Internal pixel write.
fn cv_set_pixel(
  img : CVImage,
  x : Int,
  y : Int,
  c : Int,
  v : Double
) -> Unit {
  let idx = (y * img.width + x) * img.channels + c
  if idx >= 0 && idx < img.data.length() {
    img.data[idx] = v
  }
}

/// 内部正弦 / Internal sine.
fn cv_sin(x : Double) -> Double {
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

/// 内部余弦 / Internal cosine.
fn cv_cos(x : Double) -> Double {
  cv_sin(x + 1.5707963267948966)
}

/// 内部平方根 / Internal square root.
fn cv_sqrt(x : Double) -> Double {
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

/// 内部指数 / Internal exp.
fn cv_exp(x : Double) -> Double {
  let mut term = 1.0
  let mut sum = 1.0
  for n in 1..<24 {
    term = term * x / n.to_double()
    sum = sum + term
  }
  sum
}

/// 内部对数 / Internal ln.
fn cv_ln(x : Double) -> Double {
  if x <= 0.0 {
    return -999.0
  }
  let mut result = 0.0
  let t = (x - 1.0) / (x + 1.0)
  let t2 = t * t
  let mut term = t
  for k in 0..<50 {
    result = result + term / (2 * k + 1).to_double()
    term = term * t2
  }
  2.0 * result
}

/// 内部绝对值 / Internal abs.
fn cv_abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

/// 内部最大值 / Internal max.
fn cv_max(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

/// 内部最小值 / Internal min.
fn cv_min(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

/// 内部限幅 / Internal clamp.
fn cv_clamp(v : Double, lo : Double, hi : Double) -> Double {
  if v < lo {
    lo
  } else if v > hi {
    hi
  } else {
    v
  }
}

/// 内部空图像 / Internal empty image.
fn cv_empty(w : Int, h : Int, c : Int) -> CVImage {
  let n = w * h * c
  let data : Array[Double] = []
  for _ in 0..<n {
    data.push(0.0)
  }
  { width: w, height: h, channels: c, data }
}

/// 最近邻缩放 / Resize nearest.
pub fn cv_resize_nearest(img : CVImage, new_w : Int, new_h : Int) -> CVImage {
  if new_w <= 0 || new_h <= 0 {
    return cv_empty(0, 0, img.channels)
  }
  let out = cv_empty(new_w, new_h, img.channels)
  for y in 0..<new_h {
    for x in 0..<new_w {
      let sx = x * img.width / new_w
      let sy = y * img.height / new_h
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, cv_pixel(img, sx, sy, c))
      }
    }
  }
  out
}

/// 双线性缩放 / Resize bilinear.
pub fn cv_resize_bilinear(img : CVImage, new_w : Int, new_h : Int) -> CVImage {
  if new_w <= 0 || new_h <= 0 || img.width <= 0 || img.height <= 0 {
    return cv_empty(0, 0, img.channels)
  }
  let out = cv_empty(new_w, new_h, img.channels)
  let sx_ratio = img.width.to_double() / new_w.to_double()
  let sy_ratio = img.height.to_double() / new_h.to_double()
  for y in 0..<new_h {
    for x in 0..<new_w {
      let fx = x.to_double() * sx_ratio
      let fy = y.to_double() * sy_ratio
      let x0 = fx.to_int()
      let y0 = fy.to_int()
      let x1 = if x0 + 1 < img.width { x0 + 1 } else { x0 }
      let y1 = if y0 + 1 < img.height { y0 + 1 } else { y0 }
      let dx = fx - x0.to_double()
      let dy = fy - y0.to_double()
      for c in 0..<img.channels {
        let v00 = cv_pixel(img, x0, y0, c)
        let v01 = cv_pixel(img, x0, y1, c)
        let v10 = cv_pixel(img, x1, y0, c)
        let v11 = cv_pixel(img, x1, y1, c)
        let v = v00 * (1.0 - dx) * (1.0 - dy) + v10 * dx * (1.0 - dy) + v01 * (1.0 - dx) * dy + v11 * dx * dy
        cv_set_pixel(out, x, y, c, v)
      }
    }
  }
  out
}

/// 双三次缩放 / Resize bicubic (simplified to bilinear kernel).
pub fn cv_resize_bicubic(img : CVImage, new_w : Int, new_h : Int) -> CVImage {
  if new_w <= 0 || new_h <= 0 || img.width <= 0 || img.height <= 0 {
    return cv_empty(0, 0, img.channels)
  }
  let out = cv_empty(new_w, new_h, img.channels)
  let sx_ratio = img.width.to_double() / new_w.to_double()
  let sy_ratio = img.height.to_double() / new_h.to_double()
  for y in 0..<new_h {
    for x in 0..<new_w {
      let fx = x.to_double() * sx_ratio
      let fy = y.to_double() * sy_ratio
      let x0 = fx.to_int()
      let y0 = fy.to_int()
      let dx = fx - x0.to_double()
      let dy = fy - y0.to_double()
      for c in 0..<img.channels {
        let mut acc = 0.0
        let mut wsum = 0.0
        for j in -1..=2 {
          for i in -1..=2 {
            let sx = x0 + i
            let sy = y0 + j
            let wx = cv_cubic_weight(i.to_double() - dx)
            let wy = cv_cubic_weight(j.to_double() - dy)
            let w = wx * wy
            acc = acc + cv_pixel(img, sx, sy, c) * w
            wsum = wsum + w
          }
        }
        if wsum != 0.0 {
          cv_set_pixel(out, x, y, c, acc / wsum)
        }
      }
    }
  }
  out
}

/// 内部三次卷积权重 / Internal cubic weight.
fn cv_cubic_weight(t : Double) -> Double {
  let a = -0.5
  let at = cv_abs(t)
  if at < 1.0 {
    (a + 2.0) * at * at * at - (a + 3.0) * at * at + 1.0
  } else if at < 2.0 {
    a * at * at * at - 5.0 * a * at * at + 8.0 * a * at - 4.0 * a
  } else {
    0.0
  }
}

/// 通用缩放 / Resize (mode: 0=nearest, 1=bilinear, 2=bicubic).
pub fn cv_resize(img : CVImage, new_w : Int, new_h : Int, mode : Int) -> CVImage {
  if mode == 0 {
    cv_resize_nearest(img, new_w, new_h)
  } else if mode == 1 {
    cv_resize_bilinear(img, new_w, new_h)
  } else {
    cv_resize_bicubic(img, new_w, new_h)
  }
}

/// 旋转 / Rotate (angle in degrees, around center).
pub fn cv_rotate(img : CVImage, angle_deg : Double) -> CVImage {
  if img.width <= 0 || img.height <= 0 {
    return cv_empty(0, 0, img.channels)
  }
  let rad = angle_deg * 3.141592653589793 / 180.0
  let cs = cv_cos(rad)
  let sn = cv_sin(rad)
  let cx = img.width.to_double() / 2.0
  let cy = img.height.to_double() / 2.0
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let dx = x.to_double() - cx
      let dy = y.to_double() - cy
      let sx = dx * cs + dy * sn + cx
      let sy = -dx * sn + dy * cs + cy
      let x0 = sx.to_int()
      let y0 = sy.to_int()
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, cv_pixel(img, x0, y0, c))
      }
    }
  }
  out
}

/// 水平翻转 / Flip horizontal.
pub fn cv_flip_h(img : CVImage) -> CVImage {
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, cv_pixel(img, img.width - 1 - x, y, c))
      }
    }
  }
  out
}

/// 垂直翻转 / Flip vertical.
pub fn cv_flip_v(img : CVImage) -> CVImage {
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, cv_pixel(img, x, img.height - 1 - y, c))
      }
    }
  }
  out
}

/// 裁剪 / Crop region.
pub fn cv_crop(img : CVImage, x : Int, y : Int, w : Int, h : Int) -> CVImage {
  if w <= 0 || h <= 0 {
    return cv_empty(0, 0, img.channels)
  }
  let out = cv_empty(w, h, img.channels)
  for j in 0..<h {
    for i in 0..<w {
      for c in 0..<img.channels {
        cv_set_pixel(out, i, j, c, cv_pixel(img, x + i, y + j, c))
      }
    }
  }
  out
}

/// 填充 / Pad image with constant value.
pub fn cv_pad(img : CVImage, top : Int, bottom : Int, left : Int, right : Int, value : Double) -> CVImage {
  let new_w = img.width + left + right
  let new_h = img.height + top + bottom
  if new_w <= 0 || new_h <= 0 {
    return cv_empty(0, 0, img.channels)
  }
  let out = cv_empty(new_w, new_h, img.channels)
  for y in 0..<new_h {
    for x in 0..<new_w {
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, value)
      }
    }
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        cv_set_pixel(out, x + left, y + top, c, cv_pixel(img, x, y, c))
      }
    }
  }
  out
}

/// 灰度化 / Convert to grayscale.
pub fn cv_grayscale(img : CVImage) -> CVImage {
  if img.channels < 3 {
    return img
  }
  let out = cv_empty(img.width, img.height, 1)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let r = cv_pixel(img, x, y, 0)
      let g = cv_pixel(img, x, y, 1)
      let b = cv_pixel(img, x, y, 2)
      let gray = 0.299 * r + 0.587 * g + 0.114 * b
      cv_set_pixel(out, x, y, 0, gray)
    }
  }
  out
}

/// 阈值二值化 / Threshold binary.
pub fn cv_threshold_cv(img : CVImage, thresh : Double, max_val : Double) -> CVImage {
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let v = cv_pixel(img, x, y, c)
        cv_set_pixel(out, x, y, c, if v > thresh { max_val } else { 0.0 })
      }
    }
  }
  out
}

/// 自适应阈值 / Adaptive threshold (mean-based).
pub fn cv_adaptive_threshold(img : CVImage, block_size : Int, c_offset : Double) -> CVImage {
  if img.channels != 1 || block_size <= 0 {
    return img
  }
  let half = block_size / 2
  let out = cv_empty(img.width, img.height, 1)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let mut sum = 0.0
      let mut cnt = 0
      for dy in -half..=half {
        for dx in -half..=half {
          sum = sum + cv_pixel(img, x + dx, y + dy, 0)
          cnt = cnt + 1
        }
      }
      let mean = if cnt > 0 { sum / cnt.to_double() } else { 0.0 }
      let v = cv_pixel(img, x, y, 0)
      cv_set_pixel(out, x, y, 0, if v > mean - c_offset { 255.0 } else { 0.0 })
    }
  }
  out
}

/// 内部高斯函数 / Internal gaussian.
fn cv_gauss(x : Double, sigma : Double) -> Double {
  if sigma == 0.0 {
    return 0.0
  }
  let s2 = sigma * sigma
  cv_exp(-x * x / (2.0 * s2)) / cv_sqrt(6.283185307179586 * s2)
}

/// 高斯模糊 / Gaussian blur.
pub fn cv_gaussian_blur(img : CVImage, ksize : Int, sigma : Double) -> CVImage {
  if ksize <= 0 || ksize % 2 == 0 {
    return img
  }
  let half = ksize / 2
  let kernel : Array[Double] = []
  let mut ksum = 0.0
  for i in 0..<ksize {
    let v = cv_gauss((i - half).to_double(), sigma)
    kernel.push(v)
    ksum = ksum + v
  }
  for i in 0..<ksize {
    kernel[i] = kernel[i] / ksum
  }
  let tmp = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let mut acc = 0.0
        for k in 0..<ksize {
          acc = acc + cv_pixel(img, x + k - half, y, c) * kernel[k]
        }
        cv_set_pixel(tmp, x, y, c, acc)
      }
    }
  }
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let mut acc = 0.0
        for k in 0..<ksize {
          acc = acc + cv_pixel(tmp, x, y + k - half, c) * kernel[k]
        }
        cv_set_pixel(out, x, y, c, acc)
      }
    }
  }
  out
}

/// 方框模糊 / Box blur.
pub fn cv_box_blur(img : CVImage, ksize : Int) -> CVImage {
  if ksize <= 0 {
    return img
  }
  let half = ksize / 2
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let mut sum = 0.0
        let mut cnt = 0
        for dy in -half..=half {
          for dx in -half..=half {
            sum = sum + cv_pixel(img, x + dx, y + dy, c)
            cnt = cnt + 1
          }
        }
        cv_set_pixel(out, x, y, c, sum / cnt.to_double())
      }
    }
  }
  out
}

/// 中值模糊 / Median blur.
pub fn cv_median_blur(img : CVImage, ksize : Int) -> CVImage {
  if ksize <= 0 {
    return img
  }
  let half = ksize / 2
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let vals : Array[Double] = []
        for dy in -half..=half {
          for dx in -half..=half {
            vals.push(cv_pixel(img, x + dx, y + dy, c))
          }
        }
        cv_set_pixel(out, x, y, c, cv_median(vals))
      }
    }
  }
  out
}

/// 内部中位数 / Internal median.
fn cv_median(arr : Array[Double]) -> Double {
  let n = arr.length()
  if n == 0 {
    return 0.0
  }
  let sorted = Array::copy(arr)
  for i in 0..<n {
    for j in 0..<(n - 1 - i) {
      if sorted[j] > sorted[j + 1] {
        let t = sorted[j]
        sorted[j] = sorted[j + 1]
        sorted[j + 1] = t
      }
    }
  }
  sorted[n / 2]
}

/// 双边滤波 / Bilateral filter.
pub fn cv_bilateral_filter(img : CVImage, ksize : Int, sigma_space : Double, sigma_color : Double) -> CVImage {
  if ksize <= 0 {
    return img
  }
  let half = ksize / 2
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let center = cv_pixel(img, x, y, c)
        let mut acc = 0.0
        let mut wsum = 0.0
        for dy in -half..=half {
          for dx in -half..=half {
            let v = cv_pixel(img, x + dx, y + dy, c)
            let ws = cv_exp(-(dx * dx + dy * dy).to_double() / (2.0 * sigma_space * sigma_space))
            let wc = cv_exp(-(v - center) * (v - center) / (2.0 * sigma_color * sigma_color))
            let w = ws * wc
            acc = acc + v * w
            wsum = wsum + w
          }
        }
        cv_set_pixel(out, x, y, c, if wsum > 0.0 { acc / wsum } else { center })
      }
    }
  }
  out
}

/// Sobel 边缘 / Sobel edge.
pub fn cv_sobel(img : CVImage, dx : Int, dy : Int, ksize : Int) -> CVImage {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let out = cv_empty(gray.width, gray.height, 1)
  let half = if ksize == 3 { 1 } else { 1 }
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      let mut gx = 0.0
      let mut gy = 0.0
      if dx > 0 {
        gx = cv_pixel(gray, x + 1, y, 0) - cv_pixel(gray, x - 1, y, 0)
      }
      if dy > 0 {
        gy = cv_pixel(gray, x, y + 1, 0) - cv_pixel(gray, x, y - 1, 0)
      }
      let v = cv_sqrt(gx * gx + gy * gy)
      ignore(half)
      cv_set_pixel(out, x, y, 0, v)
    }
  }
  out
}

/// 拉普拉斯 / Laplacian.
pub fn cv_laplacian(img : CVImage, ksize : Int) -> CVImage {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let out = cv_empty(gray.width, gray.height, 1)
  ignore(ksize)
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      let v = 4.0 * cv_pixel(gray, x, y, 0) - cv_pixel(gray, x + 1, y, 0) - cv_pixel(gray, x - 1, y, 0) - cv_pixel(gray, x, y + 1, 0) - cv_pixel(gray, x, y - 1, 0)
      cv_set_pixel(out, x, y, 0, v)
    }
  }
  out
}

/// Canny 边缘 / Canny edge.
pub fn cv_canny(img : CVImage, low : Double, high : Double) -> CVImage {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let blurred = cv_gaussian_blur(gray, 3, 1.0)
  let gx = cv_sobel(blurred, 1, 0, 3)
  let gy = cv_sobel(blurred, 0, 1, 3)
  let out = cv_empty(gray.width, gray.height, 1)
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      let mag = cv_sqrt(cv_pixel(gx, x, y, 0) * cv_pixel(gx, x, y, 0) + cv_pixel(gy, x, y, 0) * cv_pixel(gy, x, y, 0))
      cv_set_pixel(out, x, y, 0, if mag > high { 255.0 } else if mag > low { 128.0 } else { 0.0 })
    }
  }
  out
}

/// Hough 直线 / Hough lines (returns list of (rho, theta)).
pub fn cv_hough_lines(img : CVImage, threshold : Double) -> Array[(Double, Double)] {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let result : Array[(Double, Double)] = []
  let num_theta = 180
  let max_rho = cv_sqrt(gray.width.to_double() * gray.width.to_double() + gray.height.to_double() * gray.height.to_double())
  let num_rho = (max_rho * 2.0).to_int() + 1
  let accum : Array[Int] = []
  for _ in 0..<(num_rho * num_theta) {
    accum.push(0)
  }
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      if cv_pixel(gray, x, y, 0) > 128.0 {
        for t in 0..<num_theta {
          let theta = t.to_double() * 3.141592653589793 / 180.0
          let rho = x.to_double() * cv_cos(theta) + y.to_double() * cv_sin(theta)
          let r_idx = (rho + max_rho).to_int()
          if r_idx >= 0 && r_idx < num_rho {
            accum[r_idx * num_theta + t] = accum[r_idx * num_theta + t] + 1
          }
        }
      }
    }
  }
  for r in 0..<num_rho {
    for t in 0..<num_theta {
      if accum[r * num_theta + t].to_double() > threshold {
        result.push((r.to_double() - max_rho, t.to_double() * 3.141592653589793 / 180.0))
      }
    }
  }
  result
}

/// Hough 圆 / Hough circles (returns list of (cx, cy, r)).
pub fn cv_hough_circles(img : CVImage, min_r : Int, max_r : Int, threshold : Double) -> Array[(Double, Double, Double)] {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let result : Array[(Double, Double, Double)] = []
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      if cv_pixel(gray, x, y, 0) > 128.0 {
        for r in min_r..=max_r {
          let mut cnt = 0
          for t in 0..<36 {
            let theta = t.to_double() * 6.283185307179586 / 36.0
            let cx = x.to_double() - r.to_double() * cv_cos(theta)
            let cy = y.to_double() - r.to_double() * cv_sin(theta)
            if cv_pixel(gray, cx.to_int(), cy.to_int(), 0) > 128.0 {
              cnt = cnt + 1
            }
          }
          if cnt.to_double() > threshold {
            result.push((x.to_double(), y.to_double(), r.to_double()))
          }
        }
      }
    }
  }
  result
}

/// 轮廓（占位）/ Contours placeholder.
pub fn cv_contours(img : CVImage) -> Array[Array[(Int, Int)]] {
  let result : Array[Array[(Int, Int)]] = []
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let visited : Array[Bool] = []
  for _ in 0..<(gray.width * gray.height) {
    visited.push(false)
  }
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      let idx = y * gray.width + x
      if cv_pixel(gray, x, y, 0) > 128.0 && not(visited[idx]) {
        let contour : Array[(Int, Int)] = []
        cv_trace_contour(gray, x, y, visited, contour)
        if contour.length() > 0 {
          result.push(contour)
        }
      }
    }
  }
  result
}

/// 内部轮廓追踪 / Internal trace contour.
fn cv_trace_contour(
  img : CVImage,
  sx : Int,
  sy : Int,
  visited : Array[Bool],
  contour : Array[(Int, Int)]
) -> Unit {
  let mut x = sx
  let mut y = sy
  let mut iter = 0
  while iter < img.width * img.height {
    let idx = y * img.width + x
    if visited[idx] {
      return
    }
    if cv_pixel(img, x, y, 0) <= 128.0 {
      return
    }
    visited[idx] = true
    contour.push((x, y))
    if cv_pixel(img, x + 1, y, 0) > 128.0 {
      x = x + 1
    } else if cv_pixel(img, x, y + 1, 0) > 128.0 {
      y = y + 1
    } else if cv_pixel(img, x - 1, y, 0) > 128.0 {
      x = x - 1
    } else if cv_pixel(img, x, y - 1, 0) > 128.0 {
      y = y - 1
    } else {
      return
    }
    iter = iter + 1
  }
}

/// 查找轮廓 / Find contours (alias).
pub fn cv_find_contours(img : CVImage) -> Array[Array[(Int, Int)]] {
  cv_contours(img)
}

/// 绘制轮廓 / Draw contours.
pub fn cv_draw_contours(img : CVImage, contours : Array[Array[(Int, Int)]], color : Double) -> CVImage {
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, cv_pixel(img, x, y, c))
      }
    }
  }
  for contour in contours {
    for pt in contour {
      let (x, y) = pt
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, color)
      }
    }
  }
  out
}

/// 轮廓面积 / Contour area (shoelace).
pub fn cv_contour_area(contour : Array[(Int, Int)]) -> Double {
  let n = contour.length()
  if n < 3 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let (x1, y1) = contour[i]
    let (x2, y2) = contour[(i + 1) % n]
    sum = sum + (x1.to_double() * y2.to_double() - x2.to_double() * y1.to_double())
  }
  cv_abs(sum) / 2.0
}

/// 外接矩形 / Bounding rect (returns (x, y, w, h)).
pub fn cv_bounding_rect(contour : Array[(Int, Int)]) -> (Int, Int, Int, Int) {
  if contour.length() == 0 {
    return (0, 0, 0, 0)
  }
  let (x0, y0) = contour[0]
  let mut min_x = x0
  let mut max_x = x0
  let mut min_y = y0
  let mut max_y = y0
  for pt in contour {
    let (x, y) = pt
    if x < min_x {
      min_x = x
    }
    if x > max_x {
      max_x = x
    }
    if y < min_y {
      min_y = y
    }
    if y > max_y {
      max_y = y
    }
  }
  (min_x, min_y, max_x - min_x + 1, max_y - min_y + 1)
}

/// 最小面积矩形 / Min area rect (simplified to bounding rect).
pub fn cv_min_area_rect(contour : Array[(Int, Int)]) -> ((Double, Double), (Double, Double), Double) {
  let (x, y, w, h) = cv_bounding_rect(contour)
  ((x.to_double(), y.to_double()), (w.to_double(), h.to_double()), 0.0)
}

/// 拟合椭圆 / Fit ellipse (returns (cx, cy, a, b, angle)).
pub fn cv_fit_ellipse(contour : Array[(Int, Int)]) -> (Double, Double, Double, Double, Double) {
  let n = contour.length()
  if n < 5 {
    return (0.0, 0.0, 0.0, 0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for pt in contour {
    let (x, y) = pt
    sx = sx + x.to_double()
    sy = sy + y.to_double()
  }
  let cx = sx / n.to_double()
  let cy = sy / n.to_double()
  let mut max_r = 0.0
  let mut min_r = 999999.0
  for pt in contour {
    let (x, y) = pt
    let d = cv_sqrt((x.to_double() - cx) * (x.to_double() - cx) + (y.to_double() - cy) * (y.to_double() - cy))
    if d > max_r {
      max_r = d
    }
    if d < min_r {
      min_r = d
    }
  }
  (cx, cy, max_r, min_r, 0.0)
}

/// 仿射变换 / Warp affine.
pub fn cv_warp_affine(img : CVImage, m : Array[Double]) -> CVImage {
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let sx = m[0] * x.to_double() + m[1] * y.to_double() + m[2]
      let sy = m[3] * x.to_double() + m[4] * y.to_double() + m[5]
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, cv_pixel(img, sx.to_int(), sy.to_int(), c))
      }
    }
  }
  out
}

/// 透视变换 / Warp perspective.
pub fn cv_warp_perspective(img : CVImage, m : Array[Double]) -> CVImage {
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      let w = m[6] * x.to_double() + m[7] * y.to_double() + m[8]
      let w_safe = if w == 0.0 { 0.000001 } else { w }
      let sx = (m[0] * x.to_double() + m[1] * y.to_double() + m[2]) / w_safe
      let sy = (m[3] * x.to_double() + m[4] * y.to_double() + m[5]) / w_safe
      for c in 0..<img.channels {
        cv_set_pixel(out, x, y, c, cv_pixel(img, sx.to_int(), sy.to_int(), c))
      }
    }
  }
  out
}

/// 计算仿射矩阵 / Get affine matrix from 3 point pairs.
pub fn cv_get_affine(
  src : Array[(Double, Double)],
  dst : Array[(Double, Double)]
) -> Array[Double] {
  let m : Array[Double] = []
  for _ in 0..<6 {
    m.push(0.0)
  }
  if src.length() < 3 || dst.length() < 3 {
    return m
  }
  let (sx0, sy0) = src[0]
  let (sx1, sy1) = src[1]
  let (sx2, sy2) = src[2]
  let (dx0, dy0) = dst[0]
  let (dx1, dy1) = dst[1]
  let (dx2, dy2) = dst[2]
  let det = sx0 * (sy1 - sy2) - sx1 * (sy0 - sy2) + sx2 * (sy0 - sy1)
  if cv_abs(det) < 0.000001 {
    return m
  }
  m[0] = (dx0 * (sy1 - sy2) - dx1 * (sy0 - sy2) + dx2 * (sy0 - sy1)) / det
  m[1] = (sx0 * (dx1 - dx2) - sx1 * (dx0 - dx2) + sx2 * (dx0 - dx1)) / det
  m[2] = (sx0 * (sy1 * dx2 - sy2 * dx1) - sx1 * (sy0 * dx2 - sy2 * dx0) + sx2 * (sy0 * dx1 - sy1 * dx0)) / det
  m[3] = (dy0 * (sy1 - sy2) - dy1 * (sy0 - sy2) + dy2 * (sy0 - sy1)) / det
  m[4] = (sx0 * (dy1 - dy2) - sx1 * (dy0 - dy2) + sx2 * (dy0 - dy1)) / det
  m[5] = (sx0 * (sy1 * dy2 - sy2 * dy1) - sx1 * (sy0 * dy2 - sy2 * dy0) + sx2 * (sy0 * dy1 - sy1 * dy0)) / det
  m
}

/// 计算透视矩阵 / Get perspective matrix from 4 point pairs (simplified identity).
pub fn cv_get_perspective(
  src : Array[(Double, Double)],
  dst : Array[(Double, Double)]
) -> Array[Double] {
  let m : Array[Double] = []
  for _ in 0..<9 {
    m.push(0.0)
  }
  if src.length() < 4 || dst.length() < 4 {
    m[0] = 1.0
    m[4] = 1.0
    m[8] = 1.0
    return m
  }
  m[0] = 1.0
  m[4] = 1.0
  m[8] = 1.0
  m[2] = dst[0].0 - src[0].0
  m[5] = dst[0].1 - src[0].1
  m
}

/// 模板匹配 / Template matching (returns best (x, y, score)).
pub fn cv_template_match(img : CVImage, tmpl : CVImage, mode : Int) -> (Int, Int, Double) {
  let mut best_x = 0
  let mut best_y = 0
  let mut best_score = -999999.0
  for y in 0..=(img.height - tmpl.height) {
    for x in 0..=(img.width - tmpl.width) {
      let mut score = 0.0
      for j in 0..<tmpl.height {
        for i in 0..<tmpl.width {
          for c in 0..<tmpl.channels {
            let a = cv_pixel(img, x + i, y + j, c)
            let b = cv_pixel(tmpl, i, j, c)
            if mode == 0 {
              score = score + (a - b) * (a - b)
            } else if mode == 1 {
              score = score + a * b
            } else {
              score = score + cv_abs(a - b)
            }
          }
        }
      }
      if mode == 0 {
        score = -score
      }
      if score > best_score {
        best_score = score
        best_x = x
        best_y = y
      }
    }
  }
  (best_x, best_y, best_score)
}

/// 模板匹配（别名）/ Match template alias.
pub fn cv_match_template(img : CVImage, tmpl : CVImage) -> (Int, Int, Double) {
  cv_template_match(img, tmpl, 1)
}

/// 相关匹配 / Correlation match.
pub fn cv_correlation_match(img : CVImage, tmpl : CVImage) -> Double {
  let (_, _, score) = cv_template_match(img, tmpl, 1)
  let mut img_e = 0.0
  let mut tmpl_e = 0.0
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let v = cv_pixel(img, x, y, c)
        img_e = img_e + v * v
      }
    }
  }
  for y in 0..<tmpl.height {
    for x in 0..<tmpl.width {
      for c in 0..<tmpl.channels {
        let v = cv_pixel(tmpl, x, y, c)
        tmpl_e = tmpl_e + v * v
      }
    }
  }
  let denom = cv_sqrt(img_e * tmpl_e)
  if denom == 0.0 {
    return 0.0
  }
  score / denom
}

/// 直方图 / Histogram.
pub fn cv_histogram(img : CVImage, bins : Int) -> Array[Double] {
  let hist : Array[Double] = []
  for _ in 0..<bins {
    hist.push(0.0)
  }
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let v = cv_pixel(img, x, y, c)
        let idx = (v * bins.to_double() / 256.0).to_int()
        let safe_idx = if idx < 0 { 0 } else if idx >= bins { bins - 1 } else { idx }
        hist[safe_idx] = hist[safe_idx] + 1.0
      }
    }
  }
  hist
}

/// 直方图均衡化 / Histogram equalization.
pub fn cv_hist_equalize(img : CVImage) -> CVImage {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let hist = cv_histogram(gray, 256)
  let total = gray.width.to_double() * gray.height.to_double()
  if total == 0.0 {
    return gray
  }
  let cdf : Array[Double] = []
  let mut acc = 0.0
  for i in 0..<256 {
    acc = acc + hist[i]
    cdf.push(acc / total * 255.0)
  }
  let out = cv_empty(gray.width, gray.height, 1)
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      let v = cv_pixel(gray, x, y, 0).to_int()
      let safe_v = if v < 0 { 0 } else if v > 255 { 255 } else { v }
      cv_set_pixel(out, x, y, 0, cdf[safe_v])
    }
  }
  out
}

/// CLAHE / CLAHE (simplified to equalize).
pub fn cv_clahe(img : CVImage, clip_limit : Double, tile_size : Int) -> CVImage {
  ignore(clip_limit)
  ignore(tile_size)
  cv_hist_equalize(img)
}

/// 腐蚀 / Erode.
pub fn cv_morphology_erode(img : CVImage, ksize : Int) -> CVImage {
  let half = ksize / 2
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let mut min_v = 999999.0
        for dy in -half..=half {
          for dx in -half..=half {
            let v = cv_pixel(img, x + dx, y + dy, c)
            if v < min_v {
              min_v = v
            }
          }
        }
        cv_set_pixel(out, x, y, c, min_v)
      }
    }
  }
  out
}

/// 膨胀 / Dilate.
pub fn cv_morphology_dilate(img : CVImage, ksize : Int) -> CVImage {
  let half = ksize / 2
  let out = cv_empty(img.width, img.height, img.channels)
  for y in 0..<img.height {
    for x in 0..<img.width {
      for c in 0..<img.channels {
        let mut max_v = -999999.0
        for dy in -half..=half {
          for dx in -half..=half {
            let v = cv_pixel(img, x + dx, y + dy, c)
            if v > max_v {
              max_v = v
            }
          }
        }
        cv_set_pixel(out, x, y, c, max_v)
      }
    }
  }
  out
}

/// 开运算 / Morphological open.
pub fn cv_morphology_open(img : CVImage, ksize : Int) -> CVImage {
  cv_morphology_dilate(cv_morphology_erode(img, ksize), ksize)
}

/// 闭运算 / Morphological close.
pub fn cv_morphology_close(img : CVImage, ksize : Int) -> CVImage {
  cv_morphology_erode(cv_morphology_dilate(img, ksize), ksize)
}

/// 连通分量 / Connected components (returns label image).
pub fn cv_connected_components(img : CVImage, connectivity : Int) -> CVImage {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let out = cv_empty(gray.width, gray.height, 1)
  let mut label = 1.0
  let visited : Array[Bool] = []
  for _ in 0..<(gray.width * gray.height) {
    visited.push(false)
  }
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      let idx = y * gray.width + x
      if not(visited[idx]) && cv_pixel(gray, x, y, 0) > 0.0 {
        cv_flood_fill(gray, x, y, label, visited, out, connectivity)
        label = label + 1.0
      }
    }
  }
  out
}

/// 内部洪水填充 / Internal flood fill.
fn cv_flood_fill(
  img : CVImage,
  sx : Int,
  sy : Int,
  label : Double,
  visited : Array[Bool],
  out : CVImage,
  connectivity : Int
) -> Unit {
  let stack : Array[(Int, Int)] = []
  stack.push((sx, sy))
  while stack.length() > 0 {
    let (x, y) = stack[stack.length() - 1]
    ignore(stack.remove(stack.length() - 1))
    if x < 0 || x >= img.width || y < 0 || y >= img.height {
      continue
    }
    let idx = y * img.width + x
    if visited[idx] {
      continue
    }
    if cv_pixel(img, x, y, 0) <= 0.0 {
      continue
    }
    visited[idx] = true
    cv_set_pixel(out, x, y, 0, label)
    stack.push((x + 1, y))
    stack.push((x - 1, y))
    stack.push((x, y + 1))
    stack.push((x, y - 1))
    if connectivity == 8 {
      stack.push((x + 1, y + 1))
      stack.push((x - 1, y - 1))
      stack.push((x + 1, y - 1))
      stack.push((x - 1, y + 1))
    }
  }
}

/// 标记（别名）/ Label (alias).
pub fn cv_label(img : CVImage) -> CVImage {
  cv_connected_components(img, 4)
}

/// 区域属性 / Region properties (returns (count, area, centroid_x, centroid_y)).
pub fn cv_region_props(label_img : CVImage, label : Double) -> (Int, Double, Double, Double) {
  let mut count = 0
  let mut sx = 0.0
  let mut sy = 0.0
  for y in 0..<label_img.height {
    for x in 0..<label_img.width {
      if cv_pixel(label_img, x, y, 0) == label {
        count = count + 1
        sx = sx + x.to_double()
        sy = sy + y.to_double()
      }
    }
  }
  let area = count.to_double()
  let cx = if count > 0 { sx / area } else { 0.0 }
  let cy = if count > 0 { sy / area } else { 0.0 }
  (count, area, cx, cy)
}

/// Harris 角点 / Harris corners (returns list of (x, y, response)).
pub fn cv_corners_harris(img : CVImage, k : Double, threshold : Double) -> Array[(Int, Int, Double)] {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let result : Array[(Int, Int, Double)] = []
  for y in 1..<(gray.height - 1) {
    for x in 1..<(gray.width - 1) {
      let ix = cv_pixel(gray, x + 1, y, 0) - cv_pixel(gray, x - 1, y, 0)
      let iy = cv_pixel(gray, x, y + 1, 0) - cv_pixel(gray, x, y - 1, 0)
      let ixx = ix * ix
      let iyy = iy * iy
      let ixy = ix * iy
      let det = ixx * iyy - ixy * ixy
      let trace = ixx + iyy
      let r = det - k * trace * trace
      if r > threshold {
        result.push((x, y, r))
      }
    }
  }
  result
}

/// GoodFeatures 角点 / Good features to track.
pub fn cv_corners_good(img : CVImage, max_corners : Int, threshold : Double) -> Array[(Int, Int)] {
  let corners = cv_corners_harris(img, 0.04, threshold)
  let result : Array[(Int, Int)] = []
  let n = if corners.length() < max_corners { corners.length() } else { max_corners }
  for i in 0..<n {
    let (x, y, _) = corners[i]
    result.push((x, y))
  }
  result
}

/// FAST 角点 / FAST corners (simplified).
pub fn cv_corners_fast(img : CVImage, threshold : Double) -> Array[(Int, Int)] {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let result : Array[(Int, Int)] = []
  for y in 3..<(gray.height - 3) {
    for x in 3..<(gray.width - 3) {
      let center = cv_pixel(gray, x, y, 0)
      let mut bright = 0
      let circle = [(0, -3), (1, -3), (2, -2), (3, -1), (3, 0), (3, 1), (2, 2), (1, 3), (0, 3), (-1, 3), (-2, 2), (-3, 1), (-3, 0), (-3, -1), (-2, -2), (-1, -3)]
      for pt in circle {
        let (dx, dy) = pt
        if cv_pixel(gray, x + dx, y + dy, 0) > center + threshold {
          bright = bright + 1
        }
      }
      if bright >= 12 {
        result.push((x, y))
      }
    }
  }
  result
}

/// SIFT 特征（简化）/ SIFT features (simplified).
pub fn cv_features_sift_simple(img : CVImage) -> Array[(Int, Int, Double)] {
  cv_corners_harris(img, 0.04, 100.0)
}

/// SURF 特征（简化）/ SURF features (simplified).
pub fn cv_features_surf_simple(img : CVImage) -> Array[(Int, Int, Double)] {
  cv_corners_harris(img, 0.04, 500.0)
}

/// ORB 特征（简化）/ ORB features (simplified).
pub fn cv_features_orb_simple(img : CVImage) -> Array[(Int, Int)] {
  cv_corners_good(img, 500, 100.0)
}

/// 描述子匹配 / Descriptor match.
pub fn cv_descriptors_match(
  desc1 : Array[Array[Double]],
  desc2 : Array[Array[Double]]
) -> Array[(Int, Int)] {
  let result : Array[(Int, Int)] = []
  for i in 0..<desc1.length() {
    let mut best_j = 0
    let mut best_d = 999999.0
    for j in 0..<desc2.length() {
      let mut d = 0.0
      for k in 0..<desc1[i].length() {
        let diff = desc1[i][k] - desc2[j][k]
        d = d + diff * diff
      }
      if d < best_d {
        best_d = d
        best_j = j
      }
    }
    result.push((i, best_j))
  }
  result
}

/// KNN 匹配 / KNN match.
pub fn cv_knn_match(
  desc1 : Array[Array[Double]],
  desc2 : Array[Array[Double]],
  k : Int
) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for i in 0..<desc1.length() {
    let dists : Array[(Int, Double)] = []
    for j in 0..<desc2.length() {
      let mut d = 0.0
      for kk in 0..<desc1[i].length() {
        let diff = desc1[i][kk] - desc2[j][kk]
        d = d + diff * diff
      }
      dists.push((j, d))
    }
    for a in 0..<dists.length() {
      for b in 0..<(dists.length() - 1 - a) {
        if dists[b].1 > dists[b + 1].1 {
          let t = dists[b]
          dists[b] = dists[b + 1]
          dists[b + 1] = t
        }
      }
    }
    let matches : Array[Int] = []
    let cnt = if k < dists.length() { k } else { dists.length() }
    for a in 0..<cnt {
      matches.push(dists[a].0)
    }
    result.push(matches)
  }
  result
}

/// RANSAC / RANSAC (simplified, returns inlier count).
pub fn cv_ransac(
  points1 : Array[(Double, Double)],
  points2 : Array[(Double, Double)],
  threshold : Double,
  iterations : Int
) -> Int {
  let n = points1.length()
  if n < 2 {
    return 0
  }
  let mut best_inliers = 0
  for _ in 0..<iterations {
    let i = 0
    let j = if n > 1 { 1 } else { 0 }
    let (x1, y1) = points1[i]
    let (x2, y2) = points1[j]
    let (u1, v1) = points2[i]
    let (u2, v2) = points2[j]
    let dx = x2 - x1
    let dy = y2 - y1
    let du = u2 - u1
    let dv = v2 - v1
    let mut inliers = 0
    for k in 0..<n {
      let (px, py) = points1[k]
      let (qx, qy) = points2[k]
      let ex = (px - x1) * du / (if dx == 0.0 { 0.000001 } else { dx }) - (qx - u1)
      let ey = (py - y1) * dv / (if dy == 0.0 { 0.000001 } else { dy }) - (qy - v1)
      if cv_sqrt(ex * ex + ey * ey) < threshold {
        inliers = inliers + 1
      }
    }
    if inliers > best_inliers {
      best_inliers = inliers
    }
  }
  best_inliers
}

/// 立体视差 / Stereo disparity.
pub fn cv_stereo_disparity(left : CVImage, right : CVImage, max_disparity : Int) -> CVImage {
  let lg = if left.channels == 1 { left } else { cv_grayscale(left) }
  let rg = if right.channels == 1 { right } else { cv_grayscale(right) }
  let out = cv_empty(lg.width, lg.height, 1)
  for y in 0..<lg.height {
    for x in 0..<lg.width {
      let mut best_d = 0
      let mut best_sad = 999999.0
      for d in 0..=max_disparity {
        let mut sad = 0.0
        for dx in -2..=2 {
          sad = sad + cv_abs(cv_pixel(lg, x + dx, y, 0) - cv_pixel(rg, x + dx - d, y, 0))
        }
        if sad < best_sad {
          best_sad = sad
          best_d = d
        }
      }
      cv_set_pixel(out, x, y, 0, best_d.to_double())
    }
  }
  out
}

/// 深度从立体 / Depth from stereo.
pub fn cv_depth_from_stereo(disparity : CVImage, baseline : Double, focal : Double) -> CVImage {
  let out = cv_empty(disparity.width, disparity.height, 1)
  for y in 0..<disparity.height {
    for x in 0..<disparity.width {
      let d = cv_pixel(disparity, x, y, 0)
      let depth = if d > 0.0 { baseline * focal / d } else { 0.0 }
      cv_set_pixel(out, x, y, 0, depth)
    }
  }
  out
}

/// 点云从深度 / Point cloud from depth.
pub fn cv_point_cloud_from_depth(depth : CVImage, fx : Double, fy : Double, cx : Double, cy : Double) -> Array[(Double, Double, Double)] {
  let result : Array[(Double, Double, Double)] = []
  for y in 0..<depth.height {
    for x in 0..<depth.width {
      let d = cv_pixel(depth, x, y, 0)
      if d > 0.0 {
        let px = (x.to_double() - cx) * d / fx
        let py = (y.to_double() - cy) * d / fy
        result.push((px, py, d))
      }
    }
  }
  result
}

/// 光流 / Optical flow (simplified).
pub fn cv_optical_flow(prev : CVImage, curr : CVImage) -> Array[(Int, Int, Double, Double)] {
  let pg = if prev.channels == 1 { prev } else { cv_grayscale(prev) }
  let cg = if curr.channels == 1 { curr } else { cv_grayscale(curr) }
  let result : Array[(Int, Int, Double, Double)] = []
  for y in 1..<(pg.height - 1) {
    for x in 1..<(pg.width - 1) {
      let ix = cv_pixel(pg, x + 1, y, 0) - cv_pixel(pg, x - 1, y, 0) / 2.0
      let iy = cv_pixel(pg, x, y + 1, 0) - cv_pixel(pg, x, y - 1, 0) / 2.0
      let it = cv_pixel(cg, x, y, 0) - cv_pixel(pg, x, y, 0)
      let denom = ix * ix + iy * iy
      if denom > 0.000001 {
        let u = -ix * it / denom
        let v = -iy * it / denom
        result.push((x, y, u, v))
      }
    }
  }
  result
}

/// Lucas-Kanade 跟踪 / Lucas-Kanade tracking.
pub fn cv_track_lucas_kanade(prev : CVImage, curr : CVImage, points : Array[(Int, Int)]) -> Array[(Int, Int)] {
  let result : Array[(Int, Int)] = []
  let flow = cv_optical_flow(prev, curr)
  for pt in points {
    let (x, y) = pt
    let mut u = 0.0
    let mut v = 0.0
    for f in flow {
      let (fx, fy, fu, fv) = f
      if fx == x && fy == y {
        u = fu
        v = fv
      }
    }
    result.push((x + u.to_int(), y + v.to_int()))
  }
  result
}

/// Farneback 光流 / Farneback optical flow (simplified).
pub fn cv_track_farneback(prev : CVImage, curr : CVImage) -> Array[(Int, Int, Double, Double)] {
  cv_optical_flow(prev, curr)
}

/// Haar 检测 / Haar object detection (placeholder).
pub fn cv_object_detect_haar(img : CVImage, scale_factor : Double, min_neighbors : Int) -> Array[(Int, Int, Int, Int)] {
  let result : Array[(Int, Int, Int, Int)] = []
  ignore(scale_factor)
  ignore(min_neighbors)
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let mut sum = 0.0
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      sum = sum + cv_pixel(gray, x, y, 0)
    }
  }
  let mean = if gray.width * gray.height > 0 { sum / (gray.width * gray.height).to_double() } else { 0.0 }
  if mean > 100.0 {
    result.push((gray.width / 4, gray.height / 4, gray.width / 2, gray.height / 2))
  }
  result
}

/// HOG 检测 / HOG object detection (placeholder).
pub fn cv_object_detect_hog(img : CVImage) -> Array[(Int, Int, Int, Int)] {
  let result : Array[(Int, Int, Int, Int)] = []
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let gx = cv_sobel(gray, 1, 0, 3)
  let gy = cv_sobel(gray, 0, 1, 3)
  let mut mag_sum = 0.0
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      mag_sum = mag_sum + cv_sqrt(cv_pixel(gx, x, y, 0) * cv_pixel(gx, x, y, 0) + cv_pixel(gy, x, y, 0) * cv_pixel(gy, x, y, 0))
    }
  }
  if mag_sum > 1000.0 {
    result.push((0, 0, gray.width, gray.height))
  }
  result
}

/// NMS / Non-maximum suppression.
pub fn cv_nms(boxes : Array[(Int, Int, Int, Int)], scores : Array[Double], threshold : Double) -> Array[Int] {
  let n = boxes.length()
  let indices : Array[Int] = []
  for i in 0..<n {
    indices.push(i)
  }
  for i in 0..<n {
    for j in 0..<(n - 1 - i) {
      if scores[indices[j]] < scores[indices[j + 1]] {
        let t = indices[j]
        indices[j] = indices[j + 1]
        indices[j + 1] = t
      }
    }
  }
  let keep : Array[Int] = []
  let suppressed : Array[Bool] = []
  for _ in 0..<n {
    suppressed.push(false)
  }
  for i in 0..<n {
    if suppressed[indices[i]] {
      continue
    }
    keep.push(indices[i])
    for j in (i + 1)..<n {
      if suppressed[indices[j]] {
        continue
      }
      let iou = cv_iou(boxes[indices[i]], boxes[indices[j]])
      if iou > threshold {
        suppressed[indices[j]] = true
      }
    }
  }
  keep
}

/// 内部 IoU / Internal IoU.
fn cv_iou(a : (Int, Int, Int, Int), b : (Int, Int, Int, Int)) -> Double {
  let (ax, ay, aw, ah) = a
  let (bx, by, bw, bh) = b
  let x1 = cv_max(ax.to_double(), bx.to_double())
  let y1 = cv_max(ay.to_double(), by.to_double())
  let x2 = cv_min((ax + aw).to_double(), (bx + bw).to_double())
  let y2 = cv_min((ay + ah).to_double(), (by + bh).to_double())
  let inter = cv_max(0.0, x2 - x1) * cv_max(0.0, y2 - y1)
  let area_a = (aw * ah).to_double()
  let area_b = (bw * bh).to_double()
  let union_ = area_a + area_b - inter
  if union_ <= 0.0 {
    return 0.0
  }
  inter / union_
}

/// 简单分类 / Simple classification (returns class id).
pub fn cv_classification_simple(img : CVImage, num_classes : Int) -> Int {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let mut sum = 0.0
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      sum = sum + cv_pixel(gray, x, y, 0)
    }
  }
  let mean = if gray.width * gray.height > 0 { sum / (gray.width * gray.height).to_double() } else { 0.0 }
  let cls = (mean / 256.0 * num_classes.to_double()).to_int()
  if cls < 0 {
    0
  } else if cls >= num_classes {
    num_classes - 1
  } else {
    cls
  }
}

/// 简单分割 / Simple segmentation (k-means-like).
pub fn cv_segmentation_simple(img : CVImage, k : Int) -> CVImage {
  let gray = if img.channels == 1 { img } else { cv_grayscale(img) }
  let out = cv_empty(gray.width, gray.height, 1)
  let step = 256.0 / k.to_double()
  for y in 0..<gray.height {
    for x in 0..<gray.width {
      let v = cv_pixel(gray, x, y, 0)
      let label = (v / step).to_int()
      let safe_label = if label >= k { k - 1 } else if label < 0 { 0 } else { label }
      cv_set_pixel(out, x, y, 0, safe_label.to_double())
    }
  }
  out
}

/// 简单检测 / Simple detection.
pub fn cv_detection_simple(img : CVImage, threshold : Double) -> Array[(Int, Int, Int, Int)] {
  let edges = cv_canny(img, threshold / 2.0, threshold)
  let result : Array[(Int, Int, Int, Int)] = []
  let mut min_x = edges.width
  let mut max_x = 0
  let mut min_y = edges.height
  let mut max_y = 0
  let mut found = false
  for y in 0..<edges.height {
    for x in 0..<edges.width {
      if cv_pixel(edges, x, y, 0) > 0.0 {
        found = true
        if x < min_x {
          min_x = x
        }
        if x > max_x {
          max_x = x
        }
        if y < min_y {
          min_y = y
        }
        if y > max_y {
          max_y = y
        }
      }
    }
  }
  if found {
    result.push((min_x, min_y, max_x - min_x + 1, max_y - min_y + 1))
  }
  result
}

/// PSNR / Peak signal-to-noise ratio.
pub fn cv_psnr(img1 : CVImage, img2 : CVImage) -> Double {
  let mse = cv_mse_cv(img1, img2)
  if mse == 0.0 {
    return 999.0
  }
  10.0 * cv_ln(255.0 * 255.0 / mse) / 2.302585092994046
}

/// SSIM / Structural similarity index.
pub fn cv_ssim(img1 : CVImage, img2 : CVImage) -> Double {
  let g1 = if img1.channels == 1 { img1 } else { cv_grayscale(img1) }
  let g2 = if img2.channels == 1 { img2 } else { cv_grayscale(img2) }
  let n = g1.width * g1.height
  if n == 0 {
    return 0.0
  }
  let mut sum1 = 0.0
  let mut sum2 = 0.0
  let mut sum12 = 0.0
  let mut sum11 = 0.0
  let mut sum22 = 0.0
  for y in 0..<g1.height {
    for x in 0..<g1.width {
      let a = cv_pixel(g1, x, y, 0)
      let b = cv_pixel(g2, x, y, 0)
      sum1 = sum1 + a
      sum2 = sum2 + b
      sum12 = sum12 + a * b
      sum11 = sum11 + a * a
      sum22 = sum22 + b * b
    }
  }
  let nd = n.to_double()
  let mu1 = sum1 / nd
  let mu2 = sum2 / nd
  let sigma1 = sum11 / nd - mu1 * mu1
  let sigma2 = sum22 / nd - mu2 * mu2
  let sigma12 = sum12 / nd - mu1 * mu2
  let c1 = 6.5025
  let c2 = 58.5225
  ((2.0 * mu1 * mu2 + c1) * (2.0 * sigma12 + c2)) / ((mu1 * mu1 + mu2 * mu2 + c1) * (sigma1 + sigma2 + c2))
}

/// MSE / Mean squared error.
pub fn cv_mse_cv(img1 : CVImage, img2 : CVImage) -> Double {
  let n = img1.width * img1.height * img1.channels
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for y in 0..<img1.height {
    for x in 0..<img1.width {
      for c in 0..<img1.channels {
        let diff = cv_pixel(img1, x, y, c) - cv_pixel(img2, x, y, c)
        sum = sum + diff * diff
      }
    }
  }
  sum / n.to_double()
}

/// CV 模块 ID / CV module id.
pub fn computer_vision_id() -> String {
  "opcore/computer_vision"
}