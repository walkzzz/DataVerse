///|
/// # dataobject/schema 模式描述 / Schema Description
///
/// 字段、类型、嵌套结构、约束的基础结构。架构 §4.2。
/// S0.3 提供结构定义与构造；Schema 校验逻辑在 S0.4 opcore 填充。
///
/// # Schema description
///
/// Fields, types, nested structure, constraints. See architecture §4.2.
/// S0.3 provides structure and constructors; validation logic filled in S0.4.

///|
/// 字段类型 / Field type.
pub(all) enum FieldType {
  Text
  Integer
  Float
  Boolean
  Nested
} derive(Debug, Eq)

///|
pub extend FieldType with Eq::{equal, not_equal}

///|
pub extend FieldType with Debug::{to_repr}

///|
/// 字段描述 / Field descriptor.
pub struct Field {
  name : String
  field_type : FieldType
} derive(Debug, Eq)

///|
pub extend Field with Eq::{equal, not_equal}

///|
pub extend Field with Debug::{to_repr}

///|
/// 模式 / Schema: field collection.
pub struct Schema {
  fields : Array[Field]
} derive(Debug, Eq)

///|
pub extend Schema with Eq::{equal, not_equal}

///|
pub extend Schema with Debug::{to_repr}

///|
/// 构造字段 / Build a field.
pub fn field(name : String, field_type : FieldType) -> Field {
  { name, field_type, }
}

///|
/// 构造模式 / Build a schema from field list.
pub fn make(fields : Array[Field]) -> Schema {
  { fields, }
}

///|
/// 空模式 / Empty schema (degenerate-safe).
pub fn empty() -> Schema {
  { fields: [], }
}

///|
/// 字段数 / Field count.
pub fn size(s : Schema) -> Int32 {
  s.fields.length()
}

///|
pub fn schema_id() -> String {
  "dataobject/schema"
}
