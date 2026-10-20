///===
/// extcore/timeseries_forecast_bagging

pub(all) struct TimeseriesforecastbaggingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_bagging_make_point(x : Double, y : Double) -> TimeseriesforecastbaggingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_bagging_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastbaggingPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_bagging_point_x(pt : TimeseriesforecastbaggingPoint) -> Double { pt.x }

pub fn timeseries_forecast_bagging_point_y(pt : TimeseriesforecastbaggingPoint) -> Double { pt.y }

pub fn timeseries_forecast_bagging_point_z(pt : TimeseriesforecastbaggingPoint) -> Double { pt.z }

pub fn timeseries_forecast_bagging_point_label(pt : TimeseriesforecastbaggingPoint) -> Int { pt.label }

pub fn timeseries_forecast_bagging_point_dist(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_bagging_point_add(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_bagging_point_sub(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_bagging_point_scale(pt : TimeseriesforecastbaggingPoint, s : Double) -> TimeseriesforecastbaggingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_bagging_point_dot(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_bagging_point_cross(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_bagging_point_norm(pt : TimeseriesforecastbaggingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_bagging_point_normalize(pt : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  let n = timeseries_forecast_bagging_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_bagging_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_bagging_point_negate(pt : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_bagging_point_mid(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_bagging_point_lerp(a : TimeseriesforecastbaggingPoint, b : TimeseriesforecastbaggingPoint, t : Double) -> TimeseriesforecastbaggingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_bagging_point_to_string(pt : TimeseriesforecastbaggingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_bagging_make_series(vals : Array[Double], name : String) -> TimeseriesforecastbaggingSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_bagging_series_len(s : TimeseriesforecastbaggingSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_bagging_series_sum(s : TimeseriesforecastbaggingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_forecast_bagging_series_mean(s : TimeseriesforecastbaggingSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_bagging_series_min(s : TimeseriesforecastbaggingSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_bagging_series_max(s : TimeseriesforecastbaggingSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_bagging_series_range(s : TimeseriesforecastbaggingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_bagging_series_var(s : TimeseriesforecastbaggingSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_bagging_series_std(s : TimeseriesforecastbaggingSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_bagging_series_median(s : TimeseriesforecastbaggingSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_bagging_series_scale(s : TimeseriesforecastbaggingSeries, f : Double) -> TimeseriesforecastbaggingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_bagging_series_add(a : TimeseriesforecastbaggingSeries, b : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_bagging_series_sub(a : TimeseriesforecastbaggingSeries, b : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_bagging_series_normalize(s : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let mn = timeseries_forecast_bagging_series_min(s)
  let mx = timeseries_forecast_bagging_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_bagging_series_cumsum(s : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_bagging_series_to_string(s : TimeseriesforecastbaggingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastbaggingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_bagging_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastbaggingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_bagging_matrix_identity(n : Int) -> TimeseriesforecastbaggingMatrix {
  let m = timeseries_forecast_bagging_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_bagging_matrix_get(m : TimeseriesforecastbaggingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_bagging_matrix_transpose(m : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  let result = timeseries_forecast_bagging_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_bagging_matrix_add(a : TimeseriesforecastbaggingMatrix, b : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_bagging_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_bagging_matrix_scale(m : TimeseriesforecastbaggingMatrix, s : Double) -> TimeseriesforecastbaggingMatrix {
  let result = timeseries_forecast_bagging_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_bagging_matrix_multiply(a : TimeseriesforecastbaggingMatrix, b : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  if a.cols != b.rows { return timeseries_forecast_bagging_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_bagging_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_bagging_matrix_trace(m : TimeseriesforecastbaggingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_bagging_matrix_det(m : TimeseriesforecastbaggingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_bagging_matrix_norm(m : TimeseriesforecastbaggingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_bagging_matrix_to_string(m : TimeseriesforecastbaggingMatrix) -> String {
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

pub(all) struct TimeseriesforecastbaggingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_bagging_make_vector(comps : Array[Double]) -> TimeseriesforecastbaggingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_bagging_vector_zero(dim : Int) -> TimeseriesforecastbaggingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_bagging_vector_add(a : TimeseriesforecastbaggingVector, b : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_bagging_vector_sub(a : TimeseriesforecastbaggingVector, b : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_bagging_vector_scale(v : TimeseriesforecastbaggingVector, s : Double) -> TimeseriesforecastbaggingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_bagging_vector_dot(a : TimeseriesforecastbaggingVector, b : TimeseriesforecastbaggingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_bagging_vector_norm(v : TimeseriesforecastbaggingVector) -> Double { @_common.sqrt(timeseries_forecast_bagging_vector_dot(v, v)) }

pub fn timeseries_forecast_bagging_vector_normalize(v : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = timeseries_forecast_bagging_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_bagging_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_bagging_vector_dist(a : TimeseriesforecastbaggingVector, b : TimeseriesforecastbaggingVector) -> Double {
  timeseries_forecast_bagging_vector_norm(timeseries_forecast_bagging_vector_sub(a, b))
}

pub fn timeseries_forecast_bagging_vector_to_string(v : TimeseriesforecastbaggingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_bagging_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_bagging_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_bagging_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_bagging_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_bagging_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_bagging_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_bagging_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_bagging_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_bagging_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_bagging_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_bagging_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_bagging_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_bagging_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_bagging_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_bagging_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_bagging_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_bagging_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_bagging_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_bagging_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_bagging_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_bagging_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_bagging_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_bagging_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_bagging_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_bagging_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_bagging_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_bagging_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_bagging_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_bagging_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastbaggingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_frame_make(size : Int) -> TimeseriesforecastbaggingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_frame_len(s : TimeseriesforecastbaggingFrame) -> Int { s.size }

pub fn timeseries_forecast_bagging_frame_get(s : TimeseriesforecastbaggingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_frame_set(s : TimeseriesforecastbaggingFrame, i : Int, v : Double) -> TimeseriesforecastbaggingFrame {
  let result = timeseries_forecast_bagging_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_frame_sum(s : TimeseriesforecastbaggingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_frame_mean(s : TimeseriesforecastbaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_frame_scale(s : TimeseriesforecastbaggingFrame, f : Double) -> TimeseriesforecastbaggingFrame {
  let result = timeseries_forecast_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_frame_add(a : TimeseriesforecastbaggingFrame, b : TimeseriesforecastbaggingFrame) -> TimeseriesforecastbaggingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_frame_copy(s : TimeseriesforecastbaggingFrame) -> TimeseriesforecastbaggingFrame {
  let result = timeseries_forecast_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_frame_fill(s : TimeseriesforecastbaggingFrame, v : Double) -> TimeseriesforecastbaggingFrame {
  let result = timeseries_forecast_bagging_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_frame_min(s : TimeseriesforecastbaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_frame_max(s : TimeseriesforecastbaggingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_frame_to_string(s : TimeseriesforecastbaggingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_table_make(size : Int) -> TimeseriesforecastbaggingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_table_len(s : TimeseriesforecastbaggingTable) -> Int { s.size }

pub fn timeseries_forecast_bagging_table_get(s : TimeseriesforecastbaggingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_table_set(s : TimeseriesforecastbaggingTable, i : Int, v : Double) -> TimeseriesforecastbaggingTable {
  let result = timeseries_forecast_bagging_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_table_sum(s : TimeseriesforecastbaggingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_table_mean(s : TimeseriesforecastbaggingTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_table_scale(s : TimeseriesforecastbaggingTable, f : Double) -> TimeseriesforecastbaggingTable {
  let result = timeseries_forecast_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_table_add(a : TimeseriesforecastbaggingTable, b : TimeseriesforecastbaggingTable) -> TimeseriesforecastbaggingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_table_copy(s : TimeseriesforecastbaggingTable) -> TimeseriesforecastbaggingTable {
  let result = timeseries_forecast_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_table_fill(s : TimeseriesforecastbaggingTable, v : Double) -> TimeseriesforecastbaggingTable {
  let result = timeseries_forecast_bagging_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_table_min(s : TimeseriesforecastbaggingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_table_max(s : TimeseriesforecastbaggingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_table_to_string(s : TimeseriesforecastbaggingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_graphn_make(size : Int) -> TimeseriesforecastbaggingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_graphn_len(s : TimeseriesforecastbaggingGraphN) -> Int { s.size }

pub fn timeseries_forecast_bagging_graphn_get(s : TimeseriesforecastbaggingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_graphn_set(s : TimeseriesforecastbaggingGraphN, i : Int, v : Double) -> TimeseriesforecastbaggingGraphN {
  let result = timeseries_forecast_bagging_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_graphn_sum(s : TimeseriesforecastbaggingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_graphn_mean(s : TimeseriesforecastbaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_graphn_scale(s : TimeseriesforecastbaggingGraphN, f : Double) -> TimeseriesforecastbaggingGraphN {
  let result = timeseries_forecast_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_graphn_add(a : TimeseriesforecastbaggingGraphN, b : TimeseriesforecastbaggingGraphN) -> TimeseriesforecastbaggingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_graphn_copy(s : TimeseriesforecastbaggingGraphN) -> TimeseriesforecastbaggingGraphN {
  let result = timeseries_forecast_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_graphn_fill(s : TimeseriesforecastbaggingGraphN, v : Double) -> TimeseriesforecastbaggingGraphN {
  let result = timeseries_forecast_bagging_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_graphn_min(s : TimeseriesforecastbaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_graphn_max(s : TimeseriesforecastbaggingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_graphn_to_string(s : TimeseriesforecastbaggingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_node_make(size : Int) -> TimeseriesforecastbaggingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_node_len(s : TimeseriesforecastbaggingNode) -> Int { s.size }

pub fn timeseries_forecast_bagging_node_get(s : TimeseriesforecastbaggingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_node_set(s : TimeseriesforecastbaggingNode, i : Int, v : Double) -> TimeseriesforecastbaggingNode {
  let result = timeseries_forecast_bagging_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_node_sum(s : TimeseriesforecastbaggingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_node_mean(s : TimeseriesforecastbaggingNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_node_scale(s : TimeseriesforecastbaggingNode, f : Double) -> TimeseriesforecastbaggingNode {
  let result = timeseries_forecast_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_node_add(a : TimeseriesforecastbaggingNode, b : TimeseriesforecastbaggingNode) -> TimeseriesforecastbaggingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_node_copy(s : TimeseriesforecastbaggingNode) -> TimeseriesforecastbaggingNode {
  let result = timeseries_forecast_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_node_fill(s : TimeseriesforecastbaggingNode, v : Double) -> TimeseriesforecastbaggingNode {
  let result = timeseries_forecast_bagging_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_node_min(s : TimeseriesforecastbaggingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_node_max(s : TimeseriesforecastbaggingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_node_to_string(s : TimeseriesforecastbaggingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_edge_make(size : Int) -> TimeseriesforecastbaggingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_edge_len(s : TimeseriesforecastbaggingEdge) -> Int { s.size }

pub fn timeseries_forecast_bagging_edge_get(s : TimeseriesforecastbaggingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_edge_set(s : TimeseriesforecastbaggingEdge, i : Int, v : Double) -> TimeseriesforecastbaggingEdge {
  let result = timeseries_forecast_bagging_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_edge_sum(s : TimeseriesforecastbaggingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_edge_mean(s : TimeseriesforecastbaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_edge_scale(s : TimeseriesforecastbaggingEdge, f : Double) -> TimeseriesforecastbaggingEdge {
  let result = timeseries_forecast_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_edge_add(a : TimeseriesforecastbaggingEdge, b : TimeseriesforecastbaggingEdge) -> TimeseriesforecastbaggingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_edge_copy(s : TimeseriesforecastbaggingEdge) -> TimeseriesforecastbaggingEdge {
  let result = timeseries_forecast_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_edge_fill(s : TimeseriesforecastbaggingEdge, v : Double) -> TimeseriesforecastbaggingEdge {
  let result = timeseries_forecast_bagging_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_edge_min(s : TimeseriesforecastbaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_edge_max(s : TimeseriesforecastbaggingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_edge_to_string(s : TimeseriesforecastbaggingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_path_make(size : Int) -> TimeseriesforecastbaggingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_path_len(s : TimeseriesforecastbaggingPath) -> Int { s.size }

pub fn timeseries_forecast_bagging_path_get(s : TimeseriesforecastbaggingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_path_set(s : TimeseriesforecastbaggingPath, i : Int, v : Double) -> TimeseriesforecastbaggingPath {
  let result = timeseries_forecast_bagging_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_path_sum(s : TimeseriesforecastbaggingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_path_mean(s : TimeseriesforecastbaggingPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_path_scale(s : TimeseriesforecastbaggingPath, f : Double) -> TimeseriesforecastbaggingPath {
  let result = timeseries_forecast_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_path_add(a : TimeseriesforecastbaggingPath, b : TimeseriesforecastbaggingPath) -> TimeseriesforecastbaggingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_path_copy(s : TimeseriesforecastbaggingPath) -> TimeseriesforecastbaggingPath {
  let result = timeseries_forecast_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_path_fill(s : TimeseriesforecastbaggingPath, v : Double) -> TimeseriesforecastbaggingPath {
  let result = timeseries_forecast_bagging_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_path_min(s : TimeseriesforecastbaggingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_path_max(s : TimeseriesforecastbaggingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_path_to_string(s : TimeseriesforecastbaggingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_cluster_make(size : Int) -> TimeseriesforecastbaggingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_cluster_len(s : TimeseriesforecastbaggingCluster) -> Int { s.size }

pub fn timeseries_forecast_bagging_cluster_get(s : TimeseriesforecastbaggingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_cluster_set(s : TimeseriesforecastbaggingCluster, i : Int, v : Double) -> TimeseriesforecastbaggingCluster {
  let result = timeseries_forecast_bagging_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_cluster_sum(s : TimeseriesforecastbaggingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_cluster_mean(s : TimeseriesforecastbaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_cluster_scale(s : TimeseriesforecastbaggingCluster, f : Double) -> TimeseriesforecastbaggingCluster {
  let result = timeseries_forecast_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_cluster_add(a : TimeseriesforecastbaggingCluster, b : TimeseriesforecastbaggingCluster) -> TimeseriesforecastbaggingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_cluster_copy(s : TimeseriesforecastbaggingCluster) -> TimeseriesforecastbaggingCluster {
  let result = timeseries_forecast_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_cluster_fill(s : TimeseriesforecastbaggingCluster, v : Double) -> TimeseriesforecastbaggingCluster {
  let result = timeseries_forecast_bagging_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_cluster_min(s : TimeseriesforecastbaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cluster_max(s : TimeseriesforecastbaggingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cluster_to_string(s : TimeseriesforecastbaggingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_model_make(size : Int) -> TimeseriesforecastbaggingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_model_len(s : TimeseriesforecastbaggingModel) -> Int { s.size }

pub fn timeseries_forecast_bagging_model_get(s : TimeseriesforecastbaggingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_model_set(s : TimeseriesforecastbaggingModel, i : Int, v : Double) -> TimeseriesforecastbaggingModel {
  let result = timeseries_forecast_bagging_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_model_sum(s : TimeseriesforecastbaggingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_model_mean(s : TimeseriesforecastbaggingModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_model_scale(s : TimeseriesforecastbaggingModel, f : Double) -> TimeseriesforecastbaggingModel {
  let result = timeseries_forecast_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_model_add(a : TimeseriesforecastbaggingModel, b : TimeseriesforecastbaggingModel) -> TimeseriesforecastbaggingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_model_copy(s : TimeseriesforecastbaggingModel) -> TimeseriesforecastbaggingModel {
  let result = timeseries_forecast_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_model_fill(s : TimeseriesforecastbaggingModel, v : Double) -> TimeseriesforecastbaggingModel {
  let result = timeseries_forecast_bagging_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_model_min(s : TimeseriesforecastbaggingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_model_max(s : TimeseriesforecastbaggingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_model_to_string(s : TimeseriesforecastbaggingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_layer_make(size : Int) -> TimeseriesforecastbaggingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_layer_len(s : TimeseriesforecastbaggingLayer) -> Int { s.size }

pub fn timeseries_forecast_bagging_layer_get(s : TimeseriesforecastbaggingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_layer_set(s : TimeseriesforecastbaggingLayer, i : Int, v : Double) -> TimeseriesforecastbaggingLayer {
  let result = timeseries_forecast_bagging_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_layer_sum(s : TimeseriesforecastbaggingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_layer_mean(s : TimeseriesforecastbaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_layer_scale(s : TimeseriesforecastbaggingLayer, f : Double) -> TimeseriesforecastbaggingLayer {
  let result = timeseries_forecast_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_layer_add(a : TimeseriesforecastbaggingLayer, b : TimeseriesforecastbaggingLayer) -> TimeseriesforecastbaggingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_layer_copy(s : TimeseriesforecastbaggingLayer) -> TimeseriesforecastbaggingLayer {
  let result = timeseries_forecast_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_layer_fill(s : TimeseriesforecastbaggingLayer, v : Double) -> TimeseriesforecastbaggingLayer {
  let result = timeseries_forecast_bagging_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_layer_min(s : TimeseriesforecastbaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_layer_max(s : TimeseriesforecastbaggingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_layer_to_string(s : TimeseriesforecastbaggingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_buffer_make(size : Int) -> TimeseriesforecastbaggingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_buffer_len(s : TimeseriesforecastbaggingBuffer) -> Int { s.size }

pub fn timeseries_forecast_bagging_buffer_get(s : TimeseriesforecastbaggingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_buffer_set(s : TimeseriesforecastbaggingBuffer, i : Int, v : Double) -> TimeseriesforecastbaggingBuffer {
  let result = timeseries_forecast_bagging_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_buffer_sum(s : TimeseriesforecastbaggingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_buffer_mean(s : TimeseriesforecastbaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_buffer_scale(s : TimeseriesforecastbaggingBuffer, f : Double) -> TimeseriesforecastbaggingBuffer {
  let result = timeseries_forecast_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_buffer_add(a : TimeseriesforecastbaggingBuffer, b : TimeseriesforecastbaggingBuffer) -> TimeseriesforecastbaggingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_buffer_copy(s : TimeseriesforecastbaggingBuffer) -> TimeseriesforecastbaggingBuffer {
  let result = timeseries_forecast_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_buffer_fill(s : TimeseriesforecastbaggingBuffer, v : Double) -> TimeseriesforecastbaggingBuffer {
  let result = timeseries_forecast_bagging_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_buffer_min(s : TimeseriesforecastbaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_buffer_max(s : TimeseriesforecastbaggingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_buffer_to_string(s : TimeseriesforecastbaggingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_cursor_make(size : Int) -> TimeseriesforecastbaggingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_cursor_len(s : TimeseriesforecastbaggingCursor) -> Int { s.size }

pub fn timeseries_forecast_bagging_cursor_get(s : TimeseriesforecastbaggingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_cursor_set(s : TimeseriesforecastbaggingCursor, i : Int, v : Double) -> TimeseriesforecastbaggingCursor {
  let result = timeseries_forecast_bagging_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_cursor_sum(s : TimeseriesforecastbaggingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_cursor_mean(s : TimeseriesforecastbaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_cursor_scale(s : TimeseriesforecastbaggingCursor, f : Double) -> TimeseriesforecastbaggingCursor {
  let result = timeseries_forecast_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_cursor_add(a : TimeseriesforecastbaggingCursor, b : TimeseriesforecastbaggingCursor) -> TimeseriesforecastbaggingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_cursor_copy(s : TimeseriesforecastbaggingCursor) -> TimeseriesforecastbaggingCursor {
  let result = timeseries_forecast_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_cursor_fill(s : TimeseriesforecastbaggingCursor, v : Double) -> TimeseriesforecastbaggingCursor {
  let result = timeseries_forecast_bagging_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_cursor_min(s : TimeseriesforecastbaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cursor_max(s : TimeseriesforecastbaggingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_cursor_to_string(s : TimeseriesforecastbaggingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_view_make(size : Int) -> TimeseriesforecastbaggingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_view_len(s : TimeseriesforecastbaggingView) -> Int { s.size }

pub fn timeseries_forecast_bagging_view_get(s : TimeseriesforecastbaggingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_view_set(s : TimeseriesforecastbaggingView, i : Int, v : Double) -> TimeseriesforecastbaggingView {
  let result = timeseries_forecast_bagging_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_view_sum(s : TimeseriesforecastbaggingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_view_mean(s : TimeseriesforecastbaggingView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_view_scale(s : TimeseriesforecastbaggingView, f : Double) -> TimeseriesforecastbaggingView {
  let result = timeseries_forecast_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_view_add(a : TimeseriesforecastbaggingView, b : TimeseriesforecastbaggingView) -> TimeseriesforecastbaggingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_view_copy(s : TimeseriesforecastbaggingView) -> TimeseriesforecastbaggingView {
  let result = timeseries_forecast_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_view_fill(s : TimeseriesforecastbaggingView, v : Double) -> TimeseriesforecastbaggingView {
  let result = timeseries_forecast_bagging_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_view_min(s : TimeseriesforecastbaggingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_view_max(s : TimeseriesforecastbaggingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_view_to_string(s : TimeseriesforecastbaggingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_range_make(size : Int) -> TimeseriesforecastbaggingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_range_len(s : TimeseriesforecastbaggingRange) -> Int { s.size }

pub fn timeseries_forecast_bagging_range_get(s : TimeseriesforecastbaggingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_range_set(s : TimeseriesforecastbaggingRange, i : Int, v : Double) -> TimeseriesforecastbaggingRange {
  let result = timeseries_forecast_bagging_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_range_sum(s : TimeseriesforecastbaggingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_range_mean(s : TimeseriesforecastbaggingRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_range_scale(s : TimeseriesforecastbaggingRange, f : Double) -> TimeseriesforecastbaggingRange {
  let result = timeseries_forecast_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_range_add(a : TimeseriesforecastbaggingRange, b : TimeseriesforecastbaggingRange) -> TimeseriesforecastbaggingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_range_copy(s : TimeseriesforecastbaggingRange) -> TimeseriesforecastbaggingRange {
  let result = timeseries_forecast_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_range_fill(s : TimeseriesforecastbaggingRange, v : Double) -> TimeseriesforecastbaggingRange {
  let result = timeseries_forecast_bagging_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_range_min(s : TimeseriesforecastbaggingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_range_max(s : TimeseriesforecastbaggingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_range_to_string(s : TimeseriesforecastbaggingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_slice_make(size : Int) -> TimeseriesforecastbaggingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_slice_len(s : TimeseriesforecastbaggingSlice) -> Int { s.size }

pub fn timeseries_forecast_bagging_slice_get(s : TimeseriesforecastbaggingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_slice_set(s : TimeseriesforecastbaggingSlice, i : Int, v : Double) -> TimeseriesforecastbaggingSlice {
  let result = timeseries_forecast_bagging_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_slice_sum(s : TimeseriesforecastbaggingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_bagging_slice_mean(s : TimeseriesforecastbaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_bagging_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_bagging_slice_scale(s : TimeseriesforecastbaggingSlice, f : Double) -> TimeseriesforecastbaggingSlice {
  let result = timeseries_forecast_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_bagging_slice_add(a : TimeseriesforecastbaggingSlice, b : TimeseriesforecastbaggingSlice) -> TimeseriesforecastbaggingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_bagging_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_bagging_slice_copy(s : TimeseriesforecastbaggingSlice) -> TimeseriesforecastbaggingSlice {
  let result = timeseries_forecast_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_bagging_slice_fill(s : TimeseriesforecastbaggingSlice, v : Double) -> TimeseriesforecastbaggingSlice {
  let result = timeseries_forecast_bagging_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_bagging_slice_min(s : TimeseriesforecastbaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_slice_max(s : TimeseriesforecastbaggingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_bagging_slice_to_string(s : TimeseriesforecastbaggingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

