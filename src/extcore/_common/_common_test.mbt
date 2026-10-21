///|
test "common_sqrt" {
  let s = @_common.sqrt(4.0)
  assert_true(s > 1.99 && s < 2.01)
  assert_true(@_common.sqrt(0.0) < 0.001)
  assert_true(@_common.sqrt(-1.0) < 0.001)
  let s2 = @_common.sqrt(2.0)
  assert_true(s2 > 1.414 && s2 < 1.415)
}

///|
test "common_abs" {
  assert_true(@_common.abs(-5.0) > 4.99 && @_common.abs(-5.0) < 5.01)
  assert_true(@_common.abs(3.0) > 2.99 && @_common.abs(3.0) < 3.01)
  assert_true(@_common.abs(0.0) < 0.001)
}

///|
test "common_clamp" {
  assert_true(
    @_common.clamp(5.0, 0.0, 10.0) > 4.99 &&
    @_common.clamp(5.0, 0.0, 10.0) < 5.01,
  )
  assert_true(@_common.clamp(-1.0, 0.0, 10.0) < 0.001)
  assert_true(@_common.clamp(15.0, 0.0, 10.0) > 9.99)
}

///|
test "common_lerp" {
  assert_true(
    @_common.lerp(0.0, 10.0, 0.5) > 4.99 && @_common.lerp(0.0, 10.0, 0.5) < 5.01,
  )
  assert_true(@_common.lerp(0.0, 10.0, 0.0) < 0.001)
  assert_true(@_common.lerp(0.0, 10.0, 1.0) > 9.99)
}

///|
test "common_mean" {
  let m = @_common.mean([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(m > 2.99 && m < 3.01)
  assert_true(@_common.mean([]) < 0.001)
  assert_true(@_common.mean([10.0]) > 9.99 && @_common.mean([10.0]) < 10.01)
}

///|
test "common_sum" {
  let s = @_common.sum([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(s > 14.99 && s < 15.01)
  assert_true(@_common.sum([]) < 0.001)
  assert_true(@_common.sum([10.0]) > 9.99 && @_common.sum([10.0]) < 10.01)
}

///|
test "common_variance_std" {
  let v = @_common.variance([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(v > 1.99 && v < 2.01)
  let s = @_common.std([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(s > 1.41 && s < 1.42)
}

///|
test "common_sort" {
  let sorted = @_common.sort([3.0, 1.0, 4.0, 1.0, 5.0])
  assert_true(sorted[0] > 0.99 && sorted[0] < 1.01)
  assert_true(sorted[4] > 4.99 && sorted[4] < 5.01)
  let desc = @_common.sort_desc([3.0, 1.0, 4.0, 1.0, 5.0])
  assert_true(desc[0] > 4.99 && desc[0] < 5.01)
  assert_true(desc[4] > 0.99 && desc[4] < 1.01)
}

///|
test "common_min_max" {
  assert_true(
    @_common.min([3.0, 1.0, 4.0, 1.0, 5.0]) > 0.99 &&
    @_common.min([3.0, 1.0, 4.0, 1.0, 5.0]) < 1.01,
  )
  assert_true(
    @_common.max([3.0, 1.0, 4.0, 1.0, 5.0]) > 4.99 &&
    @_common.max([3.0, 1.0, 4.0, 1.0, 5.0]) < 5.01,
  )
  assert_true(@_common.min([]) < 0.001)
}

///|
test "common_accuracy" {
  let acc = @_common.accuracy([1, 0, 1, 1, 0], [1, 0, 1, 0, 0])
  assert_true(acc > 0.79 && acc < 0.81)
}

///|
test "common_mse_rmse" {
  let m = @_common.mse([1.0, 2.0, 3.0], [1.0, 2.0, 3.0])
  assert_true(m < 0.001)
  let r = @_common.rmse([1.0, 2.0, 3.0], [2.0, 3.0, 4.0])
  assert_true(r > 0.99 && r < 1.01)
}

///|
test "common_factorial" {
  assert_true(@_common.factorial(0) > 0.99 && @_common.factorial(0) < 1.01)
  assert_true(@_common.factorial(1) > 0.99 && @_common.factorial(1) < 1.01)
  assert_true(@_common.factorial(5) > 119.99 && @_common.factorial(5) < 120.01)
}

///|
test "common_gcd_lcm" {
  assert_true(@_common.gcd(12, 8) == 4)
  assert_true(@_common.gcd(7, 13) == 1)
  assert_true(@_common.lcm(4, 6) == 12)
}

///|
test "common_is_prime" {
  assert_true(@_common.is_prime(2))
  assert_true(@_common.is_prime(7))
  assert_false(@_common.is_prime(1))
  assert_false(@_common.is_prime(4))
}

///|
test "common_fibonacci" {
  assert_true(@_common.fibonacci(0) == 0)
  assert_true(@_common.fibonacci(1) == 1)
  assert_true(@_common.fibonacci(10) == 55)
}

///|
test "common_normalize" {
  let n = @_common.normalize([0.0, 5.0, 10.0])
  assert_true(n[0] < 0.001)
  assert_true(n[1] > 0.49 && n[1] < 0.51)
  assert_true(n[2] > 0.99)
}

///|
test "common_cumsum" {
  let c = @_common.cumsum([1.0, 2.0, 3.0, 4.0])
  assert_true(c[0] > 0.99 && c[0] < 1.01)
  assert_true(c[3] > 9.99 && c[3] < 10.01)
}

///|
test "common_reverse" {
  let r = @_common.reverse([1.0, 2.0, 3.0])
  assert_true(r[0] > 2.99 && r[0] < 3.01)
  assert_true(r[2] > 0.99 && r[2] < 1.01)
}

///|
test "common_concat" {
  let c = @_common.concat([1.0, 2.0], [3.0, 4.0])
  assert_true(c.length() == 4)
  assert_true(c[2] > 2.99 && c[2] < 3.01)
}

///|
test "common_median" {
  let m1 = @_common.median([1.0, 3.0, 2.0])
  assert_true(m1 > 1.99 && m1 < 2.01)
  let m2 = @_common.median([1.0, 2.0, 3.0, 4.0])
  assert_true(m2 > 2.49 && m2 < 2.51)
}

///|
test "common_corr" {
  let c = @_common.corr([1.0, 2.0, 3.0, 4.0], [2.0, 4.0, 6.0, 8.0])
  assert_true(c > 0.99)
}

///|
test "common_array_ops" {
  let r = @_common.copy_arr([1.0, 2.0, 3.0])
  assert_true(r[2] > 2.99 && r[2] < 3.01)
  let s = @_common.scale_arr([1.0, 2.0, 3.0], 2.0)
  assert_true(s[1] > 3.99 && s[1] < 4.01)
  let a = @_common.add_arr([1.0, 2.0], [3.0, 4.0])
  assert_true(a[0] > 3.99 && a[0] < 4.01)
  assert_true(a[1] > 5.99 && a[1] < 6.01)
  let f = @_common.fill_arr(3, 5.0)
  assert_true(f[0] > 4.99 && f[2] > 4.99)
}

///|
test "common_robustness_factorial" {
  assert_true(@_common.factorial(-1) < 0.001)
  assert_true(@_common.factorial(0) > 0.99 && @_common.factorial(0) < 1.01)
  assert_true(@_common.factorial(5) > 119.9 && @_common.factorial(5) < 120.1)
}

///|
test "common_robustness_fibonacci" {
  assert_true(@_common.fibonacci(-1) == 0)
  assert_true(@_common.fibonacci(0) == 0)
  assert_true(@_common.fibonacci(1) == 1)
  assert_true(@_common.fibonacci(10) == 55)
}

///|
test "common_robustness_is_prime" {
  assert_true(!@_common.is_prime(-1))
  assert_true(!@_common.is_prime(0))
  assert_true(!@_common.is_prime(1))
  assert_true(@_common.is_prime(2))
  assert_true(@_common.is_prime(3))
  assert_true(@_common.is_prime(7))
  assert_true(!@_common.is_prime(8))
  assert_true(@_common.is_prime(97))
}

///|
test "common_robustness_clamp" {
  let r = @_common.clamp(5.0, 10.0, 0.0)
  assert_true(r > 4.99 && r < 5.01)
  let r2 = @_common.clamp(-1.0, 0.0, 10.0)
  assert_true(r2 < 0.001)
  let r3 = @_common.clamp(15.0, 0.0, 10.0)
  assert_true(r3 > 9.99)
}

///|
test "common_robustness_sort" {
  let sorted = @_common.sort([5.0, 3.0, 1.0, 4.0, 2.0])
  assert_true(sorted[0] < 1.01 && sorted[4] > 4.99)
  let sorted2 = @_common.sort([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(sorted2[0] < 1.01 && sorted2[4] > 4.99)
  let sorted3 = @_common.sort([])
  assert_true(sorted3.length() == 0)
  let sorted4 = @_common.sort([42.0])
  assert_true(sorted4[0] > 41.99 && sorted4[0] < 42.01)
}

///|
test "proof_sqrt_nonneg" {
  assert_true(@_common.sqrt(0.0) < 0.001)
  assert_true(@_common.sqrt(1.0) > 0.99)
  assert_true(@_common.sqrt(100.0) > 9.99)
  assert_true(@_common.sqrt(0.25) > 0.49 && @_common.sqrt(0.25) < 0.51)
}

///|
test "proof_sort_nondecreasing" {
  let sorted = @_common.sort([5.0, 3.0, 1.0, 4.0, 2.0, 8.0, 6.0, 7.0])
  let end = sorted.length() - 1
  for i in 0..<end {
    assert_true(sorted[i] <= sorted[i + 1])
  }
}

///|
test "proof_mean_constant" {
  let m = @_common.mean([7.0, 7.0, 7.0, 7.0])
  assert_true(m > 6.99 && m < 7.01)
}

///|
test "proof_variance_constant" {
  let v = @_common.variance([7.0, 7.0, 7.0, 7.0])
  assert_true(v < 0.001)
}

///|
test "proof_sum_empty" {
  assert_true(@_common.sum([]) < 0.001)
}

///|
test "proof_factorial_base" {
  assert_true(@_common.factorial(0) > 0.99 && @_common.factorial(0) < 1.01)
  assert_true(@_common.factorial(1) > 0.99 && @_common.factorial(1) < 1.01)
  assert_true(
    @_common.factorial(10) > 3628799.0 && @_common.factorial(10) < 3628801.0,
  )
}

///|
test "proof_gcd_divides" {
  let g = @_common.gcd(12, 18)
  assert_true(12 % g == 0)
  assert_true(18 % g == 0)
  assert_true(g == 6)
}

///|
test "proof_fibonacci_recurrence" {
  for n in 2..<20 {
    assert_true(
      @_common.fibonacci(n) ==
      @_common.fibonacci(n - 1) + @_common.fibonacci(n - 2),
    )
  }
}

///|
test "proof_clamp_bounds" {
  for x in [-5.0, 0.0, 5.0, 10.0, 15.0] {
    let c = @_common.clamp(x, 0.0, 10.0)
    assert_true(c >= 0.0 && c <= 10.0)
  }
}

///|
test "proof_abs_nonneg" {
  assert_true(@_common.abs(-5.0) > 4.99)
  assert_true(@_common.abs(0.0) < 0.001)
  assert_true(@_common.abs(5.0) > 4.99)
}

///|
test "proof_lcm_multiple" {
  let l = @_common.lcm(4, 6)
  assert_true(l % 4 == 0)
  assert_true(l % 6 == 0)
  assert_true(l == 12)
}

///|
test "proof_accuracy_perfect" {
  let acc = @_common.accuracy([1, 2, 3], [1, 2, 3])
  assert_true(acc > 0.99)
}

///|
test "proof_accuracy_zero" {
  let acc = @_common.accuracy([1, 2, 3], [4, 5, 6])
  assert_true(acc < 0.01)
}

///|
test "proof_mse_zero_perfect" {
  let m = @_common.mse([1.0, 2.0, 3.0], [1.0, 2.0, 3.0])
  assert_true(m < 0.001)
}

///|
test "proof_rmse_nonneg" {
  let r = @_common.rmse([1.0, 2.0], [3.0, 4.0])
  assert_true(r > 0.0)
}

///|
test "proof_mae_nonneg" {
  let m = @_common.mae([1.0, 2.0], [3.0, 4.0])
  assert_true(m > 0.0)
}

///|
test "proof_r2_perfect" {
  let r = @_common.r2([1.0, 2.0, 3.0], [1.0, 2.0, 3.0])
  assert_true(r > 0.99)
}

///|
test "proof_corr_self" {
  let c = @_common.corr([1.0, 2.0, 3.0, 4.0], [1.0, 2.0, 3.0, 4.0])
  assert_true(c > 0.99)
}

///|
test "proof_corr_negated" {
  let c = @_common.corr([1.0, 2.0, 3.0, 4.0], [-1.0, -2.0, -3.0, -4.0])
  assert_true(c < -0.99)
}

///|
test "proof_normalize_range" {
  let n = @_common.normalize([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(n[0] < 0.001)
  assert_true(n[4] > 0.99)
}

///|
test "proof_cumsum_last" {
  let c = @_common.cumsum([1.0, 2.0, 3.0, 4.0])
  assert_true(c[3] > 9.99 && c[3] < 10.01)
}

///|
test "proof_reverse_length" {
  let r = @_common.reverse([1.0, 2.0, 3.0])
  assert_true(r.length() == 3)
  assert_true(r[0] > 2.99 && r[2] < 1.01)
}

///|
test "proof_concat_length" {
  let c = @_common.concat([1.0, 2.0], [3.0, 4.0, 5.0])
  assert_true(c.length() == 5)
}

///|
test "edge_empty_arrays" {
  assert_true(@_common.sum([]) < 0.001)
  assert_true(@_common.mean([]) < 0.001)
  assert_true(@_common.variance([]) < 0.001)
  assert_true(@_common.std([]) < 0.001)
  assert_true(@_common.min([]) < 0.001)
  assert_true(@_common.max([]) < 0.001)
  assert_true(@_common.median([]) < 0.001)
  assert_true(@_common.sort([]).length() == 0)
  assert_true(@_common.normalize([]).length() == 0)
  assert_true(@_common.cumsum([]).length() == 0)
}

///|
test "edge_single_element" {
  assert_true(@_common.sum([42.0]) > 41.99)
  assert_true(@_common.mean([42.0]) > 41.99)
  assert_true(@_common.variance([42.0]) < 0.001)
  assert_true(@_common.std([42.0]) < 0.001)
  assert_true(@_common.min([42.0]) > 41.99)
  assert_true(@_common.max([42.0]) > 41.99)
  assert_true(@_common.median([42.0]) > 41.99)
}

///|
test "edge_negative_numbers" {
  let data = [-5.0, -3.0, -1.0]
  assert_true(@_common.sum(data) > -9.01 && @_common.sum(data) < -8.99)
  assert_true(@_common.mean(data) > -3.01 && @_common.mean(data) < -2.99)
  assert_true(@_common.min(data) > -5.01 && @_common.min(data) < -4.99)
  assert_true(@_common.max(data) > -1.01 && @_common.max(data) < -0.99)
}

///|
test "edge_large_numbers" {
  let data = [1000000.0, 2000000.0, 3000000.0]
  let m = @_common.mean(data)
  assert_true(m > 1999999.0 && m < 2000001.0)
  let s = @_common.sum(data)
  assert_true(s > 5999999.0 && s < 6000001.0)
}

///|
test "edge_near_zero" {
  let data = [0.000001, 0.000002, 0.000003]
  let m = @_common.mean(data)
  assert_true(m > 0.0)
  let s = @_common.std(data)
  assert_true(s >= 0.0)
}

///|
test "edge_clamp_lo_eq_hi" {
  let c = @_common.clamp(5.0, 3.0, 3.0)
  assert_true(c > 2.99 && c < 3.01)
}

///|
test "edge_factorial_large" {
  let f = @_common.factorial(15)
  assert_true(f > 1300000000000.0)
}

///|
test "math_log_exp" {
  let l = @_common.log(2.718281828459045)
  assert_true(l > 0.99 && l < 1.01)
  let e = @_common.exp(1.0)
  assert_true(e > 2.71 && e < 2.72)
}

///|
test "math_log10" {
  let l = @_common.log10(1000.0)
  assert_true(l > 2.99 && l < 3.01)
}

///|
test "math_pow" {
  let p = @_common.pow(2.0, 10.0)
  assert_true(p > 1023.0 && p < 1025.0)
}

///|
test "math_sin_cos" {
  let s = @_common.sin(3.141592653589793 / 2.0)
  assert_true(s > 0.99)
  let c = @_common.cos(0.0)
  assert_true(c > 0.99)
}

///|
test "math_hypot" {
  let h = @_common.hypot(3.0, 4.0)
  assert_true(h > 4.99 && h < 5.01)
}

///|
test "math_max2_min2" {
  assert_true(@_common.max2(3.0, 5.0) > 4.99)
  assert_true(@_common.min2(3.0, 5.0) > 2.99 && @_common.min2(3.0, 5.0) < 3.01)
}

///|
test "math_floor_ceil" {
  assert_true(@_common.floor(3.7) > 2.99 && @_common.floor(3.7) < 3.01)
  assert_true(@_common.ceil(3.2) > 3.99 && @_common.ceil(3.2) < 4.01)
}
