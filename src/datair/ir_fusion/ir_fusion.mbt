///|
/// # datair/ir_fusion 算子融合优化 / Operator Fusion Optimization
///
/// 相邻 map 类算子融合为单趟处理。架构 §7 可融合属性。S3.4 填充。
///
/// # Operator fusion
///
/// Fuse adjacent map operators into single pass.

/// 融合规则 / Fusion rule.
pub(all) enum FusionRule {
  MapFusion          // 相邻 map 融合
  FilterFusion       // 相邻 filter 融合
  IdentityElimination // 恒等算子消除
  DeadCodeElimination // 死代码消除
} derive(Debug, Eq)

pub extend FusionRule with Eq::{equal, not_equal}
pub extend FusionRule with Debug::{to_repr}

/// 融合规则名称 / Fusion rule name.
pub fn fusion_rule_name(rule : FusionRule) -> String {
  match rule {
    MapFusion => "map_fusion"
    FilterFusion => "filter_fusion"
    IdentityElimination => "identity_elimination"
    DeadCodeElimination => "dead_code_elimination"
  }
}

/// 融合结果 / Fusion result.
pub struct FusionResult {
  original_node_count : Int
  fused_node_count : Int
  rules_applied : Array[FusionRule]
  reduction : Int
} derive(Debug, Eq)

pub extend FusionResult with Eq::{equal, not_equal}
pub extend FusionResult with Debug::{to_repr}

/// 构造融合结果 / Build fusion result.
pub fn make_fusion_result(
  original_node_count : Int,
  fused_node_count : Int,
  rules_applied : Array[FusionRule]
) -> FusionResult {
  { original_node_count, fused_node_count, rules_applied, reduction: original_node_count - fused_node_count }
}

/// 应用融合优化 / Apply fusion optimization.
///
/// 模拟：对 PipelineIR 应用所有融合规则，返回融合结果。
/// 策略：每对相邻 map 算子融合为 1 个（节点数减半），恒等算子消除。
/// 退化安全：空流水线返回空结果。
pub fn apply_fusion(pipeline : @ir_pipeline.PipelineIR) -> FusionResult {
  let original = pipeline.nodes.length()
  if original == 0 {
    make_fusion_result(0, 0, [])
  } else {
    let rules : Array[FusionRule] = [MapFusion, FilterFusion, IdentityElimination]
    let fused = if original <= 1 { original } else { (original + 1) / 2 }
    make_fusion_result(original, fused, rules)
  }
}

/// 融合收益率 / Fusion reduction ratio.
///
/// 公式：`reduction / original`。
/// 退化安全：original=0 返回 0.0。
pub fn fusion_reduction_ratio(result : FusionResult) -> Double {
  if result.original_node_count == 0 {
    0.0
  } else {
    result.reduction.to_double() / result.original_node_count.to_double()
  }
}

/// 融合结果 URI / Fusion result URI.
pub fn fusion_result_uri(result : FusionResult) -> String {
  "fusion://nodes=" + result.original_node_count.to_string() + "->" + result.fused_node_count.to_string() + ";reduction=" + result.reduction.to_string()
}

/// 多次融合 / Apply fusion multiple times.
///
/// 模拟：对融合结果再次融合，直到节点数不再减少。
pub fn iterative_fusion(pipeline : @ir_pipeline.PipelineIR, max_rounds : Int) -> FusionResult {
  let result = apply_fusion(pipeline)
  if max_rounds <= 1 || result.fused_node_count <= 1 {
    result
  } else {
    let rules : Array[FusionRule] = [MapFusion, FilterFusion, IdentityElimination, DeadCodeElimination]
    let final_count = if result.fused_node_count <= 1 { result.fused_node_count } else { 1 }
    make_fusion_result(result.original_node_count, final_count, rules)
  }
}

pub fn ir_fusion_id() -> String {
  "datair/ir_fusion"
}