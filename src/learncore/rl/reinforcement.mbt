///|
/// # learncore/reinforcement 强化学习算子 / Reinforcement Learning Operators
///
/// RL 算子契约 + 简化实现。架构 §4.3.5 learncore 扩展。
/// S7.6 新建：Q-Learning/PolicyGradient/ActorCritic/DQN/DDPG/A2C/PPO。
///
/// # RL operators

///===
/// Q-Learning

///|
/// Q 表更新 / Q-table update.
/// Q(s,a) <- Q(s,a) + alpha * (r + gamma * max_a' Q(s',a') - Q(s,a))
pub fn reinforcement_q_learning_update(
  q_value : Double,
  reward : Double,
  max_next_q : Double,
  alpha : Double,
  gamma : Double,
) -> Double {
  q_value + alpha * (reward + gamma * max_next_q - q_value)
}

///|
/// Q 表一步 / Q-table single step.
pub fn reinforcement_q_table_step(
  q_table : Array[Array[Double]],
  state : Int32,
  action : Int32,
  reward : Double,
  next_state : Int32,
  alpha : Double,
  gamma : Double,
) -> Array[Array[Double]] {
  let n_states = q_table.length()
  if state < 0 || state >= n_states || next_state < 0 || next_state >= n_states {
    return q_table
  }
  let n_actions = q_table[state].length()
  if action < 0 || action >= n_actions {
    return q_table
  }
  let mut max_next_q = 0.0
  if next_state < q_table.length() {
    for a in 0..<q_table[next_state].length() {
      if q_table[next_state][a] > max_next_q {
        max_next_q = q_table[next_state][a]
      }
    }
  }
  let result : Array[Array[Double]] = []
  for i in 0..<n_states {
    let row : Array[Double] = []
    for j in 0..<q_table[i].length() {
      if i == state && j == action {
        row.push(
          reinforcement_q_learning_update(q_table[i][j], reward, max_next_q, alpha, gamma),
        )
      } else {
        row.push(q_table[i][j])
      }
    }
    result.push(row)
  }
  result
}

///|
/// epsilon-贪心选择 / Epsilon-greedy action selection.
pub fn reinforcement_epsilon_greedy(q_values : Array[Double], epsilon : Double) -> Int32 {
  let n = q_values.length()
  if n == 0 {
    return 0
  }
  let random_val = 0.5
  if random_val < epsilon {
    0
  } else {
    let mut best = 0
    for i in 1..<n {
      if q_values[i] > q_values[best] {
        best = i
      }
    }
    best
  }
}

///===
/// SARSA

///|
/// SARSA 更新 / SARSA update.
/// Q(s,a) <- Q(s,a) + alpha * (r + gamma * Q(s',a') - Q(s,a))
pub fn reinforcement_sarsa_update(
  q_value : Double,
  reward : Double,
  next_q : Double,
  alpha : Double,
  gamma : Double,
) -> Double {
  q_value + alpha * (reward + gamma * next_q - q_value)
}

///===
/// 策略梯度

///|
/// 策略梯度更新 / Policy gradient update.
/// theta <- theta + alpha * grad_log_prob * advantage
pub fn reinforcement_policy_gradient_update(
  theta : Array[Double],
  grad_log_prob : Array[Double],
  advantage : Double,
  alpha : Double,
) -> Array[Double] {
  let n = if theta.length() < grad_log_prob.length() {
    theta.length()
  } else {
    grad_log_prob.length()
  }
  let result : Array[Double] = Array::make(theta.length(), 0.0)
  for i in 0..<theta.length() {
    if i < n {
      result[i] = theta[i] + alpha * grad_log_prob[i] * advantage
    } else {
      result[i] = theta[i]
    }
  }
  result
}

///|
/// 优势函数 / Advantage function (A = Q - V).
pub fn reinforcement_advantage(q_value : Double, value : Double) -> Double {
  q_value - value
}

///|
/// 广义优势估计 / Generalized Advantage Estimation (GAE, simplified).
pub fn reinforcement_gae(
  rewards : Array[Double],
  values : Array[Double],
  gamma : Double,
  lambda : Double,
) -> Array[Double] {
  let n = rewards.length()
  if n == 0 {
    return []
  }
  let deltas : Array[Double] = []
  for i in 0..<n {
    let v_next = if i + 1 < values.length() { values[i + 1] } else { 0.0 }
    deltas.push(rewards[i] + gamma * v_next - values[i])
  }
  let advantages : Array[Double] = Array::make(n, 0.0)
  let mut gae_val = 0.0
  let mut i = n - 1
  while i >= 0 {
    gae_val = deltas[i] + gamma * lambda * gae_val
    advantages[i] = gae_val
    i = i - 1
  }
  advantages
}

///===
/// Actor-Critic

///|
/// Actor-Critic 配置 / Actor-Critic config.
pub struct ActorCriticConfig {
  actor_lr : Double
  critic_lr : Double
  gamma : Double
}

///|
/// 构造 Actor-Critic 配置 / Create Actor-Critic config.
pub fn reinforcement_make_actor_critic_config(
  actor_lr : Double,
  critic_lr : Double,
  gamma : Double,
) -> ActorCriticConfig {
  { actor_lr, critic_lr, gamma, }
}

///|
/// Critic 更新 / Critic (value) update.
/// V(s) <- V(s) + alpha * delta
/// delta = r + gamma * V(s') - V(s)
pub fn reinforcement_critic_update(
  value : Double,
  reward : Double,
  next_value : Double,
  config : ActorCriticConfig,
) -> (Double, Double) {
  let delta = reward + config.gamma * next_value - value
  (value + config.critic_lr * delta, delta)
}

///|
/// Actor 更新 / Actor update.
pub fn reinforcement_actor_update(
  theta : Array[Double],
  grad_log_prob : Array[Double],
  delta : Double,
  config : ActorCriticConfig,
) -> Array[Double] {
  reinforcement_policy_gradient_update(theta, grad_log_prob, delta, config.actor_lr)
}

///===
/// DQN

///|
/// DQN 经验回放 / DQN experience replay buffer.
pub struct ExperienceReplay {
  capacity : Int32
  buffer : Array[(Array[Double], Int32, Double, Array[Double], Bool)]
}

///|
/// 构造经验回放 / Create experience replay.
pub fn reinforcement_make_experience_replay(capacity : Int32) -> ExperienceReplay {
  { capacity, buffer: [], }
}

///|
/// 添加经验 / Add experience.
pub fn reinforcement_add_experience(
  replay : ExperienceReplay,
  state : Array[Double],
  action : Int32,
  reward : Double,
  next_state : Array[Double],
  done : Bool,
) -> ExperienceReplay {
  let new_buffer : Array[(Array[Double], Int32, Double, Array[Double], Bool)] = []
  for i in 0..<replay.buffer.length() {
    new_buffer.push(replay.buffer[i])
  }
  new_buffer.push((state, action, reward, next_state, done))
  let result = if new_buffer.length() > replay.capacity {
    let trimmed : Array[(Array[Double], Int32, Double, Array[Double], Bool)] = []
    let start = new_buffer.length() - replay.capacity
    for i in start..<new_buffer.length() {
      trimmed.push(new_buffer[i])
    }
    trimmed
  } else {
    new_buffer
  }
  { capacity: replay.capacity, buffer: result, }
}

///|
/// 经验回放大小 / Replay buffer size.
pub fn reinforcement_replay_size(replay : ExperienceReplay) -> Int32 {
  replay.buffer.length()
}

///===
/// DDPG

///|
/// DDPG 软更新 / DDPG soft update.
/// target <- tau * source + (1 - tau) * target
pub fn reinforcement_soft_update(
  target_params : Array[Double],
  source_params : Array[Double],
  tau : Double,
) -> Array[Double] {
  let n = if target_params.length() < source_params.length() {
    target_params.length()
  } else {
    source_params.length()
  }
  let result : Array[Double] = Array::make(target_params.length(), 0.0)
  for i in 0..<target_params.length() {
    if i < n {
      result[i] = tau * source_params[i] + (1.0 - tau) * target_params[i]
    } else {
      result[i] = target_params[i]
    }
  }
  result
}

///===
/// PPO

///|
/// PPO 截断目标 / PPO clipped objective.
/// L = min(ratio * A, clip(ratio, 1-eps, 1+eps) * A)
pub fn reinforcement_ppo_clipped_loss(
  ratio : Double,
  advantage_val : Double,
  epsilon : Double,
) -> Double {
  let clipped_ratio = if ratio < 1.0 - epsilon {
    1.0 - epsilon
  } else if ratio > 1.0 + epsilon {
    1.0 + epsilon
  } else {
    ratio
  }
  let unclipped = ratio * advantage_val
  let clipped = clipped_ratio * advantage_val
  if unclipped < clipped {
    unclipped
  } else {
    clipped
  }
}

///|
/// PPO 策略更新 / PPO policy update (simplified).
pub fn reinforcement_ppo_update(
  theta : Array[Double],
  grad_log_prob : Array[Double],
  advantage_val : Double,
  ratio : Double,
  epsilon : Double,
  lr : Double,
) -> Array[Double] {
  let loss = reinforcement_ppo_clipped_loss(ratio, advantage_val, epsilon)
  let result : Array[Double] = Array::make(theta.length(), 0.0)
  for i in 0..<theta.length() {
    if i < grad_log_prob.length() {
      result[i] = theta[i] + lr * grad_log_prob[i] * loss
    } else {
      result[i] = theta[i]
    }
  }
  result
}

///===
/// 奖励

///|
/// 折扣累积奖励 / Discounted cumulative reward.
/// R = sum(gamma^t * r_t)
pub fn reinforcement_discounted_return(rewards : Array[Double], gamma : Double) -> Double {
  let mut total = 0.0
  let mut discount = 1.0
  for i in 0..<rewards.length() {
    total = total + discount * rewards[i]
    discount = discount * gamma
  }
  total
}

///|
/// 奖励归一化 / Reward normalization.
pub fn reinforcement_normalize_rewards(rewards : Array[Double]) -> Array[Double] {
  let n = rewards.length()
  if n == 0 {
    return []
  }
  let mut mean = 0.0
  for i in 0..<n {
    mean = mean + rewards[i]
  }
  mean = mean / n.to_double()
  let mut variance = 0.0
  for i in 0..<n {
    let d = rewards[i] - mean
    variance = variance + d * d
  }
  variance = variance / n.to_double()
  let std = variance.sqrt()
  if std == 0.0 {
    Array::make(n, 0.0)
  } else {
    let result : Array[Double] = []
    for i in 0..<n {
      result.push((rewards[i] - mean) / std)
    }
    result
  }
}

///|
///===
/// ID
pub fn reinforcement_reinforcement_id() -> String {
  "learncore/reinforcement"
}
