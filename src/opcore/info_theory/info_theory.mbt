///|
///===
/// opcore/info_theory
/// S13.23 new
pub struct Info_theoryPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn info_theory_make_point(x : Double, y : Double) -> Info_theoryPoint {
  { x, y, label: 0, }
}

///|
pub fn info_theory_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Info_theoryPoint {
  { x, y, label, }
}

///|
pub fn info_theory_point_x(p : Info_theoryPoint) -> Double {
  p.x
}

///|
pub fn info_theory_point_y(p : Info_theoryPoint) -> Double {
  p.y
}

///|
pub fn info_theory_point_label(p : Info_theoryPoint) -> Int32 {
  p.label
}

///|
pub fn info_theory_point_dist(
  a : Info_theoryPoint,
  b : Info_theoryPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn info_theory_point_add(
  a : Info_theoryPoint,
  b : Info_theoryPoint,
) -> Info_theoryPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn info_theory_point_sub(
  a : Info_theoryPoint,
  b : Info_theoryPoint,
) -> Info_theoryPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn info_theory_point_scale(
  pt : Info_theoryPoint,
  s : Double,
) -> Info_theoryPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn info_theory_point_dot(
  a : Info_theoryPoint,
  b : Info_theoryPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn info_theory_point_norm(pt : Info_theoryPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn info_theory_point_to_string(pt : Info_theoryPoint) -> String {
  "(" +
  info_theory_dbl(pt.x) +
  ", " +
  info_theory_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Info_theorySeries {
  vals : Array[Double]
  name : String
}

///|
pub fn info_theory_make_series(
  vals : Array[Double],
  name : String,
) -> Info_theorySeries {
  { vals, name, }
}

///|
pub fn info_theory_series_len(s : Info_theorySeries) -> Int32 {
  s.vals.length()
}

///|
pub fn info_theory_series_sum(s : Info_theorySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn info_theory_series_mean(s : Info_theorySeries) -> Double {
  let n = info_theory_series_len(s)
  if n == 0 {
    0.0
  } else {
    info_theory_series_sum(s) / n.to_double()
  }
}

///|
pub fn info_theory_series_min(s : Info_theorySeries) -> Double {
  let n = info_theory_series_len(s)
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
pub fn info_theory_series_max(s : Info_theorySeries) -> Double {
  let n = info_theory_series_len(s)
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
pub fn info_theory_series_var(s : Info_theorySeries) -> Double {
  let n = info_theory_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = info_theory_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn info_theory_series_std(s : Info_theorySeries) -> Double {
  @_common.sqrt(info_theory_series_var(s))
}

///|
pub fn info_theory_series_scale(
  s : Info_theorySeries,
  f : Double,
) -> Info_theorySeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = info_theory_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn info_theory_series_add(
  a : Info_theorySeries,
  b : Info_theorySeries,
) -> Info_theorySeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = info_theory_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn info_theory_series_to_string(s : Info_theorySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + info_theory_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Info_theoryMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn info_theory_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Info_theoryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn info_theory_matrix_identity(n : Int32) -> Info_theoryMatrix {
  let m = info_theory_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn info_theory_matrix_get(
  m : Info_theoryMatrix,
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
pub fn info_theory_matrix_transpose(m : Info_theoryMatrix) -> Info_theoryMatrix {
  let result = info_theory_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn info_theory_matrix_add(
  a : Info_theoryMatrix,
  b : Info_theoryMatrix,
) -> Info_theoryMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = info_theory_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn info_theory_matrix_scale(
  m : Info_theoryMatrix,
  s : Double,
) -> Info_theoryMatrix {
  let result = info_theory_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn info_theory_matrix_multiply(
  a : Info_theoryMatrix,
  b : Info_theoryMatrix,
) -> Info_theoryMatrix {
  if a.cols != b.rows {
    return info_theory_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = info_theory_make_matrix(a.rows, b.cols, 0.0)
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
pub fn info_theory_matrix_trace(m : Info_theoryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn info_theory_matrix_norm(m : Info_theoryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn info_theory_matrix_to_string(m : Info_theoryMatrix) -> String {
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
      result = result + info_theory_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Info_theoryVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn info_theory_make_vector(comps : Array[Double]) -> Info_theoryVector {
  { comps, dim: comps.length(), }
}

///|
pub fn info_theory_vector_zero(dim : Int32) -> Info_theoryVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn info_theory_vector_add(
  a : Info_theoryVector,
  b : Info_theoryVector,
) -> Info_theoryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = info_theory_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn info_theory_vector_sub(
  a : Info_theoryVector,
  b : Info_theoryVector,
) -> Info_theoryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = info_theory_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn info_theory_vector_scale(
  v : Info_theoryVector,
  s : Double,
) -> Info_theoryVector {
  let mut result = []
  for i in 0..<v.dim {
    result = info_theory_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn info_theory_vector_dot(
  a : Info_theoryVector,
  b : Info_theoryVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn info_theory_vector_norm(v : Info_theoryVector) -> Double {
  @_common.sqrt(info_theory_vector_dot(v, v))
}

///|
pub fn info_theory_vector_normalize(v : Info_theoryVector) -> Info_theoryVector {
  let n = info_theory_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    info_theory_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn info_theory_vector_dist(
  a : Info_theoryVector,
  b : Info_theoryVector,
) -> Double {
  info_theory_vector_norm(info_theory_vector_sub(a, b))
}

///|
pub fn info_theory_vector_to_string(v : Info_theoryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + info_theory_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn info_theory_var(data : Array[Double]) -> Double {
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
pub fn info_theory_std(data : Array[Double]) -> Double {
  @_common.sqrt(info_theory_var(data))
}

///|
pub fn info_theory_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn info_theory_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = info_theory_std(a)
  let sb = info_theory_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    info_theory_cov(a, b) / (sa * sb)
  }
}

///|
pub fn info_theory_accuracy(
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
pub fn info_theory_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn info_theory_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn info_theory_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn info_theory_precision(
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
pub fn info_theory_recall(
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
pub fn info_theory_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = info_theory_precision(pred, labels, pos)
  let r = info_theory_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn info_theory_dbl(x : Double) -> String {
  let i = if x >= 0.0 { info_theory_int(x) } else { -info_theory_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    info_theory_int(f * 1000000.0)
  } else {
    info_theory_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn info_theory_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn info_theory_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
