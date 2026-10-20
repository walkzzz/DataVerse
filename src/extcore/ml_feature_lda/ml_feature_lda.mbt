///===
/// extcore/ml_feature_lda

pub(all) struct MlfeatureldaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_lda_make_point(x : Double, y : Double) -> MlfeatureldaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_lda_make_point3(x : Double, y : Double, z : Double) -> MlfeatureldaPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_lda_point_x(pt : MlfeatureldaPoint) -> Double { pt.x }

pub fn ml_feature_lda_point_y(pt : MlfeatureldaPoint) -> Double { pt.y }

pub fn ml_feature_lda_point_z(pt : MlfeatureldaPoint) -> Double { pt.z }

pub fn ml_feature_lda_point_label(pt : MlfeatureldaPoint) -> Int { pt.label }

pub fn ml_feature_lda_point_dist(a : MlfeatureldaPoint, b : MlfeatureldaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_lda_point_add(a : MlfeatureldaPoint, b : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_lda_point_sub(a : MlfeatureldaPoint, b : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_lda_point_scale(pt : MlfeatureldaPoint, s : Double) -> MlfeatureldaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_lda_point_dot(a : MlfeatureldaPoint, b : MlfeatureldaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_lda_point_cross(a : MlfeatureldaPoint, b : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_lda_point_norm(pt : MlfeatureldaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_lda_point_normalize(pt : MlfeatureldaPoint) -> MlfeatureldaPoint {
  let n = ml_feature_lda_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_lda_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_lda_point_negate(pt : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_lda_point_mid(a : MlfeatureldaPoint, b : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_lda_point_lerp(a : MlfeatureldaPoint, b : MlfeatureldaPoint, t : Double) -> MlfeatureldaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_lda_point_to_string(pt : MlfeatureldaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeatureldaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_lda_make_series(vals : Array[Double], name : String) -> MlfeatureldaSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_lda_series_len(s : MlfeatureldaSeries) -> Int { s.vals.length() }

pub fn ml_feature_lda_series_sum(s : MlfeatureldaSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_feature_lda_series_mean(s : MlfeatureldaSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_feature_lda_series_min(s : MlfeatureldaSeries) -> Double { @_common.min(s.vals) }

pub fn ml_feature_lda_series_max(s : MlfeatureldaSeries) -> Double { @_common.max(s.vals) }

pub fn ml_feature_lda_series_range(s : MlfeatureldaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_feature_lda_series_var(s : MlfeatureldaSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_feature_lda_series_std(s : MlfeatureldaSeries) -> Double { @_common.std(s.vals) }

pub fn ml_feature_lda_series_median(s : MlfeatureldaSeries) -> Double { @_common.median(s.vals) }

pub fn ml_feature_lda_series_scale(s : MlfeatureldaSeries, f : Double) -> MlfeatureldaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_feature_lda_series_add(a : MlfeatureldaSeries, b : MlfeatureldaSeries) -> MlfeatureldaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_lda_series_sub(a : MlfeatureldaSeries, b : MlfeatureldaSeries) -> MlfeatureldaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_lda_series_normalize(s : MlfeatureldaSeries) -> MlfeatureldaSeries {
  let mn = ml_feature_lda_series_min(s)
  let mx = ml_feature_lda_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_lda_series_cumsum(s : MlfeatureldaSeries) -> MlfeatureldaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_lda_series_to_string(s : MlfeatureldaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureldaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_lda_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureldaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_lda_matrix_identity(n : Int) -> MlfeatureldaMatrix {
  let m = ml_feature_lda_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_lda_matrix_get(m : MlfeatureldaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_lda_matrix_transpose(m : MlfeatureldaMatrix) -> MlfeatureldaMatrix {
  let result = ml_feature_lda_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_lda_matrix_add(a : MlfeatureldaMatrix, b : MlfeatureldaMatrix) -> MlfeatureldaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_lda_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_lda_matrix_scale(m : MlfeatureldaMatrix, s : Double) -> MlfeatureldaMatrix {
  let result = ml_feature_lda_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_lda_matrix_multiply(a : MlfeatureldaMatrix, b : MlfeatureldaMatrix) -> MlfeatureldaMatrix {
  if a.cols != b.rows { return ml_feature_lda_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_lda_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_lda_matrix_trace(m : MlfeatureldaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_lda_matrix_det(m : MlfeatureldaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_lda_matrix_norm(m : MlfeatureldaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_feature_lda_matrix_to_string(m : MlfeatureldaMatrix) -> String {
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

pub(all) struct MlfeatureldaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_lda_make_vector(comps : Array[Double]) -> MlfeatureldaVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_lda_vector_zero(dim : Int) -> MlfeatureldaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_lda_vector_add(a : MlfeatureldaVector, b : MlfeatureldaVector) -> MlfeatureldaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_lda_vector_sub(a : MlfeatureldaVector, b : MlfeatureldaVector) -> MlfeatureldaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_lda_vector_scale(v : MlfeatureldaVector, s : Double) -> MlfeatureldaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_feature_lda_vector_dot(a : MlfeatureldaVector, b : MlfeatureldaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_lda_vector_norm(v : MlfeatureldaVector) -> Double { @_common.sqrt(ml_feature_lda_vector_dot(v, v)) }

pub fn ml_feature_lda_vector_normalize(v : MlfeatureldaVector) -> MlfeatureldaVector {
  let n = ml_feature_lda_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_lda_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_lda_vector_dist(a : MlfeatureldaVector, b : MlfeatureldaVector) -> Double {
  ml_feature_lda_vector_norm(ml_feature_lda_vector_sub(a, b))
}

pub fn ml_feature_lda_vector_to_string(v : MlfeatureldaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_lda_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_lda_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_lda_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_lda_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_lda_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_lda_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_lda_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_lda_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_lda_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_lda_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_lda_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_lda_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_lda_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_lda_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_lda_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_lda_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_lda_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_lda_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_lda_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_lda_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_lda_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_lda_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_lda_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_lda_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_lda_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_lda_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_lda_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_lda_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_lda_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureldaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_frame_make(size : Int) -> MlfeatureldaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_frame_len(s : MlfeatureldaFrame) -> Int { s.size }

pub fn ml_feature_lda_frame_get(s : MlfeatureldaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_frame_set(s : MlfeatureldaFrame, i : Int, v : Double) -> MlfeatureldaFrame {
  let result = ml_feature_lda_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_frame_sum(s : MlfeatureldaFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_frame_mean(s : MlfeatureldaFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_frame_scale(s : MlfeatureldaFrame, f : Double) -> MlfeatureldaFrame {
  let result = ml_feature_lda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_frame_add(a : MlfeatureldaFrame, b : MlfeatureldaFrame) -> MlfeatureldaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_frame_copy(s : MlfeatureldaFrame) -> MlfeatureldaFrame {
  let result = ml_feature_lda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_frame_fill(s : MlfeatureldaFrame, v : Double) -> MlfeatureldaFrame {
  let result = ml_feature_lda_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_frame_min(s : MlfeatureldaFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_frame_max(s : MlfeatureldaFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_frame_to_string(s : MlfeatureldaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_table_make(size : Int) -> MlfeatureldaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_table_len(s : MlfeatureldaTable) -> Int { s.size }

pub fn ml_feature_lda_table_get(s : MlfeatureldaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_table_set(s : MlfeatureldaTable, i : Int, v : Double) -> MlfeatureldaTable {
  let result = ml_feature_lda_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_table_sum(s : MlfeatureldaTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_table_mean(s : MlfeatureldaTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_table_scale(s : MlfeatureldaTable, f : Double) -> MlfeatureldaTable {
  let result = ml_feature_lda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_table_add(a : MlfeatureldaTable, b : MlfeatureldaTable) -> MlfeatureldaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_table_copy(s : MlfeatureldaTable) -> MlfeatureldaTable {
  let result = ml_feature_lda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_table_fill(s : MlfeatureldaTable, v : Double) -> MlfeatureldaTable {
  let result = ml_feature_lda_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_table_min(s : MlfeatureldaTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_table_max(s : MlfeatureldaTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_table_to_string(s : MlfeatureldaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_graphn_make(size : Int) -> MlfeatureldaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_graphn_len(s : MlfeatureldaGraphN) -> Int { s.size }

pub fn ml_feature_lda_graphn_get(s : MlfeatureldaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_graphn_set(s : MlfeatureldaGraphN, i : Int, v : Double) -> MlfeatureldaGraphN {
  let result = ml_feature_lda_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_graphn_sum(s : MlfeatureldaGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_graphn_mean(s : MlfeatureldaGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_graphn_scale(s : MlfeatureldaGraphN, f : Double) -> MlfeatureldaGraphN {
  let result = ml_feature_lda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_graphn_add(a : MlfeatureldaGraphN, b : MlfeatureldaGraphN) -> MlfeatureldaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_graphn_copy(s : MlfeatureldaGraphN) -> MlfeatureldaGraphN {
  let result = ml_feature_lda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_graphn_fill(s : MlfeatureldaGraphN, v : Double) -> MlfeatureldaGraphN {
  let result = ml_feature_lda_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_graphn_min(s : MlfeatureldaGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_graphn_max(s : MlfeatureldaGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_graphn_to_string(s : MlfeatureldaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_node_make(size : Int) -> MlfeatureldaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_node_len(s : MlfeatureldaNode) -> Int { s.size }

pub fn ml_feature_lda_node_get(s : MlfeatureldaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_node_set(s : MlfeatureldaNode, i : Int, v : Double) -> MlfeatureldaNode {
  let result = ml_feature_lda_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_node_sum(s : MlfeatureldaNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_node_mean(s : MlfeatureldaNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_node_scale(s : MlfeatureldaNode, f : Double) -> MlfeatureldaNode {
  let result = ml_feature_lda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_node_add(a : MlfeatureldaNode, b : MlfeatureldaNode) -> MlfeatureldaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_node_copy(s : MlfeatureldaNode) -> MlfeatureldaNode {
  let result = ml_feature_lda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_node_fill(s : MlfeatureldaNode, v : Double) -> MlfeatureldaNode {
  let result = ml_feature_lda_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_node_min(s : MlfeatureldaNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_node_max(s : MlfeatureldaNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_node_to_string(s : MlfeatureldaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_edge_make(size : Int) -> MlfeatureldaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_edge_len(s : MlfeatureldaEdge) -> Int { s.size }

pub fn ml_feature_lda_edge_get(s : MlfeatureldaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_edge_set(s : MlfeatureldaEdge, i : Int, v : Double) -> MlfeatureldaEdge {
  let result = ml_feature_lda_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_edge_sum(s : MlfeatureldaEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_edge_mean(s : MlfeatureldaEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_edge_scale(s : MlfeatureldaEdge, f : Double) -> MlfeatureldaEdge {
  let result = ml_feature_lda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_edge_add(a : MlfeatureldaEdge, b : MlfeatureldaEdge) -> MlfeatureldaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_edge_copy(s : MlfeatureldaEdge) -> MlfeatureldaEdge {
  let result = ml_feature_lda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_edge_fill(s : MlfeatureldaEdge, v : Double) -> MlfeatureldaEdge {
  let result = ml_feature_lda_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_edge_min(s : MlfeatureldaEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_edge_max(s : MlfeatureldaEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_edge_to_string(s : MlfeatureldaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_path_make(size : Int) -> MlfeatureldaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_path_len(s : MlfeatureldaPath) -> Int { s.size }

pub fn ml_feature_lda_path_get(s : MlfeatureldaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_path_set(s : MlfeatureldaPath, i : Int, v : Double) -> MlfeatureldaPath {
  let result = ml_feature_lda_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_path_sum(s : MlfeatureldaPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_path_mean(s : MlfeatureldaPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_path_scale(s : MlfeatureldaPath, f : Double) -> MlfeatureldaPath {
  let result = ml_feature_lda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_path_add(a : MlfeatureldaPath, b : MlfeatureldaPath) -> MlfeatureldaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_path_copy(s : MlfeatureldaPath) -> MlfeatureldaPath {
  let result = ml_feature_lda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_path_fill(s : MlfeatureldaPath, v : Double) -> MlfeatureldaPath {
  let result = ml_feature_lda_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_path_min(s : MlfeatureldaPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_path_max(s : MlfeatureldaPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_path_to_string(s : MlfeatureldaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_cluster_make(size : Int) -> MlfeatureldaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_cluster_len(s : MlfeatureldaCluster) -> Int { s.size }

pub fn ml_feature_lda_cluster_get(s : MlfeatureldaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_cluster_set(s : MlfeatureldaCluster, i : Int, v : Double) -> MlfeatureldaCluster {
  let result = ml_feature_lda_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_cluster_sum(s : MlfeatureldaCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_cluster_mean(s : MlfeatureldaCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_cluster_scale(s : MlfeatureldaCluster, f : Double) -> MlfeatureldaCluster {
  let result = ml_feature_lda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_cluster_add(a : MlfeatureldaCluster, b : MlfeatureldaCluster) -> MlfeatureldaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_cluster_copy(s : MlfeatureldaCluster) -> MlfeatureldaCluster {
  let result = ml_feature_lda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_cluster_fill(s : MlfeatureldaCluster, v : Double) -> MlfeatureldaCluster {
  let result = ml_feature_lda_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_cluster_min(s : MlfeatureldaCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_cluster_max(s : MlfeatureldaCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_cluster_to_string(s : MlfeatureldaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_model_make(size : Int) -> MlfeatureldaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_model_len(s : MlfeatureldaModel) -> Int { s.size }

pub fn ml_feature_lda_model_get(s : MlfeatureldaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_model_set(s : MlfeatureldaModel, i : Int, v : Double) -> MlfeatureldaModel {
  let result = ml_feature_lda_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_model_sum(s : MlfeatureldaModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_model_mean(s : MlfeatureldaModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_model_scale(s : MlfeatureldaModel, f : Double) -> MlfeatureldaModel {
  let result = ml_feature_lda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_model_add(a : MlfeatureldaModel, b : MlfeatureldaModel) -> MlfeatureldaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_model_copy(s : MlfeatureldaModel) -> MlfeatureldaModel {
  let result = ml_feature_lda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_model_fill(s : MlfeatureldaModel, v : Double) -> MlfeatureldaModel {
  let result = ml_feature_lda_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_model_min(s : MlfeatureldaModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_model_max(s : MlfeatureldaModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_model_to_string(s : MlfeatureldaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_layer_make(size : Int) -> MlfeatureldaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_layer_len(s : MlfeatureldaLayer) -> Int { s.size }

pub fn ml_feature_lda_layer_get(s : MlfeatureldaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_layer_set(s : MlfeatureldaLayer, i : Int, v : Double) -> MlfeatureldaLayer {
  let result = ml_feature_lda_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_layer_sum(s : MlfeatureldaLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_layer_mean(s : MlfeatureldaLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_layer_scale(s : MlfeatureldaLayer, f : Double) -> MlfeatureldaLayer {
  let result = ml_feature_lda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_layer_add(a : MlfeatureldaLayer, b : MlfeatureldaLayer) -> MlfeatureldaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_layer_copy(s : MlfeatureldaLayer) -> MlfeatureldaLayer {
  let result = ml_feature_lda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_layer_fill(s : MlfeatureldaLayer, v : Double) -> MlfeatureldaLayer {
  let result = ml_feature_lda_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_layer_min(s : MlfeatureldaLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_layer_max(s : MlfeatureldaLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_layer_to_string(s : MlfeatureldaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_buffer_make(size : Int) -> MlfeatureldaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_buffer_len(s : MlfeatureldaBuffer) -> Int { s.size }

pub fn ml_feature_lda_buffer_get(s : MlfeatureldaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_buffer_set(s : MlfeatureldaBuffer, i : Int, v : Double) -> MlfeatureldaBuffer {
  let result = ml_feature_lda_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_buffer_sum(s : MlfeatureldaBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_buffer_mean(s : MlfeatureldaBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_buffer_scale(s : MlfeatureldaBuffer, f : Double) -> MlfeatureldaBuffer {
  let result = ml_feature_lda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_buffer_add(a : MlfeatureldaBuffer, b : MlfeatureldaBuffer) -> MlfeatureldaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_buffer_copy(s : MlfeatureldaBuffer) -> MlfeatureldaBuffer {
  let result = ml_feature_lda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_buffer_fill(s : MlfeatureldaBuffer, v : Double) -> MlfeatureldaBuffer {
  let result = ml_feature_lda_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_buffer_min(s : MlfeatureldaBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_buffer_max(s : MlfeatureldaBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_buffer_to_string(s : MlfeatureldaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_cursor_make(size : Int) -> MlfeatureldaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_cursor_len(s : MlfeatureldaCursor) -> Int { s.size }

pub fn ml_feature_lda_cursor_get(s : MlfeatureldaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_cursor_set(s : MlfeatureldaCursor, i : Int, v : Double) -> MlfeatureldaCursor {
  let result = ml_feature_lda_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_cursor_sum(s : MlfeatureldaCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_cursor_mean(s : MlfeatureldaCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_cursor_scale(s : MlfeatureldaCursor, f : Double) -> MlfeatureldaCursor {
  let result = ml_feature_lda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_cursor_add(a : MlfeatureldaCursor, b : MlfeatureldaCursor) -> MlfeatureldaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_cursor_copy(s : MlfeatureldaCursor) -> MlfeatureldaCursor {
  let result = ml_feature_lda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_cursor_fill(s : MlfeatureldaCursor, v : Double) -> MlfeatureldaCursor {
  let result = ml_feature_lda_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_cursor_min(s : MlfeatureldaCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_cursor_max(s : MlfeatureldaCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_cursor_to_string(s : MlfeatureldaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_view_make(size : Int) -> MlfeatureldaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_view_len(s : MlfeatureldaView) -> Int { s.size }

pub fn ml_feature_lda_view_get(s : MlfeatureldaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_view_set(s : MlfeatureldaView, i : Int, v : Double) -> MlfeatureldaView {
  let result = ml_feature_lda_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_view_sum(s : MlfeatureldaView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_view_mean(s : MlfeatureldaView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_view_scale(s : MlfeatureldaView, f : Double) -> MlfeatureldaView {
  let result = ml_feature_lda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_view_add(a : MlfeatureldaView, b : MlfeatureldaView) -> MlfeatureldaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_view_copy(s : MlfeatureldaView) -> MlfeatureldaView {
  let result = ml_feature_lda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_view_fill(s : MlfeatureldaView, v : Double) -> MlfeatureldaView {
  let result = ml_feature_lda_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_view_min(s : MlfeatureldaView) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_view_max(s : MlfeatureldaView) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_view_to_string(s : MlfeatureldaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_range_make(size : Int) -> MlfeatureldaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_range_len(s : MlfeatureldaRange) -> Int { s.size }

pub fn ml_feature_lda_range_get(s : MlfeatureldaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_range_set(s : MlfeatureldaRange, i : Int, v : Double) -> MlfeatureldaRange {
  let result = ml_feature_lda_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_range_sum(s : MlfeatureldaRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_range_mean(s : MlfeatureldaRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_range_scale(s : MlfeatureldaRange, f : Double) -> MlfeatureldaRange {
  let result = ml_feature_lda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_range_add(a : MlfeatureldaRange, b : MlfeatureldaRange) -> MlfeatureldaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_range_copy(s : MlfeatureldaRange) -> MlfeatureldaRange {
  let result = ml_feature_lda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_range_fill(s : MlfeatureldaRange, v : Double) -> MlfeatureldaRange {
  let result = ml_feature_lda_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_range_min(s : MlfeatureldaRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_range_max(s : MlfeatureldaRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_range_to_string(s : MlfeatureldaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_slice_make(size : Int) -> MlfeatureldaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_slice_len(s : MlfeatureldaSlice) -> Int { s.size }

pub fn ml_feature_lda_slice_get(s : MlfeatureldaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_slice_set(s : MlfeatureldaSlice, i : Int, v : Double) -> MlfeatureldaSlice {
  let result = ml_feature_lda_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_slice_sum(s : MlfeatureldaSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_slice_mean(s : MlfeatureldaSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_slice_scale(s : MlfeatureldaSlice, f : Double) -> MlfeatureldaSlice {
  let result = ml_feature_lda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_lda_slice_add(a : MlfeatureldaSlice, b : MlfeatureldaSlice) -> MlfeatureldaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_lda_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_lda_slice_copy(s : MlfeatureldaSlice) -> MlfeatureldaSlice {
  let result = ml_feature_lda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_lda_slice_fill(s : MlfeatureldaSlice, v : Double) -> MlfeatureldaSlice {
  let result = ml_feature_lda_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_lda_slice_min(s : MlfeatureldaSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_slice_max(s : MlfeatureldaSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_slice_to_string(s : MlfeatureldaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

