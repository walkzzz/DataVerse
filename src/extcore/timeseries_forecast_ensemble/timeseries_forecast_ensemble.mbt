///===
/// extcore/timeseries_forecast_ensemble

pub(all) struct TimeseriesforecastensemblePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_ensemble_make_point(x : Double, y : Double) -> TimeseriesforecastensemblePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_ensemble_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastensemblePoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_ensemble_point_x(pt : TimeseriesforecastensemblePoint) -> Double { pt.x }

pub fn timeseries_forecast_ensemble_point_y(pt : TimeseriesforecastensemblePoint) -> Double { pt.y }

pub fn timeseries_forecast_ensemble_point_z(pt : TimeseriesforecastensemblePoint) -> Double { pt.z }

pub fn timeseries_forecast_ensemble_point_label(pt : TimeseriesforecastensemblePoint) -> Int { pt.label }

pub fn timeseries_forecast_ensemble_point_dist(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_ensemble_point_add(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_ensemble_point_sub(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_ensemble_point_scale(pt : TimeseriesforecastensemblePoint, s : Double) -> TimeseriesforecastensemblePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_ensemble_point_dot(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_ensemble_point_cross(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_ensemble_point_norm(pt : TimeseriesforecastensemblePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_ensemble_point_normalize(pt : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  let n = timeseries_forecast_ensemble_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_ensemble_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_ensemble_point_negate(pt : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_ensemble_point_mid(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_ensemble_point_lerp(a : TimeseriesforecastensemblePoint, b : TimeseriesforecastensemblePoint, t : Double) -> TimeseriesforecastensemblePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_ensemble_point_to_string(pt : TimeseriesforecastensemblePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_ensemble_make_series(vals : Array[Double], name : String) -> TimeseriesforecastensembleSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_ensemble_series_len(s : TimeseriesforecastensembleSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_ensemble_series_sum(s : TimeseriesforecastensembleSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_forecast_ensemble_series_mean(s : TimeseriesforecastensembleSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_ensemble_series_min(s : TimeseriesforecastensembleSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_ensemble_series_max(s : TimeseriesforecastensembleSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_ensemble_series_range(s : TimeseriesforecastensembleSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_ensemble_series_var(s : TimeseriesforecastensembleSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_ensemble_series_std(s : TimeseriesforecastensembleSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_ensemble_series_median(s : TimeseriesforecastensembleSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_ensemble_series_scale(s : TimeseriesforecastensembleSeries, f : Double) -> TimeseriesforecastensembleSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_ensemble_series_add(a : TimeseriesforecastensembleSeries, b : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_ensemble_series_sub(a : TimeseriesforecastensembleSeries, b : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_ensemble_series_normalize(s : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  let mn = timeseries_forecast_ensemble_series_min(s)
  let mx = timeseries_forecast_ensemble_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_ensemble_series_cumsum(s : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_ensemble_series_to_string(s : TimeseriesforecastensembleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastensembleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_ensemble_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastensembleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_ensemble_matrix_identity(n : Int) -> TimeseriesforecastensembleMatrix {
  let m = timeseries_forecast_ensemble_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_ensemble_matrix_get(m : TimeseriesforecastensembleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_ensemble_matrix_transpose(m : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  let result = timeseries_forecast_ensemble_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_ensemble_matrix_add(a : TimeseriesforecastensembleMatrix, b : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_ensemble_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_ensemble_matrix_scale(m : TimeseriesforecastensembleMatrix, s : Double) -> TimeseriesforecastensembleMatrix {
  let result = timeseries_forecast_ensemble_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_ensemble_matrix_multiply(a : TimeseriesforecastensembleMatrix, b : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  if a.cols != b.rows { return timeseries_forecast_ensemble_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_ensemble_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_ensemble_matrix_trace(m : TimeseriesforecastensembleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_ensemble_matrix_det(m : TimeseriesforecastensembleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_ensemble_matrix_norm(m : TimeseriesforecastensembleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_ensemble_matrix_to_string(m : TimeseriesforecastensembleMatrix) -> String {
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

pub(all) struct TimeseriesforecastensembleVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_ensemble_make_vector(comps : Array[Double]) -> TimeseriesforecastensembleVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_ensemble_vector_zero(dim : Int) -> TimeseriesforecastensembleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_ensemble_vector_add(a : TimeseriesforecastensembleVector, b : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_forecast_ensemble_vector_sub(a : TimeseriesforecastensembleVector, b : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_forecast_ensemble_vector_scale(v : TimeseriesforecastensembleVector, s : Double) -> TimeseriesforecastensembleVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn timeseries_forecast_ensemble_vector_dot(a : TimeseriesforecastensembleVector, b : TimeseriesforecastensembleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_ensemble_vector_norm(v : TimeseriesforecastensembleVector) -> Double { @_common.sqrt(timeseries_forecast_ensemble_vector_dot(v, v)) }

pub fn timeseries_forecast_ensemble_vector_normalize(v : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = timeseries_forecast_ensemble_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_ensemble_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_ensemble_vector_dist(a : TimeseriesforecastensembleVector, b : TimeseriesforecastensembleVector) -> Double {
  timeseries_forecast_ensemble_vector_norm(timeseries_forecast_ensemble_vector_sub(a, b))
}

pub fn timeseries_forecast_ensemble_vector_to_string(v : TimeseriesforecastensembleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_ensemble_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_ensemble_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_ensemble_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_ensemble_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_ensemble_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_ensemble_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_ensemble_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_ensemble_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_ensemble_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_ensemble_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_ensemble_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_ensemble_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_ensemble_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_ensemble_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_ensemble_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_ensemble_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_ensemble_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_ensemble_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_ensemble_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_ensemble_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_ensemble_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_ensemble_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_ensemble_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_ensemble_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_ensemble_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_ensemble_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_ensemble_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_ensemble_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_ensemble_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastensembleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_frame_make(size : Int) -> TimeseriesforecastensembleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_frame_len(s : TimeseriesforecastensembleFrame) -> Int { s.size }

pub fn timeseries_forecast_ensemble_frame_get(s : TimeseriesforecastensembleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_frame_set(s : TimeseriesforecastensembleFrame, i : Int, v : Double) -> TimeseriesforecastensembleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_frame_sum(s : TimeseriesforecastensembleFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_frame_mean(s : TimeseriesforecastensembleFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_frame_scale(s : TimeseriesforecastensembleFrame, f : Double) -> TimeseriesforecastensembleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_frame_add(a : TimeseriesforecastensembleFrame, b : TimeseriesforecastensembleFrame) -> TimeseriesforecastensembleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_frame_copy(s : TimeseriesforecastensembleFrame) -> TimeseriesforecastensembleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_frame_fill(s : TimeseriesforecastensembleFrame, v : Double) -> TimeseriesforecastensembleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_frame_min(s : TimeseriesforecastensembleFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_frame_max(s : TimeseriesforecastensembleFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_frame_to_string(s : TimeseriesforecastensembleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_table_make(size : Int) -> TimeseriesforecastensembleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_table_len(s : TimeseriesforecastensembleTable) -> Int { s.size }

pub fn timeseries_forecast_ensemble_table_get(s : TimeseriesforecastensembleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_table_set(s : TimeseriesforecastensembleTable, i : Int, v : Double) -> TimeseriesforecastensembleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_table_sum(s : TimeseriesforecastensembleTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_table_mean(s : TimeseriesforecastensembleTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_table_scale(s : TimeseriesforecastensembleTable, f : Double) -> TimeseriesforecastensembleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_table_add(a : TimeseriesforecastensembleTable, b : TimeseriesforecastensembleTable) -> TimeseriesforecastensembleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_table_copy(s : TimeseriesforecastensembleTable) -> TimeseriesforecastensembleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_table_fill(s : TimeseriesforecastensembleTable, v : Double) -> TimeseriesforecastensembleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_table_min(s : TimeseriesforecastensembleTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_table_max(s : TimeseriesforecastensembleTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_table_to_string(s : TimeseriesforecastensembleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_graphn_make(size : Int) -> TimeseriesforecastensembleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_graphn_len(s : TimeseriesforecastensembleGraphN) -> Int { s.size }

pub fn timeseries_forecast_ensemble_graphn_get(s : TimeseriesforecastensembleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_graphn_set(s : TimeseriesforecastensembleGraphN, i : Int, v : Double) -> TimeseriesforecastensembleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_graphn_sum(s : TimeseriesforecastensembleGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_graphn_mean(s : TimeseriesforecastensembleGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_graphn_scale(s : TimeseriesforecastensembleGraphN, f : Double) -> TimeseriesforecastensembleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_graphn_add(a : TimeseriesforecastensembleGraphN, b : TimeseriesforecastensembleGraphN) -> TimeseriesforecastensembleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_graphn_copy(s : TimeseriesforecastensembleGraphN) -> TimeseriesforecastensembleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_graphn_fill(s : TimeseriesforecastensembleGraphN, v : Double) -> TimeseriesforecastensembleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_graphn_min(s : TimeseriesforecastensembleGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_graphn_max(s : TimeseriesforecastensembleGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_graphn_to_string(s : TimeseriesforecastensembleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_node_make(size : Int) -> TimeseriesforecastensembleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_node_len(s : TimeseriesforecastensembleNode) -> Int { s.size }

pub fn timeseries_forecast_ensemble_node_get(s : TimeseriesforecastensembleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_node_set(s : TimeseriesforecastensembleNode, i : Int, v : Double) -> TimeseriesforecastensembleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_node_sum(s : TimeseriesforecastensembleNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_node_mean(s : TimeseriesforecastensembleNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_node_scale(s : TimeseriesforecastensembleNode, f : Double) -> TimeseriesforecastensembleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_node_add(a : TimeseriesforecastensembleNode, b : TimeseriesforecastensembleNode) -> TimeseriesforecastensembleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_node_copy(s : TimeseriesforecastensembleNode) -> TimeseriesforecastensembleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_node_fill(s : TimeseriesforecastensembleNode, v : Double) -> TimeseriesforecastensembleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_node_min(s : TimeseriesforecastensembleNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_node_max(s : TimeseriesforecastensembleNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_node_to_string(s : TimeseriesforecastensembleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_edge_make(size : Int) -> TimeseriesforecastensembleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_edge_len(s : TimeseriesforecastensembleEdge) -> Int { s.size }

pub fn timeseries_forecast_ensemble_edge_get(s : TimeseriesforecastensembleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_edge_set(s : TimeseriesforecastensembleEdge, i : Int, v : Double) -> TimeseriesforecastensembleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_edge_sum(s : TimeseriesforecastensembleEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_edge_mean(s : TimeseriesforecastensembleEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_edge_scale(s : TimeseriesforecastensembleEdge, f : Double) -> TimeseriesforecastensembleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_edge_add(a : TimeseriesforecastensembleEdge, b : TimeseriesforecastensembleEdge) -> TimeseriesforecastensembleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_edge_copy(s : TimeseriesforecastensembleEdge) -> TimeseriesforecastensembleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_edge_fill(s : TimeseriesforecastensembleEdge, v : Double) -> TimeseriesforecastensembleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_edge_min(s : TimeseriesforecastensembleEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_edge_max(s : TimeseriesforecastensembleEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_edge_to_string(s : TimeseriesforecastensembleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensemblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_path_make(size : Int) -> TimeseriesforecastensemblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_path_len(s : TimeseriesforecastensemblePath) -> Int { s.size }

pub fn timeseries_forecast_ensemble_path_get(s : TimeseriesforecastensemblePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_path_set(s : TimeseriesforecastensemblePath, i : Int, v : Double) -> TimeseriesforecastensemblePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_path_sum(s : TimeseriesforecastensemblePath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_path_mean(s : TimeseriesforecastensemblePath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_path_scale(s : TimeseriesforecastensemblePath, f : Double) -> TimeseriesforecastensemblePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_path_add(a : TimeseriesforecastensemblePath, b : TimeseriesforecastensemblePath) -> TimeseriesforecastensemblePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_path_copy(s : TimeseriesforecastensemblePath) -> TimeseriesforecastensemblePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_path_fill(s : TimeseriesforecastensemblePath, v : Double) -> TimeseriesforecastensemblePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_path_min(s : TimeseriesforecastensemblePath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_path_max(s : TimeseriesforecastensemblePath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_path_to_string(s : TimeseriesforecastensemblePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_cluster_make(size : Int) -> TimeseriesforecastensembleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_cluster_len(s : TimeseriesforecastensembleCluster) -> Int { s.size }

pub fn timeseries_forecast_ensemble_cluster_get(s : TimeseriesforecastensembleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_cluster_set(s : TimeseriesforecastensembleCluster, i : Int, v : Double) -> TimeseriesforecastensembleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cluster_sum(s : TimeseriesforecastensembleCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_cluster_mean(s : TimeseriesforecastensembleCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_cluster_scale(s : TimeseriesforecastensembleCluster, f : Double) -> TimeseriesforecastensembleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cluster_add(a : TimeseriesforecastensembleCluster, b : TimeseriesforecastensembleCluster) -> TimeseriesforecastensembleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_cluster_copy(s : TimeseriesforecastensembleCluster) -> TimeseriesforecastensembleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cluster_fill(s : TimeseriesforecastensembleCluster, v : Double) -> TimeseriesforecastensembleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cluster_min(s : TimeseriesforecastensembleCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_cluster_max(s : TimeseriesforecastensembleCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_cluster_to_string(s : TimeseriesforecastensembleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_model_make(size : Int) -> TimeseriesforecastensembleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_model_len(s : TimeseriesforecastensembleModel) -> Int { s.size }

pub fn timeseries_forecast_ensemble_model_get(s : TimeseriesforecastensembleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_model_set(s : TimeseriesforecastensembleModel, i : Int, v : Double) -> TimeseriesforecastensembleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_model_sum(s : TimeseriesforecastensembleModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_model_mean(s : TimeseriesforecastensembleModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_model_scale(s : TimeseriesforecastensembleModel, f : Double) -> TimeseriesforecastensembleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_model_add(a : TimeseriesforecastensembleModel, b : TimeseriesforecastensembleModel) -> TimeseriesforecastensembleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_model_copy(s : TimeseriesforecastensembleModel) -> TimeseriesforecastensembleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_model_fill(s : TimeseriesforecastensembleModel, v : Double) -> TimeseriesforecastensembleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_model_min(s : TimeseriesforecastensembleModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_model_max(s : TimeseriesforecastensembleModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_model_to_string(s : TimeseriesforecastensembleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_layer_make(size : Int) -> TimeseriesforecastensembleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_layer_len(s : TimeseriesforecastensembleLayer) -> Int { s.size }

pub fn timeseries_forecast_ensemble_layer_get(s : TimeseriesforecastensembleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_layer_set(s : TimeseriesforecastensembleLayer, i : Int, v : Double) -> TimeseriesforecastensembleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_layer_sum(s : TimeseriesforecastensembleLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_layer_mean(s : TimeseriesforecastensembleLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_layer_scale(s : TimeseriesforecastensembleLayer, f : Double) -> TimeseriesforecastensembleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_layer_add(a : TimeseriesforecastensembleLayer, b : TimeseriesforecastensembleLayer) -> TimeseriesforecastensembleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_layer_copy(s : TimeseriesforecastensembleLayer) -> TimeseriesforecastensembleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_layer_fill(s : TimeseriesforecastensembleLayer, v : Double) -> TimeseriesforecastensembleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_layer_min(s : TimeseriesforecastensembleLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_layer_max(s : TimeseriesforecastensembleLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_layer_to_string(s : TimeseriesforecastensembleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_buffer_make(size : Int) -> TimeseriesforecastensembleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_buffer_len(s : TimeseriesforecastensembleBuffer) -> Int { s.size }

pub fn timeseries_forecast_ensemble_buffer_get(s : TimeseriesforecastensembleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_buffer_set(s : TimeseriesforecastensembleBuffer, i : Int, v : Double) -> TimeseriesforecastensembleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_buffer_sum(s : TimeseriesforecastensembleBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_buffer_mean(s : TimeseriesforecastensembleBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_buffer_scale(s : TimeseriesforecastensembleBuffer, f : Double) -> TimeseriesforecastensembleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_buffer_add(a : TimeseriesforecastensembleBuffer, b : TimeseriesforecastensembleBuffer) -> TimeseriesforecastensembleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_buffer_copy(s : TimeseriesforecastensembleBuffer) -> TimeseriesforecastensembleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_buffer_fill(s : TimeseriesforecastensembleBuffer, v : Double) -> TimeseriesforecastensembleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_buffer_min(s : TimeseriesforecastensembleBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_buffer_max(s : TimeseriesforecastensembleBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_buffer_to_string(s : TimeseriesforecastensembleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_cursor_make(size : Int) -> TimeseriesforecastensembleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_cursor_len(s : TimeseriesforecastensembleCursor) -> Int { s.size }

pub fn timeseries_forecast_ensemble_cursor_get(s : TimeseriesforecastensembleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_cursor_set(s : TimeseriesforecastensembleCursor, i : Int, v : Double) -> TimeseriesforecastensembleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cursor_sum(s : TimeseriesforecastensembleCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_cursor_mean(s : TimeseriesforecastensembleCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_cursor_scale(s : TimeseriesforecastensembleCursor, f : Double) -> TimeseriesforecastensembleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cursor_add(a : TimeseriesforecastensembleCursor, b : TimeseriesforecastensembleCursor) -> TimeseriesforecastensembleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_cursor_copy(s : TimeseriesforecastensembleCursor) -> TimeseriesforecastensembleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cursor_fill(s : TimeseriesforecastensembleCursor, v : Double) -> TimeseriesforecastensembleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cursor_min(s : TimeseriesforecastensembleCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_cursor_max(s : TimeseriesforecastensembleCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_cursor_to_string(s : TimeseriesforecastensembleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_view_make(size : Int) -> TimeseriesforecastensembleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_view_len(s : TimeseriesforecastensembleView) -> Int { s.size }

pub fn timeseries_forecast_ensemble_view_get(s : TimeseriesforecastensembleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_view_set(s : TimeseriesforecastensembleView, i : Int, v : Double) -> TimeseriesforecastensembleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_view_sum(s : TimeseriesforecastensembleView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_view_mean(s : TimeseriesforecastensembleView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_view_scale(s : TimeseriesforecastensembleView, f : Double) -> TimeseriesforecastensembleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_view_add(a : TimeseriesforecastensembleView, b : TimeseriesforecastensembleView) -> TimeseriesforecastensembleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_view_copy(s : TimeseriesforecastensembleView) -> TimeseriesforecastensembleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_view_fill(s : TimeseriesforecastensembleView, v : Double) -> TimeseriesforecastensembleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_view_min(s : TimeseriesforecastensembleView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_view_max(s : TimeseriesforecastensembleView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_view_to_string(s : TimeseriesforecastensembleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_range_make(size : Int) -> TimeseriesforecastensembleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_range_len(s : TimeseriesforecastensembleRange) -> Int { s.size }

pub fn timeseries_forecast_ensemble_range_get(s : TimeseriesforecastensembleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_range_set(s : TimeseriesforecastensembleRange, i : Int, v : Double) -> TimeseriesforecastensembleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_range_sum(s : TimeseriesforecastensembleRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_range_mean(s : TimeseriesforecastensembleRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_range_scale(s : TimeseriesforecastensembleRange, f : Double) -> TimeseriesforecastensembleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_range_add(a : TimeseriesforecastensembleRange, b : TimeseriesforecastensembleRange) -> TimeseriesforecastensembleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_range_copy(s : TimeseriesforecastensembleRange) -> TimeseriesforecastensembleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_range_fill(s : TimeseriesforecastensembleRange, v : Double) -> TimeseriesforecastensembleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_range_min(s : TimeseriesforecastensembleRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_range_max(s : TimeseriesforecastensembleRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_range_to_string(s : TimeseriesforecastensembleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_slice_make(size : Int) -> TimeseriesforecastensembleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_slice_len(s : TimeseriesforecastensembleSlice) -> Int { s.size }

pub fn timeseries_forecast_ensemble_slice_get(s : TimeseriesforecastensembleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_slice_set(s : TimeseriesforecastensembleSlice, i : Int, v : Double) -> TimeseriesforecastensembleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_slice_sum(s : TimeseriesforecastensembleSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_slice_mean(s : TimeseriesforecastensembleSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_slice_scale(s : TimeseriesforecastensembleSlice, f : Double) -> TimeseriesforecastensembleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_slice_add(a : TimeseriesforecastensembleSlice, b : TimeseriesforecastensembleSlice) -> TimeseriesforecastensembleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_slice_copy(s : TimeseriesforecastensembleSlice) -> TimeseriesforecastensembleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_slice_fill(s : TimeseriesforecastensembleSlice, v : Double) -> TimeseriesforecastensembleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_slice_min(s : TimeseriesforecastensembleSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_slice_max(s : TimeseriesforecastensembleSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_slice_to_string(s : TimeseriesforecastensembleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

