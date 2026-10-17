///|
/// # datatemporal/replay 回放与回溯 / Replay and Backtracking
///
/// 回放与回溯。架构 §4.4。S0.5 数据结构定型。
///
/// # Replay and backtracking
///
/// Replay and backtracking. See architecture §4.4.

/// 回放轨迹 / Replay trace: trace id + operator steps + result fingerprint.
pub struct ReplayTrace {
  trace_id : String
  steps : Array[String]
  result_fingerprint : String
} derive(Debug, Eq)

pub extend ReplayTrace with Eq::{equal, not_equal}
pub extend ReplayTrace with Debug::{to_repr}

/// 构造回放轨迹 / Build a replay trace.
pub fn make_trace(trace_id : String, steps : Array[String], result_fp : String) -> ReplayTrace {
  { trace_id, steps, result_fingerprint: result_fp }
}

/// 空轨迹（退化安全）/ Empty trace (degenerate-safe).
pub fn empty_trace(trace_id : String) -> ReplayTrace {
  { trace_id, steps: [], result_fingerprint: "" }
}

/// 轨迹步数 / Step count.
pub fn step_count(trace : ReplayTrace) -> Int {
  trace.steps.length()
}

pub fn replay_id() -> String {
  "datatemporal/replay"
}