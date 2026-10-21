///===
/// dataobject/graph_store
/// S13.167 new

pub struct Graph_storePoint {
  x : Double
  y : Double
  label : Int
}

pub fn graph_store_make_point(x : Double, y : Double) -> Graph_storePoint {
  { x, y, label: 0 }
}

pub fn graph_store_make_labeled_point(x : Double, y : Double, label : Int) -> Graph_storePoint {
  { x, y, label }
}

pub fn graph_store_point_x(p : Graph_storePoint) -> Double { p.x }

pub fn graph_store_point_y(p : Graph_storePoint) -> Double { p.y }

pub fn graph_store_point_label(p : Graph_storePoint) -> Int { p.label }

pub fn graph_store_point_dist(a : Graph_storePoint, b : Graph_storePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn graph_store_point_add(a : Graph_storePoint, b : Graph_storePoint) -> Graph_storePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn graph_store_point_sub(a : Graph_storePoint, b : Graph_storePoint) -> Graph_storePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn graph_store_point_scale(pt : Graph_storePoint, s : Double) -> Graph_storePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn graph_store_point_dot(a : Graph_storePoint, b : Graph_storePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn graph_store_point_norm(pt : Graph_storePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn graph_store_point_to_string(pt : Graph_storePoint) -> String {
  "(" + graph_store_dbl(pt.x) + ", " + graph_store_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Graph_storeSeries {
  vals : Array[Double]
  name : String
}

pub fn graph_store_make_series(vals : Array[Double], name : String) -> Graph_storeSeries {
  { vals, name }
}

pub fn graph_store_series_len(s : Graph_storeSeries) -> Int { s.vals.length() }

pub fn graph_store_series_sum(s : Graph_storeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_store_series_mean(s : Graph_storeSeries) -> Double {
  let n = graph_store_series_len(s)
  if n == 0 { 0.0 } else { graph_store_series_sum(s) / n.to_double() }
}

pub fn graph_store_series_min(s : Graph_storeSeries) -> Double {
  let n = graph_store_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_store_series_max(s : Graph_storeSeries) -> Double {
  let n = graph_store_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_store_series_var(s : Graph_storeSeries) -> Double {
  let n = graph_store_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_store_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_store_series_std(s : Graph_storeSeries) -> Double { @_common.sqrt(graph_store_series_var(s)) }

pub fn graph_store_series_scale(s : Graph_storeSeries, f : Double) -> Graph_storeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_store_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn graph_store_series_add(a : Graph_storeSeries, b : Graph_storeSeries) -> Graph_storeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_store_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn graph_store_series_to_string(s : Graph_storeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_store_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Graph_storeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_store_make_matrix(rows : Int, cols : Int, val : Double) -> Graph_storeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_store_matrix_identity(n : Int) -> Graph_storeMatrix {
  let m = graph_store_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_store_matrix_get(m : Graph_storeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_store_matrix_transpose(m : Graph_storeMatrix) -> Graph_storeMatrix {
  let result = graph_store_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_store_matrix_add(a : Graph_storeMatrix, b : Graph_storeMatrix) -> Graph_storeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_store_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_store_matrix_scale(m : Graph_storeMatrix, s : Double) -> Graph_storeMatrix {
  let result = graph_store_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_store_matrix_multiply(a : Graph_storeMatrix, b : Graph_storeMatrix) -> Graph_storeMatrix {
  if a.cols != b.rows { return graph_store_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_store_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_store_matrix_trace(m : Graph_storeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_store_matrix_norm(m : Graph_storeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_store_matrix_to_string(m : Graph_storeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_store_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Graph_storeVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_store_make_vector(comps : Array[Double]) -> Graph_storeVector {
  { comps, dim: comps.length() }
}

pub fn graph_store_vector_zero(dim : Int) -> Graph_storeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_store_vector_add(a : Graph_storeVector, b : Graph_storeVector) -> Graph_storeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_store_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_store_vector_sub(a : Graph_storeVector, b : Graph_storeVector) -> Graph_storeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_store_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_store_vector_scale(v : Graph_storeVector, s : Double) -> Graph_storeVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_store_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_store_vector_dot(a : Graph_storeVector, b : Graph_storeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_store_vector_norm(v : Graph_storeVector) -> Double { @_common.sqrt(graph_store_vector_dot(v, v)) }

pub fn graph_store_vector_normalize(v : Graph_storeVector) -> Graph_storeVector {
  let n = graph_store_vector_norm(v)
  if n < 0.0000001 { v } else { graph_store_vector_scale(v, 1.0 / n) }
}

pub fn graph_store_vector_dist(a : Graph_storeVector, b : Graph_storeVector) -> Double {
  graph_store_vector_norm(graph_store_vector_sub(a, b))
}

pub fn graph_store_vector_to_string(v : Graph_storeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_store_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_store_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_store_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_store_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_store_std(data : Array[Double]) -> Double { @_common.sqrt(graph_store_var(data)) }

pub fn graph_store_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_store_mean(a); let mb = graph_store_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_store_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_store_std(a); let sb = graph_store_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_store_cov(a, b) / (sa * sb) }
}

pub fn graph_store_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_store_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_store_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_store_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_store_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_store_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_store_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_store_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_store_precision(pred, labels, pos); let r = graph_store_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn graph_store_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_store_int(x) } else { -graph_store_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_store_int(f * 1000000.0) } else { graph_store_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_store_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_store_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
