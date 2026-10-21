///===
/// dataobject/block_store
/// S13.180 new

pub struct Block_storePoint {
  x : Double
  y : Double
  label : Int
}

pub fn block_store_make_point(x : Double, y : Double) -> Block_storePoint {
  { x, y, label: 0 }
}

pub fn block_store_make_labeled_point(x : Double, y : Double, label : Int) -> Block_storePoint {
  { x, y, label }
}

pub fn block_store_point_x(p : Block_storePoint) -> Double { p.x }

pub fn block_store_point_y(p : Block_storePoint) -> Double { p.y }

pub fn block_store_point_label(p : Block_storePoint) -> Int { p.label }

pub fn block_store_point_dist(a : Block_storePoint, b : Block_storePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn block_store_point_add(a : Block_storePoint, b : Block_storePoint) -> Block_storePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn block_store_point_sub(a : Block_storePoint, b : Block_storePoint) -> Block_storePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn block_store_point_scale(pt : Block_storePoint, s : Double) -> Block_storePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn block_store_point_dot(a : Block_storePoint, b : Block_storePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn block_store_point_norm(pt : Block_storePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn block_store_point_to_string(pt : Block_storePoint) -> String {
  "(" + block_store_dbl(pt.x) + ", " + block_store_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Block_storeSeries {
  vals : Array[Double]
  name : String
}

pub fn block_store_make_series(vals : Array[Double], name : String) -> Block_storeSeries {
  { vals, name }
}

pub fn block_store_series_len(s : Block_storeSeries) -> Int { s.vals.length() }

pub fn block_store_series_sum(s : Block_storeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn block_store_series_mean(s : Block_storeSeries) -> Double {
  let n = block_store_series_len(s)
  if n == 0 { 0.0 } else { block_store_series_sum(s) / n.to_double() }
}

pub fn block_store_series_min(s : Block_storeSeries) -> Double {
  let n = block_store_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn block_store_series_max(s : Block_storeSeries) -> Double {
  let n = block_store_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn block_store_series_var(s : Block_storeSeries) -> Double {
  let n = block_store_series_len(s)
  if n == 0 { 0.0 } else {
    let m = block_store_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn block_store_series_std(s : Block_storeSeries) -> Double { @_common.sqrt(block_store_series_var(s)) }

pub fn block_store_series_scale(s : Block_storeSeries, f : Double) -> Block_storeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = block_store_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn block_store_series_add(a : Block_storeSeries, b : Block_storeSeries) -> Block_storeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = block_store_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn block_store_series_to_string(s : Block_storeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + block_store_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Block_storeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn block_store_make_matrix(rows : Int, cols : Int, val : Double) -> Block_storeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn block_store_matrix_identity(n : Int) -> Block_storeMatrix {
  let m = block_store_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn block_store_matrix_get(m : Block_storeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn block_store_matrix_transpose(m : Block_storeMatrix) -> Block_storeMatrix {
  let result = block_store_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn block_store_matrix_add(a : Block_storeMatrix, b : Block_storeMatrix) -> Block_storeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = block_store_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn block_store_matrix_scale(m : Block_storeMatrix, s : Double) -> Block_storeMatrix {
  let result = block_store_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn block_store_matrix_multiply(a : Block_storeMatrix, b : Block_storeMatrix) -> Block_storeMatrix {
  if a.cols != b.rows { return block_store_make_matrix(a.rows, b.cols, 0.0) }
  let result = block_store_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn block_store_matrix_trace(m : Block_storeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn block_store_matrix_norm(m : Block_storeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn block_store_matrix_to_string(m : Block_storeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + block_store_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Block_storeVector {
  comps : Array[Double]
  dim : Int
}

pub fn block_store_make_vector(comps : Array[Double]) -> Block_storeVector {
  { comps, dim: comps.length() }
}

pub fn block_store_vector_zero(dim : Int) -> Block_storeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn block_store_vector_add(a : Block_storeVector, b : Block_storeVector) -> Block_storeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = block_store_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn block_store_vector_sub(a : Block_storeVector, b : Block_storeVector) -> Block_storeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = block_store_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn block_store_vector_scale(v : Block_storeVector, s : Double) -> Block_storeVector {
  let mut result = []
  for i in 0..<v.dim { result = block_store_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn block_store_vector_dot(a : Block_storeVector, b : Block_storeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn block_store_vector_norm(v : Block_storeVector) -> Double { @_common.sqrt(block_store_vector_dot(v, v)) }

pub fn block_store_vector_normalize(v : Block_storeVector) -> Block_storeVector {
  let n = block_store_vector_norm(v)
  if n < 0.0000001 { v } else { block_store_vector_scale(v, 1.0 / n) }
}

pub fn block_store_vector_dist(a : Block_storeVector, b : Block_storeVector) -> Double {
  block_store_vector_norm(block_store_vector_sub(a, b))
}

pub fn block_store_vector_to_string(v : Block_storeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + block_store_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn block_store_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn block_store_std(data : Array[Double]) -> Double { @_common.sqrt(block_store_var(data)) }

pub fn block_store_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn block_store_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = block_store_std(a); let sb = block_store_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { block_store_cov(a, b) / (sa * sb) }
}

pub fn block_store_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn block_store_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn block_store_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn block_store_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn block_store_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn block_store_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn block_store_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = block_store_precision(pred, labels, pos); let r = block_store_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn block_store_dbl(x : Double) -> String {
  let i = if x >= 0.0 { block_store_int(x) } else { -block_store_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { block_store_int(f * 1000000.0) } else { block_store_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn block_store_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn block_store_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
