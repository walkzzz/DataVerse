///===
/// agent_kit/sat_solver
/// S13.161 new

pub struct Sat_solverPoint {
  x : Double
  y : Double
  label : Int
}

pub fn sat_solver_make_point(x : Double, y : Double) -> Sat_solverPoint {
  { x, y, label: 0 }
}

pub fn sat_solver_make_labeled_point(x : Double, y : Double, label : Int) -> Sat_solverPoint {
  { x, y, label }
}

pub fn sat_solver_point_x(p : Sat_solverPoint) -> Double { p.x }

pub fn sat_solver_point_y(p : Sat_solverPoint) -> Double { p.y }

pub fn sat_solver_point_label(p : Sat_solverPoint) -> Int { p.label }

pub fn sat_solver_point_dist(a : Sat_solverPoint, b : Sat_solverPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  sat_solver_sqrt(dx * dx + dy * dy)
}

pub fn sat_solver_point_add(a : Sat_solverPoint, b : Sat_solverPoint) -> Sat_solverPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn sat_solver_point_sub(a : Sat_solverPoint, b : Sat_solverPoint) -> Sat_solverPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn sat_solver_point_scale(pt : Sat_solverPoint, s : Double) -> Sat_solverPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn sat_solver_point_dot(a : Sat_solverPoint, b : Sat_solverPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn sat_solver_point_norm(pt : Sat_solverPoint) -> Double {
  sat_solver_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn sat_solver_point_to_string(pt : Sat_solverPoint) -> String {
  "(" + sat_solver_dbl(pt.x) + ", " + sat_solver_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Sat_solverSeries {
  vals : Array[Double]
  name : String
}

pub fn sat_solver_make_series(vals : Array[Double], name : String) -> Sat_solverSeries {
  { vals, name }
}

pub fn sat_solver_series_len(s : Sat_solverSeries) -> Int { s.vals.length() }

pub fn sat_solver_series_sum(s : Sat_solverSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sat_solver_series_mean(s : Sat_solverSeries) -> Double {
  let n = sat_solver_series_len(s)
  if n == 0 { 0.0 } else { sat_solver_series_sum(s) / n.to_double() }
}

pub fn sat_solver_series_min(s : Sat_solverSeries) -> Double {
  let n = sat_solver_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sat_solver_series_max(s : Sat_solverSeries) -> Double {
  let n = sat_solver_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sat_solver_series_var(s : Sat_solverSeries) -> Double {
  let n = sat_solver_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sat_solver_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sat_solver_series_std(s : Sat_solverSeries) -> Double { sat_solver_sqrt(sat_solver_series_var(s)) }

pub fn sat_solver_series_scale(s : Sat_solverSeries, f : Double) -> Sat_solverSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sat_solver_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn sat_solver_series_add(a : Sat_solverSeries, b : Sat_solverSeries) -> Sat_solverSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sat_solver_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn sat_solver_series_to_string(s : Sat_solverSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sat_solver_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Sat_solverMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sat_solver_make_matrix(rows : Int, cols : Int, val : Double) -> Sat_solverMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sat_solver_matrix_identity(n : Int) -> Sat_solverMatrix {
  let m = sat_solver_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sat_solver_matrix_get(m : Sat_solverMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sat_solver_matrix_transpose(m : Sat_solverMatrix) -> Sat_solverMatrix {
  let result = sat_solver_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sat_solver_matrix_add(a : Sat_solverMatrix, b : Sat_solverMatrix) -> Sat_solverMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sat_solver_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sat_solver_matrix_scale(m : Sat_solverMatrix, s : Double) -> Sat_solverMatrix {
  let result = sat_solver_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sat_solver_matrix_multiply(a : Sat_solverMatrix, b : Sat_solverMatrix) -> Sat_solverMatrix {
  if a.cols != b.rows { return sat_solver_make_matrix(a.rows, b.cols, 0.0) }
  let result = sat_solver_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sat_solver_matrix_trace(m : Sat_solverMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sat_solver_matrix_norm(m : Sat_solverMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sat_solver_sqrt(sum)
}

pub fn sat_solver_matrix_to_string(m : Sat_solverMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sat_solver_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Sat_solverVector {
  comps : Array[Double]
  dim : Int
}

pub fn sat_solver_make_vector(comps : Array[Double]) -> Sat_solverVector {
  { comps, dim: comps.length() }
}

pub fn sat_solver_vector_zero(dim : Int) -> Sat_solverVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sat_solver_vector_add(a : Sat_solverVector, b : Sat_solverVector) -> Sat_solverVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sat_solver_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sat_solver_vector_sub(a : Sat_solverVector, b : Sat_solverVector) -> Sat_solverVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sat_solver_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sat_solver_vector_scale(v : Sat_solverVector, s : Double) -> Sat_solverVector {
  let mut result = []
  for i in 0..<v.dim { result = sat_solver_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sat_solver_vector_dot(a : Sat_solverVector, b : Sat_solverVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sat_solver_vector_norm(v : Sat_solverVector) -> Double { sat_solver_sqrt(sat_solver_vector_dot(v, v)) }

pub fn sat_solver_vector_normalize(v : Sat_solverVector) -> Sat_solverVector {
  let n = sat_solver_vector_norm(v)
  if n < 0.0000001 { v } else { sat_solver_vector_scale(v, 1.0 / n) }
}

pub fn sat_solver_vector_dist(a : Sat_solverVector, b : Sat_solverVector) -> Double {
  sat_solver_vector_norm(sat_solver_vector_sub(a, b))
}

pub fn sat_solver_vector_to_string(v : Sat_solverVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sat_solver_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sat_solver_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sat_solver_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sat_solver_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sat_solver_std(data : Array[Double]) -> Double { sat_solver_sqrt(sat_solver_var(data)) }

pub fn sat_solver_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sat_solver_mean(a); let mb = sat_solver_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sat_solver_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sat_solver_std(a); let sb = sat_solver_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sat_solver_cov(a, b) / (sa * sb) }
}

pub fn sat_solver_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sat_solver_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sat_solver_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sat_solver_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sat_solver_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sat_solver_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sat_solver_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sat_solver_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sat_solver_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sat_solver_precision(pred, labels, pos); let r = sat_solver_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn sat_solver_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sat_solver_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sat_solver_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sat_solver_int(x) } else { -sat_solver_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sat_solver_int(f * 1000000.0) } else { sat_solver_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sat_solver_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sat_solver_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
