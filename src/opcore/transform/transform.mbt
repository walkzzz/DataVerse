///|
/// # opcore/transform 变换与增强算子 / Transform & Augment Operators
///
/// 文本增强、图像/音频/视频变换。架构 §4.3.2 ⑦。
/// S1.1 填充：to_lowercase + to_uppercase + truncate（文本变换基礎）。
///
/// # Transform operators
///
/// Text/image/audio/video transform. See architecture §4.3.2 ⑦.

/// 转小写 / Convert content to lowercase.
pub fn to_lowercase(
  input : @dataobject.DataObject
) -> @dataobject.DataObject {
  let lowered = String::from_array(
    input.content.to_array().map(fn(c) { c.to_ascii_lowercase() }),
  )
  @dataobject.make_dataobject_with_metadata(
    lowered, input.modality, input.schema, input.metadata,
  )
}

/// 转大写 / Convert content to uppercase.
pub fn to_uppercase(
  input : @dataobject.DataObject
) -> @dataobject.DataObject {
  let uppered = String::from_array(
    input.content.to_array().map(fn(c) { c.to_ascii_uppercase() }),
  )
  @dataobject.make_dataobject_with_metadata(
    uppered, input.modality, input.schema, input.metadata,
  )
}

/// 截断：保留前 max_len 字符 / Truncate to max_len characters.
pub fn truncate(
  input : @dataobject.DataObject,
  max_len : Int
) -> @dataobject.DataObject {
  let truncated = if input.content.length() <= max_len {
    input.content
  } else {
    String::from_array(input.content.to_array()[0:max_len])
  }
  @dataobject.make_dataobject_with_metadata(
    truncated, input.modality, input.schema, input.metadata,
  )
}

pub fn transform_id() -> String {
  "opcore/transform"
}