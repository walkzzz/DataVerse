///===
/// extcore/crypto_sign_rsa_pss

pub(all) struct CryptosignrsapssPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_rsa_pss_make_point(x : Double, y : Double) -> CryptosignrsapssPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_rsa_pss_make_point3(x : Double, y : Double, z : Double) -> CryptosignrsapssPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_rsa_pss_point_x(pt : CryptosignrsapssPoint) -> Double { pt.x }

pub fn crypto_sign_rsa_pss_point_y(pt : CryptosignrsapssPoint) -> Double { pt.y }

pub fn crypto_sign_rsa_pss_point_z(pt : CryptosignrsapssPoint) -> Double { pt.z }

pub fn crypto_sign_rsa_pss_point_label(pt : CryptosignrsapssPoint) -> Int { pt.label }

pub fn crypto_sign_rsa_pss_point_dist(a : CryptosignrsapssPoint, b : CryptosignrsapssPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_rsa_pss_point_add(a : CryptosignrsapssPoint, b : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_rsa_pss_point_sub(a : CryptosignrsapssPoint, b : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_rsa_pss_point_scale(pt : CryptosignrsapssPoint, s : Double) -> CryptosignrsapssPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_rsa_pss_point_dot(a : CryptosignrsapssPoint, b : CryptosignrsapssPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_rsa_pss_point_cross(a : CryptosignrsapssPoint, b : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_rsa_pss_point_norm(pt : CryptosignrsapssPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_rsa_pss_point_normalize(pt : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  let n = crypto_sign_rsa_pss_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_rsa_pss_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_rsa_pss_point_negate(pt : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_rsa_pss_point_mid(a : CryptosignrsapssPoint, b : CryptosignrsapssPoint) -> CryptosignrsapssPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_rsa_pss_point_lerp(a : CryptosignrsapssPoint, b : CryptosignrsapssPoint, t : Double) -> CryptosignrsapssPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_rsa_pss_point_to_string(pt : CryptosignrsapssPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosignrsapssSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_rsa_pss_make_series(vals : Array[Double], name : String) -> CryptosignrsapssSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_rsa_pss_series_len(s : CryptosignrsapssSeries) -> Int { s.vals.length() }

pub fn crypto_sign_rsa_pss_series_sum(s : CryptosignrsapssSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sign_rsa_pss_series_mean(s : CryptosignrsapssSeries) -> Double { @_common.mean(s.vals) }

pub fn crypto_sign_rsa_pss_series_min(s : CryptosignrsapssSeries) -> Double { @_common.min(s.vals) }

pub fn crypto_sign_rsa_pss_series_max(s : CryptosignrsapssSeries) -> Double { @_common.max(s.vals) }

pub fn crypto_sign_rsa_pss_series_range(s : CryptosignrsapssSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sign_rsa_pss_series_var(s : CryptosignrsapssSeries) -> Double { @_common.variance(s.vals) }

pub fn crypto_sign_rsa_pss_series_std(s : CryptosignrsapssSeries) -> Double { @_common.std(s.vals) }

pub fn crypto_sign_rsa_pss_series_median(s : CryptosignrsapssSeries) -> Double { @_common.median(s.vals) }

pub fn crypto_sign_rsa_pss_series_scale(s : CryptosignrsapssSeries, f : Double) -> CryptosignrsapssSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_rsa_pss_series_add(a : CryptosignrsapssSeries, b : CryptosignrsapssSeries) -> CryptosignrsapssSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_rsa_pss_series_sub(a : CryptosignrsapssSeries, b : CryptosignrsapssSeries) -> CryptosignrsapssSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_rsa_pss_series_normalize(s : CryptosignrsapssSeries) -> CryptosignrsapssSeries {
  let mn = crypto_sign_rsa_pss_series_min(s)
  let mx = crypto_sign_rsa_pss_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_rsa_pss_series_cumsum(s : CryptosignrsapssSeries) -> CryptosignrsapssSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_rsa_pss_series_to_string(s : CryptosignrsapssSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignrsapssMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_rsa_pss_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignrsapssMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_rsa_pss_matrix_identity(n : Int) -> CryptosignrsapssMatrix {
  let m = crypto_sign_rsa_pss_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_rsa_pss_matrix_get(m : CryptosignrsapssMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_rsa_pss_matrix_transpose(m : CryptosignrsapssMatrix) -> CryptosignrsapssMatrix {
  let result = crypto_sign_rsa_pss_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_rsa_pss_matrix_add(a : CryptosignrsapssMatrix, b : CryptosignrsapssMatrix) -> CryptosignrsapssMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_rsa_pss_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_rsa_pss_matrix_scale(m : CryptosignrsapssMatrix, s : Double) -> CryptosignrsapssMatrix {
  let result = crypto_sign_rsa_pss_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_rsa_pss_matrix_multiply(a : CryptosignrsapssMatrix, b : CryptosignrsapssMatrix) -> CryptosignrsapssMatrix {
  if a.cols != b.rows { return crypto_sign_rsa_pss_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_rsa_pss_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_rsa_pss_matrix_trace(m : CryptosignrsapssMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_rsa_pss_matrix_det(m : CryptosignrsapssMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_rsa_pss_matrix_norm(m : CryptosignrsapssMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sign_rsa_pss_matrix_to_string(m : CryptosignrsapssMatrix) -> String {
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

pub(all) struct CryptosignrsapssVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_rsa_pss_make_vector(comps : Array[Double]) -> CryptosignrsapssVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_rsa_pss_vector_zero(dim : Int) -> CryptosignrsapssVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_rsa_pss_vector_add(a : CryptosignrsapssVector, b : CryptosignrsapssVector) -> CryptosignrsapssVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_rsa_pss_vector_sub(a : CryptosignrsapssVector, b : CryptosignrsapssVector) -> CryptosignrsapssVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_rsa_pss_vector_scale(v : CryptosignrsapssVector, s : Double) -> CryptosignrsapssVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_rsa_pss_vector_dot(a : CryptosignrsapssVector, b : CryptosignrsapssVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_rsa_pss_vector_norm(v : CryptosignrsapssVector) -> Double { @_common.sqrt(crypto_sign_rsa_pss_vector_dot(v, v)) }

pub fn crypto_sign_rsa_pss_vector_normalize(v : CryptosignrsapssVector) -> CryptosignrsapssVector {
  let n = crypto_sign_rsa_pss_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_rsa_pss_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_rsa_pss_vector_dist(a : CryptosignrsapssVector, b : CryptosignrsapssVector) -> Double {
  crypto_sign_rsa_pss_vector_norm(crypto_sign_rsa_pss_vector_sub(a, b))
}

pub fn crypto_sign_rsa_pss_vector_to_string(v : CryptosignrsapssVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_rsa_pss_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_rsa_pss_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_rsa_pss_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_rsa_pss_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_rsa_pss_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_rsa_pss_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_rsa_pss_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_rsa_pss_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_rsa_pss_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_rsa_pss_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_rsa_pss_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_rsa_pss_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_rsa_pss_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_rsa_pss_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_rsa_pss_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_rsa_pss_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_rsa_pss_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_rsa_pss_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_rsa_pss_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_rsa_pss_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_rsa_pss_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_rsa_pss_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_rsa_pss_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_rsa_pss_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_rsa_pss_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_rsa_pss_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_rsa_pss_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_rsa_pss_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_rsa_pss_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignrsapssFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_frame_make(size : Int) -> CryptosignrsapssFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_frame_len(s : CryptosignrsapssFrame) -> Int { s.size }

pub fn crypto_sign_rsa_pss_frame_get(s : CryptosignrsapssFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_frame_set(s : CryptosignrsapssFrame, i : Int, v : Double) -> CryptosignrsapssFrame {
  let result = crypto_sign_rsa_pss_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_frame_sum(s : CryptosignrsapssFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_frame_mean(s : CryptosignrsapssFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_frame_scale(s : CryptosignrsapssFrame, f : Double) -> CryptosignrsapssFrame {
  let result = crypto_sign_rsa_pss_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_frame_add(a : CryptosignrsapssFrame, b : CryptosignrsapssFrame) -> CryptosignrsapssFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_frame_copy(s : CryptosignrsapssFrame) -> CryptosignrsapssFrame {
  let result = crypto_sign_rsa_pss_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_frame_fill(s : CryptosignrsapssFrame, v : Double) -> CryptosignrsapssFrame {
  let result = crypto_sign_rsa_pss_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_frame_min(s : CryptosignrsapssFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_frame_max(s : CryptosignrsapssFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_frame_to_string(s : CryptosignrsapssFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_table_make(size : Int) -> CryptosignrsapssTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_table_len(s : CryptosignrsapssTable) -> Int { s.size }

pub fn crypto_sign_rsa_pss_table_get(s : CryptosignrsapssTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_table_set(s : CryptosignrsapssTable, i : Int, v : Double) -> CryptosignrsapssTable {
  let result = crypto_sign_rsa_pss_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_table_sum(s : CryptosignrsapssTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_table_mean(s : CryptosignrsapssTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_table_scale(s : CryptosignrsapssTable, f : Double) -> CryptosignrsapssTable {
  let result = crypto_sign_rsa_pss_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_table_add(a : CryptosignrsapssTable, b : CryptosignrsapssTable) -> CryptosignrsapssTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_table_copy(s : CryptosignrsapssTable) -> CryptosignrsapssTable {
  let result = crypto_sign_rsa_pss_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_table_fill(s : CryptosignrsapssTable, v : Double) -> CryptosignrsapssTable {
  let result = crypto_sign_rsa_pss_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_table_min(s : CryptosignrsapssTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_table_max(s : CryptosignrsapssTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_table_to_string(s : CryptosignrsapssTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_graphn_make(size : Int) -> CryptosignrsapssGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_graphn_len(s : CryptosignrsapssGraphN) -> Int { s.size }

pub fn crypto_sign_rsa_pss_graphn_get(s : CryptosignrsapssGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_graphn_set(s : CryptosignrsapssGraphN, i : Int, v : Double) -> CryptosignrsapssGraphN {
  let result = crypto_sign_rsa_pss_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_graphn_sum(s : CryptosignrsapssGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_graphn_mean(s : CryptosignrsapssGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_graphn_scale(s : CryptosignrsapssGraphN, f : Double) -> CryptosignrsapssGraphN {
  let result = crypto_sign_rsa_pss_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_graphn_add(a : CryptosignrsapssGraphN, b : CryptosignrsapssGraphN) -> CryptosignrsapssGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_graphn_copy(s : CryptosignrsapssGraphN) -> CryptosignrsapssGraphN {
  let result = crypto_sign_rsa_pss_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_graphn_fill(s : CryptosignrsapssGraphN, v : Double) -> CryptosignrsapssGraphN {
  let result = crypto_sign_rsa_pss_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_graphn_min(s : CryptosignrsapssGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_graphn_max(s : CryptosignrsapssGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_graphn_to_string(s : CryptosignrsapssGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_node_make(size : Int) -> CryptosignrsapssNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_node_len(s : CryptosignrsapssNode) -> Int { s.size }

pub fn crypto_sign_rsa_pss_node_get(s : CryptosignrsapssNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_node_set(s : CryptosignrsapssNode, i : Int, v : Double) -> CryptosignrsapssNode {
  let result = crypto_sign_rsa_pss_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_node_sum(s : CryptosignrsapssNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_node_mean(s : CryptosignrsapssNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_node_scale(s : CryptosignrsapssNode, f : Double) -> CryptosignrsapssNode {
  let result = crypto_sign_rsa_pss_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_node_add(a : CryptosignrsapssNode, b : CryptosignrsapssNode) -> CryptosignrsapssNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_node_copy(s : CryptosignrsapssNode) -> CryptosignrsapssNode {
  let result = crypto_sign_rsa_pss_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_node_fill(s : CryptosignrsapssNode, v : Double) -> CryptosignrsapssNode {
  let result = crypto_sign_rsa_pss_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_node_min(s : CryptosignrsapssNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_node_max(s : CryptosignrsapssNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_node_to_string(s : CryptosignrsapssNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_edge_make(size : Int) -> CryptosignrsapssEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_edge_len(s : CryptosignrsapssEdge) -> Int { s.size }

pub fn crypto_sign_rsa_pss_edge_get(s : CryptosignrsapssEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_edge_set(s : CryptosignrsapssEdge, i : Int, v : Double) -> CryptosignrsapssEdge {
  let result = crypto_sign_rsa_pss_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_edge_sum(s : CryptosignrsapssEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_edge_mean(s : CryptosignrsapssEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_edge_scale(s : CryptosignrsapssEdge, f : Double) -> CryptosignrsapssEdge {
  let result = crypto_sign_rsa_pss_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_edge_add(a : CryptosignrsapssEdge, b : CryptosignrsapssEdge) -> CryptosignrsapssEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_edge_copy(s : CryptosignrsapssEdge) -> CryptosignrsapssEdge {
  let result = crypto_sign_rsa_pss_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_edge_fill(s : CryptosignrsapssEdge, v : Double) -> CryptosignrsapssEdge {
  let result = crypto_sign_rsa_pss_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_edge_min(s : CryptosignrsapssEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_edge_max(s : CryptosignrsapssEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_edge_to_string(s : CryptosignrsapssEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_path_make(size : Int) -> CryptosignrsapssPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_path_len(s : CryptosignrsapssPath) -> Int { s.size }

pub fn crypto_sign_rsa_pss_path_get(s : CryptosignrsapssPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_path_set(s : CryptosignrsapssPath, i : Int, v : Double) -> CryptosignrsapssPath {
  let result = crypto_sign_rsa_pss_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_path_sum(s : CryptosignrsapssPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_path_mean(s : CryptosignrsapssPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_path_scale(s : CryptosignrsapssPath, f : Double) -> CryptosignrsapssPath {
  let result = crypto_sign_rsa_pss_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_path_add(a : CryptosignrsapssPath, b : CryptosignrsapssPath) -> CryptosignrsapssPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_path_copy(s : CryptosignrsapssPath) -> CryptosignrsapssPath {
  let result = crypto_sign_rsa_pss_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_path_fill(s : CryptosignrsapssPath, v : Double) -> CryptosignrsapssPath {
  let result = crypto_sign_rsa_pss_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_path_min(s : CryptosignrsapssPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_path_max(s : CryptosignrsapssPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_path_to_string(s : CryptosignrsapssPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_cluster_make(size : Int) -> CryptosignrsapssCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_cluster_len(s : CryptosignrsapssCluster) -> Int { s.size }

pub fn crypto_sign_rsa_pss_cluster_get(s : CryptosignrsapssCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_cluster_set(s : CryptosignrsapssCluster, i : Int, v : Double) -> CryptosignrsapssCluster {
  let result = crypto_sign_rsa_pss_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_cluster_sum(s : CryptosignrsapssCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_cluster_mean(s : CryptosignrsapssCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_cluster_scale(s : CryptosignrsapssCluster, f : Double) -> CryptosignrsapssCluster {
  let result = crypto_sign_rsa_pss_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_cluster_add(a : CryptosignrsapssCluster, b : CryptosignrsapssCluster) -> CryptosignrsapssCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_cluster_copy(s : CryptosignrsapssCluster) -> CryptosignrsapssCluster {
  let result = crypto_sign_rsa_pss_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_cluster_fill(s : CryptosignrsapssCluster, v : Double) -> CryptosignrsapssCluster {
  let result = crypto_sign_rsa_pss_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_cluster_min(s : CryptosignrsapssCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_cluster_max(s : CryptosignrsapssCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_cluster_to_string(s : CryptosignrsapssCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_model_make(size : Int) -> CryptosignrsapssModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_model_len(s : CryptosignrsapssModel) -> Int { s.size }

pub fn crypto_sign_rsa_pss_model_get(s : CryptosignrsapssModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_model_set(s : CryptosignrsapssModel, i : Int, v : Double) -> CryptosignrsapssModel {
  let result = crypto_sign_rsa_pss_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_model_sum(s : CryptosignrsapssModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_model_mean(s : CryptosignrsapssModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_model_scale(s : CryptosignrsapssModel, f : Double) -> CryptosignrsapssModel {
  let result = crypto_sign_rsa_pss_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_model_add(a : CryptosignrsapssModel, b : CryptosignrsapssModel) -> CryptosignrsapssModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_model_copy(s : CryptosignrsapssModel) -> CryptosignrsapssModel {
  let result = crypto_sign_rsa_pss_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_model_fill(s : CryptosignrsapssModel, v : Double) -> CryptosignrsapssModel {
  let result = crypto_sign_rsa_pss_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_model_min(s : CryptosignrsapssModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_model_max(s : CryptosignrsapssModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_model_to_string(s : CryptosignrsapssModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_layer_make(size : Int) -> CryptosignrsapssLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_layer_len(s : CryptosignrsapssLayer) -> Int { s.size }

pub fn crypto_sign_rsa_pss_layer_get(s : CryptosignrsapssLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_layer_set(s : CryptosignrsapssLayer, i : Int, v : Double) -> CryptosignrsapssLayer {
  let result = crypto_sign_rsa_pss_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_layer_sum(s : CryptosignrsapssLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_layer_mean(s : CryptosignrsapssLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_layer_scale(s : CryptosignrsapssLayer, f : Double) -> CryptosignrsapssLayer {
  let result = crypto_sign_rsa_pss_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_layer_add(a : CryptosignrsapssLayer, b : CryptosignrsapssLayer) -> CryptosignrsapssLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_layer_copy(s : CryptosignrsapssLayer) -> CryptosignrsapssLayer {
  let result = crypto_sign_rsa_pss_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_layer_fill(s : CryptosignrsapssLayer, v : Double) -> CryptosignrsapssLayer {
  let result = crypto_sign_rsa_pss_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_layer_min(s : CryptosignrsapssLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_layer_max(s : CryptosignrsapssLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_layer_to_string(s : CryptosignrsapssLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_buffer_make(size : Int) -> CryptosignrsapssBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_buffer_len(s : CryptosignrsapssBuffer) -> Int { s.size }

pub fn crypto_sign_rsa_pss_buffer_get(s : CryptosignrsapssBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_buffer_set(s : CryptosignrsapssBuffer, i : Int, v : Double) -> CryptosignrsapssBuffer {
  let result = crypto_sign_rsa_pss_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_buffer_sum(s : CryptosignrsapssBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_buffer_mean(s : CryptosignrsapssBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_buffer_scale(s : CryptosignrsapssBuffer, f : Double) -> CryptosignrsapssBuffer {
  let result = crypto_sign_rsa_pss_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_buffer_add(a : CryptosignrsapssBuffer, b : CryptosignrsapssBuffer) -> CryptosignrsapssBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_buffer_copy(s : CryptosignrsapssBuffer) -> CryptosignrsapssBuffer {
  let result = crypto_sign_rsa_pss_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_buffer_fill(s : CryptosignrsapssBuffer, v : Double) -> CryptosignrsapssBuffer {
  let result = crypto_sign_rsa_pss_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_buffer_min(s : CryptosignrsapssBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_buffer_max(s : CryptosignrsapssBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_buffer_to_string(s : CryptosignrsapssBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_cursor_make(size : Int) -> CryptosignrsapssCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_cursor_len(s : CryptosignrsapssCursor) -> Int { s.size }

pub fn crypto_sign_rsa_pss_cursor_get(s : CryptosignrsapssCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_cursor_set(s : CryptosignrsapssCursor, i : Int, v : Double) -> CryptosignrsapssCursor {
  let result = crypto_sign_rsa_pss_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_cursor_sum(s : CryptosignrsapssCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_cursor_mean(s : CryptosignrsapssCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_cursor_scale(s : CryptosignrsapssCursor, f : Double) -> CryptosignrsapssCursor {
  let result = crypto_sign_rsa_pss_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_cursor_add(a : CryptosignrsapssCursor, b : CryptosignrsapssCursor) -> CryptosignrsapssCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_cursor_copy(s : CryptosignrsapssCursor) -> CryptosignrsapssCursor {
  let result = crypto_sign_rsa_pss_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_cursor_fill(s : CryptosignrsapssCursor, v : Double) -> CryptosignrsapssCursor {
  let result = crypto_sign_rsa_pss_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_cursor_min(s : CryptosignrsapssCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_cursor_max(s : CryptosignrsapssCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_cursor_to_string(s : CryptosignrsapssCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_view_make(size : Int) -> CryptosignrsapssView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_view_len(s : CryptosignrsapssView) -> Int { s.size }

pub fn crypto_sign_rsa_pss_view_get(s : CryptosignrsapssView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_view_set(s : CryptosignrsapssView, i : Int, v : Double) -> CryptosignrsapssView {
  let result = crypto_sign_rsa_pss_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_view_sum(s : CryptosignrsapssView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_view_mean(s : CryptosignrsapssView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_view_scale(s : CryptosignrsapssView, f : Double) -> CryptosignrsapssView {
  let result = crypto_sign_rsa_pss_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_view_add(a : CryptosignrsapssView, b : CryptosignrsapssView) -> CryptosignrsapssView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_view_copy(s : CryptosignrsapssView) -> CryptosignrsapssView {
  let result = crypto_sign_rsa_pss_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_view_fill(s : CryptosignrsapssView, v : Double) -> CryptosignrsapssView {
  let result = crypto_sign_rsa_pss_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_view_min(s : CryptosignrsapssView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_view_max(s : CryptosignrsapssView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_view_to_string(s : CryptosignrsapssView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_range_make(size : Int) -> CryptosignrsapssRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_range_len(s : CryptosignrsapssRange) -> Int { s.size }

pub fn crypto_sign_rsa_pss_range_get(s : CryptosignrsapssRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_range_set(s : CryptosignrsapssRange, i : Int, v : Double) -> CryptosignrsapssRange {
  let result = crypto_sign_rsa_pss_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_range_sum(s : CryptosignrsapssRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_range_mean(s : CryptosignrsapssRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_range_scale(s : CryptosignrsapssRange, f : Double) -> CryptosignrsapssRange {
  let result = crypto_sign_rsa_pss_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_range_add(a : CryptosignrsapssRange, b : CryptosignrsapssRange) -> CryptosignrsapssRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_range_copy(s : CryptosignrsapssRange) -> CryptosignrsapssRange {
  let result = crypto_sign_rsa_pss_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_range_fill(s : CryptosignrsapssRange, v : Double) -> CryptosignrsapssRange {
  let result = crypto_sign_rsa_pss_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_range_min(s : CryptosignrsapssRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_range_max(s : CryptosignrsapssRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_range_to_string(s : CryptosignrsapssRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignrsapssSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_rsa_pss_slice_make(size : Int) -> CryptosignrsapssSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_rsa_pss_slice_len(s : CryptosignrsapssSlice) -> Int { s.size }

pub fn crypto_sign_rsa_pss_slice_get(s : CryptosignrsapssSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_rsa_pss_slice_set(s : CryptosignrsapssSlice, i : Int, v : Double) -> CryptosignrsapssSlice {
  let result = crypto_sign_rsa_pss_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_slice_sum(s : CryptosignrsapssSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_rsa_pss_slice_mean(s : CryptosignrsapssSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_rsa_pss_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_rsa_pss_slice_scale(s : CryptosignrsapssSlice, f : Double) -> CryptosignrsapssSlice {
  let result = crypto_sign_rsa_pss_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_rsa_pss_slice_add(a : CryptosignrsapssSlice, b : CryptosignrsapssSlice) -> CryptosignrsapssSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_rsa_pss_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_slice_copy(s : CryptosignrsapssSlice) -> CryptosignrsapssSlice {
  let result = crypto_sign_rsa_pss_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_rsa_pss_slice_fill(s : CryptosignrsapssSlice, v : Double) -> CryptosignrsapssSlice {
  let result = crypto_sign_rsa_pss_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_rsa_pss_slice_min(s : CryptosignrsapssSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_slice_max(s : CryptosignrsapssSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_rsa_pss_slice_to_string(s : CryptosignrsapssSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

