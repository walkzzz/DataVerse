///===
/// extcore/graph_connect_circuit

pub(all) struct GraphconnectcircuitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_circuit_make_point(x : Double, y : Double) -> GraphconnectcircuitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_circuit_make_point3(x : Double, y : Double, z : Double) -> GraphconnectcircuitPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_circuit_point_x(pt : GraphconnectcircuitPoint) -> Double { pt.x }

pub fn graph_connect_circuit_point_y(pt : GraphconnectcircuitPoint) -> Double { pt.y }

pub fn graph_connect_circuit_point_z(pt : GraphconnectcircuitPoint) -> Double { pt.z }

pub fn graph_connect_circuit_point_label(pt : GraphconnectcircuitPoint) -> Int { pt.label }

pub fn graph_connect_circuit_point_dist(a : GraphconnectcircuitPoint, b : GraphconnectcircuitPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_circuit_point_add(a : GraphconnectcircuitPoint, b : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_circuit_point_sub(a : GraphconnectcircuitPoint, b : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_circuit_point_scale(pt : GraphconnectcircuitPoint, s : Double) -> GraphconnectcircuitPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_circuit_point_dot(a : GraphconnectcircuitPoint, b : GraphconnectcircuitPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_circuit_point_cross(a : GraphconnectcircuitPoint, b : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_circuit_point_norm(pt : GraphconnectcircuitPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_circuit_point_normalize(pt : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  let n = graph_connect_circuit_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_circuit_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_circuit_point_negate(pt : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_circuit_point_mid(a : GraphconnectcircuitPoint, b : GraphconnectcircuitPoint) -> GraphconnectcircuitPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_circuit_point_lerp(a : GraphconnectcircuitPoint, b : GraphconnectcircuitPoint, t : Double) -> GraphconnectcircuitPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_circuit_point_to_string(pt : GraphconnectcircuitPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectcircuitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_circuit_make_series(vals : Array[Double], name : String) -> GraphconnectcircuitSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_circuit_series_len(s : GraphconnectcircuitSeries) -> Int { s.vals.length() }

pub fn graph_connect_circuit_series_sum(s : GraphconnectcircuitSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_connect_circuit_series_mean(s : GraphconnectcircuitSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_connect_circuit_series_min(s : GraphconnectcircuitSeries) -> Double { @_common.min(s.vals) }

pub fn graph_connect_circuit_series_max(s : GraphconnectcircuitSeries) -> Double { @_common.max(s.vals) }

pub fn graph_connect_circuit_series_range(s : GraphconnectcircuitSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_connect_circuit_series_var(s : GraphconnectcircuitSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_connect_circuit_series_std(s : GraphconnectcircuitSeries) -> Double { @_common.std(s.vals) }

pub fn graph_connect_circuit_series_median(s : GraphconnectcircuitSeries) -> Double { @_common.median(s.vals) }

pub fn graph_connect_circuit_series_scale(s : GraphconnectcircuitSeries, f : Double) -> GraphconnectcircuitSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_circuit_series_add(a : GraphconnectcircuitSeries, b : GraphconnectcircuitSeries) -> GraphconnectcircuitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_circuit_series_sub(a : GraphconnectcircuitSeries, b : GraphconnectcircuitSeries) -> GraphconnectcircuitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_circuit_series_normalize(s : GraphconnectcircuitSeries) -> GraphconnectcircuitSeries {
  let mn = graph_connect_circuit_series_min(s)
  let mx = graph_connect_circuit_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_circuit_series_cumsum(s : GraphconnectcircuitSeries) -> GraphconnectcircuitSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_circuit_series_to_string(s : GraphconnectcircuitSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectcircuitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_circuit_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectcircuitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_circuit_matrix_identity(n : Int) -> GraphconnectcircuitMatrix {
  let m = graph_connect_circuit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_circuit_matrix_get(m : GraphconnectcircuitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_circuit_matrix_transpose(m : GraphconnectcircuitMatrix) -> GraphconnectcircuitMatrix {
  let result = graph_connect_circuit_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_circuit_matrix_add(a : GraphconnectcircuitMatrix, b : GraphconnectcircuitMatrix) -> GraphconnectcircuitMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_circuit_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_circuit_matrix_scale(m : GraphconnectcircuitMatrix, s : Double) -> GraphconnectcircuitMatrix {
  let result = graph_connect_circuit_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_circuit_matrix_multiply(a : GraphconnectcircuitMatrix, b : GraphconnectcircuitMatrix) -> GraphconnectcircuitMatrix {
  if a.cols != b.rows { return graph_connect_circuit_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_circuit_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_circuit_matrix_trace(m : GraphconnectcircuitMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_circuit_matrix_det(m : GraphconnectcircuitMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_circuit_matrix_norm(m : GraphconnectcircuitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_circuit_matrix_to_string(m : GraphconnectcircuitMatrix) -> String {
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

pub(all) struct GraphconnectcircuitVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_circuit_make_vector(comps : Array[Double]) -> GraphconnectcircuitVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_circuit_vector_zero(dim : Int) -> GraphconnectcircuitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_circuit_vector_add(a : GraphconnectcircuitVector, b : GraphconnectcircuitVector) -> GraphconnectcircuitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_circuit_vector_sub(a : GraphconnectcircuitVector, b : GraphconnectcircuitVector) -> GraphconnectcircuitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_circuit_vector_scale(v : GraphconnectcircuitVector, s : Double) -> GraphconnectcircuitVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_circuit_vector_dot(a : GraphconnectcircuitVector, b : GraphconnectcircuitVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_circuit_vector_norm(v : GraphconnectcircuitVector) -> Double { @_common.sqrt(graph_connect_circuit_vector_dot(v, v)) }

pub fn graph_connect_circuit_vector_normalize(v : GraphconnectcircuitVector) -> GraphconnectcircuitVector {
  let n = graph_connect_circuit_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_circuit_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_circuit_vector_dist(a : GraphconnectcircuitVector, b : GraphconnectcircuitVector) -> Double {
  graph_connect_circuit_vector_norm(graph_connect_circuit_vector_sub(a, b))
}

pub fn graph_connect_circuit_vector_to_string(v : GraphconnectcircuitVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_circuit_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_circuit_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_circuit_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_circuit_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_circuit_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_circuit_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_circuit_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_circuit_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_circuit_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_circuit_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_circuit_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_circuit_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_circuit_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_circuit_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_circuit_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_circuit_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_circuit_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_circuit_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_circuit_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_circuit_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_circuit_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_circuit_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_circuit_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_circuit_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_circuit_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_circuit_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_circuit_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_circuit_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_circuit_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectcircuitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_frame_make(size : Int) -> GraphconnectcircuitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_frame_len(s : GraphconnectcircuitFrame) -> Int { s.size }

pub fn graph_connect_circuit_frame_get(s : GraphconnectcircuitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_frame_set(s : GraphconnectcircuitFrame, i : Int, v : Double) -> GraphconnectcircuitFrame {
  let result = graph_connect_circuit_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_frame_sum(s : GraphconnectcircuitFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_frame_mean(s : GraphconnectcircuitFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_frame_scale(s : GraphconnectcircuitFrame, f : Double) -> GraphconnectcircuitFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_frame_add(a : GraphconnectcircuitFrame, b : GraphconnectcircuitFrame) -> GraphconnectcircuitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_frame_copy(s : GraphconnectcircuitFrame) -> GraphconnectcircuitFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_frame_fill(s : GraphconnectcircuitFrame, v : Double) -> GraphconnectcircuitFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_frame_min(s : GraphconnectcircuitFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_frame_max(s : GraphconnectcircuitFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_frame_to_string(s : GraphconnectcircuitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_table_make(size : Int) -> GraphconnectcircuitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_table_len(s : GraphconnectcircuitTable) -> Int { s.size }

pub fn graph_connect_circuit_table_get(s : GraphconnectcircuitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_table_set(s : GraphconnectcircuitTable, i : Int, v : Double) -> GraphconnectcircuitTable {
  let result = graph_connect_circuit_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_table_sum(s : GraphconnectcircuitTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_table_mean(s : GraphconnectcircuitTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_table_scale(s : GraphconnectcircuitTable, f : Double) -> GraphconnectcircuitTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_table_add(a : GraphconnectcircuitTable, b : GraphconnectcircuitTable) -> GraphconnectcircuitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_table_copy(s : GraphconnectcircuitTable) -> GraphconnectcircuitTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_table_fill(s : GraphconnectcircuitTable, v : Double) -> GraphconnectcircuitTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_table_min(s : GraphconnectcircuitTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_table_max(s : GraphconnectcircuitTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_table_to_string(s : GraphconnectcircuitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_graphn_make(size : Int) -> GraphconnectcircuitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_graphn_len(s : GraphconnectcircuitGraphN) -> Int { s.size }

pub fn graph_connect_circuit_graphn_get(s : GraphconnectcircuitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_graphn_set(s : GraphconnectcircuitGraphN, i : Int, v : Double) -> GraphconnectcircuitGraphN {
  let result = graph_connect_circuit_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_graphn_sum(s : GraphconnectcircuitGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_graphn_mean(s : GraphconnectcircuitGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_graphn_scale(s : GraphconnectcircuitGraphN, f : Double) -> GraphconnectcircuitGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_graphn_add(a : GraphconnectcircuitGraphN, b : GraphconnectcircuitGraphN) -> GraphconnectcircuitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_graphn_copy(s : GraphconnectcircuitGraphN) -> GraphconnectcircuitGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_graphn_fill(s : GraphconnectcircuitGraphN, v : Double) -> GraphconnectcircuitGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_graphn_min(s : GraphconnectcircuitGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_graphn_max(s : GraphconnectcircuitGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_graphn_to_string(s : GraphconnectcircuitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_node_make(size : Int) -> GraphconnectcircuitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_node_len(s : GraphconnectcircuitNode) -> Int { s.size }

pub fn graph_connect_circuit_node_get(s : GraphconnectcircuitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_node_set(s : GraphconnectcircuitNode, i : Int, v : Double) -> GraphconnectcircuitNode {
  let result = graph_connect_circuit_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_node_sum(s : GraphconnectcircuitNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_node_mean(s : GraphconnectcircuitNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_node_scale(s : GraphconnectcircuitNode, f : Double) -> GraphconnectcircuitNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_node_add(a : GraphconnectcircuitNode, b : GraphconnectcircuitNode) -> GraphconnectcircuitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_node_copy(s : GraphconnectcircuitNode) -> GraphconnectcircuitNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_node_fill(s : GraphconnectcircuitNode, v : Double) -> GraphconnectcircuitNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_node_min(s : GraphconnectcircuitNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_node_max(s : GraphconnectcircuitNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_node_to_string(s : GraphconnectcircuitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_edge_make(size : Int) -> GraphconnectcircuitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_edge_len(s : GraphconnectcircuitEdge) -> Int { s.size }

pub fn graph_connect_circuit_edge_get(s : GraphconnectcircuitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_edge_set(s : GraphconnectcircuitEdge, i : Int, v : Double) -> GraphconnectcircuitEdge {
  let result = graph_connect_circuit_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_edge_sum(s : GraphconnectcircuitEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_edge_mean(s : GraphconnectcircuitEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_edge_scale(s : GraphconnectcircuitEdge, f : Double) -> GraphconnectcircuitEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_edge_add(a : GraphconnectcircuitEdge, b : GraphconnectcircuitEdge) -> GraphconnectcircuitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_edge_copy(s : GraphconnectcircuitEdge) -> GraphconnectcircuitEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_edge_fill(s : GraphconnectcircuitEdge, v : Double) -> GraphconnectcircuitEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_edge_min(s : GraphconnectcircuitEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_edge_max(s : GraphconnectcircuitEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_edge_to_string(s : GraphconnectcircuitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_path_make(size : Int) -> GraphconnectcircuitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_path_len(s : GraphconnectcircuitPath) -> Int { s.size }

pub fn graph_connect_circuit_path_get(s : GraphconnectcircuitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_path_set(s : GraphconnectcircuitPath, i : Int, v : Double) -> GraphconnectcircuitPath {
  let result = graph_connect_circuit_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_path_sum(s : GraphconnectcircuitPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_path_mean(s : GraphconnectcircuitPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_path_scale(s : GraphconnectcircuitPath, f : Double) -> GraphconnectcircuitPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_path_add(a : GraphconnectcircuitPath, b : GraphconnectcircuitPath) -> GraphconnectcircuitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_path_copy(s : GraphconnectcircuitPath) -> GraphconnectcircuitPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_path_fill(s : GraphconnectcircuitPath, v : Double) -> GraphconnectcircuitPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_path_min(s : GraphconnectcircuitPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_path_max(s : GraphconnectcircuitPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_path_to_string(s : GraphconnectcircuitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_cluster_make(size : Int) -> GraphconnectcircuitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_cluster_len(s : GraphconnectcircuitCluster) -> Int { s.size }

pub fn graph_connect_circuit_cluster_get(s : GraphconnectcircuitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_cluster_set(s : GraphconnectcircuitCluster, i : Int, v : Double) -> GraphconnectcircuitCluster {
  let result = graph_connect_circuit_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_cluster_sum(s : GraphconnectcircuitCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_cluster_mean(s : GraphconnectcircuitCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_cluster_scale(s : GraphconnectcircuitCluster, f : Double) -> GraphconnectcircuitCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cluster_add(a : GraphconnectcircuitCluster, b : GraphconnectcircuitCluster) -> GraphconnectcircuitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_cluster_copy(s : GraphconnectcircuitCluster) -> GraphconnectcircuitCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cluster_fill(s : GraphconnectcircuitCluster, v : Double) -> GraphconnectcircuitCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cluster_min(s : GraphconnectcircuitCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_cluster_max(s : GraphconnectcircuitCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_cluster_to_string(s : GraphconnectcircuitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_model_make(size : Int) -> GraphconnectcircuitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_model_len(s : GraphconnectcircuitModel) -> Int { s.size }

pub fn graph_connect_circuit_model_get(s : GraphconnectcircuitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_model_set(s : GraphconnectcircuitModel, i : Int, v : Double) -> GraphconnectcircuitModel {
  let result = graph_connect_circuit_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_model_sum(s : GraphconnectcircuitModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_model_mean(s : GraphconnectcircuitModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_model_scale(s : GraphconnectcircuitModel, f : Double) -> GraphconnectcircuitModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_model_add(a : GraphconnectcircuitModel, b : GraphconnectcircuitModel) -> GraphconnectcircuitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_model_copy(s : GraphconnectcircuitModel) -> GraphconnectcircuitModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_model_fill(s : GraphconnectcircuitModel, v : Double) -> GraphconnectcircuitModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_model_min(s : GraphconnectcircuitModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_model_max(s : GraphconnectcircuitModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_model_to_string(s : GraphconnectcircuitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_layer_make(size : Int) -> GraphconnectcircuitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_layer_len(s : GraphconnectcircuitLayer) -> Int { s.size }

pub fn graph_connect_circuit_layer_get(s : GraphconnectcircuitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_layer_set(s : GraphconnectcircuitLayer, i : Int, v : Double) -> GraphconnectcircuitLayer {
  let result = graph_connect_circuit_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_layer_sum(s : GraphconnectcircuitLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_layer_mean(s : GraphconnectcircuitLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_layer_scale(s : GraphconnectcircuitLayer, f : Double) -> GraphconnectcircuitLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_layer_add(a : GraphconnectcircuitLayer, b : GraphconnectcircuitLayer) -> GraphconnectcircuitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_layer_copy(s : GraphconnectcircuitLayer) -> GraphconnectcircuitLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_layer_fill(s : GraphconnectcircuitLayer, v : Double) -> GraphconnectcircuitLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_layer_min(s : GraphconnectcircuitLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_layer_max(s : GraphconnectcircuitLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_layer_to_string(s : GraphconnectcircuitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_buffer_make(size : Int) -> GraphconnectcircuitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_buffer_len(s : GraphconnectcircuitBuffer) -> Int { s.size }

pub fn graph_connect_circuit_buffer_get(s : GraphconnectcircuitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_buffer_set(s : GraphconnectcircuitBuffer, i : Int, v : Double) -> GraphconnectcircuitBuffer {
  let result = graph_connect_circuit_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_buffer_sum(s : GraphconnectcircuitBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_buffer_mean(s : GraphconnectcircuitBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_buffer_scale(s : GraphconnectcircuitBuffer, f : Double) -> GraphconnectcircuitBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_buffer_add(a : GraphconnectcircuitBuffer, b : GraphconnectcircuitBuffer) -> GraphconnectcircuitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_buffer_copy(s : GraphconnectcircuitBuffer) -> GraphconnectcircuitBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_buffer_fill(s : GraphconnectcircuitBuffer, v : Double) -> GraphconnectcircuitBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_buffer_min(s : GraphconnectcircuitBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_buffer_max(s : GraphconnectcircuitBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_buffer_to_string(s : GraphconnectcircuitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_cursor_make(size : Int) -> GraphconnectcircuitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_cursor_len(s : GraphconnectcircuitCursor) -> Int { s.size }

pub fn graph_connect_circuit_cursor_get(s : GraphconnectcircuitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_cursor_set(s : GraphconnectcircuitCursor, i : Int, v : Double) -> GraphconnectcircuitCursor {
  let result = graph_connect_circuit_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_cursor_sum(s : GraphconnectcircuitCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_cursor_mean(s : GraphconnectcircuitCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_cursor_scale(s : GraphconnectcircuitCursor, f : Double) -> GraphconnectcircuitCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cursor_add(a : GraphconnectcircuitCursor, b : GraphconnectcircuitCursor) -> GraphconnectcircuitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_cursor_copy(s : GraphconnectcircuitCursor) -> GraphconnectcircuitCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cursor_fill(s : GraphconnectcircuitCursor, v : Double) -> GraphconnectcircuitCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_cursor_min(s : GraphconnectcircuitCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_cursor_max(s : GraphconnectcircuitCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_cursor_to_string(s : GraphconnectcircuitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_view_make(size : Int) -> GraphconnectcircuitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_view_len(s : GraphconnectcircuitView) -> Int { s.size }

pub fn graph_connect_circuit_view_get(s : GraphconnectcircuitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_view_set(s : GraphconnectcircuitView, i : Int, v : Double) -> GraphconnectcircuitView {
  let result = graph_connect_circuit_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_view_sum(s : GraphconnectcircuitView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_view_mean(s : GraphconnectcircuitView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_view_scale(s : GraphconnectcircuitView, f : Double) -> GraphconnectcircuitView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_view_add(a : GraphconnectcircuitView, b : GraphconnectcircuitView) -> GraphconnectcircuitView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_view_copy(s : GraphconnectcircuitView) -> GraphconnectcircuitView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_view_fill(s : GraphconnectcircuitView, v : Double) -> GraphconnectcircuitView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_view_min(s : GraphconnectcircuitView) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_view_max(s : GraphconnectcircuitView) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_view_to_string(s : GraphconnectcircuitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_range_make(size : Int) -> GraphconnectcircuitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_range_len(s : GraphconnectcircuitRange) -> Int { s.size }

pub fn graph_connect_circuit_range_get(s : GraphconnectcircuitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_range_set(s : GraphconnectcircuitRange, i : Int, v : Double) -> GraphconnectcircuitRange {
  let result = graph_connect_circuit_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_range_sum(s : GraphconnectcircuitRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_range_mean(s : GraphconnectcircuitRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_range_scale(s : GraphconnectcircuitRange, f : Double) -> GraphconnectcircuitRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_range_add(a : GraphconnectcircuitRange, b : GraphconnectcircuitRange) -> GraphconnectcircuitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_range_copy(s : GraphconnectcircuitRange) -> GraphconnectcircuitRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_range_fill(s : GraphconnectcircuitRange, v : Double) -> GraphconnectcircuitRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_range_min(s : GraphconnectcircuitRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_range_max(s : GraphconnectcircuitRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_range_to_string(s : GraphconnectcircuitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcircuitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_circuit_slice_make(size : Int) -> GraphconnectcircuitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_circuit_slice_len(s : GraphconnectcircuitSlice) -> Int { s.size }

pub fn graph_connect_circuit_slice_get(s : GraphconnectcircuitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_circuit_slice_set(s : GraphconnectcircuitSlice, i : Int, v : Double) -> GraphconnectcircuitSlice {
  let result = graph_connect_circuit_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_circuit_slice_sum(s : GraphconnectcircuitSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_circuit_slice_mean(s : GraphconnectcircuitSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_circuit_slice_scale(s : GraphconnectcircuitSlice, f : Double) -> GraphconnectcircuitSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_slice_add(a : GraphconnectcircuitSlice, b : GraphconnectcircuitSlice) -> GraphconnectcircuitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_circuit_slice_copy(s : GraphconnectcircuitSlice) -> GraphconnectcircuitSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_slice_fill(s : GraphconnectcircuitSlice, v : Double) -> GraphconnectcircuitSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_circuit_slice_min(s : GraphconnectcircuitSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_circuit_slice_max(s : GraphconnectcircuitSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_circuit_slice_to_string(s : GraphconnectcircuitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

