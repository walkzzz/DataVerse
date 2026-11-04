///|
/// # DataVerse 性能基准测试 / Benchmark Suite
///
/// 覆盖核心数学、数组、统计、安全 API、trait 方法的性能基准。

///|
fn bench_array_ops(n : Int) -> Unit {
  let data = Array::make(n, 0.0)
  for i in 0..<n {
    data[i] = i.to_double()
  }
  let _ = @_common.mean(data)
  let _ = @_common.std(data)
  let _ = @_common.min(data)
  let _ = @_common.max(data)
  let _ = @_common.sum(data)
  let sorted = @_common.sort(data)
  let _ = @_common.variance(data)
  let _ = @_common.median(data)
  println("  array_ops(\{n}): mean/std/min/max/sum/sort/variance/median OK, sorted=\{sorted.length()}")
}

///|
fn bench_safe_api(n : Int) -> Unit {
  let data = Array::make(n, 0.0)
  for i in 0..<n {
    data[i] = i.to_double() + 1.0
  }
  let _ = @_common.safe_arr_sum(data)
  let _ = @_common.safe_arr_mean(data)
  let _ = @_common.safe_arr_min(data)
  let _ = @_common.safe_arr_max(data)
  let _ = @_common.safe_arr_var(data)
  let _ = @_common.safe_arr_std(data)
  let _ = @_common.safe_arr_range(data)
  let _ = @_common.safe_arr_product(data)
  let _ = @_common.safe_sum_squares(data)
  let _ = @_common.safe_arr_dot(data, data)
  let _ = @_common.safe_arr_l1_dist(data, data)
  let _ = @_common.safe_arr_l2_dist(data, data)
  let _ = @_common.safe_arr_scale(data, 2.0)
  let _ = @_common.safe_arr_offset(data, 1.0)
  let _ = @_common.safe_arr_add(data, data)
  let _ = @_common.safe_arr_sub(data, data)
  let _ = @_common.safe_arr_mul(data, data)
  let _ = @_common.safe_arr_all_pos(data)
  let _ = @_common.safe_arr_count_pos(data)
  let _ = @_common.safe_arr_count_neg(data)
  let _ = @_common.safe_arr_count_zero(data)
  println("  safe_api(\{n}): 20 safe array operations OK")
}

///|
fn bench_math_ops(n : Int) -> Unit {
  let mut s = 0.0
  for i in 0..<n {
    let x = i.to_double()
    s += @_common.abs(x)
    s += @_common.sqrt(x + 1.0)
    s += @_common.sin(x)
    s += @_common.cos(x)
    s += @_common.exp(x * 0.001)
    s += @_common.log(x + 1.0)
    s += @_common.pow(x + 1.0, 0.5)
  }
  println("  math_ops(\{n}): abs/sqrt/sin/cos/exp/ln/pow OK, sum=\{s > 0.0}")
}

///|
fn bench_stat_ops(n : Int) -> Unit {
  let data = Array::make(n, 0.0)
  for i in 0..<n {
    data[i] = (i.to_double() % 100.0) - 50.0
  }
  let _ = @_common.mean(data)
  let _ = @_common.std(data)
  let _ = @_common.variance(data)
  let _ = @_common.median(data)
  let _ = @_common.min(data)
  let _ = @_common.max(data)
  let _ = @_common.sum(data)
  let _ = @_common.max(data) - @_common.min(data)
  let _ = @_common.median(data)
  let _ = @_common.standardize(data)
  let _ = @_common.normalize(data)
  println("  stat_ops(\{n}): mean/std/variance/median/min/max/sum/standardize/normalize OK")
}

///|
fn bench_safe_math(n : Int) -> Unit {
  let mut ok_count = 0
  for i in 0..<n {
    let x = i.to_double() + 1.0
    match @_common.safe_div(1.0, x) {
      Ok(_) => ok_count += 1
      Err(_) => ()
    }
    match @_common.safe_log(x) {
      Ok(_) => ok_count += 1
      Err(_) => ()
    }
    match @_common.safe_sqrt(x) {
      Ok(_) => ok_count += 1
      Err(_) => ()
    }
    match @_common.safe_pow(x, 0.5) {
      Ok(_) => ok_count += 1
      Err(_) => ()
    }
    match @_common.safe_reciprocal(x) {
      Ok(_) => ok_count += 1
      Err(_) => ()
    }
  }
  println("  safe_math(\{n}): 5 safe math ops × n = \{ok_count} successful")
}

///|
fn bench_string_ops(n : Int) -> Unit {
  let mut s = ""
  for i in 0..<n {
    s = s + i.to_string()
  }
  let _ = s.length()
  let upper = s.to_upper()
  let lower = s.to_lower()
  let _ = upper.length()
  let _ = lower.length()
  let _ = s.contains("123")
  let _ = s.has_prefix("0")
  println("  string_ops(\{n}): concat/length/upper/lower/contains/starts OK, len=\{s.length()}")
}

///|
fn bench_int_ops(n : Int) -> Unit {
  let mut sum = 0
  for i in 1..=n {
    sum += i
    sum *= 2
    sum /= 2
    sum %= 1000
  }
  let _ = @_common.safe_factorial_small(10)
  let _ = @_common.safe_perm(20, 5)
  let _ = @_common.safe_comb(20, 10)
  let _ = @_common.safe_int_pow(2, 20)
  let _ = @_common.safe_gcd(123456, 7890)
  let _ = @_common.safe_lcm(123, 456)
  let _ = @_common.safe_is_prime(997)
  let _ = @_common.safe_fibonacci(30)
  println("  int_ops(\{n}): sum/arithmetic/factorial/perm/comb/pow/gcd/lcm/prime/fib OK, sum=\{sum}")
}

///|
fn main {
  println("DataVerse Benchmark Tool v1.0.0-beta")
  println("=====================================")
  println("")
  let sizes = [1000, 10000, 100000]
  for i in 0..<sizes.length() {
    let n = sizes[i]
    println("--- N = \{n} ---")
    bench_array_ops(n)
    bench_safe_api(n)
    bench_math_ops(n)
    bench_stat_ops(n)
    bench_safe_math(n)
    bench_string_ops(n)
    bench_int_ops(n)
    println("")
  }
  println("All benchmarks completed successfully.")
}
