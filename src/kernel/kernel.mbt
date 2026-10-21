///|
/// # kernel 算子执行内核 / Operator Execution Kernel
///
/// 四模式执行内核：确定性精确 / 近似概率 / 流式 / 缓存增量。
/// 架构 §4.1。S0.2 实现模式框架 + 一致性契约 + 子包聚合。
///
/// 依赖方向：kernel 根包 import 四模式子包（聚合），子包不 import kernel 根（无循环依赖）。
/// 共享类型 `ExecMode` / `Consistency` 定义在本包，子包通过 `mode_tag` 字符串与根包交互。
///
/// # Operator execution kernel
///
/// Four execution modes: exact / approx / streaming / cache.
/// See architecture §4.1. S0.2 implements mode framework + consistency contract + aggregation.
///
/// Dependency: kernel root imports four mode sub-packages (aggregation);
/// sub-packages do not import kernel root (no cycle).
/// Shared types `ExecMode` / `Consistency` live here; sub-packages interact via `mode_tag` strings.

///|
/// 执行模式 / Execution mode.
///
/// - `Exact`：确定性精确，逐字节等价
/// - `Approx(seed)`：近似概率，固定种子保证可复现
/// - `Streaming`：流式，窗口内等价
/// - `Cache`：缓存增量，命中缓存即等价
pub(all) enum ExecMode {
  Exact // 确定性精确 / deterministic exact
  Approx(Int32) // 近似，带种子 / approximate with seed
  Streaming // 流式 / streaming
  Cache // 缓存增量 / cache incremental
} derive(Debug, Eq)

///|
pub extend ExecMode with Eq::{equal, not_equal}

///|
pub extend ExecMode with Debug::{to_repr}

///|
/// 一致性保证声明 / Consistency guarantee.
///
/// - `ByteExact`：逐字节等价
/// - `SeededBound(seed, bound)`：固定种子 + 误差界
/// - `WindowEquiv`：窗口内等价
/// - `CacheHitEquiv`：命中缓存即等价
pub(all) enum Consistency {
  ByteExact // 逐字节等价
  SeededBound(Int32, Double) // 固定种子 + 误差界
  WindowEquiv // 窗口内等价
  CacheHitEquiv // 命中缓存即等价
} derive(Debug, Eq)

///|
pub extend Consistency with Eq::{equal, not_equal}

///|
pub extend Consistency with Debug::{to_repr}

///|
/// 执行模式的一致性契约 / Consistency contract of an execution mode.
///
/// 每种执行模式对应一种一致性保证（架构 §4.1 表）。
pub fn mode_consistency(mode : ExecMode) -> Consistency {
  match mode {
    Exact => ByteExact
    Approx(seed) => SeededBound(seed, 0.0)
    Streaming => WindowEquiv
    Cache => CacheHitEquiv
  }
}

///|
/// 模式名称 / Mode name string.
///
/// 用于日志、血缘、DataIR 节点标注。`Approx` 统一记为 `"approx(seed)"`。
pub fn mode_name(mode : ExecMode) -> String {
  match mode {
    Exact => "exact"
    Approx(_) => "approx(seed)"
    Streaming => "streaming"
    Cache => "cache"
  }
}

///|
/// 从子包 mode_tag 构建 ExecMode / Build ExecMode from sub-package mode tag.
///
/// 子包通过 `mode_tag()` 返回字符串标识，根包据此构造类型化 `ExecMode`。
/// 退化策略：未知 tag 安全退化为 `Exact`（最严格的一致性保证）。
pub fn mode_from_tag(tag : String, seed : Int32) -> ExecMode {
  match tag {
    "exact" => Exact
    "approx" => Approx(seed)
    "streaming" => Streaming
    "cache" => Cache
    _ => Exact
  }
}

///|
/// 四模式子包聚合标签 / Aggregated mode tags from sub-packages.
///
/// 返回四模式子包的 mode_tag，用于一致性回归测试。
pub fn all_mode_tags() -> Array[String] {
  [
    @exact.mode_tag(),
    @approx.mode_tag(),
    @streaming.mode_tag(),
    @cache.mode_tag(),
  ]
}

///|
pub fn kernel_id() -> String {
  "kernel"
}
