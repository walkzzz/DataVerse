///===
/// learncore/lpd
/// S13.99 new

pub struct LpdPoint {
  x : Double
  y : Double
  label : Int
}

pub fn lpd_make_point(x : Double, y : Double) -> LpdPoint {
  { x, y, label: 0 }
}

pub fn lpd_make_labeled_point(x : Double, y : Double, label : Int) -> LpdPoint {
  { x, y, label }
}

pub fn lpd_point_x(p : LpdPoint) -> Double { p.x }

pub fn lpd_point_y(p : LpdPoint) -> Double { p.y }

pub fn lpd_point_label(p : LpdPoint) -> Int { p.label }

pub fn lpd_point_dist(a : LpdPoint, b : LpdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn lpd_point_add(a : LpdPoint, b : LpdPoint) -> LpdPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn lpd_point_sub(a : LpdPoint, b : LpdPoint) -> LpdPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn lpd_point_scale(pt : LpdPoint, s : Double) -> LpdPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn lpd_point_dot(a : LpdPoint, b : LpdPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn lpd_point_norm(pt : LpdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn lpd_point_to_string(pt : LpdPoint) -> String {
  "(" + lpd_dbl(pt.x) + ", " + lpd_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct LpdSeries {
  vals : Array[Double]
  name : String
}

pub fn lpd_make_series(vals : Array[Double], name : String) -> LpdSeries {
  { vals, name }
}

pub fn lpd_series_len(s : LpdSeries) -> Int { s.vals.length() }

pub fn lpd_series_sum(s : LpdSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn lpd_series_mean(s : LpdSeries) -> Double {
  let n = lpd_series_len(s)
  if n == 0 { 0.0 } else { lpd_series_sum(s) / n.to_double() }
}

pub fn lpd_series_min(s : LpdSeries) -> Double {
  let n = lpd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn lpd_series_max(s : LpdSeries) -> Double {
  let n = lpd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn lpd_series_var(s : LpdSeries) -> Double {
  let n = lpd_series_len(s)
  if n == 0 { 0.0 } else {
    let m = lpd_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn lpd_series_std(s : LpdSeries) -> Double { @_common.sqrt(lpd_series_var(s)) }

pub fn lpd_series_scale(s : LpdSeries, f : Double) -> LpdSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = lpd_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn lpd_series_add(a : LpdSeries, b : LpdSeries) -> LpdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = lpd_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn lpd_series_to_string(s : LpdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + lpd_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct LpdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn lpd_make_matrix(rows : Int, cols : Int, val : Double) -> LpdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn lpd_matrix_identity(n : Int) -> LpdMatrix {
  let m = lpd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn lpd_matrix_get(m : LpdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn lpd_matrix_transpose(m : LpdMatrix) -> LpdMatrix {
  let result = lpd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn lpd_matrix_add(a : LpdMatrix, b : LpdMatrix) -> LpdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = lpd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn lpd_matrix_scale(m : LpdMatrix, s : Double) -> LpdMatrix {
  let result = lpd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn lpd_matrix_multiply(a : LpdMatrix, b : LpdMatrix) -> LpdMatrix {
  if a.cols != b.rows { return lpd_make_matrix(a.rows, b.cols, 0.0) }
  let result = lpd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn lpd_matrix_trace(m : LpdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn lpd_matrix_norm(m : LpdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn lpd_matrix_to_string(m : LpdMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + lpd_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct LpdVector {
  comps : Array[Double]
  dim : Int
}

pub fn lpd_make_vector(comps : Array[Double]) -> LpdVector {
  { comps, dim: comps.length() }
}

pub fn lpd_vector_zero(dim : Int) -> LpdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn lpd_vector_add(a : LpdVector, b : LpdVector) -> LpdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = lpd_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn lpd_vector_sub(a : LpdVector, b : LpdVector) -> LpdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = lpd_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn lpd_vector_scale(v : LpdVector, s : Double) -> LpdVector {
  let mut result = []
  for i in 0..<v.dim { result = lpd_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn lpd_vector_dot(a : LpdVector, b : LpdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn lpd_vector_norm(v : LpdVector) -> Double { @_common.sqrt(lpd_vector_dot(v, v)) }

pub fn lpd_vector_normalize(v : LpdVector) -> LpdVector {
  let n = lpd_vector_norm(v)
  if n < 0.0000001 { v } else { lpd_vector_scale(v, 1.0 / n) }
}

pub fn lpd_vector_dist(a : LpdVector, b : LpdVector) -> Double {
  lpd_vector_norm(lpd_vector_sub(a, b))
}

pub fn lpd_vector_to_string(v : LpdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + lpd_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn lpd_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn lpd_std(data : Array[Double]) -> Double { @_common.sqrt(lpd_var(data)) }

pub fn lpd_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn lpd_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = lpd_std(a); let sb = lpd_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { lpd_cov(a, b) / (sa * sb) }
}

pub fn lpd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn lpd_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn lpd_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn lpd_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn lpd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn lpd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn lpd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = lpd_precision(pred, labels, pos); let r = lpd_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn lpd_dbl(x : Double) -> String {
  let i = if x >= 0.0 { lpd_int(x) } else { -lpd_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { lpd_int(f * 1000000.0) } else { lpd_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn lpd_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn lpd_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
