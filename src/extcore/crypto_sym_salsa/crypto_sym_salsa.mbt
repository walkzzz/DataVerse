///===
/// extcore/crypto_sym_salsa

pub(all) struct CryptosymsalsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_salsa_make_point(x : Double, y : Double) -> CryptosymsalsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_salsa_make_point3(x : Double, y : Double, z : Double) -> CryptosymsalsaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_salsa_point_x(pt : CryptosymsalsaPoint) -> Double { pt.x }

pub fn crypto_sym_salsa_point_y(pt : CryptosymsalsaPoint) -> Double { pt.y }

pub fn crypto_sym_salsa_point_z(pt : CryptosymsalsaPoint) -> Double { pt.z }

pub fn crypto_sym_salsa_point_label(pt : CryptosymsalsaPoint) -> Int { pt.label }

pub fn crypto_sym_salsa_point_dist(a : CryptosymsalsaPoint, b : CryptosymsalsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_salsa_point_add(a : CryptosymsalsaPoint, b : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_salsa_point_sub(a : CryptosymsalsaPoint, b : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_salsa_point_scale(pt : CryptosymsalsaPoint, s : Double) -> CryptosymsalsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_salsa_point_dot(a : CryptosymsalsaPoint, b : CryptosymsalsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_salsa_point_cross(a : CryptosymsalsaPoint, b : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_salsa_point_norm(pt : CryptosymsalsaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_salsa_point_normalize(pt : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  let n = crypto_sym_salsa_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_salsa_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_salsa_point_negate(pt : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_salsa_point_mid(a : CryptosymsalsaPoint, b : CryptosymsalsaPoint) -> CryptosymsalsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_salsa_point_lerp(a : CryptosymsalsaPoint, b : CryptosymsalsaPoint, t : Double) -> CryptosymsalsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_salsa_point_to_string(pt : CryptosymsalsaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymsalsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_salsa_make_series(vals : Array[Double], name : String) -> CryptosymsalsaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_salsa_series_len(s : CryptosymsalsaSeries) -> Int { s.vals.length() }

pub fn crypto_sym_salsa_series_sum(s : CryptosymsalsaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sym_salsa_series_mean(s : CryptosymsalsaSeries) -> Double {
  let n = crypto_sym_salsa_series_len(s)
  if n == 0 { 0.0 } else { crypto_sym_salsa_series_sum(s) / n.to_double() }
}

pub fn crypto_sym_salsa_series_min(s : CryptosymsalsaSeries) -> Double {
  let n = crypto_sym_salsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_salsa_series_max(s : CryptosymsalsaSeries) -> Double {
  let n = crypto_sym_salsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_salsa_series_range(s : CryptosymsalsaSeries) -> Double {
  crypto_sym_salsa_series_max(s) - crypto_sym_salsa_series_min(s)
}

pub fn crypto_sym_salsa_series_var(s : CryptosymsalsaSeries) -> Double {
  let n = crypto_sym_salsa_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sym_salsa_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sym_salsa_series_std(s : CryptosymsalsaSeries) -> Double { @_common.sqrt(crypto_sym_salsa_series_var(s)) }

pub fn crypto_sym_salsa_series_median(s : CryptosymsalsaSeries) -> Double {
  let n = crypto_sym_salsa_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_salsa_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_salsa_series_scale(s : CryptosymsalsaSeries, f : Double) -> CryptosymsalsaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_salsa_series_add(a : CryptosymsalsaSeries, b : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_salsa_series_sub(a : CryptosymsalsaSeries, b : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_salsa_series_normalize(s : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  let mn = crypto_sym_salsa_series_min(s)
  let mx = crypto_sym_salsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_salsa_series_cumsum(s : CryptosymsalsaSeries) -> CryptosymsalsaSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_salsa_series_to_string(s : CryptosymsalsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymsalsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_salsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymsalsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_salsa_matrix_identity(n : Int) -> CryptosymsalsaMatrix {
  let m = crypto_sym_salsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_salsa_matrix_get(m : CryptosymsalsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_salsa_matrix_transpose(m : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  let result = crypto_sym_salsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_salsa_matrix_add(a : CryptosymsalsaMatrix, b : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_salsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_salsa_matrix_scale(m : CryptosymsalsaMatrix, s : Double) -> CryptosymsalsaMatrix {
  let result = crypto_sym_salsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_salsa_matrix_multiply(a : CryptosymsalsaMatrix, b : CryptosymsalsaMatrix) -> CryptosymsalsaMatrix {
  if a.cols != b.rows { return crypto_sym_salsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_salsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_salsa_matrix_trace(m : CryptosymsalsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_salsa_matrix_det(m : CryptosymsalsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_salsa_matrix_norm(m : CryptosymsalsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_salsa_matrix_to_string(m : CryptosymsalsaMatrix) -> String {
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

pub(all) struct CryptosymsalsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_salsa_make_vector(comps : Array[Double]) -> CryptosymsalsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_salsa_vector_zero(dim : Int) -> CryptosymsalsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_salsa_vector_add(a : CryptosymsalsaVector, b : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_salsa_vector_sub(a : CryptosymsalsaVector, b : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_salsa_vector_scale(v : CryptosymsalsaVector, s : Double) -> CryptosymsalsaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_salsa_vector_dot(a : CryptosymsalsaVector, b : CryptosymsalsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_salsa_vector_norm(v : CryptosymsalsaVector) -> Double { @_common.sqrt(crypto_sym_salsa_vector_dot(v, v)) }

pub fn crypto_sym_salsa_vector_normalize(v : CryptosymsalsaVector) -> CryptosymsalsaVector {
  let n = crypto_sym_salsa_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_salsa_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_salsa_vector_dist(a : CryptosymsalsaVector, b : CryptosymsalsaVector) -> Double {
  crypto_sym_salsa_vector_norm(crypto_sym_salsa_vector_sub(a, b))
}

pub fn crypto_sym_salsa_vector_to_string(v : CryptosymsalsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_salsa_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sym_salsa_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sym_salsa_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_salsa_std(data : Array[Double]) -> Double { @_common.sqrt(crypto_sym_salsa_var(data)) }

pub fn crypto_sym_salsa_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sym_salsa_mean(a); let mb = crypto_sym_salsa_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_salsa_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sym_salsa_std(a); let sb = crypto_sym_salsa_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sym_salsa_cov(a, b) / (sa * sb) }
}

pub fn crypto_sym_salsa_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_salsa_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_salsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sym_salsa_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_salsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(crypto_sym_salsa_mse(pred, labels))
}

pub fn crypto_sym_salsa_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_salsa_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sym_salsa_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sym_salsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sym_salsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sym_salsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sym_salsa_precision(pred, labels, pos); let r = crypto_sym_salsa_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sym_salsa_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sym_salsa_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sym_salsa_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sym_salsa_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sym_salsa_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sym_salsa_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sym_salsa_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sym_salsa_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sym_salsa_fibonacci(n : Int) -> Int {
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

pub fn crypto_sym_salsa_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sym_salsa_min(data); let mx = crypto_sym_salsa_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sym_salsa_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sym_salsa_mean(data); let sd = crypto_sym_salsa_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sym_salsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sym_salsa_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sym_salsa_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sym_salsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct CryptosymsalsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_frame_make(size : Int) -> CryptosymsalsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_frame_len(s : CryptosymsalsaFrame) -> Int { s.size }

pub fn crypto_sym_salsa_frame_get(s : CryptosymsalsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_frame_set(s : CryptosymsalsaFrame, i : Int, v : Double) -> CryptosymsalsaFrame {
  let result = crypto_sym_salsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_frame_sum(s : CryptosymsalsaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_frame_mean(s : CryptosymsalsaFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_frame_scale(s : CryptosymsalsaFrame, f : Double) -> CryptosymsalsaFrame {
  let result = crypto_sym_salsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_frame_add(a : CryptosymsalsaFrame, b : CryptosymsalsaFrame) -> CryptosymsalsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_frame_copy(s : CryptosymsalsaFrame) -> CryptosymsalsaFrame {
  let result = crypto_sym_salsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_frame_fill(s : CryptosymsalsaFrame, v : Double) -> CryptosymsalsaFrame {
  let result = crypto_sym_salsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_frame_min(s : CryptosymsalsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_frame_max(s : CryptosymsalsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_frame_to_string(s : CryptosymsalsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_table_make(size : Int) -> CryptosymsalsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_table_len(s : CryptosymsalsaTable) -> Int { s.size }

pub fn crypto_sym_salsa_table_get(s : CryptosymsalsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_table_set(s : CryptosymsalsaTable, i : Int, v : Double) -> CryptosymsalsaTable {
  let result = crypto_sym_salsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_table_sum(s : CryptosymsalsaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_table_mean(s : CryptosymsalsaTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_table_scale(s : CryptosymsalsaTable, f : Double) -> CryptosymsalsaTable {
  let result = crypto_sym_salsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_table_add(a : CryptosymsalsaTable, b : CryptosymsalsaTable) -> CryptosymsalsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_table_copy(s : CryptosymsalsaTable) -> CryptosymsalsaTable {
  let result = crypto_sym_salsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_table_fill(s : CryptosymsalsaTable, v : Double) -> CryptosymsalsaTable {
  let result = crypto_sym_salsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_table_min(s : CryptosymsalsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_table_max(s : CryptosymsalsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_table_to_string(s : CryptosymsalsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_graphn_make(size : Int) -> CryptosymsalsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_graphn_len(s : CryptosymsalsaGraphN) -> Int { s.size }

pub fn crypto_sym_salsa_graphn_get(s : CryptosymsalsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_graphn_set(s : CryptosymsalsaGraphN, i : Int, v : Double) -> CryptosymsalsaGraphN {
  let result = crypto_sym_salsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_graphn_sum(s : CryptosymsalsaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_graphn_mean(s : CryptosymsalsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_graphn_scale(s : CryptosymsalsaGraphN, f : Double) -> CryptosymsalsaGraphN {
  let result = crypto_sym_salsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_graphn_add(a : CryptosymsalsaGraphN, b : CryptosymsalsaGraphN) -> CryptosymsalsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_graphn_copy(s : CryptosymsalsaGraphN) -> CryptosymsalsaGraphN {
  let result = crypto_sym_salsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_graphn_fill(s : CryptosymsalsaGraphN, v : Double) -> CryptosymsalsaGraphN {
  let result = crypto_sym_salsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_graphn_min(s : CryptosymsalsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_graphn_max(s : CryptosymsalsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_graphn_to_string(s : CryptosymsalsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_node_make(size : Int) -> CryptosymsalsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_node_len(s : CryptosymsalsaNode) -> Int { s.size }

pub fn crypto_sym_salsa_node_get(s : CryptosymsalsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_node_set(s : CryptosymsalsaNode, i : Int, v : Double) -> CryptosymsalsaNode {
  let result = crypto_sym_salsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_node_sum(s : CryptosymsalsaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_node_mean(s : CryptosymsalsaNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_node_scale(s : CryptosymsalsaNode, f : Double) -> CryptosymsalsaNode {
  let result = crypto_sym_salsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_node_add(a : CryptosymsalsaNode, b : CryptosymsalsaNode) -> CryptosymsalsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_node_copy(s : CryptosymsalsaNode) -> CryptosymsalsaNode {
  let result = crypto_sym_salsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_node_fill(s : CryptosymsalsaNode, v : Double) -> CryptosymsalsaNode {
  let result = crypto_sym_salsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_node_min(s : CryptosymsalsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_node_max(s : CryptosymsalsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_node_to_string(s : CryptosymsalsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_edge_make(size : Int) -> CryptosymsalsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_edge_len(s : CryptosymsalsaEdge) -> Int { s.size }

pub fn crypto_sym_salsa_edge_get(s : CryptosymsalsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_edge_set(s : CryptosymsalsaEdge, i : Int, v : Double) -> CryptosymsalsaEdge {
  let result = crypto_sym_salsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_edge_sum(s : CryptosymsalsaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_edge_mean(s : CryptosymsalsaEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_edge_scale(s : CryptosymsalsaEdge, f : Double) -> CryptosymsalsaEdge {
  let result = crypto_sym_salsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_edge_add(a : CryptosymsalsaEdge, b : CryptosymsalsaEdge) -> CryptosymsalsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_edge_copy(s : CryptosymsalsaEdge) -> CryptosymsalsaEdge {
  let result = crypto_sym_salsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_edge_fill(s : CryptosymsalsaEdge, v : Double) -> CryptosymsalsaEdge {
  let result = crypto_sym_salsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_edge_min(s : CryptosymsalsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_edge_max(s : CryptosymsalsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_edge_to_string(s : CryptosymsalsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_path_make(size : Int) -> CryptosymsalsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_path_len(s : CryptosymsalsaPath) -> Int { s.size }

pub fn crypto_sym_salsa_path_get(s : CryptosymsalsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_path_set(s : CryptosymsalsaPath, i : Int, v : Double) -> CryptosymsalsaPath {
  let result = crypto_sym_salsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_path_sum(s : CryptosymsalsaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_path_mean(s : CryptosymsalsaPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_path_scale(s : CryptosymsalsaPath, f : Double) -> CryptosymsalsaPath {
  let result = crypto_sym_salsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_path_add(a : CryptosymsalsaPath, b : CryptosymsalsaPath) -> CryptosymsalsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_path_copy(s : CryptosymsalsaPath) -> CryptosymsalsaPath {
  let result = crypto_sym_salsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_path_fill(s : CryptosymsalsaPath, v : Double) -> CryptosymsalsaPath {
  let result = crypto_sym_salsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_path_min(s : CryptosymsalsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_path_max(s : CryptosymsalsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_path_to_string(s : CryptosymsalsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_cluster_make(size : Int) -> CryptosymsalsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_cluster_len(s : CryptosymsalsaCluster) -> Int { s.size }

pub fn crypto_sym_salsa_cluster_get(s : CryptosymsalsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_cluster_set(s : CryptosymsalsaCluster, i : Int, v : Double) -> CryptosymsalsaCluster {
  let result = crypto_sym_salsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_cluster_sum(s : CryptosymsalsaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_cluster_mean(s : CryptosymsalsaCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_cluster_scale(s : CryptosymsalsaCluster, f : Double) -> CryptosymsalsaCluster {
  let result = crypto_sym_salsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_cluster_add(a : CryptosymsalsaCluster, b : CryptosymsalsaCluster) -> CryptosymsalsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_cluster_copy(s : CryptosymsalsaCluster) -> CryptosymsalsaCluster {
  let result = crypto_sym_salsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_cluster_fill(s : CryptosymsalsaCluster, v : Double) -> CryptosymsalsaCluster {
  let result = crypto_sym_salsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_cluster_min(s : CryptosymsalsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_cluster_max(s : CryptosymsalsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_cluster_to_string(s : CryptosymsalsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_model_make(size : Int) -> CryptosymsalsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_model_len(s : CryptosymsalsaModel) -> Int { s.size }

pub fn crypto_sym_salsa_model_get(s : CryptosymsalsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_model_set(s : CryptosymsalsaModel, i : Int, v : Double) -> CryptosymsalsaModel {
  let result = crypto_sym_salsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_model_sum(s : CryptosymsalsaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_model_mean(s : CryptosymsalsaModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_model_scale(s : CryptosymsalsaModel, f : Double) -> CryptosymsalsaModel {
  let result = crypto_sym_salsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_model_add(a : CryptosymsalsaModel, b : CryptosymsalsaModel) -> CryptosymsalsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_model_copy(s : CryptosymsalsaModel) -> CryptosymsalsaModel {
  let result = crypto_sym_salsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_model_fill(s : CryptosymsalsaModel, v : Double) -> CryptosymsalsaModel {
  let result = crypto_sym_salsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_model_min(s : CryptosymsalsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_model_max(s : CryptosymsalsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_model_to_string(s : CryptosymsalsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_layer_make(size : Int) -> CryptosymsalsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_layer_len(s : CryptosymsalsaLayer) -> Int { s.size }

pub fn crypto_sym_salsa_layer_get(s : CryptosymsalsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_layer_set(s : CryptosymsalsaLayer, i : Int, v : Double) -> CryptosymsalsaLayer {
  let result = crypto_sym_salsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_layer_sum(s : CryptosymsalsaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_layer_mean(s : CryptosymsalsaLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_layer_scale(s : CryptosymsalsaLayer, f : Double) -> CryptosymsalsaLayer {
  let result = crypto_sym_salsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_layer_add(a : CryptosymsalsaLayer, b : CryptosymsalsaLayer) -> CryptosymsalsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_layer_copy(s : CryptosymsalsaLayer) -> CryptosymsalsaLayer {
  let result = crypto_sym_salsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_layer_fill(s : CryptosymsalsaLayer, v : Double) -> CryptosymsalsaLayer {
  let result = crypto_sym_salsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_layer_min(s : CryptosymsalsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_layer_max(s : CryptosymsalsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_layer_to_string(s : CryptosymsalsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_buffer_make(size : Int) -> CryptosymsalsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_buffer_len(s : CryptosymsalsaBuffer) -> Int { s.size }

pub fn crypto_sym_salsa_buffer_get(s : CryptosymsalsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_buffer_set(s : CryptosymsalsaBuffer, i : Int, v : Double) -> CryptosymsalsaBuffer {
  let result = crypto_sym_salsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_buffer_sum(s : CryptosymsalsaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_buffer_mean(s : CryptosymsalsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_buffer_scale(s : CryptosymsalsaBuffer, f : Double) -> CryptosymsalsaBuffer {
  let result = crypto_sym_salsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_buffer_add(a : CryptosymsalsaBuffer, b : CryptosymsalsaBuffer) -> CryptosymsalsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_buffer_copy(s : CryptosymsalsaBuffer) -> CryptosymsalsaBuffer {
  let result = crypto_sym_salsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_buffer_fill(s : CryptosymsalsaBuffer, v : Double) -> CryptosymsalsaBuffer {
  let result = crypto_sym_salsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_buffer_min(s : CryptosymsalsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_buffer_max(s : CryptosymsalsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_buffer_to_string(s : CryptosymsalsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_cursor_make(size : Int) -> CryptosymsalsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_cursor_len(s : CryptosymsalsaCursor) -> Int { s.size }

pub fn crypto_sym_salsa_cursor_get(s : CryptosymsalsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_cursor_set(s : CryptosymsalsaCursor, i : Int, v : Double) -> CryptosymsalsaCursor {
  let result = crypto_sym_salsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_cursor_sum(s : CryptosymsalsaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_cursor_mean(s : CryptosymsalsaCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_cursor_scale(s : CryptosymsalsaCursor, f : Double) -> CryptosymsalsaCursor {
  let result = crypto_sym_salsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_cursor_add(a : CryptosymsalsaCursor, b : CryptosymsalsaCursor) -> CryptosymsalsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_cursor_copy(s : CryptosymsalsaCursor) -> CryptosymsalsaCursor {
  let result = crypto_sym_salsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_cursor_fill(s : CryptosymsalsaCursor, v : Double) -> CryptosymsalsaCursor {
  let result = crypto_sym_salsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_cursor_min(s : CryptosymsalsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_cursor_max(s : CryptosymsalsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_cursor_to_string(s : CryptosymsalsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_view_make(size : Int) -> CryptosymsalsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_view_len(s : CryptosymsalsaView) -> Int { s.size }

pub fn crypto_sym_salsa_view_get(s : CryptosymsalsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_view_set(s : CryptosymsalsaView, i : Int, v : Double) -> CryptosymsalsaView {
  let result = crypto_sym_salsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_view_sum(s : CryptosymsalsaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_view_mean(s : CryptosymsalsaView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_view_scale(s : CryptosymsalsaView, f : Double) -> CryptosymsalsaView {
  let result = crypto_sym_salsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_view_add(a : CryptosymsalsaView, b : CryptosymsalsaView) -> CryptosymsalsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_view_copy(s : CryptosymsalsaView) -> CryptosymsalsaView {
  let result = crypto_sym_salsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_view_fill(s : CryptosymsalsaView, v : Double) -> CryptosymsalsaView {
  let result = crypto_sym_salsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_view_min(s : CryptosymsalsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_view_max(s : CryptosymsalsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_view_to_string(s : CryptosymsalsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_range_make(size : Int) -> CryptosymsalsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_range_len(s : CryptosymsalsaRange) -> Int { s.size }

pub fn crypto_sym_salsa_range_get(s : CryptosymsalsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_range_set(s : CryptosymsalsaRange, i : Int, v : Double) -> CryptosymsalsaRange {
  let result = crypto_sym_salsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_range_sum(s : CryptosymsalsaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_range_mean(s : CryptosymsalsaRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_range_scale(s : CryptosymsalsaRange, f : Double) -> CryptosymsalsaRange {
  let result = crypto_sym_salsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_range_add(a : CryptosymsalsaRange, b : CryptosymsalsaRange) -> CryptosymsalsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_range_copy(s : CryptosymsalsaRange) -> CryptosymsalsaRange {
  let result = crypto_sym_salsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_range_fill(s : CryptosymsalsaRange, v : Double) -> CryptosymsalsaRange {
  let result = crypto_sym_salsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_range_min(s : CryptosymsalsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_range_max(s : CryptosymsalsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_range_to_string(s : CryptosymsalsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymsalsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_salsa_slice_make(size : Int) -> CryptosymsalsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_salsa_slice_len(s : CryptosymsalsaSlice) -> Int { s.size }

pub fn crypto_sym_salsa_slice_get(s : CryptosymsalsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_salsa_slice_set(s : CryptosymsalsaSlice, i : Int, v : Double) -> CryptosymsalsaSlice {
  let result = crypto_sym_salsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_slice_sum(s : CryptosymsalsaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_salsa_slice_mean(s : CryptosymsalsaSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_salsa_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_salsa_slice_scale(s : CryptosymsalsaSlice, f : Double) -> CryptosymsalsaSlice {
  let result = crypto_sym_salsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_salsa_slice_add(a : CryptosymsalsaSlice, b : CryptosymsalsaSlice) -> CryptosymsalsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_salsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_salsa_slice_copy(s : CryptosymsalsaSlice) -> CryptosymsalsaSlice {
  let result = crypto_sym_salsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_salsa_slice_fill(s : CryptosymsalsaSlice, v : Double) -> CryptosymsalsaSlice {
  let result = crypto_sym_salsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_salsa_slice_min(s : CryptosymsalsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_slice_max(s : CryptosymsalsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_salsa_slice_to_string(s : CryptosymsalsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

