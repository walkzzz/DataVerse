///===
/// extcore/crypto_sign_threshold

pub(all) struct CryptosignthresholdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sign_threshold_make_point(x : Double, y : Double) -> CryptosignthresholdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sign_threshold_make_point3(x : Double, y : Double, z : Double) -> CryptosignthresholdPoint {
  { x, y, z, label: 0 }
}

pub fn crypto_sign_threshold_point_x(pt : CryptosignthresholdPoint) -> Double { pt.x }

pub fn crypto_sign_threshold_point_y(pt : CryptosignthresholdPoint) -> Double { pt.y }

pub fn crypto_sign_threshold_point_z(pt : CryptosignthresholdPoint) -> Double { pt.z }

pub fn crypto_sign_threshold_point_label(pt : CryptosignthresholdPoint) -> Int { pt.label }

pub fn crypto_sign_threshold_point_dist(a : CryptosignthresholdPoint, b : CryptosignthresholdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sign_threshold_point_add(a : CryptosignthresholdPoint, b : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sign_threshold_point_sub(a : CryptosignthresholdPoint, b : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sign_threshold_point_scale(pt : CryptosignthresholdPoint, s : Double) -> CryptosignthresholdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sign_threshold_point_dot(a : CryptosignthresholdPoint, b : CryptosignthresholdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sign_threshold_point_cross(a : CryptosignthresholdPoint, b : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sign_threshold_point_norm(pt : CryptosignthresholdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sign_threshold_point_normalize(pt : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  let n = crypto_sign_threshold_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sign_threshold_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sign_threshold_point_negate(pt : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sign_threshold_point_mid(a : CryptosignthresholdPoint, b : CryptosignthresholdPoint) -> CryptosignthresholdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sign_threshold_point_lerp(a : CryptosignthresholdPoint, b : CryptosignthresholdPoint, t : Double) -> CryptosignthresholdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sign_threshold_point_to_string(pt : CryptosignthresholdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct CryptosignthresholdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sign_threshold_make_series(vals : Array[Double], name : String) -> CryptosignthresholdSeries {
  { vals, name, meta: 0 }
}

pub fn crypto_sign_threshold_series_len(s : CryptosignthresholdSeries) -> Int { s.vals.length() }

pub fn crypto_sign_threshold_series_sum(s : CryptosignthresholdSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sign_threshold_series_mean(s : CryptosignthresholdSeries) -> Double {
  let n = crypto_sign_threshold_series_len(s)
  if n == 0 { 0.0 } else { crypto_sign_threshold_series_sum(s) / n.to_double() }
}

pub fn crypto_sign_threshold_series_min(s : CryptosignthresholdSeries) -> Double {
  let n = crypto_sign_threshold_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_threshold_series_max(s : CryptosignthresholdSeries) -> Double {
  let n = crypto_sign_threshold_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn crypto_sign_threshold_series_range(s : CryptosignthresholdSeries) -> Double {
  crypto_sign_threshold_series_max(s) - crypto_sign_threshold_series_min(s)
}

pub fn crypto_sign_threshold_series_var(s : CryptosignthresholdSeries) -> Double {
  let n = crypto_sign_threshold_series_len(s)
  if n == 0 { 0.0 } else {
    let m = crypto_sign_threshold_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn crypto_sign_threshold_series_std(s : CryptosignthresholdSeries) -> Double { @_common.sqrt(crypto_sign_threshold_series_var(s)) }

pub fn crypto_sign_threshold_series_median(s : CryptosignthresholdSeries) -> Double {
  let n = crypto_sign_threshold_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = crypto_sign_threshold_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn crypto_sign_threshold_series_scale(s : CryptosignthresholdSeries, f : Double) -> CryptosignthresholdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sign_threshold_series_add(a : CryptosignthresholdSeries, b : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sign_threshold_series_sub(a : CryptosignthresholdSeries, b : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sign_threshold_series_normalize(s : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  let mn = crypto_sign_threshold_series_min(s)
  let mx = crypto_sign_threshold_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sign_threshold_series_cumsum(s : CryptosignthresholdSeries) -> CryptosignthresholdSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sign_threshold_series_to_string(s : CryptosignthresholdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosignthresholdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sign_threshold_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosignthresholdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sign_threshold_matrix_identity(n : Int) -> CryptosignthresholdMatrix {
  let m = crypto_sign_threshold_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sign_threshold_matrix_get(m : CryptosignthresholdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sign_threshold_matrix_transpose(m : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  let result = crypto_sign_threshold_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sign_threshold_matrix_add(a : CryptosignthresholdMatrix, b : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sign_threshold_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sign_threshold_matrix_scale(m : CryptosignthresholdMatrix, s : Double) -> CryptosignthresholdMatrix {
  let result = crypto_sign_threshold_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sign_threshold_matrix_multiply(a : CryptosignthresholdMatrix, b : CryptosignthresholdMatrix) -> CryptosignthresholdMatrix {
  if a.cols != b.rows { return crypto_sign_threshold_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sign_threshold_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sign_threshold_matrix_trace(m : CryptosignthresholdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sign_threshold_matrix_det(m : CryptosignthresholdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sign_threshold_matrix_norm(m : CryptosignthresholdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sign_threshold_matrix_to_string(m : CryptosignthresholdMatrix) -> String {
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

pub(all) struct CryptosignthresholdVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sign_threshold_make_vector(comps : Array[Double]) -> CryptosignthresholdVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sign_threshold_vector_zero(dim : Int) -> CryptosignthresholdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sign_threshold_vector_add(a : CryptosignthresholdVector, b : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_threshold_vector_sub(a : CryptosignthresholdVector, b : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sign_threshold_vector_scale(v : CryptosignthresholdVector, s : Double) -> CryptosignthresholdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sign_threshold_vector_dot(a : CryptosignthresholdVector, b : CryptosignthresholdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sign_threshold_vector_norm(v : CryptosignthresholdVector) -> Double { @_common.sqrt(crypto_sign_threshold_vector_dot(v, v)) }

pub fn crypto_sign_threshold_vector_normalize(v : CryptosignthresholdVector) -> CryptosignthresholdVector {
  let n = crypto_sign_threshold_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sign_threshold_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sign_threshold_vector_dist(a : CryptosignthresholdVector, b : CryptosignthresholdVector) -> Double {
  crypto_sign_threshold_vector_norm(crypto_sign_threshold_vector_sub(a, b))
}

pub fn crypto_sign_threshold_vector_to_string(v : CryptosignthresholdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sign_threshold_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sign_threshold_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sign_threshold_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sign_threshold_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sign_threshold_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sign_threshold_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sign_threshold_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sign_threshold_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sign_threshold_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sign_threshold_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sign_threshold_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sign_threshold_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sign_threshold_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sign_threshold_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sign_threshold_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sign_threshold_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sign_threshold_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sign_threshold_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sign_threshold_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sign_threshold_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sign_threshold_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sign_threshold_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sign_threshold_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sign_threshold_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sign_threshold_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sign_threshold_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sign_threshold_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sign_threshold_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sign_threshold_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosignthresholdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_frame_make(size : Int) -> CryptosignthresholdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_frame_len(s : CryptosignthresholdFrame) -> Int { s.size }

pub fn crypto_sign_threshold_frame_get(s : CryptosignthresholdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_frame_set(s : CryptosignthresholdFrame, i : Int, v : Double) -> CryptosignthresholdFrame {
  let result = crypto_sign_threshold_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_frame_sum(s : CryptosignthresholdFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_frame_mean(s : CryptosignthresholdFrame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_frame_scale(s : CryptosignthresholdFrame, f : Double) -> CryptosignthresholdFrame {
  let result = crypto_sign_threshold_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_frame_add(a : CryptosignthresholdFrame, b : CryptosignthresholdFrame) -> CryptosignthresholdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_frame_copy(s : CryptosignthresholdFrame) -> CryptosignthresholdFrame {
  let result = crypto_sign_threshold_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_frame_fill(s : CryptosignthresholdFrame, v : Double) -> CryptosignthresholdFrame {
  let result = crypto_sign_threshold_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_frame_min(s : CryptosignthresholdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_frame_max(s : CryptosignthresholdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_frame_to_string(s : CryptosignthresholdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_table_make(size : Int) -> CryptosignthresholdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_table_len(s : CryptosignthresholdTable) -> Int { s.size }

pub fn crypto_sign_threshold_table_get(s : CryptosignthresholdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_table_set(s : CryptosignthresholdTable, i : Int, v : Double) -> CryptosignthresholdTable {
  let result = crypto_sign_threshold_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_table_sum(s : CryptosignthresholdTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_table_mean(s : CryptosignthresholdTable) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_table_scale(s : CryptosignthresholdTable, f : Double) -> CryptosignthresholdTable {
  let result = crypto_sign_threshold_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_table_add(a : CryptosignthresholdTable, b : CryptosignthresholdTable) -> CryptosignthresholdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_table_copy(s : CryptosignthresholdTable) -> CryptosignthresholdTable {
  let result = crypto_sign_threshold_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_table_fill(s : CryptosignthresholdTable, v : Double) -> CryptosignthresholdTable {
  let result = crypto_sign_threshold_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_table_min(s : CryptosignthresholdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_table_max(s : CryptosignthresholdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_table_to_string(s : CryptosignthresholdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_graphn_make(size : Int) -> CryptosignthresholdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_graphn_len(s : CryptosignthresholdGraphN) -> Int { s.size }

pub fn crypto_sign_threshold_graphn_get(s : CryptosignthresholdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_graphn_set(s : CryptosignthresholdGraphN, i : Int, v : Double) -> CryptosignthresholdGraphN {
  let result = crypto_sign_threshold_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_graphn_sum(s : CryptosignthresholdGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_graphn_mean(s : CryptosignthresholdGraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_graphn_scale(s : CryptosignthresholdGraphN, f : Double) -> CryptosignthresholdGraphN {
  let result = crypto_sign_threshold_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_graphn_add(a : CryptosignthresholdGraphN, b : CryptosignthresholdGraphN) -> CryptosignthresholdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_graphn_copy(s : CryptosignthresholdGraphN) -> CryptosignthresholdGraphN {
  let result = crypto_sign_threshold_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_graphn_fill(s : CryptosignthresholdGraphN, v : Double) -> CryptosignthresholdGraphN {
  let result = crypto_sign_threshold_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_graphn_min(s : CryptosignthresholdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_graphn_max(s : CryptosignthresholdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_graphn_to_string(s : CryptosignthresholdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_node_make(size : Int) -> CryptosignthresholdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_node_len(s : CryptosignthresholdNode) -> Int { s.size }

pub fn crypto_sign_threshold_node_get(s : CryptosignthresholdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_node_set(s : CryptosignthresholdNode, i : Int, v : Double) -> CryptosignthresholdNode {
  let result = crypto_sign_threshold_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_node_sum(s : CryptosignthresholdNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_node_mean(s : CryptosignthresholdNode) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_node_scale(s : CryptosignthresholdNode, f : Double) -> CryptosignthresholdNode {
  let result = crypto_sign_threshold_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_node_add(a : CryptosignthresholdNode, b : CryptosignthresholdNode) -> CryptosignthresholdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_node_copy(s : CryptosignthresholdNode) -> CryptosignthresholdNode {
  let result = crypto_sign_threshold_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_node_fill(s : CryptosignthresholdNode, v : Double) -> CryptosignthresholdNode {
  let result = crypto_sign_threshold_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_node_min(s : CryptosignthresholdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_node_max(s : CryptosignthresholdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_node_to_string(s : CryptosignthresholdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_edge_make(size : Int) -> CryptosignthresholdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_edge_len(s : CryptosignthresholdEdge) -> Int { s.size }

pub fn crypto_sign_threshold_edge_get(s : CryptosignthresholdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_edge_set(s : CryptosignthresholdEdge, i : Int, v : Double) -> CryptosignthresholdEdge {
  let result = crypto_sign_threshold_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_edge_sum(s : CryptosignthresholdEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_edge_mean(s : CryptosignthresholdEdge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_edge_scale(s : CryptosignthresholdEdge, f : Double) -> CryptosignthresholdEdge {
  let result = crypto_sign_threshold_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_edge_add(a : CryptosignthresholdEdge, b : CryptosignthresholdEdge) -> CryptosignthresholdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_edge_copy(s : CryptosignthresholdEdge) -> CryptosignthresholdEdge {
  let result = crypto_sign_threshold_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_edge_fill(s : CryptosignthresholdEdge, v : Double) -> CryptosignthresholdEdge {
  let result = crypto_sign_threshold_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_edge_min(s : CryptosignthresholdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_edge_max(s : CryptosignthresholdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_edge_to_string(s : CryptosignthresholdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_path_make(size : Int) -> CryptosignthresholdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_path_len(s : CryptosignthresholdPath) -> Int { s.size }

pub fn crypto_sign_threshold_path_get(s : CryptosignthresholdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_path_set(s : CryptosignthresholdPath, i : Int, v : Double) -> CryptosignthresholdPath {
  let result = crypto_sign_threshold_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_path_sum(s : CryptosignthresholdPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_path_mean(s : CryptosignthresholdPath) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_path_scale(s : CryptosignthresholdPath, f : Double) -> CryptosignthresholdPath {
  let result = crypto_sign_threshold_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_path_add(a : CryptosignthresholdPath, b : CryptosignthresholdPath) -> CryptosignthresholdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_path_copy(s : CryptosignthresholdPath) -> CryptosignthresholdPath {
  let result = crypto_sign_threshold_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_path_fill(s : CryptosignthresholdPath, v : Double) -> CryptosignthresholdPath {
  let result = crypto_sign_threshold_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_path_min(s : CryptosignthresholdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_path_max(s : CryptosignthresholdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_path_to_string(s : CryptosignthresholdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_cluster_make(size : Int) -> CryptosignthresholdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_cluster_len(s : CryptosignthresholdCluster) -> Int { s.size }

pub fn crypto_sign_threshold_cluster_get(s : CryptosignthresholdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_cluster_set(s : CryptosignthresholdCluster, i : Int, v : Double) -> CryptosignthresholdCluster {
  let result = crypto_sign_threshold_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_cluster_sum(s : CryptosignthresholdCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_cluster_mean(s : CryptosignthresholdCluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_cluster_scale(s : CryptosignthresholdCluster, f : Double) -> CryptosignthresholdCluster {
  let result = crypto_sign_threshold_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_cluster_add(a : CryptosignthresholdCluster, b : CryptosignthresholdCluster) -> CryptosignthresholdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_cluster_copy(s : CryptosignthresholdCluster) -> CryptosignthresholdCluster {
  let result = crypto_sign_threshold_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_cluster_fill(s : CryptosignthresholdCluster, v : Double) -> CryptosignthresholdCluster {
  let result = crypto_sign_threshold_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_cluster_min(s : CryptosignthresholdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_cluster_max(s : CryptosignthresholdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_cluster_to_string(s : CryptosignthresholdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_model_make(size : Int) -> CryptosignthresholdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_model_len(s : CryptosignthresholdModel) -> Int { s.size }

pub fn crypto_sign_threshold_model_get(s : CryptosignthresholdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_model_set(s : CryptosignthresholdModel, i : Int, v : Double) -> CryptosignthresholdModel {
  let result = crypto_sign_threshold_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_model_sum(s : CryptosignthresholdModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_model_mean(s : CryptosignthresholdModel) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_model_scale(s : CryptosignthresholdModel, f : Double) -> CryptosignthresholdModel {
  let result = crypto_sign_threshold_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_model_add(a : CryptosignthresholdModel, b : CryptosignthresholdModel) -> CryptosignthresholdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_model_copy(s : CryptosignthresholdModel) -> CryptosignthresholdModel {
  let result = crypto_sign_threshold_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_model_fill(s : CryptosignthresholdModel, v : Double) -> CryptosignthresholdModel {
  let result = crypto_sign_threshold_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_model_min(s : CryptosignthresholdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_model_max(s : CryptosignthresholdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_model_to_string(s : CryptosignthresholdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_layer_make(size : Int) -> CryptosignthresholdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_layer_len(s : CryptosignthresholdLayer) -> Int { s.size }

pub fn crypto_sign_threshold_layer_get(s : CryptosignthresholdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_layer_set(s : CryptosignthresholdLayer, i : Int, v : Double) -> CryptosignthresholdLayer {
  let result = crypto_sign_threshold_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_layer_sum(s : CryptosignthresholdLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_layer_mean(s : CryptosignthresholdLayer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_layer_scale(s : CryptosignthresholdLayer, f : Double) -> CryptosignthresholdLayer {
  let result = crypto_sign_threshold_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_layer_add(a : CryptosignthresholdLayer, b : CryptosignthresholdLayer) -> CryptosignthresholdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_layer_copy(s : CryptosignthresholdLayer) -> CryptosignthresholdLayer {
  let result = crypto_sign_threshold_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_layer_fill(s : CryptosignthresholdLayer, v : Double) -> CryptosignthresholdLayer {
  let result = crypto_sign_threshold_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_layer_min(s : CryptosignthresholdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_layer_max(s : CryptosignthresholdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_layer_to_string(s : CryptosignthresholdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_buffer_make(size : Int) -> CryptosignthresholdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_buffer_len(s : CryptosignthresholdBuffer) -> Int { s.size }

pub fn crypto_sign_threshold_buffer_get(s : CryptosignthresholdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_buffer_set(s : CryptosignthresholdBuffer, i : Int, v : Double) -> CryptosignthresholdBuffer {
  let result = crypto_sign_threshold_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_buffer_sum(s : CryptosignthresholdBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_buffer_mean(s : CryptosignthresholdBuffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_buffer_scale(s : CryptosignthresholdBuffer, f : Double) -> CryptosignthresholdBuffer {
  let result = crypto_sign_threshold_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_buffer_add(a : CryptosignthresholdBuffer, b : CryptosignthresholdBuffer) -> CryptosignthresholdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_buffer_copy(s : CryptosignthresholdBuffer) -> CryptosignthresholdBuffer {
  let result = crypto_sign_threshold_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_buffer_fill(s : CryptosignthresholdBuffer, v : Double) -> CryptosignthresholdBuffer {
  let result = crypto_sign_threshold_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_buffer_min(s : CryptosignthresholdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_buffer_max(s : CryptosignthresholdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_buffer_to_string(s : CryptosignthresholdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_cursor_make(size : Int) -> CryptosignthresholdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_cursor_len(s : CryptosignthresholdCursor) -> Int { s.size }

pub fn crypto_sign_threshold_cursor_get(s : CryptosignthresholdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_cursor_set(s : CryptosignthresholdCursor, i : Int, v : Double) -> CryptosignthresholdCursor {
  let result = crypto_sign_threshold_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_cursor_sum(s : CryptosignthresholdCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_cursor_mean(s : CryptosignthresholdCursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_cursor_scale(s : CryptosignthresholdCursor, f : Double) -> CryptosignthresholdCursor {
  let result = crypto_sign_threshold_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_cursor_add(a : CryptosignthresholdCursor, b : CryptosignthresholdCursor) -> CryptosignthresholdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_cursor_copy(s : CryptosignthresholdCursor) -> CryptosignthresholdCursor {
  let result = crypto_sign_threshold_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_cursor_fill(s : CryptosignthresholdCursor, v : Double) -> CryptosignthresholdCursor {
  let result = crypto_sign_threshold_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_cursor_min(s : CryptosignthresholdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_cursor_max(s : CryptosignthresholdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_cursor_to_string(s : CryptosignthresholdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_view_make(size : Int) -> CryptosignthresholdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_view_len(s : CryptosignthresholdView) -> Int { s.size }

pub fn crypto_sign_threshold_view_get(s : CryptosignthresholdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_view_set(s : CryptosignthresholdView, i : Int, v : Double) -> CryptosignthresholdView {
  let result = crypto_sign_threshold_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_view_sum(s : CryptosignthresholdView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_view_mean(s : CryptosignthresholdView) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_view_scale(s : CryptosignthresholdView, f : Double) -> CryptosignthresholdView {
  let result = crypto_sign_threshold_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_view_add(a : CryptosignthresholdView, b : CryptosignthresholdView) -> CryptosignthresholdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_view_copy(s : CryptosignthresholdView) -> CryptosignthresholdView {
  let result = crypto_sign_threshold_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_view_fill(s : CryptosignthresholdView, v : Double) -> CryptosignthresholdView {
  let result = crypto_sign_threshold_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_view_min(s : CryptosignthresholdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_view_max(s : CryptosignthresholdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_view_to_string(s : CryptosignthresholdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_range_make(size : Int) -> CryptosignthresholdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_range_len(s : CryptosignthresholdRange) -> Int { s.size }

pub fn crypto_sign_threshold_range_get(s : CryptosignthresholdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_range_set(s : CryptosignthresholdRange, i : Int, v : Double) -> CryptosignthresholdRange {
  let result = crypto_sign_threshold_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_range_sum(s : CryptosignthresholdRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_range_mean(s : CryptosignthresholdRange) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_range_scale(s : CryptosignthresholdRange, f : Double) -> CryptosignthresholdRange {
  let result = crypto_sign_threshold_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_range_add(a : CryptosignthresholdRange, b : CryptosignthresholdRange) -> CryptosignthresholdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_range_copy(s : CryptosignthresholdRange) -> CryptosignthresholdRange {
  let result = crypto_sign_threshold_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_range_fill(s : CryptosignthresholdRange, v : Double) -> CryptosignthresholdRange {
  let result = crypto_sign_threshold_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_range_min(s : CryptosignthresholdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_range_max(s : CryptosignthresholdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_range_to_string(s : CryptosignthresholdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosignthresholdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sign_threshold_slice_make(size : Int) -> CryptosignthresholdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sign_threshold_slice_len(s : CryptosignthresholdSlice) -> Int { s.size }

pub fn crypto_sign_threshold_slice_get(s : CryptosignthresholdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sign_threshold_slice_set(s : CryptosignthresholdSlice, i : Int, v : Double) -> CryptosignthresholdSlice {
  let result = crypto_sign_threshold_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_slice_sum(s : CryptosignthresholdSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sign_threshold_slice_mean(s : CryptosignthresholdSlice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sign_threshold_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sign_threshold_slice_scale(s : CryptosignthresholdSlice, f : Double) -> CryptosignthresholdSlice {
  let result = crypto_sign_threshold_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sign_threshold_slice_add(a : CryptosignthresholdSlice, b : CryptosignthresholdSlice) -> CryptosignthresholdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sign_threshold_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sign_threshold_slice_copy(s : CryptosignthresholdSlice) -> CryptosignthresholdSlice {
  let result = crypto_sign_threshold_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sign_threshold_slice_fill(s : CryptosignthresholdSlice, v : Double) -> CryptosignthresholdSlice {
  let result = crypto_sign_threshold_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sign_threshold_slice_min(s : CryptosignthresholdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_slice_max(s : CryptosignthresholdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sign_threshold_slice_to_string(s : CryptosignthresholdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

