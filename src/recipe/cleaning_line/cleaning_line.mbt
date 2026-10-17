///|
/// # recipe/cleaning_line 标准清洗线 / Standard Cleaning Pipeline
///
/// 编排：remove_empty → strip_whitespace → whitespace_normalization。
/// 架构 §4.5 ①。对标 DJ cleaning 流水线。
///
/// # Standard cleaning pipeline
///
/// remove_empty → strip_whitespace → whitespace_normalization. See architecture §4.5 ①.

/// 标准清洗线 / Standard cleaning line.
///
/// 对每个 DataObject 依次执行：去空 → 去首尾空白 → 空白归一。
/// 退化安全：空数组返回空数组。
pub fn cleaning_line(
  arr : Array[@dataobject.DataObject]
) -> Array[@dataobject.DataObject] {
  arr
    .filter(fn(d) { d.content.length() > 0 })
    .map(fn(d) { @clean.strip_whitespace(d) })
    .map(fn(d) { @normalize.whitespace_normalization(d) })
}

pub fn cleaning_line_id() -> String {
  "recipe/cleaning_line"
}