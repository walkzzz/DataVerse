///===
/// extcore/crypto_sym_aes

pub(all) struct CryptosymaesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_aes_make_point(x : Double, y : Double) -> CryptosymaesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_aes_make_point3(x : Double, y : Double, z : Double) -> CryptosymaesPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_aes_point_x(pt : CryptosymaesPoint) -> Double { pt.x }

pub fn crypto_sym_aes_point_y(pt : CryptosymaesPoint) -> Double { pt.y }

pub fn crypto_sym_aes_point_z(pt : CryptosymaesPoint) -> Double { pt.z }

pub fn crypto_sym_aes_point_label(pt : CryptosymaesPoint) -> Int { pt.label }

pub fn crypto_sym_aes_point_dist(a : CryptosymaesPoint, b : CryptosymaesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_aes_point_add(a : CryptosymaesPoint, b : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_aes_point_sub(a : CryptosymaesPoint, b : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_aes_point_scale(pt : CryptosymaesPoint, s : Double) -> CryptosymaesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_aes_point_dot(a : CryptosymaesPoint, b : CryptosymaesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_aes_point_cross(a : CryptosymaesPoint, b : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_aes_point_norm(pt : CryptosymaesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_aes_point_normalize(pt : CryptosymaesPoint) -> CryptosymaesPoint {
  let n = crypto_sym_aes_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_aes_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_aes_point_negate(pt : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_aes_point_mid(a : CryptosymaesPoint, b : CryptosymaesPoint) -> CryptosymaesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_aes_point_lerp(a : CryptosymaesPoint, b : CryptosymaesPoint, t : Double) -> CryptosymaesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_aes_point_to_string(pt : CryptosymaesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosymaesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_aes_make_series(vals : Array[Double], name : String) -> CryptosymaesSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_aes_series_len(s : CryptosymaesSeries) -> Int { s.vals.length() }

pub fn crypto_sym_aes_series_sum(s : CryptosymaesSeries) -> Double { @_common.sum(s.vals) }

pub fn crypto_sym_aes_series_mean(s : CryptosymaesSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sym_aes_series_min(s : CryptosymaesSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sym_aes_series_max(s : CryptosymaesSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sym_aes_series_range(s : CryptosymaesSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sym_aes_series_var(s : CryptosymaesSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sym_aes_series_std(s : CryptosymaesSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sym_aes_series_median(s : CryptosymaesSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sym_aes_series_scale(s : CryptosymaesSeries, f : Double) -> CryptosymaesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_aes_series_add(a : CryptosymaesSeries, b : CryptosymaesSeries) -> CryptosymaesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_aes_series_sub(a : CryptosymaesSeries, b : CryptosymaesSeries) -> CryptosymaesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_aes_series_normalize(s : CryptosymaesSeries) -> CryptosymaesSeries {
  let mn = crypto_sym_aes_series_min(s)
  let mx = crypto_sym_aes_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_aes_series_cumsum(s : CryptosymaesSeries) -> CryptosymaesSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_aes_series_to_string(s : CryptosymaesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymaesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_aes_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymaesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_aes_matrix_identity(n : Int) -> CryptosymaesMatrix {
  let m = crypto_sym_aes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_aes_matrix_get(m : CryptosymaesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_aes_matrix_transpose(m : CryptosymaesMatrix) -> CryptosymaesMatrix {
  let result = crypto_sym_aes_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_aes_matrix_add(a : CryptosymaesMatrix, b : CryptosymaesMatrix) -> CryptosymaesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_aes_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_aes_matrix_scale(m : CryptosymaesMatrix, s : Double) -> CryptosymaesMatrix {
  let result = crypto_sym_aes_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_aes_matrix_multiply(a : CryptosymaesMatrix, b : CryptosymaesMatrix) -> CryptosymaesMatrix {
  if a.cols != b.rows { return crypto_sym_aes_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_aes_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_aes_matrix_trace(m : CryptosymaesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_aes_matrix_det(m : CryptosymaesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_aes_matrix_norm(m : CryptosymaesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_aes_matrix_to_string(m : CryptosymaesMatrix) -> String {
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

pub(all) struct CryptosymaesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_aes_make_vector(comps : Array[Double]) -> CryptosymaesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_aes_vector_zero(dim : Int) -> CryptosymaesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_aes_vector_add(a : CryptosymaesVector, b : CryptosymaesVector) -> CryptosymaesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_aes_vector_sub(a : CryptosymaesVector, b : CryptosymaesVector) -> CryptosymaesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_aes_vector_scale(v : CryptosymaesVector, s : Double) -> CryptosymaesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_aes_vector_dot(a : CryptosymaesVector, b : CryptosymaesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_aes_vector_norm(v : CryptosymaesVector) -> Double { @_common.sqrt(crypto_sym_aes_vector_dot(v, v)) }

pub fn crypto_sym_aes_vector_normalize(v : CryptosymaesVector) -> CryptosymaesVector {
  let n = crypto_sym_aes_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_aes_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_aes_vector_dist(a : CryptosymaesVector, b : CryptosymaesVector) -> Double {
  crypto_sym_aes_vector_norm(crypto_sym_aes_vector_sub(a, b))
}

pub fn crypto_sym_aes_vector_to_string(v : CryptosymaesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_aes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_aes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_aes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_aes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_aes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_aes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_aes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_aes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_aes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_aes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_aes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_aes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_aes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_aes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_aes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_aes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_aes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_aes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_aes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_aes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_aes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_aes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_aes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_aes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_aes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_aes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_aes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_aes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_aes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymaesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_frame_make(size : Int) -> CryptosymaesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_frame_len(s : CryptosymaesFrame) -> Int { s.size }

pub fn crypto_sym_aes_frame_get(s : CryptosymaesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_frame_set(s : CryptosymaesFrame, i : Int, v : Double) -> CryptosymaesFrame {
  let result = crypto_sym_aes_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_frame_sum(s : CryptosymaesFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_frame_mean(s : CryptosymaesFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_frame_scale(s : CryptosymaesFrame, f : Double) -> CryptosymaesFrame {
  let result = crypto_sym_aes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_frame_add(a : CryptosymaesFrame, b : CryptosymaesFrame) -> CryptosymaesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_frame_copy(s : CryptosymaesFrame) -> CryptosymaesFrame {
  let result = crypto_sym_aes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_frame_fill(s : CryptosymaesFrame, v : Double) -> CryptosymaesFrame {
  let result = crypto_sym_aes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_frame_min(s : CryptosymaesFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_frame_max(s : CryptosymaesFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_frame_to_string(s : CryptosymaesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_table_make(size : Int) -> CryptosymaesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_table_len(s : CryptosymaesTable) -> Int { s.size }

pub fn crypto_sym_aes_table_get(s : CryptosymaesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_table_set(s : CryptosymaesTable, i : Int, v : Double) -> CryptosymaesTable {
  let result = crypto_sym_aes_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_table_sum(s : CryptosymaesTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_table_mean(s : CryptosymaesTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_table_scale(s : CryptosymaesTable, f : Double) -> CryptosymaesTable {
  let result = crypto_sym_aes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_table_add(a : CryptosymaesTable, b : CryptosymaesTable) -> CryptosymaesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_table_copy(s : CryptosymaesTable) -> CryptosymaesTable {
  let result = crypto_sym_aes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_table_fill(s : CryptosymaesTable, v : Double) -> CryptosymaesTable {
  let result = crypto_sym_aes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_table_min(s : CryptosymaesTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_table_max(s : CryptosymaesTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_table_to_string(s : CryptosymaesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_graphn_make(size : Int) -> CryptosymaesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_graphn_len(s : CryptosymaesGraphN) -> Int { s.size }

pub fn crypto_sym_aes_graphn_get(s : CryptosymaesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_graphn_set(s : CryptosymaesGraphN, i : Int, v : Double) -> CryptosymaesGraphN {
  let result = crypto_sym_aes_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_graphn_sum(s : CryptosymaesGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_graphn_mean(s : CryptosymaesGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_graphn_scale(s : CryptosymaesGraphN, f : Double) -> CryptosymaesGraphN {
  let result = crypto_sym_aes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_graphn_add(a : CryptosymaesGraphN, b : CryptosymaesGraphN) -> CryptosymaesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_graphn_copy(s : CryptosymaesGraphN) -> CryptosymaesGraphN {
  let result = crypto_sym_aes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_graphn_fill(s : CryptosymaesGraphN, v : Double) -> CryptosymaesGraphN {
  let result = crypto_sym_aes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_graphn_min(s : CryptosymaesGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_graphn_max(s : CryptosymaesGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_graphn_to_string(s : CryptosymaesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_node_make(size : Int) -> CryptosymaesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_node_len(s : CryptosymaesNode) -> Int { s.size }

pub fn crypto_sym_aes_node_get(s : CryptosymaesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_node_set(s : CryptosymaesNode, i : Int, v : Double) -> CryptosymaesNode {
  let result = crypto_sym_aes_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_node_sum(s : CryptosymaesNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_node_mean(s : CryptosymaesNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_node_scale(s : CryptosymaesNode, f : Double) -> CryptosymaesNode {
  let result = crypto_sym_aes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_node_add(a : CryptosymaesNode, b : CryptosymaesNode) -> CryptosymaesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_node_copy(s : CryptosymaesNode) -> CryptosymaesNode {
  let result = crypto_sym_aes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_node_fill(s : CryptosymaesNode, v : Double) -> CryptosymaesNode {
  let result = crypto_sym_aes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_node_min(s : CryptosymaesNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_node_max(s : CryptosymaesNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_node_to_string(s : CryptosymaesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_edge_make(size : Int) -> CryptosymaesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_edge_len(s : CryptosymaesEdge) -> Int { s.size }

pub fn crypto_sym_aes_edge_get(s : CryptosymaesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_edge_set(s : CryptosymaesEdge, i : Int, v : Double) -> CryptosymaesEdge {
  let result = crypto_sym_aes_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_edge_sum(s : CryptosymaesEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_edge_mean(s : CryptosymaesEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_edge_scale(s : CryptosymaesEdge, f : Double) -> CryptosymaesEdge {
  let result = crypto_sym_aes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_edge_add(a : CryptosymaesEdge, b : CryptosymaesEdge) -> CryptosymaesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_edge_copy(s : CryptosymaesEdge) -> CryptosymaesEdge {
  let result = crypto_sym_aes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_edge_fill(s : CryptosymaesEdge, v : Double) -> CryptosymaesEdge {
  let result = crypto_sym_aes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_edge_min(s : CryptosymaesEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_edge_max(s : CryptosymaesEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_edge_to_string(s : CryptosymaesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_path_make(size : Int) -> CryptosymaesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_path_len(s : CryptosymaesPath) -> Int { s.size }

pub fn crypto_sym_aes_path_get(s : CryptosymaesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_path_set(s : CryptosymaesPath, i : Int, v : Double) -> CryptosymaesPath {
  let result = crypto_sym_aes_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_path_sum(s : CryptosymaesPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_path_mean(s : CryptosymaesPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_path_scale(s : CryptosymaesPath, f : Double) -> CryptosymaesPath {
  let result = crypto_sym_aes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_path_add(a : CryptosymaesPath, b : CryptosymaesPath) -> CryptosymaesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_path_copy(s : CryptosymaesPath) -> CryptosymaesPath {
  let result = crypto_sym_aes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_path_fill(s : CryptosymaesPath, v : Double) -> CryptosymaesPath {
  let result = crypto_sym_aes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_path_min(s : CryptosymaesPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_path_max(s : CryptosymaesPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_path_to_string(s : CryptosymaesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_cluster_make(size : Int) -> CryptosymaesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_cluster_len(s : CryptosymaesCluster) -> Int { s.size }

pub fn crypto_sym_aes_cluster_get(s : CryptosymaesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_cluster_set(s : CryptosymaesCluster, i : Int, v : Double) -> CryptosymaesCluster {
  let result = crypto_sym_aes_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_cluster_sum(s : CryptosymaesCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_cluster_mean(s : CryptosymaesCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_cluster_scale(s : CryptosymaesCluster, f : Double) -> CryptosymaesCluster {
  let result = crypto_sym_aes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_cluster_add(a : CryptosymaesCluster, b : CryptosymaesCluster) -> CryptosymaesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_cluster_copy(s : CryptosymaesCluster) -> CryptosymaesCluster {
  let result = crypto_sym_aes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_cluster_fill(s : CryptosymaesCluster, v : Double) -> CryptosymaesCluster {
  let result = crypto_sym_aes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_cluster_min(s : CryptosymaesCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_cluster_max(s : CryptosymaesCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_cluster_to_string(s : CryptosymaesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_model_make(size : Int) -> CryptosymaesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_model_len(s : CryptosymaesModel) -> Int { s.size }

pub fn crypto_sym_aes_model_get(s : CryptosymaesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_model_set(s : CryptosymaesModel, i : Int, v : Double) -> CryptosymaesModel {
  let result = crypto_sym_aes_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_model_sum(s : CryptosymaesModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_model_mean(s : CryptosymaesModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_model_scale(s : CryptosymaesModel, f : Double) -> CryptosymaesModel {
  let result = crypto_sym_aes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_model_add(a : CryptosymaesModel, b : CryptosymaesModel) -> CryptosymaesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_model_copy(s : CryptosymaesModel) -> CryptosymaesModel {
  let result = crypto_sym_aes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_model_fill(s : CryptosymaesModel, v : Double) -> CryptosymaesModel {
  let result = crypto_sym_aes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_model_min(s : CryptosymaesModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_model_max(s : CryptosymaesModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_model_to_string(s : CryptosymaesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_layer_make(size : Int) -> CryptosymaesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_layer_len(s : CryptosymaesLayer) -> Int { s.size }

pub fn crypto_sym_aes_layer_get(s : CryptosymaesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_layer_set(s : CryptosymaesLayer, i : Int, v : Double) -> CryptosymaesLayer {
  let result = crypto_sym_aes_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_layer_sum(s : CryptosymaesLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_layer_mean(s : CryptosymaesLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_layer_scale(s : CryptosymaesLayer, f : Double) -> CryptosymaesLayer {
  let result = crypto_sym_aes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_layer_add(a : CryptosymaesLayer, b : CryptosymaesLayer) -> CryptosymaesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_layer_copy(s : CryptosymaesLayer) -> CryptosymaesLayer {
  let result = crypto_sym_aes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_layer_fill(s : CryptosymaesLayer, v : Double) -> CryptosymaesLayer {
  let result = crypto_sym_aes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_layer_min(s : CryptosymaesLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_layer_max(s : CryptosymaesLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_layer_to_string(s : CryptosymaesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_buffer_make(size : Int) -> CryptosymaesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_buffer_len(s : CryptosymaesBuffer) -> Int { s.size }

pub fn crypto_sym_aes_buffer_get(s : CryptosymaesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_buffer_set(s : CryptosymaesBuffer, i : Int, v : Double) -> CryptosymaesBuffer {
  let result = crypto_sym_aes_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_buffer_sum(s : CryptosymaesBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_buffer_mean(s : CryptosymaesBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_buffer_scale(s : CryptosymaesBuffer, f : Double) -> CryptosymaesBuffer {
  let result = crypto_sym_aes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_buffer_add(a : CryptosymaesBuffer, b : CryptosymaesBuffer) -> CryptosymaesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_buffer_copy(s : CryptosymaesBuffer) -> CryptosymaesBuffer {
  let result = crypto_sym_aes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_buffer_fill(s : CryptosymaesBuffer, v : Double) -> CryptosymaesBuffer {
  let result = crypto_sym_aes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_buffer_min(s : CryptosymaesBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_buffer_max(s : CryptosymaesBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_buffer_to_string(s : CryptosymaesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_cursor_make(size : Int) -> CryptosymaesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_cursor_len(s : CryptosymaesCursor) -> Int { s.size }

pub fn crypto_sym_aes_cursor_get(s : CryptosymaesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_cursor_set(s : CryptosymaesCursor, i : Int, v : Double) -> CryptosymaesCursor {
  let result = crypto_sym_aes_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_cursor_sum(s : CryptosymaesCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_cursor_mean(s : CryptosymaesCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_cursor_scale(s : CryptosymaesCursor, f : Double) -> CryptosymaesCursor {
  let result = crypto_sym_aes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_cursor_add(a : CryptosymaesCursor, b : CryptosymaesCursor) -> CryptosymaesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_cursor_copy(s : CryptosymaesCursor) -> CryptosymaesCursor {
  let result = crypto_sym_aes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_cursor_fill(s : CryptosymaesCursor, v : Double) -> CryptosymaesCursor {
  let result = crypto_sym_aes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_cursor_min(s : CryptosymaesCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_cursor_max(s : CryptosymaesCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_cursor_to_string(s : CryptosymaesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_view_make(size : Int) -> CryptosymaesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_view_len(s : CryptosymaesView) -> Int { s.size }

pub fn crypto_sym_aes_view_get(s : CryptosymaesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_view_set(s : CryptosymaesView, i : Int, v : Double) -> CryptosymaesView {
  let result = crypto_sym_aes_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_view_sum(s : CryptosymaesView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_view_mean(s : CryptosymaesView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_view_scale(s : CryptosymaesView, f : Double) -> CryptosymaesView {
  let result = crypto_sym_aes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_view_add(a : CryptosymaesView, b : CryptosymaesView) -> CryptosymaesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_view_copy(s : CryptosymaesView) -> CryptosymaesView {
  let result = crypto_sym_aes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_view_fill(s : CryptosymaesView, v : Double) -> CryptosymaesView {
  let result = crypto_sym_aes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_view_min(s : CryptosymaesView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_view_max(s : CryptosymaesView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_view_to_string(s : CryptosymaesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_range_make(size : Int) -> CryptosymaesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_range_len(s : CryptosymaesRange) -> Int { s.size }

pub fn crypto_sym_aes_range_get(s : CryptosymaesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_range_set(s : CryptosymaesRange, i : Int, v : Double) -> CryptosymaesRange {
  let result = crypto_sym_aes_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_range_sum(s : CryptosymaesRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_range_mean(s : CryptosymaesRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_range_scale(s : CryptosymaesRange, f : Double) -> CryptosymaesRange {
  let result = crypto_sym_aes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_range_add(a : CryptosymaesRange, b : CryptosymaesRange) -> CryptosymaesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_range_copy(s : CryptosymaesRange) -> CryptosymaesRange {
  let result = crypto_sym_aes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_range_fill(s : CryptosymaesRange, v : Double) -> CryptosymaesRange {
  let result = crypto_sym_aes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_range_min(s : CryptosymaesRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_range_max(s : CryptosymaesRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_range_to_string(s : CryptosymaesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymaesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_aes_slice_make(size : Int) -> CryptosymaesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_aes_slice_len(s : CryptosymaesSlice) -> Int { s.size }

pub fn crypto_sym_aes_slice_get(s : CryptosymaesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_aes_slice_set(s : CryptosymaesSlice, i : Int, v : Double) -> CryptosymaesSlice {
  let result = crypto_sym_aes_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_slice_sum(s : CryptosymaesSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_aes_slice_mean(s : CryptosymaesSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_aes_slice_scale(s : CryptosymaesSlice, f : Double) -> CryptosymaesSlice {
  let result = crypto_sym_aes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_aes_slice_add(a : CryptosymaesSlice, b : CryptosymaesSlice) -> CryptosymaesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_aes_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_aes_slice_copy(s : CryptosymaesSlice) -> CryptosymaesSlice {
  let result = crypto_sym_aes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_aes_slice_fill(s : CryptosymaesSlice, v : Double) -> CryptosymaesSlice {
  let result = crypto_sym_aes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_aes_slice_min(s : CryptosymaesSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_aes_slice_max(s : CryptosymaesSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_aes_slice_to_string(s : CryptosymaesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

