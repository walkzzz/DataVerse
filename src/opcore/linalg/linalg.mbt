///===
/// opcore/linalg
/// S13.1 new

pub struct LinalgPoint {
  x : Double
  y : Double
  label : Int
}

pub fn linalg_make_point(x : Double, y : Double) -> LinalgPoint {
  { x, y, label: 0 }
}

pub fn linalg_make_labeled_point(x : Double, y : Double, label : Int) -> LinalgPoint {
  { x, y, label }
}

pub fn linalg_point_x(p : LinalgPoint) -> Double { p.x }

pub fn linalg_point_y(p : LinalgPoint) -> Double { p.y }

pub fn linalg_point_label(p : LinalgPoint) -> Int { p.label }

pub fn linalg_point_dist(a : LinalgPoint, b : LinalgPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn linalg_point_add(a : LinalgPoint, b : LinalgPoint) -> LinalgPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn linalg_point_sub(a : LinalgPoint, b : LinalgPoint) -> LinalgPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn linalg_point_scale(pt : LinalgPoint, s : Double) -> LinalgPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn linalg_point_dot(a : LinalgPoint, b : LinalgPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn linalg_point_norm(pt : LinalgPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn linalg_point_to_string(pt : LinalgPoint) -> String {
  "(" + linalg_dbl(pt.x) + ", " + linalg_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct LinalgSeries {
  vals : Array[Double]
  name : String
}

pub fn linalg_make_series(vals : Array[Double], name : String) -> LinalgSeries {
  { vals, name }
}

pub fn linalg_series_len(s : LinalgSeries) -> Int { s.vals.length() }

pub fn linalg_series_sum(s : LinalgSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn linalg_series_mean(s : LinalgSeries) -> Double {
  let n = linalg_series_len(s)
  if n == 0 { 0.0 } else { linalg_series_sum(s) / n.to_double() }
}

pub fn linalg_series_min(s : LinalgSeries) -> Double {
  let n = linalg_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn linalg_series_max(s : LinalgSeries) -> Double {
  let n = linalg_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn linalg_series_var(s : LinalgSeries) -> Double {
  let n = linalg_series_len(s)
  if n == 0 { 0.0 } else {
    let m = linalg_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn linalg_series_std(s : LinalgSeries) -> Double { @_common.sqrt(linalg_series_var(s)) }

pub fn linalg_series_scale(s : LinalgSeries, f : Double) -> LinalgSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = linalg_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn linalg_series_add(a : LinalgSeries, b : LinalgSeries) -> LinalgSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = linalg_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn linalg_series_to_string(s : LinalgSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + linalg_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct LinalgMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn linalg_make_matrix(rows : Int, cols : Int, val : Double) -> LinalgMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn linalg_matrix_identity(n : Int) -> LinalgMatrix {
  let m = linalg_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn linalg_matrix_get(m : LinalgMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn linalg_matrix_transpose(m : LinalgMatrix) -> LinalgMatrix {
  let result = linalg_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn linalg_matrix_add(a : LinalgMatrix, b : LinalgMatrix) -> LinalgMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = linalg_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn linalg_matrix_scale(m : LinalgMatrix, s : Double) -> LinalgMatrix {
  let result = linalg_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn linalg_matrix_multiply(a : LinalgMatrix, b : LinalgMatrix) -> LinalgMatrix {
  if a.cols != b.rows { return linalg_make_matrix(a.rows, b.cols, 0.0) }
  let result = linalg_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn linalg_matrix_trace(m : LinalgMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn linalg_matrix_norm(m : LinalgMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn linalg_matrix_to_string(m : LinalgMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + linalg_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct LinalgVector {
  comps : Array[Double]
  dim : Int
}

pub fn linalg_make_vector(comps : Array[Double]) -> LinalgVector {
  { comps, dim: comps.length() }
}

pub fn linalg_vector_zero(dim : Int) -> LinalgVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn linalg_vector_add(a : LinalgVector, b : LinalgVector) -> LinalgVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = linalg_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn linalg_vector_sub(a : LinalgVector, b : LinalgVector) -> LinalgVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = linalg_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn linalg_vector_scale(v : LinalgVector, s : Double) -> LinalgVector {
  let mut result = []
  for i in 0..<v.dim { result = linalg_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn linalg_vector_dot(a : LinalgVector, b : LinalgVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn linalg_vector_norm(v : LinalgVector) -> Double { @_common.sqrt(linalg_vector_dot(v, v)) }

pub fn linalg_vector_normalize(v : LinalgVector) -> LinalgVector {
  let n = linalg_vector_norm(v)
  if n < 0.0000001 { v } else { linalg_vector_scale(v, 1.0 / n) }
}

pub fn linalg_vector_dist(a : LinalgVector, b : LinalgVector) -> Double {
  linalg_vector_norm(linalg_vector_sub(a, b))
}

pub fn linalg_vector_to_string(v : LinalgVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + linalg_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn linalg_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn linalg_std(data : Array[Double]) -> Double { @_common.sqrt(linalg_var(data)) }

pub fn linalg_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn linalg_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = linalg_std(a); let sb = linalg_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { linalg_cov(a, b) / (sa * sb) }
}

pub fn linalg_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn linalg_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn linalg_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn linalg_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn linalg_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn linalg_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn linalg_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = linalg_precision(pred, labels, pos); let r = linalg_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn linalg_dbl(x : Double) -> String {
  let i = if x >= 0.0 { linalg_int(x) } else { -linalg_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { linalg_int(f * 1000000.0) } else { linalg_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn linalg_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn linalg_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
