///|
/// # Smoke tests - auto-generated
///
test "intention_plan_make_labeled_point_smoke" {
  let _ = @intention_plan.intention_plan_make_labeled_point(1.0, 1.0, 1)
}
///|
test "intention_plan_make_matrix_smoke" {
  let _ = @intention_plan.intention_plan_make_matrix(1, 1, 1.0)
}
///|
test "intention_plan_make_point_smoke" {
  let _ = @intention_plan.intention_plan_make_point(1.0, 1.0)
}
///|
test "intention_plan_make_series_smoke" {
  let _ = @intention_plan.intention_plan_make_series([1.0, 2.0, 3.0], "test")
}
///|
test "intention_plan_make_vector_smoke" {
  let _ = @intention_plan.intention_plan_make_vector([1.0, 2.0, 3.0])
}
///|
test "intention_plan_matrix_identity_smoke" {
  let _ = @intention_plan.intention_plan_matrix_identity(1)
}
///|
test "intention_plan_vector_zero_smoke" {
  let _ = @intention_plan.intention_plan_vector_zero(1)
}
