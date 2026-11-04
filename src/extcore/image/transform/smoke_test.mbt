///|
/// # Smoke tests - auto-generated
///
test "image_transform_affine_make_matrix_smoke" {
  let _ = @transform.image_transform_affine_make_matrix(1, 1, 1.0)
}
///|
test "image_transform_affine_make_point_smoke" {
  let _ = @transform.image_transform_affine_make_point(1.0, 1.0)
}
///|
test "image_transform_affine_make_point3_smoke" {
  let _ = @transform.image_transform_affine_make_point3(1.0, 1.0, 1.0)
}
///|
test "image_transform_affine_make_series_smoke" {
  let _ = @transform.image_transform_affine_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "image_transform_affine_make_vector_smoke" {
  let _ = @transform.image_transform_affine_make_vector([1.0, 2.0, 3.0])
}
///|
test "image_transform_affine_matrix_identity_smoke" {
  let _ = @transform.image_transform_affine_matrix_identity(1)
}
///|
test "image_transform_affine_vector_zero_smoke" {
  let _ = @transform.image_transform_affine_vector_zero(1)
}
///|
test "image_transform_flip_make_matrix_smoke" {
  let _ = @transform.image_transform_flip_make_matrix(1, 1, 1.0)
}
///|
test "image_transform_flip_make_point_smoke" {
  let _ = @transform.image_transform_flip_make_point(1.0, 1.0)
}
///|
test "image_transform_flip_make_point3_smoke" {
  let _ = @transform.image_transform_flip_make_point3(1.0, 1.0, 1.0)
}
