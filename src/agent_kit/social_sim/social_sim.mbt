///===
/// agent_kit/social_sim
/// S13.133 new

pub struct Social_simPoint {
  x : Double
  y : Double
  label : Int
}

pub fn social_sim_make_point(x : Double, y : Double) -> Social_simPoint {
  { x, y, label: 0 }
}

pub fn social_sim_make_labeled_point(x : Double, y : Double, label : Int) -> Social_simPoint {
  { x, y, label }
}

pub fn social_sim_point_x(p : Social_simPoint) -> Double { p.x }

pub fn social_sim_point_y(p : Social_simPoint) -> Double { p.y }

pub fn social_sim_point_label(p : Social_simPoint) -> Int { p.label }

pub fn social_sim_point_dist(a : Social_simPoint, b : Social_simPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn social_sim_point_add(a : Social_simPoint, b : Social_simPoint) -> Social_simPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn social_sim_point_sub(a : Social_simPoint, b : Social_simPoint) -> Social_simPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn social_sim_point_scale(pt : Social_simPoint, s : Double) -> Social_simPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn social_sim_point_dot(a : Social_simPoint, b : Social_simPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn social_sim_point_norm(pt : Social_simPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn social_sim_point_to_string(pt : Social_simPoint) -> String {
  "(" + social_sim_dbl(pt.x) + ", " + social_sim_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Social_simSeries {
  vals : Array[Double]
  name : String
}

pub fn social_sim_make_series(vals : Array[Double], name : String) -> Social_simSeries {
  { vals, name }
}

pub fn social_sim_series_len(s : Social_simSeries) -> Int { s.vals.length() }

pub fn social_sim_series_sum(s : Social_simSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn social_sim_series_mean(s : Social_simSeries) -> Double {
  let n = social_sim_series_len(s)
  if n == 0 { 0.0 } else { social_sim_series_sum(s) / n.to_double() }
}

pub fn social_sim_series_min(s : Social_simSeries) -> Double {
  let n = social_sim_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn social_sim_series_max(s : Social_simSeries) -> Double {
  let n = social_sim_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn social_sim_series_var(s : Social_simSeries) -> Double {
  let n = social_sim_series_len(s)
  if n == 0 { 0.0 } else {
    let m = social_sim_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn social_sim_series_std(s : Social_simSeries) -> Double { @_common.sqrt(social_sim_series_var(s)) }

pub fn social_sim_series_scale(s : Social_simSeries, f : Double) -> Social_simSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = social_sim_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn social_sim_series_add(a : Social_simSeries, b : Social_simSeries) -> Social_simSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = social_sim_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn social_sim_series_to_string(s : Social_simSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + social_sim_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Social_simMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn social_sim_make_matrix(rows : Int, cols : Int, val : Double) -> Social_simMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn social_sim_matrix_identity(n : Int) -> Social_simMatrix {
  let m = social_sim_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn social_sim_matrix_get(m : Social_simMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn social_sim_matrix_transpose(m : Social_simMatrix) -> Social_simMatrix {
  let result = social_sim_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn social_sim_matrix_add(a : Social_simMatrix, b : Social_simMatrix) -> Social_simMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = social_sim_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn social_sim_matrix_scale(m : Social_simMatrix, s : Double) -> Social_simMatrix {
  let result = social_sim_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn social_sim_matrix_multiply(a : Social_simMatrix, b : Social_simMatrix) -> Social_simMatrix {
  if a.cols != b.rows { return social_sim_make_matrix(a.rows, b.cols, 0.0) }
  let result = social_sim_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn social_sim_matrix_trace(m : Social_simMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn social_sim_matrix_norm(m : Social_simMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn social_sim_matrix_to_string(m : Social_simMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + social_sim_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Social_simVector {
  comps : Array[Double]
  dim : Int
}

pub fn social_sim_make_vector(comps : Array[Double]) -> Social_simVector {
  { comps, dim: comps.length() }
}

pub fn social_sim_vector_zero(dim : Int) -> Social_simVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn social_sim_vector_add(a : Social_simVector, b : Social_simVector) -> Social_simVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = social_sim_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn social_sim_vector_sub(a : Social_simVector, b : Social_simVector) -> Social_simVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = social_sim_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn social_sim_vector_scale(v : Social_simVector, s : Double) -> Social_simVector {
  let mut result = []
  for i in 0..<v.dim { result = social_sim_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn social_sim_vector_dot(a : Social_simVector, b : Social_simVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn social_sim_vector_norm(v : Social_simVector) -> Double { @_common.sqrt(social_sim_vector_dot(v, v)) }

pub fn social_sim_vector_normalize(v : Social_simVector) -> Social_simVector {
  let n = social_sim_vector_norm(v)
  if n < 0.0000001 { v } else { social_sim_vector_scale(v, 1.0 / n) }
}

pub fn social_sim_vector_dist(a : Social_simVector, b : Social_simVector) -> Double {
  social_sim_vector_norm(social_sim_vector_sub(a, b))
}

pub fn social_sim_vector_to_string(v : Social_simVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + social_sim_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn social_sim_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn social_sim_std(data : Array[Double]) -> Double { @_common.sqrt(social_sim_var(data)) }

pub fn social_sim_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn social_sim_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = social_sim_std(a); let sb = social_sim_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { social_sim_cov(a, b) / (sa * sb) }
}

pub fn social_sim_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn social_sim_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn social_sim_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn social_sim_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn social_sim_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn social_sim_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn social_sim_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = social_sim_precision(pred, labels, pos); let r = social_sim_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn social_sim_dbl(x : Double) -> String {
  let i = if x >= 0.0 { social_sim_int(x) } else { -social_sim_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { social_sim_int(f * 1000000.0) } else { social_sim_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn social_sim_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn social_sim_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
