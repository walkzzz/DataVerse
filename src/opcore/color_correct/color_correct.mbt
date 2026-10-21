///|
///===
/// opcore/color_correct
/// S13.53 new
pub struct Color_correctPoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn color_correct_make_point(x : Double, y : Double) -> Color_correctPoint {
  { x, y, label: 0, }
}

///|
pub fn color_correct_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Color_correctPoint {
  { x, y, label, }
}

///|
pub fn color_correct_point_x(p : Color_correctPoint) -> Double {
  p.x
}

///|
pub fn color_correct_point_y(p : Color_correctPoint) -> Double {
  p.y
}

///|
pub fn color_correct_point_label(p : Color_correctPoint) -> Int32 {
  p.label
}

///|
pub fn color_correct_point_dist(
  a : Color_correctPoint,
  b : Color_correctPoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn color_correct_point_add(
  a : Color_correctPoint,
  b : Color_correctPoint,
) -> Color_correctPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn color_correct_point_sub(
  a : Color_correctPoint,
  b : Color_correctPoint,
) -> Color_correctPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn color_correct_point_scale(
  pt : Color_correctPoint,
  s : Double,
) -> Color_correctPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn color_correct_point_dot(
  a : Color_correctPoint,
  b : Color_correctPoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn color_correct_point_norm(pt : Color_correctPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn color_correct_point_to_string(pt : Color_correctPoint) -> String {
  "(" +
  color_correct_dbl(pt.x) +
  ", " +
  color_correct_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Color_correctSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn color_correct_make_series(
  vals : Array[Double],
  name : String,
) -> Color_correctSeries {
  { vals, name, }
}

///|
pub fn color_correct_series_len(s : Color_correctSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn color_correct_series_sum(s : Color_correctSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn color_correct_series_mean(s : Color_correctSeries) -> Double {
  let n = color_correct_series_len(s)
  if n == 0 {
    0.0
  } else {
    color_correct_series_sum(s) / n.to_double()
  }
}

///|
pub fn color_correct_series_min(s : Color_correctSeries) -> Double {
  let n = color_correct_series_len(s)
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
pub fn color_correct_series_max(s : Color_correctSeries) -> Double {
  let n = color_correct_series_len(s)
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
pub fn color_correct_series_var(s : Color_correctSeries) -> Double {
  let n = color_correct_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = color_correct_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn color_correct_series_std(s : Color_correctSeries) -> Double {
  @_common.sqrt(color_correct_series_var(s))
}

///|
pub fn color_correct_series_scale(
  s : Color_correctSeries,
  f : Double,
) -> Color_correctSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = color_correct_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn color_correct_series_add(
  a : Color_correctSeries,
  b : Color_correctSeries,
) -> Color_correctSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = color_correct_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn color_correct_series_to_string(s : Color_correctSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + color_correct_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Color_correctMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn color_correct_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Color_correctMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn color_correct_matrix_identity(n : Int32) -> Color_correctMatrix {
  let m = color_correct_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn color_correct_matrix_get(
  m : Color_correctMatrix,
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
pub fn color_correct_matrix_transpose(
  m : Color_correctMatrix,
) -> Color_correctMatrix {
  let result = color_correct_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn color_correct_matrix_add(
  a : Color_correctMatrix,
  b : Color_correctMatrix,
) -> Color_correctMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = color_correct_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn color_correct_matrix_scale(
  m : Color_correctMatrix,
  s : Double,
) -> Color_correctMatrix {
  let result = color_correct_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn color_correct_matrix_multiply(
  a : Color_correctMatrix,
  b : Color_correctMatrix,
) -> Color_correctMatrix {
  if a.cols != b.rows {
    return color_correct_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = color_correct_make_matrix(a.rows, b.cols, 0.0)
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
pub fn color_correct_matrix_trace(m : Color_correctMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn color_correct_matrix_norm(m : Color_correctMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn color_correct_matrix_to_string(m : Color_correctMatrix) -> String {
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
      result = result + color_correct_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Color_correctVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn color_correct_make_vector(comps : Array[Double]) -> Color_correctVector {
  { comps, dim: comps.length(), }
}

///|
pub fn color_correct_vector_zero(dim : Int32) -> Color_correctVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn color_correct_vector_add(
  a : Color_correctVector,
  b : Color_correctVector,
) -> Color_correctVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = color_correct_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn color_correct_vector_sub(
  a : Color_correctVector,
  b : Color_correctVector,
) -> Color_correctVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = color_correct_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn color_correct_vector_scale(
  v : Color_correctVector,
  s : Double,
) -> Color_correctVector {
  let mut result = []
  for i in 0..<v.dim {
    result = color_correct_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn color_correct_vector_dot(
  a : Color_correctVector,
  b : Color_correctVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn color_correct_vector_norm(v : Color_correctVector) -> Double {
  @_common.sqrt(color_correct_vector_dot(v, v))
}

///|
pub fn color_correct_vector_normalize(
  v : Color_correctVector,
) -> Color_correctVector {
  let n = color_correct_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    color_correct_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn color_correct_vector_dist(
  a : Color_correctVector,
  b : Color_correctVector,
) -> Double {
  color_correct_vector_norm(color_correct_vector_sub(a, b))
}

///|
pub fn color_correct_vector_to_string(v : Color_correctVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + color_correct_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn color_correct_var(data : Array[Double]) -> Double {
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
pub fn color_correct_std(data : Array[Double]) -> Double {
  @_common.sqrt(color_correct_var(data))
}

///|
pub fn color_correct_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn color_correct_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = color_correct_std(a)
  let sb = color_correct_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    color_correct_cov(a, b) / (sa * sb)
  }
}

///|
pub fn color_correct_accuracy(
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
pub fn color_correct_mse(
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
pub fn color_correct_mae(
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
pub fn color_correct_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn color_correct_precision(
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
pub fn color_correct_recall(
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
pub fn color_correct_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = color_correct_precision(pred, labels, pos)
  let r = color_correct_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn color_correct_dbl(x : Double) -> String {
  let i = if x >= 0.0 { color_correct_int(x) } else { -color_correct_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    color_correct_int(f * 1000000.0)
  } else {
    color_correct_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn color_correct_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn color_correct_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
