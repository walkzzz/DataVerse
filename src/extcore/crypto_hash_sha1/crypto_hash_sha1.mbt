///===
/// extcore/crypto_hash_sha1

pub(all) struct Cryptohashsha1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_sha1_make_point(x : Double, y : Double) -> Cryptohashsha1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_sha1_make_point3(x : Double, y : Double, z : Double) -> Cryptohashsha1Point {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_sha1_point_x(pt : Cryptohashsha1Point) -> Double { pt.x }

pub fn crypto_hash_sha1_point_y(pt : Cryptohashsha1Point) -> Double { pt.y }

pub fn crypto_hash_sha1_point_z(pt : Cryptohashsha1Point) -> Double { pt.z }

pub fn crypto_hash_sha1_point_label(pt : Cryptohashsha1Point) -> Int { pt.label }

pub fn crypto_hash_sha1_point_dist(a : Cryptohashsha1Point, b : Cryptohashsha1Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_sha1_point_add(a : Cryptohashsha1Point, b : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_sha1_point_sub(a : Cryptohashsha1Point, b : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_sha1_point_scale(pt : Cryptohashsha1Point, s : Double) -> Cryptohashsha1Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_sha1_point_dot(a : Cryptohashsha1Point, b : Cryptohashsha1Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_sha1_point_cross(a : Cryptohashsha1Point, b : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_sha1_point_norm(pt : Cryptohashsha1Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_sha1_point_normalize(pt : Cryptohashsha1Point) -> Cryptohashsha1Point {
  let n = crypto_hash_sha1_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_sha1_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_sha1_point_negate(pt : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_sha1_point_mid(a : Cryptohashsha1Point, b : Cryptohashsha1Point) -> Cryptohashsha1Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_sha1_point_lerp(a : Cryptohashsha1Point, b : Cryptohashsha1Point, t : Double) -> Cryptohashsha1Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_sha1_point_to_string(pt : Cryptohashsha1Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptohashsha1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_sha1_make_series(vals : Array[Double], name : String) -> Cryptohashsha1Series {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_sha1_series_len(s : Cryptohashsha1Series) -> Int { s.vals.length() }

pub fn crypto_hash_sha1_series_sum(s : Cryptohashsha1Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_hash_sha1_series_mean(s : Cryptohashsha1Series) -> Double { @_common.mean(s.vals) }

pub fn crypto_hash_sha1_series_min(s : Cryptohashsha1Series) -> Double { @_common.min(s.vals) }

pub fn crypto_hash_sha1_series_max(s : Cryptohashsha1Series) -> Double { @_common.max(s.vals) }

pub fn crypto_hash_sha1_series_range(s : Cryptohashsha1Series) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_hash_sha1_series_var(s : Cryptohashsha1Series) -> Double { @_common.variance(s.vals) }

pub fn crypto_hash_sha1_series_std(s : Cryptohashsha1Series) -> Double { @_common.std(s.vals) }

pub fn crypto_hash_sha1_series_median(s : Cryptohashsha1Series) -> Double { @_common.median(s.vals) }

pub fn crypto_hash_sha1_series_scale(s : Cryptohashsha1Series, f : Double) -> Cryptohashsha1Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_sha1_series_add(a : Cryptohashsha1Series, b : Cryptohashsha1Series) -> Cryptohashsha1Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_sha1_series_sub(a : Cryptohashsha1Series, b : Cryptohashsha1Series) -> Cryptohashsha1Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_sha1_series_normalize(s : Cryptohashsha1Series) -> Cryptohashsha1Series {
  let mn = crypto_hash_sha1_series_min(s)
  let mx = crypto_hash_sha1_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_sha1_series_cumsum(s : Cryptohashsha1Series) -> Cryptohashsha1Series {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_sha1_series_to_string(s : Cryptohashsha1Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashsha1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_sha1_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashsha1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_sha1_matrix_identity(n : Int) -> Cryptohashsha1Matrix {
  let m = crypto_hash_sha1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_sha1_matrix_get(m : Cryptohashsha1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_sha1_matrix_transpose(m : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  let result = crypto_hash_sha1_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_sha1_matrix_add(a : Cryptohashsha1Matrix, b : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_sha1_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_sha1_matrix_scale(m : Cryptohashsha1Matrix, s : Double) -> Cryptohashsha1Matrix {
  let result = crypto_hash_sha1_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_sha1_matrix_multiply(a : Cryptohashsha1Matrix, b : Cryptohashsha1Matrix) -> Cryptohashsha1Matrix {
  if a.cols != b.rows { return crypto_hash_sha1_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_sha1_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_sha1_matrix_trace(m : Cryptohashsha1Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_sha1_matrix_det(m : Cryptohashsha1Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_sha1_matrix_norm(m : Cryptohashsha1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_sha1_matrix_to_string(m : Cryptohashsha1Matrix) -> String {
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

pub(all) struct Cryptohashsha1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_sha1_make_vector(comps : Array[Double]) -> Cryptohashsha1Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_sha1_vector_zero(dim : Int) -> Cryptohashsha1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_sha1_vector_add(a : Cryptohashsha1Vector, b : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_sha1_vector_sub(a : Cryptohashsha1Vector, b : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_sha1_vector_scale(v : Cryptohashsha1Vector, s : Double) -> Cryptohashsha1Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_sha1_vector_dot(a : Cryptohashsha1Vector, b : Cryptohashsha1Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_sha1_vector_norm(v : Cryptohashsha1Vector) -> Double { @_common.sqrt(crypto_hash_sha1_vector_dot(v, v)) }

pub fn crypto_hash_sha1_vector_normalize(v : Cryptohashsha1Vector) -> Cryptohashsha1Vector {
  let n = crypto_hash_sha1_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_sha1_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_sha1_vector_dist(a : Cryptohashsha1Vector, b : Cryptohashsha1Vector) -> Double {
  crypto_hash_sha1_vector_norm(crypto_hash_sha1_vector_sub(a, b))
}

pub fn crypto_hash_sha1_vector_to_string(v : Cryptohashsha1Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_sha1_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_sha1_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_sha1_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_sha1_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_sha1_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_sha1_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_sha1_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_sha1_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_sha1_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_sha1_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_sha1_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_sha1_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_sha1_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_sha1_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_sha1_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_sha1_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_sha1_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_sha1_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_sha1_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_sha1_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_sha1_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_sha1_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_sha1_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_sha1_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_sha1_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_sha1_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_sha1_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_sha1_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_sha1_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashsha1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_frame_make(size : Int) -> Cryptohashsha1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_frame_len(s : Cryptohashsha1Frame) -> Int { s.size }

pub fn crypto_hash_sha1_frame_get(s : Cryptohashsha1Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_frame_set(s : Cryptohashsha1Frame, i : Int, v : Double) -> Cryptohashsha1Frame {
  let result = crypto_hash_sha1_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_frame_sum(s : Cryptohashsha1Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_frame_mean(s : Cryptohashsha1Frame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_frame_scale(s : Cryptohashsha1Frame, f : Double) -> Cryptohashsha1Frame {
  let result = crypto_hash_sha1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_frame_add(a : Cryptohashsha1Frame, b : Cryptohashsha1Frame) -> Cryptohashsha1Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_frame_copy(s : Cryptohashsha1Frame) -> Cryptohashsha1Frame {
  let result = crypto_hash_sha1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_frame_fill(s : Cryptohashsha1Frame, v : Double) -> Cryptohashsha1Frame {
  let result = crypto_hash_sha1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_frame_min(s : Cryptohashsha1Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_frame_max(s : Cryptohashsha1Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_frame_to_string(s : Cryptohashsha1Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_table_make(size : Int) -> Cryptohashsha1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_table_len(s : Cryptohashsha1Table) -> Int { s.size }

pub fn crypto_hash_sha1_table_get(s : Cryptohashsha1Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_table_set(s : Cryptohashsha1Table, i : Int, v : Double) -> Cryptohashsha1Table {
  let result = crypto_hash_sha1_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_table_sum(s : Cryptohashsha1Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_table_mean(s : Cryptohashsha1Table) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_table_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_table_scale(s : Cryptohashsha1Table, f : Double) -> Cryptohashsha1Table {
  let result = crypto_hash_sha1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_table_add(a : Cryptohashsha1Table, b : Cryptohashsha1Table) -> Cryptohashsha1Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_table_copy(s : Cryptohashsha1Table) -> Cryptohashsha1Table {
  let result = crypto_hash_sha1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_table_fill(s : Cryptohashsha1Table, v : Double) -> Cryptohashsha1Table {
  let result = crypto_hash_sha1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_table_min(s : Cryptohashsha1Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_table_max(s : Cryptohashsha1Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_table_to_string(s : Cryptohashsha1Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_graphn_make(size : Int) -> Cryptohashsha1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_graphn_len(s : Cryptohashsha1GraphN) -> Int { s.size }

pub fn crypto_hash_sha1_graphn_get(s : Cryptohashsha1GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_graphn_set(s : Cryptohashsha1GraphN, i : Int, v : Double) -> Cryptohashsha1GraphN {
  let result = crypto_hash_sha1_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_graphn_sum(s : Cryptohashsha1GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_graphn_mean(s : Cryptohashsha1GraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_graphn_scale(s : Cryptohashsha1GraphN, f : Double) -> Cryptohashsha1GraphN {
  let result = crypto_hash_sha1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_graphn_add(a : Cryptohashsha1GraphN, b : Cryptohashsha1GraphN) -> Cryptohashsha1GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_graphn_copy(s : Cryptohashsha1GraphN) -> Cryptohashsha1GraphN {
  let result = crypto_hash_sha1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_graphn_fill(s : Cryptohashsha1GraphN, v : Double) -> Cryptohashsha1GraphN {
  let result = crypto_hash_sha1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_graphn_min(s : Cryptohashsha1GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_graphn_max(s : Cryptohashsha1GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_graphn_to_string(s : Cryptohashsha1GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_node_make(size : Int) -> Cryptohashsha1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_node_len(s : Cryptohashsha1Node) -> Int { s.size }

pub fn crypto_hash_sha1_node_get(s : Cryptohashsha1Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_node_set(s : Cryptohashsha1Node, i : Int, v : Double) -> Cryptohashsha1Node {
  let result = crypto_hash_sha1_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_node_sum(s : Cryptohashsha1Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_node_mean(s : Cryptohashsha1Node) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_node_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_node_scale(s : Cryptohashsha1Node, f : Double) -> Cryptohashsha1Node {
  let result = crypto_hash_sha1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_node_add(a : Cryptohashsha1Node, b : Cryptohashsha1Node) -> Cryptohashsha1Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_node_copy(s : Cryptohashsha1Node) -> Cryptohashsha1Node {
  let result = crypto_hash_sha1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_node_fill(s : Cryptohashsha1Node, v : Double) -> Cryptohashsha1Node {
  let result = crypto_hash_sha1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_node_min(s : Cryptohashsha1Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_node_max(s : Cryptohashsha1Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_node_to_string(s : Cryptohashsha1Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_edge_make(size : Int) -> Cryptohashsha1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_edge_len(s : Cryptohashsha1Edge) -> Int { s.size }

pub fn crypto_hash_sha1_edge_get(s : Cryptohashsha1Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_edge_set(s : Cryptohashsha1Edge, i : Int, v : Double) -> Cryptohashsha1Edge {
  let result = crypto_hash_sha1_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_edge_sum(s : Cryptohashsha1Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_edge_mean(s : Cryptohashsha1Edge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_edge_scale(s : Cryptohashsha1Edge, f : Double) -> Cryptohashsha1Edge {
  let result = crypto_hash_sha1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_edge_add(a : Cryptohashsha1Edge, b : Cryptohashsha1Edge) -> Cryptohashsha1Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_edge_copy(s : Cryptohashsha1Edge) -> Cryptohashsha1Edge {
  let result = crypto_hash_sha1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_edge_fill(s : Cryptohashsha1Edge, v : Double) -> Cryptohashsha1Edge {
  let result = crypto_hash_sha1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_edge_min(s : Cryptohashsha1Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_edge_max(s : Cryptohashsha1Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_edge_to_string(s : Cryptohashsha1Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_path_make(size : Int) -> Cryptohashsha1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_path_len(s : Cryptohashsha1Path) -> Int { s.size }

pub fn crypto_hash_sha1_path_get(s : Cryptohashsha1Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_path_set(s : Cryptohashsha1Path, i : Int, v : Double) -> Cryptohashsha1Path {
  let result = crypto_hash_sha1_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_path_sum(s : Cryptohashsha1Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_path_mean(s : Cryptohashsha1Path) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_path_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_path_scale(s : Cryptohashsha1Path, f : Double) -> Cryptohashsha1Path {
  let result = crypto_hash_sha1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_path_add(a : Cryptohashsha1Path, b : Cryptohashsha1Path) -> Cryptohashsha1Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_path_copy(s : Cryptohashsha1Path) -> Cryptohashsha1Path {
  let result = crypto_hash_sha1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_path_fill(s : Cryptohashsha1Path, v : Double) -> Cryptohashsha1Path {
  let result = crypto_hash_sha1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_path_min(s : Cryptohashsha1Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_path_max(s : Cryptohashsha1Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_path_to_string(s : Cryptohashsha1Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_cluster_make(size : Int) -> Cryptohashsha1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_cluster_len(s : Cryptohashsha1Cluster) -> Int { s.size }

pub fn crypto_hash_sha1_cluster_get(s : Cryptohashsha1Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_cluster_set(s : Cryptohashsha1Cluster, i : Int, v : Double) -> Cryptohashsha1Cluster {
  let result = crypto_hash_sha1_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_cluster_sum(s : Cryptohashsha1Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_cluster_mean(s : Cryptohashsha1Cluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_cluster_scale(s : Cryptohashsha1Cluster, f : Double) -> Cryptohashsha1Cluster {
  let result = crypto_hash_sha1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_cluster_add(a : Cryptohashsha1Cluster, b : Cryptohashsha1Cluster) -> Cryptohashsha1Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_cluster_copy(s : Cryptohashsha1Cluster) -> Cryptohashsha1Cluster {
  let result = crypto_hash_sha1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_cluster_fill(s : Cryptohashsha1Cluster, v : Double) -> Cryptohashsha1Cluster {
  let result = crypto_hash_sha1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_cluster_min(s : Cryptohashsha1Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_cluster_max(s : Cryptohashsha1Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_cluster_to_string(s : Cryptohashsha1Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_model_make(size : Int) -> Cryptohashsha1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_model_len(s : Cryptohashsha1Model) -> Int { s.size }

pub fn crypto_hash_sha1_model_get(s : Cryptohashsha1Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_model_set(s : Cryptohashsha1Model, i : Int, v : Double) -> Cryptohashsha1Model {
  let result = crypto_hash_sha1_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_model_sum(s : Cryptohashsha1Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_model_mean(s : Cryptohashsha1Model) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_model_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_model_scale(s : Cryptohashsha1Model, f : Double) -> Cryptohashsha1Model {
  let result = crypto_hash_sha1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_model_add(a : Cryptohashsha1Model, b : Cryptohashsha1Model) -> Cryptohashsha1Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_model_copy(s : Cryptohashsha1Model) -> Cryptohashsha1Model {
  let result = crypto_hash_sha1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_model_fill(s : Cryptohashsha1Model, v : Double) -> Cryptohashsha1Model {
  let result = crypto_hash_sha1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_model_min(s : Cryptohashsha1Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_model_max(s : Cryptohashsha1Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_model_to_string(s : Cryptohashsha1Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_layer_make(size : Int) -> Cryptohashsha1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_layer_len(s : Cryptohashsha1Layer) -> Int { s.size }

pub fn crypto_hash_sha1_layer_get(s : Cryptohashsha1Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_layer_set(s : Cryptohashsha1Layer, i : Int, v : Double) -> Cryptohashsha1Layer {
  let result = crypto_hash_sha1_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_layer_sum(s : Cryptohashsha1Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_layer_mean(s : Cryptohashsha1Layer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_layer_scale(s : Cryptohashsha1Layer, f : Double) -> Cryptohashsha1Layer {
  let result = crypto_hash_sha1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_layer_add(a : Cryptohashsha1Layer, b : Cryptohashsha1Layer) -> Cryptohashsha1Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_layer_copy(s : Cryptohashsha1Layer) -> Cryptohashsha1Layer {
  let result = crypto_hash_sha1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_layer_fill(s : Cryptohashsha1Layer, v : Double) -> Cryptohashsha1Layer {
  let result = crypto_hash_sha1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_layer_min(s : Cryptohashsha1Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_layer_max(s : Cryptohashsha1Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_layer_to_string(s : Cryptohashsha1Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_buffer_make(size : Int) -> Cryptohashsha1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_buffer_len(s : Cryptohashsha1Buffer) -> Int { s.size }

pub fn crypto_hash_sha1_buffer_get(s : Cryptohashsha1Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_buffer_set(s : Cryptohashsha1Buffer, i : Int, v : Double) -> Cryptohashsha1Buffer {
  let result = crypto_hash_sha1_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_buffer_sum(s : Cryptohashsha1Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_buffer_mean(s : Cryptohashsha1Buffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_buffer_scale(s : Cryptohashsha1Buffer, f : Double) -> Cryptohashsha1Buffer {
  let result = crypto_hash_sha1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_buffer_add(a : Cryptohashsha1Buffer, b : Cryptohashsha1Buffer) -> Cryptohashsha1Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_buffer_copy(s : Cryptohashsha1Buffer) -> Cryptohashsha1Buffer {
  let result = crypto_hash_sha1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_buffer_fill(s : Cryptohashsha1Buffer, v : Double) -> Cryptohashsha1Buffer {
  let result = crypto_hash_sha1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_buffer_min(s : Cryptohashsha1Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_buffer_max(s : Cryptohashsha1Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_buffer_to_string(s : Cryptohashsha1Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_cursor_make(size : Int) -> Cryptohashsha1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_cursor_len(s : Cryptohashsha1Cursor) -> Int { s.size }

pub fn crypto_hash_sha1_cursor_get(s : Cryptohashsha1Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_cursor_set(s : Cryptohashsha1Cursor, i : Int, v : Double) -> Cryptohashsha1Cursor {
  let result = crypto_hash_sha1_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_cursor_sum(s : Cryptohashsha1Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_cursor_mean(s : Cryptohashsha1Cursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_cursor_scale(s : Cryptohashsha1Cursor, f : Double) -> Cryptohashsha1Cursor {
  let result = crypto_hash_sha1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_cursor_add(a : Cryptohashsha1Cursor, b : Cryptohashsha1Cursor) -> Cryptohashsha1Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_cursor_copy(s : Cryptohashsha1Cursor) -> Cryptohashsha1Cursor {
  let result = crypto_hash_sha1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_cursor_fill(s : Cryptohashsha1Cursor, v : Double) -> Cryptohashsha1Cursor {
  let result = crypto_hash_sha1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_cursor_min(s : Cryptohashsha1Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_cursor_max(s : Cryptohashsha1Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_cursor_to_string(s : Cryptohashsha1Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_view_make(size : Int) -> Cryptohashsha1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_view_len(s : Cryptohashsha1View) -> Int { s.size }

pub fn crypto_hash_sha1_view_get(s : Cryptohashsha1View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_view_set(s : Cryptohashsha1View, i : Int, v : Double) -> Cryptohashsha1View {
  let result = crypto_hash_sha1_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_view_sum(s : Cryptohashsha1View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_view_mean(s : Cryptohashsha1View) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_view_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_view_scale(s : Cryptohashsha1View, f : Double) -> Cryptohashsha1View {
  let result = crypto_hash_sha1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_view_add(a : Cryptohashsha1View, b : Cryptohashsha1View) -> Cryptohashsha1View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_view_copy(s : Cryptohashsha1View) -> Cryptohashsha1View {
  let result = crypto_hash_sha1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_view_fill(s : Cryptohashsha1View, v : Double) -> Cryptohashsha1View {
  let result = crypto_hash_sha1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_view_min(s : Cryptohashsha1View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_view_max(s : Cryptohashsha1View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_view_to_string(s : Cryptohashsha1View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_range_make(size : Int) -> Cryptohashsha1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_range_len(s : Cryptohashsha1Range) -> Int { s.size }

pub fn crypto_hash_sha1_range_get(s : Cryptohashsha1Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_range_set(s : Cryptohashsha1Range, i : Int, v : Double) -> Cryptohashsha1Range {
  let result = crypto_hash_sha1_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_range_sum(s : Cryptohashsha1Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_range_mean(s : Cryptohashsha1Range) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_range_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_range_scale(s : Cryptohashsha1Range, f : Double) -> Cryptohashsha1Range {
  let result = crypto_hash_sha1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_range_add(a : Cryptohashsha1Range, b : Cryptohashsha1Range) -> Cryptohashsha1Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_range_copy(s : Cryptohashsha1Range) -> Cryptohashsha1Range {
  let result = crypto_hash_sha1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_range_fill(s : Cryptohashsha1Range, v : Double) -> Cryptohashsha1Range {
  let result = crypto_hash_sha1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_range_min(s : Cryptohashsha1Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_range_max(s : Cryptohashsha1Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_range_to_string(s : Cryptohashsha1Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashsha1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_sha1_slice_make(size : Int) -> Cryptohashsha1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_sha1_slice_len(s : Cryptohashsha1Slice) -> Int { s.size }

pub fn crypto_hash_sha1_slice_get(s : Cryptohashsha1Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_sha1_slice_set(s : Cryptohashsha1Slice, i : Int, v : Double) -> Cryptohashsha1Slice {
  let result = crypto_hash_sha1_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_slice_sum(s : Cryptohashsha1Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_sha1_slice_mean(s : Cryptohashsha1Slice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_sha1_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_sha1_slice_scale(s : Cryptohashsha1Slice, f : Double) -> Cryptohashsha1Slice {
  let result = crypto_hash_sha1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_sha1_slice_add(a : Cryptohashsha1Slice, b : Cryptohashsha1Slice) -> Cryptohashsha1Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_sha1_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_sha1_slice_copy(s : Cryptohashsha1Slice) -> Cryptohashsha1Slice {
  let result = crypto_hash_sha1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_sha1_slice_fill(s : Cryptohashsha1Slice, v : Double) -> Cryptohashsha1Slice {
  let result = crypto_hash_sha1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_sha1_slice_min(s : Cryptohashsha1Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_slice_max(s : Cryptohashsha1Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_sha1_slice_to_string(s : Cryptohashsha1Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

