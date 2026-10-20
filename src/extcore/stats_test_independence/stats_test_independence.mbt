///===
/// extcore/stats_test_independence

pub(all) struct StatstestindependencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_independence_make_point(x : Double, y : Double) -> StatstestindependencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_independence_make_point3(x : Double, y : Double, z : Double) -> StatstestindependencePoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_independence_point_x(pt : StatstestindependencePoint) -> Double { pt.x }

pub fn stats_test_independence_point_y(pt : StatstestindependencePoint) -> Double { pt.y }

pub fn stats_test_independence_point_z(pt : StatstestindependencePoint) -> Double { pt.z }

pub fn stats_test_independence_point_label(pt : StatstestindependencePoint) -> Int { pt.label }

pub fn stats_test_independence_point_dist(a : StatstestindependencePoint, b : StatstestindependencePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_independence_point_add(a : StatstestindependencePoint, b : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_independence_point_sub(a : StatstestindependencePoint, b : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_independence_point_scale(pt : StatstestindependencePoint, s : Double) -> StatstestindependencePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_independence_point_dot(a : StatstestindependencePoint, b : StatstestindependencePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_independence_point_cross(a : StatstestindependencePoint, b : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_independence_point_norm(pt : StatstestindependencePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_independence_point_normalize(pt : StatstestindependencePoint) -> StatstestindependencePoint {
  let n = stats_test_independence_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_independence_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_independence_point_negate(pt : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_independence_point_mid(a : StatstestindependencePoint, b : StatstestindependencePoint) -> StatstestindependencePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_independence_point_lerp(a : StatstestindependencePoint, b : StatstestindependencePoint, t : Double) -> StatstestindependencePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_independence_point_to_string(pt : StatstestindependencePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestindependenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_independence_make_series(vals : Array[Double], name : String) -> StatstestindependenceSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_independence_series_len(s : StatstestindependenceSeries) -> Int { s.vals.length() }

pub fn stats_test_independence_series_sum(s : StatstestindependenceSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_test_independence_series_mean(s : StatstestindependenceSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_test_independence_series_min(s : StatstestindependenceSeries) -> Double { @_common.min(s.vals) }

pub fn stats_test_independence_series_max(s : StatstestindependenceSeries) -> Double { @_common.max(s.vals) }

pub fn stats_test_independence_series_range(s : StatstestindependenceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_test_independence_series_var(s : StatstestindependenceSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_test_independence_series_std(s : StatstestindependenceSeries) -> Double { @_common.std(s.vals) }

pub fn stats_test_independence_series_median(s : StatstestindependenceSeries) -> Double { @_common.median(s.vals) }

pub fn stats_test_independence_series_scale(s : StatstestindependenceSeries, f : Double) -> StatstestindependenceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_independence_series_add(a : StatstestindependenceSeries, b : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_independence_series_sub(a : StatstestindependenceSeries, b : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_independence_series_normalize(s : StatstestindependenceSeries) -> StatstestindependenceSeries {
  let mn = stats_test_independence_series_min(s)
  let mx = stats_test_independence_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_independence_series_cumsum(s : StatstestindependenceSeries) -> StatstestindependenceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_independence_series_to_string(s : StatstestindependenceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestindependenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_independence_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestindependenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_independence_matrix_identity(n : Int) -> StatstestindependenceMatrix {
  let m = stats_test_independence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_independence_matrix_get(m : StatstestindependenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_independence_matrix_transpose(m : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  let result = stats_test_independence_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_independence_matrix_add(a : StatstestindependenceMatrix, b : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_independence_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_independence_matrix_scale(m : StatstestindependenceMatrix, s : Double) -> StatstestindependenceMatrix {
  let result = stats_test_independence_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_independence_matrix_multiply(a : StatstestindependenceMatrix, b : StatstestindependenceMatrix) -> StatstestindependenceMatrix {
  if a.cols != b.rows { return stats_test_independence_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_independence_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_independence_matrix_trace(m : StatstestindependenceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_independence_matrix_det(m : StatstestindependenceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_independence_matrix_norm(m : StatstestindependenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_independence_matrix_to_string(m : StatstestindependenceMatrix) -> String {
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

pub(all) struct StatstestindependenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_independence_make_vector(comps : Array[Double]) -> StatstestindependenceVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_independence_vector_zero(dim : Int) -> StatstestindependenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_independence_vector_add(a : StatstestindependenceVector, b : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_independence_vector_sub(a : StatstestindependenceVector, b : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_independence_vector_scale(v : StatstestindependenceVector, s : Double) -> StatstestindependenceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_independence_vector_dot(a : StatstestindependenceVector, b : StatstestindependenceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_independence_vector_norm(v : StatstestindependenceVector) -> Double { @_common.sqrt(stats_test_independence_vector_dot(v, v)) }

pub fn stats_test_independence_vector_normalize(v : StatstestindependenceVector) -> StatstestindependenceVector {
  let n = stats_test_independence_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_independence_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_independence_vector_dist(a : StatstestindependenceVector, b : StatstestindependenceVector) -> Double {
  stats_test_independence_vector_norm(stats_test_independence_vector_sub(a, b))
}

pub fn stats_test_independence_vector_to_string(v : StatstestindependenceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_independence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_independence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_independence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_independence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_independence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_independence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_independence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_independence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_independence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_independence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_independence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_independence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_independence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_independence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_independence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_independence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_independence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_independence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_independence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_independence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_independence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_independence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_independence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_independence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_independence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_independence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_independence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_independence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_independence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestindependenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_frame_make(size : Int) -> StatstestindependenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_frame_len(s : StatstestindependenceFrame) -> Int { s.size }

pub fn stats_test_independence_frame_get(s : StatstestindependenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_frame_set(s : StatstestindependenceFrame, i : Int, v : Double) -> StatstestindependenceFrame {
  let result = stats_test_independence_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_frame_sum(s : StatstestindependenceFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_frame_mean(s : StatstestindependenceFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_frame_scale(s : StatstestindependenceFrame, f : Double) -> StatstestindependenceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_frame_add(a : StatstestindependenceFrame, b : StatstestindependenceFrame) -> StatstestindependenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_frame_copy(s : StatstestindependenceFrame) -> StatstestindependenceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_frame_fill(s : StatstestindependenceFrame, v : Double) -> StatstestindependenceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_frame_min(s : StatstestindependenceFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_frame_max(s : StatstestindependenceFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_frame_to_string(s : StatstestindependenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_table_make(size : Int) -> StatstestindependenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_table_len(s : StatstestindependenceTable) -> Int { s.size }

pub fn stats_test_independence_table_get(s : StatstestindependenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_table_set(s : StatstestindependenceTable, i : Int, v : Double) -> StatstestindependenceTable {
  let result = stats_test_independence_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_table_sum(s : StatstestindependenceTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_table_mean(s : StatstestindependenceTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_table_scale(s : StatstestindependenceTable, f : Double) -> StatstestindependenceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_table_add(a : StatstestindependenceTable, b : StatstestindependenceTable) -> StatstestindependenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_table_copy(s : StatstestindependenceTable) -> StatstestindependenceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_table_fill(s : StatstestindependenceTable, v : Double) -> StatstestindependenceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_table_min(s : StatstestindependenceTable) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_table_max(s : StatstestindependenceTable) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_table_to_string(s : StatstestindependenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_graphn_make(size : Int) -> StatstestindependenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_graphn_len(s : StatstestindependenceGraphN) -> Int { s.size }

pub fn stats_test_independence_graphn_get(s : StatstestindependenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_graphn_set(s : StatstestindependenceGraphN, i : Int, v : Double) -> StatstestindependenceGraphN {
  let result = stats_test_independence_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_graphn_sum(s : StatstestindependenceGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_graphn_mean(s : StatstestindependenceGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_graphn_scale(s : StatstestindependenceGraphN, f : Double) -> StatstestindependenceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_graphn_add(a : StatstestindependenceGraphN, b : StatstestindependenceGraphN) -> StatstestindependenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_graphn_copy(s : StatstestindependenceGraphN) -> StatstestindependenceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_graphn_fill(s : StatstestindependenceGraphN, v : Double) -> StatstestindependenceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_graphn_min(s : StatstestindependenceGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_graphn_max(s : StatstestindependenceGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_graphn_to_string(s : StatstestindependenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_node_make(size : Int) -> StatstestindependenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_node_len(s : StatstestindependenceNode) -> Int { s.size }

pub fn stats_test_independence_node_get(s : StatstestindependenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_node_set(s : StatstestindependenceNode, i : Int, v : Double) -> StatstestindependenceNode {
  let result = stats_test_independence_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_node_sum(s : StatstestindependenceNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_node_mean(s : StatstestindependenceNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_node_scale(s : StatstestindependenceNode, f : Double) -> StatstestindependenceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_node_add(a : StatstestindependenceNode, b : StatstestindependenceNode) -> StatstestindependenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_node_copy(s : StatstestindependenceNode) -> StatstestindependenceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_node_fill(s : StatstestindependenceNode, v : Double) -> StatstestindependenceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_node_min(s : StatstestindependenceNode) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_node_max(s : StatstestindependenceNode) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_node_to_string(s : StatstestindependenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_edge_make(size : Int) -> StatstestindependenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_edge_len(s : StatstestindependenceEdge) -> Int { s.size }

pub fn stats_test_independence_edge_get(s : StatstestindependenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_edge_set(s : StatstestindependenceEdge, i : Int, v : Double) -> StatstestindependenceEdge {
  let result = stats_test_independence_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_edge_sum(s : StatstestindependenceEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_edge_mean(s : StatstestindependenceEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_edge_scale(s : StatstestindependenceEdge, f : Double) -> StatstestindependenceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_edge_add(a : StatstestindependenceEdge, b : StatstestindependenceEdge) -> StatstestindependenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_edge_copy(s : StatstestindependenceEdge) -> StatstestindependenceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_edge_fill(s : StatstestindependenceEdge, v : Double) -> StatstestindependenceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_edge_min(s : StatstestindependenceEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_edge_max(s : StatstestindependenceEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_edge_to_string(s : StatstestindependenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_path_make(size : Int) -> StatstestindependencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_path_len(s : StatstestindependencePath) -> Int { s.size }

pub fn stats_test_independence_path_get(s : StatstestindependencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_path_set(s : StatstestindependencePath, i : Int, v : Double) -> StatstestindependencePath {
  let result = stats_test_independence_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_path_sum(s : StatstestindependencePath) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_path_mean(s : StatstestindependencePath) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_path_scale(s : StatstestindependencePath, f : Double) -> StatstestindependencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_path_add(a : StatstestindependencePath, b : StatstestindependencePath) -> StatstestindependencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_path_copy(s : StatstestindependencePath) -> StatstestindependencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_path_fill(s : StatstestindependencePath, v : Double) -> StatstestindependencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_path_min(s : StatstestindependencePath) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_path_max(s : StatstestindependencePath) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_path_to_string(s : StatstestindependencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_cluster_make(size : Int) -> StatstestindependenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_cluster_len(s : StatstestindependenceCluster) -> Int { s.size }

pub fn stats_test_independence_cluster_get(s : StatstestindependenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_cluster_set(s : StatstestindependenceCluster, i : Int, v : Double) -> StatstestindependenceCluster {
  let result = stats_test_independence_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_cluster_sum(s : StatstestindependenceCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_cluster_mean(s : StatstestindependenceCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_cluster_scale(s : StatstestindependenceCluster, f : Double) -> StatstestindependenceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cluster_add(a : StatstestindependenceCluster, b : StatstestindependenceCluster) -> StatstestindependenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_cluster_copy(s : StatstestindependenceCluster) -> StatstestindependenceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cluster_fill(s : StatstestindependenceCluster, v : Double) -> StatstestindependenceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cluster_min(s : StatstestindependenceCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_cluster_max(s : StatstestindependenceCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_cluster_to_string(s : StatstestindependenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_model_make(size : Int) -> StatstestindependenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_model_len(s : StatstestindependenceModel) -> Int { s.size }

pub fn stats_test_independence_model_get(s : StatstestindependenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_model_set(s : StatstestindependenceModel, i : Int, v : Double) -> StatstestindependenceModel {
  let result = stats_test_independence_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_model_sum(s : StatstestindependenceModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_model_mean(s : StatstestindependenceModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_model_scale(s : StatstestindependenceModel, f : Double) -> StatstestindependenceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_model_add(a : StatstestindependenceModel, b : StatstestindependenceModel) -> StatstestindependenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_model_copy(s : StatstestindependenceModel) -> StatstestindependenceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_model_fill(s : StatstestindependenceModel, v : Double) -> StatstestindependenceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_model_min(s : StatstestindependenceModel) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_model_max(s : StatstestindependenceModel) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_model_to_string(s : StatstestindependenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_layer_make(size : Int) -> StatstestindependenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_layer_len(s : StatstestindependenceLayer) -> Int { s.size }

pub fn stats_test_independence_layer_get(s : StatstestindependenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_layer_set(s : StatstestindependenceLayer, i : Int, v : Double) -> StatstestindependenceLayer {
  let result = stats_test_independence_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_layer_sum(s : StatstestindependenceLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_layer_mean(s : StatstestindependenceLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_layer_scale(s : StatstestindependenceLayer, f : Double) -> StatstestindependenceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_layer_add(a : StatstestindependenceLayer, b : StatstestindependenceLayer) -> StatstestindependenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_layer_copy(s : StatstestindependenceLayer) -> StatstestindependenceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_layer_fill(s : StatstestindependenceLayer, v : Double) -> StatstestindependenceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_layer_min(s : StatstestindependenceLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_layer_max(s : StatstestindependenceLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_layer_to_string(s : StatstestindependenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_buffer_make(size : Int) -> StatstestindependenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_buffer_len(s : StatstestindependenceBuffer) -> Int { s.size }

pub fn stats_test_independence_buffer_get(s : StatstestindependenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_buffer_set(s : StatstestindependenceBuffer, i : Int, v : Double) -> StatstestindependenceBuffer {
  let result = stats_test_independence_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_buffer_sum(s : StatstestindependenceBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_buffer_mean(s : StatstestindependenceBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_buffer_scale(s : StatstestindependenceBuffer, f : Double) -> StatstestindependenceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_buffer_add(a : StatstestindependenceBuffer, b : StatstestindependenceBuffer) -> StatstestindependenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_buffer_copy(s : StatstestindependenceBuffer) -> StatstestindependenceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_buffer_fill(s : StatstestindependenceBuffer, v : Double) -> StatstestindependenceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_buffer_min(s : StatstestindependenceBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_buffer_max(s : StatstestindependenceBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_buffer_to_string(s : StatstestindependenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_cursor_make(size : Int) -> StatstestindependenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_cursor_len(s : StatstestindependenceCursor) -> Int { s.size }

pub fn stats_test_independence_cursor_get(s : StatstestindependenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_cursor_set(s : StatstestindependenceCursor, i : Int, v : Double) -> StatstestindependenceCursor {
  let result = stats_test_independence_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_cursor_sum(s : StatstestindependenceCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_cursor_mean(s : StatstestindependenceCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_cursor_scale(s : StatstestindependenceCursor, f : Double) -> StatstestindependenceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cursor_add(a : StatstestindependenceCursor, b : StatstestindependenceCursor) -> StatstestindependenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_cursor_copy(s : StatstestindependenceCursor) -> StatstestindependenceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cursor_fill(s : StatstestindependenceCursor, v : Double) -> StatstestindependenceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_cursor_min(s : StatstestindependenceCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_cursor_max(s : StatstestindependenceCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_cursor_to_string(s : StatstestindependenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_view_make(size : Int) -> StatstestindependenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_view_len(s : StatstestindependenceView) -> Int { s.size }

pub fn stats_test_independence_view_get(s : StatstestindependenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_view_set(s : StatstestindependenceView, i : Int, v : Double) -> StatstestindependenceView {
  let result = stats_test_independence_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_view_sum(s : StatstestindependenceView) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_view_mean(s : StatstestindependenceView) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_view_scale(s : StatstestindependenceView, f : Double) -> StatstestindependenceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_view_add(a : StatstestindependenceView, b : StatstestindependenceView) -> StatstestindependenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_view_copy(s : StatstestindependenceView) -> StatstestindependenceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_view_fill(s : StatstestindependenceView, v : Double) -> StatstestindependenceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_view_min(s : StatstestindependenceView) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_view_max(s : StatstestindependenceView) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_view_to_string(s : StatstestindependenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_range_make(size : Int) -> StatstestindependenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_range_len(s : StatstestindependenceRange) -> Int { s.size }

pub fn stats_test_independence_range_get(s : StatstestindependenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_range_set(s : StatstestindependenceRange, i : Int, v : Double) -> StatstestindependenceRange {
  let result = stats_test_independence_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_range_sum(s : StatstestindependenceRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_range_mean(s : StatstestindependenceRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_range_scale(s : StatstestindependenceRange, f : Double) -> StatstestindependenceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_range_add(a : StatstestindependenceRange, b : StatstestindependenceRange) -> StatstestindependenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_range_copy(s : StatstestindependenceRange) -> StatstestindependenceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_range_fill(s : StatstestindependenceRange, v : Double) -> StatstestindependenceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_range_min(s : StatstestindependenceRange) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_range_max(s : StatstestindependenceRange) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_range_to_string(s : StatstestindependenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestindependenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_independence_slice_make(size : Int) -> StatstestindependenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_independence_slice_len(s : StatstestindependenceSlice) -> Int { s.size }

pub fn stats_test_independence_slice_get(s : StatstestindependenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_independence_slice_set(s : StatstestindependenceSlice, i : Int, v : Double) -> StatstestindependenceSlice {
  let result = stats_test_independence_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_independence_slice_sum(s : StatstestindependenceSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_independence_slice_mean(s : StatstestindependenceSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_independence_slice_scale(s : StatstestindependenceSlice, f : Double) -> StatstestindependenceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_slice_add(a : StatstestindependenceSlice, b : StatstestindependenceSlice) -> StatstestindependenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_independence_slice_copy(s : StatstestindependenceSlice) -> StatstestindependenceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_slice_fill(s : StatstestindependenceSlice, v : Double) -> StatstestindependenceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_independence_slice_min(s : StatstestindependenceSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_independence_slice_max(s : StatstestindependenceSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_independence_slice_to_string(s : StatstestindependenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

