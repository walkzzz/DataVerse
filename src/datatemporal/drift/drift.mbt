///|
/// # datatemporal/drift 漂移检测 / Drift Detection
///
/// 漂移检测、数据衰老。架构 §4.4。S0.5 数据结构定型。
///
/// # Drift detection
///
/// Drift detection, data aging. See architecture §4.4.

/// 漂移报告 / Drift report: metric + baseline + current + drift score.
pub struct DriftReport {
  metric : String
  baseline : Double
  current : Double
  drift_score : Double
} derive(Debug, Eq)

pub extend DriftReport with Eq::{equal, not_equal}
pub extend DriftReport with Debug::{to_repr}

/// 构造漂移报告 / Build a drift report.
pub fn make_drift_report(
  metric : String,
  baseline : Double,
  current : Double
) -> DriftReport {
  { metric, baseline, current, drift_score: current - baseline }
}

/// 漂移是否显著（阈值）/ Whether drift is significant (threshold).
pub fn is_significant(report : DriftReport, threshold : Double) -> Bool {
  report.drift_score.abs() > threshold
}

pub fn drift_id() -> String {
  "datatemporal/drift"
}