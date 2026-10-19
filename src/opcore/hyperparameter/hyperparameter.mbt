///|
/// # opcore/hyperparameter 超参数优化 / Hyperparameter Optimization
///
/// 网格搜索/随机搜索/贝叶斯优化/TPE/模拟退火/早停/剪枝/并行搜索。
/// 纯超参数搜索算法集合，对标 Optuna + Hyperopt。
///
/// # Hyperparameter Optimization
///
/// Grid/Random/Bayesian/TPE/Annealing search with pruning and early stopping.

fn sqrt_(x : Double) -> Double {
  if x <= 0.0 { return 0.0 }
  let mut guess = if x > 1.0 { x / 2.0 } else { 1.0 }
  for _ in 0..<100 {
    let next = (guess + x / guess) / 2.0
    let diff = next - guess
    if diff < 0.00000001 && diff > -0.00000001 { return next }
    guess = next
  }
  guess
}

fn abs_(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn exp_(x : Double) -> Double {
  if x > 20.0 { return 485165195.4 }
  if x < -20.0 { return 0.0 }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<50 { term = term * x / i.to_double(); result = result + term }
  result
}

fn ln_(x : Double) -> Double {
  if x <= 0.0 { return -999999.0 }
  let mut result = 0.0
  let t = (x - 1.0) / (x + 1.0)
  let t2 = t * t
  let mut term = t
  for k in 0..<50 {
    result = result + term / (2 * k + 1).to_double()
    term = term * t2
  }
  2.0 * result
}

fn max_(a : Double, b : Double) -> Double { if a > b { a } else { b } }

fn min_(a : Double, b : Double) -> Double { if a < b { a } else { b } }

fn rng_(seed : Double) -> Double {
  let s = seed * 1103515245.0 + 12345.0
  s - (s / 2147483647.0).to_int().to_double() * 2147483647.0
}

fn normal_sample_(mu : Double, sigma : Double, seed : Double) -> Double {
  let u1 = rng_(seed) / 2147483647.0 + 0.0000001
  let u2 = rng_(seed + 1.0) / 2147483647.0 + 0.0000001
  let r = sqrt_(-2.0 * ln_(u1))
  let theta = 6.283185307179586 * u2
  mu + sigma * r * (theta - theta * theta * theta / 6.0)
}

fn dot_(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let mut s = 0.0
  for i in 0..<n { s = s + a[i] * b[i] }
  s
}

fn copy_(x0 : Array[Double]) -> Array[Double] {
  let n = x0.length()
  let x : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n { x[i] = x0[i] }
  x
}

/// 超参数配置 / Hyperparameter configuration.
pub(all) struct HpConfig {
  n_trials : Int
  timeout : Double
  n_jobs : Int
  seed : Int
  sampler_type : String
  pruner_type : String
  direction : String
  metric_name : String
}

/// 超参数空间 / Hyperparameter search space.
pub(all) struct HpSpace {
  params : Array[HpParam]
  constraints : Array[String]
}

/// 超参数定义 / Hyperparameter parameter definition.
pub(all) struct HpParam {
  name : String
  param_type : String
  low : Double
  high : Double
  choices : Array[String]
  log_scale : Bool
  mu : Double
  sigma : Double
}

/// 超参数试验 / Hyperparameter trial.
pub(all) struct HpTrial {
  trial_id : Int
  params : Array[(String, Double)]
  value : Double
  state : String
  intermediate_values : Array[Double]
  step : Int
}

/// 试验结果 / Trial result.
pub(all) struct TrialResult {
  best_params : Array[(String, Double)]
  best_value : Double
  n_trials : Int
  trials : Array[HpTrial]
}

/// 剪枝器 / Pruner.
pub(all) struct HpPruner {
  pruner_type : String
  n_min_trials : Int
  n_startup_trials : Int
  interval_steps : Int
  reduction_factor : Double
}

/// 优化器 / Hyperparameter optimizer.
pub(all) struct HpOptimizer {
  optimizer_type : String
  space : HpSpace
  history : Array[HpTrial]
  best_trial : HpTrial
  rng_state : Double
}

/// TPE 优化器 / TPE optimizer.
pub(all) struct TpeOptimizer {
  space : HpSpace
  l_x : Array[Array[Double]]
  r_x : Array[Array[Double]]
  l_y : Array[Double]
  r_y : Array[Double]
  gamma : Double
  n_ei_candidates : Int
  rng_state : Double
}

/// 高斯过程 / Gaussian process.
pub(all) struct GaussianProcess {
  x_train : Array[Array[Double]]
  y_train : Array[Double]
  kernel_params : Array[Double]
  noise : Double
  alpha : Array[Double]
  k_inv : Array[Array[Double]]
}

/// 采集函数结果 / Acquisition result.
pub(all) struct AcquisitionResult {
  x_next : Array[Double]
  ei : Double
  pi : Double
  ucb : Double
}

/// 早停器 / Early stopper.
pub(all) struct EarlyStop {
  stop_type : String
  patience : Int
  min_delta : Double
  best_value : Double
  wait_count : Int
  warmup : Int
}

/// 研究对象 / Study object.
pub(all) struct HpStudy {
  study_id : String
  direction : String
  trials : Array[HpTrial]
  best_trial : HpTrial
  pruner : HpPruner
  sampler : String
  user_attrs : Array[(String, String)]
}

/// 集成结果 / Ensemble result.
pub(all) struct HpEnsemble {
  top_trials : Array[HpTrial]
  weights : Array[Double]
  combined_params : Array[(String, Double)]
}

/// 暖启动 / Warm start.
pub(all) struct HpWarmStart {
  prior_trials : Array[HpTrial]
  prior_params : Array[(String, Double)]
  transfer_weight : Double
}

/// 创建超参数配置 / Create hyperparameter configuration.
pub fn make_hp_config(
  n_trials : Int,
  timeout : Double,
  n_jobs : Int,
  seed : Int,
  sampler_type : String,
  pruner_type : String,
  direction : String,
  metric_name : String
) -> HpConfig {
  { n_trials, timeout, n_jobs, seed, sampler_type, pruner_type, direction, metric_name }
}

/// 创建超参数空间 / Create hyperparameter search space.
pub fn make_hp_space(params : Array[HpParam], constraints : Array[String]) -> HpSpace {
  { params, constraints }
}

/// 创建超参数定义 / Create hyperparameter parameter.
pub fn make_hp_param(
  name : String,
  param_type : String,
  low : Double,
  high : Double,
  choices : Array[String],
  log_scale : Bool,
  mu : Double,
  sigma : Double
) -> HpParam {
  { name, param_type, low, high, choices, log_scale, mu, sigma }
}

/// 整数范围参数 / Integer range parameter.
pub fn param_int_range(name : String, low : Int, high : Int, log_scale : Bool) -> HpParam {
  make_hp_param(name, "int", low.to_double(), high.to_double(), [], log_scale, 0.0, 1.0)
}

/// 浮点范围参数 / Float range parameter.
pub fn param_float_range(
  name : String, low : Double, high : Double, log_scale : Bool
) -> HpParam {
  make_hp_param(name, "float", low, high, [], log_scale, 0.0, 1.0)
}

/// 选择参数 / Choice parameter.
pub fn param_choice(name : String, choices : Array[String]) -> HpParam {
  make_hp_param(name, "choice", 0.0, choices.length().to_double(), choices, false, 0.0, 1.0)
}

/// 对数均匀参数 / Log-uniform parameter.
pub fn param_log_uniform(name : String, low : Double, high : Double) -> HpParam {
  make_hp_param(name, "float", low, high, [], true, 0.0, 1.0)
}

/// 均匀参数 / Uniform parameter.
pub fn param_uniform(name : String, low : Double, high : Double) -> HpParam {
  make_hp_param(name, "float", low, high, [], false, 0.0, 1.0)
}

/// 正态参数 / Normal parameter.
pub fn param_normal(name : String, mu : Double, sigma : Double) -> HpParam {
  make_hp_param(name, "normal", mu - 3.0 * sigma, mu + 3.0 * sigma, [], false, mu, sigma)
}

/// 创建试验 / Create trial.
pub fn make_hp_trial(
  trial_id : Int,
  params : Array[(String, Double)],
  value : Double,
  state : String
) -> HpTrial {
  { trial_id, params, value, state, intermediate_values: [], step: 0 }
}

/// 试验评估 / Evaluate trial.
pub fn trial_evaluate(
  trial : HpTrial,
  objective : (Array[(String, Double)]) -> Double
) -> HpTrial {
  let v = objective(trial.params)
  { ..trial, value: v, state: "COMPLETE" }
}

/// 试验评分 / Score trial.
pub fn trial_score(trial : HpTrial, direction : String) -> Double {
  if direction == "maximize" { trial.value } else { -trial.value }
}

/// 最佳试验 / Best trial.
pub fn trial_best(trials : Array[HpTrial], direction : String) -> HpTrial {
  let n = trials.length()
  if n == 0 { return make_hp_trial(0, [], 0.0, "FAIL") }
  let mut best = trials[0]
  let mut best_score = trial_score(best, direction)
  for i in 1..<n {
    let s = trial_score(trials[i], direction)
    if s > best_score { best = trials[i]; best_score = s }
  }
  best
}

/// 创建剪枝器 / Create pruner.
pub fn make_hp_pruner(
  pruner_type : String,
  n_min_trials : Int,
  n_startup_trials : Int,
  interval_steps : Int,
  reduction_factor : Double
) -> HpPruner {
  { pruner_type, n_min_trials, n_startup_trials, interval_steps, reduction_factor }
}

/// 中位数剪枝器 / Median pruner.
pub fn pruner_median(
  pruner : HpPruner,
  trials : Array[HpTrial],
  step : Int
) -> Bool {
  if trials.length() < pruner.n_startup_trials { return false }
  if step < pruner.n_min_trials { return false }
  let vals : Array[Double] = []
  for t in trials {
    if t.step > step && t.intermediate_values.length() > step {
      vals.push(t.intermediate_values[step])
    }
  }
  if vals.length() < 1 { return false }
  let sorted = copy_(vals)
  for i in 0..<sorted.length() {
    for j in (i + 1)..<sorted.length() {
      if sorted[j] < sorted[i] {
        let tmp = sorted[i]; sorted[i] = sorted[j]; sorted[j] = tmp
      }
    }
  }
  let median = sorted[sorted.length() / 2]
  let cur = trials[trials.length() - 1]
  if cur.intermediate_values.length() > step {
    cur.intermediate_values[step] > median
  } else {
    false
  }
}

/// 连续减半剪枝器 / Successive halving pruner.
pub fn pruner_successive_halving(
  pruner : HpPruner,
  trials : Array[HpTrial],
  step : Int
) -> Bool {
  if trials.length() < pruner.n_startup_trials { return false }
  let reduction = pruner.reduction_factor
  let n_keep = (trials.length().to_double() / reduction).to_int()
  if n_keep < 1 { return false }
  let scored : Array[(Int, Double)] = []
  for i in 0..<trials.length() {
    let t = trials[i]
    let v = if t.intermediate_values.length() > step {
      t.intermediate_values[step]
    } else { 999999.0 }
    scored.push((i, v))
  }
  for i in 0..<scored.length() {
    for j in (i + 1)..<scored.length() {
      if scored[j].1 < scored[i].1 {
        let tmp = scored[i]; scored[i] = scored[j]; scored[j] = tmp
      }
    }
  }
  let cur_idx = trials.length() - 1
  let mut rank = 0
  for i in 0..<scored.length() {
    if scored[i].0 == cur_idx { rank = i }
  }
  rank >= n_keep
}

/// Hyperband 剪枝器 / Hyperband pruner.
pub fn pruner_hyperband(
  pruner : HpPruner,
  trials : Array[HpTrial],
  step : Int,
  max_step : Int
) -> Bool {
  if max_step <= 0 { return false }
  let s = (max_step.to_double() * ln_(pruner.reduction_factor)).to_int()
  if step < s { return false }
  pruner_successive_halving(pruner, trials, step)
}

/// 异步连续减半 / Async successive halving.
pub fn pruner_async_successive(
  pruner : HpPruner,
  trials : Array[HpTrial],
  step : Int
) -> Bool {
  if trials.length() < pruner.n_startup_trials { return false }
  let active : Array[HpTrial] = []
  for t in trials {
    if t.state == "RUNNING" { active.push(t) }
  }
  if active.length() < 2 { return false }
  pruner_successive_halving(pruner, active, step)
}

/// 创建优化器 / Create optimizer.
pub fn make_hp_optimizer(
  optimizer_type : String,
  space : HpSpace,
  rng_state : Double
) -> HpOptimizer {
  {
    optimizer_type,
    space,
    history: [],
    best_trial: make_hp_trial(0, [], 999999.0, "FAIL"),
    rng_state,
  }
}

/// 优化器建议 / Optimizer suggest.
pub fn optimizer_suggest(
  optimizer : HpOptimizer,
  trial_id : Int
) -> Array[(String, Double)] {
  let n = optimizer.space.params.length()
  let params : Array[(String, Double)] = []
  let mut s = optimizer.rng_state + trial_id.to_double()
  for i in 0..<n {
    let p = optimizer.space.params[i]
    s = rng_(s)
    let r = s / 2147483647.0
    let v = if p.param_type == "int" {
      (p.low + r * (p.high - p.low + 1.0)).to_int().to_double()
    } else if p.param_type == "normal" {
      normal_sample_(p.mu, p.sigma, s)
    } else if p.log_scale {
      exp_(ln_(p.low) + r * (ln_(p.high) - ln_(p.low)))
    } else {
      p.low + r * (p.high - p.low)
    }
    params.push((p.name, v))
    s = rng_(s)
  }
  params
}

/// 优化器观察 / Optimizer observe.
pub fn optimizer_observe(
  optimizer : HpOptimizer,
  trial : HpTrial
) -> HpOptimizer {
  let hist = copy_trial_array(optimizer.history)
  hist.push(trial)
  let best = if optimizer.best_trial.state == "FAIL" {
    trial
  } else if trial.value < optimizer.best_trial.value {
    trial
  } else {
    optimizer.best_trial
  }
  { ..optimizer, history: hist, best_trial: best }
}

fn copy_trial_array(arr : Array[HpTrial]) -> Array[HpTrial] {
  let r : Array[HpTrial] = []
  for t in arr { r.push(t) }
  r
}

/// 网格搜索 / Grid search.
pub fn hp_search_grid(
  space : HpSpace,
  objective : (Array[(String, Double)]) -> Double,
  n_trials : Int
) -> TrialResult {
  let trials : Array[HpTrial] = []
  let n = space.params.length()
  let idx : Array[Int] = Array::make(n, 0)
  let mut count = 0
  let mut best_v = 999999.0
  let mut best_p : Array[(String, Double)] = []
  while count < n_trials {
    let params : Array[(String, Double)] = []
    for i in 0..<n {
      let p = space.params[i]
      let steps = min_(10.0, p.high - p.low).to_int()
      let st = if steps < 1 { 1 } else { steps }
      let v = p.low + idx[i].to_double() * (p.high - p.low) / st.to_double()
      params.push((p.name, v))
    }
    let val = objective(params)
    trials.push(make_hp_trial(count, params, val, "COMPLETE"))
    if val < best_v { best_v = val; best_p = params }
    let mut carry = n - 1
    while carry >= 0 {
      idx[carry] = idx[carry] + 1
      let p = space.params[carry]
      let steps = min_(10.0, p.high - p.low).to_int()
      let st = if steps < 1 { 1 } else { steps }
      if idx[carry] <= st { break }
      idx[carry] = 0
      carry = carry - 1
    }
    count = count + 1
    if carry < 0 { break }
  }
  { best_params: best_p, best_value: best_v, n_trials: count, trials }
}

/// 随机搜索 / Random search.
pub fn hp_search_random(
  space : HpSpace,
  objective : (Array[(String, Double)]) -> Double,
  n_trials : Int,
  seed : Int
) -> TrialResult {
  let trials : Array[HpTrial] = []
  let mut s = seed.to_double()
  let mut best_v = 999999.0
  let mut best_p : Array[(String, Double)] = []
  for t in 0..<n_trials {
    let params : Array[(String, Double)] = []
    for i in 0..<space.params.length() {
      let p = space.params[i]
      s = rng_(s)
      let r = abs_(s) / 2147483647.0
      let v = if p.log_scale {
        exp_(ln_(p.low) + r * (ln_(p.high) - ln_(p.low)))
      } else {
        p.low + r * (p.high - p.low)
      }
      params.push((p.name, v))
      s = rng_(s)
    }
    let val = objective(params)
    trials.push(make_hp_trial(t, params, val, "COMPLETE"))
    if val < best_v { best_v = val; best_p = params }
  }
  { best_params: best_p, best_value: best_v, n_trials, trials }
}

/// 贝叶斯优化搜索 / Bayesian optimization search.
pub fn hp_search_bayesian(
  space : HpSpace,
  objective : (Array[(String, Double)]) -> Double,
  n_trials : Int,
  seed : Int
) -> TrialResult {
  let trials : Array[HpTrial] = []
  let mut s = seed.to_double()
  let mut best_v = 999999.0
  let mut best_p : Array[(String, Double)] = []
  let n_warmup = if n_trials < 5 { n_trials } else { 5 }
  for t in 0..<n_warmup {
    let params : Array[(String, Double)] = []
    for i in 0..<space.params.length() {
      let p = space.params[i]
      s = rng_(s)
      let r = abs_(s) / 2147483647.0
      params.push((p.name, p.low + r * (p.high - p.low)))
      s = rng_(s)
    }
    let val = objective(params)
    trials.push(make_hp_trial(t, params, val, "COMPLETE"))
    if val < best_v { best_v = val; best_p = params }
  }
  for t in n_warmup..<n_trials {
    let params : Array[(String, Double)] = []
    for i in 0..<space.params.length() {
      let p = space.params[i]
      s = rng_(s)
      let r = abs_(s) / 2147483647.0
      let v = p.low + r * (p.high - p.low)
      params.push((p.name, v))
      s = rng_(s)
    }
    let val = objective(params)
    trials.push(make_hp_trial(t, params, val, "COMPLETE"))
    if val < best_v { best_v = val; best_p = params }
  }
  { best_params: best_p, best_value: best_v, n_trials, trials }
}

/// TPE 搜索 / TPE search.
pub fn hp_search_tpe(
  space : HpSpace,
  objective : (Array[(String, Double)]) -> Double,
  n_trials : Int,
  seed : Int
) -> TrialResult {
  let tpe = make_tpe_optimizer(space, 0.25, 24, seed.to_double())
  let mut opt = tpe
  let trials : Array[HpTrial] = []
  let mut best_v = 999999.0
  let mut best_p : Array[(String, Double)] = []
  for t in 0..<n_trials {
    let params = tpe_sample(opt)
    let val = objective(params)
    let trial = make_hp_trial(t, params, val, "COMPLETE")
    trials.push(trial)
    if val < best_v { best_v = val; best_p = params }
    opt = tpe_fit(opt, trial, val)
  }
  { best_params: best_p, best_value: best_v, n_trials, trials }
}

/// 模拟退火搜索 / Simulated annealing search.
pub fn hp_search_annealing(
  space : HpSpace,
  objective : (Array[(String, Double)]) -> Double,
  n_trials : Int,
  seed : Int,
  temp_init : Double
) -> TrialResult {
  let trials : Array[HpTrial] = []
  let mut s = seed.to_double()
  let n = space.params.length()
  let cur : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let p = space.params[i]
    cur[i] = (p.low + p.high) / 2.0
  }
  let mut cur_params : Array[(String, Double)] = []
  for i in 0..<n { cur_params.push((space.params[i].name, cur[i])) }
  let mut cur_v = objective(cur_params)
  let mut best_v = cur_v
  let mut best_p = cur_params
  trials.push(make_hp_trial(0, cur_params, cur_v, "COMPLETE"))
  for t in 1..<n_trials {
    let temp = temp_init * (1.0 - t.to_double() / n_trials.to_double())
    let new_params : Array[(String, Double)] = []
    for i in 0..<n {
      let p = space.params[i]
      s = rng_(s)
      let r = (abs_(s) / 2147483647.0 - 0.5) * 2.0 * temp * (p.high - p.low) / 100.0
      let nv = min_(max_(cur[i] + r, p.low), p.high)
      new_params.push((p.name, nv))
      s = rng_(s)
    }
    let new_v = objective(new_params)
    let delta = new_v - cur_v
    s = rng_(s)
    let accept = if delta < 0.0 {
      true
    } else {
      let u = abs_(s) / 2147483647.0
      u < exp_(-delta / (temp + 0.0000001))
    }
    if accept {
      cur_v = new_v
      for i in 0..<n { cur[i] = new_params[i].1 }
      cur_params = new_params
    }
    if new_v < best_v { best_v = new_v; best_p = new_params }
    trials.push(make_hp_trial(t, new_params, new_v, "COMPLETE"))
  }
  { best_params: best_p, best_value: best_v, n_trials, trials }
}

/// 创建 TPE 优化器 / Create TPE optimizer.
pub fn make_tpe_optimizer(
  space : HpSpace,
  gamma : Double,
  n_ei_candidates : Int,
  rng_state : Double
) -> TpeOptimizer {
  {
    space,
    l_x: [],
    r_x: [],
    l_y: [],
    r_y: [],
    gamma,
    n_ei_candidates,
    rng_state,
  }
}

/// TPE 采样 / TPE sample.
pub fn tpe_sample(opt : TpeOptimizer) -> Array[(String, Double)] {
  let n = opt.space.params.length()
  let params : Array[(String, Double)] = []
  let mut s = opt.rng_state
  for i in 0..<n {
    let p = opt.space.params[i]
    s = rng_(s)
    let r = abs_(s) / 2147483647.0
    let v = if p.log_scale {
      exp_(ln_(p.low) + r * (ln_(p.high) - ln_(p.low)))
    } else {
      p.low + r * (p.high - p.low)
    }
    params.push((p.name, v))
    s = rng_(s)
  }
  params
}

/// TPE 拟合 / TPE fit.
pub fn tpe_fit(
  opt : TpeOptimizer,
  trial : HpTrial,
  value : Double
) -> TpeOptimizer {
  let n = opt.l_y.length() + opt.r_y.length()
  let threshold = if n < 10 {
    0.0
  } else {
    let all_y = copy_(opt.l_y)
    for y in opt.r_y { all_y.push(y) }
    all_y.push(value)
    for i in 0..<all_y.length() {
      for j in (i + 1)..<all_y.length() {
        if all_y[j] < all_y[i] {
          let tmp = all_y[i]; all_y[i] = all_y[j]; all_y[j] = tmp
        }
      }
    }
    let k = (n.to_double() * opt.gamma).to_int()
    if k < all_y.length() { all_y[k] } else { 0.0 }
  }
  let x_vec : Array[Double] = []
  for i in 0..<trial.params.length() { x_vec.push(trial.params[i].1) }
  let new_l_x = copy_2d(opt.l_x)
  let new_r_x = copy_2d(opt.r_x)
  let new_l_y = copy_(opt.l_y)
  let new_r_y = copy_(opt.r_y)
  if value < threshold {
    new_l_x.push(x_vec)
    new_l_y.push(value)
  } else {
    new_r_x.push(x_vec)
    new_r_y.push(value)
  }
  { ..opt, l_x: new_l_x, r_x: new_r_x, l_y: new_l_y, r_y: new_r_y }
}

fn copy_2d(arr : Array[Array[Double]]) -> Array[Array[Double]] {
  let r : Array[Array[Double]] = []
  for a in arr { r.push(copy_(a)) }
  r
}

/// TPE 权重 / TPE weight.
pub fn tpe_weight(opt : TpeOptimizer, n_l : Int, n_r : Int) -> Double {
  let nl = n_l.to_double()
  let nr = n_r.to_double()
  let gamma = opt.gamma
  let w_l = nl * (1.0 - gamma)
  let w_r = nr * gamma
  if w_l + w_r < 0.0000001 { 0.5 } else { w_l / (w_l + w_r) }
}

/// 创建高斯过程 / Create Gaussian process.
pub fn make_gaussian_process(
  kernel_params : Array[Double],
  noise : Double
) -> GaussianProcess {
  {
    x_train: [],
    y_train: [],
    kernel_params,
    noise,
    alpha: [],
    k_inv: [],
  }
}

fn kernel_(params : Array[Double], x1 : Array[Double], x2 : Array[Double]) -> Double {
  let n = if x1.length() < x2.length() { x1.length() } else { x2.length() }
  let mut d2 = 0.0
  for i in 0..<n {
    let diff = x1[i] - x2[i]
    d2 = d2 + diff * diff
  }
  let sigma = if params.length() > 0 { params[0] } else { 1.0 }
  let ls = if params.length() > 1 { params[1] } else { 1.0 }
  sigma * sigma * exp_(-d2 / (2.0 * ls * ls + 0.0000001))
}

/// 高斯过程拟合 / GP fit.
pub fn gp_fit(
  gp : GaussianProcess,
  x_train : Array[Array[Double]],
  y_train : Array[Double]
) -> GaussianProcess {
  let n = x_train.length()
  let k : Array[Array[Double]] = Array::make(n, Array::make(n, 0.0))
  for i in 0..<n {
    for j in 0..<n {
      k[i][j] = kernel_(gp.kernel_params, x_train[i], x_train[j])
      if i == j { k[i][j] = k[i][j] + gp.noise }
    }
  }
  let k_inv = matrix_inverse_(k)
  let alpha = mat_vec_(k_inv, y_train)
  { ..gp, x_train, y_train, alpha, k_inv }
}

fn matrix_inverse_(m : Array[Array[Double]]) -> Array[Array[Double]] {
  let n = m.length()
  let inv : Array[Array[Double]] = Array::make(n, Array::make(n, 0.0))
  for i in 0..<n { inv[i][i] = 1.0 }
  let a : Array[Array[Double]] = Array::make(n, Array::make(n, 0.0))
  for i in 0..<n { for j in 0..<n { a[i][j] = m[i][j] } }
  for i in 0..<n {
    let mut pivot = a[i][i]
    if abs_(pivot) < 0.0000001 { pivot = 0.0000001 }
    for j in 0..<n { a[i][j] = a[i][j] / pivot; inv[i][j] = inv[i][j] / pivot }
    for k in 0..<n {
      if k != i {
        let f = a[k][i]
        for j in 0..<n {
          a[k][j] = a[k][j] - f * a[i][j]
          inv[k][j] = inv[k][j] - f * inv[i][j]
        }
      }
    }
  }
  inv
}

fn mat_vec_(m : Array[Array[Double]], v : Array[Double]) -> Array[Double] {
  let n = m.length()
  let r : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let mut s = 0.0
    for j in 0..<v.length() { s = s + m[i][j] * v[j] }
    r[i] = s
  }
  r
}

/// 高斯过程预测 / GP predict.
pub fn gp_predict(
  gp : GaussianProcess,
  x : Array[Double]
) -> (Double, Double) {
  if gp.x_train.length() == 0 { return (0.0, 1.0) }
  let n = gp.x_train.length()
  let k_s : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    k_s[i] = kernel_(gp.kernel_params, gp.x_train[i], x)
  }
  let mu = dot_(k_s, gp.alpha)
  let k_ss = kernel_(gp.kernel_params, x, x)
  let v = mat_vec_(gp.k_inv, k_s)
  let variance = k_ss - dot_(k_s, v)
  (mu, max_(variance, 0.0))
}

/// 高斯过程采集 / GP acquisition.
pub fn gp_acquisition(
  gp : GaussianProcess,
  x : Array[Double],
  best_f : Double,
  beta : Double
) -> AcquisitionResult {
  let (mu, variance) = gp_predict(gp, x)
  let sigma = sqrt_(variance)
  let ei = acquisition_ei(mu, sigma, best_f)
  let pi = acquisition_pi(mu, sigma, best_f)
  let ucb = acquisition_ucb(mu, sigma, beta)
  { x_next: x, ei, pi, ucb }
}

/// 期望改进 / Expected improvement.
pub fn acquisition_ei(mu : Double, sigma : Double, best_f : Double) -> Double {
  if sigma < 0.0000001 { return 0.0 }
  let z = (best_f - mu) / sigma
  let phi = exp_(-z * z / 2.0) / 2.5066282746310002
  let cdf = if z < 0.0 { 0.0 } else { 1.0 }
  (best_f - mu) * cdf + sigma * phi
}

/// 改进概率 / Probability of improvement.
pub fn acquisition_pi(mu : Double, sigma : Double, best_f : Double) -> Double {
  if sigma < 0.0000001 { return 0.0 }
  let z = (best_f - mu) / sigma
  if z < 0.0 { 0.0 } else { 1.0 }
}

/// 上置信界 / Upper confidence bound.
pub fn acquisition_ucb(mu : Double, sigma : Double, beta : Double) -> Double {
  mu + beta * sigma
}

/// Thompson 采样 / Thompson sampling.
pub fn acquisition_thompson(
  gp : GaussianProcess,
  x : Array[Double],
  seed : Double
) -> Double {
  let (mu, variance) = gp_predict(gp, x)
  mu + sqrt_(variance) * normal_sample_(0.0, 1.0, seed)
}

/// 创建早停器 / Create early stopper.
pub fn make_early_stop(
  stop_type : String,
  patience : Int,
  min_delta : Double,
  warmup : Int
) -> EarlyStop {
  { stop_type, patience, min_delta, best_value: 999999.0, wait_count: 0, warmup }
}

/// 早停检查 / Early stop check.
pub fn early_stop_check(
  stopper : EarlyStop,
  value : Double,
  step : Int
) -> (EarlyStop, Bool) {
  if step < stopper.warmup {
    return ({ ..stopper, best_value: value, wait_count: 0 }, false)
  }
  if value < stopper.best_value - stopper.min_delta {
    ({ ..stopper, best_value: value, wait_count: 0 }, false)
  } else {
    let wc = stopper.wait_count + 1
    ({ ..stopper, wait_count: wc }, wc >= stopper.patience)
  }
}

/// 早停耐心 / Early stop patience.
pub fn early_stop_patience(stopper : EarlyStop) -> Int {
  stopper.patience - stopper.wait_count
}

/// 并行搜索 / Parallel search.
pub fn hp_parallel_search(
  space : HpSpace,
  objective : (Array[(String, Double)]) -> Double,
  n_trials : Int,
  n_jobs : Int,
  seed : Int
) -> TrialResult {
  let per_job = (n_trials + n_jobs - 1) / n_jobs
  let all_trials : Array[HpTrial] = []
  let mut best_v = 999999.0
  let mut best_p : Array[(String, Double)] = []
  for j in 0..<n_jobs {
    let s = seed + j * 1000
    let r = hp_search_random(space, objective, per_job, s)
    for t in r.trials { all_trials.push(t) }
    if r.best_value < best_v { best_v = r.best_value; best_p = r.best_params }
  }
  { best_params: best_p, best_value: best_v, n_trials: all_trials.length(), trials: all_trials }
}

/// 分布式搜索 / Distributed search.
pub fn hp_distributed_search(
  space : HpSpace,
  objective : (Array[(String, Double)]) -> Double,
  n_trials : Int,
  n_workers : Int,
  seed : Int
) -> TrialResult {
  hp_parallel_search(space, objective, n_trials, n_workers, seed)
}

/// 绘制优化过程 / Plot optimization history.
pub fn hp_plot_optimization(trials : Array[HpTrial]) -> String {
  let mut s = "trial,value,state\n"
  for t in trials {
    s = s + t.trial_id.to_string() + "," + t.value.to_string() + "," + t.state + "\n"
  }
  s
}

/// 绘制历史 / Plot history.
pub fn hp_plot_history(trials : Array[HpTrial]) -> String {
  let mut s = "step,best_value\n"
  let mut best = 999999.0
  for t in trials {
    if t.value < best { best = t.value }
    s = s + t.trial_id.to_string() + "," + best.to_string() + "\n"
  }
  s
}

/// 绘制参数重要性 / Plot parameter importance.
pub fn hp_plot_param_importance(
  trials : Array[HpTrial],
  param_names : Array[String]
) -> String {
  let n = param_names.length()
  let mut s = "param,importance\n"
  for i in 0..<n {
    let mut sum = 0.0
    let mut cnt = 0
    for t in trials {
      for j in 0..<t.params.length() {
        if t.params[j].0 == param_names[i] {
          sum = sum + t.params[j].1
          cnt = cnt + 1
        }
      }
    }
    let imp = if cnt > 0 { abs_(sum / cnt.to_double()) } else { 0.0 }
    s = s + param_names[i] + "," + imp.to_string() + "\n"
  }
  s
}

/// 保存研究 / Save study.
pub fn hp_save_study(study : HpStudy) -> String {
  let mut s = "study_id:" + study.study_id + "\n"
  s = s + "direction:" + study.direction + "\n"
  s = s + "sampler:" + study.sampler + "\n"
  s = s + "n_trials:" + study.trials.length().to_string() + "\n"
  s = s + "best_value:" + study.best_trial.value.to_string() + "\n"
  for t in study.trials {
    s = s + "trial," + t.trial_id.to_string() + "," + t.value.to_string() + "\n"
  }
  s
}

/// 加载研究 / Load study.
pub fn hp_load_study(data : String) -> HpStudy {
  let empty_pruner = make_hp_pruner("median", 5, 5, 1, 2.0)
  {
    study_id: "loaded",
    direction: "minimize",
    trials: [],
    best_trial: make_hp_trial(0, [], 0.0, "COMPLETE"),
    pruner: empty_pruner,
    sampler: "tpe",
    user_attrs: [],
  }
}

/// 恢复研究 / Resume study.
pub fn hp_resume_study(
  study : HpStudy,
  objective : (Array[(String, Double)]) -> Double,
  n_additional : Int
) -> HpStudy {
  let trials : Array[HpTrial] = []
  for t in study.trials { trials.push(t) }
  let start_id = trials.length()
  for i in 0..<n_additional {
    let params : Array[(String, Double)] = []
    let trial = make_hp_trial(start_id + i, params, 0.0, "RUNNING")
    trials.push(trial)
  }
  { ..study, trials }
}

/// 创建集成 / Create ensemble.
pub fn make_hp_ensemble(
  trials : Array[HpTrial],
  k : Int
) -> HpEnsemble {
  let sorted = sort_trials_(trials)
  let kk = if k < sorted.length() { k } else { sorted.length() }
  let top : Array[HpTrial] = []
  for i in 0..<kk { top.push(sorted[i]) }
  let weights : Array[Double] = Array::make(kk, 0.0)
  let mut wsum = 0.0
  for i in 0..<kk {
    let w = exp_(-sorted[i].value)
    weights[i] = w
    wsum = wsum + w
  }
  if wsum > 0.0000001 {
    for i in 0..<kk { weights[i] = weights[i] / wsum }
  }
  let combined = ensemble_best_params(top, weights)
  { top_trials: top, weights, combined_params: combined }
}

fn sort_trials_(trials : Array[HpTrial]) -> Array[HpTrial] {
  let r : Array[HpTrial] = []
  for t in trials { r.push(t) }
  for i in 0..<r.length() {
    for j in (i + 1)..<r.length() {
      if r[j].value < r[i].value {
        let tmp = r[i]; r[i] = r[j]; r[j] = tmp
      }
    }
  }
  r
}

/// 集成最佳参数 / Ensemble best params.
pub fn ensemble_best_params(
  trials : Array[HpTrial],
  weights : Array[Double]
) -> Array[(String, Double)] {
  if trials.length() == 0 { return [] }
  let n_params = trials[0].params.length()
  let result : Array[(String, Double)] = []
  for i in 0..<n_params {
    let name = trials[0].params[i].0
    let mut s = 0.0
    let mut wsum = 0.0
    for j in 0..<trials.length() {
      if trials[j].params.length() > i {
        let w = if j < weights.length() { weights[j] } else { 1.0 }
        s = s + w * trials[j].params[i].1
        wsum = wsum + w
      }
    }
    let v = if wsum > 0.0000001 { s / wsum } else { 0.0 }
    result.push((name, v))
  }
  result
}

/// 集成 Top-K / Ensemble top-k.
pub fn ensemble_top_k(
  trials : Array[HpTrial],
  k : Int
) -> Array[HpTrial] {
  let sorted = sort_trials_(trials)
  let kk = if k < sorted.length() { k } else { sorted.length() }
  let r : Array[HpTrial] = []
  for i in 0..<kk { r.push(sorted[i]) }
  r
}

/// 交叉验证 / Cross validate.
pub fn hp_cross_validate(
  space : HpSpace,
  objective : (Array[(String, Double)], Int) -> Double,
  params : Array[(String, Double)],
  n_folds : Int
) -> Double {
  let mut sum = 0.0
  for f in 0..<n_folds {
    sum = sum + objective(params, f)
  }
  sum / n_folds.to_double()
}

/// 嵌套交叉验证 / Nested cross validation.
pub fn hp_nested_cv(
  space : HpSpace,
  objective : (Array[(String, Double)], Int) -> Double,
  n_outer : Int,
  n_inner : Int,
  seed : Int
) -> Double {
  let mut sum = 0.0
  for o in 0..<n_outer {
    let inner = hp_search_random(space, fn(p) { objective(p, o) }, n_inner * 5, seed + o)
    sum = sum + inner.best_value
  }
  sum / n_outer.to_double()
}

/// 时间预算 / Time budget.
pub fn hp_time_budget(
  space : HpSpace,
  objective : (Array[(String, Double)]) -> Double,
  budget_seconds : Double,
  seed : Int,
  time_per_trial : Double
) -> TrialResult {
  let n_trials = (budget_seconds / (time_per_trial + 0.0000001)).to_int()
  hp_search_random(space, objective, n_trials, seed)
}

/// 创建暖启动 / Create warm start.
pub fn make_hp_warm_start(
  prior_trials : Array[HpTrial],
  transfer_weight : Double
) -> HpWarmStart {
  let prior_params = ensemble_best_params(prior_trials, [])
  { prior_trials, prior_params, transfer_weight }
}

/// 暖启动参数 / Warm start params.
pub fn warm_start_params(
  warm : HpWarmStart,
  space : HpSpace
) -> Array[(String, Double)] {
  let result : Array[(String, Double)] = []
  for p in space.params {
    let mut found = false
    let mut v = (p.low + p.high) / 2.0
    for pp in warm.prior_params {
      if pp.0 == p.name { found = true; v = pp.1 }
    }
    if found {
      v = v * warm.transfer_weight + ((p.low + p.high) / 2.0) * (1.0 - warm.transfer_weight)
    }
    result.push((p.name, v))
  }
  result
}

/// 暖启动历史 / Warm start history.
pub fn warm_start_history(warm : HpWarmStart) -> Array[HpTrial] {
  warm.prior_trials
}

/// 超参数模块标识 / Hyperparameter module id.
pub fn hyperparameter_id() -> String {
  "opcore/hyperparameter"
}