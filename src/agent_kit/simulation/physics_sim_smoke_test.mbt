///|
/// # Smoke tests - auto-generated
///
test "physics_sim_make_labeled_point_smoke" {
  let _ = @types.dv_make_labeled_point(1.0, 1.0, 1)
}
///|
test "physics_sim_make_matrix_smoke" {
  let _ = @types.dv_make_matrix(1, 1, 1.0)
}
///|
test "physics_sim_make_point_smoke" {
  let _ = @types.dv_make_point(1.0, 1.0)
}
///|
test "physics_sim_make_series_smoke" {
  let _ = @types.dv_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "physics_sim_make_vector_smoke" {
  let _ = @types.dv_make_vector([1.0, 2.0, 3.0])
}
///|
test "physics_sim_matrix_identity_smoke" {
  let _ = @types.dv_matrix_identity(1)
}
///|
test "physics_sim_vector_zero_smoke" {
  let _ = @types.dv_vector_zero(1)
}
