///===
/// extcore/stats_dist_gamma

pub(all) struct StatsdistgammaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_gamma_make_point(x : Double, y : Double) -> StatsdistgammaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_gamma_make_point3(x : Double, y : Double, z : Double) -> StatsdistgammaPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_gamma_point_x(pt : StatsdistgammaPoint) -> Double { pt.x }

pub fn stats_dist_gamma_point_y(pt : StatsdistgammaPoint) -> Double { pt.y }

pub fn stats_dist_gamma_point_z(pt : StatsdistgammaPoint) -> Double { pt.z }

pub fn stats_dist_gamma_point_label(pt : StatsdistgammaPoint) -> Int { pt.label }

pub fn stats_dist_gamma_point_dist(a : StatsdistgammaPoint, b : StatsdistgammaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_gamma_point_add(a : StatsdistgammaPoint, b : StatsdistgammaPoint) -> StatsdistgammaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_gamma_point_sub(a : StatsdistgammaPoint, b : StatsdistgammaPoint) -> StatsdistgammaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_gamma_point_scale(pt : StatsdistgammaPoint, s : Double) -> StatsdistgammaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_gamma_point_dot(a : StatsdistgammaPoint, b : StatsdistgammaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_gamma_point_cross(a : StatsdistgammaPoint, b : StatsdistgammaPoint) -> StatsdistgammaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_gamma_point_norm(pt : StatsdistgammaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_gamma_point_normalize(pt : StatsdistgammaPoint) -> StatsdistgammaPoint {
  let n = stats_dist_gamma_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_gamma_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_gamma_point_negate(pt : StatsdistgammaPoint) -> StatsdistgammaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_gamma_point_mid(a : StatsdistgammaPoint, b : StatsdistgammaPoint) -> StatsdistgammaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_gamma_point_lerp(a : StatsdistgammaPoint, b : StatsdistgammaPoint, t : Double) -> StatsdistgammaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_gamma_point_to_string(pt : StatsdistgammaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistgammaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_gamma_make_series(vals : Array[Double], name : String) -> StatsdistgammaSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_gamma_series_len(s : StatsdistgammaSeries) -> Int { s.vals.length() }

pub fn stats_dist_gamma_series_sum(s : StatsdistgammaSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_dist_gamma_series_mean(s : StatsdistgammaSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_gamma_series_min(s : StatsdistgammaSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_gamma_series_max(s : StatsdistgammaSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_gamma_series_range(s : StatsdistgammaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_gamma_series_var(s : StatsdistgammaSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_gamma_series_std(s : StatsdistgammaSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_gamma_series_median(s : StatsdistgammaSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_gamma_series_scale(s : StatsdistgammaSeries, f : Double) -> StatsdistgammaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_gamma_series_add(a : StatsdistgammaSeries, b : StatsdistgammaSeries) -> StatsdistgammaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_gamma_series_sub(a : StatsdistgammaSeries, b : StatsdistgammaSeries) -> StatsdistgammaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_gamma_series_normalize(s : StatsdistgammaSeries) -> StatsdistgammaSeries {
  let mn = stats_dist_gamma_series_min(s)
  let mx = stats_dist_gamma_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_gamma_series_cumsum(s : StatsdistgammaSeries) -> StatsdistgammaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_gamma_series_to_string(s : StatsdistgammaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistgammaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_gamma_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistgammaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_gamma_matrix_identity(n : Int) -> StatsdistgammaMatrix {
  let m = stats_dist_gamma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_gamma_matrix_get(m : StatsdistgammaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_gamma_matrix_transpose(m : StatsdistgammaMatrix) -> StatsdistgammaMatrix {
  let result = stats_dist_gamma_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_gamma_matrix_add(a : StatsdistgammaMatrix, b : StatsdistgammaMatrix) -> StatsdistgammaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_gamma_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_gamma_matrix_scale(m : StatsdistgammaMatrix, s : Double) -> StatsdistgammaMatrix {
  let result = stats_dist_gamma_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_gamma_matrix_multiply(a : StatsdistgammaMatrix, b : StatsdistgammaMatrix) -> StatsdistgammaMatrix {
  if a.cols != b.rows { return stats_dist_gamma_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_gamma_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_gamma_matrix_trace(m : StatsdistgammaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_gamma_matrix_det(m : StatsdistgammaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_gamma_matrix_norm(m : StatsdistgammaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_gamma_matrix_to_string(m : StatsdistgammaMatrix) -> String {
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

pub(all) struct StatsdistgammaVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_gamma_make_vector(comps : Array[Double]) -> StatsdistgammaVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_gamma_vector_zero(dim : Int) -> StatsdistgammaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_gamma_vector_add(a : StatsdistgammaVector, b : StatsdistgammaVector) -> StatsdistgammaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_gamma_vector_sub(a : StatsdistgammaVector, b : StatsdistgammaVector) -> StatsdistgammaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_gamma_vector_scale(v : StatsdistgammaVector, s : Double) -> StatsdistgammaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_gamma_vector_dot(a : StatsdistgammaVector, b : StatsdistgammaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_gamma_vector_norm(v : StatsdistgammaVector) -> Double { @_common.sqrt(stats_dist_gamma_vector_dot(v, v)) }

pub fn stats_dist_gamma_vector_normalize(v : StatsdistgammaVector) -> StatsdistgammaVector {
  let n = stats_dist_gamma_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_gamma_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_gamma_vector_dist(a : StatsdistgammaVector, b : StatsdistgammaVector) -> Double {
  stats_dist_gamma_vector_norm(stats_dist_gamma_vector_sub(a, b))
}

pub fn stats_dist_gamma_vector_to_string(v : StatsdistgammaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_gamma_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_gamma_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_gamma_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_gamma_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_gamma_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_gamma_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_gamma_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_gamma_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_gamma_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_gamma_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_gamma_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_gamma_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_gamma_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_gamma_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_gamma_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_gamma_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_gamma_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_gamma_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_gamma_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_gamma_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_gamma_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_gamma_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_gamma_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_gamma_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_gamma_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_gamma_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_gamma_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_gamma_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_gamma_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistgammaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_frame_make(size : Int) -> StatsdistgammaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_frame_len(s : StatsdistgammaFrame) -> Int { s.size }

pub fn stats_dist_gamma_frame_get(s : StatsdistgammaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_frame_set(s : StatsdistgammaFrame, i : Int, v : Double) -> StatsdistgammaFrame {
  let result = stats_dist_gamma_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_frame_sum(s : StatsdistgammaFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_frame_mean(s : StatsdistgammaFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_frame_scale(s : StatsdistgammaFrame, f : Double) -> StatsdistgammaFrame {
  let result = stats_dist_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_frame_add(a : StatsdistgammaFrame, b : StatsdistgammaFrame) -> StatsdistgammaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_frame_copy(s : StatsdistgammaFrame) -> StatsdistgammaFrame {
  let result = stats_dist_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_frame_fill(s : StatsdistgammaFrame, v : Double) -> StatsdistgammaFrame {
  let result = stats_dist_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_frame_min(s : StatsdistgammaFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_frame_max(s : StatsdistgammaFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_frame_to_string(s : StatsdistgammaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_table_make(size : Int) -> StatsdistgammaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_table_len(s : StatsdistgammaTable) -> Int { s.size }

pub fn stats_dist_gamma_table_get(s : StatsdistgammaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_table_set(s : StatsdistgammaTable, i : Int, v : Double) -> StatsdistgammaTable {
  let result = stats_dist_gamma_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_table_sum(s : StatsdistgammaTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_table_mean(s : StatsdistgammaTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_table_scale(s : StatsdistgammaTable, f : Double) -> StatsdistgammaTable {
  let result = stats_dist_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_table_add(a : StatsdistgammaTable, b : StatsdistgammaTable) -> StatsdistgammaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_table_copy(s : StatsdistgammaTable) -> StatsdistgammaTable {
  let result = stats_dist_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_table_fill(s : StatsdistgammaTable, v : Double) -> StatsdistgammaTable {
  let result = stats_dist_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_table_min(s : StatsdistgammaTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_table_max(s : StatsdistgammaTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_table_to_string(s : StatsdistgammaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_graphn_make(size : Int) -> StatsdistgammaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_graphn_len(s : StatsdistgammaGraphN) -> Int { s.size }

pub fn stats_dist_gamma_graphn_get(s : StatsdistgammaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_graphn_set(s : StatsdistgammaGraphN, i : Int, v : Double) -> StatsdistgammaGraphN {
  let result = stats_dist_gamma_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_graphn_sum(s : StatsdistgammaGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_graphn_mean(s : StatsdistgammaGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_graphn_scale(s : StatsdistgammaGraphN, f : Double) -> StatsdistgammaGraphN {
  let result = stats_dist_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_graphn_add(a : StatsdistgammaGraphN, b : StatsdistgammaGraphN) -> StatsdistgammaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_graphn_copy(s : StatsdistgammaGraphN) -> StatsdistgammaGraphN {
  let result = stats_dist_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_graphn_fill(s : StatsdistgammaGraphN, v : Double) -> StatsdistgammaGraphN {
  let result = stats_dist_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_graphn_min(s : StatsdistgammaGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_graphn_max(s : StatsdistgammaGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_graphn_to_string(s : StatsdistgammaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_node_make(size : Int) -> StatsdistgammaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_node_len(s : StatsdistgammaNode) -> Int { s.size }

pub fn stats_dist_gamma_node_get(s : StatsdistgammaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_node_set(s : StatsdistgammaNode, i : Int, v : Double) -> StatsdistgammaNode {
  let result = stats_dist_gamma_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_node_sum(s : StatsdistgammaNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_node_mean(s : StatsdistgammaNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_node_scale(s : StatsdistgammaNode, f : Double) -> StatsdistgammaNode {
  let result = stats_dist_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_node_add(a : StatsdistgammaNode, b : StatsdistgammaNode) -> StatsdistgammaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_node_copy(s : StatsdistgammaNode) -> StatsdistgammaNode {
  let result = stats_dist_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_node_fill(s : StatsdistgammaNode, v : Double) -> StatsdistgammaNode {
  let result = stats_dist_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_node_min(s : StatsdistgammaNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_node_max(s : StatsdistgammaNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_node_to_string(s : StatsdistgammaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_edge_make(size : Int) -> StatsdistgammaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_edge_len(s : StatsdistgammaEdge) -> Int { s.size }

pub fn stats_dist_gamma_edge_get(s : StatsdistgammaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_edge_set(s : StatsdistgammaEdge, i : Int, v : Double) -> StatsdistgammaEdge {
  let result = stats_dist_gamma_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_edge_sum(s : StatsdistgammaEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_edge_mean(s : StatsdistgammaEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_edge_scale(s : StatsdistgammaEdge, f : Double) -> StatsdistgammaEdge {
  let result = stats_dist_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_edge_add(a : StatsdistgammaEdge, b : StatsdistgammaEdge) -> StatsdistgammaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_edge_copy(s : StatsdistgammaEdge) -> StatsdistgammaEdge {
  let result = stats_dist_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_edge_fill(s : StatsdistgammaEdge, v : Double) -> StatsdistgammaEdge {
  let result = stats_dist_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_edge_min(s : StatsdistgammaEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_edge_max(s : StatsdistgammaEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_edge_to_string(s : StatsdistgammaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_path_make(size : Int) -> StatsdistgammaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_path_len(s : StatsdistgammaPath) -> Int { s.size }

pub fn stats_dist_gamma_path_get(s : StatsdistgammaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_path_set(s : StatsdistgammaPath, i : Int, v : Double) -> StatsdistgammaPath {
  let result = stats_dist_gamma_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_path_sum(s : StatsdistgammaPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_path_mean(s : StatsdistgammaPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_path_scale(s : StatsdistgammaPath, f : Double) -> StatsdistgammaPath {
  let result = stats_dist_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_path_add(a : StatsdistgammaPath, b : StatsdistgammaPath) -> StatsdistgammaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_path_copy(s : StatsdistgammaPath) -> StatsdistgammaPath {
  let result = stats_dist_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_path_fill(s : StatsdistgammaPath, v : Double) -> StatsdistgammaPath {
  let result = stats_dist_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_path_min(s : StatsdistgammaPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_path_max(s : StatsdistgammaPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_path_to_string(s : StatsdistgammaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_cluster_make(size : Int) -> StatsdistgammaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_cluster_len(s : StatsdistgammaCluster) -> Int { s.size }

pub fn stats_dist_gamma_cluster_get(s : StatsdistgammaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_cluster_set(s : StatsdistgammaCluster, i : Int, v : Double) -> StatsdistgammaCluster {
  let result = stats_dist_gamma_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_cluster_sum(s : StatsdistgammaCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_cluster_mean(s : StatsdistgammaCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_cluster_scale(s : StatsdistgammaCluster, f : Double) -> StatsdistgammaCluster {
  let result = stats_dist_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_cluster_add(a : StatsdistgammaCluster, b : StatsdistgammaCluster) -> StatsdistgammaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_cluster_copy(s : StatsdistgammaCluster) -> StatsdistgammaCluster {
  let result = stats_dist_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_cluster_fill(s : StatsdistgammaCluster, v : Double) -> StatsdistgammaCluster {
  let result = stats_dist_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_cluster_min(s : StatsdistgammaCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_cluster_max(s : StatsdistgammaCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_cluster_to_string(s : StatsdistgammaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_model_make(size : Int) -> StatsdistgammaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_model_len(s : StatsdistgammaModel) -> Int { s.size }

pub fn stats_dist_gamma_model_get(s : StatsdistgammaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_model_set(s : StatsdistgammaModel, i : Int, v : Double) -> StatsdistgammaModel {
  let result = stats_dist_gamma_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_model_sum(s : StatsdistgammaModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_model_mean(s : StatsdistgammaModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_model_scale(s : StatsdistgammaModel, f : Double) -> StatsdistgammaModel {
  let result = stats_dist_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_model_add(a : StatsdistgammaModel, b : StatsdistgammaModel) -> StatsdistgammaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_model_copy(s : StatsdistgammaModel) -> StatsdistgammaModel {
  let result = stats_dist_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_model_fill(s : StatsdistgammaModel, v : Double) -> StatsdistgammaModel {
  let result = stats_dist_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_model_min(s : StatsdistgammaModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_model_max(s : StatsdistgammaModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_model_to_string(s : StatsdistgammaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_layer_make(size : Int) -> StatsdistgammaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_layer_len(s : StatsdistgammaLayer) -> Int { s.size }

pub fn stats_dist_gamma_layer_get(s : StatsdistgammaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_layer_set(s : StatsdistgammaLayer, i : Int, v : Double) -> StatsdistgammaLayer {
  let result = stats_dist_gamma_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_layer_sum(s : StatsdistgammaLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_layer_mean(s : StatsdistgammaLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_layer_scale(s : StatsdistgammaLayer, f : Double) -> StatsdistgammaLayer {
  let result = stats_dist_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_layer_add(a : StatsdistgammaLayer, b : StatsdistgammaLayer) -> StatsdistgammaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_layer_copy(s : StatsdistgammaLayer) -> StatsdistgammaLayer {
  let result = stats_dist_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_layer_fill(s : StatsdistgammaLayer, v : Double) -> StatsdistgammaLayer {
  let result = stats_dist_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_layer_min(s : StatsdistgammaLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_layer_max(s : StatsdistgammaLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_layer_to_string(s : StatsdistgammaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_buffer_make(size : Int) -> StatsdistgammaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_buffer_len(s : StatsdistgammaBuffer) -> Int { s.size }

pub fn stats_dist_gamma_buffer_get(s : StatsdistgammaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_buffer_set(s : StatsdistgammaBuffer, i : Int, v : Double) -> StatsdistgammaBuffer {
  let result = stats_dist_gamma_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_buffer_sum(s : StatsdistgammaBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_buffer_mean(s : StatsdistgammaBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_buffer_scale(s : StatsdistgammaBuffer, f : Double) -> StatsdistgammaBuffer {
  let result = stats_dist_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_buffer_add(a : StatsdistgammaBuffer, b : StatsdistgammaBuffer) -> StatsdistgammaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_buffer_copy(s : StatsdistgammaBuffer) -> StatsdistgammaBuffer {
  let result = stats_dist_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_buffer_fill(s : StatsdistgammaBuffer, v : Double) -> StatsdistgammaBuffer {
  let result = stats_dist_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_buffer_min(s : StatsdistgammaBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_buffer_max(s : StatsdistgammaBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_buffer_to_string(s : StatsdistgammaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_cursor_make(size : Int) -> StatsdistgammaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_cursor_len(s : StatsdistgammaCursor) -> Int { s.size }

pub fn stats_dist_gamma_cursor_get(s : StatsdistgammaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_cursor_set(s : StatsdistgammaCursor, i : Int, v : Double) -> StatsdistgammaCursor {
  let result = stats_dist_gamma_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_cursor_sum(s : StatsdistgammaCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_cursor_mean(s : StatsdistgammaCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_cursor_scale(s : StatsdistgammaCursor, f : Double) -> StatsdistgammaCursor {
  let result = stats_dist_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_cursor_add(a : StatsdistgammaCursor, b : StatsdistgammaCursor) -> StatsdistgammaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_cursor_copy(s : StatsdistgammaCursor) -> StatsdistgammaCursor {
  let result = stats_dist_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_cursor_fill(s : StatsdistgammaCursor, v : Double) -> StatsdistgammaCursor {
  let result = stats_dist_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_cursor_min(s : StatsdistgammaCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_cursor_max(s : StatsdistgammaCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_cursor_to_string(s : StatsdistgammaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_view_make(size : Int) -> StatsdistgammaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_view_len(s : StatsdistgammaView) -> Int { s.size }

pub fn stats_dist_gamma_view_get(s : StatsdistgammaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_view_set(s : StatsdistgammaView, i : Int, v : Double) -> StatsdistgammaView {
  let result = stats_dist_gamma_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_view_sum(s : StatsdistgammaView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_view_mean(s : StatsdistgammaView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_view_scale(s : StatsdistgammaView, f : Double) -> StatsdistgammaView {
  let result = stats_dist_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_view_add(a : StatsdistgammaView, b : StatsdistgammaView) -> StatsdistgammaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_view_copy(s : StatsdistgammaView) -> StatsdistgammaView {
  let result = stats_dist_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_view_fill(s : StatsdistgammaView, v : Double) -> StatsdistgammaView {
  let result = stats_dist_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_view_min(s : StatsdistgammaView) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_view_max(s : StatsdistgammaView) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_view_to_string(s : StatsdistgammaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_range_make(size : Int) -> StatsdistgammaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_range_len(s : StatsdistgammaRange) -> Int { s.size }

pub fn stats_dist_gamma_range_get(s : StatsdistgammaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_range_set(s : StatsdistgammaRange, i : Int, v : Double) -> StatsdistgammaRange {
  let result = stats_dist_gamma_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_range_sum(s : StatsdistgammaRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_range_mean(s : StatsdistgammaRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_range_scale(s : StatsdistgammaRange, f : Double) -> StatsdistgammaRange {
  let result = stats_dist_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_range_add(a : StatsdistgammaRange, b : StatsdistgammaRange) -> StatsdistgammaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_range_copy(s : StatsdistgammaRange) -> StatsdistgammaRange {
  let result = stats_dist_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_range_fill(s : StatsdistgammaRange, v : Double) -> StatsdistgammaRange {
  let result = stats_dist_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_range_min(s : StatsdistgammaRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_range_max(s : StatsdistgammaRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_range_to_string(s : StatsdistgammaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistgammaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_gamma_slice_make(size : Int) -> StatsdistgammaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_gamma_slice_len(s : StatsdistgammaSlice) -> Int { s.size }

pub fn stats_dist_gamma_slice_get(s : StatsdistgammaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_gamma_slice_set(s : StatsdistgammaSlice, i : Int, v : Double) -> StatsdistgammaSlice {
  let result = stats_dist_gamma_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_slice_sum(s : StatsdistgammaSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_gamma_slice_mean(s : StatsdistgammaSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_gamma_slice_scale(s : StatsdistgammaSlice, f : Double) -> StatsdistgammaSlice {
  let result = stats_dist_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_gamma_slice_add(a : StatsdistgammaSlice, b : StatsdistgammaSlice) -> StatsdistgammaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_gamma_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_gamma_slice_copy(s : StatsdistgammaSlice) -> StatsdistgammaSlice {
  let result = stats_dist_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_gamma_slice_fill(s : StatsdistgammaSlice, v : Double) -> StatsdistgammaSlice {
  let result = stats_dist_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_gamma_slice_min(s : StatsdistgammaSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_gamma_slice_max(s : StatsdistgammaSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_gamma_slice_to_string(s : StatsdistgammaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

