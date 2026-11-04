///|
/// # core/error 测试 / Error type tests

///|
test "error_construction" {
  let e1 = @error.DataVerseError::InvalidInput("bad param")
  assert_true(@error.error_code(e1) == "E001")
  assert_true(@error.error_detail(e1) == "bad param")

  let e2 = @error.DataVerseError::OutOfRange("index 10 out of 5")
  assert_true(@error.error_code(e2) == "E002")

  let e3 = @error.DataVerseError::DimensionMismatch("expected 3x3 got 2x2")
  assert_true(@error.error_code(e3) == "E003")

  let e4 = @error.DataVerseError::ConvergenceFailure("max iterations reached")
  assert_true(@error.error_code(e4) == "E004")

  let e5 = @error.DataVerseError::NotSupported("sparse matrix not yet supported")
  assert_true(@error.error_code(e5) == "E005")

  let e6 = @error.DataVerseError::Internal("unexpected null")
  assert_true(@error.error_code(e6) == "E999")
}

///|
test "error_message_format" {
  let e = @error.DataVerseError::InvalidInput("bad param")
  assert_true(@error.error_message(e) == "InvalidInput: bad param")
  assert_true(@error.format_error(e) == "E001: InvalidInput: bad param")
}

///|
test "error_recoverable" {
  assert_true(@error.is_recoverable(@error.DataVerseError::InvalidInput("x")))
  assert_true(@error.is_recoverable(@error.DataVerseError::OutOfRange("x")))
  assert_true(@error.is_recoverable(@error.DataVerseError::DimensionMismatch("x")))
  assert_true(@error.is_recoverable(@error.DataVerseError::ConvergenceFailure("x")))
  assert_true(@error.is_recoverable(@error.DataVerseError::NotSupported("x")))
  assert_true(!@error.is_recoverable(@error.DataVerseError::Internal("x")))
}

///|
test "error_helper_constructors" {
  assert_true(@error.error_code(@error.invalid_input("x")) == "E001")
  assert_true(@error.error_code(@error.out_of_range("x")) == "E002")
  assert_true(@error.error_code(@error.dimension_mismatch("x")) == "E003")
  assert_true(@error.error_code(@error.convergence_failure("x")) == "E004")
  assert_true(@error.error_code(@error.not_supported("x")) == "E005")
  assert_true(@error.error_code(@error.internal_error("x")) == "E999")
}

///|
test "error_lift_string_result" {
  let ok : Result[Int, String] = Ok(42)
  let lifted_ok = @error.lift_string_result(ok)
  match lifted_ok {
    Ok(v) => assert_true(v == 42)
    Err(_) => assert_true(false)
  }

  let err : Result[Int, String] = Err("something failed")
  let lifted_err = @error.lift_string_result(err)
  match lifted_err {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E999")
  }
}

///|
test "error_equality" {
  let e1 = @error.DataVerseError::InvalidInput("a")
  let e2 = @error.DataVerseError::InvalidInput("a")
  let e3 = @error.DataVerseError::InvalidInput("b")
  assert_true(e1 == e2)
  assert_true(e1 != e3)
}