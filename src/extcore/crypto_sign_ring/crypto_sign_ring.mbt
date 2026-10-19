///===
/// extcore/crypto_sign_ring

pub(all) struct CryptosignringPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_ring_make_point(x : Double, y : Double) -> CryptosignringPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_ring_make_point3(x : Double, y : Double, z : Double) -> CryptosignringPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_ring_point_x(pt : CryptosignringPoint) -> Double { pt.x }

pub fn crypto_sign_ring_point_y(pt : CryptosignringPoint) -> Double { pt.y }

pub fn crypto_sign_ring_point_z(pt : CryptosignringPoint) -> Double { pt.z }

pub fn crypto_sign_ring_point_label(pt : CryptosignringPoint) -> Int { pt.label }

pub fn crypto_sign_ring_point_dist(a : CryptosignringPoint, b : CryptosignringPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_sign_ring_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_ring_point_add(a : CryptosignringPoint, b : CryptosignringPoint) -> CryptosignringPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_ring_point_sub(a : CryptosignringPoint, b : CryptosignringPoint) -> CryptosignringPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_ring_point_scale(pt : CryptosignringPoint, s : Double) -> CryptosignringPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_ring_point_dot(a : CryptosignringPoint, b : CryptosignringPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_ring_point_cross(a : CryptosignringPoint, b : CryptosignringPoint) -> CryptosignringPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_ring_point_norm(pt : CryptosignringPoint) -> Double {
  crypto_sign_ring_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_ring_point_normalize(pt : CryptosignringPoint) -> CryptosignringPoint {
  let n = crypto_sign_ring_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_ring_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_ring_point_negate(pt : CryptosignringPoint) -> CryptosignringPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_ring_point_mid(a : CryptosignringPoint, b : CryptosignringPoint) -> CryptosignringPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_ring_point_lerp(a : CryptosignringPoint, b : CryptosignringPoint, t : Double) -> CryptosignringPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_ring_point_to_string(pt : CryptosignringPoint) -> String {
  "(" + crypto_sign_ring_dbl(pt.x) + ", " + crypto_sign_ring_dbl(pt.y) + ", " + crypto_sign_ring_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosignringSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_ring_make_series(vals : Array[Double], name : String) -> CryptosignringSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_ring_series_len(s : CryptosignringSeries) -> Int { s.vals.length() }

pub fn crypto_sign_ring_series_sum(s : CryptosignringSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sign_ring_series_mean(s : CryptosignringSeries) -> Double {
  let n = crypto_sign_ring_series_len(s)
  if n == 0 { 0.0 } else { crypto_sign_ring_series_sum(s) / n.to_double() }
}

pub fn crypto_sign_ring_series_min(s : CryptosignringSeries) -> Double {
  let n = crypto_sign_ring_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_ring_series_max(s : CryptosignringSeries) -> Double {
  let n = crypto_sign_ring_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_ring_series_range(s : CryptosignringSeries) -> Double {
  crypto_sign_ring_series_max(s) - crypto_sign_ring_series_min(s)
}

pub fn crypto_sign_ring_series_var(s : CryptosignringSeries) -> Double {
  let n = crypto_sign_ring_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sign_ring_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sign_ring_series_std(s : CryptosignringSeries) -> Double { crypto_sign_ring_sqrt(crypto_sign_ring_series_var(s)) }

pub fn crypto_sign_ring_series_median(s : CryptosignringSeries) -> Double {
  let n = crypto_sign_ring_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_ring_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_ring_series_scale(s : CryptosignringSeries, f : Double) -> CryptosignringSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_sign_ring_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_ring_series_add(a : CryptosignringSeries, b : CryptosignringSeries) -> CryptosignringSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sign_ring_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_ring_series_sub(a : CryptosignringSeries, b : CryptosignringSeries) -> CryptosignringSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sign_ring_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_ring_series_normalize(s : CryptosignringSeries) -> CryptosignringSeries {
  let mn = crypto_sign_ring_series_min(s)
  let mx = crypto_sign_ring_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_sign_ring_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_ring_series_cumsum(s : CryptosignringSeries) -> CryptosignringSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_sign_ring_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_ring_series_to_string(s : CryptosignringSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sign_ring_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignringMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_ring_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignringMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_ring_matrix_identity(n : Int) -> CryptosignringMatrix {
  let m = crypto_sign_ring_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_ring_matrix_get(m : CryptosignringMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_ring_matrix_transpose(m : CryptosignringMatrix) -> CryptosignringMatrix {
  let result = crypto_sign_ring_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_ring_matrix_add(a : CryptosignringMatrix, b : CryptosignringMatrix) -> CryptosignringMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_ring_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_ring_matrix_scale(m : CryptosignringMatrix, s : Double) -> CryptosignringMatrix {
  let result = crypto_sign_ring_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_ring_matrix_multiply(a : CryptosignringMatrix, b : CryptosignringMatrix) -> CryptosignringMatrix {
  if a.cols != b.rows { return crypto_sign_ring_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_ring_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_ring_matrix_trace(m : CryptosignringMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_ring_matrix_det(m : CryptosignringMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_ring_matrix_norm(m : CryptosignringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_sign_ring_sqrt(sum)
}

pub fn crypto_sign_ring_matrix_to_string(m : CryptosignringMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_sign_ring_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosignringVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_ring_make_vector(comps : Array[Double]) -> CryptosignringVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_ring_vector_zero(dim : Int) -> CryptosignringVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_ring_vector_add(a : CryptosignringVector, b : CryptosignringVector) -> CryptosignringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sign_ring_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_ring_vector_sub(a : CryptosignringVector, b : CryptosignringVector) -> CryptosignringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sign_ring_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_ring_vector_scale(v : CryptosignringVector, s : Double) -> CryptosignringVector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_sign_ring_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_ring_vector_dot(a : CryptosignringVector, b : CryptosignringVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_ring_vector_norm(v : CryptosignringVector) -> Double { crypto_sign_ring_sqrt(crypto_sign_ring_vector_dot(v, v)) }

pub fn crypto_sign_ring_vector_normalize(v : CryptosignringVector) -> CryptosignringVector {
  let n = crypto_sign_ring_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_ring_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_ring_vector_dist(a : CryptosignringVector, b : CryptosignringVector) -> Double {
  crypto_sign_ring_vector_norm(crypto_sign_ring_vector_sub(a, b))
}

pub fn crypto_sign_ring_vector_to_string(v : CryptosignringVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sign_ring_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_ring_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sign_ring_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sign_ring_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sign_ring_std(data : Array[Double]) -> Double { crypto_sign_ring_sqrt(crypto_sign_ring_var(data)) }

pub fn crypto_sign_ring_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sign_ring_mean(a); let mb = crypto_sign_ring_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sign_ring_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sign_ring_std(a); let sb = crypto_sign_ring_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sign_ring_cov(a, b) / (sa * sb) }
}

pub fn crypto_sign_ring_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_ring_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_ring_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sign_ring_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sign_ring_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_sign_ring_sqrt(crypto_sign_ring_mse(pred, labels))
}

pub fn crypto_sign_ring_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_sign_ring_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sign_ring_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sign_ring_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sign_ring_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sign_ring_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sign_ring_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sign_ring_precision(pred, labels, pos); let r = crypto_sign_ring_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sign_ring_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sign_ring_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sign_ring_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sign_ring_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sign_ring_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sign_ring_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sign_ring_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sign_ring_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sign_ring_fibonacci(n : Int) -> Int {
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

pub fn crypto_sign_ring_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sign_ring_min(data); let mx = crypto_sign_ring_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sign_ring_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sign_ring_mean(data); let sd = crypto_sign_ring_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sign_ring_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sign_ring_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sign_ring_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sign_ring_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sign_ring_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sign_ring_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_sign_ring_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_sign_ring_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_sign_ring_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_sign_ring_int(x) } else { -crypto_sign_ring_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_sign_ring_int(f * 1000000.0) } else { crypto_sign_ring_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_sign_ring_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_sign_ring_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct CryptosignringFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_frame_make(size : Int) -> CryptosignringFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_frame_len(s : CryptosignringFrame) -> Int { s.size }

pub fn crypto_sign_ring_frame_get(s : CryptosignringFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_frame_set(s : CryptosignringFrame, i : Int, v : Double) -> CryptosignringFrame {
  let result = crypto_sign_ring_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_frame_sum(s : CryptosignringFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_frame_mean(s : CryptosignringFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_frame_scale(s : CryptosignringFrame, f : Double) -> CryptosignringFrame {
  let result = crypto_sign_ring_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_frame_add(a : CryptosignringFrame, b : CryptosignringFrame) -> CryptosignringFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_frame_copy(s : CryptosignringFrame) -> CryptosignringFrame {
  let result = crypto_sign_ring_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_frame_fill(s : CryptosignringFrame, v : Double) -> CryptosignringFrame {
  let result = crypto_sign_ring_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_frame_min(s : CryptosignringFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_frame_max(s : CryptosignringFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_frame_to_string(s : CryptosignringFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_table_make(size : Int) -> CryptosignringTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_table_len(s : CryptosignringTable) -> Int { s.size }

pub fn crypto_sign_ring_table_get(s : CryptosignringTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_table_set(s : CryptosignringTable, i : Int, v : Double) -> CryptosignringTable {
  let result = crypto_sign_ring_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_table_sum(s : CryptosignringTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_table_mean(s : CryptosignringTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_table_scale(s : CryptosignringTable, f : Double) -> CryptosignringTable {
  let result = crypto_sign_ring_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_table_add(a : CryptosignringTable, b : CryptosignringTable) -> CryptosignringTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_table_copy(s : CryptosignringTable) -> CryptosignringTable {
  let result = crypto_sign_ring_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_table_fill(s : CryptosignringTable, v : Double) -> CryptosignringTable {
  let result = crypto_sign_ring_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_table_min(s : CryptosignringTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_table_max(s : CryptosignringTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_table_to_string(s : CryptosignringTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_graphn_make(size : Int) -> CryptosignringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_graphn_len(s : CryptosignringGraphN) -> Int { s.size }

pub fn crypto_sign_ring_graphn_get(s : CryptosignringGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_graphn_set(s : CryptosignringGraphN, i : Int, v : Double) -> CryptosignringGraphN {
  let result = crypto_sign_ring_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_graphn_sum(s : CryptosignringGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_graphn_mean(s : CryptosignringGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_graphn_scale(s : CryptosignringGraphN, f : Double) -> CryptosignringGraphN {
  let result = crypto_sign_ring_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_graphn_add(a : CryptosignringGraphN, b : CryptosignringGraphN) -> CryptosignringGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_graphn_copy(s : CryptosignringGraphN) -> CryptosignringGraphN {
  let result = crypto_sign_ring_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_graphn_fill(s : CryptosignringGraphN, v : Double) -> CryptosignringGraphN {
  let result = crypto_sign_ring_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_graphn_min(s : CryptosignringGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_graphn_max(s : CryptosignringGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_graphn_to_string(s : CryptosignringGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_node_make(size : Int) -> CryptosignringNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_node_len(s : CryptosignringNode) -> Int { s.size }

pub fn crypto_sign_ring_node_get(s : CryptosignringNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_node_set(s : CryptosignringNode, i : Int, v : Double) -> CryptosignringNode {
  let result = crypto_sign_ring_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_node_sum(s : CryptosignringNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_node_mean(s : CryptosignringNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_node_scale(s : CryptosignringNode, f : Double) -> CryptosignringNode {
  let result = crypto_sign_ring_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_node_add(a : CryptosignringNode, b : CryptosignringNode) -> CryptosignringNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_node_copy(s : CryptosignringNode) -> CryptosignringNode {
  let result = crypto_sign_ring_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_node_fill(s : CryptosignringNode, v : Double) -> CryptosignringNode {
  let result = crypto_sign_ring_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_node_min(s : CryptosignringNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_node_max(s : CryptosignringNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_node_to_string(s : CryptosignringNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_edge_make(size : Int) -> CryptosignringEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_edge_len(s : CryptosignringEdge) -> Int { s.size }

pub fn crypto_sign_ring_edge_get(s : CryptosignringEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_edge_set(s : CryptosignringEdge, i : Int, v : Double) -> CryptosignringEdge {
  let result = crypto_sign_ring_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_edge_sum(s : CryptosignringEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_edge_mean(s : CryptosignringEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_edge_scale(s : CryptosignringEdge, f : Double) -> CryptosignringEdge {
  let result = crypto_sign_ring_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_edge_add(a : CryptosignringEdge, b : CryptosignringEdge) -> CryptosignringEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_edge_copy(s : CryptosignringEdge) -> CryptosignringEdge {
  let result = crypto_sign_ring_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_edge_fill(s : CryptosignringEdge, v : Double) -> CryptosignringEdge {
  let result = crypto_sign_ring_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_edge_min(s : CryptosignringEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_edge_max(s : CryptosignringEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_edge_to_string(s : CryptosignringEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_path_make(size : Int) -> CryptosignringPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_path_len(s : CryptosignringPath) -> Int { s.size }

pub fn crypto_sign_ring_path_get(s : CryptosignringPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_path_set(s : CryptosignringPath, i : Int, v : Double) -> CryptosignringPath {
  let result = crypto_sign_ring_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_path_sum(s : CryptosignringPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_path_mean(s : CryptosignringPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_path_scale(s : CryptosignringPath, f : Double) -> CryptosignringPath {
  let result = crypto_sign_ring_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_path_add(a : CryptosignringPath, b : CryptosignringPath) -> CryptosignringPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_path_copy(s : CryptosignringPath) -> CryptosignringPath {
  let result = crypto_sign_ring_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_path_fill(s : CryptosignringPath, v : Double) -> CryptosignringPath {
  let result = crypto_sign_ring_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_path_min(s : CryptosignringPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_path_max(s : CryptosignringPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_path_to_string(s : CryptosignringPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_cluster_make(size : Int) -> CryptosignringCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_cluster_len(s : CryptosignringCluster) -> Int { s.size }

pub fn crypto_sign_ring_cluster_get(s : CryptosignringCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_cluster_set(s : CryptosignringCluster, i : Int, v : Double) -> CryptosignringCluster {
  let result = crypto_sign_ring_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_cluster_sum(s : CryptosignringCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_cluster_mean(s : CryptosignringCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_cluster_scale(s : CryptosignringCluster, f : Double) -> CryptosignringCluster {
  let result = crypto_sign_ring_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_cluster_add(a : CryptosignringCluster, b : CryptosignringCluster) -> CryptosignringCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_cluster_copy(s : CryptosignringCluster) -> CryptosignringCluster {
  let result = crypto_sign_ring_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_cluster_fill(s : CryptosignringCluster, v : Double) -> CryptosignringCluster {
  let result = crypto_sign_ring_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_cluster_min(s : CryptosignringCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_cluster_max(s : CryptosignringCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_cluster_to_string(s : CryptosignringCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_model_make(size : Int) -> CryptosignringModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_model_len(s : CryptosignringModel) -> Int { s.size }

pub fn crypto_sign_ring_model_get(s : CryptosignringModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_model_set(s : CryptosignringModel, i : Int, v : Double) -> CryptosignringModel {
  let result = crypto_sign_ring_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_model_sum(s : CryptosignringModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_model_mean(s : CryptosignringModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_model_scale(s : CryptosignringModel, f : Double) -> CryptosignringModel {
  let result = crypto_sign_ring_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_model_add(a : CryptosignringModel, b : CryptosignringModel) -> CryptosignringModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_model_copy(s : CryptosignringModel) -> CryptosignringModel {
  let result = crypto_sign_ring_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_model_fill(s : CryptosignringModel, v : Double) -> CryptosignringModel {
  let result = crypto_sign_ring_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_model_min(s : CryptosignringModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_model_max(s : CryptosignringModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_model_to_string(s : CryptosignringModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_layer_make(size : Int) -> CryptosignringLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_layer_len(s : CryptosignringLayer) -> Int { s.size }

pub fn crypto_sign_ring_layer_get(s : CryptosignringLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_layer_set(s : CryptosignringLayer, i : Int, v : Double) -> CryptosignringLayer {
  let result = crypto_sign_ring_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_layer_sum(s : CryptosignringLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_layer_mean(s : CryptosignringLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_layer_scale(s : CryptosignringLayer, f : Double) -> CryptosignringLayer {
  let result = crypto_sign_ring_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_layer_add(a : CryptosignringLayer, b : CryptosignringLayer) -> CryptosignringLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_layer_copy(s : CryptosignringLayer) -> CryptosignringLayer {
  let result = crypto_sign_ring_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_layer_fill(s : CryptosignringLayer, v : Double) -> CryptosignringLayer {
  let result = crypto_sign_ring_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_layer_min(s : CryptosignringLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_layer_max(s : CryptosignringLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_layer_to_string(s : CryptosignringLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_buffer_make(size : Int) -> CryptosignringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_buffer_len(s : CryptosignringBuffer) -> Int { s.size }

pub fn crypto_sign_ring_buffer_get(s : CryptosignringBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_buffer_set(s : CryptosignringBuffer, i : Int, v : Double) -> CryptosignringBuffer {
  let result = crypto_sign_ring_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_buffer_sum(s : CryptosignringBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_buffer_mean(s : CryptosignringBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_buffer_scale(s : CryptosignringBuffer, f : Double) -> CryptosignringBuffer {
  let result = crypto_sign_ring_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_buffer_add(a : CryptosignringBuffer, b : CryptosignringBuffer) -> CryptosignringBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_buffer_copy(s : CryptosignringBuffer) -> CryptosignringBuffer {
  let result = crypto_sign_ring_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_buffer_fill(s : CryptosignringBuffer, v : Double) -> CryptosignringBuffer {
  let result = crypto_sign_ring_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_buffer_min(s : CryptosignringBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_buffer_max(s : CryptosignringBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_buffer_to_string(s : CryptosignringBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_cursor_make(size : Int) -> CryptosignringCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_cursor_len(s : CryptosignringCursor) -> Int { s.size }

pub fn crypto_sign_ring_cursor_get(s : CryptosignringCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_cursor_set(s : CryptosignringCursor, i : Int, v : Double) -> CryptosignringCursor {
  let result = crypto_sign_ring_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_cursor_sum(s : CryptosignringCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_cursor_mean(s : CryptosignringCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_cursor_scale(s : CryptosignringCursor, f : Double) -> CryptosignringCursor {
  let result = crypto_sign_ring_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_cursor_add(a : CryptosignringCursor, b : CryptosignringCursor) -> CryptosignringCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_cursor_copy(s : CryptosignringCursor) -> CryptosignringCursor {
  let result = crypto_sign_ring_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_cursor_fill(s : CryptosignringCursor, v : Double) -> CryptosignringCursor {
  let result = crypto_sign_ring_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_cursor_min(s : CryptosignringCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_cursor_max(s : CryptosignringCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_cursor_to_string(s : CryptosignringCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_view_make(size : Int) -> CryptosignringView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_view_len(s : CryptosignringView) -> Int { s.size }

pub fn crypto_sign_ring_view_get(s : CryptosignringView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_view_set(s : CryptosignringView, i : Int, v : Double) -> CryptosignringView {
  let result = crypto_sign_ring_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_view_sum(s : CryptosignringView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_view_mean(s : CryptosignringView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_view_scale(s : CryptosignringView, f : Double) -> CryptosignringView {
  let result = crypto_sign_ring_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_view_add(a : CryptosignringView, b : CryptosignringView) -> CryptosignringView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_view_copy(s : CryptosignringView) -> CryptosignringView {
  let result = crypto_sign_ring_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_view_fill(s : CryptosignringView, v : Double) -> CryptosignringView {
  let result = crypto_sign_ring_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_view_min(s : CryptosignringView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_view_max(s : CryptosignringView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_view_to_string(s : CryptosignringView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_range_make(size : Int) -> CryptosignringRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_range_len(s : CryptosignringRange) -> Int { s.size }

pub fn crypto_sign_ring_range_get(s : CryptosignringRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_range_set(s : CryptosignringRange, i : Int, v : Double) -> CryptosignringRange {
  let result = crypto_sign_ring_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_range_sum(s : CryptosignringRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_range_mean(s : CryptosignringRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_range_scale(s : CryptosignringRange, f : Double) -> CryptosignringRange {
  let result = crypto_sign_ring_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_range_add(a : CryptosignringRange, b : CryptosignringRange) -> CryptosignringRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_range_copy(s : CryptosignringRange) -> CryptosignringRange {
  let result = crypto_sign_ring_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_range_fill(s : CryptosignringRange, v : Double) -> CryptosignringRange {
  let result = crypto_sign_ring_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_range_min(s : CryptosignringRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_range_max(s : CryptosignringRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_range_to_string(s : CryptosignringRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignringSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ring_slice_make(size : Int) -> CryptosignringSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ring_slice_len(s : CryptosignringSlice) -> Int { s.size }

pub fn crypto_sign_ring_slice_get(s : CryptosignringSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ring_slice_set(s : CryptosignringSlice, i : Int, v : Double) -> CryptosignringSlice {
  let result = crypto_sign_ring_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_slice_sum(s : CryptosignringSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ring_slice_mean(s : CryptosignringSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ring_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ring_slice_scale(s : CryptosignringSlice, f : Double) -> CryptosignringSlice {
  let result = crypto_sign_ring_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ring_slice_add(a : CryptosignringSlice, b : CryptosignringSlice) -> CryptosignringSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ring_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ring_slice_copy(s : CryptosignringSlice) -> CryptosignringSlice {
  let result = crypto_sign_ring_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ring_slice_fill(s : CryptosignringSlice, v : Double) -> CryptosignringSlice {
  let result = crypto_sign_ring_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ring_slice_min(s : CryptosignringSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_slice_max(s : CryptosignringSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ring_slice_to_string(s : CryptosignringSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_sign_ring_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_ring_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

