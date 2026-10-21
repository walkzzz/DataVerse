///|
/// # opcore/normalize 格式化与规范化算子 / Format & Normalize Operators
///
/// 编码归一、换行与空白归一、Schema 对齐。架构 §4.3.2 ②。
/// S1.1 填充：whitespace_normalization + punctuation_normalization（对标 DJ）。
///
/// # Normalize operators
///
/// Encoding/whitespace/schema normalization. See architecture §4.3.2 ②.

///|
/// 空白归一：合并连续空白为单空格，去除首尾空白 / Whitespace normalization.
///
/// 对标 DJ `whitespace_normalization_mapper`。
pub fn whitespace_normalization(
  input : @dataobject.DataObject,
) -> @dataobject.DataObject {
  let normalized = collapse_whitespace(input.content)
  @dataobject.make_dataobject_with_metadata(
    normalized,
    input.modality,
    input.schema,
    input.metadata,
  )
}

///|
/// 标点归一：全角标点转半角 / Punctuation normalization (full-width to half-width).
///
/// 对标 DJ `punctuation_normalization_mapper`。S1.1 基础版：转换常见全角标点。
pub fn punctuation_normalization(
  input : @dataobject.DataObject,
) -> @dataobject.DataObject {
  let normalized = normalize_punctuation(input.content)
  @dataobject.make_dataobject_with_metadata(
    normalized,
    input.modality,
    input.schema,
    input.metadata,
  )
}

///|
pub fn normalize_id() -> String {
  "opcore/normalize"
}

///|
fn collapse_whitespace(s : String) -> String {
  let result = []
  let chars = s.to_array()
  let mut prev_space = false
  for i = 0; i < chars.length(); i = i + 1 {
    let c = chars[i]
    if c == ' ' || c == '\t' || c == '\n' || c == '\r' {
      if !prev_space {
        result.push(' ')
        prev_space = true
      }
    } else {
      result.push(c)
      prev_space = false
    }
  }
  String::from_array(result).trim().to_owned()
}

///|
fn normalize_punctuation(s : String) -> String {
  let chars = s.to_array()
  let result = []
  for i = 0; i < chars.length(); i = i + 1 {
    let c = chars[i]
    let mapped = match c {
      '，' => ','
      '。' => '.'
      '；' => ';'
      '：' => ':'
      '？' => '?'
      '！' => '!'
      '（' => '('
      '）' => ')'
      '【' => '['
      '】' => ']'
      '《' => '<'
      '》' => '>'
      _ => c
    }
    result.push(mapped)
  }
  String::from_array(result)
}
