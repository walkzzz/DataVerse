///===
/// dataobject/time_store
/// S13.171 new

pub struct Time_storePoint {
  x : Double
  y : Double
  label : Int
}

pub fn time_store_make_point(x : Double, y : Double) -> Time_storePoint {
  { x, y, label: 0 }
}

pub fn time_store_make_labeled_point(x : Double, y : Double, label : Int) -> Time_storePoint {
  { x, y, label }
}

pub fn time_store_point_x(p : Time_storePoint) -> Double { p.x }

pub fn time_store_point_y(p : Time_storePoint) -> Double { p.y }

pub fn time_store_point_label(p : Time_storePoint) -> Int { p.label }

pub fn time_store_point_dist(a : Time_storePoint, b : Time_storePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn time_store_point_add(a : Time_storePoint, b : Time_storePoint) -> Time_storePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn time_store_point_sub(a : Time_storePoint, b : Time_storePoint) -> Time_storePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn time_store_point_scale(pt : Time_storePoint, s : Double) -> Time_storePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn time_store_point_dot(a : Time_storePoint, b : Time_storePoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn time_store_point_norm(pt : Time_storePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn time_store_point_to_string(pt : Time_storePoint) -> String {
  "(" + time_store_dbl(pt.x) + ", " + time_store_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Time_storeSeries {
  vals : Array[Double]
  name : String
}

pub fn time_store_make_series(vals : Array[Double], name : String) -> Time_storeSeries {
  { vals, name }
}

pub fn time_store_series_len(s : Time_storeSeries) -> Int { s.vals.length() }

pub fn time_store_series_sum(s : Time_storeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn time_store_series_mean(s : Time_storeSeries) -> Double {
  let n = time_store_series_len(s)
  if n == 0 { 0.0 } else { time_store_series_sum(s) / n.to_double() }
}

pub fn time_store_series_min(s : Time_storeSeries) -> Double {
  let n = time_store_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn time_store_series_max(s : Time_storeSeries) -> Double {
  let n = time_store_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn time_store_series_var(s : Time_storeSeries) -> Double {
  let n = time_store_series_len(s)
  if n == 0 { 0.0 } else {
    let m = time_store_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn time_store_series_std(s : Time_storeSeries) -> Double { @_common.sqrt(time_store_series_var(s)) }

pub fn time_store_series_scale(s : Time_storeSeries, f : Double) -> Time_storeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = time_store_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn time_store_series_add(a : Time_storeSeries, b : Time_storeSeries) -> Time_storeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = time_store_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn time_store_series_to_string(s : Time_storeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + time_store_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Time_storeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn time_store_make_matrix(rows : Int, cols : Int, val : Double) -> Time_storeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn time_store_matrix_identity(n : Int) -> Time_storeMatrix {
  let m = time_store_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn time_store_matrix_get(m : Time_storeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn time_store_matrix_transpose(m : Time_storeMatrix) -> Time_storeMatrix {
  let result = time_store_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn time_store_matrix_add(a : Time_storeMatrix, b : Time_storeMatrix) -> Time_storeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = time_store_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn time_store_matrix_scale(m : Time_storeMatrix, s : Double) -> Time_storeMatrix {
  let result = time_store_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn time_store_matrix_multiply(a : Time_storeMatrix, b : Time_storeMatrix) -> Time_storeMatrix {
  if a.cols != b.rows { return time_store_make_matrix(a.rows, b.cols, 0.0) }
  let result = time_store_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn time_store_matrix_trace(m : Time_storeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn time_store_matrix_norm(m : Time_storeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn time_store_matrix_to_string(m : Time_storeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + time_store_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Time_storeVector {
  comps : Array[Double]
  dim : Int
}

pub fn time_store_make_vector(comps : Array[Double]) -> Time_storeVector {
  { comps, dim: comps.length() }
}

pub fn time_store_vector_zero(dim : Int) -> Time_storeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn time_store_vector_add(a : Time_storeVector, b : Time_storeVector) -> Time_storeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = time_store_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn time_store_vector_sub(a : Time_storeVector, b : Time_storeVector) -> Time_storeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = time_store_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn time_store_vector_scale(v : Time_storeVector, s : Double) -> Time_storeVector {
  let mut result = []
  for i in 0..<v.dim { result = time_store_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn time_store_vector_dot(a : Time_storeVector, b : Time_storeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn time_store_vector_norm(v : Time_storeVector) -> Double { @_common.sqrt(time_store_vector_dot(v, v)) }

pub fn time_store_vector_normalize(v : Time_storeVector) -> Time_storeVector {
  let n = time_store_vector_norm(v)
  if n < 0.0000001 { v } else { time_store_vector_scale(v, 1.0 / n) }
}

pub fn time_store_vector_dist(a : Time_storeVector, b : Time_storeVector) -> Double {
  time_store_vector_norm(time_store_vector_sub(a, b))
}

pub fn time_store_vector_to_string(v : Time_storeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + time_store_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn time_store_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn time_store_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = time_store_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn time_store_std(data : Array[Double]) -> Double { @_common.sqrt(time_store_var(data)) }

pub fn time_store_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = time_store_mean(a); let mb = time_store_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn time_store_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = time_store_std(a); let sb = time_store_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { time_store_cov(a, b) / (sa * sb) }
}

pub fn time_store_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn time_store_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn time_store_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn time_store_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = time_store_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn time_store_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn time_store_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn time_store_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = time_store_precision(pred, labels, pos); let r = time_store_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn time_store_dbl(x : Double) -> String {
  let i = if x >= 0.0 { time_store_int(x) } else { -time_store_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { time_store_int(f * 1000000.0) } else { time_store_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn time_store_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn time_store_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
