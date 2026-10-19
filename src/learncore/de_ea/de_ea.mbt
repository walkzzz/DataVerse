///===
/// learncore/de_ea
/// S13.70 new

pub struct De_eaPoint {
  x : Double
  y : Double
  label : Int
}

pub fn de_ea_make_point(x : Double, y : Double) -> De_eaPoint {
  { x, y, label: 0 }
}

pub fn de_ea_make_labeled_point(x : Double, y : Double, label : Int) -> De_eaPoint {
  { x, y, label }
}

pub fn de_ea_point_x(p : De_eaPoint) -> Double { p.x }

pub fn de_ea_point_y(p : De_eaPoint) -> Double { p.y }

pub fn de_ea_point_label(p : De_eaPoint) -> Int { p.label }

pub fn de_ea_point_dist(a : De_eaPoint, b : De_eaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  de_ea_sqrt(dx * dx + dy * dy)
}

pub fn de_ea_point_add(a : De_eaPoint, b : De_eaPoint) -> De_eaPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn de_ea_point_sub(a : De_eaPoint, b : De_eaPoint) -> De_eaPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn de_ea_point_scale(pt : De_eaPoint, s : Double) -> De_eaPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn de_ea_point_dot(a : De_eaPoint, b : De_eaPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn de_ea_point_norm(pt : De_eaPoint) -> Double {
  de_ea_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn de_ea_point_to_string(pt : De_eaPoint) -> String {
  "(" + de_ea_dbl(pt.x) + ", " + de_ea_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct De_eaSeries {
  vals : Array[Double]
  name : String
}

pub fn de_ea_make_series(vals : Array[Double], name : String) -> De_eaSeries {
  { vals, name }
}

pub fn de_ea_series_len(s : De_eaSeries) -> Int { s.vals.length() }

pub fn de_ea_series_sum(s : De_eaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn de_ea_series_mean(s : De_eaSeries) -> Double {
  let n = de_ea_series_len(s)
  if n == 0 { 0.0 } else { de_ea_series_sum(s) / n.to_double() }
}

pub fn de_ea_series_min(s : De_eaSeries) -> Double {
  let n = de_ea_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn de_ea_series_max(s : De_eaSeries) -> Double {
  let n = de_ea_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn de_ea_series_var(s : De_eaSeries) -> Double {
  let n = de_ea_series_len(s)
  if n == 0 { 0.0 } else {
    let m = de_ea_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn de_ea_series_std(s : De_eaSeries) -> Double { de_ea_sqrt(de_ea_series_var(s)) }

pub fn de_ea_series_scale(s : De_eaSeries, f : Double) -> De_eaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = de_ea_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn de_ea_series_add(a : De_eaSeries, b : De_eaSeries) -> De_eaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = de_ea_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn de_ea_series_to_string(s : De_eaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + de_ea_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct De_eaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn de_ea_make_matrix(rows : Int, cols : Int, val : Double) -> De_eaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn de_ea_matrix_identity(n : Int) -> De_eaMatrix {
  let m = de_ea_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn de_ea_matrix_get(m : De_eaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn de_ea_matrix_transpose(m : De_eaMatrix) -> De_eaMatrix {
  let result = de_ea_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn de_ea_matrix_add(a : De_eaMatrix, b : De_eaMatrix) -> De_eaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = de_ea_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn de_ea_matrix_scale(m : De_eaMatrix, s : Double) -> De_eaMatrix {
  let result = de_ea_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn de_ea_matrix_multiply(a : De_eaMatrix, b : De_eaMatrix) -> De_eaMatrix {
  if a.cols != b.rows { return de_ea_make_matrix(a.rows, b.cols, 0.0) }
  let result = de_ea_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn de_ea_matrix_trace(m : De_eaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn de_ea_matrix_norm(m : De_eaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  de_ea_sqrt(sum)
}

pub fn de_ea_matrix_to_string(m : De_eaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + de_ea_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct De_eaVector {
  comps : Array[Double]
  dim : Int
}

pub fn de_ea_make_vector(comps : Array[Double]) -> De_eaVector {
  { comps, dim: comps.length() }
}

pub fn de_ea_vector_zero(dim : Int) -> De_eaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn de_ea_vector_add(a : De_eaVector, b : De_eaVector) -> De_eaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = de_ea_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn de_ea_vector_sub(a : De_eaVector, b : De_eaVector) -> De_eaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = de_ea_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn de_ea_vector_scale(v : De_eaVector, s : Double) -> De_eaVector {
  let mut result = []
  for i in 0..<v.dim { result = de_ea_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn de_ea_vector_dot(a : De_eaVector, b : De_eaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn de_ea_vector_norm(v : De_eaVector) -> Double { de_ea_sqrt(de_ea_vector_dot(v, v)) }

pub fn de_ea_vector_normalize(v : De_eaVector) -> De_eaVector {
  let n = de_ea_vector_norm(v)
  if n < 0.0000001 { v } else { de_ea_vector_scale(v, 1.0 / n) }
}

pub fn de_ea_vector_dist(a : De_eaVector, b : De_eaVector) -> Double {
  de_ea_vector_norm(de_ea_vector_sub(a, b))
}

pub fn de_ea_vector_to_string(v : De_eaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + de_ea_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn de_ea_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn de_ea_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = de_ea_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn de_ea_std(data : Array[Double]) -> Double { de_ea_sqrt(de_ea_var(data)) }

pub fn de_ea_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = de_ea_mean(a); let mb = de_ea_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn de_ea_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = de_ea_std(a); let sb = de_ea_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { de_ea_cov(a, b) / (sa * sb) }
}

pub fn de_ea_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn de_ea_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn de_ea_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + de_ea_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn de_ea_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = de_ea_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn de_ea_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn de_ea_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn de_ea_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = de_ea_precision(pred, labels, pos); let r = de_ea_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn de_ea_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn de_ea_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn de_ea_dbl(x : Double) -> String {
  let i = if x >= 0.0 { de_ea_int(x) } else { -de_ea_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { de_ea_int(f * 1000000.0) } else { de_ea_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn de_ea_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn de_ea_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
