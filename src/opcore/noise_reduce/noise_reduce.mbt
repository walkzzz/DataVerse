///===
/// opcore/noise_reduce
/// S13.39 new

pub struct Noise_reducePoint {
  x : Double
  y : Double
  label : Int
}

pub fn noise_reduce_make_point(x : Double, y : Double) -> Noise_reducePoint {
  { x, y, label: 0 }
}

pub fn noise_reduce_make_labeled_point(x : Double, y : Double, label : Int) -> Noise_reducePoint {
  { x, y, label }
}

pub fn noise_reduce_point_x(p : Noise_reducePoint) -> Double { p.x }

pub fn noise_reduce_point_y(p : Noise_reducePoint) -> Double { p.y }

pub fn noise_reduce_point_label(p : Noise_reducePoint) -> Int { p.label }

pub fn noise_reduce_point_dist(a : Noise_reducePoint, b : Noise_reducePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn noise_reduce_point_add(a : Noise_reducePoint, b : Noise_reducePoint) -> Noise_reducePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn noise_reduce_point_sub(a : Noise_reducePoint, b : Noise_reducePoint) -> Noise_reducePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn noise_reduce_point_scale(pt : Noise_reducePoint, s : Double) -> Noise_reducePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn noise_reduce_point_dot(a : Noise_reducePoint, b : Noise_reducePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn noise_reduce_point_norm(pt : Noise_reducePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn noise_reduce_point_to_string(pt : Noise_reducePoint) -> String {
  "(" + noise_reduce_dbl(pt.x) + ", " + noise_reduce_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Noise_reduceSeries {
  vals : Array[Double]
  name : String
}

pub fn noise_reduce_make_series(vals : Array[Double], name : String) -> Noise_reduceSeries {
  { vals, name }
}

pub fn noise_reduce_series_len(s : Noise_reduceSeries) -> Int { s.vals.length() }

pub fn noise_reduce_series_sum(s : Noise_reduceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn noise_reduce_series_mean(s : Noise_reduceSeries) -> Double {
  let n = noise_reduce_series_len(s)
  if n == 0 { 0.0 } else { noise_reduce_series_sum(s) / n.to_double() }
}

pub fn noise_reduce_series_min(s : Noise_reduceSeries) -> Double {
  let n = noise_reduce_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn noise_reduce_series_max(s : Noise_reduceSeries) -> Double {
  let n = noise_reduce_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn noise_reduce_series_var(s : Noise_reduceSeries) -> Double {
  let n = noise_reduce_series_len(s)
  if n == 0 { 0.0 } else {
    let m = noise_reduce_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn noise_reduce_series_std(s : Noise_reduceSeries) -> Double { @_common.sqrt(noise_reduce_series_var(s)) }

pub fn noise_reduce_series_scale(s : Noise_reduceSeries, f : Double) -> Noise_reduceSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = noise_reduce_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn noise_reduce_series_add(a : Noise_reduceSeries, b : Noise_reduceSeries) -> Noise_reduceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = noise_reduce_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn noise_reduce_series_to_string(s : Noise_reduceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + noise_reduce_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Noise_reduceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn noise_reduce_make_matrix(rows : Int, cols : Int, val : Double) -> Noise_reduceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn noise_reduce_matrix_identity(n : Int) -> Noise_reduceMatrix {
  let m = noise_reduce_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn noise_reduce_matrix_get(m : Noise_reduceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn noise_reduce_matrix_transpose(m : Noise_reduceMatrix) -> Noise_reduceMatrix {
  let result = noise_reduce_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn noise_reduce_matrix_add(a : Noise_reduceMatrix, b : Noise_reduceMatrix) -> Noise_reduceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = noise_reduce_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn noise_reduce_matrix_scale(m : Noise_reduceMatrix, s : Double) -> Noise_reduceMatrix {
  let result = noise_reduce_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn noise_reduce_matrix_multiply(a : Noise_reduceMatrix, b : Noise_reduceMatrix) -> Noise_reduceMatrix {
  if a.cols != b.rows { return noise_reduce_make_matrix(a.rows, b.cols, 0.0) }
  let result = noise_reduce_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn noise_reduce_matrix_trace(m : Noise_reduceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn noise_reduce_matrix_norm(m : Noise_reduceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn noise_reduce_matrix_to_string(m : Noise_reduceMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + noise_reduce_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Noise_reduceVector {
  comps : Array[Double]
  dim : Int
}

pub fn noise_reduce_make_vector(comps : Array[Double]) -> Noise_reduceVector {
  { comps, dim: comps.length() }
}

pub fn noise_reduce_vector_zero(dim : Int) -> Noise_reduceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn noise_reduce_vector_add(a : Noise_reduceVector, b : Noise_reduceVector) -> Noise_reduceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = noise_reduce_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn noise_reduce_vector_sub(a : Noise_reduceVector, b : Noise_reduceVector) -> Noise_reduceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = noise_reduce_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn noise_reduce_vector_scale(v : Noise_reduceVector, s : Double) -> Noise_reduceVector {
  let mut result = []
  for i in 0..<v.dim { result = noise_reduce_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn noise_reduce_vector_dot(a : Noise_reduceVector, b : Noise_reduceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn noise_reduce_vector_norm(v : Noise_reduceVector) -> Double { @_common.sqrt(noise_reduce_vector_dot(v, v)) }

pub fn noise_reduce_vector_normalize(v : Noise_reduceVector) -> Noise_reduceVector {
  let n = noise_reduce_vector_norm(v)
  if n < 0.0000001 { v } else { noise_reduce_vector_scale(v, 1.0 / n) }
}

pub fn noise_reduce_vector_dist(a : Noise_reduceVector, b : Noise_reduceVector) -> Double {
  noise_reduce_vector_norm(noise_reduce_vector_sub(a, b))
}

pub fn noise_reduce_vector_to_string(v : Noise_reduceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + noise_reduce_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn noise_reduce_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn noise_reduce_std(data : Array[Double]) -> Double { @_common.sqrt(noise_reduce_var(data)) }

pub fn noise_reduce_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn noise_reduce_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = noise_reduce_std(a); let sb = noise_reduce_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { noise_reduce_cov(a, b) / (sa * sb) }
}

pub fn noise_reduce_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn noise_reduce_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn noise_reduce_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn noise_reduce_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn noise_reduce_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn noise_reduce_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn noise_reduce_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = noise_reduce_precision(pred, labels, pos); let r = noise_reduce_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn noise_reduce_dbl(x : Double) -> String {
  let i = if x >= 0.0 { noise_reduce_int(x) } else { -noise_reduce_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { noise_reduce_int(f * 1000000.0) } else { noise_reduce_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn noise_reduce_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn noise_reduce_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
