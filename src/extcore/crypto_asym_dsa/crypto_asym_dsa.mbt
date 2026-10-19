///===
/// extcore/crypto_asym_dsa

pub(all) struct CryptoasymdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_dsa_make_point(x : Double, y : Double) -> CryptoasymdsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_dsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymdsaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_dsa_point_x(pt : CryptoasymdsaPoint) -> Double { pt.x }

pub fn crypto_asym_dsa_point_y(pt : CryptoasymdsaPoint) -> Double { pt.y }

pub fn crypto_asym_dsa_point_z(pt : CryptoasymdsaPoint) -> Double { pt.z }

pub fn crypto_asym_dsa_point_label(pt : CryptoasymdsaPoint) -> Int { pt.label }

pub fn crypto_asym_dsa_point_dist(a : CryptoasymdsaPoint, b : CryptoasymdsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_asym_dsa_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_dsa_point_add(a : CryptoasymdsaPoint, b : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_dsa_point_sub(a : CryptoasymdsaPoint, b : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_dsa_point_scale(pt : CryptoasymdsaPoint, s : Double) -> CryptoasymdsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_dsa_point_dot(a : CryptoasymdsaPoint, b : CryptoasymdsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_dsa_point_cross(a : CryptoasymdsaPoint, b : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_dsa_point_norm(pt : CryptoasymdsaPoint) -> Double {
  crypto_asym_dsa_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_dsa_point_normalize(pt : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  let n = crypto_asym_dsa_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_dsa_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_dsa_point_negate(pt : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_dsa_point_mid(a : CryptoasymdsaPoint, b : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_dsa_point_lerp(a : CryptoasymdsaPoint, b : CryptoasymdsaPoint, t : Double) -> CryptoasymdsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_dsa_point_to_string(pt : CryptoasymdsaPoint) -> String {
  "(" + crypto_asym_dsa_dbl(pt.x) + ", " + crypto_asym_dsa_dbl(pt.y) + ", " + crypto_asym_dsa_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptoasymdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_dsa_make_series(vals : Array[Double], name : String) -> CryptoasymdsaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_dsa_series_len(s : CryptoasymdsaSeries) -> Int { s.vals.length() }

pub fn crypto_asym_dsa_series_sum(s : CryptoasymdsaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_asym_dsa_series_mean(s : CryptoasymdsaSeries) -> Double {
  let n = crypto_asym_dsa_series_len(s)
  if n == 0 { 0.0 } else { crypto_asym_dsa_series_sum(s) / n.to_double() }
}

pub fn crypto_asym_dsa_series_min(s : CryptoasymdsaSeries) -> Double {
  let n = crypto_asym_dsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_asym_dsa_series_max(s : CryptoasymdsaSeries) -> Double {
  let n = crypto_asym_dsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_asym_dsa_series_range(s : CryptoasymdsaSeries) -> Double {
  crypto_asym_dsa_series_max(s) - crypto_asym_dsa_series_min(s)
}

pub fn crypto_asym_dsa_series_var(s : CryptoasymdsaSeries) -> Double {
  let n = crypto_asym_dsa_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_asym_dsa_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_asym_dsa_series_std(s : CryptoasymdsaSeries) -> Double { crypto_asym_dsa_sqrt(crypto_asym_dsa_series_var(s)) }

pub fn crypto_asym_dsa_series_median(s : CryptoasymdsaSeries) -> Double {
  let n = crypto_asym_dsa_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_asym_dsa_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_asym_dsa_series_scale(s : CryptoasymdsaSeries, f : Double) -> CryptoasymdsaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_asym_dsa_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_asym_dsa_series_add(a : CryptoasymdsaSeries, b : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_asym_dsa_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_dsa_series_sub(a : CryptoasymdsaSeries, b : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_asym_dsa_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_dsa_series_normalize(s : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  let mn = crypto_asym_dsa_series_min(s)
  let mx = crypto_asym_dsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_asym_dsa_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_dsa_series_cumsum(s : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_asym_dsa_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_dsa_series_to_string(s : CryptoasymdsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_asym_dsa_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymdsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_dsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymdsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_dsa_matrix_identity(n : Int) -> CryptoasymdsaMatrix {
  let m = crypto_asym_dsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_dsa_matrix_get(m : CryptoasymdsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_dsa_matrix_transpose(m : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  let result = crypto_asym_dsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_dsa_matrix_add(a : CryptoasymdsaMatrix, b : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_dsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_dsa_matrix_scale(m : CryptoasymdsaMatrix, s : Double) -> CryptoasymdsaMatrix {
  let result = crypto_asym_dsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_dsa_matrix_multiply(a : CryptoasymdsaMatrix, b : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  if a.cols != b.rows { return crypto_asym_dsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_dsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_dsa_matrix_trace(m : CryptoasymdsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_dsa_matrix_det(m : CryptoasymdsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_dsa_matrix_norm(m : CryptoasymdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_asym_dsa_sqrt(sum)
}

pub fn crypto_asym_dsa_matrix_to_string(m : CryptoasymdsaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_asym_dsa_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptoasymdsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_dsa_make_vector(comps : Array[Double]) -> CryptoasymdsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_dsa_vector_zero(dim : Int) -> CryptoasymdsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_dsa_vector_add(a : CryptoasymdsaVector, b : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_asym_dsa_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_dsa_vector_sub(a : CryptoasymdsaVector, b : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_asym_dsa_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_dsa_vector_scale(v : CryptoasymdsaVector, s : Double) -> CryptoasymdsaVector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_asym_dsa_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_asym_dsa_vector_dot(a : CryptoasymdsaVector, b : CryptoasymdsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_dsa_vector_norm(v : CryptoasymdsaVector) -> Double { crypto_asym_dsa_sqrt(crypto_asym_dsa_vector_dot(v, v)) }

pub fn crypto_asym_dsa_vector_normalize(v : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = crypto_asym_dsa_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_dsa_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_dsa_vector_dist(a : CryptoasymdsaVector, b : CryptoasymdsaVector) -> Double {
  crypto_asym_dsa_vector_norm(crypto_asym_dsa_vector_sub(a, b))
}

pub fn crypto_asym_dsa_vector_to_string(v : CryptoasymdsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_asym_dsa_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_dsa_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_asym_dsa_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_asym_dsa_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_asym_dsa_std(data : Array[Double]) -> Double { crypto_asym_dsa_sqrt(crypto_asym_dsa_var(data)) }

pub fn crypto_asym_dsa_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_asym_dsa_mean(a); let mb = crypto_asym_dsa_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_asym_dsa_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_asym_dsa_std(a); let sb = crypto_asym_dsa_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_asym_dsa_cov(a, b) / (sa * sb) }
}

pub fn crypto_asym_dsa_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_asym_dsa_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_asym_dsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_asym_dsa_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_asym_dsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_asym_dsa_sqrt(crypto_asym_dsa_mse(pred, labels))
}

pub fn crypto_asym_dsa_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_asym_dsa_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_asym_dsa_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_asym_dsa_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_asym_dsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_asym_dsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_asym_dsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_asym_dsa_precision(pred, labels, pos); let r = crypto_asym_dsa_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_asym_dsa_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_asym_dsa_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_asym_dsa_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_asym_dsa_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_asym_dsa_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_asym_dsa_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_asym_dsa_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_asym_dsa_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_asym_dsa_fibonacci(n : Int) -> Int {
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

pub fn crypto_asym_dsa_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_asym_dsa_min(data); let mx = crypto_asym_dsa_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_asym_dsa_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_asym_dsa_mean(data); let sd = crypto_asym_dsa_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_asym_dsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_asym_dsa_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_asym_dsa_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_asym_dsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_asym_dsa_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_asym_dsa_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_asym_dsa_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_asym_dsa_int(x) } else { -crypto_asym_dsa_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_asym_dsa_int(f * 1000000.0) } else { crypto_asym_dsa_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_asym_dsa_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_asym_dsa_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct CryptoasymdsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_frame_make(size : Int) -> CryptoasymdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_frame_len(s : CryptoasymdsaFrame) -> Int { s.size }

pub fn crypto_asym_dsa_frame_get(s : CryptoasymdsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_frame_set(s : CryptoasymdsaFrame, i : Int, v : Double) -> CryptoasymdsaFrame {
  let result = crypto_asym_dsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_frame_sum(s : CryptoasymdsaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_frame_mean(s : CryptoasymdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_frame_scale(s : CryptoasymdsaFrame, f : Double) -> CryptoasymdsaFrame {
  let result = crypto_asym_dsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_frame_add(a : CryptoasymdsaFrame, b : CryptoasymdsaFrame) -> CryptoasymdsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_frame_copy(s : CryptoasymdsaFrame) -> CryptoasymdsaFrame {
  let result = crypto_asym_dsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_frame_fill(s : CryptoasymdsaFrame, v : Double) -> CryptoasymdsaFrame {
  let result = crypto_asym_dsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_frame_min(s : CryptoasymdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_frame_max(s : CryptoasymdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_frame_to_string(s : CryptoasymdsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_table_make(size : Int) -> CryptoasymdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_table_len(s : CryptoasymdsaTable) -> Int { s.size }

pub fn crypto_asym_dsa_table_get(s : CryptoasymdsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_table_set(s : CryptoasymdsaTable, i : Int, v : Double) -> CryptoasymdsaTable {
  let result = crypto_asym_dsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_table_sum(s : CryptoasymdsaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_table_mean(s : CryptoasymdsaTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_table_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_table_scale(s : CryptoasymdsaTable, f : Double) -> CryptoasymdsaTable {
  let result = crypto_asym_dsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_table_add(a : CryptoasymdsaTable, b : CryptoasymdsaTable) -> CryptoasymdsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_table_copy(s : CryptoasymdsaTable) -> CryptoasymdsaTable {
  let result = crypto_asym_dsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_table_fill(s : CryptoasymdsaTable, v : Double) -> CryptoasymdsaTable {
  let result = crypto_asym_dsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_table_min(s : CryptoasymdsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_table_max(s : CryptoasymdsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_table_to_string(s : CryptoasymdsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_graphn_make(size : Int) -> CryptoasymdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_graphn_len(s : CryptoasymdsaGraphN) -> Int { s.size }

pub fn crypto_asym_dsa_graphn_get(s : CryptoasymdsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_graphn_set(s : CryptoasymdsaGraphN, i : Int, v : Double) -> CryptoasymdsaGraphN {
  let result = crypto_asym_dsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_graphn_sum(s : CryptoasymdsaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_graphn_mean(s : CryptoasymdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_graphn_scale(s : CryptoasymdsaGraphN, f : Double) -> CryptoasymdsaGraphN {
  let result = crypto_asym_dsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_graphn_add(a : CryptoasymdsaGraphN, b : CryptoasymdsaGraphN) -> CryptoasymdsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_graphn_copy(s : CryptoasymdsaGraphN) -> CryptoasymdsaGraphN {
  let result = crypto_asym_dsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_graphn_fill(s : CryptoasymdsaGraphN, v : Double) -> CryptoasymdsaGraphN {
  let result = crypto_asym_dsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_graphn_min(s : CryptoasymdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_graphn_max(s : CryptoasymdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_graphn_to_string(s : CryptoasymdsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_node_make(size : Int) -> CryptoasymdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_node_len(s : CryptoasymdsaNode) -> Int { s.size }

pub fn crypto_asym_dsa_node_get(s : CryptoasymdsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_node_set(s : CryptoasymdsaNode, i : Int, v : Double) -> CryptoasymdsaNode {
  let result = crypto_asym_dsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_node_sum(s : CryptoasymdsaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_node_mean(s : CryptoasymdsaNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_node_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_node_scale(s : CryptoasymdsaNode, f : Double) -> CryptoasymdsaNode {
  let result = crypto_asym_dsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_node_add(a : CryptoasymdsaNode, b : CryptoasymdsaNode) -> CryptoasymdsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_node_copy(s : CryptoasymdsaNode) -> CryptoasymdsaNode {
  let result = crypto_asym_dsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_node_fill(s : CryptoasymdsaNode, v : Double) -> CryptoasymdsaNode {
  let result = crypto_asym_dsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_node_min(s : CryptoasymdsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_node_max(s : CryptoasymdsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_node_to_string(s : CryptoasymdsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_edge_make(size : Int) -> CryptoasymdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_edge_len(s : CryptoasymdsaEdge) -> Int { s.size }

pub fn crypto_asym_dsa_edge_get(s : CryptoasymdsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_edge_set(s : CryptoasymdsaEdge, i : Int, v : Double) -> CryptoasymdsaEdge {
  let result = crypto_asym_dsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_edge_sum(s : CryptoasymdsaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_edge_mean(s : CryptoasymdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_edge_scale(s : CryptoasymdsaEdge, f : Double) -> CryptoasymdsaEdge {
  let result = crypto_asym_dsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_edge_add(a : CryptoasymdsaEdge, b : CryptoasymdsaEdge) -> CryptoasymdsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_edge_copy(s : CryptoasymdsaEdge) -> CryptoasymdsaEdge {
  let result = crypto_asym_dsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_edge_fill(s : CryptoasymdsaEdge, v : Double) -> CryptoasymdsaEdge {
  let result = crypto_asym_dsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_edge_min(s : CryptoasymdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_edge_max(s : CryptoasymdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_edge_to_string(s : CryptoasymdsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_path_make(size : Int) -> CryptoasymdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_path_len(s : CryptoasymdsaPath) -> Int { s.size }

pub fn crypto_asym_dsa_path_get(s : CryptoasymdsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_path_set(s : CryptoasymdsaPath, i : Int, v : Double) -> CryptoasymdsaPath {
  let result = crypto_asym_dsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_path_sum(s : CryptoasymdsaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_path_mean(s : CryptoasymdsaPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_path_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_path_scale(s : CryptoasymdsaPath, f : Double) -> CryptoasymdsaPath {
  let result = crypto_asym_dsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_path_add(a : CryptoasymdsaPath, b : CryptoasymdsaPath) -> CryptoasymdsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_path_copy(s : CryptoasymdsaPath) -> CryptoasymdsaPath {
  let result = crypto_asym_dsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_path_fill(s : CryptoasymdsaPath, v : Double) -> CryptoasymdsaPath {
  let result = crypto_asym_dsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_path_min(s : CryptoasymdsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_path_max(s : CryptoasymdsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_path_to_string(s : CryptoasymdsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_cluster_make(size : Int) -> CryptoasymdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_cluster_len(s : CryptoasymdsaCluster) -> Int { s.size }

pub fn crypto_asym_dsa_cluster_get(s : CryptoasymdsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_cluster_set(s : CryptoasymdsaCluster, i : Int, v : Double) -> CryptoasymdsaCluster {
  let result = crypto_asym_dsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_cluster_sum(s : CryptoasymdsaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_cluster_mean(s : CryptoasymdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_cluster_scale(s : CryptoasymdsaCluster, f : Double) -> CryptoasymdsaCluster {
  let result = crypto_asym_dsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_cluster_add(a : CryptoasymdsaCluster, b : CryptoasymdsaCluster) -> CryptoasymdsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_cluster_copy(s : CryptoasymdsaCluster) -> CryptoasymdsaCluster {
  let result = crypto_asym_dsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_cluster_fill(s : CryptoasymdsaCluster, v : Double) -> CryptoasymdsaCluster {
  let result = crypto_asym_dsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_cluster_min(s : CryptoasymdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_cluster_max(s : CryptoasymdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_cluster_to_string(s : CryptoasymdsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_model_make(size : Int) -> CryptoasymdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_model_len(s : CryptoasymdsaModel) -> Int { s.size }

pub fn crypto_asym_dsa_model_get(s : CryptoasymdsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_model_set(s : CryptoasymdsaModel, i : Int, v : Double) -> CryptoasymdsaModel {
  let result = crypto_asym_dsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_model_sum(s : CryptoasymdsaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_model_mean(s : CryptoasymdsaModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_model_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_model_scale(s : CryptoasymdsaModel, f : Double) -> CryptoasymdsaModel {
  let result = crypto_asym_dsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_model_add(a : CryptoasymdsaModel, b : CryptoasymdsaModel) -> CryptoasymdsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_model_copy(s : CryptoasymdsaModel) -> CryptoasymdsaModel {
  let result = crypto_asym_dsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_model_fill(s : CryptoasymdsaModel, v : Double) -> CryptoasymdsaModel {
  let result = crypto_asym_dsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_model_min(s : CryptoasymdsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_model_max(s : CryptoasymdsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_model_to_string(s : CryptoasymdsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_layer_make(size : Int) -> CryptoasymdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_layer_len(s : CryptoasymdsaLayer) -> Int { s.size }

pub fn crypto_asym_dsa_layer_get(s : CryptoasymdsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_layer_set(s : CryptoasymdsaLayer, i : Int, v : Double) -> CryptoasymdsaLayer {
  let result = crypto_asym_dsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_layer_sum(s : CryptoasymdsaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_layer_mean(s : CryptoasymdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_layer_scale(s : CryptoasymdsaLayer, f : Double) -> CryptoasymdsaLayer {
  let result = crypto_asym_dsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_layer_add(a : CryptoasymdsaLayer, b : CryptoasymdsaLayer) -> CryptoasymdsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_layer_copy(s : CryptoasymdsaLayer) -> CryptoasymdsaLayer {
  let result = crypto_asym_dsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_layer_fill(s : CryptoasymdsaLayer, v : Double) -> CryptoasymdsaLayer {
  let result = crypto_asym_dsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_layer_min(s : CryptoasymdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_layer_max(s : CryptoasymdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_layer_to_string(s : CryptoasymdsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_buffer_make(size : Int) -> CryptoasymdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_buffer_len(s : CryptoasymdsaBuffer) -> Int { s.size }

pub fn crypto_asym_dsa_buffer_get(s : CryptoasymdsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_buffer_set(s : CryptoasymdsaBuffer, i : Int, v : Double) -> CryptoasymdsaBuffer {
  let result = crypto_asym_dsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_buffer_sum(s : CryptoasymdsaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_buffer_mean(s : CryptoasymdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_buffer_scale(s : CryptoasymdsaBuffer, f : Double) -> CryptoasymdsaBuffer {
  let result = crypto_asym_dsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_buffer_add(a : CryptoasymdsaBuffer, b : CryptoasymdsaBuffer) -> CryptoasymdsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_buffer_copy(s : CryptoasymdsaBuffer) -> CryptoasymdsaBuffer {
  let result = crypto_asym_dsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_buffer_fill(s : CryptoasymdsaBuffer, v : Double) -> CryptoasymdsaBuffer {
  let result = crypto_asym_dsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_buffer_min(s : CryptoasymdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_buffer_max(s : CryptoasymdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_buffer_to_string(s : CryptoasymdsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_cursor_make(size : Int) -> CryptoasymdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_cursor_len(s : CryptoasymdsaCursor) -> Int { s.size }

pub fn crypto_asym_dsa_cursor_get(s : CryptoasymdsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_cursor_set(s : CryptoasymdsaCursor, i : Int, v : Double) -> CryptoasymdsaCursor {
  let result = crypto_asym_dsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_cursor_sum(s : CryptoasymdsaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_cursor_mean(s : CryptoasymdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_cursor_scale(s : CryptoasymdsaCursor, f : Double) -> CryptoasymdsaCursor {
  let result = crypto_asym_dsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_cursor_add(a : CryptoasymdsaCursor, b : CryptoasymdsaCursor) -> CryptoasymdsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_cursor_copy(s : CryptoasymdsaCursor) -> CryptoasymdsaCursor {
  let result = crypto_asym_dsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_cursor_fill(s : CryptoasymdsaCursor, v : Double) -> CryptoasymdsaCursor {
  let result = crypto_asym_dsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_cursor_min(s : CryptoasymdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_cursor_max(s : CryptoasymdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_cursor_to_string(s : CryptoasymdsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_view_make(size : Int) -> CryptoasymdsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_view_len(s : CryptoasymdsaView) -> Int { s.size }

pub fn crypto_asym_dsa_view_get(s : CryptoasymdsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_view_set(s : CryptoasymdsaView, i : Int, v : Double) -> CryptoasymdsaView {
  let result = crypto_asym_dsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_view_sum(s : CryptoasymdsaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_view_mean(s : CryptoasymdsaView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_view_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_view_scale(s : CryptoasymdsaView, f : Double) -> CryptoasymdsaView {
  let result = crypto_asym_dsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_view_add(a : CryptoasymdsaView, b : CryptoasymdsaView) -> CryptoasymdsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_view_copy(s : CryptoasymdsaView) -> CryptoasymdsaView {
  let result = crypto_asym_dsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_view_fill(s : CryptoasymdsaView, v : Double) -> CryptoasymdsaView {
  let result = crypto_asym_dsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_view_min(s : CryptoasymdsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_view_max(s : CryptoasymdsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_view_to_string(s : CryptoasymdsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_range_make(size : Int) -> CryptoasymdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_range_len(s : CryptoasymdsaRange) -> Int { s.size }

pub fn crypto_asym_dsa_range_get(s : CryptoasymdsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_range_set(s : CryptoasymdsaRange, i : Int, v : Double) -> CryptoasymdsaRange {
  let result = crypto_asym_dsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_range_sum(s : CryptoasymdsaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_range_mean(s : CryptoasymdsaRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_range_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_range_scale(s : CryptoasymdsaRange, f : Double) -> CryptoasymdsaRange {
  let result = crypto_asym_dsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_range_add(a : CryptoasymdsaRange, b : CryptoasymdsaRange) -> CryptoasymdsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_range_copy(s : CryptoasymdsaRange) -> CryptoasymdsaRange {
  let result = crypto_asym_dsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_range_fill(s : CryptoasymdsaRange, v : Double) -> CryptoasymdsaRange {
  let result = crypto_asym_dsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_range_min(s : CryptoasymdsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_range_max(s : CryptoasymdsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_range_to_string(s : CryptoasymdsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_slice_make(size : Int) -> CryptoasymdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_dsa_slice_len(s : CryptoasymdsaSlice) -> Int { s.size }

pub fn crypto_asym_dsa_slice_get(s : CryptoasymdsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_dsa_slice_set(s : CryptoasymdsaSlice, i : Int, v : Double) -> CryptoasymdsaSlice {
  let result = crypto_asym_dsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_slice_sum(s : CryptoasymdsaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_dsa_slice_mean(s : CryptoasymdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_dsa_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_dsa_slice_scale(s : CryptoasymdsaSlice, f : Double) -> CryptoasymdsaSlice {
  let result = crypto_asym_dsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_dsa_slice_add(a : CryptoasymdsaSlice, b : CryptoasymdsaSlice) -> CryptoasymdsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_dsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_dsa_slice_copy(s : CryptoasymdsaSlice) -> CryptoasymdsaSlice {
  let result = crypto_asym_dsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_dsa_slice_fill(s : CryptoasymdsaSlice, v : Double) -> CryptoasymdsaSlice {
  let result = crypto_asym_dsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_dsa_slice_min(s : CryptoasymdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_slice_max(s : CryptoasymdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_dsa_slice_to_string(s : CryptoasymdsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_asym_dsa_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_dsa_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

