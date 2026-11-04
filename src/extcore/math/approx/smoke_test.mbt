///|
/// # Smoke tests - auto-generated
///
test "math_approx_chebyshev_make_matrix_smoke" {
  let _ = @approx.math_approx_chebyshev_make_matrix(1, 1, 1.0)
}
///|
test "math_approx_chebyshev_make_point_smoke" {
  let _ = @approx.math_approx_chebyshev_make_point(1.0, 1.0)
}
///|
test "math_approx_chebyshev_make_point3_smoke" {
  let _ = @approx.math_approx_chebyshev_make_point3(1.0, 1.0, 1.0)
}
///|
test "math_approx_chebyshev_make_series_smoke" {
  let _ = @approx.math_approx_chebyshev_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "math_approx_chebyshev_make_vector_smoke" {
  let _ = @approx.math_approx_chebyshev_make_vector([1.0, 2.0, 3.0])
}
///|
test "math_approx_chebyshev_matrix_identity_smoke" {
  let _ = @approx.math_approx_chebyshev_matrix_identity(1)
}
///|
test "math_approx_chebyshev_vector_zero_smoke" {
  let _ = @approx.math_approx_chebyshev_vector_zero(1)
}
///|
test "math_approx_fourier_make_matrix_smoke" {
  let _ = @approx.math_approx_fourier_make_matrix(1, 1, 1.0)
}
///|
test "math_approx_fourier_make_point_smoke" {
  let _ = @approx.math_approx_fourier_make_point(1.0, 1.0)
}
///|
test "math_approx_fourier_make_point3_smoke" {
  let _ = @approx.math_approx_fourier_make_point3(1.0, 1.0, 1.0)
}
