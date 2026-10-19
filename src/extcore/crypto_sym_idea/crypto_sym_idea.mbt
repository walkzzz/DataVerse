///===
/// extcore/crypto_sym_idea

pub(all) struct CryptosymideaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_idea_make_point(x : Double, y : Double) -> CryptosymideaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_idea_make_point3(x : Double, y : Double, z : Double) -> CryptosymideaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_idea_point_x(pt : CryptosymideaPoint) -> Double { pt.x }

pub fn crypto_sym_idea_point_y(pt : CryptosymideaPoint) -> Double { pt.y }

pub fn crypto_sym_idea_point_z(pt : CryptosymideaPoint) -> Double { pt.z }

pub fn crypto_sym_idea_point_label(pt : CryptosymideaPoint) -> Int { pt.label }

pub fn crypto_sym_idea_point_dist(a : CryptosymideaPoint, b : CryptosymideaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_sym_idea_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_idea_point_add(a : CryptosymideaPoint, b : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_idea_point_sub(a : CryptosymideaPoint, b : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_idea_point_scale(pt : CryptosymideaPoint, s : Double) -> CryptosymideaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_idea_point_dot(a : CryptosymideaPoint, b : CryptosymideaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_idea_point_cross(a : CryptosymideaPoint, b : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_idea_point_norm(pt : CryptosymideaPoint) -> Double {
  crypto_sym_idea_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_idea_point_normalize(pt : CryptosymideaPoint) -> CryptosymideaPoint {
  let n = crypto_sym_idea_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_idea_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_idea_point_negate(pt : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_idea_point_mid(a : CryptosymideaPoint, b : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_idea_point_lerp(a : CryptosymideaPoint, b : CryptosymideaPoint, t : Double) -> CryptosymideaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_idea_point_to_string(pt : CryptosymideaPoint) -> String {
  "(" + crypto_sym_idea_dbl(pt.x) + ", " + crypto_sym_idea_dbl(pt.y) + ", " + crypto_sym_idea_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymideaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_idea_make_series(vals : Array[Double], name : String) -> CryptosymideaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_idea_series_len(s : CryptosymideaSeries) -> Int { s.vals.length() }

pub fn crypto_sym_idea_series_sum(s : CryptosymideaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sym_idea_series_mean(s : CryptosymideaSeries) -> Double {
  let n = crypto_sym_idea_series_len(s)
  if n == 0 { 0.0 } else { crypto_sym_idea_series_sum(s) / n.to_double() }
}

pub fn crypto_sym_idea_series_min(s : CryptosymideaSeries) -> Double {
  let n = crypto_sym_idea_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_idea_series_max(s : CryptosymideaSeries) -> Double {
  let n = crypto_sym_idea_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sym_idea_series_range(s : CryptosymideaSeries) -> Double {
  crypto_sym_idea_series_max(s) - crypto_sym_idea_series_min(s)
}

pub fn crypto_sym_idea_series_var(s : CryptosymideaSeries) -> Double {
  let n = crypto_sym_idea_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sym_idea_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sym_idea_series_std(s : CryptosymideaSeries) -> Double { crypto_sym_idea_sqrt(crypto_sym_idea_series_var(s)) }

pub fn crypto_sym_idea_series_median(s : CryptosymideaSeries) -> Double {
  let n = crypto_sym_idea_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_idea_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_idea_series_scale(s : CryptosymideaSeries, f : Double) -> CryptosymideaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_sym_idea_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_idea_series_add(a : CryptosymideaSeries, b : CryptosymideaSeries) -> CryptosymideaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sym_idea_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_idea_series_sub(a : CryptosymideaSeries, b : CryptosymideaSeries) -> CryptosymideaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_sym_idea_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_idea_series_normalize(s : CryptosymideaSeries) -> CryptosymideaSeries {
  let mn = crypto_sym_idea_series_min(s)
  let mx = crypto_sym_idea_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_sym_idea_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_idea_series_cumsum(s : CryptosymideaSeries) -> CryptosymideaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_sym_idea_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_idea_series_to_string(s : CryptosymideaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sym_idea_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymideaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_idea_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymideaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_idea_matrix_identity(n : Int) -> CryptosymideaMatrix {
  let m = crypto_sym_idea_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_idea_matrix_get(m : CryptosymideaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_idea_matrix_transpose(m : CryptosymideaMatrix) -> CryptosymideaMatrix {
  let result = crypto_sym_idea_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_idea_matrix_add(a : CryptosymideaMatrix, b : CryptosymideaMatrix) -> CryptosymideaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_idea_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_idea_matrix_scale(m : CryptosymideaMatrix, s : Double) -> CryptosymideaMatrix {
  let result = crypto_sym_idea_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_idea_matrix_multiply(a : CryptosymideaMatrix, b : CryptosymideaMatrix) -> CryptosymideaMatrix {
  if a.cols != b.rows { return crypto_sym_idea_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_idea_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_idea_matrix_trace(m : CryptosymideaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_idea_matrix_det(m : CryptosymideaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_idea_matrix_norm(m : CryptosymideaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_sym_idea_sqrt(sum)
}

pub fn crypto_sym_idea_matrix_to_string(m : CryptosymideaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_sym_idea_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosymideaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_idea_make_vector(comps : Array[Double]) -> CryptosymideaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_idea_vector_zero(dim : Int) -> CryptosymideaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_idea_vector_add(a : CryptosymideaVector, b : CryptosymideaVector) -> CryptosymideaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sym_idea_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_idea_vector_sub(a : CryptosymideaVector, b : CryptosymideaVector) -> CryptosymideaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_sym_idea_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_idea_vector_scale(v : CryptosymideaVector, s : Double) -> CryptosymideaVector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_sym_idea_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_idea_vector_dot(a : CryptosymideaVector, b : CryptosymideaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_idea_vector_norm(v : CryptosymideaVector) -> Double { crypto_sym_idea_sqrt(crypto_sym_idea_vector_dot(v, v)) }

pub fn crypto_sym_idea_vector_normalize(v : CryptosymideaVector) -> CryptosymideaVector {
  let n = crypto_sym_idea_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_idea_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_idea_vector_dist(a : CryptosymideaVector, b : CryptosymideaVector) -> Double {
  crypto_sym_idea_vector_norm(crypto_sym_idea_vector_sub(a, b))
}

pub fn crypto_sym_idea_vector_to_string(v : CryptosymideaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_sym_idea_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_idea_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_sym_idea_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_sym_idea_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_idea_std(data : Array[Double]) -> Double { crypto_sym_idea_sqrt(crypto_sym_idea_var(data)) }

pub fn crypto_sym_idea_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_sym_idea_mean(a); let mb = crypto_sym_idea_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_idea_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_sym_idea_std(a); let sb = crypto_sym_idea_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_sym_idea_cov(a, b) / (sa * sb) }
}

pub fn crypto_sym_idea_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_sym_idea_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sym_idea_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_sym_idea_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_sym_idea_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_sym_idea_sqrt(crypto_sym_idea_mse(pred, labels))
}

pub fn crypto_sym_idea_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_sym_idea_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_sym_idea_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_sym_idea_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_sym_idea_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_sym_idea_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_sym_idea_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_sym_idea_precision(pred, labels, pos); let r = crypto_sym_idea_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_sym_idea_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_sym_idea_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_sym_idea_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_sym_idea_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_sym_idea_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_sym_idea_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_sym_idea_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_sym_idea_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_sym_idea_fibonacci(n : Int) -> Int {
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

pub fn crypto_sym_idea_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_sym_idea_min(data); let mx = crypto_sym_idea_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_sym_idea_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_sym_idea_mean(data); let sd = crypto_sym_idea_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_sym_idea_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_sym_idea_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_idea_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_sym_idea_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_sym_idea_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_sym_idea_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_sym_idea_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_sym_idea_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_sym_idea_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_sym_idea_int(x) } else { -crypto_sym_idea_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_sym_idea_int(f * 1000000.0) } else { crypto_sym_idea_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_sym_idea_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_sym_idea_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct CryptosymideaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_frame_make(size : Int) -> CryptosymideaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_frame_len(s : CryptosymideaFrame) -> Int { s.size }

pub fn crypto_sym_idea_frame_get(s : CryptosymideaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_frame_set(s : CryptosymideaFrame, i : Int, v : Double) -> CryptosymideaFrame {
  let result = crypto_sym_idea_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_frame_sum(s : CryptosymideaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_frame_mean(s : CryptosymideaFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_frame_scale(s : CryptosymideaFrame, f : Double) -> CryptosymideaFrame {
  let result = crypto_sym_idea_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_frame_add(a : CryptosymideaFrame, b : CryptosymideaFrame) -> CryptosymideaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_frame_copy(s : CryptosymideaFrame) -> CryptosymideaFrame {
  let result = crypto_sym_idea_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_frame_fill(s : CryptosymideaFrame, v : Double) -> CryptosymideaFrame {
  let result = crypto_sym_idea_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_frame_min(s : CryptosymideaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_frame_max(s : CryptosymideaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_frame_to_string(s : CryptosymideaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_table_make(size : Int) -> CryptosymideaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_table_len(s : CryptosymideaTable) -> Int { s.size }

pub fn crypto_sym_idea_table_get(s : CryptosymideaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_table_set(s : CryptosymideaTable, i : Int, v : Double) -> CryptosymideaTable {
  let result = crypto_sym_idea_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_table_sum(s : CryptosymideaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_table_mean(s : CryptosymideaTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_table_scale(s : CryptosymideaTable, f : Double) -> CryptosymideaTable {
  let result = crypto_sym_idea_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_table_add(a : CryptosymideaTable, b : CryptosymideaTable) -> CryptosymideaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_table_copy(s : CryptosymideaTable) -> CryptosymideaTable {
  let result = crypto_sym_idea_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_table_fill(s : CryptosymideaTable, v : Double) -> CryptosymideaTable {
  let result = crypto_sym_idea_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_table_min(s : CryptosymideaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_table_max(s : CryptosymideaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_table_to_string(s : CryptosymideaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_graphn_make(size : Int) -> CryptosymideaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_graphn_len(s : CryptosymideaGraphN) -> Int { s.size }

pub fn crypto_sym_idea_graphn_get(s : CryptosymideaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_graphn_set(s : CryptosymideaGraphN, i : Int, v : Double) -> CryptosymideaGraphN {
  let result = crypto_sym_idea_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_graphn_sum(s : CryptosymideaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_graphn_mean(s : CryptosymideaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_graphn_scale(s : CryptosymideaGraphN, f : Double) -> CryptosymideaGraphN {
  let result = crypto_sym_idea_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_graphn_add(a : CryptosymideaGraphN, b : CryptosymideaGraphN) -> CryptosymideaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_graphn_copy(s : CryptosymideaGraphN) -> CryptosymideaGraphN {
  let result = crypto_sym_idea_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_graphn_fill(s : CryptosymideaGraphN, v : Double) -> CryptosymideaGraphN {
  let result = crypto_sym_idea_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_graphn_min(s : CryptosymideaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_graphn_max(s : CryptosymideaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_graphn_to_string(s : CryptosymideaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_node_make(size : Int) -> CryptosymideaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_node_len(s : CryptosymideaNode) -> Int { s.size }

pub fn crypto_sym_idea_node_get(s : CryptosymideaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_node_set(s : CryptosymideaNode, i : Int, v : Double) -> CryptosymideaNode {
  let result = crypto_sym_idea_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_node_sum(s : CryptosymideaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_node_mean(s : CryptosymideaNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_node_scale(s : CryptosymideaNode, f : Double) -> CryptosymideaNode {
  let result = crypto_sym_idea_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_node_add(a : CryptosymideaNode, b : CryptosymideaNode) -> CryptosymideaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_node_copy(s : CryptosymideaNode) -> CryptosymideaNode {
  let result = crypto_sym_idea_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_node_fill(s : CryptosymideaNode, v : Double) -> CryptosymideaNode {
  let result = crypto_sym_idea_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_node_min(s : CryptosymideaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_node_max(s : CryptosymideaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_node_to_string(s : CryptosymideaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_edge_make(size : Int) -> CryptosymideaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_edge_len(s : CryptosymideaEdge) -> Int { s.size }

pub fn crypto_sym_idea_edge_get(s : CryptosymideaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_edge_set(s : CryptosymideaEdge, i : Int, v : Double) -> CryptosymideaEdge {
  let result = crypto_sym_idea_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_edge_sum(s : CryptosymideaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_edge_mean(s : CryptosymideaEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_edge_scale(s : CryptosymideaEdge, f : Double) -> CryptosymideaEdge {
  let result = crypto_sym_idea_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_edge_add(a : CryptosymideaEdge, b : CryptosymideaEdge) -> CryptosymideaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_edge_copy(s : CryptosymideaEdge) -> CryptosymideaEdge {
  let result = crypto_sym_idea_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_edge_fill(s : CryptosymideaEdge, v : Double) -> CryptosymideaEdge {
  let result = crypto_sym_idea_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_edge_min(s : CryptosymideaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_edge_max(s : CryptosymideaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_edge_to_string(s : CryptosymideaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_path_make(size : Int) -> CryptosymideaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_path_len(s : CryptosymideaPath) -> Int { s.size }

pub fn crypto_sym_idea_path_get(s : CryptosymideaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_path_set(s : CryptosymideaPath, i : Int, v : Double) -> CryptosymideaPath {
  let result = crypto_sym_idea_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_path_sum(s : CryptosymideaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_path_mean(s : CryptosymideaPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_path_scale(s : CryptosymideaPath, f : Double) -> CryptosymideaPath {
  let result = crypto_sym_idea_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_path_add(a : CryptosymideaPath, b : CryptosymideaPath) -> CryptosymideaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_path_copy(s : CryptosymideaPath) -> CryptosymideaPath {
  let result = crypto_sym_idea_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_path_fill(s : CryptosymideaPath, v : Double) -> CryptosymideaPath {
  let result = crypto_sym_idea_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_path_min(s : CryptosymideaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_path_max(s : CryptosymideaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_path_to_string(s : CryptosymideaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_cluster_make(size : Int) -> CryptosymideaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_cluster_len(s : CryptosymideaCluster) -> Int { s.size }

pub fn crypto_sym_idea_cluster_get(s : CryptosymideaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_cluster_set(s : CryptosymideaCluster, i : Int, v : Double) -> CryptosymideaCluster {
  let result = crypto_sym_idea_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_cluster_sum(s : CryptosymideaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_cluster_mean(s : CryptosymideaCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_cluster_scale(s : CryptosymideaCluster, f : Double) -> CryptosymideaCluster {
  let result = crypto_sym_idea_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_cluster_add(a : CryptosymideaCluster, b : CryptosymideaCluster) -> CryptosymideaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_cluster_copy(s : CryptosymideaCluster) -> CryptosymideaCluster {
  let result = crypto_sym_idea_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_cluster_fill(s : CryptosymideaCluster, v : Double) -> CryptosymideaCluster {
  let result = crypto_sym_idea_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_cluster_min(s : CryptosymideaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_cluster_max(s : CryptosymideaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_cluster_to_string(s : CryptosymideaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_model_make(size : Int) -> CryptosymideaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_model_len(s : CryptosymideaModel) -> Int { s.size }

pub fn crypto_sym_idea_model_get(s : CryptosymideaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_model_set(s : CryptosymideaModel, i : Int, v : Double) -> CryptosymideaModel {
  let result = crypto_sym_idea_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_model_sum(s : CryptosymideaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_model_mean(s : CryptosymideaModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_model_scale(s : CryptosymideaModel, f : Double) -> CryptosymideaModel {
  let result = crypto_sym_idea_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_model_add(a : CryptosymideaModel, b : CryptosymideaModel) -> CryptosymideaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_model_copy(s : CryptosymideaModel) -> CryptosymideaModel {
  let result = crypto_sym_idea_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_model_fill(s : CryptosymideaModel, v : Double) -> CryptosymideaModel {
  let result = crypto_sym_idea_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_model_min(s : CryptosymideaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_model_max(s : CryptosymideaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_model_to_string(s : CryptosymideaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_layer_make(size : Int) -> CryptosymideaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_layer_len(s : CryptosymideaLayer) -> Int { s.size }

pub fn crypto_sym_idea_layer_get(s : CryptosymideaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_layer_set(s : CryptosymideaLayer, i : Int, v : Double) -> CryptosymideaLayer {
  let result = crypto_sym_idea_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_layer_sum(s : CryptosymideaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_layer_mean(s : CryptosymideaLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_layer_scale(s : CryptosymideaLayer, f : Double) -> CryptosymideaLayer {
  let result = crypto_sym_idea_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_layer_add(a : CryptosymideaLayer, b : CryptosymideaLayer) -> CryptosymideaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_layer_copy(s : CryptosymideaLayer) -> CryptosymideaLayer {
  let result = crypto_sym_idea_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_layer_fill(s : CryptosymideaLayer, v : Double) -> CryptosymideaLayer {
  let result = crypto_sym_idea_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_layer_min(s : CryptosymideaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_layer_max(s : CryptosymideaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_layer_to_string(s : CryptosymideaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_buffer_make(size : Int) -> CryptosymideaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_buffer_len(s : CryptosymideaBuffer) -> Int { s.size }

pub fn crypto_sym_idea_buffer_get(s : CryptosymideaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_buffer_set(s : CryptosymideaBuffer, i : Int, v : Double) -> CryptosymideaBuffer {
  let result = crypto_sym_idea_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_buffer_sum(s : CryptosymideaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_buffer_mean(s : CryptosymideaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_buffer_scale(s : CryptosymideaBuffer, f : Double) -> CryptosymideaBuffer {
  let result = crypto_sym_idea_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_buffer_add(a : CryptosymideaBuffer, b : CryptosymideaBuffer) -> CryptosymideaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_buffer_copy(s : CryptosymideaBuffer) -> CryptosymideaBuffer {
  let result = crypto_sym_idea_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_buffer_fill(s : CryptosymideaBuffer, v : Double) -> CryptosymideaBuffer {
  let result = crypto_sym_idea_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_buffer_min(s : CryptosymideaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_buffer_max(s : CryptosymideaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_buffer_to_string(s : CryptosymideaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_cursor_make(size : Int) -> CryptosymideaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_cursor_len(s : CryptosymideaCursor) -> Int { s.size }

pub fn crypto_sym_idea_cursor_get(s : CryptosymideaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_cursor_set(s : CryptosymideaCursor, i : Int, v : Double) -> CryptosymideaCursor {
  let result = crypto_sym_idea_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_cursor_sum(s : CryptosymideaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_cursor_mean(s : CryptosymideaCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_cursor_scale(s : CryptosymideaCursor, f : Double) -> CryptosymideaCursor {
  let result = crypto_sym_idea_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_cursor_add(a : CryptosymideaCursor, b : CryptosymideaCursor) -> CryptosymideaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_cursor_copy(s : CryptosymideaCursor) -> CryptosymideaCursor {
  let result = crypto_sym_idea_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_cursor_fill(s : CryptosymideaCursor, v : Double) -> CryptosymideaCursor {
  let result = crypto_sym_idea_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_cursor_min(s : CryptosymideaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_cursor_max(s : CryptosymideaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_cursor_to_string(s : CryptosymideaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_view_make(size : Int) -> CryptosymideaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_view_len(s : CryptosymideaView) -> Int { s.size }

pub fn crypto_sym_idea_view_get(s : CryptosymideaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_view_set(s : CryptosymideaView, i : Int, v : Double) -> CryptosymideaView {
  let result = crypto_sym_idea_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_view_sum(s : CryptosymideaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_view_mean(s : CryptosymideaView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_view_scale(s : CryptosymideaView, f : Double) -> CryptosymideaView {
  let result = crypto_sym_idea_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_view_add(a : CryptosymideaView, b : CryptosymideaView) -> CryptosymideaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_view_copy(s : CryptosymideaView) -> CryptosymideaView {
  let result = crypto_sym_idea_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_view_fill(s : CryptosymideaView, v : Double) -> CryptosymideaView {
  let result = crypto_sym_idea_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_view_min(s : CryptosymideaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_view_max(s : CryptosymideaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_view_to_string(s : CryptosymideaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_range_make(size : Int) -> CryptosymideaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_range_len(s : CryptosymideaRange) -> Int { s.size }

pub fn crypto_sym_idea_range_get(s : CryptosymideaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_range_set(s : CryptosymideaRange, i : Int, v : Double) -> CryptosymideaRange {
  let result = crypto_sym_idea_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_range_sum(s : CryptosymideaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_range_mean(s : CryptosymideaRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_range_scale(s : CryptosymideaRange, f : Double) -> CryptosymideaRange {
  let result = crypto_sym_idea_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_range_add(a : CryptosymideaRange, b : CryptosymideaRange) -> CryptosymideaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_range_copy(s : CryptosymideaRange) -> CryptosymideaRange {
  let result = crypto_sym_idea_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_range_fill(s : CryptosymideaRange, v : Double) -> CryptosymideaRange {
  let result = crypto_sym_idea_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_range_min(s : CryptosymideaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_range_max(s : CryptosymideaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_range_to_string(s : CryptosymideaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_slice_make(size : Int) -> CryptosymideaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_slice_len(s : CryptosymideaSlice) -> Int { s.size }

pub fn crypto_sym_idea_slice_get(s : CryptosymideaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_slice_set(s : CryptosymideaSlice, i : Int, v : Double) -> CryptosymideaSlice {
  let result = crypto_sym_idea_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_slice_sum(s : CryptosymideaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_idea_slice_mean(s : CryptosymideaSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_idea_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_idea_slice_scale(s : CryptosymideaSlice, f : Double) -> CryptosymideaSlice {
  let result = crypto_sym_idea_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_idea_slice_add(a : CryptosymideaSlice, b : CryptosymideaSlice) -> CryptosymideaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_idea_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_idea_slice_copy(s : CryptosymideaSlice) -> CryptosymideaSlice {
  let result = crypto_sym_idea_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_idea_slice_fill(s : CryptosymideaSlice, v : Double) -> CryptosymideaSlice {
  let result = crypto_sym_idea_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_idea_slice_min(s : CryptosymideaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_slice_max(s : CryptosymideaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_idea_slice_to_string(s : CryptosymideaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_sym_idea_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_sym_idea_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

