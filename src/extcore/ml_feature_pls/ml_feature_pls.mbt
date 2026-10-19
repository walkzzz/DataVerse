///===
/// extcore/ml_feature_pls

pub(all) struct MlfeatureplsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_pls_make_point(x : Double, y : Double) -> MlfeatureplsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_pls_make_point3(x : Double, y : Double, z : Double) -> MlfeatureplsPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_pls_point_x(pt : MlfeatureplsPoint) -> Double { pt.x }

pub fn ml_feature_pls_point_y(pt : MlfeatureplsPoint) -> Double { pt.y }

pub fn ml_feature_pls_point_z(pt : MlfeatureplsPoint) -> Double { pt.z }

pub fn ml_feature_pls_point_label(pt : MlfeatureplsPoint) -> Int { pt.label }

pub fn ml_feature_pls_point_dist(a : MlfeatureplsPoint, b : MlfeatureplsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_pls_point_add(a : MlfeatureplsPoint, b : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_pls_point_sub(a : MlfeatureplsPoint, b : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_pls_point_scale(pt : MlfeatureplsPoint, s : Double) -> MlfeatureplsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_pls_point_dot(a : MlfeatureplsPoint, b : MlfeatureplsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_pls_point_cross(a : MlfeatureplsPoint, b : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_pls_point_norm(pt : MlfeatureplsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_pls_point_normalize(pt : MlfeatureplsPoint) -> MlfeatureplsPoint {
  let n = ml_feature_pls_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_pls_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_pls_point_negate(pt : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_pls_point_mid(a : MlfeatureplsPoint, b : MlfeatureplsPoint) -> MlfeatureplsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_pls_point_lerp(a : MlfeatureplsPoint, b : MlfeatureplsPoint, t : Double) -> MlfeatureplsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_pls_point_to_string(pt : MlfeatureplsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeatureplsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_pls_make_series(vals : Array[Double], name : String) -> MlfeatureplsSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_pls_series_len(s : MlfeatureplsSeries) -> Int { s.vals.length() }

pub fn ml_feature_pls_series_sum(s : MlfeatureplsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_feature_pls_series_mean(s : MlfeatureplsSeries) -> Double {
  let n = ml_feature_pls_series_len(s)
  if n == 0 { 0.0 } else { ml_feature_pls_series_sum(s) / n.to_double() }
}

pub fn ml_feature_pls_series_min(s : MlfeatureplsSeries) -> Double {
  let n = ml_feature_pls_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_pls_series_max(s : MlfeatureplsSeries) -> Double {
  let n = ml_feature_pls_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_pls_series_range(s : MlfeatureplsSeries) -> Double {
  ml_feature_pls_series_max(s) - ml_feature_pls_series_min(s)
}

pub fn ml_feature_pls_series_var(s : MlfeatureplsSeries) -> Double {
  let n = ml_feature_pls_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_feature_pls_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_feature_pls_series_std(s : MlfeatureplsSeries) -> Double { @_common.sqrt(ml_feature_pls_series_var(s)) }

pub fn ml_feature_pls_series_median(s : MlfeatureplsSeries) -> Double {
  let n = ml_feature_pls_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_feature_pls_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_feature_pls_series_scale(s : MlfeatureplsSeries, f : Double) -> MlfeatureplsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_feature_pls_series_add(a : MlfeatureplsSeries, b : MlfeatureplsSeries) -> MlfeatureplsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_pls_series_sub(a : MlfeatureplsSeries, b : MlfeatureplsSeries) -> MlfeatureplsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_pls_series_normalize(s : MlfeatureplsSeries) -> MlfeatureplsSeries {
  let mn = ml_feature_pls_series_min(s)
  let mx = ml_feature_pls_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_pls_series_cumsum(s : MlfeatureplsSeries) -> MlfeatureplsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_pls_series_to_string(s : MlfeatureplsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureplsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_pls_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureplsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_pls_matrix_identity(n : Int) -> MlfeatureplsMatrix {
  let m = ml_feature_pls_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_pls_matrix_get(m : MlfeatureplsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_pls_matrix_transpose(m : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  let result = ml_feature_pls_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_pls_matrix_add(a : MlfeatureplsMatrix, b : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_pls_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_pls_matrix_scale(m : MlfeatureplsMatrix, s : Double) -> MlfeatureplsMatrix {
  let result = ml_feature_pls_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_pls_matrix_multiply(a : MlfeatureplsMatrix, b : MlfeatureplsMatrix) -> MlfeatureplsMatrix {
  if a.cols != b.rows { return ml_feature_pls_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_pls_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_pls_matrix_trace(m : MlfeatureplsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_pls_matrix_det(m : MlfeatureplsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_pls_matrix_norm(m : MlfeatureplsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_feature_pls_matrix_to_string(m : MlfeatureplsMatrix) -> String {
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

pub(all) struct MlfeatureplsVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_pls_make_vector(comps : Array[Double]) -> MlfeatureplsVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_pls_vector_zero(dim : Int) -> MlfeatureplsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_pls_vector_add(a : MlfeatureplsVector, b : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_pls_vector_sub(a : MlfeatureplsVector, b : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_pls_vector_scale(v : MlfeatureplsVector, s : Double) -> MlfeatureplsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_feature_pls_vector_dot(a : MlfeatureplsVector, b : MlfeatureplsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_pls_vector_norm(v : MlfeatureplsVector) -> Double { @_common.sqrt(ml_feature_pls_vector_dot(v, v)) }

pub fn ml_feature_pls_vector_normalize(v : MlfeatureplsVector) -> MlfeatureplsVector {
  let n = ml_feature_pls_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_pls_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_pls_vector_dist(a : MlfeatureplsVector, b : MlfeatureplsVector) -> Double {
  ml_feature_pls_vector_norm(ml_feature_pls_vector_sub(a, b))
}

pub fn ml_feature_pls_vector_to_string(v : MlfeatureplsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_pls_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_pls_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_pls_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_pls_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_pls_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_pls_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_pls_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_pls_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_pls_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_pls_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_pls_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_pls_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_pls_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_pls_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_pls_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_pls_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_pls_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_pls_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_pls_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_pls_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_pls_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_pls_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_pls_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_pls_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_pls_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_pls_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_pls_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_pls_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_pls_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureplsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_frame_make(size : Int) -> MlfeatureplsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_frame_len(s : MlfeatureplsFrame) -> Int { s.size }

pub fn ml_feature_pls_frame_get(s : MlfeatureplsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_frame_set(s : MlfeatureplsFrame, i : Int, v : Double) -> MlfeatureplsFrame {
  let result = ml_feature_pls_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_frame_sum(s : MlfeatureplsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_frame_mean(s : MlfeatureplsFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_frame_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_frame_scale(s : MlfeatureplsFrame, f : Double) -> MlfeatureplsFrame {
  let result = ml_feature_pls_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_frame_add(a : MlfeatureplsFrame, b : MlfeatureplsFrame) -> MlfeatureplsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_frame_copy(s : MlfeatureplsFrame) -> MlfeatureplsFrame {
  let result = ml_feature_pls_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_frame_fill(s : MlfeatureplsFrame, v : Double) -> MlfeatureplsFrame {
  let result = ml_feature_pls_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_frame_min(s : MlfeatureplsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_frame_max(s : MlfeatureplsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_frame_to_string(s : MlfeatureplsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_table_make(size : Int) -> MlfeatureplsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_table_len(s : MlfeatureplsTable) -> Int { s.size }

pub fn ml_feature_pls_table_get(s : MlfeatureplsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_table_set(s : MlfeatureplsTable, i : Int, v : Double) -> MlfeatureplsTable {
  let result = ml_feature_pls_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_table_sum(s : MlfeatureplsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_table_mean(s : MlfeatureplsTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_table_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_table_scale(s : MlfeatureplsTable, f : Double) -> MlfeatureplsTable {
  let result = ml_feature_pls_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_table_add(a : MlfeatureplsTable, b : MlfeatureplsTable) -> MlfeatureplsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_table_copy(s : MlfeatureplsTable) -> MlfeatureplsTable {
  let result = ml_feature_pls_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_table_fill(s : MlfeatureplsTable, v : Double) -> MlfeatureplsTable {
  let result = ml_feature_pls_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_table_min(s : MlfeatureplsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_table_max(s : MlfeatureplsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_table_to_string(s : MlfeatureplsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_graphn_make(size : Int) -> MlfeatureplsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_graphn_len(s : MlfeatureplsGraphN) -> Int { s.size }

pub fn ml_feature_pls_graphn_get(s : MlfeatureplsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_graphn_set(s : MlfeatureplsGraphN, i : Int, v : Double) -> MlfeatureplsGraphN {
  let result = ml_feature_pls_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_graphn_sum(s : MlfeatureplsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_graphn_mean(s : MlfeatureplsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_graphn_scale(s : MlfeatureplsGraphN, f : Double) -> MlfeatureplsGraphN {
  let result = ml_feature_pls_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_graphn_add(a : MlfeatureplsGraphN, b : MlfeatureplsGraphN) -> MlfeatureplsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_graphn_copy(s : MlfeatureplsGraphN) -> MlfeatureplsGraphN {
  let result = ml_feature_pls_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_graphn_fill(s : MlfeatureplsGraphN, v : Double) -> MlfeatureplsGraphN {
  let result = ml_feature_pls_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_graphn_min(s : MlfeatureplsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_graphn_max(s : MlfeatureplsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_graphn_to_string(s : MlfeatureplsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_node_make(size : Int) -> MlfeatureplsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_node_len(s : MlfeatureplsNode) -> Int { s.size }

pub fn ml_feature_pls_node_get(s : MlfeatureplsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_node_set(s : MlfeatureplsNode, i : Int, v : Double) -> MlfeatureplsNode {
  let result = ml_feature_pls_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_node_sum(s : MlfeatureplsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_node_mean(s : MlfeatureplsNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_node_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_node_scale(s : MlfeatureplsNode, f : Double) -> MlfeatureplsNode {
  let result = ml_feature_pls_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_node_add(a : MlfeatureplsNode, b : MlfeatureplsNode) -> MlfeatureplsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_node_copy(s : MlfeatureplsNode) -> MlfeatureplsNode {
  let result = ml_feature_pls_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_node_fill(s : MlfeatureplsNode, v : Double) -> MlfeatureplsNode {
  let result = ml_feature_pls_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_node_min(s : MlfeatureplsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_node_max(s : MlfeatureplsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_node_to_string(s : MlfeatureplsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_edge_make(size : Int) -> MlfeatureplsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_edge_len(s : MlfeatureplsEdge) -> Int { s.size }

pub fn ml_feature_pls_edge_get(s : MlfeatureplsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_edge_set(s : MlfeatureplsEdge, i : Int, v : Double) -> MlfeatureplsEdge {
  let result = ml_feature_pls_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_edge_sum(s : MlfeatureplsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_edge_mean(s : MlfeatureplsEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_edge_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_edge_scale(s : MlfeatureplsEdge, f : Double) -> MlfeatureplsEdge {
  let result = ml_feature_pls_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_edge_add(a : MlfeatureplsEdge, b : MlfeatureplsEdge) -> MlfeatureplsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_edge_copy(s : MlfeatureplsEdge) -> MlfeatureplsEdge {
  let result = ml_feature_pls_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_edge_fill(s : MlfeatureplsEdge, v : Double) -> MlfeatureplsEdge {
  let result = ml_feature_pls_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_edge_min(s : MlfeatureplsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_edge_max(s : MlfeatureplsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_edge_to_string(s : MlfeatureplsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_path_make(size : Int) -> MlfeatureplsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_path_len(s : MlfeatureplsPath) -> Int { s.size }

pub fn ml_feature_pls_path_get(s : MlfeatureplsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_path_set(s : MlfeatureplsPath, i : Int, v : Double) -> MlfeatureplsPath {
  let result = ml_feature_pls_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_path_sum(s : MlfeatureplsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_path_mean(s : MlfeatureplsPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_path_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_path_scale(s : MlfeatureplsPath, f : Double) -> MlfeatureplsPath {
  let result = ml_feature_pls_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_path_add(a : MlfeatureplsPath, b : MlfeatureplsPath) -> MlfeatureplsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_path_copy(s : MlfeatureplsPath) -> MlfeatureplsPath {
  let result = ml_feature_pls_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_path_fill(s : MlfeatureplsPath, v : Double) -> MlfeatureplsPath {
  let result = ml_feature_pls_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_path_min(s : MlfeatureplsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_path_max(s : MlfeatureplsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_path_to_string(s : MlfeatureplsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_cluster_make(size : Int) -> MlfeatureplsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_cluster_len(s : MlfeatureplsCluster) -> Int { s.size }

pub fn ml_feature_pls_cluster_get(s : MlfeatureplsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_cluster_set(s : MlfeatureplsCluster, i : Int, v : Double) -> MlfeatureplsCluster {
  let result = ml_feature_pls_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_cluster_sum(s : MlfeatureplsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_cluster_mean(s : MlfeatureplsCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_cluster_scale(s : MlfeatureplsCluster, f : Double) -> MlfeatureplsCluster {
  let result = ml_feature_pls_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_cluster_add(a : MlfeatureplsCluster, b : MlfeatureplsCluster) -> MlfeatureplsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_cluster_copy(s : MlfeatureplsCluster) -> MlfeatureplsCluster {
  let result = ml_feature_pls_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_cluster_fill(s : MlfeatureplsCluster, v : Double) -> MlfeatureplsCluster {
  let result = ml_feature_pls_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_cluster_min(s : MlfeatureplsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_cluster_max(s : MlfeatureplsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_cluster_to_string(s : MlfeatureplsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_model_make(size : Int) -> MlfeatureplsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_model_len(s : MlfeatureplsModel) -> Int { s.size }

pub fn ml_feature_pls_model_get(s : MlfeatureplsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_model_set(s : MlfeatureplsModel, i : Int, v : Double) -> MlfeatureplsModel {
  let result = ml_feature_pls_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_model_sum(s : MlfeatureplsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_model_mean(s : MlfeatureplsModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_model_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_model_scale(s : MlfeatureplsModel, f : Double) -> MlfeatureplsModel {
  let result = ml_feature_pls_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_model_add(a : MlfeatureplsModel, b : MlfeatureplsModel) -> MlfeatureplsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_model_copy(s : MlfeatureplsModel) -> MlfeatureplsModel {
  let result = ml_feature_pls_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_model_fill(s : MlfeatureplsModel, v : Double) -> MlfeatureplsModel {
  let result = ml_feature_pls_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_model_min(s : MlfeatureplsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_model_max(s : MlfeatureplsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_model_to_string(s : MlfeatureplsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_layer_make(size : Int) -> MlfeatureplsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_layer_len(s : MlfeatureplsLayer) -> Int { s.size }

pub fn ml_feature_pls_layer_get(s : MlfeatureplsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_layer_set(s : MlfeatureplsLayer, i : Int, v : Double) -> MlfeatureplsLayer {
  let result = ml_feature_pls_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_layer_sum(s : MlfeatureplsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_layer_mean(s : MlfeatureplsLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_layer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_layer_scale(s : MlfeatureplsLayer, f : Double) -> MlfeatureplsLayer {
  let result = ml_feature_pls_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_layer_add(a : MlfeatureplsLayer, b : MlfeatureplsLayer) -> MlfeatureplsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_layer_copy(s : MlfeatureplsLayer) -> MlfeatureplsLayer {
  let result = ml_feature_pls_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_layer_fill(s : MlfeatureplsLayer, v : Double) -> MlfeatureplsLayer {
  let result = ml_feature_pls_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_layer_min(s : MlfeatureplsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_layer_max(s : MlfeatureplsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_layer_to_string(s : MlfeatureplsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_buffer_make(size : Int) -> MlfeatureplsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_buffer_len(s : MlfeatureplsBuffer) -> Int { s.size }

pub fn ml_feature_pls_buffer_get(s : MlfeatureplsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_buffer_set(s : MlfeatureplsBuffer, i : Int, v : Double) -> MlfeatureplsBuffer {
  let result = ml_feature_pls_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_buffer_sum(s : MlfeatureplsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_buffer_mean(s : MlfeatureplsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_buffer_scale(s : MlfeatureplsBuffer, f : Double) -> MlfeatureplsBuffer {
  let result = ml_feature_pls_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_buffer_add(a : MlfeatureplsBuffer, b : MlfeatureplsBuffer) -> MlfeatureplsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_buffer_copy(s : MlfeatureplsBuffer) -> MlfeatureplsBuffer {
  let result = ml_feature_pls_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_buffer_fill(s : MlfeatureplsBuffer, v : Double) -> MlfeatureplsBuffer {
  let result = ml_feature_pls_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_buffer_min(s : MlfeatureplsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_buffer_max(s : MlfeatureplsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_buffer_to_string(s : MlfeatureplsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_cursor_make(size : Int) -> MlfeatureplsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_cursor_len(s : MlfeatureplsCursor) -> Int { s.size }

pub fn ml_feature_pls_cursor_get(s : MlfeatureplsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_cursor_set(s : MlfeatureplsCursor, i : Int, v : Double) -> MlfeatureplsCursor {
  let result = ml_feature_pls_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_cursor_sum(s : MlfeatureplsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_cursor_mean(s : MlfeatureplsCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_cursor_scale(s : MlfeatureplsCursor, f : Double) -> MlfeatureplsCursor {
  let result = ml_feature_pls_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_cursor_add(a : MlfeatureplsCursor, b : MlfeatureplsCursor) -> MlfeatureplsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_cursor_copy(s : MlfeatureplsCursor) -> MlfeatureplsCursor {
  let result = ml_feature_pls_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_cursor_fill(s : MlfeatureplsCursor, v : Double) -> MlfeatureplsCursor {
  let result = ml_feature_pls_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_cursor_min(s : MlfeatureplsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_cursor_max(s : MlfeatureplsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_cursor_to_string(s : MlfeatureplsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_view_make(size : Int) -> MlfeatureplsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_view_len(s : MlfeatureplsView) -> Int { s.size }

pub fn ml_feature_pls_view_get(s : MlfeatureplsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_view_set(s : MlfeatureplsView, i : Int, v : Double) -> MlfeatureplsView {
  let result = ml_feature_pls_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_view_sum(s : MlfeatureplsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_view_mean(s : MlfeatureplsView) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_view_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_view_scale(s : MlfeatureplsView, f : Double) -> MlfeatureplsView {
  let result = ml_feature_pls_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_view_add(a : MlfeatureplsView, b : MlfeatureplsView) -> MlfeatureplsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_view_copy(s : MlfeatureplsView) -> MlfeatureplsView {
  let result = ml_feature_pls_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_view_fill(s : MlfeatureplsView, v : Double) -> MlfeatureplsView {
  let result = ml_feature_pls_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_view_min(s : MlfeatureplsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_view_max(s : MlfeatureplsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_view_to_string(s : MlfeatureplsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_range_make(size : Int) -> MlfeatureplsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_range_len(s : MlfeatureplsRange) -> Int { s.size }

pub fn ml_feature_pls_range_get(s : MlfeatureplsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_range_set(s : MlfeatureplsRange, i : Int, v : Double) -> MlfeatureplsRange {
  let result = ml_feature_pls_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_range_sum(s : MlfeatureplsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_range_mean(s : MlfeatureplsRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_range_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_range_scale(s : MlfeatureplsRange, f : Double) -> MlfeatureplsRange {
  let result = ml_feature_pls_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_range_add(a : MlfeatureplsRange, b : MlfeatureplsRange) -> MlfeatureplsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_range_copy(s : MlfeatureplsRange) -> MlfeatureplsRange {
  let result = ml_feature_pls_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_range_fill(s : MlfeatureplsRange, v : Double) -> MlfeatureplsRange {
  let result = ml_feature_pls_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_range_min(s : MlfeatureplsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_range_max(s : MlfeatureplsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_range_to_string(s : MlfeatureplsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureplsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pls_slice_make(size : Int) -> MlfeatureplsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pls_slice_len(s : MlfeatureplsSlice) -> Int { s.size }

pub fn ml_feature_pls_slice_get(s : MlfeatureplsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pls_slice_set(s : MlfeatureplsSlice, i : Int, v : Double) -> MlfeatureplsSlice {
  let result = ml_feature_pls_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_slice_sum(s : MlfeatureplsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pls_slice_mean(s : MlfeatureplsSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pls_slice_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pls_slice_scale(s : MlfeatureplsSlice, f : Double) -> MlfeatureplsSlice {
  let result = ml_feature_pls_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pls_slice_add(a : MlfeatureplsSlice, b : MlfeatureplsSlice) -> MlfeatureplsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pls_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pls_slice_copy(s : MlfeatureplsSlice) -> MlfeatureplsSlice {
  let result = ml_feature_pls_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pls_slice_fill(s : MlfeatureplsSlice, v : Double) -> MlfeatureplsSlice {
  let result = ml_feature_pls_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pls_slice_min(s : MlfeatureplsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_slice_max(s : MlfeatureplsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pls_slice_to_string(s : MlfeatureplsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

