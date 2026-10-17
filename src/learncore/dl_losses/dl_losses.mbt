///|
/// # learncore/dl_losses DL 损失函数 / Deep Learning Losses
///
/// 损失函数契约 + 数学实现。架构 §4.3.5 learncore DL。
/// S2.3 填充：MSE + CrossEntropy（含 softmax）+ Hinge。
///
/// # DL losses
///
/// Loss function contracts + math. See architecture §4.3.5.

/// 损失类型 / Loss kind.
pub(all) enum LossKind {
  MSE           // 均方误差
  CrossEntropy  // 交叉熵（含 softmax）
  Hinge         // 合页损失
} derive(Debug, Eq)

pub extend LossKind with Eq::{equal, not_equal}
pub extend LossKind with Debug::{to_repr}

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

/// 交叉熵损失 / Cross-entropy loss.
///
/// 输入为 logits，先 softmax 再计算 -sum(target * log(prob))。
/// 退化安全：长度不匹配或空返回 0.0。
pub fn cross_entropy_loss(logits : Array[Double], target : Array[Double]) -> Double {
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

/// 损失值 / Compute loss.
pub fn loss_value(kind : LossKind, pred : Array[Double], target : Array[Double]) -> Double {
  match kind {
    MSE => mse_loss(pred, target)
    CrossEntropy => cross_entropy_loss(pred, target)
    Hinge => hinge_loss(pred, target)
  }
}

/// 损失名称 / Loss name.
pub fn loss_name(kind : LossKind) -> String {
  match kind {
    MSE => "mse"
    CrossEntropy => "cross_entropy"
    Hinge => "hinge"
  }
}

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

pub fn dl_losses_id() -> String {
  "learncore/dl_losses"
}