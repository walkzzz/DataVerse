///===
/// extcore/timeseries_forecast_seasonal

pub(all) struct TimeseriesforecastseasonalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_seasonal_make_point(x : Double, y : Double) -> TimeseriesforecastseasonalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_seasonal_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastseasonalPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_seasonal_point_x(pt : TimeseriesforecastseasonalPoint) -> Double { pt.x }

pub fn timeseries_forecast_seasonal_point_y(pt : TimeseriesforecastseasonalPoint) -> Double { pt.y }

pub fn timeseries_forecast_seasonal_point_z(pt : TimeseriesforecastseasonalPoint) -> Double { pt.z }

pub fn timeseries_forecast_seasonal_point_label(pt : TimeseriesforecastseasonalPoint) -> Int { pt.label }

pub fn timeseries_forecast_seasonal_point_dist(a : TimeseriesforecastseasonalPoint, b : TimeseriesforecastseasonalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_seasonal_point_add(a : TimeseriesforecastseasonalPoint, b : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_seasonal_point_sub(a : TimeseriesforecastseasonalPoint, b : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_seasonal_point_scale(pt : TimeseriesforecastseasonalPoint, s : Double) -> TimeseriesforecastseasonalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_seasonal_point_dot(a : TimeseriesforecastseasonalPoint, b : TimeseriesforecastseasonalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_seasonal_point_cross(a : TimeseriesforecastseasonalPoint, b : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_seasonal_point_norm(pt : TimeseriesforecastseasonalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_seasonal_point_normalize(pt : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  let n = timeseries_forecast_seasonal_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_seasonal_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_seasonal_point_negate(pt : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_seasonal_point_mid(a : TimeseriesforecastseasonalPoint, b : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_seasonal_point_lerp(a : TimeseriesforecastseasonalPoint, b : TimeseriesforecastseasonalPoint, t : Double) -> TimeseriesforecastseasonalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_seasonal_point_to_string(pt : TimeseriesforecastseasonalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_seasonal_make_series(vals : Array[Double], name : String) -> TimeseriesforecastseasonalSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_seasonal_series_len(s : TimeseriesforecastseasonalSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_seasonal_series_sum(s : TimeseriesforecastseasonalSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_forecast_seasonal_series_mean(s : TimeseriesforecastseasonalSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_seasonal_series_min(s : TimeseriesforecastseasonalSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_seasonal_series_max(s : TimeseriesforecastseasonalSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_seasonal_series_range(s : TimeseriesforecastseasonalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_seasonal_series_var(s : TimeseriesforecastseasonalSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_seasonal_series_std(s : TimeseriesforecastseasonalSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_seasonal_series_median(s : TimeseriesforecastseasonalSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_seasonal_series_scale(s : TimeseriesforecastseasonalSeries, f : Double) -> TimeseriesforecastseasonalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_seasonal_series_add(a : TimeseriesforecastseasonalSeries, b : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_seasonal_series_sub(a : TimeseriesforecastseasonalSeries, b : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_seasonal_series_normalize(s : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  let mn = timeseries_forecast_seasonal_series_min(s)
  let mx = timeseries_forecast_seasonal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_seasonal_series_cumsum(s : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_seasonal_series_to_string(s : TimeseriesforecastseasonalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastseasonalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_seasonal_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastseasonalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_seasonal_matrix_identity(n : Int) -> TimeseriesforecastseasonalMatrix {
  let m = timeseries_forecast_seasonal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_seasonal_matrix_get(m : TimeseriesforecastseasonalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_seasonal_matrix_transpose(m : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  let result = timeseries_forecast_seasonal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_seasonal_matrix_add(a : TimeseriesforecastseasonalMatrix, b : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_seasonal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_seasonal_matrix_scale(m : TimeseriesforecastseasonalMatrix, s : Double) -> TimeseriesforecastseasonalMatrix {
  let result = timeseries_forecast_seasonal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_seasonal_matrix_multiply(a : TimeseriesforecastseasonalMatrix, b : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  if a.cols != b.rows { return timeseries_forecast_seasonal_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_seasonal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_seasonal_matrix_trace(m : TimeseriesforecastseasonalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_seasonal_matrix_det(m : TimeseriesforecastseasonalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_seasonal_matrix_norm(m : TimeseriesforecastseasonalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_seasonal_matrix_to_string(m : TimeseriesforecastseasonalMatrix) -> String {
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

pub(all) struct TimeseriesforecastseasonalVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_seasonal_make_vector(comps : Array[Double]) -> TimeseriesforecastseasonalVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_seasonal_vector_zero(dim : Int) -> TimeseriesforecastseasonalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_seasonal_vector_add(a : TimeseriesforecastseasonalVector, b : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_seasonal_vector_sub(a : TimeseriesforecastseasonalVector, b : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_seasonal_vector_scale(v : TimeseriesforecastseasonalVector, s : Double) -> TimeseriesforecastseasonalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_seasonal_vector_dot(a : TimeseriesforecastseasonalVector, b : TimeseriesforecastseasonalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_seasonal_vector_norm(v : TimeseriesforecastseasonalVector) -> Double { @_common.sqrt(timeseries_forecast_seasonal_vector_dot(v, v)) }

pub fn timeseries_forecast_seasonal_vector_normalize(v : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = timeseries_forecast_seasonal_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_seasonal_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_seasonal_vector_dist(a : TimeseriesforecastseasonalVector, b : TimeseriesforecastseasonalVector) -> Double {
  timeseries_forecast_seasonal_vector_norm(timeseries_forecast_seasonal_vector_sub(a, b))
}

pub fn timeseries_forecast_seasonal_vector_to_string(v : TimeseriesforecastseasonalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_seasonal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_seasonal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_seasonal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_seasonal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_seasonal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_seasonal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_seasonal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_seasonal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_seasonal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_seasonal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_seasonal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_seasonal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_seasonal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_seasonal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_seasonal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_seasonal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_seasonal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_seasonal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_seasonal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_seasonal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_seasonal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_seasonal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_seasonal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_seasonal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_seasonal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_seasonal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_seasonal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_seasonal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_seasonal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastseasonalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_frame_make(size : Int) -> TimeseriesforecastseasonalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_frame_len(s : TimeseriesforecastseasonalFrame) -> Int { s.size }

pub fn timeseries_forecast_seasonal_frame_get(s : TimeseriesforecastseasonalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_frame_set(s : TimeseriesforecastseasonalFrame, i : Int, v : Double) -> TimeseriesforecastseasonalFrame {
  let result = timeseries_forecast_seasonal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_frame_sum(s : TimeseriesforecastseasonalFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_frame_mean(s : TimeseriesforecastseasonalFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_frame_scale(s : TimeseriesforecastseasonalFrame, f : Double) -> TimeseriesforecastseasonalFrame {
  let result = timeseries_forecast_seasonal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_frame_add(a : TimeseriesforecastseasonalFrame, b : TimeseriesforecastseasonalFrame) -> TimeseriesforecastseasonalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_frame_copy(s : TimeseriesforecastseasonalFrame) -> TimeseriesforecastseasonalFrame {
  let result = timeseries_forecast_seasonal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_frame_fill(s : TimeseriesforecastseasonalFrame, v : Double) -> TimeseriesforecastseasonalFrame {
  let result = timeseries_forecast_seasonal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_frame_min(s : TimeseriesforecastseasonalFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_frame_max(s : TimeseriesforecastseasonalFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_frame_to_string(s : TimeseriesforecastseasonalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_table_make(size : Int) -> TimeseriesforecastseasonalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_table_len(s : TimeseriesforecastseasonalTable) -> Int { s.size }

pub fn timeseries_forecast_seasonal_table_get(s : TimeseriesforecastseasonalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_table_set(s : TimeseriesforecastseasonalTable, i : Int, v : Double) -> TimeseriesforecastseasonalTable {
  let result = timeseries_forecast_seasonal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_table_sum(s : TimeseriesforecastseasonalTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_table_mean(s : TimeseriesforecastseasonalTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_table_scale(s : TimeseriesforecastseasonalTable, f : Double) -> TimeseriesforecastseasonalTable {
  let result = timeseries_forecast_seasonal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_table_add(a : TimeseriesforecastseasonalTable, b : TimeseriesforecastseasonalTable) -> TimeseriesforecastseasonalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_table_copy(s : TimeseriesforecastseasonalTable) -> TimeseriesforecastseasonalTable {
  let result = timeseries_forecast_seasonal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_table_fill(s : TimeseriesforecastseasonalTable, v : Double) -> TimeseriesforecastseasonalTable {
  let result = timeseries_forecast_seasonal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_table_min(s : TimeseriesforecastseasonalTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_table_max(s : TimeseriesforecastseasonalTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_table_to_string(s : TimeseriesforecastseasonalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_graphn_make(size : Int) -> TimeseriesforecastseasonalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_graphn_len(s : TimeseriesforecastseasonalGraphN) -> Int { s.size }

pub fn timeseries_forecast_seasonal_graphn_get(s : TimeseriesforecastseasonalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_graphn_set(s : TimeseriesforecastseasonalGraphN, i : Int, v : Double) -> TimeseriesforecastseasonalGraphN {
  let result = timeseries_forecast_seasonal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_graphn_sum(s : TimeseriesforecastseasonalGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_graphn_mean(s : TimeseriesforecastseasonalGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_graphn_scale(s : TimeseriesforecastseasonalGraphN, f : Double) -> TimeseriesforecastseasonalGraphN {
  let result = timeseries_forecast_seasonal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_graphn_add(a : TimeseriesforecastseasonalGraphN, b : TimeseriesforecastseasonalGraphN) -> TimeseriesforecastseasonalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_graphn_copy(s : TimeseriesforecastseasonalGraphN) -> TimeseriesforecastseasonalGraphN {
  let result = timeseries_forecast_seasonal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_graphn_fill(s : TimeseriesforecastseasonalGraphN, v : Double) -> TimeseriesforecastseasonalGraphN {
  let result = timeseries_forecast_seasonal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_graphn_min(s : TimeseriesforecastseasonalGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_graphn_max(s : TimeseriesforecastseasonalGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_graphn_to_string(s : TimeseriesforecastseasonalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_node_make(size : Int) -> TimeseriesforecastseasonalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_node_len(s : TimeseriesforecastseasonalNode) -> Int { s.size }

pub fn timeseries_forecast_seasonal_node_get(s : TimeseriesforecastseasonalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_node_set(s : TimeseriesforecastseasonalNode, i : Int, v : Double) -> TimeseriesforecastseasonalNode {
  let result = timeseries_forecast_seasonal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_node_sum(s : TimeseriesforecastseasonalNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_node_mean(s : TimeseriesforecastseasonalNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_node_scale(s : TimeseriesforecastseasonalNode, f : Double) -> TimeseriesforecastseasonalNode {
  let result = timeseries_forecast_seasonal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_node_add(a : TimeseriesforecastseasonalNode, b : TimeseriesforecastseasonalNode) -> TimeseriesforecastseasonalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_node_copy(s : TimeseriesforecastseasonalNode) -> TimeseriesforecastseasonalNode {
  let result = timeseries_forecast_seasonal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_node_fill(s : TimeseriesforecastseasonalNode, v : Double) -> TimeseriesforecastseasonalNode {
  let result = timeseries_forecast_seasonal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_node_min(s : TimeseriesforecastseasonalNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_node_max(s : TimeseriesforecastseasonalNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_node_to_string(s : TimeseriesforecastseasonalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_edge_make(size : Int) -> TimeseriesforecastseasonalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_edge_len(s : TimeseriesforecastseasonalEdge) -> Int { s.size }

pub fn timeseries_forecast_seasonal_edge_get(s : TimeseriesforecastseasonalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_edge_set(s : TimeseriesforecastseasonalEdge, i : Int, v : Double) -> TimeseriesforecastseasonalEdge {
  let result = timeseries_forecast_seasonal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_edge_sum(s : TimeseriesforecastseasonalEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_edge_mean(s : TimeseriesforecastseasonalEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_edge_scale(s : TimeseriesforecastseasonalEdge, f : Double) -> TimeseriesforecastseasonalEdge {
  let result = timeseries_forecast_seasonal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_edge_add(a : TimeseriesforecastseasonalEdge, b : TimeseriesforecastseasonalEdge) -> TimeseriesforecastseasonalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_edge_copy(s : TimeseriesforecastseasonalEdge) -> TimeseriesforecastseasonalEdge {
  let result = timeseries_forecast_seasonal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_edge_fill(s : TimeseriesforecastseasonalEdge, v : Double) -> TimeseriesforecastseasonalEdge {
  let result = timeseries_forecast_seasonal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_edge_min(s : TimeseriesforecastseasonalEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_edge_max(s : TimeseriesforecastseasonalEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_edge_to_string(s : TimeseriesforecastseasonalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_path_make(size : Int) -> TimeseriesforecastseasonalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_path_len(s : TimeseriesforecastseasonalPath) -> Int { s.size }

pub fn timeseries_forecast_seasonal_path_get(s : TimeseriesforecastseasonalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_path_set(s : TimeseriesforecastseasonalPath, i : Int, v : Double) -> TimeseriesforecastseasonalPath {
  let result = timeseries_forecast_seasonal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_path_sum(s : TimeseriesforecastseasonalPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_path_mean(s : TimeseriesforecastseasonalPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_path_scale(s : TimeseriesforecastseasonalPath, f : Double) -> TimeseriesforecastseasonalPath {
  let result = timeseries_forecast_seasonal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_path_add(a : TimeseriesforecastseasonalPath, b : TimeseriesforecastseasonalPath) -> TimeseriesforecastseasonalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_path_copy(s : TimeseriesforecastseasonalPath) -> TimeseriesforecastseasonalPath {
  let result = timeseries_forecast_seasonal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_path_fill(s : TimeseriesforecastseasonalPath, v : Double) -> TimeseriesforecastseasonalPath {
  let result = timeseries_forecast_seasonal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_path_min(s : TimeseriesforecastseasonalPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_path_max(s : TimeseriesforecastseasonalPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_path_to_string(s : TimeseriesforecastseasonalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_cluster_make(size : Int) -> TimeseriesforecastseasonalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_cluster_len(s : TimeseriesforecastseasonalCluster) -> Int { s.size }

pub fn timeseries_forecast_seasonal_cluster_get(s : TimeseriesforecastseasonalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_cluster_set(s : TimeseriesforecastseasonalCluster, i : Int, v : Double) -> TimeseriesforecastseasonalCluster {
  let result = timeseries_forecast_seasonal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_cluster_sum(s : TimeseriesforecastseasonalCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_cluster_mean(s : TimeseriesforecastseasonalCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_cluster_scale(s : TimeseriesforecastseasonalCluster, f : Double) -> TimeseriesforecastseasonalCluster {
  let result = timeseries_forecast_seasonal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_cluster_add(a : TimeseriesforecastseasonalCluster, b : TimeseriesforecastseasonalCluster) -> TimeseriesforecastseasonalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_cluster_copy(s : TimeseriesforecastseasonalCluster) -> TimeseriesforecastseasonalCluster {
  let result = timeseries_forecast_seasonal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_cluster_fill(s : TimeseriesforecastseasonalCluster, v : Double) -> TimeseriesforecastseasonalCluster {
  let result = timeseries_forecast_seasonal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_cluster_min(s : TimeseriesforecastseasonalCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_cluster_max(s : TimeseriesforecastseasonalCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_cluster_to_string(s : TimeseriesforecastseasonalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_model_make(size : Int) -> TimeseriesforecastseasonalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_model_len(s : TimeseriesforecastseasonalModel) -> Int { s.size }

pub fn timeseries_forecast_seasonal_model_get(s : TimeseriesforecastseasonalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_model_set(s : TimeseriesforecastseasonalModel, i : Int, v : Double) -> TimeseriesforecastseasonalModel {
  let result = timeseries_forecast_seasonal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_model_sum(s : TimeseriesforecastseasonalModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_model_mean(s : TimeseriesforecastseasonalModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_model_scale(s : TimeseriesforecastseasonalModel, f : Double) -> TimeseriesforecastseasonalModel {
  let result = timeseries_forecast_seasonal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_model_add(a : TimeseriesforecastseasonalModel, b : TimeseriesforecastseasonalModel) -> TimeseriesforecastseasonalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_model_copy(s : TimeseriesforecastseasonalModel) -> TimeseriesforecastseasonalModel {
  let result = timeseries_forecast_seasonal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_model_fill(s : TimeseriesforecastseasonalModel, v : Double) -> TimeseriesforecastseasonalModel {
  let result = timeseries_forecast_seasonal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_model_min(s : TimeseriesforecastseasonalModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_model_max(s : TimeseriesforecastseasonalModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_model_to_string(s : TimeseriesforecastseasonalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_layer_make(size : Int) -> TimeseriesforecastseasonalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_layer_len(s : TimeseriesforecastseasonalLayer) -> Int { s.size }

pub fn timeseries_forecast_seasonal_layer_get(s : TimeseriesforecastseasonalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_layer_set(s : TimeseriesforecastseasonalLayer, i : Int, v : Double) -> TimeseriesforecastseasonalLayer {
  let result = timeseries_forecast_seasonal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_layer_sum(s : TimeseriesforecastseasonalLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_layer_mean(s : TimeseriesforecastseasonalLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_layer_scale(s : TimeseriesforecastseasonalLayer, f : Double) -> TimeseriesforecastseasonalLayer {
  let result = timeseries_forecast_seasonal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_layer_add(a : TimeseriesforecastseasonalLayer, b : TimeseriesforecastseasonalLayer) -> TimeseriesforecastseasonalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_layer_copy(s : TimeseriesforecastseasonalLayer) -> TimeseriesforecastseasonalLayer {
  let result = timeseries_forecast_seasonal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_layer_fill(s : TimeseriesforecastseasonalLayer, v : Double) -> TimeseriesforecastseasonalLayer {
  let result = timeseries_forecast_seasonal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_layer_min(s : TimeseriesforecastseasonalLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_layer_max(s : TimeseriesforecastseasonalLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_layer_to_string(s : TimeseriesforecastseasonalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_buffer_make(size : Int) -> TimeseriesforecastseasonalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_buffer_len(s : TimeseriesforecastseasonalBuffer) -> Int { s.size }

pub fn timeseries_forecast_seasonal_buffer_get(s : TimeseriesforecastseasonalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_buffer_set(s : TimeseriesforecastseasonalBuffer, i : Int, v : Double) -> TimeseriesforecastseasonalBuffer {
  let result = timeseries_forecast_seasonal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_buffer_sum(s : TimeseriesforecastseasonalBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_buffer_mean(s : TimeseriesforecastseasonalBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_buffer_scale(s : TimeseriesforecastseasonalBuffer, f : Double) -> TimeseriesforecastseasonalBuffer {
  let result = timeseries_forecast_seasonal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_buffer_add(a : TimeseriesforecastseasonalBuffer, b : TimeseriesforecastseasonalBuffer) -> TimeseriesforecastseasonalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_buffer_copy(s : TimeseriesforecastseasonalBuffer) -> TimeseriesforecastseasonalBuffer {
  let result = timeseries_forecast_seasonal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_buffer_fill(s : TimeseriesforecastseasonalBuffer, v : Double) -> TimeseriesforecastseasonalBuffer {
  let result = timeseries_forecast_seasonal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_buffer_min(s : TimeseriesforecastseasonalBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_buffer_max(s : TimeseriesforecastseasonalBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_buffer_to_string(s : TimeseriesforecastseasonalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_cursor_make(size : Int) -> TimeseriesforecastseasonalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_cursor_len(s : TimeseriesforecastseasonalCursor) -> Int { s.size }

pub fn timeseries_forecast_seasonal_cursor_get(s : TimeseriesforecastseasonalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_cursor_set(s : TimeseriesforecastseasonalCursor, i : Int, v : Double) -> TimeseriesforecastseasonalCursor {
  let result = timeseries_forecast_seasonal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_cursor_sum(s : TimeseriesforecastseasonalCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_cursor_mean(s : TimeseriesforecastseasonalCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_cursor_scale(s : TimeseriesforecastseasonalCursor, f : Double) -> TimeseriesforecastseasonalCursor {
  let result = timeseries_forecast_seasonal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_cursor_add(a : TimeseriesforecastseasonalCursor, b : TimeseriesforecastseasonalCursor) -> TimeseriesforecastseasonalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_cursor_copy(s : TimeseriesforecastseasonalCursor) -> TimeseriesforecastseasonalCursor {
  let result = timeseries_forecast_seasonal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_cursor_fill(s : TimeseriesforecastseasonalCursor, v : Double) -> TimeseriesforecastseasonalCursor {
  let result = timeseries_forecast_seasonal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_cursor_min(s : TimeseriesforecastseasonalCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_cursor_max(s : TimeseriesforecastseasonalCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_cursor_to_string(s : TimeseriesforecastseasonalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_view_make(size : Int) -> TimeseriesforecastseasonalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_view_len(s : TimeseriesforecastseasonalView) -> Int { s.size }

pub fn timeseries_forecast_seasonal_view_get(s : TimeseriesforecastseasonalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_view_set(s : TimeseriesforecastseasonalView, i : Int, v : Double) -> TimeseriesforecastseasonalView {
  let result = timeseries_forecast_seasonal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_view_sum(s : TimeseriesforecastseasonalView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_view_mean(s : TimeseriesforecastseasonalView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_view_scale(s : TimeseriesforecastseasonalView, f : Double) -> TimeseriesforecastseasonalView {
  let result = timeseries_forecast_seasonal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_view_add(a : TimeseriesforecastseasonalView, b : TimeseriesforecastseasonalView) -> TimeseriesforecastseasonalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_view_copy(s : TimeseriesforecastseasonalView) -> TimeseriesforecastseasonalView {
  let result = timeseries_forecast_seasonal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_view_fill(s : TimeseriesforecastseasonalView, v : Double) -> TimeseriesforecastseasonalView {
  let result = timeseries_forecast_seasonal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_view_min(s : TimeseriesforecastseasonalView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_view_max(s : TimeseriesforecastseasonalView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_view_to_string(s : TimeseriesforecastseasonalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_range_make(size : Int) -> TimeseriesforecastseasonalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_range_len(s : TimeseriesforecastseasonalRange) -> Int { s.size }

pub fn timeseries_forecast_seasonal_range_get(s : TimeseriesforecastseasonalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_range_set(s : TimeseriesforecastseasonalRange, i : Int, v : Double) -> TimeseriesforecastseasonalRange {
  let result = timeseries_forecast_seasonal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_range_sum(s : TimeseriesforecastseasonalRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_range_mean(s : TimeseriesforecastseasonalRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_range_scale(s : TimeseriesforecastseasonalRange, f : Double) -> TimeseriesforecastseasonalRange {
  let result = timeseries_forecast_seasonal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_range_add(a : TimeseriesforecastseasonalRange, b : TimeseriesforecastseasonalRange) -> TimeseriesforecastseasonalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_range_copy(s : TimeseriesforecastseasonalRange) -> TimeseriesforecastseasonalRange {
  let result = timeseries_forecast_seasonal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_range_fill(s : TimeseriesforecastseasonalRange, v : Double) -> TimeseriesforecastseasonalRange {
  let result = timeseries_forecast_seasonal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_range_min(s : TimeseriesforecastseasonalRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_range_max(s : TimeseriesforecastseasonalRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_range_to_string(s : TimeseriesforecastseasonalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_slice_make(size : Int) -> TimeseriesforecastseasonalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_slice_len(s : TimeseriesforecastseasonalSlice) -> Int { s.size }

pub fn timeseries_forecast_seasonal_slice_get(s : TimeseriesforecastseasonalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_slice_set(s : TimeseriesforecastseasonalSlice, i : Int, v : Double) -> TimeseriesforecastseasonalSlice {
  let result = timeseries_forecast_seasonal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_slice_sum(s : TimeseriesforecastseasonalSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_slice_mean(s : TimeseriesforecastseasonalSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_slice_scale(s : TimeseriesforecastseasonalSlice, f : Double) -> TimeseriesforecastseasonalSlice {
  let result = timeseries_forecast_seasonal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_seasonal_slice_add(a : TimeseriesforecastseasonalSlice, b : TimeseriesforecastseasonalSlice) -> TimeseriesforecastseasonalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_seasonal_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_slice_copy(s : TimeseriesforecastseasonalSlice) -> TimeseriesforecastseasonalSlice {
  let result = timeseries_forecast_seasonal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_seasonal_slice_fill(s : TimeseriesforecastseasonalSlice, v : Double) -> TimeseriesforecastseasonalSlice {
  let result = timeseries_forecast_seasonal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_seasonal_slice_min(s : TimeseriesforecastseasonalSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_slice_max(s : TimeseriesforecastseasonalSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_slice_to_string(s : TimeseriesforecastseasonalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

