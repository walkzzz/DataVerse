///===
/// extcore/crypto_sign_bls

pub(all) struct CryptosignblsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_bls_make_point(x : Double, y : Double) -> CryptosignblsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_bls_make_point3(x : Double, y : Double, z : Double) -> CryptosignblsPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_bls_point_x(pt : CryptosignblsPoint) -> Double { pt.x }

pub fn crypto_sign_bls_point_y(pt : CryptosignblsPoint) -> Double { pt.y }

pub fn crypto_sign_bls_point_z(pt : CryptosignblsPoint) -> Double { pt.z }

pub fn crypto_sign_bls_point_label(pt : CryptosignblsPoint) -> Int { pt.label }

pub fn crypto_sign_bls_point_dist(a : CryptosignblsPoint, b : CryptosignblsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_bls_point_add(a : CryptosignblsPoint, b : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_bls_point_sub(a : CryptosignblsPoint, b : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_bls_point_scale(pt : CryptosignblsPoint, s : Double) -> CryptosignblsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_bls_point_dot(a : CryptosignblsPoint, b : CryptosignblsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_bls_point_cross(a : CryptosignblsPoint, b : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_bls_point_norm(pt : CryptosignblsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_bls_point_normalize(pt : CryptosignblsPoint) -> CryptosignblsPoint {
  let n = crypto_sign_bls_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_bls_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_bls_point_negate(pt : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_bls_point_mid(a : CryptosignblsPoint, b : CryptosignblsPoint) -> CryptosignblsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_bls_point_lerp(a : CryptosignblsPoint, b : CryptosignblsPoint, t : Double) -> CryptosignblsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_bls_point_to_string(pt : CryptosignblsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosignblsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_bls_make_series(vals : Array[Double], name : String) -> CryptosignblsSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_bls_series_len(s : CryptosignblsSeries) -> Int { s.vals.length() }

pub fn crypto_sign_bls_series_sum(s : CryptosignblsSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sign_bls_series_mean(s : CryptosignblsSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sign_bls_series_min(s : CryptosignblsSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sign_bls_series_max(s : CryptosignblsSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sign_bls_series_range(s : CryptosignblsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sign_bls_series_var(s : CryptosignblsSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sign_bls_series_std(s : CryptosignblsSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sign_bls_series_median(s : CryptosignblsSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sign_bls_series_scale(s : CryptosignblsSeries, f : Double) -> CryptosignblsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_bls_series_add(a : CryptosignblsSeries, b : CryptosignblsSeries) -> CryptosignblsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_bls_series_sub(a : CryptosignblsSeries, b : CryptosignblsSeries) -> CryptosignblsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_bls_series_normalize(s : CryptosignblsSeries) -> CryptosignblsSeries {
  let mn = crypto_sign_bls_series_min(s)
  let mx = crypto_sign_bls_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_bls_series_cumsum(s : CryptosignblsSeries) -> CryptosignblsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_bls_series_to_string(s : CryptosignblsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignblsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_bls_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignblsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_bls_matrix_identity(n : Int) -> CryptosignblsMatrix {
  let m = crypto_sign_bls_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_bls_matrix_get(m : CryptosignblsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_bls_matrix_transpose(m : CryptosignblsMatrix) -> CryptosignblsMatrix {
  let result = crypto_sign_bls_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_bls_matrix_add(a : CryptosignblsMatrix, b : CryptosignblsMatrix) -> CryptosignblsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_bls_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_bls_matrix_scale(m : CryptosignblsMatrix, s : Double) -> CryptosignblsMatrix {
  let result = crypto_sign_bls_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_bls_matrix_multiply(a : CryptosignblsMatrix, b : CryptosignblsMatrix) -> CryptosignblsMatrix {
  if a.cols != b.rows { return crypto_sign_bls_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_bls_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_bls_matrix_trace(m : CryptosignblsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_bls_matrix_det(m : CryptosignblsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_bls_matrix_norm(m : CryptosignblsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sign_bls_matrix_to_string(m : CryptosignblsMatrix) -> String {
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

pub(all) struct CryptosignblsVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_bls_make_vector(comps : Array[Double]) -> CryptosignblsVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_bls_vector_zero(dim : Int) -> CryptosignblsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_bls_vector_add(a : CryptosignblsVector, b : CryptosignblsVector) -> CryptosignblsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_bls_vector_sub(a : CryptosignblsVector, b : CryptosignblsVector) -> CryptosignblsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_bls_vector_scale(v : CryptosignblsVector, s : Double) -> CryptosignblsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_bls_vector_dot(a : CryptosignblsVector, b : CryptosignblsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_bls_vector_norm(v : CryptosignblsVector) -> Double { @_common.sqrt(crypto_sign_bls_vector_dot(v, v)) }

pub fn crypto_sign_bls_vector_normalize(v : CryptosignblsVector) -> CryptosignblsVector {
  let n = crypto_sign_bls_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_bls_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_bls_vector_dist(a : CryptosignblsVector, b : CryptosignblsVector) -> Double {
  crypto_sign_bls_vector_norm(crypto_sign_bls_vector_sub(a, b))
}

pub fn crypto_sign_bls_vector_to_string(v : CryptosignblsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_bls_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_bls_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_bls_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_bls_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_bls_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_bls_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_bls_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_bls_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_bls_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_bls_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_bls_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_bls_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_bls_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_bls_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_bls_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_bls_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_bls_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_bls_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_bls_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_bls_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_bls_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_bls_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_bls_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_bls_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_bls_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_bls_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_bls_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_bls_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_bls_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignblsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_frame_make(size : Int) -> CryptosignblsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_frame_len(s : CryptosignblsFrame) -> Int { s.size }

pub fn crypto_sign_bls_frame_get(s : CryptosignblsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_frame_set(s : CryptosignblsFrame, i : Int, v : Double) -> CryptosignblsFrame {
  let result = crypto_sign_bls_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_frame_sum(s : CryptosignblsFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_frame_mean(s : CryptosignblsFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_frame_scale(s : CryptosignblsFrame, f : Double) -> CryptosignblsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_frame_add(a : CryptosignblsFrame, b : CryptosignblsFrame) -> CryptosignblsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_frame_copy(s : CryptosignblsFrame) -> CryptosignblsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_frame_fill(s : CryptosignblsFrame, v : Double) -> CryptosignblsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_frame_min(s : CryptosignblsFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_frame_max(s : CryptosignblsFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_frame_to_string(s : CryptosignblsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_table_make(size : Int) -> CryptosignblsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_table_len(s : CryptosignblsTable) -> Int { s.size }

pub fn crypto_sign_bls_table_get(s : CryptosignblsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_table_set(s : CryptosignblsTable, i : Int, v : Double) -> CryptosignblsTable {
  let result = crypto_sign_bls_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_table_sum(s : CryptosignblsTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_table_mean(s : CryptosignblsTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_table_scale(s : CryptosignblsTable, f : Double) -> CryptosignblsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_table_add(a : CryptosignblsTable, b : CryptosignblsTable) -> CryptosignblsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_table_copy(s : CryptosignblsTable) -> CryptosignblsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_table_fill(s : CryptosignblsTable, v : Double) -> CryptosignblsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_table_min(s : CryptosignblsTable) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_table_max(s : CryptosignblsTable) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_table_to_string(s : CryptosignblsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_graphn_make(size : Int) -> CryptosignblsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_graphn_len(s : CryptosignblsGraphN) -> Int { s.size }

pub fn crypto_sign_bls_graphn_get(s : CryptosignblsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_graphn_set(s : CryptosignblsGraphN, i : Int, v : Double) -> CryptosignblsGraphN {
  let result = crypto_sign_bls_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_graphn_sum(s : CryptosignblsGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_graphn_mean(s : CryptosignblsGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_graphn_scale(s : CryptosignblsGraphN, f : Double) -> CryptosignblsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_graphn_add(a : CryptosignblsGraphN, b : CryptosignblsGraphN) -> CryptosignblsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_graphn_copy(s : CryptosignblsGraphN) -> CryptosignblsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_graphn_fill(s : CryptosignblsGraphN, v : Double) -> CryptosignblsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_graphn_min(s : CryptosignblsGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_graphn_max(s : CryptosignblsGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_graphn_to_string(s : CryptosignblsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_node_make(size : Int) -> CryptosignblsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_node_len(s : CryptosignblsNode) -> Int { s.size }

pub fn crypto_sign_bls_node_get(s : CryptosignblsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_node_set(s : CryptosignblsNode, i : Int, v : Double) -> CryptosignblsNode {
  let result = crypto_sign_bls_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_node_sum(s : CryptosignblsNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_node_mean(s : CryptosignblsNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_node_scale(s : CryptosignblsNode, f : Double) -> CryptosignblsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_node_add(a : CryptosignblsNode, b : CryptosignblsNode) -> CryptosignblsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_node_copy(s : CryptosignblsNode) -> CryptosignblsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_node_fill(s : CryptosignblsNode, v : Double) -> CryptosignblsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_node_min(s : CryptosignblsNode) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_node_max(s : CryptosignblsNode) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_node_to_string(s : CryptosignblsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_edge_make(size : Int) -> CryptosignblsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_edge_len(s : CryptosignblsEdge) -> Int { s.size }

pub fn crypto_sign_bls_edge_get(s : CryptosignblsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_edge_set(s : CryptosignblsEdge, i : Int, v : Double) -> CryptosignblsEdge {
  let result = crypto_sign_bls_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_edge_sum(s : CryptosignblsEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_edge_mean(s : CryptosignblsEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_edge_scale(s : CryptosignblsEdge, f : Double) -> CryptosignblsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_edge_add(a : CryptosignblsEdge, b : CryptosignblsEdge) -> CryptosignblsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_edge_copy(s : CryptosignblsEdge) -> CryptosignblsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_edge_fill(s : CryptosignblsEdge, v : Double) -> CryptosignblsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_edge_min(s : CryptosignblsEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_edge_max(s : CryptosignblsEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_edge_to_string(s : CryptosignblsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_path_make(size : Int) -> CryptosignblsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_path_len(s : CryptosignblsPath) -> Int { s.size }

pub fn crypto_sign_bls_path_get(s : CryptosignblsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_path_set(s : CryptosignblsPath, i : Int, v : Double) -> CryptosignblsPath {
  let result = crypto_sign_bls_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_path_sum(s : CryptosignblsPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_path_mean(s : CryptosignblsPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_path_scale(s : CryptosignblsPath, f : Double) -> CryptosignblsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_path_add(a : CryptosignblsPath, b : CryptosignblsPath) -> CryptosignblsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_path_copy(s : CryptosignblsPath) -> CryptosignblsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_path_fill(s : CryptosignblsPath, v : Double) -> CryptosignblsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_path_min(s : CryptosignblsPath) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_path_max(s : CryptosignblsPath) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_path_to_string(s : CryptosignblsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_cluster_make(size : Int) -> CryptosignblsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_cluster_len(s : CryptosignblsCluster) -> Int { s.size }

pub fn crypto_sign_bls_cluster_get(s : CryptosignblsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_cluster_set(s : CryptosignblsCluster, i : Int, v : Double) -> CryptosignblsCluster {
  let result = crypto_sign_bls_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_cluster_sum(s : CryptosignblsCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_cluster_mean(s : CryptosignblsCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_cluster_scale(s : CryptosignblsCluster, f : Double) -> CryptosignblsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cluster_add(a : CryptosignblsCluster, b : CryptosignblsCluster) -> CryptosignblsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_cluster_copy(s : CryptosignblsCluster) -> CryptosignblsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cluster_fill(s : CryptosignblsCluster, v : Double) -> CryptosignblsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cluster_min(s : CryptosignblsCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_cluster_max(s : CryptosignblsCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_cluster_to_string(s : CryptosignblsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_model_make(size : Int) -> CryptosignblsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_model_len(s : CryptosignblsModel) -> Int { s.size }

pub fn crypto_sign_bls_model_get(s : CryptosignblsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_model_set(s : CryptosignblsModel, i : Int, v : Double) -> CryptosignblsModel {
  let result = crypto_sign_bls_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_model_sum(s : CryptosignblsModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_model_mean(s : CryptosignblsModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_model_scale(s : CryptosignblsModel, f : Double) -> CryptosignblsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_model_add(a : CryptosignblsModel, b : CryptosignblsModel) -> CryptosignblsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_model_copy(s : CryptosignblsModel) -> CryptosignblsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_model_fill(s : CryptosignblsModel, v : Double) -> CryptosignblsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_model_min(s : CryptosignblsModel) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_model_max(s : CryptosignblsModel) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_model_to_string(s : CryptosignblsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_layer_make(size : Int) -> CryptosignblsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_layer_len(s : CryptosignblsLayer) -> Int { s.size }

pub fn crypto_sign_bls_layer_get(s : CryptosignblsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_layer_set(s : CryptosignblsLayer, i : Int, v : Double) -> CryptosignblsLayer {
  let result = crypto_sign_bls_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_layer_sum(s : CryptosignblsLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_layer_mean(s : CryptosignblsLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_layer_scale(s : CryptosignblsLayer, f : Double) -> CryptosignblsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_layer_add(a : CryptosignblsLayer, b : CryptosignblsLayer) -> CryptosignblsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_layer_copy(s : CryptosignblsLayer) -> CryptosignblsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_layer_fill(s : CryptosignblsLayer, v : Double) -> CryptosignblsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_layer_min(s : CryptosignblsLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_layer_max(s : CryptosignblsLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_layer_to_string(s : CryptosignblsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_buffer_make(size : Int) -> CryptosignblsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_buffer_len(s : CryptosignblsBuffer) -> Int { s.size }

pub fn crypto_sign_bls_buffer_get(s : CryptosignblsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_buffer_set(s : CryptosignblsBuffer, i : Int, v : Double) -> CryptosignblsBuffer {
  let result = crypto_sign_bls_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_buffer_sum(s : CryptosignblsBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_buffer_mean(s : CryptosignblsBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_buffer_scale(s : CryptosignblsBuffer, f : Double) -> CryptosignblsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_buffer_add(a : CryptosignblsBuffer, b : CryptosignblsBuffer) -> CryptosignblsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_buffer_copy(s : CryptosignblsBuffer) -> CryptosignblsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_buffer_fill(s : CryptosignblsBuffer, v : Double) -> CryptosignblsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_buffer_min(s : CryptosignblsBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_buffer_max(s : CryptosignblsBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_buffer_to_string(s : CryptosignblsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_cursor_make(size : Int) -> CryptosignblsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_cursor_len(s : CryptosignblsCursor) -> Int { s.size }

pub fn crypto_sign_bls_cursor_get(s : CryptosignblsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_cursor_set(s : CryptosignblsCursor, i : Int, v : Double) -> CryptosignblsCursor {
  let result = crypto_sign_bls_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_cursor_sum(s : CryptosignblsCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_cursor_mean(s : CryptosignblsCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_cursor_scale(s : CryptosignblsCursor, f : Double) -> CryptosignblsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cursor_add(a : CryptosignblsCursor, b : CryptosignblsCursor) -> CryptosignblsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_cursor_copy(s : CryptosignblsCursor) -> CryptosignblsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cursor_fill(s : CryptosignblsCursor, v : Double) -> CryptosignblsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_cursor_min(s : CryptosignblsCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_cursor_max(s : CryptosignblsCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_cursor_to_string(s : CryptosignblsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_view_make(size : Int) -> CryptosignblsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_view_len(s : CryptosignblsView) -> Int { s.size }

pub fn crypto_sign_bls_view_get(s : CryptosignblsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_view_set(s : CryptosignblsView, i : Int, v : Double) -> CryptosignblsView {
  let result = crypto_sign_bls_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_view_sum(s : CryptosignblsView) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_view_mean(s : CryptosignblsView) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_view_scale(s : CryptosignblsView, f : Double) -> CryptosignblsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_view_add(a : CryptosignblsView, b : CryptosignblsView) -> CryptosignblsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_view_copy(s : CryptosignblsView) -> CryptosignblsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_view_fill(s : CryptosignblsView, v : Double) -> CryptosignblsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_view_min(s : CryptosignblsView) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_view_max(s : CryptosignblsView) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_view_to_string(s : CryptosignblsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_range_make(size : Int) -> CryptosignblsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_range_len(s : CryptosignblsRange) -> Int { s.size }

pub fn crypto_sign_bls_range_get(s : CryptosignblsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_range_set(s : CryptosignblsRange, i : Int, v : Double) -> CryptosignblsRange {
  let result = crypto_sign_bls_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_range_sum(s : CryptosignblsRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_range_mean(s : CryptosignblsRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_range_scale(s : CryptosignblsRange, f : Double) -> CryptosignblsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_range_add(a : CryptosignblsRange, b : CryptosignblsRange) -> CryptosignblsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_range_copy(s : CryptosignblsRange) -> CryptosignblsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_range_fill(s : CryptosignblsRange, v : Double) -> CryptosignblsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_range_min(s : CryptosignblsRange) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_range_max(s : CryptosignblsRange) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_range_to_string(s : CryptosignblsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignblsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_bls_slice_make(size : Int) -> CryptosignblsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_bls_slice_len(s : CryptosignblsSlice) -> Int { s.size }

pub fn crypto_sign_bls_slice_get(s : CryptosignblsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_bls_slice_set(s : CryptosignblsSlice, i : Int, v : Double) -> CryptosignblsSlice {
  let result = crypto_sign_bls_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_bls_slice_sum(s : CryptosignblsSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sign_bls_slice_mean(s : CryptosignblsSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sign_bls_slice_scale(s : CryptosignblsSlice, f : Double) -> CryptosignblsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_slice_add(a : CryptosignblsSlice, b : CryptosignblsSlice) -> CryptosignblsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sign_bls_slice_copy(s : CryptosignblsSlice) -> CryptosignblsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_slice_fill(s : CryptosignblsSlice, v : Double) -> CryptosignblsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sign_bls_slice_min(s : CryptosignblsSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sign_bls_slice_max(s : CryptosignblsSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sign_bls_slice_to_string(s : CryptosignblsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

