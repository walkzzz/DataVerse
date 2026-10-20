///===
/// extcore/timeseries_anomaly_zscore

pub(all) struct TimeseriesanomalyzscorePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_zscore_make_point(x : Double, y : Double) -> TimeseriesanomalyzscorePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_zscore_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyzscorePoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_zscore_point_x(pt : TimeseriesanomalyzscorePoint) -> Double { pt.x }

pub fn timeseries_anomaly_zscore_point_y(pt : TimeseriesanomalyzscorePoint) -> Double { pt.y }

pub fn timeseries_anomaly_zscore_point_z(pt : TimeseriesanomalyzscorePoint) -> Double { pt.z }

pub fn timeseries_anomaly_zscore_point_label(pt : TimeseriesanomalyzscorePoint) -> Int { pt.label }

pub fn timeseries_anomaly_zscore_point_dist(a : TimeseriesanomalyzscorePoint, b : TimeseriesanomalyzscorePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_zscore_point_add(a : TimeseriesanomalyzscorePoint, b : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_zscore_point_sub(a : TimeseriesanomalyzscorePoint, b : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_zscore_point_scale(pt : TimeseriesanomalyzscorePoint, s : Double) -> TimeseriesanomalyzscorePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_zscore_point_dot(a : TimeseriesanomalyzscorePoint, b : TimeseriesanomalyzscorePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_zscore_point_cross(a : TimeseriesanomalyzscorePoint, b : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_zscore_point_norm(pt : TimeseriesanomalyzscorePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_zscore_point_normalize(pt : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  let n = timeseries_anomaly_zscore_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_zscore_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_zscore_point_negate(pt : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_zscore_point_mid(a : TimeseriesanomalyzscorePoint, b : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_zscore_point_lerp(a : TimeseriesanomalyzscorePoint, b : TimeseriesanomalyzscorePoint, t : Double) -> TimeseriesanomalyzscorePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_zscore_point_to_string(pt : TimeseriesanomalyzscorePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_zscore_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyzscoreSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_zscore_series_len(s : TimeseriesanomalyzscoreSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_zscore_series_sum(s : TimeseriesanomalyzscoreSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_anomaly_zscore_series_mean(s : TimeseriesanomalyzscoreSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_anomaly_zscore_series_min(s : TimeseriesanomalyzscoreSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_anomaly_zscore_series_max(s : TimeseriesanomalyzscoreSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_anomaly_zscore_series_range(s : TimeseriesanomalyzscoreSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_anomaly_zscore_series_var(s : TimeseriesanomalyzscoreSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_anomaly_zscore_series_std(s : TimeseriesanomalyzscoreSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_anomaly_zscore_series_median(s : TimeseriesanomalyzscoreSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_anomaly_zscore_series_scale(s : TimeseriesanomalyzscoreSeries, f : Double) -> TimeseriesanomalyzscoreSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_zscore_series_add(a : TimeseriesanomalyzscoreSeries, b : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_zscore_series_sub(a : TimeseriesanomalyzscoreSeries, b : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_zscore_series_normalize(s : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  let mn = timeseries_anomaly_zscore_series_min(s)
  let mx = timeseries_anomaly_zscore_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_zscore_series_cumsum(s : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_zscore_series_to_string(s : TimeseriesanomalyzscoreSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyzscoreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_zscore_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyzscoreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_zscore_matrix_identity(n : Int) -> TimeseriesanomalyzscoreMatrix {
  let m = timeseries_anomaly_zscore_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_zscore_matrix_get(m : TimeseriesanomalyzscoreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_zscore_matrix_transpose(m : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  let result = timeseries_anomaly_zscore_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_zscore_matrix_add(a : TimeseriesanomalyzscoreMatrix, b : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_zscore_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_zscore_matrix_scale(m : TimeseriesanomalyzscoreMatrix, s : Double) -> TimeseriesanomalyzscoreMatrix {
  let result = timeseries_anomaly_zscore_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_zscore_matrix_multiply(a : TimeseriesanomalyzscoreMatrix, b : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  if a.cols != b.rows { return timeseries_anomaly_zscore_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_zscore_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_zscore_matrix_trace(m : TimeseriesanomalyzscoreMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_zscore_matrix_det(m : TimeseriesanomalyzscoreMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_zscore_matrix_norm(m : TimeseriesanomalyzscoreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_anomaly_zscore_matrix_to_string(m : TimeseriesanomalyzscoreMatrix) -> String {
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

pub(all) struct TimeseriesanomalyzscoreVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_zscore_make_vector(comps : Array[Double]) -> TimeseriesanomalyzscoreVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_zscore_vector_zero(dim : Int) -> TimeseriesanomalyzscoreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_zscore_vector_add(a : TimeseriesanomalyzscoreVector, b : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_zscore_vector_sub(a : TimeseriesanomalyzscoreVector, b : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_zscore_vector_scale(v : TimeseriesanomalyzscoreVector, s : Double) -> TimeseriesanomalyzscoreVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_zscore_vector_dot(a : TimeseriesanomalyzscoreVector, b : TimeseriesanomalyzscoreVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_zscore_vector_norm(v : TimeseriesanomalyzscoreVector) -> Double { @_common.sqrt(timeseries_anomaly_zscore_vector_dot(v, v)) }

pub fn timeseries_anomaly_zscore_vector_normalize(v : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = timeseries_anomaly_zscore_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_zscore_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_zscore_vector_dist(a : TimeseriesanomalyzscoreVector, b : TimeseriesanomalyzscoreVector) -> Double {
  timeseries_anomaly_zscore_vector_norm(timeseries_anomaly_zscore_vector_sub(a, b))
}

pub fn timeseries_anomaly_zscore_vector_to_string(v : TimeseriesanomalyzscoreVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_zscore_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_zscore_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_zscore_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_zscore_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_zscore_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_zscore_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_zscore_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_zscore_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_zscore_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_zscore_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_zscore_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_zscore_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_zscore_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_zscore_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_zscore_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_zscore_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_zscore_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_zscore_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_zscore_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_zscore_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_zscore_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_zscore_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_zscore_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_zscore_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_zscore_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_zscore_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_zscore_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_zscore_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_zscore_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyzscoreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_frame_make(size : Int) -> TimeseriesanomalyzscoreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_frame_len(s : TimeseriesanomalyzscoreFrame) -> Int { s.size }

pub fn timeseries_anomaly_zscore_frame_get(s : TimeseriesanomalyzscoreFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_frame_set(s : TimeseriesanomalyzscoreFrame, i : Int, v : Double) -> TimeseriesanomalyzscoreFrame {
  let result = timeseries_anomaly_zscore_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_frame_sum(s : TimeseriesanomalyzscoreFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_frame_mean(s : TimeseriesanomalyzscoreFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_frame_scale(s : TimeseriesanomalyzscoreFrame, f : Double) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_frame_add(a : TimeseriesanomalyzscoreFrame, b : TimeseriesanomalyzscoreFrame) -> TimeseriesanomalyzscoreFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_frame_copy(s : TimeseriesanomalyzscoreFrame) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_frame_fill(s : TimeseriesanomalyzscoreFrame, v : Double) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_frame_min(s : TimeseriesanomalyzscoreFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_frame_max(s : TimeseriesanomalyzscoreFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_frame_to_string(s : TimeseriesanomalyzscoreFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_table_make(size : Int) -> TimeseriesanomalyzscoreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_table_len(s : TimeseriesanomalyzscoreTable) -> Int { s.size }

pub fn timeseries_anomaly_zscore_table_get(s : TimeseriesanomalyzscoreTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_table_set(s : TimeseriesanomalyzscoreTable, i : Int, v : Double) -> TimeseriesanomalyzscoreTable {
  let result = timeseries_anomaly_zscore_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_table_sum(s : TimeseriesanomalyzscoreTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_table_mean(s : TimeseriesanomalyzscoreTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_table_scale(s : TimeseriesanomalyzscoreTable, f : Double) -> TimeseriesanomalyzscoreTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_table_add(a : TimeseriesanomalyzscoreTable, b : TimeseriesanomalyzscoreTable) -> TimeseriesanomalyzscoreTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_table_copy(s : TimeseriesanomalyzscoreTable) -> TimeseriesanomalyzscoreTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_table_fill(s : TimeseriesanomalyzscoreTable, v : Double) -> TimeseriesanomalyzscoreTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_table_min(s : TimeseriesanomalyzscoreTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_table_max(s : TimeseriesanomalyzscoreTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_table_to_string(s : TimeseriesanomalyzscoreTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_graphn_make(size : Int) -> TimeseriesanomalyzscoreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_graphn_len(s : TimeseriesanomalyzscoreGraphN) -> Int { s.size }

pub fn timeseries_anomaly_zscore_graphn_get(s : TimeseriesanomalyzscoreGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_graphn_set(s : TimeseriesanomalyzscoreGraphN, i : Int, v : Double) -> TimeseriesanomalyzscoreGraphN {
  let result = timeseries_anomaly_zscore_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_graphn_sum(s : TimeseriesanomalyzscoreGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_graphn_mean(s : TimeseriesanomalyzscoreGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_graphn_scale(s : TimeseriesanomalyzscoreGraphN, f : Double) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_graphn_add(a : TimeseriesanomalyzscoreGraphN, b : TimeseriesanomalyzscoreGraphN) -> TimeseriesanomalyzscoreGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_graphn_copy(s : TimeseriesanomalyzscoreGraphN) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_graphn_fill(s : TimeseriesanomalyzscoreGraphN, v : Double) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_graphn_min(s : TimeseriesanomalyzscoreGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_graphn_max(s : TimeseriesanomalyzscoreGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_graphn_to_string(s : TimeseriesanomalyzscoreGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_node_make(size : Int) -> TimeseriesanomalyzscoreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_node_len(s : TimeseriesanomalyzscoreNode) -> Int { s.size }

pub fn timeseries_anomaly_zscore_node_get(s : TimeseriesanomalyzscoreNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_node_set(s : TimeseriesanomalyzscoreNode, i : Int, v : Double) -> TimeseriesanomalyzscoreNode {
  let result = timeseries_anomaly_zscore_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_node_sum(s : TimeseriesanomalyzscoreNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_node_mean(s : TimeseriesanomalyzscoreNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_node_scale(s : TimeseriesanomalyzscoreNode, f : Double) -> TimeseriesanomalyzscoreNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_node_add(a : TimeseriesanomalyzscoreNode, b : TimeseriesanomalyzscoreNode) -> TimeseriesanomalyzscoreNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_node_copy(s : TimeseriesanomalyzscoreNode) -> TimeseriesanomalyzscoreNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_node_fill(s : TimeseriesanomalyzscoreNode, v : Double) -> TimeseriesanomalyzscoreNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_node_min(s : TimeseriesanomalyzscoreNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_node_max(s : TimeseriesanomalyzscoreNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_node_to_string(s : TimeseriesanomalyzscoreNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_edge_make(size : Int) -> TimeseriesanomalyzscoreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_edge_len(s : TimeseriesanomalyzscoreEdge) -> Int { s.size }

pub fn timeseries_anomaly_zscore_edge_get(s : TimeseriesanomalyzscoreEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_edge_set(s : TimeseriesanomalyzscoreEdge, i : Int, v : Double) -> TimeseriesanomalyzscoreEdge {
  let result = timeseries_anomaly_zscore_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_edge_sum(s : TimeseriesanomalyzscoreEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_edge_mean(s : TimeseriesanomalyzscoreEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_edge_scale(s : TimeseriesanomalyzscoreEdge, f : Double) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_edge_add(a : TimeseriesanomalyzscoreEdge, b : TimeseriesanomalyzscoreEdge) -> TimeseriesanomalyzscoreEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_edge_copy(s : TimeseriesanomalyzscoreEdge) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_edge_fill(s : TimeseriesanomalyzscoreEdge, v : Double) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_edge_min(s : TimeseriesanomalyzscoreEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_edge_max(s : TimeseriesanomalyzscoreEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_edge_to_string(s : TimeseriesanomalyzscoreEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscorePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_path_make(size : Int) -> TimeseriesanomalyzscorePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_path_len(s : TimeseriesanomalyzscorePath) -> Int { s.size }

pub fn timeseries_anomaly_zscore_path_get(s : TimeseriesanomalyzscorePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_path_set(s : TimeseriesanomalyzscorePath, i : Int, v : Double) -> TimeseriesanomalyzscorePath {
  let result = timeseries_anomaly_zscore_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_path_sum(s : TimeseriesanomalyzscorePath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_path_mean(s : TimeseriesanomalyzscorePath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_path_scale(s : TimeseriesanomalyzscorePath, f : Double) -> TimeseriesanomalyzscorePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_path_add(a : TimeseriesanomalyzscorePath, b : TimeseriesanomalyzscorePath) -> TimeseriesanomalyzscorePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_path_copy(s : TimeseriesanomalyzscorePath) -> TimeseriesanomalyzscorePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_path_fill(s : TimeseriesanomalyzscorePath, v : Double) -> TimeseriesanomalyzscorePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_path_min(s : TimeseriesanomalyzscorePath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_path_max(s : TimeseriesanomalyzscorePath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_path_to_string(s : TimeseriesanomalyzscorePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_cluster_make(size : Int) -> TimeseriesanomalyzscoreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_cluster_len(s : TimeseriesanomalyzscoreCluster) -> Int { s.size }

pub fn timeseries_anomaly_zscore_cluster_get(s : TimeseriesanomalyzscoreCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_cluster_set(s : TimeseriesanomalyzscoreCluster, i : Int, v : Double) -> TimeseriesanomalyzscoreCluster {
  let result = timeseries_anomaly_zscore_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_cluster_sum(s : TimeseriesanomalyzscoreCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_cluster_mean(s : TimeseriesanomalyzscoreCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_cluster_scale(s : TimeseriesanomalyzscoreCluster, f : Double) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cluster_add(a : TimeseriesanomalyzscoreCluster, b : TimeseriesanomalyzscoreCluster) -> TimeseriesanomalyzscoreCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_cluster_copy(s : TimeseriesanomalyzscoreCluster) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cluster_fill(s : TimeseriesanomalyzscoreCluster, v : Double) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cluster_min(s : TimeseriesanomalyzscoreCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_cluster_max(s : TimeseriesanomalyzscoreCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_cluster_to_string(s : TimeseriesanomalyzscoreCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_model_make(size : Int) -> TimeseriesanomalyzscoreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_model_len(s : TimeseriesanomalyzscoreModel) -> Int { s.size }

pub fn timeseries_anomaly_zscore_model_get(s : TimeseriesanomalyzscoreModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_model_set(s : TimeseriesanomalyzscoreModel, i : Int, v : Double) -> TimeseriesanomalyzscoreModel {
  let result = timeseries_anomaly_zscore_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_model_sum(s : TimeseriesanomalyzscoreModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_model_mean(s : TimeseriesanomalyzscoreModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_model_scale(s : TimeseriesanomalyzscoreModel, f : Double) -> TimeseriesanomalyzscoreModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_model_add(a : TimeseriesanomalyzscoreModel, b : TimeseriesanomalyzscoreModel) -> TimeseriesanomalyzscoreModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_model_copy(s : TimeseriesanomalyzscoreModel) -> TimeseriesanomalyzscoreModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_model_fill(s : TimeseriesanomalyzscoreModel, v : Double) -> TimeseriesanomalyzscoreModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_model_min(s : TimeseriesanomalyzscoreModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_model_max(s : TimeseriesanomalyzscoreModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_model_to_string(s : TimeseriesanomalyzscoreModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_layer_make(size : Int) -> TimeseriesanomalyzscoreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_layer_len(s : TimeseriesanomalyzscoreLayer) -> Int { s.size }

pub fn timeseries_anomaly_zscore_layer_get(s : TimeseriesanomalyzscoreLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_layer_set(s : TimeseriesanomalyzscoreLayer, i : Int, v : Double) -> TimeseriesanomalyzscoreLayer {
  let result = timeseries_anomaly_zscore_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_layer_sum(s : TimeseriesanomalyzscoreLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_layer_mean(s : TimeseriesanomalyzscoreLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_layer_scale(s : TimeseriesanomalyzscoreLayer, f : Double) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_layer_add(a : TimeseriesanomalyzscoreLayer, b : TimeseriesanomalyzscoreLayer) -> TimeseriesanomalyzscoreLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_layer_copy(s : TimeseriesanomalyzscoreLayer) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_layer_fill(s : TimeseriesanomalyzscoreLayer, v : Double) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_layer_min(s : TimeseriesanomalyzscoreLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_layer_max(s : TimeseriesanomalyzscoreLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_layer_to_string(s : TimeseriesanomalyzscoreLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_buffer_make(size : Int) -> TimeseriesanomalyzscoreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_buffer_len(s : TimeseriesanomalyzscoreBuffer) -> Int { s.size }

pub fn timeseries_anomaly_zscore_buffer_get(s : TimeseriesanomalyzscoreBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_buffer_set(s : TimeseriesanomalyzscoreBuffer, i : Int, v : Double) -> TimeseriesanomalyzscoreBuffer {
  let result = timeseries_anomaly_zscore_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_buffer_sum(s : TimeseriesanomalyzscoreBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_buffer_mean(s : TimeseriesanomalyzscoreBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_buffer_scale(s : TimeseriesanomalyzscoreBuffer, f : Double) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_buffer_add(a : TimeseriesanomalyzscoreBuffer, b : TimeseriesanomalyzscoreBuffer) -> TimeseriesanomalyzscoreBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_buffer_copy(s : TimeseriesanomalyzscoreBuffer) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_buffer_fill(s : TimeseriesanomalyzscoreBuffer, v : Double) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_buffer_min(s : TimeseriesanomalyzscoreBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_buffer_max(s : TimeseriesanomalyzscoreBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_buffer_to_string(s : TimeseriesanomalyzscoreBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_cursor_make(size : Int) -> TimeseriesanomalyzscoreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_cursor_len(s : TimeseriesanomalyzscoreCursor) -> Int { s.size }

pub fn timeseries_anomaly_zscore_cursor_get(s : TimeseriesanomalyzscoreCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_cursor_set(s : TimeseriesanomalyzscoreCursor, i : Int, v : Double) -> TimeseriesanomalyzscoreCursor {
  let result = timeseries_anomaly_zscore_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_cursor_sum(s : TimeseriesanomalyzscoreCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_cursor_mean(s : TimeseriesanomalyzscoreCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_cursor_scale(s : TimeseriesanomalyzscoreCursor, f : Double) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cursor_add(a : TimeseriesanomalyzscoreCursor, b : TimeseriesanomalyzscoreCursor) -> TimeseriesanomalyzscoreCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_cursor_copy(s : TimeseriesanomalyzscoreCursor) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cursor_fill(s : TimeseriesanomalyzscoreCursor, v : Double) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cursor_min(s : TimeseriesanomalyzscoreCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_cursor_max(s : TimeseriesanomalyzscoreCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_cursor_to_string(s : TimeseriesanomalyzscoreCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_view_make(size : Int) -> TimeseriesanomalyzscoreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_view_len(s : TimeseriesanomalyzscoreView) -> Int { s.size }

pub fn timeseries_anomaly_zscore_view_get(s : TimeseriesanomalyzscoreView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_view_set(s : TimeseriesanomalyzscoreView, i : Int, v : Double) -> TimeseriesanomalyzscoreView {
  let result = timeseries_anomaly_zscore_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_view_sum(s : TimeseriesanomalyzscoreView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_view_mean(s : TimeseriesanomalyzscoreView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_view_scale(s : TimeseriesanomalyzscoreView, f : Double) -> TimeseriesanomalyzscoreView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_view_add(a : TimeseriesanomalyzscoreView, b : TimeseriesanomalyzscoreView) -> TimeseriesanomalyzscoreView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_view_copy(s : TimeseriesanomalyzscoreView) -> TimeseriesanomalyzscoreView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_view_fill(s : TimeseriesanomalyzscoreView, v : Double) -> TimeseriesanomalyzscoreView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_view_min(s : TimeseriesanomalyzscoreView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_view_max(s : TimeseriesanomalyzscoreView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_view_to_string(s : TimeseriesanomalyzscoreView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_range_make(size : Int) -> TimeseriesanomalyzscoreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_range_len(s : TimeseriesanomalyzscoreRange) -> Int { s.size }

pub fn timeseries_anomaly_zscore_range_get(s : TimeseriesanomalyzscoreRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_range_set(s : TimeseriesanomalyzscoreRange, i : Int, v : Double) -> TimeseriesanomalyzscoreRange {
  let result = timeseries_anomaly_zscore_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_range_sum(s : TimeseriesanomalyzscoreRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_range_mean(s : TimeseriesanomalyzscoreRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_range_scale(s : TimeseriesanomalyzscoreRange, f : Double) -> TimeseriesanomalyzscoreRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_range_add(a : TimeseriesanomalyzscoreRange, b : TimeseriesanomalyzscoreRange) -> TimeseriesanomalyzscoreRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_range_copy(s : TimeseriesanomalyzscoreRange) -> TimeseriesanomalyzscoreRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_range_fill(s : TimeseriesanomalyzscoreRange, v : Double) -> TimeseriesanomalyzscoreRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_range_min(s : TimeseriesanomalyzscoreRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_range_max(s : TimeseriesanomalyzscoreRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_range_to_string(s : TimeseriesanomalyzscoreRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_slice_make(size : Int) -> TimeseriesanomalyzscoreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_slice_len(s : TimeseriesanomalyzscoreSlice) -> Int { s.size }

pub fn timeseries_anomaly_zscore_slice_get(s : TimeseriesanomalyzscoreSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_slice_set(s : TimeseriesanomalyzscoreSlice, i : Int, v : Double) -> TimeseriesanomalyzscoreSlice {
  let result = timeseries_anomaly_zscore_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_zscore_slice_sum(s : TimeseriesanomalyzscoreSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_slice_mean(s : TimeseriesanomalyzscoreSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_slice_scale(s : TimeseriesanomalyzscoreSlice, f : Double) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_slice_add(a : TimeseriesanomalyzscoreSlice, b : TimeseriesanomalyzscoreSlice) -> TimeseriesanomalyzscoreSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_slice_copy(s : TimeseriesanomalyzscoreSlice) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_slice_fill(s : TimeseriesanomalyzscoreSlice, v : Double) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_slice_min(s : TimeseriesanomalyzscoreSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_slice_max(s : TimeseriesanomalyzscoreSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_slice_to_string(s : TimeseriesanomalyzscoreSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

