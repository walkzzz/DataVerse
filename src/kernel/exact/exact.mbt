///|
/// # kernel/exact 确定性精确模式 / Deterministic Exact Mode
///
/// 精确哈希去重、精确统计、Schema 校验的执行模式基座。
/// 一致性保证：逐字节等价。架构 §4.1。
/// S0.2 提供模式标识与契约声明；具体精确哈希算法（SHA-256 等）在 S0.4 算子层填充。
///
/// # Deterministic exact mode
///
/// Base for exact-hash dedup, exact statistics, schema validation.
/// Consistency: byte-exact. See architecture §4.1.
/// S0.2 provides mode tag and contract; concrete hash algorithms (SHA-256 etc.) filled in S0.4.

pub fn exact_id() -> String {
  "kernel/exact"
}

/// 模式标签 / Mode tag string.
pub fn mode_tag() -> String {
  "exact"
}

/// 一致性保证声明 / Consistency guarantee.
pub fn consistency_guarantee() -> String {
  "byte-exact"
}

/// 退化处理：空数据安全 / Degenerate handling: empty data is safe.
pub fn handles_empty() -> Bool {
  true
}