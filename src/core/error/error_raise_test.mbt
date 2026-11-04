///|
/// # core/error 错误处理机制测试 / Error handling mechanism tests
/// 测试 suberror + raise + try/catch + 错误多态高阶函数

// ============================================================================
// suberror 构造函数测试 / Suberror Constructor Tests
// ============================================================================

///|
test "make_input_error_constructs" {
  let _e = @error.make_input_error("bad input")
  assert_true(true)
}

///|
test "make_range_error_constructs" {
  let _e = @error.make_range_error("oob")
  assert_true(true)
}

///|
test "make_dim_error_constructs" {
  let _e = @error.make_dim_error("dim mismatch")
  assert_true(true)
}

///|
test "make_convergence_error_constructs" {
  let _e = @error.make_convergence_error("no converge")
  assert_true(true)
}

///|
test "make_support_error_constructs" {
  let _e = @error.make_support_error("not supported")
  assert_true(true)
}

// ============================================================================
// raise 核心操作 — 成功路径 / Raise Operations — Success Paths
// ============================================================================

///|
test "raise_div_normal" {
  let result = @error.raise_div(10.0, 2.0)
  assert_true(result == 5.0)
}

///|
test "raise_int_div_normal" {
  let result = @error.raise_int_div(17, 5)
  assert_true(result == 3)
}

///|
test "raise_mod_normal" {
  let result = @error.raise_mod(17, 5)
  assert_true(result == 2)
}

///|
test "raise_sqrt_normal" {
  let result = @error.raise_sqrt(9.0)
  assert_true(result == 3.0)
}

///|
test "raise_sqrt_zero" {
  let result = @error.raise_sqrt(0.0)
  assert_true(result == 0.0)
}

///|
test "raise_log_normal" {
  let result = @error.raise_log(1.0)
  assert_true(result == 0.0)
}

///|
test "raise_arr_get_normal" {
  let arr = [10, 20, 30]
  let result = @error.raise_arr_get(arr, 1)
  assert_true(result == 20)
}

///|
test "raise_arr_head_normal" {
  let arr = [10, 20, 30]
  let result = @error.raise_arr_head(arr)
  assert_true(result == 10)
}

///|
test "raise_arr_tail_normal" {
  let arr = [10, 20, 30]
  let result = @error.raise_arr_tail(arr)
  assert_true(result == 30)
}

// ============================================================================
// raise 核心操作 — 错误路径 / Raise Operations — Error Paths
// ============================================================================

///|
test "raise_div_zero_catch" {
  let result = try Some(@error.raise_div(1.0, 0.0)) catch {
    _ => None
  }
  assert_true(result == None)
}

///|
test "raise_int_div_zero_catch" {
  let result = try Some(@error.raise_int_div(1, 0)) catch {
    _ => None
  }
  assert_true(result == None)
}

///|
test "raise_mod_zero_catch" {
  let result = try Some(@error.raise_mod(5, 0)) catch {
    _ => None
  }
  assert_true(result == None)
}

///|
test "raise_sqrt_negative_catch" {
  let result = try Some(@error.raise_sqrt(-1.0)) catch {
    _ => None
  }
  assert_true(result == None)
}

///|
test "raise_log_non_positive_catch" {
  let result = try Some(@error.raise_log(0.0)) catch {
    _ => None
  }
  assert_true(result == None)
}

///|
test "raise_arr_get_out_of_bounds_catch" {
  let arr = [1, 2, 3]
  let result = try Some(@error.raise_arr_get(arr, 10)) catch {
    _ => None
  }
  assert_true(result == None)
}

///|
test "raise_arr_head_empty_catch" {
  let empty : Array[Int] = []
  let result = try Some(@error.raise_arr_head(empty)) catch {
    _ => None
  }
  assert_true(result == None)
}

///|
test "raise_arr_tail_empty_catch" {
  let empty : Array[Int] = []
  let result = try Some(@error.raise_arr_tail(empty)) catch {
    _ => None
  }
  assert_true(result == None)
}

// ============================================================================
// Result ↔ raise 转换测试 / Result ↔ raise Conversion Tests
// ============================================================================

///|
test "to_result_success" {
  let r = @error.to_result(() => @error.raise_div(10.0, 2.0))
  match r {
    Ok(v) => assert_true(v == 5.0)
    Err(_) => assert_true(false)
  }
}

///|
test "to_result_div_zero_error" {
  let r = @error.to_result(() => @error.raise_div(1.0, 0.0))
  match r {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "to_result_input_success" {
  let r = @error.to_result_input(() => @error.raise_arr_head([1, 2, 3]))
  match r {
    Ok(v) => assert_true(v == 1)
    Err(_) => assert_true(false)
  }
}

///|
test "to_result_input_empty_error" {
  let empty : Array[Int] = []
  let r = @error.to_result_input(() => @error.raise_arr_head(empty))
  match r {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "to_result_dim_success" {
  let r = @error.to_result_dim(() => 42)
  match r {
    Ok(v) => assert_true(v == 42)
    Err(_) => assert_true(false)
  }
}

///|
test "to_result_conv_success" {
  let r = @error.to_result_conv(() => 100)
  match r {
    Ok(v) => assert_true(v == 100)
    Err(_) => assert_true(false)
  }
}

///|
test "to_result_support_success" {
  let r = @error.to_result_support(() => 200)
  match r {
    Ok(v) => assert_true(v == 200)
    Err(_) => assert_true(false)
  }
}

///|
test "err_result_always_error" {
  let r : Result[Int, @error.DataVerseError] = @error.err_result("fail")
  match r {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

// ============================================================================
// 错误多态高阶函数测试 / Error-Polymorphic HOF Tests
// ============================================================================

///|
test "map_raise_normal" {
  let arr = [1, 2, 3]
  let result = @error.map_raise(arr, (x) => x * 2)
  assert_true(result == [2, 4, 6])
}

///|
test "map_raise_empty" {
  let empty : Array[Int] = []
  let result = @error.map_raise(empty, (x) => x * 2)
  assert_true(result.length() == 0)
}

///|
test "filter_raise_normal" {
  let arr = [1, 2, 3, 4, 5, 6]
  let result = @error.filter_raise(arr, (x) => x % 2 == 0)
  assert_true(result == [2, 4, 6])
}

///|
test "filter_raise_empty" {
  let empty : Array[Int] = []
  let result = @error.filter_raise(empty, (x) => x > 0)
  assert_true(result.length() == 0)
}

///|
test "fold_raise_sum" {
  let arr = [1, 2, 3, 4, 5]
  let result = @error.fold_raise(arr, 0, (acc, x) => acc + x)
  assert_true(result == 15)
}

///|
test "fold_raise_product" {
  let arr = [1, 2, 3, 4]
  let result = @error.fold_raise(arr, 1, (acc, x) => acc * x)
  assert_true(result == 24)
}

///|
test "fold_raise_empty" {
  let empty : Array[Int] = []
  let result = @error.fold_raise(empty, 42, (acc, x) => acc + x)
  assert_true(result == 42)
}

///|
test "for_each_raise_side_effect" {
  let arr = [1, 2, 3]
  let acc = []
  @error.for_each_raise(arr, (x) => acc.push(x))
  assert_true(acc == [1, 2, 3])
}

// ============================================================================
// try/catch 工具函数测试 / try/catch Utility Tests
// ============================================================================

///|
test "catch_range_default_success" {
  let result = @error.catch_range_default(() => @error.raise_div(10.0, 2.0), -1.0)
  assert_true(result == 5.0)
}

///|
test "catch_range_default_error" {
  let result = @error.catch_range_default(() => @error.raise_div(1.0, 0.0), -1.0)
  assert_true(result == -1.0)
}

///|
test "catch_input_default_success" {
  let result = @error.catch_input_default(() => @error.raise_arr_head([1, 2]), 0)
  assert_true(result == 1)
}

///|
test "catch_input_default_error" {
  let empty : Array[Int] = []
  let result = @error.catch_input_default(() => @error.raise_arr_head(empty), 0)
  assert_true(result == 0)
}

///|
test "catch_range_log_success" {
  let result = @error.catch_range_log(() => @error.raise_sqrt(16.0), (_msg) => ())
  match result {
    Some(v) => assert_true(v == 4.0)
    None => assert_true(false)
  }
}

///|
test "catch_range_log_error" {
  let acc = []
  let result = @error.catch_range_log(() => @error.raise_sqrt(-1.0), (msg) => acc.push(msg))
  match result {
    Some(_) => assert_true(false)
    None => assert_true(acc.length() == 1)
  }
}

// ============================================================================
// Result 工具函数测试 / Result Utility Tests
// ============================================================================

///|
test "and_then_success" {
  let r1 : Result[Int, @error.DataVerseError] = Ok(5)
  let r2 = @error.and_then(r1, (x) => Ok(x * 2))
  match r2 {
    Ok(v) => assert_true(v == 10)
    Err(_) => assert_true(false)
  }
}

///|
test "and_then_error" {
  let r1 : Result[Int, @error.DataVerseError] = @error.err_result("fail")
  let r2 = @error.and_then(r1, (x) => Ok(x * 2))
  match r2 {
    Ok(_) => assert_true(false)
    Err(_) => assert_true(true)
  }
}

///|
test "map_ok_success" {
  let r : Result[Int, @error.DataVerseError] = Ok(5)
  let r2 = @error.map_ok(r, (x) => x + 10)
  match r2 {
    Ok(v) => assert_true(v == 15)
    Err(_) => assert_true(false)
  }
}

///|
test "map_ok_error" {
  let r : Result[Int, @error.DataVerseError] = @error.err_result("e")
  let r2 = @error.map_ok(r, (x) => x + 10)
  match r2 {
    Ok(_) => assert_true(false)
    Err(_) => assert_true(true)
  }
}

///|
test "recover_from_error" {
  let r : Result[Int, @error.DataVerseError] = @error.err_result("recovered")
  let result = @error.recover(r, (_e) => 999)
  assert_true(result == 999)
}

///|
test "recover_from_ok" {
  let r : Result[Int, @error.DataVerseError] = Ok(42)
  let result = @error.recover(r, (_e) => 999)
  assert_true(result == 42)
}

///|
test "combine_both_ok" {
  let r1 : Result[Int, @error.DataVerseError] = Ok(1)
  let r2 : Result[String, @error.DataVerseError] = Ok("hello")
  let r = @error.combine(r1, r2)
  match r {
    Ok((a, b)) => {
      assert_true(a == 1)
      assert_true(b == "hello")
    }
    Err(_) => assert_true(false)
  }
}

///|
test "combine_first_error" {
  let r1 : Result[Int, @error.DataVerseError] = @error.err_result("e1")
  let r2 : Result[String, @error.DataVerseError] = Ok("hello")
  let r = @error.combine(r1, r2)
  match r {
    Ok(_) => assert_true(false)
    Err(_) => assert_true(true)
  }
}

///|
test "combine_second_error" {
  let r1 : Result[Int, @error.DataVerseError] = Ok(1)
  let r2 : Result[String, @error.DataVerseError] = @error.err_result("e2")
  let r = @error.combine(r1, r2)
  match r {
    Ok(_) => assert_true(false)
    Err(_) => assert_true(true)
  }
}

///|
test "collect_all_all_ok" {
  let arr : Array[Result[Int, @error.DataVerseError]] = [Ok(1), Ok(2), Ok(3)]
  let r = @error.collect_all(arr)
  match r {
    Ok(v) => assert_true(v == [1, 2, 3])
    Err(_) => assert_true(false)
  }
}

///|
test "collect_all_with_error" {
  let arr : Array[Result[Int, @error.DataVerseError]] = [
    Ok(1), @error.err_result("fail"), Ok(3),
  ]
  let r = @error.collect_all(arr)
  match r {
    Ok(_) => assert_true(false)
    Err(_) => assert_true(true)
  }
}

///|
test "collect_all_empty" {
  let empty : Array[Result[Int, @error.DataVerseError]] = []
  let r = @error.collect_all(empty)
  match r {
    Ok(v) => assert_true(v.length() == 0)
    Err(_) => assert_true(false)
  }
}