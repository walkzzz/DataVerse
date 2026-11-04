///|
/// # Smoke tests - auto-generated
///
test "geo_dist_ellipsoidal_make_matrix_smoke" {
  let _ = @dist.geo_dist_ellipsoidal_make_matrix(1, 1, 1.0)
}
///|
test "geo_dist_ellipsoidal_make_point_smoke" {
  let _ = @dist.geo_dist_ellipsoidal_make_point(1.0, 1.0)
}
///|
test "geo_dist_ellipsoidal_make_point3_smoke" {
  let _ = @dist.geo_dist_ellipsoidal_make_point3(1.0, 1.0, 1.0)
}
///|
test "geo_dist_ellipsoidal_make_series_smoke" {
  let _ = @dist.geo_dist_ellipsoidal_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "geo_dist_ellipsoidal_make_vector_smoke" {
  let _ = @dist.geo_dist_ellipsoidal_make_vector([1.0, 2.0, 3.0])
}
///|
test "geo_dist_ellipsoidal_matrix_identity_smoke" {
  let _ = @dist.geo_dist_ellipsoidal_matrix_identity(1)
}
///|
test "geo_dist_ellipsoidal_vector_zero_smoke" {
  let _ = @dist.geo_dist_ellipsoidal_vector_zero(1)
}
///|
test "geo_dist_euclidean_make_matrix_smoke" {
  let _ = @dist.geo_dist_euclidean_make_matrix(1, 1, 1.0)
}
///|
test "geo_dist_euclidean_make_point_smoke" {
  let _ = @dist.geo_dist_euclidean_make_point(1.0, 1.0)
}
///|
test "geo_dist_euclidean_make_point3_smoke" {
  let _ = @dist.geo_dist_euclidean_make_point3(1.0, 1.0, 1.0)
}
