///|
/// # Smoke tests - auto-generated
///
test "file_sink_smoke" {
  let _ = @io.file_sink("test", "test")
}
///|
test "in_memory_sink_smoke" {
  let _ = @io.in_memory_sink("test")
}
///|
test "object_storage_sink_smoke" {
  let _ = @io.object_storage_sink("test", "test", "test", "test")
}
