///===
/// extcore/sort_exchange_j

pub(all) struct SortexchangejPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_j_make_point(x : Double, y : Double) -> SortexchangejPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_j_make_point3(x : Double, y : Double, z : Double) -> SortexchangejPoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_j_point_x(pt : SortexchangejPoint) -> Double { pt.x }

pub fn sort_exchange_j_point_y(pt : SortexchangejPoint) -> Double { pt.y }

pub fn sort_exchange_j_point_z(pt : SortexchangejPoint) -> Double { pt.z }

pub fn sort_exchange_j_point_label(pt : SortexchangejPoint) -> Int { pt.label }

pub fn sort_exchange_j_point_dist(a : SortexchangejPoint, b : SortexchangejPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_j_point_add(a : SortexchangejPoint, b : SortexchangejPoint) -> SortexchangejPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_j_point_sub(a : SortexchangejPoint, b : SortexchangejPoint) -> SortexchangejPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_j_point_scale(pt : SortexchangejPoint, s : Double) -> SortexchangejPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_j_point_dot(a : SortexchangejPoint, b : SortexchangejPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_j_point_cross(a : SortexchangejPoint, b : SortexchangejPoint) -> SortexchangejPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_j_point_norm(pt : SortexchangejPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_j_point_normalize(pt : SortexchangejPoint) -> SortexchangejPoint {
  let n = sort_exchange_j_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_j_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_j_point_negate(pt : SortexchangejPoint) -> SortexchangejPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_j_point_mid(a : SortexchangejPoint, b : SortexchangejPoint) -> SortexchangejPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_j_point_lerp(a : SortexchangejPoint, b : SortexchangejPoint, t : Double) -> SortexchangejPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_j_point_to_string(pt : SortexchangejPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangejSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_j_make_series(vals : Array[Double], name : String) -> SortexchangejSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_j_series_len(s : SortexchangejSeries) -> Int { s.vals.length() }

pub fn sort_exchange_j_series_sum(s : SortexchangejSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_exchange_j_series_mean(s : SortexchangejSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_exchange_j_series_min(s : SortexchangejSeries) -> Double { @_common.min(s.vals) }

pub fn sort_exchange_j_series_max(s : SortexchangejSeries) -> Double { @_common.max(s.vals) }

pub fn sort_exchange_j_series_range(s : SortexchangejSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_exchange_j_series_var(s : SortexchangejSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_exchange_j_series_std(s : SortexchangejSeries) -> Double { @_common.std(s.vals) }

pub fn sort_exchange_j_series_median(s : SortexchangejSeries) -> Double { @_common.median(s.vals) }

pub fn sort_exchange_j_series_scale(s : SortexchangejSeries, f : Double) -> SortexchangejSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_j_series_add(a : SortexchangejSeries, b : SortexchangejSeries) -> SortexchangejSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_j_series_sub(a : SortexchangejSeries, b : SortexchangejSeries) -> SortexchangejSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_j_series_normalize(s : SortexchangejSeries) -> SortexchangejSeries {
  let mn = sort_exchange_j_series_min(s)
  let mx = sort_exchange_j_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_j_series_cumsum(s : SortexchangejSeries) -> SortexchangejSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_j_series_to_string(s : SortexchangejSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangejMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_j_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangejMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_j_matrix_identity(n : Int) -> SortexchangejMatrix {
  let m = sort_exchange_j_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_j_matrix_get(m : SortexchangejMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_j_matrix_transpose(m : SortexchangejMatrix) -> SortexchangejMatrix {
  let result = sort_exchange_j_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_j_matrix_add(a : SortexchangejMatrix, b : SortexchangejMatrix) -> SortexchangejMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_j_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_j_matrix_scale(m : SortexchangejMatrix, s : Double) -> SortexchangejMatrix {
  let result = sort_exchange_j_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_j_matrix_multiply(a : SortexchangejMatrix, b : SortexchangejMatrix) -> SortexchangejMatrix {
  if a.cols != b.rows { return sort_exchange_j_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_j_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_j_matrix_trace(m : SortexchangejMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_j_matrix_det(m : SortexchangejMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_j_matrix_norm(m : SortexchangejMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_j_matrix_to_string(m : SortexchangejMatrix) -> String {
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

pub(all) struct SortexchangejVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_j_make_vector(comps : Array[Double]) -> SortexchangejVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_j_vector_zero(dim : Int) -> SortexchangejVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_j_vector_add(a : SortexchangejVector, b : SortexchangejVector) -> SortexchangejVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_j_vector_sub(a : SortexchangejVector, b : SortexchangejVector) -> SortexchangejVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_j_vector_scale(v : SortexchangejVector, s : Double) -> SortexchangejVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_j_vector_dot(a : SortexchangejVector, b : SortexchangejVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_j_vector_norm(v : SortexchangejVector) -> Double { @_common.sqrt(sort_exchange_j_vector_dot(v, v)) }

pub fn sort_exchange_j_vector_normalize(v : SortexchangejVector) -> SortexchangejVector {
  let n = sort_exchange_j_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_j_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_j_vector_dist(a : SortexchangejVector, b : SortexchangejVector) -> Double {
  sort_exchange_j_vector_norm(sort_exchange_j_vector_sub(a, b))
}

pub fn sort_exchange_j_vector_to_string(v : SortexchangejVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_j_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_j_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_j_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_j_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_j_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_j_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_j_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_j_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_j_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_j_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_j_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_j_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_j_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_j_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_j_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_j_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_j_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_j_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_j_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_j_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_j_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_j_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_j_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_j_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_j_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_j_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_j_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_j_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_j_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangejFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_frame_make(size : Int) -> SortexchangejFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_frame_len(s : SortexchangejFrame) -> Int { s.size }

pub fn sort_exchange_j_frame_get(s : SortexchangejFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_frame_set(s : SortexchangejFrame, i : Int, v : Double) -> SortexchangejFrame {
  let result = sort_exchange_j_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_frame_sum(s : SortexchangejFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_frame_mean(s : SortexchangejFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_frame_scale(s : SortexchangejFrame, f : Double) -> SortexchangejFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_frame_add(a : SortexchangejFrame, b : SortexchangejFrame) -> SortexchangejFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_frame_copy(s : SortexchangejFrame) -> SortexchangejFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_frame_fill(s : SortexchangejFrame, v : Double) -> SortexchangejFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_frame_min(s : SortexchangejFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_frame_max(s : SortexchangejFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_frame_to_string(s : SortexchangejFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_table_make(size : Int) -> SortexchangejTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_table_len(s : SortexchangejTable) -> Int { s.size }

pub fn sort_exchange_j_table_get(s : SortexchangejTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_table_set(s : SortexchangejTable, i : Int, v : Double) -> SortexchangejTable {
  let result = sort_exchange_j_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_table_sum(s : SortexchangejTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_table_mean(s : SortexchangejTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_table_scale(s : SortexchangejTable, f : Double) -> SortexchangejTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_table_add(a : SortexchangejTable, b : SortexchangejTable) -> SortexchangejTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_table_copy(s : SortexchangejTable) -> SortexchangejTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_table_fill(s : SortexchangejTable, v : Double) -> SortexchangejTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_table_min(s : SortexchangejTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_table_max(s : SortexchangejTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_table_to_string(s : SortexchangejTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_graphn_make(size : Int) -> SortexchangejGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_graphn_len(s : SortexchangejGraphN) -> Int { s.size }

pub fn sort_exchange_j_graphn_get(s : SortexchangejGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_graphn_set(s : SortexchangejGraphN, i : Int, v : Double) -> SortexchangejGraphN {
  let result = sort_exchange_j_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_graphn_sum(s : SortexchangejGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_graphn_mean(s : SortexchangejGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_graphn_scale(s : SortexchangejGraphN, f : Double) -> SortexchangejGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_graphn_add(a : SortexchangejGraphN, b : SortexchangejGraphN) -> SortexchangejGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_graphn_copy(s : SortexchangejGraphN) -> SortexchangejGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_graphn_fill(s : SortexchangejGraphN, v : Double) -> SortexchangejGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_graphn_min(s : SortexchangejGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_graphn_max(s : SortexchangejGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_graphn_to_string(s : SortexchangejGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_node_make(size : Int) -> SortexchangejNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_node_len(s : SortexchangejNode) -> Int { s.size }

pub fn sort_exchange_j_node_get(s : SortexchangejNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_node_set(s : SortexchangejNode, i : Int, v : Double) -> SortexchangejNode {
  let result = sort_exchange_j_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_node_sum(s : SortexchangejNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_node_mean(s : SortexchangejNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_node_scale(s : SortexchangejNode, f : Double) -> SortexchangejNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_node_add(a : SortexchangejNode, b : SortexchangejNode) -> SortexchangejNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_node_copy(s : SortexchangejNode) -> SortexchangejNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_node_fill(s : SortexchangejNode, v : Double) -> SortexchangejNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_node_min(s : SortexchangejNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_node_max(s : SortexchangejNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_node_to_string(s : SortexchangejNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_edge_make(size : Int) -> SortexchangejEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_edge_len(s : SortexchangejEdge) -> Int { s.size }

pub fn sort_exchange_j_edge_get(s : SortexchangejEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_edge_set(s : SortexchangejEdge, i : Int, v : Double) -> SortexchangejEdge {
  let result = sort_exchange_j_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_edge_sum(s : SortexchangejEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_edge_mean(s : SortexchangejEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_edge_scale(s : SortexchangejEdge, f : Double) -> SortexchangejEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_edge_add(a : SortexchangejEdge, b : SortexchangejEdge) -> SortexchangejEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_edge_copy(s : SortexchangejEdge) -> SortexchangejEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_edge_fill(s : SortexchangejEdge, v : Double) -> SortexchangejEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_edge_min(s : SortexchangejEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_edge_max(s : SortexchangejEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_edge_to_string(s : SortexchangejEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_path_make(size : Int) -> SortexchangejPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_path_len(s : SortexchangejPath) -> Int { s.size }

pub fn sort_exchange_j_path_get(s : SortexchangejPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_path_set(s : SortexchangejPath, i : Int, v : Double) -> SortexchangejPath {
  let result = sort_exchange_j_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_path_sum(s : SortexchangejPath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_path_mean(s : SortexchangejPath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_path_scale(s : SortexchangejPath, f : Double) -> SortexchangejPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_path_add(a : SortexchangejPath, b : SortexchangejPath) -> SortexchangejPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_path_copy(s : SortexchangejPath) -> SortexchangejPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_path_fill(s : SortexchangejPath, v : Double) -> SortexchangejPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_path_min(s : SortexchangejPath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_path_max(s : SortexchangejPath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_path_to_string(s : SortexchangejPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_cluster_make(size : Int) -> SortexchangejCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_cluster_len(s : SortexchangejCluster) -> Int { s.size }

pub fn sort_exchange_j_cluster_get(s : SortexchangejCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_cluster_set(s : SortexchangejCluster, i : Int, v : Double) -> SortexchangejCluster {
  let result = sort_exchange_j_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_cluster_sum(s : SortexchangejCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_cluster_mean(s : SortexchangejCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_cluster_scale(s : SortexchangejCluster, f : Double) -> SortexchangejCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_cluster_add(a : SortexchangejCluster, b : SortexchangejCluster) -> SortexchangejCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_cluster_copy(s : SortexchangejCluster) -> SortexchangejCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_cluster_fill(s : SortexchangejCluster, v : Double) -> SortexchangejCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_cluster_min(s : SortexchangejCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_cluster_max(s : SortexchangejCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_cluster_to_string(s : SortexchangejCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_model_make(size : Int) -> SortexchangejModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_model_len(s : SortexchangejModel) -> Int { s.size }

pub fn sort_exchange_j_model_get(s : SortexchangejModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_model_set(s : SortexchangejModel, i : Int, v : Double) -> SortexchangejModel {
  let result = sort_exchange_j_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_model_sum(s : SortexchangejModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_model_mean(s : SortexchangejModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_model_scale(s : SortexchangejModel, f : Double) -> SortexchangejModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_model_add(a : SortexchangejModel, b : SortexchangejModel) -> SortexchangejModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_model_copy(s : SortexchangejModel) -> SortexchangejModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_model_fill(s : SortexchangejModel, v : Double) -> SortexchangejModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_model_min(s : SortexchangejModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_model_max(s : SortexchangejModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_model_to_string(s : SortexchangejModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_layer_make(size : Int) -> SortexchangejLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_layer_len(s : SortexchangejLayer) -> Int { s.size }

pub fn sort_exchange_j_layer_get(s : SortexchangejLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_layer_set(s : SortexchangejLayer, i : Int, v : Double) -> SortexchangejLayer {
  let result = sort_exchange_j_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_layer_sum(s : SortexchangejLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_layer_mean(s : SortexchangejLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_layer_scale(s : SortexchangejLayer, f : Double) -> SortexchangejLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_layer_add(a : SortexchangejLayer, b : SortexchangejLayer) -> SortexchangejLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_layer_copy(s : SortexchangejLayer) -> SortexchangejLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_layer_fill(s : SortexchangejLayer, v : Double) -> SortexchangejLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_layer_min(s : SortexchangejLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_layer_max(s : SortexchangejLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_layer_to_string(s : SortexchangejLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_buffer_make(size : Int) -> SortexchangejBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_buffer_len(s : SortexchangejBuffer) -> Int { s.size }

pub fn sort_exchange_j_buffer_get(s : SortexchangejBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_buffer_set(s : SortexchangejBuffer, i : Int, v : Double) -> SortexchangejBuffer {
  let result = sort_exchange_j_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_buffer_sum(s : SortexchangejBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_buffer_mean(s : SortexchangejBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_buffer_scale(s : SortexchangejBuffer, f : Double) -> SortexchangejBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_buffer_add(a : SortexchangejBuffer, b : SortexchangejBuffer) -> SortexchangejBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_buffer_copy(s : SortexchangejBuffer) -> SortexchangejBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_buffer_fill(s : SortexchangejBuffer, v : Double) -> SortexchangejBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_buffer_min(s : SortexchangejBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_buffer_max(s : SortexchangejBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_buffer_to_string(s : SortexchangejBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_cursor_make(size : Int) -> SortexchangejCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_cursor_len(s : SortexchangejCursor) -> Int { s.size }

pub fn sort_exchange_j_cursor_get(s : SortexchangejCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_cursor_set(s : SortexchangejCursor, i : Int, v : Double) -> SortexchangejCursor {
  let result = sort_exchange_j_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_cursor_sum(s : SortexchangejCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_cursor_mean(s : SortexchangejCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_cursor_scale(s : SortexchangejCursor, f : Double) -> SortexchangejCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_cursor_add(a : SortexchangejCursor, b : SortexchangejCursor) -> SortexchangejCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_cursor_copy(s : SortexchangejCursor) -> SortexchangejCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_cursor_fill(s : SortexchangejCursor, v : Double) -> SortexchangejCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_cursor_min(s : SortexchangejCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_cursor_max(s : SortexchangejCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_cursor_to_string(s : SortexchangejCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_view_make(size : Int) -> SortexchangejView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_view_len(s : SortexchangejView) -> Int { s.size }

pub fn sort_exchange_j_view_get(s : SortexchangejView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_view_set(s : SortexchangejView, i : Int, v : Double) -> SortexchangejView {
  let result = sort_exchange_j_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_view_sum(s : SortexchangejView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_view_mean(s : SortexchangejView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_view_scale(s : SortexchangejView, f : Double) -> SortexchangejView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_view_add(a : SortexchangejView, b : SortexchangejView) -> SortexchangejView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_view_copy(s : SortexchangejView) -> SortexchangejView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_view_fill(s : SortexchangejView, v : Double) -> SortexchangejView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_view_min(s : SortexchangejView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_view_max(s : SortexchangejView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_view_to_string(s : SortexchangejView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_range_make(size : Int) -> SortexchangejRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_range_len(s : SortexchangejRange) -> Int { s.size }

pub fn sort_exchange_j_range_get(s : SortexchangejRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_range_set(s : SortexchangejRange, i : Int, v : Double) -> SortexchangejRange {
  let result = sort_exchange_j_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_range_sum(s : SortexchangejRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_range_mean(s : SortexchangejRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_range_scale(s : SortexchangejRange, f : Double) -> SortexchangejRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_range_add(a : SortexchangejRange, b : SortexchangejRange) -> SortexchangejRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_range_copy(s : SortexchangejRange) -> SortexchangejRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_range_fill(s : SortexchangejRange, v : Double) -> SortexchangejRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_range_min(s : SortexchangejRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_range_max(s : SortexchangejRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_range_to_string(s : SortexchangejRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangejSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_j_slice_make(size : Int) -> SortexchangejSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_j_slice_len(s : SortexchangejSlice) -> Int { s.size }

pub fn sort_exchange_j_slice_get(s : SortexchangejSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_j_slice_set(s : SortexchangejSlice, i : Int, v : Double) -> SortexchangejSlice {
  let result = sort_exchange_j_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_j_slice_sum(s : SortexchangejSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_j_slice_mean(s : SortexchangejSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_j_slice_scale(s : SortexchangejSlice, f : Double) -> SortexchangejSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_slice_add(a : SortexchangejSlice, b : SortexchangejSlice) -> SortexchangejSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_j_slice_copy(s : SortexchangejSlice) -> SortexchangejSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_slice_fill(s : SortexchangejSlice, v : Double) -> SortexchangejSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_j_slice_min(s : SortexchangejSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_j_slice_max(s : SortexchangejSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_j_slice_to_string(s : SortexchangejSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

