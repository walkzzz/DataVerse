///|
/// # Smoke tests - auto-generated
///
test "serialize_id_smoke" {
  let _ = @serialize.serialize_id()
}
///|
test "validate_non_empty_smoke" {
  let _ = @serialize.validate_non_empty("test", "test")
}
