///===
/// extcore/ml_regress_ridge

pub(all) struct MlregressridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_ridge_make_point(x : Double, y : Double) -> MlregressridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_ridge_make_point3(x : Double, y : Double, z : Double) -> MlregressridgePoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_ridge_point_x(pt : MlregressridgePoint) -> Double { pt.x }

pub fn ml_regress_ridge_point_y(pt : MlregressridgePoint) -> Double { pt.y }

pub fn ml_regress_ridge_point_z(pt : MlregressridgePoint) -> Double { pt.z }

pub fn ml_regress_ridge_point_label(pt : MlregressridgePoint) -> Int { pt.label }

pub fn ml_regress_ridge_point_dist(a : MlregressridgePoint, b : MlregressridgePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_ridge_point_add(a : MlregressridgePoint, b : MlregressridgePoint) -> MlregressridgePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_ridge_point_sub(a : MlregressridgePoint, b : MlregressridgePoint) -> MlregressridgePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_ridge_point_scale(pt : MlregressridgePoint, s : Double) -> MlregressridgePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_ridge_point_dot(a : MlregressridgePoint, b : MlregressridgePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_ridge_point_cross(a : MlregressridgePoint, b : MlregressridgePoint) -> MlregressridgePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_ridge_point_norm(pt : MlregressridgePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_ridge_point_normalize(pt : MlregressridgePoint) -> MlregressridgePoint {
  let n = ml_regress_ridge_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_ridge_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_ridge_point_negate(pt : MlregressridgePoint) -> MlregressridgePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_ridge_point_mid(a : MlregressridgePoint, b : MlregressridgePoint) -> MlregressridgePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_ridge_point_lerp(a : MlregressridgePoint, b : MlregressridgePoint, t : Double) -> MlregressridgePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_ridge_point_to_string(pt : MlregressridgePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregressridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_ridge_make_series(vals : Array[Double], name : String) -> MlregressridgeSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_ridge_series_len(s : MlregressridgeSeries) -> Int { s.vals.length() }

pub fn ml_regress_ridge_series_sum(s : MlregressridgeSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_regress_ridge_series_mean(s : MlregressridgeSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_regress_ridge_series_min(s : MlregressridgeSeries) -> Double { @_common.min(s.vals) }

pub fn ml_regress_ridge_series_max(s : MlregressridgeSeries) -> Double { @_common.max(s.vals) }

pub fn ml_regress_ridge_series_range(s : MlregressridgeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_regress_ridge_series_var(s : MlregressridgeSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_regress_ridge_series_std(s : MlregressridgeSeries) -> Double { @_common.std(s.vals) }

pub fn ml_regress_ridge_series_median(s : MlregressridgeSeries) -> Double { @_common.median(s.vals) }

pub fn ml_regress_ridge_series_scale(s : MlregressridgeSeries, f : Double) -> MlregressridgeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_ridge_series_add(a : MlregressridgeSeries, b : MlregressridgeSeries) -> MlregressridgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_ridge_series_sub(a : MlregressridgeSeries, b : MlregressridgeSeries) -> MlregressridgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_ridge_series_normalize(s : MlregressridgeSeries) -> MlregressridgeSeries {
  let mn = ml_regress_ridge_series_min(s)
  let mx = ml_regress_ridge_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_ridge_series_cumsum(s : MlregressridgeSeries) -> MlregressridgeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_ridge_series_to_string(s : MlregressridgeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_ridge_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_ridge_matrix_identity(n : Int) -> MlregressridgeMatrix {
  let m = ml_regress_ridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_ridge_matrix_get(m : MlregressridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_ridge_matrix_transpose(m : MlregressridgeMatrix) -> MlregressridgeMatrix {
  let result = ml_regress_ridge_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_ridge_matrix_add(a : MlregressridgeMatrix, b : MlregressridgeMatrix) -> MlregressridgeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_ridge_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_ridge_matrix_scale(m : MlregressridgeMatrix, s : Double) -> MlregressridgeMatrix {
  let result = ml_regress_ridge_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_ridge_matrix_multiply(a : MlregressridgeMatrix, b : MlregressridgeMatrix) -> MlregressridgeMatrix {
  if a.cols != b.rows { return ml_regress_ridge_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_ridge_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_ridge_matrix_trace(m : MlregressridgeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_ridge_matrix_det(m : MlregressridgeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_ridge_matrix_norm(m : MlregressridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_regress_ridge_matrix_to_string(m : MlregressridgeMatrix) -> String {
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

pub(all) struct MlregressridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_ridge_make_vector(comps : Array[Double]) -> MlregressridgeVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_ridge_vector_zero(dim : Int) -> MlregressridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_ridge_vector_add(a : MlregressridgeVector, b : MlregressridgeVector) -> MlregressridgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_ridge_vector_sub(a : MlregressridgeVector, b : MlregressridgeVector) -> MlregressridgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_ridge_vector_scale(v : MlregressridgeVector, s : Double) -> MlregressridgeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_ridge_vector_dot(a : MlregressridgeVector, b : MlregressridgeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_ridge_vector_norm(v : MlregressridgeVector) -> Double { @_common.sqrt(ml_regress_ridge_vector_dot(v, v)) }

pub fn ml_regress_ridge_vector_normalize(v : MlregressridgeVector) -> MlregressridgeVector {
  let n = ml_regress_ridge_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_ridge_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_ridge_vector_dist(a : MlregressridgeVector, b : MlregressridgeVector) -> Double {
  ml_regress_ridge_vector_norm(ml_regress_ridge_vector_sub(a, b))
}

pub fn ml_regress_ridge_vector_to_string(v : MlregressridgeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_ridge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_ridge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_ridge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_ridge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_ridge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_ridge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_ridge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_ridge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_ridge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_ridge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_ridge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_ridge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_ridge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_ridge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_ridge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_ridge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_ridge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_ridge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_ridge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_ridge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_ridge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_ridge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_ridge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_ridge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_ridge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_ridge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_ridge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_ridge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_ridge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregressridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_frame_make(size : Int) -> MlregressridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_frame_len(s : MlregressridgeFrame) -> Int { s.size }

pub fn ml_regress_ridge_frame_get(s : MlregressridgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_frame_set(s : MlregressridgeFrame, i : Int, v : Double) -> MlregressridgeFrame {
  let result = ml_regress_ridge_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_frame_sum(s : MlregressridgeFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_frame_mean(s : MlregressridgeFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_frame_scale(s : MlregressridgeFrame, f : Double) -> MlregressridgeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_frame_add(a : MlregressridgeFrame, b : MlregressridgeFrame) -> MlregressridgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_frame_copy(s : MlregressridgeFrame) -> MlregressridgeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_frame_fill(s : MlregressridgeFrame, v : Double) -> MlregressridgeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_frame_min(s : MlregressridgeFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_frame_max(s : MlregressridgeFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_frame_to_string(s : MlregressridgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_table_make(size : Int) -> MlregressridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_table_len(s : MlregressridgeTable) -> Int { s.size }

pub fn ml_regress_ridge_table_get(s : MlregressridgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_table_set(s : MlregressridgeTable, i : Int, v : Double) -> MlregressridgeTable {
  let result = ml_regress_ridge_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_table_sum(s : MlregressridgeTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_table_mean(s : MlregressridgeTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_table_scale(s : MlregressridgeTable, f : Double) -> MlregressridgeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_table_add(a : MlregressridgeTable, b : MlregressridgeTable) -> MlregressridgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_table_copy(s : MlregressridgeTable) -> MlregressridgeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_table_fill(s : MlregressridgeTable, v : Double) -> MlregressridgeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_table_min(s : MlregressridgeTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_table_max(s : MlregressridgeTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_table_to_string(s : MlregressridgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_graphn_make(size : Int) -> MlregressridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_graphn_len(s : MlregressridgeGraphN) -> Int { s.size }

pub fn ml_regress_ridge_graphn_get(s : MlregressridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_graphn_set(s : MlregressridgeGraphN, i : Int, v : Double) -> MlregressridgeGraphN {
  let result = ml_regress_ridge_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_graphn_sum(s : MlregressridgeGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_graphn_mean(s : MlregressridgeGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_graphn_scale(s : MlregressridgeGraphN, f : Double) -> MlregressridgeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_graphn_add(a : MlregressridgeGraphN, b : MlregressridgeGraphN) -> MlregressridgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_graphn_copy(s : MlregressridgeGraphN) -> MlregressridgeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_graphn_fill(s : MlregressridgeGraphN, v : Double) -> MlregressridgeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_graphn_min(s : MlregressridgeGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_graphn_max(s : MlregressridgeGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_graphn_to_string(s : MlregressridgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_node_make(size : Int) -> MlregressridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_node_len(s : MlregressridgeNode) -> Int { s.size }

pub fn ml_regress_ridge_node_get(s : MlregressridgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_node_set(s : MlregressridgeNode, i : Int, v : Double) -> MlregressridgeNode {
  let result = ml_regress_ridge_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_node_sum(s : MlregressridgeNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_node_mean(s : MlregressridgeNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_node_scale(s : MlregressridgeNode, f : Double) -> MlregressridgeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_node_add(a : MlregressridgeNode, b : MlregressridgeNode) -> MlregressridgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_node_copy(s : MlregressridgeNode) -> MlregressridgeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_node_fill(s : MlregressridgeNode, v : Double) -> MlregressridgeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_node_min(s : MlregressridgeNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_node_max(s : MlregressridgeNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_node_to_string(s : MlregressridgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_edge_make(size : Int) -> MlregressridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_edge_len(s : MlregressridgeEdge) -> Int { s.size }

pub fn ml_regress_ridge_edge_get(s : MlregressridgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_edge_set(s : MlregressridgeEdge, i : Int, v : Double) -> MlregressridgeEdge {
  let result = ml_regress_ridge_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_edge_sum(s : MlregressridgeEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_edge_mean(s : MlregressridgeEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_edge_scale(s : MlregressridgeEdge, f : Double) -> MlregressridgeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_edge_add(a : MlregressridgeEdge, b : MlregressridgeEdge) -> MlregressridgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_edge_copy(s : MlregressridgeEdge) -> MlregressridgeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_edge_fill(s : MlregressridgeEdge, v : Double) -> MlregressridgeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_edge_min(s : MlregressridgeEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_edge_max(s : MlregressridgeEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_edge_to_string(s : MlregressridgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_path_make(size : Int) -> MlregressridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_path_len(s : MlregressridgePath) -> Int { s.size }

pub fn ml_regress_ridge_path_get(s : MlregressridgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_path_set(s : MlregressridgePath, i : Int, v : Double) -> MlregressridgePath {
  let result = ml_regress_ridge_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_path_sum(s : MlregressridgePath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_path_mean(s : MlregressridgePath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_path_scale(s : MlregressridgePath, f : Double) -> MlregressridgePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_path_add(a : MlregressridgePath, b : MlregressridgePath) -> MlregressridgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_path_copy(s : MlregressridgePath) -> MlregressridgePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_path_fill(s : MlregressridgePath, v : Double) -> MlregressridgePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_path_min(s : MlregressridgePath) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_path_max(s : MlregressridgePath) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_path_to_string(s : MlregressridgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_cluster_make(size : Int) -> MlregressridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_cluster_len(s : MlregressridgeCluster) -> Int { s.size }

pub fn ml_regress_ridge_cluster_get(s : MlregressridgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_cluster_set(s : MlregressridgeCluster, i : Int, v : Double) -> MlregressridgeCluster {
  let result = ml_regress_ridge_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_cluster_sum(s : MlregressridgeCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_cluster_mean(s : MlregressridgeCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_cluster_scale(s : MlregressridgeCluster, f : Double) -> MlregressridgeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cluster_add(a : MlregressridgeCluster, b : MlregressridgeCluster) -> MlregressridgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_cluster_copy(s : MlregressridgeCluster) -> MlregressridgeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cluster_fill(s : MlregressridgeCluster, v : Double) -> MlregressridgeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cluster_min(s : MlregressridgeCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_cluster_max(s : MlregressridgeCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_cluster_to_string(s : MlregressridgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_model_make(size : Int) -> MlregressridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_model_len(s : MlregressridgeModel) -> Int { s.size }

pub fn ml_regress_ridge_model_get(s : MlregressridgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_model_set(s : MlregressridgeModel, i : Int, v : Double) -> MlregressridgeModel {
  let result = ml_regress_ridge_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_model_sum(s : MlregressridgeModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_model_mean(s : MlregressridgeModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_model_scale(s : MlregressridgeModel, f : Double) -> MlregressridgeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_model_add(a : MlregressridgeModel, b : MlregressridgeModel) -> MlregressridgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_model_copy(s : MlregressridgeModel) -> MlregressridgeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_model_fill(s : MlregressridgeModel, v : Double) -> MlregressridgeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_model_min(s : MlregressridgeModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_model_max(s : MlregressridgeModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_model_to_string(s : MlregressridgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_layer_make(size : Int) -> MlregressridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_layer_len(s : MlregressridgeLayer) -> Int { s.size }

pub fn ml_regress_ridge_layer_get(s : MlregressridgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_layer_set(s : MlregressridgeLayer, i : Int, v : Double) -> MlregressridgeLayer {
  let result = ml_regress_ridge_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_layer_sum(s : MlregressridgeLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_layer_mean(s : MlregressridgeLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_layer_scale(s : MlregressridgeLayer, f : Double) -> MlregressridgeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_layer_add(a : MlregressridgeLayer, b : MlregressridgeLayer) -> MlregressridgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_layer_copy(s : MlregressridgeLayer) -> MlregressridgeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_layer_fill(s : MlregressridgeLayer, v : Double) -> MlregressridgeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_layer_min(s : MlregressridgeLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_layer_max(s : MlregressridgeLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_layer_to_string(s : MlregressridgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_buffer_make(size : Int) -> MlregressridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_buffer_len(s : MlregressridgeBuffer) -> Int { s.size }

pub fn ml_regress_ridge_buffer_get(s : MlregressridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_buffer_set(s : MlregressridgeBuffer, i : Int, v : Double) -> MlregressridgeBuffer {
  let result = ml_regress_ridge_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_buffer_sum(s : MlregressridgeBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_buffer_mean(s : MlregressridgeBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_buffer_scale(s : MlregressridgeBuffer, f : Double) -> MlregressridgeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_buffer_add(a : MlregressridgeBuffer, b : MlregressridgeBuffer) -> MlregressridgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_buffer_copy(s : MlregressridgeBuffer) -> MlregressridgeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_buffer_fill(s : MlregressridgeBuffer, v : Double) -> MlregressridgeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_buffer_min(s : MlregressridgeBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_buffer_max(s : MlregressridgeBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_buffer_to_string(s : MlregressridgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_cursor_make(size : Int) -> MlregressridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_cursor_len(s : MlregressridgeCursor) -> Int { s.size }

pub fn ml_regress_ridge_cursor_get(s : MlregressridgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_cursor_set(s : MlregressridgeCursor, i : Int, v : Double) -> MlregressridgeCursor {
  let result = ml_regress_ridge_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_cursor_sum(s : MlregressridgeCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_cursor_mean(s : MlregressridgeCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_cursor_scale(s : MlregressridgeCursor, f : Double) -> MlregressridgeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cursor_add(a : MlregressridgeCursor, b : MlregressridgeCursor) -> MlregressridgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_cursor_copy(s : MlregressridgeCursor) -> MlregressridgeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cursor_fill(s : MlregressridgeCursor, v : Double) -> MlregressridgeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_cursor_min(s : MlregressridgeCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_cursor_max(s : MlregressridgeCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_cursor_to_string(s : MlregressridgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_view_make(size : Int) -> MlregressridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_view_len(s : MlregressridgeView) -> Int { s.size }

pub fn ml_regress_ridge_view_get(s : MlregressridgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_view_set(s : MlregressridgeView, i : Int, v : Double) -> MlregressridgeView {
  let result = ml_regress_ridge_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_view_sum(s : MlregressridgeView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_view_mean(s : MlregressridgeView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_view_scale(s : MlregressridgeView, f : Double) -> MlregressridgeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_view_add(a : MlregressridgeView, b : MlregressridgeView) -> MlregressridgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_view_copy(s : MlregressridgeView) -> MlregressridgeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_view_fill(s : MlregressridgeView, v : Double) -> MlregressridgeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_view_min(s : MlregressridgeView) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_view_max(s : MlregressridgeView) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_view_to_string(s : MlregressridgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_range_make(size : Int) -> MlregressridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_range_len(s : MlregressridgeRange) -> Int { s.size }

pub fn ml_regress_ridge_range_get(s : MlregressridgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_range_set(s : MlregressridgeRange, i : Int, v : Double) -> MlregressridgeRange {
  let result = ml_regress_ridge_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_range_sum(s : MlregressridgeRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_range_mean(s : MlregressridgeRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_range_scale(s : MlregressridgeRange, f : Double) -> MlregressridgeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_range_add(a : MlregressridgeRange, b : MlregressridgeRange) -> MlregressridgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_range_copy(s : MlregressridgeRange) -> MlregressridgeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_range_fill(s : MlregressridgeRange, v : Double) -> MlregressridgeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_range_min(s : MlregressridgeRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_range_max(s : MlregressridgeRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_range_to_string(s : MlregressridgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_ridge_slice_make(size : Int) -> MlregressridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_ridge_slice_len(s : MlregressridgeSlice) -> Int { s.size }

pub fn ml_regress_ridge_slice_get(s : MlregressridgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_ridge_slice_set(s : MlregressridgeSlice, i : Int, v : Double) -> MlregressridgeSlice {
  let result = ml_regress_ridge_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_ridge_slice_sum(s : MlregressridgeSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_ridge_slice_mean(s : MlregressridgeSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_ridge_slice_scale(s : MlregressridgeSlice, f : Double) -> MlregressridgeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_slice_add(a : MlregressridgeSlice, b : MlregressridgeSlice) -> MlregressridgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_ridge_slice_copy(s : MlregressridgeSlice) -> MlregressridgeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_slice_fill(s : MlregressridgeSlice, v : Double) -> MlregressridgeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_ridge_slice_min(s : MlregressridgeSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_ridge_slice_max(s : MlregressridgeSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_ridge_slice_to_string(s : MlregressridgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

