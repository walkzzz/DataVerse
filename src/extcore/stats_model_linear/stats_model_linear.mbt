///===
/// extcore/stats_model_linear

pub(all) struct StatsmodellinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_linear_make_point(x : Double, y : Double) -> StatsmodellinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_linear_make_point3(x : Double, y : Double, z : Double) -> StatsmodellinearPoint {
  { x, y, z, label: 0 }
}

pub fn stats_model_linear_point_x(pt : StatsmodellinearPoint) -> Double { pt.x }

pub fn stats_model_linear_point_y(pt : StatsmodellinearPoint) -> Double { pt.y }

pub fn stats_model_linear_point_z(pt : StatsmodellinearPoint) -> Double { pt.z }

pub fn stats_model_linear_point_label(pt : StatsmodellinearPoint) -> Int { pt.label }

pub fn stats_model_linear_point_dist(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_model_linear_point_add(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_model_linear_point_sub(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_model_linear_point_scale(pt : StatsmodellinearPoint, s : Double) -> StatsmodellinearPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_model_linear_point_dot(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_model_linear_point_cross(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_model_linear_point_norm(pt : StatsmodellinearPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_model_linear_point_normalize(pt : StatsmodellinearPoint) -> StatsmodellinearPoint {
  let n = stats_model_linear_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_model_linear_point_scale(pt, 1.0 / n) }
}

pub fn stats_model_linear_point_negate(pt : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_model_linear_point_mid(a : StatsmodellinearPoint, b : StatsmodellinearPoint) -> StatsmodellinearPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_model_linear_point_lerp(a : StatsmodellinearPoint, b : StatsmodellinearPoint, t : Double) -> StatsmodellinearPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_model_linear_point_to_string(pt : StatsmodellinearPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsmodellinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_linear_make_series(vals : Array[Double], name : String) -> StatsmodellinearSeries {
  { vals, name, meta: 0 }
}

pub fn stats_model_linear_series_len(s : StatsmodellinearSeries) -> Int { s.vals.length() }

pub fn stats_model_linear_series_sum(s : StatsmodellinearSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_model_linear_series_mean(s : StatsmodellinearSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_model_linear_series_min(s : StatsmodellinearSeries) -> Double { @_common.min(s.vals) }

pub fn stats_model_linear_series_max(s : StatsmodellinearSeries) -> Double { @_common.max(s.vals) }

pub fn stats_model_linear_series_range(s : StatsmodellinearSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_model_linear_series_var(s : StatsmodellinearSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_model_linear_series_std(s : StatsmodellinearSeries) -> Double { @_common.std(s.vals) }

pub fn stats_model_linear_series_median(s : StatsmodellinearSeries) -> Double { @_common.median(s.vals) }

pub fn stats_model_linear_series_scale(s : StatsmodellinearSeries, f : Double) -> StatsmodellinearSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_model_linear_series_add(a : StatsmodellinearSeries, b : StatsmodellinearSeries) -> StatsmodellinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_model_linear_series_sub(a : StatsmodellinearSeries, b : StatsmodellinearSeries) -> StatsmodellinearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_model_linear_series_normalize(s : StatsmodellinearSeries) -> StatsmodellinearSeries {
  let mn = stats_model_linear_series_min(s)
  let mx = stats_model_linear_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_model_linear_series_cumsum(s : StatsmodellinearSeries) -> StatsmodellinearSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_model_linear_series_to_string(s : StatsmodellinearSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodellinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_linear_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodellinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_linear_matrix_identity(n : Int) -> StatsmodellinearMatrix {
  let m = stats_model_linear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_model_linear_matrix_get(m : StatsmodellinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_model_linear_matrix_transpose(m : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  let result = stats_model_linear_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_model_linear_matrix_add(a : StatsmodellinearMatrix, b : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_model_linear_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_model_linear_matrix_scale(m : StatsmodellinearMatrix, s : Double) -> StatsmodellinearMatrix {
  let result = stats_model_linear_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_model_linear_matrix_multiply(a : StatsmodellinearMatrix, b : StatsmodellinearMatrix) -> StatsmodellinearMatrix {
  if a.cols != b.rows { return stats_model_linear_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_model_linear_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_model_linear_matrix_trace(m : StatsmodellinearMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_model_linear_matrix_det(m : StatsmodellinearMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_model_linear_matrix_norm(m : StatsmodellinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_model_linear_matrix_to_string(m : StatsmodellinearMatrix) -> String {
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

pub(all) struct StatsmodellinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_linear_make_vector(comps : Array[Double]) -> StatsmodellinearVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_linear_vector_zero(dim : Int) -> StatsmodellinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_model_linear_vector_add(a : StatsmodellinearVector, b : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_linear_vector_sub(a : StatsmodellinearVector, b : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_linear_vector_scale(v : StatsmodellinearVector, s : Double) -> StatsmodellinearVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_model_linear_vector_dot(a : StatsmodellinearVector, b : StatsmodellinearVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_model_linear_vector_norm(v : StatsmodellinearVector) -> Double { @_common.sqrt(stats_model_linear_vector_dot(v, v)) }

pub fn stats_model_linear_vector_normalize(v : StatsmodellinearVector) -> StatsmodellinearVector {
  let n = stats_model_linear_vector_norm(v)
  if n < 0.0000001 { v } else { stats_model_linear_vector_scale(v, 1.0 / n) }
}

pub fn stats_model_linear_vector_dist(a : StatsmodellinearVector, b : StatsmodellinearVector) -> Double {
  stats_model_linear_vector_norm(stats_model_linear_vector_sub(a, b))
}

pub fn stats_model_linear_vector_to_string(v : StatsmodellinearVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_linear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_model_linear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_model_linear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_model_linear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_model_linear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_model_linear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_model_linear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_model_linear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_model_linear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_model_linear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_model_linear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_model_linear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_model_linear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_model_linear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_model_linear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_model_linear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_model_linear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_model_linear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_model_linear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_model_linear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_model_linear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_model_linear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_model_linear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_model_linear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_model_linear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_model_linear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_model_linear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_model_linear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_model_linear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsmodellinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_frame_make(size : Int) -> StatsmodellinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_frame_len(s : StatsmodellinearFrame) -> Int { s.size }

pub fn stats_model_linear_frame_get(s : StatsmodellinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_frame_set(s : StatsmodellinearFrame, i : Int, v : Double) -> StatsmodellinearFrame {
  let result = stats_model_linear_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_frame_sum(s : StatsmodellinearFrame) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_frame_mean(s : StatsmodellinearFrame) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_frame_scale(s : StatsmodellinearFrame, f : Double) -> StatsmodellinearFrame {
  let result = stats_model_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_frame_add(a : StatsmodellinearFrame, b : StatsmodellinearFrame) -> StatsmodellinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_frame_copy(s : StatsmodellinearFrame) -> StatsmodellinearFrame {
  let result = stats_model_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_frame_fill(s : StatsmodellinearFrame, v : Double) -> StatsmodellinearFrame {
  let result = stats_model_linear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_frame_min(s : StatsmodellinearFrame) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_frame_max(s : StatsmodellinearFrame) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_frame_to_string(s : StatsmodellinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_table_make(size : Int) -> StatsmodellinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_table_len(s : StatsmodellinearTable) -> Int { s.size }

pub fn stats_model_linear_table_get(s : StatsmodellinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_table_set(s : StatsmodellinearTable, i : Int, v : Double) -> StatsmodellinearTable {
  let result = stats_model_linear_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_table_sum(s : StatsmodellinearTable) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_table_mean(s : StatsmodellinearTable) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_table_scale(s : StatsmodellinearTable, f : Double) -> StatsmodellinearTable {
  let result = stats_model_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_table_add(a : StatsmodellinearTable, b : StatsmodellinearTable) -> StatsmodellinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_table_copy(s : StatsmodellinearTable) -> StatsmodellinearTable {
  let result = stats_model_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_table_fill(s : StatsmodellinearTable, v : Double) -> StatsmodellinearTable {
  let result = stats_model_linear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_table_min(s : StatsmodellinearTable) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_table_max(s : StatsmodellinearTable) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_table_to_string(s : StatsmodellinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_graphn_make(size : Int) -> StatsmodellinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_graphn_len(s : StatsmodellinearGraphN) -> Int { s.size }

pub fn stats_model_linear_graphn_get(s : StatsmodellinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_graphn_set(s : StatsmodellinearGraphN, i : Int, v : Double) -> StatsmodellinearGraphN {
  let result = stats_model_linear_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_graphn_sum(s : StatsmodellinearGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_graphn_mean(s : StatsmodellinearGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_graphn_scale(s : StatsmodellinearGraphN, f : Double) -> StatsmodellinearGraphN {
  let result = stats_model_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_graphn_add(a : StatsmodellinearGraphN, b : StatsmodellinearGraphN) -> StatsmodellinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_graphn_copy(s : StatsmodellinearGraphN) -> StatsmodellinearGraphN {
  let result = stats_model_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_graphn_fill(s : StatsmodellinearGraphN, v : Double) -> StatsmodellinearGraphN {
  let result = stats_model_linear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_graphn_min(s : StatsmodellinearGraphN) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_graphn_max(s : StatsmodellinearGraphN) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_graphn_to_string(s : StatsmodellinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_node_make(size : Int) -> StatsmodellinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_node_len(s : StatsmodellinearNode) -> Int { s.size }

pub fn stats_model_linear_node_get(s : StatsmodellinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_node_set(s : StatsmodellinearNode, i : Int, v : Double) -> StatsmodellinearNode {
  let result = stats_model_linear_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_node_sum(s : StatsmodellinearNode) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_node_mean(s : StatsmodellinearNode) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_node_scale(s : StatsmodellinearNode, f : Double) -> StatsmodellinearNode {
  let result = stats_model_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_node_add(a : StatsmodellinearNode, b : StatsmodellinearNode) -> StatsmodellinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_node_copy(s : StatsmodellinearNode) -> StatsmodellinearNode {
  let result = stats_model_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_node_fill(s : StatsmodellinearNode, v : Double) -> StatsmodellinearNode {
  let result = stats_model_linear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_node_min(s : StatsmodellinearNode) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_node_max(s : StatsmodellinearNode) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_node_to_string(s : StatsmodellinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_edge_make(size : Int) -> StatsmodellinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_edge_len(s : StatsmodellinearEdge) -> Int { s.size }

pub fn stats_model_linear_edge_get(s : StatsmodellinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_edge_set(s : StatsmodellinearEdge, i : Int, v : Double) -> StatsmodellinearEdge {
  let result = stats_model_linear_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_edge_sum(s : StatsmodellinearEdge) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_edge_mean(s : StatsmodellinearEdge) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_edge_scale(s : StatsmodellinearEdge, f : Double) -> StatsmodellinearEdge {
  let result = stats_model_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_edge_add(a : StatsmodellinearEdge, b : StatsmodellinearEdge) -> StatsmodellinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_edge_copy(s : StatsmodellinearEdge) -> StatsmodellinearEdge {
  let result = stats_model_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_edge_fill(s : StatsmodellinearEdge, v : Double) -> StatsmodellinearEdge {
  let result = stats_model_linear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_edge_min(s : StatsmodellinearEdge) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_edge_max(s : StatsmodellinearEdge) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_edge_to_string(s : StatsmodellinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_path_make(size : Int) -> StatsmodellinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_path_len(s : StatsmodellinearPath) -> Int { s.size }

pub fn stats_model_linear_path_get(s : StatsmodellinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_path_set(s : StatsmodellinearPath, i : Int, v : Double) -> StatsmodellinearPath {
  let result = stats_model_linear_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_path_sum(s : StatsmodellinearPath) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_path_mean(s : StatsmodellinearPath) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_path_scale(s : StatsmodellinearPath, f : Double) -> StatsmodellinearPath {
  let result = stats_model_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_path_add(a : StatsmodellinearPath, b : StatsmodellinearPath) -> StatsmodellinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_path_copy(s : StatsmodellinearPath) -> StatsmodellinearPath {
  let result = stats_model_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_path_fill(s : StatsmodellinearPath, v : Double) -> StatsmodellinearPath {
  let result = stats_model_linear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_path_min(s : StatsmodellinearPath) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_path_max(s : StatsmodellinearPath) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_path_to_string(s : StatsmodellinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_cluster_make(size : Int) -> StatsmodellinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_cluster_len(s : StatsmodellinearCluster) -> Int { s.size }

pub fn stats_model_linear_cluster_get(s : StatsmodellinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_cluster_set(s : StatsmodellinearCluster, i : Int, v : Double) -> StatsmodellinearCluster {
  let result = stats_model_linear_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_cluster_sum(s : StatsmodellinearCluster) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_cluster_mean(s : StatsmodellinearCluster) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_cluster_scale(s : StatsmodellinearCluster, f : Double) -> StatsmodellinearCluster {
  let result = stats_model_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_cluster_add(a : StatsmodellinearCluster, b : StatsmodellinearCluster) -> StatsmodellinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_cluster_copy(s : StatsmodellinearCluster) -> StatsmodellinearCluster {
  let result = stats_model_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_cluster_fill(s : StatsmodellinearCluster, v : Double) -> StatsmodellinearCluster {
  let result = stats_model_linear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_cluster_min(s : StatsmodellinearCluster) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_cluster_max(s : StatsmodellinearCluster) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_cluster_to_string(s : StatsmodellinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_model_make(size : Int) -> StatsmodellinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_model_len(s : StatsmodellinearModel) -> Int { s.size }

pub fn stats_model_linear_model_get(s : StatsmodellinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_model_set(s : StatsmodellinearModel, i : Int, v : Double) -> StatsmodellinearModel {
  let result = stats_model_linear_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_model_sum(s : StatsmodellinearModel) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_model_mean(s : StatsmodellinearModel) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_model_scale(s : StatsmodellinearModel, f : Double) -> StatsmodellinearModel {
  let result = stats_model_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_model_add(a : StatsmodellinearModel, b : StatsmodellinearModel) -> StatsmodellinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_model_copy(s : StatsmodellinearModel) -> StatsmodellinearModel {
  let result = stats_model_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_model_fill(s : StatsmodellinearModel, v : Double) -> StatsmodellinearModel {
  let result = stats_model_linear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_model_min(s : StatsmodellinearModel) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_model_max(s : StatsmodellinearModel) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_model_to_string(s : StatsmodellinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_layer_make(size : Int) -> StatsmodellinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_layer_len(s : StatsmodellinearLayer) -> Int { s.size }

pub fn stats_model_linear_layer_get(s : StatsmodellinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_layer_set(s : StatsmodellinearLayer, i : Int, v : Double) -> StatsmodellinearLayer {
  let result = stats_model_linear_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_layer_sum(s : StatsmodellinearLayer) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_layer_mean(s : StatsmodellinearLayer) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_layer_scale(s : StatsmodellinearLayer, f : Double) -> StatsmodellinearLayer {
  let result = stats_model_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_layer_add(a : StatsmodellinearLayer, b : StatsmodellinearLayer) -> StatsmodellinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_layer_copy(s : StatsmodellinearLayer) -> StatsmodellinearLayer {
  let result = stats_model_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_layer_fill(s : StatsmodellinearLayer, v : Double) -> StatsmodellinearLayer {
  let result = stats_model_linear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_layer_min(s : StatsmodellinearLayer) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_layer_max(s : StatsmodellinearLayer) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_layer_to_string(s : StatsmodellinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_buffer_make(size : Int) -> StatsmodellinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_buffer_len(s : StatsmodellinearBuffer) -> Int { s.size }

pub fn stats_model_linear_buffer_get(s : StatsmodellinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_buffer_set(s : StatsmodellinearBuffer, i : Int, v : Double) -> StatsmodellinearBuffer {
  let result = stats_model_linear_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_buffer_sum(s : StatsmodellinearBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_buffer_mean(s : StatsmodellinearBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_buffer_scale(s : StatsmodellinearBuffer, f : Double) -> StatsmodellinearBuffer {
  let result = stats_model_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_buffer_add(a : StatsmodellinearBuffer, b : StatsmodellinearBuffer) -> StatsmodellinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_buffer_copy(s : StatsmodellinearBuffer) -> StatsmodellinearBuffer {
  let result = stats_model_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_buffer_fill(s : StatsmodellinearBuffer, v : Double) -> StatsmodellinearBuffer {
  let result = stats_model_linear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_buffer_min(s : StatsmodellinearBuffer) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_buffer_max(s : StatsmodellinearBuffer) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_buffer_to_string(s : StatsmodellinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_cursor_make(size : Int) -> StatsmodellinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_cursor_len(s : StatsmodellinearCursor) -> Int { s.size }

pub fn stats_model_linear_cursor_get(s : StatsmodellinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_cursor_set(s : StatsmodellinearCursor, i : Int, v : Double) -> StatsmodellinearCursor {
  let result = stats_model_linear_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_cursor_sum(s : StatsmodellinearCursor) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_cursor_mean(s : StatsmodellinearCursor) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_cursor_scale(s : StatsmodellinearCursor, f : Double) -> StatsmodellinearCursor {
  let result = stats_model_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_cursor_add(a : StatsmodellinearCursor, b : StatsmodellinearCursor) -> StatsmodellinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_cursor_copy(s : StatsmodellinearCursor) -> StatsmodellinearCursor {
  let result = stats_model_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_cursor_fill(s : StatsmodellinearCursor, v : Double) -> StatsmodellinearCursor {
  let result = stats_model_linear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_cursor_min(s : StatsmodellinearCursor) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_cursor_max(s : StatsmodellinearCursor) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_cursor_to_string(s : StatsmodellinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_view_make(size : Int) -> StatsmodellinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_view_len(s : StatsmodellinearView) -> Int { s.size }

pub fn stats_model_linear_view_get(s : StatsmodellinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_view_set(s : StatsmodellinearView, i : Int, v : Double) -> StatsmodellinearView {
  let result = stats_model_linear_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_view_sum(s : StatsmodellinearView) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_view_mean(s : StatsmodellinearView) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_view_scale(s : StatsmodellinearView, f : Double) -> StatsmodellinearView {
  let result = stats_model_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_view_add(a : StatsmodellinearView, b : StatsmodellinearView) -> StatsmodellinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_view_copy(s : StatsmodellinearView) -> StatsmodellinearView {
  let result = stats_model_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_view_fill(s : StatsmodellinearView, v : Double) -> StatsmodellinearView {
  let result = stats_model_linear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_view_min(s : StatsmodellinearView) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_view_max(s : StatsmodellinearView) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_view_to_string(s : StatsmodellinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_range_make(size : Int) -> StatsmodellinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_range_len(s : StatsmodellinearRange) -> Int { s.size }

pub fn stats_model_linear_range_get(s : StatsmodellinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_range_set(s : StatsmodellinearRange, i : Int, v : Double) -> StatsmodellinearRange {
  let result = stats_model_linear_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_range_sum(s : StatsmodellinearRange) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_range_mean(s : StatsmodellinearRange) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_range_scale(s : StatsmodellinearRange, f : Double) -> StatsmodellinearRange {
  let result = stats_model_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_range_add(a : StatsmodellinearRange, b : StatsmodellinearRange) -> StatsmodellinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_range_copy(s : StatsmodellinearRange) -> StatsmodellinearRange {
  let result = stats_model_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_range_fill(s : StatsmodellinearRange, v : Double) -> StatsmodellinearRange {
  let result = stats_model_linear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_range_min(s : StatsmodellinearRange) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_range_max(s : StatsmodellinearRange) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_range_to_string(s : StatsmodellinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodellinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_linear_slice_make(size : Int) -> StatsmodellinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_linear_slice_len(s : StatsmodellinearSlice) -> Int { s.size }

pub fn stats_model_linear_slice_get(s : StatsmodellinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_linear_slice_set(s : StatsmodellinearSlice, i : Int, v : Double) -> StatsmodellinearSlice {
  let result = stats_model_linear_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_slice_sum(s : StatsmodellinearSlice) -> Double { @_common.sum(s.data) }

pub fn stats_model_linear_slice_mean(s : StatsmodellinearSlice) -> Double { @_common.mean(s.data) }

pub fn stats_model_linear_slice_scale(s : StatsmodellinearSlice, f : Double) -> StatsmodellinearSlice {
  let result = stats_model_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_linear_slice_add(a : StatsmodellinearSlice, b : StatsmodellinearSlice) -> StatsmodellinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_linear_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_linear_slice_copy(s : StatsmodellinearSlice) -> StatsmodellinearSlice {
  let result = stats_model_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_linear_slice_fill(s : StatsmodellinearSlice, v : Double) -> StatsmodellinearSlice {
  let result = stats_model_linear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_linear_slice_min(s : StatsmodellinearSlice) -> Double { @_common.min(s.data) }

pub fn stats_model_linear_slice_max(s : StatsmodellinearSlice) -> Double { @_common.max(s.data) }

pub fn stats_model_linear_slice_to_string(s : StatsmodellinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

