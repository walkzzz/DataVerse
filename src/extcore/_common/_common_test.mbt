test "common_sqrt" {
  let s = @_common.sqrt(4.0)
  assert_true(s > 1.99 && s < 2.01)
  assert_true(@_common.sqrt(0.0) < 0.001)
  assert_true(@_common.sqrt(-1.0) < 0.001)
  let s2 = @_common.sqrt(2.0)
  assert_true(s2 > 1.414 && s2 < 1.415)
}

test "common_abs" {
  assert_true(@_common.abs(-5.0) > 4.99 && @_common.abs(-5.0) < 5.01)
  assert_true(@_common.abs(3.0) > 2.99 && @_common.abs(3.0) < 3.01)
  assert_true(@_common.abs(0.0) < 0.001)
}

test "common_clamp" {
  assert_true(@_common.clamp(5.0, 0.0, 10.0) > 4.99 && @_common.clamp(5.0, 0.0, 10.0) < 5.01)
  assert_true(@_common.clamp(-1.0, 0.0, 10.0) < 0.001)
  assert_true(@_common.clamp(15.0, 0.0, 10.0) > 9.99)
}

test "common_lerp" {
  assert_true(@_common.lerp(0.0, 10.0, 0.5) > 4.99 && @_common.lerp(0.0, 10.0, 0.5) < 5.01)
  assert_true(@_common.lerp(0.0, 10.0, 0.0) < 0.001)
  assert_true(@_common.lerp(0.0, 10.0, 1.0) > 9.99)
}

test "common_mean" {
  let m = @_common.mean([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(m > 2.99 && m < 3.01)
  assert_true(@_common.mean([]) < 0.001)
  assert_true(@_common.mean([10.0]) > 9.99 && @_common.mean([10.0]) < 10.01)
}

test "common_sum" {
  let s = @_common.sum([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(s > 14.99 && s < 15.01)
  assert_true(@_common.sum([]) < 0.001)
  assert_true(@_common.sum([10.0]) > 9.99 && @_common.sum([10.0]) < 10.01)
}

test "common_variance_std" {
  let v = @_common.variance([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(v > 1.99 && v < 2.01)
  let s = @_common.std([1.0, 2.0, 3.0, 4.0, 5.0])
  assert_true(s > 1.41 && s < 1.42)
}

test "common_sort" {
  let sorted = @_common.sort([3.0, 1.0, 4.0, 1.0, 5.0])
  assert_true(sorted[0] > 0.99 && sorted[0] < 1.01)
  assert_true(sorted[4] > 4.99 && sorted[4] < 5.01)
  let desc = @_common.sort_desc([3.0, 1.0, 4.0, 1.0, 5.0])
  assert_true(desc[0] > 4.99 && desc[0] < 5.01)
  assert_true(desc[4] > 0.99 && desc[4] < 1.01)
}

test "common_min_max" {
  assert_true(@_common.min([3.0, 1.0, 4.0, 1.0, 5.0]) > 0.99 && @_common.min([3.0, 1.0, 4.0, 1.0, 5.0]) < 1.01)
  assert_true(@_common.max([3.0, 1.0, 4.0, 1.0, 5.0]) > 4.99 && @_common.max([3.0, 1.0, 4.0, 1.0, 5.0]) < 5.01)
  assert_true(@_common.min([]) < 0.001)
}

test "common_accuracy" {
  let acc = @_common.accuracy([1, 0, 1, 1, 0], [1, 0, 1, 0, 0])
  assert_true(acc > 0.79 && acc < 0.81)
}

test "common_mse_rmse" {
  let m = @_common.mse([1.0, 2.0, 3.0], [1.0, 2.0, 3.0])
  assert_true(m < 0.001)
  let r = @_common.rmse([1.0, 2.0, 3.0], [2.0, 3.0, 4.0])
  assert_true(r > 0.99 && r < 1.01)
}

test "common_factorial" {
  assert_true(@_common.factorial(0) > 0.99 && @_common.factorial(0) < 1.01)
  assert_true(@_common.factorial(1) > 0.99 && @_common.factorial(1) < 1.01)
  assert_true(@_common.factorial(5) > 119.99 && @_common.factorial(5) < 120.01)
}

test "common_gcd_lcm" {
  assert_true(@_common.gcd(12, 8) == 4)
  assert_true(@_common.gcd(7, 13) == 1)
  assert_true(@_common.lcm(4, 6) == 12)
}

test "common_is_prime" {
  assert_true(@_common.is_prime(2))
  assert_true(@_common.is_prime(7))
  assert_false(@_common.is_prime(1))
  assert_false(@_common.is_prime(4))
}

test "common_fibonacci" {
  assert_true(@_common.fibonacci(0) == 0)
  assert_true(@_common.fibonacci(1) == 1)
  assert_true(@_common.fibonacci(10) == 55)
}

test "common_normalize" {
  let n = @_common.normalize([0.0, 5.0, 10.0])
  assert_true(n[0] < 0.001)
  assert_true(n[1] > 0.49 && n[1] < 0.51)
  assert_true(n[2] > 0.99)
}

test "common_cumsum" {
  let c = @_common.cumsum([1.0, 2.0, 3.0, 4.0])
  assert_true(c[0] > 0.99 && c[0] < 1.01)
  assert_true(c[3] > 9.99 && c[3] < 10.01)
}

test "common_reverse" {
  let r = @_common.reverse([1.0, 2.0, 3.0])
  assert_true(r[0] > 2.99 && r[0] < 3.01)
  assert_true(r[2] > 0.99 && r[2] < 1.01)
}

test "common_concat" {
  let c = @_common.concat([1.0, 2.0], [3.0, 4.0])
  assert_true(c.length() == 4)
  assert_true(c[2] > 2.99 && c[2] < 3.01)
}

test "common_median" {
  let m1 = @_common.median([1.0, 3.0, 2.0])
  assert_true(m1 > 1.99 && m1 < 2.01)
  let m2 = @_common.median([1.0, 2.0, 3.0, 4.0])
  assert_true(m2 > 2.49 && m2 < 2.51)
}

test "common_corr" {
  let c = @_common.corr([1.0, 2.0, 3.0, 4.0], [2.0, 4.0, 6.0, 8.0])
  assert_true(c > 0.99)
}