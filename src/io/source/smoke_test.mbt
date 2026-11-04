///|
/// # Smoke tests - auto-generated
///
test "file_source_smoke" {
  let _ = @source.file_source("test", "test")
}
///|
test "in_memory_source_smoke" {
  let _ = @source.in_memory_source("test")
}
///|
test "object_storage_source_smoke" {
  let _ = @source.object_storage_source("test", "test", "test", "test")
}
