///===
/// extcore/timeseries_forecast_naive

pub(all) struct TimeseriesforecastnaivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_naive_make_point(x : Double, y : Double) -> TimeseriesforecastnaivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_naive_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastnaivePoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_naive_point_x(pt : TimeseriesforecastnaivePoint) -> Double { pt.x }

pub fn timeseries_forecast_naive_point_y(pt : TimeseriesforecastnaivePoint) -> Double { pt.y }

pub fn timeseries_forecast_naive_point_z(pt : TimeseriesforecastnaivePoint) -> Double { pt.z }

pub fn timeseries_forecast_naive_point_label(pt : TimeseriesforecastnaivePoint) -> Int { pt.label }

pub fn timeseries_forecast_naive_point_dist(a : TimeseriesforecastnaivePoint, b : TimeseriesforecastnaivePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_naive_point_add(a : TimeseriesforecastnaivePoint, b : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_naive_point_sub(a : TimeseriesforecastnaivePoint, b : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_naive_point_scale(pt : TimeseriesforecastnaivePoint, s : Double) -> TimeseriesforecastnaivePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_naive_point_dot(a : TimeseriesforecastnaivePoint, b : TimeseriesforecastnaivePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_naive_point_cross(a : TimeseriesforecastnaivePoint, b : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_naive_point_norm(pt : TimeseriesforecastnaivePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_naive_point_normalize(pt : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  let n = timeseries_forecast_naive_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_naive_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_naive_point_negate(pt : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_naive_point_mid(a : TimeseriesforecastnaivePoint, b : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_naive_point_lerp(a : TimeseriesforecastnaivePoint, b : TimeseriesforecastnaivePoint, t : Double) -> TimeseriesforecastnaivePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_naive_point_to_string(pt : TimeseriesforecastnaivePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_naive_make_series(vals : Array[Double], name : String) -> TimeseriesforecastnaiveSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_naive_series_len(s : TimeseriesforecastnaiveSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_naive_series_sum(s : TimeseriesforecastnaiveSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_forecast_naive_series_mean(s : TimeseriesforecastnaiveSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_naive_series_min(s : TimeseriesforecastnaiveSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_naive_series_max(s : TimeseriesforecastnaiveSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_naive_series_range(s : TimeseriesforecastnaiveSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_naive_series_var(s : TimeseriesforecastnaiveSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_naive_series_std(s : TimeseriesforecastnaiveSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_naive_series_median(s : TimeseriesforecastnaiveSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_naive_series_scale(s : TimeseriesforecastnaiveSeries, f : Double) -> TimeseriesforecastnaiveSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_naive_series_add(a : TimeseriesforecastnaiveSeries, b : TimeseriesforecastnaiveSeries) -> TimeseriesforecastnaiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_naive_series_sub(a : TimeseriesforecastnaiveSeries, b : TimeseriesforecastnaiveSeries) -> TimeseriesforecastnaiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_naive_series_normalize(s : TimeseriesforecastnaiveSeries) -> TimeseriesforecastnaiveSeries {
  let mn = timeseries_forecast_naive_series_min(s)
  let mx = timeseries_forecast_naive_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_naive_series_cumsum(s : TimeseriesforecastnaiveSeries) -> TimeseriesforecastnaiveSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_naive_series_to_string(s : TimeseriesforecastnaiveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastnaiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_naive_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastnaiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_naive_matrix_identity(n : Int) -> TimeseriesforecastnaiveMatrix {
  let m = timeseries_forecast_naive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_naive_matrix_get(m : TimeseriesforecastnaiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_naive_matrix_transpose(m : TimeseriesforecastnaiveMatrix) -> TimeseriesforecastnaiveMatrix {
  let result = timeseries_forecast_naive_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_naive_matrix_add(a : TimeseriesforecastnaiveMatrix, b : TimeseriesforecastnaiveMatrix) -> TimeseriesforecastnaiveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_naive_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_naive_matrix_scale(m : TimeseriesforecastnaiveMatrix, s : Double) -> TimeseriesforecastnaiveMatrix {
  let result = timeseries_forecast_naive_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_naive_matrix_multiply(a : TimeseriesforecastnaiveMatrix, b : TimeseriesforecastnaiveMatrix) -> TimeseriesforecastnaiveMatrix {
  if a.cols != b.rows { return timeseries_forecast_naive_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_naive_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_naive_matrix_trace(m : TimeseriesforecastnaiveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_naive_matrix_det(m : TimeseriesforecastnaiveMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_naive_matrix_norm(m : TimeseriesforecastnaiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_naive_matrix_to_string(m : TimeseriesforecastnaiveMatrix) -> String {
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

pub(all) struct TimeseriesforecastnaiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_naive_make_vector(comps : Array[Double]) -> TimeseriesforecastnaiveVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_naive_vector_zero(dim : Int) -> TimeseriesforecastnaiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_naive_vector_add(a : TimeseriesforecastnaiveVector, b : TimeseriesforecastnaiveVector) -> TimeseriesforecastnaiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_naive_vector_sub(a : TimeseriesforecastnaiveVector, b : TimeseriesforecastnaiveVector) -> TimeseriesforecastnaiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_naive_vector_scale(v : TimeseriesforecastnaiveVector, s : Double) -> TimeseriesforecastnaiveVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_naive_vector_dot(a : TimeseriesforecastnaiveVector, b : TimeseriesforecastnaiveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_naive_vector_norm(v : TimeseriesforecastnaiveVector) -> Double { @_common.sqrt(timeseries_forecast_naive_vector_dot(v, v)) }

pub fn timeseries_forecast_naive_vector_normalize(v : TimeseriesforecastnaiveVector) -> TimeseriesforecastnaiveVector {
  let n = timeseries_forecast_naive_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_naive_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_naive_vector_dist(a : TimeseriesforecastnaiveVector, b : TimeseriesforecastnaiveVector) -> Double {
  timeseries_forecast_naive_vector_norm(timeseries_forecast_naive_vector_sub(a, b))
}

pub fn timeseries_forecast_naive_vector_to_string(v : TimeseriesforecastnaiveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_naive_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_naive_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_naive_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_naive_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_naive_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_naive_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_naive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_naive_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_naive_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_naive_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_naive_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_naive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_naive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_naive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_naive_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_naive_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_naive_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_naive_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_naive_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_naive_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_naive_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_naive_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_naive_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_naive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_naive_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_naive_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_naive_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_naive_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_naive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastnaiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_frame_make(size : Int) -> TimeseriesforecastnaiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_frame_len(s : TimeseriesforecastnaiveFrame) -> Int { s.size }

pub fn timeseries_forecast_naive_frame_get(s : TimeseriesforecastnaiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_frame_set(s : TimeseriesforecastnaiveFrame, i : Int, v : Double) -> TimeseriesforecastnaiveFrame {
  let result = timeseries_forecast_naive_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_frame_sum(s : TimeseriesforecastnaiveFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_frame_mean(s : TimeseriesforecastnaiveFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_frame_scale(s : TimeseriesforecastnaiveFrame, f : Double) -> TimeseriesforecastnaiveFrame {
  let result = timeseries_forecast_naive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_frame_add(a : TimeseriesforecastnaiveFrame, b : TimeseriesforecastnaiveFrame) -> TimeseriesforecastnaiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_frame_copy(s : TimeseriesforecastnaiveFrame) -> TimeseriesforecastnaiveFrame {
  let result = timeseries_forecast_naive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_frame_fill(s : TimeseriesforecastnaiveFrame, v : Double) -> TimeseriesforecastnaiveFrame {
  let result = timeseries_forecast_naive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_frame_min(s : TimeseriesforecastnaiveFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_frame_max(s : TimeseriesforecastnaiveFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_frame_to_string(s : TimeseriesforecastnaiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_table_make(size : Int) -> TimeseriesforecastnaiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_table_len(s : TimeseriesforecastnaiveTable) -> Int { s.size }

pub fn timeseries_forecast_naive_table_get(s : TimeseriesforecastnaiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_table_set(s : TimeseriesforecastnaiveTable, i : Int, v : Double) -> TimeseriesforecastnaiveTable {
  let result = timeseries_forecast_naive_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_table_sum(s : TimeseriesforecastnaiveTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_table_mean(s : TimeseriesforecastnaiveTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_table_scale(s : TimeseriesforecastnaiveTable, f : Double) -> TimeseriesforecastnaiveTable {
  let result = timeseries_forecast_naive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_table_add(a : TimeseriesforecastnaiveTable, b : TimeseriesforecastnaiveTable) -> TimeseriesforecastnaiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_table_copy(s : TimeseriesforecastnaiveTable) -> TimeseriesforecastnaiveTable {
  let result = timeseries_forecast_naive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_table_fill(s : TimeseriesforecastnaiveTable, v : Double) -> TimeseriesforecastnaiveTable {
  let result = timeseries_forecast_naive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_table_min(s : TimeseriesforecastnaiveTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_table_max(s : TimeseriesforecastnaiveTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_table_to_string(s : TimeseriesforecastnaiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_graphn_make(size : Int) -> TimeseriesforecastnaiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_graphn_len(s : TimeseriesforecastnaiveGraphN) -> Int { s.size }

pub fn timeseries_forecast_naive_graphn_get(s : TimeseriesforecastnaiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_graphn_set(s : TimeseriesforecastnaiveGraphN, i : Int, v : Double) -> TimeseriesforecastnaiveGraphN {
  let result = timeseries_forecast_naive_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_graphn_sum(s : TimeseriesforecastnaiveGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_graphn_mean(s : TimeseriesforecastnaiveGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_graphn_scale(s : TimeseriesforecastnaiveGraphN, f : Double) -> TimeseriesforecastnaiveGraphN {
  let result = timeseries_forecast_naive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_graphn_add(a : TimeseriesforecastnaiveGraphN, b : TimeseriesforecastnaiveGraphN) -> TimeseriesforecastnaiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_graphn_copy(s : TimeseriesforecastnaiveGraphN) -> TimeseriesforecastnaiveGraphN {
  let result = timeseries_forecast_naive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_graphn_fill(s : TimeseriesforecastnaiveGraphN, v : Double) -> TimeseriesforecastnaiveGraphN {
  let result = timeseries_forecast_naive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_graphn_min(s : TimeseriesforecastnaiveGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_graphn_max(s : TimeseriesforecastnaiveGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_graphn_to_string(s : TimeseriesforecastnaiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_node_make(size : Int) -> TimeseriesforecastnaiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_node_len(s : TimeseriesforecastnaiveNode) -> Int { s.size }

pub fn timeseries_forecast_naive_node_get(s : TimeseriesforecastnaiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_node_set(s : TimeseriesforecastnaiveNode, i : Int, v : Double) -> TimeseriesforecastnaiveNode {
  let result = timeseries_forecast_naive_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_node_sum(s : TimeseriesforecastnaiveNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_node_mean(s : TimeseriesforecastnaiveNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_node_scale(s : TimeseriesforecastnaiveNode, f : Double) -> TimeseriesforecastnaiveNode {
  let result = timeseries_forecast_naive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_node_add(a : TimeseriesforecastnaiveNode, b : TimeseriesforecastnaiveNode) -> TimeseriesforecastnaiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_node_copy(s : TimeseriesforecastnaiveNode) -> TimeseriesforecastnaiveNode {
  let result = timeseries_forecast_naive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_node_fill(s : TimeseriesforecastnaiveNode, v : Double) -> TimeseriesforecastnaiveNode {
  let result = timeseries_forecast_naive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_node_min(s : TimeseriesforecastnaiveNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_node_max(s : TimeseriesforecastnaiveNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_node_to_string(s : TimeseriesforecastnaiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_edge_make(size : Int) -> TimeseriesforecastnaiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_edge_len(s : TimeseriesforecastnaiveEdge) -> Int { s.size }

pub fn timeseries_forecast_naive_edge_get(s : TimeseriesforecastnaiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_edge_set(s : TimeseriesforecastnaiveEdge, i : Int, v : Double) -> TimeseriesforecastnaiveEdge {
  let result = timeseries_forecast_naive_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_edge_sum(s : TimeseriesforecastnaiveEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_edge_mean(s : TimeseriesforecastnaiveEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_edge_scale(s : TimeseriesforecastnaiveEdge, f : Double) -> TimeseriesforecastnaiveEdge {
  let result = timeseries_forecast_naive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_edge_add(a : TimeseriesforecastnaiveEdge, b : TimeseriesforecastnaiveEdge) -> TimeseriesforecastnaiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_edge_copy(s : TimeseriesforecastnaiveEdge) -> TimeseriesforecastnaiveEdge {
  let result = timeseries_forecast_naive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_edge_fill(s : TimeseriesforecastnaiveEdge, v : Double) -> TimeseriesforecastnaiveEdge {
  let result = timeseries_forecast_naive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_edge_min(s : TimeseriesforecastnaiveEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_edge_max(s : TimeseriesforecastnaiveEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_edge_to_string(s : TimeseriesforecastnaiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_path_make(size : Int) -> TimeseriesforecastnaivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_path_len(s : TimeseriesforecastnaivePath) -> Int { s.size }

pub fn timeseries_forecast_naive_path_get(s : TimeseriesforecastnaivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_path_set(s : TimeseriesforecastnaivePath, i : Int, v : Double) -> TimeseriesforecastnaivePath {
  let result = timeseries_forecast_naive_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_path_sum(s : TimeseriesforecastnaivePath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_path_mean(s : TimeseriesforecastnaivePath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_path_scale(s : TimeseriesforecastnaivePath, f : Double) -> TimeseriesforecastnaivePath {
  let result = timeseries_forecast_naive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_path_add(a : TimeseriesforecastnaivePath, b : TimeseriesforecastnaivePath) -> TimeseriesforecastnaivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_path_copy(s : TimeseriesforecastnaivePath) -> TimeseriesforecastnaivePath {
  let result = timeseries_forecast_naive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_path_fill(s : TimeseriesforecastnaivePath, v : Double) -> TimeseriesforecastnaivePath {
  let result = timeseries_forecast_naive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_path_min(s : TimeseriesforecastnaivePath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_path_max(s : TimeseriesforecastnaivePath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_path_to_string(s : TimeseriesforecastnaivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_cluster_make(size : Int) -> TimeseriesforecastnaiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_cluster_len(s : TimeseriesforecastnaiveCluster) -> Int { s.size }

pub fn timeseries_forecast_naive_cluster_get(s : TimeseriesforecastnaiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_cluster_set(s : TimeseriesforecastnaiveCluster, i : Int, v : Double) -> TimeseriesforecastnaiveCluster {
  let result = timeseries_forecast_naive_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_cluster_sum(s : TimeseriesforecastnaiveCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_cluster_mean(s : TimeseriesforecastnaiveCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_cluster_scale(s : TimeseriesforecastnaiveCluster, f : Double) -> TimeseriesforecastnaiveCluster {
  let result = timeseries_forecast_naive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_cluster_add(a : TimeseriesforecastnaiveCluster, b : TimeseriesforecastnaiveCluster) -> TimeseriesforecastnaiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_cluster_copy(s : TimeseriesforecastnaiveCluster) -> TimeseriesforecastnaiveCluster {
  let result = timeseries_forecast_naive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_cluster_fill(s : TimeseriesforecastnaiveCluster, v : Double) -> TimeseriesforecastnaiveCluster {
  let result = timeseries_forecast_naive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_cluster_min(s : TimeseriesforecastnaiveCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_cluster_max(s : TimeseriesforecastnaiveCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_cluster_to_string(s : TimeseriesforecastnaiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_model_make(size : Int) -> TimeseriesforecastnaiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_model_len(s : TimeseriesforecastnaiveModel) -> Int { s.size }

pub fn timeseries_forecast_naive_model_get(s : TimeseriesforecastnaiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_model_set(s : TimeseriesforecastnaiveModel, i : Int, v : Double) -> TimeseriesforecastnaiveModel {
  let result = timeseries_forecast_naive_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_model_sum(s : TimeseriesforecastnaiveModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_model_mean(s : TimeseriesforecastnaiveModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_model_scale(s : TimeseriesforecastnaiveModel, f : Double) -> TimeseriesforecastnaiveModel {
  let result = timeseries_forecast_naive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_model_add(a : TimeseriesforecastnaiveModel, b : TimeseriesforecastnaiveModel) -> TimeseriesforecastnaiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_model_copy(s : TimeseriesforecastnaiveModel) -> TimeseriesforecastnaiveModel {
  let result = timeseries_forecast_naive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_model_fill(s : TimeseriesforecastnaiveModel, v : Double) -> TimeseriesforecastnaiveModel {
  let result = timeseries_forecast_naive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_model_min(s : TimeseriesforecastnaiveModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_model_max(s : TimeseriesforecastnaiveModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_model_to_string(s : TimeseriesforecastnaiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_layer_make(size : Int) -> TimeseriesforecastnaiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_layer_len(s : TimeseriesforecastnaiveLayer) -> Int { s.size }

pub fn timeseries_forecast_naive_layer_get(s : TimeseriesforecastnaiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_layer_set(s : TimeseriesforecastnaiveLayer, i : Int, v : Double) -> TimeseriesforecastnaiveLayer {
  let result = timeseries_forecast_naive_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_layer_sum(s : TimeseriesforecastnaiveLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_layer_mean(s : TimeseriesforecastnaiveLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_layer_scale(s : TimeseriesforecastnaiveLayer, f : Double) -> TimeseriesforecastnaiveLayer {
  let result = timeseries_forecast_naive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_layer_add(a : TimeseriesforecastnaiveLayer, b : TimeseriesforecastnaiveLayer) -> TimeseriesforecastnaiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_layer_copy(s : TimeseriesforecastnaiveLayer) -> TimeseriesforecastnaiveLayer {
  let result = timeseries_forecast_naive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_layer_fill(s : TimeseriesforecastnaiveLayer, v : Double) -> TimeseriesforecastnaiveLayer {
  let result = timeseries_forecast_naive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_layer_min(s : TimeseriesforecastnaiveLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_layer_max(s : TimeseriesforecastnaiveLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_layer_to_string(s : TimeseriesforecastnaiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_buffer_make(size : Int) -> TimeseriesforecastnaiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_buffer_len(s : TimeseriesforecastnaiveBuffer) -> Int { s.size }

pub fn timeseries_forecast_naive_buffer_get(s : TimeseriesforecastnaiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_buffer_set(s : TimeseriesforecastnaiveBuffer, i : Int, v : Double) -> TimeseriesforecastnaiveBuffer {
  let result = timeseries_forecast_naive_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_buffer_sum(s : TimeseriesforecastnaiveBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_buffer_mean(s : TimeseriesforecastnaiveBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_buffer_scale(s : TimeseriesforecastnaiveBuffer, f : Double) -> TimeseriesforecastnaiveBuffer {
  let result = timeseries_forecast_naive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_buffer_add(a : TimeseriesforecastnaiveBuffer, b : TimeseriesforecastnaiveBuffer) -> TimeseriesforecastnaiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_buffer_copy(s : TimeseriesforecastnaiveBuffer) -> TimeseriesforecastnaiveBuffer {
  let result = timeseries_forecast_naive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_buffer_fill(s : TimeseriesforecastnaiveBuffer, v : Double) -> TimeseriesforecastnaiveBuffer {
  let result = timeseries_forecast_naive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_buffer_min(s : TimeseriesforecastnaiveBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_buffer_max(s : TimeseriesforecastnaiveBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_buffer_to_string(s : TimeseriesforecastnaiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_cursor_make(size : Int) -> TimeseriesforecastnaiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_cursor_len(s : TimeseriesforecastnaiveCursor) -> Int { s.size }

pub fn timeseries_forecast_naive_cursor_get(s : TimeseriesforecastnaiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_cursor_set(s : TimeseriesforecastnaiveCursor, i : Int, v : Double) -> TimeseriesforecastnaiveCursor {
  let result = timeseries_forecast_naive_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_cursor_sum(s : TimeseriesforecastnaiveCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_cursor_mean(s : TimeseriesforecastnaiveCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_cursor_scale(s : TimeseriesforecastnaiveCursor, f : Double) -> TimeseriesforecastnaiveCursor {
  let result = timeseries_forecast_naive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_cursor_add(a : TimeseriesforecastnaiveCursor, b : TimeseriesforecastnaiveCursor) -> TimeseriesforecastnaiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_cursor_copy(s : TimeseriesforecastnaiveCursor) -> TimeseriesforecastnaiveCursor {
  let result = timeseries_forecast_naive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_cursor_fill(s : TimeseriesforecastnaiveCursor, v : Double) -> TimeseriesforecastnaiveCursor {
  let result = timeseries_forecast_naive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_cursor_min(s : TimeseriesforecastnaiveCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_cursor_max(s : TimeseriesforecastnaiveCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_cursor_to_string(s : TimeseriesforecastnaiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_view_make(size : Int) -> TimeseriesforecastnaiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_view_len(s : TimeseriesforecastnaiveView) -> Int { s.size }

pub fn timeseries_forecast_naive_view_get(s : TimeseriesforecastnaiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_view_set(s : TimeseriesforecastnaiveView, i : Int, v : Double) -> TimeseriesforecastnaiveView {
  let result = timeseries_forecast_naive_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_view_sum(s : TimeseriesforecastnaiveView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_view_mean(s : TimeseriesforecastnaiveView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_view_scale(s : TimeseriesforecastnaiveView, f : Double) -> TimeseriesforecastnaiveView {
  let result = timeseries_forecast_naive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_view_add(a : TimeseriesforecastnaiveView, b : TimeseriesforecastnaiveView) -> TimeseriesforecastnaiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_view_copy(s : TimeseriesforecastnaiveView) -> TimeseriesforecastnaiveView {
  let result = timeseries_forecast_naive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_view_fill(s : TimeseriesforecastnaiveView, v : Double) -> TimeseriesforecastnaiveView {
  let result = timeseries_forecast_naive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_view_min(s : TimeseriesforecastnaiveView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_view_max(s : TimeseriesforecastnaiveView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_view_to_string(s : TimeseriesforecastnaiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_range_make(size : Int) -> TimeseriesforecastnaiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_range_len(s : TimeseriesforecastnaiveRange) -> Int { s.size }

pub fn timeseries_forecast_naive_range_get(s : TimeseriesforecastnaiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_range_set(s : TimeseriesforecastnaiveRange, i : Int, v : Double) -> TimeseriesforecastnaiveRange {
  let result = timeseries_forecast_naive_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_range_sum(s : TimeseriesforecastnaiveRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_range_mean(s : TimeseriesforecastnaiveRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_range_scale(s : TimeseriesforecastnaiveRange, f : Double) -> TimeseriesforecastnaiveRange {
  let result = timeseries_forecast_naive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_range_add(a : TimeseriesforecastnaiveRange, b : TimeseriesforecastnaiveRange) -> TimeseriesforecastnaiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_range_copy(s : TimeseriesforecastnaiveRange) -> TimeseriesforecastnaiveRange {
  let result = timeseries_forecast_naive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_range_fill(s : TimeseriesforecastnaiveRange, v : Double) -> TimeseriesforecastnaiveRange {
  let result = timeseries_forecast_naive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_range_min(s : TimeseriesforecastnaiveRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_range_max(s : TimeseriesforecastnaiveRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_range_to_string(s : TimeseriesforecastnaiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_slice_make(size : Int) -> TimeseriesforecastnaiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_slice_len(s : TimeseriesforecastnaiveSlice) -> Int { s.size }

pub fn timeseries_forecast_naive_slice_get(s : TimeseriesforecastnaiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_slice_set(s : TimeseriesforecastnaiveSlice, i : Int, v : Double) -> TimeseriesforecastnaiveSlice {
  let result = timeseries_forecast_naive_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_slice_sum(s : TimeseriesforecastnaiveSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_slice_mean(s : TimeseriesforecastnaiveSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_slice_scale(s : TimeseriesforecastnaiveSlice, f : Double) -> TimeseriesforecastnaiveSlice {
  let result = timeseries_forecast_naive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_naive_slice_add(a : TimeseriesforecastnaiveSlice, b : TimeseriesforecastnaiveSlice) -> TimeseriesforecastnaiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_naive_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_naive_slice_copy(s : TimeseriesforecastnaiveSlice) -> TimeseriesforecastnaiveSlice {
  let result = timeseries_forecast_naive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_naive_slice_fill(s : TimeseriesforecastnaiveSlice, v : Double) -> TimeseriesforecastnaiveSlice {
  let result = timeseries_forecast_naive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_naive_slice_min(s : TimeseriesforecastnaiveSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_slice_max(s : TimeseriesforecastnaiveSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_slice_to_string(s : TimeseriesforecastnaiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

