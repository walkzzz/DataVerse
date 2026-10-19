///|
/// # opcore/signal_proc 信号处理 / Signal Processing
///
/// 滤波/变换/频谱/卷积。
///
/// # Signal processing
///
/// Filtering, transforms, spectrum, convolution.

/// 复数 / Complex number.
pub struct Complex {
  re : Double
  im : Double
} derive(Debug, Eq)

pub extend Complex with Eq::{equal, not_equal}
pub extend Complex with Debug::{to_repr}

/// 正弦函数（泰勒级数）/ Sine via Taylor series.
pub fn sin_(x : Double) -> Double {
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

/// 余弦函数（泰勒级数）/ Cosine via Taylor series.
pub fn cos_(x : Double) -> Double {
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
  let mut term = 1.0
  let mut sum = 1.0
  for n in 1..<14 {
    term = -term * y2 / ((2 * n - 1).to_double() * (2 * n).to_double())
    sum = sum + term
  }
  sum
}

/// 平方根（牛顿迭代法）/ Square root via Newton iteration.
pub fn sqrt_(x : Double) -> Double {
  if x <= 0.0 {
    0.0
  } else {
    let mut guess = x
    if guess > 1.0 {
      guess = guess / 2.0
    }
    let mut prev = 0.0
    let mut iter = 0
    while (guess - prev).abs() > 0.0000001 && iter < 60 {
      prev = guess
      guess = (guess + x / guess) / 2.0
      iter = iter + 1
    }
    guess
  }
}

fn exp_(x : Double) -> Double {
  let mut term = 1.0
  let mut sum = 1.0
  for n in 1..<24 {
    term = term * x / n.to_double()
    sum = sum + term
  }
  sum
}

fn atan_(x : Double) -> Double {
  if x.abs() > 1.0 {
    1.5707963267948966 - atan_(1.0 / x)
  } else {
    let mut term = x
    let mut sum = x
    for n in 1..<24 {
      term = -term * x * x * (2 * n - 1).to_double() / (2 * n + 1).to_double()
      sum = sum + term
    }
    sum
  }
}

fn atan2_(y : Double, x : Double) -> Double {
  let pi = 3.141592653589793
  let half_pi = 1.5707963267948966
  if x > 0.0 {
    atan_(y / x)
  } else if x < 0.0 && y >= 0.0 {
    atan_(y / x) + pi
  } else if x < 0.0 && y < 0.0 {
    atan_(y / x) - pi
  } else if x == 0.0 && y > 0.0 {
    half_pi
  } else if x == 0.0 && y < 0.0 {
    -half_pi
  } else {
    0.0
  }
}

fn sort_array(arr : Array[Double]) -> Array[Double] {
  let result : Array[Double] = []
  for v in arr {
    result.push(v)
  }
  let n = result.length()
  for i in 0..<n {
    for j in 0..<(n - 1 - i) {
      if result[j] > result[j + 1] {
        let tmp = result[j]
        result[j] = result[j + 1]
        result[j + 1] = tmp
      }
    }
  }
  result
}

/// 创建信号 / Create a signal filled with value.
pub fn make_signal(size : Int, value : Double) -> Array[Double] {
  let result : Array[Double] = []
  for _ in 0..<size {
    result.push(value)
  }
  result
}

/// 信号长度 / Signal length.
pub fn signal_length(signal : Array[Double]) -> Int {
  signal.length()
}

/// 信号求和 / Signal sum.
pub fn signal_sum(signal : Array[Double]) -> Double {
  let mut sum = 0.0
  for x in signal {
    sum = sum + x
  }
  sum
}

/// 信号均值 / Signal mean.
pub fn signal_mean(signal : Array[Double]) -> Double {
  let n = signal.length()
  if n == 0 {
    0.0
  } else {
    signal_sum(signal) / n.to_double()
  }
}

/// 信号最大值 / Signal maximum.
pub fn signal_max(signal : Array[Double]) -> Double {
  let n = signal.length()
  if n == 0 {
    0.0
  } else {
    let mut m = signal[0]
    for x in signal {
      if x > m {
        m = x
      }
    }
    m
  }
}

/// 信号最小值 / Signal minimum.
pub fn signal_min(signal : Array[Double]) -> Double {
  let n = signal.length()
  if n == 0 {
    0.0
  } else {
    let mut m = signal[0]
    for x in signal {
      if x < m {
        m = x
      }
    }
    m
  }
}

/// 信号能量 / Signal energy (sum of squares).
pub fn signal_energy(signal : Array[Double]) -> Double {
  let mut e = 0.0
  for x in signal {
    e = e + x * x
  }
  e
}

/// 信号功率 / Signal power (energy / length).
pub fn signal_power(signal : Array[Double]) -> Double {
  let n = signal.length()
  if n == 0 {
    0.0
  } else {
    signal_energy(signal) / n.to_double()
  }
}

/// 信号缩放 / Scale signal by factor.
pub fn signal_scale(signal : Array[Double], factor : Double) -> Array[Double] {
  let result : Array[Double] = []
  for x in signal {
    result.push(x * factor)
  }
  result
}

/// 信号相加 / Add two signals element-wise.
pub fn signal_add(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(a[i] + b[i])
  }
  result
}

/// 信号相乘 / Multiply two signals element-wise.
pub fn signal_multiply(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(a[i] * b[i])
  }
  result
}

/// 信号取反 / Negate signal.
pub fn signal_negate(signal : Array[Double]) -> Array[Double] {
  let result : Array[Double] = []
  for x in signal {
    result.push(-x)
  }
  result
}

/// 信号共轭 / Conjugate signal (identity for real signals).
pub fn signal_conjugate(signal : Array[Double]) -> Array[Double] {
  let result : Array[Double] = []
  for x in signal {
    result.push(x)
  }
  result
}

/// 信号反转 / Reverse signal.
pub fn signal_reverse(signal : Array[Double]) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(signal[n - 1 - i])
  }
  result
}

/// 信号移位 / Shift signal by offset.
pub fn signal_shift(signal : Array[Double], shift : Int) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  for _ in 0..<n {
    result.push(0.0)
  }
  for i in 0..<n {
    let j = i + shift
    if j >= 0 && j < n {
      result[j] = signal[i]
    }
  }
  result
}

/// 移动平均滤波 / Moving average filter.
pub fn moving_average_filter(signal : Array[Double], window : Int) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let half = window / 2
  for i in 0..<n {
    let mut sum = 0.0
    let mut count = 0
    for k in 0..<window {
      let idx = i + k - half
      if idx >= 0 && idx < n {
        sum = sum + signal[idx]
        count = count + 1
      }
    }
    if count > 0 {
      result.push(sum / count.to_double())
    } else {
      result.push(0.0)
    }
  }
  result
}

/// 中值滤波 / Median filter.
pub fn median_filter(signal : Array[Double], window : Int) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let half = window / 2
  for i in 0..<n {
    let vals : Array[Double] = []
    for k in 0..<window {
      let idx = i + k - half
      if idx >= 0 && idx < n {
        vals.push(signal[idx])
      }
    }
    let sorted = sort_array(vals)
    let mid = sorted.length() / 2
    if sorted.length() > 0 {
      result.push(sorted[mid])
    } else {
      result.push(0.0)
    }
  }
  result
}

/// 高斯滤波 / Gaussian filter.
pub fn gaussian_filter(signal : Array[Double], sigma : Double) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let radius = 3
  for i in 0..<n {
    let mut sum = 0.0
    let mut wsum = 0.0
    for k in 0..<(2 * radius + 1) {
      let offset = k - radius
      let idx = i + offset
      if idx >= 0 && idx < n {
        let w = exp_(-((offset.to_double() * offset.to_double())) / (2.0 * sigma * sigma))
        sum = sum + signal[idx] * w
        wsum = wsum + w
      }
    }
    if wsum > 0.0 {
      result.push(sum / wsum)
    } else {
      result.push(0.0)
    }
  }
  result
}

/// 低通滤波 / Low pass filter.
pub fn low_pass_filter(signal : Array[Double], cutoff : Double) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let alpha = cutoff
  if n > 0 {
    result.push(signal[0])
  }
  for i in 1..<n {
    result.push(alpha * signal[i] + (1.0 - alpha) * result[i - 1])
  }
  result
}

/// 高通滤波 / High pass filter.
pub fn high_pass_filter(signal : Array[Double], cutoff : Double) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let alpha = cutoff
  if n > 0 {
    result.push(signal[0])
  }
  for i in 1..<n {
    result.push(alpha * (result[i - 1] + signal[i] - signal[i - 1]))
  }
  result
}

/// 带通滤波 / Band pass filter.
pub fn band_pass_filter(signal : Array[Double], low : Double, high : Double) -> Array[Double] {
  let lp_high = low_pass_filter(signal, high)
  let lp_low = low_pass_filter(signal, low)
  signal_add(lp_high, signal_negate(lp_low))
}

/// 巴特沃斯滤波 / Butterworth filter.
pub fn butterworth_filter(
  signal : Array[Double],
  cutoff : Double,
  order : Int
) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let alpha = cutoff
  if n > 0 {
    result.push(signal[0])
  }
  for i in 1..<n {
    let mut y = alpha * signal[i] + (1.0 - alpha) * result[i - 1]
    for _ in 1..<order {
      y = alpha * y + (1.0 - alpha) * result[i - 1]
    }
    result.push(y)
  }
  result
}

/// 切比雪夫滤波 / Chebyshev filter.
pub fn chebyshev_filter(
  signal : Array[Double],
  cutoff : Double,
  ripple : Double
) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let alpha = cutoff * (1.0 + ripple)
  if n > 0 {
    result.push(signal[0])
  }
  for i in 1..<n {
    result.push(alpha * signal[i] + (1.0 - alpha) * result[i - 1])
  }
  result
}

/// 离散傅里叶变换 / Discrete Fourier Transform.
pub fn dft(signal : Array[Double]) -> Array[Complex] {
  let n = signal.length()
  let result : Array[Complex] = []
  let pi2 = 6.283185307179586
  for k in 0..<n {
    let mut re = 0.0
    let mut im = 0.0
    for j in 0..<n {
      let angle = -pi2 * k.to_double() * j.to_double() / n.to_double()
      re = re + signal[j] * cos_(angle)
      im = im + signal[j] * sin_(angle)
    }
    result.push(Complex::{re, im})
  }
  result
}

/// 逆离散傅里叶变换 / Inverse Discrete Fourier Transform.
pub fn idft(spectrum : Array[Complex]) -> Array[Double] {
  let n = spectrum.length()
  let result : Array[Double] = []
  let pi2 = 6.283185307179586
  for k in 0..<n {
    let mut re = 0.0
    for j in 0..<n {
      let angle = pi2 * k.to_double() * j.to_double() / n.to_double()
      re = re + spectrum[j].re * cos_(angle) - spectrum[j].im * sin_(angle)
    }
    result.push(re / n.to_double())
  }
  result
}

/// FFT 幅度 / FFT magnitude spectrum.
pub fn fft_magnitude(signal : Array[Double]) -> Array[Double] {
  let spectrum = dft(signal)
  let result : Array[Double] = []
  for c in spectrum {
    result.push(sqrt_(c.re * c.re + c.im * c.im))
  }
  result
}

/// FFT 相位 / FFT phase spectrum.
pub fn fft_phase(signal : Array[Double]) -> Array[Double] {
  let spectrum = dft(signal)
  let result : Array[Double] = []
  for c in spectrum {
    if c.re == 0.0 && c.im == 0.0 {
      result.push(0.0)
    } else {
      result.push(atan2_(c.im, c.re))
    }
  }
  result
}

/// 离散余弦变换 / Discrete Cosine Transform.
pub fn dct(signal : Array[Double]) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let pi = 3.141592653589793
  for k in 0..<n {
    let mut sum = 0.0
    for j in 0..<n {
      let angle = pi * k.to_double() * (2 * j + 1).to_double() / (2.0 * n.to_double())
      sum = sum + signal[j] * cos_(angle)
    }
    result.push(sum)
  }
  result
}

/// 离散正弦变换 / Discrete Sine Transform.
pub fn dst(signal : Array[Double]) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let pi = 3.141592653589793
  for k in 0..<n {
    let mut sum = 0.0
    for j in 0..<n {
      let angle = pi * (k + 1).to_double() * (j + 1).to_double() / (n.to_double() + 1.0)
      sum = sum + signal[j] * sin_(angle)
    }
    result.push(sum)
  }
  result
}

/// 希尔伯特变换 / Hilbert transform.
pub fn hilbert_transform(signal : Array[Double]) -> Array[Double] {
  let n = signal.length()
  let result : Array[Double] = []
  let pi = 3.141592653589793
  for i in 0..<n {
    let mut sum = 0.0
    for j in 0..<n {
      if i != j {
        let diff = (i - j).to_double()
        sum = sum + signal[j] / diff
      }
    }
    result.push(sum / pi)
  }
  result
}

/// 功率谱 / Power spectrum.
pub fn power_spectrum(signal : Array[Double]) -> Array[Double] {
  let mag = fft_magnitude(signal)
  let result : Array[Double] = []
  for m in mag {
    result.push(m * m)
  }
  result
}

/// 幅度谱 / Magnitude spectrum.
pub fn magnitude_spectrum(signal : Array[Double]) -> Array[Double] {
  fft_magnitude(signal)
}

/// 相位谱 / Phase spectrum.
pub fn phase_spectrum(signal : Array[Double]) -> Array[Double] {
  fft_phase(signal)
}

/// 频谱图 / Spectrogram.
pub fn spectrogram(signal : Array[Double], window_size : Int) -> Array[Array[Double]] {
  let result : Array[Array[Double]] = []
  let n = signal.length()
  let hop = window_size / 2
  if hop <= 0 {
    return result
  }
  let mut start = 0
  while start + window_size <= n {
    let frame : Array[Double] = []
    for i in 0..<window_size {
      frame.push(signal[start + i])
    }
    result.push(power_spectrum(frame))
    start = start + hop
  }
  result
}

/// 谱质心 / Spectral centroid.
pub fn spectral_centroid(signal : Array[Double]) -> Double {
  let mag = magnitude_spectrum(signal)
  let n = mag.length()
  let mut weighted = 0.0
  let mut total = 0.0
  for i in 0..<n {
    weighted = weighted + i.to_double() * mag[i]
    total = total + mag[i]
  }
  if total > 0.0 {
    weighted / total
  } else {
    0.0
  }
}

/// 谱滚降点 / Spectral rolloff.
pub fn spectral_rolloff(signal : Array[Double], threshold : Double) -> Double {
  let mag = magnitude_spectrum(signal)
  let n = mag.length()
  let mut total = 0.0
  for m in mag {
    total = total + m
  }
  let target = total * threshold
  let mut cumsum = 0.0
  for i in 0..<n {
    cumsum = cumsum + mag[i]
    if cumsum >= target {
      return i.to_double()
    }
  }
  0.0
}

/// 谱通量 / Spectral flux.
pub fn spectral_flux(a : Array[Double], b : Array[Double]) -> Double {
  let mag_a = magnitude_spectrum(a)
  let mag_b = magnitude_spectrum(b)
  let n = if mag_a.length() < mag_b.length() { mag_a.length() } else {
    mag_b.length()
  }
  let mut sum = 0.0
  for i in 0..<n {
    let diff = mag_b[i] - mag_a[i]
    sum = sum + diff * diff
  }
  sqrt_(sum)
}

/// 过零率 / Zero crossing rate.
pub fn zero_crossing_rate(signal : Array[Double]) -> Double {
  let n = signal.length()
  if n < 2 {
    return 0.0
  }
  let mut count = 0
  for i in 1..<n {
    if (signal[i - 1] >= 0.0 && signal[i] < 0.0) || (signal[i - 1] < 0.0 && signal[i] >= 0.0) {
      count = count + 1
    }
  }
  count.to_double() / (n - 1).to_double()
}

/// 汉宁窗 / Hann window.
pub fn hann_window(size : Int) -> Array[Double] {
  let result : Array[Double] = []
  let pi = 3.141592653589793
  if size <= 1 {
    for _ in 0..<size {
      result.push(1.0)
    }
    return result
  }
  for i in 0..<size {
    let w = 0.5 - 0.5 * cos_(2.0 * pi * i.to_double() / (size - 1).to_double())
    result.push(w)
  }
  result
}

/// 汉明窗 / Hamming window.
pub fn hamming_window(size : Int) -> Array[Double] {
  let result : Array[Double] = []
  let pi = 3.141592653589793
  if size <= 1 {
    for _ in 0..<size {
      result.push(1.0)
    }
    return result
  }
  for i in 0..<size {
    let w = 0.54 - 0.46 * cos_(2.0 * pi * i.to_double() / (size - 1).to_double())
    result.push(w)
  }
  result
}

/// 布莱克曼窗 / Blackman window.
pub fn blackman_window(size : Int) -> Array[Double] {
  let result : Array[Double] = []
  let pi = 3.141592653589793
  if size <= 1 {
    for _ in 0..<size {
      result.push(1.0)
    }
    return result
  }
  for i in 0..<size {
    let x = 2.0 * pi * i.to_double() / (size - 1).to_double()
    let w = 0.42 - 0.5 * cos_(x) + 0.08 * cos_(2.0 * x)
    result.push(w)
  }
  result
}

/// 矩形窗 / Rectangular window.
pub fn rectangular_window(size : Int) -> Array[Double] {
  let result : Array[Double] = []
  for _ in 0..<size {
    result.push(1.0)
  }
  result
}

/// 三角窗 / Triangular window.
pub fn triangular_window(size : Int) -> Array[Double] {
  let result : Array[Double] = []
  if size <= 1 {
    for _ in 0..<size {
      result.push(1.0)
    }
    return result
  }
  let half = (size - 1).to_double() / 2.0
  for i in 0..<size {
    let w = 1.0 - (i.to_double() - half).abs() / half
    result.push(w)
  }
  result
}

/// 平顶窗 / Flat top window.
pub fn flattop_window(size : Int) -> Array[Double] {
  let result : Array[Double] = []
  let pi = 3.141592653589793
  if size <= 1 {
    for _ in 0..<size {
      result.push(1.0)
    }
    return result
  }
  for i in 0..<size {
    let x = 2.0 * pi * i.to_double() / (size - 1).to_double()
    let w = 0.21557895 - 0.41663158 * cos_(x) + 0.277263158 * cos_(2.0 * x) - 0.083578947 * cos_(3.0 * x) + 0.006947368 * cos_(4.0 * x)
    result.push(w)
  }
  result
}

/// 卷积 / Convolution.
pub fn convolve(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length()
  let nb = b.length()
  if na == 0 || nb == 0 {
    return []
  }
  let n = na + nb - 1
  let result : Array[Double] = []
  for _ in 0..<n {
    result.push(0.0)
  }
  for i in 0..<na {
    for j in 0..<nb {
      result[i + j] = result[i + j] + a[i] * b[j]
    }
  }
  result
}

/// 互相关 / Correlation.
pub fn correlate(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length()
  let nb = b.length()
  if na == 0 || nb == 0 {
    return []
  }
  let n = na + nb - 1
  let result : Array[Double] = []
  for _ in 0..<n {
    result.push(0.0)
  }
  for i in 0..<na {
    for j in 0..<nb {
      result[i + nb - 1 - j] = result[i + nb - 1 - j] + a[i] * b[j]
    }
  }
  result
}

/// 自相关 / Autocorrelation.
pub fn autocorrelate(signal : Array[Double]) -> Array[Double] {
  correlate(signal, signal)
}

/// 互相关（交叉）/ Cross correlation.
pub fn cross_correlate(a : Array[Double], b : Array[Double]) -> Array[Double] {
  correlate(a, signal_reverse(b))
}

/// 包标识 / Package identifier.
pub fn signal_proc_id() -> String {
  "opcore/signal_proc"
}