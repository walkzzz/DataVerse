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