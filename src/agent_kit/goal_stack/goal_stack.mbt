///===
/// agent_kit/goal_stack
/// S13.119 new

pub struct Goal_stackPoint {
  x : Double
  y : Double
  label : Int
}

pub fn goal_stack_make_point(x : Double, y : Double) -> Goal_stackPoint {
  { x, y, label: 0 }
}

pub fn goal_stack_make_labeled_point(x : Double, y : Double, label : Int) -> Goal_stackPoint {
  { x, y, label }
}

pub fn goal_stack_point_x(p : Goal_stackPoint) -> Double { p.x }

pub fn goal_stack_point_y(p : Goal_stackPoint) -> Double { p.y }

pub fn goal_stack_point_label(p : Goal_stackPoint) -> Int { p.label }

pub fn goal_stack_point_dist(a : Goal_stackPoint, b : Goal_stackPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn goal_stack_point_add(a : Goal_stackPoint, b : Goal_stackPoint) -> Goal_stackPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn goal_stack_point_sub(a : Goal_stackPoint, b : Goal_stackPoint) -> Goal_stackPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn goal_stack_point_scale(pt : Goal_stackPoint, s : Double) -> Goal_stackPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn goal_stack_point_dot(a : Goal_stackPoint, b : Goal_stackPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn goal_stack_point_norm(pt : Goal_stackPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn goal_stack_point_to_string(pt : Goal_stackPoint) -> String {
  "(" + goal_stack_dbl(pt.x) + ", " + goal_stack_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Goal_stackSeries {
  vals : Array[Double]
  name : String
}

pub fn goal_stack_make_series(vals : Array[Double], name : String) -> Goal_stackSeries {
  { vals, name }
}

pub fn goal_stack_series_len(s : Goal_stackSeries) -> Int { s.vals.length() }

pub fn goal_stack_series_sum(s : Goal_stackSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn goal_stack_series_mean(s : Goal_stackSeries) -> Double {
  let n = goal_stack_series_len(s)
  if n == 0 { 0.0 } else { goal_stack_series_sum(s) / n.to_double() }
}

pub fn goal_stack_series_min(s : Goal_stackSeries) -> Double {
  let n = goal_stack_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn goal_stack_series_max(s : Goal_stackSeries) -> Double {
  let n = goal_stack_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn goal_stack_series_var(s : Goal_stackSeries) -> Double {
  let n = goal_stack_series_len(s)
  if n == 0 { 0.0 } else {
    let m = goal_stack_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn goal_stack_series_std(s : Goal_stackSeries) -> Double { @_common.sqrt(goal_stack_series_var(s)) }

pub fn goal_stack_series_scale(s : Goal_stackSeries, f : Double) -> Goal_stackSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = goal_stack_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn goal_stack_series_add(a : Goal_stackSeries, b : Goal_stackSeries) -> Goal_stackSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = goal_stack_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn goal_stack_series_to_string(s : Goal_stackSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + goal_stack_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Goal_stackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn goal_stack_make_matrix(rows : Int, cols : Int, val : Double) -> Goal_stackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn goal_stack_matrix_identity(n : Int) -> Goal_stackMatrix {
  let m = goal_stack_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn goal_stack_matrix_get(m : Goal_stackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn goal_stack_matrix_transpose(m : Goal_stackMatrix) -> Goal_stackMatrix {
  let result = goal_stack_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn goal_stack_matrix_add(a : Goal_stackMatrix, b : Goal_stackMatrix) -> Goal_stackMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = goal_stack_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn goal_stack_matrix_scale(m : Goal_stackMatrix, s : Double) -> Goal_stackMatrix {
  let result = goal_stack_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn goal_stack_matrix_multiply(a : Goal_stackMatrix, b : Goal_stackMatrix) -> Goal_stackMatrix {
  if a.cols != b.rows { return goal_stack_make_matrix(a.rows, b.cols, 0.0) }
  let result = goal_stack_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn goal_stack_matrix_trace(m : Goal_stackMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn goal_stack_matrix_norm(m : Goal_stackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn goal_stack_matrix_to_string(m : Goal_stackMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + goal_stack_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Goal_stackVector {
  comps : Array[Double]
  dim : Int
}

pub fn goal_stack_make_vector(comps : Array[Double]) -> Goal_stackVector {
  { comps, dim: comps.length() }
}

pub fn goal_stack_vector_zero(dim : Int) -> Goal_stackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn goal_stack_vector_add(a : Goal_stackVector, b : Goal_stackVector) -> Goal_stackVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = goal_stack_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn goal_stack_vector_sub(a : Goal_stackVector, b : Goal_stackVector) -> Goal_stackVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = goal_stack_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn goal_stack_vector_scale(v : Goal_stackVector, s : Double) -> Goal_stackVector {
  let mut result = []
  for i in 0..<v.dim { result = goal_stack_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn goal_stack_vector_dot(a : Goal_stackVector, b : Goal_stackVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn goal_stack_vector_norm(v : Goal_stackVector) -> Double { @_common.sqrt(goal_stack_vector_dot(v, v)) }

pub fn goal_stack_vector_normalize(v : Goal_stackVector) -> Goal_stackVector {
  let n = goal_stack_vector_norm(v)
  if n < 0.0000001 { v } else { goal_stack_vector_scale(v, 1.0 / n) }
}

pub fn goal_stack_vector_dist(a : Goal_stackVector, b : Goal_stackVector) -> Double {
  goal_stack_vector_norm(goal_stack_vector_sub(a, b))
}

pub fn goal_stack_vector_to_string(v : Goal_stackVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + goal_stack_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn goal_stack_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn goal_stack_std(data : Array[Double]) -> Double { @_common.sqrt(goal_stack_var(data)) }

pub fn goal_stack_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn goal_stack_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = goal_stack_std(a); let sb = goal_stack_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { goal_stack_cov(a, b) / (sa * sb) }
}

pub fn goal_stack_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn goal_stack_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn goal_stack_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn goal_stack_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn goal_stack_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn goal_stack_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn goal_stack_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = goal_stack_precision(pred, labels, pos); let r = goal_stack_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn goal_stack_dbl(x : Double) -> String {
  let i = if x >= 0.0 { goal_stack_int(x) } else { -goal_stack_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { goal_stack_int(f * 1000000.0) } else { goal_stack_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn goal_stack_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn goal_stack_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
