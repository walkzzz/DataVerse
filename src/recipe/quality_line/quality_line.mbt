///|
/// # recipe/quality_line 质量线 / Quality Pipeline
///
/// 编排：length 质量评分过滤 + topk_by_length 选择。架构 §4.5 ③。
///
/// # Quality pipeline
///
/// Filter by quality score + top-k selection. See architecture §4.5 ③.

///|
/// 质量线 / Quality line.
///
/// 1. 过滤掉质量分 < min_score 的
/// 2. 按长度 Top-K 选择
/// 退化安全：空数组返回空数组；k ≤ 0 返回过滤后全部。
pub fn quality_line(
  arr : Array[@dataobject.DataObject],
  min_score : Double,
  k : Int32,
) -> Array[@dataobject.DataObject] {
  let filtered = arr.filter(fn(d) {
    @quality.length_quality_score(d) >= min_score
  })
  @select.topk_by_length(filtered, k)
}

///|
pub fn quality_line_id() -> String {
  "recipe/quality_line"
}
