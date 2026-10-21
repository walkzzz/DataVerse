///|
/// # datair/ir_operator 算子 IR / Operator IR
///
/// 原子算子节点：名称、参数、模态、确定性、代价模型。架构 §4.6。
/// IR 模态与确定性独立定义，避免循环依赖 dataobject/opcore。
/// S0.6 填充基础语法。
///
/// # Operator IR
///
/// Atomic operator node: name, params, modality, determinism, cost model.
/// See architecture §4.6.

///|
/// 确定性枚举 / Determinism enum.
///
/// - `Deterministic`：确定性算子（同输入同输出，如 exact_dedup）
/// - `ApproximateWithSeed(seed)`：带种子近似（可复现，如 minhash_dedup）
/// - `NonDeterministic`：非确定性（如涉及外部模型调用的算子）
pub(all) enum Determinism {
  Deterministic
  ApproximateWithSeed(Int32)
  NonDeterministic
} derive(Debug, Eq)

///|
pub extend Determinism with Eq::{equal, not_equal}

///|
pub extend Determinism with Debug::{to_repr}

///|
/// IR 模态枚举 / IR modality enum.
///
/// 独立定义以避免循环依赖 dataobject；与 dataobject.Modality 一一对应。
pub(all) enum IRModality {
  Text
  Image
  Audio
  Video
  Table
  Code
  Multi
} derive(Debug, Eq)

///|
pub extend IRModality with Eq::{equal, not_equal}

///|
pub extend IRModality with Debug::{to_repr}

///|
/// 代价模型 / Cost model.
///
/// - `time_complexity`：时间复杂度记号（"O(n)", "O(n log n)" 等）
/// - `space_complexity`：空间复杂度记号
/// - `estimated_cost`：归一化估计开销 0.0-1.0，用于调度排序
pub struct CostModel {
  time_complexity : String
  space_complexity : String
  estimated_cost : Double
} derive(Debug, Eq)

///|
pub extend CostModel with Eq::{equal, not_equal}

///|
pub extend CostModel with Debug::{to_repr}

///|
/// 算子 IR / Operator IR: atomic operator node.
///
/// - `params`：参数键值对（字符串化），用于序列化与跨语言传输
/// - `modality`：算子主模态（多模态算子用 Multi）
/// - `determinism`：确定性级别
/// - `cost_model`：代价模型，供优化器与调度器使用
pub struct OperatorIR {
  node_id : @ir_core.IRNodeId
  name : String
  params : Array[(String, String)]
  modality : IRModality
  determinism : Determinism
  cost_model : CostModel
  metadata : @ir_core.IRMetadata
} derive(Debug, Eq)

///|
pub extend OperatorIR with Eq::{equal, not_equal}

///|
pub extend OperatorIR with Debug::{to_repr}

///|
/// 构造代价模型 / Build a cost model.
pub fn CostModel::new(
  time_complexity : String,
  space_complexity : String,
  estimated_cost : Double,
) -> CostModel {
  { time_complexity, space_complexity, estimated_cost, }
}

///|
/// 简化代价模型（O(n), O(n), 0.5）/ Simple cost model.
pub fn CostModel::simple() -> CostModel {
  { time_complexity: "O(n)", space_complexity: "O(n)", estimated_cost: 0.5, }
}

///|
/// 时间复杂度 / Time complexity.
pub fn CostModel::time_complexity(self : CostModel) -> String {
  self.time_complexity
}

///|
/// 空间复杂度 / Space complexity.
pub fn CostModel::space_complexity(self : CostModel) -> String {
  self.space_complexity
}

///|
/// 估计开销 / Estimated cost.
pub fn CostModel::estimated_cost(self : CostModel) -> Double {
  self.estimated_cost
}

///|
/// 构造算子 IR / Build an operator IR.
pub fn OperatorIR::new(
  node_id : @ir_core.IRNodeId,
  name : String,
  params : Array[(String, String)],
  modality : IRModality,
  determinism : Determinism,
  cost_model : CostModel,
  metadata : @ir_core.IRMetadata,
) -> OperatorIR {
  { node_id, name, params, modality, determinism, cost_model, metadata, }
}

///|
/// 简化构造（无参数、简单代价、空元数据）/ Simplified build.
pub fn OperatorIR::simple(
  node_id : @ir_core.IRNodeId,
  name : String,
  modality : IRModality,
  determinism : Determinism,
) -> OperatorIR {
  {
    node_id,
    name,
    params: [],
    modality,
    determinism,
    cost_model: CostModel::simple(),
    metadata: @ir_core.IRMetadata::empty(),
  }
}

///|
/// 节点 id / Node id.
pub fn OperatorIR::node_id(self : OperatorIR) -> @ir_core.IRNodeId {
  self.node_id
}

///|
/// 算子名称 / Operator name.
pub fn OperatorIR::name(self : OperatorIR) -> String {
  self.name
}

///|
/// 参数数 / Parameter count.
pub fn OperatorIR::param_count(self : OperatorIR) -> Int32 {
  self.params.length()
}

///|
/// 确定性名称 / Determinism name.
pub fn determinism_name(d : Determinism) -> String {
  match d {
    Deterministic => "deterministic"
    ApproximateWithSeed(_) => "approximate(seed)"
    NonDeterministic => "non-deterministic"
  }
}

///|
/// 模态名称 / Modality name.
pub fn modality_name(m : IRModality) -> String {
  match m {
    Text => "text"
    Image => "image"
    Audio => "audio"
    Video => "video"
    Table => "table"
    Code => "code"
    Multi => "multi"
  }
}
