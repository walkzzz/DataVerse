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

/// 激活函数 / Activation function.
pub(all) enum Activation {
  ReLU
  Sigmoid
  Tanh
  Identity
} derive(Debug, Eq)

pub extend Activation with Eq::{equal, not_equal}
pub extend Activation with Debug::{to_repr}

/// 线性层 / Linear layer: y = Wx + b.
pub struct LinearLayer {
  weights : Array[Array[Double]]
  bias : Array[Double]
  in_dim : Int
  out_dim : Int
} derive(Debug, Eq)

pub extend LinearLayer with Eq::{equal, not_equal}
pub extend LinearLayer with Debug::{to_repr}

/// 构造线性层（零初始化）/ Build linear layer (zero-init).
pub fn make_linear_layer(in_dim : Int, out_dim : Int) -> LinearLayer {
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
  { weights: w, bias: b, in_dim, out_dim }
}

/// 构造线性层（指定权重）/ Build linear layer with given weights.
pub fn make_linear_layer_with_weights(
  weights : Array[Array[Double]],
  bias : Array[Double],
  in_dim : Int,
  out_dim : Int
) -> LinearLayer {
  { weights, bias, in_dim, out_dim }
}

/// 线性层前向传播 / Linear layer forward pass.
///
/// y = Wx + b。退化安全：输入维度不匹配返回空数组。
pub fn linear_forward(layer : LinearLayer, input : Array[Double]) -> Array[Double] {
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

/// 激活函数前向传播 / Apply activation to an array.
pub fn activation_forward(act : Activation, input : Array[Double]) -> Array[Double] {
  input.map(fn(x) { activate(act, x) })
}

/// 激活函数名称 / Activation name.
pub fn activation_name(act : Activation) -> String {
  match act {
    ReLU => "relu"
    Sigmoid => "sigmoid"
    Tanh => "tanh"
    Identity => "identity"
  }
}

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

pub fn dl_layers_id() -> String {
  "learncore/dl_layers"
}
// ============================================================
// S2.9 DL 扩展层 / Extended DL Layers
// ============================================================

/// Conv2d 配置 / Conv2d configuration.
pub struct Conv2dMeta {
  in_channels : Int
  out_channels : Int
  kernel_size : Int
  stride : Int
  padding : Int
} derive(Debug, Eq)

pub extend Conv2dMeta with Eq::{equal, not_equal}
pub extend Conv2dMeta with Debug::{to_repr}

/// 构造 Conv2d 配置 / Build Conv2d meta.
pub fn make_conv2d(in_channels : Int, out_channels : Int, kernel_size : Int, stride : Int, padding : Int) -> Conv2dMeta {
  { in_channels, out_channels, kernel_size, stride, padding }
}

/// Conv2d 输出维度 / Conv2d output dimension.
///
/// 公式：`(input + 2*padding - kernel) / stride + 1`。
/// 退化安全：stride <= 0 返回 0。
pub fn conv2d_output_dim(input_dim : Int, meta : Conv2dMeta) -> Int {
  if meta.stride <= 0 {
    0
  } else {
    (input_dim + 2 * meta.padding - meta.kernel_size) / meta.stride + 1
  }
}

/// MaxPool 配置 / MaxPool configuration.
pub struct MaxPoolMeta {
  kernel_size : Int
  stride : Int
} derive(Debug, Eq)

pub extend MaxPoolMeta with Eq::{equal, not_equal}
pub extend MaxPoolMeta with Debug::{to_repr}

/// 构造 MaxPool 配置 / Build MaxPool meta.
pub fn make_maxpool(kernel_size : Int, stride : Int) -> MaxPoolMeta {
  { kernel_size, stride }
}

/// MaxPool 输出维度 / MaxPool output dimension.
///
/// 公式：`(input - kernel) / stride + 1`。
/// 退化安全：stride <= 0 返回 0。
pub fn maxpool_output_dim(input_dim : Int, meta : MaxPoolMeta) -> Int {
  if meta.stride <= 0 {
    0
  } else {
    (input_dim - meta.kernel_size) / meta.stride + 1
  }
}

/// Dropout 模式 / Dropout mode.
pub(all) enum DropoutMode {
  Training
  Inference
} derive(Debug, Eq)

pub extend DropoutMode with Eq::{equal, not_equal}
pub extend DropoutMode with Debug::{to_repr}

/// Dropout 前向传播 / Dropout forward.
///
/// 训练模式：确定性模拟（每隔 1/rate 置零），推理模式：原样返回。
/// 退化安全：rate <= 0 或 rate >= 1 返回原输入。
pub fn dropout_forward(input : Array[Double], rate : Double, mode : DropoutMode) -> Array[Double] {
  match mode {
    Inference => input
    Training => {
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
}

/// BatchNorm 配置 / BatchNorm configuration.
pub struct BatchNormMeta {
  num_features : Int
  epsilon : Double
  gamma : Array[Double]
  beta : Array[Double]
} derive(Debug, Eq)

pub extend BatchNormMeta with Eq::{equal, not_equal}
pub extend BatchNormMeta with Debug::{to_repr}

/// 构造 BatchNorm 配置（单位变换）/ Build BatchNorm meta (identity).
pub fn make_batchnorm(num_features : Int, epsilon : Double) -> BatchNormMeta {
  let g : Array[Double] = []
  let b : Array[Double] = []
  for _ in 0..<num_features {
    g.push(1.0)
    b.push(0.0)
  }
  { num_features, epsilon, gamma: g, beta: b }
}

/// BatchNorm 前向传播 / BatchNorm forward.
///
/// 公式：`gamma * (x - mean) / sqrt(var + epsilon) + beta`。
/// 退化安全：空输入返回空数组。
pub fn batchnorm_forward(input : Array[Double], meta : BatchNormMeta) -> Array[Double] {
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

/// Dropout 模式名称 / Dropout mode name.
pub fn dropout_mode_name(mode : DropoutMode) -> String {
  match mode {
    Training => "training"
    Inference => "inference"
  }
}