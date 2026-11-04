///|
///===
/// datatemporal/window_slide
/// S13.208 new
pub struct Window_slidePoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn window_slide_make_point(x : Double, y : Double) -> Window_slidePoint {
  { x, y, label: 0, }
}

///|
pub fn window_slide_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Window_slidePoint {
  { x, y, label, }
}

///|
pub fn window_slide_point_x(p : Window_slidePoint) -> Double {
  p.x
}

///|
pub fn window_slide_point_y(p : Window_slidePoint) -> Double {
  p.y
}

///|
pub fn window_slide_point_label(p : Window_slidePoint) -> Int32 {
  p.label
}

///|
pub fn window_slide_point_dist(
  a : Window_slidePoint,
  b : Window_slidePoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn window_slide_point_add(
  a : Window_slidePoint,
  b : Window_slidePoint,
) -> Window_slidePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn window_slide_point_sub(
  a : Window_slidePoint,
  b : Window_slidePoint,
) -> Window_slidePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn window_slide_point_scale(
  pt : Window_slidePoint,
  s : Double,
) -> Window_slidePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn window_slide_point_dot(
  a : Window_slidePoint,
  b : Window_slidePoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn window_slide_point_norm(pt : Window_slidePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn window_slide_point_to_string(pt : Window_slidePoint) -> String {
  "(" +
  window_slide_dbl(pt.x) +
  ", " +
  window_slide_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Window_slideSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn window_slide_make_series(
  vals : Array[Double],
  name : String,
) -> Window_slideSeries {
  { vals, name, }
}

///|
pub fn window_slide_series_len(s : Window_slideSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn window_slide_series_sum(s : Window_slideSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn window_slide_series_mean(s : Window_slideSeries) -> Double {
  let n = window_slide_series_len(s)
  if n == 0 {
    0.0
  } else {
    window_slide_series_sum(s) / n.to_double()
  }
}

///|
pub fn window_slide_series_min(s : Window_slideSeries) -> Double {
  let n = window_slide_series_len(s)
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
pub fn window_slide_series_max(s : Window_slideSeries) -> Double {
  let n = window_slide_series_len(s)
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
pub fn window_slide_series_var(s : Window_slideSeries) -> Double {
  let n = window_slide_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = window_slide_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn window_slide_series_std(s : Window_slideSeries) -> Double {
  @_common.sqrt(window_slide_series_var(s))
}

///|
pub fn window_slide_series_scale(
  s : Window_slideSeries,
  f : Double,
) -> Window_slideSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = window_slide_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn window_slide_series_add(
  a : Window_slideSeries,
  b : Window_slideSeries,
) -> Window_slideSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = window_slide_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn window_slide_series_to_string(s : Window_slideSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + window_slide_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Window_slideMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn window_slide_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Window_slideMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn window_slide_matrix_identity(n : Int32) -> Window_slideMatrix {
  let m = window_slide_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn window_slide_matrix_get(
  m : Window_slideMatrix,
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
pub fn window_slide_matrix_transpose(
  m : Window_slideMatrix,
) -> Window_slideMatrix {
  let result = window_slide_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn window_slide_matrix_add(
  a : Window_slideMatrix,
  b : Window_slideMatrix,
) -> Window_slideMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = window_slide_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn window_slide_matrix_scale(
  m : Window_slideMatrix,
  s : Double,
) -> Window_slideMatrix {
  let result = window_slide_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn window_slide_matrix_multiply(
  a : Window_slideMatrix,
  b : Window_slideMatrix,
) -> Window_slideMatrix {
  if a.cols != b.rows {
    return window_slide_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = window_slide_make_matrix(a.rows, b.cols, 0.0)
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
pub fn window_slide_matrix_trace(m : Window_slideMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn window_slide_matrix_norm(m : Window_slideMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn window_slide_matrix_to_string(m : Window_slideMatrix) -> String {
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
      result = result + window_slide_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Window_slideVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn window_slide_make_vector(comps : Array[Double]) -> Window_slideVector {
  { comps, dim: comps.length(), }
}

///|
pub fn window_slide_vector_zero(dim : Int32) -> Window_slideVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn window_slide_vector_add(
  a : Window_slideVector,
  b : Window_slideVector,
) -> Window_slideVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = window_slide_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn window_slide_vector_sub(
  a : Window_slideVector,
  b : Window_slideVector,
) -> Window_slideVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = window_slide_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn window_slide_vector_scale(
  v : Window_slideVector,
  s : Double,
) -> Window_slideVector {
  let mut result = []
  for i in 0..<v.dim {
    result = window_slide_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn window_slide_vector_dot(
  a : Window_slideVector,
  b : Window_slideVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn window_slide_vector_norm(v : Window_slideVector) -> Double {
  @_common.sqrt(window_slide_vector_dot(v, v))
}

///|
pub fn window_slide_vector_normalize(
  v : Window_slideVector,
) -> Window_slideVector {
  let n = window_slide_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    window_slide_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn window_slide_vector_dist(
  a : Window_slideVector,
  b : Window_slideVector,
) -> Double {
  window_slide_vector_norm(window_slide_vector_sub(a, b))
}

///|
pub fn window_slide_vector_to_string(v : Window_slideVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + window_slide_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn window_slide_var(data : Array[Double]) -> Double {
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
pub fn window_slide_std(data : Array[Double]) -> Double {
  @_common.sqrt(window_slide_var(data))
}

///|
pub fn window_slide_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn window_slide_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = window_slide_std(a)
  let sb = window_slide_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    window_slide_cov(a, b) / (sa * sb)
  }
}

///|
pub fn window_slide_accuracy(
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
pub fn window_slide_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn window_slide_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn window_slide_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn window_slide_precision(
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
pub fn window_slide_recall(
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
pub fn window_slide_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = window_slide_precision(pred, labels, pos)
  let r = window_slide_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn window_slide_dbl(x : Double) -> String {
  let i = if x >= 0.0 { window_slide_int(x) } else { -window_slide_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    window_slide_int(f * 1000000.0)
  } else {
    window_slide_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn window_slide_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn window_slide_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}
