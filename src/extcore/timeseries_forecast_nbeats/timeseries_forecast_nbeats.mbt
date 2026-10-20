///===
/// extcore/timeseries_forecast_nbeats

pub(all) struct TimeseriesforecastnbeatsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_nbeats_make_point(x : Double, y : Double) -> TimeseriesforecastnbeatsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_nbeats_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastnbeatsPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_nbeats_point_x(pt : TimeseriesforecastnbeatsPoint) -> Double { pt.x }

pub fn timeseries_forecast_nbeats_point_y(pt : TimeseriesforecastnbeatsPoint) -> Double { pt.y }

pub fn timeseries_forecast_nbeats_point_z(pt : TimeseriesforecastnbeatsPoint) -> Double { pt.z }

pub fn timeseries_forecast_nbeats_point_label(pt : TimeseriesforecastnbeatsPoint) -> Int { pt.label }

pub fn timeseries_forecast_nbeats_point_dist(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_nbeats_point_add(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_nbeats_point_sub(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_nbeats_point_scale(pt : TimeseriesforecastnbeatsPoint, s : Double) -> TimeseriesforecastnbeatsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_nbeats_point_dot(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_nbeats_point_cross(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_nbeats_point_norm(pt : TimeseriesforecastnbeatsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_nbeats_point_normalize(pt : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  let n = timeseries_forecast_nbeats_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_nbeats_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_nbeats_point_negate(pt : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_nbeats_point_mid(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_nbeats_point_lerp(a : TimeseriesforecastnbeatsPoint, b : TimeseriesforecastnbeatsPoint, t : Double) -> TimeseriesforecastnbeatsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_nbeats_point_to_string(pt : TimeseriesforecastnbeatsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_nbeats_make_series(vals : Array[Double], name : String) -> TimeseriesforecastnbeatsSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_nbeats_series_len(s : TimeseriesforecastnbeatsSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_nbeats_series_sum(s : TimeseriesforecastnbeatsSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_forecast_nbeats_series_mean(s : TimeseriesforecastnbeatsSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_nbeats_series_min(s : TimeseriesforecastnbeatsSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_nbeats_series_max(s : TimeseriesforecastnbeatsSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_nbeats_series_range(s : TimeseriesforecastnbeatsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_nbeats_series_var(s : TimeseriesforecastnbeatsSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_nbeats_series_std(s : TimeseriesforecastnbeatsSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_nbeats_series_median(s : TimeseriesforecastnbeatsSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_nbeats_series_scale(s : TimeseriesforecastnbeatsSeries, f : Double) -> TimeseriesforecastnbeatsSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_nbeats_series_add(a : TimeseriesforecastnbeatsSeries, b : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_nbeats_series_sub(a : TimeseriesforecastnbeatsSeries, b : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_nbeats_series_normalize(s : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  let mn = timeseries_forecast_nbeats_series_min(s)
  let mx = timeseries_forecast_nbeats_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_nbeats_series_cumsum(s : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_nbeats_series_to_string(s : TimeseriesforecastnbeatsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastnbeatsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_nbeats_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastnbeatsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_nbeats_matrix_identity(n : Int) -> TimeseriesforecastnbeatsMatrix {
  let m = timeseries_forecast_nbeats_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_nbeats_matrix_get(m : TimeseriesforecastnbeatsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_nbeats_matrix_transpose(m : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  let result = timeseries_forecast_nbeats_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_nbeats_matrix_add(a : TimeseriesforecastnbeatsMatrix, b : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_nbeats_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_nbeats_matrix_scale(m : TimeseriesforecastnbeatsMatrix, s : Double) -> TimeseriesforecastnbeatsMatrix {
  let result = timeseries_forecast_nbeats_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_nbeats_matrix_multiply(a : TimeseriesforecastnbeatsMatrix, b : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  if a.cols != b.rows { return timeseries_forecast_nbeats_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_nbeats_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_nbeats_matrix_trace(m : TimeseriesforecastnbeatsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_nbeats_matrix_det(m : TimeseriesforecastnbeatsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_nbeats_matrix_norm(m : TimeseriesforecastnbeatsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_nbeats_matrix_to_string(m : TimeseriesforecastnbeatsMatrix) -> String {
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

pub(all) struct TimeseriesforecastnbeatsVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_nbeats_make_vector(comps : Array[Double]) -> TimeseriesforecastnbeatsVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_nbeats_vector_zero(dim : Int) -> TimeseriesforecastnbeatsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_nbeats_vector_add(a : TimeseriesforecastnbeatsVector, b : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_forecast_nbeats_vector_sub(a : TimeseriesforecastnbeatsVector, b : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_forecast_nbeats_vector_scale(v : TimeseriesforecastnbeatsVector, s : Double) -> TimeseriesforecastnbeatsVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn timeseries_forecast_nbeats_vector_dot(a : TimeseriesforecastnbeatsVector, b : TimeseriesforecastnbeatsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_nbeats_vector_norm(v : TimeseriesforecastnbeatsVector) -> Double { @_common.sqrt(timeseries_forecast_nbeats_vector_dot(v, v)) }

pub fn timeseries_forecast_nbeats_vector_normalize(v : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = timeseries_forecast_nbeats_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_nbeats_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_nbeats_vector_dist(a : TimeseriesforecastnbeatsVector, b : TimeseriesforecastnbeatsVector) -> Double {
  timeseries_forecast_nbeats_vector_norm(timeseries_forecast_nbeats_vector_sub(a, b))
}

pub fn timeseries_forecast_nbeats_vector_to_string(v : TimeseriesforecastnbeatsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_nbeats_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_nbeats_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_nbeats_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_nbeats_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_nbeats_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_nbeats_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_nbeats_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_nbeats_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_nbeats_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_nbeats_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_nbeats_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_nbeats_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_nbeats_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_nbeats_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_nbeats_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_nbeats_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_nbeats_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_nbeats_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_nbeats_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_nbeats_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_nbeats_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_nbeats_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_nbeats_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_nbeats_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_nbeats_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_nbeats_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_nbeats_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_nbeats_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_nbeats_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastnbeatsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_frame_make(size : Int) -> TimeseriesforecastnbeatsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_frame_len(s : TimeseriesforecastnbeatsFrame) -> Int { s.size }

pub fn timeseries_forecast_nbeats_frame_get(s : TimeseriesforecastnbeatsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_frame_set(s : TimeseriesforecastnbeatsFrame, i : Int, v : Double) -> TimeseriesforecastnbeatsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_frame_sum(s : TimeseriesforecastnbeatsFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_frame_mean(s : TimeseriesforecastnbeatsFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_frame_scale(s : TimeseriesforecastnbeatsFrame, f : Double) -> TimeseriesforecastnbeatsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_frame_add(a : TimeseriesforecastnbeatsFrame, b : TimeseriesforecastnbeatsFrame) -> TimeseriesforecastnbeatsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_frame_copy(s : TimeseriesforecastnbeatsFrame) -> TimeseriesforecastnbeatsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_frame_fill(s : TimeseriesforecastnbeatsFrame, v : Double) -> TimeseriesforecastnbeatsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_frame_min(s : TimeseriesforecastnbeatsFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_frame_max(s : TimeseriesforecastnbeatsFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_frame_to_string(s : TimeseriesforecastnbeatsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_table_make(size : Int) -> TimeseriesforecastnbeatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_table_len(s : TimeseriesforecastnbeatsTable) -> Int { s.size }

pub fn timeseries_forecast_nbeats_table_get(s : TimeseriesforecastnbeatsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_table_set(s : TimeseriesforecastnbeatsTable, i : Int, v : Double) -> TimeseriesforecastnbeatsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_table_sum(s : TimeseriesforecastnbeatsTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_table_mean(s : TimeseriesforecastnbeatsTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_table_scale(s : TimeseriesforecastnbeatsTable, f : Double) -> TimeseriesforecastnbeatsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_table_add(a : TimeseriesforecastnbeatsTable, b : TimeseriesforecastnbeatsTable) -> TimeseriesforecastnbeatsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_table_copy(s : TimeseriesforecastnbeatsTable) -> TimeseriesforecastnbeatsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_table_fill(s : TimeseriesforecastnbeatsTable, v : Double) -> TimeseriesforecastnbeatsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_table_min(s : TimeseriesforecastnbeatsTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_table_max(s : TimeseriesforecastnbeatsTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_table_to_string(s : TimeseriesforecastnbeatsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_graphn_make(size : Int) -> TimeseriesforecastnbeatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_graphn_len(s : TimeseriesforecastnbeatsGraphN) -> Int { s.size }

pub fn timeseries_forecast_nbeats_graphn_get(s : TimeseriesforecastnbeatsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_graphn_set(s : TimeseriesforecastnbeatsGraphN, i : Int, v : Double) -> TimeseriesforecastnbeatsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_graphn_sum(s : TimeseriesforecastnbeatsGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_graphn_mean(s : TimeseriesforecastnbeatsGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_graphn_scale(s : TimeseriesforecastnbeatsGraphN, f : Double) -> TimeseriesforecastnbeatsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_graphn_add(a : TimeseriesforecastnbeatsGraphN, b : TimeseriesforecastnbeatsGraphN) -> TimeseriesforecastnbeatsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_graphn_copy(s : TimeseriesforecastnbeatsGraphN) -> TimeseriesforecastnbeatsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_graphn_fill(s : TimeseriesforecastnbeatsGraphN, v : Double) -> TimeseriesforecastnbeatsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_graphn_min(s : TimeseriesforecastnbeatsGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_graphn_max(s : TimeseriesforecastnbeatsGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_graphn_to_string(s : TimeseriesforecastnbeatsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_node_make(size : Int) -> TimeseriesforecastnbeatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_node_len(s : TimeseriesforecastnbeatsNode) -> Int { s.size }

pub fn timeseries_forecast_nbeats_node_get(s : TimeseriesforecastnbeatsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_node_set(s : TimeseriesforecastnbeatsNode, i : Int, v : Double) -> TimeseriesforecastnbeatsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_node_sum(s : TimeseriesforecastnbeatsNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_node_mean(s : TimeseriesforecastnbeatsNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_node_scale(s : TimeseriesforecastnbeatsNode, f : Double) -> TimeseriesforecastnbeatsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_node_add(a : TimeseriesforecastnbeatsNode, b : TimeseriesforecastnbeatsNode) -> TimeseriesforecastnbeatsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_node_copy(s : TimeseriesforecastnbeatsNode) -> TimeseriesforecastnbeatsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_node_fill(s : TimeseriesforecastnbeatsNode, v : Double) -> TimeseriesforecastnbeatsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_node_min(s : TimeseriesforecastnbeatsNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_node_max(s : TimeseriesforecastnbeatsNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_node_to_string(s : TimeseriesforecastnbeatsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_edge_make(size : Int) -> TimeseriesforecastnbeatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_edge_len(s : TimeseriesforecastnbeatsEdge) -> Int { s.size }

pub fn timeseries_forecast_nbeats_edge_get(s : TimeseriesforecastnbeatsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_edge_set(s : TimeseriesforecastnbeatsEdge, i : Int, v : Double) -> TimeseriesforecastnbeatsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_edge_sum(s : TimeseriesforecastnbeatsEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_edge_mean(s : TimeseriesforecastnbeatsEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_edge_scale(s : TimeseriesforecastnbeatsEdge, f : Double) -> TimeseriesforecastnbeatsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_edge_add(a : TimeseriesforecastnbeatsEdge, b : TimeseriesforecastnbeatsEdge) -> TimeseriesforecastnbeatsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_edge_copy(s : TimeseriesforecastnbeatsEdge) -> TimeseriesforecastnbeatsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_edge_fill(s : TimeseriesforecastnbeatsEdge, v : Double) -> TimeseriesforecastnbeatsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_edge_min(s : TimeseriesforecastnbeatsEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_edge_max(s : TimeseriesforecastnbeatsEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_edge_to_string(s : TimeseriesforecastnbeatsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_path_make(size : Int) -> TimeseriesforecastnbeatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_path_len(s : TimeseriesforecastnbeatsPath) -> Int { s.size }

pub fn timeseries_forecast_nbeats_path_get(s : TimeseriesforecastnbeatsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_path_set(s : TimeseriesforecastnbeatsPath, i : Int, v : Double) -> TimeseriesforecastnbeatsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_path_sum(s : TimeseriesforecastnbeatsPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_path_mean(s : TimeseriesforecastnbeatsPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_path_scale(s : TimeseriesforecastnbeatsPath, f : Double) -> TimeseriesforecastnbeatsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_path_add(a : TimeseriesforecastnbeatsPath, b : TimeseriesforecastnbeatsPath) -> TimeseriesforecastnbeatsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_path_copy(s : TimeseriesforecastnbeatsPath) -> TimeseriesforecastnbeatsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_path_fill(s : TimeseriesforecastnbeatsPath, v : Double) -> TimeseriesforecastnbeatsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_path_min(s : TimeseriesforecastnbeatsPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_path_max(s : TimeseriesforecastnbeatsPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_path_to_string(s : TimeseriesforecastnbeatsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_cluster_make(size : Int) -> TimeseriesforecastnbeatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_cluster_len(s : TimeseriesforecastnbeatsCluster) -> Int { s.size }

pub fn timeseries_forecast_nbeats_cluster_get(s : TimeseriesforecastnbeatsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_cluster_set(s : TimeseriesforecastnbeatsCluster, i : Int, v : Double) -> TimeseriesforecastnbeatsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_cluster_sum(s : TimeseriesforecastnbeatsCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_cluster_mean(s : TimeseriesforecastnbeatsCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_cluster_scale(s : TimeseriesforecastnbeatsCluster, f : Double) -> TimeseriesforecastnbeatsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_cluster_add(a : TimeseriesforecastnbeatsCluster, b : TimeseriesforecastnbeatsCluster) -> TimeseriesforecastnbeatsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_cluster_copy(s : TimeseriesforecastnbeatsCluster) -> TimeseriesforecastnbeatsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_cluster_fill(s : TimeseriesforecastnbeatsCluster, v : Double) -> TimeseriesforecastnbeatsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_cluster_min(s : TimeseriesforecastnbeatsCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_cluster_max(s : TimeseriesforecastnbeatsCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_cluster_to_string(s : TimeseriesforecastnbeatsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_model_make(size : Int) -> TimeseriesforecastnbeatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_model_len(s : TimeseriesforecastnbeatsModel) -> Int { s.size }

pub fn timeseries_forecast_nbeats_model_get(s : TimeseriesforecastnbeatsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_model_set(s : TimeseriesforecastnbeatsModel, i : Int, v : Double) -> TimeseriesforecastnbeatsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_model_sum(s : TimeseriesforecastnbeatsModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_model_mean(s : TimeseriesforecastnbeatsModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_model_scale(s : TimeseriesforecastnbeatsModel, f : Double) -> TimeseriesforecastnbeatsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_model_add(a : TimeseriesforecastnbeatsModel, b : TimeseriesforecastnbeatsModel) -> TimeseriesforecastnbeatsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_model_copy(s : TimeseriesforecastnbeatsModel) -> TimeseriesforecastnbeatsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_model_fill(s : TimeseriesforecastnbeatsModel, v : Double) -> TimeseriesforecastnbeatsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_model_min(s : TimeseriesforecastnbeatsModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_model_max(s : TimeseriesforecastnbeatsModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_model_to_string(s : TimeseriesforecastnbeatsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_layer_make(size : Int) -> TimeseriesforecastnbeatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_layer_len(s : TimeseriesforecastnbeatsLayer) -> Int { s.size }

pub fn timeseries_forecast_nbeats_layer_get(s : TimeseriesforecastnbeatsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_layer_set(s : TimeseriesforecastnbeatsLayer, i : Int, v : Double) -> TimeseriesforecastnbeatsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_layer_sum(s : TimeseriesforecastnbeatsLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_layer_mean(s : TimeseriesforecastnbeatsLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_layer_scale(s : TimeseriesforecastnbeatsLayer, f : Double) -> TimeseriesforecastnbeatsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_layer_add(a : TimeseriesforecastnbeatsLayer, b : TimeseriesforecastnbeatsLayer) -> TimeseriesforecastnbeatsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_layer_copy(s : TimeseriesforecastnbeatsLayer) -> TimeseriesforecastnbeatsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_layer_fill(s : TimeseriesforecastnbeatsLayer, v : Double) -> TimeseriesforecastnbeatsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_layer_min(s : TimeseriesforecastnbeatsLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_layer_max(s : TimeseriesforecastnbeatsLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_layer_to_string(s : TimeseriesforecastnbeatsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_buffer_make(size : Int) -> TimeseriesforecastnbeatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_buffer_len(s : TimeseriesforecastnbeatsBuffer) -> Int { s.size }

pub fn timeseries_forecast_nbeats_buffer_get(s : TimeseriesforecastnbeatsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_buffer_set(s : TimeseriesforecastnbeatsBuffer, i : Int, v : Double) -> TimeseriesforecastnbeatsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_buffer_sum(s : TimeseriesforecastnbeatsBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_buffer_mean(s : TimeseriesforecastnbeatsBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_buffer_scale(s : TimeseriesforecastnbeatsBuffer, f : Double) -> TimeseriesforecastnbeatsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_buffer_add(a : TimeseriesforecastnbeatsBuffer, b : TimeseriesforecastnbeatsBuffer) -> TimeseriesforecastnbeatsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_buffer_copy(s : TimeseriesforecastnbeatsBuffer) -> TimeseriesforecastnbeatsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_buffer_fill(s : TimeseriesforecastnbeatsBuffer, v : Double) -> TimeseriesforecastnbeatsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_buffer_min(s : TimeseriesforecastnbeatsBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_buffer_max(s : TimeseriesforecastnbeatsBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_buffer_to_string(s : TimeseriesforecastnbeatsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_cursor_make(size : Int) -> TimeseriesforecastnbeatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_cursor_len(s : TimeseriesforecastnbeatsCursor) -> Int { s.size }

pub fn timeseries_forecast_nbeats_cursor_get(s : TimeseriesforecastnbeatsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_cursor_set(s : TimeseriesforecastnbeatsCursor, i : Int, v : Double) -> TimeseriesforecastnbeatsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_cursor_sum(s : TimeseriesforecastnbeatsCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_cursor_mean(s : TimeseriesforecastnbeatsCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_cursor_scale(s : TimeseriesforecastnbeatsCursor, f : Double) -> TimeseriesforecastnbeatsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_cursor_add(a : TimeseriesforecastnbeatsCursor, b : TimeseriesforecastnbeatsCursor) -> TimeseriesforecastnbeatsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_cursor_copy(s : TimeseriesforecastnbeatsCursor) -> TimeseriesforecastnbeatsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_cursor_fill(s : TimeseriesforecastnbeatsCursor, v : Double) -> TimeseriesforecastnbeatsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_cursor_min(s : TimeseriesforecastnbeatsCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_cursor_max(s : TimeseriesforecastnbeatsCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_cursor_to_string(s : TimeseriesforecastnbeatsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_view_make(size : Int) -> TimeseriesforecastnbeatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_view_len(s : TimeseriesforecastnbeatsView) -> Int { s.size }

pub fn timeseries_forecast_nbeats_view_get(s : TimeseriesforecastnbeatsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_view_set(s : TimeseriesforecastnbeatsView, i : Int, v : Double) -> TimeseriesforecastnbeatsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_view_sum(s : TimeseriesforecastnbeatsView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_view_mean(s : TimeseriesforecastnbeatsView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_view_scale(s : TimeseriesforecastnbeatsView, f : Double) -> TimeseriesforecastnbeatsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_view_add(a : TimeseriesforecastnbeatsView, b : TimeseriesforecastnbeatsView) -> TimeseriesforecastnbeatsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_view_copy(s : TimeseriesforecastnbeatsView) -> TimeseriesforecastnbeatsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_view_fill(s : TimeseriesforecastnbeatsView, v : Double) -> TimeseriesforecastnbeatsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_view_min(s : TimeseriesforecastnbeatsView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_view_max(s : TimeseriesforecastnbeatsView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_view_to_string(s : TimeseriesforecastnbeatsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_range_make(size : Int) -> TimeseriesforecastnbeatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_range_len(s : TimeseriesforecastnbeatsRange) -> Int { s.size }

pub fn timeseries_forecast_nbeats_range_get(s : TimeseriesforecastnbeatsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_range_set(s : TimeseriesforecastnbeatsRange, i : Int, v : Double) -> TimeseriesforecastnbeatsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_range_sum(s : TimeseriesforecastnbeatsRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_range_mean(s : TimeseriesforecastnbeatsRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_range_scale(s : TimeseriesforecastnbeatsRange, f : Double) -> TimeseriesforecastnbeatsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_range_add(a : TimeseriesforecastnbeatsRange, b : TimeseriesforecastnbeatsRange) -> TimeseriesforecastnbeatsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_range_copy(s : TimeseriesforecastnbeatsRange) -> TimeseriesforecastnbeatsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_range_fill(s : TimeseriesforecastnbeatsRange, v : Double) -> TimeseriesforecastnbeatsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_range_min(s : TimeseriesforecastnbeatsRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_range_max(s : TimeseriesforecastnbeatsRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_range_to_string(s : TimeseriesforecastnbeatsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_slice_make(size : Int) -> TimeseriesforecastnbeatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_nbeats_slice_len(s : TimeseriesforecastnbeatsSlice) -> Int { s.size }

pub fn timeseries_forecast_nbeats_slice_get(s : TimeseriesforecastnbeatsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_nbeats_slice_set(s : TimeseriesforecastnbeatsSlice, i : Int, v : Double) -> TimeseriesforecastnbeatsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_slice_sum(s : TimeseriesforecastnbeatsSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_nbeats_slice_mean(s : TimeseriesforecastnbeatsSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_nbeats_slice_scale(s : TimeseriesforecastnbeatsSlice, f : Double) -> TimeseriesforecastnbeatsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_slice_add(a : TimeseriesforecastnbeatsSlice, b : TimeseriesforecastnbeatsSlice) -> TimeseriesforecastnbeatsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_nbeats_slice_copy(s : TimeseriesforecastnbeatsSlice) -> TimeseriesforecastnbeatsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_slice_fill(s : TimeseriesforecastnbeatsSlice, v : Double) -> TimeseriesforecastnbeatsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_nbeats_slice_min(s : TimeseriesforecastnbeatsSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_nbeats_slice_max(s : TimeseriesforecastnbeatsSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_nbeats_slice_to_string(s : TimeseriesforecastnbeatsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

