///|
/// # learncore/distill_adv 高级知识蒸馏 / Advanced Knowledge Distillation
///
/// 知识蒸馏策略：KL 散度、软目标、特征蒸馏、Logit 蒸馏、关系蒸馏、注意力蒸馏、渐进蒸馏、在线蒸馏、自蒸馏、Mean Teacher、去偏蒸馏、评估与调度。
///
/// # Advanced Knowledge Distillation
///
/// KL divergence, soft targets, feature/logit/relation/attention distillation, progressive/online/self distillation, mean teacher, debiased, evaluation, schedule.

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

fn clamp(x : Double, lo : Double, hi : Double) -> Double {
  if x < lo { lo } else if x > hi { hi } else { x }
}

fn dot(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let mut s = 0.0
  for i in 0..<n {
    s = s + a[i] * b[i]
  }
  s
}

fn sub_arr(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(a[i] - b[i])
  }
  result
}

fn softmax_arr(logits : Array[Double]) -> Array[Double] {
  let n = logits.length()
  if n == 0 {
    []
  } else {
    let mut max_val = logits[0]
    for i in 1..<n {
      if logits[i] > max_val {
        max_val = logits[i]
      }
    }
    let exps = logits.map(fn(x) { exp(x - max_val) })
    let mut total = 0.0
    for i in 0..<n {
      total = total + exps[i]
    }
    if total == 0.0 {
      exps
    } else {
      exps.map(fn(x) { x / total })
    }
  }
}

pub(all) struct DistillConfig {
  alpha : Double
  temperature : Double
  beta : Double
} derive(Debug, Eq)

pub extend DistillConfig with Eq::{equal, not_equal}
pub extend DistillConfig with Debug::{to_repr}

pub(all) struct TeacherStudentConfig {
  teacher_dim : Int
  student_dim : Int
  temperature : Double
  alpha : Double
} derive(Debug, Eq)

pub extend TeacherStudentConfig with Eq::{equal, not_equal}
pub extend TeacherStudentConfig with Debug::{to_repr}

pub(all) struct SoftTargetConfig {
  temperature : Double
  hard_weight : Double
} derive(Debug, Eq)

pub extend SoftTargetConfig with Eq::{equal, not_equal}
pub extend SoftTargetConfig with Debug::{to_repr}

pub(all) struct FeatureDistillConfig {
  teacher_layers : Array[Int]
  student_layers : Array[Int]
  weight : Double
} derive(Debug, Eq)

pub extend FeatureDistillConfig with Eq::{equal, not_equal}
pub extend FeatureDistillConfig with Debug::{to_repr}

pub(all) struct LogitDistillConfig {
  temperature : Double
  weight : Double
} derive(Debug, Eq)

pub extend LogitDistillConfig with Eq::{equal, not_equal}
pub extend LogitDistillConfig with Debug::{to_repr}

pub(all) struct RelationDistillConfig {
  temperature : Double
  weight : Double
} derive(Debug, Eq)

pub extend RelationDistillConfig with Eq::{equal, not_equal}
pub extend RelationDistillConfig with Debug::{to_repr}

pub(all) struct AttentionDistillConfig {
  num_heads : Int
  weight : Double
} derive(Debug, Eq)

pub extend AttentionDistillConfig with Eq::{equal, not_equal}
pub extend AttentionDistillConfig with Debug::{to_repr}

pub(all) struct ProgressiveDistillConfig {
  num_stages : Int
  stage_length : Int
  init_temperature : Double
} derive(Debug, Eq)

pub extend ProgressiveDistillConfig with Eq::{equal, not_equal}
pub extend ProgressiveDistillConfig with Debug::{to_repr}

pub(all) struct OnlineDistillConfig {
  num_peers : Int
  mutual_weight : Double
  temperature : Double
} derive(Debug, Eq)

pub extend OnlineDistillConfig with Eq::{equal, not_equal}
pub extend OnlineDistillConfig with Debug::{to_repr}

pub(all) struct SelfDistillConfig {
  num_generations : Int
  ema_decay : Double
} derive(Debug, Eq)

pub extend SelfDistillConfig with Eq::{equal, not_equal}
pub extend SelfDistillConfig with Debug::{to_repr}

pub(all) struct MeanTeacherConfig {
  ema_decay : Double
  consistency_weight : Double
} derive(Debug, Eq)

pub extend MeanTeacherConfig with Eq::{equal, not_equal}
pub extend MeanTeacherConfig with Debug::{to_repr}

pub(all) struct DebiasedDistillConfig {
  bias_estimate : Double
  num_samples : Int
  weight : Double
} derive(Debug, Eq)

pub extend DebiasedDistillConfig with Eq::{equal, not_equal}
pub extend DebiasedDistillConfig with Debug::{to_repr}

pub(all) struct DistillScheduleConfig {
  init_temperature : Double
  final_temperature : Double
  num_steps : Int
  schedule_type : String
} derive(Debug, Eq)

pub extend DistillScheduleConfig with Eq::{equal, not_equal}
pub extend DistillScheduleConfig with Debug::{to_repr}

/// 构造蒸馏配置 / Build distill config.
pub fn make_distill_config(
  alpha : Double,
  temperature : Double,
  beta : Double
) -> DistillConfig {
  { alpha, temperature, beta }
}

/// 蒸馏损失 / Distillation loss.
/// L = alpha * task_loss + (1 - alpha) * T^2 * kl_loss
pub fn distill_loss(
  task_loss : Double,
  kl_loss : Double,
  config : DistillConfig
) -> Double {
  config.alpha * task_loss + (1.0 - config.alpha) * config.temperature * config.temperature * kl_loss + config.beta * 0.0
}

/// KL 散度 / KL divergence.
/// KL(p || q) = sum(p * log(p / q))
pub fn distill_kl_divergence(p : Array[Double], q : Array[Double]) -> Double {
  let n = if p.length() < q.length() { p.length() } else { q.length() }
  let mut total = 0.0
  for i in 0..<n {
    if p[i] > 0.0 && q[i] > 0.0 {
      total = total + p[i] * (log(p[i]) - log(q[i]))
    }
  }
  total
}

/// 构造师生配置 / Build teacher-student config.
pub fn make_teacher_student(
  teacher_dim : Int,
  student_dim : Int,
  temperature : Double,
  alpha : Double
) -> TeacherStudentConfig {
  { teacher_dim, student_dim, temperature, alpha }
}

/// 教师前向 / Teacher forward pass.
pub fn teacher_forward_d(
  input : Array[Double],
  weight : Array[Array[Double]],
  bias : Array[Double]
) -> Array[Double] {
  let out_dim = weight.length()
  let result : Array[Double] = []
  for i in 0..<out_dim {
    let mut s = if i < bias.length() { bias[i] } else { 0.0 }
    for j in 0..<input.length() {
      if j < weight[i].length() {
        s = s + weight[i][j] * input[j]
      }
    }
    result.push(s)
  }
  result
}

/// 学生前向 / Student forward pass.
pub fn student_forward_d(
  input : Array[Double],
  weight : Array[Array[Double]],
  bias : Array[Double]
) -> Array[Double] {
  let out_dim = weight.length()
  let result : Array[Double] = []
  for i in 0..<out_dim {
    let mut s = if i < bias.length() { bias[i] } else { 0.0 }
    for j in 0..<input.length() {
      if j < weight[i].length() {
        s = s + weight[i][j] * input[j]
      }
    }
    result.push(s)
  }
  result
}

/// 构造软目标配置 / Build soft target config.
pub fn make_soft_target(temperature : Double, hard_weight : Double) -> SoftTargetConfig {
  { temperature, hard_weight }
}

/// 软目标计算 / Compute soft target from logits.
pub fn soft_target_compute(logits : Array[Double], temperature : Double) -> Array[Double] {
  if temperature == 0.0 {
    []
  } else {
    let scaled = logits.map(fn(x) { x / temperature })
    softmax_arr(scaled)
  }
}

/// 软目标温度 / Soft target temperature scaling.
pub fn soft_target_temperature(
  logits : Array[Double],
  temperature : Double
) -> Array[Double] {
  soft_target_compute(logits, temperature)
}

/// 构造特征蒸馏配置 / Build feature distill config.
pub fn make_feature_distill(
  teacher_layers : Array[Int],
  student_layers : Array[Int],
  weight : Double
) -> FeatureDistillConfig {
  { teacher_layers, student_layers, weight }
}

/// 特征蒸馏损失 / Feature distillation loss.
/// L = weight * sum ||f_t - f_s||^2
pub fn feature_distill_loss(
  teacher_features : Array[Array[Double]],
  student_features : Array[Array[Double]],
  config : FeatureDistillConfig
) -> Double {
  let n = if teacher_features.length() < student_features.length() {
    teacher_features.length()
  } else {
    student_features.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let diff = sub_arr(teacher_features[i], student_features[i])
      total = total + dot(diff, diff)
    }
    config.weight * total / n.to_double()
  }
}

/// 特征对齐 / Feature alignment via projection.
pub fn feature_align(
  student_features : Array[Double],
  projection : Array[Array[Double]]
) -> Array[Double] {
  let out_dim = projection.length()
  let result : Array[Double] = []
  for i in 0..<out_dim {
    let mut s = 0.0
    for j in 0..<student_features.length() {
      if j < projection[i].length() {
        s = s + projection[i][j] * student_features[j]
      }
    }
    result.push(s)
  }
  result
}

/// 构造 Logit 蒸馏配置 / Build logit distill config.
pub fn make_logit_distill(temperature : Double, weight : Double) -> LogitDistillConfig {
  { temperature, weight }
}

/// Logit 蒸馏损失 / Logit distillation loss.
/// L = T^2 * KL(soft_t || soft_s)
pub fn logit_distill_loss(
  teacher_logits : Array[Double],
  student_logits : Array[Double],
  config : LogitDistillConfig
) -> Double {
  if config.temperature == 0.0 {
    0.0
  } else {
    let soft_t = soft_target_compute(teacher_logits, config.temperature)
    let soft_s = soft_target_compute(student_logits, config.temperature)
    config.weight * config.temperature * config.temperature * distill_kl_divergence(soft_t, soft_s)
  }
}

/// Logit 匹配 / Logit matching loss (MSE).
pub fn logit_match(
  teacher_logits : Array[Double],
  student_logits : Array[Double]
) -> Double {
  let n = if teacher_logits.length() < student_logits.length() {
    teacher_logits.length()
  } else {
    student_logits.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let diff = teacher_logits[i] - student_logits[i]
      total = total + diff * diff
    }
    total / n.to_double()
  }
}

/// 构造关系蒸馏配置 / Build relation distill config.
pub fn make_relation_distill(temperature : Double, weight : Double) -> RelationDistillConfig {
  { temperature, weight }
}

/// 关系蒸馏损失 / Relation distillation loss.
/// L = weight * ||R_t - R_s||^2
pub fn relation_distill_loss(
  teacher_relations : Array[Array[Double]],
  student_relations : Array[Array[Double]],
  config : RelationDistillConfig
) -> Double {
  let n = if teacher_relations.length() < student_relations.length() {
    teacher_relations.length()
  } else {
    student_relations.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let m = if teacher_relations[i].length() < student_relations[i].length() {
        teacher_relations[i].length()
      } else {
        student_relations[i].length()
      }
      for j in 0..<m {
        let diff = teacher_relations[i][j] - student_relations[i][j]
        total = total + diff * diff
      }
    }
    config.weight * total / n.to_double()
  }
}

/// 关系提取 / Extract relation matrix from features.
pub fn relation_extract(features : Array[Array[Double]]) -> Array[Array[Double]] {
  let n = features.length()
  let result : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      row.push(dot(features[i], features[j]))
    }
    result.push(row)
  }
  result
}

/// 构造注意力蒸馏配置 / Build attention distill config.
pub fn make_attention_distill(num_heads : Int, weight : Double) -> AttentionDistillConfig {
  { num_heads, weight }
}

/// 注意力蒸馏损失 / Attention distillation loss.
/// L = weight * sum ||A_t - A_s||^2
pub fn attention_distill_loss(
  teacher_attention : Array[Array[Double]],
  student_attention : Array[Array[Double]],
  config : AttentionDistillConfig
) -> Double {
  let n = if teacher_attention.length() < student_attention.length() {
    teacher_attention.length()
  } else {
    student_attention.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let m = if teacher_attention[i].length() < student_attention[i].length() {
        teacher_attention[i].length()
      } else {
        student_attention[i].length()
      }
      for j in 0..<m {
        let diff = teacher_attention[i][j] - student_attention[i][j]
        total = total + diff * diff
      }
    }
    config.weight * total / n.to_double()
  }
}

/// 注意力迁移 / Attention transfer.
pub fn attention_transfer(
  student_features : Array[Array[Double]]
) -> Array[Array[Double]] {
  let n = student_features.length()
  let result : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      let f_i = student_features[i]
      let f_j = student_features[j]
      row.push(dot(f_i, f_j))
    }
    result.push(row)
  }
  result
}

/// 构造渐进蒸馏配置 / Build progressive distill config.
pub fn make_progressive_distill(
  num_stages : Int,
  stage_length : Int,
  init_temperature : Double
) -> ProgressiveDistillConfig {
  { num_stages, stage_length, init_temperature }
}

/// 渐进调度 / Progressive schedule.
pub fn progressive_schedule(config : ProgressiveDistillConfig, step : Int) -> Int {
  if config.stage_length <= 0 {
    0
  } else {
    let stage = step / config.stage_length
    if stage >= config.num_stages { config.num_stages - 1 } else { stage }
  }
}

/// 渐进步骤 / Progressive step temperature.
pub fn progressive_step(config : ProgressiveDistillConfig, step : Int) -> Double {
  let stage = progressive_schedule(config, step)
  config.init_temperature + stage.to_double()
}

/// 构造在线蒸馏配置 / Build online distill config.
pub fn make_online_distill(
  num_peers : Int,
  mutual_weight : Double,
  temperature : Double
) -> OnlineDistillConfig {
  { num_peers, mutual_weight, temperature }
}

/// 在线同伴 / Online peer distillation loss.
pub fn online_peer(
  peer_logits : Array[Array[Double]],
  my_logits : Array[Double],
  config : OnlineDistillConfig
) -> Double {
  let n = peer_logits.length()
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let soft_p = soft_target_compute(peer_logits[i], config.temperature)
      let soft_m = soft_target_compute(my_logits, config.temperature)
      total = total + distill_kl_divergence(soft_p, soft_m)
    }
    config.mutual_weight * total / n.to_double()
  }
}

/// 在线互学习 / Online mutual learning loss.
pub fn online_mutual(
  peer_a_logits : Array[Double],
  peer_b_logits : Array[Double],
  config : OnlineDistillConfig
) -> Double {
  if config.temperature == 0.0 {
    0.0
  } else {
    let soft_a = soft_target_compute(peer_a_logits, config.temperature)
    let soft_b = soft_target_compute(peer_b_logits, config.temperature)
    config.mutual_weight * (distill_kl_divergence(soft_a, soft_b) + distill_kl_divergence(soft_b, soft_a)) * 0.5
  }
}

/// 构造自蒸馏配置 / Build self distill config.
pub fn make_self_distill(num_generations : Int, ema_decay : Double) -> SelfDistillConfig {
  { num_generations, ema_decay }
}

/// 自蒸馏损失 / Self distillation loss.
pub fn self_distill_loss(
  current_logits : Array[Double],
  ema_logits : Array[Double],
  temperature : Double
) -> Double {
  if temperature == 0.0 {
    0.0
  } else {
    let soft_c = soft_target_compute(current_logits, temperature)
    let soft_e = soft_target_compute(ema_logits, temperature)
    distill_kl_divergence(soft_e, soft_c)
  }
}

/// 自集成 / Self ensemble (EMA update).
pub fn self_ensemble(
  current_params : Array[Double],
  ema_params : Array[Double],
  decay : Double
) -> Array[Double] {
  let n = if current_params.length() < ema_params.length() {
    current_params.length()
  } else {
    ema_params.length()
  }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(decay * ema_params[i] + (1.0 - decay) * current_params[i])
  }
  result
}

/// 构造 Mean Teacher 配置 / Build mean teacher config.
pub fn make_mean_teacher(ema_decay : Double, consistency_weight : Double) -> MeanTeacherConfig {
  { ema_decay, consistency_weight }
}

/// Mean Teacher EMA / Mean teacher EMA update.
pub fn mean_teacher_ema(
  teacher_params : Array[Double],
  student_params : Array[Double],
  config : MeanTeacherConfig
) -> Array[Double] {
  let n = if teacher_params.length() < student_params.length() {
    teacher_params.length()
  } else {
    student_params.length()
  }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(config.ema_decay * teacher_params[i] + (1.0 - config.ema_decay) * student_params[i])
  }
  result
}

/// Mean Teacher 损失 / Mean teacher consistency loss.
pub fn mean_teacher_loss(
  teacher_output : Array[Double],
  student_output : Array[Double],
  config : MeanTeacherConfig
) -> Double {
  let n = if teacher_output.length() < student_output.length() {
    teacher_output.length()
  } else {
    student_output.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut total = 0.0
    for i in 0..<n {
      let diff = teacher_output[i] - student_output[i]
      total = total + diff * diff
    }
    config.consistency_weight * total / n.to_double()
  }
}

/// 构造去偏蒸馏配置 / Build debiased distill config.
pub fn make_debiased_distill(
  bias_estimate : Double,
  num_samples : Int,
  weight : Double
) -> DebiasedDistillConfig {
  { bias_estimate, num_samples, weight }
}

/// 去偏损失 / Debiased distillation loss.
pub fn debiased_loss(
  raw_loss : Double,
  config : DebiasedDistillConfig
) -> Double {
  let correction = bias_correction(config)
  config.weight * (raw_loss - correction)
}

/// 偏差校正 / Bias correction term.
pub fn bias_correction(config : DebiasedDistillConfig) -> Double {
  if config.num_samples <= 0 {
    0.0
  } else {
    config.bias_estimate / config.num_samples.to_double()
  }
}

/// 蒸馏评估 / Evaluate distillation quality.
pub fn distill_evaluate(
  teacher_acc : Double,
  student_acc : Double,
  distill_loss : Double
) -> Double {
  let acc_ratio = if teacher_acc == 0.0 { 0.0 } else { student_acc / teacher_acc }
  acc_ratio - 0.01 * distill_loss
}

/// 蒸馏效率 / Distillation efficiency.
pub fn distill_efficiency(
  student_acc : Double,
  teacher_params : Int,
  student_params : Int
) -> Double {
  if teacher_params <= 0 || student_params <= 0 {
    0.0
  } else {
    student_acc * student_params.to_double() / teacher_params.to_double()
  }
}

/// 蒸馏压缩比 / Distillation compression ratio.
pub fn distill_compression_ratio(teacher_params : Int, student_params : Int) -> Double {
  if student_params <= 0 {
    0.0
  } else {
    teacher_params.to_double() / student_params.to_double()
  }
}

/// 构造蒸馏调度配置 / Build distill schedule config.
pub fn make_distill_schedule(
  init_temperature : Double,
  final_temperature : Double,
  num_steps : Int,
  schedule_type : String
) -> DistillScheduleConfig {
  { init_temperature, final_temperature, num_steps, schedule_type }
}

/// 调度步骤 / Schedule step value.
pub fn schedule_step(config : DistillScheduleConfig, step : Int) -> Double {
  if config.num_steps <= 0 {
    config.init_temperature
  } else {
    let progress = clamp(step.to_double() / config.num_steps.to_double(), 0.0, 1.0)
    if config.schedule_type == "linear" {
      config.init_temperature + (config.final_temperature - config.init_temperature) * progress
    } else if config.schedule_type == "exp" {
      let ratio = config.final_temperature / config.init_temperature
      config.init_temperature * exp(progress * log(ratio))
    } else {
      config.init_temperature
    }
  }
}

/// 调度温度 / Schedule temperature at step.
pub fn schedule_temperature(config : DistillScheduleConfig, step : Int) -> Double {
  schedule_step(config, step)
}

/// 模块标识 / Module identity.
pub fn distill_adv_id() -> String {
  "learncore/distill_adv"
}