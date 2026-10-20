///===
/// extcore/crypto_asym_eddsa

pub(all) struct CryptoasymeddsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_eddsa_make_point(x : Double, y : Double) -> CryptoasymeddsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_eddsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymeddsaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_eddsa_point_x(pt : CryptoasymeddsaPoint) -> Double { pt.x }

pub fn crypto_asym_eddsa_point_y(pt : CryptoasymeddsaPoint) -> Double { pt.y }

pub fn crypto_asym_eddsa_point_z(pt : CryptoasymeddsaPoint) -> Double { pt.z }

pub fn crypto_asym_eddsa_point_label(pt : CryptoasymeddsaPoint) -> Int { pt.label }

pub fn crypto_asym_eddsa_point_dist(a : CryptoasymeddsaPoint, b : CryptoasymeddsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_eddsa_point_add(a : CryptoasymeddsaPoint, b : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_eddsa_point_sub(a : CryptoasymeddsaPoint, b : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_eddsa_point_scale(pt : CryptoasymeddsaPoint, s : Double) -> CryptoasymeddsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_eddsa_point_dot(a : CryptoasymeddsaPoint, b : CryptoasymeddsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_eddsa_point_cross(a : CryptoasymeddsaPoint, b : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_eddsa_point_norm(pt : CryptoasymeddsaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_eddsa_point_normalize(pt : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  let n = crypto_asym_eddsa_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_eddsa_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_eddsa_point_negate(pt : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_eddsa_point_mid(a : CryptoasymeddsaPoint, b : CryptoasymeddsaPoint) -> CryptoasymeddsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_eddsa_point_lerp(a : CryptoasymeddsaPoint, b : CryptoasymeddsaPoint, t : Double) -> CryptoasymeddsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_eddsa_point_to_string(pt : CryptoasymeddsaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptoasymeddsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_eddsa_make_series(vals : Array[Double], name : String) -> CryptoasymeddsaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_eddsa_series_len(s : CryptoasymeddsaSeries) -> Int { s.vals.length() }

pub fn crypto_asym_eddsa_series_sum(s : CryptoasymeddsaSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_asym_eddsa_series_mean(s : CryptoasymeddsaSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_asym_eddsa_series_min(s : CryptoasymeddsaSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_asym_eddsa_series_max(s : CryptoasymeddsaSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_asym_eddsa_series_range(s : CryptoasymeddsaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_asym_eddsa_series_var(s : CryptoasymeddsaSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_asym_eddsa_series_std(s : CryptoasymeddsaSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_asym_eddsa_series_median(s : CryptoasymeddsaSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_asym_eddsa_series_scale(s : CryptoasymeddsaSeries, f : Double) -> CryptoasymeddsaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_asym_eddsa_series_add(a : CryptoasymeddsaSeries, b : CryptoasymeddsaSeries) -> CryptoasymeddsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_eddsa_series_sub(a : CryptoasymeddsaSeries, b : CryptoasymeddsaSeries) -> CryptoasymeddsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_eddsa_series_normalize(s : CryptoasymeddsaSeries) -> CryptoasymeddsaSeries {
  let mn = crypto_asym_eddsa_series_min(s)
  let mx = crypto_asym_eddsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_eddsa_series_cumsum(s : CryptoasymeddsaSeries) -> CryptoasymeddsaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_eddsa_series_to_string(s : CryptoasymeddsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeddsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_eddsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymeddsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_eddsa_matrix_identity(n : Int) -> CryptoasymeddsaMatrix {
  let m = crypto_asym_eddsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_eddsa_matrix_get(m : CryptoasymeddsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_eddsa_matrix_transpose(m : CryptoasymeddsaMatrix) -> CryptoasymeddsaMatrix {
  let result = crypto_asym_eddsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_eddsa_matrix_add(a : CryptoasymeddsaMatrix, b : CryptoasymeddsaMatrix) -> CryptoasymeddsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_eddsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_eddsa_matrix_scale(m : CryptoasymeddsaMatrix, s : Double) -> CryptoasymeddsaMatrix {
  let result = crypto_asym_eddsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_eddsa_matrix_multiply(a : CryptoasymeddsaMatrix, b : CryptoasymeddsaMatrix) -> CryptoasymeddsaMatrix {
  if a.cols != b.rows { return crypto_asym_eddsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_eddsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_eddsa_matrix_trace(m : CryptoasymeddsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_eddsa_matrix_det(m : CryptoasymeddsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_eddsa_matrix_norm(m : CryptoasymeddsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_asym_eddsa_matrix_to_string(m : CryptoasymeddsaMatrix) -> String {
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

pub(all) struct CryptoasymeddsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_eddsa_make_vector(comps : Array[Double]) -> CryptoasymeddsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_eddsa_vector_zero(dim : Int) -> CryptoasymeddsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_eddsa_vector_add(a : CryptoasymeddsaVector, b : CryptoasymeddsaVector) -> CryptoasymeddsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_eddsa_vector_sub(a : CryptoasymeddsaVector, b : CryptoasymeddsaVector) -> CryptoasymeddsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_eddsa_vector_scale(v : CryptoasymeddsaVector, s : Double) -> CryptoasymeddsaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_asym_eddsa_vector_dot(a : CryptoasymeddsaVector, b : CryptoasymeddsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_eddsa_vector_norm(v : CryptoasymeddsaVector) -> Double { @_common.sqrt(crypto_asym_eddsa_vector_dot(v, v)) }

pub fn crypto_asym_eddsa_vector_normalize(v : CryptoasymeddsaVector) -> CryptoasymeddsaVector {
  let n = crypto_asym_eddsa_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_eddsa_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_eddsa_vector_dist(a : CryptoasymeddsaVector, b : CryptoasymeddsaVector) -> Double {
  crypto_asym_eddsa_vector_norm(crypto_asym_eddsa_vector_sub(a, b))
}

pub fn crypto_asym_eddsa_vector_to_string(v : CryptoasymeddsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_eddsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_eddsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_eddsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_eddsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_eddsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_eddsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_eddsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_eddsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_eddsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_eddsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_eddsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_eddsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_eddsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_eddsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_eddsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_eddsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_eddsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_eddsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_eddsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_eddsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_eddsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_eddsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_eddsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_eddsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_eddsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_eddsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_eddsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_eddsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_eddsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymeddsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_frame_make(size : Int) -> CryptoasymeddsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_frame_len(s : CryptoasymeddsaFrame) -> Int { s.size }

pub fn crypto_asym_eddsa_frame_get(s : CryptoasymeddsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_frame_set(s : CryptoasymeddsaFrame, i : Int, v : Double) -> CryptoasymeddsaFrame {
  let result = crypto_asym_eddsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_frame_sum(s : CryptoasymeddsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_frame_mean(s : CryptoasymeddsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_frame_scale(s : CryptoasymeddsaFrame, f : Double) -> CryptoasymeddsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_frame_add(a : CryptoasymeddsaFrame, b : CryptoasymeddsaFrame) -> CryptoasymeddsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_frame_copy(s : CryptoasymeddsaFrame) -> CryptoasymeddsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_frame_fill(s : CryptoasymeddsaFrame, v : Double) -> CryptoasymeddsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_frame_min(s : CryptoasymeddsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_frame_max(s : CryptoasymeddsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_frame_to_string(s : CryptoasymeddsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_table_make(size : Int) -> CryptoasymeddsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_table_len(s : CryptoasymeddsaTable) -> Int { s.size }

pub fn crypto_asym_eddsa_table_get(s : CryptoasymeddsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_table_set(s : CryptoasymeddsaTable, i : Int, v : Double) -> CryptoasymeddsaTable {
  let result = crypto_asym_eddsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_table_sum(s : CryptoasymeddsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_table_mean(s : CryptoasymeddsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_table_scale(s : CryptoasymeddsaTable, f : Double) -> CryptoasymeddsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_table_add(a : CryptoasymeddsaTable, b : CryptoasymeddsaTable) -> CryptoasymeddsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_table_copy(s : CryptoasymeddsaTable) -> CryptoasymeddsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_table_fill(s : CryptoasymeddsaTable, v : Double) -> CryptoasymeddsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_table_min(s : CryptoasymeddsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_table_max(s : CryptoasymeddsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_table_to_string(s : CryptoasymeddsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_graphn_make(size : Int) -> CryptoasymeddsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_graphn_len(s : CryptoasymeddsaGraphN) -> Int { s.size }

pub fn crypto_asym_eddsa_graphn_get(s : CryptoasymeddsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_graphn_set(s : CryptoasymeddsaGraphN, i : Int, v : Double) -> CryptoasymeddsaGraphN {
  let result = crypto_asym_eddsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_graphn_sum(s : CryptoasymeddsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_graphn_mean(s : CryptoasymeddsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_graphn_scale(s : CryptoasymeddsaGraphN, f : Double) -> CryptoasymeddsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_graphn_add(a : CryptoasymeddsaGraphN, b : CryptoasymeddsaGraphN) -> CryptoasymeddsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_graphn_copy(s : CryptoasymeddsaGraphN) -> CryptoasymeddsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_graphn_fill(s : CryptoasymeddsaGraphN, v : Double) -> CryptoasymeddsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_graphn_min(s : CryptoasymeddsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_graphn_max(s : CryptoasymeddsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_graphn_to_string(s : CryptoasymeddsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_node_make(size : Int) -> CryptoasymeddsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_node_len(s : CryptoasymeddsaNode) -> Int { s.size }

pub fn crypto_asym_eddsa_node_get(s : CryptoasymeddsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_node_set(s : CryptoasymeddsaNode, i : Int, v : Double) -> CryptoasymeddsaNode {
  let result = crypto_asym_eddsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_node_sum(s : CryptoasymeddsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_node_mean(s : CryptoasymeddsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_node_scale(s : CryptoasymeddsaNode, f : Double) -> CryptoasymeddsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_node_add(a : CryptoasymeddsaNode, b : CryptoasymeddsaNode) -> CryptoasymeddsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_node_copy(s : CryptoasymeddsaNode) -> CryptoasymeddsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_node_fill(s : CryptoasymeddsaNode, v : Double) -> CryptoasymeddsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_node_min(s : CryptoasymeddsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_node_max(s : CryptoasymeddsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_node_to_string(s : CryptoasymeddsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_edge_make(size : Int) -> CryptoasymeddsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_edge_len(s : CryptoasymeddsaEdge) -> Int { s.size }

pub fn crypto_asym_eddsa_edge_get(s : CryptoasymeddsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_edge_set(s : CryptoasymeddsaEdge, i : Int, v : Double) -> CryptoasymeddsaEdge {
  let result = crypto_asym_eddsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_edge_sum(s : CryptoasymeddsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_edge_mean(s : CryptoasymeddsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_edge_scale(s : CryptoasymeddsaEdge, f : Double) -> CryptoasymeddsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_edge_add(a : CryptoasymeddsaEdge, b : CryptoasymeddsaEdge) -> CryptoasymeddsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_edge_copy(s : CryptoasymeddsaEdge) -> CryptoasymeddsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_edge_fill(s : CryptoasymeddsaEdge, v : Double) -> CryptoasymeddsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_edge_min(s : CryptoasymeddsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_edge_max(s : CryptoasymeddsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_edge_to_string(s : CryptoasymeddsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_path_make(size : Int) -> CryptoasymeddsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_path_len(s : CryptoasymeddsaPath) -> Int { s.size }

pub fn crypto_asym_eddsa_path_get(s : CryptoasymeddsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_path_set(s : CryptoasymeddsaPath, i : Int, v : Double) -> CryptoasymeddsaPath {
  let result = crypto_asym_eddsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_path_sum(s : CryptoasymeddsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_path_mean(s : CryptoasymeddsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_path_scale(s : CryptoasymeddsaPath, f : Double) -> CryptoasymeddsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_path_add(a : CryptoasymeddsaPath, b : CryptoasymeddsaPath) -> CryptoasymeddsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_path_copy(s : CryptoasymeddsaPath) -> CryptoasymeddsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_path_fill(s : CryptoasymeddsaPath, v : Double) -> CryptoasymeddsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_path_min(s : CryptoasymeddsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_path_max(s : CryptoasymeddsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_path_to_string(s : CryptoasymeddsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_cluster_make(size : Int) -> CryptoasymeddsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_cluster_len(s : CryptoasymeddsaCluster) -> Int { s.size }

pub fn crypto_asym_eddsa_cluster_get(s : CryptoasymeddsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_cluster_set(s : CryptoasymeddsaCluster, i : Int, v : Double) -> CryptoasymeddsaCluster {
  let result = crypto_asym_eddsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_cluster_sum(s : CryptoasymeddsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_cluster_mean(s : CryptoasymeddsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_cluster_scale(s : CryptoasymeddsaCluster, f : Double) -> CryptoasymeddsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_cluster_add(a : CryptoasymeddsaCluster, b : CryptoasymeddsaCluster) -> CryptoasymeddsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_cluster_copy(s : CryptoasymeddsaCluster) -> CryptoasymeddsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_cluster_fill(s : CryptoasymeddsaCluster, v : Double) -> CryptoasymeddsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_cluster_min(s : CryptoasymeddsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_cluster_max(s : CryptoasymeddsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_cluster_to_string(s : CryptoasymeddsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_model_make(size : Int) -> CryptoasymeddsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_model_len(s : CryptoasymeddsaModel) -> Int { s.size }

pub fn crypto_asym_eddsa_model_get(s : CryptoasymeddsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_model_set(s : CryptoasymeddsaModel, i : Int, v : Double) -> CryptoasymeddsaModel {
  let result = crypto_asym_eddsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_model_sum(s : CryptoasymeddsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_model_mean(s : CryptoasymeddsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_model_scale(s : CryptoasymeddsaModel, f : Double) -> CryptoasymeddsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_model_add(a : CryptoasymeddsaModel, b : CryptoasymeddsaModel) -> CryptoasymeddsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_model_copy(s : CryptoasymeddsaModel) -> CryptoasymeddsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_model_fill(s : CryptoasymeddsaModel, v : Double) -> CryptoasymeddsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_model_min(s : CryptoasymeddsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_model_max(s : CryptoasymeddsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_model_to_string(s : CryptoasymeddsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_layer_make(size : Int) -> CryptoasymeddsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_layer_len(s : CryptoasymeddsaLayer) -> Int { s.size }

pub fn crypto_asym_eddsa_layer_get(s : CryptoasymeddsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_layer_set(s : CryptoasymeddsaLayer, i : Int, v : Double) -> CryptoasymeddsaLayer {
  let result = crypto_asym_eddsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_layer_sum(s : CryptoasymeddsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_layer_mean(s : CryptoasymeddsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_layer_scale(s : CryptoasymeddsaLayer, f : Double) -> CryptoasymeddsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_layer_add(a : CryptoasymeddsaLayer, b : CryptoasymeddsaLayer) -> CryptoasymeddsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_layer_copy(s : CryptoasymeddsaLayer) -> CryptoasymeddsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_layer_fill(s : CryptoasymeddsaLayer, v : Double) -> CryptoasymeddsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_layer_min(s : CryptoasymeddsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_layer_max(s : CryptoasymeddsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_layer_to_string(s : CryptoasymeddsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_buffer_make(size : Int) -> CryptoasymeddsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_buffer_len(s : CryptoasymeddsaBuffer) -> Int { s.size }

pub fn crypto_asym_eddsa_buffer_get(s : CryptoasymeddsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_buffer_set(s : CryptoasymeddsaBuffer, i : Int, v : Double) -> CryptoasymeddsaBuffer {
  let result = crypto_asym_eddsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_buffer_sum(s : CryptoasymeddsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_buffer_mean(s : CryptoasymeddsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_buffer_scale(s : CryptoasymeddsaBuffer, f : Double) -> CryptoasymeddsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_buffer_add(a : CryptoasymeddsaBuffer, b : CryptoasymeddsaBuffer) -> CryptoasymeddsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_buffer_copy(s : CryptoasymeddsaBuffer) -> CryptoasymeddsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_buffer_fill(s : CryptoasymeddsaBuffer, v : Double) -> CryptoasymeddsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_buffer_min(s : CryptoasymeddsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_buffer_max(s : CryptoasymeddsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_buffer_to_string(s : CryptoasymeddsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_cursor_make(size : Int) -> CryptoasymeddsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_cursor_len(s : CryptoasymeddsaCursor) -> Int { s.size }

pub fn crypto_asym_eddsa_cursor_get(s : CryptoasymeddsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_cursor_set(s : CryptoasymeddsaCursor, i : Int, v : Double) -> CryptoasymeddsaCursor {
  let result = crypto_asym_eddsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_cursor_sum(s : CryptoasymeddsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_cursor_mean(s : CryptoasymeddsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_cursor_scale(s : CryptoasymeddsaCursor, f : Double) -> CryptoasymeddsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_cursor_add(a : CryptoasymeddsaCursor, b : CryptoasymeddsaCursor) -> CryptoasymeddsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_cursor_copy(s : CryptoasymeddsaCursor) -> CryptoasymeddsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_cursor_fill(s : CryptoasymeddsaCursor, v : Double) -> CryptoasymeddsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_cursor_min(s : CryptoasymeddsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_cursor_max(s : CryptoasymeddsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_cursor_to_string(s : CryptoasymeddsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_view_make(size : Int) -> CryptoasymeddsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_view_len(s : CryptoasymeddsaView) -> Int { s.size }

pub fn crypto_asym_eddsa_view_get(s : CryptoasymeddsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_view_set(s : CryptoasymeddsaView, i : Int, v : Double) -> CryptoasymeddsaView {
  let result = crypto_asym_eddsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_view_sum(s : CryptoasymeddsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_view_mean(s : CryptoasymeddsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_view_scale(s : CryptoasymeddsaView, f : Double) -> CryptoasymeddsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_view_add(a : CryptoasymeddsaView, b : CryptoasymeddsaView) -> CryptoasymeddsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_view_copy(s : CryptoasymeddsaView) -> CryptoasymeddsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_view_fill(s : CryptoasymeddsaView, v : Double) -> CryptoasymeddsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_view_min(s : CryptoasymeddsaView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_view_max(s : CryptoasymeddsaView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_view_to_string(s : CryptoasymeddsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_range_make(size : Int) -> CryptoasymeddsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_range_len(s : CryptoasymeddsaRange) -> Int { s.size }

pub fn crypto_asym_eddsa_range_get(s : CryptoasymeddsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_range_set(s : CryptoasymeddsaRange, i : Int, v : Double) -> CryptoasymeddsaRange {
  let result = crypto_asym_eddsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_range_sum(s : CryptoasymeddsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_range_mean(s : CryptoasymeddsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_range_scale(s : CryptoasymeddsaRange, f : Double) -> CryptoasymeddsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_range_add(a : CryptoasymeddsaRange, b : CryptoasymeddsaRange) -> CryptoasymeddsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_range_copy(s : CryptoasymeddsaRange) -> CryptoasymeddsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_range_fill(s : CryptoasymeddsaRange, v : Double) -> CryptoasymeddsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_range_min(s : CryptoasymeddsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_range_max(s : CryptoasymeddsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_range_to_string(s : CryptoasymeddsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeddsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_eddsa_slice_make(size : Int) -> CryptoasymeddsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_eddsa_slice_len(s : CryptoasymeddsaSlice) -> Int { s.size }

pub fn crypto_asym_eddsa_slice_get(s : CryptoasymeddsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_eddsa_slice_set(s : CryptoasymeddsaSlice, i : Int, v : Double) -> CryptoasymeddsaSlice {
  let result = crypto_asym_eddsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_eddsa_slice_sum(s : CryptoasymeddsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_eddsa_slice_mean(s : CryptoasymeddsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_eddsa_slice_scale(s : CryptoasymeddsaSlice, f : Double) -> CryptoasymeddsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_slice_add(a : CryptoasymeddsaSlice, b : CryptoasymeddsaSlice) -> CryptoasymeddsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_eddsa_slice_copy(s : CryptoasymeddsaSlice) -> CryptoasymeddsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_slice_fill(s : CryptoasymeddsaSlice, v : Double) -> CryptoasymeddsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_eddsa_slice_min(s : CryptoasymeddsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_eddsa_slice_max(s : CryptoasymeddsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_eddsa_slice_to_string(s : CryptoasymeddsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

