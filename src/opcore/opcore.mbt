///|
/// # opcore 全域算子库 / Full-domain Operator Core
///
/// 数据算子 + 模型/学习算子的一等集合。所有算子遵循统一签名
/// `Operator(Input) -> Output + Lineage + Metrics`。
/// 分类：14 类数据算子 + 6 类模型/学习算子，共 20 类。架构 §4.3。
/// S0.4 填充框架（Operator 契约 + OperatorCategory）+ 三类核心算子（clean/dedup/filter）。
///
/// # Full-domain operator core
///
/// Uniform signature `Operator(Input) -> Output + Lineage + Metrics`.
/// 14 data categories + 6 model/learning categories. See architecture §4.3.
/// S0.4 fills framework + three core operators.

/// 算子分类（14 类数据算子）/ Operator category (14 data categories).
pub(all) enum OperatorCategory {
  Ingest        // ① 摄入与解析
  Normalize     // ② 格式化与规范化
  Clean         // ③ 清洗
  Dedup         // ④ 去重
  Filter        // ⑤ 过滤
  Quality       // ⑥ 质量评分
  Transform     // ⑦ 变换与增强
  Annotate      // ⑧ 标注与推理
  Select        // ⑨ 选择与采样
  Mix           // ⑩ 配比与混合
  Pack          // ⑪ 打包与序列化
  Eval          // ⑫ 评估与验证
  Lineage       // ⑬ 血缘与版本
  Safety        // ⑭ 安全与合规
} derive(Debug, Eq)

pub extend OperatorCategory with Eq::{equal, not_equal}
pub extend OperatorCategory with Debug::{to_repr}

/// 算子契约 / Operator contract.
///
/// 架构 §4.3.1。S0.4 实现核心字段；signature/params/cost_model/metrics/ir_form 留后续。
pub struct Operator {
  name : String
  category : OperatorCategory
  modality : @dataobject.Modality
  determinism : @kernel.ExecMode
  reversible : Bool
} derive(Debug, Eq)

pub extend Operator with Eq::{equal, not_equal}
pub extend Operator with Debug::{to_repr}

/// 算子执行结果 / Operator execution result.
///
/// 统一签名 `Operator(Input) -> Output + Lineage + Metrics`。
pub struct OperatorResult {
  output : @dataobject.DataObject
  lineage : @dataobject.Lineage
  metrics : Array[(String, Double)]
} derive(Debug, Eq)

pub extend OperatorResult with Eq::{equal, not_equal}
pub extend OperatorResult with Debug::{to_repr}

/// 构造算子契约 / Build an operator contract.
pub fn make_operator(
  name : String,
  category : OperatorCategory,
  modality : @dataobject.Modality,
  determinism : @kernel.ExecMode,
  reversible : Bool
) -> Operator {
  { name, category, modality, determinism, reversible }
}

/// 构造算子结果 / Build an operator result.
pub fn make_result(
  output : @dataobject.DataObject,
  lineage : @dataobject.Lineage,
  metrics : Array[(String, Double)]
) -> OperatorResult {
  { output, lineage, metrics }
}

/// 算子分类名称 / Category name string.
pub fn category_name(cat : OperatorCategory) -> String {
  match cat {
    Ingest => "ingest"
    Normalize => "normalize"
    Clean => "clean"
    Dedup => "dedup"
    Filter => "filter"
    Quality => "quality"
    Transform => "transform"
    Annotate => "annotate"
    Select => "select"
    Mix => "mix"
    Pack => "pack"
    Eval => "eval"
    Lineage => "lineage"
    Safety => "safety"
  }
}

pub fn opcore_id() -> String {
  "opcore"
}