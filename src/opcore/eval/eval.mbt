///|
/// # opcore/eval 评估与验证算子 / Eval & Validate Operators
///
/// 数据质量、污染、漂移的端到端评估。架构 §4.3.2 ⑫。
/// S1.1 填充：global_statistics（对标 DJ global_statistics_pipeline）。
///
/// # Eval operators
///
/// Quality, contamination, drift evaluation. See architecture §4.3.2 ⑫.

/// 全局统计结果 / Global statistics result.
pub struct GlobalStats {
  total_count : Int
  nonempty_count : Int
  avg_length : Double
  max_length : Int
  min_length : Int
} derive(Debug, Eq)

pub extend GlobalStats with Eq::{equal, not_equal}
pub extend GlobalStats with Debug::{to_repr}

/// 全局统计：总数、非空数、平均/最大/最小长度 / Global statistics.
///
/// 对标 DJ `global_statistics_pipeline`。空数组退化安全。
pub fn global_statistics(
  arr : Array[@dataobject.DataObject]
) -> GlobalStats {
  let total = arr.length()
  if total == 0 {
    { total_count: 0, nonempty_count: 0, avg_length: 0.0, max_length: 0, min_length: 0 }
  } else {
    let nonempty = arr.filter(fn(d) { d.content.length() > 0 }).length()
    let lengths = arr.map(fn(d) { d.content.length() })
    let sum = lengths.fold(init=0, fn(acc, n) { acc + n })
    let max_len = lengths.fold(init=0, fn(acc, n) { if n > acc { n } else { acc } })
    let min_len = lengths.fold(init=total * 10000, fn(acc, n) {
      if n < acc { n } else { acc }
    })
    { total_count: total, nonempty_count: nonempty, avg_length: sum.to_double() / total.to_double(), max_length: max_len, min_length: min_len }
  }
}

pub fn eval_id() -> String {
  "opcore/eval"
}