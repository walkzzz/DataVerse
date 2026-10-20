///===
/// extcore/stats_dist_poisson

pub(all) struct StatsdistpoissonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_poisson_make_point(x : Double, y : Double) -> StatsdistpoissonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_poisson_make_point3(x : Double, y : Double, z : Double) -> StatsdistpoissonPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_poisson_point_x(pt : StatsdistpoissonPoint) -> Double { pt.x }

pub fn stats_dist_poisson_point_y(pt : StatsdistpoissonPoint) -> Double { pt.y }

pub fn stats_dist_poisson_point_z(pt : StatsdistpoissonPoint) -> Double { pt.z }

pub fn stats_dist_poisson_point_label(pt : StatsdistpoissonPoint) -> Int { pt.label }

pub fn stats_dist_poisson_point_dist(a : StatsdistpoissonPoint, b : StatsdistpoissonPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_poisson_point_add(a : StatsdistpoissonPoint, b : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_poisson_point_sub(a : StatsdistpoissonPoint, b : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_poisson_point_scale(pt : StatsdistpoissonPoint, s : Double) -> StatsdistpoissonPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_poisson_point_dot(a : StatsdistpoissonPoint, b : StatsdistpoissonPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_poisson_point_cross(a : StatsdistpoissonPoint, b : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_poisson_point_norm(pt : StatsdistpoissonPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_poisson_point_normalize(pt : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  let n = stats_dist_poisson_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_poisson_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_poisson_point_negate(pt : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_poisson_point_mid(a : StatsdistpoissonPoint, b : StatsdistpoissonPoint) -> StatsdistpoissonPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_poisson_point_lerp(a : StatsdistpoissonPoint, b : StatsdistpoissonPoint, t : Double) -> StatsdistpoissonPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_poisson_point_to_string(pt : StatsdistpoissonPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistpoissonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_poisson_make_series(vals : Array[Double], name : String) -> StatsdistpoissonSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_poisson_series_len(s : StatsdistpoissonSeries) -> Int { s.vals.length() }

pub fn stats_dist_poisson_series_sum(s : StatsdistpoissonSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_poisson_series_mean(s : StatsdistpoissonSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_poisson_series_min(s : StatsdistpoissonSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_poisson_series_max(s : StatsdistpoissonSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_poisson_series_range(s : StatsdistpoissonSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_poisson_series_var(s : StatsdistpoissonSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_poisson_series_std(s : StatsdistpoissonSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_poisson_series_median(s : StatsdistpoissonSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_poisson_series_scale(s : StatsdistpoissonSeries, f : Double) -> StatsdistpoissonSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_poisson_series_add(a : StatsdistpoissonSeries, b : StatsdistpoissonSeries) -> StatsdistpoissonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_poisson_series_sub(a : StatsdistpoissonSeries, b : StatsdistpoissonSeries) -> StatsdistpoissonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_poisson_series_normalize(s : StatsdistpoissonSeries) -> StatsdistpoissonSeries {
  let mn = stats_dist_poisson_series_min(s)
  let mx = stats_dist_poisson_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_poisson_series_cumsum(s : StatsdistpoissonSeries) -> StatsdistpoissonSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_poisson_series_to_string(s : StatsdistpoissonSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistpoissonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_poisson_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistpoissonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_poisson_matrix_identity(n : Int) -> StatsdistpoissonMatrix {
  let m = stats_dist_poisson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_poisson_matrix_get(m : StatsdistpoissonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_poisson_matrix_transpose(m : StatsdistpoissonMatrix) -> StatsdistpoissonMatrix {
  let result = stats_dist_poisson_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_poisson_matrix_add(a : StatsdistpoissonMatrix, b : StatsdistpoissonMatrix) -> StatsdistpoissonMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_poisson_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_poisson_matrix_scale(m : StatsdistpoissonMatrix, s : Double) -> StatsdistpoissonMatrix {
  let result = stats_dist_poisson_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_poisson_matrix_multiply(a : StatsdistpoissonMatrix, b : StatsdistpoissonMatrix) -> StatsdistpoissonMatrix {
  if a.cols != b.rows { return stats_dist_poisson_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_poisson_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_poisson_matrix_trace(m : StatsdistpoissonMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_poisson_matrix_det(m : StatsdistpoissonMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_poisson_matrix_norm(m : StatsdistpoissonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_poisson_matrix_to_string(m : StatsdistpoissonMatrix) -> String {
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

pub(all) struct StatsdistpoissonVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_poisson_make_vector(comps : Array[Double]) -> StatsdistpoissonVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_poisson_vector_zero(dim : Int) -> StatsdistpoissonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_poisson_vector_add(a : StatsdistpoissonVector, b : StatsdistpoissonVector) -> StatsdistpoissonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_poisson_vector_sub(a : StatsdistpoissonVector, b : StatsdistpoissonVector) -> StatsdistpoissonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_poisson_vector_scale(v : StatsdistpoissonVector, s : Double) -> StatsdistpoissonVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_poisson_vector_dot(a : StatsdistpoissonVector, b : StatsdistpoissonVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_poisson_vector_norm(v : StatsdistpoissonVector) -> Double { @_common.sqrt(stats_dist_poisson_vector_dot(v, v)) }

pub fn stats_dist_poisson_vector_normalize(v : StatsdistpoissonVector) -> StatsdistpoissonVector {
  let n = stats_dist_poisson_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_poisson_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_poisson_vector_dist(a : StatsdistpoissonVector, b : StatsdistpoissonVector) -> Double {
  stats_dist_poisson_vector_norm(stats_dist_poisson_vector_sub(a, b))
}

pub fn stats_dist_poisson_vector_to_string(v : StatsdistpoissonVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_poisson_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_poisson_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_poisson_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_poisson_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_poisson_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_poisson_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_poisson_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_poisson_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_poisson_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_poisson_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_poisson_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_poisson_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_poisson_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_poisson_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_poisson_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_poisson_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_poisson_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_poisson_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_poisson_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_poisson_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_poisson_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_poisson_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_poisson_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_poisson_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_poisson_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_poisson_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_poisson_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_poisson_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_poisson_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistpoissonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_frame_make(size : Int) -> StatsdistpoissonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_frame_len(s : StatsdistpoissonFrame) -> Int { s.size }

pub fn stats_dist_poisson_frame_get(s : StatsdistpoissonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_frame_set(s : StatsdistpoissonFrame, i : Int, v : Double) -> StatsdistpoissonFrame {
  let result = stats_dist_poisson_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_frame_sum(s : StatsdistpoissonFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_frame_mean(s : StatsdistpoissonFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_frame_scale(s : StatsdistpoissonFrame, f : Double) -> StatsdistpoissonFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_frame_add(a : StatsdistpoissonFrame, b : StatsdistpoissonFrame) -> StatsdistpoissonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_frame_copy(s : StatsdistpoissonFrame) -> StatsdistpoissonFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_frame_fill(s : StatsdistpoissonFrame, v : Double) -> StatsdistpoissonFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_frame_min(s : StatsdistpoissonFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_frame_max(s : StatsdistpoissonFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_frame_to_string(s : StatsdistpoissonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_table_make(size : Int) -> StatsdistpoissonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_table_len(s : StatsdistpoissonTable) -> Int { s.size }

pub fn stats_dist_poisson_table_get(s : StatsdistpoissonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_table_set(s : StatsdistpoissonTable, i : Int, v : Double) -> StatsdistpoissonTable {
  let result = stats_dist_poisson_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_table_sum(s : StatsdistpoissonTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_table_mean(s : StatsdistpoissonTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_table_scale(s : StatsdistpoissonTable, f : Double) -> StatsdistpoissonTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_table_add(a : StatsdistpoissonTable, b : StatsdistpoissonTable) -> StatsdistpoissonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_table_copy(s : StatsdistpoissonTable) -> StatsdistpoissonTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_table_fill(s : StatsdistpoissonTable, v : Double) -> StatsdistpoissonTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_table_min(s : StatsdistpoissonTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_table_max(s : StatsdistpoissonTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_table_to_string(s : StatsdistpoissonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_graphn_make(size : Int) -> StatsdistpoissonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_graphn_len(s : StatsdistpoissonGraphN) -> Int { s.size }

pub fn stats_dist_poisson_graphn_get(s : StatsdistpoissonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_graphn_set(s : StatsdistpoissonGraphN, i : Int, v : Double) -> StatsdistpoissonGraphN {
  let result = stats_dist_poisson_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_graphn_sum(s : StatsdistpoissonGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_graphn_mean(s : StatsdistpoissonGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_graphn_scale(s : StatsdistpoissonGraphN, f : Double) -> StatsdistpoissonGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_graphn_add(a : StatsdistpoissonGraphN, b : StatsdistpoissonGraphN) -> StatsdistpoissonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_graphn_copy(s : StatsdistpoissonGraphN) -> StatsdistpoissonGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_graphn_fill(s : StatsdistpoissonGraphN, v : Double) -> StatsdistpoissonGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_graphn_min(s : StatsdistpoissonGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_graphn_max(s : StatsdistpoissonGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_graphn_to_string(s : StatsdistpoissonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_node_make(size : Int) -> StatsdistpoissonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_node_len(s : StatsdistpoissonNode) -> Int { s.size }

pub fn stats_dist_poisson_node_get(s : StatsdistpoissonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_node_set(s : StatsdistpoissonNode, i : Int, v : Double) -> StatsdistpoissonNode {
  let result = stats_dist_poisson_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_node_sum(s : StatsdistpoissonNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_node_mean(s : StatsdistpoissonNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_node_scale(s : StatsdistpoissonNode, f : Double) -> StatsdistpoissonNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_node_add(a : StatsdistpoissonNode, b : StatsdistpoissonNode) -> StatsdistpoissonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_node_copy(s : StatsdistpoissonNode) -> StatsdistpoissonNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_node_fill(s : StatsdistpoissonNode, v : Double) -> StatsdistpoissonNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_node_min(s : StatsdistpoissonNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_node_max(s : StatsdistpoissonNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_node_to_string(s : StatsdistpoissonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_edge_make(size : Int) -> StatsdistpoissonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_edge_len(s : StatsdistpoissonEdge) -> Int { s.size }

pub fn stats_dist_poisson_edge_get(s : StatsdistpoissonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_edge_set(s : StatsdistpoissonEdge, i : Int, v : Double) -> StatsdistpoissonEdge {
  let result = stats_dist_poisson_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_edge_sum(s : StatsdistpoissonEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_edge_mean(s : StatsdistpoissonEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_edge_scale(s : StatsdistpoissonEdge, f : Double) -> StatsdistpoissonEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_edge_add(a : StatsdistpoissonEdge, b : StatsdistpoissonEdge) -> StatsdistpoissonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_edge_copy(s : StatsdistpoissonEdge) -> StatsdistpoissonEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_edge_fill(s : StatsdistpoissonEdge, v : Double) -> StatsdistpoissonEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_edge_min(s : StatsdistpoissonEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_edge_max(s : StatsdistpoissonEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_edge_to_string(s : StatsdistpoissonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_path_make(size : Int) -> StatsdistpoissonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_path_len(s : StatsdistpoissonPath) -> Int { s.size }

pub fn stats_dist_poisson_path_get(s : StatsdistpoissonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_path_set(s : StatsdistpoissonPath, i : Int, v : Double) -> StatsdistpoissonPath {
  let result = stats_dist_poisson_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_path_sum(s : StatsdistpoissonPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_path_mean(s : StatsdistpoissonPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_path_scale(s : StatsdistpoissonPath, f : Double) -> StatsdistpoissonPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_path_add(a : StatsdistpoissonPath, b : StatsdistpoissonPath) -> StatsdistpoissonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_path_copy(s : StatsdistpoissonPath) -> StatsdistpoissonPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_path_fill(s : StatsdistpoissonPath, v : Double) -> StatsdistpoissonPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_path_min(s : StatsdistpoissonPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_path_max(s : StatsdistpoissonPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_path_to_string(s : StatsdistpoissonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_cluster_make(size : Int) -> StatsdistpoissonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_cluster_len(s : StatsdistpoissonCluster) -> Int { s.size }

pub fn stats_dist_poisson_cluster_get(s : StatsdistpoissonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_cluster_set(s : StatsdistpoissonCluster, i : Int, v : Double) -> StatsdistpoissonCluster {
  let result = stats_dist_poisson_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_cluster_sum(s : StatsdistpoissonCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_cluster_mean(s : StatsdistpoissonCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_cluster_scale(s : StatsdistpoissonCluster, f : Double) -> StatsdistpoissonCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_cluster_add(a : StatsdistpoissonCluster, b : StatsdistpoissonCluster) -> StatsdistpoissonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_cluster_copy(s : StatsdistpoissonCluster) -> StatsdistpoissonCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_cluster_fill(s : StatsdistpoissonCluster, v : Double) -> StatsdistpoissonCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_cluster_min(s : StatsdistpoissonCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_cluster_max(s : StatsdistpoissonCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_cluster_to_string(s : StatsdistpoissonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_model_make(size : Int) -> StatsdistpoissonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_model_len(s : StatsdistpoissonModel) -> Int { s.size }

pub fn stats_dist_poisson_model_get(s : StatsdistpoissonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_model_set(s : StatsdistpoissonModel, i : Int, v : Double) -> StatsdistpoissonModel {
  let result = stats_dist_poisson_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_model_sum(s : StatsdistpoissonModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_model_mean(s : StatsdistpoissonModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_model_scale(s : StatsdistpoissonModel, f : Double) -> StatsdistpoissonModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_model_add(a : StatsdistpoissonModel, b : StatsdistpoissonModel) -> StatsdistpoissonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_model_copy(s : StatsdistpoissonModel) -> StatsdistpoissonModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_model_fill(s : StatsdistpoissonModel, v : Double) -> StatsdistpoissonModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_model_min(s : StatsdistpoissonModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_model_max(s : StatsdistpoissonModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_model_to_string(s : StatsdistpoissonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_layer_make(size : Int) -> StatsdistpoissonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_layer_len(s : StatsdistpoissonLayer) -> Int { s.size }

pub fn stats_dist_poisson_layer_get(s : StatsdistpoissonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_layer_set(s : StatsdistpoissonLayer, i : Int, v : Double) -> StatsdistpoissonLayer {
  let result = stats_dist_poisson_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_layer_sum(s : StatsdistpoissonLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_layer_mean(s : StatsdistpoissonLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_layer_scale(s : StatsdistpoissonLayer, f : Double) -> StatsdistpoissonLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_layer_add(a : StatsdistpoissonLayer, b : StatsdistpoissonLayer) -> StatsdistpoissonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_layer_copy(s : StatsdistpoissonLayer) -> StatsdistpoissonLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_layer_fill(s : StatsdistpoissonLayer, v : Double) -> StatsdistpoissonLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_layer_min(s : StatsdistpoissonLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_layer_max(s : StatsdistpoissonLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_layer_to_string(s : StatsdistpoissonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_buffer_make(size : Int) -> StatsdistpoissonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_buffer_len(s : StatsdistpoissonBuffer) -> Int { s.size }

pub fn stats_dist_poisson_buffer_get(s : StatsdistpoissonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_buffer_set(s : StatsdistpoissonBuffer, i : Int, v : Double) -> StatsdistpoissonBuffer {
  let result = stats_dist_poisson_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_buffer_sum(s : StatsdistpoissonBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_buffer_mean(s : StatsdistpoissonBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_buffer_scale(s : StatsdistpoissonBuffer, f : Double) -> StatsdistpoissonBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_buffer_add(a : StatsdistpoissonBuffer, b : StatsdistpoissonBuffer) -> StatsdistpoissonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_buffer_copy(s : StatsdistpoissonBuffer) -> StatsdistpoissonBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_buffer_fill(s : StatsdistpoissonBuffer, v : Double) -> StatsdistpoissonBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_buffer_min(s : StatsdistpoissonBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_buffer_max(s : StatsdistpoissonBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_buffer_to_string(s : StatsdistpoissonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_cursor_make(size : Int) -> StatsdistpoissonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_cursor_len(s : StatsdistpoissonCursor) -> Int { s.size }

pub fn stats_dist_poisson_cursor_get(s : StatsdistpoissonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_cursor_set(s : StatsdistpoissonCursor, i : Int, v : Double) -> StatsdistpoissonCursor {
  let result = stats_dist_poisson_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_cursor_sum(s : StatsdistpoissonCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_cursor_mean(s : StatsdistpoissonCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_cursor_scale(s : StatsdistpoissonCursor, f : Double) -> StatsdistpoissonCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_cursor_add(a : StatsdistpoissonCursor, b : StatsdistpoissonCursor) -> StatsdistpoissonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_cursor_copy(s : StatsdistpoissonCursor) -> StatsdistpoissonCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_cursor_fill(s : StatsdistpoissonCursor, v : Double) -> StatsdistpoissonCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_cursor_min(s : StatsdistpoissonCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_cursor_max(s : StatsdistpoissonCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_cursor_to_string(s : StatsdistpoissonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_view_make(size : Int) -> StatsdistpoissonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_view_len(s : StatsdistpoissonView) -> Int { s.size }

pub fn stats_dist_poisson_view_get(s : StatsdistpoissonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_view_set(s : StatsdistpoissonView, i : Int, v : Double) -> StatsdistpoissonView {
  let result = stats_dist_poisson_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_view_sum(s : StatsdistpoissonView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_view_mean(s : StatsdistpoissonView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_view_scale(s : StatsdistpoissonView, f : Double) -> StatsdistpoissonView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_view_add(a : StatsdistpoissonView, b : StatsdistpoissonView) -> StatsdistpoissonView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_view_copy(s : StatsdistpoissonView) -> StatsdistpoissonView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_view_fill(s : StatsdistpoissonView, v : Double) -> StatsdistpoissonView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_view_min(s : StatsdistpoissonView) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_view_max(s : StatsdistpoissonView) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_view_to_string(s : StatsdistpoissonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_range_make(size : Int) -> StatsdistpoissonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_range_len(s : StatsdistpoissonRange) -> Int { s.size }

pub fn stats_dist_poisson_range_get(s : StatsdistpoissonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_range_set(s : StatsdistpoissonRange, i : Int, v : Double) -> StatsdistpoissonRange {
  let result = stats_dist_poisson_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_range_sum(s : StatsdistpoissonRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_range_mean(s : StatsdistpoissonRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_range_scale(s : StatsdistpoissonRange, f : Double) -> StatsdistpoissonRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_range_add(a : StatsdistpoissonRange, b : StatsdistpoissonRange) -> StatsdistpoissonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_range_copy(s : StatsdistpoissonRange) -> StatsdistpoissonRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_range_fill(s : StatsdistpoissonRange, v : Double) -> StatsdistpoissonRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_range_min(s : StatsdistpoissonRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_range_max(s : StatsdistpoissonRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_range_to_string(s : StatsdistpoissonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistpoissonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_poisson_slice_make(size : Int) -> StatsdistpoissonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_poisson_slice_len(s : StatsdistpoissonSlice) -> Int { s.size }

pub fn stats_dist_poisson_slice_get(s : StatsdistpoissonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_poisson_slice_set(s : StatsdistpoissonSlice, i : Int, v : Double) -> StatsdistpoissonSlice {
  let result = stats_dist_poisson_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_poisson_slice_sum(s : StatsdistpoissonSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_poisson_slice_mean(s : StatsdistpoissonSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_poisson_slice_scale(s : StatsdistpoissonSlice, f : Double) -> StatsdistpoissonSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_slice_add(a : StatsdistpoissonSlice, b : StatsdistpoissonSlice) -> StatsdistpoissonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_poisson_slice_copy(s : StatsdistpoissonSlice) -> StatsdistpoissonSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_slice_fill(s : StatsdistpoissonSlice, v : Double) -> StatsdistpoissonSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_poisson_slice_min(s : StatsdistpoissonSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_poisson_slice_max(s : StatsdistpoissonSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_poisson_slice_to_string(s : StatsdistpoissonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

