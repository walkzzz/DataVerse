///|
/// # dataobject/embedding 向量表示 / Embedding Representation
///
/// 模型标识 + 向量 + 归一化信息。架构 §4.2。
/// S0.3 提供结构定义与构造；嵌入算子在 Phase 1+ 填充。
///
/// # Embedding representation
///
/// Model id + vector + normalization info. See architecture §4.2.
/// S0.3 provides structure and constructors; embedding operators filled in Phase 1+.

/// 向量表示 / Embedding vector.
pub struct Embedding {
  model_id : String
  vector : Array[Double]
  normalized : Bool
} derive(Debug, Eq)

pub extend Embedding with Eq::{equal, not_equal}
pub extend Embedding with Debug::{to_repr}

/// 构造嵌入 / Build an embedding.
pub fn make(model_id : String, vector : Array[Double]) -> Embedding {
  { model_id, vector, normalized: false }
}

/// 构造归一化嵌入 / Build a normalized embedding.
pub fn make_normalized(model_id : String, vector : Array[Double]) -> Embedding {
  { model_id, vector, normalized: true }
}

/// 零向量嵌入（退化安全）/ Zero-vector embedding (degenerate-safe).
pub fn zero(model_id : String) -> Embedding {
  { model_id, vector: [], normalized: true }
}

/// 向量维度 / Vector dimensionality.
pub fn dim(e : Embedding) -> Int {
  e.vector.length()
}

pub fn embedding_id() -> String {
  "dataobject/embedding"
}