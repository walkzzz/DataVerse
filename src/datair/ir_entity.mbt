///|
/// # datair/ir_entity 实体 IR / Entity IR
///
/// DataObject / Chunk / Embedding / Dataset 的结构与元数据投影。架构 §4.6。
/// IR 是源数据的中间表示，不持有源对象引用，避免循环依赖。
/// S0.6 填充基础语法。
///
/// # Entity IR
///
/// Projection of DataObject / Chunk / Embedding / Dataset. See architecture §4.6.

///|
/// 实体类型枚举 / Entity type enum.
///
/// 对应基础数据层四类实体（架构 §4.2）。
pub(all) enum EntityType {
  DataObject
  Chunk
  Embedding
  Dataset
} derive(Debug, Eq)

///|
pub extend EntityType with Eq::{equal, not_equal}

///|
pub extend EntityType with Debug::{to_repr}

///|
/// 实体 IR / Entity IR: projection of DataObject / Chunk / Embedding / Dataset.
///
/// - `schema_ref`：schema 引用（路径或哈希），不内联 schema 定义
/// - `size_hint`：估计大小（元素数或字节数），用于代价估计
/// - `metadata`：IR 元数据（标签 + 版本 + 来源）
pub struct EntityIR {
  node_id : IRNodeId
  entity_type : EntityType
  schema_ref : String
  size_hint : Int32
  metadata : IRMetadata
} derive(Debug, Eq)

///|
pub extend EntityIR with Eq::{equal, not_equal}

///|
pub extend EntityIR with Debug::{to_repr}

///|
/// 构造实体 IR / Build an entity IR.
pub fn EntityIR::new(
  node_id : IRNodeId,
  entity_type : EntityType,
  schema_ref : String,
  size_hint : Int32,
  metadata : IRMetadata,
) -> EntityIR {
  { node_id, entity_type, schema_ref, size_hint, metadata, }
}

///|
/// 简化构造（空元数据）/ Simplified build with empty metadata.
pub fn EntityIR::simple(
  node_id : IRNodeId,
  entity_type : EntityType,
  schema_ref : String,
) -> EntityIR {
  {
    node_id,
    entity_type,
    schema_ref,
    size_hint: 0,
    metadata: IRMetadata::empty(),
  }
}

///|
/// 节点 id / Node id.
pub fn EntityIR::node_id(self : EntityIR) -> IRNodeId {
  self.node_id
}

///|
/// 实体类型 / Entity type.
pub fn EntityIR::entity_type(self : EntityIR) -> EntityType {
  self.entity_type
}

///|
/// schema 引用 / Schema reference.
pub fn EntityIR::schema_ref(self : EntityIR) -> String {
  self.schema_ref
}

///|
/// 估计大小 / Size hint.
pub fn EntityIR::size_hint(self : EntityIR) -> Int32 {
  self.size_hint
}

///|
/// 实体类型名称 / Entity type name.
pub fn entity_type_name(t : EntityType) -> String {
  match t {
    DataObject => "data_object"
    Chunk => "chunk"
    Embedding => "embedding"
    Dataset => "dataset"
  }
}
