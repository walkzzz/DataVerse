///===
/// extcore/crypto_sym_chacha

pub(all) struct CryptosymchachaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_chacha_make_point(x : Double, y : Double) -> CryptosymchachaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_chacha_make_point3(x : Double, y : Double, z : Double) -> CryptosymchachaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_chacha_point_x(pt : CryptosymchachaPoint) -> Double { pt.x }

pub fn crypto_sym_chacha_point_y(pt : CryptosymchachaPoint) -> Double { pt.y }

pub fn crypto_sym_chacha_point_z(pt : CryptosymchachaPoint) -> Double { pt.z }

pub fn crypto_sym_chacha_point_label(pt : CryptosymchachaPoint) -> Int { pt.label }

pub fn crypto_sym_chacha_point_dist(a : CryptosymchachaPoint, b : CryptosymchachaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_chacha_point_add(a : CryptosymchachaPoint, b : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_chacha_point_sub(a : CryptosymchachaPoint, b : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_chacha_point_scale(pt : CryptosymchachaPoint, s : Double) -> CryptosymchachaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_chacha_point_dot(a : CryptosymchachaPoint, b : CryptosymchachaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_chacha_point_cross(a : CryptosymchachaPoint, b : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_chacha_point_norm(pt : CryptosymchachaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_chacha_point_normalize(pt : CryptosymchachaPoint) -> CryptosymchachaPoint {
  let n = crypto_sym_chacha_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_chacha_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_chacha_point_negate(pt : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_chacha_point_mid(a : CryptosymchachaPoint, b : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_chacha_point_lerp(a : CryptosymchachaPoint, b : CryptosymchachaPoint, t : Double) -> CryptosymchachaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_chacha_point_to_string(pt : CryptosymchachaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymchachaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_chacha_make_series(vals : Array[Double], name : String) -> CryptosymchachaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_chacha_series_len(s : CryptosymchachaSeries) -> Int { s.vals.length() }

pub fn crypto_sym_chacha_series_sum(s : CryptosymchachaSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sym_chacha_series_mean(s : CryptosymchachaSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sym_chacha_series_min(s : CryptosymchachaSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sym_chacha_series_max(s : CryptosymchachaSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sym_chacha_series_range(s : CryptosymchachaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sym_chacha_series_var(s : CryptosymchachaSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sym_chacha_series_std(s : CryptosymchachaSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sym_chacha_series_median(s : CryptosymchachaSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sym_chacha_series_scale(s : CryptosymchachaSeries, f : Double) -> CryptosymchachaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_chacha_series_add(a : CryptosymchachaSeries, b : CryptosymchachaSeries) -> CryptosymchachaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_chacha_series_sub(a : CryptosymchachaSeries, b : CryptosymchachaSeries) -> CryptosymchachaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_chacha_series_normalize(s : CryptosymchachaSeries) -> CryptosymchachaSeries {
  let mn = crypto_sym_chacha_series_min(s)
  let mx = crypto_sym_chacha_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_chacha_series_cumsum(s : CryptosymchachaSeries) -> CryptosymchachaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_chacha_series_to_string(s : CryptosymchachaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymchachaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_chacha_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymchachaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_chacha_matrix_identity(n : Int) -> CryptosymchachaMatrix {
  let m = crypto_sym_chacha_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_chacha_matrix_get(m : CryptosymchachaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_chacha_matrix_transpose(m : CryptosymchachaMatrix) -> CryptosymchachaMatrix {
  let result = crypto_sym_chacha_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_chacha_matrix_add(a : CryptosymchachaMatrix, b : CryptosymchachaMatrix) -> CryptosymchachaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_chacha_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_chacha_matrix_scale(m : CryptosymchachaMatrix, s : Double) -> CryptosymchachaMatrix {
  let result = crypto_sym_chacha_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_chacha_matrix_multiply(a : CryptosymchachaMatrix, b : CryptosymchachaMatrix) -> CryptosymchachaMatrix {
  if a.cols != b.rows { return crypto_sym_chacha_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_chacha_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_chacha_matrix_trace(m : CryptosymchachaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_chacha_matrix_det(m : CryptosymchachaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_chacha_matrix_norm(m : CryptosymchachaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_chacha_matrix_to_string(m : CryptosymchachaMatrix) -> String {
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

pub(all) struct CryptosymchachaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_chacha_make_vector(comps : Array[Double]) -> CryptosymchachaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_chacha_vector_zero(dim : Int) -> CryptosymchachaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_chacha_vector_add(a : CryptosymchachaVector, b : CryptosymchachaVector) -> CryptosymchachaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_chacha_vector_sub(a : CryptosymchachaVector, b : CryptosymchachaVector) -> CryptosymchachaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_chacha_vector_scale(v : CryptosymchachaVector, s : Double) -> CryptosymchachaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_chacha_vector_dot(a : CryptosymchachaVector, b : CryptosymchachaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_chacha_vector_norm(v : CryptosymchachaVector) -> Double { @_common.sqrt(crypto_sym_chacha_vector_dot(v, v)) }

pub fn crypto_sym_chacha_vector_normalize(v : CryptosymchachaVector) -> CryptosymchachaVector {
  let n = crypto_sym_chacha_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_chacha_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_chacha_vector_dist(a : CryptosymchachaVector, b : CryptosymchachaVector) -> Double {
  crypto_sym_chacha_vector_norm(crypto_sym_chacha_vector_sub(a, b))
}

pub fn crypto_sym_chacha_vector_to_string(v : CryptosymchachaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_chacha_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_chacha_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_chacha_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_chacha_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_chacha_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_chacha_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_chacha_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_chacha_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_chacha_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_chacha_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_chacha_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_chacha_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_chacha_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_chacha_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_chacha_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_chacha_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_chacha_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_chacha_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_chacha_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_chacha_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_chacha_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_chacha_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_chacha_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_chacha_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_chacha_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_chacha_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_chacha_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_chacha_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_chacha_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymchachaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_frame_make(size : Int) -> CryptosymchachaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_frame_len(s : CryptosymchachaFrame) -> Int { s.size }

pub fn crypto_sym_chacha_frame_get(s : CryptosymchachaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_frame_set(s : CryptosymchachaFrame, i : Int, v : Double) -> CryptosymchachaFrame {
  let result = crypto_sym_chacha_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_frame_sum(s : CryptosymchachaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_frame_mean(s : CryptosymchachaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_frame_scale(s : CryptosymchachaFrame, f : Double) -> CryptosymchachaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_frame_add(a : CryptosymchachaFrame, b : CryptosymchachaFrame) -> CryptosymchachaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_frame_copy(s : CryptosymchachaFrame) -> CryptosymchachaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_frame_fill(s : CryptosymchachaFrame, v : Double) -> CryptosymchachaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_frame_min(s : CryptosymchachaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_frame_max(s : CryptosymchachaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_frame_to_string(s : CryptosymchachaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_table_make(size : Int) -> CryptosymchachaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_table_len(s : CryptosymchachaTable) -> Int { s.size }

pub fn crypto_sym_chacha_table_get(s : CryptosymchachaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_table_set(s : CryptosymchachaTable, i : Int, v : Double) -> CryptosymchachaTable {
  let result = crypto_sym_chacha_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_table_sum(s : CryptosymchachaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_table_mean(s : CryptosymchachaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_table_scale(s : CryptosymchachaTable, f : Double) -> CryptosymchachaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_table_add(a : CryptosymchachaTable, b : CryptosymchachaTable) -> CryptosymchachaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_table_copy(s : CryptosymchachaTable) -> CryptosymchachaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_table_fill(s : CryptosymchachaTable, v : Double) -> CryptosymchachaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_table_min(s : CryptosymchachaTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_table_max(s : CryptosymchachaTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_table_to_string(s : CryptosymchachaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_graphn_make(size : Int) -> CryptosymchachaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_graphn_len(s : CryptosymchachaGraphN) -> Int { s.size }

pub fn crypto_sym_chacha_graphn_get(s : CryptosymchachaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_graphn_set(s : CryptosymchachaGraphN, i : Int, v : Double) -> CryptosymchachaGraphN {
  let result = crypto_sym_chacha_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_graphn_sum(s : CryptosymchachaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_graphn_mean(s : CryptosymchachaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_graphn_scale(s : CryptosymchachaGraphN, f : Double) -> CryptosymchachaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_graphn_add(a : CryptosymchachaGraphN, b : CryptosymchachaGraphN) -> CryptosymchachaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_graphn_copy(s : CryptosymchachaGraphN) -> CryptosymchachaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_graphn_fill(s : CryptosymchachaGraphN, v : Double) -> CryptosymchachaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_graphn_min(s : CryptosymchachaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_graphn_max(s : CryptosymchachaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_graphn_to_string(s : CryptosymchachaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_node_make(size : Int) -> CryptosymchachaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_node_len(s : CryptosymchachaNode) -> Int { s.size }

pub fn crypto_sym_chacha_node_get(s : CryptosymchachaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_node_set(s : CryptosymchachaNode, i : Int, v : Double) -> CryptosymchachaNode {
  let result = crypto_sym_chacha_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_node_sum(s : CryptosymchachaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_node_mean(s : CryptosymchachaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_node_scale(s : CryptosymchachaNode, f : Double) -> CryptosymchachaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_node_add(a : CryptosymchachaNode, b : CryptosymchachaNode) -> CryptosymchachaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_node_copy(s : CryptosymchachaNode) -> CryptosymchachaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_node_fill(s : CryptosymchachaNode, v : Double) -> CryptosymchachaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_node_min(s : CryptosymchachaNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_node_max(s : CryptosymchachaNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_node_to_string(s : CryptosymchachaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_edge_make(size : Int) -> CryptosymchachaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_edge_len(s : CryptosymchachaEdge) -> Int { s.size }

pub fn crypto_sym_chacha_edge_get(s : CryptosymchachaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_edge_set(s : CryptosymchachaEdge, i : Int, v : Double) -> CryptosymchachaEdge {
  let result = crypto_sym_chacha_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_edge_sum(s : CryptosymchachaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_edge_mean(s : CryptosymchachaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_edge_scale(s : CryptosymchachaEdge, f : Double) -> CryptosymchachaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_edge_add(a : CryptosymchachaEdge, b : CryptosymchachaEdge) -> CryptosymchachaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_edge_copy(s : CryptosymchachaEdge) -> CryptosymchachaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_edge_fill(s : CryptosymchachaEdge, v : Double) -> CryptosymchachaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_edge_min(s : CryptosymchachaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_edge_max(s : CryptosymchachaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_edge_to_string(s : CryptosymchachaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_path_make(size : Int) -> CryptosymchachaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_path_len(s : CryptosymchachaPath) -> Int { s.size }

pub fn crypto_sym_chacha_path_get(s : CryptosymchachaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_path_set(s : CryptosymchachaPath, i : Int, v : Double) -> CryptosymchachaPath {
  let result = crypto_sym_chacha_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_path_sum(s : CryptosymchachaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_path_mean(s : CryptosymchachaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_path_scale(s : CryptosymchachaPath, f : Double) -> CryptosymchachaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_path_add(a : CryptosymchachaPath, b : CryptosymchachaPath) -> CryptosymchachaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_path_copy(s : CryptosymchachaPath) -> CryptosymchachaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_path_fill(s : CryptosymchachaPath, v : Double) -> CryptosymchachaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_path_min(s : CryptosymchachaPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_path_max(s : CryptosymchachaPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_path_to_string(s : CryptosymchachaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_cluster_make(size : Int) -> CryptosymchachaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_cluster_len(s : CryptosymchachaCluster) -> Int { s.size }

pub fn crypto_sym_chacha_cluster_get(s : CryptosymchachaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_cluster_set(s : CryptosymchachaCluster, i : Int, v : Double) -> CryptosymchachaCluster {
  let result = crypto_sym_chacha_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_cluster_sum(s : CryptosymchachaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_cluster_mean(s : CryptosymchachaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_cluster_scale(s : CryptosymchachaCluster, f : Double) -> CryptosymchachaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cluster_add(a : CryptosymchachaCluster, b : CryptosymchachaCluster) -> CryptosymchachaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_cluster_copy(s : CryptosymchachaCluster) -> CryptosymchachaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cluster_fill(s : CryptosymchachaCluster, v : Double) -> CryptosymchachaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cluster_min(s : CryptosymchachaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_cluster_max(s : CryptosymchachaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_cluster_to_string(s : CryptosymchachaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_model_make(size : Int) -> CryptosymchachaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_model_len(s : CryptosymchachaModel) -> Int { s.size }

pub fn crypto_sym_chacha_model_get(s : CryptosymchachaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_model_set(s : CryptosymchachaModel, i : Int, v : Double) -> CryptosymchachaModel {
  let result = crypto_sym_chacha_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_model_sum(s : CryptosymchachaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_model_mean(s : CryptosymchachaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_model_scale(s : CryptosymchachaModel, f : Double) -> CryptosymchachaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_model_add(a : CryptosymchachaModel, b : CryptosymchachaModel) -> CryptosymchachaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_model_copy(s : CryptosymchachaModel) -> CryptosymchachaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_model_fill(s : CryptosymchachaModel, v : Double) -> CryptosymchachaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_model_min(s : CryptosymchachaModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_model_max(s : CryptosymchachaModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_model_to_string(s : CryptosymchachaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_layer_make(size : Int) -> CryptosymchachaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_layer_len(s : CryptosymchachaLayer) -> Int { s.size }

pub fn crypto_sym_chacha_layer_get(s : CryptosymchachaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_layer_set(s : CryptosymchachaLayer, i : Int, v : Double) -> CryptosymchachaLayer {
  let result = crypto_sym_chacha_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_layer_sum(s : CryptosymchachaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_layer_mean(s : CryptosymchachaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_layer_scale(s : CryptosymchachaLayer, f : Double) -> CryptosymchachaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_layer_add(a : CryptosymchachaLayer, b : CryptosymchachaLayer) -> CryptosymchachaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_layer_copy(s : CryptosymchachaLayer) -> CryptosymchachaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_layer_fill(s : CryptosymchachaLayer, v : Double) -> CryptosymchachaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_layer_min(s : CryptosymchachaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_layer_max(s : CryptosymchachaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_layer_to_string(s : CryptosymchachaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_buffer_make(size : Int) -> CryptosymchachaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_buffer_len(s : CryptosymchachaBuffer) -> Int { s.size }

pub fn crypto_sym_chacha_buffer_get(s : CryptosymchachaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_buffer_set(s : CryptosymchachaBuffer, i : Int, v : Double) -> CryptosymchachaBuffer {
  let result = crypto_sym_chacha_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_buffer_sum(s : CryptosymchachaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_buffer_mean(s : CryptosymchachaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_buffer_scale(s : CryptosymchachaBuffer, f : Double) -> CryptosymchachaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_buffer_add(a : CryptosymchachaBuffer, b : CryptosymchachaBuffer) -> CryptosymchachaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_buffer_copy(s : CryptosymchachaBuffer) -> CryptosymchachaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_buffer_fill(s : CryptosymchachaBuffer, v : Double) -> CryptosymchachaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_buffer_min(s : CryptosymchachaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_buffer_max(s : CryptosymchachaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_buffer_to_string(s : CryptosymchachaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_cursor_make(size : Int) -> CryptosymchachaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_cursor_len(s : CryptosymchachaCursor) -> Int { s.size }

pub fn crypto_sym_chacha_cursor_get(s : CryptosymchachaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_cursor_set(s : CryptosymchachaCursor, i : Int, v : Double) -> CryptosymchachaCursor {
  let result = crypto_sym_chacha_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_cursor_sum(s : CryptosymchachaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_cursor_mean(s : CryptosymchachaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_cursor_scale(s : CryptosymchachaCursor, f : Double) -> CryptosymchachaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cursor_add(a : CryptosymchachaCursor, b : CryptosymchachaCursor) -> CryptosymchachaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_cursor_copy(s : CryptosymchachaCursor) -> CryptosymchachaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cursor_fill(s : CryptosymchachaCursor, v : Double) -> CryptosymchachaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cursor_min(s : CryptosymchachaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_cursor_max(s : CryptosymchachaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_cursor_to_string(s : CryptosymchachaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_view_make(size : Int) -> CryptosymchachaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_view_len(s : CryptosymchachaView) -> Int { s.size }

pub fn crypto_sym_chacha_view_get(s : CryptosymchachaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_view_set(s : CryptosymchachaView, i : Int, v : Double) -> CryptosymchachaView {
  let result = crypto_sym_chacha_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_view_sum(s : CryptosymchachaView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_view_mean(s : CryptosymchachaView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_view_scale(s : CryptosymchachaView, f : Double) -> CryptosymchachaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_view_add(a : CryptosymchachaView, b : CryptosymchachaView) -> CryptosymchachaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_view_copy(s : CryptosymchachaView) -> CryptosymchachaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_view_fill(s : CryptosymchachaView, v : Double) -> CryptosymchachaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_view_min(s : CryptosymchachaView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_view_max(s : CryptosymchachaView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_view_to_string(s : CryptosymchachaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_range_make(size : Int) -> CryptosymchachaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_range_len(s : CryptosymchachaRange) -> Int { s.size }

pub fn crypto_sym_chacha_range_get(s : CryptosymchachaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_range_set(s : CryptosymchachaRange, i : Int, v : Double) -> CryptosymchachaRange {
  let result = crypto_sym_chacha_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_range_sum(s : CryptosymchachaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_range_mean(s : CryptosymchachaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_range_scale(s : CryptosymchachaRange, f : Double) -> CryptosymchachaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_range_add(a : CryptosymchachaRange, b : CryptosymchachaRange) -> CryptosymchachaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_range_copy(s : CryptosymchachaRange) -> CryptosymchachaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_range_fill(s : CryptosymchachaRange, v : Double) -> CryptosymchachaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_range_min(s : CryptosymchachaRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_range_max(s : CryptosymchachaRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_range_to_string(s : CryptosymchachaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_slice_make(size : Int) -> CryptosymchachaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_slice_len(s : CryptosymchachaSlice) -> Int { s.size }

pub fn crypto_sym_chacha_slice_get(s : CryptosymchachaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_slice_set(s : CryptosymchachaSlice, i : Int, v : Double) -> CryptosymchachaSlice {
  let result = crypto_sym_chacha_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_chacha_slice_sum(s : CryptosymchachaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_slice_mean(s : CryptosymchachaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_slice_scale(s : CryptosymchachaSlice, f : Double) -> CryptosymchachaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_slice_add(a : CryptosymchachaSlice, b : CryptosymchachaSlice) -> CryptosymchachaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_slice_copy(s : CryptosymchachaSlice) -> CryptosymchachaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_slice_fill(s : CryptosymchachaSlice, v : Double) -> CryptosymchachaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_slice_min(s : CryptosymchachaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_slice_max(s : CryptosymchachaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_slice_to_string(s : CryptosymchachaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

