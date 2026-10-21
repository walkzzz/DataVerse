///===
/// opcore/markov_chain
/// S13.20 new

pub struct Markov_chainPoint {
  x : Double
  y : Double
  label : Int
}

pub fn markov_chain_make_point(x : Double, y : Double) -> Markov_chainPoint {
  { x, y, label: 0 }
}

pub fn markov_chain_make_labeled_point(x : Double, y : Double, label : Int) -> Markov_chainPoint {
  { x, y, label }
}

pub fn markov_chain_point_x(p : Markov_chainPoint) -> Double { p.x }

pub fn markov_chain_point_y(p : Markov_chainPoint) -> Double { p.y }

pub fn markov_chain_point_label(p : Markov_chainPoint) -> Int { p.label }

pub fn markov_chain_point_dist(a : Markov_chainPoint, b : Markov_chainPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn markov_chain_point_add(a : Markov_chainPoint, b : Markov_chainPoint) -> Markov_chainPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn markov_chain_point_sub(a : Markov_chainPoint, b : Markov_chainPoint) -> Markov_chainPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn markov_chain_point_scale(pt : Markov_chainPoint, s : Double) -> Markov_chainPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn markov_chain_point_dot(a : Markov_chainPoint, b : Markov_chainPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn markov_chain_point_norm(pt : Markov_chainPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn markov_chain_point_to_string(pt : Markov_chainPoint) -> String {
  "(" + markov_chain_dbl(pt.x) + ", " + markov_chain_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Markov_chainSeries {
  vals : Array[Double]
  name : String
}

pub fn markov_chain_make_series(vals : Array[Double], name : String) -> Markov_chainSeries {
  { vals, name }
}

pub fn markov_chain_series_len(s : Markov_chainSeries) -> Int { s.vals.length() }

pub fn markov_chain_series_sum(s : Markov_chainSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn markov_chain_series_mean(s : Markov_chainSeries) -> Double {
  let n = markov_chain_series_len(s)
  if n == 0 { 0.0 } else { markov_chain_series_sum(s) / n.to_double() }
}

pub fn markov_chain_series_min(s : Markov_chainSeries) -> Double {
  let n = markov_chain_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn markov_chain_series_max(s : Markov_chainSeries) -> Double {
  let n = markov_chain_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn markov_chain_series_var(s : Markov_chainSeries) -> Double {
  let n = markov_chain_series_len(s)
  if n == 0 { 0.0 } else {
    let m = markov_chain_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn markov_chain_series_std(s : Markov_chainSeries) -> Double { @_common.sqrt(markov_chain_series_var(s)) }

pub fn markov_chain_series_scale(s : Markov_chainSeries, f : Double) -> Markov_chainSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = markov_chain_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn markov_chain_series_add(a : Markov_chainSeries, b : Markov_chainSeries) -> Markov_chainSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = markov_chain_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn markov_chain_series_to_string(s : Markov_chainSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + markov_chain_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Markov_chainMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn markov_chain_make_matrix(rows : Int, cols : Int, val : Double) -> Markov_chainMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn markov_chain_matrix_identity(n : Int) -> Markov_chainMatrix {
  let m = markov_chain_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn markov_chain_matrix_get(m : Markov_chainMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn markov_chain_matrix_transpose(m : Markov_chainMatrix) -> Markov_chainMatrix {
  let result = markov_chain_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn markov_chain_matrix_add(a : Markov_chainMatrix, b : Markov_chainMatrix) -> Markov_chainMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = markov_chain_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn markov_chain_matrix_scale(m : Markov_chainMatrix, s : Double) -> Markov_chainMatrix {
  let result = markov_chain_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn markov_chain_matrix_multiply(a : Markov_chainMatrix, b : Markov_chainMatrix) -> Markov_chainMatrix {
  if a.cols != b.rows { return markov_chain_make_matrix(a.rows, b.cols, 0.0) }
  let result = markov_chain_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn markov_chain_matrix_trace(m : Markov_chainMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn markov_chain_matrix_norm(m : Markov_chainMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn markov_chain_matrix_to_string(m : Markov_chainMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + markov_chain_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Markov_chainVector {
  comps : Array[Double]
  dim : Int
}

pub fn markov_chain_make_vector(comps : Array[Double]) -> Markov_chainVector {
  { comps, dim: comps.length() }
}

pub fn markov_chain_vector_zero(dim : Int) -> Markov_chainVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn markov_chain_vector_add(a : Markov_chainVector, b : Markov_chainVector) -> Markov_chainVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = markov_chain_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn markov_chain_vector_sub(a : Markov_chainVector, b : Markov_chainVector) -> Markov_chainVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = markov_chain_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn markov_chain_vector_scale(v : Markov_chainVector, s : Double) -> Markov_chainVector {
  let mut result = []
  for i in 0..<v.dim { result = markov_chain_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn markov_chain_vector_dot(a : Markov_chainVector, b : Markov_chainVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn markov_chain_vector_norm(v : Markov_chainVector) -> Double { @_common.sqrt(markov_chain_vector_dot(v, v)) }

pub fn markov_chain_vector_normalize(v : Markov_chainVector) -> Markov_chainVector {
  let n = markov_chain_vector_norm(v)
  if n < 0.0000001 { v } else { markov_chain_vector_scale(v, 1.0 / n) }
}

pub fn markov_chain_vector_dist(a : Markov_chainVector, b : Markov_chainVector) -> Double {
  markov_chain_vector_norm(markov_chain_vector_sub(a, b))
}

pub fn markov_chain_vector_to_string(v : Markov_chainVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + markov_chain_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn markov_chain_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn markov_chain_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = markov_chain_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn markov_chain_std(data : Array[Double]) -> Double { @_common.sqrt(markov_chain_var(data)) }

pub fn markov_chain_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = markov_chain_mean(a); let mb = markov_chain_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn markov_chain_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = markov_chain_std(a); let sb = markov_chain_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { markov_chain_cov(a, b) / (sa * sb) }
}

pub fn markov_chain_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn markov_chain_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn markov_chain_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn markov_chain_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = markov_chain_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn markov_chain_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn markov_chain_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn markov_chain_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = markov_chain_precision(pred, labels, pos); let r = markov_chain_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn markov_chain_dbl(x : Double) -> String {
  let i = if x >= 0.0 { markov_chain_int(x) } else { -markov_chain_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { markov_chain_int(f * 1000000.0) } else { markov_chain_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn markov_chain_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn markov_chain_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
