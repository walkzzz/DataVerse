///|
///===
/// opcore/cross_corr
/// S13.33 new
pub struct Cross_corrPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn cross_corr_make_point(x : Double, y : Double) -> Cross_corrPoint {
  { x, y, label: 0, }
}

///|
pub fn cross_corr_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Cross_corrPoint {
  { x, y, label, }
}

///|
pub fn cross_corr_point_x(p : Cross_corrPoint) -> Double {
  p.x
}

///|
pub fn cross_corr_point_y(p : Cross_corrPoint) -> Double {
  p.y
}

///|
pub fn cross_corr_point_label(p : Cross_corrPoint) -> Int32 {
  p.label
}

///|
pub fn cross_corr_point_dist(
  a : Cross_corrPoint,
  b : Cross_corrPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn cross_corr_point_add(
  a : Cross_corrPoint,
  b : Cross_corrPoint,
) -> Cross_corrPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn cross_corr_point_sub(
  a : Cross_corrPoint,
  b : Cross_corrPoint,
) -> Cross_corrPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn cross_corr_point_scale(
  pt : Cross_corrPoint,
  s : Double,
) -> Cross_corrPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn cross_corr_point_dot(a : Cross_corrPoint, b : Cross_corrPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn cross_corr_point_norm(pt : Cross_corrPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn cross_corr_point_to_string(pt : Cross_corrPoint) -> String {
  "(" +
  cross_corr_dbl(pt.x) +
  ", " +
  cross_corr_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Cross_corrSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn cross_corr_make_series(
  vals : Array[Double],
  name : String,
) -> Cross_corrSeries {
  { vals, name, }
}

///|
pub fn cross_corr_series_len(s : Cross_corrSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn cross_corr_series_sum(s : Cross_corrSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn cross_corr_series_mean(s : Cross_corrSeries) -> Double {
  let n = cross_corr_series_len(s)
  if n == 0 {
    0.0
  } else {
    cross_corr_series_sum(s) / n.to_double()
  }
}

///|
pub fn cross_corr_series_min(s : Cross_corrSeries) -> Double {
  let n = cross_corr_series_len(s)
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
pub fn cross_corr_series_max(s : Cross_corrSeries) -> Double {
  let n = cross_corr_series_len(s)
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
pub fn cross_corr_series_var(s : Cross_corrSeries) -> Double {
  let n = cross_corr_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = cross_corr_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn cross_corr_series_std(s : Cross_corrSeries) -> Double {
  @_common.sqrt(cross_corr_series_var(s))
}

///|
pub fn cross_corr_series_scale(
  s : Cross_corrSeries,
  f : Double,
) -> Cross_corrSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = cross_corr_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn cross_corr_series_add(
  a : Cross_corrSeries,
  b : Cross_corrSeries,
) -> Cross_corrSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = cross_corr_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn cross_corr_series_to_string(s : Cross_corrSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + cross_corr_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Cross_corrMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn cross_corr_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Cross_corrMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn cross_corr_matrix_identity(n : Int32) -> Cross_corrMatrix {
  let m = cross_corr_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn cross_corr_matrix_get(
  m : Cross_corrMatrix,
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
pub fn cross_corr_matrix_transpose(m : Cross_corrMatrix) -> Cross_corrMatrix {
  let result = cross_corr_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn cross_corr_matrix_add(
  a : Cross_corrMatrix,
  b : Cross_corrMatrix,
) -> Cross_corrMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = cross_corr_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn cross_corr_matrix_scale(
  m : Cross_corrMatrix,
  s : Double,
) -> Cross_corrMatrix {
  let result = cross_corr_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn cross_corr_matrix_multiply(
  a : Cross_corrMatrix,
  b : Cross_corrMatrix,
) -> Cross_corrMatrix {
  if a.cols != b.rows {
    return cross_corr_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = cross_corr_make_matrix(a.rows, b.cols, 0.0)
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
pub fn cross_corr_matrix_trace(m : Cross_corrMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn cross_corr_matrix_norm(m : Cross_corrMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn cross_corr_matrix_to_string(m : Cross_corrMatrix) -> String {
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
      result = result + cross_corr_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Cross_corrVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn cross_corr_make_vector(comps : Array[Double]) -> Cross_corrVector {
  { comps, dim: comps.length(), }
}

///|
pub fn cross_corr_vector_zero(dim : Int32) -> Cross_corrVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn cross_corr_vector_add(
  a : Cross_corrVector,
  b : Cross_corrVector,
) -> Cross_corrVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = cross_corr_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn cross_corr_vector_sub(
  a : Cross_corrVector,
  b : Cross_corrVector,
) -> Cross_corrVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = cross_corr_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn cross_corr_vector_scale(
  v : Cross_corrVector,
  s : Double,
) -> Cross_corrVector {
  let mut result = []
  for i in 0..<v.dim {
    result = cross_corr_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn cross_corr_vector_dot(
  a : Cross_corrVector,
  b : Cross_corrVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn cross_corr_vector_norm(v : Cross_corrVector) -> Double {
  @_common.sqrt(cross_corr_vector_dot(v, v))
}

///|
pub fn cross_corr_vector_normalize(v : Cross_corrVector) -> Cross_corrVector {
  let n = cross_corr_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    cross_corr_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn cross_corr_vector_dist(
  a : Cross_corrVector,
  b : Cross_corrVector,
) -> Double {
  cross_corr_vector_norm(cross_corr_vector_sub(a, b))
}

///|
pub fn cross_corr_vector_to_string(v : Cross_corrVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + cross_corr_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn cross_corr_var(data : Array[Double]) -> Double {
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
pub fn cross_corr_std(data : Array[Double]) -> Double {
  @_common.sqrt(cross_corr_var(data))
}

///|
pub fn cross_corr_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn cross_corr_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = cross_corr_std(a)
  let sb = cross_corr_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    cross_corr_cov(a, b) / (sa * sb)
  }
}

///|
pub fn cross_corr_accuracy(
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
pub fn cross_corr_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn cross_corr_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn cross_corr_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn cross_corr_precision(
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
pub fn cross_corr_recall(
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
pub fn cross_corr_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = cross_corr_precision(pred, labels, pos)
  let r = cross_corr_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn cross_corr_dbl(x : Double) -> String {
  let i = if x >= 0.0 { cross_corr_int(x) } else { -cross_corr_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    cross_corr_int(f * 1000000.0)
  } else {
    cross_corr_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn cross_corr_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn cross_corr_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
