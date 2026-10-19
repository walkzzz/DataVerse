///===
/// extcore/crypto_hash_sha3

pub(all) struct Cryptohashsha3Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha3_make_point(x : Double, y : Double) -> Cryptohashsha3Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha3_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha3Point {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_sha3_point_x(pt : Cryptohashsha3Point) -> Double { pt.x }

pub fn crypto_hash_sha3_point_y(pt : Cryptohashsha3Point) -> Double { pt.y }

pub fn crypto_hash_sha3_point_z(pt : Cryptohashsha3Point) -> Double { pt.z }

pub fn crypto_hash_sha3_point_label(pt : Cryptohashsha3Point) -> Int { pt.label }

pub fn crypto_hash_sha3_point_dist(a : Cryptohashsha3Point, b : Cryptohashsha3Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_sha3_point_add(a : Cryptohashsha3Point, b : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_sha3_point_sub(a : Cryptohashsha3Point, b : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_sha3_point_scale(pt : Cryptohashsha3Point, s : Double) -> Cryptohashsha3Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_sha3_point_dot(a : Cryptohashsha3Point, b : Cryptohashsha3Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_sha3_point_cross(a : Cryptohashsha3Point, b : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_sha3_point_norm(pt : Cryptohashsha3Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_sha3_point_normalize(pt : Cryptohashsha3Point) -> Cryptohashsha3Point {
  let n = crypto_hash_sha3_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_sha3_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_sha3_point_negate(pt : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_sha3_point_mid(a : Cryptohashsha3Point, b : Cryptohashsha3Point) -> Cryptohashsha3Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_sha3_point_lerp(a : Cryptohashsha3Point, b : Cryptohashsha3Point, t : Double) -> Cryptohashsha3Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_sha3_point_to_string(pt : Cryptohashsha3Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptohashsha3Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha3_make_series(vals : Array[Double], name : String) -> Cryptohashsha3Series {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_sha3_series_len(s : Cryptohashsha3Series) -> Int { s.vals.length() }

pub fn crypto_hash_sha3_series_sum(s : Cryptohashsha3Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_hash_sha3_series_mean(s : Cryptohashsha3Series) -> Double {
  let n = crypto_hash_sha3_series_len(s)
  if n == 0 { 0.0 } else { crypto_hash_sha3_series_sum(s) / n.to_double() }
}

pub fn crypto_hash_sha3_series_min(s : Cryptohashsha3Series) -> Double {
  let n = crypto_hash_sha3_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_hash_sha3_series_max(s : Cryptohashsha3Series) -> Double {
  let n = crypto_hash_sha3_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_hash_sha3_series_range(s : Cryptohashsha3Series) -> Double {
  crypto_hash_sha3_series_max(s) - crypto_hash_sha3_series_min(s)
}

pub fn crypto_hash_sha3_series_var(s : Cryptohashsha3Series) -> Double {
  let n = crypto_hash_sha3_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_hash_sha3_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_hash_sha3_series_std(s : Cryptohashsha3Series) -> Double { @_common.sqrt(crypto_hash_sha3_series_var(s)) }

pub fn crypto_hash_sha3_series_median(s : Cryptohashsha3Series) -> Double {
  let n = crypto_hash_sha3_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_hash_sha3_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_hash_sha3_series_scale(s : Cryptohashsha3Series, f : Double) -> Cryptohashsha3Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_sha3_series_add(a : Cryptohashsha3Series, b : Cryptohashsha3Series) -> Cryptohashsha3Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_sha3_series_sub(a : Cryptohashsha3Series, b : Cryptohashsha3Series) -> Cryptohashsha3Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_sha3_series_normalize(s : Cryptohashsha3Series) -> Cryptohashsha3Series {
  let mn = crypto_hash_sha3_series_min(s)
  let mx = crypto_hash_sha3_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_sha3_series_cumsum(s : Cryptohashsha3Series) -> Cryptohashsha3Series {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_sha3_series_to_string(s : Cryptohashsha3Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha3Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha3_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha3Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha3_matrix_identity(n : Int) -> Cryptohashsha3Matrix {
  let m = crypto_hash_sha3_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_sha3_matrix_get(m : Cryptohashsha3Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_sha3_matrix_transpose(m : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  let result = crypto_hash_sha3_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_sha3_matrix_add(a : Cryptohashsha3Matrix, b : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_sha3_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_sha3_matrix_scale(m : Cryptohashsha3Matrix, s : Double) -> Cryptohashsha3Matrix {
  let result = crypto_hash_sha3_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_sha3_matrix_multiply(a : Cryptohashsha3Matrix, b : Cryptohashsha3Matrix) -> Cryptohashsha3Matrix {
  if a.cols != b.rows { return crypto_hash_sha3_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_sha3_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_sha3_matrix_trace(m : Cryptohashsha3Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_sha3_matrix_det(m : Cryptohashsha3Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_sha3_matrix_norm(m : Cryptohashsha3Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_sha3_matrix_to_string(m : Cryptohashsha3Matrix) -> String {
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

pub(all) struct Cryptohashsha3Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha3_make_vector(comps : Array[Double]) -> Cryptohashsha3Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha3_vector_zero(dim : Int) -> Cryptohashsha3Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_sha3_vector_add(a : Cryptohashsha3Vector, b : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_sha3_vector_sub(a : Cryptohashsha3Vector, b : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_sha3_vector_scale(v : Cryptohashsha3Vector, s : Double) -> Cryptohashsha3Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_sha3_vector_dot(a : Cryptohashsha3Vector, b : Cryptohashsha3Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_sha3_vector_norm(v : Cryptohashsha3Vector) -> Double { @_common.sqrt(crypto_hash_sha3_vector_dot(v, v)) }

pub fn crypto_hash_sha3_vector_normalize(v : Cryptohashsha3Vector) -> Cryptohashsha3Vector {
  let n = crypto_hash_sha3_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_sha3_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_sha3_vector_dist(a : Cryptohashsha3Vector, b : Cryptohashsha3Vector) -> Double {
  crypto_hash_sha3_vector_norm(crypto_hash_sha3_vector_sub(a, b))
}

pub fn crypto_hash_sha3_vector_to_string(v : Cryptohashsha3Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_sha3_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha3_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = crypto_hash_sha3_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha3_std(data : Array[Double]) -> Double { @_common.sqrt(crypto_hash_sha3_var(data)) }

pub fn crypto_hash_sha3_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = crypto_hash_sha3_mean(a); let mb = crypto_hash_sha3_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha3_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = crypto_hash_sha3_std(a); let sb = crypto_hash_sha3_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { crypto_hash_sha3_cov(a, b) / (sa * sb) }
}

pub fn crypto_hash_sha3_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = crypto_hash_sha3_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_hash_sha3_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn crypto_hash_sha3_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha3_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(crypto_hash_sha3_mse(pred, labels))
}

pub fn crypto_hash_sha3_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn crypto_hash_sha3_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = crypto_hash_sha3_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn crypto_hash_sha3_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn crypto_hash_sha3_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn crypto_hash_sha3_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = crypto_hash_sha3_precision(pred, labels, pos); let r = crypto_hash_sha3_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn crypto_hash_sha3_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn crypto_hash_sha3_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = crypto_hash_sha3_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn crypto_hash_sha3_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn crypto_hash_sha3_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn crypto_hash_sha3_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = crypto_hash_sha3_gcd(a, b)
    (a / g) * b
  }
}

pub fn crypto_hash_sha3_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn crypto_hash_sha3_fibonacci(n : Int) -> Int {
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

pub fn crypto_hash_sha3_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = crypto_hash_sha3_min(data); let mx = crypto_hash_sha3_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn crypto_hash_sha3_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = crypto_hash_sha3_mean(data); let sd = crypto_hash_sha3_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn crypto_hash_sha3_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn crypto_hash_sha3_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn crypto_hash_sha3_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn crypto_hash_sha3_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct Cryptohashsha3Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_frame_make(size : Int) -> Cryptohashsha3Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_frame_len(s : Cryptohashsha3Frame) -> Int { s.size }

pub fn crypto_hash_sha3_frame_get(s : Cryptohashsha3Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_frame_set(s : Cryptohashsha3Frame, i : Int, v : Double) -> Cryptohashsha3Frame {
  let result = crypto_hash_sha3_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_frame_sum(s : Cryptohashsha3Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_frame_mean(s : Cryptohashsha3Frame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_frame_scale(s : Cryptohashsha3Frame, f : Double) -> Cryptohashsha3Frame {
  let result = crypto_hash_sha3_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_frame_add(a : Cryptohashsha3Frame, b : Cryptohashsha3Frame) -> Cryptohashsha3Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_frame_copy(s : Cryptohashsha3Frame) -> Cryptohashsha3Frame {
  let result = crypto_hash_sha3_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_frame_fill(s : Cryptohashsha3Frame, v : Double) -> Cryptohashsha3Frame {
  let result = crypto_hash_sha3_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_frame_min(s : Cryptohashsha3Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_frame_max(s : Cryptohashsha3Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_frame_to_string(s : Cryptohashsha3Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_table_make(size : Int) -> Cryptohashsha3Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_table_len(s : Cryptohashsha3Table) -> Int { s.size }

pub fn crypto_hash_sha3_table_get(s : Cryptohashsha3Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_table_set(s : Cryptohashsha3Table, i : Int, v : Double) -> Cryptohashsha3Table {
  let result = crypto_hash_sha3_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_table_sum(s : Cryptohashsha3Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_table_mean(s : Cryptohashsha3Table) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_table_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_table_scale(s : Cryptohashsha3Table, f : Double) -> Cryptohashsha3Table {
  let result = crypto_hash_sha3_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_table_add(a : Cryptohashsha3Table, b : Cryptohashsha3Table) -> Cryptohashsha3Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_table_copy(s : Cryptohashsha3Table) -> Cryptohashsha3Table {
  let result = crypto_hash_sha3_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_table_fill(s : Cryptohashsha3Table, v : Double) -> Cryptohashsha3Table {
  let result = crypto_hash_sha3_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_table_min(s : Cryptohashsha3Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_table_max(s : Cryptohashsha3Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_table_to_string(s : Cryptohashsha3Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_graphn_make(size : Int) -> Cryptohashsha3GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_graphn_len(s : Cryptohashsha3GraphN) -> Int { s.size }

pub fn crypto_hash_sha3_graphn_get(s : Cryptohashsha3GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_graphn_set(s : Cryptohashsha3GraphN, i : Int, v : Double) -> Cryptohashsha3GraphN {
  let result = crypto_hash_sha3_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_graphn_sum(s : Cryptohashsha3GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_graphn_mean(s : Cryptohashsha3GraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_graphn_scale(s : Cryptohashsha3GraphN, f : Double) -> Cryptohashsha3GraphN {
  let result = crypto_hash_sha3_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_graphn_add(a : Cryptohashsha3GraphN, b : Cryptohashsha3GraphN) -> Cryptohashsha3GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_graphn_copy(s : Cryptohashsha3GraphN) -> Cryptohashsha3GraphN {
  let result = crypto_hash_sha3_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_graphn_fill(s : Cryptohashsha3GraphN, v : Double) -> Cryptohashsha3GraphN {
  let result = crypto_hash_sha3_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_graphn_min(s : Cryptohashsha3GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_graphn_max(s : Cryptohashsha3GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_graphn_to_string(s : Cryptohashsha3GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_node_make(size : Int) -> Cryptohashsha3Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_node_len(s : Cryptohashsha3Node) -> Int { s.size }

pub fn crypto_hash_sha3_node_get(s : Cryptohashsha3Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_node_set(s : Cryptohashsha3Node, i : Int, v : Double) -> Cryptohashsha3Node {
  let result = crypto_hash_sha3_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_node_sum(s : Cryptohashsha3Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_node_mean(s : Cryptohashsha3Node) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_node_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_node_scale(s : Cryptohashsha3Node, f : Double) -> Cryptohashsha3Node {
  let result = crypto_hash_sha3_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_node_add(a : Cryptohashsha3Node, b : Cryptohashsha3Node) -> Cryptohashsha3Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_node_copy(s : Cryptohashsha3Node) -> Cryptohashsha3Node {
  let result = crypto_hash_sha3_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_node_fill(s : Cryptohashsha3Node, v : Double) -> Cryptohashsha3Node {
  let result = crypto_hash_sha3_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_node_min(s : Cryptohashsha3Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_node_max(s : Cryptohashsha3Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_node_to_string(s : Cryptohashsha3Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_edge_make(size : Int) -> Cryptohashsha3Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_edge_len(s : Cryptohashsha3Edge) -> Int { s.size }

pub fn crypto_hash_sha3_edge_get(s : Cryptohashsha3Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_edge_set(s : Cryptohashsha3Edge, i : Int, v : Double) -> Cryptohashsha3Edge {
  let result = crypto_hash_sha3_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_edge_sum(s : Cryptohashsha3Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_edge_mean(s : Cryptohashsha3Edge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_edge_scale(s : Cryptohashsha3Edge, f : Double) -> Cryptohashsha3Edge {
  let result = crypto_hash_sha3_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_edge_add(a : Cryptohashsha3Edge, b : Cryptohashsha3Edge) -> Cryptohashsha3Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_edge_copy(s : Cryptohashsha3Edge) -> Cryptohashsha3Edge {
  let result = crypto_hash_sha3_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_edge_fill(s : Cryptohashsha3Edge, v : Double) -> Cryptohashsha3Edge {
  let result = crypto_hash_sha3_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_edge_min(s : Cryptohashsha3Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_edge_max(s : Cryptohashsha3Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_edge_to_string(s : Cryptohashsha3Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_path_make(size : Int) -> Cryptohashsha3Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_path_len(s : Cryptohashsha3Path) -> Int { s.size }

pub fn crypto_hash_sha3_path_get(s : Cryptohashsha3Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_path_set(s : Cryptohashsha3Path, i : Int, v : Double) -> Cryptohashsha3Path {
  let result = crypto_hash_sha3_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_path_sum(s : Cryptohashsha3Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_path_mean(s : Cryptohashsha3Path) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_path_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_path_scale(s : Cryptohashsha3Path, f : Double) -> Cryptohashsha3Path {
  let result = crypto_hash_sha3_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_path_add(a : Cryptohashsha3Path, b : Cryptohashsha3Path) -> Cryptohashsha3Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_path_copy(s : Cryptohashsha3Path) -> Cryptohashsha3Path {
  let result = crypto_hash_sha3_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_path_fill(s : Cryptohashsha3Path, v : Double) -> Cryptohashsha3Path {
  let result = crypto_hash_sha3_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_path_min(s : Cryptohashsha3Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_path_max(s : Cryptohashsha3Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_path_to_string(s : Cryptohashsha3Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_cluster_make(size : Int) -> Cryptohashsha3Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_cluster_len(s : Cryptohashsha3Cluster) -> Int { s.size }

pub fn crypto_hash_sha3_cluster_get(s : Cryptohashsha3Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_cluster_set(s : Cryptohashsha3Cluster, i : Int, v : Double) -> Cryptohashsha3Cluster {
  let result = crypto_hash_sha3_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_cluster_sum(s : Cryptohashsha3Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_cluster_mean(s : Cryptohashsha3Cluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_cluster_scale(s : Cryptohashsha3Cluster, f : Double) -> Cryptohashsha3Cluster {
  let result = crypto_hash_sha3_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_cluster_add(a : Cryptohashsha3Cluster, b : Cryptohashsha3Cluster) -> Cryptohashsha3Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_cluster_copy(s : Cryptohashsha3Cluster) -> Cryptohashsha3Cluster {
  let result = crypto_hash_sha3_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_cluster_fill(s : Cryptohashsha3Cluster, v : Double) -> Cryptohashsha3Cluster {
  let result = crypto_hash_sha3_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_cluster_min(s : Cryptohashsha3Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_cluster_max(s : Cryptohashsha3Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_cluster_to_string(s : Cryptohashsha3Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_model_make(size : Int) -> Cryptohashsha3Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_model_len(s : Cryptohashsha3Model) -> Int { s.size }

pub fn crypto_hash_sha3_model_get(s : Cryptohashsha3Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_model_set(s : Cryptohashsha3Model, i : Int, v : Double) -> Cryptohashsha3Model {
  let result = crypto_hash_sha3_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_model_sum(s : Cryptohashsha3Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_model_mean(s : Cryptohashsha3Model) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_model_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_model_scale(s : Cryptohashsha3Model, f : Double) -> Cryptohashsha3Model {
  let result = crypto_hash_sha3_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_model_add(a : Cryptohashsha3Model, b : Cryptohashsha3Model) -> Cryptohashsha3Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_model_copy(s : Cryptohashsha3Model) -> Cryptohashsha3Model {
  let result = crypto_hash_sha3_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_model_fill(s : Cryptohashsha3Model, v : Double) -> Cryptohashsha3Model {
  let result = crypto_hash_sha3_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_model_min(s : Cryptohashsha3Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_model_max(s : Cryptohashsha3Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_model_to_string(s : Cryptohashsha3Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_layer_make(size : Int) -> Cryptohashsha3Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_layer_len(s : Cryptohashsha3Layer) -> Int { s.size }

pub fn crypto_hash_sha3_layer_get(s : Cryptohashsha3Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_layer_set(s : Cryptohashsha3Layer, i : Int, v : Double) -> Cryptohashsha3Layer {
  let result = crypto_hash_sha3_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_layer_sum(s : Cryptohashsha3Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_layer_mean(s : Cryptohashsha3Layer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_layer_scale(s : Cryptohashsha3Layer, f : Double) -> Cryptohashsha3Layer {
  let result = crypto_hash_sha3_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_layer_add(a : Cryptohashsha3Layer, b : Cryptohashsha3Layer) -> Cryptohashsha3Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_layer_copy(s : Cryptohashsha3Layer) -> Cryptohashsha3Layer {
  let result = crypto_hash_sha3_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_layer_fill(s : Cryptohashsha3Layer, v : Double) -> Cryptohashsha3Layer {
  let result = crypto_hash_sha3_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_layer_min(s : Cryptohashsha3Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_layer_max(s : Cryptohashsha3Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_layer_to_string(s : Cryptohashsha3Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_buffer_make(size : Int) -> Cryptohashsha3Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_buffer_len(s : Cryptohashsha3Buffer) -> Int { s.size }

pub fn crypto_hash_sha3_buffer_get(s : Cryptohashsha3Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_buffer_set(s : Cryptohashsha3Buffer, i : Int, v : Double) -> Cryptohashsha3Buffer {
  let result = crypto_hash_sha3_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_buffer_sum(s : Cryptohashsha3Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_buffer_mean(s : Cryptohashsha3Buffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_buffer_scale(s : Cryptohashsha3Buffer, f : Double) -> Cryptohashsha3Buffer {
  let result = crypto_hash_sha3_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_buffer_add(a : Cryptohashsha3Buffer, b : Cryptohashsha3Buffer) -> Cryptohashsha3Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_buffer_copy(s : Cryptohashsha3Buffer) -> Cryptohashsha3Buffer {
  let result = crypto_hash_sha3_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_buffer_fill(s : Cryptohashsha3Buffer, v : Double) -> Cryptohashsha3Buffer {
  let result = crypto_hash_sha3_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_buffer_min(s : Cryptohashsha3Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_buffer_max(s : Cryptohashsha3Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_buffer_to_string(s : Cryptohashsha3Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_cursor_make(size : Int) -> Cryptohashsha3Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_cursor_len(s : Cryptohashsha3Cursor) -> Int { s.size }

pub fn crypto_hash_sha3_cursor_get(s : Cryptohashsha3Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_cursor_set(s : Cryptohashsha3Cursor, i : Int, v : Double) -> Cryptohashsha3Cursor {
  let result = crypto_hash_sha3_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_cursor_sum(s : Cryptohashsha3Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_cursor_mean(s : Cryptohashsha3Cursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_cursor_scale(s : Cryptohashsha3Cursor, f : Double) -> Cryptohashsha3Cursor {
  let result = crypto_hash_sha3_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_cursor_add(a : Cryptohashsha3Cursor, b : Cryptohashsha3Cursor) -> Cryptohashsha3Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_cursor_copy(s : Cryptohashsha3Cursor) -> Cryptohashsha3Cursor {
  let result = crypto_hash_sha3_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_cursor_fill(s : Cryptohashsha3Cursor, v : Double) -> Cryptohashsha3Cursor {
  let result = crypto_hash_sha3_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_cursor_min(s : Cryptohashsha3Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_cursor_max(s : Cryptohashsha3Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_cursor_to_string(s : Cryptohashsha3Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_view_make(size : Int) -> Cryptohashsha3View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_view_len(s : Cryptohashsha3View) -> Int { s.size }

pub fn crypto_hash_sha3_view_get(s : Cryptohashsha3View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_view_set(s : Cryptohashsha3View, i : Int, v : Double) -> Cryptohashsha3View {
  let result = crypto_hash_sha3_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_view_sum(s : Cryptohashsha3View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_view_mean(s : Cryptohashsha3View) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_view_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_view_scale(s : Cryptohashsha3View, f : Double) -> Cryptohashsha3View {
  let result = crypto_hash_sha3_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_view_add(a : Cryptohashsha3View, b : Cryptohashsha3View) -> Cryptohashsha3View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_view_copy(s : Cryptohashsha3View) -> Cryptohashsha3View {
  let result = crypto_hash_sha3_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_view_fill(s : Cryptohashsha3View, v : Double) -> Cryptohashsha3View {
  let result = crypto_hash_sha3_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_view_min(s : Cryptohashsha3View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_view_max(s : Cryptohashsha3View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_view_to_string(s : Cryptohashsha3View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_range_make(size : Int) -> Cryptohashsha3Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_range_len(s : Cryptohashsha3Range) -> Int { s.size }

pub fn crypto_hash_sha3_range_get(s : Cryptohashsha3Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_range_set(s : Cryptohashsha3Range, i : Int, v : Double) -> Cryptohashsha3Range {
  let result = crypto_hash_sha3_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_range_sum(s : Cryptohashsha3Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_range_mean(s : Cryptohashsha3Range) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_range_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_range_scale(s : Cryptohashsha3Range, f : Double) -> Cryptohashsha3Range {
  let result = crypto_hash_sha3_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_range_add(a : Cryptohashsha3Range, b : Cryptohashsha3Range) -> Cryptohashsha3Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_range_copy(s : Cryptohashsha3Range) -> Cryptohashsha3Range {
  let result = crypto_hash_sha3_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_range_fill(s : Cryptohashsha3Range, v : Double) -> Cryptohashsha3Range {
  let result = crypto_hash_sha3_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_range_min(s : Cryptohashsha3Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_range_max(s : Cryptohashsha3Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_range_to_string(s : Cryptohashsha3Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha3Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha3_slice_make(size : Int) -> Cryptohashsha3Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha3_slice_len(s : Cryptohashsha3Slice) -> Int { s.size }

pub fn crypto_hash_sha3_slice_get(s : Cryptohashsha3Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha3_slice_set(s : Cryptohashsha3Slice, i : Int, v : Double) -> Cryptohashsha3Slice {
  let result = crypto_hash_sha3_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_slice_sum(s : Cryptohashsha3Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha3_slice_mean(s : Cryptohashsha3Slice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha3_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha3_slice_scale(s : Cryptohashsha3Slice, f : Double) -> Cryptohashsha3Slice {
  let result = crypto_hash_sha3_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha3_slice_add(a : Cryptohashsha3Slice, b : Cryptohashsha3Slice) -> Cryptohashsha3Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha3_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha3_slice_copy(s : Cryptohashsha3Slice) -> Cryptohashsha3Slice {
  let result = crypto_hash_sha3_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha3_slice_fill(s : Cryptohashsha3Slice, v : Double) -> Cryptohashsha3Slice {
  let result = crypto_hash_sha3_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha3_slice_min(s : Cryptohashsha3Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_slice_max(s : Cryptohashsha3Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha3_slice_to_string(s : Cryptohashsha3Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

