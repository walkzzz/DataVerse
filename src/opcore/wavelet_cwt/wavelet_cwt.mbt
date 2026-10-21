///===
/// opcore/wavelet_cwt
/// S13.13 new

pub struct Wavelet_cwtPoint {
  x : Double
  y : Double
  label : Int
}

pub fn wavelet_cwt_make_point(x : Double, y : Double) -> Wavelet_cwtPoint {
  { x, y, label: 0 }
}

pub fn wavelet_cwt_make_labeled_point(x : Double, y : Double, label : Int) -> Wavelet_cwtPoint {
  { x, y, label }
}

pub fn wavelet_cwt_point_x(p : Wavelet_cwtPoint) -> Double { p.x }

pub fn wavelet_cwt_point_y(p : Wavelet_cwtPoint) -> Double { p.y }

pub fn wavelet_cwt_point_label(p : Wavelet_cwtPoint) -> Int { p.label }

pub fn wavelet_cwt_point_dist(a : Wavelet_cwtPoint, b : Wavelet_cwtPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn wavelet_cwt_point_add(a : Wavelet_cwtPoint, b : Wavelet_cwtPoint) -> Wavelet_cwtPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn wavelet_cwt_point_sub(a : Wavelet_cwtPoint, b : Wavelet_cwtPoint) -> Wavelet_cwtPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn wavelet_cwt_point_scale(pt : Wavelet_cwtPoint, s : Double) -> Wavelet_cwtPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn wavelet_cwt_point_dot(a : Wavelet_cwtPoint, b : Wavelet_cwtPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn wavelet_cwt_point_norm(pt : Wavelet_cwtPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn wavelet_cwt_point_to_string(pt : Wavelet_cwtPoint) -> String {
  "(" + wavelet_cwt_dbl(pt.x) + ", " + wavelet_cwt_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Wavelet_cwtSeries {
  vals : Array[Double]
  name : String
}

pub fn wavelet_cwt_make_series(vals : Array[Double], name : String) -> Wavelet_cwtSeries {
  { vals, name }
}

pub fn wavelet_cwt_series_len(s : Wavelet_cwtSeries) -> Int { s.vals.length() }

pub fn wavelet_cwt_series_sum(s : Wavelet_cwtSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn wavelet_cwt_series_mean(s : Wavelet_cwtSeries) -> Double {
  let n = wavelet_cwt_series_len(s)
  if n == 0 { 0.0 } else { wavelet_cwt_series_sum(s) / n.to_double() }
}

pub fn wavelet_cwt_series_min(s : Wavelet_cwtSeries) -> Double {
  let n = wavelet_cwt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn wavelet_cwt_series_max(s : Wavelet_cwtSeries) -> Double {
  let n = wavelet_cwt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn wavelet_cwt_series_var(s : Wavelet_cwtSeries) -> Double {
  let n = wavelet_cwt_series_len(s)
  if n == 0 { 0.0 } else {
    let m = wavelet_cwt_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn wavelet_cwt_series_std(s : Wavelet_cwtSeries) -> Double { @_common.sqrt(wavelet_cwt_series_var(s)) }

pub fn wavelet_cwt_series_scale(s : Wavelet_cwtSeries, f : Double) -> Wavelet_cwtSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = wavelet_cwt_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn wavelet_cwt_series_add(a : Wavelet_cwtSeries, b : Wavelet_cwtSeries) -> Wavelet_cwtSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = wavelet_cwt_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn wavelet_cwt_series_to_string(s : Wavelet_cwtSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + wavelet_cwt_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Wavelet_cwtMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn wavelet_cwt_make_matrix(rows : Int, cols : Int, val : Double) -> Wavelet_cwtMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn wavelet_cwt_matrix_identity(n : Int) -> Wavelet_cwtMatrix {
  let m = wavelet_cwt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn wavelet_cwt_matrix_get(m : Wavelet_cwtMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn wavelet_cwt_matrix_transpose(m : Wavelet_cwtMatrix) -> Wavelet_cwtMatrix {
  let result = wavelet_cwt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn wavelet_cwt_matrix_add(a : Wavelet_cwtMatrix, b : Wavelet_cwtMatrix) -> Wavelet_cwtMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = wavelet_cwt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn wavelet_cwt_matrix_scale(m : Wavelet_cwtMatrix, s : Double) -> Wavelet_cwtMatrix {
  let result = wavelet_cwt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn wavelet_cwt_matrix_multiply(a : Wavelet_cwtMatrix, b : Wavelet_cwtMatrix) -> Wavelet_cwtMatrix {
  if a.cols != b.rows { return wavelet_cwt_make_matrix(a.rows, b.cols, 0.0) }
  let result = wavelet_cwt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn wavelet_cwt_matrix_trace(m : Wavelet_cwtMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn wavelet_cwt_matrix_norm(m : Wavelet_cwtMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn wavelet_cwt_matrix_to_string(m : Wavelet_cwtMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + wavelet_cwt_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Wavelet_cwtVector {
  comps : Array[Double]
  dim : Int
}

pub fn wavelet_cwt_make_vector(comps : Array[Double]) -> Wavelet_cwtVector {
  { comps, dim: comps.length() }
}

pub fn wavelet_cwt_vector_zero(dim : Int) -> Wavelet_cwtVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn wavelet_cwt_vector_add(a : Wavelet_cwtVector, b : Wavelet_cwtVector) -> Wavelet_cwtVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = wavelet_cwt_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn wavelet_cwt_vector_sub(a : Wavelet_cwtVector, b : Wavelet_cwtVector) -> Wavelet_cwtVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = wavelet_cwt_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn wavelet_cwt_vector_scale(v : Wavelet_cwtVector, s : Double) -> Wavelet_cwtVector {
  let mut result = []
  for i in 0..<v.dim { result = wavelet_cwt_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn wavelet_cwt_vector_dot(a : Wavelet_cwtVector, b : Wavelet_cwtVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn wavelet_cwt_vector_norm(v : Wavelet_cwtVector) -> Double { @_common.sqrt(wavelet_cwt_vector_dot(v, v)) }

pub fn wavelet_cwt_vector_normalize(v : Wavelet_cwtVector) -> Wavelet_cwtVector {
  let n = wavelet_cwt_vector_norm(v)
  if n < 0.0000001 { v } else { wavelet_cwt_vector_scale(v, 1.0 / n) }
}

pub fn wavelet_cwt_vector_dist(a : Wavelet_cwtVector, b : Wavelet_cwtVector) -> Double {
  wavelet_cwt_vector_norm(wavelet_cwt_vector_sub(a, b))
}

pub fn wavelet_cwt_vector_to_string(v : Wavelet_cwtVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + wavelet_cwt_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn wavelet_cwt_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn wavelet_cwt_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = wavelet_cwt_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn wavelet_cwt_std(data : Array[Double]) -> Double { @_common.sqrt(wavelet_cwt_var(data)) }

pub fn wavelet_cwt_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = wavelet_cwt_mean(a); let mb = wavelet_cwt_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn wavelet_cwt_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = wavelet_cwt_std(a); let sb = wavelet_cwt_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { wavelet_cwt_cov(a, b) / (sa * sb) }
}

pub fn wavelet_cwt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn wavelet_cwt_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn wavelet_cwt_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn wavelet_cwt_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = wavelet_cwt_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn wavelet_cwt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn wavelet_cwt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn wavelet_cwt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = wavelet_cwt_precision(pred, labels, pos); let r = wavelet_cwt_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn wavelet_cwt_dbl(x : Double) -> String {
  let i = if x >= 0.0 { wavelet_cwt_int(x) } else { -wavelet_cwt_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { wavelet_cwt_int(f * 1000000.0) } else { wavelet_cwt_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn wavelet_cwt_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn wavelet_cwt_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
