///===
/// extcore/graph_color_list

pub(all) struct GraphcolorlistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_list_make_point(x : Double, y : Double) -> GraphcolorlistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_list_make_point3(x : Double, y : Double, z : Double) -> GraphcolorlistPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_list_point_x(pt : GraphcolorlistPoint) -> Double { pt.x }

pub fn graph_color_list_point_y(pt : GraphcolorlistPoint) -> Double { pt.y }

pub fn graph_color_list_point_z(pt : GraphcolorlistPoint) -> Double { pt.z }

pub fn graph_color_list_point_label(pt : GraphcolorlistPoint) -> Int { pt.label }

pub fn graph_color_list_point_dist(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_list_point_add(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_list_point_sub(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_list_point_scale(pt : GraphcolorlistPoint, s : Double) -> GraphcolorlistPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_list_point_dot(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_list_point_cross(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_list_point_norm(pt : GraphcolorlistPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_list_point_normalize(pt : GraphcolorlistPoint) -> GraphcolorlistPoint {
  let n = graph_color_list_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_list_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_list_point_negate(pt : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_list_point_mid(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_list_point_lerp(a : GraphcolorlistPoint, b : GraphcolorlistPoint, t : Double) -> GraphcolorlistPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_list_point_to_string(pt : GraphcolorlistPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorlistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_list_make_series(vals : Array[Double], name : String) -> GraphcolorlistSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_list_series_len(s : GraphcolorlistSeries) -> Int { s.vals.length() }

pub fn graph_color_list_series_sum(s : GraphcolorlistSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_color_list_series_mean(s : GraphcolorlistSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_color_list_series_min(s : GraphcolorlistSeries) -> Double { @_common.min(s.vals) }

pub fn graph_color_list_series_max(s : GraphcolorlistSeries) -> Double { @_common.max(s.vals) }

pub fn graph_color_list_series_range(s : GraphcolorlistSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_color_list_series_var(s : GraphcolorlistSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_color_list_series_std(s : GraphcolorlistSeries) -> Double { @_common.std(s.vals) }

pub fn graph_color_list_series_median(s : GraphcolorlistSeries) -> Double { @_common.median(s.vals) }

pub fn graph_color_list_series_scale(s : GraphcolorlistSeries, f : Double) -> GraphcolorlistSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_color_list_series_add(a : GraphcolorlistSeries, b : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_list_series_sub(a : GraphcolorlistSeries, b : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_list_series_normalize(s : GraphcolorlistSeries) -> GraphcolorlistSeries {
  let mn = graph_color_list_series_min(s)
  let mx = graph_color_list_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_list_series_cumsum(s : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_list_series_to_string(s : GraphcolorlistSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_list_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorlistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_list_matrix_identity(n : Int) -> GraphcolorlistMatrix {
  let m = graph_color_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_list_matrix_get(m : GraphcolorlistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_list_matrix_transpose(m : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  let result = graph_color_list_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_list_matrix_add(a : GraphcolorlistMatrix, b : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_list_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_list_matrix_scale(m : GraphcolorlistMatrix, s : Double) -> GraphcolorlistMatrix {
  let result = graph_color_list_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_list_matrix_multiply(a : GraphcolorlistMatrix, b : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  if a.cols != b.rows { return graph_color_list_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_list_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_list_matrix_trace(m : GraphcolorlistMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_list_matrix_det(m : GraphcolorlistMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_list_matrix_norm(m : GraphcolorlistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_list_matrix_to_string(m : GraphcolorlistMatrix) -> String {
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

pub(all) struct GraphcolorlistVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_list_make_vector(comps : Array[Double]) -> GraphcolorlistVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_list_vector_zero(dim : Int) -> GraphcolorlistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_list_vector_add(a : GraphcolorlistVector, b : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_color_list_vector_sub(a : GraphcolorlistVector, b : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_color_list_vector_scale(v : GraphcolorlistVector, s : Double) -> GraphcolorlistVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_color_list_vector_dot(a : GraphcolorlistVector, b : GraphcolorlistVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_list_vector_norm(v : GraphcolorlistVector) -> Double { @_common.sqrt(graph_color_list_vector_dot(v, v)) }

pub fn graph_color_list_vector_normalize(v : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = graph_color_list_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_list_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_list_vector_dist(a : GraphcolorlistVector, b : GraphcolorlistVector) -> Double {
  graph_color_list_vector_norm(graph_color_list_vector_sub(a, b))
}

pub fn graph_color_list_vector_to_string(v : GraphcolorlistVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_list_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_list_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_list_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_list_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_list_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_list_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_list_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_list_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_list_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_list_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_list_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_list_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_list_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_list_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_list_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_list_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_list_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_list_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_list_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_list_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_list_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_list_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_list_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_list_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_list_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_list_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_list_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_list_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_list_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorlistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_frame_make(size : Int) -> GraphcolorlistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_frame_len(s : GraphcolorlistFrame) -> Int { s.size }

pub fn graph_color_list_frame_get(s : GraphcolorlistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_frame_set(s : GraphcolorlistFrame, i : Int, v : Double) -> GraphcolorlistFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_frame_sum(s : GraphcolorlistFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_frame_mean(s : GraphcolorlistFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_frame_scale(s : GraphcolorlistFrame, f : Double) -> GraphcolorlistFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_frame_add(a : GraphcolorlistFrame, b : GraphcolorlistFrame) -> GraphcolorlistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_frame_copy(s : GraphcolorlistFrame) -> GraphcolorlistFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_frame_fill(s : GraphcolorlistFrame, v : Double) -> GraphcolorlistFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_frame_min(s : GraphcolorlistFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_list_frame_max(s : GraphcolorlistFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_list_frame_to_string(s : GraphcolorlistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_table_make(size : Int) -> GraphcolorlistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_table_len(s : GraphcolorlistTable) -> Int { s.size }

pub fn graph_color_list_table_get(s : GraphcolorlistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_table_set(s : GraphcolorlistTable, i : Int, v : Double) -> GraphcolorlistTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_table_sum(s : GraphcolorlistTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_table_mean(s : GraphcolorlistTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_table_scale(s : GraphcolorlistTable, f : Double) -> GraphcolorlistTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_table_add(a : GraphcolorlistTable, b : GraphcolorlistTable) -> GraphcolorlistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_table_copy(s : GraphcolorlistTable) -> GraphcolorlistTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_table_fill(s : GraphcolorlistTable, v : Double) -> GraphcolorlistTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_table_min(s : GraphcolorlistTable) -> Double { @_common.min(s.data) }

pub fn graph_color_list_table_max(s : GraphcolorlistTable) -> Double { @_common.max(s.data) }

pub fn graph_color_list_table_to_string(s : GraphcolorlistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_graphn_make(size : Int) -> GraphcolorlistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_graphn_len(s : GraphcolorlistGraphN) -> Int { s.size }

pub fn graph_color_list_graphn_get(s : GraphcolorlistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_graphn_set(s : GraphcolorlistGraphN, i : Int, v : Double) -> GraphcolorlistGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_graphn_sum(s : GraphcolorlistGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_graphn_mean(s : GraphcolorlistGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_graphn_scale(s : GraphcolorlistGraphN, f : Double) -> GraphcolorlistGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_graphn_add(a : GraphcolorlistGraphN, b : GraphcolorlistGraphN) -> GraphcolorlistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_graphn_copy(s : GraphcolorlistGraphN) -> GraphcolorlistGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_graphn_fill(s : GraphcolorlistGraphN, v : Double) -> GraphcolorlistGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_graphn_min(s : GraphcolorlistGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_list_graphn_max(s : GraphcolorlistGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_list_graphn_to_string(s : GraphcolorlistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_node_make(size : Int) -> GraphcolorlistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_node_len(s : GraphcolorlistNode) -> Int { s.size }

pub fn graph_color_list_node_get(s : GraphcolorlistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_node_set(s : GraphcolorlistNode, i : Int, v : Double) -> GraphcolorlistNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_node_sum(s : GraphcolorlistNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_node_mean(s : GraphcolorlistNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_node_scale(s : GraphcolorlistNode, f : Double) -> GraphcolorlistNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_node_add(a : GraphcolorlistNode, b : GraphcolorlistNode) -> GraphcolorlistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_node_copy(s : GraphcolorlistNode) -> GraphcolorlistNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_node_fill(s : GraphcolorlistNode, v : Double) -> GraphcolorlistNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_node_min(s : GraphcolorlistNode) -> Double { @_common.min(s.data) }

pub fn graph_color_list_node_max(s : GraphcolorlistNode) -> Double { @_common.max(s.data) }

pub fn graph_color_list_node_to_string(s : GraphcolorlistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_edge_make(size : Int) -> GraphcolorlistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_edge_len(s : GraphcolorlistEdge) -> Int { s.size }

pub fn graph_color_list_edge_get(s : GraphcolorlistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_edge_set(s : GraphcolorlistEdge, i : Int, v : Double) -> GraphcolorlistEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_edge_sum(s : GraphcolorlistEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_edge_mean(s : GraphcolorlistEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_edge_scale(s : GraphcolorlistEdge, f : Double) -> GraphcolorlistEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_edge_add(a : GraphcolorlistEdge, b : GraphcolorlistEdge) -> GraphcolorlistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_edge_copy(s : GraphcolorlistEdge) -> GraphcolorlistEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_edge_fill(s : GraphcolorlistEdge, v : Double) -> GraphcolorlistEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_edge_min(s : GraphcolorlistEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_list_edge_max(s : GraphcolorlistEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_list_edge_to_string(s : GraphcolorlistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_path_make(size : Int) -> GraphcolorlistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_path_len(s : GraphcolorlistPath) -> Int { s.size }

pub fn graph_color_list_path_get(s : GraphcolorlistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_path_set(s : GraphcolorlistPath, i : Int, v : Double) -> GraphcolorlistPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_path_sum(s : GraphcolorlistPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_path_mean(s : GraphcolorlistPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_path_scale(s : GraphcolorlistPath, f : Double) -> GraphcolorlistPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_path_add(a : GraphcolorlistPath, b : GraphcolorlistPath) -> GraphcolorlistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_path_copy(s : GraphcolorlistPath) -> GraphcolorlistPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_path_fill(s : GraphcolorlistPath, v : Double) -> GraphcolorlistPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_path_min(s : GraphcolorlistPath) -> Double { @_common.min(s.data) }

pub fn graph_color_list_path_max(s : GraphcolorlistPath) -> Double { @_common.max(s.data) }

pub fn graph_color_list_path_to_string(s : GraphcolorlistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_cluster_make(size : Int) -> GraphcolorlistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_cluster_len(s : GraphcolorlistCluster) -> Int { s.size }

pub fn graph_color_list_cluster_get(s : GraphcolorlistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_cluster_set(s : GraphcolorlistCluster, i : Int, v : Double) -> GraphcolorlistCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_cluster_sum(s : GraphcolorlistCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_cluster_mean(s : GraphcolorlistCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_cluster_scale(s : GraphcolorlistCluster, f : Double) -> GraphcolorlistCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cluster_add(a : GraphcolorlistCluster, b : GraphcolorlistCluster) -> GraphcolorlistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_cluster_copy(s : GraphcolorlistCluster) -> GraphcolorlistCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cluster_fill(s : GraphcolorlistCluster, v : Double) -> GraphcolorlistCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cluster_min(s : GraphcolorlistCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_list_cluster_max(s : GraphcolorlistCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_list_cluster_to_string(s : GraphcolorlistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_model_make(size : Int) -> GraphcolorlistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_model_len(s : GraphcolorlistModel) -> Int { s.size }

pub fn graph_color_list_model_get(s : GraphcolorlistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_model_set(s : GraphcolorlistModel, i : Int, v : Double) -> GraphcolorlistModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_model_sum(s : GraphcolorlistModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_model_mean(s : GraphcolorlistModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_model_scale(s : GraphcolorlistModel, f : Double) -> GraphcolorlistModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_model_add(a : GraphcolorlistModel, b : GraphcolorlistModel) -> GraphcolorlistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_model_copy(s : GraphcolorlistModel) -> GraphcolorlistModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_model_fill(s : GraphcolorlistModel, v : Double) -> GraphcolorlistModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_model_min(s : GraphcolorlistModel) -> Double { @_common.min(s.data) }

pub fn graph_color_list_model_max(s : GraphcolorlistModel) -> Double { @_common.max(s.data) }

pub fn graph_color_list_model_to_string(s : GraphcolorlistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_layer_make(size : Int) -> GraphcolorlistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_layer_len(s : GraphcolorlistLayer) -> Int { s.size }

pub fn graph_color_list_layer_get(s : GraphcolorlistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_layer_set(s : GraphcolorlistLayer, i : Int, v : Double) -> GraphcolorlistLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_layer_sum(s : GraphcolorlistLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_layer_mean(s : GraphcolorlistLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_layer_scale(s : GraphcolorlistLayer, f : Double) -> GraphcolorlistLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_layer_add(a : GraphcolorlistLayer, b : GraphcolorlistLayer) -> GraphcolorlistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_layer_copy(s : GraphcolorlistLayer) -> GraphcolorlistLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_layer_fill(s : GraphcolorlistLayer, v : Double) -> GraphcolorlistLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_layer_min(s : GraphcolorlistLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_list_layer_max(s : GraphcolorlistLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_list_layer_to_string(s : GraphcolorlistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_buffer_make(size : Int) -> GraphcolorlistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_buffer_len(s : GraphcolorlistBuffer) -> Int { s.size }

pub fn graph_color_list_buffer_get(s : GraphcolorlistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_buffer_set(s : GraphcolorlistBuffer, i : Int, v : Double) -> GraphcolorlistBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_buffer_sum(s : GraphcolorlistBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_buffer_mean(s : GraphcolorlistBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_buffer_scale(s : GraphcolorlistBuffer, f : Double) -> GraphcolorlistBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_buffer_add(a : GraphcolorlistBuffer, b : GraphcolorlistBuffer) -> GraphcolorlistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_buffer_copy(s : GraphcolorlistBuffer) -> GraphcolorlistBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_buffer_fill(s : GraphcolorlistBuffer, v : Double) -> GraphcolorlistBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_buffer_min(s : GraphcolorlistBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_list_buffer_max(s : GraphcolorlistBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_list_buffer_to_string(s : GraphcolorlistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_cursor_make(size : Int) -> GraphcolorlistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_cursor_len(s : GraphcolorlistCursor) -> Int { s.size }

pub fn graph_color_list_cursor_get(s : GraphcolorlistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_cursor_set(s : GraphcolorlistCursor, i : Int, v : Double) -> GraphcolorlistCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_cursor_sum(s : GraphcolorlistCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_cursor_mean(s : GraphcolorlistCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_cursor_scale(s : GraphcolorlistCursor, f : Double) -> GraphcolorlistCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cursor_add(a : GraphcolorlistCursor, b : GraphcolorlistCursor) -> GraphcolorlistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_cursor_copy(s : GraphcolorlistCursor) -> GraphcolorlistCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cursor_fill(s : GraphcolorlistCursor, v : Double) -> GraphcolorlistCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cursor_min(s : GraphcolorlistCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_list_cursor_max(s : GraphcolorlistCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_list_cursor_to_string(s : GraphcolorlistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_view_make(size : Int) -> GraphcolorlistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_view_len(s : GraphcolorlistView) -> Int { s.size }

pub fn graph_color_list_view_get(s : GraphcolorlistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_view_set(s : GraphcolorlistView, i : Int, v : Double) -> GraphcolorlistView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_view_sum(s : GraphcolorlistView) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_view_mean(s : GraphcolorlistView) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_view_scale(s : GraphcolorlistView, f : Double) -> GraphcolorlistView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_view_add(a : GraphcolorlistView, b : GraphcolorlistView) -> GraphcolorlistView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_view_copy(s : GraphcolorlistView) -> GraphcolorlistView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_view_fill(s : GraphcolorlistView, v : Double) -> GraphcolorlistView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_view_min(s : GraphcolorlistView) -> Double { @_common.min(s.data) }

pub fn graph_color_list_view_max(s : GraphcolorlistView) -> Double { @_common.max(s.data) }

pub fn graph_color_list_view_to_string(s : GraphcolorlistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_range_make(size : Int) -> GraphcolorlistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_range_len(s : GraphcolorlistRange) -> Int { s.size }

pub fn graph_color_list_range_get(s : GraphcolorlistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_range_set(s : GraphcolorlistRange, i : Int, v : Double) -> GraphcolorlistRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_range_sum(s : GraphcolorlistRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_range_mean(s : GraphcolorlistRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_range_scale(s : GraphcolorlistRange, f : Double) -> GraphcolorlistRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_range_add(a : GraphcolorlistRange, b : GraphcolorlistRange) -> GraphcolorlistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_range_copy(s : GraphcolorlistRange) -> GraphcolorlistRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_range_fill(s : GraphcolorlistRange, v : Double) -> GraphcolorlistRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_range_min(s : GraphcolorlistRange) -> Double { @_common.min(s.data) }

pub fn graph_color_list_range_max(s : GraphcolorlistRange) -> Double { @_common.max(s.data) }

pub fn graph_color_list_range_to_string(s : GraphcolorlistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_slice_make(size : Int) -> GraphcolorlistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_slice_len(s : GraphcolorlistSlice) -> Int { s.size }

pub fn graph_color_list_slice_get(s : GraphcolorlistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_slice_set(s : GraphcolorlistSlice, i : Int, v : Double) -> GraphcolorlistSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_slice_sum(s : GraphcolorlistSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_slice_mean(s : GraphcolorlistSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_slice_scale(s : GraphcolorlistSlice, f : Double) -> GraphcolorlistSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_slice_add(a : GraphcolorlistSlice, b : GraphcolorlistSlice) -> GraphcolorlistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_slice_copy(s : GraphcolorlistSlice) -> GraphcolorlistSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_slice_fill(s : GraphcolorlistSlice, v : Double) -> GraphcolorlistSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_slice_min(s : GraphcolorlistSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_list_slice_max(s : GraphcolorlistSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_list_slice_to_string(s : GraphcolorlistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

