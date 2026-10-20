///===
/// extcore/stats_dist_hypergeo

pub(all) struct StatsdisthypergeoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_hypergeo_make_point(x : Double, y : Double) -> StatsdisthypergeoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_hypergeo_make_point3(x : Double, y : Double, z : Double) -> StatsdisthypergeoPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_hypergeo_point_x(pt : StatsdisthypergeoPoint) -> Double { pt.x }

pub fn stats_dist_hypergeo_point_y(pt : StatsdisthypergeoPoint) -> Double { pt.y }

pub fn stats_dist_hypergeo_point_z(pt : StatsdisthypergeoPoint) -> Double { pt.z }

pub fn stats_dist_hypergeo_point_label(pt : StatsdisthypergeoPoint) -> Int { pt.label }

pub fn stats_dist_hypergeo_point_dist(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_hypergeo_point_add(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_hypergeo_point_sub(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_hypergeo_point_scale(pt : StatsdisthypergeoPoint, s : Double) -> StatsdisthypergeoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_hypergeo_point_dot(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_hypergeo_point_cross(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_hypergeo_point_norm(pt : StatsdisthypergeoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_hypergeo_point_normalize(pt : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  let n = stats_dist_hypergeo_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_hypergeo_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_hypergeo_point_negate(pt : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_hypergeo_point_mid(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint) -> StatsdisthypergeoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_hypergeo_point_lerp(a : StatsdisthypergeoPoint, b : StatsdisthypergeoPoint, t : Double) -> StatsdisthypergeoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_hypergeo_point_to_string(pt : StatsdisthypergeoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdisthypergeoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_hypergeo_make_series(vals : Array[Double], name : String) -> StatsdisthypergeoSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_hypergeo_series_len(s : StatsdisthypergeoSeries) -> Int { s.vals.length() }

pub fn stats_dist_hypergeo_series_sum(s : StatsdisthypergeoSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_hypergeo_series_mean(s : StatsdisthypergeoSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_hypergeo_series_min(s : StatsdisthypergeoSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_hypergeo_series_max(s : StatsdisthypergeoSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_hypergeo_series_range(s : StatsdisthypergeoSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_hypergeo_series_var(s : StatsdisthypergeoSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_hypergeo_series_std(s : StatsdisthypergeoSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_hypergeo_series_median(s : StatsdisthypergeoSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_hypergeo_series_scale(s : StatsdisthypergeoSeries, f : Double) -> StatsdisthypergeoSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn stats_dist_hypergeo_series_add(a : StatsdisthypergeoSeries, b : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_hypergeo_series_sub(a : StatsdisthypergeoSeries, b : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_hypergeo_series_normalize(s : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  let mn = stats_dist_hypergeo_series_min(s)
  let mx = stats_dist_hypergeo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_hypergeo_series_cumsum(s : StatsdisthypergeoSeries) -> StatsdisthypergeoSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_hypergeo_series_to_string(s : StatsdisthypergeoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdisthypergeoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_hypergeo_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdisthypergeoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_hypergeo_matrix_identity(n : Int) -> StatsdisthypergeoMatrix {
  let m = stats_dist_hypergeo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_hypergeo_matrix_get(m : StatsdisthypergeoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_hypergeo_matrix_transpose(m : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  let result = stats_dist_hypergeo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_hypergeo_matrix_add(a : StatsdisthypergeoMatrix, b : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_hypergeo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_hypergeo_matrix_scale(m : StatsdisthypergeoMatrix, s : Double) -> StatsdisthypergeoMatrix {
  let result = stats_dist_hypergeo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_hypergeo_matrix_multiply(a : StatsdisthypergeoMatrix, b : StatsdisthypergeoMatrix) -> StatsdisthypergeoMatrix {
  if a.cols != b.rows { return stats_dist_hypergeo_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_hypergeo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_hypergeo_matrix_trace(m : StatsdisthypergeoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_hypergeo_matrix_det(m : StatsdisthypergeoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_hypergeo_matrix_norm(m : StatsdisthypergeoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_hypergeo_matrix_to_string(m : StatsdisthypergeoMatrix) -> String {
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

pub(all) struct StatsdisthypergeoVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_hypergeo_make_vector(comps : Array[Double]) -> StatsdisthypergeoVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_hypergeo_vector_zero(dim : Int) -> StatsdisthypergeoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_hypergeo_vector_add(a : StatsdisthypergeoVector, b : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn stats_dist_hypergeo_vector_sub(a : StatsdisthypergeoVector, b : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn stats_dist_hypergeo_vector_scale(v : StatsdisthypergeoVector, s : Double) -> StatsdisthypergeoVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn stats_dist_hypergeo_vector_dot(a : StatsdisthypergeoVector, b : StatsdisthypergeoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_hypergeo_vector_norm(v : StatsdisthypergeoVector) -> Double { @_common.sqrt(stats_dist_hypergeo_vector_dot(v, v)) }

pub fn stats_dist_hypergeo_vector_normalize(v : StatsdisthypergeoVector) -> StatsdisthypergeoVector {
  let n = stats_dist_hypergeo_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_hypergeo_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_hypergeo_vector_dist(a : StatsdisthypergeoVector, b : StatsdisthypergeoVector) -> Double {
  stats_dist_hypergeo_vector_norm(stats_dist_hypergeo_vector_sub(a, b))
}

pub fn stats_dist_hypergeo_vector_to_string(v : StatsdisthypergeoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_hypergeo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_hypergeo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_hypergeo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_hypergeo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_hypergeo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_hypergeo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_hypergeo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_hypergeo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_hypergeo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_hypergeo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_hypergeo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_hypergeo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_hypergeo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_hypergeo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_hypergeo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_hypergeo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_hypergeo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_hypergeo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_hypergeo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_hypergeo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_hypergeo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_hypergeo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_hypergeo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_hypergeo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_hypergeo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_hypergeo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_hypergeo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_hypergeo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_hypergeo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdisthypergeoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_frame_make(size : Int) -> StatsdisthypergeoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_frame_len(s : StatsdisthypergeoFrame) -> Int { s.size }

pub fn stats_dist_hypergeo_frame_get(s : StatsdisthypergeoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_frame_set(s : StatsdisthypergeoFrame, i : Int, v : Double) -> StatsdisthypergeoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_frame_sum(s : StatsdisthypergeoFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_frame_mean(s : StatsdisthypergeoFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_frame_scale(s : StatsdisthypergeoFrame, f : Double) -> StatsdisthypergeoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_frame_add(a : StatsdisthypergeoFrame, b : StatsdisthypergeoFrame) -> StatsdisthypergeoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_frame_copy(s : StatsdisthypergeoFrame) -> StatsdisthypergeoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_frame_fill(s : StatsdisthypergeoFrame, v : Double) -> StatsdisthypergeoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_frame_min(s : StatsdisthypergeoFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_frame_max(s : StatsdisthypergeoFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_frame_to_string(s : StatsdisthypergeoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_table_make(size : Int) -> StatsdisthypergeoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_table_len(s : StatsdisthypergeoTable) -> Int { s.size }

pub fn stats_dist_hypergeo_table_get(s : StatsdisthypergeoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_table_set(s : StatsdisthypergeoTable, i : Int, v : Double) -> StatsdisthypergeoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_table_sum(s : StatsdisthypergeoTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_table_mean(s : StatsdisthypergeoTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_table_scale(s : StatsdisthypergeoTable, f : Double) -> StatsdisthypergeoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_table_add(a : StatsdisthypergeoTable, b : StatsdisthypergeoTable) -> StatsdisthypergeoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_table_copy(s : StatsdisthypergeoTable) -> StatsdisthypergeoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_table_fill(s : StatsdisthypergeoTable, v : Double) -> StatsdisthypergeoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_table_min(s : StatsdisthypergeoTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_table_max(s : StatsdisthypergeoTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_table_to_string(s : StatsdisthypergeoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_graphn_make(size : Int) -> StatsdisthypergeoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_graphn_len(s : StatsdisthypergeoGraphN) -> Int { s.size }

pub fn stats_dist_hypergeo_graphn_get(s : StatsdisthypergeoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_graphn_set(s : StatsdisthypergeoGraphN, i : Int, v : Double) -> StatsdisthypergeoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_graphn_sum(s : StatsdisthypergeoGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_graphn_mean(s : StatsdisthypergeoGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_graphn_scale(s : StatsdisthypergeoGraphN, f : Double) -> StatsdisthypergeoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_graphn_add(a : StatsdisthypergeoGraphN, b : StatsdisthypergeoGraphN) -> StatsdisthypergeoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_graphn_copy(s : StatsdisthypergeoGraphN) -> StatsdisthypergeoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_graphn_fill(s : StatsdisthypergeoGraphN, v : Double) -> StatsdisthypergeoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_graphn_min(s : StatsdisthypergeoGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_graphn_max(s : StatsdisthypergeoGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_graphn_to_string(s : StatsdisthypergeoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_node_make(size : Int) -> StatsdisthypergeoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_node_len(s : StatsdisthypergeoNode) -> Int { s.size }

pub fn stats_dist_hypergeo_node_get(s : StatsdisthypergeoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_node_set(s : StatsdisthypergeoNode, i : Int, v : Double) -> StatsdisthypergeoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_node_sum(s : StatsdisthypergeoNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_node_mean(s : StatsdisthypergeoNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_node_scale(s : StatsdisthypergeoNode, f : Double) -> StatsdisthypergeoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_node_add(a : StatsdisthypergeoNode, b : StatsdisthypergeoNode) -> StatsdisthypergeoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_node_copy(s : StatsdisthypergeoNode) -> StatsdisthypergeoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_node_fill(s : StatsdisthypergeoNode, v : Double) -> StatsdisthypergeoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_node_min(s : StatsdisthypergeoNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_node_max(s : StatsdisthypergeoNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_node_to_string(s : StatsdisthypergeoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_edge_make(size : Int) -> StatsdisthypergeoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_edge_len(s : StatsdisthypergeoEdge) -> Int { s.size }

pub fn stats_dist_hypergeo_edge_get(s : StatsdisthypergeoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_edge_set(s : StatsdisthypergeoEdge, i : Int, v : Double) -> StatsdisthypergeoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_edge_sum(s : StatsdisthypergeoEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_edge_mean(s : StatsdisthypergeoEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_edge_scale(s : StatsdisthypergeoEdge, f : Double) -> StatsdisthypergeoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_edge_add(a : StatsdisthypergeoEdge, b : StatsdisthypergeoEdge) -> StatsdisthypergeoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_edge_copy(s : StatsdisthypergeoEdge) -> StatsdisthypergeoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_edge_fill(s : StatsdisthypergeoEdge, v : Double) -> StatsdisthypergeoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_edge_min(s : StatsdisthypergeoEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_edge_max(s : StatsdisthypergeoEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_edge_to_string(s : StatsdisthypergeoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_path_make(size : Int) -> StatsdisthypergeoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_path_len(s : StatsdisthypergeoPath) -> Int { s.size }

pub fn stats_dist_hypergeo_path_get(s : StatsdisthypergeoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_path_set(s : StatsdisthypergeoPath, i : Int, v : Double) -> StatsdisthypergeoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_path_sum(s : StatsdisthypergeoPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_path_mean(s : StatsdisthypergeoPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_path_scale(s : StatsdisthypergeoPath, f : Double) -> StatsdisthypergeoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_path_add(a : StatsdisthypergeoPath, b : StatsdisthypergeoPath) -> StatsdisthypergeoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_path_copy(s : StatsdisthypergeoPath) -> StatsdisthypergeoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_path_fill(s : StatsdisthypergeoPath, v : Double) -> StatsdisthypergeoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_path_min(s : StatsdisthypergeoPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_path_max(s : StatsdisthypergeoPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_path_to_string(s : StatsdisthypergeoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_cluster_make(size : Int) -> StatsdisthypergeoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_cluster_len(s : StatsdisthypergeoCluster) -> Int { s.size }

pub fn stats_dist_hypergeo_cluster_get(s : StatsdisthypergeoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_cluster_set(s : StatsdisthypergeoCluster, i : Int, v : Double) -> StatsdisthypergeoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cluster_sum(s : StatsdisthypergeoCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_cluster_mean(s : StatsdisthypergeoCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_cluster_scale(s : StatsdisthypergeoCluster, f : Double) -> StatsdisthypergeoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cluster_add(a : StatsdisthypergeoCluster, b : StatsdisthypergeoCluster) -> StatsdisthypergeoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_cluster_copy(s : StatsdisthypergeoCluster) -> StatsdisthypergeoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cluster_fill(s : StatsdisthypergeoCluster, v : Double) -> StatsdisthypergeoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cluster_min(s : StatsdisthypergeoCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_cluster_max(s : StatsdisthypergeoCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_cluster_to_string(s : StatsdisthypergeoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_model_make(size : Int) -> StatsdisthypergeoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_model_len(s : StatsdisthypergeoModel) -> Int { s.size }

pub fn stats_dist_hypergeo_model_get(s : StatsdisthypergeoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_model_set(s : StatsdisthypergeoModel, i : Int, v : Double) -> StatsdisthypergeoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_model_sum(s : StatsdisthypergeoModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_model_mean(s : StatsdisthypergeoModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_model_scale(s : StatsdisthypergeoModel, f : Double) -> StatsdisthypergeoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_model_add(a : StatsdisthypergeoModel, b : StatsdisthypergeoModel) -> StatsdisthypergeoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_model_copy(s : StatsdisthypergeoModel) -> StatsdisthypergeoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_model_fill(s : StatsdisthypergeoModel, v : Double) -> StatsdisthypergeoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_model_min(s : StatsdisthypergeoModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_model_max(s : StatsdisthypergeoModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_model_to_string(s : StatsdisthypergeoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_layer_make(size : Int) -> StatsdisthypergeoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_layer_len(s : StatsdisthypergeoLayer) -> Int { s.size }

pub fn stats_dist_hypergeo_layer_get(s : StatsdisthypergeoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_layer_set(s : StatsdisthypergeoLayer, i : Int, v : Double) -> StatsdisthypergeoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_layer_sum(s : StatsdisthypergeoLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_layer_mean(s : StatsdisthypergeoLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_layer_scale(s : StatsdisthypergeoLayer, f : Double) -> StatsdisthypergeoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_layer_add(a : StatsdisthypergeoLayer, b : StatsdisthypergeoLayer) -> StatsdisthypergeoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_layer_copy(s : StatsdisthypergeoLayer) -> StatsdisthypergeoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_layer_fill(s : StatsdisthypergeoLayer, v : Double) -> StatsdisthypergeoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_layer_min(s : StatsdisthypergeoLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_layer_max(s : StatsdisthypergeoLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_layer_to_string(s : StatsdisthypergeoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_buffer_make(size : Int) -> StatsdisthypergeoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_buffer_len(s : StatsdisthypergeoBuffer) -> Int { s.size }

pub fn stats_dist_hypergeo_buffer_get(s : StatsdisthypergeoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_buffer_set(s : StatsdisthypergeoBuffer, i : Int, v : Double) -> StatsdisthypergeoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_buffer_sum(s : StatsdisthypergeoBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_buffer_mean(s : StatsdisthypergeoBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_buffer_scale(s : StatsdisthypergeoBuffer, f : Double) -> StatsdisthypergeoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_buffer_add(a : StatsdisthypergeoBuffer, b : StatsdisthypergeoBuffer) -> StatsdisthypergeoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_buffer_copy(s : StatsdisthypergeoBuffer) -> StatsdisthypergeoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_buffer_fill(s : StatsdisthypergeoBuffer, v : Double) -> StatsdisthypergeoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_buffer_min(s : StatsdisthypergeoBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_buffer_max(s : StatsdisthypergeoBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_buffer_to_string(s : StatsdisthypergeoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_cursor_make(size : Int) -> StatsdisthypergeoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_cursor_len(s : StatsdisthypergeoCursor) -> Int { s.size }

pub fn stats_dist_hypergeo_cursor_get(s : StatsdisthypergeoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_cursor_set(s : StatsdisthypergeoCursor, i : Int, v : Double) -> StatsdisthypergeoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cursor_sum(s : StatsdisthypergeoCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_cursor_mean(s : StatsdisthypergeoCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_cursor_scale(s : StatsdisthypergeoCursor, f : Double) -> StatsdisthypergeoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cursor_add(a : StatsdisthypergeoCursor, b : StatsdisthypergeoCursor) -> StatsdisthypergeoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_cursor_copy(s : StatsdisthypergeoCursor) -> StatsdisthypergeoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cursor_fill(s : StatsdisthypergeoCursor, v : Double) -> StatsdisthypergeoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_cursor_min(s : StatsdisthypergeoCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_cursor_max(s : StatsdisthypergeoCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_cursor_to_string(s : StatsdisthypergeoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_view_make(size : Int) -> StatsdisthypergeoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_view_len(s : StatsdisthypergeoView) -> Int { s.size }

pub fn stats_dist_hypergeo_view_get(s : StatsdisthypergeoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_view_set(s : StatsdisthypergeoView, i : Int, v : Double) -> StatsdisthypergeoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_view_sum(s : StatsdisthypergeoView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_view_mean(s : StatsdisthypergeoView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_view_scale(s : StatsdisthypergeoView, f : Double) -> StatsdisthypergeoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_view_add(a : StatsdisthypergeoView, b : StatsdisthypergeoView) -> StatsdisthypergeoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_view_copy(s : StatsdisthypergeoView) -> StatsdisthypergeoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_view_fill(s : StatsdisthypergeoView, v : Double) -> StatsdisthypergeoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_view_min(s : StatsdisthypergeoView) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_view_max(s : StatsdisthypergeoView) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_view_to_string(s : StatsdisthypergeoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_range_make(size : Int) -> StatsdisthypergeoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_range_len(s : StatsdisthypergeoRange) -> Int { s.size }

pub fn stats_dist_hypergeo_range_get(s : StatsdisthypergeoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_range_set(s : StatsdisthypergeoRange, i : Int, v : Double) -> StatsdisthypergeoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_range_sum(s : StatsdisthypergeoRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_range_mean(s : StatsdisthypergeoRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_range_scale(s : StatsdisthypergeoRange, f : Double) -> StatsdisthypergeoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_range_add(a : StatsdisthypergeoRange, b : StatsdisthypergeoRange) -> StatsdisthypergeoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_range_copy(s : StatsdisthypergeoRange) -> StatsdisthypergeoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_range_fill(s : StatsdisthypergeoRange, v : Double) -> StatsdisthypergeoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_range_min(s : StatsdisthypergeoRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_range_max(s : StatsdisthypergeoRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_range_to_string(s : StatsdisthypergeoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdisthypergeoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_hypergeo_slice_make(size : Int) -> StatsdisthypergeoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_hypergeo_slice_len(s : StatsdisthypergeoSlice) -> Int { s.size }

pub fn stats_dist_hypergeo_slice_get(s : StatsdisthypergeoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_hypergeo_slice_set(s : StatsdisthypergeoSlice, i : Int, v : Double) -> StatsdisthypergeoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_slice_sum(s : StatsdisthypergeoSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_hypergeo_slice_mean(s : StatsdisthypergeoSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_hypergeo_slice_scale(s : StatsdisthypergeoSlice, f : Double) -> StatsdisthypergeoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_slice_add(a : StatsdisthypergeoSlice, b : StatsdisthypergeoSlice) -> StatsdisthypergeoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_hypergeo_slice_copy(s : StatsdisthypergeoSlice) -> StatsdisthypergeoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_slice_fill(s : StatsdisthypergeoSlice, v : Double) -> StatsdisthypergeoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_hypergeo_slice_min(s : StatsdisthypergeoSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_hypergeo_slice_max(s : StatsdisthypergeoSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_hypergeo_slice_to_string(s : StatsdisthypergeoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

