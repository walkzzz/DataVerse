///===
/// extcore/crypto_hash_groestl

pub(all) struct CryptohashgroestlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_groestl_make_point(x : Double, y : Double) -> CryptohashgroestlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_groestl_make_point3(x : Double, y : Double, z : Double) -> CryptohashgroestlPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_hash_groestl_point_x(pt : CryptohashgroestlPoint) -> Double { pt.x }

pub fn crypto_hash_groestl_point_y(pt : CryptohashgroestlPoint) -> Double { pt.y }

pub fn crypto_hash_groestl_point_z(pt : CryptohashgroestlPoint) -> Double { pt.z }

pub fn crypto_hash_groestl_point_label(pt : CryptohashgroestlPoint) -> Int { pt.label }

pub fn crypto_hash_groestl_point_dist(a : CryptohashgroestlPoint, b : CryptohashgroestlPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_hash_groestl_point_add(a : CryptohashgroestlPoint, b : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_hash_groestl_point_sub(a : CryptohashgroestlPoint, b : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_hash_groestl_point_scale(pt : CryptohashgroestlPoint, s : Double) -> CryptohashgroestlPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_hash_groestl_point_dot(a : CryptohashgroestlPoint, b : CryptohashgroestlPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_hash_groestl_point_cross(a : CryptohashgroestlPoint, b : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_hash_groestl_point_norm(pt : CryptohashgroestlPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_hash_groestl_point_normalize(pt : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  let n = crypto_hash_groestl_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_hash_groestl_point_scale(pt, 1.0 / n) }
}

pub fn crypto_hash_groestl_point_negate(pt : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_hash_groestl_point_mid(a : CryptohashgroestlPoint, b : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_hash_groestl_point_lerp(a : CryptohashgroestlPoint, b : CryptohashgroestlPoint, t : Double) -> CryptohashgroestlPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_hash_groestl_point_to_string(pt : CryptohashgroestlPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptohashgroestlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_groestl_make_series(vals : Array[Double], name : String) -> CryptohashgroestlSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_hash_groestl_series_len(s : CryptohashgroestlSeries) -> Int { s.vals.length() }

pub fn crypto_hash_groestl_series_sum(s : CryptohashgroestlSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_hash_groestl_series_mean(s : CryptohashgroestlSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_hash_groestl_series_min(s : CryptohashgroestlSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_hash_groestl_series_max(s : CryptohashgroestlSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_hash_groestl_series_range(s : CryptohashgroestlSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_hash_groestl_series_var(s : CryptohashgroestlSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_hash_groestl_series_std(s : CryptohashgroestlSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_hash_groestl_series_median(s : CryptohashgroestlSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_hash_groestl_series_scale(s : CryptohashgroestlSeries, f : Double) -> CryptohashgroestlSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_hash_groestl_series_add(a : CryptohashgroestlSeries, b : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_hash_groestl_series_sub(a : CryptohashgroestlSeries, b : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_hash_groestl_series_normalize(s : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  let mn = crypto_hash_groestl_series_min(s)
  let mx = crypto_hash_groestl_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_hash_groestl_series_cumsum(s : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_hash_groestl_series_to_string(s : CryptohashgroestlSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashgroestlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_groestl_make_matrix(rows : Int, cols : Int, val : Double) -> CryptohashgroestlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_groestl_matrix_identity(n : Int) -> CryptohashgroestlMatrix {
  let m = crypto_hash_groestl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_hash_groestl_matrix_get(m : CryptohashgroestlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_hash_groestl_matrix_transpose(m : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  let result = crypto_hash_groestl_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_hash_groestl_matrix_add(a : CryptohashgroestlMatrix, b : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_hash_groestl_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_hash_groestl_matrix_scale(m : CryptohashgroestlMatrix, s : Double) -> CryptohashgroestlMatrix {
  let result = crypto_hash_groestl_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_hash_groestl_matrix_multiply(a : CryptohashgroestlMatrix, b : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  if a.cols != b.rows { return crypto_hash_groestl_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_hash_groestl_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_hash_groestl_matrix_trace(m : CryptohashgroestlMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_hash_groestl_matrix_det(m : CryptohashgroestlMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_hash_groestl_matrix_norm(m : CryptohashgroestlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_hash_groestl_matrix_to_string(m : CryptohashgroestlMatrix) -> String {
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

pub(all) struct CryptohashgroestlVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_groestl_make_vector(comps : Array[Double]) -> CryptohashgroestlVector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_groestl_vector_zero(dim : Int) -> CryptohashgroestlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_hash_groestl_vector_add(a : CryptohashgroestlVector, b : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_groestl_vector_sub(a : CryptohashgroestlVector, b : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_hash_groestl_vector_scale(v : CryptohashgroestlVector, s : Double) -> CryptohashgroestlVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_hash_groestl_vector_dot(a : CryptohashgroestlVector, b : CryptohashgroestlVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_hash_groestl_vector_norm(v : CryptohashgroestlVector) -> Double { @_common.sqrt(crypto_hash_groestl_vector_dot(v, v)) }

pub fn crypto_hash_groestl_vector_normalize(v : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = crypto_hash_groestl_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_hash_groestl_vector_scale(v, 1.0 / n) }
}

pub fn crypto_hash_groestl_vector_dist(a : CryptohashgroestlVector, b : CryptohashgroestlVector) -> Double {
  crypto_hash_groestl_vector_norm(crypto_hash_groestl_vector_sub(a, b))
}

pub fn crypto_hash_groestl_vector_to_string(v : CryptohashgroestlVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_groestl_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_groestl_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_groestl_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_groestl_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_groestl_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_groestl_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_groestl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_groestl_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_groestl_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_groestl_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_groestl_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_groestl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_groestl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_groestl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_groestl_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_groestl_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_groestl_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_groestl_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_groestl_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_groestl_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_groestl_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_groestl_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_groestl_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_groestl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_groestl_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_groestl_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_groestl_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_groestl_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_groestl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptohashgroestlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_frame_make(size : Int) -> CryptohashgroestlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_frame_len(s : CryptohashgroestlFrame) -> Int { s.size }

pub fn crypto_hash_groestl_frame_get(s : CryptohashgroestlFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_frame_set(s : CryptohashgroestlFrame, i : Int, v : Double) -> CryptohashgroestlFrame {
  let result = crypto_hash_groestl_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_frame_sum(s : CryptohashgroestlFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_frame_mean(s : CryptohashgroestlFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_frame_scale(s : CryptohashgroestlFrame, f : Double) -> CryptohashgroestlFrame {
  let result = crypto_hash_groestl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_frame_add(a : CryptohashgroestlFrame, b : CryptohashgroestlFrame) -> CryptohashgroestlFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_frame_copy(s : CryptohashgroestlFrame) -> CryptohashgroestlFrame {
  let result = crypto_hash_groestl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_frame_fill(s : CryptohashgroestlFrame, v : Double) -> CryptohashgroestlFrame {
  let result = crypto_hash_groestl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_frame_min(s : CryptohashgroestlFrame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_frame_max(s : CryptohashgroestlFrame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_frame_to_string(s : CryptohashgroestlFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_table_make(size : Int) -> CryptohashgroestlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_table_len(s : CryptohashgroestlTable) -> Int { s.size }

pub fn crypto_hash_groestl_table_get(s : CryptohashgroestlTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_table_set(s : CryptohashgroestlTable, i : Int, v : Double) -> CryptohashgroestlTable {
  let result = crypto_hash_groestl_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_table_sum(s : CryptohashgroestlTable) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_table_mean(s : CryptohashgroestlTable) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_table_scale(s : CryptohashgroestlTable, f : Double) -> CryptohashgroestlTable {
  let result = crypto_hash_groestl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_table_add(a : CryptohashgroestlTable, b : CryptohashgroestlTable) -> CryptohashgroestlTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_table_copy(s : CryptohashgroestlTable) -> CryptohashgroestlTable {
  let result = crypto_hash_groestl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_table_fill(s : CryptohashgroestlTable, v : Double) -> CryptohashgroestlTable {
  let result = crypto_hash_groestl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_table_min(s : CryptohashgroestlTable) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_table_max(s : CryptohashgroestlTable) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_table_to_string(s : CryptohashgroestlTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_graphn_make(size : Int) -> CryptohashgroestlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_graphn_len(s : CryptohashgroestlGraphN) -> Int { s.size }

pub fn crypto_hash_groestl_graphn_get(s : CryptohashgroestlGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_graphn_set(s : CryptohashgroestlGraphN, i : Int, v : Double) -> CryptohashgroestlGraphN {
  let result = crypto_hash_groestl_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_graphn_sum(s : CryptohashgroestlGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_graphn_mean(s : CryptohashgroestlGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_graphn_scale(s : CryptohashgroestlGraphN, f : Double) -> CryptohashgroestlGraphN {
  let result = crypto_hash_groestl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_graphn_add(a : CryptohashgroestlGraphN, b : CryptohashgroestlGraphN) -> CryptohashgroestlGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_graphn_copy(s : CryptohashgroestlGraphN) -> CryptohashgroestlGraphN {
  let result = crypto_hash_groestl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_graphn_fill(s : CryptohashgroestlGraphN, v : Double) -> CryptohashgroestlGraphN {
  let result = crypto_hash_groestl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_graphn_min(s : CryptohashgroestlGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_graphn_max(s : CryptohashgroestlGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_graphn_to_string(s : CryptohashgroestlGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_node_make(size : Int) -> CryptohashgroestlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_node_len(s : CryptohashgroestlNode) -> Int { s.size }

pub fn crypto_hash_groestl_node_get(s : CryptohashgroestlNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_node_set(s : CryptohashgroestlNode, i : Int, v : Double) -> CryptohashgroestlNode {
  let result = crypto_hash_groestl_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_node_sum(s : CryptohashgroestlNode) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_node_mean(s : CryptohashgroestlNode) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_node_scale(s : CryptohashgroestlNode, f : Double) -> CryptohashgroestlNode {
  let result = crypto_hash_groestl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_node_add(a : CryptohashgroestlNode, b : CryptohashgroestlNode) -> CryptohashgroestlNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_node_copy(s : CryptohashgroestlNode) -> CryptohashgroestlNode {
  let result = crypto_hash_groestl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_node_fill(s : CryptohashgroestlNode, v : Double) -> CryptohashgroestlNode {
  let result = crypto_hash_groestl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_node_min(s : CryptohashgroestlNode) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_node_max(s : CryptohashgroestlNode) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_node_to_string(s : CryptohashgroestlNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_edge_make(size : Int) -> CryptohashgroestlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_edge_len(s : CryptohashgroestlEdge) -> Int { s.size }

pub fn crypto_hash_groestl_edge_get(s : CryptohashgroestlEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_edge_set(s : CryptohashgroestlEdge, i : Int, v : Double) -> CryptohashgroestlEdge {
  let result = crypto_hash_groestl_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_edge_sum(s : CryptohashgroestlEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_edge_mean(s : CryptohashgroestlEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_edge_scale(s : CryptohashgroestlEdge, f : Double) -> CryptohashgroestlEdge {
  let result = crypto_hash_groestl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_edge_add(a : CryptohashgroestlEdge, b : CryptohashgroestlEdge) -> CryptohashgroestlEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_edge_copy(s : CryptohashgroestlEdge) -> CryptohashgroestlEdge {
  let result = crypto_hash_groestl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_edge_fill(s : CryptohashgroestlEdge, v : Double) -> CryptohashgroestlEdge {
  let result = crypto_hash_groestl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_edge_min(s : CryptohashgroestlEdge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_edge_max(s : CryptohashgroestlEdge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_edge_to_string(s : CryptohashgroestlEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_path_make(size : Int) -> CryptohashgroestlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_path_len(s : CryptohashgroestlPath) -> Int { s.size }

pub fn crypto_hash_groestl_path_get(s : CryptohashgroestlPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_path_set(s : CryptohashgroestlPath, i : Int, v : Double) -> CryptohashgroestlPath {
  let result = crypto_hash_groestl_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_path_sum(s : CryptohashgroestlPath) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_path_mean(s : CryptohashgroestlPath) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_path_scale(s : CryptohashgroestlPath, f : Double) -> CryptohashgroestlPath {
  let result = crypto_hash_groestl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_path_add(a : CryptohashgroestlPath, b : CryptohashgroestlPath) -> CryptohashgroestlPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_path_copy(s : CryptohashgroestlPath) -> CryptohashgroestlPath {
  let result = crypto_hash_groestl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_path_fill(s : CryptohashgroestlPath, v : Double) -> CryptohashgroestlPath {
  let result = crypto_hash_groestl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_path_min(s : CryptohashgroestlPath) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_path_max(s : CryptohashgroestlPath) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_path_to_string(s : CryptohashgroestlPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_cluster_make(size : Int) -> CryptohashgroestlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_cluster_len(s : CryptohashgroestlCluster) -> Int { s.size }

pub fn crypto_hash_groestl_cluster_get(s : CryptohashgroestlCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_cluster_set(s : CryptohashgroestlCluster, i : Int, v : Double) -> CryptohashgroestlCluster {
  let result = crypto_hash_groestl_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_cluster_sum(s : CryptohashgroestlCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_cluster_mean(s : CryptohashgroestlCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_cluster_scale(s : CryptohashgroestlCluster, f : Double) -> CryptohashgroestlCluster {
  let result = crypto_hash_groestl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_cluster_add(a : CryptohashgroestlCluster, b : CryptohashgroestlCluster) -> CryptohashgroestlCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_cluster_copy(s : CryptohashgroestlCluster) -> CryptohashgroestlCluster {
  let result = crypto_hash_groestl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_cluster_fill(s : CryptohashgroestlCluster, v : Double) -> CryptohashgroestlCluster {
  let result = crypto_hash_groestl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_cluster_min(s : CryptohashgroestlCluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_cluster_max(s : CryptohashgroestlCluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_cluster_to_string(s : CryptohashgroestlCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_model_make(size : Int) -> CryptohashgroestlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_model_len(s : CryptohashgroestlModel) -> Int { s.size }

pub fn crypto_hash_groestl_model_get(s : CryptohashgroestlModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_model_set(s : CryptohashgroestlModel, i : Int, v : Double) -> CryptohashgroestlModel {
  let result = crypto_hash_groestl_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_model_sum(s : CryptohashgroestlModel) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_model_mean(s : CryptohashgroestlModel) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_model_scale(s : CryptohashgroestlModel, f : Double) -> CryptohashgroestlModel {
  let result = crypto_hash_groestl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_model_add(a : CryptohashgroestlModel, b : CryptohashgroestlModel) -> CryptohashgroestlModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_model_copy(s : CryptohashgroestlModel) -> CryptohashgroestlModel {
  let result = crypto_hash_groestl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_model_fill(s : CryptohashgroestlModel, v : Double) -> CryptohashgroestlModel {
  let result = crypto_hash_groestl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_model_min(s : CryptohashgroestlModel) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_model_max(s : CryptohashgroestlModel) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_model_to_string(s : CryptohashgroestlModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_layer_make(size : Int) -> CryptohashgroestlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_layer_len(s : CryptohashgroestlLayer) -> Int { s.size }

pub fn crypto_hash_groestl_layer_get(s : CryptohashgroestlLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_layer_set(s : CryptohashgroestlLayer, i : Int, v : Double) -> CryptohashgroestlLayer {
  let result = crypto_hash_groestl_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_layer_sum(s : CryptohashgroestlLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_layer_mean(s : CryptohashgroestlLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_layer_scale(s : CryptohashgroestlLayer, f : Double) -> CryptohashgroestlLayer {
  let result = crypto_hash_groestl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_layer_add(a : CryptohashgroestlLayer, b : CryptohashgroestlLayer) -> CryptohashgroestlLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_layer_copy(s : CryptohashgroestlLayer) -> CryptohashgroestlLayer {
  let result = crypto_hash_groestl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_layer_fill(s : CryptohashgroestlLayer, v : Double) -> CryptohashgroestlLayer {
  let result = crypto_hash_groestl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_layer_min(s : CryptohashgroestlLayer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_layer_max(s : CryptohashgroestlLayer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_layer_to_string(s : CryptohashgroestlLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_buffer_make(size : Int) -> CryptohashgroestlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_buffer_len(s : CryptohashgroestlBuffer) -> Int { s.size }

pub fn crypto_hash_groestl_buffer_get(s : CryptohashgroestlBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_buffer_set(s : CryptohashgroestlBuffer, i : Int, v : Double) -> CryptohashgroestlBuffer {
  let result = crypto_hash_groestl_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_buffer_sum(s : CryptohashgroestlBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_buffer_mean(s : CryptohashgroestlBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_buffer_scale(s : CryptohashgroestlBuffer, f : Double) -> CryptohashgroestlBuffer {
  let result = crypto_hash_groestl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_buffer_add(a : CryptohashgroestlBuffer, b : CryptohashgroestlBuffer) -> CryptohashgroestlBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_buffer_copy(s : CryptohashgroestlBuffer) -> CryptohashgroestlBuffer {
  let result = crypto_hash_groestl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_buffer_fill(s : CryptohashgroestlBuffer, v : Double) -> CryptohashgroestlBuffer {
  let result = crypto_hash_groestl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_buffer_min(s : CryptohashgroestlBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_buffer_max(s : CryptohashgroestlBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_buffer_to_string(s : CryptohashgroestlBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_cursor_make(size : Int) -> CryptohashgroestlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_cursor_len(s : CryptohashgroestlCursor) -> Int { s.size }

pub fn crypto_hash_groestl_cursor_get(s : CryptohashgroestlCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_cursor_set(s : CryptohashgroestlCursor, i : Int, v : Double) -> CryptohashgroestlCursor {
  let result = crypto_hash_groestl_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_cursor_sum(s : CryptohashgroestlCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_cursor_mean(s : CryptohashgroestlCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_cursor_scale(s : CryptohashgroestlCursor, f : Double) -> CryptohashgroestlCursor {
  let result = crypto_hash_groestl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_cursor_add(a : CryptohashgroestlCursor, b : CryptohashgroestlCursor) -> CryptohashgroestlCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_cursor_copy(s : CryptohashgroestlCursor) -> CryptohashgroestlCursor {
  let result = crypto_hash_groestl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_cursor_fill(s : CryptohashgroestlCursor, v : Double) -> CryptohashgroestlCursor {
  let result = crypto_hash_groestl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_cursor_min(s : CryptohashgroestlCursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_cursor_max(s : CryptohashgroestlCursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_cursor_to_string(s : CryptohashgroestlCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_view_make(size : Int) -> CryptohashgroestlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_view_len(s : CryptohashgroestlView) -> Int { s.size }

pub fn crypto_hash_groestl_view_get(s : CryptohashgroestlView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_view_set(s : CryptohashgroestlView, i : Int, v : Double) -> CryptohashgroestlView {
  let result = crypto_hash_groestl_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_view_sum(s : CryptohashgroestlView) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_view_mean(s : CryptohashgroestlView) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_view_scale(s : CryptohashgroestlView, f : Double) -> CryptohashgroestlView {
  let result = crypto_hash_groestl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_view_add(a : CryptohashgroestlView, b : CryptohashgroestlView) -> CryptohashgroestlView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_view_copy(s : CryptohashgroestlView) -> CryptohashgroestlView {
  let result = crypto_hash_groestl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_view_fill(s : CryptohashgroestlView, v : Double) -> CryptohashgroestlView {
  let result = crypto_hash_groestl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_view_min(s : CryptohashgroestlView) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_view_max(s : CryptohashgroestlView) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_view_to_string(s : CryptohashgroestlView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_range_make(size : Int) -> CryptohashgroestlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_range_len(s : CryptohashgroestlRange) -> Int { s.size }

pub fn crypto_hash_groestl_range_get(s : CryptohashgroestlRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_range_set(s : CryptohashgroestlRange, i : Int, v : Double) -> CryptohashgroestlRange {
  let result = crypto_hash_groestl_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_range_sum(s : CryptohashgroestlRange) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_range_mean(s : CryptohashgroestlRange) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_range_scale(s : CryptohashgroestlRange, f : Double) -> CryptohashgroestlRange {
  let result = crypto_hash_groestl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_range_add(a : CryptohashgroestlRange, b : CryptohashgroestlRange) -> CryptohashgroestlRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_range_copy(s : CryptohashgroestlRange) -> CryptohashgroestlRange {
  let result = crypto_hash_groestl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_range_fill(s : CryptohashgroestlRange, v : Double) -> CryptohashgroestlRange {
  let result = crypto_hash_groestl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_range_min(s : CryptohashgroestlRange) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_range_max(s : CryptohashgroestlRange) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_range_to_string(s : CryptohashgroestlRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_slice_make(size : Int) -> CryptohashgroestlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_slice_len(s : CryptohashgroestlSlice) -> Int { s.size }

pub fn crypto_hash_groestl_slice_get(s : CryptohashgroestlSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_slice_set(s : CryptohashgroestlSlice, i : Int, v : Double) -> CryptohashgroestlSlice {
  let result = crypto_hash_groestl_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_slice_sum(s : CryptohashgroestlSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_slice_mean(s : CryptohashgroestlSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_slice_scale(s : CryptohashgroestlSlice, f : Double) -> CryptohashgroestlSlice {
  let result = crypto_hash_groestl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_hash_groestl_slice_add(a : CryptohashgroestlSlice, b : CryptohashgroestlSlice) -> CryptohashgroestlSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_hash_groestl_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_hash_groestl_slice_copy(s : CryptohashgroestlSlice) -> CryptohashgroestlSlice {
  let result = crypto_hash_groestl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_hash_groestl_slice_fill(s : CryptohashgroestlSlice, v : Double) -> CryptohashgroestlSlice {
  let result = crypto_hash_groestl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_hash_groestl_slice_min(s : CryptohashgroestlSlice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_slice_max(s : CryptohashgroestlSlice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_slice_to_string(s : CryptohashgroestlSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

