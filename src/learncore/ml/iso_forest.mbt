///|
///===
/// learncore/iso_forest
/// S13.96 new
pub struct Iso_forestPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn iso_forest_iso_forest_make_point(x : Double, y : Double) -> Iso_forestPoint {
  { x, y, label: 0, }
}

///|
pub fn iso_forest_iso_forest_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Iso_forestPoint {
  { x, y, label, }
}

///|
pub fn iso_forest_iso_forest_point_x(p : Iso_forestPoint) -> Double {
  p.x
}

///|
pub fn iso_forest_iso_forest_point_y(p : Iso_forestPoint) -> Double {
  p.y
}

///|
pub fn iso_forest_iso_forest_point_label(p : Iso_forestPoint) -> Int32 {
  p.label
}

///|
pub fn iso_forest_iso_forest_point_dist(
  a : Iso_forestPoint,
  b : Iso_forestPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn iso_forest_iso_forest_point_add(
  a : Iso_forestPoint,
  b : Iso_forestPoint,
) -> Iso_forestPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn iso_forest_iso_forest_point_sub(
  a : Iso_forestPoint,
  b : Iso_forestPoint,
) -> Iso_forestPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn iso_forest_iso_forest_point_scale(
  pt : Iso_forestPoint,
  s : Double,
) -> Iso_forestPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn iso_forest_iso_forest_point_dot(a : Iso_forestPoint, b : Iso_forestPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn iso_forest_iso_forest_point_norm(pt : Iso_forestPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn iso_forest_iso_forest_point_to_string(pt : Iso_forestPoint) -> String {
  "(" +
  iso_forest_iso_forest_dbl(pt.x) +
  ", " +
  iso_forest_iso_forest_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Iso_forestSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn iso_forest_iso_forest_make_series(
  vals : Array[Double],
  name : String,
) -> Iso_forestSeries {
  { vals, name, }
}

///|
pub fn iso_forest_iso_forest_series_len(s : Iso_forestSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn iso_forest_iso_forest_series_sum(s : Iso_forestSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn iso_forest_iso_forest_series_mean(s : Iso_forestSeries) -> Double {
  let n = iso_forest_iso_forest_series_len(s)
  if n == 0 {
    0.0
  } else {
    iso_forest_iso_forest_series_sum(s) / n.to_double()
  }
}

///|
pub fn iso_forest_iso_forest_series_min(s : Iso_forestSeries) -> Double {
  let n = iso_forest_iso_forest_series_len(s)
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
pub fn iso_forest_iso_forest_series_max(s : Iso_forestSeries) -> Double {
  let n = iso_forest_iso_forest_series_len(s)
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
pub fn iso_forest_iso_forest_series_var(s : Iso_forestSeries) -> Double {
  let n = iso_forest_iso_forest_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = iso_forest_iso_forest_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn iso_forest_iso_forest_series_std(s : Iso_forestSeries) -> Double {
  @_common.sqrt(iso_forest_iso_forest_series_var(s))
}

///|
pub fn iso_forest_iso_forest_series_scale(
  s : Iso_forestSeries,
  f : Double,
) -> Iso_forestSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = iso_forest_iso_forest_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn iso_forest_iso_forest_series_add(
  a : Iso_forestSeries,
  b : Iso_forestSeries,
) -> Iso_forestSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = iso_forest_iso_forest_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn iso_forest_iso_forest_series_to_string(s : Iso_forestSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + iso_forest_iso_forest_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Iso_forestMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn iso_forest_iso_forest_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Iso_forestMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn iso_forest_iso_forest_matrix_identity(n : Int32) -> Iso_forestMatrix {
  let m = iso_forest_iso_forest_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn iso_forest_iso_forest_matrix_get(
  m : Iso_forestMatrix,
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
pub fn iso_forest_iso_forest_matrix_transpose(m : Iso_forestMatrix) -> Iso_forestMatrix {
  let result = iso_forest_iso_forest_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn iso_forest_iso_forest_matrix_add(
  a : Iso_forestMatrix,
  b : Iso_forestMatrix,
) -> Iso_forestMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = iso_forest_iso_forest_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn iso_forest_iso_forest_matrix_scale(
  m : Iso_forestMatrix,
  s : Double,
) -> Iso_forestMatrix {
  let result = iso_forest_iso_forest_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn iso_forest_iso_forest_matrix_multiply(
  a : Iso_forestMatrix,
  b : Iso_forestMatrix,
) -> Iso_forestMatrix {
  if a.cols != b.rows {
    return iso_forest_iso_forest_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = iso_forest_iso_forest_make_matrix(a.rows, b.cols, 0.0)
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
pub fn iso_forest_iso_forest_matrix_trace(m : Iso_forestMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn iso_forest_iso_forest_matrix_norm(m : Iso_forestMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn iso_forest_iso_forest_matrix_to_string(m : Iso_forestMatrix) -> String {
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
      result = result + iso_forest_iso_forest_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Iso_forestVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn iso_forest_iso_forest_make_vector(comps : Array[Double]) -> Iso_forestVector {
  { comps, dim: comps.length(), }
}

///|
pub fn iso_forest_iso_forest_vector_zero(dim : Int32) -> Iso_forestVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn iso_forest_iso_forest_vector_add(
  a : Iso_forestVector,
  b : Iso_forestVector,
) -> Iso_forestVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = iso_forest_iso_forest_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn iso_forest_iso_forest_vector_sub(
  a : Iso_forestVector,
  b : Iso_forestVector,
) -> Iso_forestVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = iso_forest_iso_forest_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn iso_forest_iso_forest_vector_scale(
  v : Iso_forestVector,
  s : Double,
) -> Iso_forestVector {
  let mut result = []
  for i in 0..<v.dim {
    result = iso_forest_iso_forest_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn iso_forest_iso_forest_vector_dot(
  a : Iso_forestVector,
  b : Iso_forestVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn iso_forest_iso_forest_vector_norm(v : Iso_forestVector) -> Double {
  @_common.sqrt(iso_forest_iso_forest_vector_dot(v, v))
}

///|
pub fn iso_forest_iso_forest_vector_normalize(v : Iso_forestVector) -> Iso_forestVector {
  let n = iso_forest_iso_forest_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    iso_forest_iso_forest_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn iso_forest_iso_forest_vector_dist(
  a : Iso_forestVector,
  b : Iso_forestVector,
) -> Double {
  iso_forest_iso_forest_vector_norm(iso_forest_iso_forest_vector_sub(a, b))
}

///|
pub fn iso_forest_iso_forest_vector_to_string(v : Iso_forestVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + iso_forest_iso_forest_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn iso_forest_iso_forest_var(data : Array[Double]) -> Double {
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
pub fn iso_forest_iso_forest_std(data : Array[Double]) -> Double {
  @_common.sqrt(iso_forest_iso_forest_var(data))
}

///|
pub fn iso_forest_iso_forest_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn iso_forest_iso_forest_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = iso_forest_iso_forest_std(a)
  let sb = iso_forest_iso_forest_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    iso_forest_iso_forest_cov(a, b) / (sa * sb)
  }
}

///|
pub fn iso_forest_iso_forest_accuracy(
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
pub fn iso_forest_iso_forest_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn iso_forest_iso_forest_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn iso_forest_iso_forest_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn iso_forest_iso_forest_precision(
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
pub fn iso_forest_iso_forest_recall(
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
pub fn iso_forest_iso_forest_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = iso_forest_iso_forest_precision(pred, labels, pos)
  let r = iso_forest_iso_forest_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn iso_forest_iso_forest_dbl(x : Double) -> String {
  let i = if x >= 0.0 { iso_forest_iso_forest_int(x) } else { -iso_forest_iso_forest_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    iso_forest_iso_forest_int(f * 1000000.0)
  } else {
    iso_forest_iso_forest_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn iso_forest_iso_forest_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn iso_forest_iso_forest_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
