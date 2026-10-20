///===
/// extcore/stats_dist_f

pub(all) struct StatsdistfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_f_make_point(x : Double, y : Double) -> StatsdistfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_f_make_point3(x : Double, y : Double, z : Double) -> StatsdistfPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_f_point_x(pt : StatsdistfPoint) -> Double { pt.x }

pub fn stats_dist_f_point_y(pt : StatsdistfPoint) -> Double { pt.y }

pub fn stats_dist_f_point_z(pt : StatsdistfPoint) -> Double { pt.z }

pub fn stats_dist_f_point_label(pt : StatsdistfPoint) -> Int { pt.label }

pub fn stats_dist_f_point_dist(a : StatsdistfPoint, b : StatsdistfPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_f_point_add(a : StatsdistfPoint, b : StatsdistfPoint) -> StatsdistfPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_f_point_sub(a : StatsdistfPoint, b : StatsdistfPoint) -> StatsdistfPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_f_point_scale(pt : StatsdistfPoint, s : Double) -> StatsdistfPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_f_point_dot(a : StatsdistfPoint, b : StatsdistfPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_f_point_cross(a : StatsdistfPoint, b : StatsdistfPoint) -> StatsdistfPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_f_point_norm(pt : StatsdistfPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_f_point_normalize(pt : StatsdistfPoint) -> StatsdistfPoint {
  let n = stats_dist_f_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_f_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_f_point_negate(pt : StatsdistfPoint) -> StatsdistfPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_f_point_mid(a : StatsdistfPoint, b : StatsdistfPoint) -> StatsdistfPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_f_point_lerp(a : StatsdistfPoint, b : StatsdistfPoint, t : Double) -> StatsdistfPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_f_point_to_string(pt : StatsdistfPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_f_make_series(vals : Array[Double], name : String) -> StatsdistfSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_f_series_len(s : StatsdistfSeries) -> Int { s.vals.length() }

pub fn stats_dist_f_series_sum(s : StatsdistfSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_f_series_mean(s : StatsdistfSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_f_series_min(s : StatsdistfSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_f_series_max(s : StatsdistfSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_f_series_range(s : StatsdistfSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_f_series_var(s : StatsdistfSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_f_series_std(s : StatsdistfSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_f_series_median(s : StatsdistfSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_f_series_scale(s : StatsdistfSeries, f : Double) -> StatsdistfSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_f_series_add(a : StatsdistfSeries, b : StatsdistfSeries) -> StatsdistfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_f_series_sub(a : StatsdistfSeries, b : StatsdistfSeries) -> StatsdistfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_f_series_normalize(s : StatsdistfSeries) -> StatsdistfSeries {
  let mn = stats_dist_f_series_min(s)
  let mx = stats_dist_f_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_f_series_cumsum(s : StatsdistfSeries) -> StatsdistfSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_f_series_to_string(s : StatsdistfSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_f_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_f_matrix_identity(n : Int) -> StatsdistfMatrix {
  let m = stats_dist_f_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_f_matrix_get(m : StatsdistfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_f_matrix_transpose(m : StatsdistfMatrix) -> StatsdistfMatrix {
  let result = stats_dist_f_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_f_matrix_add(a : StatsdistfMatrix, b : StatsdistfMatrix) -> StatsdistfMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_f_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_f_matrix_scale(m : StatsdistfMatrix, s : Double) -> StatsdistfMatrix {
  let result = stats_dist_f_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_f_matrix_multiply(a : StatsdistfMatrix, b : StatsdistfMatrix) -> StatsdistfMatrix {
  if a.cols != b.rows { return stats_dist_f_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_f_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_f_matrix_trace(m : StatsdistfMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_f_matrix_det(m : StatsdistfMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_f_matrix_norm(m : StatsdistfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_f_matrix_to_string(m : StatsdistfMatrix) -> String {
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

pub(all) struct StatsdistfVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_f_make_vector(comps : Array[Double]) -> StatsdistfVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_f_vector_zero(dim : Int) -> StatsdistfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_f_vector_add(a : StatsdistfVector, b : StatsdistfVector) -> StatsdistfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_f_vector_sub(a : StatsdistfVector, b : StatsdistfVector) -> StatsdistfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_f_vector_scale(v : StatsdistfVector, s : Double) -> StatsdistfVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_f_vector_dot(a : StatsdistfVector, b : StatsdistfVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_f_vector_norm(v : StatsdistfVector) -> Double { @_common.sqrt(stats_dist_f_vector_dot(v, v)) }

pub fn stats_dist_f_vector_normalize(v : StatsdistfVector) -> StatsdistfVector {
  let n = stats_dist_f_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_f_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_f_vector_dist(a : StatsdistfVector, b : StatsdistfVector) -> Double {
  stats_dist_f_vector_norm(stats_dist_f_vector_sub(a, b))
}

pub fn stats_dist_f_vector_to_string(v : StatsdistfVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_f_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_f_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_f_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_f_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_f_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_f_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_f_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_f_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_f_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_f_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_f_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_f_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_f_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_f_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_f_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_f_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_f_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_f_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_f_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_f_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_f_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_f_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_f_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_f_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_f_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_f_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_f_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_f_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_f_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_frame_make(size : Int) -> StatsdistfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_frame_len(s : StatsdistfFrame) -> Int { s.size }

pub fn stats_dist_f_frame_get(s : StatsdistfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_frame_set(s : StatsdistfFrame, i : Int, v : Double) -> StatsdistfFrame {
  let result = stats_dist_f_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_frame_sum(s : StatsdistfFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_frame_mean(s : StatsdistfFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_frame_scale(s : StatsdistfFrame, f : Double) -> StatsdistfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_frame_add(a : StatsdistfFrame, b : StatsdistfFrame) -> StatsdistfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_frame_copy(s : StatsdistfFrame) -> StatsdistfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_frame_fill(s : StatsdistfFrame, v : Double) -> StatsdistfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_frame_min(s : StatsdistfFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_frame_max(s : StatsdistfFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_frame_to_string(s : StatsdistfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_table_make(size : Int) -> StatsdistfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_table_len(s : StatsdistfTable) -> Int { s.size }

pub fn stats_dist_f_table_get(s : StatsdistfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_table_set(s : StatsdistfTable, i : Int, v : Double) -> StatsdistfTable {
  let result = stats_dist_f_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_table_sum(s : StatsdistfTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_table_mean(s : StatsdistfTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_table_scale(s : StatsdistfTable, f : Double) -> StatsdistfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_table_add(a : StatsdistfTable, b : StatsdistfTable) -> StatsdistfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_table_copy(s : StatsdistfTable) -> StatsdistfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_table_fill(s : StatsdistfTable, v : Double) -> StatsdistfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_table_min(s : StatsdistfTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_table_max(s : StatsdistfTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_table_to_string(s : StatsdistfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_graphn_make(size : Int) -> StatsdistfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_graphn_len(s : StatsdistfGraphN) -> Int { s.size }

pub fn stats_dist_f_graphn_get(s : StatsdistfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_graphn_set(s : StatsdistfGraphN, i : Int, v : Double) -> StatsdistfGraphN {
  let result = stats_dist_f_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_graphn_sum(s : StatsdistfGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_graphn_mean(s : StatsdistfGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_graphn_scale(s : StatsdistfGraphN, f : Double) -> StatsdistfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_graphn_add(a : StatsdistfGraphN, b : StatsdistfGraphN) -> StatsdistfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_graphn_copy(s : StatsdistfGraphN) -> StatsdistfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_graphn_fill(s : StatsdistfGraphN, v : Double) -> StatsdistfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_graphn_min(s : StatsdistfGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_graphn_max(s : StatsdistfGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_graphn_to_string(s : StatsdistfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_node_make(size : Int) -> StatsdistfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_node_len(s : StatsdistfNode) -> Int { s.size }

pub fn stats_dist_f_node_get(s : StatsdistfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_node_set(s : StatsdistfNode, i : Int, v : Double) -> StatsdistfNode {
  let result = stats_dist_f_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_node_sum(s : StatsdistfNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_node_mean(s : StatsdistfNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_node_scale(s : StatsdistfNode, f : Double) -> StatsdistfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_node_add(a : StatsdistfNode, b : StatsdistfNode) -> StatsdistfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_node_copy(s : StatsdistfNode) -> StatsdistfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_node_fill(s : StatsdistfNode, v : Double) -> StatsdistfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_node_min(s : StatsdistfNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_node_max(s : StatsdistfNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_node_to_string(s : StatsdistfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_edge_make(size : Int) -> StatsdistfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_edge_len(s : StatsdistfEdge) -> Int { s.size }

pub fn stats_dist_f_edge_get(s : StatsdistfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_edge_set(s : StatsdistfEdge, i : Int, v : Double) -> StatsdistfEdge {
  let result = stats_dist_f_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_edge_sum(s : StatsdistfEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_edge_mean(s : StatsdistfEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_edge_scale(s : StatsdistfEdge, f : Double) -> StatsdistfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_edge_add(a : StatsdistfEdge, b : StatsdistfEdge) -> StatsdistfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_edge_copy(s : StatsdistfEdge) -> StatsdistfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_edge_fill(s : StatsdistfEdge, v : Double) -> StatsdistfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_edge_min(s : StatsdistfEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_edge_max(s : StatsdistfEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_edge_to_string(s : StatsdistfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_path_make(size : Int) -> StatsdistfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_path_len(s : StatsdistfPath) -> Int { s.size }

pub fn stats_dist_f_path_get(s : StatsdistfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_path_set(s : StatsdistfPath, i : Int, v : Double) -> StatsdistfPath {
  let result = stats_dist_f_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_path_sum(s : StatsdistfPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_path_mean(s : StatsdistfPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_path_scale(s : StatsdistfPath, f : Double) -> StatsdistfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_path_add(a : StatsdistfPath, b : StatsdistfPath) -> StatsdistfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_path_copy(s : StatsdistfPath) -> StatsdistfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_path_fill(s : StatsdistfPath, v : Double) -> StatsdistfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_path_min(s : StatsdistfPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_path_max(s : StatsdistfPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_path_to_string(s : StatsdistfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_cluster_make(size : Int) -> StatsdistfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_cluster_len(s : StatsdistfCluster) -> Int { s.size }

pub fn stats_dist_f_cluster_get(s : StatsdistfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_cluster_set(s : StatsdistfCluster, i : Int, v : Double) -> StatsdistfCluster {
  let result = stats_dist_f_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_cluster_sum(s : StatsdistfCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_cluster_mean(s : StatsdistfCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_cluster_scale(s : StatsdistfCluster, f : Double) -> StatsdistfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cluster_add(a : StatsdistfCluster, b : StatsdistfCluster) -> StatsdistfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_cluster_copy(s : StatsdistfCluster) -> StatsdistfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cluster_fill(s : StatsdistfCluster, v : Double) -> StatsdistfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cluster_min(s : StatsdistfCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_cluster_max(s : StatsdistfCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_cluster_to_string(s : StatsdistfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_model_make(size : Int) -> StatsdistfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_model_len(s : StatsdistfModel) -> Int { s.size }

pub fn stats_dist_f_model_get(s : StatsdistfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_model_set(s : StatsdistfModel, i : Int, v : Double) -> StatsdistfModel {
  let result = stats_dist_f_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_model_sum(s : StatsdistfModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_model_mean(s : StatsdistfModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_model_scale(s : StatsdistfModel, f : Double) -> StatsdistfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_model_add(a : StatsdistfModel, b : StatsdistfModel) -> StatsdistfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_model_copy(s : StatsdistfModel) -> StatsdistfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_model_fill(s : StatsdistfModel, v : Double) -> StatsdistfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_model_min(s : StatsdistfModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_model_max(s : StatsdistfModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_model_to_string(s : StatsdistfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_layer_make(size : Int) -> StatsdistfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_layer_len(s : StatsdistfLayer) -> Int { s.size }

pub fn stats_dist_f_layer_get(s : StatsdistfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_layer_set(s : StatsdistfLayer, i : Int, v : Double) -> StatsdistfLayer {
  let result = stats_dist_f_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_layer_sum(s : StatsdistfLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_layer_mean(s : StatsdistfLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_layer_scale(s : StatsdistfLayer, f : Double) -> StatsdistfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_layer_add(a : StatsdistfLayer, b : StatsdistfLayer) -> StatsdistfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_layer_copy(s : StatsdistfLayer) -> StatsdistfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_layer_fill(s : StatsdistfLayer, v : Double) -> StatsdistfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_layer_min(s : StatsdistfLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_layer_max(s : StatsdistfLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_layer_to_string(s : StatsdistfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_buffer_make(size : Int) -> StatsdistfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_buffer_len(s : StatsdistfBuffer) -> Int { s.size }

pub fn stats_dist_f_buffer_get(s : StatsdistfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_buffer_set(s : StatsdistfBuffer, i : Int, v : Double) -> StatsdistfBuffer {
  let result = stats_dist_f_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_buffer_sum(s : StatsdistfBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_buffer_mean(s : StatsdistfBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_buffer_scale(s : StatsdistfBuffer, f : Double) -> StatsdistfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_buffer_add(a : StatsdistfBuffer, b : StatsdistfBuffer) -> StatsdistfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_buffer_copy(s : StatsdistfBuffer) -> StatsdistfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_buffer_fill(s : StatsdistfBuffer, v : Double) -> StatsdistfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_buffer_min(s : StatsdistfBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_buffer_max(s : StatsdistfBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_buffer_to_string(s : StatsdistfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_cursor_make(size : Int) -> StatsdistfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_cursor_len(s : StatsdistfCursor) -> Int { s.size }

pub fn stats_dist_f_cursor_get(s : StatsdistfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_cursor_set(s : StatsdistfCursor, i : Int, v : Double) -> StatsdistfCursor {
  let result = stats_dist_f_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_cursor_sum(s : StatsdistfCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_cursor_mean(s : StatsdistfCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_cursor_scale(s : StatsdistfCursor, f : Double) -> StatsdistfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cursor_add(a : StatsdistfCursor, b : StatsdistfCursor) -> StatsdistfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_cursor_copy(s : StatsdistfCursor) -> StatsdistfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cursor_fill(s : StatsdistfCursor, v : Double) -> StatsdistfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cursor_min(s : StatsdistfCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_cursor_max(s : StatsdistfCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_cursor_to_string(s : StatsdistfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_view_make(size : Int) -> StatsdistfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_view_len(s : StatsdistfView) -> Int { s.size }

pub fn stats_dist_f_view_get(s : StatsdistfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_view_set(s : StatsdistfView, i : Int, v : Double) -> StatsdistfView {
  let result = stats_dist_f_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_view_sum(s : StatsdistfView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_view_mean(s : StatsdistfView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_view_scale(s : StatsdistfView, f : Double) -> StatsdistfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_view_add(a : StatsdistfView, b : StatsdistfView) -> StatsdistfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_view_copy(s : StatsdistfView) -> StatsdistfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_view_fill(s : StatsdistfView, v : Double) -> StatsdistfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_view_min(s : StatsdistfView) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_view_max(s : StatsdistfView) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_view_to_string(s : StatsdistfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_range_make(size : Int) -> StatsdistfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_range_len(s : StatsdistfRange) -> Int { s.size }

pub fn stats_dist_f_range_get(s : StatsdistfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_range_set(s : StatsdistfRange, i : Int, v : Double) -> StatsdistfRange {
  let result = stats_dist_f_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_range_sum(s : StatsdistfRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_range_mean(s : StatsdistfRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_range_scale(s : StatsdistfRange, f : Double) -> StatsdistfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_range_add(a : StatsdistfRange, b : StatsdistfRange) -> StatsdistfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_range_copy(s : StatsdistfRange) -> StatsdistfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_range_fill(s : StatsdistfRange, v : Double) -> StatsdistfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_range_min(s : StatsdistfRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_range_max(s : StatsdistfRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_range_to_string(s : StatsdistfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_slice_make(size : Int) -> StatsdistfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_slice_len(s : StatsdistfSlice) -> Int { s.size }

pub fn stats_dist_f_slice_get(s : StatsdistfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_slice_set(s : StatsdistfSlice, i : Int, v : Double) -> StatsdistfSlice {
  let result = stats_dist_f_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_f_slice_sum(s : StatsdistfSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_slice_mean(s : StatsdistfSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_slice_scale(s : StatsdistfSlice, f : Double) -> StatsdistfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_slice_add(a : StatsdistfSlice, b : StatsdistfSlice) -> StatsdistfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_slice_copy(s : StatsdistfSlice) -> StatsdistfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_slice_fill(s : StatsdistfSlice, v : Double) -> StatsdistfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_slice_min(s : StatsdistfSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_slice_max(s : StatsdistfSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_slice_to_string(s : StatsdistfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

