///|
/// # learncore/dl_optimizers DL 优化器 / Deep Learning Optimizers
///
/// 优化器契约 + 单步参数更新。架构 §4.3.5 learncore DL。
/// S2.3 填充：SGD + Adam（简化版，无真实梯度计算，模拟单步）。
///
/// # DL optimizers
///
/// Optimizer contracts + single-step update. See architecture §4.3.5.

///|
/// 整数幂 / Integer power helper.
fn dl_optimizers_pow_int(base : Double, exp : Int32) -> Double {
  let mut result = 1.0
  for _i in 0..<exp {
    result = result * base
  }
  result
}

///|
/// 优化器类型 / Optimizer kind.
pub(all) enum OptimizerKind {
  SGD
  Adam
} derive(Debug, Eq)

///|
pub extend OptimizerKind with Eq::{equal, not_equal}

///|
pub extend OptimizerKind with Debug::{to_repr}

///|
/// 优化器状态 / Optimizer state.
pub struct OptimizerState {
  kind : OptimizerKind
  lr : Double
  params : Array[Double]
  velocity : Array[Double]
  step_count : Int32
} derive(Debug, Eq)

///|
pub extend OptimizerState with Eq::{equal, not_equal}

///|
pub extend OptimizerState with Debug::{to_repr}

///|
/// 构造优化器 / Build optimizer.
pub fn dl_optimizers_make_optimizer(
  kind : OptimizerKind,
  lr : Double,
  params : Array[Double],
) -> OptimizerState {
  let n = params.length()
  let v : Array[Double] = []
  for _ in 0..<n {
    v.push(0.0)
  }
  { kind, lr, params, velocity: v, step_count: 0, }
}

///|
/// SGD 单步 / SGD step.
///
/// new_params = params - lr * gradients.
pub fn dl_optimizers_sgd_step(
  state : OptimizerState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  if n != gradients.length() {
    state.params
  } else {
    let result : Array[Double] = []
    for i in 0..<n {
      result.push(state.params[i] - state.lr * gradients[i])
    }
    result
  }
}

///|
/// Adam 单步（简化）/ Adam step (simplified).
///
/// 简化版：velocity = beta1 * velocity + (1 - beta1) * grad
///        new_params = params - lr * velocity
pub fn dl_optimizers_adam_step(
  state : OptimizerState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  if n != gradients.length() {
    state.params
  } else {
    let beta1 = 0.9
    let result : Array[Double] = []
    for i in 0..<n {
      let new_v = beta1 * state.velocity[i] + (1.0 - beta1) * gradients[i]
      result.push(state.params[i] - state.lr * new_v)
    }
    result
  }
}

///|
/// 优化器单步 / Optimizer step.
pub fn dl_optimizers_optimizer_step(
  state : OptimizerState,
  gradients : Array[Double],
) -> Array[Double] {
  match state.kind {
    SGD => dl_optimizers_sgd_step(state, gradients)
    Adam => dl_optimizers_adam_step(state, gradients)
  }
}

///|
/// 更新优化器状态 / Update optimizer state after a step.
pub fn dl_optimizers_update_state(
  state : OptimizerState,
  new_params : Array[Double],
) -> OptimizerState {
  let n = new_params.length()
  let new_v : Array[Double] = []
  for i in 0..<n {
    if i < state.velocity.length() {
      let beta1 = 0.9
      if state.kind == Adam {
        new_v.push(beta1 * state.velocity[i])
      } else {
        new_v.push(0.0)
      }
    } else {
      new_v.push(0.0)
    }
  }
  {
    kind: state.kind,
    lr: state.lr,
    params: new_params,
    velocity: new_v,
    step_count: state.step_count + 1,
  }
}

///|
/// 优化器名称 / Optimizer name.
pub fn dl_optimizers_optimizer_name(kind : OptimizerKind) -> String {
  match kind {
    SGD => "sgd"
    Adam => "adam"
  }
}

///|
pub fn dl_optimizers_dl_optimizers_id() -> String {
  "learncore/dl_optimizers"
}

///===
/// S7.3 扩展：AdamW/RAdam/Lookahead/AdaBelief/NAdam/AdaMax/RMSProp/Adagrad/ASGD/Lamb

///|
/// AdamW 一步 / AdamW optimizer step (decoupled weight decay).
pub fn dl_optimizers_adamw_step(
  state : OptimizerState,
  gradients : Array[Double],
  weight_decay : Double,
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let beta1 = 0.9
  let beta2 = 0.999
  let eps = 0.00000001
  let t = state.step_count + 1
  for i in 0..<m {
    let g = gradients[i] + weight_decay * state.params[i]
    let m_t = beta1 * state.velocity[i] + (1.0 - beta1) * g
    let v_t = beta2 * state.velocity[i] + (1.0 - beta2) * g * g
    let m_hat = m_t / (1.0 - dl_optimizers_pow_int(beta1, t))
    let v_hat = v_t / (1.0 - dl_optimizers_pow_int(beta2, t))
    result[i] = state.params[i] - state.lr * m_hat / (v_hat.sqrt() + eps)
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// RAdam 一步 / Rectified Adam step.
pub fn dl_optimizers_radam_step(
  state : OptimizerState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let beta1 = 0.9
  let beta2 = 0.999
  let eps = 0.00000001
  let t = state.step_count + 1
  let rho_inf = 2.0 / (1.0 - beta2) - 1.0
  let rho_t = rho_inf -
    2.0 * t.to_double() * dl_optimizers_pow_int(beta2, t) / (1.0 - dl_optimizers_pow_int(beta2, t))
  for i in 0..<m {
    let g = gradients[i]
    let m_t = beta1 * state.velocity[i] + (1.0 - beta1) * g
    let v_t = beta2 * state.velocity[i] + (1.0 - beta2) * g * g
    let m_hat = m_t / (1.0 - dl_optimizers_pow_int(beta1, t))
    if rho_t > 4.0 {
      let r_t = ((rho_t - 4.0) *
      (rho_t - 2.0) *
      rho_inf /
      ((rho_inf - 4.0) * (rho_inf - 2.0) * rho_t)).sqrt()
      let v_hat = v_t.sqrt()
      result[i] = state.params[i] - state.lr * r_t * m_hat / (v_hat + eps)
    } else {
      result[i] = state.params[i] - state.lr * m_hat
    }
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// AdaBelief 一步 / AdaBelief optimizer step.
pub fn dl_optimizers_adabelief_step(
  state : OptimizerState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let beta1 = 0.9
  let beta2 = 0.999
  let eps = 0.00000001
  let t = state.step_count + 1
  for i in 0..<m {
    let g = gradients[i]
    let m_t = beta1 * state.velocity[i] + (1.0 - beta1) * g
    let v_t = beta2 * state.velocity[i] +
      (1.0 - beta2) * (g - m_t) * (g - m_t) +
      eps
    let m_hat = m_t / (1.0 - dl_optimizers_pow_int(beta1, t))
    let v_hat = v_t / (1.0 - dl_optimizers_pow_int(beta2, t))
    result[i] = state.params[i] - state.lr * m_hat / (v_hat.sqrt() + eps)
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// NAdam 一步 / NAdam optimizer step (Nesterov-accelerated Adam).
pub fn dl_optimizers_nadam_step(
  state : OptimizerState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let beta1 = 0.9
  let beta2 = 0.999
  let eps = 0.00000001
  let t = state.step_count + 1
  for i in 0..<m {
    let g = gradients[i]
    let m_t = beta1 * state.velocity[i] + (1.0 - beta1) * g
    let v_t = beta2 * state.velocity[i] + (1.0 - beta2) * g * g
    let m_hat = m_t / (1.0 - dl_optimizers_pow_int(beta1, t)) +
      (1.0 - beta1) * g / (1.0 - dl_optimizers_pow_int(beta1, t))
    let v_hat = v_t / (1.0 - dl_optimizers_pow_int(beta2, t))
    result[i] = state.params[i] - state.lr * m_hat / (v_hat.sqrt() + eps)
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// AdaMax 一步 / AdaMax optimizer step.
pub fn dl_optimizers_adamax_step(
  state : OptimizerState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let beta1 = 0.9
  let beta2 = 0.999
  let eps = 0.00000001
  let t = state.step_count + 1
  for i in 0..<m {
    let g = gradients[i]
    let m_t = beta1 * state.velocity[i] + (1.0 - beta1) * g
    let v_t = beta2 * state.velocity[i]
    let abs_g = if g < 0.0 { -g } else { g }
    let u_t = if v_t > abs_g { v_t } else { abs_g }
    let m_hat = m_t / (1.0 - dl_optimizers_pow_int(beta1, t))
    result[i] = state.params[i] - state.lr * m_hat / (u_t + eps)
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// RMSProp 一步 / RMSProp optimizer step.
pub fn dl_optimizers_rmsprop_step(
  state : OptimizerState,
  gradients : Array[Double],
  alpha : Double,
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let eps = 0.00000001
  for i in 0..<m {
    let g = gradients[i]
    let v_t = alpha * state.velocity[i] + (1.0 - alpha) * g * g
    result[i] = state.params[i] - state.lr * g / (v_t.sqrt() + eps)
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// Adagrad 一步 / Adagrad optimizer step.
pub fn dl_optimizers_adagrad_step(
  state : OptimizerState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let eps = 0.00000001
  for i in 0..<m {
    let g = gradients[i]
    let v_t = state.velocity[i] + g * g
    result[i] = state.params[i] - state.lr * g / (v_t.sqrt() + eps)
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// ASGD 一步 / Averaged SGD step.
pub fn dl_optimizers_asgd_step(
  state : OptimizerState,
  gradients : Array[Double],
  weight_decay : Double,
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let t = state.step_count + 1
  for i in 0..<m {
    let g = gradients[i] + weight_decay * state.params[i]
    let new_param = state.params[i] - state.lr * g
    result[i] = (t.to_double() * state.params[i] + new_param) /
      (t.to_double() + 1.0)
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// Lamb 一步 / Lamb optimizer step (simplified).
pub fn dl_optimizers_lamb_step(
  state : OptimizerState,
  gradients : Array[Double],
  weight_decay : Double,
) -> Array[Double] {
  let n = state.params.length()
  let m = if gradients.length() < n { gradients.length() } else { n }
  let result : Array[Double] = Array::make(n, 0.0)
  let beta1 = 0.9
  let beta2 = 0.999
  let eps = 0.00000001
  let t = state.step_count + 1
  for i in 0..<m {
    let g = gradients[i] + weight_decay * state.params[i]
    let m_t = beta1 * state.velocity[i] + (1.0 - beta1) * g
    let v_t = beta2 * state.velocity[i] + (1.0 - beta2) * g * g
    let m_hat = m_t / (1.0 - dl_optimizers_pow_int(beta1, t))
    let v_hat = v_t / (1.0 - dl_optimizers_pow_int(beta2, t))
    let update = m_hat / (v_hat.sqrt() + eps)
    result[i] = state.params[i] - state.lr * update
  }
  for i in m..<n {
    result[i] = state.params[i]
  }
  result
}

///|
/// Lookahead 一步 / Lookahead optimizer step (simplified, returns averaged).
pub fn dl_optimizers_lookahead_step(
  slow_params : Array[Double],
  fast_params : Array[Double],
  k : Double,
) -> Array[Double] {
  let n = if slow_params.length() < fast_params.length() {
    slow_params.length()
  } else {
    fast_params.length()
  }
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = slow_params[i] + k * (fast_params[i] - slow_params[i])
  }
  result
}
