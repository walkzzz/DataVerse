///|
/// # learncore/rl_ext 强化学习扩展算子 / Reinforcement Learning Extension Operators
///
/// RL 扩展算子契约 + 简化实现。架构 §4.3.5 learncore 扩展。
/// S7.7 新建：Q-Table/Policy/Experience/DQN/REINFORCE/ActorCritic/PPO/A2C/SAC/TD3。
///
/// # RL extension operators

///===
/// 内部数学辅助 / Internal math helpers

fn rl_exp_helper(x : Double) -> Double {
  let mut term = 1.0
  let mut sum = 1.0
  for i in 1..<20 {
    term = term * x / i.to_double()
    sum = sum + term
  }
  sum
}

fn rl_ln_helper(x : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let mut y = (x - 1.0) / (x + 1.0)
  let mut sum = 0.0
  let y2 = y * y
  for i in 0..<50 {
    let k = (2 * i + 1).to_double()
    sum = sum + y / k
    y = y * y2
  }
  2.0 * sum
}

fn rl_abs_diff(x : Double) -> Double {
  if x < 0.0 { -x } else { x }
}

///===
/// Q-Table

pub struct QTable {
  n_states : Int
  n_actions : Int
  values : Array[Array[Double]]
}

pub fn make_q_table(n_states : Int, n_actions : Int) -> QTable {
  let values : Array[Array[Double]] = []
  for _ in 0..<n_states {
    let row : Array[Double] = Array::make(n_actions, 0.0)
    values.push(row)
  }
  { n_states, n_actions, values }
}

pub fn q_table_get(table : QTable, state : Int, action : Int) -> Double {
  if state < 0 || state >= table.n_states || action < 0 || action >= table.n_actions {
    return 0.0
  }
  table.values[state][action]
}

pub fn q_table_set(table : QTable, state : Int, action : Int, value : Double) -> QTable {
  if state < 0 || state >= table.n_states || action < 0 || action >= table.n_actions {
    return table
  }
  let new_values : Array[Array[Double]] = []
  for i in 0..<table.n_states {
    let row : Array[Double] = []
    for j in 0..<table.n_actions {
      if i == state && j == action {
        row.push(value)
      } else {
        row.push(table.values[i][j])
      }
    }
    new_values.push(row)
  }
  { n_states: table.n_states, n_actions: table.n_actions, values: new_values }
}

pub fn q_table_update(
  table : QTable,
  state : Int,
  action : Int,
  reward : Double,
  next_state : Int,
  alpha : Double,
  gamma : Double
) -> QTable {
  if state < 0 || state >= table.n_states || action < 0 || action >= table.n_actions {
    return table
  }
  let mut max_next_q = 0.0
  if next_state >= 0 && next_state < table.n_states {
    for a in 0..<table.n_actions {
      if table.values[next_state][a] > max_next_q {
        max_next_q = table.values[next_state][a]
      }
    }
  }
  let current = table.values[state][action]
  let updated = current + alpha * (reward + gamma * max_next_q - current)
  q_table_set(table, state, action, updated)
}

///===
/// Policy

pub struct Policy {
  n_actions : Int
  logits : Array[Double]
}

pub fn make_policy(n_actions : Int) -> Policy {
  { n_actions, logits: Array::make(n_actions, 0.0) }
}

pub fn policy_greedy(q_values : Array[Double]) -> Int {
  let n = q_values.length()
  if n == 0 {
    return 0
  }
  let mut best = 0
  for i in 1..<n {
    if q_values[i] > q_values[best] {
      best = i
    }
  }
  best
}

pub fn policy_epsilon_greedy(q_values : Array[Double], epsilon : Double) -> Int {
  let n = q_values.length()
  if n == 0 {
    return 0
  }
  let threshold = 0.5
  if threshold < epsilon {
    0
  } else {
    policy_greedy(q_values)
  }
}

pub fn policy_softmax(logits : Array[Double]) -> Array[Double] {
  let n = logits.length()
  if n == 0 {
    return []
  }
  let mut max_logit = logits[0]
  for i in 1..<n {
    if logits[i] > max_logit {
      max_logit = logits[i]
    }
  }
  let exps : Array[Double] = []
  let mut total = 0.0
  for i in 0..<n {
    let e = rl_exp_helper(logits[i] - max_logit)
    exps.push(e)
    total = total + e
  }
  if total == 0.0 {
    return Array::make(n, 1.0 / n.to_double())
  }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(exps[i] / total)
  }
  result
}

///===
/// Experience Replay

pub struct Experience {
  state : Array[Double]
  action : Int
  reward : Double
  next_state : Array[Double]
  done : Bool
}

pub struct ReplayBuffer {
  capacity : Int
  buffer : Array[Experience]
}

pub fn make_experience(
  state : Array[Double],
  action : Int,
  reward : Double,
  next_state : Array[Double],
  done : Bool
) -> Experience {
  { state, action, reward, next_state, done }
}

pub fn make_buffer(capacity : Int) -> ReplayBuffer {
  { capacity, buffer: [] }
}

pub fn buffer_add(buffer : ReplayBuffer, exp : Experience) -> ReplayBuffer {
  let new_buffer : Array[Experience] = []
  for i in 0..<buffer.buffer.length() {
    new_buffer.push(buffer.buffer[i])
  }
  new_buffer.push(exp)
  let result = if new_buffer.length() > buffer.capacity {
    let trimmed : Array[Experience] = []
    let start = new_buffer.length() - buffer.capacity
    for i in start..<new_buffer.length() {
      trimmed.push(new_buffer[i])
    }
    trimmed
  } else {
    new_buffer
  }
  { capacity: buffer.capacity, buffer: result }
}

pub fn buffer_size(buffer : ReplayBuffer) -> Int {
  buffer.buffer.length()
}

pub fn buffer_sample(buffer : ReplayBuffer, batch_size : Int) -> Array[Experience] {
  let n = buffer.buffer.length()
  if n == 0 || batch_size <= 0 {
    return []
  }
  let size = if batch_size > n { n } else { batch_size }
  let result : Array[Experience] = []
  for i in 0..<size {
    let idx = i % n
    result.push(buffer.buffer[idx])
  }
  result
}

pub fn experience_replay(
  buffer : ReplayBuffer,
  batch_size : Int,
  q_table : QTable,
  alpha : Double,
  gamma : Double
) -> QTable {
  let batch = buffer_sample(buffer, batch_size)
  let mut current = q_table
  for i in 0..<batch.length() {
    let exp = batch[i]
    let s_idx = 0
    let ns_idx = 0
    current = q_table_update(current, s_idx, exp.action, exp.reward, ns_idx, alpha, gamma)
  }
  current
}

pub fn sample_batch(buffer : ReplayBuffer, batch_size : Int) -> Array[Experience] {
  buffer_sample(buffer, batch_size)
}

///===
/// DQN

pub struct DQN {
  weights : Array[Double]
  bias : Double
  learning_rate : Double
  gamma : Double
}

pub fn make_dqn(n_features : Int, learning_rate : Double, gamma : Double) -> DQN {
  { weights: Array::make(n_features, 0.0), bias: 0.0, learning_rate, gamma }
}

pub fn dqn_forward(dqn : DQN, state : Array[Double]) -> Double {
  let n = if dqn.weights.length() < state.length() {
    dqn.weights.length()
  } else {
    state.length()
  }
  let mut sum = dqn.bias
  for i in 0..<n {
    sum = sum + dqn.weights[i] * state[i]
  }
  sum
}

pub fn dqn_loss(
  dqn : DQN,
  state : Array[Double],
  target : Double
) -> Double {
  let pred = dqn_forward(dqn, state)
  let diff = pred - target
  diff * diff
}

pub fn dqn_update(
  dqn : DQN,
  state : Array[Double],
  target : Double
) -> DQN {
  let pred = dqn_forward(dqn, state)
  let diff = pred - target
  let n = if dqn.weights.length() < state.length() {
    dqn.weights.length()
  } else {
    state.length()
  }
  let new_weights : Array[Double] = Array::make(dqn.weights.length(), 0.0)
  for i in 0..<dqn.weights.length() {
    if i < n {
      new_weights[i] = dqn.weights[i] - dqn.learning_rate * 2.0 * diff * state[i]
    } else {
      new_weights[i] = dqn.weights[i]
    }
  }
  let new_bias = dqn.bias - dqn.learning_rate * 2.0 * diff
  { weights: new_weights, bias: new_bias, learning_rate: dqn.learning_rate, gamma: dqn.gamma }
}

///===
/// REINFORCE

pub struct Reinforce {
  theta : Array[Double]
  learning_rate : Double
  gamma : Double
}

pub fn make_reinforce(n_params : Int, learning_rate : Double, gamma : Double) -> Reinforce {
  { theta: Array::make(n_params, 0.0), learning_rate, gamma }
}

pub fn reinforce_forward(agent : Reinforce, state : Array[Double]) -> Double {
  let n = if agent.theta.length() < state.length() {
    agent.theta.length()
  } else {
    state.length()
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + agent.theta[i] * state[i]
  }
  sum
}

pub fn reinforce_loss(
  agent : Reinforce,
  state : Array[Double],
  action : Int,
  reward : Double
) -> Double {
  let logits = reinforce_forward(agent, state)
  let probs = policy_softmax([logits, 0.0])
  let prob = if action < probs.length() { probs[action] } else { 0.0 }
  if prob <= 0.0 {
    return 0.0
  }
  -rl_ln_helper(prob) * reward
}

///===
/// Actor-Critic

pub struct ActorCritic {
  actor_theta : Array[Double]
  critic_theta : Array[Double]
  actor_lr : Double
  critic_lr : Double
  gamma : Double
}

pub fn make_actor_critic(
  n_features : Int,
  actor_lr : Double,
  critic_lr : Double,
  gamma : Double
) -> ActorCritic {
  {
    actor_theta: Array::make(n_features, 0.0),
    critic_theta: Array::make(n_features, 0.0),
    actor_lr,
    critic_lr,
    gamma,
  }
}

pub fn actor_forward(agent : ActorCritic, state : Array[Double]) -> Double {
  let n = if agent.actor_theta.length() < state.length() {
    agent.actor_theta.length()
  } else {
    state.length()
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + agent.actor_theta[i] * state[i]
  }
  sum
}

pub fn critic_forward(agent : ActorCritic, state : Array[Double]) -> Double {
  let n = if agent.critic_theta.length() < state.length() {
    agent.critic_theta.length()
  } else {
    state.length()
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + agent.critic_theta[i] * state[i]
  }
  sum
}

pub fn actor_critic_update(
  agent : ActorCritic,
  state : Array[Double],
  reward : Double,
  next_state : Array[Double],
  grad_log_prob : Array[Double]
) -> ActorCritic {
  let v = critic_forward(agent, state)
  let v_next = critic_forward(agent, next_state)
  let delta = reward + agent.gamma * v_next - v
  let new_actor : Array[Double] = Array::make(agent.actor_theta.length(), 0.0)
  for i in 0..<agent.actor_theta.length() {
    if i < grad_log_prob.length() {
      new_actor[i] = agent.actor_theta[i] + agent.actor_lr * grad_log_prob[i] * delta
    } else {
      new_actor[i] = agent.actor_theta[i]
    }
  }
  let new_critic : Array[Double] = Array::make(agent.critic_theta.length(), 0.0)
  for i in 0..<agent.critic_theta.length() {
    if i < state.length() {
      new_critic[i] = agent.critic_theta[i] + agent.critic_lr * delta * state[i]
    } else {
      new_critic[i] = agent.critic_theta[i]
    }
  }
  {
    actor_theta: new_actor,
    critic_theta: new_critic,
    actor_lr: agent.actor_lr,
    critic_lr: agent.critic_lr,
    gamma: agent.gamma,
  }
}

///===
/// PPO

pub struct PPO {
  theta : Array[Double]
  learning_rate : Double
  clip_epsilon : Double
  gamma : Double
}

pub fn make_ppo(
  n_params : Int,
  learning_rate : Double,
  clip_epsilon : Double,
  gamma : Double
) -> PPO {
  { theta: Array::make(n_params, 0.0), learning_rate, clip_epsilon, gamma }
}

pub fn ppo_clip(ratio : Double, epsilon : Double) -> Double {
  let lower = 1.0 - epsilon
  let upper = 1.0 + epsilon
  if ratio < lower {
    lower
  } else if ratio > upper {
    upper
  } else {
    ratio
  }
}

pub fn ppo_loss(ratio : Double, advantage_val : Double, epsilon : Double) -> Double {
  let clipped_ratio = ppo_clip(ratio, epsilon)
  let unclipped = ratio * advantage_val
  let clipped = clipped_ratio * advantage_val
  if unclipped < clipped { unclipped } else { clipped }
}

pub fn ppo_update(
  agent : PPO,
  grad_log_prob : Array[Double],
  advantage_val : Double,
  ratio : Double
) -> PPO {
  let loss = ppo_loss(ratio, advantage_val, agent.clip_epsilon)
  let new_theta : Array[Double] = Array::make(agent.theta.length(), 0.0)
  for i in 0..<agent.theta.length() {
    if i < grad_log_prob.length() {
      new_theta[i] = agent.theta[i] + agent.learning_rate * grad_log_prob[i] * loss
    } else {
      new_theta[i] = agent.theta[i]
    }
  }
  { theta: new_theta, learning_rate: agent.learning_rate, clip_epsilon: agent.clip_epsilon, gamma: agent.gamma }
}

///===
/// A2C

pub struct A2C {
  actor_theta : Array[Double]
  critic_theta : Array[Double]
  actor_lr : Double
  critic_lr : Double
  gamma : Double
}

pub fn make_a2c(
  n_features : Int,
  actor_lr : Double,
  critic_lr : Double,
  gamma : Double
) -> A2C {
  {
    actor_theta: Array::make(n_features, 0.0),
    critic_theta: Array::make(n_features, 0.0),
    actor_lr,
    critic_lr,
    gamma,
  }
}

pub fn a2c_loss(
  agent : A2C,
  state : Array[Double],
  reward : Double,
  next_state : Array[Double]
) -> Double {
  let v = a2c_critic_value(agent, state)
  let v_next = a2c_critic_value(agent, next_state)
  let delta = reward + agent.gamma * v_next - v
  delta * delta
}

fn a2c_critic_value(agent : A2C, state : Array[Double]) -> Double {
  let n = if agent.critic_theta.length() < state.length() {
    agent.critic_theta.length()
  } else {
    state.length()
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + agent.critic_theta[i] * state[i]
  }
  sum
}

pub fn a2c_update(
  agent : A2C,
  state : Array[Double],
  reward : Double,
  next_state : Array[Double],
  grad_log_prob : Array[Double]
) -> A2C {
  let v = a2c_critic_value(agent, state)
  let v_next = a2c_critic_value(agent, next_state)
  let delta = reward + agent.gamma * v_next - v
  let new_actor : Array[Double] = Array::make(agent.actor_theta.length(), 0.0)
  for i in 0..<agent.actor_theta.length() {
    if i < grad_log_prob.length() {
      new_actor[i] = agent.actor_theta[i] + agent.actor_lr * grad_log_prob[i] * delta
    } else {
      new_actor[i] = agent.actor_theta[i]
    }
  }
  let new_critic : Array[Double] = Array::make(agent.critic_theta.length(), 0.0)
  for i in 0..<agent.critic_theta.length() {
    if i < state.length() {
      new_critic[i] = agent.critic_theta[i] + agent.critic_lr * delta * state[i]
    } else {
      new_critic[i] = agent.critic_theta[i]
    }
  }
  {
    actor_theta: new_actor,
    critic_theta: new_critic,
    actor_lr: agent.actor_lr,
    critic_lr: agent.critic_lr,
    gamma: agent.gamma,
  }
}

///===
/// SAC

pub struct SAC {
  actor_theta : Array[Double]
  critic_theta : Array[Double]
  temperature : Double
  actor_lr : Double
  critic_lr : Double
  gamma : Double
}

pub fn make_sac(
  n_features : Int,
  temperature : Double,
  actor_lr : Double,
  critic_lr : Double,
  gamma : Double
) -> SAC {
  {
    actor_theta: Array::make(n_features, 0.0),
    critic_theta: Array::make(n_features, 0.0),
    temperature,
    actor_lr,
    critic_lr,
    gamma,
  }
}

pub fn sac_temperature(agent : SAC) -> Double {
  agent.temperature
}

pub fn sac_loss(
  agent : SAC,
  q_value : Double,
  log_prob : Double
) -> Double {
  q_value - agent.temperature * log_prob
}

pub fn sac_update(
  agent : SAC,
  state : Array[Double],
  reward : Double,
  next_state : Array[Double],
  grad_log_prob : Array[Double]
) -> SAC {
  let n = if agent.critic_theta.length() < state.length() {
    agent.critic_theta.length()
  } else {
    state.length()
  }
  let mut v = 0.0
  for i in 0..<n {
    v = v + agent.critic_theta[i] * state[i]
  }
  let mut v_next = 0.0
  let n2 = if agent.critic_theta.length() < next_state.length() {
    agent.critic_theta.length()
  } else {
    next_state.length()
  }
  for i in 0..<n2 {
    v_next = v_next + agent.critic_theta[i] * next_state[i]
  }
  let delta = reward + agent.gamma * v_next - v
  let new_actor : Array[Double] = Array::make(agent.actor_theta.length(), 0.0)
  for i in 0..<agent.actor_theta.length() {
    if i < grad_log_prob.length() {
      new_actor[i] = agent.actor_theta[i] + agent.actor_lr * grad_log_prob[i] * delta
    } else {
      new_actor[i] = agent.actor_theta[i]
    }
  }
  let new_critic : Array[Double] = Array::make(agent.critic_theta.length(), 0.0)
  for i in 0..<agent.critic_theta.length() {
    if i < state.length() {
      new_critic[i] = agent.critic_theta[i] + agent.critic_lr * delta * state[i]
    } else {
      new_critic[i] = agent.critic_theta[i]
    }
  }
  {
    actor_theta: new_actor,
    critic_theta: new_critic,
    temperature: agent.temperature,
    actor_lr: agent.actor_lr,
    critic_lr: agent.critic_lr,
    gamma: agent.gamma,
  }
}

///===
/// TD3

pub struct TD3 {
  actor_theta : Array[Double]
  critic_theta : Array[Double]
  target_actor_theta : Array[Double]
  target_critic_theta : Array[Double]
  actor_lr : Double
  critic_lr : Double
  gamma : Double
  tau : Double
}

pub fn make_td3(
  n_features : Int,
  actor_lr : Double,
  critic_lr : Double,
  gamma : Double,
  tau : Double
) -> TD3 {
  {
    actor_theta: Array::make(n_features, 0.0),
    critic_theta: Array::make(n_features, 0.0),
    target_actor_theta: Array::make(n_features, 0.0),
    target_critic_theta: Array::make(n_features, 0.0),
    actor_lr,
    critic_lr,
    gamma,
    tau,
  }
}

pub fn td3_target(agent : TD3, state : Array[Double]) -> Double {
  let n = if agent.target_critic_theta.length() < state.length() {
    agent.target_critic_theta.length()
  } else {
    state.length()
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + agent.target_critic_theta[i] * state[i]
  }
  sum
}

pub fn td3_update(
  agent : TD3,
  state : Array[Double],
  reward : Double,
  next_state : Array[Double]
) -> TD3 {
  let n = if agent.critic_theta.length() < state.length() {
    agent.critic_theta.length()
  } else {
    state.length()
  }
  let mut v = 0.0
  for i in 0..<n {
    v = v + agent.critic_theta[i] * state[i]
  }
  let v_target = td3_target(agent, next_state)
  let delta = reward + agent.gamma * v_target - v
  let new_critic : Array[Double] = Array::make(agent.critic_theta.length(), 0.0)
  for i in 0..<agent.critic_theta.length() {
    if i < state.length() {
      new_critic[i] = agent.critic_theta[i] + agent.critic_lr * delta * state[i]
    } else {
      new_critic[i] = agent.critic_theta[i]
    }
  }
  let new_target_critic : Array[Double] = Array::make(agent.target_critic_theta.length(), 0.0)
  for i in 0..<agent.target_critic_theta.length() {
    if i < new_critic.length() {
      new_target_critic[i] = agent.tau * new_critic[i] + (1.0 - agent.tau) * agent.target_critic_theta[i]
    } else {
      new_target_critic[i] = agent.target_critic_theta[i]
    }
  }
  {
    actor_theta: agent.actor_theta,
    critic_theta: new_critic,
    target_actor_theta: agent.target_actor_theta,
    target_critic_theta: new_target_critic,
    actor_lr: agent.actor_lr,
    critic_lr: agent.critic_lr,
    gamma: agent.gamma,
    tau: agent.tau,
  }
}

///===
/// Value Function & Bellman

pub fn value_function(values : Array[Double], state : Int) -> Double {
  if state < 0 || state >= values.length() {
    return 0.0
  }
  values[state]
}

pub fn bellman_update(
  value : Double,
  reward : Double,
  next_value : Double,
  gamma : Double
) -> Double {
  reward + gamma * next_value - value
}

pub fn td_update(
  value : Double,
  reward : Double,
  next_value : Double,
  alpha : Double,
  gamma : Double
) -> Double {
  let delta = bellman_update(value, reward, next_value, gamma)
  value + alpha * delta
}

pub fn monte_carlo_update(
  value : Double,
  returns : Double,
  alpha : Double
) -> Double {
  value + alpha * (returns - value)
}

///===
/// Reward

pub fn make_reward(value : Double) -> Double {
  value
}

pub fn discount_rewards(rewards : Array[Double], gamma : Double) -> Array[Double] {
  let n = rewards.length()
  if n == 0 {
    return []
  }
  let result : Array[Double] = Array::make(n, 0.0)
  let mut cum = 0.0
  let mut i = n - 1
  while i >= 0 {
    cum = cum * gamma + rewards[i]
    result[i] = cum
    i = i - 1
  }
  result
}

pub fn normalize_rewards(rewards : Array[Double]) -> Array[Double] {
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

///===
/// Transition & Episode

pub struct Transition {
  state : Int
  action : Int
  reward : Double
  next_state : Int
  done : Bool
}

pub fn make_transition(
  state : Int,
  action : Int,
  reward : Double,
  next_state : Int,
  done : Bool
) -> Transition {
  { state, action, reward, next_state, done }
}

pub struct Episode {
  transitions : Array[Transition]
}

pub fn make_episode() -> Episode {
  { transitions: [] }
}

pub fn episode_return(episode : Episode, gamma : Double) -> Double {
  let mut total = 0.0
  let mut discount = 1.0
  for i in 0..<episode.transitions.length() {
    total = total + discount * episode.transitions[i].reward
    discount = discount * gamma
  }
  total
}

///===
/// Environment Wrapper

pub struct EnvWrapper {
  n_states : Int
  n_actions : Int
  current_state : Int
}

pub fn make_env_wrapper(n_states : Int, n_actions : Int) -> EnvWrapper {
  { n_states, n_actions, current_state: 0 }
}

pub fn env_reset(env : EnvWrapper) -> EnvWrapper {
  { n_states: env.n_states, n_actions: env.n_actions, current_state: 0 }
}

pub fn env_step(env : EnvWrapper, action : Int) -> (EnvWrapper, Int, Double, Bool) {
  let next_state = (env.current_state + 1) % env.n_states
  let reward = if action == 0 { 1.0 } else { 0.0 }
  let done = next_state == 0
  ({ n_states: env.n_states, n_actions: env.n_actions, current_state: next_state }, next_state, reward, done)
}

///===
/// Agent

pub struct Agent {
  q_table : QTable
  epsilon : Double
  alpha : Double
  gamma : Double
}

pub fn make_agent(
  n_states : Int,
  n_actions : Int,
  epsilon : Double,
  alpha : Double,
  gamma : Double
) -> Agent {
  { q_table: make_q_table(n_states, n_actions), epsilon, alpha, gamma }
}

pub fn agent_act(agent : Agent, state : Int) -> Int {
  if state < 0 || state >= agent.q_table.n_states {
    return 0
  }
  policy_epsilon_greedy(agent.q_table.values[state], agent.epsilon)
}

pub fn agent_observe(
  agent : Agent,
  state : Int,
  action : Int,
  reward : Double,
  next_state : Int
) -> Agent {
  let new_q = q_table_update(agent.q_table, state, action, reward, next_state, agent.alpha, agent.gamma)
  { q_table: new_q, epsilon: agent.epsilon, alpha: agent.alpha, gamma: agent.gamma }
}

pub fn agent_learn(
  agent : Agent,
  episode : Episode
) -> Agent {
  let mut current = agent
  for i in 0..<episode.transitions.length() {
    let t = episode.transitions[i]
    current = agent_observe(current, t.state, t.action, t.reward, t.next_state)
  }
  current
}

///===
/// Schedules

pub fn epsilon_decay(epsilon : Double, decay_rate : Double, episode : Int) -> Double {
  let result = epsilon * @math.pow(decay_rate, episode.to_double())
  if result < 0.01 { 0.01 } else { result }
}

pub fn lr_schedule_rl(initial_lr : Double, decay_rate : Double, step : Int) -> Double {
  initial_lr / (1.0 + decay_rate * step.to_double())
}

pub fn exploration_rate(epsilon : Double, step : Int) -> Double {
  let result = epsilon / (1.0 + step.to_double() * 0.001)
  if result < 0.01 { 0.01 } else { result }
}

///===
/// Prioritized Replay

pub struct PrioritizedItem {
  experience : Experience
  priority : Double
}

pub fn prioritized_replay(
  buffer : ReplayBuffer,
  priorities : Array[Double],
  batch_size : Int
) -> Array[Experience] {
  let n = buffer.buffer.length()
  if n == 0 || batch_size <= 0 {
    return []
  }
  let mut total_priority = 0.0
  for i in 0..<priorities.length() {
    if i < n {
      total_priority = total_priority + rl_abs_diff(priorities[i])
    }
  }
  if total_priority == 0.0 {
    return buffer_sample(buffer, batch_size)
  }
  let result : Array[Experience] = []
  let size = if batch_size > n { n } else { batch_size }
  for i in 0..<size {
    let idx = i % n
    result.push(buffer.buffer[idx])
  }
  result
}

pub fn importance_sampling(
  priorities : Array[Double],
  buffer_size_val : Int,
  beta : Double
) -> Array[Double] {
  let n = priorities.length()
  if n == 0 || buffer_size_val == 0 {
    return []
  }
  let mut total = 0.0
  for i in 0..<n {
    total = total + rl_abs_diff(priorities[i])
  }
  if total == 0.0 {
    return Array::make(n, 1.0)
  }
  let result : Array[Double] = []
  for i in 0..<n {
    let prob = rl_abs_diff(priorities[i]) / total
    let weight = @math.pow(1.0 / (buffer_size_val.to_double() * prob), beta)
    result.push(weight)
  }
  result
}

///===
/// N-step / Lambda returns / GAE

pub fn n_step_return(
  rewards : Array[Double],
  next_value : Double,
  gamma : Double,
  n : Int
) -> Double {
  let mut total = 0.0
  let mut discount = 1.0
  let steps = if n < rewards.length() { n } else { rewards.length() }
  for i in 0..<steps {
    total = total + discount * rewards[i]
    discount = discount * gamma
  }
  total + discount * next_value
}

pub fn lambda_return(
  rewards : Array[Double],
  values : Array[Double],
  gamma : Double,
  lambda : Double
) -> Array[Double] {
  let n = rewards.length()
  if n == 0 {
    return []
  }
  let result : Array[Double] = Array::make(n, 0.0)
  let mut g_lambda = 0.0
  let mut i = n - 1
  while i >= 0 {
    let v_next = if i + 1 < values.length() { values[i + 1] } else { 0.0 }
    let delta = rewards[i] + gamma * v_next - values[i]
    g_lambda = delta + gamma * lambda * g_lambda
    result[i] = values[i] + g_lambda
    i = i - 1
  }
  result
}

pub fn gae_advantage(
  rewards : Array[Double],
  values : Array[Double],
  gamma : Double,
  lambda : Double
) -> Array[Double] {
  let n = rewards.length()
  if n == 0 {
    return []
  }
  let deltas : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let v_next = if i + 1 < values.length() { values[i + 1] } else { 0.0 }
    deltas[i] = rewards[i] + gamma * v_next - values[i]
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
/// ID

pub fn rl_ext_id() -> String {
  "learncore/rl_ext"
}