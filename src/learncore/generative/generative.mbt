///|
/// # learncore/generative 生成模型 / Generative Models
///
/// 生成模型族：GAN、VAE、Diffusion、Flow、Autoregressive、Markov、HMM、TextGAN 等。
///
/// # Generative Models
///
/// GAN, VAE, Diffusion, Flow, Autoregressive, Markov, HMM, TextGAN, etc.

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

fn box_muller(seed : Int) -> Double {
  let u1 = rand_double(seed)
  let u2 = rand_double(lcg_next(seed))
  let r = sqrt(-2.0 * log(u1 + 0.000000001))
  let two_pi = 6.283185307179586
  r * cos(0.0 + two_pi * u2)
}

fn cos(x : Double) -> Double {
  let half_pi = 1.5707963267948966
  sin(x + half_pi)
}

fn sin(x : Double) -> Double {
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
    term = term * y2 / ((2 * j).to_double() * (2 * j + 1).to_double()) * (-1.0)
    result = result + term
  }
  result
}

/// GAN 模型配置 / GAN model configuration.
pub struct GANModel {
  gen_dim : Int
  disc_dim : Int
  noise_dim : Int
  lr : Double
  seed : Int
} derive(Debug, Eq)

pub extend GANModel with Eq::{equal, not_equal}
pub extend GANModel with Debug::{to_repr}

/// VAE 模型配置 / VAE model configuration.
pub struct VAEModel {
  input_dim : Int
  hidden_dim : Int
  latent_dim : Int
  lr : Double
  seed : Int
} derive(Debug, Eq)

pub extend VAEModel with Eq::{equal, not_equal}
pub extend VAEModel with Debug::{to_repr}

/// Diffusion 模型配置 / Diffusion model configuration.
pub struct DiffusionModel {
  num_steps : Int
  beta_start : Double
  beta_end : Double
  input_dim : Int
  seed : Int
} derive(Debug, Eq)

pub extend DiffusionModel with Eq::{equal, not_equal}
pub extend DiffusionModel with Debug::{to_repr}

/// TextGAN 配置 / TextGAN configuration.
pub struct TextGANModel {
  vocab_size : Int
  seq_len : Int
  embed_dim : Int
  seed : Int
} derive(Debug, Eq)

pub extend TextGANModel with Eq::{equal, not_equal}
pub extend TextGANModel with Debug::{to_repr}

/// Flow 模型配置 / Flow model configuration.
pub struct FlowModel {
  input_dim : Int
  num_layers : Int
  seed : Int
} derive(Debug, Eq)

pub extend FlowModel with Eq::{equal, not_equal}
pub extend FlowModel with Debug::{to_repr}

/// Autoregressive 模型配置 / Autoregressive model configuration.
pub struct AutoregressiveModel {
  vocab_size : Int
  seq_len : Int
  hidden_dim : Int
  seed : Int
} derive(Debug, Eq)

pub extend AutoregressiveModel with Eq::{equal, not_equal}
pub extend AutoregressiveModel with Debug::{to_repr}

/// Markov 模型配置 / Markov model configuration.
pub struct MarkovModel {
  num_states : Int
  transition : Array[Array[Double]]
  initial : Array[Double]
  seed : Int
} derive(Debug, Eq)

pub extend MarkovModel with Eq::{equal, not_equal}
pub extend MarkovModel with Debug::{to_repr}

/// HMM 生成配置 / HMM generation configuration.
pub struct HMMGenModel {
  num_states : Int
  num_obs : Int
  transition : Array[Array[Double]]
  emission : Array[Array[Double]]
  initial : Array[Double]
  seed : Int
} derive(Debug, Eq)

pub extend HMMGenModel with Eq::{equal, not_equal}
pub extend HMMGenModel with Debug::{to_repr}

/// Generator 网络配置 / Generator network configuration.
pub struct GeneratorNet {
  input_dim : Int
  output_dim : Int
  hidden_dim : Int
  weights : Array[Array[Double]]
  bias : Array[Double]
} derive(Debug, Eq)

pub extend GeneratorNet with Eq::{equal, not_equal}
pub extend GeneratorNet with Debug::{to_repr}

/// Discriminator 网络配置 / Discriminator network configuration.
pub struct DiscriminatorNet {
  input_dim : Int
  hidden_dim : Int
  weights : Array[Array[Double]]
  bias : Array[Double]
} derive(Debug, Eq)

pub extend DiscriminatorNet with Eq::{equal, not_equal}
pub extend DiscriminatorNet with Debug::{to_repr}

/// 构造 GAN 模型 / Build GAN model.
pub fn make_gan_model(gen_dim : Int, disc_dim : Int, noise_dim : Int, lr : Double, seed : Int) -> GANModel {
  { gen_dim, disc_dim, noise_dim, lr, seed }
}

/// GAN 训练步 / GAN training step.
pub fn gan_train_step(model : GANModel, real_data : Array[Double], step : Int) -> (GANModel, Double) {
  let n = real_data.length()
  if n == 0 {
    (model, 0.0)
  } else {
    let noise : Array[Double] = Array::make(model.noise_dim, 0.0)
    for i in 0..<model.noise_dim {
      noise[i] = box_muller(model.seed + step * 31 + i)
    }
    let fake = gan_generate(model, noise)
    let d_real = gan_discriminate(model, real_data)
    let d_fake = gan_discriminate(model, fake)
    let eps = 0.000000001
    let loss = -(log(d_real + eps) + log(1.0 - d_fake + eps))
    let new_seed = lcg_next(model.seed)
    ({ gen_dim: model.gen_dim, disc_dim: model.disc_dim, noise_dim: model.noise_dim, lr: model.lr, seed: new_seed }, loss)
  }
}

/// GAN 生成 / GAN generate.
pub fn gan_generate(model : GANModel, noise : Array[Double]) -> Array[Double] {
  let result : Array[Double] = Array::make(model.gen_dim, 0.0)
  for i in 0..<model.gen_dim {
    let mut sum = 0.0
    for j in 0..<model.noise_dim {
      if j < noise.length() {
        sum = sum + noise[j] / model.noise_dim.to_double()
      }
    }
    result[i] = tanh_d(sum)
  }
  result
}

/// GAN 判别 / GAN discriminate.
pub fn gan_discriminate(model : GANModel, input : Array[Double]) -> Double {
  let n = input.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + input[i]
    }
    sigmoid(sum / n.to_double())
  }
}

/// 构造 VAE 模型 / Build VAE model.
pub fn make_vae_model(input_dim : Int, hidden_dim : Int, latent_dim : Int, lr : Double, seed : Int) -> VAEModel {
  { input_dim, hidden_dim, latent_dim, lr, seed }
}

/// VAE 编码 / VAE encode.
pub fn vae_encode(model : VAEModel, input : Array[Double]) -> (Array[Double], Array[Double]) {
  let mu : Array[Double] = Array::make(model.latent_dim, 0.0)
  let log_var : Array[Double] = Array::make(model.latent_dim, 0.0)
  for i in 0..<model.latent_dim {
    let mut sum = 0.0
    for j in 0..<model.input_dim {
      if j < input.length() {
        sum = sum + input[j] / model.input_dim.to_double()
      }
    }
    mu[i] = tanh_d(sum)
    log_var[i] = -1.0
  }
  (mu, log_var)
}

/// VAE 解码 / VAE decode.
pub fn vae_decode(model : VAEModel, latent : Array[Double]) -> Array[Double] {
  let result : Array[Double] = Array::make(model.input_dim, 0.0)
  for i in 0..<model.input_dim {
    let mut sum = 0.0
    for j in 0..<model.latent_dim {
      if j < latent.length() {
        sum = sum + latent[j] / model.latent_dim.to_double()
      }
    }
    result[i] = sigmoid(sum)
  }
  result
}

/// VAE 损失 / VAE loss.
pub fn vae_loss(recon : Array[Double], target : Array[Double], mu : Array[Double], log_var : Array[Double]) -> Double {
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
        kl = kl + -0.5 * (1.0 + log_var[i] - mu[i] * mu[i] - exp(log_var[i]))
      }
    }
    recon_loss + kl
  }
}

/// VAE 采样 / VAE sample.
pub fn vae_sample(model : VAEModel, mu : Array[Double], log_var : Array[Double], step : Int) -> Array[Double] {
  let result : Array[Double] = Array::make(model.latent_dim, 0.0)
  for i in 0..<model.latent_dim {
    let eps = box_muller(model.seed + step * 17 + i)
    let std = exp(0.5 * log_var[i])
    result[i] = mu[i] + std * eps
  }
  result
}

/// 构造 Diffusion 模型 / Build diffusion model.
pub fn make_diffusion(num_steps : Int, beta_start : Double, beta_end : Double, input_dim : Int, seed : Int) -> DiffusionModel {
  { num_steps, beta_start, beta_end, input_dim, seed }
}

/// Diffusion 前向 / Diffusion forward (add noise).
pub fn diffusion_forward(model : DiffusionModel, x0 : Array[Double], t : Int, step : Int) -> Array[Double] {
  let n = x0.length()
  if n == 0 || t <= 0 || t > model.num_steps {
    x0
  } else {
    let beta = model.beta_start + (model.beta_end - model.beta_start) * t.to_double() / model.num_steps.to_double()
    let alpha = 1.0 - beta
    let mut cum_alpha = 1.0
    for _ in 0..<t {
      cum_alpha = cum_alpha * alpha
    }
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let noise = box_muller(model.seed + step * 13 + i)
      result[i] = sqrt(cum_alpha) * x0[i] + sqrt(1.0 - cum_alpha) * noise
    }
    result
  }
}

/// Diffusion 反向 / Diffusion reverse (denoise).
pub fn diffusion_reverse(model : DiffusionModel, xt : Array[Double], t : Int, step : Int) -> Array[Double] {
  let n = xt.length()
  if n == 0 || t <= 0 {
    xt
  } else {
    let beta = model.beta_start + (model.beta_end - model.beta_start) * t.to_double() / model.num_steps.to_double()
    let alpha = 1.0 - beta
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      let noise = box_muller(model.seed + step * 19 + i)
      result[i] = (xt[i] - beta / sqrt(1.0 - alpha) * noise) / sqrt(alpha)
    }
    result
  }
}

/// Diffusion 单步 / Diffusion single step.
pub fn diffusion_step(model : DiffusionModel, x : Array[Double], t : Int, step : Int) -> Array[Double] {
  diffusion_reverse(model, x, t, step)
}

/// 构造 TextGAN / Build TextGAN.
pub fn make_text_gan(vocab_size : Int, seq_len : Int, embed_dim : Int, seed : Int) -> TextGANModel {
  { vocab_size, seq_len, embed_dim, seed }
}

/// TextGAN 生成 / TextGAN generate.
pub fn text_gan_generate(model : TextGANModel, noise : Array[Double]) -> Array[Int] {
  let result : Array[Int] = Array::make(model.seq_len, 0)
  for i in 0..<model.seq_len {
    let mut sum = 0.0
    for j in 0..<noise.length() {
      sum = sum + noise[j]
    }
    let v = (sigmoid(sum) * model.vocab_size.to_double()).to_int()
    let clamped = if v < 0 { 0 } else if v >= model.vocab_size { model.vocab_size - 1 } else { v }
    result[i] = clamped
  }
  result
}

/// TextGAN 判别 / TextGAN discriminate.
pub fn text_gan_discriminate(model : TextGANModel, seq : Array[Int]) -> Double {
  let n = seq.length()
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let v = seq[i].to_double() / model.vocab_size.to_double()
      sum = sum + v
    }
    sigmoid(sum / n.to_double())
  }
}

/// 构造 Flow 模型 / Build flow model.
pub fn make_flow_model(input_dim : Int, num_layers : Int, seed : Int) -> FlowModel {
  { input_dim, num_layers, seed }
}

/// Flow 前向 / Flow forward.
pub fn flow_forward(model : FlowModel, x : Array[Double]) -> Array[Double] {
  let n = x.length()
  if n == 0 {
    x
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = x[i]
    }
    for _ in 0..<model.num_layers {
      for i in 0..<n {
        result[i] = tanh_d(result[i] + 0.1)
      }
    }
    result
  }
}

/// Flow 反向 / Flow inverse.
pub fn flow_inverse(model : FlowModel, y : Array[Double]) -> Array[Double] {
  let n = y.length()
  if n == 0 {
    y
  } else {
    let result : Array[Double] = Array::make(n, 0.0)
    for i in 0..<n {
      result[i] = y[i]
    }
    for _ in 0..<model.num_layers {
      for i in 0..<n {
        let mut z = result[i]
        for _ in 0..<20 {
          z = z - (tanh_d(z + 0.1) - result[i]) / (1.0 - tanh_d(z + 0.1) * tanh_d(z + 0.1))
        }
        result[i] = z
      }
    }
    result
  }
}

/// Flow 对数概率 / Flow log probability.
pub fn flow_log_prob(model : FlowModel, x : Array[Double]) -> Double {
  let n = x.length()
  if n == 0 {
    0.0
  } else {
    let y = flow_forward(model, x)
    let mut log_det = 0.0
    for i in 0..<n {
      log_det = log_det + log(1.0 - tanh_d(y[i] + 0.1) * tanh_d(y[i] + 0.1) + 0.000000001)
    }
    let mut lp = 0.0
    for i in 0..<n {
      lp = lp + -0.5 * y[i] * y[i] - 0.5 * log(6.283185307179586)
    }
    lp + log_det
  }
}

/// 构造 Autoregressive 模型 / Build autoregressive model.
pub fn make_autoregressive(vocab_size : Int, seq_len : Int, hidden_dim : Int, seed : Int) -> AutoregressiveModel {
  { vocab_size, seq_len, hidden_dim, seed }
}

/// Autoregressive 采样 / Autoregressive sample.
pub fn autoregressive_sample(model : AutoregressiveModel, prompt : Array[Int], step : Int) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<prompt.length() {
    result.push(prompt[i])
  }
  while result.length() < model.seq_len {
    let mut sum = 0.0
    for i in 0..<result.length() {
      sum = sum + result[i].to_double()
    }
    let noise = rand_double(model.seed + step * 7 + result.length())
    let v = ((sigmoid(sum / (result.length() + 1).to_double()) + noise) * 0.5 * model.vocab_size.to_double()).to_int()
    let clamped = if v < 0 { 0 } else if v >= model.vocab_size { model.vocab_size - 1 } else { v }
    result.push(clamped)
  }
  result
}

/// Autoregressive 损失 / Autoregressive loss.
pub fn autoregressive_loss(model : AutoregressiveModel, seq : Array[Int], target : Array[Int]) -> Double {
  let n = seq.length()
  if n == 0 || n != target.length() {
    0.0
  } else {
    let mut loss = 0.0
    for i in 0..<n {
      let p = sigmoid(seq[i].to_double() / model.vocab_size.to_double())
      let t = target[i].to_double() / model.vocab_size.to_double()
      let eps = 0.000000001
      loss = loss + -(t * log(p + eps) + (1.0 - t) * log(1.0 - p + eps))
    }
    loss / n.to_double()
  }
}

/// 构造 Markov 模型 / Build Markov model.
pub fn make_markov_model(num_states : Int, transition : Array[Array[Double]], initial : Array[Double], seed : Int) -> MarkovModel {
  { num_states, transition, initial, seed }
}

/// Markov 采样 / Markov sample.
pub fn markov_sample(model : MarkovModel, num_steps : Int, step : Int) -> Array[Int] {
  let result : Array[Int] = []
  if model.num_states == 0 {
    return result
  }
  let r0 = rand_double(model.seed + step)
  let mut cum = 0.0
  let mut cur = 0
  for i in 0..<model.num_states {
    if i < model.initial.length() {
      cum = cum + model.initial[i]
      if r0 < cum && cur == 0 && i > 0 {
        cur = i
      }
    }
  }
  result.push(cur)
  for _ in 1..<num_steps {
    let r = rand_double(model.seed + step * 11 + result.length())
    let mut c = 0.0
    let mut next = cur
    for j in 0..<model.num_states {
      if cur < model.transition.length() && j < model.transition[cur].length() {
        c = c + model.transition[cur][j]
        if r < c && next == cur && j > cur {
          next = j
        }
      }
    }
    cur = next
    result.push(cur)
  }
  result
}

/// Markov 概率 / Markov probability.
pub fn markov_prob(model : MarkovModel, from_state : Int, to_state : Int) -> Double {
  if from_state < 0 || from_state >= model.transition.length() {
    0.0
  } else if to_state < 0 || to_state >= model.transition[from_state].length() {
    0.0
  } else {
    model.transition[from_state][to_state]
  }
}

/// 构造 HMM 生成模型 / Build HMM generation model.
pub fn make_hmm_gen(num_states : Int, num_obs : Int, transition : Array[Array[Double]], emission : Array[Array[Double]], initial : Array[Double], seed : Int) -> HMMGenModel {
  { num_states, num_obs, transition, emission, initial, seed }
}

/// HMM 生成 / HMM generate.
pub fn hmm_generate(model : HMMGenModel, num_steps : Int, step : Int) -> (Array[Int], Array[Int]) {
  let states : Array[Int] = []
  let obs : Array[Int] = []
  if model.num_states == 0 || model.num_obs == 0 {
    return (states, obs)
  }
  let r0 = rand_double(model.seed + step)
  let mut cum = 0.0
  let mut cur = 0
  for i in 0..<model.num_states {
    if i < model.initial.length() {
      cum = cum + model.initial[i]
      if r0 < cum && cur == 0 && i > 0 {
        cur = i
      }
    }
  }
  states.push(cur)
  let r1 = rand_double(model.seed + step * 3 + 1)
  let mut c1 = 0.0
  let mut o = 0
  for j in 0..<model.num_obs {
    if cur < model.emission.length() && j < model.emission[cur].length() {
      c1 = c1 + model.emission[cur][j]
      if r1 < c1 && o == 0 && j > 0 {
        o = j
      }
    }
  }
  obs.push(o)
  for t in 1..<num_steps {
    let r = rand_double(model.seed + step * 13 + t)
    let mut c = 0.0
    let mut next = cur
    for j in 0..<model.num_states {
      if cur < model.transition.length() && j < model.transition[cur].length() {
        c = c + model.transition[cur][j]
        if r < c && next == cur && j > cur {
          next = j
        }
      }
    }
    cur = next
    states.push(cur)
    let ro = rand_double(model.seed + step * 17 + t)
    let mut co = 0.0
    let mut oo = 0
    for j in 0..<model.num_obs {
      if cur < model.emission.length() && j < model.emission[cur].length() {
        co = co + model.emission[cur][j]
        if ro < co && oo == 0 && j > 0 {
          oo = j
        }
      }
    }
    obs.push(oo)
  }
  (states, obs)
}

/// HMM Viterbi 生成 / HMM Viterbi generation.
pub fn hmm_viterbi_gen(model : HMMGenModel, obs : Array[Int]) -> Array[Int] {
  let t = obs.length()
  if t == 0 || model.num_states == 0 {
    return []
  }
  let dp : Array[Array[Double]] = Array::make(t, Array::make(model.num_states, 0.0))
  let bp : Array[Array[Int]] = Array::make(t, Array::make(model.num_states, 0))
  for s in 0..<model.num_states {
    let init_p = if s < model.initial.length() { model.initial[s] } else { 0.0 }
    let emit_p = if s < model.emission.length() && obs[0] < model.emission[s].length() { model.emission[s][obs[0]] } else { 0.0 }
    dp[0][s] = log(init_p + 0.000000001) + log(emit_p + 0.000000001)
  }
  for k in 1..<t {
    for s in 0..<model.num_states {
      let mut best = -1000000000.0
      let mut best_prev = 0
      for ps in 0..<model.num_states {
        let trans_p = if ps < model.transition.length() && s < model.transition[ps].length() { model.transition[ps][s] } else { 0.0 }
        let val = dp[k - 1][ps] + log(trans_p + 0.000000001)
        if val > best {
          best = val
          best_prev = ps
        }
      }
      let emit_p = if s < model.emission.length() && obs[k] < model.emission[s].length() { model.emission[s][obs[k]] } else { 0.0 }
      dp[k][s] = best + log(emit_p + 0.000000001)
      bp[k][s] = best_prev
    }
  }
  let result : Array[Int] = Array::make(t, 0)
  let mut best_final = 0
  let mut best_val = -1000000000.0
  for s in 0..<model.num_states {
    if dp[t - 1][s] > best_val {
      best_val = dp[t - 1][s]
      best_final = s
    }
  }
  result[t - 1] = best_final
  let mut k = t - 1
  while k >= 1 {
    result[k - 1] = bp[k][result[k]]
    k = k - 1
  }
  result
}

/// 正态噪声 / Normal noise.
pub fn noise_normal(size : Int, mean : Double, std : Double, seed : Int) -> Array[Double] {
  let result : Array[Double] = Array::make(size, 0.0)
  for i in 0..<size {
    result[i] = mean + std * box_muller(seed + i * 7)
  }
  result
}

/// 均匀噪声 / Uniform noise.
pub fn noise_uniform(size : Int, low : Double, high : Double, seed : Int) -> Array[Double] {
  let result : Array[Double] = Array::make(size, 0.0)
  for i in 0..<size {
    let r = rand_double(seed + i * 11)
    result[i] = low + (high - low) * r
  }
  result
}

/// 伯努利噪声 / Bernoulli noise.
pub fn noise_bernoulli(size : Int, p : Double, seed : Int) -> Array[Double] {
  let result : Array[Double] = Array::make(size, 0.0)
  for i in 0..<size {
    let r = rand_double(seed + i * 13)
    result[i] = if r < p { 1.0 } else { 0.0 }
  }
  result
}

/// 分类采样 / Categorical sample.
pub fn sample_categorical(probs : Array[Double], seed : Int) -> Int {
  let n = probs.length()
  if n == 0 {
    return 0
  }
  let r = rand_double(seed)
  let mut cum = 0.0
  for i in 0..<n {
    cum = cum + probs[i]
    if r < cum {
      return i
    }
  }
  n - 1
}

/// 多项式采样 / Multinomial sample.
pub fn sample_multinomial(probs : Array[Double], num_samples : Int, seed : Int) -> Array[Int] {
  let n = probs.length()
  let result : Array[Int] = Array::make(n, 0)
  for k in 0..<num_samples {
    let idx = sample_categorical(probs, seed + k * 17)
    if idx >= 0 && idx < n {
      result[idx] = result[idx] + 1
    }
  }
  result
}

/// Dirichlet 采样 / Dirichlet sample.
pub fn sample_dirichlet(alphas : Array[Double], seed : Int) -> Array[Double] {
  let n = alphas.length()
  if n == 0 {
    return []
  }
  let result : Array[Double] = Array::make(n, 0.0)
  let mut sum = 0.0
  for i in 0..<n {
    let a = alphas[i]
    let mut g = 0.0
    for _ in 0..<20 {
      g = g + -log(rand_double(seed + i * 23 + g.to_int()))
    }
    g = g / 20.0 * a
    result[i] = g
    sum = sum + g
  }
  if sum > 0.0 {
    for i in 0..<n {
      result[i] = result[i] / sum
    }
  }
  result
}

/// 潜空间插值 / Latent interpolation.
pub fn interpolate_latent(z1 : Array[Double], z2 : Array[Double], alpha : Double) -> Array[Double] {
  let n = z1.length()
  if n == 0 || n != z2.length() {
    return []
  }
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = (1.0 - alpha) * z1[i] + alpha * z2[i]
  }
  result
}

/// 潜空间多步插值 / Latent space multi-step interpolation.
pub fn latent_space_interpolation(z1 : Array[Double], z2 : Array[Double], num_steps : Int) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  if num_steps <= 0 {
    return result
  }
  for k in 0..<num_steps {
    let alpha = k.to_double() / (num_steps - 1).to_double()
    result.push(interpolate_latent(z1, z2, alpha))
  }
  result
}

/// 构造 Generator 网络 / Build generator network.
pub fn make_generator_net(input_dim : Int, output_dim : Int, hidden_dim : Int, seed : Int) -> GeneratorNet {
  let weights : Array[Array[Double]] = Array::make(2, Array::make(hidden_dim, 0.0))
  weights[0] = Array::make(input_dim, 0.0)
  for i in 0..<input_dim {
    weights[0][i] = rand_double(seed + i) * 2.0 - 1.0
  }
  weights[1] = Array::make(hidden_dim, 0.0)
  for i in 0..<hidden_dim {
    weights[1][i] = rand_double(seed + 100 + i) * 2.0 - 1.0
  }
  let bias : Array[Double] = Array::make(hidden_dim, 0.0)
  for i in 0..<hidden_dim {
    bias[i] = rand_double(seed + 200 + i) * 0.1
  }
  { input_dim, output_dim, hidden_dim, weights, bias }
}

/// Generator 前向 / Generator forward.
pub fn generator_forward(net : GeneratorNet, input : Array[Double]) -> Array[Double] {
  let result : Array[Double] = Array::make(net.output_dim, 0.0)
  let hidden : Array[Double] = Array::make(net.hidden_dim, 0.0)
  for i in 0..<net.hidden_dim {
    let mut sum = 0.0
    for j in 0..<net.input_dim {
      if j < input.length() && j < net.weights[0].length() {
        sum = sum + net.weights[0][j] * input[j]
      }
    }
    if i < net.bias.length() {
      sum = sum + net.bias[i]
    }
    hidden[i] = tanh_d(sum)
  }
  for i in 0..<net.output_dim {
    let mut sum = 0.0
    for j in 0..<net.hidden_dim {
      if j < net.weights[1].length() {
        sum = sum + net.weights[1][j] * hidden[j]
      }
    }
    result[i] = sigmoid(sum)
  }
  result
}

/// Generator 损失 / Generator loss.
pub fn generator_loss(fake_disc : Double) -> Double {
  let eps = 0.000000001
  -log(fake_disc + eps)
}

/// 构造 Discriminator 网络 / Build discriminator network.
pub fn make_discriminator_net(input_dim : Int, hidden_dim : Int, seed : Int) -> DiscriminatorNet {
  let weights : Array[Array[Double]] = Array::make(2, Array::make(hidden_dim, 0.0))
  weights[0] = Array::make(input_dim, 0.0)
  for i in 0..<input_dim {
    weights[0][i] = rand_double(seed + i * 3) * 2.0 - 1.0
  }
  weights[1] = Array::make(hidden_dim, 0.0)
  for i in 0..<hidden_dim {
    weights[1][i] = rand_double(seed + 50 + i * 3) * 2.0 - 1.0
  }
  let bias : Array[Double] = Array::make(hidden_dim, 0.0)
  for i in 0..<hidden_dim {
    bias[i] = rand_double(seed + 150 + i * 3) * 0.1
  }
  { input_dim, hidden_dim, weights, bias }
}

/// Discriminator 前向 / Discriminator forward.
pub fn discriminator_forward(net : DiscriminatorNet, input : Array[Double]) -> Double {
  let hidden : Array[Double] = Array::make(net.hidden_dim, 0.0)
  for i in 0..<net.hidden_dim {
    let mut sum = 0.0
    for j in 0..<net.input_dim {
      if j < input.length() && j < net.weights[0].length() {
        sum = sum + net.weights[0][j] * input[j]
      }
    }
    if i < net.bias.length() {
      sum = sum + net.bias[i]
    }
    hidden[i] = tanh_d(sum)
  }
  let mut sum = 0.0
  for j in 0..<net.hidden_dim {
    if j < net.weights[1].length() {
      sum = sum + net.weights[1][j] * hidden[j]
    }
  }
  sigmoid(sum)
}

/// Discriminator 损失 / Discriminator loss.
pub fn discriminator_loss(d_real : Double, d_fake : Double) -> Double {
  let eps = 0.000000001
  -(log(d_real + eps) + log(1.0 - d_fake + eps))
}

/// 模式崩溃检查 / Mode collapse check.
pub fn mode_collapse_check(samples : Array[Array[Double]], threshold : Double) -> Bool {
  let n = samples.length()
  if n < 2 {
    return false
  }
  let dim = samples[0].length()
  let mut total_var = 0.0
  for d in 0..<dim {
    let mut mean = 0.0
    for i in 0..<n {
      if d < samples[i].length() {
        mean = mean + samples[i][d]
      }
    }
    mean = mean / n.to_double()
    let mut variance = 0.0
    for i in 0..<n {
      if d < samples[i].length() {
        let diff = samples[i][d] - mean
        variance = variance + diff * diff
      }
    }
    variance = variance / n.to_double()
    total_var = total_var + variance
  }
  total_var < threshold
}

/// Inception Score 简化版 / Simplified Inception score.
pub fn inception_score_simple(samples : Array[Array[Double]], num_classes : Int) -> Double {
  let n = samples.length()
  if n == 0 || num_classes == 0 {
    return 0.0
  }
  let p_mean : Array[Double] = Array::make(num_classes, 0.0)
  let mut kl_sum = 0.0
  for i in 0..<n {
    let p : Array[Double] = Array::make(num_classes, 0.0)
    let dim = samples[i].length()
    for c in 0..<num_classes {
      if c < dim {
        p[c] = sigmoid(samples[i][c])
      }
    }
    let mut s = 0.0
    for c in 0..<num_classes {
      s = s + p[c]
    }
    if s > 0.0 {
      for c in 0..<num_classes {
        p[c] = p[c] / s
        p_mean[c] = p_mean[c] + p[c]
      }
    }
    for c in 0..<num_classes {
      let eps = 0.000000001
      kl_sum = kl_sum + p[c] * (log(p[c] + eps) - log(p_mean[c] / n.to_double() + eps))
    }
  }
  exp(kl_sum / n.to_double())
}

/// FID Score 简化版 / Simplified FID score.
pub fn fid_score_simple(real : Array[Array[Double]], fake : Array[Array[Double]]) -> Double {
  let nr = real.length()
  let nf = fake.length()
  if nr == 0 || nf == 0 {
    return 0.0
  }
  let dim = real[0].length()
  let mu_r : Array[Double] = Array::make(dim, 0.0)
  let mu_f : Array[Double] = Array::make(dim, 0.0)
  for i in 0..<nr {
    for d in 0..<dim {
      if d < real[i].length() {
        mu_r[d] = mu_r[d] + real[i][d]
      }
    }
  }
  for i in 0..<nf {
    for d in 0..<dim {
      if d < fake[i].length() {
        mu_f[d] = mu_f[d] + fake[i][d]
      }
    }
  }
  let mut diff_sq = 0.0
  for d in 0..<dim {
    mu_r[d] = mu_r[d] / nr.to_double()
    mu_f[d] = mu_f[d] / nf.to_double()
    diff_sq = diff_sq + (mu_r[d] - mu_f[d]) * (mu_r[d] - mu_f[d])
  }
  let mut trace_r = 0.0
  let mut trace_f = 0.0
  for i in 0..<nr {
    for d in 0..<dim {
      if d < real[i].length() {
        let diff = real[i][d] - mu_r[d]
        trace_r = trace_r + diff * diff
      }
    }
  }
  for i in 0..<nf {
    for d in 0..<dim {
      if d < fake[i].length() {
        let diff = fake[i][d] - mu_f[d]
        trace_f = trace_f + diff * diff
      }
    }
  }
  trace_r = trace_r / nr.to_double()
  trace_f = trace_f / nf.to_double()
  diff_sq + trace_r + trace_f
}

/// 生成文本 / Generate text.
pub fn generate_text(model : TextGANModel, prompt : Array[Int], step : Int) -> Array[Int] {
  let noise = noise_normal(model.seq_len, 0.0, 1.0, model.seed + step)
  let result : Array[Int] = []
  for i in 0..<prompt.length() {
    result.push(prompt[i])
  }
  while result.length() < model.seq_len {
    let idx = result.length() - prompt.length()
    if idx >= 0 && idx < noise.length() {
      let v = ((sigmoid(noise[idx]) + 0.5) * model.vocab_size.to_double()).to_int()
      let clamped = if v < 0 { 0 } else if v >= model.vocab_size { model.vocab_size - 1 } else { v }
      result.push(clamped)
    } else {
      result.push(0)
    }
  }
  result
}

/// 简化图像生成 / Simplified image generation.
pub fn generate_image_simple(width : Int, height : Int, seed : Int) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = Array::make(height, Array::make(width, 0.0))
  for i in 0..<height {
    for j in 0..<width {
      let r = rand_double(seed + i * width + j)
      result[i][j] = r
    }
  }
  result
}

/// 生成序列 / Generate sequence.
pub fn generate_sequence(model : AutoregressiveModel, prompt : Array[Int], step : Int) -> Array[Int] {
  autoregressive_sample(model, prompt, step)
}

/// 条件生成 / Conditional generation.
pub fn conditional_generate(model : GANModel, condition : Array[Double], noise : Array[Double]) -> Array[Double] {
  let n = model.gen_dim
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let mut sum = 0.0
    for j in 0..<model.noise_dim {
      if j < noise.length() {
        sum = sum + noise[j]
      }
    }
    for k in 0..<condition.length() {
      sum = sum + condition[k] * 0.1
    }
    result[i] = tanh_d(sum / (model.noise_dim + condition.length()).to_double())
  }
  result
}

/// 受控生成 / Controlled generation.
pub fn controlled_generate(model : GANModel, noise : Array[Double], control : Array[Double]) -> Array[Double] {
  let base = gan_generate(model, noise)
  let n = base.length()
  let result : Array[Double] = Array::make(n, 0.0)
  for i in 0..<n {
    let c = if i < control.length() { control[i] } else { 0.0 }
    result[i] = tanh_d(base[i] + c)
  }
  result
}

/// 模块标识 / Module identifier.
pub fn generate_id() -> String {
  "learncore/generative"
}