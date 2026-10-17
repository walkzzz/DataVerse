///|
/// # learncore/hyperparam_search 超参搜索 / Hyperparameter Search
///
/// 网格搜索契约 + 结果聚合。架构 §4.3.5 learncore Eval。
/// S2.4 填充：GridConfig + GridResult + grid_search（接受评估函数）。
///
/// # Hyperparameter search
///
/// Grid search contract + result aggregation. See architecture §4.3.5.

/// 网格搜索配置 / Grid search config: one param dimension.
pub struct GridConfig {
  param_name : String
  param_values : Array[Double]
} derive(Debug, Eq)

pub extend GridConfig with Eq::{equal, not_equal}
pub extend GridConfig with Debug::{to_repr}

/// 参数组合 / Parameter combination.
pub struct ParamCombo {
  params : Array[(String, Double)]
  score : Double
} derive(Debug, Eq)

pub extend ParamCombo with Eq::{equal, not_equal}
pub extend ParamCombo with Debug::{to_repr}

/// 网格搜索结果 / Grid search result.
pub struct GridResult {
  best_params : Array[(String, Double)]
  best_score : Double
  all_results : Array[ParamCombo]
  total_configs : Int
} derive(Debug, Eq)

pub extend GridResult with Eq::{equal, not_equal}
pub extend GridResult with Debug::{to_repr}

/// 构造网格配置 / Build grid config.
pub fn make_grid_config(param_name : String, param_values : Array[Double]) -> GridConfig {
  { param_name, param_values }
}

/// 生成所有参数组合 / Generate all parameter combinations.
///
/// 笛卡尔积。退化安全：空配置返回空数组。
pub fn grid_combinations(configs : Array[GridConfig]) -> Array[Array[(String, Double)]] {
  if configs.length() == 0 {
    []
  } else {
    let result : Array[Array[(String, Double)]] = [[]]
    for cfg_idx in 0..<configs.length() {
      let cfg = configs[cfg_idx]
      let new_result : Array[Array[(String, Double)]] = []
      for combo_idx in 0..<result.length() {
        for val_idx in 0..<cfg.param_values.length() {
          let combo = result[combo_idx]
          let new_combo : Array[(String, Double)] = []
          for k in 0..<combo.length() {
            new_combo.push(combo[k])
          }
          new_combo.push((cfg.param_name, cfg.param_values[val_idx]))
          new_result.push(new_combo)
        }
      }
      result.clear()
      for i in 0..<new_result.length() {
        result.push(new_result[i])
      }
    }
    result
  }
}

/// 网格搜索 / Grid search.
///
/// 接受评估函数 eval_fn，对每个参数组合计算分数，返回最佳。
pub fn grid_search(
  configs : Array[GridConfig],
  eval_fn : (Array[(String, Double)]) -> Double
) -> GridResult {
  let combos = grid_combinations(configs)
  if combos.length() == 0 {
    empty_grid_result()
  } else {
    let all_results : Array[ParamCombo] = []
    let mut best_score = -1000000000.0
    let mut best_params : Array[(String, Double)] = []
    for i in 0..<combos.length() {
      let score = eval_fn(combos[i])
      all_results.push({ params: combos[i], score })
      if score > best_score {
        best_score = score
        best_params = combos[i]
      }
    }
    { best_params, best_score, all_results, total_configs: combos.length() }
  }
}

/// 空网格搜索结果（退化安全）/ Empty grid result (degenerate-safe).
pub fn empty_grid_result() -> GridResult {
  { best_params: [], best_score: 0.0, all_results: [], total_configs: 0 }
}

pub fn hyperparam_search_id() -> String {
  "learncore/hyperparam_search"
}