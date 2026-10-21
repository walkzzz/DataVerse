///|
/// S9.4 语义分析深化 / Semantic Analysis Deepening

///|
/// 文本嵌入向量 / Text embedding vector.
pub struct Embedding {
  vector : Array[Double]
}

///|
/// 构造嵌入 / Create embedding.
pub fn make_embedding(vector : Array[Double]) -> Embedding {
  { vector, }
}

///|
/// 嵌入维度 / Embedding dimension.
pub fn embedding_dim(emb : Embedding) -> Int32 {
  emb.vector.length()
}

///|
/// 余弦相似度 / Cosine similarity.
pub fn cosine_similarity(emb1 : Embedding, emb2 : Embedding) -> Double {
  let n = emb1.vector.length()
  if n == 0 || n != emb2.vector.length() {
    return 0.0
  }
  let mut dot = 0.0
  let mut norm1 = 0.0
  let mut norm2 = 0.0
  for i in 0..<n {
    dot = dot + emb1.vector[i] * emb2.vector[i]
    norm1 = norm1 + emb1.vector[i] * emb1.vector[i]
    norm2 = norm2 + emb2.vector[i] * emb2.vector[i]
  }
  if norm1 == 0.0 || norm2 == 0.0 {
    return 0.0
  }
  dot / (norm1.sqrt() * norm2.sqrt())
}

///|
/// 欧氏距离 / Euclidean distance between embeddings.
pub fn embedding_distance(emb1 : Embedding, emb2 : Embedding) -> Double {
  let n = emb1.vector.length()
  if n == 0 || n != emb2.vector.length() {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let diff = emb1.vector[i] - emb2.vector[i]
    sum = sum + diff * diff
  }
  sum.sqrt()
}

///|
/// 点积 / Dot product.
pub fn dot_product(emb1 : Embedding, emb2 : Embedding) -> Double {
  let n = emb1.vector.length()
  if n == 0 || n != emb2.vector.length() {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + emb1.vector[i] * emb2.vector[i]
  }
  sum
}

///|
/// 嵌入归一化 / Normalize embedding.
pub fn normalize_embedding(emb : Embedding) -> Embedding {
  let mut norm = 0.0
  for i in 0..<emb.vector.length() {
    norm = norm + emb.vector[i] * emb.vector[i]
  }
  norm = norm.sqrt()
  if norm == 0.0 {
    return emb
  }
  let result : Array[Double] = []
  for i in 0..<emb.vector.length() {
    result.push(emb.vector[i] / norm)
  }
  { vector: result, }
}

///|
/// K-最近邻搜索 / K-nearest neighbors search.
pub fn knn_search(
  query : Embedding,
  database : Array[Embedding],
  k : Int32,
) -> Array[(Int32, Double)] {
  let scores : Array[(Int32, Double)] = []
  for i in 0..<database.length() {
    let sim = cosine_similarity(query, database[i])
    scores.push((i, sim))
  }
  scores.sort_by(fn(a, b) {
    if a.1 > b.1 {
      -1
    } else if a.1 < b.1 {
      1
    } else {
      0
    }
  })
  let result : Array[(Int32, Double)] = []
  let n = if k < scores.length() { k } else { scores.length() }
  for i in 0..<n {
    result.push(scores[i])
  }
  result
}

///|
/// 质心嵌入 / Centroid embedding (average of multiple embeddings).
pub fn centroid_embedding(embeddings : Array[Embedding]) -> Embedding {
  if embeddings.length() == 0 {
    return { vector: [], }
  }
  let dim = embeddings[0].vector.length()
  let result : Array[Double] = Array::make(dim, 0.0)
  for i in 0..<embeddings.length() {
    for j in 0..<dim {
      if j < embeddings[i].vector.length() {
        result[j] = result[j] + embeddings[i].vector[j]
      }
    }
  }
  let n = embeddings.length().to_double()
  for j in 0..<dim {
    result[j] = result[j] / n
  }
  { vector: result, }
}

///|
/// 文本分类（简化）/ Text classification (simplified, nearest centroid).
pub fn classify_text(
  query : Embedding,
  centroids : Array[(String, Embedding)],
) -> String {
  let mut best_label = ""
  let mut best_sim = -2.0
  for i in 0..<centroids.length() {
    let (label, emb) = centroids[i]
    let sim = cosine_similarity(query, emb)
    if sim > best_sim {
      best_sim = sim
      best_label = label
    }
  }
  best_label
}

///|
/// 词频向量 / Term frequency vector.
pub fn term_frequency_vector(
  tokens : Array[String],
  vocabulary : Array[String],
) -> Embedding {
  let result : Array[Double] = Array::make(vocabulary.length(), 0.0)
  for i in 0..<tokens.length() {
    for j in 0..<vocabulary.length() {
      if tokens[i] == vocabulary[j] {
        result[j] = result[j] + 1.0
      }
    }
  }
  { vector: result, }
}
