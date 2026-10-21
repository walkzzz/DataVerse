///|
/// # kernel/streaming 流式模式 / Streaming Mode
///
/// 无界数据、在线清洗、实时过滤的执行模式基座。
/// 一致性保证：窗口内等价。架构 §4.1。
/// S0.2 提供窗口抽象与契约声明；具体流式算子在 Phase 1 填充。
///
/// # Streaming mode
///
/// Base for unbounded data, online cleaning, real-time filtering.
/// Consistency: window-equivalent. See architecture §4.1.
/// S0.2 provides window abstraction and contract; concrete operators filled in Phase 1.

///|
/// 流式窗口配置 / Streaming window configuration.
///
/// `window_size` 为窗口大小，`slide` 为滑动步长。
/// 当 `slide == window_size` 为翻滚窗口；`slide < window_size` 为滑动窗口。
pub struct WindowConfig {
  window_size : Int32
  slide : Int32
} derive(Debug, Eq)

///|
pub extend WindowConfig with Eq::{equal, not_equal}

///|
pub extend WindowConfig with Debug::{to_repr}

///|
/// 默认窗口：翻滚窗口，大小 100 / Default tumbling window, size 100.
pub fn default_window() -> WindowConfig {
  { window_size: 100, slide: 100, }
}

///|
/// 滑动窗口 / Sliding window with given size and slide.
pub fn sliding_window(size : Int32, slide : Int32) -> WindowConfig {
  { window_size: size, slide, }
}

///|
pub fn streaming_id() -> String {
  "kernel/streaming"
}

///|
/// 模式标签 / Mode tag string.
pub fn mode_tag() -> String {
  "streaming"
}

///|
/// 一致性保证声明 / Consistency guarantee.
pub fn consistency_guarantee() -> String {
  "window-equiv"
}

///|
/// 窗口校验 / Window validation: size > 0 and slide > 0.
pub fn valid_window(config : WindowConfig) -> Bool {
  config.window_size > 0 && config.slide > 0
}
