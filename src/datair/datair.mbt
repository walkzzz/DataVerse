///|
/// # datair 全域数据中间表示 / Data Intermediate Representation
///
/// 统一表达三类对象：数据实体、算子、流水线。架构 §4.6。
/// S0.6 填充基础语法：ir_core（基础节点）+ ir_entity（实体 IR）+ ir_operator（算子 IR）。
/// 流水线 IR（DAG）与优化器留 Phase 1。
///
/// # Data intermediate representation
///
/// Uniformly represents three kinds: entities, operators, pipelines.
/// See architecture §4.6. S0.6 fills ir_core + ir_entity + ir_operator.
/// Pipeline IR (DAG) and optimizer deferred to Phase 1.
pub fn datair_id() -> String {
  "datair"
}

/// ir_core 子包标识 / ir_core sub-package id.
pub fn ir_core_id() -> String {
  "datair/ir_core"
}

/// ir_entity 子包标识 / ir_entity sub-package id.
pub fn ir_entity_id() -> String {
  "datair/ir_entity"
}

/// ir_operator 子包标识 / ir_operator sub-package id.
pub fn ir_operator_id() -> String {
  "datair/ir_operator"
}

/// IR 种类数 / IR kind count.
///
/// S0.6 实体 IR + 算子 IR 已落地；流水线 IR 留 Phase 1，此处返回已落地种类数。
pub fn ir_kind_count() -> Int {
  2
}