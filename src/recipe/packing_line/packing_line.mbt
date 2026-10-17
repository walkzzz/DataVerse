///|
/// # recipe/packing_line 打包流水线 / Packing Pipeline
///
/// 编排：filter_empty → chunk → collect。架构 §4.5 ②。
/// 对标 DJ packing 流水线。
///
/// # Packing pipeline
///
/// filter_empty → chunk → collect. See architecture §4.5 ②.

/// 打包流水线 / Packing line.
///
/// 对每个非空 DataObject 按 chunk_size 切分内容，返回所有段的 DataObject 数组。
/// 退化安全：空数组返回空数组；chunk_size <= 0 返回原数组（不过滤空）。
pub fn packing_line(
  arr : Array[@dataobject.DataObject],
  chunk_size : Int
) -> Array[@dataobject.DataObject] {
  if chunk_size <= 0 {
    arr
  } else {
    let result : Array[@dataobject.DataObject] = []
    for i in 0..<arr.length() {
      let d = arr[i]
      if d.content.length() > 0 {
        let chars = d.content.to_array()
        let total = chars.length()
        let mut pos = 0
        while pos < total {
          let end = if pos + chunk_size < total { pos + chunk_size } else { total }
          let piece = String::from_array(chars[pos:end])
          result.push(@dataobject.make_dataobject(piece, d.modality, d.schema))
          pos = pos + chunk_size
        }
      }
    }
    result
  }
}

pub fn packing_line_id() -> String {
  "recipe/packing_line"
}