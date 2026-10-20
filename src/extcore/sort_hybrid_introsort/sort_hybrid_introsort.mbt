///===
/// extcore/sort_hybrid_introsort

pub(all) struct SorthybridintrosortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_introsort_make_point(x : Double, y : Double) -> SorthybridintrosortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_introsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridintrosortPoint {
  { x, y, z, label: 0 }
}

pub fn sort_hybrid_introsort_point_x(pt : SorthybridintrosortPoint) -> Double { pt.x }

pub fn sort_hybrid_introsort_point_y(pt : SorthybridintrosortPoint) -> Double { pt.y }

pub fn sort_hybrid_introsort_point_z(pt : SorthybridintrosortPoint) -> Double { pt.z }

pub fn sort_hybrid_introsort_point_label(pt : SorthybridintrosortPoint) -> Int { pt.label }

pub fn sort_hybrid_introsort_point_dist(a : SorthybridintrosortPoint, b : SorthybridintrosortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_hybrid_introsort_point_add(a : SorthybridintrosortPoint, b : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_hybrid_introsort_point_sub(a : SorthybridintrosortPoint, b : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_hybrid_introsort_point_scale(pt : SorthybridintrosortPoint, s : Double) -> SorthybridintrosortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_hybrid_introsort_point_dot(a : SorthybridintrosortPoint, b : SorthybridintrosortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_hybrid_introsort_point_cross(a : SorthybridintrosortPoint, b : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_hybrid_introsort_point_norm(pt : SorthybridintrosortPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_hybrid_introsort_point_normalize(pt : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  let n = sort_hybrid_introsort_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_hybrid_introsort_point_scale(pt, 1.0 / n) }
}

pub fn sort_hybrid_introsort_point_negate(pt : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_hybrid_introsort_point_mid(a : SorthybridintrosortPoint, b : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_hybrid_introsort_point_lerp(a : SorthybridintrosortPoint, b : SorthybridintrosortPoint, t : Double) -> SorthybridintrosortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_hybrid_introsort_point_to_string(pt : SorthybridintrosortPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SorthybridintrosortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_introsort_make_series(vals : Array[Double], name : String) -> SorthybridintrosortSeries {
  { vals, name, meta: 0 }
}

pub fn sort_hybrid_introsort_series_len(s : SorthybridintrosortSeries) -> Int { s.vals.length() }

pub fn sort_hybrid_introsort_series_sum(s : SorthybridintrosortSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_hybrid_introsort_series_mean(s : SorthybridintrosortSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_hybrid_introsort_series_min(s : SorthybridintrosortSeries) -> Double { @_common.min(s.vals) }

pub fn sort_hybrid_introsort_series_max(s : SorthybridintrosortSeries) -> Double { @_common.max(s.vals) }

pub fn sort_hybrid_introsort_series_range(s : SorthybridintrosortSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_hybrid_introsort_series_var(s : SorthybridintrosortSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_hybrid_introsort_series_std(s : SorthybridintrosortSeries) -> Double { @_common.std(s.vals) }

pub fn sort_hybrid_introsort_series_median(s : SorthybridintrosortSeries) -> Double { @_common.median(s.vals) }

pub fn sort_hybrid_introsort_series_scale(s : SorthybridintrosortSeries, f : Double) -> SorthybridintrosortSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_hybrid_introsort_series_add(a : SorthybridintrosortSeries, b : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_hybrid_introsort_series_sub(a : SorthybridintrosortSeries, b : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_hybrid_introsort_series_normalize(s : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  let mn = sort_hybrid_introsort_series_min(s)
  let mx = sort_hybrid_introsort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_hybrid_introsort_series_cumsum(s : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_hybrid_introsort_series_to_string(s : SorthybridintrosortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridintrosortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_introsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridintrosortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_introsort_matrix_identity(n : Int) -> SorthybridintrosortMatrix {
  let m = sort_hybrid_introsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_hybrid_introsort_matrix_get(m : SorthybridintrosortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_hybrid_introsort_matrix_transpose(m : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  let result = sort_hybrid_introsort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_hybrid_introsort_matrix_add(a : SorthybridintrosortMatrix, b : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_hybrid_introsort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_hybrid_introsort_matrix_scale(m : SorthybridintrosortMatrix, s : Double) -> SorthybridintrosortMatrix {
  let result = sort_hybrid_introsort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_hybrid_introsort_matrix_multiply(a : SorthybridintrosortMatrix, b : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  if a.cols != b.rows { return sort_hybrid_introsort_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_hybrid_introsort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_hybrid_introsort_matrix_trace(m : SorthybridintrosortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_hybrid_introsort_matrix_det(m : SorthybridintrosortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_hybrid_introsort_matrix_norm(m : SorthybridintrosortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_hybrid_introsort_matrix_to_string(m : SorthybridintrosortMatrix) -> String {
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

pub(all) struct SorthybridintrosortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_introsort_make_vector(comps : Array[Double]) -> SorthybridintrosortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_introsort_vector_zero(dim : Int) -> SorthybridintrosortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_hybrid_introsort_vector_add(a : SorthybridintrosortVector, b : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_introsort_vector_sub(a : SorthybridintrosortVector, b : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_introsort_vector_scale(v : SorthybridintrosortVector, s : Double) -> SorthybridintrosortVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_hybrid_introsort_vector_dot(a : SorthybridintrosortVector, b : SorthybridintrosortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_hybrid_introsort_vector_norm(v : SorthybridintrosortVector) -> Double { @_common.sqrt(sort_hybrid_introsort_vector_dot(v, v)) }

pub fn sort_hybrid_introsort_vector_normalize(v : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = sort_hybrid_introsort_vector_norm(v)
  if n < 0.0000001 { v } else { sort_hybrid_introsort_vector_scale(v, 1.0 / n) }
}

pub fn sort_hybrid_introsort_vector_dist(a : SorthybridintrosortVector, b : SorthybridintrosortVector) -> Double {
  sort_hybrid_introsort_vector_norm(sort_hybrid_introsort_vector_sub(a, b))
}

pub fn sort_hybrid_introsort_vector_to_string(v : SorthybridintrosortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_introsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_introsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_introsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_introsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_introsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_introsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_introsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_introsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_introsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_introsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_introsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_introsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_introsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_introsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_introsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_introsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_introsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_introsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_introsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_introsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_introsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_introsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_introsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_introsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_introsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_introsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_introsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_introsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_introsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridintrosortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_frame_make(size : Int) -> SorthybridintrosortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_frame_len(s : SorthybridintrosortFrame) -> Int { s.size }

pub fn sort_hybrid_introsort_frame_get(s : SorthybridintrosortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_frame_set(s : SorthybridintrosortFrame, i : Int, v : Double) -> SorthybridintrosortFrame {
  let result = sort_hybrid_introsort_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_frame_sum(s : SorthybridintrosortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_frame_mean(s : SorthybridintrosortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_frame_scale(s : SorthybridintrosortFrame, f : Double) -> SorthybridintrosortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_frame_add(a : SorthybridintrosortFrame, b : SorthybridintrosortFrame) -> SorthybridintrosortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_frame_copy(s : SorthybridintrosortFrame) -> SorthybridintrosortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_frame_fill(s : SorthybridintrosortFrame, v : Double) -> SorthybridintrosortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_frame_min(s : SorthybridintrosortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_frame_max(s : SorthybridintrosortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_frame_to_string(s : SorthybridintrosortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_table_make(size : Int) -> SorthybridintrosortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_table_len(s : SorthybridintrosortTable) -> Int { s.size }

pub fn sort_hybrid_introsort_table_get(s : SorthybridintrosortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_table_set(s : SorthybridintrosortTable, i : Int, v : Double) -> SorthybridintrosortTable {
  let result = sort_hybrid_introsort_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_table_sum(s : SorthybridintrosortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_table_mean(s : SorthybridintrosortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_table_scale(s : SorthybridintrosortTable, f : Double) -> SorthybridintrosortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_table_add(a : SorthybridintrosortTable, b : SorthybridintrosortTable) -> SorthybridintrosortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_table_copy(s : SorthybridintrosortTable) -> SorthybridintrosortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_table_fill(s : SorthybridintrosortTable, v : Double) -> SorthybridintrosortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_table_min(s : SorthybridintrosortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_table_max(s : SorthybridintrosortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_table_to_string(s : SorthybridintrosortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_graphn_make(size : Int) -> SorthybridintrosortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_graphn_len(s : SorthybridintrosortGraphN) -> Int { s.size }

pub fn sort_hybrid_introsort_graphn_get(s : SorthybridintrosortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_graphn_set(s : SorthybridintrosortGraphN, i : Int, v : Double) -> SorthybridintrosortGraphN {
  let result = sort_hybrid_introsort_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_graphn_sum(s : SorthybridintrosortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_graphn_mean(s : SorthybridintrosortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_graphn_scale(s : SorthybridintrosortGraphN, f : Double) -> SorthybridintrosortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_graphn_add(a : SorthybridintrosortGraphN, b : SorthybridintrosortGraphN) -> SorthybridintrosortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_graphn_copy(s : SorthybridintrosortGraphN) -> SorthybridintrosortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_graphn_fill(s : SorthybridintrosortGraphN, v : Double) -> SorthybridintrosortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_graphn_min(s : SorthybridintrosortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_graphn_max(s : SorthybridintrosortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_graphn_to_string(s : SorthybridintrosortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_node_make(size : Int) -> SorthybridintrosortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_node_len(s : SorthybridintrosortNode) -> Int { s.size }

pub fn sort_hybrid_introsort_node_get(s : SorthybridintrosortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_node_set(s : SorthybridintrosortNode, i : Int, v : Double) -> SorthybridintrosortNode {
  let result = sort_hybrid_introsort_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_node_sum(s : SorthybridintrosortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_node_mean(s : SorthybridintrosortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_node_scale(s : SorthybridintrosortNode, f : Double) -> SorthybridintrosortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_node_add(a : SorthybridintrosortNode, b : SorthybridintrosortNode) -> SorthybridintrosortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_node_copy(s : SorthybridintrosortNode) -> SorthybridintrosortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_node_fill(s : SorthybridintrosortNode, v : Double) -> SorthybridintrosortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_node_min(s : SorthybridintrosortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_node_max(s : SorthybridintrosortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_node_to_string(s : SorthybridintrosortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_edge_make(size : Int) -> SorthybridintrosortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_edge_len(s : SorthybridintrosortEdge) -> Int { s.size }

pub fn sort_hybrid_introsort_edge_get(s : SorthybridintrosortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_edge_set(s : SorthybridintrosortEdge, i : Int, v : Double) -> SorthybridintrosortEdge {
  let result = sort_hybrid_introsort_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_edge_sum(s : SorthybridintrosortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_edge_mean(s : SorthybridintrosortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_edge_scale(s : SorthybridintrosortEdge, f : Double) -> SorthybridintrosortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_edge_add(a : SorthybridintrosortEdge, b : SorthybridintrosortEdge) -> SorthybridintrosortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_edge_copy(s : SorthybridintrosortEdge) -> SorthybridintrosortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_edge_fill(s : SorthybridintrosortEdge, v : Double) -> SorthybridintrosortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_edge_min(s : SorthybridintrosortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_edge_max(s : SorthybridintrosortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_edge_to_string(s : SorthybridintrosortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_path_make(size : Int) -> SorthybridintrosortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_path_len(s : SorthybridintrosortPath) -> Int { s.size }

pub fn sort_hybrid_introsort_path_get(s : SorthybridintrosortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_path_set(s : SorthybridintrosortPath, i : Int, v : Double) -> SorthybridintrosortPath {
  let result = sort_hybrid_introsort_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_path_sum(s : SorthybridintrosortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_path_mean(s : SorthybridintrosortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_path_scale(s : SorthybridintrosortPath, f : Double) -> SorthybridintrosortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_path_add(a : SorthybridintrosortPath, b : SorthybridintrosortPath) -> SorthybridintrosortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_path_copy(s : SorthybridintrosortPath) -> SorthybridintrosortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_path_fill(s : SorthybridintrosortPath, v : Double) -> SorthybridintrosortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_path_min(s : SorthybridintrosortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_path_max(s : SorthybridintrosortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_path_to_string(s : SorthybridintrosortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_cluster_make(size : Int) -> SorthybridintrosortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_cluster_len(s : SorthybridintrosortCluster) -> Int { s.size }

pub fn sort_hybrid_introsort_cluster_get(s : SorthybridintrosortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_cluster_set(s : SorthybridintrosortCluster, i : Int, v : Double) -> SorthybridintrosortCluster {
  let result = sort_hybrid_introsort_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_cluster_sum(s : SorthybridintrosortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_cluster_mean(s : SorthybridintrosortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_cluster_scale(s : SorthybridintrosortCluster, f : Double) -> SorthybridintrosortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cluster_add(a : SorthybridintrosortCluster, b : SorthybridintrosortCluster) -> SorthybridintrosortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_cluster_copy(s : SorthybridintrosortCluster) -> SorthybridintrosortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cluster_fill(s : SorthybridintrosortCluster, v : Double) -> SorthybridintrosortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cluster_min(s : SorthybridintrosortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_cluster_max(s : SorthybridintrosortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_cluster_to_string(s : SorthybridintrosortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_model_make(size : Int) -> SorthybridintrosortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_model_len(s : SorthybridintrosortModel) -> Int { s.size }

pub fn sort_hybrid_introsort_model_get(s : SorthybridintrosortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_model_set(s : SorthybridintrosortModel, i : Int, v : Double) -> SorthybridintrosortModel {
  let result = sort_hybrid_introsort_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_model_sum(s : SorthybridintrosortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_model_mean(s : SorthybridintrosortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_model_scale(s : SorthybridintrosortModel, f : Double) -> SorthybridintrosortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_model_add(a : SorthybridintrosortModel, b : SorthybridintrosortModel) -> SorthybridintrosortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_model_copy(s : SorthybridintrosortModel) -> SorthybridintrosortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_model_fill(s : SorthybridintrosortModel, v : Double) -> SorthybridintrosortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_model_min(s : SorthybridintrosortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_model_max(s : SorthybridintrosortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_model_to_string(s : SorthybridintrosortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_layer_make(size : Int) -> SorthybridintrosortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_layer_len(s : SorthybridintrosortLayer) -> Int { s.size }

pub fn sort_hybrid_introsort_layer_get(s : SorthybridintrosortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_layer_set(s : SorthybridintrosortLayer, i : Int, v : Double) -> SorthybridintrosortLayer {
  let result = sort_hybrid_introsort_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_layer_sum(s : SorthybridintrosortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_layer_mean(s : SorthybridintrosortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_layer_scale(s : SorthybridintrosortLayer, f : Double) -> SorthybridintrosortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_layer_add(a : SorthybridintrosortLayer, b : SorthybridintrosortLayer) -> SorthybridintrosortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_layer_copy(s : SorthybridintrosortLayer) -> SorthybridintrosortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_layer_fill(s : SorthybridintrosortLayer, v : Double) -> SorthybridintrosortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_layer_min(s : SorthybridintrosortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_layer_max(s : SorthybridintrosortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_layer_to_string(s : SorthybridintrosortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_buffer_make(size : Int) -> SorthybridintrosortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_buffer_len(s : SorthybridintrosortBuffer) -> Int { s.size }

pub fn sort_hybrid_introsort_buffer_get(s : SorthybridintrosortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_buffer_set(s : SorthybridintrosortBuffer, i : Int, v : Double) -> SorthybridintrosortBuffer {
  let result = sort_hybrid_introsort_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_buffer_sum(s : SorthybridintrosortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_buffer_mean(s : SorthybridintrosortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_buffer_scale(s : SorthybridintrosortBuffer, f : Double) -> SorthybridintrosortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_buffer_add(a : SorthybridintrosortBuffer, b : SorthybridintrosortBuffer) -> SorthybridintrosortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_buffer_copy(s : SorthybridintrosortBuffer) -> SorthybridintrosortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_buffer_fill(s : SorthybridintrosortBuffer, v : Double) -> SorthybridintrosortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_buffer_min(s : SorthybridintrosortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_buffer_max(s : SorthybridintrosortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_buffer_to_string(s : SorthybridintrosortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_cursor_make(size : Int) -> SorthybridintrosortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_cursor_len(s : SorthybridintrosortCursor) -> Int { s.size }

pub fn sort_hybrid_introsort_cursor_get(s : SorthybridintrosortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_cursor_set(s : SorthybridintrosortCursor, i : Int, v : Double) -> SorthybridintrosortCursor {
  let result = sort_hybrid_introsort_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_cursor_sum(s : SorthybridintrosortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_cursor_mean(s : SorthybridintrosortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_cursor_scale(s : SorthybridintrosortCursor, f : Double) -> SorthybridintrosortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cursor_add(a : SorthybridintrosortCursor, b : SorthybridintrosortCursor) -> SorthybridintrosortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_cursor_copy(s : SorthybridintrosortCursor) -> SorthybridintrosortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cursor_fill(s : SorthybridintrosortCursor, v : Double) -> SorthybridintrosortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cursor_min(s : SorthybridintrosortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_cursor_max(s : SorthybridintrosortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_cursor_to_string(s : SorthybridintrosortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_view_make(size : Int) -> SorthybridintrosortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_view_len(s : SorthybridintrosortView) -> Int { s.size }

pub fn sort_hybrid_introsort_view_get(s : SorthybridintrosortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_view_set(s : SorthybridintrosortView, i : Int, v : Double) -> SorthybridintrosortView {
  let result = sort_hybrid_introsort_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_view_sum(s : SorthybridintrosortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_view_mean(s : SorthybridintrosortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_view_scale(s : SorthybridintrosortView, f : Double) -> SorthybridintrosortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_view_add(a : SorthybridintrosortView, b : SorthybridintrosortView) -> SorthybridintrosortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_view_copy(s : SorthybridintrosortView) -> SorthybridintrosortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_view_fill(s : SorthybridintrosortView, v : Double) -> SorthybridintrosortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_view_min(s : SorthybridintrosortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_view_max(s : SorthybridintrosortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_view_to_string(s : SorthybridintrosortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_range_make(size : Int) -> SorthybridintrosortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_range_len(s : SorthybridintrosortRange) -> Int { s.size }

pub fn sort_hybrid_introsort_range_get(s : SorthybridintrosortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_range_set(s : SorthybridintrosortRange, i : Int, v : Double) -> SorthybridintrosortRange {
  let result = sort_hybrid_introsort_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_range_sum(s : SorthybridintrosortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_range_mean(s : SorthybridintrosortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_range_scale(s : SorthybridintrosortRange, f : Double) -> SorthybridintrosortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_range_add(a : SorthybridintrosortRange, b : SorthybridintrosortRange) -> SorthybridintrosortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_range_copy(s : SorthybridintrosortRange) -> SorthybridintrosortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_range_fill(s : SorthybridintrosortRange, v : Double) -> SorthybridintrosortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_range_min(s : SorthybridintrosortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_range_max(s : SorthybridintrosortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_range_to_string(s : SorthybridintrosortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_slice_make(size : Int) -> SorthybridintrosortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_slice_len(s : SorthybridintrosortSlice) -> Int { s.size }

pub fn sort_hybrid_introsort_slice_get(s : SorthybridintrosortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_slice_set(s : SorthybridintrosortSlice, i : Int, v : Double) -> SorthybridintrosortSlice {
  let result = sort_hybrid_introsort_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_introsort_slice_sum(s : SorthybridintrosortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_slice_mean(s : SorthybridintrosortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_slice_scale(s : SorthybridintrosortSlice, f : Double) -> SorthybridintrosortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_slice_add(a : SorthybridintrosortSlice, b : SorthybridintrosortSlice) -> SorthybridintrosortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_slice_copy(s : SorthybridintrosortSlice) -> SorthybridintrosortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_slice_fill(s : SorthybridintrosortSlice, v : Double) -> SorthybridintrosortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_slice_min(s : SorthybridintrosortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_slice_max(s : SorthybridintrosortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_slice_to_string(s : SorthybridintrosortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

