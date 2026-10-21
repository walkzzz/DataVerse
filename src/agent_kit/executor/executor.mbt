///|
/// # agent_kit/executor 执行器 / Executor
///
/// 执行计划 + 状态跟踪。架构 §4.8 Agent-Kit。
/// S2.7 填充：模拟执行（无真实算子调用，返回成功状态）。
///
/// # Executor
///
/// Execute plan + status tracking. See architecture §4.8.

///|
/// 执行状态 / Execution status.
pub(all) enum ExecStatus {
  Pending
  Running
  Success
  Failed
} derive(Debug, Eq)

///|
pub extend ExecStatus with Eq::{equal, not_equal}

///|
pub extend ExecStatus with Debug::{to_repr}

///|
/// 执行结果 / Execution result for one step.
pub struct ExecResult {
  step_id : Int32
  status : ExecStatus
  operator_path : String
  output_summary : String
  duration_ms : Int32
} derive(Debug, Eq)

///|
pub extend ExecResult with Eq::{equal, not_equal}

///|
pub extend ExecResult with Debug::{to_repr}

///|
/// 构造执行结果 / Build exec result.
pub fn make_exec_result(
  step_id : Int32,
  status : ExecStatus,
  operator_path : String,
  output_summary : String,
  duration_ms : Int32,
) -> ExecResult {
  { step_id, status, operator_path, output_summary, duration_ms, }
}

///|
/// 执行计划 / Execute plan.
///
/// 模拟执行：每个步骤返回 Success，duration_ms = 10。
/// 退化安全：空计划返回空数组。
pub fn execute_plan(plan : @planner.ExecutionPlan) -> Array[ExecResult] {
  let results : Array[ExecResult] = []
  for i in 0..<plan.steps.length() {
    let step = plan.steps[i]
    results.push(
      make_exec_result(
        step.step_id,
        Success,
        step.operator_path,
        "Simulated execution",
        10,
      ),
    )
  }
  results
}

///|
/// 执行统计 / Execution statistics.
pub struct ExecStats {
  total_steps : Int32
  success_count : Int32
  failed_count : Int32
  total_duration_ms : Int32
} derive(Debug, Eq)

///|
pub extend ExecStats with Eq::{equal, not_equal}

///|
pub extend ExecStats with Debug::{to_repr}

///|
/// 计算执行统计 / Compute execution stats.
pub fn exec_stats(results : Array[ExecResult]) -> ExecStats {
  let total = results.length()
  let mut success = 0
  let mut failed = 0
  let mut duration = 0
  for i in 0..<total {
    match results[i].status {
      Success => success = success + 1
      Failed => failed = failed + 1
      _ => ()
    }
    duration = duration + results[i].duration_ms
  }
  {
    total_steps: total,
    success_count: success,
    failed_count: failed,
    total_duration_ms: duration,
  }
}

///|
/// 执行状态名称 / Exec status name.
pub fn exec_status_name(status : ExecStatus) -> String {
  match status {
    Pending => "pending"
    Running => "running"
    Success => "success"
    Failed => "failed"
  }
}

///|
pub fn executor_id() -> String {
  "agent_kit/executor"
}
