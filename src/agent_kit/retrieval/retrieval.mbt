///|
/// # agent_kit/retrieval 检索增强 / Retrieval Augmentation
///
/// 向量检索、关键词检索、混合检索、重排序。
/// S11.2 新建。
///
/// # Retrieval augmentation operators

/// 检索方法 / Retrieval method_.
pub(all) enum RetrievalMethod {
  VectorSearch
  KeywordSearch
  HybridSearch
  SemanticSearch
}

/// 文档 / Document.
pub(all) struct Document {
  id : String
  content : String
  embedding : Array[Double]
  metadata : String
  score : Double
}

/// 检索结果 / Retrieval result.
pub struct RetrievalResult {
  document : Document
  method_ : RetrievalMethod
  rank : Int
}

/// 构造文档 / Create document.
pub fn make_document(
  id : String,
  content : String,
  embedding : Array[Double],
  metadata : String,
) -> Document {
  { id: id, content: content, embedding: embedding, metadata: metadata, score: 0.0 }
}

/// 构造检索结果 / Create retrieval result.
pub fn make_retrieval_result(document : Document, method_ : RetrievalMethod, rank : Int) -> RetrievalResult {
  { document: document, method_: method_, rank: rank }
}

///===
/// 向量检索 / Vector search

/// 余弦相似度 / Cosine similarity.
pub fn cosine_similarity(a : Array[Double], b : Array[Double]) -> Double {
  let len = if a.length() < b.length() { a.length() } else { b.length() }
  if len == 0 {
    return 0.0
  }
  let mut dot = 0.0
  let mut norm_a = 0.0
  let mut norm_b = 0.0
  for i in 0..<len {
    dot = dot + a[i] * b[i]
    norm_a = norm_a + a[i] * a[i]
    norm_b = norm_b + b[i] * b[i]
  }
  let denom = sqrt_(norm_a) * sqrt_(norm_b)
  if denom == 0.0 { 0.0 } else { dot / denom }
}

fn sqrt_(x : Double) -> Double {
  if x < 0.0 { return 0.0 }
  if x == 0.0 { return 0.0 }
  let mut guess = x / 2.0
  if guess == 0.0 { guess = 1.0 }
  for _ in 0..<50 {
    guess = (guess + x / guess) / 2.0
  }
  guess
}

/// 向量检索 / Vector search.
pub fn vector_search(
  query_embedding : Array[Double],
  documents : Array[Document],
  top_k : Int,
) -> Array[RetrievalResult] {
  let scored : Array[Document] = []
  for i in 0..<documents.length() {
    let sim = cosine_similarity(query_embedding, documents[i].embedding)
    scored.push({ ..documents[i], score: sim })
  }
  scored.sort_by(fn(a, b) { b.score.compare(a.score) })
  let result : Array[RetrievalResult] = []
  let k = if top_k < scored.length() { top_k } else { scored.length() }
  for i in 0..<k {
    result.push(make_retrieval_result(scored[i], VectorSearch, i + 1))
  }
  result
}

///===
/// 关键词检索 / Keyword search

/// 关键词检索 / Keyword search.
pub fn keyword_search(
  query : String,
  documents : Array[Document],
  top_k : Int,
) -> Array[RetrievalResult] {
  let query_lower = query
  let scored : Array[Document] = []
  for i in 0..<documents.length() {
    let score = keyword_score(query_lower, documents[i].content)
    scored.push({ ..documents[i], score: score })
  }
  scored.sort_by(fn(a, b) { b.score.compare(a.score) })
  let result : Array[RetrievalResult] = []
  let k = if top_k < scored.length() { top_k } else { scored.length() }
  for i in 0..<k {
    result.push(make_retrieval_result(scored[i], KeywordSearch, i + 1))
  }
  result
}

fn keyword_score(query : String, content : String) -> Double {
  let mut score = 0.0
  let query_words = query.split(" ").to_array()
  for i in 0..<query_words.length() {
    let word = query_words[i].to_owned()
    if word.length() > 0 && content.contains(word) {
      score = score + 1.0
    }
  }
  score
}

///===
/// 混合检索 / Hybrid search

/// 混合检索 / Hybrid search (combine vector + keyword).
pub fn hybrid_search(
  query : String,
  query_embedding : Array[Double],
  documents : Array[Document],
  top_k : Int,
  vector_weight : Double,
) -> Array[RetrievalResult] {
  let keyword_weight = 1.0 - vector_weight
  let vector_results = vector_search(query_embedding, documents, documents.length())
  let keyword_results = keyword_search(query, documents, documents.length())
  let scored : Array[Document] = []
  for i in 0..<documents.length() {
    let mut v_score = 0.0
    let mut k_score = 0.0
    for j in 0..<vector_results.length() {
      if vector_results[j].document.id == documents[i].id {
        v_score = vector_results[j].document.score
      }
    }
    for j in 0..<keyword_results.length() {
      if keyword_results[j].document.id == documents[i].id {
        k_score = keyword_results[j].document.score
      }
    }
    let combined = vector_weight * v_score + keyword_weight * k_score
    scored.push({ ..documents[i], score: combined })
  }
  scored.sort_by(fn(a, b) { b.score.compare(a.score) })
  let result : Array[RetrievalResult] = []
  let k = if top_k < scored.length() { top_k } else { scored.length() }
  for i in 0..<k {
    result.push(make_retrieval_result(scored[i], HybridSearch, i + 1))
  }
  result
}

///===
/// 重排序 / Re-ranking

/// 重排序 / Re-rank results by score.
pub fn rerank(results : Array[RetrievalResult]) -> Array[RetrievalResult] {
  let sorted = results.copy()
  sorted.sort_by(fn(a, b) { b.document.score.compare(a.document.score) })
  let result : Array[RetrievalResult] = []
  for i in 0..<sorted.length() {
    result.push({ ..sorted[i], rank: i + 1 })
  }
  result
}

/// 去重 / Deduplicate results.
pub fn deduplicate_results(results : Array[RetrievalResult]) -> Array[RetrievalResult] {
  let seen : Array[String] = []
  let result : Array[RetrievalResult] = []
  for i in 0..<results.length() {
    let mut found = false
    for j in 0..<seen.length() {
      if seen[j] == results[i].document.id {
        found = true
      }
    }
    if !(found) {
      seen.push(results[i].document.id)
      result.push(results[i])
    }
  }
  result
}

///===
/// 方法名称 / Method name

pub fn method_name(method_ : RetrievalMethod) -> String {
  match method_ {
    VectorSearch => "vector"
    KeywordSearch => "keyword"
    HybridSearch => "hybrid"
    SemanticSearch => "semantic"
  }
}

///===
/// ID

pub fn retrieval_id() -> String {
  "agent_kit/retrieval"
}