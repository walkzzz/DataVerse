///===
/// extcore/crypto_hash_whirlpool

pub(all) struct CryptohashwhirlpoolPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_whirlpool_make_point(x : Double, y : Double) -> CryptohashwhirlpoolPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_whirlpool_make_point3(x : Double, y : Double, z : Double) -> CryptohashwhirlpoolPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_whirlpool_point_x(pt : CryptohashwhirlpoolPoint) -> Double { pt.x }

pub fn crypto_hash_whirlpool_point_y(pt : CryptohashwhirlpoolPoint) -> Double { pt.y }

pub fn crypto_hash_whirlpool_point_z(pt : CryptohashwhirlpoolPoint) -> Double { pt.z }

pub fn crypto_hash_whirlpool_point_label(pt : CryptohashwhirlpoolPoint) -> Int { pt.label }

pub fn crypto_hash_whirlpool_point_dist(a : CryptohashwhirlpoolPoint, b : CryptohashwhirlpoolPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_whirlpool_point_add(a : CryptohashwhirlpoolPoint, b : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_whirlpool_point_sub(a : CryptohashwhirlpoolPoint, b : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_whirlpool_point_scale(pt : CryptohashwhirlpoolPoint, s : Double) -> CryptohashwhirlpoolPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_whirlpool_point_dot(a : CryptohashwhirlpoolPoint, b : CryptohashwhirlpoolPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_whirlpool_point_cross(a : CryptohashwhirlpoolPoint, b : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_whirlpool_point_norm(pt : CryptohashwhirlpoolPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_whirlpool_point_normalize(pt : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  let n = crypto_hash_whirlpool_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_whirlpool_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_whirlpool_point_negate(pt : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_whirlpool_point_mid(a : CryptohashwhirlpoolPoint, b : CryptohashwhirlpoolPoint) -> CryptohashwhirlpoolPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_whirlpool_point_lerp(a : CryptohashwhirlpoolPoint, b : CryptohashwhirlpoolPoint, t : Double) -> CryptohashwhirlpoolPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_whirlpool_point_to_string(pt : CryptohashwhirlpoolPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_whirlpool_make_series(vals : Array[Double], name : String) -> CryptohashwhirlpoolSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_whirlpool_series_len(s : CryptohashwhirlpoolSeries) -> Int { s.vals.length() }

pub fn crypto_hash_whirlpool_series_sum(s : CryptohashwhirlpoolSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_hash_whirlpool_series_mean(s : CryptohashwhirlpoolSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_hash_whirlpool_series_min(s : CryptohashwhirlpoolSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_hash_whirlpool_series_max(s : CryptohashwhirlpoolSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_hash_whirlpool_series_range(s : CryptohashwhirlpoolSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_hash_whirlpool_series_var(s : CryptohashwhirlpoolSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_hash_whirlpool_series_std(s : CryptohashwhirlpoolSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_hash_whirlpool_series_median(s : CryptohashwhirlpoolSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_hash_whirlpool_series_scale(s : CryptohashwhirlpoolSeries, f : Double) -> CryptohashwhirlpoolSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_whirlpool_series_add(a : CryptohashwhirlpoolSeries, b : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_whirlpool_series_sub(a : CryptohashwhirlpoolSeries, b : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_whirlpool_series_normalize(s : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  let mn = crypto_hash_whirlpool_series_min(s)
  let mx = crypto_hash_whirlpool_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_whirlpool_series_cumsum(s : CryptohashwhirlpoolSeries) -> CryptohashwhirlpoolSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_whirlpool_series_to_string(s : CryptohashwhirlpoolSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashwhirlpoolMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_whirlpool_make_matrix(rows : Int, cols : Int, val : Double) -> CryptohashwhirlpoolMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_whirlpool_matrix_identity(n : Int) -> CryptohashwhirlpoolMatrix {
  let m = crypto_hash_whirlpool_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_whirlpool_matrix_get(m : CryptohashwhirlpoolMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_whirlpool_matrix_transpose(m : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  let result = crypto_hash_whirlpool_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_whirlpool_matrix_add(a : CryptohashwhirlpoolMatrix, b : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_whirlpool_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_whirlpool_matrix_scale(m : CryptohashwhirlpoolMatrix, s : Double) -> CryptohashwhirlpoolMatrix {
  let result = crypto_hash_whirlpool_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_whirlpool_matrix_multiply(a : CryptohashwhirlpoolMatrix, b : CryptohashwhirlpoolMatrix) -> CryptohashwhirlpoolMatrix {
  if a.cols != b.rows { return crypto_hash_whirlpool_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_whirlpool_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_whirlpool_matrix_trace(m : CryptohashwhirlpoolMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_whirlpool_matrix_det(m : CryptohashwhirlpoolMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_whirlpool_matrix_norm(m : CryptohashwhirlpoolMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_whirlpool_matrix_to_string(m : CryptohashwhirlpoolMatrix) -> String {
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

pub(all) struct CryptohashwhirlpoolVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_whirlpool_make_vector(comps : Array[Double]) -> CryptohashwhirlpoolVector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_whirlpool_vector_zero(dim : Int) -> CryptohashwhirlpoolVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_whirlpool_vector_add(a : CryptohashwhirlpoolVector, b : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_whirlpool_vector_sub(a : CryptohashwhirlpoolVector, b : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_whirlpool_vector_scale(v : CryptohashwhirlpoolVector, s : Double) -> CryptohashwhirlpoolVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_whirlpool_vector_dot(a : CryptohashwhirlpoolVector, b : CryptohashwhirlpoolVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_whirlpool_vector_norm(v : CryptohashwhirlpoolVector) -> Double { @_common.sqrt(crypto_hash_whirlpool_vector_dot(v, v)) }

pub fn crypto_hash_whirlpool_vector_normalize(v : CryptohashwhirlpoolVector) -> CryptohashwhirlpoolVector {
  let n = crypto_hash_whirlpool_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_whirlpool_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_whirlpool_vector_dist(a : CryptohashwhirlpoolVector, b : CryptohashwhirlpoolVector) -> Double {
  crypto_hash_whirlpool_vector_norm(crypto_hash_whirlpool_vector_sub(a, b))
}

pub fn crypto_hash_whirlpool_vector_to_string(v : CryptohashwhirlpoolVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_whirlpool_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_whirlpool_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_whirlpool_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_whirlpool_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_whirlpool_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_whirlpool_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_whirlpool_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_whirlpool_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_whirlpool_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_whirlpool_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_whirlpool_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_whirlpool_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_whirlpool_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_whirlpool_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_whirlpool_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_whirlpool_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_whirlpool_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_whirlpool_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_whirlpool_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_whirlpool_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_whirlpool_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_whirlpool_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_whirlpool_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_whirlpool_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_whirlpool_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_whirlpool_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_whirlpool_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_whirlpool_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_whirlpool_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptohashwhirlpoolFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_frame_make(size : Int) -> CryptohashwhirlpoolFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_frame_len(s : CryptohashwhirlpoolFrame) -> Int { s.size }

pub fn crypto_hash_whirlpool_frame_get(s : CryptohashwhirlpoolFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_frame_set(s : CryptohashwhirlpoolFrame, i : Int, v : Double) -> CryptohashwhirlpoolFrame {
  let result = crypto_hash_whirlpool_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_frame_sum(s : CryptohashwhirlpoolFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_frame_mean(s : CryptohashwhirlpoolFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_frame_scale(s : CryptohashwhirlpoolFrame, f : Double) -> CryptohashwhirlpoolFrame {
  let result = crypto_hash_whirlpool_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_frame_add(a : CryptohashwhirlpoolFrame, b : CryptohashwhirlpoolFrame) -> CryptohashwhirlpoolFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_frame_copy(s : CryptohashwhirlpoolFrame) -> CryptohashwhirlpoolFrame {
  let result = crypto_hash_whirlpool_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_frame_fill(s : CryptohashwhirlpoolFrame, v : Double) -> CryptohashwhirlpoolFrame {
  let result = crypto_hash_whirlpool_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_frame_min(s : CryptohashwhirlpoolFrame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_frame_max(s : CryptohashwhirlpoolFrame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_frame_to_string(s : CryptohashwhirlpoolFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_table_make(size : Int) -> CryptohashwhirlpoolTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_table_len(s : CryptohashwhirlpoolTable) -> Int { s.size }

pub fn crypto_hash_whirlpool_table_get(s : CryptohashwhirlpoolTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_table_set(s : CryptohashwhirlpoolTable, i : Int, v : Double) -> CryptohashwhirlpoolTable {
  let result = crypto_hash_whirlpool_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_table_sum(s : CryptohashwhirlpoolTable) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_table_mean(s : CryptohashwhirlpoolTable) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_table_scale(s : CryptohashwhirlpoolTable, f : Double) -> CryptohashwhirlpoolTable {
  let result = crypto_hash_whirlpool_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_table_add(a : CryptohashwhirlpoolTable, b : CryptohashwhirlpoolTable) -> CryptohashwhirlpoolTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_table_copy(s : CryptohashwhirlpoolTable) -> CryptohashwhirlpoolTable {
  let result = crypto_hash_whirlpool_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_table_fill(s : CryptohashwhirlpoolTable, v : Double) -> CryptohashwhirlpoolTable {
  let result = crypto_hash_whirlpool_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_table_min(s : CryptohashwhirlpoolTable) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_table_max(s : CryptohashwhirlpoolTable) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_table_to_string(s : CryptohashwhirlpoolTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_graphn_make(size : Int) -> CryptohashwhirlpoolGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_graphn_len(s : CryptohashwhirlpoolGraphN) -> Int { s.size }

pub fn crypto_hash_whirlpool_graphn_get(s : CryptohashwhirlpoolGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_graphn_set(s : CryptohashwhirlpoolGraphN, i : Int, v : Double) -> CryptohashwhirlpoolGraphN {
  let result = crypto_hash_whirlpool_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_graphn_sum(s : CryptohashwhirlpoolGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_graphn_mean(s : CryptohashwhirlpoolGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_graphn_scale(s : CryptohashwhirlpoolGraphN, f : Double) -> CryptohashwhirlpoolGraphN {
  let result = crypto_hash_whirlpool_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_graphn_add(a : CryptohashwhirlpoolGraphN, b : CryptohashwhirlpoolGraphN) -> CryptohashwhirlpoolGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_graphn_copy(s : CryptohashwhirlpoolGraphN) -> CryptohashwhirlpoolGraphN {
  let result = crypto_hash_whirlpool_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_graphn_fill(s : CryptohashwhirlpoolGraphN, v : Double) -> CryptohashwhirlpoolGraphN {
  let result = crypto_hash_whirlpool_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_graphn_min(s : CryptohashwhirlpoolGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_graphn_max(s : CryptohashwhirlpoolGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_graphn_to_string(s : CryptohashwhirlpoolGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_node_make(size : Int) -> CryptohashwhirlpoolNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_node_len(s : CryptohashwhirlpoolNode) -> Int { s.size }

pub fn crypto_hash_whirlpool_node_get(s : CryptohashwhirlpoolNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_node_set(s : CryptohashwhirlpoolNode, i : Int, v : Double) -> CryptohashwhirlpoolNode {
  let result = crypto_hash_whirlpool_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_node_sum(s : CryptohashwhirlpoolNode) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_node_mean(s : CryptohashwhirlpoolNode) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_node_scale(s : CryptohashwhirlpoolNode, f : Double) -> CryptohashwhirlpoolNode {
  let result = crypto_hash_whirlpool_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_node_add(a : CryptohashwhirlpoolNode, b : CryptohashwhirlpoolNode) -> CryptohashwhirlpoolNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_node_copy(s : CryptohashwhirlpoolNode) -> CryptohashwhirlpoolNode {
  let result = crypto_hash_whirlpool_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_node_fill(s : CryptohashwhirlpoolNode, v : Double) -> CryptohashwhirlpoolNode {
  let result = crypto_hash_whirlpool_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_node_min(s : CryptohashwhirlpoolNode) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_node_max(s : CryptohashwhirlpoolNode) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_node_to_string(s : CryptohashwhirlpoolNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_edge_make(size : Int) -> CryptohashwhirlpoolEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_edge_len(s : CryptohashwhirlpoolEdge) -> Int { s.size }

pub fn crypto_hash_whirlpool_edge_get(s : CryptohashwhirlpoolEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_edge_set(s : CryptohashwhirlpoolEdge, i : Int, v : Double) -> CryptohashwhirlpoolEdge {
  let result = crypto_hash_whirlpool_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_edge_sum(s : CryptohashwhirlpoolEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_edge_mean(s : CryptohashwhirlpoolEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_edge_scale(s : CryptohashwhirlpoolEdge, f : Double) -> CryptohashwhirlpoolEdge {
  let result = crypto_hash_whirlpool_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_edge_add(a : CryptohashwhirlpoolEdge, b : CryptohashwhirlpoolEdge) -> CryptohashwhirlpoolEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_edge_copy(s : CryptohashwhirlpoolEdge) -> CryptohashwhirlpoolEdge {
  let result = crypto_hash_whirlpool_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_edge_fill(s : CryptohashwhirlpoolEdge, v : Double) -> CryptohashwhirlpoolEdge {
  let result = crypto_hash_whirlpool_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_edge_min(s : CryptohashwhirlpoolEdge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_edge_max(s : CryptohashwhirlpoolEdge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_edge_to_string(s : CryptohashwhirlpoolEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_path_make(size : Int) -> CryptohashwhirlpoolPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_path_len(s : CryptohashwhirlpoolPath) -> Int { s.size }

pub fn crypto_hash_whirlpool_path_get(s : CryptohashwhirlpoolPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_path_set(s : CryptohashwhirlpoolPath, i : Int, v : Double) -> CryptohashwhirlpoolPath {
  let result = crypto_hash_whirlpool_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_path_sum(s : CryptohashwhirlpoolPath) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_path_mean(s : CryptohashwhirlpoolPath) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_path_scale(s : CryptohashwhirlpoolPath, f : Double) -> CryptohashwhirlpoolPath {
  let result = crypto_hash_whirlpool_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_path_add(a : CryptohashwhirlpoolPath, b : CryptohashwhirlpoolPath) -> CryptohashwhirlpoolPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_path_copy(s : CryptohashwhirlpoolPath) -> CryptohashwhirlpoolPath {
  let result = crypto_hash_whirlpool_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_path_fill(s : CryptohashwhirlpoolPath, v : Double) -> CryptohashwhirlpoolPath {
  let result = crypto_hash_whirlpool_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_path_min(s : CryptohashwhirlpoolPath) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_path_max(s : CryptohashwhirlpoolPath) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_path_to_string(s : CryptohashwhirlpoolPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_cluster_make(size : Int) -> CryptohashwhirlpoolCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_cluster_len(s : CryptohashwhirlpoolCluster) -> Int { s.size }

pub fn crypto_hash_whirlpool_cluster_get(s : CryptohashwhirlpoolCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_cluster_set(s : CryptohashwhirlpoolCluster, i : Int, v : Double) -> CryptohashwhirlpoolCluster {
  let result = crypto_hash_whirlpool_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_cluster_sum(s : CryptohashwhirlpoolCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_cluster_mean(s : CryptohashwhirlpoolCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_cluster_scale(s : CryptohashwhirlpoolCluster, f : Double) -> CryptohashwhirlpoolCluster {
  let result = crypto_hash_whirlpool_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_cluster_add(a : CryptohashwhirlpoolCluster, b : CryptohashwhirlpoolCluster) -> CryptohashwhirlpoolCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_cluster_copy(s : CryptohashwhirlpoolCluster) -> CryptohashwhirlpoolCluster {
  let result = crypto_hash_whirlpool_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_cluster_fill(s : CryptohashwhirlpoolCluster, v : Double) -> CryptohashwhirlpoolCluster {
  let result = crypto_hash_whirlpool_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_cluster_min(s : CryptohashwhirlpoolCluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_cluster_max(s : CryptohashwhirlpoolCluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_cluster_to_string(s : CryptohashwhirlpoolCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_model_make(size : Int) -> CryptohashwhirlpoolModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_model_len(s : CryptohashwhirlpoolModel) -> Int { s.size }

pub fn crypto_hash_whirlpool_model_get(s : CryptohashwhirlpoolModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_model_set(s : CryptohashwhirlpoolModel, i : Int, v : Double) -> CryptohashwhirlpoolModel {
  let result = crypto_hash_whirlpool_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_model_sum(s : CryptohashwhirlpoolModel) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_model_mean(s : CryptohashwhirlpoolModel) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_model_scale(s : CryptohashwhirlpoolModel, f : Double) -> CryptohashwhirlpoolModel {
  let result = crypto_hash_whirlpool_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_model_add(a : CryptohashwhirlpoolModel, b : CryptohashwhirlpoolModel) -> CryptohashwhirlpoolModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_model_copy(s : CryptohashwhirlpoolModel) -> CryptohashwhirlpoolModel {
  let result = crypto_hash_whirlpool_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_model_fill(s : CryptohashwhirlpoolModel, v : Double) -> CryptohashwhirlpoolModel {
  let result = crypto_hash_whirlpool_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_model_min(s : CryptohashwhirlpoolModel) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_model_max(s : CryptohashwhirlpoolModel) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_model_to_string(s : CryptohashwhirlpoolModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_layer_make(size : Int) -> CryptohashwhirlpoolLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_layer_len(s : CryptohashwhirlpoolLayer) -> Int { s.size }

pub fn crypto_hash_whirlpool_layer_get(s : CryptohashwhirlpoolLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_layer_set(s : CryptohashwhirlpoolLayer, i : Int, v : Double) -> CryptohashwhirlpoolLayer {
  let result = crypto_hash_whirlpool_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_layer_sum(s : CryptohashwhirlpoolLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_layer_mean(s : CryptohashwhirlpoolLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_layer_scale(s : CryptohashwhirlpoolLayer, f : Double) -> CryptohashwhirlpoolLayer {
  let result = crypto_hash_whirlpool_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_layer_add(a : CryptohashwhirlpoolLayer, b : CryptohashwhirlpoolLayer) -> CryptohashwhirlpoolLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_layer_copy(s : CryptohashwhirlpoolLayer) -> CryptohashwhirlpoolLayer {
  let result = crypto_hash_whirlpool_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_layer_fill(s : CryptohashwhirlpoolLayer, v : Double) -> CryptohashwhirlpoolLayer {
  let result = crypto_hash_whirlpool_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_layer_min(s : CryptohashwhirlpoolLayer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_layer_max(s : CryptohashwhirlpoolLayer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_layer_to_string(s : CryptohashwhirlpoolLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_buffer_make(size : Int) -> CryptohashwhirlpoolBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_buffer_len(s : CryptohashwhirlpoolBuffer) -> Int { s.size }

pub fn crypto_hash_whirlpool_buffer_get(s : CryptohashwhirlpoolBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_buffer_set(s : CryptohashwhirlpoolBuffer, i : Int, v : Double) -> CryptohashwhirlpoolBuffer {
  let result = crypto_hash_whirlpool_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_buffer_sum(s : CryptohashwhirlpoolBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_buffer_mean(s : CryptohashwhirlpoolBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_buffer_scale(s : CryptohashwhirlpoolBuffer, f : Double) -> CryptohashwhirlpoolBuffer {
  let result = crypto_hash_whirlpool_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_buffer_add(a : CryptohashwhirlpoolBuffer, b : CryptohashwhirlpoolBuffer) -> CryptohashwhirlpoolBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_buffer_copy(s : CryptohashwhirlpoolBuffer) -> CryptohashwhirlpoolBuffer {
  let result = crypto_hash_whirlpool_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_buffer_fill(s : CryptohashwhirlpoolBuffer, v : Double) -> CryptohashwhirlpoolBuffer {
  let result = crypto_hash_whirlpool_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_buffer_min(s : CryptohashwhirlpoolBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_buffer_max(s : CryptohashwhirlpoolBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_buffer_to_string(s : CryptohashwhirlpoolBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_cursor_make(size : Int) -> CryptohashwhirlpoolCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_cursor_len(s : CryptohashwhirlpoolCursor) -> Int { s.size }

pub fn crypto_hash_whirlpool_cursor_get(s : CryptohashwhirlpoolCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_cursor_set(s : CryptohashwhirlpoolCursor, i : Int, v : Double) -> CryptohashwhirlpoolCursor {
  let result = crypto_hash_whirlpool_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_cursor_sum(s : CryptohashwhirlpoolCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_cursor_mean(s : CryptohashwhirlpoolCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_cursor_scale(s : CryptohashwhirlpoolCursor, f : Double) -> CryptohashwhirlpoolCursor {
  let result = crypto_hash_whirlpool_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_cursor_add(a : CryptohashwhirlpoolCursor, b : CryptohashwhirlpoolCursor) -> CryptohashwhirlpoolCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_cursor_copy(s : CryptohashwhirlpoolCursor) -> CryptohashwhirlpoolCursor {
  let result = crypto_hash_whirlpool_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_cursor_fill(s : CryptohashwhirlpoolCursor, v : Double) -> CryptohashwhirlpoolCursor {
  let result = crypto_hash_whirlpool_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_cursor_min(s : CryptohashwhirlpoolCursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_cursor_max(s : CryptohashwhirlpoolCursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_cursor_to_string(s : CryptohashwhirlpoolCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_view_make(size : Int) -> CryptohashwhirlpoolView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_view_len(s : CryptohashwhirlpoolView) -> Int { s.size }

pub fn crypto_hash_whirlpool_view_get(s : CryptohashwhirlpoolView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_view_set(s : CryptohashwhirlpoolView, i : Int, v : Double) -> CryptohashwhirlpoolView {
  let result = crypto_hash_whirlpool_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_view_sum(s : CryptohashwhirlpoolView) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_view_mean(s : CryptohashwhirlpoolView) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_view_scale(s : CryptohashwhirlpoolView, f : Double) -> CryptohashwhirlpoolView {
  let result = crypto_hash_whirlpool_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_view_add(a : CryptohashwhirlpoolView, b : CryptohashwhirlpoolView) -> CryptohashwhirlpoolView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_view_copy(s : CryptohashwhirlpoolView) -> CryptohashwhirlpoolView {
  let result = crypto_hash_whirlpool_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_view_fill(s : CryptohashwhirlpoolView, v : Double) -> CryptohashwhirlpoolView {
  let result = crypto_hash_whirlpool_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_view_min(s : CryptohashwhirlpoolView) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_view_max(s : CryptohashwhirlpoolView) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_view_to_string(s : CryptohashwhirlpoolView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_range_make(size : Int) -> CryptohashwhirlpoolRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_range_len(s : CryptohashwhirlpoolRange) -> Int { s.size }

pub fn crypto_hash_whirlpool_range_get(s : CryptohashwhirlpoolRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_range_set(s : CryptohashwhirlpoolRange, i : Int, v : Double) -> CryptohashwhirlpoolRange {
  let result = crypto_hash_whirlpool_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_range_sum(s : CryptohashwhirlpoolRange) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_range_mean(s : CryptohashwhirlpoolRange) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_range_scale(s : CryptohashwhirlpoolRange, f : Double) -> CryptohashwhirlpoolRange {
  let result = crypto_hash_whirlpool_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_range_add(a : CryptohashwhirlpoolRange, b : CryptohashwhirlpoolRange) -> CryptohashwhirlpoolRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_range_copy(s : CryptohashwhirlpoolRange) -> CryptohashwhirlpoolRange {
  let result = crypto_hash_whirlpool_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_range_fill(s : CryptohashwhirlpoolRange, v : Double) -> CryptohashwhirlpoolRange {
  let result = crypto_hash_whirlpool_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_range_min(s : CryptohashwhirlpoolRange) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_range_max(s : CryptohashwhirlpoolRange) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_range_to_string(s : CryptohashwhirlpoolRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashwhirlpoolSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_whirlpool_slice_make(size : Int) -> CryptohashwhirlpoolSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_whirlpool_slice_len(s : CryptohashwhirlpoolSlice) -> Int { s.size }

pub fn crypto_hash_whirlpool_slice_get(s : CryptohashwhirlpoolSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_whirlpool_slice_set(s : CryptohashwhirlpoolSlice, i : Int, v : Double) -> CryptohashwhirlpoolSlice {
  let result = crypto_hash_whirlpool_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_slice_sum(s : CryptohashwhirlpoolSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_whirlpool_slice_mean(s : CryptohashwhirlpoolSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_whirlpool_slice_scale(s : CryptohashwhirlpoolSlice, f : Double) -> CryptohashwhirlpoolSlice {
  let result = crypto_hash_whirlpool_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_whirlpool_slice_add(a : CryptohashwhirlpoolSlice, b : CryptohashwhirlpoolSlice) -> CryptohashwhirlpoolSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_whirlpool_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_whirlpool_slice_copy(s : CryptohashwhirlpoolSlice) -> CryptohashwhirlpoolSlice {
  let result = crypto_hash_whirlpool_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_whirlpool_slice_fill(s : CryptohashwhirlpoolSlice, v : Double) -> CryptohashwhirlpoolSlice {
  let result = crypto_hash_whirlpool_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_whirlpool_slice_min(s : CryptohashwhirlpoolSlice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_whirlpool_slice_max(s : CryptohashwhirlpoolSlice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_whirlpool_slice_to_string(s : CryptohashwhirlpoolSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

