///===
/// extcore/graph_search_bellman

pub(all) struct GraphsearchbellmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bellman_make_point(x : Double, y : Double) -> GraphsearchbellmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bellman_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbellmanPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_bellman_point_x(pt : GraphsearchbellmanPoint) -> Double { pt.x }

pub fn graph_search_bellman_point_y(pt : GraphsearchbellmanPoint) -> Double { pt.y }

pub fn graph_search_bellman_point_z(pt : GraphsearchbellmanPoint) -> Double { pt.z }

pub fn graph_search_bellman_point_label(pt : GraphsearchbellmanPoint) -> Int { pt.label }

pub fn graph_search_bellman_point_dist(a : GraphsearchbellmanPoint, b : GraphsearchbellmanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_bellman_point_add(a : GraphsearchbellmanPoint, b : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_bellman_point_sub(a : GraphsearchbellmanPoint, b : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_bellman_point_scale(pt : GraphsearchbellmanPoint, s : Double) -> GraphsearchbellmanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_bellman_point_dot(a : GraphsearchbellmanPoint, b : GraphsearchbellmanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_bellman_point_cross(a : GraphsearchbellmanPoint, b : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_bellman_point_norm(pt : GraphsearchbellmanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_bellman_point_normalize(pt : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  let n = graph_search_bellman_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_bellman_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_bellman_point_negate(pt : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_bellman_point_mid(a : GraphsearchbellmanPoint, b : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_bellman_point_lerp(a : GraphsearchbellmanPoint, b : GraphsearchbellmanPoint, t : Double) -> GraphsearchbellmanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_bellman_point_to_string(pt : GraphsearchbellmanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchbellmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bellman_make_series(vals : Array[Double], name : String) -> GraphsearchbellmanSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_bellman_series_len(s : GraphsearchbellmanSeries) -> Int { s.vals.length() }

pub fn graph_search_bellman_series_sum(s : GraphsearchbellmanSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_search_bellman_series_mean(s : GraphsearchbellmanSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_search_bellman_series_min(s : GraphsearchbellmanSeries) -> Double { @_common.min(s.vals) }

pub fn graph_search_bellman_series_max(s : GraphsearchbellmanSeries) -> Double { @_common.max(s.vals) }

pub fn graph_search_bellman_series_range(s : GraphsearchbellmanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_search_bellman_series_var(s : GraphsearchbellmanSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_search_bellman_series_std(s : GraphsearchbellmanSeries) -> Double { @_common.std(s.vals) }

pub fn graph_search_bellman_series_median(s : GraphsearchbellmanSeries) -> Double { @_common.median(s.vals) }

pub fn graph_search_bellman_series_scale(s : GraphsearchbellmanSeries, f : Double) -> GraphsearchbellmanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_bellman_series_add(a : GraphsearchbellmanSeries, b : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_bellman_series_sub(a : GraphsearchbellmanSeries, b : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_bellman_series_normalize(s : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  let mn = graph_search_bellman_series_min(s)
  let mx = graph_search_bellman_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_bellman_series_cumsum(s : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_bellman_series_to_string(s : GraphsearchbellmanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbellmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bellman_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbellmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bellman_matrix_identity(n : Int) -> GraphsearchbellmanMatrix {
  let m = graph_search_bellman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_bellman_matrix_get(m : GraphsearchbellmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_bellman_matrix_transpose(m : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  let result = graph_search_bellman_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_bellman_matrix_add(a : GraphsearchbellmanMatrix, b : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_bellman_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_bellman_matrix_scale(m : GraphsearchbellmanMatrix, s : Double) -> GraphsearchbellmanMatrix {
  let result = graph_search_bellman_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_bellman_matrix_multiply(a : GraphsearchbellmanMatrix, b : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  if a.cols != b.rows { return graph_search_bellman_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_bellman_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_bellman_matrix_trace(m : GraphsearchbellmanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_bellman_matrix_det(m : GraphsearchbellmanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_bellman_matrix_norm(m : GraphsearchbellmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_bellman_matrix_to_string(m : GraphsearchbellmanMatrix) -> String {
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

pub(all) struct GraphsearchbellmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bellman_make_vector(comps : Array[Double]) -> GraphsearchbellmanVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bellman_vector_zero(dim : Int) -> GraphsearchbellmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_bellman_vector_add(a : GraphsearchbellmanVector, b : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_bellman_vector_sub(a : GraphsearchbellmanVector, b : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_bellman_vector_scale(v : GraphsearchbellmanVector, s : Double) -> GraphsearchbellmanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_bellman_vector_dot(a : GraphsearchbellmanVector, b : GraphsearchbellmanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_bellman_vector_norm(v : GraphsearchbellmanVector) -> Double { @_common.sqrt(graph_search_bellman_vector_dot(v, v)) }

pub fn graph_search_bellman_vector_normalize(v : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = graph_search_bellman_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_bellman_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_bellman_vector_dist(a : GraphsearchbellmanVector, b : GraphsearchbellmanVector) -> Double {
  graph_search_bellman_vector_norm(graph_search_bellman_vector_sub(a, b))
}

pub fn graph_search_bellman_vector_to_string(v : GraphsearchbellmanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bellman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_bellman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_bellman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_bellman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_bellman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_bellman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_bellman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_bellman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_bellman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_bellman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_bellman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_bellman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_bellman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_bellman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_bellman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_bellman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_bellman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_bellman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_bellman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_bellman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_bellman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_bellman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_bellman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_bellman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_bellman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_bellman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_bellman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_bellman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_bellman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchbellmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_frame_make(size : Int) -> GraphsearchbellmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_frame_len(s : GraphsearchbellmanFrame) -> Int { s.size }

pub fn graph_search_bellman_frame_get(s : GraphsearchbellmanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_frame_set(s : GraphsearchbellmanFrame, i : Int, v : Double) -> GraphsearchbellmanFrame {
  let result = graph_search_bellman_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_frame_sum(s : GraphsearchbellmanFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_frame_mean(s : GraphsearchbellmanFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_frame_scale(s : GraphsearchbellmanFrame, f : Double) -> GraphsearchbellmanFrame {
  let result = graph_search_bellman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_frame_add(a : GraphsearchbellmanFrame, b : GraphsearchbellmanFrame) -> GraphsearchbellmanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_frame_copy(s : GraphsearchbellmanFrame) -> GraphsearchbellmanFrame {
  let result = graph_search_bellman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_frame_fill(s : GraphsearchbellmanFrame, v : Double) -> GraphsearchbellmanFrame {
  let result = graph_search_bellman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_frame_min(s : GraphsearchbellmanFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_frame_max(s : GraphsearchbellmanFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_frame_to_string(s : GraphsearchbellmanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_table_make(size : Int) -> GraphsearchbellmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_table_len(s : GraphsearchbellmanTable) -> Int { s.size }

pub fn graph_search_bellman_table_get(s : GraphsearchbellmanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_table_set(s : GraphsearchbellmanTable, i : Int, v : Double) -> GraphsearchbellmanTable {
  let result = graph_search_bellman_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_table_sum(s : GraphsearchbellmanTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_table_mean(s : GraphsearchbellmanTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_table_scale(s : GraphsearchbellmanTable, f : Double) -> GraphsearchbellmanTable {
  let result = graph_search_bellman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_table_add(a : GraphsearchbellmanTable, b : GraphsearchbellmanTable) -> GraphsearchbellmanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_table_copy(s : GraphsearchbellmanTable) -> GraphsearchbellmanTable {
  let result = graph_search_bellman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_table_fill(s : GraphsearchbellmanTable, v : Double) -> GraphsearchbellmanTable {
  let result = graph_search_bellman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_table_min(s : GraphsearchbellmanTable) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_table_max(s : GraphsearchbellmanTable) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_table_to_string(s : GraphsearchbellmanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_graphn_make(size : Int) -> GraphsearchbellmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_graphn_len(s : GraphsearchbellmanGraphN) -> Int { s.size }

pub fn graph_search_bellman_graphn_get(s : GraphsearchbellmanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_graphn_set(s : GraphsearchbellmanGraphN, i : Int, v : Double) -> GraphsearchbellmanGraphN {
  let result = graph_search_bellman_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_graphn_sum(s : GraphsearchbellmanGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_graphn_mean(s : GraphsearchbellmanGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_graphn_scale(s : GraphsearchbellmanGraphN, f : Double) -> GraphsearchbellmanGraphN {
  let result = graph_search_bellman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_graphn_add(a : GraphsearchbellmanGraphN, b : GraphsearchbellmanGraphN) -> GraphsearchbellmanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_graphn_copy(s : GraphsearchbellmanGraphN) -> GraphsearchbellmanGraphN {
  let result = graph_search_bellman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_graphn_fill(s : GraphsearchbellmanGraphN, v : Double) -> GraphsearchbellmanGraphN {
  let result = graph_search_bellman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_graphn_min(s : GraphsearchbellmanGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_graphn_max(s : GraphsearchbellmanGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_graphn_to_string(s : GraphsearchbellmanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_node_make(size : Int) -> GraphsearchbellmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_node_len(s : GraphsearchbellmanNode) -> Int { s.size }

pub fn graph_search_bellman_node_get(s : GraphsearchbellmanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_node_set(s : GraphsearchbellmanNode, i : Int, v : Double) -> GraphsearchbellmanNode {
  let result = graph_search_bellman_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_node_sum(s : GraphsearchbellmanNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_node_mean(s : GraphsearchbellmanNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_node_scale(s : GraphsearchbellmanNode, f : Double) -> GraphsearchbellmanNode {
  let result = graph_search_bellman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_node_add(a : GraphsearchbellmanNode, b : GraphsearchbellmanNode) -> GraphsearchbellmanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_node_copy(s : GraphsearchbellmanNode) -> GraphsearchbellmanNode {
  let result = graph_search_bellman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_node_fill(s : GraphsearchbellmanNode, v : Double) -> GraphsearchbellmanNode {
  let result = graph_search_bellman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_node_min(s : GraphsearchbellmanNode) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_node_max(s : GraphsearchbellmanNode) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_node_to_string(s : GraphsearchbellmanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_edge_make(size : Int) -> GraphsearchbellmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_edge_len(s : GraphsearchbellmanEdge) -> Int { s.size }

pub fn graph_search_bellman_edge_get(s : GraphsearchbellmanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_edge_set(s : GraphsearchbellmanEdge, i : Int, v : Double) -> GraphsearchbellmanEdge {
  let result = graph_search_bellman_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_edge_sum(s : GraphsearchbellmanEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_edge_mean(s : GraphsearchbellmanEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_edge_scale(s : GraphsearchbellmanEdge, f : Double) -> GraphsearchbellmanEdge {
  let result = graph_search_bellman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_edge_add(a : GraphsearchbellmanEdge, b : GraphsearchbellmanEdge) -> GraphsearchbellmanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_edge_copy(s : GraphsearchbellmanEdge) -> GraphsearchbellmanEdge {
  let result = graph_search_bellman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_edge_fill(s : GraphsearchbellmanEdge, v : Double) -> GraphsearchbellmanEdge {
  let result = graph_search_bellman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_edge_min(s : GraphsearchbellmanEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_edge_max(s : GraphsearchbellmanEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_edge_to_string(s : GraphsearchbellmanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_path_make(size : Int) -> GraphsearchbellmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_path_len(s : GraphsearchbellmanPath) -> Int { s.size }

pub fn graph_search_bellman_path_get(s : GraphsearchbellmanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_path_set(s : GraphsearchbellmanPath, i : Int, v : Double) -> GraphsearchbellmanPath {
  let result = graph_search_bellman_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_path_sum(s : GraphsearchbellmanPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_path_mean(s : GraphsearchbellmanPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_path_scale(s : GraphsearchbellmanPath, f : Double) -> GraphsearchbellmanPath {
  let result = graph_search_bellman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_path_add(a : GraphsearchbellmanPath, b : GraphsearchbellmanPath) -> GraphsearchbellmanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_path_copy(s : GraphsearchbellmanPath) -> GraphsearchbellmanPath {
  let result = graph_search_bellman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_path_fill(s : GraphsearchbellmanPath, v : Double) -> GraphsearchbellmanPath {
  let result = graph_search_bellman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_path_min(s : GraphsearchbellmanPath) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_path_max(s : GraphsearchbellmanPath) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_path_to_string(s : GraphsearchbellmanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_cluster_make(size : Int) -> GraphsearchbellmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_cluster_len(s : GraphsearchbellmanCluster) -> Int { s.size }

pub fn graph_search_bellman_cluster_get(s : GraphsearchbellmanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_cluster_set(s : GraphsearchbellmanCluster, i : Int, v : Double) -> GraphsearchbellmanCluster {
  let result = graph_search_bellman_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_cluster_sum(s : GraphsearchbellmanCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_cluster_mean(s : GraphsearchbellmanCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_cluster_scale(s : GraphsearchbellmanCluster, f : Double) -> GraphsearchbellmanCluster {
  let result = graph_search_bellman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_cluster_add(a : GraphsearchbellmanCluster, b : GraphsearchbellmanCluster) -> GraphsearchbellmanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_cluster_copy(s : GraphsearchbellmanCluster) -> GraphsearchbellmanCluster {
  let result = graph_search_bellman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_cluster_fill(s : GraphsearchbellmanCluster, v : Double) -> GraphsearchbellmanCluster {
  let result = graph_search_bellman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_cluster_min(s : GraphsearchbellmanCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_cluster_max(s : GraphsearchbellmanCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_cluster_to_string(s : GraphsearchbellmanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_model_make(size : Int) -> GraphsearchbellmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_model_len(s : GraphsearchbellmanModel) -> Int { s.size }

pub fn graph_search_bellman_model_get(s : GraphsearchbellmanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_model_set(s : GraphsearchbellmanModel, i : Int, v : Double) -> GraphsearchbellmanModel {
  let result = graph_search_bellman_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_model_sum(s : GraphsearchbellmanModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_model_mean(s : GraphsearchbellmanModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_model_scale(s : GraphsearchbellmanModel, f : Double) -> GraphsearchbellmanModel {
  let result = graph_search_bellman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_model_add(a : GraphsearchbellmanModel, b : GraphsearchbellmanModel) -> GraphsearchbellmanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_model_copy(s : GraphsearchbellmanModel) -> GraphsearchbellmanModel {
  let result = graph_search_bellman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_model_fill(s : GraphsearchbellmanModel, v : Double) -> GraphsearchbellmanModel {
  let result = graph_search_bellman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_model_min(s : GraphsearchbellmanModel) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_model_max(s : GraphsearchbellmanModel) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_model_to_string(s : GraphsearchbellmanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_layer_make(size : Int) -> GraphsearchbellmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_layer_len(s : GraphsearchbellmanLayer) -> Int { s.size }

pub fn graph_search_bellman_layer_get(s : GraphsearchbellmanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_layer_set(s : GraphsearchbellmanLayer, i : Int, v : Double) -> GraphsearchbellmanLayer {
  let result = graph_search_bellman_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_layer_sum(s : GraphsearchbellmanLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_layer_mean(s : GraphsearchbellmanLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_layer_scale(s : GraphsearchbellmanLayer, f : Double) -> GraphsearchbellmanLayer {
  let result = graph_search_bellman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_layer_add(a : GraphsearchbellmanLayer, b : GraphsearchbellmanLayer) -> GraphsearchbellmanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_layer_copy(s : GraphsearchbellmanLayer) -> GraphsearchbellmanLayer {
  let result = graph_search_bellman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_layer_fill(s : GraphsearchbellmanLayer, v : Double) -> GraphsearchbellmanLayer {
  let result = graph_search_bellman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_layer_min(s : GraphsearchbellmanLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_layer_max(s : GraphsearchbellmanLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_layer_to_string(s : GraphsearchbellmanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_buffer_make(size : Int) -> GraphsearchbellmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_buffer_len(s : GraphsearchbellmanBuffer) -> Int { s.size }

pub fn graph_search_bellman_buffer_get(s : GraphsearchbellmanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_buffer_set(s : GraphsearchbellmanBuffer, i : Int, v : Double) -> GraphsearchbellmanBuffer {
  let result = graph_search_bellman_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_buffer_sum(s : GraphsearchbellmanBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_buffer_mean(s : GraphsearchbellmanBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_buffer_scale(s : GraphsearchbellmanBuffer, f : Double) -> GraphsearchbellmanBuffer {
  let result = graph_search_bellman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_buffer_add(a : GraphsearchbellmanBuffer, b : GraphsearchbellmanBuffer) -> GraphsearchbellmanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_buffer_copy(s : GraphsearchbellmanBuffer) -> GraphsearchbellmanBuffer {
  let result = graph_search_bellman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_buffer_fill(s : GraphsearchbellmanBuffer, v : Double) -> GraphsearchbellmanBuffer {
  let result = graph_search_bellman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_buffer_min(s : GraphsearchbellmanBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_buffer_max(s : GraphsearchbellmanBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_buffer_to_string(s : GraphsearchbellmanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_cursor_make(size : Int) -> GraphsearchbellmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_cursor_len(s : GraphsearchbellmanCursor) -> Int { s.size }

pub fn graph_search_bellman_cursor_get(s : GraphsearchbellmanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_cursor_set(s : GraphsearchbellmanCursor, i : Int, v : Double) -> GraphsearchbellmanCursor {
  let result = graph_search_bellman_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_cursor_sum(s : GraphsearchbellmanCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_cursor_mean(s : GraphsearchbellmanCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_cursor_scale(s : GraphsearchbellmanCursor, f : Double) -> GraphsearchbellmanCursor {
  let result = graph_search_bellman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_cursor_add(a : GraphsearchbellmanCursor, b : GraphsearchbellmanCursor) -> GraphsearchbellmanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_cursor_copy(s : GraphsearchbellmanCursor) -> GraphsearchbellmanCursor {
  let result = graph_search_bellman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_cursor_fill(s : GraphsearchbellmanCursor, v : Double) -> GraphsearchbellmanCursor {
  let result = graph_search_bellman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_cursor_min(s : GraphsearchbellmanCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_cursor_max(s : GraphsearchbellmanCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_cursor_to_string(s : GraphsearchbellmanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_view_make(size : Int) -> GraphsearchbellmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_view_len(s : GraphsearchbellmanView) -> Int { s.size }

pub fn graph_search_bellman_view_get(s : GraphsearchbellmanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_view_set(s : GraphsearchbellmanView, i : Int, v : Double) -> GraphsearchbellmanView {
  let result = graph_search_bellman_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_view_sum(s : GraphsearchbellmanView) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_view_mean(s : GraphsearchbellmanView) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_view_scale(s : GraphsearchbellmanView, f : Double) -> GraphsearchbellmanView {
  let result = graph_search_bellman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_view_add(a : GraphsearchbellmanView, b : GraphsearchbellmanView) -> GraphsearchbellmanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_view_copy(s : GraphsearchbellmanView) -> GraphsearchbellmanView {
  let result = graph_search_bellman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_view_fill(s : GraphsearchbellmanView, v : Double) -> GraphsearchbellmanView {
  let result = graph_search_bellman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_view_min(s : GraphsearchbellmanView) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_view_max(s : GraphsearchbellmanView) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_view_to_string(s : GraphsearchbellmanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_range_make(size : Int) -> GraphsearchbellmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_range_len(s : GraphsearchbellmanRange) -> Int { s.size }

pub fn graph_search_bellman_range_get(s : GraphsearchbellmanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_range_set(s : GraphsearchbellmanRange, i : Int, v : Double) -> GraphsearchbellmanRange {
  let result = graph_search_bellman_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_range_sum(s : GraphsearchbellmanRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_range_mean(s : GraphsearchbellmanRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_range_scale(s : GraphsearchbellmanRange, f : Double) -> GraphsearchbellmanRange {
  let result = graph_search_bellman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_range_add(a : GraphsearchbellmanRange, b : GraphsearchbellmanRange) -> GraphsearchbellmanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_range_copy(s : GraphsearchbellmanRange) -> GraphsearchbellmanRange {
  let result = graph_search_bellman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_range_fill(s : GraphsearchbellmanRange, v : Double) -> GraphsearchbellmanRange {
  let result = graph_search_bellman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_range_min(s : GraphsearchbellmanRange) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_range_max(s : GraphsearchbellmanRange) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_range_to_string(s : GraphsearchbellmanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_slice_make(size : Int) -> GraphsearchbellmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_slice_len(s : GraphsearchbellmanSlice) -> Int { s.size }

pub fn graph_search_bellman_slice_get(s : GraphsearchbellmanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_slice_set(s : GraphsearchbellmanSlice, i : Int, v : Double) -> GraphsearchbellmanSlice {
  let result = graph_search_bellman_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_slice_sum(s : GraphsearchbellmanSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_slice_mean(s : GraphsearchbellmanSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_slice_scale(s : GraphsearchbellmanSlice, f : Double) -> GraphsearchbellmanSlice {
  let result = graph_search_bellman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bellman_slice_add(a : GraphsearchbellmanSlice, b : GraphsearchbellmanSlice) -> GraphsearchbellmanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bellman_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bellman_slice_copy(s : GraphsearchbellmanSlice) -> GraphsearchbellmanSlice {
  let result = graph_search_bellman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bellman_slice_fill(s : GraphsearchbellmanSlice, v : Double) -> GraphsearchbellmanSlice {
  let result = graph_search_bellman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bellman_slice_min(s : GraphsearchbellmanSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_slice_max(s : GraphsearchbellmanSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_slice_to_string(s : GraphsearchbellmanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

