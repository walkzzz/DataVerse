///|
/// # opcore/audio 音频算子 / Audio Operators
///
/// 音频元数据算子：时长、采样率、分段。架构 §4.3.2 ⑦ Transform（多模态）。
/// S2.1 填充：元数据驱动（MoonBit 无真实音频解码，操作 AudioMeta 结构体）。
/// 对标 DJ audio_duration_filter / sample_rate_filter。
///
/// # Audio operators
///
/// Metadata-driven audio operators. See architecture §4.3.2 ⑦.

/// 音频元数据 / Audio metadata.
pub struct AudioMeta {
  duration_ms : Int
  sample_rate : Int
  channels : Int
  format : String
} derive(Debug, Eq)

pub extend AudioMeta with Eq::{equal, not_equal}
pub extend AudioMeta with Debug::{to_repr}

/// 构造音频元数据 / Build audio metadata.
pub fn make_audio_meta(duration_ms : Int, sample_rate : Int, channels : Int, format : String) -> AudioMeta {
  { duration_ms, sample_rate, channels, format }
}

/// 空音频元数据（退化安全）/ Empty audio metadata (degenerate-safe).
pub fn empty_audio_meta() -> AudioMeta {
  { duration_ms: 0, sample_rate: 0, channels: 0, format: "" }
}

/// 音频时长（毫秒）/ Audio duration in milliseconds.
pub fn audio_duration(meta : AudioMeta) -> Int {
  meta.duration_ms
}

/// 采样率过滤 / Sample rate filter.
///
/// 判断 sample_rate 是否在 [min_sr, max_sr] 范围内。
pub fn sample_rate_filter(meta : AudioMeta, min_sr : Int, max_sr : Int) -> Bool {
  meta.sample_rate >= min_sr && meta.sample_rate <= max_sr
}

/// 音频分段 / Audio segment.
///
/// 截取 [start_ms, end_ms] 时间段。返回新 AudioMeta。
/// 退化安全：越界截断到边界，负值取 0。
pub fn audio_segment(meta : AudioMeta, start_ms : Int, end_ms : Int) -> AudioMeta {
  let s = if start_ms < 0 { 0 } else { start_ms }
  let e = if end_ms > meta.duration_ms { meta.duration_ms } else { end_ms }
  let dur = if e > s { e - s } else { 0 }
  { duration_ms: dur, sample_rate: meta.sample_rate, channels: meta.channels, format: meta.format }
}

/// 音频元数据转 DataObject / Convert audio metadata to DataObject.
pub fn audio_to_dataobject(meta : AudioMeta) -> @dataobject.DataObject {
  let content = "audio:" + meta.format.to_string() + ":" + meta.duration_ms.to_string() + "ms@" + meta.sample_rate.to_string() + "Hz"
  @dataobject.make_dataobject(content, @dataobject.Audio, @schema.empty())
}

pub fn audio_id() -> String {
  "opcore/audio"
}