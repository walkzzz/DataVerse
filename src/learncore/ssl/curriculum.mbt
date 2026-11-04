///|
/// # learncore/curriculum 课程学习 / Curriculum Learning
///
/// 课程学习策略：难度评分、采样器、教师信号、自步学习、BoostRate、反课程、平衡课程、在线课程、迁移课程、BabyStep、Macro 课程、评估与消融。
///
/// # Curriculum Learning
///
/// Difficulty scoring, samplers, teacher signal, self-paced, boost, anti/balanced/online/transfer curriculum, baby step, macro, evaluation.
fn curriculum_exp(x : Double) -> Double {
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
fn curriculum_log(x : Double) -> Double {
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
fn curriculum_sqrt(x : Double) -> Double {
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
fn curriculum_abs_d(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

///|
fn curriculum_sin_d(x : Double) -> Double {
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
fn curriculum_clamp(x : Double, lo : Double, hi : Double) -> Double {
  if x < lo {
    lo
  } else if x > hi {
    hi
  } else {
    x
  }
}

///|
pub(all) struct Curriculum {
  samples : Array[Int32]
  difficulties : Array[Double]
  current_step : Int32
  max_step : Int32
} derive(Debug, Eq)

///|
pub extend Curriculum with Eq::{equal, not_equal}

///|
pub extend Curriculum with Debug::{to_repr}

///|
pub(all) struct DifficultyConfig {
  method_name : String
  threshold : Double
  num_bins : Int32
} derive(Debug, Eq)

///|
pub extend DifficultyConfig with Eq::{equal, not_equal}

///|
pub extend DifficultyConfig with Debug::{to_repr}

///|
pub(all) struct SamplerConfig {
  batch_size : Int32
  easy_ratio : Double
  hard_ratio : Double
} derive(Debug, Eq)

///|
pub extend SamplerConfig with Eq::{equal, not_equal}

///|
pub extend SamplerConfig with Debug::{to_repr}

///|
pub(all) struct TeacherConfig {
  teacher_type : String
  confidence_threshold : Double
  temperature : Double
} derive(Debug, Eq)

///|
pub extend TeacherConfig with Eq::{equal, not_equal}

///|
pub extend TeacherConfig with Debug::{to_repr}

///|
pub(all) struct SelfPacedConfig {
  threshold : Double
  lambda : Double
  gamma : Double
} derive(Debug, Eq)

///|
pub extend SelfPacedConfig with Eq::{equal, not_equal}

///|
pub extend SelfPacedConfig with Debug::{to_repr}

///|
pub(all) struct BoostConfig {
  init_rate : Double
  decay : Double
  max_rate : Double
} derive(Debug, Eq)

///|
pub extend BoostConfig with Eq::{equal, not_equal}

///|
pub extend BoostConfig with Debug::{to_repr}

///|
pub(all) struct AntiCurriculumConfig {
  start_hard : Bool
  schedule : String
  num_steps : Int32
} derive(Debug, Eq)

///|
pub extend AntiCurriculumConfig with Eq::{equal, not_equal}

///|
pub extend AntiCurriculumConfig with Debug::{to_repr}

///|
pub(all) struct BalancedConfig {
  target_ratio : Double
  tolerance : Double
  buffer_size : Int32
} derive(Debug, Eq)

///|
pub extend BalancedConfig with Eq::{equal, not_equal}

///|
pub extend BalancedConfig with Debug::{to_repr}

///|
pub(all) struct OnlineCurriculumConfig {
  window_size : Int32
  adapt_rate : Double
  min_difficulty : Double
  max_difficulty : Double
} derive(Debug, Eq)

///|
pub extend OnlineCurriculumConfig with Eq::{equal, not_equal}

///|
pub extend OnlineCurriculumConfig with Debug::{to_repr}

///|
pub(all) struct TransferCurriculumConfig {
  source_steps : Int32
  target_steps : Int32
  adapt_rate : Double
} derive(Debug, Eq)

///|
pub extend TransferCurriculumConfig with Eq::{equal, not_equal}

///|
pub extend TransferCurriculumConfig with Debug::{to_repr}

///|
pub(all) struct BabyStepConfig {
  init_difficulty : Double
  step_increment : Double
  max_difficulty : Double
} derive(Debug, Eq)

///|
pub extend BabyStepConfig with Eq::{equal, not_equal}

///|
pub extend BabyStepConfig with Debug::{to_repr}

///|
pub(all) struct MacroCurriculumConfig {
  num_phases : Int32
  phase_length : Int32
  difficulty_increment : Double
} derive(Debug, Eq)

///|
pub extend MacroCurriculumConfig with Eq::{equal, not_equal}

///|
pub extend MacroCurriculumConfig with Debug::{to_repr}

///|
/// 构造课程 / Build curriculum.
pub fn curriculum_make_curriculum(
  samples : Array[Int32],
  difficulties : Array[Double],
  max_step : Int32,
) -> Curriculum {
  { samples, difficulties, current_step: 0, max_step, }
}

///|
/// 课程添加样本 / Add sample to curriculum.
pub fn curriculum_curriculum_add(
  curr : Curriculum,
  sample : Int32,
  difficulty : Double,
) -> Curriculum {
  let new_samples = curr.samples
  new_samples.push(sample)
  let new_diffs = curr.difficulties
  new_diffs.push(difficulty)
  {
    samples: new_samples,
    difficulties: new_diffs,
    current_step: curr.current_step,
    max_step: curr.max_step,
  }
}

///|
/// 课程排序 / Sort curriculum by difficulty.
pub fn curriculum_curriculum_sort(curr : Curriculum) -> Curriculum {
  let n = if curr.samples.length() < curr.difficulties.length() {
    curr.samples.length()
  } else {
    curr.difficulties.length()
  }
  let pairs : Array[(Double, Int32)] = []
  for i in 0..<n {
    pairs.push((curr.difficulties[i], curr.samples[i]))
  }
  pairs.sort_by(fn(a, b) { a.0.compare(b.0) })
  let sorted_samples : Array[Int32] = []
  let sorted_diffs : Array[Double] = []
  for i in 0..<pairs.length() {
    sorted_samples.push(pairs[i].1)
    sorted_diffs.push(pairs[i].0)
  }
  {
    samples: sorted_samples,
    difficulties: sorted_diffs,
    current_step: curr.current_step,
    max_step: curr.max_step,
  }
}

///|
/// 构造难度配置 / Build difficulty config.
pub fn curriculum_make_difficulty(
  method_name : String,
  threshold : Double,
  num_bins : Int32,
) -> DifficultyConfig {
  { method_name, threshold, num_bins, }
}

///|
/// 难度评分 / Compute difficulty score from loss.
pub fn curriculum_difficulty_score(loss : Double, config : DifficultyConfig) -> Double {
  if config.method_name == "loss" {
    curriculum_clamp(loss, 0.0, 999999.0)
  } else if config.method_name == "log_loss" {
    if loss > 0.0 {
      curriculum_log(loss + 1.0)
    } else {
      0.0
    }
  } else if config.method_name == "sqrt_loss" {
    curriculum_sqrt(curriculum_clamp(loss, 0.0, 999999.0))
  } else {
    curriculum_clamp(loss, 0.0, 999999.0)
  }
}

///|
/// 难度等级 / Assign difficulty rank (bin).
pub fn curriculum_difficulty_rank(score : Double, config : DifficultyConfig) -> Int32 {
  if config.num_bins <= 0 {
    0
  } else {
    let rank = (score * config.num_bins.to_double()).to_int()
    if rank < 0 {
      0
    } else if rank >= config.num_bins {
      config.num_bins - 1
    } else {
      rank
    }
  }
}

///|
/// 构造课程采样器 / Build curriculum sampler.
pub fn curriculum_make_sampler_curriculum(
  batch_size : Int32,
  easy_ratio : Double,
  hard_ratio : Double,
) -> SamplerConfig {
  { batch_size, easy_ratio, hard_ratio, }
}

///|
/// 采样简单样本 / Sample easy samples.
pub fn curriculum_sample_easy(
  samples : Array[Int32],
  difficulties : Array[Double],
  batch_size : Int32,
) -> Array[Int32] {
  let n = if samples.length() < difficulties.length() {
    samples.length()
  } else {
    difficulties.length()
  }
  if n == 0 || batch_size <= 0 {
    []
  } else {
    let pairs : Array[(Double, Int32)] = []
    for i in 0..<n {
      pairs.push((difficulties[i], samples[i]))
    }
    pairs.sort_by(fn(a, b) { a.0.compare(b.0) })
    let take = if batch_size < pairs.length() {
      batch_size
    } else {
      pairs.length()
    }
    let result : Array[Int32] = []
    for i in 0..<take {
      result.push(pairs[i].1)
    }
    result
  }
}

///|
/// 采样困难样本 / Sample hard samples.
pub fn curriculum_sample_hard(
  samples : Array[Int32],
  difficulties : Array[Double],
  batch_size : Int32,
) -> Array[Int32] {
  let n = if samples.length() < difficulties.length() {
    samples.length()
  } else {
    difficulties.length()
  }
  if n == 0 || batch_size <= 0 {
    []
  } else {
    let pairs : Array[(Double, Int32)] = []
    for i in 0..<n {
      pairs.push((difficulties[i], samples[i]))
    }
    pairs.sort_by(fn(a, b) { b.0.compare(a.0) })
    let take = if batch_size < pairs.length() {
      batch_size
    } else {
      pairs.length()
    }
    let result : Array[Int32] = []
    for i in 0..<take {
      result.push(pairs[i].1)
    }
    result
  }
}

///|
/// 混合采样 / Mixed sampling with easy/hard ratio.
pub fn curriculum_sample_mixed(
  samples : Array[Int32],
  difficulties : Array[Double],
  config : SamplerConfig,
) -> Array[Int32] {
  let easy_count = (config.batch_size.to_double() * config.easy_ratio).to_int()
  let hard_count = (config.batch_size.to_double() * config.hard_ratio).to_int()
  let easy = curriculum_sample_easy(samples, difficulties, easy_count)
  let hard = curriculum_sample_hard(samples, difficulties, hard_count)
  let result : Array[Int32] = []
  for i in 0..<easy.length() {
    result.push(easy[i])
  }
  for i in 0..<hard.length() {
    result.push(hard[i])
  }
  result
}

///|
/// 构造教师配置 / Build teacher config.
pub fn curriculum_make_teacher(
  teacher_type : String,
  confidence_threshold : Double,
  temperature : Double,
) -> TeacherConfig {
  { teacher_type, confidence_threshold, temperature, }
}

///|
/// 教师信号 / Teacher confidence signal.
pub fn curriculum_teacher_signal(
  teacher_logits : Array[Double],
  config : TeacherConfig,
) -> Double {
  let n = teacher_logits.length()
  if n == 0 {
    0.0
  } else {
    let mut max_val = teacher_logits[0]
    for i in 1..<n {
      if teacher_logits[i] > max_val {
        max_val = teacher_logits[i]
      }
    }
    let mut sum_exp = 0.0
    for i in 0..<n {
      sum_exp = sum_exp +
        curriculum_exp((teacher_logits[i] - max_val) / config.temperature)
    }
    if sum_exp == 0.0 {
      0.0
    } else {
      let max_prob = 1.0 / sum_exp
      if max_prob >= config.confidence_threshold {
        max_prob
      } else {
        0.0
      }
    }
  }
}

///|
/// 教师知识 / Teacher knowledge (soft labels).
pub fn curriculum_teacher_knowledge(
  teacher_logits : Array[Double],
  temperature : Double,
) -> Array[Double] {
  let n = teacher_logits.length()
  if n == 0 || temperature == 0.0 {
    []
  } else {
    let mut max_val = teacher_logits[0]
    for i in 1..<n {
      if teacher_logits[i] > max_val {
        max_val = teacher_logits[i]
      }
    }
    let exps = teacher_logits.map(fn(x) { curriculum_exp((x - max_val) / temperature) })
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

///|
/// 构造自步配置 / Build self-paced config.
pub fn curriculum_make_self_paced(
  threshold : Double,
  lambda : Double,
  gamma : Double,
) -> SelfPacedConfig {
  { threshold, lambda, gamma, }
}

///|
/// SPL 损失 / Self-paced learning loss.
/// L = loss + lambda * v, where v is sample weight.
pub fn curriculum_spl_loss(loss : Double, weight : Double, lambda : Double) -> Double {
  loss + lambda * weight
}

///|
/// SPL 权重 / Self-paced weight.
/// v = 1 - lambda / loss if loss > lambda, else 0.
pub fn curriculum_spl_weight(loss : Double, lambda : Double) -> Double {
  if loss > lambda && loss > 0.0 {
    1.0 - lambda / loss
  } else {
    0.0
  }
}

///|
/// SPL 阈值 / Self-paced threshold update.
pub fn curriculum_spl_threshold(config : SelfPacedConfig, step : Int32) -> Double {
  if step <= 0 {
    config.threshold
  } else {
    config.threshold + config.gamma * step.to_double()
  }
}

///|
/// 构造 Boost 配置 / Build boost config.
pub fn curriculum_make_boost_rate(
  init_rate : Double,
  decay : Double,
  max_rate : Double,
) -> BoostConfig {
  { init_rate, decay, max_rate, }
}

///|
/// Boost 采样 / Boost sample selection.
pub fn curriculum_boost_sample(
  samples : Array[Int32],
  losses : Array[Double],
  rate : Double,
) -> Array[Int32] {
  let n = if samples.length() < losses.length() {
    samples.length()
  } else {
    losses.length()
  }
  let result : Array[Int32] = []
  for i in 0..<n {
    let p = curriculum_clamp(losses[i] * rate, 0.0, 1.0)
    let seed = curriculum_abs_d(curriculum_sin_d(samples[i].to_double()))
    if seed < p {
      result.push(samples[i])
    }
  }
  result
}

///|
/// Boost 权重 / Boost weight schedule.
pub fn curriculum_boost_weight(config : BoostConfig, step : Int32) -> Double {
  let rate = config.init_rate * curriculum_exp(-config.decay * step.to_double())
  curriculum_clamp(rate, 0.0, config.max_rate)
}

///|
/// 构造反课程配置 / Build anti-curriculum config.
pub fn curriculum_make_anti_curriculum(
  start_hard : Bool,
  schedule : String,
  num_steps : Int32,
) -> AntiCurriculumConfig {
  { start_hard, schedule, num_steps, }
}

///|
/// 反课程采样 / Anti-curriculum sampling (hard first).
pub fn curriculum_anti_sample(
  samples : Array[Int32],
  difficulties : Array[Double],
  step : Int32,
  config : AntiCurriculumConfig,
) -> Array[Int32] {
  let n = if samples.length() < difficulties.length() {
    samples.length()
  } else {
    difficulties.length()
  }
  if n == 0 {
    []
  } else {
    let progress = if config.num_steps <= 0 {
      1.0
    } else {
      curriculum_clamp(step.to_double() / config.num_steps.to_double(), 0.0, 1.0)
    }
    let threshold = 1.0 - progress
    let result : Array[Int32] = []
    for i in 0..<n {
      let norm_d = curriculum_clamp(difficulties[i], 0.0, 1.0)
      if norm_d >= threshold {
        result.push(samples[i])
      }
    }
    result
  }
}

///|
/// 反课程调度 / Anti-curriculum schedule.
pub fn curriculum_anti_schedule(config : AntiCurriculumConfig, step : Int32) -> Double {
  if config.num_steps <= 0 {
    1.0
  } else {
    let progress = curriculum_clamp(
      step.to_double() / config.num_steps.to_double(),
      0.0,
      1.0,
    )
    if config.schedule == "linear" {
      1.0 - progress
    } else if config.schedule == "exp" {
      curriculum_exp(-3.0 * progress)
    } else {
      1.0 - progress
    }
  }
}

///|
/// 构造平衡课程配置 / Build balanced curriculum config.
pub fn curriculum_make_balanced_curriculum(
  target_ratio : Double,
  tolerance : Double,
  buffer_size : Int32,
) -> BalancedConfig {
  { target_ratio, tolerance, buffer_size, }
}

///|
/// 平衡简单困难 / Balance easy and hard samples.
pub fn curriculum_balance_easy_hard(
  easy_samples : Array[Int32],
  hard_samples : Array[Int32],
  config : BalancedConfig,
) -> Array[Int32] {
  let easy_n = easy_samples.length()
  let hard_n = hard_samples.length()
  if easy_n + hard_n == 0 {
    []
  } else {
    let current_ratio = easy_n.to_double() / (easy_n + hard_n).to_double()
    let result : Array[Int32] = []
    if curriculum_abs_d(current_ratio - config.target_ratio) < config.tolerance {
      for i in 0..<easy_n {
        result.push(easy_samples[i])
      }
      for i in 0..<hard_n {
        result.push(hard_samples[i])
      }
    } else if current_ratio < config.target_ratio {
      for i in 0..<easy_n {
        result.push(easy_samples[i])
      }
      let take = (easy_n.to_double() *
      (1.0 - config.target_ratio) /
      config.target_ratio).to_int()
      let t = if take < hard_n { take } else { hard_n }
      for i in 0..<t {
        result.push(hard_samples[i])
      }
    } else {
      let take = (hard_n.to_double() *
      config.target_ratio /
      (1.0 - config.target_ratio)).to_int()
      let t = if take < easy_n { take } else { easy_n }
      for i in 0..<t {
        result.push(easy_samples[i])
      }
      for i in 0..<hard_n {
        result.push(hard_samples[i])
      }
    }
    result
  }
}

///|
/// 平衡比例 / Compute balance ratio.
pub fn curriculum_balance_ratio(easy_count : Int32, hard_count : Int32) -> Double {
  if easy_count + hard_count == 0 {
    0.5
  } else {
    easy_count.to_double() / (easy_count + hard_count).to_double()
  }
}

///|
/// 构造在线课程配置 / Build online curriculum config.
pub fn curriculum_make_online_curriculum(
  window_size : Int32,
  adapt_rate : Double,
  min_difficulty : Double,
  max_difficulty : Double,
) -> OnlineCurriculumConfig {
  { window_size, adapt_rate, min_difficulty, max_difficulty, }
}

///|
/// 在线更新 / Online difficulty update.
pub fn curriculum_online_update(
  config : OnlineCurriculumConfig,
  current_difficulty : Double,
  loss : Double,
) -> Double {
  let target = curriculum_clamp(loss, config.min_difficulty, config.max_difficulty)
  let updated = current_difficulty +
    config.adapt_rate * (target - current_difficulty)
  curriculum_clamp(updated, config.min_difficulty, config.max_difficulty)
}

///|
/// 在线难度 / Online difficulty from window of losses.
pub fn curriculum_online_difficulty(
  losses : Array[Double],
  config : OnlineCurriculumConfig,
) -> Double {
  let n = losses.length()
  if n == 0 {
    config.min_difficulty
  } else {
    let start = if n > config.window_size && config.window_size > 0 {
      n - config.window_size
    } else {
      0
    }
    let mut sum = 0.0
    let mut count = 0
    for i in start..<n {
      sum = sum + losses[i]
      count = count + 1
    }
    if count == 0 {
      config.min_difficulty
    } else {
      curriculum_clamp(
        sum / count.to_double(),
        config.min_difficulty,
        config.max_difficulty,
      )
    }
  }
}

///|
/// 构造迁移课程配置 / Build transfer curriculum config.
pub fn curriculum_make_transfer_curriculum(
  source_steps : Int32,
  target_steps : Int32,
  adapt_rate : Double,
) -> TransferCurriculumConfig {
  { source_steps, target_steps, adapt_rate, }
}

///|
/// 迁移调度 / Transfer schedule.
pub fn curriculum_transfer_schedule(
  config : TransferCurriculumConfig,
  step : Int32,
) -> Double {
  if step < config.source_steps {
    curriculum_clamp(step.to_double() / config.source_steps.to_double(), 0.0, 1.0)
  } else {
    let target_step = step - config.source_steps
    if config.target_steps <= 0 {
      1.0
    } else {
      curriculum_clamp(
        1.0 -
        target_step.to_double() /
        config.target_steps.to_double() *
        config.adapt_rate,
        0.0,
        1.0,
      )
    }
  }
}

///|
/// 迁移适应 / Transfer adaptation weight.
pub fn curriculum_transfer_adapt(
  config : TransferCurriculumConfig,
  step : Int32,
) -> Double {
  if step < config.source_steps {
    1.0
  } else {
    let target_step = step - config.source_steps
    curriculum_clamp(curriculum_exp(-config.adapt_rate * target_step.to_double()), 0.0, 1.0)
  }
}

///|
/// 构造 BabyStep 配置 / Build baby step config.
pub fn curriculum_make_baby_step(
  init_difficulty : Double,
  step_increment : Double,
  max_difficulty : Double,
) -> BabyStepConfig {
  { init_difficulty, step_increment, max_difficulty, }
}

///|
/// BabyStep 调度 / Baby step schedule.
pub fn curriculum_baby_step_schedule(config : BabyStepConfig, step : Int32) -> Double {
  let d = config.init_difficulty + config.step_increment * step.to_double()
  curriculum_clamp(d, 0.0, config.max_difficulty)
}

///|
/// BabyStep 下一步 / Baby step next difficulty.
pub fn curriculum_baby_step_next(config : BabyStepConfig, current : Double) -> Double {
  curriculum_clamp(current + config.step_increment, 0.0, config.max_difficulty)
}

///|
/// 构造 Macro 课程配置 / Build macro curriculum config.
pub fn curriculum_make_macro_curriculum(
  num_phases : Int32,
  phase_length : Int32,
  difficulty_increment : Double,
) -> MacroCurriculumConfig {
  { num_phases, phase_length, difficulty_increment, }
}

///|
/// Macro 调度 / Macro schedule.
pub fn curriculum_macro_schedule(config : MacroCurriculumConfig, step : Int32) -> Double {
  if config.phase_length <= 0 {
    0.0
  } else {
    let phase = step / config.phase_length
    curriculum_clamp(config.difficulty_increment * phase.to_double(), 0.0, 999999.0)
  }
}

///|
/// Macro 阶段 / Macro current phase.
pub fn curriculum_macro_phase(config : MacroCurriculumConfig, step : Int32) -> Int32 {
  if config.phase_length <= 0 {
    0
  } else {
    let phase = step / config.phase_length
    if phase >= config.num_phases {
      config.num_phases - 1
    } else {
      phase
    }
  }
}

///|
/// 课程评估 / Evaluate curriculum.
pub fn curriculum_curriculum_evaluate(
  losses : Array[Double],
  difficulties : Array[Double],
) -> Double {
  let n = if losses.length() < difficulties.length() {
    losses.length()
  } else {
    difficulties.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + losses[i] * difficulties[i]
    }
    sum / n.to_double()
  }
}

///|
/// 课程进度 / Curriculum progress.
pub fn curriculum_curriculum_progress(curr : Curriculum) -> Double {
  if curr.max_step <= 0 {
    0.0
  } else {
    curriculum_clamp(curr.current_step.to_double() / curr.max_step.to_double(), 0.0, 1.0)
  }
}

///|
/// 课程消融 / Curriculum ablation (compare with/without).
pub fn curriculum_curriculum_ablation(loss_with : Double, loss_without : Double) -> Double {
  loss_without - loss_with
}

///|
/// 反课程损失 / Anti-curriculum loss weighting.
pub fn curriculum_anti_curriculum_loss(
  loss : Double,
  difficulty : Double,
  step : Int32,
  num_steps : Int32,
) -> Double {
  if num_steps <= 0 {
    loss
  } else {
    let progress = curriculum_clamp(step.to_double() / num_steps.to_double(), 0.0, 1.0)
    let weight = 1.0 - 0.5 * progress * difficulty
    loss * weight
  }
}

///|
/// 模块标识 / Module identity.
pub fn curriculum_curriculum_id() -> String {
  "learncore/curriculum"
}
