///|
/// # Smoke tests - auto-generated
///
test "image_feature_akaze_make_matrix_smoke" {
  let _ = @feature.image_feature_akaze_make_matrix(1, 1, 1.0)
}
///|
test "image_feature_akaze_make_point_smoke" {
  let _ = @feature.image_feature_akaze_make_point(1.0, 1.0)
}
///|
test "image_feature_akaze_make_point3_smoke" {
  let _ = @feature.image_feature_akaze_make_point3(1.0, 1.0, 1.0)
}
///|
test "image_feature_akaze_make_series_smoke" {
  let _ = @feature.image_feature_akaze_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "image_feature_akaze_make_vector_smoke" {
  let _ = @feature.image_feature_akaze_make_vector([1.0, 2.0, 3.0])
}
///|
test "image_feature_akaze_matrix_identity_smoke" {
  let _ = @feature.image_feature_akaze_matrix_identity(1)
}
///|
test "image_feature_akaze_vector_zero_smoke" {
  let _ = @feature.image_feature_akaze_vector_zero(1)
}
///|
test "image_feature_blob_make_matrix_smoke" {
  let _ = @feature.image_feature_blob_make_matrix(1, 1, 1.0)
}
///|
test "image_feature_blob_make_point_smoke" {
  let _ = @feature.image_feature_blob_make_point(1.0, 1.0)
}
///|
test "image_feature_blob_make_point3_smoke" {
  let _ = @feature.image_feature_blob_make_point3(1.0, 1.0, 1.0)
}
