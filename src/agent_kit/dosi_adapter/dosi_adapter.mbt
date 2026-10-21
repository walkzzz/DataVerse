///|
/// # agent_kit/dosi_adapter DOSI 适配器 / DOSI Adapter
///
/// Agent-Kit 接入 DOSI 的桥接层。架构 §4.8 + §4.7.4。
/// S1.8 基礎：自然语言查询 → DOSI 检索 → 算子路径列表。
///
/// # DOSI adapter for Agent-Kit
///
/// Bridge Agent-Kit to DOSI. See architecture §4.8 + §4.7.4.

///|
/// 查询结果 / Query result: matched operator paths + summaries.
pub struct QueryResult {
  paths : Array[String]
  summaries : Array[String]
  total_matches : Int32
} derive(Debug, Eq)

///|
pub extend QueryResult with Eq::{equal, not_equal}

///|
pub extend QueryResult with Debug::{to_repr}

///|
/// 自然语言查询 DOSI / Query DOSI by natural language keyword.
///
/// 简化版：按关键词匹配索引条目的 summary 或 path。
/// 退化安全：空索引返回空结果。
pub fn query_dosi(index : @dosi.DOSIIndex, keyword : String) -> QueryResult {
  let entries = index.entries()
  let paths = []
  let summaries = []
  for i = 0; i < entries.length(); i = i + 1 {
    let entry = entries[i]
    if entry.semantic.summary.contains(keyword) ||
      entry.symbolic.path.contains(keyword) {
      paths.push(entry.symbolic.path)
      summaries.push(entry.semantic.summary)
    }
  }
  { paths, summaries, total_matches: paths.length(), }
}

///|
/// 规划流水线 / Plan pipeline from keywords.
///
/// 简化版：把关键词列表映射为算子路径列表。
pub fn plan_pipeline(
  index : @dosi.DOSIIndex,
  keywords : Array[String],
) -> Array[String] {
  let result = []
  for i = 0; i < keywords.length(); i = i + 1 {
    let q = query_dosi(index, keywords[i])
    for j = 0; j < q.paths.length(); j = j + 1 {
      result.push(q.paths[j])
    }
  }
  result
}

///|
/// 空查询结果 / Empty query result.
pub fn empty_query_result() -> QueryResult {
  { paths: [], summaries: [], total_matches: 0, }
}

///|
pub fn dosi_adapter_id() -> String {
  "agent_kit/dosi_adapter"
}
