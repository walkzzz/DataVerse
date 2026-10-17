///|
/// # learncore/dl_optimizers DL 优化器 / Deep Learning Optimizers
///
/// 优化器契约 + 单步参数更新。架构 §4.3.5 learncore DL。
/// S2.3 填充：SGD + Adam（简化版，无真实梯度计算，模拟单步）。
///
/// # DL optimizers
///
/// Optimizer contracts + single-step update. See architecture §4.3.5.

/// 优化器类型 / Optimizer kind.
pub(all) enum OptimizerKind {
  SGD
  Adam
} derive(Debug, Eq)

pub extend OptimizerKind with Eq::{equal, not_equal}
pub extend OptimizerKind with Debug::{to_repr}

/// 优化器状态 / Optimizer state.
pub struct OptimizerState {
  kind : OptimizerKind
  lr : Double
  params : Array[Double]
  velocity : Array[Double]
  step_count : Int
} derive(Debug, Eq)

pub extend OptimizerState with Eq::{equal, not_equal}
pub extend OptimizerState with Debug::{to_repr}

/// 构造优化器 / Build optimizer.
pub fn make_optimizer(kind : OptimizerKind, lr : Double, params : Array[Double]) -> OptimizerState {
  let n = params.length()
  let v : Array[Double] = []
  for _ in 0..<n {
    v.push(0.0)
  }
  { kind, lr, params, velocity: v, step_count: 0 }
}

/// SGD 单步 / SGD step.
///
/// new_params = params - lr * gradients.
pub fn sgd_step(state : OptimizerState, gradients : Array[Double]) -> Array[Double] {
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

/// Adam 单步（简化）/ Adam step (simplified).
///
/// 简化版：velocity = beta1 * velocity + (1 - beta1) * grad
///        new_params = params - lr * velocity
pub fn adam_step(state : OptimizerState, gradients : Array[Double]) -> Array[Double] {
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

/// 优化器单步 / Optimizer step.
pub fn optimizer_step(state : OptimizerState, gradients : Array[Double]) -> Array[Double] {
  match state.kind {
    SGD => sgd_step(state, gradients)
    Adam => adam_step(state, gradients)
  }
}

/// 更新优化器状态 / Update optimizer state after a step.
pub fn update_state(state : OptimizerState, new_params : Array[Double]) -> OptimizerState {
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
  { kind: state.kind, lr: state.lr, params: new_params, velocity: new_v, step_count: state.step_count + 1 }
}

/// 优化器名称 / Optimizer name.
pub fn optimizer_name(kind : OptimizerKind) -> String {
  match kind {
    SGD => "sgd"
    Adam => "adam"
  }
}

pub fn dl_optimizers_id() -> String {
  "learncore/dl_optimizers"
}