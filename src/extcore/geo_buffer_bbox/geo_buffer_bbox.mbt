///===
/// extcore/geo_buffer_bbox

pub(all) struct GeobufferbboxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_bbox_make_point(x : Double, y : Double) -> GeobufferbboxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_bbox_make_point3(x : Double, y : Double, z : Double) -> GeobufferbboxPoint {
  { x, y, z, label: 0 }
}

pub fn geo_buffer_bbox_point_x(pt : GeobufferbboxPoint) -> Double { pt.x }

pub fn geo_buffer_bbox_point_y(pt : GeobufferbboxPoint) -> Double { pt.y }

pub fn geo_buffer_bbox_point_z(pt : GeobufferbboxPoint) -> Double { pt.z }

pub fn geo_buffer_bbox_point_label(pt : GeobufferbboxPoint) -> Int { pt.label }

pub fn geo_buffer_bbox_point_dist(a : GeobufferbboxPoint, b : GeobufferbboxPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_buffer_bbox_point_add(a : GeobufferbboxPoint, b : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_buffer_bbox_point_sub(a : GeobufferbboxPoint, b : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_buffer_bbox_point_scale(pt : GeobufferbboxPoint, s : Double) -> GeobufferbboxPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_buffer_bbox_point_dot(a : GeobufferbboxPoint, b : GeobufferbboxPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_buffer_bbox_point_cross(a : GeobufferbboxPoint, b : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_buffer_bbox_point_norm(pt : GeobufferbboxPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_buffer_bbox_point_normalize(pt : GeobufferbboxPoint) -> GeobufferbboxPoint {
  let n = geo_buffer_bbox_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_buffer_bbox_point_scale(pt, 1.0 / n) }
}

pub fn geo_buffer_bbox_point_negate(pt : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_buffer_bbox_point_mid(a : GeobufferbboxPoint, b : GeobufferbboxPoint) -> GeobufferbboxPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_buffer_bbox_point_lerp(a : GeobufferbboxPoint, b : GeobufferbboxPoint, t : Double) -> GeobufferbboxPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_buffer_bbox_point_to_string(pt : GeobufferbboxPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeobufferbboxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_bbox_make_series(vals : Array[Double], name : String) -> GeobufferbboxSeries {
  { vals, name, meta: 0 }
}

pub fn geo_buffer_bbox_series_len(s : GeobufferbboxSeries) -> Int { s.vals.length() }

pub fn geo_buffer_bbox_series_sum(s : GeobufferbboxSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_buffer_bbox_series_mean(s : GeobufferbboxSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_buffer_bbox_series_min(s : GeobufferbboxSeries) -> Double { @_common.min(s.vals) }

pub fn geo_buffer_bbox_series_max(s : GeobufferbboxSeries) -> Double { @_common.max(s.vals) }

pub fn geo_buffer_bbox_series_range(s : GeobufferbboxSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_buffer_bbox_series_var(s : GeobufferbboxSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_buffer_bbox_series_std(s : GeobufferbboxSeries) -> Double { @_common.std(s.vals) }

pub fn geo_buffer_bbox_series_median(s : GeobufferbboxSeries) -> Double { @_common.median(s.vals) }

pub fn geo_buffer_bbox_series_scale(s : GeobufferbboxSeries, f : Double) -> GeobufferbboxSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn geo_buffer_bbox_series_add(a : GeobufferbboxSeries, b : GeobufferbboxSeries) -> GeobufferbboxSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_buffer_bbox_series_sub(a : GeobufferbboxSeries, b : GeobufferbboxSeries) -> GeobufferbboxSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_buffer_bbox_series_normalize(s : GeobufferbboxSeries) -> GeobufferbboxSeries {
  let mn = geo_buffer_bbox_series_min(s)
  let mx = geo_buffer_bbox_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_buffer_bbox_series_cumsum(s : GeobufferbboxSeries) -> GeobufferbboxSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_buffer_bbox_series_to_string(s : GeobufferbboxSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferbboxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_bbox_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferbboxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_bbox_matrix_identity(n : Int) -> GeobufferbboxMatrix {
  let m = geo_buffer_bbox_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_buffer_bbox_matrix_get(m : GeobufferbboxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_buffer_bbox_matrix_transpose(m : GeobufferbboxMatrix) -> GeobufferbboxMatrix {
  let result = geo_buffer_bbox_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_buffer_bbox_matrix_add(a : GeobufferbboxMatrix, b : GeobufferbboxMatrix) -> GeobufferbboxMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_buffer_bbox_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_buffer_bbox_matrix_scale(m : GeobufferbboxMatrix, s : Double) -> GeobufferbboxMatrix {
  let result = geo_buffer_bbox_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_buffer_bbox_matrix_multiply(a : GeobufferbboxMatrix, b : GeobufferbboxMatrix) -> GeobufferbboxMatrix {
  if a.cols != b.rows { return geo_buffer_bbox_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_buffer_bbox_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_buffer_bbox_matrix_trace(m : GeobufferbboxMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_buffer_bbox_matrix_det(m : GeobufferbboxMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_buffer_bbox_matrix_norm(m : GeobufferbboxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_buffer_bbox_matrix_to_string(m : GeobufferbboxMatrix) -> String {
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

pub(all) struct GeobufferbboxVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_bbox_make_vector(comps : Array[Double]) -> GeobufferbboxVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_bbox_vector_zero(dim : Int) -> GeobufferbboxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_buffer_bbox_vector_add(a : GeobufferbboxVector, b : GeobufferbboxVector) -> GeobufferbboxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn geo_buffer_bbox_vector_sub(a : GeobufferbboxVector, b : GeobufferbboxVector) -> GeobufferbboxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn geo_buffer_bbox_vector_scale(v : GeobufferbboxVector, s : Double) -> GeobufferbboxVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn geo_buffer_bbox_vector_dot(a : GeobufferbboxVector, b : GeobufferbboxVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_buffer_bbox_vector_norm(v : GeobufferbboxVector) -> Double { @_common.sqrt(geo_buffer_bbox_vector_dot(v, v)) }

pub fn geo_buffer_bbox_vector_normalize(v : GeobufferbboxVector) -> GeobufferbboxVector {
  let n = geo_buffer_bbox_vector_norm(v)
  if n < 0.0000001 { v } else { geo_buffer_bbox_vector_scale(v, 1.0 / n) }
}

pub fn geo_buffer_bbox_vector_dist(a : GeobufferbboxVector, b : GeobufferbboxVector) -> Double {
  geo_buffer_bbox_vector_norm(geo_buffer_bbox_vector_sub(a, b))
}

pub fn geo_buffer_bbox_vector_to_string(v : GeobufferbboxVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_bbox_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_bbox_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_bbox_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_bbox_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_bbox_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_bbox_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_bbox_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_bbox_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_bbox_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_bbox_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_bbox_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_bbox_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_bbox_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_bbox_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_bbox_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_bbox_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_bbox_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_bbox_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_bbox_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_bbox_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_bbox_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_bbox_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_bbox_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_bbox_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_bbox_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_bbox_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_bbox_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_bbox_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_bbox_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferbboxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_frame_make(size : Int) -> GeobufferbboxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_frame_len(s : GeobufferbboxFrame) -> Int { s.size }

pub fn geo_buffer_bbox_frame_get(s : GeobufferbboxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_frame_set(s : GeobufferbboxFrame, i : Int, v : Double) -> GeobufferbboxFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_frame_sum(s : GeobufferbboxFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_frame_mean(s : GeobufferbboxFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_frame_scale(s : GeobufferbboxFrame, f : Double) -> GeobufferbboxFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_frame_add(a : GeobufferbboxFrame, b : GeobufferbboxFrame) -> GeobufferbboxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_frame_copy(s : GeobufferbboxFrame) -> GeobufferbboxFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_frame_fill(s : GeobufferbboxFrame, v : Double) -> GeobufferbboxFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_frame_min(s : GeobufferbboxFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_frame_max(s : GeobufferbboxFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_frame_to_string(s : GeobufferbboxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_table_make(size : Int) -> GeobufferbboxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_table_len(s : GeobufferbboxTable) -> Int { s.size }

pub fn geo_buffer_bbox_table_get(s : GeobufferbboxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_table_set(s : GeobufferbboxTable, i : Int, v : Double) -> GeobufferbboxTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_table_sum(s : GeobufferbboxTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_table_mean(s : GeobufferbboxTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_table_scale(s : GeobufferbboxTable, f : Double) -> GeobufferbboxTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_table_add(a : GeobufferbboxTable, b : GeobufferbboxTable) -> GeobufferbboxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_table_copy(s : GeobufferbboxTable) -> GeobufferbboxTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_table_fill(s : GeobufferbboxTable, v : Double) -> GeobufferbboxTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_table_min(s : GeobufferbboxTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_table_max(s : GeobufferbboxTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_table_to_string(s : GeobufferbboxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_graphn_make(size : Int) -> GeobufferbboxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_graphn_len(s : GeobufferbboxGraphN) -> Int { s.size }

pub fn geo_buffer_bbox_graphn_get(s : GeobufferbboxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_graphn_set(s : GeobufferbboxGraphN, i : Int, v : Double) -> GeobufferbboxGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_graphn_sum(s : GeobufferbboxGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_graphn_mean(s : GeobufferbboxGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_graphn_scale(s : GeobufferbboxGraphN, f : Double) -> GeobufferbboxGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_graphn_add(a : GeobufferbboxGraphN, b : GeobufferbboxGraphN) -> GeobufferbboxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_graphn_copy(s : GeobufferbboxGraphN) -> GeobufferbboxGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_graphn_fill(s : GeobufferbboxGraphN, v : Double) -> GeobufferbboxGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_graphn_min(s : GeobufferbboxGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_graphn_max(s : GeobufferbboxGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_graphn_to_string(s : GeobufferbboxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_node_make(size : Int) -> GeobufferbboxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_node_len(s : GeobufferbboxNode) -> Int { s.size }

pub fn geo_buffer_bbox_node_get(s : GeobufferbboxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_node_set(s : GeobufferbboxNode, i : Int, v : Double) -> GeobufferbboxNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_node_sum(s : GeobufferbboxNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_node_mean(s : GeobufferbboxNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_node_scale(s : GeobufferbboxNode, f : Double) -> GeobufferbboxNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_node_add(a : GeobufferbboxNode, b : GeobufferbboxNode) -> GeobufferbboxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_node_copy(s : GeobufferbboxNode) -> GeobufferbboxNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_node_fill(s : GeobufferbboxNode, v : Double) -> GeobufferbboxNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_node_min(s : GeobufferbboxNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_node_max(s : GeobufferbboxNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_node_to_string(s : GeobufferbboxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_edge_make(size : Int) -> GeobufferbboxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_edge_len(s : GeobufferbboxEdge) -> Int { s.size }

pub fn geo_buffer_bbox_edge_get(s : GeobufferbboxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_edge_set(s : GeobufferbboxEdge, i : Int, v : Double) -> GeobufferbboxEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_edge_sum(s : GeobufferbboxEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_edge_mean(s : GeobufferbboxEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_edge_scale(s : GeobufferbboxEdge, f : Double) -> GeobufferbboxEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_edge_add(a : GeobufferbboxEdge, b : GeobufferbboxEdge) -> GeobufferbboxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_edge_copy(s : GeobufferbboxEdge) -> GeobufferbboxEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_edge_fill(s : GeobufferbboxEdge, v : Double) -> GeobufferbboxEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_edge_min(s : GeobufferbboxEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_edge_max(s : GeobufferbboxEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_edge_to_string(s : GeobufferbboxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_path_make(size : Int) -> GeobufferbboxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_path_len(s : GeobufferbboxPath) -> Int { s.size }

pub fn geo_buffer_bbox_path_get(s : GeobufferbboxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_path_set(s : GeobufferbboxPath, i : Int, v : Double) -> GeobufferbboxPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_path_sum(s : GeobufferbboxPath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_path_mean(s : GeobufferbboxPath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_path_scale(s : GeobufferbboxPath, f : Double) -> GeobufferbboxPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_path_add(a : GeobufferbboxPath, b : GeobufferbboxPath) -> GeobufferbboxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_path_copy(s : GeobufferbboxPath) -> GeobufferbboxPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_path_fill(s : GeobufferbboxPath, v : Double) -> GeobufferbboxPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_path_min(s : GeobufferbboxPath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_path_max(s : GeobufferbboxPath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_path_to_string(s : GeobufferbboxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_cluster_make(size : Int) -> GeobufferbboxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_cluster_len(s : GeobufferbboxCluster) -> Int { s.size }

pub fn geo_buffer_bbox_cluster_get(s : GeobufferbboxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_cluster_set(s : GeobufferbboxCluster, i : Int, v : Double) -> GeobufferbboxCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_cluster_sum(s : GeobufferbboxCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_cluster_mean(s : GeobufferbboxCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_cluster_scale(s : GeobufferbboxCluster, f : Double) -> GeobufferbboxCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_cluster_add(a : GeobufferbboxCluster, b : GeobufferbboxCluster) -> GeobufferbboxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_cluster_copy(s : GeobufferbboxCluster) -> GeobufferbboxCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_cluster_fill(s : GeobufferbboxCluster, v : Double) -> GeobufferbboxCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_cluster_min(s : GeobufferbboxCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_cluster_max(s : GeobufferbboxCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_cluster_to_string(s : GeobufferbboxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_model_make(size : Int) -> GeobufferbboxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_model_len(s : GeobufferbboxModel) -> Int { s.size }

pub fn geo_buffer_bbox_model_get(s : GeobufferbboxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_model_set(s : GeobufferbboxModel, i : Int, v : Double) -> GeobufferbboxModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_model_sum(s : GeobufferbboxModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_model_mean(s : GeobufferbboxModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_model_scale(s : GeobufferbboxModel, f : Double) -> GeobufferbboxModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_model_add(a : GeobufferbboxModel, b : GeobufferbboxModel) -> GeobufferbboxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_model_copy(s : GeobufferbboxModel) -> GeobufferbboxModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_model_fill(s : GeobufferbboxModel, v : Double) -> GeobufferbboxModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_model_min(s : GeobufferbboxModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_model_max(s : GeobufferbboxModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_model_to_string(s : GeobufferbboxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_layer_make(size : Int) -> GeobufferbboxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_layer_len(s : GeobufferbboxLayer) -> Int { s.size }

pub fn geo_buffer_bbox_layer_get(s : GeobufferbboxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_layer_set(s : GeobufferbboxLayer, i : Int, v : Double) -> GeobufferbboxLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_layer_sum(s : GeobufferbboxLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_layer_mean(s : GeobufferbboxLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_layer_scale(s : GeobufferbboxLayer, f : Double) -> GeobufferbboxLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_layer_add(a : GeobufferbboxLayer, b : GeobufferbboxLayer) -> GeobufferbboxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_layer_copy(s : GeobufferbboxLayer) -> GeobufferbboxLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_layer_fill(s : GeobufferbboxLayer, v : Double) -> GeobufferbboxLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_layer_min(s : GeobufferbboxLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_layer_max(s : GeobufferbboxLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_layer_to_string(s : GeobufferbboxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_buffer_make(size : Int) -> GeobufferbboxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_buffer_len(s : GeobufferbboxBuffer) -> Int { s.size }

pub fn geo_buffer_bbox_buffer_get(s : GeobufferbboxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_buffer_set(s : GeobufferbboxBuffer, i : Int, v : Double) -> GeobufferbboxBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_buffer_sum(s : GeobufferbboxBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_buffer_mean(s : GeobufferbboxBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_buffer_scale(s : GeobufferbboxBuffer, f : Double) -> GeobufferbboxBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_buffer_add(a : GeobufferbboxBuffer, b : GeobufferbboxBuffer) -> GeobufferbboxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_buffer_copy(s : GeobufferbboxBuffer) -> GeobufferbboxBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_buffer_fill(s : GeobufferbboxBuffer, v : Double) -> GeobufferbboxBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_buffer_min(s : GeobufferbboxBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_buffer_max(s : GeobufferbboxBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_buffer_to_string(s : GeobufferbboxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_cursor_make(size : Int) -> GeobufferbboxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_cursor_len(s : GeobufferbboxCursor) -> Int { s.size }

pub fn geo_buffer_bbox_cursor_get(s : GeobufferbboxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_cursor_set(s : GeobufferbboxCursor, i : Int, v : Double) -> GeobufferbboxCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_cursor_sum(s : GeobufferbboxCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_cursor_mean(s : GeobufferbboxCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_cursor_scale(s : GeobufferbboxCursor, f : Double) -> GeobufferbboxCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_cursor_add(a : GeobufferbboxCursor, b : GeobufferbboxCursor) -> GeobufferbboxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_cursor_copy(s : GeobufferbboxCursor) -> GeobufferbboxCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_cursor_fill(s : GeobufferbboxCursor, v : Double) -> GeobufferbboxCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_cursor_min(s : GeobufferbboxCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_cursor_max(s : GeobufferbboxCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_cursor_to_string(s : GeobufferbboxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_view_make(size : Int) -> GeobufferbboxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_view_len(s : GeobufferbboxView) -> Int { s.size }

pub fn geo_buffer_bbox_view_get(s : GeobufferbboxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_view_set(s : GeobufferbboxView, i : Int, v : Double) -> GeobufferbboxView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_view_sum(s : GeobufferbboxView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_view_mean(s : GeobufferbboxView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_view_scale(s : GeobufferbboxView, f : Double) -> GeobufferbboxView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_view_add(a : GeobufferbboxView, b : GeobufferbboxView) -> GeobufferbboxView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_view_copy(s : GeobufferbboxView) -> GeobufferbboxView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_view_fill(s : GeobufferbboxView, v : Double) -> GeobufferbboxView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_view_min(s : GeobufferbboxView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_view_max(s : GeobufferbboxView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_view_to_string(s : GeobufferbboxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_range_make(size : Int) -> GeobufferbboxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_range_len(s : GeobufferbboxRange) -> Int { s.size }

pub fn geo_buffer_bbox_range_get(s : GeobufferbboxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_range_set(s : GeobufferbboxRange, i : Int, v : Double) -> GeobufferbboxRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_range_sum(s : GeobufferbboxRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_range_mean(s : GeobufferbboxRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_range_scale(s : GeobufferbboxRange, f : Double) -> GeobufferbboxRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_range_add(a : GeobufferbboxRange, b : GeobufferbboxRange) -> GeobufferbboxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_range_copy(s : GeobufferbboxRange) -> GeobufferbboxRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_range_fill(s : GeobufferbboxRange, v : Double) -> GeobufferbboxRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_range_min(s : GeobufferbboxRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_range_max(s : GeobufferbboxRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_range_to_string(s : GeobufferbboxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferbboxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_bbox_slice_make(size : Int) -> GeobufferbboxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_bbox_slice_len(s : GeobufferbboxSlice) -> Int { s.size }

pub fn geo_buffer_bbox_slice_get(s : GeobufferbboxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_bbox_slice_set(s : GeobufferbboxSlice, i : Int, v : Double) -> GeobufferbboxSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_slice_sum(s : GeobufferbboxSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_bbox_slice_mean(s : GeobufferbboxSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_bbox_slice_scale(s : GeobufferbboxSlice, f : Double) -> GeobufferbboxSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_slice_add(a : GeobufferbboxSlice, b : GeobufferbboxSlice) -> GeobufferbboxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_bbox_slice_copy(s : GeobufferbboxSlice) -> GeobufferbboxSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_slice_fill(s : GeobufferbboxSlice, v : Double) -> GeobufferbboxSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_bbox_slice_min(s : GeobufferbboxSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_bbox_slice_max(s : GeobufferbboxSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_bbox_slice_to_string(s : GeobufferbboxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

