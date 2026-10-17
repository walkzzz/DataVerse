///|
/// # learncore/cluster 聚类算子 / Clustering Operators
///
/// KMeans 聚类。架构 §4.3.5 A。
/// S1.2 基礎：KMeans（Lloyd 迭代，欧氏距离）。
///
/// # Clustering operators
///
/// KMeans clustering. See architecture §4.3.5 A.

/// KMeans 聚类 / KMeans clustering.
///
/// 输入点集 + 簇数 k + 最大迭代次数，返回每个点的簇标签。
/// 退化安全：空点集返回空数组；k ≤ 0 返回全 0 标签。
pub fn kmeans(
  points : Array[Array[Double]],
  k : Int,
  max_iter : Int
) -> Array[Int] {
  let n = points.length()
  if n == 0 {
    return []
  }
  if k <= 0 || k > n {
    return Array::make(n, 0)
  }
  // 初始化质心：前 k 个点
  let centroids = []
  for i = 0; i < k; i = i + 1 {
    centroids.push(points[i].copy())
  }
  let labels = Array::make(n, 0)
  let mut iter = 0
  let mut changed = true
  while iter < max_iter && changed {
    changed = false
    // 分配步骤
    for i = 0; i < n; i = i + 1 {
      let mut best_cluster = 0
      let mut best_dist = squared_dist(points[i], centroids[0])
      for c = 1; c < k; c = c + 1 {
        let d = squared_dist(points[i], centroids[c])
        if d < best_dist {
          best_dist = d
          best_cluster = c
        }
      }
      if labels[i] != best_cluster {
        labels[i] = best_cluster
        changed = true
      }
    }
    // 更新步骤
    for c = 0; c < k; c = c + 1 {
      let dim = centroids[c].length()
      let sums = Array::make(dim, 0.0)
      let mut count = 0
      for i = 0; i < n; i = i + 1 {
        if labels[i] == c {
          for d = 0; d < dim; d = d + 1 {
            sums[d] = sums[d] + points[i][d]
          }
          count = count + 1
        }
      }
      if count > 0 {
        for d = 0; d < dim; d = d + 1 {
          centroids[c][d] = sums[d] / count.to_double()
        }
      }
    }
    iter = iter + 1
  }
  labels
}

fn squared_dist(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let mut sum = 0.0
  for i = 0; i < n; i = i + 1 {
    let d = a[i] - b[i]
    sum = sum + d * d
  }
  sum
}

pub fn cluster_id() -> String {
  "learncore/cluster"
}