///|
/// # datair/ir_optimizer 基礎优化器 / Basic Optimizer
///
/// 算子融合 + 恒等消除 + 重排。架构 §4.6。
/// S1.4 基礎：fuse_adjacent_maps + remove_identity + optimize。
///
/// # Basic optimizer
///
/// Operator fusion + identity elimination + reorder. See architecture §4.6.

///|
/// 融合相邻同名 map 类算子 / Fuse adjacent same-name map operators.
///
/// 若流水线中有连续两个同名算子（如 normalize→normalize），融合为一个。
/// 幂等性声明：normalize/dedup 等同名连续出现可消除冗余。
pub fn fuse_adjacent_maps(
  pipeline : PipelineIR,
) -> PipelineIR {
  let nodes = pipeline.nodes
  if nodes.length() <= 1 {
    return pipeline
  }
  // 简化：按节点顺序检测同名连续对，保留第一个
  let fused = []
  let skip = Array::make(nodes.length(), false)
  for i = 0; i < nodes.length(); i = i + 1 {
    if skip[i] {
      continue
    }
    fused.push(nodes[i])
    // 检查下一个是否同名（简化：只看线性顺序）
    if i + 1 < nodes.length() && nodes[i + 1].name == nodes[i].name {
      skip[i + 1] = true
    }
  }
  PipelineIR::new(fused, pipeline.edges)
}

///|
/// 移除恒等算子 / Remove identity operators.
///
/// 名为 "identity" 或 "noop" 的算子视为恒等，移除。
pub fn remove_identity(
  pipeline : PipelineIR,
) -> PipelineIR {
  let filtered = pipeline.nodes.filter(fn(n) {
    n.name != "identity" && n.name != "noop"
  })
  PipelineIR::new(filtered, pipeline.edges)
}

///|
/// 综合优化 / Comprehensive optimize.
///
/// 依次执行：移除恒等 → 融合同名 map。
pub fn optimize(pipeline : PipelineIR) -> PipelineIR {
  let step1 = remove_identity(pipeline)
  fuse_adjacent_maps(step1)
}

///|
/// 优化统计 / Optimization stats.
pub struct OptStats {
  original_nodes : Int32
  optimized_nodes : Int32
  removed : Int32
} derive(Debug, Eq)

///|
pub extend OptStats with Eq::{equal, not_equal}

///|
pub extend OptStats with Debug::{to_repr}

///|
/// 计算优化统计 / Compute optimization stats.
pub fn opt_stats(
  original : PipelineIR,
  optimized : PipelineIR,
) -> OptStats {
  {
    original_nodes: original.node_count(),
    optimized_nodes: optimized.node_count(),
    removed: original.node_count() - optimized.node_count(),
  }
}

///|
pub fn ir_optimizer_id() -> String {
  "datair/ir_optimizer"
}
