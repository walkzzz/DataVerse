///===
/// datatemporal/pipe_buf
/// S13.233 new

pub struct Pipe_bufPoint {
  x : Double
  y : Double
  label : Int
}

pub fn pipe_buf_make_point(x : Double, y : Double) -> Pipe_bufPoint {
  { x, y, label: 0 }
}

pub fn pipe_buf_make_labeled_point(x : Double, y : Double, label : Int) -> Pipe_bufPoint {
  { x, y, label }
}

pub fn pipe_buf_point_x(p : Pipe_bufPoint) -> Double { p.x }

pub fn pipe_buf_point_y(p : Pipe_bufPoint) -> Double { p.y }

pub fn pipe_buf_point_label(p : Pipe_bufPoint) -> Int { p.label }

pub fn pipe_buf_point_dist(a : Pipe_bufPoint, b : Pipe_bufPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  pipe_buf_sqrt(dx * dx + dy * dy)
}

pub fn pipe_buf_point_add(a : Pipe_bufPoint, b : Pipe_bufPoint) -> Pipe_bufPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn pipe_buf_point_sub(a : Pipe_bufPoint, b : Pipe_bufPoint) -> Pipe_bufPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn pipe_buf_point_scale(pt : Pipe_bufPoint, s : Double) -> Pipe_bufPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn pipe_buf_point_dot(a : Pipe_bufPoint, b : Pipe_bufPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn pipe_buf_point_norm(pt : Pipe_bufPoint) -> Double {
  pipe_buf_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn pipe_buf_point_to_string(pt : Pipe_bufPoint) -> String {
  "(" + pipe_buf_dbl(pt.x) + ", " + pipe_buf_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Pipe_bufSeries {
  vals : Array[Double]
  name : String
}

pub fn pipe_buf_make_series(vals : Array[Double], name : String) -> Pipe_bufSeries {
  { vals, name }
}

pub fn pipe_buf_series_len(s : Pipe_bufSeries) -> Int { s.vals.length() }

pub fn pipe_buf_series_sum(s : Pipe_bufSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn pipe_buf_series_mean(s : Pipe_bufSeries) -> Double {
  let n = pipe_buf_series_len(s)
  if n == 0 { 0.0 } else { pipe_buf_series_sum(s) / n.to_double() }
}

pub fn pipe_buf_series_min(s : Pipe_bufSeries) -> Double {
  let n = pipe_buf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn pipe_buf_series_max(s : Pipe_bufSeries) -> Double {
  let n = pipe_buf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn pipe_buf_series_var(s : Pipe_bufSeries) -> Double {
  let n = pipe_buf_series_len(s)
  if n == 0 { 0.0 } else {
    let m = pipe_buf_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn pipe_buf_series_std(s : Pipe_bufSeries) -> Double { pipe_buf_sqrt(pipe_buf_series_var(s)) }

pub fn pipe_buf_series_scale(s : Pipe_bufSeries, f : Double) -> Pipe_bufSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = pipe_buf_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn pipe_buf_series_add(a : Pipe_bufSeries, b : Pipe_bufSeries) -> Pipe_bufSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = pipe_buf_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn pipe_buf_series_to_string(s : Pipe_bufSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + pipe_buf_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Pipe_bufMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn pipe_buf_make_matrix(rows : Int, cols : Int, val : Double) -> Pipe_bufMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn pipe_buf_matrix_identity(n : Int) -> Pipe_bufMatrix {
  let m = pipe_buf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn pipe_buf_matrix_get(m : Pipe_bufMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn pipe_buf_matrix_transpose(m : Pipe_bufMatrix) -> Pipe_bufMatrix {
  let result = pipe_buf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn pipe_buf_matrix_add(a : Pipe_bufMatrix, b : Pipe_bufMatrix) -> Pipe_bufMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = pipe_buf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn pipe_buf_matrix_scale(m : Pipe_bufMatrix, s : Double) -> Pipe_bufMatrix {
  let result = pipe_buf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn pipe_buf_matrix_multiply(a : Pipe_bufMatrix, b : Pipe_bufMatrix) -> Pipe_bufMatrix {
  if a.cols != b.rows { return pipe_buf_make_matrix(a.rows, b.cols, 0.0) }
  let result = pipe_buf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn pipe_buf_matrix_trace(m : Pipe_bufMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn pipe_buf_matrix_norm(m : Pipe_bufMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  pipe_buf_sqrt(sum)
}

pub fn pipe_buf_matrix_to_string(m : Pipe_bufMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + pipe_buf_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Pipe_bufVector {
  comps : Array[Double]
  dim : Int
}

pub fn pipe_buf_make_vector(comps : Array[Double]) -> Pipe_bufVector {
  { comps, dim: comps.length() }
}

pub fn pipe_buf_vector_zero(dim : Int) -> Pipe_bufVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn pipe_buf_vector_add(a : Pipe_bufVector, b : Pipe_bufVector) -> Pipe_bufVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = pipe_buf_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn pipe_buf_vector_sub(a : Pipe_bufVector, b : Pipe_bufVector) -> Pipe_bufVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = pipe_buf_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn pipe_buf_vector_scale(v : Pipe_bufVector, s : Double) -> Pipe_bufVector {
  let mut result = []
  for i in 0..<v.dim { result = pipe_buf_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn pipe_buf_vector_dot(a : Pipe_bufVector, b : Pipe_bufVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn pipe_buf_vector_norm(v : Pipe_bufVector) -> Double { pipe_buf_sqrt(pipe_buf_vector_dot(v, v)) }

pub fn pipe_buf_vector_normalize(v : Pipe_bufVector) -> Pipe_bufVector {
  let n = pipe_buf_vector_norm(v)
  if n < 0.0000001 { v } else { pipe_buf_vector_scale(v, 1.0 / n) }
}

pub fn pipe_buf_vector_dist(a : Pipe_bufVector, b : Pipe_bufVector) -> Double {
  pipe_buf_vector_norm(pipe_buf_vector_sub(a, b))
}

pub fn pipe_buf_vector_to_string(v : Pipe_bufVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + pipe_buf_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn pipe_buf_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn pipe_buf_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = pipe_buf_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn pipe_buf_std(data : Array[Double]) -> Double { pipe_buf_sqrt(pipe_buf_var(data)) }

pub fn pipe_buf_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = pipe_buf_mean(a); let mb = pipe_buf_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn pipe_buf_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = pipe_buf_std(a); let sb = pipe_buf_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { pipe_buf_cov(a, b) / (sa * sb) }
}

pub fn pipe_buf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn pipe_buf_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn pipe_buf_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + pipe_buf_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn pipe_buf_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = pipe_buf_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn pipe_buf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn pipe_buf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn pipe_buf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = pipe_buf_precision(pred, labels, pos); let r = pipe_buf_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn pipe_buf_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn pipe_buf_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn pipe_buf_dbl(x : Double) -> String {
  let i = if x >= 0.0 { pipe_buf_int(x) } else { -pipe_buf_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { pipe_buf_int(f * 1000000.0) } else { pipe_buf_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn pipe_buf_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn pipe_buf_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
