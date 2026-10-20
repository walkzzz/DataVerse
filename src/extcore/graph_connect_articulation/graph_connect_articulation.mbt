///===
/// extcore/graph_connect_articulation

pub(all) struct GraphconnectarticulationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_articulation_make_point(x : Double, y : Double) -> GraphconnectarticulationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_articulation_make_point3(x : Double, y : Double, z : Double) -> GraphconnectarticulationPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_articulation_point_x(pt : GraphconnectarticulationPoint) -> Double { pt.x }

pub fn graph_connect_articulation_point_y(pt : GraphconnectarticulationPoint) -> Double { pt.y }

pub fn graph_connect_articulation_point_z(pt : GraphconnectarticulationPoint) -> Double { pt.z }

pub fn graph_connect_articulation_point_label(pt : GraphconnectarticulationPoint) -> Int { pt.label }

pub fn graph_connect_articulation_point_dist(a : GraphconnectarticulationPoint, b : GraphconnectarticulationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_articulation_point_add(a : GraphconnectarticulationPoint, b : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_articulation_point_sub(a : GraphconnectarticulationPoint, b : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_articulation_point_scale(pt : GraphconnectarticulationPoint, s : Double) -> GraphconnectarticulationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_articulation_point_dot(a : GraphconnectarticulationPoint, b : GraphconnectarticulationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_articulation_point_cross(a : GraphconnectarticulationPoint, b : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_articulation_point_norm(pt : GraphconnectarticulationPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_articulation_point_normalize(pt : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  let n = graph_connect_articulation_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_articulation_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_articulation_point_negate(pt : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_articulation_point_mid(a : GraphconnectarticulationPoint, b : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_articulation_point_lerp(a : GraphconnectarticulationPoint, b : GraphconnectarticulationPoint, t : Double) -> GraphconnectarticulationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_articulation_point_to_string(pt : GraphconnectarticulationPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectarticulationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_articulation_make_series(vals : Array[Double], name : String) -> GraphconnectarticulationSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_articulation_series_len(s : GraphconnectarticulationSeries) -> Int { s.vals.length() }

pub fn graph_connect_articulation_series_sum(s : GraphconnectarticulationSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_connect_articulation_series_mean(s : GraphconnectarticulationSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_connect_articulation_series_min(s : GraphconnectarticulationSeries) -> Double { @_common.min(s.vals) }

pub fn graph_connect_articulation_series_max(s : GraphconnectarticulationSeries) -> Double { @_common.max(s.vals) }

pub fn graph_connect_articulation_series_range(s : GraphconnectarticulationSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_connect_articulation_series_var(s : GraphconnectarticulationSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_connect_articulation_series_std(s : GraphconnectarticulationSeries) -> Double { @_common.std(s.vals) }

pub fn graph_connect_articulation_series_median(s : GraphconnectarticulationSeries) -> Double { @_common.median(s.vals) }

pub fn graph_connect_articulation_series_scale(s : GraphconnectarticulationSeries, f : Double) -> GraphconnectarticulationSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_articulation_series_add(a : GraphconnectarticulationSeries, b : GraphconnectarticulationSeries) -> GraphconnectarticulationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_articulation_series_sub(a : GraphconnectarticulationSeries, b : GraphconnectarticulationSeries) -> GraphconnectarticulationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_articulation_series_normalize(s : GraphconnectarticulationSeries) -> GraphconnectarticulationSeries {
  let mn = graph_connect_articulation_series_min(s)
  let mx = graph_connect_articulation_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_articulation_series_cumsum(s : GraphconnectarticulationSeries) -> GraphconnectarticulationSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_articulation_series_to_string(s : GraphconnectarticulationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectarticulationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_articulation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectarticulationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_articulation_matrix_identity(n : Int) -> GraphconnectarticulationMatrix {
  let m = graph_connect_articulation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_articulation_matrix_get(m : GraphconnectarticulationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_articulation_matrix_transpose(m : GraphconnectarticulationMatrix) -> GraphconnectarticulationMatrix {
  let result = graph_connect_articulation_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_articulation_matrix_add(a : GraphconnectarticulationMatrix, b : GraphconnectarticulationMatrix) -> GraphconnectarticulationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_articulation_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_articulation_matrix_scale(m : GraphconnectarticulationMatrix, s : Double) -> GraphconnectarticulationMatrix {
  let result = graph_connect_articulation_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_articulation_matrix_multiply(a : GraphconnectarticulationMatrix, b : GraphconnectarticulationMatrix) -> GraphconnectarticulationMatrix {
  if a.cols != b.rows { return graph_connect_articulation_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_articulation_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_articulation_matrix_trace(m : GraphconnectarticulationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_articulation_matrix_det(m : GraphconnectarticulationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_articulation_matrix_norm(m : GraphconnectarticulationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_articulation_matrix_to_string(m : GraphconnectarticulationMatrix) -> String {
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

pub(all) struct GraphconnectarticulationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_articulation_make_vector(comps : Array[Double]) -> GraphconnectarticulationVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_articulation_vector_zero(dim : Int) -> GraphconnectarticulationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_articulation_vector_add(a : GraphconnectarticulationVector, b : GraphconnectarticulationVector) -> GraphconnectarticulationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_articulation_vector_sub(a : GraphconnectarticulationVector, b : GraphconnectarticulationVector) -> GraphconnectarticulationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_articulation_vector_scale(v : GraphconnectarticulationVector, s : Double) -> GraphconnectarticulationVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_articulation_vector_dot(a : GraphconnectarticulationVector, b : GraphconnectarticulationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_articulation_vector_norm(v : GraphconnectarticulationVector) -> Double { @_common.sqrt(graph_connect_articulation_vector_dot(v, v)) }

pub fn graph_connect_articulation_vector_normalize(v : GraphconnectarticulationVector) -> GraphconnectarticulationVector {
  let n = graph_connect_articulation_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_articulation_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_articulation_vector_dist(a : GraphconnectarticulationVector, b : GraphconnectarticulationVector) -> Double {
  graph_connect_articulation_vector_norm(graph_connect_articulation_vector_sub(a, b))
}

pub fn graph_connect_articulation_vector_to_string(v : GraphconnectarticulationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_articulation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_articulation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_articulation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_articulation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_articulation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_articulation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_articulation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_articulation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_articulation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_articulation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_articulation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_articulation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_articulation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_articulation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_articulation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_articulation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_articulation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_articulation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_articulation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_articulation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_articulation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_articulation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_articulation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_articulation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_articulation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_articulation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_articulation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_articulation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_articulation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectarticulationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_frame_make(size : Int) -> GraphconnectarticulationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_frame_len(s : GraphconnectarticulationFrame) -> Int { s.size }

pub fn graph_connect_articulation_frame_get(s : GraphconnectarticulationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_frame_set(s : GraphconnectarticulationFrame, i : Int, v : Double) -> GraphconnectarticulationFrame {
  let result = graph_connect_articulation_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_frame_sum(s : GraphconnectarticulationFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_frame_mean(s : GraphconnectarticulationFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_frame_scale(s : GraphconnectarticulationFrame, f : Double) -> GraphconnectarticulationFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_frame_add(a : GraphconnectarticulationFrame, b : GraphconnectarticulationFrame) -> GraphconnectarticulationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_frame_copy(s : GraphconnectarticulationFrame) -> GraphconnectarticulationFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_frame_fill(s : GraphconnectarticulationFrame, v : Double) -> GraphconnectarticulationFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_frame_min(s : GraphconnectarticulationFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_frame_max(s : GraphconnectarticulationFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_frame_to_string(s : GraphconnectarticulationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_table_make(size : Int) -> GraphconnectarticulationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_table_len(s : GraphconnectarticulationTable) -> Int { s.size }

pub fn graph_connect_articulation_table_get(s : GraphconnectarticulationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_table_set(s : GraphconnectarticulationTable, i : Int, v : Double) -> GraphconnectarticulationTable {
  let result = graph_connect_articulation_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_table_sum(s : GraphconnectarticulationTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_table_mean(s : GraphconnectarticulationTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_table_scale(s : GraphconnectarticulationTable, f : Double) -> GraphconnectarticulationTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_table_add(a : GraphconnectarticulationTable, b : GraphconnectarticulationTable) -> GraphconnectarticulationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_table_copy(s : GraphconnectarticulationTable) -> GraphconnectarticulationTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_table_fill(s : GraphconnectarticulationTable, v : Double) -> GraphconnectarticulationTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_table_min(s : GraphconnectarticulationTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_table_max(s : GraphconnectarticulationTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_table_to_string(s : GraphconnectarticulationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_graphn_make(size : Int) -> GraphconnectarticulationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_graphn_len(s : GraphconnectarticulationGraphN) -> Int { s.size }

pub fn graph_connect_articulation_graphn_get(s : GraphconnectarticulationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_graphn_set(s : GraphconnectarticulationGraphN, i : Int, v : Double) -> GraphconnectarticulationGraphN {
  let result = graph_connect_articulation_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_graphn_sum(s : GraphconnectarticulationGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_graphn_mean(s : GraphconnectarticulationGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_graphn_scale(s : GraphconnectarticulationGraphN, f : Double) -> GraphconnectarticulationGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_graphn_add(a : GraphconnectarticulationGraphN, b : GraphconnectarticulationGraphN) -> GraphconnectarticulationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_graphn_copy(s : GraphconnectarticulationGraphN) -> GraphconnectarticulationGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_graphn_fill(s : GraphconnectarticulationGraphN, v : Double) -> GraphconnectarticulationGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_graphn_min(s : GraphconnectarticulationGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_graphn_max(s : GraphconnectarticulationGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_graphn_to_string(s : GraphconnectarticulationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_node_make(size : Int) -> GraphconnectarticulationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_node_len(s : GraphconnectarticulationNode) -> Int { s.size }

pub fn graph_connect_articulation_node_get(s : GraphconnectarticulationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_node_set(s : GraphconnectarticulationNode, i : Int, v : Double) -> GraphconnectarticulationNode {
  let result = graph_connect_articulation_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_node_sum(s : GraphconnectarticulationNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_node_mean(s : GraphconnectarticulationNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_node_scale(s : GraphconnectarticulationNode, f : Double) -> GraphconnectarticulationNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_node_add(a : GraphconnectarticulationNode, b : GraphconnectarticulationNode) -> GraphconnectarticulationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_node_copy(s : GraphconnectarticulationNode) -> GraphconnectarticulationNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_node_fill(s : GraphconnectarticulationNode, v : Double) -> GraphconnectarticulationNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_node_min(s : GraphconnectarticulationNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_node_max(s : GraphconnectarticulationNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_node_to_string(s : GraphconnectarticulationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_edge_make(size : Int) -> GraphconnectarticulationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_edge_len(s : GraphconnectarticulationEdge) -> Int { s.size }

pub fn graph_connect_articulation_edge_get(s : GraphconnectarticulationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_edge_set(s : GraphconnectarticulationEdge, i : Int, v : Double) -> GraphconnectarticulationEdge {
  let result = graph_connect_articulation_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_edge_sum(s : GraphconnectarticulationEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_edge_mean(s : GraphconnectarticulationEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_edge_scale(s : GraphconnectarticulationEdge, f : Double) -> GraphconnectarticulationEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_edge_add(a : GraphconnectarticulationEdge, b : GraphconnectarticulationEdge) -> GraphconnectarticulationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_edge_copy(s : GraphconnectarticulationEdge) -> GraphconnectarticulationEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_edge_fill(s : GraphconnectarticulationEdge, v : Double) -> GraphconnectarticulationEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_edge_min(s : GraphconnectarticulationEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_edge_max(s : GraphconnectarticulationEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_edge_to_string(s : GraphconnectarticulationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_path_make(size : Int) -> GraphconnectarticulationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_path_len(s : GraphconnectarticulationPath) -> Int { s.size }

pub fn graph_connect_articulation_path_get(s : GraphconnectarticulationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_path_set(s : GraphconnectarticulationPath, i : Int, v : Double) -> GraphconnectarticulationPath {
  let result = graph_connect_articulation_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_path_sum(s : GraphconnectarticulationPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_path_mean(s : GraphconnectarticulationPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_path_scale(s : GraphconnectarticulationPath, f : Double) -> GraphconnectarticulationPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_path_add(a : GraphconnectarticulationPath, b : GraphconnectarticulationPath) -> GraphconnectarticulationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_path_copy(s : GraphconnectarticulationPath) -> GraphconnectarticulationPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_path_fill(s : GraphconnectarticulationPath, v : Double) -> GraphconnectarticulationPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_path_min(s : GraphconnectarticulationPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_path_max(s : GraphconnectarticulationPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_path_to_string(s : GraphconnectarticulationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_cluster_make(size : Int) -> GraphconnectarticulationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_cluster_len(s : GraphconnectarticulationCluster) -> Int { s.size }

pub fn graph_connect_articulation_cluster_get(s : GraphconnectarticulationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_cluster_set(s : GraphconnectarticulationCluster, i : Int, v : Double) -> GraphconnectarticulationCluster {
  let result = graph_connect_articulation_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_cluster_sum(s : GraphconnectarticulationCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_cluster_mean(s : GraphconnectarticulationCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_cluster_scale(s : GraphconnectarticulationCluster, f : Double) -> GraphconnectarticulationCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cluster_add(a : GraphconnectarticulationCluster, b : GraphconnectarticulationCluster) -> GraphconnectarticulationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_cluster_copy(s : GraphconnectarticulationCluster) -> GraphconnectarticulationCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cluster_fill(s : GraphconnectarticulationCluster, v : Double) -> GraphconnectarticulationCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cluster_min(s : GraphconnectarticulationCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_cluster_max(s : GraphconnectarticulationCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_cluster_to_string(s : GraphconnectarticulationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_model_make(size : Int) -> GraphconnectarticulationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_model_len(s : GraphconnectarticulationModel) -> Int { s.size }

pub fn graph_connect_articulation_model_get(s : GraphconnectarticulationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_model_set(s : GraphconnectarticulationModel, i : Int, v : Double) -> GraphconnectarticulationModel {
  let result = graph_connect_articulation_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_model_sum(s : GraphconnectarticulationModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_model_mean(s : GraphconnectarticulationModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_model_scale(s : GraphconnectarticulationModel, f : Double) -> GraphconnectarticulationModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_model_add(a : GraphconnectarticulationModel, b : GraphconnectarticulationModel) -> GraphconnectarticulationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_model_copy(s : GraphconnectarticulationModel) -> GraphconnectarticulationModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_model_fill(s : GraphconnectarticulationModel, v : Double) -> GraphconnectarticulationModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_model_min(s : GraphconnectarticulationModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_model_max(s : GraphconnectarticulationModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_model_to_string(s : GraphconnectarticulationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_layer_make(size : Int) -> GraphconnectarticulationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_layer_len(s : GraphconnectarticulationLayer) -> Int { s.size }

pub fn graph_connect_articulation_layer_get(s : GraphconnectarticulationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_layer_set(s : GraphconnectarticulationLayer, i : Int, v : Double) -> GraphconnectarticulationLayer {
  let result = graph_connect_articulation_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_layer_sum(s : GraphconnectarticulationLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_layer_mean(s : GraphconnectarticulationLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_layer_scale(s : GraphconnectarticulationLayer, f : Double) -> GraphconnectarticulationLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_layer_add(a : GraphconnectarticulationLayer, b : GraphconnectarticulationLayer) -> GraphconnectarticulationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_layer_copy(s : GraphconnectarticulationLayer) -> GraphconnectarticulationLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_layer_fill(s : GraphconnectarticulationLayer, v : Double) -> GraphconnectarticulationLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_layer_min(s : GraphconnectarticulationLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_layer_max(s : GraphconnectarticulationLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_layer_to_string(s : GraphconnectarticulationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_buffer_make(size : Int) -> GraphconnectarticulationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_buffer_len(s : GraphconnectarticulationBuffer) -> Int { s.size }

pub fn graph_connect_articulation_buffer_get(s : GraphconnectarticulationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_buffer_set(s : GraphconnectarticulationBuffer, i : Int, v : Double) -> GraphconnectarticulationBuffer {
  let result = graph_connect_articulation_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_buffer_sum(s : GraphconnectarticulationBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_buffer_mean(s : GraphconnectarticulationBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_buffer_scale(s : GraphconnectarticulationBuffer, f : Double) -> GraphconnectarticulationBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_buffer_add(a : GraphconnectarticulationBuffer, b : GraphconnectarticulationBuffer) -> GraphconnectarticulationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_buffer_copy(s : GraphconnectarticulationBuffer) -> GraphconnectarticulationBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_buffer_fill(s : GraphconnectarticulationBuffer, v : Double) -> GraphconnectarticulationBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_buffer_min(s : GraphconnectarticulationBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_buffer_max(s : GraphconnectarticulationBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_buffer_to_string(s : GraphconnectarticulationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_cursor_make(size : Int) -> GraphconnectarticulationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_cursor_len(s : GraphconnectarticulationCursor) -> Int { s.size }

pub fn graph_connect_articulation_cursor_get(s : GraphconnectarticulationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_cursor_set(s : GraphconnectarticulationCursor, i : Int, v : Double) -> GraphconnectarticulationCursor {
  let result = graph_connect_articulation_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_cursor_sum(s : GraphconnectarticulationCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_cursor_mean(s : GraphconnectarticulationCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_cursor_scale(s : GraphconnectarticulationCursor, f : Double) -> GraphconnectarticulationCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cursor_add(a : GraphconnectarticulationCursor, b : GraphconnectarticulationCursor) -> GraphconnectarticulationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_cursor_copy(s : GraphconnectarticulationCursor) -> GraphconnectarticulationCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cursor_fill(s : GraphconnectarticulationCursor, v : Double) -> GraphconnectarticulationCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cursor_min(s : GraphconnectarticulationCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_cursor_max(s : GraphconnectarticulationCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_cursor_to_string(s : GraphconnectarticulationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_view_make(size : Int) -> GraphconnectarticulationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_view_len(s : GraphconnectarticulationView) -> Int { s.size }

pub fn graph_connect_articulation_view_get(s : GraphconnectarticulationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_view_set(s : GraphconnectarticulationView, i : Int, v : Double) -> GraphconnectarticulationView {
  let result = graph_connect_articulation_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_view_sum(s : GraphconnectarticulationView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_view_mean(s : GraphconnectarticulationView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_view_scale(s : GraphconnectarticulationView, f : Double) -> GraphconnectarticulationView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_view_add(a : GraphconnectarticulationView, b : GraphconnectarticulationView) -> GraphconnectarticulationView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_view_copy(s : GraphconnectarticulationView) -> GraphconnectarticulationView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_view_fill(s : GraphconnectarticulationView, v : Double) -> GraphconnectarticulationView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_view_min(s : GraphconnectarticulationView) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_view_max(s : GraphconnectarticulationView) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_view_to_string(s : GraphconnectarticulationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_range_make(size : Int) -> GraphconnectarticulationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_range_len(s : GraphconnectarticulationRange) -> Int { s.size }

pub fn graph_connect_articulation_range_get(s : GraphconnectarticulationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_range_set(s : GraphconnectarticulationRange, i : Int, v : Double) -> GraphconnectarticulationRange {
  let result = graph_connect_articulation_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_range_sum(s : GraphconnectarticulationRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_range_mean(s : GraphconnectarticulationRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_range_scale(s : GraphconnectarticulationRange, f : Double) -> GraphconnectarticulationRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_range_add(a : GraphconnectarticulationRange, b : GraphconnectarticulationRange) -> GraphconnectarticulationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_range_copy(s : GraphconnectarticulationRange) -> GraphconnectarticulationRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_range_fill(s : GraphconnectarticulationRange, v : Double) -> GraphconnectarticulationRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_range_min(s : GraphconnectarticulationRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_range_max(s : GraphconnectarticulationRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_range_to_string(s : GraphconnectarticulationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_slice_make(size : Int) -> GraphconnectarticulationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_slice_len(s : GraphconnectarticulationSlice) -> Int { s.size }

pub fn graph_connect_articulation_slice_get(s : GraphconnectarticulationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_slice_set(s : GraphconnectarticulationSlice, i : Int, v : Double) -> GraphconnectarticulationSlice {
  let result = graph_connect_articulation_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_articulation_slice_sum(s : GraphconnectarticulationSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_slice_mean(s : GraphconnectarticulationSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_slice_scale(s : GraphconnectarticulationSlice, f : Double) -> GraphconnectarticulationSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_slice_add(a : GraphconnectarticulationSlice, b : GraphconnectarticulationSlice) -> GraphconnectarticulationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_slice_copy(s : GraphconnectarticulationSlice) -> GraphconnectarticulationSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_slice_fill(s : GraphconnectarticulationSlice, v : Double) -> GraphconnectarticulationSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_slice_min(s : GraphconnectarticulationSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_slice_max(s : GraphconnectarticulationSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_slice_to_string(s : GraphconnectarticulationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

