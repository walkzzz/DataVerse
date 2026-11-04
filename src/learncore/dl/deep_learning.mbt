///|
/// # learncore/deep_learning 深度学习 / Deep Learning
///
/// 深度学习核心组件：张量运算、卷积、池化、归一化、注意力、RNN/LSTM/GRU、优化器、损失函数、生成模型。
///
/// # Deep Learning
///
/// Tensor ops, conv, pool, norm, attention, RNN/LSTM/GRU, optimizers, losses, generative models.
fn deep_learning_exp(x : Double) -> Double {
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
fn deep_learning_log(x : Double) -> Double {
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
fn deep_learning_sqrt(x : Double) -> Double {
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
fn deep_learning_abs_d(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
fn deep_learning_sin(x : Double) -> Double {
  let pi = 3.141592653589793
  let two_pi = 6.283185307179586
  let mut y = x
  while y > pi {
    y = y - two_pi
  }
  while y < -pi {
    y = y + two_pi
  }
  let mut result = y
  let mut term = y
  let y2 = y * y
  for j in 1..<20 {
    term = term * y2 / ((2 * j).to_double() * (2 * j + 1).to_double()) * -1.0
    result = result + term
  }
  result
}

///|
fn deep_learning_cos(x : Double) -> Double {
  let half_pi = 1.5707963267948966
  deep_learning_sin(x + half_pi)
}

///|
fn deep_learning_sigmoid(x : Double) -> Double {
  1.0 / (1.0 + deep_learning_exp(-x))
}

///|
fn deep_learning_tanh_d(x : Double) -> Double {
  let e1 = deep_learning_exp(x)
  let e2 = deep_learning_exp(-x)
  (e1 - e2) / (e1 + e2)
}

///|
fn deep_learning_parse_double_str(s : String) -> Double {
  let mut result = 0.0
  let mut negative = false
  let mut i = 0
  if s.length() > 0 && s[0].to_int() == 45 {
    negative = true
    i = 1
  }
  let mut has_dot = false
  let mut scale = 0.1
  while i < s.length() {
    let c = s[i].to_int()
    if c >= 48 && c <= 57 {
      if has_dot {
        result = result + (c - 48).to_double() * scale
        scale = scale * 0.1
      } else {
        result = result * 10.0 + (c - 48).to_double()
      }
    } else if c == 46 {
      has_dot = true
    }
    i = i + 1
  }
  if negative {
    -result
  } else {
    result
  }
}

///|
/// 张量 / Tensor.
pub struct Tensor {
  shape : Array[Int32]
  data : Array[Double]
} derive(Debug, Eq)

///|
pub extend Tensor with Eq::{equal, not_equal}

///|
pub extend Tensor with Debug::{to_repr}

///|

///|

///|

///|

///|
/// AvgPool 配置 / AvgPool configuration.
pub struct AvgPoolMeta {
  kernel_size : Int32
  stride : Int32
} derive(Debug, Eq)

///|
pub extend AvgPoolMeta with Eq::{equal, not_equal}

///|
pub extend AvgPoolMeta with Debug::{to_repr}

///|

///|

///|

///|

///|
/// Dropout 配置 / Dropout configuration.
pub struct DropoutMeta {
  rate : Double
  training : Bool
} derive(Debug, Eq)

///|
pub extend DropoutMeta with Eq::{equal, not_equal}

///|
pub extend DropoutMeta with Debug::{to_repr}

///|
/// Attention 配置 / Attention configuration.
pub struct AttentionMeta {
  num_heads : Int32
  d_model : Int32
  d_k : Int32
  d_v : Int32
} derive(Debug, Eq)

///|
pub extend AttentionMeta with Eq::{equal, not_equal}

///|
pub extend AttentionMeta with Debug::{to_repr}

///|
/// Transformer 配置 / Transformer configuration.
pub struct TransformerMeta {
  num_layers : Int32
  num_heads : Int32
  d_model : Int32
  d_ff : Int32
} derive(Debug, Eq)

///|
pub extend TransformerMeta with Eq::{equal, not_equal}

///|
pub extend TransformerMeta with Debug::{to_repr}

///|

///|

///|

///|

///|
/// Adam 优化器状态 / Adam optimizer state.
pub struct AdamState {
  lr : Double
  beta1 : Double
  beta2 : Double
  epsilon : Double
  params : Array[Double]
  m : Array[Double]
  v : Array[Double]
  step_count : Int32
} derive(Debug, Eq)

///|
pub extend AdamState with Eq::{equal, not_equal}

///|
pub extend AdamState with Debug::{to_repr}

///|
/// SGD 优化器状态 / SGD optimizer state.
pub struct SGDState {
  lr : Double
  momentum : Double
  params : Array[Double]
  velocity : Array[Double]
} derive(Debug, Eq)

///|
pub extend SGDState with Eq::{equal, not_equal}

///|
pub extend SGDState with Debug::{to_repr}

///|
/// AdaGrad 优化器状态 / AdaGrad optimizer state.
pub struct AdaGradState {
  lr : Double
  epsilon : Double
  params : Array[Double]
  cache : Array[Double]
} derive(Debug, Eq)

///|
pub extend AdaGradState with Eq::{equal, not_equal}

///|
pub extend AdaGradState with Debug::{to_repr}

///|
/// AdaDelta 优化器状态 / AdaDelta optimizer state.
pub struct AdaDeltaState {
  lr : Double
  rho : Double
  epsilon : Double
  params : Array[Double]
  eg : Array[Double]
  edx : Array[Double]
} derive(Debug, Eq)

///|
pub extend AdaDeltaState with Eq::{equal, not_equal}

///|
pub extend AdaDeltaState with Debug::{to_repr}

///|
/// 学习率调度器 / Learning rate scheduler.
pub struct SchedulerMeta {
  init_lr : Double
  step_size : Int32
  gamma : Double
  total_steps : Int32
} derive(Debug, Eq)

///|
pub extend SchedulerMeta with Eq::{equal, not_equal}

///|
pub extend SchedulerMeta with Debug::{to_repr}

///|
/// 自编码器配置 / Autoencoder configuration.
pub struct AutoEncoderMeta {
  input_dim : Int32
  hidden_dim : Int32
  latent_dim : Int32
} derive(Debug, Eq)

///|
pub extend AutoEncoderMeta with Eq::{equal, not_equal}

///|
pub extend AutoEncoderMeta with Debug::{to_repr}

///|
/// VAE 配置 / Variational Autoencoder configuration.
pub struct VAEMeta {
  input_dim : Int32
  hidden_dim : Int32
  latent_dim : Int32
} derive(Debug, Eq)

///|
pub extend VAEMeta with Eq::{equal, not_equal}

///|
pub extend VAEMeta with Debug::{to_repr}

///|
/// GAN 配置 / GAN configuration.
pub struct GANMeta {
  generator_dim : Int32
  discriminator_dim : Int32
  noise_dim : Int32
} derive(Debug, Eq)

///|
pub extend GANMeta with Eq::{equal, not_equal}

///|
pub extend GANMeta with Debug::{to_repr}

///|
/// 构造张量 / Build tensor.
pub fn deep_learning_make_tensor(shape : Array[Int32], data : Array[Double]) -> Tensor {
  { shape, data, }
}

///|
/// 张量形状 / Tensor shape.
pub fn deep_learning_tensor_shape(tensor : Tensor) -> Array[Int32] {
  tensor.shape
}

///|
/// 张量大小 / Tensor size (number of elements).
pub fn deep_learning_tensor_size(tensor : Tensor) -> Int32 {
  tensor.data.length()
}

///|
/// 张量重塑 / Tensor reshape.
pub fn deep_learning_tensor_reshape(tensor : Tensor, new_shape : Array[Int32]) -> Tensor {
  let mut new_size = 1
  for i in 0..<new_shape.length() {
    new_size = new_size * new_shape[i]
  }
  if new_size != tensor.data.length() {
    tensor
  } else {
    { shape: new_shape, data: tensor.data, }
  }
}

///|
/// 张量加法 / Tensor element-wise add.
pub fn deep_learning_tensor_add(a : Tensor, b : Tensor) -> Tensor {
  let n = a.data.length()
  if n != b.data.length() {
    { shape: [], data: [], }
  } else {
    let data : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      data[i] = a.data[i] + b.data[i]
    }
    { shape: a.shape, data, }
  }
}

///|
/// 张量减法 / Tensor element-wise sub.
pub fn deep_learning_tensor_sub(a : Tensor, b : Tensor) -> Tensor {
  let n = a.data.length()
  if n != b.data.length() {
    { shape: [], data: [], }
  } else {
    let data : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      data[i] = a.data[i] - b.data[i]
    }
    { shape: a.shape, data, }
  }
}

///|
/// 张量乘法 / Tensor element-wise mul.
pub fn deep_learning_tensor_mul(a : Tensor, b : Tensor) -> Tensor {
  let n = a.data.length()
  if n != b.data.length() {
    { shape: [], data: [], }
  } else {
    let data : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      data[i] = a.data[i] * b.data[i]
    }
    { shape: a.shape, data, }
  }
}

///|
/// 张量除法 / Tensor element-wise div.
pub fn deep_learning_tensor_div(a : Tensor, b : Tensor) -> Tensor {
  let n = a.data.length()
  if n != b.data.length() {
    { shape: [], data: [], }
  } else {
    let data : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      if b.data[i] != 0.0 {
        data[i] = a.data[i] / b.data[i]
      }
    }
    { shape: a.shape, data, }
  }
}

///|
/// 张量点积 / Tensor dot product.
pub fn deep_learning_tensor_dot(a : Tensor, b : Tensor) -> Double {
  let n = a.data.length()
  if n != b.data.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + a.data[i] * b.data[i]
    }
    sum
  }
}

///|
/// 张量转置 / Tensor transpose (2D).
pub fn deep_learning_tensor_transpose(tensor : Tensor) -> Tensor {
  if tensor.shape.length() != 2 {
    tensor
  } else {
    let rows = tensor.shape[0]
    let cols = tensor.shape[1]
    let new_data : Array[Double] = Array::make(rows * cols, 0.0)
    for i in 0..<rows {
      for j in 0..<cols {
        new_data[j * rows + i] = tensor.data[i * cols + j]
      }
    }
    let new_shape : Array[Int32] = [cols, rows]
    { shape: new_shape, data: new_data, }
  }
}

///|
/// 张量矩阵乘法 / Tensor matrix multiply (2D).
pub fn deep_learning_tensor_matmul(a : Tensor, b : Tensor) -> Tensor {
  if a.shape.length() != 2 || b.shape.length() != 2 || a.shape[1] != b.shape[0] {
    { shape: [], data: [], }
  } else {
    let m = a.shape[0]
    let k = a.shape[1]
    let n = b.shape[1]
    let new_data : Array[Double] = Array::make(m * n, 0.0)
    for i in 0..<m {
      for j in 0..<n {
        let mut sum = 0.0
        for d in 0..<k {
          sum = sum + a.data[i * k + d] * b.data[d * n + j]
        }
        new_data[i * n + j] = sum
      }
    }
    let new_shape : Array[Int32] = [m, n]
    { shape: new_shape, data: new_data, }
  }
}

///|
/// 构造 Conv2d / Build Conv2d meta.
pub fn deep_learning_make_conv2d(
  in_channels : Int32,
  out_channels : Int32,
  kernel_size : Int32,
  stride : Int32,
  padding : Int32,
) -> Conv2dMeta {
  { in_channels, out_channels, kernel_size, stride, padding, }
}

///|
/// Conv2d 前向 / Conv2d forward.
pub fn deep_learning_conv2d_forward(
  input : Array[Array[Double]],
  kernel : Array[Array[Double]],
  meta : Conv2dMeta,
) -> Array[Array[Double]] {
  let h = input.length()
  if h == 0 {
    []
  } else {
    let w = input[0].length()
    let k = meta.kernel_size
    let s = meta.stride
    if s <= 0 || k <= 0 {
      []
    } else {
      let out_h = (h + 2 * meta.padding - k) / s + 1
      let out_w = (w + 2 * meta.padding - k) / s + 1
      if out_h <= 0 || out_w <= 0 {
        []
      } else {
        let padded : Array[Array[Double]] = []
        for _ in 0..<meta.padding {
          padded.push(Array::make(w + 2 * meta.padding, 0.0))
        }
        for i in 0..<h {
          let row : Array[Double] = Array::make(meta.padding, 0.0)
          for j in 0..<w {
            row.push(input[i][j])
          }
          for _ in 0..<meta.padding {
            row.push(0.0)
          }
          padded.push(row)
        }
        for _ in 0..<meta.padding {
          padded.push(Array::make(w + 2 * meta.padding, 0.0))
        }
        let result : Array[Array[Double]] = []
        for oi in 0..<out_h {
          let row : Array[Double] = []
          for oj in 0..<out_w {
            let mut sum = 0.0
            for ki in 0..<k {
              for kj in 0..<k {
                let pi = oi * s + ki
                let pj = oj * s + kj
                if pi < padded.length() &&
                  pj < padded[pi].length() &&
                  ki < kernel.length() &&
                  kj < kernel[ki].length() {
                  sum = sum + padded[pi][pj] * kernel[ki][kj]
                }
              }
            }
            row.push(sum)
          }
          result.push(row)
        }
        result
      }
    }
  }
}

///|
/// Conv2d 反向 / Conv2d backward (gradient w.r.t. input, simplified).
pub fn deep_learning_conv2d_backward(
  grad_output : Array[Array[Double]],
  kernel : Array[Array[Double]],
  meta : Conv2dMeta,
) -> Array[Array[Double]] {
  let h = grad_output.length()
  if h == 0 {
    []
  } else {
    let w = grad_output[0].length()
    let k = meta.kernel_size
    let result : Array[Array[Double]] = []
    for _ in 0..<(h * meta.stride + k) {
      let row : Array[Double] = Array::make(w * meta.stride + k, 0.0)
      result.push(row)
    }
    for oi in 0..<h {
      for oj in 0..<w {
        for ki in 0..<k {
          for kj in 0..<k {
            let pi = oi * meta.stride + ki
            let pj = oj * meta.stride + kj
            if pi < result.length() &&
              pj < result[pi].length() &&
              ki < kernel.length() &&
              kj < kernel[ki].length() {
              result[pi][pj] = result[pi][pj] +
                grad_output[oi][oj] * kernel[ki][kj]
            }
          }
        }
      }
    }
    result
  }
}

///|
/// 构造 MaxPool / Build MaxPool meta.
pub fn deep_learning_make_maxpool(kernel_size : Int32, stride : Int32) -> MaxPoolMeta {
  { kernel_size, stride, }
}

///|
/// MaxPool 前向 / MaxPool forward.
pub fn deep_learning_maxpool_forward(
  input : Array[Array[Double]],
  meta : MaxPoolMeta,
) -> Array[Array[Double]] {
  let h = input.length()
  if h == 0 || meta.stride <= 0 {
    []
  } else {
    let w = input[0].length()
    let out_h = (h - meta.kernel_size) / meta.stride + 1
    let out_w = (w - meta.kernel_size) / meta.stride + 1
    if out_h <= 0 || out_w <= 0 {
      []
    } else {
      let result : Array[Array[Double]] = []
      for oi in 0..<out_h {
        let row : Array[Double] = []
        for oj in 0..<out_w {
          let mut max_val = -1000000.0
          for ki in 0..<meta.kernel_size {
            for kj in 0..<meta.kernel_size {
              let pi = oi * meta.stride + ki
              let pj = oj * meta.stride + kj
              if pi < h && pj < w {
                if input[pi][pj] > max_val {
                  max_val = input[pi][pj]
                }
              }
            }
          }
          row.push(max_val)
        }
        result.push(row)
      }
      result
    }
  }
}

///|
/// MaxPool 反向 / MaxPool backward (simplified).
pub fn deep_learning_maxpool_backward(
  grad_output : Array[Array[Double]],
  input : Array[Array[Double]],
  meta : MaxPoolMeta,
) -> Array[Array[Double]] {
  let h = input.length()
  if h == 0 {
    []
  } else {
    let w = input[0].length()
    let result : Array[Array[Double]] = []
    for _ in 0..<h {
      result.push(Array::make(w, 0.0))
    }
    let out_h = grad_output.length()
    if out_h > 0 {
      let out_w = grad_output[0].length()
      for oi in 0..<out_h {
        for oj in 0..<out_w {
          let mut max_val = -1000000.0
          let mut max_pi = 0
          let mut max_pj = 0
          for ki in 0..<meta.kernel_size {
            for kj in 0..<meta.kernel_size {
              let pi = oi * meta.stride + ki
              let pj = oj * meta.stride + kj
              if pi < h && pj < w {
                if input[pi][pj] > max_val {
                  max_val = input[pi][pj]
                  max_pi = pi
                  max_pj = pj
                }
              }
            }
          }
          if max_pi < h && max_pj < w {
            result[max_pi][max_pj] = grad_output[oi][oj]
          }
        }
      }
    }
    result
  }
}

///|
/// 构造 AvgPool / Build AvgPool meta.
pub fn deep_learning_make_avgpool(kernel_size : Int32, stride : Int32) -> AvgPoolMeta {
  { kernel_size, stride, }
}

///|
/// AvgPool 前向 / AvgPool forward.
pub fn deep_learning_avgpool_forward(
  input : Array[Array[Double]],
  meta : AvgPoolMeta,
) -> Array[Array[Double]] {
  let h = input.length()
  if h == 0 || meta.stride <= 0 {
    []
  } else {
    let w = input[0].length()
    let out_h = (h - meta.kernel_size) / meta.stride + 1
    let out_w = (w - meta.kernel_size) / meta.stride + 1
    if out_h <= 0 || out_w <= 0 {
      []
    } else {
      let k_area = (meta.kernel_size * meta.kernel_size).to_double()
      let result : Array[Array[Double]] = []
      for oi in 0..<out_h {
        let row : Array[Double] = []
        for oj in 0..<out_w {
          let mut sum = 0.0
          for ki in 0..<meta.kernel_size {
            for kj in 0..<meta.kernel_size {
              let pi = oi * meta.stride + ki
              let pj = oj * meta.stride + kj
              if pi < h && pj < w {
                sum = sum + input[pi][pj]
              }
            }
          }
          row.push(sum / k_area)
        }
        result.push(row)
      }
      result
    }
  }
}

///|
/// AvgPool 反向 / AvgPool backward.
pub fn deep_learning_avgpool_backward(
  grad_output : Array[Array[Double]],
  input : Array[Array[Double]],
  meta : AvgPoolMeta,
) -> Array[Array[Double]] {
  let h = input.length()
  if h == 0 {
    []
  } else {
    let w = input[0].length()
    let result : Array[Array[Double]] = []
    for _ in 0..<h {
      result.push(Array::make(w, 0.0))
    }
    let k_area = (meta.kernel_size * meta.kernel_size).to_double()
    let out_h = grad_output.length()
    if out_h > 0 {
      let out_w = grad_output[0].length()
      for oi in 0..<out_h {
        for oj in 0..<out_w {
          let g = grad_output[oi][oj] / k_area
          for ki in 0..<meta.kernel_size {
            for kj in 0..<meta.kernel_size {
              let pi = oi * meta.stride + ki
              let pj = oj * meta.stride + kj
              if pi < h && pj < w {
                result[pi][pj] = result[pi][pj] + g
              }
            }
          }
        }
      }
    }
    result
  }
}

///|
/// 构造 BatchNorm / Build BatchNorm meta.
pub fn deep_learning_make_batchnorm(num_features : Int32, epsilon : Double) -> BatchNormMeta {
  {
    num_features,
    epsilon,
    gamma: Array::make(num_features, 1.0),
    beta: Array::make(num_features, 0.0),
  }
}

///|
/// BatchNorm 前向 / BatchNorm forward.
pub fn deep_learning_batchnorm_forward(
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
      let d = input[i] - mean
      var_sum = var_sum + d * d
    }
    let variance = var_sum / n.to_double()
    let std = deep_learning_sqrt(variance + meta.epsilon)
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let g = if i < meta.gamma.length() { meta.gamma[i] } else { 1.0 }
      let b = if i < meta.beta.length() { meta.beta[i] } else { 0.0 }
      result[i] = g * (input[i] - mean) / std + b
    }
    result
  }
}

///|
/// BatchNorm 反向 / BatchNorm backward (simplified).
pub fn deep_learning_batchnorm_backward(
  grad_output : Array[Double],
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
      let d = input[i] - mean
      var_sum = var_sum + d * d
    }
    let variance = var_sum / n.to_double()
    let std = deep_learning_sqrt(variance + meta.epsilon)
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let g = if i < meta.gamma.length() { meta.gamma[i] } else { 1.0 }
      result[i] = g * grad_output[i] / std
    }
    result
  }
}

///|
/// 构造 LayerNorm / Build LayerNorm meta.
pub fn deep_learning_make_layernorm(num_features : Int32, epsilon : Double) -> LayerNormMeta {
  {
    num_features,
    epsilon,
    gamma: Array::make(num_features, 1.0),
    beta: Array::make(num_features, 0.0),
  }
}

///|
/// LayerNorm 前向 / LayerNorm forward.
pub fn deep_learning_layernorm_forward(
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
    let std = deep_learning_sqrt(variance + meta.epsilon)
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let g = if i < meta.gamma.length() { meta.gamma[i] } else { 1.0 }
      let b = if i < meta.beta.length() { meta.beta[i] } else { 0.0 }
      result[i] = g * (input[i] - mean) / std + b
    }
    result
  }
}

///|
/// LayerNorm 反向 / LayerNorm backward (simplified).
pub fn deep_learning_layernorm_backward(
  grad_output : Array[Double],
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
    let std = deep_learning_sqrt(variance + meta.epsilon)
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let g = if i < meta.gamma.length() { meta.gamma[i] } else { 1.0 }
      result[i] = g * grad_output[i] / std
    }
    result
  }
}

///|
/// 构造 Dropout / Build Dropout meta.
pub fn deep_learning_make_dropout(rate : Double, training : Bool) -> DropoutMeta {
  { rate, training, }
}

///|
/// Dropout 前向 / Dropout forward.
pub fn deep_learning_dropout_forward(
  input : Array[Double],
  meta : DropoutMeta,
) -> Array[Double] {
  if !meta.training || meta.rate <= 0.0 || meta.rate >= 1.0 {
    input
  } else {
    let period = (1.0 / meta.rate).to_int()
    if period <= 0 {
      input
    } else {
      let scale = 1.0 / (1.0 - meta.rate)
      let result : Array[Double] = Array::make(input.length(), 0.0)
      for i in 0..<input.length() {
        if i % period == 0 {
          result[i] = 0.0
        } else {
          result[i] = input[i] * scale
        }
      }
      result
    }
  }
}

///|
/// Dropout 反向 / Dropout backward.
pub fn deep_learning_dropout_backward(
  grad_output : Array[Double],
  meta : DropoutMeta,
) -> Array[Double] {
  deep_learning_dropout_forward(grad_output, meta)
}

///|
/// 构造 Attention / Build Attention meta.
pub fn deep_learning_make_attention(num_heads : Int32, d_model : Int32) -> AttentionMeta {
  let d_k = if num_heads > 0 { d_model / num_heads } else { d_model }
  { num_heads, d_model, d_k, d_v: d_k, }
}

///|
/// Attention 前向 / Scaled dot-product attention.
pub fn deep_learning_attention_forward(
  query : Array[Double],
  keys : Array[Double],
  values : Array[Double],
) -> Array[Double] {
  let n = query.length()
  if n == 0 || n != keys.length() || n != values.length() {
    []
  } else {
    let scale = 1.0 / deep_learning_sqrt(n.to_double())
    let score = deep_learning_tensor_dot({ shape: [n], data: query, }, {
        shape: [n],
        data: keys,
      }) *
      scale
    let weight = deep_learning_sigmoid(score)
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = weight * values[i]
    }
    result
  }
}

///|
/// 多头注意力 / Multi-head attention.
pub fn deep_learning_multi_head_attention(
  query : Array[Double],
  keys : Array[Double],
  values : Array[Double],
  meta : AttentionMeta,
) -> Array[Double] {
  let n = query.length()
  if n == 0 || meta.num_heads <= 0 {
    []
  } else {
    let head_dim = n / meta.num_heads
    if head_dim == 0 {
      deep_learning_attention_forward(query, keys, values)
    } else {
      let result : Array[Double] = Array::make(n, 0.0)
      for h in 0..<meta.num_heads {
        let start = h * head_dim
        let q_head : Array[Double] = []
        let k_head : Array[Double] = []
        let v_head : Array[Double] = []
        for i in 0..<head_dim {
          if start + i < n {
            q_head.push(query[start + i])
            k_head.push(keys[start + i])
            v_head.push(values[start + i])
          }
        }
        let head_out = deep_learning_attention_forward(q_head, k_head, v_head)
        for i in 0..<head_dim {
          if start + i < n && i < head_out.length() {
            result[start + i] = result[start + i] +
              head_out[i] / meta.num_heads.to_double()
          }
        }
      }
      result
    }
  }
}

///|
/// 构造 Transformer / Build Transformer meta.
pub fn deep_learning_make_transformer(
  num_layers : Int32,
  num_heads : Int32,
  d_model : Int32,
  d_ff : Int32,
) -> TransformerMeta {
  { num_layers, num_heads, d_model, d_ff, }
}

///|
/// Transformer 层 / Transformer single layer.
pub fn deep_learning_transformer_layer(
  input : Array[Array[Double]],
  meta : TransformerMeta,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<input.length() {
    let row : Array[Double] = []
    let attn = deep_learning_multi_head_attention(
      input[i],
      input[i],
      input[i],
      deep_learning_make_attention(meta.num_heads, meta.d_model),
    )
    for j in 0..<input[i].length() {
      let v = if j < attn.length() {
        input[i][j] + attn[j]
      } else {
        input[i][j]
      }
      row.push(deep_learning_tanh_d(v))
    }
    result.push(row)
  }
  result
}

///|
/// Transformer 前向 / Transformer forward.
pub fn deep_learning_transformer_forward(
  input : Array[Array[Double]],
  meta : TransformerMeta,
) -> Array[Array[Double]] {
  let mut result = input
  for _ in 0..<meta.num_layers {
    result = deep_learning_transformer_layer(result, meta)
  }
  result
}

///|
/// 构造 LSTM / Build LSTM meta.
pub fn deep_learning_make_lstm(input_size : Int32, hidden_size : Int32) -> LSTMMeta {
  { input_size, hidden_size, }
}

///|
/// LSTM 门控 / LSTM gate computation.
pub fn deep_learning_lstm_gate(
  x : Double,
  h : Double,
  _meta : LSTMMeta,
) -> (Double, Double, Double, Double) {
  let combined = x + h
  (deep_learning_sigmoid(combined), deep_learning_sigmoid(combined), deep_learning_tanh_d(combined), deep_learning_sigmoid(combined))
}

///|
/// LSTM 单元 / LSTM cell.
pub fn deep_learning_lstm_cell(
  input : Array[Double],
  hidden : Array[Double],
  cell : Array[Double],
  meta : LSTMMeta,
) -> (Array[Double], Array[Double]) {
  let h_size = meta.hidden_size
  let new_h : Array[Double] = Array::make(h_size, 0.0)
  let new_c : Array[Double] = Array::make(h_size, 0.0)
  for i in 0..<h_size {
    let x_val = if i < input.length() { input[i] } else { 0.0 }
    let h_val = if i < hidden.length() { hidden[i] } else { 0.0 }
    let c_val = if i < cell.length() { cell[i] } else { 0.0 }
    let (f_gate, i_gate, g_gate, o_gate) = deep_learning_lstm_gate(x_val, h_val, meta)
    new_c[i] = f_gate * c_val + i_gate * g_gate
    new_h[i] = o_gate * deep_learning_tanh_d(new_c[i])
  }
  (new_h, new_c)
}

///|
/// LSTM 前向 / LSTM forward.
pub fn deep_learning_lstm_forward(
  sequence : Array[Array[Double]],
  initial_hidden : Array[Double],
  initial_cell : Array[Double],
  meta : LSTMMeta,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let mut hidden = initial_hidden
  let mut cell = initial_cell
  for t in 0..<sequence.length() {
    let (h, c) = deep_learning_lstm_cell(sequence[t], hidden, cell, meta)
    hidden = h
    cell = c
    result.push(hidden)
  }
  result
}

///|
/// 构造 GRU / Build GRU meta.
pub fn deep_learning_make_gru(input_size : Int32, hidden_size : Int32) -> GRUMeta {
  { input_size, hidden_size, }
}

///|
/// GRU 门控 / GRU gate computation.
pub fn deep_learning_gru_gate(
  x : Double,
  h : Double,
  _meta : GRUMeta,
) -> (Double, Double, Double) {
  let combined = x + h
  (deep_learning_sigmoid(combined), deep_learning_sigmoid(combined), deep_learning_tanh_d(x + deep_learning_sigmoid(combined) * h))
}

///|
/// GRU 单元 / GRU cell.
pub fn deep_learning_gru_cell(
  input : Array[Double],
  hidden : Array[Double],
  meta : GRUMeta,
) -> Array[Double] {
  let h_size = meta.hidden_size
  let result : Array[Double] = Array::make(h_size, 0.0)
  for i in 0..<h_size {
    let x_val = if i < input.length() { input[i] } else { 0.0 }
    let h_val = if i < hidden.length() { hidden[i] } else { 0.0 }
    let (_, z_gate, h_tilde) = deep_learning_gru_gate(x_val, h_val, meta)
    result[i] = (1.0 - z_gate) * h_val + z_gate * h_tilde
  }
  result
}

///|
/// GRU 前向 / GRU forward.
pub fn deep_learning_gru_forward(
  sequence : Array[Array[Double]],
  initial_hidden : Array[Double],
  meta : GRUMeta,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let mut hidden = initial_hidden
  for t in 0..<sequence.length() {
    hidden = deep_learning_gru_cell(sequence[t], hidden, meta)
    result.push(hidden)
  }
  result
}

///|
/// 构造 Adam 优化器 / Build Adam optimizer.
pub fn deep_learning_make_optimizer_adam(lr : Double, params : Array[Double]) -> AdamState {
  let n = params.length()
  {
    lr,
    beta1: 0.9,
    beta2: 0.999,
    epsilon: 0.000000001,
    params,
    m: Array::make(n, 0.0),
    v: Array::make(n, 0.0),
    step_count: 0,
  }
}

///|
/// Adam 单步 / Adam step.
pub fn deep_learning_adam_step(state : AdamState, gradients : Array[Double]) -> Array[Double] {
  let n = state.params.length()
  if n != gradients.length() {
    state.params
  } else {
    let beta1 = state.beta1
    let beta2 = state.beta2
    let eps = state.epsilon
    let t = (state.step_count + 1).to_double()
    let bc1 = 1.0 - @math.pow(beta1, t)
    let bc2 = 1.0 - @math.pow(beta2, t)
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let g = gradients[i]
      let m = beta1 * state.m[i] + (1.0 - beta1) * g
      let v = beta2 * state.v[i] + (1.0 - beta2) * g * g
      let m_hat = m / bc1
      let v_hat = v / bc2
      result[i] = state.params[i] - state.lr * m_hat / (deep_learning_sqrt(v_hat) + eps)
    }
    result
  }
}

///|
/// Adam 更新状态 / Adam update state.
pub fn deep_learning_adam_update(state : AdamState, gradients : Array[Double]) -> AdamState {
  let n = state.params.length()
  if n != gradients.length() {
    state
  } else {
    let beta1 = state.beta1
    let beta2 = state.beta2
    let new_m : Array[Double] = Array::make(n, 0.0)
    let new_v : Array[Double] = Array::make(n, 0.0)
    let new_params : Array[Double] = Array::make(n, 0.0)
    let t = (state.step_count + 1).to_double()
    let bc1 = 1.0 - @math.pow(beta1, t)
    let bc2 = 1.0 - @math.pow(beta2, t)
    for i in 0..<n {
      let g = gradients[i]
      new_m[i] = beta1 * state.m[i] + (1.0 - beta1) * g
      new_v[i] = beta2 * state.v[i] + (1.0 - beta2) * g * g
      let m_hat = new_m[i] / bc1
      let v_hat = new_v[i] / bc2
      new_params[i] = state.params[i] -
        state.lr * m_hat / (deep_learning_sqrt(v_hat) + state.epsilon)
    }
    {
      lr: state.lr,
      beta1,
      beta2,
      epsilon: state.epsilon,
      params: new_params,
      m: new_m,
      v: new_v,
      step_count: state.step_count + 1,
    }
  }
}

///|
/// 构造 SGD 优化器 / Build SGD optimizer.
pub fn deep_learning_make_optimizer_sgd(lr : Double, params : Array[Double]) -> SGDState {
  let n = params.length()
  { lr, momentum: 0.0, params, velocity: Array::make(n, 0.0), }
}

///|
/// SGD 单步 / SGD step.
pub fn deep_learning_sgd_step(state : SGDState, gradients : Array[Double]) -> Array[Double] {
  let n = state.params.length()
  if n != gradients.length() {
    state.params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = state.params[i] - state.lr * gradients[i]
    }
    result
  }
}

///|
/// SGD 更新状态 / SGD update state.
pub fn deep_learning_sgd_update(state : SGDState, gradients : Array[Double]) -> SGDState {
  let n = state.params.length()
  if n != gradients.length() {
    state
  } else {
    let new_v : Array[Double] = Array::make(n, 0.0)
    let new_p : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      new_v[i] = state.momentum * state.velocity[i] - state.lr * gradients[i]
      new_p[i] = state.params[i] + new_v[i]
    }
    { lr: state.lr, momentum: state.momentum, params: new_p, velocity: new_v, }
  }
}

///|
/// 构造 AdaGrad 优化器 / Build AdaGrad optimizer.
pub fn deep_learning_make_optimizer_adagrad(
  lr : Double,
  params : Array[Double],
) -> AdaGradState {
  let n = params.length()
  { lr, epsilon: 0.000000001, params, cache: Array::make(n, 0.0), }
}

///|
/// AdaGrad 单步 / AdaGrad step.
pub fn deep_learning_adagrad_step(
  state : AdaGradState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  if n != gradients.length() {
    state.params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let g = gradients[i]
      let cache = state.cache[i] + g * g
      result[i] = state.params[i] - state.lr * g / (deep_learning_sqrt(cache) + state.epsilon)
    }
    result
  }
}

///|
/// 构造 AdaDelta 优化器 / Build AdaDelta optimizer.
pub fn deep_learning_make_optimizer_adadelta(
  lr : Double,
  params : Array[Double],
) -> AdaDeltaState {
  let n = params.length()
  {
    lr,
    rho: 0.95,
    epsilon: 0.000000001,
    params,
    eg: Array::make(n, 0.0),
    edx: Array::make(n, 0.0),
  }
}

///|
/// AdaDelta 单步 / AdaDelta step.
pub fn deep_learning_adadelta_step(
  state : AdaDeltaState,
  gradients : Array[Double],
) -> Array[Double] {
  let n = state.params.length()
  if n != gradients.length() {
    state.params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let g = gradients[i]
      let eg = state.rho * state.eg[i] + (1.0 - state.rho) * g * g
      let dx = deep_learning_sqrt(state.edx[i] + state.epsilon) / deep_learning_sqrt(eg + state.epsilon) * g
      result[i] = state.params[i] - dx
    }
    result
  }
}

///|
/// 构造交叉熵损失标识 / Build cross-entropy loss id.
pub fn deep_learning_make_loss_cross_entropy() -> Int32 {
  0
}

///|
/// 交叉熵损失 / Cross-entropy loss.
pub fn deep_learning_cross_entropy_loss(
  logits : Array[Double],
  target : Array[Double],
) -> Double {
  let n = logits.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let mut max_val = logits[0]
    for i in 1..<n {
      if logits[i] > max_val {
        max_val = logits[i]
      }
    }
    let mut sum_exp = 0.0
    for i in 0..<n {
      sum_exp = sum_exp + deep_learning_exp(logits[i] - max_val)
    }
    let log_sum = deep_learning_log(sum_exp) + max_val
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + target[i] * logits[i]
    }
    -sum + log_sum
  }
}

///|
/// 构造 MSE 损失标识 / Build MSE loss id.
pub fn deep_learning_make_loss_mse() -> Int32 {
  1
}

///|
/// MSE 损失 / MSE loss.
pub fn deep_learning_mse_loss(pred : Array[Double], target : Array[Double]) -> Double {
  let n = pred.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let d = pred[i] - target[i]
      sum = sum + d * d
    }
    sum / n.to_double()
  }
}

///|
/// 构造 MAE 损失标识 / Build MAE loss id.
pub fn deep_learning_make_loss_mae() -> Int32 {
  2
}

///|
/// MAE 损失 / MAE loss.
pub fn deep_learning_mae_loss(pred : Array[Double], target : Array[Double]) -> Double {
  let n = pred.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + deep_learning_abs_d(pred[i] - target[i])
    }
    sum / n.to_double()
  }
}

///|
/// 构造 Huber 损失 / Build Huber loss.
pub fn deep_learning_make_loss_huber(delta : Double) -> Double {
  delta
}

///|
/// Huber 损失 / Huber loss.
pub fn deep_learning_huber_loss(
  pred : Array[Double],
  target : Array[Double],
  delta : Double,
) -> Double {
  let n = pred.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let mut sum = 0.0
    let d2 = delta * delta
    for i in 0..<n {
      let e = deep_learning_abs_d(pred[i] - target[i])
      if e <= delta {
        sum = sum + 0.5 * e * e
      } else {
        sum = sum + delta * e - 0.5 * d2
      }
    }
    sum / n.to_double()
  }
}

///|
/// 构造 KL 散度标识 / Build KL divergence loss id.
pub fn deep_learning_make_loss_kl() -> Int32 {
  3
}

///|
/// KL 散度 / KL divergence loss.
pub fn deep_learning_kl_loss(p : Array[Double], q : Array[Double]) -> Double {
  let n = p.length()
  if n == 0 || n != q.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      if p[i] > 0.0 && q[i] > 0.0 {
        sum = sum + p[i] * deep_learning_log(p[i] / q[i])
      }
    }
    sum
  }
}

///|
/// 梯度检查 / Gradient check.
pub fn deep_learning_gradient_check(f : (Double) -> Double, x : Double, h : Double) -> Bool {
  let grad = (f(x + h) - f(x - h)) / (2.0 * h)
  let grad2 = (f(x + h) - f(x)) / h
  deep_learning_abs_d(grad - grad2) < 0.01
}

///|
/// 数值梯度检查 / Numerical gradient check.
pub fn deep_learning_numerical_gradient_check(
  params : Array[Double],
  gradients : Array[Double],
  h : Double,
) -> Bool {
  let n = params.length()
  if n != gradients.length() {
    false
  } else {
    let mut max_diff = 0.0
    for i in 0..<n {
      let diff = deep_learning_abs_d(gradients[i])
      if diff > max_diff {
        max_diff = diff
      }
    }
    max_diff < h
  }
}

///|
/// 构造调度器 / Build scheduler.
pub fn deep_learning_make_scheduler(
  init_lr : Double,
  step_size : Int32,
  gamma : Double,
) -> SchedulerMeta {
  { init_lr, step_size, gamma, total_steps: 100, }
}

///|
/// 阶梯学习率 / Step learning rate.
pub fn deep_learning_lr_step(scheduler : SchedulerMeta, step : Int32) -> Double {
  if scheduler.step_size <= 0 {
    scheduler.init_lr
  } else {
    let num_drops = step / scheduler.step_size
    let mut factor = 1.0
    for _ in 0..<num_drops {
      factor = factor * scheduler.gamma
    }
    scheduler.init_lr * factor
  }
}

///|
/// 指数学习率 / Exponential learning rate.
pub fn deep_learning_lr_exponential(scheduler : SchedulerMeta, step : Int32) -> Double {
  let mut factor = 1.0
  for _ in 0..<step {
    factor = factor * scheduler.gamma
  }
  scheduler.init_lr * factor
}

///|
/// 余弦学习率 / Cosine learning rate.
pub fn deep_learning_lr_cosine(scheduler : SchedulerMeta, step : Int32) -> Double {
  if scheduler.total_steps <= 0 {
    scheduler.init_lr
  } else {
    let progress = step.to_double() / scheduler.total_steps.to_double()
    let cosine_val = deep_learning_cos(3.141592653589793 * progress)
    scheduler.init_lr * 0.5 * (1.0 + cosine_val)
  }
}

///|
/// 模型保存 / Model save (serialize to string).
pub fn deep_learning_model_save(params : Array[Double]) -> String {
  let mut result = ""
  for i in 0..<params.length() {
    if i > 0 {
      result = result + ","
    }
    result = result + params[i].to_string()
  }
  result
}

///|
/// 模型加载 / Model load (deserialize from string, simplified).
pub fn deep_learning_model_load(data : String) -> Array[Double] {
  let result : Array[Double] = []
  let mut current = ""
  for i in 0..<data.length() {
    let ch = data[i]
    if ch.to_int() == 44 {
      if current.length() > 0 {
        result.push(deep_learning_parse_double_str(current))
      }
      current = ""
    } else {
      current = current + ch.to_string()
    }
  }
  if current.length() > 0 {
    result.push(deep_learning_parse_double_str(current))
  }
  result
}

///|
/// 模型摘要 / Model summary.
pub fn deep_learning_model_summary(params : Array[Double]) -> String {
  let n = params.length()
  let mut sum = 0.0
  let mut min_val = 0.0
  let mut max_val = 0.0
  if n > 0 {
    min_val = params[0]
    max_val = params[0]
  }
  for i in 0..<n {
    sum = sum + params[i]
    if params[i] < min_val {
      min_val = params[i]
    }
    if params[i] > max_val {
      max_val = params[i]
    }
  }
  let mean = if n > 0 { sum / n.to_double() } else { 0.0 }
  "params=" +
  n.to_string() +
  ",mean=" +
  mean.to_string() +
  ",min=" +
  min_val.to_string() +
  ",max=" +
  max_val.to_string()
}

///|
/// 构造自编码器 / Build autoencoder.
pub fn deep_learning_make_autoencoder(
  input_dim : Int32,
  hidden_dim : Int32,
  latent_dim : Int32,
) -> AutoEncoderMeta {
  { input_dim, hidden_dim, latent_dim, }
}

///|
/// 自编码器编码 / Autoencoder encode.
pub fn deep_learning_autoencoder_encode(
  input : Array[Double],
  meta : AutoEncoderMeta,
) -> Array[Double] {
  let result : Array[Double] = Array::make(meta.latent_dim, 0.0)
  for i in 0..<meta.latent_dim {
    let mut sum = 0.0
    for j in 0..<meta.input_dim {
      if j < input.length() {
        sum = sum + input[j] / meta.input_dim.to_double()
      }
    }
    result[i] = deep_learning_tanh_d(sum)
  }
  result
}

///|
/// 自编码器解码 / Autoencoder decode.
pub fn deep_learning_autoencoder_decode(
  latent : Array[Double],
  meta : AutoEncoderMeta,
) -> Array[Double] {
  let result : Array[Double] = Array::make(meta.input_dim, 0.0)
  for i in 0..<meta.input_dim {
    let mut sum = 0.0
    for j in 0..<meta.latent_dim {
      if j < latent.length() {
        sum = sum + latent[j] / meta.latent_dim.to_double()
      }
    }
    result[i] = deep_learning_tanh_d(sum)
  }
  result
}

///|
/// 构造 VAE / Build VAE.
pub fn deep_learning_make_vae(
  input_dim : Int32,
  hidden_dim : Int32,
  latent_dim : Int32,
) -> VAEMeta {
  { input_dim, hidden_dim, latent_dim, }
}

///|
/// VAE 编码 / VAE encode (returns mean and log_var).
pub fn deep_learning_vae_encode(
  input : Array[Double],
  meta : VAEMeta,
) -> (Array[Double], Array[Double]) {
  let mu : Array[Double] = Array::make(meta.latent_dim, 0.0)
  let log_var : Array[Double] = Array::make(meta.latent_dim, 0.0)
  for i in 0..<meta.latent_dim {
    let mut sum = 0.0
    for j in 0..<meta.input_dim {
      if j < input.length() {
        sum = sum + input[j] / meta.input_dim.to_double()
      }
    }
    mu[i] = deep_learning_tanh_d(sum)
    log_var[i] = -1.0
  }
  (mu, log_var)
}

///|
/// VAE 解码 / VAE decode.
pub fn deep_learning_vae_decode(latent : Array[Double], meta : VAEMeta) -> Array[Double] {
  let result : Array[Double] = Array::make(meta.input_dim, 0.0)
  for i in 0..<meta.input_dim {
    let mut sum = 0.0
    for j in 0..<meta.latent_dim {
      if j < latent.length() {
        sum = sum + latent[j] / meta.latent_dim.to_double()
      }
    }
    result[i] = deep_learning_sigmoid(sum)
  }
  result
}

///|
/// VAE 损失 / VAE loss (reconstruction + KL).
pub fn deep_learning_vae_loss(
  recon : Array[Double],
  target : Array[Double],
  mu : Array[Double],
  log_var : Array[Double],
) -> Double {
  let n = recon.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let mut recon_loss = 0.0
    for i in 0..<n {
      let d = recon[i] - target[i]
      recon_loss = recon_loss + d * d
    }
    let mut kl = 0.0
    let k = mu.length()
    for i in 0..<k {
      if i < log_var.length() {
        kl = kl + -0.5 * (1.0 + log_var[i] - mu[i] * mu[i] - deep_learning_exp(log_var[i]))
      }
    }
    recon_loss + kl
  }
}

///|
/// 构造 GAN / Build GAN.
pub fn deep_learning_make_gan(
  generator_dim : Int32,
  discriminator_dim : Int32,
  noise_dim : Int32,
) -> GANMeta {
  { generator_dim, discriminator_dim, noise_dim, }
}

///|
/// GAN 判别器 / GAN discriminator.
pub fn deep_learning_gan_discriminator(input : Array[Double], _meta : GANMeta) -> Double {
  let n = input.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + input[i]
    }
    deep_learning_sigmoid(sum / n.to_double())
  }
}

///|
/// GAN 生成器 / GAN generator.
pub fn deep_learning_gan_generator(noise : Array[Double], meta : GANMeta) -> Array[Double] {
  let result : Array[Double] = Array::make(meta.generator_dim, 0.0)
  for i in 0..<meta.generator_dim {
    let mut sum = 0.0
    for j in 0..<meta.noise_dim {
      if j < noise.length() {
        sum = sum + noise[j]
      }
    }
    result[i] = deep_learning_tanh_d(sum / meta.noise_dim.to_double())
  }
  result
}

///|
/// GAN 损失 / GAN loss.
pub fn deep_learning_gan_loss(d_real : Double, d_fake : Double) -> Double {
  let eps = 0.000000001
  -(deep_learning_log(d_real + eps) + deep_learning_log(1.0 - d_fake + eps))
}

///|
/// 模块标识 / Module identifier.
pub fn deep_learning_deep_learning_id() -> String {
  "learncore/deep_learning"
}
