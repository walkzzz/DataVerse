///|
/// # opcore/image 图像算子 / Image Operators
///
/// 图像元数据算子：尺寸、宽高比、缩放、裁剪。架构 §4.3.2 ⑦ Transform（多模态）。
/// S2.1 填充：元数据驱动（MoonBit 无真实图像解码，操作 ImageMeta 结构体）。
/// 对标 DJ image_size / aspect_ratio_filter / image_captioning_mapper（P3 多模态）。
///
/// # Image operators
///
/// Metadata-driven image operators. See architecture §4.3.2 ⑦.

/// 图像元数据 / Image metadata.
pub struct ImageMeta {
  width : Int
  height : Int
  channels : Int
  format : String
} derive(Debug, Eq)

pub extend ImageMeta with Eq::{equal, not_equal}
pub extend ImageMeta with Debug::{to_repr}

/// 构造图像元数据 / Build image metadata.
pub fn make_image_meta(width : Int, height : Int, channels : Int, format : String) -> ImageMeta {
  { width, height, channels, format }
}

/// 空图像元数据（退化安全）/ Empty image metadata (degenerate-safe).
pub fn empty_image_meta() -> ImageMeta {
  { width: 0, height: 0, channels: 0, format: "" }
}

/// 图像尺寸 / Image size (width, height).
pub fn image_size(meta : ImageMeta) -> (Int, Int) {
  (meta.width, meta.height)
}

/// 宽高比 / Aspect ratio (width / height).
///
/// 退化安全：height=0 返回 0.0。
pub fn aspect_ratio(meta : ImageMeta) -> Double {
  if meta.height == 0 {
    0.0
  } else {
    meta.width.to_double() / meta.height.to_double()
  }
}

/// 宽高比过滤 / Aspect ratio filter.
///
/// 判断 aspect_ratio 是否在 [min_ratio, max_ratio] 范围内。
/// 退化安全：height=0 返回 false。
pub fn aspect_ratio_filter(meta : ImageMeta, min_ratio : Double, max_ratio : Double) -> Bool {
  let r = aspect_ratio(meta)
  r >= min_ratio && r <= max_ratio
}

/// 图像缩放 / Image resize.
///
/// 返回新尺寸的 ImageMeta，channels 和 format 不变。
/// 退化安全：new_width/new_height 为负时取 0。
pub fn image_resize(meta : ImageMeta, new_width : Int, new_height : Int) -> ImageMeta {
  let w = if new_width < 0 { 0 } else { new_width }
  let h = if new_height < 0 { 0 } else { new_height }
  { width: w, height: h, channels: meta.channels, format: meta.format }
}

/// 图像裁剪 / Image crop.
///
/// 从 (x, y) 起裁剪 w×h 区域。返回裁剪后的 ImageMeta。
/// 退化安全：越界时裁剪到边界，负值取 0。
pub fn image_crop(meta : ImageMeta, x : Int, y : Int, w : Int, h : Int) -> ImageMeta {
  let x0 = if x < 0 { 0 } else { x }
  let y0 = if y < 0 { 0 } else { y }
  let w0 = if w < 0 { 0 } else { w }
  let h0 = if h < 0 { 0 } else { h }
  let avail_w = meta.width - x0
  let avail_h = meta.height - y0
  let crop_w = if w0 > avail_w { avail_w } else { w0 }
  let crop_h = if h0 > avail_h { avail_h } else { h0 }
  let final_w = if crop_w < 0 { 0 } else { crop_w }
  let final_h = if crop_h < 0 { 0 } else { crop_h }
  { width: final_w, height: final_h, channels: meta.channels, format: meta.format }
}

/// 图像元数据转 DataObject / Convert image metadata to DataObject.
pub fn image_to_dataobject(meta : ImageMeta) -> @dataobject.DataObject {
  let content = "image:" + meta.format.to_string() + ":" + meta.width.to_string() + "x" + meta.height.to_string() + "x" + meta.channels.to_string()
  @dataobject.make_dataobject(content, @dataobject.Image, @schema.empty())
}

pub fn image_id() -> String {
  "opcore/image"
}
// ============================================================
// S2.10 图像翻转与旋转 / Image flip and rotate
// ============================================================

/// 翻转轴 / Flip axis.
pub(all) enum FlipAxis {
  Horizontal
  Vertical
  Both
} derive(Debug, Eq)

pub extend FlipAxis with Eq::{equal, not_equal}
pub extend FlipAxis with Debug::{to_repr}

/// 旋转角度 / Rotation angle (90-degree increments).
pub(all) enum RotateAngle {
  D90
  D180
  D270
} derive(Debug, Eq)

pub extend RotateAngle with Eq::{equal, not_equal}
pub extend RotateAngle with Debug::{to_repr}

/// 图像翻转 / Image flip.
///
/// 翻转不改变尺寸，返回同尺寸 ImageMeta。
/// 退化安全：空图像返回空图像。
pub fn image_flip(meta : ImageMeta, axis : FlipAxis) -> ImageMeta {
  ignore(axis)
  { width: meta.width, height: meta.height, channels: meta.channels, format: meta.format }
}

/// 图像旋转 / Image rotate.
///
/// D90/D270 交换 width 和 height，D180 保持不变。
/// 退化安全：空图像返回空图像。
pub fn image_rotate(meta : ImageMeta, angle : RotateAngle) -> ImageMeta {
  match angle {
    D90 => { width: meta.height, height: meta.width, channels: meta.channels, format: meta.format }
    D180 => { width: meta.width, height: meta.height, channels: meta.channels, format: meta.format }
    D270 => { width: meta.height, height: meta.width, channels: meta.channels, format: meta.format }
  }
}

/// 翻转轴名称 / Flip axis name.
pub fn flip_axis_name(axis : FlipAxis) -> String {
  match axis {
    Horizontal => "horizontal"
    Vertical => "vertical"
    Both => "both"
  }
}

/// 旋转角度名称 / Rotation angle name.
pub fn rotate_angle_name(angle : RotateAngle) -> String {
  match angle {
    D90 => "90"
    D180 => "180"
    D270 => "270"
  }
}
///===
/// S9.1 图像处理深化 / Image Processing Deepening

/// 图像（灰度像素数组，行优先）/ Grayscale image (row-major pixel array).
pub struct GrayImage {
  width : Int
  height : Int
  pixels : Array[Double]
}

/// 构造灰度图像 / Create grayscale image.
pub fn make_gray_image(
  width : Int,
  height : Int,
  pixels : Array[Double],
) -> GrayImage {
  { width: width, height: height, pixels: pixels }
}

/// 安全获取像素 / Safe pixel access.
fn get_pixel(img : GrayImage, row : Int, col : Int) -> Double {
  if row < 0 || row >= img.height || col < 0 || col >= img.width {
    return 0.0
  }
  img.pixels[row * img.width + col]
}

/// 图像最小值 / Image min pixel value.
pub fn image_min(img : GrayImage) -> Double {
  if img.pixels.length() == 0 {
    return 0.0
  }
  let mut min_val = img.pixels[0]
  for i in 1..<img.pixels.length() {
    if img.pixels[i] < min_val {
      min_val = img.pixels[i]
    }
  }
  min_val
}

/// 图像最大值 / Image max pixel value.
pub fn image_max(img : GrayImage) -> Double {
  if img.pixels.length() == 0 {
    return 0.0
  }
  let mut max_val = img.pixels[0]
  for i in 1..<img.pixels.length() {
    if img.pixels[i] > max_val {
      max_val = img.pixels[i]
    }
  }
  max_val
}

/// 图像均值 / Image mean pixel value.
pub fn image_mean(img : GrayImage) -> Double {
  let n = img.pixels.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + img.pixels[i]
  }
  sum / n.to_double()
}

/// 图像标准差 / Image standard deviation.
pub fn image_std(img : GrayImage) -> Double {
  let n = img.pixels.length()
  if n == 0 {
    return 0.0
  }
  let mean = image_mean(img)
  let mut variance = 0.0
  for i in 0..<n {
    let diff = img.pixels[i] - mean
    variance = variance + diff * diff
  }
  (variance / n.to_double()).sqrt()
}

/// 亮度调整 / Adjust brightness.
pub fn adjust_brightness(img : GrayImage, delta : Double) -> GrayImage {
  let result : Array[Double] = []
  for i in 0..<img.pixels.length() {
    let v = img.pixels[i] + delta
    let clamped = if v < 0.0 { 0.0 } else if v > 255.0 { 255.0 } else { v }
    result.push(clamped)
  }
  { width: img.width, height: img.height, pixels: result }
}

/// 对比度调整 / Adjust contrast.
pub fn adjust_contrast(img : GrayImage, factor : Double) -> GrayImage {
  let mean = image_mean(img)
  let result : Array[Double] = []
  for i in 0..<img.pixels.length() {
    let v = mean + (img.pixels[i] - mean) * factor
    let clamped = if v < 0.0 { 0.0 } else if v > 255.0 { 255.0 } else { v }
    result.push(clamped)
  }
  { width: img.width, height: img.height, pixels: result }
}

/// 伽马校正 / Gamma correction.
pub fn gamma_correction(img : GrayImage, gamma : Double) -> GrayImage {
  let result : Array[Double] = []
  for i in 0..<img.pixels.length() {
    let normalized = img.pixels[i] / 255.0
    let corrected = pow_double(normalized, gamma) * 255.0
    result.push(corrected)
  }
  { width: img.width, height: img.height, pixels: result }
}

/// 幂运算 / Power function (for gamma correction).
fn pow_double(base : Double, exp : Double) -> Double {
  if base <= 0.0 {
    return 0.0
  }
  let log_base = ln_(base)
  exp_(exp * log_base)
}

/// 自然对数 / Natural log.
fn ln_(x : Double) -> Double {
  if x <= 0.0 {
    return -999999.0
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

/// 指数 / Exponential.
fn exp_(x : Double) -> Double {
  if x > 20.0 {
    return 485165195.4
  }
  if x < -20.0 {
    return 0.0
  }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<50 {
    term = term * x / i.to_double()
    result = result + term
  }
  result
}

/// 二值化阈值 / Binary threshold.
pub fn threshold(img : GrayImage, thresh : Double) -> GrayImage {
  let result : Array[Double] = []
  for i in 0..<img.pixels.length() {
    if img.pixels[i] >= thresh {
      result.push(255.0)
    } else {
      result.push(0.0)
    }
  }
  { width: img.width, height: img.height, pixels: result }
}

/// 直方图 / Histogram (256 bins).
pub fn histogram(img : GrayImage) -> Array[Int] {
  let hist : Array[Int] = Array::make(256, 0)
  for i in 0..<img.pixels.length() {
    let bin = img.pixels[i].to_int()
    let idx = if bin < 0 { 0 } else if bin > 255 { 255 } else { bin }
    hist[idx] = hist[idx] + 1
  }
  hist
}

/// 均值滤波 / Mean filter (3x3).
pub fn mean_filter(img : GrayImage) -> GrayImage {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let mut sum = 0.0
      let mut count = 0
      for dr in -1..=1 {
        for dc in -1..=1 {
          sum = sum + get_pixel(img, r + dr, c + dc)
          count = count + 1
        }
      }
      result.push(sum / count.to_double())
    }
  }
  { width: img.width, height: img.height, pixels: result }
}

/// 中值滤波 / Median filter (3x3).
pub fn median_filter(img : GrayImage) -> GrayImage {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let vals : Array[Double] = []
      for dr in -1..=1 {
        for dc in -1..=1 {
          vals.push(get_pixel(img, r + dr, c + dc))
        }
      }
      vals.sort_by(fn(a, b) { if a < b { -1 } else if a > b { 1 } else { 0 } })
      result.push(vals[4])
    }
  }
  { width: img.width, height: img.height, pixels: result }
}

/// Sobel X 梯度 / Sobel X gradient.
pub fn sobel_x(img : GrayImage) -> GrayImage {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let gx = -get_pixel(img, r - 1, c - 1) + get_pixel(img, r - 1, c + 1) - 2.0 * get_pixel(img, r, c - 1) + 2.0 * get_pixel(img, r, c + 1) - get_pixel(img, r + 1, c - 1) + get_pixel(img, r + 1, c + 1)
      result.push(gx)
    }
  }
  { width: img.width, height: img.height, pixels: result }
}

/// Sobel Y 梯度 / Sobel Y gradient.
pub fn sobel_y(img : GrayImage) -> GrayImage {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let gy = -get_pixel(img, r - 1, c - 1) - 2.0 * get_pixel(img, r - 1, c) - get_pixel(img, r - 1, c + 1) + get_pixel(img, r + 1, c - 1) + 2.0 * get_pixel(img, r + 1, c) + get_pixel(img, r + 1, c + 1)
      result.push(gy)
    }
  }
  { width: img.width, height: img.height, pixels: result }
}

/// 边缘强度 / Edge magnitude from Sobel.
pub fn edge_magnitude(img : GrayImage) -> GrayImage {
  let gx = sobel_x(img)
  let gy = sobel_y(img)
  let result : Array[Double] = []
  for i in 0..<img.pixels.length() {
    result.push((gx.pixels[i] * gx.pixels[i] + gy.pixels[i] * gy.pixels[i]).sqrt())
  }
  { width: img.width, height: img.height, pixels: result }
}

/// 下采样 / Downsample (2x).
pub fn downsample(img : GrayImage) -> GrayImage {
  let new_w = img.width / 2
  let new_h = img.height / 2
  let result : Array[Double] = []
  for r in 0..<new_h {
    for c in 0..<new_w {
      result.push(get_pixel(img, r * 2, c * 2))
    }
  }
  { width: new_w, height: new_h, pixels: result }
}

/// 膨胀 / Morphological dilate (3x3 max filter).
pub fn dilate(img : GrayImage) -> GrayImage {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let mut max_val = 0.0
      for dr in -1..=1 {
        for dc in -1..=1 {
          let v = get_pixel(img, r + dr, c + dc)
          if v > max_val {
            max_val = v
          }
        }
      }
      result.push(max_val)
    }
  }
  { width: img.width, height: img.height, pixels: result }
}

/// 腐蚀 / Morphological erode (3x3 min filter).
pub fn erode(img : GrayImage) -> GrayImage {
  let result : Array[Double] = []
  for r in 0..<img.height {
    for c in 0..<img.width {
      let mut min_val = 999999.0
      for dr in -1..=1 {
        for dc in -1..=1 {
          let v = get_pixel(img, r + dr, c + dc)
          if v < min_val {
            min_val = v
          }
        }
      }
      result.push(min_val)
    }
  }
  { width: img.width, height: img.height, pixels: result }
}

/// RGB → 灰度 / RGB to grayscale.
pub fn rgb_to_gray(
  width : Int,
  height : Int,
  rgb : Array[(Double, Double, Double)],
) -> GrayImage {
  let result : Array[Double] = []
  for i in 0..<rgb.length() {
    let (r, g, b) = rgb[i]
    result.push(0.299 * r + 0.587 * g + 0.114 * b)
  }
  { width: width, height: height, pixels: result }
}
