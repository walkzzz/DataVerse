///===
/// extcore/stats_test_f

pub(all) struct StatstestfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_f_make_point(x : Double, y : Double) -> StatstestfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_f_make_point3(x : Double, y : Double, z : Double) -> StatstestfPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_f_point_x(pt : StatstestfPoint) -> Double { pt.x }

pub fn stats_test_f_point_y(pt : StatstestfPoint) -> Double { pt.y }

pub fn stats_test_f_point_z(pt : StatstestfPoint) -> Double { pt.z }

pub fn stats_test_f_point_label(pt : StatstestfPoint) -> Int { pt.label }

pub fn stats_test_f_point_dist(a : StatstestfPoint, b : StatstestfPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_f_point_add(a : StatstestfPoint, b : StatstestfPoint) -> StatstestfPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_f_point_sub(a : StatstestfPoint, b : StatstestfPoint) -> StatstestfPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_f_point_scale(pt : StatstestfPoint, s : Double) -> StatstestfPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_f_point_dot(a : StatstestfPoint, b : StatstestfPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_f_point_cross(a : StatstestfPoint, b : StatstestfPoint) -> StatstestfPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_f_point_norm(pt : StatstestfPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_f_point_normalize(pt : StatstestfPoint) -> StatstestfPoint {
  let n = stats_test_f_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_f_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_f_point_negate(pt : StatstestfPoint) -> StatstestfPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_f_point_mid(a : StatstestfPoint, b : StatstestfPoint) -> StatstestfPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_f_point_lerp(a : StatstestfPoint, b : StatstestfPoint, t : Double) -> StatstestfPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_f_point_to_string(pt : StatstestfPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_f_make_series(vals : Array[Double], name : String) -> StatstestfSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_f_series_len(s : StatstestfSeries) -> Int { s.vals.length() }

pub fn stats_test_f_series_sum(s : StatstestfSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_test_f_series_mean(s : StatstestfSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_test_f_series_min(s : StatstestfSeries) -> Double { @_common.min(s.vals) }

pub fn stats_test_f_series_max(s : StatstestfSeries) -> Double { @_common.max(s.vals) }

pub fn stats_test_f_series_range(s : StatstestfSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_test_f_series_var(s : StatstestfSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_test_f_series_std(s : StatstestfSeries) -> Double { @_common.std(s.vals) }

pub fn stats_test_f_series_median(s : StatstestfSeries) -> Double { @_common.median(s.vals) }

pub fn stats_test_f_series_scale(s : StatstestfSeries, f : Double) -> StatstestfSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_f_series_add(a : StatstestfSeries, b : StatstestfSeries) -> StatstestfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_f_series_sub(a : StatstestfSeries, b : StatstestfSeries) -> StatstestfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_f_series_normalize(s : StatstestfSeries) -> StatstestfSeries {
  let mn = stats_test_f_series_min(s)
  let mx = stats_test_f_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_f_series_cumsum(s : StatstestfSeries) -> StatstestfSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_f_series_to_string(s : StatstestfSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_f_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_f_matrix_identity(n : Int) -> StatstestfMatrix {
  let m = stats_test_f_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_f_matrix_get(m : StatstestfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_f_matrix_transpose(m : StatstestfMatrix) -> StatstestfMatrix {
  let result = stats_test_f_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_f_matrix_add(a : StatstestfMatrix, b : StatstestfMatrix) -> StatstestfMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_f_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_f_matrix_scale(m : StatstestfMatrix, s : Double) -> StatstestfMatrix {
  let result = stats_test_f_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_f_matrix_multiply(a : StatstestfMatrix, b : StatstestfMatrix) -> StatstestfMatrix {
  if a.cols != b.rows { return stats_test_f_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_f_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_f_matrix_trace(m : StatstestfMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_f_matrix_det(m : StatstestfMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_f_matrix_norm(m : StatstestfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_f_matrix_to_string(m : StatstestfMatrix) -> String {
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

pub(all) struct StatstestfVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_f_make_vector(comps : Array[Double]) -> StatstestfVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_f_vector_zero(dim : Int) -> StatstestfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_f_vector_add(a : StatstestfVector, b : StatstestfVector) -> StatstestfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_f_vector_sub(a : StatstestfVector, b : StatstestfVector) -> StatstestfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_f_vector_scale(v : StatstestfVector, s : Double) -> StatstestfVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_f_vector_dot(a : StatstestfVector, b : StatstestfVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_f_vector_norm(v : StatstestfVector) -> Double { @_common.sqrt(stats_test_f_vector_dot(v, v)) }

pub fn stats_test_f_vector_normalize(v : StatstestfVector) -> StatstestfVector {
  let n = stats_test_f_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_f_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_f_vector_dist(a : StatstestfVector, b : StatstestfVector) -> Double {
  stats_test_f_vector_norm(stats_test_f_vector_sub(a, b))
}

pub fn stats_test_f_vector_to_string(v : StatstestfVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_f_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_f_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_f_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_f_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_f_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_f_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_f_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_f_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_f_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_f_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_f_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_f_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_f_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_f_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_f_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_f_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_f_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_f_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_f_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_f_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_f_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_f_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_f_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_f_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_f_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_f_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_f_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_f_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_f_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_frame_make(size : Int) -> StatstestfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_frame_len(s : StatstestfFrame) -> Int { s.size }

pub fn stats_test_f_frame_get(s : StatstestfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_frame_set(s : StatstestfFrame, i : Int, v : Double) -> StatstestfFrame {
  let result = stats_test_f_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_frame_sum(s : StatstestfFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_frame_mean(s : StatstestfFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_frame_scale(s : StatstestfFrame, f : Double) -> StatstestfFrame {
  let result = stats_test_f_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_frame_add(a : StatstestfFrame, b : StatstestfFrame) -> StatstestfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_frame_copy(s : StatstestfFrame) -> StatstestfFrame {
  let result = stats_test_f_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_frame_fill(s : StatstestfFrame, v : Double) -> StatstestfFrame {
  let result = stats_test_f_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_frame_min(s : StatstestfFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_f_frame_max(s : StatstestfFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_f_frame_to_string(s : StatstestfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_table_make(size : Int) -> StatstestfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_table_len(s : StatstestfTable) -> Int { s.size }

pub fn stats_test_f_table_get(s : StatstestfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_table_set(s : StatstestfTable, i : Int, v : Double) -> StatstestfTable {
  let result = stats_test_f_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_table_sum(s : StatstestfTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_table_mean(s : StatstestfTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_table_scale(s : StatstestfTable, f : Double) -> StatstestfTable {
  let result = stats_test_f_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_table_add(a : StatstestfTable, b : StatstestfTable) -> StatstestfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_table_copy(s : StatstestfTable) -> StatstestfTable {
  let result = stats_test_f_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_table_fill(s : StatstestfTable, v : Double) -> StatstestfTable {
  let result = stats_test_f_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_table_min(s : StatstestfTable) -> Double { @_common.min(s.data) }

pub fn stats_test_f_table_max(s : StatstestfTable) -> Double { @_common.max(s.data) }

pub fn stats_test_f_table_to_string(s : StatstestfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_graphn_make(size : Int) -> StatstestfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_graphn_len(s : StatstestfGraphN) -> Int { s.size }

pub fn stats_test_f_graphn_get(s : StatstestfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_graphn_set(s : StatstestfGraphN, i : Int, v : Double) -> StatstestfGraphN {
  let result = stats_test_f_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_graphn_sum(s : StatstestfGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_graphn_mean(s : StatstestfGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_graphn_scale(s : StatstestfGraphN, f : Double) -> StatstestfGraphN {
  let result = stats_test_f_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_graphn_add(a : StatstestfGraphN, b : StatstestfGraphN) -> StatstestfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_graphn_copy(s : StatstestfGraphN) -> StatstestfGraphN {
  let result = stats_test_f_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_graphn_fill(s : StatstestfGraphN, v : Double) -> StatstestfGraphN {
  let result = stats_test_f_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_graphn_min(s : StatstestfGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_f_graphn_max(s : StatstestfGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_f_graphn_to_string(s : StatstestfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_node_make(size : Int) -> StatstestfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_node_len(s : StatstestfNode) -> Int { s.size }

pub fn stats_test_f_node_get(s : StatstestfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_node_set(s : StatstestfNode, i : Int, v : Double) -> StatstestfNode {
  let result = stats_test_f_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_node_sum(s : StatstestfNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_node_mean(s : StatstestfNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_node_scale(s : StatstestfNode, f : Double) -> StatstestfNode {
  let result = stats_test_f_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_node_add(a : StatstestfNode, b : StatstestfNode) -> StatstestfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_node_copy(s : StatstestfNode) -> StatstestfNode {
  let result = stats_test_f_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_node_fill(s : StatstestfNode, v : Double) -> StatstestfNode {
  let result = stats_test_f_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_node_min(s : StatstestfNode) -> Double { @_common.min(s.data) }

pub fn stats_test_f_node_max(s : StatstestfNode) -> Double { @_common.max(s.data) }

pub fn stats_test_f_node_to_string(s : StatstestfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_edge_make(size : Int) -> StatstestfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_edge_len(s : StatstestfEdge) -> Int { s.size }

pub fn stats_test_f_edge_get(s : StatstestfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_edge_set(s : StatstestfEdge, i : Int, v : Double) -> StatstestfEdge {
  let result = stats_test_f_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_edge_sum(s : StatstestfEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_edge_mean(s : StatstestfEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_edge_scale(s : StatstestfEdge, f : Double) -> StatstestfEdge {
  let result = stats_test_f_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_edge_add(a : StatstestfEdge, b : StatstestfEdge) -> StatstestfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_edge_copy(s : StatstestfEdge) -> StatstestfEdge {
  let result = stats_test_f_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_edge_fill(s : StatstestfEdge, v : Double) -> StatstestfEdge {
  let result = stats_test_f_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_edge_min(s : StatstestfEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_f_edge_max(s : StatstestfEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_f_edge_to_string(s : StatstestfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_path_make(size : Int) -> StatstestfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_path_len(s : StatstestfPath) -> Int { s.size }

pub fn stats_test_f_path_get(s : StatstestfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_path_set(s : StatstestfPath, i : Int, v : Double) -> StatstestfPath {
  let result = stats_test_f_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_path_sum(s : StatstestfPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_path_mean(s : StatstestfPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_path_scale(s : StatstestfPath, f : Double) -> StatstestfPath {
  let result = stats_test_f_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_path_add(a : StatstestfPath, b : StatstestfPath) -> StatstestfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_path_copy(s : StatstestfPath) -> StatstestfPath {
  let result = stats_test_f_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_path_fill(s : StatstestfPath, v : Double) -> StatstestfPath {
  let result = stats_test_f_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_path_min(s : StatstestfPath) -> Double { @_common.min(s.data) }

pub fn stats_test_f_path_max(s : StatstestfPath) -> Double { @_common.max(s.data) }

pub fn stats_test_f_path_to_string(s : StatstestfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_cluster_make(size : Int) -> StatstestfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_cluster_len(s : StatstestfCluster) -> Int { s.size }

pub fn stats_test_f_cluster_get(s : StatstestfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_cluster_set(s : StatstestfCluster, i : Int, v : Double) -> StatstestfCluster {
  let result = stats_test_f_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_cluster_sum(s : StatstestfCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_cluster_mean(s : StatstestfCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_cluster_scale(s : StatstestfCluster, f : Double) -> StatstestfCluster {
  let result = stats_test_f_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_cluster_add(a : StatstestfCluster, b : StatstestfCluster) -> StatstestfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_cluster_copy(s : StatstestfCluster) -> StatstestfCluster {
  let result = stats_test_f_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_cluster_fill(s : StatstestfCluster, v : Double) -> StatstestfCluster {
  let result = stats_test_f_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_cluster_min(s : StatstestfCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_f_cluster_max(s : StatstestfCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_f_cluster_to_string(s : StatstestfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_model_make(size : Int) -> StatstestfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_model_len(s : StatstestfModel) -> Int { s.size }

pub fn stats_test_f_model_get(s : StatstestfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_model_set(s : StatstestfModel, i : Int, v : Double) -> StatstestfModel {
  let result = stats_test_f_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_model_sum(s : StatstestfModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_model_mean(s : StatstestfModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_model_scale(s : StatstestfModel, f : Double) -> StatstestfModel {
  let result = stats_test_f_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_model_add(a : StatstestfModel, b : StatstestfModel) -> StatstestfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_model_copy(s : StatstestfModel) -> StatstestfModel {
  let result = stats_test_f_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_model_fill(s : StatstestfModel, v : Double) -> StatstestfModel {
  let result = stats_test_f_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_model_min(s : StatstestfModel) -> Double { @_common.min(s.data) }

pub fn stats_test_f_model_max(s : StatstestfModel) -> Double { @_common.max(s.data) }

pub fn stats_test_f_model_to_string(s : StatstestfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_layer_make(size : Int) -> StatstestfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_layer_len(s : StatstestfLayer) -> Int { s.size }

pub fn stats_test_f_layer_get(s : StatstestfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_layer_set(s : StatstestfLayer, i : Int, v : Double) -> StatstestfLayer {
  let result = stats_test_f_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_layer_sum(s : StatstestfLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_layer_mean(s : StatstestfLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_layer_scale(s : StatstestfLayer, f : Double) -> StatstestfLayer {
  let result = stats_test_f_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_layer_add(a : StatstestfLayer, b : StatstestfLayer) -> StatstestfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_layer_copy(s : StatstestfLayer) -> StatstestfLayer {
  let result = stats_test_f_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_layer_fill(s : StatstestfLayer, v : Double) -> StatstestfLayer {
  let result = stats_test_f_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_layer_min(s : StatstestfLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_f_layer_max(s : StatstestfLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_f_layer_to_string(s : StatstestfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_buffer_make(size : Int) -> StatstestfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_buffer_len(s : StatstestfBuffer) -> Int { s.size }

pub fn stats_test_f_buffer_get(s : StatstestfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_buffer_set(s : StatstestfBuffer, i : Int, v : Double) -> StatstestfBuffer {
  let result = stats_test_f_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_buffer_sum(s : StatstestfBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_buffer_mean(s : StatstestfBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_buffer_scale(s : StatstestfBuffer, f : Double) -> StatstestfBuffer {
  let result = stats_test_f_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_buffer_add(a : StatstestfBuffer, b : StatstestfBuffer) -> StatstestfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_buffer_copy(s : StatstestfBuffer) -> StatstestfBuffer {
  let result = stats_test_f_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_buffer_fill(s : StatstestfBuffer, v : Double) -> StatstestfBuffer {
  let result = stats_test_f_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_buffer_min(s : StatstestfBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_f_buffer_max(s : StatstestfBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_f_buffer_to_string(s : StatstestfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_cursor_make(size : Int) -> StatstestfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_cursor_len(s : StatstestfCursor) -> Int { s.size }

pub fn stats_test_f_cursor_get(s : StatstestfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_cursor_set(s : StatstestfCursor, i : Int, v : Double) -> StatstestfCursor {
  let result = stats_test_f_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_cursor_sum(s : StatstestfCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_cursor_mean(s : StatstestfCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_cursor_scale(s : StatstestfCursor, f : Double) -> StatstestfCursor {
  let result = stats_test_f_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_cursor_add(a : StatstestfCursor, b : StatstestfCursor) -> StatstestfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_cursor_copy(s : StatstestfCursor) -> StatstestfCursor {
  let result = stats_test_f_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_cursor_fill(s : StatstestfCursor, v : Double) -> StatstestfCursor {
  let result = stats_test_f_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_cursor_min(s : StatstestfCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_f_cursor_max(s : StatstestfCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_f_cursor_to_string(s : StatstestfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_view_make(size : Int) -> StatstestfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_view_len(s : StatstestfView) -> Int { s.size }

pub fn stats_test_f_view_get(s : StatstestfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_view_set(s : StatstestfView, i : Int, v : Double) -> StatstestfView {
  let result = stats_test_f_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_view_sum(s : StatstestfView) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_view_mean(s : StatstestfView) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_view_scale(s : StatstestfView, f : Double) -> StatstestfView {
  let result = stats_test_f_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_view_add(a : StatstestfView, b : StatstestfView) -> StatstestfView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_view_copy(s : StatstestfView) -> StatstestfView {
  let result = stats_test_f_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_view_fill(s : StatstestfView, v : Double) -> StatstestfView {
  let result = stats_test_f_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_view_min(s : StatstestfView) -> Double { @_common.min(s.data) }

pub fn stats_test_f_view_max(s : StatstestfView) -> Double { @_common.max(s.data) }

pub fn stats_test_f_view_to_string(s : StatstestfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_range_make(size : Int) -> StatstestfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_range_len(s : StatstestfRange) -> Int { s.size }

pub fn stats_test_f_range_get(s : StatstestfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_range_set(s : StatstestfRange, i : Int, v : Double) -> StatstestfRange {
  let result = stats_test_f_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_range_sum(s : StatstestfRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_range_mean(s : StatstestfRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_range_scale(s : StatstestfRange, f : Double) -> StatstestfRange {
  let result = stats_test_f_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_range_add(a : StatstestfRange, b : StatstestfRange) -> StatstestfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_range_copy(s : StatstestfRange) -> StatstestfRange {
  let result = stats_test_f_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_range_fill(s : StatstestfRange, v : Double) -> StatstestfRange {
  let result = stats_test_f_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_range_min(s : StatstestfRange) -> Double { @_common.min(s.data) }

pub fn stats_test_f_range_max(s : StatstestfRange) -> Double { @_common.max(s.data) }

pub fn stats_test_f_range_to_string(s : StatstestfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_slice_make(size : Int) -> StatstestfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_slice_len(s : StatstestfSlice) -> Int { s.size }

pub fn stats_test_f_slice_get(s : StatstestfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_slice_set(s : StatstestfSlice, i : Int, v : Double) -> StatstestfSlice {
  let result = stats_test_f_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_slice_sum(s : StatstestfSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_slice_mean(s : StatstestfSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_slice_scale(s : StatstestfSlice, f : Double) -> StatstestfSlice {
  let result = stats_test_f_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_f_slice_add(a : StatstestfSlice, b : StatstestfSlice) -> StatstestfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_f_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_f_slice_copy(s : StatstestfSlice) -> StatstestfSlice {
  let result = stats_test_f_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_f_slice_fill(s : StatstestfSlice, v : Double) -> StatstestfSlice {
  let result = stats_test_f_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_f_slice_min(s : StatstestfSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_f_slice_max(s : StatstestfSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_f_slice_to_string(s : StatstestfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

