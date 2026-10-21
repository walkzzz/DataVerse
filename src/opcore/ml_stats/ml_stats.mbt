///|
/// # opcore/ml_stats 机器学习统计 / ML Statistics
///
/// 特征工程 / 模型评估 / 交叉验证 / 重采样。
/// 对标 scikit-learn 机器学习工具集。
/// S12.10 新建：35+ pub fn 机器学习算子。
///
/// # Machine learning statistics
///
/// Feature engineering / Model evaluation / Cross-validation / Resampling.

// ============================================================
// 常量 / Constants
// ============================================================

const E_EULER : Double = 2.718281828459045

///|
const LARGE_DOUBLE : Double = 999999999999999.0

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 混淆矩阵 / Confusion matrix.
pub struct ConfusionMatrix {
  matrix : Array[Array[Int32]]
  num_classes : Int32
} derive(Debug, Eq)

///|
pub extend ConfusionMatrix with Eq::{equal, not_equal}

///|
pub extend ConfusionMatrix with Debug::{to_repr}

///|
/// ROC 曲线 / ROC curve result.
pub struct ROCCurve {
  fpr : Array[Double]
  tpr : Array[Double]
  thresholds : Array[Double]
} derive(Debug, Eq)

///|
pub extend ROCCurve with Eq::{equal, not_equal}

///|
pub extend ROCCurve with Debug::{to_repr}

///|
/// 交叉验证结果 / Cross-validation result.
pub struct CVResult {
  mean_score : Double
  std_score : Double
  scores : Array[Double]
} derive(Debug, Eq)

///|
pub extend CVResult with Eq::{equal, not_equal}

///|
pub extend CVResult with Debug::{to_repr}

// ============================================================
// 辅助数学函数 / Helper math functions
// ============================================================

///|
/// 平方根 / Square root.
pub fn sqrt_(x : Double) -> Double {
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

///|
fn abs_(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
/// 自然指数 / Natural exponential.
pub fn exp_(x : Double) -> Double {
  if x > 700.0 {
    return LARGE_DOUBLE
  }
  if x < -700.0 {
    return 0.0
  }
  let mut n = 0
  let mut y = x
  while y > 0.5 {
    y = y / 2.0
    n = n + 1
  }
  while y < -0.5 {
    y = y / 2.0
    n = n + 1
  }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<40 {
    term = term * y / i.to_double()
    result = result + term
    if abs_(term) < 0.0000000000000001 {
      break
    }
  }
  for _ in 0..<n {
    result = result * result
  }
  result
}

///|
/// 自然对数 / Natural logarithm.
pub fn ln_(x : Double) -> Double {
  if x <= 0.0 {
    return -LARGE_DOUBLE
  }
  if x == 1.0 {
    return 0.0
  }
  let mut m = 0
  let mut y = x
  while y > 2.0 {
    y = y / E_EULER
    m = m + 1
  }
  while y < 0.5 {
    y = y * E_EULER
    m = m - 1
  }
  let t = (y - 1.0) / (y + 1.0)
  let mut result = 0.0
  let mut t_pow = t
  for k in 0..<80 {
    let term = t_pow / (2 * k + 1).to_double()
    result = result + term
    t_pow = t_pow * t * t
    if abs_(term) < 0.0000000000000001 {
      break
    }
  }
  result * 2.0 + m.to_double()
}

///|
fn rng_(seed : Double) -> Double {
  let s = seed * 1103515245.0 + 12345.0
  s - (s / 2147483647.0).to_int().to_double() * 2147483647.0
}

///|
fn euclidean_dist(x : Array[Double], y : Array[Double]) -> Double {
  let n = x.length()
  let mut sum = 0.0
  for i in 0..<n {
    let d = x[i] - y[i]
    sum = sum + d * d
  }
  sqrt_(sum)
}

///|
fn pearson_corr(x : Array[Double], y : Array[Double]) -> Double {
  let n = x.length()
  if n == 0 || n != y.length() {
    return 0.0
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for i in 0..<n {
    sx = sx + x[i]
    sy = sy + y[i]
  }
  let mx = sx / n.to_double()
  let my = sy / n.to_double()
  let mut cov = 0.0
  let mut vx = 0.0
  let mut vy = 0.0
  for i in 0..<n {
    let dx = x[i] - mx
    let dy = y[i] - my
    cov = cov + dx * dy
    vx = vx + dx * dx
    vy = vy + dy * dy
  }
  let denom = sqrt_(vx * vy)
  if denom == 0.0 {
    0.0
  } else {
    cov / denom
  }
}

///|
/// 包标识 / Package identity.
pub fn ml_stats_id() -> String {
  "dataverse/opcore/ml_stats v0.1.0 (42 fn)"
}

// ============================================================
// 特征工程 / Feature engineering
// ============================================================

///|
/// L2 归一化 / L2 normalization.
pub fn normalize_feature(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 {
    return []
  }
  let mut sum_sq = 0.0
  for i in 0..<n {
    sum_sq = sum_sq + data[i] * data[i]
  }
  let norm = sqrt_(sum_sq)
  if norm == 0.0 {
    return Array::make(n, 0.0)
  }
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = data[i] / norm
  }
  result
}

///|
/// 标准化（Z-score）/ Standardization.
pub fn standardize_feature(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 {
    return []
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + data[i]
  }
  let mean = sum / n.to_double()
  let mut sq_sum = 0.0
  for i in 0..<n {
    let d = data[i] - mean
    sq_sum = sq_sum + d * d
  }
  let std = sqrt_(sq_sum / n.to_double())
  if std == 0.0 {
    return Array::make(n, 0.0)
  }
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = (data[i] - mean) / std
  }
  result
}

///|
/// Min-Max 缩放 / Min-Max scaling.
pub fn min_max_scale(
  data : Array[Double],
  min_val : Double,
  max_val : Double,
) -> Array[Double] {
  let n = data.length()
  if n == 0 {
    return []
  }
  let mut d_min = data[0]
  let mut d_max = data[0]
  for i in 1..<n {
    if data[i] < d_min {
      d_min = data[i]
    }
    if data[i] > d_max {
      d_max = data[i]
    }
  }
  let range = d_max - d_min
  let target_range = max_val - min_val
  let result = Array::make(n, 0.0)
  if range == 0.0 {
    for i in 0..<n {
      result[i] = min_val
    }
    return result
  }
  for i in 0..<n {
    result[i] = (data[i] - d_min) / range * target_range + min_val
  }
  result
}

///|
/// One-Hot 编码 / One-hot encoding.
pub fn encode_one_hot(
  labels : Array[Int32],
  num_classes : Int32,
) -> Array[Array[Double]] {
  let n = labels.length()
  let result : Array[Array[Double]] = []
  for _ in 0..<n {
    result.push(Array::make(num_classes, 0.0))
  }
  for i in 0..<n {
    if labels[i] >= 0 && labels[i] < num_classes {
      result[i][labels[i]] = 1.0
    }
  }
  result
}

///|
/// 标签编码 / Label encoding.
pub fn encode_label(labels : Array[String]) -> Array[Int32] {
  let n = labels.length()
  let unique : Array[String] = []
  for i in 0..<n {
    let mut found = false
    for j in 0..<unique.length() {
      if unique[j] == labels[i] {
        found = true
        break
      }
    }
    if !found {
      unique.push(labels[i])
    }
  }
  let result = Array::make(n, 0)
  for i in 0..<n {
    for j in 0..<unique.length() {
      if unique[j] == labels[i] {
        result[i] = j
        break
      }
    }
  }
  result
}

///|
/// 序数编码 / Ordinal encoding.
pub fn encode_ordinal(
  labels : Array[String],
  order : Array[String],
) -> Array[Int32] {
  let n = labels.length()
  let result = Array::make(n, -1)
  for i in 0..<n {
    for j in 0..<order.length() {
      if order[j] == labels[i] {
        result[i] = j
        break
      }
    }
  }
  result
}

///|
/// 分箱 / Binning by edges.
pub fn bin_feature(data : Array[Double], edges : Array[Double]) -> Array[Int32] {
  let n = data.length()
  let result = Array::make(n, 0)
  for i in 0..<n {
    let mut bin = 0
    for j in 0..<edges.length() {
      if data[i] >= edges[j] {
        bin = j + 1
      } else {
        break
      }
    }
    result[i] = bin
  }
  result
}

///|
/// 等宽离散化 / Equal-width discretization.
pub fn discretize(data : Array[Double], num_bins : Int32) -> Array[Int32] {
  let n = data.length()
  if n == 0 || num_bins <= 0 {
    return []
  }
  let mut d_min = data[0]
  let mut d_max = data[0]
  for i in 1..<n {
    if data[i] < d_min {
      d_min = data[i]
    }
    if data[i] > d_max {
      d_max = data[i]
    }
  }
  let bin_width = (d_max - d_min) / num_bins.to_double()
  let result = Array::make(n, 0)
  if bin_width == 0.0 {
    return result
  }
  for i in 0..<n {
    let bin = ((data[i] - d_min) / bin_width).to_int()
    if bin >= num_bins {
      result[i] = num_bins - 1
    } else if bin < 0 {
      result[i] = 0
    } else {
      result[i] = bin
    }
  }
  result
}

///|
/// 多项式特征 / Polynomial features.
pub fn polynomial_features(
  data : Array[Double],
  degree : Int32,
) -> Array[Array[Double]] {
  let n = data.length()
  let result : Array[Array[Double]] = []
  for _ in 0..<n {
    result.push(Array::make(degree + 1, 0.0))
  }
  for i in 0..<n {
    let mut p = 1.0
    result[i][0] = 1.0
    for d in 1..<=degree {
      p = p * data[i]
      result[i][d] = p
    }
  }
  result
}

///|
/// 特征重要性 / Feature importance.
pub fn feature_importance(weights : Array[Double]) -> Array[Double] {
  let n = weights.length()
  if n == 0 {
    return []
  }
  let mut sum_abs = 0.0
  for i in 0..<n {
    sum_abs = sum_abs + abs_(weights[i])
  }
  let result = Array::make(n, 0.0)
  if sum_abs == 0.0 {
    return result
  }
  for i in 0..<n {
    result[i] = abs_(weights[i]) / sum_abs
  }
  result
}

///|
/// 特征选择 / Feature selection by threshold.
pub fn feature_selection(
  scores : Array[Double],
  threshold : Double,
) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<scores.length() {
    if scores[i] >= threshold {
      result.push(i)
    }
  }
  result
}

///|
/// 移除相关特征 / Remove correlated features.
pub fn remove_correlated(
  features : Array[Array[Double]],
  threshold : Double,
) -> Array[Int32] {
  let n = features.length()
  if n == 0 {
    return []
  }
  let selected : Array[Int32] = [0]
  for i in 1..<n {
    let mut keep = true
    for j in 0..<selected.length() {
      let corr = pearson_corr(features[i], features[selected[j]])
      if abs_(corr) > threshold {
        keep = false
        break
      }
    }
    if keep {
      selected.push(i)
    }
  }
  selected
}

// ============================================================
// 模型评估 / Model evaluation
// ============================================================

///|
/// 准确率 / Accuracy.
pub fn accuracy(y_true : Array[Int32], y_pred : Array[Int32]) -> Double {
  let n = y_true.length()
  if n == 0 || n != y_pred.length() {
    return 0.0
  }
  let mut correct = 0
  for i in 0..<n {
    if y_true[i] == y_pred[i] {
      correct = correct + 1
    }
  }
  correct.to_double() / n.to_double()
}

///|
/// 精确率 / Precision.
pub fn precision(
  y_true : Array[Int32],
  y_pred : Array[Int32],
  positive : Int32,
) -> Double {
  let n = y_true.length()
  if n == 0 || n != y_pred.length() {
    return 0.0
  }
  let mut tp = 0
  let mut fp = 0
  for i in 0..<n {
    if y_pred[i] == positive {
      if y_true[i] == positive {
        tp = tp + 1
      } else {
        fp = fp + 1
      }
    }
  }
  let denom = tp + fp
  if denom == 0 {
    0.0
  } else {
    tp.to_double() / denom.to_double()
  }
}

///|
/// 召回率 / Recall.
pub fn recall(
  y_true : Array[Int32],
  y_pred : Array[Int32],
  positive : Int32,
) -> Double {
  let n = y_true.length()
  if n == 0 || n != y_pred.length() {
    return 0.0
  }
  let mut tp = 0
  let mut fn_ = 0
  for i in 0..<n {
    if y_true[i] == positive {
      if y_pred[i] == positive {
        tp = tp + 1
      } else {
        fn_ = fn_ + 1
      }
    }
  }
  let denom = tp + fn_
  if denom == 0 {
    0.0
  } else {
    tp.to_double() / denom.to_double()
  }
}

///|
/// F1 分数 / F1 score.
pub fn f1_score_ml(
  y_true : Array[Int32],
  y_pred : Array[Int32],
  positive : Int32,
) -> Double {
  let p = precision(y_true, y_pred, positive)
  let r = recall(y_true, y_pred, positive)
  let sum = p + r
  if sum == 0.0 {
    0.0
  } else {
    2.0 * p * r / sum
  }
}

///|
/// 混淆矩阵 / Confusion matrix.
pub fn confusion_matrix(
  y_true : Array[Int32],
  y_pred : Array[Int32],
  num_classes : Int32,
) -> ConfusionMatrix {
  let matrix : Array[Array[Int32]] = []
  for _ in 0..<num_classes {
    matrix.push(Array::make(num_classes, 0))
  }
  let n = y_true.length()
  for i in 0..<n {
    if y_true[i] >= 0 &&
      y_true[i] < num_classes &&
      y_pred[i] >= 0 &&
      y_pred[i] < num_classes {
      matrix[y_true[i]][y_pred[i]] = matrix[y_true[i]][y_pred[i]] + 1
    }
  }
  { matrix, num_classes, }
}

///|
/// ROC 曲线 / ROC curve.
pub fn roc_curve(y_true : Array[Int32], y_score : Array[Double]) -> ROCCurve {
  let n = y_true.length()
  let mut pos = 0
  let mut neg = 0
  for i in 0..<n {
    if y_true[i] == 1 {
      pos = pos + 1
    } else {
      neg = neg + 1
    }
  }
  let indices = Array::make(n, 0)
  for i in 0..<n {
    indices[i] = i
  }
  let mut i = 0
  while i < n {
    let mut j = i + 1
    while j < n {
      if y_score[indices[j]] > y_score[indices[i]] {
        let tmp = indices[i]
        indices[i] = indices[j]
        indices[j] = tmp
      }
      j = j + 1
    }
    i = i + 1
  }
  let fpr : Array[Double] = [0.0]
  let tpr : Array[Double] = [0.0]
  let thresholds : Array[Double] = [LARGE_DOUBLE]
  let mut tp = 0
  let mut fp = 0
  for k in 0..<n {
    if y_true[indices[k]] == 1 {
      tp = tp + 1
    } else {
      fp = fp + 1
    }
    let fpr_val = if neg == 0 { 0.0 } else { fp.to_double() / neg.to_double() }
    let tpr_val = if pos == 0 { 0.0 } else { tp.to_double() / pos.to_double() }
    fpr.push(fpr_val)
    tpr.push(tpr_val)
    thresholds.push(y_score[indices[k]])
  }
  { fpr, tpr, thresholds, }
}

///|
/// AUC 分数 / AUC score.
pub fn auc_score(y_true : Array[Int32], y_score : Array[Double]) -> Double {
  let roc = roc_curve(y_true, y_score)
  let n = roc.fpr.length()
  if n < 2 {
    return 0.0
  }
  let mut auc = 0.0
  for i in 1..<n {
    let dx = roc.fpr[i] - roc.fpr[i - 1]
    let dy = roc.tpr[i] + roc.tpr[i - 1]
    auc = auc + dx * dy / 2.0
  }
  auc
}

///|
/// 对数损失 / Log loss.
pub fn log_loss(y_true : Array[Int32], y_prob : Array[Double]) -> Double {
  let n = y_true.length()
  if n == 0 || n != y_prob.length() {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let p = y_prob[i]
    let p_clamped = if p < 0.0000001 {
      0.0000001
    } else if p > 0.9999999 {
      0.9999999
    } else {
      p
    }
    if y_true[i] == 1 {
      sum = sum + ln_(p_clamped)
    } else {
      sum = sum + ln_(1.0 - p_clamped)
    }
  }
  -sum / n.to_double()
}

///|
/// Hinge 损失 / Hinge loss.
pub fn hinge_loss(y_true : Array[Int32], y_pred : Array[Double]) -> Double {
  let n = y_true.length()
  if n == 0 || n != y_pred.length() {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let y = if y_true[i] == 1 { 1.0 } else { -1.0 }
    let m = 1.0 - y * y_pred[i]
    if m > 0.0 {
      sum = sum + m
    }
  }
  sum / n.to_double()
}

///|
/// KL 散度 / KL divergence.
pub fn kl_divergence(p : Array[Double], q : Array[Double]) -> Double {
  let n = p.length()
  if n == 0 || n != q.length() {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    if p[i] > 0.0 && q[i] > 0.0 {
      sum = sum + p[i] * (ln_(p[i]) - ln_(q[i]))
    }
  }
  sum
}

///|
/// 均方误差 / Mean squared error.
pub fn mean_squared_error(
  y_true : Array[Double],
  y_pred : Array[Double],
) -> Double {
  let n = y_true.length()
  if n == 0 || n != y_pred.length() {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    let d = y_true[i] - y_pred[i]
    sum = sum + d * d
  }
  sum / n.to_double()
}

///|
/// 平均绝对误差 / Mean absolute error.
pub fn mean_absolute_error(
  y_true : Array[Double],
  y_pred : Array[Double],
) -> Double {
  let n = y_true.length()
  if n == 0 || n != y_pred.length() {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + abs_(y_true[i] - y_pred[i])
  }
  sum / n.to_double()
}

///|
/// R2 分数 / R2 score.
pub fn r2_score(y_true : Array[Double], y_pred : Array[Double]) -> Double {
  let n = y_true.length()
  if n == 0 || n != y_pred.length() {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + y_true[i]
  }
  let mean = sum / n.to_double()
  let mut ss_res = 0.0
  let mut ss_tot = 0.0
  for i in 0..<n {
    let res = y_true[i] - y_pred[i]
    let tot = y_true[i] - mean
    ss_res = ss_res + res * res
    ss_tot = ss_tot + tot * tot
  }
  if ss_tot == 0.0 {
    0.0
  } else {
    1.0 - ss_res / ss_tot
  }
}

///|
/// 轮廓系数 / Silhouette score.
pub fn silhouette_score(
  data : Array[Array[Double]],
  labels : Array[Int32],
) -> Double {
  let n = data.length()
  if n == 0 || n != labels.length() {
    return 0.0
  }
  let mut total = 0.0
  for i in 0..<n {
    let mut a_sum = 0.0
    let mut a_count = 0
    let mut b_sum = 0.0
    let mut b_count = 0
    for j in 0..<n {
      if i != j {
        let d = euclidean_dist(data[i], data[j])
        if labels[j] == labels[i] {
          a_sum = a_sum + d
          a_count = a_count + 1
        } else {
          b_sum = b_sum + d
          b_count = b_count + 1
        }
      }
    }
    let a = if a_count == 0 { 0.0 } else { a_sum / a_count.to_double() }
    let b = if b_count == 0 { 0.0 } else { b_sum / b_count.to_double() }
    let max_ab = if a > b { a } else { b }
    let s = if max_ab == 0.0 { 0.0 } else { (b - a) / max_ab }
    total = total + s
  }
  total / n.to_double()
}

///|
/// Davies-Bouldin 指数 / Davies-Bouldin index.
pub fn davies_bouldin_score(
  data : Array[Array[Double]],
  labels : Array[Int32],
) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let dim = data[0].length()
  let mut max_label = 0
  for i in 0..<n {
    if labels[i] > max_label {
      max_label = labels[i]
    }
  }
  let k = max_label + 1
  if k <= 1 {
    return 0.0
  }
  let centroids : Array[Array[Double]] = []
  for _ in 0..<k {
    centroids.push(Array::make(dim, 0.0))
  }
  let counts = Array::make(k, 0)
  for i in 0..<n {
    counts[labels[i]] = counts[labels[i]] + 1
    for d in 0..<dim {
      centroids[labels[i]][d] = centroids[labels[i]][d] + data[i][d]
    }
  }
  for c in 0..<k {
    if counts[c] > 0 {
      for d in 0..<dim {
        centroids[c][d] = centroids[c][d] / counts[c].to_double()
      }
    }
  }
  let scatter = Array::make(k, 0.0)
  for i in 0..<n {
    let d = euclidean_dist(data[i], centroids[labels[i]])
    scatter[labels[i]] = scatter[labels[i]] + d
  }
  for c in 0..<k {
    if counts[c] > 0 {
      scatter[c] = scatter[c] / counts[c].to_double()
    }
  }
  let mut total = 0.0
  for i in 0..<k {
    let mut max_r = 0.0
    for j in 0..<k {
      if i != j {
        let dist = euclidean_dist(centroids[i], centroids[j])
        if dist > 0.0 {
          let r = (scatter[i] + scatter[j]) / dist
          if r > max_r {
            max_r = r
          }
        }
      }
    }
    total = total + max_r
  }
  total / k.to_double()
}

///|
/// Calinski-Harabasz 指数 / Calinski-Harabasz index.
pub fn calinski_harabasz_score(
  data : Array[Array[Double]],
  labels : Array[Int32],
) -> Double {
  let n = data.length()
  if n == 0 {
    return 0.0
  }
  let dim = data[0].length()
  let mut max_label = 0
  for i in 0..<n {
    if labels[i] > max_label {
      max_label = labels[i]
    }
  }
  let k = max_label + 1
  if k <= 1 || k >= n {
    return 0.0
  }
  let global_centroid = Array::make(dim, 0.0)
  for i in 0..<n {
    for d in 0..<dim {
      global_centroid[d] = global_centroid[d] + data[i][d]
    }
  }
  for d in 0..<dim {
    global_centroid[d] = global_centroid[d] / n.to_double()
  }
  let centroids : Array[Array[Double]] = []
  for _ in 0..<k {
    centroids.push(Array::make(dim, 0.0))
  }
  let counts = Array::make(k, 0)
  for i in 0..<n {
    counts[labels[i]] = counts[labels[i]] + 1
    for d in 0..<dim {
      centroids[labels[i]][d] = centroids[labels[i]][d] + data[i][d]
    }
  }
  for c in 0..<k {
    if counts[c] > 0 {
      for d in 0..<dim {
        centroids[c][d] = centroids[c][d] / counts[c].to_double()
      }
    }
  }
  let mut ss_b = 0.0
  for c in 0..<k {
    let d = euclidean_dist(centroids[c], global_centroid)
    ss_b = ss_b + counts[c].to_double() * d * d
  }
  let mut ss_w = 0.0
  for i in 0..<n {
    let d = euclidean_dist(data[i], centroids[labels[i]])
    ss_w = ss_w + d * d
  }
  if ss_w == 0.0 {
    0.0
  } else {
    ss_b / (k - 1).to_double() / (ss_w / (n - k).to_double())
  }
}

// ============================================================
// 交叉验证 / Cross-validation
// ============================================================

///|
/// K 折分割 / K-fold split.
pub fn k_fold_split(
  n : Int32,
  k : Int32,
) -> Array[(Array[Int32], Array[Int32])] {
  if n <= 0 || k <= 0 || k > n {
    return []
  }
  let fold_size = n / k
  let remainder = n % k
  let result : Array[(Array[Int32], Array[Int32])] = []
  let mut start = 0
  for fold in 0..<k {
    let size = if fold < remainder { fold_size + 1 } else { fold_size }
    let test_set : Array[Int32] = []
    let train_set : Array[Int32] = []
    for i in 0..<n {
      if i >= start && i < start + size {
        test_set.push(i)
      } else {
        train_set.push(i)
      }
    }
    result.push((train_set, test_set))
    start = start + size
  }
  result
}

///|
/// 分层分割 / Stratified split.
pub fn stratified_split(
  labels : Array[Int32],
  k : Int32,
) -> Array[(Array[Int32], Array[Int32])] {
  let n = labels.length()
  if n == 0 || k <= 0 {
    return []
  }
  let mut max_label = 0
  for i in 0..<n {
    if labels[i] > max_label {
      max_label = labels[i]
    }
  }
  let num_classes = max_label + 1
  let class_indices : Array[Array[Int32]] = []
  for _ in 0..<num_classes {
    class_indices.push([])
  }
  for i in 0..<n {
    class_indices[labels[i]].push(i)
  }
  let folds : Array[Array[Int32]] = []
  for _ in 0..<k {
    folds.push([])
  }
  for c in 0..<num_classes {
    let cn = class_indices[c].length()
    for i in 0..<cn {
      let fold = i % k
      folds[fold].push(class_indices[c][i])
    }
  }
  let result : Array[(Array[Int32], Array[Int32])] = []
  for fold in 0..<k {
    let test_set = folds[fold]
    let train_set : Array[Int32] = []
    for i in 0..<n {
      let mut in_test = false
      for j in 0..<test_set.length() {
        if test_set[j] == i {
          in_test = true
          break
        }
      }
      if !in_test {
        train_set.push(i)
      }
    }
    result.push((train_set, test_set))
  }
  result
}

///|
/// 留一法 / Leave-one-out.
pub fn leave_one_out(n : Int32) -> Array[(Array[Int32], Array[Int32])] {
  if n <= 0 {
    return []
  }
  let result : Array[(Array[Int32], Array[Int32])] = []
  for i in 0..<n {
    let train_set : Array[Int32] = []
    let test_set : Array[Int32] = [i]
    for j in 0..<n {
      if j != i {
        train_set.push(j)
      }
    }
    result.push((train_set, test_set))
  }
  result
}

///|
/// 交叉验证分数 / Cross-validate score.
pub fn cross_validate_score(scores : Array[Double]) -> CVResult {
  let n = scores.length()
  if n == 0 {
    return { mean_score: 0.0, std_score: 0.0, scores: [], }
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + scores[i]
  }
  let mean = sum / n.to_double()
  let mut sq_sum = 0.0
  for i in 0..<n {
    let d = scores[i] - mean
    sq_sum = sq_sum + d * d
  }
  let std = sqrt_(sq_sum / n.to_double())
  { mean_score: mean, std_score: std, scores, }
}

///|
/// 自助采样 / Bootstrap sample.
pub fn bootstrap_sample(
  data : Array[Double],
  n_samples : Int32,
) -> Array[Double] {
  let n = data.length()
  if n == 0 || n_samples <= 0 {
    return []
  }
  let result = Array::make(n_samples, 0.0)
  let mut seed = 42.0
  for i in 0..<n_samples {
    seed = rng_(seed)
    let idx = (seed / 2147483647.0 * n.to_double()).to_int() % n
    result[i] = data[idx]
  }
  result
}

// ============================================================
// 重采样 / Resampling
// ============================================================

///|
/// 过采样 / Oversample.
pub fn oversample(
  data : Array[Array[Double]],
  labels : Array[Int32],
  target_count : Int32,
) -> Array[Array[Double]] {
  let n = data.length()
  if n == 0 || n != labels.length() {
    return []
  }
  let mut max_label = 0
  for i in 0..<n {
    if labels[i] > max_label {
      max_label = labels[i]
    }
  }
  let num_classes = max_label + 1
  let class_indices : Array[Array[Int32]] = []
  for _ in 0..<num_classes {
    class_indices.push([])
  }
  for i in 0..<n {
    class_indices[labels[i]].push(i)
  }
  let result : Array[Array[Double]] = []
  let mut seed = 42.0
  for c in 0..<num_classes {
    let cn = class_indices[c].length()
    let need = target_count - cn
    if need > 0 && cn > 0 {
      for _ in 0..<need {
        seed = rng_(seed)
        let idx = (seed / 2147483647.0 * cn.to_double()).to_int() % cn
        result.push(data[class_indices[c][idx]])
      }
    }
  }
  result
}

///|
/// 欠采样 / Undersample.
pub fn undersample(
  data : Array[Array[Double]],
  labels : Array[Int32],
  target_count : Int32,
) -> Array[Array[Double]] {
  let n = data.length()
  if n == 0 || n != labels.length() {
    return []
  }
  let mut max_label = 0
  for i in 0..<n {
    if labels[i] > max_label {
      max_label = labels[i]
    }
  }
  let num_classes = max_label + 1
  let class_indices : Array[Array[Int32]] = []
  for _ in 0..<num_classes {
    class_indices.push([])
  }
  for i in 0..<n {
    class_indices[labels[i]].push(i)
  }
  let result : Array[Array[Double]] = []
  let mut seed = 42.0
  for c in 0..<num_classes {
    let cn = class_indices[c].length()
    if cn > target_count && target_count > 0 {
      let selected : Array[Int32] = []
      while selected.length() < target_count {
        seed = rng_(seed)
        let idx = (seed / 2147483647.0 * cn.to_double()).to_int() % cn
        let mut already = false
        for j in 0..<selected.length() {
          if selected[j] == idx {
            already = true
            break
          }
        }
        if !already {
          selected.push(idx)
        }
      }
      for i in 0..<target_count {
        result.push(data[class_indices[c][selected[i]]])
      }
    } else if cn > 0 {
      for i in 0..<cn {
        result.push(data[class_indices[c][i]])
      }
    }
  }
  result
}

///|
/// SMOTE 合成 / SMOTE synthetic samples.
pub fn smote(
  data : Array[Array[Double]],
  labels : Array[Int32],
  k : Int32,
  n_synthetic : Int32,
) -> Array[Array[Double]] {
  let n = data.length()
  if n == 0 || n != labels.length() || n_synthetic <= 0 {
    return []
  }
  let mut max_label = 0
  for i in 0..<n {
    if labels[i] > max_label {
      max_label = labels[i]
    }
  }
  let num_classes = max_label + 1
  let class_counts = Array::make(num_classes, 0)
  for i in 0..<n {
    class_counts[labels[i]] = class_counts[labels[i]] + 1
  }
  let mut minority_class = 0
  let mut min_count = n
  for c in 0..<num_classes {
    if class_counts[c] < min_count && class_counts[c] > 0 {
      min_count = class_counts[c]
      minority_class = c
    }
  }
  let minority_indices : Array[Int32] = []
  for i in 0..<n {
    if labels[i] == minority_class {
      minority_indices.push(i)
    }
  }
  let mn = minority_indices.length()
  if mn == 0 {
    return []
  }
  let dim = data[0].length()
  let result : Array[Array[Double]] = []
  let mut seed = 42.0
  for _ in 0..<n_synthetic {
    seed = rng_(seed)
    let idx = minority_indices[(seed / 2147483647.0 * mn.to_double()).to_int() %
      mn]
    let kk = if k < mn { k } else { mn - 1 }
    if kk <= 0 {
      result.push(data[idx])
      continue
    }
    let dists : Array[(Int32, Double)] = []
    for j in 0..<mn {
      if minority_indices[j] != idx {
        dists.push(
          (
            minority_indices[j],
            euclidean_dist(data[idx], data[minority_indices[j]]),
          ),
        )
      }
    }
    let mut i = 0
    while i < dists.length() {
      let mut j = i + 1
      while j < dists.length() {
        if dists[j].1 < dists[i].1 {
          let tmp = dists[i]
          dists[i] = dists[j]
          dists[j] = tmp
        }
        j = j + 1
      }
      i = i + 1
    }
    seed = rng_(seed)
    let nn_idx = dists[(seed / 2147483647.0 * kk.to_double()).to_int() % kk].0
    seed = rng_(seed)
    let gap = seed / 2147483647.0
    let synth = Array::make(dim, 0.0)
    for d in 0..<dim {
      synth[d] = data[idx][d] + gap * (data[nn_idx][d] - data[idx][d])
    }
    result.push(synth)
  }
  result
}

///|
/// 训练测试分割 / Train-test split.
pub fn train_test_split(
  n : Int32,
  test_ratio : Double,
) -> (Array[Int32], Array[Int32]) {
  if n <= 0 {
    return ([], [])
  }
  let test_size = (n.to_double() * test_ratio).to_int()
  let indices = shuffle_dataset(n)
  let test_set : Array[Int32] = []
  let train_set : Array[Int32] = []
  for i in 0..<n {
    if i < test_size {
      test_set.push(indices[i])
    } else {
      train_set.push(indices[i])
    }
  }
  (train_set, test_set)
}

///|
/// 数据集洗牌 / Shuffle dataset.
pub fn shuffle_dataset(n : Int32) -> Array[Int32] {
  let result = Array::make(n, 0)
  for i in 0..<n {
    result[i] = i
  }
  let mut seed = 42.0
  let mut i = n - 1
  while i > 0 {
    seed = rng_(seed)
    let j = (seed / 2147483647.0 * (i + 1).to_double()).to_int() % (i + 1)
    let tmp = result[i]
    result[i] = result[j]
    result[j] = tmp
    i = i - 1
  }
  result
}
