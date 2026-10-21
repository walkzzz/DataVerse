///|
///===
/// agent_kit/smt_solver
/// S13.162 new
pub struct Smt_solverPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn smt_solver_make_point(x : Double, y : Double) -> Smt_solverPoint {
  { x, y, label: 0, }
}

///|
pub fn smt_solver_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Smt_solverPoint {
  { x, y, label, }
}

///|
pub fn smt_solver_point_x(p : Smt_solverPoint) -> Double {
  p.x
}

///|
pub fn smt_solver_point_y(p : Smt_solverPoint) -> Double {
  p.y
}

///|
pub fn smt_solver_point_label(p : Smt_solverPoint) -> Int32 {
  p.label
}

///|
pub fn smt_solver_point_dist(
  a : Smt_solverPoint,
  b : Smt_solverPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn smt_solver_point_add(
  a : Smt_solverPoint,
  b : Smt_solverPoint,
) -> Smt_solverPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn smt_solver_point_sub(
  a : Smt_solverPoint,
  b : Smt_solverPoint,
) -> Smt_solverPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn smt_solver_point_scale(
  pt : Smt_solverPoint,
  s : Double,
) -> Smt_solverPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn smt_solver_point_dot(a : Smt_solverPoint, b : Smt_solverPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn smt_solver_point_norm(pt : Smt_solverPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn smt_solver_point_to_string(pt : Smt_solverPoint) -> String {
  "(" +
  smt_solver_dbl(pt.x) +
  ", " +
  smt_solver_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Smt_solverSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn smt_solver_make_series(
  vals : Array[Double],
  name : String,
) -> Smt_solverSeries {
  { vals, name, }
}

///|
pub fn smt_solver_series_len(s : Smt_solverSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn smt_solver_series_sum(s : Smt_solverSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn smt_solver_series_mean(s : Smt_solverSeries) -> Double {
  let n = smt_solver_series_len(s)
  if n == 0 {
    0.0
  } else {
    smt_solver_series_sum(s) / n.to_double()
  }
}

///|
pub fn smt_solver_series_min(s : Smt_solverSeries) -> Double {
  let n = smt_solver_series_len(s)
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
pub fn smt_solver_series_max(s : Smt_solverSeries) -> Double {
  let n = smt_solver_series_len(s)
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
pub fn smt_solver_series_var(s : Smt_solverSeries) -> Double {
  let n = smt_solver_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = smt_solver_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn smt_solver_series_std(s : Smt_solverSeries) -> Double {
  @_common.sqrt(smt_solver_series_var(s))
}

///|
pub fn smt_solver_series_scale(
  s : Smt_solverSeries,
  f : Double,
) -> Smt_solverSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = smt_solver_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn smt_solver_series_add(
  a : Smt_solverSeries,
  b : Smt_solverSeries,
) -> Smt_solverSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = smt_solver_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn smt_solver_series_to_string(s : Smt_solverSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + smt_solver_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Smt_solverMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn smt_solver_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Smt_solverMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn smt_solver_matrix_identity(n : Int32) -> Smt_solverMatrix {
  let m = smt_solver_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn smt_solver_matrix_get(
  m : Smt_solverMatrix,
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
pub fn smt_solver_matrix_transpose(m : Smt_solverMatrix) -> Smt_solverMatrix {
  let result = smt_solver_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn smt_solver_matrix_add(
  a : Smt_solverMatrix,
  b : Smt_solverMatrix,
) -> Smt_solverMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = smt_solver_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn smt_solver_matrix_scale(
  m : Smt_solverMatrix,
  s : Double,
) -> Smt_solverMatrix {
  let result = smt_solver_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn smt_solver_matrix_multiply(
  a : Smt_solverMatrix,
  b : Smt_solverMatrix,
) -> Smt_solverMatrix {
  if a.cols != b.rows {
    return smt_solver_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = smt_solver_make_matrix(a.rows, b.cols, 0.0)
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
pub fn smt_solver_matrix_trace(m : Smt_solverMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn smt_solver_matrix_norm(m : Smt_solverMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn smt_solver_matrix_to_string(m : Smt_solverMatrix) -> String {
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
      result = result + smt_solver_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Smt_solverVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn smt_solver_make_vector(comps : Array[Double]) -> Smt_solverVector {
  { comps, dim: comps.length(), }
}

///|
pub fn smt_solver_vector_zero(dim : Int32) -> Smt_solverVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn smt_solver_vector_add(
  a : Smt_solverVector,
  b : Smt_solverVector,
) -> Smt_solverVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = smt_solver_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn smt_solver_vector_sub(
  a : Smt_solverVector,
  b : Smt_solverVector,
) -> Smt_solverVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = smt_solver_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn smt_solver_vector_scale(
  v : Smt_solverVector,
  s : Double,
) -> Smt_solverVector {
  let mut result = []
  for i in 0..<v.dim {
    result = smt_solver_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn smt_solver_vector_dot(
  a : Smt_solverVector,
  b : Smt_solverVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn smt_solver_vector_norm(v : Smt_solverVector) -> Double {
  @_common.sqrt(smt_solver_vector_dot(v, v))
}

///|
pub fn smt_solver_vector_normalize(v : Smt_solverVector) -> Smt_solverVector {
  let n = smt_solver_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    smt_solver_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn smt_solver_vector_dist(
  a : Smt_solverVector,
  b : Smt_solverVector,
) -> Double {
  smt_solver_vector_norm(smt_solver_vector_sub(a, b))
}

///|
pub fn smt_solver_vector_to_string(v : Smt_solverVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + smt_solver_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn smt_solver_var(data : Array[Double]) -> Double {
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
pub fn smt_solver_std(data : Array[Double]) -> Double {
  @_common.sqrt(smt_solver_var(data))
}

///|
pub fn smt_solver_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn smt_solver_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = smt_solver_std(a)
  let sb = smt_solver_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    smt_solver_cov(a, b) / (sa * sb)
  }
}

///|
pub fn smt_solver_accuracy(
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
pub fn smt_solver_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn smt_solver_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn smt_solver_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn smt_solver_precision(
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
pub fn smt_solver_recall(
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
pub fn smt_solver_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = smt_solver_precision(pred, labels, pos)
  let r = smt_solver_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn smt_solver_dbl(x : Double) -> String {
  let i = if x >= 0.0 { smt_solver_int(x) } else { -smt_solver_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    smt_solver_int(f * 1000000.0)
  } else {
    smt_solver_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn smt_solver_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn smt_solver_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
