///===
/// agent_kit/state_machine
/// S13.156 new

pub struct State_machinePoint {
  x : Double
  y : Double
  label : Int
}

pub fn state_machine_make_point(x : Double, y : Double) -> State_machinePoint {
  { x, y, label: 0 }
}

pub fn state_machine_make_labeled_point(x : Double, y : Double, label : Int) -> State_machinePoint {
  { x, y, label }
}

pub fn state_machine_point_x(p : State_machinePoint) -> Double { p.x }

pub fn state_machine_point_y(p : State_machinePoint) -> Double { p.y }

pub fn state_machine_point_label(p : State_machinePoint) -> Int { p.label }

pub fn state_machine_point_dist(a : State_machinePoint, b : State_machinePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn state_machine_point_add(a : State_machinePoint, b : State_machinePoint) -> State_machinePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn state_machine_point_sub(a : State_machinePoint, b : State_machinePoint) -> State_machinePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn state_machine_point_scale(pt : State_machinePoint, s : Double) -> State_machinePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn state_machine_point_dot(a : State_machinePoint, b : State_machinePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn state_machine_point_norm(pt : State_machinePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn state_machine_point_to_string(pt : State_machinePoint) -> String {
  "(" + state_machine_dbl(pt.x) + ", " + state_machine_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct State_machineSeries {
  vals : Array[Double]
  name : String
}

pub fn state_machine_make_series(vals : Array[Double], name : String) -> State_machineSeries {
  { vals, name }
}

pub fn state_machine_series_len(s : State_machineSeries) -> Int { s.vals.length() }

pub fn state_machine_series_sum(s : State_machineSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn state_machine_series_mean(s : State_machineSeries) -> Double {
  let n = state_machine_series_len(s)
  if n == 0 { 0.0 } else { state_machine_series_sum(s) / n.to_double() }
}

pub fn state_machine_series_min(s : State_machineSeries) -> Double {
  let n = state_machine_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn state_machine_series_max(s : State_machineSeries) -> Double {
  let n = state_machine_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn state_machine_series_var(s : State_machineSeries) -> Double {
  let n = state_machine_series_len(s)
  if n == 0 { 0.0 } else {
    let m = state_machine_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn state_machine_series_std(s : State_machineSeries) -> Double { @_common.sqrt(state_machine_series_var(s)) }

pub fn state_machine_series_scale(s : State_machineSeries, f : Double) -> State_machineSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = state_machine_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn state_machine_series_add(a : State_machineSeries, b : State_machineSeries) -> State_machineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = state_machine_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn state_machine_series_to_string(s : State_machineSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + state_machine_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct State_machineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn state_machine_make_matrix(rows : Int, cols : Int, val : Double) -> State_machineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn state_machine_matrix_identity(n : Int) -> State_machineMatrix {
  let m = state_machine_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn state_machine_matrix_get(m : State_machineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn state_machine_matrix_transpose(m : State_machineMatrix) -> State_machineMatrix {
  let result = state_machine_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn state_machine_matrix_add(a : State_machineMatrix, b : State_machineMatrix) -> State_machineMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = state_machine_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn state_machine_matrix_scale(m : State_machineMatrix, s : Double) -> State_machineMatrix {
  let result = state_machine_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn state_machine_matrix_multiply(a : State_machineMatrix, b : State_machineMatrix) -> State_machineMatrix {
  if a.cols != b.rows { return state_machine_make_matrix(a.rows, b.cols, 0.0) }
  let result = state_machine_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn state_machine_matrix_trace(m : State_machineMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn state_machine_matrix_norm(m : State_machineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn state_machine_matrix_to_string(m : State_machineMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + state_machine_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct State_machineVector {
  comps : Array[Double]
  dim : Int
}

pub fn state_machine_make_vector(comps : Array[Double]) -> State_machineVector {
  { comps, dim: comps.length() }
}

pub fn state_machine_vector_zero(dim : Int) -> State_machineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn state_machine_vector_add(a : State_machineVector, b : State_machineVector) -> State_machineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = state_machine_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn state_machine_vector_sub(a : State_machineVector, b : State_machineVector) -> State_machineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = state_machine_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn state_machine_vector_scale(v : State_machineVector, s : Double) -> State_machineVector {
  let mut result = []
  for i in 0..<v.dim { result = state_machine_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn state_machine_vector_dot(a : State_machineVector, b : State_machineVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn state_machine_vector_norm(v : State_machineVector) -> Double { @_common.sqrt(state_machine_vector_dot(v, v)) }

pub fn state_machine_vector_normalize(v : State_machineVector) -> State_machineVector {
  let n = state_machine_vector_norm(v)
  if n < 0.0000001 { v } else { state_machine_vector_scale(v, 1.0 / n) }
}

pub fn state_machine_vector_dist(a : State_machineVector, b : State_machineVector) -> Double {
  state_machine_vector_norm(state_machine_vector_sub(a, b))
}

pub fn state_machine_vector_to_string(v : State_machineVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + state_machine_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn state_machine_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn state_machine_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = state_machine_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn state_machine_std(data : Array[Double]) -> Double { @_common.sqrt(state_machine_var(data)) }

pub fn state_machine_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = state_machine_mean(a); let mb = state_machine_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn state_machine_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = state_machine_std(a); let sb = state_machine_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { state_machine_cov(a, b) / (sa * sb) }
}

pub fn state_machine_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn state_machine_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn state_machine_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn state_machine_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = state_machine_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn state_machine_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn state_machine_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn state_machine_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = state_machine_precision(pred, labels, pos); let r = state_machine_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn state_machine_dbl(x : Double) -> String {
  let i = if x >= 0.0 { state_machine_int(x) } else { -state_machine_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { state_machine_int(f * 1000000.0) } else { state_machine_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn state_machine_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn state_machine_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
