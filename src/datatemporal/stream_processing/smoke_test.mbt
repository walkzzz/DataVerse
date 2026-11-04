///|
/// # Smoke tests - auto-generated
///
test "make_exactly_once_sp_smoke" {
  let _ = @stream_processing.make_exactly_once_sp()
}
///|
test "make_schema_registry_smoke" {
  let _ = @stream_processing.make_schema_registry()
}
///|
test "make_stateful_op_smoke" {
  let _ = @stream_processing.make_stateful_op()
}
///|
test "make_stream_dag_smoke" {
  let _ = @stream_processing.make_stream_dag()
}
///|
test "stream_processing_id_smoke" {
  let _ = @stream_processing.stream_processing_id()
}
