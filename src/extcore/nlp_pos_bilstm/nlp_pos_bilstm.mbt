///===
/// extcore/nlp_pos_bilstm

pub(all) struct NlpposbilstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_bilstm_make_point(x : Double, y : Double) -> NlpposbilstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_bilstm_make_point3(x : Double, y : Double, z : Double) -> NlpposbilstmPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_bilstm_point_x(pt : NlpposbilstmPoint) -> Double { pt.x }

pub fn nlp_pos_bilstm_point_y(pt : NlpposbilstmPoint) -> Double { pt.y }

pub fn nlp_pos_bilstm_point_z(pt : NlpposbilstmPoint) -> Double { pt.z }

pub fn nlp_pos_bilstm_point_label(pt : NlpposbilstmPoint) -> Int { pt.label }

pub fn nlp_pos_bilstm_point_dist(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_pos_bilstm_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_bilstm_point_add(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_bilstm_point_sub(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_bilstm_point_scale(pt : NlpposbilstmPoint, s : Double) -> NlpposbilstmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_bilstm_point_dot(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_bilstm_point_cross(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_bilstm_point_norm(pt : NlpposbilstmPoint) -> Double {
  nlp_pos_bilstm_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_bilstm_point_normalize(pt : NlpposbilstmPoint) -> NlpposbilstmPoint {
  let n = nlp_pos_bilstm_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_bilstm_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_bilstm_point_negate(pt : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_bilstm_point_mid(a : NlpposbilstmPoint, b : NlpposbilstmPoint) -> NlpposbilstmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_bilstm_point_lerp(a : NlpposbilstmPoint, b : NlpposbilstmPoint, t : Double) -> NlpposbilstmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_bilstm_point_to_string(pt : NlpposbilstmPoint) -> String {
  "(" + nlp_pos_bilstm_dbl(pt.x) + ", " + nlp_pos_bilstm_dbl(pt.y) + ", " + nlp_pos_bilstm_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpposbilstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_bilstm_make_series(vals : Array[Double], name : String) -> NlpposbilstmSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_bilstm_series_len(s : NlpposbilstmSeries) -> Int { s.vals.length() }

pub fn nlp_pos_bilstm_series_sum(s : NlpposbilstmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_pos_bilstm_series_mean(s : NlpposbilstmSeries) -> Double {
  let n = nlp_pos_bilstm_series_len(s)
  if n == 0 { 0.0 } else { nlp_pos_bilstm_series_sum(s) / n.to_double() }
}

pub fn nlp_pos_bilstm_series_min(s : NlpposbilstmSeries) -> Double {
  let n = nlp_pos_bilstm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_series_max(s : NlpposbilstmSeries) -> Double {
  let n = nlp_pos_bilstm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_series_range(s : NlpposbilstmSeries) -> Double {
  nlp_pos_bilstm_series_max(s) - nlp_pos_bilstm_series_min(s)
}

pub fn nlp_pos_bilstm_series_var(s : NlpposbilstmSeries) -> Double {
  let n = nlp_pos_bilstm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_pos_bilstm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_pos_bilstm_series_std(s : NlpposbilstmSeries) -> Double { nlp_pos_bilstm_sqrt(nlp_pos_bilstm_series_var(s)) }

pub fn nlp_pos_bilstm_series_median(s : NlpposbilstmSeries) -> Double {
  let n = nlp_pos_bilstm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_bilstm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_bilstm_series_scale(s : NlpposbilstmSeries, f : Double) -> NlpposbilstmSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_pos_bilstm_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_bilstm_series_add(a : NlpposbilstmSeries, b : NlpposbilstmSeries) -> NlpposbilstmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_pos_bilstm_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_bilstm_series_sub(a : NlpposbilstmSeries, b : NlpposbilstmSeries) -> NlpposbilstmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_pos_bilstm_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_bilstm_series_normalize(s : NlpposbilstmSeries) -> NlpposbilstmSeries {
  let mn = nlp_pos_bilstm_series_min(s)
  let mx = nlp_pos_bilstm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_pos_bilstm_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_bilstm_series_cumsum(s : NlpposbilstmSeries) -> NlpposbilstmSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_pos_bilstm_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_bilstm_series_to_string(s : NlpposbilstmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_pos_bilstm_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposbilstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_bilstm_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposbilstmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_bilstm_matrix_identity(n : Int) -> NlpposbilstmMatrix {
  let m = nlp_pos_bilstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_bilstm_matrix_get(m : NlpposbilstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_bilstm_matrix_transpose(m : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  let result = nlp_pos_bilstm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_bilstm_matrix_add(a : NlpposbilstmMatrix, b : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_bilstm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_bilstm_matrix_scale(m : NlpposbilstmMatrix, s : Double) -> NlpposbilstmMatrix {
  let result = nlp_pos_bilstm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_bilstm_matrix_multiply(a : NlpposbilstmMatrix, b : NlpposbilstmMatrix) -> NlpposbilstmMatrix {
  if a.cols != b.rows { return nlp_pos_bilstm_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_bilstm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_bilstm_matrix_trace(m : NlpposbilstmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_bilstm_matrix_det(m : NlpposbilstmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_bilstm_matrix_norm(m : NlpposbilstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_pos_bilstm_sqrt(sum)
}

pub fn nlp_pos_bilstm_matrix_to_string(m : NlpposbilstmMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_pos_bilstm_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlpposbilstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_bilstm_make_vector(comps : Array[Double]) -> NlpposbilstmVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_bilstm_vector_zero(dim : Int) -> NlpposbilstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_bilstm_vector_add(a : NlpposbilstmVector, b : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_pos_bilstm_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_bilstm_vector_sub(a : NlpposbilstmVector, b : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_pos_bilstm_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_bilstm_vector_scale(v : NlpposbilstmVector, s : Double) -> NlpposbilstmVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_pos_bilstm_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_bilstm_vector_dot(a : NlpposbilstmVector, b : NlpposbilstmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_bilstm_vector_norm(v : NlpposbilstmVector) -> Double { nlp_pos_bilstm_sqrt(nlp_pos_bilstm_vector_dot(v, v)) }

pub fn nlp_pos_bilstm_vector_normalize(v : NlpposbilstmVector) -> NlpposbilstmVector {
  let n = nlp_pos_bilstm_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_bilstm_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_bilstm_vector_dist(a : NlpposbilstmVector, b : NlpposbilstmVector) -> Double {
  nlp_pos_bilstm_vector_norm(nlp_pos_bilstm_vector_sub(a, b))
}

pub fn nlp_pos_bilstm_vector_to_string(v : NlpposbilstmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_pos_bilstm_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_bilstm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_pos_bilstm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_pos_bilstm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_bilstm_std(data : Array[Double]) -> Double { nlp_pos_bilstm_sqrt(nlp_pos_bilstm_var(data)) }

pub fn nlp_pos_bilstm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_pos_bilstm_mean(a); let mb = nlp_pos_bilstm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_bilstm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_pos_bilstm_std(a); let sb = nlp_pos_bilstm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_pos_bilstm_cov(a, b) / (sa * sb) }
}

pub fn nlp_pos_bilstm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_bilstm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_bilstm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_pos_bilstm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_bilstm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_pos_bilstm_sqrt(nlp_pos_bilstm_mse(pred, labels))
}

pub fn nlp_pos_bilstm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_pos_bilstm_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_bilstm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_pos_bilstm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_pos_bilstm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_pos_bilstm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_pos_bilstm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_pos_bilstm_precision(pred, labels, pos); let r = nlp_pos_bilstm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_pos_bilstm_sort(arr : Array[Double]) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  for i in 0..<n {
    let mut min_idx = i
    let start = i + 1
    for j in start..<n { if result[j] < result[min_idx] { min_idx = j } }
    let tmp = result[i]; result[i] = result[min_idx]; result[min_idx] = tmp
  }
  result
}

pub fn nlp_pos_bilstm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_pos_bilstm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_pos_bilstm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_pos_bilstm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_pos_bilstm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_pos_bilstm_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_pos_bilstm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_pos_bilstm_fibonacci(n : Int) -> Int {
  if n < 2 {
    n
  } else {
    let mut a = 0
    let mut b = 1
    let end = n + 1
    for _ in 2..<end {
      let c = a + b
      a = b
      b = c
    }
    b
  }
}

pub fn nlp_pos_bilstm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_pos_bilstm_min(data); let mx = nlp_pos_bilstm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_pos_bilstm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_pos_bilstm_mean(data); let sd = nlp_pos_bilstm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_pos_bilstm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_pos_bilstm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_pos_bilstm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_pos_bilstm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_pos_bilstm_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_pos_bilstm_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_pos_bilstm_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_pos_bilstm_int(x) } else { -nlp_pos_bilstm_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_pos_bilstm_int(f * 1000000.0) } else { nlp_pos_bilstm_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_pos_bilstm_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_pos_bilstm_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlpposbilstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_frame_make(size : Int) -> NlpposbilstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_frame_len(s : NlpposbilstmFrame) -> Int { s.size }

pub fn nlp_pos_bilstm_frame_get(s : NlpposbilstmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_frame_set(s : NlpposbilstmFrame, i : Int, v : Double) -> NlpposbilstmFrame {
  let result = nlp_pos_bilstm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_frame_sum(s : NlpposbilstmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_frame_mean(s : NlpposbilstmFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_frame_scale(s : NlpposbilstmFrame, f : Double) -> NlpposbilstmFrame {
  let result = nlp_pos_bilstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_frame_add(a : NlpposbilstmFrame, b : NlpposbilstmFrame) -> NlpposbilstmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_frame_copy(s : NlpposbilstmFrame) -> NlpposbilstmFrame {
  let result = nlp_pos_bilstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_frame_fill(s : NlpposbilstmFrame, v : Double) -> NlpposbilstmFrame {
  let result = nlp_pos_bilstm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_frame_min(s : NlpposbilstmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_frame_max(s : NlpposbilstmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_frame_to_string(s : NlpposbilstmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_table_make(size : Int) -> NlpposbilstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_table_len(s : NlpposbilstmTable) -> Int { s.size }

pub fn nlp_pos_bilstm_table_get(s : NlpposbilstmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_table_set(s : NlpposbilstmTable, i : Int, v : Double) -> NlpposbilstmTable {
  let result = nlp_pos_bilstm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_table_sum(s : NlpposbilstmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_table_mean(s : NlpposbilstmTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_table_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_table_scale(s : NlpposbilstmTable, f : Double) -> NlpposbilstmTable {
  let result = nlp_pos_bilstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_table_add(a : NlpposbilstmTable, b : NlpposbilstmTable) -> NlpposbilstmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_table_copy(s : NlpposbilstmTable) -> NlpposbilstmTable {
  let result = nlp_pos_bilstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_table_fill(s : NlpposbilstmTable, v : Double) -> NlpposbilstmTable {
  let result = nlp_pos_bilstm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_table_min(s : NlpposbilstmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_table_max(s : NlpposbilstmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_table_to_string(s : NlpposbilstmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_graphn_make(size : Int) -> NlpposbilstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_graphn_len(s : NlpposbilstmGraphN) -> Int { s.size }

pub fn nlp_pos_bilstm_graphn_get(s : NlpposbilstmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_graphn_set(s : NlpposbilstmGraphN, i : Int, v : Double) -> NlpposbilstmGraphN {
  let result = nlp_pos_bilstm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_graphn_sum(s : NlpposbilstmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_graphn_mean(s : NlpposbilstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_graphn_scale(s : NlpposbilstmGraphN, f : Double) -> NlpposbilstmGraphN {
  let result = nlp_pos_bilstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_graphn_add(a : NlpposbilstmGraphN, b : NlpposbilstmGraphN) -> NlpposbilstmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_graphn_copy(s : NlpposbilstmGraphN) -> NlpposbilstmGraphN {
  let result = nlp_pos_bilstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_graphn_fill(s : NlpposbilstmGraphN, v : Double) -> NlpposbilstmGraphN {
  let result = nlp_pos_bilstm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_graphn_min(s : NlpposbilstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_graphn_max(s : NlpposbilstmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_graphn_to_string(s : NlpposbilstmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_node_make(size : Int) -> NlpposbilstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_node_len(s : NlpposbilstmNode) -> Int { s.size }

pub fn nlp_pos_bilstm_node_get(s : NlpposbilstmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_node_set(s : NlpposbilstmNode, i : Int, v : Double) -> NlpposbilstmNode {
  let result = nlp_pos_bilstm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_node_sum(s : NlpposbilstmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_node_mean(s : NlpposbilstmNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_node_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_node_scale(s : NlpposbilstmNode, f : Double) -> NlpposbilstmNode {
  let result = nlp_pos_bilstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_node_add(a : NlpposbilstmNode, b : NlpposbilstmNode) -> NlpposbilstmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_node_copy(s : NlpposbilstmNode) -> NlpposbilstmNode {
  let result = nlp_pos_bilstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_node_fill(s : NlpposbilstmNode, v : Double) -> NlpposbilstmNode {
  let result = nlp_pos_bilstm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_node_min(s : NlpposbilstmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_node_max(s : NlpposbilstmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_node_to_string(s : NlpposbilstmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_edge_make(size : Int) -> NlpposbilstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_edge_len(s : NlpposbilstmEdge) -> Int { s.size }

pub fn nlp_pos_bilstm_edge_get(s : NlpposbilstmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_edge_set(s : NlpposbilstmEdge, i : Int, v : Double) -> NlpposbilstmEdge {
  let result = nlp_pos_bilstm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_edge_sum(s : NlpposbilstmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_edge_mean(s : NlpposbilstmEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_edge_scale(s : NlpposbilstmEdge, f : Double) -> NlpposbilstmEdge {
  let result = nlp_pos_bilstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_edge_add(a : NlpposbilstmEdge, b : NlpposbilstmEdge) -> NlpposbilstmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_edge_copy(s : NlpposbilstmEdge) -> NlpposbilstmEdge {
  let result = nlp_pos_bilstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_edge_fill(s : NlpposbilstmEdge, v : Double) -> NlpposbilstmEdge {
  let result = nlp_pos_bilstm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_edge_min(s : NlpposbilstmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_edge_max(s : NlpposbilstmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_edge_to_string(s : NlpposbilstmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_path_make(size : Int) -> NlpposbilstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_path_len(s : NlpposbilstmPath) -> Int { s.size }

pub fn nlp_pos_bilstm_path_get(s : NlpposbilstmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_path_set(s : NlpposbilstmPath, i : Int, v : Double) -> NlpposbilstmPath {
  let result = nlp_pos_bilstm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_path_sum(s : NlpposbilstmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_path_mean(s : NlpposbilstmPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_path_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_path_scale(s : NlpposbilstmPath, f : Double) -> NlpposbilstmPath {
  let result = nlp_pos_bilstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_path_add(a : NlpposbilstmPath, b : NlpposbilstmPath) -> NlpposbilstmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_path_copy(s : NlpposbilstmPath) -> NlpposbilstmPath {
  let result = nlp_pos_bilstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_path_fill(s : NlpposbilstmPath, v : Double) -> NlpposbilstmPath {
  let result = nlp_pos_bilstm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_path_min(s : NlpposbilstmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_path_max(s : NlpposbilstmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_path_to_string(s : NlpposbilstmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_cluster_make(size : Int) -> NlpposbilstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_cluster_len(s : NlpposbilstmCluster) -> Int { s.size }

pub fn nlp_pos_bilstm_cluster_get(s : NlpposbilstmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_cluster_set(s : NlpposbilstmCluster, i : Int, v : Double) -> NlpposbilstmCluster {
  let result = nlp_pos_bilstm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_cluster_sum(s : NlpposbilstmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_cluster_mean(s : NlpposbilstmCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_cluster_scale(s : NlpposbilstmCluster, f : Double) -> NlpposbilstmCluster {
  let result = nlp_pos_bilstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_cluster_add(a : NlpposbilstmCluster, b : NlpposbilstmCluster) -> NlpposbilstmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_cluster_copy(s : NlpposbilstmCluster) -> NlpposbilstmCluster {
  let result = nlp_pos_bilstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_cluster_fill(s : NlpposbilstmCluster, v : Double) -> NlpposbilstmCluster {
  let result = nlp_pos_bilstm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_cluster_min(s : NlpposbilstmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_cluster_max(s : NlpposbilstmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_cluster_to_string(s : NlpposbilstmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_model_make(size : Int) -> NlpposbilstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_model_len(s : NlpposbilstmModel) -> Int { s.size }

pub fn nlp_pos_bilstm_model_get(s : NlpposbilstmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_model_set(s : NlpposbilstmModel, i : Int, v : Double) -> NlpposbilstmModel {
  let result = nlp_pos_bilstm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_model_sum(s : NlpposbilstmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_model_mean(s : NlpposbilstmModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_model_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_model_scale(s : NlpposbilstmModel, f : Double) -> NlpposbilstmModel {
  let result = nlp_pos_bilstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_model_add(a : NlpposbilstmModel, b : NlpposbilstmModel) -> NlpposbilstmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_model_copy(s : NlpposbilstmModel) -> NlpposbilstmModel {
  let result = nlp_pos_bilstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_model_fill(s : NlpposbilstmModel, v : Double) -> NlpposbilstmModel {
  let result = nlp_pos_bilstm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_model_min(s : NlpposbilstmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_model_max(s : NlpposbilstmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_model_to_string(s : NlpposbilstmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_layer_make(size : Int) -> NlpposbilstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_layer_len(s : NlpposbilstmLayer) -> Int { s.size }

pub fn nlp_pos_bilstm_layer_get(s : NlpposbilstmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_layer_set(s : NlpposbilstmLayer, i : Int, v : Double) -> NlpposbilstmLayer {
  let result = nlp_pos_bilstm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_layer_sum(s : NlpposbilstmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_layer_mean(s : NlpposbilstmLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_layer_scale(s : NlpposbilstmLayer, f : Double) -> NlpposbilstmLayer {
  let result = nlp_pos_bilstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_layer_add(a : NlpposbilstmLayer, b : NlpposbilstmLayer) -> NlpposbilstmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_layer_copy(s : NlpposbilstmLayer) -> NlpposbilstmLayer {
  let result = nlp_pos_bilstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_layer_fill(s : NlpposbilstmLayer, v : Double) -> NlpposbilstmLayer {
  let result = nlp_pos_bilstm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_layer_min(s : NlpposbilstmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_layer_max(s : NlpposbilstmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_layer_to_string(s : NlpposbilstmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_buffer_make(size : Int) -> NlpposbilstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_buffer_len(s : NlpposbilstmBuffer) -> Int { s.size }

pub fn nlp_pos_bilstm_buffer_get(s : NlpposbilstmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_buffer_set(s : NlpposbilstmBuffer, i : Int, v : Double) -> NlpposbilstmBuffer {
  let result = nlp_pos_bilstm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_buffer_sum(s : NlpposbilstmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_buffer_mean(s : NlpposbilstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_buffer_scale(s : NlpposbilstmBuffer, f : Double) -> NlpposbilstmBuffer {
  let result = nlp_pos_bilstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_buffer_add(a : NlpposbilstmBuffer, b : NlpposbilstmBuffer) -> NlpposbilstmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_buffer_copy(s : NlpposbilstmBuffer) -> NlpposbilstmBuffer {
  let result = nlp_pos_bilstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_buffer_fill(s : NlpposbilstmBuffer, v : Double) -> NlpposbilstmBuffer {
  let result = nlp_pos_bilstm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_buffer_min(s : NlpposbilstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_buffer_max(s : NlpposbilstmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_buffer_to_string(s : NlpposbilstmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_cursor_make(size : Int) -> NlpposbilstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_cursor_len(s : NlpposbilstmCursor) -> Int { s.size }

pub fn nlp_pos_bilstm_cursor_get(s : NlpposbilstmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_cursor_set(s : NlpposbilstmCursor, i : Int, v : Double) -> NlpposbilstmCursor {
  let result = nlp_pos_bilstm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_cursor_sum(s : NlpposbilstmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_cursor_mean(s : NlpposbilstmCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_cursor_scale(s : NlpposbilstmCursor, f : Double) -> NlpposbilstmCursor {
  let result = nlp_pos_bilstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_cursor_add(a : NlpposbilstmCursor, b : NlpposbilstmCursor) -> NlpposbilstmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_cursor_copy(s : NlpposbilstmCursor) -> NlpposbilstmCursor {
  let result = nlp_pos_bilstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_cursor_fill(s : NlpposbilstmCursor, v : Double) -> NlpposbilstmCursor {
  let result = nlp_pos_bilstm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_cursor_min(s : NlpposbilstmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_cursor_max(s : NlpposbilstmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_cursor_to_string(s : NlpposbilstmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_view_make(size : Int) -> NlpposbilstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_view_len(s : NlpposbilstmView) -> Int { s.size }

pub fn nlp_pos_bilstm_view_get(s : NlpposbilstmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_view_set(s : NlpposbilstmView, i : Int, v : Double) -> NlpposbilstmView {
  let result = nlp_pos_bilstm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_view_sum(s : NlpposbilstmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_view_mean(s : NlpposbilstmView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_view_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_view_scale(s : NlpposbilstmView, f : Double) -> NlpposbilstmView {
  let result = nlp_pos_bilstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_view_add(a : NlpposbilstmView, b : NlpposbilstmView) -> NlpposbilstmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_view_copy(s : NlpposbilstmView) -> NlpposbilstmView {
  let result = nlp_pos_bilstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_view_fill(s : NlpposbilstmView, v : Double) -> NlpposbilstmView {
  let result = nlp_pos_bilstm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_view_min(s : NlpposbilstmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_view_max(s : NlpposbilstmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_view_to_string(s : NlpposbilstmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_range_make(size : Int) -> NlpposbilstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_range_len(s : NlpposbilstmRange) -> Int { s.size }

pub fn nlp_pos_bilstm_range_get(s : NlpposbilstmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_range_set(s : NlpposbilstmRange, i : Int, v : Double) -> NlpposbilstmRange {
  let result = nlp_pos_bilstm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_range_sum(s : NlpposbilstmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_range_mean(s : NlpposbilstmRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_range_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_range_scale(s : NlpposbilstmRange, f : Double) -> NlpposbilstmRange {
  let result = nlp_pos_bilstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_range_add(a : NlpposbilstmRange, b : NlpposbilstmRange) -> NlpposbilstmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_range_copy(s : NlpposbilstmRange) -> NlpposbilstmRange {
  let result = nlp_pos_bilstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_range_fill(s : NlpposbilstmRange, v : Double) -> NlpposbilstmRange {
  let result = nlp_pos_bilstm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_range_min(s : NlpposbilstmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_range_max(s : NlpposbilstmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_range_to_string(s : NlpposbilstmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposbilstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_bilstm_slice_make(size : Int) -> NlpposbilstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_bilstm_slice_len(s : NlpposbilstmSlice) -> Int { s.size }

pub fn nlp_pos_bilstm_slice_get(s : NlpposbilstmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_bilstm_slice_set(s : NlpposbilstmSlice, i : Int, v : Double) -> NlpposbilstmSlice {
  let result = nlp_pos_bilstm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_slice_sum(s : NlpposbilstmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_bilstm_slice_mean(s : NlpposbilstmSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_bilstm_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_bilstm_slice_scale(s : NlpposbilstmSlice, f : Double) -> NlpposbilstmSlice {
  let result = nlp_pos_bilstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_bilstm_slice_add(a : NlpposbilstmSlice, b : NlpposbilstmSlice) -> NlpposbilstmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_bilstm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_bilstm_slice_copy(s : NlpposbilstmSlice) -> NlpposbilstmSlice {
  let result = nlp_pos_bilstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_bilstm_slice_fill(s : NlpposbilstmSlice, v : Double) -> NlpposbilstmSlice {
  let result = nlp_pos_bilstm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_bilstm_slice_min(s : NlpposbilstmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_slice_max(s : NlpposbilstmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_bilstm_slice_to_string(s : NlpposbilstmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_pos_bilstm_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_pos_bilstm_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

