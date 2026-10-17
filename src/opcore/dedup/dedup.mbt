///|
/// # opcore/dedup 去重算子 / Dedup Operators
///
/// 精确去重、近似去重、语义去重。架构 §4.3.2 ④。
/// S0.4 提供 `exact_dedup`（按 content 精确去重）；近似/语义去重后续填充。
///
/// # Dedup operators
///
/// Exact, approximate, semantic dedup. See architecture §4.3.2 ④.

/// 精确去重：按 content 去重，保留首次出现 / Exact dedup by content, keep first occurrence.
pub fn exact_dedup(inputs : Array[@dataobject.DataObject]) -> Array[@dataobject.DataObject] {
  let result : Array[@dataobject.DataObject] = []
  for d in inputs {
    let mut found = false
    for r in result {
      if r.content == d.content {
        found = true
      }
    }
    if !found {
      result.push(d)
    }
  }
  result
}

/// 去重前后数量差 / Dedup count reduction.
pub fn dedup_count(before : Int, after : Int) -> Int {
  before - after
}

pub fn dedup_id() -> String {
  "opcore/dedup"
}