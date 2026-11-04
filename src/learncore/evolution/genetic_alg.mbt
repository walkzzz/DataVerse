///|
///===
/// learncore/genetic_alg
/// S13.69 new
pub struct Genetic_algPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn genetic_alg_genetic_alg_make_point(x : Double, y : Double) -> Genetic_algPoint {
  { x, y, label: 0, }
}

///|
pub fn genetic_alg_genetic_alg_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Genetic_algPoint {
  { x, y, label, }
}

///|
pub fn genetic_alg_genetic_alg_point_x(p : Genetic_algPoint) -> Double {
  p.x
}

///|
pub fn genetic_alg_genetic_alg_point_y(p : Genetic_algPoint) -> Double {
  p.y
}

///|
pub fn genetic_alg_genetic_alg_point_label(p : Genetic_algPoint) -> Int32 {
  p.label
}

///|
pub fn genetic_alg_genetic_alg_point_dist(
  a : Genetic_algPoint,
  b : Genetic_algPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn genetic_alg_genetic_alg_point_add(
  a : Genetic_algPoint,
  b : Genetic_algPoint,
) -> Genetic_algPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn genetic_alg_genetic_alg_point_sub(
  a : Genetic_algPoint,
  b : Genetic_algPoint,
) -> Genetic_algPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn genetic_alg_genetic_alg_point_scale(
  pt : Genetic_algPoint,
  s : Double,
) -> Genetic_algPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn genetic_alg_genetic_alg_point_dot(
  a : Genetic_algPoint,
  b : Genetic_algPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn genetic_alg_genetic_alg_point_norm(pt : Genetic_algPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn genetic_alg_genetic_alg_point_to_string(pt : Genetic_algPoint) -> String {
  "(" +
  genetic_alg_genetic_alg_dbl(pt.x) +
  ", " +
  genetic_alg_genetic_alg_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Genetic_algSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn genetic_alg_genetic_alg_make_series(
  vals : Array[Double],
  name : String,
) -> Genetic_algSeries {
  { vals, name, }
}

///|
pub fn genetic_alg_genetic_alg_series_len(s : Genetic_algSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn genetic_alg_genetic_alg_series_sum(s : Genetic_algSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn genetic_alg_genetic_alg_series_mean(s : Genetic_algSeries) -> Double {
  let n = genetic_alg_genetic_alg_series_len(s)
  if n == 0 {
    0.0
  } else {
    genetic_alg_genetic_alg_series_sum(s) / n.to_double()
  }
}

///|
pub fn genetic_alg_genetic_alg_series_min(s : Genetic_algSeries) -> Double {
  let n = genetic_alg_genetic_alg_series_len(s)
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
pub fn genetic_alg_genetic_alg_series_max(s : Genetic_algSeries) -> Double {
  let n = genetic_alg_genetic_alg_series_len(s)
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
pub fn genetic_alg_genetic_alg_series_var(s : Genetic_algSeries) -> Double {
  let n = genetic_alg_genetic_alg_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = genetic_alg_genetic_alg_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn genetic_alg_genetic_alg_series_std(s : Genetic_algSeries) -> Double {
  @_common.sqrt(genetic_alg_genetic_alg_series_var(s))
}

///|
pub fn genetic_alg_genetic_alg_series_scale(
  s : Genetic_algSeries,
  f : Double,
) -> Genetic_algSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = genetic_alg_genetic_alg_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn genetic_alg_genetic_alg_series_add(
  a : Genetic_algSeries,
  b : Genetic_algSeries,
) -> Genetic_algSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = genetic_alg_genetic_alg_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn genetic_alg_genetic_alg_series_to_string(s : Genetic_algSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + genetic_alg_genetic_alg_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Genetic_algMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn genetic_alg_genetic_alg_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Genetic_algMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn genetic_alg_genetic_alg_matrix_identity(n : Int32) -> Genetic_algMatrix {
  let m = genetic_alg_genetic_alg_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn genetic_alg_genetic_alg_matrix_get(
  m : Genetic_algMatrix,
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
pub fn genetic_alg_genetic_alg_matrix_transpose(m : Genetic_algMatrix) -> Genetic_algMatrix {
  let result = genetic_alg_genetic_alg_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn genetic_alg_genetic_alg_matrix_add(
  a : Genetic_algMatrix,
  b : Genetic_algMatrix,
) -> Genetic_algMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = genetic_alg_genetic_alg_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn genetic_alg_genetic_alg_matrix_scale(
  m : Genetic_algMatrix,
  s : Double,
) -> Genetic_algMatrix {
  let result = genetic_alg_genetic_alg_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn genetic_alg_genetic_alg_matrix_multiply(
  a : Genetic_algMatrix,
  b : Genetic_algMatrix,
) -> Genetic_algMatrix {
  if a.cols != b.rows {
    return genetic_alg_genetic_alg_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = genetic_alg_genetic_alg_make_matrix(a.rows, b.cols, 0.0)
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
pub fn genetic_alg_genetic_alg_matrix_trace(m : Genetic_algMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn genetic_alg_genetic_alg_matrix_norm(m : Genetic_algMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn genetic_alg_genetic_alg_matrix_to_string(m : Genetic_algMatrix) -> String {
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
      result = result + genetic_alg_genetic_alg_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Genetic_algVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn genetic_alg_genetic_alg_make_vector(comps : Array[Double]) -> Genetic_algVector {
  { comps, dim: comps.length(), }
}

///|
pub fn genetic_alg_genetic_alg_vector_zero(dim : Int32) -> Genetic_algVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn genetic_alg_genetic_alg_vector_add(
  a : Genetic_algVector,
  b : Genetic_algVector,
) -> Genetic_algVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = genetic_alg_genetic_alg_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn genetic_alg_genetic_alg_vector_sub(
  a : Genetic_algVector,
  b : Genetic_algVector,
) -> Genetic_algVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = genetic_alg_genetic_alg_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn genetic_alg_genetic_alg_vector_scale(
  v : Genetic_algVector,
  s : Double,
) -> Genetic_algVector {
  let mut result = []
  for i in 0..<v.dim {
    result = genetic_alg_genetic_alg_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn genetic_alg_genetic_alg_vector_dot(
  a : Genetic_algVector,
  b : Genetic_algVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn genetic_alg_genetic_alg_vector_norm(v : Genetic_algVector) -> Double {
  @_common.sqrt(genetic_alg_genetic_alg_vector_dot(v, v))
}

///|
pub fn genetic_alg_genetic_alg_vector_normalize(v : Genetic_algVector) -> Genetic_algVector {
  let n = genetic_alg_genetic_alg_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    genetic_alg_genetic_alg_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn genetic_alg_genetic_alg_vector_dist(
  a : Genetic_algVector,
  b : Genetic_algVector,
) -> Double {
  genetic_alg_genetic_alg_vector_norm(genetic_alg_genetic_alg_vector_sub(a, b))
}

///|
pub fn genetic_alg_genetic_alg_vector_to_string(v : Genetic_algVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + genetic_alg_genetic_alg_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn genetic_alg_genetic_alg_var(data : Array[Double]) -> Double {
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
pub fn genetic_alg_genetic_alg_std(data : Array[Double]) -> Double {
  @_common.sqrt(genetic_alg_genetic_alg_var(data))
}

///|
pub fn genetic_alg_genetic_alg_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn genetic_alg_genetic_alg_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = genetic_alg_genetic_alg_std(a)
  let sb = genetic_alg_genetic_alg_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    genetic_alg_genetic_alg_cov(a, b) / (sa * sb)
  }
}

///|
pub fn genetic_alg_genetic_alg_accuracy(
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
pub fn genetic_alg_genetic_alg_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn genetic_alg_genetic_alg_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn genetic_alg_genetic_alg_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn genetic_alg_genetic_alg_precision(
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
pub fn genetic_alg_genetic_alg_recall(
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
pub fn genetic_alg_genetic_alg_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = genetic_alg_genetic_alg_precision(pred, labels, pos)
  let r = genetic_alg_genetic_alg_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn genetic_alg_genetic_alg_dbl(x : Double) -> String {
  let i = if x >= 0.0 { genetic_alg_genetic_alg_int(x) } else { -genetic_alg_genetic_alg_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    genetic_alg_genetic_alg_int(f * 1000000.0)
  } else {
    genetic_alg_genetic_alg_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn genetic_alg_genetic_alg_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn genetic_alg_genetic_alg_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
