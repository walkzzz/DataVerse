///===
/// agent_kit/planning_causal
/// S13.166 new

pub struct Planning_causalPoint {
  x : Double
  y : Double
  label : Int
}

pub fn planning_causal_make_point(x : Double, y : Double) -> Planning_causalPoint {
  { x, y, label: 0 }
}

pub fn planning_causal_make_labeled_point(x : Double, y : Double, label : Int) -> Planning_causalPoint {
  { x, y, label }
}

pub fn planning_causal_point_x(p : Planning_causalPoint) -> Double { p.x }

pub fn planning_causal_point_y(p : Planning_causalPoint) -> Double { p.y }

pub fn planning_causal_point_label(p : Planning_causalPoint) -> Int { p.label }

pub fn planning_causal_point_dist(a : Planning_causalPoint, b : Planning_causalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  planning_causal_sqrt(dx * dx + dy * dy)
}

pub fn planning_causal_point_add(a : Planning_causalPoint, b : Planning_causalPoint) -> Planning_causalPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn planning_causal_point_sub(a : Planning_causalPoint, b : Planning_causalPoint) -> Planning_causalPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn planning_causal_point_scale(pt : Planning_causalPoint, s : Double) -> Planning_causalPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn planning_causal_point_dot(a : Planning_causalPoint, b : Planning_causalPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn planning_causal_point_norm(pt : Planning_causalPoint) -> Double {
  planning_causal_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn planning_causal_point_to_string(pt : Planning_causalPoint) -> String {
  "(" + planning_causal_dbl(pt.x) + ", " + planning_causal_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Planning_causalSeries {
  vals : Array[Double]
  name : String
}

pub fn planning_causal_make_series(vals : Array[Double], name : String) -> Planning_causalSeries {
  { vals, name }
}

pub fn planning_causal_series_len(s : Planning_causalSeries) -> Int { s.vals.length() }

pub fn planning_causal_series_sum(s : Planning_causalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn planning_causal_series_mean(s : Planning_causalSeries) -> Double {
  let n = planning_causal_series_len(s)
  if n == 0 { 0.0 } else { planning_causal_series_sum(s) / n.to_double() }
}

pub fn planning_causal_series_min(s : Planning_causalSeries) -> Double {
  let n = planning_causal_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn planning_causal_series_max(s : Planning_causalSeries) -> Double {
  let n = planning_causal_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn planning_causal_series_var(s : Planning_causalSeries) -> Double {
  let n = planning_causal_series_len(s)
  if n == 0 { 0.0 } else {
    let m = planning_causal_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn planning_causal_series_std(s : Planning_causalSeries) -> Double { planning_causal_sqrt(planning_causal_series_var(s)) }

pub fn planning_causal_series_scale(s : Planning_causalSeries, f : Double) -> Planning_causalSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = planning_causal_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn planning_causal_series_add(a : Planning_causalSeries, b : Planning_causalSeries) -> Planning_causalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = planning_causal_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn planning_causal_series_to_string(s : Planning_causalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + planning_causal_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Planning_causalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn planning_causal_make_matrix(rows : Int, cols : Int, val : Double) -> Planning_causalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn planning_causal_matrix_identity(n : Int) -> Planning_causalMatrix {
  let m = planning_causal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn planning_causal_matrix_get(m : Planning_causalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn planning_causal_matrix_transpose(m : Planning_causalMatrix) -> Planning_causalMatrix {
  let result = planning_causal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn planning_causal_matrix_add(a : Planning_causalMatrix, b : Planning_causalMatrix) -> Planning_causalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = planning_causal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn planning_causal_matrix_scale(m : Planning_causalMatrix, s : Double) -> Planning_causalMatrix {
  let result = planning_causal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn planning_causal_matrix_multiply(a : Planning_causalMatrix, b : Planning_causalMatrix) -> Planning_causalMatrix {
  if a.cols != b.rows { return planning_causal_make_matrix(a.rows, b.cols, 0.0) }
  let result = planning_causal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn planning_causal_matrix_trace(m : Planning_causalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn planning_causal_matrix_norm(m : Planning_causalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  planning_causal_sqrt(sum)
}

pub fn planning_causal_matrix_to_string(m : Planning_causalMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + planning_causal_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Planning_causalVector {
  comps : Array[Double]
  dim : Int
}

pub fn planning_causal_make_vector(comps : Array[Double]) -> Planning_causalVector {
  { comps, dim: comps.length() }
}

pub fn planning_causal_vector_zero(dim : Int) -> Planning_causalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn planning_causal_vector_add(a : Planning_causalVector, b : Planning_causalVector) -> Planning_causalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = planning_causal_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn planning_causal_vector_sub(a : Planning_causalVector, b : Planning_causalVector) -> Planning_causalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = planning_causal_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn planning_causal_vector_scale(v : Planning_causalVector, s : Double) -> Planning_causalVector {
  let mut result = []
  for i in 0..<v.dim { result = planning_causal_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn planning_causal_vector_dot(a : Planning_causalVector, b : Planning_causalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn planning_causal_vector_norm(v : Planning_causalVector) -> Double { planning_causal_sqrt(planning_causal_vector_dot(v, v)) }

pub fn planning_causal_vector_normalize(v : Planning_causalVector) -> Planning_causalVector {
  let n = planning_causal_vector_norm(v)
  if n < 0.0000001 { v } else { planning_causal_vector_scale(v, 1.0 / n) }
}

pub fn planning_causal_vector_dist(a : Planning_causalVector, b : Planning_causalVector) -> Double {
  planning_causal_vector_norm(planning_causal_vector_sub(a, b))
}

pub fn planning_causal_vector_to_string(v : Planning_causalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + planning_causal_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn planning_causal_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn planning_causal_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = planning_causal_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn planning_causal_std(data : Array[Double]) -> Double { planning_causal_sqrt(planning_causal_var(data)) }

pub fn planning_causal_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = planning_causal_mean(a); let mb = planning_causal_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn planning_causal_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = planning_causal_std(a); let sb = planning_causal_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { planning_causal_cov(a, b) / (sa * sb) }
}

pub fn planning_causal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn planning_causal_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn planning_causal_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + planning_causal_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn planning_causal_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = planning_causal_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn planning_causal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn planning_causal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn planning_causal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = planning_causal_precision(pred, labels, pos); let r = planning_causal_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn planning_causal_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn planning_causal_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn planning_causal_dbl(x : Double) -> String {
  let i = if x >= 0.0 { planning_causal_int(x) } else { -planning_causal_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { planning_causal_int(f * 1000000.0) } else { planning_causal_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn planning_causal_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn planning_causal_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
