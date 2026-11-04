///|
/// # Smoke tests - auto-generated
///
test "belief_state_make_labeled_point_smoke" {
  let _ = @belief_state.belief_state_make_labeled_point(1.0, 1.0, 1)
}
///|
test "belief_state_make_matrix_smoke" {
  let _ = @belief_state.belief_state_make_matrix(1, 1, 1.0)
}
///|
test "belief_state_make_point_smoke" {
  let _ = @belief_state.belief_state_make_point(1.0, 1.0)
}
///|
test "belief_state_make_series_smoke" {
  let _ = @belief_state.belief_state_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "belief_state_make_vector_smoke" {
  let _ = @belief_state.belief_state_make_vector([1.0, 2.0, 3.0])
}
///|
test "belief_state_matrix_identity_smoke" {
  let _ = @belief_state.belief_state_matrix_identity(1)
}
///|
test "belief_state_vector_zero_smoke" {
  let _ = @belief_state.belief_state_vector_zero(1)
}
