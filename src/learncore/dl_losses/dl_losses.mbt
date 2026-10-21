///|
/// # learncore/dl_losses DL 损失函数 / Deep Learning Losses
///
/// 损失函数契约 + 数学实现。架构 §4.3.5 learncore DL。
/// S2.3 填充：MSE + CrossEntropy（含 softmax）+ Hinge。
///
/// # DL losses
///
/// Loss function contracts + math. See architecture §4.3.5.

///|
/// 损失类型 / Loss kind.
pub(all) enum LossKind {
  MSE // 均方误差
  CrossEntropy // 交叉熵（含 softmax）
  Hinge // 合页损失
} derive(Debug, Eq)

///|
pub extend LossKind with Eq::{equal, not_equal}

///|
pub extend LossKind with Debug::{to_repr}

///|
/// MSE 损失 / MSE loss.
///
/// 公式：`mean((pred[i] - target[i])^2)`。
/// 退化安全：长度不匹配返回 0.0。
pub fn mse_loss(pred : Array[Double], target : Array[Double]) -> Double {
  let n = pred.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let diff = pred[i] - target[i]
      sum = sum + diff * diff
    }
    sum / n.to_double()
  }
}

///|
/// Softmax / Softmax.
fn softmax(logits : Array[Double]) -> Array[Double] {
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

///|
/// 交叉熵损失 / Cross-entropy loss.
///
/// 输入为 logits，先 softmax 再计算 -sum(target * log(prob))。
/// 退化安全：长度不匹配或空返回 0.0。
pub fn cross_entropy_loss(
  logits : Array[Double],
  target : Array[Double],
) -> Double {
  let n = logits.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let probs = softmax(logits)
    let mut sum = 0.0
    for i in 0..<n {
      if target[i] > 0.0 && probs[i] > 0.0 {
        sum = sum + target[i] * log(probs[i])
      }
    }
    -sum
  }
}

///|
/// 合页损失 / Hinge loss.
///
/// 公式：`mean(max(0, 1 - target[i] * pred[i]))`。
pub fn hinge_loss(pred : Array[Double], target : Array[Double]) -> Double {
  let n = pred.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let val = 1.0 - target[i] * pred[i]
      sum = sum + (if val > 0.0 { val } else { 0.0 })
    }
    sum / n.to_double()
  }
}

///|
/// 损失值 / Compute loss.
pub fn loss_value(
  kind : LossKind,
  pred : Array[Double],
  target : Array[Double],
) -> Double {
  match kind {
    MSE => mse_loss(pred, target)
    CrossEntropy => cross_entropy_loss(pred, target)
    Hinge => hinge_loss(pred, target)
  }
}

///|
/// 损失名称 / Loss name.
pub fn loss_name(kind : LossKind) -> String {
  match kind {
    MSE => "mse"
    CrossEntropy => "cross_entropy"
    Hinge => "hinge"
  }
}

///|
/// 自然指数 / Natural exponential (Taylor series).
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

///|
/// 自然对数 / Natural log.
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

///|
pub fn dl_losses_id() -> String {
  "learncore/dl_losses"
}

///===
/// S7.2 扩展：Contrastive/Triplet/Focal/LabelSmoothing/KLDiv/Huber/SmoothL1/CosineEmbedding/MarginRanking/SoftMargin/NLL/BCE/LogCosh/Dice/Tversky

///|
/// 对比损失 / Contrastive Loss.
/// L = (1 - y) * 0.5 * D^2 + y * 0.5 * max(0, margin - D)^2
/// y=1 表示不同类，y=0 表示同类。D 为距离。
pub fn contrastive_loss(
  embedding1 : Array[Double],
  embedding2 : Array[Double],
  label : Double,
  margin : Double,
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
  let d = d_sq.sqrt()
  let same = 1.0 - label
  let diff_loss = if margin - d > 0.0 {
    (margin - d) * (margin - d)
  } else {
    0.0
  }
  same * 0.5 * d_sq + label * 0.5 * diff_loss
}

///|
/// 三元组损失 / Triplet Margin Loss.
/// L = max(0, d(a, p) - d(a, n) + margin)
pub fn triplet_loss(
  anchor : Array[Double],
  positive : Array[Double],
  negative : Array[Double],
  margin : Double,
) -> Double {
  let n = if anchor.length() < positive.length() {
    anchor.length()
  } else {
    positive.length()
  }
  let mut d_ap = 0.0
  for i in 0..<n {
    let diff = anchor[i] - positive[i]
    d_ap = d_ap + diff * diff
  }
  let m = if anchor.length() < negative.length() {
    anchor.length()
  } else {
    negative.length()
  }
  let mut d_an = 0.0
  for i in 0..<m {
    let diff = anchor[i] - negative[i]
    d_an = d_an + diff * diff
  }
  let loss = d_ap.sqrt() - d_an.sqrt() + margin
  if loss > 0.0 {
    loss
  } else {
    0.0
  }
}

///|
/// Focal 损失 / Focal Loss.
/// FL = -alpha * (1 - p_t)^gamma * log(p_t)
/// p_t = p if y=1 else 1-p
pub fn focal_loss(
  pred : Array[Double],
  target : Array[Double],
  alpha : Double,
  gamma : Double,
) -> Double {
  let n = if pred.length() < target.length() {
    pred.length()
  } else {
    target.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let p = pred[i]
      let y = target[i]
      let p_t = y * p + (1.0 - y) * (1.0 - p)
      let pt = if p_t > 0.0 { p_t } else { 0.000001 }
      let modulating = exp(gamma * log(1.0 - pt))
      total = total + alpha * modulating * -log(pt)
    }
    total / n.to_double()
  }
}

///|
/// 标签平滑交叉熵 / Label Smoothing Cross Entropy.
/// L = -(1 - eps) * log(p_y) - eps * mean(log(p_i))
pub fn label_smoothing_loss(
  logits : Array[Double],
  target : Int32,
  epsilon : Double,
) -> Double {
  let n = logits.length()
  if n == 0 || target < 0 || target >= n {
    0.0
  } else {
    let sm = softmax(logits)
    let mut loss = 0.0
    for i in 0..<n {
      let p = if sm[i] > 0.0 { sm[i] } else { 0.000001 }
      let weight = if i == target { 1.0 - epsilon } else { 0.0 }
      loss = loss + (weight + epsilon / n.to_double()) * -log(p)
    }
    loss
  }
}

///|
/// KL 散度 / KL Divergence.
/// KL(P || Q) = sum(P_i * log(P_i / Q_i))
pub fn kl_div_loss(p : Array[Double], q : Array[Double]) -> Double {
  let n = if p.length() < q.length() { p.length() } else { q.length() }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let pi = p[i]
      let qi = q[i]
      if pi > 0.0 && qi > 0.0 {
        total = total + pi * log(pi / qi)
      }
    }
    total
  }
}

///|
/// Huber 损失 / Huber Loss.
/// L = 0.5 * x^2 if |x| <= delta else delta * (|x| - 0.5 * delta)
pub fn huber_loss(
  pred : Array[Double],
  target : Array[Double],
  delta : Double,
) -> Double {
  let n = if pred.length() < target.length() {
    pred.length()
  } else {
    target.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let x = pred[i] - target[i]
      let abs_x = if x < 0.0 { -x } else { x }
      if abs_x <= delta {
        total = total + 0.5 * x * x
      } else {
        total = total + delta * (abs_x - 0.5 * delta)
      }
    }
    total / n.to_double()
  }
}

///|
/// Smooth L1 损失 / Smooth L1 Loss (beta=1 Huber).
pub fn smooth_l1_loss(
  pred : Array[Double],
  target : Array[Double],
  beta : Double,
) -> Double {
  let n = if pred.length() < target.length() {
    pred.length()
  } else {
    target.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let x = pred[i] - target[i]
      let abs_x = if x < 0.0 { -x } else { x }
      if abs_x < beta {
        total = total + 0.5 * x * x / beta
      } else {
        total = total + abs_x - 0.5 * beta
      }
    }
    total / n.to_double()
  }
}

///|
/// 余弦嵌入损失 / Cosine Embedding Loss.
/// L = 1 - cos(a, b) if y=1 else max(0, cos(a, b) - margin)
pub fn cosine_embedding_loss(
  a : Array[Double],
  b : Array[Double],
  target : Double,
  margin : Double,
) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 {
    0.0
  } else {
    let mut dot = 0.0
    let mut norm_a = 0.0
    let mut norm_b = 0.0
    for i in 0..<n {
      dot = dot + a[i] * b[i]
      norm_a = norm_a + a[i] * a[i]
      norm_b = norm_b + b[i] * b[i]
    }
    let na = norm_a.sqrt()
    let nb = norm_b.sqrt()
    let cos = if na > 0.0 && nb > 0.0 { dot / (na * nb) } else { 0.0 }
    if target == 1.0 {
      1.0 - cos
    } else {
      let loss = cos - margin
      if loss > 0.0 {
        loss
      } else {
        0.0
      }
    }
  }
}

///|
/// Margin Ranking 损失 / Margin Ranking Loss.
/// L = max(0, -y * (x1 - x2) + margin)
pub fn margin_ranking_loss(
  x1 : Double,
  x2 : Double,
  y : Double,
  margin : Double,
) -> Double {
  let loss = -y * (x1 - x2) + margin
  if loss > 0.0 {
    loss
  } else {
    0.0
  }
}

///|
/// Soft Margin 损失 / Soft Margin Loss.
/// L = log(1 + exp(-y * x))
pub fn soft_margin_loss(pred : Double, target : Double) -> Double {
  let z = -target * pred
  if z > 20.0 {
    z
  } else if z < -20.0 {
    0.0
  } else {
    log(1.0 + exp(z))
  }
}

///|
/// 负对数似然损失 / Negative Log-Likelihood Loss.
/// L = -log(p[target])
pub fn nll_loss(log_probs : Array[Double], target : Int32) -> Double {
  let n = log_probs.length()
  if n == 0 || target < 0 || target >= n {
    0.0
  } else {
    -log_probs[target]
  }
}

///|
/// 二元交叉熵损失 / Binary Cross-Entropy Loss.
/// L = -(y * log(p) + (1 - y) * log(1 - p))
pub fn bce_loss(pred : Array[Double], target : Array[Double]) -> Double {
  let n = if pred.length() < target.length() {
    pred.length()
  } else {
    target.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let p = pred[i]
      let y = target[i]
      let pp = if p > 0.0 { p } else { 0.000001 }
      let qp = if p < 1.0 { 1.0 - p } else { 0.000001 }
      total = total + -(y * log(pp) + (1.0 - y) * log(qp))
    }
    total / n.to_double()
  }
}

///|
/// LogCosh 损失 / LogCosh Loss.
/// L = log(cosh(x)) = log((exp(x) + exp(-x)) / 2)
pub fn log_cosh_loss(pred : Array[Double], target : Array[Double]) -> Double {
  let n = if pred.length() < target.length() {
    pred.length()
  } else {
    target.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let x = pred[i] - target[i]
      let abs_x = if x < 0.0 { -x } else { x }
      total = total + abs_x + log(1.0 + exp(-2.0 * abs_x)) - 0.6931471805599453
    }
    total / n.to_double()
  }
}

///|
/// Dice 损失 / Dice Loss.
/// L = 1 - 2 * |pred ∩ target| / (|pred| + |target|)
pub fn dice_loss(pred : Array[Double], target : Array[Double]) -> Double {
  let n = if pred.length() < target.length() {
    pred.length()
  } else {
    target.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut intersection = 0.0
    let mut sum_pred = 0.0
    let mut sum_target = 0.0
    for i in 0..<n {
      intersection = intersection + pred[i] * target[i]
      sum_pred = sum_pred + pred[i]
      sum_target = sum_target + target[i]
    }
    let denom = sum_pred + sum_target
    if denom == 0.0 {
      0.0
    } else {
      1.0 - 2.0 * intersection / denom
    }
  }
}

///|
/// Tversky 损失 / Tversky Loss.
/// L = 1 - TP / (TP + alpha * FN + beta * FP)
pub fn tversky_loss(
  pred : Array[Double],
  target : Array[Double],
  alpha : Double,
  beta : Double,
) -> Double {
  let n = if pred.length() < target.length() {
    pred.length()
  } else {
    target.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut tp = 0.0
    let mut fp = 0.0
    let mut fn_ = 0.0
    for i in 0..<n {
      tp = tp + pred[i] * target[i]
      fp = fp + pred[i] * (1.0 - target[i])
      fn_ = fn_ + (1.0 - pred[i]) * target[i]
    }
    let denom = tp + alpha * fn_ + beta * fp
    if denom == 0.0 {
      0.0
    } else {
      1.0 - tp / denom
    }
  }
}
