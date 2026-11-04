///|
/// # extcore/_common/safe — 安全版本函数 / Safe API functions
///
/// 为核心统计/数学函数提供返回 `Result[T, DataVerseError]` 的安全版本。
/// 当输入不满足前置条件时返回错误，而非静默返回默认值。
///
/// ## 安全函数列表
/// | 函数 | 错误条件 |
/// |------|----------|
/// | safe_mean | 空数组 |
/// | safe_std | 空数组 |
/// | safe_variance | 空数组 |
/// | safe_min | 空数组 |
/// | safe_max | 空数组 |
/// | safe_median | 空数组 |
/// | safe_sqrt | 负数 |
/// | safe_log | 零或负数 |
/// | safe_factorial | 负数 |
/// | safe_normalize | 空数组或零方差 |

///|
/// 安全均值 / Safe mean.
pub fn safe_mean(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("mean of empty array"))
  } else {
    Ok(mean(arr))
  }
}

///|
/// 安全标准差 / Safe standard deviation.
pub fn safe_std(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("std of empty array"))
  } else {
    Ok(std(arr))
  }
}

///|
/// 安全方差 / Safe variance.
pub fn safe_variance(
  arr : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("variance of empty array"))
  } else {
    Ok(variance(arr))
  }
}

///|
/// 安全最小值 / Safe min.
pub fn safe_min(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("min of empty array"))
  } else {
    Ok(min(arr))
  }
}

///|
/// 安全最大值 / Safe max.
pub fn safe_max(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("max of empty array"))
  } else {
    Ok(max(arr))
  }
}

///|
/// 安全中位数 / Safe median.
pub fn safe_median(
  arr : Array[Double],
) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("median of empty array"))
  } else {
    Ok(median(arr))
  }
}

///|
/// 安全平方根 / Safe square root.
pub fn safe_sqrt(x : Double) -> Result[Double, @error.DataVerseError] {
  if x < 0.0 {
    Err(@error.out_of_range("sqrt of negative number: " + x.to_string()))
  } else {
    Ok(sqrt(x))
  }
}

///|
/// 安全对数 / Safe logarithm.
pub fn safe_log(x : Double) -> Result[Double, @error.DataVerseError] {
  if x <= 0.0 {
    Err(@error.out_of_range("log of non-positive number: " + x.to_string()))
  } else {
    Ok(log(x))
  }
}

///|
/// 安全阶乘 / Safe factorial.
pub fn safe_factorial(n : Int) -> Result[Double, @error.DataVerseError] {
  if n < 0 {
    Err(@error.out_of_range("factorial of negative number: " + n.to_string()))
  } else if n > 20 {
    Err(@error.out_of_range("factorial too large: " + n.to_string()))
  } else {
    Ok(factorial(n))
  }
}

///|
/// 安全归一化 / Safe normalize.
pub fn safe_normalize(
  arr : Array[Double],
) -> Result[Array[Double], @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("normalize of empty array"))
  } else {
    let s = sum(arr)
    if abs(s) < 0.0000001 {
      Err(@error.invalid_input("normalize: sum is zero"))
    } else {
      Ok(normalize(arr))
    }
  }
}

///|
/// 安全除法 / Safe division.
pub fn safe_div(
  a : Double,
  b : Double,
) -> Result[Double, @error.DataVerseError] {
  if abs(b) < 0.0000001 {
    Err(@error.invalid_input("division by zero"))
  } else {
    Ok(a / b)
  }
}

///|
/// 安全数组索引 / Safe array index.
pub fn safe_index(
  arr : Array[Double],
  i : Int,
) -> Result[Double, @error.DataVerseError] {
  if i < 0 || i >= arr.length() {
    Err(
      @error.out_of_range(
        "index " + i.to_string() + " out of bounds [0, " +
        arr.length().to_string() + ")",
      ),
    )
  } else {
    Ok(arr[i])
  }
}