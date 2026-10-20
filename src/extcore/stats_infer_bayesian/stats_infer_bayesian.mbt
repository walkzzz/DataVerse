///===
/// extcore/stats_infer_bayesian

pub(all) struct StatsinferbayesianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_bayesian_make_point(x : Double, y : Double) -> StatsinferbayesianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_bayesian_make_point3(x : Double, y : Double, z : Double) -> StatsinferbayesianPoint {
  { x, y, z, label: 0 }
}

pub fn stats_infer_bayesian_point_x(pt : StatsinferbayesianPoint) -> Double { pt.x }

pub fn stats_infer_bayesian_point_y(pt : StatsinferbayesianPoint) -> Double { pt.y }

pub fn stats_infer_bayesian_point_z(pt : StatsinferbayesianPoint) -> Double { pt.z }

pub fn stats_infer_bayesian_point_label(pt : StatsinferbayesianPoint) -> Int { pt.label }

pub fn stats_infer_bayesian_point_dist(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_infer_bayesian_point_add(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_infer_bayesian_point_sub(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_infer_bayesian_point_scale(pt : StatsinferbayesianPoint, s : Double) -> StatsinferbayesianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_infer_bayesian_point_dot(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_infer_bayesian_point_cross(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_infer_bayesian_point_norm(pt : StatsinferbayesianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_infer_bayesian_point_normalize(pt : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  let n = stats_infer_bayesian_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_infer_bayesian_point_scale(pt, 1.0 / n) }
}

pub fn stats_infer_bayesian_point_negate(pt : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_infer_bayesian_point_mid(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint) -> StatsinferbayesianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_infer_bayesian_point_lerp(a : StatsinferbayesianPoint, b : StatsinferbayesianPoint, t : Double) -> StatsinferbayesianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_infer_bayesian_point_to_string(pt : StatsinferbayesianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsinferbayesianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_bayesian_make_series(vals : Array[Double], name : String) -> StatsinferbayesianSeries {
  { vals, name, meta: 0 }
}

pub fn stats_infer_bayesian_series_len(s : StatsinferbayesianSeries) -> Int { s.vals.length() }

pub fn stats_infer_bayesian_series_sum(s : StatsinferbayesianSeries) -> Double { @_common.sum(s.vals) }

pub fn stats_infer_bayesian_series_mean(s : StatsinferbayesianSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_infer_bayesian_series_min(s : StatsinferbayesianSeries) -> Double { @_common.min(s.vals) }

pub fn stats_infer_bayesian_series_max(s : StatsinferbayesianSeries) -> Double { @_common.max(s.vals) }

pub fn stats_infer_bayesian_series_range(s : StatsinferbayesianSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_infer_bayesian_series_var(s : StatsinferbayesianSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_infer_bayesian_series_std(s : StatsinferbayesianSeries) -> Double { @_common.std(s.vals) }

pub fn stats_infer_bayesian_series_median(s : StatsinferbayesianSeries) -> Double { @_common.median(s.vals) }

pub fn stats_infer_bayesian_series_scale(s : StatsinferbayesianSeries, f : Double) -> StatsinferbayesianSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_infer_bayesian_series_add(a : StatsinferbayesianSeries, b : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_infer_bayesian_series_sub(a : StatsinferbayesianSeries, b : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_infer_bayesian_series_normalize(s : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  let mn = stats_infer_bayesian_series_min(s)
  let mx = stats_infer_bayesian_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_infer_bayesian_series_cumsum(s : StatsinferbayesianSeries) -> StatsinferbayesianSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_infer_bayesian_series_to_string(s : StatsinferbayesianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferbayesianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_bayesian_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferbayesianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_bayesian_matrix_identity(n : Int) -> StatsinferbayesianMatrix {
  let m = stats_infer_bayesian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_infer_bayesian_matrix_get(m : StatsinferbayesianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_infer_bayesian_matrix_transpose(m : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  let result = stats_infer_bayesian_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_infer_bayesian_matrix_add(a : StatsinferbayesianMatrix, b : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_infer_bayesian_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_infer_bayesian_matrix_scale(m : StatsinferbayesianMatrix, s : Double) -> StatsinferbayesianMatrix {
  let result = stats_infer_bayesian_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_infer_bayesian_matrix_multiply(a : StatsinferbayesianMatrix, b : StatsinferbayesianMatrix) -> StatsinferbayesianMatrix {
  if a.cols != b.rows { return stats_infer_bayesian_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_infer_bayesian_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_infer_bayesian_matrix_trace(m : StatsinferbayesianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_infer_bayesian_matrix_det(m : StatsinferbayesianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_infer_bayesian_matrix_norm(m : StatsinferbayesianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_infer_bayesian_matrix_to_string(m : StatsinferbayesianMatrix) -> String {
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

pub(all) struct StatsinferbayesianVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_bayesian_make_vector(comps : Array[Double]) -> StatsinferbayesianVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_bayesian_vector_zero(dim : Int) -> StatsinferbayesianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_infer_bayesian_vector_add(a : StatsinferbayesianVector, b : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_bayesian_vector_sub(a : StatsinferbayesianVector, b : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_bayesian_vector_scale(v : StatsinferbayesianVector, s : Double) -> StatsinferbayesianVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_infer_bayesian_vector_dot(a : StatsinferbayesianVector, b : StatsinferbayesianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_infer_bayesian_vector_norm(v : StatsinferbayesianVector) -> Double { @_common.sqrt(stats_infer_bayesian_vector_dot(v, v)) }

pub fn stats_infer_bayesian_vector_normalize(v : StatsinferbayesianVector) -> StatsinferbayesianVector {
  let n = stats_infer_bayesian_vector_norm(v)
  if n < 0.0000001 { v } else { stats_infer_bayesian_vector_scale(v, 1.0 / n) }
}

pub fn stats_infer_bayesian_vector_dist(a : StatsinferbayesianVector, b : StatsinferbayesianVector) -> Double {
  stats_infer_bayesian_vector_norm(stats_infer_bayesian_vector_sub(a, b))
}

pub fn stats_infer_bayesian_vector_to_string(v : StatsinferbayesianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_bayesian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_bayesian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_bayesian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_bayesian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_bayesian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_bayesian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_bayesian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_bayesian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_bayesian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_bayesian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_bayesian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_bayesian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_bayesian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_bayesian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_bayesian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_bayesian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_bayesian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_bayesian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_bayesian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_bayesian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_bayesian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_bayesian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_bayesian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_bayesian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_bayesian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_bayesian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_bayesian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_bayesian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_bayesian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinferbayesianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_frame_make(size : Int) -> StatsinferbayesianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_frame_len(s : StatsinferbayesianFrame) -> Int { s.size }

pub fn stats_infer_bayesian_frame_get(s : StatsinferbayesianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_frame_set(s : StatsinferbayesianFrame, i : Int, v : Double) -> StatsinferbayesianFrame {
  let result = stats_infer_bayesian_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_frame_sum(s : StatsinferbayesianFrame) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_frame_mean(s : StatsinferbayesianFrame) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_frame_scale(s : StatsinferbayesianFrame, f : Double) -> StatsinferbayesianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_frame_add(a : StatsinferbayesianFrame, b : StatsinferbayesianFrame) -> StatsinferbayesianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_frame_copy(s : StatsinferbayesianFrame) -> StatsinferbayesianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_frame_fill(s : StatsinferbayesianFrame, v : Double) -> StatsinferbayesianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_frame_min(s : StatsinferbayesianFrame) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_frame_max(s : StatsinferbayesianFrame) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_frame_to_string(s : StatsinferbayesianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_table_make(size : Int) -> StatsinferbayesianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_table_len(s : StatsinferbayesianTable) -> Int { s.size }

pub fn stats_infer_bayesian_table_get(s : StatsinferbayesianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_table_set(s : StatsinferbayesianTable, i : Int, v : Double) -> StatsinferbayesianTable {
  let result = stats_infer_bayesian_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_table_sum(s : StatsinferbayesianTable) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_table_mean(s : StatsinferbayesianTable) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_table_scale(s : StatsinferbayesianTable, f : Double) -> StatsinferbayesianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_table_add(a : StatsinferbayesianTable, b : StatsinferbayesianTable) -> StatsinferbayesianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_table_copy(s : StatsinferbayesianTable) -> StatsinferbayesianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_table_fill(s : StatsinferbayesianTable, v : Double) -> StatsinferbayesianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_table_min(s : StatsinferbayesianTable) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_table_max(s : StatsinferbayesianTable) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_table_to_string(s : StatsinferbayesianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_graphn_make(size : Int) -> StatsinferbayesianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_graphn_len(s : StatsinferbayesianGraphN) -> Int { s.size }

pub fn stats_infer_bayesian_graphn_get(s : StatsinferbayesianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_graphn_set(s : StatsinferbayesianGraphN, i : Int, v : Double) -> StatsinferbayesianGraphN {
  let result = stats_infer_bayesian_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_graphn_sum(s : StatsinferbayesianGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_graphn_mean(s : StatsinferbayesianGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_graphn_scale(s : StatsinferbayesianGraphN, f : Double) -> StatsinferbayesianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_graphn_add(a : StatsinferbayesianGraphN, b : StatsinferbayesianGraphN) -> StatsinferbayesianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_graphn_copy(s : StatsinferbayesianGraphN) -> StatsinferbayesianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_graphn_fill(s : StatsinferbayesianGraphN, v : Double) -> StatsinferbayesianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_graphn_min(s : StatsinferbayesianGraphN) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_graphn_max(s : StatsinferbayesianGraphN) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_graphn_to_string(s : StatsinferbayesianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_node_make(size : Int) -> StatsinferbayesianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_node_len(s : StatsinferbayesianNode) -> Int { s.size }

pub fn stats_infer_bayesian_node_get(s : StatsinferbayesianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_node_set(s : StatsinferbayesianNode, i : Int, v : Double) -> StatsinferbayesianNode {
  let result = stats_infer_bayesian_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_node_sum(s : StatsinferbayesianNode) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_node_mean(s : StatsinferbayesianNode) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_node_scale(s : StatsinferbayesianNode, f : Double) -> StatsinferbayesianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_node_add(a : StatsinferbayesianNode, b : StatsinferbayesianNode) -> StatsinferbayesianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_node_copy(s : StatsinferbayesianNode) -> StatsinferbayesianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_node_fill(s : StatsinferbayesianNode, v : Double) -> StatsinferbayesianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_node_min(s : StatsinferbayesianNode) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_node_max(s : StatsinferbayesianNode) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_node_to_string(s : StatsinferbayesianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_edge_make(size : Int) -> StatsinferbayesianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_edge_len(s : StatsinferbayesianEdge) -> Int { s.size }

pub fn stats_infer_bayesian_edge_get(s : StatsinferbayesianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_edge_set(s : StatsinferbayesianEdge, i : Int, v : Double) -> StatsinferbayesianEdge {
  let result = stats_infer_bayesian_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_edge_sum(s : StatsinferbayesianEdge) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_edge_mean(s : StatsinferbayesianEdge) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_edge_scale(s : StatsinferbayesianEdge, f : Double) -> StatsinferbayesianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_edge_add(a : StatsinferbayesianEdge, b : StatsinferbayesianEdge) -> StatsinferbayesianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_edge_copy(s : StatsinferbayesianEdge) -> StatsinferbayesianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_edge_fill(s : StatsinferbayesianEdge, v : Double) -> StatsinferbayesianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_edge_min(s : StatsinferbayesianEdge) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_edge_max(s : StatsinferbayesianEdge) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_edge_to_string(s : StatsinferbayesianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_path_make(size : Int) -> StatsinferbayesianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_path_len(s : StatsinferbayesianPath) -> Int { s.size }

pub fn stats_infer_bayesian_path_get(s : StatsinferbayesianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_path_set(s : StatsinferbayesianPath, i : Int, v : Double) -> StatsinferbayesianPath {
  let result = stats_infer_bayesian_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_path_sum(s : StatsinferbayesianPath) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_path_mean(s : StatsinferbayesianPath) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_path_scale(s : StatsinferbayesianPath, f : Double) -> StatsinferbayesianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_path_add(a : StatsinferbayesianPath, b : StatsinferbayesianPath) -> StatsinferbayesianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_path_copy(s : StatsinferbayesianPath) -> StatsinferbayesianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_path_fill(s : StatsinferbayesianPath, v : Double) -> StatsinferbayesianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_path_min(s : StatsinferbayesianPath) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_path_max(s : StatsinferbayesianPath) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_path_to_string(s : StatsinferbayesianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_cluster_make(size : Int) -> StatsinferbayesianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_cluster_len(s : StatsinferbayesianCluster) -> Int { s.size }

pub fn stats_infer_bayesian_cluster_get(s : StatsinferbayesianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_cluster_set(s : StatsinferbayesianCluster, i : Int, v : Double) -> StatsinferbayesianCluster {
  let result = stats_infer_bayesian_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_cluster_sum(s : StatsinferbayesianCluster) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_cluster_mean(s : StatsinferbayesianCluster) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_cluster_scale(s : StatsinferbayesianCluster, f : Double) -> StatsinferbayesianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_cluster_add(a : StatsinferbayesianCluster, b : StatsinferbayesianCluster) -> StatsinferbayesianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_cluster_copy(s : StatsinferbayesianCluster) -> StatsinferbayesianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_cluster_fill(s : StatsinferbayesianCluster, v : Double) -> StatsinferbayesianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_cluster_min(s : StatsinferbayesianCluster) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_cluster_max(s : StatsinferbayesianCluster) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_cluster_to_string(s : StatsinferbayesianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_model_make(size : Int) -> StatsinferbayesianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_model_len(s : StatsinferbayesianModel) -> Int { s.size }

pub fn stats_infer_bayesian_model_get(s : StatsinferbayesianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_model_set(s : StatsinferbayesianModel, i : Int, v : Double) -> StatsinferbayesianModel {
  let result = stats_infer_bayesian_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_model_sum(s : StatsinferbayesianModel) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_model_mean(s : StatsinferbayesianModel) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_model_scale(s : StatsinferbayesianModel, f : Double) -> StatsinferbayesianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_model_add(a : StatsinferbayesianModel, b : StatsinferbayesianModel) -> StatsinferbayesianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_model_copy(s : StatsinferbayesianModel) -> StatsinferbayesianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_model_fill(s : StatsinferbayesianModel, v : Double) -> StatsinferbayesianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_model_min(s : StatsinferbayesianModel) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_model_max(s : StatsinferbayesianModel) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_model_to_string(s : StatsinferbayesianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_layer_make(size : Int) -> StatsinferbayesianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_layer_len(s : StatsinferbayesianLayer) -> Int { s.size }

pub fn stats_infer_bayesian_layer_get(s : StatsinferbayesianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_layer_set(s : StatsinferbayesianLayer, i : Int, v : Double) -> StatsinferbayesianLayer {
  let result = stats_infer_bayesian_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_layer_sum(s : StatsinferbayesianLayer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_layer_mean(s : StatsinferbayesianLayer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_layer_scale(s : StatsinferbayesianLayer, f : Double) -> StatsinferbayesianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_layer_add(a : StatsinferbayesianLayer, b : StatsinferbayesianLayer) -> StatsinferbayesianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_layer_copy(s : StatsinferbayesianLayer) -> StatsinferbayesianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_layer_fill(s : StatsinferbayesianLayer, v : Double) -> StatsinferbayesianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_layer_min(s : StatsinferbayesianLayer) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_layer_max(s : StatsinferbayesianLayer) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_layer_to_string(s : StatsinferbayesianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_buffer_make(size : Int) -> StatsinferbayesianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_buffer_len(s : StatsinferbayesianBuffer) -> Int { s.size }

pub fn stats_infer_bayesian_buffer_get(s : StatsinferbayesianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_buffer_set(s : StatsinferbayesianBuffer, i : Int, v : Double) -> StatsinferbayesianBuffer {
  let result = stats_infer_bayesian_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_buffer_sum(s : StatsinferbayesianBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_buffer_mean(s : StatsinferbayesianBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_buffer_scale(s : StatsinferbayesianBuffer, f : Double) -> StatsinferbayesianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_buffer_add(a : StatsinferbayesianBuffer, b : StatsinferbayesianBuffer) -> StatsinferbayesianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_buffer_copy(s : StatsinferbayesianBuffer) -> StatsinferbayesianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_buffer_fill(s : StatsinferbayesianBuffer, v : Double) -> StatsinferbayesianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_buffer_min(s : StatsinferbayesianBuffer) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_buffer_max(s : StatsinferbayesianBuffer) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_buffer_to_string(s : StatsinferbayesianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_cursor_make(size : Int) -> StatsinferbayesianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_cursor_len(s : StatsinferbayesianCursor) -> Int { s.size }

pub fn stats_infer_bayesian_cursor_get(s : StatsinferbayesianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_cursor_set(s : StatsinferbayesianCursor, i : Int, v : Double) -> StatsinferbayesianCursor {
  let result = stats_infer_bayesian_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_cursor_sum(s : StatsinferbayesianCursor) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_cursor_mean(s : StatsinferbayesianCursor) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_cursor_scale(s : StatsinferbayesianCursor, f : Double) -> StatsinferbayesianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_cursor_add(a : StatsinferbayesianCursor, b : StatsinferbayesianCursor) -> StatsinferbayesianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_cursor_copy(s : StatsinferbayesianCursor) -> StatsinferbayesianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_cursor_fill(s : StatsinferbayesianCursor, v : Double) -> StatsinferbayesianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_cursor_min(s : StatsinferbayesianCursor) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_cursor_max(s : StatsinferbayesianCursor) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_cursor_to_string(s : StatsinferbayesianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_view_make(size : Int) -> StatsinferbayesianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_view_len(s : StatsinferbayesianView) -> Int { s.size }

pub fn stats_infer_bayesian_view_get(s : StatsinferbayesianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_view_set(s : StatsinferbayesianView, i : Int, v : Double) -> StatsinferbayesianView {
  let result = stats_infer_bayesian_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_view_sum(s : StatsinferbayesianView) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_view_mean(s : StatsinferbayesianView) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_view_scale(s : StatsinferbayesianView, f : Double) -> StatsinferbayesianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_view_add(a : StatsinferbayesianView, b : StatsinferbayesianView) -> StatsinferbayesianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_view_copy(s : StatsinferbayesianView) -> StatsinferbayesianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_view_fill(s : StatsinferbayesianView, v : Double) -> StatsinferbayesianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_view_min(s : StatsinferbayesianView) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_view_max(s : StatsinferbayesianView) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_view_to_string(s : StatsinferbayesianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_range_make(size : Int) -> StatsinferbayesianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_range_len(s : StatsinferbayesianRange) -> Int { s.size }

pub fn stats_infer_bayesian_range_get(s : StatsinferbayesianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_range_set(s : StatsinferbayesianRange, i : Int, v : Double) -> StatsinferbayesianRange {
  let result = stats_infer_bayesian_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_range_sum(s : StatsinferbayesianRange) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_range_mean(s : StatsinferbayesianRange) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_range_scale(s : StatsinferbayesianRange, f : Double) -> StatsinferbayesianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_range_add(a : StatsinferbayesianRange, b : StatsinferbayesianRange) -> StatsinferbayesianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_range_copy(s : StatsinferbayesianRange) -> StatsinferbayesianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_range_fill(s : StatsinferbayesianRange, v : Double) -> StatsinferbayesianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_range_min(s : StatsinferbayesianRange) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_range_max(s : StatsinferbayesianRange) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_range_to_string(s : StatsinferbayesianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferbayesianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_bayesian_slice_make(size : Int) -> StatsinferbayesianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_bayesian_slice_len(s : StatsinferbayesianSlice) -> Int { s.size }

pub fn stats_infer_bayesian_slice_get(s : StatsinferbayesianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_bayesian_slice_set(s : StatsinferbayesianSlice, i : Int, v : Double) -> StatsinferbayesianSlice {
  let result = stats_infer_bayesian_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_bayesian_slice_sum(s : StatsinferbayesianSlice) -> Double { @_common.sum(s.data) }

pub fn stats_infer_bayesian_slice_mean(s : StatsinferbayesianSlice) -> Double { @_common.mean(s.data) }

pub fn stats_infer_bayesian_slice_scale(s : StatsinferbayesianSlice, f : Double) -> StatsinferbayesianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_slice_add(a : StatsinferbayesianSlice, b : StatsinferbayesianSlice) -> StatsinferbayesianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_bayesian_slice_copy(s : StatsinferbayesianSlice) -> StatsinferbayesianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_slice_fill(s : StatsinferbayesianSlice, v : Double) -> StatsinferbayesianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_bayesian_slice_min(s : StatsinferbayesianSlice) -> Double { @_common.min(s.data) }

pub fn stats_infer_bayesian_slice_max(s : StatsinferbayesianSlice) -> Double { @_common.max(s.data) }

pub fn stats_infer_bayesian_slice_to_string(s : StatsinferbayesianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

