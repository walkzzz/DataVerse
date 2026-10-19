///===
/// extcore/crypto_hash_sha512

pub(all) struct Cryptohashsha512Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha512_make_point(x : Double, y : Double) -> Cryptohashsha512Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha512_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha512Point {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_sha512_point_x(pt : Cryptohashsha512Point) -> Double { pt.x }

pub fn crypto_hash_sha512_point_y(pt : Cryptohashsha512Point) -> Double { pt.y }

pub fn crypto_hash_sha512_point_z(pt : Cryptohashsha512Point) -> Double { pt.z }

pub fn crypto_hash_sha512_point_label(pt : Cryptohashsha512Point) -> Int { pt.label }

pub fn crypto_hash_sha512_point_dist(a : Cryptohashsha512Point, b : Cryptohashsha512Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_sha512_point_add(a : Cryptohashsha512Point, b : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_sha512_point_sub(a : Cryptohashsha512Point, b : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_sha512_point_scale(pt : Cryptohashsha512Point, s : Double) -> Cryptohashsha512Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_sha512_point_dot(a : Cryptohashsha512Point, b : Cryptohashsha512Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_sha512_point_cross(a : Cryptohashsha512Point, b : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_sha512_point_norm(pt : Cryptohashsha512Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_sha512_point_normalize(pt : Cryptohashsha512Point) -> Cryptohashsha512Point {
  let n = crypto_hash_sha512_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_sha512_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_sha512_point_negate(pt : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_sha512_point_mid(a : Cryptohashsha512Point, b : Cryptohashsha512Point) -> Cryptohashsha512Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_sha512_point_lerp(a : Cryptohashsha512Point, b : Cryptohashsha512Point, t : Double) -> Cryptohashsha512Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_sha512_point_to_string(pt : Cryptohashsha512Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptohashsha512Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha512_make_series(vals : Array[Double], name : String) -> Cryptohashsha512Series {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_sha512_series_len(s : Cryptohashsha512Series) -> Int { s.vals.length() }

pub fn crypto_hash_sha512_series_sum(s : Cryptohashsha512Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_hash_sha512_series_mean(s : Cryptohashsha512Series) -> Double {
  let n = crypto_hash_sha512_series_len(s)
  if n == 0 { 0.0 } else { crypto_hash_sha512_series_sum(s) / n.to_double() }
}

pub fn crypto_hash_sha512_series_min(s : Cryptohashsha512Series) -> Double {
  let n = crypto_hash_sha512_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_hash_sha512_series_max(s : Cryptohashsha512Series) -> Double {
  let n = crypto_hash_sha512_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_hash_sha512_series_range(s : Cryptohashsha512Series) -> Double {
  crypto_hash_sha512_series_max(s) - crypto_hash_sha512_series_min(s)
}

pub fn crypto_hash_sha512_series_var(s : Cryptohashsha512Series) -> Double {
  let n = crypto_hash_sha512_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_hash_sha512_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_hash_sha512_series_std(s : Cryptohashsha512Series) -> Double { @_common.sqrt(crypto_hash_sha512_series_var(s)) }

pub fn crypto_hash_sha512_series_median(s : Cryptohashsha512Series) -> Double {
  let n = crypto_hash_sha512_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_hash_sha512_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_hash_sha512_series_scale(s : Cryptohashsha512Series, f : Double) -> Cryptohashsha512Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_sha512_series_add(a : Cryptohashsha512Series, b : Cryptohashsha512Series) -> Cryptohashsha512Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_sha512_series_sub(a : Cryptohashsha512Series, b : Cryptohashsha512Series) -> Cryptohashsha512Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_sha512_series_normalize(s : Cryptohashsha512Series) -> Cryptohashsha512Series {
  let mn = crypto_hash_sha512_series_min(s)
  let mx = crypto_hash_sha512_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_sha512_series_cumsum(s : Cryptohashsha512Series) -> Cryptohashsha512Series {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_sha512_series_to_string(s : Cryptohashsha512Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha512Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha512_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha512Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha512_matrix_identity(n : Int) -> Cryptohashsha512Matrix {
  let m = crypto_hash_sha512_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_sha512_matrix_get(m : Cryptohashsha512Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_sha512_matrix_transpose(m : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  let result = crypto_hash_sha512_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_sha512_matrix_add(a : Cryptohashsha512Matrix, b : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_sha512_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_sha512_matrix_scale(m : Cryptohashsha512Matrix, s : Double) -> Cryptohashsha512Matrix {
  let result = crypto_hash_sha512_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_sha512_matrix_multiply(a : Cryptohashsha512Matrix, b : Cryptohashsha512Matrix) -> Cryptohashsha512Matrix {
  if a.cols != b.rows { return crypto_hash_sha512_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_sha512_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_sha512_matrix_trace(m : Cryptohashsha512Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_sha512_matrix_det(m : Cryptohashsha512Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_sha512_matrix_norm(m : Cryptohashsha512Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_sha512_matrix_to_string(m : Cryptohashsha512Matrix) -> String {
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

pub(all) struct Cryptohashsha512Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha512_make_vector(comps : Array[Double]) -> Cryptohashsha512Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha512_vector_zero(dim : Int) -> Cryptohashsha512Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_sha512_vector_add(a : Cryptohashsha512Vector, b : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_sha512_vector_sub(a : Cryptohashsha512Vector, b : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_sha512_vector_scale(v : Cryptohashsha512Vector, s : Double) -> Cryptohashsha512Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_sha512_vector_dot(a : Cryptohashsha512Vector, b : Cryptohashsha512Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_sha512_vector_norm(v : Cryptohashsha512Vector) -> Double { @_common.sqrt(crypto_hash_sha512_vector_dot(v, v)) }

pub fn crypto_hash_sha512_vector_normalize(v : Cryptohashsha512Vector) -> Cryptohashsha512Vector {
  let n = crypto_hash_sha512_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_sha512_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_sha512_vector_dist(a : Cryptohashsha512Vector, b : Cryptohashsha512Vector) -> Double {
  crypto_hash_sha512_vector_norm(crypto_hash_sha512_vector_sub(a, b))
}

pub fn crypto_hash_sha512_vector_to_string(v : Cryptohashsha512Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_sha512_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_sha512_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_sha512_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_sha512_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_sha512_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_sha512_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_sha512_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_sha512_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_sha512_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_sha512_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_sha512_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_sha512_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_sha512_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_sha512_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_sha512_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_sha512_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_sha512_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_sha512_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_sha512_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_sha512_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_sha512_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_sha512_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_sha512_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_sha512_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_sha512_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_sha512_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_sha512_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_sha512_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_sha512_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashsha512Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_frame_make(size : Int) -> Cryptohashsha512Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_frame_len(s : Cryptohashsha512Frame) -> Int { s.size }

pub fn crypto_hash_sha512_frame_get(s : Cryptohashsha512Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_frame_set(s : Cryptohashsha512Frame, i : Int, v : Double) -> Cryptohashsha512Frame {
  let result = crypto_hash_sha512_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_frame_sum(s : Cryptohashsha512Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_frame_mean(s : Cryptohashsha512Frame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_frame_scale(s : Cryptohashsha512Frame, f : Double) -> Cryptohashsha512Frame {
  let result = crypto_hash_sha512_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_frame_add(a : Cryptohashsha512Frame, b : Cryptohashsha512Frame) -> Cryptohashsha512Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_frame_copy(s : Cryptohashsha512Frame) -> Cryptohashsha512Frame {
  let result = crypto_hash_sha512_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_frame_fill(s : Cryptohashsha512Frame, v : Double) -> Cryptohashsha512Frame {
  let result = crypto_hash_sha512_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_frame_min(s : Cryptohashsha512Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_frame_max(s : Cryptohashsha512Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_frame_to_string(s : Cryptohashsha512Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_table_make(size : Int) -> Cryptohashsha512Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_table_len(s : Cryptohashsha512Table) -> Int { s.size }

pub fn crypto_hash_sha512_table_get(s : Cryptohashsha512Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_table_set(s : Cryptohashsha512Table, i : Int, v : Double) -> Cryptohashsha512Table {
  let result = crypto_hash_sha512_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_table_sum(s : Cryptohashsha512Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_table_mean(s : Cryptohashsha512Table) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_table_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_table_scale(s : Cryptohashsha512Table, f : Double) -> Cryptohashsha512Table {
  let result = crypto_hash_sha512_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_table_add(a : Cryptohashsha512Table, b : Cryptohashsha512Table) -> Cryptohashsha512Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_table_copy(s : Cryptohashsha512Table) -> Cryptohashsha512Table {
  let result = crypto_hash_sha512_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_table_fill(s : Cryptohashsha512Table, v : Double) -> Cryptohashsha512Table {
  let result = crypto_hash_sha512_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_table_min(s : Cryptohashsha512Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_table_max(s : Cryptohashsha512Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_table_to_string(s : Cryptohashsha512Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_graphn_make(size : Int) -> Cryptohashsha512GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_graphn_len(s : Cryptohashsha512GraphN) -> Int { s.size }

pub fn crypto_hash_sha512_graphn_get(s : Cryptohashsha512GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_graphn_set(s : Cryptohashsha512GraphN, i : Int, v : Double) -> Cryptohashsha512GraphN {
  let result = crypto_hash_sha512_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_graphn_sum(s : Cryptohashsha512GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_graphn_mean(s : Cryptohashsha512GraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_graphn_scale(s : Cryptohashsha512GraphN, f : Double) -> Cryptohashsha512GraphN {
  let result = crypto_hash_sha512_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_graphn_add(a : Cryptohashsha512GraphN, b : Cryptohashsha512GraphN) -> Cryptohashsha512GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_graphn_copy(s : Cryptohashsha512GraphN) -> Cryptohashsha512GraphN {
  let result = crypto_hash_sha512_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_graphn_fill(s : Cryptohashsha512GraphN, v : Double) -> Cryptohashsha512GraphN {
  let result = crypto_hash_sha512_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_graphn_min(s : Cryptohashsha512GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_graphn_max(s : Cryptohashsha512GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_graphn_to_string(s : Cryptohashsha512GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_node_make(size : Int) -> Cryptohashsha512Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_node_len(s : Cryptohashsha512Node) -> Int { s.size }

pub fn crypto_hash_sha512_node_get(s : Cryptohashsha512Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_node_set(s : Cryptohashsha512Node, i : Int, v : Double) -> Cryptohashsha512Node {
  let result = crypto_hash_sha512_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_node_sum(s : Cryptohashsha512Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_node_mean(s : Cryptohashsha512Node) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_node_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_node_scale(s : Cryptohashsha512Node, f : Double) -> Cryptohashsha512Node {
  let result = crypto_hash_sha512_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_node_add(a : Cryptohashsha512Node, b : Cryptohashsha512Node) -> Cryptohashsha512Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_node_copy(s : Cryptohashsha512Node) -> Cryptohashsha512Node {
  let result = crypto_hash_sha512_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_node_fill(s : Cryptohashsha512Node, v : Double) -> Cryptohashsha512Node {
  let result = crypto_hash_sha512_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_node_min(s : Cryptohashsha512Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_node_max(s : Cryptohashsha512Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_node_to_string(s : Cryptohashsha512Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_edge_make(size : Int) -> Cryptohashsha512Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_edge_len(s : Cryptohashsha512Edge) -> Int { s.size }

pub fn crypto_hash_sha512_edge_get(s : Cryptohashsha512Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_edge_set(s : Cryptohashsha512Edge, i : Int, v : Double) -> Cryptohashsha512Edge {
  let result = crypto_hash_sha512_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_edge_sum(s : Cryptohashsha512Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_edge_mean(s : Cryptohashsha512Edge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_edge_scale(s : Cryptohashsha512Edge, f : Double) -> Cryptohashsha512Edge {
  let result = crypto_hash_sha512_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_edge_add(a : Cryptohashsha512Edge, b : Cryptohashsha512Edge) -> Cryptohashsha512Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_edge_copy(s : Cryptohashsha512Edge) -> Cryptohashsha512Edge {
  let result = crypto_hash_sha512_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_edge_fill(s : Cryptohashsha512Edge, v : Double) -> Cryptohashsha512Edge {
  let result = crypto_hash_sha512_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_edge_min(s : Cryptohashsha512Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_edge_max(s : Cryptohashsha512Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_edge_to_string(s : Cryptohashsha512Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_path_make(size : Int) -> Cryptohashsha512Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_path_len(s : Cryptohashsha512Path) -> Int { s.size }

pub fn crypto_hash_sha512_path_get(s : Cryptohashsha512Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_path_set(s : Cryptohashsha512Path, i : Int, v : Double) -> Cryptohashsha512Path {
  let result = crypto_hash_sha512_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_path_sum(s : Cryptohashsha512Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_path_mean(s : Cryptohashsha512Path) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_path_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_path_scale(s : Cryptohashsha512Path, f : Double) -> Cryptohashsha512Path {
  let result = crypto_hash_sha512_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_path_add(a : Cryptohashsha512Path, b : Cryptohashsha512Path) -> Cryptohashsha512Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_path_copy(s : Cryptohashsha512Path) -> Cryptohashsha512Path {
  let result = crypto_hash_sha512_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_path_fill(s : Cryptohashsha512Path, v : Double) -> Cryptohashsha512Path {
  let result = crypto_hash_sha512_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_path_min(s : Cryptohashsha512Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_path_max(s : Cryptohashsha512Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_path_to_string(s : Cryptohashsha512Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_cluster_make(size : Int) -> Cryptohashsha512Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_cluster_len(s : Cryptohashsha512Cluster) -> Int { s.size }

pub fn crypto_hash_sha512_cluster_get(s : Cryptohashsha512Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_cluster_set(s : Cryptohashsha512Cluster, i : Int, v : Double) -> Cryptohashsha512Cluster {
  let result = crypto_hash_sha512_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_cluster_sum(s : Cryptohashsha512Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_cluster_mean(s : Cryptohashsha512Cluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_cluster_scale(s : Cryptohashsha512Cluster, f : Double) -> Cryptohashsha512Cluster {
  let result = crypto_hash_sha512_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_cluster_add(a : Cryptohashsha512Cluster, b : Cryptohashsha512Cluster) -> Cryptohashsha512Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_cluster_copy(s : Cryptohashsha512Cluster) -> Cryptohashsha512Cluster {
  let result = crypto_hash_sha512_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_cluster_fill(s : Cryptohashsha512Cluster, v : Double) -> Cryptohashsha512Cluster {
  let result = crypto_hash_sha512_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_cluster_min(s : Cryptohashsha512Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_cluster_max(s : Cryptohashsha512Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_cluster_to_string(s : Cryptohashsha512Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_model_make(size : Int) -> Cryptohashsha512Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_model_len(s : Cryptohashsha512Model) -> Int { s.size }

pub fn crypto_hash_sha512_model_get(s : Cryptohashsha512Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_model_set(s : Cryptohashsha512Model, i : Int, v : Double) -> Cryptohashsha512Model {
  let result = crypto_hash_sha512_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_model_sum(s : Cryptohashsha512Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_model_mean(s : Cryptohashsha512Model) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_model_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_model_scale(s : Cryptohashsha512Model, f : Double) -> Cryptohashsha512Model {
  let result = crypto_hash_sha512_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_model_add(a : Cryptohashsha512Model, b : Cryptohashsha512Model) -> Cryptohashsha512Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_model_copy(s : Cryptohashsha512Model) -> Cryptohashsha512Model {
  let result = crypto_hash_sha512_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_model_fill(s : Cryptohashsha512Model, v : Double) -> Cryptohashsha512Model {
  let result = crypto_hash_sha512_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_model_min(s : Cryptohashsha512Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_model_max(s : Cryptohashsha512Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_model_to_string(s : Cryptohashsha512Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_layer_make(size : Int) -> Cryptohashsha512Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_layer_len(s : Cryptohashsha512Layer) -> Int { s.size }

pub fn crypto_hash_sha512_layer_get(s : Cryptohashsha512Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_layer_set(s : Cryptohashsha512Layer, i : Int, v : Double) -> Cryptohashsha512Layer {
  let result = crypto_hash_sha512_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_layer_sum(s : Cryptohashsha512Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_layer_mean(s : Cryptohashsha512Layer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_layer_scale(s : Cryptohashsha512Layer, f : Double) -> Cryptohashsha512Layer {
  let result = crypto_hash_sha512_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_layer_add(a : Cryptohashsha512Layer, b : Cryptohashsha512Layer) -> Cryptohashsha512Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_layer_copy(s : Cryptohashsha512Layer) -> Cryptohashsha512Layer {
  let result = crypto_hash_sha512_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_layer_fill(s : Cryptohashsha512Layer, v : Double) -> Cryptohashsha512Layer {
  let result = crypto_hash_sha512_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_layer_min(s : Cryptohashsha512Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_layer_max(s : Cryptohashsha512Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_layer_to_string(s : Cryptohashsha512Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_buffer_make(size : Int) -> Cryptohashsha512Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_buffer_len(s : Cryptohashsha512Buffer) -> Int { s.size }

pub fn crypto_hash_sha512_buffer_get(s : Cryptohashsha512Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_buffer_set(s : Cryptohashsha512Buffer, i : Int, v : Double) -> Cryptohashsha512Buffer {
  let result = crypto_hash_sha512_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_buffer_sum(s : Cryptohashsha512Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_buffer_mean(s : Cryptohashsha512Buffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_buffer_scale(s : Cryptohashsha512Buffer, f : Double) -> Cryptohashsha512Buffer {
  let result = crypto_hash_sha512_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_buffer_add(a : Cryptohashsha512Buffer, b : Cryptohashsha512Buffer) -> Cryptohashsha512Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_buffer_copy(s : Cryptohashsha512Buffer) -> Cryptohashsha512Buffer {
  let result = crypto_hash_sha512_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_buffer_fill(s : Cryptohashsha512Buffer, v : Double) -> Cryptohashsha512Buffer {
  let result = crypto_hash_sha512_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_buffer_min(s : Cryptohashsha512Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_buffer_max(s : Cryptohashsha512Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_buffer_to_string(s : Cryptohashsha512Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_cursor_make(size : Int) -> Cryptohashsha512Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_cursor_len(s : Cryptohashsha512Cursor) -> Int { s.size }

pub fn crypto_hash_sha512_cursor_get(s : Cryptohashsha512Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_cursor_set(s : Cryptohashsha512Cursor, i : Int, v : Double) -> Cryptohashsha512Cursor {
  let result = crypto_hash_sha512_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_cursor_sum(s : Cryptohashsha512Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_cursor_mean(s : Cryptohashsha512Cursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_cursor_scale(s : Cryptohashsha512Cursor, f : Double) -> Cryptohashsha512Cursor {
  let result = crypto_hash_sha512_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_cursor_add(a : Cryptohashsha512Cursor, b : Cryptohashsha512Cursor) -> Cryptohashsha512Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_cursor_copy(s : Cryptohashsha512Cursor) -> Cryptohashsha512Cursor {
  let result = crypto_hash_sha512_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_cursor_fill(s : Cryptohashsha512Cursor, v : Double) -> Cryptohashsha512Cursor {
  let result = crypto_hash_sha512_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_cursor_min(s : Cryptohashsha512Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_cursor_max(s : Cryptohashsha512Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_cursor_to_string(s : Cryptohashsha512Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_view_make(size : Int) -> Cryptohashsha512View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_view_len(s : Cryptohashsha512View) -> Int { s.size }

pub fn crypto_hash_sha512_view_get(s : Cryptohashsha512View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_view_set(s : Cryptohashsha512View, i : Int, v : Double) -> Cryptohashsha512View {
  let result = crypto_hash_sha512_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_view_sum(s : Cryptohashsha512View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_view_mean(s : Cryptohashsha512View) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_view_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_view_scale(s : Cryptohashsha512View, f : Double) -> Cryptohashsha512View {
  let result = crypto_hash_sha512_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_view_add(a : Cryptohashsha512View, b : Cryptohashsha512View) -> Cryptohashsha512View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_view_copy(s : Cryptohashsha512View) -> Cryptohashsha512View {
  let result = crypto_hash_sha512_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_view_fill(s : Cryptohashsha512View, v : Double) -> Cryptohashsha512View {
  let result = crypto_hash_sha512_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_view_min(s : Cryptohashsha512View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_view_max(s : Cryptohashsha512View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_view_to_string(s : Cryptohashsha512View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_range_make(size : Int) -> Cryptohashsha512Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_range_len(s : Cryptohashsha512Range) -> Int { s.size }

pub fn crypto_hash_sha512_range_get(s : Cryptohashsha512Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_range_set(s : Cryptohashsha512Range, i : Int, v : Double) -> Cryptohashsha512Range {
  let result = crypto_hash_sha512_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_range_sum(s : Cryptohashsha512Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_range_mean(s : Cryptohashsha512Range) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_range_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_range_scale(s : Cryptohashsha512Range, f : Double) -> Cryptohashsha512Range {
  let result = crypto_hash_sha512_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_range_add(a : Cryptohashsha512Range, b : Cryptohashsha512Range) -> Cryptohashsha512Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_range_copy(s : Cryptohashsha512Range) -> Cryptohashsha512Range {
  let result = crypto_hash_sha512_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_range_fill(s : Cryptohashsha512Range, v : Double) -> Cryptohashsha512Range {
  let result = crypto_hash_sha512_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_range_min(s : Cryptohashsha512Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_range_max(s : Cryptohashsha512Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_range_to_string(s : Cryptohashsha512Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha512Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha512_slice_make(size : Int) -> Cryptohashsha512Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha512_slice_len(s : Cryptohashsha512Slice) -> Int { s.size }

pub fn crypto_hash_sha512_slice_get(s : Cryptohashsha512Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha512_slice_set(s : Cryptohashsha512Slice, i : Int, v : Double) -> Cryptohashsha512Slice {
  let result = crypto_hash_sha512_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_slice_sum(s : Cryptohashsha512Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha512_slice_mean(s : Cryptohashsha512Slice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha512_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha512_slice_scale(s : Cryptohashsha512Slice, f : Double) -> Cryptohashsha512Slice {
  let result = crypto_hash_sha512_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha512_slice_add(a : Cryptohashsha512Slice, b : Cryptohashsha512Slice) -> Cryptohashsha512Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha512_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha512_slice_copy(s : Cryptohashsha512Slice) -> Cryptohashsha512Slice {
  let result = crypto_hash_sha512_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha512_slice_fill(s : Cryptohashsha512Slice, v : Double) -> Cryptohashsha512Slice {
  let result = crypto_hash_sha512_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha512_slice_min(s : Cryptohashsha512Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_slice_max(s : Cryptohashsha512Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha512_slice_to_string(s : Cryptohashsha512Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

