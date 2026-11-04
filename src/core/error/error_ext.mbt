///|
/// # core/error/error_ext — 扩展错误处理 / Extended Error Handling
///
/// 使用 MoonBit 现代错误处理机制（suberror + raise + try/catch），
/// 补充现有的 `Result[T, DataVerseError]` 模式。
///
/// ## 特性
/// - `suberror` 定义的具体错误类型，可自动提升为 `Error`
/// - `raise` 版本的核心操作函数
/// - `try/catch` 错误捕获工具
/// - `Result` ↔ `raise` 双向转换
/// - 错误多态高阶函数（`raise?`）

// ============================================================================
// suberror 错误类型定义 / Suberror Type Definitions
// ============================================================================

///|
/// 输入验证错误 / Input validation error.
suberror InputError {
  InputError(String)
} derive(Debug, Eq)

///|
pub extend InputError with Eq::{equal, not_equal}

///|
pub extend InputError with Debug::{to_repr}

///|
/// 范围越界错误 / Out of range error.
suberror RangeError {
  RangeError(String)
} derive(Debug, Eq)

///|
pub extend RangeError with Eq::{equal, not_equal}

///|
pub extend RangeError with Debug::{to_repr}

///|
/// 维度不匹配错误 / Dimension mismatch error.
suberror DimError {
  DimError(String)
} derive(Debug, Eq)

///|
pub extend DimError with Eq::{equal, not_equal}

///|
pub extend DimError with Debug::{to_repr}

///|
/// 收敛失败错误 / Convergence failure error.
suberror ConvergenceError {
  ConvergenceError(String)
} derive(Debug, Eq)

///|
pub extend ConvergenceError with Eq::{equal, not_equal}

///|
pub extend ConvergenceError with Debug::{to_repr}

///|
/// 操作不支持错误 / Not supported error.
suberror SupportError {
  SupportError(String)
} derive(Debug, Eq)

///|
pub extend SupportError with Eq::{equal, not_equal}

///|
pub extend SupportError with Debug::{to_repr}

// ============================================================================
// suberror 构造函数 / Suberror Constructors
// ============================================================================

///|
/// 构造输入错误 / Construct an input error.
pub fn make_input_error(msg : String) -> InputError {
  InputError(msg)
}

///|
/// 构造范围错误 / Construct a range error.
pub fn make_range_error(msg : String) -> RangeError {
  RangeError(msg)
}

///|
/// 构造维度错误 / Construct a dimension error.
pub fn make_dim_error(msg : String) -> DimError {
  DimError(msg)
}

///|
/// 构造收敛错误 / Construct a convergence error.
pub fn make_convergence_error(msg : String) -> ConvergenceError {
  ConvergenceError(msg)
}

///|
/// 构造不支持错误 / Construct a support error.
pub fn make_support_error(msg : String) -> SupportError {
  SupportError(msg)
}

// ============================================================================
// raise 版本的核心操作 / Raising Versions of Core Operations
// ============================================================================

///|
/// 安全除法（raise 版本）/ Safe division (raising version).
pub fn raise_div(x : Double, y : Double) -> Double raise RangeError {
  if y == 0.0 {
    raise RangeError("division by zero")
  }
  x / y
}

///|
/// 安全整数除法（raise 版本）/ Safe integer division (raising version).
pub fn raise_int_div(x : Int, y : Int) -> Int raise RangeError {
  if y == 0 {
    raise RangeError("integer division by zero")
  }
  x / y
}

///|
/// 安全取模（raise 版本）/ Safe modulo (raising version).
pub fn raise_mod(x : Int, y : Int) -> Int raise RangeError {
  if y == 0 {
    raise RangeError("modulo by zero")
  }
  x % y
}

///|
/// 安全平方根（raise 版本）/ Safe square root (raising version).
pub fn raise_sqrt(x : Double) -> Double raise RangeError {
  if x < 0.0 {
    raise RangeError("sqrt of negative number")
  }
  x.sqrt()
}

///|
/// 安全对数（raise 版本）/ Safe logarithm (raising version).
pub fn raise_log(x : Double) -> Double raise RangeError {
  if x <= 0.0 {
    raise RangeError("log of non-positive number")
  }
  @math.ln(x)
}

///|
/// 安全数组索引（raise 版本）/ Safe array index (raising version).
pub fn[T] raise_arr_get(arr : Array[T], idx : Int) -> T raise RangeError {
  if idx < 0 || idx >= arr.length() {
    raise RangeError("index \{idx} out of bounds [0, \{arr.length()})")
  }
  arr[idx]
}

///|
/// 安全数组头部（raise 版本）/ Safe array head (raising version).
pub fn[T] raise_arr_head(arr : Array[T]) -> T raise InputError {
  if arr.length() == 0 {
    raise InputError("empty array has no head")
  }
  arr[0]
}

///|
/// 安全数组尾部（raise 版本）/ Safe array tail (raising version).
pub fn[T] raise_arr_tail(arr : Array[T]) -> T raise InputError {
  if arr.length() == 0 {
    raise InputError("empty array has no tail")
  }
  arr[arr.length() - 1]
}

// ============================================================================
// Result ↔ raise 双向转换 / Result ↔ raise Conversion
// ============================================================================

///|
/// 将 raise 函数转换为 Result / Convert a raising function to Result.
pub fn[T] to_result(f : () -> T raise RangeError) -> Result[T, DataVerseError] {
  try Ok(f()) catch {
    RangeError(msg) => Err(OutOfRange(msg))
  }
}

///|
/// 将 raise 函数转换为 Result（InputError 版本）.
pub fn[T] to_result_input(f : () -> T raise InputError) -> Result[T, DataVerseError] {
  try Ok(f()) catch {
    InputError(msg) => Err(InvalidInput(msg))
  }
}

///|
/// 将 raise 函数转换为 Result（DimError 版本）.
pub fn[T] to_result_dim(f : () -> T raise DimError) -> Result[T, DataVerseError] {
  try Ok(f()) catch {
    DimError(msg) => Err(DimensionMismatch(msg))
  }
}

///|
/// 将 raise 函数转换为 Result（ConvergenceError 版本）.
pub fn[T] to_result_conv(
  f : () -> T raise ConvergenceError,
) -> Result[T, DataVerseError] {
  try Ok(f()) catch {
    ConvergenceError(msg) => Err(ConvergenceFailure(msg))
  }
}

///|
/// 将 raise 函数转换为 Result（SupportError 版本）.
pub fn[T] to_result_support(
  f : () -> T raise SupportError,
) -> Result[T, DataVerseError] {
  try Ok(f()) catch {
    SupportError(msg) => Err(NotSupported(msg))
  }
}

///|
/// 将 Result[T, DataVerseError] 解包或抛出错误 / Unwrap Result or raise.
pub fn[T] unwrap_or_raise(
  r : Result[T, DataVerseError],
) -> T raise Failure {
  match r {
    Ok(v) => v
    Err(e) => fail(format_error(e))
  }
}

///|
/// 从 DataVerseError 创建 Result 错误 / Create error Result.
pub fn[T] err_result(msg : String) -> Result[T, DataVerseError] {
  Err(InvalidInput(msg))
}

// ============================================================================
// 错误多态高阶函数 / Error-Polymorphic Higher-Order Functions
// ============================================================================

///|
/// 错误多态 map / Error-polymorphic map.
pub fn[T] map_raise(
  arr : Array[T],
  f : (T) -> T raise?,
) -> Array[T] raise? {
  let res = []
  for x in arr {
    res.push(f(x))
  }
  res
}

///|
/// 错误多态 filter / Error-polymorphic filter.
pub fn[T] filter_raise(
  arr : Array[T],
  pred : (T) -> Bool raise?,
) -> Array[T] raise? {
  let res = []
  for x in arr {
    if pred(x) {
      res.push(x)
    }
  }
  res
}

///|
/// 错误多态 fold / Error-polymorphic fold.
pub fn[T, A] fold_raise(
  arr : Array[T],
  init : A,
  f : (A, T) -> A raise?,
) -> A raise? {
  let mut acc = init
  for x in arr {
    acc = f(acc, x)
  }
  acc
}

///|
/// 错误多态 for_each / Error-polymorphic for_each.
pub fn[T] for_each_raise(arr : Array[T], f : (T) -> Unit raise?) -> Unit raise? {
  for x in arr {
    f(x)
  }
}

// ============================================================================
// try/catch 工具函数 / try/catch Utilities
// ============================================================================

///|
/// 捕获 RangeError 并返回默认值 / Catch RangeError and return default.
pub fn[T] catch_range_default(
  f : () -> T raise RangeError,
  default : T,
) -> T {
  try f() catch {
    RangeError(_) => default
  }
}

///|
/// 捕获 InputError 并返回默认值 / Catch InputError and return default.
pub fn[T] catch_input_default(
  f : () -> T raise InputError,
  default : T,
) -> T {
  try f() catch {
    InputError(_) => default
  }
}

///|
/// 捕获 RangeError 并记录错误 / Catch RangeError and log.
pub fn[T] catch_range_log(
  f : () -> T raise RangeError,
  on_error : (String) -> Unit,
) -> Option[T] {
  try Some(f()) catch {
    RangeError(msg) => {
      on_error(msg)
      None
    }
  }
}

///|
/// 链式错误处理 / Chained error handling.
pub fn[T, U] and_then(
  r : Result[T, DataVerseError],
  f : (T) -> Result[U, DataVerseError],
) -> Result[U, DataVerseError] {
  match r {
    Ok(v) => f(v)
    Err(e) => Err(e)
  }
}

///|
/// 错误映射 / Map error.
pub fn[T, U] map_ok(
  r : Result[T, DataVerseError],
  f : (T) -> U,
) -> Result[U, DataVerseError] {
  match r {
    Ok(v) => Ok(f(v))
    Err(e) => Err(e)
  }
}

///|
/// 错误恢复 / Recover from error.
pub fn[T] recover(
  r : Result[T, DataVerseError],
  f : (DataVerseError) -> T,
) -> T {
  match r {
    Ok(v) => v
    Err(e) => f(e)
  }
}

///|
/// 组合多个 Result / Combine multiple Results.
pub fn[T, U] combine(
  r1 : Result[T, DataVerseError],
  r2 : Result[U, DataVerseError],
) -> Result[(T, U), DataVerseError] {
  match r1 {
    Ok(v1) => {
      match r2 {
        Ok(v2) => Ok((v1, v2))
        Err(e) => Err(e)
      }
    }
    Err(e) => Err(e)
  }
}

///|
/// 收集所有 Result / Collect all Results (fail on first error).
pub fn[T] collect_all(
  arr : Array[Result[T, DataVerseError]],
) -> Result[Array[T], DataVerseError] {
  let result = []
  for i in 0..<arr.length() {
    match arr[i] {
      Ok(v) => result.push(v)
      Err(e) => return Err(e)
    }
  }
  Ok(result)
}