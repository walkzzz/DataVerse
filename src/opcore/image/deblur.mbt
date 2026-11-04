///|
///===
/// opcore/deblur
/// S13.56 new
pub struct DeblurPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn deblur_deblur_make_point(x : Double, y : Double) -> DeblurPoint {
  { x, y, label: 0, }
}

///|
pub fn deblur_deblur_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> DeblurPoint {
  { x, y, label, }
}

///|
pub fn deblur_deblur_point_x(p : DeblurPoint) -> Double {
  p.x
}

///|
pub fn deblur_deblur_point_y(p : DeblurPoint) -> Double {
  p.y
}

///|
pub fn deblur_deblur_point_label(p : DeblurPoint) -> Int32 {
  p.label
}

///|
pub fn deblur_deblur_point_dist(a : DeblurPoint, b : DeblurPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn deblur_deblur_point_add(a : DeblurPoint, b : DeblurPoint) -> DeblurPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn deblur_deblur_point_sub(a : DeblurPoint, b : DeblurPoint) -> DeblurPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn deblur_deblur_point_scale(pt : DeblurPoint, s : Double) -> DeblurPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn deblur_deblur_point_dot(a : DeblurPoint, b : DeblurPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn deblur_deblur_point_norm(pt : DeblurPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn deblur_deblur_point_to_string(pt : DeblurPoint) -> String {
  "(" +
  deblur_deblur_dbl(pt.x) +
  ", " +
  deblur_deblur_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct DeblurSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn deblur_deblur_make_series(vals : Array[Double], name : String) -> DeblurSeries {
  { vals, name, }
}

///|
pub fn deblur_deblur_series_len(s : DeblurSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn deblur_deblur_series_sum(s : DeblurSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn deblur_deblur_series_mean(s : DeblurSeries) -> Double {
  let n = deblur_deblur_series_len(s)
  if n == 0 {
    0.0
  } else {
    deblur_deblur_series_sum(s) / n.to_double()
  }
}

///|
pub fn deblur_deblur_series_min(s : DeblurSeries) -> Double {
  let n = deblur_deblur_series_len(s)
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
pub fn deblur_deblur_series_max(s : DeblurSeries) -> Double {
  let n = deblur_deblur_series_len(s)
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
pub fn deblur_deblur_series_var(s : DeblurSeries) -> Double {
  let n = deblur_deblur_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = deblur_deblur_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn deblur_deblur_series_std(s : DeblurSeries) -> Double {
  @_common.sqrt(deblur_deblur_series_var(s))
}

///|
pub fn deblur_deblur_series_scale(s : DeblurSeries, f : Double) -> DeblurSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = deblur_deblur_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn deblur_deblur_series_add(a : DeblurSeries, b : DeblurSeries) -> DeblurSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = deblur_deblur_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn deblur_deblur_series_to_string(s : DeblurSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + deblur_deblur_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct DeblurMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn deblur_deblur_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DeblurMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn deblur_deblur_matrix_identity(n : Int32) -> DeblurMatrix {
  let m = deblur_deblur_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn deblur_deblur_matrix_get(m : DeblurMatrix, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn deblur_deblur_matrix_transpose(m : DeblurMatrix) -> DeblurMatrix {
  let result = deblur_deblur_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn deblur_deblur_matrix_add(a : DeblurMatrix, b : DeblurMatrix) -> DeblurMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = deblur_deblur_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn deblur_deblur_matrix_scale(m : DeblurMatrix, s : Double) -> DeblurMatrix {
  let result = deblur_deblur_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn deblur_deblur_matrix_multiply(
  a : DeblurMatrix,
  b : DeblurMatrix,
) -> DeblurMatrix {
  if a.cols != b.rows {
    return deblur_deblur_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = deblur_deblur_make_matrix(a.rows, b.cols, 0.0)
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
pub fn deblur_deblur_matrix_trace(m : DeblurMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn deblur_deblur_matrix_norm(m : DeblurMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn deblur_deblur_matrix_to_string(m : DeblurMatrix) -> String {
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
      result = result + deblur_deblur_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct DeblurVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn deblur_deblur_make_vector(comps : Array[Double]) -> DeblurVector {
  { comps, dim: comps.length(), }
}

///|
pub fn deblur_deblur_vector_zero(dim : Int32) -> DeblurVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn deblur_deblur_vector_add(a : DeblurVector, b : DeblurVector) -> DeblurVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = deblur_deblur_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn deblur_deblur_vector_sub(a : DeblurVector, b : DeblurVector) -> DeblurVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = deblur_deblur_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn deblur_deblur_vector_scale(v : DeblurVector, s : Double) -> DeblurVector {
  let mut result = []
  for i in 0..<v.dim {
    result = deblur_deblur_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn deblur_deblur_vector_dot(a : DeblurVector, b : DeblurVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn deblur_deblur_vector_norm(v : DeblurVector) -> Double {
  @_common.sqrt(deblur_deblur_vector_dot(v, v))
}

///|
pub fn deblur_deblur_vector_normalize(v : DeblurVector) -> DeblurVector {
  let n = deblur_deblur_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    deblur_deblur_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn deblur_deblur_vector_dist(a : DeblurVector, b : DeblurVector) -> Double {
  deblur_deblur_vector_norm(deblur_deblur_vector_sub(a, b))
}

///|
pub fn deblur_deblur_vector_to_string(v : DeblurVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + deblur_deblur_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn deblur_deblur_var(data : Array[Double]) -> Double {
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
pub fn deblur_deblur_std(data : Array[Double]) -> Double {
  @_common.sqrt(deblur_deblur_var(data))
}

///|
pub fn deblur_deblur_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn deblur_deblur_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = deblur_deblur_std(a)
  let sb = deblur_deblur_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    deblur_deblur_cov(a, b) / (sa * sb)
  }
}

///|
pub fn deblur_deblur_accuracy(pred : Array[Int32], labels : Array[Int32]) -> Double {
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
pub fn deblur_deblur_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn deblur_deblur_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn deblur_deblur_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn deblur_deblur_precision(
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
pub fn deblur_deblur_recall(
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
pub fn deblur_deblur_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = deblur_deblur_precision(pred, labels, pos)
  let r = deblur_deblur_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn deblur_deblur_dbl(x : Double) -> String {
  let i = if x >= 0.0 { deblur_deblur_int(x) } else { -deblur_deblur_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    deblur_deblur_int(f * 1000000.0)
  } else {
    deblur_deblur_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn deblur_deblur_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn deblur_deblur_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
