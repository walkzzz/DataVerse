///|
/// # Smoke tests - auto-generated
///
test "graph_flow_assignment_make_matrix_smoke" {
  let _ = @flow.graph_flow_assignment_make_matrix(1, 1, 1.0)
}
///|
test "graph_flow_assignment_make_point_smoke" {
  let _ = @flow.graph_flow_assignment_make_point(1.0, 1.0)
}
///|
test "graph_flow_assignment_make_point3_smoke" {
  let _ = @flow.graph_flow_assignment_make_point3(1.0, 1.0, 1.0)
}
///|
test "graph_flow_assignment_make_series_smoke" {
  let _ = @flow.graph_flow_assignment_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "graph_flow_assignment_make_vector_smoke" {
  let _ = @flow.graph_flow_assignment_make_vector([1.0, 2.0, 3.0])
}
///|
test "graph_flow_assignment_matrix_identity_smoke" {
  let _ = @flow.graph_flow_assignment_matrix_identity(1)
}
///|
test "graph_flow_assignment_vector_zero_smoke" {
  let _ = @flow.graph_flow_assignment_vector_zero(1)
}
///|
test "graph_flow_bipartite_make_matrix_smoke" {
  let _ = @flow.graph_flow_bipartite_make_matrix(1, 1, 1.0)
}
///|
test "graph_flow_bipartite_make_point_smoke" {
  let _ = @flow.graph_flow_bipartite_make_point(1.0, 1.0)
}
///|
test "graph_flow_bipartite_make_point3_smoke" {
  let _ = @flow.graph_flow_bipartite_make_point3(1.0, 1.0, 1.0)
}
