///|
/// # recipe/balance_line 配比线 / Balance Pipeline
///
/// 编排：group_by_modality + 每组 topk_by_length。架构 §4.5 ④。
///
/// # Balance pipeline
///
/// Group by modality + per-group top-k. See architecture §4.5 ④.

///|
/// 配比线 / Balance line.
///
/// 按模态分组，每组取长度 Top-k，合并返回。
/// 退化安全：空数组返回空数组；k ≤ 0 返回全部。
pub fn balance_line(
  arr : Array[@dataobject.DataObject],
  k_per_modality : Int32,
) -> Array[@dataobject.DataObject] {
  let groups = @mix.group_by_modality(arr)
  let result = []
  for i = 0; i < groups.length(); i = i + 1 {
    let topk = @select.topk_by_length(groups[i].1, k_per_modality)
    for j = 0; j < topk.length(); j = j + 1 {
      result.push(topk[j])
    }
  }
  result
}

///|
pub fn balance_line_id() -> String {
  "recipe/balance_line"
}
