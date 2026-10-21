///|
/// # learncore/transfer_learning 迁移学习 / Transfer Learning
///
/// 迁移学习族：预训练微调、域适配、DANN、渐进式、知识蒸馏、Adapter、LoRA、Prefix/Prompt Tuning。
///
/// # Transfer Learning
///
/// Pretrain-finetune, domain adaptation, DANN, progressive, distillation, Adapter, LoRA, Prefix/Prompt Tuning.

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

fn abs_d(x : Double) -> Double {
  if x < 0.0 { -x } else { x }
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

/// 迁移配置 / Transfer configuration.
pub struct TransferConfig {
  source_model : String
  target_task : String
  freeze_ratio : Double
  lr : Double
  num_layers : Int
  seed : Int
} derive(Debug, Eq)

pub extend TransferConfig with Eq::{equal, not_equal}
pub extend TransferConfig with Debug::{to_repr}

/// 预训练模型 / Pretrained model.
pub struct PretrainedModel {
  name : String
  layers : Array[Array[Double]]
  layer_names : Array[String]
  input_dim : Int
  output_dim : Int
} derive(Debug, Eq)

pub extend PretrainedModel with Eq::{equal, not_equal}
pub extend PretrainedModel with Debug::{to_repr}

/// 特征提取器 / Feature extractor.
pub struct FeatureExtractor {
  backbone : PretrainedModel
  output_dim : Int
  frozen : Bool
} derive(Debug, Eq)

pub extend FeatureExtractor with Eq::{equal, not_equal}
pub extend FeatureExtractor with Debug::{to_repr}

/// 域适配器 / Domain adapter.
pub struct DomainAdapter {
  source_dim : Int
  target_dim : Int
  weights : Array[Array[Double]]
  bias : Array[Double]
} derive(Debug, Eq)

pub extend DomainAdapter with Eq::{equal, not_equal}
pub extend DomainAdapter with Debug::{to_repr}

/// DANN 模型 / DANN model.
pub struct DANNModel {
  feature_dim : Int
  num_classes : Int
  lambda_grl : Double
  feature_weights : Array[Array[Double]]
  class_weights : Array[Array[Double]]
  domain_weights : Array[Array[Double]]
} derive(Debug, Eq)

pub extend DANNModel with Eq::{equal, not_equal}
pub extend DANNModel with Debug::{to_repr}

/// 渐进式模型 / Progressive model.
pub struct ProgressiveModel {
  max_layers : Int
  current_layers : Int
  layer_weights : Array[Array[Array[Double]]]
} derive(Debug, Eq)

pub extend ProgressiveModel with Eq::{equal, not_equal}
pub extend ProgressiveModel with Debug::{to_repr}

/// 蒸馏配置 / Distillation configuration.
pub struct DistillationConfig {
  teacher : PretrainedModel
  student : PretrainedModel
  temperature : Double
  alpha : Double
} derive(Debug, Eq)

pub extend DistillationConfig with Eq::{equal, not_equal}
pub extend DistillationConfig with Debug::{to_repr}

/// Adapter 模块 / Adapter module.
pub struct AdapterModule {
  input_dim : Int
  bottleneck_dim : Int
  down_weights : Array[Array[Double]]
  up_weights : Array[Array[Double]]
} derive(Debug, Eq)

pub extend AdapterModule with Eq::{equal, not_equal}
pub extend AdapterModule with Debug::{to_repr}

/// LoRA 模块 / LoRA module.
pub struct LoRAModule {
  input_dim : Int
  rank : Int
  a_weights : Array[Array[Double]]
  b_weights : Array[Array[Double]]
  scaling : Double
} derive(Debug, Eq)

pub extend LoRAModule with Eq::{equal, not_equal}
pub extend LoRAModule with Debug::{to_repr}

/// Prefix Tuning 配置 / Prefix tuning configuration.
pub struct PrefixTuning {
  num_layers : Int
  prefix_len : Int
  embed_dim : Int
  prefix_weights : Array[Array[Double]]
} derive(Debug, Eq)

pub extend PrefixTuning with Eq::{equal, not_equal}
pub extend PrefixTuning with Debug::{to_repr}

/// Prompt Tuning 配置 / Prompt tuning configuration.
pub struct PromptTuning {
  prompt_len : Int
  embed_dim : Int
  prompt_params : Array[Array[Double]]
} derive(Debug, Eq)

pub extend PromptTuning with Eq::{equal, not_equal}
pub extend PromptTuning with Debug::{to_repr}

/// 源-目标对 / Source-target pair.
pub struct SourceTarget {
  source_data : Array[Array[Double]]
  target_data : Array[Array[Double]]
  source_labels : Array[Int]
  target_labels : Array[Int]
} derive(Debug, Eq)

pub extend SourceTarget with Eq::{equal, not_equal}
pub extend SourceTarget with Debug::{to_repr}

/// 构造迁移配置 / Build transfer configuration.
pub fn make_transfer_config(source_model : String, target_task : String, freeze_ratio : Double, lr : Double, num_layers : Int, seed : Int) -> TransferConfig {
  { source_model, target_task, freeze_ratio, lr, num_layers, seed }
}

/// 预训练迁移 / Transfer pretrained.
pub fn transfer_pretrained(config : TransferConfig, model : PretrainedModel) -> PretrainedModel {
  let freeze_count = (model.layers.length().to_double() * config.freeze_ratio).to_int()
  let new_layers : Array[Array[Double]] = []
  let new_names : Array[String] = []
  for i in 0..<model.layers.length() {
    if i < freeze_count {
      let layer_copy : Array[Double] = []
      for j in 0..<model.layers[i].length() {
        layer_copy.push(model.layers[i][j])
      }
      new_layers.push(layer_copy)
    } else {
      let layer_new : Array[Double] = []
      for j in 0..<model.layers[i].length() {
        let r = rand_double(config.seed + i * 31 + j) * 0.02 - 0.01
        layer_new.push(model.layers[i][j] + r * config.lr)
      }
      new_layers.push(layer_new)
    }
    if i < model.layer_names.length() {
      new_names.push(model.layer_names[i])
    } else {
      new_names.push("layer_" + i.to_string())
    }
  }
  { name: model.name, layers: new_layers, layer_names: new_names, input_dim: model.input_dim, output_dim: model.output_dim }
}

/// 微调 / Fine-tune.
pub fn transfer_finetune(config : TransferConfig, model : PretrainedModel, gradients : Array[Array[Double]]) -> PretrainedModel {
  let n = model.layers.length()
  let new_layers : Array[Array[Double]] = []
  for i in 0..<n {
    let layer : Array[Double] = []
    let grad = if i < gradients.length() { gradients[i] } else { [] }
    for j in 0..<model.layers[i].length() {
      let g = if j < grad.length() { grad[j] } else { 0.0 }
      layer.push(model.layers[i][j] - config.lr * g)
    }
    new_layers.push(layer)
  }
  { name: model.name, layers: new_layers, layer_names: model.layer_names, input_dim: model.input_dim, output_dim: model.output_dim }
}

/// 冻结层 / Freeze layers.
pub fn freeze_layers(model : PretrainedModel, layer_indices : Array[Int]) -> PretrainedModel {
  let new_layers : Array[Array[Double]] = []
  for i in 0..<model.layers.length() {
    let layer : Array[Double] = []
    let is_frozen = {
      let mut found = false
      for k in 0..<layer_indices.length() {
        if layer_indices[k] == i {
          found = true
        }
      }
      found
    }
    for j in 0..<model.layers[i].length() {
      if is_frozen {
        layer.push(0.0)
      } else {
        layer.push(model.layers[i][j])
      }
    }
    new_layers.push(layer)
  }
  { name: model.name, layers: new_layers, layer_names: model.layer_names, input_dim: model.input_dim, output_dim: model.output_dim }
}

/// 解冻层 / Unfreeze layers.
pub fn unfreeze_layers(model : PretrainedModel, _layer_indices : Array[Int]) -> PretrainedModel {
  model
}

/// 冻结 backbone / Freeze backbone.
pub fn freeze_backbone(extractor : FeatureExtractor) -> FeatureExtractor {
  { backbone: extractor.backbone, output_dim: extractor.output_dim, frozen: true }
}

/// 构造特征提取器 / Build feature extractor.
pub fn make_feature_extractor(backbone : PretrainedModel, output_dim : Int, frozen : Bool) -> FeatureExtractor {
  { backbone, output_dim, frozen }
}

/// 提取迁移特征 / Extract transfer features.
pub fn extract_features_transfer(extractor : FeatureExtractor, input : Array[Double]) -> Array[Double] {
  let mut current = input
  for i in 0..<extractor.backbone.layers.length() {
    let layer = extractor.backbone.layers[i]
    let out_size = layer.length() / extractor.backbone.input_dim
    let next : Array[Double] = Array::make(if out_size > 0 { out_size } else { 1 }, 0.0)
    for j in 0..<next.length() {
      let mut sum = 0.0
      for k in 0..<current.length() {
        let idx = j * current.length() + k
        if idx < layer.length() {
          sum = sum + layer[idx] * current[k]
        }
      }
      next[j] = tanh_d(sum)
    }
    current = next
  }
  if current.length() > extractor.output_dim {
    let result : Array[Double] = Array::make(extractor.output_dim, 0.0)
    for i in 0..<extractor.output_dim {
      result[i] = current[i]
    }
    result
  } else {
    current
  }
}

/// 构造域适配器 / Build domain adapter.
pub fn make_domain_adapter(source_dim : Int, target_dim : Int, seed : Int) -> DomainAdapter {
  let weights : Array[Array[Double]] = Array::make(target_dim, Array::make(source_dim, 0.0))
  for i in 0..<target_dim {
    for j in 0..<source_dim {
      weights[i][j] = rand_double(seed + i * source_dim + j) * 2.0 - 1.0
    }
  }
  let bias : Array[Double] = Array::make(target_dim, 0.0)
  for i in 0..<target_dim {
    bias[i] = rand_double(seed + 1000 + i) * 0.1
  }
  { source_dim, target_dim, weights, bias }
}

/// 域适配 / Adapt domain.
pub fn adapt_domain(adapter : DomainAdapter, source_feature : Array[Double]) -> Array[Double] {
  let result : Array[Double] = Array::make(adapter.target_dim, 0.0)
  for i in 0..<adapter.target_dim {
    let mut sum = adapter.bias[i]
    for j in 0..<adapter.source_dim {
      if j < source_feature.length() {
        sum = sum + adapter.weights[i][j] * source_feature[j]
      }
    }
    result[i] = tanh_d(sum)
  }
  result
}

/// 域对齐 / Domain alignment.
pub fn domain_alignment(source : Array[Array[Double]], target : Array[Array[Double]]) -> Double {
  let ns = source.length()
  let nt = target.length()
  if ns == 0 || nt == 0 {
    return 0.0
  }
  let dim = source[0].length()
  let mu_s : Array[Double] = Array::make(dim, 0.0)
  let mu_t : Array[Double] = Array::make(dim, 0.0)
  for i in 0..<ns {
    for d in 0..<dim {
      if d < source[i].length() {
        mu_s[d] = mu_s[d] + source[i][d]
      }
    }
  }
  for i in 0..<nt {
    for d in 0..<dim {
      if d < target[i].length() {
        mu_t[d] = mu_t[d] + target[i][d]
      }
    }
  }
  let mut dist = 0.0
  for d in 0..<dim {
    mu_s[d] = mu_s[d] / ns.to_double()
    mu_t[d] = mu_t[d] / nt.to_double()
    dist = dist + (mu_s[d] - mu_t[d]) * (mu_s[d] - mu_t[d])
  }
  sqrt(dist)
}

/// 构造 MMD 损失 / Build MMD loss.
pub fn make_mmd_loss(source : Array[Array[Double]], target : Array[Array[Double]]) -> Double {
  let ns = source.length()
  let nt = target.length()
  if ns == 0 || nt == 0 {
    return 0.0
  }
  let mut s_sum = 0.0
  for i in 0..<ns {
    for j in 0..<ns {
      let dim = source[i].length()
      let mut k = 0.0
      for d in 0..<dim {
        if d < source[j].length() {
          let diff = source[i][d] - source[j][d]
          k = k + diff * diff
        }
      }
      s_sum = s_sum + exp(-k / 2.0)
    }
  }
  let mut t_sum = 0.0
  for i in 0..<nt {
    for j in 0..<nt {
      let dim = target[i].length()
      let mut k = 0.0
      for d in 0..<dim {
        if d < target[j].length() {
          let diff = target[i][d] - target[j][d]
          k = k + diff * diff
        }
      }
      t_sum = t_sum + exp(-k / 2.0)
    }
  }
  let mut c_sum = 0.0
  for i in 0..<ns {
    for j in 0..<nt {
      let dim = source[i].length()
      let mut k = 0.0
      for d in 0..<dim {
        if d < target[j].length() {
          let diff = source[i][d] - target[j][d]
          k = k + diff * diff
        }
      }
      c_sum = c_sum + exp(-k / 2.0)
    }
  }
  s_sum / (ns * ns).to_double() + t_sum / (nt * nt).to_double() - 2.0 * c_sum / (ns * nt).to_double()
}

/// MMD 距离 / MMD distance.
pub fn mmd_distance(source : Array[Array[Double]], target : Array[Array[Double]]) -> Double {
  make_mmd_loss(source, target)
}

/// CORAL 损失 / CORAL loss.
pub fn coral_loss(source : Array[Array[Double]], target : Array[Array[Double]]) -> Double {
  let ns = source.length()
  let nt = target.length()
  if ns == 0 || nt == 0 {
    return 0.0
  }
  let dim = source[0].length()
  let mu_s : Array[Double] = Array::make(dim, 0.0)
  let mu_t : Array[Double] = Array::make(dim, 0.0)
  for i in 0..<ns {
    for d in 0..<dim {
      if d < source[i].length() {
        mu_s[d] = mu_s[d] + source[i][d]
      }
    }
  }
  for i in 0..<nt {
    for d in 0..<dim {
      if d < target[i].length() {
        mu_t[d] = mu_t[d] + target[i][d]
      }
    }
  }
  for d in 0..<dim {
    mu_s[d] = mu_s[d] / ns.to_double()
    mu_t[d] = mu_t[d] / nt.to_double()
  }
  let cov_s : Array[Array[Double]] = Array::make(dim, Array::make(dim, 0.0))
  let cov_t : Array[Array[Double]] = Array::make(dim, Array::make(dim, 0.0))
  for i in 0..<ns {
    for a in 0..<dim {
      for b in 0..<dim {
        if a < source[i].length() && b < source[i].length() {
          cov_s[a][b] = cov_s[a][b] + (source[i][a] - mu_s[a]) * (source[i][b] - mu_s[b])
        }
      }
    }
  }
  for i in 0..<nt {
    for a in 0..<dim {
      for b in 0..<dim {
        if a < target[i].length() && b < target[i].length() {
          cov_t[a][b] = cov_t[a][b] + (target[i][a] - mu_t[a]) * (target[i][b] - mu_t[b])
        }
      }
    }
  }
  let mut loss = 0.0
  for a in 0..<dim {
    for b in 0..<dim {
      let d = cov_s[a][b] / ns.to_double() - cov_t[a][b] / nt.to_double()
      loss = loss + d * d
    }
  }
  loss / 4.0
}

/// 构造 DANN / Build DANN.
pub fn make_dann(feature_dim : Int, num_classes : Int, lambda_grl : Double, seed : Int) -> DANNModel {
  let fw : Array[Array[Double]] = Array::make(feature_dim, Array::make(feature_dim, 0.0))
  let cw : Array[Array[Double]] = Array::make(num_classes, Array::make(feature_dim, 0.0))
  let dw : Array[Array[Double]] = Array::make(2, Array::make(feature_dim, 0.0))
  for i in 0..<feature_dim {
    for j in 0..<feature_dim {
      fw[i][j] = rand_double(seed + i * feature_dim + j) * 2.0 - 1.0
    }
  }
  for i in 0..<num_classes {
    for j in 0..<feature_dim {
      cw[i][j] = rand_double(seed + 1000 + i * feature_dim + j) * 2.0 - 1.0
    }
  }
  for i in 0..<2 {
    for j in 0..<feature_dim {
      dw[i][j] = rand_double(seed + 2000 + i * feature_dim + j) * 2.0 - 1.0
    }
  }
  { feature_dim, num_classes, lambda_grl, feature_weights: fw, class_weights: cw, domain_weights: dw }
}

/// DANN 前向 / DANN forward.
pub fn dann_forward(model : DANNModel, input : Array[Double]) -> (Array[Double], Double) {
  let feature : Array[Double] = Array::make(model.feature_dim, 0.0)
  for i in 0..<model.feature_dim {
    let mut sum = 0.0
    for j in 0..<model.feature_dim {
      if j < input.length() {
        sum = sum + model.feature_weights[i][j] * input[j]
      }
    }
    feature[i] = tanh_d(sum)
  }
  let class_out : Array[Double] = Array::make(model.num_classes, 0.0)
  for i in 0..<model.num_classes {
    let mut sum = 0.0
    for j in 0..<model.feature_dim {
      sum = sum + model.class_weights[i][j] * feature[j]
    }
    class_out[i] = sigmoid(sum)
  }
  let mut domain_sum = 0.0
  for j in 0..<model.feature_dim {
    domain_sum = domain_sum + model.domain_weights[0][j] * feature[j]
  }
  (class_out, sigmoid(domain_sum))
}

/// DANN 损失 / DANN loss.
pub fn dann_loss(class_pred : Array[Double], class_target : Array[Int], domain_pred : Double, domain_target : Int, lambda : Double) -> Double {
  let n = class_pred.length()
  if n == 0 || n != class_target.length() {
    return 0.0
  }
  let mut cls_loss = 0.0
  let eps = 0.000000001
  for i in 0..<n {
    let t = class_target[i].to_double()
    cls_loss = cls_loss + -(t * log(class_pred[i] + eps) + (1.0 - t) * log(1.0 - class_pred[i] + eps))
  }
  let dt = domain_target.to_double()
  let dom_loss = -(dt * log(domain_pred + eps) + (1.0 - dt) * log(1.0 - domain_pred + eps))
  cls_loss + lambda * dom_loss
}

/// DANN 梯度反转 / DANN gradient reversal.
pub fn dann_gradient_reversal(gradients : Array[Double], lambda : Double) -> Array[Double] {
  let n = gradients.length()
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = -lambda * gradients[i]
  }
  result
}

/// 构造渐进式模型 / Build progressive model.
pub fn make_progressive(max_layers : Int, seed : Int) -> ProgressiveModel {
  let layer_weights : Array[Array[Array[Double]]] = Array::make(max_layers, [])
  for i in 0..<max_layers {
    let dim = 16 * (i + 1)
    let w : Array[Array[Double]] = Array::make(dim, Array::make(dim, 0.0))
    for a in 0..<dim {
      for b in 0..<dim {
        w[a][b] = rand_double(seed + i * 1000 + a * dim + b) * 2.0 - 1.0
      }
    }
    layer_weights[i] = w
  }
  { max_layers, current_layers: 1, layer_weights }
}

/// 渐进式增长 / Progressive grow.
pub fn progressive_grow(model : ProgressiveModel) -> ProgressiveModel {
  if model.current_layers < model.max_layers {
    { max_layers: model.max_layers, current_layers: model.current_layers + 1, layer_weights: model.layer_weights }
  } else {
    model
  }
}

/// 渐进式迁移 / Progressive transfer.
pub fn progressive_transfer(model : ProgressiveModel, _new_data : Array[Array[Double]]) -> ProgressiveModel {
  progressive_grow(model)
}

/// 构造蒸馏配置 / Build distillation configuration.
pub fn make_distillation(teacher : PretrainedModel, student : PretrainedModel, temperature : Double, alpha : Double) -> DistillationConfig {
  { teacher, student, temperature, alpha }
}

/// 蒸馏知识 / Distill knowledge.
pub fn distill_knowledge(config : DistillationConfig, input : Array[Double]) -> (Array[Double], Array[Double]) {
  let teacher_out = run_pretrained(config.teacher, input)
  let student_out = run_pretrained(config.student, input)
  let t = config.temperature
  let teacher_soft : Array[Double] = Array::make(teacher_out.length(), 0.0)
  let student_soft : Array[Double] = Array::make(student_out.length(), 0.0)
  let mut t_sum = 0.0
  let mut s_sum = 0.0
  for i in 0..<teacher_out.length() {
    teacher_soft[i] = exp(teacher_out[i] / t)
    t_sum = t_sum + teacher_soft[i]
  }
  for i in 0..<student_out.length() {
    student_soft[i] = exp(student_out[i] / t)
    s_sum = s_sum + student_soft[i]
  }
  if t_sum > 0.0 {
    for i in 0..<teacher_out.length() {
      teacher_soft[i] = teacher_soft[i] / t_sum
    }
  }
  if s_sum > 0.0 {
    for i in 0..<student_out.length() {
      student_soft[i] = student_soft[i] / s_sum
    }
  }
  (teacher_soft, student_soft)
}

fn run_pretrained(model : PretrainedModel, input : Array[Double]) -> Array[Double] {
  let mut current = input
  for i in 0..<model.layers.length() {
    let layer = model.layers[i]
    let out_size = if layer.length() == 0 { 1 } else { layer.length() / (current.length() + 1) }
    let next : Array[Double] = Array::make(if out_size > 0 { out_size } else { 1 }, 0.0)
    for j in 0..<next.length() {
      let mut sum = 0.0
      for k in 0..<current.length() {
        let idx = j * (current.length() + 1) + k
        if idx < layer.length() {
          sum = sum + layer[idx] * current[k]
        }
      }
      let bias_idx = j * (current.length() + 1) + current.length()
      if bias_idx < layer.length() {
        sum = sum + layer[bias_idx]
      }
      next[j] = tanh_d(sum)
    }
    current = next
  }
  current
}

/// Teacher-Student 损失 / Teacher-student loss.
pub fn teacher_student_loss(teacher_soft : Array[Double], student_soft : Array[Double], hard_target : Array[Double], temperature : Double, alpha : Double) -> Double {
  let n = teacher_soft.length()
  if n == 0 || n != student_soft.length() {
    return 0.0
  }
  let eps = 0.000000001
  let mut kl = 0.0
  for i in 0..<n {
    kl = kl + teacher_soft[i] * (log(teacher_soft[i] + eps) - log(student_soft[i] + eps))
  }
  let mut ce = 0.0
  for i in 0..<n {
    if i < hard_target.length() {
      ce = ce + -(hard_target[i] * log(student_soft[i] + eps) + (1.0 - hard_target[i]) * log(1.0 - student_soft[i] + eps))
    }
  }
  alpha * temperature * temperature * kl + (1.0 - alpha) * ce
}

/// 构造 Adapter / Build adapter.
pub fn make_adapter(input_dim : Int, bottleneck_dim : Int, seed : Int) -> AdapterModule {
  let down : Array[Array[Double]] = Array::make(bottleneck_dim, Array::make(input_dim, 0.0))
  let up : Array[Array[Double]] = Array::make(input_dim, Array::make(bottleneck_dim, 0.0))
  for i in 0..<bottleneck_dim {
    for j in 0..<input_dim {
      down[i][j] = rand_double(seed + i * input_dim + j) * 0.02 - 0.01
    }
  }
  for i in 0..<input_dim {
    for j in 0..<bottleneck_dim {
      up[i][j] = rand_double(seed + 1000 + i * bottleneck_dim + j) * 0.02 - 0.01
    }
  }
  { input_dim, bottleneck_dim, down_weights: down, up_weights: up }
}

/// Adapter 前向 / Adapter forward.
pub fn adapter_forward(adapter : AdapterModule, input : Array[Double]) -> Array[Double] {
  let down : Array[Double] = Array::make(adapter.bottleneck_dim, 0.0)
  for i in 0..<adapter.bottleneck_dim {
    let mut sum = 0.0
    for j in 0..<adapter.input_dim {
      if j < input.length() {
        sum = sum + adapter.down_weights[i][j] * input[j]
      }
    }
    down[i] = sum
  }
  let up : Array[Double] = Array::make(adapter.input_dim, 0.0)
  for i in 0..<adapter.input_dim {
    let mut sum = 0.0
    for j in 0..<adapter.bottleneck_dim {
      sum = sum + adapter.up_weights[i][j] * down[j]
    }
    up[i] = sum
  }
  let result : Array[Double] = Array::make(adapter.input_dim, 0.0)
  for i in 0..<adapter.input_dim {
    if i < input.length() {
      result[i] = input[i] + up[i]
    } else {
      result[i] = up[i]
    }
  }
  result
}

/// Adapter 训练 / Adapter train.
pub fn adapter_train(adapter : AdapterModule, _input : Array[Double], grad : Array[Double], lr : Double) -> AdapterModule {
  let down : Array[Array[Double]] = Array::make(adapter.bottleneck_dim, Array::make(adapter.input_dim, 0.0))
  let up : Array[Array[Double]] = Array::make(adapter.input_dim, Array::make(adapter.bottleneck_dim, 0.0))
  for i in 0..<adapter.bottleneck_dim {
    for j in 0..<adapter.input_dim {
      let g = if j < grad.length() { grad[j] } else { 0.0 }
      down[i][j] = adapter.down_weights[i][j] - lr * g * 0.01
    }
  }
  for i in 0..<adapter.input_dim {
    for j in 0..<adapter.bottleneck_dim {
      let g = if i < grad.length() { grad[i] } else { 0.0 }
      up[i][j] = adapter.up_weights[i][j] - lr * g * 0.01
    }
  }
  { input_dim: adapter.input_dim, bottleneck_dim: adapter.bottleneck_dim, down_weights: down, up_weights: up }
}

/// 构造 LoRA / Build LoRA.
pub fn make_lora(input_dim : Int, rank : Int, scaling : Double, seed : Int) -> LoRAModule {
  let a : Array[Array[Double]] = Array::make(rank, Array::make(input_dim, 0.0))
  let b : Array[Array[Double]] = Array::make(input_dim, Array::make(rank, 0.0))
  for i in 0..<rank {
    for j in 0..<input_dim {
      a[i][j] = rand_double(seed + i * input_dim + j) * 0.02 - 0.01
    }
  }
  for i in 0..<input_dim {
    for j in 0..<rank {
      b[i][j] = 0.0
    }
  }
  { input_dim, rank, a_weights: a, b_weights: b, scaling }
}

/// LoRA 前向 / LoRA forward.
pub fn lora_forward(lora : LoRAModule, input : Array[Double]) -> Array[Double] {
  let ax : Array[Double] = Array::make(lora.rank, 0.0)
  for i in 0..<lora.rank {
    let mut sum = 0.0
    for j in 0..<lora.input_dim {
      if j < input.length() {
        sum = sum + lora.a_weights[i][j] * input[j]
      }
    }
    ax[i] = sum
  }
  let bax : Array[Double] = Array::make(lora.input_dim, 0.0)
  for i in 0..<lora.input_dim {
    let mut sum = 0.0
    for j in 0..<lora.rank {
      sum = sum + lora.b_weights[i][j] * ax[j]
    }
    bax[i] = lora.scaling * sum
  }
  let result : Array[Double] = Array::make(lora.input_dim, 0.0)
  for i in 0..<lora.input_dim {
    if i < input.length() {
      result[i] = input[i] + bax[i]
    } else {
      result[i] = bax[i]
    }
  }
  result
}

/// LoRA 训练 / LoRA train.
pub fn lora_train(lora : LoRAModule, _input : Array[Double], grad : Array[Double], lr : Double) -> LoRAModule {
  let a : Array[Array[Double]] = Array::make(lora.rank, Array::make(lora.input_dim, 0.0))
  let b : Array[Array[Double]] = Array::make(lora.input_dim, Array::make(lora.rank, 0.0))
  for i in 0..<lora.rank {
    for j in 0..<lora.input_dim {
      let g = if j < grad.length() { grad[j] } else { 0.0 }
      a[i][j] = lora.a_weights[i][j] - lr * g * 0.001
    }
  }
  for i in 0..<lora.input_dim {
    for j in 0..<lora.rank {
      let g = if i < grad.length() { grad[i] } else { 0.0 }
      b[i][j] = lora.b_weights[i][j] - lr * g * 0.001
    }
  }
  { input_dim: lora.input_dim, rank: lora.rank, a_weights: a, b_weights: b, scaling: lora.scaling }
}

/// 构造 Prefix Tuning / Build prefix tuning.
pub fn make_prefix_tuning(num_layers : Int, prefix_len : Int, embed_dim : Int, seed : Int) -> PrefixTuning {
  let total = prefix_len * embed_dim
  let weights : Array[Array[Double]] = Array::make(num_layers, Array::make(total, 0.0))
  for i in 0..<num_layers {
    for j in 0..<total {
      weights[i][j] = rand_double(seed + i * total + j) * 0.02 - 0.01
    }
  }
  { num_layers, prefix_len, embed_dim, prefix_weights: weights }
}

/// Prefix 前向 / Prefix forward.
pub fn prefix_forward(prefix : PrefixTuning, input : Array[Double], layer : Int) -> Array[Double] {
  if layer < 0 || layer >= prefix.num_layers {
    return input
  }
  let total = prefix.prefix_len * prefix.embed_dim
  let result : Array[Double] = Array::make(total, 0.0)
  for i in 0..<total {
    result[i] = prefix.prefix_weights[layer][i]
  }
  let combined : Array[Double] = []
  for i in 0..<result.length() {
    combined.push(result[i])
  }
  for i in 0..<input.length() {
    combined.push(input[i])
  }
  combined
}

/// Prefix 训练 / Prefix train.
pub fn prefix_train(prefix : PrefixTuning, grad : Array[Double], lr : Double) -> PrefixTuning {
  let total = prefix.prefix_len * prefix.embed_dim
  let weights : Array[Array[Double]] = Array::make(prefix.num_layers, Array::make(total, 0.0))
  for i in 0..<prefix.num_layers {
    for j in 0..<total {
      let g = if j < grad.length() { grad[j] } else { 0.0 }
      weights[i][j] = prefix.prefix_weights[i][j] - lr * g * 0.01
    }
  }
  { num_layers: prefix.num_layers, prefix_len: prefix.prefix_len, embed_dim: prefix.embed_dim, prefix_weights: weights }
}

/// 构造 Prompt Tuning / Build prompt tuning.
pub fn make_prompt_tuning(prompt_len : Int, embed_dim : Int, seed : Int) -> PromptTuning {
  let params : Array[Array[Double]] = Array::make(prompt_len, Array::make(embed_dim, 0.0))
  for i in 0..<prompt_len {
    for j in 0..<embed_dim {
      params[i][j] = rand_double(seed + i * embed_dim + j) * 0.02 - 0.01
    }
  }
  { prompt_len, embed_dim, prompt_params: params }
}

/// Prompt 前向 / Prompt forward.
pub fn prompt_forward(prompt : PromptTuning, input : Array[Double]) -> Array[Double] {
  let combined : Array[Double] = []
  for i in 0..<prompt.prompt_len {
    for j in 0..<prompt.embed_dim {
      combined.push(prompt.prompt_params[i][j])
    }
  }
  for i in 0..<input.length() {
    combined.push(input[i])
  }
  combined
}

/// Prompt 训练 / Prompt train.
pub fn prompt_train(prompt : PromptTuning, grad : Array[Double], lr : Double) -> PromptTuning {
  let params : Array[Array[Double]] = Array::make(prompt.prompt_len, Array::make(prompt.embed_dim, 0.0))
  for i in 0..<prompt.prompt_len {
    for j in 0..<prompt.embed_dim {
      let idx = i * prompt.embed_dim + j
      let g = if idx < grad.length() { grad[idx] } else { 0.0 }
      params[i][j] = prompt.prompt_params[i][j] - lr * g
    }
  }
  { prompt_len: prompt.prompt_len, embed_dim: prompt.embed_dim, prompt_params: params }
}

/// 评估迁移 / Evaluate transfer.
pub fn evaluate_transfer(source_acc : Double, target_acc : Double) -> Double {
  target_acc - source_acc
}

/// 迁移效率 / Transfer efficiency.
pub fn transfer_efficiency(target_acc : Double, from_scratch_acc : Double) -> Double {
  if abs_d(from_scratch_acc) < 0.000000001 {
    0.0
  } else {
    target_acc / from_scratch_acc
  }
}

/// 负迁移检查 / Negative transfer check.
pub fn negative_transfer_check(source_acc : Double, target_acc : Double, threshold : Double) -> Bool {
  target_acc < source_acc - threshold
}

/// 构造源-目标对 / Build source-target pair.
pub fn make_source_target(source_data : Array[Array[Double]], target_data : Array[Array[Double]], source_labels : Array[Int], target_labels : Array[Int]) -> SourceTarget {
  { source_data, target_data, source_labels, target_labels }
}

/// 源数据 / Source data.
pub fn source_data(pair : SourceTarget) -> Array[Array[Double]] {
  pair.source_data
}

/// 目标数据 / Target data.
pub fn target_data(pair : SourceTarget) -> Array[Array[Double]] {
  pair.target_data
}

/// 层匹配 / Layer matching.
pub fn layer_matching(source_model : PretrainedModel, target_model : PretrainedModel) -> Array[(Int, Int)] {
  let result : Array[(Int, Int)] = []
  let ns = source_model.layers.length()
  let nt = target_model.layers.length()
  let min_len = if ns < nt { ns } else { nt }
  for i in 0..<min_len {
    result.push((i, i))
  }
  result
}

/// 权重迁移 / Weight transfer.
pub fn weight_transfer(source_model : PretrainedModel, target_model : PretrainedModel, matching : Array[(Int, Int)]) -> PretrainedModel {
  let new_layers : Array[Array[Double]] = []
  for i in 0..<target_model.layers.length() {
    let mut src_idx = -1
    for k in 0..<matching.length() {
      if matching[k].1 == i {
        src_idx = matching[k].0
      }
    }
    let layer : Array[Double] = []
    if src_idx >= 0 && src_idx < source_model.layers.length() {
      let src_layer = source_model.layers[src_idx]
      let tgt_layer = target_model.layers[i]
      for j in 0..<tgt_layer.length() {
        if j < src_layer.length() {
          layer.push(src_layer[j])
        } else {
          layer.push(tgt_layer[j])
        }
      }
    } else {
      for j in 0..<target_model.layers[i].length() {
        layer.push(target_model.layers[i][j])
      }
    }
    new_layers.push(layer)
  }
  { name: target_model.name, layers: new_layers, layer_names: target_model.layer_names, input_dim: target_model.input_dim, output_dim: target_model.output_dim }
}

/// 权重初始化迁移 / Weight init transfer.
pub fn weight_init_transfer(source_model : PretrainedModel, target_dim : Int) -> PretrainedModel {
  let new_layers : Array[Array[Double]] = []
  for i in 0..<source_model.layers.length() {
    let layer : Array[Double] = []
    for j in 0..<target_dim {
      if j < source_model.layers[i].length() {
        layer.push(source_model.layers[i][j])
      } else {
        layer.push(0.0)
      }
    }
    new_layers.push(layer)
  }
  { name: source_model.name, layers: new_layers, layer_names: source_model.layer_names, input_dim: source_model.input_dim, output_dim: target_dim }
}

/// 模块标识 / Module identifier.
pub fn transfer_learning_id() -> String {
  "learncore/transfer_learning"
}