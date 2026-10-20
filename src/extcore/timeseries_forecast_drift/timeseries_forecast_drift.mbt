///===
/// extcore/timeseries_forecast_drift

pub(all) struct TimeseriesforecastdriftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_drift_make_point(x : Double, y : Double) -> TimeseriesforecastdriftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_drift_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastdriftPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_drift_point_x(pt : TimeseriesforecastdriftPoint) -> Double { pt.x }

pub fn timeseries_forecast_drift_point_y(pt : TimeseriesforecastdriftPoint) -> Double { pt.y }

pub fn timeseries_forecast_drift_point_z(pt : TimeseriesforecastdriftPoint) -> Double { pt.z }

pub fn timeseries_forecast_drift_point_label(pt : TimeseriesforecastdriftPoint) -> Int { pt.label }

pub fn timeseries_forecast_drift_point_dist(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_drift_point_add(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_drift_point_sub(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_drift_point_scale(pt : TimeseriesforecastdriftPoint, s : Double) -> TimeseriesforecastdriftPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_drift_point_dot(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_drift_point_cross(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_drift_point_norm(pt : TimeseriesforecastdriftPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_drift_point_normalize(pt : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  let n = timeseries_forecast_drift_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_drift_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_drift_point_negate(pt : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_drift_point_mid(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_drift_point_lerp(a : TimeseriesforecastdriftPoint, b : TimeseriesforecastdriftPoint, t : Double) -> TimeseriesforecastdriftPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_drift_point_to_string(pt : TimeseriesforecastdriftPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_drift_make_series(vals : Array[Double], name : String) -> TimeseriesforecastdriftSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_drift_series_len(s : TimeseriesforecastdriftSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_drift_series_sum(s : TimeseriesforecastdriftSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_forecast_drift_series_mean(s : TimeseriesforecastdriftSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_drift_series_min(s : TimeseriesforecastdriftSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_drift_series_max(s : TimeseriesforecastdriftSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_drift_series_range(s : TimeseriesforecastdriftSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_drift_series_var(s : TimeseriesforecastdriftSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_drift_series_std(s : TimeseriesforecastdriftSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_drift_series_median(s : TimeseriesforecastdriftSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_drift_series_scale(s : TimeseriesforecastdriftSeries, f : Double) -> TimeseriesforecastdriftSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_drift_series_add(a : TimeseriesforecastdriftSeries, b : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_drift_series_sub(a : TimeseriesforecastdriftSeries, b : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_drift_series_normalize(s : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let mn = timeseries_forecast_drift_series_min(s)
  let mx = timeseries_forecast_drift_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_drift_series_cumsum(s : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_drift_series_to_string(s : TimeseriesforecastdriftSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdriftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_drift_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastdriftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_drift_matrix_identity(n : Int) -> TimeseriesforecastdriftMatrix {
  let m = timeseries_forecast_drift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_drift_matrix_get(m : TimeseriesforecastdriftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_drift_matrix_transpose(m : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  let result = timeseries_forecast_drift_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_drift_matrix_add(a : TimeseriesforecastdriftMatrix, b : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_drift_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_drift_matrix_scale(m : TimeseriesforecastdriftMatrix, s : Double) -> TimeseriesforecastdriftMatrix {
  let result = timeseries_forecast_drift_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_drift_matrix_multiply(a : TimeseriesforecastdriftMatrix, b : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  if a.cols != b.rows { return timeseries_forecast_drift_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_drift_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_drift_matrix_trace(m : TimeseriesforecastdriftMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_drift_matrix_det(m : TimeseriesforecastdriftMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_drift_matrix_norm(m : TimeseriesforecastdriftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_drift_matrix_to_string(m : TimeseriesforecastdriftMatrix) -> String {
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

pub(all) struct TimeseriesforecastdriftVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_drift_make_vector(comps : Array[Double]) -> TimeseriesforecastdriftVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_drift_vector_zero(dim : Int) -> TimeseriesforecastdriftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_drift_vector_add(a : TimeseriesforecastdriftVector, b : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_drift_vector_sub(a : TimeseriesforecastdriftVector, b : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_drift_vector_scale(v : TimeseriesforecastdriftVector, s : Double) -> TimeseriesforecastdriftVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_drift_vector_dot(a : TimeseriesforecastdriftVector, b : TimeseriesforecastdriftVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_drift_vector_norm(v : TimeseriesforecastdriftVector) -> Double { @_common.sqrt(timeseries_forecast_drift_vector_dot(v, v)) }

pub fn timeseries_forecast_drift_vector_normalize(v : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = timeseries_forecast_drift_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_drift_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_drift_vector_dist(a : TimeseriesforecastdriftVector, b : TimeseriesforecastdriftVector) -> Double {
  timeseries_forecast_drift_vector_norm(timeseries_forecast_drift_vector_sub(a, b))
}

pub fn timeseries_forecast_drift_vector_to_string(v : TimeseriesforecastdriftVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_drift_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_drift_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_drift_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_drift_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_drift_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_drift_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_drift_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_drift_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_drift_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_drift_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_drift_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_drift_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_drift_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_drift_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_drift_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_drift_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_drift_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_drift_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_drift_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_drift_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_drift_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_drift_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_drift_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_drift_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_drift_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_drift_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_drift_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_drift_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_drift_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastdriftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_frame_make(size : Int) -> TimeseriesforecastdriftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_frame_len(s : TimeseriesforecastdriftFrame) -> Int { s.size }

pub fn timeseries_forecast_drift_frame_get(s : TimeseriesforecastdriftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_frame_set(s : TimeseriesforecastdriftFrame, i : Int, v : Double) -> TimeseriesforecastdriftFrame {
  let result = timeseries_forecast_drift_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_frame_sum(s : TimeseriesforecastdriftFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_frame_mean(s : TimeseriesforecastdriftFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_frame_scale(s : TimeseriesforecastdriftFrame, f : Double) -> TimeseriesforecastdriftFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_frame_add(a : TimeseriesforecastdriftFrame, b : TimeseriesforecastdriftFrame) -> TimeseriesforecastdriftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_frame_copy(s : TimeseriesforecastdriftFrame) -> TimeseriesforecastdriftFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_frame_fill(s : TimeseriesforecastdriftFrame, v : Double) -> TimeseriesforecastdriftFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_frame_min(s : TimeseriesforecastdriftFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_frame_max(s : TimeseriesforecastdriftFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_frame_to_string(s : TimeseriesforecastdriftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_table_make(size : Int) -> TimeseriesforecastdriftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_table_len(s : TimeseriesforecastdriftTable) -> Int { s.size }

pub fn timeseries_forecast_drift_table_get(s : TimeseriesforecastdriftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_table_set(s : TimeseriesforecastdriftTable, i : Int, v : Double) -> TimeseriesforecastdriftTable {
  let result = timeseries_forecast_drift_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_table_sum(s : TimeseriesforecastdriftTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_table_mean(s : TimeseriesforecastdriftTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_table_scale(s : TimeseriesforecastdriftTable, f : Double) -> TimeseriesforecastdriftTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_table_add(a : TimeseriesforecastdriftTable, b : TimeseriesforecastdriftTable) -> TimeseriesforecastdriftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_table_copy(s : TimeseriesforecastdriftTable) -> TimeseriesforecastdriftTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_table_fill(s : TimeseriesforecastdriftTable, v : Double) -> TimeseriesforecastdriftTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_table_min(s : TimeseriesforecastdriftTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_table_max(s : TimeseriesforecastdriftTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_table_to_string(s : TimeseriesforecastdriftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_graphn_make(size : Int) -> TimeseriesforecastdriftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_graphn_len(s : TimeseriesforecastdriftGraphN) -> Int { s.size }

pub fn timeseries_forecast_drift_graphn_get(s : TimeseriesforecastdriftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_graphn_set(s : TimeseriesforecastdriftGraphN, i : Int, v : Double) -> TimeseriesforecastdriftGraphN {
  let result = timeseries_forecast_drift_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_graphn_sum(s : TimeseriesforecastdriftGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_graphn_mean(s : TimeseriesforecastdriftGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_graphn_scale(s : TimeseriesforecastdriftGraphN, f : Double) -> TimeseriesforecastdriftGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_graphn_add(a : TimeseriesforecastdriftGraphN, b : TimeseriesforecastdriftGraphN) -> TimeseriesforecastdriftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_graphn_copy(s : TimeseriesforecastdriftGraphN) -> TimeseriesforecastdriftGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_graphn_fill(s : TimeseriesforecastdriftGraphN, v : Double) -> TimeseriesforecastdriftGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_graphn_min(s : TimeseriesforecastdriftGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_graphn_max(s : TimeseriesforecastdriftGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_graphn_to_string(s : TimeseriesforecastdriftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_node_make(size : Int) -> TimeseriesforecastdriftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_node_len(s : TimeseriesforecastdriftNode) -> Int { s.size }

pub fn timeseries_forecast_drift_node_get(s : TimeseriesforecastdriftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_node_set(s : TimeseriesforecastdriftNode, i : Int, v : Double) -> TimeseriesforecastdriftNode {
  let result = timeseries_forecast_drift_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_node_sum(s : TimeseriesforecastdriftNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_node_mean(s : TimeseriesforecastdriftNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_node_scale(s : TimeseriesforecastdriftNode, f : Double) -> TimeseriesforecastdriftNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_node_add(a : TimeseriesforecastdriftNode, b : TimeseriesforecastdriftNode) -> TimeseriesforecastdriftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_node_copy(s : TimeseriesforecastdriftNode) -> TimeseriesforecastdriftNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_node_fill(s : TimeseriesforecastdriftNode, v : Double) -> TimeseriesforecastdriftNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_node_min(s : TimeseriesforecastdriftNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_node_max(s : TimeseriesforecastdriftNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_node_to_string(s : TimeseriesforecastdriftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_edge_make(size : Int) -> TimeseriesforecastdriftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_edge_len(s : TimeseriesforecastdriftEdge) -> Int { s.size }

pub fn timeseries_forecast_drift_edge_get(s : TimeseriesforecastdriftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_edge_set(s : TimeseriesforecastdriftEdge, i : Int, v : Double) -> TimeseriesforecastdriftEdge {
  let result = timeseries_forecast_drift_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_edge_sum(s : TimeseriesforecastdriftEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_edge_mean(s : TimeseriesforecastdriftEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_edge_scale(s : TimeseriesforecastdriftEdge, f : Double) -> TimeseriesforecastdriftEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_edge_add(a : TimeseriesforecastdriftEdge, b : TimeseriesforecastdriftEdge) -> TimeseriesforecastdriftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_edge_copy(s : TimeseriesforecastdriftEdge) -> TimeseriesforecastdriftEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_edge_fill(s : TimeseriesforecastdriftEdge, v : Double) -> TimeseriesforecastdriftEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_edge_min(s : TimeseriesforecastdriftEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_edge_max(s : TimeseriesforecastdriftEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_edge_to_string(s : TimeseriesforecastdriftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_path_make(size : Int) -> TimeseriesforecastdriftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_path_len(s : TimeseriesforecastdriftPath) -> Int { s.size }

pub fn timeseries_forecast_drift_path_get(s : TimeseriesforecastdriftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_path_set(s : TimeseriesforecastdriftPath, i : Int, v : Double) -> TimeseriesforecastdriftPath {
  let result = timeseries_forecast_drift_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_path_sum(s : TimeseriesforecastdriftPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_path_mean(s : TimeseriesforecastdriftPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_path_scale(s : TimeseriesforecastdriftPath, f : Double) -> TimeseriesforecastdriftPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_path_add(a : TimeseriesforecastdriftPath, b : TimeseriesforecastdriftPath) -> TimeseriesforecastdriftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_path_copy(s : TimeseriesforecastdriftPath) -> TimeseriesforecastdriftPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_path_fill(s : TimeseriesforecastdriftPath, v : Double) -> TimeseriesforecastdriftPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_path_min(s : TimeseriesforecastdriftPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_path_max(s : TimeseriesforecastdriftPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_path_to_string(s : TimeseriesforecastdriftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_cluster_make(size : Int) -> TimeseriesforecastdriftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_cluster_len(s : TimeseriesforecastdriftCluster) -> Int { s.size }

pub fn timeseries_forecast_drift_cluster_get(s : TimeseriesforecastdriftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_cluster_set(s : TimeseriesforecastdriftCluster, i : Int, v : Double) -> TimeseriesforecastdriftCluster {
  let result = timeseries_forecast_drift_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_cluster_sum(s : TimeseriesforecastdriftCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_cluster_mean(s : TimeseriesforecastdriftCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_cluster_scale(s : TimeseriesforecastdriftCluster, f : Double) -> TimeseriesforecastdriftCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cluster_add(a : TimeseriesforecastdriftCluster, b : TimeseriesforecastdriftCluster) -> TimeseriesforecastdriftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_cluster_copy(s : TimeseriesforecastdriftCluster) -> TimeseriesforecastdriftCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cluster_fill(s : TimeseriesforecastdriftCluster, v : Double) -> TimeseriesforecastdriftCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cluster_min(s : TimeseriesforecastdriftCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_cluster_max(s : TimeseriesforecastdriftCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_cluster_to_string(s : TimeseriesforecastdriftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_model_make(size : Int) -> TimeseriesforecastdriftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_model_len(s : TimeseriesforecastdriftModel) -> Int { s.size }

pub fn timeseries_forecast_drift_model_get(s : TimeseriesforecastdriftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_model_set(s : TimeseriesforecastdriftModel, i : Int, v : Double) -> TimeseriesforecastdriftModel {
  let result = timeseries_forecast_drift_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_model_sum(s : TimeseriesforecastdriftModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_model_mean(s : TimeseriesforecastdriftModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_model_scale(s : TimeseriesforecastdriftModel, f : Double) -> TimeseriesforecastdriftModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_model_add(a : TimeseriesforecastdriftModel, b : TimeseriesforecastdriftModel) -> TimeseriesforecastdriftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_model_copy(s : TimeseriesforecastdriftModel) -> TimeseriesforecastdriftModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_model_fill(s : TimeseriesforecastdriftModel, v : Double) -> TimeseriesforecastdriftModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_model_min(s : TimeseriesforecastdriftModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_model_max(s : TimeseriesforecastdriftModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_model_to_string(s : TimeseriesforecastdriftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_layer_make(size : Int) -> TimeseriesforecastdriftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_layer_len(s : TimeseriesforecastdriftLayer) -> Int { s.size }

pub fn timeseries_forecast_drift_layer_get(s : TimeseriesforecastdriftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_layer_set(s : TimeseriesforecastdriftLayer, i : Int, v : Double) -> TimeseriesforecastdriftLayer {
  let result = timeseries_forecast_drift_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_layer_sum(s : TimeseriesforecastdriftLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_layer_mean(s : TimeseriesforecastdriftLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_layer_scale(s : TimeseriesforecastdriftLayer, f : Double) -> TimeseriesforecastdriftLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_layer_add(a : TimeseriesforecastdriftLayer, b : TimeseriesforecastdriftLayer) -> TimeseriesforecastdriftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_layer_copy(s : TimeseriesforecastdriftLayer) -> TimeseriesforecastdriftLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_layer_fill(s : TimeseriesforecastdriftLayer, v : Double) -> TimeseriesforecastdriftLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_layer_min(s : TimeseriesforecastdriftLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_layer_max(s : TimeseriesforecastdriftLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_layer_to_string(s : TimeseriesforecastdriftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_buffer_make(size : Int) -> TimeseriesforecastdriftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_buffer_len(s : TimeseriesforecastdriftBuffer) -> Int { s.size }

pub fn timeseries_forecast_drift_buffer_get(s : TimeseriesforecastdriftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_buffer_set(s : TimeseriesforecastdriftBuffer, i : Int, v : Double) -> TimeseriesforecastdriftBuffer {
  let result = timeseries_forecast_drift_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_buffer_sum(s : TimeseriesforecastdriftBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_buffer_mean(s : TimeseriesforecastdriftBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_buffer_scale(s : TimeseriesforecastdriftBuffer, f : Double) -> TimeseriesforecastdriftBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_buffer_add(a : TimeseriesforecastdriftBuffer, b : TimeseriesforecastdriftBuffer) -> TimeseriesforecastdriftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_buffer_copy(s : TimeseriesforecastdriftBuffer) -> TimeseriesforecastdriftBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_buffer_fill(s : TimeseriesforecastdriftBuffer, v : Double) -> TimeseriesforecastdriftBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_buffer_min(s : TimeseriesforecastdriftBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_buffer_max(s : TimeseriesforecastdriftBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_buffer_to_string(s : TimeseriesforecastdriftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_cursor_make(size : Int) -> TimeseriesforecastdriftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_cursor_len(s : TimeseriesforecastdriftCursor) -> Int { s.size }

pub fn timeseries_forecast_drift_cursor_get(s : TimeseriesforecastdriftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_cursor_set(s : TimeseriesforecastdriftCursor, i : Int, v : Double) -> TimeseriesforecastdriftCursor {
  let result = timeseries_forecast_drift_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_cursor_sum(s : TimeseriesforecastdriftCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_cursor_mean(s : TimeseriesforecastdriftCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_cursor_scale(s : TimeseriesforecastdriftCursor, f : Double) -> TimeseriesforecastdriftCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cursor_add(a : TimeseriesforecastdriftCursor, b : TimeseriesforecastdriftCursor) -> TimeseriesforecastdriftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_cursor_copy(s : TimeseriesforecastdriftCursor) -> TimeseriesforecastdriftCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cursor_fill(s : TimeseriesforecastdriftCursor, v : Double) -> TimeseriesforecastdriftCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cursor_min(s : TimeseriesforecastdriftCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_cursor_max(s : TimeseriesforecastdriftCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_cursor_to_string(s : TimeseriesforecastdriftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_view_make(size : Int) -> TimeseriesforecastdriftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_view_len(s : TimeseriesforecastdriftView) -> Int { s.size }

pub fn timeseries_forecast_drift_view_get(s : TimeseriesforecastdriftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_view_set(s : TimeseriesforecastdriftView, i : Int, v : Double) -> TimeseriesforecastdriftView {
  let result = timeseries_forecast_drift_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_view_sum(s : TimeseriesforecastdriftView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_view_mean(s : TimeseriesforecastdriftView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_view_scale(s : TimeseriesforecastdriftView, f : Double) -> TimeseriesforecastdriftView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_view_add(a : TimeseriesforecastdriftView, b : TimeseriesforecastdriftView) -> TimeseriesforecastdriftView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_view_copy(s : TimeseriesforecastdriftView) -> TimeseriesforecastdriftView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_view_fill(s : TimeseriesforecastdriftView, v : Double) -> TimeseriesforecastdriftView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_view_min(s : TimeseriesforecastdriftView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_view_max(s : TimeseriesforecastdriftView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_view_to_string(s : TimeseriesforecastdriftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_range_make(size : Int) -> TimeseriesforecastdriftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_range_len(s : TimeseriesforecastdriftRange) -> Int { s.size }

pub fn timeseries_forecast_drift_range_get(s : TimeseriesforecastdriftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_range_set(s : TimeseriesforecastdriftRange, i : Int, v : Double) -> TimeseriesforecastdriftRange {
  let result = timeseries_forecast_drift_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_range_sum(s : TimeseriesforecastdriftRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_range_mean(s : TimeseriesforecastdriftRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_range_scale(s : TimeseriesforecastdriftRange, f : Double) -> TimeseriesforecastdriftRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_range_add(a : TimeseriesforecastdriftRange, b : TimeseriesforecastdriftRange) -> TimeseriesforecastdriftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_range_copy(s : TimeseriesforecastdriftRange) -> TimeseriesforecastdriftRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_range_fill(s : TimeseriesforecastdriftRange, v : Double) -> TimeseriesforecastdriftRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_range_min(s : TimeseriesforecastdriftRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_range_max(s : TimeseriesforecastdriftRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_range_to_string(s : TimeseriesforecastdriftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_slice_make(size : Int) -> TimeseriesforecastdriftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_slice_len(s : TimeseriesforecastdriftSlice) -> Int { s.size }

pub fn timeseries_forecast_drift_slice_get(s : TimeseriesforecastdriftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_slice_set(s : TimeseriesforecastdriftSlice, i : Int, v : Double) -> TimeseriesforecastdriftSlice {
  let result = timeseries_forecast_drift_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_drift_slice_sum(s : TimeseriesforecastdriftSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_slice_mean(s : TimeseriesforecastdriftSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_slice_scale(s : TimeseriesforecastdriftSlice, f : Double) -> TimeseriesforecastdriftSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_slice_add(a : TimeseriesforecastdriftSlice, b : TimeseriesforecastdriftSlice) -> TimeseriesforecastdriftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_slice_copy(s : TimeseriesforecastdriftSlice) -> TimeseriesforecastdriftSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_slice_fill(s : TimeseriesforecastdriftSlice, v : Double) -> TimeseriesforecastdriftSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_slice_min(s : TimeseriesforecastdriftSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_slice_max(s : TimeseriesforecastdriftSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_slice_to_string(s : TimeseriesforecastdriftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

