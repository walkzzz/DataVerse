///|
/// # Smoke tests - auto-generated
///
test "org_agent_make_labeled_point_smoke" {
  let _ = @agents.org_agent_make_labeled_point(1.0, 1.0, 1)
}
///|
test "org_agent_make_matrix_smoke" {
  let _ = @agents.org_agent_make_matrix(1, 1, 1.0)
}
///|
test "org_agent_make_point_smoke" {
  let _ = @agents.org_agent_make_point(1.0, 1.0)
}
///|
test "org_agent_make_series_smoke" {
  let _ = @agents.org_agent_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "org_agent_make_vector_smoke" {
  let _ = @agents.org_agent_make_vector([1.0, 2.0, 3.0])
}
///|
test "org_agent_matrix_identity_smoke" {
  let _ = @agents.org_agent_matrix_identity(1)
}
///|
test "org_agent_vector_zero_smoke" {
  let _ = @agents.org_agent_vector_zero(1)
}
