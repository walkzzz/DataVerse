///===
/// extcore/timeseries_anomaly_dbscan

pub(all) struct TimeseriesanomalydbscanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_dbscan_make_point(x : Double, y : Double) -> TimeseriesanomalydbscanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_dbscan_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalydbscanPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_dbscan_point_x(pt : TimeseriesanomalydbscanPoint) -> Double { pt.x }

pub fn timeseries_anomaly_dbscan_point_y(pt : TimeseriesanomalydbscanPoint) -> Double { pt.y }

pub fn timeseries_anomaly_dbscan_point_z(pt : TimeseriesanomalydbscanPoint) -> Double { pt.z }

pub fn timeseries_anomaly_dbscan_point_label(pt : TimeseriesanomalydbscanPoint) -> Int { pt.label }

pub fn timeseries_anomaly_dbscan_point_dist(a : TimeseriesanomalydbscanPoint, b : TimeseriesanomalydbscanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_dbscan_point_add(a : TimeseriesanomalydbscanPoint, b : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_dbscan_point_sub(a : TimeseriesanomalydbscanPoint, b : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_dbscan_point_scale(pt : TimeseriesanomalydbscanPoint, s : Double) -> TimeseriesanomalydbscanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_dbscan_point_dot(a : TimeseriesanomalydbscanPoint, b : TimeseriesanomalydbscanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_dbscan_point_cross(a : TimeseriesanomalydbscanPoint, b : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_dbscan_point_norm(pt : TimeseriesanomalydbscanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_dbscan_point_normalize(pt : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  let n = timeseries_anomaly_dbscan_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_dbscan_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_dbscan_point_negate(pt : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_dbscan_point_mid(a : TimeseriesanomalydbscanPoint, b : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_dbscan_point_lerp(a : TimeseriesanomalydbscanPoint, b : TimeseriesanomalydbscanPoint, t : Double) -> TimeseriesanomalydbscanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_dbscan_point_to_string(pt : TimeseriesanomalydbscanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_dbscan_make_series(vals : Array[Double], name : String) -> TimeseriesanomalydbscanSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_dbscan_series_len(s : TimeseriesanomalydbscanSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_dbscan_series_sum(s : TimeseriesanomalydbscanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_anomaly_dbscan_series_mean(s : TimeseriesanomalydbscanSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_anomaly_dbscan_series_min(s : TimeseriesanomalydbscanSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_anomaly_dbscan_series_max(s : TimeseriesanomalydbscanSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_anomaly_dbscan_series_range(s : TimeseriesanomalydbscanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_anomaly_dbscan_series_var(s : TimeseriesanomalydbscanSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_anomaly_dbscan_series_std(s : TimeseriesanomalydbscanSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_anomaly_dbscan_series_median(s : TimeseriesanomalydbscanSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_anomaly_dbscan_series_scale(s : TimeseriesanomalydbscanSeries, f : Double) -> TimeseriesanomalydbscanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_dbscan_series_add(a : TimeseriesanomalydbscanSeries, b : TimeseriesanomalydbscanSeries) -> TimeseriesanomalydbscanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_dbscan_series_sub(a : TimeseriesanomalydbscanSeries, b : TimeseriesanomalydbscanSeries) -> TimeseriesanomalydbscanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_dbscan_series_normalize(s : TimeseriesanomalydbscanSeries) -> TimeseriesanomalydbscanSeries {
  let mn = timeseries_anomaly_dbscan_series_min(s)
  let mx = timeseries_anomaly_dbscan_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_dbscan_series_cumsum(s : TimeseriesanomalydbscanSeries) -> TimeseriesanomalydbscanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_dbscan_series_to_string(s : TimeseriesanomalydbscanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalydbscanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_dbscan_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalydbscanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_dbscan_matrix_identity(n : Int) -> TimeseriesanomalydbscanMatrix {
  let m = timeseries_anomaly_dbscan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_dbscan_matrix_get(m : TimeseriesanomalydbscanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_dbscan_matrix_transpose(m : TimeseriesanomalydbscanMatrix) -> TimeseriesanomalydbscanMatrix {
  let result = timeseries_anomaly_dbscan_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_dbscan_matrix_add(a : TimeseriesanomalydbscanMatrix, b : TimeseriesanomalydbscanMatrix) -> TimeseriesanomalydbscanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_dbscan_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_dbscan_matrix_scale(m : TimeseriesanomalydbscanMatrix, s : Double) -> TimeseriesanomalydbscanMatrix {
  let result = timeseries_anomaly_dbscan_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_dbscan_matrix_multiply(a : TimeseriesanomalydbscanMatrix, b : TimeseriesanomalydbscanMatrix) -> TimeseriesanomalydbscanMatrix {
  if a.cols != b.rows { return timeseries_anomaly_dbscan_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_dbscan_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_dbscan_matrix_trace(m : TimeseriesanomalydbscanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_dbscan_matrix_det(m : TimeseriesanomalydbscanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_dbscan_matrix_norm(m : TimeseriesanomalydbscanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_anomaly_dbscan_matrix_to_string(m : TimeseriesanomalydbscanMatrix) -> String {
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

pub(all) struct TimeseriesanomalydbscanVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_dbscan_make_vector(comps : Array[Double]) -> TimeseriesanomalydbscanVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_dbscan_vector_zero(dim : Int) -> TimeseriesanomalydbscanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_dbscan_vector_add(a : TimeseriesanomalydbscanVector, b : TimeseriesanomalydbscanVector) -> TimeseriesanomalydbscanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_dbscan_vector_sub(a : TimeseriesanomalydbscanVector, b : TimeseriesanomalydbscanVector) -> TimeseriesanomalydbscanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_dbscan_vector_scale(v : TimeseriesanomalydbscanVector, s : Double) -> TimeseriesanomalydbscanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_dbscan_vector_dot(a : TimeseriesanomalydbscanVector, b : TimeseriesanomalydbscanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_dbscan_vector_norm(v : TimeseriesanomalydbscanVector) -> Double { @_common.sqrt(timeseries_anomaly_dbscan_vector_dot(v, v)) }

pub fn timeseries_anomaly_dbscan_vector_normalize(v : TimeseriesanomalydbscanVector) -> TimeseriesanomalydbscanVector {
  let n = timeseries_anomaly_dbscan_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_dbscan_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_dbscan_vector_dist(a : TimeseriesanomalydbscanVector, b : TimeseriesanomalydbscanVector) -> Double {
  timeseries_anomaly_dbscan_vector_norm(timeseries_anomaly_dbscan_vector_sub(a, b))
}

pub fn timeseries_anomaly_dbscan_vector_to_string(v : TimeseriesanomalydbscanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_dbscan_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_dbscan_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_dbscan_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_dbscan_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_dbscan_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_dbscan_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_dbscan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_dbscan_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_dbscan_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_dbscan_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_dbscan_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_dbscan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_dbscan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_dbscan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_dbscan_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_dbscan_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_dbscan_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_dbscan_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_dbscan_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_dbscan_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_dbscan_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_dbscan_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_dbscan_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_dbscan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_dbscan_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_dbscan_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_dbscan_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_dbscan_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_dbscan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalydbscanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_frame_make(size : Int) -> TimeseriesanomalydbscanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_frame_len(s : TimeseriesanomalydbscanFrame) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_frame_get(s : TimeseriesanomalydbscanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_frame_set(s : TimeseriesanomalydbscanFrame, i : Int, v : Double) -> TimeseriesanomalydbscanFrame {
  let result = timeseries_anomaly_dbscan_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_frame_sum(s : TimeseriesanomalydbscanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_frame_mean(s : TimeseriesanomalydbscanFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_frame_scale(s : TimeseriesanomalydbscanFrame, f : Double) -> TimeseriesanomalydbscanFrame {
  let result = timeseries_anomaly_dbscan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_frame_add(a : TimeseriesanomalydbscanFrame, b : TimeseriesanomalydbscanFrame) -> TimeseriesanomalydbscanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_frame_copy(s : TimeseriesanomalydbscanFrame) -> TimeseriesanomalydbscanFrame {
  let result = timeseries_anomaly_dbscan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_frame_fill(s : TimeseriesanomalydbscanFrame, v : Double) -> TimeseriesanomalydbscanFrame {
  let result = timeseries_anomaly_dbscan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_frame_min(s : TimeseriesanomalydbscanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_frame_max(s : TimeseriesanomalydbscanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_frame_to_string(s : TimeseriesanomalydbscanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_table_make(size : Int) -> TimeseriesanomalydbscanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_table_len(s : TimeseriesanomalydbscanTable) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_table_get(s : TimeseriesanomalydbscanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_table_set(s : TimeseriesanomalydbscanTable, i : Int, v : Double) -> TimeseriesanomalydbscanTable {
  let result = timeseries_anomaly_dbscan_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_table_sum(s : TimeseriesanomalydbscanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_table_mean(s : TimeseriesanomalydbscanTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_table_scale(s : TimeseriesanomalydbscanTable, f : Double) -> TimeseriesanomalydbscanTable {
  let result = timeseries_anomaly_dbscan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_table_add(a : TimeseriesanomalydbscanTable, b : TimeseriesanomalydbscanTable) -> TimeseriesanomalydbscanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_table_copy(s : TimeseriesanomalydbscanTable) -> TimeseriesanomalydbscanTable {
  let result = timeseries_anomaly_dbscan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_table_fill(s : TimeseriesanomalydbscanTable, v : Double) -> TimeseriesanomalydbscanTable {
  let result = timeseries_anomaly_dbscan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_table_min(s : TimeseriesanomalydbscanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_table_max(s : TimeseriesanomalydbscanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_table_to_string(s : TimeseriesanomalydbscanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_graphn_make(size : Int) -> TimeseriesanomalydbscanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_graphn_len(s : TimeseriesanomalydbscanGraphN) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_graphn_get(s : TimeseriesanomalydbscanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_graphn_set(s : TimeseriesanomalydbscanGraphN, i : Int, v : Double) -> TimeseriesanomalydbscanGraphN {
  let result = timeseries_anomaly_dbscan_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_graphn_sum(s : TimeseriesanomalydbscanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_graphn_mean(s : TimeseriesanomalydbscanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_graphn_scale(s : TimeseriesanomalydbscanGraphN, f : Double) -> TimeseriesanomalydbscanGraphN {
  let result = timeseries_anomaly_dbscan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_graphn_add(a : TimeseriesanomalydbscanGraphN, b : TimeseriesanomalydbscanGraphN) -> TimeseriesanomalydbscanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_graphn_copy(s : TimeseriesanomalydbscanGraphN) -> TimeseriesanomalydbscanGraphN {
  let result = timeseries_anomaly_dbscan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_graphn_fill(s : TimeseriesanomalydbscanGraphN, v : Double) -> TimeseriesanomalydbscanGraphN {
  let result = timeseries_anomaly_dbscan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_graphn_min(s : TimeseriesanomalydbscanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_graphn_max(s : TimeseriesanomalydbscanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_graphn_to_string(s : TimeseriesanomalydbscanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_node_make(size : Int) -> TimeseriesanomalydbscanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_node_len(s : TimeseriesanomalydbscanNode) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_node_get(s : TimeseriesanomalydbscanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_node_set(s : TimeseriesanomalydbscanNode, i : Int, v : Double) -> TimeseriesanomalydbscanNode {
  let result = timeseries_anomaly_dbscan_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_node_sum(s : TimeseriesanomalydbscanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_node_mean(s : TimeseriesanomalydbscanNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_node_scale(s : TimeseriesanomalydbscanNode, f : Double) -> TimeseriesanomalydbscanNode {
  let result = timeseries_anomaly_dbscan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_node_add(a : TimeseriesanomalydbscanNode, b : TimeseriesanomalydbscanNode) -> TimeseriesanomalydbscanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_node_copy(s : TimeseriesanomalydbscanNode) -> TimeseriesanomalydbscanNode {
  let result = timeseries_anomaly_dbscan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_node_fill(s : TimeseriesanomalydbscanNode, v : Double) -> TimeseriesanomalydbscanNode {
  let result = timeseries_anomaly_dbscan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_node_min(s : TimeseriesanomalydbscanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_node_max(s : TimeseriesanomalydbscanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_node_to_string(s : TimeseriesanomalydbscanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_edge_make(size : Int) -> TimeseriesanomalydbscanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_edge_len(s : TimeseriesanomalydbscanEdge) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_edge_get(s : TimeseriesanomalydbscanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_edge_set(s : TimeseriesanomalydbscanEdge, i : Int, v : Double) -> TimeseriesanomalydbscanEdge {
  let result = timeseries_anomaly_dbscan_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_edge_sum(s : TimeseriesanomalydbscanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_edge_mean(s : TimeseriesanomalydbscanEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_edge_scale(s : TimeseriesanomalydbscanEdge, f : Double) -> TimeseriesanomalydbscanEdge {
  let result = timeseries_anomaly_dbscan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_edge_add(a : TimeseriesanomalydbscanEdge, b : TimeseriesanomalydbscanEdge) -> TimeseriesanomalydbscanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_edge_copy(s : TimeseriesanomalydbscanEdge) -> TimeseriesanomalydbscanEdge {
  let result = timeseries_anomaly_dbscan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_edge_fill(s : TimeseriesanomalydbscanEdge, v : Double) -> TimeseriesanomalydbscanEdge {
  let result = timeseries_anomaly_dbscan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_edge_min(s : TimeseriesanomalydbscanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_edge_max(s : TimeseriesanomalydbscanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_edge_to_string(s : TimeseriesanomalydbscanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_path_make(size : Int) -> TimeseriesanomalydbscanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_path_len(s : TimeseriesanomalydbscanPath) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_path_get(s : TimeseriesanomalydbscanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_path_set(s : TimeseriesanomalydbscanPath, i : Int, v : Double) -> TimeseriesanomalydbscanPath {
  let result = timeseries_anomaly_dbscan_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_path_sum(s : TimeseriesanomalydbscanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_path_mean(s : TimeseriesanomalydbscanPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_path_scale(s : TimeseriesanomalydbscanPath, f : Double) -> TimeseriesanomalydbscanPath {
  let result = timeseries_anomaly_dbscan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_path_add(a : TimeseriesanomalydbscanPath, b : TimeseriesanomalydbscanPath) -> TimeseriesanomalydbscanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_path_copy(s : TimeseriesanomalydbscanPath) -> TimeseriesanomalydbscanPath {
  let result = timeseries_anomaly_dbscan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_path_fill(s : TimeseriesanomalydbscanPath, v : Double) -> TimeseriesanomalydbscanPath {
  let result = timeseries_anomaly_dbscan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_path_min(s : TimeseriesanomalydbscanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_path_max(s : TimeseriesanomalydbscanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_path_to_string(s : TimeseriesanomalydbscanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_cluster_make(size : Int) -> TimeseriesanomalydbscanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_cluster_len(s : TimeseriesanomalydbscanCluster) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_cluster_get(s : TimeseriesanomalydbscanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_cluster_set(s : TimeseriesanomalydbscanCluster, i : Int, v : Double) -> TimeseriesanomalydbscanCluster {
  let result = timeseries_anomaly_dbscan_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_cluster_sum(s : TimeseriesanomalydbscanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_cluster_mean(s : TimeseriesanomalydbscanCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_cluster_scale(s : TimeseriesanomalydbscanCluster, f : Double) -> TimeseriesanomalydbscanCluster {
  let result = timeseries_anomaly_dbscan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_cluster_add(a : TimeseriesanomalydbscanCluster, b : TimeseriesanomalydbscanCluster) -> TimeseriesanomalydbscanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_cluster_copy(s : TimeseriesanomalydbscanCluster) -> TimeseriesanomalydbscanCluster {
  let result = timeseries_anomaly_dbscan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_cluster_fill(s : TimeseriesanomalydbscanCluster, v : Double) -> TimeseriesanomalydbscanCluster {
  let result = timeseries_anomaly_dbscan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_cluster_min(s : TimeseriesanomalydbscanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_cluster_max(s : TimeseriesanomalydbscanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_cluster_to_string(s : TimeseriesanomalydbscanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_model_make(size : Int) -> TimeseriesanomalydbscanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_model_len(s : TimeseriesanomalydbscanModel) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_model_get(s : TimeseriesanomalydbscanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_model_set(s : TimeseriesanomalydbscanModel, i : Int, v : Double) -> TimeseriesanomalydbscanModel {
  let result = timeseries_anomaly_dbscan_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_model_sum(s : TimeseriesanomalydbscanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_model_mean(s : TimeseriesanomalydbscanModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_model_scale(s : TimeseriesanomalydbscanModel, f : Double) -> TimeseriesanomalydbscanModel {
  let result = timeseries_anomaly_dbscan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_model_add(a : TimeseriesanomalydbscanModel, b : TimeseriesanomalydbscanModel) -> TimeseriesanomalydbscanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_model_copy(s : TimeseriesanomalydbscanModel) -> TimeseriesanomalydbscanModel {
  let result = timeseries_anomaly_dbscan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_model_fill(s : TimeseriesanomalydbscanModel, v : Double) -> TimeseriesanomalydbscanModel {
  let result = timeseries_anomaly_dbscan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_model_min(s : TimeseriesanomalydbscanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_model_max(s : TimeseriesanomalydbscanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_model_to_string(s : TimeseriesanomalydbscanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_layer_make(size : Int) -> TimeseriesanomalydbscanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_layer_len(s : TimeseriesanomalydbscanLayer) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_layer_get(s : TimeseriesanomalydbscanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_layer_set(s : TimeseriesanomalydbscanLayer, i : Int, v : Double) -> TimeseriesanomalydbscanLayer {
  let result = timeseries_anomaly_dbscan_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_layer_sum(s : TimeseriesanomalydbscanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_layer_mean(s : TimeseriesanomalydbscanLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_layer_scale(s : TimeseriesanomalydbscanLayer, f : Double) -> TimeseriesanomalydbscanLayer {
  let result = timeseries_anomaly_dbscan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_layer_add(a : TimeseriesanomalydbscanLayer, b : TimeseriesanomalydbscanLayer) -> TimeseriesanomalydbscanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_layer_copy(s : TimeseriesanomalydbscanLayer) -> TimeseriesanomalydbscanLayer {
  let result = timeseries_anomaly_dbscan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_layer_fill(s : TimeseriesanomalydbscanLayer, v : Double) -> TimeseriesanomalydbscanLayer {
  let result = timeseries_anomaly_dbscan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_layer_min(s : TimeseriesanomalydbscanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_layer_max(s : TimeseriesanomalydbscanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_layer_to_string(s : TimeseriesanomalydbscanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_buffer_make(size : Int) -> TimeseriesanomalydbscanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_buffer_len(s : TimeseriesanomalydbscanBuffer) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_buffer_get(s : TimeseriesanomalydbscanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_buffer_set(s : TimeseriesanomalydbscanBuffer, i : Int, v : Double) -> TimeseriesanomalydbscanBuffer {
  let result = timeseries_anomaly_dbscan_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_buffer_sum(s : TimeseriesanomalydbscanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_buffer_mean(s : TimeseriesanomalydbscanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_buffer_scale(s : TimeseriesanomalydbscanBuffer, f : Double) -> TimeseriesanomalydbscanBuffer {
  let result = timeseries_anomaly_dbscan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_buffer_add(a : TimeseriesanomalydbscanBuffer, b : TimeseriesanomalydbscanBuffer) -> TimeseriesanomalydbscanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_buffer_copy(s : TimeseriesanomalydbscanBuffer) -> TimeseriesanomalydbscanBuffer {
  let result = timeseries_anomaly_dbscan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_buffer_fill(s : TimeseriesanomalydbscanBuffer, v : Double) -> TimeseriesanomalydbscanBuffer {
  let result = timeseries_anomaly_dbscan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_buffer_min(s : TimeseriesanomalydbscanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_buffer_max(s : TimeseriesanomalydbscanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_buffer_to_string(s : TimeseriesanomalydbscanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_cursor_make(size : Int) -> TimeseriesanomalydbscanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_cursor_len(s : TimeseriesanomalydbscanCursor) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_cursor_get(s : TimeseriesanomalydbscanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_cursor_set(s : TimeseriesanomalydbscanCursor, i : Int, v : Double) -> TimeseriesanomalydbscanCursor {
  let result = timeseries_anomaly_dbscan_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_cursor_sum(s : TimeseriesanomalydbscanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_cursor_mean(s : TimeseriesanomalydbscanCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_cursor_scale(s : TimeseriesanomalydbscanCursor, f : Double) -> TimeseriesanomalydbscanCursor {
  let result = timeseries_anomaly_dbscan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_cursor_add(a : TimeseriesanomalydbscanCursor, b : TimeseriesanomalydbscanCursor) -> TimeseriesanomalydbscanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_cursor_copy(s : TimeseriesanomalydbscanCursor) -> TimeseriesanomalydbscanCursor {
  let result = timeseries_anomaly_dbscan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_cursor_fill(s : TimeseriesanomalydbscanCursor, v : Double) -> TimeseriesanomalydbscanCursor {
  let result = timeseries_anomaly_dbscan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_cursor_min(s : TimeseriesanomalydbscanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_cursor_max(s : TimeseriesanomalydbscanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_cursor_to_string(s : TimeseriesanomalydbscanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_view_make(size : Int) -> TimeseriesanomalydbscanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_view_len(s : TimeseriesanomalydbscanView) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_view_get(s : TimeseriesanomalydbscanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_view_set(s : TimeseriesanomalydbscanView, i : Int, v : Double) -> TimeseriesanomalydbscanView {
  let result = timeseries_anomaly_dbscan_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_view_sum(s : TimeseriesanomalydbscanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_view_mean(s : TimeseriesanomalydbscanView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_view_scale(s : TimeseriesanomalydbscanView, f : Double) -> TimeseriesanomalydbscanView {
  let result = timeseries_anomaly_dbscan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_view_add(a : TimeseriesanomalydbscanView, b : TimeseriesanomalydbscanView) -> TimeseriesanomalydbscanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_view_copy(s : TimeseriesanomalydbscanView) -> TimeseriesanomalydbscanView {
  let result = timeseries_anomaly_dbscan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_view_fill(s : TimeseriesanomalydbscanView, v : Double) -> TimeseriesanomalydbscanView {
  let result = timeseries_anomaly_dbscan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_view_min(s : TimeseriesanomalydbscanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_view_max(s : TimeseriesanomalydbscanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_view_to_string(s : TimeseriesanomalydbscanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_range_make(size : Int) -> TimeseriesanomalydbscanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_range_len(s : TimeseriesanomalydbscanRange) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_range_get(s : TimeseriesanomalydbscanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_range_set(s : TimeseriesanomalydbscanRange, i : Int, v : Double) -> TimeseriesanomalydbscanRange {
  let result = timeseries_anomaly_dbscan_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_range_sum(s : TimeseriesanomalydbscanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_range_mean(s : TimeseriesanomalydbscanRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_range_scale(s : TimeseriesanomalydbscanRange, f : Double) -> TimeseriesanomalydbscanRange {
  let result = timeseries_anomaly_dbscan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_range_add(a : TimeseriesanomalydbscanRange, b : TimeseriesanomalydbscanRange) -> TimeseriesanomalydbscanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_range_copy(s : TimeseriesanomalydbscanRange) -> TimeseriesanomalydbscanRange {
  let result = timeseries_anomaly_dbscan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_range_fill(s : TimeseriesanomalydbscanRange, v : Double) -> TimeseriesanomalydbscanRange {
  let result = timeseries_anomaly_dbscan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_range_min(s : TimeseriesanomalydbscanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_range_max(s : TimeseriesanomalydbscanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_range_to_string(s : TimeseriesanomalydbscanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_slice_make(size : Int) -> TimeseriesanomalydbscanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_slice_len(s : TimeseriesanomalydbscanSlice) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_slice_get(s : TimeseriesanomalydbscanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_slice_set(s : TimeseriesanomalydbscanSlice, i : Int, v : Double) -> TimeseriesanomalydbscanSlice {
  let result = timeseries_anomaly_dbscan_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_slice_sum(s : TimeseriesanomalydbscanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_anomaly_dbscan_slice_mean(s : TimeseriesanomalydbscanSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_anomaly_dbscan_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_anomaly_dbscan_slice_scale(s : TimeseriesanomalydbscanSlice, f : Double) -> TimeseriesanomalydbscanSlice {
  let result = timeseries_anomaly_dbscan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_dbscan_slice_add(a : TimeseriesanomalydbscanSlice, b : TimeseriesanomalydbscanSlice) -> TimeseriesanomalydbscanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_dbscan_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_slice_copy(s : TimeseriesanomalydbscanSlice) -> TimeseriesanomalydbscanSlice {
  let result = timeseries_anomaly_dbscan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_dbscan_slice_fill(s : TimeseriesanomalydbscanSlice, v : Double) -> TimeseriesanomalydbscanSlice {
  let result = timeseries_anomaly_dbscan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_dbscan_slice_min(s : TimeseriesanomalydbscanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_slice_max(s : TimeseriesanomalydbscanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_anomaly_dbscan_slice_to_string(s : TimeseriesanomalydbscanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

