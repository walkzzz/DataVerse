///|
/// # learncore/dl_layers DL 网络层 / Deep Learning Layers
///
/// 网络层契约 + 前向传播模拟。架构 §4.3.5 learncore DL。
/// S2.3 填充：LinearLayer（矩阵乘法）+ Activation（ReLU/Sigmoid/Tanh/Identity）。
/// MoonBit 无 autograd，仅前向传播（推理模拟）。
///
/// # DL layers
///
/// Layer contracts + forward pass simulation. See architecture §4.3.5.

///|
/// 激活函数 / Activation function.
pub(all) enum Activation {
  ReLU
  Sigmoid
  Tanh
  Identity
} derive(Debug, Eq)

///|
pub extend Activation with Eq::{equal, not_equal}

///|
pub extend Activation with Debug::{to_repr}

///|
/// 线性层 / Linear layer: y = Wx + b.
pub struct LinearLayer {
  weights : Array[Array[Double]]
  bias : Array[Double]
  in_dim : Int32
  out_dim : Int32
} derive(Debug, Eq)

///|
pub extend LinearLayer with Eq::{equal, not_equal}

///|
pub extend LinearLayer with Debug::{to_repr}

///|
/// 构造线性层（零初始化）/ Build linear layer (zero-init).
pub fn make_linear_layer(in_dim : Int32, out_dim : Int32) -> LinearLayer {
  let w : Array[Array[Double]] = []
  for _ in 0..<out_dim {
    let row : Array[Double] = []
    for _ in 0..<in_dim {
      row.push(0.0)
    }
    w.push(row)
  }
  let b : Array[Double] = []
  for _ in 0..<out_dim {
    b.push(0.0)
  }
  { weights: w, bias: b, in_dim, out_dim, }
}

///|
/// 构造线性层（指定权重）/ Build linear layer with given weights.
pub fn make_linear_layer_with_weights(
  weights : Array[Array[Double]],
  bias : Array[Double],
  in_dim : Int32,
  out_dim : Int32,
) -> LinearLayer {
  { weights, bias, in_dim, out_dim, }
}

///|
/// 线性层前向传播 / Linear layer forward pass.
///
/// y = Wx + b。退化安全：输入维度不匹配返回空数组。
pub fn linear_forward(
  layer : LinearLayer,
  input : Array[Double],
) -> Array[Double] {
  if input.length() != layer.in_dim {
    []
  } else {
    let result : Array[Double] = []
    for i in 0..<layer.out_dim {
      let mut sum = layer.bias[i]
      for j in 0..<layer.in_dim {
        sum = sum + layer.weights[i][j] * input[j]
      }
      result.push(sum)
    }
    result
  }
}

///|
/// 激活函数值 / Apply activation to a scalar.
pub fn activate(act : Activation, x : Double) -> Double {
  match act {
    ReLU => if x > 0.0 { x } else { 0.0 }
    Sigmoid => 1.0 / (1.0 + exp(-x))
    Tanh => {
      let e1 = exp(x)
      let e2 = exp(-x)
      (e1 - e2) / (e1 + e2)
    }
    Identity => x
  }
}

///|
/// 激活函数前向传播 / Apply activation to an array.
pub fn activation_forward(
  act : Activation,
  input : Array[Double],
) -> Array[Double] {
  input.map(fn(x) { activate(act, x) })
}

///|
/// 激活函数名称 / Activation name.
pub fn activation_name(act : Activation) -> String {
  match act {
    ReLU => "relu"
    Sigmoid => "sigmoid"
    Tanh => "tanh"
    Identity => "identity"
  }
}

///|
/// 自然指数 / Natural exponential (Taylor series for stability).
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
/// 自然对数 / Natural log (Taylor series).
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
pub fn dl_layers_id() -> String {
  "learncore/dl_layers"
}
// ============================================================
// S2.9 DL 扩展层 / Extended DL Layers
// ============================================================

///|
/// Conv2d 配置 / Conv2d configuration.
pub struct Conv2dMeta {
  in_channels : Int32
  out_channels : Int32
  kernel_size : Int32
  stride : Int32
  padding : Int32
} derive(Debug, Eq)

///|
pub extend Conv2dMeta with Eq::{equal, not_equal}

///|
pub extend Conv2dMeta with Debug::{to_repr}

///|
/// 构造 Conv2d 配置 / Build Conv2d meta.
pub fn make_conv2d(
  in_channels : Int32,
  out_channels : Int32,
  kernel_size : Int32,
  stride : Int32,
  padding : Int32,
) -> Conv2dMeta {
  { in_channels, out_channels, kernel_size, stride, padding, }
}

///|
/// Conv2d 输出维度 / Conv2d output dimension.
///
/// 公式：`(input + 2*padding - kernel) / stride + 1`。
/// 退化安全：stride <= 0 返回 0。
pub fn conv2d_output_dim(input_dim : Int32, meta : Conv2dMeta) -> Int32 {
  if meta.stride <= 0 {
    0
  } else {
    (input_dim + 2 * meta.padding - meta.kernel_size) / meta.stride + 1
  }
}

///|
/// MaxPool 配置 / MaxPool configuration.
pub struct MaxPoolMeta {
  kernel_size : Int32
  stride : Int32
} derive(Debug, Eq)

///|
pub extend MaxPoolMeta with Eq::{equal, not_equal}

///|
pub extend MaxPoolMeta with Debug::{to_repr}

///|
/// 构造 MaxPool 配置 / Build MaxPool meta.
pub fn make_maxpool(kernel_size : Int32, stride : Int32) -> MaxPoolMeta {
  { kernel_size, stride, }
}

///|
/// MaxPool 输出维度 / MaxPool output dimension.
///
/// 公式：`(input - kernel) / stride + 1`。
/// 退化安全：stride <= 0 返回 0。
pub fn maxpool_output_dim(input_dim : Int32, meta : MaxPoolMeta) -> Int32 {
  if meta.stride <= 0 {
    0
  } else {
    (input_dim - meta.kernel_size) / meta.stride + 1
  }
}

///|
/// Dropout 模式 / Dropout mode.
pub(all) enum DropoutMode {
  Training
  Inference
} derive(Debug, Eq)

///|
pub extend DropoutMode with Eq::{equal, not_equal}

///|
pub extend DropoutMode with Debug::{to_repr}

///|
/// Dropout 前向传播 / Dropout forward.
///
/// 训练模式：确定性模拟（每隔 1/rate 置零），推理模式：原样返回。
/// 退化安全：rate <= 0 或 rate >= 1 返回原输入。
pub fn dropout_forward(
  input : Array[Double],
  rate : Double,
  mode : DropoutMode,
) -> Array[Double] {
  match mode {
    Inference => input
    Training =>
      if rate <= 0.0 || rate >= 1.0 {
        input
      } else {
        let period = (1.0 / rate).to_int()
        if period <= 0 {
          input
        } else {
          let result : Array[Double] = []
          for i in 0..<input.length() {
            if i % period == 0 {
              result.push(0.0)
            } else {
              result.push(input[i])
            }
          }
          result
        }
      }
  }
}

///|
/// BatchNorm 配置 / BatchNorm configuration.
pub struct BatchNormMeta {
  num_features : Int32
  epsilon : Double
  gamma : Array[Double]
  beta : Array[Double]
} derive(Debug, Eq)

///|
pub extend BatchNormMeta with Eq::{equal, not_equal}

///|
pub extend BatchNormMeta with Debug::{to_repr}

///|
/// 构造 BatchNorm 配置（单位变换）/ Build BatchNorm meta (identity).
pub fn make_batchnorm(num_features : Int32, epsilon : Double) -> BatchNormMeta {
  let g : Array[Double] = []
  let b : Array[Double] = []
  for _ in 0..<num_features {
    g.push(1.0)
    b.push(0.0)
  }
  { num_features, epsilon, gamma: g, beta: b, }
}

///|
/// BatchNorm 前向传播 / BatchNorm forward.
///
/// 公式：`gamma * (x - mean) / sqrt(variance + epsilon) + beta`。
/// 退化安全：空输入返回空数组。
pub fn batchnorm_forward(
  input : Array[Double],
  meta : BatchNormMeta,
) -> Array[Double] {
  let n = input.length()
  if n == 0 {
    []
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + input[i]
    }
    let mean = sum / n.to_double()
    let mut var_sum = 0.0
    for i in 0..<n {
      let diff = input[i] - mean
      var_sum = var_sum + diff * diff
    }
    let variance = var_sum / n.to_double()
    let std = (variance + meta.epsilon).sqrt()
    let result : Array[Double] = []
    for i in 0..<n {
      let g = if i < meta.gamma.length() { meta.gamma[i] } else { 1.0 }
      let b = if i < meta.beta.length() { meta.beta[i] } else { 0.0 }
      result.push(g * (input[i] - mean) / std + b)
    }
    result
  }
}

///|
/// Dropout 模式名称 / Dropout mode name.
pub fn dropout_mode_name(mode : DropoutMode) -> String {
  match mode {
    Training => "training"
    Inference => "inference"
  }
}

///===
/// S7.1 扩展：Transformer/Attention/RNN/LSTM/GRU/Conv 变体/Norm 变体/激活变体
/// 对标 PyTorch torch.nn 核心层。

///|
/// GELU 激活 / Gaussian Error Linear Unit.
/// GELU(x) = 0.5 * x * (1 + erf(x / sqrt(2)))
/// 简化：用 sigmoid 近似 GELU(x) ≈ 0.5 * x * (1 + tanh(sqrt(2/pi) * (x + 0.044715 * x^3)))
pub fn activate_gelu(x : Double) -> Double {
  let c = 0.7978845608028654
  let inner = c * (x + 0.044715 * x * x * x)
  0.5 * x * (1.0 + activate(Tanh, inner))
}

///|
/// SiLU/Swish 激活 / Sigmoid Linear Unit.
/// SiLU(x) = x * sigmoid(x)
pub fn activate_silu(x : Double) -> Double {
  x * activate(Sigmoid, x)
}

///|
/// Mish 激活 / Mish(x) = x * tanh(softplus(x)).
pub fn activate_mish(x : Double) -> Double {
  let sp = if x > 20.0 { x } else { log(1.0 + exp(x)) }
  x * activate(Tanh, sp)
}

///|
/// Hardswish 激活 / Hardswish(x) = x * clamp(x+3, 0, 6) / 6.
pub fn activate_hardswish(x : Double) -> Double {
  let clamped = if x + 3.0 < 0.0 {
    0.0
  } else if x + 3.0 > 6.0 {
    6.0
  } else {
    x + 3.0
  }
  x * clamped / 6.0
}

///|
/// Hardsigmoid 激活 / Hardsigmoid(x) = clamp(x+3, 0, 6) / 6.
pub fn activate_hardsigmoid(x : Double) -> Double {
  let clamped = if x + 3.0 < 0.0 {
    0.0
  } else if x + 3.0 > 6.0 {
    6.0
  } else {
    x + 3.0
  }
  clamped / 6.0
}

///|
/// ELU 激活 / Exponential Linear Unit.
/// ELU(x) = x if x > 0 else alpha * (exp(x) - 1)
pub fn activate_elu(x : Double, alpha : Double) -> Double {
  if x > 0.0 {
    x
  } else {
    alpha * (exp(x) - 1.0)
  }
}

///|
/// LeakyReLU 激活 / LeakyReLU(x) = max(0, x) + negative_slope * min(0, x).
pub fn activate_leaky_relu(x : Double, negative_slope : Double) -> Double {
  if x > 0.0 {
    x
  } else {
    negative_slope * x
  }
}

///|
/// PReLU 激活 / Parametric ReLU.
/// PReLU(x) = max(0, x) + alpha * min(0, x)
pub fn activate_prelu(x : Double, alpha : Double) -> Double {
  if x > 0.0 {
    x
  } else {
    alpha * x
  }
}

///|
/// ThresholdReLU 激活 / Thresholded ReLU.
/// ThresholdReLU(x) = x if x > threshold else 0
pub fn activate_threshold_relu(x : Double, threshold : Double) -> Double {
  if x > threshold {
    x
  } else {
    0.0
  }
}

///|
/// Softmax / Softmax(x_i) = exp(x_i) / sum(exp(x_j)).
/// 退化安全：空输入返回空数组。
pub fn softmax(input : Array[Double]) -> Array[Double] {
  let n = input.length()
  if n == 0 {
    []
  } else {
    let mut max_val = input[0]
    for i in 1..<n {
      if input[i] > max_val {
        max_val = input[i]
      }
    }
    let result : Array[Double] = []
    let mut sum = 0.0
    for i in 0..<n {
      let v = exp(input[i] - max_val)
      result.push(v)
      sum = sum + v
    }
    if sum == 0.0 {
      result
    } else {
      for i in 0..<n {
        result[i] = result[i] / sum
      }
      result
    }
  }
}

///|
/// LogSoftmax / LogSoftmax(x_i) = x_i - max(x) - log(sum(exp(x_j - max(x)))).
pub fn log_softmax(input : Array[Double]) -> Array[Double] {
  let n = input.length()
  if n == 0 {
    []
  } else {
    let mut max_val = input[0]
    for i in 1..<n {
      if input[i] > max_val {
        max_val = input[i]
      }
    }
    let mut sum_exp = 0.0
    for i in 0..<n {
      sum_exp = sum_exp + exp(input[i] - max_val)
    }
    let log_sum = log(sum_exp)
    let result : Array[Double] = []
    for i in 0..<n {
      result.push(input[i] - max_val - log_sum)
    }
    result
  }
}

///===
/// Norm 层

///|
/// LayerNorm 元数据 / Layer Normalization metadata.
pub struct LayerNormMeta {
  num_features : Int32
  epsilon : Double
  gamma : Array[Double]
  beta : Array[Double]
}

///|
/// 构造 LayerNorm / Create LayerNorm.
pub fn make_layernorm(num_features : Int32, epsilon : Double) -> LayerNormMeta {
  let gamma = Array::make(num_features, 1.0)
  let beta = Array::make(num_features, 0.0)
  { num_features, epsilon, gamma, beta, }
}

///|
/// LayerNorm 前向 / LayerNorm forward.
/// y = gamma * (x - mean) / sqrt(variance + eps) + beta
pub fn layernorm_forward(
  input : Array[Double],
  meta : LayerNormMeta,
) -> Array[Double] {
  let n = input.length()
  if n == 0 {
    []
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + input[i]
    }
    let mean = sum / n.to_double()
    let mut var_sum = 0.0
    for i in 0..<n {
      let d = input[i] - mean
      var_sum = var_sum + d * d
    }
    let variance = var_sum / n.to_double()
    let std = (variance + meta.epsilon).sqrt()
    let result : Array[Double] = []
    for i in 0..<n {
      let normalized = (input[i] - mean) / std
      let g = if i < meta.gamma.length() { meta.gamma[i] } else { 1.0 }
      let b = if i < meta.beta.length() { meta.beta[i] } else { 0.0 }
      result.push(g * normalized + b)
    }
    result
  }
}

///|
/// GroupNorm 元数据 / Group Normalization metadata.
pub struct GroupNormMeta {
  num_groups : Int32
  num_channels : Int32
  epsilon : Double
}

///|
/// 构造 GroupNorm / Create GroupNorm.
pub fn make_groupnorm(
  num_groups : Int32,
  num_channels : Int32,
  epsilon : Double,
) -> GroupNormMeta {
  { num_groups, num_channels, epsilon, }
}

///|
/// GroupNorm 前向 / GroupNorm forward (simplified for 1D).
pub fn groupnorm_forward(
  input : Array[Double],
  meta : GroupNormMeta,
) -> Array[Double] {
  let n = input.length()
  if n == 0 || meta.num_groups <= 0 {
    input
  } else {
    let group_size = n / meta.num_groups
    if group_size == 0 {
      input
    } else {
      let result : Array[Double] = []
      for g in 0..<meta.num_groups {
        let start = g * group_size
        let end = if g == meta.num_groups - 1 { n } else { start + group_size }
        let mut sum = 0.0
        for i in start..<end {
          sum = sum + input[i]
        }
        let mean = sum / (end - start).to_double()
        let mut var_sum = 0.0
        for i in start..<end {
          let d = input[i] - mean
          var_sum = var_sum + d * d
        }
        let variance = var_sum / (end - start).to_double()
        let std = (variance + meta.epsilon).sqrt()
        for i in start..<end {
          result.push((input[i] - mean) / std)
        }
      }
      result
    }
  }
}

///|
/// InstanceNorm 元数据 / Instance Normalization metadata.
pub struct InstanceNormMeta {
  num_features : Int32
  epsilon : Double
}

///|
/// 构造 InstanceNorm / Create InstanceNorm.
pub fn make_instancenorm(
  num_features : Int32,
  epsilon : Double,
) -> InstanceNormMeta {
  { num_features, epsilon, }
}

///|
/// InstanceNorm 前向（等同于对每个样本做 LayerNorm）/ InstanceNorm forward.
pub fn instancenorm_forward(
  input : Array[Double],
  meta : InstanceNormMeta,
) -> Array[Double] {
  let ln_meta = make_layernorm(meta.num_features, meta.epsilon)
  layernorm_forward(input, ln_meta)
}

///===
/// Attention 机制

///|
/// 缩放点积注意力 / Scaled Dot-Product Attention.
/// attention(Q, K, V) = softmax(Q * K^T / sqrt(d_k)) * V
/// 简化：Q/K/V 为同维度向量，返回加权 V。
pub fn attention_scaled_dot_product(
  query : Array[Double],
  keys : Array[Array[Double]],
  values : Array[Array[Double]],
) -> Array[Double] {
  let n = keys.length()
  if n == 0 || values.length() != n {
    []
  } else {
    let d_k = query.length()
    if d_k == 0 {
      []
    } else {
      let scale = 1.0 / d_k.to_double().sqrt()
      let scores : Array[Double] = []
      for i in 0..<n {
        let mut s = 0.0
        let k = keys[i]
        let m = if d_k < k.length() { d_k } else { k.length() }
        for j in 0..<m {
          s = s + query[j] * k[j]
        }
        scores.push(s * scale)
      }
      let weights = softmax(scores)
      let d_v = values[0].length()
      let result : Array[Double] = Array::make(d_v, 0.0)
      for i in 0..<n {
        let v = values[i]
        for j in 0..<d_v {
          if j < v.length() {
            result[j] = result[j] + weights[i] * v[j]
          }
        }
      }
      result
    }
  }
}

///|
/// 多头注意力元数据 / Multi-Head Attention metadata.
pub struct MultiHeadAttentionMeta {
  num_heads : Int32
  d_model : Int32
  d_k : Int32
  d_v : Int32
}

///|
/// 构造多头注意力 / Create Multi-Head Attention.
pub fn make_multihead_attention(
  num_heads : Int32,
  d_model : Int32,
) -> MultiHeadAttentionMeta {
  let d_k = d_model / num_heads
  { num_heads, d_model, d_k, d_v: d_k, }
}

///|
/// 多头注意力前向（简化）/ Multi-Head Attention forward (simplified).
/// 简化：每个头共享 Q/K/V，返回拼接后均值。
pub fn multihead_attention_forward(
  query : Array[Double],
  keys : Array[Array[Double]],
  values : Array[Array[Double]],
  meta : MultiHeadAttentionMeta,
) -> Array[Double] {
  let n = values.length()
  if n == 0 || meta.num_heads <= 0 {
    []
  } else {
    let d_v = values[0].length()
    let head_dim = d_v / meta.num_heads
    if head_dim == 0 {
      attention_scaled_dot_product(query, keys, values)
    } else {
      let result : Array[Double] = Array::make(d_v, 0.0)
      for _h in 0..<meta.num_heads {
        let head_out = attention_scaled_dot_product(query, keys, values)
        for j in 0..<d_v {
          if j < head_out.length() {
            result[j] = result[j] + head_out[j] / meta.num_heads.to_double()
          }
        }
      }
      result
    }
  }
}

///===
/// RNN / LSTM / GRU

///|
/// RNN 元数据 / RNN metadata.
pub struct RNNMeta {
  input_size : Int32
  hidden_size : Int32
}

///|
/// 构造 RNN / Create RNN.
pub fn make_rnn(input_size : Int32, hidden_size : Int32) -> RNNMeta {
  { input_size, hidden_size, }
}

///|
/// RNN 单步前向 / RNN single step forward.
/// h_t = tanh(W_ih * x_t + W_hh * h_{t-1} + b)
/// 简化：W_ih/W_hh 用单位矩阵近似，b=0。
pub fn rnn_step(
  input : Array[Double],
  hidden : Array[Double],
  meta : RNNMeta,
) -> Array[Double] {
  let h_size = meta.hidden_size
  let result : Array[Double] = Array::make(h_size, 0.0)
  let in_size = if input.length() < h_size { input.length() } else { h_size }
  for i in 0..<h_size {
    let mut s = 0.0
    if i < in_size {
      s = s + input[i]
    }
    if i < hidden.length() {
      s = s + hidden[i]
    }
    result[i] = activate(Tanh, s)
  }
  result
}

///|
/// RNN 序列前向 / RNN sequence forward.
pub fn rnn_forward(
  sequence : Array[Array[Double]],
  initial_hidden : Array[Double],
  meta : RNNMeta,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let mut hidden = initial_hidden
  for t in 0..<sequence.length() {
    hidden = rnn_step(sequence[t], hidden, meta)
    result.push(hidden)
  }
  result
}

///|
/// LSTM 元数据 / LSTM metadata.
pub struct LSTMMeta {
  input_size : Int32
  hidden_size : Int32
}

///|
/// 构造 LSTM / Create LSTM.
pub fn make_lstm(input_size : Int32, hidden_size : Int32) -> LSTMMeta {
  { input_size, hidden_size, }
}

///|
/// LSTM 单步前向 / LSTM single step forward (simplified).
/// 简化：门控用 sigmoid，候选用 tanh，权重用单位矩阵近似。
/// 返回 (h_t, c_t)。
pub fn lstm_step(
  input : Array[Double],
  hidden : Array[Double],
  cell : Array[Double],
  meta : LSTMMeta,
) -> (Array[Double], Array[Double]) {
  let h_size = meta.hidden_size
  let new_h : Array[Double] = Array::make(h_size, 0.0)
  let new_c : Array[Double] = Array::make(h_size, 0.0)
  for i in 0..<h_size {
    let mut x_val = 0.0
    if i < input.length() {
      x_val = input[i]
    }
    let mut h_val = 0.0
    if i < hidden.length() {
      h_val = hidden[i]
    }
    let mut c_val = 0.0
    if i < cell.length() {
      c_val = cell[i]
    }
    let combined = x_val + h_val
    let f_gate = activate(Sigmoid, combined)
    let i_gate = activate(Sigmoid, combined)
    let g_gate = activate(Tanh, combined)
    let o_gate = activate(Sigmoid, combined)
    new_c[i] = f_gate * c_val + i_gate * g_gate
    new_h[i] = o_gate * activate(Tanh, new_c[i])
  }
  (new_h, new_c)
}

///|
/// LSTM 序列前向 / LSTM sequence forward.
pub fn lstm_forward(
  sequence : Array[Array[Double]],
  initial_hidden : Array[Double],
  initial_cell : Array[Double],
  meta : LSTMMeta,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let mut hidden = initial_hidden
  let mut cell = initial_cell
  for t in 0..<sequence.length() {
    let (h, c) = lstm_step(sequence[t], hidden, cell, meta)
    hidden = h
    cell = c
    result.push(hidden)
  }
  result
}

///|
/// GRU 元数据 / GRU metadata.
pub struct GRUMeta {
  input_size : Int32
  hidden_size : Int32
}

///|
/// 构造 GRU / Create GRU.
pub fn make_gru(input_size : Int32, hidden_size : Int32) -> GRUMeta {
  { input_size, hidden_size, }
}

///|
/// GRU 单步前向 / GRU single step forward (simplified).
pub fn gru_step(
  input : Array[Double],
  hidden : Array[Double],
  meta : GRUMeta,
) -> Array[Double] {
  let h_size = meta.hidden_size
  let result : Array[Double] = Array::make(h_size, 0.0)
  for i in 0..<h_size {
    let mut x_val = 0.0
    if i < input.length() {
      x_val = input[i]
    }
    let mut h_val = 0.0
    if i < hidden.length() {
      h_val = hidden[i]
    }
    let combined = x_val + h_val
    let r_gate = activate(Sigmoid, combined)
    let z_gate = activate(Sigmoid, combined)
    let h_tilde = activate(Tanh, x_val + r_gate * h_val)
    result[i] = (1.0 - z_gate) * h_val + z_gate * h_tilde
  }
  result
}

///|
/// GRU 序列前向 / GRU sequence forward.
pub fn gru_forward(
  sequence : Array[Array[Double]],
  initial_hidden : Array[Double],
  meta : GRUMeta,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let mut hidden = initial_hidden
  for t in 0..<sequence.length() {
    hidden = gru_step(sequence[t], hidden, meta)
    result.push(hidden)
  }
  result
}

///===
/// Conv 变体

///|
/// Conv1d 元数据 / 1D Convolution metadata.
pub struct Conv1dMeta {
  in_channels : Int32
  out_channels : Int32
  kernel_size : Int32
  stride : Int32
  padding : Int32
}

///|
/// 构造 Conv1d / Create Conv1d.
pub fn make_conv1d(
  in_channels : Int32,
  out_channels : Int32,
  kernel_size : Int32,
  stride : Int32,
  padding : Int32,
) -> Conv1dMeta {
  { in_channels, out_channels, kernel_size, stride, padding, }
}

///|
/// Conv1d 输出维度 / Conv1d output dimension.
/// L_out = (L_in + 2*padding - kernel_size) / stride + 1
pub fn conv1d_output_dim(input_dim : Int32, meta : Conv1dMeta) -> Int32 {
  (input_dim + 2 * meta.padding - meta.kernel_size) / meta.stride + 1
}

///|
/// Conv1d 前向（简化）/ Conv1d forward (simplified, single channel).
pub fn conv1d_forward(
  input : Array[Double],
  meta : Conv1dMeta,
) -> Array[Double] {
  let n = input.length()
  if n == 0 || meta.kernel_size <= 0 || meta.stride <= 0 {
    []
  } else {
    let padded : Array[Double] = []
    for _i in 0..<meta.padding {
      padded.push(0.0)
    }
    for i in 0..<n {
      padded.push(input[i])
    }
    for _i in 0..<meta.padding {
      padded.push(0.0)
    }
    let out_dim = conv1d_output_dim(n, meta)
    if out_dim <= 0 {
      []
    } else {
      let result : Array[Double] = Array::make(out_dim, 0.0)
      for o in 0..<out_dim {
        let start = o * meta.stride
        let mut s = 0.0
        for k in 0..<meta.kernel_size {
          if start + k < padded.length() {
            s = s + padded[start + k]
          }
        }
        result[o] = s
      }
      result
    }
  }
}

///|
/// AvgPool2d 元数据 / 2D Average Pooling metadata.
pub struct AvgPool2dMeta {
  kernel_size : Int32
  stride : Int32
}

///|
/// 构造 AvgPool2d / Create AvgPool2d.
pub fn make_avgpool2d(kernel_size : Int32, stride : Int32) -> AvgPool2dMeta {
  { kernel_size, stride, }
}

///|
/// AvgPool2d 输出维度 / AvgPool2d output dimension.
pub fn avgpool2d_output_dim(input_dim : Int32, meta : AvgPool2dMeta) -> Int32 {
  if meta.stride <= 0 {
    0
  } else {
    (input_dim - meta.kernel_size) / meta.stride + 1
  }
}

///===
/// 工具层

///|
/// Flatten / Flatten 2D to 1D.
pub fn flatten_forward(input : Array[Array[Double]]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<input.length() {
    for j in 0..<input[i].length() {
      result.push(input[i][j])
    }
  }
  result
}

///|
/// 全局平均池化 / Global Average Pooling.
pub fn global_avg_pool_forward(input : Array[Array[Double]]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<input.length() {
    let row = input[i]
    let n = row.length()
    if n > 0 {
      let mut sum = 0.0
      for j in 0..<n {
        sum = sum + row[j]
      }
      result.push(sum / n.to_double())
    } else {
      result.push(0.0)
    }
  }
  result
}

///|
/// 残差加 / Residual Add.
pub fn residual_add(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = a[i] + b[i]
  }
  result
}

///|
/// 拼接 / Concatenate.
pub fn concat_forward(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<a.length() {
    result.push(a[i])
  }
  for i in 0..<b.length() {
    result.push(b[i])
  }
  result
}

///|
/// Embedding 层 / Embedding layer (lookup table).
pub fn embedding_forward(
  indices : Array[Int32],
  embedding_table : Array[Array[Double]],
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<indices.length() {
    let idx = indices[i]
    if idx >= 0 && idx < embedding_table.length() {
      result.push(embedding_table[idx])
    } else {
      result.push([])
    }
  }
  result
}

///|
/// Pixel Shuffle / Pixel Shuffle (simplified, returns input unchanged for 1D).
pub fn pixel_shuffle_forward(
  input : Array[Double],
  upscale_factor : Int32,
) -> Array[Double] {
  ignore(upscale_factor)
  input
}

///|
/// ConvTranspose2d 输出维度 / ConvTranspose2d output dimension.
/// L_out = (L_in - 1) * stride - 2 * padding + kernel_size + output_padding
pub fn conv_transpose2d_output_dim(
  input_dim : Int32,
  kernel_size : Int32,
  stride : Int32,
  padding : Int32,
  output_padding : Int32,
) -> Int32 {
  (input_dim - 1) * stride - 2 * padding + kernel_size + output_padding
}
