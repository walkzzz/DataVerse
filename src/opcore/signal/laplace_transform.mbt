///|
///===
/// opcore/laplace_transform
/// S13.10 new
pub struct Laplace_transformPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn laplace_transform_laplace_transform_make_point(
  x : Double,
  y : Double,
) -> Laplace_transformPoint {
  { x, y, label: 0, }
}

///|
pub fn laplace_transform_laplace_transform_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Laplace_transformPoint {
  { x, y, label, }
}

///|
pub fn laplace_transform_laplace_transform_point_x(p : Laplace_transformPoint) -> Double {
  p.x
}

///|
pub fn laplace_transform_laplace_transform_point_y(p : Laplace_transformPoint) -> Double {
  p.y
}

///|
pub fn laplace_transform_laplace_transform_point_label(p : Laplace_transformPoint) -> Int32 {
  p.label
}

///|
pub fn laplace_transform_laplace_transform_point_dist(
  a : Laplace_transformPoint,
  b : Laplace_transformPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn laplace_transform_laplace_transform_point_add(
  a : Laplace_transformPoint,
  b : Laplace_transformPoint,
) -> Laplace_transformPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn laplace_transform_laplace_transform_point_sub(
  a : Laplace_transformPoint,
  b : Laplace_transformPoint,
) -> Laplace_transformPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn laplace_transform_laplace_transform_point_scale(
  pt : Laplace_transformPoint,
  s : Double,
) -> Laplace_transformPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn laplace_transform_laplace_transform_point_dot(
  a : Laplace_transformPoint,
  b : Laplace_transformPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn laplace_transform_laplace_transform_point_norm(pt : Laplace_transformPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn laplace_transform_laplace_transform_point_to_string(pt : Laplace_transformPoint) -> String {
  "(" +
  laplace_transform_laplace_transform_dbl(pt.x) +
  ", " +
  laplace_transform_laplace_transform_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Laplace_transformSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn laplace_transform_laplace_transform_make_series(
  vals : Array[Double],
  name : String,
) -> Laplace_transformSeries {
  { vals, name, }
}

///|
pub fn laplace_transform_laplace_transform_series_len(s : Laplace_transformSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn laplace_transform_laplace_transform_series_sum(s : Laplace_transformSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn laplace_transform_laplace_transform_series_mean(s : Laplace_transformSeries) -> Double {
  let n = laplace_transform_laplace_transform_series_len(s)
  if n == 0 {
    0.0
  } else {
    laplace_transform_laplace_transform_series_sum(s) / n.to_double()
  }
}

///|
pub fn laplace_transform_laplace_transform_series_min(s : Laplace_transformSeries) -> Double {
  let n = laplace_transform_laplace_transform_series_len(s)
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
pub fn laplace_transform_laplace_transform_series_max(s : Laplace_transformSeries) -> Double {
  let n = laplace_transform_laplace_transform_series_len(s)
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
pub fn laplace_transform_laplace_transform_series_var(s : Laplace_transformSeries) -> Double {
  let n = laplace_transform_laplace_transform_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = laplace_transform_laplace_transform_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn laplace_transform_laplace_transform_series_std(s : Laplace_transformSeries) -> Double {
  @_common.sqrt(laplace_transform_laplace_transform_series_var(s))
}

///|
pub fn laplace_transform_laplace_transform_series_scale(
  s : Laplace_transformSeries,
  f : Double,
) -> Laplace_transformSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = laplace_transform_laplace_transform_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn laplace_transform_laplace_transform_series_add(
  a : Laplace_transformSeries,
  b : Laplace_transformSeries,
) -> Laplace_transformSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = laplace_transform_laplace_transform_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn laplace_transform_laplace_transform_series_to_string(
  s : Laplace_transformSeries,
) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + laplace_transform_laplace_transform_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Laplace_transformMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn laplace_transform_laplace_transform_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Laplace_transformMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn laplace_transform_laplace_transform_matrix_identity(n : Int32) -> Laplace_transformMatrix {
  let m = laplace_transform_laplace_transform_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn laplace_transform_laplace_transform_matrix_get(
  m : Laplace_transformMatrix,
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
pub fn laplace_transform_laplace_transform_matrix_transpose(
  m : Laplace_transformMatrix,
) -> Laplace_transformMatrix {
  let result = laplace_transform_laplace_transform_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn laplace_transform_laplace_transform_matrix_add(
  a : Laplace_transformMatrix,
  b : Laplace_transformMatrix,
) -> Laplace_transformMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = laplace_transform_laplace_transform_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn laplace_transform_laplace_transform_matrix_scale(
  m : Laplace_transformMatrix,
  s : Double,
) -> Laplace_transformMatrix {
  let result = laplace_transform_laplace_transform_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn laplace_transform_laplace_transform_matrix_multiply(
  a : Laplace_transformMatrix,
  b : Laplace_transformMatrix,
) -> Laplace_transformMatrix {
  if a.cols != b.rows {
    return laplace_transform_laplace_transform_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = laplace_transform_laplace_transform_make_matrix(a.rows, b.cols, 0.0)
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
pub fn laplace_transform_laplace_transform_matrix_trace(m : Laplace_transformMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn laplace_transform_laplace_transform_matrix_norm(m : Laplace_transformMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn laplace_transform_laplace_transform_matrix_to_string(
  m : Laplace_transformMatrix,
) -> String {
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
      result = result + laplace_transform_laplace_transform_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Laplace_transformVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn laplace_transform_laplace_transform_make_vector(
  comps : Array[Double],
) -> Laplace_transformVector {
  { comps, dim: comps.length(), }
}

///|
pub fn laplace_transform_laplace_transform_vector_zero(dim : Int32) -> Laplace_transformVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn laplace_transform_laplace_transform_vector_add(
  a : Laplace_transformVector,
  b : Laplace_transformVector,
) -> Laplace_transformVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = laplace_transform_laplace_transform_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn laplace_transform_laplace_transform_vector_sub(
  a : Laplace_transformVector,
  b : Laplace_transformVector,
) -> Laplace_transformVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = laplace_transform_laplace_transform_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn laplace_transform_laplace_transform_vector_scale(
  v : Laplace_transformVector,
  s : Double,
) -> Laplace_transformVector {
  let mut result = []
  for i in 0..<v.dim {
    result = laplace_transform_laplace_transform_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn laplace_transform_laplace_transform_vector_dot(
  a : Laplace_transformVector,
  b : Laplace_transformVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn laplace_transform_laplace_transform_vector_norm(v : Laplace_transformVector) -> Double {
  @_common.sqrt(laplace_transform_laplace_transform_vector_dot(v, v))
}

///|
pub fn laplace_transform_laplace_transform_vector_normalize(
  v : Laplace_transformVector,
) -> Laplace_transformVector {
  let n = laplace_transform_laplace_transform_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    laplace_transform_laplace_transform_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn laplace_transform_laplace_transform_vector_dist(
  a : Laplace_transformVector,
  b : Laplace_transformVector,
) -> Double {
  laplace_transform_laplace_transform_vector_norm(laplace_transform_laplace_transform_vector_sub(a, b))
}

///|
pub fn laplace_transform_laplace_transform_vector_to_string(
  v : Laplace_transformVector,
) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + laplace_transform_laplace_transform_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn laplace_transform_laplace_transform_var(data : Array[Double]) -> Double {
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
pub fn laplace_transform_laplace_transform_std(data : Array[Double]) -> Double {
  @_common.sqrt(laplace_transform_laplace_transform_var(data))
}

///|
pub fn laplace_transform_laplace_transform_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn laplace_transform_laplace_transform_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = laplace_transform_laplace_transform_std(a)
  let sb = laplace_transform_laplace_transform_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    laplace_transform_laplace_transform_cov(a, b) / (sa * sb)
  }
}

///|
pub fn laplace_transform_laplace_transform_accuracy(
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
pub fn laplace_transform_laplace_transform_mse(
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
pub fn laplace_transform_laplace_transform_mae(
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
pub fn laplace_transform_laplace_transform_r2(
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
pub fn laplace_transform_laplace_transform_precision(
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
pub fn laplace_transform_laplace_transform_recall(
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
pub fn laplace_transform_laplace_transform_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = laplace_transform_laplace_transform_precision(pred, labels, pos)
  let r = laplace_transform_laplace_transform_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn laplace_transform_laplace_transform_dbl(x : Double) -> String {
  let i = if x >= 0.0 {
    laplace_transform_laplace_transform_int(x)
  } else {
    -laplace_transform_laplace_transform_int(-x)
  }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    laplace_transform_laplace_transform_int(f * 1000000.0)
  } else {
    laplace_transform_laplace_transform_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn laplace_transform_laplace_transform_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn laplace_transform_laplace_transform_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
