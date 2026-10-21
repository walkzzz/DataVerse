///===
/// datatemporal/throttle
/// S13.231 new

pub struct ThrottlePoint {
  x : Double
  y : Double
  label : Int
}

pub fn throttle_make_point(x : Double, y : Double) -> ThrottlePoint {
  { x, y, label: 0 }
}

pub fn throttle_make_labeled_point(x : Double, y : Double, label : Int) -> ThrottlePoint {
  { x, y, label }
}

pub fn throttle_point_x(p : ThrottlePoint) -> Double { p.x }

pub fn throttle_point_y(p : ThrottlePoint) -> Double { p.y }

pub fn throttle_point_label(p : ThrottlePoint) -> Int { p.label }

pub fn throttle_point_dist(a : ThrottlePoint, b : ThrottlePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn throttle_point_add(a : ThrottlePoint, b : ThrottlePoint) -> ThrottlePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn throttle_point_sub(a : ThrottlePoint, b : ThrottlePoint) -> ThrottlePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn throttle_point_scale(pt : ThrottlePoint, s : Double) -> ThrottlePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn throttle_point_dot(a : ThrottlePoint, b : ThrottlePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn throttle_point_norm(pt : ThrottlePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn throttle_point_to_string(pt : ThrottlePoint) -> String {
  "(" + throttle_dbl(pt.x) + ", " + throttle_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct ThrottleSeries {
  vals : Array[Double]
  name : String
}

pub fn throttle_make_series(vals : Array[Double], name : String) -> ThrottleSeries {
  { vals, name }
}

pub fn throttle_series_len(s : ThrottleSeries) -> Int { s.vals.length() }

pub fn throttle_series_sum(s : ThrottleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn throttle_series_mean(s : ThrottleSeries) -> Double {
  let n = throttle_series_len(s)
  if n == 0 { 0.0 } else { throttle_series_sum(s) / n.to_double() }
}

pub fn throttle_series_min(s : ThrottleSeries) -> Double {
  let n = throttle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn throttle_series_max(s : ThrottleSeries) -> Double {
  let n = throttle_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn throttle_series_var(s : ThrottleSeries) -> Double {
  let n = throttle_series_len(s)
  if n == 0 { 0.0 } else {
    let m = throttle_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn throttle_series_std(s : ThrottleSeries) -> Double { @_common.sqrt(throttle_series_var(s)) }

pub fn throttle_series_scale(s : ThrottleSeries, f : Double) -> ThrottleSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = throttle_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn throttle_series_add(a : ThrottleSeries, b : ThrottleSeries) -> ThrottleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = throttle_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn throttle_series_to_string(s : ThrottleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + throttle_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct ThrottleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn throttle_make_matrix(rows : Int, cols : Int, val : Double) -> ThrottleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn throttle_matrix_identity(n : Int) -> ThrottleMatrix {
  let m = throttle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn throttle_matrix_get(m : ThrottleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn throttle_matrix_transpose(m : ThrottleMatrix) -> ThrottleMatrix {
  let result = throttle_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn throttle_matrix_add(a : ThrottleMatrix, b : ThrottleMatrix) -> ThrottleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = throttle_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn throttle_matrix_scale(m : ThrottleMatrix, s : Double) -> ThrottleMatrix {
  let result = throttle_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn throttle_matrix_multiply(a : ThrottleMatrix, b : ThrottleMatrix) -> ThrottleMatrix {
  if a.cols != b.rows { return throttle_make_matrix(a.rows, b.cols, 0.0) }
  let result = throttle_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn throttle_matrix_trace(m : ThrottleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn throttle_matrix_norm(m : ThrottleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn throttle_matrix_to_string(m : ThrottleMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + throttle_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct ThrottleVector {
  comps : Array[Double]
  dim : Int
}

pub fn throttle_make_vector(comps : Array[Double]) -> ThrottleVector {
  { comps, dim: comps.length() }
}

pub fn throttle_vector_zero(dim : Int) -> ThrottleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn throttle_vector_add(a : ThrottleVector, b : ThrottleVector) -> ThrottleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = throttle_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn throttle_vector_sub(a : ThrottleVector, b : ThrottleVector) -> ThrottleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = throttle_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn throttle_vector_scale(v : ThrottleVector, s : Double) -> ThrottleVector {
  let mut result = []
  for i in 0..<v.dim { result = throttle_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn throttle_vector_dot(a : ThrottleVector, b : ThrottleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn throttle_vector_norm(v : ThrottleVector) -> Double { @_common.sqrt(throttle_vector_dot(v, v)) }

pub fn throttle_vector_normalize(v : ThrottleVector) -> ThrottleVector {
  let n = throttle_vector_norm(v)
  if n < 0.0000001 { v } else { throttle_vector_scale(v, 1.0 / n) }
}

pub fn throttle_vector_dist(a : ThrottleVector, b : ThrottleVector) -> Double {
  throttle_vector_norm(throttle_vector_sub(a, b))
}

pub fn throttle_vector_to_string(v : ThrottleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + throttle_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn throttle_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn throttle_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = throttle_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn throttle_std(data : Array[Double]) -> Double { @_common.sqrt(throttle_var(data)) }

pub fn throttle_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = throttle_mean(a); let mb = throttle_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn throttle_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = throttle_std(a); let sb = throttle_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { throttle_cov(a, b) / (sa * sb) }
}

pub fn throttle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn throttle_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn throttle_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn throttle_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = throttle_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn throttle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn throttle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn throttle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = throttle_precision(pred, labels, pos); let r = throttle_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn throttle_dbl(x : Double) -> String {
  let i = if x >= 0.0 { throttle_int(x) } else { -throttle_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { throttle_int(f * 1000000.0) } else { throttle_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn throttle_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn throttle_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
