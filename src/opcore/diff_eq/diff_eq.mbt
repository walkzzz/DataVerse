///===
/// opcore/diff_eq
/// S13.3 new

pub struct Diff_eqPoint {
  x : Double
  y : Double
  label : Int
}

pub fn diff_eq_make_point(x : Double, y : Double) -> Diff_eqPoint {
  { x, y, label: 0 }
}

pub fn diff_eq_make_labeled_point(x : Double, y : Double, label : Int) -> Diff_eqPoint {
  { x, y, label }
}

pub fn diff_eq_point_x(p : Diff_eqPoint) -> Double { p.x }

pub fn diff_eq_point_y(p : Diff_eqPoint) -> Double { p.y }

pub fn diff_eq_point_label(p : Diff_eqPoint) -> Int { p.label }

pub fn diff_eq_point_dist(a : Diff_eqPoint, b : Diff_eqPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn diff_eq_point_add(a : Diff_eqPoint, b : Diff_eqPoint) -> Diff_eqPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn diff_eq_point_sub(a : Diff_eqPoint, b : Diff_eqPoint) -> Diff_eqPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn diff_eq_point_scale(pt : Diff_eqPoint, s : Double) -> Diff_eqPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn diff_eq_point_dot(a : Diff_eqPoint, b : Diff_eqPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn diff_eq_point_norm(pt : Diff_eqPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn diff_eq_point_to_string(pt : Diff_eqPoint) -> String {
  "(" + diff_eq_dbl(pt.x) + ", " + diff_eq_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Diff_eqSeries {
  vals : Array[Double]
  name : String
}

pub fn diff_eq_make_series(vals : Array[Double], name : String) -> Diff_eqSeries {
  { vals, name }
}

pub fn diff_eq_series_len(s : Diff_eqSeries) -> Int { s.vals.length() }

pub fn diff_eq_series_sum(s : Diff_eqSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn diff_eq_series_mean(s : Diff_eqSeries) -> Double {
  let n = diff_eq_series_len(s)
  if n == 0 { 0.0 } else { diff_eq_series_sum(s) / n.to_double() }
}

pub fn diff_eq_series_min(s : Diff_eqSeries) -> Double {
  let n = diff_eq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn diff_eq_series_max(s : Diff_eqSeries) -> Double {
  let n = diff_eq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn diff_eq_series_var(s : Diff_eqSeries) -> Double {
  let n = diff_eq_series_len(s)
  if n == 0 { 0.0 } else {
    let m = diff_eq_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn diff_eq_series_std(s : Diff_eqSeries) -> Double { @_common.sqrt(diff_eq_series_var(s)) }

pub fn diff_eq_series_scale(s : Diff_eqSeries, f : Double) -> Diff_eqSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = diff_eq_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn diff_eq_series_add(a : Diff_eqSeries, b : Diff_eqSeries) -> Diff_eqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = diff_eq_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn diff_eq_series_to_string(s : Diff_eqSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + diff_eq_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Diff_eqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn diff_eq_make_matrix(rows : Int, cols : Int, val : Double) -> Diff_eqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn diff_eq_matrix_identity(n : Int) -> Diff_eqMatrix {
  let m = diff_eq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn diff_eq_matrix_get(m : Diff_eqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn diff_eq_matrix_transpose(m : Diff_eqMatrix) -> Diff_eqMatrix {
  let result = diff_eq_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn diff_eq_matrix_add(a : Diff_eqMatrix, b : Diff_eqMatrix) -> Diff_eqMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = diff_eq_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn diff_eq_matrix_scale(m : Diff_eqMatrix, s : Double) -> Diff_eqMatrix {
  let result = diff_eq_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn diff_eq_matrix_multiply(a : Diff_eqMatrix, b : Diff_eqMatrix) -> Diff_eqMatrix {
  if a.cols != b.rows { return diff_eq_make_matrix(a.rows, b.cols, 0.0) }
  let result = diff_eq_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn diff_eq_matrix_trace(m : Diff_eqMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn diff_eq_matrix_norm(m : Diff_eqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn diff_eq_matrix_to_string(m : Diff_eqMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + diff_eq_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Diff_eqVector {
  comps : Array[Double]
  dim : Int
}

pub fn diff_eq_make_vector(comps : Array[Double]) -> Diff_eqVector {
  { comps, dim: comps.length() }
}

pub fn diff_eq_vector_zero(dim : Int) -> Diff_eqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn diff_eq_vector_add(a : Diff_eqVector, b : Diff_eqVector) -> Diff_eqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = diff_eq_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn diff_eq_vector_sub(a : Diff_eqVector, b : Diff_eqVector) -> Diff_eqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = diff_eq_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn diff_eq_vector_scale(v : Diff_eqVector, s : Double) -> Diff_eqVector {
  let mut result = []
  for i in 0..<v.dim { result = diff_eq_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn diff_eq_vector_dot(a : Diff_eqVector, b : Diff_eqVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn diff_eq_vector_norm(v : Diff_eqVector) -> Double { @_common.sqrt(diff_eq_vector_dot(v, v)) }

pub fn diff_eq_vector_normalize(v : Diff_eqVector) -> Diff_eqVector {
  let n = diff_eq_vector_norm(v)
  if n < 0.0000001 { v } else { diff_eq_vector_scale(v, 1.0 / n) }
}

pub fn diff_eq_vector_dist(a : Diff_eqVector, b : Diff_eqVector) -> Double {
  diff_eq_vector_norm(diff_eq_vector_sub(a, b))
}

pub fn diff_eq_vector_to_string(v : Diff_eqVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + diff_eq_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn diff_eq_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn diff_eq_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = diff_eq_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn diff_eq_std(data : Array[Double]) -> Double { @_common.sqrt(diff_eq_var(data)) }

pub fn diff_eq_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = diff_eq_mean(a); let mb = diff_eq_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn diff_eq_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = diff_eq_std(a); let sb = diff_eq_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { diff_eq_cov(a, b) / (sa * sb) }
}

pub fn diff_eq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn diff_eq_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn diff_eq_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn diff_eq_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = diff_eq_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn diff_eq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn diff_eq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn diff_eq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = diff_eq_precision(pred, labels, pos); let r = diff_eq_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn diff_eq_dbl(x : Double) -> String {
  let i = if x >= 0.0 { diff_eq_int(x) } else { -diff_eq_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { diff_eq_int(f * 1000000.0) } else { diff_eq_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn diff_eq_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn diff_eq_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
