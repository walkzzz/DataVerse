///|
/// # Smoke tests - auto-generated
///
test "active_learning_active_learning_id_smoke" {
  let _ = @ssl.active_learning_active_learning_id()
}
///|
test "active_learning_make_al_config_smoke" {
  let _ = @ssl.active_learning_make_al_config(1, 1, 1, 1)
}
///|
test "active_learning_make_annotation_cost_smoke" {
  let _ = @ssl.active_learning_make_annotation_cost(1.0, 1.0)
}
///|
test "active_learning_make_emc_smoke" {
  let _ = @ssl.active_learning_make_emc(1, 1, 1.0)
}
///|
test "active_learning_make_labeled_pool_smoke" {
  let _ = @ssl.active_learning_make_labeled_pool()
}
///|
test "active_learning_make_oracle_smoke" {
  let _ = @ssl.active_learning_make_oracle(1.0, 1.0, 1.0)
}
///|
test "active_learning_make_query_strategy_smoke" {
  let _ = @ssl.active_learning_make_query_strategy(1, 1.0, 1)
}
///|
test "active_learning_make_stop_criterion_smoke" {
  let _ = @ssl.active_learning_make_stop_criterion(1.0, 1, 1)
}
///|
test "curriculum_curriculum_id_smoke" {
  let _ = @ssl.curriculum_curriculum_id()
}
///|
test "curriculum_make_anti_curriculum_smoke" {
  let _ = @ssl.curriculum_make_anti_curriculum(true, "test", 1)
}
