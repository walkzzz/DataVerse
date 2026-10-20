///===
/// extcore/stats_dist_pareto

pub(all) struct StatsdistparetoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_pareto_make_point(x : Double, y : Double) -> StatsdistparetoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_pareto_make_point3(x : Double, y : Double, z : Double) -> StatsdistparetoPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_pareto_point_x(pt : StatsdistparetoPoint) -> Double { pt.x }

pub fn stats_dist_pareto_point_y(pt : StatsdistparetoPoint) -> Double { pt.y }

pub fn stats_dist_pareto_point_z(pt : StatsdistparetoPoint) -> Double { pt.z }

pub fn stats_dist_pareto_point_label(pt : StatsdistparetoPoint) -> Int { pt.label }

pub fn stats_dist_pareto_point_dist(a : StatsdistparetoPoint, b : StatsdistparetoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_pareto_point_add(a : StatsdistparetoPoint, b : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_pareto_point_sub(a : StatsdistparetoPoint, b : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_pareto_point_scale(pt : StatsdistparetoPoint, s : Double) -> StatsdistparetoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_pareto_point_dot(a : StatsdistparetoPoint, b : StatsdistparetoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_pareto_point_cross(a : StatsdistparetoPoint, b : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_pareto_point_norm(pt : StatsdistparetoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_pareto_point_normalize(pt : StatsdistparetoPoint) -> StatsdistparetoPoint {
  let n = stats_dist_pareto_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_pareto_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_pareto_point_negate(pt : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_pareto_point_mid(a : StatsdistparetoPoint, b : StatsdistparetoPoint) -> StatsdistparetoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_pareto_point_lerp(a : StatsdistparetoPoint, b : StatsdistparetoPoint, t : Double) -> StatsdistparetoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_pareto_point_to_string(pt : StatsdistparetoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistparetoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_pareto_make_series(vals : Array[Double], name : String) -> StatsdistparetoSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_pareto_series_len(s : StatsdistparetoSeries) -> Int { s.vals.length() }

pub fn stats_dist_pareto_series_sum(s : StatsdistparetoSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_pareto_series_mean(s : StatsdistparetoSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_pareto_series_min(s : StatsdistparetoSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_pareto_series_max(s : StatsdistparetoSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_pareto_series_range(s : StatsdistparetoSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_pareto_series_var(s : StatsdistparetoSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_pareto_series_std(s : StatsdistparetoSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_pareto_series_median(s : StatsdistparetoSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_pareto_series_scale(s : StatsdistparetoSeries, f : Double) -> StatsdistparetoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_pareto_series_add(a : StatsdistparetoSeries, b : StatsdistparetoSeries) -> StatsdistparetoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_pareto_series_sub(a : StatsdistparetoSeries, b : StatsdistparetoSeries) -> StatsdistparetoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_pareto_series_normalize(s : StatsdistparetoSeries) -> StatsdistparetoSeries {
  let mn = stats_dist_pareto_series_min(s)
  let mx = stats_dist_pareto_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_pareto_series_cumsum(s : StatsdistparetoSeries) -> StatsdistparetoSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_pareto_series_to_string(s : StatsdistparetoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistparetoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_pareto_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistparetoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_pareto_matrix_identity(n : Int) -> StatsdistparetoMatrix {
  let m = stats_dist_pareto_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_pareto_matrix_get(m : StatsdistparetoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_pareto_matrix_transpose(m : StatsdistparetoMatrix) -> StatsdistparetoMatrix {
  let result = stats_dist_pareto_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_pareto_matrix_add(a : StatsdistparetoMatrix, b : StatsdistparetoMatrix) -> StatsdistparetoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_pareto_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_pareto_matrix_scale(m : StatsdistparetoMatrix, s : Double) -> StatsdistparetoMatrix {
  let result = stats_dist_pareto_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_pareto_matrix_multiply(a : StatsdistparetoMatrix, b : StatsdistparetoMatrix) -> StatsdistparetoMatrix {
  if a.cols != b.rows { return stats_dist_pareto_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_pareto_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_pareto_matrix_trace(m : StatsdistparetoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_pareto_matrix_det(m : StatsdistparetoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_pareto_matrix_norm(m : StatsdistparetoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_pareto_matrix_to_string(m : StatsdistparetoMatrix) -> String {
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

pub(all) struct StatsdistparetoVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_pareto_make_vector(comps : Array[Double]) -> StatsdistparetoVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_pareto_vector_zero(dim : Int) -> StatsdistparetoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_pareto_vector_add(a : StatsdistparetoVector, b : StatsdistparetoVector) -> StatsdistparetoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_pareto_vector_sub(a : StatsdistparetoVector, b : StatsdistparetoVector) -> StatsdistparetoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_pareto_vector_scale(v : StatsdistparetoVector, s : Double) -> StatsdistparetoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_pareto_vector_dot(a : StatsdistparetoVector, b : StatsdistparetoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_pareto_vector_norm(v : StatsdistparetoVector) -> Double { @_common.sqrt(stats_dist_pareto_vector_dot(v, v)) }

pub fn stats_dist_pareto_vector_normalize(v : StatsdistparetoVector) -> StatsdistparetoVector {
  let n = stats_dist_pareto_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_pareto_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_pareto_vector_dist(a : StatsdistparetoVector, b : StatsdistparetoVector) -> Double {
  stats_dist_pareto_vector_norm(stats_dist_pareto_vector_sub(a, b))
}

pub fn stats_dist_pareto_vector_to_string(v : StatsdistparetoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_pareto_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_pareto_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_pareto_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_pareto_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_pareto_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_pareto_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_pareto_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_pareto_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_pareto_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_pareto_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_pareto_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_pareto_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_pareto_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_pareto_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_pareto_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_pareto_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_pareto_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_pareto_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_pareto_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_pareto_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_pareto_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_pareto_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_pareto_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_pareto_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_pareto_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_pareto_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_pareto_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_pareto_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_pareto_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistparetoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_frame_make(size : Int) -> StatsdistparetoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_frame_len(s : StatsdistparetoFrame) -> Int { s.size }

pub fn stats_dist_pareto_frame_get(s : StatsdistparetoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_frame_set(s : StatsdistparetoFrame, i : Int, v : Double) -> StatsdistparetoFrame {
  let result = stats_dist_pareto_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_frame_sum(s : StatsdistparetoFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_frame_mean(s : StatsdistparetoFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_frame_scale(s : StatsdistparetoFrame, f : Double) -> StatsdistparetoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_frame_add(a : StatsdistparetoFrame, b : StatsdistparetoFrame) -> StatsdistparetoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_frame_copy(s : StatsdistparetoFrame) -> StatsdistparetoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_frame_fill(s : StatsdistparetoFrame, v : Double) -> StatsdistparetoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_frame_min(s : StatsdistparetoFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_frame_max(s : StatsdistparetoFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_frame_to_string(s : StatsdistparetoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_table_make(size : Int) -> StatsdistparetoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_table_len(s : StatsdistparetoTable) -> Int { s.size }

pub fn stats_dist_pareto_table_get(s : StatsdistparetoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_table_set(s : StatsdistparetoTable, i : Int, v : Double) -> StatsdistparetoTable {
  let result = stats_dist_pareto_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_table_sum(s : StatsdistparetoTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_table_mean(s : StatsdistparetoTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_table_scale(s : StatsdistparetoTable, f : Double) -> StatsdistparetoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_table_add(a : StatsdistparetoTable, b : StatsdistparetoTable) -> StatsdistparetoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_table_copy(s : StatsdistparetoTable) -> StatsdistparetoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_table_fill(s : StatsdistparetoTable, v : Double) -> StatsdistparetoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_table_min(s : StatsdistparetoTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_table_max(s : StatsdistparetoTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_table_to_string(s : StatsdistparetoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_graphn_make(size : Int) -> StatsdistparetoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_graphn_len(s : StatsdistparetoGraphN) -> Int { s.size }

pub fn stats_dist_pareto_graphn_get(s : StatsdistparetoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_graphn_set(s : StatsdistparetoGraphN, i : Int, v : Double) -> StatsdistparetoGraphN {
  let result = stats_dist_pareto_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_graphn_sum(s : StatsdistparetoGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_graphn_mean(s : StatsdistparetoGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_graphn_scale(s : StatsdistparetoGraphN, f : Double) -> StatsdistparetoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_graphn_add(a : StatsdistparetoGraphN, b : StatsdistparetoGraphN) -> StatsdistparetoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_graphn_copy(s : StatsdistparetoGraphN) -> StatsdistparetoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_graphn_fill(s : StatsdistparetoGraphN, v : Double) -> StatsdistparetoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_graphn_min(s : StatsdistparetoGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_graphn_max(s : StatsdistparetoGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_graphn_to_string(s : StatsdistparetoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_node_make(size : Int) -> StatsdistparetoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_node_len(s : StatsdistparetoNode) -> Int { s.size }

pub fn stats_dist_pareto_node_get(s : StatsdistparetoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_node_set(s : StatsdistparetoNode, i : Int, v : Double) -> StatsdistparetoNode {
  let result = stats_dist_pareto_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_node_sum(s : StatsdistparetoNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_node_mean(s : StatsdistparetoNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_node_scale(s : StatsdistparetoNode, f : Double) -> StatsdistparetoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_node_add(a : StatsdistparetoNode, b : StatsdistparetoNode) -> StatsdistparetoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_node_copy(s : StatsdistparetoNode) -> StatsdistparetoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_node_fill(s : StatsdistparetoNode, v : Double) -> StatsdistparetoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_node_min(s : StatsdistparetoNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_node_max(s : StatsdistparetoNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_node_to_string(s : StatsdistparetoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_edge_make(size : Int) -> StatsdistparetoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_edge_len(s : StatsdistparetoEdge) -> Int { s.size }

pub fn stats_dist_pareto_edge_get(s : StatsdistparetoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_edge_set(s : StatsdistparetoEdge, i : Int, v : Double) -> StatsdistparetoEdge {
  let result = stats_dist_pareto_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_edge_sum(s : StatsdistparetoEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_edge_mean(s : StatsdistparetoEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_edge_scale(s : StatsdistparetoEdge, f : Double) -> StatsdistparetoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_edge_add(a : StatsdistparetoEdge, b : StatsdistparetoEdge) -> StatsdistparetoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_edge_copy(s : StatsdistparetoEdge) -> StatsdistparetoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_edge_fill(s : StatsdistparetoEdge, v : Double) -> StatsdistparetoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_edge_min(s : StatsdistparetoEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_edge_max(s : StatsdistparetoEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_edge_to_string(s : StatsdistparetoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_path_make(size : Int) -> StatsdistparetoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_path_len(s : StatsdistparetoPath) -> Int { s.size }

pub fn stats_dist_pareto_path_get(s : StatsdistparetoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_path_set(s : StatsdistparetoPath, i : Int, v : Double) -> StatsdistparetoPath {
  let result = stats_dist_pareto_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_path_sum(s : StatsdistparetoPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_path_mean(s : StatsdistparetoPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_path_scale(s : StatsdistparetoPath, f : Double) -> StatsdistparetoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_path_add(a : StatsdistparetoPath, b : StatsdistparetoPath) -> StatsdistparetoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_path_copy(s : StatsdistparetoPath) -> StatsdistparetoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_path_fill(s : StatsdistparetoPath, v : Double) -> StatsdistparetoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_path_min(s : StatsdistparetoPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_path_max(s : StatsdistparetoPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_path_to_string(s : StatsdistparetoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_cluster_make(size : Int) -> StatsdistparetoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_cluster_len(s : StatsdistparetoCluster) -> Int { s.size }

pub fn stats_dist_pareto_cluster_get(s : StatsdistparetoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_cluster_set(s : StatsdistparetoCluster, i : Int, v : Double) -> StatsdistparetoCluster {
  let result = stats_dist_pareto_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_cluster_sum(s : StatsdistparetoCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_cluster_mean(s : StatsdistparetoCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_cluster_scale(s : StatsdistparetoCluster, f : Double) -> StatsdistparetoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cluster_add(a : StatsdistparetoCluster, b : StatsdistparetoCluster) -> StatsdistparetoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_cluster_copy(s : StatsdistparetoCluster) -> StatsdistparetoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cluster_fill(s : StatsdistparetoCluster, v : Double) -> StatsdistparetoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cluster_min(s : StatsdistparetoCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_cluster_max(s : StatsdistparetoCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_cluster_to_string(s : StatsdistparetoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_model_make(size : Int) -> StatsdistparetoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_model_len(s : StatsdistparetoModel) -> Int { s.size }

pub fn stats_dist_pareto_model_get(s : StatsdistparetoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_model_set(s : StatsdistparetoModel, i : Int, v : Double) -> StatsdistparetoModel {
  let result = stats_dist_pareto_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_model_sum(s : StatsdistparetoModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_model_mean(s : StatsdistparetoModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_model_scale(s : StatsdistparetoModel, f : Double) -> StatsdistparetoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_model_add(a : StatsdistparetoModel, b : StatsdistparetoModel) -> StatsdistparetoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_model_copy(s : StatsdistparetoModel) -> StatsdistparetoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_model_fill(s : StatsdistparetoModel, v : Double) -> StatsdistparetoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_model_min(s : StatsdistparetoModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_model_max(s : StatsdistparetoModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_model_to_string(s : StatsdistparetoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_layer_make(size : Int) -> StatsdistparetoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_layer_len(s : StatsdistparetoLayer) -> Int { s.size }

pub fn stats_dist_pareto_layer_get(s : StatsdistparetoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_layer_set(s : StatsdistparetoLayer, i : Int, v : Double) -> StatsdistparetoLayer {
  let result = stats_dist_pareto_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_layer_sum(s : StatsdistparetoLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_layer_mean(s : StatsdistparetoLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_layer_scale(s : StatsdistparetoLayer, f : Double) -> StatsdistparetoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_layer_add(a : StatsdistparetoLayer, b : StatsdistparetoLayer) -> StatsdistparetoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_layer_copy(s : StatsdistparetoLayer) -> StatsdistparetoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_layer_fill(s : StatsdistparetoLayer, v : Double) -> StatsdistparetoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_layer_min(s : StatsdistparetoLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_layer_max(s : StatsdistparetoLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_layer_to_string(s : StatsdistparetoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_buffer_make(size : Int) -> StatsdistparetoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_buffer_len(s : StatsdistparetoBuffer) -> Int { s.size }

pub fn stats_dist_pareto_buffer_get(s : StatsdistparetoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_buffer_set(s : StatsdistparetoBuffer, i : Int, v : Double) -> StatsdistparetoBuffer {
  let result = stats_dist_pareto_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_buffer_sum(s : StatsdistparetoBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_buffer_mean(s : StatsdistparetoBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_buffer_scale(s : StatsdistparetoBuffer, f : Double) -> StatsdistparetoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_buffer_add(a : StatsdistparetoBuffer, b : StatsdistparetoBuffer) -> StatsdistparetoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_buffer_copy(s : StatsdistparetoBuffer) -> StatsdistparetoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_buffer_fill(s : StatsdistparetoBuffer, v : Double) -> StatsdistparetoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_buffer_min(s : StatsdistparetoBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_buffer_max(s : StatsdistparetoBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_buffer_to_string(s : StatsdistparetoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_cursor_make(size : Int) -> StatsdistparetoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_cursor_len(s : StatsdistparetoCursor) -> Int { s.size }

pub fn stats_dist_pareto_cursor_get(s : StatsdistparetoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_cursor_set(s : StatsdistparetoCursor, i : Int, v : Double) -> StatsdistparetoCursor {
  let result = stats_dist_pareto_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_cursor_sum(s : StatsdistparetoCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_cursor_mean(s : StatsdistparetoCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_cursor_scale(s : StatsdistparetoCursor, f : Double) -> StatsdistparetoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cursor_add(a : StatsdistparetoCursor, b : StatsdistparetoCursor) -> StatsdistparetoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_cursor_copy(s : StatsdistparetoCursor) -> StatsdistparetoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cursor_fill(s : StatsdistparetoCursor, v : Double) -> StatsdistparetoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_cursor_min(s : StatsdistparetoCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_cursor_max(s : StatsdistparetoCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_cursor_to_string(s : StatsdistparetoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_view_make(size : Int) -> StatsdistparetoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_view_len(s : StatsdistparetoView) -> Int { s.size }

pub fn stats_dist_pareto_view_get(s : StatsdistparetoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_view_set(s : StatsdistparetoView, i : Int, v : Double) -> StatsdistparetoView {
  let result = stats_dist_pareto_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_view_sum(s : StatsdistparetoView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_view_mean(s : StatsdistparetoView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_view_scale(s : StatsdistparetoView, f : Double) -> StatsdistparetoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_view_add(a : StatsdistparetoView, b : StatsdistparetoView) -> StatsdistparetoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_view_copy(s : StatsdistparetoView) -> StatsdistparetoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_view_fill(s : StatsdistparetoView, v : Double) -> StatsdistparetoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_view_min(s : StatsdistparetoView) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_view_max(s : StatsdistparetoView) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_view_to_string(s : StatsdistparetoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_range_make(size : Int) -> StatsdistparetoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_range_len(s : StatsdistparetoRange) -> Int { s.size }

pub fn stats_dist_pareto_range_get(s : StatsdistparetoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_range_set(s : StatsdistparetoRange, i : Int, v : Double) -> StatsdistparetoRange {
  let result = stats_dist_pareto_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_range_sum(s : StatsdistparetoRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_range_mean(s : StatsdistparetoRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_range_scale(s : StatsdistparetoRange, f : Double) -> StatsdistparetoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_range_add(a : StatsdistparetoRange, b : StatsdistparetoRange) -> StatsdistparetoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_range_copy(s : StatsdistparetoRange) -> StatsdistparetoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_range_fill(s : StatsdistparetoRange, v : Double) -> StatsdistparetoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_range_min(s : StatsdistparetoRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_range_max(s : StatsdistparetoRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_range_to_string(s : StatsdistparetoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistparetoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_pareto_slice_make(size : Int) -> StatsdistparetoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_pareto_slice_len(s : StatsdistparetoSlice) -> Int { s.size }

pub fn stats_dist_pareto_slice_get(s : StatsdistparetoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_pareto_slice_set(s : StatsdistparetoSlice, i : Int, v : Double) -> StatsdistparetoSlice {
  let result = stats_dist_pareto_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_pareto_slice_sum(s : StatsdistparetoSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_pareto_slice_mean(s : StatsdistparetoSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_pareto_slice_scale(s : StatsdistparetoSlice, f : Double) -> StatsdistparetoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_slice_add(a : StatsdistparetoSlice, b : StatsdistparetoSlice) -> StatsdistparetoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_pareto_slice_copy(s : StatsdistparetoSlice) -> StatsdistparetoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_slice_fill(s : StatsdistparetoSlice, v : Double) -> StatsdistparetoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_pareto_slice_min(s : StatsdistparetoSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_pareto_slice_max(s : StatsdistparetoSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_pareto_slice_to_string(s : StatsdistparetoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

