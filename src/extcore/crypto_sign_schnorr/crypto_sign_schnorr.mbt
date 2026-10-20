///===
/// extcore/crypto_sign_schnorr

pub(all) struct CryptosignschnorrPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_schnorr_make_point(x : Double, y : Double) -> CryptosignschnorrPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_schnorr_make_point3(x : Double, y : Double, z : Double) -> CryptosignschnorrPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_schnorr_point_x(pt : CryptosignschnorrPoint) -> Double { pt.x }

pub fn crypto_sign_schnorr_point_y(pt : CryptosignschnorrPoint) -> Double { pt.y }

pub fn crypto_sign_schnorr_point_z(pt : CryptosignschnorrPoint) -> Double { pt.z }

pub fn crypto_sign_schnorr_point_label(pt : CryptosignschnorrPoint) -> Int { pt.label }

pub fn crypto_sign_schnorr_point_dist(a : CryptosignschnorrPoint, b : CryptosignschnorrPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_schnorr_point_add(a : CryptosignschnorrPoint, b : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_schnorr_point_sub(a : CryptosignschnorrPoint, b : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_schnorr_point_scale(pt : CryptosignschnorrPoint, s : Double) -> CryptosignschnorrPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_schnorr_point_dot(a : CryptosignschnorrPoint, b : CryptosignschnorrPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_schnorr_point_cross(a : CryptosignschnorrPoint, b : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_schnorr_point_norm(pt : CryptosignschnorrPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_schnorr_point_normalize(pt : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  let n = crypto_sign_schnorr_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_schnorr_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_schnorr_point_negate(pt : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_schnorr_point_mid(a : CryptosignschnorrPoint, b : CryptosignschnorrPoint) -> CryptosignschnorrPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_schnorr_point_lerp(a : CryptosignschnorrPoint, b : CryptosignschnorrPoint, t : Double) -> CryptosignschnorrPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_schnorr_point_to_string(pt : CryptosignschnorrPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosignschnorrSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_schnorr_make_series(vals : Array[Double], name : String) -> CryptosignschnorrSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_schnorr_series_len(s : CryptosignschnorrSeries) -> Int { s.vals.length() }

pub fn crypto_sign_schnorr_series_sum(s : CryptosignschnorrSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sign_schnorr_series_mean(s : CryptosignschnorrSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sign_schnorr_series_min(s : CryptosignschnorrSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sign_schnorr_series_max(s : CryptosignschnorrSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sign_schnorr_series_range(s : CryptosignschnorrSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sign_schnorr_series_var(s : CryptosignschnorrSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sign_schnorr_series_std(s : CryptosignschnorrSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sign_schnorr_series_median(s : CryptosignschnorrSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sign_schnorr_series_scale(s : CryptosignschnorrSeries, f : Double) -> CryptosignschnorrSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn crypto_sign_schnorr_series_add(a : CryptosignschnorrSeries, b : CryptosignschnorrSeries) -> CryptosignschnorrSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_schnorr_series_sub(a : CryptosignschnorrSeries, b : CryptosignschnorrSeries) -> CryptosignschnorrSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_schnorr_series_normalize(s : CryptosignschnorrSeries) -> CryptosignschnorrSeries {
  let mn = crypto_sign_schnorr_series_min(s)
  let mx = crypto_sign_schnorr_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_schnorr_series_cumsum(s : CryptosignschnorrSeries) -> CryptosignschnorrSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_schnorr_series_to_string(s : CryptosignschnorrSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignschnorrMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_schnorr_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignschnorrMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_schnorr_matrix_identity(n : Int) -> CryptosignschnorrMatrix {
  let m = crypto_sign_schnorr_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_schnorr_matrix_get(m : CryptosignschnorrMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_schnorr_matrix_transpose(m : CryptosignschnorrMatrix) -> CryptosignschnorrMatrix {
  let result = crypto_sign_schnorr_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_schnorr_matrix_add(a : CryptosignschnorrMatrix, b : CryptosignschnorrMatrix) -> CryptosignschnorrMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_schnorr_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_schnorr_matrix_scale(m : CryptosignschnorrMatrix, s : Double) -> CryptosignschnorrMatrix {
  let result = crypto_sign_schnorr_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_schnorr_matrix_multiply(a : CryptosignschnorrMatrix, b : CryptosignschnorrMatrix) -> CryptosignschnorrMatrix {
  if a.cols != b.rows { return crypto_sign_schnorr_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_schnorr_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_schnorr_matrix_trace(m : CryptosignschnorrMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_schnorr_matrix_det(m : CryptosignschnorrMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_schnorr_matrix_norm(m : CryptosignschnorrMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sign_schnorr_matrix_to_string(m : CryptosignschnorrMatrix) -> String {
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

pub(all) struct CryptosignschnorrVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_schnorr_make_vector(comps : Array[Double]) -> CryptosignschnorrVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_schnorr_vector_zero(dim : Int) -> CryptosignschnorrVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_schnorr_vector_add(a : CryptosignschnorrVector, b : CryptosignschnorrVector) -> CryptosignschnorrVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_sign_schnorr_vector_sub(a : CryptosignschnorrVector, b : CryptosignschnorrVector) -> CryptosignschnorrVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn crypto_sign_schnorr_vector_scale(v : CryptosignschnorrVector, s : Double) -> CryptosignschnorrVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn crypto_sign_schnorr_vector_dot(a : CryptosignschnorrVector, b : CryptosignschnorrVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_schnorr_vector_norm(v : CryptosignschnorrVector) -> Double { @_common.sqrt(crypto_sign_schnorr_vector_dot(v, v)) }

pub fn crypto_sign_schnorr_vector_normalize(v : CryptosignschnorrVector) -> CryptosignschnorrVector {
  let n = crypto_sign_schnorr_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_schnorr_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_schnorr_vector_dist(a : CryptosignschnorrVector, b : CryptosignschnorrVector) -> Double {
  crypto_sign_schnorr_vector_norm(crypto_sign_schnorr_vector_sub(a, b))
}

pub fn crypto_sign_schnorr_vector_to_string(v : CryptosignschnorrVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_schnorr_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_schnorr_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_schnorr_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_schnorr_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_schnorr_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_schnorr_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_schnorr_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_schnorr_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_schnorr_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_schnorr_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_schnorr_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_schnorr_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_schnorr_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_schnorr_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_schnorr_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_schnorr_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_schnorr_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_schnorr_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_schnorr_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_schnorr_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_schnorr_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_schnorr_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_schnorr_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_schnorr_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_schnorr_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_schnorr_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_schnorr_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_schnorr_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_schnorr_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignschnorrFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_frame_make(size : Int) -> CryptosignschnorrFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_frame_len(s : CryptosignschnorrFrame) -> Int { s.size }

pub fn crypto_sign_schnorr_frame_get(s : CryptosignschnorrFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_frame_set(s : CryptosignschnorrFrame, i : Int, v : Double) -> CryptosignschnorrFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_frame_sum(s : CryptosignschnorrFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_frame_mean(s : CryptosignschnorrFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_frame_scale(s : CryptosignschnorrFrame, f : Double) -> CryptosignschnorrFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_frame_add(a : CryptosignschnorrFrame, b : CryptosignschnorrFrame) -> CryptosignschnorrFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_frame_copy(s : CryptosignschnorrFrame) -> CryptosignschnorrFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_frame_fill(s : CryptosignschnorrFrame, v : Double) -> CryptosignschnorrFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_frame_min(s : CryptosignschnorrFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_frame_max(s : CryptosignschnorrFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_frame_to_string(s : CryptosignschnorrFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_table_make(size : Int) -> CryptosignschnorrTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_table_len(s : CryptosignschnorrTable) -> Int { s.size }

pub fn crypto_sign_schnorr_table_get(s : CryptosignschnorrTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_table_set(s : CryptosignschnorrTable, i : Int, v : Double) -> CryptosignschnorrTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_table_sum(s : CryptosignschnorrTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_table_mean(s : CryptosignschnorrTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_table_scale(s : CryptosignschnorrTable, f : Double) -> CryptosignschnorrTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_table_add(a : CryptosignschnorrTable, b : CryptosignschnorrTable) -> CryptosignschnorrTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_table_copy(s : CryptosignschnorrTable) -> CryptosignschnorrTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_table_fill(s : CryptosignschnorrTable, v : Double) -> CryptosignschnorrTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_table_min(s : CryptosignschnorrTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_table_max(s : CryptosignschnorrTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_table_to_string(s : CryptosignschnorrTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_graphn_make(size : Int) -> CryptosignschnorrGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_graphn_len(s : CryptosignschnorrGraphN) -> Int { s.size }

pub fn crypto_sign_schnorr_graphn_get(s : CryptosignschnorrGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_graphn_set(s : CryptosignschnorrGraphN, i : Int, v : Double) -> CryptosignschnorrGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_graphn_sum(s : CryptosignschnorrGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_graphn_mean(s : CryptosignschnorrGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_graphn_scale(s : CryptosignschnorrGraphN, f : Double) -> CryptosignschnorrGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_graphn_add(a : CryptosignschnorrGraphN, b : CryptosignschnorrGraphN) -> CryptosignschnorrGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_graphn_copy(s : CryptosignschnorrGraphN) -> CryptosignschnorrGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_graphn_fill(s : CryptosignschnorrGraphN, v : Double) -> CryptosignschnorrGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_graphn_min(s : CryptosignschnorrGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_graphn_max(s : CryptosignschnorrGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_graphn_to_string(s : CryptosignschnorrGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_node_make(size : Int) -> CryptosignschnorrNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_node_len(s : CryptosignschnorrNode) -> Int { s.size }

pub fn crypto_sign_schnorr_node_get(s : CryptosignschnorrNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_node_set(s : CryptosignschnorrNode, i : Int, v : Double) -> CryptosignschnorrNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_node_sum(s : CryptosignschnorrNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_node_mean(s : CryptosignschnorrNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_node_scale(s : CryptosignschnorrNode, f : Double) -> CryptosignschnorrNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_node_add(a : CryptosignschnorrNode, b : CryptosignschnorrNode) -> CryptosignschnorrNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_node_copy(s : CryptosignschnorrNode) -> CryptosignschnorrNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_node_fill(s : CryptosignschnorrNode, v : Double) -> CryptosignschnorrNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_node_min(s : CryptosignschnorrNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_node_max(s : CryptosignschnorrNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_node_to_string(s : CryptosignschnorrNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_edge_make(size : Int) -> CryptosignschnorrEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_edge_len(s : CryptosignschnorrEdge) -> Int { s.size }

pub fn crypto_sign_schnorr_edge_get(s : CryptosignschnorrEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_edge_set(s : CryptosignschnorrEdge, i : Int, v : Double) -> CryptosignschnorrEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_edge_sum(s : CryptosignschnorrEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_edge_mean(s : CryptosignschnorrEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_edge_scale(s : CryptosignschnorrEdge, f : Double) -> CryptosignschnorrEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_edge_add(a : CryptosignschnorrEdge, b : CryptosignschnorrEdge) -> CryptosignschnorrEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_edge_copy(s : CryptosignschnorrEdge) -> CryptosignschnorrEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_edge_fill(s : CryptosignschnorrEdge, v : Double) -> CryptosignschnorrEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_edge_min(s : CryptosignschnorrEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_edge_max(s : CryptosignschnorrEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_edge_to_string(s : CryptosignschnorrEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_path_make(size : Int) -> CryptosignschnorrPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_path_len(s : CryptosignschnorrPath) -> Int { s.size }

pub fn crypto_sign_schnorr_path_get(s : CryptosignschnorrPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_path_set(s : CryptosignschnorrPath, i : Int, v : Double) -> CryptosignschnorrPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_path_sum(s : CryptosignschnorrPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_path_mean(s : CryptosignschnorrPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_path_scale(s : CryptosignschnorrPath, f : Double) -> CryptosignschnorrPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_path_add(a : CryptosignschnorrPath, b : CryptosignschnorrPath) -> CryptosignschnorrPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_path_copy(s : CryptosignschnorrPath) -> CryptosignschnorrPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_path_fill(s : CryptosignschnorrPath, v : Double) -> CryptosignschnorrPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_path_min(s : CryptosignschnorrPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_path_max(s : CryptosignschnorrPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_path_to_string(s : CryptosignschnorrPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_cluster_make(size : Int) -> CryptosignschnorrCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_cluster_len(s : CryptosignschnorrCluster) -> Int { s.size }

pub fn crypto_sign_schnorr_cluster_get(s : CryptosignschnorrCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_cluster_set(s : CryptosignschnorrCluster, i : Int, v : Double) -> CryptosignschnorrCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cluster_sum(s : CryptosignschnorrCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_cluster_mean(s : CryptosignschnorrCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_cluster_scale(s : CryptosignschnorrCluster, f : Double) -> CryptosignschnorrCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cluster_add(a : CryptosignschnorrCluster, b : CryptosignschnorrCluster) -> CryptosignschnorrCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_cluster_copy(s : CryptosignschnorrCluster) -> CryptosignschnorrCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cluster_fill(s : CryptosignschnorrCluster, v : Double) -> CryptosignschnorrCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cluster_min(s : CryptosignschnorrCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_cluster_max(s : CryptosignschnorrCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_cluster_to_string(s : CryptosignschnorrCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_model_make(size : Int) -> CryptosignschnorrModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_model_len(s : CryptosignschnorrModel) -> Int { s.size }

pub fn crypto_sign_schnorr_model_get(s : CryptosignschnorrModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_model_set(s : CryptosignschnorrModel, i : Int, v : Double) -> CryptosignschnorrModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_model_sum(s : CryptosignschnorrModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_model_mean(s : CryptosignschnorrModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_model_scale(s : CryptosignschnorrModel, f : Double) -> CryptosignschnorrModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_model_add(a : CryptosignschnorrModel, b : CryptosignschnorrModel) -> CryptosignschnorrModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_model_copy(s : CryptosignschnorrModel) -> CryptosignschnorrModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_model_fill(s : CryptosignschnorrModel, v : Double) -> CryptosignschnorrModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_model_min(s : CryptosignschnorrModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_model_max(s : CryptosignschnorrModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_model_to_string(s : CryptosignschnorrModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_layer_make(size : Int) -> CryptosignschnorrLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_layer_len(s : CryptosignschnorrLayer) -> Int { s.size }

pub fn crypto_sign_schnorr_layer_get(s : CryptosignschnorrLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_layer_set(s : CryptosignschnorrLayer, i : Int, v : Double) -> CryptosignschnorrLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_layer_sum(s : CryptosignschnorrLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_layer_mean(s : CryptosignschnorrLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_layer_scale(s : CryptosignschnorrLayer, f : Double) -> CryptosignschnorrLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_layer_add(a : CryptosignschnorrLayer, b : CryptosignschnorrLayer) -> CryptosignschnorrLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_layer_copy(s : CryptosignschnorrLayer) -> CryptosignschnorrLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_layer_fill(s : CryptosignschnorrLayer, v : Double) -> CryptosignschnorrLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_layer_min(s : CryptosignschnorrLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_layer_max(s : CryptosignschnorrLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_layer_to_string(s : CryptosignschnorrLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_buffer_make(size : Int) -> CryptosignschnorrBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_buffer_len(s : CryptosignschnorrBuffer) -> Int { s.size }

pub fn crypto_sign_schnorr_buffer_get(s : CryptosignschnorrBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_buffer_set(s : CryptosignschnorrBuffer, i : Int, v : Double) -> CryptosignschnorrBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_buffer_sum(s : CryptosignschnorrBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_buffer_mean(s : CryptosignschnorrBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_buffer_scale(s : CryptosignschnorrBuffer, f : Double) -> CryptosignschnorrBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_buffer_add(a : CryptosignschnorrBuffer, b : CryptosignschnorrBuffer) -> CryptosignschnorrBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_buffer_copy(s : CryptosignschnorrBuffer) -> CryptosignschnorrBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_buffer_fill(s : CryptosignschnorrBuffer, v : Double) -> CryptosignschnorrBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_buffer_min(s : CryptosignschnorrBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_buffer_max(s : CryptosignschnorrBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_buffer_to_string(s : CryptosignschnorrBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_cursor_make(size : Int) -> CryptosignschnorrCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_cursor_len(s : CryptosignschnorrCursor) -> Int { s.size }

pub fn crypto_sign_schnorr_cursor_get(s : CryptosignschnorrCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_cursor_set(s : CryptosignschnorrCursor, i : Int, v : Double) -> CryptosignschnorrCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cursor_sum(s : CryptosignschnorrCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_cursor_mean(s : CryptosignschnorrCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_cursor_scale(s : CryptosignschnorrCursor, f : Double) -> CryptosignschnorrCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cursor_add(a : CryptosignschnorrCursor, b : CryptosignschnorrCursor) -> CryptosignschnorrCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_cursor_copy(s : CryptosignschnorrCursor) -> CryptosignschnorrCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cursor_fill(s : CryptosignschnorrCursor, v : Double) -> CryptosignschnorrCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_cursor_min(s : CryptosignschnorrCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_cursor_max(s : CryptosignschnorrCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_cursor_to_string(s : CryptosignschnorrCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_view_make(size : Int) -> CryptosignschnorrView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_view_len(s : CryptosignschnorrView) -> Int { s.size }

pub fn crypto_sign_schnorr_view_get(s : CryptosignschnorrView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_view_set(s : CryptosignschnorrView, i : Int, v : Double) -> CryptosignschnorrView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_view_sum(s : CryptosignschnorrView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_view_mean(s : CryptosignschnorrView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_view_scale(s : CryptosignschnorrView, f : Double) -> CryptosignschnorrView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_view_add(a : CryptosignschnorrView, b : CryptosignschnorrView) -> CryptosignschnorrView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_view_copy(s : CryptosignschnorrView) -> CryptosignschnorrView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_view_fill(s : CryptosignschnorrView, v : Double) -> CryptosignschnorrView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_view_min(s : CryptosignschnorrView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_view_max(s : CryptosignschnorrView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_view_to_string(s : CryptosignschnorrView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_range_make(size : Int) -> CryptosignschnorrRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_range_len(s : CryptosignschnorrRange) -> Int { s.size }

pub fn crypto_sign_schnorr_range_get(s : CryptosignschnorrRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_range_set(s : CryptosignschnorrRange, i : Int, v : Double) -> CryptosignschnorrRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_range_sum(s : CryptosignschnorrRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_range_mean(s : CryptosignschnorrRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_range_scale(s : CryptosignschnorrRange, f : Double) -> CryptosignschnorrRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_range_add(a : CryptosignschnorrRange, b : CryptosignschnorrRange) -> CryptosignschnorrRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_range_copy(s : CryptosignschnorrRange) -> CryptosignschnorrRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_range_fill(s : CryptosignschnorrRange, v : Double) -> CryptosignschnorrRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_range_min(s : CryptosignschnorrRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_range_max(s : CryptosignschnorrRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_range_to_string(s : CryptosignschnorrRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignschnorrSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_schnorr_slice_make(size : Int) -> CryptosignschnorrSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_schnorr_slice_len(s : CryptosignschnorrSlice) -> Int { s.size }

pub fn crypto_sign_schnorr_slice_get(s : CryptosignschnorrSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_schnorr_slice_set(s : CryptosignschnorrSlice, i : Int, v : Double) -> CryptosignschnorrSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_slice_sum(s : CryptosignschnorrSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_schnorr_slice_mean(s : CryptosignschnorrSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_schnorr_slice_scale(s : CryptosignschnorrSlice, f : Double) -> CryptosignschnorrSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_slice_add(a : CryptosignschnorrSlice, b : CryptosignschnorrSlice) -> CryptosignschnorrSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_schnorr_slice_copy(s : CryptosignschnorrSlice) -> CryptosignschnorrSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_slice_fill(s : CryptosignschnorrSlice, v : Double) -> CryptosignschnorrSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_schnorr_slice_min(s : CryptosignschnorrSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_schnorr_slice_max(s : CryptosignschnorrSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_schnorr_slice_to_string(s : CryptosignschnorrSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

