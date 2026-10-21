///===
/// opcore/denoise_wavelet
/// S13.61 new

pub struct Denoise_waveletPoint {
  x : Double
  y : Double
  label : Int
}

pub fn denoise_wavelet_make_point(x : Double, y : Double) -> Denoise_waveletPoint {
  { x, y, label: 0 }
}

pub fn denoise_wavelet_make_labeled_point(x : Double, y : Double, label : Int) -> Denoise_waveletPoint {
  { x, y, label }
}

pub fn denoise_wavelet_point_x(p : Denoise_waveletPoint) -> Double { p.x }

pub fn denoise_wavelet_point_y(p : Denoise_waveletPoint) -> Double { p.y }

pub fn denoise_wavelet_point_label(p : Denoise_waveletPoint) -> Int { p.label }

pub fn denoise_wavelet_point_dist(a : Denoise_waveletPoint, b : Denoise_waveletPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn denoise_wavelet_point_add(a : Denoise_waveletPoint, b : Denoise_waveletPoint) -> Denoise_waveletPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn denoise_wavelet_point_sub(a : Denoise_waveletPoint, b : Denoise_waveletPoint) -> Denoise_waveletPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn denoise_wavelet_point_scale(pt : Denoise_waveletPoint, s : Double) -> Denoise_waveletPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn denoise_wavelet_point_dot(a : Denoise_waveletPoint, b : Denoise_waveletPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn denoise_wavelet_point_norm(pt : Denoise_waveletPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn denoise_wavelet_point_to_string(pt : Denoise_waveletPoint) -> String {
  "(" + denoise_wavelet_dbl(pt.x) + ", " + denoise_wavelet_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Denoise_waveletSeries {
  vals : Array[Double]
  name : String
}

pub fn denoise_wavelet_make_series(vals : Array[Double], name : String) -> Denoise_waveletSeries {
  { vals, name }
}

pub fn denoise_wavelet_series_len(s : Denoise_waveletSeries) -> Int { s.vals.length() }

pub fn denoise_wavelet_series_sum(s : Denoise_waveletSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn denoise_wavelet_series_mean(s : Denoise_waveletSeries) -> Double {
  let n = denoise_wavelet_series_len(s)
  if n == 0 { 0.0 } else { denoise_wavelet_series_sum(s) / n.to_double() }
}

pub fn denoise_wavelet_series_min(s : Denoise_waveletSeries) -> Double {
  let n = denoise_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn denoise_wavelet_series_max(s : Denoise_waveletSeries) -> Double {
  let n = denoise_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn denoise_wavelet_series_var(s : Denoise_waveletSeries) -> Double {
  let n = denoise_wavelet_series_len(s)
  if n == 0 { 0.0 } else {
    let m = denoise_wavelet_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn denoise_wavelet_series_std(s : Denoise_waveletSeries) -> Double { @_common.sqrt(denoise_wavelet_series_var(s)) }

pub fn denoise_wavelet_series_scale(s : Denoise_waveletSeries, f : Double) -> Denoise_waveletSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = denoise_wavelet_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn denoise_wavelet_series_add(a : Denoise_waveletSeries, b : Denoise_waveletSeries) -> Denoise_waveletSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = denoise_wavelet_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn denoise_wavelet_series_to_string(s : Denoise_waveletSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + denoise_wavelet_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Denoise_waveletMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn denoise_wavelet_make_matrix(rows : Int, cols : Int, val : Double) -> Denoise_waveletMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn denoise_wavelet_matrix_identity(n : Int) -> Denoise_waveletMatrix {
  let m = denoise_wavelet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn denoise_wavelet_matrix_get(m : Denoise_waveletMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn denoise_wavelet_matrix_transpose(m : Denoise_waveletMatrix) -> Denoise_waveletMatrix {
  let result = denoise_wavelet_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn denoise_wavelet_matrix_add(a : Denoise_waveletMatrix, b : Denoise_waveletMatrix) -> Denoise_waveletMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = denoise_wavelet_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn denoise_wavelet_matrix_scale(m : Denoise_waveletMatrix, s : Double) -> Denoise_waveletMatrix {
  let result = denoise_wavelet_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn denoise_wavelet_matrix_multiply(a : Denoise_waveletMatrix, b : Denoise_waveletMatrix) -> Denoise_waveletMatrix {
  if a.cols != b.rows { return denoise_wavelet_make_matrix(a.rows, b.cols, 0.0) }
  let result = denoise_wavelet_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn denoise_wavelet_matrix_trace(m : Denoise_waveletMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn denoise_wavelet_matrix_norm(m : Denoise_waveletMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn denoise_wavelet_matrix_to_string(m : Denoise_waveletMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + denoise_wavelet_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Denoise_waveletVector {
  comps : Array[Double]
  dim : Int
}

pub fn denoise_wavelet_make_vector(comps : Array[Double]) -> Denoise_waveletVector {
  { comps, dim: comps.length() }
}

pub fn denoise_wavelet_vector_zero(dim : Int) -> Denoise_waveletVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn denoise_wavelet_vector_add(a : Denoise_waveletVector, b : Denoise_waveletVector) -> Denoise_waveletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = denoise_wavelet_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn denoise_wavelet_vector_sub(a : Denoise_waveletVector, b : Denoise_waveletVector) -> Denoise_waveletVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = denoise_wavelet_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn denoise_wavelet_vector_scale(v : Denoise_waveletVector, s : Double) -> Denoise_waveletVector {
  let mut result = []
  for i in 0..<v.dim { result = denoise_wavelet_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn denoise_wavelet_vector_dot(a : Denoise_waveletVector, b : Denoise_waveletVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn denoise_wavelet_vector_norm(v : Denoise_waveletVector) -> Double { @_common.sqrt(denoise_wavelet_vector_dot(v, v)) }

pub fn denoise_wavelet_vector_normalize(v : Denoise_waveletVector) -> Denoise_waveletVector {
  let n = denoise_wavelet_vector_norm(v)
  if n < 0.0000001 { v } else { denoise_wavelet_vector_scale(v, 1.0 / n) }
}

pub fn denoise_wavelet_vector_dist(a : Denoise_waveletVector, b : Denoise_waveletVector) -> Double {
  denoise_wavelet_vector_norm(denoise_wavelet_vector_sub(a, b))
}

pub fn denoise_wavelet_vector_to_string(v : Denoise_waveletVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + denoise_wavelet_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn denoise_wavelet_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn denoise_wavelet_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = denoise_wavelet_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn denoise_wavelet_std(data : Array[Double]) -> Double { @_common.sqrt(denoise_wavelet_var(data)) }

pub fn denoise_wavelet_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = denoise_wavelet_mean(a); let mb = denoise_wavelet_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn denoise_wavelet_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = denoise_wavelet_std(a); let sb = denoise_wavelet_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { denoise_wavelet_cov(a, b) / (sa * sb) }
}

pub fn denoise_wavelet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn denoise_wavelet_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn denoise_wavelet_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn denoise_wavelet_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = denoise_wavelet_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn denoise_wavelet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn denoise_wavelet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn denoise_wavelet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = denoise_wavelet_precision(pred, labels, pos); let r = denoise_wavelet_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn denoise_wavelet_dbl(x : Double) -> String {
  let i = if x >= 0.0 { denoise_wavelet_int(x) } else { -denoise_wavelet_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { denoise_wavelet_int(f * 1000000.0) } else { denoise_wavelet_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn denoise_wavelet_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn denoise_wavelet_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
