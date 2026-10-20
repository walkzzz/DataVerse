///===
/// extcore/graph_flow_bipartite

pub(all) struct GraphflowbipartitePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_bipartite_make_point(x : Double, y : Double) -> GraphflowbipartitePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_bipartite_make_point3(x : Double, y : Double, z : Double) -> GraphflowbipartitePoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_bipartite_point_x(pt : GraphflowbipartitePoint) -> Double { pt.x }

pub fn graph_flow_bipartite_point_y(pt : GraphflowbipartitePoint) -> Double { pt.y }

pub fn graph_flow_bipartite_point_z(pt : GraphflowbipartitePoint) -> Double { pt.z }

pub fn graph_flow_bipartite_point_label(pt : GraphflowbipartitePoint) -> Int { pt.label }

pub fn graph_flow_bipartite_point_dist(a : GraphflowbipartitePoint, b : GraphflowbipartitePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_bipartite_point_add(a : GraphflowbipartitePoint, b : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_bipartite_point_sub(a : GraphflowbipartitePoint, b : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_bipartite_point_scale(pt : GraphflowbipartitePoint, s : Double) -> GraphflowbipartitePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_bipartite_point_dot(a : GraphflowbipartitePoint, b : GraphflowbipartitePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_bipartite_point_cross(a : GraphflowbipartitePoint, b : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_bipartite_point_norm(pt : GraphflowbipartitePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_bipartite_point_normalize(pt : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  let n = graph_flow_bipartite_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_bipartite_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_bipartite_point_negate(pt : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_bipartite_point_mid(a : GraphflowbipartitePoint, b : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_bipartite_point_lerp(a : GraphflowbipartitePoint, b : GraphflowbipartitePoint, t : Double) -> GraphflowbipartitePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_bipartite_point_to_string(pt : GraphflowbipartitePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowbipartiteSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_bipartite_make_series(vals : Array[Double], name : String) -> GraphflowbipartiteSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_bipartite_series_len(s : GraphflowbipartiteSeries) -> Int { s.vals.length() }

pub fn graph_flow_bipartite_series_sum(s : GraphflowbipartiteSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_flow_bipartite_series_mean(s : GraphflowbipartiteSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_flow_bipartite_series_min(s : GraphflowbipartiteSeries) -> Double { @_common.min(s.vals) }

pub fn graph_flow_bipartite_series_max(s : GraphflowbipartiteSeries) -> Double { @_common.max(s.vals) }

pub fn graph_flow_bipartite_series_range(s : GraphflowbipartiteSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_flow_bipartite_series_var(s : GraphflowbipartiteSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_flow_bipartite_series_std(s : GraphflowbipartiteSeries) -> Double { @_common.std(s.vals) }

pub fn graph_flow_bipartite_series_median(s : GraphflowbipartiteSeries) -> Double { @_common.median(s.vals) }

pub fn graph_flow_bipartite_series_scale(s : GraphflowbipartiteSeries, f : Double) -> GraphflowbipartiteSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_bipartite_series_add(a : GraphflowbipartiteSeries, b : GraphflowbipartiteSeries) -> GraphflowbipartiteSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_bipartite_series_sub(a : GraphflowbipartiteSeries, b : GraphflowbipartiteSeries) -> GraphflowbipartiteSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_bipartite_series_normalize(s : GraphflowbipartiteSeries) -> GraphflowbipartiteSeries {
  let mn = graph_flow_bipartite_series_min(s)
  let mx = graph_flow_bipartite_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_bipartite_series_cumsum(s : GraphflowbipartiteSeries) -> GraphflowbipartiteSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_bipartite_series_to_string(s : GraphflowbipartiteSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowbipartiteMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_bipartite_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowbipartiteMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_bipartite_matrix_identity(n : Int) -> GraphflowbipartiteMatrix {
  let m = graph_flow_bipartite_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_bipartite_matrix_get(m : GraphflowbipartiteMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_bipartite_matrix_transpose(m : GraphflowbipartiteMatrix) -> GraphflowbipartiteMatrix {
  let result = graph_flow_bipartite_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_bipartite_matrix_add(a : GraphflowbipartiteMatrix, b : GraphflowbipartiteMatrix) -> GraphflowbipartiteMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_bipartite_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_bipartite_matrix_scale(m : GraphflowbipartiteMatrix, s : Double) -> GraphflowbipartiteMatrix {
  let result = graph_flow_bipartite_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_bipartite_matrix_multiply(a : GraphflowbipartiteMatrix, b : GraphflowbipartiteMatrix) -> GraphflowbipartiteMatrix {
  if a.cols != b.rows { return graph_flow_bipartite_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_bipartite_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_bipartite_matrix_trace(m : GraphflowbipartiteMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_bipartite_matrix_det(m : GraphflowbipartiteMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_bipartite_matrix_norm(m : GraphflowbipartiteMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_flow_bipartite_matrix_to_string(m : GraphflowbipartiteMatrix) -> String {
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

pub(all) struct GraphflowbipartiteVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_bipartite_make_vector(comps : Array[Double]) -> GraphflowbipartiteVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_bipartite_vector_zero(dim : Int) -> GraphflowbipartiteVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_bipartite_vector_add(a : GraphflowbipartiteVector, b : GraphflowbipartiteVector) -> GraphflowbipartiteVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_bipartite_vector_sub(a : GraphflowbipartiteVector, b : GraphflowbipartiteVector) -> GraphflowbipartiteVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_bipartite_vector_scale(v : GraphflowbipartiteVector, s : Double) -> GraphflowbipartiteVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_bipartite_vector_dot(a : GraphflowbipartiteVector, b : GraphflowbipartiteVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_bipartite_vector_norm(v : GraphflowbipartiteVector) -> Double { @_common.sqrt(graph_flow_bipartite_vector_dot(v, v)) }

pub fn graph_flow_bipartite_vector_normalize(v : GraphflowbipartiteVector) -> GraphflowbipartiteVector {
  let n = graph_flow_bipartite_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_bipartite_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_bipartite_vector_dist(a : GraphflowbipartiteVector, b : GraphflowbipartiteVector) -> Double {
  graph_flow_bipartite_vector_norm(graph_flow_bipartite_vector_sub(a, b))
}

pub fn graph_flow_bipartite_vector_to_string(v : GraphflowbipartiteVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_bipartite_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_bipartite_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_bipartite_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_bipartite_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_bipartite_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_bipartite_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_bipartite_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_bipartite_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_bipartite_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_bipartite_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_bipartite_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_bipartite_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_bipartite_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_bipartite_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_bipartite_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_bipartite_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_bipartite_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_bipartite_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_bipartite_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_bipartite_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_bipartite_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_bipartite_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_bipartite_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_bipartite_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_bipartite_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_bipartite_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_bipartite_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_bipartite_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_bipartite_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowbipartiteFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_frame_make(size : Int) -> GraphflowbipartiteFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_frame_len(s : GraphflowbipartiteFrame) -> Int { s.size }

pub fn graph_flow_bipartite_frame_get(s : GraphflowbipartiteFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_frame_set(s : GraphflowbipartiteFrame, i : Int, v : Double) -> GraphflowbipartiteFrame {
  let result = graph_flow_bipartite_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_frame_sum(s : GraphflowbipartiteFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_frame_mean(s : GraphflowbipartiteFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_frame_scale(s : GraphflowbipartiteFrame, f : Double) -> GraphflowbipartiteFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_frame_add(a : GraphflowbipartiteFrame, b : GraphflowbipartiteFrame) -> GraphflowbipartiteFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_frame_copy(s : GraphflowbipartiteFrame) -> GraphflowbipartiteFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_frame_fill(s : GraphflowbipartiteFrame, v : Double) -> GraphflowbipartiteFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_frame_min(s : GraphflowbipartiteFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_frame_max(s : GraphflowbipartiteFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_frame_to_string(s : GraphflowbipartiteFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_table_make(size : Int) -> GraphflowbipartiteTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_table_len(s : GraphflowbipartiteTable) -> Int { s.size }

pub fn graph_flow_bipartite_table_get(s : GraphflowbipartiteTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_table_set(s : GraphflowbipartiteTable, i : Int, v : Double) -> GraphflowbipartiteTable {
  let result = graph_flow_bipartite_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_table_sum(s : GraphflowbipartiteTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_table_mean(s : GraphflowbipartiteTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_table_scale(s : GraphflowbipartiteTable, f : Double) -> GraphflowbipartiteTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_table_add(a : GraphflowbipartiteTable, b : GraphflowbipartiteTable) -> GraphflowbipartiteTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_table_copy(s : GraphflowbipartiteTable) -> GraphflowbipartiteTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_table_fill(s : GraphflowbipartiteTable, v : Double) -> GraphflowbipartiteTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_table_min(s : GraphflowbipartiteTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_table_max(s : GraphflowbipartiteTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_table_to_string(s : GraphflowbipartiteTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_graphn_make(size : Int) -> GraphflowbipartiteGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_graphn_len(s : GraphflowbipartiteGraphN) -> Int { s.size }

pub fn graph_flow_bipartite_graphn_get(s : GraphflowbipartiteGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_graphn_set(s : GraphflowbipartiteGraphN, i : Int, v : Double) -> GraphflowbipartiteGraphN {
  let result = graph_flow_bipartite_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_graphn_sum(s : GraphflowbipartiteGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_graphn_mean(s : GraphflowbipartiteGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_graphn_scale(s : GraphflowbipartiteGraphN, f : Double) -> GraphflowbipartiteGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_graphn_add(a : GraphflowbipartiteGraphN, b : GraphflowbipartiteGraphN) -> GraphflowbipartiteGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_graphn_copy(s : GraphflowbipartiteGraphN) -> GraphflowbipartiteGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_graphn_fill(s : GraphflowbipartiteGraphN, v : Double) -> GraphflowbipartiteGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_graphn_min(s : GraphflowbipartiteGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_graphn_max(s : GraphflowbipartiteGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_graphn_to_string(s : GraphflowbipartiteGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_node_make(size : Int) -> GraphflowbipartiteNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_node_len(s : GraphflowbipartiteNode) -> Int { s.size }

pub fn graph_flow_bipartite_node_get(s : GraphflowbipartiteNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_node_set(s : GraphflowbipartiteNode, i : Int, v : Double) -> GraphflowbipartiteNode {
  let result = graph_flow_bipartite_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_node_sum(s : GraphflowbipartiteNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_node_mean(s : GraphflowbipartiteNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_node_scale(s : GraphflowbipartiteNode, f : Double) -> GraphflowbipartiteNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_node_add(a : GraphflowbipartiteNode, b : GraphflowbipartiteNode) -> GraphflowbipartiteNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_node_copy(s : GraphflowbipartiteNode) -> GraphflowbipartiteNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_node_fill(s : GraphflowbipartiteNode, v : Double) -> GraphflowbipartiteNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_node_min(s : GraphflowbipartiteNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_node_max(s : GraphflowbipartiteNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_node_to_string(s : GraphflowbipartiteNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_edge_make(size : Int) -> GraphflowbipartiteEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_edge_len(s : GraphflowbipartiteEdge) -> Int { s.size }

pub fn graph_flow_bipartite_edge_get(s : GraphflowbipartiteEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_edge_set(s : GraphflowbipartiteEdge, i : Int, v : Double) -> GraphflowbipartiteEdge {
  let result = graph_flow_bipartite_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_edge_sum(s : GraphflowbipartiteEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_edge_mean(s : GraphflowbipartiteEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_edge_scale(s : GraphflowbipartiteEdge, f : Double) -> GraphflowbipartiteEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_edge_add(a : GraphflowbipartiteEdge, b : GraphflowbipartiteEdge) -> GraphflowbipartiteEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_edge_copy(s : GraphflowbipartiteEdge) -> GraphflowbipartiteEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_edge_fill(s : GraphflowbipartiteEdge, v : Double) -> GraphflowbipartiteEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_edge_min(s : GraphflowbipartiteEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_edge_max(s : GraphflowbipartiteEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_edge_to_string(s : GraphflowbipartiteEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartitePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_path_make(size : Int) -> GraphflowbipartitePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_path_len(s : GraphflowbipartitePath) -> Int { s.size }

pub fn graph_flow_bipartite_path_get(s : GraphflowbipartitePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_path_set(s : GraphflowbipartitePath, i : Int, v : Double) -> GraphflowbipartitePath {
  let result = graph_flow_bipartite_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_path_sum(s : GraphflowbipartitePath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_path_mean(s : GraphflowbipartitePath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_path_scale(s : GraphflowbipartitePath, f : Double) -> GraphflowbipartitePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_path_add(a : GraphflowbipartitePath, b : GraphflowbipartitePath) -> GraphflowbipartitePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_path_copy(s : GraphflowbipartitePath) -> GraphflowbipartitePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_path_fill(s : GraphflowbipartitePath, v : Double) -> GraphflowbipartitePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_path_min(s : GraphflowbipartitePath) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_path_max(s : GraphflowbipartitePath) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_path_to_string(s : GraphflowbipartitePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_cluster_make(size : Int) -> GraphflowbipartiteCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_cluster_len(s : GraphflowbipartiteCluster) -> Int { s.size }

pub fn graph_flow_bipartite_cluster_get(s : GraphflowbipartiteCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_cluster_set(s : GraphflowbipartiteCluster, i : Int, v : Double) -> GraphflowbipartiteCluster {
  let result = graph_flow_bipartite_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_cluster_sum(s : GraphflowbipartiteCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_cluster_mean(s : GraphflowbipartiteCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_cluster_scale(s : GraphflowbipartiteCluster, f : Double) -> GraphflowbipartiteCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cluster_add(a : GraphflowbipartiteCluster, b : GraphflowbipartiteCluster) -> GraphflowbipartiteCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_cluster_copy(s : GraphflowbipartiteCluster) -> GraphflowbipartiteCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cluster_fill(s : GraphflowbipartiteCluster, v : Double) -> GraphflowbipartiteCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cluster_min(s : GraphflowbipartiteCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_cluster_max(s : GraphflowbipartiteCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_cluster_to_string(s : GraphflowbipartiteCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_model_make(size : Int) -> GraphflowbipartiteModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_model_len(s : GraphflowbipartiteModel) -> Int { s.size }

pub fn graph_flow_bipartite_model_get(s : GraphflowbipartiteModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_model_set(s : GraphflowbipartiteModel, i : Int, v : Double) -> GraphflowbipartiteModel {
  let result = graph_flow_bipartite_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_model_sum(s : GraphflowbipartiteModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_model_mean(s : GraphflowbipartiteModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_model_scale(s : GraphflowbipartiteModel, f : Double) -> GraphflowbipartiteModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_model_add(a : GraphflowbipartiteModel, b : GraphflowbipartiteModel) -> GraphflowbipartiteModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_model_copy(s : GraphflowbipartiteModel) -> GraphflowbipartiteModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_model_fill(s : GraphflowbipartiteModel, v : Double) -> GraphflowbipartiteModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_model_min(s : GraphflowbipartiteModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_model_max(s : GraphflowbipartiteModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_model_to_string(s : GraphflowbipartiteModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_layer_make(size : Int) -> GraphflowbipartiteLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_layer_len(s : GraphflowbipartiteLayer) -> Int { s.size }

pub fn graph_flow_bipartite_layer_get(s : GraphflowbipartiteLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_layer_set(s : GraphflowbipartiteLayer, i : Int, v : Double) -> GraphflowbipartiteLayer {
  let result = graph_flow_bipartite_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_layer_sum(s : GraphflowbipartiteLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_layer_mean(s : GraphflowbipartiteLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_layer_scale(s : GraphflowbipartiteLayer, f : Double) -> GraphflowbipartiteLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_layer_add(a : GraphflowbipartiteLayer, b : GraphflowbipartiteLayer) -> GraphflowbipartiteLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_layer_copy(s : GraphflowbipartiteLayer) -> GraphflowbipartiteLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_layer_fill(s : GraphflowbipartiteLayer, v : Double) -> GraphflowbipartiteLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_layer_min(s : GraphflowbipartiteLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_layer_max(s : GraphflowbipartiteLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_layer_to_string(s : GraphflowbipartiteLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_buffer_make(size : Int) -> GraphflowbipartiteBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_buffer_len(s : GraphflowbipartiteBuffer) -> Int { s.size }

pub fn graph_flow_bipartite_buffer_get(s : GraphflowbipartiteBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_buffer_set(s : GraphflowbipartiteBuffer, i : Int, v : Double) -> GraphflowbipartiteBuffer {
  let result = graph_flow_bipartite_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_buffer_sum(s : GraphflowbipartiteBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_buffer_mean(s : GraphflowbipartiteBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_buffer_scale(s : GraphflowbipartiteBuffer, f : Double) -> GraphflowbipartiteBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_buffer_add(a : GraphflowbipartiteBuffer, b : GraphflowbipartiteBuffer) -> GraphflowbipartiteBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_buffer_copy(s : GraphflowbipartiteBuffer) -> GraphflowbipartiteBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_buffer_fill(s : GraphflowbipartiteBuffer, v : Double) -> GraphflowbipartiteBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_buffer_min(s : GraphflowbipartiteBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_buffer_max(s : GraphflowbipartiteBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_buffer_to_string(s : GraphflowbipartiteBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_cursor_make(size : Int) -> GraphflowbipartiteCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_cursor_len(s : GraphflowbipartiteCursor) -> Int { s.size }

pub fn graph_flow_bipartite_cursor_get(s : GraphflowbipartiteCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_cursor_set(s : GraphflowbipartiteCursor, i : Int, v : Double) -> GraphflowbipartiteCursor {
  let result = graph_flow_bipartite_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_cursor_sum(s : GraphflowbipartiteCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_cursor_mean(s : GraphflowbipartiteCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_cursor_scale(s : GraphflowbipartiteCursor, f : Double) -> GraphflowbipartiteCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cursor_add(a : GraphflowbipartiteCursor, b : GraphflowbipartiteCursor) -> GraphflowbipartiteCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_cursor_copy(s : GraphflowbipartiteCursor) -> GraphflowbipartiteCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cursor_fill(s : GraphflowbipartiteCursor, v : Double) -> GraphflowbipartiteCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cursor_min(s : GraphflowbipartiteCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_cursor_max(s : GraphflowbipartiteCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_cursor_to_string(s : GraphflowbipartiteCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_view_make(size : Int) -> GraphflowbipartiteView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_view_len(s : GraphflowbipartiteView) -> Int { s.size }

pub fn graph_flow_bipartite_view_get(s : GraphflowbipartiteView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_view_set(s : GraphflowbipartiteView, i : Int, v : Double) -> GraphflowbipartiteView {
  let result = graph_flow_bipartite_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_view_sum(s : GraphflowbipartiteView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_view_mean(s : GraphflowbipartiteView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_view_scale(s : GraphflowbipartiteView, f : Double) -> GraphflowbipartiteView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_view_add(a : GraphflowbipartiteView, b : GraphflowbipartiteView) -> GraphflowbipartiteView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_view_copy(s : GraphflowbipartiteView) -> GraphflowbipartiteView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_view_fill(s : GraphflowbipartiteView, v : Double) -> GraphflowbipartiteView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_view_min(s : GraphflowbipartiteView) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_view_max(s : GraphflowbipartiteView) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_view_to_string(s : GraphflowbipartiteView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_range_make(size : Int) -> GraphflowbipartiteRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_range_len(s : GraphflowbipartiteRange) -> Int { s.size }

pub fn graph_flow_bipartite_range_get(s : GraphflowbipartiteRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_range_set(s : GraphflowbipartiteRange, i : Int, v : Double) -> GraphflowbipartiteRange {
  let result = graph_flow_bipartite_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_range_sum(s : GraphflowbipartiteRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_range_mean(s : GraphflowbipartiteRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_range_scale(s : GraphflowbipartiteRange, f : Double) -> GraphflowbipartiteRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_range_add(a : GraphflowbipartiteRange, b : GraphflowbipartiteRange) -> GraphflowbipartiteRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_range_copy(s : GraphflowbipartiteRange) -> GraphflowbipartiteRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_range_fill(s : GraphflowbipartiteRange, v : Double) -> GraphflowbipartiteRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_range_min(s : GraphflowbipartiteRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_range_max(s : GraphflowbipartiteRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_range_to_string(s : GraphflowbipartiteRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_slice_make(size : Int) -> GraphflowbipartiteSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_slice_len(s : GraphflowbipartiteSlice) -> Int { s.size }

pub fn graph_flow_bipartite_slice_get(s : GraphflowbipartiteSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_slice_set(s : GraphflowbipartiteSlice, i : Int, v : Double) -> GraphflowbipartiteSlice {
  let result = graph_flow_bipartite_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_bipartite_slice_sum(s : GraphflowbipartiteSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_slice_mean(s : GraphflowbipartiteSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_slice_scale(s : GraphflowbipartiteSlice, f : Double) -> GraphflowbipartiteSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_slice_add(a : GraphflowbipartiteSlice, b : GraphflowbipartiteSlice) -> GraphflowbipartiteSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_slice_copy(s : GraphflowbipartiteSlice) -> GraphflowbipartiteSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_slice_fill(s : GraphflowbipartiteSlice, v : Double) -> GraphflowbipartiteSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_slice_min(s : GraphflowbipartiteSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_slice_max(s : GraphflowbipartiteSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_slice_to_string(s : GraphflowbipartiteSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

