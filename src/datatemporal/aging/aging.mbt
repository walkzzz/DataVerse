///|
/// # datatemporal/aging 数据衰老 / Data Aging
///
/// 基于时间的指数衰减。架构 §4.4 datatemporal 深化。
/// S2.6 填充：AgingConfig + aging_weight + aging_score。
///
/// # Data aging
///
/// Time-based exponential decay. See architecture §4.4.

///|
/// 衰减配置 / Aging config.
pub struct AgingConfig {
  half_life_days : Double
  reference_time_days : Double
} derive(Debug, Eq)

///|
pub extend AgingConfig with Eq::{equal, not_equal}

///|
pub extend AgingConfig with Debug::{to_repr}

///|
/// 构造衰减配置 / Build aging config.
pub fn make_aging_config(
  half_life_days : Double,
  reference_time_days : Double,
) -> AgingConfig {
  { half_life_days, reference_time_days, }
}

///|
/// 衰减权重 / Aging weight.
///
/// 公式：`2^(-(reference - timestamp) / half_life)`。
/// timestamp > reference（未来数据）返回 1.0。
/// 退化安全：half_life <= 0 返回 1.0。
pub fn aging_weight(timestamp_days : Double, config : AgingConfig) -> Double {
  if config.half_life_days <= 0.0 {
    1.0
  } else {
    let diff = config.reference_time_days - timestamp_days
    if diff <= 0.0 {
      1.0
    } else {
      let exp = diff / config.half_life_days
      1.0 / pow2(exp)
    }
  }
}

///|
/// 衰减分数 / Aging score for multiple timestamps.
///
/// 返回平均衰减权重。退化安全：空数组返回 0.0。
pub fn aging_score(
  timestamps_days : Array[Double],
  config : AgingConfig,
) -> Double {
  let n = timestamps_days.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + aging_weight(timestamps_days[i], config)
    }
    sum / n.to_double()
  }
}

///|
/// 2 的幂次 / 2^x (for x >= 0).
fn pow2(x : Double) -> Double {
  let ln2 = 0.6931471805599453
  let target = x * ln2
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<60 {
    term = term * target / i.to_double()
    result = result + term
  }
  result
}

///|
pub fn aging_id() -> String {
  "datatemporal/aging"
}
