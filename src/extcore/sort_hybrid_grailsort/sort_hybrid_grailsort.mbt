///===
/// extcore/sort_hybrid_grailsort

pub(all) struct SorthybridgrailsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_grailsort_make_point(x : Double, y : Double) -> SorthybridgrailsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_grailsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridgrailsortPoint {
  { x, y, z, label: 0 }
}

pub fn sort_hybrid_grailsort_point_x(pt : SorthybridgrailsortPoint) -> Double { pt.x }

pub fn sort_hybrid_grailsort_point_y(pt : SorthybridgrailsortPoint) -> Double { pt.y }

pub fn sort_hybrid_grailsort_point_z(pt : SorthybridgrailsortPoint) -> Double { pt.z }

pub fn sort_hybrid_grailsort_point_label(pt : SorthybridgrailsortPoint) -> Int { pt.label }

pub fn sort_hybrid_grailsort_point_dist(a : SorthybridgrailsortPoint, b : SorthybridgrailsortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_hybrid_grailsort_point_add(a : SorthybridgrailsortPoint, b : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_hybrid_grailsort_point_sub(a : SorthybridgrailsortPoint, b : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_hybrid_grailsort_point_scale(pt : SorthybridgrailsortPoint, s : Double) -> SorthybridgrailsortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_hybrid_grailsort_point_dot(a : SorthybridgrailsortPoint, b : SorthybridgrailsortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_hybrid_grailsort_point_cross(a : SorthybridgrailsortPoint, b : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_hybrid_grailsort_point_norm(pt : SorthybridgrailsortPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_hybrid_grailsort_point_normalize(pt : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  let n = sort_hybrid_grailsort_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_hybrid_grailsort_point_scale(pt, 1.0 / n) }
}

pub fn sort_hybrid_grailsort_point_negate(pt : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_hybrid_grailsort_point_mid(a : SorthybridgrailsortPoint, b : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_hybrid_grailsort_point_lerp(a : SorthybridgrailsortPoint, b : SorthybridgrailsortPoint, t : Double) -> SorthybridgrailsortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_hybrid_grailsort_point_to_string(pt : SorthybridgrailsortPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SorthybridgrailsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_grailsort_make_series(vals : Array[Double], name : String) -> SorthybridgrailsortSeries {
  { vals, name, meta: 0 }
}

pub fn sort_hybrid_grailsort_series_len(s : SorthybridgrailsortSeries) -> Int { s.vals.length() }

pub fn sort_hybrid_grailsort_series_sum(s : SorthybridgrailsortSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_hybrid_grailsort_series_mean(s : SorthybridgrailsortSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_hybrid_grailsort_series_min(s : SorthybridgrailsortSeries) -> Double { @_common.min(s.vals) }

pub fn sort_hybrid_grailsort_series_max(s : SorthybridgrailsortSeries) -> Double { @_common.max(s.vals) }

pub fn sort_hybrid_grailsort_series_range(s : SorthybridgrailsortSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_hybrid_grailsort_series_var(s : SorthybridgrailsortSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_hybrid_grailsort_series_std(s : SorthybridgrailsortSeries) -> Double { @_common.std(s.vals) }

pub fn sort_hybrid_grailsort_series_median(s : SorthybridgrailsortSeries) -> Double { @_common.median(s.vals) }

pub fn sort_hybrid_grailsort_series_scale(s : SorthybridgrailsortSeries, f : Double) -> SorthybridgrailsortSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_hybrid_grailsort_series_add(a : SorthybridgrailsortSeries, b : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_hybrid_grailsort_series_sub(a : SorthybridgrailsortSeries, b : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_hybrid_grailsort_series_normalize(s : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  let mn = sort_hybrid_grailsort_series_min(s)
  let mx = sort_hybrid_grailsort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_hybrid_grailsort_series_cumsum(s : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_hybrid_grailsort_series_to_string(s : SorthybridgrailsortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridgrailsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_grailsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridgrailsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_grailsort_matrix_identity(n : Int) -> SorthybridgrailsortMatrix {
  let m = sort_hybrid_grailsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_hybrid_grailsort_matrix_get(m : SorthybridgrailsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_hybrid_grailsort_matrix_transpose(m : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  let result = sort_hybrid_grailsort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_hybrid_grailsort_matrix_add(a : SorthybridgrailsortMatrix, b : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_hybrid_grailsort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_hybrid_grailsort_matrix_scale(m : SorthybridgrailsortMatrix, s : Double) -> SorthybridgrailsortMatrix {
  let result = sort_hybrid_grailsort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_hybrid_grailsort_matrix_multiply(a : SorthybridgrailsortMatrix, b : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  if a.cols != b.rows { return sort_hybrid_grailsort_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_hybrid_grailsort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_hybrid_grailsort_matrix_trace(m : SorthybridgrailsortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_hybrid_grailsort_matrix_det(m : SorthybridgrailsortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_hybrid_grailsort_matrix_norm(m : SorthybridgrailsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_hybrid_grailsort_matrix_to_string(m : SorthybridgrailsortMatrix) -> String {
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

pub(all) struct SorthybridgrailsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_grailsort_make_vector(comps : Array[Double]) -> SorthybridgrailsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_grailsort_vector_zero(dim : Int) -> SorthybridgrailsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_hybrid_grailsort_vector_add(a : SorthybridgrailsortVector, b : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_grailsort_vector_sub(a : SorthybridgrailsortVector, b : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_grailsort_vector_scale(v : SorthybridgrailsortVector, s : Double) -> SorthybridgrailsortVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_hybrid_grailsort_vector_dot(a : SorthybridgrailsortVector, b : SorthybridgrailsortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_hybrid_grailsort_vector_norm(v : SorthybridgrailsortVector) -> Double { @_common.sqrt(sort_hybrid_grailsort_vector_dot(v, v)) }

pub fn sort_hybrid_grailsort_vector_normalize(v : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = sort_hybrid_grailsort_vector_norm(v)
  if n < 0.0000001 { v } else { sort_hybrid_grailsort_vector_scale(v, 1.0 / n) }
}

pub fn sort_hybrid_grailsort_vector_dist(a : SorthybridgrailsortVector, b : SorthybridgrailsortVector) -> Double {
  sort_hybrid_grailsort_vector_norm(sort_hybrid_grailsort_vector_sub(a, b))
}

pub fn sort_hybrid_grailsort_vector_to_string(v : SorthybridgrailsortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_grailsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_grailsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_grailsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_grailsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_grailsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_grailsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_grailsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_grailsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_grailsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_grailsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_grailsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_grailsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_grailsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_grailsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_grailsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_grailsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_grailsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_grailsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_grailsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_grailsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_grailsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_grailsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_grailsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_grailsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_grailsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_grailsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_grailsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_grailsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_grailsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridgrailsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_frame_make(size : Int) -> SorthybridgrailsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_frame_len(s : SorthybridgrailsortFrame) -> Int { s.size }

pub fn sort_hybrid_grailsort_frame_get(s : SorthybridgrailsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_frame_set(s : SorthybridgrailsortFrame, i : Int, v : Double) -> SorthybridgrailsortFrame {
  let result = sort_hybrid_grailsort_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_frame_sum(s : SorthybridgrailsortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_frame_mean(s : SorthybridgrailsortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_frame_scale(s : SorthybridgrailsortFrame, f : Double) -> SorthybridgrailsortFrame {
  let result = sort_hybrid_grailsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_frame_add(a : SorthybridgrailsortFrame, b : SorthybridgrailsortFrame) -> SorthybridgrailsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_frame_copy(s : SorthybridgrailsortFrame) -> SorthybridgrailsortFrame {
  let result = sort_hybrid_grailsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_frame_fill(s : SorthybridgrailsortFrame, v : Double) -> SorthybridgrailsortFrame {
  let result = sort_hybrid_grailsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_frame_min(s : SorthybridgrailsortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_frame_max(s : SorthybridgrailsortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_frame_to_string(s : SorthybridgrailsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_table_make(size : Int) -> SorthybridgrailsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_table_len(s : SorthybridgrailsortTable) -> Int { s.size }

pub fn sort_hybrid_grailsort_table_get(s : SorthybridgrailsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_table_set(s : SorthybridgrailsortTable, i : Int, v : Double) -> SorthybridgrailsortTable {
  let result = sort_hybrid_grailsort_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_table_sum(s : SorthybridgrailsortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_table_mean(s : SorthybridgrailsortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_table_scale(s : SorthybridgrailsortTable, f : Double) -> SorthybridgrailsortTable {
  let result = sort_hybrid_grailsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_table_add(a : SorthybridgrailsortTable, b : SorthybridgrailsortTable) -> SorthybridgrailsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_table_copy(s : SorthybridgrailsortTable) -> SorthybridgrailsortTable {
  let result = sort_hybrid_grailsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_table_fill(s : SorthybridgrailsortTable, v : Double) -> SorthybridgrailsortTable {
  let result = sort_hybrid_grailsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_table_min(s : SorthybridgrailsortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_table_max(s : SorthybridgrailsortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_table_to_string(s : SorthybridgrailsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_graphn_make(size : Int) -> SorthybridgrailsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_graphn_len(s : SorthybridgrailsortGraphN) -> Int { s.size }

pub fn sort_hybrid_grailsort_graphn_get(s : SorthybridgrailsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_graphn_set(s : SorthybridgrailsortGraphN, i : Int, v : Double) -> SorthybridgrailsortGraphN {
  let result = sort_hybrid_grailsort_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_graphn_sum(s : SorthybridgrailsortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_graphn_mean(s : SorthybridgrailsortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_graphn_scale(s : SorthybridgrailsortGraphN, f : Double) -> SorthybridgrailsortGraphN {
  let result = sort_hybrid_grailsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_graphn_add(a : SorthybridgrailsortGraphN, b : SorthybridgrailsortGraphN) -> SorthybridgrailsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_graphn_copy(s : SorthybridgrailsortGraphN) -> SorthybridgrailsortGraphN {
  let result = sort_hybrid_grailsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_graphn_fill(s : SorthybridgrailsortGraphN, v : Double) -> SorthybridgrailsortGraphN {
  let result = sort_hybrid_grailsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_graphn_min(s : SorthybridgrailsortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_graphn_max(s : SorthybridgrailsortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_graphn_to_string(s : SorthybridgrailsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_node_make(size : Int) -> SorthybridgrailsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_node_len(s : SorthybridgrailsortNode) -> Int { s.size }

pub fn sort_hybrid_grailsort_node_get(s : SorthybridgrailsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_node_set(s : SorthybridgrailsortNode, i : Int, v : Double) -> SorthybridgrailsortNode {
  let result = sort_hybrid_grailsort_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_node_sum(s : SorthybridgrailsortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_node_mean(s : SorthybridgrailsortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_node_scale(s : SorthybridgrailsortNode, f : Double) -> SorthybridgrailsortNode {
  let result = sort_hybrid_grailsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_node_add(a : SorthybridgrailsortNode, b : SorthybridgrailsortNode) -> SorthybridgrailsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_node_copy(s : SorthybridgrailsortNode) -> SorthybridgrailsortNode {
  let result = sort_hybrid_grailsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_node_fill(s : SorthybridgrailsortNode, v : Double) -> SorthybridgrailsortNode {
  let result = sort_hybrid_grailsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_node_min(s : SorthybridgrailsortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_node_max(s : SorthybridgrailsortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_node_to_string(s : SorthybridgrailsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_edge_make(size : Int) -> SorthybridgrailsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_edge_len(s : SorthybridgrailsortEdge) -> Int { s.size }

pub fn sort_hybrid_grailsort_edge_get(s : SorthybridgrailsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_edge_set(s : SorthybridgrailsortEdge, i : Int, v : Double) -> SorthybridgrailsortEdge {
  let result = sort_hybrid_grailsort_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_edge_sum(s : SorthybridgrailsortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_edge_mean(s : SorthybridgrailsortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_edge_scale(s : SorthybridgrailsortEdge, f : Double) -> SorthybridgrailsortEdge {
  let result = sort_hybrid_grailsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_edge_add(a : SorthybridgrailsortEdge, b : SorthybridgrailsortEdge) -> SorthybridgrailsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_edge_copy(s : SorthybridgrailsortEdge) -> SorthybridgrailsortEdge {
  let result = sort_hybrid_grailsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_edge_fill(s : SorthybridgrailsortEdge, v : Double) -> SorthybridgrailsortEdge {
  let result = sort_hybrid_grailsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_edge_min(s : SorthybridgrailsortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_edge_max(s : SorthybridgrailsortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_edge_to_string(s : SorthybridgrailsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_path_make(size : Int) -> SorthybridgrailsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_path_len(s : SorthybridgrailsortPath) -> Int { s.size }

pub fn sort_hybrid_grailsort_path_get(s : SorthybridgrailsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_path_set(s : SorthybridgrailsortPath, i : Int, v : Double) -> SorthybridgrailsortPath {
  let result = sort_hybrid_grailsort_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_path_sum(s : SorthybridgrailsortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_path_mean(s : SorthybridgrailsortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_path_scale(s : SorthybridgrailsortPath, f : Double) -> SorthybridgrailsortPath {
  let result = sort_hybrid_grailsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_path_add(a : SorthybridgrailsortPath, b : SorthybridgrailsortPath) -> SorthybridgrailsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_path_copy(s : SorthybridgrailsortPath) -> SorthybridgrailsortPath {
  let result = sort_hybrid_grailsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_path_fill(s : SorthybridgrailsortPath, v : Double) -> SorthybridgrailsortPath {
  let result = sort_hybrid_grailsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_path_min(s : SorthybridgrailsortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_path_max(s : SorthybridgrailsortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_path_to_string(s : SorthybridgrailsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_cluster_make(size : Int) -> SorthybridgrailsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_cluster_len(s : SorthybridgrailsortCluster) -> Int { s.size }

pub fn sort_hybrid_grailsort_cluster_get(s : SorthybridgrailsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_cluster_set(s : SorthybridgrailsortCluster, i : Int, v : Double) -> SorthybridgrailsortCluster {
  let result = sort_hybrid_grailsort_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_cluster_sum(s : SorthybridgrailsortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_cluster_mean(s : SorthybridgrailsortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_cluster_scale(s : SorthybridgrailsortCluster, f : Double) -> SorthybridgrailsortCluster {
  let result = sort_hybrid_grailsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_cluster_add(a : SorthybridgrailsortCluster, b : SorthybridgrailsortCluster) -> SorthybridgrailsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_cluster_copy(s : SorthybridgrailsortCluster) -> SorthybridgrailsortCluster {
  let result = sort_hybrid_grailsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_cluster_fill(s : SorthybridgrailsortCluster, v : Double) -> SorthybridgrailsortCluster {
  let result = sort_hybrid_grailsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_cluster_min(s : SorthybridgrailsortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_cluster_max(s : SorthybridgrailsortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_cluster_to_string(s : SorthybridgrailsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_model_make(size : Int) -> SorthybridgrailsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_model_len(s : SorthybridgrailsortModel) -> Int { s.size }

pub fn sort_hybrid_grailsort_model_get(s : SorthybridgrailsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_model_set(s : SorthybridgrailsortModel, i : Int, v : Double) -> SorthybridgrailsortModel {
  let result = sort_hybrid_grailsort_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_model_sum(s : SorthybridgrailsortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_model_mean(s : SorthybridgrailsortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_model_scale(s : SorthybridgrailsortModel, f : Double) -> SorthybridgrailsortModel {
  let result = sort_hybrid_grailsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_model_add(a : SorthybridgrailsortModel, b : SorthybridgrailsortModel) -> SorthybridgrailsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_model_copy(s : SorthybridgrailsortModel) -> SorthybridgrailsortModel {
  let result = sort_hybrid_grailsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_model_fill(s : SorthybridgrailsortModel, v : Double) -> SorthybridgrailsortModel {
  let result = sort_hybrid_grailsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_model_min(s : SorthybridgrailsortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_model_max(s : SorthybridgrailsortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_model_to_string(s : SorthybridgrailsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_layer_make(size : Int) -> SorthybridgrailsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_layer_len(s : SorthybridgrailsortLayer) -> Int { s.size }

pub fn sort_hybrid_grailsort_layer_get(s : SorthybridgrailsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_layer_set(s : SorthybridgrailsortLayer, i : Int, v : Double) -> SorthybridgrailsortLayer {
  let result = sort_hybrid_grailsort_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_layer_sum(s : SorthybridgrailsortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_layer_mean(s : SorthybridgrailsortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_layer_scale(s : SorthybridgrailsortLayer, f : Double) -> SorthybridgrailsortLayer {
  let result = sort_hybrid_grailsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_layer_add(a : SorthybridgrailsortLayer, b : SorthybridgrailsortLayer) -> SorthybridgrailsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_layer_copy(s : SorthybridgrailsortLayer) -> SorthybridgrailsortLayer {
  let result = sort_hybrid_grailsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_layer_fill(s : SorthybridgrailsortLayer, v : Double) -> SorthybridgrailsortLayer {
  let result = sort_hybrid_grailsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_layer_min(s : SorthybridgrailsortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_layer_max(s : SorthybridgrailsortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_layer_to_string(s : SorthybridgrailsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_buffer_make(size : Int) -> SorthybridgrailsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_buffer_len(s : SorthybridgrailsortBuffer) -> Int { s.size }

pub fn sort_hybrid_grailsort_buffer_get(s : SorthybridgrailsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_buffer_set(s : SorthybridgrailsortBuffer, i : Int, v : Double) -> SorthybridgrailsortBuffer {
  let result = sort_hybrid_grailsort_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_buffer_sum(s : SorthybridgrailsortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_buffer_mean(s : SorthybridgrailsortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_buffer_scale(s : SorthybridgrailsortBuffer, f : Double) -> SorthybridgrailsortBuffer {
  let result = sort_hybrid_grailsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_buffer_add(a : SorthybridgrailsortBuffer, b : SorthybridgrailsortBuffer) -> SorthybridgrailsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_buffer_copy(s : SorthybridgrailsortBuffer) -> SorthybridgrailsortBuffer {
  let result = sort_hybrid_grailsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_buffer_fill(s : SorthybridgrailsortBuffer, v : Double) -> SorthybridgrailsortBuffer {
  let result = sort_hybrid_grailsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_buffer_min(s : SorthybridgrailsortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_buffer_max(s : SorthybridgrailsortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_buffer_to_string(s : SorthybridgrailsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_cursor_make(size : Int) -> SorthybridgrailsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_cursor_len(s : SorthybridgrailsortCursor) -> Int { s.size }

pub fn sort_hybrid_grailsort_cursor_get(s : SorthybridgrailsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_cursor_set(s : SorthybridgrailsortCursor, i : Int, v : Double) -> SorthybridgrailsortCursor {
  let result = sort_hybrid_grailsort_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_cursor_sum(s : SorthybridgrailsortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_cursor_mean(s : SorthybridgrailsortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_cursor_scale(s : SorthybridgrailsortCursor, f : Double) -> SorthybridgrailsortCursor {
  let result = sort_hybrid_grailsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_cursor_add(a : SorthybridgrailsortCursor, b : SorthybridgrailsortCursor) -> SorthybridgrailsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_cursor_copy(s : SorthybridgrailsortCursor) -> SorthybridgrailsortCursor {
  let result = sort_hybrid_grailsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_cursor_fill(s : SorthybridgrailsortCursor, v : Double) -> SorthybridgrailsortCursor {
  let result = sort_hybrid_grailsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_cursor_min(s : SorthybridgrailsortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_cursor_max(s : SorthybridgrailsortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_cursor_to_string(s : SorthybridgrailsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_view_make(size : Int) -> SorthybridgrailsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_view_len(s : SorthybridgrailsortView) -> Int { s.size }

pub fn sort_hybrid_grailsort_view_get(s : SorthybridgrailsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_view_set(s : SorthybridgrailsortView, i : Int, v : Double) -> SorthybridgrailsortView {
  let result = sort_hybrid_grailsort_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_view_sum(s : SorthybridgrailsortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_view_mean(s : SorthybridgrailsortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_view_scale(s : SorthybridgrailsortView, f : Double) -> SorthybridgrailsortView {
  let result = sort_hybrid_grailsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_view_add(a : SorthybridgrailsortView, b : SorthybridgrailsortView) -> SorthybridgrailsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_view_copy(s : SorthybridgrailsortView) -> SorthybridgrailsortView {
  let result = sort_hybrid_grailsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_view_fill(s : SorthybridgrailsortView, v : Double) -> SorthybridgrailsortView {
  let result = sort_hybrid_grailsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_view_min(s : SorthybridgrailsortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_view_max(s : SorthybridgrailsortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_view_to_string(s : SorthybridgrailsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_range_make(size : Int) -> SorthybridgrailsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_range_len(s : SorthybridgrailsortRange) -> Int { s.size }

pub fn sort_hybrid_grailsort_range_get(s : SorthybridgrailsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_range_set(s : SorthybridgrailsortRange, i : Int, v : Double) -> SorthybridgrailsortRange {
  let result = sort_hybrid_grailsort_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_range_sum(s : SorthybridgrailsortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_range_mean(s : SorthybridgrailsortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_range_scale(s : SorthybridgrailsortRange, f : Double) -> SorthybridgrailsortRange {
  let result = sort_hybrid_grailsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_range_add(a : SorthybridgrailsortRange, b : SorthybridgrailsortRange) -> SorthybridgrailsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_range_copy(s : SorthybridgrailsortRange) -> SorthybridgrailsortRange {
  let result = sort_hybrid_grailsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_range_fill(s : SorthybridgrailsortRange, v : Double) -> SorthybridgrailsortRange {
  let result = sort_hybrid_grailsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_range_min(s : SorthybridgrailsortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_range_max(s : SorthybridgrailsortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_range_to_string(s : SorthybridgrailsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_slice_make(size : Int) -> SorthybridgrailsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_slice_len(s : SorthybridgrailsortSlice) -> Int { s.size }

pub fn sort_hybrid_grailsort_slice_get(s : SorthybridgrailsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_slice_set(s : SorthybridgrailsortSlice, i : Int, v : Double) -> SorthybridgrailsortSlice {
  let result = sort_hybrid_grailsort_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_slice_sum(s : SorthybridgrailsortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_slice_mean(s : SorthybridgrailsortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_slice_scale(s : SorthybridgrailsortSlice, f : Double) -> SorthybridgrailsortSlice {
  let result = sort_hybrid_grailsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_grailsort_slice_add(a : SorthybridgrailsortSlice, b : SorthybridgrailsortSlice) -> SorthybridgrailsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_grailsort_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_grailsort_slice_copy(s : SorthybridgrailsortSlice) -> SorthybridgrailsortSlice {
  let result = sort_hybrid_grailsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_grailsort_slice_fill(s : SorthybridgrailsortSlice, v : Double) -> SorthybridgrailsortSlice {
  let result = sort_hybrid_grailsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_grailsort_slice_min(s : SorthybridgrailsortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_slice_max(s : SorthybridgrailsortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_slice_to_string(s : SorthybridgrailsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

