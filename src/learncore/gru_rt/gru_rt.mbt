///===
/// learncore/gru_rt
/// S13.113 new

pub struct Gru_rtPoint {
  x : Double
  y : Double
  label : Int
}

pub fn gru_rt_make_point(x : Double, y : Double) -> Gru_rtPoint {
  { x, y, label: 0 }
}

pub fn gru_rt_make_labeled_point(x : Double, y : Double, label : Int) -> Gru_rtPoint {
  { x, y, label }
}

pub fn gru_rt_point_x(p : Gru_rtPoint) -> Double { p.x }

pub fn gru_rt_point_y(p : Gru_rtPoint) -> Double { p.y }

pub fn gru_rt_point_label(p : Gru_rtPoint) -> Int { p.label }

pub fn gru_rt_point_dist(a : Gru_rtPoint, b : Gru_rtPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn gru_rt_point_add(a : Gru_rtPoint, b : Gru_rtPoint) -> Gru_rtPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn gru_rt_point_sub(a : Gru_rtPoint, b : Gru_rtPoint) -> Gru_rtPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn gru_rt_point_scale(pt : Gru_rtPoint, s : Double) -> Gru_rtPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn gru_rt_point_dot(a : Gru_rtPoint, b : Gru_rtPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn gru_rt_point_norm(pt : Gru_rtPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn gru_rt_point_to_string(pt : Gru_rtPoint) -> String {
  "(" + gru_rt_dbl(pt.x) + ", " + gru_rt_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Gru_rtSeries {
  vals : Array[Double]
  name : String
}

pub fn gru_rt_make_series(vals : Array[Double], name : String) -> Gru_rtSeries {
  { vals, name }
}

pub fn gru_rt_series_len(s : Gru_rtSeries) -> Int { s.vals.length() }

pub fn gru_rt_series_sum(s : Gru_rtSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn gru_rt_series_mean(s : Gru_rtSeries) -> Double {
  let n = gru_rt_series_len(s)
  if n == 0 { 0.0 } else { gru_rt_series_sum(s) / n.to_double() }
}

pub fn gru_rt_series_min(s : Gru_rtSeries) -> Double {
  let n = gru_rt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn gru_rt_series_max(s : Gru_rtSeries) -> Double {
  let n = gru_rt_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn gru_rt_series_var(s : Gru_rtSeries) -> Double {
  let n = gru_rt_series_len(s)
  if n == 0 { 0.0 } else {
    let m = gru_rt_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn gru_rt_series_std(s : Gru_rtSeries) -> Double { @_common.sqrt(gru_rt_series_var(s)) }

pub fn gru_rt_series_scale(s : Gru_rtSeries, f : Double) -> Gru_rtSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = gru_rt_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn gru_rt_series_add(a : Gru_rtSeries, b : Gru_rtSeries) -> Gru_rtSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = gru_rt_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn gru_rt_series_to_string(s : Gru_rtSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + gru_rt_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Gru_rtMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn gru_rt_make_matrix(rows : Int, cols : Int, val : Double) -> Gru_rtMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn gru_rt_matrix_identity(n : Int) -> Gru_rtMatrix {
  let m = gru_rt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn gru_rt_matrix_get(m : Gru_rtMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn gru_rt_matrix_transpose(m : Gru_rtMatrix) -> Gru_rtMatrix {
  let result = gru_rt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn gru_rt_matrix_add(a : Gru_rtMatrix, b : Gru_rtMatrix) -> Gru_rtMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = gru_rt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn gru_rt_matrix_scale(m : Gru_rtMatrix, s : Double) -> Gru_rtMatrix {
  let result = gru_rt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn gru_rt_matrix_multiply(a : Gru_rtMatrix, b : Gru_rtMatrix) -> Gru_rtMatrix {
  if a.cols != b.rows { return gru_rt_make_matrix(a.rows, b.cols, 0.0) }
  let result = gru_rt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn gru_rt_matrix_trace(m : Gru_rtMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn gru_rt_matrix_norm(m : Gru_rtMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn gru_rt_matrix_to_string(m : Gru_rtMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + gru_rt_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Gru_rtVector {
  comps : Array[Double]
  dim : Int
}

pub fn gru_rt_make_vector(comps : Array[Double]) -> Gru_rtVector {
  { comps, dim: comps.length() }
}

pub fn gru_rt_vector_zero(dim : Int) -> Gru_rtVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn gru_rt_vector_add(a : Gru_rtVector, b : Gru_rtVector) -> Gru_rtVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = gru_rt_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn gru_rt_vector_sub(a : Gru_rtVector, b : Gru_rtVector) -> Gru_rtVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = gru_rt_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn gru_rt_vector_scale(v : Gru_rtVector, s : Double) -> Gru_rtVector {
  let mut result = []
  for i in 0..<v.dim { result = gru_rt_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn gru_rt_vector_dot(a : Gru_rtVector, b : Gru_rtVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn gru_rt_vector_norm(v : Gru_rtVector) -> Double { @_common.sqrt(gru_rt_vector_dot(v, v)) }

pub fn gru_rt_vector_normalize(v : Gru_rtVector) -> Gru_rtVector {
  let n = gru_rt_vector_norm(v)
  if n < 0.0000001 { v } else { gru_rt_vector_scale(v, 1.0 / n) }
}

pub fn gru_rt_vector_dist(a : Gru_rtVector, b : Gru_rtVector) -> Double {
  gru_rt_vector_norm(gru_rt_vector_sub(a, b))
}

pub fn gru_rt_vector_to_string(v : Gru_rtVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + gru_rt_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn gru_rt_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn gru_rt_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = gru_rt_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn gru_rt_std(data : Array[Double]) -> Double { @_common.sqrt(gru_rt_var(data)) }

pub fn gru_rt_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = gru_rt_mean(a); let mb = gru_rt_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn gru_rt_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = gru_rt_std(a); let sb = gru_rt_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { gru_rt_cov(a, b) / (sa * sb) }
}

pub fn gru_rt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn gru_rt_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn gru_rt_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn gru_rt_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = gru_rt_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn gru_rt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn gru_rt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn gru_rt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = gru_rt_precision(pred, labels, pos); let r = gru_rt_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn gru_rt_dbl(x : Double) -> String {
  let i = if x >= 0.0 { gru_rt_int(x) } else { -gru_rt_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { gru_rt_int(f * 1000000.0) } else { gru_rt_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn gru_rt_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn gru_rt_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
