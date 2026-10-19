///===
/// extcore/crypto_sign_ecdsa

pub(all) struct CryptosignecdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_ecdsa_make_point(x : Double, y : Double) -> CryptosignecdsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_ecdsa_make_point3(x : Double, y : Double, z : Double) -> CryptosignecdsaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_ecdsa_point_x(pt : CryptosignecdsaPoint) -> Double { pt.x }

pub fn crypto_sign_ecdsa_point_y(pt : CryptosignecdsaPoint) -> Double { pt.y }

pub fn crypto_sign_ecdsa_point_z(pt : CryptosignecdsaPoint) -> Double { pt.z }

pub fn crypto_sign_ecdsa_point_label(pt : CryptosignecdsaPoint) -> Int { pt.label }

pub fn crypto_sign_ecdsa_point_dist(a : CryptosignecdsaPoint, b : CryptosignecdsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_ecdsa_point_add(a : CryptosignecdsaPoint, b : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_ecdsa_point_sub(a : CryptosignecdsaPoint, b : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_ecdsa_point_scale(pt : CryptosignecdsaPoint, s : Double) -> CryptosignecdsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_ecdsa_point_dot(a : CryptosignecdsaPoint, b : CryptosignecdsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_ecdsa_point_cross(a : CryptosignecdsaPoint, b : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_ecdsa_point_norm(pt : CryptosignecdsaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_ecdsa_point_normalize(pt : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  let n = crypto_sign_ecdsa_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_ecdsa_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_ecdsa_point_negate(pt : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_ecdsa_point_mid(a : CryptosignecdsaPoint, b : CryptosignecdsaPoint) -> CryptosignecdsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_ecdsa_point_lerp(a : CryptosignecdsaPoint, b : CryptosignecdsaPoint, t : Double) -> CryptosignecdsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_ecdsa_point_to_string(pt : CryptosignecdsaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosignecdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_ecdsa_make_series(vals : Array[Double], name : String) -> CryptosignecdsaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_ecdsa_series_len(s : CryptosignecdsaSeries) -> Int { s.vals.length() }

pub fn crypto_sign_ecdsa_series_sum(s : CryptosignecdsaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sign_ecdsa_series_mean(s : CryptosignecdsaSeries) -> Double {
  let n = crypto_sign_ecdsa_series_len(s)
  if n == 0 { 0.0 } else { crypto_sign_ecdsa_series_sum(s) / n.to_double() }
}

pub fn crypto_sign_ecdsa_series_min(s : CryptosignecdsaSeries) -> Double {
  let n = crypto_sign_ecdsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_series_max(s : CryptosignecdsaSeries) -> Double {
  let n = crypto_sign_ecdsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_series_range(s : CryptosignecdsaSeries) -> Double {
  crypto_sign_ecdsa_series_max(s) - crypto_sign_ecdsa_series_min(s)
}

pub fn crypto_sign_ecdsa_series_var(s : CryptosignecdsaSeries) -> Double {
  let n = crypto_sign_ecdsa_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sign_ecdsa_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sign_ecdsa_series_std(s : CryptosignecdsaSeries) -> Double { @_common.sqrt(crypto_sign_ecdsa_series_var(s)) }

pub fn crypto_sign_ecdsa_series_median(s : CryptosignecdsaSeries) -> Double {
  let n = crypto_sign_ecdsa_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_ecdsa_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_ecdsa_series_scale(s : CryptosignecdsaSeries, f : Double) -> CryptosignecdsaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_ecdsa_series_add(a : CryptosignecdsaSeries, b : CryptosignecdsaSeries) -> CryptosignecdsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_ecdsa_series_sub(a : CryptosignecdsaSeries, b : CryptosignecdsaSeries) -> CryptosignecdsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_ecdsa_series_normalize(s : CryptosignecdsaSeries) -> CryptosignecdsaSeries {
  let mn = crypto_sign_ecdsa_series_min(s)
  let mx = crypto_sign_ecdsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_ecdsa_series_cumsum(s : CryptosignecdsaSeries) -> CryptosignecdsaSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_ecdsa_series_to_string(s : CryptosignecdsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignecdsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_ecdsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignecdsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_ecdsa_matrix_identity(n : Int) -> CryptosignecdsaMatrix {
  let m = crypto_sign_ecdsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_ecdsa_matrix_get(m : CryptosignecdsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_ecdsa_matrix_transpose(m : CryptosignecdsaMatrix) -> CryptosignecdsaMatrix {
  let result = crypto_sign_ecdsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_ecdsa_matrix_add(a : CryptosignecdsaMatrix, b : CryptosignecdsaMatrix) -> CryptosignecdsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_ecdsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_ecdsa_matrix_scale(m : CryptosignecdsaMatrix, s : Double) -> CryptosignecdsaMatrix {
  let result = crypto_sign_ecdsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_ecdsa_matrix_multiply(a : CryptosignecdsaMatrix, b : CryptosignecdsaMatrix) -> CryptosignecdsaMatrix {
  if a.cols != b.rows { return crypto_sign_ecdsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_ecdsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_ecdsa_matrix_trace(m : CryptosignecdsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_ecdsa_matrix_det(m : CryptosignecdsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_ecdsa_matrix_norm(m : CryptosignecdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sign_ecdsa_matrix_to_string(m : CryptosignecdsaMatrix) -> String {
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

pub(all) struct CryptosignecdsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_ecdsa_make_vector(comps : Array[Double]) -> CryptosignecdsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_ecdsa_vector_zero(dim : Int) -> CryptosignecdsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_ecdsa_vector_add(a : CryptosignecdsaVector, b : CryptosignecdsaVector) -> CryptosignecdsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_ecdsa_vector_sub(a : CryptosignecdsaVector, b : CryptosignecdsaVector) -> CryptosignecdsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_ecdsa_vector_scale(v : CryptosignecdsaVector, s : Double) -> CryptosignecdsaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_ecdsa_vector_dot(a : CryptosignecdsaVector, b : CryptosignecdsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_ecdsa_vector_norm(v : CryptosignecdsaVector) -> Double { @_common.sqrt(crypto_sign_ecdsa_vector_dot(v, v)) }

pub fn crypto_sign_ecdsa_vector_normalize(v : CryptosignecdsaVector) -> CryptosignecdsaVector {
  let n = crypto_sign_ecdsa_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_ecdsa_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_ecdsa_vector_dist(a : CryptosignecdsaVector, b : CryptosignecdsaVector) -> Double {
  crypto_sign_ecdsa_vector_norm(crypto_sign_ecdsa_vector_sub(a, b))
}

pub fn crypto_sign_ecdsa_vector_to_string(v : CryptosignecdsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_ecdsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_ecdsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_ecdsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_ecdsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_ecdsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_ecdsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_ecdsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_ecdsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_ecdsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_ecdsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_ecdsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_ecdsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_ecdsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_ecdsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_ecdsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_ecdsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_ecdsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_ecdsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_ecdsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_ecdsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_ecdsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_ecdsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_ecdsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_ecdsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_ecdsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_ecdsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_ecdsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_ecdsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_ecdsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignecdsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_frame_make(size : Int) -> CryptosignecdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_frame_len(s : CryptosignecdsaFrame) -> Int { s.size }

pub fn crypto_sign_ecdsa_frame_get(s : CryptosignecdsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_frame_set(s : CryptosignecdsaFrame, i : Int, v : Double) -> CryptosignecdsaFrame {
  let result = crypto_sign_ecdsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_frame_sum(s : CryptosignecdsaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_frame_mean(s : CryptosignecdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_frame_scale(s : CryptosignecdsaFrame, f : Double) -> CryptosignecdsaFrame {
  let result = crypto_sign_ecdsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_frame_add(a : CryptosignecdsaFrame, b : CryptosignecdsaFrame) -> CryptosignecdsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_frame_copy(s : CryptosignecdsaFrame) -> CryptosignecdsaFrame {
  let result = crypto_sign_ecdsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_frame_fill(s : CryptosignecdsaFrame, v : Double) -> CryptosignecdsaFrame {
  let result = crypto_sign_ecdsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_frame_min(s : CryptosignecdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_frame_max(s : CryptosignecdsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_frame_to_string(s : CryptosignecdsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_table_make(size : Int) -> CryptosignecdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_table_len(s : CryptosignecdsaTable) -> Int { s.size }

pub fn crypto_sign_ecdsa_table_get(s : CryptosignecdsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_table_set(s : CryptosignecdsaTable, i : Int, v : Double) -> CryptosignecdsaTable {
  let result = crypto_sign_ecdsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_table_sum(s : CryptosignecdsaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_table_mean(s : CryptosignecdsaTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_table_scale(s : CryptosignecdsaTable, f : Double) -> CryptosignecdsaTable {
  let result = crypto_sign_ecdsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_table_add(a : CryptosignecdsaTable, b : CryptosignecdsaTable) -> CryptosignecdsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_table_copy(s : CryptosignecdsaTable) -> CryptosignecdsaTable {
  let result = crypto_sign_ecdsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_table_fill(s : CryptosignecdsaTable, v : Double) -> CryptosignecdsaTable {
  let result = crypto_sign_ecdsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_table_min(s : CryptosignecdsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_table_max(s : CryptosignecdsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_table_to_string(s : CryptosignecdsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_graphn_make(size : Int) -> CryptosignecdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_graphn_len(s : CryptosignecdsaGraphN) -> Int { s.size }

pub fn crypto_sign_ecdsa_graphn_get(s : CryptosignecdsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_graphn_set(s : CryptosignecdsaGraphN, i : Int, v : Double) -> CryptosignecdsaGraphN {
  let result = crypto_sign_ecdsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_graphn_sum(s : CryptosignecdsaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_graphn_mean(s : CryptosignecdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_graphn_scale(s : CryptosignecdsaGraphN, f : Double) -> CryptosignecdsaGraphN {
  let result = crypto_sign_ecdsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_graphn_add(a : CryptosignecdsaGraphN, b : CryptosignecdsaGraphN) -> CryptosignecdsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_graphn_copy(s : CryptosignecdsaGraphN) -> CryptosignecdsaGraphN {
  let result = crypto_sign_ecdsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_graphn_fill(s : CryptosignecdsaGraphN, v : Double) -> CryptosignecdsaGraphN {
  let result = crypto_sign_ecdsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_graphn_min(s : CryptosignecdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_graphn_max(s : CryptosignecdsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_graphn_to_string(s : CryptosignecdsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_node_make(size : Int) -> CryptosignecdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_node_len(s : CryptosignecdsaNode) -> Int { s.size }

pub fn crypto_sign_ecdsa_node_get(s : CryptosignecdsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_node_set(s : CryptosignecdsaNode, i : Int, v : Double) -> CryptosignecdsaNode {
  let result = crypto_sign_ecdsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_node_sum(s : CryptosignecdsaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_node_mean(s : CryptosignecdsaNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_node_scale(s : CryptosignecdsaNode, f : Double) -> CryptosignecdsaNode {
  let result = crypto_sign_ecdsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_node_add(a : CryptosignecdsaNode, b : CryptosignecdsaNode) -> CryptosignecdsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_node_copy(s : CryptosignecdsaNode) -> CryptosignecdsaNode {
  let result = crypto_sign_ecdsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_node_fill(s : CryptosignecdsaNode, v : Double) -> CryptosignecdsaNode {
  let result = crypto_sign_ecdsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_node_min(s : CryptosignecdsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_node_max(s : CryptosignecdsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_node_to_string(s : CryptosignecdsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_edge_make(size : Int) -> CryptosignecdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_edge_len(s : CryptosignecdsaEdge) -> Int { s.size }

pub fn crypto_sign_ecdsa_edge_get(s : CryptosignecdsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_edge_set(s : CryptosignecdsaEdge, i : Int, v : Double) -> CryptosignecdsaEdge {
  let result = crypto_sign_ecdsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_edge_sum(s : CryptosignecdsaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_edge_mean(s : CryptosignecdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_edge_scale(s : CryptosignecdsaEdge, f : Double) -> CryptosignecdsaEdge {
  let result = crypto_sign_ecdsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_edge_add(a : CryptosignecdsaEdge, b : CryptosignecdsaEdge) -> CryptosignecdsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_edge_copy(s : CryptosignecdsaEdge) -> CryptosignecdsaEdge {
  let result = crypto_sign_ecdsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_edge_fill(s : CryptosignecdsaEdge, v : Double) -> CryptosignecdsaEdge {
  let result = crypto_sign_ecdsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_edge_min(s : CryptosignecdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_edge_max(s : CryptosignecdsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_edge_to_string(s : CryptosignecdsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_path_make(size : Int) -> CryptosignecdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_path_len(s : CryptosignecdsaPath) -> Int { s.size }

pub fn crypto_sign_ecdsa_path_get(s : CryptosignecdsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_path_set(s : CryptosignecdsaPath, i : Int, v : Double) -> CryptosignecdsaPath {
  let result = crypto_sign_ecdsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_path_sum(s : CryptosignecdsaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_path_mean(s : CryptosignecdsaPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_path_scale(s : CryptosignecdsaPath, f : Double) -> CryptosignecdsaPath {
  let result = crypto_sign_ecdsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_path_add(a : CryptosignecdsaPath, b : CryptosignecdsaPath) -> CryptosignecdsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_path_copy(s : CryptosignecdsaPath) -> CryptosignecdsaPath {
  let result = crypto_sign_ecdsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_path_fill(s : CryptosignecdsaPath, v : Double) -> CryptosignecdsaPath {
  let result = crypto_sign_ecdsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_path_min(s : CryptosignecdsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_path_max(s : CryptosignecdsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_path_to_string(s : CryptosignecdsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_cluster_make(size : Int) -> CryptosignecdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_cluster_len(s : CryptosignecdsaCluster) -> Int { s.size }

pub fn crypto_sign_ecdsa_cluster_get(s : CryptosignecdsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_cluster_set(s : CryptosignecdsaCluster, i : Int, v : Double) -> CryptosignecdsaCluster {
  let result = crypto_sign_ecdsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_cluster_sum(s : CryptosignecdsaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_cluster_mean(s : CryptosignecdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_cluster_scale(s : CryptosignecdsaCluster, f : Double) -> CryptosignecdsaCluster {
  let result = crypto_sign_ecdsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_cluster_add(a : CryptosignecdsaCluster, b : CryptosignecdsaCluster) -> CryptosignecdsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_cluster_copy(s : CryptosignecdsaCluster) -> CryptosignecdsaCluster {
  let result = crypto_sign_ecdsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_cluster_fill(s : CryptosignecdsaCluster, v : Double) -> CryptosignecdsaCluster {
  let result = crypto_sign_ecdsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_cluster_min(s : CryptosignecdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_cluster_max(s : CryptosignecdsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_cluster_to_string(s : CryptosignecdsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_model_make(size : Int) -> CryptosignecdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_model_len(s : CryptosignecdsaModel) -> Int { s.size }

pub fn crypto_sign_ecdsa_model_get(s : CryptosignecdsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_model_set(s : CryptosignecdsaModel, i : Int, v : Double) -> CryptosignecdsaModel {
  let result = crypto_sign_ecdsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_model_sum(s : CryptosignecdsaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_model_mean(s : CryptosignecdsaModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_model_scale(s : CryptosignecdsaModel, f : Double) -> CryptosignecdsaModel {
  let result = crypto_sign_ecdsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_model_add(a : CryptosignecdsaModel, b : CryptosignecdsaModel) -> CryptosignecdsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_model_copy(s : CryptosignecdsaModel) -> CryptosignecdsaModel {
  let result = crypto_sign_ecdsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_model_fill(s : CryptosignecdsaModel, v : Double) -> CryptosignecdsaModel {
  let result = crypto_sign_ecdsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_model_min(s : CryptosignecdsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_model_max(s : CryptosignecdsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_model_to_string(s : CryptosignecdsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_layer_make(size : Int) -> CryptosignecdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_layer_len(s : CryptosignecdsaLayer) -> Int { s.size }

pub fn crypto_sign_ecdsa_layer_get(s : CryptosignecdsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_layer_set(s : CryptosignecdsaLayer, i : Int, v : Double) -> CryptosignecdsaLayer {
  let result = crypto_sign_ecdsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_layer_sum(s : CryptosignecdsaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_layer_mean(s : CryptosignecdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_layer_scale(s : CryptosignecdsaLayer, f : Double) -> CryptosignecdsaLayer {
  let result = crypto_sign_ecdsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_layer_add(a : CryptosignecdsaLayer, b : CryptosignecdsaLayer) -> CryptosignecdsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_layer_copy(s : CryptosignecdsaLayer) -> CryptosignecdsaLayer {
  let result = crypto_sign_ecdsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_layer_fill(s : CryptosignecdsaLayer, v : Double) -> CryptosignecdsaLayer {
  let result = crypto_sign_ecdsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_layer_min(s : CryptosignecdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_layer_max(s : CryptosignecdsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_layer_to_string(s : CryptosignecdsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_buffer_make(size : Int) -> CryptosignecdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_buffer_len(s : CryptosignecdsaBuffer) -> Int { s.size }

pub fn crypto_sign_ecdsa_buffer_get(s : CryptosignecdsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_buffer_set(s : CryptosignecdsaBuffer, i : Int, v : Double) -> CryptosignecdsaBuffer {
  let result = crypto_sign_ecdsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_buffer_sum(s : CryptosignecdsaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_buffer_mean(s : CryptosignecdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_buffer_scale(s : CryptosignecdsaBuffer, f : Double) -> CryptosignecdsaBuffer {
  let result = crypto_sign_ecdsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_buffer_add(a : CryptosignecdsaBuffer, b : CryptosignecdsaBuffer) -> CryptosignecdsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_buffer_copy(s : CryptosignecdsaBuffer) -> CryptosignecdsaBuffer {
  let result = crypto_sign_ecdsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_buffer_fill(s : CryptosignecdsaBuffer, v : Double) -> CryptosignecdsaBuffer {
  let result = crypto_sign_ecdsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_buffer_min(s : CryptosignecdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_buffer_max(s : CryptosignecdsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_buffer_to_string(s : CryptosignecdsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_cursor_make(size : Int) -> CryptosignecdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_cursor_len(s : CryptosignecdsaCursor) -> Int { s.size }

pub fn crypto_sign_ecdsa_cursor_get(s : CryptosignecdsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_cursor_set(s : CryptosignecdsaCursor, i : Int, v : Double) -> CryptosignecdsaCursor {
  let result = crypto_sign_ecdsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_cursor_sum(s : CryptosignecdsaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_cursor_mean(s : CryptosignecdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_cursor_scale(s : CryptosignecdsaCursor, f : Double) -> CryptosignecdsaCursor {
  let result = crypto_sign_ecdsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_cursor_add(a : CryptosignecdsaCursor, b : CryptosignecdsaCursor) -> CryptosignecdsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_cursor_copy(s : CryptosignecdsaCursor) -> CryptosignecdsaCursor {
  let result = crypto_sign_ecdsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_cursor_fill(s : CryptosignecdsaCursor, v : Double) -> CryptosignecdsaCursor {
  let result = crypto_sign_ecdsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_cursor_min(s : CryptosignecdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_cursor_max(s : CryptosignecdsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_cursor_to_string(s : CryptosignecdsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_view_make(size : Int) -> CryptosignecdsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_view_len(s : CryptosignecdsaView) -> Int { s.size }

pub fn crypto_sign_ecdsa_view_get(s : CryptosignecdsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_view_set(s : CryptosignecdsaView, i : Int, v : Double) -> CryptosignecdsaView {
  let result = crypto_sign_ecdsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_view_sum(s : CryptosignecdsaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_view_mean(s : CryptosignecdsaView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_view_scale(s : CryptosignecdsaView, f : Double) -> CryptosignecdsaView {
  let result = crypto_sign_ecdsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_view_add(a : CryptosignecdsaView, b : CryptosignecdsaView) -> CryptosignecdsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_view_copy(s : CryptosignecdsaView) -> CryptosignecdsaView {
  let result = crypto_sign_ecdsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_view_fill(s : CryptosignecdsaView, v : Double) -> CryptosignecdsaView {
  let result = crypto_sign_ecdsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_view_min(s : CryptosignecdsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_view_max(s : CryptosignecdsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_view_to_string(s : CryptosignecdsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_range_make(size : Int) -> CryptosignecdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_range_len(s : CryptosignecdsaRange) -> Int { s.size }

pub fn crypto_sign_ecdsa_range_get(s : CryptosignecdsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_range_set(s : CryptosignecdsaRange, i : Int, v : Double) -> CryptosignecdsaRange {
  let result = crypto_sign_ecdsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_range_sum(s : CryptosignecdsaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_range_mean(s : CryptosignecdsaRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_range_scale(s : CryptosignecdsaRange, f : Double) -> CryptosignecdsaRange {
  let result = crypto_sign_ecdsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_range_add(a : CryptosignecdsaRange, b : CryptosignecdsaRange) -> CryptosignecdsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_range_copy(s : CryptosignecdsaRange) -> CryptosignecdsaRange {
  let result = crypto_sign_ecdsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_range_fill(s : CryptosignecdsaRange, v : Double) -> CryptosignecdsaRange {
  let result = crypto_sign_ecdsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_range_min(s : CryptosignecdsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_range_max(s : CryptosignecdsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_range_to_string(s : CryptosignecdsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignecdsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_ecdsa_slice_make(size : Int) -> CryptosignecdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_ecdsa_slice_len(s : CryptosignecdsaSlice) -> Int { s.size }

pub fn crypto_sign_ecdsa_slice_get(s : CryptosignecdsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_ecdsa_slice_set(s : CryptosignecdsaSlice, i : Int, v : Double) -> CryptosignecdsaSlice {
  let result = crypto_sign_ecdsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_slice_sum(s : CryptosignecdsaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_ecdsa_slice_mean(s : CryptosignecdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_ecdsa_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_ecdsa_slice_scale(s : CryptosignecdsaSlice, f : Double) -> CryptosignecdsaSlice {
  let result = crypto_sign_ecdsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_ecdsa_slice_add(a : CryptosignecdsaSlice, b : CryptosignecdsaSlice) -> CryptosignecdsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_ecdsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_ecdsa_slice_copy(s : CryptosignecdsaSlice) -> CryptosignecdsaSlice {
  let result = crypto_sign_ecdsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_ecdsa_slice_fill(s : CryptosignecdsaSlice, v : Double) -> CryptosignecdsaSlice {
  let result = crypto_sign_ecdsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_ecdsa_slice_min(s : CryptosignecdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_slice_max(s : CryptosignecdsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_ecdsa_slice_to_string(s : CryptosignecdsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

