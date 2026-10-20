///===
/// extcore/crypto_sign_group

pub(all) struct CryptosigngroupPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_group_make_point(x : Double, y : Double) -> CryptosigngroupPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_group_make_point3(x : Double, y : Double, z : Double) -> CryptosigngroupPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_group_point_x(pt : CryptosigngroupPoint) -> Double { pt.x }

pub fn crypto_sign_group_point_y(pt : CryptosigngroupPoint) -> Double { pt.y }

pub fn crypto_sign_group_point_z(pt : CryptosigngroupPoint) -> Double { pt.z }

pub fn crypto_sign_group_point_label(pt : CryptosigngroupPoint) -> Int { pt.label }

pub fn crypto_sign_group_point_dist(a : CryptosigngroupPoint, b : CryptosigngroupPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_group_point_add(a : CryptosigngroupPoint, b : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_group_point_sub(a : CryptosigngroupPoint, b : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_group_point_scale(pt : CryptosigngroupPoint, s : Double) -> CryptosigngroupPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_group_point_dot(a : CryptosigngroupPoint, b : CryptosigngroupPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_group_point_cross(a : CryptosigngroupPoint, b : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_group_point_norm(pt : CryptosigngroupPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_group_point_normalize(pt : CryptosigngroupPoint) -> CryptosigngroupPoint {
  let n = crypto_sign_group_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_group_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_group_point_negate(pt : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_group_point_mid(a : CryptosigngroupPoint, b : CryptosigngroupPoint) -> CryptosigngroupPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_group_point_lerp(a : CryptosigngroupPoint, b : CryptosigngroupPoint, t : Double) -> CryptosigngroupPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_group_point_to_string(pt : CryptosigngroupPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosigngroupSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_group_make_series(vals : Array[Double], name : String) -> CryptosigngroupSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_group_series_len(s : CryptosigngroupSeries) -> Int { s.vals.length() }

pub fn crypto_sign_group_series_sum(s : CryptosigngroupSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sign_group_series_mean(s : CryptosigngroupSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sign_group_series_min(s : CryptosigngroupSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sign_group_series_max(s : CryptosigngroupSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sign_group_series_range(s : CryptosigngroupSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sign_group_series_var(s : CryptosigngroupSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sign_group_series_std(s : CryptosigngroupSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sign_group_series_median(s : CryptosigngroupSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sign_group_series_scale(s : CryptosigngroupSeries, f : Double) -> CryptosigngroupSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_group_series_add(a : CryptosigngroupSeries, b : CryptosigngroupSeries) -> CryptosigngroupSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_group_series_sub(a : CryptosigngroupSeries, b : CryptosigngroupSeries) -> CryptosigngroupSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_group_series_normalize(s : CryptosigngroupSeries) -> CryptosigngroupSeries {
  let mn = crypto_sign_group_series_min(s)
  let mx = crypto_sign_group_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_group_series_cumsum(s : CryptosigngroupSeries) -> CryptosigngroupSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_group_series_to_string(s : CryptosigngroupSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigngroupMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_group_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosigngroupMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_group_matrix_identity(n : Int) -> CryptosigngroupMatrix {
  let m = crypto_sign_group_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_group_matrix_get(m : CryptosigngroupMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_group_matrix_transpose(m : CryptosigngroupMatrix) -> CryptosigngroupMatrix {
  let result = crypto_sign_group_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_group_matrix_add(a : CryptosigngroupMatrix, b : CryptosigngroupMatrix) -> CryptosigngroupMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_group_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_group_matrix_scale(m : CryptosigngroupMatrix, s : Double) -> CryptosigngroupMatrix {
  let result = crypto_sign_group_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_group_matrix_multiply(a : CryptosigngroupMatrix, b : CryptosigngroupMatrix) -> CryptosigngroupMatrix {
  if a.cols != b.rows { return crypto_sign_group_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_group_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_group_matrix_trace(m : CryptosigngroupMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_group_matrix_det(m : CryptosigngroupMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_group_matrix_norm(m : CryptosigngroupMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sign_group_matrix_to_string(m : CryptosigngroupMatrix) -> String {
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

pub(all) struct CryptosigngroupVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_group_make_vector(comps : Array[Double]) -> CryptosigngroupVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_group_vector_zero(dim : Int) -> CryptosigngroupVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_group_vector_add(a : CryptosigngroupVector, b : CryptosigngroupVector) -> CryptosigngroupVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_group_vector_sub(a : CryptosigngroupVector, b : CryptosigngroupVector) -> CryptosigngroupVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_group_vector_scale(v : CryptosigngroupVector, s : Double) -> CryptosigngroupVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_group_vector_dot(a : CryptosigngroupVector, b : CryptosigngroupVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_group_vector_norm(v : CryptosigngroupVector) -> Double { @_common.sqrt(crypto_sign_group_vector_dot(v, v)) }

pub fn crypto_sign_group_vector_normalize(v : CryptosigngroupVector) -> CryptosigngroupVector {
  let n = crypto_sign_group_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_group_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_group_vector_dist(a : CryptosigngroupVector, b : CryptosigngroupVector) -> Double {
  crypto_sign_group_vector_norm(crypto_sign_group_vector_sub(a, b))
}

pub fn crypto_sign_group_vector_to_string(v : CryptosigngroupVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_group_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_group_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_group_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_group_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_group_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_group_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_group_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_group_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_group_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_group_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_group_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_group_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_group_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_group_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_group_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_group_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_group_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_group_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_group_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_group_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_group_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_group_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_group_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_group_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_group_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_group_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_group_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_group_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_group_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosigngroupFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_frame_make(size : Int) -> CryptosigngroupFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_frame_len(s : CryptosigngroupFrame) -> Int { s.size }

pub fn crypto_sign_group_frame_get(s : CryptosigngroupFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_frame_set(s : CryptosigngroupFrame, i : Int, v : Double) -> CryptosigngroupFrame {
  let result = crypto_sign_group_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_frame_sum(s : CryptosigngroupFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_frame_mean(s : CryptosigngroupFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_frame_scale(s : CryptosigngroupFrame, f : Double) -> CryptosigngroupFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_frame_add(a : CryptosigngroupFrame, b : CryptosigngroupFrame) -> CryptosigngroupFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_frame_copy(s : CryptosigngroupFrame) -> CryptosigngroupFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_frame_fill(s : CryptosigngroupFrame, v : Double) -> CryptosigngroupFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_frame_min(s : CryptosigngroupFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_frame_max(s : CryptosigngroupFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_frame_to_string(s : CryptosigngroupFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_table_make(size : Int) -> CryptosigngroupTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_table_len(s : CryptosigngroupTable) -> Int { s.size }

pub fn crypto_sign_group_table_get(s : CryptosigngroupTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_table_set(s : CryptosigngroupTable, i : Int, v : Double) -> CryptosigngroupTable {
  let result = crypto_sign_group_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_table_sum(s : CryptosigngroupTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_table_mean(s : CryptosigngroupTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_table_scale(s : CryptosigngroupTable, f : Double) -> CryptosigngroupTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_table_add(a : CryptosigngroupTable, b : CryptosigngroupTable) -> CryptosigngroupTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_table_copy(s : CryptosigngroupTable) -> CryptosigngroupTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_table_fill(s : CryptosigngroupTable, v : Double) -> CryptosigngroupTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_table_min(s : CryptosigngroupTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_table_max(s : CryptosigngroupTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_table_to_string(s : CryptosigngroupTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_graphn_make(size : Int) -> CryptosigngroupGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_graphn_len(s : CryptosigngroupGraphN) -> Int { s.size }

pub fn crypto_sign_group_graphn_get(s : CryptosigngroupGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_graphn_set(s : CryptosigngroupGraphN, i : Int, v : Double) -> CryptosigngroupGraphN {
  let result = crypto_sign_group_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_graphn_sum(s : CryptosigngroupGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_graphn_mean(s : CryptosigngroupGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_graphn_scale(s : CryptosigngroupGraphN, f : Double) -> CryptosigngroupGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_graphn_add(a : CryptosigngroupGraphN, b : CryptosigngroupGraphN) -> CryptosigngroupGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_graphn_copy(s : CryptosigngroupGraphN) -> CryptosigngroupGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_graphn_fill(s : CryptosigngroupGraphN, v : Double) -> CryptosigngroupGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_graphn_min(s : CryptosigngroupGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_graphn_max(s : CryptosigngroupGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_graphn_to_string(s : CryptosigngroupGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_node_make(size : Int) -> CryptosigngroupNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_node_len(s : CryptosigngroupNode) -> Int { s.size }

pub fn crypto_sign_group_node_get(s : CryptosigngroupNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_node_set(s : CryptosigngroupNode, i : Int, v : Double) -> CryptosigngroupNode {
  let result = crypto_sign_group_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_node_sum(s : CryptosigngroupNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_node_mean(s : CryptosigngroupNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_node_scale(s : CryptosigngroupNode, f : Double) -> CryptosigngroupNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_node_add(a : CryptosigngroupNode, b : CryptosigngroupNode) -> CryptosigngroupNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_node_copy(s : CryptosigngroupNode) -> CryptosigngroupNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_node_fill(s : CryptosigngroupNode, v : Double) -> CryptosigngroupNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_node_min(s : CryptosigngroupNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_node_max(s : CryptosigngroupNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_node_to_string(s : CryptosigngroupNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_edge_make(size : Int) -> CryptosigngroupEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_edge_len(s : CryptosigngroupEdge) -> Int { s.size }

pub fn crypto_sign_group_edge_get(s : CryptosigngroupEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_edge_set(s : CryptosigngroupEdge, i : Int, v : Double) -> CryptosigngroupEdge {
  let result = crypto_sign_group_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_edge_sum(s : CryptosigngroupEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_edge_mean(s : CryptosigngroupEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_edge_scale(s : CryptosigngroupEdge, f : Double) -> CryptosigngroupEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_edge_add(a : CryptosigngroupEdge, b : CryptosigngroupEdge) -> CryptosigngroupEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_edge_copy(s : CryptosigngroupEdge) -> CryptosigngroupEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_edge_fill(s : CryptosigngroupEdge, v : Double) -> CryptosigngroupEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_edge_min(s : CryptosigngroupEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_edge_max(s : CryptosigngroupEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_edge_to_string(s : CryptosigngroupEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_path_make(size : Int) -> CryptosigngroupPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_path_len(s : CryptosigngroupPath) -> Int { s.size }

pub fn crypto_sign_group_path_get(s : CryptosigngroupPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_path_set(s : CryptosigngroupPath, i : Int, v : Double) -> CryptosigngroupPath {
  let result = crypto_sign_group_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_path_sum(s : CryptosigngroupPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_path_mean(s : CryptosigngroupPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_path_scale(s : CryptosigngroupPath, f : Double) -> CryptosigngroupPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_path_add(a : CryptosigngroupPath, b : CryptosigngroupPath) -> CryptosigngroupPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_path_copy(s : CryptosigngroupPath) -> CryptosigngroupPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_path_fill(s : CryptosigngroupPath, v : Double) -> CryptosigngroupPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_path_min(s : CryptosigngroupPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_path_max(s : CryptosigngroupPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_path_to_string(s : CryptosigngroupPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_cluster_make(size : Int) -> CryptosigngroupCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_cluster_len(s : CryptosigngroupCluster) -> Int { s.size }

pub fn crypto_sign_group_cluster_get(s : CryptosigngroupCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_cluster_set(s : CryptosigngroupCluster, i : Int, v : Double) -> CryptosigngroupCluster {
  let result = crypto_sign_group_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_cluster_sum(s : CryptosigngroupCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_cluster_mean(s : CryptosigngroupCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_cluster_scale(s : CryptosigngroupCluster, f : Double) -> CryptosigngroupCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cluster_add(a : CryptosigngroupCluster, b : CryptosigngroupCluster) -> CryptosigngroupCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_cluster_copy(s : CryptosigngroupCluster) -> CryptosigngroupCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cluster_fill(s : CryptosigngroupCluster, v : Double) -> CryptosigngroupCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cluster_min(s : CryptosigngroupCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_cluster_max(s : CryptosigngroupCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_cluster_to_string(s : CryptosigngroupCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_model_make(size : Int) -> CryptosigngroupModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_model_len(s : CryptosigngroupModel) -> Int { s.size }

pub fn crypto_sign_group_model_get(s : CryptosigngroupModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_model_set(s : CryptosigngroupModel, i : Int, v : Double) -> CryptosigngroupModel {
  let result = crypto_sign_group_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_model_sum(s : CryptosigngroupModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_model_mean(s : CryptosigngroupModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_model_scale(s : CryptosigngroupModel, f : Double) -> CryptosigngroupModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_model_add(a : CryptosigngroupModel, b : CryptosigngroupModel) -> CryptosigngroupModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_model_copy(s : CryptosigngroupModel) -> CryptosigngroupModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_model_fill(s : CryptosigngroupModel, v : Double) -> CryptosigngroupModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_model_min(s : CryptosigngroupModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_model_max(s : CryptosigngroupModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_model_to_string(s : CryptosigngroupModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_layer_make(size : Int) -> CryptosigngroupLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_layer_len(s : CryptosigngroupLayer) -> Int { s.size }

pub fn crypto_sign_group_layer_get(s : CryptosigngroupLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_layer_set(s : CryptosigngroupLayer, i : Int, v : Double) -> CryptosigngroupLayer {
  let result = crypto_sign_group_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_layer_sum(s : CryptosigngroupLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_layer_mean(s : CryptosigngroupLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_layer_scale(s : CryptosigngroupLayer, f : Double) -> CryptosigngroupLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_layer_add(a : CryptosigngroupLayer, b : CryptosigngroupLayer) -> CryptosigngroupLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_layer_copy(s : CryptosigngroupLayer) -> CryptosigngroupLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_layer_fill(s : CryptosigngroupLayer, v : Double) -> CryptosigngroupLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_layer_min(s : CryptosigngroupLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_layer_max(s : CryptosigngroupLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_layer_to_string(s : CryptosigngroupLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_buffer_make(size : Int) -> CryptosigngroupBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_buffer_len(s : CryptosigngroupBuffer) -> Int { s.size }

pub fn crypto_sign_group_buffer_get(s : CryptosigngroupBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_buffer_set(s : CryptosigngroupBuffer, i : Int, v : Double) -> CryptosigngroupBuffer {
  let result = crypto_sign_group_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_buffer_sum(s : CryptosigngroupBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_buffer_mean(s : CryptosigngroupBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_buffer_scale(s : CryptosigngroupBuffer, f : Double) -> CryptosigngroupBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_buffer_add(a : CryptosigngroupBuffer, b : CryptosigngroupBuffer) -> CryptosigngroupBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_buffer_copy(s : CryptosigngroupBuffer) -> CryptosigngroupBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_buffer_fill(s : CryptosigngroupBuffer, v : Double) -> CryptosigngroupBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_buffer_min(s : CryptosigngroupBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_buffer_max(s : CryptosigngroupBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_buffer_to_string(s : CryptosigngroupBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_cursor_make(size : Int) -> CryptosigngroupCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_cursor_len(s : CryptosigngroupCursor) -> Int { s.size }

pub fn crypto_sign_group_cursor_get(s : CryptosigngroupCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_cursor_set(s : CryptosigngroupCursor, i : Int, v : Double) -> CryptosigngroupCursor {
  let result = crypto_sign_group_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_cursor_sum(s : CryptosigngroupCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_cursor_mean(s : CryptosigngroupCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_cursor_scale(s : CryptosigngroupCursor, f : Double) -> CryptosigngroupCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cursor_add(a : CryptosigngroupCursor, b : CryptosigngroupCursor) -> CryptosigngroupCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_cursor_copy(s : CryptosigngroupCursor) -> CryptosigngroupCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cursor_fill(s : CryptosigngroupCursor, v : Double) -> CryptosigngroupCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_cursor_min(s : CryptosigngroupCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_cursor_max(s : CryptosigngroupCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_cursor_to_string(s : CryptosigngroupCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_view_make(size : Int) -> CryptosigngroupView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_view_len(s : CryptosigngroupView) -> Int { s.size }

pub fn crypto_sign_group_view_get(s : CryptosigngroupView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_view_set(s : CryptosigngroupView, i : Int, v : Double) -> CryptosigngroupView {
  let result = crypto_sign_group_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_view_sum(s : CryptosigngroupView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_view_mean(s : CryptosigngroupView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_view_scale(s : CryptosigngroupView, f : Double) -> CryptosigngroupView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_view_add(a : CryptosigngroupView, b : CryptosigngroupView) -> CryptosigngroupView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_view_copy(s : CryptosigngroupView) -> CryptosigngroupView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_view_fill(s : CryptosigngroupView, v : Double) -> CryptosigngroupView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_view_min(s : CryptosigngroupView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_view_max(s : CryptosigngroupView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_view_to_string(s : CryptosigngroupView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_range_make(size : Int) -> CryptosigngroupRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_range_len(s : CryptosigngroupRange) -> Int { s.size }

pub fn crypto_sign_group_range_get(s : CryptosigngroupRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_range_set(s : CryptosigngroupRange, i : Int, v : Double) -> CryptosigngroupRange {
  let result = crypto_sign_group_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_range_sum(s : CryptosigngroupRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_range_mean(s : CryptosigngroupRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_range_scale(s : CryptosigngroupRange, f : Double) -> CryptosigngroupRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_range_add(a : CryptosigngroupRange, b : CryptosigngroupRange) -> CryptosigngroupRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_range_copy(s : CryptosigngroupRange) -> CryptosigngroupRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_range_fill(s : CryptosigngroupRange, v : Double) -> CryptosigngroupRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_range_min(s : CryptosigngroupRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_range_max(s : CryptosigngroupRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_range_to_string(s : CryptosigngroupRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigngroupSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_group_slice_make(size : Int) -> CryptosigngroupSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_group_slice_len(s : CryptosigngroupSlice) -> Int { s.size }

pub fn crypto_sign_group_slice_get(s : CryptosigngroupSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_group_slice_set(s : CryptosigngroupSlice, i : Int, v : Double) -> CryptosigngroupSlice {
  let result = crypto_sign_group_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_group_slice_sum(s : CryptosigngroupSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_group_slice_mean(s : CryptosigngroupSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_group_slice_scale(s : CryptosigngroupSlice, f : Double) -> CryptosigngroupSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_slice_add(a : CryptosigngroupSlice, b : CryptosigngroupSlice) -> CryptosigngroupSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_group_slice_copy(s : CryptosigngroupSlice) -> CryptosigngroupSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_slice_fill(s : CryptosigngroupSlice, v : Double) -> CryptosigngroupSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_group_slice_min(s : CryptosigngroupSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_group_slice_max(s : CryptosigngroupSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_group_slice_to_string(s : CryptosigngroupSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

