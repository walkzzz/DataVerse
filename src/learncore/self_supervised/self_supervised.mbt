///|
/// # learncore/self_supervised 自监督学习 / Self-Supervised Learning
///
/// 自监督学习族：SimCLR、MoCo、BYOL、SwAV、DINO、Masked LM、MAE、对比学习、前置任务、表示学习、投影头、停止梯度。
///
/// # Self-Supervised Learning
///
/// SimCLR, MoCo, BYOL, SwAV, DINO, Masked LM, MAE, contrastive, pretext, representation, projection, stop-gradient.

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

fn vec_dot(a : Array[Double], b : Array[Double]) -> Double {
  let n = a.length()
  if n != b.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + a[i] * b[i]
    }
    sum
  }
}

fn norm(a : Array[Double]) -> Double {
  sqrt(vec_dot(a, a))
}

fn normalize(a : Array[Double]) -> Array[Double] {
  let n = norm(a)
  if n == 0.0 {
    a
  } else {
    let result : Array[Double] = Array::make(a.length(), 0.0)
    for i in 0..<a.length() {
      result[i] = a[i] / n
    }
    result
  }
}

/// SimCLR 配置 / SimCLR configuration.
pub struct SimCLRMeta {
  temperature : Double
  projection_dim : Int
  feature_dim : Int
  batch_size : Int
} derive(Debug, Eq)

pub extend SimCLRMeta with Eq::{equal, not_equal}
pub extend SimCLRMeta with Debug::{to_repr}

/// MoCo 配置 / MoCo configuration.
pub struct MoCoMeta {
  queue_size : Int
  momentum : Double
  temperature : Double
  feature_dim : Int
} derive(Debug, Eq)

pub extend MoCoMeta with Eq::{equal, not_equal}
pub extend MoCoMeta with Debug::{to_repr}

/// BYOL 配置 / BYOL configuration.
pub struct BYOLMeta {
  projection_dim : Int
  predictor_dim : Int
  momentum : Double
  feature_dim : Int
} derive(Debug, Eq)

pub extend BYOLMeta with Eq::{equal, not_equal}
pub extend BYOLMeta with Debug::{to_repr}

/// SwAV 配置 / SwAV configuration.
pub struct SwAVMeta {
  n_prototypes : Int
  n_queues : Int
  temperature : Double
  epsilon : Double
  feature_dim : Int
} derive(Debug, Eq)

pub extend SwAVMeta with Eq::{equal, not_equal}
pub extend SwAVMeta with Debug::{to_repr}

/// DINO 配置 / DINO configuration.
pub struct DINOMeta {
  student_dim : Int
  teacher_dim : Int
  n_patches : Int
  momentum : Double
  temperature : Double
} derive(Debug, Eq)

pub extend DINOMeta with Eq::{equal, not_equal}
pub extend DINOMeta with Debug::{to_repr}

/// Masked LM 配置 / Masked LM configuration.
pub struct MaskedLMMeta {
  vocab_size : Int
  mask_prob : Double
  n_masked : Int
  hidden_dim : Int
} derive(Debug, Eq)

pub extend MaskedLMMeta with Eq::{equal, not_equal}
pub extend MaskedLMMeta with Debug::{to_repr}

/// MAE 配置 / MAE configuration.
pub struct MAEMeta {
  patch_size : Int
  mask_ratio : Double
  encoder_dim : Int
  decoder_dim : Int
  img_size : Int
} derive(Debug, Eq)

pub extend MAEMeta with Eq::{equal, not_equal}
pub extend MAEMeta with Debug::{to_repr}

/// 对比学习配置 / Contrastive learning configuration.
pub struct ContrastiveMeta {
  temperature : Double
  n_positives : Int
  n_negatives : Int
  feature_dim : Int
} derive(Debug, Eq)

pub extend ContrastiveMeta with Eq::{equal, not_equal}
pub extend ContrastiveMeta with Debug::{to_repr}

/// 前置任务配置 / Pretext task configuration.
pub struct PretextMeta {
  task_type : Int
  n_classes : Int
  feature_dim : Int
} derive(Debug, Eq)

pub extend PretextMeta with Eq::{equal, not_equal}
pub extend PretextMeta with Debug::{to_repr}

/// 表示学习配置 / Representation learning configuration.
pub struct RepresentationMeta {
  input_dim : Int
  hidden_dim : Int
  output_dim : Int
  n_layers : Int
} derive(Debug, Eq)

pub extend RepresentationMeta with Eq::{equal, not_equal}
pub extend RepresentationMeta with Debug::{to_repr}

/// 投影头配置 / Projection head configuration.
pub struct ProjectionHeadMeta {
  input_dim : Int
  hidden_dim : Int
  output_dim : Int
  use_bn : Bool
} derive(Debug, Eq)

pub extend ProjectionHeadMeta with Eq::{equal, not_equal}
pub extend ProjectionHeadMeta with Debug::{to_repr}

/// 停止梯度配置 / Stop gradient configuration.
pub struct StopGradientMeta {
  enabled : Bool
  scale : Double
} derive(Debug, Eq)

pub extend StopGradientMeta with Eq::{equal, not_equal}
pub extend StopGradientMeta with Debug::{to_repr}

/// 构造 SimCLR / Build SimCLR meta.
pub fn make_simclr(temperature : Double, projection_dim : Int, feature_dim : Int, batch_size : Int) -> SimCLRMeta {
  { temperature, projection_dim, feature_dim, batch_size }
}

/// SimCLR 数据增强 / SimCLR augmentation.
pub fn simclr_augment(input : Array[Double], seed : Int) -> Array[Double] {
  let n = input.length()
  let result : Array[Double] = Array::make(n, 0.0)
  let mut s = seed
  for i in 0..<n {
    s = lcg_next(s)
    let r = rand_double(s)
    let jitter = (r - 0.5) * 0.2
    result[i] = input[i] + jitter
  }
  result
}

/// SimCLR 对比损失 / SimCLR contrastive loss.
pub fn simclr_contrastive_loss(z_i : Array[Double], z_j : Array[Double], meta : SimCLRMeta) -> Double {
  let zi = normalize(z_i)
  let zj = normalize(z_j)
  let sim = vec_dot(zi, zj)
  -log(exp(sim / meta.temperature) + exp(0.0))
}

/// SimCLR NT-Xent 损失 / SimCLR NT-Xent loss.
pub fn simclr_nt_xent(z_i : Array[Double], z_j : Array[Double], negatives : Array[Array[Double]], meta : SimCLRMeta) -> Double {
  let zi = normalize(z_i)
  let zj = normalize(z_j)
  let pos = vec_dot(zi, zj) / meta.temperature
  let mut denom = exp(pos)
  for k in 0..<negatives.length() {
    let nk = normalize(negatives[k])
    denom = denom + exp(vec_dot(zi, nk) / meta.temperature)
  }
  -log(exp(pos) / denom)
}

/// 构造 MoCo / Build MoCo meta.
pub fn make_moco(queue_size : Int, momentum : Double, temperature : Double, feature_dim : Int) -> MoCoMeta {
  { queue_size, momentum, temperature, feature_dim }
}

/// MoCo 编码器前向 / MoCo encoder forward.
pub fn moco_encoder(input : Array[Double], weights : Array[Double]) -> Array[Double] {
  let n = input.length()
  if n != weights.length() {
    Array::make(n, 0.0)
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = tanh_d(input[i] * weights[i])
    }
    result
  }
}

/// MoCo 动量编码器更新 / MoCo momentum encoder update.
pub fn moco_momentum_encoder(encoder_params : Array[Double], momentum_params : Array[Double], momentum : Double) -> Array[Double] {
  let n = encoder_params.length()
  if n != momentum_params.length() {
    momentum_params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = momentum * momentum_params[i] + (1.0 - momentum) * encoder_params[i]
    }
    result
  }
}

/// MoCo 队列操作 / MoCo queue operation.
pub fn moco_queue(queue : Array[Array[Double]], new_keys : Array[Array[Double]], max_size : Int) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<queue.length() {
    result.push(queue[i])
  }
  for i in 0..<new_keys.length() {
    result.push(new_keys[i])
  }
  while result.length() > max_size {
    let _ = result.remove(0)
  }
  result
}

/// 构造 BYOL / Build BYOL meta.
pub fn make_byol(projection_dim : Int, predictor_dim : Int, momentum : Double, feature_dim : Int) -> BYOLMeta {
  { projection_dim, predictor_dim, momentum, feature_dim }
}

/// BYOL 预测器 / BYOL predictor.
pub fn byol_predictor(input : Array[Double], meta : BYOLMeta) -> Array[Double] {
  let n = input.length()
  let result : Array[Double] = Array::make(meta.predictor_dim, 0.0)
  for i in 0..<meta.predictor_dim {
    if i < n {
      result[i] = tanh_d(input[i])
    }
  }
  result
}

/// BYOL 损失 / BYOL loss.
pub fn byol_loss(p : Array[Double], z : Array[Double]) -> Double {
  let pn = normalize(p)
  let zn = normalize(z)
  let d = vec_dot(pn, zn)
  2.0 - 2.0 * d
}

/// BYOL 动量更新 / BYOL momentum update.
pub fn byol_momentum(online_params : Array[Double], target_params : Array[Double], momentum : Double) -> Array[Double] {
  let n = online_params.length()
  if n != target_params.length() {
    target_params
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = momentum * target_params[i] + (1.0 - momentum) * online_params[i]
    }
    result
  }
}

/// 构造 SwAV / Build SwAV meta.
pub fn make_swav(n_prototypes : Int, n_queues : Int, temperature : Double, epsilon : Double, feature_dim : Int) -> SwAVMeta {
  { n_prototypes, n_queues, temperature, epsilon, feature_dim }
}

/// SwAV 软分配 / SwAV assignments.
pub fn swav_assignments(features : Array[Double], prototypes : Array[Array[Double]], meta : SwAVMeta) -> Array[Double] {
  let n = prototypes.length()
  let scores : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    scores[i] = vec_dot(features, prototypes[i]) / meta.temperature
  }
  let mut max_score = scores[0]
  for i in 1..<n {
    if scores[i] > max_score {
      max_score = scores[i]
    }
  }
  let mut sum_exp = 0.0
  for i in 0..<n {
    scores[i] = exp(scores[i] - max_score)
    sum_exp = sum_exp + scores[i]
  }
  let result : Array[Double] = Array::make(n, 0.0)
  if sum_exp > 0.0 {
    for i in 0..<n {
      result[i] = scores[i] / sum_exp
    }
  }
  result
}

/// SwAV 损失 / SwAV loss.
pub fn swav_loss(z : Array[Double], q : Array[Double], prototypes : Array[Array[Double]]) -> Double {
  let n = q.length()
  let mut loss = 0.0
  for i in 0..<n {
    let p = vec_dot(z, prototypes[i])
    if q[i] > 0.0 {
      loss = loss - q[i] * log(q[i]) + q[i] * log(exp(p) + 0.000001)
    }
  }
  loss
}

/// SwAV 多裁剪 / SwAV multi-crop.
pub fn swav_multi_crop(input : Array[Double], n8 : Int, seed : Int) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let mut s = seed
  for _ in 0..<n8 {
    s = lcg_next(s)
    let scale = 0.5 + rand_double(s) * 0.5
    let crop : Array[Double] = Array::make(input.length(), 0.0)
    for i in 0..<input.length() {
      crop[i] = input[i] * scale
    }
    result.push(crop)
  }
  result
}

/// 构造 DINO / Build DINO meta.
pub fn make_dino(student_dim : Int, teacher_dim : Int, n_patches : Int, momentum : Double, temperature : Double) -> DINOMeta {
  { student_dim, teacher_dim, n_patches, momentum, temperature }
}

/// DINO 学生网络 / DINO student network.
pub fn dino_student(input : Array[Double], meta : DINOMeta) -> Array[Double] {
  let result : Array[Double] = Array::make(meta.n_patches, 0.0)
  for i in 0..<meta.n_patches {
    if i < input.length() {
      result[i] = tanh_d(input[i])
    }
  }
  result
}

/// DINO 教师网络 / DINO teacher network.
pub fn dino_teacher(input : Array[Double], meta : DINOMeta) -> Array[Double] {
  let result : Array[Double] = Array::make(meta.n_patches, 0.0)
  for i in 0..<meta.n_patches {
    if i < input.length() {
      result[i] = sigmoid(input[i] / meta.temperature)
    }
  }
  result
}

/// DINO 损失 / DINO loss.
pub fn dino_loss(student_logits : Array[Double], teacher_probs : Array[Double]) -> Double {
  let n = student_logits.length()
  if n != teacher_probs.length() {
    0.0
  } else {
    let mut loss = 0.0
    for i in 0..<n {
      let s = sigmoid(student_logits[i])
      if teacher_probs[i] > 0.0 && s > 0.0 {
        loss = loss - teacher_probs[i] * log(s)
      }
    }
    loss
  }
}

/// 构造 Masked LM / Build Masked LM meta.
pub fn make_masked_lm(vocab_size : Int, mask_prob : Double, n_masked : Int, hidden_dim : Int) -> MaskedLMMeta {
  { vocab_size, mask_prob, n_masked, hidden_dim }
}

/// 掩码 token / Mask tokens.
pub fn mask_tokens(tokens : Array[Int], meta : MaskedLMMeta, seed : Int) -> Array[Int] {
  let n = tokens.length()
  let result : Array[Int] = Array::make(n, 0)
  let mut s = seed
  for i in 0..<n {
    s = lcg_next(s)
    let r = rand_double(s)
    if r < meta.mask_prob {
      result[i] = meta.vocab_size
    } else {
      result[i] = tokens[i]
    }
  }
  result
}

/// Masked LM 损失 / Masked LM loss.
pub fn masked_lm_loss(predictions : Array[Array[Double]], targets : Array[Int], meta : MaskedLMMeta) -> Double {
  let n = targets.length()
  if n != predictions.length() {
    0.0
  } else {
    let vocab_scale = 1.0 / meta.vocab_size.to_double()
    let mut loss = 0.0
    for i in 0..<n {
      let logits = predictions[i]
      let mut max_l = logits[0]
      for j in 1..<logits.length() {
        if logits[j] > max_l {
          max_l = logits[j]
        }
      }
      let mut sum_exp = 0.0
      for j in 0..<logits.length() {
        sum_exp = sum_exp + exp(logits[j] - max_l)
      }
      let target = targets[i]
      if target < logits.length() {
        loss = loss - (logits[target] - max_l) + log(sum_exp)
      }
    }
    loss / n.to_double() * (1.0 + vocab_scale * 0.0)
  }
}

/// 构造 MAE / Build MAE meta.
pub fn make_mae(patch_size : Int, mask_ratio : Double, encoder_dim : Int, decoder_dim : Int, img_size : Int) -> MAEMeta {
  { patch_size, mask_ratio, encoder_dim, decoder_dim, img_size }
}

/// MAE 掩码 / MAE mask.
pub fn mae_mask(n_patches : Int, mask_ratio : Double, seed : Int) -> Array[Bool] {
  let result : Array[Bool] = Array::make(n_patches, false)
  let mut s = seed
  let n_mask = (n_patches.to_double() * mask_ratio).to_int()
  let mut count = 0
  while count < n_mask {
    s = lcg_next(s)
    let idx = (rand_double(s) * n_patches.to_double()).to_int()
    if idx >= 0 && idx < n_patches && !result[idx] {
      result[idx] = true
      count = count + 1
    }
  }
  result
}

/// MAE 编码器 / MAE encoder.
pub fn mae_encoder(patches : Array[Array[Double]], mask : Array[Bool], meta : MAEMeta) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for i in 0..<patches.length() {
    if i < mask.length() {
      if !mask[i] {
        let encoded : Array[Double] = Array::make(meta.encoder_dim, 0.0)
        for j in 0..<meta.encoder_dim {
          if j < patches[i].length() {
            encoded[j] = tanh_d(patches[i][j])
          }
        }
        result.push(encoded)
      }
    }
  }
  result
}

/// MAE 解码器 / MAE decoder.
pub fn mae_decoder(encoded : Array[Array[Double]], mask : Array[Bool], meta : MAEMeta) -> Array[Array[Double]] {
  let mask_count = mask.length()
  let result : Array[Array[Double]] = []
  for i in 0..<encoded.length() {
    let decoded : Array[Double] = Array::make(meta.decoder_dim, 0.0)
    for j in 0..<meta.decoder_dim {
      if j < encoded[i].length() {
        decoded[j] = tanh_d(encoded[i][j])
      }
    }
    result.push(decoded)
  }
  if mask_count >= 0 {
    result
  } else {
    result
  }
}

/// MAE 损失 / MAE loss.
pub fn mae_loss(reconstructions : Array[Array[Double]], targets : Array[Array[Double]], mask : Array[Bool]) -> Double {
  let mut loss = 0.0
  let mut count = 0
  for i in 0..<targets.length() {
    if i < mask.length() && mask[i] {
      let t = targets[i]
      let r_idx = count
      if r_idx < reconstructions.length() {
        let r = reconstructions[r_idx]
        for j in 0..<t.length() {
          if j < r.length() {
            let diff = t[j] - r[j]
            loss = loss + diff * diff
          }
        }
        count = count + 1
      }
    }
  }
  if count == 0 { 0.0 } else { loss / count.to_double() }
}

/// 构造对比学习 / Build contrastive meta.
pub fn make_contrastive(temperature : Double, n_positives : Int, n_negatives : Int, feature_dim : Int) -> ContrastiveMeta {
  { temperature, n_positives, n_negatives, feature_dim }
}

/// 对比学习正样本 / Contrastive positive.
pub fn contrastive_positive(anchor : Array[Double], positive : Array[Double], meta : ContrastiveMeta) -> Double {
  let a = normalize(anchor)
  let p = normalize(positive)
  vec_dot(a, p) / meta.temperature
}

/// 对比学习负样本 / Contrastive negative.
pub fn contrastive_negative(anchor : Array[Double], negatives : Array[Array[Double]], meta : ContrastiveMeta) -> Double {
  let a = normalize(anchor)
  let mut sum = 0.0
  for i in 0..<negatives.length() {
    let n = normalize(negatives[i])
    sum = sum + exp(vec_dot(a, n) / meta.temperature)
  }
  log(sum)
}

/// 构造前置任务 / Build pretext meta.
pub fn make_pretext(task_type : Int, n_classes : Int, feature_dim : Int) -> PretextMeta {
  { task_type, n_classes, feature_dim }
}

/// 前置任务旋转 / Pretext rotation.
pub fn pretext_rotate(input : Array[Double], k : Int) -> Array[Double] {
  let n = input.length()
  if n == 0 {
    input
  } else {
    let shift = ((k % 4) + 4) % 4
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = input[(i + shift * (n / 4)) % n]
    }
    result
  }
}

/// 前置任务拼图 / Pretext jigsaw.
pub fn pretext_jigsaw(patches : Array[Array[Double]], permutation : Array[Int]) -> Array[Array[Double]] {
  let n = patches.length()
  let result : Array[Array[Double]] = []
  for i in 0..<permutation.length() {
    let idx = permutation[i]
    if idx >= 0 && idx < n {
      result.push(patches[idx])
    }
  }
  result
}

/// 前置任务着色 / Pretext colorize.
pub fn pretext_colorize(input : Array[Double], n_bins : Int) -> Array[Int] {
  let n = input.length()
  let result : Array[Int] = Array::make(n, 0)
  for i in 0..<n {
    let v = input[i]
    let bin = ((v + 1.0) * n_bins.to_double() / 2.0).to_int()
    if bin < 0 {
      result[i] = 0
    } else if bin >= n_bins {
      result[i] = n_bins - 1
    } else {
      result[i] = bin
    }
  }
  result
}

/// 构造表示学习 / Build representation meta.
pub fn make_representation(input_dim : Int, hidden_dim : Int, output_dim : Int, n_layers : Int) -> RepresentationMeta {
  { input_dim, hidden_dim, output_dim, n_layers }
}

/// 表示学习 / Representation learn.
pub fn representation_learn(input : Array[Double], weights : Array[Array[Double]], meta : RepresentationMeta) -> Array[Double] {
  let mut current = input
  for l in 0..<meta.n_layers {
    if l < weights.length() {
      let w = weights[l]
      let n_out = w.length() / current.length()
      let out : Array[Double] = Array::make(n_out, 0.0)
      for j in 0..<n_out {
        let mut sum = 0.0
        for i in 0..<current.length() {
          let idx = j * current.length() + i
          if idx < w.length() {
            sum = sum + current[i] * w[idx]
          }
        }
        out[j] = tanh_d(sum)
      }
      current = out
    }
  }
  current
}

/// 表示学习评估 / Representation eval.
pub fn representation_eval(features : Array[Double], labels : Array[Int]) -> Double {
  let n = features.length()
  if n == 0 || labels.length() == 0 {
    0.0
  } else {
    let mean = vec_dot(features, Array::make(n, 1.0)) / n.to_double()
    let mut var_sum = 0.0
    for i in 0..<n {
      let d = features[i] - mean
      var_sum = var_sum + d * d
    }
    let variance = var_sum / n.to_double()
    variance
  }
}

/// 构造投影头 / Build projection head meta.
pub fn make_projection_head(input_dim : Int, hidden_dim : Int, output_dim : Int, use_bn : Bool) -> ProjectionHeadMeta {
  { input_dim, hidden_dim, output_dim, use_bn }
}

/// 投影头前向 / Projection head forward.
pub fn projection_forward(input : Array[Double], weights : Array[Double], meta : ProjectionHeadMeta) -> Array[Double] {
  let result : Array[Double] = Array::make(meta.output_dim, 0.0)
  for j in 0..<meta.output_dim {
    let mut sum = 0.0
    for i in 0..<meta.input_dim {
      let idx = j * meta.input_dim + i
      if idx < weights.length() && i < input.length() {
        sum = sum + input[i] * weights[idx]
      }
    }
    result[j] = tanh_d(sum)
  }
  if meta.use_bn {
    let mut mean = 0.0
    for i in 0..<meta.output_dim {
      mean = mean + result[i]
    }
    mean = mean / meta.output_dim.to_double()
    let mut var_sum = 0.0
    for i in 0..<meta.output_dim {
      let d = result[i] - mean
      var_sum = var_sum + d * d
    }
    let variance = var_sum / meta.output_dim.to_double()
    let std = sqrt(variance + 0.000001)
    for i in 0..<meta.output_dim {
      result[i] = (result[i] - mean) / std
    }
  }
  result
}

/// 投影头损失 / Projection head loss.
pub fn projection_loss(z1 : Array[Double], z2 : Array[Double]) -> Double {
  let n = z1.length()
  if n != z2.length() {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let d = z1[i] - z2[i]
      sum = sum + d * d
    }
    sum / n.to_double()
  }
}

/// 构造停止梯度 / Build stop gradient meta.
pub fn make_stop_gradient(enabled : Bool, scale : Double) -> StopGradientMeta {
  { enabled, scale }
}

/// 停止梯度 / Stop gradient.
pub fn stop_grad(values : Array[Double], meta : StopGradientMeta) -> Array[Double] {
  if meta.enabled {
    let result : Array[Double] = Array::make(values.length(), 0.0)
    for i in 0..<values.length() {
      result[i] = values[i] * meta.scale
    }
    result
  } else {
    values
  }
}

/// BYOL 停止梯度 / BYOL stop gradient.
pub fn byol_stop_grad(values : Array[Double]) -> Array[Double] {
  let result : Array[Double] = Array::make(values.length(), 0.0)
  for i in 0..<values.length() {
    result[i] = values[i]
  }
  result
}

/// 自监督学习 ID / Self-supervised learning id.
pub fn self_supervised_id() -> String {
  "self_supervised_v1"
}