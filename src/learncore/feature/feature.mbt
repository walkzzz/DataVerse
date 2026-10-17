///|
/// # learncore/feature 特征工程算子 / Feature Engineering Operators
///
/// 标准化、归一化、编码。架构 §4.3.5 A（降维与特征）。
/// S1.2 基礎：standardize（Z-score）+ normalize_minmax。
///
/// # Feature engineering operators
///
/// Standardization, normalization, encoding. See architecture §4.3.5 A.

/// 标准化（Z-score）：(x - mean) / std / Standardize (Z-score).
///
/// 退化安全：空数组返回空数组；std = 0 返回全 0。
pub fn standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 {
    return []
  }
  let mean = data.fold(init=0.0, fn(acc, x) { acc + x }) / n.to_double()
  let mut variance = 0.0
  for i = 0; i < n; i = i + 1 {
    let d = data[i] - mean
    variance = variance + d * d
  }
  variance = variance / n.to_double()
  let std = variance.sqrt()
  if std < 0.000000000001 {
    return Array::make(n, 0.0)
  }
  data.map(fn(x) { (x - mean) / std })
}

/// Min-Max 归一化：映射到 [0, 1] / Min-Max normalize to [0, 1].
///
/// 退化安全：空数组返回空数组；所有值相同返回全 0。
pub fn normalize_minmax(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 {
    return []
  }
  let mut lo = data[0]
  let mut hi = data[0]
  for i = 1; i < n; i = i + 1 {
    if data[i] < lo {
      lo = data[i]
    }
    if data[i] > hi {
      hi = data[i]
    }
  }
  let range = hi - lo
  if range < 0.000000000001 {
    return Array::make(n, 0.0)
  }
  data.map(fn(x) { (x - lo) / range })
}

pub fn feature_id() -> String {
  "learncore/feature"
}