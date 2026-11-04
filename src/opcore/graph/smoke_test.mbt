///|
/// # Smoke tests - auto-generated
///
test "graph_analytics_graph_analytics_id_smoke" {
  let _ = @graph.graph_analytics_graph_analytics_id()
}
///|
test "graph_analytics_make_graph_smoke" {
  let _ = @graph.graph_analytics_make_graph(true, true)
}
///|
test "recommendation_make_contextual_smoke" {
  let _ = @graph.recommendation_make_contextual(1)
}
///|
test "recommendation_make_embedding_rec_smoke" {
  let _ = @graph.recommendation_make_embedding_rec(1, 1)
}
///|
test "recommendation_make_interaction_smoke" {
  let _ = @graph.recommendation_make_interaction(1, 1, 1)
}
///|
test "recommendation_make_item_smoke" {
  let _ = @graph.recommendation_make_item(1, [1.0, 2.0, 3.0])
}
///|
test "recommendation_make_rating_smoke" {
  let _ = @graph.recommendation_make_rating(1, 1, 1.0)
}
///|
test "recommendation_make_rating_matrix_smoke" {
  let _ = @graph.recommendation_make_rating_matrix(1, 1)
}
///|
test "recommendation_make_rule_rec_smoke" {
  let _ = @graph.recommendation_make_rule_rec(1, 1.0)
}
///|
test "recommendation_make_session_smoke" {
  let _ = @graph.recommendation_make_session(1, [1, 2, 3], [1, 2, 3])
}
