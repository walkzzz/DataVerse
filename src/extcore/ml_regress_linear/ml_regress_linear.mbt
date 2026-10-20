///===
/// extcore/ml_regress_linear

pub(all) struct MlregresslinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_linear_make_point(x : Double, y : Double) -> MlregresslinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_linear_make_point3(x : Double, y : Double, z : Double) -> MlregresslinearPoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_linear_point_x(pt : MlregresslinearPoint) -> Double { pt.x }

pub fn ml_regress_linear_point_y(pt : MlregresslinearPoint) -> Double { pt.y }

pub fn ml_regress_linear_point_z(pt : MlregresslinearPoint) -> Double { pt.z }

pub fn ml_regress_linear_point_label(pt : MlregresslinearPoint) -> Int { pt.label }

pub fn ml_regress_linear_point_dist(a : MlregresslinearPoint, b : MlregresslinearPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_linear_point_add(a : MlregresslinearPoint, b : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_linear_point_sub(a : MlregresslinearPoint, b : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_linear_point_scale(pt : MlregresslinearPoint, s : Double) -> MlregresslinearPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_linear_point_dot(a : MlregresslinearPoint, b : MlregresslinearPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_linear_point_cross(a : MlregresslinearPoint, b : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_linear_point_norm(pt : MlregresslinearPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_linear_point_normalize(pt : MlregresslinearPoint) -> MlregresslinearPoint {
  let n = ml_regress_linear_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_linear_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_linear_point_negate(pt : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_linear_point_mid(a : MlregresslinearPoint, b : MlregresslinearPoint) -> MlregresslinearPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_linear_point_lerp(a : MlregresslinearPoint, b : MlregresslinearPoint, t : Double) -> MlregresslinearPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_linear_point_to_string(pt : MlregresslinearPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregresslinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_linear_make_series(vals : Array[Double], name : String) -> MlregresslinearSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_linear_series_len(s : MlregresslinearSeries) -> Int { s.vals.length() }

pub fn ml_regress_linear_series_sum(s : MlregresslinearSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_regress_linear_series_mean(s : MlregresslinearSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_regress_linear_series_min(s : MlregresslinearSeries) -> Double { @_common.min(s.vals) }

pub fn ml_regress_linear_series_max(s : MlregresslinearSeries) -> Double { @_common.max(s.vals) }

pub fn ml_regress_linear_series_range(s : MlregresslinearSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_regress_linear_series_var(s : MlregresslinearSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_regress_linear_series_std(s : MlregresslinearSeries) -> Double { @_common.std(s.vals) }

pub fn ml_regress_linear_series_median(s : MlregresslinearSeries) -> Double { @_common.median(s.vals) }

pub fn ml_regress_linear_series_scale(s : MlregresslinearSeries, f : Double) -> MlregresslinearSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_linear_series_add(a : MlregresslinearSeries, b : MlregresslinearSeries) -> MlregresslinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_linear_series_sub(a : MlregresslinearSeries, b : MlregresslinearSeries) -> MlregresslinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_linear_series_normalize(s : MlregresslinearSeries) -> MlregresslinearSeries {
  let mn = ml_regress_linear_series_min(s)
  let mx = ml_regress_linear_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_linear_series_cumsum(s : MlregresslinearSeries) -> MlregresslinearSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_linear_series_to_string(s : MlregresslinearSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_linear_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresslinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_linear_matrix_identity(n : Int) -> MlregresslinearMatrix {
  let m = ml_regress_linear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_linear_matrix_get(m : MlregresslinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_linear_matrix_transpose(m : MlregresslinearMatrix) -> MlregresslinearMatrix {
  let result = ml_regress_linear_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_linear_matrix_add(a : MlregresslinearMatrix, b : MlregresslinearMatrix) -> MlregresslinearMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_linear_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_linear_matrix_scale(m : MlregresslinearMatrix, s : Double) -> MlregresslinearMatrix {
  let result = ml_regress_linear_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_linear_matrix_multiply(a : MlregresslinearMatrix, b : MlregresslinearMatrix) -> MlregresslinearMatrix {
  if a.cols != b.rows { return ml_regress_linear_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_linear_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_linear_matrix_trace(m : MlregresslinearMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_linear_matrix_det(m : MlregresslinearMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_linear_matrix_norm(m : MlregresslinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_regress_linear_matrix_to_string(m : MlregresslinearMatrix) -> String {
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

pub(all) struct MlregresslinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_linear_make_vector(comps : Array[Double]) -> MlregresslinearVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_linear_vector_zero(dim : Int) -> MlregresslinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_linear_vector_add(a : MlregresslinearVector, b : MlregresslinearVector) -> MlregresslinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_linear_vector_sub(a : MlregresslinearVector, b : MlregresslinearVector) -> MlregresslinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_linear_vector_scale(v : MlregresslinearVector, s : Double) -> MlregresslinearVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_linear_vector_dot(a : MlregresslinearVector, b : MlregresslinearVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_linear_vector_norm(v : MlregresslinearVector) -> Double { @_common.sqrt(ml_regress_linear_vector_dot(v, v)) }

pub fn ml_regress_linear_vector_normalize(v : MlregresslinearVector) -> MlregresslinearVector {
  let n = ml_regress_linear_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_linear_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_linear_vector_dist(a : MlregresslinearVector, b : MlregresslinearVector) -> Double {
  ml_regress_linear_vector_norm(ml_regress_linear_vector_sub(a, b))
}

pub fn ml_regress_linear_vector_to_string(v : MlregresslinearVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_linear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_linear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_linear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_linear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_linear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_linear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_linear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_linear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_linear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_linear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_linear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_linear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_linear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_linear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_linear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_linear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_linear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_linear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_linear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_linear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_linear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_linear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_linear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_linear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_linear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_linear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_linear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_linear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_linear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresslinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_frame_make(size : Int) -> MlregresslinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_frame_len(s : MlregresslinearFrame) -> Int { s.size }

pub fn ml_regress_linear_frame_get(s : MlregresslinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_frame_set(s : MlregresslinearFrame, i : Int, v : Double) -> MlregresslinearFrame {
  let result = ml_regress_linear_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_frame_sum(s : MlregresslinearFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_frame_mean(s : MlregresslinearFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_frame_scale(s : MlregresslinearFrame, f : Double) -> MlregresslinearFrame {
  let result = ml_regress_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_frame_add(a : MlregresslinearFrame, b : MlregresslinearFrame) -> MlregresslinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_frame_copy(s : MlregresslinearFrame) -> MlregresslinearFrame {
  let result = ml_regress_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_frame_fill(s : MlregresslinearFrame, v : Double) -> MlregresslinearFrame {
  let result = ml_regress_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_frame_min(s : MlregresslinearFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_frame_max(s : MlregresslinearFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_frame_to_string(s : MlregresslinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_table_make(size : Int) -> MlregresslinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_table_len(s : MlregresslinearTable) -> Int { s.size }

pub fn ml_regress_linear_table_get(s : MlregresslinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_table_set(s : MlregresslinearTable, i : Int, v : Double) -> MlregresslinearTable {
  let result = ml_regress_linear_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_table_sum(s : MlregresslinearTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_table_mean(s : MlregresslinearTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_table_scale(s : MlregresslinearTable, f : Double) -> MlregresslinearTable {
  let result = ml_regress_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_table_add(a : MlregresslinearTable, b : MlregresslinearTable) -> MlregresslinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_table_copy(s : MlregresslinearTable) -> MlregresslinearTable {
  let result = ml_regress_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_table_fill(s : MlregresslinearTable, v : Double) -> MlregresslinearTable {
  let result = ml_regress_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_table_min(s : MlregresslinearTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_table_max(s : MlregresslinearTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_table_to_string(s : MlregresslinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_graphn_make(size : Int) -> MlregresslinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_graphn_len(s : MlregresslinearGraphN) -> Int { s.size }

pub fn ml_regress_linear_graphn_get(s : MlregresslinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_graphn_set(s : MlregresslinearGraphN, i : Int, v : Double) -> MlregresslinearGraphN {
  let result = ml_regress_linear_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_graphn_sum(s : MlregresslinearGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_graphn_mean(s : MlregresslinearGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_graphn_scale(s : MlregresslinearGraphN, f : Double) -> MlregresslinearGraphN {
  let result = ml_regress_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_graphn_add(a : MlregresslinearGraphN, b : MlregresslinearGraphN) -> MlregresslinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_graphn_copy(s : MlregresslinearGraphN) -> MlregresslinearGraphN {
  let result = ml_regress_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_graphn_fill(s : MlregresslinearGraphN, v : Double) -> MlregresslinearGraphN {
  let result = ml_regress_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_graphn_min(s : MlregresslinearGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_graphn_max(s : MlregresslinearGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_graphn_to_string(s : MlregresslinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_node_make(size : Int) -> MlregresslinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_node_len(s : MlregresslinearNode) -> Int { s.size }

pub fn ml_regress_linear_node_get(s : MlregresslinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_node_set(s : MlregresslinearNode, i : Int, v : Double) -> MlregresslinearNode {
  let result = ml_regress_linear_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_node_sum(s : MlregresslinearNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_node_mean(s : MlregresslinearNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_node_scale(s : MlregresslinearNode, f : Double) -> MlregresslinearNode {
  let result = ml_regress_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_node_add(a : MlregresslinearNode, b : MlregresslinearNode) -> MlregresslinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_node_copy(s : MlregresslinearNode) -> MlregresslinearNode {
  let result = ml_regress_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_node_fill(s : MlregresslinearNode, v : Double) -> MlregresslinearNode {
  let result = ml_regress_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_node_min(s : MlregresslinearNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_node_max(s : MlregresslinearNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_node_to_string(s : MlregresslinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_edge_make(size : Int) -> MlregresslinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_edge_len(s : MlregresslinearEdge) -> Int { s.size }

pub fn ml_regress_linear_edge_get(s : MlregresslinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_edge_set(s : MlregresslinearEdge, i : Int, v : Double) -> MlregresslinearEdge {
  let result = ml_regress_linear_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_edge_sum(s : MlregresslinearEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_edge_mean(s : MlregresslinearEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_edge_scale(s : MlregresslinearEdge, f : Double) -> MlregresslinearEdge {
  let result = ml_regress_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_edge_add(a : MlregresslinearEdge, b : MlregresslinearEdge) -> MlregresslinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_edge_copy(s : MlregresslinearEdge) -> MlregresslinearEdge {
  let result = ml_regress_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_edge_fill(s : MlregresslinearEdge, v : Double) -> MlregresslinearEdge {
  let result = ml_regress_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_edge_min(s : MlregresslinearEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_edge_max(s : MlregresslinearEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_edge_to_string(s : MlregresslinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_path_make(size : Int) -> MlregresslinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_path_len(s : MlregresslinearPath) -> Int { s.size }

pub fn ml_regress_linear_path_get(s : MlregresslinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_path_set(s : MlregresslinearPath, i : Int, v : Double) -> MlregresslinearPath {
  let result = ml_regress_linear_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_path_sum(s : MlregresslinearPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_path_mean(s : MlregresslinearPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_path_scale(s : MlregresslinearPath, f : Double) -> MlregresslinearPath {
  let result = ml_regress_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_path_add(a : MlregresslinearPath, b : MlregresslinearPath) -> MlregresslinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_path_copy(s : MlregresslinearPath) -> MlregresslinearPath {
  let result = ml_regress_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_path_fill(s : MlregresslinearPath, v : Double) -> MlregresslinearPath {
  let result = ml_regress_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_path_min(s : MlregresslinearPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_path_max(s : MlregresslinearPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_path_to_string(s : MlregresslinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_cluster_make(size : Int) -> MlregresslinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_cluster_len(s : MlregresslinearCluster) -> Int { s.size }

pub fn ml_regress_linear_cluster_get(s : MlregresslinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_cluster_set(s : MlregresslinearCluster, i : Int, v : Double) -> MlregresslinearCluster {
  let result = ml_regress_linear_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_cluster_sum(s : MlregresslinearCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_cluster_mean(s : MlregresslinearCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_cluster_scale(s : MlregresslinearCluster, f : Double) -> MlregresslinearCluster {
  let result = ml_regress_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_cluster_add(a : MlregresslinearCluster, b : MlregresslinearCluster) -> MlregresslinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_cluster_copy(s : MlregresslinearCluster) -> MlregresslinearCluster {
  let result = ml_regress_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_cluster_fill(s : MlregresslinearCluster, v : Double) -> MlregresslinearCluster {
  let result = ml_regress_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_cluster_min(s : MlregresslinearCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_cluster_max(s : MlregresslinearCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_cluster_to_string(s : MlregresslinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_model_make(size : Int) -> MlregresslinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_model_len(s : MlregresslinearModel) -> Int { s.size }

pub fn ml_regress_linear_model_get(s : MlregresslinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_model_set(s : MlregresslinearModel, i : Int, v : Double) -> MlregresslinearModel {
  let result = ml_regress_linear_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_model_sum(s : MlregresslinearModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_model_mean(s : MlregresslinearModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_model_scale(s : MlregresslinearModel, f : Double) -> MlregresslinearModel {
  let result = ml_regress_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_model_add(a : MlregresslinearModel, b : MlregresslinearModel) -> MlregresslinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_model_copy(s : MlregresslinearModel) -> MlregresslinearModel {
  let result = ml_regress_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_model_fill(s : MlregresslinearModel, v : Double) -> MlregresslinearModel {
  let result = ml_regress_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_model_min(s : MlregresslinearModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_model_max(s : MlregresslinearModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_model_to_string(s : MlregresslinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_layer_make(size : Int) -> MlregresslinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_layer_len(s : MlregresslinearLayer) -> Int { s.size }

pub fn ml_regress_linear_layer_get(s : MlregresslinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_layer_set(s : MlregresslinearLayer, i : Int, v : Double) -> MlregresslinearLayer {
  let result = ml_regress_linear_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_layer_sum(s : MlregresslinearLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_layer_mean(s : MlregresslinearLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_layer_scale(s : MlregresslinearLayer, f : Double) -> MlregresslinearLayer {
  let result = ml_regress_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_layer_add(a : MlregresslinearLayer, b : MlregresslinearLayer) -> MlregresslinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_layer_copy(s : MlregresslinearLayer) -> MlregresslinearLayer {
  let result = ml_regress_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_layer_fill(s : MlregresslinearLayer, v : Double) -> MlregresslinearLayer {
  let result = ml_regress_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_layer_min(s : MlregresslinearLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_layer_max(s : MlregresslinearLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_layer_to_string(s : MlregresslinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_buffer_make(size : Int) -> MlregresslinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_buffer_len(s : MlregresslinearBuffer) -> Int { s.size }

pub fn ml_regress_linear_buffer_get(s : MlregresslinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_buffer_set(s : MlregresslinearBuffer, i : Int, v : Double) -> MlregresslinearBuffer {
  let result = ml_regress_linear_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_buffer_sum(s : MlregresslinearBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_buffer_mean(s : MlregresslinearBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_buffer_scale(s : MlregresslinearBuffer, f : Double) -> MlregresslinearBuffer {
  let result = ml_regress_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_buffer_add(a : MlregresslinearBuffer, b : MlregresslinearBuffer) -> MlregresslinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_buffer_copy(s : MlregresslinearBuffer) -> MlregresslinearBuffer {
  let result = ml_regress_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_buffer_fill(s : MlregresslinearBuffer, v : Double) -> MlregresslinearBuffer {
  let result = ml_regress_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_buffer_min(s : MlregresslinearBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_buffer_max(s : MlregresslinearBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_buffer_to_string(s : MlregresslinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_cursor_make(size : Int) -> MlregresslinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_cursor_len(s : MlregresslinearCursor) -> Int { s.size }

pub fn ml_regress_linear_cursor_get(s : MlregresslinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_cursor_set(s : MlregresslinearCursor, i : Int, v : Double) -> MlregresslinearCursor {
  let result = ml_regress_linear_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_cursor_sum(s : MlregresslinearCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_cursor_mean(s : MlregresslinearCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_cursor_scale(s : MlregresslinearCursor, f : Double) -> MlregresslinearCursor {
  let result = ml_regress_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_cursor_add(a : MlregresslinearCursor, b : MlregresslinearCursor) -> MlregresslinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_cursor_copy(s : MlregresslinearCursor) -> MlregresslinearCursor {
  let result = ml_regress_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_cursor_fill(s : MlregresslinearCursor, v : Double) -> MlregresslinearCursor {
  let result = ml_regress_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_cursor_min(s : MlregresslinearCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_cursor_max(s : MlregresslinearCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_cursor_to_string(s : MlregresslinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_view_make(size : Int) -> MlregresslinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_view_len(s : MlregresslinearView) -> Int { s.size }

pub fn ml_regress_linear_view_get(s : MlregresslinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_view_set(s : MlregresslinearView, i : Int, v : Double) -> MlregresslinearView {
  let result = ml_regress_linear_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_view_sum(s : MlregresslinearView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_view_mean(s : MlregresslinearView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_view_scale(s : MlregresslinearView, f : Double) -> MlregresslinearView {
  let result = ml_regress_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_view_add(a : MlregresslinearView, b : MlregresslinearView) -> MlregresslinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_view_copy(s : MlregresslinearView) -> MlregresslinearView {
  let result = ml_regress_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_view_fill(s : MlregresslinearView, v : Double) -> MlregresslinearView {
  let result = ml_regress_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_view_min(s : MlregresslinearView) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_view_max(s : MlregresslinearView) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_view_to_string(s : MlregresslinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_range_make(size : Int) -> MlregresslinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_range_len(s : MlregresslinearRange) -> Int { s.size }

pub fn ml_regress_linear_range_get(s : MlregresslinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_range_set(s : MlregresslinearRange, i : Int, v : Double) -> MlregresslinearRange {
  let result = ml_regress_linear_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_range_sum(s : MlregresslinearRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_range_mean(s : MlregresslinearRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_range_scale(s : MlregresslinearRange, f : Double) -> MlregresslinearRange {
  let result = ml_regress_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_range_add(a : MlregresslinearRange, b : MlregresslinearRange) -> MlregresslinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_range_copy(s : MlregresslinearRange) -> MlregresslinearRange {
  let result = ml_regress_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_range_fill(s : MlregresslinearRange, v : Double) -> MlregresslinearRange {
  let result = ml_regress_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_range_min(s : MlregresslinearRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_range_max(s : MlregresslinearRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_range_to_string(s : MlregresslinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_linear_slice_make(size : Int) -> MlregresslinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_linear_slice_len(s : MlregresslinearSlice) -> Int { s.size }

pub fn ml_regress_linear_slice_get(s : MlregresslinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_linear_slice_set(s : MlregresslinearSlice, i : Int, v : Double) -> MlregresslinearSlice {
  let result = ml_regress_linear_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_slice_sum(s : MlregresslinearSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_linear_slice_mean(s : MlregresslinearSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_linear_slice_scale(s : MlregresslinearSlice, f : Double) -> MlregresslinearSlice {
  let result = ml_regress_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_linear_slice_add(a : MlregresslinearSlice, b : MlregresslinearSlice) -> MlregresslinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_linear_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_linear_slice_copy(s : MlregresslinearSlice) -> MlregresslinearSlice {
  let result = ml_regress_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_linear_slice_fill(s : MlregresslinearSlice, v : Double) -> MlregresslinearSlice {
  let result = ml_regress_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_linear_slice_min(s : MlregresslinearSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_linear_slice_max(s : MlregresslinearSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_linear_slice_to_string(s : MlregresslinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

