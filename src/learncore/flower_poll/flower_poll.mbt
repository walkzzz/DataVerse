///|
///===
/// learncore/flower_poll
/// S13.78 new
pub struct Flower_pollPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn flower_poll_make_point(x : Double, y : Double) -> Flower_pollPoint {
  { x, y, label: 0, }
}

///|
pub fn flower_poll_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Flower_pollPoint {
  { x, y, label, }
}

///|
pub fn flower_poll_point_x(p : Flower_pollPoint) -> Double {
  p.x
}

///|
pub fn flower_poll_point_y(p : Flower_pollPoint) -> Double {
  p.y
}

///|
pub fn flower_poll_point_label(p : Flower_pollPoint) -> Int32 {
  p.label
}

///|
pub fn flower_poll_point_dist(
  a : Flower_pollPoint,
  b : Flower_pollPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn flower_poll_point_add(
  a : Flower_pollPoint,
  b : Flower_pollPoint,
) -> Flower_pollPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn flower_poll_point_sub(
  a : Flower_pollPoint,
  b : Flower_pollPoint,
) -> Flower_pollPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn flower_poll_point_scale(
  pt : Flower_pollPoint,
  s : Double,
) -> Flower_pollPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn flower_poll_point_dot(
  a : Flower_pollPoint,
  b : Flower_pollPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn flower_poll_point_norm(pt : Flower_pollPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn flower_poll_point_to_string(pt : Flower_pollPoint) -> String {
  "(" +
  flower_poll_dbl(pt.x) +
  ", " +
  flower_poll_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Flower_pollSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn flower_poll_make_series(
  vals : Array[Double],
  name : String,
) -> Flower_pollSeries {
  { vals, name, }
}

///|
pub fn flower_poll_series_len(s : Flower_pollSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn flower_poll_series_sum(s : Flower_pollSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn flower_poll_series_mean(s : Flower_pollSeries) -> Double {
  let n = flower_poll_series_len(s)
  if n == 0 {
    0.0
  } else {
    flower_poll_series_sum(s) / n.to_double()
  }
}

///|
pub fn flower_poll_series_min(s : Flower_pollSeries) -> Double {
  let n = flower_poll_series_len(s)
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
pub fn flower_poll_series_max(s : Flower_pollSeries) -> Double {
  let n = flower_poll_series_len(s)
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
pub fn flower_poll_series_var(s : Flower_pollSeries) -> Double {
  let n = flower_poll_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = flower_poll_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn flower_poll_series_std(s : Flower_pollSeries) -> Double {
  @_common.sqrt(flower_poll_series_var(s))
}

///|
pub fn flower_poll_series_scale(
  s : Flower_pollSeries,
  f : Double,
) -> Flower_pollSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = flower_poll_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn flower_poll_series_add(
  a : Flower_pollSeries,
  b : Flower_pollSeries,
) -> Flower_pollSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = flower_poll_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn flower_poll_series_to_string(s : Flower_pollSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + flower_poll_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Flower_pollMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn flower_poll_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Flower_pollMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn flower_poll_matrix_identity(n : Int32) -> Flower_pollMatrix {
  let m = flower_poll_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn flower_poll_matrix_get(
  m : Flower_pollMatrix,
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
pub fn flower_poll_matrix_transpose(m : Flower_pollMatrix) -> Flower_pollMatrix {
  let result = flower_poll_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn flower_poll_matrix_add(
  a : Flower_pollMatrix,
  b : Flower_pollMatrix,
) -> Flower_pollMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = flower_poll_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn flower_poll_matrix_scale(
  m : Flower_pollMatrix,
  s : Double,
) -> Flower_pollMatrix {
  let result = flower_poll_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn flower_poll_matrix_multiply(
  a : Flower_pollMatrix,
  b : Flower_pollMatrix,
) -> Flower_pollMatrix {
  if a.cols != b.rows {
    return flower_poll_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = flower_poll_make_matrix(a.rows, b.cols, 0.0)
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
pub fn flower_poll_matrix_trace(m : Flower_pollMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn flower_poll_matrix_norm(m : Flower_pollMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn flower_poll_matrix_to_string(m : Flower_pollMatrix) -> String {
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
      result = result + flower_poll_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Flower_pollVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn flower_poll_make_vector(comps : Array[Double]) -> Flower_pollVector {
  { comps, dim: comps.length(), }
}

///|
pub fn flower_poll_vector_zero(dim : Int32) -> Flower_pollVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn flower_poll_vector_add(
  a : Flower_pollVector,
  b : Flower_pollVector,
) -> Flower_pollVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = flower_poll_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn flower_poll_vector_sub(
  a : Flower_pollVector,
  b : Flower_pollVector,
) -> Flower_pollVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = flower_poll_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn flower_poll_vector_scale(
  v : Flower_pollVector,
  s : Double,
) -> Flower_pollVector {
  let mut result = []
  for i in 0..<v.dim {
    result = flower_poll_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn flower_poll_vector_dot(
  a : Flower_pollVector,
  b : Flower_pollVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn flower_poll_vector_norm(v : Flower_pollVector) -> Double {
  @_common.sqrt(flower_poll_vector_dot(v, v))
}

///|
pub fn flower_poll_vector_normalize(v : Flower_pollVector) -> Flower_pollVector {
  let n = flower_poll_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    flower_poll_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn flower_poll_vector_dist(
  a : Flower_pollVector,
  b : Flower_pollVector,
) -> Double {
  flower_poll_vector_norm(flower_poll_vector_sub(a, b))
}

///|
pub fn flower_poll_vector_to_string(v : Flower_pollVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + flower_poll_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn flower_poll_var(data : Array[Double]) -> Double {
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
pub fn flower_poll_std(data : Array[Double]) -> Double {
  @_common.sqrt(flower_poll_var(data))
}

///|
pub fn flower_poll_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn flower_poll_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = flower_poll_std(a)
  let sb = flower_poll_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    flower_poll_cov(a, b) / (sa * sb)
  }
}

///|
pub fn flower_poll_accuracy(
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
pub fn flower_poll_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn flower_poll_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn flower_poll_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn flower_poll_precision(
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
pub fn flower_poll_recall(
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
pub fn flower_poll_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = flower_poll_precision(pred, labels, pos)
  let r = flower_poll_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn flower_poll_dbl(x : Double) -> String {
  let i = if x >= 0.0 { flower_poll_int(x) } else { -flower_poll_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    flower_poll_int(f * 1000000.0)
  } else {
    flower_poll_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn flower_poll_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn flower_poll_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
