///===
/// extcore/timeseries_var

pub(all) struct TimeseriesvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_var_make_point(x : Double, y : Double) -> TimeseriesvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_var_make_point3(x : Double, y : Double, z : Double) -> TimeseriesvarPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_var_point_x(pt : TimeseriesvarPoint) -> Double { pt.x }

pub fn timeseries_var_point_y(pt : TimeseriesvarPoint) -> Double { pt.y }

pub fn timeseries_var_point_z(pt : TimeseriesvarPoint) -> Double { pt.z }

pub fn timeseries_var_point_label(pt : TimeseriesvarPoint) -> Int { pt.label }

pub fn timeseries_var_point_dist(a : TimeseriesvarPoint, b : TimeseriesvarPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_var_point_add(a : TimeseriesvarPoint, b : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_var_point_sub(a : TimeseriesvarPoint, b : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_var_point_scale(pt : TimeseriesvarPoint, s : Double) -> TimeseriesvarPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_var_point_dot(a : TimeseriesvarPoint, b : TimeseriesvarPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_var_point_cross(a : TimeseriesvarPoint, b : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_var_point_norm(pt : TimeseriesvarPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_var_point_normalize(pt : TimeseriesvarPoint) -> TimeseriesvarPoint {
  let n = timeseries_var_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_var_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_var_point_negate(pt : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_var_point_mid(a : TimeseriesvarPoint, b : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_var_point_lerp(a : TimeseriesvarPoint, b : TimeseriesvarPoint, t : Double) -> TimeseriesvarPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_var_point_to_string(pt : TimeseriesvarPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_var_make_series(vals : Array[Double], name : String) -> TimeseriesvarSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_var_series_len(s : TimeseriesvarSeries) -> Int { s.vals.length() }

pub fn timeseries_var_series_sum(s : TimeseriesvarSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_var_series_mean(s : TimeseriesvarSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_var_series_min(s : TimeseriesvarSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_var_series_max(s : TimeseriesvarSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_var_series_range(s : TimeseriesvarSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_var_series_var(s : TimeseriesvarSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_var_series_std(s : TimeseriesvarSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_var_series_median(s : TimeseriesvarSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_var_series_scale(s : TimeseriesvarSeries, f : Double) -> TimeseriesvarSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_var_series_add(a : TimeseriesvarSeries, b : TimeseriesvarSeries) -> TimeseriesvarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_var_series_sub(a : TimeseriesvarSeries, b : TimeseriesvarSeries) -> TimeseriesvarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_var_series_normalize(s : TimeseriesvarSeries) -> TimeseriesvarSeries {
  let mn = timeseries_var_series_min(s)
  let mx = timeseries_var_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_var_series_cumsum(s : TimeseriesvarSeries) -> TimeseriesvarSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_var_series_to_string(s : TimeseriesvarSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_var_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_var_matrix_identity(n : Int) -> TimeseriesvarMatrix {
  let m = timeseries_var_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_var_matrix_get(m : TimeseriesvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_var_matrix_transpose(m : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  let result = timeseries_var_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_var_matrix_add(a : TimeseriesvarMatrix, b : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_var_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_var_matrix_scale(m : TimeseriesvarMatrix, s : Double) -> TimeseriesvarMatrix {
  let result = timeseries_var_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_var_matrix_multiply(a : TimeseriesvarMatrix, b : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  if a.cols != b.rows { return timeseries_var_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_var_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_var_matrix_trace(m : TimeseriesvarMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_var_matrix_det(m : TimeseriesvarMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_var_matrix_norm(m : TimeseriesvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_var_matrix_to_string(m : TimeseriesvarMatrix) -> String {
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

pub(all) struct TimeseriesvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_var_make_vector(comps : Array[Double]) -> TimeseriesvarVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_var_vector_zero(dim : Int) -> TimeseriesvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_var_vector_add(a : TimeseriesvarVector, b : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_var_vector_sub(a : TimeseriesvarVector, b : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_var_vector_scale(v : TimeseriesvarVector, s : Double) -> TimeseriesvarVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_var_vector_dot(a : TimeseriesvarVector, b : TimeseriesvarVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_var_vector_norm(v : TimeseriesvarVector) -> Double { @_common.sqrt(timeseries_var_vector_dot(v, v)) }

pub fn timeseries_var_vector_normalize(v : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = timeseries_var_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_var_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_var_vector_dist(a : TimeseriesvarVector, b : TimeseriesvarVector) -> Double {
  timeseries_var_vector_norm(timeseries_var_vector_sub(a, b))
}

pub fn timeseries_var_vector_to_string(v : TimeseriesvarVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_var_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_var_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_var_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_var_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_var_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_var_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_var_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_var_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_var_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_var_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_var_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_var_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_var_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_var_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_var_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_var_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_var_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_var_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_var_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_var_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_var_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_var_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_var_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_var_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_var_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_var_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_var_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_var_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_var_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_frame_make(size : Int) -> TimeseriesvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_frame_len(s : TimeseriesvarFrame) -> Int { s.size }

pub fn timeseries_var_frame_get(s : TimeseriesvarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_frame_set(s : TimeseriesvarFrame, i : Int, v : Double) -> TimeseriesvarFrame {
  let result = timeseries_var_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_frame_sum(s : TimeseriesvarFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_frame_mean(s : TimeseriesvarFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_frame_scale(s : TimeseriesvarFrame, f : Double) -> TimeseriesvarFrame {
  let result = timeseries_var_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_frame_add(a : TimeseriesvarFrame, b : TimeseriesvarFrame) -> TimeseriesvarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_frame_copy(s : TimeseriesvarFrame) -> TimeseriesvarFrame {
  let result = timeseries_var_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_frame_fill(s : TimeseriesvarFrame, v : Double) -> TimeseriesvarFrame {
  let result = timeseries_var_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_frame_min(s : TimeseriesvarFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_var_frame_max(s : TimeseriesvarFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_var_frame_to_string(s : TimeseriesvarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_table_make(size : Int) -> TimeseriesvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_table_len(s : TimeseriesvarTable) -> Int { s.size }

pub fn timeseries_var_table_get(s : TimeseriesvarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_table_set(s : TimeseriesvarTable, i : Int, v : Double) -> TimeseriesvarTable {
  let result = timeseries_var_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_table_sum(s : TimeseriesvarTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_table_mean(s : TimeseriesvarTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_table_scale(s : TimeseriesvarTable, f : Double) -> TimeseriesvarTable {
  let result = timeseries_var_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_table_add(a : TimeseriesvarTable, b : TimeseriesvarTable) -> TimeseriesvarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_table_copy(s : TimeseriesvarTable) -> TimeseriesvarTable {
  let result = timeseries_var_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_table_fill(s : TimeseriesvarTable, v : Double) -> TimeseriesvarTable {
  let result = timeseries_var_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_table_min(s : TimeseriesvarTable) -> Double { @_common.min(s.data) }

pub fn timeseries_var_table_max(s : TimeseriesvarTable) -> Double { @_common.max(s.data) }

pub fn timeseries_var_table_to_string(s : TimeseriesvarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_graphn_make(size : Int) -> TimeseriesvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_graphn_len(s : TimeseriesvarGraphN) -> Int { s.size }

pub fn timeseries_var_graphn_get(s : TimeseriesvarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_graphn_set(s : TimeseriesvarGraphN, i : Int, v : Double) -> TimeseriesvarGraphN {
  let result = timeseries_var_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_graphn_sum(s : TimeseriesvarGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_graphn_mean(s : TimeseriesvarGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_graphn_scale(s : TimeseriesvarGraphN, f : Double) -> TimeseriesvarGraphN {
  let result = timeseries_var_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_graphn_add(a : TimeseriesvarGraphN, b : TimeseriesvarGraphN) -> TimeseriesvarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_graphn_copy(s : TimeseriesvarGraphN) -> TimeseriesvarGraphN {
  let result = timeseries_var_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_graphn_fill(s : TimeseriesvarGraphN, v : Double) -> TimeseriesvarGraphN {
  let result = timeseries_var_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_graphn_min(s : TimeseriesvarGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_var_graphn_max(s : TimeseriesvarGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_var_graphn_to_string(s : TimeseriesvarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_node_make(size : Int) -> TimeseriesvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_node_len(s : TimeseriesvarNode) -> Int { s.size }

pub fn timeseries_var_node_get(s : TimeseriesvarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_node_set(s : TimeseriesvarNode, i : Int, v : Double) -> TimeseriesvarNode {
  let result = timeseries_var_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_node_sum(s : TimeseriesvarNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_node_mean(s : TimeseriesvarNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_node_scale(s : TimeseriesvarNode, f : Double) -> TimeseriesvarNode {
  let result = timeseries_var_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_node_add(a : TimeseriesvarNode, b : TimeseriesvarNode) -> TimeseriesvarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_node_copy(s : TimeseriesvarNode) -> TimeseriesvarNode {
  let result = timeseries_var_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_node_fill(s : TimeseriesvarNode, v : Double) -> TimeseriesvarNode {
  let result = timeseries_var_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_node_min(s : TimeseriesvarNode) -> Double { @_common.min(s.data) }

pub fn timeseries_var_node_max(s : TimeseriesvarNode) -> Double { @_common.max(s.data) }

pub fn timeseries_var_node_to_string(s : TimeseriesvarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_edge_make(size : Int) -> TimeseriesvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_edge_len(s : TimeseriesvarEdge) -> Int { s.size }

pub fn timeseries_var_edge_get(s : TimeseriesvarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_edge_set(s : TimeseriesvarEdge, i : Int, v : Double) -> TimeseriesvarEdge {
  let result = timeseries_var_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_edge_sum(s : TimeseriesvarEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_edge_mean(s : TimeseriesvarEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_edge_scale(s : TimeseriesvarEdge, f : Double) -> TimeseriesvarEdge {
  let result = timeseries_var_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_edge_add(a : TimeseriesvarEdge, b : TimeseriesvarEdge) -> TimeseriesvarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_edge_copy(s : TimeseriesvarEdge) -> TimeseriesvarEdge {
  let result = timeseries_var_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_edge_fill(s : TimeseriesvarEdge, v : Double) -> TimeseriesvarEdge {
  let result = timeseries_var_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_edge_min(s : TimeseriesvarEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_var_edge_max(s : TimeseriesvarEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_var_edge_to_string(s : TimeseriesvarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_path_make(size : Int) -> TimeseriesvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_path_len(s : TimeseriesvarPath) -> Int { s.size }

pub fn timeseries_var_path_get(s : TimeseriesvarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_path_set(s : TimeseriesvarPath, i : Int, v : Double) -> TimeseriesvarPath {
  let result = timeseries_var_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_path_sum(s : TimeseriesvarPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_path_mean(s : TimeseriesvarPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_path_scale(s : TimeseriesvarPath, f : Double) -> TimeseriesvarPath {
  let result = timeseries_var_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_path_add(a : TimeseriesvarPath, b : TimeseriesvarPath) -> TimeseriesvarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_path_copy(s : TimeseriesvarPath) -> TimeseriesvarPath {
  let result = timeseries_var_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_path_fill(s : TimeseriesvarPath, v : Double) -> TimeseriesvarPath {
  let result = timeseries_var_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_path_min(s : TimeseriesvarPath) -> Double { @_common.min(s.data) }

pub fn timeseries_var_path_max(s : TimeseriesvarPath) -> Double { @_common.max(s.data) }

pub fn timeseries_var_path_to_string(s : TimeseriesvarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_cluster_make(size : Int) -> TimeseriesvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_cluster_len(s : TimeseriesvarCluster) -> Int { s.size }

pub fn timeseries_var_cluster_get(s : TimeseriesvarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_cluster_set(s : TimeseriesvarCluster, i : Int, v : Double) -> TimeseriesvarCluster {
  let result = timeseries_var_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_cluster_sum(s : TimeseriesvarCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_cluster_mean(s : TimeseriesvarCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_cluster_scale(s : TimeseriesvarCluster, f : Double) -> TimeseriesvarCluster {
  let result = timeseries_var_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_cluster_add(a : TimeseriesvarCluster, b : TimeseriesvarCluster) -> TimeseriesvarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_cluster_copy(s : TimeseriesvarCluster) -> TimeseriesvarCluster {
  let result = timeseries_var_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_cluster_fill(s : TimeseriesvarCluster, v : Double) -> TimeseriesvarCluster {
  let result = timeseries_var_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_cluster_min(s : TimeseriesvarCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_var_cluster_max(s : TimeseriesvarCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_var_cluster_to_string(s : TimeseriesvarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_model_make(size : Int) -> TimeseriesvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_model_len(s : TimeseriesvarModel) -> Int { s.size }

pub fn timeseries_var_model_get(s : TimeseriesvarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_model_set(s : TimeseriesvarModel, i : Int, v : Double) -> TimeseriesvarModel {
  let result = timeseries_var_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_model_sum(s : TimeseriesvarModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_model_mean(s : TimeseriesvarModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_model_scale(s : TimeseriesvarModel, f : Double) -> TimeseriesvarModel {
  let result = timeseries_var_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_model_add(a : TimeseriesvarModel, b : TimeseriesvarModel) -> TimeseriesvarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_model_copy(s : TimeseriesvarModel) -> TimeseriesvarModel {
  let result = timeseries_var_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_model_fill(s : TimeseriesvarModel, v : Double) -> TimeseriesvarModel {
  let result = timeseries_var_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_model_min(s : TimeseriesvarModel) -> Double { @_common.min(s.data) }

pub fn timeseries_var_model_max(s : TimeseriesvarModel) -> Double { @_common.max(s.data) }

pub fn timeseries_var_model_to_string(s : TimeseriesvarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_layer_make(size : Int) -> TimeseriesvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_layer_len(s : TimeseriesvarLayer) -> Int { s.size }

pub fn timeseries_var_layer_get(s : TimeseriesvarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_layer_set(s : TimeseriesvarLayer, i : Int, v : Double) -> TimeseriesvarLayer {
  let result = timeseries_var_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_layer_sum(s : TimeseriesvarLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_layer_mean(s : TimeseriesvarLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_layer_scale(s : TimeseriesvarLayer, f : Double) -> TimeseriesvarLayer {
  let result = timeseries_var_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_layer_add(a : TimeseriesvarLayer, b : TimeseriesvarLayer) -> TimeseriesvarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_layer_copy(s : TimeseriesvarLayer) -> TimeseriesvarLayer {
  let result = timeseries_var_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_layer_fill(s : TimeseriesvarLayer, v : Double) -> TimeseriesvarLayer {
  let result = timeseries_var_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_layer_min(s : TimeseriesvarLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_var_layer_max(s : TimeseriesvarLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_var_layer_to_string(s : TimeseriesvarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_buffer_make(size : Int) -> TimeseriesvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_buffer_len(s : TimeseriesvarBuffer) -> Int { s.size }

pub fn timeseries_var_buffer_get(s : TimeseriesvarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_buffer_set(s : TimeseriesvarBuffer, i : Int, v : Double) -> TimeseriesvarBuffer {
  let result = timeseries_var_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_buffer_sum(s : TimeseriesvarBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_buffer_mean(s : TimeseriesvarBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_buffer_scale(s : TimeseriesvarBuffer, f : Double) -> TimeseriesvarBuffer {
  let result = timeseries_var_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_buffer_add(a : TimeseriesvarBuffer, b : TimeseriesvarBuffer) -> TimeseriesvarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_buffer_copy(s : TimeseriesvarBuffer) -> TimeseriesvarBuffer {
  let result = timeseries_var_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_buffer_fill(s : TimeseriesvarBuffer, v : Double) -> TimeseriesvarBuffer {
  let result = timeseries_var_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_buffer_min(s : TimeseriesvarBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_var_buffer_max(s : TimeseriesvarBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_var_buffer_to_string(s : TimeseriesvarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_cursor_make(size : Int) -> TimeseriesvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_cursor_len(s : TimeseriesvarCursor) -> Int { s.size }

pub fn timeseries_var_cursor_get(s : TimeseriesvarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_cursor_set(s : TimeseriesvarCursor, i : Int, v : Double) -> TimeseriesvarCursor {
  let result = timeseries_var_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_cursor_sum(s : TimeseriesvarCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_cursor_mean(s : TimeseriesvarCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_cursor_scale(s : TimeseriesvarCursor, f : Double) -> TimeseriesvarCursor {
  let result = timeseries_var_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_cursor_add(a : TimeseriesvarCursor, b : TimeseriesvarCursor) -> TimeseriesvarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_cursor_copy(s : TimeseriesvarCursor) -> TimeseriesvarCursor {
  let result = timeseries_var_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_cursor_fill(s : TimeseriesvarCursor, v : Double) -> TimeseriesvarCursor {
  let result = timeseries_var_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_cursor_min(s : TimeseriesvarCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_var_cursor_max(s : TimeseriesvarCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_var_cursor_to_string(s : TimeseriesvarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_view_make(size : Int) -> TimeseriesvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_view_len(s : TimeseriesvarView) -> Int { s.size }

pub fn timeseries_var_view_get(s : TimeseriesvarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_view_set(s : TimeseriesvarView, i : Int, v : Double) -> TimeseriesvarView {
  let result = timeseries_var_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_view_sum(s : TimeseriesvarView) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_view_mean(s : TimeseriesvarView) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_view_scale(s : TimeseriesvarView, f : Double) -> TimeseriesvarView {
  let result = timeseries_var_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_view_add(a : TimeseriesvarView, b : TimeseriesvarView) -> TimeseriesvarView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_view_copy(s : TimeseriesvarView) -> TimeseriesvarView {
  let result = timeseries_var_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_view_fill(s : TimeseriesvarView, v : Double) -> TimeseriesvarView {
  let result = timeseries_var_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_view_min(s : TimeseriesvarView) -> Double { @_common.min(s.data) }

pub fn timeseries_var_view_max(s : TimeseriesvarView) -> Double { @_common.max(s.data) }

pub fn timeseries_var_view_to_string(s : TimeseriesvarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_range_make(size : Int) -> TimeseriesvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_range_len(s : TimeseriesvarRange) -> Int { s.size }

pub fn timeseries_var_range_get(s : TimeseriesvarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_range_set(s : TimeseriesvarRange, i : Int, v : Double) -> TimeseriesvarRange {
  let result = timeseries_var_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_range_sum(s : TimeseriesvarRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_range_mean(s : TimeseriesvarRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_range_scale(s : TimeseriesvarRange, f : Double) -> TimeseriesvarRange {
  let result = timeseries_var_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_range_add(a : TimeseriesvarRange, b : TimeseriesvarRange) -> TimeseriesvarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_range_copy(s : TimeseriesvarRange) -> TimeseriesvarRange {
  let result = timeseries_var_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_range_fill(s : TimeseriesvarRange, v : Double) -> TimeseriesvarRange {
  let result = timeseries_var_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_range_min(s : TimeseriesvarRange) -> Double { @_common.min(s.data) }

pub fn timeseries_var_range_max(s : TimeseriesvarRange) -> Double { @_common.max(s.data) }

pub fn timeseries_var_range_to_string(s : TimeseriesvarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_slice_make(size : Int) -> TimeseriesvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_slice_len(s : TimeseriesvarSlice) -> Int { s.size }

pub fn timeseries_var_slice_get(s : TimeseriesvarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_slice_set(s : TimeseriesvarSlice, i : Int, v : Double) -> TimeseriesvarSlice {
  let result = timeseries_var_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_slice_sum(s : TimeseriesvarSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_slice_mean(s : TimeseriesvarSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_slice_scale(s : TimeseriesvarSlice, f : Double) -> TimeseriesvarSlice {
  let result = timeseries_var_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_var_slice_add(a : TimeseriesvarSlice, b : TimeseriesvarSlice) -> TimeseriesvarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_var_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_var_slice_copy(s : TimeseriesvarSlice) -> TimeseriesvarSlice {
  let result = timeseries_var_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_var_slice_fill(s : TimeseriesvarSlice, v : Double) -> TimeseriesvarSlice {
  let result = timeseries_var_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_var_slice_min(s : TimeseriesvarSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_var_slice_max(s : TimeseriesvarSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_var_slice_to_string(s : TimeseriesvarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

