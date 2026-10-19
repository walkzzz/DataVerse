///|
/// # learncore/active_learning 主动学习 / Active Learning
///
/// 主动学习族：不确定性采样、边缘采样、熵采样、QBC、期望改进、核心集、EMC、停止准则、标注成本优化。
///
/// # Active Learning
///
/// Uncertainty, margin, entropy, QBC, expected improvement, coreset, EMC, stopping, annotation cost.

fn exp(x : Double) -> Double {
  if x > 20.0 {
    485165195.4
  } else if x < -20.0 {
    0.0
  } else {
    let mut result = 1.0
    let mut term = 1.0
    for i in 1..<50 {
      term = term * x / i.to_double()
      result = result + term
    }
    result
  }
}

fn log(x : Double) -> Double {
  if x <= 0.0 {
    -1000.0
  } else {
    let mut result = 0.0
    let term = (x - 1.0) / (x + 1.0)
    let t2 = term * term
    let mut pow = term
    for i in 0..<50 {
      result = result + pow / (2 * i + 1).to_double()
      pow = pow * t2
    }
    2.0 * result
  }
}

fn sqrt(x : Double) -> Double {
  if x <= 0.0 {
    0.0
  } else {
    let mut guess = x
    for _ in 0..<50 {
      guess = 0.5 * (guess + x / guess)
    }
    guess
  }
}


fn lcg_next(state : Int) -> Int {
  let a = 1103515245
  let c = 12345
  let m = 2147483647
  (a * state + c) % m
}

fn rand_double(seed : Int) -> Double {
  let s = lcg_next(seed)
  s.to_double() / 2147483647.0
}

fn vec_dist(a : Array[Double], b : Array[Double]) -> Double {
  let n = a.length()
  if n != b.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let diff = a[i] - b[i]
      sum = sum + diff * diff
    }
    sqrt(sum)
  }
}

/// 主动学习配置 / Active learning configuration.
pub struct ALConfig {
  n_initial : Int
  n_query : Int
  n_rounds : Int
  strategy : Int
} derive(Debug, Eq)

pub extend ALConfig with Eq::{equal, not_equal}
pub extend ALConfig with Debug::{to_repr}

/// 标注者 / Oracle.
pub struct Oracle {
  accuracy : Double
  cost_per_label : Double
  noise_level : Double
} derive(Debug, Eq)

pub extend Oracle with Eq::{equal, not_equal}
pub extend Oracle with Debug::{to_repr}

/// 查询策略 / Query strategy.
pub struct QueryStrategy {
  strategy_type : Int
  temperature : Double
  n_committee : Int
} derive(Debug, Eq)

pub extend QueryStrategy with Eq::{equal, not_equal}
pub extend QueryStrategy with Debug::{to_repr}

/// 已标注池 / Labeled pool.
pub struct LabeledPool {
  features : Array[Array[Double]]
  labels : Array[Int]
} derive(Debug, Eq)

pub extend LabeledPool with Eq::{equal, not_equal}
pub extend LabeledPool with Debug::{to_repr}

/// 未标注池 / Unlabeled pool.
pub struct UnlabeledPool {
  features : Array[Array[Double]]
  indices : Array[Int]
} derive(Debug, Eq)

pub extend UnlabeledPool with Eq::{equal, not_equal}
pub extend UnlabeledPool with Debug::{to_repr}

/// 停止准则 / Stop criterion.
pub struct StopCriterion {
  target_accuracy : Double
  max_budget : Int
  patience : Int
} derive(Debug, Eq)

pub extend StopCriterion with Eq::{equal, not_equal}
pub extend StopCriterion with Debug::{to_repr}

/// 标注成本 / Annotation cost.
pub struct AnnotationCost {
  per_label_cost : Double
  total_budget : Double
  spent : Double
} derive(Debug, Eq)

pub extend AnnotationCost with Eq::{equal, not_equal}
pub extend AnnotationCost with Debug::{to_repr}

/// 主动学习流水线 / AL pipeline.
pub struct ALPipeline {
  config : ALConfig
  strategy : QueryStrategy
  stop_criterion : StopCriterion
  round : Int
} derive(Debug, Eq)

pub extend ALPipeline with Eq::{equal, not_equal}
pub extend ALPipeline with Debug::{to_repr}

/// EMC 配置 / EMC configuration.
pub struct EMCConfig {
  n_samples : Int
  n_classes : Int
  gamma : Double
} derive(Debug, Eq)

pub extend EMCConfig with Eq::{equal, not_equal}
pub extend EMCConfig with Debug::{to_repr}

/// 构造主动学习配置 / Build AL config.
pub fn make_al_config(n_initial : Int, n_query : Int, n_rounds : Int, strategy : Int) -> ALConfig {
  { n_initial, n_query, n_rounds, strategy }
}

/// 构造标注者 / Build oracle.
pub fn make_oracle(accuracy : Double, cost_per_label : Double, noise_level : Double) -> Oracle {
  { accuracy, cost_per_label, noise_level }
}

/// 构造查询策略 / Build query strategy.
pub fn make_query_strategy(strategy_type : Int, temperature : Double, n_committee : Int) -> QueryStrategy {
  { strategy_type, temperature, n_committee }
}

/// 不确定性采样 / Uncertainty sampling.
pub fn query_uncertainty(probs : Array[Double]) -> Double {
  let n = probs.length()
  if n == 0 {
    0.0
  } else {
    let mut max_p = probs[0]
    for i in 1..<n {
      if probs[i] > max_p {
        max_p = probs[i]
      }
    }
    1.0 - max_p
  }
}

/// 边缘采样 / Margin sampling.
pub fn query_margin(probs : Array[Double]) -> Double {
  let n = probs.length()
  if n < 2 {
    0.0
  } else {
    let mut max1 = probs[0]
    let mut max2 = probs[1]
    if max2 > max1 {
      let tmp = max1
      max1 = max2
      max2 = tmp
    }
    for i in 2..<n {
      if probs[i] > max1 {
        max2 = max1
        max1 = probs[i]
      } else if probs[i] > max2 {
        max2 = probs[i]
      }
    }
    max1 - max2
  }
}

/// 熵采样 / Entropy sampling.
pub fn query_entropy(probs : Array[Double]) -> Double {
  let n = probs.length()
  let mut entropy = 0.0
  for i in 0..<n {
    if probs[i] > 0.0 {
      entropy = entropy - probs[i] * log(probs[i])
    }
  }
  entropy
}

/// 随机采样 / Random sampling.
pub fn query_random(n_unlabeled : Int, seed : Int) -> Int {
  if n_unlabeled <= 0 {
    0
  } else {
    let s = lcg_next(seed)
    (rand_double(s) * n_unlabeled.to_double()).to_int()
  }
}

/// 多样性采样 / Diversity sampling.
pub fn query_diversity(feature : Array[Double], centers : Array[Array[Double]]) -> Double {
  let n = centers.length()
  if n == 0 {
    0.0
  } else {
    let mut min_dist = 999999.0
    for i in 0..<n {
      let d = vec_dist(feature, centers[i])
      if d < min_dist {
        min_dist = d
      }
    }
    min_dist
  }
}


/// 密度采样 / Density sampling.
pub fn query_density(feature : Array[Double], all_features : Array[Array[Double]], bandwidth : Double) -> Double {
  let n = all_features.length()
  if n == 0 || bandwidth <= 0.0 {
    0.0
  } else {
    let mut density = 0.0
    for i in 0..<n {
      let d = vec_dist(feature, all_features[i])
      let u = d / bandwidth
      density = density + exp(-0.5 * u * u)
    }
    density / (n.to_double() * bandwidth)
  }
}

/// QBC 查询 / Query by committee.
pub fn query_qbc(committee_probs : Array[Array[Double]]) -> Double {
  let n = committee_probs.length()
  if n == 0 {
    0.0
  } else {
    let n_classes = committee_probs[0].length()
    let mut disagreement = 0.0
    for j in 0..<n_classes {
      let mut mean = 0.0
      for i in 0..<n {
        if j < committee_probs[i].length() {
          mean = mean + committee_probs[i][j]
        }
      }
      mean = mean / n.to_double()
      let mut var_sum = 0.0
      for i in 0..<n {
        if j < committee_probs[i].length() {
          let d = committee_probs[i][j] - mean
          var_sum = var_sum + d * d
        }
      }
      disagreement = disagreement + var_sum / n.to_double()
    }
    disagreement
  }
}

/// Bagging 查询 / Bagging query.
pub fn query_bagging(features : Array[Array[Double]], n_models : Int, seed : Int) -> Array[Int] {
  let n = features.length()
  let result : Array[Int] = Array::make(n_models, 0)
  let mut s = seed
  for m in 0..<n_models {
    s = lcg_next(s)
    let idx = (rand_double(s) * n.to_double()).to_int()
    if idx >= 0 && idx < n {
      result[m] = idx
    }
  }
  result
}

/// 投票熵 / Vote entropy.
pub fn query_vote_entropy(votes : Array[Int], n_classes : Int) -> Double {
  let n = votes.length()
  if n == 0 || n_classes <= 0 {
    0.0
  } else {
    let counts : Array[Int] = Array::make(n_classes, 0)
    for i in 0..<n {
      if votes[i] >= 0 && votes[i] < n_classes {
        counts[votes[i]] = counts[votes[i]] + 1
      }
    }
    let mut entropy = 0.0
    for k in 0..<n_classes {
      if counts[k] > 0 {
        let p = counts[k].to_double() / n.to_double()
        entropy = entropy - p * log(p)
      }
    }
    entropy
  }
}

/// 期望改进 / Expected improvement.
pub fn query_expected_improvement(current_loss : Double, predicted_losses : Array[Double]) -> Double {
  let n = predicted_losses.length()
  if n == 0 {
    0.0
  } else {
    let mut sum_improvement = 0.0
    for i in 0..<n {
      if predicted_losses[i] < current_loss {
        sum_improvement = sum_improvement + (current_loss - predicted_losses[i])
      }
    }
    sum_improvement / n.to_double()
  }
}

/// 期望损失减少 / Expected reduction.
pub fn query_expected_reduction(current_loss : Double, predicted_losses : Array[Double], probs : Array[Double]) -> Double {
  let n = predicted_losses.length()
  if n != probs.length() || n == 0 {
    0.0
  } else {
    let mut expected_reduction = 0.0
    for i in 0..<n {
      if predicted_losses[i] < current_loss {
        expected_reduction = expected_reduction + probs[i] * (current_loss - predicted_losses[i])
      }
    }
    expected_reduction
  }
}

/// 核心集 / Coreset.
pub fn query_coreset(labeled_features : Array[Array[Double]], unlabeled_features : Array[Array[Double]]) -> Int {
  let n_u = unlabeled_features.length()
  let n_l = labeled_features.length()
  if n_u == 0 {
    -1
  } else if n_l == 0 {
    0
  } else {
    let mut best_idx = 0
    let mut best_dist = 0.0
    for u in 0..<n_u {
      let mut min_dist = 999999.0
      for l in 0..<n_l {
        let d = vec_dist(unlabeled_features[u], labeled_features[l])
        if d < min_dist {
          min_dist = d
        }
      }
      if min_dist > best_dist {
        best_dist = min_dist
        best_idx = u
      }
    }
    best_idx
  }
}

/// 贪心采样 / Greedy sampling.
pub fn query_greedy_sampling(unlabeled_features : Array[Array[Double]], k : Int) -> Array[Int] {
  let n = unlabeled_features.length()
  if n == 0 || k <= 0 {
    []
  } else {
    let selected : Array[Int] = []
    selected.push(0)
    while selected.length() < k && selected.length() < n {
      let mut best_idx = -1
      let mut best_dist = -1.0
      for u in 0..<n {
        let mut already = false
        for s in 0..<selected.length() {
          if selected[s] == u {
            already = true
          }
        }
        if !already {
          let mut min_dist = 999999.0
          for s in 0..<selected.length() {
            let d = vec_dist(unlabeled_features[u], unlabeled_features[selected[s]])
            if d < min_dist {
              min_dist = d
            }
          }
          if min_dist > best_dist {
            best_dist = min_dist
            best_idx = u
          }
        }
      }
      if best_idx >= 0 {
        selected.push(best_idx)
      } else {
        break
      }
    }
    selected
  }
}

/// 构造已标注池 / Build labeled pool.
pub fn make_labeled_pool() -> LabeledPool {
  { features: [], labels: [] }
}

/// 构造未标注池 / Build unlabeled pool.
pub fn make_unlabeled_pool(features : Array[Array[Double]]) -> UnlabeledPool {
  let n = features.length()
  let indices : Array[Int] = Array::make(n, 0)
  for i in 0..<n {
    indices[i] = i
  }
  { features, indices }
}

/// 添加已标注 / Add labeled.
pub fn add_labeled(pool : LabeledPool, feature : Array[Double], label : Int) -> LabeledPool {
  let new_features : Array[Array[Double]] = []
  for i in 0..<pool.features.length() {
    new_features.push(pool.features[i])
  }
  new_features.push(feature)
  let new_labels : Array[Int] = []
  for i in 0..<pool.labels.length() {
    new_labels.push(pool.labels[i])
  }
  new_labels.push(label)
  { features: new_features, labels: new_labels }
}

/// 添加未标注 / Add unlabeled.
pub fn add_unlabeled(pool : UnlabeledPool, feature : Array[Double]) -> UnlabeledPool {
  let new_features : Array[Array[Double]] = []
  for i in 0..<pool.features.length() {
    new_features.push(pool.features[i])
  }
  new_features.push(feature)
  let new_indices : Array[Int] = []
  for i in 0..<pool.indices.length() {
    new_indices.push(pool.indices[i])
  }
  new_indices.push(pool.indices.length())
  { features: new_features, indices: new_indices }
}

/// 移除未标注 / Remove unlabeled.
pub fn remove_unlabeled(pool : UnlabeledPool, idx : Int) -> UnlabeledPool {
  let n = pool.features.length()
  if idx < 0 || idx >= n {
    pool
  } else {
    let new_features : Array[Array[Double]] = []
    let new_indices : Array[Int] = []
    for i in 0..<n {
      if i != idx {
        new_features.push(pool.features[i])
        new_indices.push(pool.indices[i])
      }
    }
    { features: new_features, indices: new_indices }
  }
}

/// 获取已标注 / Get labeled.
pub fn get_labeled(pool : LabeledPool) -> (Array[Array[Double]], Array[Int]) {
  (pool.features, pool.labels)
}

/// 获取未标注 / Get unlabeled.
pub fn get_unlabeled(pool : UnlabeledPool) -> Array[Array[Double]] {
  pool.features
}

/// 主动学习训练 / AL train.
pub fn al_train(pool : LabeledPool, weights : Array[Double]) -> Array[Double] {
  let n = weights.length()
  let result : Array[Double] = Array::make(n, 0.0)
  let n_samples = pool.features.length()
  if n_samples == 0 {
    result
  } else {
    for j in 0..<n {
      let mut sum = 0.0
      for i in 0..<n_samples {
        if j < pool.features[i].length() {
          sum = sum + pool.features[i][j] * pool.labels[i].to_double()
        }
      }
      result[j] = sum / n_samples.to_double()
    }
    result
  }
}

/// 主动学习迭代 / AL iterate.
pub fn al_iterate(pool : LabeledPool, unlabeled : UnlabeledPool, strategy : QueryStrategy, n_query : Int) -> Array[Int] {
  let n_u = unlabeled.features.length()
  let pool_size = pool.features.length()
  let strat_weight = strategy.temperature
  if n_u == 0 || n_query <= 0 {
    []
  } else {
    let result : Array[Int] = []
    let scores : Array[Double] = Array::make(n_u, 0.0)
    for i in 0..<n_u {
      let feature = unlabeled.features[i]
      let mut score = 0.0
      for j in 0..<feature.length() {
        score = score + feature[j] * feature[j]
      }
      scores[i] = score + pool_size.to_double() * strat_weight * 0.0
    }
    for _ in 0..<n_query {
      if result.length() >= n_u {
        break
      }
      let mut best_idx = -1
      let mut best_score = -1.0
      for i in 0..<n_u {
        let mut already = false
        for s in 0..<result.length() {
          if result[s] == i {
            already = true
          }
        }
        if !already && scores[i] > best_score {
          best_score = scores[i]
          best_idx = i
        }
      }
      if best_idx >= 0 {
        result.push(best_idx)
      }
    }
    result
  }
}

/// 主动学习评估 / AL evaluate.
pub fn al_evaluate(params : Array[Double], test_features : Array[Array[Double]], test_labels : Array[Int]) -> Double {
  let n = test_features.length()
  if n == 0 || n != test_labels.length() {
    0.0
  } else {
    let mut correct = 0.0
    for i in 0..<n {
      let feature = test_features[i]
      let mut score = 0.0
      for j in 0..<feature.length() {
        if j < params.length() {
          score = score + feature[j] * params[j]
        }
      }
      let pred = if score > 0.0 { 1 } else { 0 }
      if pred == test_labels[i] {
        correct = correct + 1.0
      }
    }
    correct / n.to_double()
  }
}

/// 构造停止准则 / Build stop criterion.
pub fn make_stop_criterion(target_accuracy : Double, max_budget : Int, patience : Int) -> StopCriterion {
  { target_accuracy, max_budget, patience }
}

/// 准确率停止 / Stop by accuracy.
pub fn stop_accuracy(current_accuracy : Double, criterion : StopCriterion) -> Bool {
  current_accuracy >= criterion.target_accuracy
}

/// 预算停止 / Stop by budget.
pub fn stop_budget(spent : Int, criterion : StopCriterion) -> Bool {
  spent >= criterion.max_budget
}

/// 收敛停止 / Stop by convergence.
pub fn stop_convergence(accuracies : Array[Double], criterion : StopCriterion) -> Bool {
  let n = accuracies.length()
  if n <= criterion.patience {
    false
  } else {
    let recent = accuracies[n - 1]
    let old = accuracies[n - 1 - criterion.patience]
    abs_d(recent - old) < 0.001
  }
}

fn abs_d(x : Double) -> Double {
  if x < 0.0 { -x } else { x }
}

/// 构造标注成本 / Build annotation cost.
pub fn make_annotation_cost(per_label_cost : Double, total_budget : Double) -> AnnotationCost {
  { per_label_cost, total_budget, spent: 0.0 }
}

/// 估计成本 / Estimate cost.
pub fn estimate_cost(n_labels : Int, cost : AnnotationCost) -> Double {
  n_labels.to_double() * cost.per_label_cost
}

/// 优化预算 / Optimize budget.
pub fn optimize_budget(cost : AnnotationCost, accuracies : Array[Double], n_labels : Array[Int]) -> Int {
  let n = accuracies.length()
  if n == 0 || n != n_labels.length() {
    0
  } else {
    let mut best_idx = 0
    let mut best_ratio = 0.0
    for i in 0..<n {
      let c = n_labels[i].to_double() * cost.per_label_cost
      if c > 0.0 {
        let ratio = accuracies[i] / c
        if ratio > best_ratio {
          best_ratio = ratio
          best_idx = i
        }
      }
    }
    n_labels[best_idx]
  }
}

/// 构造主动学习流水线 / Build AL pipeline.
pub fn make_al_pipeline(config : ALConfig, strategy : QueryStrategy, stop_criterion : StopCriterion) -> ALPipeline {
  { config, strategy, stop_criterion, round: 0 }
}

/// 流水线步 / Pipeline step.
pub fn pipeline_step(pipeline : ALPipeline, pool : LabeledPool, unlabeled : UnlabeledPool) -> ALPipeline {
  let n_query = pipeline.config.n_query
  let _ = al_iterate(pool, unlabeled, pipeline.strategy, n_query)
  { config: pipeline.config, strategy: pipeline.strategy, stop_criterion: pipeline.stop_criterion, round: pipeline.round + 1 }
}

/// 流水线运行 / Pipeline run.
pub fn pipeline_run(pipeline : ALPipeline, pool : LabeledPool, unlabeled : UnlabeledPool) -> ALPipeline {
  let mut current = pipeline
  for _ in 0..<pipeline.config.n_rounds {
    if stop_accuracy(al_evaluate(al_train(pool, Array::make(1, 1.0)), [], []), pipeline.stop_criterion) {
      break
    }
    current = pipeline_step(current, pool, unlabeled)
  }
  current
}

/// 准确率曲线 / Accuracy curve.
pub fn al_accuracy_curve(accuracies : Array[Double]) -> Array[Double] {
  let n = accuracies.length()
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = accuracies[i]
  }
  result
}

/// 学习曲线 / Learning curve.
pub fn al_learning_curve(n_labels : Array[Int], accuracies : Array[Double]) -> Array[(Int, Double)] {
  let n = n_labels.length()
  if n != accuracies.length() {
    []
  } else {
    let result : Array[(Int, Double)] = []
    for i in 0..<n {
      result.push((n_labels[i], accuracies[i]))
    }
    result
  }
}

/// 构造 EMC / Build EMC config.
pub fn make_emc(n_samples : Int, n_classes : Int, gamma : Double) -> EMCConfig {
  { n_samples, n_classes, gamma }
}

/// EMC 估计 / EMC estimate.
pub fn emc_estimate(config : EMCConfig, probs : Array[Array[Double]]) -> Double {
  let n = probs.length()
  if n == 0 {
    0.0
  } else {
    let mut emc = 0.0
    for i in 0..<n {
      let p = probs[i]
      let mut max_p = 0.0
      for j in 0..<p.length() {
        if p[j] > max_p {
          max_p = p[j]
        }
      }
      emc = emc + (1.0 - max_p) * config.gamma
    }
    emc / n.to_double()
  }
}

/// EMC 最优 / EMC optimal.
pub fn emc_optimal(config : EMCConfig, probs : Array[Array[Double]], budget : Int) -> Int {
  let n = probs.length()
  if n == 0 || budget <= 0 {
    0
  } else {
    let scores : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let p = probs[i]
      let mut max_p = 0.0
      for j in 0..<p.length() {
        if p[j] > max_p {
          max_p = p[j]
        }
      }
      scores[i] = (1.0 - max_p) * config.gamma
    }
    let selected : Array[Int] = []
    for _ in 0..<budget {
      if selected.length() >= n {
        break
      }
      let mut best_idx = -1
      let mut best_score = -1.0
      for i in 0..<n {
        let mut already = false
        for s in 0..<selected.length() {
          if selected[s] == i {
            already = true
          }
        }
        if !already && scores[i] > best_score {
          best_score = scores[i]
          best_idx = i
        }
      }
      if best_idx >= 0 {
        selected.push(best_idx)
      }
    }
    selected.length()
  }
}

/// 主动学习 ID / Active learning id.
pub fn active_learning_id() -> String {
  "active_learning_v1"
}