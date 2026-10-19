///===
/// learncore/svdd
/// S13.98 new

pub struct SvddPoint {
  x : Double
  y : Double
  label : Int
}

pub fn svdd_make_point(x : Double, y : Double) -> SvddPoint {
  { x, y, label: 0 }
}

pub fn svdd_make_labeled_point(x : Double, y : Double, label : Int) -> SvddPoint {
  { x, y, label }
}

pub fn svdd_point_x(p : SvddPoint) -> Double { p.x }

pub fn svdd_point_y(p : SvddPoint) -> Double { p.y }

pub fn svdd_point_label(p : SvddPoint) -> Int { p.label }

pub fn svdd_point_dist(a : SvddPoint, b : SvddPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  svdd_sqrt(dx * dx + dy * dy)
}

pub fn svdd_point_add(a : SvddPoint, b : SvddPoint) -> SvddPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn svdd_point_sub(a : SvddPoint, b : SvddPoint) -> SvddPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn svdd_point_scale(pt : SvddPoint, s : Double) -> SvddPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn svdd_point_dot(a : SvddPoint, b : SvddPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn svdd_point_norm(pt : SvddPoint) -> Double {
  svdd_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn svdd_point_to_string(pt : SvddPoint) -> String {
  "(" + svdd_dbl(pt.x) + ", " + svdd_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct SvddSeries {
  vals : Array[Double]
  name : String
}

pub fn svdd_make_series(vals : Array[Double], name : String) -> SvddSeries {
  { vals, name }
}

pub fn svdd_series_len(s : SvddSeries) -> Int { s.vals.length() }

pub fn svdd_series_sum(s : SvddSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn svdd_series_mean(s : SvddSeries) -> Double {
  let n = svdd_series_len(s)
  if n == 0 { 0.0 } else { svdd_series_sum(s) / n.to_double() }
}

pub fn svdd_series_min(s : SvddSeries) -> Double {
  let n = svdd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn svdd_series_max(s : SvddSeries) -> Double {
  let n = svdd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn svdd_series_var(s : SvddSeries) -> Double {
  let n = svdd_series_len(s)
  if n == 0 { 0.0 } else {
    let m = svdd_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn svdd_series_std(s : SvddSeries) -> Double { svdd_sqrt(svdd_series_var(s)) }

pub fn svdd_series_scale(s : SvddSeries, f : Double) -> SvddSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = svdd_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn svdd_series_add(a : SvddSeries, b : SvddSeries) -> SvddSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = svdd_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn svdd_series_to_string(s : SvddSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + svdd_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct SvddMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn svdd_make_matrix(rows : Int, cols : Int, val : Double) -> SvddMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn svdd_matrix_identity(n : Int) -> SvddMatrix {
  let m = svdd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn svdd_matrix_get(m : SvddMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn svdd_matrix_transpose(m : SvddMatrix) -> SvddMatrix {
  let result = svdd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn svdd_matrix_add(a : SvddMatrix, b : SvddMatrix) -> SvddMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = svdd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn svdd_matrix_scale(m : SvddMatrix, s : Double) -> SvddMatrix {
  let result = svdd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn svdd_matrix_multiply(a : SvddMatrix, b : SvddMatrix) -> SvddMatrix {
  if a.cols != b.rows { return svdd_make_matrix(a.rows, b.cols, 0.0) }
  let result = svdd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn svdd_matrix_trace(m : SvddMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn svdd_matrix_norm(m : SvddMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  svdd_sqrt(sum)
}

pub fn svdd_matrix_to_string(m : SvddMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + svdd_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct SvddVector {
  comps : Array[Double]
  dim : Int
}

pub fn svdd_make_vector(comps : Array[Double]) -> SvddVector {
  { comps, dim: comps.length() }
}

pub fn svdd_vector_zero(dim : Int) -> SvddVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn svdd_vector_add(a : SvddVector, b : SvddVector) -> SvddVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = svdd_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn svdd_vector_sub(a : SvddVector, b : SvddVector) -> SvddVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = svdd_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn svdd_vector_scale(v : SvddVector, s : Double) -> SvddVector {
  let mut result = []
  for i in 0..<v.dim { result = svdd_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn svdd_vector_dot(a : SvddVector, b : SvddVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn svdd_vector_norm(v : SvddVector) -> Double { svdd_sqrt(svdd_vector_dot(v, v)) }

pub fn svdd_vector_normalize(v : SvddVector) -> SvddVector {
  let n = svdd_vector_norm(v)
  if n < 0.0000001 { v } else { svdd_vector_scale(v, 1.0 / n) }
}

pub fn svdd_vector_dist(a : SvddVector, b : SvddVector) -> Double {
  svdd_vector_norm(svdd_vector_sub(a, b))
}

pub fn svdd_vector_to_string(v : SvddVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + svdd_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn svdd_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn svdd_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = svdd_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn svdd_std(data : Array[Double]) -> Double { svdd_sqrt(svdd_var(data)) }

pub fn svdd_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = svdd_mean(a); let mb = svdd_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn svdd_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = svdd_std(a); let sb = svdd_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { svdd_cov(a, b) / (sa * sb) }
}

pub fn svdd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn svdd_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn svdd_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + svdd_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn svdd_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = svdd_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn svdd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn svdd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn svdd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = svdd_precision(pred, labels, pos); let r = svdd_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn svdd_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn svdd_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn svdd_dbl(x : Double) -> String {
  let i = if x >= 0.0 { svdd_int(x) } else { -svdd_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { svdd_int(f * 1000000.0) } else { svdd_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn svdd_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn svdd_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
