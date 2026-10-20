///===
/// extcore/sort_hybrid_timsort

pub(all) struct SorthybridtimsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_timsort_make_point(x : Double, y : Double) -> SorthybridtimsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_timsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridtimsortPoint {
  { x, y, z, label: 0 }
}

pub fn sort_hybrid_timsort_point_x(pt : SorthybridtimsortPoint) -> Double { pt.x }

pub fn sort_hybrid_timsort_point_y(pt : SorthybridtimsortPoint) -> Double { pt.y }

pub fn sort_hybrid_timsort_point_z(pt : SorthybridtimsortPoint) -> Double { pt.z }

pub fn sort_hybrid_timsort_point_label(pt : SorthybridtimsortPoint) -> Int { pt.label }

pub fn sort_hybrid_timsort_point_dist(a : SorthybridtimsortPoint, b : SorthybridtimsortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_hybrid_timsort_point_add(a : SorthybridtimsortPoint, b : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_hybrid_timsort_point_sub(a : SorthybridtimsortPoint, b : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_hybrid_timsort_point_scale(pt : SorthybridtimsortPoint, s : Double) -> SorthybridtimsortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_hybrid_timsort_point_dot(a : SorthybridtimsortPoint, b : SorthybridtimsortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_hybrid_timsort_point_cross(a : SorthybridtimsortPoint, b : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_hybrid_timsort_point_norm(pt : SorthybridtimsortPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_hybrid_timsort_point_normalize(pt : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  let n = sort_hybrid_timsort_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_hybrid_timsort_point_scale(pt, 1.0 / n) }
}

pub fn sort_hybrid_timsort_point_negate(pt : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_hybrid_timsort_point_mid(a : SorthybridtimsortPoint, b : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_hybrid_timsort_point_lerp(a : SorthybridtimsortPoint, b : SorthybridtimsortPoint, t : Double) -> SorthybridtimsortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_hybrid_timsort_point_to_string(pt : SorthybridtimsortPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SorthybridtimsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_timsort_make_series(vals : Array[Double], name : String) -> SorthybridtimsortSeries {
  { vals, name, meta: 0 }
}

pub fn sort_hybrid_timsort_series_len(s : SorthybridtimsortSeries) -> Int { s.vals.length() }

pub fn sort_hybrid_timsort_series_sum(s : SorthybridtimsortSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_hybrid_timsort_series_mean(s : SorthybridtimsortSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_hybrid_timsort_series_min(s : SorthybridtimsortSeries) -> Double { @_common.min(s.vals) }

pub fn sort_hybrid_timsort_series_max(s : SorthybridtimsortSeries) -> Double { @_common.max(s.vals) }

pub fn sort_hybrid_timsort_series_range(s : SorthybridtimsortSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_hybrid_timsort_series_var(s : SorthybridtimsortSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_hybrid_timsort_series_std(s : SorthybridtimsortSeries) -> Double { @_common.std(s.vals) }

pub fn sort_hybrid_timsort_series_median(s : SorthybridtimsortSeries) -> Double { @_common.median(s.vals) }

pub fn sort_hybrid_timsort_series_scale(s : SorthybridtimsortSeries, f : Double) -> SorthybridtimsortSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_hybrid_timsort_series_add(a : SorthybridtimsortSeries, b : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_hybrid_timsort_series_sub(a : SorthybridtimsortSeries, b : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_hybrid_timsort_series_normalize(s : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  let mn = sort_hybrid_timsort_series_min(s)
  let mx = sort_hybrid_timsort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_hybrid_timsort_series_cumsum(s : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_hybrid_timsort_series_to_string(s : SorthybridtimsortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridtimsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_timsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridtimsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_timsort_matrix_identity(n : Int) -> SorthybridtimsortMatrix {
  let m = sort_hybrid_timsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_hybrid_timsort_matrix_get(m : SorthybridtimsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_hybrid_timsort_matrix_transpose(m : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  let result = sort_hybrid_timsort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_hybrid_timsort_matrix_add(a : SorthybridtimsortMatrix, b : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_hybrid_timsort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_hybrid_timsort_matrix_scale(m : SorthybridtimsortMatrix, s : Double) -> SorthybridtimsortMatrix {
  let result = sort_hybrid_timsort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_hybrid_timsort_matrix_multiply(a : SorthybridtimsortMatrix, b : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  if a.cols != b.rows { return sort_hybrid_timsort_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_hybrid_timsort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_hybrid_timsort_matrix_trace(m : SorthybridtimsortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_hybrid_timsort_matrix_det(m : SorthybridtimsortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_hybrid_timsort_matrix_norm(m : SorthybridtimsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_hybrid_timsort_matrix_to_string(m : SorthybridtimsortMatrix) -> String {
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

pub(all) struct SorthybridtimsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_timsort_make_vector(comps : Array[Double]) -> SorthybridtimsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_timsort_vector_zero(dim : Int) -> SorthybridtimsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_hybrid_timsort_vector_add(a : SorthybridtimsortVector, b : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_timsort_vector_sub(a : SorthybridtimsortVector, b : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_timsort_vector_scale(v : SorthybridtimsortVector, s : Double) -> SorthybridtimsortVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_hybrid_timsort_vector_dot(a : SorthybridtimsortVector, b : SorthybridtimsortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_hybrid_timsort_vector_norm(v : SorthybridtimsortVector) -> Double { @_common.sqrt(sort_hybrid_timsort_vector_dot(v, v)) }

pub fn sort_hybrid_timsort_vector_normalize(v : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = sort_hybrid_timsort_vector_norm(v)
  if n < 0.0000001 { v } else { sort_hybrid_timsort_vector_scale(v, 1.0 / n) }
}

pub fn sort_hybrid_timsort_vector_dist(a : SorthybridtimsortVector, b : SorthybridtimsortVector) -> Double {
  sort_hybrid_timsort_vector_norm(sort_hybrid_timsort_vector_sub(a, b))
}

pub fn sort_hybrid_timsort_vector_to_string(v : SorthybridtimsortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_timsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_timsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_timsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_timsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_timsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_timsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_timsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_timsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_timsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_timsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_timsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_timsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_timsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_timsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_timsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_timsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_timsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_timsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_timsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_timsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_timsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_timsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_timsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_timsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_timsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_timsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_timsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_timsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_timsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridtimsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_frame_make(size : Int) -> SorthybridtimsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_frame_len(s : SorthybridtimsortFrame) -> Int { s.size }

pub fn sort_hybrid_timsort_frame_get(s : SorthybridtimsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_frame_set(s : SorthybridtimsortFrame, i : Int, v : Double) -> SorthybridtimsortFrame {
  let result = sort_hybrid_timsort_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_frame_sum(s : SorthybridtimsortFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_frame_mean(s : SorthybridtimsortFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_frame_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_frame_scale(s : SorthybridtimsortFrame, f : Double) -> SorthybridtimsortFrame {
  let result = sort_hybrid_timsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_frame_add(a : SorthybridtimsortFrame, b : SorthybridtimsortFrame) -> SorthybridtimsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_frame_copy(s : SorthybridtimsortFrame) -> SorthybridtimsortFrame {
  let result = sort_hybrid_timsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_frame_fill(s : SorthybridtimsortFrame, v : Double) -> SorthybridtimsortFrame {
  let result = sort_hybrid_timsort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_frame_min(s : SorthybridtimsortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_frame_max(s : SorthybridtimsortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_frame_to_string(s : SorthybridtimsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_table_make(size : Int) -> SorthybridtimsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_table_len(s : SorthybridtimsortTable) -> Int { s.size }

pub fn sort_hybrid_timsort_table_get(s : SorthybridtimsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_table_set(s : SorthybridtimsortTable, i : Int, v : Double) -> SorthybridtimsortTable {
  let result = sort_hybrid_timsort_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_table_sum(s : SorthybridtimsortTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_table_mean(s : SorthybridtimsortTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_table_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_table_scale(s : SorthybridtimsortTable, f : Double) -> SorthybridtimsortTable {
  let result = sort_hybrid_timsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_table_add(a : SorthybridtimsortTable, b : SorthybridtimsortTable) -> SorthybridtimsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_table_copy(s : SorthybridtimsortTable) -> SorthybridtimsortTable {
  let result = sort_hybrid_timsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_table_fill(s : SorthybridtimsortTable, v : Double) -> SorthybridtimsortTable {
  let result = sort_hybrid_timsort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_table_min(s : SorthybridtimsortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_table_max(s : SorthybridtimsortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_table_to_string(s : SorthybridtimsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_graphn_make(size : Int) -> SorthybridtimsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_graphn_len(s : SorthybridtimsortGraphN) -> Int { s.size }

pub fn sort_hybrid_timsort_graphn_get(s : SorthybridtimsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_graphn_set(s : SorthybridtimsortGraphN, i : Int, v : Double) -> SorthybridtimsortGraphN {
  let result = sort_hybrid_timsort_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_graphn_sum(s : SorthybridtimsortGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_graphn_mean(s : SorthybridtimsortGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_graphn_scale(s : SorthybridtimsortGraphN, f : Double) -> SorthybridtimsortGraphN {
  let result = sort_hybrid_timsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_graphn_add(a : SorthybridtimsortGraphN, b : SorthybridtimsortGraphN) -> SorthybridtimsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_graphn_copy(s : SorthybridtimsortGraphN) -> SorthybridtimsortGraphN {
  let result = sort_hybrid_timsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_graphn_fill(s : SorthybridtimsortGraphN, v : Double) -> SorthybridtimsortGraphN {
  let result = sort_hybrid_timsort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_graphn_min(s : SorthybridtimsortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_graphn_max(s : SorthybridtimsortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_graphn_to_string(s : SorthybridtimsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_node_make(size : Int) -> SorthybridtimsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_node_len(s : SorthybridtimsortNode) -> Int { s.size }

pub fn sort_hybrid_timsort_node_get(s : SorthybridtimsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_node_set(s : SorthybridtimsortNode, i : Int, v : Double) -> SorthybridtimsortNode {
  let result = sort_hybrid_timsort_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_node_sum(s : SorthybridtimsortNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_node_mean(s : SorthybridtimsortNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_node_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_node_scale(s : SorthybridtimsortNode, f : Double) -> SorthybridtimsortNode {
  let result = sort_hybrid_timsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_node_add(a : SorthybridtimsortNode, b : SorthybridtimsortNode) -> SorthybridtimsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_node_copy(s : SorthybridtimsortNode) -> SorthybridtimsortNode {
  let result = sort_hybrid_timsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_node_fill(s : SorthybridtimsortNode, v : Double) -> SorthybridtimsortNode {
  let result = sort_hybrid_timsort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_node_min(s : SorthybridtimsortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_node_max(s : SorthybridtimsortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_node_to_string(s : SorthybridtimsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_edge_make(size : Int) -> SorthybridtimsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_edge_len(s : SorthybridtimsortEdge) -> Int { s.size }

pub fn sort_hybrid_timsort_edge_get(s : SorthybridtimsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_edge_set(s : SorthybridtimsortEdge, i : Int, v : Double) -> SorthybridtimsortEdge {
  let result = sort_hybrid_timsort_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_edge_sum(s : SorthybridtimsortEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_edge_mean(s : SorthybridtimsortEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_edge_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_edge_scale(s : SorthybridtimsortEdge, f : Double) -> SorthybridtimsortEdge {
  let result = sort_hybrid_timsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_edge_add(a : SorthybridtimsortEdge, b : SorthybridtimsortEdge) -> SorthybridtimsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_edge_copy(s : SorthybridtimsortEdge) -> SorthybridtimsortEdge {
  let result = sort_hybrid_timsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_edge_fill(s : SorthybridtimsortEdge, v : Double) -> SorthybridtimsortEdge {
  let result = sort_hybrid_timsort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_edge_min(s : SorthybridtimsortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_edge_max(s : SorthybridtimsortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_edge_to_string(s : SorthybridtimsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_path_make(size : Int) -> SorthybridtimsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_path_len(s : SorthybridtimsortPath) -> Int { s.size }

pub fn sort_hybrid_timsort_path_get(s : SorthybridtimsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_path_set(s : SorthybridtimsortPath, i : Int, v : Double) -> SorthybridtimsortPath {
  let result = sort_hybrid_timsort_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_path_sum(s : SorthybridtimsortPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_path_mean(s : SorthybridtimsortPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_path_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_path_scale(s : SorthybridtimsortPath, f : Double) -> SorthybridtimsortPath {
  let result = sort_hybrid_timsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_path_add(a : SorthybridtimsortPath, b : SorthybridtimsortPath) -> SorthybridtimsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_path_copy(s : SorthybridtimsortPath) -> SorthybridtimsortPath {
  let result = sort_hybrid_timsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_path_fill(s : SorthybridtimsortPath, v : Double) -> SorthybridtimsortPath {
  let result = sort_hybrid_timsort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_path_min(s : SorthybridtimsortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_path_max(s : SorthybridtimsortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_path_to_string(s : SorthybridtimsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_cluster_make(size : Int) -> SorthybridtimsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_cluster_len(s : SorthybridtimsortCluster) -> Int { s.size }

pub fn sort_hybrid_timsort_cluster_get(s : SorthybridtimsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_cluster_set(s : SorthybridtimsortCluster, i : Int, v : Double) -> SorthybridtimsortCluster {
  let result = sort_hybrid_timsort_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_cluster_sum(s : SorthybridtimsortCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_cluster_mean(s : SorthybridtimsortCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_cluster_scale(s : SorthybridtimsortCluster, f : Double) -> SorthybridtimsortCluster {
  let result = sort_hybrid_timsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_cluster_add(a : SorthybridtimsortCluster, b : SorthybridtimsortCluster) -> SorthybridtimsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_cluster_copy(s : SorthybridtimsortCluster) -> SorthybridtimsortCluster {
  let result = sort_hybrid_timsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_cluster_fill(s : SorthybridtimsortCluster, v : Double) -> SorthybridtimsortCluster {
  let result = sort_hybrid_timsort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_cluster_min(s : SorthybridtimsortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_cluster_max(s : SorthybridtimsortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_cluster_to_string(s : SorthybridtimsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_model_make(size : Int) -> SorthybridtimsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_model_len(s : SorthybridtimsortModel) -> Int { s.size }

pub fn sort_hybrid_timsort_model_get(s : SorthybridtimsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_model_set(s : SorthybridtimsortModel, i : Int, v : Double) -> SorthybridtimsortModel {
  let result = sort_hybrid_timsort_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_model_sum(s : SorthybridtimsortModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_model_mean(s : SorthybridtimsortModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_model_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_model_scale(s : SorthybridtimsortModel, f : Double) -> SorthybridtimsortModel {
  let result = sort_hybrid_timsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_model_add(a : SorthybridtimsortModel, b : SorthybridtimsortModel) -> SorthybridtimsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_model_copy(s : SorthybridtimsortModel) -> SorthybridtimsortModel {
  let result = sort_hybrid_timsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_model_fill(s : SorthybridtimsortModel, v : Double) -> SorthybridtimsortModel {
  let result = sort_hybrid_timsort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_model_min(s : SorthybridtimsortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_model_max(s : SorthybridtimsortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_model_to_string(s : SorthybridtimsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_layer_make(size : Int) -> SorthybridtimsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_layer_len(s : SorthybridtimsortLayer) -> Int { s.size }

pub fn sort_hybrid_timsort_layer_get(s : SorthybridtimsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_layer_set(s : SorthybridtimsortLayer, i : Int, v : Double) -> SorthybridtimsortLayer {
  let result = sort_hybrid_timsort_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_layer_sum(s : SorthybridtimsortLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_layer_mean(s : SorthybridtimsortLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_layer_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_layer_scale(s : SorthybridtimsortLayer, f : Double) -> SorthybridtimsortLayer {
  let result = sort_hybrid_timsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_layer_add(a : SorthybridtimsortLayer, b : SorthybridtimsortLayer) -> SorthybridtimsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_layer_copy(s : SorthybridtimsortLayer) -> SorthybridtimsortLayer {
  let result = sort_hybrid_timsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_layer_fill(s : SorthybridtimsortLayer, v : Double) -> SorthybridtimsortLayer {
  let result = sort_hybrid_timsort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_layer_min(s : SorthybridtimsortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_layer_max(s : SorthybridtimsortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_layer_to_string(s : SorthybridtimsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_buffer_make(size : Int) -> SorthybridtimsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_buffer_len(s : SorthybridtimsortBuffer) -> Int { s.size }

pub fn sort_hybrid_timsort_buffer_get(s : SorthybridtimsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_buffer_set(s : SorthybridtimsortBuffer, i : Int, v : Double) -> SorthybridtimsortBuffer {
  let result = sort_hybrid_timsort_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_buffer_sum(s : SorthybridtimsortBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_buffer_mean(s : SorthybridtimsortBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_buffer_scale(s : SorthybridtimsortBuffer, f : Double) -> SorthybridtimsortBuffer {
  let result = sort_hybrid_timsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_buffer_add(a : SorthybridtimsortBuffer, b : SorthybridtimsortBuffer) -> SorthybridtimsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_buffer_copy(s : SorthybridtimsortBuffer) -> SorthybridtimsortBuffer {
  let result = sort_hybrid_timsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_buffer_fill(s : SorthybridtimsortBuffer, v : Double) -> SorthybridtimsortBuffer {
  let result = sort_hybrid_timsort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_buffer_min(s : SorthybridtimsortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_buffer_max(s : SorthybridtimsortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_buffer_to_string(s : SorthybridtimsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_cursor_make(size : Int) -> SorthybridtimsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_cursor_len(s : SorthybridtimsortCursor) -> Int { s.size }

pub fn sort_hybrid_timsort_cursor_get(s : SorthybridtimsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_cursor_set(s : SorthybridtimsortCursor, i : Int, v : Double) -> SorthybridtimsortCursor {
  let result = sort_hybrid_timsort_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_cursor_sum(s : SorthybridtimsortCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_cursor_mean(s : SorthybridtimsortCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_cursor_scale(s : SorthybridtimsortCursor, f : Double) -> SorthybridtimsortCursor {
  let result = sort_hybrid_timsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_cursor_add(a : SorthybridtimsortCursor, b : SorthybridtimsortCursor) -> SorthybridtimsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_cursor_copy(s : SorthybridtimsortCursor) -> SorthybridtimsortCursor {
  let result = sort_hybrid_timsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_cursor_fill(s : SorthybridtimsortCursor, v : Double) -> SorthybridtimsortCursor {
  let result = sort_hybrid_timsort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_cursor_min(s : SorthybridtimsortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_cursor_max(s : SorthybridtimsortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_cursor_to_string(s : SorthybridtimsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_view_make(size : Int) -> SorthybridtimsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_view_len(s : SorthybridtimsortView) -> Int { s.size }

pub fn sort_hybrid_timsort_view_get(s : SorthybridtimsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_view_set(s : SorthybridtimsortView, i : Int, v : Double) -> SorthybridtimsortView {
  let result = sort_hybrid_timsort_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_view_sum(s : SorthybridtimsortView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_view_mean(s : SorthybridtimsortView) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_view_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_view_scale(s : SorthybridtimsortView, f : Double) -> SorthybridtimsortView {
  let result = sort_hybrid_timsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_view_add(a : SorthybridtimsortView, b : SorthybridtimsortView) -> SorthybridtimsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_view_copy(s : SorthybridtimsortView) -> SorthybridtimsortView {
  let result = sort_hybrid_timsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_view_fill(s : SorthybridtimsortView, v : Double) -> SorthybridtimsortView {
  let result = sort_hybrid_timsort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_view_min(s : SorthybridtimsortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_view_max(s : SorthybridtimsortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_view_to_string(s : SorthybridtimsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_range_make(size : Int) -> SorthybridtimsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_range_len(s : SorthybridtimsortRange) -> Int { s.size }

pub fn sort_hybrid_timsort_range_get(s : SorthybridtimsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_range_set(s : SorthybridtimsortRange, i : Int, v : Double) -> SorthybridtimsortRange {
  let result = sort_hybrid_timsort_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_range_sum(s : SorthybridtimsortRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_range_mean(s : SorthybridtimsortRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_range_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_range_scale(s : SorthybridtimsortRange, f : Double) -> SorthybridtimsortRange {
  let result = sort_hybrid_timsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_range_add(a : SorthybridtimsortRange, b : SorthybridtimsortRange) -> SorthybridtimsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_range_copy(s : SorthybridtimsortRange) -> SorthybridtimsortRange {
  let result = sort_hybrid_timsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_range_fill(s : SorthybridtimsortRange, v : Double) -> SorthybridtimsortRange {
  let result = sort_hybrid_timsort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_range_min(s : SorthybridtimsortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_range_max(s : SorthybridtimsortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_range_to_string(s : SorthybridtimsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_slice_make(size : Int) -> SorthybridtimsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_slice_len(s : SorthybridtimsortSlice) -> Int { s.size }

pub fn sort_hybrid_timsort_slice_get(s : SorthybridtimsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_slice_set(s : SorthybridtimsortSlice, i : Int, v : Double) -> SorthybridtimsortSlice {
  let result = sort_hybrid_timsort_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_slice_sum(s : SorthybridtimsortSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_timsort_slice_mean(s : SorthybridtimsortSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_timsort_slice_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_timsort_slice_scale(s : SorthybridtimsortSlice, f : Double) -> SorthybridtimsortSlice {
  let result = sort_hybrid_timsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_timsort_slice_add(a : SorthybridtimsortSlice, b : SorthybridtimsortSlice) -> SorthybridtimsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_timsort_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_timsort_slice_copy(s : SorthybridtimsortSlice) -> SorthybridtimsortSlice {
  let result = sort_hybrid_timsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_timsort_slice_fill(s : SorthybridtimsortSlice, v : Double) -> SorthybridtimsortSlice {
  let result = sort_hybrid_timsort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_timsort_slice_min(s : SorthybridtimsortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_slice_max(s : SorthybridtimsortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_timsort_slice_to_string(s : SorthybridtimsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

