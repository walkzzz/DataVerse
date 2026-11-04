///|
/// # 批量安全 API / Batch Safe API
///
/// 安全函数包装，覆盖数学、数组、字符串、统计等常见操作。

///|
/// safe_abs_diff — 绝对差
pub fn safe_abs_diff(a : Double, b : Double) -> Result[Double, @error.DataVerseError] {
  Ok(if a >= b { a - b } else { b - a })
}

///|
/// safe_avg2 — 两数均值
pub fn safe_avg2(a : Double, b : Double) -> Result[Double, @error.DataVerseError] {
  Ok((a + b) / 2.0)
}

///|
/// safe_neg — 取反
pub fn safe_neg(x : Double) -> Result[Double, @error.DataVerseError] {
  Ok(-x)
}

///|
/// safe_square — 平方
pub fn safe_square(x : Double) -> Result[Double, @error.DataVerseError] {
  Ok(x * x)
}

///|
/// safe_cube — 立方
pub fn safe_cube(x : Double) -> Result[Double, @error.DataVerseError] {
  Ok(x * x * x)
}

///|
/// safe_half — 减半
pub fn safe_half(x : Double) -> Result[Double, @error.DataVerseError] {
  Ok(x / 2.0)
}

///|
/// safe_double_val — 倍增
pub fn safe_double_val(x : Double) -> Result[Double, @error.DataVerseError] {
  Ok(x * 2.0)
}

///|
/// safe_inc — 加一
pub fn safe_inc(x : Double) -> Result[Double, @error.DataVerseError] {
  Ok(x + 1.0)
}

///|
/// safe_dec — 减一
pub fn safe_dec(x : Double) -> Result[Double, @error.DataVerseError] {
  Ok(x - 1.0)
}

///|
/// safe_add3 — 三数之和
pub fn safe_add3(a : Double, b : Double, c : Double) -> Result[Double, @error.DataVerseError] {
  Ok(a + b + c)
}

///|
/// safe_sub3 — 三数之差
pub fn safe_sub3(a : Double, b : Double, c : Double) -> Result[Double, @error.DataVerseError] {
  Ok(a - b - c)
}

///|
/// safe_mul3 — 三数之积
pub fn safe_mul3(a : Double, b : Double, c : Double) -> Result[Double, @error.DataVerseError] {
  Ok(a * b * c)
}

///|
/// safe_min3 — 三数最小
pub fn safe_min3(a : Double, b : Double, c : Double) -> Result[Double, @error.DataVerseError] {
  let m = if a < b { a } else { b }
  Ok(if m < c { m } else { c })
}

///|
/// safe_max3 — 三数最大
pub fn safe_max3(a : Double, b : Double, c : Double) -> Result[Double, @error.DataVerseError] {
  let m = if a > b { a } else { b }
  Ok(if m > c { m } else { c })
}

///|
/// safe_midval — 中值
pub fn safe_midval(lo : Double, hi : Double) -> Result[Double, @error.DataVerseError] {
  Ok((lo + hi) / 2.0)
}

///|
/// safe_range_val — 范围宽度
pub fn safe_range_val(lo : Double, hi : Double) -> Result[Double, @error.DataVerseError] {
  if hi < lo {
    Err(@error.invalid_input("hi < lo"))
  } else {
    Ok(hi - lo)
  }
}

///|
/// safe_deg2rad — 度转弧度
pub fn safe_deg2rad(deg : Double) -> Result[Double, @error.DataVerseError] {
  Ok(deg * 3.141592653589793 / 180.0)
}

///|
/// safe_rad2deg — 弧度转度
pub fn safe_rad2deg(rad : Double) -> Result[Double, @error.DataVerseError] {
  Ok(rad * 180.0 / 3.141592653589793)
}

///|
/// safe_hypot2 — 平方和
pub fn safe_hypot2(a : Double, b : Double) -> Result[Double, @error.DataVerseError] {
  Ok(a * a + b * b)
}

///|
/// safe_int_abs — 整数绝对值
pub fn safe_int_abs(x : Int) -> Result[Int, @error.DataVerseError] {
  Ok(if x < 0 { -x } else { x })
}

///|
/// safe_int_sign — 整数符号
pub fn safe_int_sign(x : Int) -> Result[Int, @error.DataVerseError] {
  Ok(if x > 0 { 1 } else if x < 0 { -1 } else { 0 })
}

///|
/// safe_int_min — 整数最小
pub fn safe_int_min(a : Int, b : Int) -> Result[Int, @error.DataVerseError] {
  Ok(if a < b { a } else { b })
}

///|
/// safe_int_max — 整数最大
pub fn safe_int_max(a : Int, b : Int) -> Result[Int, @error.DataVerseError] {
  Ok(if a > b { a } else { b })
}

///|
/// safe_int_avg — 整数均值
pub fn safe_int_avg(a : Int, b : Int) -> Result[Int, @error.DataVerseError] {
  Ok((a + b) / 2)
}

///|
/// safe_int_pow — 整数幂
pub fn safe_int_pow(base : Int, exp : Int) -> Result[Int, @error.DataVerseError] {
  if exp < 0 {
    Err(@error.out_of_range("negative exp"))
  } else {
    let mut r = 1
    for _ in 0..<exp {
      r *= base
    }
    Ok(r)
  }
}

///|
/// safe_int_mod — 整数取模
pub fn safe_int_mod(a : Int, b : Int) -> Result[Int, @error.DataVerseError] {
  if b == 0 {
    Err(@error.invalid_input("division by zero"))
  } else {
    Ok(a % b)
  }
}

///|
/// safe_int_div — 整数除法
pub fn safe_int_div(a : Int, b : Int) -> Result[Int, @error.DataVerseError] {
  if b == 0 {
    Err(@error.invalid_input("division by zero"))
  } else {
    Ok(a / b)
  }
}

///|
/// safe_factorial_small — 小整数阶乘
pub fn safe_factorial_small(n : Int) -> Result[Int, @error.DataVerseError] {
  if n < 0 || n > 20 {
    Err(@error.out_of_range("factorial: 0..20 only"))
  } else {
    let mut r = 1
    for i in 1..=n {
      r *= i
    }
    Ok(r)
  }
}

///|
/// safe_perm — 排列数
pub fn safe_perm(n : Int, k : Int) -> Result[Int, @error.DataVerseError] {
  if n < 0 || k < 0 || k > n {
    Err(@error.out_of_range("invalid perm args"))
  } else {
    let mut r = 1
    for i in 0..<k {
      r *= (n - i)
    }
    Ok(r)
  }
}

///|
/// safe_comb — 组合数
pub fn safe_comb(n : Int, k : Int) -> Result[Int, @error.DataVerseError] {
  if n < 0 || k < 0 || k > n {
    Err(@error.out_of_range("invalid comb args"))
  } else {
    let mut r = 1
    for i in 0..<k {
      r = r * (n - i) / (i + 1)
    }
    Ok(r)
  }
}

///|
/// safe_arr_sum — 数组求和
pub fn safe_arr_sum(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  let mut s = 0.0
  for i in 0..<arr.length() {
    s += arr[i]
  }
  Ok(s)
}

///|
/// safe_arr_product — 数组求积
pub fn safe_arr_product(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  let mut p = 1.0
  for i in 0..<arr.length() {
    p *= arr[i]
  }
  Ok(p)
}

///|
/// safe_arr_min — 数组最小值
pub fn safe_arr_min(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    let mut m = arr[0]
    for i in 1..<arr.length() {
      if arr[i] < m {
        m = arr[i]
      }
    }
    Ok(m)
  }
}

///|
/// safe_arr_max — 数组最大值
pub fn safe_arr_max(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    let mut m = arr[0]
    for i in 1..<arr.length() {
      if arr[i] > m {
        m = arr[i]
      }
    }
    Ok(m)
  }
}

///|
/// safe_arr_range — 数组极差
pub fn safe_arr_range(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    let mut lo = arr[0]
    let mut hi = arr[0]
    for i in 1..<arr.length() {
      if arr[i] < lo {
        lo = arr[i]
      }
      if arr[i] > hi {
        hi = arr[i]
      }
    }
    Ok(hi - lo)
  }
}

///|
/// safe_arr_len — 数组长度
pub fn safe_arr_len(arr : Array[Double]) -> Result[Int, @error.DataVerseError] {
  Ok(arr.length())
}

///|
/// safe_arr_is_empty — 数组是否为空
pub fn safe_arr_is_empty(arr : Array[Double]) -> Result[Bool, @error.DataVerseError] {
  Ok(arr.length() == 0)
}

///|
/// safe_arr_all_pos — 全正
pub fn safe_arr_all_pos(arr : Array[Double]) -> Result[Bool, @error.DataVerseError] {
  let mut ok = true
  for i in 0..<arr.length() {
    if arr[i] <= 0.0 {
      ok = false
    }
  }
  Ok(ok)
}

///|
/// safe_arr_all_neg — 全负
pub fn safe_arr_all_neg(arr : Array[Double]) -> Result[Bool, @error.DataVerseError] {
  let mut ok = true
  for i in 0..<arr.length() {
    if arr[i] >= 0.0 {
      ok = false
    }
  }
  Ok(ok)
}

///|
/// safe_arr_count_pos — 正数计数
pub fn safe_arr_count_pos(arr : Array[Double]) -> Result[Int, @error.DataVerseError] {
  let mut c = 0
  for i in 0..<arr.length() {
    if arr[i] > 0.0 {
      c += 1
    }
  }
  Ok(c)
}

///|
/// safe_arr_count_neg — 负数计数
pub fn safe_arr_count_neg(arr : Array[Double]) -> Result[Int, @error.DataVerseError] {
  let mut c = 0
  for i in 0..<arr.length() {
    if arr[i] < 0.0 {
      c += 1
    }
  }
  Ok(c)
}

///|
/// safe_arr_count_zero — 零值计数
pub fn safe_arr_count_zero(arr : Array[Double]) -> Result[Int, @error.DataVerseError] {
  let mut c = 0
  for i in 0..<arr.length() {
    if arr[i] == 0.0 {
      c += 1
    }
  }
  Ok(c)
}

///|
/// safe_int_arr_sum — 整数数组求和
pub fn safe_int_arr_sum(arr : Array[Int]) -> Result[Int, @error.DataVerseError] {
  let mut s = 0
  for i in 0..<arr.length() {
    s += arr[i]
  }
  Ok(s)
}

///|
/// safe_int_arr_min — 整数数组最小
pub fn safe_int_arr_min(arr : Array[Int]) -> Result[Int, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    let mut m = arr[0]
    for i in 1..<arr.length() {
      if arr[i] < m {
        m = arr[i]
      }
    }
    Ok(m)
  }
}

///|
/// safe_int_arr_max — 整数数组最大
pub fn safe_int_arr_max(arr : Array[Int]) -> Result[Int, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    let mut m = arr[0]
    for i in 1..<arr.length() {
      if arr[i] > m {
        m = arr[i]
      }
    }
    Ok(m)
  }
}

///|
/// safe_int_arr_product — 整数数组求积
pub fn safe_int_arr_product(arr : Array[Int]) -> Result[Int, @error.DataVerseError] {
  let mut p = 1
  for i in 0..<arr.length() {
    p *= arr[i]
  }
  Ok(p)
}

///|
/// safe_arr_get — 安全索引
pub fn safe_arr_get(arr : Array[Double], idx : Int) -> Result[Double, @error.DataVerseError] {
  if idx < 0 || idx >= arr.length() {
    Err(@error.out_of_range("index out of bounds"))
  } else {
    Ok(arr[idx])
  }
}

///|
/// safe_arr_head — 首元素
pub fn safe_arr_head(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    Ok(arr[0])
  }
}

///|
/// safe_arr_tail — 末元素
pub fn safe_arr_tail(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    Ok(arr[arr.length() - 1])
  }
}

///|
/// safe_arr_dot — 点积
pub fn safe_arr_dot(a : Array[Double], b : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("dimension mismatch"))
  } else {
    let mut s = 0.0
    for i in 0..<a.length() {
      s += a[i] * b[i]
    }
    Ok(s)
  }
}

///|
/// safe_arr_l1_dist — L1 距离
pub fn safe_arr_l1_dist(a : Array[Double], b : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("dimension mismatch"))
  } else {
    let mut s = 0.0
    for i in 0..<a.length() {
      let d = a[i] - b[i]
      s += if d < 0.0 { -d } else { d }
    }
    Ok(s)
  }
}

///|
/// safe_arr_l2_dist — L2 距离
pub fn safe_arr_l2_dist(a : Array[Double], b : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("dimension mismatch"))
  } else {
    let mut s = 0.0
    for i in 0..<a.length() {
      s += (a[i] - b[i]) * (a[i] - b[i])
    }
    Ok(sqrt(s))
  }
}

///|
/// safe_arr_scale — 数组缩放
pub fn safe_arr_scale(arr : Array[Double], s : Double) -> Result[Array[Double], @error.DataVerseError] {
  let r = []
  for i in 0..<arr.length() {
    r.push(arr[i] * s)
  }
  Ok(r)
}

///|
/// safe_arr_offset — 数组偏移
pub fn safe_arr_offset(arr : Array[Double], c : Double) -> Result[Array[Double], @error.DataVerseError] {
  let r = []
  for i in 0..<arr.length() {
    r.push(arr[i] + c)
  }
  Ok(r)
}

///|
/// safe_arr_add — 数组加法
pub fn safe_arr_add(a : Array[Double], b : Array[Double]) -> Result[Array[Double], @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("dimension mismatch"))
  } else {
    let r = []
    for i in 0..<a.length() {
      r.push(a[i] + b[i])
    }
    Ok(r)
  }
}

///|
/// safe_arr_sub — 数组减法
pub fn safe_arr_sub(a : Array[Double], b : Array[Double]) -> Result[Array[Double], @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("dimension mismatch"))
  } else {
    let r = []
    for i in 0..<a.length() {
      r.push(a[i] - b[i])
    }
    Ok(r)
  }
}

///|
/// safe_arr_mul — 数组逐元素乘
pub fn safe_arr_mul(a : Array[Double], b : Array[Double]) -> Result[Array[Double], @error.DataVerseError] {
  if a.length() != b.length() {
    Err(@error.dimension_mismatch("dimension mismatch"))
  } else {
    let r = []
    for i in 0..<a.length() {
      r.push(a[i] * b[i])
    }
    Ok(r)
  }
}

///|
/// safe_sum_squares — 平方和
pub fn safe_sum_squares(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  let mut s = 0.0
  for i in 0..<arr.length() {
    s += arr[i] * arr[i]
  }
  Ok(s)
}

///|
/// safe_str_len — 字符串长度
pub fn safe_str_len(s : String) -> Result[Int, @error.DataVerseError] {
  Ok(s.length())
}

///|
/// safe_str_is_empty — 字符串是否为空
pub fn safe_str_is_empty(s : String) -> Result[Bool, @error.DataVerseError] {
  Ok(s.length() == 0)
}

///|
/// safe_str_concat — 字符串拼接
pub fn safe_str_concat(a : String, b : String) -> Result[String, @error.DataVerseError] {
  Ok(a + b)
}

///|
/// safe_str_contains — 包含子串
pub fn safe_str_contains(s : String, sub : String) -> Result[Bool, @error.DataVerseError] {
  Ok(s.contains(sub))
}

///|
/// safe_str_starts — 前缀匹配
pub fn safe_str_starts(s : String, prefix : String) -> Result[Bool, @error.DataVerseError] {
  Ok(s.has_prefix(prefix))
}

///|
/// safe_str_ends — 后缀匹配
pub fn safe_str_ends(s : String, suffix : String) -> Result[Bool, @error.DataVerseError] {
  Ok(s.has_suffix(suffix))
}

///|
/// safe_str_upper — 转大写
pub fn safe_str_upper(s : String) -> Result[String, @error.DataVerseError] {
  Ok(s.to_upper())
}

///|
/// safe_str_lower — 转小写
pub fn safe_str_lower(s : String) -> Result[String, @error.DataVerseError] {
  Ok(s.to_lower())
}

///|

/// safe_arr_mean — 数组均值
pub fn safe_arr_mean(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    let mut s = 0.0
    for i in 0..<arr.length() {
      s += arr[i]
    }
    Ok(s / arr.length().to_double())
  }
}

///|
/// safe_arr_var — 方差
pub fn safe_arr_var(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    let mut s = 0.0
    for i in 0..<arr.length() {
      s += arr[i]
    }
    let m = s / arr.length().to_double()
    let mut v = 0.0
    for i in 0..<arr.length() {
      v += (arr[i] - m) * (arr[i] - m)
    }
    Ok(v / arr.length().to_double())
  }
}

///|
/// safe_arr_std — 标准差
pub fn safe_arr_std(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("empty input"))
  } else {
    let mut s = 0.0
    for i in 0..<arr.length() {
      s += arr[i]
    }
    let m = s / arr.length().to_double()
    let mut v = 0.0
    for i in 0..<arr.length() {
      v += (arr[i] - m) * (arr[i] - m)
    }
    Ok(sqrt(v / arr.length().to_double()))
  }
}

///|
/// safe_error_rate — 错误率
pub fn safe_error_rate(errors : Int, total : Int) -> Result[Double, @error.DataVerseError] {
  if total == 0 {
    Err(@error.invalid_input("division by zero"))
  } else {
    Ok(errors.to_double() / total.to_double())
  }
}

///|
/// safe_accuracy_rate — 准确率
pub fn safe_accuracy_rate(correct : Int, total : Int) -> Result[Double, @error.DataVerseError] {
  if total == 0 {
    Err(@error.invalid_input("division by zero"))
  } else {
    Ok(correct.to_double() / total.to_double())
  }
}

///|
/// safe_margin — 误差
pub fn safe_margin(actual : Double, predicted : Double) -> Result[Double, @error.DataVerseError] {
  Ok(actual - predicted)
}

///|
/// safe_margin_pct — 百分比误差
pub fn safe_margin_pct(actual : Double, predicted : Double) -> Result[Double, @error.DataVerseError] {
  if actual == 0.0 {
    Err(@error.invalid_input("division by zero"))
  } else {
    Ok((actual - predicted) / actual * 100.0)
  }
}

///|
/// safe_ape — 绝对百分比误差
pub fn safe_ape(actual : Double, predicted : Double) -> Result[Double, @error.DataVerseError] {
  if actual == 0.0 {
    Err(@error.invalid_input("division by zero"))
  } else {
    let d = (actual - predicted) / actual * 100.0
    Ok(if d < 0.0 { -d } else { d })
  }
}