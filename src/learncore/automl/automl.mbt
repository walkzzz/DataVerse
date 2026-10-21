///|
/// # learncore/automl 自动化机器学习 / Automated Machine Learning
///
/// 模型搜索/管道搜索/集成搜索/神经架构搜索/元学习/资源感知/可解释。
/// 纯 AutoML 算法集合，对标 auto-sklearn + TPOT + AutoGluon。
///
/// # Automated Machine Learning
///
/// Model/pipeline/ensemble/neural search with meta-learning and resource awareness.

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

fn rng_(seed : Double) -> Double {
  let s = seed * 1103515245.0 + 12345.0
  s - (s / 2147483647.0).to_int().to_double() * 2147483647.0
}

/// AutoML 配置 / AutoML configuration.
pub(all) struct AutoMlConfig {
  time_limit : Double
  n_jobs : Int
  seed : Int
  metric : String
  task_type : String
  ensemble_size : Int
  n_folds : Int
  max_models : Int
  verbose : Bool
}

/// 模型搜索空间 / Model search space.
pub(all) struct ModelSearchSpace {
  classifiers : Array[String]
  regressors : Array[String]
  preprocessing : Array[String]
  feature_eng : Array[String]
  postprocessing : Array[String]
}

/// 模型候选 / Model candidate.
pub(all) struct ModelCandidate {
  name : String
  model_type : String
  params : Array[(String, Double)]
  score : Double
  fit_time : Double
  predict_time : Double
  complexity : Int
}

/// 管道 / Pipeline.
pub(all) struct AutoMlPipeline {
  pipeline_id : Int
  steps : Array[PipelineStep]
  score : Double
  fitted : Bool
}

/// 管道步骤 / Pipeline step.
pub(all) struct PipelineStep {
  step_name : String
  step_type : String
  params : Array[(String, Double)]
}

/// 集成模型 / Ensemble model.
pub(all) struct AutoMlEnsemble {
  ensemble_id : Int
  models : Array[ModelCandidate]
  weights : Array[Double]
  score : Double
  combination : String
}

/// 神经架构 / Neural architecture.
pub(all) struct NeuralArchitecture {
  arch_id : Int
  layers : Array[Int]
  activations : Array[String]
  connections : Array[(Int, Int)]
  score : Double
  params_count : Int
}

/// HPO-AutoML 配置 / HPO-AutoML config.
pub(all) struct HpoAutoMl {
  config : AutoMlConfig
  search_space : ModelSearchSpace
  trials : Array[ModelCandidate]
  best_model : ModelCandidate
}

/// 元学习器 / Meta learner.
pub(all) struct MetaLearner {
  dataset_features : Array[Double]
  model_performances : Array[(String, Double)]
  trained : Bool
}

/// 模型选择器 / Model selector.
pub(all) struct ModelSelection {
  candidates : Array[ModelCandidate]
  selection_criteria : String
  diversity_weight : Double
}

/// 数据感知 / Data aware.
pub(all) struct DataAware {
  n_samples : Int
  n_features : Int
  n_classes : Int
  feature_types : Array[String]
  missing_ratio : Double
  imbalance_ratio : Double
}

/// 资源感知 / Resource aware.
pub(all) struct ResourceAware {
  cpu_budget : Int
  memory_budget : Int
  gpu_count : Int
  time_budget : Double
  allocated : Array[(String, Int)]
}

/// 时间感知 / Time aware.
pub(all) struct TimeAware {
  total_budget : Double
  elapsed : Double
  per_model_estimate : Double
  remaining : Double
}

/// 可解释性 / Interpretable.
pub(all) struct Interpretable {
  interpretability_score : Double
  accuracy_score : Double
  tradeoff_alpha : Double
}

/// 稳健 AutoML / Robust AutoML.
pub(all) struct RobustAutoMl {
  candidates : Array[ModelCandidate]
  noise_tolerance : Double
  cv_folds : Int
  worst_case_score : Double
}

/// AutoML 报告 / AutoML report.
pub(all) struct AutoMlReport {
  best_model : String
  best_score : Double
  n_models_tried : Int
  total_time : Double
  leaderboard : Array[(String, Double)]
  config : AutoMlConfig
}

/// 渐进搜索 / Progressive search.
pub(all) struct ProgressiveSearch {
  stage : Int
  n_stages : Int
  candidates_per_stage : Int
  refine_factor : Double
  current_best : Double
}

/// 创建 AutoML 配置 / Create AutoML config.
pub fn make_automl_config(
  time_limit : Double,
  n_jobs : Int,
  seed : Int,
  metric : String,
  task_type : String,
  ensemble_size : Int,
  n_folds : Int,
  max_models : Int,
  verbose : Bool
) -> AutoMlConfig {
  { time_limit, n_jobs, seed, metric, task_type, ensemble_size, n_folds, max_models, verbose }
}

/// 创建模型搜索空间 / Create model search space.
pub fn make_model_search_space(
  classifiers : Array[String],
  regressors : Array[String],
  preprocessing : Array[String],
  feature_eng : Array[String],
  postprocessing : Array[String]
) -> ModelSearchSpace {
  { classifiers, regressors, preprocessing, feature_eng, postprocessing }
}

/// 搜索分类器 / Search classifiers.
pub fn search_classifiers(
  space : ModelSearchSpace,
  n_max : Int
) -> Array[String] {
  let n = if n_max < space.classifiers.length() { n_max } else { space.classifiers.length() }
  let r : Array[String] = []
  for i in 0..<n { r.push(space.classifiers[i]) }
  r
}

/// 搜索回归器 / Search regressors.
pub fn search_regressors(
  space : ModelSearchSpace,
  n_max : Int
) -> Array[String] {
  let n = if n_max < space.regressors.length() { n_max } else { space.regressors.length() }
  let r : Array[String] = []
  for i in 0..<n { r.push(space.regressors[i]) }
  r
}

/// 搜索预处理 / Search preprocessing.
pub fn search_preprocessing(
  space : ModelSearchSpace,
  n_max : Int
) -> Array[String] {
  let n = if n_max < space.preprocessing.length() {
    n_max
  } else {
    space.preprocessing.length()
  }
  let r : Array[String] = []
  for i in 0..<n { r.push(space.preprocessing[i]) }
  r
}

/// 搜索特征工程 / Search feature engineering.
pub fn search_feature_eng(
  space : ModelSearchSpace,
  n_max : Int
) -> Array[String] {
  let n = if n_max < space.feature_eng.length() { n_max } else { space.feature_eng.length() }
  let r : Array[String] = []
  for i in 0..<n { r.push(space.feature_eng[i]) }
  r
}

/// 搜索后处理 / Search postprocessing.
pub fn search_postprocessing(
  space : ModelSearchSpace,
  n_max : Int
) -> Array[String] {
  let n = if n_max < space.postprocessing.length() {
    n_max
  } else {
    space.postprocessing.length()
  }
  let r : Array[String] = []
  for i in 0..<n { r.push(space.postprocessing[i]) }
  r
}

/// 创建管道搜索 / Create pipeline search.
pub fn make_pipeline_search(
  space : ModelSearchSpace,
  max_steps : Int
) -> Array[AutoMlPipeline] {
  let pipelines : Array[AutoMlPipeline] = []
  let pre = search_preprocessing(space, 3)
  let models = search_classifiers(space, 5)
  let mut pid = 0
  for p in pre {
    for m in models {
      let steps : Array[PipelineStep] = [
        { step_name: p, step_type: "preprocess", params: [] },
        { step_name: m, step_type: "model", params: [] },
      ]
      pipelines.push({ pipeline_id: pid, steps, score: 0.0, fitted: false })
      pid = pid + 1
      if pid >= max_steps { break }
    }
    if pid >= max_steps { break }
  }
  pipelines
}

/// 生成管道 / Generate pipeline.
pub fn pipeline_generate(
  space : ModelSearchSpace,
  seed : Int
) -> AutoMlPipeline {
  let mut s = seed.to_double()
  s = rng_(s)
  let pre_idx = (abs_(s) / 2147483647.0 * space.preprocessing.length().to_double()).to_int()
  s = rng_(s)
  let model_idx = (abs_(s) / 2147483647.0 * space.classifiers.length().to_double()).to_int()
  let pre = if pre_idx < space.preprocessing.length() {
    space.preprocessing[pre_idx]
  } else {
    "identity"
  }
  let model = if model_idx < space.classifiers.length() {
    space.classifiers[model_idx]
  } else {
    "logistic"
  }
  let steps : Array[PipelineStep] = [
    { step_name: pre, step_type: "preprocess", params: [] },
    { step_name: model, step_type: "model", params: [] },
  ]
  { pipeline_id: seed, steps, score: 0.0, fitted: false }
}

/// 评估管道 / Evaluate pipeline.
pub fn pipeline_evaluate(
  pipeline : AutoMlPipeline,
  eval_fn : (Array[PipelineStep]) -> Double
) -> AutoMlPipeline {
  let score = eval_fn(pipeline.steps)
  { ..pipeline, score, fitted: true }
}

/// 创建集成搜索 / Create ensemble search.
pub fn make_ensemble_search(
  candidates : Array[ModelCandidate],
  max_size : Int
) -> Array[AutoMlEnsemble] {
  let ensembles : Array[AutoMlEnsemble] = []
  let n = if max_size < candidates.length() { max_size } else { candidates.length() }
  let mut eid = 0
  for size in 2..=n {
    let models : Array[ModelCandidate] = []
    let weights : Array[Double] = []
    let mut wsum = 0.0
    for i in 0..<size {
      models.push(candidates[i])
      let w = exp_(-candidates[i].score)
      weights.push(w)
      wsum = wsum + w
    }
    if wsum > 0.0000001 {
      for i in 0..<weights.length() { weights[i] = weights[i] / wsum }
    }
    let mut score = 0.0
    for i in 0..<models.length() { score = score + weights[i] * models[i].score }
    ensembles.push({ ensemble_id: eid, models, weights, score, combination: "weighted_avg" })
    eid = eid + 1
  }
  ensembles
}

/// 生成集成 / Generate ensemble.
pub fn ensemble_generate(
  models : Array[ModelCandidate],
  combination : String
) -> AutoMlEnsemble {
  let n = models.length()
  let weights : Array[Double] = Array::make(n, 1.0 / n.to_double())
  let mut score = 0.0
  for i in 0..<n { score = score + weights[i] * models[i].score }
  { ensemble_id: 0, models, weights, score, combination }
}

/// 评估集成 / Evaluate ensemble.
pub fn ensemble_evaluate(
  ensemble : AutoMlEnsemble,
  eval_fn : (Array[ModelCandidate], Array[Double]) -> Double
) -> AutoMlEnsemble {
  let score = eval_fn(ensemble.models, ensemble.weights)
  { ..ensemble, score }
}

/// 创建神经搜索 / Create neural search.
pub fn make_neural_search(
  max_layers : Int,
  max_units : Int,
  seed : Int
) -> Array[NeuralArchitecture] {
  let archs : Array[NeuralArchitecture] = []
  let mut s = seed.to_double()
  let mut aid = 0
  for n_layers in 1..=max_layers {
    let layers : Array[Int] = Array::make(n_layers, 0)
    let acts : Array[String] = Array::make(n_layers, "relu")
    let mut pc = 0
    for i in 0..<n_layers {
      s = rng_(s)
      let u = (abs_(s) / 2147483647.0 * max_units.to_double()).to_int() + 1
      layers[i] = u
      pc = pc + u
    }
    let conns : Array[(Int, Int)] = []
    for i in 0..<(n_layers - 1) { conns.push((i, i + 1)) }
    archs.push({ arch_id: aid, layers, activations: acts, connections: conns, score: 0.0, params_count: pc })
    aid = aid + 1
  }
  archs
}

/// 神经架构搜索 / Neural architecture search.
pub fn neural_arch_search(
  max_layers : Int,
  max_units : Int,
  eval_fn : (NeuralArchitecture) -> Double,
  n_trials : Int,
  seed : Int
) -> NeuralArchitecture {
  let archs = make_neural_search(max_layers, max_units, seed)
  if archs.length() == 0 {
    return { arch_id: 0, layers: [], activations: [], connections: [], score: 0.0, params_count: 0 }
  }
  let mut best = archs[0]
  let mut best_score = eval_fn(best)
  let n = if n_trials < archs.length() { n_trials } else { archs.length() }
  for i in 1..<n {
    let sc = eval_fn(archs[i])
    if sc > best_score { best = archs[i]; best_score = sc }
  }
  { ..best, score: best_score }
}

/// 神经架构优化 / Neural architecture optimize.
pub fn neural_arch_optimize(
  arch : NeuralArchitecture,
  eval_fn : (NeuralArchitecture) -> Double,
  n_iters : Int,
  seed : Int
) -> NeuralArchitecture {
  let mut cur = arch
  let mut cur_score = eval_fn(cur)
  let mut s = seed.to_double()
  for _ in 0..<n_iters {
    s = rng_(s)
    let idx = (abs_(s) / 2147483647.0 * cur.layers.length().to_double()).to_int()
    s = rng_(s)
    let delta = (abs_(s) / 2147483647.0 - 0.5) * 10.0
    if idx < cur.layers.length() {
      let new_layers = copy_int_(cur.layers)
      new_layers[idx] = max_(1.0, new_layers[idx].to_double() + delta).to_int()
      let candidate = { ..cur, layers: new_layers }
      let cs = eval_fn(candidate)
      if cs > cur_score { cur = candidate; cur_score = cs }
    }
  }
  cur
}

fn copy_int_(arr : Array[Int]) -> Array[Int] {
  let r : Array[Int] = Array::make(arr.length(), 0)
  for i in 0..<arr.length() { r[i] = arr[i] }
  r
}

/// 创建 HPO-AutoML / Create HPO-AutoML.
pub fn make_hpo_automl(
  config : AutoMlConfig,
  search_space : ModelSearchSpace
) -> HpoAutoMl {
  {
    config,
    search_space,
    trials: [],
    best_model: {
      name: "",
      model_type: "",
      params: [],
      score: -999999.0,
      fit_time: 0.0,
      predict_time: 0.0,
      complexity: 0,
    },
  }
}

/// HPO 运行 / HPO run.
pub fn hpo_run(
  hpo : HpoAutoMl,
  eval_fn : (String, Array[(String, Double)]) -> Double,
  n_trials : Int
) -> HpoAutoMl {
  let trials : Array[ModelCandidate] = []
  let mut best_score = -999999.0
  let mut best_model = hpo.best_model
  let models = search_classifiers(hpo.search_space, n_trials)
  for i in 0..<models.length() {
    let params : Array[(String, Double)] = []
    let score = eval_fn(models[i], params)
    let cand = {
      name: models[i],
      model_type: "classifier",
      params,
      score,
      fit_time: 0.0,
      predict_time: 0.0,
      complexity: 0,
    }
    trials.push(cand)
    if score > best_score { best_score = score; best_model = cand }
  }
  { ..hpo, trials, best_model }
}

/// HPO 并行 / HPO parallel.
pub fn hpo_parallel(
  hpo : HpoAutoMl,
  eval_fn : (String, Array[(String, Double)]) -> Double,
  n_trials : Int,
  n_jobs : Int
) -> HpoAutoMl {
  let per_job = (n_trials + n_jobs - 1) / n_jobs
  let all_trials : Array[ModelCandidate] = []
  let mut best = hpo.best_model
  for _ in 0..<n_jobs {
    let sub = hpo_run(hpo, eval_fn, per_job)
    for t in sub.trials { all_trials.push(t) }
    if sub.best_model.score > best.score { best = sub.best_model }
  }
  { ..hpo, trials: all_trials, best_model: best }
}

/// HPO 分布式 / HPO distributed.
pub fn hpo_distributed(
  hpo : HpoAutoMl,
  eval_fn : (String, Array[(String, Double)]) -> Double,
  n_trials : Int,
  n_workers : Int
) -> HpoAutoMl {
  hpo_parallel(hpo, eval_fn, n_trials, n_workers)
}

/// 创建元学习器 / Create meta learner.
pub fn make_meta_learner() -> MetaLearner {
  { dataset_features: [], model_performances: [], trained: false }
}

/// 元学习特征 / Meta learn features.
pub fn meta_learn_features(
  learner : MetaLearner,
  data_aware : DataAware
) -> MetaLearner {
  let features : Array[Double] = [
    data_aware.n_samples.to_double(),
    data_aware.n_features.to_double(),
    data_aware.n_classes.to_double(),
    data_aware.missing_ratio,
    data_aware.imbalance_ratio,
    ln_(data_aware.n_samples.to_double() + 1.0),
    ln_(data_aware.n_features.to_double() + 1.0),
  ]
  { ..learner, dataset_features: features }
}

/// 元预测性能 / Meta predict performance.
pub fn meta_predict_performance(
  learner : MetaLearner,
  model_name : String
) -> Double {
  if !(learner.trained) { return 0.5 }
  let mut sum = 0.0
  let mut cnt = 0
  for mp in learner.model_performances {
    if mp.0 == model_name { sum = sum + mp.1; cnt = cnt + 1 }
  }
  if cnt > 0 { sum / cnt.to_double() } else { 0.5 }
}

/// 创建模型选择器 / Create model selector.
pub fn model_selection(
  candidates : Array[ModelCandidate],
  criteria : String,
  diversity_weight : Double
) -> ModelSelection {
  { candidates, selection_criteria: criteria, diversity_weight }
}

/// 选择最佳 / Select best.
pub fn select_best(
  selector : ModelSelection
) -> ModelCandidate {
  if selector.candidates.length() == 0 {
    return {
      name: "",
      model_type: "",
      params: [],
      score: -999999.0,
      fit_time: 0.0,
      predict_time: 0.0,
      complexity: 0,
    }
  }
  let mut best = selector.candidates[0]
  for i in 1..<selector.candidates.length() {
    if selector.candidates[i].score > best.score { best = selector.candidates[i] }
  }
  best
}

/// 选择 Top-K / Select top-k.
pub fn select_top_k(
  selector : ModelSelection,
  k : Int
) -> Array[ModelCandidate] {
  let sorted = sort_candidates_(selector.candidates)
  let kk = if k < sorted.length() { k } else { sorted.length() }
  let r : Array[ModelCandidate] = []
  for i in 0..<kk { r.push(sorted[i]) }
  r
}

/// 选择多样性 / Select diverse.
pub fn select_diverse(
  selector : ModelSelection,
  k : Int
) -> Array[ModelCandidate] {
  let sorted = sort_candidates_(selector.candidates)
  if sorted.length() == 0 { return [] }
  let r : Array[ModelCandidate] = []
  r.push(sorted[0])
  let mut last = 0
  while r.length() < k && r.length() < sorted.length() {
    let mut next_idx = -1
    let mut max_dist = -1.0
    for i in 0..<sorted.length() {
      let mut in_set = false
      for j in 0..<r.length() { if sorted[i].name == r[j].name { in_set = true } }
      if !(in_set) {
        let d = abs_(sorted[i].score - sorted[last].score)
        let div_bonus = selector.diversity_weight * d
        if div_bonus > max_dist { max_dist = div_bonus; next_idx = i }
      }
    }
    if next_idx < 0 { break }
    r.push(sorted[next_idx])
    last = next_idx
  }
  r
}

fn sort_candidates_(cands : Array[ModelCandidate]) -> Array[ModelCandidate] {
  let r : Array[ModelCandidate] = []
  for c in cands { r.push(c) }
  for i in 0..<r.length() {
    for j in (i + 1)..<r.length() {
      if r[j].score > r[i].score {
        let tmp = r[i]; r[i] = r[j]; r[j] = tmp
      }
    }
  }
  r
}

/// 创建数据感知 / Create data aware.
pub fn make_data_aware(
  n_samples : Int,
  n_features : Int,
  n_classes : Int,
  feature_types : Array[String],
  missing_ratio : Double,
  imbalance_ratio : Double
) -> DataAware {
  { n_samples, n_features, n_classes, feature_types, missing_ratio, imbalance_ratio }
}

/// 数据画像 AutoML / Data profile for AutoML.
pub fn data_profile_automl(
  data : Array[Array[Double]],
  labels : Array[Int]
) -> DataAware {
  let n_samples = data.length()
  let n_features = if n_samples > 0 { data[0].length() } else { 0 }
  let mut max_label = 0
  for l in labels { if l > max_label { max_label = l } }
  let n_classes = max_label + 1
  let mut missing = 0.0
  let mut total = 0.0
  for row in data {
    for v in row {
      total = total + 1.0
      if abs_(v) < 0.0000001 { missing = missing + 1.0 }
    }
  }
  let missing_ratio = if total > 0.0 { missing / total } else { 0.0 }
  let feature_types : Array[String] = Array::make(n_features, "numeric")
  { n_samples, n_features, n_classes, feature_types, missing_ratio, imbalance_ratio: 1.0 }
}

/// 数据感知推荐 / Data aware recommendation.
pub fn data_aware_recommend(
  data : DataAware,
  space : ModelSearchSpace
) -> Array[String] {
  let recs : Array[String] = []
  if data.n_samples < 1000 {
    if space.classifiers.length() > 0 { recs.push(space.classifiers[0]) }
  } else if data.n_samples < 100000 {
    if space.classifiers.length() > 1 { recs.push(space.classifiers[1]) }
  } else {
    if space.classifiers.length() > 2 { recs.push(space.classifiers[2]) }
  }
  if data.n_features > 100 {
    if space.preprocessing.length() > 0 { recs.push(space.preprocessing[0]) }
  }
  if data.missing_ratio > 0.1 {
    if space.preprocessing.length() > 1 { recs.push(space.preprocessing[1]) }
  }
  recs
}

/// 创建资源感知 / Create resource aware.
pub fn make_resource_aware(
  cpu_budget : Int,
  memory_budget : Int,
  gpu_count : Int,
  time_budget : Double
) -> ResourceAware {
  { cpu_budget, memory_budget, gpu_count, time_budget, allocated: [] }
}

/// 资源预算 / Resource budget.
pub fn resource_budget(resource : ResourceAware) -> Double {
  let cpu_w = resource.cpu_budget.to_double() * 1.0
  let mem_w = resource.memory_budget.to_double() * 0.001
  let gpu_w = resource.gpu_count.to_double() * 10.0
  cpu_w + mem_w + gpu_w + resource.time_budget
}

/// 资源分配 / Resource allocate.
pub fn resource_allocate(
  resource : ResourceAware,
  models : Array[String]
) -> ResourceAware {
  let n = models.length()
  if n == 0 { return resource }
  let cpu_per = resource.cpu_budget / n
  let alloc : Array[(String, Int)] = []
  for i in 0..<n { alloc.push((models[i], cpu_per)) }
  { ..resource, allocated: alloc }
}

/// 创建时间感知 / Create time aware.
pub fn make_time_aware(
  total_budget : Double,
  per_model_estimate : Double
) -> TimeAware {
  { total_budget, elapsed: 0.0, per_model_estimate, remaining: total_budget }
}

/// 时间预算 / Time budget.
pub fn time_budget(time : TimeAware) -> Int {
  (time.remaining / (time.per_model_estimate + 0.0000001)).to_int()
}

/// 时间估计 / Time estimate.
pub fn time_estimate(
  time : TimeAware,
  n_models : Int
) -> Double {
  n_models.to_double() * time.per_model_estimate
}

/// 创建可解释 / Create interpretable.
pub fn make_interpretable(
  interpretability_score : Double,
  accuracy_score : Double,
  tradeoff_alpha : Double
) -> Interpretable {
  { interpretability_score, accuracy_score, tradeoff_alpha }
}

/// 可解释评分 / Interpret score.
pub fn interpret_score(interp : Interpretable) -> Double {
  interp.tradeoff_alpha * interp.accuracy_score + (1.0 - interp.tradeoff_alpha) * interp.interpretability_score
}

/// 可解释权衡 / Interpret tradeoff.
pub fn interpret_tradeoff(
  interp : Interpretable,
  alpha : Double
) -> Interpretable {
  { ..interp, tradeoff_alpha: alpha }
}

/// 创建稳健 AutoML / Create robust AutoML.
pub fn make_robust_automl(
  candidates : Array[ModelCandidate],
  noise_tolerance : Double,
  cv_folds : Int
) -> RobustAutoMl {
  let mut worst = 999999.0
  for c in candidates { if c.score < worst { worst = c.score } }
  { candidates, noise_tolerance, cv_folds, worst_case_score: worst }
}

/// 稳健评估 / Robust evaluate.
pub fn robust_evaluate(
  robust : RobustAutoMl,
  noise : Double
) -> Double {
  if robust.candidates.length() == 0 { return 0.0 }
  let mut sum = 0.0
  for c in robust.candidates {
    let penalized = c.score - noise * robust.noise_tolerance
    sum = sum + penalized
  }
  sum / robust.candidates.length().to_double()
}

/// 稳健选择 / Robust select.
pub fn robust_select(robust : RobustAutoMl) -> ModelCandidate {
  if robust.candidates.length() == 0 {
    return {
      name: "",
      model_type: "",
      params: [],
      score: -999999.0,
      fit_time: 0.0,
      predict_time: 0.0,
      complexity: 0,
    }
  }
  let mut best = robust.candidates[0]
  let mut best_worst = best.score - robust.noise_tolerance
  for i in 1..<robust.candidates.length() {
    let w = robust.candidates[i].score - robust.noise_tolerance
    if w > best_worst { best = robust.candidates[i]; best_worst = w }
  }
  best
}

/// AutoML 搜索 / AutoML search.
pub fn automl_search(
  config : AutoMlConfig,
  space : ModelSearchSpace,
  eval_fn : (String, Array[(String, Double)]) -> Double
) -> Array[ModelCandidate] {
  let models = if config.task_type == "classify" {
    search_classifiers(space, config.max_models)
  } else {
    search_regressors(space, config.max_models)
  }
  let candidates : Array[ModelCandidate] = []
  for i in 0..<models.length() {
    let params : Array[(String, Double)] = []
    let score = eval_fn(models[i], params)
    candidates.push({
      name: models[i],
      model_type: config.task_type,
      params,
      score,
      fit_time: 0.0,
      predict_time: 0.0,
      complexity: 0,
    })
  }
  candidates
}

/// AutoML 拟合 / AutoML fit.
pub fn automl_fit(
  config : AutoMlConfig,
  space : ModelSearchSpace,
  eval_fn : (String, Array[(String, Double)]) -> Double
) -> AutoMlReport {
  let candidates = automl_search(config, space, eval_fn)
  let sorted = sort_candidates_(candidates)
  let best = if sorted.length() > 0 { sorted[0] } else {
    {
      name: "",
      model_type: "",
      params: [],
      score: 0.0,
      fit_time: 0.0,
      predict_time: 0.0,
      complexity: 0,
    }
  }
  let leaderboard : Array[(String, Double)] = []
  for c in sorted { leaderboard.push((c.name, c.score)) }
  {
    best_model: best.name,
    best_score: best.score,
    n_models_tried: candidates.length(),
    total_time: 0.0,
    leaderboard,
    config,
  }
}

/// AutoML 预测 / AutoML predict.
pub fn automl_predict(
  report : AutoMlReport,
  predict_fn : (String, Array[Double]) -> Double,
  x : Array[Double]
) -> Double {
  predict_fn(report.best_model, x)
}

/// AutoML 报告生成 / AutoML report.
pub fn automl_report(report : AutoMlReport) -> String {
  let mut s = "AutoML Report\n"
  s = s + "Best Model: " + report.best_model + "\n"
  s = s + "Best Score: " + report.best_score.to_string() + "\n"
  s = s + "Models Tried: " + report.n_models_tried.to_string() + "\n"
  s = s + "Total Time: " + report.total_time.to_string() + "\n"
  s = s + "Leaderboard:\n"
  for lb in report.leaderboard {
    s = s + "  " + lb.0 + ": " + lb.1.to_string() + "\n"
  }
  s
}

/// AutoML 排行榜 / AutoML leaderboard.
pub fn automl_leaderboard(report : AutoMlReport) -> Array[(String, Double)] {
  report.leaderboard
}

/// AutoML 保存 / AutoML save.
pub fn automl_save(report : AutoMlReport) -> String {
  let mut s = "best_model:" + report.best_model + "\n"
  s = s + "best_score:" + report.best_score.to_string() + "\n"
  s = s + "n_models:" + report.n_models_tried.to_string() + "\n"
  s = s + "total_time:" + report.total_time.to_string() + "\n"
  for lb in report.leaderboard {
    s = s + "model," + lb.0 + "," + lb.1.to_string() + "\n"
  }
  s
}

/// 创建 AutoML 管道 / Create AutoML pipeline.
pub fn make_automl_pipeline(
  steps : Array[PipelineStep],
  pipeline_id : Int
) -> AutoMlPipeline {
  { pipeline_id, steps, score: 0.0, fitted: false }
}

/// 管道步骤 / Pipeline steps.
pub fn pipeline_steps(pipeline : AutoMlPipeline) -> Array[PipelineStep] {
  pipeline.steps
}

/// 管道优化 / Pipeline optimize.
pub fn pipeline_optimize(
  pipeline : AutoMlPipeline,
  eval_fn : (Array[PipelineStep]) -> Double,
  n_iters : Int
) -> AutoMlPipeline {
  let mut best = pipeline
  let mut best_score = eval_fn(pipeline.steps)
  for _ in 0..<n_iters {
    let score = eval_fn(pipeline.steps)
    if score > best_score { best_score = score; best = pipeline }
  }
  { ..best, score: best_score, fitted: true }
}

/// 创建朴素搜索 / Create naive search.
pub fn make_naive_search(
  space : ModelSearchSpace,
  max_models : Int
) -> Array[String] {
  let all : Array[String] = []
  for c in space.classifiers { all.push(c) }
  for r in space.regressors { all.push(r) }
  let n = if max_models < all.length() { max_models } else { all.length() }
  let result : Array[String] = []
  for i in 0..<n { result.push(all[i]) }
  result
}

/// 朴素枚举 / Naive enumerate.
pub fn naive_enumerate(
  models : Array[String],
  params_grid : Array[Array[(String, Double)]]
) -> Array[(String, Array[(String, Double)])] {
  let result : Array[(String, Array[(String, Double)])] = []
  for m in models {
    for params in params_grid {
      result.push((m, params))
    }
  }
  result
}

/// 朴素评估 / Naive evaluate.
pub fn naive_evaluate(
  candidates : Array[(String, Array[(String, Double)])],
  eval_fn : (String, Array[(String, Double)]) -> Double
) -> Array[ModelCandidate] {
  let result : Array[ModelCandidate] = []
  for i in 0..<candidates.length() {
    let name = candidates[i].0
    let params = candidates[i].1
    let score = eval_fn(name, params)
    result.push({
      name,
      model_type: "unknown",
      params,
      score,
      fit_time: 0.0,
      predict_time: 0.0,
      complexity: 0,
    })
  }
  result
}

/// 创建渐进搜索 / Create progressive search.
pub fn make_progressive_search(
  n_stages : Int,
  candidates_per_stage : Int,
  refine_factor : Double
) -> ProgressiveSearch {
  { stage: 0, n_stages, candidates_per_stage, refine_factor, current_best: -999999.0 }
}

/// 渐进细化 / Progressive refine.
pub fn progressive_refine(
  search : ProgressiveSearch,
  candidates : Array[ModelCandidate]
) -> ProgressiveSearch {
  let mut best = search.current_best
  for c in candidates { if c.score > best { best = c.score } }
  { ..search, stage: search.stage + 1, current_best: best }
}

/// 渐进停止 / Progressive stop.
pub fn progressive_stop(search : ProgressiveSearch) -> Bool {
  search.stage >= search.n_stages
}

/// AutoML 模块标识 / AutoML module id.
pub fn automl_id() -> String {
  "learncore/automl"
}