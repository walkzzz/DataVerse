///===
/// extcore/graph_search_dfs

pub(all) struct GraphsearchdfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_dfs_make_point(x : Double, y : Double) -> GraphsearchdfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_dfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchdfsPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_dfs_point_x(pt : GraphsearchdfsPoint) -> Double { pt.x }

pub fn graph_search_dfs_point_y(pt : GraphsearchdfsPoint) -> Double { pt.y }

pub fn graph_search_dfs_point_z(pt : GraphsearchdfsPoint) -> Double { pt.z }

pub fn graph_search_dfs_point_label(pt : GraphsearchdfsPoint) -> Int { pt.label }

pub fn graph_search_dfs_point_dist(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_dfs_point_add(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_dfs_point_sub(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_dfs_point_scale(pt : GraphsearchdfsPoint, s : Double) -> GraphsearchdfsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_dfs_point_dot(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_dfs_point_cross(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_dfs_point_norm(pt : GraphsearchdfsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_dfs_point_normalize(pt : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  let n = graph_search_dfs_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_dfs_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_dfs_point_negate(pt : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_dfs_point_mid(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_dfs_point_lerp(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint, t : Double) -> GraphsearchdfsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_dfs_point_to_string(pt : GraphsearchdfsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchdfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_dfs_make_series(vals : Array[Double], name : String) -> GraphsearchdfsSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_dfs_series_len(s : GraphsearchdfsSeries) -> Int { s.vals.length() }

pub fn graph_search_dfs_series_sum(s : GraphsearchdfsSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_search_dfs_series_mean(s : GraphsearchdfsSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_search_dfs_series_min(s : GraphsearchdfsSeries) -> Double { @_common.min(s.vals) }

pub fn graph_search_dfs_series_max(s : GraphsearchdfsSeries) -> Double { @_common.max(s.vals) }

pub fn graph_search_dfs_series_range(s : GraphsearchdfsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_search_dfs_series_var(s : GraphsearchdfsSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_search_dfs_series_std(s : GraphsearchdfsSeries) -> Double { @_common.std(s.vals) }

pub fn graph_search_dfs_series_median(s : GraphsearchdfsSeries) -> Double { @_common.median(s.vals) }

pub fn graph_search_dfs_series_scale(s : GraphsearchdfsSeries, f : Double) -> GraphsearchdfsSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_search_dfs_series_add(a : GraphsearchdfsSeries, b : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_dfs_series_sub(a : GraphsearchdfsSeries, b : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_dfs_series_normalize(s : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  let mn = graph_search_dfs_series_min(s)
  let mx = graph_search_dfs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_dfs_series_cumsum(s : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_dfs_series_to_string(s : GraphsearchdfsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchdfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_dfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchdfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_dfs_matrix_identity(n : Int) -> GraphsearchdfsMatrix {
  let m = graph_search_dfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_dfs_matrix_get(m : GraphsearchdfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_dfs_matrix_transpose(m : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  let result = graph_search_dfs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_dfs_matrix_add(a : GraphsearchdfsMatrix, b : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_dfs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_dfs_matrix_scale(m : GraphsearchdfsMatrix, s : Double) -> GraphsearchdfsMatrix {
  let result = graph_search_dfs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_dfs_matrix_multiply(a : GraphsearchdfsMatrix, b : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  if a.cols != b.rows { return graph_search_dfs_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_dfs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_dfs_matrix_trace(m : GraphsearchdfsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_dfs_matrix_det(m : GraphsearchdfsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_dfs_matrix_norm(m : GraphsearchdfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_dfs_matrix_to_string(m : GraphsearchdfsMatrix) -> String {
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

pub(all) struct GraphsearchdfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_dfs_make_vector(comps : Array[Double]) -> GraphsearchdfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_dfs_vector_zero(dim : Int) -> GraphsearchdfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_dfs_vector_add(a : GraphsearchdfsVector, b : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_search_dfs_vector_sub(a : GraphsearchdfsVector, b : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_search_dfs_vector_scale(v : GraphsearchdfsVector, s : Double) -> GraphsearchdfsVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_search_dfs_vector_dot(a : GraphsearchdfsVector, b : GraphsearchdfsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_dfs_vector_norm(v : GraphsearchdfsVector) -> Double { @_common.sqrt(graph_search_dfs_vector_dot(v, v)) }

pub fn graph_search_dfs_vector_normalize(v : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = graph_search_dfs_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_dfs_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_dfs_vector_dist(a : GraphsearchdfsVector, b : GraphsearchdfsVector) -> Double {
  graph_search_dfs_vector_norm(graph_search_dfs_vector_sub(a, b))
}

pub fn graph_search_dfs_vector_to_string(v : GraphsearchdfsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_dfs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_dfs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_dfs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_dfs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_dfs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_dfs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_dfs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_dfs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_dfs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_dfs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_dfs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_dfs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_dfs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_dfs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_dfs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_dfs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_dfs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_dfs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_dfs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_dfs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_dfs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_dfs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_dfs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_dfs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_dfs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_dfs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_dfs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_dfs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_dfs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchdfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_frame_make(size : Int) -> GraphsearchdfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_frame_len(s : GraphsearchdfsFrame) -> Int { s.size }

pub fn graph_search_dfs_frame_get(s : GraphsearchdfsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_frame_set(s : GraphsearchdfsFrame, i : Int, v : Double) -> GraphsearchdfsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_frame_sum(s : GraphsearchdfsFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_frame_mean(s : GraphsearchdfsFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_frame_scale(s : GraphsearchdfsFrame, f : Double) -> GraphsearchdfsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_frame_add(a : GraphsearchdfsFrame, b : GraphsearchdfsFrame) -> GraphsearchdfsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_frame_copy(s : GraphsearchdfsFrame) -> GraphsearchdfsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_frame_fill(s : GraphsearchdfsFrame, v : Double) -> GraphsearchdfsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_frame_min(s : GraphsearchdfsFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_frame_max(s : GraphsearchdfsFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_frame_to_string(s : GraphsearchdfsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_table_make(size : Int) -> GraphsearchdfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_table_len(s : GraphsearchdfsTable) -> Int { s.size }

pub fn graph_search_dfs_table_get(s : GraphsearchdfsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_table_set(s : GraphsearchdfsTable, i : Int, v : Double) -> GraphsearchdfsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_table_sum(s : GraphsearchdfsTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_table_mean(s : GraphsearchdfsTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_table_scale(s : GraphsearchdfsTable, f : Double) -> GraphsearchdfsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_table_add(a : GraphsearchdfsTable, b : GraphsearchdfsTable) -> GraphsearchdfsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_table_copy(s : GraphsearchdfsTable) -> GraphsearchdfsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_table_fill(s : GraphsearchdfsTable, v : Double) -> GraphsearchdfsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_table_min(s : GraphsearchdfsTable) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_table_max(s : GraphsearchdfsTable) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_table_to_string(s : GraphsearchdfsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_graphn_make(size : Int) -> GraphsearchdfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_graphn_len(s : GraphsearchdfsGraphN) -> Int { s.size }

pub fn graph_search_dfs_graphn_get(s : GraphsearchdfsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_graphn_set(s : GraphsearchdfsGraphN, i : Int, v : Double) -> GraphsearchdfsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_graphn_sum(s : GraphsearchdfsGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_graphn_mean(s : GraphsearchdfsGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_graphn_scale(s : GraphsearchdfsGraphN, f : Double) -> GraphsearchdfsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_graphn_add(a : GraphsearchdfsGraphN, b : GraphsearchdfsGraphN) -> GraphsearchdfsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_graphn_copy(s : GraphsearchdfsGraphN) -> GraphsearchdfsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_graphn_fill(s : GraphsearchdfsGraphN, v : Double) -> GraphsearchdfsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_graphn_min(s : GraphsearchdfsGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_graphn_max(s : GraphsearchdfsGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_graphn_to_string(s : GraphsearchdfsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_node_make(size : Int) -> GraphsearchdfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_node_len(s : GraphsearchdfsNode) -> Int { s.size }

pub fn graph_search_dfs_node_get(s : GraphsearchdfsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_node_set(s : GraphsearchdfsNode, i : Int, v : Double) -> GraphsearchdfsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_node_sum(s : GraphsearchdfsNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_node_mean(s : GraphsearchdfsNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_node_scale(s : GraphsearchdfsNode, f : Double) -> GraphsearchdfsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_node_add(a : GraphsearchdfsNode, b : GraphsearchdfsNode) -> GraphsearchdfsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_node_copy(s : GraphsearchdfsNode) -> GraphsearchdfsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_node_fill(s : GraphsearchdfsNode, v : Double) -> GraphsearchdfsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_node_min(s : GraphsearchdfsNode) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_node_max(s : GraphsearchdfsNode) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_node_to_string(s : GraphsearchdfsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_edge_make(size : Int) -> GraphsearchdfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_edge_len(s : GraphsearchdfsEdge) -> Int { s.size }

pub fn graph_search_dfs_edge_get(s : GraphsearchdfsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_edge_set(s : GraphsearchdfsEdge, i : Int, v : Double) -> GraphsearchdfsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_edge_sum(s : GraphsearchdfsEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_edge_mean(s : GraphsearchdfsEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_edge_scale(s : GraphsearchdfsEdge, f : Double) -> GraphsearchdfsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_edge_add(a : GraphsearchdfsEdge, b : GraphsearchdfsEdge) -> GraphsearchdfsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_edge_copy(s : GraphsearchdfsEdge) -> GraphsearchdfsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_edge_fill(s : GraphsearchdfsEdge, v : Double) -> GraphsearchdfsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_edge_min(s : GraphsearchdfsEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_edge_max(s : GraphsearchdfsEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_edge_to_string(s : GraphsearchdfsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_path_make(size : Int) -> GraphsearchdfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_path_len(s : GraphsearchdfsPath) -> Int { s.size }

pub fn graph_search_dfs_path_get(s : GraphsearchdfsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_path_set(s : GraphsearchdfsPath, i : Int, v : Double) -> GraphsearchdfsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_path_sum(s : GraphsearchdfsPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_path_mean(s : GraphsearchdfsPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_path_scale(s : GraphsearchdfsPath, f : Double) -> GraphsearchdfsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_path_add(a : GraphsearchdfsPath, b : GraphsearchdfsPath) -> GraphsearchdfsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_path_copy(s : GraphsearchdfsPath) -> GraphsearchdfsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_path_fill(s : GraphsearchdfsPath, v : Double) -> GraphsearchdfsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_path_min(s : GraphsearchdfsPath) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_path_max(s : GraphsearchdfsPath) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_path_to_string(s : GraphsearchdfsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_cluster_make(size : Int) -> GraphsearchdfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_cluster_len(s : GraphsearchdfsCluster) -> Int { s.size }

pub fn graph_search_dfs_cluster_get(s : GraphsearchdfsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_cluster_set(s : GraphsearchdfsCluster, i : Int, v : Double) -> GraphsearchdfsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_cluster_sum(s : GraphsearchdfsCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_cluster_mean(s : GraphsearchdfsCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_cluster_scale(s : GraphsearchdfsCluster, f : Double) -> GraphsearchdfsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_cluster_add(a : GraphsearchdfsCluster, b : GraphsearchdfsCluster) -> GraphsearchdfsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_cluster_copy(s : GraphsearchdfsCluster) -> GraphsearchdfsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_cluster_fill(s : GraphsearchdfsCluster, v : Double) -> GraphsearchdfsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_cluster_min(s : GraphsearchdfsCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_cluster_max(s : GraphsearchdfsCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_cluster_to_string(s : GraphsearchdfsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_model_make(size : Int) -> GraphsearchdfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_model_len(s : GraphsearchdfsModel) -> Int { s.size }

pub fn graph_search_dfs_model_get(s : GraphsearchdfsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_model_set(s : GraphsearchdfsModel, i : Int, v : Double) -> GraphsearchdfsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_model_sum(s : GraphsearchdfsModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_model_mean(s : GraphsearchdfsModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_model_scale(s : GraphsearchdfsModel, f : Double) -> GraphsearchdfsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_model_add(a : GraphsearchdfsModel, b : GraphsearchdfsModel) -> GraphsearchdfsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_model_copy(s : GraphsearchdfsModel) -> GraphsearchdfsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_model_fill(s : GraphsearchdfsModel, v : Double) -> GraphsearchdfsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_model_min(s : GraphsearchdfsModel) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_model_max(s : GraphsearchdfsModel) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_model_to_string(s : GraphsearchdfsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_layer_make(size : Int) -> GraphsearchdfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_layer_len(s : GraphsearchdfsLayer) -> Int { s.size }

pub fn graph_search_dfs_layer_get(s : GraphsearchdfsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_layer_set(s : GraphsearchdfsLayer, i : Int, v : Double) -> GraphsearchdfsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_layer_sum(s : GraphsearchdfsLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_layer_mean(s : GraphsearchdfsLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_layer_scale(s : GraphsearchdfsLayer, f : Double) -> GraphsearchdfsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_layer_add(a : GraphsearchdfsLayer, b : GraphsearchdfsLayer) -> GraphsearchdfsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_layer_copy(s : GraphsearchdfsLayer) -> GraphsearchdfsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_layer_fill(s : GraphsearchdfsLayer, v : Double) -> GraphsearchdfsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_layer_min(s : GraphsearchdfsLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_layer_max(s : GraphsearchdfsLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_layer_to_string(s : GraphsearchdfsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_buffer_make(size : Int) -> GraphsearchdfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_buffer_len(s : GraphsearchdfsBuffer) -> Int { s.size }

pub fn graph_search_dfs_buffer_get(s : GraphsearchdfsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_buffer_set(s : GraphsearchdfsBuffer, i : Int, v : Double) -> GraphsearchdfsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_buffer_sum(s : GraphsearchdfsBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_buffer_mean(s : GraphsearchdfsBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_buffer_scale(s : GraphsearchdfsBuffer, f : Double) -> GraphsearchdfsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_buffer_add(a : GraphsearchdfsBuffer, b : GraphsearchdfsBuffer) -> GraphsearchdfsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_buffer_copy(s : GraphsearchdfsBuffer) -> GraphsearchdfsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_buffer_fill(s : GraphsearchdfsBuffer, v : Double) -> GraphsearchdfsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_buffer_min(s : GraphsearchdfsBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_buffer_max(s : GraphsearchdfsBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_buffer_to_string(s : GraphsearchdfsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_cursor_make(size : Int) -> GraphsearchdfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_cursor_len(s : GraphsearchdfsCursor) -> Int { s.size }

pub fn graph_search_dfs_cursor_get(s : GraphsearchdfsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_cursor_set(s : GraphsearchdfsCursor, i : Int, v : Double) -> GraphsearchdfsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_cursor_sum(s : GraphsearchdfsCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_cursor_mean(s : GraphsearchdfsCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_cursor_scale(s : GraphsearchdfsCursor, f : Double) -> GraphsearchdfsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_cursor_add(a : GraphsearchdfsCursor, b : GraphsearchdfsCursor) -> GraphsearchdfsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_cursor_copy(s : GraphsearchdfsCursor) -> GraphsearchdfsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_cursor_fill(s : GraphsearchdfsCursor, v : Double) -> GraphsearchdfsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_cursor_min(s : GraphsearchdfsCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_cursor_max(s : GraphsearchdfsCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_cursor_to_string(s : GraphsearchdfsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_view_make(size : Int) -> GraphsearchdfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_view_len(s : GraphsearchdfsView) -> Int { s.size }

pub fn graph_search_dfs_view_get(s : GraphsearchdfsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_view_set(s : GraphsearchdfsView, i : Int, v : Double) -> GraphsearchdfsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_view_sum(s : GraphsearchdfsView) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_view_mean(s : GraphsearchdfsView) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_view_scale(s : GraphsearchdfsView, f : Double) -> GraphsearchdfsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_view_add(a : GraphsearchdfsView, b : GraphsearchdfsView) -> GraphsearchdfsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_view_copy(s : GraphsearchdfsView) -> GraphsearchdfsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_view_fill(s : GraphsearchdfsView, v : Double) -> GraphsearchdfsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_view_min(s : GraphsearchdfsView) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_view_max(s : GraphsearchdfsView) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_view_to_string(s : GraphsearchdfsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_range_make(size : Int) -> GraphsearchdfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_range_len(s : GraphsearchdfsRange) -> Int { s.size }

pub fn graph_search_dfs_range_get(s : GraphsearchdfsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_range_set(s : GraphsearchdfsRange, i : Int, v : Double) -> GraphsearchdfsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_range_sum(s : GraphsearchdfsRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_range_mean(s : GraphsearchdfsRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_range_scale(s : GraphsearchdfsRange, f : Double) -> GraphsearchdfsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_range_add(a : GraphsearchdfsRange, b : GraphsearchdfsRange) -> GraphsearchdfsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_range_copy(s : GraphsearchdfsRange) -> GraphsearchdfsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_range_fill(s : GraphsearchdfsRange, v : Double) -> GraphsearchdfsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_range_min(s : GraphsearchdfsRange) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_range_max(s : GraphsearchdfsRange) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_range_to_string(s : GraphsearchdfsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_slice_make(size : Int) -> GraphsearchdfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_slice_len(s : GraphsearchdfsSlice) -> Int { s.size }

pub fn graph_search_dfs_slice_get(s : GraphsearchdfsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_slice_set(s : GraphsearchdfsSlice, i : Int, v : Double) -> GraphsearchdfsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_slice_sum(s : GraphsearchdfsSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_dfs_slice_mean(s : GraphsearchdfsSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_dfs_slice_scale(s : GraphsearchdfsSlice, f : Double) -> GraphsearchdfsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_slice_add(a : GraphsearchdfsSlice, b : GraphsearchdfsSlice) -> GraphsearchdfsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dfs_slice_copy(s : GraphsearchdfsSlice) -> GraphsearchdfsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_slice_fill(s : GraphsearchdfsSlice, v : Double) -> GraphsearchdfsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dfs_slice_min(s : GraphsearchdfsSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_dfs_slice_max(s : GraphsearchdfsSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_dfs_slice_to_string(s : GraphsearchdfsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

