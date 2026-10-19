///===
/// extcore/crypto_hash_md5

pub(all) struct Cryptohashmd5Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_md5_make_point(x : Double, y : Double) -> Cryptohashmd5Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_md5_make_point3(x : Double, y : Double, z : Double) -> Cryptohashmd5Point {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_md5_point_x(pt : Cryptohashmd5Point) -> Double { pt.x }

pub fn crypto_hash_md5_point_y(pt : Cryptohashmd5Point) -> Double { pt.y }

pub fn crypto_hash_md5_point_z(pt : Cryptohashmd5Point) -> Double { pt.z }

pub fn crypto_hash_md5_point_label(pt : Cryptohashmd5Point) -> Int { pt.label }

pub fn crypto_hash_md5_point_dist(a : Cryptohashmd5Point, b : Cryptohashmd5Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  crypto_hash_md5_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_md5_point_add(a : Cryptohashmd5Point, b : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_md5_point_sub(a : Cryptohashmd5Point, b : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_md5_point_scale(pt : Cryptohashmd5Point, s : Double) -> Cryptohashmd5Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_md5_point_dot(a : Cryptohashmd5Point, b : Cryptohashmd5Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_md5_point_cross(a : Cryptohashmd5Point, b : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_md5_point_norm(pt : Cryptohashmd5Point) -> Double {
  crypto_hash_md5_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_md5_point_normalize(pt : Cryptohashmd5Point) -> Cryptohashmd5Point {
  let n = crypto_hash_md5_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_md5_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_md5_point_negate(pt : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_md5_point_mid(a : Cryptohashmd5Point, b : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_md5_point_lerp(a : Cryptohashmd5Point, b : Cryptohashmd5Point, t : Double) -> Cryptohashmd5Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_md5_point_to_string(pt : Cryptohashmd5Point) -> String {
  "(" + crypto_hash_md5_dbl(pt.x) + ", " + crypto_hash_md5_dbl(pt.y) + ", " + crypto_hash_md5_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptohashmd5Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_md5_make_series(vals : Array[Double], name : String) -> Cryptohashmd5Series {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_md5_series_len(s : Cryptohashmd5Series) -> Int { s.vals.length() }

pub fn crypto_hash_md5_series_sum(s : Cryptohashmd5Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_hash_md5_series_mean(s : Cryptohashmd5Series) -> Double {
  let n = crypto_hash_md5_series_len(s)
  if n == 0 { 0.0 } else { crypto_hash_md5_series_sum(s) / n.to_double() }
}

pub fn crypto_hash_md5_series_min(s : Cryptohashmd5Series) -> Double {
  let n = crypto_hash_md5_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_hash_md5_series_max(s : Cryptohashmd5Series) -> Double {
  let n = crypto_hash_md5_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_hash_md5_series_range(s : Cryptohashmd5Series) -> Double {
  crypto_hash_md5_series_max(s) - crypto_hash_md5_series_min(s)
}

pub fn crypto_hash_md5_series_var(s : Cryptohashmd5Series) -> Double {
  let n = crypto_hash_md5_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_hash_md5_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_hash_md5_series_std(s : Cryptohashmd5Series) -> Double { crypto_hash_md5_sqrt(crypto_hash_md5_series_var(s)) }

pub fn crypto_hash_md5_series_median(s : Cryptohashmd5Series) -> Double {
  let n = crypto_hash_md5_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_hash_md5_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_hash_md5_series_scale(s : Cryptohashmd5Series, f : Double) -> Cryptohashmd5Series {
  let mut result = []
  for i in 0..<s.vals.length() { result = crypto_hash_md5_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_md5_series_add(a : Cryptohashmd5Series, b : Cryptohashmd5Series) -> Cryptohashmd5Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_hash_md5_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_md5_series_sub(a : Cryptohashmd5Series, b : Cryptohashmd5Series) -> Cryptohashmd5Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = crypto_hash_md5_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_md5_series_normalize(s : Cryptohashmd5Series) -> Cryptohashmd5Series {
  let mn = crypto_hash_md5_series_min(s)
  let mx = crypto_hash_md5_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = crypto_hash_md5_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_md5_series_cumsum(s : Cryptohashmd5Series) -> Cryptohashmd5Series {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = crypto_hash_md5_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_md5_series_to_string(s : Cryptohashmd5Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_hash_md5_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashmd5Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_md5_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashmd5Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_md5_matrix_identity(n : Int) -> Cryptohashmd5Matrix {
  let m = crypto_hash_md5_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_md5_matrix_get(m : Cryptohashmd5Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_md5_matrix_transpose(m : Cryptohashmd5Matrix) -> Cryptohashmd5Matrix {
  let result = crypto_hash_md5_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_md5_matrix_add(a : Cryptohashmd5Matrix, b : Cryptohashmd5Matrix) -> Cryptohashmd5Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_md5_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_md5_matrix_scale(m : Cryptohashmd5Matrix, s : Double) -> Cryptohashmd5Matrix {
  let result = crypto_hash_md5_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_md5_matrix_multiply(a : Cryptohashmd5Matrix, b : Cryptohashmd5Matrix) -> Cryptohashmd5Matrix {
  if a.cols != b.rows { return crypto_hash_md5_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_md5_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_md5_matrix_trace(m : Cryptohashmd5Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_md5_matrix_det(m : Cryptohashmd5Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_md5_matrix_norm(m : Cryptohashmd5Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  crypto_hash_md5_sqrt(sum)
}

pub fn crypto_hash_md5_matrix_to_string(m : Cryptohashmd5Matrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + crypto_hash_md5_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Cryptohashmd5Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_md5_make_vector(comps : Array[Double]) -> Cryptohashmd5Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_md5_vector_zero(dim : Int) -> Cryptohashmd5Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_md5_vector_add(a : Cryptohashmd5Vector, b : Cryptohashmd5Vector) -> Cryptohashmd5Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_hash_md5_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_md5_vector_sub(a : Cryptohashmd5Vector, b : Cryptohashmd5Vector) -> Cryptohashmd5Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = crypto_hash_md5_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_md5_vector_scale(v : Cryptohashmd5Vector, s : Double) -> Cryptohashmd5Vector {
  let mut result = []
  for i in 0..<v.dim { result = crypto_hash_md5_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_md5_vector_dot(a : Cryptohashmd5Vector, b : Cryptohashmd5Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_md5_vector_norm(v : Cryptohashmd5Vector) -> Double { crypto_hash_md5_sqrt(crypto_hash_md5_vector_dot(v, v)) }

pub fn crypto_hash_md5_vector_normalize(v : Cryptohashmd5Vector) -> Cryptohashmd5Vector {
  let n = crypto_hash_md5_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_md5_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_md5_vector_dist(a : Cryptohashmd5Vector, b : Cryptohashmd5Vector) -> Double {
  crypto_hash_md5_vector_norm(crypto_hash_md5_vector_sub(a, b))
}

pub fn crypto_hash_md5_vector_to_string(v : Cryptohashmd5Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + crypto_hash_md5_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_md5_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_hash_md5_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_hash_md5_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_hash_md5_std(data : Array[Double]) -> Double { crypto_hash_md5_sqrt(crypto_hash_md5_var(data)) }

pub fn crypto_hash_md5_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_hash_md5_mean(a); let mb = crypto_hash_md5_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_hash_md5_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_hash_md5_std(a); let sb = crypto_hash_md5_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_hash_md5_cov(a, b) / (sa * sb) }
}

pub fn crypto_hash_md5_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_hash_md5_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_hash_md5_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_hash_md5_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_hash_md5_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  crypto_hash_md5_sqrt(crypto_hash_md5_mse(pred, labels))
}

pub fn crypto_hash_md5_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + crypto_hash_md5_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_hash_md5_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_hash_md5_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_hash_md5_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_hash_md5_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_hash_md5_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_hash_md5_precision(pred, labels, pos); let r = crypto_hash_md5_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_hash_md5_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_hash_md5_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_hash_md5_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_hash_md5_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_hash_md5_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_hash_md5_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_hash_md5_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_hash_md5_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_hash_md5_fibonacci(n : Int) -> Int {
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

pub fn crypto_hash_md5_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_hash_md5_min(data); let mx = crypto_hash_md5_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_hash_md5_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_hash_md5_mean(data); let sd = crypto_hash_md5_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_hash_md5_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_hash_md5_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_hash_md5_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_hash_md5_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_hash_md5_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_hash_md5_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn crypto_hash_md5_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn crypto_hash_md5_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn crypto_hash_md5_dbl(x : Double) -> String {
  let i = if x >= 0.0 { crypto_hash_md5_int(x) } else { -crypto_hash_md5_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { crypto_hash_md5_int(f * 1000000.0) } else { crypto_hash_md5_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn crypto_hash_md5_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn crypto_hash_md5_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct Cryptohashmd5Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_frame_make(size : Int) -> Cryptohashmd5Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_frame_len(s : Cryptohashmd5Frame) -> Int { s.size }

pub fn crypto_hash_md5_frame_get(s : Cryptohashmd5Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_frame_set(s : Cryptohashmd5Frame, i : Int, v : Double) -> Cryptohashmd5Frame {
  let result = crypto_hash_md5_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_frame_sum(s : Cryptohashmd5Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_frame_mean(s : Cryptohashmd5Frame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_frame_scale(s : Cryptohashmd5Frame, f : Double) -> Cryptohashmd5Frame {
  let result = crypto_hash_md5_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_frame_add(a : Cryptohashmd5Frame, b : Cryptohashmd5Frame) -> Cryptohashmd5Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_frame_copy(s : Cryptohashmd5Frame) -> Cryptohashmd5Frame {
  let result = crypto_hash_md5_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_frame_fill(s : Cryptohashmd5Frame, v : Double) -> Cryptohashmd5Frame {
  let result = crypto_hash_md5_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_frame_min(s : Cryptohashmd5Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_frame_max(s : Cryptohashmd5Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_frame_to_string(s : Cryptohashmd5Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_table_make(size : Int) -> Cryptohashmd5Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_table_len(s : Cryptohashmd5Table) -> Int { s.size }

pub fn crypto_hash_md5_table_get(s : Cryptohashmd5Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_table_set(s : Cryptohashmd5Table, i : Int, v : Double) -> Cryptohashmd5Table {
  let result = crypto_hash_md5_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_table_sum(s : Cryptohashmd5Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_table_mean(s : Cryptohashmd5Table) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_table_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_table_scale(s : Cryptohashmd5Table, f : Double) -> Cryptohashmd5Table {
  let result = crypto_hash_md5_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_table_add(a : Cryptohashmd5Table, b : Cryptohashmd5Table) -> Cryptohashmd5Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_table_copy(s : Cryptohashmd5Table) -> Cryptohashmd5Table {
  let result = crypto_hash_md5_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_table_fill(s : Cryptohashmd5Table, v : Double) -> Cryptohashmd5Table {
  let result = crypto_hash_md5_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_table_min(s : Cryptohashmd5Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_table_max(s : Cryptohashmd5Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_table_to_string(s : Cryptohashmd5Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_graphn_make(size : Int) -> Cryptohashmd5GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_graphn_len(s : Cryptohashmd5GraphN) -> Int { s.size }

pub fn crypto_hash_md5_graphn_get(s : Cryptohashmd5GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_graphn_set(s : Cryptohashmd5GraphN, i : Int, v : Double) -> Cryptohashmd5GraphN {
  let result = crypto_hash_md5_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_graphn_sum(s : Cryptohashmd5GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_graphn_mean(s : Cryptohashmd5GraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_graphn_scale(s : Cryptohashmd5GraphN, f : Double) -> Cryptohashmd5GraphN {
  let result = crypto_hash_md5_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_graphn_add(a : Cryptohashmd5GraphN, b : Cryptohashmd5GraphN) -> Cryptohashmd5GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_graphn_copy(s : Cryptohashmd5GraphN) -> Cryptohashmd5GraphN {
  let result = crypto_hash_md5_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_graphn_fill(s : Cryptohashmd5GraphN, v : Double) -> Cryptohashmd5GraphN {
  let result = crypto_hash_md5_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_graphn_min(s : Cryptohashmd5GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_graphn_max(s : Cryptohashmd5GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_graphn_to_string(s : Cryptohashmd5GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_node_make(size : Int) -> Cryptohashmd5Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_node_len(s : Cryptohashmd5Node) -> Int { s.size }

pub fn crypto_hash_md5_node_get(s : Cryptohashmd5Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_node_set(s : Cryptohashmd5Node, i : Int, v : Double) -> Cryptohashmd5Node {
  let result = crypto_hash_md5_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_node_sum(s : Cryptohashmd5Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_node_mean(s : Cryptohashmd5Node) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_node_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_node_scale(s : Cryptohashmd5Node, f : Double) -> Cryptohashmd5Node {
  let result = crypto_hash_md5_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_node_add(a : Cryptohashmd5Node, b : Cryptohashmd5Node) -> Cryptohashmd5Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_node_copy(s : Cryptohashmd5Node) -> Cryptohashmd5Node {
  let result = crypto_hash_md5_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_node_fill(s : Cryptohashmd5Node, v : Double) -> Cryptohashmd5Node {
  let result = crypto_hash_md5_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_node_min(s : Cryptohashmd5Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_node_max(s : Cryptohashmd5Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_node_to_string(s : Cryptohashmd5Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_edge_make(size : Int) -> Cryptohashmd5Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_edge_len(s : Cryptohashmd5Edge) -> Int { s.size }

pub fn crypto_hash_md5_edge_get(s : Cryptohashmd5Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_edge_set(s : Cryptohashmd5Edge, i : Int, v : Double) -> Cryptohashmd5Edge {
  let result = crypto_hash_md5_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_edge_sum(s : Cryptohashmd5Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_edge_mean(s : Cryptohashmd5Edge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_edge_scale(s : Cryptohashmd5Edge, f : Double) -> Cryptohashmd5Edge {
  let result = crypto_hash_md5_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_edge_add(a : Cryptohashmd5Edge, b : Cryptohashmd5Edge) -> Cryptohashmd5Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_edge_copy(s : Cryptohashmd5Edge) -> Cryptohashmd5Edge {
  let result = crypto_hash_md5_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_edge_fill(s : Cryptohashmd5Edge, v : Double) -> Cryptohashmd5Edge {
  let result = crypto_hash_md5_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_edge_min(s : Cryptohashmd5Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_edge_max(s : Cryptohashmd5Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_edge_to_string(s : Cryptohashmd5Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_path_make(size : Int) -> Cryptohashmd5Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_path_len(s : Cryptohashmd5Path) -> Int { s.size }

pub fn crypto_hash_md5_path_get(s : Cryptohashmd5Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_path_set(s : Cryptohashmd5Path, i : Int, v : Double) -> Cryptohashmd5Path {
  let result = crypto_hash_md5_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_path_sum(s : Cryptohashmd5Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_path_mean(s : Cryptohashmd5Path) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_path_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_path_scale(s : Cryptohashmd5Path, f : Double) -> Cryptohashmd5Path {
  let result = crypto_hash_md5_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_path_add(a : Cryptohashmd5Path, b : Cryptohashmd5Path) -> Cryptohashmd5Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_path_copy(s : Cryptohashmd5Path) -> Cryptohashmd5Path {
  let result = crypto_hash_md5_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_path_fill(s : Cryptohashmd5Path, v : Double) -> Cryptohashmd5Path {
  let result = crypto_hash_md5_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_path_min(s : Cryptohashmd5Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_path_max(s : Cryptohashmd5Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_path_to_string(s : Cryptohashmd5Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_cluster_make(size : Int) -> Cryptohashmd5Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_cluster_len(s : Cryptohashmd5Cluster) -> Int { s.size }

pub fn crypto_hash_md5_cluster_get(s : Cryptohashmd5Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_cluster_set(s : Cryptohashmd5Cluster, i : Int, v : Double) -> Cryptohashmd5Cluster {
  let result = crypto_hash_md5_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_cluster_sum(s : Cryptohashmd5Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_cluster_mean(s : Cryptohashmd5Cluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_cluster_scale(s : Cryptohashmd5Cluster, f : Double) -> Cryptohashmd5Cluster {
  let result = crypto_hash_md5_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_cluster_add(a : Cryptohashmd5Cluster, b : Cryptohashmd5Cluster) -> Cryptohashmd5Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_cluster_copy(s : Cryptohashmd5Cluster) -> Cryptohashmd5Cluster {
  let result = crypto_hash_md5_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_cluster_fill(s : Cryptohashmd5Cluster, v : Double) -> Cryptohashmd5Cluster {
  let result = crypto_hash_md5_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_cluster_min(s : Cryptohashmd5Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_cluster_max(s : Cryptohashmd5Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_cluster_to_string(s : Cryptohashmd5Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_model_make(size : Int) -> Cryptohashmd5Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_model_len(s : Cryptohashmd5Model) -> Int { s.size }

pub fn crypto_hash_md5_model_get(s : Cryptohashmd5Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_model_set(s : Cryptohashmd5Model, i : Int, v : Double) -> Cryptohashmd5Model {
  let result = crypto_hash_md5_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_model_sum(s : Cryptohashmd5Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_model_mean(s : Cryptohashmd5Model) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_model_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_model_scale(s : Cryptohashmd5Model, f : Double) -> Cryptohashmd5Model {
  let result = crypto_hash_md5_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_model_add(a : Cryptohashmd5Model, b : Cryptohashmd5Model) -> Cryptohashmd5Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_model_copy(s : Cryptohashmd5Model) -> Cryptohashmd5Model {
  let result = crypto_hash_md5_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_model_fill(s : Cryptohashmd5Model, v : Double) -> Cryptohashmd5Model {
  let result = crypto_hash_md5_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_model_min(s : Cryptohashmd5Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_model_max(s : Cryptohashmd5Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_model_to_string(s : Cryptohashmd5Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_layer_make(size : Int) -> Cryptohashmd5Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_layer_len(s : Cryptohashmd5Layer) -> Int { s.size }

pub fn crypto_hash_md5_layer_get(s : Cryptohashmd5Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_layer_set(s : Cryptohashmd5Layer, i : Int, v : Double) -> Cryptohashmd5Layer {
  let result = crypto_hash_md5_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_layer_sum(s : Cryptohashmd5Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_layer_mean(s : Cryptohashmd5Layer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_layer_scale(s : Cryptohashmd5Layer, f : Double) -> Cryptohashmd5Layer {
  let result = crypto_hash_md5_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_layer_add(a : Cryptohashmd5Layer, b : Cryptohashmd5Layer) -> Cryptohashmd5Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_layer_copy(s : Cryptohashmd5Layer) -> Cryptohashmd5Layer {
  let result = crypto_hash_md5_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_layer_fill(s : Cryptohashmd5Layer, v : Double) -> Cryptohashmd5Layer {
  let result = crypto_hash_md5_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_layer_min(s : Cryptohashmd5Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_layer_max(s : Cryptohashmd5Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_layer_to_string(s : Cryptohashmd5Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_buffer_make(size : Int) -> Cryptohashmd5Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_buffer_len(s : Cryptohashmd5Buffer) -> Int { s.size }

pub fn crypto_hash_md5_buffer_get(s : Cryptohashmd5Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_buffer_set(s : Cryptohashmd5Buffer, i : Int, v : Double) -> Cryptohashmd5Buffer {
  let result = crypto_hash_md5_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_buffer_sum(s : Cryptohashmd5Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_buffer_mean(s : Cryptohashmd5Buffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_buffer_scale(s : Cryptohashmd5Buffer, f : Double) -> Cryptohashmd5Buffer {
  let result = crypto_hash_md5_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_buffer_add(a : Cryptohashmd5Buffer, b : Cryptohashmd5Buffer) -> Cryptohashmd5Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_buffer_copy(s : Cryptohashmd5Buffer) -> Cryptohashmd5Buffer {
  let result = crypto_hash_md5_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_buffer_fill(s : Cryptohashmd5Buffer, v : Double) -> Cryptohashmd5Buffer {
  let result = crypto_hash_md5_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_buffer_min(s : Cryptohashmd5Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_buffer_max(s : Cryptohashmd5Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_buffer_to_string(s : Cryptohashmd5Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_cursor_make(size : Int) -> Cryptohashmd5Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_cursor_len(s : Cryptohashmd5Cursor) -> Int { s.size }

pub fn crypto_hash_md5_cursor_get(s : Cryptohashmd5Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_cursor_set(s : Cryptohashmd5Cursor, i : Int, v : Double) -> Cryptohashmd5Cursor {
  let result = crypto_hash_md5_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_cursor_sum(s : Cryptohashmd5Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_cursor_mean(s : Cryptohashmd5Cursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_cursor_scale(s : Cryptohashmd5Cursor, f : Double) -> Cryptohashmd5Cursor {
  let result = crypto_hash_md5_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_cursor_add(a : Cryptohashmd5Cursor, b : Cryptohashmd5Cursor) -> Cryptohashmd5Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_cursor_copy(s : Cryptohashmd5Cursor) -> Cryptohashmd5Cursor {
  let result = crypto_hash_md5_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_cursor_fill(s : Cryptohashmd5Cursor, v : Double) -> Cryptohashmd5Cursor {
  let result = crypto_hash_md5_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_cursor_min(s : Cryptohashmd5Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_cursor_max(s : Cryptohashmd5Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_cursor_to_string(s : Cryptohashmd5Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_view_make(size : Int) -> Cryptohashmd5View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_view_len(s : Cryptohashmd5View) -> Int { s.size }

pub fn crypto_hash_md5_view_get(s : Cryptohashmd5View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_view_set(s : Cryptohashmd5View, i : Int, v : Double) -> Cryptohashmd5View {
  let result = crypto_hash_md5_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_view_sum(s : Cryptohashmd5View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_view_mean(s : Cryptohashmd5View) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_view_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_view_scale(s : Cryptohashmd5View, f : Double) -> Cryptohashmd5View {
  let result = crypto_hash_md5_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_view_add(a : Cryptohashmd5View, b : Cryptohashmd5View) -> Cryptohashmd5View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_view_copy(s : Cryptohashmd5View) -> Cryptohashmd5View {
  let result = crypto_hash_md5_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_view_fill(s : Cryptohashmd5View, v : Double) -> Cryptohashmd5View {
  let result = crypto_hash_md5_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_view_min(s : Cryptohashmd5View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_view_max(s : Cryptohashmd5View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_view_to_string(s : Cryptohashmd5View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_range_make(size : Int) -> Cryptohashmd5Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_range_len(s : Cryptohashmd5Range) -> Int { s.size }

pub fn crypto_hash_md5_range_get(s : Cryptohashmd5Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_range_set(s : Cryptohashmd5Range, i : Int, v : Double) -> Cryptohashmd5Range {
  let result = crypto_hash_md5_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_range_sum(s : Cryptohashmd5Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_range_mean(s : Cryptohashmd5Range) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_range_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_range_scale(s : Cryptohashmd5Range, f : Double) -> Cryptohashmd5Range {
  let result = crypto_hash_md5_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_range_add(a : Cryptohashmd5Range, b : Cryptohashmd5Range) -> Cryptohashmd5Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_range_copy(s : Cryptohashmd5Range) -> Cryptohashmd5Range {
  let result = crypto_hash_md5_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_range_fill(s : Cryptohashmd5Range, v : Double) -> Cryptohashmd5Range {
  let result = crypto_hash_md5_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_range_min(s : Cryptohashmd5Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_range_max(s : Cryptohashmd5Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_range_to_string(s : Cryptohashmd5Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_slice_make(size : Int) -> Cryptohashmd5Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_slice_len(s : Cryptohashmd5Slice) -> Int { s.size }

pub fn crypto_hash_md5_slice_get(s : Cryptohashmd5Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_slice_set(s : Cryptohashmd5Slice, i : Int, v : Double) -> Cryptohashmd5Slice {
  let result = crypto_hash_md5_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_slice_sum(s : Cryptohashmd5Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_md5_slice_mean(s : Cryptohashmd5Slice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_md5_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_md5_slice_scale(s : Cryptohashmd5Slice, f : Double) -> Cryptohashmd5Slice {
  let result = crypto_hash_md5_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_md5_slice_add(a : Cryptohashmd5Slice, b : Cryptohashmd5Slice) -> Cryptohashmd5Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_md5_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_md5_slice_copy(s : Cryptohashmd5Slice) -> Cryptohashmd5Slice {
  let result = crypto_hash_md5_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_md5_slice_fill(s : Cryptohashmd5Slice, v : Double) -> Cryptohashmd5Slice {
  let result = crypto_hash_md5_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_md5_slice_min(s : Cryptohashmd5Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_slice_max(s : Cryptohashmd5Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_md5_slice_to_string(s : Cryptohashmd5Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn crypto_hash_md5_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn crypto_hash_md5_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

