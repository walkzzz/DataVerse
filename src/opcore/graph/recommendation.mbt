///|
/// # opcore/recommendation 推荐系统 / Recommendation System
///
/// 推荐系统算法集合：协同过滤、矩阵分解、内容推荐、混合推荐、评估指标。
///
/// # Recommendation System
///
/// CF, matrix factorization, content-based, hybrid, evaluation metrics.
fn recommendation_log(x : Double) -> Double {
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
fn recommendation_sqrt(x : Double) -> Double {
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

///|
fn recommendation_abs_d(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
/// 用户 / User.
pub struct User {
  user_id : Int32
  features : Array[Double]
} derive(Debug, Eq)

///|
pub extend User with Eq::{equal, not_equal}

///|
pub extend User with Debug::{to_repr}

///|
/// 物品 / Item.
pub struct Item {
  item_id : Int32
  features : Array[Double]
} derive(Debug, Eq)

///|
pub extend Item with Eq::{equal, not_equal}

///|
pub extend Item with Debug::{to_repr}

///|
/// 评分 / Rating.
pub struct Rating {
  user_id : Int32
  item_id : Int32
  score : Double
} derive(Debug, Eq)

///|
pub extend Rating with Eq::{equal, not_equal}

///|
pub extend Rating with Debug::{to_repr}

///|
/// 交互 / Interaction.
pub struct Interaction {
  user_id : Int32
  item_id : Int32
  timestamp : Int32
} derive(Debug, Eq)

///|
pub extend Interaction with Eq::{equal, not_equal}

///|
pub extend Interaction with Debug::{to_repr}

///|
/// 评分矩阵 / Rating matrix.
pub struct RatingMatrix {
  num_users : Int32
  num_items : Int32
  data : Array[Array[Double]]
} derive(Debug, Eq)

///|
pub extend RatingMatrix with Eq::{equal, not_equal}

///|
pub extend RatingMatrix with Debug::{to_repr}

///|
/// 嵌入 / Embedding.
pub struct EmbeddingRec {
  num_entities : Int32
  dim : Int32
  vectors : Array[Array[Double]]
} derive(Debug, Eq)

///|
pub extend EmbeddingRec with Eq::{equal, not_equal}

///|
pub extend EmbeddingRec with Debug::{to_repr}

///|
/// 会话 / Session.
pub struct Session {
  session_id : Int32
  items : Array[Int32]
  timestamps : Array[Int32]
} derive(Debug, Eq)

///|
pub extend Session with Eq::{equal, not_equal}

///|
pub extend Session with Debug::{to_repr}

///|
/// 规则 / Rule.
pub struct Rule {
  item_id : Int32
  weight : Double
} derive(Debug, Eq)

///|
pub extend Rule with Eq::{equal, not_equal}

///|
pub extend Rule with Debug::{to_repr}

///|
/// 上下文强盗 / Contextual bandit.
pub struct ContextualBandit {
  num_arms : Int32
  counts : Array[Int32]
  rewards : Array[Double]
  values : Array[Double]
} derive(Debug, Eq)

///|
pub extend ContextualBandit with Eq::{equal, not_equal}

///|
pub extend ContextualBandit with Debug::{to_repr}

///|
/// 矩阵分解结果 / Matrix factorization result.
pub struct MFResult {
  num_users : Int32
  num_items : Int32
  k : Int32
  user_factors : Array[Array[Double]]
  item_factors : Array[Array[Double]]
} derive(Debug, Eq)

///|
pub extend MFResult with Eq::{equal, not_equal}

///|
pub extend MFResult with Debug::{to_repr}

///|
/// 构造用户 / Build user.
pub fn recommendation_make_user(user_id : Int32, features : Array[Double]) -> User {
  { user_id, features, }
}

///|
/// 构造物品 / Build item.
pub fn recommendation_make_item(item_id : Int32, features : Array[Double]) -> Item {
  { item_id, features, }
}

///|
/// 构造评分 / Build rating.
pub fn recommendation_make_rating(user_id : Int32, item_id : Int32, score : Double) -> Rating {
  { user_id, item_id, score, }
}

///|
/// 构造交互 / Build interaction.
pub fn recommendation_make_interaction(
  user_id : Int32,
  item_id : Int32,
  timestamp : Int32,
) -> Interaction {
  { user_id, item_id, timestamp, }
}

///|
/// 构造评分矩阵（零初始化）/ Build rating matrix (zero-init).
pub fn recommendation_make_rating_matrix(num_users : Int32, num_items : Int32) -> RatingMatrix {
  let data : Array[Array[Double]] = []
  for _ in 0..<num_users {
    data.push(Array::make(num_items, 0.0))
  }
  { num_users, num_items, data, }
}

///|
/// 归一化评分到 [0, 1] / Normalize ratings to [0, 1].
pub fn recommendation_normalize_ratings(
  matrix : RatingMatrix,
  min_val : Double,
  max_val : Double,
) -> RatingMatrix {
  let range = max_val - min_val
  if range == 0.0 {
    matrix
  } else {
    let data : Array[Array[Double]] = []
    for i in 0..<matrix.num_users {
      let row : Array[Double] = []
      for j in 0..<matrix.num_items {
        let v = matrix.data[i][j]
        let nv = (v - min_val) / range
        row.push(if nv < 0.0 { 0.0 } else if nv > 1.0 { 1.0 } else { nv })
      }
      data.push(row)
    }
    { num_users: matrix.num_users, num_items: matrix.num_items, data, }
  }
}

///|
/// 中心化评分（减去用户均值）/ Center ratings (subtract user mean).
pub fn recommendation_center_ratings(matrix : RatingMatrix) -> RatingMatrix {
  let data : Array[Array[Double]] = []
  for i in 0..<matrix.num_users {
    let mut sum = 0.0
    let mut count = 0
    for j in 0..<matrix.num_items {
      if matrix.data[i][j] != 0.0 {
        sum = sum + matrix.data[i][j]
        count = count + 1
      }
    }
    let mean = if count > 0 { sum / count.to_double() } else { 0.0 }
    let row : Array[Double] = []
    for j in 0..<matrix.num_items {
      if matrix.data[i][j] != 0.0 {
        row.push(matrix.data[i][j] - mean)
      } else {
        row.push(0.0)
      }
    }
    data.push(row)
  }
  { num_users: matrix.num_users, num_items: matrix.num_items, data, }
}

///|
/// 余弦相似度 / Cosine similarity.
pub fn recommendation_cosine_sim_rec(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 {
    0.0
  } else {
    let mut dot = 0.0
    let mut na = 0.0
    let mut nb = 0.0
    for i in 0..<n {
      dot = dot + a[i] * b[i]
      na = na + a[i] * a[i]
      nb = nb + b[i] * b[i]
    }
    let denom = recommendation_sqrt(na) * recommendation_sqrt(nb)
    if denom == 0.0 {
      0.0
    } else {
      dot / denom
    }
  }
}

///|
/// 皮尔逊相关系数 / Pearson correlation.
pub fn recommendation_pearson_sim_rec(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 {
    0.0
  } else {
    let mut sa = 0.0
    let mut sb = 0.0
    for i in 0..<n {
      sa = sa + a[i]
      sb = sb + b[i]
    }
    let ma = sa / n.to_double()
    let mb = sb / n.to_double()
    let mut cov = 0.0
    let mut va = 0.0
    let mut vb = 0.0
    for i in 0..<n {
      let da = a[i] - ma
      let db = b[i] - mb
      cov = cov + da * db
      va = va + da * da
      vb = vb + db * db
    }
    let denom = recommendation_sqrt(va) * recommendation_sqrt(vb)
    if denom == 0.0 {
      0.0
    } else {
      cov / denom
    }
  }
}

///|
/// Jaccard 相似度 / Jaccard similarity.
pub fn recommendation_jaccard_sim_rec(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 {
    0.0
  } else {
    let mut inter = 0
    let mut union = 0
    for i in 0..<n {
      let na = a[i] != 0.0
      let nb = b[i] != 0.0
      if na && nb {
        inter = inter + 1
      }
      if na || nb {
        union = union + 1
      }
    }
    if union == 0 {
      0.0
    } else {
      inter.to_double() / union.to_double()
    }
  }
}

///|
/// 基于用户的协同过滤 / User-based collaborative filtering.
pub fn recommendation_user_based_cf(
  matrix : RatingMatrix,
  user_id : Int32,
  item_id : Int32,
  k : Int32,
) -> Double {
  if user_id < 0 ||
    user_id >= matrix.num_users ||
    item_id < 0 ||
    item_id >= matrix.num_items {
    0.0
  } else if matrix.data[user_id][item_id] != 0.0 {
    matrix.data[user_id][item_id]
  } else {
    let target = matrix.data[user_id]
    let sims : Array[(Int32, Double)] = []
    for u in 0..<matrix.num_users {
      if u != user_id && matrix.data[u][item_id] != 0.0 {
        let s = recommendation_cosine_sim_rec(target, matrix.data[u])
        if s > 0.0 {
          sims.push((u, s))
        }
      }
    }
    let kk = if k < sims.length() { k } else { sims.length() }
    if kk == 0 {
      0.0
    } else {
      let mut num = 0.0
      let mut den = 0.0
      for i in 0..<kk {
        let (u, s) = sims[i]
        num = num + s * matrix.data[u][item_id]
        den = den + recommendation_abs_d(s)
      }
      if den == 0.0 {
        0.0
      } else {
        num / den
      }
    }
  }
}

///|
/// 基于物品的协同过滤 / Item-based collaborative filtering.
pub fn recommendation_item_based_cf(
  matrix : RatingMatrix,
  user_id : Int32,
  item_id : Int32,
  k : Int32,
) -> Double {
  if user_id < 0 ||
    user_id >= matrix.num_users ||
    item_id < 0 ||
    item_id >= matrix.num_items {
    0.0
  } else if matrix.data[user_id][item_id] != 0.0 {
    matrix.data[user_id][item_id]
  } else {
    let item_col : Array[Double] = []
    for u in 0..<matrix.num_users {
      item_col.push(matrix.data[u][item_id])
    }
    let sims : Array[(Int32, Double)] = []
    for j in 0..<matrix.num_items {
      if j != item_id && matrix.data[user_id][j] != 0.0 {
        let other_col : Array[Double] = []
        for u in 0..<matrix.num_users {
          other_col.push(matrix.data[u][j])
        }
        let s = recommendation_cosine_sim_rec(item_col, other_col)
        if s > 0.0 {
          sims.push((j, s))
        }
      }
    }
    let kk = if k < sims.length() { k } else { sims.length() }
    if kk == 0 {
      0.0
    } else {
      let mut num = 0.0
      let mut den = 0.0
      for i in 0..<kk {
        let (j, s) = sims[i]
        num = num + s * matrix.data[user_id][j]
        den = den + recommendation_abs_d(s)
      }
      if den == 0.0 {
        0.0
      } else {
        num / den
      }
    }
  }
}

///|
/// 预测评分 / Predict rating.
pub fn recommendation_predict_rating(
  matrix : RatingMatrix,
  user_id : Int32,
  item_id : Int32,
  method_ : Int32,
) -> Double {
  if method_ == 0 {
    recommendation_user_based_cf(matrix, user_id, item_id, 10)
  } else {
    recommendation_item_based_cf(matrix, user_id, item_id, 10)
  }
}

///|
/// 推荐 Top-N / Recommend top-N items.
pub fn recommendation_recommend_top_n(
  matrix : RatingMatrix,
  user_id : Int32,
  n : Int32,
) -> Array[Int32] {
  if user_id < 0 || user_id >= matrix.num_users {
    []
  } else {
    let scores : Array[(Int32, Double)] = []
    for j in 0..<matrix.num_items {
      if matrix.data[user_id][j] == 0.0 {
        let s = recommendation_user_based_cf(matrix, user_id, j, 10)
        scores.push((j, s))
      }
    }
    let result : Array[Int32] = []
    for _ in 0..<n {
      let mut best_idx = -1
      let mut best_score = -1000.0
      for i in 0..<scores.length() {
        let (_, sc) = scores[i]
        if sc > best_score {
          best_score = sc
          best_idx = i
        }
      }
      if best_idx >= 0 {
        let (item, _) = scores[best_idx]
        result.push(item)
        scores[best_idx] = (item, -1000.0)
      }
    }
    result
  }
}

///|
/// 为用户推荐 / Recommend for user.
pub fn recommendation_recommend_for_user(
  matrix : RatingMatrix,
  user_id : Int32,
) -> Array[Int32] {
  recommendation_recommend_top_n(matrix, user_id, 10)
}

///|
/// 矩阵分解 / Matrix factorization (gradient descent).
pub fn recommendation_matrix_factorization(
  matrix : RatingMatrix,
  k : Int32,
  lr : Double,
  reg : Double,
  epochs : Int32,
) -> MFResult {
  let nu = matrix.num_users
  let ni = matrix.num_items
  let uf : Array[Array[Double]] = []
  for _ in 0..<nu {
    uf.push(Array::make(k, 0.1))
  }
  let inf : Array[Array[Double]] = []
  for _ in 0..<ni {
    inf.push(Array::make(k, 0.1))
  }
  for _ in 0..<epochs {
    for i in 0..<nu {
      for j in 0..<ni {
        let r = matrix.data[i][j]
        if r != 0.0 {
          let mut pred = 0.0
          for d in 0..<k {
            pred = pred + uf[i][d] * inf[j][d]
          }
          let err = r - pred
          for d in 0..<k {
            let gu = err * inf[j][d] - reg * uf[i][d]
            let gi = err * uf[i][d] - reg * inf[j][d]
            uf[i][d] = uf[i][d] + lr * gu
            inf[j][d] = inf[j][d] + lr * gi
          }
        }
      }
    }
  }
  { num_users: nu, num_items: ni, k, user_factors: uf, item_factors: inf, }
}

///|
/// SVD 推荐 / SVD-based recommendation (simplified as MF).
pub fn recommendation_svd_recommend(
  matrix : RatingMatrix,
  user_id : Int32,
  item_id : Int32,
  k : Int32,
) -> Double {
  let mf = recommendation_matrix_factorization(matrix, k, 0.01, 0.1, 10)
  if user_id < 0 ||
    user_id >= mf.num_users ||
    item_id < 0 ||
    item_id >= mf.num_items {
    0.0
  } else {
    let mut pred = 0.0
    for d in 0..<mf.k {
      pred = pred + mf.user_factors[user_id][d] * mf.item_factors[item_id][d]
    }
    pred
  }
}

///|
/// ALS 分解 / ALS factorization (simplified).
pub fn recommendation_als_factorize(
  matrix : RatingMatrix,
  k : Int32,
  epochs : Int32,
) -> MFResult {
  recommendation_matrix_factorization(matrix, k, 0.01, 0.1, epochs)
}

///|
/// 梯度下降分解 / Gradient descent factorization.
pub fn recommendation_gradient_factorize(
  matrix : RatingMatrix,
  k : Int32,
  lr : Double,
  epochs : Int32,
) -> MFResult {
  recommendation_matrix_factorization(matrix, k, lr, 0.01, epochs)
}

///|
/// 基于内容的推荐 / Content-based recommendation.
pub fn recommendation_content_based_rec(
  user : User,
  items : Array[Item],
  n : Int32,
) -> Array[Int32] {
  let scores : Array[(Int32, Double)] = []
  for i in 0..<items.length() {
    let s = recommendation_cosine_sim_rec(user.features, items[i].features)
    scores.push((items[i].item_id, s))
  }
  let result : Array[Int32] = []
  for _ in 0..<n {
    let mut best_idx = -1
    let mut best_score = -1000.0
    for i in 0..<scores.length() {
      let (_, sc) = scores[i]
      if sc > best_score {
        best_score = sc
        best_idx = i
      }
    }
    if best_idx >= 0 {
      let (item, _) = scores[best_idx]
      result.push(item)
      scores[best_idx] = (item, -1000.0)
    }
  }
  result
}

///|
/// 混合推荐 / Hybrid recommendation.
pub fn recommendation_hybrid_recommend(
  matrix : RatingMatrix,
  user : User,
  items : Array[Item],
  alpha : Double,
  n : Int32,
) -> Array[Int32] {
  if user.user_id < 0 || user.user_id >= matrix.num_users {
    recommendation_content_based_rec(user, items, n)
  } else {
    let cf_recs = recommendation_recommend_top_n(matrix, user.user_id, n * 2)
    let cb_recs = recommendation_content_based_rec(user, items, n * 2)
    let scores : Array[(Int32, Double)] = []
    for i in 0..<cf_recs.length() {
      let weight = alpha * (1.0 / (i + 1).to_double())
      scores.push((cf_recs[i], weight))
    }
    for i in 0..<cb_recs.length() {
      let weight = (1.0 - alpha) * (1.0 / (i + 1).to_double())
      let mut idx = -1
      for j in 0..<scores.length() {
        let (item, _) = scores[j]
        if item == cb_recs[i] {
          idx = j
        }
      }
      if idx >= 0 {
        let (item, sc) = scores[idx]
        scores[idx] = (item, sc + weight)
      } else {
        scores.push((cb_recs[i], weight))
      }
    }
    let result : Array[Int32] = []
    for _ in 0..<n {
      let mut best_idx = -1
      let mut best_score = -1000.0
      for i in 0..<scores.length() {
        let (_, sc) = scores[i]
        if sc > best_score {
          best_score = sc
          best_idx = i
        }
      }
      if best_idx >= 0 {
        let (item, _) = scores[best_idx]
        result.push(item)
        scores[best_idx] = (item, -1000.0)
      }
    }
    result
  }
}

///|
/// 基于流行度的推荐 / Popularity-based recommendation.
pub fn recommendation_popularity_based_rec(matrix : RatingMatrix, n : Int32) -> Array[Int32] {
  let counts : Array[(Int32, Int32)] = []
  for j in 0..<matrix.num_items {
    let mut c = 0
    for i in 0..<matrix.num_users {
      if matrix.data[i][j] != 0.0 {
        c = c + 1
      }
    }
    counts.push((j, c))
  }
  let result : Array[Int32] = []
  for _ in 0..<n {
    let mut best_idx = -1
    let mut best_count = -1
    for i in 0..<counts.length() {
      let (_, c) = counts[i]
      if c > best_count {
        best_count = c
        best_idx = i
      }
    }
    if best_idx >= 0 {
      let (item, _) = counts[best_idx]
      result.push(item)
      counts[best_idx] = (item, -1)
    }
  }
  result
}

///|
/// 随机推荐 / Random recommendation.
pub fn recommendation_random_rec(num_items : Int32, n : Int32) -> Array[Int32] {
  let result : Array[Int32] = []
  let kk = if n < num_items { n } else { num_items }
  for i in 0..<kk {
    result.push(i)
  }
  result
}

///|
/// 基线推荐 / Baseline recommendation (global mean).
pub fn recommendation_baseline_rec(
  matrix : RatingMatrix,
  user_id : Int32,
  item_id : Int32,
) -> Double {
  let mut sum = 0.0
  let mut count = 0
  for i in 0..<matrix.num_users {
    for j in 0..<matrix.num_items {
      if matrix.data[i][j] != 0.0 {
        sum = sum + matrix.data[i][j]
        count = count + 1
      }
    }
  }
  let mean = if count == 0 { 0.0 } else { sum / count.to_double() }
  let mut u_mean = mean
  let mut i_mean = mean
  if user_id >= 0 && user_id < matrix.num_users {
    let mut s = 0.0
    let mut c = 0
    for j in 0..<matrix.num_items {
      if matrix.data[user_id][j] != 0.0 {
        s = s + matrix.data[user_id][j]
        c = c + 1
      }
    }
    if c > 0 {
      u_mean = s / c.to_double()
    }
  }
  if item_id >= 0 && item_id < matrix.num_items {
    let mut s = 0.0
    let mut c = 0
    for i in 0..<matrix.num_users {
      if matrix.data[i][item_id] != 0.0 {
        s = s + matrix.data[i][item_id]
        c = c + 1
      }
    }
    if c > 0 {
      i_mean = s / c.to_double()
    }
  }
  u_mean + i_mean - mean
}

///|
/// 构造嵌入 / Build embedding.
pub fn recommendation_make_embedding_rec(num_entities : Int32, dim : Int32) -> EmbeddingRec {
  let vectors : Array[Array[Double]] = []
  for i in 0..<num_entities {
    let v : Array[Double] = []
    for d in 0..<dim {
      v.push((i + d).to_double() * 0.01)
    }
    vectors.push(v)
  }
  { num_entities, dim, vectors, }
}

///|
/// 嵌入点积 / Embedding dot product.
pub fn recommendation_embedding_dot(emb : EmbeddingRec, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= emb.num_entities || j < 0 || j >= emb.num_entities {
    0.0
  } else {
    let mut s = 0.0
    for d in 0..<emb.dim {
      s = s + emb.vectors[i][d] * emb.vectors[j][d]
    }
    s
  }
}

///|
/// 嵌入推荐 / Embedding-based recommendation.
pub fn recommendation_embedding_recommend(
  emb : EmbeddingRec,
  target : Int32,
  n : Int32,
) -> Array[Int32] {
  if target < 0 || target >= emb.num_entities {
    []
  } else {
    let scores : Array[(Int32, Double)] = []
    for j in 0..<emb.num_entities {
      if j != target {
        scores.push((j, recommendation_embedding_dot(emb, target, j)))
      }
    }
    let result : Array[Int32] = []
    for _ in 0..<n {
      let mut best_idx = -1
      let mut best_score = -1000.0
      for i in 0..<scores.length() {
        let (_, sc) = scores[i]
        if sc > best_score {
          best_score = sc
          best_idx = i
        }
      }
      if best_idx >= 0 {
        let (item, _) = scores[best_idx]
        result.push(item)
        scores[best_idx] = (item, -1000.0)
      }
    }
    result
  }
}

///|
/// RMSE 评估 / RMSE evaluation.
pub fn recommendation_evaluate_rmse(pred : Array[Double], actual : Array[Double]) -> Double {
  let n = pred.length()
  if n == 0 || n != actual.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let d = pred[i] - actual[i]
      sum = sum + d * d
    }
    recommendation_sqrt(sum / n.to_double())
  }
}

///|
/// MAE 评估 / MAE evaluation.
pub fn recommendation_evaluate_mae(pred : Array[Double], actual : Array[Double]) -> Double {
  let n = pred.length()
  if n == 0 || n != actual.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + recommendation_abs_d(pred[i] - actual[i])
    }
    sum / n.to_double()
  }
}

///|
/// Precision/Recall 评估 / Precision and recall.
pub fn recommendation_evaluate_precision_recall(
  recommended : Array[Int32],
  relevant : Array[Int32],
) -> (Double, Double) {
  let mut hits = 0
  for i in 0..<recommended.length() {
    for j in 0..<relevant.length() {
      if recommended[i] == relevant[j] {
        hits = hits + 1
      }
    }
  }
  let precision = if recommended.length() == 0 {
    0.0
  } else {
    hits.to_double() / recommended.length().to_double()
  }
  let recall = if relevant.length() == 0 {
    0.0
  } else {
    hits.to_double() / relevant.length().to_double()
  }
  (precision, recall)
}

///|
/// NDCG 评估 / NDCG evaluation.
pub fn recommendation_evaluate_ndcg(
  recommended : Array[Int32],
  relevant : Array[Int32],
) -> Double {
  if recommended.length() == 0 {
    0.0
  } else {
    let mut dcg = 0.0
    for i in 0..<recommended.length() {
      let mut rel = 0.0
      for j in 0..<relevant.length() {
        if recommended[i] == relevant[j] {
          rel = 1.0
        }
      }
      if i == 0 {
        dcg = dcg + rel
      } else {
        dcg = dcg + rel / recommendation_log((i + 2).to_double())
      }
    }
    let ideal_hits = if relevant.length() < recommended.length() {
      relevant.length()
    } else {
      recommended.length()
    }
    let mut idcg = 0.0
    for i in 0..<ideal_hits {
      if i == 0 {
        idcg = idcg + 1.0
      } else {
        idcg = idcg + 1.0 / recommendation_log((i + 2).to_double())
      }
    }
    if idcg == 0.0 {
      0.0
    } else {
      dcg / idcg
    }
  }
}

///|
/// MAP 评估 / Mean Average Precision.
pub fn recommendation_evaluate_map(
  recommended : Array[Int32],
  relevant : Array[Int32],
) -> Double {
  if recommended.length() == 0 || relevant.length() == 0 {
    0.0
  } else {
    let mut hits = 0
    let mut sum_prec = 0.0
    for i in 0..<recommended.length() {
      let mut is_rel = false
      for j in 0..<relevant.length() {
        if recommended[i] == relevant[j] {
          is_rel = true
        }
      }
      if is_rel {
        hits = hits + 1
        sum_prec = sum_prec + hits.to_double() / (i + 1).to_double()
      }
    }
    if hits == 0 {
      0.0
    } else {
      sum_prec / relevant.length().to_double()
    }
  }
}

///|
/// Hit Rate 评估 / Hit rate.
pub fn recommendation_evaluate_hit_rate(
  recommended : Array[Int32],
  relevant : Array[Int32],
) -> Double {
  let mut hit = 0
  for i in 0..<recommended.length() {
    for j in 0..<relevant.length() {
      if recommended[i] == relevant[j] {
        hit = 1
      }
    }
  }
  hit.to_double()
}

///|
/// 覆盖率 / Catalog coverage.
pub fn recommendation_coverage(
  recommended_lists : Array[Array[Int32]],
  num_total_items : Int32,
) -> Double {
  if num_total_items == 0 {
    0.0
  } else {
    let unique : Array[Int32] = []
    for i in 0..<recommended_lists.length() {
      for j in 0..<recommended_lists[i].length() {
        let item = recommended_lists[i][j]
        let mut found = false
        for u in 0..<unique.length() {
          if unique[u] == item {
            found = true
          }
        }
        if !found {
          unique.push(item)
        }
      }
    }
    unique.length().to_double() / num_total_items.to_double()
  }
}

///|
/// 新颖性 / Novelty (mean self-information).
pub fn recommendation_novelty(
  recommended : Array[Int32],
  item_popularity : Array[Double],
  total_users : Int32,
) -> Double {
  if recommended.length() == 0 || total_users == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<recommended.length() {
      let item = recommended[i]
      if item >= 0 && item < item_popularity.length() {
        let p = item_popularity[item] / total_users.to_double()
        if p > 0.0 {
          sum = sum + -1.0 * recommendation_log(p)
        }
      }
    }
    sum / recommended.length().to_double()
  }
}

///|
/// 多样性 / Diversity (mean pairwise distance).
pub fn recommendation_diversity(
  recommended : Array[Int32],
  item_features : Array[Array[Double]],
) -> Double {
  let n = recommended.length()
  if n < 2 {
    0.0
  } else {
    let mut sum = 0.0
    let mut count = 0
    for i in 0..<n {
      let start = i + 1
      for j in start..<n {
        let a = recommended[i]
        let b = recommended[j]
        if a >= 0 &&
          a < item_features.length() &&
          b >= 0 &&
          b < item_features.length() {
          let dist = 1.0 - recommendation_cosine_sim_rec(item_features[a], item_features[b])
          sum = sum + dist
          count = count + 1
        }
      }
    }
    if count == 0 {
      0.0
    } else {
      sum / count.to_double()
    }
  }
}

///|
/// 意外性 / Serendipity.
pub fn recommendation_serendipity(
  recommended : Array[Int32],
  relevant : Array[Int32],
  expected : Array[Int32],
) -> Double {
  if recommended.length() == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<recommended.length() {
      let item = recommended[i]
      let mut is_rel = false
      for j in 0..<relevant.length() {
        if item == relevant[j] {
          is_rel = true
        }
      }
      let mut is_exp = false
      for j in 0..<expected.length() {
        if item == expected[j] {
          is_exp = true
        }
      }
      if is_rel && !is_exp {
        sum = sum + 1.0
      }
    }
    sum / recommended.length().to_double()
  }
}

///|
/// 构造会话 / Build session.
pub fn recommendation_make_session(
  session_id : Int32,
  items : Array[Int32],
  timestamps : Array[Int32],
) -> Session {
  { session_id, items, timestamps, }
}

///|
/// 基于会话的推荐 / Session-based recommendation.
pub fn recommendation_session_based_rec(
  session : Session,
  item_co_occurrence : Array[Array[Int32]],
  n : Int32,
) -> Array[Int32] {
  let scores : Array[(Int32, Double)] = []
  let num_items = item_co_occurrence.length()
  for j in 0..<num_items {
    let mut s = 0.0
    for i in 0..<session.items.length() {
      let item = session.items[i]
      if item >= 0 && item < num_items && j < item_co_occurrence[item].length() {
        s = s + item_co_occurrence[item][j].to_double()
      }
    }
    let mut in_session = false
    for k in 0..<session.items.length() {
      if session.items[k] == j {
        in_session = true
      }
    }
    if !in_session && s > 0.0 {
      scores.push((j, s))
    }
  }
  let result : Array[Int32] = []
  for _ in 0..<n {
    let mut best_idx = -1
    let mut best_score = -1000.0
    for i in 0..<scores.length() {
      let (_, sc) = scores[i]
      if sc > best_score {
        best_score = sc
        best_idx = i
      }
    }
    if best_idx >= 0 {
      let (item, _) = scores[best_idx]
      result.push(item)
      scores[best_idx] = (item, -1000.0)
    }
  }
  result
}

///|
/// 顺序推荐 / Sequential recommendation.
pub fn recommendation_sequential_rec(
  history : Array[Int32],
  transition_matrix : Array[Array[Double]],
  n : Int32,
) -> Array[Int32] {
  if history.length() == 0 {
    []
  } else {
    let last = history[history.length() - 1]
    if last < 0 || last >= transition_matrix.length() {
      []
    } else {
      let scores : Array[(Int32, Double)] = []
      let row = transition_matrix[last]
      for j in 0..<row.length() {
        scores.push((j, row[j]))
      }
      let result : Array[Int32] = []
      for _ in 0..<n {
        let mut best_idx = -1
        let mut best_score = -1000.0
        for i in 0..<scores.length() {
          let (_, sc) = scores[i]
          if sc > best_score {
            best_score = sc
            best_idx = i
          }
        }
        if best_idx >= 0 {
          let (item, _) = scores[best_idx]
          result.push(item)
          scores[best_idx] = (item, -1000.0)
        }
      }
      result
    }
  }
}

///|
/// 构造规则 / Build rule.
pub fn recommendation_make_rule_rec(item_id : Int32, weight : Double) -> Rule {
  { item_id, weight, }
}

///|
/// 基于规则的推荐 / Rule-based recommendation.
pub fn recommendation_rule_based_recommend(rules : Array[Rule], n : Int32) -> Array[Int32] {
  let sorted : Array[Rule] = []
  for i in 0..<rules.length() {
    sorted.push(rules[i])
  }
  let result : Array[Int32] = []
  for _ in 0..<n {
    let mut best_idx = -1
    let mut best_weight = -1000.0
    for i in 0..<sorted.length() {
      if sorted[i].weight > best_weight {
        best_weight = sorted[i].weight
        best_idx = i
      }
    }
    if best_idx >= 0 {
      result.push(sorted[best_idx].item_id)
      sorted[best_idx] = { item_id: sorted[best_idx].item_id, weight: -1000.0, }
    }
  }
  result
}

///|
/// 冷启动用户 / Cold start user.
pub fn recommendation_cold_start_user(
  user : User,
  items : Array[Item],
  n : Int32,
) -> Array[Int32] {
  recommendation_content_based_rec(user, items, n)
}

///|
/// 冷启动物品 / Cold start item.
pub fn recommendation_cold_start_item(
  item : Item,
  users : Array[User],
  n : Int32,
) -> Array[Int32] {
  let scores : Array[(Int32, Double)] = []
  for i in 0..<users.length() {
    let s = recommendation_cosine_sim_rec(item.features, users[i].features)
    scores.push((users[i].user_id, s))
  }
  let result : Array[Int32] = []
  for _ in 0..<n {
    let mut best_idx = -1
    let mut best_score = -1000.0
    for i in 0..<scores.length() {
      let (_, sc) = scores[i]
      if sc > best_score {
        best_score = sc
        best_idx = i
      }
    }
    if best_idx >= 0 {
      let (uid, _) = scores[best_idx]
      result.push(uid)
      scores[best_idx] = (uid, -1000.0)
    }
  }
  result
}

///|
/// 多臂老虎机推荐 / Multi-armed bandit recommendation.
pub fn recommendation_bandit_rec(counts : Array[Int32], rewards : Array[Double]) -> Int32 {
  let n = counts.length()
  if n == 0 {
    0
  } else {
    let mut best_arm = 0
    let mut best_value = -1000.0
    for i in 0..<n {
      let v = if counts[i] == 0 {
        1000.0
      } else {
        rewards[i] / counts[i].to_double()
      }
      if v > best_value {
        best_value = v
        best_arm = i
      }
    }
    best_arm
  }
}

///|
/// Thompson 采样 / Thompson sampling.
pub fn recommendation_thompson_sampling(
  counts : Array[Int32],
  successes : Array[Int32],
) -> Int32 {
  let n = counts.length()
  if n == 0 {
    0
  } else {
    let mut best_arm = 0
    let mut best_score = -1000.0
    for i in 0..<n {
      let alpha = successes[i].to_double() + 1.0
      let beta = (counts[i] - successes[i]).to_double() + 1.0
      let score = alpha / (alpha + beta)
      if score > best_score {
        best_score = score
        best_arm = i
      }
    }
    best_arm
  }
}

///|
/// UCB 推荐 / Upper Confidence Bound.
pub fn recommendation_ucb_rec(
  counts : Array[Int32],
  rewards : Array[Double],
  total_count : Int32,
) -> Int32 {
  let n = counts.length()
  if n == 0 {
    0
  } else {
    let mut unexplored = -1
    for i in 0..<n {
      if counts[i] == 0 {
        unexplored = i
      }
    }
    if unexplored >= 0 {
      unexplored
    } else {
      let mut best_arm = 0
      let mut best_value = -1000.0
      let tc = total_count.to_double()
      for i in 0..<n {
        let mean = rewards[i] / counts[i].to_double()
        let bonus = recommendation_sqrt(2.0 * recommendation_log(tc + 1.0) / counts[i].to_double())
        let v = mean + bonus
        if v > best_value {
          best_value = v
          best_arm = i
        }
      }
      best_arm
    }
  }
}

///|
/// 构造上下文强盗 / Build contextual bandit.
pub fn recommendation_make_contextual(num_arms : Int32) -> ContextualBandit {
  {
    num_arms,
    counts: Array::make(num_arms, 0),
    rewards: Array::make(num_arms, 0.0),
    values: Array::make(num_arms, 0.0),
  }
}

///|
/// 上下文强盗推荐 / Contextual bandit recommendation.
pub fn recommendation_contextual_bandit(
  state : ContextualBandit,
  context : Array[Double],
) -> Int32 {
  let n = state.num_arms
  if n == 0 {
    0
  } else {
    let mut best_arm = 0
    let mut best_score = -1000.0
    for i in 0..<n {
      let mut s = 0.0
      if i < context.length() {
        s = context[i]
      }
      let bonus = if state.counts[i] == 0 {
        1000.0
      } else {
        recommendation_sqrt(2.0 * recommendation_log(state.counts[i].to_double() + 1.0))
      }
      let v = state.values[i] + s + bonus
      if v > best_score {
        best_score = v
        best_arm = i
      }
    }
    best_arm
  }
}

///|
/// 模块标识 / Module identifier.
pub fn recommendation_recommendation_id() -> String {
  "opcore/recommendation"
}
