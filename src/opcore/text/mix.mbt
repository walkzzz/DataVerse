///|
/// # opcore/mix 配比与混合算子 / Mix & Blend Operators
///
/// 多维度配比、去偏、混合。架构 §4.3.2 ⑩。
/// S1.1 填充：group_by_modality + interleave（对标 DJ grouper）。
///
/// # Mix operators
///
/// Multi-dimension blending, debiasing. See architecture §4.3.2 ⑩.

///|
/// 按模态分组 / Group by modality.
///
/// 对标 DJ `naive_grouper`。返回 (模态, 该模态所有 DataObject) 列表。
pub fn mix_group_by_modality(
  arr : Array[@dataobject.DataObject],
) -> Array[(@dataobject.Modality, Array[@dataobject.DataObject])] {
  let modalities = [
    @dataobject.Text,
    @dataobject.Image,
    @dataobject.Audio,
    @dataobject.Video,
    @dataobject.Table,
    @dataobject.Code,
    @dataobject.Multi,
  ]
  modalities
  .map(fn(m) { (m, arr.filter(fn(d) { d.modality == m })) })
  .filter(fn(pair) { pair.1.length() > 0 })
}

///|
/// 交错混合：两个数组交替取元素 / Interleave two arrays.
pub fn mix_interleave(
  a : Array[@dataobject.DataObject],
  b : Array[@dataobject.DataObject],
) -> Array[@dataobject.DataObject] {
  let result = []
  let max_len = if a.length() > b.length() { a.length() } else { b.length() }
  for i = 0; i < max_len; i = i + 1 {
    if i < a.length() {
      result.push(a[i])
    }
    if i < b.length() {
      result.push(b[i])
    }
  }
  result
}

///|
pub fn mix_mix_id() -> String {
  "opcore/mix"
}
