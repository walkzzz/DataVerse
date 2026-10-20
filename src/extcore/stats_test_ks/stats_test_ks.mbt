///===
/// extcore/stats_test_ks

pub(all) struct StatstestksPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_ks_make_point(x : Double, y : Double) -> StatstestksPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_ks_make_point3(x : Double, y : Double, z : Double) -> StatstestksPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_ks_point_x(pt : StatstestksPoint) -> Double { pt.x }

pub fn stats_test_ks_point_y(pt : StatstestksPoint) -> Double { pt.y }

pub fn stats_test_ks_point_z(pt : StatstestksPoint) -> Double { pt.z }

pub fn stats_test_ks_point_label(pt : StatstestksPoint) -> Int { pt.label }

pub fn stats_test_ks_point_dist(a : StatstestksPoint, b : StatstestksPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_ks_point_add(a : StatstestksPoint, b : StatstestksPoint) -> StatstestksPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_ks_point_sub(a : StatstestksPoint, b : StatstestksPoint) -> StatstestksPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_ks_point_scale(pt : StatstestksPoint, s : Double) -> StatstestksPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_ks_point_dot(a : StatstestksPoint, b : StatstestksPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_ks_point_cross(a : StatstestksPoint, b : StatstestksPoint) -> StatstestksPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_ks_point_norm(pt : StatstestksPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_ks_point_normalize(pt : StatstestksPoint) -> StatstestksPoint {
  let n = stats_test_ks_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_ks_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_ks_point_negate(pt : StatstestksPoint) -> StatstestksPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_ks_point_mid(a : StatstestksPoint, b : StatstestksPoint) -> StatstestksPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_ks_point_lerp(a : StatstestksPoint, b : StatstestksPoint, t : Double) -> StatstestksPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_ks_point_to_string(pt : StatstestksPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestksSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_ks_make_series(vals : Array[Double], name : String) -> StatstestksSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_ks_series_len(s : StatstestksSeries) -> Int { s.vals.length() }

pub fn stats_test_ks_series_sum(s : StatstestksSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_test_ks_series_mean(s : StatstestksSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_test_ks_series_min(s : StatstestksSeries) -> Double { @_common.min(s.vals) }

pub fn stats_test_ks_series_max(s : StatstestksSeries) -> Double { @_common.max(s.vals) }

pub fn stats_test_ks_series_range(s : StatstestksSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_test_ks_series_var(s : StatstestksSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_test_ks_series_std(s : StatstestksSeries) -> Double { @_common.std(s.vals) }

pub fn stats_test_ks_series_median(s : StatstestksSeries) -> Double { @_common.median(s.vals) }

pub fn stats_test_ks_series_scale(s : StatstestksSeries, f : Double) -> StatstestksSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_ks_series_add(a : StatstestksSeries, b : StatstestksSeries) -> StatstestksSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_ks_series_sub(a : StatstestksSeries, b : StatstestksSeries) -> StatstestksSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_ks_series_normalize(s : StatstestksSeries) -> StatstestksSeries {
  let mn = stats_test_ks_series_min(s)
  let mx = stats_test_ks_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_ks_series_cumsum(s : StatstestksSeries) -> StatstestksSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_ks_series_to_string(s : StatstestksSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestksMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_ks_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestksMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_ks_matrix_identity(n : Int) -> StatstestksMatrix {
  let m = stats_test_ks_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_ks_matrix_get(m : StatstestksMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_ks_matrix_transpose(m : StatstestksMatrix) -> StatstestksMatrix {
  let result = stats_test_ks_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_ks_matrix_add(a : StatstestksMatrix, b : StatstestksMatrix) -> StatstestksMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_ks_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_ks_matrix_scale(m : StatstestksMatrix, s : Double) -> StatstestksMatrix {
  let result = stats_test_ks_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_ks_matrix_multiply(a : StatstestksMatrix, b : StatstestksMatrix) -> StatstestksMatrix {
  if a.cols != b.rows { return stats_test_ks_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_ks_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_ks_matrix_trace(m : StatstestksMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_ks_matrix_det(m : StatstestksMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_ks_matrix_norm(m : StatstestksMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_ks_matrix_to_string(m : StatstestksMatrix) -> String {
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

pub(all) struct StatstestksVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_ks_make_vector(comps : Array[Double]) -> StatstestksVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_ks_vector_zero(dim : Int) -> StatstestksVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_ks_vector_add(a : StatstestksVector, b : StatstestksVector) -> StatstestksVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_ks_vector_sub(a : StatstestksVector, b : StatstestksVector) -> StatstestksVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_ks_vector_scale(v : StatstestksVector, s : Double) -> StatstestksVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_ks_vector_dot(a : StatstestksVector, b : StatstestksVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_ks_vector_norm(v : StatstestksVector) -> Double { @_common.sqrt(stats_test_ks_vector_dot(v, v)) }

pub fn stats_test_ks_vector_normalize(v : StatstestksVector) -> StatstestksVector {
  let n = stats_test_ks_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_ks_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_ks_vector_dist(a : StatstestksVector, b : StatstestksVector) -> Double {
  stats_test_ks_vector_norm(stats_test_ks_vector_sub(a, b))
}

pub fn stats_test_ks_vector_to_string(v : StatstestksVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_ks_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_ks_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_ks_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_ks_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_ks_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_ks_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_ks_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_ks_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_ks_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_ks_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_ks_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_ks_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_ks_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_ks_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_ks_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_ks_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_ks_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_ks_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_ks_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_ks_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_ks_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_ks_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_ks_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_ks_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_ks_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_ks_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_ks_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_ks_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_ks_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestksFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_frame_make(size : Int) -> StatstestksFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_frame_len(s : StatstestksFrame) -> Int { s.size }

pub fn stats_test_ks_frame_get(s : StatstestksFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_frame_set(s : StatstestksFrame, i : Int, v : Double) -> StatstestksFrame {
  let result = stats_test_ks_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_frame_sum(s : StatstestksFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_frame_mean(s : StatstestksFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_frame_scale(s : StatstestksFrame, f : Double) -> StatstestksFrame {
  let result = stats_test_ks_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_frame_add(a : StatstestksFrame, b : StatstestksFrame) -> StatstestksFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_frame_copy(s : StatstestksFrame) -> StatstestksFrame {
  let result = stats_test_ks_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_frame_fill(s : StatstestksFrame, v : Double) -> StatstestksFrame {
  let result = stats_test_ks_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_frame_min(s : StatstestksFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_frame_max(s : StatstestksFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_frame_to_string(s : StatstestksFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_table_make(size : Int) -> StatstestksTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_table_len(s : StatstestksTable) -> Int { s.size }

pub fn stats_test_ks_table_get(s : StatstestksTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_table_set(s : StatstestksTable, i : Int, v : Double) -> StatstestksTable {
  let result = stats_test_ks_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_table_sum(s : StatstestksTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_table_mean(s : StatstestksTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_table_scale(s : StatstestksTable, f : Double) -> StatstestksTable {
  let result = stats_test_ks_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_table_add(a : StatstestksTable, b : StatstestksTable) -> StatstestksTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_table_copy(s : StatstestksTable) -> StatstestksTable {
  let result = stats_test_ks_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_table_fill(s : StatstestksTable, v : Double) -> StatstestksTable {
  let result = stats_test_ks_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_table_min(s : StatstestksTable) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_table_max(s : StatstestksTable) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_table_to_string(s : StatstestksTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_graphn_make(size : Int) -> StatstestksGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_graphn_len(s : StatstestksGraphN) -> Int { s.size }

pub fn stats_test_ks_graphn_get(s : StatstestksGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_graphn_set(s : StatstestksGraphN, i : Int, v : Double) -> StatstestksGraphN {
  let result = stats_test_ks_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_graphn_sum(s : StatstestksGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_graphn_mean(s : StatstestksGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_graphn_scale(s : StatstestksGraphN, f : Double) -> StatstestksGraphN {
  let result = stats_test_ks_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_graphn_add(a : StatstestksGraphN, b : StatstestksGraphN) -> StatstestksGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_graphn_copy(s : StatstestksGraphN) -> StatstestksGraphN {
  let result = stats_test_ks_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_graphn_fill(s : StatstestksGraphN, v : Double) -> StatstestksGraphN {
  let result = stats_test_ks_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_graphn_min(s : StatstestksGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_graphn_max(s : StatstestksGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_graphn_to_string(s : StatstestksGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_node_make(size : Int) -> StatstestksNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_node_len(s : StatstestksNode) -> Int { s.size }

pub fn stats_test_ks_node_get(s : StatstestksNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_node_set(s : StatstestksNode, i : Int, v : Double) -> StatstestksNode {
  let result = stats_test_ks_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_node_sum(s : StatstestksNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_node_mean(s : StatstestksNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_node_scale(s : StatstestksNode, f : Double) -> StatstestksNode {
  let result = stats_test_ks_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_node_add(a : StatstestksNode, b : StatstestksNode) -> StatstestksNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_node_copy(s : StatstestksNode) -> StatstestksNode {
  let result = stats_test_ks_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_node_fill(s : StatstestksNode, v : Double) -> StatstestksNode {
  let result = stats_test_ks_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_node_min(s : StatstestksNode) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_node_max(s : StatstestksNode) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_node_to_string(s : StatstestksNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_edge_make(size : Int) -> StatstestksEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_edge_len(s : StatstestksEdge) -> Int { s.size }

pub fn stats_test_ks_edge_get(s : StatstestksEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_edge_set(s : StatstestksEdge, i : Int, v : Double) -> StatstestksEdge {
  let result = stats_test_ks_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_edge_sum(s : StatstestksEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_edge_mean(s : StatstestksEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_edge_scale(s : StatstestksEdge, f : Double) -> StatstestksEdge {
  let result = stats_test_ks_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_edge_add(a : StatstestksEdge, b : StatstestksEdge) -> StatstestksEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_edge_copy(s : StatstestksEdge) -> StatstestksEdge {
  let result = stats_test_ks_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_edge_fill(s : StatstestksEdge, v : Double) -> StatstestksEdge {
  let result = stats_test_ks_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_edge_min(s : StatstestksEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_edge_max(s : StatstestksEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_edge_to_string(s : StatstestksEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_path_make(size : Int) -> StatstestksPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_path_len(s : StatstestksPath) -> Int { s.size }

pub fn stats_test_ks_path_get(s : StatstestksPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_path_set(s : StatstestksPath, i : Int, v : Double) -> StatstestksPath {
  let result = stats_test_ks_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_path_sum(s : StatstestksPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_path_mean(s : StatstestksPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_path_scale(s : StatstestksPath, f : Double) -> StatstestksPath {
  let result = stats_test_ks_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_path_add(a : StatstestksPath, b : StatstestksPath) -> StatstestksPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_path_copy(s : StatstestksPath) -> StatstestksPath {
  let result = stats_test_ks_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_path_fill(s : StatstestksPath, v : Double) -> StatstestksPath {
  let result = stats_test_ks_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_path_min(s : StatstestksPath) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_path_max(s : StatstestksPath) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_path_to_string(s : StatstestksPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_cluster_make(size : Int) -> StatstestksCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_cluster_len(s : StatstestksCluster) -> Int { s.size }

pub fn stats_test_ks_cluster_get(s : StatstestksCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_cluster_set(s : StatstestksCluster, i : Int, v : Double) -> StatstestksCluster {
  let result = stats_test_ks_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_cluster_sum(s : StatstestksCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_cluster_mean(s : StatstestksCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_cluster_scale(s : StatstestksCluster, f : Double) -> StatstestksCluster {
  let result = stats_test_ks_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_cluster_add(a : StatstestksCluster, b : StatstestksCluster) -> StatstestksCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_cluster_copy(s : StatstestksCluster) -> StatstestksCluster {
  let result = stats_test_ks_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_cluster_fill(s : StatstestksCluster, v : Double) -> StatstestksCluster {
  let result = stats_test_ks_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_cluster_min(s : StatstestksCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_cluster_max(s : StatstestksCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_cluster_to_string(s : StatstestksCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_model_make(size : Int) -> StatstestksModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_model_len(s : StatstestksModel) -> Int { s.size }

pub fn stats_test_ks_model_get(s : StatstestksModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_model_set(s : StatstestksModel, i : Int, v : Double) -> StatstestksModel {
  let result = stats_test_ks_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_model_sum(s : StatstestksModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_model_mean(s : StatstestksModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_model_scale(s : StatstestksModel, f : Double) -> StatstestksModel {
  let result = stats_test_ks_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_model_add(a : StatstestksModel, b : StatstestksModel) -> StatstestksModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_model_copy(s : StatstestksModel) -> StatstestksModel {
  let result = stats_test_ks_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_model_fill(s : StatstestksModel, v : Double) -> StatstestksModel {
  let result = stats_test_ks_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_model_min(s : StatstestksModel) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_model_max(s : StatstestksModel) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_model_to_string(s : StatstestksModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_layer_make(size : Int) -> StatstestksLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_layer_len(s : StatstestksLayer) -> Int { s.size }

pub fn stats_test_ks_layer_get(s : StatstestksLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_layer_set(s : StatstestksLayer, i : Int, v : Double) -> StatstestksLayer {
  let result = stats_test_ks_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_layer_sum(s : StatstestksLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_layer_mean(s : StatstestksLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_layer_scale(s : StatstestksLayer, f : Double) -> StatstestksLayer {
  let result = stats_test_ks_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_layer_add(a : StatstestksLayer, b : StatstestksLayer) -> StatstestksLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_layer_copy(s : StatstestksLayer) -> StatstestksLayer {
  let result = stats_test_ks_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_layer_fill(s : StatstestksLayer, v : Double) -> StatstestksLayer {
  let result = stats_test_ks_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_layer_min(s : StatstestksLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_layer_max(s : StatstestksLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_layer_to_string(s : StatstestksLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_buffer_make(size : Int) -> StatstestksBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_buffer_len(s : StatstestksBuffer) -> Int { s.size }

pub fn stats_test_ks_buffer_get(s : StatstestksBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_buffer_set(s : StatstestksBuffer, i : Int, v : Double) -> StatstestksBuffer {
  let result = stats_test_ks_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_buffer_sum(s : StatstestksBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_buffer_mean(s : StatstestksBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_buffer_scale(s : StatstestksBuffer, f : Double) -> StatstestksBuffer {
  let result = stats_test_ks_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_buffer_add(a : StatstestksBuffer, b : StatstestksBuffer) -> StatstestksBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_buffer_copy(s : StatstestksBuffer) -> StatstestksBuffer {
  let result = stats_test_ks_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_buffer_fill(s : StatstestksBuffer, v : Double) -> StatstestksBuffer {
  let result = stats_test_ks_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_buffer_min(s : StatstestksBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_buffer_max(s : StatstestksBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_buffer_to_string(s : StatstestksBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_cursor_make(size : Int) -> StatstestksCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_cursor_len(s : StatstestksCursor) -> Int { s.size }

pub fn stats_test_ks_cursor_get(s : StatstestksCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_cursor_set(s : StatstestksCursor, i : Int, v : Double) -> StatstestksCursor {
  let result = stats_test_ks_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_cursor_sum(s : StatstestksCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_cursor_mean(s : StatstestksCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_cursor_scale(s : StatstestksCursor, f : Double) -> StatstestksCursor {
  let result = stats_test_ks_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_cursor_add(a : StatstestksCursor, b : StatstestksCursor) -> StatstestksCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_cursor_copy(s : StatstestksCursor) -> StatstestksCursor {
  let result = stats_test_ks_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_cursor_fill(s : StatstestksCursor, v : Double) -> StatstestksCursor {
  let result = stats_test_ks_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_cursor_min(s : StatstestksCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_cursor_max(s : StatstestksCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_cursor_to_string(s : StatstestksCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_view_make(size : Int) -> StatstestksView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_view_len(s : StatstestksView) -> Int { s.size }

pub fn stats_test_ks_view_get(s : StatstestksView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_view_set(s : StatstestksView, i : Int, v : Double) -> StatstestksView {
  let result = stats_test_ks_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_view_sum(s : StatstestksView) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_view_mean(s : StatstestksView) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_view_scale(s : StatstestksView, f : Double) -> StatstestksView {
  let result = stats_test_ks_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_view_add(a : StatstestksView, b : StatstestksView) -> StatstestksView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_view_copy(s : StatstestksView) -> StatstestksView {
  let result = stats_test_ks_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_view_fill(s : StatstestksView, v : Double) -> StatstestksView {
  let result = stats_test_ks_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_view_min(s : StatstestksView) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_view_max(s : StatstestksView) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_view_to_string(s : StatstestksView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_range_make(size : Int) -> StatstestksRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_range_len(s : StatstestksRange) -> Int { s.size }

pub fn stats_test_ks_range_get(s : StatstestksRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_range_set(s : StatstestksRange, i : Int, v : Double) -> StatstestksRange {
  let result = stats_test_ks_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_range_sum(s : StatstestksRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_range_mean(s : StatstestksRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_range_scale(s : StatstestksRange, f : Double) -> StatstestksRange {
  let result = stats_test_ks_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_range_add(a : StatstestksRange, b : StatstestksRange) -> StatstestksRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_range_copy(s : StatstestksRange) -> StatstestksRange {
  let result = stats_test_ks_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_range_fill(s : StatstestksRange, v : Double) -> StatstestksRange {
  let result = stats_test_ks_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_range_min(s : StatstestksRange) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_range_max(s : StatstestksRange) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_range_to_string(s : StatstestksRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestksSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_ks_slice_make(size : Int) -> StatstestksSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_ks_slice_len(s : StatstestksSlice) -> Int { s.size }

pub fn stats_test_ks_slice_get(s : StatstestksSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_ks_slice_set(s : StatstestksSlice, i : Int, v : Double) -> StatstestksSlice {
  let result = stats_test_ks_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_slice_sum(s : StatstestksSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_ks_slice_mean(s : StatstestksSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_ks_slice_scale(s : StatstestksSlice, f : Double) -> StatstestksSlice {
  let result = stats_test_ks_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_ks_slice_add(a : StatstestksSlice, b : StatstestksSlice) -> StatstestksSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_ks_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_ks_slice_copy(s : StatstestksSlice) -> StatstestksSlice {
  let result = stats_test_ks_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_ks_slice_fill(s : StatstestksSlice, v : Double) -> StatstestksSlice {
  let result = stats_test_ks_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_ks_slice_min(s : StatstestksSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_ks_slice_max(s : StatstestksSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_ks_slice_to_string(s : StatstestksSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

