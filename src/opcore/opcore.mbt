///|
/// # opcore 全域算子库 / Full-domain Operator Core
///
/// 数据算子 + 模型/学习算子的一等集合。所有算子遵循统一签名
/// `Operator(Input) -> Output + Lineage + Metrics`。
/// 分类：14 类数据算子 + 6 类模型/学习算子（ML/DL），共 20 类。
/// 架构 §4.3。S0.1 骨架占位，S0.4 填充框架 + 三类核心算子。
///
/// # Full-domain operator core
///
/// First-class collection of data + model/learning operators.
/// Uniform signature `Operator(Input) -> Output + Lineage + Metrics`.
/// 14 data operator categories + 6 model/learning categories (ML/DL), 20 total.
/// See architecture §4.3. S0.4 fills the framework + three core operators.
pub fn opcore_id() -> String {
  "opcore"
}