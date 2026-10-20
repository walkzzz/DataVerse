///===
/// extcore/ml_metric_ranking

pub(all) struct MlmetricrankingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_ranking_make_point(x : Double, y : Double) -> MlmetricrankingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_ranking_make_point3(x : Double, y : Double, z : Double) -> MlmetricrankingPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_ranking_point_x(pt : MlmetricrankingPoint) -> Double { pt.x }

pub fn ml_metric_ranking_point_y(pt : MlmetricrankingPoint) -> Double { pt.y }

pub fn ml_metric_ranking_point_z(pt : MlmetricrankingPoint) -> Double { pt.z }

pub fn ml_metric_ranking_point_label(pt : MlmetricrankingPoint) -> Int { pt.label }

pub fn ml_metric_ranking_point_dist(a : MlmetricrankingPoint, b : MlmetricrankingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_ranking_point_add(a : MlmetricrankingPoint, b : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_ranking_point_sub(a : MlmetricrankingPoint, b : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_ranking_point_scale(pt : MlmetricrankingPoint, s : Double) -> MlmetricrankingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_ranking_point_dot(a : MlmetricrankingPoint, b : MlmetricrankingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_ranking_point_cross(a : MlmetricrankingPoint, b : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_ranking_point_norm(pt : MlmetricrankingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_ranking_point_normalize(pt : MlmetricrankingPoint) -> MlmetricrankingPoint {
  let n = ml_metric_ranking_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_ranking_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_ranking_point_negate(pt : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_ranking_point_mid(a : MlmetricrankingPoint, b : MlmetricrankingPoint) -> MlmetricrankingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_ranking_point_lerp(a : MlmetricrankingPoint, b : MlmetricrankingPoint, t : Double) -> MlmetricrankingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_ranking_point_to_string(pt : MlmetricrankingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricrankingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_ranking_make_series(vals : Array[Double], name : String) -> MlmetricrankingSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_ranking_series_len(s : MlmetricrankingSeries) -> Int { s.vals.length() }

pub fn ml_metric_ranking_series_sum(s : MlmetricrankingSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_metric_ranking_series_mean(s : MlmetricrankingSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_metric_ranking_series_min(s : MlmetricrankingSeries) -> Double { @_common.min(s.vals) }

pub fn ml_metric_ranking_series_max(s : MlmetricrankingSeries) -> Double { @_common.max(s.vals) }

pub fn ml_metric_ranking_series_range(s : MlmetricrankingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_metric_ranking_series_var(s : MlmetricrankingSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_metric_ranking_series_std(s : MlmetricrankingSeries) -> Double { @_common.std(s.vals) }

pub fn ml_metric_ranking_series_median(s : MlmetricrankingSeries) -> Double { @_common.median(s.vals) }

pub fn ml_metric_ranking_series_scale(s : MlmetricrankingSeries, f : Double) -> MlmetricrankingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_ranking_series_add(a : MlmetricrankingSeries, b : MlmetricrankingSeries) -> MlmetricrankingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_ranking_series_sub(a : MlmetricrankingSeries, b : MlmetricrankingSeries) -> MlmetricrankingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_ranking_series_normalize(s : MlmetricrankingSeries) -> MlmetricrankingSeries {
  let mn = ml_metric_ranking_series_min(s)
  let mx = ml_metric_ranking_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_ranking_series_cumsum(s : MlmetricrankingSeries) -> MlmetricrankingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_ranking_series_to_string(s : MlmetricrankingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricrankingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_ranking_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricrankingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_ranking_matrix_identity(n : Int) -> MlmetricrankingMatrix {
  let m = ml_metric_ranking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_ranking_matrix_get(m : MlmetricrankingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_ranking_matrix_transpose(m : MlmetricrankingMatrix) -> MlmetricrankingMatrix {
  let result = ml_metric_ranking_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_ranking_matrix_add(a : MlmetricrankingMatrix, b : MlmetricrankingMatrix) -> MlmetricrankingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_ranking_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_ranking_matrix_scale(m : MlmetricrankingMatrix, s : Double) -> MlmetricrankingMatrix {
  let result = ml_metric_ranking_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_ranking_matrix_multiply(a : MlmetricrankingMatrix, b : MlmetricrankingMatrix) -> MlmetricrankingMatrix {
  if a.cols != b.rows { return ml_metric_ranking_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_ranking_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_ranking_matrix_trace(m : MlmetricrankingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_ranking_matrix_det(m : MlmetricrankingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_ranking_matrix_norm(m : MlmetricrankingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_ranking_matrix_to_string(m : MlmetricrankingMatrix) -> String {
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

pub(all) struct MlmetricrankingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_ranking_make_vector(comps : Array[Double]) -> MlmetricrankingVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_ranking_vector_zero(dim : Int) -> MlmetricrankingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_ranking_vector_add(a : MlmetricrankingVector, b : MlmetricrankingVector) -> MlmetricrankingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_ranking_vector_sub(a : MlmetricrankingVector, b : MlmetricrankingVector) -> MlmetricrankingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_ranking_vector_scale(v : MlmetricrankingVector, s : Double) -> MlmetricrankingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_ranking_vector_dot(a : MlmetricrankingVector, b : MlmetricrankingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_ranking_vector_norm(v : MlmetricrankingVector) -> Double { @_common.sqrt(ml_metric_ranking_vector_dot(v, v)) }

pub fn ml_metric_ranking_vector_normalize(v : MlmetricrankingVector) -> MlmetricrankingVector {
  let n = ml_metric_ranking_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_ranking_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_ranking_vector_dist(a : MlmetricrankingVector, b : MlmetricrankingVector) -> Double {
  ml_metric_ranking_vector_norm(ml_metric_ranking_vector_sub(a, b))
}

pub fn ml_metric_ranking_vector_to_string(v : MlmetricrankingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_ranking_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_ranking_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_ranking_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_ranking_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_ranking_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_ranking_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_ranking_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_ranking_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_ranking_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_ranking_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_ranking_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_ranking_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_ranking_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_ranking_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_ranking_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_ranking_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_ranking_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_ranking_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_ranking_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_ranking_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_ranking_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_ranking_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_ranking_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_ranking_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_ranking_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_ranking_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_ranking_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_ranking_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_ranking_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricrankingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_frame_make(size : Int) -> MlmetricrankingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_frame_len(s : MlmetricrankingFrame) -> Int { s.size }

pub fn ml_metric_ranking_frame_get(s : MlmetricrankingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_frame_set(s : MlmetricrankingFrame, i : Int, v : Double) -> MlmetricrankingFrame {
  let result = ml_metric_ranking_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_frame_sum(s : MlmetricrankingFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_frame_mean(s : MlmetricrankingFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_frame_scale(s : MlmetricrankingFrame, f : Double) -> MlmetricrankingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_frame_add(a : MlmetricrankingFrame, b : MlmetricrankingFrame) -> MlmetricrankingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_frame_copy(s : MlmetricrankingFrame) -> MlmetricrankingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_frame_fill(s : MlmetricrankingFrame, v : Double) -> MlmetricrankingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_frame_min(s : MlmetricrankingFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_frame_max(s : MlmetricrankingFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_frame_to_string(s : MlmetricrankingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_table_make(size : Int) -> MlmetricrankingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_table_len(s : MlmetricrankingTable) -> Int { s.size }

pub fn ml_metric_ranking_table_get(s : MlmetricrankingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_table_set(s : MlmetricrankingTable, i : Int, v : Double) -> MlmetricrankingTable {
  let result = ml_metric_ranking_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_table_sum(s : MlmetricrankingTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_table_mean(s : MlmetricrankingTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_table_scale(s : MlmetricrankingTable, f : Double) -> MlmetricrankingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_table_add(a : MlmetricrankingTable, b : MlmetricrankingTable) -> MlmetricrankingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_table_copy(s : MlmetricrankingTable) -> MlmetricrankingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_table_fill(s : MlmetricrankingTable, v : Double) -> MlmetricrankingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_table_min(s : MlmetricrankingTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_table_max(s : MlmetricrankingTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_table_to_string(s : MlmetricrankingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_graphn_make(size : Int) -> MlmetricrankingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_graphn_len(s : MlmetricrankingGraphN) -> Int { s.size }

pub fn ml_metric_ranking_graphn_get(s : MlmetricrankingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_graphn_set(s : MlmetricrankingGraphN, i : Int, v : Double) -> MlmetricrankingGraphN {
  let result = ml_metric_ranking_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_graphn_sum(s : MlmetricrankingGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_graphn_mean(s : MlmetricrankingGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_graphn_scale(s : MlmetricrankingGraphN, f : Double) -> MlmetricrankingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_graphn_add(a : MlmetricrankingGraphN, b : MlmetricrankingGraphN) -> MlmetricrankingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_graphn_copy(s : MlmetricrankingGraphN) -> MlmetricrankingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_graphn_fill(s : MlmetricrankingGraphN, v : Double) -> MlmetricrankingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_graphn_min(s : MlmetricrankingGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_graphn_max(s : MlmetricrankingGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_graphn_to_string(s : MlmetricrankingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_node_make(size : Int) -> MlmetricrankingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_node_len(s : MlmetricrankingNode) -> Int { s.size }

pub fn ml_metric_ranking_node_get(s : MlmetricrankingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_node_set(s : MlmetricrankingNode, i : Int, v : Double) -> MlmetricrankingNode {
  let result = ml_metric_ranking_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_node_sum(s : MlmetricrankingNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_node_mean(s : MlmetricrankingNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_node_scale(s : MlmetricrankingNode, f : Double) -> MlmetricrankingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_node_add(a : MlmetricrankingNode, b : MlmetricrankingNode) -> MlmetricrankingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_node_copy(s : MlmetricrankingNode) -> MlmetricrankingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_node_fill(s : MlmetricrankingNode, v : Double) -> MlmetricrankingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_node_min(s : MlmetricrankingNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_node_max(s : MlmetricrankingNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_node_to_string(s : MlmetricrankingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_edge_make(size : Int) -> MlmetricrankingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_edge_len(s : MlmetricrankingEdge) -> Int { s.size }

pub fn ml_metric_ranking_edge_get(s : MlmetricrankingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_edge_set(s : MlmetricrankingEdge, i : Int, v : Double) -> MlmetricrankingEdge {
  let result = ml_metric_ranking_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_edge_sum(s : MlmetricrankingEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_edge_mean(s : MlmetricrankingEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_edge_scale(s : MlmetricrankingEdge, f : Double) -> MlmetricrankingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_edge_add(a : MlmetricrankingEdge, b : MlmetricrankingEdge) -> MlmetricrankingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_edge_copy(s : MlmetricrankingEdge) -> MlmetricrankingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_edge_fill(s : MlmetricrankingEdge, v : Double) -> MlmetricrankingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_edge_min(s : MlmetricrankingEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_edge_max(s : MlmetricrankingEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_edge_to_string(s : MlmetricrankingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_path_make(size : Int) -> MlmetricrankingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_path_len(s : MlmetricrankingPath) -> Int { s.size }

pub fn ml_metric_ranking_path_get(s : MlmetricrankingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_path_set(s : MlmetricrankingPath, i : Int, v : Double) -> MlmetricrankingPath {
  let result = ml_metric_ranking_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_path_sum(s : MlmetricrankingPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_path_mean(s : MlmetricrankingPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_path_scale(s : MlmetricrankingPath, f : Double) -> MlmetricrankingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_path_add(a : MlmetricrankingPath, b : MlmetricrankingPath) -> MlmetricrankingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_path_copy(s : MlmetricrankingPath) -> MlmetricrankingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_path_fill(s : MlmetricrankingPath, v : Double) -> MlmetricrankingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_path_min(s : MlmetricrankingPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_path_max(s : MlmetricrankingPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_path_to_string(s : MlmetricrankingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_cluster_make(size : Int) -> MlmetricrankingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_cluster_len(s : MlmetricrankingCluster) -> Int { s.size }

pub fn ml_metric_ranking_cluster_get(s : MlmetricrankingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_cluster_set(s : MlmetricrankingCluster, i : Int, v : Double) -> MlmetricrankingCluster {
  let result = ml_metric_ranking_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_cluster_sum(s : MlmetricrankingCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_cluster_mean(s : MlmetricrankingCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_cluster_scale(s : MlmetricrankingCluster, f : Double) -> MlmetricrankingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_cluster_add(a : MlmetricrankingCluster, b : MlmetricrankingCluster) -> MlmetricrankingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_cluster_copy(s : MlmetricrankingCluster) -> MlmetricrankingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_cluster_fill(s : MlmetricrankingCluster, v : Double) -> MlmetricrankingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_cluster_min(s : MlmetricrankingCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_cluster_max(s : MlmetricrankingCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_cluster_to_string(s : MlmetricrankingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_model_make(size : Int) -> MlmetricrankingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_model_len(s : MlmetricrankingModel) -> Int { s.size }

pub fn ml_metric_ranking_model_get(s : MlmetricrankingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_model_set(s : MlmetricrankingModel, i : Int, v : Double) -> MlmetricrankingModel {
  let result = ml_metric_ranking_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_model_sum(s : MlmetricrankingModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_model_mean(s : MlmetricrankingModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_model_scale(s : MlmetricrankingModel, f : Double) -> MlmetricrankingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_model_add(a : MlmetricrankingModel, b : MlmetricrankingModel) -> MlmetricrankingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_model_copy(s : MlmetricrankingModel) -> MlmetricrankingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_model_fill(s : MlmetricrankingModel, v : Double) -> MlmetricrankingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_model_min(s : MlmetricrankingModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_model_max(s : MlmetricrankingModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_model_to_string(s : MlmetricrankingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_layer_make(size : Int) -> MlmetricrankingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_layer_len(s : MlmetricrankingLayer) -> Int { s.size }

pub fn ml_metric_ranking_layer_get(s : MlmetricrankingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_layer_set(s : MlmetricrankingLayer, i : Int, v : Double) -> MlmetricrankingLayer {
  let result = ml_metric_ranking_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_layer_sum(s : MlmetricrankingLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_layer_mean(s : MlmetricrankingLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_layer_scale(s : MlmetricrankingLayer, f : Double) -> MlmetricrankingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_layer_add(a : MlmetricrankingLayer, b : MlmetricrankingLayer) -> MlmetricrankingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_layer_copy(s : MlmetricrankingLayer) -> MlmetricrankingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_layer_fill(s : MlmetricrankingLayer, v : Double) -> MlmetricrankingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_layer_min(s : MlmetricrankingLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_layer_max(s : MlmetricrankingLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_layer_to_string(s : MlmetricrankingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_buffer_make(size : Int) -> MlmetricrankingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_buffer_len(s : MlmetricrankingBuffer) -> Int { s.size }

pub fn ml_metric_ranking_buffer_get(s : MlmetricrankingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_buffer_set(s : MlmetricrankingBuffer, i : Int, v : Double) -> MlmetricrankingBuffer {
  let result = ml_metric_ranking_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_buffer_sum(s : MlmetricrankingBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_buffer_mean(s : MlmetricrankingBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_buffer_scale(s : MlmetricrankingBuffer, f : Double) -> MlmetricrankingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_buffer_add(a : MlmetricrankingBuffer, b : MlmetricrankingBuffer) -> MlmetricrankingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_buffer_copy(s : MlmetricrankingBuffer) -> MlmetricrankingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_buffer_fill(s : MlmetricrankingBuffer, v : Double) -> MlmetricrankingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_buffer_min(s : MlmetricrankingBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_buffer_max(s : MlmetricrankingBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_buffer_to_string(s : MlmetricrankingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_cursor_make(size : Int) -> MlmetricrankingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_cursor_len(s : MlmetricrankingCursor) -> Int { s.size }

pub fn ml_metric_ranking_cursor_get(s : MlmetricrankingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_cursor_set(s : MlmetricrankingCursor, i : Int, v : Double) -> MlmetricrankingCursor {
  let result = ml_metric_ranking_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_cursor_sum(s : MlmetricrankingCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_cursor_mean(s : MlmetricrankingCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_cursor_scale(s : MlmetricrankingCursor, f : Double) -> MlmetricrankingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_cursor_add(a : MlmetricrankingCursor, b : MlmetricrankingCursor) -> MlmetricrankingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_cursor_copy(s : MlmetricrankingCursor) -> MlmetricrankingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_cursor_fill(s : MlmetricrankingCursor, v : Double) -> MlmetricrankingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_cursor_min(s : MlmetricrankingCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_cursor_max(s : MlmetricrankingCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_cursor_to_string(s : MlmetricrankingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_view_make(size : Int) -> MlmetricrankingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_view_len(s : MlmetricrankingView) -> Int { s.size }

pub fn ml_metric_ranking_view_get(s : MlmetricrankingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_view_set(s : MlmetricrankingView, i : Int, v : Double) -> MlmetricrankingView {
  let result = ml_metric_ranking_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_view_sum(s : MlmetricrankingView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_view_mean(s : MlmetricrankingView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_view_scale(s : MlmetricrankingView, f : Double) -> MlmetricrankingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_view_add(a : MlmetricrankingView, b : MlmetricrankingView) -> MlmetricrankingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_view_copy(s : MlmetricrankingView) -> MlmetricrankingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_view_fill(s : MlmetricrankingView, v : Double) -> MlmetricrankingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_view_min(s : MlmetricrankingView) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_view_max(s : MlmetricrankingView) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_view_to_string(s : MlmetricrankingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_range_make(size : Int) -> MlmetricrankingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_range_len(s : MlmetricrankingRange) -> Int { s.size }

pub fn ml_metric_ranking_range_get(s : MlmetricrankingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_range_set(s : MlmetricrankingRange, i : Int, v : Double) -> MlmetricrankingRange {
  let result = ml_metric_ranking_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_range_sum(s : MlmetricrankingRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_range_mean(s : MlmetricrankingRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_range_scale(s : MlmetricrankingRange, f : Double) -> MlmetricrankingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_range_add(a : MlmetricrankingRange, b : MlmetricrankingRange) -> MlmetricrankingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_range_copy(s : MlmetricrankingRange) -> MlmetricrankingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_range_fill(s : MlmetricrankingRange, v : Double) -> MlmetricrankingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_range_min(s : MlmetricrankingRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_range_max(s : MlmetricrankingRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_range_to_string(s : MlmetricrankingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrankingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_ranking_slice_make(size : Int) -> MlmetricrankingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_ranking_slice_len(s : MlmetricrankingSlice) -> Int { s.size }

pub fn ml_metric_ranking_slice_get(s : MlmetricrankingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_ranking_slice_set(s : MlmetricrankingSlice, i : Int, v : Double) -> MlmetricrankingSlice {
  let result = ml_metric_ranking_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_ranking_slice_sum(s : MlmetricrankingSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_ranking_slice_mean(s : MlmetricrankingSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_ranking_slice_scale(s : MlmetricrankingSlice, f : Double) -> MlmetricrankingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_slice_add(a : MlmetricrankingSlice, b : MlmetricrankingSlice) -> MlmetricrankingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_ranking_slice_copy(s : MlmetricrankingSlice) -> MlmetricrankingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_slice_fill(s : MlmetricrankingSlice, v : Double) -> MlmetricrankingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_ranking_slice_min(s : MlmetricrankingSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_ranking_slice_max(s : MlmetricrankingSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_ranking_slice_to_string(s : MlmetricrankingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

