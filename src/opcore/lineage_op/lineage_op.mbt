///|
/// # opcore/lineage_op 血缘与版本算子 / Lineage & Version Operators
///
/// 血缘附加、版本快照、回放。架构 §4.3.2 ⑬。
/// DataVerse 独有（DJ 无直接对应），与 datatemporal（§4.4）联动。
/// S1.1 填充：attach_lineage + make_op_lineage。
///
/// # Lineage operators
///
/// Lineage attachment, version snapshot, replay. See architecture §4.3.2 ⑬.

/// 附加血缘：返回 (DataObject, Lineage) 元组 / Attach lineage.
///
/// 生成 Lineage 记录算子名、输入指纹（内容长度）、输出指纹。
pub fn attach_lineage(
  input : @dataobject.DataObject,
  op_name : String
) -> (@dataobject.DataObject, @dataobject.Lineage) {
  let in_fp = "fp:" + input.content.length().to_string()
  let lineage = @dataobject.make_lineage(op_name, in_fp, in_fp, "", "")
  (input, lineage)
}

/// 构造算子血缘 / Build operator lineage with params.
pub fn make_op_lineage(
  op_name : String,
  input : @dataobject.DataObject,
  params : String
) -> @dataobject.Lineage {
  let in_fp = "fp:" + input.content.length().to_string()
  @dataobject.make_lineage(op_name, in_fp, in_fp, params, "")
}

pub fn lineage_op_id() -> String {
  "opcore/lineage_op"
}