///===
/// datatemporal/circuit_break
/// S13.226 new

pub struct Circuit_breakPoint {
  x : Double
  y : Double
  label : Int
}

pub fn circuit_break_make_point(x : Double, y : Double) -> Circuit_breakPoint {
  { x, y, label: 0 }
}

pub fn circuit_break_make_labeled_point(x : Double, y : Double, label : Int) -> Circuit_breakPoint {
  { x, y, label }
}

pub fn circuit_break_point_x(p : Circuit_breakPoint) -> Double { p.x }

pub fn circuit_break_point_y(p : Circuit_breakPoint) -> Double { p.y }

pub fn circuit_break_point_label(p : Circuit_breakPoint) -> Int { p.label }

pub fn circuit_break_point_dist(a : Circuit_breakPoint, b : Circuit_breakPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  circuit_break_sqrt(dx * dx + dy * dy)
}

pub fn circuit_break_point_add(a : Circuit_breakPoint, b : Circuit_breakPoint) -> Circuit_breakPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn circuit_break_point_sub(a : Circuit_breakPoint, b : Circuit_breakPoint) -> Circuit_breakPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn circuit_break_point_scale(pt : Circuit_breakPoint, s : Double) -> Circuit_breakPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn circuit_break_point_dot(a : Circuit_breakPoint, b : Circuit_breakPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn circuit_break_point_norm(pt : Circuit_breakPoint) -> Double {
  circuit_break_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn circuit_break_point_to_string(pt : Circuit_breakPoint) -> String {
  "(" + circuit_break_dbl(pt.x) + ", " + circuit_break_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Circuit_breakSeries {
  vals : Array[Double]
  name : String
}

pub fn circuit_break_make_series(vals : Array[Double], name : String) -> Circuit_breakSeries {
  { vals, name }
}

pub fn circuit_break_series_len(s : Circuit_breakSeries) -> Int { s.vals.length() }

pub fn circuit_break_series_sum(s : Circuit_breakSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn circuit_break_series_mean(s : Circuit_breakSeries) -> Double {
  let n = circuit_break_series_len(s)
  if n == 0 { 0.0 } else { circuit_break_series_sum(s) / n.to_double() }
}

pub fn circuit_break_series_min(s : Circuit_breakSeries) -> Double {
  let n = circuit_break_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn circuit_break_series_max(s : Circuit_breakSeries) -> Double {
  let n = circuit_break_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn circuit_break_series_var(s : Circuit_breakSeries) -> Double {
  let n = circuit_break_series_len(s)
  if n == 0 { 0.0 } else {
    let m = circuit_break_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn circuit_break_series_std(s : Circuit_breakSeries) -> Double { circuit_break_sqrt(circuit_break_series_var(s)) }

pub fn circuit_break_series_scale(s : Circuit_breakSeries, f : Double) -> Circuit_breakSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = circuit_break_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn circuit_break_series_add(a : Circuit_breakSeries, b : Circuit_breakSeries) -> Circuit_breakSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = circuit_break_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn circuit_break_series_to_string(s : Circuit_breakSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + circuit_break_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Circuit_breakMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn circuit_break_make_matrix(rows : Int, cols : Int, val : Double) -> Circuit_breakMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn circuit_break_matrix_identity(n : Int) -> Circuit_breakMatrix {
  let m = circuit_break_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn circuit_break_matrix_get(m : Circuit_breakMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn circuit_break_matrix_transpose(m : Circuit_breakMatrix) -> Circuit_breakMatrix {
  let result = circuit_break_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn circuit_break_matrix_add(a : Circuit_breakMatrix, b : Circuit_breakMatrix) -> Circuit_breakMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = circuit_break_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn circuit_break_matrix_scale(m : Circuit_breakMatrix, s : Double) -> Circuit_breakMatrix {
  let result = circuit_break_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn circuit_break_matrix_multiply(a : Circuit_breakMatrix, b : Circuit_breakMatrix) -> Circuit_breakMatrix {
  if a.cols != b.rows { return circuit_break_make_matrix(a.rows, b.cols, 0.0) }
  let result = circuit_break_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn circuit_break_matrix_trace(m : Circuit_breakMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn circuit_break_matrix_norm(m : Circuit_breakMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  circuit_break_sqrt(sum)
}

pub fn circuit_break_matrix_to_string(m : Circuit_breakMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + circuit_break_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Circuit_breakVector {
  comps : Array[Double]
  dim : Int
}

pub fn circuit_break_make_vector(comps : Array[Double]) -> Circuit_breakVector {
  { comps, dim: comps.length() }
}

pub fn circuit_break_vector_zero(dim : Int) -> Circuit_breakVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn circuit_break_vector_add(a : Circuit_breakVector, b : Circuit_breakVector) -> Circuit_breakVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = circuit_break_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn circuit_break_vector_sub(a : Circuit_breakVector, b : Circuit_breakVector) -> Circuit_breakVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = circuit_break_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn circuit_break_vector_scale(v : Circuit_breakVector, s : Double) -> Circuit_breakVector {
  let mut result = []
  for i in 0..<v.dim { result = circuit_break_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn circuit_break_vector_dot(a : Circuit_breakVector, b : Circuit_breakVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn circuit_break_vector_norm(v : Circuit_breakVector) -> Double { circuit_break_sqrt(circuit_break_vector_dot(v, v)) }

pub fn circuit_break_vector_normalize(v : Circuit_breakVector) -> Circuit_breakVector {
  let n = circuit_break_vector_norm(v)
  if n < 0.0000001 { v } else { circuit_break_vector_scale(v, 1.0 / n) }
}

pub fn circuit_break_vector_dist(a : Circuit_breakVector, b : Circuit_breakVector) -> Double {
  circuit_break_vector_norm(circuit_break_vector_sub(a, b))
}

pub fn circuit_break_vector_to_string(v : Circuit_breakVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + circuit_break_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn circuit_break_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn circuit_break_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = circuit_break_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn circuit_break_std(data : Array[Double]) -> Double { circuit_break_sqrt(circuit_break_var(data)) }

pub fn circuit_break_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = circuit_break_mean(a); let mb = circuit_break_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn circuit_break_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = circuit_break_std(a); let sb = circuit_break_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { circuit_break_cov(a, b) / (sa * sb) }
}

pub fn circuit_break_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn circuit_break_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn circuit_break_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + circuit_break_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn circuit_break_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = circuit_break_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn circuit_break_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn circuit_break_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn circuit_break_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = circuit_break_precision(pred, labels, pos); let r = circuit_break_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn circuit_break_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn circuit_break_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn circuit_break_dbl(x : Double) -> String {
  let i = if x >= 0.0 { circuit_break_int(x) } else { -circuit_break_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { circuit_break_int(f * 1000000.0) } else { circuit_break_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn circuit_break_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn circuit_break_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
