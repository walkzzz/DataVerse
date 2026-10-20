///===
/// extcore/sort_hybrid_dropsort

pub(all) struct SorthybriddropsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_dropsort_make_point(x : Double, y : Double) -> SorthybriddropsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_dropsort_make_point3(x : Double, y : Double, z : Double) -> SorthybriddropsortPoint {
  { x, y, z, label: 0 }
}

pub fn sort_hybrid_dropsort_point_x(pt : SorthybriddropsortPoint) -> Double { pt.x }

pub fn sort_hybrid_dropsort_point_y(pt : SorthybriddropsortPoint) -> Double { pt.y }

pub fn sort_hybrid_dropsort_point_z(pt : SorthybriddropsortPoint) -> Double { pt.z }

pub fn sort_hybrid_dropsort_point_label(pt : SorthybriddropsortPoint) -> Int { pt.label }

pub fn sort_hybrid_dropsort_point_dist(a : SorthybriddropsortPoint, b : SorthybriddropsortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_hybrid_dropsort_point_add(a : SorthybriddropsortPoint, b : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_hybrid_dropsort_point_sub(a : SorthybriddropsortPoint, b : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_hybrid_dropsort_point_scale(pt : SorthybriddropsortPoint, s : Double) -> SorthybriddropsortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_hybrid_dropsort_point_dot(a : SorthybriddropsortPoint, b : SorthybriddropsortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_hybrid_dropsort_point_cross(a : SorthybriddropsortPoint, b : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_hybrid_dropsort_point_norm(pt : SorthybriddropsortPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_hybrid_dropsort_point_normalize(pt : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  let n = sort_hybrid_dropsort_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_hybrid_dropsort_point_scale(pt, 1.0 / n) }
}

pub fn sort_hybrid_dropsort_point_negate(pt : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_hybrid_dropsort_point_mid(a : SorthybriddropsortPoint, b : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_hybrid_dropsort_point_lerp(a : SorthybriddropsortPoint, b : SorthybriddropsortPoint, t : Double) -> SorthybriddropsortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_hybrid_dropsort_point_to_string(pt : SorthybriddropsortPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SorthybriddropsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_dropsort_make_series(vals : Array[Double], name : String) -> SorthybriddropsortSeries {
  { vals, name, meta: 0 }
}

pub fn sort_hybrid_dropsort_series_len(s : SorthybriddropsortSeries) -> Int { s.vals.length() }

pub fn sort_hybrid_dropsort_series_sum(s : SorthybriddropsortSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_hybrid_dropsort_series_mean(s : SorthybriddropsortSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_hybrid_dropsort_series_min(s : SorthybriddropsortSeries) -> Double { @_common.min(s.vals) }

pub fn sort_hybrid_dropsort_series_max(s : SorthybriddropsortSeries) -> Double { @_common.max(s.vals) }

pub fn sort_hybrid_dropsort_series_range(s : SorthybriddropsortSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_hybrid_dropsort_series_var(s : SorthybriddropsortSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_hybrid_dropsort_series_std(s : SorthybriddropsortSeries) -> Double { @_common.std(s.vals) }

pub fn sort_hybrid_dropsort_series_median(s : SorthybriddropsortSeries) -> Double { @_common.median(s.vals) }

pub fn sort_hybrid_dropsort_series_scale(s : SorthybriddropsortSeries, f : Double) -> SorthybriddropsortSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn sort_hybrid_dropsort_series_add(a : SorthybriddropsortSeries, b : SorthybriddropsortSeries) -> SorthybriddropsortSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_hybrid_dropsort_series_sub(a : SorthybriddropsortSeries, b : SorthybriddropsortSeries) -> SorthybriddropsortSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_hybrid_dropsort_series_normalize(s : SorthybriddropsortSeries) -> SorthybriddropsortSeries {
  let mn = sort_hybrid_dropsort_series_min(s)
  let mx = sort_hybrid_dropsort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_hybrid_dropsort_series_cumsum(s : SorthybriddropsortSeries) -> SorthybriddropsortSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_hybrid_dropsort_series_to_string(s : SorthybriddropsortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybriddropsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_dropsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybriddropsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_dropsort_matrix_identity(n : Int) -> SorthybriddropsortMatrix {
  let m = sort_hybrid_dropsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_hybrid_dropsort_matrix_get(m : SorthybriddropsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_hybrid_dropsort_matrix_transpose(m : SorthybriddropsortMatrix) -> SorthybriddropsortMatrix {
  let result = sort_hybrid_dropsort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_hybrid_dropsort_matrix_add(a : SorthybriddropsortMatrix, b : SorthybriddropsortMatrix) -> SorthybriddropsortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_hybrid_dropsort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_hybrid_dropsort_matrix_scale(m : SorthybriddropsortMatrix, s : Double) -> SorthybriddropsortMatrix {
  let result = sort_hybrid_dropsort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_hybrid_dropsort_matrix_multiply(a : SorthybriddropsortMatrix, b : SorthybriddropsortMatrix) -> SorthybriddropsortMatrix {
  if a.cols != b.rows { return sort_hybrid_dropsort_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_hybrid_dropsort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_hybrid_dropsort_matrix_trace(m : SorthybriddropsortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_hybrid_dropsort_matrix_det(m : SorthybriddropsortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_hybrid_dropsort_matrix_norm(m : SorthybriddropsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_hybrid_dropsort_matrix_to_string(m : SorthybriddropsortMatrix) -> String {
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

pub(all) struct SorthybriddropsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_dropsort_make_vector(comps : Array[Double]) -> SorthybriddropsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_dropsort_vector_zero(dim : Int) -> SorthybriddropsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_hybrid_dropsort_vector_add(a : SorthybriddropsortVector, b : SorthybriddropsortVector) -> SorthybriddropsortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn sort_hybrid_dropsort_vector_sub(a : SorthybriddropsortVector, b : SorthybriddropsortVector) -> SorthybriddropsortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn sort_hybrid_dropsort_vector_scale(v : SorthybriddropsortVector, s : Double) -> SorthybriddropsortVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn sort_hybrid_dropsort_vector_dot(a : SorthybriddropsortVector, b : SorthybriddropsortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_hybrid_dropsort_vector_norm(v : SorthybriddropsortVector) -> Double { @_common.sqrt(sort_hybrid_dropsort_vector_dot(v, v)) }

pub fn sort_hybrid_dropsort_vector_normalize(v : SorthybriddropsortVector) -> SorthybriddropsortVector {
  let n = sort_hybrid_dropsort_vector_norm(v)
  if n < 0.0000001 { v } else { sort_hybrid_dropsort_vector_scale(v, 1.0 / n) }
}

pub fn sort_hybrid_dropsort_vector_dist(a : SorthybriddropsortVector, b : SorthybriddropsortVector) -> Double {
  sort_hybrid_dropsort_vector_norm(sort_hybrid_dropsort_vector_sub(a, b))
}

pub fn sort_hybrid_dropsort_vector_to_string(v : SorthybriddropsortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_dropsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_dropsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_dropsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_dropsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_dropsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_dropsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_dropsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_dropsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_dropsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_dropsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_dropsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_dropsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_dropsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_dropsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_dropsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_dropsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_dropsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_dropsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_dropsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_dropsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_dropsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_dropsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_dropsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_dropsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_dropsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_dropsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_dropsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_dropsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_dropsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybriddropsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_frame_make(size : Int) -> SorthybriddropsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_frame_len(s : SorthybriddropsortFrame) -> Int { s.size }

pub fn sort_hybrid_dropsort_frame_get(s : SorthybriddropsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_frame_set(s : SorthybriddropsortFrame, i : Int, v : Double) -> SorthybriddropsortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_frame_sum(s : SorthybriddropsortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_frame_mean(s : SorthybriddropsortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_frame_scale(s : SorthybriddropsortFrame, f : Double) -> SorthybriddropsortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_frame_add(a : SorthybriddropsortFrame, b : SorthybriddropsortFrame) -> SorthybriddropsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_frame_copy(s : SorthybriddropsortFrame) -> SorthybriddropsortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_frame_fill(s : SorthybriddropsortFrame, v : Double) -> SorthybriddropsortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_frame_min(s : SorthybriddropsortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_frame_max(s : SorthybriddropsortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_frame_to_string(s : SorthybriddropsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_table_make(size : Int) -> SorthybriddropsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_table_len(s : SorthybriddropsortTable) -> Int { s.size }

pub fn sort_hybrid_dropsort_table_get(s : SorthybriddropsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_table_set(s : SorthybriddropsortTable, i : Int, v : Double) -> SorthybriddropsortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_table_sum(s : SorthybriddropsortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_table_mean(s : SorthybriddropsortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_table_scale(s : SorthybriddropsortTable, f : Double) -> SorthybriddropsortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_table_add(a : SorthybriddropsortTable, b : SorthybriddropsortTable) -> SorthybriddropsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_table_copy(s : SorthybriddropsortTable) -> SorthybriddropsortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_table_fill(s : SorthybriddropsortTable, v : Double) -> SorthybriddropsortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_table_min(s : SorthybriddropsortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_table_max(s : SorthybriddropsortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_table_to_string(s : SorthybriddropsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_graphn_make(size : Int) -> SorthybriddropsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_graphn_len(s : SorthybriddropsortGraphN) -> Int { s.size }

pub fn sort_hybrid_dropsort_graphn_get(s : SorthybriddropsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_graphn_set(s : SorthybriddropsortGraphN, i : Int, v : Double) -> SorthybriddropsortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_graphn_sum(s : SorthybriddropsortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_graphn_mean(s : SorthybriddropsortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_graphn_scale(s : SorthybriddropsortGraphN, f : Double) -> SorthybriddropsortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_graphn_add(a : SorthybriddropsortGraphN, b : SorthybriddropsortGraphN) -> SorthybriddropsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_graphn_copy(s : SorthybriddropsortGraphN) -> SorthybriddropsortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_graphn_fill(s : SorthybriddropsortGraphN, v : Double) -> SorthybriddropsortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_graphn_min(s : SorthybriddropsortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_graphn_max(s : SorthybriddropsortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_graphn_to_string(s : SorthybriddropsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_node_make(size : Int) -> SorthybriddropsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_node_len(s : SorthybriddropsortNode) -> Int { s.size }

pub fn sort_hybrid_dropsort_node_get(s : SorthybriddropsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_node_set(s : SorthybriddropsortNode, i : Int, v : Double) -> SorthybriddropsortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_node_sum(s : SorthybriddropsortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_node_mean(s : SorthybriddropsortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_node_scale(s : SorthybriddropsortNode, f : Double) -> SorthybriddropsortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_node_add(a : SorthybriddropsortNode, b : SorthybriddropsortNode) -> SorthybriddropsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_node_copy(s : SorthybriddropsortNode) -> SorthybriddropsortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_node_fill(s : SorthybriddropsortNode, v : Double) -> SorthybriddropsortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_node_min(s : SorthybriddropsortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_node_max(s : SorthybriddropsortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_node_to_string(s : SorthybriddropsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_edge_make(size : Int) -> SorthybriddropsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_edge_len(s : SorthybriddropsortEdge) -> Int { s.size }

pub fn sort_hybrid_dropsort_edge_get(s : SorthybriddropsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_edge_set(s : SorthybriddropsortEdge, i : Int, v : Double) -> SorthybriddropsortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_edge_sum(s : SorthybriddropsortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_edge_mean(s : SorthybriddropsortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_edge_scale(s : SorthybriddropsortEdge, f : Double) -> SorthybriddropsortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_edge_add(a : SorthybriddropsortEdge, b : SorthybriddropsortEdge) -> SorthybriddropsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_edge_copy(s : SorthybriddropsortEdge) -> SorthybriddropsortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_edge_fill(s : SorthybriddropsortEdge, v : Double) -> SorthybriddropsortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_edge_min(s : SorthybriddropsortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_edge_max(s : SorthybriddropsortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_edge_to_string(s : SorthybriddropsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_path_make(size : Int) -> SorthybriddropsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_path_len(s : SorthybriddropsortPath) -> Int { s.size }

pub fn sort_hybrid_dropsort_path_get(s : SorthybriddropsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_path_set(s : SorthybriddropsortPath, i : Int, v : Double) -> SorthybriddropsortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_path_sum(s : SorthybriddropsortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_path_mean(s : SorthybriddropsortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_path_scale(s : SorthybriddropsortPath, f : Double) -> SorthybriddropsortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_path_add(a : SorthybriddropsortPath, b : SorthybriddropsortPath) -> SorthybriddropsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_path_copy(s : SorthybriddropsortPath) -> SorthybriddropsortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_path_fill(s : SorthybriddropsortPath, v : Double) -> SorthybriddropsortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_path_min(s : SorthybriddropsortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_path_max(s : SorthybriddropsortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_path_to_string(s : SorthybriddropsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_cluster_make(size : Int) -> SorthybriddropsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_cluster_len(s : SorthybriddropsortCluster) -> Int { s.size }

pub fn sort_hybrid_dropsort_cluster_get(s : SorthybriddropsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_cluster_set(s : SorthybriddropsortCluster, i : Int, v : Double) -> SorthybriddropsortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cluster_sum(s : SorthybriddropsortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_cluster_mean(s : SorthybriddropsortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_cluster_scale(s : SorthybriddropsortCluster, f : Double) -> SorthybriddropsortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cluster_add(a : SorthybriddropsortCluster, b : SorthybriddropsortCluster) -> SorthybriddropsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_cluster_copy(s : SorthybriddropsortCluster) -> SorthybriddropsortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cluster_fill(s : SorthybriddropsortCluster, v : Double) -> SorthybriddropsortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cluster_min(s : SorthybriddropsortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_cluster_max(s : SorthybriddropsortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_cluster_to_string(s : SorthybriddropsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_model_make(size : Int) -> SorthybriddropsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_model_len(s : SorthybriddropsortModel) -> Int { s.size }

pub fn sort_hybrid_dropsort_model_get(s : SorthybriddropsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_model_set(s : SorthybriddropsortModel, i : Int, v : Double) -> SorthybriddropsortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_model_sum(s : SorthybriddropsortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_model_mean(s : SorthybriddropsortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_model_scale(s : SorthybriddropsortModel, f : Double) -> SorthybriddropsortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_model_add(a : SorthybriddropsortModel, b : SorthybriddropsortModel) -> SorthybriddropsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_model_copy(s : SorthybriddropsortModel) -> SorthybriddropsortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_model_fill(s : SorthybriddropsortModel, v : Double) -> SorthybriddropsortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_model_min(s : SorthybriddropsortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_model_max(s : SorthybriddropsortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_model_to_string(s : SorthybriddropsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_layer_make(size : Int) -> SorthybriddropsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_layer_len(s : SorthybriddropsortLayer) -> Int { s.size }

pub fn sort_hybrid_dropsort_layer_get(s : SorthybriddropsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_layer_set(s : SorthybriddropsortLayer, i : Int, v : Double) -> SorthybriddropsortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_layer_sum(s : SorthybriddropsortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_layer_mean(s : SorthybriddropsortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_layer_scale(s : SorthybriddropsortLayer, f : Double) -> SorthybriddropsortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_layer_add(a : SorthybriddropsortLayer, b : SorthybriddropsortLayer) -> SorthybriddropsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_layer_copy(s : SorthybriddropsortLayer) -> SorthybriddropsortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_layer_fill(s : SorthybriddropsortLayer, v : Double) -> SorthybriddropsortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_layer_min(s : SorthybriddropsortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_layer_max(s : SorthybriddropsortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_layer_to_string(s : SorthybriddropsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_buffer_make(size : Int) -> SorthybriddropsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_buffer_len(s : SorthybriddropsortBuffer) -> Int { s.size }

pub fn sort_hybrid_dropsort_buffer_get(s : SorthybriddropsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_buffer_set(s : SorthybriddropsortBuffer, i : Int, v : Double) -> SorthybriddropsortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_buffer_sum(s : SorthybriddropsortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_buffer_mean(s : SorthybriddropsortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_buffer_scale(s : SorthybriddropsortBuffer, f : Double) -> SorthybriddropsortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_buffer_add(a : SorthybriddropsortBuffer, b : SorthybriddropsortBuffer) -> SorthybriddropsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_buffer_copy(s : SorthybriddropsortBuffer) -> SorthybriddropsortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_buffer_fill(s : SorthybriddropsortBuffer, v : Double) -> SorthybriddropsortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_buffer_min(s : SorthybriddropsortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_buffer_max(s : SorthybriddropsortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_buffer_to_string(s : SorthybriddropsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_cursor_make(size : Int) -> SorthybriddropsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_cursor_len(s : SorthybriddropsortCursor) -> Int { s.size }

pub fn sort_hybrid_dropsort_cursor_get(s : SorthybriddropsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_cursor_set(s : SorthybriddropsortCursor, i : Int, v : Double) -> SorthybriddropsortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cursor_sum(s : SorthybriddropsortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_cursor_mean(s : SorthybriddropsortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_cursor_scale(s : SorthybriddropsortCursor, f : Double) -> SorthybriddropsortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cursor_add(a : SorthybriddropsortCursor, b : SorthybriddropsortCursor) -> SorthybriddropsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_cursor_copy(s : SorthybriddropsortCursor) -> SorthybriddropsortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cursor_fill(s : SorthybriddropsortCursor, v : Double) -> SorthybriddropsortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cursor_min(s : SorthybriddropsortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_cursor_max(s : SorthybriddropsortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_cursor_to_string(s : SorthybriddropsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_view_make(size : Int) -> SorthybriddropsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_view_len(s : SorthybriddropsortView) -> Int { s.size }

pub fn sort_hybrid_dropsort_view_get(s : SorthybriddropsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_view_set(s : SorthybriddropsortView, i : Int, v : Double) -> SorthybriddropsortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_view_sum(s : SorthybriddropsortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_view_mean(s : SorthybriddropsortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_view_scale(s : SorthybriddropsortView, f : Double) -> SorthybriddropsortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_view_add(a : SorthybriddropsortView, b : SorthybriddropsortView) -> SorthybriddropsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_view_copy(s : SorthybriddropsortView) -> SorthybriddropsortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_view_fill(s : SorthybriddropsortView, v : Double) -> SorthybriddropsortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_view_min(s : SorthybriddropsortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_view_max(s : SorthybriddropsortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_view_to_string(s : SorthybriddropsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_range_make(size : Int) -> SorthybriddropsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_range_len(s : SorthybriddropsortRange) -> Int { s.size }

pub fn sort_hybrid_dropsort_range_get(s : SorthybriddropsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_range_set(s : SorthybriddropsortRange, i : Int, v : Double) -> SorthybriddropsortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_range_sum(s : SorthybriddropsortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_range_mean(s : SorthybriddropsortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_range_scale(s : SorthybriddropsortRange, f : Double) -> SorthybriddropsortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_range_add(a : SorthybriddropsortRange, b : SorthybriddropsortRange) -> SorthybriddropsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_range_copy(s : SorthybriddropsortRange) -> SorthybriddropsortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_range_fill(s : SorthybriddropsortRange, v : Double) -> SorthybriddropsortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_range_min(s : SorthybriddropsortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_range_max(s : SorthybriddropsortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_range_to_string(s : SorthybriddropsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_slice_make(size : Int) -> SorthybriddropsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_slice_len(s : SorthybriddropsortSlice) -> Int { s.size }

pub fn sort_hybrid_dropsort_slice_get(s : SorthybriddropsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_slice_set(s : SorthybriddropsortSlice, i : Int, v : Double) -> SorthybriddropsortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_slice_sum(s : SorthybriddropsortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_slice_mean(s : SorthybriddropsortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_slice_scale(s : SorthybriddropsortSlice, f : Double) -> SorthybriddropsortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_slice_add(a : SorthybriddropsortSlice, b : SorthybriddropsortSlice) -> SorthybriddropsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_slice_copy(s : SorthybriddropsortSlice) -> SorthybriddropsortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_slice_fill(s : SorthybriddropsortSlice, v : Double) -> SorthybriddropsortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_slice_min(s : SorthybriddropsortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_slice_max(s : SorthybriddropsortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_slice_to_string(s : SorthybriddropsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

