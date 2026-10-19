///===
/// agent_kit/theorem_prove
/// S13.160 new

pub struct Theorem_provePoint {
  x : Double
  y : Double
  label : Int
}

pub fn theorem_prove_make_point(x : Double, y : Double) -> Theorem_provePoint {
  { x, y, label: 0 }
}

pub fn theorem_prove_make_labeled_point(x : Double, y : Double, label : Int) -> Theorem_provePoint {
  { x, y, label }
}

pub fn theorem_prove_point_x(p : Theorem_provePoint) -> Double { p.x }

pub fn theorem_prove_point_y(p : Theorem_provePoint) -> Double { p.y }

pub fn theorem_prove_point_label(p : Theorem_provePoint) -> Int { p.label }

pub fn theorem_prove_point_dist(a : Theorem_provePoint, b : Theorem_provePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  theorem_prove_sqrt(dx * dx + dy * dy)
}

pub fn theorem_prove_point_add(a : Theorem_provePoint, b : Theorem_provePoint) -> Theorem_provePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn theorem_prove_point_sub(a : Theorem_provePoint, b : Theorem_provePoint) -> Theorem_provePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn theorem_prove_point_scale(pt : Theorem_provePoint, s : Double) -> Theorem_provePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn theorem_prove_point_dot(a : Theorem_provePoint, b : Theorem_provePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn theorem_prove_point_norm(pt : Theorem_provePoint) -> Double {
  theorem_prove_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn theorem_prove_point_to_string(pt : Theorem_provePoint) -> String {
  "(" + theorem_prove_dbl(pt.x) + ", " + theorem_prove_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Theorem_proveSeries {
  vals : Array[Double]
  name : String
}

pub fn theorem_prove_make_series(vals : Array[Double], name : String) -> Theorem_proveSeries {
  { vals, name }
}

pub fn theorem_prove_series_len(s : Theorem_proveSeries) -> Int { s.vals.length() }

pub fn theorem_prove_series_sum(s : Theorem_proveSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn theorem_prove_series_mean(s : Theorem_proveSeries) -> Double {
  let n = theorem_prove_series_len(s)
  if n == 0 { 0.0 } else { theorem_prove_series_sum(s) / n.to_double() }
}

pub fn theorem_prove_series_min(s : Theorem_proveSeries) -> Double {
  let n = theorem_prove_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn theorem_prove_series_max(s : Theorem_proveSeries) -> Double {
  let n = theorem_prove_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn theorem_prove_series_var(s : Theorem_proveSeries) -> Double {
  let n = theorem_prove_series_len(s)
  if n == 0 { 0.0 } else {
    let m = theorem_prove_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn theorem_prove_series_std(s : Theorem_proveSeries) -> Double { theorem_prove_sqrt(theorem_prove_series_var(s)) }

pub fn theorem_prove_series_scale(s : Theorem_proveSeries, f : Double) -> Theorem_proveSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = theorem_prove_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn theorem_prove_series_add(a : Theorem_proveSeries, b : Theorem_proveSeries) -> Theorem_proveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = theorem_prove_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn theorem_prove_series_to_string(s : Theorem_proveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + theorem_prove_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Theorem_proveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn theorem_prove_make_matrix(rows : Int, cols : Int, val : Double) -> Theorem_proveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn theorem_prove_matrix_identity(n : Int) -> Theorem_proveMatrix {
  let m = theorem_prove_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn theorem_prove_matrix_get(m : Theorem_proveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn theorem_prove_matrix_transpose(m : Theorem_proveMatrix) -> Theorem_proveMatrix {
  let result = theorem_prove_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn theorem_prove_matrix_add(a : Theorem_proveMatrix, b : Theorem_proveMatrix) -> Theorem_proveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = theorem_prove_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn theorem_prove_matrix_scale(m : Theorem_proveMatrix, s : Double) -> Theorem_proveMatrix {
  let result = theorem_prove_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn theorem_prove_matrix_multiply(a : Theorem_proveMatrix, b : Theorem_proveMatrix) -> Theorem_proveMatrix {
  if a.cols != b.rows { return theorem_prove_make_matrix(a.rows, b.cols, 0.0) }
  let result = theorem_prove_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn theorem_prove_matrix_trace(m : Theorem_proveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn theorem_prove_matrix_norm(m : Theorem_proveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  theorem_prove_sqrt(sum)
}

pub fn theorem_prove_matrix_to_string(m : Theorem_proveMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + theorem_prove_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Theorem_proveVector {
  comps : Array[Double]
  dim : Int
}

pub fn theorem_prove_make_vector(comps : Array[Double]) -> Theorem_proveVector {
  { comps, dim: comps.length() }
}

pub fn theorem_prove_vector_zero(dim : Int) -> Theorem_proveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn theorem_prove_vector_add(a : Theorem_proveVector, b : Theorem_proveVector) -> Theorem_proveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = theorem_prove_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn theorem_prove_vector_sub(a : Theorem_proveVector, b : Theorem_proveVector) -> Theorem_proveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = theorem_prove_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn theorem_prove_vector_scale(v : Theorem_proveVector, s : Double) -> Theorem_proveVector {
  let mut result = []
  for i in 0..<v.dim { result = theorem_prove_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn theorem_prove_vector_dot(a : Theorem_proveVector, b : Theorem_proveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn theorem_prove_vector_norm(v : Theorem_proveVector) -> Double { theorem_prove_sqrt(theorem_prove_vector_dot(v, v)) }

pub fn theorem_prove_vector_normalize(v : Theorem_proveVector) -> Theorem_proveVector {
  let n = theorem_prove_vector_norm(v)
  if n < 0.0000001 { v } else { theorem_prove_vector_scale(v, 1.0 / n) }
}

pub fn theorem_prove_vector_dist(a : Theorem_proveVector, b : Theorem_proveVector) -> Double {
  theorem_prove_vector_norm(theorem_prove_vector_sub(a, b))
}

pub fn theorem_prove_vector_to_string(v : Theorem_proveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + theorem_prove_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn theorem_prove_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn theorem_prove_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = theorem_prove_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn theorem_prove_std(data : Array[Double]) -> Double { theorem_prove_sqrt(theorem_prove_var(data)) }

pub fn theorem_prove_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = theorem_prove_mean(a); let mb = theorem_prove_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn theorem_prove_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = theorem_prove_std(a); let sb = theorem_prove_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { theorem_prove_cov(a, b) / (sa * sb) }
}

pub fn theorem_prove_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn theorem_prove_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn theorem_prove_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + theorem_prove_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn theorem_prove_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = theorem_prove_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn theorem_prove_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn theorem_prove_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn theorem_prove_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = theorem_prove_precision(pred, labels, pos); let r = theorem_prove_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn theorem_prove_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn theorem_prove_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn theorem_prove_dbl(x : Double) -> String {
  let i = if x >= 0.0 { theorem_prove_int(x) } else { -theorem_prove_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { theorem_prove_int(f * 1000000.0) } else { theorem_prove_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn theorem_prove_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn theorem_prove_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
