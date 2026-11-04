///|
/// # Smoke tests - auto-generated
///
test "art_model_art_model_make_labeled_point_smoke" {
  let _ = @fuzzy.art_model_art_model_make_labeled_point(1.0, 1.0, 1)
}
///|
test "art_model_art_model_make_matrix_smoke" {
  let _ = @fuzzy.art_model_art_model_make_matrix(1, 1, 1.0)
}
///|
test "art_model_art_model_make_point_smoke" {
  let _ = @fuzzy.art_model_art_model_make_point(1.0, 1.0)
}
///|
test "art_model_art_model_make_series_smoke" {
  let _ = @fuzzy.art_model_art_model_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "art_model_art_model_make_vector_smoke" {
  let _ = @fuzzy.art_model_art_model_make_vector([1.0, 2.0, 3.0])
}
///|
test "art_model_art_model_matrix_identity_smoke" {
  let _ = @fuzzy.art_model_art_model_matrix_identity(1)
}
///|
test "art_model_art_model_vector_zero_smoke" {
  let _ = @fuzzy.art_model_art_model_vector_zero(1)
}
///|
test "artmap_artmap_make_labeled_point_smoke" {
  let _ = @fuzzy.artmap_artmap_make_labeled_point(1.0, 1.0, 1)
}
///|
test "artmap_artmap_make_matrix_smoke" {
  let _ = @fuzzy.artmap_artmap_make_matrix(1, 1, 1.0)
}
///|
test "artmap_artmap_make_point_smoke" {
  let _ = @fuzzy.artmap_artmap_make_point(1.0, 1.0)
}
