///===
/// extcore/crypto_asym_ecdsa

pub(all) struct CryptoasymecdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_ecdsa_make_point(x : Double, y : Double) -> CryptoasymecdsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_ecdsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymecdsaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_ecdsa_point_x(pt : CryptoasymecdsaPoint) -> Double { pt.x }

pub fn crypto_asym_ecdsa_point_y(pt : CryptoasymecdsaPoint) -> Double { pt.y }

pub fn crypto_asym_ecdsa_point_z(pt : CryptoasymecdsaPoint) -> Double { pt.z }

pub fn crypto_asym_ecdsa_point_label(pt : CryptoasymecdsaPoint) -> Int { pt.label }

pub fn crypto_asym_ecdsa_point_dist(a : CryptoasymecdsaPoint, b : CryptoasymecdsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_ecdsa_point_add(a : CryptoasymecdsaPoint, b : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_ecdsa_point_sub(a : CryptoasymecdsaPoint, b : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_ecdsa_point_scale(pt : CryptoasymecdsaPoint, s : Double) -> CryptoasymecdsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_ecdsa_point_dot(a : CryptoasymecdsaPoint, b : CryptoasymecdsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_ecdsa_point_cross(a : CryptoasymecdsaPoint, b : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_ecdsa_point_norm(pt : CryptoasymecdsaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_ecdsa_point_normalize(pt : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  let n = crypto_asym_ecdsa_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_ecdsa_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_ecdsa_point_negate(pt : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_ecdsa_point_mid(a : CryptoasymecdsaPoint, b : CryptoasymecdsaPoint) -> CryptoasymecdsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_ecdsa_point_lerp(a : CryptoasymecdsaPoint, b : CryptoasymecdsaPoint, t : Double) -> CryptoasymecdsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_ecdsa_point_to_string(pt : CryptoasymecdsaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptoasymecdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_ecdsa_make_series(vals : Array[Double], name : String) -> CryptoasymecdsaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_ecdsa_series_len(s : CryptoasymecdsaSeries) -> Int { s.vals.length() }

pub fn crypto_asym_ecdsa_series_sum(s : CryptoasymecdsaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_asym_ecdsa_series_mean(s : CryptoasymecdsaSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_asym_ecdsa_series_min(s : CryptoasymecdsaSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_asym_ecdsa_series_max(s : CryptoasymecdsaSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_asym_ecdsa_series_range(s : CryptoasymecdsaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_asym_ecdsa_series_var(s : CryptoasymecdsaSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_asym_ecdsa_series_std(s : CryptoasymecdsaSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_asym_ecdsa_series_median(s : CryptoasymecdsaSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_asym_ecdsa_series_scale(s : CryptoasymecdsaSeries, f : Double) -> CryptoasymecdsaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_asym_ecdsa_series_add(a : CryptoasymecdsaSeries, b : CryptoasymecdsaSeries) -> CryptoasymecdsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_ecdsa_series_sub(a : CryptoasymecdsaSeries, b : CryptoasymecdsaSeries) -> CryptoasymecdsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_ecdsa_series_normalize(s : CryptoasymecdsaSeries) -> CryptoasymecdsaSeries {
  let mn = crypto_asym_ecdsa_series_min(s)
  let mx = crypto_asym_ecdsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_ecdsa_series_cumsum(s : CryptoasymecdsaSeries) -> CryptoasymecdsaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_ecdsa_series_to_string(s : CryptoasymecdsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymecdsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_ecdsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymecdsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_ecdsa_matrix_identity(n : Int) -> CryptoasymecdsaMatrix {
  let m = crypto_asym_ecdsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_ecdsa_matrix_get(m : CryptoasymecdsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_ecdsa_matrix_transpose(m : CryptoasymecdsaMatrix) -> CryptoasymecdsaMatrix {
  let result = crypto_asym_ecdsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_ecdsa_matrix_add(a : CryptoasymecdsaMatrix, b : CryptoasymecdsaMatrix) -> CryptoasymecdsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_ecdsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_ecdsa_matrix_scale(m : CryptoasymecdsaMatrix, s : Double) -> CryptoasymecdsaMatrix {
  let result = crypto_asym_ecdsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_ecdsa_matrix_multiply(a : CryptoasymecdsaMatrix, b : CryptoasymecdsaMatrix) -> CryptoasymecdsaMatrix {
  if a.cols != b.rows { return crypto_asym_ecdsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_ecdsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_ecdsa_matrix_trace(m : CryptoasymecdsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_ecdsa_matrix_det(m : CryptoasymecdsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_ecdsa_matrix_norm(m : CryptoasymecdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_asym_ecdsa_matrix_to_string(m : CryptoasymecdsaMatrix) -> String {
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

pub(all) struct CryptoasymecdsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_ecdsa_make_vector(comps : Array[Double]) -> CryptoasymecdsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_ecdsa_vector_zero(dim : Int) -> CryptoasymecdsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_ecdsa_vector_add(a : CryptoasymecdsaVector, b : CryptoasymecdsaVector) -> CryptoasymecdsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_ecdsa_vector_sub(a : CryptoasymecdsaVector, b : CryptoasymecdsaVector) -> CryptoasymecdsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_ecdsa_vector_scale(v : CryptoasymecdsaVector, s : Double) -> CryptoasymecdsaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_asym_ecdsa_vector_dot(a : CryptoasymecdsaVector, b : CryptoasymecdsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_ecdsa_vector_norm(v : CryptoasymecdsaVector) -> Double { @_common.sqrt(crypto_asym_ecdsa_vector_dot(v, v)) }

pub fn crypto_asym_ecdsa_vector_normalize(v : CryptoasymecdsaVector) -> CryptoasymecdsaVector {
  let n = crypto_asym_ecdsa_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_ecdsa_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_ecdsa_vector_dist(a : CryptoasymecdsaVector, b : CryptoasymecdsaVector) -> Double {
  crypto_asym_ecdsa_vector_norm(crypto_asym_ecdsa_vector_sub(a, b))
}

pub fn crypto_asym_ecdsa_vector_to_string(v : CryptoasymecdsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_ecdsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_ecdsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_ecdsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_ecdsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_ecdsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_ecdsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_ecdsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_ecdsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_ecdsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_ecdsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_ecdsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_ecdsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_ecdsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_ecdsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_ecdsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_ecdsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_ecdsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_ecdsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_ecdsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_ecdsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_ecdsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_ecdsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_ecdsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_ecdsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_ecdsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_ecdsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_ecdsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_ecdsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_ecdsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymecdsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_frame_make(size : Int) -> CryptoasymecdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_frame_len(s : CryptoasymecdsaFrame) -> Int { s.size }

pub fn crypto_asym_ecdsa_frame_get(s : CryptoasymecdsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_frame_set(s : CryptoasymecdsaFrame, i : Int, v : Double) -> CryptoasymecdsaFrame {
  let result = crypto_asym_ecdsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_frame_sum(s : CryptoasymecdsaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_frame_mean(s : CryptoasymecdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_frame_scale(s : CryptoasymecdsaFrame, f : Double) -> CryptoasymecdsaFrame {
  let result = crypto_asym_ecdsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_frame_add(a : CryptoasymecdsaFrame, b : CryptoasymecdsaFrame) -> CryptoasymecdsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_frame_copy(s : CryptoasymecdsaFrame) -> CryptoasymecdsaFrame {
  let result = crypto_asym_ecdsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_frame_fill(s : CryptoasymecdsaFrame, v : Double) -> CryptoasymecdsaFrame {
  let result = crypto_asym_ecdsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_frame_min(s : CryptoasymecdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_frame_max(s : CryptoasymecdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_frame_to_string(s : CryptoasymecdsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_table_make(size : Int) -> CryptoasymecdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_table_len(s : CryptoasymecdsaTable) -> Int { s.size }

pub fn crypto_asym_ecdsa_table_get(s : CryptoasymecdsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_table_set(s : CryptoasymecdsaTable, i : Int, v : Double) -> CryptoasymecdsaTable {
  let result = crypto_asym_ecdsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_table_sum(s : CryptoasymecdsaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_table_mean(s : CryptoasymecdsaTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_table_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_table_scale(s : CryptoasymecdsaTable, f : Double) -> CryptoasymecdsaTable {
  let result = crypto_asym_ecdsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_table_add(a : CryptoasymecdsaTable, b : CryptoasymecdsaTable) -> CryptoasymecdsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_table_copy(s : CryptoasymecdsaTable) -> CryptoasymecdsaTable {
  let result = crypto_asym_ecdsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_table_fill(s : CryptoasymecdsaTable, v : Double) -> CryptoasymecdsaTable {
  let result = crypto_asym_ecdsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_table_min(s : CryptoasymecdsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_table_max(s : CryptoasymecdsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_table_to_string(s : CryptoasymecdsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_graphn_make(size : Int) -> CryptoasymecdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_graphn_len(s : CryptoasymecdsaGraphN) -> Int { s.size }

pub fn crypto_asym_ecdsa_graphn_get(s : CryptoasymecdsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_graphn_set(s : CryptoasymecdsaGraphN, i : Int, v : Double) -> CryptoasymecdsaGraphN {
  let result = crypto_asym_ecdsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_graphn_sum(s : CryptoasymecdsaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_graphn_mean(s : CryptoasymecdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_graphn_scale(s : CryptoasymecdsaGraphN, f : Double) -> CryptoasymecdsaGraphN {
  let result = crypto_asym_ecdsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_graphn_add(a : CryptoasymecdsaGraphN, b : CryptoasymecdsaGraphN) -> CryptoasymecdsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_graphn_copy(s : CryptoasymecdsaGraphN) -> CryptoasymecdsaGraphN {
  let result = crypto_asym_ecdsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_graphn_fill(s : CryptoasymecdsaGraphN, v : Double) -> CryptoasymecdsaGraphN {
  let result = crypto_asym_ecdsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_graphn_min(s : CryptoasymecdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_graphn_max(s : CryptoasymecdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_graphn_to_string(s : CryptoasymecdsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_node_make(size : Int) -> CryptoasymecdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_node_len(s : CryptoasymecdsaNode) -> Int { s.size }

pub fn crypto_asym_ecdsa_node_get(s : CryptoasymecdsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_node_set(s : CryptoasymecdsaNode, i : Int, v : Double) -> CryptoasymecdsaNode {
  let result = crypto_asym_ecdsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_node_sum(s : CryptoasymecdsaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_node_mean(s : CryptoasymecdsaNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_node_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_node_scale(s : CryptoasymecdsaNode, f : Double) -> CryptoasymecdsaNode {
  let result = crypto_asym_ecdsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_node_add(a : CryptoasymecdsaNode, b : CryptoasymecdsaNode) -> CryptoasymecdsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_node_copy(s : CryptoasymecdsaNode) -> CryptoasymecdsaNode {
  let result = crypto_asym_ecdsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_node_fill(s : CryptoasymecdsaNode, v : Double) -> CryptoasymecdsaNode {
  let result = crypto_asym_ecdsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_node_min(s : CryptoasymecdsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_node_max(s : CryptoasymecdsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_node_to_string(s : CryptoasymecdsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_edge_make(size : Int) -> CryptoasymecdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_edge_len(s : CryptoasymecdsaEdge) -> Int { s.size }

pub fn crypto_asym_ecdsa_edge_get(s : CryptoasymecdsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_edge_set(s : CryptoasymecdsaEdge, i : Int, v : Double) -> CryptoasymecdsaEdge {
  let result = crypto_asym_ecdsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_edge_sum(s : CryptoasymecdsaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_edge_mean(s : CryptoasymecdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_edge_scale(s : CryptoasymecdsaEdge, f : Double) -> CryptoasymecdsaEdge {
  let result = crypto_asym_ecdsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_edge_add(a : CryptoasymecdsaEdge, b : CryptoasymecdsaEdge) -> CryptoasymecdsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_edge_copy(s : CryptoasymecdsaEdge) -> CryptoasymecdsaEdge {
  let result = crypto_asym_ecdsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_edge_fill(s : CryptoasymecdsaEdge, v : Double) -> CryptoasymecdsaEdge {
  let result = crypto_asym_ecdsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_edge_min(s : CryptoasymecdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_edge_max(s : CryptoasymecdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_edge_to_string(s : CryptoasymecdsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_path_make(size : Int) -> CryptoasymecdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_path_len(s : CryptoasymecdsaPath) -> Int { s.size }

pub fn crypto_asym_ecdsa_path_get(s : CryptoasymecdsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_path_set(s : CryptoasymecdsaPath, i : Int, v : Double) -> CryptoasymecdsaPath {
  let result = crypto_asym_ecdsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_path_sum(s : CryptoasymecdsaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_path_mean(s : CryptoasymecdsaPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_path_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_path_scale(s : CryptoasymecdsaPath, f : Double) -> CryptoasymecdsaPath {
  let result = crypto_asym_ecdsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_path_add(a : CryptoasymecdsaPath, b : CryptoasymecdsaPath) -> CryptoasymecdsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_path_copy(s : CryptoasymecdsaPath) -> CryptoasymecdsaPath {
  let result = crypto_asym_ecdsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_path_fill(s : CryptoasymecdsaPath, v : Double) -> CryptoasymecdsaPath {
  let result = crypto_asym_ecdsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_path_min(s : CryptoasymecdsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_path_max(s : CryptoasymecdsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_path_to_string(s : CryptoasymecdsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_cluster_make(size : Int) -> CryptoasymecdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_cluster_len(s : CryptoasymecdsaCluster) -> Int { s.size }

pub fn crypto_asym_ecdsa_cluster_get(s : CryptoasymecdsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_cluster_set(s : CryptoasymecdsaCluster, i : Int, v : Double) -> CryptoasymecdsaCluster {
  let result = crypto_asym_ecdsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_cluster_sum(s : CryptoasymecdsaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_cluster_mean(s : CryptoasymecdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_cluster_scale(s : CryptoasymecdsaCluster, f : Double) -> CryptoasymecdsaCluster {
  let result = crypto_asym_ecdsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_cluster_add(a : CryptoasymecdsaCluster, b : CryptoasymecdsaCluster) -> CryptoasymecdsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_cluster_copy(s : CryptoasymecdsaCluster) -> CryptoasymecdsaCluster {
  let result = crypto_asym_ecdsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_cluster_fill(s : CryptoasymecdsaCluster, v : Double) -> CryptoasymecdsaCluster {
  let result = crypto_asym_ecdsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_cluster_min(s : CryptoasymecdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_cluster_max(s : CryptoasymecdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_cluster_to_string(s : CryptoasymecdsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_model_make(size : Int) -> CryptoasymecdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_model_len(s : CryptoasymecdsaModel) -> Int { s.size }

pub fn crypto_asym_ecdsa_model_get(s : CryptoasymecdsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_model_set(s : CryptoasymecdsaModel, i : Int, v : Double) -> CryptoasymecdsaModel {
  let result = crypto_asym_ecdsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_model_sum(s : CryptoasymecdsaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_model_mean(s : CryptoasymecdsaModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_model_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_model_scale(s : CryptoasymecdsaModel, f : Double) -> CryptoasymecdsaModel {
  let result = crypto_asym_ecdsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_model_add(a : CryptoasymecdsaModel, b : CryptoasymecdsaModel) -> CryptoasymecdsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_model_copy(s : CryptoasymecdsaModel) -> CryptoasymecdsaModel {
  let result = crypto_asym_ecdsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_model_fill(s : CryptoasymecdsaModel, v : Double) -> CryptoasymecdsaModel {
  let result = crypto_asym_ecdsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_model_min(s : CryptoasymecdsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_model_max(s : CryptoasymecdsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_model_to_string(s : CryptoasymecdsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_layer_make(size : Int) -> CryptoasymecdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_layer_len(s : CryptoasymecdsaLayer) -> Int { s.size }

pub fn crypto_asym_ecdsa_layer_get(s : CryptoasymecdsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_layer_set(s : CryptoasymecdsaLayer, i : Int, v : Double) -> CryptoasymecdsaLayer {
  let result = crypto_asym_ecdsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_layer_sum(s : CryptoasymecdsaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_layer_mean(s : CryptoasymecdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_layer_scale(s : CryptoasymecdsaLayer, f : Double) -> CryptoasymecdsaLayer {
  let result = crypto_asym_ecdsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_layer_add(a : CryptoasymecdsaLayer, b : CryptoasymecdsaLayer) -> CryptoasymecdsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_layer_copy(s : CryptoasymecdsaLayer) -> CryptoasymecdsaLayer {
  let result = crypto_asym_ecdsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_layer_fill(s : CryptoasymecdsaLayer, v : Double) -> CryptoasymecdsaLayer {
  let result = crypto_asym_ecdsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_layer_min(s : CryptoasymecdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_layer_max(s : CryptoasymecdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_layer_to_string(s : CryptoasymecdsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_buffer_make(size : Int) -> CryptoasymecdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_buffer_len(s : CryptoasymecdsaBuffer) -> Int { s.size }

pub fn crypto_asym_ecdsa_buffer_get(s : CryptoasymecdsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_buffer_set(s : CryptoasymecdsaBuffer, i : Int, v : Double) -> CryptoasymecdsaBuffer {
  let result = crypto_asym_ecdsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_buffer_sum(s : CryptoasymecdsaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_buffer_mean(s : CryptoasymecdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_buffer_scale(s : CryptoasymecdsaBuffer, f : Double) -> CryptoasymecdsaBuffer {
  let result = crypto_asym_ecdsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_buffer_add(a : CryptoasymecdsaBuffer, b : CryptoasymecdsaBuffer) -> CryptoasymecdsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_buffer_copy(s : CryptoasymecdsaBuffer) -> CryptoasymecdsaBuffer {
  let result = crypto_asym_ecdsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_buffer_fill(s : CryptoasymecdsaBuffer, v : Double) -> CryptoasymecdsaBuffer {
  let result = crypto_asym_ecdsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_buffer_min(s : CryptoasymecdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_buffer_max(s : CryptoasymecdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_buffer_to_string(s : CryptoasymecdsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_cursor_make(size : Int) -> CryptoasymecdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_cursor_len(s : CryptoasymecdsaCursor) -> Int { s.size }

pub fn crypto_asym_ecdsa_cursor_get(s : CryptoasymecdsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_cursor_set(s : CryptoasymecdsaCursor, i : Int, v : Double) -> CryptoasymecdsaCursor {
  let result = crypto_asym_ecdsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_cursor_sum(s : CryptoasymecdsaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_cursor_mean(s : CryptoasymecdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_cursor_scale(s : CryptoasymecdsaCursor, f : Double) -> CryptoasymecdsaCursor {
  let result = crypto_asym_ecdsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_cursor_add(a : CryptoasymecdsaCursor, b : CryptoasymecdsaCursor) -> CryptoasymecdsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_cursor_copy(s : CryptoasymecdsaCursor) -> CryptoasymecdsaCursor {
  let result = crypto_asym_ecdsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_cursor_fill(s : CryptoasymecdsaCursor, v : Double) -> CryptoasymecdsaCursor {
  let result = crypto_asym_ecdsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_cursor_min(s : CryptoasymecdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_cursor_max(s : CryptoasymecdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_cursor_to_string(s : CryptoasymecdsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_view_make(size : Int) -> CryptoasymecdsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_view_len(s : CryptoasymecdsaView) -> Int { s.size }

pub fn crypto_asym_ecdsa_view_get(s : CryptoasymecdsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_view_set(s : CryptoasymecdsaView, i : Int, v : Double) -> CryptoasymecdsaView {
  let result = crypto_asym_ecdsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_view_sum(s : CryptoasymecdsaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_view_mean(s : CryptoasymecdsaView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_view_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_view_scale(s : CryptoasymecdsaView, f : Double) -> CryptoasymecdsaView {
  let result = crypto_asym_ecdsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_view_add(a : CryptoasymecdsaView, b : CryptoasymecdsaView) -> CryptoasymecdsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_view_copy(s : CryptoasymecdsaView) -> CryptoasymecdsaView {
  let result = crypto_asym_ecdsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_view_fill(s : CryptoasymecdsaView, v : Double) -> CryptoasymecdsaView {
  let result = crypto_asym_ecdsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_view_min(s : CryptoasymecdsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_view_max(s : CryptoasymecdsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_view_to_string(s : CryptoasymecdsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_range_make(size : Int) -> CryptoasymecdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_range_len(s : CryptoasymecdsaRange) -> Int { s.size }

pub fn crypto_asym_ecdsa_range_get(s : CryptoasymecdsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_range_set(s : CryptoasymecdsaRange, i : Int, v : Double) -> CryptoasymecdsaRange {
  let result = crypto_asym_ecdsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_range_sum(s : CryptoasymecdsaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_range_mean(s : CryptoasymecdsaRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_range_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_range_scale(s : CryptoasymecdsaRange, f : Double) -> CryptoasymecdsaRange {
  let result = crypto_asym_ecdsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_range_add(a : CryptoasymecdsaRange, b : CryptoasymecdsaRange) -> CryptoasymecdsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_range_copy(s : CryptoasymecdsaRange) -> CryptoasymecdsaRange {
  let result = crypto_asym_ecdsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_range_fill(s : CryptoasymecdsaRange, v : Double) -> CryptoasymecdsaRange {
  let result = crypto_asym_ecdsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_range_min(s : CryptoasymecdsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_range_max(s : CryptoasymecdsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_range_to_string(s : CryptoasymecdsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymecdsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecdsa_slice_make(size : Int) -> CryptoasymecdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecdsa_slice_len(s : CryptoasymecdsaSlice) -> Int { s.size }

pub fn crypto_asym_ecdsa_slice_get(s : CryptoasymecdsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecdsa_slice_set(s : CryptoasymecdsaSlice, i : Int, v : Double) -> CryptoasymecdsaSlice {
  let result = crypto_asym_ecdsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_slice_sum(s : CryptoasymecdsaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_asym_ecdsa_slice_mean(s : CryptoasymecdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_asym_ecdsa_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_asym_ecdsa_slice_scale(s : CryptoasymecdsaSlice, f : Double) -> CryptoasymecdsaSlice {
  let result = crypto_asym_ecdsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_asym_ecdsa_slice_add(a : CryptoasymecdsaSlice, b : CryptoasymecdsaSlice) -> CryptoasymecdsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_asym_ecdsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_asym_ecdsa_slice_copy(s : CryptoasymecdsaSlice) -> CryptoasymecdsaSlice {
  let result = crypto_asym_ecdsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_asym_ecdsa_slice_fill(s : CryptoasymecdsaSlice, v : Double) -> CryptoasymecdsaSlice {
  let result = crypto_asym_ecdsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_ecdsa_slice_min(s : CryptoasymecdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_slice_max(s : CryptoasymecdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_asym_ecdsa_slice_to_string(s : CryptoasymecdsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

