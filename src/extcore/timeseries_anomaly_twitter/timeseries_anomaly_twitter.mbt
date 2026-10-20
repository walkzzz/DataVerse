///===
/// extcore/timeseries_anomaly_twitter

pub(all) struct TimeseriesanomalytwitterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_twitter_make_point(x : Double, y : Double) -> TimeseriesanomalytwitterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_twitter_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalytwitterPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_twitter_point_x(pt : TimeseriesanomalytwitterPoint) -> Double { pt.x }

pub fn timeseries_anomaly_twitter_point_y(pt : TimeseriesanomalytwitterPoint) -> Double { pt.y }

pub fn timeseries_anomaly_twitter_point_z(pt : TimeseriesanomalytwitterPoint) -> Double { pt.z }

pub fn timeseries_anomaly_twitter_point_label(pt : TimeseriesanomalytwitterPoint) -> Int { pt.label }

pub fn timeseries_anomaly_twitter_point_dist(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_twitter_point_add(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_twitter_point_sub(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_twitter_point_scale(pt : TimeseriesanomalytwitterPoint, s : Double) -> TimeseriesanomalytwitterPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_twitter_point_dot(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_twitter_point_cross(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_twitter_point_norm(pt : TimeseriesanomalytwitterPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_twitter_point_normalize(pt : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  let n = timeseries_anomaly_twitter_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_twitter_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_twitter_point_negate(pt : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_twitter_point_mid(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint) -> TimeseriesanomalytwitterPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_twitter_point_lerp(a : TimeseriesanomalytwitterPoint, b : TimeseriesanomalytwitterPoint, t : Double) -> TimeseriesanomalytwitterPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_twitter_point_to_string(pt : TimeseriesanomalytwitterPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_twitter_make_series(vals : Array[Double], name : String) -> TimeseriesanomalytwitterSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_twitter_series_len(s : TimeseriesanomalytwitterSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_twitter_series_sum(s : TimeseriesanomalytwitterSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_anomaly_twitter_series_mean(s : TimeseriesanomalytwitterSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_anomaly_twitter_series_min(s : TimeseriesanomalytwitterSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_anomaly_twitter_series_max(s : TimeseriesanomalytwitterSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_anomaly_twitter_series_range(s : TimeseriesanomalytwitterSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_anomaly_twitter_series_var(s : TimeseriesanomalytwitterSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_anomaly_twitter_series_std(s : TimeseriesanomalytwitterSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_anomaly_twitter_series_median(s : TimeseriesanomalytwitterSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_anomaly_twitter_series_scale(s : TimeseriesanomalytwitterSeries, f : Double) -> TimeseriesanomalytwitterSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_twitter_series_add(a : TimeseriesanomalytwitterSeries, b : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_twitter_series_sub(a : TimeseriesanomalytwitterSeries, b : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_twitter_series_normalize(s : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  let mn = timeseries_anomaly_twitter_series_min(s)
  let mx = timeseries_anomaly_twitter_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_twitter_series_cumsum(s : TimeseriesanomalytwitterSeries) -> TimeseriesanomalytwitterSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_twitter_series_to_string(s : TimeseriesanomalytwitterSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalytwitterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_twitter_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalytwitterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_twitter_matrix_identity(n : Int) -> TimeseriesanomalytwitterMatrix {
  let m = timeseries_anomaly_twitter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_twitter_matrix_get(m : TimeseriesanomalytwitterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_twitter_matrix_transpose(m : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  let result = timeseries_anomaly_twitter_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_twitter_matrix_add(a : TimeseriesanomalytwitterMatrix, b : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_twitter_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_twitter_matrix_scale(m : TimeseriesanomalytwitterMatrix, s : Double) -> TimeseriesanomalytwitterMatrix {
  let result = timeseries_anomaly_twitter_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_twitter_matrix_multiply(a : TimeseriesanomalytwitterMatrix, b : TimeseriesanomalytwitterMatrix) -> TimeseriesanomalytwitterMatrix {
  if a.cols != b.rows { return timeseries_anomaly_twitter_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_twitter_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_twitter_matrix_trace(m : TimeseriesanomalytwitterMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_twitter_matrix_det(m : TimeseriesanomalytwitterMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_twitter_matrix_norm(m : TimeseriesanomalytwitterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_anomaly_twitter_matrix_to_string(m : TimeseriesanomalytwitterMatrix) -> String {
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

pub(all) struct TimeseriesanomalytwitterVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_twitter_make_vector(comps : Array[Double]) -> TimeseriesanomalytwitterVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_twitter_vector_zero(dim : Int) -> TimeseriesanomalytwitterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_twitter_vector_add(a : TimeseriesanomalytwitterVector, b : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_twitter_vector_sub(a : TimeseriesanomalytwitterVector, b : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_twitter_vector_scale(v : TimeseriesanomalytwitterVector, s : Double) -> TimeseriesanomalytwitterVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_twitter_vector_dot(a : TimeseriesanomalytwitterVector, b : TimeseriesanomalytwitterVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_twitter_vector_norm(v : TimeseriesanomalytwitterVector) -> Double { @_common.sqrt(timeseries_anomaly_twitter_vector_dot(v, v)) }

pub fn timeseries_anomaly_twitter_vector_normalize(v : TimeseriesanomalytwitterVector) -> TimeseriesanomalytwitterVector {
  let n = timeseries_anomaly_twitter_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_twitter_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_twitter_vector_dist(a : TimeseriesanomalytwitterVector, b : TimeseriesanomalytwitterVector) -> Double {
  timeseries_anomaly_twitter_vector_norm(timeseries_anomaly_twitter_vector_sub(a, b))
}

pub fn timeseries_anomaly_twitter_vector_to_string(v : TimeseriesanomalytwitterVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_twitter_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_twitter_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_twitter_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_twitter_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_twitter_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_twitter_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_twitter_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_twitter_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_twitter_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_twitter_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_twitter_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_twitter_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_twitter_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_twitter_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_twitter_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_twitter_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_twitter_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_twitter_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_twitter_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_twitter_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_twitter_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_twitter_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_twitter_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_twitter_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_twitter_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_twitter_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_twitter_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_twitter_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_twitter_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalytwitterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_frame_make(size : Int) -> TimeseriesanomalytwitterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_frame_len(s : TimeseriesanomalytwitterFrame) -> Int { s.size }

pub fn timeseries_anomaly_twitter_frame_get(s : TimeseriesanomalytwitterFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_frame_set(s : TimeseriesanomalytwitterFrame, i : Int, v : Double) -> TimeseriesanomalytwitterFrame {
  let result = timeseries_anomaly_twitter_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_frame_sum(s : TimeseriesanomalytwitterFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_frame_mean(s : TimeseriesanomalytwitterFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_frame_scale(s : TimeseriesanomalytwitterFrame, f : Double) -> TimeseriesanomalytwitterFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_frame_add(a : TimeseriesanomalytwitterFrame, b : TimeseriesanomalytwitterFrame) -> TimeseriesanomalytwitterFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_frame_copy(s : TimeseriesanomalytwitterFrame) -> TimeseriesanomalytwitterFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_frame_fill(s : TimeseriesanomalytwitterFrame, v : Double) -> TimeseriesanomalytwitterFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_frame_min(s : TimeseriesanomalytwitterFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_frame_max(s : TimeseriesanomalytwitterFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_frame_to_string(s : TimeseriesanomalytwitterFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_table_make(size : Int) -> TimeseriesanomalytwitterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_table_len(s : TimeseriesanomalytwitterTable) -> Int { s.size }

pub fn timeseries_anomaly_twitter_table_get(s : TimeseriesanomalytwitterTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_table_set(s : TimeseriesanomalytwitterTable, i : Int, v : Double) -> TimeseriesanomalytwitterTable {
  let result = timeseries_anomaly_twitter_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_table_sum(s : TimeseriesanomalytwitterTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_table_mean(s : TimeseriesanomalytwitterTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_table_scale(s : TimeseriesanomalytwitterTable, f : Double) -> TimeseriesanomalytwitterTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_table_add(a : TimeseriesanomalytwitterTable, b : TimeseriesanomalytwitterTable) -> TimeseriesanomalytwitterTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_table_copy(s : TimeseriesanomalytwitterTable) -> TimeseriesanomalytwitterTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_table_fill(s : TimeseriesanomalytwitterTable, v : Double) -> TimeseriesanomalytwitterTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_table_min(s : TimeseriesanomalytwitterTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_table_max(s : TimeseriesanomalytwitterTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_table_to_string(s : TimeseriesanomalytwitterTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_graphn_make(size : Int) -> TimeseriesanomalytwitterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_graphn_len(s : TimeseriesanomalytwitterGraphN) -> Int { s.size }

pub fn timeseries_anomaly_twitter_graphn_get(s : TimeseriesanomalytwitterGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_graphn_set(s : TimeseriesanomalytwitterGraphN, i : Int, v : Double) -> TimeseriesanomalytwitterGraphN {
  let result = timeseries_anomaly_twitter_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_graphn_sum(s : TimeseriesanomalytwitterGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_graphn_mean(s : TimeseriesanomalytwitterGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_graphn_scale(s : TimeseriesanomalytwitterGraphN, f : Double) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_graphn_add(a : TimeseriesanomalytwitterGraphN, b : TimeseriesanomalytwitterGraphN) -> TimeseriesanomalytwitterGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_graphn_copy(s : TimeseriesanomalytwitterGraphN) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_graphn_fill(s : TimeseriesanomalytwitterGraphN, v : Double) -> TimeseriesanomalytwitterGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_graphn_min(s : TimeseriesanomalytwitterGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_graphn_max(s : TimeseriesanomalytwitterGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_graphn_to_string(s : TimeseriesanomalytwitterGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_node_make(size : Int) -> TimeseriesanomalytwitterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_node_len(s : TimeseriesanomalytwitterNode) -> Int { s.size }

pub fn timeseries_anomaly_twitter_node_get(s : TimeseriesanomalytwitterNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_node_set(s : TimeseriesanomalytwitterNode, i : Int, v : Double) -> TimeseriesanomalytwitterNode {
  let result = timeseries_anomaly_twitter_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_node_sum(s : TimeseriesanomalytwitterNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_node_mean(s : TimeseriesanomalytwitterNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_node_scale(s : TimeseriesanomalytwitterNode, f : Double) -> TimeseriesanomalytwitterNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_node_add(a : TimeseriesanomalytwitterNode, b : TimeseriesanomalytwitterNode) -> TimeseriesanomalytwitterNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_node_copy(s : TimeseriesanomalytwitterNode) -> TimeseriesanomalytwitterNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_node_fill(s : TimeseriesanomalytwitterNode, v : Double) -> TimeseriesanomalytwitterNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_node_min(s : TimeseriesanomalytwitterNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_node_max(s : TimeseriesanomalytwitterNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_node_to_string(s : TimeseriesanomalytwitterNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_edge_make(size : Int) -> TimeseriesanomalytwitterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_edge_len(s : TimeseriesanomalytwitterEdge) -> Int { s.size }

pub fn timeseries_anomaly_twitter_edge_get(s : TimeseriesanomalytwitterEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_edge_set(s : TimeseriesanomalytwitterEdge, i : Int, v : Double) -> TimeseriesanomalytwitterEdge {
  let result = timeseries_anomaly_twitter_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_edge_sum(s : TimeseriesanomalytwitterEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_edge_mean(s : TimeseriesanomalytwitterEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_edge_scale(s : TimeseriesanomalytwitterEdge, f : Double) -> TimeseriesanomalytwitterEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_edge_add(a : TimeseriesanomalytwitterEdge, b : TimeseriesanomalytwitterEdge) -> TimeseriesanomalytwitterEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_edge_copy(s : TimeseriesanomalytwitterEdge) -> TimeseriesanomalytwitterEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_edge_fill(s : TimeseriesanomalytwitterEdge, v : Double) -> TimeseriesanomalytwitterEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_edge_min(s : TimeseriesanomalytwitterEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_edge_max(s : TimeseriesanomalytwitterEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_edge_to_string(s : TimeseriesanomalytwitterEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_path_make(size : Int) -> TimeseriesanomalytwitterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_path_len(s : TimeseriesanomalytwitterPath) -> Int { s.size }

pub fn timeseries_anomaly_twitter_path_get(s : TimeseriesanomalytwitterPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_path_set(s : TimeseriesanomalytwitterPath, i : Int, v : Double) -> TimeseriesanomalytwitterPath {
  let result = timeseries_anomaly_twitter_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_path_sum(s : TimeseriesanomalytwitterPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_path_mean(s : TimeseriesanomalytwitterPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_path_scale(s : TimeseriesanomalytwitterPath, f : Double) -> TimeseriesanomalytwitterPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_path_add(a : TimeseriesanomalytwitterPath, b : TimeseriesanomalytwitterPath) -> TimeseriesanomalytwitterPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_path_copy(s : TimeseriesanomalytwitterPath) -> TimeseriesanomalytwitterPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_path_fill(s : TimeseriesanomalytwitterPath, v : Double) -> TimeseriesanomalytwitterPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_path_min(s : TimeseriesanomalytwitterPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_path_max(s : TimeseriesanomalytwitterPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_path_to_string(s : TimeseriesanomalytwitterPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_cluster_make(size : Int) -> TimeseriesanomalytwitterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_cluster_len(s : TimeseriesanomalytwitterCluster) -> Int { s.size }

pub fn timeseries_anomaly_twitter_cluster_get(s : TimeseriesanomalytwitterCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_cluster_set(s : TimeseriesanomalytwitterCluster, i : Int, v : Double) -> TimeseriesanomalytwitterCluster {
  let result = timeseries_anomaly_twitter_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_cluster_sum(s : TimeseriesanomalytwitterCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_cluster_mean(s : TimeseriesanomalytwitterCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_cluster_scale(s : TimeseriesanomalytwitterCluster, f : Double) -> TimeseriesanomalytwitterCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cluster_add(a : TimeseriesanomalytwitterCluster, b : TimeseriesanomalytwitterCluster) -> TimeseriesanomalytwitterCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_cluster_copy(s : TimeseriesanomalytwitterCluster) -> TimeseriesanomalytwitterCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cluster_fill(s : TimeseriesanomalytwitterCluster, v : Double) -> TimeseriesanomalytwitterCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cluster_min(s : TimeseriesanomalytwitterCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_cluster_max(s : TimeseriesanomalytwitterCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_cluster_to_string(s : TimeseriesanomalytwitterCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_model_make(size : Int) -> TimeseriesanomalytwitterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_model_len(s : TimeseriesanomalytwitterModel) -> Int { s.size }

pub fn timeseries_anomaly_twitter_model_get(s : TimeseriesanomalytwitterModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_model_set(s : TimeseriesanomalytwitterModel, i : Int, v : Double) -> TimeseriesanomalytwitterModel {
  let result = timeseries_anomaly_twitter_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_model_sum(s : TimeseriesanomalytwitterModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_model_mean(s : TimeseriesanomalytwitterModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_model_scale(s : TimeseriesanomalytwitterModel, f : Double) -> TimeseriesanomalytwitterModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_model_add(a : TimeseriesanomalytwitterModel, b : TimeseriesanomalytwitterModel) -> TimeseriesanomalytwitterModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_model_copy(s : TimeseriesanomalytwitterModel) -> TimeseriesanomalytwitterModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_model_fill(s : TimeseriesanomalytwitterModel, v : Double) -> TimeseriesanomalytwitterModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_model_min(s : TimeseriesanomalytwitterModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_model_max(s : TimeseriesanomalytwitterModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_model_to_string(s : TimeseriesanomalytwitterModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_layer_make(size : Int) -> TimeseriesanomalytwitterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_layer_len(s : TimeseriesanomalytwitterLayer) -> Int { s.size }

pub fn timeseries_anomaly_twitter_layer_get(s : TimeseriesanomalytwitterLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_layer_set(s : TimeseriesanomalytwitterLayer, i : Int, v : Double) -> TimeseriesanomalytwitterLayer {
  let result = timeseries_anomaly_twitter_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_layer_sum(s : TimeseriesanomalytwitterLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_layer_mean(s : TimeseriesanomalytwitterLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_layer_scale(s : TimeseriesanomalytwitterLayer, f : Double) -> TimeseriesanomalytwitterLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_layer_add(a : TimeseriesanomalytwitterLayer, b : TimeseriesanomalytwitterLayer) -> TimeseriesanomalytwitterLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_layer_copy(s : TimeseriesanomalytwitterLayer) -> TimeseriesanomalytwitterLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_layer_fill(s : TimeseriesanomalytwitterLayer, v : Double) -> TimeseriesanomalytwitterLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_layer_min(s : TimeseriesanomalytwitterLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_layer_max(s : TimeseriesanomalytwitterLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_layer_to_string(s : TimeseriesanomalytwitterLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_buffer_make(size : Int) -> TimeseriesanomalytwitterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_buffer_len(s : TimeseriesanomalytwitterBuffer) -> Int { s.size }

pub fn timeseries_anomaly_twitter_buffer_get(s : TimeseriesanomalytwitterBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_buffer_set(s : TimeseriesanomalytwitterBuffer, i : Int, v : Double) -> TimeseriesanomalytwitterBuffer {
  let result = timeseries_anomaly_twitter_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_buffer_sum(s : TimeseriesanomalytwitterBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_buffer_mean(s : TimeseriesanomalytwitterBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_buffer_scale(s : TimeseriesanomalytwitterBuffer, f : Double) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_buffer_add(a : TimeseriesanomalytwitterBuffer, b : TimeseriesanomalytwitterBuffer) -> TimeseriesanomalytwitterBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_buffer_copy(s : TimeseriesanomalytwitterBuffer) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_buffer_fill(s : TimeseriesanomalytwitterBuffer, v : Double) -> TimeseriesanomalytwitterBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_buffer_min(s : TimeseriesanomalytwitterBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_buffer_max(s : TimeseriesanomalytwitterBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_buffer_to_string(s : TimeseriesanomalytwitterBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_cursor_make(size : Int) -> TimeseriesanomalytwitterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_cursor_len(s : TimeseriesanomalytwitterCursor) -> Int { s.size }

pub fn timeseries_anomaly_twitter_cursor_get(s : TimeseriesanomalytwitterCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_cursor_set(s : TimeseriesanomalytwitterCursor, i : Int, v : Double) -> TimeseriesanomalytwitterCursor {
  let result = timeseries_anomaly_twitter_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_cursor_sum(s : TimeseriesanomalytwitterCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_cursor_mean(s : TimeseriesanomalytwitterCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_cursor_scale(s : TimeseriesanomalytwitterCursor, f : Double) -> TimeseriesanomalytwitterCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cursor_add(a : TimeseriesanomalytwitterCursor, b : TimeseriesanomalytwitterCursor) -> TimeseriesanomalytwitterCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_cursor_copy(s : TimeseriesanomalytwitterCursor) -> TimeseriesanomalytwitterCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cursor_fill(s : TimeseriesanomalytwitterCursor, v : Double) -> TimeseriesanomalytwitterCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_cursor_min(s : TimeseriesanomalytwitterCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_cursor_max(s : TimeseriesanomalytwitterCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_cursor_to_string(s : TimeseriesanomalytwitterCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_view_make(size : Int) -> TimeseriesanomalytwitterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_view_len(s : TimeseriesanomalytwitterView) -> Int { s.size }

pub fn timeseries_anomaly_twitter_view_get(s : TimeseriesanomalytwitterView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_view_set(s : TimeseriesanomalytwitterView, i : Int, v : Double) -> TimeseriesanomalytwitterView {
  let result = timeseries_anomaly_twitter_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_view_sum(s : TimeseriesanomalytwitterView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_view_mean(s : TimeseriesanomalytwitterView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_view_scale(s : TimeseriesanomalytwitterView, f : Double) -> TimeseriesanomalytwitterView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_view_add(a : TimeseriesanomalytwitterView, b : TimeseriesanomalytwitterView) -> TimeseriesanomalytwitterView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_view_copy(s : TimeseriesanomalytwitterView) -> TimeseriesanomalytwitterView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_view_fill(s : TimeseriesanomalytwitterView, v : Double) -> TimeseriesanomalytwitterView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_view_min(s : TimeseriesanomalytwitterView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_view_max(s : TimeseriesanomalytwitterView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_view_to_string(s : TimeseriesanomalytwitterView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_range_make(size : Int) -> TimeseriesanomalytwitterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_range_len(s : TimeseriesanomalytwitterRange) -> Int { s.size }

pub fn timeseries_anomaly_twitter_range_get(s : TimeseriesanomalytwitterRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_range_set(s : TimeseriesanomalytwitterRange, i : Int, v : Double) -> TimeseriesanomalytwitterRange {
  let result = timeseries_anomaly_twitter_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_range_sum(s : TimeseriesanomalytwitterRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_range_mean(s : TimeseriesanomalytwitterRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_range_scale(s : TimeseriesanomalytwitterRange, f : Double) -> TimeseriesanomalytwitterRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_range_add(a : TimeseriesanomalytwitterRange, b : TimeseriesanomalytwitterRange) -> TimeseriesanomalytwitterRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_range_copy(s : TimeseriesanomalytwitterRange) -> TimeseriesanomalytwitterRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_range_fill(s : TimeseriesanomalytwitterRange, v : Double) -> TimeseriesanomalytwitterRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_range_min(s : TimeseriesanomalytwitterRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_range_max(s : TimeseriesanomalytwitterRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_range_to_string(s : TimeseriesanomalytwitterRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalytwitterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_twitter_slice_make(size : Int) -> TimeseriesanomalytwitterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_twitter_slice_len(s : TimeseriesanomalytwitterSlice) -> Int { s.size }

pub fn timeseries_anomaly_twitter_slice_get(s : TimeseriesanomalytwitterSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_twitter_slice_set(s : TimeseriesanomalytwitterSlice, i : Int, v : Double) -> TimeseriesanomalytwitterSlice {
  let result = timeseries_anomaly_twitter_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_twitter_slice_sum(s : TimeseriesanomalytwitterSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_twitter_slice_mean(s : TimeseriesanomalytwitterSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_twitter_slice_scale(s : TimeseriesanomalytwitterSlice, f : Double) -> TimeseriesanomalytwitterSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_slice_add(a : TimeseriesanomalytwitterSlice, b : TimeseriesanomalytwitterSlice) -> TimeseriesanomalytwitterSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_twitter_slice_copy(s : TimeseriesanomalytwitterSlice) -> TimeseriesanomalytwitterSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_slice_fill(s : TimeseriesanomalytwitterSlice, v : Double) -> TimeseriesanomalytwitterSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_twitter_slice_min(s : TimeseriesanomalytwitterSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_twitter_slice_max(s : TimeseriesanomalytwitterSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_twitter_slice_to_string(s : TimeseriesanomalytwitterSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

