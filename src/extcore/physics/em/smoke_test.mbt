///|
/// # Smoke tests - auto-generated
///
test "physics_em_bem_make_matrix_smoke" {
  let _ = @em.physics_em_bem_make_matrix(1, 1, 1.0)
}
///|
test "physics_em_bem_make_point_smoke" {
  let _ = @em.physics_em_bem_make_point(1.0, 1.0)
}
///|
test "physics_em_bem_make_point3_smoke" {
  let _ = @em.physics_em_bem_make_point3(1.0, 1.0, 1.0)
}
///|
test "physics_em_bem_make_series_smoke" {
  let _ = @em.physics_em_bem_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "physics_em_bem_make_vector_smoke" {
  let _ = @em.physics_em_bem_make_vector([1.0, 2.0, 3.0])
}
///|
test "physics_em_bem_matrix_identity_smoke" {
  let _ = @em.physics_em_bem_matrix_identity(1)
}
///|
test "physics_em_bem_vector_zero_smoke" {
  let _ = @em.physics_em_bem_vector_zero(1)
}
///|
test "physics_em_eddy_make_matrix_smoke" {
  let _ = @em.physics_em_eddy_make_matrix(1, 1, 1.0)
}
///|
test "physics_em_eddy_make_point_smoke" {
  let _ = @em.physics_em_eddy_make_point(1.0, 1.0)
}
///|
test "physics_em_eddy_make_point3_smoke" {
  let _ = @em.physics_em_eddy_make_point3(1.0, 1.0, 1.0)
}
