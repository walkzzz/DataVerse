///|
/// # opcore/filter 过滤算子 / Filter Operators
///
/// 规则过滤、统计过滤、质量模型过滤、安全合规过滤、模态过滤。架构 §4.3.2 ⑤。
/// S0.4 提供 `length_filter` + `non_empty_filter`；其余过滤算子后续填充。
///
/// # Filter operators
///
/// Rule, statistical, quality-model, safety, modality filters. See architecture §4.3.2 ⑤.

/// 长度过滤：content 长度在 [min, max] 内返回 true / Length filter.
pub fn length_filter(min_len : Int, max_len : Int, input : @dataobject.DataObject) -> Bool {
  let len = input.content.length()
  len >= min_len && len <= max_len
}

/// 非空过滤：content 非空返回 true / Non-empty filter.
pub fn non_empty_filter(input : @dataobject.DataObject) -> Bool {
  input.content.length() > 0
}

/// 批量过滤：保留满足谓词的元素 / Batch filter keeping elements satisfying predicate.
pub fn filter_all(
  inputs : Array[@dataobject.DataObject],
  predicate : (@dataobject.DataObject) -> Bool
) -> Array[@dataobject.DataObject] {
  let result : Array[@dataobject.DataObject] = []
  for d in inputs {
    if predicate(d) {
      result.push(d)
    }
  }
  result
}

pub fn filter_id() -> String {
  "opcore/filter"
}
/// 分割 / Split text by delimiter.
///
/// 对标 ArcGIS Pro Split 工具。
/// 退化安全：空输入返回空数组。
pub fn filter_split(input : @dataobject.DataObject, delimiter : String) -> Array[String] {
  let content = input.content
  if content.length() == 0 {
    []
  } else {
    content.split(delimiter).to_array().map(fn(s) { s.to_owned() })
  }
}
