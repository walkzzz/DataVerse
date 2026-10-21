///|
/// # datatemporal/forecasting 时间序列预测算子 / Time Series Forecasting Operators
///
/// 预测算子契约 + 简化实现。架构 §4.3.6 datatemporal 扩展。
/// S7.7 新建：SMA/WMA/SES/DES/Holt-Winters/ARIMA/LSTM-Prophet/Ensemble。
///
/// # Forecasting operators

///|
///===
/// 内部数学辅助 / Internal math helpers
fn fc_abs_val(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
///===
/// Time Series
pub struct TimeSeries {
  values : Array[Double]
  timestamps : Array[Int32]
}

///|
pub fn make_time_series(
  values : Array[Double],
  timestamps : Array[Int32],
) -> TimeSeries {
  { values, timestamps, }
}

///|
pub fn ts_length(ts : TimeSeries) -> Int32 {
  ts.values.length()
}

///|
pub fn ts_values(ts : TimeSeries) -> Array[Double] {
  ts.values
}

///|
pub fn ts_timestamps(ts : TimeSeries) -> Array[Int32] {
  ts.timestamps
}

///|
///===
/// Moving Average
pub fn simple_moving_average_forecast(
  values : Array[Double],
  window : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || window <= 0 {
    return []
  }
  let result : Array[Double] = []
  for i in 0..<n {
    if i < window - 1 {
      result.push(0.0)
    } else {
      let mut sum = 0.0
      for j in 0..<window {
        sum = sum + values[i - j]
      }
      result.push(sum / window.to_double())
    }
  }
  result
}

///|
pub fn weighted_moving_average_forecast(
  values : Array[Double],
  weights : Array[Double],
) -> Array[Double] {
  let n = values.length()
  let w = weights.length()
  if n == 0 || w == 0 {
    return []
  }
  let mut weight_sum = 0.0
  for i in 0..<w {
    weight_sum = weight_sum + weights[i]
  }
  if weight_sum == 0.0 {
    return Array::make(n, 0.0)
  }
  let result : Array[Double] = []
  for i in 0..<n {
    if i < w - 1 {
      result.push(0.0)
    } else {
      let mut sum = 0.0
      for j in 0..<w {
        sum = sum + weights[j] * values[i - j]
      }
      result.push(sum / weight_sum)
    }
  }
  result
}

///|
///===
/// Exponential Smoothing
pub fn exponential_smoothing_forecast(
  values : Array[Double],
  alpha : Double,
) -> Array[Double] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let result : Array[Double] = Array::make(n, 0.0)
  result[0] = values[0]
  for i in 1..<n {
    result[i] = alpha * values[i] + (1.0 - alpha) * result[i - 1]
  }
  result
}

///|
pub fn double_exponential_smoothing(
  values : Array[Double],
  alpha : Double,
  beta : Double,
) -> Array[Double] {
  let n = values.length()
  if n == 0 {
    return []
  }
  let level : Array[Double] = Array::make(n, 0.0)
  let trend : Array[Double] = Array::make(n, 0.0)
  level[0] = values[0]
  trend[0] = if n > 1 { values[1] - values[0] } else { 0.0 }
  for i in 1..<n {
    level[i] = alpha * values[i] + (1.0 - alpha) * (level[i - 1] + trend[i - 1])
    trend[i] = beta * (level[i] - level[i - 1]) + (1.0 - beta) * trend[i - 1]
  }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(level[i] + trend[i])
  }
  result
}

///|
pub fn triple_exponential_smoothing(
  values : Array[Double],
  alpha : Double,
  beta : Double,
  gamma : Double,
  season_length : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || season_length <= 0 {
    return []
  }
  let level : Array[Double] = Array::make(n, 0.0)
  let trend : Array[Double] = Array::make(n, 0.0)
  let season : Array[Double] = Array::make(n, 0.0)
  let s = season_length
  for i in 0..<s {
    if i < n {
      season[i] = values[i]
    }
  }
  if s < n {
    level[s - 1] = values[s - 1]
    trend[s - 1] = values[s - 1] - values[0]
  } else if n > 0 {
    level[0] = values[0]
    trend[0] = 0.0
  }
  for i in s..<n {
    let prev_level = level[i - 1]
    let prev_trend = trend[i - 1]
    let seasonal_idx = i - s
    level[i] = alpha * (values[i] - season[seasonal_idx]) +
      (1.0 - alpha) * (prev_level + prev_trend)
    trend[i] = beta * (level[i] - prev_level) + (1.0 - beta) * prev_trend
    season[i] = gamma * (values[i] - level[i]) +
      (1.0 - gamma) * season[seasonal_idx]
  }
  let result : Array[Double] = []
  for i in 0..<n {
    let s_idx = i % s
    result.push(level[i] + trend[i] + season[s_idx])
  }
  result
}

///|
pub fn holt_winters(
  values : Array[Double],
  alpha : Double,
  beta : Double,
  gamma : Double,
  season_length : Int32,
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || season_length <= 0 {
    return []
  }
  let smoothed = triple_exponential_smoothing(
    values, alpha, beta, gamma, season_length,
  )
  let last_level = if n > 0 { smoothed[n - 1] } else { 0.0 }
  let result : Array[Double] = []
  for h in 1..<=horizon {
    let s_idx = (n + h - 1) % season_length
    result.push(
      last_level + h.to_double() * 0.0 + smoothed[s_idx % smoothed.length()],
    )
  }
  result
}

///|
///===
/// ARIMA
pub struct ARIMAModel {
  p : Int32
  d : Int32
  q : Int32
  phi : Array[Double]
  theta : Array[Double]
  residual : Double
}

///|
pub fn arima_fit(
  values : Array[Double],
  p : Int32,
  d : Int32,
  q : Int32,
) -> ARIMAModel {
  let phi = Array::make(p, 0.0)
  let theta = Array::make(q, 0.0)
  let mut residual = 0.0
  let n = values.length()
  if n > p {
    let mut sum = 0.0
    for i in p..<n {
      sum = sum + values[i]
    }
    residual = sum / (n - p).to_double()
  }
  { p, d, q, phi, theta, residual, }
}

///|
pub fn arima_predict(
  model : ARIMAModel,
  values : Array[Double],
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || horizon <= 0 {
    return []
  }
  let result : Array[Double] = []
  let last_value = values[n - 1]
  for _ in 0..<horizon {
    let mut pred = last_value
    for i in 0..<model.phi.length() {
      let idx = n - 1 - i
      if idx >= 0 {
        pred = pred + model.phi[i] * values[idx]
      }
    }
    pred = pred + model.residual
    result.push(pred)
  }
  result
}

///|
pub fn arima_forecast(
  values : Array[Double],
  p : Int32,
  d : Int32,
  q : Int32,
  horizon : Int32,
) -> Array[Double] {
  let model = arima_fit(values, p, d, q)
  arima_predict(model, values, horizon)
}

///|
///===
/// Trend
pub fn linear_trend_forecast(
  values : Array[Double],
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || horizon <= 0 {
    return []
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
  let slope = if denom == 0.0 {
    0.0
  } else {
    (nd * sum_xy - sum_x * sum_y) / denom
  }
  let intercept = (sum_y - slope * sum_x) / nd
  let result : Array[Double] = []
  for h in 1..<=horizon {
    let x = (n + h - 1).to_double()
    result.push(intercept + slope * x)
  }
  result
}

///|
pub fn quadratic_trend_forecast(
  values : Array[Double],
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || horizon <= 0 {
    return []
  }
  let linear_pred = linear_trend_forecast(values, horizon)
  let mean_val = @_common.mean(values)
  let result : Array[Double] = []
  for h in 0..<horizon {
    let adjustment = h.to_double() * h.to_double() * 0.001 * mean_val
    if h < linear_pred.length() {
      result.push(linear_pred[h] + adjustment)
    } else {
      result.push(linear_pred[0])
    }
  }
  result
}

///|
///===
/// Seasonal Decomposition
pub struct SeasonalDecomposition {
  trend : Array[Double]
  seasonal : Array[Double]
  remainder : Array[Double]
}

///|
pub fn seasonal_decompose(
  values : Array[Double],
  season_length : Int32,
) -> SeasonalDecomposition {
  let n = values.length()
  if n == 0 || season_length <= 0 {
    return { trend: [], seasonal: [], remainder: [], }
  }
  let trend = simple_moving_average_forecast(values, season_length)
  let seasonal : Array[Double] = Array::make(n, 0.0)
  let remainder : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    seasonal[i] = values[i] - trend[i]
    remainder[i] = values[i] - trend[i] - seasonal[i]
  }
  { trend, seasonal, remainder, }
}

///|
pub fn seasonal_adjust(
  values : Array[Double],
  season_length : Int32,
) -> Array[Double] {
  let decomp = seasonal_decompose(values, season_length)
  let result : Array[Double] = []
  for i in 0..<values.length() {
    result.push(values[i] - decomp.seasonal[i])
  }
  result
}

///|
///===
/// Autocorrelation
pub fn autocorrelation_func(
  values : Array[Double],
  max_lag : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || max_lag <= 0 {
    return []
  }
  let mean = @_common.mean(values)
  let mut variance = 0.0
  for i in 0..<n {
    let d = values[i] - mean
    variance = variance + d * d
  }
  if variance == 0.0 {
    return Array::make(max_lag, 0.0)
  }
  let result : Array[Double] = []
  for lag in 1..<=max_lag {
    let mut cov = 0.0
    for i in 0..<(n - lag) {
      cov = cov + (values[i] - mean) * (values[i + lag] - mean)
    }
    result.push(cov / variance)
  }
  result
}

///|
pub fn partial_autocorrelation(
  values : Array[Double],
  max_lag : Int32,
) -> Array[Double] {
  let acf = autocorrelation_func(values, max_lag)
  let n = acf.length()
  if n == 0 {
    return []
  }
  let pacf : Array[Double] = Array::make(n, 0.0)
  if n >= 1 {
    pacf[0] = acf[0]
  }
  for k in 1..<n {
    let mut num = acf[k]
    let mut denom = 1.0
    for j in 0..<k {
      num = num - pacf[j] * acf[k - 1 - j]
      denom = denom - pacf[j] * acf[j]
    }
    pacf[k] = if denom == 0.0 { 0.0 } else { num / denom }
  }
  pacf
}

///|
///===
/// LSTM Forecast (simplified)
pub struct LSTMForecast {
  weights : Array[Double]
  hidden_size : Int32
  learning_rate : Double
}

///|
pub fn make_lstm_forecast(
  hidden_size : Int32,
  learning_rate : Double,
) -> LSTMForecast {
  { weights: Array::make(hidden_size, 0.0), hidden_size, learning_rate, }
}

///|
pub fn lstm_forecast_fit(
  model : LSTMForecast,
  values : Array[Double],
) -> LSTMForecast {
  let n = values.length()
  if n == 0 {
    return model
  }
  let mean_val = @_common.mean(values)
  let new_weights : Array[Double] = Array::make(model.hidden_size, 0.0)
  for i in 0..<model.hidden_size {
    if i < n {
      new_weights[i] = model.weights[i] +
        model.learning_rate * (values[i] - mean_val)
    } else {
      new_weights[i] = model.weights[i]
    }
  }
  {
    weights: new_weights,
    hidden_size: model.hidden_size,
    learning_rate: model.learning_rate,
  }
}

///|
pub fn lstm_forecast_predict(
  model : LSTMForecast,
  values : Array[Double],
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || horizon <= 0 {
    return []
  }
  let last_val = values[n - 1]
  let mean_val = @_common.mean(values)
  let result : Array[Double] = []
  for h in 0..<horizon {
    let mut pred = last_val
    for i in 0..<model.hidden_size {
      if i < n {
        pred = pred + model.weights[i] * (values[n - 1 - i] - mean_val) * 0.01
      }
    }
    result.push(pred + h.to_double() * 0.001 * mean_val)
  }
  result
}

///|
///===
/// Prophet Forecast (simplified)
pub struct ProphetForecast {
  growth : Double
  seasonality : Double
  changepoints : Array[Int32]
}

///|
pub fn make_prophet_forecast(
  growth : Double,
  seasonality : Double,
) -> ProphetForecast {
  { growth, seasonality, changepoints: [], }
}

///|
pub fn prophet_fit(values : Array[Double]) -> ProphetForecast {
  let n = values.length()
  if n < 2 {
    return make_prophet_forecast(0.0, 0.0)
  }
  let growth = (values[n - 1] - values[0]) / n.to_double()
  let mean_val = @_common.mean(values)
  let seasonality = mean_val * 0.1
  { growth, seasonality, changepoints: [], }
}

///|
pub fn prophet_predict(
  model : ProphetForecast,
  values : Array[Double],
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || horizon <= 0 {
    return []
  }
  let last_val = values[n - 1]
  let result : Array[Double] = []
  for h in 1..<=horizon {
    let trend = last_val + model.growth * h.to_double()
    let seasonal = model.seasonality * (h.to_double() * 0.1)
    result.push(trend + seasonal)
  }
  result
}

///|
///===
/// Ensemble
pub fn ensemble_forecast(forecasts : Array[Array[Double]]) -> Array[Double] {
  let n = forecasts.length()
  if n == 0 {
    return []
  }
  let horizon = forecasts[0].length()
  let result : Array[Double] = Array::make(horizon, 0.0)
  for i in 0..<n {
    for h in 0..<horizon {
      if h < forecasts[i].length() {
        result[h] = result[h] + forecasts[i][h]
      }
    }
  }
  for h in 0..<horizon {
    result[h] = result[h] / n.to_double()
  }
  result
}

///|
pub fn weighted_ensemble_forecast(
  forecasts : Array[Array[Double]],
  weights : Array[Double],
) -> Array[Double] {
  let n = forecasts.length()
  if n == 0 {
    return []
  }
  let horizon = forecasts[0].length()
  let mut weight_sum = 0.0
  for i in 0..<weights.length() {
    weight_sum = weight_sum + weights[i]
  }
  if weight_sum == 0.0 {
    return Array::make(horizon, 0.0)
  }
  let result : Array[Double] = Array::make(horizon, 0.0)
  for i in 0..<n {
    let w = if i < weights.length() { weights[i] } else { 0.0 }
    for h in 0..<horizon {
      if h < forecasts[i].length() {
        result[h] = result[h] + w * forecasts[i][h]
      }
    }
  }
  for h in 0..<horizon {
    result[h] = result[h] / weight_sum
  }
  result
}

///|
///===
/// Accuracy Metrics
pub fn forecast_accuracy(
  actual : Array[Double],
  predicted : Array[Double],
) -> Double {
  let n = if actual.length() < predicted.length() {
    actual.length()
  } else {
    predicted.length()
  }
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let diff = actual[i] - predicted[i]
    sum = sum + diff * diff
  }
  (sum / n.to_double()).sqrt()
}

///|
pub fn mape(actual : Array[Double], predicted : Array[Double]) -> Double {
  let n = if actual.length() < predicted.length() {
    actual.length()
  } else {
    predicted.length()
  }
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  let mut count = 0
  for i in 0..<n {
    if fc_abs_val(actual[i]) > 0.000001 {
      sum = sum + fc_abs_val((actual[i] - predicted[i]) / actual[i])
      count = count + 1
    }
  }
  if count == 0 {
    return 0.0
  }
  100.0 * sum / count.to_double()
}

///|
pub fn mase(actual : Array[Double], predicted : Array[Double]) -> Double {
  let n = if actual.length() < predicted.length() {
    actual.length()
  } else {
    predicted.length()
  }
  if n < 2 {
    return 0.0
  }
  let mut naive_sum = 0.0
  for i in 1..<n {
    naive_sum = naive_sum + fc_abs_val(actual[i] - actual[i - 1])
  }
  let naive_scale = naive_sum / (n - 1).to_double()
  if naive_scale == 0.0 {
    return 0.0
  }
  let mut err_sum = 0.0
  for i in 0..<n {
    err_sum = err_sum + fc_abs_val(actual[i] - predicted[i])
  }
  err_sum / (n.to_double() * naive_scale)
}

///|
pub fn smape(actual : Array[Double], predicted : Array[Double]) -> Double {
  let n = if actual.length() < predicted.length() {
    actual.length()
  } else {
    predicted.length()
  }
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  let mut count = 0
  for i in 0..<n {
    let denom = (fc_abs_val(actual[i]) + fc_abs_val(predicted[i])) / 2.0
    if denom > 0.000001 {
      sum = sum + fc_abs_val(actual[i] - predicted[i]) / denom
      count = count + 1
    }
  }
  if count == 0 {
    return 0.0
  }
  100.0 * sum / count.to_double()
}

///|
///===
/// Residual Analysis
pub struct ResidualAnalysis {
  mean : Double
  variance : Double
  autocorr : Array[Double]
}

///|
pub fn residual_analysis(
  actual : Array[Double],
  predicted : Array[Double],
) -> ResidualAnalysis {
  let n = if actual.length() < predicted.length() {
    actual.length()
  } else {
    predicted.length()
  }
  if n == 0 {
    return { mean: 0.0, variance: 0.0, autocorr: [], }
  }
  let residuals : Array[Double] = []
  for i in 0..<n {
    residuals.push(actual[i] - predicted[i])
  }
  let mean = @_common.mean(residuals)
  let mut variance = 0.0
  for i in 0..<n {
    let d = residuals[i] - mean
    variance = variance + d * d
  }
  variance = variance / n.to_double()
  let autocorr = autocorrelation_func(residuals, 5)
  { mean, variance, autocorr, }
}

///|
pub fn ljung_box_test(residuals : Array[Double], lag : Int32) -> Double {
  let n = residuals.length()
  if n == 0 || lag <= 0 {
    return 0.0
  }
  let acf = autocorrelation_func(residuals, lag)
  let mut stat = 0.0
  for h in 0..<lag {
    if h < acf.length() {
      let h_val = (h + 1).to_double()
      stat = stat + acf[h] * acf[h] / (n.to_double() - h_val)
    }
  }
  stat * n.to_double() * (n.to_double() + 1.0)
}

///|
pub fn durbin_watson_test(residuals : Array[Double]) -> Double {
  let n = residuals.length()
  if n < 2 {
    return 0.0
  }
  let mut num = 0.0
  let mut denom = 0.0
  for i in 0..<n {
    denom = denom + residuals[i] * residuals[i]
  }
  for i in 1..<n {
    let diff = residuals[i] - residuals[i - 1]
    num = num + diff * diff
  }
  if denom == 0.0 {
    return 0.0
  }
  num / denom
}

///|
///===
/// Grid Search
pub struct GridSearch {
  param_grid : Array[Array[Double]]
  best_score : Double
  best_params : Array[Double]
}

///|
pub fn make_grid_search(param_grid : Array[Array[Double]]) -> GridSearch {
  { param_grid, best_score: 999999.0, best_params: [], }
}

///|
pub fn grid_search_forecast(
  values : Array[Double],
  param_grid : Array[Array[Double]],
) -> GridSearch {
  let n = values.length()
  if n < 4 {
    return make_grid_search(param_grid)
  }
  let train_size = n * 3 / 4
  let train : Array[Double] = []
  let test_set : Array[Double] = []
  for i in 0..<train_size {
    train.push(values[i])
  }
  for i in train_size..<n {
    test_set.push(values[i])
  }
  let horizon = test_set.length()
  let mut best_score = 999999.0
  let mut best_params : Array[Double] = []
  for i in 0..<param_grid.length() {
    let params = param_grid[i]
    let alpha = if params.length() > 0 { params[0] } else { 0.5 }
    let preds = exponential_smoothing_forecast(train, alpha)
    let pred_horizon : Array[Double] = []
    let last_pred = if preds.length() > 0 {
      preds[preds.length() - 1]
    } else {
      0.0
    }
    for _ in 0..<horizon {
      pred_horizon.push(last_pred)
    }
    let score = forecast_accuracy(test_set, pred_horizon)
    if score < best_score {
      best_score = score
      best_params = params
    }
  }
  { param_grid, best_score, best_params, }
}

///|
pub fn select_best_model(
  values : Array[Double],
  forecasts : Array[Array[Double]],
) -> Int32 {
  let n = values.length()
  if n == 0 || forecasts.length() == 0 {
    return 0
  }
  let mut best_idx = 0
  let mut best_score = 999999.0
  for i in 0..<forecasts.length() {
    let score = forecast_accuracy(values, forecasts[i])
    if score < best_score {
      best_score = score
      best_idx = i
    }
  }
  best_idx
}

///|
///===
/// Cross Validation
pub fn cross_validation_forecast(
  values : Array[Double],
  k_folds : Int32,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || k_folds <= 0 {
    return []
  }
  let fold_size = n / k_folds
  let scores : Array[Double] = []
  for fold in 0..<k_folds {
    let start = fold * fold_size
    let end = if fold == k_folds - 1 { n } else { start + fold_size }
    let train : Array[Double] = []
    let test_set : Array[Double] = []
    for i in 0..<start {
      train.push(values[i])
    }
    for i in end..<n {
      train.push(values[i])
    }
    for i in start..<end {
      test_set.push(values[i])
    }
    if train.length() > 0 && test_set.length() > 0 {
      let preds = linear_trend_forecast(train, test_set.length())
      scores.push(forecast_accuracy(test_set, preds))
    }
  }
  scores
}

///|
pub fn rolling_forecast(
  values : Array[Double],
  window : Int32,
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n < window || horizon <= 0 {
    return []
  }
  let result : Array[Double] = []
  let mut start = 0
  while start + window + horizon <= n {
    let train : Array[Double] = []
    for i in start..<(start + window) {
      train.push(values[i])
    }
    let preds = linear_trend_forecast(train, horizon)
    for i in 0..<preds.length() {
      result.push(preds[i])
    }
    start = start + 1
  }
  result
}

///|
pub fn expanding_window(
  values : Array[Double],
  min_train : Int32,
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n < min_train + horizon || horizon <= 0 {
    return []
  }
  let result : Array[Double] = []
  let mut train_size = min_train
  while train_size + horizon <= n {
    let train : Array[Double] = []
    for i in 0..<train_size {
      train.push(values[i])
    }
    let preds = linear_trend_forecast(train, horizon)
    for i in 0..<preds.length() {
      result.push(preds[i])
    }
    train_size = train_size + 1
  }
  result
}

///|
///===
/// Decomposition Extract
pub fn trend_extract(values : Array[Double], window : Int32) -> Array[Double] {
  simple_moving_average_forecast(values, window)
}

///|
pub fn seasonality_extract(
  values : Array[Double],
  season_length : Int32,
) -> Array[Double] {
  let decomp = seasonal_decompose(values, season_length)
  decomp.seasonal
}

///|
pub fn remainder_extract(
  values : Array[Double],
  season_length : Int32,
) -> Array[Double] {
  let decomp = seasonal_decompose(values, season_length)
  decomp.remainder
}

///|
///===
/// Changepoint & Anomaly Detection
pub fn detect_changepoint(
  values : Array[Double],
  threshold : Double,
) -> Array[Int32] {
  let n = values.length()
  if n < 2 {
    return []
  }
  let result : Array[Int32] = []
  for i in 1..<n {
    let diff = fc_abs_val(values[i] - values[i - 1])
    if diff > threshold {
      result.push(i)
    }
  }
  result
}

///|
pub fn detect_anomaly_forecast(
  values : Array[Double],
  predicted : Array[Double],
  threshold : Double,
) -> Array[Int32] {
  let n = if values.length() < predicted.length() {
    values.length()
  } else {
    predicted.length()
  }
  let result : Array[Int32] = []
  for i in 0..<n {
    let diff = fc_abs_val(values[i] - predicted[i])
    if diff > threshold {
      result.push(i)
    }
  }
  result
}

///|
///===
/// Forecast Intervals
pub fn forecast_interval(
  forecast : Array[Double],
  std_error : Double,
  z_value : Double,
) -> (Array[Double], Array[Double]) {
  let lower : Array[Double] = []
  let upper : Array[Double] = []
  let margin = z_value * std_error
  for i in 0..<forecast.length() {
    lower.push(forecast[i] - margin)
    upper.push(forecast[i] + margin)
  }
  (lower, upper)
}

///|
pub fn prediction_interval(
  forecast : Array[Double],
  residuals : Array[Double],
  z_value : Double,
) -> (Array[Double], Array[Double]) {
  let std = @_common.mean(residuals)
  let mut variance = 0.0
  let n = residuals.length()
  for i in 0..<n {
    let d = residuals[i] - std
    variance = variance + d * d
  }
  variance = if n > 0 { variance / n.to_double() } else { 0.0 }
  let std_err = variance.sqrt()
  forecast_interval(forecast, std_err, z_value)
}

///|
pub fn confidence_band(
  forecast : Array[Double],
  std_errors : Array[Double],
  z_value : Double,
) -> (Array[Double], Array[Double]) {
  let lower : Array[Double] = []
  let upper : Array[Double] = []
  for i in 0..<forecast.length() {
    let se = if i < std_errors.length() { std_errors[i] } else { 0.0 }
    let margin = z_value * se
    lower.push(forecast[i] - margin)
    upper.push(forecast[i] + margin)
  }
  (lower, upper)
}

///|
///===
/// Backtest & Validation
pub fn backtest(
  values : Array[Double],
  window : Int32,
  horizon : Int32,
) -> Array[Double] {
  rolling_forecast(values, window, horizon)
}

///|
pub fn walk_forward_validation(
  values : Array[Double],
  min_train : Int32,
  horizon : Int32,
) -> Array[Double] {
  let n = values.length()
  if n < min_train + horizon {
    return []
  }
  let errors : Array[Double] = []
  let mut train_size = min_train
  while train_size + horizon <= n {
    let train : Array[Double] = []
    for i in 0..<train_size {
      train.push(values[i])
    }
    let actual : Array[Double] = []
    for i in train_size..<(train_size + horizon) {
      actual.push(values[i])
    }
    let preds = linear_trend_forecast(train, horizon)
    errors.push(forecast_accuracy(actual, preds))
    train_size = train_size + horizon
  }
  errors
}

///|
///===
/// Benchmark
pub struct ForecastBenchmark {
  models : Array[String]
  scores : Array[Double]
}

///|
pub fn make_benchmark(models : Array[String]) -> ForecastBenchmark {
  { models, scores: Array::make(models.length(), 0.0), }
}

///|
pub fn benchmark_forecast(
  values : Array[Double],
  forecasts : Array[Array[Double]],
) -> ForecastBenchmark {
  let n = forecasts.length()
  let models : Array[String] = []
  let scores : Array[Double] = []
  for i in 0..<n {
    models.push("model_" + i.to_string())
    scores.push(forecast_accuracy(values, forecasts[i]))
  }
  { models, scores, }
}

///|
pub fn compare_forecasts(
  forecasts : Array[Array[Double]],
  actual : Array[Double],
) -> Array[Double] {
  let scores : Array[Double] = []
  for i in 0..<forecasts.length() {
    scores.push(forecast_accuracy(actual, forecasts[i]))
  }
  scores
}

///|
///===
/// ID
pub fn forecasting_id() -> String {
  "datatemporal/forecasting"
}
