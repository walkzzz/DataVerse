///|
/// # learncore/federated 联邦学习 / Federated Learning
///
/// 联邦学习族：FedAvg、FedProx、SCAFFOLD、Split Learning、差分隐私、安全聚合、拜占庭鲁棒聚合、个性化。
///
/// # Federated Learning
///
/// FedAvg, FedProx, SCAFFOLD, Split Learning, DP, Secure Aggregation, Byzantine-robust, Personalization.
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

///|
fn sigmoid(x : Double) -> Double {
  1.0 / (1.0 + exp(-x))
}

///|
fn tanh_d(x : Double) -> Double {
  let e1 = exp(x)
  let e2 = exp(-x)
  (e1 - e2) / (e1 + e2)
}

///|
fn lcg_next(state : Int32) -> Int32 {
  let a = 1103515245
  let c = 12345
  let m = 2147483647
  (a * state + c) % m
}

///|
fn rand_double(seed : Int32) -> Double {
  let s = lcg_next(seed)
  s.to_double() / 2147483647.0
}

///|
fn vec_norm(a : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<a.length() {
    sum = sum + a[i] * a[i]
  }
  sqrt(sum)
}

///|
/// 联邦配置 / Federated configuration.
pub struct FedConfig {
  n_clients : Int32
  n_rounds : Int32
  learning_rate : Double
  client_fraction : Double
} derive(Debug, Eq)

///|
pub extend FedConfig with Eq::{equal, not_equal}

///|
pub extend FedConfig with Debug::{to_repr}

///|
/// 客户端 / Client.
pub struct FedClient {
  id : Int32
  data_size : Int32
  params : Array[Double]
  gradient : Array[Double]
} derive(Debug, Eq)

///|
pub extend FedClient with Eq::{equal, not_equal}

///|
pub extend FedClient with Debug::{to_repr}

///|
/// 服务器 / Server.
pub struct FedServer {
  global_params : Array[Double]
  n_clients : Int32
  round : Int32
} derive(Debug, Eq)

///|
pub extend FedServer with Eq::{equal, not_equal}

///|
pub extend FedServer with Debug::{to_repr}

///|
/// 差分隐私配置 / DP configuration.
pub struct DPConfig {
  epsilon : Double
  delta : Double
  clip_norm : Double
  sensitivity : Double
} derive(Debug, Eq)

///|
pub extend DPConfig with Eq::{equal, not_equal}

///|
pub extend DPConfig with Debug::{to_repr}

///|
/// 安全聚合配置 / Secure aggregation configuration.
pub struct SecureAggConfig {
  n_clients : Int32
  threshold : Int32
  key_size : Int32
} derive(Debug, Eq)

///|
pub extend SecureAggConfig with Eq::{equal, not_equal}

///|
pub extend SecureAggConfig with Debug::{to_repr}

///|
/// FedProx 配置 / FedProx configuration.
pub struct FedProxMeta {
  mu : Double
  learning_rate : Double
  n_local_steps : Int32
} derive(Debug, Eq)

///|
pub extend FedProxMeta with Eq::{equal, not_equal}

///|
pub extend FedProxMeta with Debug::{to_repr}

///|
/// FedAvg 动量配置 / FedAvg momentum configuration.
pub struct FedAvgMomentumMeta {
  momentum : Double
  learning_rate : Double
  beta : Double
} derive(Debug, Eq)

///|
pub extend FedAvgMomentumMeta with Eq::{equal, not_equal}

///|
pub extend FedAvgMomentumMeta with Debug::{to_repr}

///|
/// SCAFFOLD 配置 / SCAFFOLD configuration.
pub struct ScaffoldMeta {
  learning_rate : Double
  n_local_steps : Int32
  global_correction : Array[Double]
} derive(Debug, Eq)

///|
pub extend ScaffoldMeta with Eq::{equal, not_equal}

///|
pub extend ScaffoldMeta with Debug::{to_repr}

///|
/// 分割学习配置 / Split learning configuration.
pub struct FedSplitMeta {
  split_point : Int32
  learning_rate : Double
  server_dim : Int32
  client_dim : Int32
} derive(Debug, Eq)

///|
pub extend FedSplitMeta with Eq::{equal, not_equal}

///|
pub extend FedSplitMeta with Debug::{to_repr}

///|
/// 构造联邦配置 / Build federated config.
pub fn make_fed_config(
  n_clients : Int32,
  n_rounds : Int32,
  learning_rate : Double,
  client_fraction : Double,
) -> FedConfig {
  { n_clients, n_rounds, learning_rate, client_fraction, }
}

///|
/// 构造客户端 / Build client.
pub fn make_client(
  id : Int32,
  data_size : Int32,
  params : Array[Double],
) -> FedClient {
  let gradient : Array[Double] = Array::make(params.length(), 0.0)
  { id, data_size, params, gradient, }
}

///|
/// 构造服务器 / Build server.
pub fn make_server(
  global_params : Array[Double],
  n_clients : Int32,
) -> FedServer {
  { global_params, n_clients, round: 0, }
}

///|
/// 联邦轮次 / Federated round.
pub fn fed_round(
  server : FedServer,
  clients : Array[FedClient],
  config : FedConfig,
) -> FedServer {
  let n = clients.length()
  if n == 0 {
    server
  } else {
    let frac_n = (n.to_double() * config.client_fraction).to_int()
    let active_n = if frac_n > 0 { frac_n } else { n }
    let mut total_size = 0
    for i in 0..<active_n {
      total_size = total_size + clients[i].data_size
    }
    let param_len = server.global_params.length()
    let new_params : Array[Double] = Array::make(param_len, 0.0)
    for j in 0..<param_len {
      let mut weighted_sum = 0.0
      for i in 0..<active_n {
        if j < clients[i].params.length() {
          weighted_sum = weighted_sum +
            clients[i].params[j] * clients[i].data_size.to_double()
        }
      }
      if total_size > 0 {
        new_params[j] = weighted_sum / total_size.to_double()
      }
    }
    {
      global_params: new_params,
      n_clients: server.n_clients,
      round: server.round + 1,
    }
  }
}

///|
/// 客户端训练 / Client train.
pub fn fed_client_train(
  client : FedClient,
  gradients : Array[Double],
  lr : Double,
) -> FedClient {
  let n = client.params.length()
  if n != gradients.length() {
    client
  } else {
    let new_params : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      new_params[i] = client.params[i] - lr * gradients[i]
    }
    {
      id: client.id,
      data_size: client.data_size,
      params: new_params,
      gradient: gradients,
    }
  }
}

///|
/// 客户端评估 / Client eval.
pub fn fed_client_eval(
  client : FedClient,
  data : Array[Double],
  labels : Array[Double],
) -> Double {
  let n = data.length()
  if n != labels.length() || n == 0 {
    0.0
  } else {
    let bias = if client.params.length() > 0 {
      client.params[0] * 0.0
    } else {
      0.0
    }
    let mut loss = 0.0
    for i in 0..<n {
      let pred = sigmoid(data[i]) + bias
      let diff = pred - labels[i]
      loss = loss + diff * diff
    }
    loss / n.to_double()
  }
}

///|
/// 客户端更新 / Client update.
pub fn fed_client_update(
  client : FedClient,
  global_params : Array[Double],
  local_gradient : Array[Double],
  lr : Double,
) -> FedClient {
  let n = global_params.length()
  if n != local_gradient.length() {
    client
  } else {
    let new_params : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      new_params[i] = global_params[i] - lr * local_gradient[i]
    }
    {
      id: client.id,
      data_size: client.data_size,
      params: new_params,
      gradient: local_gradient,
    }
  }
}

///|
/// 服务器聚合 / Server aggregate.
pub fn fed_server_aggregate(
  server : FedServer,
  client_params : Array[Array[Double]],
  weights : Array[Double],
) -> FedServer {
  let n = client_params.length()
  if n == 0 || n != weights.length() {
    server
  } else {
    let param_len = server.global_params.length()
    let new_params : Array[Double] = Array::make(param_len, 0.0)
    let mut total_weight = 0.0
    for i in 0..<n {
      total_weight = total_weight + weights[i]
    }
    if total_weight > 0.0 {
      for j in 0..<param_len {
        let mut sum = 0.0
        for i in 0..<n {
          if j < client_params[i].length() {
            sum = sum + client_params[i][j] * weights[i]
          }
        }
        new_params[j] = sum / total_weight
      }
    }
    {
      global_params: new_params,
      n_clients: server.n_clients,
      round: server.round,
    }
  }
}

///|
/// 服务器分发 / Server distribute.
pub fn fed_server_distribute(server : FedServer) -> Array[Double] {
  server.global_params
}

///|
/// 服务器评估 / Server eval.
pub fn fed_server_eval(
  server : FedServer,
  test_data : Array[Array[Double]],
  test_labels : Array[Double],
) -> Double {
  let n = test_data.length()
  if n == 0 {
    0.0
  } else {
    let mut total_loss = 0.0
    for i in 0..<n {
      let sample = test_data[i]
      let mut pred = 0.0
      for j in 0..<sample.length() {
        if j < server.global_params.length() {
          pred = pred + sample[j] * server.global_params[j]
        }
      }
      pred = sigmoid(pred)
      let diff = pred - test_labels[i]
      total_loss = total_loss + diff * diff
    }
    total_loss / n.to_double()
  }
}

///|
/// FedAvg 聚合 / FedAvg aggregate.
pub fn fed_avg(client_params : Array[Array[Double]]) -> Array[Double] {
  let n = client_params.length()
  if n == 0 {
    []
  } else {
    let param_len = client_params[0].length()
    let result : Array[Double] = Array::make(param_len, 0.0)
    for j in 0..<param_len {
      let mut sum = 0.0
      for i in 0..<n {
        if j < client_params[i].length() {
          sum = sum + client_params[i][j]
        }
      }
      result[j] = sum / n.to_double()
    }
    result
  }
}

///|
/// 加权平均聚合 / Weighted average aggregate.
pub fn fed_weighted_avg(
  client_params : Array[Array[Double]],
  weights : Array[Double],
) -> Array[Double] {
  let n = client_params.length()
  if n == 0 || n != weights.length() {
    []
  } else {
    let param_len = client_params[0].length()
    let result : Array[Double] = Array::make(param_len, 0.0)
    let mut total_w = 0.0
    for i in 0..<n {
      total_w = total_w + weights[i]
    }
    if total_w > 0.0 {
      for j in 0..<param_len {
        let mut sum = 0.0
        for i in 0..<n {
          if j < client_params[i].length() {
            sum = sum + client_params[i][j] * weights[i]
          }
        }
        result[j] = sum / total_w
      }
    }
    result
  }
}

///|
/// 中位数聚合 / Median aggregate.
pub fn fed_median(client_params : Array[Array[Double]]) -> Array[Double] {
  let n = client_params.length()
  if n == 0 {
    []
  } else {
    let param_len = client_params[0].length()
    let result : Array[Double] = Array::make(param_len, 0.0)
    for j in 0..<param_len {
      let vals : Array[Double] = []
      for i in 0..<n {
        if j < client_params[i].length() {
          vals.push(client_params[i][j])
        }
      }
      let m = vals.length()
      if m > 0 {
        let sorted : Array[Double] = Array::make(m, 0.0)
        for k in 0..<m {
          sorted[k] = vals[k]
        }
        for a in 0..<m {
          for b in (a + 1)..<m {
            if sorted[a] > sorted[b] {
              let tmp = sorted[a]
              sorted[a] = sorted[b]
              sorted[b] = tmp
            }
          }
        }
        result[j] = sorted[m / 2]
      }
    }
    result
  }
}

///|
/// Krum 聚合 / Krum aggregate.
pub fn fed_krum(
  client_params : Array[Array[Double]],
  n_byzantine : Int32,
) -> Array[Double] {
  let n = client_params.length()
  if n == 0 {
    []
  } else {
    let n_select = n - 2 * n_byzantine - 2
    if n_select <= 0 {
      client_params[0]
    } else {
      let scores : Array[Double] = Array::make(n, 0.0)
      for i in 0..<n {
        let dists : Array[Double] = []
        for j in 0..<n {
          if i != j {
            let mut d = 0.0
            for k in 0..<client_params[i].length() {
              if k < client_params[j].length() {
                let diff = client_params[i][k] - client_params[j][k]
                d = d + diff * diff
              }
            }
            dists.push(d)
          }
        }
        dists.sort()
        let mut s = 0.0
        for k in 0..<n_select {
          if k < dists.length() {
            s = s + dists[k]
          }
        }
        scores[i] = s
      }
      let mut best_idx = 0
      let mut best_score = scores[0]
      for i in 1..<n {
        if scores[i] < best_score {
          best_score = scores[i]
          best_idx = i
        }
      }
      client_params[best_idx]
    }
  }
}

///|
/// 截断均值聚合 / Trimmed mean aggregate.
pub fn fed_trim_mean(
  client_params : Array[Array[Double]],
  trim_ratio : Double,
) -> Array[Double] {
  let n = client_params.length()
  if n == 0 {
    []
  } else {
    let param_len = client_params[0].length()
    let result : Array[Double] = Array::make(param_len, 0.0)
    let n_trim = (n.to_double() * trim_ratio).to_int()
    for j in 0..<param_len {
      let vals : Array[Double] = []
      for i in 0..<n {
        if j < client_params[i].length() {
          vals.push(client_params[i][j])
        }
      }
      let m = vals.length()
      if m > 2 * n_trim {
        let sorted : Array[Double] = Array::make(m, 0.0)
        for k in 0..<m {
          sorted[k] = vals[k]
        }
        for a in 0..<m {
          for b in (a + 1)..<m {
            if sorted[a] > sorted[b] {
              let tmp = sorted[a]
              sorted[a] = sorted[b]
              sorted[b] = tmp
            }
          }
        }
        let mut sum = 0.0
        let count = m - 2 * n_trim
        for k in n_trim..<(n_trim + count) {
          sum = sum + sorted[k]
        }
        result[j] = sum / count.to_double()
      }
    }
    result
  }
}

///|
/// Multi-Krum 聚合 / Multi-Krum aggregate.
pub fn fed_multi_krum(
  client_params : Array[Array[Double]],
  n_byzantine : Int32,
  n_select : Int32,
) -> Array[Double] {
  let n = client_params.length()
  if n == 0 || n_select <= 0 {
    []
  } else {
    let selected = fed_krum(client_params, n_byzantine)
    let param_len = selected.length()
    let result : Array[Double] = Array::make(param_len, 0.0)
    for j in 0..<param_len {
      result[j] = selected[j]
    }
    result
  }
}

///|
/// Bulyan 聚合 / Bulyan aggregate.
pub fn fed_bulyan(
  client_params : Array[Array[Double]],
  n_byzantine : Int32,
) -> Array[Double] {
  let n = client_params.length()
  if n == 0 {
    []
  } else {
    let theta = n - 4 * n_byzantine
    if theta <= 0 {
      fed_avg(client_params)
    } else {
      let selected : Array[Array[Double]] = []
      let remaining : Array[Array[Double]] = []
      for i in 0..<n {
        remaining.push(client_params[i])
      }
      for _ in 0..<theta {
        if remaining.length() > 0 {
          let best = fed_krum(remaining, n_byzantine)
          selected.push(best)
          if remaining.length() > 0 {
            let _ = remaining.remove(0)
          }
        }
      }
      fed_trim_mean(selected, 0.25)
    }
  }
}

///|
/// 检查投毒 / Check poisoning.
pub fn fed_check_poisoning(
  client_params : Array[Array[Double]],
  threshold : Double,
) -> Array[Int32] {
  let n = client_params.length()
  let result : Array[Int32] = []
  if n < 2 {
    result
  } else {
    let mean = fed_avg(client_params)
    for i in 0..<n {
      let mut dist = 0.0
      for j in 0..<client_params[i].length() {
        if j < mean.length() {
          let diff = client_params[i][j] - mean[j]
          dist = dist + diff * diff
        }
      }
      if sqrt(dist) > threshold {
        result.push(i)
      }
    }
    result
  }
}

///|
/// 拜占庭鲁棒聚合 / Byzantine robust aggregate.
pub fn fed_byzantine_robust(
  client_params : Array[Array[Double]],
  n_byzantine : Int32,
) -> Array[Double] {
  let n = client_params.length()
  if n == 0 {
    []
  } else if n_byzantine == 0 {
    fed_avg(client_params)
  } else {
    fed_krum(client_params, n_byzantine)
  }
}

///|
/// 异常检测 / Anomaly detect.
pub fn fed_anomaly_detect(
  client_params : Array[Array[Double]],
) -> Array[Double] {
  let n = client_params.length()
  if n == 0 {
    []
  } else {
    let mean = fed_avg(client_params)
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let mut dist = 0.0
      for j in 0..<client_params[i].length() {
        if j < mean.length() {
          let diff = client_params[i][j] - mean[j]
          dist = dist + diff * diff
        }
      }
      result[i] = sqrt(dist)
    }
    result
  }
}

///|
/// 构造 DP 配置 / Build DP config.
pub fn make_dp_config(
  epsilon : Double,
  delta : Double,
  clip_norm : Double,
  sensitivity : Double,
) -> DPConfig {
  { epsilon, delta, clip_norm, sensitivity, }
}

///|
/// DP 噪声 / DP noise.
pub fn dp_noise(size : Int32, config : DPConfig, seed : Int32) -> Array[Double] {
  let result : Array[Double] = Array::make(size, 0.0)
  let sigma = config.sensitivity / config.epsilon
  let mut s = seed
  for i in 0..<size {
    s = lcg_next(s)
    let u1 = rand_double(s)
    s = lcg_next(s)
    let u2 = rand_double(s)
    let r = sqrt(-2.0 * log(u1 + 0.000001)) * cos_approx(6.283185307179586 * u2)
    result[i] = sigma * r
  }
  result
}

///|
fn cos_approx(x : Double) -> Double {
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
    term = term * y2 / ((2 * j - 1).to_double() * (2 * j).to_double()) * -1.0
    result = result + term
  }
  result
}

///|
/// DP 裁剪 / DP clip.
pub fn dp_clip(params : Array[Double], clip_norm : Double) -> Array[Double] {
  let n = params.length()
  let norm = vec_norm(params)
  if norm <= clip_norm || norm == 0.0 {
    params
  } else {
    let scale = clip_norm / norm
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = params[i] * scale
    }
    result
  }
}

///|
/// DP 隐私预算 / DP privacy budget.
pub fn dp_privacy_budget(
  config : DPConfig,
  n_steps : Int32,
  sample_rate : Double,
) -> Double {
  let eps_per_step = config.epsilon / n_steps.to_double()
  eps_per_step * sample_rate
}

///|
/// 构造安全聚合配置 / Build secure agg config.
pub fn make_secure_agg(
  n_clients : Int32,
  threshold : Int32,
  key_size : Int32,
) -> SecureAggConfig {
  { n_clients, threshold, key_size, }
}

///|
/// 安全加密 / Secure encrypt.
pub fn secure_encrypt(params : Array[Double], key : Int32) -> Array[Double] {
  let n = params.length()
  let result : Array[Double] = Array::make(n, 0.0)
  let mut k = key
  for i in 0..<n {
    k = lcg_next(k)
    result[i] = params[i] + k.to_double() / 1000000.0
  }
  result
}

///|
/// 安全解密 / Secure decrypt.
pub fn secure_decrypt(encrypted : Array[Double], key : Int32) -> Array[Double] {
  let n = encrypted.length()
  let result : Array[Double] = Array::make(n, 0.0)
  let mut k = key
  for i in 0..<n {
    k = lcg_next(k)
    result[i] = encrypted[i] - k.to_double() / 1000000.0
  }
  result
}

///|
/// 安全聚合 / Secure aggregate.
pub fn secure_aggregate(
  client_params : Array[Array[Double]],
  config : SecureAggConfig,
) -> Array[Double] {
  let n = client_params.length()
  if n < config.threshold {
    []
  } else {
    let param_len = client_params[0].length()
    let result : Array[Double] = Array::make(param_len, 0.0)
    for j in 0..<param_len {
      let mut sum = 0.0
      for i in 0..<n {
        if j < client_params[i].length() {
          sum = sum + client_params[i][j]
        }
      }
      result[j] = sum
    }
    result
  }
}

///|
/// 构造 FedProx / Build FedProx meta.
pub fn make_fed_prox(
  mu : Double,
  learning_rate : Double,
  n_local_steps : Int32,
) -> FedProxMeta {
  { mu, learning_rate, n_local_steps, }
}

///|
/// FedProx 损失 / FedProx loss.
pub fn fed_prox_loss(
  local_params : Array[Double],
  global_params : Array[Double],
  meta : FedProxMeta,
) -> Double {
  let n = local_params.length()
  if n != global_params.length() {
    0.0
  } else {
    let mut prox = 0.0
    for i in 0..<n {
      let diff = local_params[i] - global_params[i]
      prox = prox + diff * diff
    }
    0.5 * meta.mu * prox
  }
}

///|
/// FedProx 步 / FedProx step.
pub fn fed_prox_step(
  local_params : Array[Double],
  global_params : Array[Double],
  gradient : Array[Double],
  meta : FedProxMeta,
) -> Array[Double] {
  let n = local_params.length()
  if n != global_params.length() || n != gradient.length() {
    local_params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let prox_grad = gradient[i] +
        meta.mu * (local_params[i] - global_params[i])
      result[i] = local_params[i] - meta.learning_rate * prox_grad
    }
    result
  }
}

///|
/// 构造 FedAvg 动量 / Build FedAvg momentum meta.
pub fn make_fed_avg_momentum(
  momentum : Double,
  learning_rate : Double,
  beta : Double,
) -> FedAvgMomentumMeta {
  { momentum, learning_rate, beta, }
}

///|
/// FedAvg 动量步 / FedAvg momentum step.
pub fn fed_avg_momentum_step(
  params : Array[Double],
  velocity : Array[Double],
  gradient : Array[Double],
  meta : FedAvgMomentumMeta,
) -> (Array[Double], Array[Double]) {
  let n = params.length()
  if n != velocity.length() || n != gradient.length() {
    (params, velocity)
  } else {
    let new_params : Array[Double] = Array::make(n, 0.0)
    let new_velocity : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      new_velocity[i] = meta.momentum * velocity[i] +
        meta.learning_rate * gradient[i]
      new_params[i] = params[i] - new_velocity[i]
    }
    (new_params, new_velocity)
  }
}

///|
/// 构造 SCAFFOLD / Build SCAFFOLD meta.
pub fn make_scaffold(
  learning_rate : Double,
  n_local_steps : Int32,
  global_correction : Array[Double],
) -> ScaffoldMeta {
  { learning_rate, n_local_steps, global_correction, }
}

///|
/// SCAFFOLD 校正 / SCAFFOLD correction.
pub fn scaffold_correction(
  local_gradient : Array[Double],
  local_correction : Array[Double],
  global_correction : Array[Double],
) -> Array[Double] {
  let n = local_gradient.length()
  if n != local_correction.length() || n != global_correction.length() {
    local_gradient
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = local_gradient[i] - local_correction[i] + global_correction[i]
    }
    result
  }
}

///|
/// SCAFFOLD 步 / SCAFFOLD step.
pub fn scaffold_step(
  params : Array[Double],
  corrected_gradient : Array[Double],
  meta : ScaffoldMeta,
) -> Array[Double] {
  let n = params.length()
  if n != corrected_gradient.length() {
    params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = params[i] - meta.learning_rate * corrected_gradient[i]
    }
    result
  }
}

///|
/// 构造分割学习 / Build split learning meta.
pub fn make_fed_split(
  split_point : Int32,
  learning_rate : Double,
  server_dim : Int32,
  client_dim : Int32,
) -> FedSplitMeta {
  { split_point, learning_rate, server_dim, client_dim, }
}

///|
/// 分割学习 / Split learning.
pub fn split_learning(
  client_input : Array[Double],
  server_weights : Array[Double],
  meta : FedSplitMeta,
) -> Array[Double] {
  let split = split_forward(client_input, meta)
  let server_out : Array[Double] = Array::make(meta.server_dim, 0.0)
  for j in 0..<meta.server_dim {
    let mut sum = 0.0
    for i in 0..<split.length() {
      let idx = j * split.length() + i
      if idx < server_weights.length() {
        sum = sum + split[i] * server_weights[idx]
      }
    }
    server_out[j] = tanh_d(sum)
  }
  server_out
}

///|
/// 分割前向 / Split forward.
pub fn split_forward(
  input : Array[Double],
  meta : FedSplitMeta,
) -> Array[Double] {
  let n = meta.split_point
  if n > input.length() {
    input
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = tanh_d(input[i])
    }
    result
  }
}

///|
/// 分割反向 / Split backward.
pub fn split_backward(
  server_grad : Array[Double],
  client_output : Array[Double],
  meta : FedSplitMeta,
) -> Array[Double] {
  let n = client_output.length()
  let scale = if meta.server_dim > 0 {
    1.0 / meta.server_dim.to_double()
  } else {
    1.0
  }
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let grad = if i < server_grad.length() { server_grad[i] } else { 0.0 }
    result[i] = grad * (1.0 - client_output[i] * client_output[i]) * scale
  }
  result
}

///|
/// 通信成本 / Communication cost.
pub fn fed_communication_cost(
  n_clients : Int32,
  param_size : Int32,
  n_rounds : Int32,
) -> Int32 {
  n_clients * param_size * n_rounds * 2
}

///|
/// 联邦压缩 / Federated compression.
pub fn fed_compression(params : Array[Double], ratio : Int32) -> Array[Double] {
  let n = params.length()
  if ratio <= 0 {
    params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let scaled = params[i] * ratio.to_double()
      result[i] = scaled.to_int().to_double() / ratio.to_double()
    }
    result
  }
}

///|
/// 联邦量化 / Federated quantization.
pub fn fed_quantization(params : Array[Double], n_bits : Int32) -> Array[Int32] {
  let n = params.length()
  let result : Array[Int32] = Array::make(n, 0)
  if n_bits <= 0 || n_bits > 32 {
    result
  } else {
    let levels = 1 << n_bits
    let half = levels / 2
    for i in 0..<n {
      let q = params[i] * half.to_double()
      result[i] = q.to_int()
    }
    result
  }
}

///|
/// 个性化 / Personalize.
pub fn fed_personalize(
  global_params : Array[Double],
  local_params : Array[Double],
  alpha : Double,
) -> Array[Double] {
  let n = global_params.length()
  if n != local_params.length() {
    global_params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = alpha * global_params[i] + (1.0 - alpha) * local_params[i]
    }
    result
  }
}

///|
/// 微调 / Fine tune.
pub fn fed_fine_tune(
  params : Array[Double],
  gradients : Array[Double],
  lr : Double,
  n_steps : Int32,
) -> Array[Double] {
  let n = params.length()
  if n != gradients.length() {
    params
  } else {
    let current : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      current[i] = params[i]
    }
    for _ in 0..<n_steps {
      for i in 0..<n {
        current[i] = current[i] - lr * gradients[i]
      }
    }
    current
  }
}

///|
/// 本地适配 / Local adapt.
pub fn fed_local_adapt(
  global_params : Array[Double],
  local_data : Array[Double],
  lr : Double,
) -> Array[Double] {
  let n = global_params.length()
  if n != local_data.length() {
    global_params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let grad = 2.0 * (global_params[i] - local_data[i])
      result[i] = global_params[i] - lr * grad
    }
    result
  }
}

///|
/// 全局评估 / Evaluate global.
pub fn fed_evaluate_global(
  global_params : Array[Double],
  test_data : Array[Array[Double]],
  test_labels : Array[Double],
) -> Double {
  let n = test_data.length()
  if n == 0 || n != test_labels.length() {
    0.0
  } else {
    let mut correct = 0.0
    for i in 0..<n {
      let sample = test_data[i]
      let mut pred = 0.0
      for j in 0..<sample.length() {
        if j < global_params.length() {
          pred = pred + sample[j] * global_params[j]
        }
      }
      let p = sigmoid(pred)
      if (p > 0.5 && test_labels[i] > 0.5) ||
        (p <= 0.5 && test_labels[i] <= 0.5) {
        correct = correct + 1.0
      }
    }
    correct / n.to_double()
  }
}

///|
/// 本地评估 / Evaluate local.
pub fn fed_evaluate_local(
  local_params : Array[Double],
  local_data : Array[Array[Double]],
  local_labels : Array[Double],
) -> Double {
  let n = local_data.length()
  if n == 0 || n != local_labels.length() {
    0.0
  } else {
    let mut loss = 0.0
    for i in 0..<n {
      let sample = local_data[i]
      let mut pred = 0.0
      for j in 0..<sample.length() {
        if j < local_params.length() {
          pred = pred + sample[j] * local_params[j]
        }
      }
      pred = sigmoid(pred)
      let diff = pred - local_labels[i]
      loss = loss + diff * diff
    }
    loss / n.to_double()
  }
}

///|
/// 异构评估 / Evaluate heterogeneity.
pub fn fed_evaluate_heterogeneity(
  client_performances : Array[Double],
) -> Double {
  let n = client_performances.length()
  if n == 0 {
    0.0
  } else {
    let mut mean = 0.0
    for i in 0..<n {
      mean = mean + client_performances[i]
    }
    mean = mean / n.to_double()
    let mut var_sum = 0.0
    for i in 0..<n {
      let d = client_performances[i] - mean
      var_sum = var_sum + d * d
    }
    let variance = var_sum / n.to_double()
    sqrt(variance)
  }
}

///|
/// 联邦学习 ID / Federated learning id.
pub fn federated_id() -> String {
  "federated_v1"
}
