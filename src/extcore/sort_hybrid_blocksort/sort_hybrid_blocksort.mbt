///===
/// extcore/sort_hybrid_blocksort

pub(all) struct SorthybridblocksortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_blocksort_make_point(x : Double, y : Double) -> SorthybridblocksortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_blocksort_make_point3(x : Double, y : Double, z : Double) -> SorthybridblocksortPoint {
  { x, y, z, label: 0 }
}

pub fn sort_hybrid_blocksort_point_x(pt : SorthybridblocksortPoint) -> Double { pt.x }

pub fn sort_hybrid_blocksort_point_y(pt : SorthybridblocksortPoint) -> Double { pt.y }

pub fn sort_hybrid_blocksort_point_z(pt : SorthybridblocksortPoint) -> Double { pt.z }

pub fn sort_hybrid_blocksort_point_label(pt : SorthybridblocksortPoint) -> Int { pt.label }

pub fn sort_hybrid_blocksort_point_dist(a : SorthybridblocksortPoint, b : SorthybridblocksortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_hybrid_blocksort_point_add(a : SorthybridblocksortPoint, b : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_hybrid_blocksort_point_sub(a : SorthybridblocksortPoint, b : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_hybrid_blocksort_point_scale(pt : SorthybridblocksortPoint, s : Double) -> SorthybridblocksortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_hybrid_blocksort_point_dot(a : SorthybridblocksortPoint, b : SorthybridblocksortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_hybrid_blocksort_point_cross(a : SorthybridblocksortPoint, b : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_hybrid_blocksort_point_norm(pt : SorthybridblocksortPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_hybrid_blocksort_point_normalize(pt : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  let n = sort_hybrid_blocksort_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_hybrid_blocksort_point_scale(pt, 1.0 / n) }
}

pub fn sort_hybrid_blocksort_point_negate(pt : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_hybrid_blocksort_point_mid(a : SorthybridblocksortPoint, b : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_hybrid_blocksort_point_lerp(a : SorthybridblocksortPoint, b : SorthybridblocksortPoint, t : Double) -> SorthybridblocksortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_hybrid_blocksort_point_to_string(pt : SorthybridblocksortPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SorthybridblocksortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_blocksort_make_series(vals : Array[Double], name : String) -> SorthybridblocksortSeries {
  { vals, name, meta: 0 }
}

pub fn sort_hybrid_blocksort_series_len(s : SorthybridblocksortSeries) -> Int { s.vals.length() }

pub fn sort_hybrid_blocksort_series_sum(s : SorthybridblocksortSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_hybrid_blocksort_series_mean(s : SorthybridblocksortSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_hybrid_blocksort_series_min(s : SorthybridblocksortSeries) -> Double { @_common.min(s.vals) }

pub fn sort_hybrid_blocksort_series_max(s : SorthybridblocksortSeries) -> Double { @_common.max(s.vals) }

pub fn sort_hybrid_blocksort_series_range(s : SorthybridblocksortSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_hybrid_blocksort_series_var(s : SorthybridblocksortSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_hybrid_blocksort_series_std(s : SorthybridblocksortSeries) -> Double { @_common.std(s.vals) }

pub fn sort_hybrid_blocksort_series_median(s : SorthybridblocksortSeries) -> Double { @_common.median(s.vals) }

pub fn sort_hybrid_blocksort_series_scale(s : SorthybridblocksortSeries, f : Double) -> SorthybridblocksortSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_hybrid_blocksort_series_add(a : SorthybridblocksortSeries, b : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_hybrid_blocksort_series_sub(a : SorthybridblocksortSeries, b : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_hybrid_blocksort_series_normalize(s : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  let mn = sort_hybrid_blocksort_series_min(s)
  let mx = sort_hybrid_blocksort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_hybrid_blocksort_series_cumsum(s : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_hybrid_blocksort_series_to_string(s : SorthybridblocksortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridblocksortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_blocksort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridblocksortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_blocksort_matrix_identity(n : Int) -> SorthybridblocksortMatrix {
  let m = sort_hybrid_blocksort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_hybrid_blocksort_matrix_get(m : SorthybridblocksortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_hybrid_blocksort_matrix_transpose(m : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  let result = sort_hybrid_blocksort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_hybrid_blocksort_matrix_add(a : SorthybridblocksortMatrix, b : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_hybrid_blocksort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_hybrid_blocksort_matrix_scale(m : SorthybridblocksortMatrix, s : Double) -> SorthybridblocksortMatrix {
  let result = sort_hybrid_blocksort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_hybrid_blocksort_matrix_multiply(a : SorthybridblocksortMatrix, b : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  if a.cols != b.rows { return sort_hybrid_blocksort_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_hybrid_blocksort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_hybrid_blocksort_matrix_trace(m : SorthybridblocksortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_hybrid_blocksort_matrix_det(m : SorthybridblocksortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_hybrid_blocksort_matrix_norm(m : SorthybridblocksortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_hybrid_blocksort_matrix_to_string(m : SorthybridblocksortMatrix) -> String {
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

pub(all) struct SorthybridblocksortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_blocksort_make_vector(comps : Array[Double]) -> SorthybridblocksortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_blocksort_vector_zero(dim : Int) -> SorthybridblocksortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_hybrid_blocksort_vector_add(a : SorthybridblocksortVector, b : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_blocksort_vector_sub(a : SorthybridblocksortVector, b : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_blocksort_vector_scale(v : SorthybridblocksortVector, s : Double) -> SorthybridblocksortVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_hybrid_blocksort_vector_dot(a : SorthybridblocksortVector, b : SorthybridblocksortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_hybrid_blocksort_vector_norm(v : SorthybridblocksortVector) -> Double { @_common.sqrt(sort_hybrid_blocksort_vector_dot(v, v)) }

pub fn sort_hybrid_blocksort_vector_normalize(v : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = sort_hybrid_blocksort_vector_norm(v)
  if n < 0.0000001 { v } else { sort_hybrid_blocksort_vector_scale(v, 1.0 / n) }
}

pub fn sort_hybrid_blocksort_vector_dist(a : SorthybridblocksortVector, b : SorthybridblocksortVector) -> Double {
  sort_hybrid_blocksort_vector_norm(sort_hybrid_blocksort_vector_sub(a, b))
}

pub fn sort_hybrid_blocksort_vector_to_string(v : SorthybridblocksortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_blocksort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_blocksort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_blocksort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_blocksort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_blocksort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_blocksort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_blocksort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_blocksort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_blocksort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_blocksort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_blocksort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_blocksort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_blocksort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_blocksort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_blocksort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_blocksort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_blocksort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_blocksort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_blocksort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_blocksort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_blocksort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_blocksort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_blocksort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_blocksort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_blocksort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_blocksort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_blocksort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_blocksort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_blocksort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridblocksortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_frame_make(size : Int) -> SorthybridblocksortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_frame_len(s : SorthybridblocksortFrame) -> Int { s.size }

pub fn sort_hybrid_blocksort_frame_get(s : SorthybridblocksortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_frame_set(s : SorthybridblocksortFrame, i : Int, v : Double) -> SorthybridblocksortFrame {
  let result = sort_hybrid_blocksort_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_frame_sum(s : SorthybridblocksortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_frame_mean(s : SorthybridblocksortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_frame_scale(s : SorthybridblocksortFrame, f : Double) -> SorthybridblocksortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_frame_add(a : SorthybridblocksortFrame, b : SorthybridblocksortFrame) -> SorthybridblocksortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_frame_copy(s : SorthybridblocksortFrame) -> SorthybridblocksortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_frame_fill(s : SorthybridblocksortFrame, v : Double) -> SorthybridblocksortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_frame_min(s : SorthybridblocksortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_frame_max(s : SorthybridblocksortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_frame_to_string(s : SorthybridblocksortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_table_make(size : Int) -> SorthybridblocksortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_table_len(s : SorthybridblocksortTable) -> Int { s.size }

pub fn sort_hybrid_blocksort_table_get(s : SorthybridblocksortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_table_set(s : SorthybridblocksortTable, i : Int, v : Double) -> SorthybridblocksortTable {
  let result = sort_hybrid_blocksort_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_table_sum(s : SorthybridblocksortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_table_mean(s : SorthybridblocksortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_table_scale(s : SorthybridblocksortTable, f : Double) -> SorthybridblocksortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_table_add(a : SorthybridblocksortTable, b : SorthybridblocksortTable) -> SorthybridblocksortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_table_copy(s : SorthybridblocksortTable) -> SorthybridblocksortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_table_fill(s : SorthybridblocksortTable, v : Double) -> SorthybridblocksortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_table_min(s : SorthybridblocksortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_table_max(s : SorthybridblocksortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_table_to_string(s : SorthybridblocksortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_graphn_make(size : Int) -> SorthybridblocksortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_graphn_len(s : SorthybridblocksortGraphN) -> Int { s.size }

pub fn sort_hybrid_blocksort_graphn_get(s : SorthybridblocksortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_graphn_set(s : SorthybridblocksortGraphN, i : Int, v : Double) -> SorthybridblocksortGraphN {
  let result = sort_hybrid_blocksort_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_graphn_sum(s : SorthybridblocksortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_graphn_mean(s : SorthybridblocksortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_graphn_scale(s : SorthybridblocksortGraphN, f : Double) -> SorthybridblocksortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_graphn_add(a : SorthybridblocksortGraphN, b : SorthybridblocksortGraphN) -> SorthybridblocksortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_graphn_copy(s : SorthybridblocksortGraphN) -> SorthybridblocksortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_graphn_fill(s : SorthybridblocksortGraphN, v : Double) -> SorthybridblocksortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_graphn_min(s : SorthybridblocksortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_graphn_max(s : SorthybridblocksortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_graphn_to_string(s : SorthybridblocksortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_node_make(size : Int) -> SorthybridblocksortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_node_len(s : SorthybridblocksortNode) -> Int { s.size }

pub fn sort_hybrid_blocksort_node_get(s : SorthybridblocksortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_node_set(s : SorthybridblocksortNode, i : Int, v : Double) -> SorthybridblocksortNode {
  let result = sort_hybrid_blocksort_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_node_sum(s : SorthybridblocksortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_node_mean(s : SorthybridblocksortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_node_scale(s : SorthybridblocksortNode, f : Double) -> SorthybridblocksortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_node_add(a : SorthybridblocksortNode, b : SorthybridblocksortNode) -> SorthybridblocksortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_node_copy(s : SorthybridblocksortNode) -> SorthybridblocksortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_node_fill(s : SorthybridblocksortNode, v : Double) -> SorthybridblocksortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_node_min(s : SorthybridblocksortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_node_max(s : SorthybridblocksortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_node_to_string(s : SorthybridblocksortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_edge_make(size : Int) -> SorthybridblocksortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_edge_len(s : SorthybridblocksortEdge) -> Int { s.size }

pub fn sort_hybrid_blocksort_edge_get(s : SorthybridblocksortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_edge_set(s : SorthybridblocksortEdge, i : Int, v : Double) -> SorthybridblocksortEdge {
  let result = sort_hybrid_blocksort_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_edge_sum(s : SorthybridblocksortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_edge_mean(s : SorthybridblocksortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_edge_scale(s : SorthybridblocksortEdge, f : Double) -> SorthybridblocksortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_edge_add(a : SorthybridblocksortEdge, b : SorthybridblocksortEdge) -> SorthybridblocksortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_edge_copy(s : SorthybridblocksortEdge) -> SorthybridblocksortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_edge_fill(s : SorthybridblocksortEdge, v : Double) -> SorthybridblocksortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_edge_min(s : SorthybridblocksortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_edge_max(s : SorthybridblocksortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_edge_to_string(s : SorthybridblocksortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_path_make(size : Int) -> SorthybridblocksortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_path_len(s : SorthybridblocksortPath) -> Int { s.size }

pub fn sort_hybrid_blocksort_path_get(s : SorthybridblocksortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_path_set(s : SorthybridblocksortPath, i : Int, v : Double) -> SorthybridblocksortPath {
  let result = sort_hybrid_blocksort_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_path_sum(s : SorthybridblocksortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_path_mean(s : SorthybridblocksortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_path_scale(s : SorthybridblocksortPath, f : Double) -> SorthybridblocksortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_path_add(a : SorthybridblocksortPath, b : SorthybridblocksortPath) -> SorthybridblocksortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_path_copy(s : SorthybridblocksortPath) -> SorthybridblocksortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_path_fill(s : SorthybridblocksortPath, v : Double) -> SorthybridblocksortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_path_min(s : SorthybridblocksortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_path_max(s : SorthybridblocksortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_path_to_string(s : SorthybridblocksortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_cluster_make(size : Int) -> SorthybridblocksortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_cluster_len(s : SorthybridblocksortCluster) -> Int { s.size }

pub fn sort_hybrid_blocksort_cluster_get(s : SorthybridblocksortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_cluster_set(s : SorthybridblocksortCluster, i : Int, v : Double) -> SorthybridblocksortCluster {
  let result = sort_hybrid_blocksort_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_cluster_sum(s : SorthybridblocksortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_cluster_mean(s : SorthybridblocksortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_cluster_scale(s : SorthybridblocksortCluster, f : Double) -> SorthybridblocksortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cluster_add(a : SorthybridblocksortCluster, b : SorthybridblocksortCluster) -> SorthybridblocksortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_cluster_copy(s : SorthybridblocksortCluster) -> SorthybridblocksortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cluster_fill(s : SorthybridblocksortCluster, v : Double) -> SorthybridblocksortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cluster_min(s : SorthybridblocksortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_cluster_max(s : SorthybridblocksortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_cluster_to_string(s : SorthybridblocksortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_model_make(size : Int) -> SorthybridblocksortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_model_len(s : SorthybridblocksortModel) -> Int { s.size }

pub fn sort_hybrid_blocksort_model_get(s : SorthybridblocksortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_model_set(s : SorthybridblocksortModel, i : Int, v : Double) -> SorthybridblocksortModel {
  let result = sort_hybrid_blocksort_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_model_sum(s : SorthybridblocksortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_model_mean(s : SorthybridblocksortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_model_scale(s : SorthybridblocksortModel, f : Double) -> SorthybridblocksortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_model_add(a : SorthybridblocksortModel, b : SorthybridblocksortModel) -> SorthybridblocksortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_model_copy(s : SorthybridblocksortModel) -> SorthybridblocksortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_model_fill(s : SorthybridblocksortModel, v : Double) -> SorthybridblocksortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_model_min(s : SorthybridblocksortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_model_max(s : SorthybridblocksortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_model_to_string(s : SorthybridblocksortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_layer_make(size : Int) -> SorthybridblocksortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_layer_len(s : SorthybridblocksortLayer) -> Int { s.size }

pub fn sort_hybrid_blocksort_layer_get(s : SorthybridblocksortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_layer_set(s : SorthybridblocksortLayer, i : Int, v : Double) -> SorthybridblocksortLayer {
  let result = sort_hybrid_blocksort_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_layer_sum(s : SorthybridblocksortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_layer_mean(s : SorthybridblocksortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_layer_scale(s : SorthybridblocksortLayer, f : Double) -> SorthybridblocksortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_layer_add(a : SorthybridblocksortLayer, b : SorthybridblocksortLayer) -> SorthybridblocksortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_layer_copy(s : SorthybridblocksortLayer) -> SorthybridblocksortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_layer_fill(s : SorthybridblocksortLayer, v : Double) -> SorthybridblocksortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_layer_min(s : SorthybridblocksortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_layer_max(s : SorthybridblocksortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_layer_to_string(s : SorthybridblocksortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_buffer_make(size : Int) -> SorthybridblocksortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_buffer_len(s : SorthybridblocksortBuffer) -> Int { s.size }

pub fn sort_hybrid_blocksort_buffer_get(s : SorthybridblocksortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_buffer_set(s : SorthybridblocksortBuffer, i : Int, v : Double) -> SorthybridblocksortBuffer {
  let result = sort_hybrid_blocksort_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_buffer_sum(s : SorthybridblocksortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_buffer_mean(s : SorthybridblocksortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_buffer_scale(s : SorthybridblocksortBuffer, f : Double) -> SorthybridblocksortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_buffer_add(a : SorthybridblocksortBuffer, b : SorthybridblocksortBuffer) -> SorthybridblocksortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_buffer_copy(s : SorthybridblocksortBuffer) -> SorthybridblocksortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_buffer_fill(s : SorthybridblocksortBuffer, v : Double) -> SorthybridblocksortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_buffer_min(s : SorthybridblocksortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_buffer_max(s : SorthybridblocksortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_buffer_to_string(s : SorthybridblocksortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_cursor_make(size : Int) -> SorthybridblocksortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_cursor_len(s : SorthybridblocksortCursor) -> Int { s.size }

pub fn sort_hybrid_blocksort_cursor_get(s : SorthybridblocksortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_cursor_set(s : SorthybridblocksortCursor, i : Int, v : Double) -> SorthybridblocksortCursor {
  let result = sort_hybrid_blocksort_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_cursor_sum(s : SorthybridblocksortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_cursor_mean(s : SorthybridblocksortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_cursor_scale(s : SorthybridblocksortCursor, f : Double) -> SorthybridblocksortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cursor_add(a : SorthybridblocksortCursor, b : SorthybridblocksortCursor) -> SorthybridblocksortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_cursor_copy(s : SorthybridblocksortCursor) -> SorthybridblocksortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cursor_fill(s : SorthybridblocksortCursor, v : Double) -> SorthybridblocksortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cursor_min(s : SorthybridblocksortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_cursor_max(s : SorthybridblocksortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_cursor_to_string(s : SorthybridblocksortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_view_make(size : Int) -> SorthybridblocksortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_view_len(s : SorthybridblocksortView) -> Int { s.size }

pub fn sort_hybrid_blocksort_view_get(s : SorthybridblocksortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_view_set(s : SorthybridblocksortView, i : Int, v : Double) -> SorthybridblocksortView {
  let result = sort_hybrid_blocksort_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_view_sum(s : SorthybridblocksortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_view_mean(s : SorthybridblocksortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_view_scale(s : SorthybridblocksortView, f : Double) -> SorthybridblocksortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_view_add(a : SorthybridblocksortView, b : SorthybridblocksortView) -> SorthybridblocksortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_view_copy(s : SorthybridblocksortView) -> SorthybridblocksortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_view_fill(s : SorthybridblocksortView, v : Double) -> SorthybridblocksortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_view_min(s : SorthybridblocksortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_view_max(s : SorthybridblocksortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_view_to_string(s : SorthybridblocksortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_range_make(size : Int) -> SorthybridblocksortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_range_len(s : SorthybridblocksortRange) -> Int { s.size }

pub fn sort_hybrid_blocksort_range_get(s : SorthybridblocksortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_range_set(s : SorthybridblocksortRange, i : Int, v : Double) -> SorthybridblocksortRange {
  let result = sort_hybrid_blocksort_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_range_sum(s : SorthybridblocksortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_range_mean(s : SorthybridblocksortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_range_scale(s : SorthybridblocksortRange, f : Double) -> SorthybridblocksortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_range_add(a : SorthybridblocksortRange, b : SorthybridblocksortRange) -> SorthybridblocksortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_range_copy(s : SorthybridblocksortRange) -> SorthybridblocksortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_range_fill(s : SorthybridblocksortRange, v : Double) -> SorthybridblocksortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_range_min(s : SorthybridblocksortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_range_max(s : SorthybridblocksortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_range_to_string(s : SorthybridblocksortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_slice_make(size : Int) -> SorthybridblocksortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_slice_len(s : SorthybridblocksortSlice) -> Int { s.size }

pub fn sort_hybrid_blocksort_slice_get(s : SorthybridblocksortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_slice_set(s : SorthybridblocksortSlice, i : Int, v : Double) -> SorthybridblocksortSlice {
  let result = sort_hybrid_blocksort_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_blocksort_slice_sum(s : SorthybridblocksortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_slice_mean(s : SorthybridblocksortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_slice_scale(s : SorthybridblocksortSlice, f : Double) -> SorthybridblocksortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_slice_add(a : SorthybridblocksortSlice, b : SorthybridblocksortSlice) -> SorthybridblocksortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_slice_copy(s : SorthybridblocksortSlice) -> SorthybridblocksortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_slice_fill(s : SorthybridblocksortSlice, v : Double) -> SorthybridblocksortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_slice_min(s : SorthybridblocksortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_slice_max(s : SorthybridblocksortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_slice_to_string(s : SorthybridblocksortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

