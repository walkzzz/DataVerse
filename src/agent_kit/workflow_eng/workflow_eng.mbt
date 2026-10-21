///|
///===
/// agent_kit/workflow_eng
/// S13.155 new
pub struct Workflow_engPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn workflow_eng_make_point(x : Double, y : Double) -> Workflow_engPoint {
  { x, y, label: 0, }
}

///|
pub fn workflow_eng_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Workflow_engPoint {
  { x, y, label, }
}

///|
pub fn workflow_eng_point_x(p : Workflow_engPoint) -> Double {
  p.x
}

///|
pub fn workflow_eng_point_y(p : Workflow_engPoint) -> Double {
  p.y
}

///|
pub fn workflow_eng_point_label(p : Workflow_engPoint) -> Int32 {
  p.label
}

///|
pub fn workflow_eng_point_dist(
  a : Workflow_engPoint,
  b : Workflow_engPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn workflow_eng_point_add(
  a : Workflow_engPoint,
  b : Workflow_engPoint,
) -> Workflow_engPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn workflow_eng_point_sub(
  a : Workflow_engPoint,
  b : Workflow_engPoint,
) -> Workflow_engPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn workflow_eng_point_scale(
  pt : Workflow_engPoint,
  s : Double,
) -> Workflow_engPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn workflow_eng_point_dot(
  a : Workflow_engPoint,
  b : Workflow_engPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn workflow_eng_point_norm(pt : Workflow_engPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn workflow_eng_point_to_string(pt : Workflow_engPoint) -> String {
  "(" +
  workflow_eng_dbl(pt.x) +
  ", " +
  workflow_eng_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Workflow_engSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn workflow_eng_make_series(
  vals : Array[Double],
  name : String,
) -> Workflow_engSeries {
  { vals, name, }
}

///|
pub fn workflow_eng_series_len(s : Workflow_engSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn workflow_eng_series_sum(s : Workflow_engSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn workflow_eng_series_mean(s : Workflow_engSeries) -> Double {
  let n = workflow_eng_series_len(s)
  if n == 0 {
    0.0
  } else {
    workflow_eng_series_sum(s) / n.to_double()
  }
}

///|
pub fn workflow_eng_series_min(s : Workflow_engSeries) -> Double {
  let n = workflow_eng_series_len(s)
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
pub fn workflow_eng_series_max(s : Workflow_engSeries) -> Double {
  let n = workflow_eng_series_len(s)
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
pub fn workflow_eng_series_var(s : Workflow_engSeries) -> Double {
  let n = workflow_eng_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = workflow_eng_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn workflow_eng_series_std(s : Workflow_engSeries) -> Double {
  @_common.sqrt(workflow_eng_series_var(s))
}

///|
pub fn workflow_eng_series_scale(
  s : Workflow_engSeries,
  f : Double,
) -> Workflow_engSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = workflow_eng_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn workflow_eng_series_add(
  a : Workflow_engSeries,
  b : Workflow_engSeries,
) -> Workflow_engSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = workflow_eng_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn workflow_eng_series_to_string(s : Workflow_engSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + workflow_eng_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Workflow_engMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn workflow_eng_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Workflow_engMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn workflow_eng_matrix_identity(n : Int32) -> Workflow_engMatrix {
  let m = workflow_eng_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn workflow_eng_matrix_get(
  m : Workflow_engMatrix,
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
pub fn workflow_eng_matrix_transpose(
  m : Workflow_engMatrix,
) -> Workflow_engMatrix {
  let result = workflow_eng_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn workflow_eng_matrix_add(
  a : Workflow_engMatrix,
  b : Workflow_engMatrix,
) -> Workflow_engMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = workflow_eng_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn workflow_eng_matrix_scale(
  m : Workflow_engMatrix,
  s : Double,
) -> Workflow_engMatrix {
  let result = workflow_eng_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn workflow_eng_matrix_multiply(
  a : Workflow_engMatrix,
  b : Workflow_engMatrix,
) -> Workflow_engMatrix {
  if a.cols != b.rows {
    return workflow_eng_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = workflow_eng_make_matrix(a.rows, b.cols, 0.0)
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
pub fn workflow_eng_matrix_trace(m : Workflow_engMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn workflow_eng_matrix_norm(m : Workflow_engMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn workflow_eng_matrix_to_string(m : Workflow_engMatrix) -> String {
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
      result = result + workflow_eng_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Workflow_engVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn workflow_eng_make_vector(comps : Array[Double]) -> Workflow_engVector {
  { comps, dim: comps.length(), }
}

///|
pub fn workflow_eng_vector_zero(dim : Int32) -> Workflow_engVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn workflow_eng_vector_add(
  a : Workflow_engVector,
  b : Workflow_engVector,
) -> Workflow_engVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = workflow_eng_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn workflow_eng_vector_sub(
  a : Workflow_engVector,
  b : Workflow_engVector,
) -> Workflow_engVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = workflow_eng_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn workflow_eng_vector_scale(
  v : Workflow_engVector,
  s : Double,
) -> Workflow_engVector {
  let mut result = []
  for i in 0..<v.dim {
    result = workflow_eng_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn workflow_eng_vector_dot(
  a : Workflow_engVector,
  b : Workflow_engVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn workflow_eng_vector_norm(v : Workflow_engVector) -> Double {
  @_common.sqrt(workflow_eng_vector_dot(v, v))
}

///|
pub fn workflow_eng_vector_normalize(
  v : Workflow_engVector,
) -> Workflow_engVector {
  let n = workflow_eng_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    workflow_eng_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn workflow_eng_vector_dist(
  a : Workflow_engVector,
  b : Workflow_engVector,
) -> Double {
  workflow_eng_vector_norm(workflow_eng_vector_sub(a, b))
}

///|
pub fn workflow_eng_vector_to_string(v : Workflow_engVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + workflow_eng_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn workflow_eng_var(data : Array[Double]) -> Double {
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
pub fn workflow_eng_std(data : Array[Double]) -> Double {
  @_common.sqrt(workflow_eng_var(data))
}

///|
pub fn workflow_eng_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn workflow_eng_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = workflow_eng_std(a)
  let sb = workflow_eng_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    workflow_eng_cov(a, b) / (sa * sb)
  }
}

///|
pub fn workflow_eng_accuracy(
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
pub fn workflow_eng_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn workflow_eng_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn workflow_eng_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn workflow_eng_precision(
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
pub fn workflow_eng_recall(
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
pub fn workflow_eng_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = workflow_eng_precision(pred, labels, pos)
  let r = workflow_eng_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn workflow_eng_dbl(x : Double) -> String {
  let i = if x >= 0.0 { workflow_eng_int(x) } else { -workflow_eng_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    workflow_eng_int(f * 1000000.0)
  } else {
    workflow_eng_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn workflow_eng_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn workflow_eng_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
