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