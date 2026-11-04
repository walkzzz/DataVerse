///|
/// # extcore/_common extended tests

///|
test "sqrt_1" {
  assert_true(@_common.sqrt(4.0) > 1.99 && @_common.sqrt(4.0) < 2.01)
}

///|
test "sqrt_2" {
  assert_true(@_common.sqrt(0.0) < 0.01)
}

///|
test "sqrt_3" {
  assert_true(@_common.sqrt(9.0) > 2.99 && @_common.sqrt(9.0) < 3.01)
}

///|
test "abs_1" {
  assert_true(@_common.abs(-5.0) > 4.99)
}

///|
test "abs_2" {
  assert_true(@_common.abs(5.0) > 4.99)
}

///|
test "abs_3" {
  assert_true(@_common.abs(0.0) < 0.01)
}

///|
test "clamp_1" {
  assert_true(@_common.clamp(5.0, 0.0, 10.0) > 4.99)
}

///|
test "clamp_2" {
  assert_true(@_common.clamp(15.0, 0.0, 10.0) > 9.99)
}

///|
test "clamp_3" {
  assert_true(@_common.clamp(-5.0, 0.0, 10.0) < 0.01)
}

///|
test "lerp_1" {
  assert_true(@_common.lerp(0.0, 10.0, 0.5) > 4.99)
}

///|
test "lerp_2" {
  assert_true(@_common.lerp(0.0, 10.0, 0.0) < 0.01)
}

///|
test "lerp_3" {
  assert_true(@_common.lerp(0.0, 10.0, 1.0) > 9.99)
}

///|
test "deg_to_rad_1" {
  assert_true(@_common.deg_to_rad(180.0) > 3.13 && @_common.deg_to_rad(180.0) < 3.15)
}

///|
test "deg_to_rad_2" {
  assert_true(@_common.deg_to_rad(0.0) < 0.01)
}

///|
test "deg_to_rad_3" {
  assert_true(@_common.deg_to_rad(90.0) > 1.56 && @_common.deg_to_rad(90.0) < 1.58)
}

///|
test "rad_to_deg_1" {
  assert_true(@_common.rad_to_deg(3.14159265358979) > 179.9)
}

///|
test "rad_to_deg_2" {
  assert_true(@_common.rad_to_deg(0.0) < 0.01)
}

///|
test "rad_to_deg_3" {
  assert_true(@_common.rad_to_deg(1.5707963267949) > 89.9)
}

///|
test "log_1" {
  assert_true(@_common.abs(@_common.log(1.0)) < 0.01)
}

///|
test "log_2" {
  assert_true(@_common.log(2.718281828) > 0.99)
}

///|
test "log_3" {
  assert_true(@_common.log(10.0) > 2.29 && @_common.log(10.0) < 2.31)
}

///|
test "log10_1" {
  assert_true(@_common.log10(100.0) > 1.99)
}

///|
test "log10_2" {
  assert_true(@_common.abs(@_common.log10(1.0)) < 0.01)
}

///|
test "log10_3" {
  assert_true(@_common.log10(1000.0) > 2.99)
}

///|
test "exp_1" {
  assert_true(@_common.exp(0.0) > 0.99 && @_common.exp(0.0) < 1.01)
}

///|
test "exp_2" {
  assert_true(@_common.exp(1.0) > 2.71)
}

///|
test "exp_3" {
  assert_true(@_common.exp(2.0) > 7.38)
}

///|
test "pow_1" {
  assert_true(@_common.pow(2.0, 3.0) > 7.99)
}

///|
test "pow_2" {
  assert_true(@_common.pow(1.0, 100.0) > 0.99)
}

///|
test "pow_3" {
  assert_true(@_common.pow(3.0, 2.0) > 8.99)
}

///|
test "sin_1" {
  assert_true(@_common.abs(@_common.sin(0.0)) < 0.01)
}

///|
test "sin_2" {
  assert_true(@_common.sin(1.5707963267949) > 0.99)
}

///|
test "sin_3" {
  assert_true(@_common.abs(@_common.sin(3.14159265358979)) < 0.01)
}

///|
test "cos_1" {
  assert_true(@_common.cos(0.0) > 0.99)
}

///|
test "cos_2" {
  assert_true(@_common.abs(@_common.cos(1.5707963267949)) < 0.01)
}

///|
test "cos_3" {
  assert_true(@_common.cos(3.14159265358979) < -0.99)
}

///|
test "tan_1" {
  assert_true(@_common.abs(@_common.tan(0.0)) < 0.01)
}

///|
test "tan_2" {
  assert_true(@_common.tan(0.785398163397448) > 0.99)
}

///|
test "atan2_1" {
  assert_true(@_common.atan2(1.0, 1.0) > 0.78 && @_common.atan2(1.0, 1.0) < 0.79)
}

///|
test "atan2_2" {
  assert_true(@_common.abs(@_common.atan2(0.0, 1.0)) < 0.01)
}

///|
test "hypot_1" {
  assert_true(@_common.hypot(3.0, 4.0) > 4.99 && @_common.hypot(3.0, 4.0) < 5.01)
}

///|
test "hypot_2" {
  assert_true(@_common.hypot(0.0, 0.0) < 0.01)
}

///|
test "hypot_3" {
  assert_true(@_common.hypot(5.0, 12.0) > 12.99)
}

///|
test "max2_1" {
  assert_true(@_common.max2(1.0, 2.0) > 1.99)
}

///|
test "max2_2" {
  assert_true(@_common.max2(5.0, 3.0) > 4.99)
}

///|
test "min2_1" {
  assert_true(@_common.min2(1.0, 2.0) < 1.01)
}

///|
test "min2_2" {
  assert_true(@_common.min2(5.0, 3.0) < 3.01)
}

///|
test "floor_1" {
  assert_true(@_common.floor(1.5) < 1.01 && @_common.floor(1.5) > 0.99)
}

///|
test "floor_2" {
  assert_true(@_common.floor(2.9) < 2.01 && @_common.floor(2.9) > 1.99)
}

///|
test "ceil_1" {
  assert_true(@_common.ceil(1.5) > 1.99 && @_common.ceil(1.5) < 2.01)
}

///|
test "ceil_2" {
  assert_true(@_common.ceil(1.1) > 1.99 && @_common.ceil(1.1) < 2.01)
}

///|
test "mean_1" {
  assert_true(@_common.mean([1.0, 2.0, 3.0]) > 1.99 && @_common.mean([1.0, 2.0, 3.0]) < 2.01)
}

///|
test "mean_2" {
  assert_true(@_common.mean([5.0]) > 4.99 && @_common.mean([5.0]) < 5.01)
}

///|
test "mean_3" {
  assert_true(@_common.mean([1.0, 1.0, 1.0]) > 0.99 && @_common.mean([1.0, 1.0, 1.0]) < 1.01)
}

///|
test "sum_1" {
  assert_true(@_common.sum([1.0, 2.0, 3.0]) > 5.99)
}

///|
test "sum_2" {
  assert_true(@_common.sum([10.0]) > 9.99)
}

///|
test "sum_3" {
  assert_true(@_common.abs(@_common.sum([1.0, -1.0])) < 0.01)
}

///|
test "variance_1" {
  assert_true(@_common.variance([1.0, 2.0, 3.0, 4.0, 5.0]) > 1.99)
}

///|
test "variance_2" {
  assert_true(@_common.abs(@_common.variance([1.0, 1.0, 1.0])) < 0.01)
}

///|
test "std_1" {
  assert_true(@_common.std([1.0, 2.0, 3.0, 4.0, 5.0]) > 1.40)
}

///|
test "std_2" {
  assert_true(@_common.abs(@_common.std([1.0, 1.0, 1.0])) < 0.01)
}

///|
test "cov_1" {
  assert_true(@_common.abs(@_common.cov([1.0, 2.0, 3.0], [4.0, 5.0, 6.0])) > 0.01)
}

///|
test "cov_2" {
  assert_true(@_common.abs(@_common.cov([1.0, 1.0, 1.0], [2.0, 2.0, 2.0])) < 0.01)
}

///|
test "corr_1" {
  assert_true(@_common.corr([1.0, 2.0, 3.0], [1.0, 2.0, 3.0]) > 0.99)
}

///|
test "corr_2" {
  assert_true(@_common.corr([1.0, 2.0, 3.0], [3.0, 2.0, 1.0]) < -0.99)
}

///|
test "median_1" {
  assert_true(@_common.median([1.0, 2.0, 3.0]) > 1.99 && @_common.median([1.0, 2.0, 3.0]) < 2.01)
}

///|
test "median_2" {
  assert_true(@_common.median([1.0, 2.0, 3.0, 4.0]) > 2.49 && @_common.median([1.0, 2.0, 3.0, 4.0]) < 2.51)
}

///|
test "median_3" {
  assert_true(@_common.median([5.0]) > 4.99)
}

///|
test "accuracy_1" {
  assert_true(@_common.accuracy([1, 0, 1], [1, 0, 1]) > 0.99)
}

///|
test "accuracy_2" {
  assert_true(@_common.accuracy([1, 0, 1], [0, 1, 0]) < 0.01)
}

///|
test "mse_1" {
  assert_true(@_common.abs(@_common.mse([1.0, 2.0], [1.0, 2.0])) < 0.01)
}

///|
test "mse_2" {
  assert_true(@_common.mse([1.0, 2.0], [3.0, 4.0]) > 3.99)
}

///|
test "rmse_1" {
  assert_true(@_common.abs(@_common.rmse([1.0, 2.0], [1.0, 2.0])) < 0.01)
}

///|
test "rmse_2" {
  assert_true(@_common.rmse([1.0, 2.0], [3.0, 4.0]) > 1.99)
}

///|
test "mae_1" {
  assert_true(@_common.abs(@_common.mae([1.0, 2.0], [1.0, 2.0])) < 0.01)
}

///|
test "mae_2" {
  assert_true(@_common.mae([1.0, 2.0], [3.0, 4.0]) > 1.99)
}

///|
test "r2_1" {
  assert_true(@_common.r2([1.0, 2.0, 3.0], [1.0, 2.0, 3.0]) > 0.99)
}

///|
test "r2_2" {
  assert_true(@_common.r2([1.0, 2.0, 3.0], [3.0, 2.0, 1.0]) < 0.01)
}

///|
test "precision_1" {
  assert_true(@_common.precision([1, 0, 1], [1, 0, 1], 1) > 0.99)
}

///|
test "recall_1" {
  assert_true(@_common.recall([1, 0, 1], [1, 0, 1], 1) > 0.99)
}

///|
test "f1_1" {
  assert_true(@_common.f1([1, 0, 1], [1, 0, 1], 1) > 0.99)
}

///|
test "sort_1" {
  assert_true(@_common.sort([3.0, 1.0, 2.0]).length() == 3)
}

///|
test "sort_2" {
  assert_true(@_common.sort([5.0]).length() == 1)
}

///|
test "sort_3" {
  assert_true(@_common.sort([1.0, 2.0, 3.0, 4.0, 5.0]).length() == 5)
}

///|
test "sort_desc_1" {
  assert_true(@_common.sort_desc([3.0, 1.0, 2.0]).length() == 3)
}

///|
test "sort_desc_2" {
  assert_true(@_common.sort_desc([5.0]).length() == 1)
}

///|
test "sort_desc_3" {
  assert_true(@_common.sort_desc([1.0, 2.0, 3.0]).length() == 3)
}

///|
test "normalize_1" {
  assert_true(@_common.normalize([1.0, 1.0, 1.0]).length() == 3)
}

///|
test "normalize_2" {
  assert_true(@_common.normalize([1.0, 2.0, 3.0]).length() == 3)
}

///|
test "standardize_1" {
  assert_true(@_common.standardize([1.0, 2.0, 3.0, 4.0, 5.0]).length() == 5)
}

///|
test "standardize_2" {
  assert_true(@_common.standardize([1.0, 2.0, 3.0]).length() == 3)
}

///|
test "clip_1" {
  assert_true(@_common.clip([1.0, 5.0, 3.0], 2.0, 4.0).length() == 3)
}

///|
test "clip_2" {
  assert_true(@_common.clip([1.0], 0.0, 10.0).length() == 1)
}

///|
test "cumsum_1" {
  assert_true(@_common.cumsum([1.0, 2.0, 3.0]).length() == 3)
}

///|
test "cumsum_2" {
  assert_true(@_common.cumsum([5.0]).length() == 1)
}

///|
test "cumsum_3" {
  assert_true(@_common.cumsum([1.0, 2.0, 3.0, 4.0]).length() == 4)
}

///|
test "reverse_1" {
  assert_true(@_common.reverse([1.0, 2.0, 3.0]).length() == 3)
}

///|
test "reverse_2" {
  assert_true(@_common.reverse([5.0]).length() == 1)
}

///|
test "concat_1" {
  assert_true(@_common.concat([1.0], [2.0]).length() == 2)
}

///|
test "concat_2" {
  assert_true(@_common.concat([1.0, 2.0], [3.0, 4.0]).length() == 4)
}

///|
test "copy_arr_1" {
  assert_true(@_common.copy_arr([1.0, 2.0]).length() == 2)
}

///|
test "copy_arr_2" {
  assert_true(@_common.copy_arr([5.0]).length() == 1)
}

///|
test "scale_arr_1" {
  assert_true(@_common.scale_arr([1.0, 2.0], 3.0).length() == 2)
}

///|
test "scale_arr_2" {
  assert_true(@_common.scale_arr([1.0], 0.0).length() == 1)
}

///|
test "add_arr_1" {
  assert_true(@_common.add_arr([1.0, 2.0], [3.0, 4.0]).length() == 2)
}

///|
test "add_arr_2" {
  assert_true(@_common.add_arr([1.0], [2.0]).length() == 1)
}

///|
test "sub_arr_1" {
  assert_true(@_common.sub_arr([3.0, 4.0], [1.0, 2.0]).length() == 2)
}

///|
test "sub_arr_2" {
  assert_true(@_common.sub_arr([5.0], [2.0]).length() == 1)
}

///|
test "fill_arr_1" {
  assert_true(@_common.fill_arr(3, 1.0).length() == 3)
}

///|
test "fill_arr_2" {
  assert_true(@_common.fill_arr(0, 1.0).length() == 0)
}

///|
test "fill_arr_3" {
  assert_true(@_common.fill_arr(5, 0.0).length() == 5)
}

///|
test "min_1" {
  assert_true(@_common.min([1.0, 2.0, 3.0]) < 1.01)
}

///|
test "min_2" {
  assert_true(@_common.min([5.0, 3.0, 7.0]) < 3.01)
}

///|
test "max_1" {
  assert_true(@_common.max([1.0, 2.0, 3.0]) > 2.99)
}

///|
test "max_2" {
  assert_true(@_common.max([5.0, 3.0, 7.0]) > 6.99)
}

///|
test "factorial_1" {
  assert_true(@_common.factorial(5) > 119.0 && @_common.factorial(5) < 121.0)
}

///|
test "factorial_2" {
  assert_true(@_common.factorial(0) > 0.99 && @_common.factorial(0) < 1.01)
}

///|
test "factorial_3" {
  assert_true(@_common.factorial(3) > 5.99 && @_common.factorial(3) < 6.01)
}

///|
test "gcd_1" {
  assert_true(@_common.gcd(12, 8) == 4)
}

///|
test "gcd_2" {
  assert_true(@_common.gcd(17, 5) == 1)
}

///|
test "gcd_3" {
  assert_true(@_common.gcd(100, 50) == 50)
}

///|
test "lcm_1" {
  assert_true(@_common.lcm(4, 6) == 12)
}

///|
test "lcm_2" {
  assert_true(@_common.lcm(3, 7) == 21)
}

///|
test "lcm_3" {
  assert_true(@_common.lcm(5, 10) == 10)
}

///|
test "is_prime_1" {
  assert_true(@_common.is_prime(7))
}

///|
test "is_prime_2" {
  assert_true(@_common.is_prime(2))
}

///|
test "is_prime_3" {
  assert_true(@_common.is_prime(4) == false)
}

///|
test "is_prime_4" {
  assert_true(@_common.is_prime(1) == false)
}

///|
test "fibonacci_1" {
  assert_true(@_common.fibonacci(10) == 55)
}

///|
test "fibonacci_2" {
  assert_true(@_common.fibonacci(0) == 0)
}

///|
test "fibonacci_3" {
  assert_true(@_common.fibonacci(1) == 1)
}

///|
test "fibonacci_4" {
  assert_true(@_common.fibonacci(5) == 5)
}

///|
test "dbl_1" {
  assert_true(@_common.dbl(1.0) == "1")
}

///|
test "dbl_2" {
  assert_true(@_common.dbl(0.0) == "0")
}

///|
test "approx_eq_1" {
  assert_true(@_common.approx_eq(1.0, 1.00000001))
}

///|
test "approx_eq_2" {
  assert_true(@_common.approx_eq(1.0, 1.0))
}

///|
test "deg_1" {
  assert_true(@_common.deg(1.5707963267949) > 89.9)
}

///|
test "deg_2" {
  assert_true(@_common.deg(0.0) < 0.01)
}

///|
test "sqrt_edge_1" {
  assert_true(@_common.sqrt(2.0) > 1.41 && @_common.sqrt(2.0) < 1.42)
}

///|
test "sqrt_edge_2" {
  assert_true(@_common.sqrt(100.0) > 9.99)
}

///|
test "abs_edge_1" {
  assert_true(@_common.abs(-100.0) > 99.99)
}

///|
test "abs_edge_2" {
  assert_true(@_common.abs(0.001) < 0.002)
}

///|
test "clamp_edge_1" {
  assert_true(@_common.clamp(5.0, 5.0, 5.0) > 4.99)
}

///|
test "lerp_edge_1" {
  assert_true(@_common.lerp(10.0, 20.0, 0.5) > 14.99)
}

///|
test "pow_edge_1" {
  assert_true(@_common.pow(2.0, 10.0) > 1023.0)
}

///|
test "pow_edge_2" {
  assert_true(@_common.pow(10.0, 2.0) > 99.0)
}

///|
test "exp_edge_1" {
  assert_true(@_common.exp(-1.0) > 0.36 && @_common.exp(-1.0) < 0.37)
}

///|
test "log_edge_1" {
  assert_true(@_common.log(100.0) > 4.60 && @_common.log(100.0) < 4.61)
}

///|
test "sin_edge_1" {
  assert_true(@_common.sin(3.14159265358979 / 6.0) > 0.49 && @_common.sin(3.14159265358979 / 6.0) < 0.51)
}

///|
test "cos_edge_1" {
  assert_true(@_common.cos(3.14159265358979 / 3.0) > 0.49 && @_common.cos(3.14159265358979 / 3.0) < 0.51)
}

///|
test "mean_edge_1" {
  assert_true(@_common.mean([10.0, 20.0, 30.0]) > 19.99 && @_common.mean([10.0, 20.0, 30.0]) < 20.01)
}

///|
test "sum_edge_1" {
  assert_true(@_common.sum([1.0, 2.0, 3.0, 4.0, 5.0]) > 14.99)
}

///|
test "median_edge_1" {
  assert_true(@_common.median([1.0, 3.0, 5.0, 7.0, 9.0]) > 4.99 && @_common.median([1.0, 3.0, 5.0, 7.0, 9.0]) < 5.01)
}

///|
test "std_edge_1" {
  assert_true(@_common.std([0.0, 10.0]) > 4.99)
}

///|
test "variance_edge_1" {
  assert_true(@_common.variance([0.0, 10.0]) > 24.0)
}

///|
test "sort_edge_1" {
  assert_true(@_common.sort([5.0, 4.0, 3.0, 2.0, 1.0]).length() == 5)
}

///|
test "reverse_edge_1" {
  assert_true(@_common.reverse([1.0, 2.0, 3.0, 4.0]).length() == 4)
}

///|
test "concat_edge_1" {
  assert_true(@_common.concat([1.0, 2.0, 3.0], [4.0, 5.0]).length() == 5)
}

///|
test "cumsum_edge_1" {
  assert_true(@_common.cumsum([1.0, 1.0, 1.0, 1.0]).length() == 4)
}

///|
test "gcd_edge_1" {
  assert_true(@_common.gcd(1, 1) == 1)
}

///|
test "lcm_edge_1" {
  assert_true(@_common.lcm(1, 1) == 1)
}

///|
test "fibonacci_edge_1" {
  assert_true(@_common.fibonacci(15) == 610)
}

///|
test "is_prime_edge_1" {
  assert_true(@_common.is_prime(97))
}

///|
test "is_prime_edge_2" {
  assert_true(@_common.is_prime(100) == false)
}

///|
test "factorial_edge_1" {
  assert_true(@_common.factorial(10) > 3628799.0 && @_common.factorial(10) < 3628801.0)
}

///|
test "hypot_edge_1" {
  assert_true(@_common.hypot(1.0, 1.0) > 1.41 && @_common.hypot(1.0, 1.0) < 1.42)
}

///|
test "max2_edge_1" {
  assert_true(@_common.max2(-1.0, -2.0) > -1.01)
}

///|
test "min2_edge_1" {
  assert_true(@_common.min2(-1.0, -2.0) < -1.99)
}

///|
test "floor_edge_1" {
  assert_true(@_common.floor(-1.5) < -1.01 && @_common.floor(-1.5) > -2.01)
}

///|
test "ceil_edge_1" {
  assert_true(@_common.ceil(-1.5) > -1.01 && @_common.ceil(-1.5) < 0.01)
}
