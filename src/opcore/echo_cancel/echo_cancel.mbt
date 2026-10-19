///===
/// opcore/echo_cancel
/// S13.38 new

pub struct Echo_cancelPoint {
  x : Double
  y : Double
  label : Int
}

pub fn echo_cancel_make_point(x : Double, y : Double) -> Echo_cancelPoint {
  { x, y, label: 0 }
}

pub fn echo_cancel_make_labeled_point(x : Double, y : Double, label : Int) -> Echo_cancelPoint {
  { x, y, label }
}

pub fn echo_cancel_point_x(p : Echo_cancelPoint) -> Double { p.x }

pub fn echo_cancel_point_y(p : Echo_cancelPoint) -> Double { p.y }

pub fn echo_cancel_point_label(p : Echo_cancelPoint) -> Int { p.label }

pub fn echo_cancel_point_dist(a : Echo_cancelPoint, b : Echo_cancelPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  echo_cancel_sqrt(dx * dx + dy * dy)
}

pub fn echo_cancel_point_add(a : Echo_cancelPoint, b : Echo_cancelPoint) -> Echo_cancelPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn echo_cancel_point_sub(a : Echo_cancelPoint, b : Echo_cancelPoint) -> Echo_cancelPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn echo_cancel_point_scale(pt : Echo_cancelPoint, s : Double) -> Echo_cancelPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn echo_cancel_point_dot(a : Echo_cancelPoint, b : Echo_cancelPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn echo_cancel_point_norm(pt : Echo_cancelPoint) -> Double {
  echo_cancel_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn echo_cancel_point_to_string(pt : Echo_cancelPoint) -> String {
  "(" + echo_cancel_dbl(pt.x) + ", " + echo_cancel_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Echo_cancelSeries {
  vals : Array[Double]
  name : String
}

pub fn echo_cancel_make_series(vals : Array[Double], name : String) -> Echo_cancelSeries {
  { vals, name }
}

pub fn echo_cancel_series_len(s : Echo_cancelSeries) -> Int { s.vals.length() }

pub fn echo_cancel_series_sum(s : Echo_cancelSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn echo_cancel_series_mean(s : Echo_cancelSeries) -> Double {
  let n = echo_cancel_series_len(s)
  if n == 0 { 0.0 } else { echo_cancel_series_sum(s) / n.to_double() }
}

pub fn echo_cancel_series_min(s : Echo_cancelSeries) -> Double {
  let n = echo_cancel_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn echo_cancel_series_max(s : Echo_cancelSeries) -> Double {
  let n = echo_cancel_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn echo_cancel_series_var(s : Echo_cancelSeries) -> Double {
  let n = echo_cancel_series_len(s)
  if n == 0 { 0.0 } else {
    let m = echo_cancel_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn echo_cancel_series_std(s : Echo_cancelSeries) -> Double { echo_cancel_sqrt(echo_cancel_series_var(s)) }

pub fn echo_cancel_series_scale(s : Echo_cancelSeries, f : Double) -> Echo_cancelSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = echo_cancel_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn echo_cancel_series_add(a : Echo_cancelSeries, b : Echo_cancelSeries) -> Echo_cancelSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = echo_cancel_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn echo_cancel_series_to_string(s : Echo_cancelSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + echo_cancel_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Echo_cancelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn echo_cancel_make_matrix(rows : Int, cols : Int, val : Double) -> Echo_cancelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn echo_cancel_matrix_identity(n : Int) -> Echo_cancelMatrix {
  let m = echo_cancel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn echo_cancel_matrix_get(m : Echo_cancelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn echo_cancel_matrix_transpose(m : Echo_cancelMatrix) -> Echo_cancelMatrix {
  let result = echo_cancel_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn echo_cancel_matrix_add(a : Echo_cancelMatrix, b : Echo_cancelMatrix) -> Echo_cancelMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = echo_cancel_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn echo_cancel_matrix_scale(m : Echo_cancelMatrix, s : Double) -> Echo_cancelMatrix {
  let result = echo_cancel_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn echo_cancel_matrix_multiply(a : Echo_cancelMatrix, b : Echo_cancelMatrix) -> Echo_cancelMatrix {
  if a.cols != b.rows { return echo_cancel_make_matrix(a.rows, b.cols, 0.0) }
  let result = echo_cancel_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn echo_cancel_matrix_trace(m : Echo_cancelMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn echo_cancel_matrix_norm(m : Echo_cancelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  echo_cancel_sqrt(sum)
}

pub fn echo_cancel_matrix_to_string(m : Echo_cancelMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + echo_cancel_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Echo_cancelVector {
  comps : Array[Double]
  dim : Int
}

pub fn echo_cancel_make_vector(comps : Array[Double]) -> Echo_cancelVector {
  { comps, dim: comps.length() }
}

pub fn echo_cancel_vector_zero(dim : Int) -> Echo_cancelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn echo_cancel_vector_add(a : Echo_cancelVector, b : Echo_cancelVector) -> Echo_cancelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = echo_cancel_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn echo_cancel_vector_sub(a : Echo_cancelVector, b : Echo_cancelVector) -> Echo_cancelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = echo_cancel_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn echo_cancel_vector_scale(v : Echo_cancelVector, s : Double) -> Echo_cancelVector {
  let mut result = []
  for i in 0..<v.dim { result = echo_cancel_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn echo_cancel_vector_dot(a : Echo_cancelVector, b : Echo_cancelVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn echo_cancel_vector_norm(v : Echo_cancelVector) -> Double { echo_cancel_sqrt(echo_cancel_vector_dot(v, v)) }

pub fn echo_cancel_vector_normalize(v : Echo_cancelVector) -> Echo_cancelVector {
  let n = echo_cancel_vector_norm(v)
  if n < 0.0000001 { v } else { echo_cancel_vector_scale(v, 1.0 / n) }
}

pub fn echo_cancel_vector_dist(a : Echo_cancelVector, b : Echo_cancelVector) -> Double {
  echo_cancel_vector_norm(echo_cancel_vector_sub(a, b))
}

pub fn echo_cancel_vector_to_string(v : Echo_cancelVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + echo_cancel_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn echo_cancel_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn echo_cancel_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = echo_cancel_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn echo_cancel_std(data : Array[Double]) -> Double { echo_cancel_sqrt(echo_cancel_var(data)) }

pub fn echo_cancel_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = echo_cancel_mean(a); let mb = echo_cancel_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn echo_cancel_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = echo_cancel_std(a); let sb = echo_cancel_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { echo_cancel_cov(a, b) / (sa * sb) }
}

pub fn echo_cancel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn echo_cancel_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn echo_cancel_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + echo_cancel_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn echo_cancel_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = echo_cancel_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn echo_cancel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn echo_cancel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn echo_cancel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = echo_cancel_precision(pred, labels, pos); let r = echo_cancel_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn echo_cancel_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn echo_cancel_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn echo_cancel_dbl(x : Double) -> String {
  let i = if x >= 0.0 { echo_cancel_int(x) } else { -echo_cancel_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { echo_cancel_int(f * 1000000.0) } else { echo_cancel_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn echo_cancel_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn echo_cancel_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
