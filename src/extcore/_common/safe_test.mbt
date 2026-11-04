///|
/// # extcore/_common/safe 测试 / Safe API tests

///|
test "safe_mean" {
  let ok = @_common.safe_mean([1.0, 2.0, 3.0])
  match ok {
    Ok(v) => assert_true(v > 1.99 && v < 2.01)
    Err(_) => assert_true(false)
  }

  let err = @_common.safe_mean([])
  match err {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_std" {
  let ok = @_common.safe_std([1.0, 2.0, 3.0, 4.0, 5.0])
  match ok {
    Ok(v) => assert_true(v > 1.40 && v < 1.42)
    Err(_) => assert_true(false)
  }

  match @_common.safe_std([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_sqrt" {
  match @_common.safe_sqrt(4.0) {
    Ok(v) => assert_true(v > 1.99 && v < 2.01)
    Err(_) => assert_true(false)
  }

  match @_common.safe_sqrt(-1.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_log" {
  match @_common.safe_log(1.0) {
    Ok(v) => assert_true(@_common.abs(v) < 0.001)
    Err(_) => assert_true(false)
  }

  match @_common.safe_log(0.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }

  match @_common.safe_log(-1.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_factorial" {
  match @_common.safe_factorial(5) {
    Ok(v) => assert_true(v > 119.99 && v < 120.01)
    Err(_) => assert_true(false)
  }

  match @_common.safe_factorial(-1) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }

  match @_common.safe_factorial(25) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_div" {
  match @_common.safe_div(10.0, 2.0) {
    Ok(v) => assert_true(v > 4.99 && v < 5.01)
    Err(_) => assert_true(false)
  }

  match @_common.safe_div(1.0, 0.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_index" {
  let arr = [10.0, 20.0, 30.0]
  match @_common.safe_index(arr, 1) {
    Ok(v) => assert_true(v > 19.99 && v < 20.01)
    Err(_) => assert_true(false)
  }

  match @_common.safe_index(arr, 5) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }

  match @_common.safe_index(arr, -1) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_min_max" {
  let arr = [3.0, 1.0, 4.0, 1.0, 5.0]
  match @_common.safe_min(arr) {
    Ok(v) => assert_true(v > 0.99 && v < 1.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_max(arr) {
    Ok(v) => assert_true(v > 4.99 && v < 5.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_min([]) {
    Ok(_) => assert_true(false)
    Err(_) => assert_true(true)
  }
}

///|
test "safe_normalize" {
  match @_common.safe_normalize([1.0, 2.0, 3.0]) {
    Ok(arr) => assert_true(arr.length() == 3)
    Err(_) => assert_true(false)
  }
  match @_common.safe_normalize([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}