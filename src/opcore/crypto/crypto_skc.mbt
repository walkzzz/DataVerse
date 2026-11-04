///|
///===
/// opcore/crypto_skc
/// S13.28 new
pub struct Crypto_skcPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn crypto_skc_crypto_skc_make_point(x : Double, y : Double) -> Crypto_skcPoint {
  { x, y, label: 0, }
}

///|
pub fn crypto_skc_crypto_skc_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Crypto_skcPoint {
  { x, y, label, }
}

///|
pub fn crypto_skc_crypto_skc_point_x(p : Crypto_skcPoint) -> Double {
  p.x
}

///|
pub fn crypto_skc_crypto_skc_point_y(p : Crypto_skcPoint) -> Double {
  p.y
}

///|
pub fn crypto_skc_crypto_skc_point_label(p : Crypto_skcPoint) -> Int32 {
  p.label
}

///|
pub fn crypto_skc_crypto_skc_point_dist(
  a : Crypto_skcPoint,
  b : Crypto_skcPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn crypto_skc_crypto_skc_point_add(
  a : Crypto_skcPoint,
  b : Crypto_skcPoint,
) -> Crypto_skcPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn crypto_skc_crypto_skc_point_sub(
  a : Crypto_skcPoint,
  b : Crypto_skcPoint,
) -> Crypto_skcPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn crypto_skc_crypto_skc_point_scale(
  pt : Crypto_skcPoint,
  s : Double,
) -> Crypto_skcPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn crypto_skc_crypto_skc_point_dot(a : Crypto_skcPoint, b : Crypto_skcPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn crypto_skc_crypto_skc_point_norm(pt : Crypto_skcPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn crypto_skc_crypto_skc_point_to_string(pt : Crypto_skcPoint) -> String {
  "(" +
  crypto_skc_crypto_skc_dbl(pt.x) +
  ", " +
  crypto_skc_crypto_skc_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Crypto_skcSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn crypto_skc_crypto_skc_make_series(
  vals : Array[Double],
  name : String,
) -> Crypto_skcSeries {
  { vals, name, }
}

///|
pub fn crypto_skc_crypto_skc_series_len(s : Crypto_skcSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn crypto_skc_crypto_skc_series_sum(s : Crypto_skcSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn crypto_skc_crypto_skc_series_mean(s : Crypto_skcSeries) -> Double {
  let n = crypto_skc_crypto_skc_series_len(s)
  if n == 0 {
    0.0
  } else {
    crypto_skc_crypto_skc_series_sum(s) / n.to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_series_min(s : Crypto_skcSeries) -> Double {
  let n = crypto_skc_crypto_skc_series_len(s)
  if n == 0 {
    0.0
  } else {
    let mut m = s.vals[0]
    for i in 1..<n {
      if s.vals[i] < m {
        m = s.vals[i]
      }
    }
    m
  }
}

///|
pub fn crypto_skc_crypto_skc_series_max(s : Crypto_skcSeries) -> Double {
  let n = crypto_skc_crypto_skc_series_len(s)
  if n == 0 {
    0.0
  } else {
    let mut m = s.vals[0]
    for i in 1..<n {
      if s.vals[i] > m {
        m = s.vals[i]
      }
    }
    m
  }
}

///|
pub fn crypto_skc_crypto_skc_series_var(s : Crypto_skcSeries) -> Double {
  let n = crypto_skc_crypto_skc_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = crypto_skc_crypto_skc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_series_std(s : Crypto_skcSeries) -> Double {
  @_common.sqrt(crypto_skc_crypto_skc_series_var(s))
}

///|
pub fn crypto_skc_crypto_skc_series_scale(
  s : Crypto_skcSeries,
  f : Double,
) -> Crypto_skcSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = crypto_skc_crypto_skc_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn crypto_skc_crypto_skc_series_add(
  a : Crypto_skcSeries,
  b : Crypto_skcSeries,
) -> Crypto_skcSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = crypto_skc_crypto_skc_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn crypto_skc_crypto_skc_series_to_string(s : Crypto_skcSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + crypto_skc_crypto_skc_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Crypto_skcMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_skc_crypto_skc_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Crypto_skcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn crypto_skc_crypto_skc_matrix_identity(n : Int32) -> Crypto_skcMatrix {
  let m = crypto_skc_crypto_skc_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn crypto_skc_crypto_skc_matrix_get(
  m : Crypto_skcMatrix,
  i : Int32,
  j : Int32,
) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn crypto_skc_crypto_skc_matrix_transpose(m : Crypto_skcMatrix) -> Crypto_skcMatrix {
  let result = crypto_skc_crypto_skc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn crypto_skc_crypto_skc_matrix_add(
  a : Crypto_skcMatrix,
  b : Crypto_skcMatrix,
) -> Crypto_skcMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = crypto_skc_crypto_skc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn crypto_skc_crypto_skc_matrix_scale(
  m : Crypto_skcMatrix,
  s : Double,
) -> Crypto_skcMatrix {
  let result = crypto_skc_crypto_skc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn crypto_skc_crypto_skc_matrix_multiply(
  a : Crypto_skcMatrix,
  b : Crypto_skcMatrix,
) -> Crypto_skcMatrix {
  if a.cols != b.rows {
    return crypto_skc_crypto_skc_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = crypto_skc_crypto_skc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols {
        sum = sum + a.data[i][k] * b.data[k][j]
      }
      result.data[i][j] = sum
    }
  }
  result
}

///|
pub fn crypto_skc_crypto_skc_matrix_trace(m : Crypto_skcMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn crypto_skc_crypto_skc_matrix_norm(m : Crypto_skcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn crypto_skc_crypto_skc_matrix_to_string(m : Crypto_skcMatrix) -> String {
  let mut result = "Mat(" +
    m.rows.to_string() +
    "x" +
    m.cols.to_string() +
    ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + crypto_skc_crypto_skc_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Crypto_skcVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_skc_crypto_skc_make_vector(comps : Array[Double]) -> Crypto_skcVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_skc_crypto_skc_vector_zero(dim : Int32) -> Crypto_skcVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn crypto_skc_crypto_skc_vector_add(
  a : Crypto_skcVector,
  b : Crypto_skcVector,
) -> Crypto_skcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = crypto_skc_crypto_skc_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn crypto_skc_crypto_skc_vector_sub(
  a : Crypto_skcVector,
  b : Crypto_skcVector,
) -> Crypto_skcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = crypto_skc_crypto_skc_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn crypto_skc_crypto_skc_vector_scale(
  v : Crypto_skcVector,
  s : Double,
) -> Crypto_skcVector {
  let mut result = []
  for i in 0..<v.dim {
    result = crypto_skc_crypto_skc_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn crypto_skc_crypto_skc_vector_dot(
  a : Crypto_skcVector,
  b : Crypto_skcVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn crypto_skc_crypto_skc_vector_norm(v : Crypto_skcVector) -> Double {
  @_common.sqrt(crypto_skc_crypto_skc_vector_dot(v, v))
}

///|
pub fn crypto_skc_crypto_skc_vector_normalize(v : Crypto_skcVector) -> Crypto_skcVector {
  let n = crypto_skc_crypto_skc_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    crypto_skc_crypto_skc_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn crypto_skc_crypto_skc_vector_dist(
  a : Crypto_skcVector,
  b : Crypto_skcVector,
) -> Double {
  crypto_skc_crypto_skc_vector_norm(crypto_skc_crypto_skc_vector_sub(a, b))
}

///|
pub fn crypto_skc_crypto_skc_vector_to_string(v : Crypto_skcVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + crypto_skc_crypto_skc_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn crypto_skc_crypto_skc_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    0.0
  } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n {
      let d = data[i] - m
      sum = sum + d * d
    }
    sum / n.to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_std(data : Array[Double]) -> Double {
  @_common.sqrt(crypto_skc_crypto_skc_var(data))
}

///|
pub fn crypto_skc_crypto_skc_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 {
    0.0
  } else {
    let ma = @_common.mean(a)
    let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + (a[i] - ma) * (b[i] - mb)
    }
    sum / n.to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_skc_crypto_skc_std(a)
  let sb = crypto_skc_crypto_skc_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    crypto_skc_crypto_skc_cov(a, b) / (sa * sb)
  }
}

///|
pub fn crypto_skc_crypto_skc_accuracy(
  pred : Array[Int32],
  labels : Array[Int32],
) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut correct = 0
    for i in 0..<n {
      if pred[i] == labels[i] {
        correct = correct + 1
      }
    }
    correct.to_double() / n.to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let d = pred[i] - labels[i]
      sum = sum + d * d
    }
    sum / n.to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + @_common.abs(pred[i] - labels[i])
    }
    sum / n.to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0
    let mut ss_tot = 0.0
    for i in 0..<n {
      let r = labels[i] - pred[i]
      ss_res = ss_res + r * r
      let t = labels[i] - lm
      ss_tot = ss_tot + t * t
    }
    if ss_tot < 0.0000001 {
      0.0
    } else {
      1.0 - ss_res / ss_tot
    }
  }
}

///|
pub fn crypto_skc_crypto_skc_precision(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  let mut tp = 0
  let mut fp = 0
  for i in 0..<n {
    if pred[i] == pos {
      if labels[i] == pos {
        tp = tp + 1
      } else {
        fp = fp + 1
      }
    }
  }
  if tp + fp == 0 {
    0.0
  } else {
    tp.to_double() / (tp + fp).to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_recall(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  let mut tp = 0
  let mut fn_ = 0
  for i in 0..<n {
    if labels[i] == pos {
      if pred[i] == pos {
        tp = tp + 1
      } else {
        fn_ = fn_ + 1
      }
    }
  }
  if tp + fn_ == 0 {
    0.0
  } else {
    tp.to_double() / (tp + fn_).to_double()
  }
}

///|
pub fn crypto_skc_crypto_skc_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = crypto_skc_crypto_skc_precision(pred, labels, pos)
  let r = crypto_skc_crypto_skc_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn crypto_skc_crypto_skc_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_skc_crypto_skc_int(x) } else { -crypto_skc_crypto_skc_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    crypto_skc_crypto_skc_int(f * 1000000.0)
  } else {
    crypto_skc_crypto_skc_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn crypto_skc_crypto_skc_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn crypto_skc_crypto_skc_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
