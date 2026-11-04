///|
/// # opcore/video 视频算子 / Video Operators
///
/// 视频元数据算子：时长、帧数、帧采样。架构 §4.3.2 ⑦ Transform（多模态）。
/// S2.1 填充：元数据驱动（MoonBit 无真实视频解码，操作 VideoMeta 结构体）。
/// 对标 DJ video_duration_filter / frame_count_filter。
///
/// # Video operators
///
/// Metadata-driven video operators. See architecture §4.3.2 ⑦.

///|
/// 视频元数据 / Video metadata.
pub struct VideoMeta {
  duration_ms : Int32
  fps : Int32
  width : Int32
  height : Int32
  format : String
} derive(Debug, Eq)

///|
pub extend VideoMeta with Eq::{equal, not_equal}

///|
pub extend VideoMeta with Debug::{to_repr}

///|
/// 构造视频元数据 / Build video metadata.
pub fn video_make_video_meta(
  duration_ms : Int32,
  fps : Int32,
  width : Int32,
  height : Int32,
  format : String,
) -> VideoMeta {
  { duration_ms, fps, width, height, format, }
}

///|
/// 空视频元数据（退化安全）/ Empty video metadata (degenerate-safe).
pub fn video_empty_video_meta() -> VideoMeta {
  { duration_ms: 0, fps: 0, width: 0, height: 0, format: "", }
}

///|
/// 视频时长（毫秒）/ Video duration in milliseconds.
pub fn video_video_duration(meta : VideoMeta) -> Int32 {
  meta.duration_ms
}

///|
/// 帧数 / Frame count.
///
/// 公式：`duration_ms * fps / 1000`。
/// 退化安全：fps=0 或 duration_ms=0 返回 0。
pub fn video_frame_count(meta : VideoMeta) -> Int32 {
  meta.duration_ms * meta.fps / 1000
}

///|
/// 帧采样时间戳 / Sample frame timestamps.
///
/// 每 interval_ms 毫秒采样一帧，返回时间戳数组（毫秒）。
/// 退化安全：interval_ms <= 0 返回空数组。
pub fn video_video_sample_frames(
  meta : VideoMeta,
  interval_ms : Int32,
) -> Array[Int32] {
  if interval_ms <= 0 || meta.duration_ms <= 0 {
    []
  } else {
    let result = []
    let mut t = 0
    while t < meta.duration_ms {
      result.push(t)
      t = t + interval_ms
    }
    result
  }
}

///|
/// 视频元数据转 DataObject / Convert video metadata to DataObject.
pub fn video_video_to_dataobject(meta : VideoMeta) -> @dataobject.DataObject {
  let content = "video:" +
    meta.format.to_string() +
    ":" +
    meta.duration_ms.to_string() +
    "ms@" +
    meta.fps.to_string() +
    "fps" +
    meta.width.to_string() +
    "x" +
    meta.height.to_string()
  @dataobject.make_dataobject(content, @dataobject.Video, @schema.empty())
}

///|
pub fn video_video_id() -> String {
  "opcore/video"
}
// ============================================================
// S2.10 视频抽帧 / Video frame extraction
// ============================================================

///|
/// 视频抽帧 / Extract frames from video.
///
/// 均匀抽取 count 帧，返回 ImageMeta 数组（每帧 w×h×3 RGB）。
/// 退化安全：count<=0 返回空数组，duration<=0 返回空数组。
pub fn video_video_extract_frames(
  meta : VideoMeta,
  count : Int32,
) -> Array[@image.ImageMeta] {
  if count <= 0 || meta.duration_ms <= 0 {
    []
  } else {
    let result = []
    let step = meta.duration_ms / count
    let mut t = 0
    for i in 0..<count {
      ignore(i)
      result.push(@image.image_make_image_meta(meta.width, meta.height, 3, "rgb"))
      t = t + step
    }
    ignore(t)
    result
  }
}

///|
/// 视频抽帧时间戳 / Extract frame timestamps.
///
/// 均匀抽取 count 帧的时间戳（毫秒）。
/// 退化安全：count<=0 返回空数组。
pub fn video_video_frame_timestamps(meta : VideoMeta, count : Int32) -> Array[Int32] {
  if count <= 0 || meta.duration_ms <= 0 {
    []
  } else {
    let result = []
    let step = meta.duration_ms / count
    let mut t = 0
    for i in 0..<count {
      ignore(i)
      result.push(t)
      t = t + step
    }
    result
  }
}

///|
/// 视频裁剪 / Video trim.
///
/// 裁剪 [start_ms, end_ms] 时间段，返回新 VideoMeta。
/// 退化安全：越界截断到边界，负值取 0。
pub fn video_video_trim(
  meta : VideoMeta,
  start_ms : Int32,
  end_ms : Int32,
) -> VideoMeta {
  let s = if start_ms < 0 { 0 } else { start_ms }
  let e = if end_ms > meta.duration_ms { meta.duration_ms } else { end_ms }
  let dur = if e > s { e - s } else { 0 }
  {
    duration_ms: dur,
    fps: meta.fps,
    width: meta.width,
    height: meta.height,
    format: meta.format,
  }
}
