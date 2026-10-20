///===
/// extcore/graph_connect_strong

pub(all) struct GraphconnectstrongPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_strong_make_point(x : Double, y : Double) -> GraphconnectstrongPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_strong_make_point3(x : Double, y : Double, z : Double) -> GraphconnectstrongPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_strong_point_x(pt : GraphconnectstrongPoint) -> Double { pt.x }

pub fn graph_connect_strong_point_y(pt : GraphconnectstrongPoint) -> Double { pt.y }

pub fn graph_connect_strong_point_z(pt : GraphconnectstrongPoint) -> Double { pt.z }

pub fn graph_connect_strong_point_label(pt : GraphconnectstrongPoint) -> Int { pt.label }

pub fn graph_connect_strong_point_dist(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_strong_point_add(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_strong_point_sub(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_strong_point_scale(pt : GraphconnectstrongPoint, s : Double) -> GraphconnectstrongPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_strong_point_dot(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_strong_point_cross(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_strong_point_norm(pt : GraphconnectstrongPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_strong_point_normalize(pt : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  let n = graph_connect_strong_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_strong_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_strong_point_negate(pt : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_strong_point_mid(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_strong_point_lerp(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint, t : Double) -> GraphconnectstrongPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_strong_point_to_string(pt : GraphconnectstrongPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectstrongSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_strong_make_series(vals : Array[Double], name : String) -> GraphconnectstrongSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_strong_series_len(s : GraphconnectstrongSeries) -> Int { s.vals.length() }

pub fn graph_connect_strong_series_sum(s : GraphconnectstrongSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_connect_strong_series_mean(s : GraphconnectstrongSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_connect_strong_series_min(s : GraphconnectstrongSeries) -> Double { @_common.min(s.vals) }

pub fn graph_connect_strong_series_max(s : GraphconnectstrongSeries) -> Double { @_common.max(s.vals) }

pub fn graph_connect_strong_series_range(s : GraphconnectstrongSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_connect_strong_series_var(s : GraphconnectstrongSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_connect_strong_series_std(s : GraphconnectstrongSeries) -> Double { @_common.std(s.vals) }

pub fn graph_connect_strong_series_median(s : GraphconnectstrongSeries) -> Double { @_common.median(s.vals) }

pub fn graph_connect_strong_series_scale(s : GraphconnectstrongSeries, f : Double) -> GraphconnectstrongSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_connect_strong_series_add(a : GraphconnectstrongSeries, b : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_strong_series_sub(a : GraphconnectstrongSeries, b : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_strong_series_normalize(s : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  let mn = graph_connect_strong_series_min(s)
  let mx = graph_connect_strong_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_strong_series_cumsum(s : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_strong_series_to_string(s : GraphconnectstrongSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectstrongMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_strong_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectstrongMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_strong_matrix_identity(n : Int) -> GraphconnectstrongMatrix {
  let m = graph_connect_strong_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_strong_matrix_get(m : GraphconnectstrongMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_strong_matrix_transpose(m : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  let result = graph_connect_strong_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_strong_matrix_add(a : GraphconnectstrongMatrix, b : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_strong_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_strong_matrix_scale(m : GraphconnectstrongMatrix, s : Double) -> GraphconnectstrongMatrix {
  let result = graph_connect_strong_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_strong_matrix_multiply(a : GraphconnectstrongMatrix, b : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  if a.cols != b.rows { return graph_connect_strong_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_strong_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_strong_matrix_trace(m : GraphconnectstrongMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_strong_matrix_det(m : GraphconnectstrongMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_strong_matrix_norm(m : GraphconnectstrongMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_strong_matrix_to_string(m : GraphconnectstrongMatrix) -> String {
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

pub(all) struct GraphconnectstrongVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_strong_make_vector(comps : Array[Double]) -> GraphconnectstrongVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_strong_vector_zero(dim : Int) -> GraphconnectstrongVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_strong_vector_add(a : GraphconnectstrongVector, b : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_connect_strong_vector_sub(a : GraphconnectstrongVector, b : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_connect_strong_vector_scale(v : GraphconnectstrongVector, s : Double) -> GraphconnectstrongVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_connect_strong_vector_dot(a : GraphconnectstrongVector, b : GraphconnectstrongVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_strong_vector_norm(v : GraphconnectstrongVector) -> Double { @_common.sqrt(graph_connect_strong_vector_dot(v, v)) }

pub fn graph_connect_strong_vector_normalize(v : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = graph_connect_strong_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_strong_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_strong_vector_dist(a : GraphconnectstrongVector, b : GraphconnectstrongVector) -> Double {
  graph_connect_strong_vector_norm(graph_connect_strong_vector_sub(a, b))
}

pub fn graph_connect_strong_vector_to_string(v : GraphconnectstrongVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_strong_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_strong_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_strong_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_strong_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_strong_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_strong_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_strong_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_strong_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_strong_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_strong_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_strong_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_strong_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_strong_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_strong_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_strong_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_strong_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_strong_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_strong_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_strong_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_strong_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_strong_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_strong_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_strong_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_strong_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_strong_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_strong_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_strong_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_strong_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_strong_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectstrongFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_frame_make(size : Int) -> GraphconnectstrongFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_frame_len(s : GraphconnectstrongFrame) -> Int { s.size }

pub fn graph_connect_strong_frame_get(s : GraphconnectstrongFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_frame_set(s : GraphconnectstrongFrame, i : Int, v : Double) -> GraphconnectstrongFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_frame_sum(s : GraphconnectstrongFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_frame_mean(s : GraphconnectstrongFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_frame_scale(s : GraphconnectstrongFrame, f : Double) -> GraphconnectstrongFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_frame_add(a : GraphconnectstrongFrame, b : GraphconnectstrongFrame) -> GraphconnectstrongFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_frame_copy(s : GraphconnectstrongFrame) -> GraphconnectstrongFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_frame_fill(s : GraphconnectstrongFrame, v : Double) -> GraphconnectstrongFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_frame_min(s : GraphconnectstrongFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_frame_max(s : GraphconnectstrongFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_frame_to_string(s : GraphconnectstrongFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_table_make(size : Int) -> GraphconnectstrongTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_table_len(s : GraphconnectstrongTable) -> Int { s.size }

pub fn graph_connect_strong_table_get(s : GraphconnectstrongTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_table_set(s : GraphconnectstrongTable, i : Int, v : Double) -> GraphconnectstrongTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_table_sum(s : GraphconnectstrongTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_table_mean(s : GraphconnectstrongTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_table_scale(s : GraphconnectstrongTable, f : Double) -> GraphconnectstrongTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_table_add(a : GraphconnectstrongTable, b : GraphconnectstrongTable) -> GraphconnectstrongTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_table_copy(s : GraphconnectstrongTable) -> GraphconnectstrongTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_table_fill(s : GraphconnectstrongTable, v : Double) -> GraphconnectstrongTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_table_min(s : GraphconnectstrongTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_table_max(s : GraphconnectstrongTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_table_to_string(s : GraphconnectstrongTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_graphn_make(size : Int) -> GraphconnectstrongGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_graphn_len(s : GraphconnectstrongGraphN) -> Int { s.size }

pub fn graph_connect_strong_graphn_get(s : GraphconnectstrongGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_graphn_set(s : GraphconnectstrongGraphN, i : Int, v : Double) -> GraphconnectstrongGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_graphn_sum(s : GraphconnectstrongGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_graphn_mean(s : GraphconnectstrongGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_graphn_scale(s : GraphconnectstrongGraphN, f : Double) -> GraphconnectstrongGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_graphn_add(a : GraphconnectstrongGraphN, b : GraphconnectstrongGraphN) -> GraphconnectstrongGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_graphn_copy(s : GraphconnectstrongGraphN) -> GraphconnectstrongGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_graphn_fill(s : GraphconnectstrongGraphN, v : Double) -> GraphconnectstrongGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_graphn_min(s : GraphconnectstrongGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_graphn_max(s : GraphconnectstrongGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_graphn_to_string(s : GraphconnectstrongGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_node_make(size : Int) -> GraphconnectstrongNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_node_len(s : GraphconnectstrongNode) -> Int { s.size }

pub fn graph_connect_strong_node_get(s : GraphconnectstrongNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_node_set(s : GraphconnectstrongNode, i : Int, v : Double) -> GraphconnectstrongNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_node_sum(s : GraphconnectstrongNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_node_mean(s : GraphconnectstrongNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_node_scale(s : GraphconnectstrongNode, f : Double) -> GraphconnectstrongNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_node_add(a : GraphconnectstrongNode, b : GraphconnectstrongNode) -> GraphconnectstrongNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_node_copy(s : GraphconnectstrongNode) -> GraphconnectstrongNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_node_fill(s : GraphconnectstrongNode, v : Double) -> GraphconnectstrongNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_node_min(s : GraphconnectstrongNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_node_max(s : GraphconnectstrongNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_node_to_string(s : GraphconnectstrongNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_edge_make(size : Int) -> GraphconnectstrongEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_edge_len(s : GraphconnectstrongEdge) -> Int { s.size }

pub fn graph_connect_strong_edge_get(s : GraphconnectstrongEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_edge_set(s : GraphconnectstrongEdge, i : Int, v : Double) -> GraphconnectstrongEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_edge_sum(s : GraphconnectstrongEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_edge_mean(s : GraphconnectstrongEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_edge_scale(s : GraphconnectstrongEdge, f : Double) -> GraphconnectstrongEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_edge_add(a : GraphconnectstrongEdge, b : GraphconnectstrongEdge) -> GraphconnectstrongEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_edge_copy(s : GraphconnectstrongEdge) -> GraphconnectstrongEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_edge_fill(s : GraphconnectstrongEdge, v : Double) -> GraphconnectstrongEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_edge_min(s : GraphconnectstrongEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_edge_max(s : GraphconnectstrongEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_edge_to_string(s : GraphconnectstrongEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_path_make(size : Int) -> GraphconnectstrongPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_path_len(s : GraphconnectstrongPath) -> Int { s.size }

pub fn graph_connect_strong_path_get(s : GraphconnectstrongPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_path_set(s : GraphconnectstrongPath, i : Int, v : Double) -> GraphconnectstrongPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_path_sum(s : GraphconnectstrongPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_path_mean(s : GraphconnectstrongPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_path_scale(s : GraphconnectstrongPath, f : Double) -> GraphconnectstrongPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_path_add(a : GraphconnectstrongPath, b : GraphconnectstrongPath) -> GraphconnectstrongPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_path_copy(s : GraphconnectstrongPath) -> GraphconnectstrongPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_path_fill(s : GraphconnectstrongPath, v : Double) -> GraphconnectstrongPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_path_min(s : GraphconnectstrongPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_path_max(s : GraphconnectstrongPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_path_to_string(s : GraphconnectstrongPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_cluster_make(size : Int) -> GraphconnectstrongCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_cluster_len(s : GraphconnectstrongCluster) -> Int { s.size }

pub fn graph_connect_strong_cluster_get(s : GraphconnectstrongCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_cluster_set(s : GraphconnectstrongCluster, i : Int, v : Double) -> GraphconnectstrongCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cluster_sum(s : GraphconnectstrongCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_cluster_mean(s : GraphconnectstrongCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_cluster_scale(s : GraphconnectstrongCluster, f : Double) -> GraphconnectstrongCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cluster_add(a : GraphconnectstrongCluster, b : GraphconnectstrongCluster) -> GraphconnectstrongCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_cluster_copy(s : GraphconnectstrongCluster) -> GraphconnectstrongCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cluster_fill(s : GraphconnectstrongCluster, v : Double) -> GraphconnectstrongCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cluster_min(s : GraphconnectstrongCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_cluster_max(s : GraphconnectstrongCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_cluster_to_string(s : GraphconnectstrongCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_model_make(size : Int) -> GraphconnectstrongModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_model_len(s : GraphconnectstrongModel) -> Int { s.size }

pub fn graph_connect_strong_model_get(s : GraphconnectstrongModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_model_set(s : GraphconnectstrongModel, i : Int, v : Double) -> GraphconnectstrongModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_model_sum(s : GraphconnectstrongModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_model_mean(s : GraphconnectstrongModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_model_scale(s : GraphconnectstrongModel, f : Double) -> GraphconnectstrongModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_model_add(a : GraphconnectstrongModel, b : GraphconnectstrongModel) -> GraphconnectstrongModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_model_copy(s : GraphconnectstrongModel) -> GraphconnectstrongModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_model_fill(s : GraphconnectstrongModel, v : Double) -> GraphconnectstrongModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_model_min(s : GraphconnectstrongModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_model_max(s : GraphconnectstrongModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_model_to_string(s : GraphconnectstrongModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_layer_make(size : Int) -> GraphconnectstrongLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_layer_len(s : GraphconnectstrongLayer) -> Int { s.size }

pub fn graph_connect_strong_layer_get(s : GraphconnectstrongLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_layer_set(s : GraphconnectstrongLayer, i : Int, v : Double) -> GraphconnectstrongLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_layer_sum(s : GraphconnectstrongLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_layer_mean(s : GraphconnectstrongLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_layer_scale(s : GraphconnectstrongLayer, f : Double) -> GraphconnectstrongLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_layer_add(a : GraphconnectstrongLayer, b : GraphconnectstrongLayer) -> GraphconnectstrongLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_layer_copy(s : GraphconnectstrongLayer) -> GraphconnectstrongLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_layer_fill(s : GraphconnectstrongLayer, v : Double) -> GraphconnectstrongLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_layer_min(s : GraphconnectstrongLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_layer_max(s : GraphconnectstrongLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_layer_to_string(s : GraphconnectstrongLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_buffer_make(size : Int) -> GraphconnectstrongBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_buffer_len(s : GraphconnectstrongBuffer) -> Int { s.size }

pub fn graph_connect_strong_buffer_get(s : GraphconnectstrongBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_buffer_set(s : GraphconnectstrongBuffer, i : Int, v : Double) -> GraphconnectstrongBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_buffer_sum(s : GraphconnectstrongBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_buffer_mean(s : GraphconnectstrongBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_buffer_scale(s : GraphconnectstrongBuffer, f : Double) -> GraphconnectstrongBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_buffer_add(a : GraphconnectstrongBuffer, b : GraphconnectstrongBuffer) -> GraphconnectstrongBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_buffer_copy(s : GraphconnectstrongBuffer) -> GraphconnectstrongBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_buffer_fill(s : GraphconnectstrongBuffer, v : Double) -> GraphconnectstrongBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_buffer_min(s : GraphconnectstrongBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_buffer_max(s : GraphconnectstrongBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_buffer_to_string(s : GraphconnectstrongBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_cursor_make(size : Int) -> GraphconnectstrongCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_cursor_len(s : GraphconnectstrongCursor) -> Int { s.size }

pub fn graph_connect_strong_cursor_get(s : GraphconnectstrongCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_cursor_set(s : GraphconnectstrongCursor, i : Int, v : Double) -> GraphconnectstrongCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cursor_sum(s : GraphconnectstrongCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_cursor_mean(s : GraphconnectstrongCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_cursor_scale(s : GraphconnectstrongCursor, f : Double) -> GraphconnectstrongCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cursor_add(a : GraphconnectstrongCursor, b : GraphconnectstrongCursor) -> GraphconnectstrongCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_cursor_copy(s : GraphconnectstrongCursor) -> GraphconnectstrongCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cursor_fill(s : GraphconnectstrongCursor, v : Double) -> GraphconnectstrongCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cursor_min(s : GraphconnectstrongCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_cursor_max(s : GraphconnectstrongCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_cursor_to_string(s : GraphconnectstrongCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_view_make(size : Int) -> GraphconnectstrongView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_view_len(s : GraphconnectstrongView) -> Int { s.size }

pub fn graph_connect_strong_view_get(s : GraphconnectstrongView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_view_set(s : GraphconnectstrongView, i : Int, v : Double) -> GraphconnectstrongView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_view_sum(s : GraphconnectstrongView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_view_mean(s : GraphconnectstrongView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_view_scale(s : GraphconnectstrongView, f : Double) -> GraphconnectstrongView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_view_add(a : GraphconnectstrongView, b : GraphconnectstrongView) -> GraphconnectstrongView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_view_copy(s : GraphconnectstrongView) -> GraphconnectstrongView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_view_fill(s : GraphconnectstrongView, v : Double) -> GraphconnectstrongView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_view_min(s : GraphconnectstrongView) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_view_max(s : GraphconnectstrongView) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_view_to_string(s : GraphconnectstrongView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_range_make(size : Int) -> GraphconnectstrongRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_range_len(s : GraphconnectstrongRange) -> Int { s.size }

pub fn graph_connect_strong_range_get(s : GraphconnectstrongRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_range_set(s : GraphconnectstrongRange, i : Int, v : Double) -> GraphconnectstrongRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_range_sum(s : GraphconnectstrongRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_range_mean(s : GraphconnectstrongRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_range_scale(s : GraphconnectstrongRange, f : Double) -> GraphconnectstrongRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_range_add(a : GraphconnectstrongRange, b : GraphconnectstrongRange) -> GraphconnectstrongRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_range_copy(s : GraphconnectstrongRange) -> GraphconnectstrongRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_range_fill(s : GraphconnectstrongRange, v : Double) -> GraphconnectstrongRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_range_min(s : GraphconnectstrongRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_range_max(s : GraphconnectstrongRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_range_to_string(s : GraphconnectstrongRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_slice_make(size : Int) -> GraphconnectstrongSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_slice_len(s : GraphconnectstrongSlice) -> Int { s.size }

pub fn graph_connect_strong_slice_get(s : GraphconnectstrongSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_slice_set(s : GraphconnectstrongSlice, i : Int, v : Double) -> GraphconnectstrongSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_slice_sum(s : GraphconnectstrongSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_slice_mean(s : GraphconnectstrongSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_slice_scale(s : GraphconnectstrongSlice, f : Double) -> GraphconnectstrongSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_slice_add(a : GraphconnectstrongSlice, b : GraphconnectstrongSlice) -> GraphconnectstrongSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_slice_copy(s : GraphconnectstrongSlice) -> GraphconnectstrongSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_slice_fill(s : GraphconnectstrongSlice, v : Double) -> GraphconnectstrongSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_slice_min(s : GraphconnectstrongSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_slice_max(s : GraphconnectstrongSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_slice_to_string(s : GraphconnectstrongSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

