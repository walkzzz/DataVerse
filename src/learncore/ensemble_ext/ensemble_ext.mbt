///|
/// # learncore/ensemble_ext 集成学习扩展 / Ensemble Extension
///
/// 集成学习扩展算子契约 + 简化实现。
/// Bagging / Boosting / Stacking / Voting / RandomForest / XGBoost / LightGBM / CatBoost。
///
/// # Ensemble extension operators

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// Bagging 配置 / Bagging config.
pub struct BaggingConfig {
  n_estimators : Int
  sample_ratio : Double
  with_replacement : Bool
} derive(Debug, Eq)

pub extend BaggingConfig with Eq::{equal, not_equal}
pub extend BaggingConfig with Debug::{to_repr}

/// Boosting 配置 / Boosting config.
pub struct BoostingConfig {
  n_estimators : Int
  learning_rate : Double
  loss : String
} derive(Debug, Eq)

pub extend BoostingConfig with Eq::{equal, not_equal}
pub extend BoostingConfig with Debug::{to_repr}

/// Stacking 配置 / Stacking config.
pub struct StackingConfig {
  base_models : Int
  meta_learner : String
  cv_folds : Int
} derive(Debug, Eq)

pub extend StackingConfig with Eq::{equal, not_equal}
pub extend StackingConfig with Debug::{to_repr}

/// Voting 配置 / Voting config.
pub struct VotingConfig {
  n_models : Int
  weights : Array[Double]
  voting_type : String
} derive(Debug, Eq)

pub extend VotingConfig with Eq::{equal, not_equal}
pub extend VotingConfig with Debug::{to_repr}

/// 随机森林配置 / Random forest config.
pub struct RandomForestConfig {
  n_estimators : Int
  max_depth : Int
  max_features : Int
} derive(Debug, Eq)

pub extend RandomForestConfig with Eq::{equal, not_equal}
pub extend RandomForestConfig with Debug::{to_repr}

/// 集成配置 / Ensemble config.
pub struct EnsembleConfig {
  name : String
  n_models : Int
  weights : Array[Double]
  method : String
} derive(Debug, Eq)

pub extend EnsembleConfig with Eq::{equal, not_equal}
pub extend EnsembleConfig with Debug::{to_repr}

/// 集成模型 / Ensemble model.
pub struct EnsembleModel {
  predictions : Array[Array[Double]]
  weights : Array[Double]
  labels : Array[Int]
} derive(Debug, Eq)

pub extend EnsembleModel with Eq::{equal, not_equal}
pub extend EnsembleModel with Debug::{to_repr}

/// AdaBoost 状态 / AdaBoost state.
pub struct AdaBoostState {
  weights : Array[Double]
  alphas : Array[Double]
  errors : Array[Double]
} derive(Debug, Eq)

pub extend AdaBoostState with Eq::{equal, not_equal}
pub extend AdaBoostState with Debug::{to_repr}

/// XGBoost 配置 / XGBoost config.
pub struct XGBoostConfig {
  n_estimators : Int
  learning_rate : Double
  max_depth : Int
  lambda : Double
} derive(Debug, Eq)

pub extend XGBoostConfig with Eq::{equal, not_equal}
pub extend XGBoostConfig with Debug::{to_repr}

// ============================================================
// 辅助数学函数 / Helper math functions
// ============================================================

fn exp_approx(x : Double) -> Double {
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

fn log_approx(x : Double) -> Double {
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

fn sqrt_approx(x : Double) -> Double {
  if x < 0.0 {
    return 0.0
  }
  if x == 0.0 {
    return 0.0
  }
  let mut guess = x / 2.0
  if guess == 0.0 {
    guess = 1.0
  }
  for _ in 0..<60 {
    guess = (guess + x / guess) / 2.0
  }
  guess
}

fn parse_int_simple(s : String) -> Int {
  let mut result = 0
  let mut negative = false
  let mut i = 0
  if s.length() > 0 && s[0].to_int() == 45 {
    negative = true
    i = 1
  }
  while i < s.length() {
    let c = s[i].to_int()
    if c >= 48 && c <= 57 {
      result = result * 10 + (c - 48)
    }
    i = i + 1
  }
  if negative { -result } else { result }
}

fn parse_double_simple(s : String) -> Double {
  let mut result = 0.0
  let mut negative = false
  let mut i = 0
  if s.length() > 0 && s[0].to_int() == 45 {
    negative = true
    i = 1
  }
  while i < s.length() {
    let c = s[i].to_int()
    if c >= 48 && c <= 57 {
      result = result * 10.0 + (c - 48).to_double()
    } else if c == 46 {
      i = i + 1
      let mut scale = 0.1
      while i < s.length() {
        let c2 = s[i].to_int()
        if c2 >= 48 && c2 <= 57 {
          result = result + (c2 - 48).to_double() * scale
          scale = scale * 0.1
        }
        i = i + 1
      }
      break
    }
    i = i + 1
  }
  if negative { -result } else { result }
}

// ============================================================
// Bagging
// ============================================================

/// 创建 Bagging 配置 / Make bagging config.
pub fn make_bagging(n_estimators : Int, sample_ratio : Double) -> BaggingConfig {
  BaggingConfig::{n_estimators, sample_ratio, with_replacement: true}
}

/// Bagging 训练 / Bagging train (returns ensemble of predictions).
pub fn bagging_train(
  data : Array[Double],
  labels : Array[Int],
  config : BaggingConfig
) -> EnsembleModel {
  let predictions : Array[Array[Double]] = []
  let weights : Array[Double] = []
  for m in 0..<config.n_estimators {
    let pred : Array[Double] = []
    for i in 0..<data.length() {
      let idx = (i + m * 7) % data.length()
      pred.push(data[idx])
    }
    predictions.push(pred)
    weights.push(1.0 / config.n_estimators.to_double())
  }
  EnsembleModel::{predictions, weights, labels}
}

/// Bagging 预测 / Bagging predict.
pub fn bagging_predict(model : EnsembleModel) -> Array[Double] {
  let n_models = model.predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = model.predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  for m in 0..<n_models {
    let w = if m < model.weights.length() { model.weights[m] } else { 1.0 / n_models.to_double() }
    for s in 0..<n_samples {
      if s < model.predictions[m].length() {
        result[s] = result[s] + w * model.predictions[m][s]
      }
    }
  }
  result
}

// ============================================================
// Boosting
// ============================================================

/// 创建 Boosting 配置 / Make boosting config.
pub fn make_boosting(n_estimators : Int, learning_rate : Double) -> BoostingConfig {
  BoostingConfig::{n_estimators, learning_rate, loss: "exponential"}
}

/// Boosting 训练 / Boosting train.
pub fn boosting_train(
  data : Array[Double],
  labels : Array[Int],
  config : BoostingConfig
) -> EnsembleModel {
  let n = data.length()
  let weights : Array[Double] = Array::make(n, 1.0 / n.to_double())
  let predictions : Array[Array[Double]] = []
  let model_weights : Array[Double] = []
  let current_pred : Array[Double] = Array::make(n, 0.0)
  for m in 0..<config.n_estimators {
    let pred : Array[Double] = []
    for i in 0..<n {
      pred.push(data[i] * 0.5 + labels[i].to_double() * 0.5)
    }
    predictions.push(pred)
    let mut err = 0.0
    for i in 0..<n {
      if pred[i] < 0.5 && labels[i] == 1 || pred[i] >= 0.5 && labels[i] == 0 {
        err = err + weights[i]
      }
    }
    let alpha = 0.5 * log_approx((1.0 - err) / (err + 0.0001))
    model_weights.push(alpha)
    for i in 0..<n {
      current_pred[i] = current_pred[i] + config.learning_rate * pred[i]
    }
  }
  EnsembleModel::{predictions, weights: model_weights, labels}
}

/// Boosting 预测 / Boosting predict.
pub fn boosting_predict(model : EnsembleModel) -> Array[Double] {
  let n_models = model.predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = model.predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  for m in 0..<n_models {
    let w = if m < model.weights.length() { model.weights[m] } else { 1.0 }
    for s in 0..<n_samples {
      if s < model.predictions[m].length() {
        result[s] = result[s] + w * model.predictions[m][s]
      }
    }
  }
  result
}

// ============================================================
// AdaBoost
// ============================================================

/// AdaBoost 单步 / AdaBoost step.
pub fn adaboost_step(
  weights : Array[Double],
  predictions : Array[Int],
  labels : Array[Int],
  learning_rate : Double
) -> AdaBoostState {
  let n = weights.length()
  let mut err = 0.0
  for i in 0..<n {
    if i < predictions.length() && i < labels.length() && predictions[i] != labels[i] {
      err = err + weights[i]
    }
  }
  let alpha = if err <= 0.0 || err >= 1.0 { 0.0 } else { learning_rate * log_approx((1.0 - err) / err) }
  let new_weights : Array[Double] = []
  let mut sum = 0.0
  for i in 0..<n {
    let incorrect = if i < predictions.length() && i < labels.length() && predictions[i] != labels[i] { 1.0 } else { 0.0 }
    let w = weights[i] * exp_approx(alpha * incorrect)
    new_weights.push(w)
    sum = sum + w
  }
  if sum > 0.0 {
    for i in 0..<n {
      new_weights[i] = new_weights[i] / sum
    }
  }
  AdaBoostState::{weights: new_weights, alphas: [alpha], errors: [err]}
}

/// AdaBoost 权重 / AdaBoost weight.
pub fn adaboost_weight(
  base_weights : Array[Double],
  predictions : Array[Int],
  labels : Array[Int],
  alpha : Double
) -> Array[Double] {
  let n = base_weights.length()
  let result : Array[Double] = []
  let mut sum = 0.0
  for i in 0..<n {
    let incorrect = if i < predictions.length() && i < labels.length() && predictions[i] != labels[i] { 1.0 } else { 0.0 }
    let w = base_weights[i] * exp_approx(alpha * incorrect)
    result.push(w)
    sum = sum + w
  }
  if sum > 0.0 {
    for i in 0..<n {
      result[i] = result[i] / sum
    }
  }
  result
}

/// AdaBoost 预测 / AdaBoost predict.
pub fn adaboost_predict(
  base_predictions : Array[Array[Int]],
  alphas : Array[Double]
) -> Array[Int] {
  let n_models = base_predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = base_predictions[0].length()
  let result : Array[Int] = []
  for s in 0..<n_samples {
    let mut score = 0.0
    for m in 0..<n_models {
      let a = if m < alphas.length() { alphas[m] } else { 1.0 }
      let p = if s < base_predictions[m].length() { if base_predictions[m][s] == 1 { 1.0 } else { -1.0 } } else { 0.0 }
      score = score + a * p
    }
    result.push(if score > 0.0 { 1 } else { 0 })
  }
  result
}

// ============================================================
// Gradient Boosting
// ============================================================

/// 梯度提升单步 / Gradient boost step.
pub fn gradient_boost_step(
  current_predictions : Array[Double],
  residuals : Array[Double],
  learning_rate : Double
) -> Array[Double] {
  let n = current_predictions.length()
  let m = if n < residuals.length() { n } else { residuals.length() }
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    if i < m {
      result[i] = current_predictions[i] + learning_rate * residuals[i]
    } else {
      result[i] = current_predictions[i]
    }
  }
  result
}

/// 梯度提升预测 / Gradient boost predict.
pub fn gradient_boost_predict(
  base_predictions : Array[Array[Double]],
  learning_rates : Array[Double]
) -> Array[Double] {
  let n_models = base_predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = base_predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  for m in 0..<n_models {
    let lr = if m < learning_rates.length() { learning_rates[m] } else { 0.1 }
    for s in 0..<n_samples {
      if s < base_predictions[m].length() {
        result[s] = result[s] + lr * base_predictions[m][s]
      }
    }
  }
  result
}

// ============================================================
// Stacking
// ============================================================

/// 创建 Stacking 配置 / Make stacking config.
pub fn make_stacking(n_base_models : Int, meta_learner : String) -> StackingConfig {
  StackingConfig::{base_models: n_base_models, meta_learner, cv_folds: 5}
}

/// Stacking 预测 / Stacking predict.
pub fn stacking_predict(
  base_predictions : Array[Array[Double]],
  meta_weights : Array[Double]
) -> Array[Double] {
  let n_models = base_predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = base_predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  let mut bias = 0.0
  if meta_weights.length() > n_models {
    bias = meta_weights[n_models]
  }
  for s in 0..<n_samples {
    result[s] = bias
    for m in 0..<n_models {
      let w = if m < meta_weights.length() { meta_weights[m] } else { 0.0 }
      if s < base_predictions[m].length() {
        result[s] = result[s] + w * base_predictions[m][s]
      }
    }
  }
  result
}

/// 元学习器预测 / Meta learner predict.
pub fn meta_learner_predict(
  base_predictions : Array[Array[Double]],
  meta_weights : Array[Double],
  method : String
) -> Array[Double] {
  if method == "linear" {
    stacking_predict(base_predictions, meta_weights)
  } else {
    let n_models = base_predictions.length()
    if n_models == 0 {
      return []
    }
    let n_samples = base_predictions[0].length()
    let result : Array[Double] = Array::make(n_samples, 0.0)
    for m in 0..<n_models {
      for s in 0..<n_samples {
        if s < base_predictions[m].length() {
          result[s] = result[s] + base_predictions[m][s]
        }
      }
    }
    for s in 0..<n_samples {
      result[s] = result[s] / n_models.to_double()
    }
    result
  }
}

// ============================================================
// Voting
// ============================================================

/// 创建 Voting 配置 / Make voting config.
pub fn make_voting(n_models : Int, weights : Array[Double], voting_type : String) -> VotingConfig {
  VotingConfig::{n_models, weights, voting_type}
}

/// 硬投票 / Voting hard.
pub fn voting_hard(predictions : Array[Array[Int]]) -> Array[Int] {
  let n_models = predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = predictions[0].length()
  let result : Array[Int] = []
  for s in 0..<n_samples {
    let votes : Array[(Int, Int)] = []
    for m in 0..<n_models {
      if s < predictions[m].length() {
        let pred = predictions[m][s]
        let mut found = false
        for idx in 0..<votes.length() {
          if votes[idx].0 == pred {
            votes[idx] = (pred, votes[idx].1 + 1)
            found = true
          }
        }
        if not(found) {
          votes.push((pred, 1))
        }
      }
    }
    let mut best_label = 0
    let mut best_count = 0
    for idx in 0..<votes.length() {
      if votes[idx].1 > best_count {
        best_count = votes[idx].1
        best_label = votes[idx].0
      }
    }
    result.push(best_label)
  }
  result
}

/// 软投票 / Voting soft.
pub fn voting_soft(probabilities : Array[Array[Array[Double]]]) -> Array[Array[Double]] {
  let n_models = probabilities.length()
  if n_models == 0 {
    return []
  }
  let n_samples = probabilities[0].length()
  let result : Array[Array[Double]] = []
  for s in 0..<n_samples {
    let n_classes = if s < probabilities[0].length() { probabilities[0][s].length() } else { 0 }
    let avg : Array[Double] = Array::make(n_classes, 0.0)
    for m in 0..<n_models {
      if s < probabilities[m].length() {
        for c in 0..<n_classes {
          if c < probabilities[m][s].length() {
            avg[c] = avg[c] + probabilities[m][s][c]
          }
        }
      }
    }
    for c in 0..<n_classes {
      avg[c] = avg[c] / n_models.to_double()
    }
    result.push(avg)
  }
  result
}

// ============================================================
// Random Forest
// ============================================================

/// 创建随机森林配置 / Make random forest config.
pub fn make_random_forest(n_estimators : Int, max_depth : Int, max_features : Int) -> RandomForestConfig {
  RandomForestConfig::{n_estimators, max_depth, max_features}
}

/// 随机森林预测 / RF predict.
pub fn rf_predict(base_predictions : Array[Array[Double]]) -> Array[Double] {
  let n_models = base_predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = base_predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  for m in 0..<n_models {
    for s in 0..<n_samples {
      if s < base_predictions[m].length() {
        result[s] = result[s] + base_predictions[m][s]
      }
    }
  }
  for s in 0..<n_samples {
    result[s] = result[s] / n_models.to_double()
  }
  result
}

/// 随机森林特征重要性 / RF feature importance.
pub fn rf_feature_importance(importances : Array[Array[Double]]) -> Array[Double] {
  let n_models = importances.length()
  if n_models == 0 {
    return []
  }
  let n_features = importances[0].length()
  let result : Array[Double] = Array::make(n_features, 0.0)
  for m in 0..<n_models {
    for f in 0..<n_features {
      if f < importances[m].length() {
        result[f] = result[f] + importances[m][f]
      }
    }
  }
  for f in 0..<n_features {
    result[f] = result[f] / n_models.to_double()
  }
  result
}

// ============================================================
// Extra Trees
// ============================================================

/// 创建 Extra Trees 配置 / Make extra trees config.
pub fn make_extra_trees(n_estimators : Int, max_depth : Int) -> RandomForestConfig {
  RandomForestConfig::{n_estimators, max_depth, max_features: 0}
}

/// Extra Trees 预测 / Extra trees predict.
pub fn extra_trees_predict(base_predictions : Array[Array[Double]]) -> Array[Double] {
  rf_predict(base_predictions)
}

// ============================================================
// XGBoost / LightGBM / CatBoost (simplified)
// ============================================================

/// 创建 XGBoost 配置 / Make XGBoost config.
pub fn make_xgboost_simple(n_estimators : Int, learning_rate : Double) -> XGBoostConfig {
  XGBoostConfig::{n_estimators, learning_rate, max_depth: 6, lambda: 1.0}
}

/// XGBoost 预测 / XGBoost predict.
pub fn xgboost_predict(
  base_predictions : Array[Array[Double]],
  learning_rate : Double
) -> Array[Double] {
  let n_models = base_predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = base_predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  for m in 0..<n_models {
    for s in 0..<n_samples {
      if s < base_predictions[m].length() {
        result[s] = result[s] + learning_rate * base_predictions[m][s]
      }
    }
  }
  result
}

/// 创建 LightGBM 配置 / Make LightGBM config.
pub fn make_lightgbm_simple(n_estimators : Int, learning_rate : Double) -> XGBoostConfig {
  XGBoostConfig::{n_estimators, learning_rate, max_depth: -1, lambda: 0.0}
}

/// LightGBM 预测 / LightGBM predict.
pub fn lightgbm_predict(
  base_predictions : Array[Array[Double]],
  learning_rate : Double
) -> Array[Double] {
  xgboost_predict(base_predictions, learning_rate)
}

/// 创建 CatBoost 配置 / Make CatBoost config.
pub fn make_catboost_simple(n_estimators : Int, learning_rate : Double) -> XGBoostConfig {
  XGBoostConfig::{n_estimators, learning_rate, max_depth: 8, lambda: 3.0}
}

/// CatBoost 预测 / CatBoost predict.
pub fn catboost_predict(
  base_predictions : Array[Array[Double]],
  learning_rate : Double
) -> Array[Double] {
  xgboost_predict(base_predictions, learning_rate)
}

// ============================================================
// 集成诊断 / Ensemble diagnostics
// ============================================================

/// 集成多样性 / Ensemble diversity (average pairwise disagreement).
pub fn ensemble_diversity(predictions : Array[Array[Int]]) -> Double {
  let n_models = predictions.length()
  if n_models < 2 {
    return 0.0
  }
  let n_samples = predictions[0].length()
  let mut total_disagree = 0.0
  let mut count = 0.0
  for m1 in 0..<n_models {
    for m2 in (m1 + 1)..<n_models {
      let mut disagree = 0.0
      for s in 0..<n_samples {
        if s < predictions[m1].length() && s < predictions[m2].length() {
          if predictions[m1][s] != predictions[m2][s] {
            disagree = disagree + 1.0
          }
        }
      }
      if n_samples > 0 {
        total_disagree = total_disagree + disagree / n_samples.to_double()
      }
      count = count + 1.0
    }
  }
  if count > 0.0 {
    total_disagree / count
  } else {
    0.0
  }
}

/// 集成相关性 / Ensemble correlation (average pairwise correlation).
pub fn ensemble_correlation(predictions : Array[Array[Double]]) -> Double {
  let n_models = predictions.length()
  if n_models < 2 {
    return 1.0
  }
  let n_samples = predictions[0].length()
  let mut total_corr = 0.0
  let mut count = 0.0
  for m1 in 0..<n_models {
    for m2 in (m1 + 1)..<n_models {
      let mut sum1 = 0.0
      let mut sum2 = 0.0
      let mut sum12 = 0.0
      let mut sum11 = 0.0
      let mut sum22 = 0.0
      for s in 0..<n_samples {
        let p1 = if s < predictions[m1].length() { predictions[m1][s] } else { 0.0 }
        let p2 = if s < predictions[m2].length() { predictions[m2][s] } else { 0.0 }
        sum1 = sum1 + p1
        sum2 = sum2 + p2
        sum12 = sum12 + p1 * p2
        sum11 = sum11 + p1 * p1
        sum22 = sum22 + p2 * p2
      }
      let n_d = n_samples.to_double()
      let mean1 = sum1 / n_d
      let mean2 = sum2 / n_d
      let cov = sum12 / n_d - mean1 * mean2
      let var1 = sum11 / n_d - mean1 * mean1
      let var2 = sum22 / n_d - mean2 * mean2
      let denom = sqrt_approx(var1 * var2)
      if denom > 0.0 {
        total_corr = total_corr + cov / denom
      }
      count = count + 1.0
    }
  }
  if count > 0.0 {
    total_corr / count
  } else {
    1.0
  }
}

// ============================================================
// 加权集成 / Weighted ensemble
// ============================================================

/// 加权集成 / Weighted ensemble.
pub fn weighted_ensemble(
  predictions : Array[Array[Double]],
  weights : Array[Double]
) -> Array[Double] {
  let n_models = predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  let mut weight_sum = 0.0
  for m in 0..<n_models {
    let w = if m < weights.length() { weights[m] } else { 1.0 }
    weight_sum = weight_sum + w
  }
  if weight_sum == 0.0 {
    weight_sum = 1.0
  }
  for m in 0..<n_models {
    let w = if m < weights.length() { weights[m] } else { 1.0 }
    for s in 0..<n_samples {
      if s < predictions[m].length() {
        result[s] = result[s] + w * predictions[m][s]
      }
    }
  }
  for s in 0..<n_samples {
    result[s] = result[s] / weight_sum
  }
  result
}

/// 优化权重 / Optimize weights (simple grid search).
pub fn optimize_weights(
  predictions : Array[Array[Double]],
  labels : Array[Double]
) -> Array[Double] {
  let n_models = predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = predictions[0].length()
  let best_weights : Array[Double] = Array::make(n_models, 1.0 / n_models.to_double())
  let mut best_error = 999999999.0
  let steps = 10
  for m in 0..<n_models {
    for s in 0..<(steps + 1) {
      let w = s.to_double() / steps.to_double()
      let test_weights : Array[Double] = Array::make(n_models, 0.0)
      test_weights[m] = w
      let mut sum_w = 0.0
      for k in 0..<n_models {
        sum_w = sum_w + test_weights[k]
      }
      if sum_w == 0.0 {
        sum_w = 1.0
      }
      let mut error = 0.0
      for i in 0..<n_samples {
        let mut pred = 0.0
        for k in 0..<n_models {
          if i < predictions[k].length() {
            pred = pred + test_weights[k] * predictions[k][i]
          }
        }
        pred = pred / sum_w
        let diff = if i < labels.length() { pred - labels[i] } else { pred }
        error = error + diff * diff
      }
      if error < best_error {
        best_error = error
        best_weights[m] = w
      }
    }
  }
  let mut sum_w = 0.0
  for k in 0..<n_models {
    sum_w = sum_w + best_weights[k]
  }
  if sum_w > 0.0 {
    for k in 0..<n_models {
      best_weights[k] = best_weights[k] / sum_w
    }
  }
  best_weights
}

// ============================================================
// 集成配置 / Ensemble config
// ============================================================

/// 创建集成配置 / Make ensemble config.
pub fn make_ensemble_config(
  name : String,
  n_models : Int,
  weights : Array[Double],
  method : String
) -> EnsembleConfig {
  EnsembleConfig::{name, n_models, weights, method}
}

/// 验证集成配置 / Ensemble validate.
pub fn ensemble_validate(config : EnsembleConfig) -> Bool {
  if config.n_models <= 0 {
    return false
  }
  if config.weights.length() != config.n_models {
    return false
  }
  let mut sum = 0.0
  for i in 0..<config.weights.length() {
    if config.weights[i] < 0.0 {
      return false
    }
    sum = sum + config.weights[i]
  }
  sum > 0.0
}

// ============================================================
// OOB (Out-of-Bag)
// ============================================================

/// OOB 得分 / OOB score.
pub fn oob_score(
  oob_predictions : Array[Double],
  labels : Array[Int]
) -> Double {
  let n = oob_predictions.length()
  if n == 0 {
    return 0.0
  }
  let mut correct = 0.0
  for i in 0..<n {
    if i < labels.length() {
      let pred = if oob_predictions[i] > 0.5 { 1 } else { 0 }
      if pred == labels[i] {
        correct = correct + 1.0
      }
    }
  }
  correct / n.to_double()
}

/// OOB 预测 / OOB prediction.
pub fn oob_prediction(
  base_predictions : Array[Array[Double]],
  oob_mask : Array[Array[Bool]]
) -> Array[Double] {
  let n_models = base_predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = base_predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  let counts : Array[Int] = Array::make(n_samples, 0)
  for m in 0..<n_models {
    for s in 0..<n_samples {
      if s < oob_mask[m].length() && oob_mask[m][s] && s < base_predictions[m].length() {
        result[s] = result[s] + base_predictions[m][s]
        counts[s] = counts[s] + 1
      }
    }
  }
  for s in 0..<n_samples {
    if counts[s] > 0 {
      result[s] = result[s] / counts[s].to_double()
    }
  }
  result
}

// ============================================================
// 集成保存/加载/摘要 / Ensemble save/load/summary
// ============================================================

/// 集成保存 / Ensemble save (to string).
pub fn ensemble_save(model : EnsembleModel) -> String {
  let mut result = model.labels.length().to_string() + ";"
  for i in 0..<model.labels.length() {
    result = result + model.labels[i].to_string()
    if i < model.labels.length() - 1 {
      result = result + ","
    }
  }
  result = result + ";" + model.weights.length().to_string() + ";"
  for i in 0..<model.weights.length() {
    result = result + model.weights[i].to_string()
    if i < model.weights.length() - 1 {
      result = result + ","
    }
  }
  result
}

/// 集成加载 / Ensemble load (from string, simplified).
pub fn ensemble_load(s : String) -> EnsembleModel {
  let predictions : Array[Array[Double]] = []
  let weights : Array[Double] = []
  let labels : Array[Int] = []
  let parts : Array[String] = []
  let mut current = ""
  for i in 0..<s.length() {
    let c = s[i].to_int()
    if c == 59 {
      parts.push(current)
      current = ""
    } else {
      current = current + String::from_array([Char::from_int(c)])
    }
  }
  parts.push(current)
  if parts.length() >= 4 {
    let n_labels = parse_int_simple(parts[0])
    let label_str = parts[1]
    let mut num = 0
    for i in 0..<label_str.length() {
      let c = label_str[i].to_int()
      if c >= 48 && c <= 57 {
        num = num * 10 + (c - 48)
      } else if c == 44 {
        labels.push(num)
        num = 0
      }
    }
    if n_labels > 0 {
      labels.push(num)
    }
    let weight_str = parts[3]
    let mut wnum = ""
    for i in 0..<weight_str.length() {
      let c = weight_str[i].to_int()
      if c == 44 {
        weights.push(parse_double_simple(wnum))
        wnum = ""
      } else {
        wnum = wnum + String::from_array([Char::from_int(c)])
      }
    }
    if weight_str.length() > 0 {
      weights.push(parse_double_simple(wnum))
    }
  }
  EnsembleModel::{predictions, weights, labels}
}

/// 集成摘要 / Ensemble summary.
pub fn ensemble_summary(model : EnsembleModel) -> String {
  let n_models = model.predictions.length()
  let n_labels = model.labels.length()
  let n_weights = model.weights.length()
  "Ensemble: " + n_models.to_string() + " models, " + n_labels.to_string() + " labels, " + n_weights.to_string() + " weights"
}

// ============================================================
// 多分类集成 / Multiclass ensemble
// ============================================================

/// 创建多分类集成 / Make multiclass ensemble.
pub fn make_multiclass_ensemble(
  predictions : Array[Array[Array[Double]]],
  n_classes : Int
) -> Array[Array[Double]] {
  let n_models = predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = predictions[0].length()
  let result : Array[Array[Double]] = []
  for s in 0..<n_samples {
    let avg : Array[Double] = Array::make(n_classes, 0.0)
    for m in 0..<n_models {
      if s < predictions[m].length() {
        for c in 0..<n_classes {
          if c < predictions[m][s].length() {
            avg[c] = avg[c] + predictions[m][s][c]
          }
        }
      }
    }
    for c in 0..<n_classes {
      avg[c] = avg[c] / n_models.to_double()
    }
    result.push(avg)
  }
  result
}

/// 多分类投票 / Multiclass voting.
pub fn multiclass_voting(
  predictions : Array[Array[Int]],
  n_classes : Int
) -> Array[Int] {
  let n_models = predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = predictions[0].length()
  let result : Array[Int] = []
  for s in 0..<n_samples {
    let votes : Array[Int] = Array::make(n_classes, 0)
    for m in 0..<n_models {
      if s < predictions[m].length() && predictions[m][s] >= 0 && predictions[m][s] < n_classes {
        votes[predictions[m][s]] = votes[predictions[m][s]] + 1
      }
    }
    let mut best_class = 0
    let mut best_count = -1
    for c in 0..<n_classes {
      if votes[c] > best_count {
        best_count = votes[c]
        best_class = c
      }
    }
    result.push(best_class)
  }
  result
}

// ============================================================
// 特征选择与剪枝 / Feature selection & pruning
// ============================================================

/// 集成特征选择 / Ensemble feature selection.
pub fn ensemble_feature_selection(
  importances : Array[Array[Double]],
  threshold : Double
) -> Array[Int] {
  let avg = rf_feature_importance(importances)
  let selected : Array[Int] = []
  for f in 0..<avg.length() {
    if avg[f] >= threshold {
      selected.push(f)
    }
  }
  selected
}

/// 集成剪枝 / Ensemble prune (remove low-weight models).
pub fn ensemble_prune(
  model : EnsembleModel,
  threshold : Double
) -> EnsembleModel {
  let new_predictions : Array[Array[Double]] = []
  let new_weights : Array[Double] = []
  for m in 0..<model.predictions.length() {
    let w = if m < model.weights.length() { model.weights[m] } else { 0.0 }
    if w >= threshold {
      new_predictions.push(model.predictions[m])
      new_weights.push(w)
    }
  }
  EnsembleModel::{predictions: new_predictions, weights: new_weights, labels: model.labels}
}

// ============================================================
// ID
// ============================================================

/// 集成扩展算子 ID / Ensemble extension operator ID.
pub fn ensemble_ext_id() -> String {
  "learncore/ensemble_ext"
}