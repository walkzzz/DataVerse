///===
/// opcore/pitch_detect
/// S13.36 new

pub struct Pitch_detectPoint {
  x : Double
  y : Double
  label : Int
}

pub fn pitch_detect_make_point(x : Double, y : Double) -> Pitch_detectPoint {
  { x, y, label: 0 }
}

pub fn pitch_detect_make_labeled_point(x : Double, y : Double, label : Int) -> Pitch_detectPoint {
  { x, y, label }
}

pub fn pitch_detect_point_x(p : Pitch_detectPoint) -> Double { p.x }

pub fn pitch_detect_point_y(p : Pitch_detectPoint) -> Double { p.y }

pub fn pitch_detect_point_label(p : Pitch_detectPoint) -> Int { p.label }

pub fn pitch_detect_point_dist(a : Pitch_detectPoint, b : Pitch_detectPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn pitch_detect_point_add(a : Pitch_detectPoint, b : Pitch_detectPoint) -> Pitch_detectPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn pitch_detect_point_sub(a : Pitch_detectPoint, b : Pitch_detectPoint) -> Pitch_detectPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn pitch_detect_point_scale(pt : Pitch_detectPoint, s : Double) -> Pitch_detectPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn pitch_detect_point_dot(a : Pitch_detectPoint, b : Pitch_detectPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn pitch_detect_point_norm(pt : Pitch_detectPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn pitch_detect_point_to_string(pt : Pitch_detectPoint) -> String {
  "(" + pitch_detect_dbl(pt.x) + ", " + pitch_detect_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Pitch_detectSeries {
  vals : Array[Double]
  name : String
}

pub fn pitch_detect_make_series(vals : Array[Double], name : String) -> Pitch_detectSeries {
  { vals, name }
}

pub fn pitch_detect_series_len(s : Pitch_detectSeries) -> Int { s.vals.length() }

pub fn pitch_detect_series_sum(s : Pitch_detectSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn pitch_detect_series_mean(s : Pitch_detectSeries) -> Double {
  let n = pitch_detect_series_len(s)
  if n == 0 { 0.0 } else { pitch_detect_series_sum(s) / n.to_double() }
}

pub fn pitch_detect_series_min(s : Pitch_detectSeries) -> Double {
  let n = pitch_detect_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn pitch_detect_series_max(s : Pitch_detectSeries) -> Double {
  let n = pitch_detect_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn pitch_detect_series_var(s : Pitch_detectSeries) -> Double {
  let n = pitch_detect_series_len(s)
  if n == 0 { 0.0 } else {
    let m = pitch_detect_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn pitch_detect_series_std(s : Pitch_detectSeries) -> Double { @_common.sqrt(pitch_detect_series_var(s)) }

pub fn pitch_detect_series_scale(s : Pitch_detectSeries, f : Double) -> Pitch_detectSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = pitch_detect_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn pitch_detect_series_add(a : Pitch_detectSeries, b : Pitch_detectSeries) -> Pitch_detectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = pitch_detect_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn pitch_detect_series_to_string(s : Pitch_detectSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + pitch_detect_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Pitch_detectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn pitch_detect_make_matrix(rows : Int, cols : Int, val : Double) -> Pitch_detectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn pitch_detect_matrix_identity(n : Int) -> Pitch_detectMatrix {
  let m = pitch_detect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn pitch_detect_matrix_get(m : Pitch_detectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn pitch_detect_matrix_transpose(m : Pitch_detectMatrix) -> Pitch_detectMatrix {
  let result = pitch_detect_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn pitch_detect_matrix_add(a : Pitch_detectMatrix, b : Pitch_detectMatrix) -> Pitch_detectMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = pitch_detect_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn pitch_detect_matrix_scale(m : Pitch_detectMatrix, s : Double) -> Pitch_detectMatrix {
  let result = pitch_detect_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn pitch_detect_matrix_multiply(a : Pitch_detectMatrix, b : Pitch_detectMatrix) -> Pitch_detectMatrix {
  if a.cols != b.rows { return pitch_detect_make_matrix(a.rows, b.cols, 0.0) }
  let result = pitch_detect_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn pitch_detect_matrix_trace(m : Pitch_detectMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn pitch_detect_matrix_norm(m : Pitch_detectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn pitch_detect_matrix_to_string(m : Pitch_detectMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + pitch_detect_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Pitch_detectVector {
  comps : Array[Double]
  dim : Int
}

pub fn pitch_detect_make_vector(comps : Array[Double]) -> Pitch_detectVector {
  { comps, dim: comps.length() }
}

pub fn pitch_detect_vector_zero(dim : Int) -> Pitch_detectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn pitch_detect_vector_add(a : Pitch_detectVector, b : Pitch_detectVector) -> Pitch_detectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = pitch_detect_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn pitch_detect_vector_sub(a : Pitch_detectVector, b : Pitch_detectVector) -> Pitch_detectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = pitch_detect_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn pitch_detect_vector_scale(v : Pitch_detectVector, s : Double) -> Pitch_detectVector {
  let mut result = []
  for i in 0..<v.dim { result = pitch_detect_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn pitch_detect_vector_dot(a : Pitch_detectVector, b : Pitch_detectVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn pitch_detect_vector_norm(v : Pitch_detectVector) -> Double { @_common.sqrt(pitch_detect_vector_dot(v, v)) }

pub fn pitch_detect_vector_normalize(v : Pitch_detectVector) -> Pitch_detectVector {
  let n = pitch_detect_vector_norm(v)
  if n < 0.0000001 { v } else { pitch_detect_vector_scale(v, 1.0 / n) }
}

pub fn pitch_detect_vector_dist(a : Pitch_detectVector, b : Pitch_detectVector) -> Double {
  pitch_detect_vector_norm(pitch_detect_vector_sub(a, b))
}

pub fn pitch_detect_vector_to_string(v : Pitch_detectVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + pitch_detect_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn pitch_detect_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn pitch_detect_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = pitch_detect_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn pitch_detect_std(data : Array[Double]) -> Double { @_common.sqrt(pitch_detect_var(data)) }

pub fn pitch_detect_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = pitch_detect_mean(a); let mb = pitch_detect_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn pitch_detect_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = pitch_detect_std(a); let sb = pitch_detect_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { pitch_detect_cov(a, b) / (sa * sb) }
}

pub fn pitch_detect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn pitch_detect_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn pitch_detect_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn pitch_detect_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = pitch_detect_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn pitch_detect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn pitch_detect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn pitch_detect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = pitch_detect_precision(pred, labels, pos); let r = pitch_detect_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn pitch_detect_dbl(x : Double) -> String {
  let i = if x >= 0.0 { pitch_detect_int(x) } else { -pitch_detect_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { pitch_detect_int(f * 1000000.0) } else { pitch_detect_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn pitch_detect_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn pitch_detect_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
