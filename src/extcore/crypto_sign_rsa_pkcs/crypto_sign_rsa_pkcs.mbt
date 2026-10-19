///===
/// extcore/crypto_sign_rsa_pkcs

pub(all) struct CryptosignrsapkcsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_rsa_pkcs_make_point(x : Double, y : Double) -> CryptosignrsapkcsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_rsa_pkcs_make_point3(x : Double, y : Double, z : Double) -> CryptosignrsapkcsPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_rsa_pkcs_point_x(pt : CryptosignrsapkcsPoint) -> Double { pt.x }

pub fn crypto_sign_rsa_pkcs_point_y(pt : CryptosignrsapkcsPoint) -> Double { pt.y }

pub fn crypto_sign_rsa_pkcs_point_z(pt : CryptosignrsapkcsPoint) -> Double { pt.z }

pub fn crypto_sign_rsa_pkcs_point_label(pt : CryptosignrsapkcsPoint) -> Int { pt.label }

pub fn crypto_sign_rsa_pkcs_point_dist(a : CryptosignrsapkcsPoint, b : CryptosignrsapkcsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_sign_rsa_pkcs_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_rsa_pkcs_point_add(a : CryptosignrsapkcsPoint, b : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_rsa_pkcs_point_sub(a : CryptosignrsapkcsPoint, b : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_rsa_pkcs_point_scale(pt : CryptosignrsapkcsPoint, s : Double) -> CryptosignrsapkcsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_rsa_pkcs_point_dot(a : CryptosignrsapkcsPoint, b : CryptosignrsapkcsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_rsa_pkcs_point_cross(a : CryptosignrsapkcsPoint, b : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_rsa_pkcs_point_norm(pt : CryptosignrsapkcsPoint) -> Double {
  crypto_sign_rsa_pkcs_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_rsa_pkcs_point_normalize(pt : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  let n = crypto_sign_rsa_pkcs_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_rsa_pkcs_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_rsa_pkcs_point_negate(pt : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_rsa_pkcs_point_mid(a : CryptosignrsapkcsPoint, b : CryptosignrsapkcsPoint) -> CryptosignrsapkcsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_rsa_pkcs_point_lerp(a : CryptosignrsapkcsPoint, b : CryptosignrsapkcsPoint, t : Double) -> CryptosignrsapkcsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_rsa_pkcs_point_to_string(pt : CryptosignrsapkcsPoint) -> String {
  "(" + crypto_sign_rsa_pkcs_dbl(pt.x) + ", " + crypto_sign_rsa_pkcs_dbl(pt.y) + ", " + crypto_sign_rsa_pkcs_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_rsa_pkcs_make_series(vals : Array[Double], name : String) -> CryptosignrsapkcsSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_rsa_pkcs_series_len(s : CryptosignrsapkcsSeries) -> Int { s.vals.length() }

pub fn crypto_sign_rsa_pkcs_series_sum(s : CryptosignrsapkcsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_series_mean(s : CryptosignrsapkcsSeries) -> Double {
  let n = crypto_sign_rsa_pkcs_series_len(s)
  if n == 0 { 0.0 } else { crypto_sign_rsa_pkcs_series_sum(s) / n.to_double() }
}

pub fn crypto_sign_rsa_pkcs_series_min(s : CryptosignrsapkcsSeries) -> Double {
  let n = crypto_sign_rsa_pkcs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_series_max(s : CryptosignrsapkcsSeries) -> Double {
  let n = crypto_sign_rsa_pkcs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_series_range(s : CryptosignrsapkcsSeries) -> Double {
  crypto_sign_rsa_pkcs_series_max(s) - crypto_sign_rsa_pkcs_series_min(s)
}

pub fn crypto_sign_rsa_pkcs_series_var(s : CryptosignrsapkcsSeries) -> Double {
  let n = crypto_sign_rsa_pkcs_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sign_rsa_pkcs_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_series_std(s : CryptosignrsapkcsSeries) -> Double { crypto_sign_rsa_pkcs_sqrt(crypto_sign_rsa_pkcs_series_var(s)) }

pub fn crypto_sign_rsa_pkcs_series_median(s : CryptosignrsapkcsSeries) -> Double {
  let n = crypto_sign_rsa_pkcs_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_rsa_pkcs_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_rsa_pkcs_series_scale(s : CryptosignrsapkcsSeries, f : Double) -> CryptosignrsapkcsSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_sign_rsa_pkcs_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_rsa_pkcs_series_add(a : CryptosignrsapkcsSeries, b : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sign_rsa_pkcs_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_rsa_pkcs_series_sub(a : CryptosignrsapkcsSeries, b : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sign_rsa_pkcs_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_rsa_pkcs_series_normalize(s : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  let mn = crypto_sign_rsa_pkcs_series_min(s)
  let mx = crypto_sign_rsa_pkcs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_sign_rsa_pkcs_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_rsa_pkcs_series_cumsum(s : CryptosignrsapkcsSeries) -> CryptosignrsapkcsSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_sign_rsa_pkcs_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_rsa_pkcs_series_to_string(s : CryptosignrsapkcsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sign_rsa_pkcs_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignrsapkcsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_rsa_pkcs_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignrsapkcsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_rsa_pkcs_matrix_identity(n : Int) -> CryptosignrsapkcsMatrix {
  let m = crypto_sign_rsa_pkcs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_rsa_pkcs_matrix_get(m : CryptosignrsapkcsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_rsa_pkcs_matrix_transpose(m : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  let result = crypto_sign_rsa_pkcs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_rsa_pkcs_matrix_add(a : CryptosignrsapkcsMatrix, b : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_rsa_pkcs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_rsa_pkcs_matrix_scale(m : CryptosignrsapkcsMatrix, s : Double) -> CryptosignrsapkcsMatrix {
  let result = crypto_sign_rsa_pkcs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_rsa_pkcs_matrix_multiply(a : CryptosignrsapkcsMatrix, b : CryptosignrsapkcsMatrix) -> CryptosignrsapkcsMatrix {
  if a.cols != b.rows { return crypto_sign_rsa_pkcs_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_rsa_pkcs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_rsa_pkcs_matrix_trace(m : CryptosignrsapkcsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_rsa_pkcs_matrix_det(m : CryptosignrsapkcsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_rsa_pkcs_matrix_norm(m : CryptosignrsapkcsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_sign_rsa_pkcs_sqrt(sum)
}

pub fn crypto_sign_rsa_pkcs_matrix_to_string(m : CryptosignrsapkcsMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_sign_rsa_pkcs_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosignrsapkcsVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_rsa_pkcs_make_vector(comps : Array[Double]) -> CryptosignrsapkcsVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_rsa_pkcs_vector_zero(dim : Int) -> CryptosignrsapkcsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_rsa_pkcs_vector_add(a : CryptosignrsapkcsVector, b : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sign_rsa_pkcs_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_rsa_pkcs_vector_sub(a : CryptosignrsapkcsVector, b : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sign_rsa_pkcs_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_rsa_pkcs_vector_scale(v : CryptosignrsapkcsVector, s : Double) -> CryptosignrsapkcsVector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_sign_rsa_pkcs_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_rsa_pkcs_vector_dot(a : CryptosignrsapkcsVector, b : CryptosignrsapkcsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_rsa_pkcs_vector_norm(v : CryptosignrsapkcsVector) -> Double { crypto_sign_rsa_pkcs_sqrt(crypto_sign_rsa_pkcs_vector_dot(v, v)) }

pub fn crypto_sign_rsa_pkcs_vector_normalize(v : CryptosignrsapkcsVector) -> CryptosignrsapkcsVector {
  let n = crypto_sign_rsa_pkcs_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_rsa_pkcs_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_rsa_pkcs_vector_dist(a : CryptosignrsapkcsVector, b : CryptosignrsapkcsVector) -> Double {
  crypto_sign_rsa_pkcs_vector_norm(crypto_sign_rsa_pkcs_vector_sub(a, b))
}

pub fn crypto_sign_rsa_pkcs_vector_to_string(v : CryptosignrsapkcsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sign_rsa_pkcs_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_rsa_pkcs_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sign_rsa_pkcs_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_std(data : Array[Double]) -> Double { crypto_sign_rsa_pkcs_sqrt(crypto_sign_rsa_pkcs_var(data)) }

pub fn crypto_sign_rsa_pkcs_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sign_rsa_pkcs_mean(a); let mb = crypto_sign_rsa_pkcs_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sign_rsa_pkcs_std(a); let sb = crypto_sign_rsa_pkcs_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sign_rsa_pkcs_cov(a, b) / (sa * sb) }
}

pub fn crypto_sign_rsa_pkcs_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_rsa_pkcs_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_rsa_pkcs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_sign_rsa_pkcs_sqrt(crypto_sign_rsa_pkcs_mse(pred, labels))
}

pub fn crypto_sign_rsa_pkcs_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_sign_rsa_pkcs_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sign_rsa_pkcs_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sign_rsa_pkcs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sign_rsa_pkcs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sign_rsa_pkcs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sign_rsa_pkcs_precision(pred, labels, pos); let r = crypto_sign_rsa_pkcs_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sign_rsa_pkcs_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sign_rsa_pkcs_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sign_rsa_pkcs_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sign_rsa_pkcs_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sign_rsa_pkcs_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sign_rsa_pkcs_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sign_rsa_pkcs_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sign_rsa_pkcs_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sign_rsa_pkcs_fibonacci(n : Int) -> Int {
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

pub fn crypto_sign_rsa_pkcs_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sign_rsa_pkcs_min(data); let mx = crypto_sign_rsa_pkcs_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sign_rsa_pkcs_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sign_rsa_pkcs_mean(data); let sd = crypto_sign_rsa_pkcs_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sign_rsa_pkcs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sign_rsa_pkcs_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sign_rsa_pkcs_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sign_rsa_pkcs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_sign_rsa_pkcs_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_sign_rsa_pkcs_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_sign_rsa_pkcs_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_sign_rsa_pkcs_int(x) } else { -crypto_sign_rsa_pkcs_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_sign_rsa_pkcs_int(f * 1000000.0) } else { crypto_sign_rsa_pkcs_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_sign_rsa_pkcs_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_sign_rsa_pkcs_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct CryptosignrsapkcsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_frame_make(size : Int) -> CryptosignrsapkcsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_frame_len(s : CryptosignrsapkcsFrame) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_frame_get(s : CryptosignrsapkcsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_frame_set(s : CryptosignrsapkcsFrame, i : Int, v : Double) -> CryptosignrsapkcsFrame {
  let result = crypto_sign_rsa_pkcs_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_frame_sum(s : CryptosignrsapkcsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_frame_mean(s : CryptosignrsapkcsFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_frame_scale(s : CryptosignrsapkcsFrame, f : Double) -> CryptosignrsapkcsFrame {
  let result = crypto_sign_rsa_pkcs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_frame_add(a : CryptosignrsapkcsFrame, b : CryptosignrsapkcsFrame) -> CryptosignrsapkcsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_frame_copy(s : CryptosignrsapkcsFrame) -> CryptosignrsapkcsFrame {
  let result = crypto_sign_rsa_pkcs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_frame_fill(s : CryptosignrsapkcsFrame, v : Double) -> CryptosignrsapkcsFrame {
  let result = crypto_sign_rsa_pkcs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_frame_min(s : CryptosignrsapkcsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_frame_max(s : CryptosignrsapkcsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_frame_to_string(s : CryptosignrsapkcsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_table_make(size : Int) -> CryptosignrsapkcsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_table_len(s : CryptosignrsapkcsTable) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_table_get(s : CryptosignrsapkcsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_table_set(s : CryptosignrsapkcsTable, i : Int, v : Double) -> CryptosignrsapkcsTable {
  let result = crypto_sign_rsa_pkcs_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_table_sum(s : CryptosignrsapkcsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_table_mean(s : CryptosignrsapkcsTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_table_scale(s : CryptosignrsapkcsTable, f : Double) -> CryptosignrsapkcsTable {
  let result = crypto_sign_rsa_pkcs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_table_add(a : CryptosignrsapkcsTable, b : CryptosignrsapkcsTable) -> CryptosignrsapkcsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_table_copy(s : CryptosignrsapkcsTable) -> CryptosignrsapkcsTable {
  let result = crypto_sign_rsa_pkcs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_table_fill(s : CryptosignrsapkcsTable, v : Double) -> CryptosignrsapkcsTable {
  let result = crypto_sign_rsa_pkcs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_table_min(s : CryptosignrsapkcsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_table_max(s : CryptosignrsapkcsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_table_to_string(s : CryptosignrsapkcsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_graphn_make(size : Int) -> CryptosignrsapkcsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_graphn_len(s : CryptosignrsapkcsGraphN) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_graphn_get(s : CryptosignrsapkcsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_graphn_set(s : CryptosignrsapkcsGraphN, i : Int, v : Double) -> CryptosignrsapkcsGraphN {
  let result = crypto_sign_rsa_pkcs_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_graphn_sum(s : CryptosignrsapkcsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_graphn_mean(s : CryptosignrsapkcsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_graphn_scale(s : CryptosignrsapkcsGraphN, f : Double) -> CryptosignrsapkcsGraphN {
  let result = crypto_sign_rsa_pkcs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_graphn_add(a : CryptosignrsapkcsGraphN, b : CryptosignrsapkcsGraphN) -> CryptosignrsapkcsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_graphn_copy(s : CryptosignrsapkcsGraphN) -> CryptosignrsapkcsGraphN {
  let result = crypto_sign_rsa_pkcs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_graphn_fill(s : CryptosignrsapkcsGraphN, v : Double) -> CryptosignrsapkcsGraphN {
  let result = crypto_sign_rsa_pkcs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_graphn_min(s : CryptosignrsapkcsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_graphn_max(s : CryptosignrsapkcsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_graphn_to_string(s : CryptosignrsapkcsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_node_make(size : Int) -> CryptosignrsapkcsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_node_len(s : CryptosignrsapkcsNode) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_node_get(s : CryptosignrsapkcsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_node_set(s : CryptosignrsapkcsNode, i : Int, v : Double) -> CryptosignrsapkcsNode {
  let result = crypto_sign_rsa_pkcs_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_node_sum(s : CryptosignrsapkcsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_node_mean(s : CryptosignrsapkcsNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_node_scale(s : CryptosignrsapkcsNode, f : Double) -> CryptosignrsapkcsNode {
  let result = crypto_sign_rsa_pkcs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_node_add(a : CryptosignrsapkcsNode, b : CryptosignrsapkcsNode) -> CryptosignrsapkcsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_node_copy(s : CryptosignrsapkcsNode) -> CryptosignrsapkcsNode {
  let result = crypto_sign_rsa_pkcs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_node_fill(s : CryptosignrsapkcsNode, v : Double) -> CryptosignrsapkcsNode {
  let result = crypto_sign_rsa_pkcs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_node_min(s : CryptosignrsapkcsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_node_max(s : CryptosignrsapkcsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_node_to_string(s : CryptosignrsapkcsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_edge_make(size : Int) -> CryptosignrsapkcsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_edge_len(s : CryptosignrsapkcsEdge) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_edge_get(s : CryptosignrsapkcsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_edge_set(s : CryptosignrsapkcsEdge, i : Int, v : Double) -> CryptosignrsapkcsEdge {
  let result = crypto_sign_rsa_pkcs_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_edge_sum(s : CryptosignrsapkcsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_edge_mean(s : CryptosignrsapkcsEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_edge_scale(s : CryptosignrsapkcsEdge, f : Double) -> CryptosignrsapkcsEdge {
  let result = crypto_sign_rsa_pkcs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_edge_add(a : CryptosignrsapkcsEdge, b : CryptosignrsapkcsEdge) -> CryptosignrsapkcsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_edge_copy(s : CryptosignrsapkcsEdge) -> CryptosignrsapkcsEdge {
  let result = crypto_sign_rsa_pkcs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_edge_fill(s : CryptosignrsapkcsEdge, v : Double) -> CryptosignrsapkcsEdge {
  let result = crypto_sign_rsa_pkcs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_edge_min(s : CryptosignrsapkcsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_edge_max(s : CryptosignrsapkcsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_edge_to_string(s : CryptosignrsapkcsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_path_make(size : Int) -> CryptosignrsapkcsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_path_len(s : CryptosignrsapkcsPath) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_path_get(s : CryptosignrsapkcsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_path_set(s : CryptosignrsapkcsPath, i : Int, v : Double) -> CryptosignrsapkcsPath {
  let result = crypto_sign_rsa_pkcs_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_path_sum(s : CryptosignrsapkcsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_path_mean(s : CryptosignrsapkcsPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_path_scale(s : CryptosignrsapkcsPath, f : Double) -> CryptosignrsapkcsPath {
  let result = crypto_sign_rsa_pkcs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_path_add(a : CryptosignrsapkcsPath, b : CryptosignrsapkcsPath) -> CryptosignrsapkcsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_path_copy(s : CryptosignrsapkcsPath) -> CryptosignrsapkcsPath {
  let result = crypto_sign_rsa_pkcs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_path_fill(s : CryptosignrsapkcsPath, v : Double) -> CryptosignrsapkcsPath {
  let result = crypto_sign_rsa_pkcs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_path_min(s : CryptosignrsapkcsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_path_max(s : CryptosignrsapkcsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_path_to_string(s : CryptosignrsapkcsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_cluster_make(size : Int) -> CryptosignrsapkcsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_cluster_len(s : CryptosignrsapkcsCluster) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_cluster_get(s : CryptosignrsapkcsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_cluster_set(s : CryptosignrsapkcsCluster, i : Int, v : Double) -> CryptosignrsapkcsCluster {
  let result = crypto_sign_rsa_pkcs_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_cluster_sum(s : CryptosignrsapkcsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_cluster_mean(s : CryptosignrsapkcsCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_cluster_scale(s : CryptosignrsapkcsCluster, f : Double) -> CryptosignrsapkcsCluster {
  let result = crypto_sign_rsa_pkcs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_cluster_add(a : CryptosignrsapkcsCluster, b : CryptosignrsapkcsCluster) -> CryptosignrsapkcsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_cluster_copy(s : CryptosignrsapkcsCluster) -> CryptosignrsapkcsCluster {
  let result = crypto_sign_rsa_pkcs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_cluster_fill(s : CryptosignrsapkcsCluster, v : Double) -> CryptosignrsapkcsCluster {
  let result = crypto_sign_rsa_pkcs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_cluster_min(s : CryptosignrsapkcsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_cluster_max(s : CryptosignrsapkcsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_cluster_to_string(s : CryptosignrsapkcsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_model_make(size : Int) -> CryptosignrsapkcsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_model_len(s : CryptosignrsapkcsModel) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_model_get(s : CryptosignrsapkcsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_model_set(s : CryptosignrsapkcsModel, i : Int, v : Double) -> CryptosignrsapkcsModel {
  let result = crypto_sign_rsa_pkcs_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_model_sum(s : CryptosignrsapkcsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_model_mean(s : CryptosignrsapkcsModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_model_scale(s : CryptosignrsapkcsModel, f : Double) -> CryptosignrsapkcsModel {
  let result = crypto_sign_rsa_pkcs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_model_add(a : CryptosignrsapkcsModel, b : CryptosignrsapkcsModel) -> CryptosignrsapkcsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_model_copy(s : CryptosignrsapkcsModel) -> CryptosignrsapkcsModel {
  let result = crypto_sign_rsa_pkcs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_model_fill(s : CryptosignrsapkcsModel, v : Double) -> CryptosignrsapkcsModel {
  let result = crypto_sign_rsa_pkcs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_model_min(s : CryptosignrsapkcsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_model_max(s : CryptosignrsapkcsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_model_to_string(s : CryptosignrsapkcsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_layer_make(size : Int) -> CryptosignrsapkcsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_layer_len(s : CryptosignrsapkcsLayer) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_layer_get(s : CryptosignrsapkcsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_layer_set(s : CryptosignrsapkcsLayer, i : Int, v : Double) -> CryptosignrsapkcsLayer {
  let result = crypto_sign_rsa_pkcs_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_layer_sum(s : CryptosignrsapkcsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_layer_mean(s : CryptosignrsapkcsLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_layer_scale(s : CryptosignrsapkcsLayer, f : Double) -> CryptosignrsapkcsLayer {
  let result = crypto_sign_rsa_pkcs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_layer_add(a : CryptosignrsapkcsLayer, b : CryptosignrsapkcsLayer) -> CryptosignrsapkcsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_layer_copy(s : CryptosignrsapkcsLayer) -> CryptosignrsapkcsLayer {
  let result = crypto_sign_rsa_pkcs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_layer_fill(s : CryptosignrsapkcsLayer, v : Double) -> CryptosignrsapkcsLayer {
  let result = crypto_sign_rsa_pkcs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_layer_min(s : CryptosignrsapkcsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_layer_max(s : CryptosignrsapkcsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_layer_to_string(s : CryptosignrsapkcsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_buffer_make(size : Int) -> CryptosignrsapkcsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_buffer_len(s : CryptosignrsapkcsBuffer) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_buffer_get(s : CryptosignrsapkcsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_buffer_set(s : CryptosignrsapkcsBuffer, i : Int, v : Double) -> CryptosignrsapkcsBuffer {
  let result = crypto_sign_rsa_pkcs_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_buffer_sum(s : CryptosignrsapkcsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_buffer_mean(s : CryptosignrsapkcsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_buffer_scale(s : CryptosignrsapkcsBuffer, f : Double) -> CryptosignrsapkcsBuffer {
  let result = crypto_sign_rsa_pkcs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_buffer_add(a : CryptosignrsapkcsBuffer, b : CryptosignrsapkcsBuffer) -> CryptosignrsapkcsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_buffer_copy(s : CryptosignrsapkcsBuffer) -> CryptosignrsapkcsBuffer {
  let result = crypto_sign_rsa_pkcs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_buffer_fill(s : CryptosignrsapkcsBuffer, v : Double) -> CryptosignrsapkcsBuffer {
  let result = crypto_sign_rsa_pkcs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_buffer_min(s : CryptosignrsapkcsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_buffer_max(s : CryptosignrsapkcsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_buffer_to_string(s : CryptosignrsapkcsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_cursor_make(size : Int) -> CryptosignrsapkcsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_cursor_len(s : CryptosignrsapkcsCursor) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_cursor_get(s : CryptosignrsapkcsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_cursor_set(s : CryptosignrsapkcsCursor, i : Int, v : Double) -> CryptosignrsapkcsCursor {
  let result = crypto_sign_rsa_pkcs_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_cursor_sum(s : CryptosignrsapkcsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_cursor_mean(s : CryptosignrsapkcsCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_cursor_scale(s : CryptosignrsapkcsCursor, f : Double) -> CryptosignrsapkcsCursor {
  let result = crypto_sign_rsa_pkcs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_cursor_add(a : CryptosignrsapkcsCursor, b : CryptosignrsapkcsCursor) -> CryptosignrsapkcsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_cursor_copy(s : CryptosignrsapkcsCursor) -> CryptosignrsapkcsCursor {
  let result = crypto_sign_rsa_pkcs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_cursor_fill(s : CryptosignrsapkcsCursor, v : Double) -> CryptosignrsapkcsCursor {
  let result = crypto_sign_rsa_pkcs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_cursor_min(s : CryptosignrsapkcsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_cursor_max(s : CryptosignrsapkcsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_cursor_to_string(s : CryptosignrsapkcsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_view_make(size : Int) -> CryptosignrsapkcsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_view_len(s : CryptosignrsapkcsView) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_view_get(s : CryptosignrsapkcsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_view_set(s : CryptosignrsapkcsView, i : Int, v : Double) -> CryptosignrsapkcsView {
  let result = crypto_sign_rsa_pkcs_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_view_sum(s : CryptosignrsapkcsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_view_mean(s : CryptosignrsapkcsView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_view_scale(s : CryptosignrsapkcsView, f : Double) -> CryptosignrsapkcsView {
  let result = crypto_sign_rsa_pkcs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_view_add(a : CryptosignrsapkcsView, b : CryptosignrsapkcsView) -> CryptosignrsapkcsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_view_copy(s : CryptosignrsapkcsView) -> CryptosignrsapkcsView {
  let result = crypto_sign_rsa_pkcs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_view_fill(s : CryptosignrsapkcsView, v : Double) -> CryptosignrsapkcsView {
  let result = crypto_sign_rsa_pkcs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_view_min(s : CryptosignrsapkcsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_view_max(s : CryptosignrsapkcsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_view_to_string(s : CryptosignrsapkcsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_range_make(size : Int) -> CryptosignrsapkcsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_range_len(s : CryptosignrsapkcsRange) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_range_get(s : CryptosignrsapkcsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_range_set(s : CryptosignrsapkcsRange, i : Int, v : Double) -> CryptosignrsapkcsRange {
  let result = crypto_sign_rsa_pkcs_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_range_sum(s : CryptosignrsapkcsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_range_mean(s : CryptosignrsapkcsRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_range_scale(s : CryptosignrsapkcsRange, f : Double) -> CryptosignrsapkcsRange {
  let result = crypto_sign_rsa_pkcs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_range_add(a : CryptosignrsapkcsRange, b : CryptosignrsapkcsRange) -> CryptosignrsapkcsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_range_copy(s : CryptosignrsapkcsRange) -> CryptosignrsapkcsRange {
  let result = crypto_sign_rsa_pkcs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_range_fill(s : CryptosignrsapkcsRange, v : Double) -> CryptosignrsapkcsRange {
  let result = crypto_sign_rsa_pkcs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_range_min(s : CryptosignrsapkcsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_range_max(s : CryptosignrsapkcsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_range_to_string(s : CryptosignrsapkcsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapkcsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pkcs_slice_make(size : Int) -> CryptosignrsapkcsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pkcs_slice_len(s : CryptosignrsapkcsSlice) -> Int { s.size }

pub fn crypto_sign_rsa_pkcs_slice_get(s : CryptosignrsapkcsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pkcs_slice_set(s : CryptosignrsapkcsSlice, i : Int, v : Double) -> CryptosignrsapkcsSlice {
  let result = crypto_sign_rsa_pkcs_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_slice_sum(s : CryptosignrsapkcsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pkcs_slice_mean(s : CryptosignrsapkcsSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pkcs_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pkcs_slice_scale(s : CryptosignrsapkcsSlice, f : Double) -> CryptosignrsapkcsSlice {
  let result = crypto_sign_rsa_pkcs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pkcs_slice_add(a : CryptosignrsapkcsSlice, b : CryptosignrsapkcsSlice) -> CryptosignrsapkcsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pkcs_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_slice_copy(s : CryptosignrsapkcsSlice) -> CryptosignrsapkcsSlice {
  let result = crypto_sign_rsa_pkcs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pkcs_slice_fill(s : CryptosignrsapkcsSlice, v : Double) -> CryptosignrsapkcsSlice {
  let result = crypto_sign_rsa_pkcs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pkcs_slice_min(s : CryptosignrsapkcsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_slice_max(s : CryptosignrsapkcsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pkcs_slice_to_string(s : CryptosignrsapkcsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_sign_rsa_pkcs_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sign_rsa_pkcs_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

