///===
/// extcore/stats_desc_robust

pub(all) struct StatsdescrobustPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_robust_make_point(x : Double, y : Double) -> StatsdescrobustPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_robust_make_point3(x : Double, y : Double, z : Double) -> StatsdescrobustPoint {
  { x, y, z, label: 0 }
}

pub fn stats_desc_robust_point_x(pt : StatsdescrobustPoint) -> Double { pt.x }

pub fn stats_desc_robust_point_y(pt : StatsdescrobustPoint) -> Double { pt.y }

pub fn stats_desc_robust_point_z(pt : StatsdescrobustPoint) -> Double { pt.z }

pub fn stats_desc_robust_point_label(pt : StatsdescrobustPoint) -> Int { pt.label }

pub fn stats_desc_robust_point_dist(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_desc_robust_point_add(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_desc_robust_point_sub(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_desc_robust_point_scale(pt : StatsdescrobustPoint, s : Double) -> StatsdescrobustPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_desc_robust_point_dot(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_desc_robust_point_cross(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_desc_robust_point_norm(pt : StatsdescrobustPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_desc_robust_point_normalize(pt : StatsdescrobustPoint) -> StatsdescrobustPoint {
  let n = stats_desc_robust_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_desc_robust_point_scale(pt, 1.0 / n) }
}

pub fn stats_desc_robust_point_negate(pt : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_desc_robust_point_mid(a : StatsdescrobustPoint, b : StatsdescrobustPoint) -> StatsdescrobustPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_desc_robust_point_lerp(a : StatsdescrobustPoint, b : StatsdescrobustPoint, t : Double) -> StatsdescrobustPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_desc_robust_point_to_string(pt : StatsdescrobustPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdescrobustSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_robust_make_series(vals : Array[Double], name : String) -> StatsdescrobustSeries {
  { vals, name, meta: 0 }
}

pub fn stats_desc_robust_series_len(s : StatsdescrobustSeries) -> Int { s.vals.length() }

pub fn stats_desc_robust_series_sum(s : StatsdescrobustSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_desc_robust_series_mean(s : StatsdescrobustSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_desc_robust_series_min(s : StatsdescrobustSeries) -> Double { @_common.min(s.vals) }

pub fn stats_desc_robust_series_max(s : StatsdescrobustSeries) -> Double { @_common.max(s.vals) }

pub fn stats_desc_robust_series_range(s : StatsdescrobustSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_desc_robust_series_var(s : StatsdescrobustSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_desc_robust_series_std(s : StatsdescrobustSeries) -> Double { @_common.std(s.vals) }

pub fn stats_desc_robust_series_median(s : StatsdescrobustSeries) -> Double { @_common.median(s.vals) }

pub fn stats_desc_robust_series_scale(s : StatsdescrobustSeries, f : Double) -> StatsdescrobustSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_desc_robust_series_add(a : StatsdescrobustSeries, b : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_desc_robust_series_sub(a : StatsdescrobustSeries, b : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_desc_robust_series_normalize(s : StatsdescrobustSeries) -> StatsdescrobustSeries {
  let mn = stats_desc_robust_series_min(s)
  let mx = stats_desc_robust_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_desc_robust_series_cumsum(s : StatsdescrobustSeries) -> StatsdescrobustSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_desc_robust_series_to_string(s : StatsdescrobustSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescrobustMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_robust_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescrobustMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_robust_matrix_identity(n : Int) -> StatsdescrobustMatrix {
  let m = stats_desc_robust_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_desc_robust_matrix_get(m : StatsdescrobustMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_desc_robust_matrix_transpose(m : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  let result = stats_desc_robust_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_desc_robust_matrix_add(a : StatsdescrobustMatrix, b : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_desc_robust_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_desc_robust_matrix_scale(m : StatsdescrobustMatrix, s : Double) -> StatsdescrobustMatrix {
  let result = stats_desc_robust_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_desc_robust_matrix_multiply(a : StatsdescrobustMatrix, b : StatsdescrobustMatrix) -> StatsdescrobustMatrix {
  if a.cols != b.rows { return stats_desc_robust_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_desc_robust_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_desc_robust_matrix_trace(m : StatsdescrobustMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_desc_robust_matrix_det(m : StatsdescrobustMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_desc_robust_matrix_norm(m : StatsdescrobustMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_desc_robust_matrix_to_string(m : StatsdescrobustMatrix) -> String {
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

pub(all) struct StatsdescrobustVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_robust_make_vector(comps : Array[Double]) -> StatsdescrobustVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_robust_vector_zero(dim : Int) -> StatsdescrobustVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_desc_robust_vector_add(a : StatsdescrobustVector, b : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_robust_vector_sub(a : StatsdescrobustVector, b : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_robust_vector_scale(v : StatsdescrobustVector, s : Double) -> StatsdescrobustVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_desc_robust_vector_dot(a : StatsdescrobustVector, b : StatsdescrobustVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_desc_robust_vector_norm(v : StatsdescrobustVector) -> Double { @_common.sqrt(stats_desc_robust_vector_dot(v, v)) }

pub fn stats_desc_robust_vector_normalize(v : StatsdescrobustVector) -> StatsdescrobustVector {
  let n = stats_desc_robust_vector_norm(v)
  if n < 0.0000001 { v } else { stats_desc_robust_vector_scale(v, 1.0 / n) }
}

pub fn stats_desc_robust_vector_dist(a : StatsdescrobustVector, b : StatsdescrobustVector) -> Double {
  stats_desc_robust_vector_norm(stats_desc_robust_vector_sub(a, b))
}

pub fn stats_desc_robust_vector_to_string(v : StatsdescrobustVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_robust_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_robust_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_robust_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_robust_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_robust_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_robust_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_robust_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_robust_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_robust_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_robust_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_robust_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_robust_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_robust_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_robust_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_robust_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_robust_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_robust_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_robust_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_robust_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_robust_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_robust_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_robust_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_robust_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_robust_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_robust_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_robust_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_robust_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_robust_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_robust_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescrobustFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_frame_make(size : Int) -> StatsdescrobustFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_frame_len(s : StatsdescrobustFrame) -> Int { s.size }

pub fn stats_desc_robust_frame_get(s : StatsdescrobustFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_frame_set(s : StatsdescrobustFrame, i : Int, v : Double) -> StatsdescrobustFrame {
  let result = stats_desc_robust_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_frame_sum(s : StatsdescrobustFrame) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_frame_mean(s : StatsdescrobustFrame) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_frame_scale(s : StatsdescrobustFrame, f : Double) -> StatsdescrobustFrame {
  let result = stats_desc_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_frame_add(a : StatsdescrobustFrame, b : StatsdescrobustFrame) -> StatsdescrobustFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_frame_copy(s : StatsdescrobustFrame) -> StatsdescrobustFrame {
  let result = stats_desc_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_frame_fill(s : StatsdescrobustFrame, v : Double) -> StatsdescrobustFrame {
  let result = stats_desc_robust_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_frame_min(s : StatsdescrobustFrame) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_frame_max(s : StatsdescrobustFrame) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_frame_to_string(s : StatsdescrobustFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_table_make(size : Int) -> StatsdescrobustTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_table_len(s : StatsdescrobustTable) -> Int { s.size }

pub fn stats_desc_robust_table_get(s : StatsdescrobustTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_table_set(s : StatsdescrobustTable, i : Int, v : Double) -> StatsdescrobustTable {
  let result = stats_desc_robust_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_table_sum(s : StatsdescrobustTable) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_table_mean(s : StatsdescrobustTable) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_table_scale(s : StatsdescrobustTable, f : Double) -> StatsdescrobustTable {
  let result = stats_desc_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_table_add(a : StatsdescrobustTable, b : StatsdescrobustTable) -> StatsdescrobustTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_table_copy(s : StatsdescrobustTable) -> StatsdescrobustTable {
  let result = stats_desc_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_table_fill(s : StatsdescrobustTable, v : Double) -> StatsdescrobustTable {
  let result = stats_desc_robust_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_table_min(s : StatsdescrobustTable) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_table_max(s : StatsdescrobustTable) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_table_to_string(s : StatsdescrobustTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_graphn_make(size : Int) -> StatsdescrobustGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_graphn_len(s : StatsdescrobustGraphN) -> Int { s.size }

pub fn stats_desc_robust_graphn_get(s : StatsdescrobustGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_graphn_set(s : StatsdescrobustGraphN, i : Int, v : Double) -> StatsdescrobustGraphN {
  let result = stats_desc_robust_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_graphn_sum(s : StatsdescrobustGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_graphn_mean(s : StatsdescrobustGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_graphn_scale(s : StatsdescrobustGraphN, f : Double) -> StatsdescrobustGraphN {
  let result = stats_desc_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_graphn_add(a : StatsdescrobustGraphN, b : StatsdescrobustGraphN) -> StatsdescrobustGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_graphn_copy(s : StatsdescrobustGraphN) -> StatsdescrobustGraphN {
  let result = stats_desc_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_graphn_fill(s : StatsdescrobustGraphN, v : Double) -> StatsdescrobustGraphN {
  let result = stats_desc_robust_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_graphn_min(s : StatsdescrobustGraphN) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_graphn_max(s : StatsdescrobustGraphN) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_graphn_to_string(s : StatsdescrobustGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_node_make(size : Int) -> StatsdescrobustNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_node_len(s : StatsdescrobustNode) -> Int { s.size }

pub fn stats_desc_robust_node_get(s : StatsdescrobustNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_node_set(s : StatsdescrobustNode, i : Int, v : Double) -> StatsdescrobustNode {
  let result = stats_desc_robust_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_node_sum(s : StatsdescrobustNode) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_node_mean(s : StatsdescrobustNode) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_node_scale(s : StatsdescrobustNode, f : Double) -> StatsdescrobustNode {
  let result = stats_desc_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_node_add(a : StatsdescrobustNode, b : StatsdescrobustNode) -> StatsdescrobustNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_node_copy(s : StatsdescrobustNode) -> StatsdescrobustNode {
  let result = stats_desc_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_node_fill(s : StatsdescrobustNode, v : Double) -> StatsdescrobustNode {
  let result = stats_desc_robust_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_node_min(s : StatsdescrobustNode) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_node_max(s : StatsdescrobustNode) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_node_to_string(s : StatsdescrobustNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_edge_make(size : Int) -> StatsdescrobustEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_edge_len(s : StatsdescrobustEdge) -> Int { s.size }

pub fn stats_desc_robust_edge_get(s : StatsdescrobustEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_edge_set(s : StatsdescrobustEdge, i : Int, v : Double) -> StatsdescrobustEdge {
  let result = stats_desc_robust_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_edge_sum(s : StatsdescrobustEdge) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_edge_mean(s : StatsdescrobustEdge) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_edge_scale(s : StatsdescrobustEdge, f : Double) -> StatsdescrobustEdge {
  let result = stats_desc_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_edge_add(a : StatsdescrobustEdge, b : StatsdescrobustEdge) -> StatsdescrobustEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_edge_copy(s : StatsdescrobustEdge) -> StatsdescrobustEdge {
  let result = stats_desc_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_edge_fill(s : StatsdescrobustEdge, v : Double) -> StatsdescrobustEdge {
  let result = stats_desc_robust_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_edge_min(s : StatsdescrobustEdge) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_edge_max(s : StatsdescrobustEdge) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_edge_to_string(s : StatsdescrobustEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_path_make(size : Int) -> StatsdescrobustPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_path_len(s : StatsdescrobustPath) -> Int { s.size }

pub fn stats_desc_robust_path_get(s : StatsdescrobustPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_path_set(s : StatsdescrobustPath, i : Int, v : Double) -> StatsdescrobustPath {
  let result = stats_desc_robust_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_path_sum(s : StatsdescrobustPath) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_path_mean(s : StatsdescrobustPath) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_path_scale(s : StatsdescrobustPath, f : Double) -> StatsdescrobustPath {
  let result = stats_desc_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_path_add(a : StatsdescrobustPath, b : StatsdescrobustPath) -> StatsdescrobustPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_path_copy(s : StatsdescrobustPath) -> StatsdescrobustPath {
  let result = stats_desc_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_path_fill(s : StatsdescrobustPath, v : Double) -> StatsdescrobustPath {
  let result = stats_desc_robust_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_path_min(s : StatsdescrobustPath) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_path_max(s : StatsdescrobustPath) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_path_to_string(s : StatsdescrobustPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_cluster_make(size : Int) -> StatsdescrobustCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_cluster_len(s : StatsdescrobustCluster) -> Int { s.size }

pub fn stats_desc_robust_cluster_get(s : StatsdescrobustCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_cluster_set(s : StatsdescrobustCluster, i : Int, v : Double) -> StatsdescrobustCluster {
  let result = stats_desc_robust_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_cluster_sum(s : StatsdescrobustCluster) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_cluster_mean(s : StatsdescrobustCluster) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_cluster_scale(s : StatsdescrobustCluster, f : Double) -> StatsdescrobustCluster {
  let result = stats_desc_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_cluster_add(a : StatsdescrobustCluster, b : StatsdescrobustCluster) -> StatsdescrobustCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_cluster_copy(s : StatsdescrobustCluster) -> StatsdescrobustCluster {
  let result = stats_desc_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_cluster_fill(s : StatsdescrobustCluster, v : Double) -> StatsdescrobustCluster {
  let result = stats_desc_robust_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_cluster_min(s : StatsdescrobustCluster) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_cluster_max(s : StatsdescrobustCluster) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_cluster_to_string(s : StatsdescrobustCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_model_make(size : Int) -> StatsdescrobustModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_model_len(s : StatsdescrobustModel) -> Int { s.size }

pub fn stats_desc_robust_model_get(s : StatsdescrobustModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_model_set(s : StatsdescrobustModel, i : Int, v : Double) -> StatsdescrobustModel {
  let result = stats_desc_robust_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_model_sum(s : StatsdescrobustModel) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_model_mean(s : StatsdescrobustModel) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_model_scale(s : StatsdescrobustModel, f : Double) -> StatsdescrobustModel {
  let result = stats_desc_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_model_add(a : StatsdescrobustModel, b : StatsdescrobustModel) -> StatsdescrobustModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_model_copy(s : StatsdescrobustModel) -> StatsdescrobustModel {
  let result = stats_desc_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_model_fill(s : StatsdescrobustModel, v : Double) -> StatsdescrobustModel {
  let result = stats_desc_robust_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_model_min(s : StatsdescrobustModel) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_model_max(s : StatsdescrobustModel) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_model_to_string(s : StatsdescrobustModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_layer_make(size : Int) -> StatsdescrobustLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_layer_len(s : StatsdescrobustLayer) -> Int { s.size }

pub fn stats_desc_robust_layer_get(s : StatsdescrobustLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_layer_set(s : StatsdescrobustLayer, i : Int, v : Double) -> StatsdescrobustLayer {
  let result = stats_desc_robust_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_layer_sum(s : StatsdescrobustLayer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_layer_mean(s : StatsdescrobustLayer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_layer_scale(s : StatsdescrobustLayer, f : Double) -> StatsdescrobustLayer {
  let result = stats_desc_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_layer_add(a : StatsdescrobustLayer, b : StatsdescrobustLayer) -> StatsdescrobustLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_layer_copy(s : StatsdescrobustLayer) -> StatsdescrobustLayer {
  let result = stats_desc_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_layer_fill(s : StatsdescrobustLayer, v : Double) -> StatsdescrobustLayer {
  let result = stats_desc_robust_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_layer_min(s : StatsdescrobustLayer) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_layer_max(s : StatsdescrobustLayer) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_layer_to_string(s : StatsdescrobustLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_buffer_make(size : Int) -> StatsdescrobustBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_buffer_len(s : StatsdescrobustBuffer) -> Int { s.size }

pub fn stats_desc_robust_buffer_get(s : StatsdescrobustBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_buffer_set(s : StatsdescrobustBuffer, i : Int, v : Double) -> StatsdescrobustBuffer {
  let result = stats_desc_robust_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_buffer_sum(s : StatsdescrobustBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_buffer_mean(s : StatsdescrobustBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_buffer_scale(s : StatsdescrobustBuffer, f : Double) -> StatsdescrobustBuffer {
  let result = stats_desc_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_buffer_add(a : StatsdescrobustBuffer, b : StatsdescrobustBuffer) -> StatsdescrobustBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_buffer_copy(s : StatsdescrobustBuffer) -> StatsdescrobustBuffer {
  let result = stats_desc_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_buffer_fill(s : StatsdescrobustBuffer, v : Double) -> StatsdescrobustBuffer {
  let result = stats_desc_robust_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_buffer_min(s : StatsdescrobustBuffer) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_buffer_max(s : StatsdescrobustBuffer) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_buffer_to_string(s : StatsdescrobustBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_cursor_make(size : Int) -> StatsdescrobustCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_cursor_len(s : StatsdescrobustCursor) -> Int { s.size }

pub fn stats_desc_robust_cursor_get(s : StatsdescrobustCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_cursor_set(s : StatsdescrobustCursor, i : Int, v : Double) -> StatsdescrobustCursor {
  let result = stats_desc_robust_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_cursor_sum(s : StatsdescrobustCursor) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_cursor_mean(s : StatsdescrobustCursor) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_cursor_scale(s : StatsdescrobustCursor, f : Double) -> StatsdescrobustCursor {
  let result = stats_desc_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_cursor_add(a : StatsdescrobustCursor, b : StatsdescrobustCursor) -> StatsdescrobustCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_cursor_copy(s : StatsdescrobustCursor) -> StatsdescrobustCursor {
  let result = stats_desc_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_cursor_fill(s : StatsdescrobustCursor, v : Double) -> StatsdescrobustCursor {
  let result = stats_desc_robust_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_cursor_min(s : StatsdescrobustCursor) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_cursor_max(s : StatsdescrobustCursor) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_cursor_to_string(s : StatsdescrobustCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_view_make(size : Int) -> StatsdescrobustView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_view_len(s : StatsdescrobustView) -> Int { s.size }

pub fn stats_desc_robust_view_get(s : StatsdescrobustView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_view_set(s : StatsdescrobustView, i : Int, v : Double) -> StatsdescrobustView {
  let result = stats_desc_robust_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_view_sum(s : StatsdescrobustView) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_view_mean(s : StatsdescrobustView) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_view_scale(s : StatsdescrobustView, f : Double) -> StatsdescrobustView {
  let result = stats_desc_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_view_add(a : StatsdescrobustView, b : StatsdescrobustView) -> StatsdescrobustView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_view_copy(s : StatsdescrobustView) -> StatsdescrobustView {
  let result = stats_desc_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_view_fill(s : StatsdescrobustView, v : Double) -> StatsdescrobustView {
  let result = stats_desc_robust_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_view_min(s : StatsdescrobustView) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_view_max(s : StatsdescrobustView) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_view_to_string(s : StatsdescrobustView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_range_make(size : Int) -> StatsdescrobustRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_range_len(s : StatsdescrobustRange) -> Int { s.size }

pub fn stats_desc_robust_range_get(s : StatsdescrobustRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_range_set(s : StatsdescrobustRange, i : Int, v : Double) -> StatsdescrobustRange {
  let result = stats_desc_robust_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_range_sum(s : StatsdescrobustRange) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_range_mean(s : StatsdescrobustRange) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_range_scale(s : StatsdescrobustRange, f : Double) -> StatsdescrobustRange {
  let result = stats_desc_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_range_add(a : StatsdescrobustRange, b : StatsdescrobustRange) -> StatsdescrobustRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_range_copy(s : StatsdescrobustRange) -> StatsdescrobustRange {
  let result = stats_desc_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_range_fill(s : StatsdescrobustRange, v : Double) -> StatsdescrobustRange {
  let result = stats_desc_robust_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_range_min(s : StatsdescrobustRange) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_range_max(s : StatsdescrobustRange) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_range_to_string(s : StatsdescrobustRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescrobustSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_robust_slice_make(size : Int) -> StatsdescrobustSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_robust_slice_len(s : StatsdescrobustSlice) -> Int { s.size }

pub fn stats_desc_robust_slice_get(s : StatsdescrobustSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_robust_slice_set(s : StatsdescrobustSlice, i : Int, v : Double) -> StatsdescrobustSlice {
  let result = stats_desc_robust_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_slice_sum(s : StatsdescrobustSlice) -> Double { @_common.sum(s.data) }

pub fn stats_desc_robust_slice_mean(s : StatsdescrobustSlice) -> Double { @_common.mean(s.data) }

pub fn stats_desc_robust_slice_scale(s : StatsdescrobustSlice, f : Double) -> StatsdescrobustSlice {
  let result = stats_desc_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_robust_slice_add(a : StatsdescrobustSlice, b : StatsdescrobustSlice) -> StatsdescrobustSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_robust_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_robust_slice_copy(s : StatsdescrobustSlice) -> StatsdescrobustSlice {
  let result = stats_desc_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_robust_slice_fill(s : StatsdescrobustSlice, v : Double) -> StatsdescrobustSlice {
  let result = stats_desc_robust_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_robust_slice_min(s : StatsdescrobustSlice) -> Double { @_common.min(s.data) }

pub fn stats_desc_robust_slice_max(s : StatsdescrobustSlice) -> Double { @_common.max(s.data) }

pub fn stats_desc_robust_slice_to_string(s : StatsdescrobustSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

