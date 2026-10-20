///===
/// extcore/graph_flow_circulation

pub(all) struct GraphflowcirculationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_circulation_make_point(x : Double, y : Double) -> GraphflowcirculationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_circulation_make_point3(x : Double, y : Double, z : Double) -> GraphflowcirculationPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_circulation_point_x(pt : GraphflowcirculationPoint) -> Double { pt.x }

pub fn graph_flow_circulation_point_y(pt : GraphflowcirculationPoint) -> Double { pt.y }

pub fn graph_flow_circulation_point_z(pt : GraphflowcirculationPoint) -> Double { pt.z }

pub fn graph_flow_circulation_point_label(pt : GraphflowcirculationPoint) -> Int { pt.label }

pub fn graph_flow_circulation_point_dist(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_circulation_point_add(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_circulation_point_sub(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_circulation_point_scale(pt : GraphflowcirculationPoint, s : Double) -> GraphflowcirculationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_circulation_point_dot(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_circulation_point_cross(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_circulation_point_norm(pt : GraphflowcirculationPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_circulation_point_normalize(pt : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  let n = graph_flow_circulation_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_circulation_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_circulation_point_negate(pt : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_circulation_point_mid(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_circulation_point_lerp(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint, t : Double) -> GraphflowcirculationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_circulation_point_to_string(pt : GraphflowcirculationPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowcirculationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_circulation_make_series(vals : Array[Double], name : String) -> GraphflowcirculationSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_circulation_series_len(s : GraphflowcirculationSeries) -> Int { s.vals.length() }

pub fn graph_flow_circulation_series_sum(s : GraphflowcirculationSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_flow_circulation_series_mean(s : GraphflowcirculationSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_flow_circulation_series_min(s : GraphflowcirculationSeries) -> Double { @_common.min(s.vals) }

pub fn graph_flow_circulation_series_max(s : GraphflowcirculationSeries) -> Double { @_common.max(s.vals) }

pub fn graph_flow_circulation_series_range(s : GraphflowcirculationSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_flow_circulation_series_var(s : GraphflowcirculationSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_flow_circulation_series_std(s : GraphflowcirculationSeries) -> Double { @_common.std(s.vals) }

pub fn graph_flow_circulation_series_median(s : GraphflowcirculationSeries) -> Double { @_common.median(s.vals) }

pub fn graph_flow_circulation_series_scale(s : GraphflowcirculationSeries, f : Double) -> GraphflowcirculationSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_flow_circulation_series_add(a : GraphflowcirculationSeries, b : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_circulation_series_sub(a : GraphflowcirculationSeries, b : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_circulation_series_normalize(s : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  let mn = graph_flow_circulation_series_min(s)
  let mx = graph_flow_circulation_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_circulation_series_cumsum(s : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_circulation_series_to_string(s : GraphflowcirculationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowcirculationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_circulation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowcirculationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_circulation_matrix_identity(n : Int) -> GraphflowcirculationMatrix {
  let m = graph_flow_circulation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_circulation_matrix_get(m : GraphflowcirculationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_circulation_matrix_transpose(m : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  let result = graph_flow_circulation_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_circulation_matrix_add(a : GraphflowcirculationMatrix, b : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_circulation_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_circulation_matrix_scale(m : GraphflowcirculationMatrix, s : Double) -> GraphflowcirculationMatrix {
  let result = graph_flow_circulation_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_circulation_matrix_multiply(a : GraphflowcirculationMatrix, b : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  if a.cols != b.rows { return graph_flow_circulation_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_circulation_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_circulation_matrix_trace(m : GraphflowcirculationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_circulation_matrix_det(m : GraphflowcirculationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_circulation_matrix_norm(m : GraphflowcirculationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_flow_circulation_matrix_to_string(m : GraphflowcirculationMatrix) -> String {
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

pub(all) struct GraphflowcirculationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_circulation_make_vector(comps : Array[Double]) -> GraphflowcirculationVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_circulation_vector_zero(dim : Int) -> GraphflowcirculationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_circulation_vector_add(a : GraphflowcirculationVector, b : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_flow_circulation_vector_sub(a : GraphflowcirculationVector, b : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_flow_circulation_vector_scale(v : GraphflowcirculationVector, s : Double) -> GraphflowcirculationVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_flow_circulation_vector_dot(a : GraphflowcirculationVector, b : GraphflowcirculationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_circulation_vector_norm(v : GraphflowcirculationVector) -> Double { @_common.sqrt(graph_flow_circulation_vector_dot(v, v)) }

pub fn graph_flow_circulation_vector_normalize(v : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = graph_flow_circulation_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_circulation_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_circulation_vector_dist(a : GraphflowcirculationVector, b : GraphflowcirculationVector) -> Double {
  graph_flow_circulation_vector_norm(graph_flow_circulation_vector_sub(a, b))
}

pub fn graph_flow_circulation_vector_to_string(v : GraphflowcirculationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_circulation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_circulation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_circulation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_circulation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_circulation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_circulation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_circulation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_circulation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_circulation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_circulation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_circulation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_circulation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_circulation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_circulation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_circulation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_circulation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_circulation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_circulation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_circulation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_circulation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_circulation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_circulation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_circulation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_circulation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_circulation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_circulation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_circulation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_circulation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_circulation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowcirculationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_frame_make(size : Int) -> GraphflowcirculationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_frame_len(s : GraphflowcirculationFrame) -> Int { s.size }

pub fn graph_flow_circulation_frame_get(s : GraphflowcirculationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_frame_set(s : GraphflowcirculationFrame, i : Int, v : Double) -> GraphflowcirculationFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_frame_sum(s : GraphflowcirculationFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_frame_mean(s : GraphflowcirculationFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_frame_scale(s : GraphflowcirculationFrame, f : Double) -> GraphflowcirculationFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_frame_add(a : GraphflowcirculationFrame, b : GraphflowcirculationFrame) -> GraphflowcirculationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_frame_copy(s : GraphflowcirculationFrame) -> GraphflowcirculationFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_frame_fill(s : GraphflowcirculationFrame, v : Double) -> GraphflowcirculationFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_frame_min(s : GraphflowcirculationFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_frame_max(s : GraphflowcirculationFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_frame_to_string(s : GraphflowcirculationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_table_make(size : Int) -> GraphflowcirculationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_table_len(s : GraphflowcirculationTable) -> Int { s.size }

pub fn graph_flow_circulation_table_get(s : GraphflowcirculationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_table_set(s : GraphflowcirculationTable, i : Int, v : Double) -> GraphflowcirculationTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_table_sum(s : GraphflowcirculationTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_table_mean(s : GraphflowcirculationTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_table_scale(s : GraphflowcirculationTable, f : Double) -> GraphflowcirculationTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_table_add(a : GraphflowcirculationTable, b : GraphflowcirculationTable) -> GraphflowcirculationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_table_copy(s : GraphflowcirculationTable) -> GraphflowcirculationTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_table_fill(s : GraphflowcirculationTable, v : Double) -> GraphflowcirculationTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_table_min(s : GraphflowcirculationTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_table_max(s : GraphflowcirculationTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_table_to_string(s : GraphflowcirculationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_graphn_make(size : Int) -> GraphflowcirculationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_graphn_len(s : GraphflowcirculationGraphN) -> Int { s.size }

pub fn graph_flow_circulation_graphn_get(s : GraphflowcirculationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_graphn_set(s : GraphflowcirculationGraphN, i : Int, v : Double) -> GraphflowcirculationGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_graphn_sum(s : GraphflowcirculationGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_graphn_mean(s : GraphflowcirculationGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_graphn_scale(s : GraphflowcirculationGraphN, f : Double) -> GraphflowcirculationGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_graphn_add(a : GraphflowcirculationGraphN, b : GraphflowcirculationGraphN) -> GraphflowcirculationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_graphn_copy(s : GraphflowcirculationGraphN) -> GraphflowcirculationGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_graphn_fill(s : GraphflowcirculationGraphN, v : Double) -> GraphflowcirculationGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_graphn_min(s : GraphflowcirculationGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_graphn_max(s : GraphflowcirculationGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_graphn_to_string(s : GraphflowcirculationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_node_make(size : Int) -> GraphflowcirculationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_node_len(s : GraphflowcirculationNode) -> Int { s.size }

pub fn graph_flow_circulation_node_get(s : GraphflowcirculationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_node_set(s : GraphflowcirculationNode, i : Int, v : Double) -> GraphflowcirculationNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_node_sum(s : GraphflowcirculationNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_node_mean(s : GraphflowcirculationNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_node_scale(s : GraphflowcirculationNode, f : Double) -> GraphflowcirculationNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_node_add(a : GraphflowcirculationNode, b : GraphflowcirculationNode) -> GraphflowcirculationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_node_copy(s : GraphflowcirculationNode) -> GraphflowcirculationNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_node_fill(s : GraphflowcirculationNode, v : Double) -> GraphflowcirculationNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_node_min(s : GraphflowcirculationNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_node_max(s : GraphflowcirculationNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_node_to_string(s : GraphflowcirculationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_edge_make(size : Int) -> GraphflowcirculationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_edge_len(s : GraphflowcirculationEdge) -> Int { s.size }

pub fn graph_flow_circulation_edge_get(s : GraphflowcirculationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_edge_set(s : GraphflowcirculationEdge, i : Int, v : Double) -> GraphflowcirculationEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_edge_sum(s : GraphflowcirculationEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_edge_mean(s : GraphflowcirculationEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_edge_scale(s : GraphflowcirculationEdge, f : Double) -> GraphflowcirculationEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_edge_add(a : GraphflowcirculationEdge, b : GraphflowcirculationEdge) -> GraphflowcirculationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_edge_copy(s : GraphflowcirculationEdge) -> GraphflowcirculationEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_edge_fill(s : GraphflowcirculationEdge, v : Double) -> GraphflowcirculationEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_edge_min(s : GraphflowcirculationEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_edge_max(s : GraphflowcirculationEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_edge_to_string(s : GraphflowcirculationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_path_make(size : Int) -> GraphflowcirculationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_path_len(s : GraphflowcirculationPath) -> Int { s.size }

pub fn graph_flow_circulation_path_get(s : GraphflowcirculationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_path_set(s : GraphflowcirculationPath, i : Int, v : Double) -> GraphflowcirculationPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_path_sum(s : GraphflowcirculationPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_path_mean(s : GraphflowcirculationPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_path_scale(s : GraphflowcirculationPath, f : Double) -> GraphflowcirculationPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_path_add(a : GraphflowcirculationPath, b : GraphflowcirculationPath) -> GraphflowcirculationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_path_copy(s : GraphflowcirculationPath) -> GraphflowcirculationPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_path_fill(s : GraphflowcirculationPath, v : Double) -> GraphflowcirculationPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_path_min(s : GraphflowcirculationPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_path_max(s : GraphflowcirculationPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_path_to_string(s : GraphflowcirculationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_cluster_make(size : Int) -> GraphflowcirculationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_cluster_len(s : GraphflowcirculationCluster) -> Int { s.size }

pub fn graph_flow_circulation_cluster_get(s : GraphflowcirculationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_cluster_set(s : GraphflowcirculationCluster, i : Int, v : Double) -> GraphflowcirculationCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cluster_sum(s : GraphflowcirculationCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_cluster_mean(s : GraphflowcirculationCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_cluster_scale(s : GraphflowcirculationCluster, f : Double) -> GraphflowcirculationCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cluster_add(a : GraphflowcirculationCluster, b : GraphflowcirculationCluster) -> GraphflowcirculationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_cluster_copy(s : GraphflowcirculationCluster) -> GraphflowcirculationCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cluster_fill(s : GraphflowcirculationCluster, v : Double) -> GraphflowcirculationCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cluster_min(s : GraphflowcirculationCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_cluster_max(s : GraphflowcirculationCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_cluster_to_string(s : GraphflowcirculationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_model_make(size : Int) -> GraphflowcirculationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_model_len(s : GraphflowcirculationModel) -> Int { s.size }

pub fn graph_flow_circulation_model_get(s : GraphflowcirculationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_model_set(s : GraphflowcirculationModel, i : Int, v : Double) -> GraphflowcirculationModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_model_sum(s : GraphflowcirculationModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_model_mean(s : GraphflowcirculationModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_model_scale(s : GraphflowcirculationModel, f : Double) -> GraphflowcirculationModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_model_add(a : GraphflowcirculationModel, b : GraphflowcirculationModel) -> GraphflowcirculationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_model_copy(s : GraphflowcirculationModel) -> GraphflowcirculationModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_model_fill(s : GraphflowcirculationModel, v : Double) -> GraphflowcirculationModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_model_min(s : GraphflowcirculationModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_model_max(s : GraphflowcirculationModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_model_to_string(s : GraphflowcirculationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_layer_make(size : Int) -> GraphflowcirculationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_layer_len(s : GraphflowcirculationLayer) -> Int { s.size }

pub fn graph_flow_circulation_layer_get(s : GraphflowcirculationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_layer_set(s : GraphflowcirculationLayer, i : Int, v : Double) -> GraphflowcirculationLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_layer_sum(s : GraphflowcirculationLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_layer_mean(s : GraphflowcirculationLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_layer_scale(s : GraphflowcirculationLayer, f : Double) -> GraphflowcirculationLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_layer_add(a : GraphflowcirculationLayer, b : GraphflowcirculationLayer) -> GraphflowcirculationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_layer_copy(s : GraphflowcirculationLayer) -> GraphflowcirculationLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_layer_fill(s : GraphflowcirculationLayer, v : Double) -> GraphflowcirculationLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_layer_min(s : GraphflowcirculationLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_layer_max(s : GraphflowcirculationLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_layer_to_string(s : GraphflowcirculationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_buffer_make(size : Int) -> GraphflowcirculationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_buffer_len(s : GraphflowcirculationBuffer) -> Int { s.size }

pub fn graph_flow_circulation_buffer_get(s : GraphflowcirculationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_buffer_set(s : GraphflowcirculationBuffer, i : Int, v : Double) -> GraphflowcirculationBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_buffer_sum(s : GraphflowcirculationBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_buffer_mean(s : GraphflowcirculationBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_buffer_scale(s : GraphflowcirculationBuffer, f : Double) -> GraphflowcirculationBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_buffer_add(a : GraphflowcirculationBuffer, b : GraphflowcirculationBuffer) -> GraphflowcirculationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_buffer_copy(s : GraphflowcirculationBuffer) -> GraphflowcirculationBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_buffer_fill(s : GraphflowcirculationBuffer, v : Double) -> GraphflowcirculationBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_buffer_min(s : GraphflowcirculationBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_buffer_max(s : GraphflowcirculationBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_buffer_to_string(s : GraphflowcirculationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_cursor_make(size : Int) -> GraphflowcirculationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_cursor_len(s : GraphflowcirculationCursor) -> Int { s.size }

pub fn graph_flow_circulation_cursor_get(s : GraphflowcirculationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_cursor_set(s : GraphflowcirculationCursor, i : Int, v : Double) -> GraphflowcirculationCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cursor_sum(s : GraphflowcirculationCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_cursor_mean(s : GraphflowcirculationCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_cursor_scale(s : GraphflowcirculationCursor, f : Double) -> GraphflowcirculationCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cursor_add(a : GraphflowcirculationCursor, b : GraphflowcirculationCursor) -> GraphflowcirculationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_cursor_copy(s : GraphflowcirculationCursor) -> GraphflowcirculationCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cursor_fill(s : GraphflowcirculationCursor, v : Double) -> GraphflowcirculationCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cursor_min(s : GraphflowcirculationCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_cursor_max(s : GraphflowcirculationCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_cursor_to_string(s : GraphflowcirculationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_view_make(size : Int) -> GraphflowcirculationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_view_len(s : GraphflowcirculationView) -> Int { s.size }

pub fn graph_flow_circulation_view_get(s : GraphflowcirculationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_view_set(s : GraphflowcirculationView, i : Int, v : Double) -> GraphflowcirculationView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_view_sum(s : GraphflowcirculationView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_view_mean(s : GraphflowcirculationView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_view_scale(s : GraphflowcirculationView, f : Double) -> GraphflowcirculationView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_view_add(a : GraphflowcirculationView, b : GraphflowcirculationView) -> GraphflowcirculationView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_view_copy(s : GraphflowcirculationView) -> GraphflowcirculationView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_view_fill(s : GraphflowcirculationView, v : Double) -> GraphflowcirculationView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_view_min(s : GraphflowcirculationView) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_view_max(s : GraphflowcirculationView) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_view_to_string(s : GraphflowcirculationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_range_make(size : Int) -> GraphflowcirculationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_range_len(s : GraphflowcirculationRange) -> Int { s.size }

pub fn graph_flow_circulation_range_get(s : GraphflowcirculationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_range_set(s : GraphflowcirculationRange, i : Int, v : Double) -> GraphflowcirculationRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_range_sum(s : GraphflowcirculationRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_range_mean(s : GraphflowcirculationRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_range_scale(s : GraphflowcirculationRange, f : Double) -> GraphflowcirculationRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_range_add(a : GraphflowcirculationRange, b : GraphflowcirculationRange) -> GraphflowcirculationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_range_copy(s : GraphflowcirculationRange) -> GraphflowcirculationRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_range_fill(s : GraphflowcirculationRange, v : Double) -> GraphflowcirculationRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_range_min(s : GraphflowcirculationRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_range_max(s : GraphflowcirculationRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_range_to_string(s : GraphflowcirculationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_slice_make(size : Int) -> GraphflowcirculationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_slice_len(s : GraphflowcirculationSlice) -> Int { s.size }

pub fn graph_flow_circulation_slice_get(s : GraphflowcirculationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_slice_set(s : GraphflowcirculationSlice, i : Int, v : Double) -> GraphflowcirculationSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_slice_sum(s : GraphflowcirculationSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_slice_mean(s : GraphflowcirculationSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_slice_scale(s : GraphflowcirculationSlice, f : Double) -> GraphflowcirculationSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_slice_add(a : GraphflowcirculationSlice, b : GraphflowcirculationSlice) -> GraphflowcirculationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_slice_copy(s : GraphflowcirculationSlice) -> GraphflowcirculationSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_slice_fill(s : GraphflowcirculationSlice, v : Double) -> GraphflowcirculationSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_slice_min(s : GraphflowcirculationSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_slice_max(s : GraphflowcirculationSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_slice_to_string(s : GraphflowcirculationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

