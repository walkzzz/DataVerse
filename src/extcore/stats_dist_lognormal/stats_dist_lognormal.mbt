///===
/// extcore/stats_dist_lognormal

pub(all) struct StatsdistlognormalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_lognormal_make_point(x : Double, y : Double) -> StatsdistlognormalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_lognormal_make_point3(x : Double, y : Double, z : Double) -> StatsdistlognormalPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_lognormal_point_x(pt : StatsdistlognormalPoint) -> Double { pt.x }

pub fn stats_dist_lognormal_point_y(pt : StatsdistlognormalPoint) -> Double { pt.y }

pub fn stats_dist_lognormal_point_z(pt : StatsdistlognormalPoint) -> Double { pt.z }

pub fn stats_dist_lognormal_point_label(pt : StatsdistlognormalPoint) -> Int { pt.label }

pub fn stats_dist_lognormal_point_dist(a : StatsdistlognormalPoint, b : StatsdistlognormalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_lognormal_point_add(a : StatsdistlognormalPoint, b : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_lognormal_point_sub(a : StatsdistlognormalPoint, b : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_lognormal_point_scale(pt : StatsdistlognormalPoint, s : Double) -> StatsdistlognormalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_lognormal_point_dot(a : StatsdistlognormalPoint, b : StatsdistlognormalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_lognormal_point_cross(a : StatsdistlognormalPoint, b : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_lognormal_point_norm(pt : StatsdistlognormalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_lognormal_point_normalize(pt : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  let n = stats_dist_lognormal_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_lognormal_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_lognormal_point_negate(pt : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_lognormal_point_mid(a : StatsdistlognormalPoint, b : StatsdistlognormalPoint) -> StatsdistlognormalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_lognormal_point_lerp(a : StatsdistlognormalPoint, b : StatsdistlognormalPoint, t : Double) -> StatsdistlognormalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_lognormal_point_to_string(pt : StatsdistlognormalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistlognormalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_lognormal_make_series(vals : Array[Double], name : String) -> StatsdistlognormalSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_lognormal_series_len(s : StatsdistlognormalSeries) -> Int { s.vals.length() }

pub fn stats_dist_lognormal_series_sum(s : StatsdistlognormalSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_lognormal_series_mean(s : StatsdistlognormalSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_lognormal_series_min(s : StatsdistlognormalSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_lognormal_series_max(s : StatsdistlognormalSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_lognormal_series_range(s : StatsdistlognormalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_lognormal_series_var(s : StatsdistlognormalSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_lognormal_series_std(s : StatsdistlognormalSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_lognormal_series_median(s : StatsdistlognormalSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_lognormal_series_scale(s : StatsdistlognormalSeries, f : Double) -> StatsdistlognormalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_lognormal_series_add(a : StatsdistlognormalSeries, b : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_lognormal_series_sub(a : StatsdistlognormalSeries, b : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_lognormal_series_normalize(s : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  let mn = stats_dist_lognormal_series_min(s)
  let mx = stats_dist_lognormal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_lognormal_series_cumsum(s : StatsdistlognormalSeries) -> StatsdistlognormalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_lognormal_series_to_string(s : StatsdistlognormalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistlognormalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_lognormal_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistlognormalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_lognormal_matrix_identity(n : Int) -> StatsdistlognormalMatrix {
  let m = stats_dist_lognormal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_lognormal_matrix_get(m : StatsdistlognormalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_lognormal_matrix_transpose(m : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  let result = stats_dist_lognormal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_lognormal_matrix_add(a : StatsdistlognormalMatrix, b : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_lognormal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_lognormal_matrix_scale(m : StatsdistlognormalMatrix, s : Double) -> StatsdistlognormalMatrix {
  let result = stats_dist_lognormal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_lognormal_matrix_multiply(a : StatsdistlognormalMatrix, b : StatsdistlognormalMatrix) -> StatsdistlognormalMatrix {
  if a.cols != b.rows { return stats_dist_lognormal_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_lognormal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_lognormal_matrix_trace(m : StatsdistlognormalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_lognormal_matrix_det(m : StatsdistlognormalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_lognormal_matrix_norm(m : StatsdistlognormalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_lognormal_matrix_to_string(m : StatsdistlognormalMatrix) -> String {
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

pub(all) struct StatsdistlognormalVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_lognormal_make_vector(comps : Array[Double]) -> StatsdistlognormalVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_lognormal_vector_zero(dim : Int) -> StatsdistlognormalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_lognormal_vector_add(a : StatsdistlognormalVector, b : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_lognormal_vector_sub(a : StatsdistlognormalVector, b : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_lognormal_vector_scale(v : StatsdistlognormalVector, s : Double) -> StatsdistlognormalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_lognormal_vector_dot(a : StatsdistlognormalVector, b : StatsdistlognormalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_lognormal_vector_norm(v : StatsdistlognormalVector) -> Double { @_common.sqrt(stats_dist_lognormal_vector_dot(v, v)) }

pub fn stats_dist_lognormal_vector_normalize(v : StatsdistlognormalVector) -> StatsdistlognormalVector {
  let n = stats_dist_lognormal_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_lognormal_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_lognormal_vector_dist(a : StatsdistlognormalVector, b : StatsdistlognormalVector) -> Double {
  stats_dist_lognormal_vector_norm(stats_dist_lognormal_vector_sub(a, b))
}

pub fn stats_dist_lognormal_vector_to_string(v : StatsdistlognormalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_lognormal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_lognormal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_lognormal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_lognormal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_lognormal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_lognormal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_lognormal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_lognormal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_lognormal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_lognormal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_lognormal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_lognormal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_lognormal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_lognormal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_lognormal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_lognormal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_lognormal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_lognormal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_lognormal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_lognormal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_lognormal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_lognormal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_lognormal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_lognormal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_lognormal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_lognormal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_lognormal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_lognormal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_lognormal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistlognormalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_frame_make(size : Int) -> StatsdistlognormalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_frame_len(s : StatsdistlognormalFrame) -> Int { s.size }

pub fn stats_dist_lognormal_frame_get(s : StatsdistlognormalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_frame_set(s : StatsdistlognormalFrame, i : Int, v : Double) -> StatsdistlognormalFrame {
  let result = stats_dist_lognormal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_frame_sum(s : StatsdistlognormalFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_frame_mean(s : StatsdistlognormalFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_frame_scale(s : StatsdistlognormalFrame, f : Double) -> StatsdistlognormalFrame {
  let result = stats_dist_lognormal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_frame_add(a : StatsdistlognormalFrame, b : StatsdistlognormalFrame) -> StatsdistlognormalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_frame_copy(s : StatsdistlognormalFrame) -> StatsdistlognormalFrame {
  let result = stats_dist_lognormal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_frame_fill(s : StatsdistlognormalFrame, v : Double) -> StatsdistlognormalFrame {
  let result = stats_dist_lognormal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_frame_min(s : StatsdistlognormalFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_frame_max(s : StatsdistlognormalFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_frame_to_string(s : StatsdistlognormalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_table_make(size : Int) -> StatsdistlognormalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_table_len(s : StatsdistlognormalTable) -> Int { s.size }

pub fn stats_dist_lognormal_table_get(s : StatsdistlognormalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_table_set(s : StatsdistlognormalTable, i : Int, v : Double) -> StatsdistlognormalTable {
  let result = stats_dist_lognormal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_table_sum(s : StatsdistlognormalTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_table_mean(s : StatsdistlognormalTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_table_scale(s : StatsdistlognormalTable, f : Double) -> StatsdistlognormalTable {
  let result = stats_dist_lognormal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_table_add(a : StatsdistlognormalTable, b : StatsdistlognormalTable) -> StatsdistlognormalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_table_copy(s : StatsdistlognormalTable) -> StatsdistlognormalTable {
  let result = stats_dist_lognormal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_table_fill(s : StatsdistlognormalTable, v : Double) -> StatsdistlognormalTable {
  let result = stats_dist_lognormal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_table_min(s : StatsdistlognormalTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_table_max(s : StatsdistlognormalTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_table_to_string(s : StatsdistlognormalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_graphn_make(size : Int) -> StatsdistlognormalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_graphn_len(s : StatsdistlognormalGraphN) -> Int { s.size }

pub fn stats_dist_lognormal_graphn_get(s : StatsdistlognormalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_graphn_set(s : StatsdistlognormalGraphN, i : Int, v : Double) -> StatsdistlognormalGraphN {
  let result = stats_dist_lognormal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_graphn_sum(s : StatsdistlognormalGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_graphn_mean(s : StatsdistlognormalGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_graphn_scale(s : StatsdistlognormalGraphN, f : Double) -> StatsdistlognormalGraphN {
  let result = stats_dist_lognormal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_graphn_add(a : StatsdistlognormalGraphN, b : StatsdistlognormalGraphN) -> StatsdistlognormalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_graphn_copy(s : StatsdistlognormalGraphN) -> StatsdistlognormalGraphN {
  let result = stats_dist_lognormal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_graphn_fill(s : StatsdistlognormalGraphN, v : Double) -> StatsdistlognormalGraphN {
  let result = stats_dist_lognormal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_graphn_min(s : StatsdistlognormalGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_graphn_max(s : StatsdistlognormalGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_graphn_to_string(s : StatsdistlognormalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_node_make(size : Int) -> StatsdistlognormalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_node_len(s : StatsdistlognormalNode) -> Int { s.size }

pub fn stats_dist_lognormal_node_get(s : StatsdistlognormalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_node_set(s : StatsdistlognormalNode, i : Int, v : Double) -> StatsdistlognormalNode {
  let result = stats_dist_lognormal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_node_sum(s : StatsdistlognormalNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_node_mean(s : StatsdistlognormalNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_node_scale(s : StatsdistlognormalNode, f : Double) -> StatsdistlognormalNode {
  let result = stats_dist_lognormal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_node_add(a : StatsdistlognormalNode, b : StatsdistlognormalNode) -> StatsdistlognormalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_node_copy(s : StatsdistlognormalNode) -> StatsdistlognormalNode {
  let result = stats_dist_lognormal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_node_fill(s : StatsdistlognormalNode, v : Double) -> StatsdistlognormalNode {
  let result = stats_dist_lognormal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_node_min(s : StatsdistlognormalNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_node_max(s : StatsdistlognormalNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_node_to_string(s : StatsdistlognormalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_edge_make(size : Int) -> StatsdistlognormalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_edge_len(s : StatsdistlognormalEdge) -> Int { s.size }

pub fn stats_dist_lognormal_edge_get(s : StatsdistlognormalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_edge_set(s : StatsdistlognormalEdge, i : Int, v : Double) -> StatsdistlognormalEdge {
  let result = stats_dist_lognormal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_edge_sum(s : StatsdistlognormalEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_edge_mean(s : StatsdistlognormalEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_edge_scale(s : StatsdistlognormalEdge, f : Double) -> StatsdistlognormalEdge {
  let result = stats_dist_lognormal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_edge_add(a : StatsdistlognormalEdge, b : StatsdistlognormalEdge) -> StatsdistlognormalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_edge_copy(s : StatsdistlognormalEdge) -> StatsdistlognormalEdge {
  let result = stats_dist_lognormal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_edge_fill(s : StatsdistlognormalEdge, v : Double) -> StatsdistlognormalEdge {
  let result = stats_dist_lognormal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_edge_min(s : StatsdistlognormalEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_edge_max(s : StatsdistlognormalEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_edge_to_string(s : StatsdistlognormalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_path_make(size : Int) -> StatsdistlognormalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_path_len(s : StatsdistlognormalPath) -> Int { s.size }

pub fn stats_dist_lognormal_path_get(s : StatsdistlognormalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_path_set(s : StatsdistlognormalPath, i : Int, v : Double) -> StatsdistlognormalPath {
  let result = stats_dist_lognormal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_path_sum(s : StatsdistlognormalPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_path_mean(s : StatsdistlognormalPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_path_scale(s : StatsdistlognormalPath, f : Double) -> StatsdistlognormalPath {
  let result = stats_dist_lognormal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_path_add(a : StatsdistlognormalPath, b : StatsdistlognormalPath) -> StatsdistlognormalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_path_copy(s : StatsdistlognormalPath) -> StatsdistlognormalPath {
  let result = stats_dist_lognormal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_path_fill(s : StatsdistlognormalPath, v : Double) -> StatsdistlognormalPath {
  let result = stats_dist_lognormal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_path_min(s : StatsdistlognormalPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_path_max(s : StatsdistlognormalPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_path_to_string(s : StatsdistlognormalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_cluster_make(size : Int) -> StatsdistlognormalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_cluster_len(s : StatsdistlognormalCluster) -> Int { s.size }

pub fn stats_dist_lognormal_cluster_get(s : StatsdistlognormalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_cluster_set(s : StatsdistlognormalCluster, i : Int, v : Double) -> StatsdistlognormalCluster {
  let result = stats_dist_lognormal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_cluster_sum(s : StatsdistlognormalCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_cluster_mean(s : StatsdistlognormalCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_cluster_scale(s : StatsdistlognormalCluster, f : Double) -> StatsdistlognormalCluster {
  let result = stats_dist_lognormal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_cluster_add(a : StatsdistlognormalCluster, b : StatsdistlognormalCluster) -> StatsdistlognormalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_cluster_copy(s : StatsdistlognormalCluster) -> StatsdistlognormalCluster {
  let result = stats_dist_lognormal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_cluster_fill(s : StatsdistlognormalCluster, v : Double) -> StatsdistlognormalCluster {
  let result = stats_dist_lognormal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_cluster_min(s : StatsdistlognormalCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_cluster_max(s : StatsdistlognormalCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_cluster_to_string(s : StatsdistlognormalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_model_make(size : Int) -> StatsdistlognormalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_model_len(s : StatsdistlognormalModel) -> Int { s.size }

pub fn stats_dist_lognormal_model_get(s : StatsdistlognormalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_model_set(s : StatsdistlognormalModel, i : Int, v : Double) -> StatsdistlognormalModel {
  let result = stats_dist_lognormal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_model_sum(s : StatsdistlognormalModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_model_mean(s : StatsdistlognormalModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_model_scale(s : StatsdistlognormalModel, f : Double) -> StatsdistlognormalModel {
  let result = stats_dist_lognormal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_model_add(a : StatsdistlognormalModel, b : StatsdistlognormalModel) -> StatsdistlognormalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_model_copy(s : StatsdistlognormalModel) -> StatsdistlognormalModel {
  let result = stats_dist_lognormal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_model_fill(s : StatsdistlognormalModel, v : Double) -> StatsdistlognormalModel {
  let result = stats_dist_lognormal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_model_min(s : StatsdistlognormalModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_model_max(s : StatsdistlognormalModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_model_to_string(s : StatsdistlognormalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_layer_make(size : Int) -> StatsdistlognormalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_layer_len(s : StatsdistlognormalLayer) -> Int { s.size }

pub fn stats_dist_lognormal_layer_get(s : StatsdistlognormalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_layer_set(s : StatsdistlognormalLayer, i : Int, v : Double) -> StatsdistlognormalLayer {
  let result = stats_dist_lognormal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_layer_sum(s : StatsdistlognormalLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_layer_mean(s : StatsdistlognormalLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_layer_scale(s : StatsdistlognormalLayer, f : Double) -> StatsdistlognormalLayer {
  let result = stats_dist_lognormal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_layer_add(a : StatsdistlognormalLayer, b : StatsdistlognormalLayer) -> StatsdistlognormalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_layer_copy(s : StatsdistlognormalLayer) -> StatsdistlognormalLayer {
  let result = stats_dist_lognormal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_layer_fill(s : StatsdistlognormalLayer, v : Double) -> StatsdistlognormalLayer {
  let result = stats_dist_lognormal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_layer_min(s : StatsdistlognormalLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_layer_max(s : StatsdistlognormalLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_layer_to_string(s : StatsdistlognormalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_buffer_make(size : Int) -> StatsdistlognormalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_buffer_len(s : StatsdistlognormalBuffer) -> Int { s.size }

pub fn stats_dist_lognormal_buffer_get(s : StatsdistlognormalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_buffer_set(s : StatsdistlognormalBuffer, i : Int, v : Double) -> StatsdistlognormalBuffer {
  let result = stats_dist_lognormal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_buffer_sum(s : StatsdistlognormalBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_buffer_mean(s : StatsdistlognormalBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_buffer_scale(s : StatsdistlognormalBuffer, f : Double) -> StatsdistlognormalBuffer {
  let result = stats_dist_lognormal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_buffer_add(a : StatsdistlognormalBuffer, b : StatsdistlognormalBuffer) -> StatsdistlognormalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_buffer_copy(s : StatsdistlognormalBuffer) -> StatsdistlognormalBuffer {
  let result = stats_dist_lognormal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_buffer_fill(s : StatsdistlognormalBuffer, v : Double) -> StatsdistlognormalBuffer {
  let result = stats_dist_lognormal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_buffer_min(s : StatsdistlognormalBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_buffer_max(s : StatsdistlognormalBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_buffer_to_string(s : StatsdistlognormalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_cursor_make(size : Int) -> StatsdistlognormalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_cursor_len(s : StatsdistlognormalCursor) -> Int { s.size }

pub fn stats_dist_lognormal_cursor_get(s : StatsdistlognormalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_cursor_set(s : StatsdistlognormalCursor, i : Int, v : Double) -> StatsdistlognormalCursor {
  let result = stats_dist_lognormal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_cursor_sum(s : StatsdistlognormalCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_cursor_mean(s : StatsdistlognormalCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_cursor_scale(s : StatsdistlognormalCursor, f : Double) -> StatsdistlognormalCursor {
  let result = stats_dist_lognormal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_cursor_add(a : StatsdistlognormalCursor, b : StatsdistlognormalCursor) -> StatsdistlognormalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_cursor_copy(s : StatsdistlognormalCursor) -> StatsdistlognormalCursor {
  let result = stats_dist_lognormal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_cursor_fill(s : StatsdistlognormalCursor, v : Double) -> StatsdistlognormalCursor {
  let result = stats_dist_lognormal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_cursor_min(s : StatsdistlognormalCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_cursor_max(s : StatsdistlognormalCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_cursor_to_string(s : StatsdistlognormalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_view_make(size : Int) -> StatsdistlognormalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_view_len(s : StatsdistlognormalView) -> Int { s.size }

pub fn stats_dist_lognormal_view_get(s : StatsdistlognormalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_view_set(s : StatsdistlognormalView, i : Int, v : Double) -> StatsdistlognormalView {
  let result = stats_dist_lognormal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_view_sum(s : StatsdistlognormalView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_view_mean(s : StatsdistlognormalView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_view_scale(s : StatsdistlognormalView, f : Double) -> StatsdistlognormalView {
  let result = stats_dist_lognormal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_view_add(a : StatsdistlognormalView, b : StatsdistlognormalView) -> StatsdistlognormalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_view_copy(s : StatsdistlognormalView) -> StatsdistlognormalView {
  let result = stats_dist_lognormal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_view_fill(s : StatsdistlognormalView, v : Double) -> StatsdistlognormalView {
  let result = stats_dist_lognormal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_view_min(s : StatsdistlognormalView) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_view_max(s : StatsdistlognormalView) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_view_to_string(s : StatsdistlognormalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_range_make(size : Int) -> StatsdistlognormalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_range_len(s : StatsdistlognormalRange) -> Int { s.size }

pub fn stats_dist_lognormal_range_get(s : StatsdistlognormalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_range_set(s : StatsdistlognormalRange, i : Int, v : Double) -> StatsdistlognormalRange {
  let result = stats_dist_lognormal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_range_sum(s : StatsdistlognormalRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_range_mean(s : StatsdistlognormalRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_range_scale(s : StatsdistlognormalRange, f : Double) -> StatsdistlognormalRange {
  let result = stats_dist_lognormal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_range_add(a : StatsdistlognormalRange, b : StatsdistlognormalRange) -> StatsdistlognormalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_range_copy(s : StatsdistlognormalRange) -> StatsdistlognormalRange {
  let result = stats_dist_lognormal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_range_fill(s : StatsdistlognormalRange, v : Double) -> StatsdistlognormalRange {
  let result = stats_dist_lognormal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_range_min(s : StatsdistlognormalRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_range_max(s : StatsdistlognormalRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_range_to_string(s : StatsdistlognormalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistlognormalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_lognormal_slice_make(size : Int) -> StatsdistlognormalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_lognormal_slice_len(s : StatsdistlognormalSlice) -> Int { s.size }

pub fn stats_dist_lognormal_slice_get(s : StatsdistlognormalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_lognormal_slice_set(s : StatsdistlognormalSlice, i : Int, v : Double) -> StatsdistlognormalSlice {
  let result = stats_dist_lognormal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_slice_sum(s : StatsdistlognormalSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_lognormal_slice_mean(s : StatsdistlognormalSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_lognormal_slice_scale(s : StatsdistlognormalSlice, f : Double) -> StatsdistlognormalSlice {
  let result = stats_dist_lognormal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_lognormal_slice_add(a : StatsdistlognormalSlice, b : StatsdistlognormalSlice) -> StatsdistlognormalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_lognormal_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_lognormal_slice_copy(s : StatsdistlognormalSlice) -> StatsdistlognormalSlice {
  let result = stats_dist_lognormal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_lognormal_slice_fill(s : StatsdistlognormalSlice, v : Double) -> StatsdistlognormalSlice {
  let result = stats_dist_lognormal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_lognormal_slice_min(s : StatsdistlognormalSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_lognormal_slice_max(s : StatsdistlognormalSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_lognormal_slice_to_string(s : StatsdistlognormalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

