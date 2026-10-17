///|
/// # dosi 符号语义索引基础设施 / DOSI
///
/// 面向 AI 的数据符号语义索引。核心目标：为 DataVerse 庞大的算子库、
/// Schema、recipe、血缘图建立结构化索引，大幅减少 Agent-Kit 与自演化层
/// 交互时的 Token 消耗。架构 §4.7。
/// S0.7 填充基础设施原型：索引规范定义（二元组）+ builder + router 基础版本。
/// context_budget / verifier 留 Phase 1。
///
/// # DOSI: symbolic-semantic index for AI context control
///
/// Structured index for operators/schemas/recipes/lineage to cut Token usage.
/// See architecture §4.7. S0.7 fills index spec + builder + router prototype.

/// 符号层 / Symbolic layer.
///
/// 算子路径、分类、模态、依赖。架构 §4.7.2。
pub struct SymbolicEntry {
  path : String
  category : String
  modality : String
  dependencies : Array[String]
} derive(Debug, Eq)

pub extend SymbolicEntry with Eq::{equal, not_equal}
pub extend SymbolicEntry with Debug::{to_repr}

/// 语义层 / Semantic layer.
///
/// 核心职责摘要、参数要点、输入输出契约。架构 §4.7.2。
pub struct SemanticEntry {
  summary : String
  params : Array[String]
  contract : String
} derive(Debug, Eq)

pub extend SemanticEntry with Eq::{equal, not_equal}
pub extend SemanticEntry with Debug::{to_repr}

/// DOSI 索引条目（二元组）/ DOSI index entry (symbolic + semantic pair).
pub struct DOSIEntry {
  symbolic : SymbolicEntry
  semantic : SemanticEntry
} derive(Debug, Eq)

pub extend DOSIEntry with Eq::{equal, not_equal}
pub extend DOSIEntry with Debug::{to_repr}

/// DOSI 索引 / DOSI index.
pub struct DOSIIndex {
  entries : Array[DOSIEntry]
} derive(Debug, Eq)

pub extend DOSIIndex with Eq::{equal, not_equal}
pub extend DOSIIndex with Debug::{to_repr}

/// 构造符号层 / Build a symbolic entry.
pub fn SymbolicEntry::new(
  path : String,
  category : String,
  modality : String,
  dependencies : Array[String]
) -> SymbolicEntry {
  { path, category, modality, dependencies }
}

/// 构造语义层 / Build a semantic entry.
pub fn SemanticEntry::new(
  summary : String,
  params : Array[String],
  contract : String
) -> SemanticEntry {
  { summary, params, contract }
}

/// 构造索引条目 / Build a DOSI entry.
pub fn DOSIEntry::new(symbolic : SymbolicEntry, semantic : SemanticEntry) -> DOSIEntry {
  { symbolic, semantic }
}

/// 空索引 / Empty index.
pub fn DOSIIndex::empty() -> DOSIIndex {
  { entries: [] }
}

/// 索引条目数 / Entry count.
pub fn DOSIIndex::size(self : DOSIIndex) -> Int {
  self.entries.length()
}

/// 追加条目 / Add an entry.
pub fn DOSIIndex::add(self : DOSIIndex, entry : DOSIEntry) -> DOSIIndex {
  { entries: self.entries + [entry] }
}

/// 全部条目 / All entries.
pub fn DOSIIndex::entries(self : DOSIIndex) -> Array[DOSIEntry] {
  self.entries
}

/// 从条目数组构造 / Build index from entries.
pub fn DOSIIndex::from_entries(entries : Array[DOSIEntry]) -> DOSIIndex {
  { entries, }
}

/// 移除指定路径的条目 / Remove entry by path.
pub fn DOSIIndex::remove_by_path(self : DOSIIndex, path : String) -> DOSIIndex {
  { entries: self.entries.filter(fn(e) { e.symbolic.path != path }) }
}

pub fn dosi_id() -> String {
  "dosi"
}

/// builder 子包标识 / builder sub-package id.
pub fn builder_id() -> String {
  "dosi/builder"
}

/// router 子包标识 / router sub-package id.
pub fn router_id() -> String {
  "dosi/router"
}