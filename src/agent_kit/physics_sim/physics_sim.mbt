///===
/// agent_kit/physics_sim
/// S13.140 new

pub struct Physics_simPoint {
  x : Double
  y : Double
  label : Int
}

pub fn physics_sim_make_point(x : Double, y : Double) -> Physics_simPoint {
  { x, y, label: 0 }
}

pub fn physics_sim_make_labeled_point(x : Double, y : Double, label : Int) -> Physics_simPoint {
  { x, y, label }
}

pub fn physics_sim_point_x(p : Physics_simPoint) -> Double { p.x }

pub fn physics_sim_point_y(p : Physics_simPoint) -> Double { p.y }

pub fn physics_sim_point_label(p : Physics_simPoint) -> Int { p.label }

pub fn physics_sim_point_dist(a : Physics_simPoint, b : Physics_simPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn physics_sim_point_add(a : Physics_simPoint, b : Physics_simPoint) -> Physics_simPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn physics_sim_point_sub(a : Physics_simPoint, b : Physics_simPoint) -> Physics_simPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn physics_sim_point_scale(pt : Physics_simPoint, s : Double) -> Physics_simPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn physics_sim_point_dot(a : Physics_simPoint, b : Physics_simPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn physics_sim_point_norm(pt : Physics_simPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn physics_sim_point_to_string(pt : Physics_simPoint) -> String {
  "(" + physics_sim_dbl(pt.x) + ", " + physics_sim_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Physics_simSeries {
  vals : Array[Double]
  name : String
}

pub fn physics_sim_make_series(vals : Array[Double], name : String) -> Physics_simSeries {
  { vals, name }
}

pub fn physics_sim_series_len(s : Physics_simSeries) -> Int { s.vals.length() }

pub fn physics_sim_series_sum(s : Physics_simSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_sim_series_mean(s : Physics_simSeries) -> Double {
  let n = physics_sim_series_len(s)
  if n == 0 { 0.0 } else { physics_sim_series_sum(s) / n.to_double() }
}

pub fn physics_sim_series_min(s : Physics_simSeries) -> Double {
  let n = physics_sim_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_sim_series_max(s : Physics_simSeries) -> Double {
  let n = physics_sim_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_sim_series_var(s : Physics_simSeries) -> Double {
  let n = physics_sim_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_sim_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_sim_series_std(s : Physics_simSeries) -> Double { @_common.sqrt(physics_sim_series_var(s)) }

pub fn physics_sim_series_scale(s : Physics_simSeries, f : Double) -> Physics_simSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = physics_sim_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn physics_sim_series_add(a : Physics_simSeries, b : Physics_simSeries) -> Physics_simSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = physics_sim_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn physics_sim_series_to_string(s : Physics_simSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_sim_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Physics_simMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_sim_make_matrix(rows : Int, cols : Int, val : Double) -> Physics_simMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_sim_matrix_identity(n : Int) -> Physics_simMatrix {
  let m = physics_sim_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_sim_matrix_get(m : Physics_simMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_sim_matrix_transpose(m : Physics_simMatrix) -> Physics_simMatrix {
  let result = physics_sim_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_sim_matrix_add(a : Physics_simMatrix, b : Physics_simMatrix) -> Physics_simMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_sim_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_sim_matrix_scale(m : Physics_simMatrix, s : Double) -> Physics_simMatrix {
  let result = physics_sim_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_sim_matrix_multiply(a : Physics_simMatrix, b : Physics_simMatrix) -> Physics_simMatrix {
  if a.cols != b.rows { return physics_sim_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_sim_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_sim_matrix_trace(m : Physics_simMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_sim_matrix_norm(m : Physics_simMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_sim_matrix_to_string(m : Physics_simMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + physics_sim_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Physics_simVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_sim_make_vector(comps : Array[Double]) -> Physics_simVector {
  { comps, dim: comps.length() }
}

pub fn physics_sim_vector_zero(dim : Int) -> Physics_simVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_sim_vector_add(a : Physics_simVector, b : Physics_simVector) -> Physics_simVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_sim_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_sim_vector_sub(a : Physics_simVector, b : Physics_simVector) -> Physics_simVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = physics_sim_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_sim_vector_scale(v : Physics_simVector, s : Double) -> Physics_simVector {
  let mut result = []
  for i in 0..<v.dim { result = physics_sim_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_sim_vector_dot(a : Physics_simVector, b : Physics_simVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_sim_vector_norm(v : Physics_simVector) -> Double { @_common.sqrt(physics_sim_vector_dot(v, v)) }

pub fn physics_sim_vector_normalize(v : Physics_simVector) -> Physics_simVector {
  let n = physics_sim_vector_norm(v)
  if n < 0.0000001 { v } else { physics_sim_vector_scale(v, 1.0 / n) }
}

pub fn physics_sim_vector_dist(a : Physics_simVector, b : Physics_simVector) -> Double {
  physics_sim_vector_norm(physics_sim_vector_sub(a, b))
}

pub fn physics_sim_vector_to_string(v : Physics_simVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + physics_sim_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_sim_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_sim_std(data : Array[Double]) -> Double { @_common.sqrt(physics_sim_var(data)) }

pub fn physics_sim_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_sim_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_sim_std(a); let sb = physics_sim_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_sim_cov(a, b) / (sa * sb) }
}

pub fn physics_sim_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_sim_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_sim_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_sim_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_sim_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_sim_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_sim_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_sim_precision(pred, labels, pos); let r = physics_sim_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn physics_sim_dbl(x : Double) -> String {
  let i = if x >= 0.0 { physics_sim_int(x) } else { -physics_sim_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { physics_sim_int(f * 1000000.0) } else { physics_sim_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn physics_sim_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn physics_sim_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
