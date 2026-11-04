///|
/// # opcore/clean 清洗算子 / Clean Operators
///
/// 去 boilerplate、标签清理、隐私脱敏、空记录过滤。架构 §4.3.2 ③。
/// S0.4 提供 `remove_empty` + `strip_whitespace`；其余清洗算子后续填充。
///
/// # Clean operators
///
/// Remove boilerplate, tag cleanup, PII masking, empty filtering. See architecture §4.3.2 ③.

///|
/// 空记录过滤：空 content 替换为空 DataObject / Remove empty content.
pub fn clean_remove_empty(input : @dataobject.DataObject) -> @dataobject.DataObject {
  if input.content.length() == 0 {
    @dataobject.empty_dataobject(input.modality)
  } else {
    input
  }
}

///|
/// 空白清理：去除首尾空白 / Strip leading/trailing whitespace.
pub fn clean_strip_whitespace(
  input : @dataobject.DataObject,
) -> @dataobject.DataObject {
  let trimmed = input.content.trim().to_owned()
  @dataobject.make_dataobject_with_metadata(
    trimmed,
    input.modality,
    input.schema,
    input.metadata,
  )
}

///|
/// 内容长度 / Content length of a data object.
pub fn clean_content_len(input : @dataobject.DataObject) -> Int32 {
  input.content.length()
}

///|
pub fn clean_clean_id() -> String {
  "opcore/clean"
}
