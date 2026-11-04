///|
/// # core/error — 统一错误处理 / Unified Error Handling
///
/// 定义 `DataVerseError` 统一错误类型，核心 API 返回 `Result[T, DataVerseError]`。
///
/// ## 错误分类
/// | 错误码 | 变体 | 含义 |
/// |--------|------|------|
/// | E001 | InvalidInput | 输入参数无效 |
/// | E002 | OutOfRange | 值超出有效范围 |
/// | E003 | DimensionMismatch | 维度不匹配 |
/// | E004 | ConvergenceFailure | 迭代未收敛 |
/// | E005 | NotSupported | 操作不支持 |
/// | E999 | Internal | 内部错误 |

///|
/// 统一错误类型 / Unified error type.
pub(all) enum DataVerseError {
  InvalidInput(String)
  OutOfRange(String)
  DimensionMismatch(String)
  ConvergenceFailure(String)
  NotSupported(String)
  Internal(String)
} derive(Debug, Eq)

///|
pub extend DataVerseError with Eq::{equal, not_equal}

///|
pub extend DataVerseError with Debug::{to_repr}

///|
/// 错误码 / Error code.
pub fn error_code(err : DataVerseError) -> String {
  match err {
    InvalidInput(_) => "E001"
    OutOfRange(_) => "E002"
    DimensionMismatch(_) => "E003"
    ConvergenceFailure(_) => "E004"
    NotSupported(_) => "E005"
    Internal(_) => "E999"
  }
}

///|
/// 错误消息 / Error message (full).
pub fn error_message(err : DataVerseError) -> String {
  match err {
    InvalidInput(msg) => "InvalidInput: " + msg
    OutOfRange(msg) => "OutOfRange: " + msg
    DimensionMismatch(msg) => "DimensionMismatch: " + msg
    ConvergenceFailure(msg) => "ConvergenceFailure: " + msg
    NotSupported(msg) => "NotSupported: " + msg
    Internal(msg) => "Internal: " + msg
  }
}

///|
/// 错误详情 / Error detail (inner message only).
pub fn error_detail(err : DataVerseError) -> String {
  match err {
    InvalidInput(msg) => msg
    OutOfRange(msg) => msg
    DimensionMismatch(msg) => msg
    ConvergenceFailure(msg) => msg
    NotSupported(msg) => msg
    Internal(msg) => msg
  }
}

///|
/// 构造 InvalidInput 错误 / Create InvalidInput error.
pub fn invalid_input(msg : String) -> DataVerseError {
  InvalidInput(msg)
}

///|
/// 构造 OutOfRange 错误 / Create OutOfRange error.
pub fn out_of_range(msg : String) -> DataVerseError {
  OutOfRange(msg)
}

///|
/// 构造 DimensionMismatch 错误 / Create DimensionMismatch error.
pub fn dimension_mismatch(msg : String) -> DataVerseError {
  DimensionMismatch(msg)
}

///|
/// 构造 ConvergenceFailure 错误 / Create ConvergenceFailure error.
pub fn convergence_failure(msg : String) -> DataVerseError {
  ConvergenceFailure(msg)
}

///|
/// 构造 NotSupported 错误 / Create NotSupported error.
pub fn not_supported(msg : String) -> DataVerseError {
  NotSupported(msg)
}

///|
/// 构造 Internal 错误 / Create Internal error.
pub fn internal_error(msg : String) -> DataVerseError {
  Internal(msg)
}

///|
/// 将 Result[T, String] 提升为 Result[T, DataVerseError] / Lift string error.
pub fn[T] lift_string_result(
  r : Result[T, String],
) -> Result[T, DataVerseError] {
  match r {
    Ok(v) => Ok(v)
    Err(msg) => Err(Internal(msg))
  }
}

///|
/// 将 DataVerseError 格式化为带错误码的字符串 / Format error with code.
pub fn format_error(err : DataVerseError) -> String {
  error_code(err) + ": " + error_message(err)
}

///|
/// 判断是否为可恢复错误 / Check if error is recoverable.
pub fn is_recoverable(err : DataVerseError) -> Bool {
  match err {
    Internal(_) => false
    _ => true
  }
}