///===
/// learncore/harmony_search
/// S13.79 new

pub struct Harmony_searchPoint {
  x : Double
  y : Double
  label : Int
}

pub fn harmony_search_make_point(x : Double, y : Double) -> Harmony_searchPoint {
  { x, y, label: 0 }
}

pub fn harmony_search_make_labeled_point(x : Double, y : Double, label : Int) -> Harmony_searchPoint {
  { x, y, label }
}

pub fn harmony_search_point_x(p : Harmony_searchPoint) -> Double { p.x }

pub fn harmony_search_point_y(p : Harmony_searchPoint) -> Double { p.y }

pub fn harmony_search_point_label(p : Harmony_searchPoint) -> Int { p.label }

pub fn harmony_search_point_dist(a : Harmony_searchPoint, b : Harmony_searchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn harmony_search_point_add(a : Harmony_searchPoint, b : Harmony_searchPoint) -> Harmony_searchPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn harmony_search_point_sub(a : Harmony_searchPoint, b : Harmony_searchPoint) -> Harmony_searchPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn harmony_search_point_scale(pt : Harmony_searchPoint, s : Double) -> Harmony_searchPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn harmony_search_point_dot(a : Harmony_searchPoint, b : Harmony_searchPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn harmony_search_point_norm(pt : Harmony_searchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn harmony_search_point_to_string(pt : Harmony_searchPoint) -> String {
  "(" + harmony_search_dbl(pt.x) + ", " + harmony_search_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Harmony_searchSeries {
  vals : Array[Double]
  name : String
}

pub fn harmony_search_make_series(vals : Array[Double], name : String) -> Harmony_searchSeries {
  { vals, name }
}

pub fn harmony_search_series_len(s : Harmony_searchSeries) -> Int { s.vals.length() }

pub fn harmony_search_series_sum(s : Harmony_searchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn harmony_search_series_mean(s : Harmony_searchSeries) -> Double {
  let n = harmony_search_series_len(s)
  if n == 0 { 0.0 } else { harmony_search_series_sum(s) / n.to_double() }
}

pub fn harmony_search_series_min(s : Harmony_searchSeries) -> Double {
  let n = harmony_search_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn harmony_search_series_max(s : Harmony_searchSeries) -> Double {
  let n = harmony_search_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn harmony_search_series_var(s : Harmony_searchSeries) -> Double {
  let n = harmony_search_series_len(s)
  if n == 0 { 0.0 } else {
    let m = harmony_search_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn harmony_search_series_std(s : Harmony_searchSeries) -> Double { @_common.sqrt(harmony_search_series_var(s)) }

pub fn harmony_search_series_scale(s : Harmony_searchSeries, f : Double) -> Harmony_searchSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = harmony_search_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn harmony_search_series_add(a : Harmony_searchSeries, b : Harmony_searchSeries) -> Harmony_searchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = harmony_search_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn harmony_search_series_to_string(s : Harmony_searchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + harmony_search_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Harmony_searchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn harmony_search_make_matrix(rows : Int, cols : Int, val : Double) -> Harmony_searchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn harmony_search_matrix_identity(n : Int) -> Harmony_searchMatrix {
  let m = harmony_search_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn harmony_search_matrix_get(m : Harmony_searchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn harmony_search_matrix_transpose(m : Harmony_searchMatrix) -> Harmony_searchMatrix {
  let result = harmony_search_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn harmony_search_matrix_add(a : Harmony_searchMatrix, b : Harmony_searchMatrix) -> Harmony_searchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = harmony_search_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn harmony_search_matrix_scale(m : Harmony_searchMatrix, s : Double) -> Harmony_searchMatrix {
  let result = harmony_search_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn harmony_search_matrix_multiply(a : Harmony_searchMatrix, b : Harmony_searchMatrix) -> Harmony_searchMatrix {
  if a.cols != b.rows { return harmony_search_make_matrix(a.rows, b.cols, 0.0) }
  let result = harmony_search_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn harmony_search_matrix_trace(m : Harmony_searchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn harmony_search_matrix_norm(m : Harmony_searchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn harmony_search_matrix_to_string(m : Harmony_searchMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + harmony_search_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Harmony_searchVector {
  comps : Array[Double]
  dim : Int
}

pub fn harmony_search_make_vector(comps : Array[Double]) -> Harmony_searchVector {
  { comps, dim: comps.length() }
}

pub fn harmony_search_vector_zero(dim : Int) -> Harmony_searchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn harmony_search_vector_add(a : Harmony_searchVector, b : Harmony_searchVector) -> Harmony_searchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = harmony_search_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn harmony_search_vector_sub(a : Harmony_searchVector, b : Harmony_searchVector) -> Harmony_searchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = harmony_search_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn harmony_search_vector_scale(v : Harmony_searchVector, s : Double) -> Harmony_searchVector {
  let mut result = []
  for i in 0..<v.dim { result = harmony_search_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn harmony_search_vector_dot(a : Harmony_searchVector, b : Harmony_searchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn harmony_search_vector_norm(v : Harmony_searchVector) -> Double { @_common.sqrt(harmony_search_vector_dot(v, v)) }

pub fn harmony_search_vector_normalize(v : Harmony_searchVector) -> Harmony_searchVector {
  let n = harmony_search_vector_norm(v)
  if n < 0.0000001 { v } else { harmony_search_vector_scale(v, 1.0 / n) }
}

pub fn harmony_search_vector_dist(a : Harmony_searchVector, b : Harmony_searchVector) -> Double {
  harmony_search_vector_norm(harmony_search_vector_sub(a, b))
}

pub fn harmony_search_vector_to_string(v : Harmony_searchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + harmony_search_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn harmony_search_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn harmony_search_std(data : Array[Double]) -> Double { @_common.sqrt(harmony_search_var(data)) }

pub fn harmony_search_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn harmony_search_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = harmony_search_std(a); let sb = harmony_search_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { harmony_search_cov(a, b) / (sa * sb) }
}

pub fn harmony_search_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn harmony_search_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn harmony_search_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn harmony_search_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn harmony_search_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn harmony_search_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn harmony_search_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = harmony_search_precision(pred, labels, pos); let r = harmony_search_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn harmony_search_dbl(x : Double) -> String {
  let i = if x >= 0.0 { harmony_search_int(x) } else { -harmony_search_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { harmony_search_int(f * 1000000.0) } else { harmony_search_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn harmony_search_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn harmony_search_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
