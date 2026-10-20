///===
/// extcore/timeseries_decomp_moving

pub(all) struct TimeseriesdecompmovingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_moving_make_point(x : Double, y : Double) -> TimeseriesdecompmovingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_moving_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompmovingPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_moving_point_x(pt : TimeseriesdecompmovingPoint) -> Double { pt.x }

pub fn timeseries_decomp_moving_point_y(pt : TimeseriesdecompmovingPoint) -> Double { pt.y }

pub fn timeseries_decomp_moving_point_z(pt : TimeseriesdecompmovingPoint) -> Double { pt.z }

pub fn timeseries_decomp_moving_point_label(pt : TimeseriesdecompmovingPoint) -> Int { pt.label }

pub fn timeseries_decomp_moving_point_dist(a : TimeseriesdecompmovingPoint, b : TimeseriesdecompmovingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_moving_point_add(a : TimeseriesdecompmovingPoint, b : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_moving_point_sub(a : TimeseriesdecompmovingPoint, b : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_moving_point_scale(pt : TimeseriesdecompmovingPoint, s : Double) -> TimeseriesdecompmovingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_moving_point_dot(a : TimeseriesdecompmovingPoint, b : TimeseriesdecompmovingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_moving_point_cross(a : TimeseriesdecompmovingPoint, b : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_moving_point_norm(pt : TimeseriesdecompmovingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_moving_point_normalize(pt : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  let n = timeseries_decomp_moving_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_moving_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_moving_point_negate(pt : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_moving_point_mid(a : TimeseriesdecompmovingPoint, b : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_moving_point_lerp(a : TimeseriesdecompmovingPoint, b : TimeseriesdecompmovingPoint, t : Double) -> TimeseriesdecompmovingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_moving_point_to_string(pt : TimeseriesdecompmovingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_moving_make_series(vals : Array[Double], name : String) -> TimeseriesdecompmovingSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_moving_series_len(s : TimeseriesdecompmovingSeries) -> Int { s.vals.length() }

pub fn timeseries_decomp_moving_series_sum(s : TimeseriesdecompmovingSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_decomp_moving_series_mean(s : TimeseriesdecompmovingSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_decomp_moving_series_min(s : TimeseriesdecompmovingSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_decomp_moving_series_max(s : TimeseriesdecompmovingSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_decomp_moving_series_range(s : TimeseriesdecompmovingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_decomp_moving_series_var(s : TimeseriesdecompmovingSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_decomp_moving_series_std(s : TimeseriesdecompmovingSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_decomp_moving_series_median(s : TimeseriesdecompmovingSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_decomp_moving_series_scale(s : TimeseriesdecompmovingSeries, f : Double) -> TimeseriesdecompmovingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_moving_series_add(a : TimeseriesdecompmovingSeries, b : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_moving_series_sub(a : TimeseriesdecompmovingSeries, b : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_moving_series_normalize(s : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  let mn = timeseries_decomp_moving_series_min(s)
  let mx = timeseries_decomp_moving_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_moving_series_cumsum(s : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_moving_series_to_string(s : TimeseriesdecompmovingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompmovingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_moving_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompmovingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_moving_matrix_identity(n : Int) -> TimeseriesdecompmovingMatrix {
  let m = timeseries_decomp_moving_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_moving_matrix_get(m : TimeseriesdecompmovingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_moving_matrix_transpose(m : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  let result = timeseries_decomp_moving_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_moving_matrix_add(a : TimeseriesdecompmovingMatrix, b : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_moving_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_moving_matrix_scale(m : TimeseriesdecompmovingMatrix, s : Double) -> TimeseriesdecompmovingMatrix {
  let result = timeseries_decomp_moving_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_moving_matrix_multiply(a : TimeseriesdecompmovingMatrix, b : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  if a.cols != b.rows { return timeseries_decomp_moving_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_moving_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_moving_matrix_trace(m : TimeseriesdecompmovingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_moving_matrix_det(m : TimeseriesdecompmovingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_moving_matrix_norm(m : TimeseriesdecompmovingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_decomp_moving_matrix_to_string(m : TimeseriesdecompmovingMatrix) -> String {
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

pub(all) struct TimeseriesdecompmovingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_moving_make_vector(comps : Array[Double]) -> TimeseriesdecompmovingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_moving_vector_zero(dim : Int) -> TimeseriesdecompmovingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_moving_vector_add(a : TimeseriesdecompmovingVector, b : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_moving_vector_sub(a : TimeseriesdecompmovingVector, b : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_moving_vector_scale(v : TimeseriesdecompmovingVector, s : Double) -> TimeseriesdecompmovingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_moving_vector_dot(a : TimeseriesdecompmovingVector, b : TimeseriesdecompmovingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_moving_vector_norm(v : TimeseriesdecompmovingVector) -> Double { @_common.sqrt(timeseries_decomp_moving_vector_dot(v, v)) }

pub fn timeseries_decomp_moving_vector_normalize(v : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = timeseries_decomp_moving_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_moving_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_moving_vector_dist(a : TimeseriesdecompmovingVector, b : TimeseriesdecompmovingVector) -> Double {
  timeseries_decomp_moving_vector_norm(timeseries_decomp_moving_vector_sub(a, b))
}

pub fn timeseries_decomp_moving_vector_to_string(v : TimeseriesdecompmovingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_moving_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_moving_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_moving_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_moving_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_moving_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_moving_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_moving_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_moving_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_moving_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_moving_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_moving_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_moving_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_moving_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_moving_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_moving_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_moving_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_moving_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_moving_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_moving_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_moving_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_moving_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_moving_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_moving_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_moving_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_moving_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_moving_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_moving_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_moving_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_moving_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompmovingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_frame_make(size : Int) -> TimeseriesdecompmovingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_frame_len(s : TimeseriesdecompmovingFrame) -> Int { s.size }

pub fn timeseries_decomp_moving_frame_get(s : TimeseriesdecompmovingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_frame_set(s : TimeseriesdecompmovingFrame, i : Int, v : Double) -> TimeseriesdecompmovingFrame {
  let result = timeseries_decomp_moving_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_frame_sum(s : TimeseriesdecompmovingFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_frame_mean(s : TimeseriesdecompmovingFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_frame_scale(s : TimeseriesdecompmovingFrame, f : Double) -> TimeseriesdecompmovingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_frame_add(a : TimeseriesdecompmovingFrame, b : TimeseriesdecompmovingFrame) -> TimeseriesdecompmovingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_frame_copy(s : TimeseriesdecompmovingFrame) -> TimeseriesdecompmovingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_frame_fill(s : TimeseriesdecompmovingFrame, v : Double) -> TimeseriesdecompmovingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_frame_min(s : TimeseriesdecompmovingFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_frame_max(s : TimeseriesdecompmovingFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_frame_to_string(s : TimeseriesdecompmovingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_table_make(size : Int) -> TimeseriesdecompmovingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_table_len(s : TimeseriesdecompmovingTable) -> Int { s.size }

pub fn timeseries_decomp_moving_table_get(s : TimeseriesdecompmovingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_table_set(s : TimeseriesdecompmovingTable, i : Int, v : Double) -> TimeseriesdecompmovingTable {
  let result = timeseries_decomp_moving_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_table_sum(s : TimeseriesdecompmovingTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_table_mean(s : TimeseriesdecompmovingTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_table_scale(s : TimeseriesdecompmovingTable, f : Double) -> TimeseriesdecompmovingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_table_add(a : TimeseriesdecompmovingTable, b : TimeseriesdecompmovingTable) -> TimeseriesdecompmovingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_table_copy(s : TimeseriesdecompmovingTable) -> TimeseriesdecompmovingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_table_fill(s : TimeseriesdecompmovingTable, v : Double) -> TimeseriesdecompmovingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_table_min(s : TimeseriesdecompmovingTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_table_max(s : TimeseriesdecompmovingTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_table_to_string(s : TimeseriesdecompmovingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_graphn_make(size : Int) -> TimeseriesdecompmovingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_graphn_len(s : TimeseriesdecompmovingGraphN) -> Int { s.size }

pub fn timeseries_decomp_moving_graphn_get(s : TimeseriesdecompmovingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_graphn_set(s : TimeseriesdecompmovingGraphN, i : Int, v : Double) -> TimeseriesdecompmovingGraphN {
  let result = timeseries_decomp_moving_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_graphn_sum(s : TimeseriesdecompmovingGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_graphn_mean(s : TimeseriesdecompmovingGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_graphn_scale(s : TimeseriesdecompmovingGraphN, f : Double) -> TimeseriesdecompmovingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_graphn_add(a : TimeseriesdecompmovingGraphN, b : TimeseriesdecompmovingGraphN) -> TimeseriesdecompmovingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_graphn_copy(s : TimeseriesdecompmovingGraphN) -> TimeseriesdecompmovingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_graphn_fill(s : TimeseriesdecompmovingGraphN, v : Double) -> TimeseriesdecompmovingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_graphn_min(s : TimeseriesdecompmovingGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_graphn_max(s : TimeseriesdecompmovingGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_graphn_to_string(s : TimeseriesdecompmovingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_node_make(size : Int) -> TimeseriesdecompmovingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_node_len(s : TimeseriesdecompmovingNode) -> Int { s.size }

pub fn timeseries_decomp_moving_node_get(s : TimeseriesdecompmovingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_node_set(s : TimeseriesdecompmovingNode, i : Int, v : Double) -> TimeseriesdecompmovingNode {
  let result = timeseries_decomp_moving_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_node_sum(s : TimeseriesdecompmovingNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_node_mean(s : TimeseriesdecompmovingNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_node_scale(s : TimeseriesdecompmovingNode, f : Double) -> TimeseriesdecompmovingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_node_add(a : TimeseriesdecompmovingNode, b : TimeseriesdecompmovingNode) -> TimeseriesdecompmovingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_node_copy(s : TimeseriesdecompmovingNode) -> TimeseriesdecompmovingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_node_fill(s : TimeseriesdecompmovingNode, v : Double) -> TimeseriesdecompmovingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_node_min(s : TimeseriesdecompmovingNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_node_max(s : TimeseriesdecompmovingNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_node_to_string(s : TimeseriesdecompmovingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_edge_make(size : Int) -> TimeseriesdecompmovingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_edge_len(s : TimeseriesdecompmovingEdge) -> Int { s.size }

pub fn timeseries_decomp_moving_edge_get(s : TimeseriesdecompmovingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_edge_set(s : TimeseriesdecompmovingEdge, i : Int, v : Double) -> TimeseriesdecompmovingEdge {
  let result = timeseries_decomp_moving_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_edge_sum(s : TimeseriesdecompmovingEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_edge_mean(s : TimeseriesdecompmovingEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_edge_scale(s : TimeseriesdecompmovingEdge, f : Double) -> TimeseriesdecompmovingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_edge_add(a : TimeseriesdecompmovingEdge, b : TimeseriesdecompmovingEdge) -> TimeseriesdecompmovingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_edge_copy(s : TimeseriesdecompmovingEdge) -> TimeseriesdecompmovingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_edge_fill(s : TimeseriesdecompmovingEdge, v : Double) -> TimeseriesdecompmovingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_edge_min(s : TimeseriesdecompmovingEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_edge_max(s : TimeseriesdecompmovingEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_edge_to_string(s : TimeseriesdecompmovingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_path_make(size : Int) -> TimeseriesdecompmovingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_path_len(s : TimeseriesdecompmovingPath) -> Int { s.size }

pub fn timeseries_decomp_moving_path_get(s : TimeseriesdecompmovingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_path_set(s : TimeseriesdecompmovingPath, i : Int, v : Double) -> TimeseriesdecompmovingPath {
  let result = timeseries_decomp_moving_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_path_sum(s : TimeseriesdecompmovingPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_path_mean(s : TimeseriesdecompmovingPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_path_scale(s : TimeseriesdecompmovingPath, f : Double) -> TimeseriesdecompmovingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_path_add(a : TimeseriesdecompmovingPath, b : TimeseriesdecompmovingPath) -> TimeseriesdecompmovingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_path_copy(s : TimeseriesdecompmovingPath) -> TimeseriesdecompmovingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_path_fill(s : TimeseriesdecompmovingPath, v : Double) -> TimeseriesdecompmovingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_path_min(s : TimeseriesdecompmovingPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_path_max(s : TimeseriesdecompmovingPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_path_to_string(s : TimeseriesdecompmovingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_cluster_make(size : Int) -> TimeseriesdecompmovingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_cluster_len(s : TimeseriesdecompmovingCluster) -> Int { s.size }

pub fn timeseries_decomp_moving_cluster_get(s : TimeseriesdecompmovingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_cluster_set(s : TimeseriesdecompmovingCluster, i : Int, v : Double) -> TimeseriesdecompmovingCluster {
  let result = timeseries_decomp_moving_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_cluster_sum(s : TimeseriesdecompmovingCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_cluster_mean(s : TimeseriesdecompmovingCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_cluster_scale(s : TimeseriesdecompmovingCluster, f : Double) -> TimeseriesdecompmovingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cluster_add(a : TimeseriesdecompmovingCluster, b : TimeseriesdecompmovingCluster) -> TimeseriesdecompmovingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_cluster_copy(s : TimeseriesdecompmovingCluster) -> TimeseriesdecompmovingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cluster_fill(s : TimeseriesdecompmovingCluster, v : Double) -> TimeseriesdecompmovingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cluster_min(s : TimeseriesdecompmovingCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_cluster_max(s : TimeseriesdecompmovingCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_cluster_to_string(s : TimeseriesdecompmovingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_model_make(size : Int) -> TimeseriesdecompmovingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_model_len(s : TimeseriesdecompmovingModel) -> Int { s.size }

pub fn timeseries_decomp_moving_model_get(s : TimeseriesdecompmovingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_model_set(s : TimeseriesdecompmovingModel, i : Int, v : Double) -> TimeseriesdecompmovingModel {
  let result = timeseries_decomp_moving_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_model_sum(s : TimeseriesdecompmovingModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_model_mean(s : TimeseriesdecompmovingModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_model_scale(s : TimeseriesdecompmovingModel, f : Double) -> TimeseriesdecompmovingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_model_add(a : TimeseriesdecompmovingModel, b : TimeseriesdecompmovingModel) -> TimeseriesdecompmovingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_model_copy(s : TimeseriesdecompmovingModel) -> TimeseriesdecompmovingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_model_fill(s : TimeseriesdecompmovingModel, v : Double) -> TimeseriesdecompmovingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_model_min(s : TimeseriesdecompmovingModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_model_max(s : TimeseriesdecompmovingModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_model_to_string(s : TimeseriesdecompmovingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_layer_make(size : Int) -> TimeseriesdecompmovingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_layer_len(s : TimeseriesdecompmovingLayer) -> Int { s.size }

pub fn timeseries_decomp_moving_layer_get(s : TimeseriesdecompmovingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_layer_set(s : TimeseriesdecompmovingLayer, i : Int, v : Double) -> TimeseriesdecompmovingLayer {
  let result = timeseries_decomp_moving_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_layer_sum(s : TimeseriesdecompmovingLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_layer_mean(s : TimeseriesdecompmovingLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_layer_scale(s : TimeseriesdecompmovingLayer, f : Double) -> TimeseriesdecompmovingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_layer_add(a : TimeseriesdecompmovingLayer, b : TimeseriesdecompmovingLayer) -> TimeseriesdecompmovingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_layer_copy(s : TimeseriesdecompmovingLayer) -> TimeseriesdecompmovingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_layer_fill(s : TimeseriesdecompmovingLayer, v : Double) -> TimeseriesdecompmovingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_layer_min(s : TimeseriesdecompmovingLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_layer_max(s : TimeseriesdecompmovingLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_layer_to_string(s : TimeseriesdecompmovingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_buffer_make(size : Int) -> TimeseriesdecompmovingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_buffer_len(s : TimeseriesdecompmovingBuffer) -> Int { s.size }

pub fn timeseries_decomp_moving_buffer_get(s : TimeseriesdecompmovingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_buffer_set(s : TimeseriesdecompmovingBuffer, i : Int, v : Double) -> TimeseriesdecompmovingBuffer {
  let result = timeseries_decomp_moving_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_buffer_sum(s : TimeseriesdecompmovingBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_buffer_mean(s : TimeseriesdecompmovingBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_buffer_scale(s : TimeseriesdecompmovingBuffer, f : Double) -> TimeseriesdecompmovingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_buffer_add(a : TimeseriesdecompmovingBuffer, b : TimeseriesdecompmovingBuffer) -> TimeseriesdecompmovingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_buffer_copy(s : TimeseriesdecompmovingBuffer) -> TimeseriesdecompmovingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_buffer_fill(s : TimeseriesdecompmovingBuffer, v : Double) -> TimeseriesdecompmovingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_buffer_min(s : TimeseriesdecompmovingBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_buffer_max(s : TimeseriesdecompmovingBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_buffer_to_string(s : TimeseriesdecompmovingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_cursor_make(size : Int) -> TimeseriesdecompmovingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_cursor_len(s : TimeseriesdecompmovingCursor) -> Int { s.size }

pub fn timeseries_decomp_moving_cursor_get(s : TimeseriesdecompmovingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_cursor_set(s : TimeseriesdecompmovingCursor, i : Int, v : Double) -> TimeseriesdecompmovingCursor {
  let result = timeseries_decomp_moving_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_cursor_sum(s : TimeseriesdecompmovingCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_cursor_mean(s : TimeseriesdecompmovingCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_cursor_scale(s : TimeseriesdecompmovingCursor, f : Double) -> TimeseriesdecompmovingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cursor_add(a : TimeseriesdecompmovingCursor, b : TimeseriesdecompmovingCursor) -> TimeseriesdecompmovingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_cursor_copy(s : TimeseriesdecompmovingCursor) -> TimeseriesdecompmovingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cursor_fill(s : TimeseriesdecompmovingCursor, v : Double) -> TimeseriesdecompmovingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cursor_min(s : TimeseriesdecompmovingCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_cursor_max(s : TimeseriesdecompmovingCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_cursor_to_string(s : TimeseriesdecompmovingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_view_make(size : Int) -> TimeseriesdecompmovingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_view_len(s : TimeseriesdecompmovingView) -> Int { s.size }

pub fn timeseries_decomp_moving_view_get(s : TimeseriesdecompmovingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_view_set(s : TimeseriesdecompmovingView, i : Int, v : Double) -> TimeseriesdecompmovingView {
  let result = timeseries_decomp_moving_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_view_sum(s : TimeseriesdecompmovingView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_view_mean(s : TimeseriesdecompmovingView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_view_scale(s : TimeseriesdecompmovingView, f : Double) -> TimeseriesdecompmovingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_view_add(a : TimeseriesdecompmovingView, b : TimeseriesdecompmovingView) -> TimeseriesdecompmovingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_view_copy(s : TimeseriesdecompmovingView) -> TimeseriesdecompmovingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_view_fill(s : TimeseriesdecompmovingView, v : Double) -> TimeseriesdecompmovingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_view_min(s : TimeseriesdecompmovingView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_view_max(s : TimeseriesdecompmovingView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_view_to_string(s : TimeseriesdecompmovingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_range_make(size : Int) -> TimeseriesdecompmovingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_range_len(s : TimeseriesdecompmovingRange) -> Int { s.size }

pub fn timeseries_decomp_moving_range_get(s : TimeseriesdecompmovingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_range_set(s : TimeseriesdecompmovingRange, i : Int, v : Double) -> TimeseriesdecompmovingRange {
  let result = timeseries_decomp_moving_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_range_sum(s : TimeseriesdecompmovingRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_range_mean(s : TimeseriesdecompmovingRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_range_scale(s : TimeseriesdecompmovingRange, f : Double) -> TimeseriesdecompmovingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_range_add(a : TimeseriesdecompmovingRange, b : TimeseriesdecompmovingRange) -> TimeseriesdecompmovingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_range_copy(s : TimeseriesdecompmovingRange) -> TimeseriesdecompmovingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_range_fill(s : TimeseriesdecompmovingRange, v : Double) -> TimeseriesdecompmovingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_range_min(s : TimeseriesdecompmovingRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_range_max(s : TimeseriesdecompmovingRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_range_to_string(s : TimeseriesdecompmovingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_slice_make(size : Int) -> TimeseriesdecompmovingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_slice_len(s : TimeseriesdecompmovingSlice) -> Int { s.size }

pub fn timeseries_decomp_moving_slice_get(s : TimeseriesdecompmovingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_slice_set(s : TimeseriesdecompmovingSlice, i : Int, v : Double) -> TimeseriesdecompmovingSlice {
  let result = timeseries_decomp_moving_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_moving_slice_sum(s : TimeseriesdecompmovingSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_slice_mean(s : TimeseriesdecompmovingSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_slice_scale(s : TimeseriesdecompmovingSlice, f : Double) -> TimeseriesdecompmovingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_slice_add(a : TimeseriesdecompmovingSlice, b : TimeseriesdecompmovingSlice) -> TimeseriesdecompmovingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_slice_copy(s : TimeseriesdecompmovingSlice) -> TimeseriesdecompmovingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_slice_fill(s : TimeseriesdecompmovingSlice, v : Double) -> TimeseriesdecompmovingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_slice_min(s : TimeseriesdecompmovingSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_slice_max(s : TimeseriesdecompmovingSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_slice_to_string(s : TimeseriesdecompmovingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

