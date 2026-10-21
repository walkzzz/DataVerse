///|
/// # datatemporal/drift 漂移检测 / Drift Detection
///
/// 漂移检测、数据衰老。架构 §4.4。S0.5 数据结构定型。
///
/// # Drift detection
///
/// Drift detection, data aging. See architecture §4.4.

///|
/// 漂移报告 / Drift report: metric + baseline + current + drift score.
pub struct DriftReport {
  metric : String
  baseline : Double
  current : Double
  drift_score : Double
} derive(Debug, Eq)

///|
pub extend DriftReport with Eq::{equal, not_equal}

///|
pub extend DriftReport with Debug::{to_repr}

///|
/// 构造漂移报告 / Build a drift report.
pub fn make_drift_report(
  metric : String,
  baseline : Double,
  current : Double,
) -> DriftReport {
  { metric, baseline, current, drift_score: current - baseline, }
}

///|
/// 漂移是否显著（阈值）/ Whether drift is significant (threshold).
pub fn is_significant(report : DriftReport, threshold : Double) -> Bool {
  report.drift_score.abs() > threshold
}

///|
/// 漂移方向 / Drift direction: "up" / "down" / "stable".
pub fn drift_direction(report : DriftReport) -> String {
  if report.drift_score > 0.0001 {
    "up"
  } else if report.drift_score < -0.0001 {
    "down"
  } else {
    "stable"
  }
}

///|
/// 合并多个漂移报告 / Merge multiple drift reports.
///
/// 取平均 baseline + average current + average drift_score。
/// 退化安全：空数组返回零报告。
pub fn merge_reports(reports : Array[DriftReport]) -> DriftReport {
  let n = reports.length()
  if n == 0 {
    return { metric: "merged", baseline: 0.0, current: 0.0, drift_score: 0.0, }
  }
  let sum_base = reports.fold(init=0.0, fn(acc, r) { acc + r.baseline })
  let sum_curr = reports.fold(init=0.0, fn(acc, r) { acc + r.current })
  let sum_drift = reports.fold(init=0.0, fn(acc, r) { acc + r.drift_score })
  let nd = n.to_double()
  {
    metric: "merged",
    baseline: sum_base / nd,
    current: sum_curr / nd,
    drift_score: sum_drift / nd,
  }
}

///|
pub fn drift_id() -> String {
  "datatemporal/drift"
}
