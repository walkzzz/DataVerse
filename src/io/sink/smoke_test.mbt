///|
/// # Smoke tests - auto-generated
///
test "file_sink_smoke" {
  let _ = @sink.file_sink("test", "test")
}
///|
test "in_memory_sink_smoke" {
  let _ = @sink.in_memory_sink("test")
}
///|
test "object_storage_sink_smoke" {
  let _ = @sink.object_storage_sink("test", "test", "test", "test")
}
