///===
/// extcore/timeseries_garch

pub(all) struct TimeseriesgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_garch_make_point(x : Double, y : Double) -> TimeseriesgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_garch_make_point3(x : Double, y : Double, z : Double) -> TimeseriesgarchPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_garch_point_x(pt : TimeseriesgarchPoint) -> Double { pt.x }

pub fn timeseries_garch_point_y(pt : TimeseriesgarchPoint) -> Double { pt.y }

pub fn timeseries_garch_point_z(pt : TimeseriesgarchPoint) -> Double { pt.z }

pub fn timeseries_garch_point_label(pt : TimeseriesgarchPoint) -> Int { pt.label }

pub fn timeseries_garch_point_dist(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_garch_point_add(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_garch_point_sub(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_garch_point_scale(pt : TimeseriesgarchPoint, s : Double) -> TimeseriesgarchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_garch_point_dot(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_garch_point_cross(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_garch_point_norm(pt : TimeseriesgarchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_garch_point_normalize(pt : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  let n = timeseries_garch_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_garch_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_garch_point_negate(pt : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_garch_point_mid(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_garch_point_lerp(a : TimeseriesgarchPoint, b : TimeseriesgarchPoint, t : Double) -> TimeseriesgarchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_garch_point_to_string(pt : TimeseriesgarchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_garch_make_series(vals : Array[Double], name : String) -> TimeseriesgarchSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_garch_series_len(s : TimeseriesgarchSeries) -> Int { s.vals.length() }

pub fn timeseries_garch_series_sum(s : TimeseriesgarchSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_garch_series_mean(s : TimeseriesgarchSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_garch_series_min(s : TimeseriesgarchSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_garch_series_max(s : TimeseriesgarchSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_garch_series_range(s : TimeseriesgarchSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_garch_series_var(s : TimeseriesgarchSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_garch_series_std(s : TimeseriesgarchSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_garch_series_median(s : TimeseriesgarchSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_garch_series_scale(s : TimeseriesgarchSeries, f : Double) -> TimeseriesgarchSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_garch_series_add(a : TimeseriesgarchSeries, b : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_garch_series_sub(a : TimeseriesgarchSeries, b : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_garch_series_normalize(s : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let mn = timeseries_garch_series_min(s)
  let mx = timeseries_garch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_garch_series_cumsum(s : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_garch_series_to_string(s : TimeseriesgarchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_garch_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesgarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_garch_matrix_identity(n : Int) -> TimeseriesgarchMatrix {
  let m = timeseries_garch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_garch_matrix_get(m : TimeseriesgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_garch_matrix_transpose(m : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  let result = timeseries_garch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_garch_matrix_add(a : TimeseriesgarchMatrix, b : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_garch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_garch_matrix_scale(m : TimeseriesgarchMatrix, s : Double) -> TimeseriesgarchMatrix {
  let result = timeseries_garch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_garch_matrix_multiply(a : TimeseriesgarchMatrix, b : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  if a.cols != b.rows { return timeseries_garch_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_garch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_garch_matrix_trace(m : TimeseriesgarchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_garch_matrix_det(m : TimeseriesgarchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_garch_matrix_norm(m : TimeseriesgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_garch_matrix_to_string(m : TimeseriesgarchMatrix) -> String {
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

pub(all) struct TimeseriesgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_garch_make_vector(comps : Array[Double]) -> TimeseriesgarchVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_garch_vector_zero(dim : Int) -> TimeseriesgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_garch_vector_add(a : TimeseriesgarchVector, b : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_garch_vector_sub(a : TimeseriesgarchVector, b : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_garch_vector_scale(v : TimeseriesgarchVector, s : Double) -> TimeseriesgarchVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_garch_vector_dot(a : TimeseriesgarchVector, b : TimeseriesgarchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_garch_vector_norm(v : TimeseriesgarchVector) -> Double { @_common.sqrt(timeseries_garch_vector_dot(v, v)) }

pub fn timeseries_garch_vector_normalize(v : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = timeseries_garch_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_garch_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_garch_vector_dist(a : TimeseriesgarchVector, b : TimeseriesgarchVector) -> Double {
  timeseries_garch_vector_norm(timeseries_garch_vector_sub(a, b))
}

pub fn timeseries_garch_vector_to_string(v : TimeseriesgarchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_garch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_garch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_garch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_garch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_garch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_garch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_garch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_garch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_garch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_garch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_garch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_garch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_garch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_garch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_garch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_garch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_garch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_garch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_garch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_garch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_garch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_garch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_garch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_garch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_garch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_garch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_garch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_garch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_garch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_frame_make(size : Int) -> TimeseriesgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_frame_len(s : TimeseriesgarchFrame) -> Int { s.size }

pub fn timeseries_garch_frame_get(s : TimeseriesgarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_frame_set(s : TimeseriesgarchFrame, i : Int, v : Double) -> TimeseriesgarchFrame {
  let result = timeseries_garch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_frame_sum(s : TimeseriesgarchFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_frame_mean(s : TimeseriesgarchFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_frame_scale(s : TimeseriesgarchFrame, f : Double) -> TimeseriesgarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_frame_add(a : TimeseriesgarchFrame, b : TimeseriesgarchFrame) -> TimeseriesgarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_frame_copy(s : TimeseriesgarchFrame) -> TimeseriesgarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_frame_fill(s : TimeseriesgarchFrame, v : Double) -> TimeseriesgarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_frame_min(s : TimeseriesgarchFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_frame_max(s : TimeseriesgarchFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_frame_to_string(s : TimeseriesgarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_table_make(size : Int) -> TimeseriesgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_table_len(s : TimeseriesgarchTable) -> Int { s.size }

pub fn timeseries_garch_table_get(s : TimeseriesgarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_table_set(s : TimeseriesgarchTable, i : Int, v : Double) -> TimeseriesgarchTable {
  let result = timeseries_garch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_table_sum(s : TimeseriesgarchTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_table_mean(s : TimeseriesgarchTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_table_scale(s : TimeseriesgarchTable, f : Double) -> TimeseriesgarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_table_add(a : TimeseriesgarchTable, b : TimeseriesgarchTable) -> TimeseriesgarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_table_copy(s : TimeseriesgarchTable) -> TimeseriesgarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_table_fill(s : TimeseriesgarchTable, v : Double) -> TimeseriesgarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_table_min(s : TimeseriesgarchTable) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_table_max(s : TimeseriesgarchTable) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_table_to_string(s : TimeseriesgarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_graphn_make(size : Int) -> TimeseriesgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_graphn_len(s : TimeseriesgarchGraphN) -> Int { s.size }

pub fn timeseries_garch_graphn_get(s : TimeseriesgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_graphn_set(s : TimeseriesgarchGraphN, i : Int, v : Double) -> TimeseriesgarchGraphN {
  let result = timeseries_garch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_graphn_sum(s : TimeseriesgarchGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_graphn_mean(s : TimeseriesgarchGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_graphn_scale(s : TimeseriesgarchGraphN, f : Double) -> TimeseriesgarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_graphn_add(a : TimeseriesgarchGraphN, b : TimeseriesgarchGraphN) -> TimeseriesgarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_graphn_copy(s : TimeseriesgarchGraphN) -> TimeseriesgarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_graphn_fill(s : TimeseriesgarchGraphN, v : Double) -> TimeseriesgarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_graphn_min(s : TimeseriesgarchGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_graphn_max(s : TimeseriesgarchGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_graphn_to_string(s : TimeseriesgarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_node_make(size : Int) -> TimeseriesgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_node_len(s : TimeseriesgarchNode) -> Int { s.size }

pub fn timeseries_garch_node_get(s : TimeseriesgarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_node_set(s : TimeseriesgarchNode, i : Int, v : Double) -> TimeseriesgarchNode {
  let result = timeseries_garch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_node_sum(s : TimeseriesgarchNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_node_mean(s : TimeseriesgarchNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_node_scale(s : TimeseriesgarchNode, f : Double) -> TimeseriesgarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_node_add(a : TimeseriesgarchNode, b : TimeseriesgarchNode) -> TimeseriesgarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_node_copy(s : TimeseriesgarchNode) -> TimeseriesgarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_node_fill(s : TimeseriesgarchNode, v : Double) -> TimeseriesgarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_node_min(s : TimeseriesgarchNode) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_node_max(s : TimeseriesgarchNode) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_node_to_string(s : TimeseriesgarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_edge_make(size : Int) -> TimeseriesgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_edge_len(s : TimeseriesgarchEdge) -> Int { s.size }

pub fn timeseries_garch_edge_get(s : TimeseriesgarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_edge_set(s : TimeseriesgarchEdge, i : Int, v : Double) -> TimeseriesgarchEdge {
  let result = timeseries_garch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_edge_sum(s : TimeseriesgarchEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_edge_mean(s : TimeseriesgarchEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_edge_scale(s : TimeseriesgarchEdge, f : Double) -> TimeseriesgarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_edge_add(a : TimeseriesgarchEdge, b : TimeseriesgarchEdge) -> TimeseriesgarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_edge_copy(s : TimeseriesgarchEdge) -> TimeseriesgarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_edge_fill(s : TimeseriesgarchEdge, v : Double) -> TimeseriesgarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_edge_min(s : TimeseriesgarchEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_edge_max(s : TimeseriesgarchEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_edge_to_string(s : TimeseriesgarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_path_make(size : Int) -> TimeseriesgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_path_len(s : TimeseriesgarchPath) -> Int { s.size }

pub fn timeseries_garch_path_get(s : TimeseriesgarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_path_set(s : TimeseriesgarchPath, i : Int, v : Double) -> TimeseriesgarchPath {
  let result = timeseries_garch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_path_sum(s : TimeseriesgarchPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_path_mean(s : TimeseriesgarchPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_path_scale(s : TimeseriesgarchPath, f : Double) -> TimeseriesgarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_path_add(a : TimeseriesgarchPath, b : TimeseriesgarchPath) -> TimeseriesgarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_path_copy(s : TimeseriesgarchPath) -> TimeseriesgarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_path_fill(s : TimeseriesgarchPath, v : Double) -> TimeseriesgarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_path_min(s : TimeseriesgarchPath) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_path_max(s : TimeseriesgarchPath) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_path_to_string(s : TimeseriesgarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_cluster_make(size : Int) -> TimeseriesgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_cluster_len(s : TimeseriesgarchCluster) -> Int { s.size }

pub fn timeseries_garch_cluster_get(s : TimeseriesgarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_cluster_set(s : TimeseriesgarchCluster, i : Int, v : Double) -> TimeseriesgarchCluster {
  let result = timeseries_garch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_cluster_sum(s : TimeseriesgarchCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_cluster_mean(s : TimeseriesgarchCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_cluster_scale(s : TimeseriesgarchCluster, f : Double) -> TimeseriesgarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cluster_add(a : TimeseriesgarchCluster, b : TimeseriesgarchCluster) -> TimeseriesgarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_cluster_copy(s : TimeseriesgarchCluster) -> TimeseriesgarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cluster_fill(s : TimeseriesgarchCluster, v : Double) -> TimeseriesgarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cluster_min(s : TimeseriesgarchCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_cluster_max(s : TimeseriesgarchCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_cluster_to_string(s : TimeseriesgarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_model_make(size : Int) -> TimeseriesgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_model_len(s : TimeseriesgarchModel) -> Int { s.size }

pub fn timeseries_garch_model_get(s : TimeseriesgarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_model_set(s : TimeseriesgarchModel, i : Int, v : Double) -> TimeseriesgarchModel {
  let result = timeseries_garch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_model_sum(s : TimeseriesgarchModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_model_mean(s : TimeseriesgarchModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_model_scale(s : TimeseriesgarchModel, f : Double) -> TimeseriesgarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_model_add(a : TimeseriesgarchModel, b : TimeseriesgarchModel) -> TimeseriesgarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_model_copy(s : TimeseriesgarchModel) -> TimeseriesgarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_model_fill(s : TimeseriesgarchModel, v : Double) -> TimeseriesgarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_model_min(s : TimeseriesgarchModel) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_model_max(s : TimeseriesgarchModel) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_model_to_string(s : TimeseriesgarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_layer_make(size : Int) -> TimeseriesgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_layer_len(s : TimeseriesgarchLayer) -> Int { s.size }

pub fn timeseries_garch_layer_get(s : TimeseriesgarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_layer_set(s : TimeseriesgarchLayer, i : Int, v : Double) -> TimeseriesgarchLayer {
  let result = timeseries_garch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_layer_sum(s : TimeseriesgarchLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_layer_mean(s : TimeseriesgarchLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_layer_scale(s : TimeseriesgarchLayer, f : Double) -> TimeseriesgarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_layer_add(a : TimeseriesgarchLayer, b : TimeseriesgarchLayer) -> TimeseriesgarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_layer_copy(s : TimeseriesgarchLayer) -> TimeseriesgarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_layer_fill(s : TimeseriesgarchLayer, v : Double) -> TimeseriesgarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_layer_min(s : TimeseriesgarchLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_layer_max(s : TimeseriesgarchLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_layer_to_string(s : TimeseriesgarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_buffer_make(size : Int) -> TimeseriesgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_buffer_len(s : TimeseriesgarchBuffer) -> Int { s.size }

pub fn timeseries_garch_buffer_get(s : TimeseriesgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_buffer_set(s : TimeseriesgarchBuffer, i : Int, v : Double) -> TimeseriesgarchBuffer {
  let result = timeseries_garch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_buffer_sum(s : TimeseriesgarchBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_buffer_mean(s : TimeseriesgarchBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_buffer_scale(s : TimeseriesgarchBuffer, f : Double) -> TimeseriesgarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_buffer_add(a : TimeseriesgarchBuffer, b : TimeseriesgarchBuffer) -> TimeseriesgarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_buffer_copy(s : TimeseriesgarchBuffer) -> TimeseriesgarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_buffer_fill(s : TimeseriesgarchBuffer, v : Double) -> TimeseriesgarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_buffer_min(s : TimeseriesgarchBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_buffer_max(s : TimeseriesgarchBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_buffer_to_string(s : TimeseriesgarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_cursor_make(size : Int) -> TimeseriesgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_cursor_len(s : TimeseriesgarchCursor) -> Int { s.size }

pub fn timeseries_garch_cursor_get(s : TimeseriesgarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_cursor_set(s : TimeseriesgarchCursor, i : Int, v : Double) -> TimeseriesgarchCursor {
  let result = timeseries_garch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_cursor_sum(s : TimeseriesgarchCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_cursor_mean(s : TimeseriesgarchCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_cursor_scale(s : TimeseriesgarchCursor, f : Double) -> TimeseriesgarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cursor_add(a : TimeseriesgarchCursor, b : TimeseriesgarchCursor) -> TimeseriesgarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_cursor_copy(s : TimeseriesgarchCursor) -> TimeseriesgarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cursor_fill(s : TimeseriesgarchCursor, v : Double) -> TimeseriesgarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cursor_min(s : TimeseriesgarchCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_cursor_max(s : TimeseriesgarchCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_cursor_to_string(s : TimeseriesgarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_view_make(size : Int) -> TimeseriesgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_view_len(s : TimeseriesgarchView) -> Int { s.size }

pub fn timeseries_garch_view_get(s : TimeseriesgarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_view_set(s : TimeseriesgarchView, i : Int, v : Double) -> TimeseriesgarchView {
  let result = timeseries_garch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_view_sum(s : TimeseriesgarchView) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_view_mean(s : TimeseriesgarchView) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_view_scale(s : TimeseriesgarchView, f : Double) -> TimeseriesgarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_view_add(a : TimeseriesgarchView, b : TimeseriesgarchView) -> TimeseriesgarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_view_copy(s : TimeseriesgarchView) -> TimeseriesgarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_view_fill(s : TimeseriesgarchView, v : Double) -> TimeseriesgarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_view_min(s : TimeseriesgarchView) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_view_max(s : TimeseriesgarchView) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_view_to_string(s : TimeseriesgarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_range_make(size : Int) -> TimeseriesgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_range_len(s : TimeseriesgarchRange) -> Int { s.size }

pub fn timeseries_garch_range_get(s : TimeseriesgarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_range_set(s : TimeseriesgarchRange, i : Int, v : Double) -> TimeseriesgarchRange {
  let result = timeseries_garch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_range_sum(s : TimeseriesgarchRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_range_mean(s : TimeseriesgarchRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_range_scale(s : TimeseriesgarchRange, f : Double) -> TimeseriesgarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_range_add(a : TimeseriesgarchRange, b : TimeseriesgarchRange) -> TimeseriesgarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_range_copy(s : TimeseriesgarchRange) -> TimeseriesgarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_range_fill(s : TimeseriesgarchRange, v : Double) -> TimeseriesgarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_range_min(s : TimeseriesgarchRange) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_range_max(s : TimeseriesgarchRange) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_range_to_string(s : TimeseriesgarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_slice_make(size : Int) -> TimeseriesgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_slice_len(s : TimeseriesgarchSlice) -> Int { s.size }

pub fn timeseries_garch_slice_get(s : TimeseriesgarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_slice_set(s : TimeseriesgarchSlice, i : Int, v : Double) -> TimeseriesgarchSlice {
  let result = timeseries_garch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_garch_slice_sum(s : TimeseriesgarchSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_slice_mean(s : TimeseriesgarchSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_slice_scale(s : TimeseriesgarchSlice, f : Double) -> TimeseriesgarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_slice_add(a : TimeseriesgarchSlice, b : TimeseriesgarchSlice) -> TimeseriesgarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_slice_copy(s : TimeseriesgarchSlice) -> TimeseriesgarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_slice_fill(s : TimeseriesgarchSlice, v : Double) -> TimeseriesgarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_slice_min(s : TimeseriesgarchSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_slice_max(s : TimeseriesgarchSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_slice_to_string(s : TimeseriesgarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

