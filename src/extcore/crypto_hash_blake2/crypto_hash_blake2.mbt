///===
/// extcore/crypto_hash_blake2

pub(all) struct Cryptohashblake2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_blake2_make_point(x : Double, y : Double) -> Cryptohashblake2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_blake2_make_point3(x : Double, y : Double, z : Double) -> Cryptohashblake2Point {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_blake2_point_x(pt : Cryptohashblake2Point) -> Double { pt.x }

pub fn crypto_hash_blake2_point_y(pt : Cryptohashblake2Point) -> Double { pt.y }

pub fn crypto_hash_blake2_point_z(pt : Cryptohashblake2Point) -> Double { pt.z }

pub fn crypto_hash_blake2_point_label(pt : Cryptohashblake2Point) -> Int { pt.label }

pub fn crypto_hash_blake2_point_dist(a : Cryptohashblake2Point, b : Cryptohashblake2Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_blake2_point_add(a : Cryptohashblake2Point, b : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_blake2_point_sub(a : Cryptohashblake2Point, b : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_blake2_point_scale(pt : Cryptohashblake2Point, s : Double) -> Cryptohashblake2Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_blake2_point_dot(a : Cryptohashblake2Point, b : Cryptohashblake2Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_blake2_point_cross(a : Cryptohashblake2Point, b : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_blake2_point_norm(pt : Cryptohashblake2Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_blake2_point_normalize(pt : Cryptohashblake2Point) -> Cryptohashblake2Point {
  let n = crypto_hash_blake2_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_blake2_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_blake2_point_negate(pt : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_blake2_point_mid(a : Cryptohashblake2Point, b : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_blake2_point_lerp(a : Cryptohashblake2Point, b : Cryptohashblake2Point, t : Double) -> Cryptohashblake2Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_blake2_point_to_string(pt : Cryptohashblake2Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptohashblake2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_blake2_make_series(vals : Array[Double], name : String) -> Cryptohashblake2Series {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_blake2_series_len(s : Cryptohashblake2Series) -> Int { s.vals.length() }

pub fn crypto_hash_blake2_series_sum(s : Cryptohashblake2Series) -> Double { @_common.sum(s.vals) }

pub fn crypto_hash_blake2_series_mean(s : Cryptohashblake2Series) -> Double { @_common.mean(s.vals) }

pub fn crypto_hash_blake2_series_min(s : Cryptohashblake2Series) -> Double { @_common.min(s.vals) }

pub fn crypto_hash_blake2_series_max(s : Cryptohashblake2Series) -> Double { @_common.max(s.vals) }

pub fn crypto_hash_blake2_series_range(s : Cryptohashblake2Series) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_hash_blake2_series_var(s : Cryptohashblake2Series) -> Double { @_common.variance(s.vals) }

pub fn crypto_hash_blake2_series_std(s : Cryptohashblake2Series) -> Double { @_common.std(s.vals) }

pub fn crypto_hash_blake2_series_median(s : Cryptohashblake2Series) -> Double { @_common.median(s.vals) }

pub fn crypto_hash_blake2_series_scale(s : Cryptohashblake2Series, f : Double) -> Cryptohashblake2Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_blake2_series_add(a : Cryptohashblake2Series, b : Cryptohashblake2Series) -> Cryptohashblake2Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_blake2_series_sub(a : Cryptohashblake2Series, b : Cryptohashblake2Series) -> Cryptohashblake2Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_blake2_series_normalize(s : Cryptohashblake2Series) -> Cryptohashblake2Series {
  let mn = crypto_hash_blake2_series_min(s)
  let mx = crypto_hash_blake2_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_blake2_series_cumsum(s : Cryptohashblake2Series) -> Cryptohashblake2Series {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_blake2_series_to_string(s : Cryptohashblake2Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashblake2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_blake2_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashblake2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_blake2_matrix_identity(n : Int) -> Cryptohashblake2Matrix {
  let m = crypto_hash_blake2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_blake2_matrix_get(m : Cryptohashblake2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_blake2_matrix_transpose(m : Cryptohashblake2Matrix) -> Cryptohashblake2Matrix {
  let result = crypto_hash_blake2_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_blake2_matrix_add(a : Cryptohashblake2Matrix, b : Cryptohashblake2Matrix) -> Cryptohashblake2Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_blake2_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_blake2_matrix_scale(m : Cryptohashblake2Matrix, s : Double) -> Cryptohashblake2Matrix {
  let result = crypto_hash_blake2_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_blake2_matrix_multiply(a : Cryptohashblake2Matrix, b : Cryptohashblake2Matrix) -> Cryptohashblake2Matrix {
  if a.cols != b.rows { return crypto_hash_blake2_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_blake2_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_blake2_matrix_trace(m : Cryptohashblake2Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_blake2_matrix_det(m : Cryptohashblake2Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_blake2_matrix_norm(m : Cryptohashblake2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_blake2_matrix_to_string(m : Cryptohashblake2Matrix) -> String {
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

pub(all) struct Cryptohashblake2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_blake2_make_vector(comps : Array[Double]) -> Cryptohashblake2Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_blake2_vector_zero(dim : Int) -> Cryptohashblake2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_blake2_vector_add(a : Cryptohashblake2Vector, b : Cryptohashblake2Vector) -> Cryptohashblake2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_blake2_vector_sub(a : Cryptohashblake2Vector, b : Cryptohashblake2Vector) -> Cryptohashblake2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_blake2_vector_scale(v : Cryptohashblake2Vector, s : Double) -> Cryptohashblake2Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_blake2_vector_dot(a : Cryptohashblake2Vector, b : Cryptohashblake2Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_blake2_vector_norm(v : Cryptohashblake2Vector) -> Double { @_common.sqrt(crypto_hash_blake2_vector_dot(v, v)) }

pub fn crypto_hash_blake2_vector_normalize(v : Cryptohashblake2Vector) -> Cryptohashblake2Vector {
  let n = crypto_hash_blake2_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_blake2_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_blake2_vector_dist(a : Cryptohashblake2Vector, b : Cryptohashblake2Vector) -> Double {
  crypto_hash_blake2_vector_norm(crypto_hash_blake2_vector_sub(a, b))
}

pub fn crypto_hash_blake2_vector_to_string(v : Cryptohashblake2Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_blake2_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_blake2_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_blake2_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_blake2_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_blake2_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_blake2_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_blake2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_blake2_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_blake2_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_blake2_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_blake2_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_blake2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_blake2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_blake2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_blake2_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_blake2_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_blake2_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_blake2_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_blake2_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_blake2_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_blake2_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_blake2_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_blake2_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_blake2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_blake2_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_blake2_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_blake2_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_blake2_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_blake2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashblake2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_frame_make(size : Int) -> Cryptohashblake2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_frame_len(s : Cryptohashblake2Frame) -> Int { s.size }

pub fn crypto_hash_blake2_frame_get(s : Cryptohashblake2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_frame_set(s : Cryptohashblake2Frame, i : Int, v : Double) -> Cryptohashblake2Frame {
  let result = crypto_hash_blake2_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_frame_sum(s : Cryptohashblake2Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_frame_mean(s : Cryptohashblake2Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_frame_scale(s : Cryptohashblake2Frame, f : Double) -> Cryptohashblake2Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_frame_add(a : Cryptohashblake2Frame, b : Cryptohashblake2Frame) -> Cryptohashblake2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_frame_copy(s : Cryptohashblake2Frame) -> Cryptohashblake2Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_frame_fill(s : Cryptohashblake2Frame, v : Double) -> Cryptohashblake2Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_frame_min(s : Cryptohashblake2Frame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_frame_max(s : Cryptohashblake2Frame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_frame_to_string(s : Cryptohashblake2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_table_make(size : Int) -> Cryptohashblake2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_table_len(s : Cryptohashblake2Table) -> Int { s.size }

pub fn crypto_hash_blake2_table_get(s : Cryptohashblake2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_table_set(s : Cryptohashblake2Table, i : Int, v : Double) -> Cryptohashblake2Table {
  let result = crypto_hash_blake2_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_table_sum(s : Cryptohashblake2Table) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_table_mean(s : Cryptohashblake2Table) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_table_scale(s : Cryptohashblake2Table, f : Double) -> Cryptohashblake2Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_table_add(a : Cryptohashblake2Table, b : Cryptohashblake2Table) -> Cryptohashblake2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_table_copy(s : Cryptohashblake2Table) -> Cryptohashblake2Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_table_fill(s : Cryptohashblake2Table, v : Double) -> Cryptohashblake2Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_table_min(s : Cryptohashblake2Table) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_table_max(s : Cryptohashblake2Table) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_table_to_string(s : Cryptohashblake2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_graphn_make(size : Int) -> Cryptohashblake2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_graphn_len(s : Cryptohashblake2GraphN) -> Int { s.size }

pub fn crypto_hash_blake2_graphn_get(s : Cryptohashblake2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_graphn_set(s : Cryptohashblake2GraphN, i : Int, v : Double) -> Cryptohashblake2GraphN {
  let result = crypto_hash_blake2_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_graphn_sum(s : Cryptohashblake2GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_graphn_mean(s : Cryptohashblake2GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_graphn_scale(s : Cryptohashblake2GraphN, f : Double) -> Cryptohashblake2GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_graphn_add(a : Cryptohashblake2GraphN, b : Cryptohashblake2GraphN) -> Cryptohashblake2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_graphn_copy(s : Cryptohashblake2GraphN) -> Cryptohashblake2GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_graphn_fill(s : Cryptohashblake2GraphN, v : Double) -> Cryptohashblake2GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_graphn_min(s : Cryptohashblake2GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_graphn_max(s : Cryptohashblake2GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_graphn_to_string(s : Cryptohashblake2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_node_make(size : Int) -> Cryptohashblake2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_node_len(s : Cryptohashblake2Node) -> Int { s.size }

pub fn crypto_hash_blake2_node_get(s : Cryptohashblake2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_node_set(s : Cryptohashblake2Node, i : Int, v : Double) -> Cryptohashblake2Node {
  let result = crypto_hash_blake2_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_node_sum(s : Cryptohashblake2Node) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_node_mean(s : Cryptohashblake2Node) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_node_scale(s : Cryptohashblake2Node, f : Double) -> Cryptohashblake2Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_node_add(a : Cryptohashblake2Node, b : Cryptohashblake2Node) -> Cryptohashblake2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_node_copy(s : Cryptohashblake2Node) -> Cryptohashblake2Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_node_fill(s : Cryptohashblake2Node, v : Double) -> Cryptohashblake2Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_node_min(s : Cryptohashblake2Node) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_node_max(s : Cryptohashblake2Node) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_node_to_string(s : Cryptohashblake2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_edge_make(size : Int) -> Cryptohashblake2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_edge_len(s : Cryptohashblake2Edge) -> Int { s.size }

pub fn crypto_hash_blake2_edge_get(s : Cryptohashblake2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_edge_set(s : Cryptohashblake2Edge, i : Int, v : Double) -> Cryptohashblake2Edge {
  let result = crypto_hash_blake2_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_edge_sum(s : Cryptohashblake2Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_edge_mean(s : Cryptohashblake2Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_edge_scale(s : Cryptohashblake2Edge, f : Double) -> Cryptohashblake2Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_edge_add(a : Cryptohashblake2Edge, b : Cryptohashblake2Edge) -> Cryptohashblake2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_edge_copy(s : Cryptohashblake2Edge) -> Cryptohashblake2Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_edge_fill(s : Cryptohashblake2Edge, v : Double) -> Cryptohashblake2Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_edge_min(s : Cryptohashblake2Edge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_edge_max(s : Cryptohashblake2Edge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_edge_to_string(s : Cryptohashblake2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_path_make(size : Int) -> Cryptohashblake2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_path_len(s : Cryptohashblake2Path) -> Int { s.size }

pub fn crypto_hash_blake2_path_get(s : Cryptohashblake2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_path_set(s : Cryptohashblake2Path, i : Int, v : Double) -> Cryptohashblake2Path {
  let result = crypto_hash_blake2_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_path_sum(s : Cryptohashblake2Path) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_path_mean(s : Cryptohashblake2Path) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_path_scale(s : Cryptohashblake2Path, f : Double) -> Cryptohashblake2Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_path_add(a : Cryptohashblake2Path, b : Cryptohashblake2Path) -> Cryptohashblake2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_path_copy(s : Cryptohashblake2Path) -> Cryptohashblake2Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_path_fill(s : Cryptohashblake2Path, v : Double) -> Cryptohashblake2Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_path_min(s : Cryptohashblake2Path) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_path_max(s : Cryptohashblake2Path) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_path_to_string(s : Cryptohashblake2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_cluster_make(size : Int) -> Cryptohashblake2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_cluster_len(s : Cryptohashblake2Cluster) -> Int { s.size }

pub fn crypto_hash_blake2_cluster_get(s : Cryptohashblake2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_cluster_set(s : Cryptohashblake2Cluster, i : Int, v : Double) -> Cryptohashblake2Cluster {
  let result = crypto_hash_blake2_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_cluster_sum(s : Cryptohashblake2Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_cluster_mean(s : Cryptohashblake2Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_cluster_scale(s : Cryptohashblake2Cluster, f : Double) -> Cryptohashblake2Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cluster_add(a : Cryptohashblake2Cluster, b : Cryptohashblake2Cluster) -> Cryptohashblake2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_cluster_copy(s : Cryptohashblake2Cluster) -> Cryptohashblake2Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cluster_fill(s : Cryptohashblake2Cluster, v : Double) -> Cryptohashblake2Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cluster_min(s : Cryptohashblake2Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_cluster_max(s : Cryptohashblake2Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_cluster_to_string(s : Cryptohashblake2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_model_make(size : Int) -> Cryptohashblake2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_model_len(s : Cryptohashblake2Model) -> Int { s.size }

pub fn crypto_hash_blake2_model_get(s : Cryptohashblake2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_model_set(s : Cryptohashblake2Model, i : Int, v : Double) -> Cryptohashblake2Model {
  let result = crypto_hash_blake2_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_model_sum(s : Cryptohashblake2Model) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_model_mean(s : Cryptohashblake2Model) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_model_scale(s : Cryptohashblake2Model, f : Double) -> Cryptohashblake2Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_model_add(a : Cryptohashblake2Model, b : Cryptohashblake2Model) -> Cryptohashblake2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_model_copy(s : Cryptohashblake2Model) -> Cryptohashblake2Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_model_fill(s : Cryptohashblake2Model, v : Double) -> Cryptohashblake2Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_model_min(s : Cryptohashblake2Model) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_model_max(s : Cryptohashblake2Model) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_model_to_string(s : Cryptohashblake2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_layer_make(size : Int) -> Cryptohashblake2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_layer_len(s : Cryptohashblake2Layer) -> Int { s.size }

pub fn crypto_hash_blake2_layer_get(s : Cryptohashblake2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_layer_set(s : Cryptohashblake2Layer, i : Int, v : Double) -> Cryptohashblake2Layer {
  let result = crypto_hash_blake2_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_layer_sum(s : Cryptohashblake2Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_layer_mean(s : Cryptohashblake2Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_layer_scale(s : Cryptohashblake2Layer, f : Double) -> Cryptohashblake2Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_layer_add(a : Cryptohashblake2Layer, b : Cryptohashblake2Layer) -> Cryptohashblake2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_layer_copy(s : Cryptohashblake2Layer) -> Cryptohashblake2Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_layer_fill(s : Cryptohashblake2Layer, v : Double) -> Cryptohashblake2Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_layer_min(s : Cryptohashblake2Layer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_layer_max(s : Cryptohashblake2Layer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_layer_to_string(s : Cryptohashblake2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_buffer_make(size : Int) -> Cryptohashblake2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_buffer_len(s : Cryptohashblake2Buffer) -> Int { s.size }

pub fn crypto_hash_blake2_buffer_get(s : Cryptohashblake2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_buffer_set(s : Cryptohashblake2Buffer, i : Int, v : Double) -> Cryptohashblake2Buffer {
  let result = crypto_hash_blake2_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_buffer_sum(s : Cryptohashblake2Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_buffer_mean(s : Cryptohashblake2Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_buffer_scale(s : Cryptohashblake2Buffer, f : Double) -> Cryptohashblake2Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_buffer_add(a : Cryptohashblake2Buffer, b : Cryptohashblake2Buffer) -> Cryptohashblake2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_buffer_copy(s : Cryptohashblake2Buffer) -> Cryptohashblake2Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_buffer_fill(s : Cryptohashblake2Buffer, v : Double) -> Cryptohashblake2Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_buffer_min(s : Cryptohashblake2Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_buffer_max(s : Cryptohashblake2Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_buffer_to_string(s : Cryptohashblake2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_cursor_make(size : Int) -> Cryptohashblake2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_cursor_len(s : Cryptohashblake2Cursor) -> Int { s.size }

pub fn crypto_hash_blake2_cursor_get(s : Cryptohashblake2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_cursor_set(s : Cryptohashblake2Cursor, i : Int, v : Double) -> Cryptohashblake2Cursor {
  let result = crypto_hash_blake2_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_cursor_sum(s : Cryptohashblake2Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_cursor_mean(s : Cryptohashblake2Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_cursor_scale(s : Cryptohashblake2Cursor, f : Double) -> Cryptohashblake2Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cursor_add(a : Cryptohashblake2Cursor, b : Cryptohashblake2Cursor) -> Cryptohashblake2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_cursor_copy(s : Cryptohashblake2Cursor) -> Cryptohashblake2Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cursor_fill(s : Cryptohashblake2Cursor, v : Double) -> Cryptohashblake2Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cursor_min(s : Cryptohashblake2Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_cursor_max(s : Cryptohashblake2Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_cursor_to_string(s : Cryptohashblake2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_view_make(size : Int) -> Cryptohashblake2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_view_len(s : Cryptohashblake2View) -> Int { s.size }

pub fn crypto_hash_blake2_view_get(s : Cryptohashblake2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_view_set(s : Cryptohashblake2View, i : Int, v : Double) -> Cryptohashblake2View {
  let result = crypto_hash_blake2_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_view_sum(s : Cryptohashblake2View) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_view_mean(s : Cryptohashblake2View) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_view_scale(s : Cryptohashblake2View, f : Double) -> Cryptohashblake2View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_view_add(a : Cryptohashblake2View, b : Cryptohashblake2View) -> Cryptohashblake2View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_view_copy(s : Cryptohashblake2View) -> Cryptohashblake2View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_view_fill(s : Cryptohashblake2View, v : Double) -> Cryptohashblake2View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_view_min(s : Cryptohashblake2View) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_view_max(s : Cryptohashblake2View) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_view_to_string(s : Cryptohashblake2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_range_make(size : Int) -> Cryptohashblake2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_range_len(s : Cryptohashblake2Range) -> Int { s.size }

pub fn crypto_hash_blake2_range_get(s : Cryptohashblake2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_range_set(s : Cryptohashblake2Range, i : Int, v : Double) -> Cryptohashblake2Range {
  let result = crypto_hash_blake2_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_range_sum(s : Cryptohashblake2Range) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_range_mean(s : Cryptohashblake2Range) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_range_scale(s : Cryptohashblake2Range, f : Double) -> Cryptohashblake2Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_range_add(a : Cryptohashblake2Range, b : Cryptohashblake2Range) -> Cryptohashblake2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_range_copy(s : Cryptohashblake2Range) -> Cryptohashblake2Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_range_fill(s : Cryptohashblake2Range, v : Double) -> Cryptohashblake2Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_range_min(s : Cryptohashblake2Range) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_range_max(s : Cryptohashblake2Range) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_range_to_string(s : Cryptohashblake2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_slice_make(size : Int) -> Cryptohashblake2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_slice_len(s : Cryptohashblake2Slice) -> Int { s.size }

pub fn crypto_hash_blake2_slice_get(s : Cryptohashblake2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_slice_set(s : Cryptohashblake2Slice, i : Int, v : Double) -> Cryptohashblake2Slice {
  let result = crypto_hash_blake2_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_blake2_slice_sum(s : Cryptohashblake2Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_slice_mean(s : Cryptohashblake2Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_slice_scale(s : Cryptohashblake2Slice, f : Double) -> Cryptohashblake2Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_slice_add(a : Cryptohashblake2Slice, b : Cryptohashblake2Slice) -> Cryptohashblake2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_slice_copy(s : Cryptohashblake2Slice) -> Cryptohashblake2Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_slice_fill(s : Cryptohashblake2Slice, v : Double) -> Cryptohashblake2Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_slice_min(s : Cryptohashblake2Slice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_slice_max(s : Cryptohashblake2Slice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_slice_to_string(s : Cryptohashblake2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

