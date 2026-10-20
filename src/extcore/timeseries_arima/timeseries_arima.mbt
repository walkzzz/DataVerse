///===
/// extcore/timeseries_arima

pub(all) struct TimeseriesarimaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_arima_make_point(x : Double, y : Double) -> TimeseriesarimaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_arima_make_point3(x : Double, y : Double, z : Double) -> TimeseriesarimaPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_arima_point_x(pt : TimeseriesarimaPoint) -> Double { pt.x }

pub fn timeseries_arima_point_y(pt : TimeseriesarimaPoint) -> Double { pt.y }

pub fn timeseries_arima_point_z(pt : TimeseriesarimaPoint) -> Double { pt.z }

pub fn timeseries_arima_point_label(pt : TimeseriesarimaPoint) -> Int { pt.label }

pub fn timeseries_arima_point_dist(a : TimeseriesarimaPoint, b : TimeseriesarimaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_arima_point_add(a : TimeseriesarimaPoint, b : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_arima_point_sub(a : TimeseriesarimaPoint, b : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_arima_point_scale(pt : TimeseriesarimaPoint, s : Double) -> TimeseriesarimaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_arima_point_dot(a : TimeseriesarimaPoint, b : TimeseriesarimaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_arima_point_cross(a : TimeseriesarimaPoint, b : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_arima_point_norm(pt : TimeseriesarimaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_arima_point_normalize(pt : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  let n = timeseries_arima_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_arima_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_arima_point_negate(pt : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_arima_point_mid(a : TimeseriesarimaPoint, b : TimeseriesarimaPoint) -> TimeseriesarimaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_arima_point_lerp(a : TimeseriesarimaPoint, b : TimeseriesarimaPoint, t : Double) -> TimeseriesarimaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_arima_point_to_string(pt : TimeseriesarimaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeseriesarimaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_arima_make_series(vals : Array[Double], name : String) -> TimeseriesarimaSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_arima_series_len(s : TimeseriesarimaSeries) -> Int { s.vals.length() }

pub fn timeseries_arima_series_sum(s : TimeseriesarimaSeries) -> Double { @_common.sum(s.vals) }

pub fn timeseries_arima_series_mean(s : TimeseriesarimaSeries) -> Double { @_common.mean(s.vals) }

pub fn timeseries_arima_series_min(s : TimeseriesarimaSeries) -> Double { @_common.min(s.vals) }

pub fn timeseries_arima_series_max(s : TimeseriesarimaSeries) -> Double { @_common.max(s.vals) }

pub fn timeseries_arima_series_range(s : TimeseriesarimaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn timeseries_arima_series_var(s : TimeseriesarimaSeries) -> Double { @_common.variance(s.vals) }

pub fn timeseries_arima_series_std(s : TimeseriesarimaSeries) -> Double { @_common.std(s.vals) }

pub fn timeseries_arima_series_median(s : TimeseriesarimaSeries) -> Double { @_common.median(s.vals) }

pub fn timeseries_arima_series_scale(s : TimeseriesarimaSeries, f : Double) -> TimeseriesarimaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_arima_series_add(a : TimeseriesarimaSeries, b : TimeseriesarimaSeries) -> TimeseriesarimaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_arima_series_sub(a : TimeseriesarimaSeries, b : TimeseriesarimaSeries) -> TimeseriesarimaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_arima_series_normalize(s : TimeseriesarimaSeries) -> TimeseriesarimaSeries {
  let mn = timeseries_arima_series_min(s)
  let mx = timeseries_arima_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_arima_series_cumsum(s : TimeseriesarimaSeries) -> TimeseriesarimaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_arima_series_to_string(s : TimeseriesarimaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesarimaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_arima_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesarimaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_arima_matrix_identity(n : Int) -> TimeseriesarimaMatrix {
  let m = timeseries_arima_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_arima_matrix_get(m : TimeseriesarimaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_arima_matrix_transpose(m : TimeseriesarimaMatrix) -> TimeseriesarimaMatrix {
  let result = timeseries_arima_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_arima_matrix_add(a : TimeseriesarimaMatrix, b : TimeseriesarimaMatrix) -> TimeseriesarimaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_arima_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_arima_matrix_scale(m : TimeseriesarimaMatrix, s : Double) -> TimeseriesarimaMatrix {
  let result = timeseries_arima_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_arima_matrix_multiply(a : TimeseriesarimaMatrix, b : TimeseriesarimaMatrix) -> TimeseriesarimaMatrix {
  if a.cols != b.rows { return timeseries_arima_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_arima_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_arima_matrix_trace(m : TimeseriesarimaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_arima_matrix_det(m : TimeseriesarimaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_arima_matrix_norm(m : TimeseriesarimaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_arima_matrix_to_string(m : TimeseriesarimaMatrix) -> String {
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

pub(all) struct TimeseriesarimaVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_arima_make_vector(comps : Array[Double]) -> TimeseriesarimaVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_arima_vector_zero(dim : Int) -> TimeseriesarimaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_arima_vector_add(a : TimeseriesarimaVector, b : TimeseriesarimaVector) -> TimeseriesarimaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_arima_vector_sub(a : TimeseriesarimaVector, b : TimeseriesarimaVector) -> TimeseriesarimaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_arima_vector_scale(v : TimeseriesarimaVector, s : Double) -> TimeseriesarimaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_arima_vector_dot(a : TimeseriesarimaVector, b : TimeseriesarimaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_arima_vector_norm(v : TimeseriesarimaVector) -> Double { @_common.sqrt(timeseries_arima_vector_dot(v, v)) }

pub fn timeseries_arima_vector_normalize(v : TimeseriesarimaVector) -> TimeseriesarimaVector {
  let n = timeseries_arima_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_arima_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_arima_vector_dist(a : TimeseriesarimaVector, b : TimeseriesarimaVector) -> Double {
  timeseries_arima_vector_norm(timeseries_arima_vector_sub(a, b))
}

pub fn timeseries_arima_vector_to_string(v : TimeseriesarimaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_arima_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_arima_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_arima_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_arima_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_arima_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_arima_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_arima_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_arima_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_arima_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_arima_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_arima_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_arima_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_arima_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_arima_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_arima_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_arima_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_arima_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_arima_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_arima_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_arima_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_arima_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_arima_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_arima_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_arima_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_arima_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_arima_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_arima_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_arima_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_arima_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesarimaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_frame_make(size : Int) -> TimeseriesarimaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_frame_len(s : TimeseriesarimaFrame) -> Int { s.size }

pub fn timeseries_arima_frame_get(s : TimeseriesarimaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_frame_set(s : TimeseriesarimaFrame, i : Int, v : Double) -> TimeseriesarimaFrame {
  let result = timeseries_arima_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_frame_sum(s : TimeseriesarimaFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_frame_mean(s : TimeseriesarimaFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_frame_scale(s : TimeseriesarimaFrame, f : Double) -> TimeseriesarimaFrame {
  let result = timeseries_arima_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_frame_add(a : TimeseriesarimaFrame, b : TimeseriesarimaFrame) -> TimeseriesarimaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_frame_copy(s : TimeseriesarimaFrame) -> TimeseriesarimaFrame {
  let result = timeseries_arima_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_frame_fill(s : TimeseriesarimaFrame, v : Double) -> TimeseriesarimaFrame {
  let result = timeseries_arima_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_frame_min(s : TimeseriesarimaFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_frame_max(s : TimeseriesarimaFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_frame_to_string(s : TimeseriesarimaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_table_make(size : Int) -> TimeseriesarimaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_table_len(s : TimeseriesarimaTable) -> Int { s.size }

pub fn timeseries_arima_table_get(s : TimeseriesarimaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_table_set(s : TimeseriesarimaTable, i : Int, v : Double) -> TimeseriesarimaTable {
  let result = timeseries_arima_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_table_sum(s : TimeseriesarimaTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_table_mean(s : TimeseriesarimaTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_table_scale(s : TimeseriesarimaTable, f : Double) -> TimeseriesarimaTable {
  let result = timeseries_arima_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_table_add(a : TimeseriesarimaTable, b : TimeseriesarimaTable) -> TimeseriesarimaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_table_copy(s : TimeseriesarimaTable) -> TimeseriesarimaTable {
  let result = timeseries_arima_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_table_fill(s : TimeseriesarimaTable, v : Double) -> TimeseriesarimaTable {
  let result = timeseries_arima_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_table_min(s : TimeseriesarimaTable) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_table_max(s : TimeseriesarimaTable) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_table_to_string(s : TimeseriesarimaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_graphn_make(size : Int) -> TimeseriesarimaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_graphn_len(s : TimeseriesarimaGraphN) -> Int { s.size }

pub fn timeseries_arima_graphn_get(s : TimeseriesarimaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_graphn_set(s : TimeseriesarimaGraphN, i : Int, v : Double) -> TimeseriesarimaGraphN {
  let result = timeseries_arima_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_graphn_sum(s : TimeseriesarimaGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_graphn_mean(s : TimeseriesarimaGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_graphn_scale(s : TimeseriesarimaGraphN, f : Double) -> TimeseriesarimaGraphN {
  let result = timeseries_arima_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_graphn_add(a : TimeseriesarimaGraphN, b : TimeseriesarimaGraphN) -> TimeseriesarimaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_graphn_copy(s : TimeseriesarimaGraphN) -> TimeseriesarimaGraphN {
  let result = timeseries_arima_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_graphn_fill(s : TimeseriesarimaGraphN, v : Double) -> TimeseriesarimaGraphN {
  let result = timeseries_arima_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_graphn_min(s : TimeseriesarimaGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_graphn_max(s : TimeseriesarimaGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_graphn_to_string(s : TimeseriesarimaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_node_make(size : Int) -> TimeseriesarimaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_node_len(s : TimeseriesarimaNode) -> Int { s.size }

pub fn timeseries_arima_node_get(s : TimeseriesarimaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_node_set(s : TimeseriesarimaNode, i : Int, v : Double) -> TimeseriesarimaNode {
  let result = timeseries_arima_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_node_sum(s : TimeseriesarimaNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_node_mean(s : TimeseriesarimaNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_node_scale(s : TimeseriesarimaNode, f : Double) -> TimeseriesarimaNode {
  let result = timeseries_arima_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_node_add(a : TimeseriesarimaNode, b : TimeseriesarimaNode) -> TimeseriesarimaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_node_copy(s : TimeseriesarimaNode) -> TimeseriesarimaNode {
  let result = timeseries_arima_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_node_fill(s : TimeseriesarimaNode, v : Double) -> TimeseriesarimaNode {
  let result = timeseries_arima_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_node_min(s : TimeseriesarimaNode) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_node_max(s : TimeseriesarimaNode) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_node_to_string(s : TimeseriesarimaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_edge_make(size : Int) -> TimeseriesarimaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_edge_len(s : TimeseriesarimaEdge) -> Int { s.size }

pub fn timeseries_arima_edge_get(s : TimeseriesarimaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_edge_set(s : TimeseriesarimaEdge, i : Int, v : Double) -> TimeseriesarimaEdge {
  let result = timeseries_arima_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_edge_sum(s : TimeseriesarimaEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_edge_mean(s : TimeseriesarimaEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_edge_scale(s : TimeseriesarimaEdge, f : Double) -> TimeseriesarimaEdge {
  let result = timeseries_arima_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_edge_add(a : TimeseriesarimaEdge, b : TimeseriesarimaEdge) -> TimeseriesarimaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_edge_copy(s : TimeseriesarimaEdge) -> TimeseriesarimaEdge {
  let result = timeseries_arima_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_edge_fill(s : TimeseriesarimaEdge, v : Double) -> TimeseriesarimaEdge {
  let result = timeseries_arima_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_edge_min(s : TimeseriesarimaEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_edge_max(s : TimeseriesarimaEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_edge_to_string(s : TimeseriesarimaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_path_make(size : Int) -> TimeseriesarimaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_path_len(s : TimeseriesarimaPath) -> Int { s.size }

pub fn timeseries_arima_path_get(s : TimeseriesarimaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_path_set(s : TimeseriesarimaPath, i : Int, v : Double) -> TimeseriesarimaPath {
  let result = timeseries_arima_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_path_sum(s : TimeseriesarimaPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_path_mean(s : TimeseriesarimaPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_path_scale(s : TimeseriesarimaPath, f : Double) -> TimeseriesarimaPath {
  let result = timeseries_arima_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_path_add(a : TimeseriesarimaPath, b : TimeseriesarimaPath) -> TimeseriesarimaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_path_copy(s : TimeseriesarimaPath) -> TimeseriesarimaPath {
  let result = timeseries_arima_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_path_fill(s : TimeseriesarimaPath, v : Double) -> TimeseriesarimaPath {
  let result = timeseries_arima_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_path_min(s : TimeseriesarimaPath) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_path_max(s : TimeseriesarimaPath) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_path_to_string(s : TimeseriesarimaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_cluster_make(size : Int) -> TimeseriesarimaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_cluster_len(s : TimeseriesarimaCluster) -> Int { s.size }

pub fn timeseries_arima_cluster_get(s : TimeseriesarimaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_cluster_set(s : TimeseriesarimaCluster, i : Int, v : Double) -> TimeseriesarimaCluster {
  let result = timeseries_arima_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_cluster_sum(s : TimeseriesarimaCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_cluster_mean(s : TimeseriesarimaCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_cluster_scale(s : TimeseriesarimaCluster, f : Double) -> TimeseriesarimaCluster {
  let result = timeseries_arima_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_cluster_add(a : TimeseriesarimaCluster, b : TimeseriesarimaCluster) -> TimeseriesarimaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_cluster_copy(s : TimeseriesarimaCluster) -> TimeseriesarimaCluster {
  let result = timeseries_arima_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_cluster_fill(s : TimeseriesarimaCluster, v : Double) -> TimeseriesarimaCluster {
  let result = timeseries_arima_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_cluster_min(s : TimeseriesarimaCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_cluster_max(s : TimeseriesarimaCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_cluster_to_string(s : TimeseriesarimaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_model_make(size : Int) -> TimeseriesarimaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_model_len(s : TimeseriesarimaModel) -> Int { s.size }

pub fn timeseries_arima_model_get(s : TimeseriesarimaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_model_set(s : TimeseriesarimaModel, i : Int, v : Double) -> TimeseriesarimaModel {
  let result = timeseries_arima_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_model_sum(s : TimeseriesarimaModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_model_mean(s : TimeseriesarimaModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_model_scale(s : TimeseriesarimaModel, f : Double) -> TimeseriesarimaModel {
  let result = timeseries_arima_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_model_add(a : TimeseriesarimaModel, b : TimeseriesarimaModel) -> TimeseriesarimaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_model_copy(s : TimeseriesarimaModel) -> TimeseriesarimaModel {
  let result = timeseries_arima_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_model_fill(s : TimeseriesarimaModel, v : Double) -> TimeseriesarimaModel {
  let result = timeseries_arima_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_model_min(s : TimeseriesarimaModel) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_model_max(s : TimeseriesarimaModel) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_model_to_string(s : TimeseriesarimaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_layer_make(size : Int) -> TimeseriesarimaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_layer_len(s : TimeseriesarimaLayer) -> Int { s.size }

pub fn timeseries_arima_layer_get(s : TimeseriesarimaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_layer_set(s : TimeseriesarimaLayer, i : Int, v : Double) -> TimeseriesarimaLayer {
  let result = timeseries_arima_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_layer_sum(s : TimeseriesarimaLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_layer_mean(s : TimeseriesarimaLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_layer_scale(s : TimeseriesarimaLayer, f : Double) -> TimeseriesarimaLayer {
  let result = timeseries_arima_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_layer_add(a : TimeseriesarimaLayer, b : TimeseriesarimaLayer) -> TimeseriesarimaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_layer_copy(s : TimeseriesarimaLayer) -> TimeseriesarimaLayer {
  let result = timeseries_arima_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_layer_fill(s : TimeseriesarimaLayer, v : Double) -> TimeseriesarimaLayer {
  let result = timeseries_arima_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_layer_min(s : TimeseriesarimaLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_layer_max(s : TimeseriesarimaLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_layer_to_string(s : TimeseriesarimaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_buffer_make(size : Int) -> TimeseriesarimaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_buffer_len(s : TimeseriesarimaBuffer) -> Int { s.size }

pub fn timeseries_arima_buffer_get(s : TimeseriesarimaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_buffer_set(s : TimeseriesarimaBuffer, i : Int, v : Double) -> TimeseriesarimaBuffer {
  let result = timeseries_arima_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_buffer_sum(s : TimeseriesarimaBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_buffer_mean(s : TimeseriesarimaBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_buffer_scale(s : TimeseriesarimaBuffer, f : Double) -> TimeseriesarimaBuffer {
  let result = timeseries_arima_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_buffer_add(a : TimeseriesarimaBuffer, b : TimeseriesarimaBuffer) -> TimeseriesarimaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_buffer_copy(s : TimeseriesarimaBuffer) -> TimeseriesarimaBuffer {
  let result = timeseries_arima_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_buffer_fill(s : TimeseriesarimaBuffer, v : Double) -> TimeseriesarimaBuffer {
  let result = timeseries_arima_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_buffer_min(s : TimeseriesarimaBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_buffer_max(s : TimeseriesarimaBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_buffer_to_string(s : TimeseriesarimaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_cursor_make(size : Int) -> TimeseriesarimaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_cursor_len(s : TimeseriesarimaCursor) -> Int { s.size }

pub fn timeseries_arima_cursor_get(s : TimeseriesarimaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_cursor_set(s : TimeseriesarimaCursor, i : Int, v : Double) -> TimeseriesarimaCursor {
  let result = timeseries_arima_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_cursor_sum(s : TimeseriesarimaCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_cursor_mean(s : TimeseriesarimaCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_cursor_scale(s : TimeseriesarimaCursor, f : Double) -> TimeseriesarimaCursor {
  let result = timeseries_arima_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_cursor_add(a : TimeseriesarimaCursor, b : TimeseriesarimaCursor) -> TimeseriesarimaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_cursor_copy(s : TimeseriesarimaCursor) -> TimeseriesarimaCursor {
  let result = timeseries_arima_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_cursor_fill(s : TimeseriesarimaCursor, v : Double) -> TimeseriesarimaCursor {
  let result = timeseries_arima_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_cursor_min(s : TimeseriesarimaCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_cursor_max(s : TimeseriesarimaCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_cursor_to_string(s : TimeseriesarimaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_view_make(size : Int) -> TimeseriesarimaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_view_len(s : TimeseriesarimaView) -> Int { s.size }

pub fn timeseries_arima_view_get(s : TimeseriesarimaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_view_set(s : TimeseriesarimaView, i : Int, v : Double) -> TimeseriesarimaView {
  let result = timeseries_arima_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_view_sum(s : TimeseriesarimaView) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_view_mean(s : TimeseriesarimaView) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_view_scale(s : TimeseriesarimaView, f : Double) -> TimeseriesarimaView {
  let result = timeseries_arima_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_view_add(a : TimeseriesarimaView, b : TimeseriesarimaView) -> TimeseriesarimaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_view_copy(s : TimeseriesarimaView) -> TimeseriesarimaView {
  let result = timeseries_arima_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_view_fill(s : TimeseriesarimaView, v : Double) -> TimeseriesarimaView {
  let result = timeseries_arima_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_view_min(s : TimeseriesarimaView) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_view_max(s : TimeseriesarimaView) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_view_to_string(s : TimeseriesarimaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_range_make(size : Int) -> TimeseriesarimaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_range_len(s : TimeseriesarimaRange) -> Int { s.size }

pub fn timeseries_arima_range_get(s : TimeseriesarimaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_range_set(s : TimeseriesarimaRange, i : Int, v : Double) -> TimeseriesarimaRange {
  let result = timeseries_arima_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_range_sum(s : TimeseriesarimaRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_range_mean(s : TimeseriesarimaRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_range_scale(s : TimeseriesarimaRange, f : Double) -> TimeseriesarimaRange {
  let result = timeseries_arima_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_range_add(a : TimeseriesarimaRange, b : TimeseriesarimaRange) -> TimeseriesarimaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_range_copy(s : TimeseriesarimaRange) -> TimeseriesarimaRange {
  let result = timeseries_arima_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_range_fill(s : TimeseriesarimaRange, v : Double) -> TimeseriesarimaRange {
  let result = timeseries_arima_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_range_min(s : TimeseriesarimaRange) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_range_max(s : TimeseriesarimaRange) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_range_to_string(s : TimeseriesarimaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarimaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arima_slice_make(size : Int) -> TimeseriesarimaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arima_slice_len(s : TimeseriesarimaSlice) -> Int { s.size }

pub fn timeseries_arima_slice_get(s : TimeseriesarimaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arima_slice_set(s : TimeseriesarimaSlice, i : Int, v : Double) -> TimeseriesarimaSlice {
  let result = timeseries_arima_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_slice_sum(s : TimeseriesarimaSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_arima_slice_mean(s : TimeseriesarimaSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_arima_slice_scale(s : TimeseriesarimaSlice, f : Double) -> TimeseriesarimaSlice {
  let result = timeseries_arima_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_arima_slice_add(a : TimeseriesarimaSlice, b : TimeseriesarimaSlice) -> TimeseriesarimaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_arima_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_arima_slice_copy(s : TimeseriesarimaSlice) -> TimeseriesarimaSlice {
  let result = timeseries_arima_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_arima_slice_fill(s : TimeseriesarimaSlice, v : Double) -> TimeseriesarimaSlice {
  let result = timeseries_arima_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_arima_slice_min(s : TimeseriesarimaSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_arima_slice_max(s : TimeseriesarimaSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_arima_slice_to_string(s : TimeseriesarimaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

