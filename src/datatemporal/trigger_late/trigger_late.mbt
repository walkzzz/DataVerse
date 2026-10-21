///===
/// datatemporal/trigger_late
/// S13.217 new

pub struct Trigger_latePoint {
  x : Double
  y : Double
  label : Int
}

pub fn trigger_late_make_point(x : Double, y : Double) -> Trigger_latePoint {
  { x, y, label: 0 }
}

pub fn trigger_late_make_labeled_point(x : Double, y : Double, label : Int) -> Trigger_latePoint {
  { x, y, label }
}

pub fn trigger_late_point_x(p : Trigger_latePoint) -> Double { p.x }

pub fn trigger_late_point_y(p : Trigger_latePoint) -> Double { p.y }

pub fn trigger_late_point_label(p : Trigger_latePoint) -> Int { p.label }

pub fn trigger_late_point_dist(a : Trigger_latePoint, b : Trigger_latePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn trigger_late_point_add(a : Trigger_latePoint, b : Trigger_latePoint) -> Trigger_latePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn trigger_late_point_sub(a : Trigger_latePoint, b : Trigger_latePoint) -> Trigger_latePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn trigger_late_point_scale(pt : Trigger_latePoint, s : Double) -> Trigger_latePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn trigger_late_point_dot(a : Trigger_latePoint, b : Trigger_latePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn trigger_late_point_norm(pt : Trigger_latePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn trigger_late_point_to_string(pt : Trigger_latePoint) -> String {
  "(" + trigger_late_dbl(pt.x) + ", " + trigger_late_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Trigger_lateSeries {
  vals : Array[Double]
  name : String
}

pub fn trigger_late_make_series(vals : Array[Double], name : String) -> Trigger_lateSeries {
  { vals, name }
}

pub fn trigger_late_series_len(s : Trigger_lateSeries) -> Int { s.vals.length() }

pub fn trigger_late_series_sum(s : Trigger_lateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn trigger_late_series_mean(s : Trigger_lateSeries) -> Double {
  let n = trigger_late_series_len(s)
  if n == 0 { 0.0 } else { trigger_late_series_sum(s) / n.to_double() }
}

pub fn trigger_late_series_min(s : Trigger_lateSeries) -> Double {
  let n = trigger_late_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn trigger_late_series_max(s : Trigger_lateSeries) -> Double {
  let n = trigger_late_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn trigger_late_series_var(s : Trigger_lateSeries) -> Double {
  let n = trigger_late_series_len(s)
  if n == 0 { 0.0 } else {
    let m = trigger_late_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn trigger_late_series_std(s : Trigger_lateSeries) -> Double { @_common.sqrt(trigger_late_series_var(s)) }

pub fn trigger_late_series_scale(s : Trigger_lateSeries, f : Double) -> Trigger_lateSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = trigger_late_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn trigger_late_series_add(a : Trigger_lateSeries, b : Trigger_lateSeries) -> Trigger_lateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = trigger_late_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn trigger_late_series_to_string(s : Trigger_lateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + trigger_late_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Trigger_lateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn trigger_late_make_matrix(rows : Int, cols : Int, val : Double) -> Trigger_lateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn trigger_late_matrix_identity(n : Int) -> Trigger_lateMatrix {
  let m = trigger_late_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn trigger_late_matrix_get(m : Trigger_lateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn trigger_late_matrix_transpose(m : Trigger_lateMatrix) -> Trigger_lateMatrix {
  let result = trigger_late_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn trigger_late_matrix_add(a : Trigger_lateMatrix, b : Trigger_lateMatrix) -> Trigger_lateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = trigger_late_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn trigger_late_matrix_scale(m : Trigger_lateMatrix, s : Double) -> Trigger_lateMatrix {
  let result = trigger_late_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn trigger_late_matrix_multiply(a : Trigger_lateMatrix, b : Trigger_lateMatrix) -> Trigger_lateMatrix {
  if a.cols != b.rows { return trigger_late_make_matrix(a.rows, b.cols, 0.0) }
  let result = trigger_late_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn trigger_late_matrix_trace(m : Trigger_lateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn trigger_late_matrix_norm(m : Trigger_lateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn trigger_late_matrix_to_string(m : Trigger_lateMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + trigger_late_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Trigger_lateVector {
  comps : Array[Double]
  dim : Int
}

pub fn trigger_late_make_vector(comps : Array[Double]) -> Trigger_lateVector {
  { comps, dim: comps.length() }
}

pub fn trigger_late_vector_zero(dim : Int) -> Trigger_lateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn trigger_late_vector_add(a : Trigger_lateVector, b : Trigger_lateVector) -> Trigger_lateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = trigger_late_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn trigger_late_vector_sub(a : Trigger_lateVector, b : Trigger_lateVector) -> Trigger_lateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = trigger_late_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn trigger_late_vector_scale(v : Trigger_lateVector, s : Double) -> Trigger_lateVector {
  let mut result = []
  for i in 0..<v.dim { result = trigger_late_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn trigger_late_vector_dot(a : Trigger_lateVector, b : Trigger_lateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn trigger_late_vector_norm(v : Trigger_lateVector) -> Double { @_common.sqrt(trigger_late_vector_dot(v, v)) }

pub fn trigger_late_vector_normalize(v : Trigger_lateVector) -> Trigger_lateVector {
  let n = trigger_late_vector_norm(v)
  if n < 0.0000001 { v } else { trigger_late_vector_scale(v, 1.0 / n) }
}

pub fn trigger_late_vector_dist(a : Trigger_lateVector, b : Trigger_lateVector) -> Double {
  trigger_late_vector_norm(trigger_late_vector_sub(a, b))
}

pub fn trigger_late_vector_to_string(v : Trigger_lateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + trigger_late_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn trigger_late_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn trigger_late_std(data : Array[Double]) -> Double { @_common.sqrt(trigger_late_var(data)) }

pub fn trigger_late_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn trigger_late_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = trigger_late_std(a); let sb = trigger_late_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { trigger_late_cov(a, b) / (sa * sb) }
}

pub fn trigger_late_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn trigger_late_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn trigger_late_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn trigger_late_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn trigger_late_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn trigger_late_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn trigger_late_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = trigger_late_precision(pred, labels, pos); let r = trigger_late_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn trigger_late_dbl(x : Double) -> String {
  let i = if x >= 0.0 { trigger_late_int(x) } else { -trigger_late_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { trigger_late_int(f * 1000000.0) } else { trigger_late_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn trigger_late_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn trigger_late_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
