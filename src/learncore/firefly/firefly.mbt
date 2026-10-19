///===
/// learncore/firefly
/// S13.74 new

pub struct FireflyPoint {
  x : Double
  y : Double
  label : Int
}

pub fn firefly_make_point(x : Double, y : Double) -> FireflyPoint {
  { x, y, label: 0 }
}

pub fn firefly_make_labeled_point(x : Double, y : Double, label : Int) -> FireflyPoint {
  { x, y, label }
}

pub fn firefly_point_x(p : FireflyPoint) -> Double { p.x }

pub fn firefly_point_y(p : FireflyPoint) -> Double { p.y }

pub fn firefly_point_label(p : FireflyPoint) -> Int { p.label }

pub fn firefly_point_dist(a : FireflyPoint, b : FireflyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  firefly_sqrt(dx * dx + dy * dy)
}

pub fn firefly_point_add(a : FireflyPoint, b : FireflyPoint) -> FireflyPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn firefly_point_sub(a : FireflyPoint, b : FireflyPoint) -> FireflyPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn firefly_point_scale(pt : FireflyPoint, s : Double) -> FireflyPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn firefly_point_dot(a : FireflyPoint, b : FireflyPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn firefly_point_norm(pt : FireflyPoint) -> Double {
  firefly_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn firefly_point_to_string(pt : FireflyPoint) -> String {
  "(" + firefly_dbl(pt.x) + ", " + firefly_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct FireflySeries {
  vals : Array[Double]
  name : String
}

pub fn firefly_make_series(vals : Array[Double], name : String) -> FireflySeries {
  { vals, name }
}

pub fn firefly_series_len(s : FireflySeries) -> Int { s.vals.length() }

pub fn firefly_series_sum(s : FireflySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn firefly_series_mean(s : FireflySeries) -> Double {
  let n = firefly_series_len(s)
  if n == 0 { 0.0 } else { firefly_series_sum(s) / n.to_double() }
}

pub fn firefly_series_min(s : FireflySeries) -> Double {
  let n = firefly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn firefly_series_max(s : FireflySeries) -> Double {
  let n = firefly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn firefly_series_var(s : FireflySeries) -> Double {
  let n = firefly_series_len(s)
  if n == 0 { 0.0 } else {
    let m = firefly_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn firefly_series_std(s : FireflySeries) -> Double { firefly_sqrt(firefly_series_var(s)) }

pub fn firefly_series_scale(s : FireflySeries, f : Double) -> FireflySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = firefly_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn firefly_series_add(a : FireflySeries, b : FireflySeries) -> FireflySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = firefly_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn firefly_series_to_string(s : FireflySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + firefly_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct FireflyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn firefly_make_matrix(rows : Int, cols : Int, val : Double) -> FireflyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn firefly_matrix_identity(n : Int) -> FireflyMatrix {
  let m = firefly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn firefly_matrix_get(m : FireflyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn firefly_matrix_transpose(m : FireflyMatrix) -> FireflyMatrix {
  let result = firefly_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn firefly_matrix_add(a : FireflyMatrix, b : FireflyMatrix) -> FireflyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = firefly_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn firefly_matrix_scale(m : FireflyMatrix, s : Double) -> FireflyMatrix {
  let result = firefly_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn firefly_matrix_multiply(a : FireflyMatrix, b : FireflyMatrix) -> FireflyMatrix {
  if a.cols != b.rows { return firefly_make_matrix(a.rows, b.cols, 0.0) }
  let result = firefly_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn firefly_matrix_trace(m : FireflyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn firefly_matrix_norm(m : FireflyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  firefly_sqrt(sum)
}

pub fn firefly_matrix_to_string(m : FireflyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + firefly_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct FireflyVector {
  comps : Array[Double]
  dim : Int
}

pub fn firefly_make_vector(comps : Array[Double]) -> FireflyVector {
  { comps, dim: comps.length() }
}

pub fn firefly_vector_zero(dim : Int) -> FireflyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn firefly_vector_add(a : FireflyVector, b : FireflyVector) -> FireflyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = firefly_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn firefly_vector_sub(a : FireflyVector, b : FireflyVector) -> FireflyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = firefly_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn firefly_vector_scale(v : FireflyVector, s : Double) -> FireflyVector {
  let mut result = []
  for i in 0..<v.dim { result = firefly_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn firefly_vector_dot(a : FireflyVector, b : FireflyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn firefly_vector_norm(v : FireflyVector) -> Double { firefly_sqrt(firefly_vector_dot(v, v)) }

pub fn firefly_vector_normalize(v : FireflyVector) -> FireflyVector {
  let n = firefly_vector_norm(v)
  if n < 0.0000001 { v } else { firefly_vector_scale(v, 1.0 / n) }
}

pub fn firefly_vector_dist(a : FireflyVector, b : FireflyVector) -> Double {
  firefly_vector_norm(firefly_vector_sub(a, b))
}

pub fn firefly_vector_to_string(v : FireflyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + firefly_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn firefly_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn firefly_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = firefly_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn firefly_std(data : Array[Double]) -> Double { firefly_sqrt(firefly_var(data)) }

pub fn firefly_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = firefly_mean(a); let mb = firefly_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn firefly_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = firefly_std(a); let sb = firefly_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { firefly_cov(a, b) / (sa * sb) }
}

pub fn firefly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn firefly_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn firefly_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + firefly_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn firefly_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = firefly_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn firefly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn firefly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn firefly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = firefly_precision(pred, labels, pos); let r = firefly_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn firefly_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn firefly_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn firefly_dbl(x : Double) -> String {
  let i = if x >= 0.0 { firefly_int(x) } else { -firefly_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { firefly_int(f * 1000000.0) } else { firefly_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn firefly_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn firefly_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
