///|
/// # dataobject/data_profiling 数据剖析 / Data Profiling
///
/// 列剖析 / 表剖析 / 数据集剖析 / 分布 / 异常 / 漂移 / 质量评分。
/// S12.10 新建：50+ pub fn 数据剖析算子。
///
/// # Data profiling
///
/// Column / table / dataset profiling, distribution, outlier, drift, quality score.

const PROF_LARGE_DOUBLE : Double = 999999999999999.0
const PROF_EPS : Double = 0.0000000000000001

/// 列类型 / Column kind.
pub(all) enum ColumnKind {
  NumericKind
  CategoricalKind
  DatetimeKind
  TextKind
  UnknownKind
} derive(Debug, Eq)

pub extend ColumnKind with Eq::{equal, not_equal}
pub extend ColumnKind with Debug::{to_repr}

/// 剖析配置 / Profiling config.
pub struct ProfileConfig {
  sample_size : Int
  bin_count : Int
  outlier_method : String
  drift_threshold : Double
  enable_histogram : Bool
  enable_correlation : Bool
}

/// 列剖析结果 / Column profile result.
pub struct ColumnProfileResult {
  name : String
  kind : ColumnKind
  count : Int
  nulls : Int
  distinct : Int
  duplicates : Int
  min_val : Double
  max_val : Double
  mean_val : Double
  std_val : Double
  completeness : Double
  uniqueness : Double
  quality_score : Double
}

/// 表剖析结果 / Table profile result.
pub struct TableProfileResult {
  table_name : String
  row_count : Int
  col_count : Int
  columns : Array[ColumnProfileResult]
  overall_quality : Double
}

/// 数据集剖析结果 / Dataset profile result.
pub struct DatasetProfileResult {
  dataset_name : String
  tables : Array[TableProfileResult]
  total_rows : Int
  total_cols : Int
  overall_quality : Double
}

/// 直方图 / Histogram.
pub struct Histogram {
  bin_edges : Array[Double]
  bin_counts : Array[Int]
  total : Int
}

/// 分位数 / Quantiles.
pub struct Quantiles {
  q0 : Double
  q1 : Double
  q2 : Double
  q3 : Double
  q4 : Double
}

/// 异常剖析 / Anomaly profile.
pub struct AnomalyProfile {
  outlier_indices : Array[Int]
  outlier_count : Int
  outlier_ratio : Double
  method_ : String
}

/// 漂移结果 / Drift result.
pub struct DriftResult {
  drift_score : Double
  is_drifted : Bool
  threshold : Double
}

/// 剖析摘要 / Profile summary.
pub struct ProfileSummary {
  total_count : Int
  missing_count : Int
  unique_count : Int
  duplicate_count : Int
  mean_value : Double
  std_value : Double
  quality_score : Double
}

/// 剖析报告 / Profile report.
pub struct ProfileReport {
  title : String
  summaries : Array[ProfileSummary]
  generated_at : Double
}

/// 剖析比较 / Profile comparison.
pub struct ProfileCompare {
  base_name : String
  target_name : String
  diff_count : Int
  diff_mean : Double
  diff_std : Double
  diff_quality : Double
}

///===
/// 辅助数学函数 / Helper math (private)

fn prof_sqrt(x : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let mut guess = x / 2.0
  if guess == 0.0 {
    guess = 1.0
  }
  for _ in 0..<60 {
    guess = (guess + x / guess) / 2.0
  }
  guess
}

fn prof_abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

fn prof_ln(x : Double) -> Double {
  if x <= 0.0 {
    return -PROF_LARGE_DOUBLE
  }
  if x == 1.0 {
    return 0.0
  }
  let mut y = x
  let mut m = 0
  let e_euler = 2.718281828459045
  while y > 2.0 {
    y = y / e_euler
    m = m + 1
  }
  while y < 0.5 {
    y = y * e_euler
    m = m - 1
  }
  let t = (y - 1.0) / (y + 1.0)
  let mut result = 0.0
  let mut t_pow = t
  for k in 0..<80 {
    let term = t_pow / (2 * k + 1).to_double()
    result = result + term
    t_pow = t_pow * t * t
    if prof_abs(term) < PROF_EPS {
      break
    }
  }
  result * 2.0 + m.to_double()
}

///===
/// 构造 / Constructors

/// 构造剖析配置 / Create profile config.
pub fn make_profile_config(
  sample_size : Int,
  bin_count : Int,
  outlier_method : String,
  drift_threshold : Double,
) -> ProfileConfig {
  { sample_size: sample_size, bin_count: bin_count, outlier_method: outlier_method, drift_threshold: drift_threshold, enable_histogram: true, enable_correlation: true }
}

/// 构造列剖析结果 / Create column profile result.
pub fn make_column_profile_result(
  name : String,
  kind : ColumnKind,
  count : Int,
  nulls : Int,
  distinct : Int,
  duplicates : Int,
  min_val : Double,
  max_val : Double,
  mean_val : Double,
  std_val : Double,
  completeness : Double,
  uniqueness : Double,
  quality_score : Double,
) -> ColumnProfileResult {
  { name: name, kind: kind, count: count, nulls: nulls, distinct: distinct, duplicates: duplicates, min_val: min_val, max_val: max_val, mean_val: mean_val, std_val: std_val, completeness: completeness, uniqueness: uniqueness, quality_score: quality_score }
}

/// 构造表剖析结果 / Create table profile result.
pub fn make_table_profile_result(
  table_name : String,
  row_count : Int,
  columns : Array[ColumnProfileResult],
) -> TableProfileResult {
  let col_count = columns.length()
  let mut q_sum = 0.0
  for i in 0..<col_count {
    q_sum = q_sum + columns[i].quality_score
  }
  let overall = if col_count == 0 { 0.0 } else { q_sum / col_count.to_double() }
  { table_name: table_name, row_count: row_count, col_count: col_count, columns: columns, overall_quality: overall }
}

/// 构造数据集剖析结果 / Create dataset profile result.
pub fn make_dataset_profile_result(
  dataset_name : String,
  tables : Array[TableProfileResult],
) -> DatasetProfileResult {
  let mut total_rows = 0
  let mut total_cols = 0
  let mut q_sum = 0.0
  for i in 0..<tables.length() {
    total_rows = total_rows + tables[i].row_count
    total_cols = total_cols + tables[i].col_count
    q_sum = q_sum + tables[i].overall_quality
  }
  let n = tables.length()
  let overall = if n == 0 { 0.0 } else { q_sum / n.to_double() }
  { dataset_name: dataset_name, tables: tables, total_rows: total_rows, total_cols: total_cols, overall_quality: overall }
}

/// 构造剖析 / Create profile.
pub fn make_profile(
  name : String,
  kind : ColumnKind,
  values : Array[Double],
) -> ColumnProfileResult {
  let count = values.length()
  let nulls = profile_missing_count(values)
  let distinct = profile_distinct_count(values)
  let duplicates = count - distinct
  let min_val = profile_min(values)
  let max_val = profile_max(values)
  let mean_val = profile_mean_p(values)
  let std_val = profile_std_p(values)
  let completeness = if count == 0 { 0.0 } else { (count - nulls).to_double() / count.to_double() }
  let uniqueness = if count == 0 { 0.0 } else { distinct.to_double() / count.to_double() }
  let quality = (completeness + uniqueness) / 2.0
  make_column_profile_result(name, kind, count, nulls, distinct, duplicates, min_val, max_val, mean_val, std_val, completeness, uniqueness, quality)
}

///===
/// 基础统计 / Basic statistics

/// 最小值 / Minimum.
pub fn profile_min(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut m = values[0]
  for i in 1..<n {
    if values[i] < m {
      m = values[i]
    }
  }
  m
}

/// 最大值 / Maximum.
pub fn profile_max(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut m = values[0]
  for i in 1..<n {
    if values[i] > m {
      m = values[i]
    }
  }
  m
}

/// 均值 / Mean.
pub fn profile_mean_p(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut s = 0.0
  for i in 0..<n {
    s = s + values[i]
  }
  s / n.to_double()
}

/// 中位数 / Median.
pub fn profile_median_p(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let sorted : Array[Double] = []
  for i in 0..<n {
    sorted.push(values[i])
  }
  sorted.sort_by(fn(a, b) { a.compare(b) })
  let mid = n / 2
  if n % 2 == 1 {
    sorted[mid]
  } else {
    (sorted[mid - 1] + sorted[mid]) / 2.0
  }
}

/// 标准差 / Standard deviation (population).
pub fn profile_std_p(values : Array[Double]) -> Double {
  prof_sqrt(profile_var_p(values))
}

/// 方差 / Variance (population).
pub fn profile_var_p(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let m = profile_mean_p(values)
  let mut s = 0.0
  for i in 0..<n {
    let d = values[i] - m
    s = s + d * d
  }
  s / n.to_double()
}

/// 偏度 / Skewness.
pub fn profile_skew_p(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let m = profile_mean_p(values)
  let std = profile_std_p(values)
  if std == 0.0 {
    return 0.0
  }
  let mut s = 0.0
  for i in 0..<n {
    let d = (values[i] - m) / std
    s = s + d * d * d
  }
  s / n.to_double()
}

/// 峰度 / Kurtosis.
pub fn profile_kurt_p(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let m = profile_mean_p(values)
  let std = profile_std_p(values)
  if std == 0.0 {
    return 0.0
  }
  let mut s = 0.0
  for i in 0..<n {
    let d = (values[i] - m) / std
    s = s + d * d * d * d
  }
  s / n.to_double() - 3.0
}

///===
/// 缺失 / 重复 / 唯一 / Missing / Duplicate / Unique

/// 缺失计数 / Missing count (NaN represented as 0.0 sentinel).
pub fn profile_missing_count(values : Array[Double]) -> Int {
  let mut count = 0
  for i in 0..<values.length() {
    if values[i] == 0.0 {
      count = count + 1
    }
  }
  count
}

/// 缺失剖析 / Missing profile.
pub fn profile_missing(values : Array[Double]) -> (Int, Double) {
  let n = values.length()
  let count = profile_missing_count(values)
  let ratio = if n == 0 { 0.0 } else { count.to_double() / n.to_double() }
  (count, ratio)
}

/// 唯一计数 / Distinct count.
pub fn profile_unique(values : Array[Double]) -> Int {
  profile_distinct_count(values)
}

/// 唯一剖析 / Unique profile.
pub fn profile_distinct_count(values : Array[Double]) -> Int {
  let n = values.length()
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
  seen.length()
}

/// 重复剖析 / Duplicate profile.
pub fn profile_duplicate(values : Array[Double]) -> (Int, Double) {
  let n = values.length()
  let distinct = profile_distinct_count(values)
  let dup = n - distinct
  let ratio = if n == 0 { 0.0 } else { dup.to_double() / n.to_double() }
  (dup, ratio)
}

///===
/// 分布 / 直方图 / 分位数 / Distribution / Histogram / Quantiles

/// 分布剖析 / Distribution profile (mean, std, skew, kurt).
pub fn profile_distribution(values : Array[Double]) -> (Double, Double, Double, Double) {
  (profile_mean_p(values), profile_std_p(values), profile_skew_p(values), profile_kurt_p(values))
}

/// 直方图 / Histogram.
pub fn profile_histogram(values : Array[Double], bin_count : Int) -> Histogram {
  let n = values.length()
  if n == 0 || bin_count <= 0 {
    return { bin_edges: [], bin_counts: [], total: 0 }
  }
  let lo = profile_min(values)
  let hi = profile_max(values)
  let range = hi - lo
  if range == 0.0 {
    let edges : Array[Double] = [lo]
    let counts : Array[Int] = [n]
    return { bin_edges: edges, bin_counts: counts, total: n }
  }
  let width = range / bin_count.to_double()
  let edges : Array[Double] = []
  let counts : Array[Int] = []
  for i in 0..<=bin_count {
    edges.push(lo + i.to_double() * width)
  }
  for _ in 0..<bin_count {
    counts.push(0)
  }
  for i in 0..<n {
    let mut idx = ((values[i] - lo) / width).to_int()
    if idx < 0 {
      idx = 0
    }
    if idx >= bin_count {
      idx = bin_count - 1
    }
    counts[idx] = counts[idx] + 1
  }
  { bin_edges: edges, bin_counts: counts, total: n }
}

/// 分位数 / Quantiles (0, 25, 50, 75, 100 percentiles).
pub fn profile_quantiles(values : Array[Double]) -> Quantiles {
  let n = values.length()
  if n == 0 {
    return { q0: 0.0, q1: 0.0, q2: 0.0, q3: 0.0, q4: 0.0 }
  }
  let sorted : Array[Double] = []
  for i in 0..<n {
    sorted.push(values[i])
  }
  sorted.sort_by(fn(a, b) { a.compare(b) })
  let q0 = sorted[0]
  let q4 = sorted[n - 1]
  let q1 = sorted[(n - 1) / 4]
  let q2 = sorted[(n - 1) / 2]
  let q3 = sorted[3 * (n - 1) / 4]
  { q0: q0, q1: q1, q2: q2, q3: q3, q4: q4 }
}

///===
/// 相关 / 协方差 / 互信息 / Correlation / Covariance / Mutual info

/// 相关 / Correlation.
pub fn profile_correlation(a : Array[Double], b : Array[Double]) -> Double {
  let n = a.length()
  if n == 0 || n != b.length() {
    return 0.0
  }
  let ma = profile_mean_p(a)
  let mb = profile_mean_p(b)
  let mut cov = 0.0
  let mut va = 0.0
  let mut vb = 0.0
  for i in 0..<n {
    let da = a[i] - ma
    let db = b[i] - mb
    cov = cov + da * db
    va = va + da * da
    vb = vb + db * db
  }
  let denom = prof_sqrt(va * vb)
  if denom == 0.0 {
    0.0
  } else {
    cov / denom
  }
}

/// 协方差 / Covariance.
pub fn profile_covariance(a : Array[Double], b : Array[Double]) -> Double {
  let n = a.length()
  if n == 0 || n != b.length() {
    return 0.0
  }
  let ma = profile_mean_p(a)
  let mb = profile_mean_p(b)
  let mut cov = 0.0
  for i in 0..<n {
    cov = cov + (a[i] - ma) * (b[i] - mb)
  }
  cov / n.to_double()
}

/// 互信息 / Mutual information (binned approximation).
pub fn profile_mutual_info(a : Array[Double], b : Array[Double], bins : Int) -> Double {
  let n = a.length()
  if n == 0 || n != b.length() || bins <= 0 {
    return 0.0
  }
  let ha = profile_histogram(a, bins)
  let hb = profile_histogram(b, bins)
  let lo_a = ha.bin_edges[0]
  let w_a = if ha.bin_edges.length() > 1 { ha.bin_edges[1] - ha.bin_edges[0] } else { 1.0 }
  let lo_b = hb.bin_edges[0]
  let w_b = if hb.bin_edges.length() > 1 { hb.bin_edges[1] - hb.bin_edges[0] } else { 1.0 }
  let mut mi = 0.0
  for i in 0..<bins {
    for j in 0..<bins {
      let mut c_ij = 0
      for k in 0..<n {
        let mut ia = ((a[k] - lo_a) / w_a).to_int()
        if ia < 0 {
          ia = 0
        }
        if ia >= bins {
          ia = bins - 1
        }
        let mut ib = ((b[k] - lo_b) / w_b).to_int()
        if ib < 0 {
          ib = 0
        }
        if ib >= bins {
          ib = bins - 1
        }
        if ia == i && ib == j {
          c_ij = c_ij + 1
        }
      }
      if c_ij > 0 {
        let p_ij = c_ij.to_double() / n.to_double()
        let p_i = ha.bin_counts[i].to_double() / n.to_double()
        let p_j = hb.bin_counts[j].to_double() / n.to_double()
        mi = mi + p_ij * (prof_ln(p_ij) - prof_ln(p_i) - prof_ln(p_j))
      }
    }
  }
  if mi < 0.0 {
    0.0
  } else {
    mi
  }
}

///===
/// 异常 / 漂移 / Outlier / Drift

/// 异常值 / Outlier detection (z-score method_).
pub fn profile_outlier(values : Array[Double], threshold : Double) -> Array[Int] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let m = profile_mean_p(values)
  let std = profile_std_p(values)
  if std == 0.0 {
    return []
  }
  let result : Array[Int] = []
  for i in 0..<n {
    let z = prof_abs((values[i] - m) / std)
    if z > threshold {
      result.push(i)
    }
  }
  result
}

/// 异常剖析 / Anomaly profile.
pub fn profile_anomaly_profile(values : Array[Double], threshold : Double) -> AnomalyProfile {
  let outliers = profile_outlier(values, threshold)
  let n = values.length()
  let ratio = if n == 0 { 0.0 } else { outliers.length().to_double() / n.to_double() }
  { outlier_indices: outliers, outlier_count: outliers.length(), outlier_ratio: ratio, method_: "zscore" }
}

/// 漂移剖析 / Drift profile.
pub fn profile_drift(base : Array[Double], target : Array[Double], threshold : Double) -> DriftResult {
  let mb = profile_mean_p(base)
  let mt = profile_mean_p(target)
  let sb = profile_std_p(base)
  let st = profile_std_p(target)
  let mean_diff = prof_abs(mt - mb)
  let std_diff = prof_abs(st - sb)
  let drift = mean_diff + std_diff
  { drift_score: drift, is_drifted: drift > threshold, threshold: threshold }
}

///===
/// 熵 / 基数 / 密度 / Entropy / Cardinality / Density

/// 熵 / Shannon entropy.
pub fn profile_entropy(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let unique : Array[Double] = []
  let counts : Array[Int] = []
  for i in 0..<n {
    let mut idx = -1
    for j in 0..<unique.length() {
      if unique[j] == values[i] {
        idx = j
        break
      }
    }
    if idx < 0 {
      unique.push(values[i])
      counts.push(1)
    } else {
      counts[idx] = counts[idx] + 1
    }
  }
  let mut h = 0.0
  for i in 0..<counts.length() {
    let p = counts[i].to_double() / n.to_double()
    h = h - p * prof_ln(p)
  }
  h
}

/// 基数 / Cardinality.
pub fn profile_cardinality(values : Array[Double]) -> Int {
  profile_distinct_count(values)
}

/// 密度 / Density (distinct / count).
pub fn profile_density(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  profile_distinct_count(values).to_double() / n.to_double()
}

///===
/// 值计数 / 频率 / 顶部值 / Value counts / Frequency / Top values

/// 值计数 / Value counts.
pub fn profile_value_counts(values : Array[Double]) -> Array[(Double, Int)] {
  let unique : Array[Double] = []
  let counts : Array[Int] = []
  for i in 0..<values.length() {
    let mut idx = -1
    for j in 0..<unique.length() {
      if unique[j] == values[i] {
        idx = j
        break
      }
    }
    if idx < 0 {
      unique.push(values[i])
      counts.push(1)
    } else {
      counts[idx] = counts[idx] + 1
    }
  }
  let result : Array[(Double, Int)] = []
  for i in 0..<unique.length() {
    result.push((unique[i], counts[i]))
  }
  result.sort_by(fn(a, b) { b.1.compare(a.1) })
  result
}

/// 频率 / Frequency.
pub fn profile_frequency(values : Array[Double]) -> Array[(Double, Double)] {
  let n = values.length()
  let counts = profile_value_counts(values)
  let result : Array[(Double, Double)] = []
  for i in 0..<counts.length() {
    let freq = if n == 0 { 0.0 } else { counts[i].1.to_double() / n.to_double() }
    result.push((counts[i].0, freq))
  }
  result
}

/// 顶部值 / Top K values.
pub fn profile_top_values(values : Array[Double], k : Int) -> Array[(Double, Int)] {
  let counts = profile_value_counts(values)
  let limit = if k < counts.length() { k } else { counts.length() }
  let result : Array[(Double, Int)] = []
  for i in 0..<limit {
    result.push(counts[i])
  }
  result
}

///===
/// 模式 / 格式 / 类型推断 / Pattern / Format / Type inference

/// 模式检测 / Pattern detection (common prefix).
pub fn profile_pattern_detect(values : Array[String]) -> String {
  let n = values.length()
  if n == 0 {
    return ""
  }
  let mut prefix = values[0]
  for i in 1..<n {
    let v = values[i]
    let mut len = prefix.length()
    if v.length() < len {
      len = v.length()
    }
    let mut new_len = 0
    while new_len < len {
      if prefix[new_len] == v[new_len] {
        new_len = new_len + 1
      } else {
        break
      }
    }
    prefix = prefix[:new_len].to_string()
    if prefix.length() == 0 {
      return ""
    }
  }
  prefix
}

/// 格式检测 / Format detection.
pub fn profile_format_detect(values : Array[String]) -> String {
  let n = values.length()
  if n == 0 {
    return "unknown"
  }
  let mut all_numeric = true
  let mut all_date = true
  let mut all_text = true
  for i in 0..<n {
    let v = values[i]
    let mut is_num = true
    for j in 0..<v.length() {
      let c = v[j]
      if !((c >= '0' && c <= '9') || c == '.' || c == '-' || c == '+') {
        is_num = false
        break
      }
    }
    if !(is_num) {
      all_numeric = false
    }
    if !(v.contains("-") || v.contains("/")) {
      all_date = false
    }
    if v.length() == 0 {
      all_text = false
    }
  }
  if all_numeric {
    "numeric"
  } else if all_date {
    "datetime"
  } else if all_text {
    "text"
  } else {
    "mixed"
  }
}

/// 类型推断 / Type inference.
pub fn profile_type_infer(values : Array[String]) -> ColumnKind {
  let fmt = profile_format_detect(values)
  match fmt {
    "numeric" => NumericKind
    "datetime" => DatetimeKind
    "text" => TextKind
    _ => CategoricalKind
  }
}

///===
/// 质量评分 / 完整性 / 有效性 / Quality / Completeness / Validity

/// 质量评分 / Quality score.
pub fn profile_quality_score(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let completeness = profile_completeness(values)
  let uniqueness = profile_density(values)
  let valid_ratio = 1.0
  (completeness + uniqueness + valid_ratio) / 3.0
}

/// 完整性 / Completeness.
pub fn profile_completeness(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let missing = profile_missing_count(values)
  (n - missing).to_double() / n.to_double()
}

/// 有效性 / Validity (in range).
pub fn profile_validity(values : Array[Double], lo : Double, hi : Double) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut valid = 0
  for i in 0..<n {
    if values[i] >= lo && values[i] <= hi {
      valid = valid + 1
    }
  }
  valid.to_double() / n.to_double()
}

///===
/// 列剖析 / 表剖析 / 数据集剖析 / Column / Table / Dataset

/// 列剖析 / Column profile.
pub fn profile_column(name : String, values : Array[Double]) -> ColumnProfileResult {
  make_profile(name, NumericKind, values)
}

/// 表剖析 / Table profile.
pub fn profile_table(
  table_name : String,
  col_names : Array[String],
  col_values : Array[Array[Double]],
) -> TableProfileResult {
  let columns : Array[ColumnProfileResult] = []
  let row_count = if col_values.length() > 0 { col_values[0].length() } else { 0 }
  for i in 0..<col_names.length() {
    let values = if i < col_values.length() { col_values[i] } else { [] }
    columns.push(profile_column(col_names[i], values))
  }
  make_table_profile_result(table_name, row_count, columns)
}

/// 数据集剖析 / Dataset profile.
pub fn profile_dataset(
  dataset_name : String,
  tables : Array[TableProfileResult],
) -> DatasetProfileResult {
  make_dataset_profile_result(dataset_name, tables)
}

///===
/// 数值 / 分类 / 日期 / 文本 / Numeric / Categorical / Datetime / Text

/// 数值剖析 / Numeric profile.
pub fn profile_numeric(name : String, values : Array[Double]) -> ColumnProfileResult {
  make_profile(name, NumericKind, values)
}

/// 分类剖析 / Categorical profile.
pub fn profile_categorical(name : String, values : Array[String]) -> ColumnProfileResult {
  let n = values.length()
  let distinct : Array[String] = []
  for i in 0..<n {
    let mut found = false
    for j in 0..<distinct.length() {
      if distinct[j] == values[i] {
        found = true
        break
      }
    }
    if !(found) {
      distinct.push(values[i])
    }
  }
  let completeness = if n == 0 { 0.0 } else { 1.0 }
  let uniqueness = if n == 0 { 0.0 } else { distinct.length().to_double() / n.to_double() }
  let quality = (completeness + uniqueness) / 2.0
  make_column_profile_result(name, CategoricalKind, n, 0, distinct.length(), n - distinct.length(), 0.0, 0.0, 0.0, 0.0, completeness, uniqueness, quality)
}

/// 日期时间剖析 / Datetime profile.
pub fn profile_datetime(name : String, values : Array[Double]) -> ColumnProfileResult {
  make_profile(name, DatetimeKind, values)
}

/// 文本剖析 / Text profile.
pub fn profile_text(name : String, values : Array[String]) -> ColumnProfileResult {
  let n = values.length()
  let mut total_len = 0
  let mut empty_count = 0
  for i in 0..<n {
    let len = values[i].length()
    total_len = total_len + len
    if len == 0 {
      empty_count = empty_count + 1
    }
  }
  let completeness = if n == 0 { 0.0 } else { (n - empty_count).to_double() / n.to_double() }
  let avg_len = if n == 0 { 0.0 } else { total_len.to_double() / n.to_double() }
  make_column_profile_result(name, TextKind, n, empty_count, 0, 0, 0.0, avg_len, avg_len, 0.0, completeness, 0.0, completeness)
}

///===
/// 摘要 / 报告 / 可视化 / Summary / Report / Visualize

/// 摘要 / Profile summary.
pub fn profile_summary(name : String, values : Array[Double]) -> ProfileSummary {
  let n = values.length()
  let missing = profile_missing_count(values)
  let unique = profile_distinct_count(values)
  let dup = n - unique
  let mean_val = profile_mean_p(values)
  let std_val = profile_std_p(values)
  let quality = profile_quality_score(values)
  {
    total_count: n,
    missing_count: missing,
    unique_count: unique,
    duplicate_count: dup,
    mean_value: mean_val,
    std_value: std_val,
    quality_score: quality,
  }
}

/// 报告 / Profile report.
pub fn profile_report(title : String, summaries : Array[ProfileSummary], generated_at : Double) -> ProfileReport {
  { title: title, summaries: summaries, generated_at: generated_at }
}

/// 可视化 / Visualize (text-based histogram).
pub fn profile_visualize(values : Array[Double], bin_count : Int) -> String {
  let hist = profile_histogram(values, bin_count)
  let mut result = "histogram:\n"
  for i in 0..<hist.bin_counts.length() {
    let edge = hist.bin_edges[i]
    let count = hist.bin_counts[i]
    let mut bar = ""
    for _ in 0..<count {
      bar = bar + "*"
    }
    result = result + "[" + edge.to_string() + "] " + bar + "\n"
  }
  result
}

///===
/// 比较 / 差异 / Compare / Diff

/// 比较 / Profile compare.
pub fn profile_compare(base : Array[Double], target : Array[Double]) -> ProfileCompare {
  let diff_count = if base.length() > target.length() { base.length() - target.length() } else { target.length() - base.length() }
  let diff_mean = prof_abs(profile_mean_p(base) - profile_mean_p(target))
  let diff_std = prof_abs(profile_std_p(base) - profile_std_p(target))
  let diff_quality = prof_abs(profile_quality_score(base) - profile_quality_score(target))
  { base_name: "base", target_name: "target", diff_count: diff_count, diff_mean: diff_mean, diff_std: diff_std, diff_quality: diff_quality }
}

/// 差异 / Profile diff (returns differences per index).
pub fn profile_diff(base : Array[Double], target : Array[Double]) -> Array[Double] {
  let n = if base.length() < target.length() { base.length() } else { target.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(base[i] - target[i])
  }
  result
}

///===
/// ID

/// 模块 ID / Module id.
pub fn data_profiling_id() -> String {
  "dataobject/data_profiling"
}