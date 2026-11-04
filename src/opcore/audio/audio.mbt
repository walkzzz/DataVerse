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

///|
/// 音频元数据 / Audio metadata.
pub struct AudioMeta {
  duration_ms : Int32
  sample_rate : Int32
  channels : Int32
  format : String
} derive(Debug, Eq)

///|
pub extend AudioMeta with Eq::{equal, not_equal}

///|
pub extend AudioMeta with Debug::{to_repr}

///|
/// 构造音频元数据 / Build audio metadata.
pub fn audio_make_audio_meta(
  duration_ms : Int32,
  sample_rate : Int32,
  channels : Int32,
  format : String,
) -> AudioMeta {
  { duration_ms, sample_rate, channels, format, }
}

///|
/// 空音频元数据（退化安全）/ Empty audio metadata (degenerate-safe).
pub fn audio_empty_audio_meta() -> AudioMeta {
  { duration_ms: 0, sample_rate: 0, channels: 0, format: "", }
}

///|
/// 音频时长（毫秒）/ Audio duration in milliseconds.
pub fn audio_audio_duration(meta : AudioMeta) -> Int32 {
  meta.duration_ms
}

///|
/// 采样率过滤 / Sample rate filter.
///
/// 判断 sample_rate 是否在 [min_sr, max_sr] 范围内。
pub fn audio_sample_rate_filter(
  meta : AudioMeta,
  min_sr : Int32,
  max_sr : Int32,
) -> Bool {
  meta.sample_rate >= min_sr && meta.sample_rate <= max_sr
}

///|
/// 音频分段 / Audio segment.
///
/// 截取 [start_ms, end_ms] 时间段。返回新 AudioMeta。
/// 退化安全：越界截断到边界，负值取 0。
pub fn audio_audio_segment(
  meta : AudioMeta,
  start_ms : Int32,
  end_ms : Int32,
) -> AudioMeta {
  let s = if start_ms < 0 { 0 } else { start_ms }
  let e = if end_ms > meta.duration_ms { meta.duration_ms } else { end_ms }
  let dur = if e > s { e - s } else { 0 }
  {
    duration_ms: dur,
    sample_rate: meta.sample_rate,
    channels: meta.channels,
    format: meta.format,
  }
}

///|
/// 音频元数据转 DataObject / Convert audio metadata to DataObject.
pub fn audio_audio_to_dataobject(meta : AudioMeta) -> @dataobject.DataObject {
  let content = "audio:" +
    meta.format.to_string() +
    ":" +
    meta.duration_ms.to_string() +
    "ms@" +
    meta.sample_rate.to_string() +
    "Hz"
  @dataobject.make_dataobject(content, @dataobject.Audio, @schema.empty())
}

///|
pub fn audio_audio_id() -> String {
  "opcore/audio"
}
// ============================================================
// S2.10 音频混合 / Audio mix
// ============================================================

///|
/// 音频混合 / Audio mix.
///
/// 混合两路音频，weight_a 为第一路权重（[0,1]）。
/// 结果：duration = max(a, b)，sample_rate = a 的（退化时取 b），channels = max(a, b)。
/// 退化安全：空音频（duration=0）被忽略。
pub fn audio_audio_mix(
  meta_a : AudioMeta,
  meta_b : AudioMeta,
  weight_a : Double,
) -> AudioMeta {
  let dur = if meta_a.duration_ms > meta_b.duration_ms {
    meta_a.duration_ms
  } else {
    meta_b.duration_ms
  }
  let sr = if meta_a.sample_rate > 0 {
    meta_a.sample_rate
  } else {
    meta_b.sample_rate
  }
  let ch = if meta_a.channels > meta_b.channels {
    meta_a.channels
  } else {
    meta_b.channels
  }
  let fmt = if meta_a.format.length() > 0 {
    meta_a.format
  } else {
    meta_b.format
  }
  ignore(weight_a)
  { duration_ms: dur, sample_rate: sr, channels: ch, format: fmt, }
}

///|
/// 音频归一化时长 / Normalize audio duration.
///
/// 将时长归一化到 [0, max_ms] 范围，返回归一化后的比例（[0,1]）。
/// 退化安全：max_ms=0 返回 0.0。
pub fn audio_audio_normalize_duration(meta : AudioMeta, max_ms : Int32) -> Double {
  if max_ms == 0 {
    0.0
  } else {
    let r = meta.duration_ms.to_double() / max_ms.to_double()
    if r > 1.0 {
      1.0
    } else if r < 0.0 {
      0.0
    } else {
      r
    }
  }
}
