///|
/// # kernel 算子执行内核 / Operator Execution Kernel
///
/// 四模式执行内核：确定性精确 / 近似概率 / 流式 / 缓存增量。
/// 对标 GeoVerse 的四种数值模式。架构 §4.1。
/// S0.1 骨架占位，S0.2 填充四模式实现。
///
/// # Operator execution kernel
///
/// Four execution modes: exact / approx / streaming / cache.
/// See architecture §4.1. S0.2 fills the implementations.
pub fn kernel_id() -> String {
  "kernel"
}