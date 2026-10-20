///===
/// extcore/stats_dist_laplace

pub(all) struct StatsdistlaplacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_laplace_make_point(x : Double, y : Double) -> StatsdistlaplacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_laplace_make_point3(x : Double, y : Double, z : Double) -> StatsdistlaplacePoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_laplace_point_x(pt : StatsdistlaplacePoint) -> Double { pt.x }

pub fn stats_dist_laplace_point_y(pt : StatsdistlaplacePoint) -> Double { pt.y }

pub fn stats_dist_laplace_point_z(pt : StatsdistlaplacePoint) -> Double { pt.z }

pub fn stats_dist_laplace_point_label(pt : StatsdistlaplacePoint) -> Int { pt.label }

pub fn stats_dist_laplace_point_dist(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_laplace_point_add(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_laplace_point_sub(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_laplace_point_scale(pt : StatsdistlaplacePoint, s : Double) -> StatsdistlaplacePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_laplace_point_dot(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_laplace_point_cross(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_laplace_point_norm(pt : StatsdistlaplacePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_laplace_point_normalize(pt : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  let n = stats_dist_laplace_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_laplace_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_laplace_point_negate(pt : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_laplace_point_mid(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint) -> StatsdistlaplacePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_laplace_point_lerp(a : StatsdistlaplacePoint, b : StatsdistlaplacePoint, t : Double) -> StatsdistlaplacePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_laplace_point_to_string(pt : StatsdistlaplacePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistlaplaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_laplace_make_series(vals : Array[Double], name : String) -> StatsdistlaplaceSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_laplace_series_len(s : StatsdistlaplaceSeries) -> Int { s.vals.length() }

pub fn stats_dist_laplace_series_sum(s : StatsdistlaplaceSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_laplace_series_mean(s : StatsdistlaplaceSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_laplace_series_min(s : StatsdistlaplaceSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_laplace_series_max(s : StatsdistlaplaceSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_laplace_series_range(s : StatsdistlaplaceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_laplace_series_var(s : StatsdistlaplaceSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_laplace_series_std(s : StatsdistlaplaceSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_laplace_series_median(s : StatsdistlaplaceSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_laplace_series_scale(s : StatsdistlaplaceSeries, f : Double) -> StatsdistlaplaceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_laplace_series_add(a : StatsdistlaplaceSeries, b : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_laplace_series_sub(a : StatsdistlaplaceSeries, b : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_laplace_series_normalize(s : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  let mn = stats_dist_laplace_series_min(s)
  let mx = stats_dist_laplace_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_laplace_series_cumsum(s : StatsdistlaplaceSeries) -> StatsdistlaplaceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_laplace_series_to_string(s : StatsdistlaplaceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlaplaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_laplace_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistlaplaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_laplace_matrix_identity(n : Int) -> StatsdistlaplaceMatrix {
  let m = stats_dist_laplace_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_laplace_matrix_get(m : StatsdistlaplaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_laplace_matrix_transpose(m : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  let result = stats_dist_laplace_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_laplace_matrix_add(a : StatsdistlaplaceMatrix, b : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_laplace_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_laplace_matrix_scale(m : StatsdistlaplaceMatrix, s : Double) -> StatsdistlaplaceMatrix {
  let result = stats_dist_laplace_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_laplace_matrix_multiply(a : StatsdistlaplaceMatrix, b : StatsdistlaplaceMatrix) -> StatsdistlaplaceMatrix {
  if a.cols != b.rows { return stats_dist_laplace_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_laplace_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_laplace_matrix_trace(m : StatsdistlaplaceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_laplace_matrix_det(m : StatsdistlaplaceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_laplace_matrix_norm(m : StatsdistlaplaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_laplace_matrix_to_string(m : StatsdistlaplaceMatrix) -> String {
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

pub(all) struct StatsdistlaplaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_laplace_make_vector(comps : Array[Double]) -> StatsdistlaplaceVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_laplace_vector_zero(dim : Int) -> StatsdistlaplaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_laplace_vector_add(a : StatsdistlaplaceVector, b : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_laplace_vector_sub(a : StatsdistlaplaceVector, b : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_laplace_vector_scale(v : StatsdistlaplaceVector, s : Double) -> StatsdistlaplaceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_laplace_vector_dot(a : StatsdistlaplaceVector, b : StatsdistlaplaceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_laplace_vector_norm(v : StatsdistlaplaceVector) -> Double { @_common.sqrt(stats_dist_laplace_vector_dot(v, v)) }

pub fn stats_dist_laplace_vector_normalize(v : StatsdistlaplaceVector) -> StatsdistlaplaceVector {
  let n = stats_dist_laplace_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_laplace_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_laplace_vector_dist(a : StatsdistlaplaceVector, b : StatsdistlaplaceVector) -> Double {
  stats_dist_laplace_vector_norm(stats_dist_laplace_vector_sub(a, b))
}

pub fn stats_dist_laplace_vector_to_string(v : StatsdistlaplaceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_laplace_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_laplace_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_laplace_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_laplace_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_laplace_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_laplace_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_laplace_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_laplace_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_laplace_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_laplace_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_laplace_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_laplace_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_laplace_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_laplace_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_laplace_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_laplace_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_laplace_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_laplace_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_laplace_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_laplace_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_laplace_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_laplace_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_laplace_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_laplace_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_laplace_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_laplace_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_laplace_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_laplace_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_laplace_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistlaplaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_frame_make(size : Int) -> StatsdistlaplaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_frame_len(s : StatsdistlaplaceFrame) -> Int { s.size }

pub fn stats_dist_laplace_frame_get(s : StatsdistlaplaceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_frame_set(s : StatsdistlaplaceFrame, i : Int, v : Double) -> StatsdistlaplaceFrame {
  let result = stats_dist_laplace_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_frame_sum(s : StatsdistlaplaceFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_frame_mean(s : StatsdistlaplaceFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_frame_scale(s : StatsdistlaplaceFrame, f : Double) -> StatsdistlaplaceFrame {
  let result = stats_dist_laplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_frame_add(a : StatsdistlaplaceFrame, b : StatsdistlaplaceFrame) -> StatsdistlaplaceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_frame_copy(s : StatsdistlaplaceFrame) -> StatsdistlaplaceFrame {
  let result = stats_dist_laplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_frame_fill(s : StatsdistlaplaceFrame, v : Double) -> StatsdistlaplaceFrame {
  let result = stats_dist_laplace_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_frame_min(s : StatsdistlaplaceFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_frame_max(s : StatsdistlaplaceFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_frame_to_string(s : StatsdistlaplaceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_table_make(size : Int) -> StatsdistlaplaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_table_len(s : StatsdistlaplaceTable) -> Int { s.size }

pub fn stats_dist_laplace_table_get(s : StatsdistlaplaceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_table_set(s : StatsdistlaplaceTable, i : Int, v : Double) -> StatsdistlaplaceTable {
  let result = stats_dist_laplace_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_table_sum(s : StatsdistlaplaceTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_table_mean(s : StatsdistlaplaceTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_table_scale(s : StatsdistlaplaceTable, f : Double) -> StatsdistlaplaceTable {
  let result = stats_dist_laplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_table_add(a : StatsdistlaplaceTable, b : StatsdistlaplaceTable) -> StatsdistlaplaceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_table_copy(s : StatsdistlaplaceTable) -> StatsdistlaplaceTable {
  let result = stats_dist_laplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_table_fill(s : StatsdistlaplaceTable, v : Double) -> StatsdistlaplaceTable {
  let result = stats_dist_laplace_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_table_min(s : StatsdistlaplaceTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_table_max(s : StatsdistlaplaceTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_table_to_string(s : StatsdistlaplaceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_graphn_make(size : Int) -> StatsdistlaplaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_graphn_len(s : StatsdistlaplaceGraphN) -> Int { s.size }

pub fn stats_dist_laplace_graphn_get(s : StatsdistlaplaceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_graphn_set(s : StatsdistlaplaceGraphN, i : Int, v : Double) -> StatsdistlaplaceGraphN {
  let result = stats_dist_laplace_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_graphn_sum(s : StatsdistlaplaceGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_graphn_mean(s : StatsdistlaplaceGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_graphn_scale(s : StatsdistlaplaceGraphN, f : Double) -> StatsdistlaplaceGraphN {
  let result = stats_dist_laplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_graphn_add(a : StatsdistlaplaceGraphN, b : StatsdistlaplaceGraphN) -> StatsdistlaplaceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_graphn_copy(s : StatsdistlaplaceGraphN) -> StatsdistlaplaceGraphN {
  let result = stats_dist_laplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_graphn_fill(s : StatsdistlaplaceGraphN, v : Double) -> StatsdistlaplaceGraphN {
  let result = stats_dist_laplace_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_graphn_min(s : StatsdistlaplaceGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_graphn_max(s : StatsdistlaplaceGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_graphn_to_string(s : StatsdistlaplaceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_node_make(size : Int) -> StatsdistlaplaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_node_len(s : StatsdistlaplaceNode) -> Int { s.size }

pub fn stats_dist_laplace_node_get(s : StatsdistlaplaceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_node_set(s : StatsdistlaplaceNode, i : Int, v : Double) -> StatsdistlaplaceNode {
  let result = stats_dist_laplace_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_node_sum(s : StatsdistlaplaceNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_node_mean(s : StatsdistlaplaceNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_node_scale(s : StatsdistlaplaceNode, f : Double) -> StatsdistlaplaceNode {
  let result = stats_dist_laplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_node_add(a : StatsdistlaplaceNode, b : StatsdistlaplaceNode) -> StatsdistlaplaceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_node_copy(s : StatsdistlaplaceNode) -> StatsdistlaplaceNode {
  let result = stats_dist_laplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_node_fill(s : StatsdistlaplaceNode, v : Double) -> StatsdistlaplaceNode {
  let result = stats_dist_laplace_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_node_min(s : StatsdistlaplaceNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_node_max(s : StatsdistlaplaceNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_node_to_string(s : StatsdistlaplaceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_edge_make(size : Int) -> StatsdistlaplaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_edge_len(s : StatsdistlaplaceEdge) -> Int { s.size }

pub fn stats_dist_laplace_edge_get(s : StatsdistlaplaceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_edge_set(s : StatsdistlaplaceEdge, i : Int, v : Double) -> StatsdistlaplaceEdge {
  let result = stats_dist_laplace_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_edge_sum(s : StatsdistlaplaceEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_edge_mean(s : StatsdistlaplaceEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_edge_scale(s : StatsdistlaplaceEdge, f : Double) -> StatsdistlaplaceEdge {
  let result = stats_dist_laplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_edge_add(a : StatsdistlaplaceEdge, b : StatsdistlaplaceEdge) -> StatsdistlaplaceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_edge_copy(s : StatsdistlaplaceEdge) -> StatsdistlaplaceEdge {
  let result = stats_dist_laplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_edge_fill(s : StatsdistlaplaceEdge, v : Double) -> StatsdistlaplaceEdge {
  let result = stats_dist_laplace_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_edge_min(s : StatsdistlaplaceEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_edge_max(s : StatsdistlaplaceEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_edge_to_string(s : StatsdistlaplaceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_path_make(size : Int) -> StatsdistlaplacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_path_len(s : StatsdistlaplacePath) -> Int { s.size }

pub fn stats_dist_laplace_path_get(s : StatsdistlaplacePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_path_set(s : StatsdistlaplacePath, i : Int, v : Double) -> StatsdistlaplacePath {
  let result = stats_dist_laplace_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_path_sum(s : StatsdistlaplacePath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_path_mean(s : StatsdistlaplacePath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_path_scale(s : StatsdistlaplacePath, f : Double) -> StatsdistlaplacePath {
  let result = stats_dist_laplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_path_add(a : StatsdistlaplacePath, b : StatsdistlaplacePath) -> StatsdistlaplacePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_path_copy(s : StatsdistlaplacePath) -> StatsdistlaplacePath {
  let result = stats_dist_laplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_path_fill(s : StatsdistlaplacePath, v : Double) -> StatsdistlaplacePath {
  let result = stats_dist_laplace_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_path_min(s : StatsdistlaplacePath) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_path_max(s : StatsdistlaplacePath) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_path_to_string(s : StatsdistlaplacePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_cluster_make(size : Int) -> StatsdistlaplaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_cluster_len(s : StatsdistlaplaceCluster) -> Int { s.size }

pub fn stats_dist_laplace_cluster_get(s : StatsdistlaplaceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_cluster_set(s : StatsdistlaplaceCluster, i : Int, v : Double) -> StatsdistlaplaceCluster {
  let result = stats_dist_laplace_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_cluster_sum(s : StatsdistlaplaceCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_cluster_mean(s : StatsdistlaplaceCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_cluster_scale(s : StatsdistlaplaceCluster, f : Double) -> StatsdistlaplaceCluster {
  let result = stats_dist_laplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_cluster_add(a : StatsdistlaplaceCluster, b : StatsdistlaplaceCluster) -> StatsdistlaplaceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_cluster_copy(s : StatsdistlaplaceCluster) -> StatsdistlaplaceCluster {
  let result = stats_dist_laplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_cluster_fill(s : StatsdistlaplaceCluster, v : Double) -> StatsdistlaplaceCluster {
  let result = stats_dist_laplace_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_cluster_min(s : StatsdistlaplaceCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_cluster_max(s : StatsdistlaplaceCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_cluster_to_string(s : StatsdistlaplaceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_model_make(size : Int) -> StatsdistlaplaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_model_len(s : StatsdistlaplaceModel) -> Int { s.size }

pub fn stats_dist_laplace_model_get(s : StatsdistlaplaceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_model_set(s : StatsdistlaplaceModel, i : Int, v : Double) -> StatsdistlaplaceModel {
  let result = stats_dist_laplace_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_model_sum(s : StatsdistlaplaceModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_model_mean(s : StatsdistlaplaceModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_model_scale(s : StatsdistlaplaceModel, f : Double) -> StatsdistlaplaceModel {
  let result = stats_dist_laplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_model_add(a : StatsdistlaplaceModel, b : StatsdistlaplaceModel) -> StatsdistlaplaceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_model_copy(s : StatsdistlaplaceModel) -> StatsdistlaplaceModel {
  let result = stats_dist_laplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_model_fill(s : StatsdistlaplaceModel, v : Double) -> StatsdistlaplaceModel {
  let result = stats_dist_laplace_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_model_min(s : StatsdistlaplaceModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_model_max(s : StatsdistlaplaceModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_model_to_string(s : StatsdistlaplaceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_layer_make(size : Int) -> StatsdistlaplaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_layer_len(s : StatsdistlaplaceLayer) -> Int { s.size }

pub fn stats_dist_laplace_layer_get(s : StatsdistlaplaceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_layer_set(s : StatsdistlaplaceLayer, i : Int, v : Double) -> StatsdistlaplaceLayer {
  let result = stats_dist_laplace_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_layer_sum(s : StatsdistlaplaceLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_layer_mean(s : StatsdistlaplaceLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_layer_scale(s : StatsdistlaplaceLayer, f : Double) -> StatsdistlaplaceLayer {
  let result = stats_dist_laplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_layer_add(a : StatsdistlaplaceLayer, b : StatsdistlaplaceLayer) -> StatsdistlaplaceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_layer_copy(s : StatsdistlaplaceLayer) -> StatsdistlaplaceLayer {
  let result = stats_dist_laplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_layer_fill(s : StatsdistlaplaceLayer, v : Double) -> StatsdistlaplaceLayer {
  let result = stats_dist_laplace_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_layer_min(s : StatsdistlaplaceLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_layer_max(s : StatsdistlaplaceLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_layer_to_string(s : StatsdistlaplaceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_buffer_make(size : Int) -> StatsdistlaplaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_buffer_len(s : StatsdistlaplaceBuffer) -> Int { s.size }

pub fn stats_dist_laplace_buffer_get(s : StatsdistlaplaceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_buffer_set(s : StatsdistlaplaceBuffer, i : Int, v : Double) -> StatsdistlaplaceBuffer {
  let result = stats_dist_laplace_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_buffer_sum(s : StatsdistlaplaceBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_buffer_mean(s : StatsdistlaplaceBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_buffer_scale(s : StatsdistlaplaceBuffer, f : Double) -> StatsdistlaplaceBuffer {
  let result = stats_dist_laplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_buffer_add(a : StatsdistlaplaceBuffer, b : StatsdistlaplaceBuffer) -> StatsdistlaplaceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_buffer_copy(s : StatsdistlaplaceBuffer) -> StatsdistlaplaceBuffer {
  let result = stats_dist_laplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_buffer_fill(s : StatsdistlaplaceBuffer, v : Double) -> StatsdistlaplaceBuffer {
  let result = stats_dist_laplace_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_buffer_min(s : StatsdistlaplaceBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_buffer_max(s : StatsdistlaplaceBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_buffer_to_string(s : StatsdistlaplaceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_cursor_make(size : Int) -> StatsdistlaplaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_cursor_len(s : StatsdistlaplaceCursor) -> Int { s.size }

pub fn stats_dist_laplace_cursor_get(s : StatsdistlaplaceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_cursor_set(s : StatsdistlaplaceCursor, i : Int, v : Double) -> StatsdistlaplaceCursor {
  let result = stats_dist_laplace_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_cursor_sum(s : StatsdistlaplaceCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_cursor_mean(s : StatsdistlaplaceCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_cursor_scale(s : StatsdistlaplaceCursor, f : Double) -> StatsdistlaplaceCursor {
  let result = stats_dist_laplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_cursor_add(a : StatsdistlaplaceCursor, b : StatsdistlaplaceCursor) -> StatsdistlaplaceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_cursor_copy(s : StatsdistlaplaceCursor) -> StatsdistlaplaceCursor {
  let result = stats_dist_laplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_cursor_fill(s : StatsdistlaplaceCursor, v : Double) -> StatsdistlaplaceCursor {
  let result = stats_dist_laplace_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_cursor_min(s : StatsdistlaplaceCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_cursor_max(s : StatsdistlaplaceCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_cursor_to_string(s : StatsdistlaplaceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_view_make(size : Int) -> StatsdistlaplaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_view_len(s : StatsdistlaplaceView) -> Int { s.size }

pub fn stats_dist_laplace_view_get(s : StatsdistlaplaceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_view_set(s : StatsdistlaplaceView, i : Int, v : Double) -> StatsdistlaplaceView {
  let result = stats_dist_laplace_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_view_sum(s : StatsdistlaplaceView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_view_mean(s : StatsdistlaplaceView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_view_scale(s : StatsdistlaplaceView, f : Double) -> StatsdistlaplaceView {
  let result = stats_dist_laplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_view_add(a : StatsdistlaplaceView, b : StatsdistlaplaceView) -> StatsdistlaplaceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_view_copy(s : StatsdistlaplaceView) -> StatsdistlaplaceView {
  let result = stats_dist_laplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_view_fill(s : StatsdistlaplaceView, v : Double) -> StatsdistlaplaceView {
  let result = stats_dist_laplace_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_view_min(s : StatsdistlaplaceView) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_view_max(s : StatsdistlaplaceView) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_view_to_string(s : StatsdistlaplaceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_range_make(size : Int) -> StatsdistlaplaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_range_len(s : StatsdistlaplaceRange) -> Int { s.size }

pub fn stats_dist_laplace_range_get(s : StatsdistlaplaceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_range_set(s : StatsdistlaplaceRange, i : Int, v : Double) -> StatsdistlaplaceRange {
  let result = stats_dist_laplace_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_range_sum(s : StatsdistlaplaceRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_range_mean(s : StatsdistlaplaceRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_range_scale(s : StatsdistlaplaceRange, f : Double) -> StatsdistlaplaceRange {
  let result = stats_dist_laplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_range_add(a : StatsdistlaplaceRange, b : StatsdistlaplaceRange) -> StatsdistlaplaceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_range_copy(s : StatsdistlaplaceRange) -> StatsdistlaplaceRange {
  let result = stats_dist_laplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_range_fill(s : StatsdistlaplaceRange, v : Double) -> StatsdistlaplaceRange {
  let result = stats_dist_laplace_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_range_min(s : StatsdistlaplaceRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_range_max(s : StatsdistlaplaceRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_range_to_string(s : StatsdistlaplaceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlaplaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_laplace_slice_make(size : Int) -> StatsdistlaplaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_laplace_slice_len(s : StatsdistlaplaceSlice) -> Int { s.size }

pub fn stats_dist_laplace_slice_get(s : StatsdistlaplaceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_laplace_slice_set(s : StatsdistlaplaceSlice, i : Int, v : Double) -> StatsdistlaplaceSlice {
  let result = stats_dist_laplace_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_slice_sum(s : StatsdistlaplaceSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_laplace_slice_mean(s : StatsdistlaplaceSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_laplace_slice_scale(s : StatsdistlaplaceSlice, f : Double) -> StatsdistlaplaceSlice {
  let result = stats_dist_laplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_laplace_slice_add(a : StatsdistlaplaceSlice, b : StatsdistlaplaceSlice) -> StatsdistlaplaceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_laplace_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_laplace_slice_copy(s : StatsdistlaplaceSlice) -> StatsdistlaplaceSlice {
  let result = stats_dist_laplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_laplace_slice_fill(s : StatsdistlaplaceSlice, v : Double) -> StatsdistlaplaceSlice {
  let result = stats_dist_laplace_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_laplace_slice_min(s : StatsdistlaplaceSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_laplace_slice_max(s : StatsdistlaplaceSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_laplace_slice_to_string(s : StatsdistlaplaceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

