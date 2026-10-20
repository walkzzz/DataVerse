///===
/// extcore/timeseries_anomaly_isolation

pub(all) struct TimeseriesanomalyisolationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_isolation_make_point(x : Double, y : Double) -> TimeseriesanomalyisolationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_isolation_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyisolationPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_anomaly_isolation_point_x(pt : TimeseriesanomalyisolationPoint) -> Double { pt.x }

pub fn timeseries_anomaly_isolation_point_y(pt : TimeseriesanomalyisolationPoint) -> Double { pt.y }

pub fn timeseries_anomaly_isolation_point_z(pt : TimeseriesanomalyisolationPoint) -> Double { pt.z }

pub fn timeseries_anomaly_isolation_point_label(pt : TimeseriesanomalyisolationPoint) -> Int { pt.label }

pub fn timeseries_anomaly_isolation_point_dist(a : TimeseriesanomalyisolationPoint, b : TimeseriesanomalyisolationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_anomaly_isolation_point_add(a : TimeseriesanomalyisolationPoint, b : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_anomaly_isolation_point_sub(a : TimeseriesanomalyisolationPoint, b : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_anomaly_isolation_point_scale(pt : TimeseriesanomalyisolationPoint, s : Double) -> TimeseriesanomalyisolationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_anomaly_isolation_point_dot(a : TimeseriesanomalyisolationPoint, b : TimeseriesanomalyisolationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_anomaly_isolation_point_cross(a : TimeseriesanomalyisolationPoint, b : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_anomaly_isolation_point_norm(pt : TimeseriesanomalyisolationPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_anomaly_isolation_point_normalize(pt : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  let n = timeseries_anomaly_isolation_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_anomaly_isolation_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_anomaly_isolation_point_negate(pt : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_anomaly_isolation_point_mid(a : TimeseriesanomalyisolationPoint, b : TimeseriesanomalyisolationPoint) -> TimeseriesanomalyisolationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_anomaly_isolation_point_lerp(a : TimeseriesanomalyisolationPoint, b : TimeseriesanomalyisolationPoint, t : Double) -> TimeseriesanomalyisolationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_anomaly_isolation_point_to_string(pt : TimeseriesanomalyisolationPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_isolation_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyisolationSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_anomaly_isolation_series_len(s : TimeseriesanomalyisolationSeries) -> Int { s.vals.length() }

pub fn timeseries_anomaly_isolation_series_sum(s : TimeseriesanomalyisolationSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_anomaly_isolation_series_mean(s : TimeseriesanomalyisolationSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_anomaly_isolation_series_min(s : TimeseriesanomalyisolationSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_anomaly_isolation_series_max(s : TimeseriesanomalyisolationSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_anomaly_isolation_series_range(s : TimeseriesanomalyisolationSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_anomaly_isolation_series_var(s : TimeseriesanomalyisolationSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_anomaly_isolation_series_std(s : TimeseriesanomalyisolationSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_anomaly_isolation_series_median(s : TimeseriesanomalyisolationSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_anomaly_isolation_series_scale(s : TimeseriesanomalyisolationSeries, f : Double) -> TimeseriesanomalyisolationSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_anomaly_isolation_series_add(a : TimeseriesanomalyisolationSeries, b : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_isolation_series_sub(a : TimeseriesanomalyisolationSeries, b : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_anomaly_isolation_series_normalize(s : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  let mn = timeseries_anomaly_isolation_series_min(s)
  let mx = timeseries_anomaly_isolation_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_anomaly_isolation_series_cumsum(s : TimeseriesanomalyisolationSeries) -> TimeseriesanomalyisolationSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_anomaly_isolation_series_to_string(s : TimeseriesanomalyisolationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyisolationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_isolation_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyisolationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_isolation_matrix_identity(n : Int) -> TimeseriesanomalyisolationMatrix {
  let m = timeseries_anomaly_isolation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_anomaly_isolation_matrix_get(m : TimeseriesanomalyisolationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_anomaly_isolation_matrix_transpose(m : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  let result = timeseries_anomaly_isolation_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_anomaly_isolation_matrix_add(a : TimeseriesanomalyisolationMatrix, b : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_anomaly_isolation_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_anomaly_isolation_matrix_scale(m : TimeseriesanomalyisolationMatrix, s : Double) -> TimeseriesanomalyisolationMatrix {
  let result = timeseries_anomaly_isolation_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_anomaly_isolation_matrix_multiply(a : TimeseriesanomalyisolationMatrix, b : TimeseriesanomalyisolationMatrix) -> TimeseriesanomalyisolationMatrix {
  if a.cols != b.rows { return timeseries_anomaly_isolation_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_anomaly_isolation_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_anomaly_isolation_matrix_trace(m : TimeseriesanomalyisolationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_anomaly_isolation_matrix_det(m : TimeseriesanomalyisolationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_anomaly_isolation_matrix_norm(m : TimeseriesanomalyisolationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_anomaly_isolation_matrix_to_string(m : TimeseriesanomalyisolationMatrix) -> String {
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

pub(all) struct TimeseriesanomalyisolationVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_isolation_make_vector(comps : Array[Double]) -> TimeseriesanomalyisolationVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_isolation_vector_zero(dim : Int) -> TimeseriesanomalyisolationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_anomaly_isolation_vector_add(a : TimeseriesanomalyisolationVector, b : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_isolation_vector_sub(a : TimeseriesanomalyisolationVector, b : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_anomaly_isolation_vector_scale(v : TimeseriesanomalyisolationVector, s : Double) -> TimeseriesanomalyisolationVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_anomaly_isolation_vector_dot(a : TimeseriesanomalyisolationVector, b : TimeseriesanomalyisolationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_anomaly_isolation_vector_norm(v : TimeseriesanomalyisolationVector) -> Double { @_common.sqrt(timeseries_anomaly_isolation_vector_dot(v, v)) }

pub fn timeseries_anomaly_isolation_vector_normalize(v : TimeseriesanomalyisolationVector) -> TimeseriesanomalyisolationVector {
  let n = timeseries_anomaly_isolation_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_anomaly_isolation_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_anomaly_isolation_vector_dist(a : TimeseriesanomalyisolationVector, b : TimeseriesanomalyisolationVector) -> Double {
  timeseries_anomaly_isolation_vector_norm(timeseries_anomaly_isolation_vector_sub(a, b))
}

pub fn timeseries_anomaly_isolation_vector_to_string(v : TimeseriesanomalyisolationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_isolation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_isolation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_isolation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_isolation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_isolation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_isolation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_isolation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_isolation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_isolation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_isolation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_isolation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_isolation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_isolation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_isolation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_isolation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_isolation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_isolation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_isolation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_isolation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_isolation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_isolation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_isolation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_isolation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_isolation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_isolation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_isolation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_isolation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_isolation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_isolation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyisolationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_frame_make(size : Int) -> TimeseriesanomalyisolationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_frame_len(s : TimeseriesanomalyisolationFrame) -> Int { s.size }

pub fn timeseries_anomaly_isolation_frame_get(s : TimeseriesanomalyisolationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_frame_set(s : TimeseriesanomalyisolationFrame, i : Int, v : Double) -> TimeseriesanomalyisolationFrame {
  let result = timeseries_anomaly_isolation_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_frame_sum(s : TimeseriesanomalyisolationFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_frame_mean(s : TimeseriesanomalyisolationFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_frame_scale(s : TimeseriesanomalyisolationFrame, f : Double) -> TimeseriesanomalyisolationFrame {
  let result = timeseries_anomaly_isolation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_frame_add(a : TimeseriesanomalyisolationFrame, b : TimeseriesanomalyisolationFrame) -> TimeseriesanomalyisolationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_frame_copy(s : TimeseriesanomalyisolationFrame) -> TimeseriesanomalyisolationFrame {
  let result = timeseries_anomaly_isolation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_frame_fill(s : TimeseriesanomalyisolationFrame, v : Double) -> TimeseriesanomalyisolationFrame {
  let result = timeseries_anomaly_isolation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_frame_min(s : TimeseriesanomalyisolationFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_frame_max(s : TimeseriesanomalyisolationFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_frame_to_string(s : TimeseriesanomalyisolationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_table_make(size : Int) -> TimeseriesanomalyisolationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_table_len(s : TimeseriesanomalyisolationTable) -> Int { s.size }

pub fn timeseries_anomaly_isolation_table_get(s : TimeseriesanomalyisolationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_table_set(s : TimeseriesanomalyisolationTable, i : Int, v : Double) -> TimeseriesanomalyisolationTable {
  let result = timeseries_anomaly_isolation_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_table_sum(s : TimeseriesanomalyisolationTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_table_mean(s : TimeseriesanomalyisolationTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_table_scale(s : TimeseriesanomalyisolationTable, f : Double) -> TimeseriesanomalyisolationTable {
  let result = timeseries_anomaly_isolation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_table_add(a : TimeseriesanomalyisolationTable, b : TimeseriesanomalyisolationTable) -> TimeseriesanomalyisolationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_table_copy(s : TimeseriesanomalyisolationTable) -> TimeseriesanomalyisolationTable {
  let result = timeseries_anomaly_isolation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_table_fill(s : TimeseriesanomalyisolationTable, v : Double) -> TimeseriesanomalyisolationTable {
  let result = timeseries_anomaly_isolation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_table_min(s : TimeseriesanomalyisolationTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_table_max(s : TimeseriesanomalyisolationTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_table_to_string(s : TimeseriesanomalyisolationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_graphn_make(size : Int) -> TimeseriesanomalyisolationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_graphn_len(s : TimeseriesanomalyisolationGraphN) -> Int { s.size }

pub fn timeseries_anomaly_isolation_graphn_get(s : TimeseriesanomalyisolationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_graphn_set(s : TimeseriesanomalyisolationGraphN, i : Int, v : Double) -> TimeseriesanomalyisolationGraphN {
  let result = timeseries_anomaly_isolation_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_graphn_sum(s : TimeseriesanomalyisolationGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_graphn_mean(s : TimeseriesanomalyisolationGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_graphn_scale(s : TimeseriesanomalyisolationGraphN, f : Double) -> TimeseriesanomalyisolationGraphN {
  let result = timeseries_anomaly_isolation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_graphn_add(a : TimeseriesanomalyisolationGraphN, b : TimeseriesanomalyisolationGraphN) -> TimeseriesanomalyisolationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_graphn_copy(s : TimeseriesanomalyisolationGraphN) -> TimeseriesanomalyisolationGraphN {
  let result = timeseries_anomaly_isolation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_graphn_fill(s : TimeseriesanomalyisolationGraphN, v : Double) -> TimeseriesanomalyisolationGraphN {
  let result = timeseries_anomaly_isolation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_graphn_min(s : TimeseriesanomalyisolationGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_graphn_max(s : TimeseriesanomalyisolationGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_graphn_to_string(s : TimeseriesanomalyisolationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_node_make(size : Int) -> TimeseriesanomalyisolationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_node_len(s : TimeseriesanomalyisolationNode) -> Int { s.size }

pub fn timeseries_anomaly_isolation_node_get(s : TimeseriesanomalyisolationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_node_set(s : TimeseriesanomalyisolationNode, i : Int, v : Double) -> TimeseriesanomalyisolationNode {
  let result = timeseries_anomaly_isolation_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_node_sum(s : TimeseriesanomalyisolationNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_node_mean(s : TimeseriesanomalyisolationNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_node_scale(s : TimeseriesanomalyisolationNode, f : Double) -> TimeseriesanomalyisolationNode {
  let result = timeseries_anomaly_isolation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_node_add(a : TimeseriesanomalyisolationNode, b : TimeseriesanomalyisolationNode) -> TimeseriesanomalyisolationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_node_copy(s : TimeseriesanomalyisolationNode) -> TimeseriesanomalyisolationNode {
  let result = timeseries_anomaly_isolation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_node_fill(s : TimeseriesanomalyisolationNode, v : Double) -> TimeseriesanomalyisolationNode {
  let result = timeseries_anomaly_isolation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_node_min(s : TimeseriesanomalyisolationNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_node_max(s : TimeseriesanomalyisolationNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_node_to_string(s : TimeseriesanomalyisolationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_edge_make(size : Int) -> TimeseriesanomalyisolationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_edge_len(s : TimeseriesanomalyisolationEdge) -> Int { s.size }

pub fn timeseries_anomaly_isolation_edge_get(s : TimeseriesanomalyisolationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_edge_set(s : TimeseriesanomalyisolationEdge, i : Int, v : Double) -> TimeseriesanomalyisolationEdge {
  let result = timeseries_anomaly_isolation_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_edge_sum(s : TimeseriesanomalyisolationEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_edge_mean(s : TimeseriesanomalyisolationEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_edge_scale(s : TimeseriesanomalyisolationEdge, f : Double) -> TimeseriesanomalyisolationEdge {
  let result = timeseries_anomaly_isolation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_edge_add(a : TimeseriesanomalyisolationEdge, b : TimeseriesanomalyisolationEdge) -> TimeseriesanomalyisolationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_edge_copy(s : TimeseriesanomalyisolationEdge) -> TimeseriesanomalyisolationEdge {
  let result = timeseries_anomaly_isolation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_edge_fill(s : TimeseriesanomalyisolationEdge, v : Double) -> TimeseriesanomalyisolationEdge {
  let result = timeseries_anomaly_isolation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_edge_min(s : TimeseriesanomalyisolationEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_edge_max(s : TimeseriesanomalyisolationEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_edge_to_string(s : TimeseriesanomalyisolationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_path_make(size : Int) -> TimeseriesanomalyisolationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_path_len(s : TimeseriesanomalyisolationPath) -> Int { s.size }

pub fn timeseries_anomaly_isolation_path_get(s : TimeseriesanomalyisolationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_path_set(s : TimeseriesanomalyisolationPath, i : Int, v : Double) -> TimeseriesanomalyisolationPath {
  let result = timeseries_anomaly_isolation_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_path_sum(s : TimeseriesanomalyisolationPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_path_mean(s : TimeseriesanomalyisolationPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_path_scale(s : TimeseriesanomalyisolationPath, f : Double) -> TimeseriesanomalyisolationPath {
  let result = timeseries_anomaly_isolation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_path_add(a : TimeseriesanomalyisolationPath, b : TimeseriesanomalyisolationPath) -> TimeseriesanomalyisolationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_path_copy(s : TimeseriesanomalyisolationPath) -> TimeseriesanomalyisolationPath {
  let result = timeseries_anomaly_isolation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_path_fill(s : TimeseriesanomalyisolationPath, v : Double) -> TimeseriesanomalyisolationPath {
  let result = timeseries_anomaly_isolation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_path_min(s : TimeseriesanomalyisolationPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_path_max(s : TimeseriesanomalyisolationPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_path_to_string(s : TimeseriesanomalyisolationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_cluster_make(size : Int) -> TimeseriesanomalyisolationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_cluster_len(s : TimeseriesanomalyisolationCluster) -> Int { s.size }

pub fn timeseries_anomaly_isolation_cluster_get(s : TimeseriesanomalyisolationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_cluster_set(s : TimeseriesanomalyisolationCluster, i : Int, v : Double) -> TimeseriesanomalyisolationCluster {
  let result = timeseries_anomaly_isolation_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_cluster_sum(s : TimeseriesanomalyisolationCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_cluster_mean(s : TimeseriesanomalyisolationCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_cluster_scale(s : TimeseriesanomalyisolationCluster, f : Double) -> TimeseriesanomalyisolationCluster {
  let result = timeseries_anomaly_isolation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_cluster_add(a : TimeseriesanomalyisolationCluster, b : TimeseriesanomalyisolationCluster) -> TimeseriesanomalyisolationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_cluster_copy(s : TimeseriesanomalyisolationCluster) -> TimeseriesanomalyisolationCluster {
  let result = timeseries_anomaly_isolation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_cluster_fill(s : TimeseriesanomalyisolationCluster, v : Double) -> TimeseriesanomalyisolationCluster {
  let result = timeseries_anomaly_isolation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_cluster_min(s : TimeseriesanomalyisolationCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_cluster_max(s : TimeseriesanomalyisolationCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_cluster_to_string(s : TimeseriesanomalyisolationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_model_make(size : Int) -> TimeseriesanomalyisolationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_model_len(s : TimeseriesanomalyisolationModel) -> Int { s.size }

pub fn timeseries_anomaly_isolation_model_get(s : TimeseriesanomalyisolationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_model_set(s : TimeseriesanomalyisolationModel, i : Int, v : Double) -> TimeseriesanomalyisolationModel {
  let result = timeseries_anomaly_isolation_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_model_sum(s : TimeseriesanomalyisolationModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_model_mean(s : TimeseriesanomalyisolationModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_model_scale(s : TimeseriesanomalyisolationModel, f : Double) -> TimeseriesanomalyisolationModel {
  let result = timeseries_anomaly_isolation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_model_add(a : TimeseriesanomalyisolationModel, b : TimeseriesanomalyisolationModel) -> TimeseriesanomalyisolationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_model_copy(s : TimeseriesanomalyisolationModel) -> TimeseriesanomalyisolationModel {
  let result = timeseries_anomaly_isolation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_model_fill(s : TimeseriesanomalyisolationModel, v : Double) -> TimeseriesanomalyisolationModel {
  let result = timeseries_anomaly_isolation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_model_min(s : TimeseriesanomalyisolationModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_model_max(s : TimeseriesanomalyisolationModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_model_to_string(s : TimeseriesanomalyisolationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_layer_make(size : Int) -> TimeseriesanomalyisolationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_layer_len(s : TimeseriesanomalyisolationLayer) -> Int { s.size }

pub fn timeseries_anomaly_isolation_layer_get(s : TimeseriesanomalyisolationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_layer_set(s : TimeseriesanomalyisolationLayer, i : Int, v : Double) -> TimeseriesanomalyisolationLayer {
  let result = timeseries_anomaly_isolation_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_layer_sum(s : TimeseriesanomalyisolationLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_layer_mean(s : TimeseriesanomalyisolationLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_layer_scale(s : TimeseriesanomalyisolationLayer, f : Double) -> TimeseriesanomalyisolationLayer {
  let result = timeseries_anomaly_isolation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_layer_add(a : TimeseriesanomalyisolationLayer, b : TimeseriesanomalyisolationLayer) -> TimeseriesanomalyisolationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_layer_copy(s : TimeseriesanomalyisolationLayer) -> TimeseriesanomalyisolationLayer {
  let result = timeseries_anomaly_isolation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_layer_fill(s : TimeseriesanomalyisolationLayer, v : Double) -> TimeseriesanomalyisolationLayer {
  let result = timeseries_anomaly_isolation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_layer_min(s : TimeseriesanomalyisolationLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_layer_max(s : TimeseriesanomalyisolationLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_layer_to_string(s : TimeseriesanomalyisolationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_buffer_make(size : Int) -> TimeseriesanomalyisolationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_buffer_len(s : TimeseriesanomalyisolationBuffer) -> Int { s.size }

pub fn timeseries_anomaly_isolation_buffer_get(s : TimeseriesanomalyisolationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_buffer_set(s : TimeseriesanomalyisolationBuffer, i : Int, v : Double) -> TimeseriesanomalyisolationBuffer {
  let result = timeseries_anomaly_isolation_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_buffer_sum(s : TimeseriesanomalyisolationBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_buffer_mean(s : TimeseriesanomalyisolationBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_buffer_scale(s : TimeseriesanomalyisolationBuffer, f : Double) -> TimeseriesanomalyisolationBuffer {
  let result = timeseries_anomaly_isolation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_buffer_add(a : TimeseriesanomalyisolationBuffer, b : TimeseriesanomalyisolationBuffer) -> TimeseriesanomalyisolationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_buffer_copy(s : TimeseriesanomalyisolationBuffer) -> TimeseriesanomalyisolationBuffer {
  let result = timeseries_anomaly_isolation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_buffer_fill(s : TimeseriesanomalyisolationBuffer, v : Double) -> TimeseriesanomalyisolationBuffer {
  let result = timeseries_anomaly_isolation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_buffer_min(s : TimeseriesanomalyisolationBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_buffer_max(s : TimeseriesanomalyisolationBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_buffer_to_string(s : TimeseriesanomalyisolationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_cursor_make(size : Int) -> TimeseriesanomalyisolationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_cursor_len(s : TimeseriesanomalyisolationCursor) -> Int { s.size }

pub fn timeseries_anomaly_isolation_cursor_get(s : TimeseriesanomalyisolationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_cursor_set(s : TimeseriesanomalyisolationCursor, i : Int, v : Double) -> TimeseriesanomalyisolationCursor {
  let result = timeseries_anomaly_isolation_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_cursor_sum(s : TimeseriesanomalyisolationCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_cursor_mean(s : TimeseriesanomalyisolationCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_cursor_scale(s : TimeseriesanomalyisolationCursor, f : Double) -> TimeseriesanomalyisolationCursor {
  let result = timeseries_anomaly_isolation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_cursor_add(a : TimeseriesanomalyisolationCursor, b : TimeseriesanomalyisolationCursor) -> TimeseriesanomalyisolationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_cursor_copy(s : TimeseriesanomalyisolationCursor) -> TimeseriesanomalyisolationCursor {
  let result = timeseries_anomaly_isolation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_cursor_fill(s : TimeseriesanomalyisolationCursor, v : Double) -> TimeseriesanomalyisolationCursor {
  let result = timeseries_anomaly_isolation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_cursor_min(s : TimeseriesanomalyisolationCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_cursor_max(s : TimeseriesanomalyisolationCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_cursor_to_string(s : TimeseriesanomalyisolationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_view_make(size : Int) -> TimeseriesanomalyisolationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_view_len(s : TimeseriesanomalyisolationView) -> Int { s.size }

pub fn timeseries_anomaly_isolation_view_get(s : TimeseriesanomalyisolationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_view_set(s : TimeseriesanomalyisolationView, i : Int, v : Double) -> TimeseriesanomalyisolationView {
  let result = timeseries_anomaly_isolation_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_view_sum(s : TimeseriesanomalyisolationView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_view_mean(s : TimeseriesanomalyisolationView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_view_scale(s : TimeseriesanomalyisolationView, f : Double) -> TimeseriesanomalyisolationView {
  let result = timeseries_anomaly_isolation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_view_add(a : TimeseriesanomalyisolationView, b : TimeseriesanomalyisolationView) -> TimeseriesanomalyisolationView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_view_copy(s : TimeseriesanomalyisolationView) -> TimeseriesanomalyisolationView {
  let result = timeseries_anomaly_isolation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_view_fill(s : TimeseriesanomalyisolationView, v : Double) -> TimeseriesanomalyisolationView {
  let result = timeseries_anomaly_isolation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_view_min(s : TimeseriesanomalyisolationView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_view_max(s : TimeseriesanomalyisolationView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_view_to_string(s : TimeseriesanomalyisolationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_range_make(size : Int) -> TimeseriesanomalyisolationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_range_len(s : TimeseriesanomalyisolationRange) -> Int { s.size }

pub fn timeseries_anomaly_isolation_range_get(s : TimeseriesanomalyisolationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_range_set(s : TimeseriesanomalyisolationRange, i : Int, v : Double) -> TimeseriesanomalyisolationRange {
  let result = timeseries_anomaly_isolation_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_range_sum(s : TimeseriesanomalyisolationRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_range_mean(s : TimeseriesanomalyisolationRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_range_scale(s : TimeseriesanomalyisolationRange, f : Double) -> TimeseriesanomalyisolationRange {
  let result = timeseries_anomaly_isolation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_range_add(a : TimeseriesanomalyisolationRange, b : TimeseriesanomalyisolationRange) -> TimeseriesanomalyisolationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_range_copy(s : TimeseriesanomalyisolationRange) -> TimeseriesanomalyisolationRange {
  let result = timeseries_anomaly_isolation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_range_fill(s : TimeseriesanomalyisolationRange, v : Double) -> TimeseriesanomalyisolationRange {
  let result = timeseries_anomaly_isolation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_range_min(s : TimeseriesanomalyisolationRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_range_max(s : TimeseriesanomalyisolationRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_range_to_string(s : TimeseriesanomalyisolationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyisolationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_isolation_slice_make(size : Int) -> TimeseriesanomalyisolationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_isolation_slice_len(s : TimeseriesanomalyisolationSlice) -> Int { s.size }

pub fn timeseries_anomaly_isolation_slice_get(s : TimeseriesanomalyisolationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_isolation_slice_set(s : TimeseriesanomalyisolationSlice, i : Int, v : Double) -> TimeseriesanomalyisolationSlice {
  let result = timeseries_anomaly_isolation_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_slice_sum(s : TimeseriesanomalyisolationSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_isolation_slice_mean(s : TimeseriesanomalyisolationSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_isolation_slice_scale(s : TimeseriesanomalyisolationSlice, f : Double) -> TimeseriesanomalyisolationSlice {
  let result = timeseries_anomaly_isolation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_anomaly_isolation_slice_add(a : TimeseriesanomalyisolationSlice, b : TimeseriesanomalyisolationSlice) -> TimeseriesanomalyisolationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_anomaly_isolation_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_slice_copy(s : TimeseriesanomalyisolationSlice) -> TimeseriesanomalyisolationSlice {
  let result = timeseries_anomaly_isolation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_anomaly_isolation_slice_fill(s : TimeseriesanomalyisolationSlice, v : Double) -> TimeseriesanomalyisolationSlice {
  let result = timeseries_anomaly_isolation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_anomaly_isolation_slice_min(s : TimeseriesanomalyisolationSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_isolation_slice_max(s : TimeseriesanomalyisolationSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_isolation_slice_to_string(s : TimeseriesanomalyisolationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

