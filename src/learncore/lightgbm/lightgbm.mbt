///===
/// learncore/lightgbm
/// S13.91 new

pub struct LightgbmPoint {
  x : Double
  y : Double
  label : Int
}

pub fn lightgbm_make_point(x : Double, y : Double) -> LightgbmPoint {
  { x, y, label: 0 }
}

pub fn lightgbm_make_labeled_point(x : Double, y : Double, label : Int) -> LightgbmPoint {
  { x, y, label }
}

pub fn lightgbm_point_x(p : LightgbmPoint) -> Double { p.x }

pub fn lightgbm_point_y(p : LightgbmPoint) -> Double { p.y }

pub fn lightgbm_point_label(p : LightgbmPoint) -> Int { p.label }

pub fn lightgbm_point_dist(a : LightgbmPoint, b : LightgbmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn lightgbm_point_add(a : LightgbmPoint, b : LightgbmPoint) -> LightgbmPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn lightgbm_point_sub(a : LightgbmPoint, b : LightgbmPoint) -> LightgbmPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn lightgbm_point_scale(pt : LightgbmPoint, s : Double) -> LightgbmPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn lightgbm_point_dot(a : LightgbmPoint, b : LightgbmPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn lightgbm_point_norm(pt : LightgbmPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn lightgbm_point_to_string(pt : LightgbmPoint) -> String {
  "(" + lightgbm_dbl(pt.x) + ", " + lightgbm_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct LightgbmSeries {
  vals : Array[Double]
  name : String
}

pub fn lightgbm_make_series(vals : Array[Double], name : String) -> LightgbmSeries {
  { vals, name }
}

pub fn lightgbm_series_len(s : LightgbmSeries) -> Int { s.vals.length() }

pub fn lightgbm_series_sum(s : LightgbmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn lightgbm_series_mean(s : LightgbmSeries) -> Double {
  let n = lightgbm_series_len(s)
  if n == 0 { 0.0 } else { lightgbm_series_sum(s) / n.to_double() }
}

pub fn lightgbm_series_min(s : LightgbmSeries) -> Double {
  let n = lightgbm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn lightgbm_series_max(s : LightgbmSeries) -> Double {
  let n = lightgbm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn lightgbm_series_var(s : LightgbmSeries) -> Double {
  let n = lightgbm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = lightgbm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn lightgbm_series_std(s : LightgbmSeries) -> Double { @_common.sqrt(lightgbm_series_var(s)) }

pub fn lightgbm_series_scale(s : LightgbmSeries, f : Double) -> LightgbmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = lightgbm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn lightgbm_series_add(a : LightgbmSeries, b : LightgbmSeries) -> LightgbmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = lightgbm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn lightgbm_series_to_string(s : LightgbmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + lightgbm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct LightgbmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn lightgbm_make_matrix(rows : Int, cols : Int, val : Double) -> LightgbmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn lightgbm_matrix_identity(n : Int) -> LightgbmMatrix {
  let m = lightgbm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn lightgbm_matrix_get(m : LightgbmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn lightgbm_matrix_transpose(m : LightgbmMatrix) -> LightgbmMatrix {
  let result = lightgbm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn lightgbm_matrix_add(a : LightgbmMatrix, b : LightgbmMatrix) -> LightgbmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = lightgbm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn lightgbm_matrix_scale(m : LightgbmMatrix, s : Double) -> LightgbmMatrix {
  let result = lightgbm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn lightgbm_matrix_multiply(a : LightgbmMatrix, b : LightgbmMatrix) -> LightgbmMatrix {
  if a.cols != b.rows { return lightgbm_make_matrix(a.rows, b.cols, 0.0) }
  let result = lightgbm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn lightgbm_matrix_trace(m : LightgbmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn lightgbm_matrix_norm(m : LightgbmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn lightgbm_matrix_to_string(m : LightgbmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + lightgbm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct LightgbmVector {
  comps : Array[Double]
  dim : Int
}

pub fn lightgbm_make_vector(comps : Array[Double]) -> LightgbmVector {
  { comps, dim: comps.length() }
}

pub fn lightgbm_vector_zero(dim : Int) -> LightgbmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn lightgbm_vector_add(a : LightgbmVector, b : LightgbmVector) -> LightgbmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = lightgbm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn lightgbm_vector_sub(a : LightgbmVector, b : LightgbmVector) -> LightgbmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = lightgbm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn lightgbm_vector_scale(v : LightgbmVector, s : Double) -> LightgbmVector {
  let mut result = []
  for i in 0..<v.dim { result = lightgbm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn lightgbm_vector_dot(a : LightgbmVector, b : LightgbmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn lightgbm_vector_norm(v : LightgbmVector) -> Double { @_common.sqrt(lightgbm_vector_dot(v, v)) }

pub fn lightgbm_vector_normalize(v : LightgbmVector) -> LightgbmVector {
  let n = lightgbm_vector_norm(v)
  if n < 0.0000001 { v } else { lightgbm_vector_scale(v, 1.0 / n) }
}

pub fn lightgbm_vector_dist(a : LightgbmVector, b : LightgbmVector) -> Double {
  lightgbm_vector_norm(lightgbm_vector_sub(a, b))
}

pub fn lightgbm_vector_to_string(v : LightgbmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + lightgbm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn lightgbm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn lightgbm_std(data : Array[Double]) -> Double { @_common.sqrt(lightgbm_var(data)) }

pub fn lightgbm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn lightgbm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = lightgbm_std(a); let sb = lightgbm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { lightgbm_cov(a, b) / (sa * sb) }
}

pub fn lightgbm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn lightgbm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn lightgbm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn lightgbm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn lightgbm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn lightgbm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn lightgbm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = lightgbm_precision(pred, labels, pos); let r = lightgbm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn lightgbm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { lightgbm_int(x) } else { -lightgbm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { lightgbm_int(f * 1000000.0) } else { lightgbm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn lightgbm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn lightgbm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
