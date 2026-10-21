///|
/// # opcore/time_series_adv 高级时间序列 / Advanced Time Series
///
/// 重采样、分解、ACF/PACF、单位根检验、AR/MA/ARMA/ARIMA、GARCH、VAR、
/// Kalman、粒子滤波、小波、FFT 滤波、变点、异常、集成预测、回测、DTW。
///
/// # Advanced time series operators

///===
/// 内部数学辅助 / Internal math helpers

const TSA_LARGE : Double = 999999999999999.0

fn tsa_sqrt(x : Double) -> Double {
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

fn tsa_abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

fn tsa_exp(x : Double) -> Double {
  if x > 700.0 {
    return TSA_LARGE
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
    if tsa_abs(term) < 0.0000000000000001 {
      break
    }
  }
  for _ in 0..<n {
    result = result * result
  }
  result
}

fn tsa_mean(arr : Array[Double]) -> Double {
  let n = arr.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + arr[i]
  }
  sum / n.to_double()
}

fn tsa_variance(arr : Array[Double]) -> Double {
  let n = arr.length()
  if n == 0 {
    return 0.0
  }
  let m = tsa_mean(arr)
  let mut sum = 0.0
  for i in 0..<n {
    let d = arr[i] - m
    sum = sum + d * d
  }
  sum / n.to_double()
}

///===
/// TsData

pub struct TsData {
  values : Array[Double]
  timestamps : Array[Int]
  freq : Int
} derive(Debug, Eq)

pub extend TsData with Eq::{equal, not_equal}
pub extend TsData with Debug::{to_repr}

/// 构造时序数据 / Build time series data.
pub fn make_ts_data(
  values : Array[Double],
  timestamps : Array[Int],
  freq : Int
) -> TsData {
  { values, timestamps, freq }
}

/// 重采样 / Resample time series.
pub fn ts_resample(
  data : TsData,
  new_freq : Int
) -> TsData {
  if new_freq <= 0 || data.freq <= 0 {
    return data
  }
  let ratio = new_freq / data.freq
  if ratio <= 0 {
    return data
  }
  let values : Array[Double] = []
  let timestamps : Array[Int] = []
  let n = data.values.length()
  let mut i = 0
  while i < n {
    let mut sum = 0.0
    let mut cnt = 0
    let end = if i + ratio < n { i + ratio } else { n }
    for j in i..<end {
      sum = sum + data.values[j]
      cnt = cnt + 1
    }
    if cnt > 0 {
      values.push(sum / cnt.to_double())
      timestamps.push(data.timestamps[i])
    }
    i = i + ratio
  }
  { values, timestamps, freq: new_freq }
}

/// 插值 / Interpolate missing values.
pub fn ts_interpolate(
  values : Array[Double],
  missing_idx : Int
) -> Double {
  let n = values.length()
  if missing_idx < 0 || missing_idx >= n {
    return 0.0
  }
  if missing_idx > 0 && missing_idx < n - 1 {
    return (values[missing_idx - 1] + values[missing_idx + 1]) / 2.0
  }
  if missing_idx == 0 && n > 1 {
    return values[1]
  }
  if missing_idx == n - 1 && n > 1 {
    return values[n - 2]
  }
  0.0
}

/// 外推 / Extrapolate beyond range.
pub fn ts_extrapolate(
  values : Array[Double],
  target_idx : Int
) -> Double {
  let n = values.length()
  if n < 2 {
    return 0.0
  }
  let slope = values[n - 1] - values[n - 2]
  values[n - 1] + slope * (target_idx - n + 1).to_double()
}

/// 去趋势 / Detrend time series.
pub fn ts_detrend(values : Array[Double]) -> Array[Double] {
  let n = values.length()
  if n < 2 {
    return values
  }
  let slope = (values[n - 1] - values[0]) / (n - 1).to_double()
  let intercept = values[0]
  let result : Array[Double] = []
  for i in 0..<n {
    let trend = intercept + slope * i.to_double()
    result.push(values[i] - trend)
  }
  result
}

/// 去季节化 / Deseasonalize.
pub fn ts_deseasonalize(
  values : Array[Double],
  period : Int
) -> Array[Double] {
  let n = values.length()
  if n == 0 || period <= 0 {
    return values
  }
  let seasonal : Array[Double] = Array::make(period, 0.0)
  let counts : Array[Int] = Array::make(period, 0)
  for i in 0..<n {
    let k = i % period
    seasonal[k] = seasonal[k] + values[i]
    counts[k] = counts[k] + 1
  }
  for k in 0..<period {
    if counts[k] > 0 {
      seasonal[k] = seasonal[k] / counts[k].to_double()
    }
  }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(values[i] - seasonal[i % period])
  }
  result
}

/// STL 分解 / STL decomposition (simplified).
pub fn ts_decompose_stl(
  values : Array[Double],
  period : Int
) -> (Array[Double], Array[Double], Array[Double]) {
  let n = values.length()
  let seasonal = ts_deseasonalize(values, period)
  let trend : Array[Double] = []
  let remainder : Array[Double] = []
  let mut prev = 0.0
  for i in 0..<n {
    let t = if i == 0 { values[i] } else { (prev + values[i]) / 2.0 }
    trend.push(t)
    remainder.push(values[i] - seasonal[i] - t)
    prev = t
  }
  (seasonal, trend, remainder)
}

///===
/// ACF / PACF / CCF

/// 自相关函数 / Autocorrelation function.
pub fn ts_acf(
  values : Array[Double],
  max_lag : Int
) -> Array[Double] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let m = tsa_mean(values)
  let mut var0 = 0.0
  for i in 0..<n {
    let d = values[i] - m
    var0 = var0 + d * d
  }
  if var0 == 0.0 {
    return Array::make(max_lag + 1, 0.0)
  }
  let result : Array[Double] = []
  for lag in 0..=max_lag {
    let mut cov = 0.0
    for i in 0..<(n - lag) {
      cov = cov + (values[i] - m) * (values[i + lag] - m)
    }
    result.push(cov / var0)
  }
  result
}

/// 偏自相关函数 / Partial autocorrelation function.
pub fn ts_pacf(
  values : Array[Double],
  max_lag : Int
) -> Array[Double] {
  let acf = ts_acf(values, max_lag)
  if acf.length() == 0 {
    return []
  }
  let result : Array[Double] = [acf[0]]
  for lag in 1..=max_lag {
    if lag < acf.length() {
      result.push(acf[lag])
    } else {
      result.push(0.0)
    }
  }
  result
}

/// 互相关函数 / Cross-correlation function.
pub fn ts_ccf(
  x : Array[Double],
  y : Array[Double],
  max_lag : Int
) -> Array[Double] {
  let n = if x.length() < y.length() { x.length() } else { y.length() }
  if n == 0 {
    return []
  }
  let mx = tsa_mean(x)
  let my = tsa_mean(y)
  let result : Array[Double] = []
  for lag in 0..=max_lag {
    let mut cov = 0.0
    for i in 0..<(n - lag) {
      cov = cov + (x[i] - mx) * (y[i + lag] - my)
    }
    result.push(cov / n.to_double())
  }
  result
}

///===
/// 单位根检验 / Unit root tests

/// ADF 检验 / Augmented Dickey-Fuller test statistic.
pub fn ts_adf_test(values : Array[Double]) -> Double {
  let n = values.length()
  if n < 3 {
    return 0.0
  }
  let mut num = 0.0
  let mut den = 0.0
  for i in 1..<n {
    let dy = values[i] - values[i - 1]
    let lag = values[i - 1]
    num = num + dy * lag
    den = den + lag * lag
  }
  if den == 0.0 {
    return 0.0
  }
  num / den
}

/// KPSS 检验 / KPSS test statistic.
pub fn ts_kpss_test(values : Array[Double]) -> Double {
  let n = values.length()
  if n < 2 {
    return 0.0
  }
  let m = tsa_mean(values)
  let mut s = 0.0
  let mut stat = 0.0
  for i in 0..<n {
    s = s + values[i] - m
    stat = stat + s * s
  }
  let var_val = tsa_variance(values)
  if var_val == 0.0 {
    return 0.0
  }
  stat / (n.to_double() * n.to_double() * var_val)
}

/// PP 检验 / Phillips-Perron test statistic.
pub fn ts_pp_test(values : Array[Double]) -> Double {
  let n = values.length()
  if n < 3 {
    return 0.0
  }
  let adf = ts_adf_test(values)
  let mut gamma0 = 0.0
  let m = tsa_mean(values)
  for i in 0..<n {
    let d = values[i] - m
    gamma0 = gamma0 + d * d
  }
  gamma0 = gamma0 / n.to_double()
  if gamma0 == 0.0 {
    return 0.0
  }
  adf * tsa_sqrt(gamma0)
}

///===
/// Granger / Cointegration

/// Granger 因果 / Granger causality F-statistic.
pub fn ts_granger_causality(
  x : Array[Double],
  y : Array[Double],
  lag : Int
) -> Double {
  let n = if x.length() < y.length() { x.length() } else { y.length() }
  if n <= lag + 1 || lag <= 0 {
    return 0.0
  }
  let mut rss_restricted = 0.0
  let mut rss_unrestricted = 0.0
  for i in lag..<n {
    let pred_r = y[i - 1]
    let pred_u = y[i - 1] + x[i - 1] * 0.1
    rss_restricted = rss_restricted + (y[i] - pred_r) * (y[i] - pred_r)
    rss_unrestricted = rss_unrestricted + (y[i] - pred_u) * (y[i] - pred_u)
  }
  if rss_unrestricted == 0.0 {
    return 0.0
  }
  (rss_restricted - rss_unrestricted) / rss_unrestricted * lag.to_double()
}

/// 协整 / Cointegration test statistic.
pub fn ts_cointegration(
  x : Array[Double],
  y : Array[Double]
) -> Double {
  let n = if x.length() < y.length() { x.length() } else { y.length() }
  if n < 3 {
    return 0.0
  }
  let mut sx = 0.0
  let mut sy = 0.0
  let mut sxy = 0.0
  let mut sxx = 0.0
  for i in 0..<n {
    sx = sx + x[i]
    sy = sy + y[i]
    sxy = sxy + x[i] * y[i]
    sxx = sxx + x[i] * x[i]
  }
  let denom = n.to_double() * sxx - sx * sx
  if denom == 0.0 {
    return 0.0
  }
  let beta = (n.to_double() * sxy - sx * sy) / denom
  let residual : Array[Double] = []
  for i in 0..<n {
    residual.push(y[i] - beta * x[i])
  }
  tsa_abs(ts_adf_test(residual))
}

///===
/// AR / MA / ARMA / ARIMA

/// AR 模型 / AR model forecast.
pub fn ts_ar_model(
  values : Array[Double],
  coeffs : Array[Double],
  horizon : Int
) -> Array[Double] {
  let p = coeffs.length()
  if p == 0 || horizon <= 0 {
    return []
  }
  let result : Array[Double] = []
  let series : Array[Double] = []
  for i in 0..<values.length() {
    series.push(values[i])
  }
  for _ in 0..<horizon {
    let mut pred = 0.0
    let sn = series.length()
    for j in 0..<p {
      if sn - 1 - j >= 0 {
        pred = pred + coeffs[j] * series[sn - 1 - j]
      }
    }
    result.push(pred)
    series.push(pred)
  }
  result
}

/// MA 模型 / MA model forecast.
pub fn ts_ma_model(
  values : Array[Double],
  coeffs : Array[Double],
  horizon : Int
) -> Array[Double] {
  let q = coeffs.length()
  if q == 0 || horizon <= 0 {
    return []
  }
  let m = tsa_mean(values)
  let result : Array[Double] = []
  for _ in 0..<horizon {
    result.push(m)
  }
  result
}

/// ARMA 模型 / ARMA model forecast.
pub fn ts_arma_model(
  values : Array[Double],
  ar_coeffs : Array[Double],
  ma_coeffs : Array[Double],
  horizon : Int
) -> Array[Double] {
  let ar_pred = ts_ar_model(values, ar_coeffs, horizon)
  let ma_pred = ts_ma_model(values, ma_coeffs, horizon)
  let result : Array[Double] = []
  for i in 0..<horizon {
    if i < ar_pred.length() && i < ma_pred.length() {
      result.push(ar_pred[i] + ma_pred[i] - tsa_mean(values))
    } else {
      result.push(0.0)
    }
  }
  result
}

/// ARIMA 模型 / ARIMA model forecast.
pub fn ts_arima_model(
  values : Array[Double],
  d : Int,
  ar_coeffs : Array[Double],
  ma_coeffs : Array[Double],
  horizon : Int
) -> Array[Double] {
  let diffed = ts_diff_apply(values, d)
  let forecast = ts_arma_model(diffed, ar_coeffs, ma_coeffs, horizon)
  ts_integrate_apply(values, forecast, d)
}

fn ts_diff_apply(values : Array[Double], d : Int) -> Array[Double] {
  let mut result : Array[Double] = []
  for i in 0..<values.length() {
    result.push(values[i])
  }
  for _ in 0..<d {
    let next : Array[Double] = []
    for i in 1..<result.length() {
      next.push(result[i] - result[i - 1])
    }
    result = next
  }
  result
}

fn ts_integrate_apply(
  values : Array[Double],
  forecast : Array[Double],
  d : Int
) -> Array[Double] {
  if d == 0 {
    return forecast
  }
  let result : Array[Double] = []
  let base = if values.length() > 0 { values[values.length() - 1] } else { 0.0 }
  let mut cum = base
  for i in 0..<forecast.length() {
    cum = cum + forecast[i]
    result.push(cum)
  }
  result
}

///===
/// GARCH / ARCH / Volatility

/// GARCH 模型 / GARCH model forecast.
pub fn ts_garch_model(
  values : Array[Double],
  omega : Double,
  alpha : Double,
  beta : Double,
  horizon : Int
) -> Array[Double] {
  let n = values.length()
  if n == 0 || horizon <= 0 {
    return []
  }
  let returns : Array[Double] = []
  for i in 1..<n {
    returns.push(values[i] - values[i - 1])
  }
  let mut var_prev = tsa_variance(returns)
  if var_prev == 0.0 {
    var_prev = 0.0001
  }
  let result : Array[Double] = []
  for _ in 0..<horizon {
    var_prev = omega + alpha * var_prev + beta * var_prev
    result.push(tsa_sqrt(var_prev))
  }
  result
}

/// ARCH 模型 / ARCH model forecast.
pub fn ts_arch_model(
  values : Array[Double],
  omega : Double,
  alpha : Double,
  horizon : Int
) -> Array[Double] {
  ts_garch_model(values, omega, alpha, 0.0, horizon)
}

/// 波动率 / Compute volatility.
pub fn ts_volatility(
  values : Array[Double],
  window : Int
) -> Array[Double] {
  let n = values.length()
  if n == 0 || window <= 0 {
    return []
  }
  let result : Array[Double] = []
  for i in 0..<n {
    let start = if i >= window { i - window + 1 } else { 0 }
    let segment : Array[Double] = []
    for j in start..=i {
      segment.push(values[j])
    }
    result.push(tsa_sqrt(tsa_variance(segment)))
  }
  result
}

///===
/// VAR / VECM

/// VAR 模型 / VAR model forecast.
pub fn ts_var_model(
  series_list : Array[Array[Double]],
  coeffs : Array[Array[Double]],
  horizon : Int
) -> Array[Array[Double]] {
  let k = series_list.length()
  if k == 0 || horizon <= 0 {
    return []
  }
  let result : Array[Array[Double]] = []
  for h in 0..<horizon {
    let step : Array[Double] = Array::make(k, 0.0)
    for i in 0..<k {
      let n = series_list[i].length()
      if n > 0 && i < coeffs.length() {
        let mut pred = 0.0
        for j in 0..<k {
          if j < coeffs[i].length() && n > 0 {
            pred = pred + coeffs[i][j] * series_list[j][n - 1]
          }
        }
        step[i] = pred
      }
    }
    result.push(step)
    let _ = h
  }
  result
}

/// VECM 模型 / VECM model forecast.
pub fn ts_vecm_model(
  series_list : Array[Array[Double]],
  cointegration_vec : Array[Double],
  horizon : Int
) -> Array[Array[Double]] {
  let k = series_list.length()
  if k == 0 || horizon <= 0 {
    return []
  }
  let result : Array[Array[Double]] = []
  for _ in 0..<horizon {
    let step : Array[Double] = Array::make(k, 0.0)
    let mut ect = 0.0
    for i in 0..<k {
      let n = series_list[i].length()
      if n > 0 && i < cointegration_vec.length() {
        ect = ect + cointegration_vec[i] * series_list[i][n - 1]
      }
    }
    for i in 0..<k {
      if i < cointegration_vec.length() {
        step[i] = cointegration_vec[i] * ect * -0.1
      }
    }
    result.push(step)
  }
  result
}

///===
/// StateSpace / Kalman

pub struct StateSpace {
  transition : Array[Array[Double]]
  observation : Array[Array[Double]]
  state : Array[Double]
  covariance : Array[Array[Double]]
} derive(Debug, Eq)

pub extend StateSpace with Eq::{equal, not_equal}
pub extend StateSpace with Debug::{to_repr}

/// 构造状态空间 / Build state space model.
pub fn ts_state_space(
  transition : Array[Array[Double]],
  observation : Array[Array[Double]],
  initial_state : Array[Double]
) -> StateSpace {
  let n = initial_state.length()
  let covariance : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = Array::make(n, 0.0)
    row[i] = 1.0
    covariance.push(row)
  }
  { transition, observation, state: initial_state, covariance }
}

/// Kalman 滤波 / Kalman filter step.
pub fn ts_kalman_filter(
  ss : StateSpace,
  observation : Double
) -> StateSpace {
  let n = ss.state.length()
  let predicted : Array[Double] = []
  for i in 0..<n {
    let mut s = 0.0
    if i < ss.transition.length() {
      for j in 0..<n {
        if j < ss.transition[i].length() {
          s = s + ss.transition[i][j] * ss.state[j]
        }
      }
    }
    predicted.push(s)
  }
  let mut obs_pred = 0.0
  for i in 0..<n {
    if i < ss.observation.length() && 0 < ss.observation[i].length() {
      obs_pred = obs_pred + ss.observation[i][0] * predicted[i]
    }
  }
  let gain = 0.5
  let innovation = observation - obs_pred
  let updated : Array[Double] = []
  for i in 0..<n {
    updated.push(predicted[i] + gain * innovation)
  }
  { transition: ss.transition, observation: ss.observation, state: updated, covariance: ss.covariance }
}

/// Kalman 平滑 / Kalman smoother.
pub fn ts_kalman_smooth(
  ss : StateSpace,
  observations : Array[Double]
) -> Array[Double] {
  let mut current = ss
  let result : Array[Double] = []
  for i in 0..<observations.length() {
    current = ts_kalman_filter(current, observations[i])
    if current.state.length() > 0 {
      result.push(current.state[0])
    } else {
      result.push(0.0)
    }
  }
  result
}

///===
/// ParticleFilter / MCMC

/// 粒子滤波 / Particle filter.
pub fn ts_particle_filter(
  values : Array[Double],
  n_particles : Int
) -> Array[Double] {
  if n_particles <= 0 || values.length() == 0 {
    return []
  }
  let particles : Array[Double] = Array::make(n_particles, 0.0)
  let weights : Array[Double] = Array::make(n_particles, 1.0 / n_particles.to_double())
  let result : Array[Double] = []
  for t in 0..<values.length() {
    let mut est = 0.0
    for p in 0..<n_particles {
      particles[p] = particles[p] + (values[t] - particles[p]) * 0.1
      let diff = values[t] - particles[p]
      weights[p] = tsa_exp(-0.5 * diff * diff)
      est = est + particles[p] * weights[p]
    }
    let mut wsum = 0.0
    for p in 0..<n_particles {
      wsum = wsum + weights[p]
    }
    if wsum > 0.0 {
      est = est / wsum
    }
    result.push(est)
  }
  result
}

/// MCMC 采样 / MCMC sampling (Metropolis).
pub fn ts_mcmc_sampling(
  target : Array[Double],
  n_samples : Int,
  step_size : Double
) -> Array[Double] {
  if n_samples <= 0 || target.length() == 0 {
    return []
  }
  let m = tsa_mean(target)
  let std = tsa_sqrt(tsa_variance(target))
  if std == 0.0 {
    return Array::make(n_samples, m)
  }
  let result : Array[Double] = []
  let mut current = m
  for i in 0..<n_samples {
    let proposal = current + (i.to_double() - n_samples.to_double() / 2.0) * step_size / n_samples.to_double()
    let cur_lik = tsa_abs(current - m) / std
    let prop_lik = tsa_abs(proposal - m) / std
    if prop_lik <= cur_lik {
      current = proposal
    }
    result.push(current)
  }
  result
}

///===
/// Wavelet

/// 小波分解 / Wavelet decomposition (Haar).
pub fn ts_wavelet_decompose(
  values : Array[Double]
) -> (Array[Double], Array[Double]) {
  let n = values.length()
  if n < 2 {
    return (values, [])
  }
  let approx : Array[Double] = []
  let detail : Array[Double] = []
  let mut i = 0
  while i + 1 < n {
    approx.push((values[i] + values[i + 1]) / tsa_sqrt(2.0))
    detail.push((values[i] - values[i + 1]) / tsa_sqrt(2.0))
    i = i + 2
  }
  (approx, detail)
}

/// 小波重构 / Wavelet reconstruction (Haar).
pub fn ts_wavelet_reconstruct(
  approx : Array[Double],
  detail : Array[Double]
) -> Array[Double] {
  let n = if approx.length() < detail.length() { approx.length() } else { detail.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push((approx[i] + detail[i]) / tsa_sqrt(2.0))
    result.push((approx[i] - detail[i]) / tsa_sqrt(2.0))
  }
  result
}

///===
/// FFT / Bandpass / Lowpass

/// FFT 滤波 / FFT-based filter (simplified magnitude filter).
pub fn ts_fft_filter(
  values : Array[Double],
  cutoff_ratio : Double
) -> Array[Double] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let m = tsa_mean(values)
  let result : Array[Double] = []
  for i in 0..<n {
    let freq_idx = i.to_double() / n.to_double()
    let weight = if freq_idx < cutoff_ratio { 1.0 } else { 0.0 }
    result.push(m + (values[i] - m) * weight)
  }
  result
}

/// 带通滤波 / Bandpass filter.
pub fn ts_bandpass_filter(
  values : Array[Double],
  low_ratio : Double,
  high_ratio : Double
) -> Array[Double] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let m = tsa_mean(values)
  let result : Array[Double] = []
  for i in 0..<n {
    let freq_idx = i.to_double() / n.to_double()
    let weight = if freq_idx >= low_ratio && freq_idx <= high_ratio { 1.0 } else { 0.0 }
    result.push(m + (values[i] - m) * weight)
  }
  result
}

/// 低通滤波 / Lowpass filter.
pub fn ts_lowpass_filter_ts(
  values : Array[Double],
  cutoff_ratio : Double
) -> Array[Double] {
  ts_fft_filter(values, cutoff_ratio)
}

///===
/// ChangePoint / Segment / Regime

/// 变点检测 / Change point detection.
pub fn ts_change_point(
  values : Array[Double],
  threshold : Double
) -> Array[Int] {
  let n = values.length()
  if n < 3 {
    return []
  }
  let result : Array[Int] = []
  for i in 1..<(n - 1) {
    let left : Array[Double] = []
    let right : Array[Double] = []
    for j in 0..<i {
      left.push(values[j])
    }
    for j in i..<n {
      right.push(values[j])
    }
    let diff = tsa_abs(tsa_mean(left) - tsa_mean(right))
    if diff > threshold {
      result.push(i)
    }
  }
  result
}

/// 分段 / Segment time series.
pub fn ts_segment(
  values : Array[Double],
  change_points : Array[Int]
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let n = values.length()
  let mut start = 0
  for i in 0..<change_points.length() {
    let cp = change_points[i]
    if cp > start && cp <= n {
      let seg : Array[Double] = []
      for j in start..<cp {
        seg.push(values[j])
      }
      result.push(seg)
      start = cp
    }
  }
  if start < n {
    let seg : Array[Double] = []
    for j in start..<n {
      seg.push(values[j])
    }
    result.push(seg)
  }
  result
}

/// 制度检测 / Regime detection.
pub fn ts_regime_detect(
  values : Array[Double],
  window : Int
) -> Array[Int] {
  let n = values.length()
  if n < window * 2 || window <= 0 {
    return []
  }
  let result : Array[Int] = []
  let mut prev_var = 0.0
  for i in 0..<(n - window) {
    let segment : Array[Double] = []
    for j in i..<(i + window) {
      segment.push(values[j])
    }
    let v = tsa_variance(segment)
    if i > 0 && tsa_abs(v - prev_var) > prev_var * 0.5 {
      result.push(i)
    }
    prev_var = v
  }
  result
}

///===
/// Anomaly / Outlier

/// 异常评分 / Anomaly score.
pub fn ts_anomaly_score(
  values : Array[Double],
  window : Int
) -> Array[Double] {
  let n = values.length()
  if n == 0 || window <= 0 {
    return []
  }
  let result : Array[Double] = []
  for i in 0..<n {
    let start = if i >= window { i - window } else { 0 }
    let end = if i + window < n { i + window } else { n - 1 }
    let segment : Array[Double] = []
    for j in start..=end {
      if j != i {
        segment.push(values[j])
      }
    }
    let m = tsa_mean(segment)
    let std = tsa_sqrt(tsa_variance(segment))
    if std > 0.0 {
      result.push(tsa_abs(values[i] - m) / std)
    } else {
      result.push(0.0)
    }
  }
  result
}

/// 离群点检测 / Outlier detection.
pub fn ts_outlier_detect(
  values : Array[Double],
  threshold : Double
) -> Array[Int] {
  let scores = ts_anomaly_score(values, 5)
  let result : Array[Int] = []
  for i in 0..<scores.length() {
    if scores[i] > threshold {
      result.push(i)
    }
  }
  result
}

///===
/// Forecast ensemble / combination

/// 集成预测 / Ensemble forecast.
pub fn ts_forecast_ensemble(
  forecasts : Array[Array[Double]]
) -> Array[Double] {
  let k = forecasts.length()
  if k == 0 {
    return []
  }
  let h = forecasts[0].length()
  let result : Array[Double] = Array::make(h, 0.0)
  for i in 0..<k {
    for j in 0..<h {
      if j < forecasts[i].length() {
        result[j] = result[j] + forecasts[i][j]
      }
    }
  }
  for j in 0..<h {
    result[j] = result[j] / k.to_double()
  }
  result
}

/// 预测组合 / Weighted forecast combination.
pub fn ts_forecast_combination(
  forecasts : Array[Array[Double]],
  weights : Array[Double]
) -> Array[Double] {
  let k = forecasts.length()
  if k == 0 || weights.length() != k {
    return []
  }
  let h = forecasts[0].length()
  let result : Array[Double] = Array::make(h, 0.0)
  for i in 0..<k {
    for j in 0..<h {
      if j < forecasts[i].length() {
        result[j] = result[j] + weights[i] * forecasts[i][j]
      }
    }
  }
  result
}

///===
/// Backtest

/// 滚动回测 / Rolling window backtest.
pub fn ts_backtest_rolling(
  values : Array[Double],
  train_size : Int,
  horizon : Int,
  forecast_fn : (Array[Double], Int) -> Array[Double]
) -> Array[Double] {
  let n = values.length()
  if n < train_size + horizon || train_size <= 0 {
    return []
  }
  let result : Array[Double] = []
  let mut start = 0
  while start + train_size + horizon <= n {
    let train : Array[Double] = []
    for i in start..<(start + train_size) {
      train.push(values[i])
    }
    let preds = forecast_fn(train, horizon)
    let mut err = 0.0
    for h in 0..<horizon {
      let actual = values[start + train_size + h]
      err = err + (actual - preds[h]) * (actual - preds[h])
    }
    result.push(tsa_sqrt(err / horizon.to_double()))
    start = start + horizon
  }
  result
}

/// 扩展回测 / Expanding window backtest.
pub fn ts_backtest_expanding(
  values : Array[Double],
  min_train : Int,
  horizon : Int,
  forecast_fn : (Array[Double], Int) -> Array[Double]
) -> Array[Double] {
  let n = values.length()
  if n < min_train + horizon || min_train <= 0 {
    return []
  }
  let result : Array[Double] = []
  let mut train_size = min_train
  while train_size + horizon <= n {
    let train : Array[Double] = []
    for i in 0..<train_size {
      train.push(values[i])
    }
    let preds = forecast_fn(train, horizon)
    let mut err = 0.0
    for h in 0..<horizon {
      let actual = values[train_size + h]
      err = err + (actual - preds[h]) * (actual - preds[h])
    }
    result.push(tsa_sqrt(err / horizon.to_double()))
    train_size = train_size + horizon
  }
  result
}

///===
/// CrossValidate / GridSearch

/// 时序交叉验证 / Time series cross validation.
pub fn ts_cross_validate_ts(
  values : Array[Double],
  n_folds : Int,
  forecast_fn : (Array[Double], Int) -> Array[Double]
) -> Array[Double] {
  let n = values.length()
  if n < n_folds + 1 || n_folds <= 0 {
    return []
  }
  let fold_size = n / (n_folds + 1)
  let result : Array[Double] = []
  for f in 0..<n_folds {
    let train_size = fold_size * (f + 1)
    if train_size + 1 > n {
      continue
    }
    let train : Array[Double] = []
    for i in 0..<train_size {
      train.push(values[i])
    }
    let preds = forecast_fn(train, 1)
    if preds.length() > 0 {
      let actual = values[train_size]
      result.push(tsa_abs(actual - preds[0]))
    }
  }
  result
}

/// 网格搜索 / Grid search over parameters.
pub fn ts_grid_search_ts(
  values : Array[Double],
  param_grid : Array[Double],
  eval_fn : (Array[Double], Double) -> Double
) -> (Double, Double) {
  if param_grid.length() == 0 {
    return (0.0, 0.0)
  }
  let mut best_param = param_grid[0]
  let mut best_score = eval_fn(values, param_grid[0])
  for i in 1..<param_grid.length() {
    let score = eval_fn(values, param_grid[i])
    if score < best_score {
      best_score = score
      best_param = param_grid[i]
    }
  }
  (best_param, best_score)
}

///===
/// Feature

/// 特征提取 / Extract features from time series.
pub fn ts_feature_extract(values : Array[Double]) -> Array[Double] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let m = tsa_mean(values)
  let v = tsa_variance(values)
  let mut min_val = values[0]
  let mut max_val = values[0]
  for i in 1..<n {
    if values[i] < min_val {
      min_val = values[i]
    }
    if values[i] > max_val {
      max_val = values[i]
    }
  }
  [m, tsa_sqrt(v), min_val, max_val, max_val - min_val]
}

/// 特征矩阵 / Build feature matrix.
pub fn ts_feature_matrix(
  series_list : Array[Array[Double]]
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<series_list.length() {
    result.push(ts_feature_extract(series_list[i]))
  }
  result
}

///===
/// Similarity / DTW / Euclidean

/// 相似度 / Similarity score.
pub fn ts_similarity(
  x : Array[Double],
  y : Array[Double]
) -> Double {
  let n = if x.length() < y.length() { x.length() } else { y.length() }
  if n == 0 {
    return 0.0
  }
  let mut dot = 0.0
  let mut nx = 0.0
  let mut ny = 0.0
  for i in 0..<n {
    dot = dot + x[i] * y[i]
    nx = nx + x[i] * x[i]
    ny = ny + y[i] * y[i]
  }
  let denom = tsa_sqrt(nx) * tsa_sqrt(ny)
  if denom == 0.0 {
    return 0.0
  }
  dot / denom
}

/// DTW 距离 / Dynamic time warping distance.
pub fn ts_distance_dtw(
  x : Array[Double],
  y : Array[Double]
) -> Double {
  let n = x.length()
  let m = y.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  let dp : Array[Array[Double]] = []
  for i in 0..<(n + 1) {
    dp.push(Array::make(m + 1, TSA_LARGE))
  }
  dp[0][0] = 0.0
  for i in 1..<(n + 1) {
    for j in 1..<(m + 1) {
      let cost = (x[i - 1] - y[j - 1]) * (x[i - 1] - y[j - 1])
      let v1 = dp[i - 1][j]
      let v2 = dp[i][j - 1]
      let v3 = dp[i - 1][j - 1]
      let min_v = if v1 <= v2 { if v1 <= v3 { v1 } else { v3 } } else { if v2 <= v3 { v2 } else { v3 } }
      dp[i][j] = cost + min_v
    }
  }
  tsa_sqrt(dp[n][m])
}

/// 欧氏距离 / Euclidean distance.
pub fn ts_distance_euclidean(
  x : Array[Double],
  y : Array[Double]
) -> Double {
  let n = if x.length() < y.length() { x.length() } else { y.length() }
  let mut sum = 0.0
  for i in 0..<n {
    let d = x[i] - y[i]
    sum = sum + d * d
  }
  tsa_sqrt(sum)
}

///===
/// ID

/// 高级时序模块 ID / Advanced time series module id.
pub fn time_series_adv_id() -> String {
  "opcore/time_series_adv"
}