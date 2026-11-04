///|
/// # Smoke tests - auto-generated
///
test "annotate_annotate_id_smoke" {
  let _ = @text.annotate_annotate_id()
}
///|
test "clean_clean_id_smoke" {
  let _ = @text.clean_clean_id()
}
///|
test "dedup_dedup_id_smoke" {
  let _ = @text.dedup_dedup_id()
}
///|
test "error_code_error_code_make_labeled_point_smoke" {
  let _ = @types.dv_make_labeled_point(1.0, 1.0, 1)
}
///|
test "error_code_error_code_make_matrix_smoke" {
  let _ = @types.dv_make_matrix(1, 1, 1.0)
}
///|
test "error_code_error_code_make_point_smoke" {
  let _ = @types.dv_make_point(1.0, 1.0)
}
///|
test "error_code_error_code_make_series_smoke" {
  let _ = @types.dv_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "error_code_error_code_make_vector_smoke" {
  let _ = @types.dv_make_vector([1.0, 2.0, 3.0])
}
///|
test "error_code_error_code_matrix_identity_smoke" {
  let _ = @types.dv_matrix_identity(1)
}
///|
test "error_code_error_code_vector_zero_smoke" {
  let _ = @types.dv_vector_zero(1)
}
