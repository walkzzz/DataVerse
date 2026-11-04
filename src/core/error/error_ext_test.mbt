///|
/// # core/error 扩展测试 / Extended error tests

///|
test "error_code_invalid_input" {
  let e = @error.invalid_input("test")
  assert_true(@error.error_code(e) == "E001")
}

///|
test "error_code_out_of_range" {
  let e = @error.out_of_range("test")
  assert_true(@error.error_code(e) == "E002")
}

///|
test "error_code_dimension_mismatch" {
  let e = @error.dimension_mismatch("test")
  assert_true(@error.error_code(e) == "E003")
}

///|
test "error_code_convergence_failure" {
  let e = @error.convergence_failure("test")
  assert_true(@error.error_code(e) == "E004")
}

///|
test "error_code_not_supported" {
  let e = @error.not_supported("test")
  assert_true(@error.error_code(e) == "E005")
}

///|
test "error_code_internal" {
  let e = @error.internal_error("test")
  assert_true(@error.error_code(e) == "E999")
}

///|
test "error_message_invalid_input" {
  let e = @error.invalid_input("bad")
  assert_true(@error.error_message(e) == "InvalidInput: bad")
}

///|
test "error_message_out_of_range" {
  let e = @error.out_of_range("oob")
  assert_true(@error.error_message(e) == "OutOfRange: oob")
}

///|
test "error_message_dimension_mismatch" {
  let e = @error.dimension_mismatch("dm")
  assert_true(@error.error_message(e) == "DimensionMismatch: dm")
}

///|
test "error_message_convergence_failure" {
  let e = @error.convergence_failure("cf")
  assert_true(@error.error_message(e) == "ConvergenceFailure: cf")
}

///|
test "error_message_not_supported" {
  let e = @error.not_supported("ns")
  assert_true(@error.error_message(e) == "NotSupported: ns")
}

///|
test "error_message_internal" {
  let e = @error.internal_error("ie")
  assert_true(@error.error_message(e) == "Internal: ie")
}

///|
test "error_detail_invalid_input" {
  let e = @error.invalid_input("detail1")
  assert_true(@error.error_detail(e) == "detail1")
}

///|
test "error_detail_out_of_range" {
  let e = @error.out_of_range("detail2")
  assert_true(@error.error_detail(e) == "detail2")
}

///|
test "error_detail_dimension_mismatch" {
  let e = @error.dimension_mismatch("detail3")
  assert_true(@error.error_detail(e) == "detail3")
}

///|
test "format_error_all_types" {
  assert_true(@error.format_error(@error.invalid_input("a")) == "E001: InvalidInput: a")
  assert_true(@error.format_error(@error.out_of_range("b")) == "E002: OutOfRange: b")
  assert_true(@error.format_error(@error.dimension_mismatch("c")) == "E003: DimensionMismatch: c")
  assert_true(@error.format_error(@error.convergence_failure("d")) == "E004: ConvergenceFailure: d")
  assert_true(@error.format_error(@error.not_supported("e")) == "E005: NotSupported: e")
  assert_true(@error.format_error(@error.internal_error("f")) == "E999: Internal: f")
}

///|
test "is_recoverable_invalid_input" {
  assert_true(@error.is_recoverable(@error.invalid_input("x")))
}

///|
test "is_recoverable_out_of_range" {
  assert_true(@error.is_recoverable(@error.out_of_range("x")))
}

///|
test "is_recoverable_dimension_mismatch" {
  assert_true(@error.is_recoverable(@error.dimension_mismatch("x")))
}

///|
test "is_recoverable_convergence_failure" {
  assert_true(@error.is_recoverable(@error.convergence_failure("x")))
}

///|
test "is_recoverable_not_supported" {
  assert_true(@error.is_recoverable(@error.not_supported("x")))
}

///|
test "is_recoverable_internal" {
  assert_true(@error.is_recoverable(@error.internal_error("x")) == false)
}

///|
test "error_construction_direct" {
  let e1 = @error.DataVerseError::InvalidInput("d1")
  assert_true(@error.error_code(e1) == "E001")
  let e2 = @error.DataVerseError::OutOfRange("d2")
  assert_true(@error.error_code(e2) == "E002")
  let e3 = @error.DataVerseError::DimensionMismatch("d3")
  assert_true(@error.error_code(e3) == "E003")
}

///|
test "error_helper_chain" {
  let e = @error.invalid_input("chain test")
  let code = @error.error_code(e)
  let msg = @error.error_message(e)
  let detail = @error.error_detail(e)
  let formatted = @error.format_error(e)
  let recoverable = @error.is_recoverable(e)
  assert_true(code == "E001")
  assert_true(msg == "InvalidInput: chain test")
  assert_true(detail == "chain test")
  assert_true(formatted == "E001: InvalidInput: chain test")
  assert_true(recoverable)
}

///|
test "error_helper_chain_internal" {
  let e = @error.internal_error("internal chain")
  let code = @error.error_code(e)
  let msg = @error.error_message(e)
  let detail = @error.error_detail(e)
  let formatted = @error.format_error(e)
  let recoverable = @error.is_recoverable(e)
  assert_true(code == "E999")
  assert_true(msg == "Internal: internal chain")
  assert_true(detail == "internal chain")
  assert_true(formatted == "E999: Internal: internal chain")
  assert_true(recoverable == false)
}

///|
test "error_empty_message" {
  let e = @error.invalid_input("")
  assert_true(@error.error_detail(e) == "")
  assert_true(@error.error_message(e) == "InvalidInput: ")
}

///|
test "error_long_message" {
  let msg = "This is a very long error message for testing purposes"
  let e = @error.out_of_range(msg)
  assert_true(@error.error_detail(e) == msg)
}

///|
test "error_special_chars" {
  let e = @error.invalid_input("error with [special] chars {test}")
  assert_true(@error.error_detail(e) == "error with [special] chars {test}")
}

///|
test "error_all_recoverable" {
  assert_true(@error.is_recoverable(@error.invalid_input("a")))
  assert_true(@error.is_recoverable(@error.out_of_range("b")))
  assert_true(@error.is_recoverable(@error.dimension_mismatch("c")))
  assert_true(@error.is_recoverable(@error.convergence_failure("d")))
  assert_true(@error.is_recoverable(@error.not_supported("e")))
}

///|
test "error_none_recoverable_internal" {
  assert_true(@error.is_recoverable(@error.internal_error("f")) == false)
  assert_true(@error.is_recoverable(@error.internal_error("")) == false)
}