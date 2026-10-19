///===
/// agent_kit/intention_plan
/// S13.122 new

pub struct Intention_planPoint {
  x : Double
  y : Double
  label : Int
}

pub fn intention_plan_make_point(x : Double, y : Double) -> Intention_planPoint {
  { x, y, label: 0 }
}

pub fn intention_plan_make_labeled_point(x : Double, y : Double, label : Int) -> Intention_planPoint {
  { x, y, label }
}

pub fn intention_plan_point_x(p : Intention_planPoint) -> Double { p.x }

pub fn intention_plan_point_y(p : Intention_planPoint) -> Double { p.y }

pub fn intention_plan_point_label(p : Intention_planPoint) -> Int { p.label }

pub fn intention_plan_point_dist(a : Intention_planPoint, b : Intention_planPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  intention_plan_sqrt(dx * dx + dy * dy)
}

pub fn intention_plan_point_add(a : Intention_planPoint, b : Intention_planPoint) -> Intention_planPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn intention_plan_point_sub(a : Intention_planPoint, b : Intention_planPoint) -> Intention_planPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn intention_plan_point_scale(pt : Intention_planPoint, s : Double) -> Intention_planPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn intention_plan_point_dot(a : Intention_planPoint, b : Intention_planPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn intention_plan_point_norm(pt : Intention_planPoint) -> Double {
  intention_plan_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn intention_plan_point_to_string(pt : Intention_planPoint) -> String {
  "(" + intention_plan_dbl(pt.x) + ", " + intention_plan_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Intention_planSeries {
  vals : Array[Double]
  name : String
}

pub fn intention_plan_make_series(vals : Array[Double], name : String) -> Intention_planSeries {
  { vals, name }
}

pub fn intention_plan_series_len(s : Intention_planSeries) -> Int { s.vals.length() }

pub fn intention_plan_series_sum(s : Intention_planSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn intention_plan_series_mean(s : Intention_planSeries) -> Double {
  let n = intention_plan_series_len(s)
  if n == 0 { 0.0 } else { intention_plan_series_sum(s) / n.to_double() }
}

pub fn intention_plan_series_min(s : Intention_planSeries) -> Double {
  let n = intention_plan_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn intention_plan_series_max(s : Intention_planSeries) -> Double {
  let n = intention_plan_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn intention_plan_series_var(s : Intention_planSeries) -> Double {
  let n = intention_plan_series_len(s)
  if n == 0 { 0.0 } else {
    let m = intention_plan_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn intention_plan_series_std(s : Intention_planSeries) -> Double { intention_plan_sqrt(intention_plan_series_var(s)) }

pub fn intention_plan_series_scale(s : Intention_planSeries, f : Double) -> Intention_planSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = intention_plan_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn intention_plan_series_add(a : Intention_planSeries, b : Intention_planSeries) -> Intention_planSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = intention_plan_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn intention_plan_series_to_string(s : Intention_planSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + intention_plan_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Intention_planMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn intention_plan_make_matrix(rows : Int, cols : Int, val : Double) -> Intention_planMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn intention_plan_matrix_identity(n : Int) -> Intention_planMatrix {
  let m = intention_plan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn intention_plan_matrix_get(m : Intention_planMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn intention_plan_matrix_transpose(m : Intention_planMatrix) -> Intention_planMatrix {
  let result = intention_plan_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn intention_plan_matrix_add(a : Intention_planMatrix, b : Intention_planMatrix) -> Intention_planMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = intention_plan_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn intention_plan_matrix_scale(m : Intention_planMatrix, s : Double) -> Intention_planMatrix {
  let result = intention_plan_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn intention_plan_matrix_multiply(a : Intention_planMatrix, b : Intention_planMatrix) -> Intention_planMatrix {
  if a.cols != b.rows { return intention_plan_make_matrix(a.rows, b.cols, 0.0) }
  let result = intention_plan_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn intention_plan_matrix_trace(m : Intention_planMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn intention_plan_matrix_norm(m : Intention_planMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  intention_plan_sqrt(sum)
}

pub fn intention_plan_matrix_to_string(m : Intention_planMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + intention_plan_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Intention_planVector {
  comps : Array[Double]
  dim : Int
}

pub fn intention_plan_make_vector(comps : Array[Double]) -> Intention_planVector {
  { comps, dim: comps.length() }
}

pub fn intention_plan_vector_zero(dim : Int) -> Intention_planVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn intention_plan_vector_add(a : Intention_planVector, b : Intention_planVector) -> Intention_planVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = intention_plan_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn intention_plan_vector_sub(a : Intention_planVector, b : Intention_planVector) -> Intention_planVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = intention_plan_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn intention_plan_vector_scale(v : Intention_planVector, s : Double) -> Intention_planVector {
  let mut result = []
  for i in 0..<v.dim { result = intention_plan_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn intention_plan_vector_dot(a : Intention_planVector, b : Intention_planVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn intention_plan_vector_norm(v : Intention_planVector) -> Double { intention_plan_sqrt(intention_plan_vector_dot(v, v)) }

pub fn intention_plan_vector_normalize(v : Intention_planVector) -> Intention_planVector {
  let n = intention_plan_vector_norm(v)
  if n < 0.0000001 { v } else { intention_plan_vector_scale(v, 1.0 / n) }
}

pub fn intention_plan_vector_dist(a : Intention_planVector, b : Intention_planVector) -> Double {
  intention_plan_vector_norm(intention_plan_vector_sub(a, b))
}

pub fn intention_plan_vector_to_string(v : Intention_planVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + intention_plan_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn intention_plan_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn intention_plan_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = intention_plan_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn intention_plan_std(data : Array[Double]) -> Double { intention_plan_sqrt(intention_plan_var(data)) }

pub fn intention_plan_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = intention_plan_mean(a); let mb = intention_plan_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn intention_plan_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = intention_plan_std(a); let sb = intention_plan_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { intention_plan_cov(a, b) / (sa * sb) }
}

pub fn intention_plan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn intention_plan_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn intention_plan_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + intention_plan_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn intention_plan_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = intention_plan_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn intention_plan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn intention_plan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn intention_plan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = intention_plan_precision(pred, labels, pos); let r = intention_plan_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn intention_plan_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn intention_plan_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn intention_plan_dbl(x : Double) -> String {
  let i = if x >= 0.0 { intention_plan_int(x) } else { -intention_plan_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { intention_plan_int(f * 1000000.0) } else { intention_plan_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn intention_plan_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn intention_plan_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
