///|
/// # DataVerse 数据算子库根包 / Root Package
///
/// 对外统一入口 `@dataverse`，重导出所有一级子包公共 API。
/// S0.1 骨架 + S0.2 kernel 四模式执行内核。
/// 重导出各子包公共 API，后续 Sprint 逐步扩充。
///
/// # Root package of DataVerse
///
/// Unified entry `@dataverse`, re-exports all first-level sub-packages' public API.
/// S0.1 skeleton + S0.2 kernel four-mode execution kernel.
pub fn version() -> String {
  "dataverse 0.1.0-dev (S0.2 kernel four-mode)"
}

pub using @kernel {
  kernel_id, mode_name, mode_consistency, mode_from_tag, all_mode_tags,
}
pub using @dataobject { dataobject_id }
pub using @opcore { opcore_id }
pub using @datatemporal { datatemporal_id }
pub using @recipe { recipe_id }
pub using @datair { datair_id }
pub using @dosi { dosi_id }
pub using @agent_kit { agent_kit_id }
pub using @self_evolve { self_evolve_id }
pub using @parallel { parallel_id }
pub using @io { io_id }
pub using @governance { governance_id }