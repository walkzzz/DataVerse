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
  assert_true(@math_linear_algebra.math_linear_algebra_point_x(pt) == 3.0)
  let sr = @math_linear_algebra.math_linear_algebra_make_series([1.0, 2.0, 3.0], "test")
  assert_true(@math_linear_algebra.math_linear_algebra_series_len(sr) == 3)
  let mt = @math_linear_algebra.math_linear_algebra_matrix_identity(3)
  assert_true(@math_linear_algebra.math_linear_algebra_matrix_trace(mt) == 3.0)
}

test "stats_dist_normal_basic" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let mean = @stats_dist_normal.stats_dist_normal_mean(data)
  assert_true(mean > 2.9 && mean < 3.1)
  let sd = @stats_dist_normal.stats_dist_normal_std(data)
  assert_true(sd > 1.4 && sd < 1.5)
}

test "ml_cluster_kmeans_basic" {
  let pt = @ml_cluster_kmeans.ml_cluster_kmeans_make_point(1.0, 2.0)
  let qt = @ml_cluster_kmeans.ml_cluster_kmeans_make_point(4.0, 6.0)
  let dt = @ml_cluster_kmeans.ml_cluster_kmeans_point_dist(pt, qt)
  assert_true(dt > 4.9 && dt < 5.1)
}

test "graph_search_bfs_basic" {
  let vt = @graph_search_bfs.graph_search_bfs_make_vector([1.0, 2.0, 3.0])
  assert_true(@graph_search_bfs.graph_search_bfs_vector_norm(vt) > 3.7 && @graph_search_bfs.graph_search_bfs_vector_norm(vt) < 3.8)
}

test "ds_tree_avl_basic" {
  let sr = @ds_tree_avl.ds_tree_avl_make_series([5.0, 3.0, 1.0, 4.0, 2.0], "tree")
  assert_true(@ds_tree_avl.ds_tree_avl_series_min(sr) == 1.0)
  assert_true(@ds_tree_avl.ds_tree_avl_series_max(sr) == 5.0)
}

test "sort_compare_quick_basic" {
  let arr = [5.0, 3.0, 1.0, 4.0, 2.0]
  let sorted = @sort_compare_quick.sort_compare_quick_sort(arr)
  assert_true(sorted[0] == 1.0)
  assert_true(sorted[4] == 5.0)
}

test "signal_filter_fir_basic" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let norm = @signal_filter_fir.signal_filter_fir_normalize(data)
  assert_true(norm[0] == 0.0)
  assert_true(norm[4] == 1.0)
}

test "image_filter_gaussian_basic" {
  let mt = @image_filter_gaussian.image_filter_gaussian_matrix_identity(3)
  assert_true(@image_filter_gaussian.image_filter_gaussian_matrix_trace(mt) == 3.0)
}

test "crypto_sym_aes_basic" {
  assert_true(@crypto_sym_aes.crypto_sym_aes_is_prime(7))
  assert_false(@crypto_sym_aes.crypto_sym_aes_is_prime(8))
  assert_true(@crypto_sym_aes.crypto_sym_aes_fibonacci(10) == 55)
}

test "timeseries_arima_basic" {
  let sr = @timeseries_arima.timeseries_arima_make_series([1.0, 4.0, 9.0, 16.0, 25.0], "series")
  assert_true(@timeseries_arima.timeseries_arima_series_mean(sr) > 10.9 && @timeseries_arima.timeseries_arima_series_mean(sr) < 11.1)
}

test "nlp_tokenize_word_basic" {
  let pt = @nlp_tokenize_word.nlp_tokenize_word_make_point3(1.0, 2.0, 3.0)
  assert_true(@nlp_tokenize_word.nlp_tokenize_word_point_z(pt) == 3.0)
}

test "geo_dist_haversine_basic" {
  let pt = @geo_dist_haversine.geo_dist_haversine_make_point(0.0, 0.0)
  let qt = @geo_dist_haversine.geo_dist_haversine_make_point(3.0, 4.0)
  let dt = @geo_dist_haversine.geo_dist_haversine_point_dist(pt, qt)
  assert_true(dt > 4.9 && dt < 5.1)
}

test "opt_grad_adam_basic" {
  let data = [0.5, 1.0, 1.5, 2.0]
  let mn = @opt_grad_adam.opt_grad_adam_mean(data)
  assert_true(mn > 1.2 && mn < 1.3)
}

test "db_index_btree_basic" {
  let vt = @db_index_btree.db_index_btree_make_vector([10.0, 20.0, 30.0])
  assert_true(@db_index_btree.db_index_btree_vector_dot(vt, vt) > 1399.9 && @db_index_btree.db_index_btree_vector_dot(vt, vt) < 1400.1)
}

test "net_proto_tcp_basic" {
  let sr = @net_proto_tcp.net_proto_tcp_make_series([1.0, 2.0, 3.0, 4.0], "packets")
  assert_true(@net_proto_tcp.net_proto_tcp_series_sum(sr) == 10.0)
}

test "physics_mechanics_kinematic_basic" {
  let pt = @physics_mechanics_kinematic.physics_mechanics_kinematic_make_point(0.0, 0.0)
  let qt = @physics_mechanics_kinematic.physics_mechanics_kinematic_make_point(0.0, 9.8)
  let dt = @physics_mechanics_kinematic.physics_mechanics_kinematic_point_dist(pt, qt)
  assert_true(dt > 9.7 && dt < 9.9)
}

test "bio_seq_align_global_basic" {
  let data = [1.0, 2.0, 3.0]
  let sorted = @bio_seq_align_global.bio_seq_align_global_sort(data)
  assert_true(sorted[0] == 1.0 && sorted[2] == 3.0)
}

test "chem_mol_repr_smiles_basic" {
  let mt = @chem_mol_repr_smiles.chem_mol_repr_smiles_matrix_identity(2)
  assert_true(@chem_mol_repr_smiles.chem_mol_repr_smiles_matrix_det(mt) == 1.0)
}

test "finance_pricing_black_scholes_basic" {
  let pred = [1.0, 2.0, 3.0]
  let labels = [1.0, 2.0, 3.0]
  let r2 = @finance_pricing_black_scholes.finance_pricing_black_scholes_r2(pred, labels)
  assert_true(r2 > 0.99)
}