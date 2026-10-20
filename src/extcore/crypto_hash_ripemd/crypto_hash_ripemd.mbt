///===
/// extcore/crypto_hash_ripemd

pub(all) struct CryptohashripemdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_ripemd_make_point(x : Double, y : Double) -> CryptohashripemdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_ripemd_make_point3(x : Double, y : Double, z : Double) -> CryptohashripemdPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_ripemd_point_x(pt : CryptohashripemdPoint) -> Double { pt.x }

pub fn crypto_hash_ripemd_point_y(pt : CryptohashripemdPoint) -> Double { pt.y }

pub fn crypto_hash_ripemd_point_z(pt : CryptohashripemdPoint) -> Double { pt.z }

pub fn crypto_hash_ripemd_point_label(pt : CryptohashripemdPoint) -> Int { pt.label }

pub fn crypto_hash_ripemd_point_dist(a : CryptohashripemdPoint, b : CryptohashripemdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_ripemd_point_add(a : CryptohashripemdPoint, b : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_ripemd_point_sub(a : CryptohashripemdPoint, b : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_ripemd_point_scale(pt : CryptohashripemdPoint, s : Double) -> CryptohashripemdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_ripemd_point_dot(a : CryptohashripemdPoint, b : CryptohashripemdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_ripemd_point_cross(a : CryptohashripemdPoint, b : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_ripemd_point_norm(pt : CryptohashripemdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_ripemd_point_normalize(pt : CryptohashripemdPoint) -> CryptohashripemdPoint {
  let n = crypto_hash_ripemd_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_ripemd_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_ripemd_point_negate(pt : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_ripemd_point_mid(a : CryptohashripemdPoint, b : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_ripemd_point_lerp(a : CryptohashripemdPoint, b : CryptohashripemdPoint, t : Double) -> CryptohashripemdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_ripemd_point_to_string(pt : CryptohashripemdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptohashripemdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_ripemd_make_series(vals : Array[Double], name : String) -> CryptohashripemdSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_ripemd_series_len(s : CryptohashripemdSeries) -> Int { s.vals.length() }

pub fn crypto_hash_ripemd_series_sum(s : CryptohashripemdSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_hash_ripemd_series_mean(s : CryptohashripemdSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_hash_ripemd_series_min(s : CryptohashripemdSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_hash_ripemd_series_max(s : CryptohashripemdSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_hash_ripemd_series_range(s : CryptohashripemdSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_hash_ripemd_series_var(s : CryptohashripemdSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_hash_ripemd_series_std(s : CryptohashripemdSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_hash_ripemd_series_median(s : CryptohashripemdSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_hash_ripemd_series_scale(s : CryptohashripemdSeries, f : Double) -> CryptohashripemdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_ripemd_series_add(a : CryptohashripemdSeries, b : CryptohashripemdSeries) -> CryptohashripemdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_ripemd_series_sub(a : CryptohashripemdSeries, b : CryptohashripemdSeries) -> CryptohashripemdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_ripemd_series_normalize(s : CryptohashripemdSeries) -> CryptohashripemdSeries {
  let mn = crypto_hash_ripemd_series_min(s)
  let mx = crypto_hash_ripemd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_ripemd_series_cumsum(s : CryptohashripemdSeries) -> CryptohashripemdSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_ripemd_series_to_string(s : CryptohashripemdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashripemdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_ripemd_make_matrix(rows : Int, cols : Int, val : Double) -> CryptohashripemdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_ripemd_matrix_identity(n : Int) -> CryptohashripemdMatrix {
  let m = crypto_hash_ripemd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_ripemd_matrix_get(m : CryptohashripemdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_ripemd_matrix_transpose(m : CryptohashripemdMatrix) -> CryptohashripemdMatrix {
  let result = crypto_hash_ripemd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_ripemd_matrix_add(a : CryptohashripemdMatrix, b : CryptohashripemdMatrix) -> CryptohashripemdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_ripemd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_ripemd_matrix_scale(m : CryptohashripemdMatrix, s : Double) -> CryptohashripemdMatrix {
  let result = crypto_hash_ripemd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_ripemd_matrix_multiply(a : CryptohashripemdMatrix, b : CryptohashripemdMatrix) -> CryptohashripemdMatrix {
  if a.cols != b.rows { return crypto_hash_ripemd_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_ripemd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_ripemd_matrix_trace(m : CryptohashripemdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_ripemd_matrix_det(m : CryptohashripemdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_ripemd_matrix_norm(m : CryptohashripemdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_ripemd_matrix_to_string(m : CryptohashripemdMatrix) -> String {
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

pub(all) struct CryptohashripemdVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_ripemd_make_vector(comps : Array[Double]) -> CryptohashripemdVector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_ripemd_vector_zero(dim : Int) -> CryptohashripemdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_ripemd_vector_add(a : CryptohashripemdVector, b : CryptohashripemdVector) -> CryptohashripemdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_ripemd_vector_sub(a : CryptohashripemdVector, b : CryptohashripemdVector) -> CryptohashripemdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_ripemd_vector_scale(v : CryptohashripemdVector, s : Double) -> CryptohashripemdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_ripemd_vector_dot(a : CryptohashripemdVector, b : CryptohashripemdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_ripemd_vector_norm(v : CryptohashripemdVector) -> Double { @_common.sqrt(crypto_hash_ripemd_vector_dot(v, v)) }

pub fn crypto_hash_ripemd_vector_normalize(v : CryptohashripemdVector) -> CryptohashripemdVector {
  let n = crypto_hash_ripemd_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_ripemd_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_ripemd_vector_dist(a : CryptohashripemdVector, b : CryptohashripemdVector) -> Double {
  crypto_hash_ripemd_vector_norm(crypto_hash_ripemd_vector_sub(a, b))
}

pub fn crypto_hash_ripemd_vector_to_string(v : CryptohashripemdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_ripemd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_ripemd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_ripemd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_ripemd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_ripemd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_ripemd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_ripemd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_ripemd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_ripemd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_ripemd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_ripemd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_ripemd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_ripemd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_ripemd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_ripemd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_ripemd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_ripemd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_ripemd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_ripemd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_ripemd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_ripemd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_ripemd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_ripemd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_ripemd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_ripemd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_ripemd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_ripemd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_ripemd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_ripemd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptohashripemdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_frame_make(size : Int) -> CryptohashripemdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_frame_len(s : CryptohashripemdFrame) -> Int { s.size }

pub fn crypto_hash_ripemd_frame_get(s : CryptohashripemdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_frame_set(s : CryptohashripemdFrame, i : Int, v : Double) -> CryptohashripemdFrame {
  let result = crypto_hash_ripemd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_frame_sum(s : CryptohashripemdFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_frame_mean(s : CryptohashripemdFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_frame_scale(s : CryptohashripemdFrame, f : Double) -> CryptohashripemdFrame {
  let result = crypto_hash_ripemd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_frame_add(a : CryptohashripemdFrame, b : CryptohashripemdFrame) -> CryptohashripemdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_frame_copy(s : CryptohashripemdFrame) -> CryptohashripemdFrame {
  let result = crypto_hash_ripemd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_frame_fill(s : CryptohashripemdFrame, v : Double) -> CryptohashripemdFrame {
  let result = crypto_hash_ripemd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_frame_min(s : CryptohashripemdFrame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_frame_max(s : CryptohashripemdFrame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_frame_to_string(s : CryptohashripemdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_table_make(size : Int) -> CryptohashripemdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_table_len(s : CryptohashripemdTable) -> Int { s.size }

pub fn crypto_hash_ripemd_table_get(s : CryptohashripemdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_table_set(s : CryptohashripemdTable, i : Int, v : Double) -> CryptohashripemdTable {
  let result = crypto_hash_ripemd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_table_sum(s : CryptohashripemdTable) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_table_mean(s : CryptohashripemdTable) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_table_scale(s : CryptohashripemdTable, f : Double) -> CryptohashripemdTable {
  let result = crypto_hash_ripemd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_table_add(a : CryptohashripemdTable, b : CryptohashripemdTable) -> CryptohashripemdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_table_copy(s : CryptohashripemdTable) -> CryptohashripemdTable {
  let result = crypto_hash_ripemd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_table_fill(s : CryptohashripemdTable, v : Double) -> CryptohashripemdTable {
  let result = crypto_hash_ripemd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_table_min(s : CryptohashripemdTable) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_table_max(s : CryptohashripemdTable) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_table_to_string(s : CryptohashripemdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_graphn_make(size : Int) -> CryptohashripemdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_graphn_len(s : CryptohashripemdGraphN) -> Int { s.size }

pub fn crypto_hash_ripemd_graphn_get(s : CryptohashripemdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_graphn_set(s : CryptohashripemdGraphN, i : Int, v : Double) -> CryptohashripemdGraphN {
  let result = crypto_hash_ripemd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_graphn_sum(s : CryptohashripemdGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_graphn_mean(s : CryptohashripemdGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_graphn_scale(s : CryptohashripemdGraphN, f : Double) -> CryptohashripemdGraphN {
  let result = crypto_hash_ripemd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_graphn_add(a : CryptohashripemdGraphN, b : CryptohashripemdGraphN) -> CryptohashripemdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_graphn_copy(s : CryptohashripemdGraphN) -> CryptohashripemdGraphN {
  let result = crypto_hash_ripemd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_graphn_fill(s : CryptohashripemdGraphN, v : Double) -> CryptohashripemdGraphN {
  let result = crypto_hash_ripemd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_graphn_min(s : CryptohashripemdGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_graphn_max(s : CryptohashripemdGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_graphn_to_string(s : CryptohashripemdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_node_make(size : Int) -> CryptohashripemdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_node_len(s : CryptohashripemdNode) -> Int { s.size }

pub fn crypto_hash_ripemd_node_get(s : CryptohashripemdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_node_set(s : CryptohashripemdNode, i : Int, v : Double) -> CryptohashripemdNode {
  let result = crypto_hash_ripemd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_node_sum(s : CryptohashripemdNode) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_node_mean(s : CryptohashripemdNode) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_node_scale(s : CryptohashripemdNode, f : Double) -> CryptohashripemdNode {
  let result = crypto_hash_ripemd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_node_add(a : CryptohashripemdNode, b : CryptohashripemdNode) -> CryptohashripemdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_node_copy(s : CryptohashripemdNode) -> CryptohashripemdNode {
  let result = crypto_hash_ripemd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_node_fill(s : CryptohashripemdNode, v : Double) -> CryptohashripemdNode {
  let result = crypto_hash_ripemd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_node_min(s : CryptohashripemdNode) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_node_max(s : CryptohashripemdNode) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_node_to_string(s : CryptohashripemdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_edge_make(size : Int) -> CryptohashripemdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_edge_len(s : CryptohashripemdEdge) -> Int { s.size }

pub fn crypto_hash_ripemd_edge_get(s : CryptohashripemdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_edge_set(s : CryptohashripemdEdge, i : Int, v : Double) -> CryptohashripemdEdge {
  let result = crypto_hash_ripemd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_edge_sum(s : CryptohashripemdEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_edge_mean(s : CryptohashripemdEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_edge_scale(s : CryptohashripemdEdge, f : Double) -> CryptohashripemdEdge {
  let result = crypto_hash_ripemd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_edge_add(a : CryptohashripemdEdge, b : CryptohashripemdEdge) -> CryptohashripemdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_edge_copy(s : CryptohashripemdEdge) -> CryptohashripemdEdge {
  let result = crypto_hash_ripemd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_edge_fill(s : CryptohashripemdEdge, v : Double) -> CryptohashripemdEdge {
  let result = crypto_hash_ripemd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_edge_min(s : CryptohashripemdEdge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_edge_max(s : CryptohashripemdEdge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_edge_to_string(s : CryptohashripemdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_path_make(size : Int) -> CryptohashripemdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_path_len(s : CryptohashripemdPath) -> Int { s.size }

pub fn crypto_hash_ripemd_path_get(s : CryptohashripemdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_path_set(s : CryptohashripemdPath, i : Int, v : Double) -> CryptohashripemdPath {
  let result = crypto_hash_ripemd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_path_sum(s : CryptohashripemdPath) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_path_mean(s : CryptohashripemdPath) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_path_scale(s : CryptohashripemdPath, f : Double) -> CryptohashripemdPath {
  let result = crypto_hash_ripemd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_path_add(a : CryptohashripemdPath, b : CryptohashripemdPath) -> CryptohashripemdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_path_copy(s : CryptohashripemdPath) -> CryptohashripemdPath {
  let result = crypto_hash_ripemd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_path_fill(s : CryptohashripemdPath, v : Double) -> CryptohashripemdPath {
  let result = crypto_hash_ripemd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_path_min(s : CryptohashripemdPath) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_path_max(s : CryptohashripemdPath) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_path_to_string(s : CryptohashripemdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_cluster_make(size : Int) -> CryptohashripemdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_cluster_len(s : CryptohashripemdCluster) -> Int { s.size }

pub fn crypto_hash_ripemd_cluster_get(s : CryptohashripemdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_cluster_set(s : CryptohashripemdCluster, i : Int, v : Double) -> CryptohashripemdCluster {
  let result = crypto_hash_ripemd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_cluster_sum(s : CryptohashripemdCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_cluster_mean(s : CryptohashripemdCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_cluster_scale(s : CryptohashripemdCluster, f : Double) -> CryptohashripemdCluster {
  let result = crypto_hash_ripemd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_cluster_add(a : CryptohashripemdCluster, b : CryptohashripemdCluster) -> CryptohashripemdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_cluster_copy(s : CryptohashripemdCluster) -> CryptohashripemdCluster {
  let result = crypto_hash_ripemd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_cluster_fill(s : CryptohashripemdCluster, v : Double) -> CryptohashripemdCluster {
  let result = crypto_hash_ripemd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_cluster_min(s : CryptohashripemdCluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_cluster_max(s : CryptohashripemdCluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_cluster_to_string(s : CryptohashripemdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_model_make(size : Int) -> CryptohashripemdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_model_len(s : CryptohashripemdModel) -> Int { s.size }

pub fn crypto_hash_ripemd_model_get(s : CryptohashripemdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_model_set(s : CryptohashripemdModel, i : Int, v : Double) -> CryptohashripemdModel {
  let result = crypto_hash_ripemd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_model_sum(s : CryptohashripemdModel) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_model_mean(s : CryptohashripemdModel) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_model_scale(s : CryptohashripemdModel, f : Double) -> CryptohashripemdModel {
  let result = crypto_hash_ripemd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_model_add(a : CryptohashripemdModel, b : CryptohashripemdModel) -> CryptohashripemdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_model_copy(s : CryptohashripemdModel) -> CryptohashripemdModel {
  let result = crypto_hash_ripemd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_model_fill(s : CryptohashripemdModel, v : Double) -> CryptohashripemdModel {
  let result = crypto_hash_ripemd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_model_min(s : CryptohashripemdModel) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_model_max(s : CryptohashripemdModel) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_model_to_string(s : CryptohashripemdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_layer_make(size : Int) -> CryptohashripemdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_layer_len(s : CryptohashripemdLayer) -> Int { s.size }

pub fn crypto_hash_ripemd_layer_get(s : CryptohashripemdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_layer_set(s : CryptohashripemdLayer, i : Int, v : Double) -> CryptohashripemdLayer {
  let result = crypto_hash_ripemd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_layer_sum(s : CryptohashripemdLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_layer_mean(s : CryptohashripemdLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_layer_scale(s : CryptohashripemdLayer, f : Double) -> CryptohashripemdLayer {
  let result = crypto_hash_ripemd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_layer_add(a : CryptohashripemdLayer, b : CryptohashripemdLayer) -> CryptohashripemdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_layer_copy(s : CryptohashripemdLayer) -> CryptohashripemdLayer {
  let result = crypto_hash_ripemd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_layer_fill(s : CryptohashripemdLayer, v : Double) -> CryptohashripemdLayer {
  let result = crypto_hash_ripemd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_layer_min(s : CryptohashripemdLayer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_layer_max(s : CryptohashripemdLayer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_layer_to_string(s : CryptohashripemdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_buffer_make(size : Int) -> CryptohashripemdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_buffer_len(s : CryptohashripemdBuffer) -> Int { s.size }

pub fn crypto_hash_ripemd_buffer_get(s : CryptohashripemdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_buffer_set(s : CryptohashripemdBuffer, i : Int, v : Double) -> CryptohashripemdBuffer {
  let result = crypto_hash_ripemd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_buffer_sum(s : CryptohashripemdBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_buffer_mean(s : CryptohashripemdBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_buffer_scale(s : CryptohashripemdBuffer, f : Double) -> CryptohashripemdBuffer {
  let result = crypto_hash_ripemd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_buffer_add(a : CryptohashripemdBuffer, b : CryptohashripemdBuffer) -> CryptohashripemdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_buffer_copy(s : CryptohashripemdBuffer) -> CryptohashripemdBuffer {
  let result = crypto_hash_ripemd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_buffer_fill(s : CryptohashripemdBuffer, v : Double) -> CryptohashripemdBuffer {
  let result = crypto_hash_ripemd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_buffer_min(s : CryptohashripemdBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_buffer_max(s : CryptohashripemdBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_buffer_to_string(s : CryptohashripemdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_cursor_make(size : Int) -> CryptohashripemdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_cursor_len(s : CryptohashripemdCursor) -> Int { s.size }

pub fn crypto_hash_ripemd_cursor_get(s : CryptohashripemdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_cursor_set(s : CryptohashripemdCursor, i : Int, v : Double) -> CryptohashripemdCursor {
  let result = crypto_hash_ripemd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_cursor_sum(s : CryptohashripemdCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_cursor_mean(s : CryptohashripemdCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_cursor_scale(s : CryptohashripemdCursor, f : Double) -> CryptohashripemdCursor {
  let result = crypto_hash_ripemd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_cursor_add(a : CryptohashripemdCursor, b : CryptohashripemdCursor) -> CryptohashripemdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_cursor_copy(s : CryptohashripemdCursor) -> CryptohashripemdCursor {
  let result = crypto_hash_ripemd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_cursor_fill(s : CryptohashripemdCursor, v : Double) -> CryptohashripemdCursor {
  let result = crypto_hash_ripemd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_cursor_min(s : CryptohashripemdCursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_cursor_max(s : CryptohashripemdCursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_cursor_to_string(s : CryptohashripemdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_view_make(size : Int) -> CryptohashripemdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_view_len(s : CryptohashripemdView) -> Int { s.size }

pub fn crypto_hash_ripemd_view_get(s : CryptohashripemdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_view_set(s : CryptohashripemdView, i : Int, v : Double) -> CryptohashripemdView {
  let result = crypto_hash_ripemd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_view_sum(s : CryptohashripemdView) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_view_mean(s : CryptohashripemdView) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_view_scale(s : CryptohashripemdView, f : Double) -> CryptohashripemdView {
  let result = crypto_hash_ripemd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_view_add(a : CryptohashripemdView, b : CryptohashripemdView) -> CryptohashripemdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_view_copy(s : CryptohashripemdView) -> CryptohashripemdView {
  let result = crypto_hash_ripemd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_view_fill(s : CryptohashripemdView, v : Double) -> CryptohashripemdView {
  let result = crypto_hash_ripemd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_view_min(s : CryptohashripemdView) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_view_max(s : CryptohashripemdView) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_view_to_string(s : CryptohashripemdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_range_make(size : Int) -> CryptohashripemdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_range_len(s : CryptohashripemdRange) -> Int { s.size }

pub fn crypto_hash_ripemd_range_get(s : CryptohashripemdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_range_set(s : CryptohashripemdRange, i : Int, v : Double) -> CryptohashripemdRange {
  let result = crypto_hash_ripemd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_range_sum(s : CryptohashripemdRange) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_range_mean(s : CryptohashripemdRange) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_range_scale(s : CryptohashripemdRange, f : Double) -> CryptohashripemdRange {
  let result = crypto_hash_ripemd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_range_add(a : CryptohashripemdRange, b : CryptohashripemdRange) -> CryptohashripemdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_range_copy(s : CryptohashripemdRange) -> CryptohashripemdRange {
  let result = crypto_hash_ripemd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_range_fill(s : CryptohashripemdRange, v : Double) -> CryptohashripemdRange {
  let result = crypto_hash_ripemd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_range_min(s : CryptohashripemdRange) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_range_max(s : CryptohashripemdRange) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_range_to_string(s : CryptohashripemdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_slice_make(size : Int) -> CryptohashripemdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_slice_len(s : CryptohashripemdSlice) -> Int { s.size }

pub fn crypto_hash_ripemd_slice_get(s : CryptohashripemdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_slice_set(s : CryptohashripemdSlice, i : Int, v : Double) -> CryptohashripemdSlice {
  let result = crypto_hash_ripemd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_slice_sum(s : CryptohashripemdSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_slice_mean(s : CryptohashripemdSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_slice_scale(s : CryptohashripemdSlice, f : Double) -> CryptohashripemdSlice {
  let result = crypto_hash_ripemd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_ripemd_slice_add(a : CryptohashripemdSlice, b : CryptohashripemdSlice) -> CryptohashripemdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_ripemd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_ripemd_slice_copy(s : CryptohashripemdSlice) -> CryptohashripemdSlice {
  let result = crypto_hash_ripemd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_ripemd_slice_fill(s : CryptohashripemdSlice, v : Double) -> CryptohashripemdSlice {
  let result = crypto_hash_ripemd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_ripemd_slice_min(s : CryptohashripemdSlice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_slice_max(s : CryptohashripemdSlice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_slice_to_string(s : CryptohashripemdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

