///|
/// # dataobject/record_dataset 记录与数据集 / Record and Dataset
///
/// 单条样本（Record）与数据集（Dataset）。架构 §4.2。
/// S0.3 提供结构定义与构造；配比/质量档案关联在后续 Sprint 填充。
///
/// # Record and Dataset
///
/// Single sample (Record) and dataset (Dataset). See architecture §4.2.
/// S0.3 provides structure and constructors; mixing/quality linking filled later.

///|
/// 单条记录 / A single record with named fields.
///
/// 字段值为字符串化表示（统一基座），具体类型由 Schema 约束。
pub struct Record {
  id : String
  fields : Array[(String, String)]
} derive(Debug, Eq)

///|
pub extend Record with Eq::{equal, not_equal}

///|
pub extend Record with Debug::{to_repr}

///|
/// 数据集 / Dataset: record collection with version and mix ratio.
pub struct Dataset {
  records : Array[Record]
  version : String
  mix_ratio : Double
} derive(Debug, Eq)

///|
pub extend Dataset with Eq::{equal, not_equal}

///|
pub extend Dataset with Debug::{to_repr}

///|
/// 构造记录 / Build a record.
pub fn make_record(id : String, fields : Array[(String, String)]) -> Record {
  { id, fields, }
}

///|
/// 空记录（退化安全）/ Empty record (degenerate-safe).
pub fn empty_record(id : String) -> Record {
  { id, fields: [], }
}

///|
/// 记录字段数 / Field count of a record.
pub fn record_field_count(r : Record) -> Int32 {
  r.fields.length()
}

///|
/// 构造数据集 / Build a dataset.
pub fn make_dataset(records : Array[Record], version : String) -> Dataset {
  { records, version, mix_ratio: 1.0, }
}

///|
/// 构造带配比的数据集 / Build a dataset with mix ratio.
pub fn make_dataset_with_ratio(
  records : Array[Record],
  version : String,
  mix_ratio : Double,
) -> Dataset {
  { records, version, mix_ratio, }
}

///|
/// 空数据集（退化安全）/ Empty dataset (degenerate-safe).
pub fn empty_dataset(version : String) -> Dataset {
  { records: [], version, mix_ratio: 1.0, }
}

///|
/// 数据集记录数 / Record count of a dataset.
pub fn size(d : Dataset) -> Int32 {
  d.records.length()
}

///|
pub fn record_dataset_id() -> String {
  "dataobject/record_dataset"
}
