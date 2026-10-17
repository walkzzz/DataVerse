///|
/// # learncore/metrics 评估指标算子 / Evaluation Metric Operators
///
/// 模型评估指标。架构 §4.3.5 D。
/// S1.2 基礎：accuracy + mse + mae + confusion_matrix。
///
/// # Evaluation metric operators
///
/// Model evaluation metrics. See architecture §4.3.5 D.

/// 准确率 / Accuracy.
///
/// 退化安全：空数组返回 0.0。
pub fn accuracy(predicted : Array[String], actual : Array[String]) -> Double {
  let n = if predicted.length() < actual.length() {
    predicted.length()
  } else {
    actual.length()
  }
  if n == 0 {
    return 0.0
  }
  let mut correct = 0
  for i = 0; i < n; i = i + 1 {
    if predicted[i] == actual[i] {
      correct = correct + 1
    }
  }
  correct.to_double() / n.to_double()
}

/// 均方误差 / Mean squared error.
///
/// 退化安全：空数组返回 0.0。
pub fn mse(predicted : Array[Double], actual : Array[Double]) -> Double {
  let n = if predicted.length() < actual.length() {
    predicted.length()
  } else {
    actual.length()
  }
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i = 0; i < n; i = i + 1 {
    let d = predicted[i] - actual[i]
    sum = sum + d * d
  }
  sum / n.to_double()
}

/// 平均绝对误差 / Mean absolute error.
///
/// 退化安全：空数组返回 0.0。
pub fn mae(predicted : Array[Double], actual : Array[Double]) -> Double {
  let n = if predicted.length() < actual.length() {
    predicted.length()
  } else {
    actual.length()
  }
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i = 0; i < n; i = i + 1 {
    let d = predicted[i] - actual[i]
    if d < 0.0 {
      sum = sum - d
    } else {
      sum = sum + d
    }
  }
  sum / n.to_double()
}

/// 混淆矩阵 / Confusion matrix.
///
/// 输入预测标签 + 真实标签 + 标签集合，返回 n×n 矩阵（行=真实，列=预测）。
/// 退化安全：空数组返回全 0 矩阵。
pub fn confusion_matrix(
  predicted : Array[String],
  actual : Array[String],
  labels : Array[String]
) -> Array[Array[Int]] {
  let n = labels.length()
  let matrix = []
  for _i = 0; _i < n; _i = _i + 1 {
    matrix.push(Array::make(n, 0))
  }
  let len = if predicted.length() < actual.length() {
    predicted.length()
  } else {
    actual.length()
  }
  for i = 0; i < len; i = i + 1 {
    let row = label_index(labels, actual[i])
    let col = label_index(labels, predicted[i])
    if row >= 0 && col >= 0 {
      matrix[row][col] = matrix[row][col] + 1
    }
  }
  matrix
}

fn label_index(labels : Array[String], label : String) -> Int {
  for i = 0; i < labels.length(); i = i + 1 {
    if labels[i] == label {
      return i
    }
  }
  -1
}

pub fn metrics_id() -> String {
  "learncore/metrics"
}