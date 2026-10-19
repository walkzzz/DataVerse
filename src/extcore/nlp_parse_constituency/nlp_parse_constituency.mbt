///===
/// extcore/nlp_parse_constituency

pub(all) struct NlpparseconstituencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_constituency_make_point(x : Double, y : Double) -> NlpparseconstituencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_constituency_make_point3(x : Double, y : Double, z : Double) -> NlpparseconstituencyPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_constituency_point_x(pt : NlpparseconstituencyPoint) -> Double { pt.x }

pub fn nlp_parse_constituency_point_y(pt : NlpparseconstituencyPoint) -> Double { pt.y }

pub fn nlp_parse_constituency_point_z(pt : NlpparseconstituencyPoint) -> Double { pt.z }

pub fn nlp_parse_constituency_point_label(pt : NlpparseconstituencyPoint) -> Int { pt.label }

pub fn nlp_parse_constituency_point_dist(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_parse_constituency_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_constituency_point_add(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_constituency_point_sub(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_constituency_point_scale(pt : NlpparseconstituencyPoint, s : Double) -> NlpparseconstituencyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_constituency_point_dot(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_constituency_point_cross(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_constituency_point_norm(pt : NlpparseconstituencyPoint) -> Double {
  nlp_parse_constituency_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_constituency_point_normalize(pt : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  let n = nlp_parse_constituency_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_constituency_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_constituency_point_negate(pt : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_constituency_point_mid(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_constituency_point_lerp(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint, t : Double) -> NlpparseconstituencyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_constituency_point_to_string(pt : NlpparseconstituencyPoint) -> String {
  "(" + nlp_parse_constituency_dbl(pt.x) + ", " + nlp_parse_constituency_dbl(pt.y) + ", " + nlp_parse_constituency_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparseconstituencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_constituency_make_series(vals : Array[Double], name : String) -> NlpparseconstituencySeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_constituency_series_len(s : NlpparseconstituencySeries) -> Int { s.vals.length() }

pub fn nlp_parse_constituency_series_sum(s : NlpparseconstituencySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_parse_constituency_series_mean(s : NlpparseconstituencySeries) -> Double {
  let n = nlp_parse_constituency_series_len(s)
  if n == 0 { 0.0 } else { nlp_parse_constituency_series_sum(s) / n.to_double() }
}

pub fn nlp_parse_constituency_series_min(s : NlpparseconstituencySeries) -> Double {
  let n = nlp_parse_constituency_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_constituency_series_max(s : NlpparseconstituencySeries) -> Double {
  let n = nlp_parse_constituency_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_constituency_series_range(s : NlpparseconstituencySeries) -> Double {
  nlp_parse_constituency_series_max(s) - nlp_parse_constituency_series_min(s)
}

pub fn nlp_parse_constituency_series_var(s : NlpparseconstituencySeries) -> Double {
  let n = nlp_parse_constituency_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_parse_constituency_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_parse_constituency_series_std(s : NlpparseconstituencySeries) -> Double { nlp_parse_constituency_sqrt(nlp_parse_constituency_series_var(s)) }

pub fn nlp_parse_constituency_series_median(s : NlpparseconstituencySeries) -> Double {
  let n = nlp_parse_constituency_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_constituency_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_constituency_series_scale(s : NlpparseconstituencySeries, f : Double) -> NlpparseconstituencySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_parse_constituency_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_constituency_series_add(a : NlpparseconstituencySeries, b : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_parse_constituency_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_constituency_series_sub(a : NlpparseconstituencySeries, b : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_parse_constituency_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_constituency_series_normalize(s : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let mn = nlp_parse_constituency_series_min(s)
  let mx = nlp_parse_constituency_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_parse_constituency_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_constituency_series_cumsum(s : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_parse_constituency_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_constituency_series_to_string(s : NlpparseconstituencySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_parse_constituency_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseconstituencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_constituency_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseconstituencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_constituency_matrix_identity(n : Int) -> NlpparseconstituencyMatrix {
  let m = nlp_parse_constituency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_constituency_matrix_get(m : NlpparseconstituencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_constituency_matrix_transpose(m : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  let result = nlp_parse_constituency_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_constituency_matrix_add(a : NlpparseconstituencyMatrix, b : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_constituency_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_constituency_matrix_scale(m : NlpparseconstituencyMatrix, s : Double) -> NlpparseconstituencyMatrix {
  let result = nlp_parse_constituency_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_constituency_matrix_multiply(a : NlpparseconstituencyMatrix, b : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  if a.cols != b.rows { return nlp_parse_constituency_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_constituency_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_constituency_matrix_trace(m : NlpparseconstituencyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_constituency_matrix_det(m : NlpparseconstituencyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_constituency_matrix_norm(m : NlpparseconstituencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_parse_constituency_sqrt(sum)
}

pub fn nlp_parse_constituency_matrix_to_string(m : NlpparseconstituencyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_parse_constituency_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlpparseconstituencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_constituency_make_vector(comps : Array[Double]) -> NlpparseconstituencyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_constituency_vector_zero(dim : Int) -> NlpparseconstituencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_constituency_vector_add(a : NlpparseconstituencyVector, b : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_parse_constituency_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_constituency_vector_sub(a : NlpparseconstituencyVector, b : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_parse_constituency_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_constituency_vector_scale(v : NlpparseconstituencyVector, s : Double) -> NlpparseconstituencyVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_parse_constituency_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_constituency_vector_dot(a : NlpparseconstituencyVector, b : NlpparseconstituencyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_constituency_vector_norm(v : NlpparseconstituencyVector) -> Double { nlp_parse_constituency_sqrt(nlp_parse_constituency_vector_dot(v, v)) }

pub fn nlp_parse_constituency_vector_normalize(v : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = nlp_parse_constituency_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_constituency_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_constituency_vector_dist(a : NlpparseconstituencyVector, b : NlpparseconstituencyVector) -> Double {
  nlp_parse_constituency_vector_norm(nlp_parse_constituency_vector_sub(a, b))
}

pub fn nlp_parse_constituency_vector_to_string(v : NlpparseconstituencyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_parse_constituency_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_constituency_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_parse_constituency_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_parse_constituency_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_constituency_std(data : Array[Double]) -> Double { nlp_parse_constituency_sqrt(nlp_parse_constituency_var(data)) }

pub fn nlp_parse_constituency_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_parse_constituency_mean(a); let mb = nlp_parse_constituency_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_constituency_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_parse_constituency_std(a); let sb = nlp_parse_constituency_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_parse_constituency_cov(a, b) / (sa * sb) }
}

pub fn nlp_parse_constituency_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_constituency_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_constituency_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_parse_constituency_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_constituency_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_parse_constituency_sqrt(nlp_parse_constituency_mse(pred, labels))
}

pub fn nlp_parse_constituency_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_parse_constituency_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_constituency_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_parse_constituency_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_parse_constituency_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_parse_constituency_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_parse_constituency_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_parse_constituency_precision(pred, labels, pos); let r = nlp_parse_constituency_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_parse_constituency_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_parse_constituency_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_parse_constituency_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_parse_constituency_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_parse_constituency_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_parse_constituency_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_parse_constituency_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_parse_constituency_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_parse_constituency_fibonacci(n : Int) -> Int {
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

pub fn nlp_parse_constituency_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_parse_constituency_min(data); let mx = nlp_parse_constituency_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_parse_constituency_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_parse_constituency_mean(data); let sd = nlp_parse_constituency_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_parse_constituency_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_parse_constituency_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_parse_constituency_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_parse_constituency_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_parse_constituency_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_parse_constituency_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_parse_constituency_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_parse_constituency_int(x) } else { -nlp_parse_constituency_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_parse_constituency_int(f * 1000000.0) } else { nlp_parse_constituency_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_parse_constituency_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_parse_constituency_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlpparseconstituencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_frame_make(size : Int) -> NlpparseconstituencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_frame_len(s : NlpparseconstituencyFrame) -> Int { s.size }

pub fn nlp_parse_constituency_frame_get(s : NlpparseconstituencyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_frame_set(s : NlpparseconstituencyFrame, i : Int, v : Double) -> NlpparseconstituencyFrame {
  let result = nlp_parse_constituency_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_frame_sum(s : NlpparseconstituencyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_frame_mean(s : NlpparseconstituencyFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_frame_scale(s : NlpparseconstituencyFrame, f : Double) -> NlpparseconstituencyFrame {
  let result = nlp_parse_constituency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_frame_add(a : NlpparseconstituencyFrame, b : NlpparseconstituencyFrame) -> NlpparseconstituencyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_frame_copy(s : NlpparseconstituencyFrame) -> NlpparseconstituencyFrame {
  let result = nlp_parse_constituency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_frame_fill(s : NlpparseconstituencyFrame, v : Double) -> NlpparseconstituencyFrame {
  let result = nlp_parse_constituency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_frame_min(s : NlpparseconstituencyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_frame_max(s : NlpparseconstituencyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_frame_to_string(s : NlpparseconstituencyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_table_make(size : Int) -> NlpparseconstituencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_table_len(s : NlpparseconstituencyTable) -> Int { s.size }

pub fn nlp_parse_constituency_table_get(s : NlpparseconstituencyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_table_set(s : NlpparseconstituencyTable, i : Int, v : Double) -> NlpparseconstituencyTable {
  let result = nlp_parse_constituency_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_table_sum(s : NlpparseconstituencyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_table_mean(s : NlpparseconstituencyTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_table_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_table_scale(s : NlpparseconstituencyTable, f : Double) -> NlpparseconstituencyTable {
  let result = nlp_parse_constituency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_table_add(a : NlpparseconstituencyTable, b : NlpparseconstituencyTable) -> NlpparseconstituencyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_table_copy(s : NlpparseconstituencyTable) -> NlpparseconstituencyTable {
  let result = nlp_parse_constituency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_table_fill(s : NlpparseconstituencyTable, v : Double) -> NlpparseconstituencyTable {
  let result = nlp_parse_constituency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_table_min(s : NlpparseconstituencyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_table_max(s : NlpparseconstituencyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_table_to_string(s : NlpparseconstituencyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_graphn_make(size : Int) -> NlpparseconstituencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_graphn_len(s : NlpparseconstituencyGraphN) -> Int { s.size }

pub fn nlp_parse_constituency_graphn_get(s : NlpparseconstituencyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_graphn_set(s : NlpparseconstituencyGraphN, i : Int, v : Double) -> NlpparseconstituencyGraphN {
  let result = nlp_parse_constituency_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_graphn_sum(s : NlpparseconstituencyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_graphn_mean(s : NlpparseconstituencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_graphn_scale(s : NlpparseconstituencyGraphN, f : Double) -> NlpparseconstituencyGraphN {
  let result = nlp_parse_constituency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_graphn_add(a : NlpparseconstituencyGraphN, b : NlpparseconstituencyGraphN) -> NlpparseconstituencyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_graphn_copy(s : NlpparseconstituencyGraphN) -> NlpparseconstituencyGraphN {
  let result = nlp_parse_constituency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_graphn_fill(s : NlpparseconstituencyGraphN, v : Double) -> NlpparseconstituencyGraphN {
  let result = nlp_parse_constituency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_graphn_min(s : NlpparseconstituencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_graphn_max(s : NlpparseconstituencyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_graphn_to_string(s : NlpparseconstituencyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_node_make(size : Int) -> NlpparseconstituencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_node_len(s : NlpparseconstituencyNode) -> Int { s.size }

pub fn nlp_parse_constituency_node_get(s : NlpparseconstituencyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_node_set(s : NlpparseconstituencyNode, i : Int, v : Double) -> NlpparseconstituencyNode {
  let result = nlp_parse_constituency_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_node_sum(s : NlpparseconstituencyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_node_mean(s : NlpparseconstituencyNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_node_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_node_scale(s : NlpparseconstituencyNode, f : Double) -> NlpparseconstituencyNode {
  let result = nlp_parse_constituency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_node_add(a : NlpparseconstituencyNode, b : NlpparseconstituencyNode) -> NlpparseconstituencyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_node_copy(s : NlpparseconstituencyNode) -> NlpparseconstituencyNode {
  let result = nlp_parse_constituency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_node_fill(s : NlpparseconstituencyNode, v : Double) -> NlpparseconstituencyNode {
  let result = nlp_parse_constituency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_node_min(s : NlpparseconstituencyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_node_max(s : NlpparseconstituencyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_node_to_string(s : NlpparseconstituencyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_edge_make(size : Int) -> NlpparseconstituencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_edge_len(s : NlpparseconstituencyEdge) -> Int { s.size }

pub fn nlp_parse_constituency_edge_get(s : NlpparseconstituencyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_edge_set(s : NlpparseconstituencyEdge, i : Int, v : Double) -> NlpparseconstituencyEdge {
  let result = nlp_parse_constituency_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_edge_sum(s : NlpparseconstituencyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_edge_mean(s : NlpparseconstituencyEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_edge_scale(s : NlpparseconstituencyEdge, f : Double) -> NlpparseconstituencyEdge {
  let result = nlp_parse_constituency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_edge_add(a : NlpparseconstituencyEdge, b : NlpparseconstituencyEdge) -> NlpparseconstituencyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_edge_copy(s : NlpparseconstituencyEdge) -> NlpparseconstituencyEdge {
  let result = nlp_parse_constituency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_edge_fill(s : NlpparseconstituencyEdge, v : Double) -> NlpparseconstituencyEdge {
  let result = nlp_parse_constituency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_edge_min(s : NlpparseconstituencyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_edge_max(s : NlpparseconstituencyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_edge_to_string(s : NlpparseconstituencyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_path_make(size : Int) -> NlpparseconstituencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_path_len(s : NlpparseconstituencyPath) -> Int { s.size }

pub fn nlp_parse_constituency_path_get(s : NlpparseconstituencyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_path_set(s : NlpparseconstituencyPath, i : Int, v : Double) -> NlpparseconstituencyPath {
  let result = nlp_parse_constituency_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_path_sum(s : NlpparseconstituencyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_path_mean(s : NlpparseconstituencyPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_path_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_path_scale(s : NlpparseconstituencyPath, f : Double) -> NlpparseconstituencyPath {
  let result = nlp_parse_constituency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_path_add(a : NlpparseconstituencyPath, b : NlpparseconstituencyPath) -> NlpparseconstituencyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_path_copy(s : NlpparseconstituencyPath) -> NlpparseconstituencyPath {
  let result = nlp_parse_constituency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_path_fill(s : NlpparseconstituencyPath, v : Double) -> NlpparseconstituencyPath {
  let result = nlp_parse_constituency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_path_min(s : NlpparseconstituencyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_path_max(s : NlpparseconstituencyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_path_to_string(s : NlpparseconstituencyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_cluster_make(size : Int) -> NlpparseconstituencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_cluster_len(s : NlpparseconstituencyCluster) -> Int { s.size }

pub fn nlp_parse_constituency_cluster_get(s : NlpparseconstituencyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_cluster_set(s : NlpparseconstituencyCluster, i : Int, v : Double) -> NlpparseconstituencyCluster {
  let result = nlp_parse_constituency_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_cluster_sum(s : NlpparseconstituencyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_cluster_mean(s : NlpparseconstituencyCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_cluster_scale(s : NlpparseconstituencyCluster, f : Double) -> NlpparseconstituencyCluster {
  let result = nlp_parse_constituency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_cluster_add(a : NlpparseconstituencyCluster, b : NlpparseconstituencyCluster) -> NlpparseconstituencyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_cluster_copy(s : NlpparseconstituencyCluster) -> NlpparseconstituencyCluster {
  let result = nlp_parse_constituency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_cluster_fill(s : NlpparseconstituencyCluster, v : Double) -> NlpparseconstituencyCluster {
  let result = nlp_parse_constituency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_cluster_min(s : NlpparseconstituencyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_cluster_max(s : NlpparseconstituencyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_cluster_to_string(s : NlpparseconstituencyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_model_make(size : Int) -> NlpparseconstituencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_model_len(s : NlpparseconstituencyModel) -> Int { s.size }

pub fn nlp_parse_constituency_model_get(s : NlpparseconstituencyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_model_set(s : NlpparseconstituencyModel, i : Int, v : Double) -> NlpparseconstituencyModel {
  let result = nlp_parse_constituency_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_model_sum(s : NlpparseconstituencyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_model_mean(s : NlpparseconstituencyModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_model_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_model_scale(s : NlpparseconstituencyModel, f : Double) -> NlpparseconstituencyModel {
  let result = nlp_parse_constituency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_model_add(a : NlpparseconstituencyModel, b : NlpparseconstituencyModel) -> NlpparseconstituencyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_model_copy(s : NlpparseconstituencyModel) -> NlpparseconstituencyModel {
  let result = nlp_parse_constituency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_model_fill(s : NlpparseconstituencyModel, v : Double) -> NlpparseconstituencyModel {
  let result = nlp_parse_constituency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_model_min(s : NlpparseconstituencyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_model_max(s : NlpparseconstituencyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_model_to_string(s : NlpparseconstituencyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_layer_make(size : Int) -> NlpparseconstituencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_layer_len(s : NlpparseconstituencyLayer) -> Int { s.size }

pub fn nlp_parse_constituency_layer_get(s : NlpparseconstituencyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_layer_set(s : NlpparseconstituencyLayer, i : Int, v : Double) -> NlpparseconstituencyLayer {
  let result = nlp_parse_constituency_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_layer_sum(s : NlpparseconstituencyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_layer_mean(s : NlpparseconstituencyLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_layer_scale(s : NlpparseconstituencyLayer, f : Double) -> NlpparseconstituencyLayer {
  let result = nlp_parse_constituency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_layer_add(a : NlpparseconstituencyLayer, b : NlpparseconstituencyLayer) -> NlpparseconstituencyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_layer_copy(s : NlpparseconstituencyLayer) -> NlpparseconstituencyLayer {
  let result = nlp_parse_constituency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_layer_fill(s : NlpparseconstituencyLayer, v : Double) -> NlpparseconstituencyLayer {
  let result = nlp_parse_constituency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_layer_min(s : NlpparseconstituencyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_layer_max(s : NlpparseconstituencyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_layer_to_string(s : NlpparseconstituencyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_buffer_make(size : Int) -> NlpparseconstituencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_buffer_len(s : NlpparseconstituencyBuffer) -> Int { s.size }

pub fn nlp_parse_constituency_buffer_get(s : NlpparseconstituencyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_buffer_set(s : NlpparseconstituencyBuffer, i : Int, v : Double) -> NlpparseconstituencyBuffer {
  let result = nlp_parse_constituency_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_buffer_sum(s : NlpparseconstituencyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_buffer_mean(s : NlpparseconstituencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_buffer_scale(s : NlpparseconstituencyBuffer, f : Double) -> NlpparseconstituencyBuffer {
  let result = nlp_parse_constituency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_buffer_add(a : NlpparseconstituencyBuffer, b : NlpparseconstituencyBuffer) -> NlpparseconstituencyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_buffer_copy(s : NlpparseconstituencyBuffer) -> NlpparseconstituencyBuffer {
  let result = nlp_parse_constituency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_buffer_fill(s : NlpparseconstituencyBuffer, v : Double) -> NlpparseconstituencyBuffer {
  let result = nlp_parse_constituency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_buffer_min(s : NlpparseconstituencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_buffer_max(s : NlpparseconstituencyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_buffer_to_string(s : NlpparseconstituencyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_cursor_make(size : Int) -> NlpparseconstituencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_cursor_len(s : NlpparseconstituencyCursor) -> Int { s.size }

pub fn nlp_parse_constituency_cursor_get(s : NlpparseconstituencyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_cursor_set(s : NlpparseconstituencyCursor, i : Int, v : Double) -> NlpparseconstituencyCursor {
  let result = nlp_parse_constituency_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_cursor_sum(s : NlpparseconstituencyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_cursor_mean(s : NlpparseconstituencyCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_cursor_scale(s : NlpparseconstituencyCursor, f : Double) -> NlpparseconstituencyCursor {
  let result = nlp_parse_constituency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_cursor_add(a : NlpparseconstituencyCursor, b : NlpparseconstituencyCursor) -> NlpparseconstituencyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_cursor_copy(s : NlpparseconstituencyCursor) -> NlpparseconstituencyCursor {
  let result = nlp_parse_constituency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_cursor_fill(s : NlpparseconstituencyCursor, v : Double) -> NlpparseconstituencyCursor {
  let result = nlp_parse_constituency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_cursor_min(s : NlpparseconstituencyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_cursor_max(s : NlpparseconstituencyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_cursor_to_string(s : NlpparseconstituencyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_view_make(size : Int) -> NlpparseconstituencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_view_len(s : NlpparseconstituencyView) -> Int { s.size }

pub fn nlp_parse_constituency_view_get(s : NlpparseconstituencyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_view_set(s : NlpparseconstituencyView, i : Int, v : Double) -> NlpparseconstituencyView {
  let result = nlp_parse_constituency_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_view_sum(s : NlpparseconstituencyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_view_mean(s : NlpparseconstituencyView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_view_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_view_scale(s : NlpparseconstituencyView, f : Double) -> NlpparseconstituencyView {
  let result = nlp_parse_constituency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_view_add(a : NlpparseconstituencyView, b : NlpparseconstituencyView) -> NlpparseconstituencyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_view_copy(s : NlpparseconstituencyView) -> NlpparseconstituencyView {
  let result = nlp_parse_constituency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_view_fill(s : NlpparseconstituencyView, v : Double) -> NlpparseconstituencyView {
  let result = nlp_parse_constituency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_view_min(s : NlpparseconstituencyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_view_max(s : NlpparseconstituencyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_view_to_string(s : NlpparseconstituencyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_range_make(size : Int) -> NlpparseconstituencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_range_len(s : NlpparseconstituencyRange) -> Int { s.size }

pub fn nlp_parse_constituency_range_get(s : NlpparseconstituencyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_range_set(s : NlpparseconstituencyRange, i : Int, v : Double) -> NlpparseconstituencyRange {
  let result = nlp_parse_constituency_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_range_sum(s : NlpparseconstituencyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_range_mean(s : NlpparseconstituencyRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_range_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_range_scale(s : NlpparseconstituencyRange, f : Double) -> NlpparseconstituencyRange {
  let result = nlp_parse_constituency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_range_add(a : NlpparseconstituencyRange, b : NlpparseconstituencyRange) -> NlpparseconstituencyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_range_copy(s : NlpparseconstituencyRange) -> NlpparseconstituencyRange {
  let result = nlp_parse_constituency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_range_fill(s : NlpparseconstituencyRange, v : Double) -> NlpparseconstituencyRange {
  let result = nlp_parse_constituency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_range_min(s : NlpparseconstituencyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_range_max(s : NlpparseconstituencyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_range_to_string(s : NlpparseconstituencyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_slice_make(size : Int) -> NlpparseconstituencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_slice_len(s : NlpparseconstituencySlice) -> Int { s.size }

pub fn nlp_parse_constituency_slice_get(s : NlpparseconstituencySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_slice_set(s : NlpparseconstituencySlice, i : Int, v : Double) -> NlpparseconstituencySlice {
  let result = nlp_parse_constituency_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_slice_sum(s : NlpparseconstituencySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_constituency_slice_mean(s : NlpparseconstituencySlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_constituency_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_constituency_slice_scale(s : NlpparseconstituencySlice, f : Double) -> NlpparseconstituencySlice {
  let result = nlp_parse_constituency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_slice_add(a : NlpparseconstituencySlice, b : NlpparseconstituencySlice) -> NlpparseconstituencySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_slice_copy(s : NlpparseconstituencySlice) -> NlpparseconstituencySlice {
  let result = nlp_parse_constituency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_slice_fill(s : NlpparseconstituencySlice, v : Double) -> NlpparseconstituencySlice {
  let result = nlp_parse_constituency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_slice_min(s : NlpparseconstituencySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_slice_max(s : NlpparseconstituencySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_constituency_slice_to_string(s : NlpparseconstituencySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_parse_constituency_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_parse_constituency_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

