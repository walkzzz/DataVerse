/// S13 tests for new packages

// === Named packages (gen_packages.py) ===

test "linalg_point_basic" {
  let p = @linalg.linalg_make_point(3.0, 4.0)
  assert_true(@linalg.linalg_point_x(p) == 3.0)
  assert_true(@linalg.linalg_point_y(p) == 4.0)
  let q = @linalg.linalg_make_point(0.0, 0.0)
  let d = @linalg.linalg_point_dist(p, q)
  assert_true(d > 4.9 && d < 5.1)
}

test "linalg_series_stats" {
  let s = @linalg.linalg_make_series([1.0, 2.0, 3.0, 4.0, 5.0], "test")
  assert_true(@linalg.linalg_series_len(s) == 5)
  let m = @linalg.linalg_series_mean(s)
  assert_true(m > 2.9 && m < 3.1)
}

test "linalg_matrix_ops" {
  let m = @linalg.linalg_make_matrix(3, 3, 0.0)
  assert_true(@linalg.linalg_matrix_get(m, 1, 1) == 0.0)
  let id = @linalg.linalg_matrix_identity(3)
  assert_true(@linalg.linalg_matrix_get(id, 0, 0) == 1.0)
  assert_true(@linalg.linalg_matrix_get(id, 0, 1) == 0.0)
}

test "linalg_vector_ops" {
  let v = @linalg.linalg_make_vector([1.0, 2.0, 3.0])
  assert_true(@linalg.linalg_vector_dot(v, v) > 13.9 && @linalg.linalg_vector_dot(v, v) < 14.1)
}

test "linalg_metrics" {
  let pred = [1, 0, 1, 1, 0]
  let labels = [1, 0, 1, 0, 0]
  let acc = @linalg.linalg_accuracy(pred, labels)
  assert_true(acc > 0.79 && acc < 0.81)
}

test "num_analysis_point" {
  let p = @num_analysis.num_analysis_make_point(1.0, 2.0)
  assert_true(@num_analysis.num_analysis_point_x(p) == 1.0)
}

test "num_analysis_series" {
  let s = @num_analysis.num_analysis_make_series([10.0, 20.0, 30.0], "data")
  assert_true(@num_analysis.num_analysis_series_len(s) == 3)
  let total = @num_analysis.num_analysis_series_sum(s)
  assert_true(total > 59.9 && total < 60.1)
}

test "diff_eq_basic" {
  let p = @diff_eq.diff_eq_make_point(0.0, 1.0)
  assert_true(@diff_eq.diff_eq_point_y(p) == 1.0)
  let s = @diff_eq.diff_eq_make_series([1.0, 4.0, 9.0, 16.0], "vals")
  let m = @diff_eq.diff_eq_series_mean(s)
  assert_true(m > 7.4 && m < 7.6)
}

test "elm_basic" {
  let s = @elm.elm_make_series([1.0, 2.0, 3.0], "x")
  assert_true(@elm.elm_series_len(s) == 3)
  let m = @elm.elm_series_max(s)
  assert_true(m == 3.0)
}

test "rbf_net_basic" {
  let p = @rbf_net.rbf_net_make_point(1.0, 1.0)
  let q = @rbf_net.rbf_net_make_point(4.0, 5.0)
  let d = @rbf_net.rbf_net_point_dist(p, q)
  assert_true(d > 4.9 && d < 5.1)
}

test "som_basic" {
  let m = @som.som_matrix_identity(3)
  assert_true(@som.som_matrix_trace(m) == 3.0)
}

test "goal_stack_basic" {
  let p = @goal_stack.goal_stack_make_point(2.0, 3.0)
  assert_true(@goal_stack.goal_stack_point_x(p) == 2.0)
  let s = @goal_stack.goal_stack_make_series([1.0, 2.0, 3.0, 4.0], "goals")
  assert_true(@goal_stack.goal_stack_series_mean(s) > 2.4 && @goal_stack.goal_stack_series_mean(s) < 2.6)
}

test "belief_state_basic" {
  let v = @belief_state.belief_state_make_vector([0.5, 0.5])
  assert_true(@belief_state.belief_state_vector_dot(v, v) > 0.49 && @belief_state.belief_state_vector_dot(v, v) < 0.51)
}

test "bdi_agent_basic" {
  let s = @bdi_agent.bdi_agent_make_series([0.0, 1.0, 0.0, 1.0], "beliefs")
  assert_true(@bdi_agent.bdi_agent_series_sum(s) == 2.0)
}

test "graph_store_basic" {
  let m = @graph_store.graph_store_make_matrix(2, 2, 1.0)
  assert_true(@graph_store.graph_store_matrix_get(m, 0, 0) == 1.0)
  let t = @graph_store.graph_store_matrix_trace(m)
  assert_true(t == 2.0)
}

test "tree_store_basic" {
  let p = @tree_store.tree_store_make_point(5.0, 6.0)
  let q = @tree_store.tree_store_make_point(5.0, 6.0)
  assert_true(@tree_store.tree_store_point_dist(p, q) < 0.01)
}

test "kv_store_basic" {
  let s = @kv_store.kv_store_make_series([100.0, 200.0, 300.0], "kv")
  assert_true(@kv_store.kv_store_series_min(s) == 100.0)
  assert_true(@kv_store.kv_store_series_max(s) == 300.0)
}

test "window_tumble_basic" {
  let p = @window_tumble.window_tumble_make_point(1.0, 2.0)
  let scaled = @window_tumble.window_tumble_point_scale(p, 2.0)
  assert_true(@window_tumble.window_tumble_point_x(scaled) == 2.0)
}

test "window_slide_basic" {
  let s = @window_slide.window_slide_make_series([1.0, 2.0, 3.0, 4.0, 5.0], "win")
  let std = @window_slide.window_slide_series_std(s)
  assert_true(std > 1.4 && std < 1.5)
}

test "window_session_basic" {
  let m = @window_session.window_session_matrix_identity(4)
  assert_true(@window_session.window_session_matrix_trace(m) == 4.0)
}

// === Numbered packages (gen_phase2.py) ===

test "p0001_basic" {
  let p = @p0001.p0001_make_point(3.0, 4.0)
  assert_true(@p0001.p0001_point_x(p) == 3.0)
  let s = @p0001.p0001_make_series([1.0, 2.0, 3.0], "test")
  assert_true(@p0001.p0001_series_len(s) == 3)
  let m = @p0001.p0001_matrix_identity(3)
  assert_true(@p0001.p0001_matrix_trace(m) == 3.0)
}

test "p0001_stats" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let mean = @p0001.p0001_mean(data)
  assert_true(mean > 2.9 && mean < 3.1)
  let sd = @p0001.p0001_std(data)
  assert_true(sd > 1.4 && sd < 1.5)
}

test "p0001_sort" {
  let arr = [5.0, 3.0, 1.0, 4.0, 2.0]
  let sorted = @p0001.p0001_sort(arr)
  assert_true(sorted[0] == 1.0)
  assert_true(sorted[4] == 5.0)
}

test "p0001_prime" {
  assert_true(@p0001.p0001_is_prime(7))
  assert_false(@p0001.p0001_is_prime(8))
  assert_true(@p0001.p0001_is_prime(2))
  assert_false(@p0001.p0001_is_prime(1))
}

test "p0001_fibonacci" {
  assert_true(@p0001.p0001_fibonacci(0) == 0)
  assert_true(@p0001.p0001_fibonacci(1) == 1)
  assert_true(@p0001.p0001_fibonacci(10) == 55)
}

test "p0100_basic" {
  let p = @p0100.p0100_make_point(1.0, 2.0)
  let q = @p0100.p0100_make_point(4.0, 6.0)
  let d = @p0100.p0100_point_dist(p, q)
  assert_true(d > 4.9 && d < 5.1)
  let s = @p0100.p0100_make_series([10.0, 20.0, 30.0], "data")
  assert_true(@p0100.p0100_series_sum(s) > 59.9 && @p0100.p0100_series_sum(s) < 60.1)
}

test "p0100_matrix" {
  let a = @p0100.p0100_make_matrix(2, 2, 1.0)
  let b = @p0100.p0100_make_matrix(2, 2, 2.0)
  let c = @p0100.p0100_matrix_add(a, b)
  assert_true(@p0100.p0100_matrix_get(c, 0, 0) == 3.0)
}

test "p0500_basic" {
  let v = @p0500.p0500_make_vector([3.0, 4.0])
  let n = @p0500.p0500_vector_norm(v)
  assert_true(n > 4.9 && n < 5.1)
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let mn = @p0500.p0500_min(data)
  let mx = @p0500.p0500_max(data)
  assert_true(mn == 1.0)
  assert_true(mx == 5.0)
}

test "p0500_normalize" {
  let data = [0.0, 5.0, 10.0]
  let norm = @p0500.p0500_normalize(data)
  assert_true(norm[0] == 0.0)
  assert_true(norm[2] == 1.0)
}

test "p0820_basic" {
  let p = @p0820.p0820_make_point3(1.0, 2.0, 3.0)
  assert_true(@p0820.p0820_point_z(p) == 3.0)
  let s = @p0820.p0820_make_series([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0], "x")
  assert_true(@p0820.p0820_series_mean(s) > 5.4 && @p0820.p0820_series_mean(s) < 5.6)
}

test "p0820_graph" {
  let g = @p0820.p0820_make_graph(3)
  let g2 = @p0820.p0820_graph_add_edge(g, 0, 1, 1.0)
  let g3 = @p0820.p0820_graph_add_edge(g2, 1, 2, 1.0)
  assert_true(@p0820.p0820_graph_edge_count(g3) == 2)
  assert_true(@p0820.p0820_graph_degree(g3, 0) == 1)
}

test "p0820_linked_list" {
  let lst = @p0820.p0820_make_linked_list()
  let lst2 = @p0820.p0820_ll_push(lst, 10.0)
  let lst3 = @p0820.p0820_ll_push(lst2, 20.0)
  assert_true(@p0820.p0820_ll_get(lst3, 0) == 10.0)
  assert_true(@p0820.p0820_ll_get(lst3, 1) == 20.0)
  assert_true(@p0820.p0820_ll_sum(lst3) > 29.9 && @p0820.p0820_ll_sum(lst3) < 30.1)
}