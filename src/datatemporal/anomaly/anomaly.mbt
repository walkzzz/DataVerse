///|
/// # datatemporal/anomaly 异常检测 / Anomaly Detection
///
/// Z-score / IQR / 孤立森林 / LOF 等异常检测算法。架构 §4.4。
/// S12.6 提供统计型、距离型、模式型异常检测算子。
///
/// # Anomaly detection
///
/// Z-score / IQR / isolation forest / LOF etc. See architecture §4.4.

/// 异常类型 / Anomaly type.
pub(all) enum AnomalyType {
  PointAnomaly
  ContextualAnomaly
  CollectiveAnomaly
  PatternAnomaly
} derive(Debug, Eq)

pub extend AnomalyType with Eq::{equal, not_equal}
pub extend AnomalyType with Debug::{to_repr}

/// 异常严重度 / Anomaly severity.
pub(all) enum AnomalySeverity {
  Low
  Medium
  High
  Critical
} derive(Debug, Eq)

pub extend AnomalySeverity with Eq::{equal, not_equal}
pub extend AnomalySeverity with Debug::{to_repr}

/// 异常检测结果 / Anomaly detection result.
pub struct AnomalyResult {
  index : Int
  value : Double
  score : Double
  anomaly_type : AnomalyType
  severity : AnomalySeverity
} derive(Debug, Eq)

pub extend AnomalyResult with Eq::{equal, not_equal}
pub extend AnomalyResult with Debug::{to_repr}

/// 异常检测配置 / Anomaly detection config.
pub struct AnomalyConfig {
  threshold : Double
  window_size : Int
  sensitivity : Double
} derive(Debug, Eq)

pub extend AnomalyConfig with Eq::{equal, not_equal}
pub extend AnomalyConfig with Debug::{to_repr}

/// 平方根（牛顿迭代法）/ Square root via Newton's method.
pub fn sqrt_(x : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let mut guess = if x < 1.0 { 1.0 } else { x }
  let mut prev = 0.0
  let mut iter = 0
  while (guess - prev).abs() > 0.0000001 && iter < 100 {
    prev = guess
    guess = (guess + x / guess) / 2.0
    iter = iter + 1
  }
  guess
}

/// 均值 / Mean (helper).
pub fn mean_(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + values[i]
  }
  sum / n.to_double()
}

/// 标准差 / Standard deviation (helper).
pub fn std_dev_(values : Array[Double]) -> Double {
  let n = values.length()
  if n < 2 {
    return 0.0
  }
  let m = mean_(values)
  let mut variance = 0.0
  for i in 0..<n {
    let diff = values[i] - m
    variance = variance + diff * diff
  }
  variance = variance / n.to_double()
  sqrt_(variance)
}

/// 中位数 / Median (helper).
pub fn median_(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let sorted = values.copy()
  sorted.sort_by(fn(a, b) { a.compare(b) })
  if n % 2 == 1 {
    sorted[n / 2]
  } else {
    (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0
  }
}

/// 中位绝对偏差 / Median Absolute Deviation (helper).
pub fn mad_(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let med = median_(values)
  let devs : Array[Double] = []
  for i in 0..<n {
    devs.push((values[i] - med).abs())
  }
  median_(devs)
}

/// 百分位数 / Percentile (helper).
pub fn percentile_(values : Array[Double], p : Double) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let sorted = values.copy()
  sorted.sort_by(fn(a, b) { a.compare(b) })
  let pos = p * (n - 1).to_double() / 100.0
  let lo = pos.to_int()
  let hi = if lo + 1 < n { lo + 1 } else { lo }
  let frac = pos - lo.to_double()
  sorted[lo] * (1.0 - frac) + sorted[hi] * frac
}

/// Z-score 异常检测 / Z-score anomaly detection.
pub fn z_score_anomaly(values : Array[Double], threshold : Double) -> Array[Int] {
  let m = mean_(values)
  let sd = std_dev_(values)
  let result : Array[Int] = []
  if sd == 0.0 {
    return result
  }
  for i in 0..<values.length() {
    let z = (values[i] - m) / sd
    if z.abs() > threshold {
      result.push(i)
    }
  }
  result
}

/// IQR 异常检测 / IQR anomaly detection.
pub fn iqr_anomaly(values : Array[Double], k : Double) -> Array[Int] {
  let n = values.length()
  if n < 4 {
    return []
  }
  let q1 = percentile_(values, 25.0)
  let q3 = percentile_(values, 75.0)
  let iqr = q3 - q1
  let lower = q1 - k * iqr
  let upper = q3 + k * iqr
  let result : Array[Int] = []
  for i in 0..<n {
    if values[i] < lower || values[i] > upper {
      result.push(i)
    }
  }
  result
}

/// 修正 Z-score / Modified Z-score using MAD.
pub fn modified_z_score(values : Array[Double], threshold : Double) -> Array[Int] {
  let med = median_(values)
  let m = mad_(values)
  let result : Array[Int] = []
  if m == 0.0 {
    return result
  }
  for i in 0..<values.length() {
    let mz = 0.6745 * (values[i] - med) / m
    if mz.abs() > threshold {
      result.push(i)
    }
  }
  result
}

/// 移动平均异常 / Moving average anomaly.
pub fn moving_average_anomaly(
  values : Array[Double],
  window : Int,
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  if window <= 0 || n < window {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<(n - window + 1) {
    let mut sum = 0.0
    for j in 0..<window {
      sum = sum + values[i + j]
    }
    let ma = sum / window.to_double()
    let center = i + window / 2
    if (values[center] - ma).abs() > threshold {
      result.push(center)
    }
  }
  result
}

/// 指数平滑异常 / Exponential smoothing anomaly.
pub fn exponential_smoothing_anomaly(
  values : Array[Double],
  alpha : Double,
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let result : Array[Int] = []
  let mut smoothed = values[0]
  for i in 1..<n {
    let predicted = smoothed
    smoothed = alpha * values[i] + (1.0 - alpha) * smoothed
    if (values[i] - predicted).abs() > threshold {
      result.push(i)
    }
  }
  result
}

/// 孤立森林评分 / Isolation forest score (simplified).
pub fn isolation_forest_score(values : Array[Double], index : Int) -> Double {
  let n = values.length()
  if n == 0 || index < 0 || index >= n {
    return 0.0
  }
  let m = mean_(values)
  let sd = std_dev_(values)
  if sd == 0.0 {
    return 0.0
  }
  let depth = (values[index] - m).abs() / sd
  let c = 2.0 * (n.to_double() - 1.0) / n.to_double()
  let score = depth / c
  if score > 1.0 { 1.0 } else { score }
}

/// 局部异常因子 / Local Outlier Factor (simplified).
pub fn local_outlier_factor(
  values : Array[Double],
  index : Int,
  k : Int,
) -> Double {
  let n = values.length()
  if n == 0 || index < 0 || index >= n || k <= 0 {
    return 0.0
  }
  let target = values[index]
  let dists : Array[Double] = []
  for i in 0..<n {
    if i != index {
      dists.push((values[i] - target).abs())
    }
  }
  dists.sort_by(fn(a, b) { a.compare(b) })
  let kk = if k < dists.length() { k } else { dists.length() }
  if kk == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<kk {
    sum = sum + dists[i]
  }
  let k_dist = sum / kk.to_double()
  if k_dist == 0.0 { 0.0 } else { 1.0 / k_dist }
}

/// 基于距离的异常 / Distance-based anomaly.
pub fn distance_based_anomaly(
  values : Array[Double],
  index : Int,
  threshold : Double,
) -> Bool {
  let n = values.length()
  if n == 0 || index < 0 || index >= n {
    return false
  }
  let target = values[index]
  let mut count = 0
  for i in 0..<n {
    if i != index {
      let d = (values[i] - target).abs()
      if d < threshold {
        count = count + 1
      }
    }
  }
  let ratio = count.to_double() / (n - 1).to_double()
  ratio < 0.1
}

/// 基于密度的异常 / Density-based anomaly.
pub fn density_based_anomaly(
  values : Array[Double],
  index : Int,
  radius : Double,
) -> Double {
  let n = values.length()
  if n == 0 || index < 0 || index >= n {
    return 0.0
  }
  let target = values[index]
  let mut count = 0
  for i in 0..<n {
    let d = (values[i] - target).abs()
    if d <= radius {
      count = count + 1
    }
  }
  if count == 0 {
    return 1.0
  }
  1.0 - count.to_double() / n.to_double()
}

/// 范围异常 / Range anomaly.
pub fn range_anomaly(
  values : Array[Double],
  lo : Double,
  hi : Double,
) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<n {
    if values[i] < lo || values[i] > hi {
      result.push(i)
    }
  }
  result
}

/// 规则异常 / Rule-based anomaly.
pub fn rule_based_anomaly(
  values : Array[Double],
  lo : Double,
  hi : Double,
) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<n {
    let v = values[i]
    let outside = v < lo || v > hi
    if outside {
      result.push(i)
    }
  }
  result
}

/// 趋势异常 / Trend anomaly.
pub fn trend_anomaly(
  values : Array[Double],
  window : Int,
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  if window <= 1 || n < 2 * window {
    return []
  }
  let result : Array[Int] = []
  for i in 0..=(n - 2 * window) {
    let mut s1 = 0.0
    let mut s2 = 0.0
    for j in 0..<window {
      s1 = s1 + values[i + j]
      s2 = s2 + values[i + window + j]
    }
    let t1 = s1 / window.to_double()
    let t2 = s2 / window.to_double()
    if (t2 - t1).abs() > threshold {
      result.push(i + window)
    }
  }
  result
}

/// 季节异常 / Seasonal anomaly.
pub fn seasonal_anomaly(
  values : Array[Double],
  period : Int,
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  if period <= 0 || n < 2 * period {
    return []
  }
  let result : Array[Int] = []
  for i in period..<n {
    let seasonal_val = values[i - period]
    let dev = (values[i] - seasonal_val).abs()
    if dev > threshold {
      result.push(i)
    }
  }
  result
}

/// 层级偏移异常 / Level shift anomaly.
pub fn level_shift_anomaly(
  values : Array[Double],
  window : Int,
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  if window <= 0 || n < 2 * window {
    return []
  }
  let result : Array[Int] = []
  for i in window..<(n - window) {
    let mut s1 = 0.0
    let mut s2 = 0.0
    for j in 0..<window {
      s1 = s1 + values[i - window + j]
      s2 = s2 + values[i + j]
    }
    let m1 = s1 / window.to_double()
    let m2 = s2 / window.to_double()
    if (m2 - m1).abs() > threshold {
      result.push(i)
    }
  }
  result
}

/// 尖峰检测 / Spike detection.
pub fn spike_detect(values : Array[Double], threshold : Double) -> Array[Int] {
  let n = values.length()
  if n < 3 {
    return []
  }
  let result : Array[Int] = []
  for i in 1..<(n - 1) {
    let left = values[i] - values[i - 1]
    let right = values[i] - values[i + 1]
    if left > threshold && right > threshold {
      result.push(i)
    }
  }
  result
}

/// 凹谷检测 / Dip detection.
pub fn dip_detect(values : Array[Double], threshold : Double) -> Array[Int] {
  let n = values.length()
  if n < 3 {
    return []
  }
  let result : Array[Int] = []
  for i in 1..<(n - 1) {
    let left = values[i - 1] - values[i]
    let right = values[i + 1] - values[i]
    if left > threshold && right > threshold {
      result.push(i)
    }
  }
  result
}

/// 变点检测 / Change point detection.
pub fn change_point_detect(
  values : Array[Double],
  min_len : Int,
) -> Array[Int] {
  let n = values.length()
  if n < 2 * min_len {
    return []
  }
  let result : Array[Int] = []
  for i in min_len..<(n - min_len) {
    let mut s1 = 0.0
    let mut s2 = 0.0
    for j in 0..<i {
      s1 = s1 + values[j]
    }
    for j in i..<n {
      s2 = s2 + values[j]
    }
    let m1 = s1 / i.to_double()
    let m2 = s2 / (n - i).to_double()
    let cost = (m2 - m1).abs() * i.to_double() * (n - i).to_double() / n.to_double()
    if cost > 1.0 {
      result.push(i)
    }
  }
  result
}

/// CUSUM 检验 / CUSUM test.
pub fn cusum_test(
  values : Array[Double],
  threshold : Double,
  drift : Double,
) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let m = mean_(values)
  let result : Array[Int] = []
  let mut s_pos = 0.0
  let mut s_neg = 0.0
  for i in 0..<n {
    let x = values[i] - m - drift
    s_pos = if s_pos + x > 0.0 { s_pos + x } else { 0.0 }
    s_neg = if s_neg - x > 0.0 { s_neg - x } else { 0.0 }
    if s_pos > threshold || s_neg > threshold {
      result.push(i)
    }
  }
  result
}

/// Page-Hinkley 检验 / Page-Hinkley test.
pub fn page_hinkley_test(
  values : Array[Double],
  threshold : Double,
  alpha : Double,
) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let m = mean_(values)
  let result : Array[Int] = []
  let mut cum_sum = 0.0
  let mut min_sum = 0.0
  for i in 0..<n {
    let x = values[i] - m - alpha
    cum_sum = cum_sum + x
    if cum_sum < min_sum {
      min_sum = cum_sum
    }
    let ph = cum_sum - min_sum
    if ph > threshold {
      result.push(i)
    }
  }
  result
}

/// 异常评分 / Anomaly score.
pub fn anomaly_score(values : Array[Double], index : Int) -> Double {
  let n = values.length()
  if n == 0 || index < 0 || index >= n {
    return 0.0
  }
  let m = mean_(values)
  let sd = std_dev_(values)
  if sd == 0.0 {
    return 0.0
  }
  let z = (values[index] - m) / sd
  let score = z.abs()
  if score > 3.0 { 1.0 } else { score / 3.0 }
}

/// 异常阈值 / Anomaly threshold.
pub fn anomaly_threshold(values : Array[Double], sensitivity : Double) -> Double {
  let sd = std_dev_(values)
  let m = mean_(values)
  let base = 3.0 - sensitivity
  if base < 0.5 {
    return m + 0.5 * sd
  }
  m + base * sd
}

/// 分类异常 / Classify anomaly.
pub fn classify_anomaly(score : Double) -> AnomalySeverity {
  if score < 0.25 {
    return Low
  }
  if score < 0.5 {
    return Medium
  }
  if score < 0.75 {
    return High
  }
  Critical
}

/// 构造异常结果 / Build anomaly result.
pub fn make_anomaly_result(
  index : Int,
  value : Double,
  score : Double,
  atype : AnomalyType,
) -> AnomalyResult {
  let severity = classify_anomaly(score)
  { index, value, score, anomaly_type: atype, severity }
}

/// 异常报告 / Anomaly report.
pub fn anomaly_report(results : Array[AnomalyResult]) -> String {
  if results.length() == 0 {
    return "No anomalies detected."
  }
  let mut report = "Anomaly Report:\n"
  for i in 0..<results.length() {
    let r = results[i]
    report = report + "  [" + i.to_string() + "] idx=" + r.index.to_string() + " score=" + r.score.to_string() + "\n"
  }
  report = report + "Total: " + results.length().to_string() + " anomalies."
  report
}

/// 统计异常 / Statistical anomaly.
pub fn statistical_anomaly(
  values : Array[Double],
  threshold : Double,
) -> Array[AnomalyResult] {
  let z_indices = z_score_anomaly(values, threshold)
  let result : Array[AnomalyResult] = []
  for i in 0..<z_indices.length() {
    let idx = z_indices[i]
    let score = anomaly_score(values, idx)
    result.push(make_anomaly_result(idx, values[idx], score, PointAnomaly))
  }
  result
}

/// 模式异常 / Pattern anomaly.
pub fn pattern_anomaly(
  values : Array[Double],
  pattern : Array[Double],
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  let pl = pattern.length()
  if pl == 0 || n < pl {
    return []
  }
  let result : Array[Int] = []
  for i in 0..=(n - pl) {
    let mut diff = 0.0
    for j in 0..<pl {
      let d = values[i + j] - pattern[j]
      diff = diff + d * d
    }
    if sqrt_(diff) > threshold {
      result.push(i)
    }
  }
  result
}

/// 上下文异常 / Contextual anomaly.
pub fn contextual_anomaly(
  values : Array[Double],
  context : Array[Double],
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  if n != context.length() || n == 0 {
    return []
  }
  let result : Array[Int] = []
  let cm = mean_(context)
  let csd = std_dev_(context)
  if csd == 0.0 {
    return result
  }
  let vm = mean_(values)
  let vsd = std_dev_(values)
  if vsd == 0.0 {
    return result
  }
  for i in 0..<n {
    let ctx_z = (context[i] - cm) / csd
    let val_z = (values[i] - vm) / vsd
    if ctx_z.abs() > threshold && val_z.abs() > threshold {
      result.push(i)
    }
  }
  result
}

/// 集体异常 / Collective anomaly.
pub fn collective_anomaly(
  values : Array[Double],
  window : Int,
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  if window <= 0 || n < window {
    return []
  }
  let result : Array[Int] = []
  let global_m = mean_(values)
  for i in 0..=(n - window) {
    let mut sum = 0.0
    for j in 0..<window {
      sum = sum + values[i + j]
    }
    let local_m = sum / window.to_double()
    if (local_m - global_m).abs() > threshold {
      for j in 0..<window {
        result.push(i + j)
      }
    }
  }
  result
}

/// 点异常 / Point anomaly.
pub fn point_anomaly(
  values : Array[Double],
  threshold : Double,
) -> Array[AnomalyResult] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let m = mean_(values)
  let sd = std_dev_(values)
  let result : Array[AnomalyResult] = []
  if sd == 0.0 {
    return result
  }
  for i in 0..<n {
    let z = (values[i] - m) / sd
    if z.abs() > threshold {
      let score = z.abs() / 3.0
      result.push(make_anomaly_result(i, values[i], score, PointAnomaly))
    }
  }
  result
}

/// 包标识 / Package id.
pub fn anomaly_id() -> String {
  let pkg = "datatemporal/anomaly"
  let version = "S12.6"
  let algorithms = "z-score,iqr,lof,iforest"
  let result = pkg + " (" + version + "): " + algorithms
  if result.length() > 0 {
    result
  } else {
    pkg
  }
}