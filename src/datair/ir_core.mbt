///|
/// # datair/ir_core 基础节点 / IR Core: Base Node + Metadata
///
/// DataIR 公共基础：IR 节点唯一标识 + 元数据。架构 §4.6。
/// 被 ir_entity / ir_operator 共享，避免循环依赖。
/// S0.6 填充基础语法。
///
/// # IR core: base node + metadata
///
/// Shared by ir_entity / ir_operator. See architecture §4.6.

///|
/// IR 节点唯一标识 / IR node unique identifier.
///
/// 非空字符串作为节点 id；空串视为无效（退化数据安全处理）。
pub struct IRNodeId {
  value : String
} derive(Debug, Eq)

///|
pub extend IRNodeId with Eq::{equal, not_equal}

///|
pub extend IRNodeId with Debug::{to_repr}

///|
/// IR 元数据 / IR metadata: tags + version + source.
///
/// tags 为任意键值标签集合；version 为语义版本；source 为来源标识（路径/哈希/URL）。
pub struct IRMetadata {
  tags : Array[String]
  version : String
  source : String
} derive(Debug, Eq)

///|
pub extend IRMetadata with Eq::{equal, not_equal}

///|
pub extend IRMetadata with Debug::{to_repr}

///|
/// 构造 IR 节点 id / Build an IR node id.
pub fn IRNodeId::new(id : String) -> IRNodeId {
  { value: id, }
}

///|
/// 节点 id 字符串值 / String value of the node id.
pub fn IRNodeId::value(self : IRNodeId) -> String {
  self.value
}

///|
/// 节点 id 是否有效 / Whether the node id is valid (non-empty).
pub fn IRNodeId::is_valid(self : IRNodeId) -> Bool {
  self.value.length() > 0
}

///|
/// 空元数据 / Empty metadata.
pub fn IRMetadata::empty() -> IRMetadata {
  { tags: [], version: "0.0.0", source: "", }
}

///|
/// 构造元数据 / Build metadata.
pub fn IRMetadata::new(
  tags : Array[String],
  version : String,
  source : String,
) -> IRMetadata {
  { tags, version, source, }
}

///|
/// 元数据标签数 / Tag count of metadata.
pub fn IRMetadata::tag_count(self : IRMetadata) -> Int32 {
  self.tags.length()
}

///|
/// 元数据是否为空 / Whether metadata is empty (no tags and default version).
pub fn IRMetadata::is_empty(self : IRMetadata) -> Bool {
  self.tags.length() == 0 && self.version == "0.0.0" && self.source == ""
}
