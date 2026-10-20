///===
/// extcore/graph_tree_encoding

pub(all) struct GraphtreeencodingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_encoding_make_point(x : Double, y : Double) -> GraphtreeencodingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_encoding_make_point3(x : Double, y : Double, z : Double) -> GraphtreeencodingPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_encoding_point_x(pt : GraphtreeencodingPoint) -> Double { pt.x }

pub fn graph_tree_encoding_point_y(pt : GraphtreeencodingPoint) -> Double { pt.y }

pub fn graph_tree_encoding_point_z(pt : GraphtreeencodingPoint) -> Double { pt.z }

pub fn graph_tree_encoding_point_label(pt : GraphtreeencodingPoint) -> Int { pt.label }

pub fn graph_tree_encoding_point_dist(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_encoding_point_add(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_encoding_point_sub(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_encoding_point_scale(pt : GraphtreeencodingPoint, s : Double) -> GraphtreeencodingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_encoding_point_dot(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_encoding_point_cross(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_encoding_point_norm(pt : GraphtreeencodingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_encoding_point_normalize(pt : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  let n = graph_tree_encoding_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_encoding_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_encoding_point_negate(pt : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_encoding_point_mid(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_encoding_point_lerp(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint, t : Double) -> GraphtreeencodingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_encoding_point_to_string(pt : GraphtreeencodingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreeencodingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_encoding_make_series(vals : Array[Double], name : String) -> GraphtreeencodingSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_encoding_series_len(s : GraphtreeencodingSeries) -> Int { s.vals.length() }

pub fn graph_tree_encoding_series_sum(s : GraphtreeencodingSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_tree_encoding_series_mean(s : GraphtreeencodingSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_tree_encoding_series_min(s : GraphtreeencodingSeries) -> Double { @_common.min(s.vals) }

pub fn graph_tree_encoding_series_max(s : GraphtreeencodingSeries) -> Double { @_common.max(s.vals) }

pub fn graph_tree_encoding_series_range(s : GraphtreeencodingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_tree_encoding_series_var(s : GraphtreeencodingSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_tree_encoding_series_std(s : GraphtreeencodingSeries) -> Double { @_common.std(s.vals) }

pub fn graph_tree_encoding_series_median(s : GraphtreeencodingSeries) -> Double { @_common.median(s.vals) }

pub fn graph_tree_encoding_series_scale(s : GraphtreeencodingSeries, f : Double) -> GraphtreeencodingSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_tree_encoding_series_add(a : GraphtreeencodingSeries, b : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_encoding_series_sub(a : GraphtreeencodingSeries, b : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_encoding_series_normalize(s : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  let mn = graph_tree_encoding_series_min(s)
  let mx = graph_tree_encoding_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_encoding_series_cumsum(s : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_encoding_series_to_string(s : GraphtreeencodingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreeencodingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_encoding_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreeencodingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_encoding_matrix_identity(n : Int) -> GraphtreeencodingMatrix {
  let m = graph_tree_encoding_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_encoding_matrix_get(m : GraphtreeencodingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_encoding_matrix_transpose(m : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  let result = graph_tree_encoding_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_encoding_matrix_add(a : GraphtreeencodingMatrix, b : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_encoding_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_encoding_matrix_scale(m : GraphtreeencodingMatrix, s : Double) -> GraphtreeencodingMatrix {
  let result = graph_tree_encoding_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_encoding_matrix_multiply(a : GraphtreeencodingMatrix, b : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  if a.cols != b.rows { return graph_tree_encoding_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_encoding_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_encoding_matrix_trace(m : GraphtreeencodingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_encoding_matrix_det(m : GraphtreeencodingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_encoding_matrix_norm(m : GraphtreeencodingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_tree_encoding_matrix_to_string(m : GraphtreeencodingMatrix) -> String {
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

pub(all) struct GraphtreeencodingVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_encoding_make_vector(comps : Array[Double]) -> GraphtreeencodingVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_encoding_vector_zero(dim : Int) -> GraphtreeencodingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_encoding_vector_add(a : GraphtreeencodingVector, b : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_tree_encoding_vector_sub(a : GraphtreeencodingVector, b : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_tree_encoding_vector_scale(v : GraphtreeencodingVector, s : Double) -> GraphtreeencodingVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_tree_encoding_vector_dot(a : GraphtreeencodingVector, b : GraphtreeencodingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_encoding_vector_norm(v : GraphtreeencodingVector) -> Double { @_common.sqrt(graph_tree_encoding_vector_dot(v, v)) }

pub fn graph_tree_encoding_vector_normalize(v : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = graph_tree_encoding_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_encoding_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_encoding_vector_dist(a : GraphtreeencodingVector, b : GraphtreeencodingVector) -> Double {
  graph_tree_encoding_vector_norm(graph_tree_encoding_vector_sub(a, b))
}

pub fn graph_tree_encoding_vector_to_string(v : GraphtreeencodingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_encoding_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_encoding_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_encoding_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_encoding_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_encoding_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_encoding_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_encoding_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_encoding_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_encoding_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_encoding_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_encoding_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_encoding_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_encoding_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_encoding_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_encoding_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_encoding_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_encoding_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_encoding_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_encoding_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_encoding_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_encoding_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_encoding_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_encoding_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_encoding_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_encoding_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_encoding_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_encoding_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_encoding_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_encoding_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreeencodingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_frame_make(size : Int) -> GraphtreeencodingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_frame_len(s : GraphtreeencodingFrame) -> Int { s.size }

pub fn graph_tree_encoding_frame_get(s : GraphtreeencodingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_frame_set(s : GraphtreeencodingFrame, i : Int, v : Double) -> GraphtreeencodingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_frame_sum(s : GraphtreeencodingFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_frame_mean(s : GraphtreeencodingFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_frame_scale(s : GraphtreeencodingFrame, f : Double) -> GraphtreeencodingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_frame_add(a : GraphtreeencodingFrame, b : GraphtreeencodingFrame) -> GraphtreeencodingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_frame_copy(s : GraphtreeencodingFrame) -> GraphtreeencodingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_frame_fill(s : GraphtreeencodingFrame, v : Double) -> GraphtreeencodingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_frame_min(s : GraphtreeencodingFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_frame_max(s : GraphtreeencodingFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_frame_to_string(s : GraphtreeencodingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_table_make(size : Int) -> GraphtreeencodingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_table_len(s : GraphtreeencodingTable) -> Int { s.size }

pub fn graph_tree_encoding_table_get(s : GraphtreeencodingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_table_set(s : GraphtreeencodingTable, i : Int, v : Double) -> GraphtreeencodingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_table_sum(s : GraphtreeencodingTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_table_mean(s : GraphtreeencodingTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_table_scale(s : GraphtreeencodingTable, f : Double) -> GraphtreeencodingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_table_add(a : GraphtreeencodingTable, b : GraphtreeencodingTable) -> GraphtreeencodingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_table_copy(s : GraphtreeencodingTable) -> GraphtreeencodingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_table_fill(s : GraphtreeencodingTable, v : Double) -> GraphtreeencodingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_table_min(s : GraphtreeencodingTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_table_max(s : GraphtreeencodingTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_table_to_string(s : GraphtreeencodingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_graphn_make(size : Int) -> GraphtreeencodingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_graphn_len(s : GraphtreeencodingGraphN) -> Int { s.size }

pub fn graph_tree_encoding_graphn_get(s : GraphtreeencodingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_graphn_set(s : GraphtreeencodingGraphN, i : Int, v : Double) -> GraphtreeencodingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_graphn_sum(s : GraphtreeencodingGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_graphn_mean(s : GraphtreeencodingGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_graphn_scale(s : GraphtreeencodingGraphN, f : Double) -> GraphtreeencodingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_graphn_add(a : GraphtreeencodingGraphN, b : GraphtreeencodingGraphN) -> GraphtreeencodingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_graphn_copy(s : GraphtreeencodingGraphN) -> GraphtreeencodingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_graphn_fill(s : GraphtreeencodingGraphN, v : Double) -> GraphtreeencodingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_graphn_min(s : GraphtreeencodingGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_graphn_max(s : GraphtreeencodingGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_graphn_to_string(s : GraphtreeencodingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_node_make(size : Int) -> GraphtreeencodingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_node_len(s : GraphtreeencodingNode) -> Int { s.size }

pub fn graph_tree_encoding_node_get(s : GraphtreeencodingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_node_set(s : GraphtreeencodingNode, i : Int, v : Double) -> GraphtreeencodingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_node_sum(s : GraphtreeencodingNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_node_mean(s : GraphtreeencodingNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_node_scale(s : GraphtreeencodingNode, f : Double) -> GraphtreeencodingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_node_add(a : GraphtreeencodingNode, b : GraphtreeencodingNode) -> GraphtreeencodingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_node_copy(s : GraphtreeencodingNode) -> GraphtreeencodingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_node_fill(s : GraphtreeencodingNode, v : Double) -> GraphtreeencodingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_node_min(s : GraphtreeencodingNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_node_max(s : GraphtreeencodingNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_node_to_string(s : GraphtreeencodingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_edge_make(size : Int) -> GraphtreeencodingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_edge_len(s : GraphtreeencodingEdge) -> Int { s.size }

pub fn graph_tree_encoding_edge_get(s : GraphtreeencodingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_edge_set(s : GraphtreeencodingEdge, i : Int, v : Double) -> GraphtreeencodingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_edge_sum(s : GraphtreeencodingEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_edge_mean(s : GraphtreeencodingEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_edge_scale(s : GraphtreeencodingEdge, f : Double) -> GraphtreeencodingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_edge_add(a : GraphtreeencodingEdge, b : GraphtreeencodingEdge) -> GraphtreeencodingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_edge_copy(s : GraphtreeencodingEdge) -> GraphtreeencodingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_edge_fill(s : GraphtreeencodingEdge, v : Double) -> GraphtreeencodingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_edge_min(s : GraphtreeencodingEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_edge_max(s : GraphtreeencodingEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_edge_to_string(s : GraphtreeencodingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_path_make(size : Int) -> GraphtreeencodingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_path_len(s : GraphtreeencodingPath) -> Int { s.size }

pub fn graph_tree_encoding_path_get(s : GraphtreeencodingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_path_set(s : GraphtreeencodingPath, i : Int, v : Double) -> GraphtreeencodingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_path_sum(s : GraphtreeencodingPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_path_mean(s : GraphtreeencodingPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_path_scale(s : GraphtreeencodingPath, f : Double) -> GraphtreeencodingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_path_add(a : GraphtreeencodingPath, b : GraphtreeencodingPath) -> GraphtreeencodingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_path_copy(s : GraphtreeencodingPath) -> GraphtreeencodingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_path_fill(s : GraphtreeencodingPath, v : Double) -> GraphtreeencodingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_path_min(s : GraphtreeencodingPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_path_max(s : GraphtreeencodingPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_path_to_string(s : GraphtreeencodingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_cluster_make(size : Int) -> GraphtreeencodingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_cluster_len(s : GraphtreeencodingCluster) -> Int { s.size }

pub fn graph_tree_encoding_cluster_get(s : GraphtreeencodingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_cluster_set(s : GraphtreeencodingCluster, i : Int, v : Double) -> GraphtreeencodingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_cluster_sum(s : GraphtreeencodingCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_cluster_mean(s : GraphtreeencodingCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_cluster_scale(s : GraphtreeencodingCluster, f : Double) -> GraphtreeencodingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_cluster_add(a : GraphtreeencodingCluster, b : GraphtreeencodingCluster) -> GraphtreeencodingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_cluster_copy(s : GraphtreeencodingCluster) -> GraphtreeencodingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_cluster_fill(s : GraphtreeencodingCluster, v : Double) -> GraphtreeencodingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_cluster_min(s : GraphtreeencodingCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_cluster_max(s : GraphtreeencodingCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_cluster_to_string(s : GraphtreeencodingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_model_make(size : Int) -> GraphtreeencodingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_model_len(s : GraphtreeencodingModel) -> Int { s.size }

pub fn graph_tree_encoding_model_get(s : GraphtreeencodingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_model_set(s : GraphtreeencodingModel, i : Int, v : Double) -> GraphtreeencodingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_model_sum(s : GraphtreeencodingModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_model_mean(s : GraphtreeencodingModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_model_scale(s : GraphtreeencodingModel, f : Double) -> GraphtreeencodingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_model_add(a : GraphtreeencodingModel, b : GraphtreeencodingModel) -> GraphtreeencodingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_model_copy(s : GraphtreeencodingModel) -> GraphtreeencodingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_model_fill(s : GraphtreeencodingModel, v : Double) -> GraphtreeencodingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_model_min(s : GraphtreeencodingModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_model_max(s : GraphtreeencodingModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_model_to_string(s : GraphtreeencodingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_layer_make(size : Int) -> GraphtreeencodingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_layer_len(s : GraphtreeencodingLayer) -> Int { s.size }

pub fn graph_tree_encoding_layer_get(s : GraphtreeencodingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_layer_set(s : GraphtreeencodingLayer, i : Int, v : Double) -> GraphtreeencodingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_layer_sum(s : GraphtreeencodingLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_layer_mean(s : GraphtreeencodingLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_layer_scale(s : GraphtreeencodingLayer, f : Double) -> GraphtreeencodingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_layer_add(a : GraphtreeencodingLayer, b : GraphtreeencodingLayer) -> GraphtreeencodingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_layer_copy(s : GraphtreeencodingLayer) -> GraphtreeencodingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_layer_fill(s : GraphtreeencodingLayer, v : Double) -> GraphtreeencodingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_layer_min(s : GraphtreeencodingLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_layer_max(s : GraphtreeencodingLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_layer_to_string(s : GraphtreeencodingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_buffer_make(size : Int) -> GraphtreeencodingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_buffer_len(s : GraphtreeencodingBuffer) -> Int { s.size }

pub fn graph_tree_encoding_buffer_get(s : GraphtreeencodingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_buffer_set(s : GraphtreeencodingBuffer, i : Int, v : Double) -> GraphtreeencodingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_buffer_sum(s : GraphtreeencodingBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_buffer_mean(s : GraphtreeencodingBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_buffer_scale(s : GraphtreeencodingBuffer, f : Double) -> GraphtreeencodingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_buffer_add(a : GraphtreeencodingBuffer, b : GraphtreeencodingBuffer) -> GraphtreeencodingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_buffer_copy(s : GraphtreeencodingBuffer) -> GraphtreeencodingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_buffer_fill(s : GraphtreeencodingBuffer, v : Double) -> GraphtreeencodingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_buffer_min(s : GraphtreeencodingBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_buffer_max(s : GraphtreeencodingBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_buffer_to_string(s : GraphtreeencodingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_cursor_make(size : Int) -> GraphtreeencodingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_cursor_len(s : GraphtreeencodingCursor) -> Int { s.size }

pub fn graph_tree_encoding_cursor_get(s : GraphtreeencodingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_cursor_set(s : GraphtreeencodingCursor, i : Int, v : Double) -> GraphtreeencodingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_cursor_sum(s : GraphtreeencodingCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_cursor_mean(s : GraphtreeencodingCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_cursor_scale(s : GraphtreeencodingCursor, f : Double) -> GraphtreeencodingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_cursor_add(a : GraphtreeencodingCursor, b : GraphtreeencodingCursor) -> GraphtreeencodingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_cursor_copy(s : GraphtreeencodingCursor) -> GraphtreeencodingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_cursor_fill(s : GraphtreeencodingCursor, v : Double) -> GraphtreeencodingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_cursor_min(s : GraphtreeencodingCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_cursor_max(s : GraphtreeencodingCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_cursor_to_string(s : GraphtreeencodingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_view_make(size : Int) -> GraphtreeencodingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_view_len(s : GraphtreeencodingView) -> Int { s.size }

pub fn graph_tree_encoding_view_get(s : GraphtreeencodingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_view_set(s : GraphtreeencodingView, i : Int, v : Double) -> GraphtreeencodingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_view_sum(s : GraphtreeencodingView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_view_mean(s : GraphtreeencodingView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_view_scale(s : GraphtreeencodingView, f : Double) -> GraphtreeencodingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_view_add(a : GraphtreeencodingView, b : GraphtreeencodingView) -> GraphtreeencodingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_view_copy(s : GraphtreeencodingView) -> GraphtreeencodingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_view_fill(s : GraphtreeencodingView, v : Double) -> GraphtreeencodingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_view_min(s : GraphtreeencodingView) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_view_max(s : GraphtreeencodingView) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_view_to_string(s : GraphtreeencodingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_range_make(size : Int) -> GraphtreeencodingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_range_len(s : GraphtreeencodingRange) -> Int { s.size }

pub fn graph_tree_encoding_range_get(s : GraphtreeencodingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_range_set(s : GraphtreeencodingRange, i : Int, v : Double) -> GraphtreeencodingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_range_sum(s : GraphtreeencodingRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_range_mean(s : GraphtreeencodingRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_range_scale(s : GraphtreeencodingRange, f : Double) -> GraphtreeencodingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_range_add(a : GraphtreeencodingRange, b : GraphtreeencodingRange) -> GraphtreeencodingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_range_copy(s : GraphtreeencodingRange) -> GraphtreeencodingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_range_fill(s : GraphtreeencodingRange, v : Double) -> GraphtreeencodingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_range_min(s : GraphtreeencodingRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_range_max(s : GraphtreeencodingRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_range_to_string(s : GraphtreeencodingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_slice_make(size : Int) -> GraphtreeencodingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_slice_len(s : GraphtreeencodingSlice) -> Int { s.size }

pub fn graph_tree_encoding_slice_get(s : GraphtreeencodingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_slice_set(s : GraphtreeencodingSlice, i : Int, v : Double) -> GraphtreeencodingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_slice_sum(s : GraphtreeencodingSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_encoding_slice_mean(s : GraphtreeencodingSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_encoding_slice_scale(s : GraphtreeencodingSlice, f : Double) -> GraphtreeencodingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_slice_add(a : GraphtreeencodingSlice, b : GraphtreeencodingSlice) -> GraphtreeencodingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_encoding_slice_copy(s : GraphtreeencodingSlice) -> GraphtreeencodingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_slice_fill(s : GraphtreeencodingSlice, v : Double) -> GraphtreeencodingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_encoding_slice_min(s : GraphtreeencodingSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_encoding_slice_max(s : GraphtreeencodingSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_encoding_slice_to_string(s : GraphtreeencodingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

