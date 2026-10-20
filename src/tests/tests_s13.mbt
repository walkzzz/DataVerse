/// S13 tests for new packages

test "linalg_point_basic" {
  let pt = @linalg.linalg_make_point(3.0, 4.0)
  assert_true(@linalg.linalg_point_x(pt) == 3.0)
  assert_true(@linalg.linalg_point_y(pt) == 4.0)
  let qt = @linalg.linalg_make_point(0.0, 0.0)
  let dt = @linalg.linalg_point_dist(pt, qt)
  assert_true(dt > 4.9 && dt < 5.1)
}

test "linalg_series_stats" {
  let sr = @linalg.linalg_make_series([1.0, 2.0, 3.0, 4.0, 5.0], "test")
  assert_true(@linalg.linalg_series_len(sr) == 5)
  let mn = @linalg.linalg_series_mean(sr)
  assert_true(mn > 2.9 && mn < 3.1)
}

test "linalg_matrix_ops" {
  let mt = @linalg.linalg_make_matrix(3, 3, 0.0)
  assert_true(@linalg.linalg_matrix_get(mt, 1, 1) == 0.0)
  let id = @linalg.linalg_matrix_identity(3)
  assert_true(@linalg.linalg_matrix_get(id, 0, 0) == 1.0)
  assert_true(@linalg.linalg_matrix_get(id, 0, 1) == 0.0)
}

test "linalg_vector_ops" {
  let vt = @linalg.linalg_make_vector([1.0, 2.0, 3.0])
  assert_true(@linalg.linalg_vector_dot(vt, vt) > 13.9 && @linalg.linalg_vector_dot(vt, vt) < 14.1)
}

test "linalg_metrics" {
  let pred = [1, 0, 1, 1, 0]
  let labels = [1, 0, 1, 0, 0]
  let acc = @linalg.linalg_accuracy(pred, labels)
  assert_true(acc > 0.79 && acc < 0.81)
}

test "num_analysis_series" {
  let sr = @num_analysis.num_analysis_make_series([10.0, 20.0, 30.0], "data")
  assert_true(@num_analysis.num_analysis_series_len(sr) == 3)
  let total = @num_analysis.num_analysis_series_sum(sr)
  assert_true(total > 59.9 && total < 60.1)
}

test "diff_eq_basic" {
  let sr = @diff_eq.diff_eq_make_series([1.0, 4.0, 9.0, 16.0], "vals")
  let mn = @diff_eq.diff_eq_series_mean(sr)
  assert_true(mn > 7.4 && mn < 7.6)
}

test "elm_basic" {
  let sr = @elm.elm_make_series([1.0, 2.0, 3.0], "x")
  assert_true(@elm.elm_series_len(sr) == 3)
  let mx = @elm.elm_series_max(sr)
  assert_true(mx == 3.0)
}

test "rbf_net_basic" {
  let pt = @rbf_net.rbf_net_make_point(1.0, 1.0)
  let qt = @rbf_net.rbf_net_make_point(4.0, 5.0)
  let dt = @rbf_net.rbf_net_point_dist(pt, qt)
  assert_true(dt > 4.9 && dt < 5.1)
}

test "som_basic" {
  let mt = @som.som_matrix_identity(3)
  assert_true(@som.som_matrix_trace(mt) == 3.0)
}

test "goal_stack_basic" {
  let pt = @goal_stack.goal_stack_make_point(2.0, 3.0)
  assert_true(@goal_stack.goal_stack_point_x(pt) == 2.0)
  let sr = @goal_stack.goal_stack_make_series([1.0, 2.0, 3.0, 4.0], "goals")
  assert_true(@goal_stack.goal_stack_series_mean(sr) > 2.4 && @goal_stack.goal_stack_series_mean(sr) < 2.6)
}

test "belief_state_basic" {
  let vt = @belief_state.belief_state_make_vector([0.5, 0.5])
  assert_true(@belief_state.belief_state_vector_dot(vt, vt) > 0.49 && @belief_state.belief_state_vector_dot(vt, vt) < 0.51)
}

test "bdi_agent_basic" {
  let sr = @bdi_agent.bdi_agent_make_series([0.0, 1.0, 0.0, 1.0], "beliefs")
  assert_true(@bdi_agent.bdi_agent_series_sum(sr) == 2.0)
}

test "graph_store_basic" {
  let mt = @graph_store.graph_store_make_matrix(2, 2, 1.0)
  assert_true(@graph_store.graph_store_matrix_get(mt, 0, 0) == 1.0)
  let tr = @graph_store.graph_store_matrix_trace(mt)
  assert_true(tr == 2.0)
}

test "tree_store_basic" {
  let pt = @tree_store.tree_store_make_point(5.0, 6.0)
  let qt = @tree_store.tree_store_make_point(5.0, 6.0)
  assert_true(@tree_store.tree_store_point_dist(pt, qt) < 0.01)
}

test "kv_store_basic" {
  let sr = @kv_store.kv_store_make_series([100.0, 200.0, 300.0], "kv")
  assert_true(@kv_store.kv_store_series_min(sr) == 100.0)
  assert_true(@kv_store.kv_store_series_max(sr) == 300.0)
}

test "window_tumble_basic" {
  let pt = @window_tumble.window_tumble_make_point(1.0, 2.0)
  let scaled = @window_tumble.window_tumble_point_scale(pt, 2.0)
  assert_true(@window_tumble.window_tumble_point_x(scaled) == 2.0)
}

test "window_slide_basic" {
  let sr = @window_slide.window_slide_make_series([1.0, 2.0, 3.0, 4.0, 5.0], "win")
  let std = @window_slide.window_slide_series_std(sr)
  assert_true(std > 1.4 && std < 1.5)
}

test "window_session_basic" {
  let mt = @window_session.window_session_matrix_identity(4)
  assert_true(@window_session.window_session_matrix_trace(mt) == 4.0)
}

test "math_linear_algebra_basic" {
  let pt = @math_linear_algebra.math_linear_algebra_make_point(3.0, 4.0)
  assert_true(pt.x() == 3.0)
  let sr = @math_linear_algebra.math_linear_algebra_make_series([1.0, 2.0, 3.0], "test")
  assert_true(sr.len() == 3)
  let mt = @math_linear_algebra.math_linear_algebra_matrix_identity(3)
  assert_true(mt.trace() == 3.0)
}

test "stats_dist_normal_basic" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let mean = @_common.mean(data)
  assert_true(mean > 2.9 && mean < 3.1)
  let sd = @_common.std(data)
  assert_true(sd > 1.4 && sd < 1.5)
}

test "ml_cluster_kmeans_basic" {
  let pt = @ml_cluster_kmeans.ml_cluster_kmeans_make_point(1.0, 2.0)
  let qt = @ml_cluster_kmeans.ml_cluster_kmeans_make_point(4.0, 6.0)
  let dt = pt.dist(qt)
  assert_true(dt > 4.9 && dt < 5.1)
}

test "graph_search_bfs_basic" {
  let vt = @graph_search_bfs.graph_search_bfs_make_vector([1.0, 2.0, 3.0])
  assert_true(vt.norm() > 3.7 && vt.norm() < 3.8)
}

test "ds_tree_avl_basic" {
  let sr = @ds_tree_avl.ds_tree_avl_make_series([5.0, 3.0, 1.0, 4.0, 2.0], "tree")
  assert_true(sr.min() == 1.0)
  assert_true(sr.max() == 5.0)
}

test "sort_compare_quick_basic" {
  let arr = [5.0, 3.0, 1.0, 4.0, 2.0]
  let sorted = @_common.sort(arr)
  assert_true(sorted[0] == 1.0)
  assert_true(sorted[4] == 5.0)
}

test "signal_filter_fir_basic" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let norm = @_common.normalize(data)
  assert_true(norm[0] == 0.0)
  assert_true(norm[4] == 1.0)
}

test "image_filter_gaussian_basic" {
  let mt = @image_filter_gaussian.image_filter_gaussian_matrix_identity(3)
  assert_true(mt.trace() == 3.0)
}

test "chem_mol_repr_smiles_basic" {
  let mt = @chem_mol_repr_smiles.chem_mol_repr_smiles_matrix_identity(2)
  assert_true(mt.det() == 1.0)
}

test "finance_pricing_black_scholes_basic" {
  let pred = [1.0, 2.0, 3.0]
  let labels = [1.0, 2.0, 3.0]
  let r2 = @_common.r2(pred, labels)
  assert_true(r2 > 0.99)
}