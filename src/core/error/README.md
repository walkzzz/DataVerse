# core/error — 统一错误处理

定义 `DataVerseError` 统一错误类型，核心 API 返回 `Result[T, DataVerseError]`。

## 错误分类

| 错误码 | 变体 | 含义 |
|--------|------|------|
| E001 | `InvalidInput(String)` | 输入参数无效 |
| E002 | `OutOfRange(String)` | 值超出有效范围 |
| E003 | `DimensionMismatch(String)` | 维度不匹配 |
| E004 | `ConvergenceFailure(String)` | 迭代未收敛 |
| E005 | `NotSupported(String)` | 操作不支持 |
| E999 | `Internal(String)` | 内部错误 |

## API

| 函数 | 说明 |
|------|------|
| `error_code(err) -> String` | 错误码 |
| `error_message(err) -> String` | 完整错误消息 |
| `error_detail(err) -> String` | 错误详情 |
| `format_error(err) -> String` | 带错误码的格式化 |
| `is_recoverable(err) -> Bool` | 是否可恢复 |
| `invalid_input(msg)` | 构造 InvalidInput |
| `out_of_range(msg)` | 构造 OutOfRange |
| `dimension_mismatch(msg)` | 构造 DimensionMismatch |
| `convergence_failure(msg)` | 构造 ConvergenceFailure |
| `not_supported(msg)` | 构造 NotSupported |
| `internal_error(msg)` | 构造 Internal |
| `lift_string_result(r)` | 将 `Result[T, String]` 提升为 `Result[T, DataVerseError]` |

## 使用方式

```moonbit
pub fn safe_mean(arr : Array[Double]) -> Result[Double, @error.DataVerseError] {
  if arr.length() == 0 {
    Err(@error.invalid_input("mean of empty array"))
  } else {
    Ok(mean(arr))
  }
}
```