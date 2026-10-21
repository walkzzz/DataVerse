///===
/// opcore/error_code
/// S13.30 new

pub struct Error_codePoint {
  x : Double
  y : Double
  label : Int
}

pub fn error_code_make_point(x : Double, y : Double) -> Error_codePoint {
  { x, y, label: 0 }
}

pub fn error_code_make_labeled_point(x : Double, y : Double, label : Int) -> Error_codePoint {
  { x, y, label }
}

pub fn error_code_point_x(p : Error_codePoint) -> Double { p.x }

pub fn error_code_point_y(p : Error_codePoint) -> Double { p.y }

pub fn error_code_point_label(p : Error_codePoint) -> Int { p.label }

pub fn error_code_point_dist(a : Error_codePoint, b : Error_codePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn error_code_point_add(a : Error_codePoint, b : Error_codePoint) -> Error_codePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn error_code_point_sub(a : Error_codePoint, b : Error_codePoint) -> Error_codePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn error_code_point_scale(pt : Error_codePoint, s : Double) -> Error_codePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn error_code_point_dot(a : Error_codePoint, b : Error_codePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn error_code_point_norm(pt : Error_codePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn error_code_point_to_string(pt : Error_codePoint) -> String {
  "(" + error_code_dbl(pt.x) + ", " + error_code_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Error_codeSeries {
  vals : Array[Double]
  name : String
}

pub fn error_code_make_series(vals : Array[Double], name : String) -> Error_codeSeries {
  { vals, name }
}

pub fn error_code_series_len(s : Error_codeSeries) -> Int { s.vals.length() }

pub fn error_code_series_sum(s : Error_codeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn error_code_series_mean(s : Error_codeSeries) -> Double {
  let n = error_code_series_len(s)
  if n == 0 { 0.0 } else { error_code_series_sum(s) / n.to_double() }
}

pub fn error_code_series_min(s : Error_codeSeries) -> Double {
  let n = error_code_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn error_code_series_max(s : Error_codeSeries) -> Double {
  let n = error_code_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn error_code_series_var(s : Error_codeSeries) -> Double {
  let n = error_code_series_len(s)
  if n == 0 { 0.0 } else {
    let m = error_code_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn error_code_series_std(s : Error_codeSeries) -> Double { @_common.sqrt(error_code_series_var(s)) }

pub fn error_code_series_scale(s : Error_codeSeries, f : Double) -> Error_codeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = error_code_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn error_code_series_add(a : Error_codeSeries, b : Error_codeSeries) -> Error_codeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = error_code_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn error_code_series_to_string(s : Error_codeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + error_code_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Error_codeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn error_code_make_matrix(rows : Int, cols : Int, val : Double) -> Error_codeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn error_code_matrix_identity(n : Int) -> Error_codeMatrix {
  let m = error_code_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn error_code_matrix_get(m : Error_codeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn error_code_matrix_transpose(m : Error_codeMatrix) -> Error_codeMatrix {
  let result = error_code_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn error_code_matrix_add(a : Error_codeMatrix, b : Error_codeMatrix) -> Error_codeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = error_code_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn error_code_matrix_scale(m : Error_codeMatrix, s : Double) -> Error_codeMatrix {
  let result = error_code_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn error_code_matrix_multiply(a : Error_codeMatrix, b : Error_codeMatrix) -> Error_codeMatrix {
  if a.cols != b.rows { return error_code_make_matrix(a.rows, b.cols, 0.0) }
  let result = error_code_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn error_code_matrix_trace(m : Error_codeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn error_code_matrix_norm(m : Error_codeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn error_code_matrix_to_string(m : Error_codeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + error_code_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Error_codeVector {
  comps : Array[Double]
  dim : Int
}

pub fn error_code_make_vector(comps : Array[Double]) -> Error_codeVector {
  { comps, dim: comps.length() }
}

pub fn error_code_vector_zero(dim : Int) -> Error_codeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn error_code_vector_add(a : Error_codeVector, b : Error_codeVector) -> Error_codeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = error_code_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn error_code_vector_sub(a : Error_codeVector, b : Error_codeVector) -> Error_codeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = error_code_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn error_code_vector_scale(v : Error_codeVector, s : Double) -> Error_codeVector {
  let mut result = []
  for i in 0..<v.dim { result = error_code_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn error_code_vector_dot(a : Error_codeVector, b : Error_codeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn error_code_vector_norm(v : Error_codeVector) -> Double { @_common.sqrt(error_code_vector_dot(v, v)) }

pub fn error_code_vector_normalize(v : Error_codeVector) -> Error_codeVector {
  let n = error_code_vector_norm(v)
  if n < 0.0000001 { v } else { error_code_vector_scale(v, 1.0 / n) }
}

pub fn error_code_vector_dist(a : Error_codeVector, b : Error_codeVector) -> Double {
  error_code_vector_norm(error_code_vector_sub(a, b))
}

pub fn error_code_vector_to_string(v : Error_codeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + error_code_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn error_code_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn error_code_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = error_code_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn error_code_std(data : Array[Double]) -> Double { @_common.sqrt(error_code_var(data)) }

pub fn error_code_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = error_code_mean(a); let mb = error_code_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn error_code_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = error_code_std(a); let sb = error_code_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { error_code_cov(a, b) / (sa * sb) }
}

pub fn error_code_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn error_code_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn error_code_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn error_code_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = error_code_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn error_code_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn error_code_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn error_code_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = error_code_precision(pred, labels, pos); let r = error_code_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn error_code_dbl(x : Double) -> String {
  let i = if x >= 0.0 { error_code_int(x) } else { -error_code_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { error_code_int(f * 1000000.0) } else { error_code_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn error_code_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn error_code_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
