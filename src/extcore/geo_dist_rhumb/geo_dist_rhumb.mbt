///===
/// extcore/geo_dist_rhumb

pub(all) struct GeodistrhumbPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_rhumb_make_point(x : Double, y : Double) -> GeodistrhumbPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_rhumb_make_point3(x : Double, y : Double, z : Double) -> GeodistrhumbPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_rhumb_point_x(pt : GeodistrhumbPoint) -> Double { pt.x }

pub fn geo_dist_rhumb_point_y(pt : GeodistrhumbPoint) -> Double { pt.y }

pub fn geo_dist_rhumb_point_z(pt : GeodistrhumbPoint) -> Double { pt.z }

pub fn geo_dist_rhumb_point_label(pt : GeodistrhumbPoint) -> Int { pt.label }

pub fn geo_dist_rhumb_point_dist(a : GeodistrhumbPoint, b : GeodistrhumbPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_rhumb_point_add(a : GeodistrhumbPoint, b : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_rhumb_point_sub(a : GeodistrhumbPoint, b : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_rhumb_point_scale(pt : GeodistrhumbPoint, s : Double) -> GeodistrhumbPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_rhumb_point_dot(a : GeodistrhumbPoint, b : GeodistrhumbPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_rhumb_point_cross(a : GeodistrhumbPoint, b : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_rhumb_point_norm(pt : GeodistrhumbPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_rhumb_point_normalize(pt : GeodistrhumbPoint) -> GeodistrhumbPoint {
  let n = geo_dist_rhumb_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_rhumb_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_rhumb_point_negate(pt : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_rhumb_point_mid(a : GeodistrhumbPoint, b : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_rhumb_point_lerp(a : GeodistrhumbPoint, b : GeodistrhumbPoint, t : Double) -> GeodistrhumbPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_rhumb_point_to_string(pt : GeodistrhumbPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistrhumbSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_rhumb_make_series(vals : Array[Double], name : String) -> GeodistrhumbSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_rhumb_series_len(s : GeodistrhumbSeries) -> Int { s.vals.length() }

pub fn geo_dist_rhumb_series_sum(s : GeodistrhumbSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_dist_rhumb_series_mean(s : GeodistrhumbSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_dist_rhumb_series_min(s : GeodistrhumbSeries) -> Double { @_common.min(s.vals) }

pub fn geo_dist_rhumb_series_max(s : GeodistrhumbSeries) -> Double { @_common.max(s.vals) }

pub fn geo_dist_rhumb_series_range(s : GeodistrhumbSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_dist_rhumb_series_var(s : GeodistrhumbSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_dist_rhumb_series_std(s : GeodistrhumbSeries) -> Double { @_common.std(s.vals) }

pub fn geo_dist_rhumb_series_median(s : GeodistrhumbSeries) -> Double { @_common.median(s.vals) }

pub fn geo_dist_rhumb_series_scale(s : GeodistrhumbSeries, f : Double) -> GeodistrhumbSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_rhumb_series_add(a : GeodistrhumbSeries, b : GeodistrhumbSeries) -> GeodistrhumbSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_rhumb_series_sub(a : GeodistrhumbSeries, b : GeodistrhumbSeries) -> GeodistrhumbSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_rhumb_series_normalize(s : GeodistrhumbSeries) -> GeodistrhumbSeries {
  let mn = geo_dist_rhumb_series_min(s)
  let mx = geo_dist_rhumb_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_rhumb_series_cumsum(s : GeodistrhumbSeries) -> GeodistrhumbSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_rhumb_series_to_string(s : GeodistrhumbSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistrhumbMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_rhumb_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistrhumbMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_rhumb_matrix_identity(n : Int) -> GeodistrhumbMatrix {
  let m = geo_dist_rhumb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_rhumb_matrix_get(m : GeodistrhumbMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_rhumb_matrix_transpose(m : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  let result = geo_dist_rhumb_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_rhumb_matrix_add(a : GeodistrhumbMatrix, b : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_rhumb_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_rhumb_matrix_scale(m : GeodistrhumbMatrix, s : Double) -> GeodistrhumbMatrix {
  let result = geo_dist_rhumb_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_rhumb_matrix_multiply(a : GeodistrhumbMatrix, b : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  if a.cols != b.rows { return geo_dist_rhumb_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_rhumb_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_rhumb_matrix_trace(m : GeodistrhumbMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_rhumb_matrix_det(m : GeodistrhumbMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_rhumb_matrix_norm(m : GeodistrhumbMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_dist_rhumb_matrix_to_string(m : GeodistrhumbMatrix) -> String {
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

pub(all) struct GeodistrhumbVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_rhumb_make_vector(comps : Array[Double]) -> GeodistrhumbVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_rhumb_vector_zero(dim : Int) -> GeodistrhumbVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_rhumb_vector_add(a : GeodistrhumbVector, b : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_rhumb_vector_sub(a : GeodistrhumbVector, b : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_rhumb_vector_scale(v : GeodistrhumbVector, s : Double) -> GeodistrhumbVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_rhumb_vector_dot(a : GeodistrhumbVector, b : GeodistrhumbVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_rhumb_vector_norm(v : GeodistrhumbVector) -> Double { @_common.sqrt(geo_dist_rhumb_vector_dot(v, v)) }

pub fn geo_dist_rhumb_vector_normalize(v : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = geo_dist_rhumb_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_rhumb_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_rhumb_vector_dist(a : GeodistrhumbVector, b : GeodistrhumbVector) -> Double {
  geo_dist_rhumb_vector_norm(geo_dist_rhumb_vector_sub(a, b))
}

pub fn geo_dist_rhumb_vector_to_string(v : GeodistrhumbVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_rhumb_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_rhumb_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_rhumb_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_rhumb_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_rhumb_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_rhumb_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_rhumb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_rhumb_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_rhumb_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_rhumb_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_rhumb_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_rhumb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_rhumb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_rhumb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_rhumb_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_rhumb_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_rhumb_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_rhumb_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_rhumb_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_rhumb_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_rhumb_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_rhumb_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_rhumb_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_rhumb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_rhumb_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_rhumb_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_rhumb_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_rhumb_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_rhumb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistrhumbFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_frame_make(size : Int) -> GeodistrhumbFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_frame_len(s : GeodistrhumbFrame) -> Int { s.size }

pub fn geo_dist_rhumb_frame_get(s : GeodistrhumbFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_frame_set(s : GeodistrhumbFrame, i : Int, v : Double) -> GeodistrhumbFrame {
  let result = geo_dist_rhumb_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_frame_sum(s : GeodistrhumbFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_frame_mean(s : GeodistrhumbFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_frame_scale(s : GeodistrhumbFrame, f : Double) -> GeodistrhumbFrame {
  let result = geo_dist_rhumb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_frame_add(a : GeodistrhumbFrame, b : GeodistrhumbFrame) -> GeodistrhumbFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_frame_copy(s : GeodistrhumbFrame) -> GeodistrhumbFrame {
  let result = geo_dist_rhumb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_frame_fill(s : GeodistrhumbFrame, v : Double) -> GeodistrhumbFrame {
  let result = geo_dist_rhumb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_frame_min(s : GeodistrhumbFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_frame_max(s : GeodistrhumbFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_frame_to_string(s : GeodistrhumbFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_table_make(size : Int) -> GeodistrhumbTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_table_len(s : GeodistrhumbTable) -> Int { s.size }

pub fn geo_dist_rhumb_table_get(s : GeodistrhumbTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_table_set(s : GeodistrhumbTable, i : Int, v : Double) -> GeodistrhumbTable {
  let result = geo_dist_rhumb_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_table_sum(s : GeodistrhumbTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_table_mean(s : GeodistrhumbTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_table_scale(s : GeodistrhumbTable, f : Double) -> GeodistrhumbTable {
  let result = geo_dist_rhumb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_table_add(a : GeodistrhumbTable, b : GeodistrhumbTable) -> GeodistrhumbTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_table_copy(s : GeodistrhumbTable) -> GeodistrhumbTable {
  let result = geo_dist_rhumb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_table_fill(s : GeodistrhumbTable, v : Double) -> GeodistrhumbTable {
  let result = geo_dist_rhumb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_table_min(s : GeodistrhumbTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_table_max(s : GeodistrhumbTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_table_to_string(s : GeodistrhumbTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_graphn_make(size : Int) -> GeodistrhumbGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_graphn_len(s : GeodistrhumbGraphN) -> Int { s.size }

pub fn geo_dist_rhumb_graphn_get(s : GeodistrhumbGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_graphn_set(s : GeodistrhumbGraphN, i : Int, v : Double) -> GeodistrhumbGraphN {
  let result = geo_dist_rhumb_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_graphn_sum(s : GeodistrhumbGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_graphn_mean(s : GeodistrhumbGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_graphn_scale(s : GeodistrhumbGraphN, f : Double) -> GeodistrhumbGraphN {
  let result = geo_dist_rhumb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_graphn_add(a : GeodistrhumbGraphN, b : GeodistrhumbGraphN) -> GeodistrhumbGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_graphn_copy(s : GeodistrhumbGraphN) -> GeodistrhumbGraphN {
  let result = geo_dist_rhumb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_graphn_fill(s : GeodistrhumbGraphN, v : Double) -> GeodistrhumbGraphN {
  let result = geo_dist_rhumb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_graphn_min(s : GeodistrhumbGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_graphn_max(s : GeodistrhumbGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_graphn_to_string(s : GeodistrhumbGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_node_make(size : Int) -> GeodistrhumbNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_node_len(s : GeodistrhumbNode) -> Int { s.size }

pub fn geo_dist_rhumb_node_get(s : GeodistrhumbNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_node_set(s : GeodistrhumbNode, i : Int, v : Double) -> GeodistrhumbNode {
  let result = geo_dist_rhumb_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_node_sum(s : GeodistrhumbNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_node_mean(s : GeodistrhumbNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_node_scale(s : GeodistrhumbNode, f : Double) -> GeodistrhumbNode {
  let result = geo_dist_rhumb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_node_add(a : GeodistrhumbNode, b : GeodistrhumbNode) -> GeodistrhumbNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_node_copy(s : GeodistrhumbNode) -> GeodistrhumbNode {
  let result = geo_dist_rhumb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_node_fill(s : GeodistrhumbNode, v : Double) -> GeodistrhumbNode {
  let result = geo_dist_rhumb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_node_min(s : GeodistrhumbNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_node_max(s : GeodistrhumbNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_node_to_string(s : GeodistrhumbNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_edge_make(size : Int) -> GeodistrhumbEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_edge_len(s : GeodistrhumbEdge) -> Int { s.size }

pub fn geo_dist_rhumb_edge_get(s : GeodistrhumbEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_edge_set(s : GeodistrhumbEdge, i : Int, v : Double) -> GeodistrhumbEdge {
  let result = geo_dist_rhumb_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_edge_sum(s : GeodistrhumbEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_edge_mean(s : GeodistrhumbEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_edge_scale(s : GeodistrhumbEdge, f : Double) -> GeodistrhumbEdge {
  let result = geo_dist_rhumb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_edge_add(a : GeodistrhumbEdge, b : GeodistrhumbEdge) -> GeodistrhumbEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_edge_copy(s : GeodistrhumbEdge) -> GeodistrhumbEdge {
  let result = geo_dist_rhumb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_edge_fill(s : GeodistrhumbEdge, v : Double) -> GeodistrhumbEdge {
  let result = geo_dist_rhumb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_edge_min(s : GeodistrhumbEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_edge_max(s : GeodistrhumbEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_edge_to_string(s : GeodistrhumbEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_path_make(size : Int) -> GeodistrhumbPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_path_len(s : GeodistrhumbPath) -> Int { s.size }

pub fn geo_dist_rhumb_path_get(s : GeodistrhumbPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_path_set(s : GeodistrhumbPath, i : Int, v : Double) -> GeodistrhumbPath {
  let result = geo_dist_rhumb_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_path_sum(s : GeodistrhumbPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_path_mean(s : GeodistrhumbPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_path_scale(s : GeodistrhumbPath, f : Double) -> GeodistrhumbPath {
  let result = geo_dist_rhumb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_path_add(a : GeodistrhumbPath, b : GeodistrhumbPath) -> GeodistrhumbPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_path_copy(s : GeodistrhumbPath) -> GeodistrhumbPath {
  let result = geo_dist_rhumb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_path_fill(s : GeodistrhumbPath, v : Double) -> GeodistrhumbPath {
  let result = geo_dist_rhumb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_path_min(s : GeodistrhumbPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_path_max(s : GeodistrhumbPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_path_to_string(s : GeodistrhumbPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_cluster_make(size : Int) -> GeodistrhumbCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_cluster_len(s : GeodistrhumbCluster) -> Int { s.size }

pub fn geo_dist_rhumb_cluster_get(s : GeodistrhumbCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_cluster_set(s : GeodistrhumbCluster, i : Int, v : Double) -> GeodistrhumbCluster {
  let result = geo_dist_rhumb_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_cluster_sum(s : GeodistrhumbCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_cluster_mean(s : GeodistrhumbCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_cluster_scale(s : GeodistrhumbCluster, f : Double) -> GeodistrhumbCluster {
  let result = geo_dist_rhumb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_cluster_add(a : GeodistrhumbCluster, b : GeodistrhumbCluster) -> GeodistrhumbCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_cluster_copy(s : GeodistrhumbCluster) -> GeodistrhumbCluster {
  let result = geo_dist_rhumb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_cluster_fill(s : GeodistrhumbCluster, v : Double) -> GeodistrhumbCluster {
  let result = geo_dist_rhumb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_cluster_min(s : GeodistrhumbCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_cluster_max(s : GeodistrhumbCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_cluster_to_string(s : GeodistrhumbCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_model_make(size : Int) -> GeodistrhumbModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_model_len(s : GeodistrhumbModel) -> Int { s.size }

pub fn geo_dist_rhumb_model_get(s : GeodistrhumbModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_model_set(s : GeodistrhumbModel, i : Int, v : Double) -> GeodistrhumbModel {
  let result = geo_dist_rhumb_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_model_sum(s : GeodistrhumbModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_model_mean(s : GeodistrhumbModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_model_scale(s : GeodistrhumbModel, f : Double) -> GeodistrhumbModel {
  let result = geo_dist_rhumb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_model_add(a : GeodistrhumbModel, b : GeodistrhumbModel) -> GeodistrhumbModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_model_copy(s : GeodistrhumbModel) -> GeodistrhumbModel {
  let result = geo_dist_rhumb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_model_fill(s : GeodistrhumbModel, v : Double) -> GeodistrhumbModel {
  let result = geo_dist_rhumb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_model_min(s : GeodistrhumbModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_model_max(s : GeodistrhumbModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_model_to_string(s : GeodistrhumbModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_layer_make(size : Int) -> GeodistrhumbLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_layer_len(s : GeodistrhumbLayer) -> Int { s.size }

pub fn geo_dist_rhumb_layer_get(s : GeodistrhumbLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_layer_set(s : GeodistrhumbLayer, i : Int, v : Double) -> GeodistrhumbLayer {
  let result = geo_dist_rhumb_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_layer_sum(s : GeodistrhumbLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_layer_mean(s : GeodistrhumbLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_layer_scale(s : GeodistrhumbLayer, f : Double) -> GeodistrhumbLayer {
  let result = geo_dist_rhumb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_layer_add(a : GeodistrhumbLayer, b : GeodistrhumbLayer) -> GeodistrhumbLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_layer_copy(s : GeodistrhumbLayer) -> GeodistrhumbLayer {
  let result = geo_dist_rhumb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_layer_fill(s : GeodistrhumbLayer, v : Double) -> GeodistrhumbLayer {
  let result = geo_dist_rhumb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_layer_min(s : GeodistrhumbLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_layer_max(s : GeodistrhumbLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_layer_to_string(s : GeodistrhumbLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_buffer_make(size : Int) -> GeodistrhumbBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_buffer_len(s : GeodistrhumbBuffer) -> Int { s.size }

pub fn geo_dist_rhumb_buffer_get(s : GeodistrhumbBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_buffer_set(s : GeodistrhumbBuffer, i : Int, v : Double) -> GeodistrhumbBuffer {
  let result = geo_dist_rhumb_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_buffer_sum(s : GeodistrhumbBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_buffer_mean(s : GeodistrhumbBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_buffer_scale(s : GeodistrhumbBuffer, f : Double) -> GeodistrhumbBuffer {
  let result = geo_dist_rhumb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_buffer_add(a : GeodistrhumbBuffer, b : GeodistrhumbBuffer) -> GeodistrhumbBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_buffer_copy(s : GeodistrhumbBuffer) -> GeodistrhumbBuffer {
  let result = geo_dist_rhumb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_buffer_fill(s : GeodistrhumbBuffer, v : Double) -> GeodistrhumbBuffer {
  let result = geo_dist_rhumb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_buffer_min(s : GeodistrhumbBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_buffer_max(s : GeodistrhumbBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_buffer_to_string(s : GeodistrhumbBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_cursor_make(size : Int) -> GeodistrhumbCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_cursor_len(s : GeodistrhumbCursor) -> Int { s.size }

pub fn geo_dist_rhumb_cursor_get(s : GeodistrhumbCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_cursor_set(s : GeodistrhumbCursor, i : Int, v : Double) -> GeodistrhumbCursor {
  let result = geo_dist_rhumb_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_cursor_sum(s : GeodistrhumbCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_cursor_mean(s : GeodistrhumbCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_cursor_scale(s : GeodistrhumbCursor, f : Double) -> GeodistrhumbCursor {
  let result = geo_dist_rhumb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_cursor_add(a : GeodistrhumbCursor, b : GeodistrhumbCursor) -> GeodistrhumbCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_cursor_copy(s : GeodistrhumbCursor) -> GeodistrhumbCursor {
  let result = geo_dist_rhumb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_cursor_fill(s : GeodistrhumbCursor, v : Double) -> GeodistrhumbCursor {
  let result = geo_dist_rhumb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_cursor_min(s : GeodistrhumbCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_cursor_max(s : GeodistrhumbCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_cursor_to_string(s : GeodistrhumbCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_view_make(size : Int) -> GeodistrhumbView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_view_len(s : GeodistrhumbView) -> Int { s.size }

pub fn geo_dist_rhumb_view_get(s : GeodistrhumbView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_view_set(s : GeodistrhumbView, i : Int, v : Double) -> GeodistrhumbView {
  let result = geo_dist_rhumb_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_view_sum(s : GeodistrhumbView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_view_mean(s : GeodistrhumbView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_view_scale(s : GeodistrhumbView, f : Double) -> GeodistrhumbView {
  let result = geo_dist_rhumb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_view_add(a : GeodistrhumbView, b : GeodistrhumbView) -> GeodistrhumbView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_view_copy(s : GeodistrhumbView) -> GeodistrhumbView {
  let result = geo_dist_rhumb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_view_fill(s : GeodistrhumbView, v : Double) -> GeodistrhumbView {
  let result = geo_dist_rhumb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_view_min(s : GeodistrhumbView) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_view_max(s : GeodistrhumbView) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_view_to_string(s : GeodistrhumbView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_range_make(size : Int) -> GeodistrhumbRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_range_len(s : GeodistrhumbRange) -> Int { s.size }

pub fn geo_dist_rhumb_range_get(s : GeodistrhumbRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_range_set(s : GeodistrhumbRange, i : Int, v : Double) -> GeodistrhumbRange {
  let result = geo_dist_rhumb_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_range_sum(s : GeodistrhumbRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_range_mean(s : GeodistrhumbRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_range_scale(s : GeodistrhumbRange, f : Double) -> GeodistrhumbRange {
  let result = geo_dist_rhumb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_range_add(a : GeodistrhumbRange, b : GeodistrhumbRange) -> GeodistrhumbRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_range_copy(s : GeodistrhumbRange) -> GeodistrhumbRange {
  let result = geo_dist_rhumb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_range_fill(s : GeodistrhumbRange, v : Double) -> GeodistrhumbRange {
  let result = geo_dist_rhumb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_range_min(s : GeodistrhumbRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_range_max(s : GeodistrhumbRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_range_to_string(s : GeodistrhumbRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_slice_make(size : Int) -> GeodistrhumbSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_slice_len(s : GeodistrhumbSlice) -> Int { s.size }

pub fn geo_dist_rhumb_slice_get(s : GeodistrhumbSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_slice_set(s : GeodistrhumbSlice, i : Int, v : Double) -> GeodistrhumbSlice {
  let result = geo_dist_rhumb_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_slice_sum(s : GeodistrhumbSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_slice_mean(s : GeodistrhumbSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_slice_scale(s : GeodistrhumbSlice, f : Double) -> GeodistrhumbSlice {
  let result = geo_dist_rhumb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_rhumb_slice_add(a : GeodistrhumbSlice, b : GeodistrhumbSlice) -> GeodistrhumbSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_rhumb_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_rhumb_slice_copy(s : GeodistrhumbSlice) -> GeodistrhumbSlice {
  let result = geo_dist_rhumb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_rhumb_slice_fill(s : GeodistrhumbSlice, v : Double) -> GeodistrhumbSlice {
  let result = geo_dist_rhumb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_rhumb_slice_min(s : GeodistrhumbSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_slice_max(s : GeodistrhumbSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_slice_to_string(s : GeodistrhumbSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

