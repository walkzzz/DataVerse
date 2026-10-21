///===
/// learncore/logit_boost
/// S13.94 new

pub struct Logit_boostPoint {
  x : Double
  y : Double
  label : Int
}

pub fn logit_boost_make_point(x : Double, y : Double) -> Logit_boostPoint {
  { x, y, label: 0 }
}

pub fn logit_boost_make_labeled_point(x : Double, y : Double, label : Int) -> Logit_boostPoint {
  { x, y, label }
}

pub fn logit_boost_point_x(p : Logit_boostPoint) -> Double { p.x }

pub fn logit_boost_point_y(p : Logit_boostPoint) -> Double { p.y }

pub fn logit_boost_point_label(p : Logit_boostPoint) -> Int { p.label }

pub fn logit_boost_point_dist(a : Logit_boostPoint, b : Logit_boostPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn logit_boost_point_add(a : Logit_boostPoint, b : Logit_boostPoint) -> Logit_boostPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn logit_boost_point_sub(a : Logit_boostPoint, b : Logit_boostPoint) -> Logit_boostPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn logit_boost_point_scale(pt : Logit_boostPoint, s : Double) -> Logit_boostPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn logit_boost_point_dot(a : Logit_boostPoint, b : Logit_boostPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn logit_boost_point_norm(pt : Logit_boostPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn logit_boost_point_to_string(pt : Logit_boostPoint) -> String {
  "(" + logit_boost_dbl(pt.x) + ", " + logit_boost_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Logit_boostSeries {
  vals : Array[Double]
  name : String
}

pub fn logit_boost_make_series(vals : Array[Double], name : String) -> Logit_boostSeries {
  { vals, name }
}

pub fn logit_boost_series_len(s : Logit_boostSeries) -> Int { s.vals.length() }

pub fn logit_boost_series_sum(s : Logit_boostSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn logit_boost_series_mean(s : Logit_boostSeries) -> Double {
  let n = logit_boost_series_len(s)
  if n == 0 { 0.0 } else { logit_boost_series_sum(s) / n.to_double() }
}

pub fn logit_boost_series_min(s : Logit_boostSeries) -> Double {
  let n = logit_boost_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn logit_boost_series_max(s : Logit_boostSeries) -> Double {
  let n = logit_boost_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn logit_boost_series_var(s : Logit_boostSeries) -> Double {
  let n = logit_boost_series_len(s)
  if n == 0 { 0.0 } else {
    let m = logit_boost_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn logit_boost_series_std(s : Logit_boostSeries) -> Double { @_common.sqrt(logit_boost_series_var(s)) }

pub fn logit_boost_series_scale(s : Logit_boostSeries, f : Double) -> Logit_boostSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = logit_boost_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn logit_boost_series_add(a : Logit_boostSeries, b : Logit_boostSeries) -> Logit_boostSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = logit_boost_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn logit_boost_series_to_string(s : Logit_boostSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + logit_boost_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Logit_boostMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn logit_boost_make_matrix(rows : Int, cols : Int, val : Double) -> Logit_boostMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn logit_boost_matrix_identity(n : Int) -> Logit_boostMatrix {
  let m = logit_boost_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn logit_boost_matrix_get(m : Logit_boostMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn logit_boost_matrix_transpose(m : Logit_boostMatrix) -> Logit_boostMatrix {
  let result = logit_boost_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn logit_boost_matrix_add(a : Logit_boostMatrix, b : Logit_boostMatrix) -> Logit_boostMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = logit_boost_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn logit_boost_matrix_scale(m : Logit_boostMatrix, s : Double) -> Logit_boostMatrix {
  let result = logit_boost_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn logit_boost_matrix_multiply(a : Logit_boostMatrix, b : Logit_boostMatrix) -> Logit_boostMatrix {
  if a.cols != b.rows { return logit_boost_make_matrix(a.rows, b.cols, 0.0) }
  let result = logit_boost_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn logit_boost_matrix_trace(m : Logit_boostMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn logit_boost_matrix_norm(m : Logit_boostMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn logit_boost_matrix_to_string(m : Logit_boostMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + logit_boost_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Logit_boostVector {
  comps : Array[Double]
  dim : Int
}

pub fn logit_boost_make_vector(comps : Array[Double]) -> Logit_boostVector {
  { comps, dim: comps.length() }
}

pub fn logit_boost_vector_zero(dim : Int) -> Logit_boostVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn logit_boost_vector_add(a : Logit_boostVector, b : Logit_boostVector) -> Logit_boostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = logit_boost_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn logit_boost_vector_sub(a : Logit_boostVector, b : Logit_boostVector) -> Logit_boostVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = logit_boost_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn logit_boost_vector_scale(v : Logit_boostVector, s : Double) -> Logit_boostVector {
  let mut result = []
  for i in 0..<v.dim { result = logit_boost_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn logit_boost_vector_dot(a : Logit_boostVector, b : Logit_boostVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn logit_boost_vector_norm(v : Logit_boostVector) -> Double { @_common.sqrt(logit_boost_vector_dot(v, v)) }

pub fn logit_boost_vector_normalize(v : Logit_boostVector) -> Logit_boostVector {
  let n = logit_boost_vector_norm(v)
  if n < 0.0000001 { v } else { logit_boost_vector_scale(v, 1.0 / n) }
}

pub fn logit_boost_vector_dist(a : Logit_boostVector, b : Logit_boostVector) -> Double {
  logit_boost_vector_norm(logit_boost_vector_sub(a, b))
}

pub fn logit_boost_vector_to_string(v : Logit_boostVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + logit_boost_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn logit_boost_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn logit_boost_std(data : Array[Double]) -> Double { @_common.sqrt(logit_boost_var(data)) }

pub fn logit_boost_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn logit_boost_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = logit_boost_std(a); let sb = logit_boost_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { logit_boost_cov(a, b) / (sa * sb) }
}

pub fn logit_boost_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn logit_boost_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn logit_boost_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn logit_boost_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn logit_boost_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn logit_boost_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn logit_boost_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = logit_boost_precision(pred, labels, pos); let r = logit_boost_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn logit_boost_dbl(x : Double) -> String {
  let i = if x >= 0.0 { logit_boost_int(x) } else { -logit_boost_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { logit_boost_int(f * 1000000.0) } else { logit_boost_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn logit_boost_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn logit_boost_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
