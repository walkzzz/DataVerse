///===
/// extcore/graph_connect_paths

pub(all) struct GraphconnectpathsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_paths_make_point(x : Double, y : Double) -> GraphconnectpathsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_paths_make_point3(x : Double, y : Double, z : Double) -> GraphconnectpathsPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_paths_point_x(pt : GraphconnectpathsPoint) -> Double { pt.x }

pub fn graph_connect_paths_point_y(pt : GraphconnectpathsPoint) -> Double { pt.y }

pub fn graph_connect_paths_point_z(pt : GraphconnectpathsPoint) -> Double { pt.z }

pub fn graph_connect_paths_point_label(pt : GraphconnectpathsPoint) -> Int { pt.label }

pub fn graph_connect_paths_point_dist(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_paths_point_add(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_paths_point_sub(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_paths_point_scale(pt : GraphconnectpathsPoint, s : Double) -> GraphconnectpathsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_paths_point_dot(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_paths_point_cross(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_paths_point_norm(pt : GraphconnectpathsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_paths_point_normalize(pt : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  let n = graph_connect_paths_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_paths_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_paths_point_negate(pt : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_paths_point_mid(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_paths_point_lerp(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint, t : Double) -> GraphconnectpathsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_paths_point_to_string(pt : GraphconnectpathsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectpathsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_paths_make_series(vals : Array[Double], name : String) -> GraphconnectpathsSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_paths_series_len(s : GraphconnectpathsSeries) -> Int { s.vals.length() }

pub fn graph_connect_paths_series_sum(s : GraphconnectpathsSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_connect_paths_series_mean(s : GraphconnectpathsSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_connect_paths_series_min(s : GraphconnectpathsSeries) -> Double { @_common.min(s.vals) }

pub fn graph_connect_paths_series_max(s : GraphconnectpathsSeries) -> Double { @_common.max(s.vals) }

pub fn graph_connect_paths_series_range(s : GraphconnectpathsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_connect_paths_series_var(s : GraphconnectpathsSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_connect_paths_series_std(s : GraphconnectpathsSeries) -> Double { @_common.std(s.vals) }

pub fn graph_connect_paths_series_median(s : GraphconnectpathsSeries) -> Double { @_common.median(s.vals) }

pub fn graph_connect_paths_series_scale(s : GraphconnectpathsSeries, f : Double) -> GraphconnectpathsSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_connect_paths_series_add(a : GraphconnectpathsSeries, b : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_paths_series_sub(a : GraphconnectpathsSeries, b : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_paths_series_normalize(s : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  let mn = graph_connect_paths_series_min(s)
  let mx = graph_connect_paths_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_paths_series_cumsum(s : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_paths_series_to_string(s : GraphconnectpathsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectpathsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_paths_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectpathsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_paths_matrix_identity(n : Int) -> GraphconnectpathsMatrix {
  let m = graph_connect_paths_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_paths_matrix_get(m : GraphconnectpathsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_paths_matrix_transpose(m : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  let result = graph_connect_paths_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_paths_matrix_add(a : GraphconnectpathsMatrix, b : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_paths_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_paths_matrix_scale(m : GraphconnectpathsMatrix, s : Double) -> GraphconnectpathsMatrix {
  let result = graph_connect_paths_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_paths_matrix_multiply(a : GraphconnectpathsMatrix, b : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  if a.cols != b.rows { return graph_connect_paths_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_paths_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_paths_matrix_trace(m : GraphconnectpathsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_paths_matrix_det(m : GraphconnectpathsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_paths_matrix_norm(m : GraphconnectpathsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_paths_matrix_to_string(m : GraphconnectpathsMatrix) -> String {
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

pub(all) struct GraphconnectpathsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_paths_make_vector(comps : Array[Double]) -> GraphconnectpathsVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_paths_vector_zero(dim : Int) -> GraphconnectpathsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_paths_vector_add(a : GraphconnectpathsVector, b : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_connect_paths_vector_sub(a : GraphconnectpathsVector, b : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_connect_paths_vector_scale(v : GraphconnectpathsVector, s : Double) -> GraphconnectpathsVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_connect_paths_vector_dot(a : GraphconnectpathsVector, b : GraphconnectpathsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_paths_vector_norm(v : GraphconnectpathsVector) -> Double { @_common.sqrt(graph_connect_paths_vector_dot(v, v)) }

pub fn graph_connect_paths_vector_normalize(v : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = graph_connect_paths_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_paths_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_paths_vector_dist(a : GraphconnectpathsVector, b : GraphconnectpathsVector) -> Double {
  graph_connect_paths_vector_norm(graph_connect_paths_vector_sub(a, b))
}

pub fn graph_connect_paths_vector_to_string(v : GraphconnectpathsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_paths_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_paths_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_paths_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_paths_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_paths_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_paths_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_paths_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_paths_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_paths_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_paths_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_paths_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_paths_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_paths_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_paths_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_paths_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_paths_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_paths_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_paths_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_paths_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_paths_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_paths_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_paths_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_paths_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_paths_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_paths_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_paths_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_paths_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_paths_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_paths_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectpathsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_frame_make(size : Int) -> GraphconnectpathsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_frame_len(s : GraphconnectpathsFrame) -> Int { s.size }

pub fn graph_connect_paths_frame_get(s : GraphconnectpathsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_frame_set(s : GraphconnectpathsFrame, i : Int, v : Double) -> GraphconnectpathsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_frame_sum(s : GraphconnectpathsFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_frame_mean(s : GraphconnectpathsFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_frame_scale(s : GraphconnectpathsFrame, f : Double) -> GraphconnectpathsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_frame_add(a : GraphconnectpathsFrame, b : GraphconnectpathsFrame) -> GraphconnectpathsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_frame_copy(s : GraphconnectpathsFrame) -> GraphconnectpathsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_frame_fill(s : GraphconnectpathsFrame, v : Double) -> GraphconnectpathsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_frame_min(s : GraphconnectpathsFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_frame_max(s : GraphconnectpathsFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_frame_to_string(s : GraphconnectpathsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_table_make(size : Int) -> GraphconnectpathsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_table_len(s : GraphconnectpathsTable) -> Int { s.size }

pub fn graph_connect_paths_table_get(s : GraphconnectpathsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_table_set(s : GraphconnectpathsTable, i : Int, v : Double) -> GraphconnectpathsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_table_sum(s : GraphconnectpathsTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_table_mean(s : GraphconnectpathsTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_table_scale(s : GraphconnectpathsTable, f : Double) -> GraphconnectpathsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_table_add(a : GraphconnectpathsTable, b : GraphconnectpathsTable) -> GraphconnectpathsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_table_copy(s : GraphconnectpathsTable) -> GraphconnectpathsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_table_fill(s : GraphconnectpathsTable, v : Double) -> GraphconnectpathsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_table_min(s : GraphconnectpathsTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_table_max(s : GraphconnectpathsTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_table_to_string(s : GraphconnectpathsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_graphn_make(size : Int) -> GraphconnectpathsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_graphn_len(s : GraphconnectpathsGraphN) -> Int { s.size }

pub fn graph_connect_paths_graphn_get(s : GraphconnectpathsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_graphn_set(s : GraphconnectpathsGraphN, i : Int, v : Double) -> GraphconnectpathsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_graphn_sum(s : GraphconnectpathsGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_graphn_mean(s : GraphconnectpathsGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_graphn_scale(s : GraphconnectpathsGraphN, f : Double) -> GraphconnectpathsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_graphn_add(a : GraphconnectpathsGraphN, b : GraphconnectpathsGraphN) -> GraphconnectpathsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_graphn_copy(s : GraphconnectpathsGraphN) -> GraphconnectpathsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_graphn_fill(s : GraphconnectpathsGraphN, v : Double) -> GraphconnectpathsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_graphn_min(s : GraphconnectpathsGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_graphn_max(s : GraphconnectpathsGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_graphn_to_string(s : GraphconnectpathsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_node_make(size : Int) -> GraphconnectpathsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_node_len(s : GraphconnectpathsNode) -> Int { s.size }

pub fn graph_connect_paths_node_get(s : GraphconnectpathsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_node_set(s : GraphconnectpathsNode, i : Int, v : Double) -> GraphconnectpathsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_node_sum(s : GraphconnectpathsNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_node_mean(s : GraphconnectpathsNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_node_scale(s : GraphconnectpathsNode, f : Double) -> GraphconnectpathsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_node_add(a : GraphconnectpathsNode, b : GraphconnectpathsNode) -> GraphconnectpathsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_node_copy(s : GraphconnectpathsNode) -> GraphconnectpathsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_node_fill(s : GraphconnectpathsNode, v : Double) -> GraphconnectpathsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_node_min(s : GraphconnectpathsNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_node_max(s : GraphconnectpathsNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_node_to_string(s : GraphconnectpathsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_edge_make(size : Int) -> GraphconnectpathsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_edge_len(s : GraphconnectpathsEdge) -> Int { s.size }

pub fn graph_connect_paths_edge_get(s : GraphconnectpathsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_edge_set(s : GraphconnectpathsEdge, i : Int, v : Double) -> GraphconnectpathsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_edge_sum(s : GraphconnectpathsEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_edge_mean(s : GraphconnectpathsEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_edge_scale(s : GraphconnectpathsEdge, f : Double) -> GraphconnectpathsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_edge_add(a : GraphconnectpathsEdge, b : GraphconnectpathsEdge) -> GraphconnectpathsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_edge_copy(s : GraphconnectpathsEdge) -> GraphconnectpathsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_edge_fill(s : GraphconnectpathsEdge, v : Double) -> GraphconnectpathsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_edge_min(s : GraphconnectpathsEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_edge_max(s : GraphconnectpathsEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_edge_to_string(s : GraphconnectpathsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_path_make(size : Int) -> GraphconnectpathsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_path_len(s : GraphconnectpathsPath) -> Int { s.size }

pub fn graph_connect_paths_path_get(s : GraphconnectpathsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_path_set(s : GraphconnectpathsPath, i : Int, v : Double) -> GraphconnectpathsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_path_sum(s : GraphconnectpathsPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_path_mean(s : GraphconnectpathsPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_path_scale(s : GraphconnectpathsPath, f : Double) -> GraphconnectpathsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_path_add(a : GraphconnectpathsPath, b : GraphconnectpathsPath) -> GraphconnectpathsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_path_copy(s : GraphconnectpathsPath) -> GraphconnectpathsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_path_fill(s : GraphconnectpathsPath, v : Double) -> GraphconnectpathsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_path_min(s : GraphconnectpathsPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_path_max(s : GraphconnectpathsPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_path_to_string(s : GraphconnectpathsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_cluster_make(size : Int) -> GraphconnectpathsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_cluster_len(s : GraphconnectpathsCluster) -> Int { s.size }

pub fn graph_connect_paths_cluster_get(s : GraphconnectpathsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_cluster_set(s : GraphconnectpathsCluster, i : Int, v : Double) -> GraphconnectpathsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_cluster_sum(s : GraphconnectpathsCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_cluster_mean(s : GraphconnectpathsCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_cluster_scale(s : GraphconnectpathsCluster, f : Double) -> GraphconnectpathsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_cluster_add(a : GraphconnectpathsCluster, b : GraphconnectpathsCluster) -> GraphconnectpathsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_cluster_copy(s : GraphconnectpathsCluster) -> GraphconnectpathsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_cluster_fill(s : GraphconnectpathsCluster, v : Double) -> GraphconnectpathsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_cluster_min(s : GraphconnectpathsCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_cluster_max(s : GraphconnectpathsCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_cluster_to_string(s : GraphconnectpathsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_model_make(size : Int) -> GraphconnectpathsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_model_len(s : GraphconnectpathsModel) -> Int { s.size }

pub fn graph_connect_paths_model_get(s : GraphconnectpathsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_model_set(s : GraphconnectpathsModel, i : Int, v : Double) -> GraphconnectpathsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_model_sum(s : GraphconnectpathsModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_model_mean(s : GraphconnectpathsModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_model_scale(s : GraphconnectpathsModel, f : Double) -> GraphconnectpathsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_model_add(a : GraphconnectpathsModel, b : GraphconnectpathsModel) -> GraphconnectpathsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_model_copy(s : GraphconnectpathsModel) -> GraphconnectpathsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_model_fill(s : GraphconnectpathsModel, v : Double) -> GraphconnectpathsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_model_min(s : GraphconnectpathsModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_model_max(s : GraphconnectpathsModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_model_to_string(s : GraphconnectpathsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_layer_make(size : Int) -> GraphconnectpathsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_layer_len(s : GraphconnectpathsLayer) -> Int { s.size }

pub fn graph_connect_paths_layer_get(s : GraphconnectpathsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_layer_set(s : GraphconnectpathsLayer, i : Int, v : Double) -> GraphconnectpathsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_layer_sum(s : GraphconnectpathsLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_layer_mean(s : GraphconnectpathsLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_layer_scale(s : GraphconnectpathsLayer, f : Double) -> GraphconnectpathsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_layer_add(a : GraphconnectpathsLayer, b : GraphconnectpathsLayer) -> GraphconnectpathsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_layer_copy(s : GraphconnectpathsLayer) -> GraphconnectpathsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_layer_fill(s : GraphconnectpathsLayer, v : Double) -> GraphconnectpathsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_layer_min(s : GraphconnectpathsLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_layer_max(s : GraphconnectpathsLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_layer_to_string(s : GraphconnectpathsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_buffer_make(size : Int) -> GraphconnectpathsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_buffer_len(s : GraphconnectpathsBuffer) -> Int { s.size }

pub fn graph_connect_paths_buffer_get(s : GraphconnectpathsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_buffer_set(s : GraphconnectpathsBuffer, i : Int, v : Double) -> GraphconnectpathsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_buffer_sum(s : GraphconnectpathsBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_buffer_mean(s : GraphconnectpathsBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_buffer_scale(s : GraphconnectpathsBuffer, f : Double) -> GraphconnectpathsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_buffer_add(a : GraphconnectpathsBuffer, b : GraphconnectpathsBuffer) -> GraphconnectpathsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_buffer_copy(s : GraphconnectpathsBuffer) -> GraphconnectpathsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_buffer_fill(s : GraphconnectpathsBuffer, v : Double) -> GraphconnectpathsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_buffer_min(s : GraphconnectpathsBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_buffer_max(s : GraphconnectpathsBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_buffer_to_string(s : GraphconnectpathsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_cursor_make(size : Int) -> GraphconnectpathsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_cursor_len(s : GraphconnectpathsCursor) -> Int { s.size }

pub fn graph_connect_paths_cursor_get(s : GraphconnectpathsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_cursor_set(s : GraphconnectpathsCursor, i : Int, v : Double) -> GraphconnectpathsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_cursor_sum(s : GraphconnectpathsCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_cursor_mean(s : GraphconnectpathsCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_cursor_scale(s : GraphconnectpathsCursor, f : Double) -> GraphconnectpathsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_cursor_add(a : GraphconnectpathsCursor, b : GraphconnectpathsCursor) -> GraphconnectpathsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_cursor_copy(s : GraphconnectpathsCursor) -> GraphconnectpathsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_cursor_fill(s : GraphconnectpathsCursor, v : Double) -> GraphconnectpathsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_cursor_min(s : GraphconnectpathsCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_cursor_max(s : GraphconnectpathsCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_cursor_to_string(s : GraphconnectpathsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_view_make(size : Int) -> GraphconnectpathsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_view_len(s : GraphconnectpathsView) -> Int { s.size }

pub fn graph_connect_paths_view_get(s : GraphconnectpathsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_view_set(s : GraphconnectpathsView, i : Int, v : Double) -> GraphconnectpathsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_view_sum(s : GraphconnectpathsView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_view_mean(s : GraphconnectpathsView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_view_scale(s : GraphconnectpathsView, f : Double) -> GraphconnectpathsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_view_add(a : GraphconnectpathsView, b : GraphconnectpathsView) -> GraphconnectpathsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_view_copy(s : GraphconnectpathsView) -> GraphconnectpathsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_view_fill(s : GraphconnectpathsView, v : Double) -> GraphconnectpathsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_view_min(s : GraphconnectpathsView) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_view_max(s : GraphconnectpathsView) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_view_to_string(s : GraphconnectpathsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_range_make(size : Int) -> GraphconnectpathsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_range_len(s : GraphconnectpathsRange) -> Int { s.size }

pub fn graph_connect_paths_range_get(s : GraphconnectpathsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_range_set(s : GraphconnectpathsRange, i : Int, v : Double) -> GraphconnectpathsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_range_sum(s : GraphconnectpathsRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_range_mean(s : GraphconnectpathsRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_range_scale(s : GraphconnectpathsRange, f : Double) -> GraphconnectpathsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_range_add(a : GraphconnectpathsRange, b : GraphconnectpathsRange) -> GraphconnectpathsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_range_copy(s : GraphconnectpathsRange) -> GraphconnectpathsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_range_fill(s : GraphconnectpathsRange, v : Double) -> GraphconnectpathsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_range_min(s : GraphconnectpathsRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_range_max(s : GraphconnectpathsRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_range_to_string(s : GraphconnectpathsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_slice_make(size : Int) -> GraphconnectpathsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_slice_len(s : GraphconnectpathsSlice) -> Int { s.size }

pub fn graph_connect_paths_slice_get(s : GraphconnectpathsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_slice_set(s : GraphconnectpathsSlice, i : Int, v : Double) -> GraphconnectpathsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_slice_sum(s : GraphconnectpathsSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_paths_slice_mean(s : GraphconnectpathsSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_paths_slice_scale(s : GraphconnectpathsSlice, f : Double) -> GraphconnectpathsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_slice_add(a : GraphconnectpathsSlice, b : GraphconnectpathsSlice) -> GraphconnectpathsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_paths_slice_copy(s : GraphconnectpathsSlice) -> GraphconnectpathsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_slice_fill(s : GraphconnectpathsSlice, v : Double) -> GraphconnectpathsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_paths_slice_min(s : GraphconnectpathsSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_paths_slice_max(s : GraphconnectpathsSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_paths_slice_to_string(s : GraphconnectpathsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

