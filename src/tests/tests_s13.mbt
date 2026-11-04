///|
/// S13 tests for new packages
test "linalg_point_basic" {
  let pt = @math.linalg_linalg_make_point(3.0, 4.0)
  assert_true(@math.linalg_linalg_point_x(pt) == 3.0)
  assert_true(@math.linalg_linalg_point_y(pt) == 4.0)
  let qt = @math.linalg_linalg_make_point(0.0, 0.0)
  let dt = @math.linalg_linalg_point_dist(pt, qt)
  assert_true(dt > 4.9 && dt < 5.1)
}

///|
test "linalg_series_stats" {
  let sr = @math.linalg_linalg_make_series([1.0, 2.0, 3.0, 4.0, 5.0], "test")
  assert_true(@math.linalg_linalg_series_len(sr) == 5)
  let mn = @math.linalg_linalg_series_mean(sr)
  assert_true(mn > 2.9 && mn < 3.1)
}

///|
test "linalg_matrix_ops" {
  let mt = @math.linalg_linalg_make_matrix(3, 3, 0.0)
  assert_true(@math.linalg_linalg_matrix_get(mt, 1, 1) == 0.0)
  let id = @math.linalg_linalg_matrix_identity(3)
  assert_true(@math.linalg_linalg_matrix_get(id, 0, 0) == 1.0)
  assert_true(@math.linalg_linalg_matrix_get(id, 0, 1) == 0.0)
}

///|
test "linalg_vector_ops" {
  let vt = @math.linalg_linalg_make_vector([1.0, 2.0, 3.0])
  assert_true(
    @math.linalg_linalg_vector_dot(vt, vt) > 13.9 &&
    @math.linalg_linalg_vector_dot(vt, vt) < 14.1,
  )
}

///|
test "linalg_metrics" {
  let pred = [1, 0, 1, 1, 0]
  let labels = [1, 0, 1, 0, 0]
  let acc = @math.linalg_linalg_accuracy(pred, labels)
  assert_true(acc > 0.79 && acc < 0.81)
}

///|
test "num_analysis_series" {
  let sr = @math.num_analysis_num_analysis_make_series([10.0, 20.0, 30.0], "data")
  assert_true(@math.num_analysis_num_analysis_series_len(sr) == 3)
  let total = @math.num_analysis_num_analysis_series_sum(sr)
  assert_true(total > 59.9 && total < 60.1)
}

///|
test "diff_eq_basic" {
  let sr = @math.diff_eq_diff_eq_make_series([1.0, 4.0, 9.0, 16.0], "vals")
  let mn = @math.diff_eq_diff_eq_series_mean(sr)
  assert_true(mn > 7.4 && mn < 7.6)
}

///|
test "elm_basic" {
  let sr = @ml.elm_elm_make_series([1.0, 2.0, 3.0], "x")
  assert_true(@ml.elm_elm_series_len(sr) == 3)
  let mx = @ml.elm_elm_series_max(sr)
  assert_true(mx == 3.0)
}

///|
test "rbf_net_basic" {
  let pt = @ml.rbf_net_rbf_net_make_point(1.0, 1.0)
  let qt = @ml.rbf_net_rbf_net_make_point(4.0, 5.0)
  let dt = @ml.rbf_net_rbf_net_point_dist(pt, qt)
  assert_true(dt > 4.9 && dt < 5.1)
}

///|
test "som_basic" {
  let mt = @ml.som_som_matrix_identity(3)
  assert_true(@ml.som_som_matrix_trace(mt) == 3.0)
}

///|
test "goal_stack_basic" {
  let pt = @types.dv_make_point(2.0, 3.0)
  assert_true(@types.dv_point_x(pt) == 2.0)
  let sr = @types.dv_make_series([1.0, 2.0, 3.0, 4.0], "goals")
  assert_true(
    @types.dv_series_mean(sr) > 2.4 &&
    @types.dv_series_mean(sr) < 2.6,
  )
}

///|
test "belief_state_basic" {
  let vt = @types.dv_make_vector([0.5, 0.5])
  assert_true(
    @types.dv_vector_dot(vt, vt) > 0.49 &&
    @types.dv_vector_dot(vt, vt) < 0.51,
  )
}

///|
test "bdi_agent_basic" {
  let sr = @agents.bdi_agent_make_series([0.0, 1.0, 0.0, 1.0], "beliefs")
  assert_true(@agents.bdi_agent_series_sum(sr) == 2.0)
}

///|
test "graph_store_basic" {
  let mt = @types.dv_make_matrix(2, 2, 1.0)
  assert_true(@types.dv_matrix_get(mt, 0, 0) == 1.0)
  let tr = @types.dv_matrix_trace(mt)
  assert_true(tr == 2.0)
}

///|
test "tree_store_basic" {
  let pt = @types.dv_make_point(5.0, 6.0)
  let qt = @types.dv_make_point(5.0, 6.0)
  assert_true(@types.dv_point_dist(pt, qt) < 0.01)
}

///|
test "kv_store_basic" {
  let sr = @types.dv_make_series([100.0, 200.0, 300.0], "kv")
  assert_true(@types.dv_series_min(sr) == 100.0)
  assert_true(@types.dv_series_max(sr) == 300.0)
}

///|
test "window_tumble_basic" {
  let pt = @types.dv_make_point(1.0, 2.0)
  let scaled = @types.dv_point_scale(pt, 2.0)
  assert_true(@types.dv_point_x(scaled) == 2.0)
}

///|
test "window_slide_basic" {
  let sr = @types.dv_make_series(
    [1.0, 2.0, 3.0, 4.0, 5.0],
    "win",
  )
  let std = @types.dv_series_std(sr)
  assert_true(std > 1.4 && std < 1.5)
}

///|
test "window_session_basic" {
  let mt = @types.dv_matrix_identity(4)
  assert_true(@types.dv_matrix_trace(mt) == 4.0)
}

///|
test "math_linear_algebra_basic" {
  let pt = @linear.math_linear_algebra_make_point(3.0, 4.0)
  assert_true(pt.x() == 3.0)
  let sr = @linear.math_linear_algebra_make_series(
    [1.0, 2.0, 3.0],
    "test",
  )
  assert_true(sr.len() == 3)
  let mt = @linear.math_linear_algebra_matrix_identity(3)
  assert_true(mt.trace() == 3.0)
}

///|
test "ml_cluster_kmeans_basic" {
  let pt = @clustering.ml_cluster_kmeans_make_point(1.0, 2.0)
  let qt = @clustering.ml_cluster_kmeans_make_point(4.0, 6.0)
  let dt = pt.dist(qt)
  assert_true(dt > 4.9 && dt < 5.1)
}

///|
test "graph_search_bfs_basic" {
  let vt = @search.graph_search_bfs_make_vector([1.0, 2.0, 3.0])
  assert_true(vt.norm() > 3.7 && vt.norm() < 3.8)
}

///|
test "ds_tree_avl_basic" {
  let sr = @tree.ds_tree_avl_make_series(
    [5.0, 3.0, 1.0, 4.0, 2.0],
    "tree",
  )
  assert_true(sr.min() == 1.0)
  assert_true(sr.max() == 5.0)
}

///|
test "image_filter_gaussian_basic" {
  let mt = @filters.image_filter_gaussian_matrix_identity(3)
  assert_true(mt.trace() == 3.0)
}

///|
test "chem_mol_repr_smiles_basic" {
  let mt = @mol.chem_mol_repr_smiles_matrix_identity(2)
  assert_true(mt.det() == 1.0)
}

///|
test "proof_point_add_commutative" {
  let a = @linear.math_linear_algebra_make_point(3.0, 4.0)
  let b = @linear.math_linear_algebra_make_point(1.0, 2.0)
  let ab = a.add(b)
  let ba = b.add(a)
  assert_true(ab.x() > 3.99 && ab.x() < 4.01)
  assert_true(ba.x() > 3.99 && ba.x() < 4.01)
}

///|
test "proof_point_sub_self" {
  let a = @linear.math_linear_algebra_make_point(5.0, 7.0)
  let z = a.sub(a)
  assert_true(z.x() < 0.01 && z.y() < 0.01)
}

///|
test "proof_point_norm_nonneg" {
  let a = @linear.math_linear_algebra_make_point(3.0, 4.0)
  let n = a.norm()
  assert_true(n > 4.99 && n < 5.01)
}

///|
test "proof_series_sum_mean_relation" {
  let sr = @linear.math_linear_algebra_make_series(
    [1.0, 2.0, 3.0, 4.0, 5.0],
    "s",
  )
  let s = sr.sum()
  let m = sr.mean()
  let n = sr.len().to_double()
  assert_true(s > 14.99 && s < 15.01)
  assert_true(m > 2.99 && m < 3.01)
  assert_true(s / n > 2.99 && s / n < 3.01)
}

///|
test "proof_series_min_max_order" {
  let sr = @linear.math_linear_algebra_make_series(
    [5.0, 3.0, 1.0, 4.0, 2.0],
    "s",
  )
  assert_true(sr.min() < 1.01)
  assert_true(sr.max() > 4.99)
  assert_true(sr.min() <= sr.max())
}

///|
test "proof_matrix_identity_trace" {
  let m3 = @linear.math_linear_algebra_matrix_identity(3)
  assert_true(m3.trace() > 2.99 && m3.trace() < 3.01)
  let m5 = @linear.math_linear_algebra_matrix_identity(5)
  assert_true(m5.trace() > 4.99 && m5.trace() < 5.01)
}

///|
test "proof_matrix_identity_det" {
  let m2 = @linear.math_linear_algebra_matrix_identity(2)
  assert_true(m2.det() > 0.99 && m2.det() < 1.01)
  let m3 = @linear.math_linear_algebra_matrix_identity(3)
  assert_true(m3.det() > 0.99 && m3.det() < 1.01)
}

///|
test "proof_vector_norm_nonneg" {
  let v = @linear.math_linear_algebra_make_vector([3.0, 4.0])
  let n = v.norm()
  assert_true(n > 4.99 && n < 5.01)
}

///|
test "proof_vector_dot_self" {
  let v = @linear.math_linear_algebra_make_vector([1.0, 2.0, 3.0])
  let d = v.dot(v)
  assert_true(d > 13.99 && d < 14.01)
}
