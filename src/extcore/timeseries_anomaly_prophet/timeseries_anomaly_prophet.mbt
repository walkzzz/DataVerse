///===
/// extcore/timeseries_anomaly_prophet

pub(all) struct TimeseriesanomalyprophetPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_prophet_make_point(x : Double, y : Double) -> TimeseriesanomalyprophetPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_prophet_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyprophetPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_prophet_point_x(pt : TimeseriesanomalyprophetPoint) -> Double { pt.x }

pub fn timeseries_anomaly_prophet_point_y(pt : TimeseriesanomalyprophetPoint) -> Double { pt.y }

pub fn timeseries_anomaly_prophet_point_z(pt : TimeseriesanomalyprophetPoint) -> Double { pt.z }

pub fn timeseries_anomaly_prophet_point_label(pt : TimeseriesanomalyprophetPoint) -> Int { pt.label }

pub fn timeseries_anomaly_prophet_point_dist(a : TimeseriesanomalyprophetPoint, b : TimeseriesanomalyprophetPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_prophet_point_add(a : TimeseriesanomalyprophetPoint, b : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_prophet_point_sub(a : TimeseriesanomalyprophetPoint, b : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_prophet_point_scale(pt : TimeseriesanomalyprophetPoint, s : Double) -> TimeseriesanomalyprophetPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_prophet_point_dot(a : TimeseriesanomalyprophetPoint, b : TimeseriesanomalyprophetPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_prophet_point_cross(a : TimeseriesanomalyprophetPoint, b : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_prophet_point_norm(pt : TimeseriesanomalyprophetPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_prophet_point_normalize(pt : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  let n = timeseries_anomaly_prophet_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_prophet_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_prophet_point_negate(pt : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_prophet_point_mid(a : TimeseriesanomalyprophetPoint, b : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_prophet_point_lerp(a : TimeseriesanomalyprophetPoint, b : TimeseriesanomalyprophetPoint, t : Double) -> TimeseriesanomalyprophetPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_prophet_point_to_string(pt : TimeseriesanomalyprophetPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_prophet_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyprophetSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_prophet_series_len(s : TimeseriesanomalyprophetSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_prophet_series_sum(s : TimeseriesanomalyprophetSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_anomaly_prophet_series_mean(s : TimeseriesanomalyprophetSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_anomaly_prophet_series_min(s : TimeseriesanomalyprophetSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_anomaly_prophet_series_max(s : TimeseriesanomalyprophetSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_anomaly_prophet_series_range(s : TimeseriesanomalyprophetSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_anomaly_prophet_series_var(s : TimeseriesanomalyprophetSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_anomaly_prophet_series_std(s : TimeseriesanomalyprophetSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_anomaly_prophet_series_median(s : TimeseriesanomalyprophetSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_anomaly_prophet_series_scale(s : TimeseriesanomalyprophetSeries, f : Double) -> TimeseriesanomalyprophetSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_prophet_series_add(a : TimeseriesanomalyprophetSeries, b : TimeseriesanomalyprophetSeries) -> TimeseriesanomalyprophetSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_prophet_series_sub(a : TimeseriesanomalyprophetSeries, b : TimeseriesanomalyprophetSeries) -> TimeseriesanomalyprophetSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_prophet_series_normalize(s : TimeseriesanomalyprophetSeries) -> TimeseriesanomalyprophetSeries {
  let mn = timeseries_anomaly_prophet_series_min(s)
  let mx = timeseries_anomaly_prophet_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_prophet_series_cumsum(s : TimeseriesanomalyprophetSeries) -> TimeseriesanomalyprophetSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_prophet_series_to_string(s : TimeseriesanomalyprophetSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyprophetMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_prophet_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyprophetMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_prophet_matrix_identity(n : Int) -> TimeseriesanomalyprophetMatrix {
  let m = timeseries_anomaly_prophet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_prophet_matrix_get(m : TimeseriesanomalyprophetMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_prophet_matrix_transpose(m : TimeseriesanomalyprophetMatrix) -> TimeseriesanomalyprophetMatrix {
  let result = timeseries_anomaly_prophet_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_prophet_matrix_add(a : TimeseriesanomalyprophetMatrix, b : TimeseriesanomalyprophetMatrix) -> TimeseriesanomalyprophetMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_prophet_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_prophet_matrix_scale(m : TimeseriesanomalyprophetMatrix, s : Double) -> TimeseriesanomalyprophetMatrix {
  let result = timeseries_anomaly_prophet_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_prophet_matrix_multiply(a : TimeseriesanomalyprophetMatrix, b : TimeseriesanomalyprophetMatrix) -> TimeseriesanomalyprophetMatrix {
  if a.cols != b.rows { return timeseries_anomaly_prophet_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_prophet_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_prophet_matrix_trace(m : TimeseriesanomalyprophetMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_prophet_matrix_det(m : TimeseriesanomalyprophetMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_prophet_matrix_norm(m : TimeseriesanomalyprophetMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_anomaly_prophet_matrix_to_string(m : TimeseriesanomalyprophetMatrix) -> String {
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

pub(all) struct TimeseriesanomalyprophetVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_prophet_make_vector(comps : Array[Double]) -> TimeseriesanomalyprophetVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_prophet_vector_zero(dim : Int) -> TimeseriesanomalyprophetVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_prophet_vector_add(a : TimeseriesanomalyprophetVector, b : TimeseriesanomalyprophetVector) -> TimeseriesanomalyprophetVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_prophet_vector_sub(a : TimeseriesanomalyprophetVector, b : TimeseriesanomalyprophetVector) -> TimeseriesanomalyprophetVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_prophet_vector_scale(v : TimeseriesanomalyprophetVector, s : Double) -> TimeseriesanomalyprophetVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_prophet_vector_dot(a : TimeseriesanomalyprophetVector, b : TimeseriesanomalyprophetVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_prophet_vector_norm(v : TimeseriesanomalyprophetVector) -> Double { @_common.sqrt(timeseries_anomaly_prophet_vector_dot(v, v)) }

pub fn timeseries_anomaly_prophet_vector_normalize(v : TimeseriesanomalyprophetVector) -> TimeseriesanomalyprophetVector {
  let n = timeseries_anomaly_prophet_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_prophet_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_prophet_vector_dist(a : TimeseriesanomalyprophetVector, b : TimeseriesanomalyprophetVector) -> Double {
  timeseries_anomaly_prophet_vector_norm(timeseries_anomaly_prophet_vector_sub(a, b))
}

pub fn timeseries_anomaly_prophet_vector_to_string(v : TimeseriesanomalyprophetVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_prophet_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_prophet_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_prophet_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_prophet_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_prophet_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_prophet_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_prophet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_prophet_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_prophet_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_prophet_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_prophet_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_prophet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_prophet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_prophet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_prophet_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_prophet_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_prophet_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_prophet_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_prophet_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_prophet_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_prophet_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_prophet_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_prophet_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_prophet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_prophet_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_prophet_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_prophet_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_prophet_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_prophet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyprophetFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_frame_make(size : Int) -> TimeseriesanomalyprophetFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_frame_len(s : TimeseriesanomalyprophetFrame) -> Int { s.size }

pub fn timeseries_anomaly_prophet_frame_get(s : TimeseriesanomalyprophetFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_frame_set(s : TimeseriesanomalyprophetFrame, i : Int, v : Double) -> TimeseriesanomalyprophetFrame {
  let result = timeseries_anomaly_prophet_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_frame_sum(s : TimeseriesanomalyprophetFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_frame_mean(s : TimeseriesanomalyprophetFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_frame_scale(s : TimeseriesanomalyprophetFrame, f : Double) -> TimeseriesanomalyprophetFrame {
  let result = timeseries_anomaly_prophet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_frame_add(a : TimeseriesanomalyprophetFrame, b : TimeseriesanomalyprophetFrame) -> TimeseriesanomalyprophetFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_frame_copy(s : TimeseriesanomalyprophetFrame) -> TimeseriesanomalyprophetFrame {
  let result = timeseries_anomaly_prophet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_frame_fill(s : TimeseriesanomalyprophetFrame, v : Double) -> TimeseriesanomalyprophetFrame {
  let result = timeseries_anomaly_prophet_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_frame_min(s : TimeseriesanomalyprophetFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_frame_max(s : TimeseriesanomalyprophetFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_frame_to_string(s : TimeseriesanomalyprophetFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_table_make(size : Int) -> TimeseriesanomalyprophetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_table_len(s : TimeseriesanomalyprophetTable) -> Int { s.size }

pub fn timeseries_anomaly_prophet_table_get(s : TimeseriesanomalyprophetTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_table_set(s : TimeseriesanomalyprophetTable, i : Int, v : Double) -> TimeseriesanomalyprophetTable {
  let result = timeseries_anomaly_prophet_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_table_sum(s : TimeseriesanomalyprophetTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_table_mean(s : TimeseriesanomalyprophetTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_table_scale(s : TimeseriesanomalyprophetTable, f : Double) -> TimeseriesanomalyprophetTable {
  let result = timeseries_anomaly_prophet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_table_add(a : TimeseriesanomalyprophetTable, b : TimeseriesanomalyprophetTable) -> TimeseriesanomalyprophetTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_table_copy(s : TimeseriesanomalyprophetTable) -> TimeseriesanomalyprophetTable {
  let result = timeseries_anomaly_prophet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_table_fill(s : TimeseriesanomalyprophetTable, v : Double) -> TimeseriesanomalyprophetTable {
  let result = timeseries_anomaly_prophet_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_table_min(s : TimeseriesanomalyprophetTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_table_max(s : TimeseriesanomalyprophetTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_table_to_string(s : TimeseriesanomalyprophetTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_graphn_make(size : Int) -> TimeseriesanomalyprophetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_graphn_len(s : TimeseriesanomalyprophetGraphN) -> Int { s.size }

pub fn timeseries_anomaly_prophet_graphn_get(s : TimeseriesanomalyprophetGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_graphn_set(s : TimeseriesanomalyprophetGraphN, i : Int, v : Double) -> TimeseriesanomalyprophetGraphN {
  let result = timeseries_anomaly_prophet_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_graphn_sum(s : TimeseriesanomalyprophetGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_graphn_mean(s : TimeseriesanomalyprophetGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_graphn_scale(s : TimeseriesanomalyprophetGraphN, f : Double) -> TimeseriesanomalyprophetGraphN {
  let result = timeseries_anomaly_prophet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_graphn_add(a : TimeseriesanomalyprophetGraphN, b : TimeseriesanomalyprophetGraphN) -> TimeseriesanomalyprophetGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_graphn_copy(s : TimeseriesanomalyprophetGraphN) -> TimeseriesanomalyprophetGraphN {
  let result = timeseries_anomaly_prophet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_graphn_fill(s : TimeseriesanomalyprophetGraphN, v : Double) -> TimeseriesanomalyprophetGraphN {
  let result = timeseries_anomaly_prophet_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_graphn_min(s : TimeseriesanomalyprophetGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_graphn_max(s : TimeseriesanomalyprophetGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_graphn_to_string(s : TimeseriesanomalyprophetGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_node_make(size : Int) -> TimeseriesanomalyprophetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_node_len(s : TimeseriesanomalyprophetNode) -> Int { s.size }

pub fn timeseries_anomaly_prophet_node_get(s : TimeseriesanomalyprophetNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_node_set(s : TimeseriesanomalyprophetNode, i : Int, v : Double) -> TimeseriesanomalyprophetNode {
  let result = timeseries_anomaly_prophet_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_node_sum(s : TimeseriesanomalyprophetNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_node_mean(s : TimeseriesanomalyprophetNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_node_scale(s : TimeseriesanomalyprophetNode, f : Double) -> TimeseriesanomalyprophetNode {
  let result = timeseries_anomaly_prophet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_node_add(a : TimeseriesanomalyprophetNode, b : TimeseriesanomalyprophetNode) -> TimeseriesanomalyprophetNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_node_copy(s : TimeseriesanomalyprophetNode) -> TimeseriesanomalyprophetNode {
  let result = timeseries_anomaly_prophet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_node_fill(s : TimeseriesanomalyprophetNode, v : Double) -> TimeseriesanomalyprophetNode {
  let result = timeseries_anomaly_prophet_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_node_min(s : TimeseriesanomalyprophetNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_node_max(s : TimeseriesanomalyprophetNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_node_to_string(s : TimeseriesanomalyprophetNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_edge_make(size : Int) -> TimeseriesanomalyprophetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_edge_len(s : TimeseriesanomalyprophetEdge) -> Int { s.size }

pub fn timeseries_anomaly_prophet_edge_get(s : TimeseriesanomalyprophetEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_edge_set(s : TimeseriesanomalyprophetEdge, i : Int, v : Double) -> TimeseriesanomalyprophetEdge {
  let result = timeseries_anomaly_prophet_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_edge_sum(s : TimeseriesanomalyprophetEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_edge_mean(s : TimeseriesanomalyprophetEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_edge_scale(s : TimeseriesanomalyprophetEdge, f : Double) -> TimeseriesanomalyprophetEdge {
  let result = timeseries_anomaly_prophet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_edge_add(a : TimeseriesanomalyprophetEdge, b : TimeseriesanomalyprophetEdge) -> TimeseriesanomalyprophetEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_edge_copy(s : TimeseriesanomalyprophetEdge) -> TimeseriesanomalyprophetEdge {
  let result = timeseries_anomaly_prophet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_edge_fill(s : TimeseriesanomalyprophetEdge, v : Double) -> TimeseriesanomalyprophetEdge {
  let result = timeseries_anomaly_prophet_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_edge_min(s : TimeseriesanomalyprophetEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_edge_max(s : TimeseriesanomalyprophetEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_edge_to_string(s : TimeseriesanomalyprophetEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_path_make(size : Int) -> TimeseriesanomalyprophetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_path_len(s : TimeseriesanomalyprophetPath) -> Int { s.size }

pub fn timeseries_anomaly_prophet_path_get(s : TimeseriesanomalyprophetPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_path_set(s : TimeseriesanomalyprophetPath, i : Int, v : Double) -> TimeseriesanomalyprophetPath {
  let result = timeseries_anomaly_prophet_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_path_sum(s : TimeseriesanomalyprophetPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_path_mean(s : TimeseriesanomalyprophetPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_path_scale(s : TimeseriesanomalyprophetPath, f : Double) -> TimeseriesanomalyprophetPath {
  let result = timeseries_anomaly_prophet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_path_add(a : TimeseriesanomalyprophetPath, b : TimeseriesanomalyprophetPath) -> TimeseriesanomalyprophetPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_path_copy(s : TimeseriesanomalyprophetPath) -> TimeseriesanomalyprophetPath {
  let result = timeseries_anomaly_prophet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_path_fill(s : TimeseriesanomalyprophetPath, v : Double) -> TimeseriesanomalyprophetPath {
  let result = timeseries_anomaly_prophet_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_path_min(s : TimeseriesanomalyprophetPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_path_max(s : TimeseriesanomalyprophetPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_path_to_string(s : TimeseriesanomalyprophetPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_cluster_make(size : Int) -> TimeseriesanomalyprophetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_cluster_len(s : TimeseriesanomalyprophetCluster) -> Int { s.size }

pub fn timeseries_anomaly_prophet_cluster_get(s : TimeseriesanomalyprophetCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_cluster_set(s : TimeseriesanomalyprophetCluster, i : Int, v : Double) -> TimeseriesanomalyprophetCluster {
  let result = timeseries_anomaly_prophet_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_cluster_sum(s : TimeseriesanomalyprophetCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_cluster_mean(s : TimeseriesanomalyprophetCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_cluster_scale(s : TimeseriesanomalyprophetCluster, f : Double) -> TimeseriesanomalyprophetCluster {
  let result = timeseries_anomaly_prophet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_cluster_add(a : TimeseriesanomalyprophetCluster, b : TimeseriesanomalyprophetCluster) -> TimeseriesanomalyprophetCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_cluster_copy(s : TimeseriesanomalyprophetCluster) -> TimeseriesanomalyprophetCluster {
  let result = timeseries_anomaly_prophet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_cluster_fill(s : TimeseriesanomalyprophetCluster, v : Double) -> TimeseriesanomalyprophetCluster {
  let result = timeseries_anomaly_prophet_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_cluster_min(s : TimeseriesanomalyprophetCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_cluster_max(s : TimeseriesanomalyprophetCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_cluster_to_string(s : TimeseriesanomalyprophetCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_model_make(size : Int) -> TimeseriesanomalyprophetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_model_len(s : TimeseriesanomalyprophetModel) -> Int { s.size }

pub fn timeseries_anomaly_prophet_model_get(s : TimeseriesanomalyprophetModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_model_set(s : TimeseriesanomalyprophetModel, i : Int, v : Double) -> TimeseriesanomalyprophetModel {
  let result = timeseries_anomaly_prophet_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_model_sum(s : TimeseriesanomalyprophetModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_model_mean(s : TimeseriesanomalyprophetModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_model_scale(s : TimeseriesanomalyprophetModel, f : Double) -> TimeseriesanomalyprophetModel {
  let result = timeseries_anomaly_prophet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_model_add(a : TimeseriesanomalyprophetModel, b : TimeseriesanomalyprophetModel) -> TimeseriesanomalyprophetModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_model_copy(s : TimeseriesanomalyprophetModel) -> TimeseriesanomalyprophetModel {
  let result = timeseries_anomaly_prophet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_model_fill(s : TimeseriesanomalyprophetModel, v : Double) -> TimeseriesanomalyprophetModel {
  let result = timeseries_anomaly_prophet_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_model_min(s : TimeseriesanomalyprophetModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_model_max(s : TimeseriesanomalyprophetModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_model_to_string(s : TimeseriesanomalyprophetModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_layer_make(size : Int) -> TimeseriesanomalyprophetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_layer_len(s : TimeseriesanomalyprophetLayer) -> Int { s.size }

pub fn timeseries_anomaly_prophet_layer_get(s : TimeseriesanomalyprophetLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_layer_set(s : TimeseriesanomalyprophetLayer, i : Int, v : Double) -> TimeseriesanomalyprophetLayer {
  let result = timeseries_anomaly_prophet_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_layer_sum(s : TimeseriesanomalyprophetLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_layer_mean(s : TimeseriesanomalyprophetLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_layer_scale(s : TimeseriesanomalyprophetLayer, f : Double) -> TimeseriesanomalyprophetLayer {
  let result = timeseries_anomaly_prophet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_layer_add(a : TimeseriesanomalyprophetLayer, b : TimeseriesanomalyprophetLayer) -> TimeseriesanomalyprophetLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_layer_copy(s : TimeseriesanomalyprophetLayer) -> TimeseriesanomalyprophetLayer {
  let result = timeseries_anomaly_prophet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_layer_fill(s : TimeseriesanomalyprophetLayer, v : Double) -> TimeseriesanomalyprophetLayer {
  let result = timeseries_anomaly_prophet_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_layer_min(s : TimeseriesanomalyprophetLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_layer_max(s : TimeseriesanomalyprophetLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_layer_to_string(s : TimeseriesanomalyprophetLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_buffer_make(size : Int) -> TimeseriesanomalyprophetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_buffer_len(s : TimeseriesanomalyprophetBuffer) -> Int { s.size }

pub fn timeseries_anomaly_prophet_buffer_get(s : TimeseriesanomalyprophetBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_buffer_set(s : TimeseriesanomalyprophetBuffer, i : Int, v : Double) -> TimeseriesanomalyprophetBuffer {
  let result = timeseries_anomaly_prophet_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_buffer_sum(s : TimeseriesanomalyprophetBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_buffer_mean(s : TimeseriesanomalyprophetBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_buffer_scale(s : TimeseriesanomalyprophetBuffer, f : Double) -> TimeseriesanomalyprophetBuffer {
  let result = timeseries_anomaly_prophet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_buffer_add(a : TimeseriesanomalyprophetBuffer, b : TimeseriesanomalyprophetBuffer) -> TimeseriesanomalyprophetBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_buffer_copy(s : TimeseriesanomalyprophetBuffer) -> TimeseriesanomalyprophetBuffer {
  let result = timeseries_anomaly_prophet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_buffer_fill(s : TimeseriesanomalyprophetBuffer, v : Double) -> TimeseriesanomalyprophetBuffer {
  let result = timeseries_anomaly_prophet_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_buffer_min(s : TimeseriesanomalyprophetBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_buffer_max(s : TimeseriesanomalyprophetBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_buffer_to_string(s : TimeseriesanomalyprophetBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_cursor_make(size : Int) -> TimeseriesanomalyprophetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_cursor_len(s : TimeseriesanomalyprophetCursor) -> Int { s.size }

pub fn timeseries_anomaly_prophet_cursor_get(s : TimeseriesanomalyprophetCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_cursor_set(s : TimeseriesanomalyprophetCursor, i : Int, v : Double) -> TimeseriesanomalyprophetCursor {
  let result = timeseries_anomaly_prophet_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_cursor_sum(s : TimeseriesanomalyprophetCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_cursor_mean(s : TimeseriesanomalyprophetCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_cursor_scale(s : TimeseriesanomalyprophetCursor, f : Double) -> TimeseriesanomalyprophetCursor {
  let result = timeseries_anomaly_prophet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_cursor_add(a : TimeseriesanomalyprophetCursor, b : TimeseriesanomalyprophetCursor) -> TimeseriesanomalyprophetCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_cursor_copy(s : TimeseriesanomalyprophetCursor) -> TimeseriesanomalyprophetCursor {
  let result = timeseries_anomaly_prophet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_cursor_fill(s : TimeseriesanomalyprophetCursor, v : Double) -> TimeseriesanomalyprophetCursor {
  let result = timeseries_anomaly_prophet_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_cursor_min(s : TimeseriesanomalyprophetCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_cursor_max(s : TimeseriesanomalyprophetCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_cursor_to_string(s : TimeseriesanomalyprophetCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_view_make(size : Int) -> TimeseriesanomalyprophetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_view_len(s : TimeseriesanomalyprophetView) -> Int { s.size }

pub fn timeseries_anomaly_prophet_view_get(s : TimeseriesanomalyprophetView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_view_set(s : TimeseriesanomalyprophetView, i : Int, v : Double) -> TimeseriesanomalyprophetView {
  let result = timeseries_anomaly_prophet_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_view_sum(s : TimeseriesanomalyprophetView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_view_mean(s : TimeseriesanomalyprophetView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_view_scale(s : TimeseriesanomalyprophetView, f : Double) -> TimeseriesanomalyprophetView {
  let result = timeseries_anomaly_prophet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_view_add(a : TimeseriesanomalyprophetView, b : TimeseriesanomalyprophetView) -> TimeseriesanomalyprophetView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_view_copy(s : TimeseriesanomalyprophetView) -> TimeseriesanomalyprophetView {
  let result = timeseries_anomaly_prophet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_view_fill(s : TimeseriesanomalyprophetView, v : Double) -> TimeseriesanomalyprophetView {
  let result = timeseries_anomaly_prophet_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_view_min(s : TimeseriesanomalyprophetView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_view_max(s : TimeseriesanomalyprophetView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_view_to_string(s : TimeseriesanomalyprophetView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_range_make(size : Int) -> TimeseriesanomalyprophetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_range_len(s : TimeseriesanomalyprophetRange) -> Int { s.size }

pub fn timeseries_anomaly_prophet_range_get(s : TimeseriesanomalyprophetRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_range_set(s : TimeseriesanomalyprophetRange, i : Int, v : Double) -> TimeseriesanomalyprophetRange {
  let result = timeseries_anomaly_prophet_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_range_sum(s : TimeseriesanomalyprophetRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_range_mean(s : TimeseriesanomalyprophetRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_range_scale(s : TimeseriesanomalyprophetRange, f : Double) -> TimeseriesanomalyprophetRange {
  let result = timeseries_anomaly_prophet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_range_add(a : TimeseriesanomalyprophetRange, b : TimeseriesanomalyprophetRange) -> TimeseriesanomalyprophetRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_range_copy(s : TimeseriesanomalyprophetRange) -> TimeseriesanomalyprophetRange {
  let result = timeseries_anomaly_prophet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_range_fill(s : TimeseriesanomalyprophetRange, v : Double) -> TimeseriesanomalyprophetRange {
  let result = timeseries_anomaly_prophet_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_range_min(s : TimeseriesanomalyprophetRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_range_max(s : TimeseriesanomalyprophetRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_range_to_string(s : TimeseriesanomalyprophetRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_slice_make(size : Int) -> TimeseriesanomalyprophetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_slice_len(s : TimeseriesanomalyprophetSlice) -> Int { s.size }

pub fn timeseries_anomaly_prophet_slice_get(s : TimeseriesanomalyprophetSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_slice_set(s : TimeseriesanomalyprophetSlice, i : Int, v : Double) -> TimeseriesanomalyprophetSlice {
  let result = timeseries_anomaly_prophet_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_slice_sum(s : TimeseriesanomalyprophetSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_slice_mean(s : TimeseriesanomalyprophetSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_slice_scale(s : TimeseriesanomalyprophetSlice, f : Double) -> TimeseriesanomalyprophetSlice {
  let result = timeseries_anomaly_prophet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_prophet_slice_add(a : TimeseriesanomalyprophetSlice, b : TimeseriesanomalyprophetSlice) -> TimeseriesanomalyprophetSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_prophet_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_slice_copy(s : TimeseriesanomalyprophetSlice) -> TimeseriesanomalyprophetSlice {
  let result = timeseries_anomaly_prophet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_prophet_slice_fill(s : TimeseriesanomalyprophetSlice, v : Double) -> TimeseriesanomalyprophetSlice {
  let result = timeseries_anomaly_prophet_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_prophet_slice_min(s : TimeseriesanomalyprophetSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_slice_max(s : TimeseriesanomalyprophetSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_slice_to_string(s : TimeseriesanomalyprophetSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

