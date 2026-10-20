///===
/// extcore/graph_tree_mst

pub(all) struct GraphtreemstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_make_point(x : Double, y : Double) -> GraphtreemstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_mst_point_x(pt : GraphtreemstPoint) -> Double { pt.x }

pub fn graph_tree_mst_point_y(pt : GraphtreemstPoint) -> Double { pt.y }

pub fn graph_tree_mst_point_z(pt : GraphtreemstPoint) -> Double { pt.z }

pub fn graph_tree_mst_point_label(pt : GraphtreemstPoint) -> Int { pt.label }

pub fn graph_tree_mst_point_dist(a : GraphtreemstPoint, b : GraphtreemstPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_mst_point_add(a : GraphtreemstPoint, b : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_mst_point_sub(a : GraphtreemstPoint, b : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_mst_point_scale(pt : GraphtreemstPoint, s : Double) -> GraphtreemstPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_mst_point_dot(a : GraphtreemstPoint, b : GraphtreemstPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_mst_point_cross(a : GraphtreemstPoint, b : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_mst_point_norm(pt : GraphtreemstPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_mst_point_normalize(pt : GraphtreemstPoint) -> GraphtreemstPoint {
  let n = graph_tree_mst_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_mst_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_mst_point_negate(pt : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_mst_point_mid(a : GraphtreemstPoint, b : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_mst_point_lerp(a : GraphtreemstPoint, b : GraphtreemstPoint, t : Double) -> GraphtreemstPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_mst_point_to_string(pt : GraphtreemstPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreemstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_make_series(vals : Array[Double], name : String) -> GraphtreemstSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_mst_series_len(s : GraphtreemstSeries) -> Int { s.vals.length() }

pub fn graph_tree_mst_series_sum(s : GraphtreemstSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_tree_mst_series_mean(s : GraphtreemstSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_tree_mst_series_min(s : GraphtreemstSeries) -> Double { @_common.min(s.vals) }

pub fn graph_tree_mst_series_max(s : GraphtreemstSeries) -> Double { @_common.max(s.vals) }

pub fn graph_tree_mst_series_range(s : GraphtreemstSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_tree_mst_series_var(s : GraphtreemstSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_tree_mst_series_std(s : GraphtreemstSeries) -> Double { @_common.std(s.vals) }

pub fn graph_tree_mst_series_median(s : GraphtreemstSeries) -> Double { @_common.median(s.vals) }

pub fn graph_tree_mst_series_scale(s : GraphtreemstSeries, f : Double) -> GraphtreemstSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_tree_mst_series_add(a : GraphtreemstSeries, b : GraphtreemstSeries) -> GraphtreemstSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_mst_series_sub(a : GraphtreemstSeries, b : GraphtreemstSeries) -> GraphtreemstSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_mst_series_normalize(s : GraphtreemstSeries) -> GraphtreemstSeries {
  let mn = graph_tree_mst_series_min(s)
  let mx = graph_tree_mst_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_mst_series_cumsum(s : GraphtreemstSeries) -> GraphtreemstSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_mst_series_to_string(s : GraphtreemstSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_mst_matrix_identity(n : Int) -> GraphtreemstMatrix {
  let m = graph_tree_mst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_mst_matrix_get(m : GraphtreemstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_mst_matrix_transpose(m : GraphtreemstMatrix) -> GraphtreemstMatrix {
  let result = graph_tree_mst_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_mst_matrix_add(a : GraphtreemstMatrix, b : GraphtreemstMatrix) -> GraphtreemstMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_mst_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_mst_matrix_scale(m : GraphtreemstMatrix, s : Double) -> GraphtreemstMatrix {
  let result = graph_tree_mst_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_mst_matrix_multiply(a : GraphtreemstMatrix, b : GraphtreemstMatrix) -> GraphtreemstMatrix {
  if a.cols != b.rows { return graph_tree_mst_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_mst_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_mst_matrix_trace(m : GraphtreemstMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_mst_matrix_det(m : GraphtreemstMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_mst_matrix_norm(m : GraphtreemstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_tree_mst_matrix_to_string(m : GraphtreemstMatrix) -> String {
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

pub(all) struct GraphtreemstVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_make_vector(comps : Array[Double]) -> GraphtreemstVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_vector_zero(dim : Int) -> GraphtreemstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_mst_vector_add(a : GraphtreemstVector, b : GraphtreemstVector) -> GraphtreemstVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_mst_vector_sub(a : GraphtreemstVector, b : GraphtreemstVector) -> GraphtreemstVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_mst_vector_scale(v : GraphtreemstVector, s : Double) -> GraphtreemstVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_tree_mst_vector_dot(a : GraphtreemstVector, b : GraphtreemstVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_mst_vector_norm(v : GraphtreemstVector) -> Double { @_common.sqrt(graph_tree_mst_vector_dot(v, v)) }

pub fn graph_tree_mst_vector_normalize(v : GraphtreemstVector) -> GraphtreemstVector {
  let n = graph_tree_mst_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_mst_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_mst_vector_dist(a : GraphtreemstVector, b : GraphtreemstVector) -> Double {
  graph_tree_mst_vector_norm(graph_tree_mst_vector_sub(a, b))
}

pub fn graph_tree_mst_vector_to_string(v : GraphtreemstVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_mst_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_mst_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_mst_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_mst_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_mst_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_mst_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_mst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_mst_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_mst_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_mst_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_mst_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_mst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_mst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_mst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_mst_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_mst_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_mst_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_mst_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_mst_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_mst_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_mst_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_mst_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_mst_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_mst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_mst_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_mst_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_mst_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_mst_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_mst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreemstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_frame_make(size : Int) -> GraphtreemstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_frame_len(s : GraphtreemstFrame) -> Int { s.size }

pub fn graph_tree_mst_frame_get(s : GraphtreemstFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_frame_set(s : GraphtreemstFrame, i : Int, v : Double) -> GraphtreemstFrame {
  let result = graph_tree_mst_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_frame_sum(s : GraphtreemstFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_frame_mean(s : GraphtreemstFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_frame_scale(s : GraphtreemstFrame, f : Double) -> GraphtreemstFrame {
  let result = graph_tree_mst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_frame_add(a : GraphtreemstFrame, b : GraphtreemstFrame) -> GraphtreemstFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_frame_copy(s : GraphtreemstFrame) -> GraphtreemstFrame {
  let result = graph_tree_mst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_frame_fill(s : GraphtreemstFrame, v : Double) -> GraphtreemstFrame {
  let result = graph_tree_mst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_frame_min(s : GraphtreemstFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_frame_max(s : GraphtreemstFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_frame_to_string(s : GraphtreemstFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_table_make(size : Int) -> GraphtreemstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_table_len(s : GraphtreemstTable) -> Int { s.size }

pub fn graph_tree_mst_table_get(s : GraphtreemstTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_table_set(s : GraphtreemstTable, i : Int, v : Double) -> GraphtreemstTable {
  let result = graph_tree_mst_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_table_sum(s : GraphtreemstTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_table_mean(s : GraphtreemstTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_table_scale(s : GraphtreemstTable, f : Double) -> GraphtreemstTable {
  let result = graph_tree_mst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_table_add(a : GraphtreemstTable, b : GraphtreemstTable) -> GraphtreemstTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_table_copy(s : GraphtreemstTable) -> GraphtreemstTable {
  let result = graph_tree_mst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_table_fill(s : GraphtreemstTable, v : Double) -> GraphtreemstTable {
  let result = graph_tree_mst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_table_min(s : GraphtreemstTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_table_max(s : GraphtreemstTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_table_to_string(s : GraphtreemstTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_graphn_make(size : Int) -> GraphtreemstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_graphn_len(s : GraphtreemstGraphN) -> Int { s.size }

pub fn graph_tree_mst_graphn_get(s : GraphtreemstGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_graphn_set(s : GraphtreemstGraphN, i : Int, v : Double) -> GraphtreemstGraphN {
  let result = graph_tree_mst_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_graphn_sum(s : GraphtreemstGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_graphn_mean(s : GraphtreemstGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_graphn_scale(s : GraphtreemstGraphN, f : Double) -> GraphtreemstGraphN {
  let result = graph_tree_mst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_graphn_add(a : GraphtreemstGraphN, b : GraphtreemstGraphN) -> GraphtreemstGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_graphn_copy(s : GraphtreemstGraphN) -> GraphtreemstGraphN {
  let result = graph_tree_mst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_graphn_fill(s : GraphtreemstGraphN, v : Double) -> GraphtreemstGraphN {
  let result = graph_tree_mst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_graphn_min(s : GraphtreemstGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_graphn_max(s : GraphtreemstGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_graphn_to_string(s : GraphtreemstGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_node_make(size : Int) -> GraphtreemstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_node_len(s : GraphtreemstNode) -> Int { s.size }

pub fn graph_tree_mst_node_get(s : GraphtreemstNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_node_set(s : GraphtreemstNode, i : Int, v : Double) -> GraphtreemstNode {
  let result = graph_tree_mst_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_node_sum(s : GraphtreemstNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_node_mean(s : GraphtreemstNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_node_scale(s : GraphtreemstNode, f : Double) -> GraphtreemstNode {
  let result = graph_tree_mst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_node_add(a : GraphtreemstNode, b : GraphtreemstNode) -> GraphtreemstNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_node_copy(s : GraphtreemstNode) -> GraphtreemstNode {
  let result = graph_tree_mst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_node_fill(s : GraphtreemstNode, v : Double) -> GraphtreemstNode {
  let result = graph_tree_mst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_node_min(s : GraphtreemstNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_node_max(s : GraphtreemstNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_node_to_string(s : GraphtreemstNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_edge_make(size : Int) -> GraphtreemstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_edge_len(s : GraphtreemstEdge) -> Int { s.size }

pub fn graph_tree_mst_edge_get(s : GraphtreemstEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_edge_set(s : GraphtreemstEdge, i : Int, v : Double) -> GraphtreemstEdge {
  let result = graph_tree_mst_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_edge_sum(s : GraphtreemstEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_edge_mean(s : GraphtreemstEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_edge_scale(s : GraphtreemstEdge, f : Double) -> GraphtreemstEdge {
  let result = graph_tree_mst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_edge_add(a : GraphtreemstEdge, b : GraphtreemstEdge) -> GraphtreemstEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_edge_copy(s : GraphtreemstEdge) -> GraphtreemstEdge {
  let result = graph_tree_mst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_edge_fill(s : GraphtreemstEdge, v : Double) -> GraphtreemstEdge {
  let result = graph_tree_mst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_edge_min(s : GraphtreemstEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_edge_max(s : GraphtreemstEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_edge_to_string(s : GraphtreemstEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_path_make(size : Int) -> GraphtreemstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_path_len(s : GraphtreemstPath) -> Int { s.size }

pub fn graph_tree_mst_path_get(s : GraphtreemstPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_path_set(s : GraphtreemstPath, i : Int, v : Double) -> GraphtreemstPath {
  let result = graph_tree_mst_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_path_sum(s : GraphtreemstPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_path_mean(s : GraphtreemstPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_path_scale(s : GraphtreemstPath, f : Double) -> GraphtreemstPath {
  let result = graph_tree_mst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_path_add(a : GraphtreemstPath, b : GraphtreemstPath) -> GraphtreemstPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_path_copy(s : GraphtreemstPath) -> GraphtreemstPath {
  let result = graph_tree_mst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_path_fill(s : GraphtreemstPath, v : Double) -> GraphtreemstPath {
  let result = graph_tree_mst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_path_min(s : GraphtreemstPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_path_max(s : GraphtreemstPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_path_to_string(s : GraphtreemstPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_cluster_make(size : Int) -> GraphtreemstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_cluster_len(s : GraphtreemstCluster) -> Int { s.size }

pub fn graph_tree_mst_cluster_get(s : GraphtreemstCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_cluster_set(s : GraphtreemstCluster, i : Int, v : Double) -> GraphtreemstCluster {
  let result = graph_tree_mst_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_cluster_sum(s : GraphtreemstCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_cluster_mean(s : GraphtreemstCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_cluster_scale(s : GraphtreemstCluster, f : Double) -> GraphtreemstCluster {
  let result = graph_tree_mst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_cluster_add(a : GraphtreemstCluster, b : GraphtreemstCluster) -> GraphtreemstCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_cluster_copy(s : GraphtreemstCluster) -> GraphtreemstCluster {
  let result = graph_tree_mst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_cluster_fill(s : GraphtreemstCluster, v : Double) -> GraphtreemstCluster {
  let result = graph_tree_mst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_cluster_min(s : GraphtreemstCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_cluster_max(s : GraphtreemstCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_cluster_to_string(s : GraphtreemstCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_model_make(size : Int) -> GraphtreemstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_model_len(s : GraphtreemstModel) -> Int { s.size }

pub fn graph_tree_mst_model_get(s : GraphtreemstModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_model_set(s : GraphtreemstModel, i : Int, v : Double) -> GraphtreemstModel {
  let result = graph_tree_mst_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_model_sum(s : GraphtreemstModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_model_mean(s : GraphtreemstModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_model_scale(s : GraphtreemstModel, f : Double) -> GraphtreemstModel {
  let result = graph_tree_mst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_model_add(a : GraphtreemstModel, b : GraphtreemstModel) -> GraphtreemstModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_model_copy(s : GraphtreemstModel) -> GraphtreemstModel {
  let result = graph_tree_mst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_model_fill(s : GraphtreemstModel, v : Double) -> GraphtreemstModel {
  let result = graph_tree_mst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_model_min(s : GraphtreemstModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_model_max(s : GraphtreemstModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_model_to_string(s : GraphtreemstModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_layer_make(size : Int) -> GraphtreemstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_layer_len(s : GraphtreemstLayer) -> Int { s.size }

pub fn graph_tree_mst_layer_get(s : GraphtreemstLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_layer_set(s : GraphtreemstLayer, i : Int, v : Double) -> GraphtreemstLayer {
  let result = graph_tree_mst_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_layer_sum(s : GraphtreemstLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_layer_mean(s : GraphtreemstLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_layer_scale(s : GraphtreemstLayer, f : Double) -> GraphtreemstLayer {
  let result = graph_tree_mst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_layer_add(a : GraphtreemstLayer, b : GraphtreemstLayer) -> GraphtreemstLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_layer_copy(s : GraphtreemstLayer) -> GraphtreemstLayer {
  let result = graph_tree_mst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_layer_fill(s : GraphtreemstLayer, v : Double) -> GraphtreemstLayer {
  let result = graph_tree_mst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_layer_min(s : GraphtreemstLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_layer_max(s : GraphtreemstLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_layer_to_string(s : GraphtreemstLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_buffer_make(size : Int) -> GraphtreemstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_buffer_len(s : GraphtreemstBuffer) -> Int { s.size }

pub fn graph_tree_mst_buffer_get(s : GraphtreemstBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_buffer_set(s : GraphtreemstBuffer, i : Int, v : Double) -> GraphtreemstBuffer {
  let result = graph_tree_mst_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_buffer_sum(s : GraphtreemstBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_buffer_mean(s : GraphtreemstBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_buffer_scale(s : GraphtreemstBuffer, f : Double) -> GraphtreemstBuffer {
  let result = graph_tree_mst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_buffer_add(a : GraphtreemstBuffer, b : GraphtreemstBuffer) -> GraphtreemstBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_buffer_copy(s : GraphtreemstBuffer) -> GraphtreemstBuffer {
  let result = graph_tree_mst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_buffer_fill(s : GraphtreemstBuffer, v : Double) -> GraphtreemstBuffer {
  let result = graph_tree_mst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_buffer_min(s : GraphtreemstBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_buffer_max(s : GraphtreemstBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_buffer_to_string(s : GraphtreemstBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_cursor_make(size : Int) -> GraphtreemstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_cursor_len(s : GraphtreemstCursor) -> Int { s.size }

pub fn graph_tree_mst_cursor_get(s : GraphtreemstCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_cursor_set(s : GraphtreemstCursor, i : Int, v : Double) -> GraphtreemstCursor {
  let result = graph_tree_mst_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_cursor_sum(s : GraphtreemstCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_cursor_mean(s : GraphtreemstCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_cursor_scale(s : GraphtreemstCursor, f : Double) -> GraphtreemstCursor {
  let result = graph_tree_mst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_cursor_add(a : GraphtreemstCursor, b : GraphtreemstCursor) -> GraphtreemstCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_cursor_copy(s : GraphtreemstCursor) -> GraphtreemstCursor {
  let result = graph_tree_mst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_cursor_fill(s : GraphtreemstCursor, v : Double) -> GraphtreemstCursor {
  let result = graph_tree_mst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_cursor_min(s : GraphtreemstCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_cursor_max(s : GraphtreemstCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_cursor_to_string(s : GraphtreemstCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_view_make(size : Int) -> GraphtreemstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_view_len(s : GraphtreemstView) -> Int { s.size }

pub fn graph_tree_mst_view_get(s : GraphtreemstView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_view_set(s : GraphtreemstView, i : Int, v : Double) -> GraphtreemstView {
  let result = graph_tree_mst_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_view_sum(s : GraphtreemstView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_view_mean(s : GraphtreemstView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_view_scale(s : GraphtreemstView, f : Double) -> GraphtreemstView {
  let result = graph_tree_mst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_view_add(a : GraphtreemstView, b : GraphtreemstView) -> GraphtreemstView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_view_copy(s : GraphtreemstView) -> GraphtreemstView {
  let result = graph_tree_mst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_view_fill(s : GraphtreemstView, v : Double) -> GraphtreemstView {
  let result = graph_tree_mst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_view_min(s : GraphtreemstView) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_view_max(s : GraphtreemstView) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_view_to_string(s : GraphtreemstView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_range_make(size : Int) -> GraphtreemstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_range_len(s : GraphtreemstRange) -> Int { s.size }

pub fn graph_tree_mst_range_get(s : GraphtreemstRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_range_set(s : GraphtreemstRange, i : Int, v : Double) -> GraphtreemstRange {
  let result = graph_tree_mst_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_range_sum(s : GraphtreemstRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_range_mean(s : GraphtreemstRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_range_scale(s : GraphtreemstRange, f : Double) -> GraphtreemstRange {
  let result = graph_tree_mst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_range_add(a : GraphtreemstRange, b : GraphtreemstRange) -> GraphtreemstRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_range_copy(s : GraphtreemstRange) -> GraphtreemstRange {
  let result = graph_tree_mst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_range_fill(s : GraphtreemstRange, v : Double) -> GraphtreemstRange {
  let result = graph_tree_mst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_range_min(s : GraphtreemstRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_range_max(s : GraphtreemstRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_range_to_string(s : GraphtreemstRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_slice_make(size : Int) -> GraphtreemstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_slice_len(s : GraphtreemstSlice) -> Int { s.size }

pub fn graph_tree_mst_slice_get(s : GraphtreemstSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_slice_set(s : GraphtreemstSlice, i : Int, v : Double) -> GraphtreemstSlice {
  let result = graph_tree_mst_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_slice_sum(s : GraphtreemstSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_slice_mean(s : GraphtreemstSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_slice_scale(s : GraphtreemstSlice, f : Double) -> GraphtreemstSlice {
  let result = graph_tree_mst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_slice_add(a : GraphtreemstSlice, b : GraphtreemstSlice) -> GraphtreemstSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_slice_copy(s : GraphtreemstSlice) -> GraphtreemstSlice {
  let result = graph_tree_mst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_slice_fill(s : GraphtreemstSlice, v : Double) -> GraphtreemstSlice {
  let result = graph_tree_mst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_slice_min(s : GraphtreemstSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_slice_max(s : GraphtreemstSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_slice_to_string(s : GraphtreemstSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

