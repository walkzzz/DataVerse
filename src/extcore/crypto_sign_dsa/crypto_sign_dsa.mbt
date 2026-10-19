///===
/// extcore/crypto_sign_dsa

pub(all) struct CryptosigndsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_dsa_make_point(x : Double, y : Double) -> CryptosigndsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_dsa_make_point3(x : Double, y : Double, z : Double) -> CryptosigndsaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_dsa_point_x(pt : CryptosigndsaPoint) -> Double { pt.x }

pub fn crypto_sign_dsa_point_y(pt : CryptosigndsaPoint) -> Double { pt.y }

pub fn crypto_sign_dsa_point_z(pt : CryptosigndsaPoint) -> Double { pt.z }

pub fn crypto_sign_dsa_point_label(pt : CryptosigndsaPoint) -> Int { pt.label }

pub fn crypto_sign_dsa_point_dist(a : CryptosigndsaPoint, b : CryptosigndsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_sign_dsa_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_dsa_point_add(a : CryptosigndsaPoint, b : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_dsa_point_sub(a : CryptosigndsaPoint, b : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_dsa_point_scale(pt : CryptosigndsaPoint, s : Double) -> CryptosigndsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_dsa_point_dot(a : CryptosigndsaPoint, b : CryptosigndsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_dsa_point_cross(a : CryptosigndsaPoint, b : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_dsa_point_norm(pt : CryptosigndsaPoint) -> Double {
  crypto_sign_dsa_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_dsa_point_normalize(pt : CryptosigndsaPoint) -> CryptosigndsaPoint {
  let n = crypto_sign_dsa_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_dsa_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_dsa_point_negate(pt : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_dsa_point_mid(a : CryptosigndsaPoint, b : CryptosigndsaPoint) -> CryptosigndsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_dsa_point_lerp(a : CryptosigndsaPoint, b : CryptosigndsaPoint, t : Double) -> CryptosigndsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_dsa_point_to_string(pt : CryptosigndsaPoint) -> String {
  "(" + crypto_sign_dsa_dbl(pt.x) + ", " + crypto_sign_dsa_dbl(pt.y) + ", " + crypto_sign_dsa_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosigndsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_dsa_make_series(vals : Array[Double], name : String) -> CryptosigndsaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_dsa_series_len(s : CryptosigndsaSeries) -> Int { s.vals.length() }

pub fn crypto_sign_dsa_series_sum(s : CryptosigndsaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sign_dsa_series_mean(s : CryptosigndsaSeries) -> Double {
  let n = crypto_sign_dsa_series_len(s)
  if n == 0 { 0.0 } else { crypto_sign_dsa_series_sum(s) / n.to_double() }
}

pub fn crypto_sign_dsa_series_min(s : CryptosigndsaSeries) -> Double {
  let n = crypto_sign_dsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_dsa_series_max(s : CryptosigndsaSeries) -> Double {
  let n = crypto_sign_dsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_dsa_series_range(s : CryptosigndsaSeries) -> Double {
  crypto_sign_dsa_series_max(s) - crypto_sign_dsa_series_min(s)
}

pub fn crypto_sign_dsa_series_var(s : CryptosigndsaSeries) -> Double {
  let n = crypto_sign_dsa_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sign_dsa_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sign_dsa_series_std(s : CryptosigndsaSeries) -> Double { crypto_sign_dsa_sqrt(crypto_sign_dsa_series_var(s)) }

pub fn crypto_sign_dsa_series_median(s : CryptosigndsaSeries) -> Double {
  let n = crypto_sign_dsa_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_dsa_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_dsa_series_scale(s : CryptosigndsaSeries, f : Double) -> CryptosigndsaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_sign_dsa_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_dsa_series_add(a : CryptosigndsaSeries, b : CryptosigndsaSeries) -> CryptosigndsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sign_dsa_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_dsa_series_sub(a : CryptosigndsaSeries, b : CryptosigndsaSeries) -> CryptosigndsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sign_dsa_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_dsa_series_normalize(s : CryptosigndsaSeries) -> CryptosigndsaSeries {
  let mn = crypto_sign_dsa_series_min(s)
  let mx = crypto_sign_dsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_sign_dsa_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_dsa_series_cumsum(s : CryptosigndsaSeries) -> CryptosigndsaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_sign_dsa_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_dsa_series_to_string(s : CryptosigndsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sign_dsa_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigndsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_dsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosigndsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_dsa_matrix_identity(n : Int) -> CryptosigndsaMatrix {
  let m = crypto_sign_dsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_dsa_matrix_get(m : CryptosigndsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_dsa_matrix_transpose(m : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  let result = crypto_sign_dsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_dsa_matrix_add(a : CryptosigndsaMatrix, b : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_dsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_dsa_matrix_scale(m : CryptosigndsaMatrix, s : Double) -> CryptosigndsaMatrix {
  let result = crypto_sign_dsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_dsa_matrix_multiply(a : CryptosigndsaMatrix, b : CryptosigndsaMatrix) -> CryptosigndsaMatrix {
  if a.cols != b.rows { return crypto_sign_dsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_dsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_dsa_matrix_trace(m : CryptosigndsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_dsa_matrix_det(m : CryptosigndsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_dsa_matrix_norm(m : CryptosigndsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_sign_dsa_sqrt(sum)
}

pub fn crypto_sign_dsa_matrix_to_string(m : CryptosigndsaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_sign_dsa_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosigndsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_dsa_make_vector(comps : Array[Double]) -> CryptosigndsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_dsa_vector_zero(dim : Int) -> CryptosigndsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_dsa_vector_add(a : CryptosigndsaVector, b : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sign_dsa_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_dsa_vector_sub(a : CryptosigndsaVector, b : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sign_dsa_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_dsa_vector_scale(v : CryptosigndsaVector, s : Double) -> CryptosigndsaVector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_sign_dsa_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_dsa_vector_dot(a : CryptosigndsaVector, b : CryptosigndsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_dsa_vector_norm(v : CryptosigndsaVector) -> Double { crypto_sign_dsa_sqrt(crypto_sign_dsa_vector_dot(v, v)) }

pub fn crypto_sign_dsa_vector_normalize(v : CryptosigndsaVector) -> CryptosigndsaVector {
  let n = crypto_sign_dsa_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_dsa_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_dsa_vector_dist(a : CryptosigndsaVector, b : CryptosigndsaVector) -> Double {
  crypto_sign_dsa_vector_norm(crypto_sign_dsa_vector_sub(a, b))
}

pub fn crypto_sign_dsa_vector_to_string(v : CryptosigndsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sign_dsa_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_dsa_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sign_dsa_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sign_dsa_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sign_dsa_std(data : Array[Double]) -> Double { crypto_sign_dsa_sqrt(crypto_sign_dsa_var(data)) }

pub fn crypto_sign_dsa_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sign_dsa_mean(a); let mb = crypto_sign_dsa_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sign_dsa_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sign_dsa_std(a); let sb = crypto_sign_dsa_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sign_dsa_cov(a, b) / (sa * sb) }
}

pub fn crypto_sign_dsa_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_dsa_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_dsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sign_dsa_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sign_dsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_sign_dsa_sqrt(crypto_sign_dsa_mse(pred, labels))
}

pub fn crypto_sign_dsa_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_sign_dsa_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sign_dsa_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sign_dsa_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sign_dsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sign_dsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sign_dsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sign_dsa_precision(pred, labels, pos); let r = crypto_sign_dsa_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sign_dsa_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sign_dsa_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sign_dsa_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sign_dsa_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sign_dsa_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sign_dsa_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sign_dsa_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sign_dsa_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sign_dsa_fibonacci(n : Int) -> Int {
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

pub fn crypto_sign_dsa_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sign_dsa_min(data); let mx = crypto_sign_dsa_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sign_dsa_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sign_dsa_mean(data); let sd = crypto_sign_dsa_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sign_dsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sign_dsa_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sign_dsa_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sign_dsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_sign_dsa_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_sign_dsa_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_sign_dsa_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_sign_dsa_int(x) } else { -crypto_sign_dsa_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_sign_dsa_int(f * 1000000.0) } else { crypto_sign_dsa_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_sign_dsa_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_sign_dsa_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct CryptosigndsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_frame_make(size : Int) -> CryptosigndsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_frame_len(s : CryptosigndsaFrame) -> Int { s.size }

pub fn crypto_sign_dsa_frame_get(s : CryptosigndsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_frame_set(s : CryptosigndsaFrame, i : Int, v : Double) -> CryptosigndsaFrame {
  let result = crypto_sign_dsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_frame_sum(s : CryptosigndsaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_frame_mean(s : CryptosigndsaFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_frame_scale(s : CryptosigndsaFrame, f : Double) -> CryptosigndsaFrame {
  let result = crypto_sign_dsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_frame_add(a : CryptosigndsaFrame, b : CryptosigndsaFrame) -> CryptosigndsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_frame_copy(s : CryptosigndsaFrame) -> CryptosigndsaFrame {
  let result = crypto_sign_dsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_frame_fill(s : CryptosigndsaFrame, v : Double) -> CryptosigndsaFrame {
  let result = crypto_sign_dsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_frame_min(s : CryptosigndsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_frame_max(s : CryptosigndsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_frame_to_string(s : CryptosigndsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_table_make(size : Int) -> CryptosigndsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_table_len(s : CryptosigndsaTable) -> Int { s.size }

pub fn crypto_sign_dsa_table_get(s : CryptosigndsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_table_set(s : CryptosigndsaTable, i : Int, v : Double) -> CryptosigndsaTable {
  let result = crypto_sign_dsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_table_sum(s : CryptosigndsaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_table_mean(s : CryptosigndsaTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_table_scale(s : CryptosigndsaTable, f : Double) -> CryptosigndsaTable {
  let result = crypto_sign_dsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_table_add(a : CryptosigndsaTable, b : CryptosigndsaTable) -> CryptosigndsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_table_copy(s : CryptosigndsaTable) -> CryptosigndsaTable {
  let result = crypto_sign_dsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_table_fill(s : CryptosigndsaTable, v : Double) -> CryptosigndsaTable {
  let result = crypto_sign_dsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_table_min(s : CryptosigndsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_table_max(s : CryptosigndsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_table_to_string(s : CryptosigndsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_graphn_make(size : Int) -> CryptosigndsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_graphn_len(s : CryptosigndsaGraphN) -> Int { s.size }

pub fn crypto_sign_dsa_graphn_get(s : CryptosigndsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_graphn_set(s : CryptosigndsaGraphN, i : Int, v : Double) -> CryptosigndsaGraphN {
  let result = crypto_sign_dsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_graphn_sum(s : CryptosigndsaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_graphn_mean(s : CryptosigndsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_graphn_scale(s : CryptosigndsaGraphN, f : Double) -> CryptosigndsaGraphN {
  let result = crypto_sign_dsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_graphn_add(a : CryptosigndsaGraphN, b : CryptosigndsaGraphN) -> CryptosigndsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_graphn_copy(s : CryptosigndsaGraphN) -> CryptosigndsaGraphN {
  let result = crypto_sign_dsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_graphn_fill(s : CryptosigndsaGraphN, v : Double) -> CryptosigndsaGraphN {
  let result = crypto_sign_dsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_graphn_min(s : CryptosigndsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_graphn_max(s : CryptosigndsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_graphn_to_string(s : CryptosigndsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_node_make(size : Int) -> CryptosigndsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_node_len(s : CryptosigndsaNode) -> Int { s.size }

pub fn crypto_sign_dsa_node_get(s : CryptosigndsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_node_set(s : CryptosigndsaNode, i : Int, v : Double) -> CryptosigndsaNode {
  let result = crypto_sign_dsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_node_sum(s : CryptosigndsaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_node_mean(s : CryptosigndsaNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_node_scale(s : CryptosigndsaNode, f : Double) -> CryptosigndsaNode {
  let result = crypto_sign_dsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_node_add(a : CryptosigndsaNode, b : CryptosigndsaNode) -> CryptosigndsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_node_copy(s : CryptosigndsaNode) -> CryptosigndsaNode {
  let result = crypto_sign_dsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_node_fill(s : CryptosigndsaNode, v : Double) -> CryptosigndsaNode {
  let result = crypto_sign_dsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_node_min(s : CryptosigndsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_node_max(s : CryptosigndsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_node_to_string(s : CryptosigndsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_edge_make(size : Int) -> CryptosigndsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_edge_len(s : CryptosigndsaEdge) -> Int { s.size }

pub fn crypto_sign_dsa_edge_get(s : CryptosigndsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_edge_set(s : CryptosigndsaEdge, i : Int, v : Double) -> CryptosigndsaEdge {
  let result = crypto_sign_dsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_edge_sum(s : CryptosigndsaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_edge_mean(s : CryptosigndsaEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_edge_scale(s : CryptosigndsaEdge, f : Double) -> CryptosigndsaEdge {
  let result = crypto_sign_dsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_edge_add(a : CryptosigndsaEdge, b : CryptosigndsaEdge) -> CryptosigndsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_edge_copy(s : CryptosigndsaEdge) -> CryptosigndsaEdge {
  let result = crypto_sign_dsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_edge_fill(s : CryptosigndsaEdge, v : Double) -> CryptosigndsaEdge {
  let result = crypto_sign_dsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_edge_min(s : CryptosigndsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_edge_max(s : CryptosigndsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_edge_to_string(s : CryptosigndsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_path_make(size : Int) -> CryptosigndsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_path_len(s : CryptosigndsaPath) -> Int { s.size }

pub fn crypto_sign_dsa_path_get(s : CryptosigndsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_path_set(s : CryptosigndsaPath, i : Int, v : Double) -> CryptosigndsaPath {
  let result = crypto_sign_dsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_path_sum(s : CryptosigndsaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_path_mean(s : CryptosigndsaPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_path_scale(s : CryptosigndsaPath, f : Double) -> CryptosigndsaPath {
  let result = crypto_sign_dsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_path_add(a : CryptosigndsaPath, b : CryptosigndsaPath) -> CryptosigndsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_path_copy(s : CryptosigndsaPath) -> CryptosigndsaPath {
  let result = crypto_sign_dsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_path_fill(s : CryptosigndsaPath, v : Double) -> CryptosigndsaPath {
  let result = crypto_sign_dsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_path_min(s : CryptosigndsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_path_max(s : CryptosigndsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_path_to_string(s : CryptosigndsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_cluster_make(size : Int) -> CryptosigndsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_cluster_len(s : CryptosigndsaCluster) -> Int { s.size }

pub fn crypto_sign_dsa_cluster_get(s : CryptosigndsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_cluster_set(s : CryptosigndsaCluster, i : Int, v : Double) -> CryptosigndsaCluster {
  let result = crypto_sign_dsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_cluster_sum(s : CryptosigndsaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_cluster_mean(s : CryptosigndsaCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_cluster_scale(s : CryptosigndsaCluster, f : Double) -> CryptosigndsaCluster {
  let result = crypto_sign_dsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_cluster_add(a : CryptosigndsaCluster, b : CryptosigndsaCluster) -> CryptosigndsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_cluster_copy(s : CryptosigndsaCluster) -> CryptosigndsaCluster {
  let result = crypto_sign_dsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_cluster_fill(s : CryptosigndsaCluster, v : Double) -> CryptosigndsaCluster {
  let result = crypto_sign_dsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_cluster_min(s : CryptosigndsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_cluster_max(s : CryptosigndsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_cluster_to_string(s : CryptosigndsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_model_make(size : Int) -> CryptosigndsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_model_len(s : CryptosigndsaModel) -> Int { s.size }

pub fn crypto_sign_dsa_model_get(s : CryptosigndsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_model_set(s : CryptosigndsaModel, i : Int, v : Double) -> CryptosigndsaModel {
  let result = crypto_sign_dsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_model_sum(s : CryptosigndsaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_model_mean(s : CryptosigndsaModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_model_scale(s : CryptosigndsaModel, f : Double) -> CryptosigndsaModel {
  let result = crypto_sign_dsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_model_add(a : CryptosigndsaModel, b : CryptosigndsaModel) -> CryptosigndsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_model_copy(s : CryptosigndsaModel) -> CryptosigndsaModel {
  let result = crypto_sign_dsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_model_fill(s : CryptosigndsaModel, v : Double) -> CryptosigndsaModel {
  let result = crypto_sign_dsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_model_min(s : CryptosigndsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_model_max(s : CryptosigndsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_model_to_string(s : CryptosigndsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_layer_make(size : Int) -> CryptosigndsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_layer_len(s : CryptosigndsaLayer) -> Int { s.size }

pub fn crypto_sign_dsa_layer_get(s : CryptosigndsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_layer_set(s : CryptosigndsaLayer, i : Int, v : Double) -> CryptosigndsaLayer {
  let result = crypto_sign_dsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_layer_sum(s : CryptosigndsaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_layer_mean(s : CryptosigndsaLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_layer_scale(s : CryptosigndsaLayer, f : Double) -> CryptosigndsaLayer {
  let result = crypto_sign_dsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_layer_add(a : CryptosigndsaLayer, b : CryptosigndsaLayer) -> CryptosigndsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_layer_copy(s : CryptosigndsaLayer) -> CryptosigndsaLayer {
  let result = crypto_sign_dsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_layer_fill(s : CryptosigndsaLayer, v : Double) -> CryptosigndsaLayer {
  let result = crypto_sign_dsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_layer_min(s : CryptosigndsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_layer_max(s : CryptosigndsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_layer_to_string(s : CryptosigndsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_buffer_make(size : Int) -> CryptosigndsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_buffer_len(s : CryptosigndsaBuffer) -> Int { s.size }

pub fn crypto_sign_dsa_buffer_get(s : CryptosigndsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_buffer_set(s : CryptosigndsaBuffer, i : Int, v : Double) -> CryptosigndsaBuffer {
  let result = crypto_sign_dsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_buffer_sum(s : CryptosigndsaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_buffer_mean(s : CryptosigndsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_buffer_scale(s : CryptosigndsaBuffer, f : Double) -> CryptosigndsaBuffer {
  let result = crypto_sign_dsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_buffer_add(a : CryptosigndsaBuffer, b : CryptosigndsaBuffer) -> CryptosigndsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_buffer_copy(s : CryptosigndsaBuffer) -> CryptosigndsaBuffer {
  let result = crypto_sign_dsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_buffer_fill(s : CryptosigndsaBuffer, v : Double) -> CryptosigndsaBuffer {
  let result = crypto_sign_dsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_buffer_min(s : CryptosigndsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_buffer_max(s : CryptosigndsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_buffer_to_string(s : CryptosigndsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_cursor_make(size : Int) -> CryptosigndsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_cursor_len(s : CryptosigndsaCursor) -> Int { s.size }

pub fn crypto_sign_dsa_cursor_get(s : CryptosigndsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_cursor_set(s : CryptosigndsaCursor, i : Int, v : Double) -> CryptosigndsaCursor {
  let result = crypto_sign_dsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_cursor_sum(s : CryptosigndsaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_cursor_mean(s : CryptosigndsaCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_cursor_scale(s : CryptosigndsaCursor, f : Double) -> CryptosigndsaCursor {
  let result = crypto_sign_dsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_cursor_add(a : CryptosigndsaCursor, b : CryptosigndsaCursor) -> CryptosigndsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_cursor_copy(s : CryptosigndsaCursor) -> CryptosigndsaCursor {
  let result = crypto_sign_dsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_cursor_fill(s : CryptosigndsaCursor, v : Double) -> CryptosigndsaCursor {
  let result = crypto_sign_dsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_cursor_min(s : CryptosigndsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_cursor_max(s : CryptosigndsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_cursor_to_string(s : CryptosigndsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_view_make(size : Int) -> CryptosigndsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_view_len(s : CryptosigndsaView) -> Int { s.size }

pub fn crypto_sign_dsa_view_get(s : CryptosigndsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_view_set(s : CryptosigndsaView, i : Int, v : Double) -> CryptosigndsaView {
  let result = crypto_sign_dsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_view_sum(s : CryptosigndsaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_view_mean(s : CryptosigndsaView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_view_scale(s : CryptosigndsaView, f : Double) -> CryptosigndsaView {
  let result = crypto_sign_dsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_view_add(a : CryptosigndsaView, b : CryptosigndsaView) -> CryptosigndsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_view_copy(s : CryptosigndsaView) -> CryptosigndsaView {
  let result = crypto_sign_dsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_view_fill(s : CryptosigndsaView, v : Double) -> CryptosigndsaView {
  let result = crypto_sign_dsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_view_min(s : CryptosigndsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_view_max(s : CryptosigndsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_view_to_string(s : CryptosigndsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_range_make(size : Int) -> CryptosigndsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_range_len(s : CryptosigndsaRange) -> Int { s.size }

pub fn crypto_sign_dsa_range_get(s : CryptosigndsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_range_set(s : CryptosigndsaRange, i : Int, v : Double) -> CryptosigndsaRange {
  let result = crypto_sign_dsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_range_sum(s : CryptosigndsaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_range_mean(s : CryptosigndsaRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_range_scale(s : CryptosigndsaRange, f : Double) -> CryptosigndsaRange {
  let result = crypto_sign_dsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_range_add(a : CryptosigndsaRange, b : CryptosigndsaRange) -> CryptosigndsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_range_copy(s : CryptosigndsaRange) -> CryptosigndsaRange {
  let result = crypto_sign_dsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_range_fill(s : CryptosigndsaRange, v : Double) -> CryptosigndsaRange {
  let result = crypto_sign_dsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_range_min(s : CryptosigndsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_range_max(s : CryptosigndsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_range_to_string(s : CryptosigndsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigndsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_dsa_slice_make(size : Int) -> CryptosigndsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_dsa_slice_len(s : CryptosigndsaSlice) -> Int { s.size }

pub fn crypto_sign_dsa_slice_get(s : CryptosigndsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_dsa_slice_set(s : CryptosigndsaSlice, i : Int, v : Double) -> CryptosigndsaSlice {
  let result = crypto_sign_dsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_slice_sum(s : CryptosigndsaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_dsa_slice_mean(s : CryptosigndsaSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_dsa_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_dsa_slice_scale(s : CryptosigndsaSlice, f : Double) -> CryptosigndsaSlice {
  let result = crypto_sign_dsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_dsa_slice_add(a : CryptosigndsaSlice, b : CryptosigndsaSlice) -> CryptosigndsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_dsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_dsa_slice_copy(s : CryptosigndsaSlice) -> CryptosigndsaSlice {
  let result = crypto_sign_dsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_dsa_slice_fill(s : CryptosigndsaSlice, v : Double) -> CryptosigndsaSlice {
  let result = crypto_sign_dsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_dsa_slice_min(s : CryptosigndsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_slice_max(s : CryptosigndsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_dsa_slice_to_string(s : CryptosigndsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_sign_dsa_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_dsa_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

