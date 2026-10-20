///===
/// extcore/ml_metric_calibration

pub(all) struct MlmetriccalibrationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_calibration_make_point(x : Double, y : Double) -> MlmetriccalibrationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_calibration_make_point3(x : Double, y : Double, z : Double) -> MlmetriccalibrationPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_calibration_point_x(pt : MlmetriccalibrationPoint) -> Double { pt.x }

pub fn ml_metric_calibration_point_y(pt : MlmetriccalibrationPoint) -> Double { pt.y }

pub fn ml_metric_calibration_point_z(pt : MlmetriccalibrationPoint) -> Double { pt.z }

pub fn ml_metric_calibration_point_label(pt : MlmetriccalibrationPoint) -> Int { pt.label }

pub fn ml_metric_calibration_point_dist(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_calibration_point_add(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_calibration_point_sub(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_calibration_point_scale(pt : MlmetriccalibrationPoint, s : Double) -> MlmetriccalibrationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_calibration_point_dot(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_calibration_point_cross(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_calibration_point_norm(pt : MlmetriccalibrationPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_calibration_point_normalize(pt : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  let n = ml_metric_calibration_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_calibration_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_calibration_point_negate(pt : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_calibration_point_mid(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint) -> MlmetriccalibrationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_calibration_point_lerp(a : MlmetriccalibrationPoint, b : MlmetriccalibrationPoint, t : Double) -> MlmetriccalibrationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_calibration_point_to_string(pt : MlmetriccalibrationPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetriccalibrationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_calibration_make_series(vals : Array[Double], name : String) -> MlmetriccalibrationSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_calibration_series_len(s : MlmetriccalibrationSeries) -> Int { s.vals.length() }

pub fn ml_metric_calibration_series_sum(s : MlmetriccalibrationSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_metric_calibration_series_mean(s : MlmetriccalibrationSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_metric_calibration_series_min(s : MlmetriccalibrationSeries) -> Double { @_common.min(s.vals) }

pub fn ml_metric_calibration_series_max(s : MlmetriccalibrationSeries) -> Double { @_common.max(s.vals) }

pub fn ml_metric_calibration_series_range(s : MlmetriccalibrationSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_metric_calibration_series_var(s : MlmetriccalibrationSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_metric_calibration_series_std(s : MlmetriccalibrationSeries) -> Double { @_common.std(s.vals) }

pub fn ml_metric_calibration_series_median(s : MlmetriccalibrationSeries) -> Double { @_common.median(s.vals) }

pub fn ml_metric_calibration_series_scale(s : MlmetriccalibrationSeries, f : Double) -> MlmetriccalibrationSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ml_metric_calibration_series_add(a : MlmetriccalibrationSeries, b : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_calibration_series_sub(a : MlmetriccalibrationSeries, b : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_calibration_series_normalize(s : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  let mn = ml_metric_calibration_series_min(s)
  let mx = ml_metric_calibration_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_calibration_series_cumsum(s : MlmetriccalibrationSeries) -> MlmetriccalibrationSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_calibration_series_to_string(s : MlmetriccalibrationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetriccalibrationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_calibration_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetriccalibrationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_calibration_matrix_identity(n : Int) -> MlmetriccalibrationMatrix {
  let m = ml_metric_calibration_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_calibration_matrix_get(m : MlmetriccalibrationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_calibration_matrix_transpose(m : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  let result = ml_metric_calibration_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_calibration_matrix_add(a : MlmetriccalibrationMatrix, b : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_calibration_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_calibration_matrix_scale(m : MlmetriccalibrationMatrix, s : Double) -> MlmetriccalibrationMatrix {
  let result = ml_metric_calibration_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_calibration_matrix_multiply(a : MlmetriccalibrationMatrix, b : MlmetriccalibrationMatrix) -> MlmetriccalibrationMatrix {
  if a.cols != b.rows { return ml_metric_calibration_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_calibration_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_calibration_matrix_trace(m : MlmetriccalibrationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_calibration_matrix_det(m : MlmetriccalibrationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_calibration_matrix_norm(m : MlmetriccalibrationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_calibration_matrix_to_string(m : MlmetriccalibrationMatrix) -> String {
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

pub(all) struct MlmetriccalibrationVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_calibration_make_vector(comps : Array[Double]) -> MlmetriccalibrationVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_calibration_vector_zero(dim : Int) -> MlmetriccalibrationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_calibration_vector_add(a : MlmetriccalibrationVector, b : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ml_metric_calibration_vector_sub(a : MlmetriccalibrationVector, b : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ml_metric_calibration_vector_scale(v : MlmetriccalibrationVector, s : Double) -> MlmetriccalibrationVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ml_metric_calibration_vector_dot(a : MlmetriccalibrationVector, b : MlmetriccalibrationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_calibration_vector_norm(v : MlmetriccalibrationVector) -> Double { @_common.sqrt(ml_metric_calibration_vector_dot(v, v)) }

pub fn ml_metric_calibration_vector_normalize(v : MlmetriccalibrationVector) -> MlmetriccalibrationVector {
  let n = ml_metric_calibration_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_calibration_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_calibration_vector_dist(a : MlmetriccalibrationVector, b : MlmetriccalibrationVector) -> Double {
  ml_metric_calibration_vector_norm(ml_metric_calibration_vector_sub(a, b))
}

pub fn ml_metric_calibration_vector_to_string(v : MlmetriccalibrationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_calibration_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_calibration_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_calibration_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_calibration_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_calibration_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_calibration_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_calibration_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_calibration_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_calibration_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_calibration_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_calibration_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_calibration_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_calibration_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_calibration_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_calibration_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_calibration_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_calibration_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_calibration_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_calibration_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_calibration_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_calibration_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_calibration_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_calibration_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_calibration_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_calibration_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_calibration_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_calibration_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_calibration_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_calibration_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetriccalibrationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_frame_make(size : Int) -> MlmetriccalibrationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_frame_len(s : MlmetriccalibrationFrame) -> Int { s.size }

pub fn ml_metric_calibration_frame_get(s : MlmetriccalibrationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_frame_set(s : MlmetriccalibrationFrame, i : Int, v : Double) -> MlmetriccalibrationFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_frame_sum(s : MlmetriccalibrationFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_frame_mean(s : MlmetriccalibrationFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_frame_scale(s : MlmetriccalibrationFrame, f : Double) -> MlmetriccalibrationFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_frame_add(a : MlmetriccalibrationFrame, b : MlmetriccalibrationFrame) -> MlmetriccalibrationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_frame_copy(s : MlmetriccalibrationFrame) -> MlmetriccalibrationFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_frame_fill(s : MlmetriccalibrationFrame, v : Double) -> MlmetriccalibrationFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_frame_min(s : MlmetriccalibrationFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_frame_max(s : MlmetriccalibrationFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_frame_to_string(s : MlmetriccalibrationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_table_make(size : Int) -> MlmetriccalibrationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_table_len(s : MlmetriccalibrationTable) -> Int { s.size }

pub fn ml_metric_calibration_table_get(s : MlmetriccalibrationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_table_set(s : MlmetriccalibrationTable, i : Int, v : Double) -> MlmetriccalibrationTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_table_sum(s : MlmetriccalibrationTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_table_mean(s : MlmetriccalibrationTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_table_scale(s : MlmetriccalibrationTable, f : Double) -> MlmetriccalibrationTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_table_add(a : MlmetriccalibrationTable, b : MlmetriccalibrationTable) -> MlmetriccalibrationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_table_copy(s : MlmetriccalibrationTable) -> MlmetriccalibrationTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_table_fill(s : MlmetriccalibrationTable, v : Double) -> MlmetriccalibrationTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_table_min(s : MlmetriccalibrationTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_table_max(s : MlmetriccalibrationTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_table_to_string(s : MlmetriccalibrationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_graphn_make(size : Int) -> MlmetriccalibrationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_graphn_len(s : MlmetriccalibrationGraphN) -> Int { s.size }

pub fn ml_metric_calibration_graphn_get(s : MlmetriccalibrationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_graphn_set(s : MlmetriccalibrationGraphN, i : Int, v : Double) -> MlmetriccalibrationGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_graphn_sum(s : MlmetriccalibrationGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_graphn_mean(s : MlmetriccalibrationGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_graphn_scale(s : MlmetriccalibrationGraphN, f : Double) -> MlmetriccalibrationGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_graphn_add(a : MlmetriccalibrationGraphN, b : MlmetriccalibrationGraphN) -> MlmetriccalibrationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_graphn_copy(s : MlmetriccalibrationGraphN) -> MlmetriccalibrationGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_graphn_fill(s : MlmetriccalibrationGraphN, v : Double) -> MlmetriccalibrationGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_graphn_min(s : MlmetriccalibrationGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_graphn_max(s : MlmetriccalibrationGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_graphn_to_string(s : MlmetriccalibrationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_node_make(size : Int) -> MlmetriccalibrationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_node_len(s : MlmetriccalibrationNode) -> Int { s.size }

pub fn ml_metric_calibration_node_get(s : MlmetriccalibrationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_node_set(s : MlmetriccalibrationNode, i : Int, v : Double) -> MlmetriccalibrationNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_node_sum(s : MlmetriccalibrationNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_node_mean(s : MlmetriccalibrationNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_node_scale(s : MlmetriccalibrationNode, f : Double) -> MlmetriccalibrationNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_node_add(a : MlmetriccalibrationNode, b : MlmetriccalibrationNode) -> MlmetriccalibrationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_node_copy(s : MlmetriccalibrationNode) -> MlmetriccalibrationNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_node_fill(s : MlmetriccalibrationNode, v : Double) -> MlmetriccalibrationNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_node_min(s : MlmetriccalibrationNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_node_max(s : MlmetriccalibrationNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_node_to_string(s : MlmetriccalibrationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_edge_make(size : Int) -> MlmetriccalibrationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_edge_len(s : MlmetriccalibrationEdge) -> Int { s.size }

pub fn ml_metric_calibration_edge_get(s : MlmetriccalibrationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_edge_set(s : MlmetriccalibrationEdge, i : Int, v : Double) -> MlmetriccalibrationEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_edge_sum(s : MlmetriccalibrationEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_edge_mean(s : MlmetriccalibrationEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_edge_scale(s : MlmetriccalibrationEdge, f : Double) -> MlmetriccalibrationEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_edge_add(a : MlmetriccalibrationEdge, b : MlmetriccalibrationEdge) -> MlmetriccalibrationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_edge_copy(s : MlmetriccalibrationEdge) -> MlmetriccalibrationEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_edge_fill(s : MlmetriccalibrationEdge, v : Double) -> MlmetriccalibrationEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_edge_min(s : MlmetriccalibrationEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_edge_max(s : MlmetriccalibrationEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_edge_to_string(s : MlmetriccalibrationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_path_make(size : Int) -> MlmetriccalibrationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_path_len(s : MlmetriccalibrationPath) -> Int { s.size }

pub fn ml_metric_calibration_path_get(s : MlmetriccalibrationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_path_set(s : MlmetriccalibrationPath, i : Int, v : Double) -> MlmetriccalibrationPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_path_sum(s : MlmetriccalibrationPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_path_mean(s : MlmetriccalibrationPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_path_scale(s : MlmetriccalibrationPath, f : Double) -> MlmetriccalibrationPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_path_add(a : MlmetriccalibrationPath, b : MlmetriccalibrationPath) -> MlmetriccalibrationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_path_copy(s : MlmetriccalibrationPath) -> MlmetriccalibrationPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_path_fill(s : MlmetriccalibrationPath, v : Double) -> MlmetriccalibrationPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_path_min(s : MlmetriccalibrationPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_path_max(s : MlmetriccalibrationPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_path_to_string(s : MlmetriccalibrationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_cluster_make(size : Int) -> MlmetriccalibrationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_cluster_len(s : MlmetriccalibrationCluster) -> Int { s.size }

pub fn ml_metric_calibration_cluster_get(s : MlmetriccalibrationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_cluster_set(s : MlmetriccalibrationCluster, i : Int, v : Double) -> MlmetriccalibrationCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_cluster_sum(s : MlmetriccalibrationCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_cluster_mean(s : MlmetriccalibrationCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_cluster_scale(s : MlmetriccalibrationCluster, f : Double) -> MlmetriccalibrationCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_cluster_add(a : MlmetriccalibrationCluster, b : MlmetriccalibrationCluster) -> MlmetriccalibrationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_cluster_copy(s : MlmetriccalibrationCluster) -> MlmetriccalibrationCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_cluster_fill(s : MlmetriccalibrationCluster, v : Double) -> MlmetriccalibrationCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_cluster_min(s : MlmetriccalibrationCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_cluster_max(s : MlmetriccalibrationCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_cluster_to_string(s : MlmetriccalibrationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_model_make(size : Int) -> MlmetriccalibrationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_model_len(s : MlmetriccalibrationModel) -> Int { s.size }

pub fn ml_metric_calibration_model_get(s : MlmetriccalibrationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_model_set(s : MlmetriccalibrationModel, i : Int, v : Double) -> MlmetriccalibrationModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_model_sum(s : MlmetriccalibrationModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_model_mean(s : MlmetriccalibrationModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_model_scale(s : MlmetriccalibrationModel, f : Double) -> MlmetriccalibrationModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_model_add(a : MlmetriccalibrationModel, b : MlmetriccalibrationModel) -> MlmetriccalibrationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_model_copy(s : MlmetriccalibrationModel) -> MlmetriccalibrationModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_model_fill(s : MlmetriccalibrationModel, v : Double) -> MlmetriccalibrationModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_model_min(s : MlmetriccalibrationModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_model_max(s : MlmetriccalibrationModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_model_to_string(s : MlmetriccalibrationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_layer_make(size : Int) -> MlmetriccalibrationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_layer_len(s : MlmetriccalibrationLayer) -> Int { s.size }

pub fn ml_metric_calibration_layer_get(s : MlmetriccalibrationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_layer_set(s : MlmetriccalibrationLayer, i : Int, v : Double) -> MlmetriccalibrationLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_layer_sum(s : MlmetriccalibrationLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_layer_mean(s : MlmetriccalibrationLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_layer_scale(s : MlmetriccalibrationLayer, f : Double) -> MlmetriccalibrationLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_layer_add(a : MlmetriccalibrationLayer, b : MlmetriccalibrationLayer) -> MlmetriccalibrationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_layer_copy(s : MlmetriccalibrationLayer) -> MlmetriccalibrationLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_layer_fill(s : MlmetriccalibrationLayer, v : Double) -> MlmetriccalibrationLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_layer_min(s : MlmetriccalibrationLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_layer_max(s : MlmetriccalibrationLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_layer_to_string(s : MlmetriccalibrationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_buffer_make(size : Int) -> MlmetriccalibrationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_buffer_len(s : MlmetriccalibrationBuffer) -> Int { s.size }

pub fn ml_metric_calibration_buffer_get(s : MlmetriccalibrationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_buffer_set(s : MlmetriccalibrationBuffer, i : Int, v : Double) -> MlmetriccalibrationBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_buffer_sum(s : MlmetriccalibrationBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_buffer_mean(s : MlmetriccalibrationBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_buffer_scale(s : MlmetriccalibrationBuffer, f : Double) -> MlmetriccalibrationBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_buffer_add(a : MlmetriccalibrationBuffer, b : MlmetriccalibrationBuffer) -> MlmetriccalibrationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_buffer_copy(s : MlmetriccalibrationBuffer) -> MlmetriccalibrationBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_buffer_fill(s : MlmetriccalibrationBuffer, v : Double) -> MlmetriccalibrationBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_buffer_min(s : MlmetriccalibrationBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_buffer_max(s : MlmetriccalibrationBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_buffer_to_string(s : MlmetriccalibrationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_cursor_make(size : Int) -> MlmetriccalibrationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_cursor_len(s : MlmetriccalibrationCursor) -> Int { s.size }

pub fn ml_metric_calibration_cursor_get(s : MlmetriccalibrationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_cursor_set(s : MlmetriccalibrationCursor, i : Int, v : Double) -> MlmetriccalibrationCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_cursor_sum(s : MlmetriccalibrationCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_cursor_mean(s : MlmetriccalibrationCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_cursor_scale(s : MlmetriccalibrationCursor, f : Double) -> MlmetriccalibrationCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_cursor_add(a : MlmetriccalibrationCursor, b : MlmetriccalibrationCursor) -> MlmetriccalibrationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_cursor_copy(s : MlmetriccalibrationCursor) -> MlmetriccalibrationCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_cursor_fill(s : MlmetriccalibrationCursor, v : Double) -> MlmetriccalibrationCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_cursor_min(s : MlmetriccalibrationCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_cursor_max(s : MlmetriccalibrationCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_cursor_to_string(s : MlmetriccalibrationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_view_make(size : Int) -> MlmetriccalibrationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_view_len(s : MlmetriccalibrationView) -> Int { s.size }

pub fn ml_metric_calibration_view_get(s : MlmetriccalibrationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_view_set(s : MlmetriccalibrationView, i : Int, v : Double) -> MlmetriccalibrationView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_view_sum(s : MlmetriccalibrationView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_view_mean(s : MlmetriccalibrationView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_view_scale(s : MlmetriccalibrationView, f : Double) -> MlmetriccalibrationView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_view_add(a : MlmetriccalibrationView, b : MlmetriccalibrationView) -> MlmetriccalibrationView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_view_copy(s : MlmetriccalibrationView) -> MlmetriccalibrationView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_view_fill(s : MlmetriccalibrationView, v : Double) -> MlmetriccalibrationView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_view_min(s : MlmetriccalibrationView) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_view_max(s : MlmetriccalibrationView) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_view_to_string(s : MlmetriccalibrationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_range_make(size : Int) -> MlmetriccalibrationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_range_len(s : MlmetriccalibrationRange) -> Int { s.size }

pub fn ml_metric_calibration_range_get(s : MlmetriccalibrationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_range_set(s : MlmetriccalibrationRange, i : Int, v : Double) -> MlmetriccalibrationRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_range_sum(s : MlmetriccalibrationRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_range_mean(s : MlmetriccalibrationRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_range_scale(s : MlmetriccalibrationRange, f : Double) -> MlmetriccalibrationRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_range_add(a : MlmetriccalibrationRange, b : MlmetriccalibrationRange) -> MlmetriccalibrationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_range_copy(s : MlmetriccalibrationRange) -> MlmetriccalibrationRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_range_fill(s : MlmetriccalibrationRange, v : Double) -> MlmetriccalibrationRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_range_min(s : MlmetriccalibrationRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_range_max(s : MlmetriccalibrationRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_range_to_string(s : MlmetriccalibrationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetriccalibrationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_calibration_slice_make(size : Int) -> MlmetriccalibrationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_calibration_slice_len(s : MlmetriccalibrationSlice) -> Int { s.size }

pub fn ml_metric_calibration_slice_get(s : MlmetriccalibrationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_calibration_slice_set(s : MlmetriccalibrationSlice, i : Int, v : Double) -> MlmetriccalibrationSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_slice_sum(s : MlmetriccalibrationSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_calibration_slice_mean(s : MlmetriccalibrationSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_calibration_slice_scale(s : MlmetriccalibrationSlice, f : Double) -> MlmetriccalibrationSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_slice_add(a : MlmetriccalibrationSlice, b : MlmetriccalibrationSlice) -> MlmetriccalibrationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_calibration_slice_copy(s : MlmetriccalibrationSlice) -> MlmetriccalibrationSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_slice_fill(s : MlmetriccalibrationSlice, v : Double) -> MlmetriccalibrationSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_calibration_slice_min(s : MlmetriccalibrationSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_calibration_slice_max(s : MlmetriccalibrationSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_calibration_slice_to_string(s : MlmetriccalibrationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

