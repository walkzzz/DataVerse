///|
/// # Smoke tests - auto-generated
///
test "data_catalog_id_smoke" {
  let _ = @data_catalog.data_catalog_id()
}
///|
test "make_data_access_smoke" {
  let _ = @data_catalog.make_data_access()
}
///|
test "make_data_lineage_catalog_smoke" {
  let _ = @data_catalog.make_data_lineage_catalog()
}
///|
test "make_data_quality_catalog_smoke" {
  let _ = @data_catalog.make_data_quality_catalog()
}
///|
test "make_data_usage_smoke" {
  let _ = @data_catalog.make_data_usage()
}
