///|
/// # dataobject 一等数据实体 / First-class Data Entities
///
/// 数据一等实体（DataObject）+ 血缘（Lineage）+ 质量档案（QualityCard）+ 模态（Modality）。
/// 架构 §4.2。S0.3 提供结构定义与构造；与 opcore 的双向交互在 S0.4 填充。
///
/// 依赖方向：dataobject 根包 import dataobject/schema（DataObject 引用 Schema）。
/// chunk/embedding/record_dataset 为独立子包，dataobject 根包不 import（避免循环）。
///
/// # First-class data entities
///
/// DataObject + Lineage + QualityCard + Modality. See architecture §4.2.
/// S0.3 provides structure and constructors; opcore interaction filled in S0.4.

/// 模态 / Data modality.
pub(all) enum Modality {
  Text
  Image
  Audio
  Video
  Table
  Code
  Multi
} derive(Debug, Eq)

pub extend Modality with Eq::{equal, not_equal}
pub extend Modality with Debug::{to_repr}

/// 血缘 / Lineage: operator graph + fingerprints + params + environment.
///
/// S0.3 占位字段为字符串；S0.5 datatemporal 填充真实算子图与指纹机制。
pub struct Lineage {
  operator_graph : String
  input_fingerprint : String
  output_fingerprint : String
  params : String
  environment : String
} derive(Debug, Eq)

pub extend Lineage with Eq::{equal, not_equal}
pub extend Lineage with Debug::{to_repr}

/// 质量档案 / Quality card: metrics + thresholds + verdict.
pub struct QualityCard {
  metrics : Array[(String, Double)]
  thresholds : Array[(String, Double)]
  verdict : Bool
} derive(Debug, Eq)

pub extend QualityCard with Eq::{equal, not_equal}
pub extend QualityCard with Debug::{to_repr}

/// 数据一等实体 / DataObject: content + schema + modality + metadata + lineage.
pub struct DataObject {
  content : String
  modality : Modality
  schema : @schema.Schema
  metadata : Array[(String, String)]
  lineage : Lineage?
} derive(Debug, Eq)

pub extend DataObject with Eq::{equal, not_equal}
pub extend DataObject with Debug::{to_repr}

/// 构造血缘 / Build a lineage.
pub fn make_lineage(
  operator_graph : String,
  input_fingerprint : String,
  output_fingerprint : String,
  params : String,
  environment : String
) -> Lineage {
  { operator_graph, input_fingerprint, output_fingerprint, params, environment }
}

/// 空血缘（退化安全）/ Empty lineage (degenerate-safe).
pub fn empty_lineage() -> Lineage {
  { operator_graph: "", input_fingerprint: "", output_fingerprint: "", params: "", environment: "" }
}

/// 构造质量档案 / Build a quality card.
pub fn make_quality_card(
  metrics : Array[(String, Double)],
  thresholds : Array[(String, Double)],
  verdict : Bool
) -> QualityCard {
  { metrics, thresholds, verdict }
}

/// 通过质量档案 / Passing quality card (empty metrics, verdict true).
pub fn passing_quality_card() -> QualityCard {
  { metrics: [], thresholds: [], verdict: true }
}

/// 构造数据对象 / Build a data object.
pub fn make_dataobject(
  content : String,
  modality : Modality,
  schema : @schema.Schema
) -> DataObject {
  { content, modality, schema, metadata: [], lineage: None }
}

/// 构造带元数据的数据对象 / Build a data object with metadata.
pub fn make_dataobject_with_metadata(
  content : String,
  modality : Modality,
  schema : @schema.Schema,
  metadata : Array[(String, String)]
) -> DataObject {
  { content, modality, schema, metadata, lineage: None }
}

/// 空数据对象（退化安全）/ Empty data object (degenerate-safe).
pub fn empty_dataobject(modality : Modality) -> DataObject {
  { content: "", modality, schema: @schema.empty(), metadata: [], lineage: None }
}

/// 内容长度 / Content length.
pub fn content_length(d : DataObject) -> Int {
  d.content.length()
}

/// 是否有血缘 / Whether lineage is attached.
pub fn has_lineage(d : DataObject) -> Bool {
  match d.lineage {
    Some(_) => true
    None => false
  }
}

pub fn dataobject_id() -> String {
  "dataobject"
}