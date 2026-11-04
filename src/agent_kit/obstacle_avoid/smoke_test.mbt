///|
/// # Smoke tests - auto-generated
///
test "obstacle_avoid_make_labeled_point_smoke" {
  let _ = @obstacle_avoid.obstacle_avoid_make_labeled_point(1.0, 1.0, 1)
}
///|
test "obstacle_avoid_make_matrix_smoke" {
  let _ = @obstacle_avoid.obstacle_avoid_make_matrix(1, 1, 1.0)
}
///|
test "obstacle_avoid_make_point_smoke" {
  let _ = @obstacle_avoid.obstacle_avoid_make_point(1.0, 1.0)
}
///|
test "obstacle_avoid_make_series_smoke" {
  let _ = @obstacle_avoid.obstacle_avoid_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "obstacle_avoid_make_vector_smoke" {
  let _ = @obstacle_avoid.obstacle_avoid_make_vector([1.0, 2.0, 3.0])
}
///|
test "obstacle_avoid_matrix_identity_smoke" {
  let _ = @obstacle_avoid.obstacle_avoid_matrix_identity(1)
}
///|
test "obstacle_avoid_vector_zero_smoke" {
  let _ = @obstacle_avoid.obstacle_avoid_vector_zero(1)
}
