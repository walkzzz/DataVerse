///===
/// extcore/crypto_asym_sm2

pub(all) struct Cryptoasymsm2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_sm2_make_point(x : Double, y : Double) -> Cryptoasymsm2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_sm2_make_point3(x : Double, y : Double, z : Double) -> Cryptoasymsm2Point {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_sm2_point_x(pt : Cryptoasymsm2Point) -> Double { pt.x }

pub fn crypto_asym_sm2_point_y(pt : Cryptoasymsm2Point) -> Double { pt.y }

pub fn crypto_asym_sm2_point_z(pt : Cryptoasymsm2Point) -> Double { pt.z }

pub fn crypto_asym_sm2_point_label(pt : Cryptoasymsm2Point) -> Int { pt.label }

pub fn crypto_asym_sm2_point_dist(a : Cryptoasymsm2Point, b : Cryptoasymsm2Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_asym_sm2_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_sm2_point_add(a : Cryptoasymsm2Point, b : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_sm2_point_sub(a : Cryptoasymsm2Point, b : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_sm2_point_scale(pt : Cryptoasymsm2Point, s : Double) -> Cryptoasymsm2Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_sm2_point_dot(a : Cryptoasymsm2Point, b : Cryptoasymsm2Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_sm2_point_cross(a : Cryptoasymsm2Point, b : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_sm2_point_norm(pt : Cryptoasymsm2Point) -> Double {
  crypto_asym_sm2_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_sm2_point_normalize(pt : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  let n = crypto_asym_sm2_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_sm2_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_sm2_point_negate(pt : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_sm2_point_mid(a : Cryptoasymsm2Point, b : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_sm2_point_lerp(a : Cryptoasymsm2Point, b : Cryptoasymsm2Point, t : Double) -> Cryptoasymsm2Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_sm2_point_to_string(pt : Cryptoasymsm2Point) -> String {
  "(" + crypto_asym_sm2_dbl(pt.x) + ", " + crypto_asym_sm2_dbl(pt.y) + ", " + crypto_asym_sm2_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_sm2_make_series(vals : Array[Double], name : String) -> Cryptoasymsm2Series {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_sm2_series_len(s : Cryptoasymsm2Series) -> Int { s.vals.length() }

pub fn crypto_asym_sm2_series_sum(s : Cryptoasymsm2Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_asym_sm2_series_mean(s : Cryptoasymsm2Series) -> Double {
  let n = crypto_asym_sm2_series_len(s)
  if n == 0 { 0.0 } else { crypto_asym_sm2_series_sum(s) / n.to_double() }
}

pub fn crypto_asym_sm2_series_min(s : Cryptoasymsm2Series) -> Double {
  let n = crypto_asym_sm2_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_asym_sm2_series_max(s : Cryptoasymsm2Series) -> Double {
  let n = crypto_asym_sm2_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_asym_sm2_series_range(s : Cryptoasymsm2Series) -> Double {
  crypto_asym_sm2_series_max(s) - crypto_asym_sm2_series_min(s)
}

pub fn crypto_asym_sm2_series_var(s : Cryptoasymsm2Series) -> Double {
  let n = crypto_asym_sm2_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_asym_sm2_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_asym_sm2_series_std(s : Cryptoasymsm2Series) -> Double { crypto_asym_sm2_sqrt(crypto_asym_sm2_series_var(s)) }

pub fn crypto_asym_sm2_series_median(s : Cryptoasymsm2Series) -> Double {
  let n = crypto_asym_sm2_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_asym_sm2_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_asym_sm2_series_scale(s : Cryptoasymsm2Series, f : Double) -> Cryptoasymsm2Series {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_asym_sm2_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_asym_sm2_series_add(a : Cryptoasymsm2Series, b : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_asym_sm2_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_sm2_series_sub(a : Cryptoasymsm2Series, b : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_asym_sm2_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_sm2_series_normalize(s : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  let mn = crypto_asym_sm2_series_min(s)
  let mx = crypto_asym_sm2_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_asym_sm2_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_sm2_series_cumsum(s : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_asym_sm2_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_sm2_series_to_string(s : Cryptoasymsm2Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_asym_sm2_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptoasymsm2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_sm2_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptoasymsm2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_sm2_matrix_identity(n : Int) -> Cryptoasymsm2Matrix {
  let m = crypto_asym_sm2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_sm2_matrix_get(m : Cryptoasymsm2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_sm2_matrix_transpose(m : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  let result = crypto_asym_sm2_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_sm2_matrix_add(a : Cryptoasymsm2Matrix, b : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_sm2_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_sm2_matrix_scale(m : Cryptoasymsm2Matrix, s : Double) -> Cryptoasymsm2Matrix {
  let result = crypto_asym_sm2_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_sm2_matrix_multiply(a : Cryptoasymsm2Matrix, b : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  if a.cols != b.rows { return crypto_asym_sm2_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_sm2_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_sm2_matrix_trace(m : Cryptoasymsm2Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_sm2_matrix_det(m : Cryptoasymsm2Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_sm2_matrix_norm(m : Cryptoasymsm2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_asym_sm2_sqrt(sum)
}

pub fn crypto_asym_sm2_matrix_to_string(m : Cryptoasymsm2Matrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_asym_sm2_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Cryptoasymsm2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_sm2_make_vector(comps : Array[Double]) -> Cryptoasymsm2Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_sm2_vector_zero(dim : Int) -> Cryptoasymsm2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_sm2_vector_add(a : Cryptoasymsm2Vector, b : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_asym_sm2_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_sm2_vector_sub(a : Cryptoasymsm2Vector, b : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_asym_sm2_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_sm2_vector_scale(v : Cryptoasymsm2Vector, s : Double) -> Cryptoasymsm2Vector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_asym_sm2_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_asym_sm2_vector_dot(a : Cryptoasymsm2Vector, b : Cryptoasymsm2Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_sm2_vector_norm(v : Cryptoasymsm2Vector) -> Double { crypto_asym_sm2_sqrt(crypto_asym_sm2_vector_dot(v, v)) }

pub fn crypto_asym_sm2_vector_normalize(v : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = crypto_asym_sm2_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_sm2_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_sm2_vector_dist(a : Cryptoasymsm2Vector, b : Cryptoasymsm2Vector) -> Double {
  crypto_asym_sm2_vector_norm(crypto_asym_sm2_vector_sub(a, b))
}

pub fn crypto_asym_sm2_vector_to_string(v : Cryptoasymsm2Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_asym_sm2_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_sm2_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_asym_sm2_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_asym_sm2_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_asym_sm2_std(data : Array[Double]) -> Double { crypto_asym_sm2_sqrt(crypto_asym_sm2_var(data)) }

pub fn crypto_asym_sm2_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_asym_sm2_mean(a); let mb = crypto_asym_sm2_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_asym_sm2_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_asym_sm2_std(a); let sb = crypto_asym_sm2_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_asym_sm2_cov(a, b) / (sa * sb) }
}

pub fn crypto_asym_sm2_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_asym_sm2_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_asym_sm2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_asym_sm2_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_asym_sm2_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_asym_sm2_sqrt(crypto_asym_sm2_mse(pred, labels))
}

pub fn crypto_asym_sm2_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_asym_sm2_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_asym_sm2_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_asym_sm2_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_asym_sm2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_asym_sm2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_asym_sm2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_asym_sm2_precision(pred, labels, pos); let r = crypto_asym_sm2_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_asym_sm2_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_asym_sm2_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_asym_sm2_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_asym_sm2_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_asym_sm2_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_asym_sm2_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_asym_sm2_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_asym_sm2_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_asym_sm2_fibonacci(n : Int) -> Int {
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

pub fn crypto_asym_sm2_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_asym_sm2_min(data); let mx = crypto_asym_sm2_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_asym_sm2_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_asym_sm2_mean(data); let sd = crypto_asym_sm2_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_asym_sm2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_asym_sm2_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_asym_sm2_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_asym_sm2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_asym_sm2_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_asym_sm2_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_asym_sm2_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_asym_sm2_int(x) } else { -crypto_asym_sm2_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_asym_sm2_int(f * 1000000.0) } else { crypto_asym_sm2_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_asym_sm2_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_asym_sm2_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct Cryptoasymsm2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_frame_make(size : Int) -> Cryptoasymsm2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_frame_len(s : Cryptoasymsm2Frame) -> Int { s.size }

pub fn crypto_asym_sm2_frame_get(s : Cryptoasymsm2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_frame_set(s : Cryptoasymsm2Frame, i : Int, v : Double) -> Cryptoasymsm2Frame {
  let result = crypto_asym_sm2_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_frame_sum(s : Cryptoasymsm2Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_frame_mean(s : Cryptoasymsm2Frame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_frame_scale(s : Cryptoasymsm2Frame, f : Double) -> Cryptoasymsm2Frame {
  let result = crypto_asym_sm2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_frame_add(a : Cryptoasymsm2Frame, b : Cryptoasymsm2Frame) -> Cryptoasymsm2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_frame_copy(s : Cryptoasymsm2Frame) -> Cryptoasymsm2Frame {
  let result = crypto_asym_sm2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_frame_fill(s : Cryptoasymsm2Frame, v : Double) -> Cryptoasymsm2Frame {
  let result = crypto_asym_sm2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_frame_min(s : Cryptoasymsm2Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_frame_max(s : Cryptoasymsm2Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_frame_to_string(s : Cryptoasymsm2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_table_make(size : Int) -> Cryptoasymsm2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_table_len(s : Cryptoasymsm2Table) -> Int { s.size }

pub fn crypto_asym_sm2_table_get(s : Cryptoasymsm2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_table_set(s : Cryptoasymsm2Table, i : Int, v : Double) -> Cryptoasymsm2Table {
  let result = crypto_asym_sm2_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_table_sum(s : Cryptoasymsm2Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_table_mean(s : Cryptoasymsm2Table) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_table_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_table_scale(s : Cryptoasymsm2Table, f : Double) -> Cryptoasymsm2Table {
  let result = crypto_asym_sm2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_table_add(a : Cryptoasymsm2Table, b : Cryptoasymsm2Table) -> Cryptoasymsm2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_table_copy(s : Cryptoasymsm2Table) -> Cryptoasymsm2Table {
  let result = crypto_asym_sm2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_table_fill(s : Cryptoasymsm2Table, v : Double) -> Cryptoasymsm2Table {
  let result = crypto_asym_sm2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_table_min(s : Cryptoasymsm2Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_table_max(s : Cryptoasymsm2Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_table_to_string(s : Cryptoasymsm2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_graphn_make(size : Int) -> Cryptoasymsm2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_graphn_len(s : Cryptoasymsm2GraphN) -> Int { s.size }

pub fn crypto_asym_sm2_graphn_get(s : Cryptoasymsm2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_graphn_set(s : Cryptoasymsm2GraphN, i : Int, v : Double) -> Cryptoasymsm2GraphN {
  let result = crypto_asym_sm2_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_graphn_sum(s : Cryptoasymsm2GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_graphn_mean(s : Cryptoasymsm2GraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_graphn_scale(s : Cryptoasymsm2GraphN, f : Double) -> Cryptoasymsm2GraphN {
  let result = crypto_asym_sm2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_graphn_add(a : Cryptoasymsm2GraphN, b : Cryptoasymsm2GraphN) -> Cryptoasymsm2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_graphn_copy(s : Cryptoasymsm2GraphN) -> Cryptoasymsm2GraphN {
  let result = crypto_asym_sm2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_graphn_fill(s : Cryptoasymsm2GraphN, v : Double) -> Cryptoasymsm2GraphN {
  let result = crypto_asym_sm2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_graphn_min(s : Cryptoasymsm2GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_graphn_max(s : Cryptoasymsm2GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_graphn_to_string(s : Cryptoasymsm2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_node_make(size : Int) -> Cryptoasymsm2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_node_len(s : Cryptoasymsm2Node) -> Int { s.size }

pub fn crypto_asym_sm2_node_get(s : Cryptoasymsm2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_node_set(s : Cryptoasymsm2Node, i : Int, v : Double) -> Cryptoasymsm2Node {
  let result = crypto_asym_sm2_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_node_sum(s : Cryptoasymsm2Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_node_mean(s : Cryptoasymsm2Node) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_node_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_node_scale(s : Cryptoasymsm2Node, f : Double) -> Cryptoasymsm2Node {
  let result = crypto_asym_sm2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_node_add(a : Cryptoasymsm2Node, b : Cryptoasymsm2Node) -> Cryptoasymsm2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_node_copy(s : Cryptoasymsm2Node) -> Cryptoasymsm2Node {
  let result = crypto_asym_sm2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_node_fill(s : Cryptoasymsm2Node, v : Double) -> Cryptoasymsm2Node {
  let result = crypto_asym_sm2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_node_min(s : Cryptoasymsm2Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_node_max(s : Cryptoasymsm2Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_node_to_string(s : Cryptoasymsm2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_edge_make(size : Int) -> Cryptoasymsm2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_edge_len(s : Cryptoasymsm2Edge) -> Int { s.size }

pub fn crypto_asym_sm2_edge_get(s : Cryptoasymsm2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_edge_set(s : Cryptoasymsm2Edge, i : Int, v : Double) -> Cryptoasymsm2Edge {
  let result = crypto_asym_sm2_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_edge_sum(s : Cryptoasymsm2Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_edge_mean(s : Cryptoasymsm2Edge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_edge_scale(s : Cryptoasymsm2Edge, f : Double) -> Cryptoasymsm2Edge {
  let result = crypto_asym_sm2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_edge_add(a : Cryptoasymsm2Edge, b : Cryptoasymsm2Edge) -> Cryptoasymsm2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_edge_copy(s : Cryptoasymsm2Edge) -> Cryptoasymsm2Edge {
  let result = crypto_asym_sm2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_edge_fill(s : Cryptoasymsm2Edge, v : Double) -> Cryptoasymsm2Edge {
  let result = crypto_asym_sm2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_edge_min(s : Cryptoasymsm2Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_edge_max(s : Cryptoasymsm2Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_edge_to_string(s : Cryptoasymsm2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_path_make(size : Int) -> Cryptoasymsm2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_path_len(s : Cryptoasymsm2Path) -> Int { s.size }

pub fn crypto_asym_sm2_path_get(s : Cryptoasymsm2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_path_set(s : Cryptoasymsm2Path, i : Int, v : Double) -> Cryptoasymsm2Path {
  let result = crypto_asym_sm2_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_path_sum(s : Cryptoasymsm2Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_path_mean(s : Cryptoasymsm2Path) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_path_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_path_scale(s : Cryptoasymsm2Path, f : Double) -> Cryptoasymsm2Path {
  let result = crypto_asym_sm2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_path_add(a : Cryptoasymsm2Path, b : Cryptoasymsm2Path) -> Cryptoasymsm2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_path_copy(s : Cryptoasymsm2Path) -> Cryptoasymsm2Path {
  let result = crypto_asym_sm2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_path_fill(s : Cryptoasymsm2Path, v : Double) -> Cryptoasymsm2Path {
  let result = crypto_asym_sm2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_path_min(s : Cryptoasymsm2Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_path_max(s : Cryptoasymsm2Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_path_to_string(s : Cryptoasymsm2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_cluster_make(size : Int) -> Cryptoasymsm2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_cluster_len(s : Cryptoasymsm2Cluster) -> Int { s.size }

pub fn crypto_asym_sm2_cluster_get(s : Cryptoasymsm2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_cluster_set(s : Cryptoasymsm2Cluster, i : Int, v : Double) -> Cryptoasymsm2Cluster {
  let result = crypto_asym_sm2_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_cluster_sum(s : Cryptoasymsm2Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_cluster_mean(s : Cryptoasymsm2Cluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_cluster_scale(s : Cryptoasymsm2Cluster, f : Double) -> Cryptoasymsm2Cluster {
  let result = crypto_asym_sm2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_cluster_add(a : Cryptoasymsm2Cluster, b : Cryptoasymsm2Cluster) -> Cryptoasymsm2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_cluster_copy(s : Cryptoasymsm2Cluster) -> Cryptoasymsm2Cluster {
  let result = crypto_asym_sm2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_cluster_fill(s : Cryptoasymsm2Cluster, v : Double) -> Cryptoasymsm2Cluster {
  let result = crypto_asym_sm2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_cluster_min(s : Cryptoasymsm2Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_cluster_max(s : Cryptoasymsm2Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_cluster_to_string(s : Cryptoasymsm2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_model_make(size : Int) -> Cryptoasymsm2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_model_len(s : Cryptoasymsm2Model) -> Int { s.size }

pub fn crypto_asym_sm2_model_get(s : Cryptoasymsm2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_model_set(s : Cryptoasymsm2Model, i : Int, v : Double) -> Cryptoasymsm2Model {
  let result = crypto_asym_sm2_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_model_sum(s : Cryptoasymsm2Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_model_mean(s : Cryptoasymsm2Model) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_model_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_model_scale(s : Cryptoasymsm2Model, f : Double) -> Cryptoasymsm2Model {
  let result = crypto_asym_sm2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_model_add(a : Cryptoasymsm2Model, b : Cryptoasymsm2Model) -> Cryptoasymsm2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_model_copy(s : Cryptoasymsm2Model) -> Cryptoasymsm2Model {
  let result = crypto_asym_sm2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_model_fill(s : Cryptoasymsm2Model, v : Double) -> Cryptoasymsm2Model {
  let result = crypto_asym_sm2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_model_min(s : Cryptoasymsm2Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_model_max(s : Cryptoasymsm2Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_model_to_string(s : Cryptoasymsm2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_layer_make(size : Int) -> Cryptoasymsm2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_layer_len(s : Cryptoasymsm2Layer) -> Int { s.size }

pub fn crypto_asym_sm2_layer_get(s : Cryptoasymsm2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_layer_set(s : Cryptoasymsm2Layer, i : Int, v : Double) -> Cryptoasymsm2Layer {
  let result = crypto_asym_sm2_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_layer_sum(s : Cryptoasymsm2Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_layer_mean(s : Cryptoasymsm2Layer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_layer_scale(s : Cryptoasymsm2Layer, f : Double) -> Cryptoasymsm2Layer {
  let result = crypto_asym_sm2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_layer_add(a : Cryptoasymsm2Layer, b : Cryptoasymsm2Layer) -> Cryptoasymsm2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_layer_copy(s : Cryptoasymsm2Layer) -> Cryptoasymsm2Layer {
  let result = crypto_asym_sm2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_layer_fill(s : Cryptoasymsm2Layer, v : Double) -> Cryptoasymsm2Layer {
  let result = crypto_asym_sm2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_layer_min(s : Cryptoasymsm2Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_layer_max(s : Cryptoasymsm2Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_layer_to_string(s : Cryptoasymsm2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_buffer_make(size : Int) -> Cryptoasymsm2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_buffer_len(s : Cryptoasymsm2Buffer) -> Int { s.size }

pub fn crypto_asym_sm2_buffer_get(s : Cryptoasymsm2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_buffer_set(s : Cryptoasymsm2Buffer, i : Int, v : Double) -> Cryptoasymsm2Buffer {
  let result = crypto_asym_sm2_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_buffer_sum(s : Cryptoasymsm2Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_buffer_mean(s : Cryptoasymsm2Buffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_buffer_scale(s : Cryptoasymsm2Buffer, f : Double) -> Cryptoasymsm2Buffer {
  let result = crypto_asym_sm2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_buffer_add(a : Cryptoasymsm2Buffer, b : Cryptoasymsm2Buffer) -> Cryptoasymsm2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_buffer_copy(s : Cryptoasymsm2Buffer) -> Cryptoasymsm2Buffer {
  let result = crypto_asym_sm2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_buffer_fill(s : Cryptoasymsm2Buffer, v : Double) -> Cryptoasymsm2Buffer {
  let result = crypto_asym_sm2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_buffer_min(s : Cryptoasymsm2Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_buffer_max(s : Cryptoasymsm2Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_buffer_to_string(s : Cryptoasymsm2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_cursor_make(size : Int) -> Cryptoasymsm2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_cursor_len(s : Cryptoasymsm2Cursor) -> Int { s.size }

pub fn crypto_asym_sm2_cursor_get(s : Cryptoasymsm2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_cursor_set(s : Cryptoasymsm2Cursor, i : Int, v : Double) -> Cryptoasymsm2Cursor {
  let result = crypto_asym_sm2_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_cursor_sum(s : Cryptoasymsm2Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_cursor_mean(s : Cryptoasymsm2Cursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_cursor_scale(s : Cryptoasymsm2Cursor, f : Double) -> Cryptoasymsm2Cursor {
  let result = crypto_asym_sm2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_cursor_add(a : Cryptoasymsm2Cursor, b : Cryptoasymsm2Cursor) -> Cryptoasymsm2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_cursor_copy(s : Cryptoasymsm2Cursor) -> Cryptoasymsm2Cursor {
  let result = crypto_asym_sm2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_cursor_fill(s : Cryptoasymsm2Cursor, v : Double) -> Cryptoasymsm2Cursor {
  let result = crypto_asym_sm2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_cursor_min(s : Cryptoasymsm2Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_cursor_max(s : Cryptoasymsm2Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_cursor_to_string(s : Cryptoasymsm2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_view_make(size : Int) -> Cryptoasymsm2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_view_len(s : Cryptoasymsm2View) -> Int { s.size }

pub fn crypto_asym_sm2_view_get(s : Cryptoasymsm2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_view_set(s : Cryptoasymsm2View, i : Int, v : Double) -> Cryptoasymsm2View {
  let result = crypto_asym_sm2_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_view_sum(s : Cryptoasymsm2View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_view_mean(s : Cryptoasymsm2View) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_view_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_view_scale(s : Cryptoasymsm2View, f : Double) -> Cryptoasymsm2View {
  let result = crypto_asym_sm2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_view_add(a : Cryptoasymsm2View, b : Cryptoasymsm2View) -> Cryptoasymsm2View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_view_copy(s : Cryptoasymsm2View) -> Cryptoasymsm2View {
  let result = crypto_asym_sm2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_view_fill(s : Cryptoasymsm2View, v : Double) -> Cryptoasymsm2View {
  let result = crypto_asym_sm2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_view_min(s : Cryptoasymsm2View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_view_max(s : Cryptoasymsm2View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_view_to_string(s : Cryptoasymsm2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_range_make(size : Int) -> Cryptoasymsm2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_range_len(s : Cryptoasymsm2Range) -> Int { s.size }

pub fn crypto_asym_sm2_range_get(s : Cryptoasymsm2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_range_set(s : Cryptoasymsm2Range, i : Int, v : Double) -> Cryptoasymsm2Range {
  let result = crypto_asym_sm2_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_range_sum(s : Cryptoasymsm2Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_range_mean(s : Cryptoasymsm2Range) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_range_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_range_scale(s : Cryptoasymsm2Range, f : Double) -> Cryptoasymsm2Range {
  let result = crypto_asym_sm2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_range_add(a : Cryptoasymsm2Range, b : Cryptoasymsm2Range) -> Cryptoasymsm2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_range_copy(s : Cryptoasymsm2Range) -> Cryptoasymsm2Range {
  let result = crypto_asym_sm2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_range_fill(s : Cryptoasymsm2Range, v : Double) -> Cryptoasymsm2Range {
  let result = crypto_asym_sm2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_range_min(s : Cryptoasymsm2Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_range_max(s : Cryptoasymsm2Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_range_to_string(s : Cryptoasymsm2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_slice_make(size : Int) -> Cryptoasymsm2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_slice_len(s : Cryptoasymsm2Slice) -> Int { s.size }

pub fn crypto_asym_sm2_slice_get(s : Cryptoasymsm2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_slice_set(s : Cryptoasymsm2Slice, i : Int, v : Double) -> Cryptoasymsm2Slice {
  let result = crypto_asym_sm2_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_slice_sum(s : Cryptoasymsm2Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_sm2_slice_mean(s : Cryptoasymsm2Slice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_sm2_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_sm2_slice_scale(s : Cryptoasymsm2Slice, f : Double) -> Cryptoasymsm2Slice {
  let result = crypto_asym_sm2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_sm2_slice_add(a : Cryptoasymsm2Slice, b : Cryptoasymsm2Slice) -> Cryptoasymsm2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_sm2_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_sm2_slice_copy(s : Cryptoasymsm2Slice) -> Cryptoasymsm2Slice {
  let result = crypto_asym_sm2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_sm2_slice_fill(s : Cryptoasymsm2Slice, v : Double) -> Cryptoasymsm2Slice {
  let result = crypto_asym_sm2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm2_slice_min(s : Cryptoasymsm2Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_slice_max(s : Cryptoasymsm2Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_sm2_slice_to_string(s : Cryptoasymsm2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_asym_sm2_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_asym_sm2_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

