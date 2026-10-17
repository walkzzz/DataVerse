///|
/// # kernel/approx 近似概率模式 / Approximate Probabilistic Mode
///
/// MinHash/SimHash 去重、概率采样、近似分位的执行模式基座。
/// 一致性保证：固定种子 + 误差界声明。架构 §4.1。
/// S0.2 提供种子管理与契约声明；具体近似算法在 S0.4 算子层填充。
///
/// # Approximate probabilistic mode
///
/// Base for MinHash/SimHash dedup, probabilistic sampling, approximate quantiles.
/// Consistency: seeded + error bound. See architecture §4.1.
/// S0.2 provides seed management and contract; concrete algorithms filled in S0.4.

/// 默认种子 / Default seed for reproducibility.
pub fn default_seed() -> Int {
  42
}

pub fn approx_id() -> String {
  "kernel/approx"
}

/// 模式标签 / Mode tag string.
pub fn mode_tag() -> String {
  "approx"
}

/// 一致性保证声明 / Consistency guarantee.
pub fn consistency_guarantee() -> String {
  "seeded-bound"
}

/// 种子校验：非负 / Seed validation: non-negative.
pub fn valid_seed(seed : Int) -> Bool {
  seed >= 0
}

/// 误差界占位 / Error bound placeholder.
/// 具体误差界由算子根据算法声明（如 MinHash 的 Jaccard 误差）。
pub fn default_error_bound() -> Double {
  0.0
}