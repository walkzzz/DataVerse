///===
/// learncore/gaussian_proc
/// S13.88 new

pub struct Gaussian_procPoint {
  x : Double
  y : Double
  label : Int
}

pub fn gaussian_proc_make_point(x : Double, y : Double) -> Gaussian_procPoint {
  { x, y, label: 0 }
}

pub fn gaussian_proc_make_labeled_point(x : Double, y : Double, label : Int) -> Gaussian_procPoint {
  { x, y, label }
}

pub fn gaussian_proc_point_x(p : Gaussian_procPoint) -> Double { p.x }

pub fn gaussian_proc_point_y(p : Gaussian_procPoint) -> Double { p.y }

pub fn gaussian_proc_point_label(p : Gaussian_procPoint) -> Int { p.label }

pub fn gaussian_proc_point_dist(a : Gaussian_procPoint, b : Gaussian_procPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn gaussian_proc_point_add(a : Gaussian_procPoint, b : Gaussian_procPoint) -> Gaussian_procPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn gaussian_proc_point_sub(a : Gaussian_procPoint, b : Gaussian_procPoint) -> Gaussian_procPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn gaussian_proc_point_scale(pt : Gaussian_procPoint, s : Double) -> Gaussian_procPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn gaussian_proc_point_dot(a : Gaussian_procPoint, b : Gaussian_procPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn gaussian_proc_point_norm(pt : Gaussian_procPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn gaussian_proc_point_to_string(pt : Gaussian_procPoint) -> String {
  "(" + gaussian_proc_dbl(pt.x) + ", " + gaussian_proc_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Gaussian_procSeries {
  vals : Array[Double]
  name : String
}

pub fn gaussian_proc_make_series(vals : Array[Double], name : String) -> Gaussian_procSeries {
  { vals, name }
}

pub fn gaussian_proc_series_len(s : Gaussian_procSeries) -> Int { s.vals.length() }

pub fn gaussian_proc_series_sum(s : Gaussian_procSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn gaussian_proc_series_mean(s : Gaussian_procSeries) -> Double {
  let n = gaussian_proc_series_len(s)
  if n == 0 { 0.0 } else { gaussian_proc_series_sum(s) / n.to_double() }
}

pub fn gaussian_proc_series_min(s : Gaussian_procSeries) -> Double {
  let n = gaussian_proc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn gaussian_proc_series_max(s : Gaussian_procSeries) -> Double {
  let n = gaussian_proc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn gaussian_proc_series_var(s : Gaussian_procSeries) -> Double {
  let n = gaussian_proc_series_len(s)
  if n == 0 { 0.0 } else {
    let m = gaussian_proc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn gaussian_proc_series_std(s : Gaussian_procSeries) -> Double { @_common.sqrt(gaussian_proc_series_var(s)) }

pub fn gaussian_proc_series_scale(s : Gaussian_procSeries, f : Double) -> Gaussian_procSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = gaussian_proc_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn gaussian_proc_series_add(a : Gaussian_procSeries, b : Gaussian_procSeries) -> Gaussian_procSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = gaussian_proc_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn gaussian_proc_series_to_string(s : Gaussian_procSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + gaussian_proc_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Gaussian_procMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn gaussian_proc_make_matrix(rows : Int, cols : Int, val : Double) -> Gaussian_procMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn gaussian_proc_matrix_identity(n : Int) -> Gaussian_procMatrix {
  let m = gaussian_proc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn gaussian_proc_matrix_get(m : Gaussian_procMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn gaussian_proc_matrix_transpose(m : Gaussian_procMatrix) -> Gaussian_procMatrix {
  let result = gaussian_proc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn gaussian_proc_matrix_add(a : Gaussian_procMatrix, b : Gaussian_procMatrix) -> Gaussian_procMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = gaussian_proc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn gaussian_proc_matrix_scale(m : Gaussian_procMatrix, s : Double) -> Gaussian_procMatrix {
  let result = gaussian_proc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn gaussian_proc_matrix_multiply(a : Gaussian_procMatrix, b : Gaussian_procMatrix) -> Gaussian_procMatrix {
  if a.cols != b.rows { return gaussian_proc_make_matrix(a.rows, b.cols, 0.0) }
  let result = gaussian_proc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn gaussian_proc_matrix_trace(m : Gaussian_procMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn gaussian_proc_matrix_norm(m : Gaussian_procMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn gaussian_proc_matrix_to_string(m : Gaussian_procMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + gaussian_proc_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Gaussian_procVector {
  comps : Array[Double]
  dim : Int
}

pub fn gaussian_proc_make_vector(comps : Array[Double]) -> Gaussian_procVector {
  { comps, dim: comps.length() }
}

pub fn gaussian_proc_vector_zero(dim : Int) -> Gaussian_procVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn gaussian_proc_vector_add(a : Gaussian_procVector, b : Gaussian_procVector) -> Gaussian_procVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = gaussian_proc_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn gaussian_proc_vector_sub(a : Gaussian_procVector, b : Gaussian_procVector) -> Gaussian_procVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = gaussian_proc_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn gaussian_proc_vector_scale(v : Gaussian_procVector, s : Double) -> Gaussian_procVector {
  let mut result = []
  for i in 0..<v.dim { result = gaussian_proc_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn gaussian_proc_vector_dot(a : Gaussian_procVector, b : Gaussian_procVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn gaussian_proc_vector_norm(v : Gaussian_procVector) -> Double { @_common.sqrt(gaussian_proc_vector_dot(v, v)) }

pub fn gaussian_proc_vector_normalize(v : Gaussian_procVector) -> Gaussian_procVector {
  let n = gaussian_proc_vector_norm(v)
  if n < 0.0000001 { v } else { gaussian_proc_vector_scale(v, 1.0 / n) }
}

pub fn gaussian_proc_vector_dist(a : Gaussian_procVector, b : Gaussian_procVector) -> Double {
  gaussian_proc_vector_norm(gaussian_proc_vector_sub(a, b))
}

pub fn gaussian_proc_vector_to_string(v : Gaussian_procVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + gaussian_proc_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn gaussian_proc_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn gaussian_proc_std(data : Array[Double]) -> Double { @_common.sqrt(gaussian_proc_var(data)) }

pub fn gaussian_proc_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn gaussian_proc_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = gaussian_proc_std(a); let sb = gaussian_proc_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { gaussian_proc_cov(a, b) / (sa * sb) }
}

pub fn gaussian_proc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn gaussian_proc_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn gaussian_proc_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn gaussian_proc_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn gaussian_proc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn gaussian_proc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn gaussian_proc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = gaussian_proc_precision(pred, labels, pos); let r = gaussian_proc_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn gaussian_proc_dbl(x : Double) -> String {
  let i = if x >= 0.0 { gaussian_proc_int(x) } else { -gaussian_proc_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { gaussian_proc_int(f * 1000000.0) } else { gaussian_proc_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn gaussian_proc_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn gaussian_proc_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
