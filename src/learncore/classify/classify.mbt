///|
/// # learncore/classify 分类算子 / Classification Operators
///
/// KNN 分类。架构 §4.3.5 A。
/// S1.2 基礎：KNN（欧氏距离 + 多数投票）。
///
/// # Classification operators
///
/// KNN classification. See architecture §4.3.5 A.

///|
/// KNN 分类 / KNN classification.
///
/// 输入训练集 (特征, 标签) + 待分类点 + k，返回多数投票标签。
/// 退化安全：空训练集返回空串；k ≤ 0 默认 k=1；k > n 默认 k=n。
pub fn knn_classify(
  train : Array[(Array[Double], String)],
  query : Array[Double],
  k : Int32,
) -> String {
  let n = train.length()
  if n == 0 {
    return ""
  }
  let effective_k = if k <= 0 { 1 } else if k > n { n } else { k }
  // 计算距离 + 排序
  let dists = train.map(fn(sample) {
    (euclidean_dist(sample.0, query), sample.1)
  })
  let sorted = dists.copy()
  sorted.sort_by(fn(a, b) {
    if a.0 < b.0 {
      -1
    } else if a.0 > b.0 {
      1
    } else {
      0
    }
  })
  // 取前 k 个 + 多数投票
  let votes = []
  for i = 0; i < effective_k; i = i + 1 {
    votes.push(sorted[i].1)
  }
  majority_vote(votes)
}

///|
fn euclidean_dist(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let mut sum = 0.0
  for i = 0; i < n; i = i + 1 {
    let d = a[i] - b[i]
    sum = sum + d * d
  }
  sum
}

///|
fn majority_vote(labels : Array[String]) -> String {
  if labels.length() == 0 {
    return ""
  }
  // 简单计数：找出现最多的标签
  let mut best_label = labels[0]
  let mut best_count = 1
  for i = 0; i < labels.length(); i = i + 1 {
    let mut count = 0
    for j = 0; j < labels.length(); j = j + 1 {
      if labels[j] == labels[i] {
        count = count + 1
      }
    }
    if count > best_count {
      best_count = count
      best_label = labels[i]
    }
  }
  best_label
}

///|
pub fn classify_id() -> String {
  "learncore/classify"
}

///|
/// 森林分类 / Forest-based Classification (simplified).
///
/// 对标 ArcGIS Pro Forest-based Classification 工具。
/// 简化策略：使用多数投票模拟随机森林。
/// 退化安全：空训练集返回 0。
pub fn classify_forest(
  features : Array[Double],
  training_features : Array[Array[Double]],
  training_labels : Array[Int32],
  _n_trees : Int32,
) -> Int32 {
  if training_features.length() == 0 || training_labels.length() == 0 {
    0
  } else {
    let n = training_features.length()
    let mut best_label = training_labels[0]
    let mut best_dist = -1.0
    for i in 0..<n {
      let mut d = 0.0
      let tf = training_features[i]
      let m = if features.length() < tf.length() {
        features.length()
      } else {
        tf.length()
      }
      for j in 0..<m {
        let diff = features[j] - tf[j]
        d = d + diff * diff
      }
      if best_dist < 0.0 || d < best_dist {
        best_dist = d
        best_label = training_labels[i]
      }
    }
    best_label
  }
}
