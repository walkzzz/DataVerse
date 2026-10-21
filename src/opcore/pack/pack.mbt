///|
/// # opcore/pack 打包与序列化算子 / Pack & Serialize Operators
///
/// 分块、打包、序列化，产出训练就绪数据集。架构 §4.3.2 ⑪。
/// S1.1 填充：text_chunk（对标 DJ text_chunk_mapper）。
///
/// # Pack operators
///
/// Chunking, packing, serialization. See architecture §4.3.2 ⑪.

///|
/// 文本分块：按 chunk_size 切分内容为 Chunk 列表 / Text chunking.
///
/// 对标 DJ `text_chunk_mapper`。chunk_size ≤ 0 时返回单个整块。
pub fn text_chunk(
  input : @dataobject.DataObject,
  chunk_size : Int32,
) -> Array[@chunk.Chunk] {
  let content = input.content
  let total = content.length()
  if chunk_size <= 0 || total == 0 {
    [@chunk.make("chunk_0", content, @chunk.TextSlice)]
  } else {
    let chars = content.to_array()
    let result = []
    let mut i = 0
    let mut idx = 0
    while i < total {
      let end = if i + chunk_size < total { i + chunk_size } else { total }
      let piece = String::from_array(chars[i:end])
      result.push(
        @chunk.make("chunk_" + idx.to_string(), piece, @chunk.TextSlice),
      )
      i = i + chunk_size
      idx = idx + 1
    }
    result
  }
}

///|
pub fn pack_id() -> String {
  "opcore/pack"
}
