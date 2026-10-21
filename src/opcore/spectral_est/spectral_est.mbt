///===
/// opcore/spectral_est
/// S13.17 new

pub struct Spectral_estPoint {
  x : Double
  y : Double
  label : Int
}

pub fn spectral_est_make_point(x : Double, y : Double) -> Spectral_estPoint {
  { x, y, label: 0 }
}

pub fn spectral_est_make_labeled_point(x : Double, y : Double, label : Int) -> Spectral_estPoint {
  { x, y, label }
}

pub fn spectral_est_point_x(p : Spectral_estPoint) -> Double { p.x }

pub fn spectral_est_point_y(p : Spectral_estPoint) -> Double { p.y }

pub fn spectral_est_point_label(p : Spectral_estPoint) -> Int { p.label }

pub fn spectral_est_point_dist(a : Spectral_estPoint, b : Spectral_estPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn spectral_est_point_add(a : Spectral_estPoint, b : Spectral_estPoint) -> Spectral_estPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn spectral_est_point_sub(a : Spectral_estPoint, b : Spectral_estPoint) -> Spectral_estPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn spectral_est_point_scale(pt : Spectral_estPoint, s : Double) -> Spectral_estPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn spectral_est_point_dot(a : Spectral_estPoint, b : Spectral_estPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn spectral_est_point_norm(pt : Spectral_estPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn spectral_est_point_to_string(pt : Spectral_estPoint) -> String {
  "(" + spectral_est_dbl(pt.x) + ", " + spectral_est_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Spectral_estSeries {
  vals : Array[Double]
  name : String
}

pub fn spectral_est_make_series(vals : Array[Double], name : String) -> Spectral_estSeries {
  { vals, name }
}

pub fn spectral_est_series_len(s : Spectral_estSeries) -> Int { s.vals.length() }

pub fn spectral_est_series_sum(s : Spectral_estSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn spectral_est_series_mean(s : Spectral_estSeries) -> Double {
  let n = spectral_est_series_len(s)
  if n == 0 { 0.0 } else { spectral_est_series_sum(s) / n.to_double() }
}

pub fn spectral_est_series_min(s : Spectral_estSeries) -> Double {
  let n = spectral_est_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn spectral_est_series_max(s : Spectral_estSeries) -> Double {
  let n = spectral_est_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn spectral_est_series_var(s : Spectral_estSeries) -> Double {
  let n = spectral_est_series_len(s)
  if n == 0 { 0.0 } else {
    let m = spectral_est_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn spectral_est_series_std(s : Spectral_estSeries) -> Double { @_common.sqrt(spectral_est_series_var(s)) }

pub fn spectral_est_series_scale(s : Spectral_estSeries, f : Double) -> Spectral_estSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = spectral_est_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn spectral_est_series_add(a : Spectral_estSeries, b : Spectral_estSeries) -> Spectral_estSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = spectral_est_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn spectral_est_series_to_string(s : Spectral_estSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + spectral_est_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Spectral_estMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn spectral_est_make_matrix(rows : Int, cols : Int, val : Double) -> Spectral_estMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn spectral_est_matrix_identity(n : Int) -> Spectral_estMatrix {
  let m = spectral_est_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn spectral_est_matrix_get(m : Spectral_estMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn spectral_est_matrix_transpose(m : Spectral_estMatrix) -> Spectral_estMatrix {
  let result = spectral_est_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn spectral_est_matrix_add(a : Spectral_estMatrix, b : Spectral_estMatrix) -> Spectral_estMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = spectral_est_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn spectral_est_matrix_scale(m : Spectral_estMatrix, s : Double) -> Spectral_estMatrix {
  let result = spectral_est_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn spectral_est_matrix_multiply(a : Spectral_estMatrix, b : Spectral_estMatrix) -> Spectral_estMatrix {
  if a.cols != b.rows { return spectral_est_make_matrix(a.rows, b.cols, 0.0) }
  let result = spectral_est_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn spectral_est_matrix_trace(m : Spectral_estMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn spectral_est_matrix_norm(m : Spectral_estMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn spectral_est_matrix_to_string(m : Spectral_estMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + spectral_est_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Spectral_estVector {
  comps : Array[Double]
  dim : Int
}

pub fn spectral_est_make_vector(comps : Array[Double]) -> Spectral_estVector {
  { comps, dim: comps.length() }
}

pub fn spectral_est_vector_zero(dim : Int) -> Spectral_estVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn spectral_est_vector_add(a : Spectral_estVector, b : Spectral_estVector) -> Spectral_estVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = spectral_est_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn spectral_est_vector_sub(a : Spectral_estVector, b : Spectral_estVector) -> Spectral_estVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = spectral_est_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn spectral_est_vector_scale(v : Spectral_estVector, s : Double) -> Spectral_estVector {
  let mut result = []
  for i in 0..<v.dim { result = spectral_est_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn spectral_est_vector_dot(a : Spectral_estVector, b : Spectral_estVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn spectral_est_vector_norm(v : Spectral_estVector) -> Double { @_common.sqrt(spectral_est_vector_dot(v, v)) }

pub fn spectral_est_vector_normalize(v : Spectral_estVector) -> Spectral_estVector {
  let n = spectral_est_vector_norm(v)
  if n < 0.0000001 { v } else { spectral_est_vector_scale(v, 1.0 / n) }
}

pub fn spectral_est_vector_dist(a : Spectral_estVector, b : Spectral_estVector) -> Double {
  spectral_est_vector_norm(spectral_est_vector_sub(a, b))
}

pub fn spectral_est_vector_to_string(v : Spectral_estVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + spectral_est_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn spectral_est_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn spectral_est_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = spectral_est_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn spectral_est_std(data : Array[Double]) -> Double { @_common.sqrt(spectral_est_var(data)) }

pub fn spectral_est_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = spectral_est_mean(a); let mb = spectral_est_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn spectral_est_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = spectral_est_std(a); let sb = spectral_est_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { spectral_est_cov(a, b) / (sa * sb) }
}

pub fn spectral_est_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn spectral_est_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn spectral_est_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn spectral_est_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = spectral_est_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn spectral_est_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn spectral_est_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn spectral_est_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = spectral_est_precision(pred, labels, pos); let r = spectral_est_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn spectral_est_dbl(x : Double) -> String {
  let i = if x >= 0.0 { spectral_est_int(x) } else { -spectral_est_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { spectral_est_int(f * 1000000.0) } else { spectral_est_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn spectral_est_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn spectral_est_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
