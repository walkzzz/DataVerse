///|
/// # learncore/cross_validation 交叉验证 / Cross-Validation
///
/// k-fold 交叉验证分割 + 评估契约。架构 §4.3.5 learncore Eval。
/// S2.4 填充：kfold_splits（纯数学索引分割）+ cv_score（接受评估函数）。
///
/// # Cross-validation
///
/// k-fold split + evaluation contract. See architecture §4.3.5.

///|
/// CV 分割 / CV split: train + test indices.
pub struct CVSplit {
  train_indices : Array[Int32]
  test_indices : Array[Int32]
  fold_id : Int32
} derive(Debug, Eq)

///|
pub extend CVSplit with Eq::{equal, not_equal}

///|
pub extend CVSplit with Debug::{to_repr}

///|
/// 生成 k-fold 分割 / Generate k-fold splits.
///
/// 将 n_samples 个样本分成 k 折，每折轮流作为测试集。
/// 退化安全：k <= 0 或 n_samples <= 0 返回空数组。
pub fn cross_validation_kfold_splits(n_samples : Int32, k : Int32) -> Array[CVSplit] {
  if k <= 0 || n_samples <= 0 {
    []
  } else {
    let fold_size = n_samples / k
    let result : Array[CVSplit] = []
    for fold in 0..<k {
      let test_start = fold * fold_size
      let test_end = if fold == k - 1 {
        n_samples
      } else {
        test_start + fold_size
      }
      let test_idx : Array[Int32] = []
      for i in test_start..<test_end {
        test_idx.push(i)
      }
      let train_idx : Array[Int32] = []
      for i in 0..<n_samples {
        if i < test_start || i >= test_end {
          train_idx.push(i)
        }
      }
      result.push({
        train_indices: train_idx,
        test_indices: test_idx,
        fold_id: fold,
      })
    }
    result
  }
}

///|
/// CV 统计 / CV statistics.
pub struct CVStats {
  mean_score : Double
  std_score : Double
  fold_scores : Array[Double]
} derive(Debug, Eq)

///|
pub extend CVStats with Eq::{equal, not_equal}

///|
pub extend CVStats with Debug::{to_repr}

///|
/// 计算 CV 统计 / Compute CV statistics from fold scores.
///
/// 退化安全：空数组返回 0.0。
pub fn cross_validation_cv_stats(fold_scores : Array[Double]) -> CVStats {
  let n = fold_scores.length()
  if n == 0 {
    { mean_score: 0.0, std_score: 0.0, fold_scores: [], }
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + fold_scores[i]
    }
    let mean = sum / n.to_double()
    let mut var_sum = 0.0
    for i in 0..<n {
      let diff = fold_scores[i] - mean
      var_sum = var_sum + diff * diff
    }
    let std = (var_sum / n.to_double()).sqrt()
    { mean_score: mean, std_score: std, fold_scores, }
  }
}

///|
/// 留一法分割数 / Leave-one-out split count.
pub fn cross_validation_loo_count(n_samples : Int32) -> Int32 {
  n_samples
}

///|
pub fn cross_validation_cross_validation_id() -> String {
  "learncore/cross_validation"
}
