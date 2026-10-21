///|
/// S9.2 音频处理深化 / Audio Processing Deepening

///|
/// 音频信号 / Audio signal (samples).
pub struct AudioSignal {
  samples : Array[Double]
  sample_rate : Int32
}

///|
/// 构造音频信号 / Create audio signal.
pub fn make_audio_signal(
  samples : Array[Double],
  sample_rate : Int32,
) -> AudioSignal {
  { samples, sample_rate, }
}

///|
/// 音频信号长度 / Audio signal length.
pub fn signal_length(sig : AudioSignal) -> Int32 {
  sig.samples.length()
}

///|
/// 音频时长（秒）/ Audio duration (seconds).
pub fn signal_duration(sig : AudioSignal) -> Double {
  sig.samples.length().to_double() / sig.sample_rate.to_double()
}

///|
/// 音频能量 / Audio energy.
pub fn signal_energy(sig : AudioSignal) -> Double {
  let mut sum = 0.0
  for i in 0..<sig.samples.length() {
    sum = sum + sig.samples[i] * sig.samples[i]
  }
  sum
}

///|
/// 音频RMS / Audio RMS (root mean square).
pub fn signal_rms(sig : AudioSignal) -> Double {
  let n = sig.samples.length()
  if n == 0 {
    return 0.0
  }
  (signal_energy(sig) / n.to_double()).sqrt()
}

///|
/// 音频过零率 / Zero crossing rate.
pub fn zero_crossing_rate(sig : AudioSignal) -> Double {
  let n = sig.samples.length()
  if n <= 1 {
    return 0.0
  }
  let mut count = 0
  for i in 1..<n {
    if (sig.samples[i - 1] >= 0.0 && sig.samples[i] < 0.0) ||
      (sig.samples[i - 1] < 0.0 && sig.samples[i] >= 0.0) {
      count = count + 1
    }
  }
  count.to_double() / (n - 1).to_double()
}

///|
/// 音频归一化 / Normalize audio signal.
pub fn normalize_signal(sig : AudioSignal) -> AudioSignal {
  let mut max_abs = 0.0
  for i in 0..<sig.samples.length() {
    let abs_v = if sig.samples[i] < 0.0 {
      -sig.samples[i]
    } else {
      sig.samples[i]
    }
    if abs_v > max_abs {
      max_abs = abs_v
    }
  }
  if max_abs == 0.0 {
    return sig
  }
  let result : Array[Double] = []
  for i in 0..<sig.samples.length() {
    result.push(sig.samples[i] / max_abs)
  }
  { samples: result, sample_rate: sig.sample_rate, }
}

///|
/// 音频静音检测 / Detect silence (returns true if RMS below threshold).
pub fn is_silent(sig : AudioSignal, threshold : Double) -> Bool {
  signal_rms(sig) < threshold
}

///|
/// 音频拼接 / Concatenate two audio signals.
pub fn concat_signals(sig1 : AudioSignal, sig2 : AudioSignal) -> AudioSignal {
  let result : Array[Double] = []
  for i in 0..<sig1.samples.length() {
    result.push(sig1.samples[i])
  }
  for i in 0..<sig2.samples.length() {
    result.push(sig2.samples[i])
  }
  { samples: result, sample_rate: sig1.sample_rate, }
}

///|
/// 音频重采样 / Resample (simple decimation).
pub fn decimate_signal(sig : AudioSignal, factor : Int32) -> AudioSignal {
  if factor <= 1 {
    return sig
  }
  let result : Array[Double] = []
  for i in 0..<sig.samples.length() {
    if i % factor == 0 {
      result.push(sig.samples[i])
    }
  }
  { samples: result, sample_rate: sig.sample_rate / factor, }
}

///|
/// 简化DFT / Simplified DFT (magnitude spectrum).
pub fn magnitude_spectrum(sig : AudioSignal, n_freqs : Int32) -> Array[Double] {
  let n = sig.samples.length()
  let result : Array[Double] = []
  for k in 0..<n_freqs {
    let mut real = 0.0
    let mut imag = 0.0
    for t in 0..<n {
      let angle = -2.0 *
        3.141592653589793 *
        k.to_double() *
        t.to_double() /
        n.to_double()
      real = real + sig.samples[t] * cos_audio(angle)
      imag = imag + sig.samples[t] * sin_audio(angle)
    }
    result.push((real * real + imag * imag).sqrt())
  }
  result
}

///|
/// 正弦近似 / Sine approximation.
fn sin_audio(x : Double) -> Double {
  let mut x = x
  let two_pi = 6.283185307179586
  let pi = 3.141592653589793
  while x > pi {
    x = x - two_pi
  }
  while x < -pi {
    x = x + two_pi
  }
  let mut result = x
  let mut term = x
  let x2 = x * x
  for i in 1..<10 {
    term = term * x2 / ((2 * i).to_double() * (2 * i + 1).to_double()) * -1.0
    result = result + term
  }
  result
}

///|
/// 余弦近似 / Cosine approximation.
fn cos_audio(x : Double) -> Double {
  sin_audio(x + 1.5707963267948966)
}

///|
/// 音频分帧 / Frame segmentation.
pub fn frame_signal(
  sig : AudioSignal,
  frame_size : Int32,
  hop_size : Int32,
) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let n = sig.samples.length()
  if frame_size <= 0 || hop_size <= 0 {
    return result
  }
  let mut start = 0
  while start + frame_size <= n {
    let frame : Array[Double] = []
    for i in 0..<frame_size {
      frame.push(sig.samples[start + i])
    }
    result.push(frame)
    start = start + hop_size
  }
  result
}

///|
/// 音频信噪比 / Signal-to-noise ratio (dB).
pub fn snr_db(signal : AudioSignal, noise : AudioSignal) -> Double {
  let s_energy = signal_energy(signal)
  let n_energy = signal_energy(noise)
  if n_energy == 0.0 {
    return 999.0
  }
  10.0 * log10_(s_energy / n_energy)
}

///|
/// 以10为底对数 / Log base 10.
fn log10_(x : Double) -> Double {
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
  2.0 * result / 2.302585092994046
}
