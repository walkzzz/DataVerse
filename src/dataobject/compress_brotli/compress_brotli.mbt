///===
/// dataobject/compress_brotli
/// S13.194 new

pub struct Compress_brotliPoint {
  x : Double
  y : Double
  label : Int
}

pub fn compress_brotli_make_point(x : Double, y : Double) -> Compress_brotliPoint {
  { x, y, label: 0 }
}

pub fn compress_brotli_make_labeled_point(x : Double, y : Double, label : Int) -> Compress_brotliPoint {
  { x, y, label }
}

pub fn compress_brotli_point_x(p : Compress_brotliPoint) -> Double { p.x }

pub fn compress_brotli_point_y(p : Compress_brotliPoint) -> Double { p.y }

pub fn compress_brotli_point_label(p : Compress_brotliPoint) -> Int { p.label }

pub fn compress_brotli_point_dist(a : Compress_brotliPoint, b : Compress_brotliPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn compress_brotli_point_add(a : Compress_brotliPoint, b : Compress_brotliPoint) -> Compress_brotliPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn compress_brotli_point_sub(a : Compress_brotliPoint, b : Compress_brotliPoint) -> Compress_brotliPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn compress_brotli_point_scale(pt : Compress_brotliPoint, s : Double) -> Compress_brotliPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn compress_brotli_point_dot(a : Compress_brotliPoint, b : Compress_brotliPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn compress_brotli_point_norm(pt : Compress_brotliPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn compress_brotli_point_to_string(pt : Compress_brotliPoint) -> String {
  "(" + compress_brotli_dbl(pt.x) + ", " + compress_brotli_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Compress_brotliSeries {
  vals : Array[Double]
  name : String
}

pub fn compress_brotli_make_series(vals : Array[Double], name : String) -> Compress_brotliSeries {
  { vals, name }
}

pub fn compress_brotli_series_len(s : Compress_brotliSeries) -> Int { s.vals.length() }

pub fn compress_brotli_series_sum(s : Compress_brotliSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn compress_brotli_series_mean(s : Compress_brotliSeries) -> Double {
  let n = compress_brotli_series_len(s)
  if n == 0 { 0.0 } else { compress_brotli_series_sum(s) / n.to_double() }
}

pub fn compress_brotli_series_min(s : Compress_brotliSeries) -> Double {
  let n = compress_brotli_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn compress_brotli_series_max(s : Compress_brotliSeries) -> Double {
  let n = compress_brotli_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn compress_brotli_series_var(s : Compress_brotliSeries) -> Double {
  let n = compress_brotli_series_len(s)
  if n == 0 { 0.0 } else {
    let m = compress_brotli_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn compress_brotli_series_std(s : Compress_brotliSeries) -> Double { @_common.sqrt(compress_brotli_series_var(s)) }

pub fn compress_brotli_series_scale(s : Compress_brotliSeries, f : Double) -> Compress_brotliSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = compress_brotli_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn compress_brotli_series_add(a : Compress_brotliSeries, b : Compress_brotliSeries) -> Compress_brotliSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = compress_brotli_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn compress_brotli_series_to_string(s : Compress_brotliSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + compress_brotli_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Compress_brotliMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn compress_brotli_make_matrix(rows : Int, cols : Int, val : Double) -> Compress_brotliMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn compress_brotli_matrix_identity(n : Int) -> Compress_brotliMatrix {
  let m = compress_brotli_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn compress_brotli_matrix_get(m : Compress_brotliMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn compress_brotli_matrix_transpose(m : Compress_brotliMatrix) -> Compress_brotliMatrix {
  let result = compress_brotli_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn compress_brotli_matrix_add(a : Compress_brotliMatrix, b : Compress_brotliMatrix) -> Compress_brotliMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = compress_brotli_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn compress_brotli_matrix_scale(m : Compress_brotliMatrix, s : Double) -> Compress_brotliMatrix {
  let result = compress_brotli_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn compress_brotli_matrix_multiply(a : Compress_brotliMatrix, b : Compress_brotliMatrix) -> Compress_brotliMatrix {
  if a.cols != b.rows { return compress_brotli_make_matrix(a.rows, b.cols, 0.0) }
  let result = compress_brotli_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn compress_brotli_matrix_trace(m : Compress_brotliMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn compress_brotli_matrix_norm(m : Compress_brotliMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn compress_brotli_matrix_to_string(m : Compress_brotliMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + compress_brotli_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Compress_brotliVector {
  comps : Array[Double]
  dim : Int
}

pub fn compress_brotli_make_vector(comps : Array[Double]) -> Compress_brotliVector {
  { comps, dim: comps.length() }
}

pub fn compress_brotli_vector_zero(dim : Int) -> Compress_brotliVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn compress_brotli_vector_add(a : Compress_brotliVector, b : Compress_brotliVector) -> Compress_brotliVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = compress_brotli_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn compress_brotli_vector_sub(a : Compress_brotliVector, b : Compress_brotliVector) -> Compress_brotliVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = compress_brotli_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn compress_brotli_vector_scale(v : Compress_brotliVector, s : Double) -> Compress_brotliVector {
  let mut result = []
  for i in 0..<v.dim { result = compress_brotli_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn compress_brotli_vector_dot(a : Compress_brotliVector, b : Compress_brotliVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn compress_brotli_vector_norm(v : Compress_brotliVector) -> Double { @_common.sqrt(compress_brotli_vector_dot(v, v)) }

pub fn compress_brotli_vector_normalize(v : Compress_brotliVector) -> Compress_brotliVector {
  let n = compress_brotli_vector_norm(v)
  if n < 0.0000001 { v } else { compress_brotli_vector_scale(v, 1.0 / n) }
}

pub fn compress_brotli_vector_dist(a : Compress_brotliVector, b : Compress_brotliVector) -> Double {
  compress_brotli_vector_norm(compress_brotli_vector_sub(a, b))
}

pub fn compress_brotli_vector_to_string(v : Compress_brotliVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + compress_brotli_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn compress_brotli_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn compress_brotli_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = compress_brotli_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn compress_brotli_std(data : Array[Double]) -> Double { @_common.sqrt(compress_brotli_var(data)) }

pub fn compress_brotli_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = compress_brotli_mean(a); let mb = compress_brotli_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn compress_brotli_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = compress_brotli_std(a); let sb = compress_brotli_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { compress_brotli_cov(a, b) / (sa * sb) }
}

pub fn compress_brotli_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn compress_brotli_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn compress_brotli_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn compress_brotli_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = compress_brotli_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn compress_brotli_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn compress_brotli_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn compress_brotli_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = compress_brotli_precision(pred, labels, pos); let r = compress_brotli_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn compress_brotli_dbl(x : Double) -> String {
  let i = if x >= 0.0 { compress_brotli_int(x) } else { -compress_brotli_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { compress_brotli_int(f * 1000000.0) } else { compress_brotli_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn compress_brotli_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn compress_brotli_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
