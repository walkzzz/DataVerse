///===
/// extcore/ml_feature_factor

pub(all) struct MlfeaturefactorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_factor_make_point(x : Double, y : Double) -> MlfeaturefactorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_factor_make_point3(x : Double, y : Double, z : Double) -> MlfeaturefactorPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_factor_point_x(pt : MlfeaturefactorPoint) -> Double { pt.x }

pub fn ml_feature_factor_point_y(pt : MlfeaturefactorPoint) -> Double { pt.y }

pub fn ml_feature_factor_point_z(pt : MlfeaturefactorPoint) -> Double { pt.z }

pub fn ml_feature_factor_point_label(pt : MlfeaturefactorPoint) -> Int { pt.label }

pub fn ml_feature_factor_point_dist(a : MlfeaturefactorPoint, b : MlfeaturefactorPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_factor_point_add(a : MlfeaturefactorPoint, b : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_factor_point_sub(a : MlfeaturefactorPoint, b : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_factor_point_scale(pt : MlfeaturefactorPoint, s : Double) -> MlfeaturefactorPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_factor_point_dot(a : MlfeaturefactorPoint, b : MlfeaturefactorPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_factor_point_cross(a : MlfeaturefactorPoint, b : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_factor_point_norm(pt : MlfeaturefactorPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_factor_point_normalize(pt : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  let n = ml_feature_factor_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_factor_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_factor_point_negate(pt : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_factor_point_mid(a : MlfeaturefactorPoint, b : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_factor_point_lerp(a : MlfeaturefactorPoint, b : MlfeaturefactorPoint, t : Double) -> MlfeaturefactorPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_factor_point_to_string(pt : MlfeaturefactorPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeaturefactorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_factor_make_series(vals : Array[Double], name : String) -> MlfeaturefactorSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_factor_series_len(s : MlfeaturefactorSeries) -> Int { s.vals.length() }

pub fn ml_feature_factor_series_sum(s : MlfeaturefactorSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_feature_factor_series_mean(s : MlfeaturefactorSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_feature_factor_series_min(s : MlfeaturefactorSeries) -> Double { @_common.min(s.vals) }

pub fn ml_feature_factor_series_max(s : MlfeaturefactorSeries) -> Double { @_common.max(s.vals) }

pub fn ml_feature_factor_series_range(s : MlfeaturefactorSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_feature_factor_series_var(s : MlfeaturefactorSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_feature_factor_series_std(s : MlfeaturefactorSeries) -> Double { @_common.std(s.vals) }

pub fn ml_feature_factor_series_median(s : MlfeaturefactorSeries) -> Double { @_common.median(s.vals) }

pub fn ml_feature_factor_series_scale(s : MlfeaturefactorSeries, f : Double) -> MlfeaturefactorSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_feature_factor_series_add(a : MlfeaturefactorSeries, b : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_factor_series_sub(a : MlfeaturefactorSeries, b : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_factor_series_normalize(s : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  let mn = ml_feature_factor_series_min(s)
  let mx = ml_feature_factor_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_factor_series_cumsum(s : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_factor_series_to_string(s : MlfeaturefactorSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturefactorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_factor_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturefactorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_factor_matrix_identity(n : Int) -> MlfeaturefactorMatrix {
  let m = ml_feature_factor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_factor_matrix_get(m : MlfeaturefactorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_factor_matrix_transpose(m : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  let result = ml_feature_factor_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_factor_matrix_add(a : MlfeaturefactorMatrix, b : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_factor_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_factor_matrix_scale(m : MlfeaturefactorMatrix, s : Double) -> MlfeaturefactorMatrix {
  let result = ml_feature_factor_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_factor_matrix_multiply(a : MlfeaturefactorMatrix, b : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  if a.cols != b.rows { return ml_feature_factor_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_factor_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_factor_matrix_trace(m : MlfeaturefactorMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_factor_matrix_det(m : MlfeaturefactorMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_factor_matrix_norm(m : MlfeaturefactorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_feature_factor_matrix_to_string(m : MlfeaturefactorMatrix) -> String {
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

pub(all) struct MlfeaturefactorVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_factor_make_vector(comps : Array[Double]) -> MlfeaturefactorVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_factor_vector_zero(dim : Int) -> MlfeaturefactorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_factor_vector_add(a : MlfeaturefactorVector, b : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_factor_vector_sub(a : MlfeaturefactorVector, b : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_factor_vector_scale(v : MlfeaturefactorVector, s : Double) -> MlfeaturefactorVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_feature_factor_vector_dot(a : MlfeaturefactorVector, b : MlfeaturefactorVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_factor_vector_norm(v : MlfeaturefactorVector) -> Double { @_common.sqrt(ml_feature_factor_vector_dot(v, v)) }

pub fn ml_feature_factor_vector_normalize(v : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = ml_feature_factor_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_factor_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_factor_vector_dist(a : MlfeaturefactorVector, b : MlfeaturefactorVector) -> Double {
  ml_feature_factor_vector_norm(ml_feature_factor_vector_sub(a, b))
}

pub fn ml_feature_factor_vector_to_string(v : MlfeaturefactorVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_factor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_factor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_factor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_factor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_factor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_factor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_factor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_factor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_factor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_factor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_factor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_factor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_factor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_factor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_factor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_factor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_factor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_factor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_factor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_factor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_factor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_factor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_factor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_factor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_factor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_factor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_factor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_factor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_factor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturefactorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_frame_make(size : Int) -> MlfeaturefactorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_frame_len(s : MlfeaturefactorFrame) -> Int { s.size }

pub fn ml_feature_factor_frame_get(s : MlfeaturefactorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_frame_set(s : MlfeaturefactorFrame, i : Int, v : Double) -> MlfeaturefactorFrame {
  let result = ml_feature_factor_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_frame_sum(s : MlfeaturefactorFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_frame_mean(s : MlfeaturefactorFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_frame_scale(s : MlfeaturefactorFrame, f : Double) -> MlfeaturefactorFrame {
  let result = ml_feature_factor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_frame_add(a : MlfeaturefactorFrame, b : MlfeaturefactorFrame) -> MlfeaturefactorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_frame_copy(s : MlfeaturefactorFrame) -> MlfeaturefactorFrame {
  let result = ml_feature_factor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_frame_fill(s : MlfeaturefactorFrame, v : Double) -> MlfeaturefactorFrame {
  let result = ml_feature_factor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_frame_min(s : MlfeaturefactorFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_frame_max(s : MlfeaturefactorFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_frame_to_string(s : MlfeaturefactorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_table_make(size : Int) -> MlfeaturefactorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_table_len(s : MlfeaturefactorTable) -> Int { s.size }

pub fn ml_feature_factor_table_get(s : MlfeaturefactorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_table_set(s : MlfeaturefactorTable, i : Int, v : Double) -> MlfeaturefactorTable {
  let result = ml_feature_factor_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_table_sum(s : MlfeaturefactorTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_table_mean(s : MlfeaturefactorTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_table_scale(s : MlfeaturefactorTable, f : Double) -> MlfeaturefactorTable {
  let result = ml_feature_factor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_table_add(a : MlfeaturefactorTable, b : MlfeaturefactorTable) -> MlfeaturefactorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_table_copy(s : MlfeaturefactorTable) -> MlfeaturefactorTable {
  let result = ml_feature_factor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_table_fill(s : MlfeaturefactorTable, v : Double) -> MlfeaturefactorTable {
  let result = ml_feature_factor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_table_min(s : MlfeaturefactorTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_table_max(s : MlfeaturefactorTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_table_to_string(s : MlfeaturefactorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_graphn_make(size : Int) -> MlfeaturefactorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_graphn_len(s : MlfeaturefactorGraphN) -> Int { s.size }

pub fn ml_feature_factor_graphn_get(s : MlfeaturefactorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_graphn_set(s : MlfeaturefactorGraphN, i : Int, v : Double) -> MlfeaturefactorGraphN {
  let result = ml_feature_factor_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_graphn_sum(s : MlfeaturefactorGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_graphn_mean(s : MlfeaturefactorGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_graphn_scale(s : MlfeaturefactorGraphN, f : Double) -> MlfeaturefactorGraphN {
  let result = ml_feature_factor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_graphn_add(a : MlfeaturefactorGraphN, b : MlfeaturefactorGraphN) -> MlfeaturefactorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_graphn_copy(s : MlfeaturefactorGraphN) -> MlfeaturefactorGraphN {
  let result = ml_feature_factor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_graphn_fill(s : MlfeaturefactorGraphN, v : Double) -> MlfeaturefactorGraphN {
  let result = ml_feature_factor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_graphn_min(s : MlfeaturefactorGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_graphn_max(s : MlfeaturefactorGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_graphn_to_string(s : MlfeaturefactorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_node_make(size : Int) -> MlfeaturefactorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_node_len(s : MlfeaturefactorNode) -> Int { s.size }

pub fn ml_feature_factor_node_get(s : MlfeaturefactorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_node_set(s : MlfeaturefactorNode, i : Int, v : Double) -> MlfeaturefactorNode {
  let result = ml_feature_factor_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_node_sum(s : MlfeaturefactorNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_node_mean(s : MlfeaturefactorNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_node_scale(s : MlfeaturefactorNode, f : Double) -> MlfeaturefactorNode {
  let result = ml_feature_factor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_node_add(a : MlfeaturefactorNode, b : MlfeaturefactorNode) -> MlfeaturefactorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_node_copy(s : MlfeaturefactorNode) -> MlfeaturefactorNode {
  let result = ml_feature_factor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_node_fill(s : MlfeaturefactorNode, v : Double) -> MlfeaturefactorNode {
  let result = ml_feature_factor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_node_min(s : MlfeaturefactorNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_node_max(s : MlfeaturefactorNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_node_to_string(s : MlfeaturefactorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_edge_make(size : Int) -> MlfeaturefactorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_edge_len(s : MlfeaturefactorEdge) -> Int { s.size }

pub fn ml_feature_factor_edge_get(s : MlfeaturefactorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_edge_set(s : MlfeaturefactorEdge, i : Int, v : Double) -> MlfeaturefactorEdge {
  let result = ml_feature_factor_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_edge_sum(s : MlfeaturefactorEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_edge_mean(s : MlfeaturefactorEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_edge_scale(s : MlfeaturefactorEdge, f : Double) -> MlfeaturefactorEdge {
  let result = ml_feature_factor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_edge_add(a : MlfeaturefactorEdge, b : MlfeaturefactorEdge) -> MlfeaturefactorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_edge_copy(s : MlfeaturefactorEdge) -> MlfeaturefactorEdge {
  let result = ml_feature_factor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_edge_fill(s : MlfeaturefactorEdge, v : Double) -> MlfeaturefactorEdge {
  let result = ml_feature_factor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_edge_min(s : MlfeaturefactorEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_edge_max(s : MlfeaturefactorEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_edge_to_string(s : MlfeaturefactorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_path_make(size : Int) -> MlfeaturefactorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_path_len(s : MlfeaturefactorPath) -> Int { s.size }

pub fn ml_feature_factor_path_get(s : MlfeaturefactorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_path_set(s : MlfeaturefactorPath, i : Int, v : Double) -> MlfeaturefactorPath {
  let result = ml_feature_factor_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_path_sum(s : MlfeaturefactorPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_path_mean(s : MlfeaturefactorPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_path_scale(s : MlfeaturefactorPath, f : Double) -> MlfeaturefactorPath {
  let result = ml_feature_factor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_path_add(a : MlfeaturefactorPath, b : MlfeaturefactorPath) -> MlfeaturefactorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_path_copy(s : MlfeaturefactorPath) -> MlfeaturefactorPath {
  let result = ml_feature_factor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_path_fill(s : MlfeaturefactorPath, v : Double) -> MlfeaturefactorPath {
  let result = ml_feature_factor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_path_min(s : MlfeaturefactorPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_path_max(s : MlfeaturefactorPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_path_to_string(s : MlfeaturefactorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_cluster_make(size : Int) -> MlfeaturefactorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_cluster_len(s : MlfeaturefactorCluster) -> Int { s.size }

pub fn ml_feature_factor_cluster_get(s : MlfeaturefactorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_cluster_set(s : MlfeaturefactorCluster, i : Int, v : Double) -> MlfeaturefactorCluster {
  let result = ml_feature_factor_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_cluster_sum(s : MlfeaturefactorCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_cluster_mean(s : MlfeaturefactorCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_cluster_scale(s : MlfeaturefactorCluster, f : Double) -> MlfeaturefactorCluster {
  let result = ml_feature_factor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_cluster_add(a : MlfeaturefactorCluster, b : MlfeaturefactorCluster) -> MlfeaturefactorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_cluster_copy(s : MlfeaturefactorCluster) -> MlfeaturefactorCluster {
  let result = ml_feature_factor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_cluster_fill(s : MlfeaturefactorCluster, v : Double) -> MlfeaturefactorCluster {
  let result = ml_feature_factor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_cluster_min(s : MlfeaturefactorCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_cluster_max(s : MlfeaturefactorCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_cluster_to_string(s : MlfeaturefactorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_model_make(size : Int) -> MlfeaturefactorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_model_len(s : MlfeaturefactorModel) -> Int { s.size }

pub fn ml_feature_factor_model_get(s : MlfeaturefactorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_model_set(s : MlfeaturefactorModel, i : Int, v : Double) -> MlfeaturefactorModel {
  let result = ml_feature_factor_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_model_sum(s : MlfeaturefactorModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_model_mean(s : MlfeaturefactorModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_model_scale(s : MlfeaturefactorModel, f : Double) -> MlfeaturefactorModel {
  let result = ml_feature_factor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_model_add(a : MlfeaturefactorModel, b : MlfeaturefactorModel) -> MlfeaturefactorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_model_copy(s : MlfeaturefactorModel) -> MlfeaturefactorModel {
  let result = ml_feature_factor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_model_fill(s : MlfeaturefactorModel, v : Double) -> MlfeaturefactorModel {
  let result = ml_feature_factor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_model_min(s : MlfeaturefactorModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_model_max(s : MlfeaturefactorModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_model_to_string(s : MlfeaturefactorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_layer_make(size : Int) -> MlfeaturefactorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_layer_len(s : MlfeaturefactorLayer) -> Int { s.size }

pub fn ml_feature_factor_layer_get(s : MlfeaturefactorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_layer_set(s : MlfeaturefactorLayer, i : Int, v : Double) -> MlfeaturefactorLayer {
  let result = ml_feature_factor_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_layer_sum(s : MlfeaturefactorLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_layer_mean(s : MlfeaturefactorLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_layer_scale(s : MlfeaturefactorLayer, f : Double) -> MlfeaturefactorLayer {
  let result = ml_feature_factor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_layer_add(a : MlfeaturefactorLayer, b : MlfeaturefactorLayer) -> MlfeaturefactorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_layer_copy(s : MlfeaturefactorLayer) -> MlfeaturefactorLayer {
  let result = ml_feature_factor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_layer_fill(s : MlfeaturefactorLayer, v : Double) -> MlfeaturefactorLayer {
  let result = ml_feature_factor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_layer_min(s : MlfeaturefactorLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_layer_max(s : MlfeaturefactorLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_layer_to_string(s : MlfeaturefactorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_buffer_make(size : Int) -> MlfeaturefactorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_buffer_len(s : MlfeaturefactorBuffer) -> Int { s.size }

pub fn ml_feature_factor_buffer_get(s : MlfeaturefactorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_buffer_set(s : MlfeaturefactorBuffer, i : Int, v : Double) -> MlfeaturefactorBuffer {
  let result = ml_feature_factor_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_buffer_sum(s : MlfeaturefactorBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_buffer_mean(s : MlfeaturefactorBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_buffer_scale(s : MlfeaturefactorBuffer, f : Double) -> MlfeaturefactorBuffer {
  let result = ml_feature_factor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_buffer_add(a : MlfeaturefactorBuffer, b : MlfeaturefactorBuffer) -> MlfeaturefactorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_buffer_copy(s : MlfeaturefactorBuffer) -> MlfeaturefactorBuffer {
  let result = ml_feature_factor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_buffer_fill(s : MlfeaturefactorBuffer, v : Double) -> MlfeaturefactorBuffer {
  let result = ml_feature_factor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_buffer_min(s : MlfeaturefactorBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_buffer_max(s : MlfeaturefactorBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_buffer_to_string(s : MlfeaturefactorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_cursor_make(size : Int) -> MlfeaturefactorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_cursor_len(s : MlfeaturefactorCursor) -> Int { s.size }

pub fn ml_feature_factor_cursor_get(s : MlfeaturefactorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_cursor_set(s : MlfeaturefactorCursor, i : Int, v : Double) -> MlfeaturefactorCursor {
  let result = ml_feature_factor_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_cursor_sum(s : MlfeaturefactorCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_cursor_mean(s : MlfeaturefactorCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_cursor_scale(s : MlfeaturefactorCursor, f : Double) -> MlfeaturefactorCursor {
  let result = ml_feature_factor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_cursor_add(a : MlfeaturefactorCursor, b : MlfeaturefactorCursor) -> MlfeaturefactorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_cursor_copy(s : MlfeaturefactorCursor) -> MlfeaturefactorCursor {
  let result = ml_feature_factor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_cursor_fill(s : MlfeaturefactorCursor, v : Double) -> MlfeaturefactorCursor {
  let result = ml_feature_factor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_cursor_min(s : MlfeaturefactorCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_cursor_max(s : MlfeaturefactorCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_cursor_to_string(s : MlfeaturefactorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_view_make(size : Int) -> MlfeaturefactorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_view_len(s : MlfeaturefactorView) -> Int { s.size }

pub fn ml_feature_factor_view_get(s : MlfeaturefactorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_view_set(s : MlfeaturefactorView, i : Int, v : Double) -> MlfeaturefactorView {
  let result = ml_feature_factor_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_view_sum(s : MlfeaturefactorView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_view_mean(s : MlfeaturefactorView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_view_scale(s : MlfeaturefactorView, f : Double) -> MlfeaturefactorView {
  let result = ml_feature_factor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_view_add(a : MlfeaturefactorView, b : MlfeaturefactorView) -> MlfeaturefactorView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_view_copy(s : MlfeaturefactorView) -> MlfeaturefactorView {
  let result = ml_feature_factor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_view_fill(s : MlfeaturefactorView, v : Double) -> MlfeaturefactorView {
  let result = ml_feature_factor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_view_min(s : MlfeaturefactorView) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_view_max(s : MlfeaturefactorView) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_view_to_string(s : MlfeaturefactorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_range_make(size : Int) -> MlfeaturefactorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_range_len(s : MlfeaturefactorRange) -> Int { s.size }

pub fn ml_feature_factor_range_get(s : MlfeaturefactorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_range_set(s : MlfeaturefactorRange, i : Int, v : Double) -> MlfeaturefactorRange {
  let result = ml_feature_factor_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_range_sum(s : MlfeaturefactorRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_range_mean(s : MlfeaturefactorRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_range_scale(s : MlfeaturefactorRange, f : Double) -> MlfeaturefactorRange {
  let result = ml_feature_factor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_range_add(a : MlfeaturefactorRange, b : MlfeaturefactorRange) -> MlfeaturefactorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_range_copy(s : MlfeaturefactorRange) -> MlfeaturefactorRange {
  let result = ml_feature_factor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_range_fill(s : MlfeaturefactorRange, v : Double) -> MlfeaturefactorRange {
  let result = ml_feature_factor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_range_min(s : MlfeaturefactorRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_range_max(s : MlfeaturefactorRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_range_to_string(s : MlfeaturefactorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_slice_make(size : Int) -> MlfeaturefactorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_slice_len(s : MlfeaturefactorSlice) -> Int { s.size }

pub fn ml_feature_factor_slice_get(s : MlfeaturefactorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_slice_set(s : MlfeaturefactorSlice, i : Int, v : Double) -> MlfeaturefactorSlice {
  let result = ml_feature_factor_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_slice_sum(s : MlfeaturefactorSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_slice_mean(s : MlfeaturefactorSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_slice_scale(s : MlfeaturefactorSlice, f : Double) -> MlfeaturefactorSlice {
  let result = ml_feature_factor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_factor_slice_add(a : MlfeaturefactorSlice, b : MlfeaturefactorSlice) -> MlfeaturefactorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_factor_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_factor_slice_copy(s : MlfeaturefactorSlice) -> MlfeaturefactorSlice {
  let result = ml_feature_factor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_factor_slice_fill(s : MlfeaturefactorSlice, v : Double) -> MlfeaturefactorSlice {
  let result = ml_feature_factor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_factor_slice_min(s : MlfeaturefactorSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_slice_max(s : MlfeaturefactorSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_slice_to_string(s : MlfeaturefactorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

