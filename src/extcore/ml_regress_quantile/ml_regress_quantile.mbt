///===
/// extcore/ml_regress_quantile

pub(all) struct MlregressquantilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_quantile_make_point(x : Double, y : Double) -> MlregressquantilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_quantile_make_point3(x : Double, y : Double, z : Double) -> MlregressquantilePoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_quantile_point_x(pt : MlregressquantilePoint) -> Double { pt.x }

pub fn ml_regress_quantile_point_y(pt : MlregressquantilePoint) -> Double { pt.y }

pub fn ml_regress_quantile_point_z(pt : MlregressquantilePoint) -> Double { pt.z }

pub fn ml_regress_quantile_point_label(pt : MlregressquantilePoint) -> Int { pt.label }

pub fn ml_regress_quantile_point_dist(a : MlregressquantilePoint, b : MlregressquantilePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_quantile_point_add(a : MlregressquantilePoint, b : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_quantile_point_sub(a : MlregressquantilePoint, b : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_quantile_point_scale(pt : MlregressquantilePoint, s : Double) -> MlregressquantilePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_quantile_point_dot(a : MlregressquantilePoint, b : MlregressquantilePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_quantile_point_cross(a : MlregressquantilePoint, b : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_quantile_point_norm(pt : MlregressquantilePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_quantile_point_normalize(pt : MlregressquantilePoint) -> MlregressquantilePoint {
  let n = ml_regress_quantile_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_quantile_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_quantile_point_negate(pt : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_quantile_point_mid(a : MlregressquantilePoint, b : MlregressquantilePoint) -> MlregressquantilePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_quantile_point_lerp(a : MlregressquantilePoint, b : MlregressquantilePoint, t : Double) -> MlregressquantilePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_quantile_point_to_string(pt : MlregressquantilePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregressquantileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_quantile_make_series(vals : Array[Double], name : String) -> MlregressquantileSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_quantile_series_len(s : MlregressquantileSeries) -> Int { s.vals.length() }

pub fn ml_regress_quantile_series_sum(s : MlregressquantileSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_regress_quantile_series_mean(s : MlregressquantileSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_regress_quantile_series_min(s : MlregressquantileSeries) -> Double { @_common.min(s.vals) }

pub fn ml_regress_quantile_series_max(s : MlregressquantileSeries) -> Double { @_common.max(s.vals) }

pub fn ml_regress_quantile_series_range(s : MlregressquantileSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_regress_quantile_series_var(s : MlregressquantileSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_regress_quantile_series_std(s : MlregressquantileSeries) -> Double { @_common.std(s.vals) }

pub fn ml_regress_quantile_series_median(s : MlregressquantileSeries) -> Double { @_common.median(s.vals) }

pub fn ml_regress_quantile_series_scale(s : MlregressquantileSeries, f : Double) -> MlregressquantileSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_regress_quantile_series_add(a : MlregressquantileSeries, b : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_quantile_series_sub(a : MlregressquantileSeries, b : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_quantile_series_normalize(s : MlregressquantileSeries) -> MlregressquantileSeries {
  let mn = ml_regress_quantile_series_min(s)
  let mx = ml_regress_quantile_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_quantile_series_cumsum(s : MlregressquantileSeries) -> MlregressquantileSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_quantile_series_to_string(s : MlregressquantileSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressquantileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_quantile_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressquantileMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_quantile_matrix_identity(n : Int) -> MlregressquantileMatrix {
  let m = ml_regress_quantile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_quantile_matrix_get(m : MlregressquantileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_quantile_matrix_transpose(m : MlregressquantileMatrix) -> MlregressquantileMatrix {
  let result = ml_regress_quantile_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_quantile_matrix_add(a : MlregressquantileMatrix, b : MlregressquantileMatrix) -> MlregressquantileMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_quantile_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_quantile_matrix_scale(m : MlregressquantileMatrix, s : Double) -> MlregressquantileMatrix {
  let result = ml_regress_quantile_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_quantile_matrix_multiply(a : MlregressquantileMatrix, b : MlregressquantileMatrix) -> MlregressquantileMatrix {
  if a.cols != b.rows { return ml_regress_quantile_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_quantile_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_quantile_matrix_trace(m : MlregressquantileMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_quantile_matrix_det(m : MlregressquantileMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_quantile_matrix_norm(m : MlregressquantileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_regress_quantile_matrix_to_string(m : MlregressquantileMatrix) -> String {
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

pub(all) struct MlregressquantileVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_quantile_make_vector(comps : Array[Double]) -> MlregressquantileVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_quantile_vector_zero(dim : Int) -> MlregressquantileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_quantile_vector_add(a : MlregressquantileVector, b : MlregressquantileVector) -> MlregressquantileVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_regress_quantile_vector_sub(a : MlregressquantileVector, b : MlregressquantileVector) -> MlregressquantileVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_regress_quantile_vector_scale(v : MlregressquantileVector, s : Double) -> MlregressquantileVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_regress_quantile_vector_dot(a : MlregressquantileVector, b : MlregressquantileVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_quantile_vector_norm(v : MlregressquantileVector) -> Double { @_common.sqrt(ml_regress_quantile_vector_dot(v, v)) }

pub fn ml_regress_quantile_vector_normalize(v : MlregressquantileVector) -> MlregressquantileVector {
  let n = ml_regress_quantile_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_quantile_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_quantile_vector_dist(a : MlregressquantileVector, b : MlregressquantileVector) -> Double {
  ml_regress_quantile_vector_norm(ml_regress_quantile_vector_sub(a, b))
}

pub fn ml_regress_quantile_vector_to_string(v : MlregressquantileVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_quantile_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_quantile_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_quantile_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_quantile_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_quantile_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_quantile_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_quantile_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_quantile_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_quantile_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_quantile_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_quantile_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_quantile_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_quantile_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_quantile_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_quantile_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_quantile_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_quantile_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_quantile_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_quantile_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_quantile_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_quantile_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_quantile_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_quantile_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_quantile_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_quantile_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_quantile_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_quantile_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_quantile_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_quantile_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregressquantileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_frame_make(size : Int) -> MlregressquantileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_frame_len(s : MlregressquantileFrame) -> Int { s.size }

pub fn ml_regress_quantile_frame_get(s : MlregressquantileFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_frame_set(s : MlregressquantileFrame, i : Int, v : Double) -> MlregressquantileFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_frame_sum(s : MlregressquantileFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_frame_mean(s : MlregressquantileFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_frame_scale(s : MlregressquantileFrame, f : Double) -> MlregressquantileFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_frame_add(a : MlregressquantileFrame, b : MlregressquantileFrame) -> MlregressquantileFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_frame_copy(s : MlregressquantileFrame) -> MlregressquantileFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_frame_fill(s : MlregressquantileFrame, v : Double) -> MlregressquantileFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_frame_min(s : MlregressquantileFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_frame_max(s : MlregressquantileFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_frame_to_string(s : MlregressquantileFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_table_make(size : Int) -> MlregressquantileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_table_len(s : MlregressquantileTable) -> Int { s.size }

pub fn ml_regress_quantile_table_get(s : MlregressquantileTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_table_set(s : MlregressquantileTable, i : Int, v : Double) -> MlregressquantileTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_table_sum(s : MlregressquantileTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_table_mean(s : MlregressquantileTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_table_scale(s : MlregressquantileTable, f : Double) -> MlregressquantileTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_table_add(a : MlregressquantileTable, b : MlregressquantileTable) -> MlregressquantileTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_table_copy(s : MlregressquantileTable) -> MlregressquantileTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_table_fill(s : MlregressquantileTable, v : Double) -> MlregressquantileTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_table_min(s : MlregressquantileTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_table_max(s : MlregressquantileTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_table_to_string(s : MlregressquantileTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_graphn_make(size : Int) -> MlregressquantileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_graphn_len(s : MlregressquantileGraphN) -> Int { s.size }

pub fn ml_regress_quantile_graphn_get(s : MlregressquantileGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_graphn_set(s : MlregressquantileGraphN, i : Int, v : Double) -> MlregressquantileGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_graphn_sum(s : MlregressquantileGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_graphn_mean(s : MlregressquantileGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_graphn_scale(s : MlregressquantileGraphN, f : Double) -> MlregressquantileGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_graphn_add(a : MlregressquantileGraphN, b : MlregressquantileGraphN) -> MlregressquantileGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_graphn_copy(s : MlregressquantileGraphN) -> MlregressquantileGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_graphn_fill(s : MlregressquantileGraphN, v : Double) -> MlregressquantileGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_graphn_min(s : MlregressquantileGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_graphn_max(s : MlregressquantileGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_graphn_to_string(s : MlregressquantileGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_node_make(size : Int) -> MlregressquantileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_node_len(s : MlregressquantileNode) -> Int { s.size }

pub fn ml_regress_quantile_node_get(s : MlregressquantileNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_node_set(s : MlregressquantileNode, i : Int, v : Double) -> MlregressquantileNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_node_sum(s : MlregressquantileNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_node_mean(s : MlregressquantileNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_node_scale(s : MlregressquantileNode, f : Double) -> MlregressquantileNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_node_add(a : MlregressquantileNode, b : MlregressquantileNode) -> MlregressquantileNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_node_copy(s : MlregressquantileNode) -> MlregressquantileNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_node_fill(s : MlregressquantileNode, v : Double) -> MlregressquantileNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_node_min(s : MlregressquantileNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_node_max(s : MlregressquantileNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_node_to_string(s : MlregressquantileNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_edge_make(size : Int) -> MlregressquantileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_edge_len(s : MlregressquantileEdge) -> Int { s.size }

pub fn ml_regress_quantile_edge_get(s : MlregressquantileEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_edge_set(s : MlregressquantileEdge, i : Int, v : Double) -> MlregressquantileEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_edge_sum(s : MlregressquantileEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_edge_mean(s : MlregressquantileEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_edge_scale(s : MlregressquantileEdge, f : Double) -> MlregressquantileEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_edge_add(a : MlregressquantileEdge, b : MlregressquantileEdge) -> MlregressquantileEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_edge_copy(s : MlregressquantileEdge) -> MlregressquantileEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_edge_fill(s : MlregressquantileEdge, v : Double) -> MlregressquantileEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_edge_min(s : MlregressquantileEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_edge_max(s : MlregressquantileEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_edge_to_string(s : MlregressquantileEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_path_make(size : Int) -> MlregressquantilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_path_len(s : MlregressquantilePath) -> Int { s.size }

pub fn ml_regress_quantile_path_get(s : MlregressquantilePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_path_set(s : MlregressquantilePath, i : Int, v : Double) -> MlregressquantilePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_path_sum(s : MlregressquantilePath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_path_mean(s : MlregressquantilePath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_path_scale(s : MlregressquantilePath, f : Double) -> MlregressquantilePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_path_add(a : MlregressquantilePath, b : MlregressquantilePath) -> MlregressquantilePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_path_copy(s : MlregressquantilePath) -> MlregressquantilePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_path_fill(s : MlregressquantilePath, v : Double) -> MlregressquantilePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_path_min(s : MlregressquantilePath) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_path_max(s : MlregressquantilePath) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_path_to_string(s : MlregressquantilePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_cluster_make(size : Int) -> MlregressquantileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_cluster_len(s : MlregressquantileCluster) -> Int { s.size }

pub fn ml_regress_quantile_cluster_get(s : MlregressquantileCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_cluster_set(s : MlregressquantileCluster, i : Int, v : Double) -> MlregressquantileCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cluster_sum(s : MlregressquantileCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_cluster_mean(s : MlregressquantileCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_cluster_scale(s : MlregressquantileCluster, f : Double) -> MlregressquantileCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cluster_add(a : MlregressquantileCluster, b : MlregressquantileCluster) -> MlregressquantileCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_cluster_copy(s : MlregressquantileCluster) -> MlregressquantileCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cluster_fill(s : MlregressquantileCluster, v : Double) -> MlregressquantileCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cluster_min(s : MlregressquantileCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_cluster_max(s : MlregressquantileCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_cluster_to_string(s : MlregressquantileCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_model_make(size : Int) -> MlregressquantileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_model_len(s : MlregressquantileModel) -> Int { s.size }

pub fn ml_regress_quantile_model_get(s : MlregressquantileModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_model_set(s : MlregressquantileModel, i : Int, v : Double) -> MlregressquantileModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_model_sum(s : MlregressquantileModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_model_mean(s : MlregressquantileModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_model_scale(s : MlregressquantileModel, f : Double) -> MlregressquantileModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_model_add(a : MlregressquantileModel, b : MlregressquantileModel) -> MlregressquantileModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_model_copy(s : MlregressquantileModel) -> MlregressquantileModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_model_fill(s : MlregressquantileModel, v : Double) -> MlregressquantileModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_model_min(s : MlregressquantileModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_model_max(s : MlregressquantileModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_model_to_string(s : MlregressquantileModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_layer_make(size : Int) -> MlregressquantileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_layer_len(s : MlregressquantileLayer) -> Int { s.size }

pub fn ml_regress_quantile_layer_get(s : MlregressquantileLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_layer_set(s : MlregressquantileLayer, i : Int, v : Double) -> MlregressquantileLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_layer_sum(s : MlregressquantileLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_layer_mean(s : MlregressquantileLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_layer_scale(s : MlregressquantileLayer, f : Double) -> MlregressquantileLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_layer_add(a : MlregressquantileLayer, b : MlregressquantileLayer) -> MlregressquantileLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_layer_copy(s : MlregressquantileLayer) -> MlregressquantileLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_layer_fill(s : MlregressquantileLayer, v : Double) -> MlregressquantileLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_layer_min(s : MlregressquantileLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_layer_max(s : MlregressquantileLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_layer_to_string(s : MlregressquantileLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_buffer_make(size : Int) -> MlregressquantileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_buffer_len(s : MlregressquantileBuffer) -> Int { s.size }

pub fn ml_regress_quantile_buffer_get(s : MlregressquantileBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_buffer_set(s : MlregressquantileBuffer, i : Int, v : Double) -> MlregressquantileBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_buffer_sum(s : MlregressquantileBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_buffer_mean(s : MlregressquantileBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_buffer_scale(s : MlregressquantileBuffer, f : Double) -> MlregressquantileBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_buffer_add(a : MlregressquantileBuffer, b : MlregressquantileBuffer) -> MlregressquantileBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_buffer_copy(s : MlregressquantileBuffer) -> MlregressquantileBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_buffer_fill(s : MlregressquantileBuffer, v : Double) -> MlregressquantileBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_buffer_min(s : MlregressquantileBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_buffer_max(s : MlregressquantileBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_buffer_to_string(s : MlregressquantileBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_cursor_make(size : Int) -> MlregressquantileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_cursor_len(s : MlregressquantileCursor) -> Int { s.size }

pub fn ml_regress_quantile_cursor_get(s : MlregressquantileCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_cursor_set(s : MlregressquantileCursor, i : Int, v : Double) -> MlregressquantileCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cursor_sum(s : MlregressquantileCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_cursor_mean(s : MlregressquantileCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_cursor_scale(s : MlregressquantileCursor, f : Double) -> MlregressquantileCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cursor_add(a : MlregressquantileCursor, b : MlregressquantileCursor) -> MlregressquantileCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_cursor_copy(s : MlregressquantileCursor) -> MlregressquantileCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cursor_fill(s : MlregressquantileCursor, v : Double) -> MlregressquantileCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_cursor_min(s : MlregressquantileCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_cursor_max(s : MlregressquantileCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_cursor_to_string(s : MlregressquantileCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_view_make(size : Int) -> MlregressquantileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_view_len(s : MlregressquantileView) -> Int { s.size }

pub fn ml_regress_quantile_view_get(s : MlregressquantileView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_view_set(s : MlregressquantileView, i : Int, v : Double) -> MlregressquantileView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_view_sum(s : MlregressquantileView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_view_mean(s : MlregressquantileView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_view_scale(s : MlregressquantileView, f : Double) -> MlregressquantileView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_view_add(a : MlregressquantileView, b : MlregressquantileView) -> MlregressquantileView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_view_copy(s : MlregressquantileView) -> MlregressquantileView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_view_fill(s : MlregressquantileView, v : Double) -> MlregressquantileView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_view_min(s : MlregressquantileView) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_view_max(s : MlregressquantileView) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_view_to_string(s : MlregressquantileView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_range_make(size : Int) -> MlregressquantileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_range_len(s : MlregressquantileRange) -> Int { s.size }

pub fn ml_regress_quantile_range_get(s : MlregressquantileRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_range_set(s : MlregressquantileRange, i : Int, v : Double) -> MlregressquantileRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_range_sum(s : MlregressquantileRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_range_mean(s : MlregressquantileRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_range_scale(s : MlregressquantileRange, f : Double) -> MlregressquantileRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_range_add(a : MlregressquantileRange, b : MlregressquantileRange) -> MlregressquantileRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_range_copy(s : MlregressquantileRange) -> MlregressquantileRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_range_fill(s : MlregressquantileRange, v : Double) -> MlregressquantileRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_range_min(s : MlregressquantileRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_range_max(s : MlregressquantileRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_range_to_string(s : MlregressquantileRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressquantileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_quantile_slice_make(size : Int) -> MlregressquantileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_quantile_slice_len(s : MlregressquantileSlice) -> Int { s.size }

pub fn ml_regress_quantile_slice_get(s : MlregressquantileSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_quantile_slice_set(s : MlregressquantileSlice, i : Int, v : Double) -> MlregressquantileSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_slice_sum(s : MlregressquantileSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_quantile_slice_mean(s : MlregressquantileSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_quantile_slice_scale(s : MlregressquantileSlice, f : Double) -> MlregressquantileSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_slice_add(a : MlregressquantileSlice, b : MlregressquantileSlice) -> MlregressquantileSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_quantile_slice_copy(s : MlregressquantileSlice) -> MlregressquantileSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_slice_fill(s : MlregressquantileSlice, v : Double) -> MlregressquantileSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_quantile_slice_min(s : MlregressquantileSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_quantile_slice_max(s : MlregressquantileSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_quantile_slice_to_string(s : MlregressquantileSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

