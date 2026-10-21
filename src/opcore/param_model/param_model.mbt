///===
/// opcore/param_model
/// S13.18 new

pub struct Param_modelPoint {
  x : Double
  y : Double
  label : Int
}

pub fn param_model_make_point(x : Double, y : Double) -> Param_modelPoint {
  { x, y, label: 0 }
}

pub fn param_model_make_labeled_point(x : Double, y : Double, label : Int) -> Param_modelPoint {
  { x, y, label }
}

pub fn param_model_point_x(p : Param_modelPoint) -> Double { p.x }

pub fn param_model_point_y(p : Param_modelPoint) -> Double { p.y }

pub fn param_model_point_label(p : Param_modelPoint) -> Int { p.label }

pub fn param_model_point_dist(a : Param_modelPoint, b : Param_modelPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn param_model_point_add(a : Param_modelPoint, b : Param_modelPoint) -> Param_modelPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn param_model_point_sub(a : Param_modelPoint, b : Param_modelPoint) -> Param_modelPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn param_model_point_scale(pt : Param_modelPoint, s : Double) -> Param_modelPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn param_model_point_dot(a : Param_modelPoint, b : Param_modelPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn param_model_point_norm(pt : Param_modelPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn param_model_point_to_string(pt : Param_modelPoint) -> String {
  "(" + param_model_dbl(pt.x) + ", " + param_model_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Param_modelSeries {
  vals : Array[Double]
  name : String
}

pub fn param_model_make_series(vals : Array[Double], name : String) -> Param_modelSeries {
  { vals, name }
}

pub fn param_model_series_len(s : Param_modelSeries) -> Int { s.vals.length() }

pub fn param_model_series_sum(s : Param_modelSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn param_model_series_mean(s : Param_modelSeries) -> Double {
  let n = param_model_series_len(s)
  if n == 0 { 0.0 } else { param_model_series_sum(s) / n.to_double() }
}

pub fn param_model_series_min(s : Param_modelSeries) -> Double {
  let n = param_model_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn param_model_series_max(s : Param_modelSeries) -> Double {
  let n = param_model_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn param_model_series_var(s : Param_modelSeries) -> Double {
  let n = param_model_series_len(s)
  if n == 0 { 0.0 } else {
    let m = param_model_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn param_model_series_std(s : Param_modelSeries) -> Double { @_common.sqrt(param_model_series_var(s)) }

pub fn param_model_series_scale(s : Param_modelSeries, f : Double) -> Param_modelSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = param_model_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn param_model_series_add(a : Param_modelSeries, b : Param_modelSeries) -> Param_modelSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = param_model_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn param_model_series_to_string(s : Param_modelSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + param_model_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Param_modelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn param_model_make_matrix(rows : Int, cols : Int, val : Double) -> Param_modelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn param_model_matrix_identity(n : Int) -> Param_modelMatrix {
  let m = param_model_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn param_model_matrix_get(m : Param_modelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn param_model_matrix_transpose(m : Param_modelMatrix) -> Param_modelMatrix {
  let result = param_model_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn param_model_matrix_add(a : Param_modelMatrix, b : Param_modelMatrix) -> Param_modelMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = param_model_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn param_model_matrix_scale(m : Param_modelMatrix, s : Double) -> Param_modelMatrix {
  let result = param_model_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn param_model_matrix_multiply(a : Param_modelMatrix, b : Param_modelMatrix) -> Param_modelMatrix {
  if a.cols != b.rows { return param_model_make_matrix(a.rows, b.cols, 0.0) }
  let result = param_model_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn param_model_matrix_trace(m : Param_modelMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn param_model_matrix_norm(m : Param_modelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn param_model_matrix_to_string(m : Param_modelMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + param_model_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Param_modelVector {
  comps : Array[Double]
  dim : Int
}

pub fn param_model_make_vector(comps : Array[Double]) -> Param_modelVector {
  { comps, dim: comps.length() }
}

pub fn param_model_vector_zero(dim : Int) -> Param_modelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn param_model_vector_add(a : Param_modelVector, b : Param_modelVector) -> Param_modelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = param_model_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn param_model_vector_sub(a : Param_modelVector, b : Param_modelVector) -> Param_modelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = param_model_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn param_model_vector_scale(v : Param_modelVector, s : Double) -> Param_modelVector {
  let mut result = []
  for i in 0..<v.dim { result = param_model_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn param_model_vector_dot(a : Param_modelVector, b : Param_modelVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn param_model_vector_norm(v : Param_modelVector) -> Double { @_common.sqrt(param_model_vector_dot(v, v)) }

pub fn param_model_vector_normalize(v : Param_modelVector) -> Param_modelVector {
  let n = param_model_vector_norm(v)
  if n < 0.0000001 { v } else { param_model_vector_scale(v, 1.0 / n) }
}

pub fn param_model_vector_dist(a : Param_modelVector, b : Param_modelVector) -> Double {
  param_model_vector_norm(param_model_vector_sub(a, b))
}

pub fn param_model_vector_to_string(v : Param_modelVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + param_model_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn param_model_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn param_model_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = param_model_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn param_model_std(data : Array[Double]) -> Double { @_common.sqrt(param_model_var(data)) }

pub fn param_model_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = param_model_mean(a); let mb = param_model_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn param_model_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = param_model_std(a); let sb = param_model_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { param_model_cov(a, b) / (sa * sb) }
}

pub fn param_model_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn param_model_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn param_model_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn param_model_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = param_model_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn param_model_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn param_model_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn param_model_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = param_model_precision(pred, labels, pos); let r = param_model_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn param_model_dbl(x : Double) -> String {
  let i = if x >= 0.0 { param_model_int(x) } else { -param_model_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { param_model_int(f * 1000000.0) } else { param_model_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn param_model_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn param_model_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
