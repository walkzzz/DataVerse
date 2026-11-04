///|
/// # Smoke tests - auto-generated
///
test "file_source_smoke" {
  let _ = @io.file_source("test", "test")
}
///|
test "in_memory_source_smoke" {
  let _ = @io.in_memory_source("test")
}
///|
test "object_storage_source_smoke" {
  let _ = @io.object_storage_source("test", "test", "test", "test")
}
