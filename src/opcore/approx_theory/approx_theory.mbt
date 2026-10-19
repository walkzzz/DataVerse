///===
/// opcore/approx_theory
/// S13.6 new

pub struct Approx_theoryPoint {
  x : Double
  y : Double
  label : Int
}

pub fn approx_theory_make_point(x : Double, y : Double) -> Approx_theoryPoint {
  { x, y, label: 0 }
}

pub fn approx_theory_make_labeled_point(x : Double, y : Double, label : Int) -> Approx_theoryPoint {
  { x, y, label }
}

pub fn approx_theory_point_x(p : Approx_theoryPoint) -> Double { p.x }

pub fn approx_theory_point_y(p : Approx_theoryPoint) -> Double { p.y }

pub fn approx_theory_point_label(p : Approx_theoryPoint) -> Int { p.label }

pub fn approx_theory_point_dist(a : Approx_theoryPoint, b : Approx_theoryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  approx_theory_sqrt(dx * dx + dy * dy)
}

pub fn approx_theory_point_add(a : Approx_theoryPoint, b : Approx_theoryPoint) -> Approx_theoryPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn approx_theory_point_sub(a : Approx_theoryPoint, b : Approx_theoryPoint) -> Approx_theoryPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn approx_theory_point_scale(pt : Approx_theoryPoint, s : Double) -> Approx_theoryPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn approx_theory_point_dot(a : Approx_theoryPoint, b : Approx_theoryPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn approx_theory_point_norm(pt : Approx_theoryPoint) -> Double {
  approx_theory_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn approx_theory_point_to_string(pt : Approx_theoryPoint) -> String {
  "(" + approx_theory_dbl(pt.x) + ", " + approx_theory_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Approx_theorySeries {
  vals : Array[Double]
  name : String
}

pub fn approx_theory_make_series(vals : Array[Double], name : String) -> Approx_theorySeries {
  { vals, name }
}

pub fn approx_theory_series_len(s : Approx_theorySeries) -> Int { s.vals.length() }

pub fn approx_theory_series_sum(s : Approx_theorySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn approx_theory_series_mean(s : Approx_theorySeries) -> Double {
  let n = approx_theory_series_len(s)
  if n == 0 { 0.0 } else { approx_theory_series_sum(s) / n.to_double() }
}

pub fn approx_theory_series_min(s : Approx_theorySeries) -> Double {
  let n = approx_theory_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn approx_theory_series_max(s : Approx_theorySeries) -> Double {
  let n = approx_theory_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn approx_theory_series_var(s : Approx_theorySeries) -> Double {
  let n = approx_theory_series_len(s)
  if n == 0 { 0.0 } else {
    let m = approx_theory_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn approx_theory_series_std(s : Approx_theorySeries) -> Double { approx_theory_sqrt(approx_theory_series_var(s)) }

pub fn approx_theory_series_scale(s : Approx_theorySeries, f : Double) -> Approx_theorySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = approx_theory_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn approx_theory_series_add(a : Approx_theorySeries, b : Approx_theorySeries) -> Approx_theorySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = approx_theory_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn approx_theory_series_to_string(s : Approx_theorySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + approx_theory_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Approx_theoryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn approx_theory_make_matrix(rows : Int, cols : Int, val : Double) -> Approx_theoryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn approx_theory_matrix_identity(n : Int) -> Approx_theoryMatrix {
  let m = approx_theory_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn approx_theory_matrix_get(m : Approx_theoryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn approx_theory_matrix_transpose(m : Approx_theoryMatrix) -> Approx_theoryMatrix {
  let result = approx_theory_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn approx_theory_matrix_add(a : Approx_theoryMatrix, b : Approx_theoryMatrix) -> Approx_theoryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = approx_theory_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn approx_theory_matrix_scale(m : Approx_theoryMatrix, s : Double) -> Approx_theoryMatrix {
  let result = approx_theory_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn approx_theory_matrix_multiply(a : Approx_theoryMatrix, b : Approx_theoryMatrix) -> Approx_theoryMatrix {
  if a.cols != b.rows { return approx_theory_make_matrix(a.rows, b.cols, 0.0) }
  let result = approx_theory_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn approx_theory_matrix_trace(m : Approx_theoryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn approx_theory_matrix_norm(m : Approx_theoryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  approx_theory_sqrt(sum)
}

pub fn approx_theory_matrix_to_string(m : Approx_theoryMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + approx_theory_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Approx_theoryVector {
  comps : Array[Double]
  dim : Int
}

pub fn approx_theory_make_vector(comps : Array[Double]) -> Approx_theoryVector {
  { comps, dim: comps.length() }
}

pub fn approx_theory_vector_zero(dim : Int) -> Approx_theoryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn approx_theory_vector_add(a : Approx_theoryVector, b : Approx_theoryVector) -> Approx_theoryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = approx_theory_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn approx_theory_vector_sub(a : Approx_theoryVector, b : Approx_theoryVector) -> Approx_theoryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = approx_theory_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn approx_theory_vector_scale(v : Approx_theoryVector, s : Double) -> Approx_theoryVector {
  let mut result = []
  for i in 0..<v.dim { result = approx_theory_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn approx_theory_vector_dot(a : Approx_theoryVector, b : Approx_theoryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn approx_theory_vector_norm(v : Approx_theoryVector) -> Double { approx_theory_sqrt(approx_theory_vector_dot(v, v)) }

pub fn approx_theory_vector_normalize(v : Approx_theoryVector) -> Approx_theoryVector {
  let n = approx_theory_vector_norm(v)
  if n < 0.0000001 { v } else { approx_theory_vector_scale(v, 1.0 / n) }
}

pub fn approx_theory_vector_dist(a : Approx_theoryVector, b : Approx_theoryVector) -> Double {
  approx_theory_vector_norm(approx_theory_vector_sub(a, b))
}

pub fn approx_theory_vector_to_string(v : Approx_theoryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + approx_theory_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn approx_theory_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn approx_theory_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = approx_theory_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn approx_theory_std(data : Array[Double]) -> Double { approx_theory_sqrt(approx_theory_var(data)) }

pub fn approx_theory_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = approx_theory_mean(a); let mb = approx_theory_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn approx_theory_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = approx_theory_std(a); let sb = approx_theory_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { approx_theory_cov(a, b) / (sa * sb) }
}

pub fn approx_theory_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn approx_theory_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn approx_theory_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + approx_theory_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn approx_theory_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = approx_theory_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn approx_theory_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn approx_theory_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn approx_theory_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = approx_theory_precision(pred, labels, pos); let r = approx_theory_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn approx_theory_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn approx_theory_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn approx_theory_dbl(x : Double) -> String {
  let i = if x >= 0.0 { approx_theory_int(x) } else { -approx_theory_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { approx_theory_int(f * 1000000.0) } else { approx_theory_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn approx_theory_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn approx_theory_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
