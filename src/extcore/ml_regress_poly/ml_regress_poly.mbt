///===
/// extcore/ml_regress_poly

pub(all) struct MlregresspolyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_poly_make_point(x : Double, y : Double) -> MlregresspolyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_poly_make_point3(x : Double, y : Double, z : Double) -> MlregresspolyPoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_poly_point_x(pt : MlregresspolyPoint) -> Double { pt.x }

pub fn ml_regress_poly_point_y(pt : MlregresspolyPoint) -> Double { pt.y }

pub fn ml_regress_poly_point_z(pt : MlregresspolyPoint) -> Double { pt.z }

pub fn ml_regress_poly_point_label(pt : MlregresspolyPoint) -> Int { pt.label }

pub fn ml_regress_poly_point_dist(a : MlregresspolyPoint, b : MlregresspolyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_poly_point_add(a : MlregresspolyPoint, b : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_poly_point_sub(a : MlregresspolyPoint, b : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_poly_point_scale(pt : MlregresspolyPoint, s : Double) -> MlregresspolyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_poly_point_dot(a : MlregresspolyPoint, b : MlregresspolyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_poly_point_cross(a : MlregresspolyPoint, b : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_poly_point_norm(pt : MlregresspolyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_poly_point_normalize(pt : MlregresspolyPoint) -> MlregresspolyPoint {
  let n = ml_regress_poly_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_poly_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_poly_point_negate(pt : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_poly_point_mid(a : MlregresspolyPoint, b : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_poly_point_lerp(a : MlregresspolyPoint, b : MlregresspolyPoint, t : Double) -> MlregresspolyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_poly_point_to_string(pt : MlregresspolyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregresspolySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_poly_make_series(vals : Array[Double], name : String) -> MlregresspolySeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_poly_series_len(s : MlregresspolySeries) -> Int { s.vals.length() }

pub fn ml_regress_poly_series_sum(s : MlregresspolySeries) -> Double { @_common.sum(s.vals) }

pub fn ml_regress_poly_series_mean(s : MlregresspolySeries) -> Double { @_common.mean(s.vals) }

pub fn ml_regress_poly_series_min(s : MlregresspolySeries) -> Double { @_common.min(s.vals) }

pub fn ml_regress_poly_series_max(s : MlregresspolySeries) -> Double { @_common.max(s.vals) }

pub fn ml_regress_poly_series_range(s : MlregresspolySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_regress_poly_series_var(s : MlregresspolySeries) -> Double { @_common.variance(s.vals) }

pub fn ml_regress_poly_series_std(s : MlregresspolySeries) -> Double { @_common.std(s.vals) }

pub fn ml_regress_poly_series_median(s : MlregresspolySeries) -> Double { @_common.median(s.vals) }

pub fn ml_regress_poly_series_scale(s : MlregresspolySeries, f : Double) -> MlregresspolySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_poly_series_add(a : MlregresspolySeries, b : MlregresspolySeries) -> MlregresspolySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_poly_series_sub(a : MlregresspolySeries, b : MlregresspolySeries) -> MlregresspolySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_poly_series_normalize(s : MlregresspolySeries) -> MlregresspolySeries {
  let mn = ml_regress_poly_series_min(s)
  let mx = ml_regress_poly_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_poly_series_cumsum(s : MlregresspolySeries) -> MlregresspolySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_poly_series_to_string(s : MlregresspolySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresspolyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_poly_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresspolyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_poly_matrix_identity(n : Int) -> MlregresspolyMatrix {
  let m = ml_regress_poly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_poly_matrix_get(m : MlregresspolyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_poly_matrix_transpose(m : MlregresspolyMatrix) -> MlregresspolyMatrix {
  let result = ml_regress_poly_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_poly_matrix_add(a : MlregresspolyMatrix, b : MlregresspolyMatrix) -> MlregresspolyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_poly_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_poly_matrix_scale(m : MlregresspolyMatrix, s : Double) -> MlregresspolyMatrix {
  let result = ml_regress_poly_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_poly_matrix_multiply(a : MlregresspolyMatrix, b : MlregresspolyMatrix) -> MlregresspolyMatrix {
  if a.cols != b.rows { return ml_regress_poly_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_poly_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_poly_matrix_trace(m : MlregresspolyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_poly_matrix_det(m : MlregresspolyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_poly_matrix_norm(m : MlregresspolyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_regress_poly_matrix_to_string(m : MlregresspolyMatrix) -> String {
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

pub(all) struct MlregresspolyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_poly_make_vector(comps : Array[Double]) -> MlregresspolyVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_poly_vector_zero(dim : Int) -> MlregresspolyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_poly_vector_add(a : MlregresspolyVector, b : MlregresspolyVector) -> MlregresspolyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_poly_vector_sub(a : MlregresspolyVector, b : MlregresspolyVector) -> MlregresspolyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_poly_vector_scale(v : MlregresspolyVector, s : Double) -> MlregresspolyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_poly_vector_dot(a : MlregresspolyVector, b : MlregresspolyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_poly_vector_norm(v : MlregresspolyVector) -> Double { @_common.sqrt(ml_regress_poly_vector_dot(v, v)) }

pub fn ml_regress_poly_vector_normalize(v : MlregresspolyVector) -> MlregresspolyVector {
  let n = ml_regress_poly_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_poly_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_poly_vector_dist(a : MlregresspolyVector, b : MlregresspolyVector) -> Double {
  ml_regress_poly_vector_norm(ml_regress_poly_vector_sub(a, b))
}

pub fn ml_regress_poly_vector_to_string(v : MlregresspolyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_poly_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_poly_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_poly_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_poly_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_poly_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_poly_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_poly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_poly_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_poly_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_poly_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_poly_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_poly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_poly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_poly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_poly_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_poly_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_poly_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_poly_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_poly_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_poly_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_poly_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_poly_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_poly_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_poly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_poly_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_poly_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_poly_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_poly_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_poly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresspolyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_frame_make(size : Int) -> MlregresspolyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_frame_len(s : MlregresspolyFrame) -> Int { s.size }

pub fn ml_regress_poly_frame_get(s : MlregresspolyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_frame_set(s : MlregresspolyFrame, i : Int, v : Double) -> MlregresspolyFrame {
  let result = ml_regress_poly_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_frame_sum(s : MlregresspolyFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_frame_mean(s : MlregresspolyFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_frame_scale(s : MlregresspolyFrame, f : Double) -> MlregresspolyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_frame_add(a : MlregresspolyFrame, b : MlregresspolyFrame) -> MlregresspolyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_frame_copy(s : MlregresspolyFrame) -> MlregresspolyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_frame_fill(s : MlregresspolyFrame, v : Double) -> MlregresspolyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_frame_min(s : MlregresspolyFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_frame_max(s : MlregresspolyFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_frame_to_string(s : MlregresspolyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_table_make(size : Int) -> MlregresspolyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_table_len(s : MlregresspolyTable) -> Int { s.size }

pub fn ml_regress_poly_table_get(s : MlregresspolyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_table_set(s : MlregresspolyTable, i : Int, v : Double) -> MlregresspolyTable {
  let result = ml_regress_poly_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_table_sum(s : MlregresspolyTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_table_mean(s : MlregresspolyTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_table_scale(s : MlregresspolyTable, f : Double) -> MlregresspolyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_table_add(a : MlregresspolyTable, b : MlregresspolyTable) -> MlregresspolyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_table_copy(s : MlregresspolyTable) -> MlregresspolyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_table_fill(s : MlregresspolyTable, v : Double) -> MlregresspolyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_table_min(s : MlregresspolyTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_table_max(s : MlregresspolyTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_table_to_string(s : MlregresspolyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_graphn_make(size : Int) -> MlregresspolyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_graphn_len(s : MlregresspolyGraphN) -> Int { s.size }

pub fn ml_regress_poly_graphn_get(s : MlregresspolyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_graphn_set(s : MlregresspolyGraphN, i : Int, v : Double) -> MlregresspolyGraphN {
  let result = ml_regress_poly_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_graphn_sum(s : MlregresspolyGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_graphn_mean(s : MlregresspolyGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_graphn_scale(s : MlregresspolyGraphN, f : Double) -> MlregresspolyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_graphn_add(a : MlregresspolyGraphN, b : MlregresspolyGraphN) -> MlregresspolyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_graphn_copy(s : MlregresspolyGraphN) -> MlregresspolyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_graphn_fill(s : MlregresspolyGraphN, v : Double) -> MlregresspolyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_graphn_min(s : MlregresspolyGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_graphn_max(s : MlregresspolyGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_graphn_to_string(s : MlregresspolyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_node_make(size : Int) -> MlregresspolyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_node_len(s : MlregresspolyNode) -> Int { s.size }

pub fn ml_regress_poly_node_get(s : MlregresspolyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_node_set(s : MlregresspolyNode, i : Int, v : Double) -> MlregresspolyNode {
  let result = ml_regress_poly_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_node_sum(s : MlregresspolyNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_node_mean(s : MlregresspolyNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_node_scale(s : MlregresspolyNode, f : Double) -> MlregresspolyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_node_add(a : MlregresspolyNode, b : MlregresspolyNode) -> MlregresspolyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_node_copy(s : MlregresspolyNode) -> MlregresspolyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_node_fill(s : MlregresspolyNode, v : Double) -> MlregresspolyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_node_min(s : MlregresspolyNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_node_max(s : MlregresspolyNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_node_to_string(s : MlregresspolyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_edge_make(size : Int) -> MlregresspolyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_edge_len(s : MlregresspolyEdge) -> Int { s.size }

pub fn ml_regress_poly_edge_get(s : MlregresspolyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_edge_set(s : MlregresspolyEdge, i : Int, v : Double) -> MlregresspolyEdge {
  let result = ml_regress_poly_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_edge_sum(s : MlregresspolyEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_edge_mean(s : MlregresspolyEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_edge_scale(s : MlregresspolyEdge, f : Double) -> MlregresspolyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_edge_add(a : MlregresspolyEdge, b : MlregresspolyEdge) -> MlregresspolyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_edge_copy(s : MlregresspolyEdge) -> MlregresspolyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_edge_fill(s : MlregresspolyEdge, v : Double) -> MlregresspolyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_edge_min(s : MlregresspolyEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_edge_max(s : MlregresspolyEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_edge_to_string(s : MlregresspolyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_path_make(size : Int) -> MlregresspolyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_path_len(s : MlregresspolyPath) -> Int { s.size }

pub fn ml_regress_poly_path_get(s : MlregresspolyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_path_set(s : MlregresspolyPath, i : Int, v : Double) -> MlregresspolyPath {
  let result = ml_regress_poly_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_path_sum(s : MlregresspolyPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_path_mean(s : MlregresspolyPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_path_scale(s : MlregresspolyPath, f : Double) -> MlregresspolyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_path_add(a : MlregresspolyPath, b : MlregresspolyPath) -> MlregresspolyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_path_copy(s : MlregresspolyPath) -> MlregresspolyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_path_fill(s : MlregresspolyPath, v : Double) -> MlregresspolyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_path_min(s : MlregresspolyPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_path_max(s : MlregresspolyPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_path_to_string(s : MlregresspolyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_cluster_make(size : Int) -> MlregresspolyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_cluster_len(s : MlregresspolyCluster) -> Int { s.size }

pub fn ml_regress_poly_cluster_get(s : MlregresspolyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_cluster_set(s : MlregresspolyCluster, i : Int, v : Double) -> MlregresspolyCluster {
  let result = ml_regress_poly_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_cluster_sum(s : MlregresspolyCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_cluster_mean(s : MlregresspolyCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_cluster_scale(s : MlregresspolyCluster, f : Double) -> MlregresspolyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cluster_add(a : MlregresspolyCluster, b : MlregresspolyCluster) -> MlregresspolyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_cluster_copy(s : MlregresspolyCluster) -> MlregresspolyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cluster_fill(s : MlregresspolyCluster, v : Double) -> MlregresspolyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cluster_min(s : MlregresspolyCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_cluster_max(s : MlregresspolyCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_cluster_to_string(s : MlregresspolyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_model_make(size : Int) -> MlregresspolyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_model_len(s : MlregresspolyModel) -> Int { s.size }

pub fn ml_regress_poly_model_get(s : MlregresspolyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_model_set(s : MlregresspolyModel, i : Int, v : Double) -> MlregresspolyModel {
  let result = ml_regress_poly_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_model_sum(s : MlregresspolyModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_model_mean(s : MlregresspolyModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_model_scale(s : MlregresspolyModel, f : Double) -> MlregresspolyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_model_add(a : MlregresspolyModel, b : MlregresspolyModel) -> MlregresspolyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_model_copy(s : MlregresspolyModel) -> MlregresspolyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_model_fill(s : MlregresspolyModel, v : Double) -> MlregresspolyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_model_min(s : MlregresspolyModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_model_max(s : MlregresspolyModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_model_to_string(s : MlregresspolyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_layer_make(size : Int) -> MlregresspolyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_layer_len(s : MlregresspolyLayer) -> Int { s.size }

pub fn ml_regress_poly_layer_get(s : MlregresspolyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_layer_set(s : MlregresspolyLayer, i : Int, v : Double) -> MlregresspolyLayer {
  let result = ml_regress_poly_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_layer_sum(s : MlregresspolyLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_layer_mean(s : MlregresspolyLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_layer_scale(s : MlregresspolyLayer, f : Double) -> MlregresspolyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_layer_add(a : MlregresspolyLayer, b : MlregresspolyLayer) -> MlregresspolyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_layer_copy(s : MlregresspolyLayer) -> MlregresspolyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_layer_fill(s : MlregresspolyLayer, v : Double) -> MlregresspolyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_layer_min(s : MlregresspolyLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_layer_max(s : MlregresspolyLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_layer_to_string(s : MlregresspolyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_buffer_make(size : Int) -> MlregresspolyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_buffer_len(s : MlregresspolyBuffer) -> Int { s.size }

pub fn ml_regress_poly_buffer_get(s : MlregresspolyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_buffer_set(s : MlregresspolyBuffer, i : Int, v : Double) -> MlregresspolyBuffer {
  let result = ml_regress_poly_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_buffer_sum(s : MlregresspolyBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_buffer_mean(s : MlregresspolyBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_buffer_scale(s : MlregresspolyBuffer, f : Double) -> MlregresspolyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_buffer_add(a : MlregresspolyBuffer, b : MlregresspolyBuffer) -> MlregresspolyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_buffer_copy(s : MlregresspolyBuffer) -> MlregresspolyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_buffer_fill(s : MlregresspolyBuffer, v : Double) -> MlregresspolyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_buffer_min(s : MlregresspolyBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_buffer_max(s : MlregresspolyBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_buffer_to_string(s : MlregresspolyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_cursor_make(size : Int) -> MlregresspolyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_cursor_len(s : MlregresspolyCursor) -> Int { s.size }

pub fn ml_regress_poly_cursor_get(s : MlregresspolyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_cursor_set(s : MlregresspolyCursor, i : Int, v : Double) -> MlregresspolyCursor {
  let result = ml_regress_poly_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_cursor_sum(s : MlregresspolyCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_cursor_mean(s : MlregresspolyCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_cursor_scale(s : MlregresspolyCursor, f : Double) -> MlregresspolyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cursor_add(a : MlregresspolyCursor, b : MlregresspolyCursor) -> MlregresspolyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_cursor_copy(s : MlregresspolyCursor) -> MlregresspolyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cursor_fill(s : MlregresspolyCursor, v : Double) -> MlregresspolyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cursor_min(s : MlregresspolyCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_cursor_max(s : MlregresspolyCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_cursor_to_string(s : MlregresspolyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_view_make(size : Int) -> MlregresspolyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_view_len(s : MlregresspolyView) -> Int { s.size }

pub fn ml_regress_poly_view_get(s : MlregresspolyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_view_set(s : MlregresspolyView, i : Int, v : Double) -> MlregresspolyView {
  let result = ml_regress_poly_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_view_sum(s : MlregresspolyView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_view_mean(s : MlregresspolyView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_view_scale(s : MlregresspolyView, f : Double) -> MlregresspolyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_view_add(a : MlregresspolyView, b : MlregresspolyView) -> MlregresspolyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_view_copy(s : MlregresspolyView) -> MlregresspolyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_view_fill(s : MlregresspolyView, v : Double) -> MlregresspolyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_view_min(s : MlregresspolyView) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_view_max(s : MlregresspolyView) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_view_to_string(s : MlregresspolyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_range_make(size : Int) -> MlregresspolyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_range_len(s : MlregresspolyRange) -> Int { s.size }

pub fn ml_regress_poly_range_get(s : MlregresspolyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_range_set(s : MlregresspolyRange, i : Int, v : Double) -> MlregresspolyRange {
  let result = ml_regress_poly_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_range_sum(s : MlregresspolyRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_range_mean(s : MlregresspolyRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_range_scale(s : MlregresspolyRange, f : Double) -> MlregresspolyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_range_add(a : MlregresspolyRange, b : MlregresspolyRange) -> MlregresspolyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_range_copy(s : MlregresspolyRange) -> MlregresspolyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_range_fill(s : MlregresspolyRange, v : Double) -> MlregresspolyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_range_min(s : MlregresspolyRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_range_max(s : MlregresspolyRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_range_to_string(s : MlregresspolyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_slice_make(size : Int) -> MlregresspolySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_slice_len(s : MlregresspolySlice) -> Int { s.size }

pub fn ml_regress_poly_slice_get(s : MlregresspolySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_slice_set(s : MlregresspolySlice, i : Int, v : Double) -> MlregresspolySlice {
  let result = ml_regress_poly_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_poly_slice_sum(s : MlregresspolySlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_slice_mean(s : MlregresspolySlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_slice_scale(s : MlregresspolySlice, f : Double) -> MlregresspolySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_slice_add(a : MlregresspolySlice, b : MlregresspolySlice) -> MlregresspolySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_slice_copy(s : MlregresspolySlice) -> MlregresspolySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_slice_fill(s : MlregresspolySlice, v : Double) -> MlregresspolySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_slice_min(s : MlregresspolySlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_slice_max(s : MlregresspolySlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_slice_to_string(s : MlregresspolySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

