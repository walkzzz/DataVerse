///===
/// extcore/crypto_hash_sha256

pub(all) struct Cryptohashsha256Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha256_make_point(x : Double, y : Double) -> Cryptohashsha256Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha256_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha256Point {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_sha256_point_x(pt : Cryptohashsha256Point) -> Double { pt.x }

pub fn crypto_hash_sha256_point_y(pt : Cryptohashsha256Point) -> Double { pt.y }

pub fn crypto_hash_sha256_point_z(pt : Cryptohashsha256Point) -> Double { pt.z }

pub fn crypto_hash_sha256_point_label(pt : Cryptohashsha256Point) -> Int { pt.label }

pub fn crypto_hash_sha256_point_dist(a : Cryptohashsha256Point, b : Cryptohashsha256Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_sha256_point_add(a : Cryptohashsha256Point, b : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_sha256_point_sub(a : Cryptohashsha256Point, b : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_sha256_point_scale(pt : Cryptohashsha256Point, s : Double) -> Cryptohashsha256Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_sha256_point_dot(a : Cryptohashsha256Point, b : Cryptohashsha256Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_sha256_point_cross(a : Cryptohashsha256Point, b : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_sha256_point_norm(pt : Cryptohashsha256Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_sha256_point_normalize(pt : Cryptohashsha256Point) -> Cryptohashsha256Point {
  let n = crypto_hash_sha256_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_sha256_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_sha256_point_negate(pt : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_sha256_point_mid(a : Cryptohashsha256Point, b : Cryptohashsha256Point) -> Cryptohashsha256Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_sha256_point_lerp(a : Cryptohashsha256Point, b : Cryptohashsha256Point, t : Double) -> Cryptohashsha256Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_sha256_point_to_string(pt : Cryptohashsha256Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptohashsha256Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha256_make_series(vals : Array[Double], name : String) -> Cryptohashsha256Series {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_sha256_series_len(s : Cryptohashsha256Series) -> Int { s.vals.length() }

pub fn crypto_hash_sha256_series_sum(s : Cryptohashsha256Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_hash_sha256_series_mean(s : Cryptohashsha256Series) -> Double {
  let n = crypto_hash_sha256_series_len(s)
  if n == 0 { 0.0 } else { crypto_hash_sha256_series_sum(s) / n.to_double() }
}

pub fn crypto_hash_sha256_series_min(s : Cryptohashsha256Series) -> Double {
  let n = crypto_hash_sha256_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_hash_sha256_series_max(s : Cryptohashsha256Series) -> Double {
  let n = crypto_hash_sha256_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_hash_sha256_series_range(s : Cryptohashsha256Series) -> Double {
  crypto_hash_sha256_series_max(s) - crypto_hash_sha256_series_min(s)
}

pub fn crypto_hash_sha256_series_var(s : Cryptohashsha256Series) -> Double {
  let n = crypto_hash_sha256_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_hash_sha256_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_hash_sha256_series_std(s : Cryptohashsha256Series) -> Double { @_common.sqrt(crypto_hash_sha256_series_var(s)) }

pub fn crypto_hash_sha256_series_median(s : Cryptohashsha256Series) -> Double {
  let n = crypto_hash_sha256_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_hash_sha256_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_hash_sha256_series_scale(s : Cryptohashsha256Series, f : Double) -> Cryptohashsha256Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_sha256_series_add(a : Cryptohashsha256Series, b : Cryptohashsha256Series) -> Cryptohashsha256Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_sha256_series_sub(a : Cryptohashsha256Series, b : Cryptohashsha256Series) -> Cryptohashsha256Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_sha256_series_normalize(s : Cryptohashsha256Series) -> Cryptohashsha256Series {
  let mn = crypto_hash_sha256_series_min(s)
  let mx = crypto_hash_sha256_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_sha256_series_cumsum(s : Cryptohashsha256Series) -> Cryptohashsha256Series {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_sha256_series_to_string(s : Cryptohashsha256Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha256Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha256_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha256Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha256_matrix_identity(n : Int) -> Cryptohashsha256Matrix {
  let m = crypto_hash_sha256_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_sha256_matrix_get(m : Cryptohashsha256Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_sha256_matrix_transpose(m : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  let result = crypto_hash_sha256_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_sha256_matrix_add(a : Cryptohashsha256Matrix, b : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_sha256_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_sha256_matrix_scale(m : Cryptohashsha256Matrix, s : Double) -> Cryptohashsha256Matrix {
  let result = crypto_hash_sha256_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_sha256_matrix_multiply(a : Cryptohashsha256Matrix, b : Cryptohashsha256Matrix) -> Cryptohashsha256Matrix {
  if a.cols != b.rows { return crypto_hash_sha256_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_sha256_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_sha256_matrix_trace(m : Cryptohashsha256Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_sha256_matrix_det(m : Cryptohashsha256Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_sha256_matrix_norm(m : Cryptohashsha256Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_sha256_matrix_to_string(m : Cryptohashsha256Matrix) -> String {
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

pub(all) struct Cryptohashsha256Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha256_make_vector(comps : Array[Double]) -> Cryptohashsha256Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha256_vector_zero(dim : Int) -> Cryptohashsha256Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_sha256_vector_add(a : Cryptohashsha256Vector, b : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_sha256_vector_sub(a : Cryptohashsha256Vector, b : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_sha256_vector_scale(v : Cryptohashsha256Vector, s : Double) -> Cryptohashsha256Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_sha256_vector_dot(a : Cryptohashsha256Vector, b : Cryptohashsha256Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_sha256_vector_norm(v : Cryptohashsha256Vector) -> Double { @_common.sqrt(crypto_hash_sha256_vector_dot(v, v)) }

pub fn crypto_hash_sha256_vector_normalize(v : Cryptohashsha256Vector) -> Cryptohashsha256Vector {
  let n = crypto_hash_sha256_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_sha256_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_sha256_vector_dist(a : Cryptohashsha256Vector, b : Cryptohashsha256Vector) -> Double {
  crypto_hash_sha256_vector_norm(crypto_hash_sha256_vector_sub(a, b))
}

pub fn crypto_hash_sha256_vector_to_string(v : Cryptohashsha256Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_sha256_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha256_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_hash_sha256_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha256_std(data : Array[Double]) -> Double { @_common.sqrt(crypto_hash_sha256_var(data)) }

pub fn crypto_hash_sha256_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_hash_sha256_mean(a); let mb = crypto_hash_sha256_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha256_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_hash_sha256_std(a); let sb = crypto_hash_sha256_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_hash_sha256_cov(a, b) / (sa * sb) }
}

pub fn crypto_hash_sha256_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_hash_sha256_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_hash_sha256_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_hash_sha256_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha256_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(crypto_hash_sha256_mse(pred, labels))
}

pub fn crypto_hash_sha256_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha256_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_hash_sha256_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_hash_sha256_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_hash_sha256_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_hash_sha256_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_hash_sha256_precision(pred, labels, pos); let r = crypto_hash_sha256_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_hash_sha256_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_hash_sha256_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_hash_sha256_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_hash_sha256_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_hash_sha256_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_hash_sha256_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_hash_sha256_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_hash_sha256_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_hash_sha256_fibonacci(n : Int) -> Int {
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

pub fn crypto_hash_sha256_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_hash_sha256_min(data); let mx = crypto_hash_sha256_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_hash_sha256_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_hash_sha256_mean(data); let sd = crypto_hash_sha256_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_hash_sha256_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_hash_sha256_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_hash_sha256_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_hash_sha256_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct Cryptohashsha256Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_frame_make(size : Int) -> Cryptohashsha256Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_frame_len(s : Cryptohashsha256Frame) -> Int { s.size }

pub fn crypto_hash_sha256_frame_get(s : Cryptohashsha256Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_frame_set(s : Cryptohashsha256Frame, i : Int, v : Double) -> Cryptohashsha256Frame {
  let result = crypto_hash_sha256_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_frame_sum(s : Cryptohashsha256Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_frame_mean(s : Cryptohashsha256Frame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_frame_scale(s : Cryptohashsha256Frame, f : Double) -> Cryptohashsha256Frame {
  let result = crypto_hash_sha256_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_frame_add(a : Cryptohashsha256Frame, b : Cryptohashsha256Frame) -> Cryptohashsha256Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_frame_copy(s : Cryptohashsha256Frame) -> Cryptohashsha256Frame {
  let result = crypto_hash_sha256_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_frame_fill(s : Cryptohashsha256Frame, v : Double) -> Cryptohashsha256Frame {
  let result = crypto_hash_sha256_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_frame_min(s : Cryptohashsha256Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_frame_max(s : Cryptohashsha256Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_frame_to_string(s : Cryptohashsha256Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_table_make(size : Int) -> Cryptohashsha256Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_table_len(s : Cryptohashsha256Table) -> Int { s.size }

pub fn crypto_hash_sha256_table_get(s : Cryptohashsha256Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_table_set(s : Cryptohashsha256Table, i : Int, v : Double) -> Cryptohashsha256Table {
  let result = crypto_hash_sha256_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_table_sum(s : Cryptohashsha256Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_table_mean(s : Cryptohashsha256Table) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_table_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_table_scale(s : Cryptohashsha256Table, f : Double) -> Cryptohashsha256Table {
  let result = crypto_hash_sha256_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_table_add(a : Cryptohashsha256Table, b : Cryptohashsha256Table) -> Cryptohashsha256Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_table_copy(s : Cryptohashsha256Table) -> Cryptohashsha256Table {
  let result = crypto_hash_sha256_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_table_fill(s : Cryptohashsha256Table, v : Double) -> Cryptohashsha256Table {
  let result = crypto_hash_sha256_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_table_min(s : Cryptohashsha256Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_table_max(s : Cryptohashsha256Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_table_to_string(s : Cryptohashsha256Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_graphn_make(size : Int) -> Cryptohashsha256GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_graphn_len(s : Cryptohashsha256GraphN) -> Int { s.size }

pub fn crypto_hash_sha256_graphn_get(s : Cryptohashsha256GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_graphn_set(s : Cryptohashsha256GraphN, i : Int, v : Double) -> Cryptohashsha256GraphN {
  let result = crypto_hash_sha256_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_graphn_sum(s : Cryptohashsha256GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_graphn_mean(s : Cryptohashsha256GraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_graphn_scale(s : Cryptohashsha256GraphN, f : Double) -> Cryptohashsha256GraphN {
  let result = crypto_hash_sha256_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_graphn_add(a : Cryptohashsha256GraphN, b : Cryptohashsha256GraphN) -> Cryptohashsha256GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_graphn_copy(s : Cryptohashsha256GraphN) -> Cryptohashsha256GraphN {
  let result = crypto_hash_sha256_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_graphn_fill(s : Cryptohashsha256GraphN, v : Double) -> Cryptohashsha256GraphN {
  let result = crypto_hash_sha256_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_graphn_min(s : Cryptohashsha256GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_graphn_max(s : Cryptohashsha256GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_graphn_to_string(s : Cryptohashsha256GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_node_make(size : Int) -> Cryptohashsha256Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_node_len(s : Cryptohashsha256Node) -> Int { s.size }

pub fn crypto_hash_sha256_node_get(s : Cryptohashsha256Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_node_set(s : Cryptohashsha256Node, i : Int, v : Double) -> Cryptohashsha256Node {
  let result = crypto_hash_sha256_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_node_sum(s : Cryptohashsha256Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_node_mean(s : Cryptohashsha256Node) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_node_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_node_scale(s : Cryptohashsha256Node, f : Double) -> Cryptohashsha256Node {
  let result = crypto_hash_sha256_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_node_add(a : Cryptohashsha256Node, b : Cryptohashsha256Node) -> Cryptohashsha256Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_node_copy(s : Cryptohashsha256Node) -> Cryptohashsha256Node {
  let result = crypto_hash_sha256_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_node_fill(s : Cryptohashsha256Node, v : Double) -> Cryptohashsha256Node {
  let result = crypto_hash_sha256_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_node_min(s : Cryptohashsha256Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_node_max(s : Cryptohashsha256Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_node_to_string(s : Cryptohashsha256Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_edge_make(size : Int) -> Cryptohashsha256Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_edge_len(s : Cryptohashsha256Edge) -> Int { s.size }

pub fn crypto_hash_sha256_edge_get(s : Cryptohashsha256Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_edge_set(s : Cryptohashsha256Edge, i : Int, v : Double) -> Cryptohashsha256Edge {
  let result = crypto_hash_sha256_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_edge_sum(s : Cryptohashsha256Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_edge_mean(s : Cryptohashsha256Edge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_edge_scale(s : Cryptohashsha256Edge, f : Double) -> Cryptohashsha256Edge {
  let result = crypto_hash_sha256_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_edge_add(a : Cryptohashsha256Edge, b : Cryptohashsha256Edge) -> Cryptohashsha256Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_edge_copy(s : Cryptohashsha256Edge) -> Cryptohashsha256Edge {
  let result = crypto_hash_sha256_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_edge_fill(s : Cryptohashsha256Edge, v : Double) -> Cryptohashsha256Edge {
  let result = crypto_hash_sha256_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_edge_min(s : Cryptohashsha256Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_edge_max(s : Cryptohashsha256Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_edge_to_string(s : Cryptohashsha256Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_path_make(size : Int) -> Cryptohashsha256Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_path_len(s : Cryptohashsha256Path) -> Int { s.size }

pub fn crypto_hash_sha256_path_get(s : Cryptohashsha256Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_path_set(s : Cryptohashsha256Path, i : Int, v : Double) -> Cryptohashsha256Path {
  let result = crypto_hash_sha256_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_path_sum(s : Cryptohashsha256Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_path_mean(s : Cryptohashsha256Path) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_path_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_path_scale(s : Cryptohashsha256Path, f : Double) -> Cryptohashsha256Path {
  let result = crypto_hash_sha256_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_path_add(a : Cryptohashsha256Path, b : Cryptohashsha256Path) -> Cryptohashsha256Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_path_copy(s : Cryptohashsha256Path) -> Cryptohashsha256Path {
  let result = crypto_hash_sha256_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_path_fill(s : Cryptohashsha256Path, v : Double) -> Cryptohashsha256Path {
  let result = crypto_hash_sha256_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_path_min(s : Cryptohashsha256Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_path_max(s : Cryptohashsha256Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_path_to_string(s : Cryptohashsha256Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_cluster_make(size : Int) -> Cryptohashsha256Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_cluster_len(s : Cryptohashsha256Cluster) -> Int { s.size }

pub fn crypto_hash_sha256_cluster_get(s : Cryptohashsha256Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_cluster_set(s : Cryptohashsha256Cluster, i : Int, v : Double) -> Cryptohashsha256Cluster {
  let result = crypto_hash_sha256_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_cluster_sum(s : Cryptohashsha256Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_cluster_mean(s : Cryptohashsha256Cluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_cluster_scale(s : Cryptohashsha256Cluster, f : Double) -> Cryptohashsha256Cluster {
  let result = crypto_hash_sha256_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_cluster_add(a : Cryptohashsha256Cluster, b : Cryptohashsha256Cluster) -> Cryptohashsha256Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_cluster_copy(s : Cryptohashsha256Cluster) -> Cryptohashsha256Cluster {
  let result = crypto_hash_sha256_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_cluster_fill(s : Cryptohashsha256Cluster, v : Double) -> Cryptohashsha256Cluster {
  let result = crypto_hash_sha256_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_cluster_min(s : Cryptohashsha256Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_cluster_max(s : Cryptohashsha256Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_cluster_to_string(s : Cryptohashsha256Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_model_make(size : Int) -> Cryptohashsha256Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_model_len(s : Cryptohashsha256Model) -> Int { s.size }

pub fn crypto_hash_sha256_model_get(s : Cryptohashsha256Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_model_set(s : Cryptohashsha256Model, i : Int, v : Double) -> Cryptohashsha256Model {
  let result = crypto_hash_sha256_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_model_sum(s : Cryptohashsha256Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_model_mean(s : Cryptohashsha256Model) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_model_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_model_scale(s : Cryptohashsha256Model, f : Double) -> Cryptohashsha256Model {
  let result = crypto_hash_sha256_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_model_add(a : Cryptohashsha256Model, b : Cryptohashsha256Model) -> Cryptohashsha256Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_model_copy(s : Cryptohashsha256Model) -> Cryptohashsha256Model {
  let result = crypto_hash_sha256_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_model_fill(s : Cryptohashsha256Model, v : Double) -> Cryptohashsha256Model {
  let result = crypto_hash_sha256_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_model_min(s : Cryptohashsha256Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_model_max(s : Cryptohashsha256Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_model_to_string(s : Cryptohashsha256Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_layer_make(size : Int) -> Cryptohashsha256Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_layer_len(s : Cryptohashsha256Layer) -> Int { s.size }

pub fn crypto_hash_sha256_layer_get(s : Cryptohashsha256Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_layer_set(s : Cryptohashsha256Layer, i : Int, v : Double) -> Cryptohashsha256Layer {
  let result = crypto_hash_sha256_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_layer_sum(s : Cryptohashsha256Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_layer_mean(s : Cryptohashsha256Layer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_layer_scale(s : Cryptohashsha256Layer, f : Double) -> Cryptohashsha256Layer {
  let result = crypto_hash_sha256_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_layer_add(a : Cryptohashsha256Layer, b : Cryptohashsha256Layer) -> Cryptohashsha256Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_layer_copy(s : Cryptohashsha256Layer) -> Cryptohashsha256Layer {
  let result = crypto_hash_sha256_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_layer_fill(s : Cryptohashsha256Layer, v : Double) -> Cryptohashsha256Layer {
  let result = crypto_hash_sha256_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_layer_min(s : Cryptohashsha256Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_layer_max(s : Cryptohashsha256Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_layer_to_string(s : Cryptohashsha256Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_buffer_make(size : Int) -> Cryptohashsha256Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_buffer_len(s : Cryptohashsha256Buffer) -> Int { s.size }

pub fn crypto_hash_sha256_buffer_get(s : Cryptohashsha256Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_buffer_set(s : Cryptohashsha256Buffer, i : Int, v : Double) -> Cryptohashsha256Buffer {
  let result = crypto_hash_sha256_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_buffer_sum(s : Cryptohashsha256Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_buffer_mean(s : Cryptohashsha256Buffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_buffer_scale(s : Cryptohashsha256Buffer, f : Double) -> Cryptohashsha256Buffer {
  let result = crypto_hash_sha256_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_buffer_add(a : Cryptohashsha256Buffer, b : Cryptohashsha256Buffer) -> Cryptohashsha256Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_buffer_copy(s : Cryptohashsha256Buffer) -> Cryptohashsha256Buffer {
  let result = crypto_hash_sha256_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_buffer_fill(s : Cryptohashsha256Buffer, v : Double) -> Cryptohashsha256Buffer {
  let result = crypto_hash_sha256_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_buffer_min(s : Cryptohashsha256Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_buffer_max(s : Cryptohashsha256Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_buffer_to_string(s : Cryptohashsha256Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_cursor_make(size : Int) -> Cryptohashsha256Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_cursor_len(s : Cryptohashsha256Cursor) -> Int { s.size }

pub fn crypto_hash_sha256_cursor_get(s : Cryptohashsha256Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_cursor_set(s : Cryptohashsha256Cursor, i : Int, v : Double) -> Cryptohashsha256Cursor {
  let result = crypto_hash_sha256_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_cursor_sum(s : Cryptohashsha256Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_cursor_mean(s : Cryptohashsha256Cursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_cursor_scale(s : Cryptohashsha256Cursor, f : Double) -> Cryptohashsha256Cursor {
  let result = crypto_hash_sha256_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_cursor_add(a : Cryptohashsha256Cursor, b : Cryptohashsha256Cursor) -> Cryptohashsha256Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_cursor_copy(s : Cryptohashsha256Cursor) -> Cryptohashsha256Cursor {
  let result = crypto_hash_sha256_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_cursor_fill(s : Cryptohashsha256Cursor, v : Double) -> Cryptohashsha256Cursor {
  let result = crypto_hash_sha256_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_cursor_min(s : Cryptohashsha256Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_cursor_max(s : Cryptohashsha256Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_cursor_to_string(s : Cryptohashsha256Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_view_make(size : Int) -> Cryptohashsha256View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_view_len(s : Cryptohashsha256View) -> Int { s.size }

pub fn crypto_hash_sha256_view_get(s : Cryptohashsha256View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_view_set(s : Cryptohashsha256View, i : Int, v : Double) -> Cryptohashsha256View {
  let result = crypto_hash_sha256_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_view_sum(s : Cryptohashsha256View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_view_mean(s : Cryptohashsha256View) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_view_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_view_scale(s : Cryptohashsha256View, f : Double) -> Cryptohashsha256View {
  let result = crypto_hash_sha256_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_view_add(a : Cryptohashsha256View, b : Cryptohashsha256View) -> Cryptohashsha256View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_view_copy(s : Cryptohashsha256View) -> Cryptohashsha256View {
  let result = crypto_hash_sha256_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_view_fill(s : Cryptohashsha256View, v : Double) -> Cryptohashsha256View {
  let result = crypto_hash_sha256_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_view_min(s : Cryptohashsha256View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_view_max(s : Cryptohashsha256View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_view_to_string(s : Cryptohashsha256View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_range_make(size : Int) -> Cryptohashsha256Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_range_len(s : Cryptohashsha256Range) -> Int { s.size }

pub fn crypto_hash_sha256_range_get(s : Cryptohashsha256Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_range_set(s : Cryptohashsha256Range, i : Int, v : Double) -> Cryptohashsha256Range {
  let result = crypto_hash_sha256_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_range_sum(s : Cryptohashsha256Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_range_mean(s : Cryptohashsha256Range) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_range_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_range_scale(s : Cryptohashsha256Range, f : Double) -> Cryptohashsha256Range {
  let result = crypto_hash_sha256_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_range_add(a : Cryptohashsha256Range, b : Cryptohashsha256Range) -> Cryptohashsha256Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_range_copy(s : Cryptohashsha256Range) -> Cryptohashsha256Range {
  let result = crypto_hash_sha256_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_range_fill(s : Cryptohashsha256Range, v : Double) -> Cryptohashsha256Range {
  let result = crypto_hash_sha256_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_range_min(s : Cryptohashsha256Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_range_max(s : Cryptohashsha256Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_range_to_string(s : Cryptohashsha256Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha256Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha256_slice_make(size : Int) -> Cryptohashsha256Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha256_slice_len(s : Cryptohashsha256Slice) -> Int { s.size }

pub fn crypto_hash_sha256_slice_get(s : Cryptohashsha256Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha256_slice_set(s : Cryptohashsha256Slice, i : Int, v : Double) -> Cryptohashsha256Slice {
  let result = crypto_hash_sha256_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_slice_sum(s : Cryptohashsha256Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha256_slice_mean(s : Cryptohashsha256Slice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha256_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha256_slice_scale(s : Cryptohashsha256Slice, f : Double) -> Cryptohashsha256Slice {
  let result = crypto_hash_sha256_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha256_slice_add(a : Cryptohashsha256Slice, b : Cryptohashsha256Slice) -> Cryptohashsha256Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha256_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha256_slice_copy(s : Cryptohashsha256Slice) -> Cryptohashsha256Slice {
  let result = crypto_hash_sha256_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha256_slice_fill(s : Cryptohashsha256Slice, v : Double) -> Cryptohashsha256Slice {
  let result = crypto_hash_sha256_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha256_slice_min(s : Cryptohashsha256Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_slice_max(s : Cryptohashsha256Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha256_slice_to_string(s : Cryptohashsha256Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

