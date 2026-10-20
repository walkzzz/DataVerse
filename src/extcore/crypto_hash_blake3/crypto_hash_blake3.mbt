///===
/// extcore/crypto_hash_blake3

pub(all) struct Cryptohashblake3Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_blake3_make_point(x : Double, y : Double) -> Cryptohashblake3Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_blake3_make_point3(x : Double, y : Double, z : Double) -> Cryptohashblake3Point {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_blake3_point_x(pt : Cryptohashblake3Point) -> Double { pt.x }

pub fn crypto_hash_blake3_point_y(pt : Cryptohashblake3Point) -> Double { pt.y }

pub fn crypto_hash_blake3_point_z(pt : Cryptohashblake3Point) -> Double { pt.z }

pub fn crypto_hash_blake3_point_label(pt : Cryptohashblake3Point) -> Int { pt.label }

pub fn crypto_hash_blake3_point_dist(a : Cryptohashblake3Point, b : Cryptohashblake3Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_blake3_point_add(a : Cryptohashblake3Point, b : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_blake3_point_sub(a : Cryptohashblake3Point, b : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_blake3_point_scale(pt : Cryptohashblake3Point, s : Double) -> Cryptohashblake3Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_blake3_point_dot(a : Cryptohashblake3Point, b : Cryptohashblake3Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_blake3_point_cross(a : Cryptohashblake3Point, b : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_blake3_point_norm(pt : Cryptohashblake3Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_blake3_point_normalize(pt : Cryptohashblake3Point) -> Cryptohashblake3Point {
  let n = crypto_hash_blake3_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_blake3_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_blake3_point_negate(pt : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_blake3_point_mid(a : Cryptohashblake3Point, b : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_blake3_point_lerp(a : Cryptohashblake3Point, b : Cryptohashblake3Point, t : Double) -> Cryptohashblake3Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_blake3_point_to_string(pt : Cryptohashblake3Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptohashblake3Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_blake3_make_series(vals : Array[Double], name : String) -> Cryptohashblake3Series {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_blake3_series_len(s : Cryptohashblake3Series) -> Int { s.vals.length() }

pub fn crypto_hash_blake3_series_sum(s : Cryptohashblake3Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_hash_blake3_series_mean(s : Cryptohashblake3Series) -> Double { @_common.mean(s.vals) }

pub fn crypto_hash_blake3_series_min(s : Cryptohashblake3Series) -> Double { @_common.min(s.vals) }

pub fn crypto_hash_blake3_series_max(s : Cryptohashblake3Series) -> Double { @_common.max(s.vals) }

pub fn crypto_hash_blake3_series_range(s : Cryptohashblake3Series) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_hash_blake3_series_var(s : Cryptohashblake3Series) -> Double { @_common.variance(s.vals) }

pub fn crypto_hash_blake3_series_std(s : Cryptohashblake3Series) -> Double { @_common.std(s.vals) }

pub fn crypto_hash_blake3_series_median(s : Cryptohashblake3Series) -> Double { @_common.median(s.vals) }

pub fn crypto_hash_blake3_series_scale(s : Cryptohashblake3Series, f : Double) -> Cryptohashblake3Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_blake3_series_add(a : Cryptohashblake3Series, b : Cryptohashblake3Series) -> Cryptohashblake3Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_blake3_series_sub(a : Cryptohashblake3Series, b : Cryptohashblake3Series) -> Cryptohashblake3Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_blake3_series_normalize(s : Cryptohashblake3Series) -> Cryptohashblake3Series {
  let mn = crypto_hash_blake3_series_min(s)
  let mx = crypto_hash_blake3_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_blake3_series_cumsum(s : Cryptohashblake3Series) -> Cryptohashblake3Series {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_blake3_series_to_string(s : Cryptohashblake3Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashblake3Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_blake3_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashblake3Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_blake3_matrix_identity(n : Int) -> Cryptohashblake3Matrix {
  let m = crypto_hash_blake3_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_blake3_matrix_get(m : Cryptohashblake3Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_blake3_matrix_transpose(m : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  let result = crypto_hash_blake3_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_blake3_matrix_add(a : Cryptohashblake3Matrix, b : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_blake3_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_blake3_matrix_scale(m : Cryptohashblake3Matrix, s : Double) -> Cryptohashblake3Matrix {
  let result = crypto_hash_blake3_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_blake3_matrix_multiply(a : Cryptohashblake3Matrix, b : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  if a.cols != b.rows { return crypto_hash_blake3_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_blake3_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_blake3_matrix_trace(m : Cryptohashblake3Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_blake3_matrix_det(m : Cryptohashblake3Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_blake3_matrix_norm(m : Cryptohashblake3Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_blake3_matrix_to_string(m : Cryptohashblake3Matrix) -> String {
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

pub(all) struct Cryptohashblake3Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_blake3_make_vector(comps : Array[Double]) -> Cryptohashblake3Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_blake3_vector_zero(dim : Int) -> Cryptohashblake3Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_blake3_vector_add(a : Cryptohashblake3Vector, b : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_blake3_vector_sub(a : Cryptohashblake3Vector, b : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_blake3_vector_scale(v : Cryptohashblake3Vector, s : Double) -> Cryptohashblake3Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_blake3_vector_dot(a : Cryptohashblake3Vector, b : Cryptohashblake3Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_blake3_vector_norm(v : Cryptohashblake3Vector) -> Double { @_common.sqrt(crypto_hash_blake3_vector_dot(v, v)) }

pub fn crypto_hash_blake3_vector_normalize(v : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = crypto_hash_blake3_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_blake3_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_blake3_vector_dist(a : Cryptohashblake3Vector, b : Cryptohashblake3Vector) -> Double {
  crypto_hash_blake3_vector_norm(crypto_hash_blake3_vector_sub(a, b))
}

pub fn crypto_hash_blake3_vector_to_string(v : Cryptohashblake3Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_blake3_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_blake3_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_blake3_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_blake3_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_blake3_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_blake3_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_blake3_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_blake3_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_blake3_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_blake3_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_blake3_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_blake3_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_blake3_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_blake3_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_blake3_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_blake3_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_blake3_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_blake3_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_blake3_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_blake3_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_blake3_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_blake3_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_blake3_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_blake3_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_blake3_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_blake3_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_blake3_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_blake3_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_blake3_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashblake3Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_frame_make(size : Int) -> Cryptohashblake3Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_frame_len(s : Cryptohashblake3Frame) -> Int { s.size }

pub fn crypto_hash_blake3_frame_get(s : Cryptohashblake3Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_frame_set(s : Cryptohashblake3Frame, i : Int, v : Double) -> Cryptohashblake3Frame {
  let result = crypto_hash_blake3_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_frame_sum(s : Cryptohashblake3Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_frame_mean(s : Cryptohashblake3Frame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_frame_scale(s : Cryptohashblake3Frame, f : Double) -> Cryptohashblake3Frame {
  let result = crypto_hash_blake3_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_frame_add(a : Cryptohashblake3Frame, b : Cryptohashblake3Frame) -> Cryptohashblake3Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_frame_copy(s : Cryptohashblake3Frame) -> Cryptohashblake3Frame {
  let result = crypto_hash_blake3_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_frame_fill(s : Cryptohashblake3Frame, v : Double) -> Cryptohashblake3Frame {
  let result = crypto_hash_blake3_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_frame_min(s : Cryptohashblake3Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_frame_max(s : Cryptohashblake3Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_frame_to_string(s : Cryptohashblake3Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_table_make(size : Int) -> Cryptohashblake3Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_table_len(s : Cryptohashblake3Table) -> Int { s.size }

pub fn crypto_hash_blake3_table_get(s : Cryptohashblake3Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_table_set(s : Cryptohashblake3Table, i : Int, v : Double) -> Cryptohashblake3Table {
  let result = crypto_hash_blake3_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_table_sum(s : Cryptohashblake3Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_table_mean(s : Cryptohashblake3Table) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_table_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_table_scale(s : Cryptohashblake3Table, f : Double) -> Cryptohashblake3Table {
  let result = crypto_hash_blake3_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_table_add(a : Cryptohashblake3Table, b : Cryptohashblake3Table) -> Cryptohashblake3Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_table_copy(s : Cryptohashblake3Table) -> Cryptohashblake3Table {
  let result = crypto_hash_blake3_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_table_fill(s : Cryptohashblake3Table, v : Double) -> Cryptohashblake3Table {
  let result = crypto_hash_blake3_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_table_min(s : Cryptohashblake3Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_table_max(s : Cryptohashblake3Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_table_to_string(s : Cryptohashblake3Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_graphn_make(size : Int) -> Cryptohashblake3GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_graphn_len(s : Cryptohashblake3GraphN) -> Int { s.size }

pub fn crypto_hash_blake3_graphn_get(s : Cryptohashblake3GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_graphn_set(s : Cryptohashblake3GraphN, i : Int, v : Double) -> Cryptohashblake3GraphN {
  let result = crypto_hash_blake3_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_graphn_sum(s : Cryptohashblake3GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_graphn_mean(s : Cryptohashblake3GraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_graphn_scale(s : Cryptohashblake3GraphN, f : Double) -> Cryptohashblake3GraphN {
  let result = crypto_hash_blake3_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_graphn_add(a : Cryptohashblake3GraphN, b : Cryptohashblake3GraphN) -> Cryptohashblake3GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_graphn_copy(s : Cryptohashblake3GraphN) -> Cryptohashblake3GraphN {
  let result = crypto_hash_blake3_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_graphn_fill(s : Cryptohashblake3GraphN, v : Double) -> Cryptohashblake3GraphN {
  let result = crypto_hash_blake3_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_graphn_min(s : Cryptohashblake3GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_graphn_max(s : Cryptohashblake3GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_graphn_to_string(s : Cryptohashblake3GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_node_make(size : Int) -> Cryptohashblake3Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_node_len(s : Cryptohashblake3Node) -> Int { s.size }

pub fn crypto_hash_blake3_node_get(s : Cryptohashblake3Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_node_set(s : Cryptohashblake3Node, i : Int, v : Double) -> Cryptohashblake3Node {
  let result = crypto_hash_blake3_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_node_sum(s : Cryptohashblake3Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_node_mean(s : Cryptohashblake3Node) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_node_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_node_scale(s : Cryptohashblake3Node, f : Double) -> Cryptohashblake3Node {
  let result = crypto_hash_blake3_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_node_add(a : Cryptohashblake3Node, b : Cryptohashblake3Node) -> Cryptohashblake3Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_node_copy(s : Cryptohashblake3Node) -> Cryptohashblake3Node {
  let result = crypto_hash_blake3_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_node_fill(s : Cryptohashblake3Node, v : Double) -> Cryptohashblake3Node {
  let result = crypto_hash_blake3_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_node_min(s : Cryptohashblake3Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_node_max(s : Cryptohashblake3Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_node_to_string(s : Cryptohashblake3Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_edge_make(size : Int) -> Cryptohashblake3Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_edge_len(s : Cryptohashblake3Edge) -> Int { s.size }

pub fn crypto_hash_blake3_edge_get(s : Cryptohashblake3Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_edge_set(s : Cryptohashblake3Edge, i : Int, v : Double) -> Cryptohashblake3Edge {
  let result = crypto_hash_blake3_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_edge_sum(s : Cryptohashblake3Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_edge_mean(s : Cryptohashblake3Edge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_edge_scale(s : Cryptohashblake3Edge, f : Double) -> Cryptohashblake3Edge {
  let result = crypto_hash_blake3_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_edge_add(a : Cryptohashblake3Edge, b : Cryptohashblake3Edge) -> Cryptohashblake3Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_edge_copy(s : Cryptohashblake3Edge) -> Cryptohashblake3Edge {
  let result = crypto_hash_blake3_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_edge_fill(s : Cryptohashblake3Edge, v : Double) -> Cryptohashblake3Edge {
  let result = crypto_hash_blake3_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_edge_min(s : Cryptohashblake3Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_edge_max(s : Cryptohashblake3Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_edge_to_string(s : Cryptohashblake3Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_path_make(size : Int) -> Cryptohashblake3Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_path_len(s : Cryptohashblake3Path) -> Int { s.size }

pub fn crypto_hash_blake3_path_get(s : Cryptohashblake3Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_path_set(s : Cryptohashblake3Path, i : Int, v : Double) -> Cryptohashblake3Path {
  let result = crypto_hash_blake3_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_path_sum(s : Cryptohashblake3Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_path_mean(s : Cryptohashblake3Path) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_path_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_path_scale(s : Cryptohashblake3Path, f : Double) -> Cryptohashblake3Path {
  let result = crypto_hash_blake3_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_path_add(a : Cryptohashblake3Path, b : Cryptohashblake3Path) -> Cryptohashblake3Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_path_copy(s : Cryptohashblake3Path) -> Cryptohashblake3Path {
  let result = crypto_hash_blake3_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_path_fill(s : Cryptohashblake3Path, v : Double) -> Cryptohashblake3Path {
  let result = crypto_hash_blake3_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_path_min(s : Cryptohashblake3Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_path_max(s : Cryptohashblake3Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_path_to_string(s : Cryptohashblake3Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_cluster_make(size : Int) -> Cryptohashblake3Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_cluster_len(s : Cryptohashblake3Cluster) -> Int { s.size }

pub fn crypto_hash_blake3_cluster_get(s : Cryptohashblake3Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_cluster_set(s : Cryptohashblake3Cluster, i : Int, v : Double) -> Cryptohashblake3Cluster {
  let result = crypto_hash_blake3_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_cluster_sum(s : Cryptohashblake3Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_cluster_mean(s : Cryptohashblake3Cluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_cluster_scale(s : Cryptohashblake3Cluster, f : Double) -> Cryptohashblake3Cluster {
  let result = crypto_hash_blake3_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_cluster_add(a : Cryptohashblake3Cluster, b : Cryptohashblake3Cluster) -> Cryptohashblake3Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_cluster_copy(s : Cryptohashblake3Cluster) -> Cryptohashblake3Cluster {
  let result = crypto_hash_blake3_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_cluster_fill(s : Cryptohashblake3Cluster, v : Double) -> Cryptohashblake3Cluster {
  let result = crypto_hash_blake3_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_cluster_min(s : Cryptohashblake3Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_cluster_max(s : Cryptohashblake3Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_cluster_to_string(s : Cryptohashblake3Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_model_make(size : Int) -> Cryptohashblake3Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_model_len(s : Cryptohashblake3Model) -> Int { s.size }

pub fn crypto_hash_blake3_model_get(s : Cryptohashblake3Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_model_set(s : Cryptohashblake3Model, i : Int, v : Double) -> Cryptohashblake3Model {
  let result = crypto_hash_blake3_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_model_sum(s : Cryptohashblake3Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_model_mean(s : Cryptohashblake3Model) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_model_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_model_scale(s : Cryptohashblake3Model, f : Double) -> Cryptohashblake3Model {
  let result = crypto_hash_blake3_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_model_add(a : Cryptohashblake3Model, b : Cryptohashblake3Model) -> Cryptohashblake3Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_model_copy(s : Cryptohashblake3Model) -> Cryptohashblake3Model {
  let result = crypto_hash_blake3_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_model_fill(s : Cryptohashblake3Model, v : Double) -> Cryptohashblake3Model {
  let result = crypto_hash_blake3_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_model_min(s : Cryptohashblake3Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_model_max(s : Cryptohashblake3Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_model_to_string(s : Cryptohashblake3Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_layer_make(size : Int) -> Cryptohashblake3Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_layer_len(s : Cryptohashblake3Layer) -> Int { s.size }

pub fn crypto_hash_blake3_layer_get(s : Cryptohashblake3Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_layer_set(s : Cryptohashblake3Layer, i : Int, v : Double) -> Cryptohashblake3Layer {
  let result = crypto_hash_blake3_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_layer_sum(s : Cryptohashblake3Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_layer_mean(s : Cryptohashblake3Layer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_layer_scale(s : Cryptohashblake3Layer, f : Double) -> Cryptohashblake3Layer {
  let result = crypto_hash_blake3_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_layer_add(a : Cryptohashblake3Layer, b : Cryptohashblake3Layer) -> Cryptohashblake3Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_layer_copy(s : Cryptohashblake3Layer) -> Cryptohashblake3Layer {
  let result = crypto_hash_blake3_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_layer_fill(s : Cryptohashblake3Layer, v : Double) -> Cryptohashblake3Layer {
  let result = crypto_hash_blake3_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_layer_min(s : Cryptohashblake3Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_layer_max(s : Cryptohashblake3Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_layer_to_string(s : Cryptohashblake3Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_buffer_make(size : Int) -> Cryptohashblake3Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_buffer_len(s : Cryptohashblake3Buffer) -> Int { s.size }

pub fn crypto_hash_blake3_buffer_get(s : Cryptohashblake3Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_buffer_set(s : Cryptohashblake3Buffer, i : Int, v : Double) -> Cryptohashblake3Buffer {
  let result = crypto_hash_blake3_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_buffer_sum(s : Cryptohashblake3Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_buffer_mean(s : Cryptohashblake3Buffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_buffer_scale(s : Cryptohashblake3Buffer, f : Double) -> Cryptohashblake3Buffer {
  let result = crypto_hash_blake3_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_buffer_add(a : Cryptohashblake3Buffer, b : Cryptohashblake3Buffer) -> Cryptohashblake3Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_buffer_copy(s : Cryptohashblake3Buffer) -> Cryptohashblake3Buffer {
  let result = crypto_hash_blake3_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_buffer_fill(s : Cryptohashblake3Buffer, v : Double) -> Cryptohashblake3Buffer {
  let result = crypto_hash_blake3_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_buffer_min(s : Cryptohashblake3Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_buffer_max(s : Cryptohashblake3Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_buffer_to_string(s : Cryptohashblake3Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_cursor_make(size : Int) -> Cryptohashblake3Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_cursor_len(s : Cryptohashblake3Cursor) -> Int { s.size }

pub fn crypto_hash_blake3_cursor_get(s : Cryptohashblake3Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_cursor_set(s : Cryptohashblake3Cursor, i : Int, v : Double) -> Cryptohashblake3Cursor {
  let result = crypto_hash_blake3_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_cursor_sum(s : Cryptohashblake3Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_cursor_mean(s : Cryptohashblake3Cursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_cursor_scale(s : Cryptohashblake3Cursor, f : Double) -> Cryptohashblake3Cursor {
  let result = crypto_hash_blake3_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_cursor_add(a : Cryptohashblake3Cursor, b : Cryptohashblake3Cursor) -> Cryptohashblake3Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_cursor_copy(s : Cryptohashblake3Cursor) -> Cryptohashblake3Cursor {
  let result = crypto_hash_blake3_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_cursor_fill(s : Cryptohashblake3Cursor, v : Double) -> Cryptohashblake3Cursor {
  let result = crypto_hash_blake3_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_cursor_min(s : Cryptohashblake3Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_cursor_max(s : Cryptohashblake3Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_cursor_to_string(s : Cryptohashblake3Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_view_make(size : Int) -> Cryptohashblake3View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_view_len(s : Cryptohashblake3View) -> Int { s.size }

pub fn crypto_hash_blake3_view_get(s : Cryptohashblake3View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_view_set(s : Cryptohashblake3View, i : Int, v : Double) -> Cryptohashblake3View {
  let result = crypto_hash_blake3_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_view_sum(s : Cryptohashblake3View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_view_mean(s : Cryptohashblake3View) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_view_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_view_scale(s : Cryptohashblake3View, f : Double) -> Cryptohashblake3View {
  let result = crypto_hash_blake3_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_view_add(a : Cryptohashblake3View, b : Cryptohashblake3View) -> Cryptohashblake3View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_view_copy(s : Cryptohashblake3View) -> Cryptohashblake3View {
  let result = crypto_hash_blake3_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_view_fill(s : Cryptohashblake3View, v : Double) -> Cryptohashblake3View {
  let result = crypto_hash_blake3_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_view_min(s : Cryptohashblake3View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_view_max(s : Cryptohashblake3View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_view_to_string(s : Cryptohashblake3View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_range_make(size : Int) -> Cryptohashblake3Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_range_len(s : Cryptohashblake3Range) -> Int { s.size }

pub fn crypto_hash_blake3_range_get(s : Cryptohashblake3Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_range_set(s : Cryptohashblake3Range, i : Int, v : Double) -> Cryptohashblake3Range {
  let result = crypto_hash_blake3_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_range_sum(s : Cryptohashblake3Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_range_mean(s : Cryptohashblake3Range) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_range_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_range_scale(s : Cryptohashblake3Range, f : Double) -> Cryptohashblake3Range {
  let result = crypto_hash_blake3_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_range_add(a : Cryptohashblake3Range, b : Cryptohashblake3Range) -> Cryptohashblake3Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_range_copy(s : Cryptohashblake3Range) -> Cryptohashblake3Range {
  let result = crypto_hash_blake3_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_range_fill(s : Cryptohashblake3Range, v : Double) -> Cryptohashblake3Range {
  let result = crypto_hash_blake3_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_range_min(s : Cryptohashblake3Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_range_max(s : Cryptohashblake3Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_range_to_string(s : Cryptohashblake3Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_slice_make(size : Int) -> Cryptohashblake3Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_slice_len(s : Cryptohashblake3Slice) -> Int { s.size }

pub fn crypto_hash_blake3_slice_get(s : Cryptohashblake3Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_slice_set(s : Cryptohashblake3Slice, i : Int, v : Double) -> Cryptohashblake3Slice {
  let result = crypto_hash_blake3_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_slice_sum(s : Cryptohashblake3Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_hash_blake3_slice_mean(s : Cryptohashblake3Slice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_hash_blake3_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_hash_blake3_slice_scale(s : Cryptohashblake3Slice, f : Double) -> Cryptohashblake3Slice {
  let result = crypto_hash_blake3_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_blake3_slice_add(a : Cryptohashblake3Slice, b : Cryptohashblake3Slice) -> Cryptohashblake3Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_blake3_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_blake3_slice_copy(s : Cryptohashblake3Slice) -> Cryptohashblake3Slice {
  let result = crypto_hash_blake3_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_blake3_slice_fill(s : Cryptohashblake3Slice, v : Double) -> Cryptohashblake3Slice {
  let result = crypto_hash_blake3_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake3_slice_min(s : Cryptohashblake3Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_slice_max(s : Cryptohashblake3Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_hash_blake3_slice_to_string(s : Cryptohashblake3Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

