///===
/// datatemporal/watermark_punct
/// S13.219 new

pub struct Watermark_punctPoint {
  x : Double
  y : Double
  label : Int
}

pub fn watermark_punct_make_point(x : Double, y : Double) -> Watermark_punctPoint {
  { x, y, label: 0 }
}

pub fn watermark_punct_make_labeled_point(x : Double, y : Double, label : Int) -> Watermark_punctPoint {
  { x, y, label }
}

pub fn watermark_punct_point_x(p : Watermark_punctPoint) -> Double { p.x }

pub fn watermark_punct_point_y(p : Watermark_punctPoint) -> Double { p.y }

pub fn watermark_punct_point_label(p : Watermark_punctPoint) -> Int { p.label }

pub fn watermark_punct_point_dist(a : Watermark_punctPoint, b : Watermark_punctPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn watermark_punct_point_add(a : Watermark_punctPoint, b : Watermark_punctPoint) -> Watermark_punctPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn watermark_punct_point_sub(a : Watermark_punctPoint, b : Watermark_punctPoint) -> Watermark_punctPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn watermark_punct_point_scale(pt : Watermark_punctPoint, s : Double) -> Watermark_punctPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn watermark_punct_point_dot(a : Watermark_punctPoint, b : Watermark_punctPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn watermark_punct_point_norm(pt : Watermark_punctPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn watermark_punct_point_to_string(pt : Watermark_punctPoint) -> String {
  "(" + watermark_punct_dbl(pt.x) + ", " + watermark_punct_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Watermark_punctSeries {
  vals : Array[Double]
  name : String
}

pub fn watermark_punct_make_series(vals : Array[Double], name : String) -> Watermark_punctSeries {
  { vals, name }
}

pub fn watermark_punct_series_len(s : Watermark_punctSeries) -> Int { s.vals.length() }

pub fn watermark_punct_series_sum(s : Watermark_punctSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn watermark_punct_series_mean(s : Watermark_punctSeries) -> Double {
  let n = watermark_punct_series_len(s)
  if n == 0 { 0.0 } else { watermark_punct_series_sum(s) / n.to_double() }
}

pub fn watermark_punct_series_min(s : Watermark_punctSeries) -> Double {
  let n = watermark_punct_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn watermark_punct_series_max(s : Watermark_punctSeries) -> Double {
  let n = watermark_punct_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn watermark_punct_series_var(s : Watermark_punctSeries) -> Double {
  let n = watermark_punct_series_len(s)
  if n == 0 { 0.0 } else {
    let m = watermark_punct_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn watermark_punct_series_std(s : Watermark_punctSeries) -> Double { @_common.sqrt(watermark_punct_series_var(s)) }

pub fn watermark_punct_series_scale(s : Watermark_punctSeries, f : Double) -> Watermark_punctSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = watermark_punct_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn watermark_punct_series_add(a : Watermark_punctSeries, b : Watermark_punctSeries) -> Watermark_punctSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = watermark_punct_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn watermark_punct_series_to_string(s : Watermark_punctSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + watermark_punct_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Watermark_punctMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn watermark_punct_make_matrix(rows : Int, cols : Int, val : Double) -> Watermark_punctMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn watermark_punct_matrix_identity(n : Int) -> Watermark_punctMatrix {
  let m = watermark_punct_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn watermark_punct_matrix_get(m : Watermark_punctMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn watermark_punct_matrix_transpose(m : Watermark_punctMatrix) -> Watermark_punctMatrix {
  let result = watermark_punct_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn watermark_punct_matrix_add(a : Watermark_punctMatrix, b : Watermark_punctMatrix) -> Watermark_punctMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = watermark_punct_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn watermark_punct_matrix_scale(m : Watermark_punctMatrix, s : Double) -> Watermark_punctMatrix {
  let result = watermark_punct_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn watermark_punct_matrix_multiply(a : Watermark_punctMatrix, b : Watermark_punctMatrix) -> Watermark_punctMatrix {
  if a.cols != b.rows { return watermark_punct_make_matrix(a.rows, b.cols, 0.0) }
  let result = watermark_punct_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn watermark_punct_matrix_trace(m : Watermark_punctMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn watermark_punct_matrix_norm(m : Watermark_punctMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn watermark_punct_matrix_to_string(m : Watermark_punctMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + watermark_punct_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Watermark_punctVector {
  comps : Array[Double]
  dim : Int
}

pub fn watermark_punct_make_vector(comps : Array[Double]) -> Watermark_punctVector {
  { comps, dim: comps.length() }
}

pub fn watermark_punct_vector_zero(dim : Int) -> Watermark_punctVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn watermark_punct_vector_add(a : Watermark_punctVector, b : Watermark_punctVector) -> Watermark_punctVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = watermark_punct_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn watermark_punct_vector_sub(a : Watermark_punctVector, b : Watermark_punctVector) -> Watermark_punctVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = watermark_punct_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn watermark_punct_vector_scale(v : Watermark_punctVector, s : Double) -> Watermark_punctVector {
  let mut result = []
  for i in 0..<v.dim { result = watermark_punct_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn watermark_punct_vector_dot(a : Watermark_punctVector, b : Watermark_punctVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn watermark_punct_vector_norm(v : Watermark_punctVector) -> Double { @_common.sqrt(watermark_punct_vector_dot(v, v)) }

pub fn watermark_punct_vector_normalize(v : Watermark_punctVector) -> Watermark_punctVector {
  let n = watermark_punct_vector_norm(v)
  if n < 0.0000001 { v } else { watermark_punct_vector_scale(v, 1.0 / n) }
}

pub fn watermark_punct_vector_dist(a : Watermark_punctVector, b : Watermark_punctVector) -> Double {
  watermark_punct_vector_norm(watermark_punct_vector_sub(a, b))
}

pub fn watermark_punct_vector_to_string(v : Watermark_punctVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + watermark_punct_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn watermark_punct_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn watermark_punct_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = watermark_punct_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn watermark_punct_std(data : Array[Double]) -> Double { @_common.sqrt(watermark_punct_var(data)) }

pub fn watermark_punct_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = watermark_punct_mean(a); let mb = watermark_punct_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn watermark_punct_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = watermark_punct_std(a); let sb = watermark_punct_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { watermark_punct_cov(a, b) / (sa * sb) }
}

pub fn watermark_punct_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn watermark_punct_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn watermark_punct_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn watermark_punct_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = watermark_punct_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn watermark_punct_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn watermark_punct_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn watermark_punct_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = watermark_punct_precision(pred, labels, pos); let r = watermark_punct_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn watermark_punct_dbl(x : Double) -> String {
  let i = if x >= 0.0 { watermark_punct_int(x) } else { -watermark_punct_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { watermark_punct_int(f * 1000000.0) } else { watermark_punct_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn watermark_punct_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn watermark_punct_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
