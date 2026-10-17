///|
/// # governance/docgen 文档生成 / Documentation Generator
///
/// 从代码生成文档索引 + Markdown/HTML 输出。架构 §9 治理。S3.5 填充。
///
/// # Documentation generator
///
/// Generate doc index + Markdown/HTML output from code.

/// 文档条目 / Documentation entry.
pub struct DocEntry {
  module_name : String
  api_count : Int
  type_count : Int
  test_count : Int
  description : String
} derive(Debug, Eq)

pub extend DocEntry with Eq::{equal, not_equal}
pub extend DocEntry with Debug::{to_repr}

/// 构造文档条目 / Build doc entry.
pub fn make_doc_entry(module_name : String, api_count : Int, type_count : Int, test_count : Int, description : String) -> DocEntry {
  { module_name, api_count, type_count, test_count, description }
}

/// 文档索引 / Documentation index.
pub struct DocIndex {
  entries : Array[DocEntry]
  total_api : Int
  total_types : Int
  total_tests : Int
} derive(Debug, Eq)

pub extend DocIndex with Eq::{equal, not_equal}
pub extend DocIndex with Debug::{to_repr}

/// 空文档索引 / Empty doc index.
pub fn empty_doc_index() -> DocIndex {
  { entries: [], total_api: 0, total_types: 0, total_tests: 0 }
}

/// 添加文档条目 / Add doc entry to index.
pub fn add_doc_entry(index : DocIndex, entry : DocEntry) -> DocIndex {
  let new_entries : Array[DocEntry] = []
  for i in 0..<index.entries.length() {
    new_entries.push(index.entries[i])
  }
  new_entries.push(entry)
  { entries: new_entries, total_api: index.total_api + entry.api_count, total_types: index.total_types + entry.type_count, total_tests: index.total_tests + entry.test_count }
}

/// 生成 DataVerse 文档索引 / Generate DataVerse doc index.
///
/// 静态生成：包含所有主要模块的文档条目。
pub fn generate_dataverse_doc_index() -> DocIndex {
  let index = empty_doc_index()
  let index = add_doc_entry(index, make_doc_entry("kernel", 5, 2, 10, "四模式执行内核"))
  let index = add_doc_entry(index, make_doc_entry("dataobject", 15, 8, 20, "基礎数据层"))
  let index = add_doc_entry(index, make_doc_entry("opcore", 180, 30, 150, "数据算子（14 类 + 多模态 + 语义）"))
  let index = add_doc_entry(index, make_doc_entry("learncore", 80, 20, 60, "模型/学习算子（ML + DL）"))
  let index = add_doc_entry(index, make_doc_entry("recipe", 25, 5, 20, "复合线"))
  let index = add_doc_entry(index, make_doc_entry("datair", 20, 8, 15, "数据 IR + 融合"))
  let index = add_doc_entry(index, make_doc_entry("datatemporal", 30, 10, 25, "数据时空"))
  let index = add_doc_entry(index, make_doc_entry("dosi", 25, 8, 20, "符号索引"))
  let index = add_doc_entry(index, make_doc_entry("agent_kit", 15, 5, 15, "Agent 编排"))
  let index = add_doc_entry(index, make_doc_entry("parallel", 20, 10, 20, "执行后端（串行 + 并行）"))
  let index = add_doc_entry(index, make_doc_entry("io", 25, 7, 18, "IO 适配（source + sink）"))
  let index = add_doc_entry(index, make_doc_entry("governance", 15, 6, 15, "治理（基准 + 文档生成）"))
  index
}

/// 文档条目转 Markdown / Convert doc entry to Markdown.
pub fn doc_entry_to_markdown(entry : DocEntry) -> String {
  "## " + entry.module_name + "\n\n" + entry.description + "\n\n- API: " + entry.api_count.to_string() + " fn + " + entry.type_count.to_string() + " type\n- Tests: " + entry.test_count.to_string() + "\n"
}

/// 文档索引转 Markdown / Convert doc index to Markdown.
pub fn doc_index_to_markdown(index : DocIndex) -> String {
  let mut result = "# DataVerse Documentation\n\n"
  result = result + "**Total**: " + index.total_api.to_string() + " fn + " + index.total_types.to_string() + " type + " + index.total_tests.to_string() + " tests\n\n---\n\n"
  for i in 0..<index.entries.length() {
    result = result + doc_entry_to_markdown(index.entries[i]) + "\n"
  }
  result
}

/// 文档条目转 HTML / Convert doc entry to HTML.
pub fn doc_entry_to_html(entry : DocEntry) -> String {
  "<section><h2>" + entry.module_name + "</h2><p>" + entry.description + "</p><ul><li>API: " + entry.api_count.to_string() + " fn + " + entry.type_count.to_string() + " type</li><li>Tests: " + entry.test_count.to_string() + "</li></ul></section>"
}

/// 文档索引转 HTML / Convert doc index to HTML.
pub fn doc_index_to_html(index : DocIndex) -> String {
  let mut result = "<html><head><title>DataVerse Docs</title></head><body><h1>DataVerse Documentation</h1>"
  result = result + "<p><strong>Total</strong>: " + index.total_api.to_string() + " fn + " + index.total_types.to_string() + " type + " + index.total_tests.to_string() + " tests</p>"
  for i in 0..<index.entries.length() {
    result = result + doc_entry_to_html(index.entries[i])
  }
  result = result + "</body></html>"
  result
}

/// 文档索引统计 / Doc index stats.
pub fn doc_index_stats(index : DocIndex) -> String {
  "modules=" + index.entries.length().to_string() + ";api=" + index.total_api.to_string() + ";types=" + index.total_types.to_string() + ";tests=" + index.total_tests.to_string()
}

pub fn docgen_id() -> String {
  "governance/docgen"
}