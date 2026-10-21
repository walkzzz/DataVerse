///|
///===
/// agent_kit/resource_alloc
/// S13.153 new
pub struct Resource_allocPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn resource_alloc_make_point(x : Double, y : Double) -> Resource_allocPoint {
  { x, y, label: 0, }
}

///|
pub fn resource_alloc_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Resource_allocPoint {
  { x, y, label, }
}

///|
pub fn resource_alloc_point_x(p : Resource_allocPoint) -> Double {
  p.x
}

///|
pub fn resource_alloc_point_y(p : Resource_allocPoint) -> Double {
  p.y
}

///|
pub fn resource_alloc_point_label(p : Resource_allocPoint) -> Int32 {
  p.label
}

///|
pub fn resource_alloc_point_dist(
  a : Resource_allocPoint,
  b : Resource_allocPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn resource_alloc_point_add(
  a : Resource_allocPoint,
  b : Resource_allocPoint,
) -> Resource_allocPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn resource_alloc_point_sub(
  a : Resource_allocPoint,
  b : Resource_allocPoint,
) -> Resource_allocPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn resource_alloc_point_scale(
  pt : Resource_allocPoint,
  s : Double,
) -> Resource_allocPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn resource_alloc_point_dot(
  a : Resource_allocPoint,
  b : Resource_allocPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn resource_alloc_point_norm(pt : Resource_allocPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn resource_alloc_point_to_string(pt : Resource_allocPoint) -> String {
  "(" +
  resource_alloc_dbl(pt.x) +
  ", " +
  resource_alloc_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Resource_allocSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn resource_alloc_make_series(
  vals : Array[Double],
  name : String,
) -> Resource_allocSeries {
  { vals, name, }
}

///|
pub fn resource_alloc_series_len(s : Resource_allocSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn resource_alloc_series_sum(s : Resource_allocSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn resource_alloc_series_mean(s : Resource_allocSeries) -> Double {
  let n = resource_alloc_series_len(s)
  if n == 0 {
    0.0
  } else {
    resource_alloc_series_sum(s) / n.to_double()
  }
}

///|
pub fn resource_alloc_series_min(s : Resource_allocSeries) -> Double {
  let n = resource_alloc_series_len(s)
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
pub fn resource_alloc_series_max(s : Resource_allocSeries) -> Double {
  let n = resource_alloc_series_len(s)
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
pub fn resource_alloc_series_var(s : Resource_allocSeries) -> Double {
  let n = resource_alloc_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = resource_alloc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn resource_alloc_series_std(s : Resource_allocSeries) -> Double {
  @_common.sqrt(resource_alloc_series_var(s))
}

///|
pub fn resource_alloc_series_scale(
  s : Resource_allocSeries,
  f : Double,
) -> Resource_allocSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = resource_alloc_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn resource_alloc_series_add(
  a : Resource_allocSeries,
  b : Resource_allocSeries,
) -> Resource_allocSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = resource_alloc_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn resource_alloc_series_to_string(s : Resource_allocSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + resource_alloc_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Resource_allocMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn resource_alloc_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Resource_allocMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn resource_alloc_matrix_identity(n : Int32) -> Resource_allocMatrix {
  let m = resource_alloc_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn resource_alloc_matrix_get(
  m : Resource_allocMatrix,
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
pub fn resource_alloc_matrix_transpose(
  m : Resource_allocMatrix,
) -> Resource_allocMatrix {
  let result = resource_alloc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn resource_alloc_matrix_add(
  a : Resource_allocMatrix,
  b : Resource_allocMatrix,
) -> Resource_allocMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = resource_alloc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn resource_alloc_matrix_scale(
  m : Resource_allocMatrix,
  s : Double,
) -> Resource_allocMatrix {
  let result = resource_alloc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn resource_alloc_matrix_multiply(
  a : Resource_allocMatrix,
  b : Resource_allocMatrix,
) -> Resource_allocMatrix {
  if a.cols != b.rows {
    return resource_alloc_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = resource_alloc_make_matrix(a.rows, b.cols, 0.0)
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
pub fn resource_alloc_matrix_trace(m : Resource_allocMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn resource_alloc_matrix_norm(m : Resource_allocMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn resource_alloc_matrix_to_string(m : Resource_allocMatrix) -> String {
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
      result = result + resource_alloc_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Resource_allocVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn resource_alloc_make_vector(
  comps : Array[Double],
) -> Resource_allocVector {
  { comps, dim: comps.length(), }
}

///|
pub fn resource_alloc_vector_zero(dim : Int32) -> Resource_allocVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn resource_alloc_vector_add(
  a : Resource_allocVector,
  b : Resource_allocVector,
) -> Resource_allocVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = resource_alloc_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn resource_alloc_vector_sub(
  a : Resource_allocVector,
  b : Resource_allocVector,
) -> Resource_allocVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = resource_alloc_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn resource_alloc_vector_scale(
  v : Resource_allocVector,
  s : Double,
) -> Resource_allocVector {
  let mut result = []
  for i in 0..<v.dim {
    result = resource_alloc_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn resource_alloc_vector_dot(
  a : Resource_allocVector,
  b : Resource_allocVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn resource_alloc_vector_norm(v : Resource_allocVector) -> Double {
  @_common.sqrt(resource_alloc_vector_dot(v, v))
}

///|
pub fn resource_alloc_vector_normalize(
  v : Resource_allocVector,
) -> Resource_allocVector {
  let n = resource_alloc_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    resource_alloc_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn resource_alloc_vector_dist(
  a : Resource_allocVector,
  b : Resource_allocVector,
) -> Double {
  resource_alloc_vector_norm(resource_alloc_vector_sub(a, b))
}

///|
pub fn resource_alloc_vector_to_string(v : Resource_allocVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + resource_alloc_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn resource_alloc_var(data : Array[Double]) -> Double {
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
pub fn resource_alloc_std(data : Array[Double]) -> Double {
  @_common.sqrt(resource_alloc_var(data))
}

///|
pub fn resource_alloc_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn resource_alloc_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = resource_alloc_std(a)
  let sb = resource_alloc_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    resource_alloc_cov(a, b) / (sa * sb)
  }
}

///|
pub fn resource_alloc_accuracy(
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
pub fn resource_alloc_mse(
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
pub fn resource_alloc_mae(
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
pub fn resource_alloc_r2(
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
pub fn resource_alloc_precision(
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
pub fn resource_alloc_recall(
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
pub fn resource_alloc_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = resource_alloc_precision(pred, labels, pos)
  let r = resource_alloc_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn resource_alloc_dbl(x : Double) -> String {
  let i = if x >= 0.0 { resource_alloc_int(x) } else { -resource_alloc_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    resource_alloc_int(f * 1000000.0)
  } else {
    resource_alloc_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn resource_alloc_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn resource_alloc_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
