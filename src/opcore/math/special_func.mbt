///|
///===
/// opcore/special_func
/// S13.5 new
pub struct Special_funcPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn special_func_special_func_make_point(x : Double, y : Double) -> Special_funcPoint {
  { x, y, label: 0, }
}

///|
pub fn special_func_special_func_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Special_funcPoint {
  { x, y, label, }
}

///|
pub fn special_func_special_func_point_x(p : Special_funcPoint) -> Double {
  p.x
}

///|
pub fn special_func_special_func_point_y(p : Special_funcPoint) -> Double {
  p.y
}

///|
pub fn special_func_special_func_point_label(p : Special_funcPoint) -> Int32 {
  p.label
}

///|
pub fn special_func_special_func_point_dist(
  a : Special_funcPoint,
  b : Special_funcPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn special_func_special_func_point_add(
  a : Special_funcPoint,
  b : Special_funcPoint,
) -> Special_funcPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn special_func_special_func_point_sub(
  a : Special_funcPoint,
  b : Special_funcPoint,
) -> Special_funcPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn special_func_special_func_point_scale(
  pt : Special_funcPoint,
  s : Double,
) -> Special_funcPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn special_func_special_func_point_dot(
  a : Special_funcPoint,
  b : Special_funcPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn special_func_special_func_point_norm(pt : Special_funcPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn special_func_special_func_point_to_string(pt : Special_funcPoint) -> String {
  "(" +
  special_func_special_func_dbl(pt.x) +
  ", " +
  special_func_special_func_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Special_funcSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn special_func_special_func_make_series(
  vals : Array[Double],
  name : String,
) -> Special_funcSeries {
  { vals, name, }
}

///|
pub fn special_func_special_func_series_len(s : Special_funcSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn special_func_special_func_series_sum(s : Special_funcSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn special_func_special_func_series_mean(s : Special_funcSeries) -> Double {
  let n = special_func_special_func_series_len(s)
  if n == 0 {
    0.0
  } else {
    special_func_special_func_series_sum(s) / n.to_double()
  }
}

///|
pub fn special_func_special_func_series_min(s : Special_funcSeries) -> Double {
  let n = special_func_special_func_series_len(s)
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
pub fn special_func_special_func_series_max(s : Special_funcSeries) -> Double {
  let n = special_func_special_func_series_len(s)
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
pub fn special_func_special_func_series_var(s : Special_funcSeries) -> Double {
  let n = special_func_special_func_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = special_func_special_func_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn special_func_special_func_series_std(s : Special_funcSeries) -> Double {
  @_common.sqrt(special_func_special_func_series_var(s))
}

///|
pub fn special_func_special_func_series_scale(
  s : Special_funcSeries,
  f : Double,
) -> Special_funcSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = special_func_special_func_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn special_func_special_func_series_add(
  a : Special_funcSeries,
  b : Special_funcSeries,
) -> Special_funcSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = special_func_special_func_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn special_func_special_func_series_to_string(s : Special_funcSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + special_func_special_func_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Special_funcMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn special_func_special_func_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Special_funcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn special_func_special_func_matrix_identity(n : Int32) -> Special_funcMatrix {
  let m = special_func_special_func_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn special_func_special_func_matrix_get(
  m : Special_funcMatrix,
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
pub fn special_func_special_func_matrix_transpose(
  m : Special_funcMatrix,
) -> Special_funcMatrix {
  let result = special_func_special_func_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn special_func_special_func_matrix_add(
  a : Special_funcMatrix,
  b : Special_funcMatrix,
) -> Special_funcMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = special_func_special_func_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn special_func_special_func_matrix_scale(
  m : Special_funcMatrix,
  s : Double,
) -> Special_funcMatrix {
  let result = special_func_special_func_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn special_func_special_func_matrix_multiply(
  a : Special_funcMatrix,
  b : Special_funcMatrix,
) -> Special_funcMatrix {
  if a.cols != b.rows {
    return special_func_special_func_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = special_func_special_func_make_matrix(a.rows, b.cols, 0.0)
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
pub fn special_func_special_func_matrix_trace(m : Special_funcMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn special_func_special_func_matrix_norm(m : Special_funcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn special_func_special_func_matrix_to_string(m : Special_funcMatrix) -> String {
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
      result = result + special_func_special_func_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Special_funcVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn special_func_special_func_make_vector(comps : Array[Double]) -> Special_funcVector {
  { comps, dim: comps.length(), }
}

///|
pub fn special_func_special_func_vector_zero(dim : Int32) -> Special_funcVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn special_func_special_func_vector_add(
  a : Special_funcVector,
  b : Special_funcVector,
) -> Special_funcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = special_func_special_func_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn special_func_special_func_vector_sub(
  a : Special_funcVector,
  b : Special_funcVector,
) -> Special_funcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = special_func_special_func_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn special_func_special_func_vector_scale(
  v : Special_funcVector,
  s : Double,
) -> Special_funcVector {
  let mut result = []
  for i in 0..<v.dim {
    result = special_func_special_func_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn special_func_special_func_vector_dot(
  a : Special_funcVector,
  b : Special_funcVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn special_func_special_func_vector_norm(v : Special_funcVector) -> Double {
  @_common.sqrt(special_func_special_func_vector_dot(v, v))
}

///|
pub fn special_func_special_func_vector_normalize(
  v : Special_funcVector,
) -> Special_funcVector {
  let n = special_func_special_func_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    special_func_special_func_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn special_func_special_func_vector_dist(
  a : Special_funcVector,
  b : Special_funcVector,
) -> Double {
  special_func_special_func_vector_norm(special_func_special_func_vector_sub(a, b))
}

///|
pub fn special_func_special_func_vector_to_string(v : Special_funcVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + special_func_special_func_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn special_func_special_func_var(data : Array[Double]) -> Double {
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
pub fn special_func_special_func_std(data : Array[Double]) -> Double {
  @_common.sqrt(special_func_special_func_var(data))
}

///|
pub fn special_func_special_func_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn special_func_special_func_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = special_func_special_func_std(a)
  let sb = special_func_special_func_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    special_func_special_func_cov(a, b) / (sa * sb)
  }
}

///|
pub fn special_func_special_func_accuracy(
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
pub fn special_func_special_func_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn special_func_special_func_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn special_func_special_func_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn special_func_special_func_precision(
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
pub fn special_func_special_func_recall(
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
pub fn special_func_special_func_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = special_func_special_func_precision(pred, labels, pos)
  let r = special_func_special_func_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn special_func_special_func_dbl(x : Double) -> String {
  let i = if x >= 0.0 { special_func_special_func_int(x) } else { -special_func_special_func_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    special_func_special_func_int(f * 1000000.0)
  } else {
    special_func_special_func_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn special_func_special_func_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn special_func_special_func_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
