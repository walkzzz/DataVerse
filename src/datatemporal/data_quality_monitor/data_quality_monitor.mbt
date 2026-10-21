///|
/// # datatemporal/data_quality_monitor 数据质量监控 / Data Quality Monitor
///
/// 监控 / 规则 / 阈值 / 指标 / 仪表板 / 警报 / 调度 / 趋势 / 漂移 / 回归 / 比较 / 修复 / 报告。
/// S12.11 新建：50+ pub fn 数据质量监控算子。
///
/// # Data quality monitor
///
/// Monitor / rule / threshold / metric / dashboard / alert / schedule / trend / drift / regression.

/// 监控状态 / Monitor status.
pub(all) enum MonitorStatus {
  MonitorIdle
  MonitorRunning
  MonitorStopped
  MonitorError
} derive(Debug, Eq)

pub extend MonitorStatus with Eq::{equal, not_equal}
pub extend MonitorStatus with Debug::{to_repr}

/// 规则维度 / Rule dimension.
pub(all) enum RuleDimension {
  RuleCompleteness
  RuleUniqueness
  RuleValidity
  RuleConsistency
  RuleAccuracy
  RuleTimeliness
} derive(Debug, Eq)

pub extend RuleDimension with Eq::{equal, not_equal}
pub extend RuleDimension with Debug::{to_repr}

/// 警报级别 / Alert level.
pub(all) enum AlertLevel {
  AlertInfo
  AlertWarning
  AlertCritical
} derive(Debug, Eq)

pub extend AlertLevel with Eq::{equal, not_equal}
pub extend AlertLevel with Debug::{to_repr}

/// 质量等级 / Quality grade.
pub(all) enum QualityGrade {
  GradeA
  GradeB
  GradeC
  GradeD
  GradeF
} derive(Debug, Eq)

pub extend QualityGrade with Eq::{equal, not_equal}
pub extend QualityGrade with Debug::{to_repr}

/// 监控器 / DQ monitor.
pub struct DQMonitor {
  name : String
  status : MonitorStatus
  rules : Array[DQRule]
  metrics : Array[DQMetric]
  history : Array[DQMetric]
  started_at : Double
}

/// 质量规则 / DQ rule.
pub struct DQRule {
  name : String
  dimension : RuleDimension
  weight : Double
  threshold : DQThreshold
}

/// 阈值 / DQ threshold.
pub struct DQThreshold {
  min_value : Double
  max_value : Double
  warn_value : Double
}

/// 指标 / DQ metric.
pub struct DQMetric {
  rule_name : String
  value : Double
  timestamp : Double
  passed : Bool
}

/// 仪表板 / DQ dashboard.
pub struct DQDashboard {
  title : String
  metrics : Array[DQMetric]
  alerts : Array[DQAlert]
  updated_at : Double
}

/// 警报 / DQ alert.
pub struct DQAlert {
  rule_name : String
  level : AlertLevel
  message : String
  timestamp : Double
  acknowledged : Bool
}

/// 调度 / DQ schedule.
pub struct DQSchedule {
  name : String
  interval : Double
  next_run : Double
  enabled : Bool
}

/// 趋势 / DQ trend.
pub struct DQTrend {
  name : String
  values : Array[Double]
  direction : String
  slope : Double
}

/// 漂移 / DQ drift.
pub struct DQDrift {
  name : String
  baseline_mean : Double
  current_mean : Double
  drift_score : Double
  significant : Bool
}

/// 回归 / DQ regression.
pub struct DQRegression {
  name : String
  baseline : Double
  current : Double
  regressed : Bool
}

/// 比较 / DQ comparison.
pub struct DQComparison {
  name : String
  historical : Double
  current : Double
  delta : Double
}

/// 修复 / DQ remediation.
pub struct DQRemediation {
  rule_name : String
  suggestion : String
  priority : Int
  applied : Bool
}

/// 报告 / DQ report.
pub struct DQReport {
  title : String
  monitor_name : String
  metrics : Array[DQMetric]
  alerts : Array[DQAlert]
  generated_at : Double
}

///===
/// 辅助数学 / Helper math (private)

///===
/// 构造 / Constructors

/// 构造监控器 / Create DQ monitor.
pub fn make_dq_monitor(name : String) -> DQMonitor {
  { name: name, status: MonitorIdle, rules: [], metrics: [], history: [], started_at: 0.0 }
}

/// 构造规则 / Create DQ rule.
pub fn make_dq_rule(
  name : String,
  dimension : RuleDimension,
  weight : Double,
  threshold : DQThreshold,
) -> DQRule {
  { name: name, dimension: dimension, weight: weight, threshold: threshold }
}

/// 构造阈值 / Create DQ threshold.
pub fn make_dq_threshold(min_value : Double, max_value : Double, warn_value : Double) -> DQThreshold {
  { min_value: min_value, max_value: max_value, warn_value: warn_value }
}

/// 构造指标 / Create DQ metric.
pub fn make_dq_metric(rule_name : String, value : Double, timestamp : Double) -> DQMetric {
  { rule_name: rule_name, value: value, timestamp: timestamp, passed: true }
}

/// 构造仪表板 / Create DQ dashboard.
pub fn make_dq_dashboard(title : String) -> DQDashboard {
  { title: title, metrics: [], alerts: [], updated_at: 0.0 }
}

/// 构造警报警 / Create DQ alert.
pub fn make_dq_alert(
  rule_name : String,
  level : AlertLevel,
  message : String,
  timestamp : Double,
) -> DQAlert {
  { rule_name: rule_name, level: level, message: message, timestamp: timestamp, acknowledged: false }
}

/// 构造调度 / Create DQ schedule.
pub fn make_dq_schedule(name : String, interval : Double) -> DQSchedule {
  { name: name, interval: interval, next_run: 0.0, enabled: true }
}

/// 构造趋势 / Create DQ trend.
pub fn make_dq_trend(name : String, values : Array[Double]) -> DQTrend {
  let slope = dq_trend_slope(values)
  let direction = if slope > 0.0 { "up" } else if slope < 0.0 { "down" } else { "flat" }
  { name: name, values: values, direction: direction, slope: slope }
}

/// 构造漂移 / Create DQ drift.
pub fn make_dq_drift(name : String, baseline : Array[Double], current : Array[Double], threshold : Double) -> DQDrift {
  let bm = @_common.mean(baseline)
  let cm = @_common.mean(current)
  let score = @_common.abs(cm - bm)
  { name: name, baseline_mean: bm, current_mean: cm, drift_score: score, significant: score > threshold }
}

/// 构造回归 / Create DQ regression.
pub fn make_dq_regression(name : String, baseline : Double, current : Double, tolerance : Double) -> DQRegression {
  { name: name, baseline: baseline, current: current, regressed: @_common.abs(current - baseline) > tolerance }
}

/// 构造比较 / Create DQ comparison.
pub fn make_dq_comparison(name : String, historical : Double, current : Double) -> DQComparison {
  { name: name, historical: historical, current: current, delta: current - historical }
}

/// 构造修复 / Create DQ remediation.
pub fn make_dq_remediation(rule_name : String, suggestion : String, priority : Int) -> DQRemediation {
  { rule_name: rule_name, suggestion: suggestion, priority: priority, applied: false }
}

/// 构造报告 / Create DQ report.
pub fn make_dq_report(title : String, monitor_name : String, generated_at : Double) -> DQReport {
  { title: title, monitor_name: monitor_name, metrics: [], alerts: [], generated_at: generated_at }
}

///===
/// 监控操作 / Monitor operations

/// 启动监控 / Start monitor.
pub fn monitor_start(monitor : DQMonitor, timestamp : Double) -> DQMonitor {
  { ..monitor, status: MonitorRunning, started_at: timestamp }
}

/// 停止监控 / Stop monitor.
pub fn monitor_stop(monitor : DQMonitor) -> DQMonitor {
  { ..monitor, status: MonitorStopped }
}

/// 检查监控 / Check monitor (run all rules).
pub fn monitor_check(monitor : DQMonitor, values : Array[Double], timestamp : Double) -> DQMonitor {
  let running = match monitor.status {
    MonitorRunning => true
    _ => false
  }
  if !(running) {
    return monitor
  }
  let new_metrics : Array[DQMetric] = []
  for i in 0..<monitor.rules.length() {
    let rule = monitor.rules[i]
    let value = dq_compute_rule_value(rule, values)
    let passed = threshold_check(rule.threshold, value)
    new_metrics.push({ rule_name: rule.name, value: value, timestamp: timestamp, passed: passed })
  }
  let new_history = monitor.history.copy()
  for i in 0..<new_metrics.length() {
    new_history.push(new_metrics[i])
  }
  { ..monitor, metrics: new_metrics, history: new_history }
}

///===
/// 规则 / Rules

/// 完整性规则 / Completeness rule.
pub fn rule_completeness(name : String, threshold : Double) -> DQRule {
  make_dq_rule(name, RuleCompleteness, 1.0, make_dq_threshold(threshold, 1.0, threshold))
}

/// 唯一性规则 / Uniqueness rule.
pub fn rule_uniqueness(name : String, threshold : Double) -> DQRule {
  make_dq_rule(name, RuleUniqueness, 1.0, make_dq_threshold(threshold, 1.0, threshold))
}

/// 有效性规则 / Validity rule.
pub fn rule_validity(name : String, threshold : Double) -> DQRule {
  make_dq_rule(name, RuleValidity, 1.0, make_dq_threshold(threshold, 1.0, threshold))
}

/// 一致性规则 / Consistency rule.
pub fn rule_consistency(name : String, threshold : Double) -> DQRule {
  make_dq_rule(name, RuleConsistency, 1.0, make_dq_threshold(threshold, 1.0, threshold))
}

/// 准确性规则 / Accuracy rule.
pub fn rule_accuracy(name : String, threshold : Double) -> DQRule {
  make_dq_rule(name, RuleAccuracy, 1.0, make_dq_threshold(threshold, 1.0, threshold))
}

/// 时效性规则 / Timeliness rule.
pub fn rule_timeliness(name : String, threshold : Double) -> DQRule {
  make_dq_rule(name, RuleTimeliness, 1.0, make_dq_threshold(threshold, 1.0, threshold))
}

fn dq_compute_rule_value(rule : DQRule, values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  match rule.dimension {
    RuleCompleteness => {
      let mut non_null = 0
      for i in 0..<n {
        if values[i] != 0.0 {
          non_null = non_null + 1
        }
      }
      non_null.to_double() / n.to_double()
    }
    RuleUniqueness => {
      let seen : Array[Double] = []
      for i in 0..<n {
        let mut found = false
        for j in 0..<seen.length() {
          if seen[j] == values[i] {
            found = true
            break
          }
        }
        if !(found) {
          seen.push(values[i])
        }
      }
      seen.length().to_double() / n.to_double()
    }
    _ => {
      let mut valid = 0
      for i in 0..<n {
        if values[i] >= rule.threshold.min_value && values[i] <= rule.threshold.max_value {
          valid = valid + 1
        }
      }
      valid.to_double() / n.to_double()
    }
  }
}

///===
/// 阈值 / Threshold

/// 阈值检查 / Threshold check.
pub fn threshold_check(threshold : DQThreshold, value : Double) -> Bool {
  value >= threshold.min_value && value <= threshold.max_value
}

/// 阈值警报警 / Threshold alert.
pub fn threshold_alert(threshold : DQThreshold, value : Double, rule_name : String, timestamp : Double) -> DQAlert {
  if value < threshold.min_value || value > threshold.max_value {
    make_dq_alert(rule_name, AlertCritical, "threshold violated: " + value.to_string(), timestamp)
  } else if value < threshold.warn_value {
    make_dq_alert(rule_name, AlertWarning, "warning: " + value.to_string(), timestamp)
  } else {
    make_dq_alert(rule_name, AlertInfo, "ok: " + value.to_string(), timestamp)
  }
}

///===
/// 指标 / Metric

/// 计算指标 / Compute metric.
pub fn metric_compute(rule : DQRule, values : Array[Double], timestamp : Double) -> DQMetric {
  let value = dq_compute_rule_value(rule, values)
  let passed = threshold_check(rule.threshold, value)
  { rule_name: rule.name, value: value, timestamp: timestamp, passed: passed }
}

/// 跟踪指标 / Track metric (append to history).
pub fn metric_track(history : Array[DQMetric], metric : DQMetric) -> Array[DQMetric] {
  let new_history = history.copy()
  new_history.push(metric)
  new_history
}

/// 指标历史 / Metric history (filter by rule name).
pub fn metric_history(history : Array[DQMetric], rule_name : String) -> Array[DQMetric] {
  let result : Array[DQMetric] = []
  for i in 0..<history.length() {
    if history[i].rule_name == rule_name {
      result.push(history[i])
    }
  }
  result
}

///===
/// 仪表板 / Dashboard

/// 更新仪表板 / Update dashboard.
pub fn dashboard_update(dashboard : DQDashboard, metrics : Array[DQMetric], alerts : Array[DQAlert], updated_at : Double) -> DQDashboard {
  { ..dashboard, metrics: metrics, alerts: alerts, updated_at: updated_at }
}

/// 渲染仪表板 / Render dashboard.
pub fn dashboard_render(dashboard : DQDashboard) -> String {
  let mut result = "dashboard: " + dashboard.title + "\n"
  result = result + "metrics:\n"
  for i in 0..<dashboard.metrics.length() {
    let m = dashboard.metrics[i]
    result = result + "  " + m.rule_name + " = " + m.value.to_string() + " (passed=" + m.passed.to_string() + ")\n"
  }
  result = result + "alerts:\n"
  for i in 0..<dashboard.alerts.length() {
    let a = dashboard.alerts[i]
    result = result + "  " + a.rule_name + ": " + a.message + "\n"
  }
  result
}

///===
/// 警报 / Alert

/// 触发警报警 / Trigger alert.
pub fn alert_trigger(rule_name : String, level : AlertLevel, message : String, timestamp : Double) -> DQAlert {
  make_dq_alert(rule_name, level, message, timestamp)
}

/// 通知警报警 / Notify alert (mark acknowledged).
pub fn alert_notify(alert : DQAlert) -> DQAlert {
  { ..alert, acknowledged: true }
}

/// 升级警报警 / Escalate alert.
pub fn alert_escalate(alert : DQAlert) -> DQAlert {
  let new_level = match alert.level {
    AlertInfo => AlertWarning
    AlertWarning => AlertCritical
    AlertCritical => AlertCritical
  }
  { ..alert, level: new_level, message: "ESCALATED: " + alert.message }
}

///===
/// 调度 / Schedule

/// 每日调度 / Daily schedule.
pub fn schedule_daily(name : String) -> DQSchedule {
  make_dq_schedule(name, 86400.0)
}

/// 每小时调度 / Hourly schedule.
pub fn schedule_hourly(name : String) -> DQSchedule {
  make_dq_schedule(name, 3600.0)
}

/// 自定义调度 / Custom schedule.
pub fn schedule_custom(name : String, interval : Double) -> DQSchedule {
  make_dq_schedule(name, interval)
}

///===
/// 趋势 / Trend

/// 趋势检测 / Detect trend direction.
pub fn trend_detect(values : Array[Double]) -> String {
  let slope = dq_trend_slope(values)
  if slope > 0.0 {
    "up"
  } else if slope < 0.0 {
    "down"
  } else {
    "flat"
  }
}

/// 趋势分析 / Analyze trend.
pub fn trend_analyze(name : String, values : Array[Double]) -> DQTrend {
  make_dq_trend(name, values)
}

/// 趋势预测 / Forecast trend (linear extrapolation).
pub fn trend_forecast(values : Array[Double], steps : Int) -> Array[Double] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let slope = dq_trend_slope(values)
  let last = values[n - 1]
  let result : Array[Double] = []
  for i in 1..<=steps {
    result.push(last + slope * i.to_double())
  }
  result
}

fn dq_trend_slope(values : Array[Double]) -> Double {
  let n = values.length()
  if n < 2 {
    return 0.0
  }
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  let mut sum_xy = 0.0
  let mut sum_x2 = 0.0
  for i in 0..<n {
    let x = i.to_double()
    let y = values[i]
    sum_x = sum_x + x
    sum_y = sum_y + y
    sum_xy = sum_xy + x * y
    sum_x2 = sum_x2 + x * x
  }
  let nd = n.to_double()
  let denom = nd * sum_x2 - sum_x * sum_x
  if denom == 0.0 {
    0.0
  } else {
    (nd * sum_xy - sum_x * sum_y) / denom
  }
}

///===
/// 漂移 / Drift

/// 漂移检测 / Detect drift.
pub fn drift_detect(baseline : Array[Double], current : Array[Double], threshold : Double) -> Bool {
  let bm = @_common.mean(baseline)
  let cm = @_common.mean(current)
  @_common.abs(cm - bm) > threshold
}

/// 漂移度量 / Measure drift.
pub fn drift_measure(baseline : Array[Double], current : Array[Double]) -> Double {
  @_common.abs(@_common.mean(current) - @_common.mean(baseline))
}

/// 漂移显著性 / Drift significance.
pub fn drift_significance(baseline : Array[Double], current : Array[Double]) -> Double {
  let bm = @_common.mean(baseline)
  let cm = @_common.mean(current)
  let n = baseline.length()
  if n == 0 {
    return 0.0
  }
  let mut var_sum = 0.0
  for i in 0..<n {
    let d = baseline[i] - bm
    var_sum = var_sum + d * d
  }
  let variance = var_sum / n.to_double()
  let std = @_common.sqrt(variance)
  if std == 0.0 {
    0.0
  } else {
    @_common.abs(cm - bm) / std
  }
}

///===
/// 回归 / Regression

/// 回归检查 / Regression check.
pub fn regression_check(baseline : Double, current : Double, tolerance : Double) -> Bool {
  @_common.abs(current - baseline) > tolerance
}

/// 回归基线 / Regression baseline (compute baseline from history).
pub fn regression_baseline(history : Array[DQMetric], rule_name : String) -> Double {
  let filtered = metric_history(history, rule_name)
  let n = filtered.length()
  if n == 0 {
    return 0.0
  }
  let mut s = 0.0
  for i in 0..<n {
    s = s + filtered[i].value
  }
  s / n.to_double()
}

///===
/// 比较 / Comparison

/// 历史比较 / Historical comparison.
pub fn comparison_historical(history : Array[DQMetric], rule_name : String, current : Double) -> DQComparison {
  let baseline = regression_baseline(history, rule_name)
  make_dq_comparison(rule_name, baseline, current)
}

/// 交叉比较 / Cross comparison.
pub fn comparison_cross(name : String, value_a : Double, value_b : Double) -> DQComparison {
  make_dq_comparison(name, value_a, value_b)
}

///===
/// 修复 / Remediation

/// 修复建议 / Remediation suggestion.
pub fn remediation_suggest(rule_name : String, dimension : RuleDimension) -> DQRemediation {
  let suggestion = match dimension {
    RuleCompleteness => "fill missing values or drop null rows"
    RuleUniqueness => "remove duplicates or add unique constraint"
    RuleValidity => "validate against domain or schema"
    RuleConsistency => "fix cross-field inconsistencies"
    RuleAccuracy => "verify against reference data"
    RuleTimeliness => "update stale records"
  }
  make_dq_remediation(rule_name, suggestion, 1)
}

/// 应用修复 / Apply remediation.
pub fn remediation_apply(remediation : DQRemediation) -> DQRemediation {
  { ..remediation, applied: true }
}

///===
/// 报告 / Report

/// 生成报告 / Generate report.
pub fn report_generate(monitor : DQMonitor, generated_at : Double) -> DQReport {
  let alerts : Array[DQAlert] = []
  for i in 0..<monitor.metrics.length() {
    if !(monitor.metrics[i].passed) {
      alerts.push(make_dq_alert(monitor.metrics[i].rule_name, AlertWarning, "rule failed: " + monitor.metrics[i].value.to_string(), monitor.metrics[i].timestamp))
    }
  }
  { title: "dq_report_" + monitor.name, monitor_name: monitor.name, metrics: monitor.metrics, alerts: alerts, generated_at: generated_at }
}

/// 调度报告 / Schedule report.
pub fn report_schedule(report : DQReport, schedule : DQSchedule) -> DQSchedule {
  { ..schedule, name: report.title }
}

/// 分发报告 / Distribute report.
pub fn report_distribute(report : DQReport) -> String {
  "distributing report: " + report.title + " for monitor: " + report.monitor_name
}

///===
/// 评分 / 等级 / 状态 / 摘要 / Score / Grade / Status / Summary

/// 质量评分 / DQ score.
pub fn dq_score(monitor : DQMonitor) -> Double {
  let n = monitor.metrics.length()
  if n == 0 {
    return 0.0
  }
  let mut passed = 0
  for i in 0..<n {
    if monitor.metrics[i].passed {
      passed = passed + 1
    }
  }
  passed.to_double() / n.to_double()
}

/// 质量等级 / DQ grade.
pub fn dq_grade(score : Double) -> QualityGrade {
  if score >= 0.9 {
    GradeA
  } else if score >= 0.8 {
    GradeB
  } else if score >= 0.7 {
    GradeC
  } else if score >= 0.6 {
    GradeD
  } else {
    GradeF
  }
}

/// 质量状态 / DQ status.
pub fn dq_status(monitor : DQMonitor) -> String {
  match monitor.status {
    MonitorIdle => "idle"
    MonitorRunning => "running"
    MonitorStopped => "stopped"
    MonitorError => "error"
  }
}

/// 质量摘要 / DQ summary.
pub fn dq_summary(monitor : DQMonitor) -> String {
  let score = dq_score(monitor)
  let grade = dq_grade(score)
  let grade_str = match grade {
    GradeA => "A"
    GradeB => "B"
    GradeC => "C"
    GradeD => "D"
    GradeF => "F"
  }
  "monitor: " + monitor.name + ", status: " + dq_status(monitor) + ", score: " + score.to_string() + ", grade: " + grade_str
}

///===
/// ID

/// 模块 ID / Module id.
pub fn data_quality_monitor_id() -> String {
  "datatemporal/data_quality_monitor"
}