///|
/// # recipe/dedup_line 多级去重线 / Multi-level Dedup Pipeline
///
/// 编排：exact_dedup。架构 §4.5 ②。
/// S1.3 基礎版：精确去重；后续 Sprint 扩展近似 + 语义去重。
///
/// # Multi-level dedup pipeline
///
/// exact_dedup. See architecture §4.5 ②.

///|
/// 去重线 / Dedup line.
///
/// 精确去重：按 content 字符串去重。
/// 退化安全：空数组返回空数组。
pub fn dedup_line(
  arr : Array[@dataobject.DataObject],
) -> Array[@dataobject.DataObject] {
  @text.dedup_exact_dedup(arr)
}

///|
pub fn dedup_line_id() -> String {
  "recipe/dedup_line"
}
