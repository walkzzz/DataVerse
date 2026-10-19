///===
/// datatemporal/retry_op
/// S13.227 new

pub struct Retry_opPoint {
  x : Double
  y : Double
  label : Int
}

pub fn retry_op_make_point(x : Double, y : Double) -> Retry_opPoint {
  { x, y, label: 0 }
}

pub fn retry_op_make_labeled_point(x : Double, y : Double, label : Int) -> Retry_opPoint {
  { x, y, label }
}

pub fn retry_op_point_x(p : Retry_opPoint) -> Double { p.x }

pub fn retry_op_point_y(p : Retry_opPoint) -> Double { p.y }

pub fn retry_op_point_label(p : Retry_opPoint) -> Int { p.label }

pub fn retry_op_point_dist(a : Retry_opPoint, b : Retry_opPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  retry_op_sqrt(dx * dx + dy * dy)
}

pub fn retry_op_point_add(a : Retry_opPoint, b : Retry_opPoint) -> Retry_opPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn retry_op_point_sub(a : Retry_opPoint, b : Retry_opPoint) -> Retry_opPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn retry_op_point_scale(pt : Retry_opPoint, s : Double) -> Retry_opPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn retry_op_point_dot(a : Retry_opPoint, b : Retry_opPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn retry_op_point_norm(pt : Retry_opPoint) -> Double {
  retry_op_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn retry_op_point_to_string(pt : Retry_opPoint) -> String {
  "(" + retry_op_dbl(pt.x) + ", " + retry_op_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Retry_opSeries {
  vals : Array[Double]
  name : String
}

pub fn retry_op_make_series(vals : Array[Double], name : String) -> Retry_opSeries {
  { vals, name }
}

pub fn retry_op_series_len(s : Retry_opSeries) -> Int { s.vals.length() }

pub fn retry_op_series_sum(s : Retry_opSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn retry_op_series_mean(s : Retry_opSeries) -> Double {
  let n = retry_op_series_len(s)
  if n == 0 { 0.0 } else { retry_op_series_sum(s) / n.to_double() }
}

pub fn retry_op_series_min(s : Retry_opSeries) -> Double {
  let n = retry_op_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn retry_op_series_max(s : Retry_opSeries) -> Double {
  let n = retry_op_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn retry_op_series_var(s : Retry_opSeries) -> Double {
  let n = retry_op_series_len(s)
  if n == 0 { 0.0 } else {
    let m = retry_op_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn retry_op_series_std(s : Retry_opSeries) -> Double { retry_op_sqrt(retry_op_series_var(s)) }

pub fn retry_op_series_scale(s : Retry_opSeries, f : Double) -> Retry_opSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = retry_op_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn retry_op_series_add(a : Retry_opSeries, b : Retry_opSeries) -> Retry_opSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = retry_op_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn retry_op_series_to_string(s : Retry_opSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + retry_op_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Retry_opMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn retry_op_make_matrix(rows : Int, cols : Int, val : Double) -> Retry_opMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn retry_op_matrix_identity(n : Int) -> Retry_opMatrix {
  let m = retry_op_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn retry_op_matrix_get(m : Retry_opMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn retry_op_matrix_transpose(m : Retry_opMatrix) -> Retry_opMatrix {
  let result = retry_op_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn retry_op_matrix_add(a : Retry_opMatrix, b : Retry_opMatrix) -> Retry_opMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = retry_op_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn retry_op_matrix_scale(m : Retry_opMatrix, s : Double) -> Retry_opMatrix {
  let result = retry_op_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn retry_op_matrix_multiply(a : Retry_opMatrix, b : Retry_opMatrix) -> Retry_opMatrix {
  if a.cols != b.rows { return retry_op_make_matrix(a.rows, b.cols, 0.0) }
  let result = retry_op_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn retry_op_matrix_trace(m : Retry_opMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn retry_op_matrix_norm(m : Retry_opMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  retry_op_sqrt(sum)
}

pub fn retry_op_matrix_to_string(m : Retry_opMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + retry_op_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Retry_opVector {
  comps : Array[Double]
  dim : Int
}

pub fn retry_op_make_vector(comps : Array[Double]) -> Retry_opVector {
  { comps, dim: comps.length() }
}

pub fn retry_op_vector_zero(dim : Int) -> Retry_opVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn retry_op_vector_add(a : Retry_opVector, b : Retry_opVector) -> Retry_opVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = retry_op_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn retry_op_vector_sub(a : Retry_opVector, b : Retry_opVector) -> Retry_opVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = retry_op_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn retry_op_vector_scale(v : Retry_opVector, s : Double) -> Retry_opVector {
  let mut result = []
  for i in 0..<v.dim { result = retry_op_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn retry_op_vector_dot(a : Retry_opVector, b : Retry_opVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn retry_op_vector_norm(v : Retry_opVector) -> Double { retry_op_sqrt(retry_op_vector_dot(v, v)) }

pub fn retry_op_vector_normalize(v : Retry_opVector) -> Retry_opVector {
  let n = retry_op_vector_norm(v)
  if n < 0.0000001 { v } else { retry_op_vector_scale(v, 1.0 / n) }
}

pub fn retry_op_vector_dist(a : Retry_opVector, b : Retry_opVector) -> Double {
  retry_op_vector_norm(retry_op_vector_sub(a, b))
}

pub fn retry_op_vector_to_string(v : Retry_opVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + retry_op_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn retry_op_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn retry_op_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = retry_op_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn retry_op_std(data : Array[Double]) -> Double { retry_op_sqrt(retry_op_var(data)) }

pub fn retry_op_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = retry_op_mean(a); let mb = retry_op_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn retry_op_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = retry_op_std(a); let sb = retry_op_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { retry_op_cov(a, b) / (sa * sb) }
}

pub fn retry_op_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn retry_op_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn retry_op_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + retry_op_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn retry_op_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = retry_op_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn retry_op_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn retry_op_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn retry_op_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = retry_op_precision(pred, labels, pos); let r = retry_op_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn retry_op_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn retry_op_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn retry_op_dbl(x : Double) -> String {
  let i = if x >= 0.0 { retry_op_int(x) } else { -retry_op_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { retry_op_int(f * 1000000.0) } else { retry_op_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn retry_op_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn retry_op_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
