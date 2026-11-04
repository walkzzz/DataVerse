///|
/// # dosi/builder 索引构建器 / DOSI Index Builder
///
/// 解析源码、算子注册表、Schema 定义、recipe、DataIR，自动生成符号坐标、
/// 依赖图谱、契约摘要。架构 §4.7.3。
/// S0.7 基础版本：为 opcore 三类算子 + DataIR 算子 IR 生成索引条目。
///
/// # DOSI index builder
///
/// Generates symbolic-semantic entries from opcore + DataIR. See architecture §4.7.3.

///|
/// 为 opcore 三类算子生成初始索引 / Build initial index for opcore three operators.
///
/// S0.7 为 clean/remove_empty、clean/strip_whitespace、dedup/exact_dedup、
/// filter/length_filter、filter/non_empty_filter 生成索引条目。
pub fn build_opcore_index() -> DOSIIndex {
  let entries = [
    make_clean_remove_empty(),
    make_clean_strip_whitespace(),
    make_dedup_exact_dedup(),
    make_filter_length_filter(),
    make_filter_non_empty_filter(),
  ]
  entries.fold(init=DOSIIndex::empty(), fn(acc, e) { acc.add(e) })
}

///|
/// 为 DataIR 算子 IR 生成索引条目 / Build index entry from operator IR.
///
/// 把 OperatorIR 投影为 DOSI 索引条目：符号层取路径/模态/依赖，语义层取名称/参数/代价。
pub fn build_from_operator_ir(op : @datair.OperatorIR) -> DOSIEntry {
  let path = "datair.operator." + op.name
  let modality = @datair.modality_name(op.modality)
  let deps = op.params.map(fn(p) { p.0 })
  let symbolic = SymbolicEntry::new(path, "operator", modality, deps)
  let params_summary = op.params.map(fn(p) { p.0 + "=" + p.1 })
  let semantic = SemanticEntry::new(
    op.name + ": " + @datair.determinism_name(op.determinism),
    params_summary,
    "cost=" + op.cost_model.time_complexity,
  )
  DOSIEntry::new(symbolic, semantic)
}

///|
/// 合并索引 / Merge two indices.
pub fn merge(a : DOSIIndex, b : DOSIIndex) -> DOSIIndex {
  b.entries().fold(init=a, fn(acc, e) { acc.add(e) })
}

///|
pub fn builder_id() -> String {
  "dosi/builder"
}

///|
fn make_clean_remove_empty() -> DOSIEntry {
  let sym = SymbolicEntry::new(
    "opcore.clean.remove_empty",
    "clean",
    "text",
    [],
  )
  let sem = SemanticEntry::new(
    "remove_empty: 清洗空内容算子",
    [],
    "DataObject -> DataObject, deterministic",
  )
  DOSIEntry::new(sym, sem)
}

///|
fn make_clean_strip_whitespace() -> DOSIEntry {
  let sym = SymbolicEntry::new(
    "opcore.clean.strip_whitespace",
    "clean",
    "text",
    [],
  )
  let sem = SemanticEntry::new(
    "strip_whitespace: 去除首尾空白算子",
    [],
    "DataObject -> DataObject, deterministic",
  )
  DOSIEntry::new(sym, sem)
}

///|
fn make_dedup_exact_dedup() -> DOSIEntry {
  let sym = SymbolicEntry::new(
    "opcore.dedup.exact_dedup",
    "dedup",
    "text",
    [],
  )
  let sem = SemanticEntry::new(
    "exact_dedup: 精确去重算子",
    [],
    "Array[DataObject] -> Array[DataObject], deterministic",
  )
  DOSIEntry::new(sym, sem)
}

///|
fn make_filter_length_filter() -> DOSIEntry {
  let sym = SymbolicEntry::new(
    "opcore.filter.length_filter",
    "filter",
    "text",
    [],
  )
  let sem = SemanticEntry::new(
    "length_filter: 长度过滤算子",
    ["min_len", "max_len"],
    "DataObject -> Bool, deterministic",
  )
  DOSIEntry::new(sym, sem)
}

///|
fn make_filter_non_empty_filter() -> DOSIEntry {
  let sym = SymbolicEntry::new(
    "opcore.filter.non_empty_filter",
    "filter",
    "text",
    [],
  )
  let sem = SemanticEntry::new(
    "non_empty_filter: 非空过滤算子",
    [],
    "DataObject -> Bool, deterministic",
  )
  DOSIEntry::new(sym, sem)
}
