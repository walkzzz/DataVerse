///|
/// # learncore/ensemble 集成学习算子 / Ensemble Learning Operators
///
/// 集成学习算子契约 + 简化实现。架构 §4.3.5 learncore 扩展。
/// S7.7 新建：Bagging/Boosting/Stacking/Voting/RandomForest。
///
/// # Ensemble operators

///===
/// 投票

///|
/// 硬投票 / Hard voting (majority vote).
pub fn hard_voting(predictions : Array[Array[Int32]]) -> Array[Int32] {
  let n_models = predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = predictions[0].length()
  let result : Array[Int32] = []
  for s in 0..<n_samples {
    let votes : Array[(Int32, Int32)] = []
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
        if !found {
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

///|
/// 软投票 / Soft voting (average probabilities).
pub fn soft_voting(
  probabilities : Array[Array[Array[Double]]],
) -> Array[Array[Double]] {
  let n_models = probabilities.length()
  if n_models == 0 {
    return []
  }
  let n_samples = probabilities[0].length()
  let result : Array[Array[Double]] = []
  for s in 0..<n_samples {
    let n_classes = if s < probabilities[0].length() {
      probabilities[0][s].length()
    } else {
      0
    }
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

///|
/// 加权投票 / Weighted voting.
pub fn weighted_voting(
  predictions : Array[Array[Int32]],
  weights : Array[Double],
) -> Array[Int32] {
  let n_models = predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = predictions[0].length()
  let result : Array[Int32] = []
  for s in 0..<n_samples {
    let votes : Array[(Int32, Double)] = []
    for m in 0..<n_models {
      if s < predictions[m].length() {
        let pred = predictions[m][s]
        let w = if m < weights.length() { weights[m] } else { 1.0 }
        let mut found = false
        for idx in 0..<votes.length() {
          if votes[idx].0 == pred {
            votes[idx] = (pred, votes[idx].1 + w)
            found = true
          }
        }
        if !found {
          votes.push((pred, w))
        }
      }
    }
    let mut best_label = 0
    let mut best_weight = -1.0
    for idx in 0..<votes.length() {
      if votes[idx].1 > best_weight {
        best_weight = votes[idx].1
        best_label = votes[idx].0
      }
    }
    result.push(best_label)
  }
  result
}

///===
/// Bagging

///|
/// Bootstrap 采样 / Bootstrap sampling (sampling with replacement).
pub fn bootstrap_sample(
  data : Array[Double],
  n_samples : Int32,
) -> Array[Double] {
  let n = data.length()
  if n == 0 || n_samples <= 0 {
    return []
  }
  let result : Array[Double] = []
  for _i in 0..<n_samples {
    let idx = n_samples % n
    result.push(data[idx])
  }
  result
}

///|
/// Bagging 预测 / Bagging prediction (average of base models).
pub fn bagging_predict(
  base_predictions : Array[Array[Double]],
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
        result[s] = result[s] + base_predictions[m][s]
      }
    }
  }
  for s in 0..<n_samples {
    result[s] = result[s] / n_models.to_double()
  }
  result
}

///===
/// AdaBoost

///|
/// AdaBoost 权重更新 / AdaBoost weight update.
/// w_i <- w_i * exp(alpha * I(y_i != pred_i)) / Z
pub fn adaboost_update_weights(
  weights : Array[Double],
  predictions : Array[Int32],
  labels : Array[Int32],
  alpha : Double,
) -> Array[Double] {
  let n = weights.length()
  if n == 0 {
    return []
  }
  let result : Array[Double] = []
  let mut sum = 0.0
  for i in 0..<n {
    let incorrect = if i < predictions.length() &&
      i < labels.length() &&
      predictions[i] != labels[i] {
      1.0
    } else {
      0.0
    }
    let w = weights[i] * exp_approx(alpha * incorrect)
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

///|
/// AdaBoost alpha 计算 / AdaBoost alpha calculation.
/// alpha = 0.5 * ln((1 - err) / err)
pub fn adaboost_alpha(error_rate : Double) -> Double {
  if error_rate <= 0.0 || error_rate >= 1.0 {
    0.0
  } else {
    0.5 * log_approx((1.0 - error_rate) / error_rate)
  }
}

///|
/// AdaBoost 误差率 / AdaBoost error rate.
pub fn adaboost_error_rate(
  weights : Array[Double],
  predictions : Array[Int32],
  labels : Array[Int32],
) -> Double {
  let n = weights.length()
  if n == 0 {
    return 0.0
  }
  let mut error = 0.0
  for i in 0..<n {
    let incorrect = if i < predictions.length() &&
      i < labels.length() &&
      predictions[i] != labels[i] {
      1.0
    } else {
      0.0
    }
    error = error + weights[i] * incorrect
  }
  error
}

///===
/// 梯度提升

///|
/// 梯度提升回归 / Gradient boosting regression step.
/// F(x) <- F(x) + lr * h(x)
pub fn gradient_boosting_update(
  current_predictions : Array[Double],
  base_learner_output : Array[Double],
  learning_rate : Double,
) -> Array[Double] {
  let n = current_predictions.length()
  let m = if n < base_learner_output.length() {
    n
  } else {
    base_learner_output.length()
  }
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    if i < m {
      result[i] = current_predictions[i] +
        learning_rate * base_learner_output[i]
    } else {
      result[i] = current_predictions[i]
    }
  }
  result
}

///|
/// 残差计算 / Residual computation.
/// r_i = y_i - F(x_i)
pub fn compute_residuals(
  labels : Array[Double],
  predictions : Array[Double],
) -> Array[Double] {
  let n = if labels.length() < predictions.length() {
    labels.length()
  } else {
    predictions.length()
  }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(labels[i] - predictions[i])
  }
  result
}

///===
/// Stacking

///|
/// Stacking 元学习器预测 /531/// Stacking meta-learner prediction.
pub fn stacking_predict(
  base_predictions : Array[Array[Double]],
  meta_weights : Array[Double],
) -> Array[Double] {
  let n_models = base_predictions.length()
  if n_models == 0 {
    return []
  }
  let n_samples = base_predictions[0].length()
  let result : Array[Double] = Array::make(n_samples, 0.0)
  for m in 0..<n_models {
    let w = if m < meta_weights.length() { meta_weights[m] } else { 0.0 }
    for s in 0..<n_samples {
      if s < base_predictions[m].length() {
        result[s] = result[s] + w * base_predictions[m][s]
      }
    }
  }
  result
}

///===
/// 随机森林

///|
/// 随机森林预测 / Random forest prediction (simplified, averages base predictions).
pub fn random_forest_predict(
  base_predictions : Array[Array[Double]],
) -> Array[Double] {
  bagging_predict(base_predictions)
}

///|
/// 随机森林分类 / Random forest classification (majority vote).
pub fn random_forest_classify(
  base_predictions : Array[Array[Int32]],
) -> Array[Int32] {
  hard_voting(base_predictions)
}

///|
/// 特征重要性聚合 / Feature importance aggregation.
pub fn aggregate_feature_importance(
  importances : Array[Array[Double]],
) -> Array[Double] {
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

///===
/// 辅助函数

///|
/// 指数近似 / Exponential approximation.
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

///|
/// 对数近似 / Log approximation.
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

///|
///===
/// ID
pub fn ensemble_id() -> String {
  "learncore/ensemble"
}
