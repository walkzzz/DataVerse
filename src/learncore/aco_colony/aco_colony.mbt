///===
/// learncore/aco_colony
/// S13.72 new

pub struct Aco_colonyPoint {
  x : Double
  y : Double
  label : Int
}

pub fn aco_colony_make_point(x : Double, y : Double) -> Aco_colonyPoint {
  { x, y, label: 0 }
}

pub fn aco_colony_make_labeled_point(x : Double, y : Double, label : Int) -> Aco_colonyPoint {
  { x, y, label }
}

pub fn aco_colony_point_x(p : Aco_colonyPoint) -> Double { p.x }

pub fn aco_colony_point_y(p : Aco_colonyPoint) -> Double { p.y }

pub fn aco_colony_point_label(p : Aco_colonyPoint) -> Int { p.label }

pub fn aco_colony_point_dist(a : Aco_colonyPoint, b : Aco_colonyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  aco_colony_sqrt(dx * dx + dy * dy)
}

pub fn aco_colony_point_add(a : Aco_colonyPoint, b : Aco_colonyPoint) -> Aco_colonyPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn aco_colony_point_sub(a : Aco_colonyPoint, b : Aco_colonyPoint) -> Aco_colonyPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn aco_colony_point_scale(pt : Aco_colonyPoint, s : Double) -> Aco_colonyPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn aco_colony_point_dot(a : Aco_colonyPoint, b : Aco_colonyPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn aco_colony_point_norm(pt : Aco_colonyPoint) -> Double {
  aco_colony_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn aco_colony_point_to_string(pt : Aco_colonyPoint) -> String {
  "(" + aco_colony_dbl(pt.x) + ", " + aco_colony_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Aco_colonySeries {
  vals : Array[Double]
  name : String
}

pub fn aco_colony_make_series(vals : Array[Double], name : String) -> Aco_colonySeries {
  { vals, name }
}

pub fn aco_colony_series_len(s : Aco_colonySeries) -> Int { s.vals.length() }

pub fn aco_colony_series_sum(s : Aco_colonySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn aco_colony_series_mean(s : Aco_colonySeries) -> Double {
  let n = aco_colony_series_len(s)
  if n == 0 { 0.0 } else { aco_colony_series_sum(s) / n.to_double() }
}

pub fn aco_colony_series_min(s : Aco_colonySeries) -> Double {
  let n = aco_colony_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn aco_colony_series_max(s : Aco_colonySeries) -> Double {
  let n = aco_colony_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn aco_colony_series_var(s : Aco_colonySeries) -> Double {
  let n = aco_colony_series_len(s)
  if n == 0 { 0.0 } else {
    let m = aco_colony_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn aco_colony_series_std(s : Aco_colonySeries) -> Double { aco_colony_sqrt(aco_colony_series_var(s)) }

pub fn aco_colony_series_scale(s : Aco_colonySeries, f : Double) -> Aco_colonySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = aco_colony_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn aco_colony_series_add(a : Aco_colonySeries, b : Aco_colonySeries) -> Aco_colonySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = aco_colony_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn aco_colony_series_to_string(s : Aco_colonySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + aco_colony_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Aco_colonyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn aco_colony_make_matrix(rows : Int, cols : Int, val : Double) -> Aco_colonyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn aco_colony_matrix_identity(n : Int) -> Aco_colonyMatrix {
  let m = aco_colony_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn aco_colony_matrix_get(m : Aco_colonyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn aco_colony_matrix_transpose(m : Aco_colonyMatrix) -> Aco_colonyMatrix {
  let result = aco_colony_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn aco_colony_matrix_add(a : Aco_colonyMatrix, b : Aco_colonyMatrix) -> Aco_colonyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = aco_colony_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn aco_colony_matrix_scale(m : Aco_colonyMatrix, s : Double) -> Aco_colonyMatrix {
  let result = aco_colony_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn aco_colony_matrix_multiply(a : Aco_colonyMatrix, b : Aco_colonyMatrix) -> Aco_colonyMatrix {
  if a.cols != b.rows { return aco_colony_make_matrix(a.rows, b.cols, 0.0) }
  let result = aco_colony_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn aco_colony_matrix_trace(m : Aco_colonyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn aco_colony_matrix_norm(m : Aco_colonyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  aco_colony_sqrt(sum)
}

pub fn aco_colony_matrix_to_string(m : Aco_colonyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + aco_colony_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Aco_colonyVector {
  comps : Array[Double]
  dim : Int
}

pub fn aco_colony_make_vector(comps : Array[Double]) -> Aco_colonyVector {
  { comps, dim: comps.length() }
}

pub fn aco_colony_vector_zero(dim : Int) -> Aco_colonyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn aco_colony_vector_add(a : Aco_colonyVector, b : Aco_colonyVector) -> Aco_colonyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = aco_colony_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn aco_colony_vector_sub(a : Aco_colonyVector, b : Aco_colonyVector) -> Aco_colonyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = aco_colony_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn aco_colony_vector_scale(v : Aco_colonyVector, s : Double) -> Aco_colonyVector {
  let mut result = []
  for i in 0..<v.dim { result = aco_colony_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn aco_colony_vector_dot(a : Aco_colonyVector, b : Aco_colonyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn aco_colony_vector_norm(v : Aco_colonyVector) -> Double { aco_colony_sqrt(aco_colony_vector_dot(v, v)) }

pub fn aco_colony_vector_normalize(v : Aco_colonyVector) -> Aco_colonyVector {
  let n = aco_colony_vector_norm(v)
  if n < 0.0000001 { v } else { aco_colony_vector_scale(v, 1.0 / n) }
}

pub fn aco_colony_vector_dist(a : Aco_colonyVector, b : Aco_colonyVector) -> Double {
  aco_colony_vector_norm(aco_colony_vector_sub(a, b))
}

pub fn aco_colony_vector_to_string(v : Aco_colonyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + aco_colony_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn aco_colony_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn aco_colony_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = aco_colony_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn aco_colony_std(data : Array[Double]) -> Double { aco_colony_sqrt(aco_colony_var(data)) }

pub fn aco_colony_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = aco_colony_mean(a); let mb = aco_colony_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn aco_colony_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = aco_colony_std(a); let sb = aco_colony_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { aco_colony_cov(a, b) / (sa * sb) }
}

pub fn aco_colony_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn aco_colony_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn aco_colony_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + aco_colony_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn aco_colony_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = aco_colony_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn aco_colony_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn aco_colony_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn aco_colony_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = aco_colony_precision(pred, labels, pos); let r = aco_colony_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn aco_colony_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn aco_colony_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn aco_colony_dbl(x : Double) -> String {
  let i = if x >= 0.0 { aco_colony_int(x) } else { -aco_colony_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { aco_colony_int(f * 1000000.0) } else { aco_colony_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn aco_colony_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn aco_colony_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
