///|
///===
/// datatemporal/checkpoint_async
/// S13.221 new
pub struct Checkpoint_asyncPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn checkpoint_async_make_point(
  x : Double,
  y : Double,
) -> Checkpoint_asyncPoint {
  { x, y, label: 0, }
}

///|
pub fn checkpoint_async_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Checkpoint_asyncPoint {
  { x, y, label, }
}

///|
pub fn checkpoint_async_point_x(p : Checkpoint_asyncPoint) -> Double {
  p.x
}

///|
pub fn checkpoint_async_point_y(p : Checkpoint_asyncPoint) -> Double {
  p.y
}

///|
pub fn checkpoint_async_point_label(p : Checkpoint_asyncPoint) -> Int32 {
  p.label
}

///|
pub fn checkpoint_async_point_dist(
  a : Checkpoint_asyncPoint,
  b : Checkpoint_asyncPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn checkpoint_async_point_add(
  a : Checkpoint_asyncPoint,
  b : Checkpoint_asyncPoint,
) -> Checkpoint_asyncPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn checkpoint_async_point_sub(
  a : Checkpoint_asyncPoint,
  b : Checkpoint_asyncPoint,
) -> Checkpoint_asyncPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn checkpoint_async_point_scale(
  pt : Checkpoint_asyncPoint,
  s : Double,
) -> Checkpoint_asyncPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn checkpoint_async_point_dot(
  a : Checkpoint_asyncPoint,
  b : Checkpoint_asyncPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn checkpoint_async_point_norm(pt : Checkpoint_asyncPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn checkpoint_async_point_to_string(pt : Checkpoint_asyncPoint) -> String {
  "(" +
  checkpoint_async_dbl(pt.x) +
  ", " +
  checkpoint_async_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Checkpoint_asyncSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn checkpoint_async_make_series(
  vals : Array[Double],
  name : String,
) -> Checkpoint_asyncSeries {
  { vals, name, }
}

///|
pub fn checkpoint_async_series_len(s : Checkpoint_asyncSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn checkpoint_async_series_sum(s : Checkpoint_asyncSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn checkpoint_async_series_mean(s : Checkpoint_asyncSeries) -> Double {
  let n = checkpoint_async_series_len(s)
  if n == 0 {
    0.0
  } else {
    checkpoint_async_series_sum(s) / n.to_double()
  }
}

///|
pub fn checkpoint_async_series_min(s : Checkpoint_asyncSeries) -> Double {
  let n = checkpoint_async_series_len(s)
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
pub fn checkpoint_async_series_max(s : Checkpoint_asyncSeries) -> Double {
  let n = checkpoint_async_series_len(s)
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
pub fn checkpoint_async_series_var(s : Checkpoint_asyncSeries) -> Double {
  let n = checkpoint_async_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = checkpoint_async_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn checkpoint_async_series_std(s : Checkpoint_asyncSeries) -> Double {
  @_common.sqrt(checkpoint_async_series_var(s))
}

///|
pub fn checkpoint_async_series_scale(
  s : Checkpoint_asyncSeries,
  f : Double,
) -> Checkpoint_asyncSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = checkpoint_async_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn checkpoint_async_series_add(
  a : Checkpoint_asyncSeries,
  b : Checkpoint_asyncSeries,
) -> Checkpoint_asyncSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = checkpoint_async_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn checkpoint_async_series_to_string(s : Checkpoint_asyncSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + checkpoint_async_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Checkpoint_asyncMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn checkpoint_async_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Checkpoint_asyncMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn checkpoint_async_matrix_identity(n : Int32) -> Checkpoint_asyncMatrix {
  let m = checkpoint_async_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn checkpoint_async_matrix_get(
  m : Checkpoint_asyncMatrix,
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
pub fn checkpoint_async_matrix_transpose(
  m : Checkpoint_asyncMatrix,
) -> Checkpoint_asyncMatrix {
  let result = checkpoint_async_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn checkpoint_async_matrix_add(
  a : Checkpoint_asyncMatrix,
  b : Checkpoint_asyncMatrix,
) -> Checkpoint_asyncMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = checkpoint_async_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn checkpoint_async_matrix_scale(
  m : Checkpoint_asyncMatrix,
  s : Double,
) -> Checkpoint_asyncMatrix {
  let result = checkpoint_async_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn checkpoint_async_matrix_multiply(
  a : Checkpoint_asyncMatrix,
  b : Checkpoint_asyncMatrix,
) -> Checkpoint_asyncMatrix {
  if a.cols != b.rows {
    return checkpoint_async_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = checkpoint_async_make_matrix(a.rows, b.cols, 0.0)
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
pub fn checkpoint_async_matrix_trace(m : Checkpoint_asyncMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn checkpoint_async_matrix_norm(m : Checkpoint_asyncMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn checkpoint_async_matrix_to_string(m : Checkpoint_asyncMatrix) -> String {
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
      result = result + checkpoint_async_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Checkpoint_asyncVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn checkpoint_async_make_vector(
  comps : Array[Double],
) -> Checkpoint_asyncVector {
  { comps, dim: comps.length(), }
}

///|
pub fn checkpoint_async_vector_zero(dim : Int32) -> Checkpoint_asyncVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn checkpoint_async_vector_add(
  a : Checkpoint_asyncVector,
  b : Checkpoint_asyncVector,
) -> Checkpoint_asyncVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = checkpoint_async_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn checkpoint_async_vector_sub(
  a : Checkpoint_asyncVector,
  b : Checkpoint_asyncVector,
) -> Checkpoint_asyncVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = checkpoint_async_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn checkpoint_async_vector_scale(
  v : Checkpoint_asyncVector,
  s : Double,
) -> Checkpoint_asyncVector {
  let mut result = []
  for i in 0..<v.dim {
    result = checkpoint_async_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn checkpoint_async_vector_dot(
  a : Checkpoint_asyncVector,
  b : Checkpoint_asyncVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn checkpoint_async_vector_norm(v : Checkpoint_asyncVector) -> Double {
  @_common.sqrt(checkpoint_async_vector_dot(v, v))
}

///|
pub fn checkpoint_async_vector_normalize(
  v : Checkpoint_asyncVector,
) -> Checkpoint_asyncVector {
  let n = checkpoint_async_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    checkpoint_async_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn checkpoint_async_vector_dist(
  a : Checkpoint_asyncVector,
  b : Checkpoint_asyncVector,
) -> Double {
  checkpoint_async_vector_norm(checkpoint_async_vector_sub(a, b))
}

///|
pub fn checkpoint_async_vector_to_string(v : Checkpoint_asyncVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + checkpoint_async_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn checkpoint_async_var(data : Array[Double]) -> Double {
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
pub fn checkpoint_async_std(data : Array[Double]) -> Double {
  @_common.sqrt(checkpoint_async_var(data))
}

///|
pub fn checkpoint_async_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn checkpoint_async_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = checkpoint_async_std(a)
  let sb = checkpoint_async_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    checkpoint_async_cov(a, b) / (sa * sb)
  }
}

///|
pub fn checkpoint_async_accuracy(
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
pub fn checkpoint_async_mse(
  pred : Array[Double],
  labels : Array[Double],
) -> Double {
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
pub fn checkpoint_async_mae(
  pred : Array[Double],
  labels : Array[Double],
) -> Double {
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
pub fn checkpoint_async_r2(
  pred : Array[Double],
  labels : Array[Double],
) -> Double {
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
pub fn checkpoint_async_precision(
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
pub fn checkpoint_async_recall(
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
pub fn checkpoint_async_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = checkpoint_async_precision(pred, labels, pos)
  let r = checkpoint_async_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn checkpoint_async_dbl(x : Double) -> String {
  let i = if x >= 0.0 {
    checkpoint_async_int(x)
  } else {
    -checkpoint_async_int(-x)
  }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    checkpoint_async_int(f * 1000000.0)
  } else {
    checkpoint_async_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn checkpoint_async_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn checkpoint_async_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
