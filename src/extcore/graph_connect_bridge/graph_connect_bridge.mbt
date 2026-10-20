///===
/// extcore/graph_connect_bridge

pub(all) struct GraphconnectbridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_bridge_make_point(x : Double, y : Double) -> GraphconnectbridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_bridge_make_point3(x : Double, y : Double, z : Double) -> GraphconnectbridgePoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_bridge_point_x(pt : GraphconnectbridgePoint) -> Double { pt.x }

pub fn graph_connect_bridge_point_y(pt : GraphconnectbridgePoint) -> Double { pt.y }

pub fn graph_connect_bridge_point_z(pt : GraphconnectbridgePoint) -> Double { pt.z }

pub fn graph_connect_bridge_point_label(pt : GraphconnectbridgePoint) -> Int { pt.label }

pub fn graph_connect_bridge_point_dist(a : GraphconnectbridgePoint, b : GraphconnectbridgePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_bridge_point_add(a : GraphconnectbridgePoint, b : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_bridge_point_sub(a : GraphconnectbridgePoint, b : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_bridge_point_scale(pt : GraphconnectbridgePoint, s : Double) -> GraphconnectbridgePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_bridge_point_dot(a : GraphconnectbridgePoint, b : GraphconnectbridgePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_bridge_point_cross(a : GraphconnectbridgePoint, b : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_bridge_point_norm(pt : GraphconnectbridgePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_bridge_point_normalize(pt : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  let n = graph_connect_bridge_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_bridge_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_bridge_point_negate(pt : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_bridge_point_mid(a : GraphconnectbridgePoint, b : GraphconnectbridgePoint) -> GraphconnectbridgePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_bridge_point_lerp(a : GraphconnectbridgePoint, b : GraphconnectbridgePoint, t : Double) -> GraphconnectbridgePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_bridge_point_to_string(pt : GraphconnectbridgePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectbridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_bridge_make_series(vals : Array[Double], name : String) -> GraphconnectbridgeSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_bridge_series_len(s : GraphconnectbridgeSeries) -> Int { s.vals.length() }

pub fn graph_connect_bridge_series_sum(s : GraphconnectbridgeSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_connect_bridge_series_mean(s : GraphconnectbridgeSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_connect_bridge_series_min(s : GraphconnectbridgeSeries) -> Double { @_common.min(s.vals) }

pub fn graph_connect_bridge_series_max(s : GraphconnectbridgeSeries) -> Double { @_common.max(s.vals) }

pub fn graph_connect_bridge_series_range(s : GraphconnectbridgeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_connect_bridge_series_var(s : GraphconnectbridgeSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_connect_bridge_series_std(s : GraphconnectbridgeSeries) -> Double { @_common.std(s.vals) }

pub fn graph_connect_bridge_series_median(s : GraphconnectbridgeSeries) -> Double { @_common.median(s.vals) }

pub fn graph_connect_bridge_series_scale(s : GraphconnectbridgeSeries, f : Double) -> GraphconnectbridgeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_bridge_series_add(a : GraphconnectbridgeSeries, b : GraphconnectbridgeSeries) -> GraphconnectbridgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_bridge_series_sub(a : GraphconnectbridgeSeries, b : GraphconnectbridgeSeries) -> GraphconnectbridgeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_bridge_series_normalize(s : GraphconnectbridgeSeries) -> GraphconnectbridgeSeries {
  let mn = graph_connect_bridge_series_min(s)
  let mx = graph_connect_bridge_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_bridge_series_cumsum(s : GraphconnectbridgeSeries) -> GraphconnectbridgeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_bridge_series_to_string(s : GraphconnectbridgeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectbridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_bridge_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectbridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_bridge_matrix_identity(n : Int) -> GraphconnectbridgeMatrix {
  let m = graph_connect_bridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_bridge_matrix_get(m : GraphconnectbridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_bridge_matrix_transpose(m : GraphconnectbridgeMatrix) -> GraphconnectbridgeMatrix {
  let result = graph_connect_bridge_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_bridge_matrix_add(a : GraphconnectbridgeMatrix, b : GraphconnectbridgeMatrix) -> GraphconnectbridgeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_bridge_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_bridge_matrix_scale(m : GraphconnectbridgeMatrix, s : Double) -> GraphconnectbridgeMatrix {
  let result = graph_connect_bridge_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_bridge_matrix_multiply(a : GraphconnectbridgeMatrix, b : GraphconnectbridgeMatrix) -> GraphconnectbridgeMatrix {
  if a.cols != b.rows { return graph_connect_bridge_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_bridge_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_bridge_matrix_trace(m : GraphconnectbridgeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_bridge_matrix_det(m : GraphconnectbridgeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_bridge_matrix_norm(m : GraphconnectbridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_bridge_matrix_to_string(m : GraphconnectbridgeMatrix) -> String {
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

pub(all) struct GraphconnectbridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_bridge_make_vector(comps : Array[Double]) -> GraphconnectbridgeVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_bridge_vector_zero(dim : Int) -> GraphconnectbridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_bridge_vector_add(a : GraphconnectbridgeVector, b : GraphconnectbridgeVector) -> GraphconnectbridgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_bridge_vector_sub(a : GraphconnectbridgeVector, b : GraphconnectbridgeVector) -> GraphconnectbridgeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_bridge_vector_scale(v : GraphconnectbridgeVector, s : Double) -> GraphconnectbridgeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_bridge_vector_dot(a : GraphconnectbridgeVector, b : GraphconnectbridgeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_bridge_vector_norm(v : GraphconnectbridgeVector) -> Double { @_common.sqrt(graph_connect_bridge_vector_dot(v, v)) }

pub fn graph_connect_bridge_vector_normalize(v : GraphconnectbridgeVector) -> GraphconnectbridgeVector {
  let n = graph_connect_bridge_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_bridge_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_bridge_vector_dist(a : GraphconnectbridgeVector, b : GraphconnectbridgeVector) -> Double {
  graph_connect_bridge_vector_norm(graph_connect_bridge_vector_sub(a, b))
}

pub fn graph_connect_bridge_vector_to_string(v : GraphconnectbridgeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_bridge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_bridge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_bridge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_bridge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_bridge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_bridge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_bridge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_bridge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_bridge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_bridge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_bridge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_bridge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_bridge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_bridge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_bridge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_bridge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_bridge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_bridge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_bridge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_bridge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_bridge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_bridge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_bridge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_bridge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_bridge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_bridge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_bridge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_bridge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_bridge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectbridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_frame_make(size : Int) -> GraphconnectbridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_frame_len(s : GraphconnectbridgeFrame) -> Int { s.size }

pub fn graph_connect_bridge_frame_get(s : GraphconnectbridgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_frame_set(s : GraphconnectbridgeFrame, i : Int, v : Double) -> GraphconnectbridgeFrame {
  let result = graph_connect_bridge_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_frame_sum(s : GraphconnectbridgeFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_frame_mean(s : GraphconnectbridgeFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_frame_scale(s : GraphconnectbridgeFrame, f : Double) -> GraphconnectbridgeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_frame_add(a : GraphconnectbridgeFrame, b : GraphconnectbridgeFrame) -> GraphconnectbridgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_frame_copy(s : GraphconnectbridgeFrame) -> GraphconnectbridgeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_frame_fill(s : GraphconnectbridgeFrame, v : Double) -> GraphconnectbridgeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_frame_min(s : GraphconnectbridgeFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_frame_max(s : GraphconnectbridgeFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_frame_to_string(s : GraphconnectbridgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_table_make(size : Int) -> GraphconnectbridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_table_len(s : GraphconnectbridgeTable) -> Int { s.size }

pub fn graph_connect_bridge_table_get(s : GraphconnectbridgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_table_set(s : GraphconnectbridgeTable, i : Int, v : Double) -> GraphconnectbridgeTable {
  let result = graph_connect_bridge_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_table_sum(s : GraphconnectbridgeTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_table_mean(s : GraphconnectbridgeTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_table_scale(s : GraphconnectbridgeTable, f : Double) -> GraphconnectbridgeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_table_add(a : GraphconnectbridgeTable, b : GraphconnectbridgeTable) -> GraphconnectbridgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_table_copy(s : GraphconnectbridgeTable) -> GraphconnectbridgeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_table_fill(s : GraphconnectbridgeTable, v : Double) -> GraphconnectbridgeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_table_min(s : GraphconnectbridgeTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_table_max(s : GraphconnectbridgeTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_table_to_string(s : GraphconnectbridgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_graphn_make(size : Int) -> GraphconnectbridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_graphn_len(s : GraphconnectbridgeGraphN) -> Int { s.size }

pub fn graph_connect_bridge_graphn_get(s : GraphconnectbridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_graphn_set(s : GraphconnectbridgeGraphN, i : Int, v : Double) -> GraphconnectbridgeGraphN {
  let result = graph_connect_bridge_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_graphn_sum(s : GraphconnectbridgeGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_graphn_mean(s : GraphconnectbridgeGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_graphn_scale(s : GraphconnectbridgeGraphN, f : Double) -> GraphconnectbridgeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_graphn_add(a : GraphconnectbridgeGraphN, b : GraphconnectbridgeGraphN) -> GraphconnectbridgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_graphn_copy(s : GraphconnectbridgeGraphN) -> GraphconnectbridgeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_graphn_fill(s : GraphconnectbridgeGraphN, v : Double) -> GraphconnectbridgeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_graphn_min(s : GraphconnectbridgeGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_graphn_max(s : GraphconnectbridgeGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_graphn_to_string(s : GraphconnectbridgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_node_make(size : Int) -> GraphconnectbridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_node_len(s : GraphconnectbridgeNode) -> Int { s.size }

pub fn graph_connect_bridge_node_get(s : GraphconnectbridgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_node_set(s : GraphconnectbridgeNode, i : Int, v : Double) -> GraphconnectbridgeNode {
  let result = graph_connect_bridge_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_node_sum(s : GraphconnectbridgeNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_node_mean(s : GraphconnectbridgeNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_node_scale(s : GraphconnectbridgeNode, f : Double) -> GraphconnectbridgeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_node_add(a : GraphconnectbridgeNode, b : GraphconnectbridgeNode) -> GraphconnectbridgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_node_copy(s : GraphconnectbridgeNode) -> GraphconnectbridgeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_node_fill(s : GraphconnectbridgeNode, v : Double) -> GraphconnectbridgeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_node_min(s : GraphconnectbridgeNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_node_max(s : GraphconnectbridgeNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_node_to_string(s : GraphconnectbridgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_edge_make(size : Int) -> GraphconnectbridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_edge_len(s : GraphconnectbridgeEdge) -> Int { s.size }

pub fn graph_connect_bridge_edge_get(s : GraphconnectbridgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_edge_set(s : GraphconnectbridgeEdge, i : Int, v : Double) -> GraphconnectbridgeEdge {
  let result = graph_connect_bridge_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_edge_sum(s : GraphconnectbridgeEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_edge_mean(s : GraphconnectbridgeEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_edge_scale(s : GraphconnectbridgeEdge, f : Double) -> GraphconnectbridgeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_edge_add(a : GraphconnectbridgeEdge, b : GraphconnectbridgeEdge) -> GraphconnectbridgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_edge_copy(s : GraphconnectbridgeEdge) -> GraphconnectbridgeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_edge_fill(s : GraphconnectbridgeEdge, v : Double) -> GraphconnectbridgeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_edge_min(s : GraphconnectbridgeEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_edge_max(s : GraphconnectbridgeEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_edge_to_string(s : GraphconnectbridgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_path_make(size : Int) -> GraphconnectbridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_path_len(s : GraphconnectbridgePath) -> Int { s.size }

pub fn graph_connect_bridge_path_get(s : GraphconnectbridgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_path_set(s : GraphconnectbridgePath, i : Int, v : Double) -> GraphconnectbridgePath {
  let result = graph_connect_bridge_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_path_sum(s : GraphconnectbridgePath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_path_mean(s : GraphconnectbridgePath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_path_scale(s : GraphconnectbridgePath, f : Double) -> GraphconnectbridgePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_path_add(a : GraphconnectbridgePath, b : GraphconnectbridgePath) -> GraphconnectbridgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_path_copy(s : GraphconnectbridgePath) -> GraphconnectbridgePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_path_fill(s : GraphconnectbridgePath, v : Double) -> GraphconnectbridgePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_path_min(s : GraphconnectbridgePath) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_path_max(s : GraphconnectbridgePath) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_path_to_string(s : GraphconnectbridgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_cluster_make(size : Int) -> GraphconnectbridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_cluster_len(s : GraphconnectbridgeCluster) -> Int { s.size }

pub fn graph_connect_bridge_cluster_get(s : GraphconnectbridgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_cluster_set(s : GraphconnectbridgeCluster, i : Int, v : Double) -> GraphconnectbridgeCluster {
  let result = graph_connect_bridge_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_cluster_sum(s : GraphconnectbridgeCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_cluster_mean(s : GraphconnectbridgeCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_cluster_scale(s : GraphconnectbridgeCluster, f : Double) -> GraphconnectbridgeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cluster_add(a : GraphconnectbridgeCluster, b : GraphconnectbridgeCluster) -> GraphconnectbridgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_cluster_copy(s : GraphconnectbridgeCluster) -> GraphconnectbridgeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cluster_fill(s : GraphconnectbridgeCluster, v : Double) -> GraphconnectbridgeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cluster_min(s : GraphconnectbridgeCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_cluster_max(s : GraphconnectbridgeCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_cluster_to_string(s : GraphconnectbridgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_model_make(size : Int) -> GraphconnectbridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_model_len(s : GraphconnectbridgeModel) -> Int { s.size }

pub fn graph_connect_bridge_model_get(s : GraphconnectbridgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_model_set(s : GraphconnectbridgeModel, i : Int, v : Double) -> GraphconnectbridgeModel {
  let result = graph_connect_bridge_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_model_sum(s : GraphconnectbridgeModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_model_mean(s : GraphconnectbridgeModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_model_scale(s : GraphconnectbridgeModel, f : Double) -> GraphconnectbridgeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_model_add(a : GraphconnectbridgeModel, b : GraphconnectbridgeModel) -> GraphconnectbridgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_model_copy(s : GraphconnectbridgeModel) -> GraphconnectbridgeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_model_fill(s : GraphconnectbridgeModel, v : Double) -> GraphconnectbridgeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_model_min(s : GraphconnectbridgeModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_model_max(s : GraphconnectbridgeModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_model_to_string(s : GraphconnectbridgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_layer_make(size : Int) -> GraphconnectbridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_layer_len(s : GraphconnectbridgeLayer) -> Int { s.size }

pub fn graph_connect_bridge_layer_get(s : GraphconnectbridgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_layer_set(s : GraphconnectbridgeLayer, i : Int, v : Double) -> GraphconnectbridgeLayer {
  let result = graph_connect_bridge_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_layer_sum(s : GraphconnectbridgeLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_layer_mean(s : GraphconnectbridgeLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_layer_scale(s : GraphconnectbridgeLayer, f : Double) -> GraphconnectbridgeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_layer_add(a : GraphconnectbridgeLayer, b : GraphconnectbridgeLayer) -> GraphconnectbridgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_layer_copy(s : GraphconnectbridgeLayer) -> GraphconnectbridgeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_layer_fill(s : GraphconnectbridgeLayer, v : Double) -> GraphconnectbridgeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_layer_min(s : GraphconnectbridgeLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_layer_max(s : GraphconnectbridgeLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_layer_to_string(s : GraphconnectbridgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_buffer_make(size : Int) -> GraphconnectbridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_buffer_len(s : GraphconnectbridgeBuffer) -> Int { s.size }

pub fn graph_connect_bridge_buffer_get(s : GraphconnectbridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_buffer_set(s : GraphconnectbridgeBuffer, i : Int, v : Double) -> GraphconnectbridgeBuffer {
  let result = graph_connect_bridge_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_buffer_sum(s : GraphconnectbridgeBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_buffer_mean(s : GraphconnectbridgeBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_buffer_scale(s : GraphconnectbridgeBuffer, f : Double) -> GraphconnectbridgeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_buffer_add(a : GraphconnectbridgeBuffer, b : GraphconnectbridgeBuffer) -> GraphconnectbridgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_buffer_copy(s : GraphconnectbridgeBuffer) -> GraphconnectbridgeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_buffer_fill(s : GraphconnectbridgeBuffer, v : Double) -> GraphconnectbridgeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_buffer_min(s : GraphconnectbridgeBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_buffer_max(s : GraphconnectbridgeBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_buffer_to_string(s : GraphconnectbridgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_cursor_make(size : Int) -> GraphconnectbridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_cursor_len(s : GraphconnectbridgeCursor) -> Int { s.size }

pub fn graph_connect_bridge_cursor_get(s : GraphconnectbridgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_cursor_set(s : GraphconnectbridgeCursor, i : Int, v : Double) -> GraphconnectbridgeCursor {
  let result = graph_connect_bridge_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_cursor_sum(s : GraphconnectbridgeCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_cursor_mean(s : GraphconnectbridgeCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_cursor_scale(s : GraphconnectbridgeCursor, f : Double) -> GraphconnectbridgeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cursor_add(a : GraphconnectbridgeCursor, b : GraphconnectbridgeCursor) -> GraphconnectbridgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_cursor_copy(s : GraphconnectbridgeCursor) -> GraphconnectbridgeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cursor_fill(s : GraphconnectbridgeCursor, v : Double) -> GraphconnectbridgeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_cursor_min(s : GraphconnectbridgeCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_cursor_max(s : GraphconnectbridgeCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_cursor_to_string(s : GraphconnectbridgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_view_make(size : Int) -> GraphconnectbridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_view_len(s : GraphconnectbridgeView) -> Int { s.size }

pub fn graph_connect_bridge_view_get(s : GraphconnectbridgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_view_set(s : GraphconnectbridgeView, i : Int, v : Double) -> GraphconnectbridgeView {
  let result = graph_connect_bridge_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_view_sum(s : GraphconnectbridgeView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_view_mean(s : GraphconnectbridgeView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_view_scale(s : GraphconnectbridgeView, f : Double) -> GraphconnectbridgeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_view_add(a : GraphconnectbridgeView, b : GraphconnectbridgeView) -> GraphconnectbridgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_view_copy(s : GraphconnectbridgeView) -> GraphconnectbridgeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_view_fill(s : GraphconnectbridgeView, v : Double) -> GraphconnectbridgeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_view_min(s : GraphconnectbridgeView) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_view_max(s : GraphconnectbridgeView) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_view_to_string(s : GraphconnectbridgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_range_make(size : Int) -> GraphconnectbridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_range_len(s : GraphconnectbridgeRange) -> Int { s.size }

pub fn graph_connect_bridge_range_get(s : GraphconnectbridgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_range_set(s : GraphconnectbridgeRange, i : Int, v : Double) -> GraphconnectbridgeRange {
  let result = graph_connect_bridge_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_range_sum(s : GraphconnectbridgeRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_range_mean(s : GraphconnectbridgeRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_range_scale(s : GraphconnectbridgeRange, f : Double) -> GraphconnectbridgeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_range_add(a : GraphconnectbridgeRange, b : GraphconnectbridgeRange) -> GraphconnectbridgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_range_copy(s : GraphconnectbridgeRange) -> GraphconnectbridgeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_range_fill(s : GraphconnectbridgeRange, v : Double) -> GraphconnectbridgeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_range_min(s : GraphconnectbridgeRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_range_max(s : GraphconnectbridgeRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_range_to_string(s : GraphconnectbridgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_bridge_slice_make(size : Int) -> GraphconnectbridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_bridge_slice_len(s : GraphconnectbridgeSlice) -> Int { s.size }

pub fn graph_connect_bridge_slice_get(s : GraphconnectbridgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_bridge_slice_set(s : GraphconnectbridgeSlice, i : Int, v : Double) -> GraphconnectbridgeSlice {
  let result = graph_connect_bridge_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_bridge_slice_sum(s : GraphconnectbridgeSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_bridge_slice_mean(s : GraphconnectbridgeSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_bridge_slice_scale(s : GraphconnectbridgeSlice, f : Double) -> GraphconnectbridgeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_slice_add(a : GraphconnectbridgeSlice, b : GraphconnectbridgeSlice) -> GraphconnectbridgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_bridge_slice_copy(s : GraphconnectbridgeSlice) -> GraphconnectbridgeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_slice_fill(s : GraphconnectbridgeSlice, v : Double) -> GraphconnectbridgeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_bridge_slice_min(s : GraphconnectbridgeSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_bridge_slice_max(s : GraphconnectbridgeSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_bridge_slice_to_string(s : GraphconnectbridgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

