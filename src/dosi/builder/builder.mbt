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

/// 为 opcore 三类算子生成初始索引 / Build initial index for opcore three operators.
///
/// S0.7 为 clean/remove_empty、clean/strip_whitespace、dedup/exact_dedup、
/// filter/length_filter、filter/non_empty_filter 生成索引条目。
pub fn build_opcore_index() -> @dosi.DOSIIndex {
  let entries = [
    make_clean_remove_empty(),
    make_clean_strip_whitespace(),
    make_dedup_exact_dedup(),
    make_filter_length_filter(),
    make_filter_non_empty_filter(),
  ]
  entries.fold(init=@dosi.DOSIIndex::empty(), fn(acc, e) { acc.add(e) })
}

/// 为 DataIR 算子 IR 生成索引条目 / Build index entry from operator IR.
///
/// 把 OperatorIR 投影为 DOSI 索引条目：符号层取路径/模态/依赖，语义层取名称/参数/代价。
pub fn build_from_operator_ir(op : @ir_operator.OperatorIR) -> @dosi.DOSIEntry {
  let path = "datair.operator." + op.name
  let modality = @ir_operator.modality_name(op.modality)
  let deps = op.params.map(fn(p) { p.0 })
  let symbolic = @dosi.SymbolicEntry::new(path, "operator", modality, deps)
  let params_summary = op.params.map(fn(p) { p.0 + "=" + p.1 })
  let semantic = @dosi.SemanticEntry::new(
    op.name + ": " + @ir_operator.determinism_name(op.determinism),
    params_summary,
    "cost=" + op.cost_model.time_complexity,
  )
  @dosi.DOSIEntry::new(symbolic, semantic)
}

/// 合并索引 / Merge two indices.
pub fn merge(a : @dosi.DOSIIndex, b : @dosi.DOSIIndex) -> @dosi.DOSIIndex {
  b.entries().fold(init=a, fn(acc, e) { acc.add(e) })
}

pub fn builder_id() -> String {
  "dosi/builder"
}

fn make_clean_remove_empty() -> @dosi.DOSIEntry {
  let sym = @dosi.SymbolicEntry::new("opcore.clean.remove_empty", "clean", "text", [])
  let sem = @dosi.SemanticEntry::new(
    "remove_empty: 清洗空内容算子", [], "DataObject -> DataObject, deterministic",
  )
  @dosi.DOSIEntry::new(sym, sem)
}

fn make_clean_strip_whitespace() -> @dosi.DOSIEntry {
  let sym = @dosi.SymbolicEntry::new(
    "opcore.clean.strip_whitespace", "clean", "text", [],
  )
  let sem = @dosi.SemanticEntry::new(
    "strip_whitespace: 去除首尾空白算子", [], "DataObject -> DataObject, deterministic",
  )
  @dosi.DOSIEntry::new(sym, sem)
}

fn make_dedup_exact_dedup() -> @dosi.DOSIEntry {
  let sym = @dosi.SymbolicEntry::new("opcore.dedup.exact_dedup", "dedup", "text", [])
  let sem = @dosi.SemanticEntry::new(
    "exact_dedup: 精确去重算子", [], "Array[DataObject] -> Array[DataObject], deterministic",
  )
  @dosi.DOSIEntry::new(sym, sem)
}

fn make_filter_length_filter() -> @dosi.DOSIEntry {
  let sym = @dosi.SymbolicEntry::new(
    "opcore.filter.length_filter", "filter", "text", [],
  )
  let sem = @dosi.SemanticEntry::new(
    "length_filter: 长度过滤算子", ["min_len", "max_len"], "DataObject -> Bool, deterministic",
  )
  @dosi.DOSIEntry::new(sym, sem)
}

fn make_filter_non_empty_filter() -> @dosi.DOSIEntry {
  let sym = @dosi.SymbolicEntry::new(
    "opcore.filter.non_empty_filter", "filter", "text", [],
  )
  let sem = @dosi.SemanticEntry::new(
    "non_empty_filter: 非空过滤算子", [], "DataObject -> Bool, deterministic",
  )
  @dosi.DOSIEntry::new(sym, sem)
}