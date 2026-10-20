///===
/// extcore/timeseries_forecast_theta

pub(all) struct TimeseriesforecastthetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_theta_make_point(x : Double, y : Double) -> TimeseriesforecastthetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_theta_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastthetaPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_theta_point_x(pt : TimeseriesforecastthetaPoint) -> Double { pt.x }

pub fn timeseries_forecast_theta_point_y(pt : TimeseriesforecastthetaPoint) -> Double { pt.y }

pub fn timeseries_forecast_theta_point_z(pt : TimeseriesforecastthetaPoint) -> Double { pt.z }

pub fn timeseries_forecast_theta_point_label(pt : TimeseriesforecastthetaPoint) -> Int { pt.label }

pub fn timeseries_forecast_theta_point_dist(a : TimeseriesforecastthetaPoint, b : TimeseriesforecastthetaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_theta_point_add(a : TimeseriesforecastthetaPoint, b : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_theta_point_sub(a : TimeseriesforecastthetaPoint, b : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_theta_point_scale(pt : TimeseriesforecastthetaPoint, s : Double) -> TimeseriesforecastthetaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_theta_point_dot(a : TimeseriesforecastthetaPoint, b : TimeseriesforecastthetaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_theta_point_cross(a : TimeseriesforecastthetaPoint, b : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_theta_point_norm(pt : TimeseriesforecastthetaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_theta_point_normalize(pt : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  let n = timeseries_forecast_theta_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_theta_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_theta_point_negate(pt : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_theta_point_mid(a : TimeseriesforecastthetaPoint, b : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_theta_point_lerp(a : TimeseriesforecastthetaPoint, b : TimeseriesforecastthetaPoint, t : Double) -> TimeseriesforecastthetaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_theta_point_to_string(pt : TimeseriesforecastthetaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_theta_make_series(vals : Array[Double], name : String) -> TimeseriesforecastthetaSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_theta_series_len(s : TimeseriesforecastthetaSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_theta_series_sum(s : TimeseriesforecastthetaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_forecast_theta_series_mean(s : TimeseriesforecastthetaSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_theta_series_min(s : TimeseriesforecastthetaSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_theta_series_max(s : TimeseriesforecastthetaSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_theta_series_range(s : TimeseriesforecastthetaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_theta_series_var(s : TimeseriesforecastthetaSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_theta_series_std(s : TimeseriesforecastthetaSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_theta_series_median(s : TimeseriesforecastthetaSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_theta_series_scale(s : TimeseriesforecastthetaSeries, f : Double) -> TimeseriesforecastthetaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_theta_series_add(a : TimeseriesforecastthetaSeries, b : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_theta_series_sub(a : TimeseriesforecastthetaSeries, b : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_theta_series_normalize(s : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  let mn = timeseries_forecast_theta_series_min(s)
  let mx = timeseries_forecast_theta_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_theta_series_cumsum(s : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_theta_series_to_string(s : TimeseriesforecastthetaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastthetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_theta_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastthetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_theta_matrix_identity(n : Int) -> TimeseriesforecastthetaMatrix {
  let m = timeseries_forecast_theta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_theta_matrix_get(m : TimeseriesforecastthetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_theta_matrix_transpose(m : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  let result = timeseries_forecast_theta_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_theta_matrix_add(a : TimeseriesforecastthetaMatrix, b : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_theta_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_theta_matrix_scale(m : TimeseriesforecastthetaMatrix, s : Double) -> TimeseriesforecastthetaMatrix {
  let result = timeseries_forecast_theta_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_theta_matrix_multiply(a : TimeseriesforecastthetaMatrix, b : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  if a.cols != b.rows { return timeseries_forecast_theta_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_theta_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_theta_matrix_trace(m : TimeseriesforecastthetaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_theta_matrix_det(m : TimeseriesforecastthetaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_theta_matrix_norm(m : TimeseriesforecastthetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_theta_matrix_to_string(m : TimeseriesforecastthetaMatrix) -> String {
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

pub(all) struct TimeseriesforecastthetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_theta_make_vector(comps : Array[Double]) -> TimeseriesforecastthetaVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_theta_vector_zero(dim : Int) -> TimeseriesforecastthetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_theta_vector_add(a : TimeseriesforecastthetaVector, b : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_theta_vector_sub(a : TimeseriesforecastthetaVector, b : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_forecast_theta_vector_scale(v : TimeseriesforecastthetaVector, s : Double) -> TimeseriesforecastthetaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_forecast_theta_vector_dot(a : TimeseriesforecastthetaVector, b : TimeseriesforecastthetaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_theta_vector_norm(v : TimeseriesforecastthetaVector) -> Double { @_common.sqrt(timeseries_forecast_theta_vector_dot(v, v)) }

pub fn timeseries_forecast_theta_vector_normalize(v : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = timeseries_forecast_theta_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_theta_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_theta_vector_dist(a : TimeseriesforecastthetaVector, b : TimeseriesforecastthetaVector) -> Double {
  timeseries_forecast_theta_vector_norm(timeseries_forecast_theta_vector_sub(a, b))
}

pub fn timeseries_forecast_theta_vector_to_string(v : TimeseriesforecastthetaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_theta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_theta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_theta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_theta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_theta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_theta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_theta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_theta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_theta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_theta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_theta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_theta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_theta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_theta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_theta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_theta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_theta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_theta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_theta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_theta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_theta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_theta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_theta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_theta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_theta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_theta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_theta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_theta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_theta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastthetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_frame_make(size : Int) -> TimeseriesforecastthetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_frame_len(s : TimeseriesforecastthetaFrame) -> Int { s.size }

pub fn timeseries_forecast_theta_frame_get(s : TimeseriesforecastthetaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_frame_set(s : TimeseriesforecastthetaFrame, i : Int, v : Double) -> TimeseriesforecastthetaFrame {
  let result = timeseries_forecast_theta_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_frame_sum(s : TimeseriesforecastthetaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_frame_mean(s : TimeseriesforecastthetaFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_frame_scale(s : TimeseriesforecastthetaFrame, f : Double) -> TimeseriesforecastthetaFrame {
  let result = timeseries_forecast_theta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_frame_add(a : TimeseriesforecastthetaFrame, b : TimeseriesforecastthetaFrame) -> TimeseriesforecastthetaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_frame_copy(s : TimeseriesforecastthetaFrame) -> TimeseriesforecastthetaFrame {
  let result = timeseries_forecast_theta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_frame_fill(s : TimeseriesforecastthetaFrame, v : Double) -> TimeseriesforecastthetaFrame {
  let result = timeseries_forecast_theta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_frame_min(s : TimeseriesforecastthetaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_frame_max(s : TimeseriesforecastthetaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_frame_to_string(s : TimeseriesforecastthetaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_table_make(size : Int) -> TimeseriesforecastthetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_table_len(s : TimeseriesforecastthetaTable) -> Int { s.size }

pub fn timeseries_forecast_theta_table_get(s : TimeseriesforecastthetaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_table_set(s : TimeseriesforecastthetaTable, i : Int, v : Double) -> TimeseriesforecastthetaTable {
  let result = timeseries_forecast_theta_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_table_sum(s : TimeseriesforecastthetaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_table_mean(s : TimeseriesforecastthetaTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_table_scale(s : TimeseriesforecastthetaTable, f : Double) -> TimeseriesforecastthetaTable {
  let result = timeseries_forecast_theta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_table_add(a : TimeseriesforecastthetaTable, b : TimeseriesforecastthetaTable) -> TimeseriesforecastthetaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_table_copy(s : TimeseriesforecastthetaTable) -> TimeseriesforecastthetaTable {
  let result = timeseries_forecast_theta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_table_fill(s : TimeseriesforecastthetaTable, v : Double) -> TimeseriesforecastthetaTable {
  let result = timeseries_forecast_theta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_table_min(s : TimeseriesforecastthetaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_table_max(s : TimeseriesforecastthetaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_table_to_string(s : TimeseriesforecastthetaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_graphn_make(size : Int) -> TimeseriesforecastthetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_graphn_len(s : TimeseriesforecastthetaGraphN) -> Int { s.size }

pub fn timeseries_forecast_theta_graphn_get(s : TimeseriesforecastthetaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_graphn_set(s : TimeseriesforecastthetaGraphN, i : Int, v : Double) -> TimeseriesforecastthetaGraphN {
  let result = timeseries_forecast_theta_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_graphn_sum(s : TimeseriesforecastthetaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_graphn_mean(s : TimeseriesforecastthetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_graphn_scale(s : TimeseriesforecastthetaGraphN, f : Double) -> TimeseriesforecastthetaGraphN {
  let result = timeseries_forecast_theta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_graphn_add(a : TimeseriesforecastthetaGraphN, b : TimeseriesforecastthetaGraphN) -> TimeseriesforecastthetaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_graphn_copy(s : TimeseriesforecastthetaGraphN) -> TimeseriesforecastthetaGraphN {
  let result = timeseries_forecast_theta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_graphn_fill(s : TimeseriesforecastthetaGraphN, v : Double) -> TimeseriesforecastthetaGraphN {
  let result = timeseries_forecast_theta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_graphn_min(s : TimeseriesforecastthetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_graphn_max(s : TimeseriesforecastthetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_graphn_to_string(s : TimeseriesforecastthetaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_node_make(size : Int) -> TimeseriesforecastthetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_node_len(s : TimeseriesforecastthetaNode) -> Int { s.size }

pub fn timeseries_forecast_theta_node_get(s : TimeseriesforecastthetaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_node_set(s : TimeseriesforecastthetaNode, i : Int, v : Double) -> TimeseriesforecastthetaNode {
  let result = timeseries_forecast_theta_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_node_sum(s : TimeseriesforecastthetaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_node_mean(s : TimeseriesforecastthetaNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_node_scale(s : TimeseriesforecastthetaNode, f : Double) -> TimeseriesforecastthetaNode {
  let result = timeseries_forecast_theta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_node_add(a : TimeseriesforecastthetaNode, b : TimeseriesforecastthetaNode) -> TimeseriesforecastthetaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_node_copy(s : TimeseriesforecastthetaNode) -> TimeseriesforecastthetaNode {
  let result = timeseries_forecast_theta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_node_fill(s : TimeseriesforecastthetaNode, v : Double) -> TimeseriesforecastthetaNode {
  let result = timeseries_forecast_theta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_node_min(s : TimeseriesforecastthetaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_node_max(s : TimeseriesforecastthetaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_node_to_string(s : TimeseriesforecastthetaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_edge_make(size : Int) -> TimeseriesforecastthetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_edge_len(s : TimeseriesforecastthetaEdge) -> Int { s.size }

pub fn timeseries_forecast_theta_edge_get(s : TimeseriesforecastthetaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_edge_set(s : TimeseriesforecastthetaEdge, i : Int, v : Double) -> TimeseriesforecastthetaEdge {
  let result = timeseries_forecast_theta_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_edge_sum(s : TimeseriesforecastthetaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_edge_mean(s : TimeseriesforecastthetaEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_edge_scale(s : TimeseriesforecastthetaEdge, f : Double) -> TimeseriesforecastthetaEdge {
  let result = timeseries_forecast_theta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_edge_add(a : TimeseriesforecastthetaEdge, b : TimeseriesforecastthetaEdge) -> TimeseriesforecastthetaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_edge_copy(s : TimeseriesforecastthetaEdge) -> TimeseriesforecastthetaEdge {
  let result = timeseries_forecast_theta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_edge_fill(s : TimeseriesforecastthetaEdge, v : Double) -> TimeseriesforecastthetaEdge {
  let result = timeseries_forecast_theta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_edge_min(s : TimeseriesforecastthetaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_edge_max(s : TimeseriesforecastthetaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_edge_to_string(s : TimeseriesforecastthetaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_path_make(size : Int) -> TimeseriesforecastthetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_path_len(s : TimeseriesforecastthetaPath) -> Int { s.size }

pub fn timeseries_forecast_theta_path_get(s : TimeseriesforecastthetaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_path_set(s : TimeseriesforecastthetaPath, i : Int, v : Double) -> TimeseriesforecastthetaPath {
  let result = timeseries_forecast_theta_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_path_sum(s : TimeseriesforecastthetaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_path_mean(s : TimeseriesforecastthetaPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_path_scale(s : TimeseriesforecastthetaPath, f : Double) -> TimeseriesforecastthetaPath {
  let result = timeseries_forecast_theta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_path_add(a : TimeseriesforecastthetaPath, b : TimeseriesforecastthetaPath) -> TimeseriesforecastthetaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_path_copy(s : TimeseriesforecastthetaPath) -> TimeseriesforecastthetaPath {
  let result = timeseries_forecast_theta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_path_fill(s : TimeseriesforecastthetaPath, v : Double) -> TimeseriesforecastthetaPath {
  let result = timeseries_forecast_theta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_path_min(s : TimeseriesforecastthetaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_path_max(s : TimeseriesforecastthetaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_path_to_string(s : TimeseriesforecastthetaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_cluster_make(size : Int) -> TimeseriesforecastthetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_cluster_len(s : TimeseriesforecastthetaCluster) -> Int { s.size }

pub fn timeseries_forecast_theta_cluster_get(s : TimeseriesforecastthetaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_cluster_set(s : TimeseriesforecastthetaCluster, i : Int, v : Double) -> TimeseriesforecastthetaCluster {
  let result = timeseries_forecast_theta_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_cluster_sum(s : TimeseriesforecastthetaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_cluster_mean(s : TimeseriesforecastthetaCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_cluster_scale(s : TimeseriesforecastthetaCluster, f : Double) -> TimeseriesforecastthetaCluster {
  let result = timeseries_forecast_theta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_cluster_add(a : TimeseriesforecastthetaCluster, b : TimeseriesforecastthetaCluster) -> TimeseriesforecastthetaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_cluster_copy(s : TimeseriesforecastthetaCluster) -> TimeseriesforecastthetaCluster {
  let result = timeseries_forecast_theta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_cluster_fill(s : TimeseriesforecastthetaCluster, v : Double) -> TimeseriesforecastthetaCluster {
  let result = timeseries_forecast_theta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_cluster_min(s : TimeseriesforecastthetaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_cluster_max(s : TimeseriesforecastthetaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_cluster_to_string(s : TimeseriesforecastthetaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_model_make(size : Int) -> TimeseriesforecastthetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_model_len(s : TimeseriesforecastthetaModel) -> Int { s.size }

pub fn timeseries_forecast_theta_model_get(s : TimeseriesforecastthetaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_model_set(s : TimeseriesforecastthetaModel, i : Int, v : Double) -> TimeseriesforecastthetaModel {
  let result = timeseries_forecast_theta_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_model_sum(s : TimeseriesforecastthetaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_model_mean(s : TimeseriesforecastthetaModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_model_scale(s : TimeseriesforecastthetaModel, f : Double) -> TimeseriesforecastthetaModel {
  let result = timeseries_forecast_theta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_model_add(a : TimeseriesforecastthetaModel, b : TimeseriesforecastthetaModel) -> TimeseriesforecastthetaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_model_copy(s : TimeseriesforecastthetaModel) -> TimeseriesforecastthetaModel {
  let result = timeseries_forecast_theta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_model_fill(s : TimeseriesforecastthetaModel, v : Double) -> TimeseriesforecastthetaModel {
  let result = timeseries_forecast_theta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_model_min(s : TimeseriesforecastthetaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_model_max(s : TimeseriesforecastthetaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_model_to_string(s : TimeseriesforecastthetaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_layer_make(size : Int) -> TimeseriesforecastthetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_layer_len(s : TimeseriesforecastthetaLayer) -> Int { s.size }

pub fn timeseries_forecast_theta_layer_get(s : TimeseriesforecastthetaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_layer_set(s : TimeseriesforecastthetaLayer, i : Int, v : Double) -> TimeseriesforecastthetaLayer {
  let result = timeseries_forecast_theta_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_layer_sum(s : TimeseriesforecastthetaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_layer_mean(s : TimeseriesforecastthetaLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_layer_scale(s : TimeseriesforecastthetaLayer, f : Double) -> TimeseriesforecastthetaLayer {
  let result = timeseries_forecast_theta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_layer_add(a : TimeseriesforecastthetaLayer, b : TimeseriesforecastthetaLayer) -> TimeseriesforecastthetaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_layer_copy(s : TimeseriesforecastthetaLayer) -> TimeseriesforecastthetaLayer {
  let result = timeseries_forecast_theta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_layer_fill(s : TimeseriesforecastthetaLayer, v : Double) -> TimeseriesforecastthetaLayer {
  let result = timeseries_forecast_theta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_layer_min(s : TimeseriesforecastthetaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_layer_max(s : TimeseriesforecastthetaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_layer_to_string(s : TimeseriesforecastthetaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_buffer_make(size : Int) -> TimeseriesforecastthetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_buffer_len(s : TimeseriesforecastthetaBuffer) -> Int { s.size }

pub fn timeseries_forecast_theta_buffer_get(s : TimeseriesforecastthetaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_buffer_set(s : TimeseriesforecastthetaBuffer, i : Int, v : Double) -> TimeseriesforecastthetaBuffer {
  let result = timeseries_forecast_theta_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_buffer_sum(s : TimeseriesforecastthetaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_buffer_mean(s : TimeseriesforecastthetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_buffer_scale(s : TimeseriesforecastthetaBuffer, f : Double) -> TimeseriesforecastthetaBuffer {
  let result = timeseries_forecast_theta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_buffer_add(a : TimeseriesforecastthetaBuffer, b : TimeseriesforecastthetaBuffer) -> TimeseriesforecastthetaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_buffer_copy(s : TimeseriesforecastthetaBuffer) -> TimeseriesforecastthetaBuffer {
  let result = timeseries_forecast_theta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_buffer_fill(s : TimeseriesforecastthetaBuffer, v : Double) -> TimeseriesforecastthetaBuffer {
  let result = timeseries_forecast_theta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_buffer_min(s : TimeseriesforecastthetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_buffer_max(s : TimeseriesforecastthetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_buffer_to_string(s : TimeseriesforecastthetaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_cursor_make(size : Int) -> TimeseriesforecastthetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_cursor_len(s : TimeseriesforecastthetaCursor) -> Int { s.size }

pub fn timeseries_forecast_theta_cursor_get(s : TimeseriesforecastthetaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_cursor_set(s : TimeseriesforecastthetaCursor, i : Int, v : Double) -> TimeseriesforecastthetaCursor {
  let result = timeseries_forecast_theta_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_cursor_sum(s : TimeseriesforecastthetaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_cursor_mean(s : TimeseriesforecastthetaCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_cursor_scale(s : TimeseriesforecastthetaCursor, f : Double) -> TimeseriesforecastthetaCursor {
  let result = timeseries_forecast_theta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_cursor_add(a : TimeseriesforecastthetaCursor, b : TimeseriesforecastthetaCursor) -> TimeseriesforecastthetaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_cursor_copy(s : TimeseriesforecastthetaCursor) -> TimeseriesforecastthetaCursor {
  let result = timeseries_forecast_theta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_cursor_fill(s : TimeseriesforecastthetaCursor, v : Double) -> TimeseriesforecastthetaCursor {
  let result = timeseries_forecast_theta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_cursor_min(s : TimeseriesforecastthetaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_cursor_max(s : TimeseriesforecastthetaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_cursor_to_string(s : TimeseriesforecastthetaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_view_make(size : Int) -> TimeseriesforecastthetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_view_len(s : TimeseriesforecastthetaView) -> Int { s.size }

pub fn timeseries_forecast_theta_view_get(s : TimeseriesforecastthetaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_view_set(s : TimeseriesforecastthetaView, i : Int, v : Double) -> TimeseriesforecastthetaView {
  let result = timeseries_forecast_theta_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_view_sum(s : TimeseriesforecastthetaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_view_mean(s : TimeseriesforecastthetaView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_view_scale(s : TimeseriesforecastthetaView, f : Double) -> TimeseriesforecastthetaView {
  let result = timeseries_forecast_theta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_view_add(a : TimeseriesforecastthetaView, b : TimeseriesforecastthetaView) -> TimeseriesforecastthetaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_view_copy(s : TimeseriesforecastthetaView) -> TimeseriesforecastthetaView {
  let result = timeseries_forecast_theta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_view_fill(s : TimeseriesforecastthetaView, v : Double) -> TimeseriesforecastthetaView {
  let result = timeseries_forecast_theta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_view_min(s : TimeseriesforecastthetaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_view_max(s : TimeseriesforecastthetaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_view_to_string(s : TimeseriesforecastthetaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_range_make(size : Int) -> TimeseriesforecastthetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_range_len(s : TimeseriesforecastthetaRange) -> Int { s.size }

pub fn timeseries_forecast_theta_range_get(s : TimeseriesforecastthetaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_range_set(s : TimeseriesforecastthetaRange, i : Int, v : Double) -> TimeseriesforecastthetaRange {
  let result = timeseries_forecast_theta_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_range_sum(s : TimeseriesforecastthetaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_range_mean(s : TimeseriesforecastthetaRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_range_scale(s : TimeseriesforecastthetaRange, f : Double) -> TimeseriesforecastthetaRange {
  let result = timeseries_forecast_theta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_range_add(a : TimeseriesforecastthetaRange, b : TimeseriesforecastthetaRange) -> TimeseriesforecastthetaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_range_copy(s : TimeseriesforecastthetaRange) -> TimeseriesforecastthetaRange {
  let result = timeseries_forecast_theta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_range_fill(s : TimeseriesforecastthetaRange, v : Double) -> TimeseriesforecastthetaRange {
  let result = timeseries_forecast_theta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_range_min(s : TimeseriesforecastthetaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_range_max(s : TimeseriesforecastthetaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_range_to_string(s : TimeseriesforecastthetaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_slice_make(size : Int) -> TimeseriesforecastthetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_slice_len(s : TimeseriesforecastthetaSlice) -> Int { s.size }

pub fn timeseries_forecast_theta_slice_get(s : TimeseriesforecastthetaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_slice_set(s : TimeseriesforecastthetaSlice, i : Int, v : Double) -> TimeseriesforecastthetaSlice {
  let result = timeseries_forecast_theta_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_slice_sum(s : TimeseriesforecastthetaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_forecast_theta_slice_mean(s : TimeseriesforecastthetaSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_forecast_theta_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_forecast_theta_slice_scale(s : TimeseriesforecastthetaSlice, f : Double) -> TimeseriesforecastthetaSlice {
  let result = timeseries_forecast_theta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_forecast_theta_slice_add(a : TimeseriesforecastthetaSlice, b : TimeseriesforecastthetaSlice) -> TimeseriesforecastthetaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_forecast_theta_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_forecast_theta_slice_copy(s : TimeseriesforecastthetaSlice) -> TimeseriesforecastthetaSlice {
  let result = timeseries_forecast_theta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_forecast_theta_slice_fill(s : TimeseriesforecastthetaSlice, v : Double) -> TimeseriesforecastthetaSlice {
  let result = timeseries_forecast_theta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_forecast_theta_slice_min(s : TimeseriesforecastthetaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_slice_max(s : TimeseriesforecastthetaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_forecast_theta_slice_to_string(s : TimeseriesforecastthetaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

