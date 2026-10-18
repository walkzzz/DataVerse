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

/// 按属性分割 / Split By Attributes.
///
/// 对标 ArcGIS Pro Split By Attributes 工具。
/// 按指定属性列的唯一值将记录分组。
/// 退化安全：空记录返回空数组。
pub fn filter_split_by_attributes(
  records : Array[Array[String]],
  attr_index : Int
) -> Array[(String, Array[Array[String]])] {
  let n = records.length()
  if n == 0 || attr_index < 0 {
    []
  } else {
    let result : Array[(String, Array[Array[String]])] = []
    for i in 0..<n {
      let record = records[i]
      let attr_val = if attr_index < record.length() { record[attr_index] } else { "" }
      let mut found = false
      for idx in 0..<result.length() {
        if result[idx].0 == attr_val {
          result[idx].1.push(record)
          found = true
        }
      }
      if !found {
        result.push((attr_val, [record]))
      }
    }
    result
  }
}