///===
/// learncore/som
/// S13.64 new

pub struct SomPoint {
  x : Double
  y : Double
  label : Int
}

pub fn som_make_point(x : Double, y : Double) -> SomPoint {
  { x, y, label: 0 }
}

pub fn som_make_labeled_point(x : Double, y : Double, label : Int) -> SomPoint {
  { x, y, label }
}

pub fn som_point_x(p : SomPoint) -> Double { p.x }

pub fn som_point_y(p : SomPoint) -> Double { p.y }

pub fn som_point_label(p : SomPoint) -> Int { p.label }

pub fn som_point_dist(a : SomPoint, b : SomPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn som_point_add(a : SomPoint, b : SomPoint) -> SomPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn som_point_sub(a : SomPoint, b : SomPoint) -> SomPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn som_point_scale(pt : SomPoint, s : Double) -> SomPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn som_point_dot(a : SomPoint, b : SomPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn som_point_norm(pt : SomPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn som_point_to_string(pt : SomPoint) -> String {
  "(" + som_dbl(pt.x) + ", " + som_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct SomSeries {
  vals : Array[Double]
  name : String
}

pub fn som_make_series(vals : Array[Double], name : String) -> SomSeries {
  { vals, name }
}

pub fn som_series_len(s : SomSeries) -> Int { s.vals.length() }

pub fn som_series_sum(s : SomSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn som_series_mean(s : SomSeries) -> Double {
  let n = som_series_len(s)
  if n == 0 { 0.0 } else { som_series_sum(s) / n.to_double() }
}

pub fn som_series_min(s : SomSeries) -> Double {
  let n = som_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn som_series_max(s : SomSeries) -> Double {
  let n = som_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn som_series_var(s : SomSeries) -> Double {
  let n = som_series_len(s)
  if n == 0 { 0.0 } else {
    let m = som_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn som_series_std(s : SomSeries) -> Double { @_common.sqrt(som_series_var(s)) }

pub fn som_series_scale(s : SomSeries, f : Double) -> SomSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = som_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn som_series_add(a : SomSeries, b : SomSeries) -> SomSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = som_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn som_series_to_string(s : SomSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + som_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct SomMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn som_make_matrix(rows : Int, cols : Int, val : Double) -> SomMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn som_matrix_identity(n : Int) -> SomMatrix {
  let m = som_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn som_matrix_get(m : SomMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn som_matrix_transpose(m : SomMatrix) -> SomMatrix {
  let result = som_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn som_matrix_add(a : SomMatrix, b : SomMatrix) -> SomMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = som_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn som_matrix_scale(m : SomMatrix, s : Double) -> SomMatrix {
  let result = som_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn som_matrix_multiply(a : SomMatrix, b : SomMatrix) -> SomMatrix {
  if a.cols != b.rows { return som_make_matrix(a.rows, b.cols, 0.0) }
  let result = som_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn som_matrix_trace(m : SomMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn som_matrix_norm(m : SomMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn som_matrix_to_string(m : SomMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + som_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct SomVector {
  comps : Array[Double]
  dim : Int
}

pub fn som_make_vector(comps : Array[Double]) -> SomVector {
  { comps, dim: comps.length() }
}

pub fn som_vector_zero(dim : Int) -> SomVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn som_vector_add(a : SomVector, b : SomVector) -> SomVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = som_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn som_vector_sub(a : SomVector, b : SomVector) -> SomVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = som_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn som_vector_scale(v : SomVector, s : Double) -> SomVector {
  let mut result = []
  for i in 0..<v.dim { result = som_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn som_vector_dot(a : SomVector, b : SomVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn som_vector_norm(v : SomVector) -> Double { @_common.sqrt(som_vector_dot(v, v)) }

pub fn som_vector_normalize(v : SomVector) -> SomVector {
  let n = som_vector_norm(v)
  if n < 0.0000001 { v } else { som_vector_scale(v, 1.0 / n) }
}

pub fn som_vector_dist(a : SomVector, b : SomVector) -> Double {
  som_vector_norm(som_vector_sub(a, b))
}

pub fn som_vector_to_string(v : SomVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + som_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn som_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn som_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = som_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn som_std(data : Array[Double]) -> Double { @_common.sqrt(som_var(data)) }

pub fn som_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = som_mean(a); let mb = som_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn som_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = som_std(a); let sb = som_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { som_cov(a, b) / (sa * sb) }
}

pub fn som_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn som_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn som_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn som_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = som_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn som_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn som_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn som_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = som_precision(pred, labels, pos); let r = som_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn som_dbl(x : Double) -> String {
  let i = if x >= 0.0 { som_int(x) } else { -som_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { som_int(f * 1000000.0) } else { som_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn som_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn som_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
