///|
///===
/// opcore/z_transform
/// S13.11 new
pub struct Z_transformPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn z_transform_z_transform_make_point(x : Double, y : Double) -> Z_transformPoint {
  { x, y, label: 0, }
}

///|
pub fn z_transform_z_transform_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Z_transformPoint {
  { x, y, label, }
}

///|
pub fn z_transform_z_transform_point_x(p : Z_transformPoint) -> Double {
  p.x
}

///|
pub fn z_transform_z_transform_point_y(p : Z_transformPoint) -> Double {
  p.y
}

///|
pub fn z_transform_z_transform_point_label(p : Z_transformPoint) -> Int32 {
  p.label
}

///|
pub fn z_transform_z_transform_point_dist(
  a : Z_transformPoint,
  b : Z_transformPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn z_transform_z_transform_point_add(
  a : Z_transformPoint,
  b : Z_transformPoint,
) -> Z_transformPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn z_transform_z_transform_point_sub(
  a : Z_transformPoint,
  b : Z_transformPoint,
) -> Z_transformPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn z_transform_z_transform_point_scale(
  pt : Z_transformPoint,
  s : Double,
) -> Z_transformPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn z_transform_z_transform_point_dot(
  a : Z_transformPoint,
  b : Z_transformPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn z_transform_z_transform_point_norm(pt : Z_transformPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn z_transform_z_transform_point_to_string(pt : Z_transformPoint) -> String {
  "(" +
  z_transform_z_transform_dbl(pt.x) +
  ", " +
  z_transform_z_transform_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Z_transformSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn z_transform_z_transform_make_series(
  vals : Array[Double],
  name : String,
) -> Z_transformSeries {
  { vals, name, }
}

///|
pub fn z_transform_z_transform_series_len(s : Z_transformSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn z_transform_z_transform_series_sum(s : Z_transformSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn z_transform_z_transform_series_mean(s : Z_transformSeries) -> Double {
  let n = z_transform_z_transform_series_len(s)
  if n == 0 {
    0.0
  } else {
    z_transform_z_transform_series_sum(s) / n.to_double()
  }
}

///|
pub fn z_transform_z_transform_series_min(s : Z_transformSeries) -> Double {
  let n = z_transform_z_transform_series_len(s)
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
pub fn z_transform_z_transform_series_max(s : Z_transformSeries) -> Double {
  let n = z_transform_z_transform_series_len(s)
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
pub fn z_transform_z_transform_series_var(s : Z_transformSeries) -> Double {
  let n = z_transform_z_transform_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = z_transform_z_transform_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn z_transform_z_transform_series_std(s : Z_transformSeries) -> Double {
  @_common.sqrt(z_transform_z_transform_series_var(s))
}

///|
pub fn z_transform_z_transform_series_scale(
  s : Z_transformSeries,
  f : Double,
) -> Z_transformSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = z_transform_z_transform_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn z_transform_z_transform_series_add(
  a : Z_transformSeries,
  b : Z_transformSeries,
) -> Z_transformSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = z_transform_z_transform_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn z_transform_z_transform_series_to_string(s : Z_transformSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + z_transform_z_transform_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Z_transformMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn z_transform_z_transform_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Z_transformMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn z_transform_z_transform_matrix_identity(n : Int32) -> Z_transformMatrix {
  let m = z_transform_z_transform_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn z_transform_z_transform_matrix_get(
  m : Z_transformMatrix,
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
pub fn z_transform_z_transform_matrix_transpose(m : Z_transformMatrix) -> Z_transformMatrix {
  let result = z_transform_z_transform_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn z_transform_z_transform_matrix_add(
  a : Z_transformMatrix,
  b : Z_transformMatrix,
) -> Z_transformMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = z_transform_z_transform_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn z_transform_z_transform_matrix_scale(
  m : Z_transformMatrix,
  s : Double,
) -> Z_transformMatrix {
  let result = z_transform_z_transform_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn z_transform_z_transform_matrix_multiply(
  a : Z_transformMatrix,
  b : Z_transformMatrix,
) -> Z_transformMatrix {
  if a.cols != b.rows {
    return z_transform_z_transform_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = z_transform_z_transform_make_matrix(a.rows, b.cols, 0.0)
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
pub fn z_transform_z_transform_matrix_trace(m : Z_transformMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn z_transform_z_transform_matrix_norm(m : Z_transformMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn z_transform_z_transform_matrix_to_string(m : Z_transformMatrix) -> String {
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
      result = result + z_transform_z_transform_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Z_transformVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn z_transform_z_transform_make_vector(comps : Array[Double]) -> Z_transformVector {
  { comps, dim: comps.length(), }
}

///|
pub fn z_transform_z_transform_vector_zero(dim : Int32) -> Z_transformVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn z_transform_z_transform_vector_add(
  a : Z_transformVector,
  b : Z_transformVector,
) -> Z_transformVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = z_transform_z_transform_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn z_transform_z_transform_vector_sub(
  a : Z_transformVector,
  b : Z_transformVector,
) -> Z_transformVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = z_transform_z_transform_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn z_transform_z_transform_vector_scale(
  v : Z_transformVector,
  s : Double,
) -> Z_transformVector {
  let mut result = []
  for i in 0..<v.dim {
    result = z_transform_z_transform_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn z_transform_z_transform_vector_dot(
  a : Z_transformVector,
  b : Z_transformVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn z_transform_z_transform_vector_norm(v : Z_transformVector) -> Double {
  @_common.sqrt(z_transform_z_transform_vector_dot(v, v))
}

///|
pub fn z_transform_z_transform_vector_normalize(v : Z_transformVector) -> Z_transformVector {
  let n = z_transform_z_transform_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    z_transform_z_transform_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn z_transform_z_transform_vector_dist(
  a : Z_transformVector,
  b : Z_transformVector,
) -> Double {
  z_transform_z_transform_vector_norm(z_transform_z_transform_vector_sub(a, b))
}

///|
pub fn z_transform_z_transform_vector_to_string(v : Z_transformVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + z_transform_z_transform_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn z_transform_z_transform_var(data : Array[Double]) -> Double {
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
pub fn z_transform_z_transform_std(data : Array[Double]) -> Double {
  @_common.sqrt(z_transform_z_transform_var(data))
}

///|
pub fn z_transform_z_transform_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn z_transform_z_transform_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = z_transform_z_transform_std(a)
  let sb = z_transform_z_transform_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    z_transform_z_transform_cov(a, b) / (sa * sb)
  }
}

///|
pub fn z_transform_z_transform_accuracy(
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
pub fn z_transform_z_transform_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn z_transform_z_transform_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn z_transform_z_transform_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn z_transform_z_transform_precision(
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
pub fn z_transform_z_transform_recall(
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
pub fn z_transform_z_transform_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = z_transform_z_transform_precision(pred, labels, pos)
  let r = z_transform_z_transform_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn z_transform_z_transform_dbl(x : Double) -> String {
  let i = if x >= 0.0 { z_transform_z_transform_int(x) } else { -z_transform_z_transform_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    z_transform_z_transform_int(f * 1000000.0)
  } else {
    z_transform_z_transform_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn z_transform_z_transform_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn z_transform_z_transform_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
