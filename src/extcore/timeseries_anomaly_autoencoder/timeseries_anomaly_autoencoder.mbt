///===
/// extcore/timeseries_anomaly_autoencoder

pub(all) struct TimeseriesanomalyautoencoderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_autoencoder_make_point(x : Double, y : Double) -> TimeseriesanomalyautoencoderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_autoencoder_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyautoencoderPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_autoencoder_point_x(pt : TimeseriesanomalyautoencoderPoint) -> Double { pt.x }

pub fn timeseries_anomaly_autoencoder_point_y(pt : TimeseriesanomalyautoencoderPoint) -> Double { pt.y }

pub fn timeseries_anomaly_autoencoder_point_z(pt : TimeseriesanomalyautoencoderPoint) -> Double { pt.z }

pub fn timeseries_anomaly_autoencoder_point_label(pt : TimeseriesanomalyautoencoderPoint) -> Int { pt.label }

pub fn timeseries_anomaly_autoencoder_point_dist(a : TimeseriesanomalyautoencoderPoint, b : TimeseriesanomalyautoencoderPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_autoencoder_point_add(a : TimeseriesanomalyautoencoderPoint, b : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_autoencoder_point_sub(a : TimeseriesanomalyautoencoderPoint, b : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_autoencoder_point_scale(pt : TimeseriesanomalyautoencoderPoint, s : Double) -> TimeseriesanomalyautoencoderPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_autoencoder_point_dot(a : TimeseriesanomalyautoencoderPoint, b : TimeseriesanomalyautoencoderPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_autoencoder_point_cross(a : TimeseriesanomalyautoencoderPoint, b : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_autoencoder_point_norm(pt : TimeseriesanomalyautoencoderPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_autoencoder_point_normalize(pt : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  let n = timeseries_anomaly_autoencoder_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_autoencoder_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_autoencoder_point_negate(pt : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_autoencoder_point_mid(a : TimeseriesanomalyautoencoderPoint, b : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_autoencoder_point_lerp(a : TimeseriesanomalyautoencoderPoint, b : TimeseriesanomalyautoencoderPoint, t : Double) -> TimeseriesanomalyautoencoderPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_autoencoder_point_to_string(pt : TimeseriesanomalyautoencoderPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_autoencoder_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyautoencoderSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_autoencoder_series_len(s : TimeseriesanomalyautoencoderSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_autoencoder_series_sum(s : TimeseriesanomalyautoencoderSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_anomaly_autoencoder_series_mean(s : TimeseriesanomalyautoencoderSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_anomaly_autoencoder_series_min(s : TimeseriesanomalyautoencoderSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_anomaly_autoencoder_series_max(s : TimeseriesanomalyautoencoderSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_anomaly_autoencoder_series_range(s : TimeseriesanomalyautoencoderSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_anomaly_autoencoder_series_var(s : TimeseriesanomalyautoencoderSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_anomaly_autoencoder_series_std(s : TimeseriesanomalyautoencoderSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_anomaly_autoencoder_series_median(s : TimeseriesanomalyautoencoderSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_anomaly_autoencoder_series_scale(s : TimeseriesanomalyautoencoderSeries, f : Double) -> TimeseriesanomalyautoencoderSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_autoencoder_series_add(a : TimeseriesanomalyautoencoderSeries, b : TimeseriesanomalyautoencoderSeries) -> TimeseriesanomalyautoencoderSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_autoencoder_series_sub(a : TimeseriesanomalyautoencoderSeries, b : TimeseriesanomalyautoencoderSeries) -> TimeseriesanomalyautoencoderSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_autoencoder_series_normalize(s : TimeseriesanomalyautoencoderSeries) -> TimeseriesanomalyautoencoderSeries {
  let mn = timeseries_anomaly_autoencoder_series_min(s)
  let mx = timeseries_anomaly_autoencoder_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_autoencoder_series_cumsum(s : TimeseriesanomalyautoencoderSeries) -> TimeseriesanomalyautoencoderSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_autoencoder_series_to_string(s : TimeseriesanomalyautoencoderSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyautoencoderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_autoencoder_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyautoencoderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_autoencoder_matrix_identity(n : Int) -> TimeseriesanomalyautoencoderMatrix {
  let m = timeseries_anomaly_autoencoder_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_autoencoder_matrix_get(m : TimeseriesanomalyautoencoderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_autoencoder_matrix_transpose(m : TimeseriesanomalyautoencoderMatrix) -> TimeseriesanomalyautoencoderMatrix {
  let result = timeseries_anomaly_autoencoder_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_autoencoder_matrix_add(a : TimeseriesanomalyautoencoderMatrix, b : TimeseriesanomalyautoencoderMatrix) -> TimeseriesanomalyautoencoderMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_autoencoder_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_autoencoder_matrix_scale(m : TimeseriesanomalyautoencoderMatrix, s : Double) -> TimeseriesanomalyautoencoderMatrix {
  let result = timeseries_anomaly_autoencoder_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_autoencoder_matrix_multiply(a : TimeseriesanomalyautoencoderMatrix, b : TimeseriesanomalyautoencoderMatrix) -> TimeseriesanomalyautoencoderMatrix {
  if a.cols != b.rows { return timeseries_anomaly_autoencoder_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_autoencoder_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_autoencoder_matrix_trace(m : TimeseriesanomalyautoencoderMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_autoencoder_matrix_det(m : TimeseriesanomalyautoencoderMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_autoencoder_matrix_norm(m : TimeseriesanomalyautoencoderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_anomaly_autoencoder_matrix_to_string(m : TimeseriesanomalyautoencoderMatrix) -> String {
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

pub(all) struct TimeseriesanomalyautoencoderVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_autoencoder_make_vector(comps : Array[Double]) -> TimeseriesanomalyautoencoderVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_autoencoder_vector_zero(dim : Int) -> TimeseriesanomalyautoencoderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_autoencoder_vector_add(a : TimeseriesanomalyautoencoderVector, b : TimeseriesanomalyautoencoderVector) -> TimeseriesanomalyautoencoderVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_anomaly_autoencoder_vector_sub(a : TimeseriesanomalyautoencoderVector, b : TimeseriesanomalyautoencoderVector) -> TimeseriesanomalyautoencoderVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_anomaly_autoencoder_vector_scale(v : TimeseriesanomalyautoencoderVector, s : Double) -> TimeseriesanomalyautoencoderVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn timeseries_anomaly_autoencoder_vector_dot(a : TimeseriesanomalyautoencoderVector, b : TimeseriesanomalyautoencoderVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_autoencoder_vector_norm(v : TimeseriesanomalyautoencoderVector) -> Double { @_common.sqrt(timeseries_anomaly_autoencoder_vector_dot(v, v)) }

pub fn timeseries_anomaly_autoencoder_vector_normalize(v : TimeseriesanomalyautoencoderVector) -> TimeseriesanomalyautoencoderVector {
  let n = timeseries_anomaly_autoencoder_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_autoencoder_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_autoencoder_vector_dist(a : TimeseriesanomalyautoencoderVector, b : TimeseriesanomalyautoencoderVector) -> Double {
  timeseries_anomaly_autoencoder_vector_norm(timeseries_anomaly_autoencoder_vector_sub(a, b))
}

pub fn timeseries_anomaly_autoencoder_vector_to_string(v : TimeseriesanomalyautoencoderVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_autoencoder_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_autoencoder_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_autoencoder_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_autoencoder_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_autoencoder_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_autoencoder_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_autoencoder_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_autoencoder_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_autoencoder_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_autoencoder_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_autoencoder_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_autoencoder_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_autoencoder_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_autoencoder_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_autoencoder_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_autoencoder_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_autoencoder_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_autoencoder_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_autoencoder_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_autoencoder_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_autoencoder_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_autoencoder_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_autoencoder_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_autoencoder_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_autoencoder_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_autoencoder_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_autoencoder_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_autoencoder_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_autoencoder_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyautoencoderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_frame_make(size : Int) -> TimeseriesanomalyautoencoderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_frame_len(s : TimeseriesanomalyautoencoderFrame) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_frame_get(s : TimeseriesanomalyautoencoderFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_frame_set(s : TimeseriesanomalyautoencoderFrame, i : Int, v : Double) -> TimeseriesanomalyautoencoderFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_sum(s : TimeseriesanomalyautoencoderFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_frame_mean(s : TimeseriesanomalyautoencoderFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_frame_scale(s : TimeseriesanomalyautoencoderFrame, f : Double) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_add(a : TimeseriesanomalyautoencoderFrame, b : TimeseriesanomalyautoencoderFrame) -> TimeseriesanomalyautoencoderFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_copy(s : TimeseriesanomalyautoencoderFrame) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_fill(s : TimeseriesanomalyautoencoderFrame, v : Double) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_min(s : TimeseriesanomalyautoencoderFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_frame_max(s : TimeseriesanomalyautoencoderFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_frame_to_string(s : TimeseriesanomalyautoencoderFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_table_make(size : Int) -> TimeseriesanomalyautoencoderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_table_len(s : TimeseriesanomalyautoencoderTable) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_table_get(s : TimeseriesanomalyautoencoderTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_table_set(s : TimeseriesanomalyautoencoderTable, i : Int, v : Double) -> TimeseriesanomalyautoencoderTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_table_sum(s : TimeseriesanomalyautoencoderTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_table_mean(s : TimeseriesanomalyautoencoderTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_table_scale(s : TimeseriesanomalyautoencoderTable, f : Double) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_table_add(a : TimeseriesanomalyautoencoderTable, b : TimeseriesanomalyautoencoderTable) -> TimeseriesanomalyautoencoderTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_table_copy(s : TimeseriesanomalyautoencoderTable) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_table_fill(s : TimeseriesanomalyautoencoderTable, v : Double) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_table_min(s : TimeseriesanomalyautoencoderTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_table_max(s : TimeseriesanomalyautoencoderTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_table_to_string(s : TimeseriesanomalyautoencoderTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_graphn_make(size : Int) -> TimeseriesanomalyautoencoderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_graphn_len(s : TimeseriesanomalyautoencoderGraphN) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_graphn_get(s : TimeseriesanomalyautoencoderGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_graphn_set(s : TimeseriesanomalyautoencoderGraphN, i : Int, v : Double) -> TimeseriesanomalyautoencoderGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_sum(s : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_graphn_mean(s : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_graphn_scale(s : TimeseriesanomalyautoencoderGraphN, f : Double) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_add(a : TimeseriesanomalyautoencoderGraphN, b : TimeseriesanomalyautoencoderGraphN) -> TimeseriesanomalyautoencoderGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_copy(s : TimeseriesanomalyautoencoderGraphN) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_fill(s : TimeseriesanomalyautoencoderGraphN, v : Double) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_min(s : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_graphn_max(s : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_graphn_to_string(s : TimeseriesanomalyautoencoderGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_node_make(size : Int) -> TimeseriesanomalyautoencoderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_node_len(s : TimeseriesanomalyautoencoderNode) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_node_get(s : TimeseriesanomalyautoencoderNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_node_set(s : TimeseriesanomalyautoencoderNode, i : Int, v : Double) -> TimeseriesanomalyautoencoderNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_node_sum(s : TimeseriesanomalyautoencoderNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_node_mean(s : TimeseriesanomalyautoencoderNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_node_scale(s : TimeseriesanomalyautoencoderNode, f : Double) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_node_add(a : TimeseriesanomalyautoencoderNode, b : TimeseriesanomalyautoencoderNode) -> TimeseriesanomalyautoencoderNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_node_copy(s : TimeseriesanomalyautoencoderNode) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_node_fill(s : TimeseriesanomalyautoencoderNode, v : Double) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_node_min(s : TimeseriesanomalyautoencoderNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_node_max(s : TimeseriesanomalyautoencoderNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_node_to_string(s : TimeseriesanomalyautoencoderNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_edge_make(size : Int) -> TimeseriesanomalyautoencoderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_edge_len(s : TimeseriesanomalyautoencoderEdge) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_edge_get(s : TimeseriesanomalyautoencoderEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_edge_set(s : TimeseriesanomalyautoencoderEdge, i : Int, v : Double) -> TimeseriesanomalyautoencoderEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_sum(s : TimeseriesanomalyautoencoderEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_edge_mean(s : TimeseriesanomalyautoencoderEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_edge_scale(s : TimeseriesanomalyautoencoderEdge, f : Double) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_add(a : TimeseriesanomalyautoencoderEdge, b : TimeseriesanomalyautoencoderEdge) -> TimeseriesanomalyautoencoderEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_copy(s : TimeseriesanomalyautoencoderEdge) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_fill(s : TimeseriesanomalyautoencoderEdge, v : Double) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_min(s : TimeseriesanomalyautoencoderEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_edge_max(s : TimeseriesanomalyautoencoderEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_edge_to_string(s : TimeseriesanomalyautoencoderEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_path_make(size : Int) -> TimeseriesanomalyautoencoderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_path_len(s : TimeseriesanomalyautoencoderPath) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_path_get(s : TimeseriesanomalyautoencoderPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_path_set(s : TimeseriesanomalyautoencoderPath, i : Int, v : Double) -> TimeseriesanomalyautoencoderPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_path_sum(s : TimeseriesanomalyautoencoderPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_path_mean(s : TimeseriesanomalyautoencoderPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_path_scale(s : TimeseriesanomalyautoencoderPath, f : Double) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_path_add(a : TimeseriesanomalyautoencoderPath, b : TimeseriesanomalyautoencoderPath) -> TimeseriesanomalyautoencoderPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_path_copy(s : TimeseriesanomalyautoencoderPath) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_path_fill(s : TimeseriesanomalyautoencoderPath, v : Double) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_path_min(s : TimeseriesanomalyautoencoderPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_path_max(s : TimeseriesanomalyautoencoderPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_path_to_string(s : TimeseriesanomalyautoencoderPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_cluster_make(size : Int) -> TimeseriesanomalyautoencoderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_cluster_len(s : TimeseriesanomalyautoencoderCluster) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_cluster_get(s : TimeseriesanomalyautoencoderCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_cluster_set(s : TimeseriesanomalyautoencoderCluster, i : Int, v : Double) -> TimeseriesanomalyautoencoderCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_sum(s : TimeseriesanomalyautoencoderCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_cluster_mean(s : TimeseriesanomalyautoencoderCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_cluster_scale(s : TimeseriesanomalyautoencoderCluster, f : Double) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_add(a : TimeseriesanomalyautoencoderCluster, b : TimeseriesanomalyautoencoderCluster) -> TimeseriesanomalyautoencoderCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_copy(s : TimeseriesanomalyautoencoderCluster) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_fill(s : TimeseriesanomalyautoencoderCluster, v : Double) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_min(s : TimeseriesanomalyautoencoderCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_cluster_max(s : TimeseriesanomalyautoencoderCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_cluster_to_string(s : TimeseriesanomalyautoencoderCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_model_make(size : Int) -> TimeseriesanomalyautoencoderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_model_len(s : TimeseriesanomalyautoencoderModel) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_model_get(s : TimeseriesanomalyautoencoderModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_model_set(s : TimeseriesanomalyautoencoderModel, i : Int, v : Double) -> TimeseriesanomalyautoencoderModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_model_sum(s : TimeseriesanomalyautoencoderModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_model_mean(s : TimeseriesanomalyautoencoderModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_model_scale(s : TimeseriesanomalyautoencoderModel, f : Double) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_model_add(a : TimeseriesanomalyautoencoderModel, b : TimeseriesanomalyautoencoderModel) -> TimeseriesanomalyautoencoderModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_model_copy(s : TimeseriesanomalyautoencoderModel) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_model_fill(s : TimeseriesanomalyautoencoderModel, v : Double) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_model_min(s : TimeseriesanomalyautoencoderModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_model_max(s : TimeseriesanomalyautoencoderModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_model_to_string(s : TimeseriesanomalyautoencoderModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_layer_make(size : Int) -> TimeseriesanomalyautoencoderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_layer_len(s : TimeseriesanomalyautoencoderLayer) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_layer_get(s : TimeseriesanomalyautoencoderLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_layer_set(s : TimeseriesanomalyautoencoderLayer, i : Int, v : Double) -> TimeseriesanomalyautoencoderLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_sum(s : TimeseriesanomalyautoencoderLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_layer_mean(s : TimeseriesanomalyautoencoderLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_layer_scale(s : TimeseriesanomalyautoencoderLayer, f : Double) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_add(a : TimeseriesanomalyautoencoderLayer, b : TimeseriesanomalyautoencoderLayer) -> TimeseriesanomalyautoencoderLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_copy(s : TimeseriesanomalyautoencoderLayer) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_fill(s : TimeseriesanomalyautoencoderLayer, v : Double) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_min(s : TimeseriesanomalyautoencoderLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_layer_max(s : TimeseriesanomalyautoencoderLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_layer_to_string(s : TimeseriesanomalyautoencoderLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_buffer_make(size : Int) -> TimeseriesanomalyautoencoderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_buffer_len(s : TimeseriesanomalyautoencoderBuffer) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_buffer_get(s : TimeseriesanomalyautoencoderBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_buffer_set(s : TimeseriesanomalyautoencoderBuffer, i : Int, v : Double) -> TimeseriesanomalyautoencoderBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_sum(s : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_buffer_mean(s : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_buffer_scale(s : TimeseriesanomalyautoencoderBuffer, f : Double) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_add(a : TimeseriesanomalyautoencoderBuffer, b : TimeseriesanomalyautoencoderBuffer) -> TimeseriesanomalyautoencoderBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_copy(s : TimeseriesanomalyautoencoderBuffer) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_fill(s : TimeseriesanomalyautoencoderBuffer, v : Double) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_min(s : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_buffer_max(s : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_buffer_to_string(s : TimeseriesanomalyautoencoderBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_cursor_make(size : Int) -> TimeseriesanomalyautoencoderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_cursor_len(s : TimeseriesanomalyautoencoderCursor) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_cursor_get(s : TimeseriesanomalyautoencoderCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_cursor_set(s : TimeseriesanomalyautoencoderCursor, i : Int, v : Double) -> TimeseriesanomalyautoencoderCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_sum(s : TimeseriesanomalyautoencoderCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_cursor_mean(s : TimeseriesanomalyautoencoderCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_cursor_scale(s : TimeseriesanomalyautoencoderCursor, f : Double) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_add(a : TimeseriesanomalyautoencoderCursor, b : TimeseriesanomalyautoencoderCursor) -> TimeseriesanomalyautoencoderCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_copy(s : TimeseriesanomalyautoencoderCursor) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_fill(s : TimeseriesanomalyautoencoderCursor, v : Double) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_min(s : TimeseriesanomalyautoencoderCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_cursor_max(s : TimeseriesanomalyautoencoderCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_cursor_to_string(s : TimeseriesanomalyautoencoderCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_view_make(size : Int) -> TimeseriesanomalyautoencoderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_view_len(s : TimeseriesanomalyautoencoderView) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_view_get(s : TimeseriesanomalyautoencoderView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_view_set(s : TimeseriesanomalyautoencoderView, i : Int, v : Double) -> TimeseriesanomalyautoencoderView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_view_sum(s : TimeseriesanomalyautoencoderView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_view_mean(s : TimeseriesanomalyautoencoderView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_view_scale(s : TimeseriesanomalyautoencoderView, f : Double) -> TimeseriesanomalyautoencoderView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_view_add(a : TimeseriesanomalyautoencoderView, b : TimeseriesanomalyautoencoderView) -> TimeseriesanomalyautoencoderView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_view_copy(s : TimeseriesanomalyautoencoderView) -> TimeseriesanomalyautoencoderView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_view_fill(s : TimeseriesanomalyautoencoderView, v : Double) -> TimeseriesanomalyautoencoderView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_view_min(s : TimeseriesanomalyautoencoderView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_view_max(s : TimeseriesanomalyautoencoderView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_view_to_string(s : TimeseriesanomalyautoencoderView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_range_make(size : Int) -> TimeseriesanomalyautoencoderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_range_len(s : TimeseriesanomalyautoencoderRange) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_range_get(s : TimeseriesanomalyautoencoderRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_range_set(s : TimeseriesanomalyautoencoderRange, i : Int, v : Double) -> TimeseriesanomalyautoencoderRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_range_sum(s : TimeseriesanomalyautoencoderRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_range_mean(s : TimeseriesanomalyautoencoderRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_range_scale(s : TimeseriesanomalyautoencoderRange, f : Double) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_range_add(a : TimeseriesanomalyautoencoderRange, b : TimeseriesanomalyautoencoderRange) -> TimeseriesanomalyautoencoderRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_range_copy(s : TimeseriesanomalyautoencoderRange) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_range_fill(s : TimeseriesanomalyautoencoderRange, v : Double) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_range_min(s : TimeseriesanomalyautoencoderRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_range_max(s : TimeseriesanomalyautoencoderRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_range_to_string(s : TimeseriesanomalyautoencoderRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_slice_make(size : Int) -> TimeseriesanomalyautoencoderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_slice_len(s : TimeseriesanomalyautoencoderSlice) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_slice_get(s : TimeseriesanomalyautoencoderSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_slice_set(s : TimeseriesanomalyautoencoderSlice, i : Int, v : Double) -> TimeseriesanomalyautoencoderSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_sum(s : TimeseriesanomalyautoencoderSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_slice_mean(s : TimeseriesanomalyautoencoderSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_slice_scale(s : TimeseriesanomalyautoencoderSlice, f : Double) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_add(a : TimeseriesanomalyautoencoderSlice, b : TimeseriesanomalyautoencoderSlice) -> TimeseriesanomalyautoencoderSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_copy(s : TimeseriesanomalyautoencoderSlice) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_fill(s : TimeseriesanomalyautoencoderSlice, v : Double) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_min(s : TimeseriesanomalyautoencoderSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_slice_max(s : TimeseriesanomalyautoencoderSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_slice_to_string(s : TimeseriesanomalyautoencoderSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

