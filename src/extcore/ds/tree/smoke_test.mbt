///|
/// # Smoke tests - auto-generated
///
test "ds_tree_avl_make_matrix_smoke" {
  let _ = @tree.ds_tree_avl_make_matrix(1, 1, 1.0)
}
///|
test "ds_tree_avl_make_point_smoke" {
  let _ = @tree.ds_tree_avl_make_point(1.0, 1.0)
}
///|
test "ds_tree_avl_make_point3_smoke" {
  let _ = @tree.ds_tree_avl_make_point3(1.0, 1.0, 1.0)
}
///|
test "ds_tree_avl_make_series_smoke" {
  let _ = @tree.ds_tree_avl_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "ds_tree_avl_make_vector_smoke" {
  let _ = @tree.ds_tree_avl_make_vector([1.0, 2.0, 3.0])
}
///|
test "ds_tree_avl_matrix_identity_smoke" {
  let _ = @tree.ds_tree_avl_matrix_identity(1)
}
///|
test "ds_tree_avl_vector_zero_smoke" {
  let _ = @tree.ds_tree_avl_vector_zero(1)
}
///|
test "ds_tree_binary_make_matrix_smoke" {
  let _ = @tree.ds_tree_binary_make_matrix(1, 1, 1.0)
}
///|
test "ds_tree_binary_make_point_smoke" {
  let _ = @tree.ds_tree_binary_make_point(1.0, 1.0)
}
///|
test "ds_tree_binary_make_point3_smoke" {
  let _ = @tree.ds_tree_binary_make_point3(1.0, 1.0, 1.0)
}
