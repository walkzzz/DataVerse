///|
/// # datatemporal 数据时空·版本·血缘 / Data Temporal
///
/// 把"数据的第 4 维"（版本/时间）做成一等维度。
/// 架构 §4.4。S0.5 数据结构定型：Fingerprint + version/lineage/drift/replay。
///
/// # Data temporal: version / lineage / drift / replay
///
/// Makes the "4th dimension" (version/time) first-class. See architecture §4.4.

///|
/// 内容指纹 / Content fingerprint.
///
/// S0.5 占位哈希（长度 + 前缀）；后续替换为 SHA-256 截断。
pub struct Fingerprint {
  content_hash : String
  algorithm : String
} derive(Debug, Eq)

///|
pub extend Fingerprint with Eq::{equal, not_equal}

///|
pub extend Fingerprint with Debug::{to_repr}

///|
/// 构造指纹（占位哈希）/ Build a fingerprint (placeholder hash).
///
/// S0.5 占位：`"fp:<length>"`。后续替换为真实内容哈希。
pub fn make_fingerprint(content : String) -> Fingerprint {
  {
    content_hash: "fp:" + content.length().to_string(),
    algorithm: "placeholder",
  }
}

///|
/// 空指纹 / Empty fingerprint (degenerate-safe).
pub fn empty_fingerprint() -> Fingerprint {
  { content_hash: "", algorithm: "placeholder", }
}

///|
/// 指纹相等判定 / Fingerprint equality.
pub fn matches(a : Fingerprint, b : Fingerprint) -> Bool {
  a.content_hash == b.content_hash
}

///|
pub fn datatemporal_id() -> String {
  "datatemporal"
}
///===
/// S10.2 时间操作扩展 / Time operations

///|
/// 时间戳对 / Timestamp pair.
pub struct TimeInterval {
  start : Double
  end : Double
}

///|
/// 构造时间区间 / Create time interval.
pub fn make_interval(start : Double, end : Double) -> TimeInterval {
  { start, end, }
}

///|
/// 区间长度 / Interval duration.
pub fn interval_duration(i : TimeInterval) -> Double {
  i.end - i.start
}

///|
/// 区间重叠 / Check interval overlap.
pub fn intervals_overlap(a : TimeInterval, b : TimeInterval) -> Bool {
  a.start < b.end && b.start < a.end
}

///|
/// 重叠长度 / Overlap duration.
pub fn overlap_duration(a : TimeInterval, b : TimeInterval) -> Double {
  if !intervals_overlap(a, b) {
    return 0.0
  }
  let overlap_start = if a.start > b.start { a.start } else { b.start }
  let overlap_end = if a.end < b.end { a.end } else { b.end }
  overlap_end - overlap_start
}

///|
/// 区间合并 / Merge intervals.
pub fn merge_intervals(intervals : Array[TimeInterval]) -> Array[TimeInterval] {
  if intervals.length() == 0 {
    return []
  }
  let sorted = intervals.copy()
  sorted.sort_by(fn(a, b) { a.start.compare(b.start) })
  let result : Array[TimeInterval] = [sorted[0]]
  for i in 1..<sorted.length() {
    let last = result[result.length() - 1]
    if sorted[i].start <= last.end {
      if sorted[i].end > last.end {
        result[result.length() - 1] = { start: last.start, end: sorted[i].end, }
      }
    } else {
      result.push(sorted[i])
    }
  }
  result
}

///|
/// 时间戳比较 / Compare timestamps.
pub fn compare_timestamps(a : Double, b : Double) -> Int32 {
  if a < b {
    -1
  } else if a > b {
    1
  } else {
    0
  }
}

///|
/// 时间戳在区间内 / Check if timestamp is in interval.
pub fn timestamp_in_interval(ts : Double, i : TimeInterval) -> Bool {
  ts >= i.start && ts <= i.end
}

///|
/// 时间序列采样 / Sample time series at regular intervals.
pub fn sample_timeseries(
  values : Array[Double],
  sample_rate : Int32,
) -> Array[Double] {
  if sample_rate <= 0 {
    return values
  }
  let result : Array[Double] = []
  let mut i = 0
  while i < values.length() {
    result.push(values[i])
    i = i + sample_rate
  }
  result
}

///|
/// 时间序列差分 / Time series differencing.
pub fn diff_timeseries(values : Array[Double]) -> Array[Double] {
  if values.length() < 2 {
    return []
  }
  let result : Array[Double] = []
  for i in 1..<values.length() {
    result.push(values[i] - values[i - 1])
  }
  result
}

///|
/// 时间序列移动平均 / Moving average.
pub fn moving_average(values : Array[Double], window : Int32) -> Array[Double] {
  if window <= 0 || values.length() < window {
    return []
  }
  let result : Array[Double] = []
  for i in 0..<(values.length() - window + 1) {
    let mut sum = 0.0
    for j in 0..<window {
      sum = sum + values[i + j]
    }
    result.push(sum / window.to_double())
  }
  result
}

///|
/// 时间序列滞后 / Lag time series.
pub fn lag_timeseries(values : Array[Double], lag : Int32) -> Array[Double] {
  if lag <= 0 || lag >= values.length() {
    return []
  }
  let result : Array[Double] = []
  for i in 0..<(values.length() - lag) {
    result.push(values[i + lag])
  }
  result
}
