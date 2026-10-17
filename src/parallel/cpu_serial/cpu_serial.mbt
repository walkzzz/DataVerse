///|
/// # parallel/cpu_serial CPU 串行执行后端 / CPU Serial Execution Backend
///
/// 按 PipelineIR 拓扑排序串行执行算子。架构 §3 + §6 S1.6。
/// S1.6 基礎：执行计划生成 + 串行模拟执行 + 执行轨迹记录。
///
/// # CPU serial execution backend
///
/// Execute PipelineIR in topological order. See architecture §3 + §6 S1.6.

/// 执行计划 / Execution plan: ordered operator names.
pub struct ExecutionPlan {
  steps : Array[String]
} derive(Debug, Eq)

pub extend ExecutionPlan with Eq::{equal, not_equal}
pub extend ExecutionPlan with Debug::{to_repr}

/// 执行结果 / Execution result: output + trace + step count.
pub struct ExecutionResult {
  output_fingerprint : String
  trace : Array[String]
  step_count : Int
  success : Bool
} derive(Debug, Eq)

pub extend ExecutionResult with Eq::{equal, not_equal}
pub extend ExecutionResult with Debug::{to_repr}

/// 从 PipelineIR 生成执行计划 / Build execution plan from PipelineIR.
///
/// 按拓扑排序排列算子名。退化安全：空流水线返回空计划；有环返回空计划。
pub fn make_plan(pipeline : @ir_pipeline.PipelineIR) -> ExecutionPlan {
  let order = pipeline.topo_order()
  let steps = []
  for i = 0; i < order.length(); i = i + 1 {
    let node = pipeline.nodes
    let mut found = ""
    for j = 0; j < node.length(); j = j + 1 {
      if node[j].node_id == order[i] {
        found = node[j].name
      }
    }
    steps.push(found)
  }
  { steps, }
}

/// 串行执行 / Execute plan serially.
///
/// 模拟执行：按步骤顺序记录轨迹，生成输出指纹。
/// 输入为输入数据指纹。退化安全：空计划返回原输入指纹。
pub fn execute(plan : ExecutionPlan, input_fingerprint : String) -> ExecutionResult {
  let trace = []
  let mut current_fp = input_fingerprint
  for i = 0; i < plan.steps.length(); i = i + 1 {
    let step_name = plan.steps[i]
    let step_fp = step_name + "(" + current_fp + ")"
    trace.push(step_name + " -> " + step_fp)
    current_fp = step_fp
  }
  {
    output_fingerprint: current_fp,
    trace,
    step_count: plan.steps.length(),
    success: true,
  }
}

/// 空执行计划 / Empty execution plan.
pub fn empty_plan() -> ExecutionPlan {
  { steps: [] }
}

/// 执行计划步数 / Plan step count.
pub fn plan_step_count(plan : ExecutionPlan) -> Int {
  plan.steps.length()
}

/// 合并两个执行结果 / Merge two execution results.
pub fn merge_results(a : ExecutionResult, b : ExecutionResult) -> ExecutionResult {
  {
    output_fingerprint: a.output_fingerprint + ";" + b.output_fingerprint,
    trace: a.trace + b.trace,
    step_count: a.step_count + b.step_count,
    success: a.success && b.success,
  }
}

pub fn cpu_serial_id() -> String {
  "parallel/cpu_serial"
}