///===
/// extcore/crypto_asym_ecc

pub(all) struct CryptoasymeccPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_ecc_make_point(x : Double, y : Double) -> CryptoasymeccPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_ecc_make_point3(x : Double, y : Double, z : Double) -> CryptoasymeccPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_ecc_point_x(pt : CryptoasymeccPoint) -> Double { pt.x }

pub fn crypto_asym_ecc_point_y(pt : CryptoasymeccPoint) -> Double { pt.y }

pub fn crypto_asym_ecc_point_z(pt : CryptoasymeccPoint) -> Double { pt.z }

pub fn crypto_asym_ecc_point_label(pt : CryptoasymeccPoint) -> Int { pt.label }

pub fn crypto_asym_ecc_point_dist(a : CryptoasymeccPoint, b : CryptoasymeccPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_ecc_point_add(a : CryptoasymeccPoint, b : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_ecc_point_sub(a : CryptoasymeccPoint, b : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_ecc_point_scale(pt : CryptoasymeccPoint, s : Double) -> CryptoasymeccPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_ecc_point_dot(a : CryptoasymeccPoint, b : CryptoasymeccPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_ecc_point_cross(a : CryptoasymeccPoint, b : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_ecc_point_norm(pt : CryptoasymeccPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_ecc_point_normalize(pt : CryptoasymeccPoint) -> CryptoasymeccPoint {
  let n = crypto_asym_ecc_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_ecc_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_ecc_point_negate(pt : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_ecc_point_mid(a : CryptoasymeccPoint, b : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_ecc_point_lerp(a : CryptoasymeccPoint, b : CryptoasymeccPoint, t : Double) -> CryptoasymeccPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_ecc_point_to_string(pt : CryptoasymeccPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptoasymeccSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_ecc_make_series(vals : Array[Double], name : String) -> CryptoasymeccSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_ecc_series_len(s : CryptoasymeccSeries) -> Int { s.vals.length() }

pub fn crypto_asym_ecc_series_sum(s : CryptoasymeccSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_asym_ecc_series_mean(s : CryptoasymeccSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_asym_ecc_series_min(s : CryptoasymeccSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_asym_ecc_series_max(s : CryptoasymeccSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_asym_ecc_series_range(s : CryptoasymeccSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_asym_ecc_series_var(s : CryptoasymeccSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_asym_ecc_series_std(s : CryptoasymeccSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_asym_ecc_series_median(s : CryptoasymeccSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_asym_ecc_series_scale(s : CryptoasymeccSeries, f : Double) -> CryptoasymeccSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_asym_ecc_series_add(a : CryptoasymeccSeries, b : CryptoasymeccSeries) -> CryptoasymeccSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_ecc_series_sub(a : CryptoasymeccSeries, b : CryptoasymeccSeries) -> CryptoasymeccSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_ecc_series_normalize(s : CryptoasymeccSeries) -> CryptoasymeccSeries {
  let mn = crypto_asym_ecc_series_min(s)
  let mx = crypto_asym_ecc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_ecc_series_cumsum(s : CryptoasymeccSeries) -> CryptoasymeccSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_ecc_series_to_string(s : CryptoasymeccSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeccMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_ecc_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymeccMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_ecc_matrix_identity(n : Int) -> CryptoasymeccMatrix {
  let m = crypto_asym_ecc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_ecc_matrix_get(m : CryptoasymeccMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_ecc_matrix_transpose(m : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  let result = crypto_asym_ecc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_ecc_matrix_add(a : CryptoasymeccMatrix, b : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_ecc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_ecc_matrix_scale(m : CryptoasymeccMatrix, s : Double) -> CryptoasymeccMatrix {
  let result = crypto_asym_ecc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_ecc_matrix_multiply(a : CryptoasymeccMatrix, b : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  if a.cols != b.rows { return crypto_asym_ecc_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_ecc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_ecc_matrix_trace(m : CryptoasymeccMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_ecc_matrix_det(m : CryptoasymeccMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_ecc_matrix_norm(m : CryptoasymeccMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_asym_ecc_matrix_to_string(m : CryptoasymeccMatrix) -> String {
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

pub(all) struct CryptoasymeccVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_ecc_make_vector(comps : Array[Double]) -> CryptoasymeccVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_ecc_vector_zero(dim : Int) -> CryptoasymeccVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_ecc_vector_add(a : CryptoasymeccVector, b : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_ecc_vector_sub(a : CryptoasymeccVector, b : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_ecc_vector_scale(v : CryptoasymeccVector, s : Double) -> CryptoasymeccVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_asym_ecc_vector_dot(a : CryptoasymeccVector, b : CryptoasymeccVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_ecc_vector_norm(v : CryptoasymeccVector) -> Double { @_common.sqrt(crypto_asym_ecc_vector_dot(v, v)) }

pub fn crypto_asym_ecc_vector_normalize(v : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = crypto_asym_ecc_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_ecc_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_ecc_vector_dist(a : CryptoasymeccVector, b : CryptoasymeccVector) -> Double {
  crypto_asym_ecc_vector_norm(crypto_asym_ecc_vector_sub(a, b))
}

pub fn crypto_asym_ecc_vector_to_string(v : CryptoasymeccVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_ecc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_ecc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_ecc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_ecc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_ecc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_ecc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_ecc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_ecc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_ecc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_ecc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_ecc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_ecc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_ecc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_ecc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_ecc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_ecc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_ecc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_ecc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_ecc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_ecc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_ecc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_ecc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_ecc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_ecc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_ecc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_ecc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_ecc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_ecc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_ecc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymeccFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_frame_make(size : Int) -> CryptoasymeccFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_frame_len(s : CryptoasymeccFrame) -> Int { s.size }

pub fn crypto_asym_ecc_frame_get(s : CryptoasymeccFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_frame_set(s : CryptoasymeccFrame, i : Int, v : Double) -> CryptoasymeccFrame {
  let result = crypto_asym_ecc_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_frame_sum(s : CryptoasymeccFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_frame_mean(s : CryptoasymeccFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_frame_scale(s : CryptoasymeccFrame, f : Double) -> CryptoasymeccFrame {
  let result = crypto_asym_ecc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_frame_add(a : CryptoasymeccFrame, b : CryptoasymeccFrame) -> CryptoasymeccFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_frame_copy(s : CryptoasymeccFrame) -> CryptoasymeccFrame {
  let result = crypto_asym_ecc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_frame_fill(s : CryptoasymeccFrame, v : Double) -> CryptoasymeccFrame {
  let result = crypto_asym_ecc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_frame_min(s : CryptoasymeccFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_frame_max(s : CryptoasymeccFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_frame_to_string(s : CryptoasymeccFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_table_make(size : Int) -> CryptoasymeccTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_table_len(s : CryptoasymeccTable) -> Int { s.size }

pub fn crypto_asym_ecc_table_get(s : CryptoasymeccTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_table_set(s : CryptoasymeccTable, i : Int, v : Double) -> CryptoasymeccTable {
  let result = crypto_asym_ecc_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_table_sum(s : CryptoasymeccTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_table_mean(s : CryptoasymeccTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_table_scale(s : CryptoasymeccTable, f : Double) -> CryptoasymeccTable {
  let result = crypto_asym_ecc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_table_add(a : CryptoasymeccTable, b : CryptoasymeccTable) -> CryptoasymeccTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_table_copy(s : CryptoasymeccTable) -> CryptoasymeccTable {
  let result = crypto_asym_ecc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_table_fill(s : CryptoasymeccTable, v : Double) -> CryptoasymeccTable {
  let result = crypto_asym_ecc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_table_min(s : CryptoasymeccTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_table_max(s : CryptoasymeccTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_table_to_string(s : CryptoasymeccTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_graphn_make(size : Int) -> CryptoasymeccGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_graphn_len(s : CryptoasymeccGraphN) -> Int { s.size }

pub fn crypto_asym_ecc_graphn_get(s : CryptoasymeccGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_graphn_set(s : CryptoasymeccGraphN, i : Int, v : Double) -> CryptoasymeccGraphN {
  let result = crypto_asym_ecc_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_graphn_sum(s : CryptoasymeccGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_graphn_mean(s : CryptoasymeccGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_graphn_scale(s : CryptoasymeccGraphN, f : Double) -> CryptoasymeccGraphN {
  let result = crypto_asym_ecc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_graphn_add(a : CryptoasymeccGraphN, b : CryptoasymeccGraphN) -> CryptoasymeccGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_graphn_copy(s : CryptoasymeccGraphN) -> CryptoasymeccGraphN {
  let result = crypto_asym_ecc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_graphn_fill(s : CryptoasymeccGraphN, v : Double) -> CryptoasymeccGraphN {
  let result = crypto_asym_ecc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_graphn_min(s : CryptoasymeccGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_graphn_max(s : CryptoasymeccGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_graphn_to_string(s : CryptoasymeccGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_node_make(size : Int) -> CryptoasymeccNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_node_len(s : CryptoasymeccNode) -> Int { s.size }

pub fn crypto_asym_ecc_node_get(s : CryptoasymeccNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_node_set(s : CryptoasymeccNode, i : Int, v : Double) -> CryptoasymeccNode {
  let result = crypto_asym_ecc_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_node_sum(s : CryptoasymeccNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_node_mean(s : CryptoasymeccNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_node_scale(s : CryptoasymeccNode, f : Double) -> CryptoasymeccNode {
  let result = crypto_asym_ecc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_node_add(a : CryptoasymeccNode, b : CryptoasymeccNode) -> CryptoasymeccNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_node_copy(s : CryptoasymeccNode) -> CryptoasymeccNode {
  let result = crypto_asym_ecc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_node_fill(s : CryptoasymeccNode, v : Double) -> CryptoasymeccNode {
  let result = crypto_asym_ecc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_node_min(s : CryptoasymeccNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_node_max(s : CryptoasymeccNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_node_to_string(s : CryptoasymeccNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_edge_make(size : Int) -> CryptoasymeccEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_edge_len(s : CryptoasymeccEdge) -> Int { s.size }

pub fn crypto_asym_ecc_edge_get(s : CryptoasymeccEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_edge_set(s : CryptoasymeccEdge, i : Int, v : Double) -> CryptoasymeccEdge {
  let result = crypto_asym_ecc_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_edge_sum(s : CryptoasymeccEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_edge_mean(s : CryptoasymeccEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_edge_scale(s : CryptoasymeccEdge, f : Double) -> CryptoasymeccEdge {
  let result = crypto_asym_ecc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_edge_add(a : CryptoasymeccEdge, b : CryptoasymeccEdge) -> CryptoasymeccEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_edge_copy(s : CryptoasymeccEdge) -> CryptoasymeccEdge {
  let result = crypto_asym_ecc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_edge_fill(s : CryptoasymeccEdge, v : Double) -> CryptoasymeccEdge {
  let result = crypto_asym_ecc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_edge_min(s : CryptoasymeccEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_edge_max(s : CryptoasymeccEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_edge_to_string(s : CryptoasymeccEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_path_make(size : Int) -> CryptoasymeccPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_path_len(s : CryptoasymeccPath) -> Int { s.size }

pub fn crypto_asym_ecc_path_get(s : CryptoasymeccPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_path_set(s : CryptoasymeccPath, i : Int, v : Double) -> CryptoasymeccPath {
  let result = crypto_asym_ecc_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_path_sum(s : CryptoasymeccPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_path_mean(s : CryptoasymeccPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_path_scale(s : CryptoasymeccPath, f : Double) -> CryptoasymeccPath {
  let result = crypto_asym_ecc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_path_add(a : CryptoasymeccPath, b : CryptoasymeccPath) -> CryptoasymeccPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_path_copy(s : CryptoasymeccPath) -> CryptoasymeccPath {
  let result = crypto_asym_ecc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_path_fill(s : CryptoasymeccPath, v : Double) -> CryptoasymeccPath {
  let result = crypto_asym_ecc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_path_min(s : CryptoasymeccPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_path_max(s : CryptoasymeccPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_path_to_string(s : CryptoasymeccPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_cluster_make(size : Int) -> CryptoasymeccCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_cluster_len(s : CryptoasymeccCluster) -> Int { s.size }

pub fn crypto_asym_ecc_cluster_get(s : CryptoasymeccCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_cluster_set(s : CryptoasymeccCluster, i : Int, v : Double) -> CryptoasymeccCluster {
  let result = crypto_asym_ecc_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_cluster_sum(s : CryptoasymeccCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_cluster_mean(s : CryptoasymeccCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_cluster_scale(s : CryptoasymeccCluster, f : Double) -> CryptoasymeccCluster {
  let result = crypto_asym_ecc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_cluster_add(a : CryptoasymeccCluster, b : CryptoasymeccCluster) -> CryptoasymeccCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_cluster_copy(s : CryptoasymeccCluster) -> CryptoasymeccCluster {
  let result = crypto_asym_ecc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_cluster_fill(s : CryptoasymeccCluster, v : Double) -> CryptoasymeccCluster {
  let result = crypto_asym_ecc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_cluster_min(s : CryptoasymeccCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_cluster_max(s : CryptoasymeccCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_cluster_to_string(s : CryptoasymeccCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_model_make(size : Int) -> CryptoasymeccModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_model_len(s : CryptoasymeccModel) -> Int { s.size }

pub fn crypto_asym_ecc_model_get(s : CryptoasymeccModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_model_set(s : CryptoasymeccModel, i : Int, v : Double) -> CryptoasymeccModel {
  let result = crypto_asym_ecc_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_model_sum(s : CryptoasymeccModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_model_mean(s : CryptoasymeccModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_model_scale(s : CryptoasymeccModel, f : Double) -> CryptoasymeccModel {
  let result = crypto_asym_ecc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_model_add(a : CryptoasymeccModel, b : CryptoasymeccModel) -> CryptoasymeccModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_model_copy(s : CryptoasymeccModel) -> CryptoasymeccModel {
  let result = crypto_asym_ecc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_model_fill(s : CryptoasymeccModel, v : Double) -> CryptoasymeccModel {
  let result = crypto_asym_ecc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_model_min(s : CryptoasymeccModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_model_max(s : CryptoasymeccModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_model_to_string(s : CryptoasymeccModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_layer_make(size : Int) -> CryptoasymeccLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_layer_len(s : CryptoasymeccLayer) -> Int { s.size }

pub fn crypto_asym_ecc_layer_get(s : CryptoasymeccLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_layer_set(s : CryptoasymeccLayer, i : Int, v : Double) -> CryptoasymeccLayer {
  let result = crypto_asym_ecc_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_layer_sum(s : CryptoasymeccLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_layer_mean(s : CryptoasymeccLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_layer_scale(s : CryptoasymeccLayer, f : Double) -> CryptoasymeccLayer {
  let result = crypto_asym_ecc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_layer_add(a : CryptoasymeccLayer, b : CryptoasymeccLayer) -> CryptoasymeccLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_layer_copy(s : CryptoasymeccLayer) -> CryptoasymeccLayer {
  let result = crypto_asym_ecc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_layer_fill(s : CryptoasymeccLayer, v : Double) -> CryptoasymeccLayer {
  let result = crypto_asym_ecc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_layer_min(s : CryptoasymeccLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_layer_max(s : CryptoasymeccLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_layer_to_string(s : CryptoasymeccLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_buffer_make(size : Int) -> CryptoasymeccBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_buffer_len(s : CryptoasymeccBuffer) -> Int { s.size }

pub fn crypto_asym_ecc_buffer_get(s : CryptoasymeccBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_buffer_set(s : CryptoasymeccBuffer, i : Int, v : Double) -> CryptoasymeccBuffer {
  let result = crypto_asym_ecc_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_buffer_sum(s : CryptoasymeccBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_buffer_mean(s : CryptoasymeccBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_buffer_scale(s : CryptoasymeccBuffer, f : Double) -> CryptoasymeccBuffer {
  let result = crypto_asym_ecc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_buffer_add(a : CryptoasymeccBuffer, b : CryptoasymeccBuffer) -> CryptoasymeccBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_buffer_copy(s : CryptoasymeccBuffer) -> CryptoasymeccBuffer {
  let result = crypto_asym_ecc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_buffer_fill(s : CryptoasymeccBuffer, v : Double) -> CryptoasymeccBuffer {
  let result = crypto_asym_ecc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_buffer_min(s : CryptoasymeccBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_buffer_max(s : CryptoasymeccBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_buffer_to_string(s : CryptoasymeccBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_cursor_make(size : Int) -> CryptoasymeccCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_cursor_len(s : CryptoasymeccCursor) -> Int { s.size }

pub fn crypto_asym_ecc_cursor_get(s : CryptoasymeccCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_cursor_set(s : CryptoasymeccCursor, i : Int, v : Double) -> CryptoasymeccCursor {
  let result = crypto_asym_ecc_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_cursor_sum(s : CryptoasymeccCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_cursor_mean(s : CryptoasymeccCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_cursor_scale(s : CryptoasymeccCursor, f : Double) -> CryptoasymeccCursor {
  let result = crypto_asym_ecc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_cursor_add(a : CryptoasymeccCursor, b : CryptoasymeccCursor) -> CryptoasymeccCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_cursor_copy(s : CryptoasymeccCursor) -> CryptoasymeccCursor {
  let result = crypto_asym_ecc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_cursor_fill(s : CryptoasymeccCursor, v : Double) -> CryptoasymeccCursor {
  let result = crypto_asym_ecc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_cursor_min(s : CryptoasymeccCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_cursor_max(s : CryptoasymeccCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_cursor_to_string(s : CryptoasymeccCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_view_make(size : Int) -> CryptoasymeccView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_view_len(s : CryptoasymeccView) -> Int { s.size }

pub fn crypto_asym_ecc_view_get(s : CryptoasymeccView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_view_set(s : CryptoasymeccView, i : Int, v : Double) -> CryptoasymeccView {
  let result = crypto_asym_ecc_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_view_sum(s : CryptoasymeccView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_view_mean(s : CryptoasymeccView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_view_scale(s : CryptoasymeccView, f : Double) -> CryptoasymeccView {
  let result = crypto_asym_ecc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_view_add(a : CryptoasymeccView, b : CryptoasymeccView) -> CryptoasymeccView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_view_copy(s : CryptoasymeccView) -> CryptoasymeccView {
  let result = crypto_asym_ecc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_view_fill(s : CryptoasymeccView, v : Double) -> CryptoasymeccView {
  let result = crypto_asym_ecc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_view_min(s : CryptoasymeccView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_view_max(s : CryptoasymeccView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_view_to_string(s : CryptoasymeccView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_range_make(size : Int) -> CryptoasymeccRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_range_len(s : CryptoasymeccRange) -> Int { s.size }

pub fn crypto_asym_ecc_range_get(s : CryptoasymeccRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_range_set(s : CryptoasymeccRange, i : Int, v : Double) -> CryptoasymeccRange {
  let result = crypto_asym_ecc_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_range_sum(s : CryptoasymeccRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_range_mean(s : CryptoasymeccRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_range_scale(s : CryptoasymeccRange, f : Double) -> CryptoasymeccRange {
  let result = crypto_asym_ecc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_range_add(a : CryptoasymeccRange, b : CryptoasymeccRange) -> CryptoasymeccRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_range_copy(s : CryptoasymeccRange) -> CryptoasymeccRange {
  let result = crypto_asym_ecc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_range_fill(s : CryptoasymeccRange, v : Double) -> CryptoasymeccRange {
  let result = crypto_asym_ecc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_range_min(s : CryptoasymeccRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_range_max(s : CryptoasymeccRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_range_to_string(s : CryptoasymeccRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_slice_make(size : Int) -> CryptoasymeccSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecc_slice_len(s : CryptoasymeccSlice) -> Int { s.size }

pub fn crypto_asym_ecc_slice_get(s : CryptoasymeccSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecc_slice_set(s : CryptoasymeccSlice, i : Int, v : Double) -> CryptoasymeccSlice {
  let result = crypto_asym_ecc_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_slice_sum(s : CryptoasymeccSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecc_slice_mean(s : CryptoasymeccSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecc_slice_scale(s : CryptoasymeccSlice, f : Double) -> CryptoasymeccSlice {
  let result = crypto_asym_ecc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecc_slice_add(a : CryptoasymeccSlice, b : CryptoasymeccSlice) -> CryptoasymeccSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecc_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecc_slice_copy(s : CryptoasymeccSlice) -> CryptoasymeccSlice {
  let result = crypto_asym_ecc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecc_slice_fill(s : CryptoasymeccSlice, v : Double) -> CryptoasymeccSlice {
  let result = crypto_asym_ecc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecc_slice_min(s : CryptoasymeccSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecc_slice_max(s : CryptoasymeccSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecc_slice_to_string(s : CryptoasymeccSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

