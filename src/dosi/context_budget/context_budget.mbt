///|
/// # dosi/context_budget 上下文预算管理器 / Context Budget Manager
///
/// 全局 Token 配额分区 + 超预算压缩。架构 §4.7.3。
/// S1.7 基礎：配额管理 + 检查 + 压缩降级。
///
/// # Context budget manager
///
/// Token quota partitioning + over-budget compression. See architecture §4.7.3.

/// 上下文预算 / Context budget: total quota + used + partitions.
pub struct ContextBudget {
  total_quota : Int
  used : Int
  dosi_quota : Int
  recall_quota : Int
  user_input_quota : Int
  output_quota : Int
} derive(Debug, Eq)

pub extend ContextBudget with Eq::{equal, not_equal}
pub extend ContextBudget with Debug::{to_repr}

/// 构造预算 / Build a context budget.
///
/// 默认分区：DOSI 10% + recall 40% + user_input 30% + output 20%。
pub fn make_budget(total_quota : Int) -> ContextBudget {
  {
    total_quota,
    used: 0,
    dosi_quota: total_quota / 10,
    recall_quota: total_quota * 4 / 10,
    user_input_quota: total_quota * 3 / 10,
    output_quota: total_quota * 2 / 10,
  }
}

/// 分配 Token / Allocate tokens.
///
/// 退化安全：超预算返回原预算不变。
pub fn allocate(budget : ContextBudget, tokens : Int) -> ContextBudget {
  if budget.used + tokens > budget.total_quota {
    budget
  } else {
    { ..budget, used: budget.used + tokens }
  }
}

/// 检查是否超预算 / Check if over budget.
pub fn is_over_budget(budget : ContextBudget) -> Bool {
  budget.used > budget.total_quota
}

/// 剩余配额 / Remaining quota.
pub fn remaining(budget : ContextBudget) -> Int {
  budget.total_quota - budget.used
}

/// 使用率 / Usage ratio (0.0-1.0).
pub fn usage_ratio(budget : ContextBudget) -> Double {
  if budget.total_quota == 0 {
    0.0
  } else {
    budget.used.to_double() / budget.total_quota.to_double()
  }
}

/// 压缩降级 / Compress on over-budget.
///
/// 超预算时返回压缩后的预算（used 降到 quota 的 80%）。
/// 未超预算返回原预算。
pub fn compress(budget : ContextBudget) -> ContextBudget {
  if is_over_budget(budget) {
    let target = budget.total_quota * 4 / 5
    { ..budget, used: target }
  } else {
    budget
  }
}

/// 设置已用量（测试/内部用）/ Set used amount (for testing/internal).
pub fn with_used(budget : ContextBudget, used : Int) -> ContextBudget {
  { ..budget, used }
}

pub fn context_budget_id() -> String {
  "dosi/context_budget"
}