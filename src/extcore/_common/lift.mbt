///|
/// # extcore/_common/lift — 通用 lift 高阶函数 / Generic Lift HOFs
///
/// 提取安全函数中重复的检查模式，消除大量重复代码。
///
/// ## 模式
/// - `lift_nonempty` — 检查数组非空后调用 f
/// - `lift_same_len` — 检查双数组长度匹配后调用 f
/// - `lift_ok` — 简单包装 Ok(f(...))
/// - `check_nonempty` — 检查非空
/// - `check_same_len` — 检查长度匹配
/// - `check_nonzero` — 检查非零

// ============================================================================
// check 系列 — 返回 Result[Unit, Error] / Check Helpers
// ============================================================================

///|
/// 检查数组非空 / Check array is non-empty.
pub fn[T] check_nonempty(
  arr : Array[T],
  fname : String,
) -> Result[Unit, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input(fname + " of empty array"))
  } else {
    Ok(())
  }
}

///|
/// 检查双数组长度匹配 / Check two arrays have same length.
pub fn[T] check_same_len(
  a : Array[T],
  b : Array[T],
  fname : String,
) -> Result[Unit, @error.DataVerseError] {
  if a.length() == 0 || b.length() == 0 {
    Err(@error.invalid_input(fname + " of empty array"))
  } else if a.length() != b.length() {
    Err(@error.dimension_mismatch(fname + ": length mismatch"))
  } else {
    Ok(())
  }
}

///|
/// 检查除数非零 / Check divisor is non-zero.
pub fn check_nonzero(
  b : Double,
  fname : String,
) -> Result[Unit, @error.DataVerseError] {
  if abs(b) < 0.0000001 {
    Err(@error.invalid_input(fname + ": division by zero"))
  } else {
    Ok(())
  }
}

///|
/// 检查值非负 / Check value is non-negative.
pub fn check_nonneg(
  x : Double,
  fname : String,
) -> Result[Unit, @error.DataVerseError] {
  if x < 0.0 {
    Err(@error.out_of_range(fname + " of negative number"))
  } else {
    Ok(())
  }
}

///|
/// 检查值为正 / Check value is positive.
pub fn check_positive(
  x : Double,
  fname : String,
) -> Result[Unit, @error.DataVerseError] {
  if x <= 0.0 {
    Err(@error.out_of_range(fname + " of non-positive number"))
  } else {
    Ok(())
  }
}

// ============================================================================
// lift 系列 — 检查后调用 f 并包装 Ok / Lift Helpers
// ============================================================================

///|
/// 检查数组非空后调用 f / Lift f with non-empty array check.
pub fn[T, U] lift_nonempty(
  arr : Array[T],
  fname : String,
  f : (Array[T]) -> U,
) -> Result[U, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input(fname + " of empty array"))
  } else {
    Ok(f(arr))
  }
}

///|
/// 检查双数组长度匹配后调用 f / Lift f with same-length check.
pub fn[T, U] lift_same_len(
  a : Array[T],
  b : Array[T],
  fname : String,
  f : (Array[T], Array[T]) -> U,
) -> Result[U, @error.DataVerseError] {
  if a.length() == 0 || b.length() == 0 {
    Err(@error.invalid_input(fname + " of empty array"))
  } else if a.length() != b.length() {
    Err(@error.dimension_mismatch(fname + ": length mismatch"))
  } else {
    Ok(f(a, b))
  }
}

///|
/// 简单包装 Ok(f(x)) / Lift a pure function into Result.
pub fn[T, U] lift_ok(
  x : T,
  f : (T) -> U,
) -> Result[U, @error.DataVerseError] {
  Ok(f(x))
}

///|
/// 简单包装 Ok(f(a, b)) / Lift a pure binary function into Result.
pub fn[T, S, U] lift_ok2(
  a : T,
  b : S,
  f : (T, S) -> U,
) -> Result[U, @error.DataVerseError] {
  Ok(f(a, b))
}