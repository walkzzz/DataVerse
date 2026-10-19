///===
/// datatemporal/rate_limit
/// S13.230 new

pub struct Rate_limitPoint {
  x : Double
  y : Double
  label : Int
}

pub fn rate_limit_make_point(x : Double, y : Double) -> Rate_limitPoint {
  { x, y, label: 0 }
}

pub fn rate_limit_make_labeled_point(x : Double, y : Double, label : Int) -> Rate_limitPoint {
  { x, y, label }
}

pub fn rate_limit_point_x(p : Rate_limitPoint) -> Double { p.x }

pub fn rate_limit_point_y(p : Rate_limitPoint) -> Double { p.y }

pub fn rate_limit_point_label(p : Rate_limitPoint) -> Int { p.label }

pub fn rate_limit_point_dist(a : Rate_limitPoint, b : Rate_limitPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  rate_limit_sqrt(dx * dx + dy * dy)
}

pub fn rate_limit_point_add(a : Rate_limitPoint, b : Rate_limitPoint) -> Rate_limitPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn rate_limit_point_sub(a : Rate_limitPoint, b : Rate_limitPoint) -> Rate_limitPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn rate_limit_point_scale(pt : Rate_limitPoint, s : Double) -> Rate_limitPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn rate_limit_point_dot(a : Rate_limitPoint, b : Rate_limitPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn rate_limit_point_norm(pt : Rate_limitPoint) -> Double {
  rate_limit_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn rate_limit_point_to_string(pt : Rate_limitPoint) -> String {
  "(" + rate_limit_dbl(pt.x) + ", " + rate_limit_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Rate_limitSeries {
  vals : Array[Double]
  name : String
}

pub fn rate_limit_make_series(vals : Array[Double], name : String) -> Rate_limitSeries {
  { vals, name }
}

pub fn rate_limit_series_len(s : Rate_limitSeries) -> Int { s.vals.length() }

pub fn rate_limit_series_sum(s : Rate_limitSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn rate_limit_series_mean(s : Rate_limitSeries) -> Double {
  let n = rate_limit_series_len(s)
  if n == 0 { 0.0 } else { rate_limit_series_sum(s) / n.to_double() }
}

pub fn rate_limit_series_min(s : Rate_limitSeries) -> Double {
  let n = rate_limit_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn rate_limit_series_max(s : Rate_limitSeries) -> Double {
  let n = rate_limit_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn rate_limit_series_var(s : Rate_limitSeries) -> Double {
  let n = rate_limit_series_len(s)
  if n == 0 { 0.0 } else {
    let m = rate_limit_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn rate_limit_series_std(s : Rate_limitSeries) -> Double { rate_limit_sqrt(rate_limit_series_var(s)) }

pub fn rate_limit_series_scale(s : Rate_limitSeries, f : Double) -> Rate_limitSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = rate_limit_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn rate_limit_series_add(a : Rate_limitSeries, b : Rate_limitSeries) -> Rate_limitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = rate_limit_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn rate_limit_series_to_string(s : Rate_limitSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + rate_limit_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Rate_limitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn rate_limit_make_matrix(rows : Int, cols : Int, val : Double) -> Rate_limitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn rate_limit_matrix_identity(n : Int) -> Rate_limitMatrix {
  let m = rate_limit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn rate_limit_matrix_get(m : Rate_limitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn rate_limit_matrix_transpose(m : Rate_limitMatrix) -> Rate_limitMatrix {
  let result = rate_limit_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn rate_limit_matrix_add(a : Rate_limitMatrix, b : Rate_limitMatrix) -> Rate_limitMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = rate_limit_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn rate_limit_matrix_scale(m : Rate_limitMatrix, s : Double) -> Rate_limitMatrix {
  let result = rate_limit_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn rate_limit_matrix_multiply(a : Rate_limitMatrix, b : Rate_limitMatrix) -> Rate_limitMatrix {
  if a.cols != b.rows { return rate_limit_make_matrix(a.rows, b.cols, 0.0) }
  let result = rate_limit_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn rate_limit_matrix_trace(m : Rate_limitMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn rate_limit_matrix_norm(m : Rate_limitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  rate_limit_sqrt(sum)
}

pub fn rate_limit_matrix_to_string(m : Rate_limitMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + rate_limit_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Rate_limitVector {
  comps : Array[Double]
  dim : Int
}

pub fn rate_limit_make_vector(comps : Array[Double]) -> Rate_limitVector {
  { comps, dim: comps.length() }
}

pub fn rate_limit_vector_zero(dim : Int) -> Rate_limitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn rate_limit_vector_add(a : Rate_limitVector, b : Rate_limitVector) -> Rate_limitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = rate_limit_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn rate_limit_vector_sub(a : Rate_limitVector, b : Rate_limitVector) -> Rate_limitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = rate_limit_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn rate_limit_vector_scale(v : Rate_limitVector, s : Double) -> Rate_limitVector {
  let mut result = []
  for i in 0..<v.dim { result = rate_limit_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn rate_limit_vector_dot(a : Rate_limitVector, b : Rate_limitVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn rate_limit_vector_norm(v : Rate_limitVector) -> Double { rate_limit_sqrt(rate_limit_vector_dot(v, v)) }

pub fn rate_limit_vector_normalize(v : Rate_limitVector) -> Rate_limitVector {
  let n = rate_limit_vector_norm(v)
  if n < 0.0000001 { v } else { rate_limit_vector_scale(v, 1.0 / n) }
}

pub fn rate_limit_vector_dist(a : Rate_limitVector, b : Rate_limitVector) -> Double {
  rate_limit_vector_norm(rate_limit_vector_sub(a, b))
}

pub fn rate_limit_vector_to_string(v : Rate_limitVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + rate_limit_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn rate_limit_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn rate_limit_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = rate_limit_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn rate_limit_std(data : Array[Double]) -> Double { rate_limit_sqrt(rate_limit_var(data)) }

pub fn rate_limit_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = rate_limit_mean(a); let mb = rate_limit_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn rate_limit_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = rate_limit_std(a); let sb = rate_limit_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { rate_limit_cov(a, b) / (sa * sb) }
}

pub fn rate_limit_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn rate_limit_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn rate_limit_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + rate_limit_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn rate_limit_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = rate_limit_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn rate_limit_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn rate_limit_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn rate_limit_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = rate_limit_precision(pred, labels, pos); let r = rate_limit_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn rate_limit_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn rate_limit_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn rate_limit_dbl(x : Double) -> String {
  let i = if x >= 0.0 { rate_limit_int(x) } else { -rate_limit_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { rate_limit_int(f * 1000000.0) } else { rate_limit_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn rate_limit_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn rate_limit_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
