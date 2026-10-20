///===
/// extcore/crypto_asym_elgamal

pub(all) struct CryptoasymelgamalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_elgamal_make_point(x : Double, y : Double) -> CryptoasymelgamalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_elgamal_make_point3(x : Double, y : Double, z : Double) -> CryptoasymelgamalPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_elgamal_point_x(pt : CryptoasymelgamalPoint) -> Double { pt.x }

pub fn crypto_asym_elgamal_point_y(pt : CryptoasymelgamalPoint) -> Double { pt.y }

pub fn crypto_asym_elgamal_point_z(pt : CryptoasymelgamalPoint) -> Double { pt.z }

pub fn crypto_asym_elgamal_point_label(pt : CryptoasymelgamalPoint) -> Int { pt.label }

pub fn crypto_asym_elgamal_point_dist(a : CryptoasymelgamalPoint, b : CryptoasymelgamalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_elgamal_point_add(a : CryptoasymelgamalPoint, b : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_elgamal_point_sub(a : CryptoasymelgamalPoint, b : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_elgamal_point_scale(pt : CryptoasymelgamalPoint, s : Double) -> CryptoasymelgamalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_elgamal_point_dot(a : CryptoasymelgamalPoint, b : CryptoasymelgamalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_elgamal_point_cross(a : CryptoasymelgamalPoint, b : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_elgamal_point_norm(pt : CryptoasymelgamalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_elgamal_point_normalize(pt : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  let n = crypto_asym_elgamal_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_elgamal_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_elgamal_point_negate(pt : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_elgamal_point_mid(a : CryptoasymelgamalPoint, b : CryptoasymelgamalPoint) -> CryptoasymelgamalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_elgamal_point_lerp(a : CryptoasymelgamalPoint, b : CryptoasymelgamalPoint, t : Double) -> CryptoasymelgamalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_elgamal_point_to_string(pt : CryptoasymelgamalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptoasymelgamalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_elgamal_make_series(vals : Array[Double], name : String) -> CryptoasymelgamalSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_elgamal_series_len(s : CryptoasymelgamalSeries) -> Int { s.vals.length() }

pub fn crypto_asym_elgamal_series_sum(s : CryptoasymelgamalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_asym_elgamal_series_mean(s : CryptoasymelgamalSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_asym_elgamal_series_min(s : CryptoasymelgamalSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_asym_elgamal_series_max(s : CryptoasymelgamalSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_asym_elgamal_series_range(s : CryptoasymelgamalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_asym_elgamal_series_var(s : CryptoasymelgamalSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_asym_elgamal_series_std(s : CryptoasymelgamalSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_asym_elgamal_series_median(s : CryptoasymelgamalSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_asym_elgamal_series_scale(s : CryptoasymelgamalSeries, f : Double) -> CryptoasymelgamalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_asym_elgamal_series_add(a : CryptoasymelgamalSeries, b : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_elgamal_series_sub(a : CryptoasymelgamalSeries, b : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_elgamal_series_normalize(s : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  let mn = crypto_asym_elgamal_series_min(s)
  let mx = crypto_asym_elgamal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_elgamal_series_cumsum(s : CryptoasymelgamalSeries) -> CryptoasymelgamalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_elgamal_series_to_string(s : CryptoasymelgamalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymelgamalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_elgamal_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymelgamalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_elgamal_matrix_identity(n : Int) -> CryptoasymelgamalMatrix {
  let m = crypto_asym_elgamal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_elgamal_matrix_get(m : CryptoasymelgamalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_elgamal_matrix_transpose(m : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  let result = crypto_asym_elgamal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_elgamal_matrix_add(a : CryptoasymelgamalMatrix, b : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_elgamal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_elgamal_matrix_scale(m : CryptoasymelgamalMatrix, s : Double) -> CryptoasymelgamalMatrix {
  let result = crypto_asym_elgamal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_elgamal_matrix_multiply(a : CryptoasymelgamalMatrix, b : CryptoasymelgamalMatrix) -> CryptoasymelgamalMatrix {
  if a.cols != b.rows { return crypto_asym_elgamal_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_elgamal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_elgamal_matrix_trace(m : CryptoasymelgamalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_elgamal_matrix_det(m : CryptoasymelgamalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_elgamal_matrix_norm(m : CryptoasymelgamalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_asym_elgamal_matrix_to_string(m : CryptoasymelgamalMatrix) -> String {
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

pub(all) struct CryptoasymelgamalVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_elgamal_make_vector(comps : Array[Double]) -> CryptoasymelgamalVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_elgamal_vector_zero(dim : Int) -> CryptoasymelgamalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_elgamal_vector_add(a : CryptoasymelgamalVector, b : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_elgamal_vector_sub(a : CryptoasymelgamalVector, b : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_elgamal_vector_scale(v : CryptoasymelgamalVector, s : Double) -> CryptoasymelgamalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_asym_elgamal_vector_dot(a : CryptoasymelgamalVector, b : CryptoasymelgamalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_elgamal_vector_norm(v : CryptoasymelgamalVector) -> Double { @_common.sqrt(crypto_asym_elgamal_vector_dot(v, v)) }

pub fn crypto_asym_elgamal_vector_normalize(v : CryptoasymelgamalVector) -> CryptoasymelgamalVector {
  let n = crypto_asym_elgamal_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_elgamal_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_elgamal_vector_dist(a : CryptoasymelgamalVector, b : CryptoasymelgamalVector) -> Double {
  crypto_asym_elgamal_vector_norm(crypto_asym_elgamal_vector_sub(a, b))
}

pub fn crypto_asym_elgamal_vector_to_string(v : CryptoasymelgamalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_elgamal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_elgamal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_elgamal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_elgamal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_elgamal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_elgamal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_elgamal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_elgamal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_elgamal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_elgamal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_elgamal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_elgamal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_elgamal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_elgamal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_elgamal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_elgamal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_elgamal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_elgamal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_elgamal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_elgamal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_elgamal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_elgamal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_elgamal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_elgamal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_elgamal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_elgamal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_elgamal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_elgamal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_elgamal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymelgamalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_frame_make(size : Int) -> CryptoasymelgamalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_frame_len(s : CryptoasymelgamalFrame) -> Int { s.size }

pub fn crypto_asym_elgamal_frame_get(s : CryptoasymelgamalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_frame_set(s : CryptoasymelgamalFrame, i : Int, v : Double) -> CryptoasymelgamalFrame {
  let result = crypto_asym_elgamal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_frame_sum(s : CryptoasymelgamalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_frame_mean(s : CryptoasymelgamalFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_frame_scale(s : CryptoasymelgamalFrame, f : Double) -> CryptoasymelgamalFrame {
  let result = crypto_asym_elgamal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_frame_add(a : CryptoasymelgamalFrame, b : CryptoasymelgamalFrame) -> CryptoasymelgamalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_frame_copy(s : CryptoasymelgamalFrame) -> CryptoasymelgamalFrame {
  let result = crypto_asym_elgamal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_frame_fill(s : CryptoasymelgamalFrame, v : Double) -> CryptoasymelgamalFrame {
  let result = crypto_asym_elgamal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_frame_min(s : CryptoasymelgamalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_frame_max(s : CryptoasymelgamalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_frame_to_string(s : CryptoasymelgamalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_table_make(size : Int) -> CryptoasymelgamalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_table_len(s : CryptoasymelgamalTable) -> Int { s.size }

pub fn crypto_asym_elgamal_table_get(s : CryptoasymelgamalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_table_set(s : CryptoasymelgamalTable, i : Int, v : Double) -> CryptoasymelgamalTable {
  let result = crypto_asym_elgamal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_table_sum(s : CryptoasymelgamalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_table_mean(s : CryptoasymelgamalTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_table_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_table_scale(s : CryptoasymelgamalTable, f : Double) -> CryptoasymelgamalTable {
  let result = crypto_asym_elgamal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_table_add(a : CryptoasymelgamalTable, b : CryptoasymelgamalTable) -> CryptoasymelgamalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_table_copy(s : CryptoasymelgamalTable) -> CryptoasymelgamalTable {
  let result = crypto_asym_elgamal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_table_fill(s : CryptoasymelgamalTable, v : Double) -> CryptoasymelgamalTable {
  let result = crypto_asym_elgamal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_table_min(s : CryptoasymelgamalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_table_max(s : CryptoasymelgamalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_table_to_string(s : CryptoasymelgamalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_graphn_make(size : Int) -> CryptoasymelgamalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_graphn_len(s : CryptoasymelgamalGraphN) -> Int { s.size }

pub fn crypto_asym_elgamal_graphn_get(s : CryptoasymelgamalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_graphn_set(s : CryptoasymelgamalGraphN, i : Int, v : Double) -> CryptoasymelgamalGraphN {
  let result = crypto_asym_elgamal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_graphn_sum(s : CryptoasymelgamalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_graphn_mean(s : CryptoasymelgamalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_graphn_scale(s : CryptoasymelgamalGraphN, f : Double) -> CryptoasymelgamalGraphN {
  let result = crypto_asym_elgamal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_graphn_add(a : CryptoasymelgamalGraphN, b : CryptoasymelgamalGraphN) -> CryptoasymelgamalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_graphn_copy(s : CryptoasymelgamalGraphN) -> CryptoasymelgamalGraphN {
  let result = crypto_asym_elgamal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_graphn_fill(s : CryptoasymelgamalGraphN, v : Double) -> CryptoasymelgamalGraphN {
  let result = crypto_asym_elgamal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_graphn_min(s : CryptoasymelgamalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_graphn_max(s : CryptoasymelgamalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_graphn_to_string(s : CryptoasymelgamalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_node_make(size : Int) -> CryptoasymelgamalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_node_len(s : CryptoasymelgamalNode) -> Int { s.size }

pub fn crypto_asym_elgamal_node_get(s : CryptoasymelgamalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_node_set(s : CryptoasymelgamalNode, i : Int, v : Double) -> CryptoasymelgamalNode {
  let result = crypto_asym_elgamal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_node_sum(s : CryptoasymelgamalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_node_mean(s : CryptoasymelgamalNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_node_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_node_scale(s : CryptoasymelgamalNode, f : Double) -> CryptoasymelgamalNode {
  let result = crypto_asym_elgamal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_node_add(a : CryptoasymelgamalNode, b : CryptoasymelgamalNode) -> CryptoasymelgamalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_node_copy(s : CryptoasymelgamalNode) -> CryptoasymelgamalNode {
  let result = crypto_asym_elgamal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_node_fill(s : CryptoasymelgamalNode, v : Double) -> CryptoasymelgamalNode {
  let result = crypto_asym_elgamal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_node_min(s : CryptoasymelgamalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_node_max(s : CryptoasymelgamalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_node_to_string(s : CryptoasymelgamalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_edge_make(size : Int) -> CryptoasymelgamalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_edge_len(s : CryptoasymelgamalEdge) -> Int { s.size }

pub fn crypto_asym_elgamal_edge_get(s : CryptoasymelgamalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_edge_set(s : CryptoasymelgamalEdge, i : Int, v : Double) -> CryptoasymelgamalEdge {
  let result = crypto_asym_elgamal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_edge_sum(s : CryptoasymelgamalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_edge_mean(s : CryptoasymelgamalEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_edge_scale(s : CryptoasymelgamalEdge, f : Double) -> CryptoasymelgamalEdge {
  let result = crypto_asym_elgamal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_edge_add(a : CryptoasymelgamalEdge, b : CryptoasymelgamalEdge) -> CryptoasymelgamalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_edge_copy(s : CryptoasymelgamalEdge) -> CryptoasymelgamalEdge {
  let result = crypto_asym_elgamal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_edge_fill(s : CryptoasymelgamalEdge, v : Double) -> CryptoasymelgamalEdge {
  let result = crypto_asym_elgamal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_edge_min(s : CryptoasymelgamalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_edge_max(s : CryptoasymelgamalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_edge_to_string(s : CryptoasymelgamalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_path_make(size : Int) -> CryptoasymelgamalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_path_len(s : CryptoasymelgamalPath) -> Int { s.size }

pub fn crypto_asym_elgamal_path_get(s : CryptoasymelgamalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_path_set(s : CryptoasymelgamalPath, i : Int, v : Double) -> CryptoasymelgamalPath {
  let result = crypto_asym_elgamal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_path_sum(s : CryptoasymelgamalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_path_mean(s : CryptoasymelgamalPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_path_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_path_scale(s : CryptoasymelgamalPath, f : Double) -> CryptoasymelgamalPath {
  let result = crypto_asym_elgamal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_path_add(a : CryptoasymelgamalPath, b : CryptoasymelgamalPath) -> CryptoasymelgamalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_path_copy(s : CryptoasymelgamalPath) -> CryptoasymelgamalPath {
  let result = crypto_asym_elgamal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_path_fill(s : CryptoasymelgamalPath, v : Double) -> CryptoasymelgamalPath {
  let result = crypto_asym_elgamal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_path_min(s : CryptoasymelgamalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_path_max(s : CryptoasymelgamalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_path_to_string(s : CryptoasymelgamalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_cluster_make(size : Int) -> CryptoasymelgamalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_cluster_len(s : CryptoasymelgamalCluster) -> Int { s.size }

pub fn crypto_asym_elgamal_cluster_get(s : CryptoasymelgamalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_cluster_set(s : CryptoasymelgamalCluster, i : Int, v : Double) -> CryptoasymelgamalCluster {
  let result = crypto_asym_elgamal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_cluster_sum(s : CryptoasymelgamalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_cluster_mean(s : CryptoasymelgamalCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_cluster_scale(s : CryptoasymelgamalCluster, f : Double) -> CryptoasymelgamalCluster {
  let result = crypto_asym_elgamal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_cluster_add(a : CryptoasymelgamalCluster, b : CryptoasymelgamalCluster) -> CryptoasymelgamalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_cluster_copy(s : CryptoasymelgamalCluster) -> CryptoasymelgamalCluster {
  let result = crypto_asym_elgamal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_cluster_fill(s : CryptoasymelgamalCluster, v : Double) -> CryptoasymelgamalCluster {
  let result = crypto_asym_elgamal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_cluster_min(s : CryptoasymelgamalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_cluster_max(s : CryptoasymelgamalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_cluster_to_string(s : CryptoasymelgamalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_model_make(size : Int) -> CryptoasymelgamalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_model_len(s : CryptoasymelgamalModel) -> Int { s.size }

pub fn crypto_asym_elgamal_model_get(s : CryptoasymelgamalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_model_set(s : CryptoasymelgamalModel, i : Int, v : Double) -> CryptoasymelgamalModel {
  let result = crypto_asym_elgamal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_model_sum(s : CryptoasymelgamalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_model_mean(s : CryptoasymelgamalModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_model_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_model_scale(s : CryptoasymelgamalModel, f : Double) -> CryptoasymelgamalModel {
  let result = crypto_asym_elgamal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_model_add(a : CryptoasymelgamalModel, b : CryptoasymelgamalModel) -> CryptoasymelgamalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_model_copy(s : CryptoasymelgamalModel) -> CryptoasymelgamalModel {
  let result = crypto_asym_elgamal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_model_fill(s : CryptoasymelgamalModel, v : Double) -> CryptoasymelgamalModel {
  let result = crypto_asym_elgamal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_model_min(s : CryptoasymelgamalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_model_max(s : CryptoasymelgamalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_model_to_string(s : CryptoasymelgamalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_layer_make(size : Int) -> CryptoasymelgamalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_layer_len(s : CryptoasymelgamalLayer) -> Int { s.size }

pub fn crypto_asym_elgamal_layer_get(s : CryptoasymelgamalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_layer_set(s : CryptoasymelgamalLayer, i : Int, v : Double) -> CryptoasymelgamalLayer {
  let result = crypto_asym_elgamal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_layer_sum(s : CryptoasymelgamalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_layer_mean(s : CryptoasymelgamalLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_layer_scale(s : CryptoasymelgamalLayer, f : Double) -> CryptoasymelgamalLayer {
  let result = crypto_asym_elgamal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_layer_add(a : CryptoasymelgamalLayer, b : CryptoasymelgamalLayer) -> CryptoasymelgamalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_layer_copy(s : CryptoasymelgamalLayer) -> CryptoasymelgamalLayer {
  let result = crypto_asym_elgamal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_layer_fill(s : CryptoasymelgamalLayer, v : Double) -> CryptoasymelgamalLayer {
  let result = crypto_asym_elgamal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_layer_min(s : CryptoasymelgamalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_layer_max(s : CryptoasymelgamalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_layer_to_string(s : CryptoasymelgamalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_buffer_make(size : Int) -> CryptoasymelgamalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_buffer_len(s : CryptoasymelgamalBuffer) -> Int { s.size }

pub fn crypto_asym_elgamal_buffer_get(s : CryptoasymelgamalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_buffer_set(s : CryptoasymelgamalBuffer, i : Int, v : Double) -> CryptoasymelgamalBuffer {
  let result = crypto_asym_elgamal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_buffer_sum(s : CryptoasymelgamalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_buffer_mean(s : CryptoasymelgamalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_buffer_scale(s : CryptoasymelgamalBuffer, f : Double) -> CryptoasymelgamalBuffer {
  let result = crypto_asym_elgamal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_buffer_add(a : CryptoasymelgamalBuffer, b : CryptoasymelgamalBuffer) -> CryptoasymelgamalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_buffer_copy(s : CryptoasymelgamalBuffer) -> CryptoasymelgamalBuffer {
  let result = crypto_asym_elgamal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_buffer_fill(s : CryptoasymelgamalBuffer, v : Double) -> CryptoasymelgamalBuffer {
  let result = crypto_asym_elgamal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_buffer_min(s : CryptoasymelgamalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_buffer_max(s : CryptoasymelgamalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_buffer_to_string(s : CryptoasymelgamalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_cursor_make(size : Int) -> CryptoasymelgamalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_cursor_len(s : CryptoasymelgamalCursor) -> Int { s.size }

pub fn crypto_asym_elgamal_cursor_get(s : CryptoasymelgamalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_cursor_set(s : CryptoasymelgamalCursor, i : Int, v : Double) -> CryptoasymelgamalCursor {
  let result = crypto_asym_elgamal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_cursor_sum(s : CryptoasymelgamalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_cursor_mean(s : CryptoasymelgamalCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_cursor_scale(s : CryptoasymelgamalCursor, f : Double) -> CryptoasymelgamalCursor {
  let result = crypto_asym_elgamal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_cursor_add(a : CryptoasymelgamalCursor, b : CryptoasymelgamalCursor) -> CryptoasymelgamalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_cursor_copy(s : CryptoasymelgamalCursor) -> CryptoasymelgamalCursor {
  let result = crypto_asym_elgamal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_cursor_fill(s : CryptoasymelgamalCursor, v : Double) -> CryptoasymelgamalCursor {
  let result = crypto_asym_elgamal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_cursor_min(s : CryptoasymelgamalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_cursor_max(s : CryptoasymelgamalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_cursor_to_string(s : CryptoasymelgamalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_view_make(size : Int) -> CryptoasymelgamalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_view_len(s : CryptoasymelgamalView) -> Int { s.size }

pub fn crypto_asym_elgamal_view_get(s : CryptoasymelgamalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_view_set(s : CryptoasymelgamalView, i : Int, v : Double) -> CryptoasymelgamalView {
  let result = crypto_asym_elgamal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_view_sum(s : CryptoasymelgamalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_view_mean(s : CryptoasymelgamalView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_view_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_view_scale(s : CryptoasymelgamalView, f : Double) -> CryptoasymelgamalView {
  let result = crypto_asym_elgamal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_view_add(a : CryptoasymelgamalView, b : CryptoasymelgamalView) -> CryptoasymelgamalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_view_copy(s : CryptoasymelgamalView) -> CryptoasymelgamalView {
  let result = crypto_asym_elgamal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_view_fill(s : CryptoasymelgamalView, v : Double) -> CryptoasymelgamalView {
  let result = crypto_asym_elgamal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_view_min(s : CryptoasymelgamalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_view_max(s : CryptoasymelgamalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_view_to_string(s : CryptoasymelgamalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_range_make(size : Int) -> CryptoasymelgamalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_range_len(s : CryptoasymelgamalRange) -> Int { s.size }

pub fn crypto_asym_elgamal_range_get(s : CryptoasymelgamalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_range_set(s : CryptoasymelgamalRange, i : Int, v : Double) -> CryptoasymelgamalRange {
  let result = crypto_asym_elgamal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_range_sum(s : CryptoasymelgamalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_range_mean(s : CryptoasymelgamalRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_range_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_range_scale(s : CryptoasymelgamalRange, f : Double) -> CryptoasymelgamalRange {
  let result = crypto_asym_elgamal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_range_add(a : CryptoasymelgamalRange, b : CryptoasymelgamalRange) -> CryptoasymelgamalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_range_copy(s : CryptoasymelgamalRange) -> CryptoasymelgamalRange {
  let result = crypto_asym_elgamal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_range_fill(s : CryptoasymelgamalRange, v : Double) -> CryptoasymelgamalRange {
  let result = crypto_asym_elgamal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_range_min(s : CryptoasymelgamalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_range_max(s : CryptoasymelgamalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_range_to_string(s : CryptoasymelgamalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymelgamalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_elgamal_slice_make(size : Int) -> CryptoasymelgamalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_elgamal_slice_len(s : CryptoasymelgamalSlice) -> Int { s.size }

pub fn crypto_asym_elgamal_slice_get(s : CryptoasymelgamalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_elgamal_slice_set(s : CryptoasymelgamalSlice, i : Int, v : Double) -> CryptoasymelgamalSlice {
  let result = crypto_asym_elgamal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_slice_sum(s : CryptoasymelgamalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_elgamal_slice_mean(s : CryptoasymelgamalSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_elgamal_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_elgamal_slice_scale(s : CryptoasymelgamalSlice, f : Double) -> CryptoasymelgamalSlice {
  let result = crypto_asym_elgamal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_elgamal_slice_add(a : CryptoasymelgamalSlice, b : CryptoasymelgamalSlice) -> CryptoasymelgamalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_elgamal_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_elgamal_slice_copy(s : CryptoasymelgamalSlice) -> CryptoasymelgamalSlice {
  let result = crypto_asym_elgamal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_elgamal_slice_fill(s : CryptoasymelgamalSlice, v : Double) -> CryptoasymelgamalSlice {
  let result = crypto_asym_elgamal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_elgamal_slice_min(s : CryptoasymelgamalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_slice_max(s : CryptoasymelgamalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_elgamal_slice_to_string(s : CryptoasymelgamalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

