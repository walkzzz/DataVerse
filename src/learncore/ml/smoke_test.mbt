///|
/// # Smoke tests - auto-generated
///
test "automl_automl_id_smoke" {
  let _ = @ml.automl_automl_id()
}
///|
test "automl_make_automl_config_smoke" {
  let _ = @ml.automl_make_automl_config(1.0, 1, 1, "test", "test", 1, 1, 1, true)
}
///|
test "automl_make_data_aware_smoke" {
  let _ = @ml.automl_make_data_aware(1, 1, 1, ["a", "b"], 1.0, 1.0)
}
///|
test "automl_make_interpretable_smoke" {
  let _ = @ml.automl_make_interpretable(1.0, 1.0, 1.0)
}
///|
test "automl_make_meta_learner_smoke" {
  let _ = @ml.automl_make_meta_learner()
}
///|
test "automl_make_model_search_space_smoke" {
  let _ = @ml.automl_make_model_search_space(["a", "b"], ["a", "b"], ["a", "b"], ["a", "b"], ["a", "b"])
}
///|
test "automl_make_neural_search_smoke" {
  let _ = @ml.automl_make_neural_search(1, 1, 1)
}
///|
test "automl_make_progressive_search_smoke" {
  let _ = @ml.automl_make_progressive_search(1, 1, 1.0)
}
///|
test "automl_make_resource_aware_smoke" {
  let _ = @ml.automl_make_resource_aware(1, 1, 1, 1.0)
}
///|
test "automl_make_time_aware_smoke" {
  let _ = @ml.automl_make_time_aware(1.0, 1.0)
}
