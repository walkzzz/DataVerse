///|
/// # agent_kit/agent_optimize Agent 优化 / Agent Optimization
///
/// Prompt 优化、超参优化、Few-shot、链优化、缓存、批处理、模型选择、温度、Token、延迟、成本、A/B 测试、贝叶斯优化。
/// S11.6 新建。
///
/// # Agent optimization

/// 优化配置 / Optimization config.
pub struct OptConfig {
  name : String
  target : String
  budget : Int
  iterations : Int
  seed : Int
}

/// 构造优化配置 / Create opt config.
pub fn make_opt_config(
  name : String,
  target : String,
  budget : Int,
  iterations : Int,
  seed : Int,
) -> OptConfig {
  { name: name, target: target, budget: budget, iterations: iterations, seed: seed }
}

///===
/// Prompt 优化 / Prompt optimization

/// Prompt 优化器 / Prompt optimizer.
pub struct PromptOptimizer {
  base_prompt : String
  variants : Array[String]
  best_score : Double
}

/// 构造 Prompt 优化器 / Create prompt optimizer.
pub fn make_prompt_optimizer(base_prompt : String) -> PromptOptimizer {
  { base_prompt: base_prompt, variants: [], best_score: 0.0 }
}

/// Prompt 优化 / Optimize prompt.
pub fn optimize_prompt(prompt : String, feedback : String) -> String {
  prompt + "\n\nRefinement: " + feedback
}

/// Prompt 搜索 / Search prompts.
pub fn prompt_search(optimizer : PromptOptimizer, candidates : Array[String]) -> Array[String] {
  let result : Array[String] = []
  result.push(optimizer.base_prompt)
  for i in 0..<candidates.length() {
    result.push(candidates[i])
  }
  result
}

/// Prompt 进化 / Evolve prompt.
pub fn prompt_evolve(prompt : String, mutation : String) -> String {
  prompt + " " + mutation
}

///===
/// 超参优化 / Hyperparameter optimization

/// 超参优化器 / Hyperparam optimizer.
pub struct HyperparamOptimizer {
  params : Array[(String, Double)]
  learning_rate : Double
}

/// 构造超参优化器 / Create hyperparam optimizer.
pub fn make_hyperparam_optimizer(params : Array[(String, Double)], learning_rate : Double) -> HyperparamOptimizer {
  { params: params, learning_rate: learning_rate }
}

/// 超参优化 / Optimize hyperparams.
pub fn optimize_hyperparams(params : Array[(String, Double)], gradients : Array[Double]) -> Array[(String, Double)] {
  let result : Array[(String, Double)] = []
  let n = params.length()
  let m = gradients.length()
  for i in 0..<n {
    let grad = if i < m { gradients[i] } else { 0.0 }
    result.push((params[i].0, params[i].1 - 0.01 * grad))
  }
  result
}

/// 超参搜索 / Search hyperparams.
pub fn hyperparam_search(optimizer : HyperparamOptimizer, bounds : Array[(Double, Double)]) -> Array[(String, Double)] {
  let result : Array[(String, Double)] = []
  let n = optimizer.params.length()
  let m = bounds.length()
  for i in 0..<n {
    let lo = if i < m { bounds[i].0 } else { 0.0 }
    let hi = if i < m { bounds[i].1 } else { 1.0 }
    let mid = (lo + hi) / 2.0
    result.push((optimizer.params[i].0, mid))
  }
  result
}

/// 超参微调 / Tune hyperparams.
pub fn hyperparam_tune(params : Array[(String, Double)], step : Double) -> Array[(String, Double)] {
  let result : Array[(String, Double)] = []
  for i in 0..<params.length() {
    result.push((params[i].0, params[i].1 + step))
  }
  result
}

///===
/// Few-shot 优化 / Few-shot optimization

/// Few-shot 优化器 / Few-shot optimizer.
pub struct FewShotOptimizer {
  examples : Array[(String, String)]
  max_shots : Int
}

/// 构造 Few-shot 优化器 / Create few-shot optimizer.
pub fn make_few_shot_optimizer(examples : Array[(String, String)], max_shots : Int) -> FewShotOptimizer {
  { examples: examples, max_shots: max_shots }
}

/// Few-shot 选择 / Select few-shot examples.
pub fn few_shot_select(optimizer : FewShotOptimizer, query : String) -> Array[(String, String)] {
  let scored : Array[(Double, (String, String))] = []
  for i in 0..<optimizer.examples.length() {
    let ex = optimizer.examples[i]
    let score = if ex.0.length() > 0 { query.length().to_double() / ex.0.length().to_double() } else { 0.0 }
    scored.push((score, ex))
  }
  scored.sort_by(fn(a, b) { b.0.compare(a.0) })
  let result : Array[(String, String)] = []
  let count = if scored.length() < optimizer.max_shots { scored.length() } else { optimizer.max_shots }
  for i in 0..<count {
    result.push(scored[i].1)
  }
  result
}

/// Few-shot 排序 / Order few-shot examples.
pub fn few_shot_order(examples : Array[(String, String)]) -> Array[(String, String)] {
  let result = examples.copy()
  result.sort_by(fn(a, b) { a.0.length().compare(b.0.length()) })
  result
}

///===
/// 链优化 / Chain optimization

/// 链优化器 / Chain optimizer.
pub struct ChainOptimizer {
  steps : Array[String]
}

/// 构造链优化器 / Create chain optimizer.
pub fn make_chain_optimizer(steps : Array[String]) -> ChainOptimizer {
  { steps: steps }
}

/// 链简化 / Simplify chain.
pub fn chain_simplify(optimizer : ChainOptimizer) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<optimizer.steps.length() {
    let mut dup = false
    for j in 0..<result.length() {
      if result[j] == optimizer.steps[i] {
        dup = true
      }
    }
    if !dup {
      result.push(optimizer.steps[i])
    }
  }
  result
}

/// 链重排 / Reorder chain.
pub fn chain_reorder(optimizer : ChainOptimizer, new_order : Array[Int]) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<new_order.length() {
    let idx = new_order[i]
    if idx >= 0 && idx < optimizer.steps.length() {
      result.push(optimizer.steps[idx])
    }
  }
  result
}

///===
/// 缓存优化 / Cache optimization

/// 缓存优化器 / Cache optimizer.
pub struct CacheOptimizer {
  strategy : String
  max_size : Int
}

/// 构造缓存优化器 / Create cache optimizer.
pub fn make_cache_optimizer(strategy : String, max_size : Int) -> CacheOptimizer {
  { strategy: strategy, max_size: max_size }
}

/// 缓存策略 / Cache strategy.
pub fn cache_strategy(optimizer : CacheOptimizer, key : String) -> String {
  optimizer.strategy + ":" + key
}

/// 缓存键生成 / Cache key generation.
pub fn cache_key_gen(input : String, model : String) -> String {
  model + ":" + input
}

///===
/// 批处理优化 / Batch optimization

/// 批处理优化器 / Batch optimizer.
pub struct BatchOptimizer {
  max_batch_size : Int
  latency_target : Double
}

/// 构造批处理优化器 / Create batch optimizer.
pub fn make_batch_optimizer(max_batch_size : Int, latency_target : Double) -> BatchOptimizer {
  { max_batch_size: max_batch_size, latency_target: latency_target }
}

/// 批大小搜索 / Search batch size.
pub fn batch_size_search(optimizer : BatchOptimizer, latencies : Array[Double]) -> Int {
  let n = latencies.length()
  if n == 0 {
    1
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + latencies[i]
    }
    let avg = sum / n.to_double()
    if avg == 0.0 {
      optimizer.max_batch_size
    } else {
      let ideal = optimizer.latency_target / avg
      let ideal_int = ideal.to_int()
      if ideal_int < 1 {
        1
      } else if ideal_int > optimizer.max_batch_size {
        optimizer.max_batch_size
      } else {
        ideal_int
      }
    }
  }
}

/// 批策略 / Batch strategy.
pub fn batch_strategy(optimizer : BatchOptimizer, n_items : Int) -> Array[Int] {
  let result : Array[Int] = []
  if n_items <= 0 {
    return result
  }
  let mut remaining = n_items
  while remaining > 0 {
    let batch = if remaining < optimizer.max_batch_size { remaining } else { optimizer.max_batch_size }
    result.push(batch)
    remaining = remaining - batch
  }
  result
}

///===
/// 模型选择 / Model selection

/// 模型选择器 / Model selector.
pub struct ModelSelector {
  models : Array[(String, Double)]
  default_model : String
}

/// 构造模型选择器 / Create model selector.
pub fn make_model_selector(models : Array[(String, Double)], default_model : String) -> ModelSelector {
  { models: models, default_model: default_model }
}

/// 模型选择 / Select model.
pub fn model_select(selector : ModelSelector, complexity : Double) -> String {
  let mut best = selector.default_model
  let mut best_diff = 10000000000.0
  for i in 0..<selector.models.length() {
    let diff = (selector.models[i].1 - complexity).abs()
    if diff < best_diff {
      best_diff = diff
      best = selector.models[i].0
    }
  }
  best
}

/// 模型路由 / Route model.
pub fn model_route(selector : ModelSelector, task_type : String) -> String {
  let mut chosen = selector.default_model
  for i in 0..<selector.models.length() {
    if selector.models[i].0.contains(task_type) {
      chosen = selector.models[i].0
    }
  }
  chosen
}

///===
/// 温度优化 / Temperature optimization

/// 温度优化器 / Temperature optimizer.
pub struct TemperatureOptimizer {
  base_temp : Double
  min_temp : Double
  max_temp : Double
}

/// 构造温度优化器 / Create temperature optimizer.
pub fn make_temperature_optimizer(base_temp : Double, min_temp : Double, max_temp : Double) -> TemperatureOptimizer {
  { base_temp: base_temp, min_temp: min_temp, max_temp: max_temp }
}

/// 温度搜索 / Search temperature.
pub fn temperature_search(optimizer : TemperatureOptimizer, steps : Int) -> Array[Double] {
  let result : Array[Double] = []
  if steps <= 0 {
    return result
  }
  let range = optimizer.max_temp - optimizer.min_temp
  let step_size = range / steps.to_double()
  for i in 0..<steps {
    result.push(optimizer.min_temp + step_size * i.to_double())
  }
  result
}

/// 温度调度 / Temperature schedule.
pub fn temperature_schedule(optimizer : TemperatureOptimizer, step : Int, total : Int) -> Double {
  if total <= 0 {
    optimizer.base_temp
  } else {
    let progress = step.to_double() / total.to_double()
    let temp = optimizer.max_temp - (optimizer.max_temp - optimizer.min_temp) * progress
    if temp < optimizer.min_temp {
      optimizer.min_temp
    } else if temp > optimizer.max_temp {
      optimizer.max_temp
    } else {
      temp
    }
  }
}

///===
/// Token 优化 / Token optimization

/// Token 优化器 / Token optimizer.
pub struct TokenOptimizer {
  total_budget : Int
  allocated : Array[(String, Int)]
}

/// 构造 Token 优化器 / Create token optimizer.
pub fn make_token_optimizer(total_budget : Int) -> TokenOptimizer {
  { total_budget: total_budget, allocated: [] }
}

/// Token 预算 / Token budget.
pub fn token_budget(optimizer : TokenOptimizer) -> Int {
  let mut used = 0
  for i in 0..<optimizer.allocated.length() {
    used = used + optimizer.allocated[i].1
  }
  optimizer.total_budget - used
}

/// Token 分配 / Allocate tokens.
pub fn token_allocate(optimizer : TokenOptimizer, task : String, amount : Int) -> TokenOptimizer {
  let remaining = token_budget(optimizer)
  if amount > remaining {
    optimizer
  } else {
    let new_allocated = optimizer.allocated.copy()
    new_allocated.push((task, amount))
    { ..optimizer, allocated: new_allocated }
  }
}

///===
/// 延迟优化 / Latency optimization

/// 延迟优化器 / Latency optimizer.
pub struct LatencyOptimizer {
  target_latency : Double
  parallelism : Int
}

/// 构造延迟优化器 / Create latency optimizer.
pub fn make_latency_optimizer(target_latency : Double, parallelism : Int) -> LatencyOptimizer {
  { target_latency: target_latency, parallelism: parallelism }
}

/// 延迟减少 / Reduce latency.
pub fn latency_reduce(optimizer : LatencyOptimizer, sequential_time : Double) -> Double {
  if optimizer.parallelism <= 0 {
    sequential_time
  } else {
    sequential_time / optimizer.parallelism.to_double()
  }
}

/// 并行策略 / Parallel strategy.
pub fn parallel_strategy(optimizer : LatencyOptimizer, n_tasks : Int) -> Array[Int] {
  let result : Array[Int] = []
  if n_tasks <= 0 {
    return result
  }
  let p = if optimizer.parallelism > 0 { optimizer.parallelism } else { 1 }
  let per = n_tasks / p
  let rem = n_tasks % p
  for i in 0..<p {
    let load = per + (if i < rem { 1 } else { 0 })
    if load > 0 {
      result.push(load)
    }
  }
  result
}

///===
/// 成本优化 / Cost optimization

/// 成本优化器 / Cost optimizer.
pub struct CostOptimizer {
  budget : Double
  priorities : Array[(String, Double)]
}

/// 构造成本优化器 / Create cost optimizer.
pub fn make_cost_optimizer(budget : Double, priorities : Array[(String, Double)]) -> CostOptimizer {
  { budget: budget, priorities: priorities }
}

/// 成本减少 / Reduce cost.
pub fn cost_reduce(optimizer : CostOptimizer, current_cost : Double) -> Double {
  if current_cost <= optimizer.budget {
    current_cost
  } else {
    optimizer.budget
  }
}

/// 成本权衡 / Cost tradeoff.
pub fn cost_tradeoff(optimizer : CostOptimizer, quality : Double, cost : Double) -> Double {
  if cost == 0.0 {
    quality
  } else {
    let weight = if cost > optimizer.budget { optimizer.budget / cost } else { 1.0 }
    quality * weight
  }
}

///===
/// 综合优化 / Combined optimization

/// 优化质量 / Optimize quality.
pub fn optimize_quality(metrics : Array[(String, Double)], weights : Array[Double]) -> Double {
  let n = metrics.length()
  if n == 0 {
    0.0
  } else {
    let m = weights.length()
    let mut sum = 0.0
    let mut wsum = 0.0
    for i in 0..<n {
      let w = if i < m { weights[i] } else { 1.0 }
      sum = sum + metrics[i].1 * w
      wsum = wsum + w
    }
    if wsum == 0.0 {
      0.0
    } else {
      sum / wsum
    }
  }
}

/// 优化速度 / Optimize speed.
pub fn optimize_speed(latencies : Array[Double], target : Double) -> Double {
  let n = latencies.length()
  if n == 0 {
    1.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      if latencies[i] <= target {
        sum = sum + 1.0
      } else if latencies[i] > 0.0 {
        sum = sum + target / latencies[i]
      }
    }
    sum / n.to_double()
  }
}

/// 优化成本平衡 / Optimize cost balance.
pub fn optimize_cost_balance(quality : Double, cost : Double, budget : Double) -> Double {
  if cost <= 0.0 {
    quality
  } else {
    let cost_ratio = if cost > budget { budget / cost } else { 1.0 }
    quality * cost_ratio
  }
}

///===
/// A/B 测试 / A/B test

/// A/B 测试 / AB test.
pub struct ABTest {
  name : String
  variant_a : Array[Double]
  variant_b : Array[Double]
}

/// 构造 A/B 测试 / Create AB test.
pub fn make_ab_test(name : String, variant_a : Array[Double], variant_b : Array[Double]) -> ABTest {
  { name: name, variant_a: variant_a, variant_b: variant_b }
}

/// 运行 A/B 测试 / Run AB test.
pub fn ab_test_run(ab_test : ABTest) -> (Double, Double) {
  let na = ab_test.variant_a.length()
  let nb = ab_test.variant_b.length()
  let mut sum_a = 0.0
  for i in 0..<na {
    sum_a = sum_a + ab_test.variant_a[i]
  }
  let mut sum_b = 0.0
  for i in 0..<nb {
    sum_b = sum_b + ab_test.variant_b[i]
  }
  let mean_a = if na == 0 { 0.0 } else { sum_a / na.to_double() }
  let mean_b = if nb == 0 { 0.0 } else { sum_b / nb.to_double() }
  (mean_a, mean_b)
}

/// A/B 显著性 / AB test significance.
pub fn ab_test_significance(ab_test : ABTest) -> Double {
  let (mean_a, mean_b) = ab_test_run(ab_test)
  let na = ab_test.variant_a.length()
  let nb = ab_test.variant_b.length()
  if na == 0 || nb == 0 {
    0.0
  } else {
    let mut var_a = 0.0
    for i in 0..<na {
      let diff = ab_test.variant_a[i] - mean_a
      var_a = var_a + diff * diff
    }
    var_a = var_a / na.to_double()
    let mut var_b = 0.0
    for i in 0..<nb {
      let diff2 = ab_test.variant_b[i] - mean_b
      var_b = var_b + diff2 * diff2
    }
    var_b = var_b / nb.to_double()
    let denom = (var_a / na.to_double() + var_b / nb.to_double()).abs()
    if denom == 0.0 {
      0.0
    } else {
      (mean_b - mean_a).abs() / denom
    }
  }
}

///===
/// 贝叶斯优化 / Bayesian optimization

/// 贝叶斯优化 / Bayesian optimization.
pub struct BayesianOpt {
  params : Array[(String, Double)]
  observations : Array[(Double, Double)]
  best_param : Double
  best_value : Double
}

/// 构造贝叶斯优化 / Create bayesian opt.
pub fn make_bayesian_opt(params : Array[(String, Double)]) -> BayesianOpt {
  { params: params, observations: [], best_param: 0.0, best_value: 0.0 }
}

/// 贝叶斯优化步 / Bayesian opt step.
pub fn bayesian_opt_step(opt : BayesianOpt, param : Double, value : Double) -> BayesianOpt {
  let new_obs = opt.observations.copy()
  new_obs.push((param, value))
  let new_best_param = if value > opt.best_value { param } else { opt.best_param }
  let new_best_value = if value > opt.best_value { value } else { opt.best_value }
  { ..opt, observations: new_obs, best_param: new_best_param, best_value: new_best_value }
}

/// 贝叶斯优化建议 / Bayesian opt suggest.
pub fn bayesian_opt_suggest(opt : BayesianOpt, lo : Double, hi : Double) -> Double {
  let n = opt.observations.length()
  if n == 0 {
    (lo + hi) / 2.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + opt.observations[i].0
    }
    let mean = sum / n.to_double()
    if mean < lo {
      hi
    } else if mean > hi {
      lo
    } else {
      (mean + hi) / 2.0
    }
  }
}

///===
/// ID

pub fn agent_optimize_id() -> String {
  "agent_kit/agent_optimize"
}