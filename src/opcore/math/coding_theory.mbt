///|
///===
/// opcore/coding_theory
/// S13.24 new
pub struct Coding_theoryPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn coding_theory_coding_theory_make_point(x : Double, y : Double) -> Coding_theoryPoint {
  { x, y, label: 0, }
}

///|
pub fn coding_theory_coding_theory_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Coding_theoryPoint {
  { x, y, label, }
}

///|
pub fn coding_theory_coding_theory_point_x(p : Coding_theoryPoint) -> Double {
  p.x
}

///|
pub fn coding_theory_coding_theory_point_y(p : Coding_theoryPoint) -> Double {
  p.y
}

///|
pub fn coding_theory_coding_theory_point_label(p : Coding_theoryPoint) -> Int32 {
  p.label
}

///|
pub fn coding_theory_coding_theory_point_dist(
  a : Coding_theoryPoint,
  b : Coding_theoryPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn coding_theory_coding_theory_point_add(
  a : Coding_theoryPoint,
  b : Coding_theoryPoint,
) -> Coding_theoryPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn coding_theory_coding_theory_point_sub(
  a : Coding_theoryPoint,
  b : Coding_theoryPoint,
) -> Coding_theoryPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn coding_theory_coding_theory_point_scale(
  pt : Coding_theoryPoint,
  s : Double,
) -> Coding_theoryPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn coding_theory_coding_theory_point_dot(
  a : Coding_theoryPoint,
  b : Coding_theoryPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn coding_theory_coding_theory_point_norm(pt : Coding_theoryPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn coding_theory_coding_theory_point_to_string(pt : Coding_theoryPoint) -> String {
  "(" +
  coding_theory_coding_theory_dbl(pt.x) +
  ", " +
  coding_theory_coding_theory_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Coding_theorySeries {
  vals : Array[Double]
  name : String
}

///|
pub fn coding_theory_coding_theory_make_series(
  vals : Array[Double],
  name : String,
) -> Coding_theorySeries {
  { vals, name, }
}

///|
pub fn coding_theory_coding_theory_series_len(s : Coding_theorySeries) -> Int32 {
  s.vals.length()
}

///|
pub fn coding_theory_coding_theory_series_sum(s : Coding_theorySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn coding_theory_coding_theory_series_mean(s : Coding_theorySeries) -> Double {
  let n = coding_theory_coding_theory_series_len(s)
  if n == 0 {
    0.0
  } else {
    coding_theory_coding_theory_series_sum(s) / n.to_double()
  }
}

///|
pub fn coding_theory_coding_theory_series_min(s : Coding_theorySeries) -> Double {
  let n = coding_theory_coding_theory_series_len(s)
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
pub fn coding_theory_coding_theory_series_max(s : Coding_theorySeries) -> Double {
  let n = coding_theory_coding_theory_series_len(s)
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
pub fn coding_theory_coding_theory_series_var(s : Coding_theorySeries) -> Double {
  let n = coding_theory_coding_theory_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = coding_theory_coding_theory_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn coding_theory_coding_theory_series_std(s : Coding_theorySeries) -> Double {
  @_common.sqrt(coding_theory_coding_theory_series_var(s))
}

///|
pub fn coding_theory_coding_theory_series_scale(
  s : Coding_theorySeries,
  f : Double,
) -> Coding_theorySeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = coding_theory_coding_theory_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn coding_theory_coding_theory_series_add(
  a : Coding_theorySeries,
  b : Coding_theorySeries,
) -> Coding_theorySeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = coding_theory_coding_theory_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn coding_theory_coding_theory_series_to_string(s : Coding_theorySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + coding_theory_coding_theory_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Coding_theoryMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn coding_theory_coding_theory_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Coding_theoryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn coding_theory_coding_theory_matrix_identity(n : Int32) -> Coding_theoryMatrix {
  let m = coding_theory_coding_theory_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn coding_theory_coding_theory_matrix_get(
  m : Coding_theoryMatrix,
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
pub fn coding_theory_coding_theory_matrix_transpose(
  m : Coding_theoryMatrix,
) -> Coding_theoryMatrix {
  let result = coding_theory_coding_theory_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn coding_theory_coding_theory_matrix_add(
  a : Coding_theoryMatrix,
  b : Coding_theoryMatrix,
) -> Coding_theoryMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = coding_theory_coding_theory_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn coding_theory_coding_theory_matrix_scale(
  m : Coding_theoryMatrix,
  s : Double,
) -> Coding_theoryMatrix {
  let result = coding_theory_coding_theory_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn coding_theory_coding_theory_matrix_multiply(
  a : Coding_theoryMatrix,
  b : Coding_theoryMatrix,
) -> Coding_theoryMatrix {
  if a.cols != b.rows {
    return coding_theory_coding_theory_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = coding_theory_coding_theory_make_matrix(a.rows, b.cols, 0.0)
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
pub fn coding_theory_coding_theory_matrix_trace(m : Coding_theoryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn coding_theory_coding_theory_matrix_norm(m : Coding_theoryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn coding_theory_coding_theory_matrix_to_string(m : Coding_theoryMatrix) -> String {
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
      result = result + coding_theory_coding_theory_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Coding_theoryVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn coding_theory_coding_theory_make_vector(comps : Array[Double]) -> Coding_theoryVector {
  { comps, dim: comps.length(), }
}

///|
pub fn coding_theory_coding_theory_vector_zero(dim : Int32) -> Coding_theoryVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn coding_theory_coding_theory_vector_add(
  a : Coding_theoryVector,
  b : Coding_theoryVector,
) -> Coding_theoryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = coding_theory_coding_theory_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn coding_theory_coding_theory_vector_sub(
  a : Coding_theoryVector,
  b : Coding_theoryVector,
) -> Coding_theoryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = coding_theory_coding_theory_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn coding_theory_coding_theory_vector_scale(
  v : Coding_theoryVector,
  s : Double,
) -> Coding_theoryVector {
  let mut result = []
  for i in 0..<v.dim {
    result = coding_theory_coding_theory_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn coding_theory_coding_theory_vector_dot(
  a : Coding_theoryVector,
  b : Coding_theoryVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn coding_theory_coding_theory_vector_norm(v : Coding_theoryVector) -> Double {
  @_common.sqrt(coding_theory_coding_theory_vector_dot(v, v))
}

///|
pub fn coding_theory_coding_theory_vector_normalize(
  v : Coding_theoryVector,
) -> Coding_theoryVector {
  let n = coding_theory_coding_theory_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    coding_theory_coding_theory_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn coding_theory_coding_theory_vector_dist(
  a : Coding_theoryVector,
  b : Coding_theoryVector,
) -> Double {
  coding_theory_coding_theory_vector_norm(coding_theory_coding_theory_vector_sub(a, b))
}

///|
pub fn coding_theory_coding_theory_vector_to_string(v : Coding_theoryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + coding_theory_coding_theory_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn coding_theory_coding_theory_var(data : Array[Double]) -> Double {
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
pub fn coding_theory_coding_theory_std(data : Array[Double]) -> Double {
  @_common.sqrt(coding_theory_coding_theory_var(data))
}

///|
pub fn coding_theory_coding_theory_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn coding_theory_coding_theory_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = coding_theory_coding_theory_std(a)
  let sb = coding_theory_coding_theory_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    coding_theory_coding_theory_cov(a, b) / (sa * sb)
  }
}

///|
pub fn coding_theory_coding_theory_accuracy(
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
pub fn coding_theory_coding_theory_mse(
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
pub fn coding_theory_coding_theory_mae(
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
pub fn coding_theory_coding_theory_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn coding_theory_coding_theory_precision(
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
pub fn coding_theory_coding_theory_recall(
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
pub fn coding_theory_coding_theory_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = coding_theory_coding_theory_precision(pred, labels, pos)
  let r = coding_theory_coding_theory_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn coding_theory_coding_theory_dbl(x : Double) -> String {
  let i = if x >= 0.0 { coding_theory_coding_theory_int(x) } else { -coding_theory_coding_theory_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    coding_theory_coding_theory_int(f * 1000000.0)
  } else {
    coding_theory_coding_theory_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn coding_theory_coding_theory_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn coding_theory_coding_theory_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
