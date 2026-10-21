///|
/// # dataobject/schema_evol Schema 演化 / Schema Evolution
///
/// Schema 版本管理 / 字段操作 / 验证 / 转换 / 数据迁移 / 演化策略 / 兼容性。架构 §4.2。
/// S12.10 提供完整 Schema 演化能力。
///
/// # Schema evolution
///
/// Version management / field ops / validation / conversion / migration / strategy / compatibility.

/// 字段类型 / Field type.
pub(all) enum FieldType {
  Text
  Integer
  Float
  Boolean
  Nested
  Date
} derive(Debug, Eq)

pub extend FieldType with Eq::{equal, not_equal}
pub extend FieldType with Debug::{to_repr}

/// 兼容性等级 / Compatibility level.
pub(all) enum Compatibility {
  Full
  Backward
  Forward
  None
} derive(Debug, Eq)

pub extend Compatibility with Eq::{equal, not_equal}
pub extend Compatibility with Debug::{to_repr}

/// 迁移风险等级 / Migration risk level.
pub(all) enum MigrationRiskLevel {
  Low
  Medium
  High
  Critical
} derive(Debug, Eq)

pub extend MigrationRiskLevel with Eq::{equal, not_equal}
pub extend MigrationRiskLevel with Debug::{to_repr}

/// 演化动作 / Evolution action.
pub(all) enum EvolutionAction {
  AddField
  RemoveField
  RenameField
  ChangeType
  MakeOptional
  MakeRequired
} derive(Debug, Eq)

pub extend EvolutionAction with Eq::{equal, not_equal}
pub extend EvolutionAction with Debug::{to_repr}

/// 字段描述 / Field descriptor.
pub struct Field {
  name : String
  field_type : FieldType
  nullable : Bool
  default_value : String?
} derive(Debug, Eq)

pub extend Field with Eq::{equal, not_equal}
pub extend Field with Debug::{to_repr}

/// 模式 / Schema.
pub struct Schema {
  version : Int
  fields : Array[Field]
} derive(Debug, Eq)

pub extend Schema with Eq::{equal, not_equal}
pub extend Schema with Debug::{to_repr}

/// 模式差异 / Schema diff.
pub struct SchemaDiff {
  added : Array[Field]
  removed : Array[Field]
  modified : Array[Field]
} derive(Debug, Eq)

pub extend SchemaDiff with Eq::{equal, not_equal}
pub extend SchemaDiff with Debug::{to_repr}

/// 迁移 / Migration.
pub struct Migration {
  from_version : Int
  to_version : Int
  diff : SchemaDiff
} derive(Debug, Eq)

pub extend Migration with Eq::{equal, not_equal}
pub extend Migration with Debug::{to_repr}

/// 演化计划 / Evolution plan.
pub struct EvolutionPlan {
  steps : Array[(EvolutionAction, String)]
  risk : MigrationRiskLevel
} derive(Debug, Eq)

pub extend EvolutionPlan with Eq::{equal, not_equal}
pub extend EvolutionPlan with Debug::{to_repr}

/// 演化结果 / Evolution result.
pub struct EvolutionResult {
  success : Bool
  new_schema : Schema
  message : String
} derive(Debug, Eq)

pub extend EvolutionResult with Eq::{equal, not_equal}
pub extend EvolutionResult with Debug::{to_repr}

/// 构造字段 / Build a field.
pub fn make_field(
  name : String,
  field_type : FieldType,
  nullable : Bool,
  default_value : String?
) -> Field {
  { name, field_type, nullable, default_value }
}

/// 构造必填字段 / Build a required field.
pub fn required_field(name : String, field_type : FieldType) -> Field {
  { name, field_type, nullable: false, default_value: None }
}

/// 构造可选字段 / Build an optional field.
pub fn optional_field(name : String, field_type : FieldType) -> Field {
  { name, field_type, nullable: true, default_value: None }
}

/// 构造空模式 / Build an empty schema.
pub fn empty_schema() -> Schema {
  { version: 0, fields: [] }
}

/// 字段名相等判断 / Field name equality.
pub fn field_name_eq(a : Field, b : Field) -> Bool {
  a.name == b.name
}

/// 字段完全相等判断 / Field full equality.
pub fn field_full_eq(a : Field, b : Field) -> Bool {
  a.name == b.name &&
  a.field_type == b.field_type &&
  a.nullable == b.nullable &&
  a.default_value == b.default_value
}

/// 在数组中查找字段名索引 / Find field index by name.
pub fn find_field_index(fields : Array[Field], name : String) -> Int {
  let n = fields.length()
  for i in 0..<n {
    if fields[i].name == name {
      return i
    }
  }
  -1
}

/// 字段类型转字符串 / Field type to string.
pub fn field_type_to_string(t : FieldType) -> String {
  match t {
    Text => "TEXT"
    Integer => "INTEGER"
    Float => "FLOAT"
    Boolean => "BOOLEAN"
    Nested => "NESTED"
    Date => "DATE"
  }
}

/// 字符串转字段类型 / String to field type.
pub fn string_to_field_type(s : String) -> FieldType {
  match s {
    "TEXT" => Text
    "INTEGER" => Integer
    "FLOAT" => Float
    "BOOLEAN" => Boolean
    "NESTED" => Nested
    "DATE" => Date
    _ => Text
  }
}

/// 兼容性转字符串 / Compatibility to string.
pub fn compatibility_to_string(c : Compatibility) -> String {
  match c {
    Full => "FULL"
    Backward => "BACKWARD"
    Forward => "FORWARD"
    None => "NONE"
  }
}

/// 风险等级转字符串 / Risk level to string.
pub fn risk_to_string(r : MigrationRiskLevel) -> String {
  match r {
    Low => "LOW"
    Medium => "MEDIUM"
    High => "HIGH"
    Critical => "CRITICAL"
  }
}

/// 演化动作转字符串 / Evolution action to string.
pub fn action_to_string(a : EvolutionAction) -> String {
  match a {
    AddField => "ADD_FIELD"
    RemoveField => "REMOVE_FIELD"
    RenameField => "RENAME_FIELD"
    ChangeType => "CHANGE_TYPE"
    MakeOptional => "MAKE_OPTIONAL"
    MakeRequired => "MAKE_REQUIRED"
  }
}

/// 构造 v1 模式 / Build a v1 schema.
pub fn make_schema_v1(fields : Array[Field]) -> Schema {
  { version: 1, fields }
}

/// 构造 v2 模式 / Build a v2 schema.
pub fn make_schema_v2(fields : Array[Field]) -> Schema {
  { version: 2, fields }
}

/// 获取模式版本 / Get schema version.
pub fn schema_version(s : Schema) -> Int {
  s.version
}

/// 计算模式差异 / Compute schema diff.
pub fn schema_diff(from : Schema, to : Schema) -> SchemaDiff {
  let added : Array[Field] = []
  let removed : Array[Field] = []
  let modified : Array[Field] = []
  let nf = from.fields.length()
  let nt = to.fields.length()
  for i in 0..<nt {
    let f = to.fields[i]
    let idx = find_field_index(from.fields, f.name)
    if idx == -1 {
      added.push(f)
    } else if !(field_full_eq(from.fields[idx], f)) {
      modified.push(f)
    }
  }
  for i in 0..<nf {
    let f = from.fields[i]
    let idx = find_field_index(to.fields, f.name)
    if idx == -1 {
      removed.push(f)
    }
  }
  { added, removed, modified }
}

/// 构造迁移 / Build a migration.
pub fn schema_migration(from : Schema, to : Schema) -> Migration {
  { from_version: from.version, to_version: to.version, diff: schema_diff(from, to) }
}

/// 向后兼容 / Backward compatibility: new schema can read old data.
pub fn schema_backward_compat(old : Schema, new : Schema) -> Bool {
  let d = schema_diff(old, new)
  let na = d.added.length()
  for i in 0..<na {
    let f = d.added[i]
    if !(f.nullable) && f.default_value is None {
      return false
    }
  }
  let nm = d.modified.length()
  for i in 0..<nm {
    let f = d.modified[i]
    let idx = find_field_index(old.fields, f.name)
    if idx >= 0 {
      let of = old.fields[idx]
      if !(f.nullable) && of.nullable {
        return false
      }
    }
  }
  true
}

/// 向前兼容 / Forward compatibility: old schema can read new data.
pub fn schema_forward_compat(old : Schema, new : Schema) -> Bool {
  let d = schema_diff(old, new)
  if d.removed.length() > 0 {
    return false
  }
  let nm = d.modified.length()
  for i in 0..<nm {
    let f = d.modified[i]
    let idx = find_field_index(old.fields, f.name)
    if idx >= 0 {
      let of = old.fields[idx]
      if f.nullable && !(of.nullable) {
        return false
      }
    }
  }
  true
}

/// 完全兼容 / Full compatibility.
pub fn schema_full_compat(old : Schema, new : Schema) -> Bool {
  schema_backward_compat(old, new) && schema_forward_compat(old, new)
}

/// 添加字段 / Add a field to schema.
pub fn add_field(s : Schema, f : Field) -> Schema {
  let idx = find_field_index(s.fields, f.name)
  if idx >= 0 {
    return s
  }
  let new_fields : Array[Field] = []
  let n = s.fields.length()
  for i in 0..<n {
    new_fields.push(s.fields[i])
  }
  new_fields.push(f)
  { version: s.version, fields: new_fields }
}

/// 移除字段 / Remove a field from schema.
pub fn remove_field(s : Schema, name : String) -> Schema {
  let new_fields : Array[Field] = []
  let n = s.fields.length()
  for i in 0..<n {
    if s.fields[i].name != name {
      new_fields.push(s.fields[i])
    }
  }
  { version: s.version, fields: new_fields }
}

/// 重命名字段 / Rename a field.
pub fn rename_field(s : Schema, old_name : String, new_name : String) -> Schema {
  let new_fields : Array[Field] = []
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    if f.name == old_name {
      new_fields.push({ name: new_name, field_type: f.field_type, nullable: f.nullable, default_value: f.default_value })
    } else {
      new_fields.push(f)
    }
  }
  { version: s.version, fields: new_fields }
}

/// 改变字段类型 / Change field type.
pub fn change_field_type(s : Schema, name : String, new_type : FieldType) -> Schema {
  let new_fields : Array[Field] = []
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    if f.name == name {
      new_fields.push({ name: f.name, field_type: new_type, nullable: f.nullable, default_value: f.default_value })
    } else {
      new_fields.push(f)
    }
  }
  { version: s.version, fields: new_fields }
}

/// 使字段可选 / Make field optional.
pub fn make_field_optional(s : Schema, name : String) -> Schema {
  let new_fields : Array[Field] = []
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    if f.name == name {
      new_fields.push({ name: f.name, field_type: f.field_type, nullable: true, default_value: f.default_value })
    } else {
      new_fields.push(f)
    }
  }
  { version: s.version, fields: new_fields }
}

/// 使字段必填 / Make field required.
pub fn make_field_required(s : Schema, name : String) -> Schema {
  let new_fields : Array[Field] = []
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    if f.name == name {
      new_fields.push({ name: f.name, field_type: f.field_type, nullable: false, default_value: f.default_value })
    } else {
      new_fields.push(f)
    }
  }
  { version: s.version, fields: new_fields }
}

/// 设置默认值 / Set default value.
pub fn set_default_value(s : Schema, name : String, value : String) -> Schema {
  let new_fields : Array[Field] = []
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    if f.name == name {
      new_fields.push({ name: f.name, field_type: f.field_type, nullable: f.nullable, default_value: Some(value) })
    } else {
      new_fields.push(f)
    }
  }
  { version: s.version, fields: new_fields }
}

/// 字段是否存在 / Check field existence.
pub fn field_exists(s : Schema, name : String) -> Bool {
  find_field_index(s.fields, name) >= 0
}

/// 获取字段类型 / Get field type.
pub fn get_field_type(s : Schema, name : String) -> FieldType? {
  let idx = find_field_index(s.fields, name)
  if idx >= 0 {
    Some(s.fields[idx].field_type)
  } else {
    None
  }
}

/// 获取字段默认值 / Get field default value.
pub fn get_field_default(s : Schema, name : String) -> String?? {
  let idx = find_field_index(s.fields, name)
  if idx >= 0 {
    Some(s.fields[idx].default_value)
  } else {
    None
  }
}

/// 验证模式 / Validate schema.
pub fn validate_schema(s : Schema) -> Bool {
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    if f.name.length() == 0 {
      return false
    }
    for j in (i + 1)..<n {
      if f.name == s.fields[j].name {
        return false
      }
    }
  }
  true
}

/// 验证记录 / Validate record against schema.
pub fn validate_record(s : Schema, record : Array[(String, String)]) -> Bool {
  let nr = record.length()
  for i in 0..<nr {
    let kv = record[i]
    let key = kv.0
    let val = kv.1
    let idx = find_field_index(s.fields, key)
    if idx == -1 {
      return false
    }
    let f = s.fields[idx]
    if val.length() == 0 && !(f.nullable) {
      return false
    }
  }
  true
}

/// 验证迁移 / Validate migration.
pub fn validate_migration(m : Migration) -> Bool {
  if m.from_version >= m.to_version {
    return false
  }
  let na = m.diff.added.length()
  for i in 0..<na {
    let f = m.diff.added[i]
    if !(f.nullable) && f.default_value is None {
      return false
    }
  }
  true
}

/// 检查可空 / Check nullable.
pub fn check_nullable(s : Schema, name : String) -> Bool {
  let idx = find_field_index(s.fields, name)
  if idx >= 0 {
    s.fields[idx].nullable
  } else {
    false
  }
}

/// 检查唯一 / Check unique field names.
pub fn check_unique(s : Schema) -> Bool {
  let n = s.fields.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if s.fields[i].name == s.fields[j].name {
        return false
      }
    }
  }
  true
}

/// 检查外键 / Check foreign key reference.
pub fn check_foreign_key(s : Schema, ref_schema : Schema, field_name : String) -> Bool {
  let idx = find_field_index(s.fields, field_name)
  if idx == -1 {
    return false
  }
  field_exists(ref_schema, field_name)
}

/// 检查索引 / Check index validity.
pub fn check_index(s : Schema, index_fields : Array[String]) -> Bool {
  let n = index_fields.length()
  for i in 0..<n {
    if !(field_exists(s, index_fields[i])) {
      return false
    }
  }
  true
}

/// 检查约束模式 / Check constraint schema.
pub fn check_constraint_schema(s : Schema, constraints : Array[String]) -> Bool {
  let nc = constraints.length()
  for i in 0..<nc {
    if !(field_exists(s, constraints[i])) {
      return false
    }
  }
  true
}

/// 模式转 JSON / Schema to JSON string.
pub fn schema_to_json(s : Schema) -> String {
  let mut result = "{\"version\":" + s.version.to_string() + ",\"fields\":["
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    result = result + "{\"name\":\"" + f.name + "\",\"type\":\"" + field_type_to_string(f.field_type) + "\",\"nullable\":" + f.nullable.to_string()
    result = result + ",\"default\":"
    match f.default_value {
      Some(v) => result = result + "\"" + v + "\""
      None => result = result + "null"
    }
    result = result + "}"
    if i < n - 1 {
      result = result + ","
    }
  }
  result = result + "]}"
  result
}

/// 从 JSON 构造模式（简化版）/ Schema from JSON (simplified).
pub fn schema_from_json(version : Int, field_names : Array[String], field_types : Array[String]) -> Schema {
  let fields : Array[Field] = []
  let n = field_names.length()
  for i in 0..<n {
    if i < field_types.length() {
      fields.push({ name: field_names[i], field_type: string_to_field_type(field_types[i]), nullable: true, default_value: None })
    }
  }
  { version, fields }
}

/// 模式转 DDL / Schema to DDL.
pub fn schema_to_ddl(s : Schema, table_name : String) -> String {
  let mut result = "CREATE TABLE " + table_name + " ("
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    result = result + f.name + " " + field_type_to_string(f.field_type)
    if !(f.nullable) {
      result = result + " NOT NULL"
    }
    match f.default_value {
      Some(v) => result = result + " DEFAULT '" + v + "'"
      None => ()
    }
    if i < n - 1 {
      result = result + ", "
    }
  }
  result = result + ");"
  result
}

/// 合并模式 / Merge schemas.
pub fn merge_schemas(a : Schema, b : Schema) -> Schema {
  let fields : Array[Field] = []
  let na = a.fields.length()
  for i in 0..<na {
    fields.push(a.fields[i])
  }
  let nb = b.fields.length()
  for i in 0..<nb {
    let f = b.fields[i]
    if find_field_index(fields, f.name) == -1 {
      fields.push(f)
    }
  }
  { version: b.version, fields }
}

/// 交集模式 / Intersect schemas.
pub fn intersect_schemas(a : Schema, b : Schema) -> Schema {
  let fields : Array[Field] = []
  let na = a.fields.length()
  for i in 0..<na {
    let f = a.fields[i]
    if find_field_index(b.fields, f.name) >= 0 {
      fields.push(f)
    }
  }
  { version: a.version, fields }
}

/// 差集模式 / Diff schemas (fields in a but not in b).
pub fn diff_schemas(a : Schema, b : Schema) -> Schema {
  let fields : Array[Field] = []
  let na = a.fields.length()
  for i in 0..<na {
    let f = a.fields[i]
    if find_field_index(b.fields, f.name) == -1 {
      fields.push(f)
    }
  }
  { version: a.version, fields }
}

/// 迁移数据 / Migrate data from old schema to new schema.
pub fn migrate_data(
  old : Schema,
  new : Schema,
  record : Array[(String, String)]
) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  let nn = new.fields.length()
  for i in 0..<nn {
    let f = new.fields[i]
    let mut found = false
    let nr = record.length()
    for j in 0..<nr {
      let kv = record[j]
      if kv.0 == f.name {
        result.push((f.name, kv.1))
        found = true
        break
      }
    }
    if !(found) {
      let old_idx = find_field_index(old.fields, f.name)
      match f.default_value {
        Some(v) => result.push((f.name, v))
        None => if f.nullable || old_idx >= 0 {
          result.push((f.name, ""))
        }
      }
    }
  }
  result
}

/// 转换数据 / Transform data values.
pub fn transform_data(
  record : Array[(String, String)],
  transform_fn : (String, String) -> String
) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  let n = record.length()
  for i in 0..<n {
    let kv = record[i]
    result.push((kv.0, transform_fn(kv.0, kv.1)))
  }
  result
}

/// 转换值类型 / Cast value to target type.
pub fn cast_value(value : String, target_type : FieldType) -> String {
  match target_type {
    Text => value
    Integer => {
      let n = value.length()
      let mut all_digit = true
      for i in 0..<n {
        let c = value[i]
        if c < '0' || c > '9' {
          if !(i == 0 && (c == '-' || c == '+')) {
            all_digit = false
            break
          }
        }
      }
      if all_digit && n > 0 {
        value
      } else {
        "0"
      }
    }
    Float => {
      let n = value.length()
      let mut dot_count = 0
      let mut valid = true
      for i in 0..<n {
        let c = value[i]
        if c == '.' {
          dot_count = dot_count + 1
          if dot_count > 1 {
            valid = false
            break
          }
        } else if (c < '0' || c > '9') && !(i == 0 && (c == '-' || c == '+')) {
          valid = false
          break
        }
      }
      if valid && n > 0 {
        value
      } else {
        "0.0"
      }
    }
    Boolean => {
      if value == "true" || value == "1" || value == "yes" {
        "true"
      } else if value == "false" || value == "0" || value == "no" {
        "false"
      } else {
        "false"
      }
    }
    Nested => value
    Date => {
      if value.length() >= 8 {
        value
      } else {
        "19700101"
      }
    }
  }
}

/// 处理缺失字段 / Handle missing field.
pub fn handle_missing_field(
  s : Schema,
  record : Array[(String, String)],
  field_name : String
) -> String {
  let nr = record.length()
  for i in 0..<nr {
    if record[i].0 == field_name {
      return record[i].1
    }
  }
  let idx = find_field_index(s.fields, field_name)
  if idx >= 0 {
    let f = s.fields[idx]
    match f.default_value {
      Some(v) => return v
      None => ()
    }
  }
  ""
}

/// 处理额外字段 / Handle extra field not in schema.
pub fn handle_extra_field(
  s : Schema,
  record : Array[(String, String)]
) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  let nr = record.length()
  for i in 0..<nr {
    let kv = record[i]
    if field_exists(s, kv.0) {
      result.push(kv)
    }
  }
  result
}

/// 处理类型不匹配 / Handle type mismatch.
pub fn handle_type_mismatch(
  s : Schema,
  record : Array[(String, String)]
) -> Array[(String, String)] {
  let result : Array[(String, String)] = []
  let nr = record.length()
  for i in 0..<nr {
    let kv = record[i]
    let idx = find_field_index(s.fields, kv.0)
    if idx >= 0 {
      let f = s.fields[idx]
      result.push((kv.0, cast_value(kv.1, f.field_type)))
    } else {
      result.push(kv)
    }
  }
  result
}

/// 扩展模式 / Expand schema by adding fields.
pub fn expand_schema(s : Schema, new_fields : Array[Field]) -> Schema {
  let fields : Array[Field] = []
  let ns = s.fields.length()
  for i in 0..<ns {
    fields.push(s.fields[i])
  }
  let nn = new_fields.length()
  for i in 0..<nn {
    let f = new_fields[i]
    if find_field_index(fields, f.name) == -1 {
      fields.push(f)
    }
  }
  { version: s.version + 1, fields }
}

/// 收缩模式 / Contract schema by removing fields.
pub fn contract_schema(s : Schema, remove_names : Array[String]) -> Schema {
  let fields : Array[Field] = []
  let ns = s.fields.length()
  for i in 0..<ns {
    let f = s.fields[i]
    let mut keep = true
    let nr = remove_names.length()
    for j in 0..<nr {
      if f.name == remove_names[j] {
        keep = false
        break
      }
    }
    if keep {
      fields.push(f)
    }
  }
  { version: s.version + 1, fields }
}

/// 演化模式 / Evolve schema with a single action.
pub fn evolve_schema(s : Schema, action : EvolutionAction, field : Field) -> Schema {
  match action {
    AddField => add_field(s, field)
    RemoveField => remove_field(s, field.name)
    RenameField => rename_field(s, field.name, field.name + "_renamed")
    ChangeType => change_field_type(s, field.name, field.field_type)
    MakeOptional => make_field_optional(s, field.name)
    MakeRequired => make_field_required(s, field.name)
  }
}

/// 创建演化计划 / Make an evolution plan.
pub fn make_evolution_plan(from : Schema, to : Schema) -> EvolutionPlan {
  let steps : Array[(EvolutionAction, String)] = []
  let d = schema_diff(from, to)
  let nr = d.removed.length()
  for i in 0..<nr {
    steps.push((RemoveField, d.removed[i].name))
  }
  let na = d.added.length()
  for i in 0..<na {
    steps.push((AddField, d.added[i].name))
  }
  let nm = d.modified.length()
  for i in 0..<nm {
    steps.push((ChangeType, d.modified[i].name))
  }
  let risk = migration_risk(from, to)
  { steps, risk }
}

/// 执行演化 / Execute evolution plan.
pub fn execute_evolution(s : Schema, plan : EvolutionPlan) -> EvolutionResult {
  let mut current = s
  let n = plan.steps.length()
  for i in 0..<n {
    let step = plan.steps[i]
    let action = step.0
    let name = step.1
    match action {
      AddField => current = add_field(current, optional_field(name, Text))
      RemoveField => current = remove_field(current, name)
      RenameField => current = rename_field(current, name, name + "_renamed")
      ChangeType => current = change_field_type(current, name, Text)
      MakeOptional => current = make_field_optional(current, name)
      MakeRequired => current = make_field_required(current, name)
    }
  }
  let msg = "Executed " + n.to_string() + " steps"
  { success: true, new_schema: current, message: msg }
}

/// 回滚演化 / Rollback evolution.
pub fn rollback_evolution(current : Schema, previous : Schema) -> EvolutionResult {
  if validate_schema(previous) {
    { success: true, new_schema: previous, message: "Rollback successful" }
  } else {
    { success: false, new_schema: current, message: "Rollback failed: invalid previous schema" }
  }
}

/// 提交演化 / Commit evolution.
pub fn commit_evolution(s : Schema) -> EvolutionResult {
  if validate_schema(s) {
    { success: true, new_schema: s, message: "Committed version " + s.version.to_string() }
  } else {
    { success: false, new_schema: s, message: "Commit failed: invalid schema" }
  }
}

/// 是否兼容 / Check compatibility.
pub fn is_compatible(old : Schema, new : Schema) -> Compatibility {
  let b = schema_backward_compat(old, new)
  let f = schema_forward_compat(old, new)
  if b && f {
    Full
  } else if b {
    Backward
  } else if f {
    Forward
  } else {
    None
  }
}

/// 兼容性评分 / Compatibility score.
pub fn compatibility_score(old : Schema, new : Schema) -> Double {
  let d = schema_diff(old, new)
  let total = d.added.length() + d.removed.length() + d.modified.length()
  if total == 0 {
    return 1.0
  }
  let b = schema_backward_compat(old, new)
  let f = schema_forward_compat(old, new)
  let mut score = 0.0
  if b {
    score = score + 0.5
  }
  if f {
    score = score + 0.5
  }
  let safe_added : Int = if b {
    d.added.length()
  } else {
    0
  }
  score - 0.01 * (d.removed.length() + d.modified.length() - safe_added / 2).to_double()
}

/// 破坏性变更 / Breaking changes count.
pub fn breaking_changes(old : Schema, new : Schema) -> Int {
  let d = schema_diff(old, new)
  let mut count = d.removed.length()
  let nm = d.modified.length()
  for i in 0..<nm {
    let f = d.modified[i]
    let idx = find_field_index(old.fields, f.name)
    if idx >= 0 {
      let of = old.fields[idx]
      if !(f.nullable) && of.nullable {
        count = count + 1
      }
      if f.field_type != of.field_type {
        count = count + 1
      }
    }
  }
  let na = d.added.length()
  for i in 0..<na {
    let f = d.added[i]
    if !(f.nullable) && f.default_value is None {
      count = count + 1
    }
  }
  count
}

/// 非破坏性变更 / Non-breaking changes count.
pub fn non_breaking_changes(old : Schema, new : Schema) -> Int {
  let d = schema_diff(old, new)
  let mut count = 0
  let na = d.added.length()
  for i in 0..<na {
    let f = d.added[i]
    if f.nullable || f.default_value is Some(_) {
      count = count + 1
    }
  }
  let nm = d.modified.length()
  for i in 0..<nm {
    let f = d.modified[i]
    let idx = find_field_index(old.fields, f.name)
    if idx >= 0 {
      let of = old.fields[idx]
      if f.nullable && !(of.nullable) {
        count = count + 1
      }
    }
  }
  count
}

/// 迁移风险 / Migration risk level.
pub fn migration_risk(old : Schema, new : Schema) -> MigrationRiskLevel {
  let bc = breaking_changes(old, new)
  if bc == 0 {
    Low
  } else if bc <= 2 {
    Medium
  } else if bc <= 5 {
    High
  } else {
    Critical
  }
}

/// 模式字段数 / Schema field count.
pub fn schema_field_count(s : Schema) -> Int {
  s.fields.length()
}

/// 模式相等 / Schema equality.
pub fn schema_equal(a : Schema, b : Schema) -> Bool {
  if a.version != b.version {
    return false
  }
  if a.fields.length() != b.fields.length() {
    return false
  }
  let n = a.fields.length()
  for i in 0..<n {
    if !(field_full_eq(a.fields[i], b.fields[i])) {
      return false
    }
  }
  true
}

/// 模式为空 / Schema is empty.
pub fn schema_is_empty(s : Schema) -> Bool {
  s.fields.length() == 0
}

/// 复制模式 / Copy schema with new version.
pub fn copy_schema(s : Schema, new_version : Int) -> Schema {
  let fields : Array[Field] = []
  let n = s.fields.length()
  for i in 0..<n {
    fields.push(s.fields[i])
  }
  { version: new_version, fields }
}

/// 获取所有字段名 / Get all field names.
pub fn field_names(s : Schema) -> Array[String] {
  let names : Array[String] = []
  let n = s.fields.length()
  for i in 0..<n {
    names.push(s.fields[i].name)
  }
  names
}

/// 获取所有字段类型 / Get all field types.
pub fn field_types(s : Schema) -> Array[FieldType] {
  let types : Array[FieldType] = []
  let n = s.fields.length()
  for i in 0..<n {
    types.push(s.fields[i].field_type)
  }
  types
}

/// 必填字段数 / Required field count.
pub fn required_field_count(s : Schema) -> Int {
  let mut count = 0
  let n = s.fields.length()
  for i in 0..<n {
    if !(s.fields[i].nullable) {
      count = count + 1
    }
  }
  count
}

/// 可选字段数 / Optional field count.
pub fn optional_field_count(s : Schema) -> Int {
  let mut count = 0
  let n = s.fields.length()
  for i in 0..<n {
    if s.fields[i].nullable {
      count = count + 1
    }
  }
  count
}

/// 有默认值的字段数 / Field count with default value.
pub fn default_value_count(s : Schema) -> Int {
  let mut count = 0
  let n = s.fields.length()
  for i in 0..<n {
    if s.fields[i].default_value is Some(_) {
      count = count + 1
    }
  }
  count
}

/// 模式摘要 / Schema summary string.
pub fn schema_summary(s : Schema) -> String {
  let mut result = "Schema v" + s.version.to_string() + " (" + s.fields.length().to_string() + " fields): "
  let n = s.fields.length()
  for i in 0..<n {
    let f = s.fields[i]
    result = result + f.name + ":" + field_type_to_string(f.field_type)
    if f.nullable {
      result = result + "?"
    }
    if i < n - 1 {
      result = result + ", "
    }
  }
  result
}

/// 差异摘要 / Diff summary string.
pub fn diff_summary(d : SchemaDiff) -> String {
  let mut result = "Diff: +" + d.added.length().to_string() + " -" + d.removed.length().to_string() + " ~" + d.modified.length().to_string()
  if d.added.length() > 0 {
    result = result + " [added:"
    let na = d.added.length()
    for i in 0..<na {
      result = result + " " + d.added[i].name
    }
    result = result + "]"
  }
  if d.removed.length() > 0 {
    result = result + " [removed:"
    let nr = d.removed.length()
    for i in 0..<nr {
      result = result + " " + d.removed[i].name
    }
    result = result + "]"
  }
  result
}

/// 迁移摘要 / Migration summary string.
pub fn migration_summary(m : Migration) -> String {
  "Migration v" + m.from_version.to_string() + " -> v" + m.to_version.to_string() + ": " + diff_summary(m.diff)
}

/// 演化计划摘要 / Evolution plan summary.
pub fn evolution_plan_summary(p : EvolutionPlan) -> String {
  let mut result = "Plan (" + p.steps.length().to_string() + " steps, risk=" + risk_to_string(p.risk) + "):"
  let n = p.steps.length()
  for i in 0..<n {
    let step = p.steps[i]
    result = result + " [" + action_to_string(step.0) + ":" + step.1 + "]"
  }
  result
}

/// 包标识 / Package id.
pub fn schema_evol_id() -> String {
  let pkg = "dataobject/schema_evol"
  let version = "S12.10"
  let caps = "version,diff,migration,compat,validation,conversion,evolve"
  let result = pkg + " (" + version + "): " + caps
  if result.length() > 0 {
    result
  } else {
    pkg
  }
}