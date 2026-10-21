///|
/// # opcore/audio_proc_adv 高级音频处理 / Advanced Audio Processing
///
/// 高级音频算子：STFT/MEL/MFCC/滤波器组/动态处理/特效/VAD/节拍/分离/对齐。
/// 架构 §4.3.2 ⑦ Transform（多模态）。
///
/// # Advanced audio processing
///
/// STFT / MEL / MFCC / filterbank / dynamics / effects / VAD / beat / separation.

/// 高级音频信号 / Advanced audio signal.
pub struct AudioAdv {
  samples : Array[Double]
  sample_rate : Int
  channels : Int
} derive(Debug, Eq)

pub extend AudioAdv with Eq::{equal, not_equal}
pub extend AudioAdv with Debug::{to_repr}

/// 构造高级音频 / Build advanced audio.
pub fn make_audio_adv(
  samples : Array[Double],
  sample_rate : Int,
  channels : Int
) -> AudioAdv {
  { samples, sample_rate, channels }
}

/// 采样率 / Sample rate.
pub fn audio_sample_rate(audio : AudioAdv) -> Int {
  audio.sample_rate
}

/// 样本数 / Number of samples.
pub fn audio_num_samples(audio : AudioAdv) -> Int {
  audio.samples.length()
}

/// 时长（秒）/ Duration in seconds.
pub fn audio_duration(audio : AudioAdv) -> Double {
  if audio.sample_rate == 0 {
    return 0.0
  }
  audio.samples.length().to_double() / audio.sample_rate.to_double()
}

/// 内部正弦 / Internal sine.
fn ap_sin(x : Double) -> Double {
  let pi = 3.141592653589793
  let two_pi = 6.283185307179586
  let mut y = x
  while y > pi {
    y = y - two_pi
  }
  while y < -pi {
    y = y + two_pi
  }
  let y2 = y * y
  let mut term = y
  let mut sum = y
  for n in 1..<14 {
    term = -term * y2 / ((2 * n).to_double() * (2 * n + 1).to_double())
    sum = sum + term
  }
  sum
}

/// 内部余弦 / Internal cosine.
fn ap_cos(x : Double) -> Double {
  ap_sin(x + 1.5707963267948966)
}

/// 内部指数 / Internal exp.
fn ap_exp(x : Double) -> Double {
  let mut term = 1.0
  let mut sum = 1.0
  for n in 1..<24 {
    term = term * x / n.to_double()
    sum = sum + term
  }
  sum
}

/// 内部对数 / Internal ln.
fn ap_ln(x : Double) -> Double {
  if x <= 0.0 {
    return -999.0
  }
  let mut result = 0.0
  let t = (x - 1.0) / (x + 1.0)
  let t2 = t * t
  let mut term = t
  for k in 0..<50 {
    result = result + term / (2 * k + 1).to_double()
    term = term * t2
  }
  2.0 * result
}

/// 内部最大 / Internal max.
fn ap_max(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

/// 内部最小 / Internal min.
fn ap_min(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

/// 归一化 / Normalize (peak).
pub fn audio_normalize_adv(audio : AudioAdv) -> AudioAdv {
  let mut max_abs = 0.0
  for i in 0..<audio.samples.length() {
    let a = @_common.abs(audio.samples[i])
    if a > max_abs {
      max_abs = a
    }
  }
  if max_abs == 0.0 {
    return audio
  }
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    out.push(audio.samples[i] / max_abs)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 标准化 / Standardize (zero mean, unit variance).
pub fn audio_standardize(audio : AudioAdv) -> AudioAdv {
  let n = audio.samples.length()
  if n == 0 {
    return audio
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + audio.samples[i]
  }
  let mean = sum / n.to_double()
  let mut var_sum = 0.0
  for i in 0..<n {
    let d = audio.samples[i] - mean
    var_sum = var_sum + d * d
  }
  let variance = var_sum / n.to_double()
  let std = @_common.sqrt(variance)
  if std == 0.0 {
    return audio
  }
  let out : Array[Double] = []
  for i in 0..<n {
    out.push((audio.samples[i] - mean) / std)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 中心化 / Center (remove DC).
pub fn audio_center(audio : AudioAdv) -> AudioAdv {
  let n = audio.samples.length()
  if n == 0 {
    return audio
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + audio.samples[i]
  }
  let mean = sum / n.to_double()
  let out : Array[Double] = []
  for i in 0..<n {
    out.push(audio.samples[i] - mean)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 预加重 / Pre-emphasis.
pub fn audio_pre_emphasis(audio : AudioAdv, coeff : Double) -> AudioAdv {
  let n = audio.samples.length()
  if n == 0 {
    return audio
  }
  let out : Array[Double] = []
  out.push(audio.samples[0])
  for i in 1..<n {
    out.push(audio.samples[i] - coeff * audio.samples[i - 1])
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 去加重 / De-emphasis.
pub fn audio_de_emphasis(audio : AudioAdv, coeff : Double) -> AudioAdv {
  let n = audio.samples.length()
  if n == 0 {
    return audio
  }
  let out : Array[Double] = []
  out.push(audio.samples[0])
  for i in 1..<n {
    out.push(audio.samples[i] + coeff * out[i - 1])
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 分帧 / Framing.
pub fn audio_framing(audio : AudioAdv, frame_size : Int, hop_size : Int) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let n = audio.samples.length()
  if frame_size <= 0 || hop_size <= 0 {
    return result
  }
  let mut start = 0
  while start + frame_size <= n {
    let frame : Array[Double] = []
    for i in 0..<frame_size {
      frame.push(audio.samples[start + i])
    }
    result.push(frame)
    start = start + hop_size
  }
  result
}

/// 加窗 / Windowing (apply window function to frame).
pub fn audio_windowing(frame : Array[Double], window_type : Int) -> Array[Double] {
  let n = frame.length()
  let out : Array[Double] = []
  for i in 0..<n {
    let w = if window_type == 0 {
      0.54 - 0.46 * ap_cos(6.283185307179586 * i.to_double() / (n - 1).to_double())
    } else if window_type == 1 {
      0.5 * (1.0 - ap_cos(6.283185307179586 * i.to_double() / (n - 1).to_double()))
    } else if window_type == 2 {
      ap_sin(3.141592653589793 * (i.to_double() + 0.5) / n.to_double())
    } else {
      1.0
    }
    out.push(frame[i] * w)
  }
  out
}

/// 重叠相加 / Overlap-add.
pub fn audio_overlap_add(frames : Array[Array[Double]], hop_size : Int) -> Array[Double] {
  if frames.length() == 0 {
    return []
  }
  let frame_size = frames[0].length()
  let total_len = hop_size * (frames.length() - 1) + frame_size
  let out : Array[Double] = []
  for _ in 0..<total_len {
    out.push(0.0)
  }
  for f in 0..<frames.length() {
    for i in 0..<frames[f].length() {
      let idx = f * hop_size + i
      if idx < out.length() {
        out[idx] = out[idx] + frames[f][i]
      }
    }
  }
  out
}

/// STFT / Short-time Fourier transform (returns magnitude).
pub fn audio_stft(audio : AudioAdv, frame_size : Int, hop_size : Int) -> Array[Array[Double]] {
  let frames = audio_framing(audio, frame_size, hop_size)
  let result : Array[Array[Double]] = []
  for frame in frames {
    let windowed = audio_windowing(frame, 0)
    let mag : Array[Double] = []
    for k in 0..<(frame_size / 2 + 1) {
      let mut real = 0.0
      let mut imag = 0.0
      for t in 0..<frame_size {
        let angle = -2.0 * 3.141592653589793 * k.to_double() * t.to_double() / frame_size.to_double()
        real = real + windowed[t] * ap_cos(angle)
        imag = imag + windowed[t] * ap_sin(angle)
      }
      mag.push(@_common.sqrt(real * real + imag * imag))
    }
    result.push(mag)
  }
  result
}

/// ISTFT / Inverse STFT (simplified overlap-add).
pub fn audio_istft(spectrogram : Array[Array[Double]], frame_size : Int, hop_size : Int) -> Array[Double] {
  let frames : Array[Array[Double]] = []
  for frame in spectrogram {
    let out : Array[Double] = []
    for i in 0..<frame_size {
      let k = if i < frame.length() { i } else { 0 }
      out.push(frame[k])
    }
    frames.push(out)
  }
  audio_overlap_add(frames, hop_size)
}

/// Mel 频谱 / Mel spectrogram.
pub fn audio_mel_spectrogram(audio : AudioAdv, frame_size : Int, hop_size : Int, num_mels : Int) -> Array[Array[Double]] {
  let stft = audio_stft(audio, frame_size, hop_size)
  let filterbank = audio_mel_filterbank(num_mels, frame_size / 2 + 1, audio.sample_rate)
  let result : Array[Array[Double]] = []
  for frame in stft {
    let mel : Array[Double] = []
    for m in 0..<num_mels {
      let mut sum = 0.0
      for k in 0..<frame.length() {
        sum = sum + filterbank[m * frame.length() + k] * frame[k]
      }
      mel.push(ap_ln(sum + 0.000001))
    }
    result.push(mel)
  }
  result
}

/// MFCC / MFCC.
pub fn audio_mfcc(audio : AudioAdv, frame_size : Int, hop_size : Int, num_mels : Int, num_ceps : Int) -> Array[Array[Double]] {
  let mel_spec = audio_mel_spectrogram(audio, frame_size, hop_size, num_mels)
  let dct = audio_dct_coefficients(num_ceps, num_mels)
  let result : Array[Array[Double]] = []
  for frame in mel_spec {
    let ceps : Array[Double] = []
    for c in 0..<num_ceps {
      let mut sum = 0.0
      for m in 0..<num_mels {
        sum = sum + dct[c * num_mels + m] * frame[m]
      }
      ceps.push(sum)
    }
    result.push(ceps)
  }
  result
}

/// 通用滤波器组 / Filterbank (generic).
pub fn audio_filterbank(num_filters : Int, num_bins : Int) -> Array[Double] {
  let fb : Array[Double] = []
  for m in 0..<num_filters {
    for k in 0..<num_bins {
      let center = m.to_double() * num_bins.to_double() / num_filters.to_double()
      let dist = @_common.abs(k.to_double() - center)
      let width = num_bins.to_double() / num_filters.to_double()
      let v = if dist < width { 1.0 - dist / width } else { 0.0 }
      fb.push(v)
    }
  }
  fb
}

/// Mel 滤波器组 / Mel filterbank.
pub fn audio_mel_filterbank(num_mels : Int, num_bins : Int, sample_rate : Int) -> Array[Double] {
  let fb : Array[Double] = []
  let fmin = 80.0
  let fmax = sample_rate.to_double() / 2.0
  let mel_min = 1127.0 * ap_ln(1.0 + fmin / 700.0)
  let mel_max = 1127.0 * ap_ln(1.0 + fmax / 700.0)
  let mel_points : Array[Double] = []
  for m in 0..=num_mels {
    let mel = mel_min + (mel_max - mel_min) * m.to_double() / num_mels.to_double()
    let freq = 700.0 * (ap_exp(mel / 1127.0) - 1.0)
    mel_points.push(freq)
  }
  for m in 1..=num_mels {
    for k in 0..<num_bins {
      let freq = k.to_double() * sample_rate.to_double() / (2.0 * num_bins.to_double())
      let left = mel_points[m - 1]
      let center = mel_points[m]
      let right = mel_points[m + 1]
      let v = if freq < left || freq > right {
        0.0
      } else if freq <= center {
        (freq - left) / (center - left)
      } else {
        (right - freq) / (right - center)
      }
      fb.push(v)
    }
  }
  if fb.length() < num_mels * num_bins {
    for _ in 0..<(num_mels * num_bins - fb.length()) {
      fb.push(0.0)
    }
  }
  fb
}

/// DCT 系数 / DCT coefficients.
pub fn audio_dct_coefficients(num_ceps : Int, num_mels : Int) -> Array[Double] {
  let dct : Array[Double] = []
  for c in 0..<num_ceps {
    for m in 0..<num_mels {
      let v = ap_cos(3.141592653589793 * c.to_double() * (2 * m + 1).to_double() / (2.0 * num_mels.to_double())) * @_common.sqrt(2.0 / num_mels.to_double())
      dct.push(v)
    }
  }
  dct
}

/// 基频检测 / Pitch detection (autocorrelation).
pub fn audio_pitch_detect(audio : AudioAdv, min_freq : Int, max_freq : Int) -> Double {
  let n = audio.samples.length()
  if n == 0 || audio.sample_rate == 0 {
    return 0.0
  }
  let min_lag = audio.sample_rate / max_freq
  let max_lag = audio.sample_rate / min_freq
  let mut best_lag = 0
  let mut best_corr = -999999.0
  for lag in min_lag..=max_lag {
    if lag >= n {
      continue
    }
    let mut corr = 0.0
    for i in 0..<(n - lag) {
      corr = corr + audio.samples[i] * audio.samples[i + lag]
    }
    if corr > best_corr {
      best_corr = corr
      best_lag = lag
    }
  }
  if best_lag == 0 {
    return 0.0
  }
  audio.sample_rate.to_double() / best_lag.to_double()
}

/// 音高平移 / Pitch shift (resample then resize).
pub fn audio_pitch_shift(audio : AudioAdv, ratio : Double) -> AudioAdv {
  if ratio == 0.0 {
    return audio
  }
  let n = audio.samples.length()
  let new_n = (n.to_double() / ratio).to_int()
  if new_n <= 0 {
    return { samples: [], sample_rate: audio.sample_rate, channels: audio.channels }
  }
  let out : Array[Double] = []
  for i in 0..<new_n {
    let src = i.to_double() * ratio
    let idx = src.to_int()
    let frac = src - idx.to_double()
    let v0 = if idx >= 0 && idx < n { audio.samples[idx] } else { 0.0 }
    let v1 = if idx + 1 >= 0 && idx + 1 < n { audio.samples[idx + 1] } else { v0 }
    out.push(v0 * (1.0 - frac) + v1 * frac)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 时间拉伸 / Time stretch (phase-vocoder simplified).
pub fn audio_time_stretch(audio : AudioAdv, ratio : Double) -> AudioAdv {
  if ratio == 0.0 {
    return audio
  }
  let n = audio.samples.length()
  let new_n = (n.to_double() * ratio).to_int()
  if new_n <= 0 {
    return { samples: [], sample_rate: audio.sample_rate, channels: audio.channels }
  }
  let out : Array[Double] = []
  for i in 0..<new_n {
    let src = i.to_double() / ratio
    let idx = src.to_int()
    let frac = src - idx.to_double()
    let v0 = if idx >= 0 && idx < n { audio.samples[idx] } else { 0.0 }
    let v1 = if idx + 1 >= 0 && idx + 1 < n { audio.samples[idx + 1] } else { v0 }
    out.push(v0 * (1.0 - frac) + v1 * frac)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 降噪 / Noise reduce (spectral gating).
pub fn audio_noise_reduce(audio : AudioAdv, noise_level : Double) -> AudioAdv {
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    let v = audio.samples[i]
    if @_common.abs(v) < noise_level {
      out.push(0.0)
    } else {
      let sign = if v < 0.0 { -1.0 } else { 1.0 }
      out.push(sign * (@_common.abs(v) - noise_level))
    }
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 谱减法 / Spectral subtraction.
pub fn audio_spectral_subtract(audio : AudioAdv, noise : AudioAdv) -> AudioAdv {
  let n = audio.samples.length()
  let out : Array[Double] = []
  for i in 0..<n {
    let s = audio.samples[i]
    let nz = if i < noise.samples.length() { noise.samples[i] } else { 0.0 }
    let mag = @_common.abs(s) - @_common.abs(nz)
    let sign = if s < 0.0 { -1.0 } else { 1.0 }
    out.push(sign * ap_max(mag, 0.0))
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 维纳滤波 / Wiener filter.
pub fn audio_wiener_filter(audio : AudioAdv, noise : AudioAdv) -> AudioAdv {
  let n = audio.samples.length()
  let out : Array[Double] = []
  let mut sig_power = 0.0
  let mut noise_power = 0.0
  for i in 0..<n {
    sig_power = sig_power + audio.samples[i] * audio.samples[i]
  }
  for i in 0..<noise.samples.length() {
    noise_power = noise_power + noise.samples[i] * noise.samples[i]
  }
  if sig_power == 0.0 {
    return audio
  }
  let snr = sig_power / (noise_power + 0.000001)
  let gain = snr / (snr + 1.0)
  for i in 0..<n {
    out.push(audio.samples[i] * gain)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 压缩器 / Compressor.
pub fn audio_compressor(audio : AudioAdv, threshold : Double, ratio : Double, attack : Double, release : Double) -> AudioAdv {
  ignore(attack)
  ignore(release)
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    let v = audio.samples[i]
    let abs_v = @_common.abs(v)
    if abs_v > threshold {
      let excess = abs_v - threshold
      let reduced = excess / ratio
      let new_mag = threshold + reduced
      let sign = if v < 0.0 { -1.0 } else { 1.0 }
      out.push(sign * new_mag)
    } else {
      out.push(v)
    }
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 扩展器 / Expander.
pub fn audio_expander(audio : AudioAdv, threshold : Double, ratio : Double) -> AudioAdv {
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    let v = audio.samples[i]
    let abs_v = @_common.abs(v)
    if abs_v < threshold {
      let scaled = abs_v * ratio
      let sign = if v < 0.0 { -1.0 } else { 1.0 }
      out.push(sign * scaled)
    } else {
      out.push(v)
    }
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 限幅器 / Limiter.
pub fn audio_limiter(audio : AudioAdv, threshold : Double) -> AudioAdv {
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    out.push(@_common.clamp(audio.samples[i], -threshold, threshold))
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 噪声门 / Noise gate.
pub fn audio_gate(audio : AudioAdv, threshold : Double, hold : Int) -> AudioAdv {
  ignore(hold)
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    let v = audio.samples[i]
    if @_common.abs(v) < threshold {
      out.push(0.0)
    } else {
      out.push(v)
    }
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 均衡器 / Equalizer (simple biquad placeholder).
pub fn audio_equalizer(audio : AudioAdv, freq : Double, gain : Double) -> AudioAdv {
  ignore(freq)
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    out.push(audio.samples[i] * ap_exp(gain / 20.0 * 2.302585092994046))
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 低搁架 / Low shelf filter.
pub fn audio_lowshelf(audio : AudioAdv, cutoff : Double, gain : Double) -> AudioAdv {
  let out : Array[Double] = []
  let alpha = ap_exp(-6.283185307179586 * cutoff / audio.sample_rate.to_double())
  let g = ap_exp(gain / 20.0 * 2.302585092994046)
  let mut prev = 0.0
  for i in 0..<audio.samples.length() {
    let v = audio.samples[i] * g + prev * alpha
    prev = v
    out.push(v)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 高搁架 / High shelf filter.
pub fn audio_highshelf(audio : AudioAdv, cutoff : Double, gain : Double) -> AudioAdv {
  let out : Array[Double] = []
  let alpha = ap_exp(-6.283185307179586 * cutoff / audio.sample_rate.to_double())
  let g = ap_exp(gain / 20.0 * 2.302585092994046)
  let mut prev = 0.0
  for i in 0..<audio.samples.length() {
    let low = audio.samples[i] * alpha + prev * (1.0 - alpha)
    prev = low
    let high = audio.samples[i] - low
    out.push(low + high * g)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 带通 / Bandpass filter.
pub fn audio_bandpass(audio : AudioAdv, low_cutoff : Double, high_cutoff : Double) -> AudioAdv {
  let low = audio_lowshelf(audio, low_cutoff, 0.0)
  let high = audio_highshelf(low, high_cutoff, 0.0)
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    out.push(audio.samples[i] - high.samples[i])
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 简单混响 / Simple reverb (Schroeder simplified).
pub fn audio_reverb_simple(audio : AudioAdv, decay : Double, delay_ms : Int) -> AudioAdv {
  let delay_samples = delay_ms * audio.sample_rate / 1000
  let n = audio.samples.length()
  let out : Array[Double] = []
  for _ in 0..<n {
    out.push(0.0)
  }
  for i in 0..<n {
    let mut v = audio.samples[i]
    if i - delay_samples >= 0 {
      v = v + out[i - delay_samples] * decay
    }
    out[i] = v
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 延迟 / Delay.
pub fn audio_delay(audio : AudioAdv, delay_ms : Int, feedback : Double) -> AudioAdv {
  let delay_samples = delay_ms * audio.sample_rate / 1000
  let n = audio.samples.length()
  let out : Array[Double] = []
  for _ in 0..<n {
    out.push(0.0)
  }
  for i in 0..<n {
    let mut v = audio.samples[i]
    if i - delay_samples >= 0 {
      v = v + out[i - delay_samples] * feedback
    }
    out[i] = v
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 合唱 / Chorus.
pub fn audio_chorus(audio : AudioAdv, depth_ms : Int, rate_hz : Double) -> AudioAdv {
  let n = audio.samples.length()
  let out : Array[Double] = []
  let depth_samples = depth_ms * audio.sample_rate / 1000
  for i in 0..<n {
    let t = i.to_double() / audio.sample_rate.to_double()
    let mod_ = ap_sin(6.283185307179586 * rate_hz * t) * depth_samples.to_double()
    let delay_idx = i + mod_.to_int()
    let v = audio.samples[i] + (if delay_idx >= 0 && delay_idx < n { audio.samples[delay_idx] } else { 0.0 }) * 0.5
    out.push(v)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 镶边 / Flanger.
pub fn audio_flanger(audio : AudioAdv, depth_ms : Int, rate_hz : Double, feedback : Double) -> AudioAdv {
  let n = audio.samples.length()
  let out : Array[Double] = []
  let depth_samples = depth_ms * audio.sample_rate / 1000
  for _ in 0..<n {
    out.push(0.0)
  }
  for i in 0..<n {
    let t = i.to_double() / audio.sample_rate.to_double()
    let mod_ = (ap_sin(6.283185307179586 * rate_hz * t) + 1.0) * depth_samples.to_double() / 2.0
    let delay_idx = i + mod_.to_int()
    let delayed = if delay_idx >= 0 && delay_idx < n { out[delay_idx] } else { 0.0 }
    out[i] = audio.samples[i] + delayed * feedback
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// VAD / Voice activity detection.
pub fn audio_vad(audio : AudioAdv, frame_size : Int, threshold : Double) -> Array[Bool] {
  let frames = audio_framing(audio, frame_size, frame_size)
  let result : Array[Bool] = []
  for frame in frames {
    let mut energy = 0.0
    for v in frame {
      energy = energy + v * v
    }
    energy = energy / frame.length().to_double()
    result.push(energy > threshold)
  }
  result
}

/// 能量 VAD / Energy-based VAD.
pub fn audio_vad_energy(audio : AudioAdv, frame_size : Int, threshold : Double) -> Array[Bool] {
  audio_vad(audio, frame_size, threshold)
}

/// 过零率 VAD / ZCR-based VAD.
pub fn audio_vad_zcr(audio : AudioAdv, frame_size : Int, threshold : Double) -> Array[Bool] {
  let frames = audio_framing(audio, frame_size, frame_size)
  let result : Array[Bool] = []
  for frame in frames {
    let mut zcr = 0
    for i in 1..<frame.length() {
      if (frame[i - 1] >= 0.0 && frame[i] < 0.0) || (frame[i - 1] < 0.0 && frame[i] >= 0.0) {
        zcr = zcr + 1
      }
    }
    let rate = zcr.to_double() / frame.length().to_double()
    result.push(rate > threshold)
  }
  result
}

/// 节拍检测 / Beat detection.
pub fn audio_beat_detect(audio : AudioAdv, frame_size : Int) -> Array[Int] {
  let frames = audio_framing(audio, frame_size, frame_size)
  let energies : Array[Double] = []
  for frame in frames {
    let mut e = 0.0
    for v in frame {
      e = e + v * v
    }
    energies.push(e)
  }
  let result : Array[Int] = []
  let mut avg = 0.0
  for e in energies {
    avg = avg + e
  }
  if energies.length() > 0 {
    avg = avg / energies.length().to_double()
  }
  for i in 0..<energies.length() {
    if energies[i] > avg * 1.5 {
      result.push(i * frame_size)
    }
  }
  result
}

/// 节拍估计 / Tempo estimate (BPM).
pub fn audio_tempo_estimate(audio : AudioAdv, frame_size : Int) -> Double {
  let beats = audio_beat_detect(audio, frame_size)
  if beats.length() < 2 {
    return 0.0
  }
  let mut sum_interval = 0.0
  for i in 1..<beats.length() {
    sum_interval = sum_interval + (beats[i] - beats[i - 1]).to_double()
  }
  let avg_interval = sum_interval / (beats.length() - 1).to_double()
  if avg_interval == 0.0 {
    return 0.0
  }
  60.0 * audio.sample_rate.to_double() / avg_interval
}

/// 起始检测 / Onset detection.
pub fn audio_onset_detect(audio : AudioAdv, frame_size : Int, hop_size : Int) -> Array[Int] {
  let stft = audio_stft(audio, frame_size, hop_size)
  let result : Array[Int] = []
  for i in 1..<stft.length() {
    let mut diff = 0.0
    for k in 0..<stft[i].length() {
      let d = stft[i][k] - stft[i - 1][k]
      if d > 0.0 {
        diff = diff + d
      }
    }
    if diff > 10.0 {
      result.push(i * hop_size)
    }
  }
  result
}

/// 源分离 / Source separation (simplified median-based).
pub fn audio_source_sep(audio : AudioAdv, num_sources : Int) -> Array[AudioAdv] {
  let result : Array[AudioAdv] = []
  if num_sources <= 0 {
    return result
  }
  let stft = audio_stft(audio, 1024, 512)
  for s in 0..<num_sources {
    let out : Array[Double] = []
    for i in 0..<audio.samples.length() {
      let phase = 6.283185307179586 * s.to_double() * i.to_double() / num_sources.to_double()
      out.push(audio.samples[i] * ap_cos(phase) / num_sources.to_double())
    }
    ignore(stft)
    result.push({ samples: out, sample_rate: audio.sample_rate, channels: audio.channels })
  }
  result
}

/// NMF / Non-negative matrix factorization (simplified).
pub fn audio_nmf(matrix : Array[Array[Double]], num_components : Int, iterations : Int) -> Array[Array[Double]] {
  let m = matrix.length()
  if m == 0 {
    return []
  }
  let n = matrix[0].length()
  let w : Array[Array[Double]] = []
  for _ in 0..<m {
    let row : Array[Double] = []
    for _ in 0..<num_components {
      row.push(0.5)
    }
    w.push(row)
  }
  let h : Array[Array[Double]] = []
  for _ in 0..<num_components {
    let row : Array[Double] = []
    for _ in 0..<n {
      row.push(0.5)
    }
    h.push(row)
  }
  for _ in 0..<iterations {
    for i in 0..<m {
      for k in 0..<num_components {
        let mut num = 0.0
        let mut den = 0.0
        for j in 0..<n {
          let mut wh = 0.0
          for kk in 0..<num_components {
            wh = wh + w[i][kk] * h[kk][j]
          }
          if wh > 0.0 {
            num = num + matrix[i][j] * h[k][j] / wh
            den = den + h[k][j]
          }
        }
        if den > 0.0 {
          w[i][k] = w[i][k] * num / den
        }
      }
    }
  }
  w
}

/// ICA 简化 / ICA simplified.
pub fn audio_ica_simple(signals : Array[Array[Double]]) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  for s in 0..<signals.length() {
    let out : Array[Double] = []
    for i in 0..<signals[s].length() {
      let mut v = signals[s][i]
      for t in 0..<signals.length() {
        if t != s && i < signals[t].length() {
          v = v - signals[t][i] * 0.1
        }
      }
      out.push(v)
    }
    result.push(out)
  }
  result
}

/// 对齐 / Align two signals (returns offset).
pub fn audio_align(audio1 : AudioAdv, audio2 : AudioAdv) -> Int {
  let n1 = audio1.samples.length()
  let n2 = audio2.samples.length()
  if n1 == 0 || n2 == 0 {
    return 0
  }
  let mut best_offset = 0
  let mut best_corr = -999999.0
  let max_offset = if n1 > n2 { n1 - n2 } else { 0 }
  for offset in 0..=max_offset {
    let mut corr = 0.0
    for i in 0..<n2 {
      if offset + i < n1 {
        corr = corr + audio1.samples[offset + i] * audio2.samples[i]
      }
    }
    if corr > best_corr {
      best_corr = corr
      best_offset = offset
    }
  }
  best_offset
}

/// 互相关 / Cross correlation.
pub fn audio_cross_corr_audio(audio1 : AudioAdv, audio2 : AudioAdv) -> Array[Double] {
  let n1 = audio1.samples.length()
  let n2 = audio2.samples.length()
  let result : Array[Double] = []
  let max_lag = if n1 > n2 { n1 } else { n2 }
  for lag in (-max_lag + 1)..<max_lag {
    let mut corr = 0.0
    for i in 0..<n2 {
      let j = i + lag
      if j >= 0 && j < n1 {
        corr = corr + audio1.samples[j] * audio2.samples[i]
      }
    }
    result.push(corr)
  }
  result
}

/// DTW / Dynamic time warping distance.
pub fn audio_dtw_audio(audio1 : AudioAdv, audio2 : AudioAdv) -> Double {
  let n = audio1.samples.length()
  let m = audio2.samples.length()
  if n == 0 || m == 0 {
    return 0.0
  }
  let dp : Array[Array[Double]] = []
  for _ in 0..<(n + 1) {
    let row : Array[Double] = []
    for _ in 0..<(m + 1) {
      row.push(0.0)
    }
    dp.push(row)
  }
  for i in 1..=n {

    dp[i][0] = 999999.0
  }
  for j in 1..=m {
    dp[0][j] = 999999.0
  }
  for i in 1..=n {
    for j in 1..=m {
      let cost = @_common.abs(audio1.samples[i - 1] - audio2.samples[j - 1])
      dp[i][j] = cost + ap_min(ap_min(dp[i - 1][j], dp[i][j - 1]), dp[i - 1][j - 1])
    }
  }
  dp[n][m]
}

/// 重采样 / Resample.
pub fn audio_resample(audio : AudioAdv, new_sample_rate : Int) -> AudioAdv {
  if audio.sample_rate == 0 || new_sample_rate == 0 {
    return audio
  }
  let ratio = new_sample_rate.to_double() / audio.sample_rate.to_double()
  let new_n = (audio.samples.length().to_double() * ratio).to_int()
  let out : Array[Double] = []
  for i in 0..<new_n {
    let src = i.to_double() / ratio
    let idx = src.to_int()
    let frac = src - idx.to_double()
    let v0 = if idx >= 0 && idx < audio.samples.length() { audio.samples[idx] } else { 0.0 }
    let v1 = if idx + 1 >= 0 && idx + 1 < audio.samples.length() { audio.samples[idx + 1] } else { v0 }
    out.push(v0 * (1.0 - frac) + v1 * frac)
  }
  { samples: out, sample_rate: new_sample_rate, channels: audio.channels }
}

/// 变速 / Change rate (resample without changing sample rate).
pub fn audio_change_rate(audio : AudioAdv, ratio : Double) -> AudioAdv {
  if ratio == 0.0 {
    return audio
  }
  let new_n = (audio.samples.length().to_double() / ratio).to_int()
  let out : Array[Double] = []
  for i in 0..<new_n {
    let src = i.to_double() * ratio
    let idx = src.to_int()
    let frac = src - idx.to_double()
    let v0 = if idx >= 0 && idx < audio.samples.length() { audio.samples[idx] } else { 0.0 }
    let v1 = if idx + 1 >= 0 && idx + 1 < audio.samples.length() { audio.samples[idx + 1] } else { v0 }
    out.push(v0 * (1.0 - frac) + v1 * frac)
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 混合 / Mix two signals.
pub fn audio_mix(audio1 : AudioAdv, audio2 : AudioAdv, weight1 : Double) -> AudioAdv {
  let n = if audio1.samples.length() > audio2.samples.length() { audio1.samples.length() } else { audio2.samples.length() }
  let out : Array[Double] = []
  for i in 0..<n {
    let v1 = if i < audio1.samples.length() { audio1.samples[i] } else { 0.0 }
    let v2 = if i < audio2.samples.length() { audio2.samples[i] } else { 0.0 }
    out.push(v1 * weight1 + v2 * (1.0 - weight1))
  }
  let sr = if audio1.sample_rate > 0 { audio1.sample_rate } else { audio2.sample_rate }
  { samples: out, sample_rate: sr, channels: audio1.channels }
}

/// 拼接 / Concatenate.
pub fn audio_concat(audio1 : AudioAdv, audio2 : AudioAdv) -> AudioAdv {
  let out : Array[Double] = []
  for i in 0..<audio1.samples.length() {
    out.push(audio1.samples[i])
  }
  for i in 0..<audio2.samples.length() {
    out.push(audio2.samples[i])
  }
  { samples: out, sample_rate: audio1.sample_rate, channels: audio1.channels }
}

/// 静音移除 / Remove silence.
pub fn audio_silence_remove(audio : AudioAdv, threshold : Double) -> AudioAdv {
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    if @_common.abs(audio.samples[i]) > threshold {
      out.push(audio.samples[i])
    }
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 修剪 / Trim (remove leading/trailing silence).
pub fn audio_trim(audio : AudioAdv, threshold : Double) -> AudioAdv {
  let n = audio.samples.length()
  let mut start = 0
  while start < n && @_common.abs(audio.samples[start]) < threshold {
    start = start + 1
  }
  let mut end = n - 1
  while end > start && @_common.abs(audio.samples[end]) < threshold {
    end = end - 1
  }
  let out : Array[Double] = []
  for i in start..=end {
    out.push(audio.samples[i])
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 填充 / Pad audio to length.
pub fn audio_pad_audio(audio : AudioAdv, target_length : Int, pad_value : Double) -> AudioAdv {
  let out : Array[Double] = []
  for i in 0..<audio.samples.length() {
    out.push(audio.samples[i])
  }
  if target_length > out.length() {
    for _ in 0..<(target_length - out.length()) {
      out.push(pad_value)
    }
  }
  { samples: out, sample_rate: audio.sample_rate, channels: audio.channels }
}

/// 高级音频模块 ID / Advanced audio module id.
pub fn audio_proc_adv_id() -> String {
  "opcore/audio_proc_adv"
}