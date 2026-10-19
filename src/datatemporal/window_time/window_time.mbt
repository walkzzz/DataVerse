///===
/// datatemporal/window_time
/// S13.212 new

pub struct Window_timePoint {
  x : Double
  y : Double
  label : Int
}

pub fn window_time_make_point(x : Double, y : Double) -> Window_timePoint {
  { x, y, label: 0 }
}

pub fn window_time_make_labeled_point(x : Double, y : Double, label : Int) -> Window_timePoint {
  { x, y, label }
}

pub fn window_time_point_x(p : Window_timePoint) -> Double { p.x }

pub fn window_time_point_y(p : Window_timePoint) -> Double { p.y }

pub fn window_time_point_label(p : Window_timePoint) -> Int { p.label }

pub fn window_time_point_dist(a : Window_timePoint, b : Window_timePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  window_time_sqrt(dx * dx + dy * dy)
}

pub fn window_time_point_add(a : Window_timePoint, b : Window_timePoint) -> Window_timePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn window_time_point_sub(a : Window_timePoint, b : Window_timePoint) -> Window_timePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn window_time_point_scale(pt : Window_timePoint, s : Double) -> Window_timePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn window_time_point_dot(a : Window_timePoint, b : Window_timePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn window_time_point_norm(pt : Window_timePoint) -> Double {
  window_time_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn window_time_point_to_string(pt : Window_timePoint) -> String {
  "(" + window_time_dbl(pt.x) + ", " + window_time_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Window_timeSeries {
  vals : Array[Double]
  name : String
}

pub fn window_time_make_series(vals : Array[Double], name : String) -> Window_timeSeries {
  { vals, name }
}

pub fn window_time_series_len(s : Window_timeSeries) -> Int { s.vals.length() }

pub fn window_time_series_sum(s : Window_timeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn window_time_series_mean(s : Window_timeSeries) -> Double {
  let n = window_time_series_len(s)
  if n == 0 { 0.0 } else { window_time_series_sum(s) / n.to_double() }
}

pub fn window_time_series_min(s : Window_timeSeries) -> Double {
  let n = window_time_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn window_time_series_max(s : Window_timeSeries) -> Double {
  let n = window_time_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn window_time_series_var(s : Window_timeSeries) -> Double {
  let n = window_time_series_len(s)
  if n == 0 { 0.0 } else {
    let m = window_time_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn window_time_series_std(s : Window_timeSeries) -> Double { window_time_sqrt(window_time_series_var(s)) }

pub fn window_time_series_scale(s : Window_timeSeries, f : Double) -> Window_timeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = window_time_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn window_time_series_add(a : Window_timeSeries, b : Window_timeSeries) -> Window_timeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = window_time_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn window_time_series_to_string(s : Window_timeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + window_time_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Window_timeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn window_time_make_matrix(rows : Int, cols : Int, val : Double) -> Window_timeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn window_time_matrix_identity(n : Int) -> Window_timeMatrix {
  let m = window_time_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn window_time_matrix_get(m : Window_timeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn window_time_matrix_transpose(m : Window_timeMatrix) -> Window_timeMatrix {
  let result = window_time_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn window_time_matrix_add(a : Window_timeMatrix, b : Window_timeMatrix) -> Window_timeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = window_time_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn window_time_matrix_scale(m : Window_timeMatrix, s : Double) -> Window_timeMatrix {
  let result = window_time_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn window_time_matrix_multiply(a : Window_timeMatrix, b : Window_timeMatrix) -> Window_timeMatrix {
  if a.cols != b.rows { return window_time_make_matrix(a.rows, b.cols, 0.0) }
  let result = window_time_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn window_time_matrix_trace(m : Window_timeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn window_time_matrix_norm(m : Window_timeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  window_time_sqrt(sum)
}

pub fn window_time_matrix_to_string(m : Window_timeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + window_time_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Window_timeVector {
  comps : Array[Double]
  dim : Int
}

pub fn window_time_make_vector(comps : Array[Double]) -> Window_timeVector {
  { comps, dim: comps.length() }
}

pub fn window_time_vector_zero(dim : Int) -> Window_timeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn window_time_vector_add(a : Window_timeVector, b : Window_timeVector) -> Window_timeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = window_time_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn window_time_vector_sub(a : Window_timeVector, b : Window_timeVector) -> Window_timeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = window_time_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn window_time_vector_scale(v : Window_timeVector, s : Double) -> Window_timeVector {
  let mut result = []
  for i in 0..<v.dim { result = window_time_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn window_time_vector_dot(a : Window_timeVector, b : Window_timeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn window_time_vector_norm(v : Window_timeVector) -> Double { window_time_sqrt(window_time_vector_dot(v, v)) }

pub fn window_time_vector_normalize(v : Window_timeVector) -> Window_timeVector {
  let n = window_time_vector_norm(v)
  if n < 0.0000001 { v } else { window_time_vector_scale(v, 1.0 / n) }
}

pub fn window_time_vector_dist(a : Window_timeVector, b : Window_timeVector) -> Double {
  window_time_vector_norm(window_time_vector_sub(a, b))
}

pub fn window_time_vector_to_string(v : Window_timeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + window_time_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn window_time_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn window_time_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = window_time_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn window_time_std(data : Array[Double]) -> Double { window_time_sqrt(window_time_var(data)) }

pub fn window_time_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = window_time_mean(a); let mb = window_time_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn window_time_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = window_time_std(a); let sb = window_time_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { window_time_cov(a, b) / (sa * sb) }
}

pub fn window_time_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn window_time_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn window_time_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + window_time_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn window_time_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = window_time_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn window_time_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn window_time_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn window_time_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = window_time_precision(pred, labels, pos); let r = window_time_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn window_time_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn window_time_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn window_time_dbl(x : Double) -> String {
  let i = if x >= 0.0 { window_time_int(x) } else { -window_time_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { window_time_int(f * 1000000.0) } else { window_time_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn window_time_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn window_time_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
