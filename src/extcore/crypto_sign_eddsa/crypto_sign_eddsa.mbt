///===
/// extcore/crypto_sign_eddsa

pub(all) struct CryptosigneddsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_eddsa_make_point(x : Double, y : Double) -> CryptosigneddsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_eddsa_make_point3(x : Double, y : Double, z : Double) -> CryptosigneddsaPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_eddsa_point_x(pt : CryptosigneddsaPoint) -> Double { pt.x }

pub fn crypto_sign_eddsa_point_y(pt : CryptosigneddsaPoint) -> Double { pt.y }

pub fn crypto_sign_eddsa_point_z(pt : CryptosigneddsaPoint) -> Double { pt.z }

pub fn crypto_sign_eddsa_point_label(pt : CryptosigneddsaPoint) -> Int { pt.label }

pub fn crypto_sign_eddsa_point_dist(a : CryptosigneddsaPoint, b : CryptosigneddsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_eddsa_point_add(a : CryptosigneddsaPoint, b : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_eddsa_point_sub(a : CryptosigneddsaPoint, b : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_eddsa_point_scale(pt : CryptosigneddsaPoint, s : Double) -> CryptosigneddsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_eddsa_point_dot(a : CryptosigneddsaPoint, b : CryptosigneddsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_eddsa_point_cross(a : CryptosigneddsaPoint, b : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_eddsa_point_norm(pt : CryptosigneddsaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_eddsa_point_normalize(pt : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  let n = crypto_sign_eddsa_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_eddsa_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_eddsa_point_negate(pt : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_eddsa_point_mid(a : CryptosigneddsaPoint, b : CryptosigneddsaPoint) -> CryptosigneddsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_eddsa_point_lerp(a : CryptosigneddsaPoint, b : CryptosigneddsaPoint, t : Double) -> CryptosigneddsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_eddsa_point_to_string(pt : CryptosigneddsaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosigneddsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_eddsa_make_series(vals : Array[Double], name : String) -> CryptosigneddsaSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_eddsa_series_len(s : CryptosigneddsaSeries) -> Int { s.vals.length() }

pub fn crypto_sign_eddsa_series_sum(s : CryptosigneddsaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sign_eddsa_series_mean(s : CryptosigneddsaSeries) -> Double {
  let n = crypto_sign_eddsa_series_len(s)
  if n == 0 { 0.0 } else { crypto_sign_eddsa_series_sum(s) / n.to_double() }
}

pub fn crypto_sign_eddsa_series_min(s : CryptosigneddsaSeries) -> Double {
  let n = crypto_sign_eddsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_series_max(s : CryptosigneddsaSeries) -> Double {
  let n = crypto_sign_eddsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_series_range(s : CryptosigneddsaSeries) -> Double {
  crypto_sign_eddsa_series_max(s) - crypto_sign_eddsa_series_min(s)
}

pub fn crypto_sign_eddsa_series_var(s : CryptosigneddsaSeries) -> Double {
  let n = crypto_sign_eddsa_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sign_eddsa_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sign_eddsa_series_std(s : CryptosigneddsaSeries) -> Double { @_common.sqrt(crypto_sign_eddsa_series_var(s)) }

pub fn crypto_sign_eddsa_series_median(s : CryptosigneddsaSeries) -> Double {
  let n = crypto_sign_eddsa_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_eddsa_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_eddsa_series_scale(s : CryptosigneddsaSeries, f : Double) -> CryptosigneddsaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_eddsa_series_add(a : CryptosigneddsaSeries, b : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_eddsa_series_sub(a : CryptosigneddsaSeries, b : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_eddsa_series_normalize(s : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  let mn = crypto_sign_eddsa_series_min(s)
  let mx = crypto_sign_eddsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_eddsa_series_cumsum(s : CryptosigneddsaSeries) -> CryptosigneddsaSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_eddsa_series_to_string(s : CryptosigneddsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosigneddsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_eddsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosigneddsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_eddsa_matrix_identity(n : Int) -> CryptosigneddsaMatrix {
  let m = crypto_sign_eddsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_eddsa_matrix_get(m : CryptosigneddsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_eddsa_matrix_transpose(m : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  let result = crypto_sign_eddsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_eddsa_matrix_add(a : CryptosigneddsaMatrix, b : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_eddsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_eddsa_matrix_scale(m : CryptosigneddsaMatrix, s : Double) -> CryptosigneddsaMatrix {
  let result = crypto_sign_eddsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_eddsa_matrix_multiply(a : CryptosigneddsaMatrix, b : CryptosigneddsaMatrix) -> CryptosigneddsaMatrix {
  if a.cols != b.rows { return crypto_sign_eddsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_eddsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_eddsa_matrix_trace(m : CryptosigneddsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_eddsa_matrix_det(m : CryptosigneddsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_eddsa_matrix_norm(m : CryptosigneddsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sign_eddsa_matrix_to_string(m : CryptosigneddsaMatrix) -> String {
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

pub(all) struct CryptosigneddsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_eddsa_make_vector(comps : Array[Double]) -> CryptosigneddsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_eddsa_vector_zero(dim : Int) -> CryptosigneddsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_eddsa_vector_add(a : CryptosigneddsaVector, b : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_eddsa_vector_sub(a : CryptosigneddsaVector, b : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_eddsa_vector_scale(v : CryptosigneddsaVector, s : Double) -> CryptosigneddsaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_eddsa_vector_dot(a : CryptosigneddsaVector, b : CryptosigneddsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_eddsa_vector_norm(v : CryptosigneddsaVector) -> Double { @_common.sqrt(crypto_sign_eddsa_vector_dot(v, v)) }

pub fn crypto_sign_eddsa_vector_normalize(v : CryptosigneddsaVector) -> CryptosigneddsaVector {
  let n = crypto_sign_eddsa_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_eddsa_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_eddsa_vector_dist(a : CryptosigneddsaVector, b : CryptosigneddsaVector) -> Double {
  crypto_sign_eddsa_vector_norm(crypto_sign_eddsa_vector_sub(a, b))
}

pub fn crypto_sign_eddsa_vector_to_string(v : CryptosigneddsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_eddsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_eddsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_eddsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_eddsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_eddsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_eddsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_eddsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_eddsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_eddsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_eddsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_eddsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_eddsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_eddsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_eddsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_eddsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_eddsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_eddsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_eddsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_eddsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_eddsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_eddsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_eddsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_eddsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_eddsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_eddsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_eddsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_eddsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_eddsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_eddsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosigneddsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_frame_make(size : Int) -> CryptosigneddsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_frame_len(s : CryptosigneddsaFrame) -> Int { s.size }

pub fn crypto_sign_eddsa_frame_get(s : CryptosigneddsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_frame_set(s : CryptosigneddsaFrame, i : Int, v : Double) -> CryptosigneddsaFrame {
  let result = crypto_sign_eddsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_frame_sum(s : CryptosigneddsaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_frame_mean(s : CryptosigneddsaFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_frame_scale(s : CryptosigneddsaFrame, f : Double) -> CryptosigneddsaFrame {
  let result = crypto_sign_eddsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_frame_add(a : CryptosigneddsaFrame, b : CryptosigneddsaFrame) -> CryptosigneddsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_frame_copy(s : CryptosigneddsaFrame) -> CryptosigneddsaFrame {
  let result = crypto_sign_eddsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_frame_fill(s : CryptosigneddsaFrame, v : Double) -> CryptosigneddsaFrame {
  let result = crypto_sign_eddsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_frame_min(s : CryptosigneddsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_frame_max(s : CryptosigneddsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_frame_to_string(s : CryptosigneddsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_table_make(size : Int) -> CryptosigneddsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_table_len(s : CryptosigneddsaTable) -> Int { s.size }

pub fn crypto_sign_eddsa_table_get(s : CryptosigneddsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_table_set(s : CryptosigneddsaTable, i : Int, v : Double) -> CryptosigneddsaTable {
  let result = crypto_sign_eddsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_table_sum(s : CryptosigneddsaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_table_mean(s : CryptosigneddsaTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_table_scale(s : CryptosigneddsaTable, f : Double) -> CryptosigneddsaTable {
  let result = crypto_sign_eddsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_table_add(a : CryptosigneddsaTable, b : CryptosigneddsaTable) -> CryptosigneddsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_table_copy(s : CryptosigneddsaTable) -> CryptosigneddsaTable {
  let result = crypto_sign_eddsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_table_fill(s : CryptosigneddsaTable, v : Double) -> CryptosigneddsaTable {
  let result = crypto_sign_eddsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_table_min(s : CryptosigneddsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_table_max(s : CryptosigneddsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_table_to_string(s : CryptosigneddsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_graphn_make(size : Int) -> CryptosigneddsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_graphn_len(s : CryptosigneddsaGraphN) -> Int { s.size }

pub fn crypto_sign_eddsa_graphn_get(s : CryptosigneddsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_graphn_set(s : CryptosigneddsaGraphN, i : Int, v : Double) -> CryptosigneddsaGraphN {
  let result = crypto_sign_eddsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_graphn_sum(s : CryptosigneddsaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_graphn_mean(s : CryptosigneddsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_graphn_scale(s : CryptosigneddsaGraphN, f : Double) -> CryptosigneddsaGraphN {
  let result = crypto_sign_eddsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_graphn_add(a : CryptosigneddsaGraphN, b : CryptosigneddsaGraphN) -> CryptosigneddsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_graphn_copy(s : CryptosigneddsaGraphN) -> CryptosigneddsaGraphN {
  let result = crypto_sign_eddsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_graphn_fill(s : CryptosigneddsaGraphN, v : Double) -> CryptosigneddsaGraphN {
  let result = crypto_sign_eddsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_graphn_min(s : CryptosigneddsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_graphn_max(s : CryptosigneddsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_graphn_to_string(s : CryptosigneddsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_node_make(size : Int) -> CryptosigneddsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_node_len(s : CryptosigneddsaNode) -> Int { s.size }

pub fn crypto_sign_eddsa_node_get(s : CryptosigneddsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_node_set(s : CryptosigneddsaNode, i : Int, v : Double) -> CryptosigneddsaNode {
  let result = crypto_sign_eddsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_node_sum(s : CryptosigneddsaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_node_mean(s : CryptosigneddsaNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_node_scale(s : CryptosigneddsaNode, f : Double) -> CryptosigneddsaNode {
  let result = crypto_sign_eddsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_node_add(a : CryptosigneddsaNode, b : CryptosigneddsaNode) -> CryptosigneddsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_node_copy(s : CryptosigneddsaNode) -> CryptosigneddsaNode {
  let result = crypto_sign_eddsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_node_fill(s : CryptosigneddsaNode, v : Double) -> CryptosigneddsaNode {
  let result = crypto_sign_eddsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_node_min(s : CryptosigneddsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_node_max(s : CryptosigneddsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_node_to_string(s : CryptosigneddsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_edge_make(size : Int) -> CryptosigneddsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_edge_len(s : CryptosigneddsaEdge) -> Int { s.size }

pub fn crypto_sign_eddsa_edge_get(s : CryptosigneddsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_edge_set(s : CryptosigneddsaEdge, i : Int, v : Double) -> CryptosigneddsaEdge {
  let result = crypto_sign_eddsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_edge_sum(s : CryptosigneddsaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_edge_mean(s : CryptosigneddsaEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_edge_scale(s : CryptosigneddsaEdge, f : Double) -> CryptosigneddsaEdge {
  let result = crypto_sign_eddsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_edge_add(a : CryptosigneddsaEdge, b : CryptosigneddsaEdge) -> CryptosigneddsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_edge_copy(s : CryptosigneddsaEdge) -> CryptosigneddsaEdge {
  let result = crypto_sign_eddsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_edge_fill(s : CryptosigneddsaEdge, v : Double) -> CryptosigneddsaEdge {
  let result = crypto_sign_eddsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_edge_min(s : CryptosigneddsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_edge_max(s : CryptosigneddsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_edge_to_string(s : CryptosigneddsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_path_make(size : Int) -> CryptosigneddsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_path_len(s : CryptosigneddsaPath) -> Int { s.size }

pub fn crypto_sign_eddsa_path_get(s : CryptosigneddsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_path_set(s : CryptosigneddsaPath, i : Int, v : Double) -> CryptosigneddsaPath {
  let result = crypto_sign_eddsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_path_sum(s : CryptosigneddsaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_path_mean(s : CryptosigneddsaPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_path_scale(s : CryptosigneddsaPath, f : Double) -> CryptosigneddsaPath {
  let result = crypto_sign_eddsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_path_add(a : CryptosigneddsaPath, b : CryptosigneddsaPath) -> CryptosigneddsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_path_copy(s : CryptosigneddsaPath) -> CryptosigneddsaPath {
  let result = crypto_sign_eddsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_path_fill(s : CryptosigneddsaPath, v : Double) -> CryptosigneddsaPath {
  let result = crypto_sign_eddsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_path_min(s : CryptosigneddsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_path_max(s : CryptosigneddsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_path_to_string(s : CryptosigneddsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_cluster_make(size : Int) -> CryptosigneddsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_cluster_len(s : CryptosigneddsaCluster) -> Int { s.size }

pub fn crypto_sign_eddsa_cluster_get(s : CryptosigneddsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_cluster_set(s : CryptosigneddsaCluster, i : Int, v : Double) -> CryptosigneddsaCluster {
  let result = crypto_sign_eddsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_cluster_sum(s : CryptosigneddsaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_cluster_mean(s : CryptosigneddsaCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_cluster_scale(s : CryptosigneddsaCluster, f : Double) -> CryptosigneddsaCluster {
  let result = crypto_sign_eddsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_cluster_add(a : CryptosigneddsaCluster, b : CryptosigneddsaCluster) -> CryptosigneddsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_cluster_copy(s : CryptosigneddsaCluster) -> CryptosigneddsaCluster {
  let result = crypto_sign_eddsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_cluster_fill(s : CryptosigneddsaCluster, v : Double) -> CryptosigneddsaCluster {
  let result = crypto_sign_eddsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_cluster_min(s : CryptosigneddsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_cluster_max(s : CryptosigneddsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_cluster_to_string(s : CryptosigneddsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_model_make(size : Int) -> CryptosigneddsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_model_len(s : CryptosigneddsaModel) -> Int { s.size }

pub fn crypto_sign_eddsa_model_get(s : CryptosigneddsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_model_set(s : CryptosigneddsaModel, i : Int, v : Double) -> CryptosigneddsaModel {
  let result = crypto_sign_eddsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_model_sum(s : CryptosigneddsaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_model_mean(s : CryptosigneddsaModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_model_scale(s : CryptosigneddsaModel, f : Double) -> CryptosigneddsaModel {
  let result = crypto_sign_eddsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_model_add(a : CryptosigneddsaModel, b : CryptosigneddsaModel) -> CryptosigneddsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_model_copy(s : CryptosigneddsaModel) -> CryptosigneddsaModel {
  let result = crypto_sign_eddsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_model_fill(s : CryptosigneddsaModel, v : Double) -> CryptosigneddsaModel {
  let result = crypto_sign_eddsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_model_min(s : CryptosigneddsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_model_max(s : CryptosigneddsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_model_to_string(s : CryptosigneddsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_layer_make(size : Int) -> CryptosigneddsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_layer_len(s : CryptosigneddsaLayer) -> Int { s.size }

pub fn crypto_sign_eddsa_layer_get(s : CryptosigneddsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_layer_set(s : CryptosigneddsaLayer, i : Int, v : Double) -> CryptosigneddsaLayer {
  let result = crypto_sign_eddsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_layer_sum(s : CryptosigneddsaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_layer_mean(s : CryptosigneddsaLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_layer_scale(s : CryptosigneddsaLayer, f : Double) -> CryptosigneddsaLayer {
  let result = crypto_sign_eddsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_layer_add(a : CryptosigneddsaLayer, b : CryptosigneddsaLayer) -> CryptosigneddsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_layer_copy(s : CryptosigneddsaLayer) -> CryptosigneddsaLayer {
  let result = crypto_sign_eddsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_layer_fill(s : CryptosigneddsaLayer, v : Double) -> CryptosigneddsaLayer {
  let result = crypto_sign_eddsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_layer_min(s : CryptosigneddsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_layer_max(s : CryptosigneddsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_layer_to_string(s : CryptosigneddsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_buffer_make(size : Int) -> CryptosigneddsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_buffer_len(s : CryptosigneddsaBuffer) -> Int { s.size }

pub fn crypto_sign_eddsa_buffer_get(s : CryptosigneddsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_buffer_set(s : CryptosigneddsaBuffer, i : Int, v : Double) -> CryptosigneddsaBuffer {
  let result = crypto_sign_eddsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_buffer_sum(s : CryptosigneddsaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_buffer_mean(s : CryptosigneddsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_buffer_scale(s : CryptosigneddsaBuffer, f : Double) -> CryptosigneddsaBuffer {
  let result = crypto_sign_eddsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_buffer_add(a : CryptosigneddsaBuffer, b : CryptosigneddsaBuffer) -> CryptosigneddsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_buffer_copy(s : CryptosigneddsaBuffer) -> CryptosigneddsaBuffer {
  let result = crypto_sign_eddsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_buffer_fill(s : CryptosigneddsaBuffer, v : Double) -> CryptosigneddsaBuffer {
  let result = crypto_sign_eddsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_buffer_min(s : CryptosigneddsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_buffer_max(s : CryptosigneddsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_buffer_to_string(s : CryptosigneddsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_cursor_make(size : Int) -> CryptosigneddsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_cursor_len(s : CryptosigneddsaCursor) -> Int { s.size }

pub fn crypto_sign_eddsa_cursor_get(s : CryptosigneddsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_cursor_set(s : CryptosigneddsaCursor, i : Int, v : Double) -> CryptosigneddsaCursor {
  let result = crypto_sign_eddsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_cursor_sum(s : CryptosigneddsaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_cursor_mean(s : CryptosigneddsaCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_cursor_scale(s : CryptosigneddsaCursor, f : Double) -> CryptosigneddsaCursor {
  let result = crypto_sign_eddsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_cursor_add(a : CryptosigneddsaCursor, b : CryptosigneddsaCursor) -> CryptosigneddsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_cursor_copy(s : CryptosigneddsaCursor) -> CryptosigneddsaCursor {
  let result = crypto_sign_eddsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_cursor_fill(s : CryptosigneddsaCursor, v : Double) -> CryptosigneddsaCursor {
  let result = crypto_sign_eddsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_cursor_min(s : CryptosigneddsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_cursor_max(s : CryptosigneddsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_cursor_to_string(s : CryptosigneddsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_view_make(size : Int) -> CryptosigneddsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_view_len(s : CryptosigneddsaView) -> Int { s.size }

pub fn crypto_sign_eddsa_view_get(s : CryptosigneddsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_view_set(s : CryptosigneddsaView, i : Int, v : Double) -> CryptosigneddsaView {
  let result = crypto_sign_eddsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_view_sum(s : CryptosigneddsaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_view_mean(s : CryptosigneddsaView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_view_scale(s : CryptosigneddsaView, f : Double) -> CryptosigneddsaView {
  let result = crypto_sign_eddsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_view_add(a : CryptosigneddsaView, b : CryptosigneddsaView) -> CryptosigneddsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_view_copy(s : CryptosigneddsaView) -> CryptosigneddsaView {
  let result = crypto_sign_eddsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_view_fill(s : CryptosigneddsaView, v : Double) -> CryptosigneddsaView {
  let result = crypto_sign_eddsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_view_min(s : CryptosigneddsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_view_max(s : CryptosigneddsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_view_to_string(s : CryptosigneddsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_range_make(size : Int) -> CryptosigneddsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_range_len(s : CryptosigneddsaRange) -> Int { s.size }

pub fn crypto_sign_eddsa_range_get(s : CryptosigneddsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_range_set(s : CryptosigneddsaRange, i : Int, v : Double) -> CryptosigneddsaRange {
  let result = crypto_sign_eddsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_range_sum(s : CryptosigneddsaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_range_mean(s : CryptosigneddsaRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_range_scale(s : CryptosigneddsaRange, f : Double) -> CryptosigneddsaRange {
  let result = crypto_sign_eddsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_range_add(a : CryptosigneddsaRange, b : CryptosigneddsaRange) -> CryptosigneddsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_range_copy(s : CryptosigneddsaRange) -> CryptosigneddsaRange {
  let result = crypto_sign_eddsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_range_fill(s : CryptosigneddsaRange, v : Double) -> CryptosigneddsaRange {
  let result = crypto_sign_eddsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_range_min(s : CryptosigneddsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_range_max(s : CryptosigneddsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_range_to_string(s : CryptosigneddsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosigneddsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_eddsa_slice_make(size : Int) -> CryptosigneddsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_eddsa_slice_len(s : CryptosigneddsaSlice) -> Int { s.size }

pub fn crypto_sign_eddsa_slice_get(s : CryptosigneddsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_eddsa_slice_set(s : CryptosigneddsaSlice, i : Int, v : Double) -> CryptosigneddsaSlice {
  let result = crypto_sign_eddsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_slice_sum(s : CryptosigneddsaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_eddsa_slice_mean(s : CryptosigneddsaSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_eddsa_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_eddsa_slice_scale(s : CryptosigneddsaSlice, f : Double) -> CryptosigneddsaSlice {
  let result = crypto_sign_eddsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_eddsa_slice_add(a : CryptosigneddsaSlice, b : CryptosigneddsaSlice) -> CryptosigneddsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_eddsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_eddsa_slice_copy(s : CryptosigneddsaSlice) -> CryptosigneddsaSlice {
  let result = crypto_sign_eddsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_eddsa_slice_fill(s : CryptosigneddsaSlice, v : Double) -> CryptosigneddsaSlice {
  let result = crypto_sign_eddsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_eddsa_slice_min(s : CryptosigneddsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_slice_max(s : CryptosigneddsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_eddsa_slice_to_string(s : CryptosigneddsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

