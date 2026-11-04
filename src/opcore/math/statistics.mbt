///|
/// # opcore/statistics 统计分析 / Statistics Analysis
///
/// 描述统计 / 推断统计 / 假设检验 / 概率分布 / 置信区间 / 回归相关。
/// 对标 SciPy stats + NumPy statistics 工具集。
/// S12.1 新建：50+ pub fn 统计算子。
///
/// # Statistics analysis
///
/// Descriptive / Inferential / Hypothesis Testing / Distributions / CI / Regression.

// ============================================================
// 常量 / Constants
// ============================================================

const STATISTICS_PI : Double = 3.141592653589793

///|
const STATISTICS_E_EULER : Double = 2.718281828459045

///|
const STATISTICS_SQRT_2PI : Double = 2.5066282746310002

///|
const STATISTICS_LARGE_DOUBLE : Double = 999999999999999.0

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 分布类型 / Distribution kind.
pub(all) enum DistributionKind {
  NormalDist
  TDist
  ChiSquareDist
  FDist
  ExponentialDist
  UniformDist
} derive(Debug, Eq)

///|
pub extend DistributionKind with Eq::{equal, not_equal}

///|
pub extend DistributionKind with Debug::{to_repr}

///|
/// 检验类型 / Test kind (alternative hypothesis).
pub(all) enum TestKind {
  TwoSided
  OneSidedLeft
  OneSidedRight
} derive(Debug, Eq)

///|
pub extend TestKind with Eq::{equal, not_equal}

///|
pub extend TestKind with Debug::{to_repr}

///|
/// 四分位数 / Quartiles (Q1, Q2=median, Q3).
pub struct Quartiles {
  q1 : Double
  q2 : Double
  q3 : Double
} derive(Debug, Eq)

///|
pub extend Quartiles with Eq::{equal, not_equal}

///|
pub extend Quartiles with Debug::{to_repr}

///|
/// 置信区间 / Confidence interval.
pub struct ConfidenceInterval {
  lower : Double
  upper : Double
  confidence : Double
} derive(Debug, Eq)

///|
pub extend ConfidenceInterval with Eq::{equal, not_equal}

///|
pub extend ConfidenceInterval with Debug::{to_repr}

///|
/// 回归结果 / Linear regression result.
pub struct RegressionResult {
  slope : Double
  intercept : Double
  r_value : Double
} derive(Debug, Eq)

///|
pub extend RegressionResult with Eq::{equal, not_equal}

///|
pub extend RegressionResult with Debug::{to_repr}

///|
/// 检验结果 / Hypothesis test result.
pub struct TestResult {
  statistic : Double
  p_value : Double
  reject_null : Bool
} derive(Debug, Eq)

///|
pub extend TestResult with Eq::{equal, not_equal}

///|
pub extend TestResult with Debug::{to_repr}

// ============================================================
// 辅助数学函数 / Helper math functions (private)
// ============================================================

///|
fn statistics_sqrt_(x : Double) -> Double {
  if x < 0.0 {
    return 0.0
  }
  if x == 0.0 {
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

///|
fn statistics_abs_(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
fn statistics_exp_(x : Double) -> Double {
  if x > 700.0 {
    return STATISTICS_LARGE_DOUBLE
  }
  if x < -700.0 {
    return 0.0
  }
  let mut n = 0
  let mut y = x
  while y > 0.5 {
    y = y / 2.0
    n = n + 1
  }
  while y < -0.5 {
    y = y / 2.0
    n = n + 1
  }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<40 {
    term = term * y / i.to_double()
    result = result + term
    if statistics_abs_(term) < 0.0000000000000001 {
      break
    }
  }
  for _ in 0..<n {
    result = result * result
  }
  result
}

///|
fn statistics_ln_(x : Double) -> Double {
  if x <= 0.0 {
    return -STATISTICS_LARGE_DOUBLE
  }
  if x == 1.0 {
    return 0.0
  }
  let mut m = 0
  let mut y = x
  while y > 2.0 {
    y = y / STATISTICS_E_EULER
    m = m + 1
  }
  while y < 0.5 {
    y = y * STATISTICS_E_EULER
    m = m - 1
  }
  let t = (y - 1.0) / (y + 1.0)
  let mut result = 0.0
  let mut t_pow = t
  for k in 0..<80 {
    let term = t_pow / (2 * k + 1).to_double()
    result = result + term
    t_pow = t_pow * t * t
    if statistics_abs_(term) < 0.0000000000000001 {
      break
    }
  }
  result * 2.0 + m.to_double()
}

///|
fn statistics_pow_(base : Double, exp : Double) -> Double {
  if base < 0.0 {
    let rounded = exp.to_int().to_double()
    if rounded == exp {
      let n = exp.to_int()
      let mut result = 1.0
      let mut abs_n = if n < 0 { -n } else { n }
      let b = if n < 0 { 1.0 / base } else { base }
      while abs_n > 0 {
        result = result * b
        abs_n = abs_n - 1
      }
      result
    } else {
      0.0
    }
  } else if base == 0.0 {
    if exp > 0.0 {
      0.0
    } else {
      STATISTICS_LARGE_DOUBLE
    }
  } else {
    statistics_exp_(exp * statistics_ln_(base))
  }
}

///|
fn statistics_sin_(x : Double) -> Double {
  let mut x = x
  let two_pi = 6.283185307179586
  while x > STATISTICS_PI {
    x = x - two_pi
  }
  while x < -STATISTICS_PI {
    x = x + two_pi
  }
  let mut result = x
  let mut term = x
  let x2 = x * x
  for i in 1..<15 {
    term = term * x2 / ((2 * i).to_double() * (2 * i + 1).to_double()) * -1.0
    result = result + term
  }
  result
}

///|
fn statistics_cos_(x : Double) -> Double {
  statistics_sin_(x + 1.5707963267948966)
}

///|
/// 角均值 / Angular statistics_mean(circular statistics).
pub fn statistics_angular_mean(angles : Array[Double]) -> Double {
  let n = angles.length()
  if n == 0 {
    return 0.0
  }
  let mut sum_cos = 0.0
  let mut sum_sin = 0.0
  for i in 0..<n {
    sum_cos = sum_cos + statistics_cos_(angles[i])
    sum_sin = sum_sin + statistics_sin_(angles[i])
  }
  let mean_cos = sum_cos / n.to_double()
  let mean_sin = sum_sin / n.to_double()
  if mean_cos == 0.0 && mean_sin == 0.0 {
    0.0
  } else if mean_cos >= 0.0 {
    statistics_atan_approx(mean_sin / mean_cos)
  } else {
    statistics_atan_approx(mean_sin / mean_cos) + STATISTICS_PI
  }
}

///|
fn statistics_atan_approx(x : Double) -> Double {
  let mut result = 0.0
  let mut term = x
  let x2 = x * x
  for n in 0..<50 {
    let t = term / (2 * n + 1).to_double()
    if n % 2 == 0 {
      result = result + t
    } else {
      result = result - t
    }
    term = term * x2
    if statistics_abs_(t) < 0.0000001 {
      break
    }
  }
  result
}

// ============================================================
// 描述统计 / Descriptive statistics
// ============================================================

///|
/// 求和 / Sum of values.
pub fn statistics_sum(data : Array[Double]) -> Double {
  let mut s = 0.0
  for i in 0..<data.length() {
    s = s + data[i]
  }
  s
}

///|
/// 乘积 / Product of values.
pub fn statistics_product(data : Array[Double]) -> Double {
  if data.length() == 0 {
    return 1.0
  }
  let mut p = 1.0
  for i in 0..<data.length() {
    p = p * data[i]
  }
  p
}

///|
/// 均值 / Arithmetic mean.
pub fn statistics_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  statistics_sum(data) / n.to_double()
}

///|
/// 中位数 / Median.
pub fn statistics_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let sorted : Array[Double] = []
  for i in 0..<n {
    sorted.push(data[i])
  }
  sorted.sort_by(fn(a, b) { if a < b { -1 } else if a > b { 1 } else { 0 } })
  let mid = n / 2
  if n % 2 == 1 {
    sorted[mid]
  } else {
    (sorted[mid - 1] + sorted[mid]) / 2.0
  }
}

///|
/// 众数 / Mode (first most frequent value).
pub fn statistics_mode(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let mut best_val = data[0]
  let mut best_cnt = 1
  for i in 0..<n {
    let mut cnt = 0
    for j in 0..<n {
      if data[j] == data[i] {
        cnt = cnt + 1
      }
    }
    if cnt > best_cnt {
      best_cnt = cnt
      best_val = data[i]
    }
  }
  best_val
}

///|
/// 方差 / Variance (sample, ddof=1).
pub fn statistics_variance(data : Array[Double]) -> Double {
  let n = data.length()
  if n < 2 {
    return 0.0
  }
  let m = statistics_mean(data)
  let mut s = 0.0
  for i in 0..<n {
    let d = data[i] - m
    s = s + d * d
  }
  s / (n - 1).to_double()
}

///|
/// 标准差 / Standard deviation (sample).
pub fn statistics_std_dev(data : Array[Double]) -> Double {
  statistics_sqrt_(statistics_variance(data))
}

///|
/// 最小值 / Minimum.
pub fn statistics_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let mut m = data[0]
  for i in 1..<n {
    if data[i] < m {
      m = data[i]
    }
  }
  m
}

///|
/// 最大值 / Maximum.
pub fn statistics_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let mut m = data[0]
  for i in 1..<n {
    if data[i] > m {
      m = data[i]
    }
  }
  m
}

///|
/// 极差 / Range (max - min).
pub fn statistics_range(data : Array[Double]) -> Double {
  if data.length() == 0 {
    return 0.0
  }
  statistics_max(data) - statistics_min(data)
}

///|
/// 百分位数 / Percentile (0 <= p <= 100, linear interpolation).
pub fn statistics_percentile(data : Array[Double], p : Double) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let sorted : Array[Double] = []
  for i in 0..<n {
    sorted.push(data[i])
  }
  sorted.sort_by(fn(a, b) { if a < b { -1 } else if a > b { 1 } else { 0 } })
  let rank = p / 100.0 * (n - 1).to_double()
  let lower = rank.to_int()
  let upper = if lower + 1 < n { lower + 1 } else { lower }
  let frac = rank - lower.to_double()
  sorted[lower] * (1.0 - frac) + sorted[upper] * frac
}

///|
/// 四分位数 / Quartiles.
pub fn statistics_quartiles(data : Array[Double]) -> Quartiles {
  let q1 = statistics_percentile(data, 25.0)
  let q2 = statistics_percentile(data, 50.0)
  let q3 = statistics_percentile(data, 75.0)
  { q1, q2, q3, }
}

///|
/// 四分位距 / Interquartile range.
pub fn statistics_iqr(data : Array[Double]) -> Double {
  let q = statistics_quartiles(data)
  q.q3 - q.q1
}

///|
/// 偏度 / Skewness (sample).
pub fn statistics_skewness(data : Array[Double]) -> Double {
  let n = data.length()
  if n < 3 {
    return 0.0
  }
  let m = statistics_mean(data)
  let s = statistics_std_dev(data)
  if s == 0.0 {
    return 0.0
  }
  let mut sum3 = 0.0
  for i in 0..<n {
    let d = data[i] - m
    sum3 = sum3 + d * d * d
  }
  let m3 = sum3 / n.to_double()
  m3 / statistics_pow_(s, 3.0)
}

///|
/// 峰度 / Kurtosis (excess, sample).
pub fn statistics_kurtosis(data : Array[Double]) -> Double {
  let n = data.length()
  if n < 4 {
    return 0.0
  }
  let m = statistics_mean(data)
  let s = statistics_std_dev(data)
  if s == 0.0 {
    return 0.0
  }
  let mut sum4 = 0.0
  for i in 0..<n {
    let d = data[i] - m
    sum4 = sum4 + d * d * d * d
  }
  let m4 = sum4 / n.to_double()
  m4 / statistics_pow_(s, 4.0) - 3.0
}

///|
/// 几何均值 / Geometric mean.
pub fn statistics_geometric_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let mut log_sum = 0.0
  for i in 0..<n {
    if data[i] <= 0.0 {
      return 0.0
    }
    log_sum = log_sum + statistics_ln_(data[i])
  }
  statistics_exp_(log_sum / n.to_double())
}

///|
/// 调和均值 / Harmonic mean.
pub fn statistics_harmonic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let mut s = 0.0
  for i in 0..<n {
    if data[i] == 0.0 {
      return 0.0
    }
    s = s + 1.0 / data[i]
  }
  if s == 0.0 {
    0.0
  } else {
    n.to_double() / s
  }
}

///|
/// 加权均值 / Weighted mean.
pub fn statistics_weighted_mean(values : Array[Double], weights : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 || n != weights.length() {
    return 0.0
  }
  let mut sum_vw = 0.0
  let mut sum_w = 0.0
  for i in 0..<n {
    sum_vw = sum_vw + values[i] * weights[i]
    sum_w = sum_w + weights[i]
  }
  if sum_w == 0.0 {
    0.0
  } else {
    sum_vw / sum_w
  }
}

///|
/// 变异系数 / Coefficient of variation.
pub fn statistics_coefficient_of_variation(data : Array[Double]) -> Double {
  let m = statistics_mean(data)
  if m == 0.0 {
    return 0.0
  }
  statistics_std_dev(data) / statistics_abs_(m)
}

///|
/// Z 分数 / Z-score of a single value.
pub fn statistics_z_score(value : Double, data : Array[Double]) -> Double {
  let s = statistics_std_dev(data)
  if s == 0.0 {
    return 0.0
  }
  (value - statistics_mean(data)) / s
}

///|
/// 标准化 / Standardize (z-score for each element).
pub fn statistics_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result : Array[Double] = Array::make(n, 0.0)
  if n == 0 {
    return result
  }
  let m = statistics_mean(data)
  let s = statistics_std_dev(data)
  if s == 0.0 {
    return result
  }
  for i in 0..<n {
    result[i] = (data[i] - m) / s
  }
  result
}

// ============================================================
// 辅助特殊函数 / Special functions (public)
// ============================================================

///|
/// 阶乘 / Factorial (n!).
pub fn statistics_factorial(n : Int32) -> Double {
  if n < 0 {
    return 0.0
  }
  let mut result = 1.0
  for i in 2..<=n {
    result = result * i.to_double()
  }
  result
}

///|
/// 对数伽马 / Log gamma (Lanczos approximation).
pub fn statistics_lgamma(x : Double) -> Double {
  if x < 0.5 {
    let reflect = statistics_ln_(STATISTICS_PI) - statistics_ln_(statistics_sin_(STATISTICS_PI * x)) - statistics_lgamma(1.0 - x)
    return reflect
  }
  let g = 7.0
  let c = [
    0.99999999999980993, 676.5203681218851, -1259.1392167224028, 771.32342877765313,
    -176.61503016214059, 12.507343278406943, -0.13857109526572012, 9.9843695780195716e-6,
    1.5056327351493116e-7,
  ]
  let z = x - 1.0
  let mut a = c[0]
  for i in 1..<9 {
    a = a + c[i] / (z + i.to_double())
  }
  let t = z + g + 0.5
  0.5 * statistics_ln_(2.0 * STATISTICS_PI) + (z + 0.5) * statistics_ln_(t) - t + statistics_ln_(a)
}

///|
/// 伽马函数 / Gamma function.
pub fn statistics_gamma_func(x : Double) -> Double {
  statistics_exp_(statistics_lgamma(x))
}

///|
/// 贝塔函数 / Beta function.
pub fn statistics_beta_func(a : Double, b : Double) -> Double {
  statistics_exp_(statistics_lgamma(a) + statistics_lgamma(b) - statistics_lgamma(a + b))
}

///|
/// 误差函数 / Error function (erf).
pub fn statistics_erf(x : Double) -> Double {
  let a1 = 0.254829592
  let a2 = -0.284496736
  let a3 = 1.421413741
  let a4 = -1.453152027
  let a5 = 1.061405429
  let p = 0.3275911
  let sign = if x < 0.0 { -1.0 } else { 1.0 }
  let ax = statistics_abs_(x)
  let t = 1.0 / (1.0 + p * ax)
  let y = 1.0 -
    ((((a5 * t + a4) * t + a3) * t + a2) * t + a1) * t * statistics_exp_(-ax * ax)
  sign * y
}

// ============================================================
// 正态分布 / Normal distribution
// ============================================================

///|
/// 正态 PDF / Normal probability density function.
pub fn statistics_normal_pdf(x : Double, mu : Double, sigma : Double) -> Double {
  if sigma <= 0.0 {
    return 0.0
  }
  let z = (x - mu) / sigma
  statistics_exp_(-0.5 * z * z) / (sigma * STATISTICS_SQRT_2PI)
}

///|
/// 正态 CDF / Normal cumulative distribution function.
pub fn statistics_normal_cdf(x : Double, mu : Double, sigma : Double) -> Double {
  if sigma <= 0.0 {
    return 0.0
  }
  let z = (x - mu) / (sigma * statistics_sqrt_(2.0))
  0.5 * (1.0 + statistics_erf(z))
}

///|
/// 逆正态 CDF / Inverse normal CDF (quantile function).
pub fn statistics_inv_normal_cdf(p : Double, mu : Double, sigma : Double) -> Double {
  if p <= 0.0 {
    return -STATISTICS_LARGE_DOUBLE
  }
  if p >= 1.0 {
    return STATISTICS_LARGE_DOUBLE
  }
  let mut lo = -8.0
  let mut hi = 8.0
  for _ in 0..<100 {
    let mid = (lo + hi) / 2.0
    let cdf = 0.5 * (1.0 + statistics_erf(mid / statistics_sqrt_(2.0)))
    if cdf < p {
      lo = mid
    } else {
      hi = mid
    }
  }
  mu + sigma * (lo + hi) / 2.0
}

// ============================================================
// t 分布 / Student's t distribution
// ============================================================

///|
/// t PDF / Student's t probability density function.
pub fn statistics_t_pdf(x : Double, df : Int32) -> Double {
  if df <= 0 {
    return 0.0
  }
  let half_df = df.to_double() / 2.0
  let coef = statistics_exp_(statistics_lgamma(half_df + 0.5) - statistics_lgamma(half_df)) /
    statistics_sqrt_(df.to_double() * STATISTICS_PI)
  coef * statistics_pow_(1.0 + x * x / df.to_double(), -(half_df + 0.5))
}

///|
/// t CDF / Student's t cumulative distribution function (via numerical integration).
pub fn statistics_t_cdf(x : Double, df : Int32) -> Double {
  if df <= 0 {
    return 0.0
  }
  if x == 0.0 {
    return 0.5
  }
  let n = 1000
  let h = x / n.to_double()
  let mut s = 0.5 * statistics_t_pdf(0.0, df)
  for i in 1..<n {
    s = s + statistics_t_pdf(i.to_double() * h, df)
  }
  s = s + 0.5 * statistics_t_pdf(x, df)
  0.5 + s * h
}

// ============================================================
// 卡方分布 / Chi-square distribution
// ============================================================

///|
/// 卡方 PDF / Chi-square probability density function.
pub fn statistics_chi_square_pdf(x : Double, df : Int32) -> Double {
  if df <= 0 || x < 0.0 {
    return 0.0
  }
  if x == 0.0 {
    if df == 2 {
      return 0.5
    }
    return 0.0
  }
  let half_df = df.to_double() / 2.0
  let coef = statistics_exp_(-x / 2.0) * statistics_pow_(x, half_df - 1.0)
  coef / (statistics_pow_(2.0, half_df) * statistics_exp_(statistics_lgamma(half_df)))
}

///|
/// 卡方 CDF / Chi-square cumulative distribution function (via numerical integration).
pub fn statistics_chi_square_cdf(x : Double, df : Int32) -> Double {
  if df <= 0 || x <= 0.0 {
    return 0.0
  }
  let n = 1000
  let h = x / n.to_double()
  let mut s = 0.5 * statistics_chi_square_pdf(0.0, df)
  for i in 1..<n {
    s = s + statistics_chi_square_pdf(i.to_double() * h, df)
  }
  s = s + 0.5 * statistics_chi_square_pdf(x, df)
  let result = s * h
  if result > 1.0 {
    1.0
  } else {
    result
  }
}

// ============================================================
// F 分布 / F distribution
// ============================================================

///|
/// F PDF / F probability density function.
pub fn statistics_f_pdf(x : Double, d1 : Int32, d2 : Int32) -> Double {
  if d1 <= 0 || d2 <= 0 || x < 0.0 {
    return 0.0
  }
  if x == 0.0 {
    return 0.0
  }
  let d1d = d1.to_double()
  let d2d = d2.to_double()
  let num = statistics_sqrt_(statistics_pow_(d1d * x, d1d) * statistics_pow_(d2d, d2d))
  let denom = (d1d * x + d2d) * statistics_sqrt_(d1d * x + d2d)
  let beta = statistics_exp_(
    statistics_lgamma(d1d / 2.0) + statistics_lgamma(d2d / 2.0) - statistics_lgamma((d1d + d2d) / 2.0),
  )
  num / (denom * x * beta)
}

///|
/// F CDF / F cumulative distribution function (via numerical integration).
pub fn statistics_f_cdf(x : Double, d1 : Int32, d2 : Int32) -> Double {
  if d1 <= 0 || d2 <= 0 || x <= 0.0 {
    return 0.0
  }
  let n = 1000
  let h = x / n.to_double()
  let mut s = 0.0
  for i in 1..<n {
    s = s + statistics_f_pdf(i.to_double() * h, d1, d2)
  }
  s = s + 0.5 * statistics_f_pdf(x, d1, d2)
  let result = s * h
  if result > 1.0 {
    1.0
  } else {
    result
  }
}

// ============================================================
// 指数分布 / Exponential distribution
// ============================================================

///|
/// 指数 PDF / Exponential probability density function.
pub fn statistics_exponential_pdf(x : Double, lambda : Double) -> Double {
  if lambda <= 0.0 || x < 0.0 {
    return 0.0
  }
  lambda * statistics_exp_(-lambda * x)
}

///|
/// 指数 CDF / Exponential cumulative distribution function.
pub fn statistics_exponential_cdf(x : Double, lambda : Double) -> Double {
  if lambda <= 0.0 || x < 0.0 {
    return 0.0
  }
  1.0 - statistics_exp_(-lambda * x)
}

// ============================================================
// 均匀分布 / Uniform distribution
// ============================================================

///|
/// 均匀 PDF / Uniform probability density function.
pub fn statistics_uniform_pdf(x : Double, a : Double, b : Double) -> Double {
  if b <= a {
    return 0.0
  }
  if x < a || x > b {
    0.0
  } else {
    1.0 / (b - a)
  }
}

///|
/// 均匀 CDF / Uniform cumulative distribution function.
pub fn statistics_uniform_cdf(x : Double, a : Double, b : Double) -> Double {
  if b <= a {
    return 0.0
  }
  if x < a {
    0.0
  } else if x > b {
    1.0
  } else {
    (x - a) / (b - a)
  }
}

// ============================================================
// 假设检验 / Hypothesis testing
// ============================================================

///|
/// Z 检验 / One-sample Z-test.
pub fn statistics_z_test(
  data : Array[Double],
  mu0 : Double,
  sigma : Double,
  test_kind : TestKind,
) -> TestResult {
  let n = data.length()
  if n == 0 || sigma <= 0.0 {
    return { statistic: 0.0, p_value: 1.0, reject_null: false, }
  }
  let z = (statistics_mean(data) - mu0) / (sigma / statistics_sqrt_(n.to_double()))
  let p = statistics_p_value_normal(z, test_kind)
  { statistic: z, p_value: p, reject_null: p < 0.05, }
}

///|
/// 单样本 t 检验 / One-sample t-test.
pub fn statistics_t_test_one_sample(
  data : Array[Double],
  mu0 : Double,
  test_kind : TestKind,
) -> TestResult {
  let n = data.length()
  if n < 2 {
    return { statistic: 0.0, p_value: 1.0, reject_null: false, }
  }
  let s = statistics_std_dev(data)
  if s == 0.0 {
    return { statistic: 0.0, p_value: 1.0, reject_null: false, }
  }
  let t = (statistics_mean(data) - mu0) / (s / statistics_sqrt_(n.to_double()))
  let df = n - 1
  let p = statistics_p_value_t(t, df, test_kind)
  { statistic: t, p_value: p, reject_null: p < 0.05, }
}

///|
/// 双样本 t 检验 / Two-sample t-test (Welch's).
pub fn statistics_t_test_two_sample(
  data1 : Array[Double],
  data2 : Array[Double],
  test_kind : TestKind,
) -> TestResult {
  let n1 = data1.length()
  let n2 = data2.length()
  if n1 < 2 || n2 < 2 {
    return { statistic: 0.0, p_value: 1.0, reject_null: false, }
  }
  let v1 = statistics_variance(data1)
  let v2 = statistics_variance(data2)
  let se = statistics_sqrt_(v1 / n1.to_double() + v2 / n2.to_double())
  if se == 0.0 {
    return { statistic: 0.0, p_value: 1.0, reject_null: false, }
  }
  let t = (statistics_mean(data1) - statistics_mean(data2)) / se
  let num = statistics_pow_(v1 / n1.to_double() + v2 / n2.to_double(), 2.0)
  let denom = statistics_pow_(v1 / n1.to_double(), 2.0) / (n1 - 1).to_double() +
    statistics_pow_(v2 / n2.to_double(), 2.0) / (n2 - 1).to_double()
  let df = if denom == 0.0 { n1 + n2 - 2 } else { (num / denom).to_int() }
  let p = statistics_p_value_t(t, df, test_kind)
  { statistic: t, p_value: p, reject_null: p < 0.05, }
}

///|
/// 卡方检验 / Chi-square goodness-of-fit test.
pub fn statistics_chi_square_test(
  observed : Array[Double],
  expected : Array[Double],
) -> TestResult {
  let n = observed.length()
  if n == 0 || n != expected.length() {
    return { statistic: 0.0, p_value: 1.0, reject_null: false, }
  }
  let mut chi2 = 0.0
  for i in 0..<n {
    if expected[i] > 0.0 {
      let d = observed[i] - expected[i]
      chi2 = chi2 + d * d / expected[i]
    }
  }
  let df = n - 1
  let p = 1.0 - statistics_chi_square_cdf(chi2, df)
  { statistic: chi2, p_value: p, reject_null: p < 0.05, }
}

///|
/// F 检验 / F-test for equality of variances.
pub fn statistics_f_test(data1 : Array[Double], data2 : Array[Double]) -> TestResult {
  let n1 = data1.length()
  let n2 = data2.length()
  if n1 < 2 || n2 < 2 {
    return { statistic: 0.0, p_value: 1.0, reject_null: false, }
  }
  let v1 = statistics_variance(data1)
  let v2 = statistics_variance(data2)
  if v2 == 0.0 {
    return { statistic: 0.0, p_value: 1.0, reject_null: false, }
  }
  let f = v1 / v2
  let d1 = n1 - 1
  let d2 = n2 - 1
  let p = 2.0 * (1.0 - statistics_f_cdf(f, d1, d2))
  let p_clamped = if p > 1.0 { 1.0 } else { p }
  { statistic: f, p_value: p_clamped, reject_null: p_clamped < 0.05, }
}

///|
/// 正态分布 p 值 / P-value for normal distribution.
pub fn statistics_p_value_normal(z : Double, test_kind : TestKind) -> Double {
  let cdf = 0.5 * (1.0 + statistics_erf(z / statistics_sqrt_(2.0)))
  match test_kind {
    TwoSided => {
      let p = 2.0 * (1.0 - cdf)
      if p > 1.0 {
        1.0
      } else {
        p
      }
    }
    OneSidedRight => 1.0 - cdf
    OneSidedLeft => cdf
  }
}

///|
/// t 分布 p 值 / P-value for t distribution.
pub fn statistics_p_value_t(t : Double, df : Int32, test_kind : TestKind) -> Double {
  if df <= 0 {
    return 1.0
  }
  let cdf = statistics_t_cdf(t, df)
  match test_kind {
    TwoSided => {
      let p = 2.0 * (1.0 - cdf)
      if p > 1.0 {
        1.0
      } else {
        p
      }
    }
    OneSidedRight => 1.0 - cdf
    OneSidedLeft => cdf
  }
}

// ============================================================
// 置信区间 / Confidence intervals
// ============================================================

///|
/// 均值置信区间 / Confidence interval for mean.
pub fn statistics_confidence_interval_mean(
  data : Array[Double],
  confidence : Double,
) -> ConfidenceInterval {
  let n = data.length()
  if n < 2 {
    return { lower: 0.0, upper: 0.0, confidence, }
  }
  let m = statistics_mean(data)
  let s = statistics_std_dev(data)
  let alpha = 1.0 - confidence
  let z = statistics_inv_normal_cdf(1.0 - alpha / 2.0, 0.0, 1.0)
  let me = z * s / statistics_sqrt_(n.to_double())
  { lower: m - me, upper: m + me, confidence, }
}

///|
/// 比例置信区间 / Confidence interval for proportion.
pub fn statistics_confidence_interval_proportion(
  successes : Int32,
  total : Int32,
  confidence : Double,
) -> ConfidenceInterval {
  if total <= 0 {
    return { lower: 0.0, upper: 1.0, confidence, }
  }
  let p = successes.to_double() / total.to_double()
  let alpha = 1.0 - confidence
  let z = statistics_inv_normal_cdf(1.0 - alpha / 2.0, 0.0, 1.0)
  let me = z * statistics_sqrt_(p * (1.0 - p) / total.to_double())
  let lo = if p - me < 0.0 { 0.0 } else { p - me }
  let hi = if p + me > 1.0 { 1.0 } else { p + me }
  { lower: lo, upper: hi, confidence, }
}

///|
/// 误差范围 / Margin of error.
pub fn statistics_margin_of_error(
  std_dev_val : Double,
  sample_size : Int32,
  confidence : Double,
) -> Double {
  if sample_size <= 0 {
    return 0.0
  }
  let alpha = 1.0 - confidence
  let z = statistics_inv_normal_cdf(1.0 - alpha / 2.0, 0.0, 1.0)
  z * std_dev_val / statistics_sqrt_(sample_size.to_double())
}

///|
/// 样本量估计 / Sample size estimate.
pub fn statistics_sample_size_estimate(
  std_dev_val : Double,
  margin_error : Double,
  confidence : Double,
) -> Int32 {
  if margin_error <= 0.0 {
    return 0
  }
  let alpha = 1.0 - confidence
  let z = statistics_inv_normal_cdf(1.0 - alpha / 2.0, 0.0, 1.0)
  let n = statistics_pow_(z * std_dev_val / margin_error, 2.0)
  (n + 0.5).to_int()
}

// ============================================================
// 相关与回归 / Correlation and regression
// ============================================================

///|
/// 协方差 / Covariance (sample).
pub fn statistics_covariance(x : Array[Double], y : Array[Double]) -> Double {
  let n = x.length()
  if n < 2 || n != y.length() {
    return 0.0
  }
  let mx = statistics_mean(x)
  let my = statistics_mean(y)
  let mut s = 0.0
  for i in 0..<n {
    s = s + (x[i] - mx) * (y[i] - my)
  }
  s / (n - 1).to_double()
}

///|
/// 相关系数 / Pearson correlation coefficient.
pub fn statistics_correlation(x : Array[Double], y : Array[Double]) -> Double {
  let n = x.length()
  if n < 2 || n != y.length() {
    return 0.0
  }
  let sx = statistics_std_dev(x)
  let sy = statistics_std_dev(y)
  if sx == 0.0 || sy == 0.0 {
    return 0.0
  }
  statistics_covariance(x, y) / (sx * sy)
}

///|
/// 线性回归 / Simple linear regression (least squares).
pub fn statistics_linear_regression(
  x : Array[Double],
  y : Array[Double],
) -> RegressionResult {
  let n = x.length()
  if n < 2 || n != y.length() {
    return { slope: 0.0, intercept: statistics_mean(y), r_value: 0.0, }
  }
  let mx = statistics_mean(x)
  let my = statistics_mean(y)
  let mut sxx = 0.0
  let mut sxy = 0.0
  for i in 0..<n {
    sxx = sxx + (x[i] - mx) * (x[i] - mx)
    sxy = sxy + (x[i] - mx) * (y[i] - my)
  }
  let slope = if sxx == 0.0 { 0.0 } else { sxy / sxx }
  let intercept = my - slope * mx
  let r = statistics_correlation(x, y)
  { slope, intercept, r_value: r, }
}

///|
/// 决定系数 / R-squared (coefficient of determination).
pub fn statistics_r_squared(x : Array[Double], y : Array[Double]) -> Double {
  let r = statistics_correlation(x, y)
  r * r
}

///|
/// 调整决定系数 / Adjusted R-squared.
pub fn statistics_adjusted_r_squared(x : Array[Double], y : Array[Double]) -> Double {
  let n = x.length()
  if n < 3 || n != y.length() {
    return 0.0
  }
  let r2 = statistics_r_squared(x, y)
  1.0 - (1.0 - r2) * (n - 1).to_double() / (n - 2).to_double()
}

// ============================================================
// ID
// ============================================================

///|
/// 模块标识 / Module identifier.
pub fn statistics_statistics_id() -> String {
  "opcore/statistics"
}
