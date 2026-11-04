///|
/// # Smoke tests - auto-generated
///
test "index_btree_make_labeled_point_smoke" {
  let _ = @index_btree.index_btree_make_labeled_point(1.0, 1.0, 1)
}
///|
test "index_btree_make_matrix_smoke" {
  let _ = @index_btree.index_btree_make_matrix(1, 1, 1.0)
}
///|
test "index_btree_make_point_smoke" {
  let _ = @index_btree.index_btree_make_point(1.0, 1.0)
}
///|
test "index_btree_make_series_smoke" {
  let _ = @index_btree.index_btree_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "index_btree_make_vector_smoke" {
  let _ = @index_btree.index_btree_make_vector([1.0, 2.0, 3.0])
}
///|
test "index_btree_matrix_identity_smoke" {
  let _ = @index_btree.index_btree_matrix_identity(1)
}
///|
test "index_btree_vector_zero_smoke" {
  let _ = @index_btree.index_btree_vector_zero(1)
}
