///|
/// # Smoke tests - auto-generated
///
test "finance_portfolio_apt_make_matrix_smoke" {
  let _ = @portfolio.finance_portfolio_apt_make_matrix(1, 1, 1.0)
}
///|
test "finance_portfolio_apt_make_point_smoke" {
  let _ = @portfolio.finance_portfolio_apt_make_point(1.0, 1.0)
}
///|
test "finance_portfolio_apt_make_point3_smoke" {
  let _ = @portfolio.finance_portfolio_apt_make_point3(1.0, 1.0, 1.0)
}
///|
test "finance_portfolio_apt_make_series_smoke" {
  let _ = @portfolio.finance_portfolio_apt_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "finance_portfolio_apt_make_vector_smoke" {
  let _ = @portfolio.finance_portfolio_apt_make_vector([1.0, 2.0, 3.0])
}
///|
test "finance_portfolio_apt_matrix_identity_smoke" {
  let _ = @portfolio.finance_portfolio_apt_matrix_identity(1)
}
///|
test "finance_portfolio_apt_vector_zero_smoke" {
  let _ = @portfolio.finance_portfolio_apt_vector_zero(1)
}
///|
test "finance_portfolio_black_litterman_make_matrix_smoke" {
  let _ = @portfolio.finance_portfolio_black_litterman_make_matrix(1, 1, 1.0)
}
///|
test "finance_portfolio_black_litterman_make_point_smoke" {
  let _ = @portfolio.finance_portfolio_black_litterman_make_point(1.0, 1.0)
}
///|
test "finance_portfolio_black_litterman_make_point3_smoke" {
  let _ = @portfolio.finance_portfolio_black_litterman_make_point3(1.0, 1.0, 1.0)
}
