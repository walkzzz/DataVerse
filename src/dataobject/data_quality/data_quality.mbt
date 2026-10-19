///|
/// # dataobject/data_quality 数据质量 / Data Quality
///
/// 完整性 / 唯一性 / 有效性 / 一致性 / 准确性 / 时效性。架构 §4.2。
/// S12.9 提供数据质量评估算子。
///
/// # Data quality
///
/// Completeness / uniqueness / validity / consistency / accuracy / timeliness. See architecture §4.2.

/// 质量维度 / Quality dimension.
pub(all) enum QualityDimension {
  Completeness
  Uniqueness
  Validity
  Consistency
  Accuracy
  Timeliness
} derive(Debug, Eq)

pub extend QualityDimension with Eq::{equal, not_equal}
pub extend QualityDimension with Debug::{to_repr}

/// 质量等级 / Quality level.
pub(all) enum QualityLevel {
  Excellent
  Good
  Fair
  Poor
} derive(Debug, Eq)

pub extend QualityLevel with Eq::{equal, not_equal}
pub extend QualityLevel with Debug::{to_repr}

/// 质量结果 / Quality result.
pub struct QualityResult {
  dimension : QualityDimension
  score : Double
  level : QualityLevel
  details : String
} derive(Debug, Eq)

pub extend QualityResult with Eq::{equal, not_equal}
pub extend QualityResult with Debug::{to_repr}

/// 质量规则 / Quality rule.
pub struct QualityRule {
  name : String
  dimension : QualityDimension
  weight : Double
} derive(Debug, Eq)

pub extend QualityRule with Eq::{equal, not_equal}
pub extend QualityRule with Debug::{to_repr}

/// 列概要 / Column profile.
pub struct ColumnProfile {
  name : String
  count : Int
  nulls : Int
  distinct : Int
  mean : Double
} derive(Debug, Eq)

pub extend ColumnProfile with Eq::{equal, not_equal}
pub extend ColumnProfile with Debug::{to_repr}

/// 完整性 / Completeness (non-null ratio).
pub fn completeness(values : Array[Option[String]]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut non_null = 0
  for i in 0..<n {
    if values[i] is Some(_) {
      non_null = non_null + 1
    }
  }
  non_null.to_double() / n.to_double()
}

/// 唯一性 / Uniqueness (distinct ratio).
pub fn uniqueness(values : Array[String]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let seen : Array[String] = []
  for i in 0..<n {
    let mut found = false
    for j in 0..<seen.length() {
      if seen[j] == values[i] {
        found = true
        break
      }
    }
    if not(found) {
      seen.push(values[i])
    }
  }
  seen.length().to_double() / n.to_double()
}

/// 有效性 / Validity (in-domain ratio).
pub fn validity(values : Array[String], domain : Array[String]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut valid = 0
  for i in 0..<n {
    let mut found = false
    for j in 0..<domain.length() {
      if domain[j] == values[i] {
        found = true
        break
      }
    }
    if found {
      valid = valid + 1
    }
  }
  valid.to_double() / n.to_double()
}

/// 一致性 / Consistency (cross-column agreement).
pub fn consistency(col_a : Array[String], col_b : Array[String]) -> Double {
  let n = col_a.length()
  if n == 0 || n != col_b.length() {
    return 0.0
  }
  let mut consistent = 0
  for i in 0..<n {
    if col_a[i] == col_b[i] {
      consistent = consistent + 1
    }
  }
  consistent.to_double() / n.to_double()
}

/// 准确性 / Accuracy (closeness to reference).
pub fn accuracy(
  values : Array[Double],
  reference : Array[Double],
  tolerance : Double,
) -> Double {
  let n = values.length()
  if n == 0 || n != reference.length() {
    return 0.0
  }
  let mut accurate = 0
  for i in 0..<n {
    if (values[i] - reference[i]).abs() <= tolerance {
      accurate = accurate + 1
    }
  }
  accurate.to_double() / n.to_double()
}

/// 时效性 / Timeliness (freshness).
pub fn timeliness(
  timestamps : Array[Double],
  current_time : Double,
  max_age : Double,
) -> Double {
  let n = timestamps.length()
  if n == 0 {
    return 0.0
  }
  let mut fresh = 0
  for i in 0..<n {
    let age = current_time - timestamps[i]
    if age >= 0.0 && age <= max_age {
      fresh = fresh + 1
    }
  }
  fresh.to_double() / n.to_double()
}

/// 空值计数 / Null count.
pub fn null_count(values : Array[Option[String]]) -> Int {
  let n = values.length()
  if n == 0 {
    return 0
  }
  let mut count = 0
  for i in 0..<n {
    if values[i] is None {
      count = count + 1
    }
  }
  count
}

/// 空值率 / Null rate.
pub fn null_rate(values : Array[Option[String]]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let count = null_count(values)
  count.to_double() / n.to_double()
}

/// 去重计数 / Distinct count.
pub fn distinct_count(values : Array[String]) -> Int {
  let n = values.length()
  if n == 0 {
    return 0
  }
  let seen : Array[String] = []
  for i in 0..<n {
    let mut found = false
    for j in 0..<seen.length() {
      if seen[j] == values[i] {
        found = true
        break
      }
    }
    if not(found) {
      seen.push(values[i])
    }
  }
  seen.length()
}

/// 重复计数 / Duplicate count.
pub fn duplicate_count(values : Array[String]) -> Int {
  let n = values.length()
  if n == 0 {
    return 0
  }
  if n == 1 {
    return 0
  }
  let distinct = distinct_count(values)
  n - distinct
}

/// 值域检查 / Value range check.
pub fn value_range_check(
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

/// 模式检查 / Pattern check (contains substring).
pub fn pattern_check(values : Array[String], pattern : String) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<n {
    if not(values[i].contains(pattern)) {
      result.push(i)
    }
  }
  result
}

/// 类型检查 / Type check (non-empty).
pub fn type_check(values : Array[String]) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<n {
    let v = values[i]
    if v.length() == 0 {
      result.push(i)
    }
  }
  result
}

/// 引用完整性 / Referential integrity.
pub fn referential_integrity(
  foreign_keys : Array[String],
  primary_keys : Array[String],
) -> Double {
  let n = foreign_keys.length()
  if n == 0 {
    return 1.0
  }
  let mut valid = 0
  for i in 0..<n {
    let mut found = false
    for j in 0..<primary_keys.length() {
      if primary_keys[j] == foreign_keys[i] {
        found = true
        break
      }
    }
    if found {
      valid = valid + 1
    }
  }
  valid.to_double() / n.to_double()
}

/// 域完整性 / Domain integrity.
pub fn domain_integrity(
  values : Array[String],
  allowed : Array[String],
) -> Double {
  let n = values.length()
  if n == 0 {
    return 1.0
  }
  let mut valid = 0
  for i in 0..<n {
    let mut found = false
    for j in 0..<allowed.length() {
      if allowed[j] == values[i] {
        found = true
        break
      }
    }
    if found {
      valid = valid + 1
    }
  }
  valid.to_double() / n.to_double()
}

/// 实体完整性 / Entity integrity (non-null primary key).
pub fn entity_integrity(primary_keys : Array[Option[String]]) -> Double {
  let n = primary_keys.length()
  if n == 0 {
    return 1.0
  }
  let mut valid = 0
  for i in 0..<n {
    if primary_keys[i] is Some(_) {
      valid = valid + 1
    }
  }
  valid.to_double() / n.to_double()
}

/// 质量评分 / Overall quality score.
pub fn quality_score(results : Array[QualityResult]) -> Double {
  let n = results.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + results[i].score
  }
  sum / n.to_double()
}

/// 质量报告 / Quality report.
pub fn quality_report(results : Array[QualityResult]) -> String {
  if results.length() == 0 {
    return "No quality results."
  }
  let mut report = "Quality Report:\n"
  for i in 0..<results.length() {
    let r = results[i]
    report = report + "  [" + i.to_string() + "] score=" + r.score.to_string() + "\n"
  }
  let overall = quality_score(results)
  report = report + "Overall: " + overall.to_string()
  report
}

/// 质量维度 / Quality dimension from score.
pub fn quality_dimension(score : Double) -> QualityLevel {
  if score >= 0.9 {
    return Excellent
  }
  if score >= 0.7 {
    return Good
  }
  if score >= 0.5 {
    return Fair
  }
  Poor
}

/// 构造质量结果 / Build quality result.
pub fn make_quality_result(
  dimension : QualityDimension,
  score : Double,
  details : String,
) -> QualityResult {
  let level = quality_dimension(score)
  { dimension, score, level, details }
}

/// 构造质量规则 / Build quality rule.
pub fn make_quality_rule(
  name : String,
  dimension : QualityDimension,
  weight : Double,
) -> QualityRule {
  let w = if weight < 0.0 { 0.0 } else { weight }
  { name, dimension, weight: w }
}

/// 检查缺失 / Check missing values.
pub fn check_missing(values : Array[Option[String]]) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<n {
    if values[i] is None {
      result.push(i)
    }
  }
  result
}

/// 检查离群值 / Check outliers.
pub fn check_outlier(
  values : Array[Double],
  threshold : Double,
) -> Array[Int] {
  let n = values.length()
  if n < 2 {
    return []
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + values[i]
  }
  let m = sum / n.to_double()
  let result : Array[Int] = []
  for i in 0..<n {
    if (values[i] - m).abs() > threshold {
      result.push(i)
    }
  }
  result
}

/// 检查格式 / Check format (non-empty and no whitespace-only).
pub fn check_format(values : Array[String]) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<n {
    let v = values[i]
    if v.length() == 0 {
      result.push(i)
    }
  }
  result
}

/// 检查模式 / Check schema (column count consistency).
pub fn check_schema(
  rows : Array[Array[String]],
  expected_cols : Int,
) -> Array[Int] {
  let n = rows.length()
  if n == 0 {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<n {
    if rows[i].length() != expected_cols {
      result.push(i)
    }
  }
  result
}

/// 数据概要 / Data profiling summary.
pub fn data_profiling(values : Array[String]) -> String {
  let n = values.length()
  if n == 0 {
    return "Empty dataset."
  }
  let distinct = distinct_count(values)
  let dup = n - distinct
  let result = "count=" + n.to_string() + " distinct=" + distinct.to_string() + " dup=" + dup.to_string()
  result
}

/// 列概要 / Column profile.
pub fn column_profile(name : String, values : Array[Double]) -> ColumnProfile {
  let n = values.length()
  if n == 0 {
    return { name, count: 0, nulls: 0, distinct: 0, mean: 0.0 }
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + values[i]
  }
  let mean = sum / n.to_double()
  let seen : Array[Double] = []
  for i in 0..<n {
    let mut found = false
    for j in 0..<seen.length() {
      if seen[j] == values[i] {
        found = true
        break
      }
    }
    if not(found) {
      seen.push(values[i])
    }
  }
  { name, count: n, nulls: 0, distinct: seen.length(), mean }
}

/// 表概要 / Table profile.
pub fn table_profile(columns : Array[Array[String]]) -> String {
  let n = columns.length()
  if n == 0 {
    return "Empty table."
  }
  let mut report = "Table Profile:\n"
  for i in 0..<n {
    let col = columns[i]
    let d = distinct_count(col)
    report = report + "  col" + i.to_string() + ": count=" + col.length().to_string() + " distinct=" + d.to_string() + "\n"
  }
  report
}

/// 相关性质量 / Correlation quality.
pub fn correlation_quality(
  col_a : Array[Double],
  col_b : Array[Double],
) -> Double {
  let n = col_a.length()
  if n < 2 || n != col_b.length() {
    return 0.0
  }
  let mut sa = 0.0
  let mut sb = 0.0
  for i in 0..<n {
    sa = sa + col_a[i]
    sb = sb + col_b[i]
  }
  let ma = sa / n.to_double()
  let mb = sb / n.to_double()
  let mut cov = 0.0
  let mut va = 0.0
  let mut vb = 0.0
  for i in 0..<n {
    let da = col_a[i] - ma
    let db = col_b[i] - mb
    cov = cov + da * db
    va = va + da * da
    vb = vb + db * db
  }
  if va == 0.0 || vb == 0.0 {
    return 0.0
  }
  cov / (va * vb).abs().sqrt()
}

/// 分布质量 / Distribution quality (uniform check).
pub fn distribution_quality(values : Array[String]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let distinct = distinct_count(values)
  if distinct == 0 {
    return 0.0
  }
  let expected = n.to_double() / distinct.to_double()
  let seen : Array[String] = []
  let counts : Array[Int] = []
  for i in 0..<n {
    let mut idx = -1
    for j in 0..<seen.length() {
      if seen[j] == values[i] {
        idx = j
        break
      }
    }
    if idx >= 0 {
      counts[idx] = counts[idx] + 1
    } else {
      seen.push(values[i])
      counts.push(1)
    }
  }
  let mut chi = 0.0
  for i in 0..<counts.length() {
    let diff = counts[i].to_double() - expected
    chi = chi + diff * diff / expected
  }
  1.0 / (1.0 + chi)
}

/// 缺失模式 / Missing pattern (MCAR check).
pub fn missing_pattern(values : Array[Option[String]]) -> String {
  let n = values.length()
  if n == 0 {
    return "empty"
  }
  let mut missing = 0
  for i in 0..<n {
    if values[i] is None {
      missing = missing + 1
    }
  }
  if missing == 0 {
    return "complete"
  }
  if missing == n {
    return "all-missing"
  }
  let rate = missing.to_double() / n.to_double()
  if rate < 0.05 {
    return "sparse-missing"
  }
  "general-missing"
}

/// 离群值检测质量 / Outlier detection quality.
pub fn outlier_detection_quality(
  values : Array[Double],
  threshold : Double,
) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + values[i]
  }
  let m = sum / n.to_double()
  let mut variance = 0.0
  for i in 0..<n {
    let d = values[i] - m
    variance = variance + d * d
  }
  variance = variance / n.to_double()
  let sd = variance.abs().sqrt()
  if sd == 0.0 {
    return 1.0
  }
  let mut outliers = 0
  for i in 0..<n {
    if (values[i] - m).abs() / sd > threshold {
      outliers = outliers + 1
    }
  }
  1.0 - outliers.to_double() / n.to_double()
}

/// 准确率 / Accuracy score (classification).
pub fn accuracy_score(
  predicted : Array[Bool],
  actual : Array[Bool],
) -> Double {
  let n = predicted.length()
  if n == 0 || n != actual.length() {
    return 0.0
  }
  let mut correct = 0
  for i in 0..<n {
    if predicted[i] == actual[i] {
      correct = correct + 1
    }
  }
  correct.to_double() / n.to_double()
}

/// 精确率 / Precision score.
pub fn precision_score(
  predicted : Array[Bool],
  actual : Array[Bool],
) -> Double {
  let n = predicted.length()
  if n == 0 || n != actual.length() {
    return 0.0
  }
  let mut tp = 0
  let mut fp = 0
  for i in 0..<n {
    if predicted[i] {
      if actual[i] {
        tp = tp + 1
      } else {
        fp = fp + 1
      }
    }
  }
  if tp + fp == 0 {
    return 0.0
  }
  tp.to_double() / (tp + fp).to_double()
}

/// 召回率 / Recall score.
pub fn recall_score(
  predicted : Array[Bool],
  actual : Array[Bool],
) -> Double {
  let n = predicted.length()
  if n == 0 || n != actual.length() {
    return 0.0
  }
  let mut tp = 0
  let mut fn_ = 0
  for i in 0..<n {
    if actual[i] {
      if predicted[i] {
        tp = tp + 1
      } else {
        fn_ = fn_ + 1
      }
    }
  }
  if tp + fn_ == 0 {
    return 0.0
  }
  tp.to_double() / (tp + fn_).to_double()
}

/// F1 分数 / F1 score.
pub fn f1_score(
  predicted : Array[Bool],
  actual : Array[Bool],
) -> Double {
  let p = precision_score(predicted, actual)
  let r = recall_score(predicted, actual)
  if p + r == 0.0 {
    return 0.0
  }
  2.0 * p * r / (p + r)
}

/// 包标识 / Package id.
pub fn data_quality_id() -> String {
  let pkg = "dataobject/data_quality"
  let version = "S12.9"
  let dims = "completeness,uniqueness,validity,consistency,accuracy,timeliness"
  let result = pkg + " (" + version + "): " + dims
  if result.length() > 0 {
    result
  } else {
    pkg
  }
}