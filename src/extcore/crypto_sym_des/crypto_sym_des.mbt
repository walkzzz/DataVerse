///===
/// extcore/crypto_sym_des

pub(all) struct CryptosymdesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_des_make_point(x : Double, y : Double) -> CryptosymdesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_des_make_point3(x : Double, y : Double, z : Double) -> CryptosymdesPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_des_point_x(pt : CryptosymdesPoint) -> Double { pt.x }

pub fn crypto_sym_des_point_y(pt : CryptosymdesPoint) -> Double { pt.y }

pub fn crypto_sym_des_point_z(pt : CryptosymdesPoint) -> Double { pt.z }

pub fn crypto_sym_des_point_label(pt : CryptosymdesPoint) -> Int { pt.label }

pub fn crypto_sym_des_point_dist(a : CryptosymdesPoint, b : CryptosymdesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_des_point_add(a : CryptosymdesPoint, b : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_des_point_sub(a : CryptosymdesPoint, b : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_des_point_scale(pt : CryptosymdesPoint, s : Double) -> CryptosymdesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_des_point_dot(a : CryptosymdesPoint, b : CryptosymdesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_des_point_cross(a : CryptosymdesPoint, b : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_des_point_norm(pt : CryptosymdesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_des_point_normalize(pt : CryptosymdesPoint) -> CryptosymdesPoint {
  let n = crypto_sym_des_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_des_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_des_point_negate(pt : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_des_point_mid(a : CryptosymdesPoint, b : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_des_point_lerp(a : CryptosymdesPoint, b : CryptosymdesPoint, t : Double) -> CryptosymdesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_des_point_to_string(pt : CryptosymdesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymdesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_des_make_series(vals : Array[Double], name : String) -> CryptosymdesSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_des_series_len(s : CryptosymdesSeries) -> Int { s.vals.length() }

pub fn crypto_sym_des_series_sum(s : CryptosymdesSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sym_des_series_mean(s : CryptosymdesSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sym_des_series_min(s : CryptosymdesSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sym_des_series_max(s : CryptosymdesSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sym_des_series_range(s : CryptosymdesSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sym_des_series_var(s : CryptosymdesSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sym_des_series_std(s : CryptosymdesSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sym_des_series_median(s : CryptosymdesSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sym_des_series_scale(s : CryptosymdesSeries, f : Double) -> CryptosymdesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_des_series_add(a : CryptosymdesSeries, b : CryptosymdesSeries) -> CryptosymdesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_des_series_sub(a : CryptosymdesSeries, b : CryptosymdesSeries) -> CryptosymdesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_des_series_normalize(s : CryptosymdesSeries) -> CryptosymdesSeries {
  let mn = crypto_sym_des_series_min(s)
  let mx = crypto_sym_des_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_des_series_cumsum(s : CryptosymdesSeries) -> CryptosymdesSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_des_series_to_string(s : CryptosymdesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymdesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_des_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymdesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_des_matrix_identity(n : Int) -> CryptosymdesMatrix {
  let m = crypto_sym_des_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_des_matrix_get(m : CryptosymdesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_des_matrix_transpose(m : CryptosymdesMatrix) -> CryptosymdesMatrix {
  let result = crypto_sym_des_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_des_matrix_add(a : CryptosymdesMatrix, b : CryptosymdesMatrix) -> CryptosymdesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_des_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_des_matrix_scale(m : CryptosymdesMatrix, s : Double) -> CryptosymdesMatrix {
  let result = crypto_sym_des_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_des_matrix_multiply(a : CryptosymdesMatrix, b : CryptosymdesMatrix) -> CryptosymdesMatrix {
  if a.cols != b.rows { return crypto_sym_des_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_des_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_des_matrix_trace(m : CryptosymdesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_des_matrix_det(m : CryptosymdesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_des_matrix_norm(m : CryptosymdesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_des_matrix_to_string(m : CryptosymdesMatrix) -> String {
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

pub(all) struct CryptosymdesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_des_make_vector(comps : Array[Double]) -> CryptosymdesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_des_vector_zero(dim : Int) -> CryptosymdesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_des_vector_add(a : CryptosymdesVector, b : CryptosymdesVector) -> CryptosymdesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_des_vector_sub(a : CryptosymdesVector, b : CryptosymdesVector) -> CryptosymdesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_des_vector_scale(v : CryptosymdesVector, s : Double) -> CryptosymdesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_des_vector_dot(a : CryptosymdesVector, b : CryptosymdesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_des_vector_norm(v : CryptosymdesVector) -> Double { @_common.sqrt(crypto_sym_des_vector_dot(v, v)) }

pub fn crypto_sym_des_vector_normalize(v : CryptosymdesVector) -> CryptosymdesVector {
  let n = crypto_sym_des_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_des_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_des_vector_dist(a : CryptosymdesVector, b : CryptosymdesVector) -> Double {
  crypto_sym_des_vector_norm(crypto_sym_des_vector_sub(a, b))
}

pub fn crypto_sym_des_vector_to_string(v : CryptosymdesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_des_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_des_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_des_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_des_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_des_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_des_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_des_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_des_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_des_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_des_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_des_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_des_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_des_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_des_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_des_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_des_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_des_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_des_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_des_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_des_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_des_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_des_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_des_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_des_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_des_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_des_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_des_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_des_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_des_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymdesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_frame_make(size : Int) -> CryptosymdesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_frame_len(s : CryptosymdesFrame) -> Int { s.size }

pub fn crypto_sym_des_frame_get(s : CryptosymdesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_frame_set(s : CryptosymdesFrame, i : Int, v : Double) -> CryptosymdesFrame {
  let result = crypto_sym_des_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_frame_sum(s : CryptosymdesFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_frame_mean(s : CryptosymdesFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_frame_scale(s : CryptosymdesFrame, f : Double) -> CryptosymdesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_frame_add(a : CryptosymdesFrame, b : CryptosymdesFrame) -> CryptosymdesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_frame_copy(s : CryptosymdesFrame) -> CryptosymdesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_frame_fill(s : CryptosymdesFrame, v : Double) -> CryptosymdesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_frame_min(s : CryptosymdesFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_frame_max(s : CryptosymdesFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_frame_to_string(s : CryptosymdesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_table_make(size : Int) -> CryptosymdesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_table_len(s : CryptosymdesTable) -> Int { s.size }

pub fn crypto_sym_des_table_get(s : CryptosymdesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_table_set(s : CryptosymdesTable, i : Int, v : Double) -> CryptosymdesTable {
  let result = crypto_sym_des_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_table_sum(s : CryptosymdesTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_table_mean(s : CryptosymdesTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_table_scale(s : CryptosymdesTable, f : Double) -> CryptosymdesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_table_add(a : CryptosymdesTable, b : CryptosymdesTable) -> CryptosymdesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_table_copy(s : CryptosymdesTable) -> CryptosymdesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_table_fill(s : CryptosymdesTable, v : Double) -> CryptosymdesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_table_min(s : CryptosymdesTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_table_max(s : CryptosymdesTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_table_to_string(s : CryptosymdesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_graphn_make(size : Int) -> CryptosymdesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_graphn_len(s : CryptosymdesGraphN) -> Int { s.size }

pub fn crypto_sym_des_graphn_get(s : CryptosymdesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_graphn_set(s : CryptosymdesGraphN, i : Int, v : Double) -> CryptosymdesGraphN {
  let result = crypto_sym_des_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_graphn_sum(s : CryptosymdesGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_graphn_mean(s : CryptosymdesGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_graphn_scale(s : CryptosymdesGraphN, f : Double) -> CryptosymdesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_graphn_add(a : CryptosymdesGraphN, b : CryptosymdesGraphN) -> CryptosymdesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_graphn_copy(s : CryptosymdesGraphN) -> CryptosymdesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_graphn_fill(s : CryptosymdesGraphN, v : Double) -> CryptosymdesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_graphn_min(s : CryptosymdesGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_graphn_max(s : CryptosymdesGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_graphn_to_string(s : CryptosymdesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_node_make(size : Int) -> CryptosymdesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_node_len(s : CryptosymdesNode) -> Int { s.size }

pub fn crypto_sym_des_node_get(s : CryptosymdesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_node_set(s : CryptosymdesNode, i : Int, v : Double) -> CryptosymdesNode {
  let result = crypto_sym_des_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_node_sum(s : CryptosymdesNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_node_mean(s : CryptosymdesNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_node_scale(s : CryptosymdesNode, f : Double) -> CryptosymdesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_node_add(a : CryptosymdesNode, b : CryptosymdesNode) -> CryptosymdesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_node_copy(s : CryptosymdesNode) -> CryptosymdesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_node_fill(s : CryptosymdesNode, v : Double) -> CryptosymdesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_node_min(s : CryptosymdesNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_node_max(s : CryptosymdesNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_node_to_string(s : CryptosymdesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_edge_make(size : Int) -> CryptosymdesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_edge_len(s : CryptosymdesEdge) -> Int { s.size }

pub fn crypto_sym_des_edge_get(s : CryptosymdesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_edge_set(s : CryptosymdesEdge, i : Int, v : Double) -> CryptosymdesEdge {
  let result = crypto_sym_des_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_edge_sum(s : CryptosymdesEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_edge_mean(s : CryptosymdesEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_edge_scale(s : CryptosymdesEdge, f : Double) -> CryptosymdesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_edge_add(a : CryptosymdesEdge, b : CryptosymdesEdge) -> CryptosymdesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_edge_copy(s : CryptosymdesEdge) -> CryptosymdesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_edge_fill(s : CryptosymdesEdge, v : Double) -> CryptosymdesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_edge_min(s : CryptosymdesEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_edge_max(s : CryptosymdesEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_edge_to_string(s : CryptosymdesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_path_make(size : Int) -> CryptosymdesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_path_len(s : CryptosymdesPath) -> Int { s.size }

pub fn crypto_sym_des_path_get(s : CryptosymdesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_path_set(s : CryptosymdesPath, i : Int, v : Double) -> CryptosymdesPath {
  let result = crypto_sym_des_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_path_sum(s : CryptosymdesPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_path_mean(s : CryptosymdesPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_path_scale(s : CryptosymdesPath, f : Double) -> CryptosymdesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_path_add(a : CryptosymdesPath, b : CryptosymdesPath) -> CryptosymdesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_path_copy(s : CryptosymdesPath) -> CryptosymdesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_path_fill(s : CryptosymdesPath, v : Double) -> CryptosymdesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_path_min(s : CryptosymdesPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_path_max(s : CryptosymdesPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_path_to_string(s : CryptosymdesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_cluster_make(size : Int) -> CryptosymdesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_cluster_len(s : CryptosymdesCluster) -> Int { s.size }

pub fn crypto_sym_des_cluster_get(s : CryptosymdesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_cluster_set(s : CryptosymdesCluster, i : Int, v : Double) -> CryptosymdesCluster {
  let result = crypto_sym_des_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_cluster_sum(s : CryptosymdesCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_cluster_mean(s : CryptosymdesCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_cluster_scale(s : CryptosymdesCluster, f : Double) -> CryptosymdesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cluster_add(a : CryptosymdesCluster, b : CryptosymdesCluster) -> CryptosymdesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_cluster_copy(s : CryptosymdesCluster) -> CryptosymdesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cluster_fill(s : CryptosymdesCluster, v : Double) -> CryptosymdesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cluster_min(s : CryptosymdesCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_cluster_max(s : CryptosymdesCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_cluster_to_string(s : CryptosymdesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_model_make(size : Int) -> CryptosymdesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_model_len(s : CryptosymdesModel) -> Int { s.size }

pub fn crypto_sym_des_model_get(s : CryptosymdesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_model_set(s : CryptosymdesModel, i : Int, v : Double) -> CryptosymdesModel {
  let result = crypto_sym_des_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_model_sum(s : CryptosymdesModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_model_mean(s : CryptosymdesModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_model_scale(s : CryptosymdesModel, f : Double) -> CryptosymdesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_model_add(a : CryptosymdesModel, b : CryptosymdesModel) -> CryptosymdesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_model_copy(s : CryptosymdesModel) -> CryptosymdesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_model_fill(s : CryptosymdesModel, v : Double) -> CryptosymdesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_model_min(s : CryptosymdesModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_model_max(s : CryptosymdesModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_model_to_string(s : CryptosymdesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_layer_make(size : Int) -> CryptosymdesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_layer_len(s : CryptosymdesLayer) -> Int { s.size }

pub fn crypto_sym_des_layer_get(s : CryptosymdesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_layer_set(s : CryptosymdesLayer, i : Int, v : Double) -> CryptosymdesLayer {
  let result = crypto_sym_des_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_layer_sum(s : CryptosymdesLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_layer_mean(s : CryptosymdesLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_layer_scale(s : CryptosymdesLayer, f : Double) -> CryptosymdesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_layer_add(a : CryptosymdesLayer, b : CryptosymdesLayer) -> CryptosymdesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_layer_copy(s : CryptosymdesLayer) -> CryptosymdesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_layer_fill(s : CryptosymdesLayer, v : Double) -> CryptosymdesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_layer_min(s : CryptosymdesLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_layer_max(s : CryptosymdesLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_layer_to_string(s : CryptosymdesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_buffer_make(size : Int) -> CryptosymdesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_buffer_len(s : CryptosymdesBuffer) -> Int { s.size }

pub fn crypto_sym_des_buffer_get(s : CryptosymdesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_buffer_set(s : CryptosymdesBuffer, i : Int, v : Double) -> CryptosymdesBuffer {
  let result = crypto_sym_des_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_buffer_sum(s : CryptosymdesBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_buffer_mean(s : CryptosymdesBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_buffer_scale(s : CryptosymdesBuffer, f : Double) -> CryptosymdesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_buffer_add(a : CryptosymdesBuffer, b : CryptosymdesBuffer) -> CryptosymdesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_buffer_copy(s : CryptosymdesBuffer) -> CryptosymdesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_buffer_fill(s : CryptosymdesBuffer, v : Double) -> CryptosymdesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_buffer_min(s : CryptosymdesBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_buffer_max(s : CryptosymdesBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_buffer_to_string(s : CryptosymdesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_cursor_make(size : Int) -> CryptosymdesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_cursor_len(s : CryptosymdesCursor) -> Int { s.size }

pub fn crypto_sym_des_cursor_get(s : CryptosymdesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_cursor_set(s : CryptosymdesCursor, i : Int, v : Double) -> CryptosymdesCursor {
  let result = crypto_sym_des_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_cursor_sum(s : CryptosymdesCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_cursor_mean(s : CryptosymdesCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_cursor_scale(s : CryptosymdesCursor, f : Double) -> CryptosymdesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cursor_add(a : CryptosymdesCursor, b : CryptosymdesCursor) -> CryptosymdesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_cursor_copy(s : CryptosymdesCursor) -> CryptosymdesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cursor_fill(s : CryptosymdesCursor, v : Double) -> CryptosymdesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cursor_min(s : CryptosymdesCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_cursor_max(s : CryptosymdesCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_cursor_to_string(s : CryptosymdesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_view_make(size : Int) -> CryptosymdesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_view_len(s : CryptosymdesView) -> Int { s.size }

pub fn crypto_sym_des_view_get(s : CryptosymdesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_view_set(s : CryptosymdesView, i : Int, v : Double) -> CryptosymdesView {
  let result = crypto_sym_des_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_view_sum(s : CryptosymdesView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_view_mean(s : CryptosymdesView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_view_scale(s : CryptosymdesView, f : Double) -> CryptosymdesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_view_add(a : CryptosymdesView, b : CryptosymdesView) -> CryptosymdesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_view_copy(s : CryptosymdesView) -> CryptosymdesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_view_fill(s : CryptosymdesView, v : Double) -> CryptosymdesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_view_min(s : CryptosymdesView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_view_max(s : CryptosymdesView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_view_to_string(s : CryptosymdesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_range_make(size : Int) -> CryptosymdesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_range_len(s : CryptosymdesRange) -> Int { s.size }

pub fn crypto_sym_des_range_get(s : CryptosymdesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_range_set(s : CryptosymdesRange, i : Int, v : Double) -> CryptosymdesRange {
  let result = crypto_sym_des_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_range_sum(s : CryptosymdesRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_range_mean(s : CryptosymdesRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_range_scale(s : CryptosymdesRange, f : Double) -> CryptosymdesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_range_add(a : CryptosymdesRange, b : CryptosymdesRange) -> CryptosymdesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_range_copy(s : CryptosymdesRange) -> CryptosymdesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_range_fill(s : CryptosymdesRange, v : Double) -> CryptosymdesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_range_min(s : CryptosymdesRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_range_max(s : CryptosymdesRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_range_to_string(s : CryptosymdesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_slice_make(size : Int) -> CryptosymdesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_slice_len(s : CryptosymdesSlice) -> Int { s.size }

pub fn crypto_sym_des_slice_get(s : CryptosymdesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_slice_set(s : CryptosymdesSlice, i : Int, v : Double) -> CryptosymdesSlice {
  let result = crypto_sym_des_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_des_slice_sum(s : CryptosymdesSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_slice_mean(s : CryptosymdesSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_slice_scale(s : CryptosymdesSlice, f : Double) -> CryptosymdesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_slice_add(a : CryptosymdesSlice, b : CryptosymdesSlice) -> CryptosymdesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_slice_copy(s : CryptosymdesSlice) -> CryptosymdesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_slice_fill(s : CryptosymdesSlice, v : Double) -> CryptosymdesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_slice_min(s : CryptosymdesSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_slice_max(s : CryptosymdesSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_slice_to_string(s : CryptosymdesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

