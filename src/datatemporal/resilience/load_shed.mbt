///|
///===
/// datatemporal/load_shed
/// S13.225 new
pub struct Load_shedPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn load_shed_make_point(x : Double, y : Double) -> Load_shedPoint {
  { x, y, label: 0, }
}

///|
pub fn load_shed_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Load_shedPoint {
  { x, y, label, }
}

///|
pub fn load_shed_point_x(p : Load_shedPoint) -> Double {
  p.x
}

///|
pub fn load_shed_point_y(p : Load_shedPoint) -> Double {
  p.y
}

///|
pub fn load_shed_point_label(p : Load_shedPoint) -> Int32 {
  p.label
}

///|
pub fn load_shed_point_dist(a : Load_shedPoint, b : Load_shedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn load_shed_point_add(
  a : Load_shedPoint,
  b : Load_shedPoint,
) -> Load_shedPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn load_shed_point_sub(
  a : Load_shedPoint,
  b : Load_shedPoint,
) -> Load_shedPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn load_shed_point_scale(pt : Load_shedPoint, s : Double) -> Load_shedPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn load_shed_point_dot(a : Load_shedPoint, b : Load_shedPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn load_shed_point_norm(pt : Load_shedPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn load_shed_point_to_string(pt : Load_shedPoint) -> String {
  "(" +
  load_shed_dbl(pt.x) +
  ", " +
  load_shed_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Load_shedSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn load_shed_make_series(
  vals : Array[Double],
  name : String,
) -> Load_shedSeries {
  { vals, name, }
}

///|
pub fn load_shed_series_len(s : Load_shedSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn load_shed_series_sum(s : Load_shedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn load_shed_series_mean(s : Load_shedSeries) -> Double {
  let n = load_shed_series_len(s)
  if n == 0 {
    0.0
  } else {
    load_shed_series_sum(s) / n.to_double()
  }
}

///|
pub fn load_shed_series_min(s : Load_shedSeries) -> Double {
  let n = load_shed_series_len(s)
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
pub fn load_shed_series_max(s : Load_shedSeries) -> Double {
  let n = load_shed_series_len(s)
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
pub fn load_shed_series_var(s : Load_shedSeries) -> Double {
  let n = load_shed_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = load_shed_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn load_shed_series_std(s : Load_shedSeries) -> Double {
  @_common.sqrt(load_shed_series_var(s))
}

///|
pub fn load_shed_series_scale(
  s : Load_shedSeries,
  f : Double,
) -> Load_shedSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = load_shed_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn load_shed_series_add(
  a : Load_shedSeries,
  b : Load_shedSeries,
) -> Load_shedSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = load_shed_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn load_shed_series_to_string(s : Load_shedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + load_shed_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Load_shedMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn load_shed_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Load_shedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn load_shed_matrix_identity(n : Int32) -> Load_shedMatrix {
  let m = load_shed_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn load_shed_matrix_get(
  m : Load_shedMatrix,
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
pub fn load_shed_matrix_transpose(m : Load_shedMatrix) -> Load_shedMatrix {
  let result = load_shed_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn load_shed_matrix_add(
  a : Load_shedMatrix,
  b : Load_shedMatrix,
) -> Load_shedMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = load_shed_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn load_shed_matrix_scale(
  m : Load_shedMatrix,
  s : Double,
) -> Load_shedMatrix {
  let result = load_shed_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn load_shed_matrix_multiply(
  a : Load_shedMatrix,
  b : Load_shedMatrix,
) -> Load_shedMatrix {
  if a.cols != b.rows {
    return load_shed_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = load_shed_make_matrix(a.rows, b.cols, 0.0)
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
pub fn load_shed_matrix_trace(m : Load_shedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn load_shed_matrix_norm(m : Load_shedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn load_shed_matrix_to_string(m : Load_shedMatrix) -> String {
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
      result = result + load_shed_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Load_shedVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn load_shed_make_vector(comps : Array[Double]) -> Load_shedVector {
  { comps, dim: comps.length(), }
}

///|
pub fn load_shed_vector_zero(dim : Int32) -> Load_shedVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn load_shed_vector_add(
  a : Load_shedVector,
  b : Load_shedVector,
) -> Load_shedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = load_shed_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn load_shed_vector_sub(
  a : Load_shedVector,
  b : Load_shedVector,
) -> Load_shedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = load_shed_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn load_shed_vector_scale(
  v : Load_shedVector,
  s : Double,
) -> Load_shedVector {
  let mut result = []
  for i in 0..<v.dim {
    result = load_shed_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn load_shed_vector_dot(a : Load_shedVector, b : Load_shedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn load_shed_vector_norm(v : Load_shedVector) -> Double {
  @_common.sqrt(load_shed_vector_dot(v, v))
}

///|
pub fn load_shed_vector_normalize(v : Load_shedVector) -> Load_shedVector {
  let n = load_shed_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    load_shed_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn load_shed_vector_dist(
  a : Load_shedVector,
  b : Load_shedVector,
) -> Double {
  load_shed_vector_norm(load_shed_vector_sub(a, b))
}

///|
pub fn load_shed_vector_to_string(v : Load_shedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + load_shed_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn load_shed_var(data : Array[Double]) -> Double {
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
pub fn load_shed_std(data : Array[Double]) -> Double {
  @_common.sqrt(load_shed_var(data))
}

///|
pub fn load_shed_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn load_shed_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = load_shed_std(a)
  let sb = load_shed_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    load_shed_cov(a, b) / (sa * sb)
  }
}

///|
pub fn load_shed_accuracy(pred : Array[Int32], labels : Array[Int32]) -> Double {
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
pub fn load_shed_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn load_shed_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn load_shed_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn load_shed_precision(
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
pub fn load_shed_recall(
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
pub fn load_shed_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = load_shed_precision(pred, labels, pos)
  let r = load_shed_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn load_shed_dbl(x : Double) -> String {
  let i = if x >= 0.0 { load_shed_int(x) } else { -load_shed_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    load_shed_int(f * 1000000.0)
  } else {
    load_shed_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn load_shed_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn load_shed_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
