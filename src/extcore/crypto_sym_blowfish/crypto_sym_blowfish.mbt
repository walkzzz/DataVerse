///===
/// extcore/crypto_sym_blowfish

pub(all) struct CryptosymblowfishPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_blowfish_make_point(x : Double, y : Double) -> CryptosymblowfishPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_blowfish_make_point3(x : Double, y : Double, z : Double) -> CryptosymblowfishPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_blowfish_point_x(pt : CryptosymblowfishPoint) -> Double { pt.x }

pub fn crypto_sym_blowfish_point_y(pt : CryptosymblowfishPoint) -> Double { pt.y }

pub fn crypto_sym_blowfish_point_z(pt : CryptosymblowfishPoint) -> Double { pt.z }

pub fn crypto_sym_blowfish_point_label(pt : CryptosymblowfishPoint) -> Int { pt.label }

pub fn crypto_sym_blowfish_point_dist(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_sym_blowfish_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_blowfish_point_add(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_blowfish_point_sub(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_blowfish_point_scale(pt : CryptosymblowfishPoint, s : Double) -> CryptosymblowfishPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_blowfish_point_dot(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_blowfish_point_cross(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_blowfish_point_norm(pt : CryptosymblowfishPoint) -> Double {
  crypto_sym_blowfish_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_blowfish_point_normalize(pt : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  let n = crypto_sym_blowfish_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_blowfish_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_blowfish_point_negate(pt : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_blowfish_point_mid(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_blowfish_point_lerp(a : CryptosymblowfishPoint, b : CryptosymblowfishPoint, t : Double) -> CryptosymblowfishPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_blowfish_point_to_string(pt : CryptosymblowfishPoint) -> String {
  "(" + crypto_sym_blowfish_dbl(pt.x) + ", " + crypto_sym_blowfish_dbl(pt.y) + ", " + crypto_sym_blowfish_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymblowfishSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_blowfish_make_series(vals : Array[Double], name : String) -> CryptosymblowfishSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_blowfish_series_len(s : CryptosymblowfishSeries) -> Int { s.vals.length() }

pub fn crypto_sym_blowfish_series_sum(s : CryptosymblowfishSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sym_blowfish_series_mean(s : CryptosymblowfishSeries) -> Double {
  let n = crypto_sym_blowfish_series_len(s)
  if n == 0 { 0.0 } else { crypto_sym_blowfish_series_sum(s) / n.to_double() }
}

pub fn crypto_sym_blowfish_series_min(s : CryptosymblowfishSeries) -> Double {
  let n = crypto_sym_blowfish_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_series_max(s : CryptosymblowfishSeries) -> Double {
  let n = crypto_sym_blowfish_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_series_range(s : CryptosymblowfishSeries) -> Double {
  crypto_sym_blowfish_series_max(s) - crypto_sym_blowfish_series_min(s)
}

pub fn crypto_sym_blowfish_series_var(s : CryptosymblowfishSeries) -> Double {
  let n = crypto_sym_blowfish_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sym_blowfish_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sym_blowfish_series_std(s : CryptosymblowfishSeries) -> Double { crypto_sym_blowfish_sqrt(crypto_sym_blowfish_series_var(s)) }

pub fn crypto_sym_blowfish_series_median(s : CryptosymblowfishSeries) -> Double {
  let n = crypto_sym_blowfish_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_blowfish_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_blowfish_series_scale(s : CryptosymblowfishSeries, f : Double) -> CryptosymblowfishSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_sym_blowfish_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_blowfish_series_add(a : CryptosymblowfishSeries, b : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sym_blowfish_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_blowfish_series_sub(a : CryptosymblowfishSeries, b : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sym_blowfish_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_blowfish_series_normalize(s : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  let mn = crypto_sym_blowfish_series_min(s)
  let mx = crypto_sym_blowfish_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_sym_blowfish_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_blowfish_series_cumsum(s : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_sym_blowfish_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_blowfish_series_to_string(s : CryptosymblowfishSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sym_blowfish_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymblowfishMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_blowfish_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymblowfishMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_blowfish_matrix_identity(n : Int) -> CryptosymblowfishMatrix {
  let m = crypto_sym_blowfish_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_blowfish_matrix_get(m : CryptosymblowfishMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_blowfish_matrix_transpose(m : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  let result = crypto_sym_blowfish_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_blowfish_matrix_add(a : CryptosymblowfishMatrix, b : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_blowfish_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_blowfish_matrix_scale(m : CryptosymblowfishMatrix, s : Double) -> CryptosymblowfishMatrix {
  let result = crypto_sym_blowfish_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_blowfish_matrix_multiply(a : CryptosymblowfishMatrix, b : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  if a.cols != b.rows { return crypto_sym_blowfish_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_blowfish_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_blowfish_matrix_trace(m : CryptosymblowfishMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_blowfish_matrix_det(m : CryptosymblowfishMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_blowfish_matrix_norm(m : CryptosymblowfishMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_sym_blowfish_sqrt(sum)
}

pub fn crypto_sym_blowfish_matrix_to_string(m : CryptosymblowfishMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_sym_blowfish_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosymblowfishVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_blowfish_make_vector(comps : Array[Double]) -> CryptosymblowfishVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_blowfish_vector_zero(dim : Int) -> CryptosymblowfishVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_blowfish_vector_add(a : CryptosymblowfishVector, b : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sym_blowfish_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_blowfish_vector_sub(a : CryptosymblowfishVector, b : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sym_blowfish_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_blowfish_vector_scale(v : CryptosymblowfishVector, s : Double) -> CryptosymblowfishVector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_sym_blowfish_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_blowfish_vector_dot(a : CryptosymblowfishVector, b : CryptosymblowfishVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_blowfish_vector_norm(v : CryptosymblowfishVector) -> Double { crypto_sym_blowfish_sqrt(crypto_sym_blowfish_vector_dot(v, v)) }

pub fn crypto_sym_blowfish_vector_normalize(v : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = crypto_sym_blowfish_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_blowfish_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_blowfish_vector_dist(a : CryptosymblowfishVector, b : CryptosymblowfishVector) -> Double {
  crypto_sym_blowfish_vector_norm(crypto_sym_blowfish_vector_sub(a, b))
}

pub fn crypto_sym_blowfish_vector_to_string(v : CryptosymblowfishVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sym_blowfish_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_blowfish_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sym_blowfish_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sym_blowfish_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_blowfish_std(data : Array[Double]) -> Double { crypto_sym_blowfish_sqrt(crypto_sym_blowfish_var(data)) }

pub fn crypto_sym_blowfish_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sym_blowfish_mean(a); let mb = crypto_sym_blowfish_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_blowfish_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sym_blowfish_std(a); let sb = crypto_sym_blowfish_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sym_blowfish_cov(a, b) / (sa * sb) }
}

pub fn crypto_sym_blowfish_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_blowfish_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_blowfish_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sym_blowfish_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_blowfish_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_sym_blowfish_sqrt(crypto_sym_blowfish_mse(pred, labels))
}

pub fn crypto_sym_blowfish_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_sym_blowfish_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_blowfish_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sym_blowfish_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sym_blowfish_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sym_blowfish_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sym_blowfish_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sym_blowfish_precision(pred, labels, pos); let r = crypto_sym_blowfish_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sym_blowfish_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sym_blowfish_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sym_blowfish_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sym_blowfish_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sym_blowfish_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sym_blowfish_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sym_blowfish_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sym_blowfish_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sym_blowfish_fibonacci(n : Int) -> Int {
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

pub fn crypto_sym_blowfish_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sym_blowfish_min(data); let mx = crypto_sym_blowfish_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sym_blowfish_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sym_blowfish_mean(data); let sd = crypto_sym_blowfish_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sym_blowfish_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sym_blowfish_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sym_blowfish_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sym_blowfish_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_sym_blowfish_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_sym_blowfish_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_sym_blowfish_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_sym_blowfish_int(x) } else { -crypto_sym_blowfish_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_sym_blowfish_int(f * 1000000.0) } else { crypto_sym_blowfish_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_sym_blowfish_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_sym_blowfish_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct CryptosymblowfishFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_frame_make(size : Int) -> CryptosymblowfishFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_frame_len(s : CryptosymblowfishFrame) -> Int { s.size }

pub fn crypto_sym_blowfish_frame_get(s : CryptosymblowfishFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_frame_set(s : CryptosymblowfishFrame, i : Int, v : Double) -> CryptosymblowfishFrame {
  let result = crypto_sym_blowfish_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_frame_sum(s : CryptosymblowfishFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_frame_mean(s : CryptosymblowfishFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_frame_scale(s : CryptosymblowfishFrame, f : Double) -> CryptosymblowfishFrame {
  let result = crypto_sym_blowfish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_frame_add(a : CryptosymblowfishFrame, b : CryptosymblowfishFrame) -> CryptosymblowfishFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_frame_copy(s : CryptosymblowfishFrame) -> CryptosymblowfishFrame {
  let result = crypto_sym_blowfish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_frame_fill(s : CryptosymblowfishFrame, v : Double) -> CryptosymblowfishFrame {
  let result = crypto_sym_blowfish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_frame_min(s : CryptosymblowfishFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_frame_max(s : CryptosymblowfishFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_frame_to_string(s : CryptosymblowfishFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_table_make(size : Int) -> CryptosymblowfishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_table_len(s : CryptosymblowfishTable) -> Int { s.size }

pub fn crypto_sym_blowfish_table_get(s : CryptosymblowfishTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_table_set(s : CryptosymblowfishTable, i : Int, v : Double) -> CryptosymblowfishTable {
  let result = crypto_sym_blowfish_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_table_sum(s : CryptosymblowfishTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_table_mean(s : CryptosymblowfishTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_table_scale(s : CryptosymblowfishTable, f : Double) -> CryptosymblowfishTable {
  let result = crypto_sym_blowfish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_table_add(a : CryptosymblowfishTable, b : CryptosymblowfishTable) -> CryptosymblowfishTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_table_copy(s : CryptosymblowfishTable) -> CryptosymblowfishTable {
  let result = crypto_sym_blowfish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_table_fill(s : CryptosymblowfishTable, v : Double) -> CryptosymblowfishTable {
  let result = crypto_sym_blowfish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_table_min(s : CryptosymblowfishTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_table_max(s : CryptosymblowfishTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_table_to_string(s : CryptosymblowfishTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_graphn_make(size : Int) -> CryptosymblowfishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_graphn_len(s : CryptosymblowfishGraphN) -> Int { s.size }

pub fn crypto_sym_blowfish_graphn_get(s : CryptosymblowfishGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_graphn_set(s : CryptosymblowfishGraphN, i : Int, v : Double) -> CryptosymblowfishGraphN {
  let result = crypto_sym_blowfish_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_graphn_sum(s : CryptosymblowfishGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_graphn_mean(s : CryptosymblowfishGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_graphn_scale(s : CryptosymblowfishGraphN, f : Double) -> CryptosymblowfishGraphN {
  let result = crypto_sym_blowfish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_graphn_add(a : CryptosymblowfishGraphN, b : CryptosymblowfishGraphN) -> CryptosymblowfishGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_graphn_copy(s : CryptosymblowfishGraphN) -> CryptosymblowfishGraphN {
  let result = crypto_sym_blowfish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_graphn_fill(s : CryptosymblowfishGraphN, v : Double) -> CryptosymblowfishGraphN {
  let result = crypto_sym_blowfish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_graphn_min(s : CryptosymblowfishGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_graphn_max(s : CryptosymblowfishGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_graphn_to_string(s : CryptosymblowfishGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_node_make(size : Int) -> CryptosymblowfishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_node_len(s : CryptosymblowfishNode) -> Int { s.size }

pub fn crypto_sym_blowfish_node_get(s : CryptosymblowfishNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_node_set(s : CryptosymblowfishNode, i : Int, v : Double) -> CryptosymblowfishNode {
  let result = crypto_sym_blowfish_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_node_sum(s : CryptosymblowfishNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_node_mean(s : CryptosymblowfishNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_node_scale(s : CryptosymblowfishNode, f : Double) -> CryptosymblowfishNode {
  let result = crypto_sym_blowfish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_node_add(a : CryptosymblowfishNode, b : CryptosymblowfishNode) -> CryptosymblowfishNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_node_copy(s : CryptosymblowfishNode) -> CryptosymblowfishNode {
  let result = crypto_sym_blowfish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_node_fill(s : CryptosymblowfishNode, v : Double) -> CryptosymblowfishNode {
  let result = crypto_sym_blowfish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_node_min(s : CryptosymblowfishNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_node_max(s : CryptosymblowfishNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_node_to_string(s : CryptosymblowfishNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_edge_make(size : Int) -> CryptosymblowfishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_edge_len(s : CryptosymblowfishEdge) -> Int { s.size }

pub fn crypto_sym_blowfish_edge_get(s : CryptosymblowfishEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_edge_set(s : CryptosymblowfishEdge, i : Int, v : Double) -> CryptosymblowfishEdge {
  let result = crypto_sym_blowfish_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_edge_sum(s : CryptosymblowfishEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_edge_mean(s : CryptosymblowfishEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_edge_scale(s : CryptosymblowfishEdge, f : Double) -> CryptosymblowfishEdge {
  let result = crypto_sym_blowfish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_edge_add(a : CryptosymblowfishEdge, b : CryptosymblowfishEdge) -> CryptosymblowfishEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_edge_copy(s : CryptosymblowfishEdge) -> CryptosymblowfishEdge {
  let result = crypto_sym_blowfish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_edge_fill(s : CryptosymblowfishEdge, v : Double) -> CryptosymblowfishEdge {
  let result = crypto_sym_blowfish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_edge_min(s : CryptosymblowfishEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_edge_max(s : CryptosymblowfishEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_edge_to_string(s : CryptosymblowfishEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_path_make(size : Int) -> CryptosymblowfishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_path_len(s : CryptosymblowfishPath) -> Int { s.size }

pub fn crypto_sym_blowfish_path_get(s : CryptosymblowfishPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_path_set(s : CryptosymblowfishPath, i : Int, v : Double) -> CryptosymblowfishPath {
  let result = crypto_sym_blowfish_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_path_sum(s : CryptosymblowfishPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_path_mean(s : CryptosymblowfishPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_path_scale(s : CryptosymblowfishPath, f : Double) -> CryptosymblowfishPath {
  let result = crypto_sym_blowfish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_path_add(a : CryptosymblowfishPath, b : CryptosymblowfishPath) -> CryptosymblowfishPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_path_copy(s : CryptosymblowfishPath) -> CryptosymblowfishPath {
  let result = crypto_sym_blowfish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_path_fill(s : CryptosymblowfishPath, v : Double) -> CryptosymblowfishPath {
  let result = crypto_sym_blowfish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_path_min(s : CryptosymblowfishPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_path_max(s : CryptosymblowfishPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_path_to_string(s : CryptosymblowfishPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_cluster_make(size : Int) -> CryptosymblowfishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_cluster_len(s : CryptosymblowfishCluster) -> Int { s.size }

pub fn crypto_sym_blowfish_cluster_get(s : CryptosymblowfishCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_cluster_set(s : CryptosymblowfishCluster, i : Int, v : Double) -> CryptosymblowfishCluster {
  let result = crypto_sym_blowfish_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_cluster_sum(s : CryptosymblowfishCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_cluster_mean(s : CryptosymblowfishCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_cluster_scale(s : CryptosymblowfishCluster, f : Double) -> CryptosymblowfishCluster {
  let result = crypto_sym_blowfish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_cluster_add(a : CryptosymblowfishCluster, b : CryptosymblowfishCluster) -> CryptosymblowfishCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_cluster_copy(s : CryptosymblowfishCluster) -> CryptosymblowfishCluster {
  let result = crypto_sym_blowfish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_cluster_fill(s : CryptosymblowfishCluster, v : Double) -> CryptosymblowfishCluster {
  let result = crypto_sym_blowfish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_cluster_min(s : CryptosymblowfishCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_cluster_max(s : CryptosymblowfishCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_cluster_to_string(s : CryptosymblowfishCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_model_make(size : Int) -> CryptosymblowfishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_model_len(s : CryptosymblowfishModel) -> Int { s.size }

pub fn crypto_sym_blowfish_model_get(s : CryptosymblowfishModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_model_set(s : CryptosymblowfishModel, i : Int, v : Double) -> CryptosymblowfishModel {
  let result = crypto_sym_blowfish_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_model_sum(s : CryptosymblowfishModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_model_mean(s : CryptosymblowfishModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_model_scale(s : CryptosymblowfishModel, f : Double) -> CryptosymblowfishModel {
  let result = crypto_sym_blowfish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_model_add(a : CryptosymblowfishModel, b : CryptosymblowfishModel) -> CryptosymblowfishModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_model_copy(s : CryptosymblowfishModel) -> CryptosymblowfishModel {
  let result = crypto_sym_blowfish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_model_fill(s : CryptosymblowfishModel, v : Double) -> CryptosymblowfishModel {
  let result = crypto_sym_blowfish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_model_min(s : CryptosymblowfishModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_model_max(s : CryptosymblowfishModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_model_to_string(s : CryptosymblowfishModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_layer_make(size : Int) -> CryptosymblowfishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_layer_len(s : CryptosymblowfishLayer) -> Int { s.size }

pub fn crypto_sym_blowfish_layer_get(s : CryptosymblowfishLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_layer_set(s : CryptosymblowfishLayer, i : Int, v : Double) -> CryptosymblowfishLayer {
  let result = crypto_sym_blowfish_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_layer_sum(s : CryptosymblowfishLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_layer_mean(s : CryptosymblowfishLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_layer_scale(s : CryptosymblowfishLayer, f : Double) -> CryptosymblowfishLayer {
  let result = crypto_sym_blowfish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_layer_add(a : CryptosymblowfishLayer, b : CryptosymblowfishLayer) -> CryptosymblowfishLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_layer_copy(s : CryptosymblowfishLayer) -> CryptosymblowfishLayer {
  let result = crypto_sym_blowfish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_layer_fill(s : CryptosymblowfishLayer, v : Double) -> CryptosymblowfishLayer {
  let result = crypto_sym_blowfish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_layer_min(s : CryptosymblowfishLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_layer_max(s : CryptosymblowfishLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_layer_to_string(s : CryptosymblowfishLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_buffer_make(size : Int) -> CryptosymblowfishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_buffer_len(s : CryptosymblowfishBuffer) -> Int { s.size }

pub fn crypto_sym_blowfish_buffer_get(s : CryptosymblowfishBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_buffer_set(s : CryptosymblowfishBuffer, i : Int, v : Double) -> CryptosymblowfishBuffer {
  let result = crypto_sym_blowfish_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_buffer_sum(s : CryptosymblowfishBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_buffer_mean(s : CryptosymblowfishBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_buffer_scale(s : CryptosymblowfishBuffer, f : Double) -> CryptosymblowfishBuffer {
  let result = crypto_sym_blowfish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_buffer_add(a : CryptosymblowfishBuffer, b : CryptosymblowfishBuffer) -> CryptosymblowfishBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_buffer_copy(s : CryptosymblowfishBuffer) -> CryptosymblowfishBuffer {
  let result = crypto_sym_blowfish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_buffer_fill(s : CryptosymblowfishBuffer, v : Double) -> CryptosymblowfishBuffer {
  let result = crypto_sym_blowfish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_buffer_min(s : CryptosymblowfishBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_buffer_max(s : CryptosymblowfishBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_buffer_to_string(s : CryptosymblowfishBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_cursor_make(size : Int) -> CryptosymblowfishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_cursor_len(s : CryptosymblowfishCursor) -> Int { s.size }

pub fn crypto_sym_blowfish_cursor_get(s : CryptosymblowfishCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_cursor_set(s : CryptosymblowfishCursor, i : Int, v : Double) -> CryptosymblowfishCursor {
  let result = crypto_sym_blowfish_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_cursor_sum(s : CryptosymblowfishCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_cursor_mean(s : CryptosymblowfishCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_cursor_scale(s : CryptosymblowfishCursor, f : Double) -> CryptosymblowfishCursor {
  let result = crypto_sym_blowfish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_cursor_add(a : CryptosymblowfishCursor, b : CryptosymblowfishCursor) -> CryptosymblowfishCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_cursor_copy(s : CryptosymblowfishCursor) -> CryptosymblowfishCursor {
  let result = crypto_sym_blowfish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_cursor_fill(s : CryptosymblowfishCursor, v : Double) -> CryptosymblowfishCursor {
  let result = crypto_sym_blowfish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_cursor_min(s : CryptosymblowfishCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_cursor_max(s : CryptosymblowfishCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_cursor_to_string(s : CryptosymblowfishCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_view_make(size : Int) -> CryptosymblowfishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_view_len(s : CryptosymblowfishView) -> Int { s.size }

pub fn crypto_sym_blowfish_view_get(s : CryptosymblowfishView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_view_set(s : CryptosymblowfishView, i : Int, v : Double) -> CryptosymblowfishView {
  let result = crypto_sym_blowfish_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_view_sum(s : CryptosymblowfishView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_view_mean(s : CryptosymblowfishView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_view_scale(s : CryptosymblowfishView, f : Double) -> CryptosymblowfishView {
  let result = crypto_sym_blowfish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_view_add(a : CryptosymblowfishView, b : CryptosymblowfishView) -> CryptosymblowfishView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_view_copy(s : CryptosymblowfishView) -> CryptosymblowfishView {
  let result = crypto_sym_blowfish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_view_fill(s : CryptosymblowfishView, v : Double) -> CryptosymblowfishView {
  let result = crypto_sym_blowfish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_view_min(s : CryptosymblowfishView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_view_max(s : CryptosymblowfishView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_view_to_string(s : CryptosymblowfishView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_range_make(size : Int) -> CryptosymblowfishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_range_len(s : CryptosymblowfishRange) -> Int { s.size }

pub fn crypto_sym_blowfish_range_get(s : CryptosymblowfishRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_range_set(s : CryptosymblowfishRange, i : Int, v : Double) -> CryptosymblowfishRange {
  let result = crypto_sym_blowfish_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_range_sum(s : CryptosymblowfishRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_range_mean(s : CryptosymblowfishRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_range_scale(s : CryptosymblowfishRange, f : Double) -> CryptosymblowfishRange {
  let result = crypto_sym_blowfish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_range_add(a : CryptosymblowfishRange, b : CryptosymblowfishRange) -> CryptosymblowfishRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_range_copy(s : CryptosymblowfishRange) -> CryptosymblowfishRange {
  let result = crypto_sym_blowfish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_range_fill(s : CryptosymblowfishRange, v : Double) -> CryptosymblowfishRange {
  let result = crypto_sym_blowfish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_range_min(s : CryptosymblowfishRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_range_max(s : CryptosymblowfishRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_range_to_string(s : CryptosymblowfishRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_slice_make(size : Int) -> CryptosymblowfishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_blowfish_slice_len(s : CryptosymblowfishSlice) -> Int { s.size }

pub fn crypto_sym_blowfish_slice_get(s : CryptosymblowfishSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_blowfish_slice_set(s : CryptosymblowfishSlice, i : Int, v : Double) -> CryptosymblowfishSlice {
  let result = crypto_sym_blowfish_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_slice_sum(s : CryptosymblowfishSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_blowfish_slice_mean(s : CryptosymblowfishSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_blowfish_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_blowfish_slice_scale(s : CryptosymblowfishSlice, f : Double) -> CryptosymblowfishSlice {
  let result = crypto_sym_blowfish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_blowfish_slice_add(a : CryptosymblowfishSlice, b : CryptosymblowfishSlice) -> CryptosymblowfishSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_blowfish_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_blowfish_slice_copy(s : CryptosymblowfishSlice) -> CryptosymblowfishSlice {
  let result = crypto_sym_blowfish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_blowfish_slice_fill(s : CryptosymblowfishSlice, v : Double) -> CryptosymblowfishSlice {
  let result = crypto_sym_blowfish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_blowfish_slice_min(s : CryptosymblowfishSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_slice_max(s : CryptosymblowfishSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_blowfish_slice_to_string(s : CryptosymblowfishSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_sym_blowfish_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_blowfish_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

