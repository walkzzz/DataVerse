///===
/// agent_kit/desire_model
/// S13.121 new

pub struct Desire_modelPoint {
  x : Double
  y : Double
  label : Int
}

pub fn desire_model_make_point(x : Double, y : Double) -> Desire_modelPoint {
  { x, y, label: 0 }
}

pub fn desire_model_make_labeled_point(x : Double, y : Double, label : Int) -> Desire_modelPoint {
  { x, y, label }
}

pub fn desire_model_point_x(p : Desire_modelPoint) -> Double { p.x }

pub fn desire_model_point_y(p : Desire_modelPoint) -> Double { p.y }

pub fn desire_model_point_label(p : Desire_modelPoint) -> Int { p.label }

pub fn desire_model_point_dist(a : Desire_modelPoint, b : Desire_modelPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn desire_model_point_add(a : Desire_modelPoint, b : Desire_modelPoint) -> Desire_modelPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn desire_model_point_sub(a : Desire_modelPoint, b : Desire_modelPoint) -> Desire_modelPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn desire_model_point_scale(pt : Desire_modelPoint, s : Double) -> Desire_modelPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn desire_model_point_dot(a : Desire_modelPoint, b : Desire_modelPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn desire_model_point_norm(pt : Desire_modelPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn desire_model_point_to_string(pt : Desire_modelPoint) -> String {
  "(" + desire_model_dbl(pt.x) + ", " + desire_model_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Desire_modelSeries {
  vals : Array[Double]
  name : String
}

pub fn desire_model_make_series(vals : Array[Double], name : String) -> Desire_modelSeries {
  { vals, name }
}

pub fn desire_model_series_len(s : Desire_modelSeries) -> Int { s.vals.length() }

pub fn desire_model_series_sum(s : Desire_modelSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn desire_model_series_mean(s : Desire_modelSeries) -> Double {
  let n = desire_model_series_len(s)
  if n == 0 { 0.0 } else { desire_model_series_sum(s) / n.to_double() }
}

pub fn desire_model_series_min(s : Desire_modelSeries) -> Double {
  let n = desire_model_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn desire_model_series_max(s : Desire_modelSeries) -> Double {
  let n = desire_model_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn desire_model_series_var(s : Desire_modelSeries) -> Double {
  let n = desire_model_series_len(s)
  if n == 0 { 0.0 } else {
    let m = desire_model_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn desire_model_series_std(s : Desire_modelSeries) -> Double { @_common.sqrt(desire_model_series_var(s)) }

pub fn desire_model_series_scale(s : Desire_modelSeries, f : Double) -> Desire_modelSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = desire_model_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn desire_model_series_add(a : Desire_modelSeries, b : Desire_modelSeries) -> Desire_modelSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = desire_model_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn desire_model_series_to_string(s : Desire_modelSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + desire_model_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Desire_modelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn desire_model_make_matrix(rows : Int, cols : Int, val : Double) -> Desire_modelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn desire_model_matrix_identity(n : Int) -> Desire_modelMatrix {
  let m = desire_model_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn desire_model_matrix_get(m : Desire_modelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn desire_model_matrix_transpose(m : Desire_modelMatrix) -> Desire_modelMatrix {
  let result = desire_model_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn desire_model_matrix_add(a : Desire_modelMatrix, b : Desire_modelMatrix) -> Desire_modelMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = desire_model_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn desire_model_matrix_scale(m : Desire_modelMatrix, s : Double) -> Desire_modelMatrix {
  let result = desire_model_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn desire_model_matrix_multiply(a : Desire_modelMatrix, b : Desire_modelMatrix) -> Desire_modelMatrix {
  if a.cols != b.rows { return desire_model_make_matrix(a.rows, b.cols, 0.0) }
  let result = desire_model_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn desire_model_matrix_trace(m : Desire_modelMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn desire_model_matrix_norm(m : Desire_modelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn desire_model_matrix_to_string(m : Desire_modelMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + desire_model_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Desire_modelVector {
  comps : Array[Double]
  dim : Int
}

pub fn desire_model_make_vector(comps : Array[Double]) -> Desire_modelVector {
  { comps, dim: comps.length() }
}

pub fn desire_model_vector_zero(dim : Int) -> Desire_modelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn desire_model_vector_add(a : Desire_modelVector, b : Desire_modelVector) -> Desire_modelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = desire_model_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn desire_model_vector_sub(a : Desire_modelVector, b : Desire_modelVector) -> Desire_modelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = desire_model_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn desire_model_vector_scale(v : Desire_modelVector, s : Double) -> Desire_modelVector {
  let mut result = []
  for i in 0..<v.dim { result = desire_model_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn desire_model_vector_dot(a : Desire_modelVector, b : Desire_modelVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn desire_model_vector_norm(v : Desire_modelVector) -> Double { @_common.sqrt(desire_model_vector_dot(v, v)) }

pub fn desire_model_vector_normalize(v : Desire_modelVector) -> Desire_modelVector {
  let n = desire_model_vector_norm(v)
  if n < 0.0000001 { v } else { desire_model_vector_scale(v, 1.0 / n) }
}

pub fn desire_model_vector_dist(a : Desire_modelVector, b : Desire_modelVector) -> Double {
  desire_model_vector_norm(desire_model_vector_sub(a, b))
}

pub fn desire_model_vector_to_string(v : Desire_modelVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + desire_model_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn desire_model_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn desire_model_std(data : Array[Double]) -> Double { @_common.sqrt(desire_model_var(data)) }

pub fn desire_model_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn desire_model_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = desire_model_std(a); let sb = desire_model_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { desire_model_cov(a, b) / (sa * sb) }
}

pub fn desire_model_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn desire_model_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn desire_model_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn desire_model_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn desire_model_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn desire_model_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn desire_model_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = desire_model_precision(pred, labels, pos); let r = desire_model_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn desire_model_dbl(x : Double) -> String {
  let i = if x >= 0.0 { desire_model_int(x) } else { -desire_model_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { desire_model_int(f * 1000000.0) } else { desire_model_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn desire_model_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn desire_model_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
