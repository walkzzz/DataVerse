///===
/// extcore/graph_flow_assignment

pub(all) struct GraphflowassignmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_assignment_make_point(x : Double, y : Double) -> GraphflowassignmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_assignment_make_point3(x : Double, y : Double, z : Double) -> GraphflowassignmentPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_assignment_point_x(pt : GraphflowassignmentPoint) -> Double { pt.x }

pub fn graph_flow_assignment_point_y(pt : GraphflowassignmentPoint) -> Double { pt.y }

pub fn graph_flow_assignment_point_z(pt : GraphflowassignmentPoint) -> Double { pt.z }

pub fn graph_flow_assignment_point_label(pt : GraphflowassignmentPoint) -> Int { pt.label }

pub fn graph_flow_assignment_point_dist(a : GraphflowassignmentPoint, b : GraphflowassignmentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_assignment_point_add(a : GraphflowassignmentPoint, b : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_assignment_point_sub(a : GraphflowassignmentPoint, b : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_assignment_point_scale(pt : GraphflowassignmentPoint, s : Double) -> GraphflowassignmentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_assignment_point_dot(a : GraphflowassignmentPoint, b : GraphflowassignmentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_assignment_point_cross(a : GraphflowassignmentPoint, b : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_assignment_point_norm(pt : GraphflowassignmentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_assignment_point_normalize(pt : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  let n = graph_flow_assignment_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_assignment_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_assignment_point_negate(pt : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_assignment_point_mid(a : GraphflowassignmentPoint, b : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_assignment_point_lerp(a : GraphflowassignmentPoint, b : GraphflowassignmentPoint, t : Double) -> GraphflowassignmentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_assignment_point_to_string(pt : GraphflowassignmentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowassignmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_assignment_make_series(vals : Array[Double], name : String) -> GraphflowassignmentSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_assignment_series_len(s : GraphflowassignmentSeries) -> Int { s.vals.length() }

pub fn graph_flow_assignment_series_sum(s : GraphflowassignmentSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_flow_assignment_series_mean(s : GraphflowassignmentSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_flow_assignment_series_min(s : GraphflowassignmentSeries) -> Double { @_common.min(s.vals) }

pub fn graph_flow_assignment_series_max(s : GraphflowassignmentSeries) -> Double { @_common.max(s.vals) }

pub fn graph_flow_assignment_series_range(s : GraphflowassignmentSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_flow_assignment_series_var(s : GraphflowassignmentSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_flow_assignment_series_std(s : GraphflowassignmentSeries) -> Double { @_common.std(s.vals) }

pub fn graph_flow_assignment_series_median(s : GraphflowassignmentSeries) -> Double { @_common.median(s.vals) }

pub fn graph_flow_assignment_series_scale(s : GraphflowassignmentSeries, f : Double) -> GraphflowassignmentSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_assignment_series_add(a : GraphflowassignmentSeries, b : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_assignment_series_sub(a : GraphflowassignmentSeries, b : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_assignment_series_normalize(s : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  let mn = graph_flow_assignment_series_min(s)
  let mx = graph_flow_assignment_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_assignment_series_cumsum(s : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_assignment_series_to_string(s : GraphflowassignmentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowassignmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_assignment_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowassignmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_assignment_matrix_identity(n : Int) -> GraphflowassignmentMatrix {
  let m = graph_flow_assignment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_assignment_matrix_get(m : GraphflowassignmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_assignment_matrix_transpose(m : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  let result = graph_flow_assignment_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_assignment_matrix_add(a : GraphflowassignmentMatrix, b : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_assignment_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_assignment_matrix_scale(m : GraphflowassignmentMatrix, s : Double) -> GraphflowassignmentMatrix {
  let result = graph_flow_assignment_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_assignment_matrix_multiply(a : GraphflowassignmentMatrix, b : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  if a.cols != b.rows { return graph_flow_assignment_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_assignment_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_assignment_matrix_trace(m : GraphflowassignmentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_assignment_matrix_det(m : GraphflowassignmentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_assignment_matrix_norm(m : GraphflowassignmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_flow_assignment_matrix_to_string(m : GraphflowassignmentMatrix) -> String {
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

pub(all) struct GraphflowassignmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_assignment_make_vector(comps : Array[Double]) -> GraphflowassignmentVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_assignment_vector_zero(dim : Int) -> GraphflowassignmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_assignment_vector_add(a : GraphflowassignmentVector, b : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_assignment_vector_sub(a : GraphflowassignmentVector, b : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_assignment_vector_scale(v : GraphflowassignmentVector, s : Double) -> GraphflowassignmentVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_assignment_vector_dot(a : GraphflowassignmentVector, b : GraphflowassignmentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_assignment_vector_norm(v : GraphflowassignmentVector) -> Double { @_common.sqrt(graph_flow_assignment_vector_dot(v, v)) }

pub fn graph_flow_assignment_vector_normalize(v : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = graph_flow_assignment_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_assignment_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_assignment_vector_dist(a : GraphflowassignmentVector, b : GraphflowassignmentVector) -> Double {
  graph_flow_assignment_vector_norm(graph_flow_assignment_vector_sub(a, b))
}

pub fn graph_flow_assignment_vector_to_string(v : GraphflowassignmentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_assignment_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_assignment_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_assignment_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_assignment_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_assignment_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_assignment_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_assignment_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_assignment_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_assignment_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_assignment_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_assignment_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_assignment_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_assignment_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_assignment_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_assignment_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_assignment_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_assignment_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_assignment_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_assignment_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_assignment_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_assignment_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_assignment_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_assignment_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_assignment_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_assignment_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_assignment_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_assignment_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_assignment_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_assignment_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowassignmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_frame_make(size : Int) -> GraphflowassignmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_frame_len(s : GraphflowassignmentFrame) -> Int { s.size }

pub fn graph_flow_assignment_frame_get(s : GraphflowassignmentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_frame_set(s : GraphflowassignmentFrame, i : Int, v : Double) -> GraphflowassignmentFrame {
  let result = graph_flow_assignment_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_frame_sum(s : GraphflowassignmentFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_frame_mean(s : GraphflowassignmentFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_frame_scale(s : GraphflowassignmentFrame, f : Double) -> GraphflowassignmentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_frame_add(a : GraphflowassignmentFrame, b : GraphflowassignmentFrame) -> GraphflowassignmentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_frame_copy(s : GraphflowassignmentFrame) -> GraphflowassignmentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_frame_fill(s : GraphflowassignmentFrame, v : Double) -> GraphflowassignmentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_frame_min(s : GraphflowassignmentFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_frame_max(s : GraphflowassignmentFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_frame_to_string(s : GraphflowassignmentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_table_make(size : Int) -> GraphflowassignmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_table_len(s : GraphflowassignmentTable) -> Int { s.size }

pub fn graph_flow_assignment_table_get(s : GraphflowassignmentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_table_set(s : GraphflowassignmentTable, i : Int, v : Double) -> GraphflowassignmentTable {
  let result = graph_flow_assignment_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_table_sum(s : GraphflowassignmentTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_table_mean(s : GraphflowassignmentTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_table_scale(s : GraphflowassignmentTable, f : Double) -> GraphflowassignmentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_table_add(a : GraphflowassignmentTable, b : GraphflowassignmentTable) -> GraphflowassignmentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_table_copy(s : GraphflowassignmentTable) -> GraphflowassignmentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_table_fill(s : GraphflowassignmentTable, v : Double) -> GraphflowassignmentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_table_min(s : GraphflowassignmentTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_table_max(s : GraphflowassignmentTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_table_to_string(s : GraphflowassignmentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_graphn_make(size : Int) -> GraphflowassignmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_graphn_len(s : GraphflowassignmentGraphN) -> Int { s.size }

pub fn graph_flow_assignment_graphn_get(s : GraphflowassignmentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_graphn_set(s : GraphflowassignmentGraphN, i : Int, v : Double) -> GraphflowassignmentGraphN {
  let result = graph_flow_assignment_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_graphn_sum(s : GraphflowassignmentGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_graphn_mean(s : GraphflowassignmentGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_graphn_scale(s : GraphflowassignmentGraphN, f : Double) -> GraphflowassignmentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_graphn_add(a : GraphflowassignmentGraphN, b : GraphflowassignmentGraphN) -> GraphflowassignmentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_graphn_copy(s : GraphflowassignmentGraphN) -> GraphflowassignmentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_graphn_fill(s : GraphflowassignmentGraphN, v : Double) -> GraphflowassignmentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_graphn_min(s : GraphflowassignmentGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_graphn_max(s : GraphflowassignmentGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_graphn_to_string(s : GraphflowassignmentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_node_make(size : Int) -> GraphflowassignmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_node_len(s : GraphflowassignmentNode) -> Int { s.size }

pub fn graph_flow_assignment_node_get(s : GraphflowassignmentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_node_set(s : GraphflowassignmentNode, i : Int, v : Double) -> GraphflowassignmentNode {
  let result = graph_flow_assignment_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_node_sum(s : GraphflowassignmentNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_node_mean(s : GraphflowassignmentNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_node_scale(s : GraphflowassignmentNode, f : Double) -> GraphflowassignmentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_node_add(a : GraphflowassignmentNode, b : GraphflowassignmentNode) -> GraphflowassignmentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_node_copy(s : GraphflowassignmentNode) -> GraphflowassignmentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_node_fill(s : GraphflowassignmentNode, v : Double) -> GraphflowassignmentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_node_min(s : GraphflowassignmentNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_node_max(s : GraphflowassignmentNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_node_to_string(s : GraphflowassignmentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_edge_make(size : Int) -> GraphflowassignmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_edge_len(s : GraphflowassignmentEdge) -> Int { s.size }

pub fn graph_flow_assignment_edge_get(s : GraphflowassignmentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_edge_set(s : GraphflowassignmentEdge, i : Int, v : Double) -> GraphflowassignmentEdge {
  let result = graph_flow_assignment_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_edge_sum(s : GraphflowassignmentEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_edge_mean(s : GraphflowassignmentEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_edge_scale(s : GraphflowassignmentEdge, f : Double) -> GraphflowassignmentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_edge_add(a : GraphflowassignmentEdge, b : GraphflowassignmentEdge) -> GraphflowassignmentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_edge_copy(s : GraphflowassignmentEdge) -> GraphflowassignmentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_edge_fill(s : GraphflowassignmentEdge, v : Double) -> GraphflowassignmentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_edge_min(s : GraphflowassignmentEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_edge_max(s : GraphflowassignmentEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_edge_to_string(s : GraphflowassignmentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_path_make(size : Int) -> GraphflowassignmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_path_len(s : GraphflowassignmentPath) -> Int { s.size }

pub fn graph_flow_assignment_path_get(s : GraphflowassignmentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_path_set(s : GraphflowassignmentPath, i : Int, v : Double) -> GraphflowassignmentPath {
  let result = graph_flow_assignment_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_path_sum(s : GraphflowassignmentPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_path_mean(s : GraphflowassignmentPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_path_scale(s : GraphflowassignmentPath, f : Double) -> GraphflowassignmentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_path_add(a : GraphflowassignmentPath, b : GraphflowassignmentPath) -> GraphflowassignmentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_path_copy(s : GraphflowassignmentPath) -> GraphflowassignmentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_path_fill(s : GraphflowassignmentPath, v : Double) -> GraphflowassignmentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_path_min(s : GraphflowassignmentPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_path_max(s : GraphflowassignmentPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_path_to_string(s : GraphflowassignmentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_cluster_make(size : Int) -> GraphflowassignmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_cluster_len(s : GraphflowassignmentCluster) -> Int { s.size }

pub fn graph_flow_assignment_cluster_get(s : GraphflowassignmentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_cluster_set(s : GraphflowassignmentCluster, i : Int, v : Double) -> GraphflowassignmentCluster {
  let result = graph_flow_assignment_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_cluster_sum(s : GraphflowassignmentCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_cluster_mean(s : GraphflowassignmentCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_cluster_scale(s : GraphflowassignmentCluster, f : Double) -> GraphflowassignmentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cluster_add(a : GraphflowassignmentCluster, b : GraphflowassignmentCluster) -> GraphflowassignmentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_cluster_copy(s : GraphflowassignmentCluster) -> GraphflowassignmentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cluster_fill(s : GraphflowassignmentCluster, v : Double) -> GraphflowassignmentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cluster_min(s : GraphflowassignmentCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_cluster_max(s : GraphflowassignmentCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_cluster_to_string(s : GraphflowassignmentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_model_make(size : Int) -> GraphflowassignmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_model_len(s : GraphflowassignmentModel) -> Int { s.size }

pub fn graph_flow_assignment_model_get(s : GraphflowassignmentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_model_set(s : GraphflowassignmentModel, i : Int, v : Double) -> GraphflowassignmentModel {
  let result = graph_flow_assignment_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_model_sum(s : GraphflowassignmentModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_model_mean(s : GraphflowassignmentModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_model_scale(s : GraphflowassignmentModel, f : Double) -> GraphflowassignmentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_model_add(a : GraphflowassignmentModel, b : GraphflowassignmentModel) -> GraphflowassignmentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_model_copy(s : GraphflowassignmentModel) -> GraphflowassignmentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_model_fill(s : GraphflowassignmentModel, v : Double) -> GraphflowassignmentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_model_min(s : GraphflowassignmentModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_model_max(s : GraphflowassignmentModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_model_to_string(s : GraphflowassignmentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_layer_make(size : Int) -> GraphflowassignmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_layer_len(s : GraphflowassignmentLayer) -> Int { s.size }

pub fn graph_flow_assignment_layer_get(s : GraphflowassignmentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_layer_set(s : GraphflowassignmentLayer, i : Int, v : Double) -> GraphflowassignmentLayer {
  let result = graph_flow_assignment_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_layer_sum(s : GraphflowassignmentLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_layer_mean(s : GraphflowassignmentLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_layer_scale(s : GraphflowassignmentLayer, f : Double) -> GraphflowassignmentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_layer_add(a : GraphflowassignmentLayer, b : GraphflowassignmentLayer) -> GraphflowassignmentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_layer_copy(s : GraphflowassignmentLayer) -> GraphflowassignmentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_layer_fill(s : GraphflowassignmentLayer, v : Double) -> GraphflowassignmentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_layer_min(s : GraphflowassignmentLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_layer_max(s : GraphflowassignmentLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_layer_to_string(s : GraphflowassignmentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_buffer_make(size : Int) -> GraphflowassignmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_buffer_len(s : GraphflowassignmentBuffer) -> Int { s.size }

pub fn graph_flow_assignment_buffer_get(s : GraphflowassignmentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_buffer_set(s : GraphflowassignmentBuffer, i : Int, v : Double) -> GraphflowassignmentBuffer {
  let result = graph_flow_assignment_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_buffer_sum(s : GraphflowassignmentBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_buffer_mean(s : GraphflowassignmentBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_buffer_scale(s : GraphflowassignmentBuffer, f : Double) -> GraphflowassignmentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_buffer_add(a : GraphflowassignmentBuffer, b : GraphflowassignmentBuffer) -> GraphflowassignmentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_buffer_copy(s : GraphflowassignmentBuffer) -> GraphflowassignmentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_buffer_fill(s : GraphflowassignmentBuffer, v : Double) -> GraphflowassignmentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_buffer_min(s : GraphflowassignmentBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_buffer_max(s : GraphflowassignmentBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_buffer_to_string(s : GraphflowassignmentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_cursor_make(size : Int) -> GraphflowassignmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_cursor_len(s : GraphflowassignmentCursor) -> Int { s.size }

pub fn graph_flow_assignment_cursor_get(s : GraphflowassignmentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_cursor_set(s : GraphflowassignmentCursor, i : Int, v : Double) -> GraphflowassignmentCursor {
  let result = graph_flow_assignment_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_cursor_sum(s : GraphflowassignmentCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_cursor_mean(s : GraphflowassignmentCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_cursor_scale(s : GraphflowassignmentCursor, f : Double) -> GraphflowassignmentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cursor_add(a : GraphflowassignmentCursor, b : GraphflowassignmentCursor) -> GraphflowassignmentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_cursor_copy(s : GraphflowassignmentCursor) -> GraphflowassignmentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cursor_fill(s : GraphflowassignmentCursor, v : Double) -> GraphflowassignmentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cursor_min(s : GraphflowassignmentCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_cursor_max(s : GraphflowassignmentCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_cursor_to_string(s : GraphflowassignmentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_view_make(size : Int) -> GraphflowassignmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_view_len(s : GraphflowassignmentView) -> Int { s.size }

pub fn graph_flow_assignment_view_get(s : GraphflowassignmentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_view_set(s : GraphflowassignmentView, i : Int, v : Double) -> GraphflowassignmentView {
  let result = graph_flow_assignment_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_view_sum(s : GraphflowassignmentView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_view_mean(s : GraphflowassignmentView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_view_scale(s : GraphflowassignmentView, f : Double) -> GraphflowassignmentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_view_add(a : GraphflowassignmentView, b : GraphflowassignmentView) -> GraphflowassignmentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_view_copy(s : GraphflowassignmentView) -> GraphflowassignmentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_view_fill(s : GraphflowassignmentView, v : Double) -> GraphflowassignmentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_view_min(s : GraphflowassignmentView) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_view_max(s : GraphflowassignmentView) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_view_to_string(s : GraphflowassignmentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_range_make(size : Int) -> GraphflowassignmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_range_len(s : GraphflowassignmentRange) -> Int { s.size }

pub fn graph_flow_assignment_range_get(s : GraphflowassignmentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_range_set(s : GraphflowassignmentRange, i : Int, v : Double) -> GraphflowassignmentRange {
  let result = graph_flow_assignment_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_range_sum(s : GraphflowassignmentRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_range_mean(s : GraphflowassignmentRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_range_scale(s : GraphflowassignmentRange, f : Double) -> GraphflowassignmentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_range_add(a : GraphflowassignmentRange, b : GraphflowassignmentRange) -> GraphflowassignmentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_range_copy(s : GraphflowassignmentRange) -> GraphflowassignmentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_range_fill(s : GraphflowassignmentRange, v : Double) -> GraphflowassignmentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_range_min(s : GraphflowassignmentRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_range_max(s : GraphflowassignmentRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_range_to_string(s : GraphflowassignmentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_slice_make(size : Int) -> GraphflowassignmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_slice_len(s : GraphflowassignmentSlice) -> Int { s.size }

pub fn graph_flow_assignment_slice_get(s : GraphflowassignmentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_slice_set(s : GraphflowassignmentSlice, i : Int, v : Double) -> GraphflowassignmentSlice {
  let result = graph_flow_assignment_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_assignment_slice_sum(s : GraphflowassignmentSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_slice_mean(s : GraphflowassignmentSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_slice_scale(s : GraphflowassignmentSlice, f : Double) -> GraphflowassignmentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_slice_add(a : GraphflowassignmentSlice, b : GraphflowassignmentSlice) -> GraphflowassignmentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_slice_copy(s : GraphflowassignmentSlice) -> GraphflowassignmentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_slice_fill(s : GraphflowassignmentSlice, v : Double) -> GraphflowassignmentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_slice_min(s : GraphflowassignmentSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_slice_max(s : GraphflowassignmentSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_slice_to_string(s : GraphflowassignmentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

