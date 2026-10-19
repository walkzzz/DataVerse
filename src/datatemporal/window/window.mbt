///|
/// # datatemporal/window 时间窗口 / Time Window
///
/// 时间窗口算子：滑动窗口、滚动窗口、会话窗口。
/// S10.2 新建。
///
/// # Time window operators

/// 窗口类型 / Window type.
pub(all) enum WindowType {
  Sliding
  Tumbling
  Session
}

/// 时间窗口 / Time window.
pub struct TimeWindow {
  start : Double
  end : Double
  window_type : WindowType
  size : Double
  slide : Double
}

/// 时间事件 / Time event.
pub struct TimeEvent {
  timestamp : Double
  value : Double
  key : String
}

/// 构造时间事件 / Create time event.
pub fn make_event(timestamp : Double, value : Double, key : String) -> TimeEvent {
  { timestamp: timestamp, value: value, key: key }
}

/// 构造时间窗口 / Create time window.
pub fn make_window(
  start : Double,
  end : Double,
  window_type : WindowType,
  size : Double,
  slide : Double,
) -> TimeWindow {
  { start: start, end: end, window_type: window_type, size: size, slide: slide }
}

/// 窗口长度 / Window duration.
pub fn window_duration(w : TimeWindow) -> Double {
  w.end - w.start
}

/// 事件是否在窗口内 / Check if event is in window.
pub fn event_in_window(event : TimeEvent, w : TimeWindow) -> Bool {
  event.timestamp >= w.start && event.timestamp < w.end
}

/// 窗口内事件 / Get events in window.
pub fn events_in_window(events : Array[TimeEvent], w : TimeWindow) -> Array[TimeEvent] {
  let result : Array[TimeEvent] = []
  for i in 0..<events.length() {
    if event_in_window(events[i], w) {
      result.push(events[i])
    }
  }
  result
}

///===
/// 滚动窗口 / Tumbling windows

/// 生成滚动窗口 / Generate tumbling windows.
pub fn tumbling_windows(
  start : Double,
  end : Double,
  size : Double,
) -> Array[TimeWindow] {
  let result : Array[TimeWindow] = []
  let mut current = start
  while current < end {
    let w_end = if current + size < end { current + size } else { end }
    result.push(make_window(current, w_end, Tumbling, size, size))
    current = current + size
  }
  result
}

///===
/// 滑动窗口 / Sliding windows

/// 生成滑动窗口 / Generate sliding windows.
pub fn sliding_windows(
  start : Double,
  end : Double,
  size : Double,
  slide : Double,
) -> Array[TimeWindow] {
  let result : Array[TimeWindow] = []
  let mut current = start
  while current < end {
    let w_end = if current + size < end { current + size } else { end }
    result.push(make_window(current, w_end, Sliding, size, slide))
    current = current + slide
  }
  result
}

///===
/// 会话窗口 / Session windows

/// 生成会话窗口 / Generate session windows by gap.
pub fn session_windows(
  events : Array[TimeEvent],
  gap : Double,
) -> Array[TimeWindow] {
  if events.length() == 0 {
    return []
  }
  let sorted = sort_events_by_time(events)
  let result : Array[TimeWindow] = []
  let mut session_start = sorted[0].timestamp
  let mut session_end = sorted[0].timestamp
  for i in 1..<sorted.length() {
    if sorted[i].timestamp - session_end <= gap {
      session_end = sorted[i].timestamp
    } else {
      result.push(make_window(session_start, session_end, Session, session_end - session_start, 0.0))
      session_start = sorted[i].timestamp
      session_end = sorted[i].timestamp
    }
  }
  result.push(make_window(session_start, session_end, Session, session_end - session_start, 0.0))
  result
}

/// 按时间排序事件 / Sort events by timestamp.
pub fn sort_events_by_time(events : Array[TimeEvent]) -> Array[TimeEvent] {
  let result = events.copy()
  result.sort_by(fn(a, b) { a.timestamp.compare(b.timestamp) })
  result
}

///===
/// 窗口聚合 / Window aggregations

/// 窗口内值求和 / Sum values in window.
pub fn window_sum(events : Array[TimeEvent], w : TimeWindow) -> Double {
  let mut sum = 0.0
  for i in 0..<events.length() {
    if event_in_window(events[i], w) {
      sum = sum + events[i].value
    }
  }
  sum
}

/// 窗口内值平均 / Average values in window.
pub fn window_avg(events : Array[TimeEvent], w : TimeWindow) -> Double {
  let mut sum = 0.0
  let mut count = 0
  for i in 0..<events.length() {
    if event_in_window(events[i], w) {
      sum = sum + events[i].value
      count = count + 1
    }
  }
  if count == 0 { 0.0 } else { sum / count.to_double() }
}

/// 窗口内值最大 / Max value in window.
pub fn window_max(events : Array[TimeEvent], w : TimeWindow) -> Double {
  let mut max_val = 0.0
  let mut found = false
  for i in 0..<events.length() {
    if event_in_window(events[i], w) {
      if not(found) || events[i].value > max_val {
        max_val = events[i].value
        found = true
      }
    }
  }
  max_val
}

/// 窗口内值最小 / Min value in window.
pub fn window_min(events : Array[TimeEvent], w : TimeWindow) -> Double {
  let mut min_val = 0.0
  let mut found = false
  for i in 0..<events.length() {
    if event_in_window(events[i], w) {
      if not(found) || events[i].value < min_val {
        min_val = events[i].value
        found = true
      }
    }
  }
  min_val
}

/// 窗口内值计数 / Count events in window.
pub fn window_count(events : Array[TimeEvent], w : TimeWindow) -> Int {
  let mut count = 0
  for i in 0..<events.length() {
    if event_in_window(events[i], w) {
      count = count + 1
    }
  }
  count
}

///===
/// 窗口应用 / Apply windows

/// 对每个窗口应用聚合 / Apply aggregation to each window.
pub fn apply_windows(
  events : Array[TimeEvent],
  windows : Array[TimeWindow],
  agg_fn : (Array[TimeEvent], TimeWindow) -> Double,
) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<windows.length() {
    result.push(agg_fn(events, windows[i]))
  }
  result
}

/// 滚动窗口求和 / Tumbling window sum.
pub fn tumbling_sum(
  events : Array[TimeEvent],
  start : Double,
  end : Double,
  size : Double,
) -> Array[Double] {
  let windows = tumbling_windows(start, end, size)
  apply_windows(events, windows, window_sum)
}

/// 滑动窗口平均 / Sliding window average.
pub fn sliding_avg(
  events : Array[TimeEvent],
  start : Double,
  end : Double,
  size : Double,
  slide : Double,
) -> Array[Double] {
  let windows = sliding_windows(start, end, size, slide)
  apply_windows(events, windows, window_avg)
}

///===
/// 窗口键分组 / Window key grouping

/// 按键分组窗口内事件 / Group events by key in window.
pub fn window_group_by_key(
  events : Array[TimeEvent],
  w : TimeWindow,
) -> Array[(String, Array[TimeEvent])] {
  let keys : Array[String] = []
  let groups : Array[(String, Array[TimeEvent])] = []
  for i in 0..<events.length() {
    if event_in_window(events[i], w) {
      let k = events[i].key
      let mut found = false
      for j in 0..<groups.length() {
        if groups[j].0 == k {
          groups[j].1.push(events[i])
          found = true
        }
      }
      if not(found) {
        groups.push((k, [events[i]]))
      }
    }
  }
  groups
}

///===
/// ID

pub fn window_id() -> String {
  "datatemporal/window"
}