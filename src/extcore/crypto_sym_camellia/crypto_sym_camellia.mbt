///===
/// extcore/crypto_sym_camellia

pub(all) struct CryptosymcamelliaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_camellia_make_point(x : Double, y : Double) -> CryptosymcamelliaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_camellia_make_point3(x : Double, y : Double, z : Double) -> CryptosymcamelliaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_camellia_point_x(pt : CryptosymcamelliaPoint) -> Double { pt.x }

pub fn crypto_sym_camellia_point_y(pt : CryptosymcamelliaPoint) -> Double { pt.y }

pub fn crypto_sym_camellia_point_z(pt : CryptosymcamelliaPoint) -> Double { pt.z }

pub fn crypto_sym_camellia_point_label(pt : CryptosymcamelliaPoint) -> Int { pt.label }

pub fn crypto_sym_camellia_point_dist(a : CryptosymcamelliaPoint, b : CryptosymcamelliaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_sym_camellia_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_camellia_point_add(a : CryptosymcamelliaPoint, b : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_camellia_point_sub(a : CryptosymcamelliaPoint, b : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_camellia_point_scale(pt : CryptosymcamelliaPoint, s : Double) -> CryptosymcamelliaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_camellia_point_dot(a : CryptosymcamelliaPoint, b : CryptosymcamelliaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_camellia_point_cross(a : CryptosymcamelliaPoint, b : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_camellia_point_norm(pt : CryptosymcamelliaPoint) -> Double {
  crypto_sym_camellia_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_camellia_point_normalize(pt : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  let n = crypto_sym_camellia_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_camellia_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_camellia_point_negate(pt : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_camellia_point_mid(a : CryptosymcamelliaPoint, b : CryptosymcamelliaPoint) -> CryptosymcamelliaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_camellia_point_lerp(a : CryptosymcamelliaPoint, b : CryptosymcamelliaPoint, t : Double) -> CryptosymcamelliaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_camellia_point_to_string(pt : CryptosymcamelliaPoint) -> String {
  "(" + crypto_sym_camellia_dbl(pt.x) + ", " + crypto_sym_camellia_dbl(pt.y) + ", " + crypto_sym_camellia_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymcamelliaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_camellia_make_series(vals : Array[Double], name : String) -> CryptosymcamelliaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_camellia_series_len(s : CryptosymcamelliaSeries) -> Int { s.vals.length() }

pub fn crypto_sym_camellia_series_sum(s : CryptosymcamelliaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sym_camellia_series_mean(s : CryptosymcamelliaSeries) -> Double {
  let n = crypto_sym_camellia_series_len(s)
  if n == 0 { 0.0 } else { crypto_sym_camellia_series_sum(s) / n.to_double() }
}

pub fn crypto_sym_camellia_series_min(s : CryptosymcamelliaSeries) -> Double {
  let n = crypto_sym_camellia_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_camellia_series_max(s : CryptosymcamelliaSeries) -> Double {
  let n = crypto_sym_camellia_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_camellia_series_range(s : CryptosymcamelliaSeries) -> Double {
  crypto_sym_camellia_series_max(s) - crypto_sym_camellia_series_min(s)
}

pub fn crypto_sym_camellia_series_var(s : CryptosymcamelliaSeries) -> Double {
  let n = crypto_sym_camellia_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sym_camellia_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sym_camellia_series_std(s : CryptosymcamelliaSeries) -> Double { crypto_sym_camellia_sqrt(crypto_sym_camellia_series_var(s)) }

pub fn crypto_sym_camellia_series_median(s : CryptosymcamelliaSeries) -> Double {
  let n = crypto_sym_camellia_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_camellia_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_camellia_series_scale(s : CryptosymcamelliaSeries, f : Double) -> CryptosymcamelliaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_sym_camellia_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_camellia_series_add(a : CryptosymcamelliaSeries, b : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sym_camellia_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_camellia_series_sub(a : CryptosymcamelliaSeries, b : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sym_camellia_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_camellia_series_normalize(s : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  let mn = crypto_sym_camellia_series_min(s)
  let mx = crypto_sym_camellia_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_sym_camellia_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_camellia_series_cumsum(s : CryptosymcamelliaSeries) -> CryptosymcamelliaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_sym_camellia_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_camellia_series_to_string(s : CryptosymcamelliaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sym_camellia_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcamelliaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_camellia_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymcamelliaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_camellia_matrix_identity(n : Int) -> CryptosymcamelliaMatrix {
  let m = crypto_sym_camellia_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_camellia_matrix_get(m : CryptosymcamelliaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_camellia_matrix_transpose(m : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  let result = crypto_sym_camellia_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_camellia_matrix_add(a : CryptosymcamelliaMatrix, b : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_camellia_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_camellia_matrix_scale(m : CryptosymcamelliaMatrix, s : Double) -> CryptosymcamelliaMatrix {
  let result = crypto_sym_camellia_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_camellia_matrix_multiply(a : CryptosymcamelliaMatrix, b : CryptosymcamelliaMatrix) -> CryptosymcamelliaMatrix {
  if a.cols != b.rows { return crypto_sym_camellia_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_camellia_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_camellia_matrix_trace(m : CryptosymcamelliaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_camellia_matrix_det(m : CryptosymcamelliaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_camellia_matrix_norm(m : CryptosymcamelliaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_sym_camellia_sqrt(sum)
}

pub fn crypto_sym_camellia_matrix_to_string(m : CryptosymcamelliaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_sym_camellia_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosymcamelliaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_camellia_make_vector(comps : Array[Double]) -> CryptosymcamelliaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_camellia_vector_zero(dim : Int) -> CryptosymcamelliaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_camellia_vector_add(a : CryptosymcamelliaVector, b : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sym_camellia_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_camellia_vector_sub(a : CryptosymcamelliaVector, b : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sym_camellia_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_camellia_vector_scale(v : CryptosymcamelliaVector, s : Double) -> CryptosymcamelliaVector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_sym_camellia_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_camellia_vector_dot(a : CryptosymcamelliaVector, b : CryptosymcamelliaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_camellia_vector_norm(v : CryptosymcamelliaVector) -> Double { crypto_sym_camellia_sqrt(crypto_sym_camellia_vector_dot(v, v)) }

pub fn crypto_sym_camellia_vector_normalize(v : CryptosymcamelliaVector) -> CryptosymcamelliaVector {
  let n = crypto_sym_camellia_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_camellia_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_camellia_vector_dist(a : CryptosymcamelliaVector, b : CryptosymcamelliaVector) -> Double {
  crypto_sym_camellia_vector_norm(crypto_sym_camellia_vector_sub(a, b))
}

pub fn crypto_sym_camellia_vector_to_string(v : CryptosymcamelliaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sym_camellia_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_camellia_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sym_camellia_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sym_camellia_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_camellia_std(data : Array[Double]) -> Double { crypto_sym_camellia_sqrt(crypto_sym_camellia_var(data)) }

pub fn crypto_sym_camellia_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sym_camellia_mean(a); let mb = crypto_sym_camellia_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_camellia_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sym_camellia_std(a); let sb = crypto_sym_camellia_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sym_camellia_cov(a, b) / (sa * sb) }
}

pub fn crypto_sym_camellia_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_camellia_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_camellia_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sym_camellia_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_camellia_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_sym_camellia_sqrt(crypto_sym_camellia_mse(pred, labels))
}

pub fn crypto_sym_camellia_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_sym_camellia_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_camellia_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sym_camellia_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sym_camellia_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sym_camellia_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sym_camellia_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sym_camellia_precision(pred, labels, pos); let r = crypto_sym_camellia_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sym_camellia_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sym_camellia_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sym_camellia_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sym_camellia_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sym_camellia_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sym_camellia_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sym_camellia_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sym_camellia_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sym_camellia_fibonacci(n : Int) -> Int {
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

pub fn crypto_sym_camellia_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sym_camellia_min(data); let mx = crypto_sym_camellia_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sym_camellia_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sym_camellia_mean(data); let sd = crypto_sym_camellia_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sym_camellia_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sym_camellia_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sym_camellia_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sym_camellia_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_sym_camellia_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_sym_camellia_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_sym_camellia_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_sym_camellia_int(x) } else { -crypto_sym_camellia_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_sym_camellia_int(f * 1000000.0) } else { crypto_sym_camellia_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_sym_camellia_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_sym_camellia_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct CryptosymcamelliaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_frame_make(size : Int) -> CryptosymcamelliaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_frame_len(s : CryptosymcamelliaFrame) -> Int { s.size }

pub fn crypto_sym_camellia_frame_get(s : CryptosymcamelliaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_frame_set(s : CryptosymcamelliaFrame, i : Int, v : Double) -> CryptosymcamelliaFrame {
  let result = crypto_sym_camellia_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_frame_sum(s : CryptosymcamelliaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_frame_mean(s : CryptosymcamelliaFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_frame_scale(s : CryptosymcamelliaFrame, f : Double) -> CryptosymcamelliaFrame {
  let result = crypto_sym_camellia_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_frame_add(a : CryptosymcamelliaFrame, b : CryptosymcamelliaFrame) -> CryptosymcamelliaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_frame_copy(s : CryptosymcamelliaFrame) -> CryptosymcamelliaFrame {
  let result = crypto_sym_camellia_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_frame_fill(s : CryptosymcamelliaFrame, v : Double) -> CryptosymcamelliaFrame {
  let result = crypto_sym_camellia_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_frame_min(s : CryptosymcamelliaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_frame_max(s : CryptosymcamelliaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_frame_to_string(s : CryptosymcamelliaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_table_make(size : Int) -> CryptosymcamelliaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_table_len(s : CryptosymcamelliaTable) -> Int { s.size }

pub fn crypto_sym_camellia_table_get(s : CryptosymcamelliaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_table_set(s : CryptosymcamelliaTable, i : Int, v : Double) -> CryptosymcamelliaTable {
  let result = crypto_sym_camellia_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_table_sum(s : CryptosymcamelliaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_table_mean(s : CryptosymcamelliaTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_table_scale(s : CryptosymcamelliaTable, f : Double) -> CryptosymcamelliaTable {
  let result = crypto_sym_camellia_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_table_add(a : CryptosymcamelliaTable, b : CryptosymcamelliaTable) -> CryptosymcamelliaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_table_copy(s : CryptosymcamelliaTable) -> CryptosymcamelliaTable {
  let result = crypto_sym_camellia_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_table_fill(s : CryptosymcamelliaTable, v : Double) -> CryptosymcamelliaTable {
  let result = crypto_sym_camellia_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_table_min(s : CryptosymcamelliaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_table_max(s : CryptosymcamelliaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_table_to_string(s : CryptosymcamelliaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_graphn_make(size : Int) -> CryptosymcamelliaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_graphn_len(s : CryptosymcamelliaGraphN) -> Int { s.size }

pub fn crypto_sym_camellia_graphn_get(s : CryptosymcamelliaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_graphn_set(s : CryptosymcamelliaGraphN, i : Int, v : Double) -> CryptosymcamelliaGraphN {
  let result = crypto_sym_camellia_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_graphn_sum(s : CryptosymcamelliaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_graphn_mean(s : CryptosymcamelliaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_graphn_scale(s : CryptosymcamelliaGraphN, f : Double) -> CryptosymcamelliaGraphN {
  let result = crypto_sym_camellia_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_graphn_add(a : CryptosymcamelliaGraphN, b : CryptosymcamelliaGraphN) -> CryptosymcamelliaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_graphn_copy(s : CryptosymcamelliaGraphN) -> CryptosymcamelliaGraphN {
  let result = crypto_sym_camellia_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_graphn_fill(s : CryptosymcamelliaGraphN, v : Double) -> CryptosymcamelliaGraphN {
  let result = crypto_sym_camellia_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_graphn_min(s : CryptosymcamelliaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_graphn_max(s : CryptosymcamelliaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_graphn_to_string(s : CryptosymcamelliaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_node_make(size : Int) -> CryptosymcamelliaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_node_len(s : CryptosymcamelliaNode) -> Int { s.size }

pub fn crypto_sym_camellia_node_get(s : CryptosymcamelliaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_node_set(s : CryptosymcamelliaNode, i : Int, v : Double) -> CryptosymcamelliaNode {
  let result = crypto_sym_camellia_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_node_sum(s : CryptosymcamelliaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_node_mean(s : CryptosymcamelliaNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_node_scale(s : CryptosymcamelliaNode, f : Double) -> CryptosymcamelliaNode {
  let result = crypto_sym_camellia_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_node_add(a : CryptosymcamelliaNode, b : CryptosymcamelliaNode) -> CryptosymcamelliaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_node_copy(s : CryptosymcamelliaNode) -> CryptosymcamelliaNode {
  let result = crypto_sym_camellia_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_node_fill(s : CryptosymcamelliaNode, v : Double) -> CryptosymcamelliaNode {
  let result = crypto_sym_camellia_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_node_min(s : CryptosymcamelliaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_node_max(s : CryptosymcamelliaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_node_to_string(s : CryptosymcamelliaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_edge_make(size : Int) -> CryptosymcamelliaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_edge_len(s : CryptosymcamelliaEdge) -> Int { s.size }

pub fn crypto_sym_camellia_edge_get(s : CryptosymcamelliaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_edge_set(s : CryptosymcamelliaEdge, i : Int, v : Double) -> CryptosymcamelliaEdge {
  let result = crypto_sym_camellia_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_edge_sum(s : CryptosymcamelliaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_edge_mean(s : CryptosymcamelliaEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_edge_scale(s : CryptosymcamelliaEdge, f : Double) -> CryptosymcamelliaEdge {
  let result = crypto_sym_camellia_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_edge_add(a : CryptosymcamelliaEdge, b : CryptosymcamelliaEdge) -> CryptosymcamelliaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_edge_copy(s : CryptosymcamelliaEdge) -> CryptosymcamelliaEdge {
  let result = crypto_sym_camellia_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_edge_fill(s : CryptosymcamelliaEdge, v : Double) -> CryptosymcamelliaEdge {
  let result = crypto_sym_camellia_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_edge_min(s : CryptosymcamelliaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_edge_max(s : CryptosymcamelliaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_edge_to_string(s : CryptosymcamelliaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_path_make(size : Int) -> CryptosymcamelliaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_path_len(s : CryptosymcamelliaPath) -> Int { s.size }

pub fn crypto_sym_camellia_path_get(s : CryptosymcamelliaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_path_set(s : CryptosymcamelliaPath, i : Int, v : Double) -> CryptosymcamelliaPath {
  let result = crypto_sym_camellia_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_path_sum(s : CryptosymcamelliaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_path_mean(s : CryptosymcamelliaPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_path_scale(s : CryptosymcamelliaPath, f : Double) -> CryptosymcamelliaPath {
  let result = crypto_sym_camellia_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_path_add(a : CryptosymcamelliaPath, b : CryptosymcamelliaPath) -> CryptosymcamelliaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_path_copy(s : CryptosymcamelliaPath) -> CryptosymcamelliaPath {
  let result = crypto_sym_camellia_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_path_fill(s : CryptosymcamelliaPath, v : Double) -> CryptosymcamelliaPath {
  let result = crypto_sym_camellia_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_path_min(s : CryptosymcamelliaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_path_max(s : CryptosymcamelliaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_path_to_string(s : CryptosymcamelliaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_cluster_make(size : Int) -> CryptosymcamelliaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_cluster_len(s : CryptosymcamelliaCluster) -> Int { s.size }

pub fn crypto_sym_camellia_cluster_get(s : CryptosymcamelliaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_cluster_set(s : CryptosymcamelliaCluster, i : Int, v : Double) -> CryptosymcamelliaCluster {
  let result = crypto_sym_camellia_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_cluster_sum(s : CryptosymcamelliaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_cluster_mean(s : CryptosymcamelliaCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_cluster_scale(s : CryptosymcamelliaCluster, f : Double) -> CryptosymcamelliaCluster {
  let result = crypto_sym_camellia_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_cluster_add(a : CryptosymcamelliaCluster, b : CryptosymcamelliaCluster) -> CryptosymcamelliaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_cluster_copy(s : CryptosymcamelliaCluster) -> CryptosymcamelliaCluster {
  let result = crypto_sym_camellia_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_cluster_fill(s : CryptosymcamelliaCluster, v : Double) -> CryptosymcamelliaCluster {
  let result = crypto_sym_camellia_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_cluster_min(s : CryptosymcamelliaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_cluster_max(s : CryptosymcamelliaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_cluster_to_string(s : CryptosymcamelliaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_model_make(size : Int) -> CryptosymcamelliaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_model_len(s : CryptosymcamelliaModel) -> Int { s.size }

pub fn crypto_sym_camellia_model_get(s : CryptosymcamelliaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_model_set(s : CryptosymcamelliaModel, i : Int, v : Double) -> CryptosymcamelliaModel {
  let result = crypto_sym_camellia_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_model_sum(s : CryptosymcamelliaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_model_mean(s : CryptosymcamelliaModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_model_scale(s : CryptosymcamelliaModel, f : Double) -> CryptosymcamelliaModel {
  let result = crypto_sym_camellia_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_model_add(a : CryptosymcamelliaModel, b : CryptosymcamelliaModel) -> CryptosymcamelliaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_model_copy(s : CryptosymcamelliaModel) -> CryptosymcamelliaModel {
  let result = crypto_sym_camellia_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_model_fill(s : CryptosymcamelliaModel, v : Double) -> CryptosymcamelliaModel {
  let result = crypto_sym_camellia_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_model_min(s : CryptosymcamelliaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_model_max(s : CryptosymcamelliaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_model_to_string(s : CryptosymcamelliaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_layer_make(size : Int) -> CryptosymcamelliaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_layer_len(s : CryptosymcamelliaLayer) -> Int { s.size }

pub fn crypto_sym_camellia_layer_get(s : CryptosymcamelliaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_layer_set(s : CryptosymcamelliaLayer, i : Int, v : Double) -> CryptosymcamelliaLayer {
  let result = crypto_sym_camellia_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_layer_sum(s : CryptosymcamelliaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_layer_mean(s : CryptosymcamelliaLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_layer_scale(s : CryptosymcamelliaLayer, f : Double) -> CryptosymcamelliaLayer {
  let result = crypto_sym_camellia_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_layer_add(a : CryptosymcamelliaLayer, b : CryptosymcamelliaLayer) -> CryptosymcamelliaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_layer_copy(s : CryptosymcamelliaLayer) -> CryptosymcamelliaLayer {
  let result = crypto_sym_camellia_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_layer_fill(s : CryptosymcamelliaLayer, v : Double) -> CryptosymcamelliaLayer {
  let result = crypto_sym_camellia_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_layer_min(s : CryptosymcamelliaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_layer_max(s : CryptosymcamelliaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_layer_to_string(s : CryptosymcamelliaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_buffer_make(size : Int) -> CryptosymcamelliaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_buffer_len(s : CryptosymcamelliaBuffer) -> Int { s.size }

pub fn crypto_sym_camellia_buffer_get(s : CryptosymcamelliaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_buffer_set(s : CryptosymcamelliaBuffer, i : Int, v : Double) -> CryptosymcamelliaBuffer {
  let result = crypto_sym_camellia_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_buffer_sum(s : CryptosymcamelliaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_buffer_mean(s : CryptosymcamelliaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_buffer_scale(s : CryptosymcamelliaBuffer, f : Double) -> CryptosymcamelliaBuffer {
  let result = crypto_sym_camellia_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_buffer_add(a : CryptosymcamelliaBuffer, b : CryptosymcamelliaBuffer) -> CryptosymcamelliaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_buffer_copy(s : CryptosymcamelliaBuffer) -> CryptosymcamelliaBuffer {
  let result = crypto_sym_camellia_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_buffer_fill(s : CryptosymcamelliaBuffer, v : Double) -> CryptosymcamelliaBuffer {
  let result = crypto_sym_camellia_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_buffer_min(s : CryptosymcamelliaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_buffer_max(s : CryptosymcamelliaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_buffer_to_string(s : CryptosymcamelliaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_cursor_make(size : Int) -> CryptosymcamelliaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_cursor_len(s : CryptosymcamelliaCursor) -> Int { s.size }

pub fn crypto_sym_camellia_cursor_get(s : CryptosymcamelliaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_cursor_set(s : CryptosymcamelliaCursor, i : Int, v : Double) -> CryptosymcamelliaCursor {
  let result = crypto_sym_camellia_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_cursor_sum(s : CryptosymcamelliaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_cursor_mean(s : CryptosymcamelliaCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_cursor_scale(s : CryptosymcamelliaCursor, f : Double) -> CryptosymcamelliaCursor {
  let result = crypto_sym_camellia_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_cursor_add(a : CryptosymcamelliaCursor, b : CryptosymcamelliaCursor) -> CryptosymcamelliaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_cursor_copy(s : CryptosymcamelliaCursor) -> CryptosymcamelliaCursor {
  let result = crypto_sym_camellia_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_cursor_fill(s : CryptosymcamelliaCursor, v : Double) -> CryptosymcamelliaCursor {
  let result = crypto_sym_camellia_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_cursor_min(s : CryptosymcamelliaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_cursor_max(s : CryptosymcamelliaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_cursor_to_string(s : CryptosymcamelliaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_view_make(size : Int) -> CryptosymcamelliaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_view_len(s : CryptosymcamelliaView) -> Int { s.size }

pub fn crypto_sym_camellia_view_get(s : CryptosymcamelliaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_view_set(s : CryptosymcamelliaView, i : Int, v : Double) -> CryptosymcamelliaView {
  let result = crypto_sym_camellia_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_view_sum(s : CryptosymcamelliaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_view_mean(s : CryptosymcamelliaView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_view_scale(s : CryptosymcamelliaView, f : Double) -> CryptosymcamelliaView {
  let result = crypto_sym_camellia_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_view_add(a : CryptosymcamelliaView, b : CryptosymcamelliaView) -> CryptosymcamelliaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_view_copy(s : CryptosymcamelliaView) -> CryptosymcamelliaView {
  let result = crypto_sym_camellia_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_view_fill(s : CryptosymcamelliaView, v : Double) -> CryptosymcamelliaView {
  let result = crypto_sym_camellia_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_view_min(s : CryptosymcamelliaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_view_max(s : CryptosymcamelliaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_view_to_string(s : CryptosymcamelliaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_range_make(size : Int) -> CryptosymcamelliaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_range_len(s : CryptosymcamelliaRange) -> Int { s.size }

pub fn crypto_sym_camellia_range_get(s : CryptosymcamelliaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_range_set(s : CryptosymcamelliaRange, i : Int, v : Double) -> CryptosymcamelliaRange {
  let result = crypto_sym_camellia_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_range_sum(s : CryptosymcamelliaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_range_mean(s : CryptosymcamelliaRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_range_scale(s : CryptosymcamelliaRange, f : Double) -> CryptosymcamelliaRange {
  let result = crypto_sym_camellia_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_range_add(a : CryptosymcamelliaRange, b : CryptosymcamelliaRange) -> CryptosymcamelliaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_range_copy(s : CryptosymcamelliaRange) -> CryptosymcamelliaRange {
  let result = crypto_sym_camellia_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_range_fill(s : CryptosymcamelliaRange, v : Double) -> CryptosymcamelliaRange {
  let result = crypto_sym_camellia_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_range_min(s : CryptosymcamelliaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_range_max(s : CryptosymcamelliaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_range_to_string(s : CryptosymcamelliaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcamelliaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_camellia_slice_make(size : Int) -> CryptosymcamelliaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_camellia_slice_len(s : CryptosymcamelliaSlice) -> Int { s.size }

pub fn crypto_sym_camellia_slice_get(s : CryptosymcamelliaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_camellia_slice_set(s : CryptosymcamelliaSlice, i : Int, v : Double) -> CryptosymcamelliaSlice {
  let result = crypto_sym_camellia_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_slice_sum(s : CryptosymcamelliaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_camellia_slice_mean(s : CryptosymcamelliaSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_camellia_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_camellia_slice_scale(s : CryptosymcamelliaSlice, f : Double) -> CryptosymcamelliaSlice {
  let result = crypto_sym_camellia_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_camellia_slice_add(a : CryptosymcamelliaSlice, b : CryptosymcamelliaSlice) -> CryptosymcamelliaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_camellia_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_camellia_slice_copy(s : CryptosymcamelliaSlice) -> CryptosymcamelliaSlice {
  let result = crypto_sym_camellia_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_camellia_slice_fill(s : CryptosymcamelliaSlice, v : Double) -> CryptosymcamelliaSlice {
  let result = crypto_sym_camellia_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_camellia_slice_min(s : CryptosymcamelliaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_slice_max(s : CryptosymcamelliaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_camellia_slice_to_string(s : CryptosymcamelliaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_sym_camellia_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_camellia_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

