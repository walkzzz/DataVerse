///|
/// # Smoke tests - auto-generated
///
test "graph_model_graph_model_id_smoke" {
  let _ = @graph.graph_model_graph_model_id()
}
///|
test "graph_model_make_bayes_net_gm_smoke" {
  let _ = @graph.graph_model_make_bayes_net_gm()
}
///|
test "graph_model_make_factor_graph_smoke" {
  let _ = @graph.graph_model_make_factor_graph(["a", "b"])
}
///|
test "graph_model_make_mrf_smoke" {
  let _ = @graph.graph_model_make_mrf(["a", "b"])
}
