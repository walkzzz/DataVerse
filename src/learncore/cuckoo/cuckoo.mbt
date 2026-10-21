///===
/// learncore/cuckoo
/// S13.76 new

pub struct CuckooPoint {
  x : Double
  y : Double
  label : Int
}

pub fn cuckoo_make_point(x : Double, y : Double) -> CuckooPoint {
  { x, y, label: 0 }
}

pub fn cuckoo_make_labeled_point(x : Double, y : Double, label : Int) -> CuckooPoint {
  { x, y, label }
}

pub fn cuckoo_point_x(p : CuckooPoint) -> Double { p.x }

pub fn cuckoo_point_y(p : CuckooPoint) -> Double { p.y }

pub fn cuckoo_point_label(p : CuckooPoint) -> Int { p.label }

pub fn cuckoo_point_dist(a : CuckooPoint, b : CuckooPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn cuckoo_point_add(a : CuckooPoint, b : CuckooPoint) -> CuckooPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn cuckoo_point_sub(a : CuckooPoint, b : CuckooPoint) -> CuckooPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn cuckoo_point_scale(pt : CuckooPoint, s : Double) -> CuckooPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn cuckoo_point_dot(a : CuckooPoint, b : CuckooPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn cuckoo_point_norm(pt : CuckooPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn cuckoo_point_to_string(pt : CuckooPoint) -> String {
  "(" + cuckoo_dbl(pt.x) + ", " + cuckoo_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct CuckooSeries {
  vals : Array[Double]
  name : String
}

pub fn cuckoo_make_series(vals : Array[Double], name : String) -> CuckooSeries {
  { vals, name }
}

pub fn cuckoo_series_len(s : CuckooSeries) -> Int { s.vals.length() }

pub fn cuckoo_series_sum(s : CuckooSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn cuckoo_series_mean(s : CuckooSeries) -> Double {
  let n = cuckoo_series_len(s)
  if n == 0 { 0.0 } else { cuckoo_series_sum(s) / n.to_double() }
}

pub fn cuckoo_series_min(s : CuckooSeries) -> Double {
  let n = cuckoo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn cuckoo_series_max(s : CuckooSeries) -> Double {
  let n = cuckoo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn cuckoo_series_var(s : CuckooSeries) -> Double {
  let n = cuckoo_series_len(s)
  if n == 0 { 0.0 } else {
    let m = cuckoo_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn cuckoo_series_std(s : CuckooSeries) -> Double { @_common.sqrt(cuckoo_series_var(s)) }

pub fn cuckoo_series_scale(s : CuckooSeries, f : Double) -> CuckooSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = cuckoo_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn cuckoo_series_add(a : CuckooSeries, b : CuckooSeries) -> CuckooSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = cuckoo_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn cuckoo_series_to_string(s : CuckooSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + cuckoo_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct CuckooMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn cuckoo_make_matrix(rows : Int, cols : Int, val : Double) -> CuckooMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn cuckoo_matrix_identity(n : Int) -> CuckooMatrix {
  let m = cuckoo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn cuckoo_matrix_get(m : CuckooMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn cuckoo_matrix_transpose(m : CuckooMatrix) -> CuckooMatrix {
  let result = cuckoo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn cuckoo_matrix_add(a : CuckooMatrix, b : CuckooMatrix) -> CuckooMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = cuckoo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn cuckoo_matrix_scale(m : CuckooMatrix, s : Double) -> CuckooMatrix {
  let result = cuckoo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn cuckoo_matrix_multiply(a : CuckooMatrix, b : CuckooMatrix) -> CuckooMatrix {
  if a.cols != b.rows { return cuckoo_make_matrix(a.rows, b.cols, 0.0) }
  let result = cuckoo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn cuckoo_matrix_trace(m : CuckooMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn cuckoo_matrix_norm(m : CuckooMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn cuckoo_matrix_to_string(m : CuckooMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + cuckoo_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct CuckooVector {
  comps : Array[Double]
  dim : Int
}

pub fn cuckoo_make_vector(comps : Array[Double]) -> CuckooVector {
  { comps, dim: comps.length() }
}

pub fn cuckoo_vector_zero(dim : Int) -> CuckooVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn cuckoo_vector_add(a : CuckooVector, b : CuckooVector) -> CuckooVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = cuckoo_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn cuckoo_vector_sub(a : CuckooVector, b : CuckooVector) -> CuckooVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = cuckoo_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn cuckoo_vector_scale(v : CuckooVector, s : Double) -> CuckooVector {
  let mut result = []
  for i in 0..<v.dim { result = cuckoo_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn cuckoo_vector_dot(a : CuckooVector, b : CuckooVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn cuckoo_vector_norm(v : CuckooVector) -> Double { @_common.sqrt(cuckoo_vector_dot(v, v)) }

pub fn cuckoo_vector_normalize(v : CuckooVector) -> CuckooVector {
  let n = cuckoo_vector_norm(v)
  if n < 0.0000001 { v } else { cuckoo_vector_scale(v, 1.0 / n) }
}

pub fn cuckoo_vector_dist(a : CuckooVector, b : CuckooVector) -> Double {
  cuckoo_vector_norm(cuckoo_vector_sub(a, b))
}

pub fn cuckoo_vector_to_string(v : CuckooVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + cuckoo_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn cuckoo_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn cuckoo_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = cuckoo_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn cuckoo_std(data : Array[Double]) -> Double { @_common.sqrt(cuckoo_var(data)) }

pub fn cuckoo_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = cuckoo_mean(a); let mb = cuckoo_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn cuckoo_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = cuckoo_std(a); let sb = cuckoo_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { cuckoo_cov(a, b) / (sa * sb) }
}

pub fn cuckoo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn cuckoo_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn cuckoo_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn cuckoo_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = cuckoo_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn cuckoo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn cuckoo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn cuckoo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = cuckoo_precision(pred, labels, pos); let r = cuckoo_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn cuckoo_dbl(x : Double) -> String {
  let i = if x >= 0.0 { cuckoo_int(x) } else { -cuckoo_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { cuckoo_int(f * 1000000.0) } else { cuckoo_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn cuckoo_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn cuckoo_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}
