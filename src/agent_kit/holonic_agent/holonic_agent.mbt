///===
/// agent_kit/holonic_agent
/// S13.128 new

pub struct Holonic_agentPoint {
  x : Double
  y : Double
  label : Int
}

pub fn holonic_agent_make_point(x : Double, y : Double) -> Holonic_agentPoint {
  { x, y, label: 0 }
}

pub fn holonic_agent_make_labeled_point(x : Double, y : Double, label : Int) -> Holonic_agentPoint {
  { x, y, label }
}

pub fn holonic_agent_point_x(p : Holonic_agentPoint) -> Double { p.x }

pub fn holonic_agent_point_y(p : Holonic_agentPoint) -> Double { p.y }

pub fn holonic_agent_point_label(p : Holonic_agentPoint) -> Int { p.label }

pub fn holonic_agent_point_dist(a : Holonic_agentPoint, b : Holonic_agentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn holonic_agent_point_add(a : Holonic_agentPoint, b : Holonic_agentPoint) -> Holonic_agentPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn holonic_agent_point_sub(a : Holonic_agentPoint, b : Holonic_agentPoint) -> Holonic_agentPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn holonic_agent_point_scale(pt : Holonic_agentPoint, s : Double) -> Holonic_agentPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn holonic_agent_point_dot(a : Holonic_agentPoint, b : Holonic_agentPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn holonic_agent_point_norm(pt : Holonic_agentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn holonic_agent_point_to_string(pt : Holonic_agentPoint) -> String {
  "(" + holonic_agent_dbl(pt.x) + ", " + holonic_agent_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Holonic_agentSeries {
  vals : Array[Double]
  name : String
}

pub fn holonic_agent_make_series(vals : Array[Double], name : String) -> Holonic_agentSeries {
  { vals, name }
}

pub fn holonic_agent_series_len(s : Holonic_agentSeries) -> Int { s.vals.length() }

pub fn holonic_agent_series_sum(s : Holonic_agentSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn holonic_agent_series_mean(s : Holonic_agentSeries) -> Double {
  let n = holonic_agent_series_len(s)
  if n == 0 { 0.0 } else { holonic_agent_series_sum(s) / n.to_double() }
}

pub fn holonic_agent_series_min(s : Holonic_agentSeries) -> Double {
  let n = holonic_agent_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn holonic_agent_series_max(s : Holonic_agentSeries) -> Double {
  let n = holonic_agent_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn holonic_agent_series_var(s : Holonic_agentSeries) -> Double {
  let n = holonic_agent_series_len(s)
  if n == 0 { 0.0 } else {
    let m = holonic_agent_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn holonic_agent_series_std(s : Holonic_agentSeries) -> Double { @_common.sqrt(holonic_agent_series_var(s)) }

pub fn holonic_agent_series_scale(s : Holonic_agentSeries, f : Double) -> Holonic_agentSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = holonic_agent_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn holonic_agent_series_add(a : Holonic_agentSeries, b : Holonic_agentSeries) -> Holonic_agentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = holonic_agent_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn holonic_agent_series_to_string(s : Holonic_agentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + holonic_agent_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Holonic_agentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn holonic_agent_make_matrix(rows : Int, cols : Int, val : Double) -> Holonic_agentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn holonic_agent_matrix_identity(n : Int) -> Holonic_agentMatrix {
  let m = holonic_agent_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn holonic_agent_matrix_get(m : Holonic_agentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn holonic_agent_matrix_transpose(m : Holonic_agentMatrix) -> Holonic_agentMatrix {
  let result = holonic_agent_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn holonic_agent_matrix_add(a : Holonic_agentMatrix, b : Holonic_agentMatrix) -> Holonic_agentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = holonic_agent_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn holonic_agent_matrix_scale(m : Holonic_agentMatrix, s : Double) -> Holonic_agentMatrix {
  let result = holonic_agent_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn holonic_agent_matrix_multiply(a : Holonic_agentMatrix, b : Holonic_agentMatrix) -> Holonic_agentMatrix {
  if a.cols != b.rows { return holonic_agent_make_matrix(a.rows, b.cols, 0.0) }
  let result = holonic_agent_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn holonic_agent_matrix_trace(m : Holonic_agentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn holonic_agent_matrix_norm(m : Holonic_agentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn holonic_agent_matrix_to_string(m : Holonic_agentMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + holonic_agent_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Holonic_agentVector {
  comps : Array[Double]
  dim : Int
}

pub fn holonic_agent_make_vector(comps : Array[Double]) -> Holonic_agentVector {
  { comps, dim: comps.length() }
}

pub fn holonic_agent_vector_zero(dim : Int) -> Holonic_agentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn holonic_agent_vector_add(a : Holonic_agentVector, b : Holonic_agentVector) -> Holonic_agentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = holonic_agent_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn holonic_agent_vector_sub(a : Holonic_agentVector, b : Holonic_agentVector) -> Holonic_agentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = holonic_agent_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn holonic_agent_vector_scale(v : Holonic_agentVector, s : Double) -> Holonic_agentVector {
  let mut result = []
  for i in 0..<v.dim { result = holonic_agent_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn holonic_agent_vector_dot(a : Holonic_agentVector, b : Holonic_agentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn holonic_agent_vector_norm(v : Holonic_agentVector) -> Double { @_common.sqrt(holonic_agent_vector_dot(v, v)) }

pub fn holonic_agent_vector_normalize(v : Holonic_agentVector) -> Holonic_agentVector {
  let n = holonic_agent_vector_norm(v)
  if n < 0.0000001 { v } else { holonic_agent_vector_scale(v, 1.0 / n) }
}

pub fn holonic_agent_vector_dist(a : Holonic_agentVector, b : Holonic_agentVector) -> Double {
  holonic_agent_vector_norm(holonic_agent_vector_sub(a, b))
}

pub fn holonic_agent_vector_to_string(v : Holonic_agentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + holonic_agent_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn holonic_agent_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn holonic_agent_std(data : Array[Double]) -> Double { @_common.sqrt(holonic_agent_var(data)) }

pub fn holonic_agent_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn holonic_agent_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = holonic_agent_std(a); let sb = holonic_agent_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { holonic_agent_cov(a, b) / (sa * sb) }
}

pub fn holonic_agent_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn holonic_agent_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn holonic_agent_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn holonic_agent_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn holonic_agent_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn holonic_agent_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn holonic_agent_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = holonic_agent_precision(pred, labels, pos); let r = holonic_agent_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn holonic_agent_dbl(x : Double) -> String {
  let i = if x >= 0.0 { holonic_agent_int(x) } else { -holonic_agent_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { holonic_agent_int(f * 1000000.0) } else { holonic_agent_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn holonic_agent_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn holonic_agent_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
