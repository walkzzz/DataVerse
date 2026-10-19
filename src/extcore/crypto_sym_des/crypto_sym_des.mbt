///===
/// extcore/crypto_sym_des

pub(all) struct CryptosymdesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_des_make_point(x : Double, y : Double) -> CryptosymdesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_des_make_point3(x : Double, y : Double, z : Double) -> CryptosymdesPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_des_point_x(pt : CryptosymdesPoint) -> Double { pt.x }

pub fn crypto_sym_des_point_y(pt : CryptosymdesPoint) -> Double { pt.y }

pub fn crypto_sym_des_point_z(pt : CryptosymdesPoint) -> Double { pt.z }

pub fn crypto_sym_des_point_label(pt : CryptosymdesPoint) -> Int { pt.label }

pub fn crypto_sym_des_point_dist(a : CryptosymdesPoint, b : CryptosymdesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_sym_des_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_des_point_add(a : CryptosymdesPoint, b : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_des_point_sub(a : CryptosymdesPoint, b : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_des_point_scale(pt : CryptosymdesPoint, s : Double) -> CryptosymdesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_des_point_dot(a : CryptosymdesPoint, b : CryptosymdesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_des_point_cross(a : CryptosymdesPoint, b : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_des_point_norm(pt : CryptosymdesPoint) -> Double {
  crypto_sym_des_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_des_point_normalize(pt : CryptosymdesPoint) -> CryptosymdesPoint {
  let n = crypto_sym_des_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_des_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_des_point_negate(pt : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_des_point_mid(a : CryptosymdesPoint, b : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_des_point_lerp(a : CryptosymdesPoint, b : CryptosymdesPoint, t : Double) -> CryptosymdesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_des_point_to_string(pt : CryptosymdesPoint) -> String {
  "(" + crypto_sym_des_dbl(pt.x) + ", " + crypto_sym_des_dbl(pt.y) + ", " + crypto_sym_des_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymdesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_des_make_series(vals : Array[Double], name : String) -> CryptosymdesSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_des_series_len(s : CryptosymdesSeries) -> Int { s.vals.length() }

pub fn crypto_sym_des_series_sum(s : CryptosymdesSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sym_des_series_mean(s : CryptosymdesSeries) -> Double {
  let n = crypto_sym_des_series_len(s)
  if n == 0 { 0.0 } else { crypto_sym_des_series_sum(s) / n.to_double() }
}

pub fn crypto_sym_des_series_min(s : CryptosymdesSeries) -> Double {
  let n = crypto_sym_des_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_des_series_max(s : CryptosymdesSeries) -> Double {
  let n = crypto_sym_des_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_des_series_range(s : CryptosymdesSeries) -> Double {
  crypto_sym_des_series_max(s) - crypto_sym_des_series_min(s)
}

pub fn crypto_sym_des_series_var(s : CryptosymdesSeries) -> Double {
  let n = crypto_sym_des_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sym_des_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sym_des_series_std(s : CryptosymdesSeries) -> Double { crypto_sym_des_sqrt(crypto_sym_des_series_var(s)) }

pub fn crypto_sym_des_series_median(s : CryptosymdesSeries) -> Double {
  let n = crypto_sym_des_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_des_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_des_series_scale(s : CryptosymdesSeries, f : Double) -> CryptosymdesSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_sym_des_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_des_series_add(a : CryptosymdesSeries, b : CryptosymdesSeries) -> CryptosymdesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sym_des_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_des_series_sub(a : CryptosymdesSeries, b : CryptosymdesSeries) -> CryptosymdesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sym_des_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_des_series_normalize(s : CryptosymdesSeries) -> CryptosymdesSeries {
  let mn = crypto_sym_des_series_min(s)
  let mx = crypto_sym_des_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_sym_des_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_des_series_cumsum(s : CryptosymdesSeries) -> CryptosymdesSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_sym_des_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_des_series_to_string(s : CryptosymdesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sym_des_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymdesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_des_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymdesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_des_matrix_identity(n : Int) -> CryptosymdesMatrix {
  let m = crypto_sym_des_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_des_matrix_get(m : CryptosymdesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_des_matrix_transpose(m : CryptosymdesMatrix) -> CryptosymdesMatrix {
  let result = crypto_sym_des_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_des_matrix_add(a : CryptosymdesMatrix, b : CryptosymdesMatrix) -> CryptosymdesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_des_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_des_matrix_scale(m : CryptosymdesMatrix, s : Double) -> CryptosymdesMatrix {
  let result = crypto_sym_des_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_des_matrix_multiply(a : CryptosymdesMatrix, b : CryptosymdesMatrix) -> CryptosymdesMatrix {
  if a.cols != b.rows { return crypto_sym_des_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_des_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_des_matrix_trace(m : CryptosymdesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_des_matrix_det(m : CryptosymdesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_des_matrix_norm(m : CryptosymdesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_sym_des_sqrt(sum)
}

pub fn crypto_sym_des_matrix_to_string(m : CryptosymdesMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_sym_des_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosymdesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_des_make_vector(comps : Array[Double]) -> CryptosymdesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_des_vector_zero(dim : Int) -> CryptosymdesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_des_vector_add(a : CryptosymdesVector, b : CryptosymdesVector) -> CryptosymdesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sym_des_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_des_vector_sub(a : CryptosymdesVector, b : CryptosymdesVector) -> CryptosymdesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sym_des_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_des_vector_scale(v : CryptosymdesVector, s : Double) -> CryptosymdesVector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_sym_des_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_des_vector_dot(a : CryptosymdesVector, b : CryptosymdesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_des_vector_norm(v : CryptosymdesVector) -> Double { crypto_sym_des_sqrt(crypto_sym_des_vector_dot(v, v)) }

pub fn crypto_sym_des_vector_normalize(v : CryptosymdesVector) -> CryptosymdesVector {
  let n = crypto_sym_des_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_des_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_des_vector_dist(a : CryptosymdesVector, b : CryptosymdesVector) -> Double {
  crypto_sym_des_vector_norm(crypto_sym_des_vector_sub(a, b))
}

pub fn crypto_sym_des_vector_to_string(v : CryptosymdesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sym_des_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_des_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sym_des_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sym_des_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_des_std(data : Array[Double]) -> Double { crypto_sym_des_sqrt(crypto_sym_des_var(data)) }

pub fn crypto_sym_des_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sym_des_mean(a); let mb = crypto_sym_des_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_des_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sym_des_std(a); let sb = crypto_sym_des_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sym_des_cov(a, b) / (sa * sb) }
}

pub fn crypto_sym_des_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_des_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_des_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sym_des_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_des_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_sym_des_sqrt(crypto_sym_des_mse(pred, labels))
}

pub fn crypto_sym_des_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_sym_des_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_des_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sym_des_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sym_des_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sym_des_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sym_des_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sym_des_precision(pred, labels, pos); let r = crypto_sym_des_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sym_des_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sym_des_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sym_des_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sym_des_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sym_des_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sym_des_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sym_des_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sym_des_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sym_des_fibonacci(n : Int) -> Int {
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

pub fn crypto_sym_des_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sym_des_min(data); let mx = crypto_sym_des_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sym_des_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sym_des_mean(data); let sd = crypto_sym_des_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sym_des_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sym_des_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_des_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_des_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sym_des_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sym_des_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_sym_des_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_sym_des_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_sym_des_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_sym_des_int(x) } else { -crypto_sym_des_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_sym_des_int(f * 1000000.0) } else { crypto_sym_des_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_sym_des_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_sym_des_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct CryptosymdesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_frame_make(size : Int) -> CryptosymdesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_frame_len(s : CryptosymdesFrame) -> Int { s.size }

pub fn crypto_sym_des_frame_get(s : CryptosymdesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_frame_set(s : CryptosymdesFrame, i : Int, v : Double) -> CryptosymdesFrame {
  let result = crypto_sym_des_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_frame_sum(s : CryptosymdesFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_frame_mean(s : CryptosymdesFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_frame_scale(s : CryptosymdesFrame, f : Double) -> CryptosymdesFrame {
  let result = crypto_sym_des_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_frame_add(a : CryptosymdesFrame, b : CryptosymdesFrame) -> CryptosymdesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_frame_copy(s : CryptosymdesFrame) -> CryptosymdesFrame {
  let result = crypto_sym_des_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_frame_fill(s : CryptosymdesFrame, v : Double) -> CryptosymdesFrame {
  let result = crypto_sym_des_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_frame_min(s : CryptosymdesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_frame_max(s : CryptosymdesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_frame_to_string(s : CryptosymdesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_table_make(size : Int) -> CryptosymdesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_table_len(s : CryptosymdesTable) -> Int { s.size }

pub fn crypto_sym_des_table_get(s : CryptosymdesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_table_set(s : CryptosymdesTable, i : Int, v : Double) -> CryptosymdesTable {
  let result = crypto_sym_des_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_table_sum(s : CryptosymdesTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_table_mean(s : CryptosymdesTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_table_scale(s : CryptosymdesTable, f : Double) -> CryptosymdesTable {
  let result = crypto_sym_des_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_table_add(a : CryptosymdesTable, b : CryptosymdesTable) -> CryptosymdesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_table_copy(s : CryptosymdesTable) -> CryptosymdesTable {
  let result = crypto_sym_des_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_table_fill(s : CryptosymdesTable, v : Double) -> CryptosymdesTable {
  let result = crypto_sym_des_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_table_min(s : CryptosymdesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_table_max(s : CryptosymdesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_table_to_string(s : CryptosymdesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_graphn_make(size : Int) -> CryptosymdesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_graphn_len(s : CryptosymdesGraphN) -> Int { s.size }

pub fn crypto_sym_des_graphn_get(s : CryptosymdesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_graphn_set(s : CryptosymdesGraphN, i : Int, v : Double) -> CryptosymdesGraphN {
  let result = crypto_sym_des_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_graphn_sum(s : CryptosymdesGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_graphn_mean(s : CryptosymdesGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_graphn_scale(s : CryptosymdesGraphN, f : Double) -> CryptosymdesGraphN {
  let result = crypto_sym_des_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_graphn_add(a : CryptosymdesGraphN, b : CryptosymdesGraphN) -> CryptosymdesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_graphn_copy(s : CryptosymdesGraphN) -> CryptosymdesGraphN {
  let result = crypto_sym_des_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_graphn_fill(s : CryptosymdesGraphN, v : Double) -> CryptosymdesGraphN {
  let result = crypto_sym_des_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_graphn_min(s : CryptosymdesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_graphn_max(s : CryptosymdesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_graphn_to_string(s : CryptosymdesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_node_make(size : Int) -> CryptosymdesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_node_len(s : CryptosymdesNode) -> Int { s.size }

pub fn crypto_sym_des_node_get(s : CryptosymdesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_node_set(s : CryptosymdesNode, i : Int, v : Double) -> CryptosymdesNode {
  let result = crypto_sym_des_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_node_sum(s : CryptosymdesNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_node_mean(s : CryptosymdesNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_node_scale(s : CryptosymdesNode, f : Double) -> CryptosymdesNode {
  let result = crypto_sym_des_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_node_add(a : CryptosymdesNode, b : CryptosymdesNode) -> CryptosymdesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_node_copy(s : CryptosymdesNode) -> CryptosymdesNode {
  let result = crypto_sym_des_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_node_fill(s : CryptosymdesNode, v : Double) -> CryptosymdesNode {
  let result = crypto_sym_des_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_node_min(s : CryptosymdesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_node_max(s : CryptosymdesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_node_to_string(s : CryptosymdesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_edge_make(size : Int) -> CryptosymdesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_edge_len(s : CryptosymdesEdge) -> Int { s.size }

pub fn crypto_sym_des_edge_get(s : CryptosymdesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_edge_set(s : CryptosymdesEdge, i : Int, v : Double) -> CryptosymdesEdge {
  let result = crypto_sym_des_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_edge_sum(s : CryptosymdesEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_edge_mean(s : CryptosymdesEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_edge_scale(s : CryptosymdesEdge, f : Double) -> CryptosymdesEdge {
  let result = crypto_sym_des_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_edge_add(a : CryptosymdesEdge, b : CryptosymdesEdge) -> CryptosymdesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_edge_copy(s : CryptosymdesEdge) -> CryptosymdesEdge {
  let result = crypto_sym_des_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_edge_fill(s : CryptosymdesEdge, v : Double) -> CryptosymdesEdge {
  let result = crypto_sym_des_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_edge_min(s : CryptosymdesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_edge_max(s : CryptosymdesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_edge_to_string(s : CryptosymdesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_path_make(size : Int) -> CryptosymdesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_path_len(s : CryptosymdesPath) -> Int { s.size }

pub fn crypto_sym_des_path_get(s : CryptosymdesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_path_set(s : CryptosymdesPath, i : Int, v : Double) -> CryptosymdesPath {
  let result = crypto_sym_des_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_path_sum(s : CryptosymdesPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_path_mean(s : CryptosymdesPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_path_scale(s : CryptosymdesPath, f : Double) -> CryptosymdesPath {
  let result = crypto_sym_des_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_path_add(a : CryptosymdesPath, b : CryptosymdesPath) -> CryptosymdesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_path_copy(s : CryptosymdesPath) -> CryptosymdesPath {
  let result = crypto_sym_des_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_path_fill(s : CryptosymdesPath, v : Double) -> CryptosymdesPath {
  let result = crypto_sym_des_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_path_min(s : CryptosymdesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_path_max(s : CryptosymdesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_path_to_string(s : CryptosymdesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_cluster_make(size : Int) -> CryptosymdesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_cluster_len(s : CryptosymdesCluster) -> Int { s.size }

pub fn crypto_sym_des_cluster_get(s : CryptosymdesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_cluster_set(s : CryptosymdesCluster, i : Int, v : Double) -> CryptosymdesCluster {
  let result = crypto_sym_des_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_cluster_sum(s : CryptosymdesCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_cluster_mean(s : CryptosymdesCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_cluster_scale(s : CryptosymdesCluster, f : Double) -> CryptosymdesCluster {
  let result = crypto_sym_des_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_cluster_add(a : CryptosymdesCluster, b : CryptosymdesCluster) -> CryptosymdesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_cluster_copy(s : CryptosymdesCluster) -> CryptosymdesCluster {
  let result = crypto_sym_des_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_cluster_fill(s : CryptosymdesCluster, v : Double) -> CryptosymdesCluster {
  let result = crypto_sym_des_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_cluster_min(s : CryptosymdesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_cluster_max(s : CryptosymdesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_cluster_to_string(s : CryptosymdesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_model_make(size : Int) -> CryptosymdesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_model_len(s : CryptosymdesModel) -> Int { s.size }

pub fn crypto_sym_des_model_get(s : CryptosymdesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_model_set(s : CryptosymdesModel, i : Int, v : Double) -> CryptosymdesModel {
  let result = crypto_sym_des_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_model_sum(s : CryptosymdesModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_model_mean(s : CryptosymdesModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_model_scale(s : CryptosymdesModel, f : Double) -> CryptosymdesModel {
  let result = crypto_sym_des_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_model_add(a : CryptosymdesModel, b : CryptosymdesModel) -> CryptosymdesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_model_copy(s : CryptosymdesModel) -> CryptosymdesModel {
  let result = crypto_sym_des_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_model_fill(s : CryptosymdesModel, v : Double) -> CryptosymdesModel {
  let result = crypto_sym_des_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_model_min(s : CryptosymdesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_model_max(s : CryptosymdesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_model_to_string(s : CryptosymdesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_layer_make(size : Int) -> CryptosymdesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_layer_len(s : CryptosymdesLayer) -> Int { s.size }

pub fn crypto_sym_des_layer_get(s : CryptosymdesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_layer_set(s : CryptosymdesLayer, i : Int, v : Double) -> CryptosymdesLayer {
  let result = crypto_sym_des_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_layer_sum(s : CryptosymdesLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_layer_mean(s : CryptosymdesLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_layer_scale(s : CryptosymdesLayer, f : Double) -> CryptosymdesLayer {
  let result = crypto_sym_des_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_layer_add(a : CryptosymdesLayer, b : CryptosymdesLayer) -> CryptosymdesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_layer_copy(s : CryptosymdesLayer) -> CryptosymdesLayer {
  let result = crypto_sym_des_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_layer_fill(s : CryptosymdesLayer, v : Double) -> CryptosymdesLayer {
  let result = crypto_sym_des_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_layer_min(s : CryptosymdesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_layer_max(s : CryptosymdesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_layer_to_string(s : CryptosymdesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_buffer_make(size : Int) -> CryptosymdesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_buffer_len(s : CryptosymdesBuffer) -> Int { s.size }

pub fn crypto_sym_des_buffer_get(s : CryptosymdesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_buffer_set(s : CryptosymdesBuffer, i : Int, v : Double) -> CryptosymdesBuffer {
  let result = crypto_sym_des_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_buffer_sum(s : CryptosymdesBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_buffer_mean(s : CryptosymdesBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_buffer_scale(s : CryptosymdesBuffer, f : Double) -> CryptosymdesBuffer {
  let result = crypto_sym_des_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_buffer_add(a : CryptosymdesBuffer, b : CryptosymdesBuffer) -> CryptosymdesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_buffer_copy(s : CryptosymdesBuffer) -> CryptosymdesBuffer {
  let result = crypto_sym_des_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_buffer_fill(s : CryptosymdesBuffer, v : Double) -> CryptosymdesBuffer {
  let result = crypto_sym_des_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_buffer_min(s : CryptosymdesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_buffer_max(s : CryptosymdesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_buffer_to_string(s : CryptosymdesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_cursor_make(size : Int) -> CryptosymdesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_cursor_len(s : CryptosymdesCursor) -> Int { s.size }

pub fn crypto_sym_des_cursor_get(s : CryptosymdesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_cursor_set(s : CryptosymdesCursor, i : Int, v : Double) -> CryptosymdesCursor {
  let result = crypto_sym_des_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_cursor_sum(s : CryptosymdesCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_cursor_mean(s : CryptosymdesCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_cursor_scale(s : CryptosymdesCursor, f : Double) -> CryptosymdesCursor {
  let result = crypto_sym_des_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_cursor_add(a : CryptosymdesCursor, b : CryptosymdesCursor) -> CryptosymdesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_cursor_copy(s : CryptosymdesCursor) -> CryptosymdesCursor {
  let result = crypto_sym_des_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_cursor_fill(s : CryptosymdesCursor, v : Double) -> CryptosymdesCursor {
  let result = crypto_sym_des_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_cursor_min(s : CryptosymdesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_cursor_max(s : CryptosymdesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_cursor_to_string(s : CryptosymdesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_view_make(size : Int) -> CryptosymdesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_view_len(s : CryptosymdesView) -> Int { s.size }

pub fn crypto_sym_des_view_get(s : CryptosymdesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_view_set(s : CryptosymdesView, i : Int, v : Double) -> CryptosymdesView {
  let result = crypto_sym_des_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_view_sum(s : CryptosymdesView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_view_mean(s : CryptosymdesView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_view_scale(s : CryptosymdesView, f : Double) -> CryptosymdesView {
  let result = crypto_sym_des_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_view_add(a : CryptosymdesView, b : CryptosymdesView) -> CryptosymdesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_view_copy(s : CryptosymdesView) -> CryptosymdesView {
  let result = crypto_sym_des_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_view_fill(s : CryptosymdesView, v : Double) -> CryptosymdesView {
  let result = crypto_sym_des_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_view_min(s : CryptosymdesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_view_max(s : CryptosymdesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_view_to_string(s : CryptosymdesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_range_make(size : Int) -> CryptosymdesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_range_len(s : CryptosymdesRange) -> Int { s.size }

pub fn crypto_sym_des_range_get(s : CryptosymdesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_range_set(s : CryptosymdesRange, i : Int, v : Double) -> CryptosymdesRange {
  let result = crypto_sym_des_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_range_sum(s : CryptosymdesRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_range_mean(s : CryptosymdesRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_range_scale(s : CryptosymdesRange, f : Double) -> CryptosymdesRange {
  let result = crypto_sym_des_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_range_add(a : CryptosymdesRange, b : CryptosymdesRange) -> CryptosymdesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_range_copy(s : CryptosymdesRange) -> CryptosymdesRange {
  let result = crypto_sym_des_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_range_fill(s : CryptosymdesRange, v : Double) -> CryptosymdesRange {
  let result = crypto_sym_des_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_range_min(s : CryptosymdesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_range_max(s : CryptosymdesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_range_to_string(s : CryptosymdesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_slice_make(size : Int) -> CryptosymdesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_slice_len(s : CryptosymdesSlice) -> Int { s.size }

pub fn crypto_sym_des_slice_get(s : CryptosymdesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_slice_set(s : CryptosymdesSlice, i : Int, v : Double) -> CryptosymdesSlice {
  let result = crypto_sym_des_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_slice_sum(s : CryptosymdesSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_des_slice_mean(s : CryptosymdesSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_des_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_des_slice_scale(s : CryptosymdesSlice, f : Double) -> CryptosymdesSlice {
  let result = crypto_sym_des_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_des_slice_add(a : CryptosymdesSlice, b : CryptosymdesSlice) -> CryptosymdesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_des_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_des_slice_copy(s : CryptosymdesSlice) -> CryptosymdesSlice {
  let result = crypto_sym_des_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_des_slice_fill(s : CryptosymdesSlice, v : Double) -> CryptosymdesSlice {
  let result = crypto_sym_des_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_slice_min(s : CryptosymdesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_slice_max(s : CryptosymdesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_des_slice_to_string(s : CryptosymdesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_sym_des_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_des_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

