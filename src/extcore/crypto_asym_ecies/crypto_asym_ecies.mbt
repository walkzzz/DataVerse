///===
/// extcore/crypto_asym_ecies

pub(all) struct CryptoasymeciesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_ecies_make_point(x : Double, y : Double) -> CryptoasymeciesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_ecies_make_point3(x : Double, y : Double, z : Double) -> CryptoasymeciesPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_ecies_point_x(pt : CryptoasymeciesPoint) -> Double { pt.x }

pub fn crypto_asym_ecies_point_y(pt : CryptoasymeciesPoint) -> Double { pt.y }

pub fn crypto_asym_ecies_point_z(pt : CryptoasymeciesPoint) -> Double { pt.z }

pub fn crypto_asym_ecies_point_label(pt : CryptoasymeciesPoint) -> Int { pt.label }

pub fn crypto_asym_ecies_point_dist(a : CryptoasymeciesPoint, b : CryptoasymeciesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_ecies_point_add(a : CryptoasymeciesPoint, b : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_ecies_point_sub(a : CryptoasymeciesPoint, b : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_ecies_point_scale(pt : CryptoasymeciesPoint, s : Double) -> CryptoasymeciesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_ecies_point_dot(a : CryptoasymeciesPoint, b : CryptoasymeciesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_ecies_point_cross(a : CryptoasymeciesPoint, b : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_ecies_point_norm(pt : CryptoasymeciesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_ecies_point_normalize(pt : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  let n = crypto_asym_ecies_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_ecies_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_ecies_point_negate(pt : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_ecies_point_mid(a : CryptoasymeciesPoint, b : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_ecies_point_lerp(a : CryptoasymeciesPoint, b : CryptoasymeciesPoint, t : Double) -> CryptoasymeciesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_ecies_point_to_string(pt : CryptoasymeciesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptoasymeciesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_ecies_make_series(vals : Array[Double], name : String) -> CryptoasymeciesSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_ecies_series_len(s : CryptoasymeciesSeries) -> Int { s.vals.length() }

pub fn crypto_asym_ecies_series_sum(s : CryptoasymeciesSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_asym_ecies_series_mean(s : CryptoasymeciesSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_asym_ecies_series_min(s : CryptoasymeciesSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_asym_ecies_series_max(s : CryptoasymeciesSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_asym_ecies_series_range(s : CryptoasymeciesSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_asym_ecies_series_var(s : CryptoasymeciesSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_asym_ecies_series_std(s : CryptoasymeciesSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_asym_ecies_series_median(s : CryptoasymeciesSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_asym_ecies_series_scale(s : CryptoasymeciesSeries, f : Double) -> CryptoasymeciesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_asym_ecies_series_add(a : CryptoasymeciesSeries, b : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_ecies_series_sub(a : CryptoasymeciesSeries, b : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_ecies_series_normalize(s : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  let mn = crypto_asym_ecies_series_min(s)
  let mx = crypto_asym_ecies_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_ecies_series_cumsum(s : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_ecies_series_to_string(s : CryptoasymeciesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeciesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_ecies_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymeciesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_ecies_matrix_identity(n : Int) -> CryptoasymeciesMatrix {
  let m = crypto_asym_ecies_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_ecies_matrix_get(m : CryptoasymeciesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_ecies_matrix_transpose(m : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  let result = crypto_asym_ecies_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_ecies_matrix_add(a : CryptoasymeciesMatrix, b : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_ecies_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_ecies_matrix_scale(m : CryptoasymeciesMatrix, s : Double) -> CryptoasymeciesMatrix {
  let result = crypto_asym_ecies_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_ecies_matrix_multiply(a : CryptoasymeciesMatrix, b : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  if a.cols != b.rows { return crypto_asym_ecies_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_ecies_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_ecies_matrix_trace(m : CryptoasymeciesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_ecies_matrix_det(m : CryptoasymeciesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_ecies_matrix_norm(m : CryptoasymeciesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_asym_ecies_matrix_to_string(m : CryptoasymeciesMatrix) -> String {
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

pub(all) struct CryptoasymeciesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_ecies_make_vector(comps : Array[Double]) -> CryptoasymeciesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_ecies_vector_zero(dim : Int) -> CryptoasymeciesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_ecies_vector_add(a : CryptoasymeciesVector, b : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_ecies_vector_sub(a : CryptoasymeciesVector, b : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_ecies_vector_scale(v : CryptoasymeciesVector, s : Double) -> CryptoasymeciesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_asym_ecies_vector_dot(a : CryptoasymeciesVector, b : CryptoasymeciesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_ecies_vector_norm(v : CryptoasymeciesVector) -> Double { @_common.sqrt(crypto_asym_ecies_vector_dot(v, v)) }

pub fn crypto_asym_ecies_vector_normalize(v : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = crypto_asym_ecies_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_ecies_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_ecies_vector_dist(a : CryptoasymeciesVector, b : CryptoasymeciesVector) -> Double {
  crypto_asym_ecies_vector_norm(crypto_asym_ecies_vector_sub(a, b))
}

pub fn crypto_asym_ecies_vector_to_string(v : CryptoasymeciesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_ecies_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_ecies_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_ecies_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_ecies_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_ecies_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_ecies_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_ecies_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_ecies_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_ecies_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_ecies_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_ecies_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_ecies_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_ecies_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_ecies_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_ecies_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_ecies_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_ecies_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_ecies_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_ecies_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_ecies_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_ecies_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_ecies_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_ecies_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_ecies_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_ecies_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_ecies_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_ecies_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_ecies_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_ecies_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymeciesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_frame_make(size : Int) -> CryptoasymeciesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_frame_len(s : CryptoasymeciesFrame) -> Int { s.size }

pub fn crypto_asym_ecies_frame_get(s : CryptoasymeciesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_frame_set(s : CryptoasymeciesFrame, i : Int, v : Double) -> CryptoasymeciesFrame {
  let result = crypto_asym_ecies_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_frame_sum(s : CryptoasymeciesFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_frame_mean(s : CryptoasymeciesFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_frame_scale(s : CryptoasymeciesFrame, f : Double) -> CryptoasymeciesFrame {
  let result = crypto_asym_ecies_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_frame_add(a : CryptoasymeciesFrame, b : CryptoasymeciesFrame) -> CryptoasymeciesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_frame_copy(s : CryptoasymeciesFrame) -> CryptoasymeciesFrame {
  let result = crypto_asym_ecies_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_frame_fill(s : CryptoasymeciesFrame, v : Double) -> CryptoasymeciesFrame {
  let result = crypto_asym_ecies_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_frame_min(s : CryptoasymeciesFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_frame_max(s : CryptoasymeciesFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_frame_to_string(s : CryptoasymeciesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_table_make(size : Int) -> CryptoasymeciesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_table_len(s : CryptoasymeciesTable) -> Int { s.size }

pub fn crypto_asym_ecies_table_get(s : CryptoasymeciesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_table_set(s : CryptoasymeciesTable, i : Int, v : Double) -> CryptoasymeciesTable {
  let result = crypto_asym_ecies_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_table_sum(s : CryptoasymeciesTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_table_mean(s : CryptoasymeciesTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_table_scale(s : CryptoasymeciesTable, f : Double) -> CryptoasymeciesTable {
  let result = crypto_asym_ecies_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_table_add(a : CryptoasymeciesTable, b : CryptoasymeciesTable) -> CryptoasymeciesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_table_copy(s : CryptoasymeciesTable) -> CryptoasymeciesTable {
  let result = crypto_asym_ecies_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_table_fill(s : CryptoasymeciesTable, v : Double) -> CryptoasymeciesTable {
  let result = crypto_asym_ecies_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_table_min(s : CryptoasymeciesTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_table_max(s : CryptoasymeciesTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_table_to_string(s : CryptoasymeciesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_graphn_make(size : Int) -> CryptoasymeciesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_graphn_len(s : CryptoasymeciesGraphN) -> Int { s.size }

pub fn crypto_asym_ecies_graphn_get(s : CryptoasymeciesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_graphn_set(s : CryptoasymeciesGraphN, i : Int, v : Double) -> CryptoasymeciesGraphN {
  let result = crypto_asym_ecies_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_graphn_sum(s : CryptoasymeciesGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_graphn_mean(s : CryptoasymeciesGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_graphn_scale(s : CryptoasymeciesGraphN, f : Double) -> CryptoasymeciesGraphN {
  let result = crypto_asym_ecies_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_graphn_add(a : CryptoasymeciesGraphN, b : CryptoasymeciesGraphN) -> CryptoasymeciesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_graphn_copy(s : CryptoasymeciesGraphN) -> CryptoasymeciesGraphN {
  let result = crypto_asym_ecies_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_graphn_fill(s : CryptoasymeciesGraphN, v : Double) -> CryptoasymeciesGraphN {
  let result = crypto_asym_ecies_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_graphn_min(s : CryptoasymeciesGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_graphn_max(s : CryptoasymeciesGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_graphn_to_string(s : CryptoasymeciesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_node_make(size : Int) -> CryptoasymeciesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_node_len(s : CryptoasymeciesNode) -> Int { s.size }

pub fn crypto_asym_ecies_node_get(s : CryptoasymeciesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_node_set(s : CryptoasymeciesNode, i : Int, v : Double) -> CryptoasymeciesNode {
  let result = crypto_asym_ecies_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_node_sum(s : CryptoasymeciesNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_node_mean(s : CryptoasymeciesNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_node_scale(s : CryptoasymeciesNode, f : Double) -> CryptoasymeciesNode {
  let result = crypto_asym_ecies_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_node_add(a : CryptoasymeciesNode, b : CryptoasymeciesNode) -> CryptoasymeciesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_node_copy(s : CryptoasymeciesNode) -> CryptoasymeciesNode {
  let result = crypto_asym_ecies_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_node_fill(s : CryptoasymeciesNode, v : Double) -> CryptoasymeciesNode {
  let result = crypto_asym_ecies_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_node_min(s : CryptoasymeciesNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_node_max(s : CryptoasymeciesNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_node_to_string(s : CryptoasymeciesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_edge_make(size : Int) -> CryptoasymeciesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_edge_len(s : CryptoasymeciesEdge) -> Int { s.size }

pub fn crypto_asym_ecies_edge_get(s : CryptoasymeciesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_edge_set(s : CryptoasymeciesEdge, i : Int, v : Double) -> CryptoasymeciesEdge {
  let result = crypto_asym_ecies_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_edge_sum(s : CryptoasymeciesEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_edge_mean(s : CryptoasymeciesEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_edge_scale(s : CryptoasymeciesEdge, f : Double) -> CryptoasymeciesEdge {
  let result = crypto_asym_ecies_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_edge_add(a : CryptoasymeciesEdge, b : CryptoasymeciesEdge) -> CryptoasymeciesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_edge_copy(s : CryptoasymeciesEdge) -> CryptoasymeciesEdge {
  let result = crypto_asym_ecies_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_edge_fill(s : CryptoasymeciesEdge, v : Double) -> CryptoasymeciesEdge {
  let result = crypto_asym_ecies_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_edge_min(s : CryptoasymeciesEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_edge_max(s : CryptoasymeciesEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_edge_to_string(s : CryptoasymeciesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_path_make(size : Int) -> CryptoasymeciesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_path_len(s : CryptoasymeciesPath) -> Int { s.size }

pub fn crypto_asym_ecies_path_get(s : CryptoasymeciesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_path_set(s : CryptoasymeciesPath, i : Int, v : Double) -> CryptoasymeciesPath {
  let result = crypto_asym_ecies_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_path_sum(s : CryptoasymeciesPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_path_mean(s : CryptoasymeciesPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_path_scale(s : CryptoasymeciesPath, f : Double) -> CryptoasymeciesPath {
  let result = crypto_asym_ecies_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_path_add(a : CryptoasymeciesPath, b : CryptoasymeciesPath) -> CryptoasymeciesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_path_copy(s : CryptoasymeciesPath) -> CryptoasymeciesPath {
  let result = crypto_asym_ecies_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_path_fill(s : CryptoasymeciesPath, v : Double) -> CryptoasymeciesPath {
  let result = crypto_asym_ecies_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_path_min(s : CryptoasymeciesPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_path_max(s : CryptoasymeciesPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_path_to_string(s : CryptoasymeciesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_cluster_make(size : Int) -> CryptoasymeciesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_cluster_len(s : CryptoasymeciesCluster) -> Int { s.size }

pub fn crypto_asym_ecies_cluster_get(s : CryptoasymeciesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_cluster_set(s : CryptoasymeciesCluster, i : Int, v : Double) -> CryptoasymeciesCluster {
  let result = crypto_asym_ecies_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_cluster_sum(s : CryptoasymeciesCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_cluster_mean(s : CryptoasymeciesCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_cluster_scale(s : CryptoasymeciesCluster, f : Double) -> CryptoasymeciesCluster {
  let result = crypto_asym_ecies_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_cluster_add(a : CryptoasymeciesCluster, b : CryptoasymeciesCluster) -> CryptoasymeciesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_cluster_copy(s : CryptoasymeciesCluster) -> CryptoasymeciesCluster {
  let result = crypto_asym_ecies_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_cluster_fill(s : CryptoasymeciesCluster, v : Double) -> CryptoasymeciesCluster {
  let result = crypto_asym_ecies_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_cluster_min(s : CryptoasymeciesCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_cluster_max(s : CryptoasymeciesCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_cluster_to_string(s : CryptoasymeciesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_model_make(size : Int) -> CryptoasymeciesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_model_len(s : CryptoasymeciesModel) -> Int { s.size }

pub fn crypto_asym_ecies_model_get(s : CryptoasymeciesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_model_set(s : CryptoasymeciesModel, i : Int, v : Double) -> CryptoasymeciesModel {
  let result = crypto_asym_ecies_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_model_sum(s : CryptoasymeciesModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_model_mean(s : CryptoasymeciesModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_model_scale(s : CryptoasymeciesModel, f : Double) -> CryptoasymeciesModel {
  let result = crypto_asym_ecies_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_model_add(a : CryptoasymeciesModel, b : CryptoasymeciesModel) -> CryptoasymeciesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_model_copy(s : CryptoasymeciesModel) -> CryptoasymeciesModel {
  let result = crypto_asym_ecies_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_model_fill(s : CryptoasymeciesModel, v : Double) -> CryptoasymeciesModel {
  let result = crypto_asym_ecies_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_model_min(s : CryptoasymeciesModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_model_max(s : CryptoasymeciesModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_model_to_string(s : CryptoasymeciesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_layer_make(size : Int) -> CryptoasymeciesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_layer_len(s : CryptoasymeciesLayer) -> Int { s.size }

pub fn crypto_asym_ecies_layer_get(s : CryptoasymeciesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_layer_set(s : CryptoasymeciesLayer, i : Int, v : Double) -> CryptoasymeciesLayer {
  let result = crypto_asym_ecies_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_layer_sum(s : CryptoasymeciesLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_layer_mean(s : CryptoasymeciesLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_layer_scale(s : CryptoasymeciesLayer, f : Double) -> CryptoasymeciesLayer {
  let result = crypto_asym_ecies_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_layer_add(a : CryptoasymeciesLayer, b : CryptoasymeciesLayer) -> CryptoasymeciesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_layer_copy(s : CryptoasymeciesLayer) -> CryptoasymeciesLayer {
  let result = crypto_asym_ecies_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_layer_fill(s : CryptoasymeciesLayer, v : Double) -> CryptoasymeciesLayer {
  let result = crypto_asym_ecies_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_layer_min(s : CryptoasymeciesLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_layer_max(s : CryptoasymeciesLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_layer_to_string(s : CryptoasymeciesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_buffer_make(size : Int) -> CryptoasymeciesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_buffer_len(s : CryptoasymeciesBuffer) -> Int { s.size }

pub fn crypto_asym_ecies_buffer_get(s : CryptoasymeciesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_buffer_set(s : CryptoasymeciesBuffer, i : Int, v : Double) -> CryptoasymeciesBuffer {
  let result = crypto_asym_ecies_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_buffer_sum(s : CryptoasymeciesBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_buffer_mean(s : CryptoasymeciesBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_buffer_scale(s : CryptoasymeciesBuffer, f : Double) -> CryptoasymeciesBuffer {
  let result = crypto_asym_ecies_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_buffer_add(a : CryptoasymeciesBuffer, b : CryptoasymeciesBuffer) -> CryptoasymeciesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_buffer_copy(s : CryptoasymeciesBuffer) -> CryptoasymeciesBuffer {
  let result = crypto_asym_ecies_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_buffer_fill(s : CryptoasymeciesBuffer, v : Double) -> CryptoasymeciesBuffer {
  let result = crypto_asym_ecies_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_buffer_min(s : CryptoasymeciesBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_buffer_max(s : CryptoasymeciesBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_buffer_to_string(s : CryptoasymeciesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_cursor_make(size : Int) -> CryptoasymeciesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_cursor_len(s : CryptoasymeciesCursor) -> Int { s.size }

pub fn crypto_asym_ecies_cursor_get(s : CryptoasymeciesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_cursor_set(s : CryptoasymeciesCursor, i : Int, v : Double) -> CryptoasymeciesCursor {
  let result = crypto_asym_ecies_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_cursor_sum(s : CryptoasymeciesCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_cursor_mean(s : CryptoasymeciesCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_cursor_scale(s : CryptoasymeciesCursor, f : Double) -> CryptoasymeciesCursor {
  let result = crypto_asym_ecies_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_cursor_add(a : CryptoasymeciesCursor, b : CryptoasymeciesCursor) -> CryptoasymeciesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_cursor_copy(s : CryptoasymeciesCursor) -> CryptoasymeciesCursor {
  let result = crypto_asym_ecies_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_cursor_fill(s : CryptoasymeciesCursor, v : Double) -> CryptoasymeciesCursor {
  let result = crypto_asym_ecies_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_cursor_min(s : CryptoasymeciesCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_cursor_max(s : CryptoasymeciesCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_cursor_to_string(s : CryptoasymeciesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_view_make(size : Int) -> CryptoasymeciesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_view_len(s : CryptoasymeciesView) -> Int { s.size }

pub fn crypto_asym_ecies_view_get(s : CryptoasymeciesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_view_set(s : CryptoasymeciesView, i : Int, v : Double) -> CryptoasymeciesView {
  let result = crypto_asym_ecies_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_view_sum(s : CryptoasymeciesView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_view_mean(s : CryptoasymeciesView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_view_scale(s : CryptoasymeciesView, f : Double) -> CryptoasymeciesView {
  let result = crypto_asym_ecies_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_view_add(a : CryptoasymeciesView, b : CryptoasymeciesView) -> CryptoasymeciesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_view_copy(s : CryptoasymeciesView) -> CryptoasymeciesView {
  let result = crypto_asym_ecies_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_view_fill(s : CryptoasymeciesView, v : Double) -> CryptoasymeciesView {
  let result = crypto_asym_ecies_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_view_min(s : CryptoasymeciesView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_view_max(s : CryptoasymeciesView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_view_to_string(s : CryptoasymeciesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_range_make(size : Int) -> CryptoasymeciesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_range_len(s : CryptoasymeciesRange) -> Int { s.size }

pub fn crypto_asym_ecies_range_get(s : CryptoasymeciesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_range_set(s : CryptoasymeciesRange, i : Int, v : Double) -> CryptoasymeciesRange {
  let result = crypto_asym_ecies_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_range_sum(s : CryptoasymeciesRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_range_mean(s : CryptoasymeciesRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_range_scale(s : CryptoasymeciesRange, f : Double) -> CryptoasymeciesRange {
  let result = crypto_asym_ecies_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_range_add(a : CryptoasymeciesRange, b : CryptoasymeciesRange) -> CryptoasymeciesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_range_copy(s : CryptoasymeciesRange) -> CryptoasymeciesRange {
  let result = crypto_asym_ecies_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_range_fill(s : CryptoasymeciesRange, v : Double) -> CryptoasymeciesRange {
  let result = crypto_asym_ecies_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_range_min(s : CryptoasymeciesRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_range_max(s : CryptoasymeciesRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_range_to_string(s : CryptoasymeciesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_slice_make(size : Int) -> CryptoasymeciesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_slice_len(s : CryptoasymeciesSlice) -> Int { s.size }

pub fn crypto_asym_ecies_slice_get(s : CryptoasymeciesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_slice_set(s : CryptoasymeciesSlice, i : Int, v : Double) -> CryptoasymeciesSlice {
  let result = crypto_asym_ecies_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_slice_sum(s : CryptoasymeciesSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_slice_mean(s : CryptoasymeciesSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_slice_scale(s : CryptoasymeciesSlice, f : Double) -> CryptoasymeciesSlice {
  let result = crypto_asym_ecies_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecies_slice_add(a : CryptoasymeciesSlice, b : CryptoasymeciesSlice) -> CryptoasymeciesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecies_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecies_slice_copy(s : CryptoasymeciesSlice) -> CryptoasymeciesSlice {
  let result = crypto_asym_ecies_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecies_slice_fill(s : CryptoasymeciesSlice, v : Double) -> CryptoasymeciesSlice {
  let result = crypto_asym_ecies_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecies_slice_min(s : CryptoasymeciesSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_slice_max(s : CryptoasymeciesSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_slice_to_string(s : CryptoasymeciesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

