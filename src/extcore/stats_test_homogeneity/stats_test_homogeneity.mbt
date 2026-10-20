///===
/// extcore/stats_test_homogeneity

pub(all) struct StatstesthomogeneityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_homogeneity_make_point(x : Double, y : Double) -> StatstesthomogeneityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_homogeneity_make_point3(x : Double, y : Double, z : Double) -> StatstesthomogeneityPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_homogeneity_point_x(pt : StatstesthomogeneityPoint) -> Double { pt.x }

pub fn stats_test_homogeneity_point_y(pt : StatstesthomogeneityPoint) -> Double { pt.y }

pub fn stats_test_homogeneity_point_z(pt : StatstesthomogeneityPoint) -> Double { pt.z }

pub fn stats_test_homogeneity_point_label(pt : StatstesthomogeneityPoint) -> Int { pt.label }

pub fn stats_test_homogeneity_point_dist(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_homogeneity_point_add(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_homogeneity_point_sub(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_homogeneity_point_scale(pt : StatstesthomogeneityPoint, s : Double) -> StatstesthomogeneityPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_homogeneity_point_dot(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_homogeneity_point_cross(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_homogeneity_point_norm(pt : StatstesthomogeneityPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_homogeneity_point_normalize(pt : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  let n = stats_test_homogeneity_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_homogeneity_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_homogeneity_point_negate(pt : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_homogeneity_point_mid(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint) -> StatstesthomogeneityPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_homogeneity_point_lerp(a : StatstesthomogeneityPoint, b : StatstesthomogeneityPoint, t : Double) -> StatstesthomogeneityPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_homogeneity_point_to_string(pt : StatstesthomogeneityPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstesthomogeneitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_homogeneity_make_series(vals : Array[Double], name : String) -> StatstesthomogeneitySeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_homogeneity_series_len(s : StatstesthomogeneitySeries) -> Int { s.vals.length() }

pub fn stats_test_homogeneity_series_sum(s : StatstesthomogeneitySeries) -> Double { @_common.sum(s.vals) }

pub fn stats_test_homogeneity_series_mean(s : StatstesthomogeneitySeries) -> Double { @_common.mean(s.vals) }

pub fn stats_test_homogeneity_series_min(s : StatstesthomogeneitySeries) -> Double { @_common.min(s.vals) }

pub fn stats_test_homogeneity_series_max(s : StatstesthomogeneitySeries) -> Double { @_common.max(s.vals) }

pub fn stats_test_homogeneity_series_range(s : StatstesthomogeneitySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_test_homogeneity_series_var(s : StatstesthomogeneitySeries) -> Double { @_common.variance(s.vals) }

pub fn stats_test_homogeneity_series_std(s : StatstesthomogeneitySeries) -> Double { @_common.std(s.vals) }

pub fn stats_test_homogeneity_series_median(s : StatstesthomogeneitySeries) -> Double { @_common.median(s.vals) }

pub fn stats_test_homogeneity_series_scale(s : StatstesthomogeneitySeries, f : Double) -> StatstesthomogeneitySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_homogeneity_series_add(a : StatstesthomogeneitySeries, b : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_homogeneity_series_sub(a : StatstesthomogeneitySeries, b : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_homogeneity_series_normalize(s : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  let mn = stats_test_homogeneity_series_min(s)
  let mx = stats_test_homogeneity_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_homogeneity_series_cumsum(s : StatstesthomogeneitySeries) -> StatstesthomogeneitySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_homogeneity_series_to_string(s : StatstesthomogeneitySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstesthomogeneityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_homogeneity_make_matrix(rows : Int, cols : Int, val : Double) -> StatstesthomogeneityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_homogeneity_matrix_identity(n : Int) -> StatstesthomogeneityMatrix {
  let m = stats_test_homogeneity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_homogeneity_matrix_get(m : StatstesthomogeneityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_homogeneity_matrix_transpose(m : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  let result = stats_test_homogeneity_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_homogeneity_matrix_add(a : StatstesthomogeneityMatrix, b : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_homogeneity_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_homogeneity_matrix_scale(m : StatstesthomogeneityMatrix, s : Double) -> StatstesthomogeneityMatrix {
  let result = stats_test_homogeneity_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_homogeneity_matrix_multiply(a : StatstesthomogeneityMatrix, b : StatstesthomogeneityMatrix) -> StatstesthomogeneityMatrix {
  if a.cols != b.rows { return stats_test_homogeneity_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_homogeneity_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_homogeneity_matrix_trace(m : StatstesthomogeneityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_homogeneity_matrix_det(m : StatstesthomogeneityMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_homogeneity_matrix_norm(m : StatstesthomogeneityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_homogeneity_matrix_to_string(m : StatstesthomogeneityMatrix) -> String {
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

pub(all) struct StatstesthomogeneityVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_homogeneity_make_vector(comps : Array[Double]) -> StatstesthomogeneityVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_homogeneity_vector_zero(dim : Int) -> StatstesthomogeneityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_homogeneity_vector_add(a : StatstesthomogeneityVector, b : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_homogeneity_vector_sub(a : StatstesthomogeneityVector, b : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_homogeneity_vector_scale(v : StatstesthomogeneityVector, s : Double) -> StatstesthomogeneityVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_homogeneity_vector_dot(a : StatstesthomogeneityVector, b : StatstesthomogeneityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_homogeneity_vector_norm(v : StatstesthomogeneityVector) -> Double { @_common.sqrt(stats_test_homogeneity_vector_dot(v, v)) }

pub fn stats_test_homogeneity_vector_normalize(v : StatstesthomogeneityVector) -> StatstesthomogeneityVector {
  let n = stats_test_homogeneity_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_homogeneity_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_homogeneity_vector_dist(a : StatstesthomogeneityVector, b : StatstesthomogeneityVector) -> Double {
  stats_test_homogeneity_vector_norm(stats_test_homogeneity_vector_sub(a, b))
}

pub fn stats_test_homogeneity_vector_to_string(v : StatstesthomogeneityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_homogeneity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_homogeneity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_homogeneity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_homogeneity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_homogeneity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_homogeneity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_homogeneity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_homogeneity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_homogeneity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_homogeneity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_homogeneity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_homogeneity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_homogeneity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_homogeneity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_homogeneity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_homogeneity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_homogeneity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_homogeneity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_homogeneity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_homogeneity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_homogeneity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_homogeneity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_homogeneity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_homogeneity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_homogeneity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_homogeneity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_homogeneity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_homogeneity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_homogeneity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstesthomogeneityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_frame_make(size : Int) -> StatstesthomogeneityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_frame_len(s : StatstesthomogeneityFrame) -> Int { s.size }

pub fn stats_test_homogeneity_frame_get(s : StatstesthomogeneityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_frame_set(s : StatstesthomogeneityFrame, i : Int, v : Double) -> StatstesthomogeneityFrame {
  let result = stats_test_homogeneity_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_frame_sum(s : StatstesthomogeneityFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_frame_mean(s : StatstesthomogeneityFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_frame_scale(s : StatstesthomogeneityFrame, f : Double) -> StatstesthomogeneityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_frame_add(a : StatstesthomogeneityFrame, b : StatstesthomogeneityFrame) -> StatstesthomogeneityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_frame_copy(s : StatstesthomogeneityFrame) -> StatstesthomogeneityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_frame_fill(s : StatstesthomogeneityFrame, v : Double) -> StatstesthomogeneityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_frame_min(s : StatstesthomogeneityFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_frame_max(s : StatstesthomogeneityFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_frame_to_string(s : StatstesthomogeneityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_table_make(size : Int) -> StatstesthomogeneityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_table_len(s : StatstesthomogeneityTable) -> Int { s.size }

pub fn stats_test_homogeneity_table_get(s : StatstesthomogeneityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_table_set(s : StatstesthomogeneityTable, i : Int, v : Double) -> StatstesthomogeneityTable {
  let result = stats_test_homogeneity_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_table_sum(s : StatstesthomogeneityTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_table_mean(s : StatstesthomogeneityTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_table_scale(s : StatstesthomogeneityTable, f : Double) -> StatstesthomogeneityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_table_add(a : StatstesthomogeneityTable, b : StatstesthomogeneityTable) -> StatstesthomogeneityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_table_copy(s : StatstesthomogeneityTable) -> StatstesthomogeneityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_table_fill(s : StatstesthomogeneityTable, v : Double) -> StatstesthomogeneityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_table_min(s : StatstesthomogeneityTable) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_table_max(s : StatstesthomogeneityTable) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_table_to_string(s : StatstesthomogeneityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_graphn_make(size : Int) -> StatstesthomogeneityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_graphn_len(s : StatstesthomogeneityGraphN) -> Int { s.size }

pub fn stats_test_homogeneity_graphn_get(s : StatstesthomogeneityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_graphn_set(s : StatstesthomogeneityGraphN, i : Int, v : Double) -> StatstesthomogeneityGraphN {
  let result = stats_test_homogeneity_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_graphn_sum(s : StatstesthomogeneityGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_graphn_mean(s : StatstesthomogeneityGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_graphn_scale(s : StatstesthomogeneityGraphN, f : Double) -> StatstesthomogeneityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_graphn_add(a : StatstesthomogeneityGraphN, b : StatstesthomogeneityGraphN) -> StatstesthomogeneityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_graphn_copy(s : StatstesthomogeneityGraphN) -> StatstesthomogeneityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_graphn_fill(s : StatstesthomogeneityGraphN, v : Double) -> StatstesthomogeneityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_graphn_min(s : StatstesthomogeneityGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_graphn_max(s : StatstesthomogeneityGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_graphn_to_string(s : StatstesthomogeneityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_node_make(size : Int) -> StatstesthomogeneityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_node_len(s : StatstesthomogeneityNode) -> Int { s.size }

pub fn stats_test_homogeneity_node_get(s : StatstesthomogeneityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_node_set(s : StatstesthomogeneityNode, i : Int, v : Double) -> StatstesthomogeneityNode {
  let result = stats_test_homogeneity_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_node_sum(s : StatstesthomogeneityNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_node_mean(s : StatstesthomogeneityNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_node_scale(s : StatstesthomogeneityNode, f : Double) -> StatstesthomogeneityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_node_add(a : StatstesthomogeneityNode, b : StatstesthomogeneityNode) -> StatstesthomogeneityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_node_copy(s : StatstesthomogeneityNode) -> StatstesthomogeneityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_node_fill(s : StatstesthomogeneityNode, v : Double) -> StatstesthomogeneityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_node_min(s : StatstesthomogeneityNode) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_node_max(s : StatstesthomogeneityNode) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_node_to_string(s : StatstesthomogeneityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_edge_make(size : Int) -> StatstesthomogeneityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_edge_len(s : StatstesthomogeneityEdge) -> Int { s.size }

pub fn stats_test_homogeneity_edge_get(s : StatstesthomogeneityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_edge_set(s : StatstesthomogeneityEdge, i : Int, v : Double) -> StatstesthomogeneityEdge {
  let result = stats_test_homogeneity_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_edge_sum(s : StatstesthomogeneityEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_edge_mean(s : StatstesthomogeneityEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_edge_scale(s : StatstesthomogeneityEdge, f : Double) -> StatstesthomogeneityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_edge_add(a : StatstesthomogeneityEdge, b : StatstesthomogeneityEdge) -> StatstesthomogeneityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_edge_copy(s : StatstesthomogeneityEdge) -> StatstesthomogeneityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_edge_fill(s : StatstesthomogeneityEdge, v : Double) -> StatstesthomogeneityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_edge_min(s : StatstesthomogeneityEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_edge_max(s : StatstesthomogeneityEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_edge_to_string(s : StatstesthomogeneityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_path_make(size : Int) -> StatstesthomogeneityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_path_len(s : StatstesthomogeneityPath) -> Int { s.size }

pub fn stats_test_homogeneity_path_get(s : StatstesthomogeneityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_path_set(s : StatstesthomogeneityPath, i : Int, v : Double) -> StatstesthomogeneityPath {
  let result = stats_test_homogeneity_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_path_sum(s : StatstesthomogeneityPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_path_mean(s : StatstesthomogeneityPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_path_scale(s : StatstesthomogeneityPath, f : Double) -> StatstesthomogeneityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_path_add(a : StatstesthomogeneityPath, b : StatstesthomogeneityPath) -> StatstesthomogeneityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_path_copy(s : StatstesthomogeneityPath) -> StatstesthomogeneityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_path_fill(s : StatstesthomogeneityPath, v : Double) -> StatstesthomogeneityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_path_min(s : StatstesthomogeneityPath) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_path_max(s : StatstesthomogeneityPath) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_path_to_string(s : StatstesthomogeneityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_cluster_make(size : Int) -> StatstesthomogeneityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_cluster_len(s : StatstesthomogeneityCluster) -> Int { s.size }

pub fn stats_test_homogeneity_cluster_get(s : StatstesthomogeneityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_cluster_set(s : StatstesthomogeneityCluster, i : Int, v : Double) -> StatstesthomogeneityCluster {
  let result = stats_test_homogeneity_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_cluster_sum(s : StatstesthomogeneityCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_cluster_mean(s : StatstesthomogeneityCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_cluster_scale(s : StatstesthomogeneityCluster, f : Double) -> StatstesthomogeneityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cluster_add(a : StatstesthomogeneityCluster, b : StatstesthomogeneityCluster) -> StatstesthomogeneityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_cluster_copy(s : StatstesthomogeneityCluster) -> StatstesthomogeneityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cluster_fill(s : StatstesthomogeneityCluster, v : Double) -> StatstesthomogeneityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cluster_min(s : StatstesthomogeneityCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_cluster_max(s : StatstesthomogeneityCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_cluster_to_string(s : StatstesthomogeneityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_model_make(size : Int) -> StatstesthomogeneityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_model_len(s : StatstesthomogeneityModel) -> Int { s.size }

pub fn stats_test_homogeneity_model_get(s : StatstesthomogeneityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_model_set(s : StatstesthomogeneityModel, i : Int, v : Double) -> StatstesthomogeneityModel {
  let result = stats_test_homogeneity_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_model_sum(s : StatstesthomogeneityModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_model_mean(s : StatstesthomogeneityModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_model_scale(s : StatstesthomogeneityModel, f : Double) -> StatstesthomogeneityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_model_add(a : StatstesthomogeneityModel, b : StatstesthomogeneityModel) -> StatstesthomogeneityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_model_copy(s : StatstesthomogeneityModel) -> StatstesthomogeneityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_model_fill(s : StatstesthomogeneityModel, v : Double) -> StatstesthomogeneityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_model_min(s : StatstesthomogeneityModel) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_model_max(s : StatstesthomogeneityModel) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_model_to_string(s : StatstesthomogeneityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_layer_make(size : Int) -> StatstesthomogeneityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_layer_len(s : StatstesthomogeneityLayer) -> Int { s.size }

pub fn stats_test_homogeneity_layer_get(s : StatstesthomogeneityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_layer_set(s : StatstesthomogeneityLayer, i : Int, v : Double) -> StatstesthomogeneityLayer {
  let result = stats_test_homogeneity_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_layer_sum(s : StatstesthomogeneityLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_layer_mean(s : StatstesthomogeneityLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_layer_scale(s : StatstesthomogeneityLayer, f : Double) -> StatstesthomogeneityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_layer_add(a : StatstesthomogeneityLayer, b : StatstesthomogeneityLayer) -> StatstesthomogeneityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_layer_copy(s : StatstesthomogeneityLayer) -> StatstesthomogeneityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_layer_fill(s : StatstesthomogeneityLayer, v : Double) -> StatstesthomogeneityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_layer_min(s : StatstesthomogeneityLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_layer_max(s : StatstesthomogeneityLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_layer_to_string(s : StatstesthomogeneityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_buffer_make(size : Int) -> StatstesthomogeneityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_buffer_len(s : StatstesthomogeneityBuffer) -> Int { s.size }

pub fn stats_test_homogeneity_buffer_get(s : StatstesthomogeneityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_buffer_set(s : StatstesthomogeneityBuffer, i : Int, v : Double) -> StatstesthomogeneityBuffer {
  let result = stats_test_homogeneity_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_buffer_sum(s : StatstesthomogeneityBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_buffer_mean(s : StatstesthomogeneityBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_buffer_scale(s : StatstesthomogeneityBuffer, f : Double) -> StatstesthomogeneityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_buffer_add(a : StatstesthomogeneityBuffer, b : StatstesthomogeneityBuffer) -> StatstesthomogeneityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_buffer_copy(s : StatstesthomogeneityBuffer) -> StatstesthomogeneityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_buffer_fill(s : StatstesthomogeneityBuffer, v : Double) -> StatstesthomogeneityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_buffer_min(s : StatstesthomogeneityBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_buffer_max(s : StatstesthomogeneityBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_buffer_to_string(s : StatstesthomogeneityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_cursor_make(size : Int) -> StatstesthomogeneityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_cursor_len(s : StatstesthomogeneityCursor) -> Int { s.size }

pub fn stats_test_homogeneity_cursor_get(s : StatstesthomogeneityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_cursor_set(s : StatstesthomogeneityCursor, i : Int, v : Double) -> StatstesthomogeneityCursor {
  let result = stats_test_homogeneity_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_cursor_sum(s : StatstesthomogeneityCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_cursor_mean(s : StatstesthomogeneityCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_cursor_scale(s : StatstesthomogeneityCursor, f : Double) -> StatstesthomogeneityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cursor_add(a : StatstesthomogeneityCursor, b : StatstesthomogeneityCursor) -> StatstesthomogeneityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_cursor_copy(s : StatstesthomogeneityCursor) -> StatstesthomogeneityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cursor_fill(s : StatstesthomogeneityCursor, v : Double) -> StatstesthomogeneityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_cursor_min(s : StatstesthomogeneityCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_cursor_max(s : StatstesthomogeneityCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_cursor_to_string(s : StatstesthomogeneityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_view_make(size : Int) -> StatstesthomogeneityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_view_len(s : StatstesthomogeneityView) -> Int { s.size }

pub fn stats_test_homogeneity_view_get(s : StatstesthomogeneityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_view_set(s : StatstesthomogeneityView, i : Int, v : Double) -> StatstesthomogeneityView {
  let result = stats_test_homogeneity_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_view_sum(s : StatstesthomogeneityView) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_view_mean(s : StatstesthomogeneityView) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_view_scale(s : StatstesthomogeneityView, f : Double) -> StatstesthomogeneityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_view_add(a : StatstesthomogeneityView, b : StatstesthomogeneityView) -> StatstesthomogeneityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_view_copy(s : StatstesthomogeneityView) -> StatstesthomogeneityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_view_fill(s : StatstesthomogeneityView, v : Double) -> StatstesthomogeneityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_view_min(s : StatstesthomogeneityView) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_view_max(s : StatstesthomogeneityView) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_view_to_string(s : StatstesthomogeneityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_range_make(size : Int) -> StatstesthomogeneityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_range_len(s : StatstesthomogeneityRange) -> Int { s.size }

pub fn stats_test_homogeneity_range_get(s : StatstesthomogeneityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_range_set(s : StatstesthomogeneityRange, i : Int, v : Double) -> StatstesthomogeneityRange {
  let result = stats_test_homogeneity_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_range_sum(s : StatstesthomogeneityRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_range_mean(s : StatstesthomogeneityRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_range_scale(s : StatstesthomogeneityRange, f : Double) -> StatstesthomogeneityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_range_add(a : StatstesthomogeneityRange, b : StatstesthomogeneityRange) -> StatstesthomogeneityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_range_copy(s : StatstesthomogeneityRange) -> StatstesthomogeneityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_range_fill(s : StatstesthomogeneityRange, v : Double) -> StatstesthomogeneityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_range_min(s : StatstesthomogeneityRange) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_range_max(s : StatstesthomogeneityRange) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_range_to_string(s : StatstesthomogeneityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesthomogeneitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_homogeneity_slice_make(size : Int) -> StatstesthomogeneitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_homogeneity_slice_len(s : StatstesthomogeneitySlice) -> Int { s.size }

pub fn stats_test_homogeneity_slice_get(s : StatstesthomogeneitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_homogeneity_slice_set(s : StatstesthomogeneitySlice, i : Int, v : Double) -> StatstesthomogeneitySlice {
  let result = stats_test_homogeneity_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_homogeneity_slice_sum(s : StatstesthomogeneitySlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_homogeneity_slice_mean(s : StatstesthomogeneitySlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_homogeneity_slice_scale(s : StatstesthomogeneitySlice, f : Double) -> StatstesthomogeneitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_slice_add(a : StatstesthomogeneitySlice, b : StatstesthomogeneitySlice) -> StatstesthomogeneitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_homogeneity_slice_copy(s : StatstesthomogeneitySlice) -> StatstesthomogeneitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_slice_fill(s : StatstesthomogeneitySlice, v : Double) -> StatstesthomogeneitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_homogeneity_slice_min(s : StatstesthomogeneitySlice) -> Double { @_common.min(s.data) }

pub fn stats_test_homogeneity_slice_max(s : StatstesthomogeneitySlice) -> Double { @_common.max(s.data) }

pub fn stats_test_homogeneity_slice_to_string(s : StatstesthomogeneitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

