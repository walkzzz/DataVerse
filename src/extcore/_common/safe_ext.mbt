///|
/// # extcore/_common/safe_ext — 扩展安全 API / Extended safe API
///
/// 为更多核心函数提供返回 `Result[T, DataVerseError]` 的安全版本。

///|
/// 安全求和 / Safe sum.
pub fn safe_sum(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  lift_nonempty(arr, "sum", sum)
}

///|
/// 安全协方差 / Safe covariance.
pub fn safe_cov(
  a : Array[Double],
  b : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(a, b, "cov", cov)
}

///|
/// 安全相关系数 / Safe correlation.
pub fn safe_corr(
  a : Array[Double],
  b : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(a, b, "corr", corr)
}

///|
/// 安全准确率 / Safe accuracy.
pub fn safe_accuracy(
  pred : Array[Int32],
  labels : Array[Int32],
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(pred, labels, "accuracy", accuracy)
}

///|
/// 安全均方误差 / Safe MSE.
pub fn safe_mse(
  pred : Array[Double],
  labels : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(pred, labels, "mse", mse)
}

///|
/// 安全均方根误差 / Safe RMSE.
pub fn safe_rmse(
  pred : Array[Double],
  labels : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(pred, labels, "rmse", rmse)
}

///|
/// 安全平均绝对误差 / Safe MAE.
pub fn safe_mae(
  pred : Array[Double],
  labels : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(pred, labels, "mae", mae)
}

///|
/// 安全 R² 分数 / Safe R-squared.
pub fn safe_r2(
  pred : Array[Double],
  labels : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(pred, labels, "r2", r2)
}

///|
/// 安全精确率 / Safe precision.
pub fn safe_precision(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(pred, labels, "precision", (a, b) => precision(a, b, pos))
}

///|
/// 安全召回率 / Safe recall.
pub fn safe_recall(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(pred, labels, "recall", (a, b) => recall(a, b, pos))
}

///|
/// 安全 F1 分数 / Safe F1 score.
pub fn safe_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Result[Double, @error.DataVerseError] {
  lift_same_len(pred, labels, "f1", (a, b) => f1(a, b, pos))
}

///|
/// 安全常用对数 / Safe log10.
pub fn safe_log10(x : Double) -> Result[Double, @error.DataVerseError] {
  if x <= 0.0 {
    Err(@error.out_of_range("log10 of non-positive number: " + x.to_string()))
  } else {
    Ok(log10(x))
  }
}

///|
/// 安全幂运算 / Safe power.
pub fn safe_pow(
  base : Double,
  exp : Double,
) -> Result[Double, @error.DataVerseError] {
  if base < 0.0 && exp != floor(exp) {
    Err(@error.invalid_input("pow: negative base with non-integer exponent"))
  } else if base == 0.0 && exp < 0.0 {
    Err(@error.invalid_input("pow: zero base with negative exponent"))
  } else {
    Ok(pow(base, exp))
  }
}

///|
/// 安全正切 / Safe tangent.
pub fn safe_tan(x : Double) -> Result[Double, @error.DataVerseError] {
  let c = cos(x)
  if abs(c) < 0.0000001 {
    Err(@error.out_of_range("tan undefined at x = " + x.to_string()))
  } else {
    Ok(tan(x))
  }
}

///|
/// 安全反正切2 / Safe atan2.
pub fn safe_atan2(
  y : Double,
  x : Double,
) -> Result[Double, @error.DataVerseError] {
  if y == 0.0 && x == 0.0 {
    Err(@error.invalid_input("atan2(0, 0) is undefined"))
  } else {
    Ok(atan2(y, x))
  }
}

///|
/// 安全最大公约数 / Safe GCD.
pub fn safe_gcd(
  a : Int32,
  b : Int32,
) -> Result[Int32, @error.DataVerseError] {
  if a == 0 && b == 0 {
    Err(@error.invalid_input("gcd(0, 0) is undefined"))
  } else {
    Ok(gcd(a, b))
  }
}

///|
/// 安全最小公倍数 / Safe LCM.
pub fn safe_lcm(
  a : Int32,
  b : Int32,
) -> Result[Int32, @error.DataVerseError] {
  if a == 0 || b == 0 {
    Err(@error.invalid_input("lcm with zero operand"))
  } else {
    Ok(lcm(a, b))
  }
}

///|
/// 安全斐波那契数 / Safe Fibonacci.
pub fn safe_fibonacci(n : Int32) -> Result[Int32, @error.DataVerseError] {
  if n < 0 {
    Err(@error.out_of_range("fibonacci of negative number: " + n.to_string()))
  } else {
    Ok(fibonacci(n))
  }
}

///|
/// 安全标准化 / Safe standardize.
pub fn safe_standardize(
  arr : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("standardize of empty array"))
  } else if arr.length() == 1 {
    Err(@error.invalid_input("standardize: need at least 2 elements"))
  } else {
    let s = std(arr)
    if abs(s) < 0.0000001 {
      Err(@error.invalid_input("standardize: zero standard deviation"))
    } else {
      Ok(standardize(arr))
    }
  }
}

///|
/// 安全裁剪数组 / Safe clip array.
pub fn safe_clip(
  data : Array[Double],
  lo : Double,
  hi : Double,
) -> Result[Array[Double], @error.DataVerseError] {
  if lo > hi {
    Err(@error.invalid_input("clip: lo > hi"))
  } else if data.length() == 0 {
    Err(@error.invalid_input("clip of empty array"))
  } else {
    Ok(clip(data, lo, hi))
  }
}

///|
/// 安全累加和 / Safe cumulative sum.
pub fn safe_cumsum(
  arr : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  lift_nonempty(arr, "cumsum", cumsum)
}

///|
/// 安全反转数组 / Safe reverse.
pub fn safe_reverse(
  arr : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  lift_nonempty(arr, "reverse", reverse)
}

///|
/// 安全拼接数组 / Safe concat.
pub fn safe_concat(
  a : Array[Double],
  b : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  if a.length() == 0 && b.length() == 0 {
    Err(@error.invalid_input("concat of two empty arrays"))
  } else {
    Ok(concat(a, b))
  }
}

///|
/// 安全复制数组 / Safe copy array.
pub fn safe_copy_arr(
  arr : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  lift_nonempty(arr, "copy", copy_arr)
}

///|
/// 安全缩放数组 / Safe scale array.
pub fn safe_scale_arr(
  arr : Array[Double],
  f : Double,
) -> Result[Array[Double], @error.DataVerseError] {
  lift_nonempty(arr, "scale", fn(a) { scale_arr(a, f) })
}

///|
/// 安全数组加法 / Safe array addition.
pub fn safe_add_arr(
  a : Array[Double],
  b : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("add_arr: length mismatch"))
  } else if a.length() == 0 {
    Err(@error.invalid_input("add_arr of empty arrays"))
  } else {
    Ok(add_arr(a, b))
  }
}

///|
/// 安全数组减法 / Safe array subtraction.
pub fn safe_sub_arr(
  a : Array[Double],
  b : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("sub_arr: length mismatch"))
  } else if a.length() == 0 {
    Err(@error.invalid_input("sub_arr of empty arrays"))
  } else {
    Ok(sub_arr(a, b))
  }
}

///|
/// 安全填充数组 / Safe fill array.
pub fn safe_fill_arr(
  n : Int32,
  v : Double,
) -> Result[Array[Double], @error.DataVerseError] {
  if n < 0 {
    Err(@error.out_of_range("fill_arr: negative size " + n.to_string()))
  } else {
    Ok(fill_arr(n, v))
  }
}

///|
/// 安全钳位 / Safe clamp.
pub fn safe_clamp(
  x : Double,
  lo : Double,
  hi : Double,
) -> Result[Double, @error.DataVerseError] {
  if lo > hi {
    Err(@error.invalid_input("clamp: lo > hi"))
  } else {
    Ok(clamp(x, lo, hi))
  }
}

///|
/// 安全线性插值 / Safe linear interpolation.
pub fn safe_lerp(
  a : Double,
  b : Double,
  t : Double,
) -> Result[Double, @error.DataVerseError] {
  if t < 0.0 || t > 1.0 {
    Err(@error.out_of_range("lerp: t = " + t.to_string() + " out of [0, 1]"))
  } else {
    Ok(lerp(a, b, t))
  }
}

///|
/// 安全素数判断 / Safe is_prime.
pub fn safe_is_prime(n : Int32) -> Result[Bool, @error.DataVerseError] {
  if n < 2 {
    Err(@error.out_of_range("is_prime: n = " + n.to_string() + " < 2"))
  } else {
    Ok(is_prime(n))
  }
}

///|
/// 安全升序排序 / Safe sort ascending.
pub fn safe_sort(
  arr : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  lift_nonempty(arr, "sort", sort)
}

///|
/// 安全降序排序 / Safe sort descending.
pub fn safe_sort_desc(
  arr : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  lift_nonempty(arr, "sort_desc", sort_desc)
}

///|
/// 安全取模 / Safe modulo.
pub fn safe_mod(
  a : Int32,
  b : Int32,
) -> Result[Int32, @error.DataVerseError] {
  if b == 0 {
    Err(@error.invalid_input("mod by zero"))
  } else {
    Ok(a % b)
  }
}

///|
/// 安全倒数 / Safe reciprocal.
pub fn safe_reciprocal(x : Double) -> Result[Double, @error.DataVerseError] {
  if abs(x) < 0.0000001 {
    Err(@error.invalid_input("reciprocal of zero"))
  } else {
    Ok(1.0 / x)
  }
}

///|
/// 安全百分位数 / Safe percentile.
pub fn safe_percentile(
  arr : Array[Double],
  p : Double,
) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("percentile of empty array"))
  } else if p < 0.0 || p > 100.0 {
    Err(@error.out_of_range("percentile: p = " + p.to_string() + " out of [0, 100]"))
  } else {
    let sorted = sort(arr)
    let n = sorted.length()
    if n == 1 {
      Ok(sorted[0])
    } else {
      let idx = p / 100.0 * (n - 1).to_double()
      let lo = floor(idx).to_int()
      let hi = lo + 1
      if hi >= n {
        Ok(sorted[n - 1])
      } else {
        let frac = idx - lo.to_double()
        Ok(sorted[lo] * (1.0 - frac) + sorted[hi] * frac)
      }
    }
  }
}

///|
/// 安全范围生成 / Safe range generation.
pub fn safe_range(n : Int32) -> Result[Array[Int32], @error.DataVerseError] {
  if n < 0 {
    Err(@error.out_of_range("range: n = " + n.to_string() + " < 0"))
  } else {
    let result = []
    for i in 0..<n {
      result.push(i)
    }
    Ok(result)
  }
}

///|
/// 安全 Z 分数 / Safe Z-score.
pub fn safe_zscore(
  x : Double,
  mu : Double,
  sigma : Double,
) -> Result[Double, @error.DataVerseError] {
  if abs(sigma) < 0.0000001 {
    Err(@error.invalid_input("z-score: zero standard deviation"))
  } else {
    Ok((x - mu) / sigma)
  }
}

///|
/// 安全点积 / Safe dot product.
pub fn safe_dot(
  a : Array[Double],
  b : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("dot: length mismatch"))
  } else if a.length() == 0 {
    Err(@error.invalid_input("dot of empty arrays"))
  } else {
    let mut s = 0.0
    for i in 0..<a.length() {
      s += a[i] * b[i]
    }
    Ok(s)
  }
}

///|
/// 安全欧几里得距离 / Safe Euclidean distance.
pub fn safe_distance(
  a : Array[Double],
  b : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("distance: length mismatch"))
  } else if a.length() == 0 {
    Err(@error.invalid_input("distance of empty arrays"))
  } else {
    let mut s = 0.0
    for i in 0..<a.length() {
      let d = a[i] - b[i]
      s += d * d
    }
    Ok(sqrt(s))
  }
}