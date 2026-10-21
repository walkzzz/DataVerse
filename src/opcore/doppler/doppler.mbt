///|
///===
/// opcore/doppler
/// S13.42 new
pub struct DopplerPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn doppler_make_point(x : Double, y : Double) -> DopplerPoint {
  { x, y, label: 0, }
}

///|
pub fn doppler_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> DopplerPoint {
  { x, y, label, }
}

///|
pub fn doppler_point_x(p : DopplerPoint) -> Double {
  p.x
}

///|
pub fn doppler_point_y(p : DopplerPoint) -> Double {
  p.y
}

///|
pub fn doppler_point_label(p : DopplerPoint) -> Int32 {
  p.label
}

///|
pub fn doppler_point_dist(a : DopplerPoint, b : DopplerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn doppler_point_add(a : DopplerPoint, b : DopplerPoint) -> DopplerPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn doppler_point_sub(a : DopplerPoint, b : DopplerPoint) -> DopplerPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn doppler_point_scale(pt : DopplerPoint, s : Double) -> DopplerPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn doppler_point_dot(a : DopplerPoint, b : DopplerPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn doppler_point_norm(pt : DopplerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn doppler_point_to_string(pt : DopplerPoint) -> String {
  "(" +
  doppler_dbl(pt.x) +
  ", " +
  doppler_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct DopplerSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn doppler_make_series(
  vals : Array[Double],
  name : String,
) -> DopplerSeries {
  { vals, name, }
}

///|
pub fn doppler_series_len(s : DopplerSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn doppler_series_sum(s : DopplerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn doppler_series_mean(s : DopplerSeries) -> Double {
  let n = doppler_series_len(s)
  if n == 0 {
    0.0
  } else {
    doppler_series_sum(s) / n.to_double()
  }
}

///|
pub fn doppler_series_min(s : DopplerSeries) -> Double {
  let n = doppler_series_len(s)
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
pub fn doppler_series_max(s : DopplerSeries) -> Double {
  let n = doppler_series_len(s)
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
pub fn doppler_series_var(s : DopplerSeries) -> Double {
  let n = doppler_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = doppler_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn doppler_series_std(s : DopplerSeries) -> Double {
  @_common.sqrt(doppler_series_var(s))
}

///|
pub fn doppler_series_scale(s : DopplerSeries, f : Double) -> DopplerSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = doppler_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn doppler_series_add(
  a : DopplerSeries,
  b : DopplerSeries,
) -> DopplerSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = doppler_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn doppler_series_to_string(s : DopplerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + doppler_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct DopplerMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn doppler_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DopplerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn doppler_matrix_identity(n : Int32) -> DopplerMatrix {
  let m = doppler_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn doppler_matrix_get(m : DopplerMatrix, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn doppler_matrix_transpose(m : DopplerMatrix) -> DopplerMatrix {
  let result = doppler_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn doppler_matrix_add(
  a : DopplerMatrix,
  b : DopplerMatrix,
) -> DopplerMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = doppler_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn doppler_matrix_scale(m : DopplerMatrix, s : Double) -> DopplerMatrix {
  let result = doppler_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn doppler_matrix_multiply(
  a : DopplerMatrix,
  b : DopplerMatrix,
) -> DopplerMatrix {
  if a.cols != b.rows {
    return doppler_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = doppler_make_matrix(a.rows, b.cols, 0.0)
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
pub fn doppler_matrix_trace(m : DopplerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn doppler_matrix_norm(m : DopplerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn doppler_matrix_to_string(m : DopplerMatrix) -> String {
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
      result = result + doppler_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct DopplerVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn doppler_make_vector(comps : Array[Double]) -> DopplerVector {
  { comps, dim: comps.length(), }
}

///|
pub fn doppler_vector_zero(dim : Int32) -> DopplerVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn doppler_vector_add(
  a : DopplerVector,
  b : DopplerVector,
) -> DopplerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = doppler_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn doppler_vector_sub(
  a : DopplerVector,
  b : DopplerVector,
) -> DopplerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = doppler_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn doppler_vector_scale(v : DopplerVector, s : Double) -> DopplerVector {
  let mut result = []
  for i in 0..<v.dim {
    result = doppler_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn doppler_vector_dot(a : DopplerVector, b : DopplerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn doppler_vector_norm(v : DopplerVector) -> Double {
  @_common.sqrt(doppler_vector_dot(v, v))
}

///|
pub fn doppler_vector_normalize(v : DopplerVector) -> DopplerVector {
  let n = doppler_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    doppler_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn doppler_vector_dist(a : DopplerVector, b : DopplerVector) -> Double {
  doppler_vector_norm(doppler_vector_sub(a, b))
}

///|
pub fn doppler_vector_to_string(v : DopplerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + doppler_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn doppler_var(data : Array[Double]) -> Double {
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
pub fn doppler_std(data : Array[Double]) -> Double {
  @_common.sqrt(doppler_var(data))
}

///|
pub fn doppler_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn doppler_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = doppler_std(a)
  let sb = doppler_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    doppler_cov(a, b) / (sa * sb)
  }
}

///|
pub fn doppler_accuracy(pred : Array[Int32], labels : Array[Int32]) -> Double {
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
pub fn doppler_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn doppler_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn doppler_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn doppler_precision(
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
pub fn doppler_recall(
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
pub fn doppler_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = doppler_precision(pred, labels, pos)
  let r = doppler_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn doppler_dbl(x : Double) -> String {
  let i = if x >= 0.0 { doppler_int(x) } else { -doppler_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    doppler_int(f * 1000000.0)
  } else {
    doppler_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn doppler_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn doppler_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
