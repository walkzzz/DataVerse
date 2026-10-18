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
/// 交叉制表 / Tabulate Intersection.
///
/// 对标 ArcGIS Pro Tabulate Intersection 工具。
/// 计算两个分类栅格的交叉面积表。
/// 退化安全：空输入返回空数组。
pub fn eval_tabulate_intersection(zone1 : Array[Int], zone2 : Array[Int]) -> Array[(Int, Int, Int)] {
  let n = zone1.length()
  if n == 0 || zone2.length() != n {
    []
  } else {
    let result : Array[(Int, Int, Int)] = []
    for i in 0..<n {
      let z1 = zone1[i]
      let z2 = zone2[i]
      let mut found = false
      for idx in 0..<result.length() {
        if result[idx].0 == z1 && result[idx].1 == z2 {
          result[idx] = (z1, z2, result[idx].2 + 1)
          found = true
        }
      }
      if !found {
        result.push((z1, z2, 1))
      }
    }
    result
  }
}
