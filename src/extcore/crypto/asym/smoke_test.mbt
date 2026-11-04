///|
/// # Smoke tests - auto-generated
///
test "crypto_asym_dh_make_matrix_smoke" {
  let _ = @asym.crypto_asym_dh_make_matrix(1, 1, 1.0)
}
///|
test "crypto_asym_dh_make_point_smoke" {
  let _ = @asym.crypto_asym_dh_make_point(1.0, 1.0)
}
///|
test "crypto_asym_dh_make_point3_smoke" {
  let _ = @asym.crypto_asym_dh_make_point3(1.0, 1.0, 1.0)
}
///|
test "crypto_asym_dh_make_series_smoke" {
  let _ = @asym.crypto_asym_dh_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "crypto_asym_dh_make_vector_smoke" {
  let _ = @asym.crypto_asym_dh_make_vector([1.0, 2.0, 3.0])
}
///|
test "crypto_asym_dh_matrix_identity_smoke" {
  let _ = @asym.crypto_asym_dh_matrix_identity(1)
}
///|
test "crypto_asym_dh_vector_zero_smoke" {
  let _ = @asym.crypto_asym_dh_vector_zero(1)
}
///|
test "crypto_asym_dsa_make_matrix_smoke" {
  let _ = @asym.crypto_asym_dsa_make_matrix(1, 1, 1.0)
}
///|
test "crypto_asym_dsa_make_point_smoke" {
  let _ = @asym.crypto_asym_dsa_make_point(1.0, 1.0)
}
///|
test "crypto_asym_dsa_make_point3_smoke" {
  let _ = @asym.crypto_asym_dsa_make_point3(1.0, 1.0, 1.0)
}
