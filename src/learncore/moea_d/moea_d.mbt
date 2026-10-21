///|
///===
/// learncore/moea_d
/// S13.84 new
pub struct Moea_dPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn moea_d_make_point(x : Double, y : Double) -> Moea_dPoint {
  { x, y, label: 0, }
}

///|
pub fn moea_d_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Moea_dPoint {
  { x, y, label, }
}

///|
pub fn moea_d_point_x(p : Moea_dPoint) -> Double {
  p.x
}

///|
pub fn moea_d_point_y(p : Moea_dPoint) -> Double {
  p.y
}

///|
pub fn moea_d_point_label(p : Moea_dPoint) -> Int32 {
  p.label
}

///|
pub fn moea_d_point_dist(a : Moea_dPoint, b : Moea_dPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn moea_d_point_add(a : Moea_dPoint, b : Moea_dPoint) -> Moea_dPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn moea_d_point_sub(a : Moea_dPoint, b : Moea_dPoint) -> Moea_dPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn moea_d_point_scale(pt : Moea_dPoint, s : Double) -> Moea_dPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn moea_d_point_dot(a : Moea_dPoint, b : Moea_dPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn moea_d_point_norm(pt : Moea_dPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn moea_d_point_to_string(pt : Moea_dPoint) -> String {
  "(" +
  moea_d_dbl(pt.x) +
  ", " +
  moea_d_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Moea_dSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn moea_d_make_series(vals : Array[Double], name : String) -> Moea_dSeries {
  { vals, name, }
}

///|
pub fn moea_d_series_len(s : Moea_dSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn moea_d_series_sum(s : Moea_dSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn moea_d_series_mean(s : Moea_dSeries) -> Double {
  let n = moea_d_series_len(s)
  if n == 0 {
    0.0
  } else {
    moea_d_series_sum(s) / n.to_double()
  }
}

///|
pub fn moea_d_series_min(s : Moea_dSeries) -> Double {
  let n = moea_d_series_len(s)
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
pub fn moea_d_series_max(s : Moea_dSeries) -> Double {
  let n = moea_d_series_len(s)
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
pub fn moea_d_series_var(s : Moea_dSeries) -> Double {
  let n = moea_d_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = moea_d_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn moea_d_series_std(s : Moea_dSeries) -> Double {
  @_common.sqrt(moea_d_series_var(s))
}

///|
pub fn moea_d_series_scale(s : Moea_dSeries, f : Double) -> Moea_dSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = moea_d_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn moea_d_series_add(a : Moea_dSeries, b : Moea_dSeries) -> Moea_dSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = moea_d_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn moea_d_series_to_string(s : Moea_dSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + moea_d_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Moea_dMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn moea_d_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Moea_dMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn moea_d_matrix_identity(n : Int32) -> Moea_dMatrix {
  let m = moea_d_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn moea_d_matrix_get(m : Moea_dMatrix, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn moea_d_matrix_transpose(m : Moea_dMatrix) -> Moea_dMatrix {
  let result = moea_d_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn moea_d_matrix_add(a : Moea_dMatrix, b : Moea_dMatrix) -> Moea_dMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = moea_d_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn moea_d_matrix_scale(m : Moea_dMatrix, s : Double) -> Moea_dMatrix {
  let result = moea_d_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn moea_d_matrix_multiply(
  a : Moea_dMatrix,
  b : Moea_dMatrix,
) -> Moea_dMatrix {
  if a.cols != b.rows {
    return moea_d_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = moea_d_make_matrix(a.rows, b.cols, 0.0)
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
pub fn moea_d_matrix_trace(m : Moea_dMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn moea_d_matrix_norm(m : Moea_dMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn moea_d_matrix_to_string(m : Moea_dMatrix) -> String {
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
      result = result + moea_d_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Moea_dVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn moea_d_make_vector(comps : Array[Double]) -> Moea_dVector {
  { comps, dim: comps.length(), }
}

///|
pub fn moea_d_vector_zero(dim : Int32) -> Moea_dVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn moea_d_vector_add(a : Moea_dVector, b : Moea_dVector) -> Moea_dVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = moea_d_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn moea_d_vector_sub(a : Moea_dVector, b : Moea_dVector) -> Moea_dVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = moea_d_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn moea_d_vector_scale(v : Moea_dVector, s : Double) -> Moea_dVector {
  let mut result = []
  for i in 0..<v.dim {
    result = moea_d_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn moea_d_vector_dot(a : Moea_dVector, b : Moea_dVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn moea_d_vector_norm(v : Moea_dVector) -> Double {
  @_common.sqrt(moea_d_vector_dot(v, v))
}

///|
pub fn moea_d_vector_normalize(v : Moea_dVector) -> Moea_dVector {
  let n = moea_d_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    moea_d_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn moea_d_vector_dist(a : Moea_dVector, b : Moea_dVector) -> Double {
  moea_d_vector_norm(moea_d_vector_sub(a, b))
}

///|
pub fn moea_d_vector_to_string(v : Moea_dVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + moea_d_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn moea_d_var(data : Array[Double]) -> Double {
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
pub fn moea_d_std(data : Array[Double]) -> Double {
  @_common.sqrt(moea_d_var(data))
}

///|
pub fn moea_d_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn moea_d_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = moea_d_std(a)
  let sb = moea_d_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    moea_d_cov(a, b) / (sa * sb)
  }
}

///|
pub fn moea_d_accuracy(pred : Array[Int32], labels : Array[Int32]) -> Double {
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
pub fn moea_d_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn moea_d_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn moea_d_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn moea_d_precision(
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
pub fn moea_d_recall(
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
pub fn moea_d_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = moea_d_precision(pred, labels, pos)
  let r = moea_d_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn moea_d_dbl(x : Double) -> String {
  let i = if x >= 0.0 { moea_d_int(x) } else { -moea_d_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    moea_d_int(f * 1000000.0)
  } else {
    moea_d_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn moea_d_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn moea_d_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
