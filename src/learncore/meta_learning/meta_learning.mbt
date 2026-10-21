///|
/// # learncore/meta_learning 元学习 / Meta Learning
///
/// 元学习族：MAML、Reptile、Meta-SGD、FOMAML、ANIL、SNAIL、Prototypical、Matching、Relation Net 等。
///
/// # Meta Learning
///
/// MAML, Reptile, Meta-SGD, FOMAML, ANIL, SNAIL, Prototypical, Matching, Relation Net, etc.

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

fn sigmoid(x : Double) -> Double {
  1.0 / (1.0 + exp(-x))
}

fn tanh_d(x : Double) -> Double {
  let e1 = exp(x)
  let e2 = exp(-x)
  (e1 - e2) / (e1 + e2)
}

fn lcg_next(state : Int) -> Int {
  let a = 1103515245
  let c = 12345
  let m = 2147483647
  (a * state + c) % m
}

fn rand_double(seed : Int) -> Double {
  let s = lcg_next(seed)
  s.to_double() / 2147483647.0
}

/// MAML 配置 / MAML configuration.
pub struct MAMLConfig {
  inner_lr : Double
  outer_lr : Double
  num_inner_steps : Int
  meta_batch_size : Int
  seed : Int
} derive(Debug, Eq)

pub extend MAMLConfig with Eq::{equal, not_equal}
pub extend MAMLConfig with Debug::{to_repr}

/// Reptile 配置 / Reptile configuration.
pub struct ReptileConfig {
  inner_lr : Double
  outer_lr : Double
  num_inner_steps : Int
  meta_batch_size : Int
  seed : Int
} derive(Debug, Eq)

pub extend ReptileConfig with Eq::{equal, not_equal}
pub extend ReptileConfig with Debug::{to_repr}

/// Meta-SGD 配置 / Meta-SGD configuration.
pub struct MetaSGDConfig {
  alpha : Double
  beta : Double
  num_inner_steps : Int
  meta_batch_size : Int
  seed : Int
} derive(Debug, Eq)

pub extend MetaSGDConfig with Eq::{equal, not_equal}
pub extend MetaSGDConfig with Debug::{to_repr}

/// FOMAML 配置 / FOMAML configuration.
pub struct FOMAMLConfig {
  inner_lr : Double
  outer_lr : Double
  num_inner_steps : Int
  meta_batch_size : Int
  seed : Int
} derive(Debug, Eq)

pub extend FOMAMLConfig with Eq::{equal, not_equal}
pub extend FOMAMLConfig with Debug::{to_repr}

/// ANIL 配置 / ANIL configuration.
pub struct ANILConfig {
  inner_lr : Double
  outer_lr : Double
  num_inner_steps : Int
  meta_batch_size : Int
  seed : Int
} derive(Debug, Eq)

pub extend ANILConfig with Eq::{equal, not_equal}
pub extend ANILConfig with Debug::{to_repr}

/// Meta batch / Meta batch.
pub struct MetaBatch {
  tasks : Array[Task]
  batch_size : Int
} derive(Debug, Eq)

pub extend MetaBatch with Eq::{equal, not_equal}
pub extend MetaBatch with Debug::{to_repr}

/// 任务 / Task.
pub struct Task {
  train_x : Array[Array[Double]]
  train_y : Array[Double]
  test_x : Array[Array[Double]]
  test_y : Array[Double]
} derive(Debug, Eq)

pub extend Task with Eq::{equal, not_equal}
pub extend Task with Debug::{to_repr}

/// 任务分布 / Task distribution.
pub struct TaskDistribution {
  input_dim : Int
  output_dim : Int
  num_tasks : Int
  seed : Int
} derive(Debug, Eq)

pub extend TaskDistribution with Eq::{equal, not_equal}
pub extend TaskDistribution with Debug::{to_repr}

/// 学习器 / Learner.
pub struct Learner {
  weights : Array[Double]
  bias : Double
  input_dim : Int
} derive(Debug, Eq)

pub extend Learner with Eq::{equal, not_equal}
pub extend Learner with Debug::{to_repr}

/// 元优化器 / Meta optimizer.
pub struct MetaOptimizer {
  meta_lr : Double
  momentum : Double
  velocity : Array[Double]
} derive(Debug, Eq)

pub extend MetaOptimizer with Eq::{equal, not_equal}
pub extend MetaOptimizer with Debug::{to_repr}

/// 超网络 / Hyper network.
pub struct HyperNet {
  input_dim : Int
  output_dim : Int
  hidden_dim : Int
  weights : Array[Array[Double]]
} derive(Debug, Eq)

pub extend HyperNet with Eq::{equal, not_equal}
pub extend HyperNet with Debug::{to_repr}

/// 上下文网络 / Context network.
pub struct ContextNet {
  input_dim : Int
  context_dim : Int
  weights : Array[Array[Double]]
} derive(Debug, Eq)

pub extend ContextNet with Eq::{equal, not_equal}
pub extend ContextNet with Debug::{to_repr}

/// SNAIL 配置 / SNAIL configuration.
pub struct SNAILConfig {
  input_dim : Int
  hidden_dim : Int
  num_layers : Int
  seq_len : Int
  seed : Int
} derive(Debug, Eq)

pub extend SNAILConfig with Eq::{equal, not_equal}
pub extend SNAILConfig with Debug::{to_repr}

/// Prototypical 配置 / Prototypical configuration.
pub struct PrototypicalConfig {
  input_dim : Int
  num_classes : Int
  distance_metric : String
  seed : Int
} derive(Debug, Eq)

pub extend PrototypicalConfig with Eq::{equal, not_equal}
pub extend PrototypicalConfig with Debug::{to_repr}

/// Matching Net 配置 / Matching net configuration.
pub struct MatchingNetConfig {
  input_dim : Int
  embedding_dim : Int
  num_classes : Int
  seed : Int
} derive(Debug, Eq)

pub extend MatchingNetConfig with Eq::{equal, not_equal}
pub extend MatchingNetConfig with Debug::{to_repr}

/// Relation Net 配置 / Relation net configuration.
pub struct RelationNetConfig {
  input_dim : Int
  hidden_dim : Int
  num_classes : Int
  seed : Int
} derive(Debug, Eq)

pub extend RelationNetConfig with Eq::{equal, not_equal}
pub extend RelationNetConfig with Debug::{to_repr}

/// 构造 MAML / Build MAML.
pub fn make_maml(inner_lr : Double, outer_lr : Double, num_inner_steps : Int, meta_batch_size : Int, seed : Int) -> MAMLConfig {
  { inner_lr, outer_lr, num_inner_steps, meta_batch_size, seed }
}

/// MAML 内循环步 / MAML inner step.
pub fn maml_inner_step(config : MAMLConfig, learner : Learner, task : Task) -> Learner {
  let mut current = learner
  for _ in 0..<config.num_inner_steps {
    let grad = compute_gradient(current, task.train_x, task.train_y)
    let new_weights : Array[Double] = Array::make(current.weights.length(), 0.0)
    for i in 0..<current.weights.length() {
      new_weights[i] = current.weights[i] - config.inner_lr * grad[i]
    }
    let bias_grad = compute_bias_gradient(current, task.train_x, task.train_y)
    current = { weights: new_weights, bias: current.bias - config.inner_lr * bias_grad, input_dim: current.input_dim }
  }
  current
}

fn compute_gradient(learner : Learner, x : Array[Array[Double]], y : Array[Double]) -> Array[Double] {
  let n = x.length()
  let grad : Array[Double] = Array::make(learner.weights.length(), 0.0)
  if n == 0 || n != y.length() {
    return grad
  }
  for i in 0..<n {
    let pred = learner_predict(learner, x[i])
    let diff = pred - y[i]
    for j in 0..<learner.weights.length() {
      if j < x[i].length() {
        grad[j] = grad[j] + 2.0 * diff * x[i][j] / n.to_double()
      }
    }
  }
  grad
}

fn compute_bias_gradient(learner : Learner, x : Array[Array[Double]], y : Array[Double]) -> Double {
  let n = x.length()
  if n == 0 || n != y.length() {
    return 0.0
  }
  let mut grad = 0.0
  for i in 0..<n {
    let pred = learner_predict(learner, x[i])
    grad = grad + 2.0 * (pred - y[i]) / n.to_double()
  }
  grad
}

/// MAML 外循环步 / MAML outer step.
pub fn maml_outer_step(config : MAMLConfig, meta_learner : Learner, batch : MetaBatch) -> Learner {
  let total_grad : Array[Double] = Array::make(meta_learner.weights.length(), 0.0)
  let mut total_bias_grad = 0.0
  let num_tasks = batch.tasks.length()
  if num_tasks == 0 {
    return meta_learner
  }
  for t in 0..<num_tasks {
    let adapted = maml_inner_step(config, meta_learner, batch.tasks[t])
    let grad = compute_gradient(adapted, batch.tasks[t].test_x, batch.tasks[t].test_y)
    let bias_grad = compute_bias_gradient(adapted, batch.tasks[t].test_x, batch.tasks[t].test_y)
    for i in 0..<total_grad.length() {
      if i < grad.length() {
        total_grad[i] = total_grad[i] + grad[i] / num_tasks.to_double()
      }
    }
    total_bias_grad = total_bias_grad + bias_grad / num_tasks.to_double()
  }
  let new_weights : Array[Double] = Array::make(meta_learner.weights.length(), 0.0)
  for i in 0..<meta_learner.weights.length() {
    new_weights[i] = meta_learner.weights[i] - config.outer_lr * total_grad[i]
  }
  { weights: new_weights, bias: meta_learner.bias - config.outer_lr * total_bias_grad, input_dim: meta_learner.input_dim }
}

/// MAML 元损失 / MAML meta loss.
pub fn maml_meta_loss(config : MAMLConfig, meta_learner : Learner, batch : MetaBatch) -> Double {
  let num_tasks = batch.tasks.length()
  if num_tasks == 0 {
    return 0.0
  }
  let mut total_loss = 0.0
  for t in 0..<num_tasks {
    let adapted = maml_inner_step(config, meta_learner, batch.tasks[t])
    total_loss = total_loss + task_loss(adapted, batch.tasks[t].test_x, batch.tasks[t].test_y)
  }
  total_loss / num_tasks.to_double()
}

/// 构造 Reptile / Build Reptile.
pub fn make_reptile(inner_lr : Double, outer_lr : Double, num_inner_steps : Int, meta_batch_size : Int, seed : Int) -> ReptileConfig {
  { inner_lr, outer_lr, num_inner_steps, meta_batch_size, seed }
}

/// Reptile 内循环步 / Reptile inner step.
pub fn reptile_inner_step(config : ReptileConfig, learner : Learner, task : Task) -> Learner {
  let mut current = learner
  for _ in 0..<config.num_inner_steps {
    let grad = compute_gradient(current, task.train_x, task.train_y)
    let bias_grad = compute_bias_gradient(current, task.train_x, task.train_y)
    let new_weights : Array[Double] = Array::make(current.weights.length(), 0.0)
    for i in 0..<current.weights.length() {
      new_weights[i] = current.weights[i] - config.inner_lr * grad[i]
    }
    current = { weights: new_weights, bias: current.bias - config.inner_lr * bias_grad, input_dim: current.input_dim }
  }
  current
}

/// Reptile 外循环步 / Reptile outer step.
pub fn reptile_outer_step(config : ReptileConfig, meta_learner : Learner, batch : MetaBatch) -> Learner {
  let num_tasks = batch.tasks.length()
  if num_tasks == 0 {
    return meta_learner
  }
  let avg_weights : Array[Double] = Array::make(meta_learner.weights.length(), 0.0)
  let mut avg_bias = 0.0
  for t in 0..<num_tasks {
    let adapted = reptile_inner_step(config, meta_learner, batch.tasks[t])
    for i in 0..<avg_weights.length() {
      if i < adapted.weights.length() {
        avg_weights[i] = avg_weights[i] + adapted.weights[i] / num_tasks.to_double()
      }
    }
    avg_bias = avg_bias + adapted.bias / num_tasks.to_double()
  }
  let new_weights : Array[Double] = Array::make(meta_learner.weights.length(), 0.0)
  for i in 0..<meta_learner.weights.length() {
    new_weights[i] = meta_learner.weights[i] + config.outer_lr * (avg_weights[i] - meta_learner.weights[i])
  }
  { weights: new_weights, bias: meta_learner.bias + config.outer_lr * (avg_bias - meta_learner.bias), input_dim: meta_learner.input_dim }
}

/// 构造 Meta-SGD / Build Meta-SGD.
pub fn make_meta_sgd(alpha : Double, beta : Double, num_inner_steps : Int, meta_batch_size : Int, seed : Int) -> MetaSGDConfig {
  { alpha, beta, num_inner_steps, meta_batch_size, seed }
}

/// Meta-SGD 步 / Meta-SGD step.
pub fn meta_sgd_step(config : MetaSGDConfig, learner : Learner, alpha_params : Array[Double], task : Task) -> Learner {
  let mut current = learner
  for _ in 0..<config.num_inner_steps {
    let grad = compute_gradient(current, task.train_x, task.train_y)
    let bias_grad = compute_bias_gradient(current, task.train_x, task.train_y)
    let new_weights : Array[Double] = Array::make(current.weights.length(), 0.0)
    for i in 0..<current.weights.length() {
      let a = if i < alpha_params.length() { alpha_params[i] } else { config.alpha }
      new_weights[i] = current.weights[i] - a * grad[i]
    }
    current = { weights: new_weights, bias: current.bias - config.alpha * bias_grad, input_dim: current.input_dim }
  }
  current
}

/// Meta-SGD 适配 / Meta-SGD adapt.
pub fn meta_sgd_adapt(config : MetaSGDConfig, learner : Learner, alpha_params : Array[Double], task : Task) -> (Learner, Array[Double]) {
  let adapted = meta_sgd_step(config, learner, alpha_params, task)
  let grad = compute_gradient(adapted, task.test_x, task.test_y)
  let new_alpha : Array[Double] = Array::make(alpha_params.length(), 0.0)
  for i in 0..<alpha_params.length() {
    let g = if i < grad.length() { grad[i] } else { 0.0 }
    new_alpha[i] = alpha_params[i] - config.beta * g
  }
  (adapted, new_alpha)
}

/// 构造 FOMAML / Build FOMAML.
pub fn make_fomaml(inner_lr : Double, outer_lr : Double, num_inner_steps : Int, meta_batch_size : Int, seed : Int) -> FOMAMLConfig {
  { inner_lr, outer_lr, num_inner_steps, meta_batch_size, seed }
}

/// FOMAML 步 / FOMAML step.
pub fn fomaml_step(config : FOMAMLConfig, learner : Learner, task : Task) -> Learner {
  let mut current = learner
  for _ in 0..<config.num_inner_steps {
    let grad = compute_gradient(current, task.train_x, task.train_y)
    let bias_grad = compute_bias_gradient(current, task.train_x, task.train_y)
    let new_weights : Array[Double] = Array::make(current.weights.length(), 0.0)
    for i in 0..<current.weights.length() {
      new_weights[i] = current.weights[i] - config.inner_lr * grad[i]
    }
    current = { weights: new_weights, bias: current.bias - config.inner_lr * bias_grad, input_dim: current.input_dim }
  }
  current
}

/// FOMAML 近似 / FOMAML approximation.
pub fn fomaml_approx(config : FOMAMLConfig, meta_learner : Learner, batch : MetaBatch) -> Learner {
  let num_tasks = batch.tasks.length()
  if num_tasks == 0 {
    return meta_learner
  }
  let total_grad : Array[Double] = Array::make(meta_learner.weights.length(), 0.0)
  let mut total_bias_grad = 0.0
  for t in 0..<num_tasks {
    let adapted = fomaml_step(config, meta_learner, batch.tasks[t])
    let grad = compute_gradient(adapted, batch.tasks[t].test_x, batch.tasks[t].test_y)
    let bias_grad = compute_bias_gradient(adapted, batch.tasks[t].test_x, batch.tasks[t].test_y)
    for i in 0..<total_grad.length() {
      if i < grad.length() {
        total_grad[i] = total_grad[i] + grad[i] / num_tasks.to_double()
      }
    }
    total_bias_grad = total_bias_grad + bias_grad / num_tasks.to_double()
  }
  let new_weights : Array[Double] = Array::make(meta_learner.weights.length(), 0.0)
  for i in 0..<meta_learner.weights.length() {
    new_weights[i] = meta_learner.weights[i] - config.outer_lr * total_grad[i]
  }
  { weights: new_weights, bias: meta_learner.bias - config.outer_lr * total_bias_grad, input_dim: meta_learner.input_dim }
}

/// 构造 ANIL / Build ANIL.
pub fn make_anil(inner_lr : Double, outer_lr : Double, num_inner_steps : Int, meta_batch_size : Int, seed : Int) -> ANILConfig {
  { inner_lr, outer_lr, num_inner_steps, meta_batch_size, seed }
}

/// ANIL 步 / ANIL step.
pub fn anil_step(config : ANILConfig, learner : Learner, task : Task) -> Learner {
  let mut current = learner
  for _ in 0..<config.num_inner_steps {
    let bias_grad = compute_bias_gradient(current, task.train_x, task.train_y)
    current = { weights: current.weights, bias: current.bias - config.inner_lr * bias_grad, input_dim: current.input_dim }
  }
  current
}

/// ANIL 仅 head / ANIL head only.
pub fn anil_head_only(config : ANILConfig, meta_learner : Learner, batch : MetaBatch) -> Learner {
  let num_tasks = batch.tasks.length()
  if num_tasks == 0 {
    return meta_learner
  }
  let mut total_bias_grad = 0.0
  for t in 0..<num_tasks {
    let adapted = anil_step(config, meta_learner, batch.tasks[t])
    let bias_grad = compute_bias_gradient(adapted, batch.tasks[t].test_x, batch.tasks[t].test_y)
    total_bias_grad = total_bias_grad + bias_grad / num_tasks.to_double()
  }
  { weights: meta_learner.weights, bias: meta_learner.bias - config.outer_lr * total_bias_grad, input_dim: meta_learner.input_dim }
}

/// 构造 Meta batch / Build meta batch.
pub fn make_meta_batch(tasks : Array[Task], batch_size : Int) -> MetaBatch {
  { tasks, batch_size }
}

/// 采样任务 / Sample tasks.
pub fn sample_tasks(dist : TaskDistribution, num_tasks : Int) -> Array[Task] {
  let result : Array[Task] = []
  for t in 0..<num_tasks {
    let task = sample_task(dist, dist.seed + t * 31)
    result.push(task)
  }
  result
}

/// 任务 batch / Task batch.
pub fn task_batch(dist : TaskDistribution, batch_size : Int) -> MetaBatch {
  let tasks = sample_tasks(dist, batch_size)
  { tasks, batch_size }
}

/// 构造任务分布 / Build task distribution.
pub fn make_task_distribution(input_dim : Int, output_dim : Int, num_tasks : Int, seed : Int) -> TaskDistribution {
  { input_dim, output_dim, num_tasks, seed }
}

/// 采样单个任务 / Sample single task.
pub fn sample_task(dist : TaskDistribution, seed : Int) -> Task {
  let num_train = 5
  let num_test = 5
  let train_x : Array[Array[Double]] = []
  let train_y : Array[Double] = []
  let test_x : Array[Array[Double]] = []
  let test_y : Array[Double] = []
  let w : Array[Double] = Array::make(dist.input_dim, 0.0)
  for i in 0..<dist.input_dim {
    w[i] = rand_double(seed + i) * 2.0 - 1.0
  }
  let b = rand_double(seed + 100) * 0.5
  for _ in 0..<num_train {
    let x : Array[Double] = Array::make(dist.input_dim, 0.0)
    for i in 0..<dist.input_dim {
      x[i] = rand_double(seed + train_x.length() * 10 + i) * 2.0 - 1.0
    }
    let mut y = b
    for i in 0..<dist.input_dim {
      y = y + w[i] * x[i]
    }
    train_x.push(x)
    train_y.push(y)
  }
  for _ in 0..<num_test {
    let x : Array[Double] = Array::make(dist.input_dim, 0.0)
    for i in 0..<dist.input_dim {
      x[i] = rand_double(seed + 500 + test_x.length() * 10 + i) * 2.0 - 1.0
    }
    let mut y = b
    for i in 0..<dist.input_dim {
      y = y + w[i] * x[i]
    }
    test_x.push(x)
    test_y.push(y)
  }
  { train_x, train_y, test_x, test_y }
}

/// 任务损失 / Task loss.
pub fn task_loss(learner : Learner, x : Array[Array[Double]], y : Array[Double]) -> Double {
  let n = x.length()
  if n == 0 || n != y.length() {
    return 0.0
  }
  let mut loss = 0.0
  for i in 0..<n {
    let pred = learner_predict(learner, x[i])
    let d = pred - y[i]
    loss = loss + d * d
  }
  loss / n.to_double()
}

/// 构造学习器 / Build learner.
pub fn make_learner(input_dim : Int, seed : Int) -> Learner {
  let weights : Array[Double] = Array::make(input_dim, 0.0)
  for i in 0..<input_dim {
    weights[i] = rand_double(seed + i) * 0.1
  }
  { weights, bias: rand_double(seed + 100) * 0.1, input_dim }
}

/// 学习器预测 / Learner predict.
pub fn learner_predict(learner : Learner, x : Array[Double]) -> Double {
  let mut sum = learner.bias
  for i in 0..<learner.weights.length() {
    if i < x.length() {
      sum = sum + learner.weights[i] * x[i]
    }
  }
  sum
}

/// 学习器适配 / Learner adapt.
pub fn learner_adapt(learner : Learner, task : Task, lr : Double, num_steps : Int) -> Learner {
  let mut current = learner
  for _ in 0..<num_steps {
    let grad = compute_gradient(current, task.train_x, task.train_y)
    let bias_grad = compute_bias_gradient(current, task.train_x, task.train_y)
    let new_weights : Array[Double] = Array::make(current.weights.length(), 0.0)
    for i in 0..<current.weights.length() {
      new_weights[i] = current.weights[i] - lr * grad[i]
    }
    current = { weights: new_weights, bias: current.bias - lr * bias_grad, input_dim: current.input_dim }
  }
  current
}

/// 构造元优化器 / Build meta optimizer.
pub fn make_meta_optimizer(meta_lr : Double, momentum : Double, param_size : Int) -> MetaOptimizer {
  { meta_lr, momentum, velocity: Array::make(param_size, 0.0) }
}

/// 元优化 / Meta optimize.
pub fn meta_optimize(opt : MetaOptimizer, params : Array[Double], grads : Array[Double]) -> (Array[Double], MetaOptimizer) {
  let n = params.length()
  if n == 0 || n != grads.length() {
    return (params, opt)
  }
  let new_velocity : Array[Double] = Array::make(n, 0.0)
  let new_params : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    new_velocity[i] = opt.momentum * opt.velocity[i] - opt.meta_lr * grads[i]
    new_params[i] = params[i] + new_velocity[i]
  }
  (new_params, { meta_lr: opt.meta_lr, momentum: opt.momentum, velocity: new_velocity })
}

/// 元学习率 / Meta learning rate.
pub fn meta_lr(opt : MetaOptimizer) -> Double {
  opt.meta_lr
}

/// 构造超网络 / Build hyper network.
pub fn make_hyper_net(input_dim : Int, output_dim : Int, hidden_dim : Int, seed : Int) -> HyperNet {
  let weights : Array[Array[Double]] = Array::make(2, [])
  let w1_size = hidden_dim * input_dim
  let w1 : Array[Double] = Array::make(w1_size, 0.0)
  for i in 0..<w1_size {
    w1[i] = rand_double(seed + i) * 0.1
  }
  let w2_size = output_dim * hidden_dim
  let w2 : Array[Double] = Array::make(w2_size, 0.0)
  for i in 0..<w2_size {
    w2[i] = rand_double(seed + 1000 + i) * 0.1
  }
  weights[0] = w1
  weights[1] = w2
  { input_dim, output_dim, hidden_dim, weights }
}

/// 超网络前向 / Hyper net forward.
pub fn hyper_net_forward(net : HyperNet, input : Array[Double]) -> Array[Double] {
  let hidden : Array[Double] = Array::make(net.hidden_dim, 0.0)
  for i in 0..<net.hidden_dim {
    let mut sum = 0.0
    for j in 0..<net.input_dim {
      if j < input.length() {
        let idx = i * net.input_dim + j
        if idx < net.weights[0].length() {
          sum = sum + net.weights[0][idx] * input[j]
        }
      }
    }
    hidden[i] = tanh_d(sum)
  }
  let result : Array[Double] = Array::make(net.output_dim, 0.0)
  for i in 0..<net.output_dim {
    let mut sum = 0.0
    for j in 0..<net.hidden_dim {
      let idx = i * net.hidden_dim + j
      if idx < net.weights[1].length() {
        sum = sum + net.weights[1][idx] * hidden[j]
      }
    }
    result[i] = sum
  }
  result
}

/// 超网络生成权重 / Hyper net weights.
pub fn hyper_net_weights(net : HyperNet, z : Array[Double]) -> Array[Double] {
  hyper_net_forward(net, z)
}

/// 构造上下文网络 / Build context network.
pub fn make_context_net(input_dim : Int, context_dim : Int, seed : Int) -> ContextNet {
  let weights : Array[Array[Double]] = Array::make(context_dim, Array::make(input_dim, 0.0))
  for i in 0..<context_dim {
    for j in 0..<input_dim {
      weights[i][j] = rand_double(seed + i * input_dim + j) * 0.1
    }
  }
  { input_dim, context_dim, weights }
}

/// 上下文编码 / Context encode.
pub fn context_encode(net : ContextNet, support_x : Array[Array[Double]]) -> Array[Double] {
  let n = support_x.length()
  if n == 0 {
    return Array::make(net.context_dim, 0.0)
  }
  let mean : Array[Double] = Array::make(net.input_dim, 0.0)
  for i in 0..<n {
    for d in 0..<net.input_dim {
      if d < support_x[i].length() {
        mean[d] = mean[d] + support_x[i][d] / n.to_double()
      }
    }
  }
  let result : Array[Double] = Array::make(net.context_dim, 0.0)
  for i in 0..<net.context_dim {
    let mut sum = 0.0
    for j in 0..<net.input_dim {
      sum = sum + net.weights[i][j] * mean[j]
    }
    result[i] = tanh_d(sum)
  }
  result
}

/// 上下文适配 / Context adapt.
pub fn context_adapt(net : ContextNet, support_x : Array[Array[Double]], query_x : Array[Double]) -> Array[Double] {
  let context = context_encode(net, support_x)
  let n = query_x.length()
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let mut sum = 0.0
    if i < context.length() {
      sum = sum + context[i]
    }
    sum = sum + query_x[i]
    result[i] = sum
  }
  result
}

/// 构造 SNAIL / Build SNAIL.
pub fn make_snail(input_dim : Int, hidden_dim : Int, num_layers : Int, seq_len : Int, seed : Int) -> SNAILConfig {
  { input_dim, hidden_dim, num_layers, seq_len, seed }
}

/// SNAIL 前向 / SNAIL forward.
pub fn snail_forward(config : SNAILConfig, seq : Array[Array[Double]]) -> Array[Double] {
  let n = seq.length()
  if n == 0 {
    return []
  }
  let mut current = seq
  for _ in 0..<config.num_layers {
    let next : Array[Array[Double]] = []
    for i in 0..<n {
      let out : Array[Double] = Array::make(config.hidden_dim, 0.0)
      for j in 0..<config.hidden_dim {
        let mut sum = 0.0
        for k in 0..<config.input_dim {
          if k < current[i].length() {
            sum = sum + current[i][k] * 0.1
          }
        }
        out[j] = tanh_d(sum)
      }
      next.push(out)
    }
    current = next
  }
  let result : Array[Double] = Array::make(config.hidden_dim, 0.0)
  if n > 0 && current[0].length() >= config.hidden_dim {
    for j in 0..<config.hidden_dim {
      result[j] = current[0][j]
    }
  }
  result
}

/// SNAIL 因果卷积 / SNAIL causal conv.
pub fn snail_causal_conv(config : SNAILConfig, seq : Array[Array[Double]], kernel_size : Int) -> Array[Array[Double]] {
  let n = seq.length()
  if n == 0 {
    return []
  }
  let result : Array[Array[Double]] = []
  for i in 0..<n {
    let out : Array[Double] = Array::make(config.hidden_dim, 0.0)
    for j in 0..<config.hidden_dim {
      let mut sum = 0.0
      for k in 0..<kernel_size {
        let idx = i - k
        if idx >= 0 && idx < n && j < seq[idx].length() {
          sum = sum + seq[idx][j] * 0.1
        }
      }
      out[j] = tanh_d(sum)
    }
    result.push(out)
  }
  result
}

/// 构造 Prototypical / Build prototypical.
pub fn make_prototypical(input_dim : Int, num_classes : Int, distance_metric : String, seed : Int) -> PrototypicalConfig {
  { input_dim, num_classes, distance_metric, seed }
}

/// 原型均值 / Proto means.
pub fn proto_means(config : PrototypicalConfig, support_x : Array[Array[Double]], support_y : Array[Int]) -> Array[Array[Double]] {
  let means : Array[Array[Double]] = Array::make(config.num_classes, Array::make(config.input_dim, 0.0))
  let counts : Array[Int] = Array::make(config.num_classes, 0)
  let n = support_x.length()
  for i in 0..<n {
    if i < support_y.length() {
      let c = support_y[i]
      if c >= 0 && c < config.num_classes {
        counts[c] = counts[c] + 1
        for d in 0..<config.input_dim {
          if d < support_x[i].length() {
            means[c][d] = means[c][d] + support_x[i][d]
          }
        }
      }
    }
  }
  for c in 0..<config.num_classes {
    if counts[c] > 0 {
      for d in 0..<config.input_dim {
        means[c][d] = means[c][d] / counts[c].to_double()
      }
    }
  }
  means
}

/// 原型距离 / Proto distance.
pub fn proto_distance(config : PrototypicalConfig, x : Array[Double], mean : Array[Double]) -> Double {
  let n = x.length()
  if n == 0 || n != mean.length() {
    return 0.0
  }
  let mut dist = 0.0
  for i in 0..<n {
    let d = x[i] - mean[i]
    dist = dist + d * d
  }
  if config.distance_metric == "cosine" {
    let mut dot = 0.0
    let mut nx = 0.0
    let mut nm = 0.0
    for i in 0..<n {
      dot = dot + x[i] * mean[i]
      nx = nx + x[i] * x[i]
      nm = nm + mean[i] * mean[i]
    }
    if nx > 0.0 && nm > 0.0 {
      1.0 - dot / (sqrt(nx) * sqrt(nm))
    } else {
      dist
    }
  } else {
    dist
  }
}

/// 原型分类 / Proto classify.
pub fn proto_classify(config : PrototypicalConfig, means : Array[Array[Double]], query : Array[Double]) -> Int {
  let mut best_class = 0
  let mut best_dist = 1000000000.0
  for c in 0..<config.num_classes {
    if c < means.length() {
      let d = proto_distance(config, query, means[c])
      if d < best_dist {
        best_dist = d
        best_class = c
      }
    }
  }
  best_class
}

/// 构造 Matching Net / Build matching net.
pub fn make_matching_net(input_dim : Int, embedding_dim : Int, num_classes : Int, seed : Int) -> MatchingNetConfig {
  { input_dim, embedding_dim, num_classes, seed }
}

/// Matching Net 前向 / Matching net forward.
pub fn matching_forward(config : MatchingNetConfig, support_x : Array[Array[Double]], support_y : Array[Int], query : Array[Double]) -> Int {
  let n = support_x.length()
  if n == 0 {
    return 0
  }
  let mut best_idx = 0
  let mut best_sim = -1000000000.0
  for i in 0..<n {
    let mut sim = 0.0
    for d in 0..<config.input_dim {
      if d < support_x[i].length() && d < query.length() {
        sim = sim + support_x[i][d] * query[d]
      }
    }
    if sim > best_sim {
      best_sim = sim
      best_idx = i
    }
  }
  if best_idx < support_y.length() {
    support_y[best_idx]
  } else {
    0
  }
}

/// Matching 注意力 / Matching attention.
pub fn matching_attention(config : MatchingNetConfig, support_x : Array[Array[Double]], query : Array[Double]) -> Array[Double] {
  let n = support_x.length()
  if n == 0 {
    return []
  }
  let sims : Array[Double] = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n {
    let mut sim = 0.0
    for d in 0..<config.input_dim {
      if d < support_x[i].length() && d < query.length() {
        sim = sim + support_x[i][d] * query[d]
      }
    }
    sims[i] = exp(sim)
    total = total + sims[i]
  }
  if total > 0.0 {
    for i in 0..<n {
      sims[i] = sims[i] / total
    }
  }
  sims
}

/// 构造 Relation Net / Build relation net.
pub fn make_relation_net(input_dim : Int, hidden_dim : Int, num_classes : Int, seed : Int) -> RelationNetConfig {
  { input_dim, hidden_dim, num_classes, seed }
}

/// Relation Net 前向 / Relation net forward.
pub fn relation_forward(config : RelationNetConfig, support_x : Array[Array[Double]], support_y : Array[Int], query : Array[Double]) -> Int {
  let n = support_x.length()
  if n == 0 {
    return 0
  }
  let mut best_idx = 0
  let mut best_score = -1000000000.0
  for i in 0..<n {
    let score = relation_score(config, support_x[i], query)
    if score > best_score {
      best_score = score
      best_idx = i
    }
  }
  if best_idx < support_y.length() {
    support_y[best_idx]
  } else {
    0
  }
}

/// Relation 得分 / Relation score.
pub fn relation_score(config : RelationNetConfig, x1 : Array[Double], x2 : Array[Double]) -> Double {
  let concat : Array[Double] = []
  for i in 0..<config.input_dim {
    if i < x1.length() {
      concat.push(x1[i])
    } else {
      concat.push(0.0)
    }
  }
  for i in 0..<config.input_dim {
    if i < x2.length() {
      concat.push(x2[i])
    } else {
      concat.push(0.0)
    }
  }
  let hidden : Array[Double] = Array::make(config.hidden_dim, 0.0)
  for i in 0..<config.hidden_dim {
    let mut sum = 0.0
    for j in 0..<concat.length() {
      sum = sum + concat[j] * 0.1
    }
    hidden[i] = tanh_d(sum)
  }
  let mut score = 0.0
  for i in 0..<config.hidden_dim {
    score = score + hidden[i]
  }
  sigmoid(score / config.hidden_dim.to_double())
}

/// Few-shot 训练 / Few-shot train.
pub fn few_shot_train(learner : Learner, support_x : Array[Array[Double]], support_y : Array[Double], lr : Double, num_steps : Int) -> Learner {
  let task = { train_x: support_x, train_y: support_y, test_x: [], test_y: [] }
  learner_adapt(learner, task, lr, num_steps)
}

/// Few-shot 预测 / Few-shot predict.
pub fn few_shot_predict(learner : Learner, query : Array[Array[Double]]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<query.length() {
    result.push(learner_predict(learner, query[i]))
  }
  result
}

/// Few-shot 评估 / Few-shot evaluate.
pub fn few_shot_predict_eval(learner : Learner, query_x : Array[Array[Double]], query_y : Array[Double]) -> Double {
  let n = query_x.length()
  if n == 0 || n != query_y.length() {
    return 0.0
  }
  let mut loss = 0.0
  for i in 0..<n {
    let pred = learner_predict(learner, query_x[i])
    let d = pred - query_y[i]
    loss = loss + d * d
  }
  loss / n.to_double()
}

/// 元测试 / Meta test.
pub fn meta_test(config : MAMLConfig, meta_learner : Learner, test_batch : MetaBatch) -> Double {
  let num_tasks = test_batch.tasks.length()
  if num_tasks == 0 {
    return 0.0
  }
  let mut total_loss = 0.0
  for t in 0..<num_tasks {
    let adapted = maml_inner_step(config, meta_learner, test_batch.tasks[t])
    total_loss = total_loss + task_loss(adapted, test_batch.tasks[t].test_x, test_batch.tasks[t].test_y)
  }
  total_loss / num_tasks.to_double()
}

/// 元训练 / Meta train.
pub fn meta_train(config : MAMLConfig, meta_learner : Learner, train_batch : MetaBatch, num_epochs : Int) -> Learner {
  let mut current = meta_learner
  for _ in 0..<num_epochs {
    current = maml_outer_step(config, current, train_batch)
  }
  current
}

/// 元验证 / Meta validate.
pub fn meta_validate(config : MAMLConfig, meta_learner : Learner, val_batch : MetaBatch) -> Double {
  meta_test(config, meta_learner, val_batch)
}

/// 模块标识 / Module identifier.
pub fn meta_learning_id() -> String {
  "learncore/meta_learning"
}