///===
/// agent_kit/belief_state
/// S13.120 new

pub struct Belief_statePoint {
  x : Double
  y : Double
  label : Int
}

pub fn belief_state_make_point(x : Double, y : Double) -> Belief_statePoint {
  { x, y, label: 0 }
}

pub fn belief_state_make_labeled_point(x : Double, y : Double, label : Int) -> Belief_statePoint {
  { x, y, label }
}

pub fn belief_state_point_x(p : Belief_statePoint) -> Double { p.x }

pub fn belief_state_point_y(p : Belief_statePoint) -> Double { p.y }

pub fn belief_state_point_label(p : Belief_statePoint) -> Int { p.label }

pub fn belief_state_point_dist(a : Belief_statePoint, b : Belief_statePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  belief_state_sqrt(dx * dx + dy * dy)
}

pub fn belief_state_point_add(a : Belief_statePoint, b : Belief_statePoint) -> Belief_statePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn belief_state_point_sub(a : Belief_statePoint, b : Belief_statePoint) -> Belief_statePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn belief_state_point_scale(pt : Belief_statePoint, s : Double) -> Belief_statePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn belief_state_point_dot(a : Belief_statePoint, b : Belief_statePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn belief_state_point_norm(pt : Belief_statePoint) -> Double {
  belief_state_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn belief_state_point_to_string(pt : Belief_statePoint) -> String {
  "(" + belief_state_dbl(pt.x) + ", " + belief_state_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Belief_stateSeries {
  vals : Array[Double]
  name : String
}

pub fn belief_state_make_series(vals : Array[Double], name : String) -> Belief_stateSeries {
  { vals, name }
}

pub fn belief_state_series_len(s : Belief_stateSeries) -> Int { s.vals.length() }

pub fn belief_state_series_sum(s : Belief_stateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn belief_state_series_mean(s : Belief_stateSeries) -> Double {
  let n = belief_state_series_len(s)
  if n == 0 { 0.0 } else { belief_state_series_sum(s) / n.to_double() }
}

pub fn belief_state_series_min(s : Belief_stateSeries) -> Double {
  let n = belief_state_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn belief_state_series_max(s : Belief_stateSeries) -> Double {
  let n = belief_state_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn belief_state_series_var(s : Belief_stateSeries) -> Double {
  let n = belief_state_series_len(s)
  if n == 0 { 0.0 } else {
    let m = belief_state_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn belief_state_series_std(s : Belief_stateSeries) -> Double { belief_state_sqrt(belief_state_series_var(s)) }

pub fn belief_state_series_scale(s : Belief_stateSeries, f : Double) -> Belief_stateSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = belief_state_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn belief_state_series_add(a : Belief_stateSeries, b : Belief_stateSeries) -> Belief_stateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = belief_state_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn belief_state_series_to_string(s : Belief_stateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + belief_state_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Belief_stateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn belief_state_make_matrix(rows : Int, cols : Int, val : Double) -> Belief_stateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn belief_state_matrix_identity(n : Int) -> Belief_stateMatrix {
  let m = belief_state_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn belief_state_matrix_get(m : Belief_stateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn belief_state_matrix_transpose(m : Belief_stateMatrix) -> Belief_stateMatrix {
  let result = belief_state_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn belief_state_matrix_add(a : Belief_stateMatrix, b : Belief_stateMatrix) -> Belief_stateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = belief_state_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn belief_state_matrix_scale(m : Belief_stateMatrix, s : Double) -> Belief_stateMatrix {
  let result = belief_state_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn belief_state_matrix_multiply(a : Belief_stateMatrix, b : Belief_stateMatrix) -> Belief_stateMatrix {
  if a.cols != b.rows { return belief_state_make_matrix(a.rows, b.cols, 0.0) }
  let result = belief_state_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn belief_state_matrix_trace(m : Belief_stateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn belief_state_matrix_norm(m : Belief_stateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  belief_state_sqrt(sum)
}

pub fn belief_state_matrix_to_string(m : Belief_stateMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + belief_state_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Belief_stateVector {
  comps : Array[Double]
  dim : Int
}

pub fn belief_state_make_vector(comps : Array[Double]) -> Belief_stateVector {
  { comps, dim: comps.length() }
}

pub fn belief_state_vector_zero(dim : Int) -> Belief_stateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn belief_state_vector_add(a : Belief_stateVector, b : Belief_stateVector) -> Belief_stateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = belief_state_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn belief_state_vector_sub(a : Belief_stateVector, b : Belief_stateVector) -> Belief_stateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = belief_state_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn belief_state_vector_scale(v : Belief_stateVector, s : Double) -> Belief_stateVector {
  let mut result = []
  for i in 0..<v.dim { result = belief_state_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn belief_state_vector_dot(a : Belief_stateVector, b : Belief_stateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn belief_state_vector_norm(v : Belief_stateVector) -> Double { belief_state_sqrt(belief_state_vector_dot(v, v)) }

pub fn belief_state_vector_normalize(v : Belief_stateVector) -> Belief_stateVector {
  let n = belief_state_vector_norm(v)
  if n < 0.0000001 { v } else { belief_state_vector_scale(v, 1.0 / n) }
}

pub fn belief_state_vector_dist(a : Belief_stateVector, b : Belief_stateVector) -> Double {
  belief_state_vector_norm(belief_state_vector_sub(a, b))
}

pub fn belief_state_vector_to_string(v : Belief_stateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + belief_state_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn belief_state_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn belief_state_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = belief_state_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn belief_state_std(data : Array[Double]) -> Double { belief_state_sqrt(belief_state_var(data)) }

pub fn belief_state_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = belief_state_mean(a); let mb = belief_state_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn belief_state_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = belief_state_std(a); let sb = belief_state_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { belief_state_cov(a, b) / (sa * sb) }
}

pub fn belief_state_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn belief_state_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn belief_state_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + belief_state_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn belief_state_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = belief_state_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn belief_state_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn belief_state_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn belief_state_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = belief_state_precision(pred, labels, pos); let r = belief_state_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn belief_state_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn belief_state_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn belief_state_dbl(x : Double) -> String {
  let i = if x >= 0.0 { belief_state_int(x) } else { -belief_state_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { belief_state_int(f * 1000000.0) } else { belief_state_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn belief_state_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn belief_state_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
