///|
/// # extcore/_common/safe_ext 测试 / Extended safe API tests

///|
test "safe_sum" {
  match @_common.safe_sum([1.0, 2.0, 3.0]) {
    Ok(v) => assert_true(v > 5.99 && v < 6.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_sum([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_cov" {
  match @_common.safe_cov([1.0, 2.0, 3.0], [4.0, 5.0, 6.0]) {
    Ok(_) => assert_true(true)
    Err(_) => assert_true(false)
  }
  match @_common.safe_cov([], []) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
  match @_common.safe_cov([1.0], [1.0, 2.0]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}

///|
test "safe_corr" {
  match @_common.safe_corr([1.0, 2.0, 3.0], [1.0, 2.0, 3.0]) {
    Ok(v) => assert_true(v > 0.99)
    Err(_) => assert_true(false)
  }
  match @_common.safe_corr([1.0], [1.0, 2.0]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}

///|
test "safe_accuracy" {
  match @_common.safe_accuracy([1, 0, 1], [1, 0, 1]) {
    Ok(v) => assert_true(v > 0.99)
    Err(_) => assert_true(false)
  }
  match @_common.safe_accuracy([], []) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_mse" {
  match @_common.safe_mse([1.0, 2.0], [1.0, 2.0]) {
    Ok(v) => assert_true(v < 0.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_mse([1.0], [1.0, 2.0]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}

///|
test "safe_rmse" {
  match @_common.safe_rmse([1.0, 2.0], [1.0, 2.0]) {
    Ok(v) => assert_true(v < 0.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_rmse([], []) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_mae" {
  match @_common.safe_mae([1.0, 2.0], [1.0, 2.0]) {
    Ok(v) => assert_true(v < 0.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_mae([1.0], [1.0, 2.0]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}

///|
test "safe_r2" {
  match @_common.safe_r2([1.0, 2.0, 3.0], [1.0, 2.0, 3.0]) {
    Ok(v) => assert_true(v > 0.99)
    Err(_) => assert_true(false)
  }
  match @_common.safe_r2([], []) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_precision" {
  match @_common.safe_precision([1, 0, 1], [1, 0, 1], 1) {
    Ok(_) => assert_true(true)
    Err(_) => assert_true(false)
  }
  match @_common.safe_precision([], [], 1) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_recall" {
  match @_common.safe_recall([1, 0, 1], [1, 0, 1], 1) {
    Ok(_) => assert_true(true)
    Err(_) => assert_true(false)
  }
  match @_common.safe_recall([1], [1, 0], 1) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}

///|
test "safe_f1" {
  match @_common.safe_f1([1, 0, 1], [1, 0, 1], 1) {
    Ok(_) => assert_true(true)
    Err(_) => assert_true(false)
  }
  match @_common.safe_f1([], [], 1) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_log10" {
  match @_common.safe_log10(100.0) {
    Ok(v) => assert_true(v > 1.99 && v < 2.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_log10(0.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_pow" {
  match @_common.safe_pow(2.0, 3.0) {
    Ok(v) => assert_true(v > 7.99 && v < 8.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_pow(0.0, -1.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_tan" {
  match @_common.safe_tan(0.0) {
    Ok(v) => assert_true(@_common.abs(v) < 0.01)
    Err(_) => assert_true(false)
  }
}

///|
test "safe_atan2" {
  match @_common.safe_atan2(1.0, 1.0) {
    Ok(_) => assert_true(true)
    Err(_) => assert_true(false)
  }
  match @_common.safe_atan2(0.0, 0.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_gcd" {
  match @_common.safe_gcd(12, 8) {
    Ok(v) => assert_true(v == 4)
    Err(_) => assert_true(false)
  }
  match @_common.safe_gcd(0, 0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_lcm" {
  match @_common.safe_lcm(4, 6) {
    Ok(v) => assert_true(v == 12)
    Err(_) => assert_true(false)
  }
  match @_common.safe_lcm(0, 5) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_fibonacci" {
  match @_common.safe_fibonacci(10) {
    Ok(v) => assert_true(v == 55)
    Err(_) => assert_true(false)
  }
  match @_common.safe_fibonacci(-1) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_standardize" {
  match @_common.safe_standardize([1.0, 2.0, 3.0, 4.0, 5.0]) {
    Ok(_) => assert_true(true)
    Err(_) => assert_true(false)
  }
  match @_common.safe_standardize([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_clip" {
  match @_common.safe_clip([1.0, 5.0, 3.0], 2.0, 4.0) {
    Ok(v) => assert_true(v.length() == 3)
    Err(_) => assert_true(false)
  }
  match @_common.safe_clip([1.0], 4.0, 2.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_cumsum" {
  match @_common.safe_cumsum([1.0, 2.0, 3.0]) {
    Ok(v) => assert_true(v.length() == 3)
    Err(_) => assert_true(false)
  }
  match @_common.safe_cumsum([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_reverse" {
  match @_common.safe_reverse([1.0, 2.0, 3.0]) {
    Ok(v) => assert_true(v.length() == 3)
    Err(_) => assert_true(false)
  }
  match @_common.safe_reverse([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_concat" {
  match @_common.safe_concat([1.0], [2.0]) {
    Ok(v) => assert_true(v.length() == 2)
    Err(_) => assert_true(false)
  }
  match @_common.safe_concat([], []) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_copy_arr" {
  match @_common.safe_copy_arr([1.0, 2.0]) {
    Ok(v) => assert_true(v.length() == 2)
    Err(_) => assert_true(false)
  }
  match @_common.safe_copy_arr([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_scale_arr" {
  match @_common.safe_scale_arr([1.0, 2.0], 3.0) {
    Ok(v) => assert_true(v.length() == 2)
    Err(_) => assert_true(false)
  }
  match @_common.safe_scale_arr([], 3.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_add_arr" {
  match @_common.safe_add_arr([1.0, 2.0], [3.0, 4.0]) {
    Ok(v) => assert_true(v.length() == 2)
    Err(_) => assert_true(false)
  }
  match @_common.safe_add_arr([1.0], [1.0, 2.0]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}

///|
test "safe_sub_arr" {
  match @_common.safe_sub_arr([3.0, 4.0], [1.0, 2.0]) {
    Ok(v) => assert_true(v.length() == 2)
    Err(_) => assert_true(false)
  }
  match @_common.safe_sub_arr([1.0], [1.0, 2.0]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}

///|
test "safe_fill_arr" {
  match @_common.safe_fill_arr(3, 1.0) {
    Ok(v) => assert_true(v.length() == 3)
    Err(_) => assert_true(false)
  }
  match @_common.safe_fill_arr(-1, 1.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_clamp" {
  match @_common.safe_clamp(5.0, 0.0, 10.0) {
    Ok(v) => assert_true(v > 4.99 && v < 5.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_clamp(5.0, 10.0, 0.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_lerp" {
  match @_common.safe_lerp(0.0, 10.0, 0.5) {
    Ok(v) => assert_true(v > 4.99 && v < 5.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_lerp(0.0, 10.0, 2.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_is_prime" {
  match @_common.safe_is_prime(7) {
    Ok(v) => assert_true(v)
    Err(_) => assert_true(false)
  }
  match @_common.safe_is_prime(1) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_sort" {
  match @_common.safe_sort([3.0, 1.0, 2.0]) {
    Ok(v) => assert_true(v.length() == 3)
    Err(_) => assert_true(false)
  }
  match @_common.safe_sort([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_sort_desc" {
  match @_common.safe_sort_desc([3.0, 1.0, 2.0]) {
    Ok(v) => assert_true(v.length() == 3)
    Err(_) => assert_true(false)
  }
  match @_common.safe_sort_desc([]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_mod" {
  match @_common.safe_mod(10, 3) {
    Ok(v) => assert_true(v == 1)
    Err(_) => assert_true(false)
  }
  match @_common.safe_mod(10, 0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_reciprocal" {
  match @_common.safe_reciprocal(4.0) {
    Ok(v) => assert_true(v > 0.24 && v < 0.26)
    Err(_) => assert_true(false)
  }
  match @_common.safe_reciprocal(0.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_percentile" {
  match @_common.safe_percentile([1.0, 2.0, 3.0, 4.0, 5.0], 50.0) {
    Ok(_) => assert_true(true)
    Err(_) => assert_true(false)
  }
  match @_common.safe_percentile([], 50.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
  match @_common.safe_percentile([1.0], 150.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_range" {
  match @_common.safe_range(3) {
    Ok(v) => assert_true(v.length() == 3)
    Err(_) => assert_true(false)
  }
  match @_common.safe_range(-1) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E002")
  }
}

///|
test "safe_zscore" {
  match @_common.safe_zscore(3.0, 1.0, 2.0) {
    Ok(v) => assert_true(v > 0.99 && v < 1.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_zscore(3.0, 1.0, 0.0) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E001")
  }
}

///|
test "safe_dot" {
  match @_common.safe_dot([1.0, 2.0], [3.0, 4.0]) {
    Ok(v) => assert_true(v > 10.99 && v < 11.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_dot([1.0], [1.0, 2.0]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}

///|
test "safe_distance" {
  match @_common.safe_distance([1.0, 2.0], [4.0, 6.0]) {
    Ok(v) => assert_true(v > 4.99 && v < 5.01)
    Err(_) => assert_true(false)
  }
  match @_common.safe_distance([1.0], [1.0, 2.0]) {
    Ok(_) => assert_true(false)
    Err(e) => assert_true(@error.error_code(e) == "E003")
  }
}