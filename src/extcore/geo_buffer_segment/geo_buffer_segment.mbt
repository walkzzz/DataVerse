///===
/// extcore/geo_buffer_segment

pub(all) struct GeobuffersegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_segment_make_point(x : Double, y : Double) -> GeobuffersegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_segment_make_point3(x : Double, y : Double, z : Double) -> GeobuffersegmentPoint {
  { x, y, z, label: 0 }
}

pub fn geo_buffer_segment_point_x(pt : GeobuffersegmentPoint) -> Double { pt.x }

pub fn geo_buffer_segment_point_y(pt : GeobuffersegmentPoint) -> Double { pt.y }

pub fn geo_buffer_segment_point_z(pt : GeobuffersegmentPoint) -> Double { pt.z }

pub fn geo_buffer_segment_point_label(pt : GeobuffersegmentPoint) -> Int { pt.label }

pub fn geo_buffer_segment_point_dist(a : GeobuffersegmentPoint, b : GeobuffersegmentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_buffer_segment_point_add(a : GeobuffersegmentPoint, b : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_buffer_segment_point_sub(a : GeobuffersegmentPoint, b : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_buffer_segment_point_scale(pt : GeobuffersegmentPoint, s : Double) -> GeobuffersegmentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_buffer_segment_point_dot(a : GeobuffersegmentPoint, b : GeobuffersegmentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_buffer_segment_point_cross(a : GeobuffersegmentPoint, b : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_buffer_segment_point_norm(pt : GeobuffersegmentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_buffer_segment_point_normalize(pt : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  let n = geo_buffer_segment_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_buffer_segment_point_scale(pt, 1.0 / n) }
}

pub fn geo_buffer_segment_point_negate(pt : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_buffer_segment_point_mid(a : GeobuffersegmentPoint, b : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_buffer_segment_point_lerp(a : GeobuffersegmentPoint, b : GeobuffersegmentPoint, t : Double) -> GeobuffersegmentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_buffer_segment_point_to_string(pt : GeobuffersegmentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeobuffersegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_segment_make_series(vals : Array[Double], name : String) -> GeobuffersegmentSeries {
  { vals, name, meta: 0 }
}

pub fn geo_buffer_segment_series_len(s : GeobuffersegmentSeries) -> Int { s.vals.length() }

pub fn geo_buffer_segment_series_sum(s : GeobuffersegmentSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_buffer_segment_series_mean(s : GeobuffersegmentSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_buffer_segment_series_min(s : GeobuffersegmentSeries) -> Double { @_common.min(s.vals) }

pub fn geo_buffer_segment_series_max(s : GeobuffersegmentSeries) -> Double { @_common.max(s.vals) }

pub fn geo_buffer_segment_series_range(s : GeobuffersegmentSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_buffer_segment_series_var(s : GeobuffersegmentSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_buffer_segment_series_std(s : GeobuffersegmentSeries) -> Double { @_common.std(s.vals) }

pub fn geo_buffer_segment_series_median(s : GeobuffersegmentSeries) -> Double { @_common.median(s.vals) }

pub fn geo_buffer_segment_series_scale(s : GeobuffersegmentSeries, f : Double) -> GeobuffersegmentSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn geo_buffer_segment_series_add(a : GeobuffersegmentSeries, b : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_buffer_segment_series_sub(a : GeobuffersegmentSeries, b : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_buffer_segment_series_normalize(s : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  let mn = geo_buffer_segment_series_min(s)
  let mx = geo_buffer_segment_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_buffer_segment_series_cumsum(s : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_buffer_segment_series_to_string(s : GeobuffersegmentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffersegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_segment_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffersegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_segment_matrix_identity(n : Int) -> GeobuffersegmentMatrix {
  let m = geo_buffer_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_buffer_segment_matrix_get(m : GeobuffersegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_buffer_segment_matrix_transpose(m : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  let result = geo_buffer_segment_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_buffer_segment_matrix_add(a : GeobuffersegmentMatrix, b : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_buffer_segment_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_buffer_segment_matrix_scale(m : GeobuffersegmentMatrix, s : Double) -> GeobuffersegmentMatrix {
  let result = geo_buffer_segment_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_buffer_segment_matrix_multiply(a : GeobuffersegmentMatrix, b : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  if a.cols != b.rows { return geo_buffer_segment_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_buffer_segment_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_buffer_segment_matrix_trace(m : GeobuffersegmentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_buffer_segment_matrix_det(m : GeobuffersegmentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_buffer_segment_matrix_norm(m : GeobuffersegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_buffer_segment_matrix_to_string(m : GeobuffersegmentMatrix) -> String {
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

pub(all) struct GeobuffersegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_segment_make_vector(comps : Array[Double]) -> GeobuffersegmentVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_segment_vector_zero(dim : Int) -> GeobuffersegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_buffer_segment_vector_add(a : GeobuffersegmentVector, b : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn geo_buffer_segment_vector_sub(a : GeobuffersegmentVector, b : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn geo_buffer_segment_vector_scale(v : GeobuffersegmentVector, s : Double) -> GeobuffersegmentVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn geo_buffer_segment_vector_dot(a : GeobuffersegmentVector, b : GeobuffersegmentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_buffer_segment_vector_norm(v : GeobuffersegmentVector) -> Double { @_common.sqrt(geo_buffer_segment_vector_dot(v, v)) }

pub fn geo_buffer_segment_vector_normalize(v : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = geo_buffer_segment_vector_norm(v)
  if n < 0.0000001 { v } else { geo_buffer_segment_vector_scale(v, 1.0 / n) }
}

pub fn geo_buffer_segment_vector_dist(a : GeobuffersegmentVector, b : GeobuffersegmentVector) -> Double {
  geo_buffer_segment_vector_norm(geo_buffer_segment_vector_sub(a, b))
}

pub fn geo_buffer_segment_vector_to_string(v : GeobuffersegmentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_segment_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_segment_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_segment_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_segment_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_segment_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_segment_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_segment_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_segment_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_segment_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_segment_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_segment_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_segment_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_segment_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_segment_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_segment_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_segment_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_segment_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_segment_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_segment_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_segment_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_segment_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_segment_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_segment_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_segment_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_segment_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_segment_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_segment_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_segment_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_segment_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobuffersegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_frame_make(size : Int) -> GeobuffersegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_frame_len(s : GeobuffersegmentFrame) -> Int { s.size }

pub fn geo_buffer_segment_frame_get(s : GeobuffersegmentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_frame_set(s : GeobuffersegmentFrame, i : Int, v : Double) -> GeobuffersegmentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_frame_sum(s : GeobuffersegmentFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_frame_mean(s : GeobuffersegmentFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_frame_scale(s : GeobuffersegmentFrame, f : Double) -> GeobuffersegmentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_frame_add(a : GeobuffersegmentFrame, b : GeobuffersegmentFrame) -> GeobuffersegmentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_frame_copy(s : GeobuffersegmentFrame) -> GeobuffersegmentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_frame_fill(s : GeobuffersegmentFrame, v : Double) -> GeobuffersegmentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_frame_min(s : GeobuffersegmentFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_frame_max(s : GeobuffersegmentFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_frame_to_string(s : GeobuffersegmentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_table_make(size : Int) -> GeobuffersegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_table_len(s : GeobuffersegmentTable) -> Int { s.size }

pub fn geo_buffer_segment_table_get(s : GeobuffersegmentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_table_set(s : GeobuffersegmentTable, i : Int, v : Double) -> GeobuffersegmentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_table_sum(s : GeobuffersegmentTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_table_mean(s : GeobuffersegmentTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_table_scale(s : GeobuffersegmentTable, f : Double) -> GeobuffersegmentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_table_add(a : GeobuffersegmentTable, b : GeobuffersegmentTable) -> GeobuffersegmentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_table_copy(s : GeobuffersegmentTable) -> GeobuffersegmentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_table_fill(s : GeobuffersegmentTable, v : Double) -> GeobuffersegmentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_table_min(s : GeobuffersegmentTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_table_max(s : GeobuffersegmentTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_table_to_string(s : GeobuffersegmentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_graphn_make(size : Int) -> GeobuffersegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_graphn_len(s : GeobuffersegmentGraphN) -> Int { s.size }

pub fn geo_buffer_segment_graphn_get(s : GeobuffersegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_graphn_set(s : GeobuffersegmentGraphN, i : Int, v : Double) -> GeobuffersegmentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_graphn_sum(s : GeobuffersegmentGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_graphn_mean(s : GeobuffersegmentGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_graphn_scale(s : GeobuffersegmentGraphN, f : Double) -> GeobuffersegmentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_graphn_add(a : GeobuffersegmentGraphN, b : GeobuffersegmentGraphN) -> GeobuffersegmentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_graphn_copy(s : GeobuffersegmentGraphN) -> GeobuffersegmentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_graphn_fill(s : GeobuffersegmentGraphN, v : Double) -> GeobuffersegmentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_graphn_min(s : GeobuffersegmentGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_graphn_max(s : GeobuffersegmentGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_graphn_to_string(s : GeobuffersegmentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_node_make(size : Int) -> GeobuffersegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_node_len(s : GeobuffersegmentNode) -> Int { s.size }

pub fn geo_buffer_segment_node_get(s : GeobuffersegmentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_node_set(s : GeobuffersegmentNode, i : Int, v : Double) -> GeobuffersegmentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_node_sum(s : GeobuffersegmentNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_node_mean(s : GeobuffersegmentNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_node_scale(s : GeobuffersegmentNode, f : Double) -> GeobuffersegmentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_node_add(a : GeobuffersegmentNode, b : GeobuffersegmentNode) -> GeobuffersegmentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_node_copy(s : GeobuffersegmentNode) -> GeobuffersegmentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_node_fill(s : GeobuffersegmentNode, v : Double) -> GeobuffersegmentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_node_min(s : GeobuffersegmentNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_node_max(s : GeobuffersegmentNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_node_to_string(s : GeobuffersegmentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_edge_make(size : Int) -> GeobuffersegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_edge_len(s : GeobuffersegmentEdge) -> Int { s.size }

pub fn geo_buffer_segment_edge_get(s : GeobuffersegmentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_edge_set(s : GeobuffersegmentEdge, i : Int, v : Double) -> GeobuffersegmentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_edge_sum(s : GeobuffersegmentEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_edge_mean(s : GeobuffersegmentEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_edge_scale(s : GeobuffersegmentEdge, f : Double) -> GeobuffersegmentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_edge_add(a : GeobuffersegmentEdge, b : GeobuffersegmentEdge) -> GeobuffersegmentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_edge_copy(s : GeobuffersegmentEdge) -> GeobuffersegmentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_edge_fill(s : GeobuffersegmentEdge, v : Double) -> GeobuffersegmentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_edge_min(s : GeobuffersegmentEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_edge_max(s : GeobuffersegmentEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_edge_to_string(s : GeobuffersegmentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_path_make(size : Int) -> GeobuffersegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_path_len(s : GeobuffersegmentPath) -> Int { s.size }

pub fn geo_buffer_segment_path_get(s : GeobuffersegmentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_path_set(s : GeobuffersegmentPath, i : Int, v : Double) -> GeobuffersegmentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_path_sum(s : GeobuffersegmentPath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_path_mean(s : GeobuffersegmentPath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_path_scale(s : GeobuffersegmentPath, f : Double) -> GeobuffersegmentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_path_add(a : GeobuffersegmentPath, b : GeobuffersegmentPath) -> GeobuffersegmentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_path_copy(s : GeobuffersegmentPath) -> GeobuffersegmentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_path_fill(s : GeobuffersegmentPath, v : Double) -> GeobuffersegmentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_path_min(s : GeobuffersegmentPath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_path_max(s : GeobuffersegmentPath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_path_to_string(s : GeobuffersegmentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_cluster_make(size : Int) -> GeobuffersegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_cluster_len(s : GeobuffersegmentCluster) -> Int { s.size }

pub fn geo_buffer_segment_cluster_get(s : GeobuffersegmentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_cluster_set(s : GeobuffersegmentCluster, i : Int, v : Double) -> GeobuffersegmentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cluster_sum(s : GeobuffersegmentCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_cluster_mean(s : GeobuffersegmentCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_cluster_scale(s : GeobuffersegmentCluster, f : Double) -> GeobuffersegmentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cluster_add(a : GeobuffersegmentCluster, b : GeobuffersegmentCluster) -> GeobuffersegmentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_cluster_copy(s : GeobuffersegmentCluster) -> GeobuffersegmentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cluster_fill(s : GeobuffersegmentCluster, v : Double) -> GeobuffersegmentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cluster_min(s : GeobuffersegmentCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_cluster_max(s : GeobuffersegmentCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_cluster_to_string(s : GeobuffersegmentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_model_make(size : Int) -> GeobuffersegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_model_len(s : GeobuffersegmentModel) -> Int { s.size }

pub fn geo_buffer_segment_model_get(s : GeobuffersegmentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_model_set(s : GeobuffersegmentModel, i : Int, v : Double) -> GeobuffersegmentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_model_sum(s : GeobuffersegmentModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_model_mean(s : GeobuffersegmentModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_model_scale(s : GeobuffersegmentModel, f : Double) -> GeobuffersegmentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_model_add(a : GeobuffersegmentModel, b : GeobuffersegmentModel) -> GeobuffersegmentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_model_copy(s : GeobuffersegmentModel) -> GeobuffersegmentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_model_fill(s : GeobuffersegmentModel, v : Double) -> GeobuffersegmentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_model_min(s : GeobuffersegmentModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_model_max(s : GeobuffersegmentModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_model_to_string(s : GeobuffersegmentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_layer_make(size : Int) -> GeobuffersegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_layer_len(s : GeobuffersegmentLayer) -> Int { s.size }

pub fn geo_buffer_segment_layer_get(s : GeobuffersegmentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_layer_set(s : GeobuffersegmentLayer, i : Int, v : Double) -> GeobuffersegmentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_layer_sum(s : GeobuffersegmentLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_layer_mean(s : GeobuffersegmentLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_layer_scale(s : GeobuffersegmentLayer, f : Double) -> GeobuffersegmentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_layer_add(a : GeobuffersegmentLayer, b : GeobuffersegmentLayer) -> GeobuffersegmentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_layer_copy(s : GeobuffersegmentLayer) -> GeobuffersegmentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_layer_fill(s : GeobuffersegmentLayer, v : Double) -> GeobuffersegmentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_layer_min(s : GeobuffersegmentLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_layer_max(s : GeobuffersegmentLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_layer_to_string(s : GeobuffersegmentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_buffer_make(size : Int) -> GeobuffersegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_buffer_len(s : GeobuffersegmentBuffer) -> Int { s.size }

pub fn geo_buffer_segment_buffer_get(s : GeobuffersegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_buffer_set(s : GeobuffersegmentBuffer, i : Int, v : Double) -> GeobuffersegmentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_buffer_sum(s : GeobuffersegmentBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_buffer_mean(s : GeobuffersegmentBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_buffer_scale(s : GeobuffersegmentBuffer, f : Double) -> GeobuffersegmentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_buffer_add(a : GeobuffersegmentBuffer, b : GeobuffersegmentBuffer) -> GeobuffersegmentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_buffer_copy(s : GeobuffersegmentBuffer) -> GeobuffersegmentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_buffer_fill(s : GeobuffersegmentBuffer, v : Double) -> GeobuffersegmentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_buffer_min(s : GeobuffersegmentBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_buffer_max(s : GeobuffersegmentBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_buffer_to_string(s : GeobuffersegmentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_cursor_make(size : Int) -> GeobuffersegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_cursor_len(s : GeobuffersegmentCursor) -> Int { s.size }

pub fn geo_buffer_segment_cursor_get(s : GeobuffersegmentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_cursor_set(s : GeobuffersegmentCursor, i : Int, v : Double) -> GeobuffersegmentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cursor_sum(s : GeobuffersegmentCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_cursor_mean(s : GeobuffersegmentCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_cursor_scale(s : GeobuffersegmentCursor, f : Double) -> GeobuffersegmentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cursor_add(a : GeobuffersegmentCursor, b : GeobuffersegmentCursor) -> GeobuffersegmentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_cursor_copy(s : GeobuffersegmentCursor) -> GeobuffersegmentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cursor_fill(s : GeobuffersegmentCursor, v : Double) -> GeobuffersegmentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cursor_min(s : GeobuffersegmentCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_cursor_max(s : GeobuffersegmentCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_cursor_to_string(s : GeobuffersegmentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_view_make(size : Int) -> GeobuffersegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_view_len(s : GeobuffersegmentView) -> Int { s.size }

pub fn geo_buffer_segment_view_get(s : GeobuffersegmentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_view_set(s : GeobuffersegmentView, i : Int, v : Double) -> GeobuffersegmentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_view_sum(s : GeobuffersegmentView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_view_mean(s : GeobuffersegmentView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_view_scale(s : GeobuffersegmentView, f : Double) -> GeobuffersegmentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_view_add(a : GeobuffersegmentView, b : GeobuffersegmentView) -> GeobuffersegmentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_view_copy(s : GeobuffersegmentView) -> GeobuffersegmentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_view_fill(s : GeobuffersegmentView, v : Double) -> GeobuffersegmentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_view_min(s : GeobuffersegmentView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_view_max(s : GeobuffersegmentView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_view_to_string(s : GeobuffersegmentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_range_make(size : Int) -> GeobuffersegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_range_len(s : GeobuffersegmentRange) -> Int { s.size }

pub fn geo_buffer_segment_range_get(s : GeobuffersegmentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_range_set(s : GeobuffersegmentRange, i : Int, v : Double) -> GeobuffersegmentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_range_sum(s : GeobuffersegmentRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_range_mean(s : GeobuffersegmentRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_range_scale(s : GeobuffersegmentRange, f : Double) -> GeobuffersegmentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_range_add(a : GeobuffersegmentRange, b : GeobuffersegmentRange) -> GeobuffersegmentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_range_copy(s : GeobuffersegmentRange) -> GeobuffersegmentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_range_fill(s : GeobuffersegmentRange, v : Double) -> GeobuffersegmentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_range_min(s : GeobuffersegmentRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_range_max(s : GeobuffersegmentRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_range_to_string(s : GeobuffersegmentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_slice_make(size : Int) -> GeobuffersegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_slice_len(s : GeobuffersegmentSlice) -> Int { s.size }

pub fn geo_buffer_segment_slice_get(s : GeobuffersegmentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_slice_set(s : GeobuffersegmentSlice, i : Int, v : Double) -> GeobuffersegmentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_slice_sum(s : GeobuffersegmentSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_slice_mean(s : GeobuffersegmentSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_slice_scale(s : GeobuffersegmentSlice, f : Double) -> GeobuffersegmentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_slice_add(a : GeobuffersegmentSlice, b : GeobuffersegmentSlice) -> GeobuffersegmentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_slice_copy(s : GeobuffersegmentSlice) -> GeobuffersegmentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_slice_fill(s : GeobuffersegmentSlice, v : Double) -> GeobuffersegmentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_slice_min(s : GeobuffersegmentSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_slice_max(s : GeobuffersegmentSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_slice_to_string(s : GeobuffersegmentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

