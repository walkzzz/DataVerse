///|
/// # datatemporal/lineage 血缘系统 / Lineage System
///
/// 双向血缘 + 字段级血缘。架构 §4.4.2。S0.5 数据结构定型。
///
/// # Lineage system
///
/// Bidirectional + field-level lineage. See architecture §4.4.2.

/// 双向血缘 / Bidirectional lineage: operator + input/output fingerprints.
pub struct BiLineage {
  operator : String
  inputs : Array[String]
  outputs : Array[String]
  params : String
} derive(Debug, Eq)

pub extend BiLineage with Eq::{equal, not_equal}
pub extend BiLineage with Debug::{to_repr}

/// 字段级血缘 / Field-level lineage: field production path.
pub struct FieldLineage {
  field_name : String
  source_fields : Array[String]
  operator : String
} derive(Debug, Eq)

pub extend FieldLineage with Eq::{equal, not_equal}
pub extend FieldLineage with Debug::{to_repr}

/// 构造双向血缘 / Build bidirectional lineage.
pub fn make_bi_lineage(
  operator : String,
  inputs : Array[String],
  outputs : Array[String],
  params : String
) -> BiLineage {
  { operator, inputs, outputs, params }
}

/// 构造字段级血缘 / Build field-level lineage.
pub fn make_field_lineage(
  field_name : String,
  source_fields : Array[String],
  operator : String
) -> FieldLineage {
  { field_name, source_fields, operator }
}

pub fn lineage_id() -> String {
  "datatemporal/lineage"
}