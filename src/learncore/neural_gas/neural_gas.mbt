///===
/// learncore/neural_gas
/// S13.65 new

pub struct Neural_gasPoint {
  x : Double
  y : Double
  label : Int
}

pub fn neural_gas_make_point(x : Double, y : Double) -> Neural_gasPoint {
  { x, y, label: 0 }
}

pub fn neural_gas_make_labeled_point(x : Double, y : Double, label : Int) -> Neural_gasPoint {
  { x, y, label }
}

pub fn neural_gas_point_x(p : Neural_gasPoint) -> Double { p.x }

pub fn neural_gas_point_y(p : Neural_gasPoint) -> Double { p.y }

pub fn neural_gas_point_label(p : Neural_gasPoint) -> Int { p.label }

pub fn neural_gas_point_dist(a : Neural_gasPoint, b : Neural_gasPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  neural_gas_sqrt(dx * dx + dy * dy)
}

pub fn neural_gas_point_add(a : Neural_gasPoint, b : Neural_gasPoint) -> Neural_gasPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn neural_gas_point_sub(a : Neural_gasPoint, b : Neural_gasPoint) -> Neural_gasPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn neural_gas_point_scale(pt : Neural_gasPoint, s : Double) -> Neural_gasPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn neural_gas_point_dot(a : Neural_gasPoint, b : Neural_gasPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn neural_gas_point_norm(pt : Neural_gasPoint) -> Double {
  neural_gas_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn neural_gas_point_to_string(pt : Neural_gasPoint) -> String {
  "(" + neural_gas_dbl(pt.x) + ", " + neural_gas_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Neural_gasSeries {
  vals : Array[Double]
  name : String
}

pub fn neural_gas_make_series(vals : Array[Double], name : String) -> Neural_gasSeries {
  { vals, name }
}

pub fn neural_gas_series_len(s : Neural_gasSeries) -> Int { s.vals.length() }

pub fn neural_gas_series_sum(s : Neural_gasSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn neural_gas_series_mean(s : Neural_gasSeries) -> Double {
  let n = neural_gas_series_len(s)
  if n == 0 { 0.0 } else { neural_gas_series_sum(s) / n.to_double() }
}

pub fn neural_gas_series_min(s : Neural_gasSeries) -> Double {
  let n = neural_gas_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn neural_gas_series_max(s : Neural_gasSeries) -> Double {
  let n = neural_gas_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn neural_gas_series_var(s : Neural_gasSeries) -> Double {
  let n = neural_gas_series_len(s)
  if n == 0 { 0.0 } else {
    let m = neural_gas_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn neural_gas_series_std(s : Neural_gasSeries) -> Double { neural_gas_sqrt(neural_gas_series_var(s)) }

pub fn neural_gas_series_scale(s : Neural_gasSeries, f : Double) -> Neural_gasSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = neural_gas_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn neural_gas_series_add(a : Neural_gasSeries, b : Neural_gasSeries) -> Neural_gasSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = neural_gas_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn neural_gas_series_to_string(s : Neural_gasSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + neural_gas_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Neural_gasMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn neural_gas_make_matrix(rows : Int, cols : Int, val : Double) -> Neural_gasMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn neural_gas_matrix_identity(n : Int) -> Neural_gasMatrix {
  let m = neural_gas_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn neural_gas_matrix_get(m : Neural_gasMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn neural_gas_matrix_transpose(m : Neural_gasMatrix) -> Neural_gasMatrix {
  let result = neural_gas_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn neural_gas_matrix_add(a : Neural_gasMatrix, b : Neural_gasMatrix) -> Neural_gasMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = neural_gas_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn neural_gas_matrix_scale(m : Neural_gasMatrix, s : Double) -> Neural_gasMatrix {
  let result = neural_gas_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn neural_gas_matrix_multiply(a : Neural_gasMatrix, b : Neural_gasMatrix) -> Neural_gasMatrix {
  if a.cols != b.rows { return neural_gas_make_matrix(a.rows, b.cols, 0.0) }
  let result = neural_gas_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn neural_gas_matrix_trace(m : Neural_gasMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn neural_gas_matrix_norm(m : Neural_gasMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  neural_gas_sqrt(sum)
}

pub fn neural_gas_matrix_to_string(m : Neural_gasMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + neural_gas_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Neural_gasVector {
  comps : Array[Double]
  dim : Int
}

pub fn neural_gas_make_vector(comps : Array[Double]) -> Neural_gasVector {
  { comps, dim: comps.length() }
}

pub fn neural_gas_vector_zero(dim : Int) -> Neural_gasVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn neural_gas_vector_add(a : Neural_gasVector, b : Neural_gasVector) -> Neural_gasVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = neural_gas_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn neural_gas_vector_sub(a : Neural_gasVector, b : Neural_gasVector) -> Neural_gasVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = neural_gas_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn neural_gas_vector_scale(v : Neural_gasVector, s : Double) -> Neural_gasVector {
  let mut result = []
  for i in 0..<v.dim { result = neural_gas_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn neural_gas_vector_dot(a : Neural_gasVector, b : Neural_gasVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn neural_gas_vector_norm(v : Neural_gasVector) -> Double { neural_gas_sqrt(neural_gas_vector_dot(v, v)) }

pub fn neural_gas_vector_normalize(v : Neural_gasVector) -> Neural_gasVector {
  let n = neural_gas_vector_norm(v)
  if n < 0.0000001 { v } else { neural_gas_vector_scale(v, 1.0 / n) }
}

pub fn neural_gas_vector_dist(a : Neural_gasVector, b : Neural_gasVector) -> Double {
  neural_gas_vector_norm(neural_gas_vector_sub(a, b))
}

pub fn neural_gas_vector_to_string(v : Neural_gasVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + neural_gas_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn neural_gas_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn neural_gas_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = neural_gas_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn neural_gas_std(data : Array[Double]) -> Double { neural_gas_sqrt(neural_gas_var(data)) }

pub fn neural_gas_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = neural_gas_mean(a); let mb = neural_gas_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn neural_gas_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = neural_gas_std(a); let sb = neural_gas_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { neural_gas_cov(a, b) / (sa * sb) }
}

pub fn neural_gas_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn neural_gas_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn neural_gas_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + neural_gas_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn neural_gas_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = neural_gas_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn neural_gas_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn neural_gas_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn neural_gas_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = neural_gas_precision(pred, labels, pos); let r = neural_gas_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn neural_gas_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn neural_gas_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn neural_gas_dbl(x : Double) -> String {
  let i = if x >= 0.0 { neural_gas_int(x) } else { -neural_gas_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { neural_gas_int(f * 1000000.0) } else { neural_gas_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn neural_gas_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn neural_gas_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
