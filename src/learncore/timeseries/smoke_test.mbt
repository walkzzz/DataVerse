///|
/// # Smoke tests - auto-generated
///
test "timeseries_make_arima_params_smoke" {
  let _ = @timeseries.timeseries_make_arima_params(1, 1, 1)
}
///|
test "timeseries_make_garch_params_smoke" {
  let _ = @timeseries.timeseries_make_garch_params(1, 1, [1.0, 2.0, 3.0], [1.0, 2.0, 3.0], 1.0)
}
///|
test "timeseries_make_holt_winters_params_smoke" {
  let _ = @timeseries.timeseries_make_holt_winters_params(1.0, 1.0, 1.0, 1)
}
///|
test "timeseries_timeseries_id_smoke" {
  let _ = @timeseries.timeseries_timeseries_id()
}
