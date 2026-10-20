///===
/// extcore/graph_tree_center

pub(all) struct GraphtreecenterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_center_make_point(x : Double, y : Double) -> GraphtreecenterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_center_make_point3(x : Double, y : Double, z : Double) -> GraphtreecenterPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_center_point_x(pt : GraphtreecenterPoint) -> Double { pt.x }

pub fn graph_tree_center_point_y(pt : GraphtreecenterPoint) -> Double { pt.y }

pub fn graph_tree_center_point_z(pt : GraphtreecenterPoint) -> Double { pt.z }

pub fn graph_tree_center_point_label(pt : GraphtreecenterPoint) -> Int { pt.label }

pub fn graph_tree_center_point_dist(a : GraphtreecenterPoint, b : GraphtreecenterPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_center_point_add(a : GraphtreecenterPoint, b : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_center_point_sub(a : GraphtreecenterPoint, b : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_center_point_scale(pt : GraphtreecenterPoint, s : Double) -> GraphtreecenterPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_center_point_dot(a : GraphtreecenterPoint, b : GraphtreecenterPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_center_point_cross(a : GraphtreecenterPoint, b : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_center_point_norm(pt : GraphtreecenterPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_center_point_normalize(pt : GraphtreecenterPoint) -> GraphtreecenterPoint {
  let n = graph_tree_center_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_center_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_center_point_negate(pt : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_center_point_mid(a : GraphtreecenterPoint, b : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_center_point_lerp(a : GraphtreecenterPoint, b : GraphtreecenterPoint, t : Double) -> GraphtreecenterPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_center_point_to_string(pt : GraphtreecenterPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreecenterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_center_make_series(vals : Array[Double], name : String) -> GraphtreecenterSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_center_series_len(s : GraphtreecenterSeries) -> Int { s.vals.length() }

pub fn graph_tree_center_series_sum(s : GraphtreecenterSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_tree_center_series_mean(s : GraphtreecenterSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_tree_center_series_min(s : GraphtreecenterSeries) -> Double { @_common.min(s.vals) }

pub fn graph_tree_center_series_max(s : GraphtreecenterSeries) -> Double { @_common.max(s.vals) }

pub fn graph_tree_center_series_range(s : GraphtreecenterSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_tree_center_series_var(s : GraphtreecenterSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_tree_center_series_std(s : GraphtreecenterSeries) -> Double { @_common.std(s.vals) }

pub fn graph_tree_center_series_median(s : GraphtreecenterSeries) -> Double { @_common.median(s.vals) }

pub fn graph_tree_center_series_scale(s : GraphtreecenterSeries, f : Double) -> GraphtreecenterSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_tree_center_series_add(a : GraphtreecenterSeries, b : GraphtreecenterSeries) -> GraphtreecenterSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_center_series_sub(a : GraphtreecenterSeries, b : GraphtreecenterSeries) -> GraphtreecenterSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_center_series_normalize(s : GraphtreecenterSeries) -> GraphtreecenterSeries {
  let mn = graph_tree_center_series_min(s)
  let mx = graph_tree_center_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_center_series_cumsum(s : GraphtreecenterSeries) -> GraphtreecenterSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_center_series_to_string(s : GraphtreecenterSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreecenterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_center_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreecenterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_center_matrix_identity(n : Int) -> GraphtreecenterMatrix {
  let m = graph_tree_center_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_center_matrix_get(m : GraphtreecenterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_center_matrix_transpose(m : GraphtreecenterMatrix) -> GraphtreecenterMatrix {
  let result = graph_tree_center_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_center_matrix_add(a : GraphtreecenterMatrix, b : GraphtreecenterMatrix) -> GraphtreecenterMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_center_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_center_matrix_scale(m : GraphtreecenterMatrix, s : Double) -> GraphtreecenterMatrix {
  let result = graph_tree_center_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_center_matrix_multiply(a : GraphtreecenterMatrix, b : GraphtreecenterMatrix) -> GraphtreecenterMatrix {
  if a.cols != b.rows { return graph_tree_center_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_center_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_center_matrix_trace(m : GraphtreecenterMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_center_matrix_det(m : GraphtreecenterMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_center_matrix_norm(m : GraphtreecenterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_tree_center_matrix_to_string(m : GraphtreecenterMatrix) -> String {
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

pub(all) struct GraphtreecenterVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_center_make_vector(comps : Array[Double]) -> GraphtreecenterVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_center_vector_zero(dim : Int) -> GraphtreecenterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_center_vector_add(a : GraphtreecenterVector, b : GraphtreecenterVector) -> GraphtreecenterVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_center_vector_sub(a : GraphtreecenterVector, b : GraphtreecenterVector) -> GraphtreecenterVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_center_vector_scale(v : GraphtreecenterVector, s : Double) -> GraphtreecenterVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_tree_center_vector_dot(a : GraphtreecenterVector, b : GraphtreecenterVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_center_vector_norm(v : GraphtreecenterVector) -> Double { @_common.sqrt(graph_tree_center_vector_dot(v, v)) }

pub fn graph_tree_center_vector_normalize(v : GraphtreecenterVector) -> GraphtreecenterVector {
  let n = graph_tree_center_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_center_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_center_vector_dist(a : GraphtreecenterVector, b : GraphtreecenterVector) -> Double {
  graph_tree_center_vector_norm(graph_tree_center_vector_sub(a, b))
}

pub fn graph_tree_center_vector_to_string(v : GraphtreecenterVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_center_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_center_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_center_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_center_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_center_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_center_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_center_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_center_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_center_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_center_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_center_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_center_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_center_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_center_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_center_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_center_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_center_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_center_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_center_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_center_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_center_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_center_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_center_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_center_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_center_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_center_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_center_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_center_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_center_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreecenterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_frame_make(size : Int) -> GraphtreecenterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_frame_len(s : GraphtreecenterFrame) -> Int { s.size }

pub fn graph_tree_center_frame_get(s : GraphtreecenterFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_frame_set(s : GraphtreecenterFrame, i : Int, v : Double) -> GraphtreecenterFrame {
  let result = graph_tree_center_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_frame_sum(s : GraphtreecenterFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_frame_mean(s : GraphtreecenterFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_frame_scale(s : GraphtreecenterFrame, f : Double) -> GraphtreecenterFrame {
  let result = graph_tree_center_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_frame_add(a : GraphtreecenterFrame, b : GraphtreecenterFrame) -> GraphtreecenterFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_frame_copy(s : GraphtreecenterFrame) -> GraphtreecenterFrame {
  let result = graph_tree_center_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_frame_fill(s : GraphtreecenterFrame, v : Double) -> GraphtreecenterFrame {
  let result = graph_tree_center_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_frame_min(s : GraphtreecenterFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_frame_max(s : GraphtreecenterFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_frame_to_string(s : GraphtreecenterFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_table_make(size : Int) -> GraphtreecenterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_table_len(s : GraphtreecenterTable) -> Int { s.size }

pub fn graph_tree_center_table_get(s : GraphtreecenterTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_table_set(s : GraphtreecenterTable, i : Int, v : Double) -> GraphtreecenterTable {
  let result = graph_tree_center_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_table_sum(s : GraphtreecenterTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_table_mean(s : GraphtreecenterTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_table_scale(s : GraphtreecenterTable, f : Double) -> GraphtreecenterTable {
  let result = graph_tree_center_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_table_add(a : GraphtreecenterTable, b : GraphtreecenterTable) -> GraphtreecenterTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_table_copy(s : GraphtreecenterTable) -> GraphtreecenterTable {
  let result = graph_tree_center_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_table_fill(s : GraphtreecenterTable, v : Double) -> GraphtreecenterTable {
  let result = graph_tree_center_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_table_min(s : GraphtreecenterTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_table_max(s : GraphtreecenterTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_table_to_string(s : GraphtreecenterTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_graphn_make(size : Int) -> GraphtreecenterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_graphn_len(s : GraphtreecenterGraphN) -> Int { s.size }

pub fn graph_tree_center_graphn_get(s : GraphtreecenterGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_graphn_set(s : GraphtreecenterGraphN, i : Int, v : Double) -> GraphtreecenterGraphN {
  let result = graph_tree_center_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_graphn_sum(s : GraphtreecenterGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_graphn_mean(s : GraphtreecenterGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_graphn_scale(s : GraphtreecenterGraphN, f : Double) -> GraphtreecenterGraphN {
  let result = graph_tree_center_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_graphn_add(a : GraphtreecenterGraphN, b : GraphtreecenterGraphN) -> GraphtreecenterGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_graphn_copy(s : GraphtreecenterGraphN) -> GraphtreecenterGraphN {
  let result = graph_tree_center_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_graphn_fill(s : GraphtreecenterGraphN, v : Double) -> GraphtreecenterGraphN {
  let result = graph_tree_center_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_graphn_min(s : GraphtreecenterGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_graphn_max(s : GraphtreecenterGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_graphn_to_string(s : GraphtreecenterGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_node_make(size : Int) -> GraphtreecenterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_node_len(s : GraphtreecenterNode) -> Int { s.size }

pub fn graph_tree_center_node_get(s : GraphtreecenterNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_node_set(s : GraphtreecenterNode, i : Int, v : Double) -> GraphtreecenterNode {
  let result = graph_tree_center_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_node_sum(s : GraphtreecenterNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_node_mean(s : GraphtreecenterNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_node_scale(s : GraphtreecenterNode, f : Double) -> GraphtreecenterNode {
  let result = graph_tree_center_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_node_add(a : GraphtreecenterNode, b : GraphtreecenterNode) -> GraphtreecenterNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_node_copy(s : GraphtreecenterNode) -> GraphtreecenterNode {
  let result = graph_tree_center_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_node_fill(s : GraphtreecenterNode, v : Double) -> GraphtreecenterNode {
  let result = graph_tree_center_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_node_min(s : GraphtreecenterNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_node_max(s : GraphtreecenterNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_node_to_string(s : GraphtreecenterNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_edge_make(size : Int) -> GraphtreecenterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_edge_len(s : GraphtreecenterEdge) -> Int { s.size }

pub fn graph_tree_center_edge_get(s : GraphtreecenterEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_edge_set(s : GraphtreecenterEdge, i : Int, v : Double) -> GraphtreecenterEdge {
  let result = graph_tree_center_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_edge_sum(s : GraphtreecenterEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_edge_mean(s : GraphtreecenterEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_edge_scale(s : GraphtreecenterEdge, f : Double) -> GraphtreecenterEdge {
  let result = graph_tree_center_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_edge_add(a : GraphtreecenterEdge, b : GraphtreecenterEdge) -> GraphtreecenterEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_edge_copy(s : GraphtreecenterEdge) -> GraphtreecenterEdge {
  let result = graph_tree_center_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_edge_fill(s : GraphtreecenterEdge, v : Double) -> GraphtreecenterEdge {
  let result = graph_tree_center_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_edge_min(s : GraphtreecenterEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_edge_max(s : GraphtreecenterEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_edge_to_string(s : GraphtreecenterEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_path_make(size : Int) -> GraphtreecenterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_path_len(s : GraphtreecenterPath) -> Int { s.size }

pub fn graph_tree_center_path_get(s : GraphtreecenterPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_path_set(s : GraphtreecenterPath, i : Int, v : Double) -> GraphtreecenterPath {
  let result = graph_tree_center_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_path_sum(s : GraphtreecenterPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_path_mean(s : GraphtreecenterPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_path_scale(s : GraphtreecenterPath, f : Double) -> GraphtreecenterPath {
  let result = graph_tree_center_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_path_add(a : GraphtreecenterPath, b : GraphtreecenterPath) -> GraphtreecenterPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_path_copy(s : GraphtreecenterPath) -> GraphtreecenterPath {
  let result = graph_tree_center_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_path_fill(s : GraphtreecenterPath, v : Double) -> GraphtreecenterPath {
  let result = graph_tree_center_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_path_min(s : GraphtreecenterPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_path_max(s : GraphtreecenterPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_path_to_string(s : GraphtreecenterPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_cluster_make(size : Int) -> GraphtreecenterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_cluster_len(s : GraphtreecenterCluster) -> Int { s.size }

pub fn graph_tree_center_cluster_get(s : GraphtreecenterCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_cluster_set(s : GraphtreecenterCluster, i : Int, v : Double) -> GraphtreecenterCluster {
  let result = graph_tree_center_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_cluster_sum(s : GraphtreecenterCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_cluster_mean(s : GraphtreecenterCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_cluster_scale(s : GraphtreecenterCluster, f : Double) -> GraphtreecenterCluster {
  let result = graph_tree_center_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_cluster_add(a : GraphtreecenterCluster, b : GraphtreecenterCluster) -> GraphtreecenterCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_cluster_copy(s : GraphtreecenterCluster) -> GraphtreecenterCluster {
  let result = graph_tree_center_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_cluster_fill(s : GraphtreecenterCluster, v : Double) -> GraphtreecenterCluster {
  let result = graph_tree_center_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_cluster_min(s : GraphtreecenterCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_cluster_max(s : GraphtreecenterCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_cluster_to_string(s : GraphtreecenterCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_model_make(size : Int) -> GraphtreecenterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_model_len(s : GraphtreecenterModel) -> Int { s.size }

pub fn graph_tree_center_model_get(s : GraphtreecenterModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_model_set(s : GraphtreecenterModel, i : Int, v : Double) -> GraphtreecenterModel {
  let result = graph_tree_center_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_model_sum(s : GraphtreecenterModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_model_mean(s : GraphtreecenterModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_model_scale(s : GraphtreecenterModel, f : Double) -> GraphtreecenterModel {
  let result = graph_tree_center_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_model_add(a : GraphtreecenterModel, b : GraphtreecenterModel) -> GraphtreecenterModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_model_copy(s : GraphtreecenterModel) -> GraphtreecenterModel {
  let result = graph_tree_center_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_model_fill(s : GraphtreecenterModel, v : Double) -> GraphtreecenterModel {
  let result = graph_tree_center_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_model_min(s : GraphtreecenterModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_model_max(s : GraphtreecenterModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_model_to_string(s : GraphtreecenterModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_layer_make(size : Int) -> GraphtreecenterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_layer_len(s : GraphtreecenterLayer) -> Int { s.size }

pub fn graph_tree_center_layer_get(s : GraphtreecenterLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_layer_set(s : GraphtreecenterLayer, i : Int, v : Double) -> GraphtreecenterLayer {
  let result = graph_tree_center_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_layer_sum(s : GraphtreecenterLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_layer_mean(s : GraphtreecenterLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_layer_scale(s : GraphtreecenterLayer, f : Double) -> GraphtreecenterLayer {
  let result = graph_tree_center_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_layer_add(a : GraphtreecenterLayer, b : GraphtreecenterLayer) -> GraphtreecenterLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_layer_copy(s : GraphtreecenterLayer) -> GraphtreecenterLayer {
  let result = graph_tree_center_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_layer_fill(s : GraphtreecenterLayer, v : Double) -> GraphtreecenterLayer {
  let result = graph_tree_center_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_layer_min(s : GraphtreecenterLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_layer_max(s : GraphtreecenterLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_layer_to_string(s : GraphtreecenterLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_buffer_make(size : Int) -> GraphtreecenterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_buffer_len(s : GraphtreecenterBuffer) -> Int { s.size }

pub fn graph_tree_center_buffer_get(s : GraphtreecenterBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_buffer_set(s : GraphtreecenterBuffer, i : Int, v : Double) -> GraphtreecenterBuffer {
  let result = graph_tree_center_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_buffer_sum(s : GraphtreecenterBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_buffer_mean(s : GraphtreecenterBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_buffer_scale(s : GraphtreecenterBuffer, f : Double) -> GraphtreecenterBuffer {
  let result = graph_tree_center_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_buffer_add(a : GraphtreecenterBuffer, b : GraphtreecenterBuffer) -> GraphtreecenterBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_buffer_copy(s : GraphtreecenterBuffer) -> GraphtreecenterBuffer {
  let result = graph_tree_center_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_buffer_fill(s : GraphtreecenterBuffer, v : Double) -> GraphtreecenterBuffer {
  let result = graph_tree_center_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_buffer_min(s : GraphtreecenterBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_buffer_max(s : GraphtreecenterBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_buffer_to_string(s : GraphtreecenterBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_cursor_make(size : Int) -> GraphtreecenterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_cursor_len(s : GraphtreecenterCursor) -> Int { s.size }

pub fn graph_tree_center_cursor_get(s : GraphtreecenterCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_cursor_set(s : GraphtreecenterCursor, i : Int, v : Double) -> GraphtreecenterCursor {
  let result = graph_tree_center_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_cursor_sum(s : GraphtreecenterCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_cursor_mean(s : GraphtreecenterCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_cursor_scale(s : GraphtreecenterCursor, f : Double) -> GraphtreecenterCursor {
  let result = graph_tree_center_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_cursor_add(a : GraphtreecenterCursor, b : GraphtreecenterCursor) -> GraphtreecenterCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_cursor_copy(s : GraphtreecenterCursor) -> GraphtreecenterCursor {
  let result = graph_tree_center_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_cursor_fill(s : GraphtreecenterCursor, v : Double) -> GraphtreecenterCursor {
  let result = graph_tree_center_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_cursor_min(s : GraphtreecenterCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_cursor_max(s : GraphtreecenterCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_cursor_to_string(s : GraphtreecenterCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_view_make(size : Int) -> GraphtreecenterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_view_len(s : GraphtreecenterView) -> Int { s.size }

pub fn graph_tree_center_view_get(s : GraphtreecenterView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_view_set(s : GraphtreecenterView, i : Int, v : Double) -> GraphtreecenterView {
  let result = graph_tree_center_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_view_sum(s : GraphtreecenterView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_view_mean(s : GraphtreecenterView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_view_scale(s : GraphtreecenterView, f : Double) -> GraphtreecenterView {
  let result = graph_tree_center_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_view_add(a : GraphtreecenterView, b : GraphtreecenterView) -> GraphtreecenterView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_view_copy(s : GraphtreecenterView) -> GraphtreecenterView {
  let result = graph_tree_center_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_view_fill(s : GraphtreecenterView, v : Double) -> GraphtreecenterView {
  let result = graph_tree_center_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_view_min(s : GraphtreecenterView) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_view_max(s : GraphtreecenterView) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_view_to_string(s : GraphtreecenterView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_range_make(size : Int) -> GraphtreecenterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_range_len(s : GraphtreecenterRange) -> Int { s.size }

pub fn graph_tree_center_range_get(s : GraphtreecenterRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_range_set(s : GraphtreecenterRange, i : Int, v : Double) -> GraphtreecenterRange {
  let result = graph_tree_center_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_range_sum(s : GraphtreecenterRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_range_mean(s : GraphtreecenterRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_range_scale(s : GraphtreecenterRange, f : Double) -> GraphtreecenterRange {
  let result = graph_tree_center_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_range_add(a : GraphtreecenterRange, b : GraphtreecenterRange) -> GraphtreecenterRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_range_copy(s : GraphtreecenterRange) -> GraphtreecenterRange {
  let result = graph_tree_center_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_range_fill(s : GraphtreecenterRange, v : Double) -> GraphtreecenterRange {
  let result = graph_tree_center_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_range_min(s : GraphtreecenterRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_range_max(s : GraphtreecenterRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_range_to_string(s : GraphtreecenterRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_slice_make(size : Int) -> GraphtreecenterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_slice_len(s : GraphtreecenterSlice) -> Int { s.size }

pub fn graph_tree_center_slice_get(s : GraphtreecenterSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_slice_set(s : GraphtreecenterSlice, i : Int, v : Double) -> GraphtreecenterSlice {
  let result = graph_tree_center_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_slice_sum(s : GraphtreecenterSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_slice_mean(s : GraphtreecenterSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_slice_scale(s : GraphtreecenterSlice, f : Double) -> GraphtreecenterSlice {
  let result = graph_tree_center_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_center_slice_add(a : GraphtreecenterSlice, b : GraphtreecenterSlice) -> GraphtreecenterSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_center_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_center_slice_copy(s : GraphtreecenterSlice) -> GraphtreecenterSlice {
  let result = graph_tree_center_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_center_slice_fill(s : GraphtreecenterSlice, v : Double) -> GraphtreecenterSlice {
  let result = graph_tree_center_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_center_slice_min(s : GraphtreecenterSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_slice_max(s : GraphtreecenterSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_slice_to_string(s : GraphtreecenterSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

