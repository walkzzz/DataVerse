///|
/// # opcore/safety 安全与合规算子 / Safety & Compliance Operators
///
/// 隐私脱敏（PII 掩码）、敏感字段隔离、毒性过滤。架构 §4.3.2 ⑭。
/// S1.1 填充：mask_digits + mask_email（对标 DJ clean_email_mapper + 脱敏）。
///
/// # Safety operators
///
/// PII masking, sensitive field isolation, toxicity filtering. See architecture §4.3.2 ⑭.

///|
/// 数字脱敏：把内容中所有数字字符替换为 * / Mask digit characters.
///
/// 用于电话号码、身份证号等数字类 PII 脱敏。
pub fn safety_mask_digits(input : @dataobject.DataObject) -> @dataobject.DataObject {
  let masked = String::from_array(
    input.content
    .to_array()
    .map(fn(c) { if c.is_ascii_digit() { '*' } else { c } }),
  )
  @dataobject.make_dataobject_with_metadata(
    masked,
    input.modality,
    input.schema,
    input.metadata,
  )
}

///|
/// 邮箱脱敏：把 @ 前部分替换为 *** / Mask email address.
///
/// 对标 DJ `clean_email_mapper` 的脱敏变体。S1.1 基础版：检测 @ 符号，掩码 @ 前内容。
pub fn safety_mask_email(input : @dataobject.DataObject) -> @dataobject.DataObject {
  let content = input.content
  let at_idx = content.find("@")
  let masked = match at_idx {
    Some(idx) =>
      if idx == 0 {
        content
      } else {
        "***" + String::from_array(content.to_array()[idx:])
      }
    None => content
  }
  @dataobject.make_dataobject_with_metadata(
    masked,
    input.modality,
    input.schema,
    input.metadata,
  )
}

///|
pub fn safety_safety_id() -> String {
  "opcore/safety"
}
