///|
/// # learncore/contrastive 对比学习 / Contrastive Learning
///
/// 对比学习损失函数族：Contrastive/NT-Xent/Triplet/InfoNCE/SupCon/Margin/Circle/ProxyNCA/ArcFace/CosFace/SphereFace/AdaFace + 数据增强 + 投影头 + 温度调度。
///
/// # Contrastive Learning
///
/// Contrastive losses, embedding mining, augmentation, projection head, temperature.

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

fn cos_d(x : Double) -> Double {
  let pi = 3.141592653589793
  let two_pi = 6.283185307179586
  let mut y = x
  while y > pi {
    y = y - two_pi
  }
  while y < -pi {
    y = y + two_pi
  }
  let mut result = 1.0
  let mut term = 1.0
  let y2 = y * y
  for j in 1..<20 {
    term = term * y2 / ((2 * j - 1).to_double() * (2 * j).to_double()) * (-1.0)
    result = result + term
  }
  result
}

fn sin_d(x : Double) -> Double {
  let half_pi = 1.5707963267948966
  cos_d(x - half_pi)
}

fn abs_d(x : Double) -> Double {
  if x < 0.0 { -x } else { x }
}

fn dot(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let mut s = 0.0
  for i in 0..<n {
    s = s + a[i] * b[i]
  }
  s
}

fn norm(a : Array[Double]) -> Double {
  sqrt(dot(a, a))
}

fn sub_arr(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(a[i] - b[i])
  }
  result
}

fn clamp(x : Double, lo : Double, hi : Double) -> Double {
  if x < lo { lo } else if x > hi { hi } else { x }
}

fn sigmoid(x : Double) -> Double {
  1.0 / (1.0 + exp(-x))
}

fn acos_d(x : Double) -> Double {
  let xx = clamp(x, -1.0, 1.0)
  let neg = xx < 0.0
  let ax = abs_d(xx)
  let mut result = -0.0187293
  result = result * ax + 0.0742610
  result = result * ax - 0.2121146
  result = result * ax + 1.5707288
  result = result * sqrt(1.0 - ax)
  if neg { 3.141592653589793 - result } else { result }
}

fn softmax_arr(logits : Array[Double]) -> Array[Double] {
  let n = logits.length()
  if n == 0 {
    []
  } else {
    let mut max_val = logits[0]
    for i in 1..<n {
      if logits[i] > max_val {
        max_val = logits[i]
      }
    }
    let exps = logits.map(fn(x) { exp(x - max_val) })
    let mut total = 0.0
    for i in 0..<n {
      total = total + exps[i]
    }
    if total == 0.0 {
      exps
    } else {
      exps.map(fn(x) { x / total })
    }
  }
}

pub(all) struct ContrastiveConfig {
  margin : Double
  temperature : Double
  distance_metric : String
} derive(Debug, Eq)

pub extend ContrastiveConfig with Eq::{equal, not_equal}
pub extend ContrastiveConfig with Debug::{to_repr}

pub(all) struct NTXentConfig {
  temperature : Double
  batch_size : Int
} derive(Debug, Eq)

pub extend NTXentConfig with Eq::{equal, not_equal}
pub extend NTXentConfig with Debug::{to_repr}

pub(all) struct TripletConfig {
  margin : Double
  mining_strategy : String
} derive(Debug, Eq)

pub extend TripletConfig with Eq::{equal, not_equal}
pub extend TripletConfig with Debug::{to_repr}

pub(all) struct InfoNCEConfig {
  temperature : Double
  num_negatives : Int
} derive(Debug, Eq)

pub extend InfoNCEConfig with Eq::{equal, not_equal}
pub extend InfoNCEConfig with Debug::{to_repr}

pub(all) struct SupConConfig {
  temperature : Double
  mode : String
} derive(Debug, Eq)

pub extend SupConConfig with Eq::{equal, not_equal}
pub extend SupConConfig with Debug::{to_repr}

pub(all) struct MarginConfig {
  margin : Double
  reduction : String
} derive(Debug, Eq)

pub extend MarginConfig with Eq::{equal, not_equal}
pub extend MarginConfig with Debug::{to_repr}

pub(all) struct CircleConfig {
  gamma : Double
  margin : Double
} derive(Debug, Eq)

pub extend CircleConfig with Eq::{equal, not_equal}
pub extend CircleConfig with Debug::{to_repr}

pub(all) struct ProxyNCAConfig {
  num_proxies : Int
  dim : Int
  temperature : Double
} derive(Debug, Eq)

pub extend ProxyNCAConfig with Eq::{equal, not_equal}
pub extend ProxyNCAConfig with Debug::{to_repr}

pub(all) struct ArcFaceConfig {
  margin : Double
  scale : Double
} derive(Debug, Eq)

pub extend ArcFaceConfig with Eq::{equal, not_equal}
pub extend ArcFaceConfig with Debug::{to_repr}

pub(all) struct CosFaceConfig {
  margin : Double
  scale : Double
} derive(Debug, Eq)

pub extend CosFaceConfig with Eq::{equal, not_equal}
pub extend CosFaceConfig with Debug::{to_repr}

pub(all) struct SphereFaceConfig {
  margin : Double
  scale : Double
} derive(Debug, Eq)

pub extend SphereFaceConfig with Eq::{equal, not_equal}
pub extend SphereFaceConfig with Debug::{to_repr}

pub(all) struct AdaFaceConfig {
  margin : Double
  scale : Double
  h : Double
} derive(Debug, Eq)

pub extend AdaFaceConfig with Eq::{equal, not_equal}
pub extend AdaFaceConfig with Debug::{to_repr}

pub(all) struct AugmentConfig {
  color_jitter : Double
  crop_ratio : Double
  flip_prob : Double
} derive(Debug, Eq)

pub extend AugmentConfig with Eq::{equal, not_equal}
pub extend AugmentConfig with Debug::{to_repr}

pub(all) struct ProjectionConfig {
  input_dim : Int
  output_dim : Int
} derive(Debug, Eq)

pub extend ProjectionConfig with Eq::{equal, not_equal}
pub extend ProjectionConfig with Debug::{to_repr}

pub(all) struct TemperatureConfig {
  init_temp : Double
  min_temp : Double
  max_temp : Double
} derive(Debug, Eq)

pub extend TemperatureConfig with Eq::{equal, not_equal}
pub extend TemperatureConfig with Debug::{to_repr}

/// 构造对比配置 / Build contrastive config.
pub fn make_contrastive_config(
  margin : Double,
  temperature : Double,
  distance_metric : String
) -> ContrastiveConfig {
  { margin, temperature, distance_metric }
}

/// 对比损失 / Contrastive loss.
/// L = (1 - y) * 0.5 * D^2 + y * 0.5 * max(0, margin - D)^2
pub fn contrastive_loss(
  embedding1 : Array[Double],
  embedding2 : Array[Double],
  label : Double,
  margin : Double
) -> Double {
  let n = if embedding1.length() < embedding2.length() {
    embedding1.length()
  } else {
    embedding2.length()
  }
  let mut d_sq = 0.0
  for i in 0..<n {
    let diff = embedding1[i] - embedding2[i]
    d_sq = d_sq + diff * diff
  }
  let d = sqrt(d_sq)
  let same = 1.0 - label
  let diff_loss = if margin - d > 0.0 {
    (margin - d) * (margin - d)
  } else {
    0.0
  }
  same * 0.5 * d_sq + label * 0.5 * diff_loss
}

/// 监督对比损失 / Supervised contrastive loss over all pairs.
pub fn contrastive_loss_supervised(
  embeddings : Array[Array[Double]],
  labels : Array[Int],
  margin : Double
) -> Double {
  let n = if embeddings.length() < labels.length() {
    embeddings.length()
  } else {
    labels.length()
  }
  if n < 2 {
    0.0
  } else {
    let mut total = 0.0
    let mut count = 0
    for i in 0..<n {
      for j in (i + 1)..<n {
        let label = if labels[i] == labels[j] { 0.0 } else { 1.0 }
        total = total + contrastive_loss(embeddings[i], embeddings[j], label, margin)
        count = count + 1
      }
    }
    if count == 0 {
      0.0
    } else {
      total / count.to_double()
    }
  }
}

/// 构造 NT-Xent 配置 / Build NT-Xent config.
pub fn make_nt_xent(temperature : Double, batch_size : Int) -> NTXentConfig {
  { temperature, batch_size }
}

/// NT-Xent 相似度 / Cosine similarity.
pub fn nt_xent_sim(emb1 : Array[Double], emb2 : Array[Double]) -> Double {
  let n1 = norm(emb1)
  let n2 = norm(emb2)
  if n1 == 0.0 || n2 == 0.0 {
    0.0
  } else {
    dot(emb1, emb2) / (n1 * n2)
  }
}

/// NT-Xent 损失 / NT-Xent loss.
/// L = -log(exp(sim_pos / t) / sum_k exp(sim_k / t))
pub fn nt_xent_loss(
  emb_i : Array[Double],
  emb_j : Array[Double],
  all_embs : Array[Array[Double]],
  temperature : Double
) -> Double {
  if temperature <= 0.0 {
    0.0
  } else {
    let sim_pos = nt_xent_sim(emb_i, emb_j) / temperature
    let mut denom = 0.0
    for k in 0..<all_embs.length() {
      let sim_k = nt_xent_sim(emb_i, all_embs[k]) / temperature
      denom = denom + exp(sim_k)
    }
    if denom == 0.0 {
      0.0
    } else {
      -log(exp(sim_pos) / denom)
    }
  }
}

/// 构造三元组配置 / Build triplet config.
pub fn make_triplet_loss(margin : Double, mining_strategy : String) -> TripletConfig {
  { margin, mining_strategy }
}

/// 三元组损失 / Triplet margin loss.
/// L = max(0, d(a, p) - d(a, n) + margin)
pub fn triplet_loss(
  anchor : Array[Double],
  positive : Array[Double],
  negative : Array[Double],
  margin : Double
) -> Double {
  let diff_ap = sub_arr(anchor, positive)
  let d_ap = sqrt(dot(diff_ap, diff_ap))
  let diff_an = sub_arr(anchor, negative)
  let d_an = sqrt(dot(diff_an, diff_an))
  let loss = d_ap - d_an + margin
  if loss > 0.0 { loss } else { 0.0 }
}

/// 三元组挖掘 / Triplet mining: hardest positive and negative.
pub fn triplet_mining(
  anchor : Array[Double],
  embeddings : Array[Array[Double]],
  labels : Array[Int],
  anchor_label : Int
) -> (Array[Double], Array[Double]) {
  let n = if embeddings.length() < labels.length() {
    embeddings.length()
  } else {
    labels.length()
  }
  let mut hardest_pos : Array[Double] = []
  let mut max_pos_d = -1.0
  let mut hardest_neg : Array[Double] = []
  let mut min_neg_d = 999999.0
  for i in 0..<n {
    let diff = sub_arr(anchor, embeddings[i])
    let d_sq = dot(diff, diff)
    if labels[i] == anchor_label {
      if d_sq > max_pos_d {
        max_pos_d = d_sq
        hardest_pos = embeddings[i]
      }
    } else {
      if d_sq < min_neg_d {
        min_neg_d = d_sq
        hardest_neg = embeddings[i]
      }
    }
  }
  (hardest_pos, hardest_neg)
}

/// 半难挖掘 / Semihard negative mining.
/// d(a, p) < d(a, n) < d(a, p) + margin
pub fn triplet_semihard(
  anchor : Array[Double],
  positive : Array[Double],
  embeddings : Array[Array[Double]],
  labels : Array[Int],
  anchor_label : Int,
  margin : Double
) -> Array[Double] {
  let n = if embeddings.length() < labels.length() {
    embeddings.length()
  } else {
    labels.length()
  }
  let diff_ap = sub_arr(anchor, positive)
  let d_ap = sqrt(dot(diff_ap, diff_ap))
  let mut best_neg : Array[Double] = []
  let mut best_d = -1.0
  for i in 0..<n {
    if labels[i] != anchor_label {
      let diff_an = sub_arr(anchor, embeddings[i])
      let d_an = sqrt(dot(diff_an, diff_an))
      if d_an > d_ap && d_an < d_ap + margin {
        if best_d < 0.0 || d_an < best_d {
          best_d = d_an
          best_neg = embeddings[i]
        }
      }
    }
  }
  best_neg
}

/// 构造 InfoNCE 配置 / Build InfoNCE config.
pub fn make_info_nce(temperature : Double, num_negatives : Int) -> InfoNCEConfig {
  { temperature, num_negatives }
}

/// InfoNCE 损失 / InfoNCE loss.
/// L = -log(exp(sim(q, k+) / t) / sum_k exp(sim(q, k) / t))
pub fn info_nce_loss(
  query : Array[Double],
  positive : Array[Double],
  negatives : Array[Array[Double]],
  temperature : Double
) -> Double {
  if temperature <= 0.0 {
    0.0
  } else {
    let sim_pos = nt_xent_sim(query, positive) / temperature
    let mut denom = exp(sim_pos)
    for k in 0..<negatives.length() {
      let sim_k = nt_xent_sim(query, negatives[k]) / temperature
      denom = denom + exp(sim_k)
    }
    if denom == 0.0 {
      0.0
    } else {
      -log(exp(sim_pos) / denom)
    }
  }
}

/// InfoNCE 下界 / InfoNCE theoretical bound.
pub fn info_nce_bound(num_negatives : Int, temperature : Double) -> Double {
  if num_negatives <= 0 || temperature <= 0.0 {
    0.0
  } else {
    -log(num_negatives.to_double()) / temperature
  }
}

/// 构造 SupCon 配置 / Build SupCon config.
pub fn make_supcon(temperature : Double, mode : String) -> SupConConfig {
  { temperature, mode }
}

/// SupCon 损失 / Supervised contrastive loss.
pub fn supcon_loss(
  embeddings : Array[Array[Double]],
  labels : Array[Int],
  temperature : Double
) -> Double {
  let n = if embeddings.length() < labels.length() {
    embeddings.length()
  } else {
    labels.length()
  }
  if n < 2 || temperature <= 0.0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let mut pos_sum = 0.0
      let mut pos_count = 0
      let mut denom = 0.0
      for a in 0..<n {
        if a != i {
          let sim = nt_xent_sim(embeddings[i], embeddings[a]) / temperature
          denom = denom + exp(sim)
          if labels[a] == labels[i] {
            pos_sum = pos_sum + exp(sim)
            pos_count = pos_count + 1
          }
        }
      }
      if pos_count > 0 && denom > 0.0 {
        total = total + -log(pos_sum / denom) / pos_count.to_double()
      }
    }
    total / n.to_double()
  }
}

/// SupCon 单对损失 / SupCon pair contribution.
pub fn supcon_pair(
  emb_i : Array[Double],
  emb_j : Array[Double],
  embeddings : Array[Array[Double]],
  labels : Array[Int],
  i : Int,
  j : Int,
  temperature : Double
) -> Double {
  let n = embeddings.length()
  if i >= n || j >= n || temperature <= 0.0 {
    0.0
  } else {
    let sim_ij = nt_xent_sim(emb_i, emb_j) / temperature
    let mut denom = 0.0
    for a in 0..<n {
      if a != i {
        let sim = nt_xent_sim(emb_i, embeddings[a]) / temperature
        denom = denom + exp(sim)
      }
    }
    if labels[i] != labels[j] || denom == 0.0 {
      0.0
    } else {
      -log(exp(sim_ij) / denom)
    }
  }
}

/// 构造 Margin 配置 / Build margin config.
pub fn make_margin_loss(margin : Double, reduction : String) -> MarginConfig {
  { margin, reduction }
}

/// Margin 损失 / Margin ranking loss.
/// L = max(0, -y * (x1 - x2) + margin)
pub fn margin_loss(
  x1 : Array[Double],
  x2 : Array[Double],
  label : Double,
  margin : Double
) -> Double {
  let n = if x1.length() < x2.length() { x1.length() } else { x2.length() }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let val = -label * (x1[i] - x2[i]) + margin
      total = total + (if val > 0.0 { val } else { 0.0 })
    }
    total / n.to_double()
  }
}

/// Margin 调度 / Margin schedule over epochs.
pub fn margin_schedule(epoch : Int, max_epoch : Int, init_margin : Double) -> Double {
  if max_epoch <= 0 {
    init_margin
  } else {
    let progress = clamp(epoch.to_double() / max_epoch.to_double(), 0.0, 1.0)
    init_margin * (1.0 - 0.5 * progress)
  }
}

/// 构造 Circle 配置 / Build circle config.
pub fn make_circle_loss(gamma : Double, margin : Double) -> CircleConfig {
  { gamma, margin }
}

/// Circle 损失 / Circle loss.
/// L = log(1 + sum_j exp(gamma*(m+s_j)) * sum_k exp(-gamma*(m-s_k)))
pub fn circle_loss(
  sim_pos : Array[Double],
  sim_neg : Array[Double],
  gamma : Double,
  margin : Double
) -> Double {
  let mut pos_term = 0.0
  for j in 0..<sim_pos.length() {
    pos_term = pos_term + exp(-gamma * (sim_pos[j] + margin))
  }
  let mut neg_term = 0.0
  for k in 0..<sim_neg.length() {
    neg_term = neg_term + exp(gamma * (sim_neg[k] - margin))
  }
  log(1.0 + pos_term * neg_term)
}

/// Circle 权重 / Circle weight for a sample.
pub fn circle_weight(
  sim : Double,
  gamma : Double,
  margin : Double,
  is_positive : Bool
) -> Double {
  if is_positive {
    exp(-gamma * (sim + margin))
  } else {
    exp(gamma * (sim - margin))
  }
}

/// 构造 ProxyNCA 配置 / Build ProxyNCA config.
pub fn make_proxy_nca(num_proxies : Int, dim : Int, temperature : Double) -> ProxyNCAConfig {
  { num_proxies, dim, temperature }
}

/// ProxyNCA 损失 / ProxyNCA loss.
/// L = -log(exp(-d(z, p_y)) / sum_c exp(-d(z, p_c)))
pub fn proxy_nca_loss(
  embedding : Array[Double],
  proxies : Array[Array[Double]],
  label : Int,
  temperature : Double
) -> Double {
  let n = proxies.length()
  if n == 0 || label < 0 || label >= n || temperature <= 0.0 {
    0.0
  } else {
    let t2 = temperature * temperature
    let mut denom = 0.0
    for c in 0..<n {
      let diff = sub_arr(embedding, proxies[c])
      let d = dot(diff, diff) / (2.0 * t2)
      denom = denom + exp(-d)
    }
    let diff_y = sub_arr(embedding, proxies[label])
    let d_y = dot(diff_y, diff_y) / (2.0 * t2)
    if denom == 0.0 {
      0.0
    } else {
      -log(exp(-d_y) / denom)
    }
  }
}

/// Proxy 锚点 / Find nearest proxy.
pub fn proxy_anchor(embedding : Array[Double], proxies : Array[Array[Double]]) -> Int {
  let n = proxies.length()
  if n == 0 {
    -1
  } else {
    let mut best = 0
    let mut best_d = 999999.0
    for c in 0..<n {
      let diff = sub_arr(embedding, proxies[c])
      let d = dot(diff, diff)
      if d < best_d {
        best_d = d
        best = c
      }
    }
    best
  }
}

/// 构造 ArcFace 配置 / Build ArcFace config.
pub fn make_arc_face(margin : Double, scale : Double) -> ArcFaceConfig {
  { margin, scale }
}

/// ArcFace 损失 / ArcFace loss.
/// cos(theta + m) = cos(theta)cos(m) - sin(theta)sin(m)
pub fn arc_face_loss(
  embedding : Array[Double],
  weight : Array[Double],
  label : Int,
  margin : Double,
  scale : Double
) -> Double {
  let n_emb = norm(embedding)
  let n_w = norm(weight)
  if n_emb == 0.0 || n_w == 0.0 {
    0.0
  } else {
    let cos_theta = clamp(dot(embedding, weight) / (n_emb * n_w), -1.0, 1.0)
    let theta = acos_d(cos_theta)
    let cos_mt = cos_d(theta + margin)
    let logits = scale * cos_mt
    -log(sigmoid(logits))
  }
}

/// ArcFace margin / ArcFace angular margin.
pub fn arc_face_margin(
  embedding : Array[Double],
  weight : Array[Double],
  label : Int,
  margin : Double
) -> Double {
  let n_emb = norm(embedding)
  let n_w = norm(weight)
  if n_emb == 0.0 || n_w == 0.0 {
    0.0
  } else {
    let cos_theta = clamp(dot(embedding, weight) / (n_emb * n_w), -1.0, 1.0)
    let theta = acos_d(cos_theta)
    cos_d(theta + margin) - cos_theta
  }
}

/// 构造 CosFace 配置 / Build CosFace config.
pub fn make_cos_face(margin : Double, scale : Double) -> CosFaceConfig {
  { margin, scale }
}

/// CosFace 损失 / CosFace loss.
/// cos(theta) - m
pub fn cos_face_loss(
  embedding : Array[Double],
  weight : Array[Double],
  label : Int,
  margin : Double,
  scale : Double
) -> Double {
  let n_emb = norm(embedding)
  let n_w = norm(weight)
  if n_emb == 0.0 || n_w == 0.0 {
    0.0
  } else {
    let cos_theta = clamp(dot(embedding, weight) / (n_emb * n_w), -1.0, 1.0)
    let logits = scale * (cos_theta - margin)
    -log(sigmoid(logits))
  }
}

/// CosFace margin / CosFace additive margin.
pub fn cos_face_margin(theta : Double, margin : Double) -> Double {
  cos_d(theta) - margin
}

/// 构造 SphereFace 配置 / Build SphereFace config.
pub fn make_sphere_face(margin : Double, scale : Double) -> SphereFaceConfig {
  { margin, scale }
}

/// SphereFace 损失 / SphereFace loss.
/// cos(m * theta)
pub fn sphere_face_loss(
  embedding : Array[Double],
  weight : Array[Double],
  label : Int,
  margin : Double,
  scale : Double
) -> Double {
  let n_emb = norm(embedding)
  let n_w = norm(weight)
  if n_emb == 0.0 || n_w == 0.0 {
    0.0
  } else {
    let cos_theta = clamp(dot(embedding, weight) / (n_emb * n_w), -1.0, 1.0)
    let theta = acos_d(cos_theta)
    let logits = scale * cos_d(margin * theta)
    -log(sigmoid(logits))
  }
}

/// 构造 AdaFace 配置 / Build AdaFace config.
pub fn make_ada_face(margin : Double, scale : Double, h : Double) -> AdaFaceConfig {
  { margin, scale, h }
}

/// AdaFace 损失 / AdaFace loss with adaptive margin.
pub fn ada_face_loss(
  embedding : Array[Double],
  weight : Array[Double],
  label : Int,
  margin : Double,
  scale : Double,
  h : Double
) -> Double {
  let n_emb = norm(embedding)
  let n_w = norm(weight)
  if n_emb == 0.0 || n_w == 0.0 {
    0.0
  } else {
    let cos_theta = clamp(dot(embedding, weight) / (n_emb * n_w), -1.0, 1.0)
    let g = ada_face_weight(n_emb, h)
    let m_t = g * margin
    let theta = acos_d(cos_theta)
    let cos_mt = cos_d(theta + m_t)
    let logits = scale * cos_mt
    -log(sigmoid(logits))
  }
}

/// AdaFace 权重 / AdaFace adaptive weight based on feature quality.
pub fn ada_face_weight(emb_norm : Double, h : Double) -> Double {
  let g = clamp(emb_norm / h, 0.0, 1.0)
  1.0 - g
}

/// 构造增强配置 / Build augmentation config.
pub fn make_augment_contrast(
  color_jitter : Double,
  crop_ratio : Double,
  flip_prob : Double
) -> AugmentConfig {
  { color_jitter, crop_ratio, flip_prob }
}

/// 颜色增强 / Color jitter augmentation.
pub fn augment_color(embedding : Array[Double], jitter : Double) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<embedding.length() {
    let scale = 1.0 + jitter * sin_d(embedding[i] + i.to_double())
    result.push(embedding[i] * scale)
  }
  result
}

/// 裁剪增强 / Center crop augmentation.
pub fn augment_crop(embedding : Array[Double], crop_ratio : Double) -> Array[Double] {
  let n = embedding.length()
  let crop_size = (n.to_double() * crop_ratio).to_int()
  if crop_size <= 0 || crop_size > n {
    embedding
  } else {
    let start = (n - crop_size) / 2
    let result : Array[Double] = []
    for i in start..<(start + crop_size) {
      result.push(embedding[i])
    }
    result
  }
}

/// 翻转增强 / Flip augmentation.
pub fn augment_flip(embedding : Array[Double], flip_prob : Double) -> Array[Double] {
  let threshold = clamp(flip_prob, 0.0, 1.0)
  let seed = abs_d(sin_d(embedding.length().to_double()))
  if seed < threshold {
    let result : Array[Double] = []
    for i in 0..<embedding.length() {
      result.push(embedding[embedding.length() - 1 - i])
    }
    result
  } else {
    embedding
  }
}

/// 构造投影配置 / Build projection config.
pub fn make_projection(input_dim : Int, output_dim : Int) -> ProjectionConfig {
  { input_dim, output_dim }
}

/// 投影头 / Projection head (linear layer).
pub fn projection_head(
  embedding : Array[Double],
  weight : Array[Array[Double]],
  bias : Array[Double]
) -> Array[Double] {
  let out_dim = weight.length()
  let result : Array[Double] = []
  for i in 0..<out_dim {
    let mut s = if i < bias.length() { bias[i] } else { 0.0 }
    for j in 0..<embedding.length() {
      if j < weight[i].length() {
        s = s + weight[i][j] * embedding[j]
      }
    }
    result.push(s)
  }
  result
}

/// 投影维度 / Projection output dimension.
pub fn projection_dim(config : ProjectionConfig) -> Int {
  config.output_dim
}

/// 构造温度配置 / Build temperature config.
pub fn make_temperature(
  init_temp : Double,
  min_temp : Double,
  max_temp : Double
) -> TemperatureConfig {
  { init_temp, min_temp, max_temp }
}

/// 温度缩放 / Temperature-scaled similarity matrix.
pub fn temperature_scale(
  temperature : Double,
  embeddings : Array[Array[Double]]
) -> Array[Array[Double]] {
  let n = embeddings.length()
  let result : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      if temperature == 0.0 {
        row.push(0.0)
      } else {
        row.push(nt_xent_sim(embeddings[i], embeddings[j]) / temperature)
      }
    }
    result.push(row)
  }
  result
}

/// 温度搜索 / Grid search for best temperature.
pub fn temperature_search(
  embeddings : Array[Array[Double]],
  labels : Array[Int],
  min_temp : Double,
  max_temp : Double,
  steps : Int
) -> Double {
  if steps <= 0 {
    (min_temp + max_temp) / 2.0
  } else {
    let mut best_temp = min_temp
    let mut best_loss = 999999.0
    let step_size = (max_temp - min_temp) / steps.to_double()
    let mut t = min_temp
    for _ in 0..<steps {
      let loss = supcon_loss(embeddings, labels, t)
      if loss < best_loss {
        best_loss = loss
        best_temp = t
      }
      t = t + step_size
    }
    best_temp
  }
}

/// 模块标识 / Module identity.
pub fn contrastive_id() -> String {
  "learncore/contrastive"
}