///|
/// # agent_kit/planner NL→DataIR 规划器 / NL to DataIR Planner
///
/// 自然语言 → DataIR 执行计划。架构 §4.8 Agent-Kit。
/// S2.7 填充：关键词匹配模拟 NL 解析。
///
/// # NL to DataIR planner
///
/// Natural language → execution plan. See architecture §4.8.

/// 计划步骤 / Plan step.
pub struct PlanStep {
  step_id : Int
  operator_path : String
  params : Array[(String, String)]
  description : String
} derive(Debug, Eq)

pub extend PlanStep with Eq::{equal, not_equal}
pub extend PlanStep with Debug::{to_repr}

/// 执行计划 / Execution plan.
pub struct ExecutionPlan {
  name : String
  description : String
  steps : Array[PlanStep]
} derive(Debug, Eq)

pub extend ExecutionPlan with Eq::{equal, not_equal}
pub extend ExecutionPlan with Debug::{to_repr}

/// 构造计划步骤 / Build plan step.
pub fn make_plan_step(step_id : Int, operator_path : String, params : Array[(String, String)], description : String) -> PlanStep {
  { step_id, operator_path, params, description }
}

/// 构造执行计划 / Build execution plan.
pub fn make_execution_plan(name : String, description : String, steps : Array[PlanStep]) -> ExecutionPlan {
  { name, description, steps }
}

/// 空执行计划（退化安全）/ Empty execution plan (degenerate-safe).
pub fn empty_execution_plan() -> ExecutionPlan {
  { name: "", description: "", steps: [] }
}

/// NL 关键词到算子路径映射 / NL keyword to operator path mapping.
fn keyword_to_path(keyword : String) -> String? {
  if keyword == "clean" || keyword == "cleaning" {
    Some("opcore/clean")
  } else if keyword == "dedup" || keyword == "deduplication" {
    Some("opcore/dedup")
  } else if keyword == "filter" || keyword == "filtering" {
    Some("opcore/filter")
  } else if keyword == "normalize" || keyword == "normalization" {
    Some("opcore/normalize")
  } else if keyword == "quality" || keyword == "scoring" {
    Some("opcore/quality")
  } else if keyword == "transform" || keyword == "transformation" {
    Some("opcore/transform")
  } else if keyword == "select" || keyword == "sampling" {
    Some("opcore/select")
  } else if keyword == "pack" || keyword == "chunk" {
    Some("opcore/pack")
  } else if keyword == "eval" || keyword == "evaluate" {
    Some("opcore/eval")
  } else {
    None
  }
}

/// 从文本中提取关键词 / Extract keywords from text.
fn extract_keywords(text : String) -> Array[String] {
  let words = text.to_array()
  let result : Array[String] = []
  let mut current : Array[Char] = []
  for i in 0..<words.length() {
    let c = words[i]
    if c == Int::unsafe_to_char(32) || c == Int::unsafe_to_char(44) || c == Int::unsafe_to_char(46) {
      if current.length() > 0 {
        result.push(String::from_array(current))
        current = []
      }
    } else {
      current.push(c.to_ascii_lowercase())
    }
  }
  if current.length() > 0 {
    result.push(String::from_array(current))
  }
  result
}

/// NL 解析为执行计划 / Parse natural language to execution plan.
///
/// 模拟策略：提取关键词 → 映射到算子路径 → 生成计划步骤。
/// 退化安全：空文本返回空计划。
pub fn parse_nl_to_plan(nl_text : String) -> ExecutionPlan {
  let keywords = extract_keywords(nl_text)
  let steps : Array[PlanStep] = []
  let mut step_id = 0
  for i in 0..<keywords.length() {
    match keyword_to_path(keywords[i]) {
      Some(path) => {
        steps.push(make_plan_step(step_id, path, [], "Auto-planned from keyword: " + keywords[i]))
        step_id = step_id + 1
      }
      None => ()
    }
  }
  if steps.length() == 0 {
    empty_execution_plan()
  } else {
    make_execution_plan("auto_plan", "Parsed from: " + nl_text, steps)
  }
}

/// 计划步骤数 / Plan step count.
pub fn plan_step_count(plan : ExecutionPlan) -> Int {
  plan.steps.length()
}

pub fn planner_id() -> String {
  "agent_kit/planner"
}