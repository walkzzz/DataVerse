///|
/// # dataobject/chunk 分块单元 / Chunk Unit
///
/// 切片文本/图像区域/表格块，带稳定 ID。架构 §4.2。
/// S0.3 提供结构定义与构造；分块算子在 S0.4 opcore 填充。
///
/// # Chunk unit
///
/// Text slice / image region / table block with stable ID. See architecture §4.2.
/// S0.3 provides structure and constructors; chunking operators filled in S0.4.

/// 分块类型 / Chunk type.
pub(all) enum ChunkType {
  TextSlice
  ImageRegion
  TableBlock
  CodeBlock
} derive(Debug, Eq)

pub extend ChunkType with Eq::{equal, not_equal}
pub extend ChunkType with Debug::{to_repr}

/// 分块单元 / Chunk with stable ID.
pub struct Chunk {
  id : String
  content : String
  chunk_type : ChunkType
} derive(Debug, Eq)

pub extend Chunk with Eq::{equal, not_equal}
pub extend Chunk with Debug::{to_repr}

/// 构造分块 / Build a chunk.
pub fn make(id : String, content : String, chunk_type : ChunkType) -> Chunk {
  { id, content, chunk_type }
}

/// 空内容分块（退化安全）/ Empty-content chunk (degenerate-safe).
pub fn empty_chunk(id : String, chunk_type : ChunkType) -> Chunk {
  { id, content: "", chunk_type }
}

/// 内容长度 / Content length.
pub fn length(c : Chunk) -> Int {
  c.content.length()
}

pub fn chunk_id() -> String {
  "dataobject/chunk"
}