///===
/// datatemporal/window_global
/// S13.210 new

pub struct Window_globalPoint {
  x : Double
  y : Double
  label : Int
}

pub fn window_global_make_point(x : Double, y : Double) -> Window_globalPoint {
  { x, y, label: 0 }
}

pub fn window_global_make_labeled_point(x : Double, y : Double, label : Int) -> Window_globalPoint {
  { x, y, label }
}

pub fn window_global_point_x(p : Window_globalPoint) -> Double { p.x }

pub fn window_global_point_y(p : Window_globalPoint) -> Double { p.y }

pub fn window_global_point_label(p : Window_globalPoint) -> Int { p.label }

pub fn window_global_point_dist(a : Window_globalPoint, b : Window_globalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  window_global_sqrt(dx * dx + dy * dy)
}

pub fn window_global_point_add(a : Window_globalPoint, b : Window_globalPoint) -> Window_globalPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn window_global_point_sub(a : Window_globalPoint, b : Window_globalPoint) -> Window_globalPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn window_global_point_scale(pt : Window_globalPoint, s : Double) -> Window_globalPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn window_global_point_dot(a : Window_globalPoint, b : Window_globalPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn window_global_point_norm(pt : Window_globalPoint) -> Double {
  window_global_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn window_global_point_to_string(pt : Window_globalPoint) -> String {
  "(" + window_global_dbl(pt.x) + ", " + window_global_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Window_globalSeries {
  vals : Array[Double]
  name : String
}

pub fn window_global_make_series(vals : Array[Double], name : String) -> Window_globalSeries {
  { vals, name }
}

pub fn window_global_series_len(s : Window_globalSeries) -> Int { s.vals.length() }

pub fn window_global_series_sum(s : Window_globalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn window_global_series_mean(s : Window_globalSeries) -> Double {
  let n = window_global_series_len(s)
  if n == 0 { 0.0 } else { window_global_series_sum(s) / n.to_double() }
}

pub fn window_global_series_min(s : Window_globalSeries) -> Double {
  let n = window_global_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn window_global_series_max(s : Window_globalSeries) -> Double {
  let n = window_global_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn window_global_series_var(s : Window_globalSeries) -> Double {
  let n = window_global_series_len(s)
  if n == 0 { 0.0 } else {
    let m = window_global_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn window_global_series_std(s : Window_globalSeries) -> Double { window_global_sqrt(window_global_series_var(s)) }

pub fn window_global_series_scale(s : Window_globalSeries, f : Double) -> Window_globalSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = window_global_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn window_global_series_add(a : Window_globalSeries, b : Window_globalSeries) -> Window_globalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = window_global_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn window_global_series_to_string(s : Window_globalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + window_global_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Window_globalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn window_global_make_matrix(rows : Int, cols : Int, val : Double) -> Window_globalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn window_global_matrix_identity(n : Int) -> Window_globalMatrix {
  let m = window_global_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn window_global_matrix_get(m : Window_globalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn window_global_matrix_transpose(m : Window_globalMatrix) -> Window_globalMatrix {
  let result = window_global_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn window_global_matrix_add(a : Window_globalMatrix, b : Window_globalMatrix) -> Window_globalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = window_global_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn window_global_matrix_scale(m : Window_globalMatrix, s : Double) -> Window_globalMatrix {
  let result = window_global_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn window_global_matrix_multiply(a : Window_globalMatrix, b : Window_globalMatrix) -> Window_globalMatrix {
  if a.cols != b.rows { return window_global_make_matrix(a.rows, b.cols, 0.0) }
  let result = window_global_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn window_global_matrix_trace(m : Window_globalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn window_global_matrix_norm(m : Window_globalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  window_global_sqrt(sum)
}

pub fn window_global_matrix_to_string(m : Window_globalMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + window_global_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Window_globalVector {
  comps : Array[Double]
  dim : Int
}

pub fn window_global_make_vector(comps : Array[Double]) -> Window_globalVector {
  { comps, dim: comps.length() }
}

pub fn window_global_vector_zero(dim : Int) -> Window_globalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn window_global_vector_add(a : Window_globalVector, b : Window_globalVector) -> Window_globalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = window_global_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn window_global_vector_sub(a : Window_globalVector, b : Window_globalVector) -> Window_globalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = window_global_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn window_global_vector_scale(v : Window_globalVector, s : Double) -> Window_globalVector {
  let mut result = []
  for i in 0..<v.dim { result = window_global_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn window_global_vector_dot(a : Window_globalVector, b : Window_globalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn window_global_vector_norm(v : Window_globalVector) -> Double { window_global_sqrt(window_global_vector_dot(v, v)) }

pub fn window_global_vector_normalize(v : Window_globalVector) -> Window_globalVector {
  let n = window_global_vector_norm(v)
  if n < 0.0000001 { v } else { window_global_vector_scale(v, 1.0 / n) }
}

pub fn window_global_vector_dist(a : Window_globalVector, b : Window_globalVector) -> Double {
  window_global_vector_norm(window_global_vector_sub(a, b))
}

pub fn window_global_vector_to_string(v : Window_globalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + window_global_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn window_global_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn window_global_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = window_global_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn window_global_std(data : Array[Double]) -> Double { window_global_sqrt(window_global_var(data)) }

pub fn window_global_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = window_global_mean(a); let mb = window_global_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn window_global_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = window_global_std(a); let sb = window_global_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { window_global_cov(a, b) / (sa * sb) }
}

pub fn window_global_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn window_global_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn window_global_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + window_global_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn window_global_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = window_global_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn window_global_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn window_global_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn window_global_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = window_global_precision(pred, labels, pos); let r = window_global_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn window_global_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn window_global_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn window_global_dbl(x : Double) -> String {
  let i = if x >= 0.0 { window_global_int(x) } else { -window_global_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { window_global_int(f * 1000000.0) } else { window_global_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn window_global_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn window_global_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
