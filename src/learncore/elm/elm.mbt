///===
/// learncore/elm
/// S13.62 new

pub struct ElmPoint {
  x : Double
  y : Double
  label : Int
}

pub fn elm_make_point(x : Double, y : Double) -> ElmPoint {
  { x, y, label: 0 }
}

pub fn elm_make_labeled_point(x : Double, y : Double, label : Int) -> ElmPoint {
  { x, y, label }
}

pub fn elm_point_x(p : ElmPoint) -> Double { p.x }

pub fn elm_point_y(p : ElmPoint) -> Double { p.y }

pub fn elm_point_label(p : ElmPoint) -> Int { p.label }

pub fn elm_point_dist(a : ElmPoint, b : ElmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  elm_sqrt(dx * dx + dy * dy)
}

pub fn elm_point_add(a : ElmPoint, b : ElmPoint) -> ElmPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn elm_point_sub(a : ElmPoint, b : ElmPoint) -> ElmPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn elm_point_scale(pt : ElmPoint, s : Double) -> ElmPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn elm_point_dot(a : ElmPoint, b : ElmPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn elm_point_norm(pt : ElmPoint) -> Double {
  elm_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn elm_point_to_string(pt : ElmPoint) -> String {
  "(" + elm_dbl(pt.x) + ", " + elm_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct ElmSeries {
  vals : Array[Double]
  name : String
}

pub fn elm_make_series(vals : Array[Double], name : String) -> ElmSeries {
  { vals, name }
}

pub fn elm_series_len(s : ElmSeries) -> Int { s.vals.length() }

pub fn elm_series_sum(s : ElmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn elm_series_mean(s : ElmSeries) -> Double {
  let n = elm_series_len(s)
  if n == 0 { 0.0 } else { elm_series_sum(s) / n.to_double() }
}

pub fn elm_series_min(s : ElmSeries) -> Double {
  let n = elm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn elm_series_max(s : ElmSeries) -> Double {
  let n = elm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn elm_series_var(s : ElmSeries) -> Double {
  let n = elm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = elm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn elm_series_std(s : ElmSeries) -> Double { elm_sqrt(elm_series_var(s)) }

pub fn elm_series_scale(s : ElmSeries, f : Double) -> ElmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = elm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn elm_series_add(a : ElmSeries, b : ElmSeries) -> ElmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = elm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn elm_series_to_string(s : ElmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + elm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct ElmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn elm_make_matrix(rows : Int, cols : Int, val : Double) -> ElmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn elm_matrix_identity(n : Int) -> ElmMatrix {
  let m = elm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn elm_matrix_get(m : ElmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn elm_matrix_transpose(m : ElmMatrix) -> ElmMatrix {
  let result = elm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn elm_matrix_add(a : ElmMatrix, b : ElmMatrix) -> ElmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = elm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn elm_matrix_scale(m : ElmMatrix, s : Double) -> ElmMatrix {
  let result = elm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn elm_matrix_multiply(a : ElmMatrix, b : ElmMatrix) -> ElmMatrix {
  if a.cols != b.rows { return elm_make_matrix(a.rows, b.cols, 0.0) }
  let result = elm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn elm_matrix_trace(m : ElmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn elm_matrix_norm(m : ElmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  elm_sqrt(sum)
}

pub fn elm_matrix_to_string(m : ElmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + elm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct ElmVector {
  comps : Array[Double]
  dim : Int
}

pub fn elm_make_vector(comps : Array[Double]) -> ElmVector {
  { comps, dim: comps.length() }
}

pub fn elm_vector_zero(dim : Int) -> ElmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn elm_vector_add(a : ElmVector, b : ElmVector) -> ElmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = elm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn elm_vector_sub(a : ElmVector, b : ElmVector) -> ElmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = elm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn elm_vector_scale(v : ElmVector, s : Double) -> ElmVector {
  let mut result = []
  for i in 0..<v.dim { result = elm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn elm_vector_dot(a : ElmVector, b : ElmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn elm_vector_norm(v : ElmVector) -> Double { elm_sqrt(elm_vector_dot(v, v)) }

pub fn elm_vector_normalize(v : ElmVector) -> ElmVector {
  let n = elm_vector_norm(v)
  if n < 0.0000001 { v } else { elm_vector_scale(v, 1.0 / n) }
}

pub fn elm_vector_dist(a : ElmVector, b : ElmVector) -> Double {
  elm_vector_norm(elm_vector_sub(a, b))
}

pub fn elm_vector_to_string(v : ElmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + elm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn elm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn elm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = elm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn elm_std(data : Array[Double]) -> Double { elm_sqrt(elm_var(data)) }

pub fn elm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = elm_mean(a); let mb = elm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn elm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = elm_std(a); let sb = elm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { elm_cov(a, b) / (sa * sb) }
}

pub fn elm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn elm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn elm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + elm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn elm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = elm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn elm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn elm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn elm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = elm_precision(pred, labels, pos); let r = elm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn elm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn elm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn elm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { elm_int(x) } else { -elm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { elm_int(f * 1000000.0) } else { elm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn elm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn elm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
