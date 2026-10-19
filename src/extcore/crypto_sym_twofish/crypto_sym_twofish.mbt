///===
/// extcore/crypto_sym_twofish

pub(all) struct CryptosymtwofishPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_twofish_make_point(x : Double, y : Double) -> CryptosymtwofishPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_twofish_make_point3(x : Double, y : Double, z : Double) -> CryptosymtwofishPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_twofish_point_x(pt : CryptosymtwofishPoint) -> Double { pt.x }

pub fn crypto_sym_twofish_point_y(pt : CryptosymtwofishPoint) -> Double { pt.y }

pub fn crypto_sym_twofish_point_z(pt : CryptosymtwofishPoint) -> Double { pt.z }

pub fn crypto_sym_twofish_point_label(pt : CryptosymtwofishPoint) -> Int { pt.label }

pub fn crypto_sym_twofish_point_dist(a : CryptosymtwofishPoint, b : CryptosymtwofishPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_twofish_point_add(a : CryptosymtwofishPoint, b : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_twofish_point_sub(a : CryptosymtwofishPoint, b : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_twofish_point_scale(pt : CryptosymtwofishPoint, s : Double) -> CryptosymtwofishPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_twofish_point_dot(a : CryptosymtwofishPoint, b : CryptosymtwofishPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_twofish_point_cross(a : CryptosymtwofishPoint, b : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_twofish_point_norm(pt : CryptosymtwofishPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_twofish_point_normalize(pt : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  let n = crypto_sym_twofish_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_twofish_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_twofish_point_negate(pt : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_twofish_point_mid(a : CryptosymtwofishPoint, b : CryptosymtwofishPoint) -> CryptosymtwofishPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_twofish_point_lerp(a : CryptosymtwofishPoint, b : CryptosymtwofishPoint, t : Double) -> CryptosymtwofishPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_twofish_point_to_string(pt : CryptosymtwofishPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymtwofishSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_twofish_make_series(vals : Array[Double], name : String) -> CryptosymtwofishSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_twofish_series_len(s : CryptosymtwofishSeries) -> Int { s.vals.length() }

pub fn crypto_sym_twofish_series_sum(s : CryptosymtwofishSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sym_twofish_series_mean(s : CryptosymtwofishSeries) -> Double {
  let n = crypto_sym_twofish_series_len(s)
  if n == 0 { 0.0 } else { crypto_sym_twofish_series_sum(s) / n.to_double() }
}

pub fn crypto_sym_twofish_series_min(s : CryptosymtwofishSeries) -> Double {
  let n = crypto_sym_twofish_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_twofish_series_max(s : CryptosymtwofishSeries) -> Double {
  let n = crypto_sym_twofish_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_twofish_series_range(s : CryptosymtwofishSeries) -> Double {
  crypto_sym_twofish_series_max(s) - crypto_sym_twofish_series_min(s)
}

pub fn crypto_sym_twofish_series_var(s : CryptosymtwofishSeries) -> Double {
  let n = crypto_sym_twofish_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sym_twofish_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sym_twofish_series_std(s : CryptosymtwofishSeries) -> Double { @_common.sqrt(crypto_sym_twofish_series_var(s)) }

pub fn crypto_sym_twofish_series_median(s : CryptosymtwofishSeries) -> Double {
  let n = crypto_sym_twofish_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_twofish_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_twofish_series_scale(s : CryptosymtwofishSeries, f : Double) -> CryptosymtwofishSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_twofish_series_add(a : CryptosymtwofishSeries, b : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_twofish_series_sub(a : CryptosymtwofishSeries, b : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_twofish_series_normalize(s : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  let mn = crypto_sym_twofish_series_min(s)
  let mx = crypto_sym_twofish_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_twofish_series_cumsum(s : CryptosymtwofishSeries) -> CryptosymtwofishSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_twofish_series_to_string(s : CryptosymtwofishSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymtwofishMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_twofish_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymtwofishMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_twofish_matrix_identity(n : Int) -> CryptosymtwofishMatrix {
  let m = crypto_sym_twofish_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_twofish_matrix_get(m : CryptosymtwofishMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_twofish_matrix_transpose(m : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  let result = crypto_sym_twofish_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_twofish_matrix_add(a : CryptosymtwofishMatrix, b : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_twofish_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_twofish_matrix_scale(m : CryptosymtwofishMatrix, s : Double) -> CryptosymtwofishMatrix {
  let result = crypto_sym_twofish_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_twofish_matrix_multiply(a : CryptosymtwofishMatrix, b : CryptosymtwofishMatrix) -> CryptosymtwofishMatrix {
  if a.cols != b.rows { return crypto_sym_twofish_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_twofish_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_twofish_matrix_trace(m : CryptosymtwofishMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_twofish_matrix_det(m : CryptosymtwofishMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_twofish_matrix_norm(m : CryptosymtwofishMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_twofish_matrix_to_string(m : CryptosymtwofishMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosymtwofishVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_twofish_make_vector(comps : Array[Double]) -> CryptosymtwofishVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_twofish_vector_zero(dim : Int) -> CryptosymtwofishVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_twofish_vector_add(a : CryptosymtwofishVector, b : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_twofish_vector_sub(a : CryptosymtwofishVector, b : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_twofish_vector_scale(v : CryptosymtwofishVector, s : Double) -> CryptosymtwofishVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_twofish_vector_dot(a : CryptosymtwofishVector, b : CryptosymtwofishVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_twofish_vector_norm(v : CryptosymtwofishVector) -> Double { @_common.sqrt(crypto_sym_twofish_vector_dot(v, v)) }

pub fn crypto_sym_twofish_vector_normalize(v : CryptosymtwofishVector) -> CryptosymtwofishVector {
  let n = crypto_sym_twofish_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_twofish_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_twofish_vector_dist(a : CryptosymtwofishVector, b : CryptosymtwofishVector) -> Double {
  crypto_sym_twofish_vector_norm(crypto_sym_twofish_vector_sub(a, b))
}

pub fn crypto_sym_twofish_vector_to_string(v : CryptosymtwofishVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_twofish_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sym_twofish_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sym_twofish_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_twofish_std(data : Array[Double]) -> Double { @_common.sqrt(crypto_sym_twofish_var(data)) }

pub fn crypto_sym_twofish_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sym_twofish_mean(a); let mb = crypto_sym_twofish_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_twofish_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sym_twofish_std(a); let sb = crypto_sym_twofish_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sym_twofish_cov(a, b) / (sa * sb) }
}

pub fn crypto_sym_twofish_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_twofish_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_twofish_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sym_twofish_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_twofish_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(crypto_sym_twofish_mse(pred, labels))
}

pub fn crypto_sym_twofish_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_twofish_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sym_twofish_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sym_twofish_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sym_twofish_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sym_twofish_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sym_twofish_precision(pred, labels, pos); let r = crypto_sym_twofish_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sym_twofish_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sym_twofish_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sym_twofish_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sym_twofish_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sym_twofish_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sym_twofish_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sym_twofish_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sym_twofish_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sym_twofish_fibonacci(n : Int) -> Int {
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

pub fn crypto_sym_twofish_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sym_twofish_min(data); let mx = crypto_sym_twofish_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sym_twofish_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sym_twofish_mean(data); let sd = crypto_sym_twofish_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sym_twofish_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sym_twofish_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sym_twofish_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sym_twofish_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct CryptosymtwofishFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_frame_make(size : Int) -> CryptosymtwofishFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_frame_len(s : CryptosymtwofishFrame) -> Int { s.size }

pub fn crypto_sym_twofish_frame_get(s : CryptosymtwofishFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_frame_set(s : CryptosymtwofishFrame, i : Int, v : Double) -> CryptosymtwofishFrame {
  let result = crypto_sym_twofish_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_frame_sum(s : CryptosymtwofishFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_frame_mean(s : CryptosymtwofishFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_frame_scale(s : CryptosymtwofishFrame, f : Double) -> CryptosymtwofishFrame {
  let result = crypto_sym_twofish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_frame_add(a : CryptosymtwofishFrame, b : CryptosymtwofishFrame) -> CryptosymtwofishFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_frame_copy(s : CryptosymtwofishFrame) -> CryptosymtwofishFrame {
  let result = crypto_sym_twofish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_frame_fill(s : CryptosymtwofishFrame, v : Double) -> CryptosymtwofishFrame {
  let result = crypto_sym_twofish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_frame_min(s : CryptosymtwofishFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_frame_max(s : CryptosymtwofishFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_frame_to_string(s : CryptosymtwofishFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_table_make(size : Int) -> CryptosymtwofishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_table_len(s : CryptosymtwofishTable) -> Int { s.size }

pub fn crypto_sym_twofish_table_get(s : CryptosymtwofishTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_table_set(s : CryptosymtwofishTable, i : Int, v : Double) -> CryptosymtwofishTable {
  let result = crypto_sym_twofish_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_table_sum(s : CryptosymtwofishTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_table_mean(s : CryptosymtwofishTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_table_scale(s : CryptosymtwofishTable, f : Double) -> CryptosymtwofishTable {
  let result = crypto_sym_twofish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_table_add(a : CryptosymtwofishTable, b : CryptosymtwofishTable) -> CryptosymtwofishTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_table_copy(s : CryptosymtwofishTable) -> CryptosymtwofishTable {
  let result = crypto_sym_twofish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_table_fill(s : CryptosymtwofishTable, v : Double) -> CryptosymtwofishTable {
  let result = crypto_sym_twofish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_table_min(s : CryptosymtwofishTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_table_max(s : CryptosymtwofishTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_table_to_string(s : CryptosymtwofishTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_graphn_make(size : Int) -> CryptosymtwofishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_graphn_len(s : CryptosymtwofishGraphN) -> Int { s.size }

pub fn crypto_sym_twofish_graphn_get(s : CryptosymtwofishGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_graphn_set(s : CryptosymtwofishGraphN, i : Int, v : Double) -> CryptosymtwofishGraphN {
  let result = crypto_sym_twofish_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_graphn_sum(s : CryptosymtwofishGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_graphn_mean(s : CryptosymtwofishGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_graphn_scale(s : CryptosymtwofishGraphN, f : Double) -> CryptosymtwofishGraphN {
  let result = crypto_sym_twofish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_graphn_add(a : CryptosymtwofishGraphN, b : CryptosymtwofishGraphN) -> CryptosymtwofishGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_graphn_copy(s : CryptosymtwofishGraphN) -> CryptosymtwofishGraphN {
  let result = crypto_sym_twofish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_graphn_fill(s : CryptosymtwofishGraphN, v : Double) -> CryptosymtwofishGraphN {
  let result = crypto_sym_twofish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_graphn_min(s : CryptosymtwofishGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_graphn_max(s : CryptosymtwofishGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_graphn_to_string(s : CryptosymtwofishGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_node_make(size : Int) -> CryptosymtwofishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_node_len(s : CryptosymtwofishNode) -> Int { s.size }

pub fn crypto_sym_twofish_node_get(s : CryptosymtwofishNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_node_set(s : CryptosymtwofishNode, i : Int, v : Double) -> CryptosymtwofishNode {
  let result = crypto_sym_twofish_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_node_sum(s : CryptosymtwofishNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_node_mean(s : CryptosymtwofishNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_node_scale(s : CryptosymtwofishNode, f : Double) -> CryptosymtwofishNode {
  let result = crypto_sym_twofish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_node_add(a : CryptosymtwofishNode, b : CryptosymtwofishNode) -> CryptosymtwofishNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_node_copy(s : CryptosymtwofishNode) -> CryptosymtwofishNode {
  let result = crypto_sym_twofish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_node_fill(s : CryptosymtwofishNode, v : Double) -> CryptosymtwofishNode {
  let result = crypto_sym_twofish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_node_min(s : CryptosymtwofishNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_node_max(s : CryptosymtwofishNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_node_to_string(s : CryptosymtwofishNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_edge_make(size : Int) -> CryptosymtwofishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_edge_len(s : CryptosymtwofishEdge) -> Int { s.size }

pub fn crypto_sym_twofish_edge_get(s : CryptosymtwofishEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_edge_set(s : CryptosymtwofishEdge, i : Int, v : Double) -> CryptosymtwofishEdge {
  let result = crypto_sym_twofish_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_edge_sum(s : CryptosymtwofishEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_edge_mean(s : CryptosymtwofishEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_edge_scale(s : CryptosymtwofishEdge, f : Double) -> CryptosymtwofishEdge {
  let result = crypto_sym_twofish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_edge_add(a : CryptosymtwofishEdge, b : CryptosymtwofishEdge) -> CryptosymtwofishEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_edge_copy(s : CryptosymtwofishEdge) -> CryptosymtwofishEdge {
  let result = crypto_sym_twofish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_edge_fill(s : CryptosymtwofishEdge, v : Double) -> CryptosymtwofishEdge {
  let result = crypto_sym_twofish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_edge_min(s : CryptosymtwofishEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_edge_max(s : CryptosymtwofishEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_edge_to_string(s : CryptosymtwofishEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_path_make(size : Int) -> CryptosymtwofishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_path_len(s : CryptosymtwofishPath) -> Int { s.size }

pub fn crypto_sym_twofish_path_get(s : CryptosymtwofishPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_path_set(s : CryptosymtwofishPath, i : Int, v : Double) -> CryptosymtwofishPath {
  let result = crypto_sym_twofish_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_path_sum(s : CryptosymtwofishPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_path_mean(s : CryptosymtwofishPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_path_scale(s : CryptosymtwofishPath, f : Double) -> CryptosymtwofishPath {
  let result = crypto_sym_twofish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_path_add(a : CryptosymtwofishPath, b : CryptosymtwofishPath) -> CryptosymtwofishPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_path_copy(s : CryptosymtwofishPath) -> CryptosymtwofishPath {
  let result = crypto_sym_twofish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_path_fill(s : CryptosymtwofishPath, v : Double) -> CryptosymtwofishPath {
  let result = crypto_sym_twofish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_path_min(s : CryptosymtwofishPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_path_max(s : CryptosymtwofishPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_path_to_string(s : CryptosymtwofishPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_cluster_make(size : Int) -> CryptosymtwofishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_cluster_len(s : CryptosymtwofishCluster) -> Int { s.size }

pub fn crypto_sym_twofish_cluster_get(s : CryptosymtwofishCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_cluster_set(s : CryptosymtwofishCluster, i : Int, v : Double) -> CryptosymtwofishCluster {
  let result = crypto_sym_twofish_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_cluster_sum(s : CryptosymtwofishCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_cluster_mean(s : CryptosymtwofishCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_cluster_scale(s : CryptosymtwofishCluster, f : Double) -> CryptosymtwofishCluster {
  let result = crypto_sym_twofish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_cluster_add(a : CryptosymtwofishCluster, b : CryptosymtwofishCluster) -> CryptosymtwofishCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_cluster_copy(s : CryptosymtwofishCluster) -> CryptosymtwofishCluster {
  let result = crypto_sym_twofish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_cluster_fill(s : CryptosymtwofishCluster, v : Double) -> CryptosymtwofishCluster {
  let result = crypto_sym_twofish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_cluster_min(s : CryptosymtwofishCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_cluster_max(s : CryptosymtwofishCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_cluster_to_string(s : CryptosymtwofishCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_model_make(size : Int) -> CryptosymtwofishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_model_len(s : CryptosymtwofishModel) -> Int { s.size }

pub fn crypto_sym_twofish_model_get(s : CryptosymtwofishModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_model_set(s : CryptosymtwofishModel, i : Int, v : Double) -> CryptosymtwofishModel {
  let result = crypto_sym_twofish_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_model_sum(s : CryptosymtwofishModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_model_mean(s : CryptosymtwofishModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_model_scale(s : CryptosymtwofishModel, f : Double) -> CryptosymtwofishModel {
  let result = crypto_sym_twofish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_model_add(a : CryptosymtwofishModel, b : CryptosymtwofishModel) -> CryptosymtwofishModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_model_copy(s : CryptosymtwofishModel) -> CryptosymtwofishModel {
  let result = crypto_sym_twofish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_model_fill(s : CryptosymtwofishModel, v : Double) -> CryptosymtwofishModel {
  let result = crypto_sym_twofish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_model_min(s : CryptosymtwofishModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_model_max(s : CryptosymtwofishModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_model_to_string(s : CryptosymtwofishModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_layer_make(size : Int) -> CryptosymtwofishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_layer_len(s : CryptosymtwofishLayer) -> Int { s.size }

pub fn crypto_sym_twofish_layer_get(s : CryptosymtwofishLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_layer_set(s : CryptosymtwofishLayer, i : Int, v : Double) -> CryptosymtwofishLayer {
  let result = crypto_sym_twofish_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_layer_sum(s : CryptosymtwofishLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_layer_mean(s : CryptosymtwofishLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_layer_scale(s : CryptosymtwofishLayer, f : Double) -> CryptosymtwofishLayer {
  let result = crypto_sym_twofish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_layer_add(a : CryptosymtwofishLayer, b : CryptosymtwofishLayer) -> CryptosymtwofishLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_layer_copy(s : CryptosymtwofishLayer) -> CryptosymtwofishLayer {
  let result = crypto_sym_twofish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_layer_fill(s : CryptosymtwofishLayer, v : Double) -> CryptosymtwofishLayer {
  let result = crypto_sym_twofish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_layer_min(s : CryptosymtwofishLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_layer_max(s : CryptosymtwofishLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_layer_to_string(s : CryptosymtwofishLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_buffer_make(size : Int) -> CryptosymtwofishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_buffer_len(s : CryptosymtwofishBuffer) -> Int { s.size }

pub fn crypto_sym_twofish_buffer_get(s : CryptosymtwofishBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_buffer_set(s : CryptosymtwofishBuffer, i : Int, v : Double) -> CryptosymtwofishBuffer {
  let result = crypto_sym_twofish_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_buffer_sum(s : CryptosymtwofishBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_buffer_mean(s : CryptosymtwofishBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_buffer_scale(s : CryptosymtwofishBuffer, f : Double) -> CryptosymtwofishBuffer {
  let result = crypto_sym_twofish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_buffer_add(a : CryptosymtwofishBuffer, b : CryptosymtwofishBuffer) -> CryptosymtwofishBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_buffer_copy(s : CryptosymtwofishBuffer) -> CryptosymtwofishBuffer {
  let result = crypto_sym_twofish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_buffer_fill(s : CryptosymtwofishBuffer, v : Double) -> CryptosymtwofishBuffer {
  let result = crypto_sym_twofish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_buffer_min(s : CryptosymtwofishBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_buffer_max(s : CryptosymtwofishBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_buffer_to_string(s : CryptosymtwofishBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_cursor_make(size : Int) -> CryptosymtwofishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_cursor_len(s : CryptosymtwofishCursor) -> Int { s.size }

pub fn crypto_sym_twofish_cursor_get(s : CryptosymtwofishCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_cursor_set(s : CryptosymtwofishCursor, i : Int, v : Double) -> CryptosymtwofishCursor {
  let result = crypto_sym_twofish_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_cursor_sum(s : CryptosymtwofishCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_cursor_mean(s : CryptosymtwofishCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_cursor_scale(s : CryptosymtwofishCursor, f : Double) -> CryptosymtwofishCursor {
  let result = crypto_sym_twofish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_cursor_add(a : CryptosymtwofishCursor, b : CryptosymtwofishCursor) -> CryptosymtwofishCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_cursor_copy(s : CryptosymtwofishCursor) -> CryptosymtwofishCursor {
  let result = crypto_sym_twofish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_cursor_fill(s : CryptosymtwofishCursor, v : Double) -> CryptosymtwofishCursor {
  let result = crypto_sym_twofish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_cursor_min(s : CryptosymtwofishCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_cursor_max(s : CryptosymtwofishCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_cursor_to_string(s : CryptosymtwofishCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_view_make(size : Int) -> CryptosymtwofishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_view_len(s : CryptosymtwofishView) -> Int { s.size }

pub fn crypto_sym_twofish_view_get(s : CryptosymtwofishView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_view_set(s : CryptosymtwofishView, i : Int, v : Double) -> CryptosymtwofishView {
  let result = crypto_sym_twofish_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_view_sum(s : CryptosymtwofishView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_view_mean(s : CryptosymtwofishView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_view_scale(s : CryptosymtwofishView, f : Double) -> CryptosymtwofishView {
  let result = crypto_sym_twofish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_view_add(a : CryptosymtwofishView, b : CryptosymtwofishView) -> CryptosymtwofishView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_view_copy(s : CryptosymtwofishView) -> CryptosymtwofishView {
  let result = crypto_sym_twofish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_view_fill(s : CryptosymtwofishView, v : Double) -> CryptosymtwofishView {
  let result = crypto_sym_twofish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_view_min(s : CryptosymtwofishView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_view_max(s : CryptosymtwofishView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_view_to_string(s : CryptosymtwofishView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_range_make(size : Int) -> CryptosymtwofishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_range_len(s : CryptosymtwofishRange) -> Int { s.size }

pub fn crypto_sym_twofish_range_get(s : CryptosymtwofishRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_range_set(s : CryptosymtwofishRange, i : Int, v : Double) -> CryptosymtwofishRange {
  let result = crypto_sym_twofish_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_range_sum(s : CryptosymtwofishRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_range_mean(s : CryptosymtwofishRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_range_scale(s : CryptosymtwofishRange, f : Double) -> CryptosymtwofishRange {
  let result = crypto_sym_twofish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_range_add(a : CryptosymtwofishRange, b : CryptosymtwofishRange) -> CryptosymtwofishRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_range_copy(s : CryptosymtwofishRange) -> CryptosymtwofishRange {
  let result = crypto_sym_twofish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_range_fill(s : CryptosymtwofishRange, v : Double) -> CryptosymtwofishRange {
  let result = crypto_sym_twofish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_range_min(s : CryptosymtwofishRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_range_max(s : CryptosymtwofishRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_range_to_string(s : CryptosymtwofishRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymtwofishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_twofish_slice_make(size : Int) -> CryptosymtwofishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_twofish_slice_len(s : CryptosymtwofishSlice) -> Int { s.size }

pub fn crypto_sym_twofish_slice_get(s : CryptosymtwofishSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_twofish_slice_set(s : CryptosymtwofishSlice, i : Int, v : Double) -> CryptosymtwofishSlice {
  let result = crypto_sym_twofish_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_slice_sum(s : CryptosymtwofishSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_twofish_slice_mean(s : CryptosymtwofishSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_twofish_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_twofish_slice_scale(s : CryptosymtwofishSlice, f : Double) -> CryptosymtwofishSlice {
  let result = crypto_sym_twofish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_twofish_slice_add(a : CryptosymtwofishSlice, b : CryptosymtwofishSlice) -> CryptosymtwofishSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_twofish_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_twofish_slice_copy(s : CryptosymtwofishSlice) -> CryptosymtwofishSlice {
  let result = crypto_sym_twofish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_twofish_slice_fill(s : CryptosymtwofishSlice, v : Double) -> CryptosymtwofishSlice {
  let result = crypto_sym_twofish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_twofish_slice_min(s : CryptosymtwofishSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_slice_max(s : CryptosymtwofishSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_twofish_slice_to_string(s : CryptosymtwofishSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

