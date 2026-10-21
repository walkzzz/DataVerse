///|
///===
/// datatemporal/savepoint
/// S13.222 new
pub struct SavepointPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn savepoint_make_point(x : Double, y : Double) -> SavepointPoint {
  { x, y, label: 0, }
}

///|
pub fn savepoint_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> SavepointPoint {
  { x, y, label, }
}

///|
pub fn savepoint_point_x(p : SavepointPoint) -> Double {
  p.x
}

///|
pub fn savepoint_point_y(p : SavepointPoint) -> Double {
  p.y
}

///|
pub fn savepoint_point_label(p : SavepointPoint) -> Int32 {
  p.label
}

///|
pub fn savepoint_point_dist(a : SavepointPoint, b : SavepointPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn savepoint_point_add(
  a : SavepointPoint,
  b : SavepointPoint,
) -> SavepointPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn savepoint_point_sub(
  a : SavepointPoint,
  b : SavepointPoint,
) -> SavepointPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn savepoint_point_scale(pt : SavepointPoint, s : Double) -> SavepointPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn savepoint_point_dot(a : SavepointPoint, b : SavepointPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn savepoint_point_norm(pt : SavepointPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn savepoint_point_to_string(pt : SavepointPoint) -> String {
  "(" +
  savepoint_dbl(pt.x) +
  ", " +
  savepoint_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct SavepointSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn savepoint_make_series(
  vals : Array[Double],
  name : String,
) -> SavepointSeries {
  { vals, name, }
}

///|
pub fn savepoint_series_len(s : SavepointSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn savepoint_series_sum(s : SavepointSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn savepoint_series_mean(s : SavepointSeries) -> Double {
  let n = savepoint_series_len(s)
  if n == 0 {
    0.0
  } else {
    savepoint_series_sum(s) / n.to_double()
  }
}

///|
pub fn savepoint_series_min(s : SavepointSeries) -> Double {
  let n = savepoint_series_len(s)
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
pub fn savepoint_series_max(s : SavepointSeries) -> Double {
  let n = savepoint_series_len(s)
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
pub fn savepoint_series_var(s : SavepointSeries) -> Double {
  let n = savepoint_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = savepoint_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn savepoint_series_std(s : SavepointSeries) -> Double {
  @_common.sqrt(savepoint_series_var(s))
}

///|
pub fn savepoint_series_scale(
  s : SavepointSeries,
  f : Double,
) -> SavepointSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = savepoint_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn savepoint_series_add(
  a : SavepointSeries,
  b : SavepointSeries,
) -> SavepointSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = savepoint_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn savepoint_series_to_string(s : SavepointSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + savepoint_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct SavepointMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn savepoint_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SavepointMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn savepoint_matrix_identity(n : Int32) -> SavepointMatrix {
  let m = savepoint_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn savepoint_matrix_get(
  m : SavepointMatrix,
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
pub fn savepoint_matrix_transpose(m : SavepointMatrix) -> SavepointMatrix {
  let result = savepoint_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn savepoint_matrix_add(
  a : SavepointMatrix,
  b : SavepointMatrix,
) -> SavepointMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = savepoint_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn savepoint_matrix_scale(
  m : SavepointMatrix,
  s : Double,
) -> SavepointMatrix {
  let result = savepoint_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn savepoint_matrix_multiply(
  a : SavepointMatrix,
  b : SavepointMatrix,
) -> SavepointMatrix {
  if a.cols != b.rows {
    return savepoint_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = savepoint_make_matrix(a.rows, b.cols, 0.0)
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
pub fn savepoint_matrix_trace(m : SavepointMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn savepoint_matrix_norm(m : SavepointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn savepoint_matrix_to_string(m : SavepointMatrix) -> String {
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
      result = result + savepoint_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct SavepointVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn savepoint_make_vector(comps : Array[Double]) -> SavepointVector {
  { comps, dim: comps.length(), }
}

///|
pub fn savepoint_vector_zero(dim : Int32) -> SavepointVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn savepoint_vector_add(
  a : SavepointVector,
  b : SavepointVector,
) -> SavepointVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = savepoint_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn savepoint_vector_sub(
  a : SavepointVector,
  b : SavepointVector,
) -> SavepointVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = savepoint_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn savepoint_vector_scale(
  v : SavepointVector,
  s : Double,
) -> SavepointVector {
  let mut result = []
  for i in 0..<v.dim {
    result = savepoint_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn savepoint_vector_dot(a : SavepointVector, b : SavepointVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn savepoint_vector_norm(v : SavepointVector) -> Double {
  @_common.sqrt(savepoint_vector_dot(v, v))
}

///|
pub fn savepoint_vector_normalize(v : SavepointVector) -> SavepointVector {
  let n = savepoint_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    savepoint_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn savepoint_vector_dist(
  a : SavepointVector,
  b : SavepointVector,
) -> Double {
  savepoint_vector_norm(savepoint_vector_sub(a, b))
}

///|
pub fn savepoint_vector_to_string(v : SavepointVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + savepoint_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn savepoint_var(data : Array[Double]) -> Double {
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
pub fn savepoint_std(data : Array[Double]) -> Double {
  @_common.sqrt(savepoint_var(data))
}

///|
pub fn savepoint_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn savepoint_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = savepoint_std(a)
  let sb = savepoint_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    savepoint_cov(a, b) / (sa * sb)
  }
}

///|
pub fn savepoint_accuracy(pred : Array[Int32], labels : Array[Int32]) -> Double {
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
pub fn savepoint_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn savepoint_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn savepoint_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn savepoint_precision(
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
pub fn savepoint_recall(
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
pub fn savepoint_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = savepoint_precision(pred, labels, pos)
  let r = savepoint_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn savepoint_dbl(x : Double) -> String {
  let i = if x >= 0.0 { savepoint_int(x) } else { -savepoint_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    savepoint_int(f * 1000000.0)
  } else {
    savepoint_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn savepoint_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn savepoint_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
