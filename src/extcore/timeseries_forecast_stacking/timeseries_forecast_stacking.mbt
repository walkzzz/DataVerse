///===
/// extcore/timeseries_forecast_stacking

pub(all) struct TimeseriesforecaststackingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_stacking_make_point(x : Double, y : Double) -> TimeseriesforecaststackingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_stacking_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecaststackingPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_forecast_stacking_point_x(pt : TimeseriesforecaststackingPoint) -> Double { pt.x }

pub fn timeseries_forecast_stacking_point_y(pt : TimeseriesforecaststackingPoint) -> Double { pt.y }

pub fn timeseries_forecast_stacking_point_z(pt : TimeseriesforecaststackingPoint) -> Double { pt.z }

pub fn timeseries_forecast_stacking_point_label(pt : TimeseriesforecaststackingPoint) -> Int { pt.label }

pub fn timeseries_forecast_stacking_point_dist(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_forecast_stacking_point_add(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_forecast_stacking_point_sub(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_forecast_stacking_point_scale(pt : TimeseriesforecaststackingPoint, s : Double) -> TimeseriesforecaststackingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_forecast_stacking_point_dot(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_forecast_stacking_point_cross(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_forecast_stacking_point_norm(pt : TimeseriesforecaststackingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_forecast_stacking_point_normalize(pt : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  let n = timeseries_forecast_stacking_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_forecast_stacking_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_forecast_stacking_point_negate(pt : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_forecast_stacking_point_mid(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_forecast_stacking_point_lerp(a : TimeseriesforecaststackingPoint, b : TimeseriesforecaststackingPoint, t : Double) -> TimeseriesforecaststackingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_forecast_stacking_point_to_string(pt : TimeseriesforecaststackingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_stacking_make_series(vals : Array[Double], name : String) -> TimeseriesforecaststackingSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_forecast_stacking_series_len(s : TimeseriesforecaststackingSeries) -> Int { s.vals.length() }

pub fn timeseries_forecast_stacking_series_sum(s : TimeseriesforecaststackingSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_forecast_stacking_series_mean(s : TimeseriesforecaststackingSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_forecast_stacking_series_min(s : TimeseriesforecaststackingSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_forecast_stacking_series_max(s : TimeseriesforecaststackingSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_forecast_stacking_series_range(s : TimeseriesforecaststackingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_forecast_stacking_series_var(s : TimeseriesforecaststackingSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_forecast_stacking_series_std(s : TimeseriesforecaststackingSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_forecast_stacking_series_median(s : TimeseriesforecaststackingSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_forecast_stacking_series_scale(s : TimeseriesforecaststackingSeries, f : Double) -> TimeseriesforecaststackingSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn timeseries_forecast_stacking_series_add(a : TimeseriesforecaststackingSeries, b : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_stacking_series_sub(a : TimeseriesforecaststackingSeries, b : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_forecast_stacking_series_normalize(s : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  let mn = timeseries_forecast_stacking_series_min(s)
  let mx = timeseries_forecast_stacking_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_forecast_stacking_series_cumsum(s : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_forecast_stacking_series_to_string(s : TimeseriesforecaststackingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecaststackingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_stacking_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecaststackingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_stacking_matrix_identity(n : Int) -> TimeseriesforecaststackingMatrix {
  let m = timeseries_forecast_stacking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_forecast_stacking_matrix_get(m : TimeseriesforecaststackingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_forecast_stacking_matrix_transpose(m : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  let result = timeseries_forecast_stacking_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_forecast_stacking_matrix_add(a : TimeseriesforecaststackingMatrix, b : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_forecast_stacking_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_forecast_stacking_matrix_scale(m : TimeseriesforecaststackingMatrix, s : Double) -> TimeseriesforecaststackingMatrix {
  let result = timeseries_forecast_stacking_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_forecast_stacking_matrix_multiply(a : TimeseriesforecaststackingMatrix, b : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  if a.cols != b.rows { return timeseries_forecast_stacking_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_forecast_stacking_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_forecast_stacking_matrix_trace(m : TimeseriesforecaststackingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_forecast_stacking_matrix_det(m : TimeseriesforecaststackingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_forecast_stacking_matrix_norm(m : TimeseriesforecaststackingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_forecast_stacking_matrix_to_string(m : TimeseriesforecaststackingMatrix) -> String {
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

pub(all) struct TimeseriesforecaststackingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_stacking_make_vector(comps : Array[Double]) -> TimeseriesforecaststackingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_stacking_vector_zero(dim : Int) -> TimeseriesforecaststackingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_forecast_stacking_vector_add(a : TimeseriesforecaststackingVector, b : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_forecast_stacking_vector_sub(a : TimeseriesforecaststackingVector, b : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn timeseries_forecast_stacking_vector_scale(v : TimeseriesforecaststackingVector, s : Double) -> TimeseriesforecaststackingVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn timeseries_forecast_stacking_vector_dot(a : TimeseriesforecaststackingVector, b : TimeseriesforecaststackingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_forecast_stacking_vector_norm(v : TimeseriesforecaststackingVector) -> Double { @_common.sqrt(timeseries_forecast_stacking_vector_dot(v, v)) }

pub fn timeseries_forecast_stacking_vector_normalize(v : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = timeseries_forecast_stacking_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_forecast_stacking_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_forecast_stacking_vector_dist(a : TimeseriesforecaststackingVector, b : TimeseriesforecaststackingVector) -> Double {
  timeseries_forecast_stacking_vector_norm(timeseries_forecast_stacking_vector_sub(a, b))
}

pub fn timeseries_forecast_stacking_vector_to_string(v : TimeseriesforecaststackingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_stacking_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_stacking_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_stacking_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_stacking_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_stacking_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_stacking_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_stacking_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_stacking_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_stacking_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_stacking_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_stacking_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_stacking_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_stacking_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_stacking_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_stacking_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_stacking_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_stacking_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_stacking_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_stacking_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_stacking_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_stacking_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_stacking_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_stacking_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_stacking_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_stacking_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_stacking_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_stacking_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_stacking_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_stacking_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecaststackingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_frame_make(size : Int) -> TimeseriesforecaststackingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_frame_len(s : TimeseriesforecaststackingFrame) -> Int { s.size }

pub fn timeseries_forecast_stacking_frame_get(s : TimeseriesforecaststackingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_frame_set(s : TimeseriesforecaststackingFrame, i : Int, v : Double) -> TimeseriesforecaststackingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_frame_sum(s : TimeseriesforecaststackingFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_frame_mean(s : TimeseriesforecaststackingFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_frame_scale(s : TimeseriesforecaststackingFrame, f : Double) -> TimeseriesforecaststackingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_frame_add(a : TimeseriesforecaststackingFrame, b : TimeseriesforecaststackingFrame) -> TimeseriesforecaststackingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_frame_copy(s : TimeseriesforecaststackingFrame) -> TimeseriesforecaststackingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_frame_fill(s : TimeseriesforecaststackingFrame, v : Double) -> TimeseriesforecaststackingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_frame_min(s : TimeseriesforecaststackingFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_frame_max(s : TimeseriesforecaststackingFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_frame_to_string(s : TimeseriesforecaststackingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_table_make(size : Int) -> TimeseriesforecaststackingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_table_len(s : TimeseriesforecaststackingTable) -> Int { s.size }

pub fn timeseries_forecast_stacking_table_get(s : TimeseriesforecaststackingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_table_set(s : TimeseriesforecaststackingTable, i : Int, v : Double) -> TimeseriesforecaststackingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_table_sum(s : TimeseriesforecaststackingTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_table_mean(s : TimeseriesforecaststackingTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_table_scale(s : TimeseriesforecaststackingTable, f : Double) -> TimeseriesforecaststackingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_table_add(a : TimeseriesforecaststackingTable, b : TimeseriesforecaststackingTable) -> TimeseriesforecaststackingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_table_copy(s : TimeseriesforecaststackingTable) -> TimeseriesforecaststackingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_table_fill(s : TimeseriesforecaststackingTable, v : Double) -> TimeseriesforecaststackingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_table_min(s : TimeseriesforecaststackingTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_table_max(s : TimeseriesforecaststackingTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_table_to_string(s : TimeseriesforecaststackingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_graphn_make(size : Int) -> TimeseriesforecaststackingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_graphn_len(s : TimeseriesforecaststackingGraphN) -> Int { s.size }

pub fn timeseries_forecast_stacking_graphn_get(s : TimeseriesforecaststackingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_graphn_set(s : TimeseriesforecaststackingGraphN, i : Int, v : Double) -> TimeseriesforecaststackingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_graphn_sum(s : TimeseriesforecaststackingGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_graphn_mean(s : TimeseriesforecaststackingGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_graphn_scale(s : TimeseriesforecaststackingGraphN, f : Double) -> TimeseriesforecaststackingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_graphn_add(a : TimeseriesforecaststackingGraphN, b : TimeseriesforecaststackingGraphN) -> TimeseriesforecaststackingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_graphn_copy(s : TimeseriesforecaststackingGraphN) -> TimeseriesforecaststackingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_graphn_fill(s : TimeseriesforecaststackingGraphN, v : Double) -> TimeseriesforecaststackingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_graphn_min(s : TimeseriesforecaststackingGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_graphn_max(s : TimeseriesforecaststackingGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_graphn_to_string(s : TimeseriesforecaststackingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_node_make(size : Int) -> TimeseriesforecaststackingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_node_len(s : TimeseriesforecaststackingNode) -> Int { s.size }

pub fn timeseries_forecast_stacking_node_get(s : TimeseriesforecaststackingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_node_set(s : TimeseriesforecaststackingNode, i : Int, v : Double) -> TimeseriesforecaststackingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_node_sum(s : TimeseriesforecaststackingNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_node_mean(s : TimeseriesforecaststackingNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_node_scale(s : TimeseriesforecaststackingNode, f : Double) -> TimeseriesforecaststackingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_node_add(a : TimeseriesforecaststackingNode, b : TimeseriesforecaststackingNode) -> TimeseriesforecaststackingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_node_copy(s : TimeseriesforecaststackingNode) -> TimeseriesforecaststackingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_node_fill(s : TimeseriesforecaststackingNode, v : Double) -> TimeseriesforecaststackingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_node_min(s : TimeseriesforecaststackingNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_node_max(s : TimeseriesforecaststackingNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_node_to_string(s : TimeseriesforecaststackingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_edge_make(size : Int) -> TimeseriesforecaststackingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_edge_len(s : TimeseriesforecaststackingEdge) -> Int { s.size }

pub fn timeseries_forecast_stacking_edge_get(s : TimeseriesforecaststackingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_edge_set(s : TimeseriesforecaststackingEdge, i : Int, v : Double) -> TimeseriesforecaststackingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_edge_sum(s : TimeseriesforecaststackingEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_edge_mean(s : TimeseriesforecaststackingEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_edge_scale(s : TimeseriesforecaststackingEdge, f : Double) -> TimeseriesforecaststackingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_edge_add(a : TimeseriesforecaststackingEdge, b : TimeseriesforecaststackingEdge) -> TimeseriesforecaststackingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_edge_copy(s : TimeseriesforecaststackingEdge) -> TimeseriesforecaststackingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_edge_fill(s : TimeseriesforecaststackingEdge, v : Double) -> TimeseriesforecaststackingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_edge_min(s : TimeseriesforecaststackingEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_edge_max(s : TimeseriesforecaststackingEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_edge_to_string(s : TimeseriesforecaststackingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_path_make(size : Int) -> TimeseriesforecaststackingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_path_len(s : TimeseriesforecaststackingPath) -> Int { s.size }

pub fn timeseries_forecast_stacking_path_get(s : TimeseriesforecaststackingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_path_set(s : TimeseriesforecaststackingPath, i : Int, v : Double) -> TimeseriesforecaststackingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_path_sum(s : TimeseriesforecaststackingPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_path_mean(s : TimeseriesforecaststackingPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_path_scale(s : TimeseriesforecaststackingPath, f : Double) -> TimeseriesforecaststackingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_path_add(a : TimeseriesforecaststackingPath, b : TimeseriesforecaststackingPath) -> TimeseriesforecaststackingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_path_copy(s : TimeseriesforecaststackingPath) -> TimeseriesforecaststackingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_path_fill(s : TimeseriesforecaststackingPath, v : Double) -> TimeseriesforecaststackingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_path_min(s : TimeseriesforecaststackingPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_path_max(s : TimeseriesforecaststackingPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_path_to_string(s : TimeseriesforecaststackingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_cluster_make(size : Int) -> TimeseriesforecaststackingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_cluster_len(s : TimeseriesforecaststackingCluster) -> Int { s.size }

pub fn timeseries_forecast_stacking_cluster_get(s : TimeseriesforecaststackingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_cluster_set(s : TimeseriesforecaststackingCluster, i : Int, v : Double) -> TimeseriesforecaststackingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cluster_sum(s : TimeseriesforecaststackingCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_cluster_mean(s : TimeseriesforecaststackingCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_cluster_scale(s : TimeseriesforecaststackingCluster, f : Double) -> TimeseriesforecaststackingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cluster_add(a : TimeseriesforecaststackingCluster, b : TimeseriesforecaststackingCluster) -> TimeseriesforecaststackingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_cluster_copy(s : TimeseriesforecaststackingCluster) -> TimeseriesforecaststackingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cluster_fill(s : TimeseriesforecaststackingCluster, v : Double) -> TimeseriesforecaststackingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cluster_min(s : TimeseriesforecaststackingCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_cluster_max(s : TimeseriesforecaststackingCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_cluster_to_string(s : TimeseriesforecaststackingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_model_make(size : Int) -> TimeseriesforecaststackingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_model_len(s : TimeseriesforecaststackingModel) -> Int { s.size }

pub fn timeseries_forecast_stacking_model_get(s : TimeseriesforecaststackingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_model_set(s : TimeseriesforecaststackingModel, i : Int, v : Double) -> TimeseriesforecaststackingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_model_sum(s : TimeseriesforecaststackingModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_model_mean(s : TimeseriesforecaststackingModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_model_scale(s : TimeseriesforecaststackingModel, f : Double) -> TimeseriesforecaststackingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_model_add(a : TimeseriesforecaststackingModel, b : TimeseriesforecaststackingModel) -> TimeseriesforecaststackingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_model_copy(s : TimeseriesforecaststackingModel) -> TimeseriesforecaststackingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_model_fill(s : TimeseriesforecaststackingModel, v : Double) -> TimeseriesforecaststackingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_model_min(s : TimeseriesforecaststackingModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_model_max(s : TimeseriesforecaststackingModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_model_to_string(s : TimeseriesforecaststackingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_layer_make(size : Int) -> TimeseriesforecaststackingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_layer_len(s : TimeseriesforecaststackingLayer) -> Int { s.size }

pub fn timeseries_forecast_stacking_layer_get(s : TimeseriesforecaststackingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_layer_set(s : TimeseriesforecaststackingLayer, i : Int, v : Double) -> TimeseriesforecaststackingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_layer_sum(s : TimeseriesforecaststackingLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_layer_mean(s : TimeseriesforecaststackingLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_layer_scale(s : TimeseriesforecaststackingLayer, f : Double) -> TimeseriesforecaststackingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_layer_add(a : TimeseriesforecaststackingLayer, b : TimeseriesforecaststackingLayer) -> TimeseriesforecaststackingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_layer_copy(s : TimeseriesforecaststackingLayer) -> TimeseriesforecaststackingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_layer_fill(s : TimeseriesforecaststackingLayer, v : Double) -> TimeseriesforecaststackingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_layer_min(s : TimeseriesforecaststackingLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_layer_max(s : TimeseriesforecaststackingLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_layer_to_string(s : TimeseriesforecaststackingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_buffer_make(size : Int) -> TimeseriesforecaststackingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_buffer_len(s : TimeseriesforecaststackingBuffer) -> Int { s.size }

pub fn timeseries_forecast_stacking_buffer_get(s : TimeseriesforecaststackingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_buffer_set(s : TimeseriesforecaststackingBuffer, i : Int, v : Double) -> TimeseriesforecaststackingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_buffer_sum(s : TimeseriesforecaststackingBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_buffer_mean(s : TimeseriesforecaststackingBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_buffer_scale(s : TimeseriesforecaststackingBuffer, f : Double) -> TimeseriesforecaststackingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_buffer_add(a : TimeseriesforecaststackingBuffer, b : TimeseriesforecaststackingBuffer) -> TimeseriesforecaststackingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_buffer_copy(s : TimeseriesforecaststackingBuffer) -> TimeseriesforecaststackingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_buffer_fill(s : TimeseriesforecaststackingBuffer, v : Double) -> TimeseriesforecaststackingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_buffer_min(s : TimeseriesforecaststackingBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_buffer_max(s : TimeseriesforecaststackingBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_buffer_to_string(s : TimeseriesforecaststackingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_cursor_make(size : Int) -> TimeseriesforecaststackingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_cursor_len(s : TimeseriesforecaststackingCursor) -> Int { s.size }

pub fn timeseries_forecast_stacking_cursor_get(s : TimeseriesforecaststackingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_cursor_set(s : TimeseriesforecaststackingCursor, i : Int, v : Double) -> TimeseriesforecaststackingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cursor_sum(s : TimeseriesforecaststackingCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_cursor_mean(s : TimeseriesforecaststackingCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_cursor_scale(s : TimeseriesforecaststackingCursor, f : Double) -> TimeseriesforecaststackingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cursor_add(a : TimeseriesforecaststackingCursor, b : TimeseriesforecaststackingCursor) -> TimeseriesforecaststackingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_cursor_copy(s : TimeseriesforecaststackingCursor) -> TimeseriesforecaststackingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cursor_fill(s : TimeseriesforecaststackingCursor, v : Double) -> TimeseriesforecaststackingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cursor_min(s : TimeseriesforecaststackingCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_cursor_max(s : TimeseriesforecaststackingCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_cursor_to_string(s : TimeseriesforecaststackingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_view_make(size : Int) -> TimeseriesforecaststackingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_view_len(s : TimeseriesforecaststackingView) -> Int { s.size }

pub fn timeseries_forecast_stacking_view_get(s : TimeseriesforecaststackingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_view_set(s : TimeseriesforecaststackingView, i : Int, v : Double) -> TimeseriesforecaststackingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_view_sum(s : TimeseriesforecaststackingView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_view_mean(s : TimeseriesforecaststackingView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_view_scale(s : TimeseriesforecaststackingView, f : Double) -> TimeseriesforecaststackingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_view_add(a : TimeseriesforecaststackingView, b : TimeseriesforecaststackingView) -> TimeseriesforecaststackingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_view_copy(s : TimeseriesforecaststackingView) -> TimeseriesforecaststackingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_view_fill(s : TimeseriesforecaststackingView, v : Double) -> TimeseriesforecaststackingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_view_min(s : TimeseriesforecaststackingView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_view_max(s : TimeseriesforecaststackingView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_view_to_string(s : TimeseriesforecaststackingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_range_make(size : Int) -> TimeseriesforecaststackingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_range_len(s : TimeseriesforecaststackingRange) -> Int { s.size }

pub fn timeseries_forecast_stacking_range_get(s : TimeseriesforecaststackingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_range_set(s : TimeseriesforecaststackingRange, i : Int, v : Double) -> TimeseriesforecaststackingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_range_sum(s : TimeseriesforecaststackingRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_range_mean(s : TimeseriesforecaststackingRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_range_scale(s : TimeseriesforecaststackingRange, f : Double) -> TimeseriesforecaststackingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_range_add(a : TimeseriesforecaststackingRange, b : TimeseriesforecaststackingRange) -> TimeseriesforecaststackingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_range_copy(s : TimeseriesforecaststackingRange) -> TimeseriesforecaststackingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_range_fill(s : TimeseriesforecaststackingRange, v : Double) -> TimeseriesforecaststackingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_range_min(s : TimeseriesforecaststackingRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_range_max(s : TimeseriesforecaststackingRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_range_to_string(s : TimeseriesforecaststackingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_slice_make(size : Int) -> TimeseriesforecaststackingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_slice_len(s : TimeseriesforecaststackingSlice) -> Int { s.size }

pub fn timeseries_forecast_stacking_slice_get(s : TimeseriesforecaststackingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_slice_set(s : TimeseriesforecaststackingSlice, i : Int, v : Double) -> TimeseriesforecaststackingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_slice_sum(s : TimeseriesforecaststackingSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_slice_mean(s : TimeseriesforecaststackingSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_slice_scale(s : TimeseriesforecaststackingSlice, f : Double) -> TimeseriesforecaststackingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_slice_add(a : TimeseriesforecaststackingSlice, b : TimeseriesforecaststackingSlice) -> TimeseriesforecaststackingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_slice_copy(s : TimeseriesforecaststackingSlice) -> TimeseriesforecaststackingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_slice_fill(s : TimeseriesforecaststackingSlice, v : Double) -> TimeseriesforecaststackingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_slice_min(s : TimeseriesforecaststackingSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_slice_max(s : TimeseriesforecaststackingSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_slice_to_string(s : TimeseriesforecaststackingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

