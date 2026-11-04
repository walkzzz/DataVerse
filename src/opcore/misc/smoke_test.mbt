///|
/// # Smoke tests - auto-generated
///
test "analysis3d_analysis3d_id_smoke" {
  let _ = @misc.analysis3d_analysis3d_id()
}
///|
test "analysis3d_make_bbox3d_smoke" {
  let _ = @misc.analysis3d_make_bbox3d(1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
}
///|
test "analysis3d_make_point3d_smoke" {
  let _ = @misc.analysis3d_make_point3d(1.0, 1.0, 1.0)
}
///|
test "feature_store_feature_store_id_smoke" {
  let _ = @misc.feature_store_feature_store_id()
}
///|
test "feature_store_make_embedding_store_smoke" {
  let _ = @misc.feature_store_make_embedding_store(1)
}
///|
test "feature_store_make_feature_group_smoke" {
  let _ = @misc.feature_store_make_feature_group("test", "test")
}
///|
test "feature_store_make_feature_index_smoke" {
  let _ = @misc.feature_store_make_feature_index("test")
}
///|
test "feature_store_make_feature_monitor_smoke" {
  let _ = @misc.feature_store_make_feature_monitor("test", 1.0, 1.0)
}
///|
test "feature_store_make_feature_pipeline_smoke" {
  let _ = @misc.feature_store_make_feature_pipeline("test", "test")
}
///|
test "feature_store_make_feature_store_smoke" {
  let _ = @misc.feature_store_make_feature_store()
}
