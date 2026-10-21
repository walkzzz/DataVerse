///|
/// # opcore/select 选择与采样算子 / Select & Sample Operators
///
/// Top-K、阈值、分层、平衡选择。架构 §4.3.2 ⑨。
/// S1.1 填充：topk_by_length + threshold_by_length（对标 DJ selector）。
///
/// # Select operators
///
/// Top-K, threshold, stratified, balanced selection. See architecture §4.3.2 ⑨.

///|
/// 按长度 Top-K：取长度最长的前 k 个 / Top-K by content length.
///
/// 对标 DJ `topk_selector`。k ≤ 0 或 k ≥ arr.length() 时返回全部。
pub fn topk_by_length(
  arr : Array[@dataobject.DataObject],
  k : Int32,
) -> Array[@dataobject.DataObject] {
  if k <= 0 || k >= arr.length() {
    arr
  } else {
    let sorted = arr.copy()
    sorted.sort_by(fn(a, b) { b.content.length() - a.content.length() })
    sorted[0:k].to_owned()
  }
}

///|
/// 按长度阈值过滤：保留长度 ≥ min_len 的 / Threshold by length.
///
/// 对标 DJ `threshold_selector`。
pub fn threshold_by_length(
  arr : Array[@dataobject.DataObject],
  min_len : Int32,
) -> Array[@dataobject.DataObject] {
  arr.filter(fn(d) { d.content.length() >= min_len })
}

///|
pub fn select_id() -> String {
  "opcore/select"
}
