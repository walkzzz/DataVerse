///===
/// extcore/graph_color_edge

pub(all) struct GraphcoloredgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_edge_make_point(x : Double, y : Double) -> GraphcoloredgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_edge_make_point3(x : Double, y : Double, z : Double) -> GraphcoloredgePoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_edge_point_x(pt : GraphcoloredgePoint) -> Double { pt.x }

pub fn graph_color_edge_point_y(pt : GraphcoloredgePoint) -> Double { pt.y }

pub fn graph_color_edge_point_z(pt : GraphcoloredgePoint) -> Double { pt.z }

pub fn graph_color_edge_point_label(pt : GraphcoloredgePoint) -> Int { pt.label }

pub fn graph_color_edge_point_dist(a : GraphcoloredgePoint, b : GraphcoloredgePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_edge_point_add(a : GraphcoloredgePoint, b : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_edge_point_sub(a : GraphcoloredgePoint, b : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_edge_point_scale(pt : GraphcoloredgePoint, s : Double) -> GraphcoloredgePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_edge_point_dot(a : GraphcoloredgePoint, b : GraphcoloredgePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_edge_point_cross(a : GraphcoloredgePoint, b : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_edge_point_norm(pt : GraphcoloredgePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_edge_point_normalize(pt : GraphcoloredgePoint) -> GraphcoloredgePoint {
  let n = graph_color_edge_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_edge_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_edge_point_negate(pt : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_edge_point_mid(a : GraphcoloredgePoint, b : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_edge_point_lerp(a : GraphcoloredgePoint, b : GraphcoloredgePoint, t : Double) -> GraphcoloredgePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_edge_point_to_string(pt : GraphcoloredgePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcoloredgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_edge_make_series(vals : Array[Double], name : String) -> GraphcoloredgeSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_edge_series_len(s : GraphcoloredgeSeries) -> Int { s.vals.length() }

pub fn graph_color_edge_series_sum(s : GraphcoloredgeSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_color_edge_series_mean(s : GraphcoloredgeSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_color_edge_series_min(s : GraphcoloredgeSeries) -> Double { @_common.min(s.vals) }

pub fn graph_color_edge_series_max(s : GraphcoloredgeSeries) -> Double { @_common.max(s.vals) }

pub fn graph_color_edge_series_range(s : GraphcoloredgeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_color_edge_series_var(s : GraphcoloredgeSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_color_edge_series_std(s : GraphcoloredgeSeries) -> Double { @_common.std(s.vals) }

pub fn graph_color_edge_series_median(s : GraphcoloredgeSeries) -> Double { @_common.median(s.vals) }

pub fn graph_color_edge_series_scale(s : GraphcoloredgeSeries, f : Double) -> GraphcoloredgeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_edge_series_add(a : GraphcoloredgeSeries, b : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_edge_series_sub(a : GraphcoloredgeSeries, b : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_edge_series_normalize(s : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  let mn = graph_color_edge_series_min(s)
  let mx = graph_color_edge_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_edge_series_cumsum(s : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_edge_series_to_string(s : GraphcoloredgeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcoloredgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_edge_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcoloredgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_edge_matrix_identity(n : Int) -> GraphcoloredgeMatrix {
  let m = graph_color_edge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_edge_matrix_get(m : GraphcoloredgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_edge_matrix_transpose(m : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  let result = graph_color_edge_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_edge_matrix_add(a : GraphcoloredgeMatrix, b : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_edge_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_edge_matrix_scale(m : GraphcoloredgeMatrix, s : Double) -> GraphcoloredgeMatrix {
  let result = graph_color_edge_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_edge_matrix_multiply(a : GraphcoloredgeMatrix, b : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  if a.cols != b.rows { return graph_color_edge_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_edge_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_edge_matrix_trace(m : GraphcoloredgeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_edge_matrix_det(m : GraphcoloredgeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_edge_matrix_norm(m : GraphcoloredgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_edge_matrix_to_string(m : GraphcoloredgeMatrix) -> String {
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

pub(all) struct GraphcoloredgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_edge_make_vector(comps : Array[Double]) -> GraphcoloredgeVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_edge_vector_zero(dim : Int) -> GraphcoloredgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_edge_vector_add(a : GraphcoloredgeVector, b : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_edge_vector_sub(a : GraphcoloredgeVector, b : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_edge_vector_scale(v : GraphcoloredgeVector, s : Double) -> GraphcoloredgeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_edge_vector_dot(a : GraphcoloredgeVector, b : GraphcoloredgeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_edge_vector_norm(v : GraphcoloredgeVector) -> Double { @_common.sqrt(graph_color_edge_vector_dot(v, v)) }

pub fn graph_color_edge_vector_normalize(v : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = graph_color_edge_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_edge_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_edge_vector_dist(a : GraphcoloredgeVector, b : GraphcoloredgeVector) -> Double {
  graph_color_edge_vector_norm(graph_color_edge_vector_sub(a, b))
}

pub fn graph_color_edge_vector_to_string(v : GraphcoloredgeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_edge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_edge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_edge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_edge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_edge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_edge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_edge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_edge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_edge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_edge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_edge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_edge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_edge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_edge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_edge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_edge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_edge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_edge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_edge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_edge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_edge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_edge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_edge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_edge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_edge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_edge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_edge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_edge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_edge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcoloredgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_frame_make(size : Int) -> GraphcoloredgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_frame_len(s : GraphcoloredgeFrame) -> Int { s.size }

pub fn graph_color_edge_frame_get(s : GraphcoloredgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_frame_set(s : GraphcoloredgeFrame, i : Int, v : Double) -> GraphcoloredgeFrame {
  let result = graph_color_edge_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_frame_sum(s : GraphcoloredgeFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_frame_mean(s : GraphcoloredgeFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_frame_scale(s : GraphcoloredgeFrame, f : Double) -> GraphcoloredgeFrame {
  let result = graph_color_edge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_frame_add(a : GraphcoloredgeFrame, b : GraphcoloredgeFrame) -> GraphcoloredgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_frame_copy(s : GraphcoloredgeFrame) -> GraphcoloredgeFrame {
  let result = graph_color_edge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_frame_fill(s : GraphcoloredgeFrame, v : Double) -> GraphcoloredgeFrame {
  let result = graph_color_edge_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_frame_min(s : GraphcoloredgeFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_frame_max(s : GraphcoloredgeFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_frame_to_string(s : GraphcoloredgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_table_make(size : Int) -> GraphcoloredgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_table_len(s : GraphcoloredgeTable) -> Int { s.size }

pub fn graph_color_edge_table_get(s : GraphcoloredgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_table_set(s : GraphcoloredgeTable, i : Int, v : Double) -> GraphcoloredgeTable {
  let result = graph_color_edge_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_table_sum(s : GraphcoloredgeTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_table_mean(s : GraphcoloredgeTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_table_scale(s : GraphcoloredgeTable, f : Double) -> GraphcoloredgeTable {
  let result = graph_color_edge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_table_add(a : GraphcoloredgeTable, b : GraphcoloredgeTable) -> GraphcoloredgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_table_copy(s : GraphcoloredgeTable) -> GraphcoloredgeTable {
  let result = graph_color_edge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_table_fill(s : GraphcoloredgeTable, v : Double) -> GraphcoloredgeTable {
  let result = graph_color_edge_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_table_min(s : GraphcoloredgeTable) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_table_max(s : GraphcoloredgeTable) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_table_to_string(s : GraphcoloredgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_graphn_make(size : Int) -> GraphcoloredgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_graphn_len(s : GraphcoloredgeGraphN) -> Int { s.size }

pub fn graph_color_edge_graphn_get(s : GraphcoloredgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_graphn_set(s : GraphcoloredgeGraphN, i : Int, v : Double) -> GraphcoloredgeGraphN {
  let result = graph_color_edge_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_graphn_sum(s : GraphcoloredgeGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_graphn_mean(s : GraphcoloredgeGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_graphn_scale(s : GraphcoloredgeGraphN, f : Double) -> GraphcoloredgeGraphN {
  let result = graph_color_edge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_graphn_add(a : GraphcoloredgeGraphN, b : GraphcoloredgeGraphN) -> GraphcoloredgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_graphn_copy(s : GraphcoloredgeGraphN) -> GraphcoloredgeGraphN {
  let result = graph_color_edge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_graphn_fill(s : GraphcoloredgeGraphN, v : Double) -> GraphcoloredgeGraphN {
  let result = graph_color_edge_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_graphn_min(s : GraphcoloredgeGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_graphn_max(s : GraphcoloredgeGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_graphn_to_string(s : GraphcoloredgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_node_make(size : Int) -> GraphcoloredgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_node_len(s : GraphcoloredgeNode) -> Int { s.size }

pub fn graph_color_edge_node_get(s : GraphcoloredgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_node_set(s : GraphcoloredgeNode, i : Int, v : Double) -> GraphcoloredgeNode {
  let result = graph_color_edge_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_node_sum(s : GraphcoloredgeNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_node_mean(s : GraphcoloredgeNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_node_scale(s : GraphcoloredgeNode, f : Double) -> GraphcoloredgeNode {
  let result = graph_color_edge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_node_add(a : GraphcoloredgeNode, b : GraphcoloredgeNode) -> GraphcoloredgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_node_copy(s : GraphcoloredgeNode) -> GraphcoloredgeNode {
  let result = graph_color_edge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_node_fill(s : GraphcoloredgeNode, v : Double) -> GraphcoloredgeNode {
  let result = graph_color_edge_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_node_min(s : GraphcoloredgeNode) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_node_max(s : GraphcoloredgeNode) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_node_to_string(s : GraphcoloredgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_edge_make(size : Int) -> GraphcoloredgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_edge_len(s : GraphcoloredgeEdge) -> Int { s.size }

pub fn graph_color_edge_edge_get(s : GraphcoloredgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_edge_set(s : GraphcoloredgeEdge, i : Int, v : Double) -> GraphcoloredgeEdge {
  let result = graph_color_edge_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_edge_sum(s : GraphcoloredgeEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_edge_mean(s : GraphcoloredgeEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_edge_scale(s : GraphcoloredgeEdge, f : Double) -> GraphcoloredgeEdge {
  let result = graph_color_edge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_edge_add(a : GraphcoloredgeEdge, b : GraphcoloredgeEdge) -> GraphcoloredgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_edge_copy(s : GraphcoloredgeEdge) -> GraphcoloredgeEdge {
  let result = graph_color_edge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_edge_fill(s : GraphcoloredgeEdge, v : Double) -> GraphcoloredgeEdge {
  let result = graph_color_edge_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_edge_min(s : GraphcoloredgeEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_edge_max(s : GraphcoloredgeEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_edge_to_string(s : GraphcoloredgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_path_make(size : Int) -> GraphcoloredgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_path_len(s : GraphcoloredgePath) -> Int { s.size }

pub fn graph_color_edge_path_get(s : GraphcoloredgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_path_set(s : GraphcoloredgePath, i : Int, v : Double) -> GraphcoloredgePath {
  let result = graph_color_edge_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_path_sum(s : GraphcoloredgePath) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_path_mean(s : GraphcoloredgePath) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_path_scale(s : GraphcoloredgePath, f : Double) -> GraphcoloredgePath {
  let result = graph_color_edge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_path_add(a : GraphcoloredgePath, b : GraphcoloredgePath) -> GraphcoloredgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_path_copy(s : GraphcoloredgePath) -> GraphcoloredgePath {
  let result = graph_color_edge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_path_fill(s : GraphcoloredgePath, v : Double) -> GraphcoloredgePath {
  let result = graph_color_edge_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_path_min(s : GraphcoloredgePath) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_path_max(s : GraphcoloredgePath) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_path_to_string(s : GraphcoloredgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_cluster_make(size : Int) -> GraphcoloredgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_cluster_len(s : GraphcoloredgeCluster) -> Int { s.size }

pub fn graph_color_edge_cluster_get(s : GraphcoloredgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_cluster_set(s : GraphcoloredgeCluster, i : Int, v : Double) -> GraphcoloredgeCluster {
  let result = graph_color_edge_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_cluster_sum(s : GraphcoloredgeCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_cluster_mean(s : GraphcoloredgeCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_cluster_scale(s : GraphcoloredgeCluster, f : Double) -> GraphcoloredgeCluster {
  let result = graph_color_edge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_cluster_add(a : GraphcoloredgeCluster, b : GraphcoloredgeCluster) -> GraphcoloredgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_cluster_copy(s : GraphcoloredgeCluster) -> GraphcoloredgeCluster {
  let result = graph_color_edge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_cluster_fill(s : GraphcoloredgeCluster, v : Double) -> GraphcoloredgeCluster {
  let result = graph_color_edge_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_cluster_min(s : GraphcoloredgeCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_cluster_max(s : GraphcoloredgeCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_cluster_to_string(s : GraphcoloredgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_model_make(size : Int) -> GraphcoloredgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_model_len(s : GraphcoloredgeModel) -> Int { s.size }

pub fn graph_color_edge_model_get(s : GraphcoloredgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_model_set(s : GraphcoloredgeModel, i : Int, v : Double) -> GraphcoloredgeModel {
  let result = graph_color_edge_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_model_sum(s : GraphcoloredgeModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_model_mean(s : GraphcoloredgeModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_model_scale(s : GraphcoloredgeModel, f : Double) -> GraphcoloredgeModel {
  let result = graph_color_edge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_model_add(a : GraphcoloredgeModel, b : GraphcoloredgeModel) -> GraphcoloredgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_model_copy(s : GraphcoloredgeModel) -> GraphcoloredgeModel {
  let result = graph_color_edge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_model_fill(s : GraphcoloredgeModel, v : Double) -> GraphcoloredgeModel {
  let result = graph_color_edge_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_model_min(s : GraphcoloredgeModel) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_model_max(s : GraphcoloredgeModel) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_model_to_string(s : GraphcoloredgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_layer_make(size : Int) -> GraphcoloredgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_layer_len(s : GraphcoloredgeLayer) -> Int { s.size }

pub fn graph_color_edge_layer_get(s : GraphcoloredgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_layer_set(s : GraphcoloredgeLayer, i : Int, v : Double) -> GraphcoloredgeLayer {
  let result = graph_color_edge_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_layer_sum(s : GraphcoloredgeLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_layer_mean(s : GraphcoloredgeLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_layer_scale(s : GraphcoloredgeLayer, f : Double) -> GraphcoloredgeLayer {
  let result = graph_color_edge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_layer_add(a : GraphcoloredgeLayer, b : GraphcoloredgeLayer) -> GraphcoloredgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_layer_copy(s : GraphcoloredgeLayer) -> GraphcoloredgeLayer {
  let result = graph_color_edge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_layer_fill(s : GraphcoloredgeLayer, v : Double) -> GraphcoloredgeLayer {
  let result = graph_color_edge_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_layer_min(s : GraphcoloredgeLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_layer_max(s : GraphcoloredgeLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_layer_to_string(s : GraphcoloredgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_buffer_make(size : Int) -> GraphcoloredgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_buffer_len(s : GraphcoloredgeBuffer) -> Int { s.size }

pub fn graph_color_edge_buffer_get(s : GraphcoloredgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_buffer_set(s : GraphcoloredgeBuffer, i : Int, v : Double) -> GraphcoloredgeBuffer {
  let result = graph_color_edge_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_buffer_sum(s : GraphcoloredgeBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_buffer_mean(s : GraphcoloredgeBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_buffer_scale(s : GraphcoloredgeBuffer, f : Double) -> GraphcoloredgeBuffer {
  let result = graph_color_edge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_buffer_add(a : GraphcoloredgeBuffer, b : GraphcoloredgeBuffer) -> GraphcoloredgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_buffer_copy(s : GraphcoloredgeBuffer) -> GraphcoloredgeBuffer {
  let result = graph_color_edge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_buffer_fill(s : GraphcoloredgeBuffer, v : Double) -> GraphcoloredgeBuffer {
  let result = graph_color_edge_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_buffer_min(s : GraphcoloredgeBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_buffer_max(s : GraphcoloredgeBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_buffer_to_string(s : GraphcoloredgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_cursor_make(size : Int) -> GraphcoloredgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_cursor_len(s : GraphcoloredgeCursor) -> Int { s.size }

pub fn graph_color_edge_cursor_get(s : GraphcoloredgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_cursor_set(s : GraphcoloredgeCursor, i : Int, v : Double) -> GraphcoloredgeCursor {
  let result = graph_color_edge_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_cursor_sum(s : GraphcoloredgeCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_cursor_mean(s : GraphcoloredgeCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_cursor_scale(s : GraphcoloredgeCursor, f : Double) -> GraphcoloredgeCursor {
  let result = graph_color_edge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_cursor_add(a : GraphcoloredgeCursor, b : GraphcoloredgeCursor) -> GraphcoloredgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_cursor_copy(s : GraphcoloredgeCursor) -> GraphcoloredgeCursor {
  let result = graph_color_edge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_cursor_fill(s : GraphcoloredgeCursor, v : Double) -> GraphcoloredgeCursor {
  let result = graph_color_edge_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_cursor_min(s : GraphcoloredgeCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_cursor_max(s : GraphcoloredgeCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_cursor_to_string(s : GraphcoloredgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_view_make(size : Int) -> GraphcoloredgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_view_len(s : GraphcoloredgeView) -> Int { s.size }

pub fn graph_color_edge_view_get(s : GraphcoloredgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_view_set(s : GraphcoloredgeView, i : Int, v : Double) -> GraphcoloredgeView {
  let result = graph_color_edge_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_view_sum(s : GraphcoloredgeView) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_view_mean(s : GraphcoloredgeView) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_view_scale(s : GraphcoloredgeView, f : Double) -> GraphcoloredgeView {
  let result = graph_color_edge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_view_add(a : GraphcoloredgeView, b : GraphcoloredgeView) -> GraphcoloredgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_view_copy(s : GraphcoloredgeView) -> GraphcoloredgeView {
  let result = graph_color_edge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_view_fill(s : GraphcoloredgeView, v : Double) -> GraphcoloredgeView {
  let result = graph_color_edge_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_view_min(s : GraphcoloredgeView) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_view_max(s : GraphcoloredgeView) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_view_to_string(s : GraphcoloredgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_range_make(size : Int) -> GraphcoloredgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_range_len(s : GraphcoloredgeRange) -> Int { s.size }

pub fn graph_color_edge_range_get(s : GraphcoloredgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_range_set(s : GraphcoloredgeRange, i : Int, v : Double) -> GraphcoloredgeRange {
  let result = graph_color_edge_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_range_sum(s : GraphcoloredgeRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_range_mean(s : GraphcoloredgeRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_range_scale(s : GraphcoloredgeRange, f : Double) -> GraphcoloredgeRange {
  let result = graph_color_edge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_range_add(a : GraphcoloredgeRange, b : GraphcoloredgeRange) -> GraphcoloredgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_range_copy(s : GraphcoloredgeRange) -> GraphcoloredgeRange {
  let result = graph_color_edge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_range_fill(s : GraphcoloredgeRange, v : Double) -> GraphcoloredgeRange {
  let result = graph_color_edge_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_range_min(s : GraphcoloredgeRange) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_range_max(s : GraphcoloredgeRange) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_range_to_string(s : GraphcoloredgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_slice_make(size : Int) -> GraphcoloredgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_slice_len(s : GraphcoloredgeSlice) -> Int { s.size }

pub fn graph_color_edge_slice_get(s : GraphcoloredgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_slice_set(s : GraphcoloredgeSlice, i : Int, v : Double) -> GraphcoloredgeSlice {
  let result = graph_color_edge_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_slice_sum(s : GraphcoloredgeSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_slice_mean(s : GraphcoloredgeSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_slice_scale(s : GraphcoloredgeSlice, f : Double) -> GraphcoloredgeSlice {
  let result = graph_color_edge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_edge_slice_add(a : GraphcoloredgeSlice, b : GraphcoloredgeSlice) -> GraphcoloredgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_edge_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_edge_slice_copy(s : GraphcoloredgeSlice) -> GraphcoloredgeSlice {
  let result = graph_color_edge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_edge_slice_fill(s : GraphcoloredgeSlice, v : Double) -> GraphcoloredgeSlice {
  let result = graph_color_edge_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_edge_slice_min(s : GraphcoloredgeSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_slice_max(s : GraphcoloredgeSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_slice_to_string(s : GraphcoloredgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

