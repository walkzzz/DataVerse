///===
/// datatemporal/restore_op
/// S13.223 new

pub struct Restore_opPoint {
  x : Double
  y : Double
  label : Int
}

pub fn restore_op_make_point(x : Double, y : Double) -> Restore_opPoint {
  { x, y, label: 0 }
}

pub fn restore_op_make_labeled_point(x : Double, y : Double, label : Int) -> Restore_opPoint {
  { x, y, label }
}

pub fn restore_op_point_x(p : Restore_opPoint) -> Double { p.x }

pub fn restore_op_point_y(p : Restore_opPoint) -> Double { p.y }

pub fn restore_op_point_label(p : Restore_opPoint) -> Int { p.label }

pub fn restore_op_point_dist(a : Restore_opPoint, b : Restore_opPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn restore_op_point_add(a : Restore_opPoint, b : Restore_opPoint) -> Restore_opPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn restore_op_point_sub(a : Restore_opPoint, b : Restore_opPoint) -> Restore_opPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn restore_op_point_scale(pt : Restore_opPoint, s : Double) -> Restore_opPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn restore_op_point_dot(a : Restore_opPoint, b : Restore_opPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn restore_op_point_norm(pt : Restore_opPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn restore_op_point_to_string(pt : Restore_opPoint) -> String {
  "(" + restore_op_dbl(pt.x) + ", " + restore_op_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Restore_opSeries {
  vals : Array[Double]
  name : String
}

pub fn restore_op_make_series(vals : Array[Double], name : String) -> Restore_opSeries {
  { vals, name }
}

pub fn restore_op_series_len(s : Restore_opSeries) -> Int { s.vals.length() }

pub fn restore_op_series_sum(s : Restore_opSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn restore_op_series_mean(s : Restore_opSeries) -> Double {
  let n = restore_op_series_len(s)
  if n == 0 { 0.0 } else { restore_op_series_sum(s) / n.to_double() }
}

pub fn restore_op_series_min(s : Restore_opSeries) -> Double {
  let n = restore_op_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn restore_op_series_max(s : Restore_opSeries) -> Double {
  let n = restore_op_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn restore_op_series_var(s : Restore_opSeries) -> Double {
  let n = restore_op_series_len(s)
  if n == 0 { 0.0 } else {
    let m = restore_op_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn restore_op_series_std(s : Restore_opSeries) -> Double { @_common.sqrt(restore_op_series_var(s)) }

pub fn restore_op_series_scale(s : Restore_opSeries, f : Double) -> Restore_opSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = restore_op_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn restore_op_series_add(a : Restore_opSeries, b : Restore_opSeries) -> Restore_opSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = restore_op_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn restore_op_series_to_string(s : Restore_opSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + restore_op_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Restore_opMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn restore_op_make_matrix(rows : Int, cols : Int, val : Double) -> Restore_opMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn restore_op_matrix_identity(n : Int) -> Restore_opMatrix {
  let m = restore_op_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn restore_op_matrix_get(m : Restore_opMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn restore_op_matrix_transpose(m : Restore_opMatrix) -> Restore_opMatrix {
  let result = restore_op_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn restore_op_matrix_add(a : Restore_opMatrix, b : Restore_opMatrix) -> Restore_opMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = restore_op_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn restore_op_matrix_scale(m : Restore_opMatrix, s : Double) -> Restore_opMatrix {
  let result = restore_op_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn restore_op_matrix_multiply(a : Restore_opMatrix, b : Restore_opMatrix) -> Restore_opMatrix {
  if a.cols != b.rows { return restore_op_make_matrix(a.rows, b.cols, 0.0) }
  let result = restore_op_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn restore_op_matrix_trace(m : Restore_opMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn restore_op_matrix_norm(m : Restore_opMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn restore_op_matrix_to_string(m : Restore_opMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + restore_op_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Restore_opVector {
  comps : Array[Double]
  dim : Int
}

pub fn restore_op_make_vector(comps : Array[Double]) -> Restore_opVector {
  { comps, dim: comps.length() }
}

pub fn restore_op_vector_zero(dim : Int) -> Restore_opVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn restore_op_vector_add(a : Restore_opVector, b : Restore_opVector) -> Restore_opVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = restore_op_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn restore_op_vector_sub(a : Restore_opVector, b : Restore_opVector) -> Restore_opVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = restore_op_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn restore_op_vector_scale(v : Restore_opVector, s : Double) -> Restore_opVector {
  let mut result = []
  for i in 0..<v.dim { result = restore_op_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn restore_op_vector_dot(a : Restore_opVector, b : Restore_opVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn restore_op_vector_norm(v : Restore_opVector) -> Double { @_common.sqrt(restore_op_vector_dot(v, v)) }

pub fn restore_op_vector_normalize(v : Restore_opVector) -> Restore_opVector {
  let n = restore_op_vector_norm(v)
  if n < 0.0000001 { v } else { restore_op_vector_scale(v, 1.0 / n) }
}

pub fn restore_op_vector_dist(a : Restore_opVector, b : Restore_opVector) -> Double {
  restore_op_vector_norm(restore_op_vector_sub(a, b))
}

pub fn restore_op_vector_to_string(v : Restore_opVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + restore_op_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn restore_op_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn restore_op_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = restore_op_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn restore_op_std(data : Array[Double]) -> Double { @_common.sqrt(restore_op_var(data)) }

pub fn restore_op_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = restore_op_mean(a); let mb = restore_op_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn restore_op_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = restore_op_std(a); let sb = restore_op_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { restore_op_cov(a, b) / (sa * sb) }
}

pub fn restore_op_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn restore_op_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn restore_op_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn restore_op_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = restore_op_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn restore_op_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn restore_op_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn restore_op_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = restore_op_precision(pred, labels, pos); let r = restore_op_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn restore_op_dbl(x : Double) -> String {
  let i = if x >= 0.0 { restore_op_int(x) } else { -restore_op_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { restore_op_int(f * 1000000.0) } else { restore_op_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn restore_op_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn restore_op_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
