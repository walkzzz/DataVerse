///===
/// extcore/ds_graph_directed

pub(all) struct DsgraphdirectedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_directed_make_point(x : Double, y : Double) -> DsgraphdirectedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_directed_make_point3(x : Double, y : Double, z : Double) -> DsgraphdirectedPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_directed_point_x(pt : DsgraphdirectedPoint) -> Double { pt.x }

pub fn ds_graph_directed_point_y(pt : DsgraphdirectedPoint) -> Double { pt.y }

pub fn ds_graph_directed_point_z(pt : DsgraphdirectedPoint) -> Double { pt.z }

pub fn ds_graph_directed_point_label(pt : DsgraphdirectedPoint) -> Int { pt.label }

pub fn ds_graph_directed_point_dist(a : DsgraphdirectedPoint, b : DsgraphdirectedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_directed_point_add(a : DsgraphdirectedPoint, b : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_directed_point_sub(a : DsgraphdirectedPoint, b : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_directed_point_scale(pt : DsgraphdirectedPoint, s : Double) -> DsgraphdirectedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_directed_point_dot(a : DsgraphdirectedPoint, b : DsgraphdirectedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_directed_point_cross(a : DsgraphdirectedPoint, b : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_directed_point_norm(pt : DsgraphdirectedPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_directed_point_normalize(pt : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  let n = ds_graph_directed_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_directed_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_directed_point_negate(pt : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_directed_point_mid(a : DsgraphdirectedPoint, b : DsgraphdirectedPoint) -> DsgraphdirectedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_directed_point_lerp(a : DsgraphdirectedPoint, b : DsgraphdirectedPoint, t : Double) -> DsgraphdirectedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_directed_point_to_string(pt : DsgraphdirectedPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphdirectedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_directed_make_series(vals : Array[Double], name : String) -> DsgraphdirectedSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_directed_series_len(s : DsgraphdirectedSeries) -> Int { s.vals.length() }

pub fn ds_graph_directed_series_sum(s : DsgraphdirectedSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_graph_directed_series_mean(s : DsgraphdirectedSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_graph_directed_series_min(s : DsgraphdirectedSeries) -> Double { @_common.min(s.vals) }

pub fn ds_graph_directed_series_max(s : DsgraphdirectedSeries) -> Double { @_common.max(s.vals) }

pub fn ds_graph_directed_series_range(s : DsgraphdirectedSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_graph_directed_series_var(s : DsgraphdirectedSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_graph_directed_series_std(s : DsgraphdirectedSeries) -> Double { @_common.std(s.vals) }

pub fn ds_graph_directed_series_median(s : DsgraphdirectedSeries) -> Double { @_common.median(s.vals) }

pub fn ds_graph_directed_series_scale(s : DsgraphdirectedSeries, f : Double) -> DsgraphdirectedSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_graph_directed_series_add(a : DsgraphdirectedSeries, b : DsgraphdirectedSeries) -> DsgraphdirectedSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_directed_series_sub(a : DsgraphdirectedSeries, b : DsgraphdirectedSeries) -> DsgraphdirectedSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_directed_series_normalize(s : DsgraphdirectedSeries) -> DsgraphdirectedSeries {
  let mn = ds_graph_directed_series_min(s)
  let mx = ds_graph_directed_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_directed_series_cumsum(s : DsgraphdirectedSeries) -> DsgraphdirectedSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_directed_series_to_string(s : DsgraphdirectedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphdirectedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_directed_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphdirectedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_directed_matrix_identity(n : Int) -> DsgraphdirectedMatrix {
  let m = ds_graph_directed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_directed_matrix_get(m : DsgraphdirectedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_directed_matrix_transpose(m : DsgraphdirectedMatrix) -> DsgraphdirectedMatrix {
  let result = ds_graph_directed_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_directed_matrix_add(a : DsgraphdirectedMatrix, b : DsgraphdirectedMatrix) -> DsgraphdirectedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_directed_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_directed_matrix_scale(m : DsgraphdirectedMatrix, s : Double) -> DsgraphdirectedMatrix {
  let result = ds_graph_directed_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_directed_matrix_multiply(a : DsgraphdirectedMatrix, b : DsgraphdirectedMatrix) -> DsgraphdirectedMatrix {
  if a.cols != b.rows { return ds_graph_directed_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_directed_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_directed_matrix_trace(m : DsgraphdirectedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_directed_matrix_det(m : DsgraphdirectedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_directed_matrix_norm(m : DsgraphdirectedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_directed_matrix_to_string(m : DsgraphdirectedMatrix) -> String {
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

pub(all) struct DsgraphdirectedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_directed_make_vector(comps : Array[Double]) -> DsgraphdirectedVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_directed_vector_zero(dim : Int) -> DsgraphdirectedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_directed_vector_add(a : DsgraphdirectedVector, b : DsgraphdirectedVector) -> DsgraphdirectedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_graph_directed_vector_sub(a : DsgraphdirectedVector, b : DsgraphdirectedVector) -> DsgraphdirectedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_graph_directed_vector_scale(v : DsgraphdirectedVector, s : Double) -> DsgraphdirectedVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_graph_directed_vector_dot(a : DsgraphdirectedVector, b : DsgraphdirectedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_directed_vector_norm(v : DsgraphdirectedVector) -> Double { @_common.sqrt(ds_graph_directed_vector_dot(v, v)) }

pub fn ds_graph_directed_vector_normalize(v : DsgraphdirectedVector) -> DsgraphdirectedVector {
  let n = ds_graph_directed_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_directed_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_directed_vector_dist(a : DsgraphdirectedVector, b : DsgraphdirectedVector) -> Double {
  ds_graph_directed_vector_norm(ds_graph_directed_vector_sub(a, b))
}

pub fn ds_graph_directed_vector_to_string(v : DsgraphdirectedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_directed_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_directed_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_directed_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_directed_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_directed_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_directed_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_directed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_directed_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_directed_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_directed_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_directed_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_directed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_directed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_directed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_directed_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_directed_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_directed_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_directed_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_directed_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_directed_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_directed_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_directed_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_directed_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_directed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_directed_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_directed_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_directed_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_directed_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_directed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphdirectedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_frame_make(size : Int) -> DsgraphdirectedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_frame_len(s : DsgraphdirectedFrame) -> Int { s.size }

pub fn ds_graph_directed_frame_get(s : DsgraphdirectedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_frame_set(s : DsgraphdirectedFrame, i : Int, v : Double) -> DsgraphdirectedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_frame_sum(s : DsgraphdirectedFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_frame_mean(s : DsgraphdirectedFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_frame_scale(s : DsgraphdirectedFrame, f : Double) -> DsgraphdirectedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_frame_add(a : DsgraphdirectedFrame, b : DsgraphdirectedFrame) -> DsgraphdirectedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_frame_copy(s : DsgraphdirectedFrame) -> DsgraphdirectedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_frame_fill(s : DsgraphdirectedFrame, v : Double) -> DsgraphdirectedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_frame_min(s : DsgraphdirectedFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_frame_max(s : DsgraphdirectedFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_frame_to_string(s : DsgraphdirectedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_table_make(size : Int) -> DsgraphdirectedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_table_len(s : DsgraphdirectedTable) -> Int { s.size }

pub fn ds_graph_directed_table_get(s : DsgraphdirectedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_table_set(s : DsgraphdirectedTable, i : Int, v : Double) -> DsgraphdirectedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_table_sum(s : DsgraphdirectedTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_table_mean(s : DsgraphdirectedTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_table_scale(s : DsgraphdirectedTable, f : Double) -> DsgraphdirectedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_table_add(a : DsgraphdirectedTable, b : DsgraphdirectedTable) -> DsgraphdirectedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_table_copy(s : DsgraphdirectedTable) -> DsgraphdirectedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_table_fill(s : DsgraphdirectedTable, v : Double) -> DsgraphdirectedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_table_min(s : DsgraphdirectedTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_table_max(s : DsgraphdirectedTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_table_to_string(s : DsgraphdirectedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_graphn_make(size : Int) -> DsgraphdirectedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_graphn_len(s : DsgraphdirectedGraphN) -> Int { s.size }

pub fn ds_graph_directed_graphn_get(s : DsgraphdirectedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_graphn_set(s : DsgraphdirectedGraphN, i : Int, v : Double) -> DsgraphdirectedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_graphn_sum(s : DsgraphdirectedGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_graphn_mean(s : DsgraphdirectedGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_graphn_scale(s : DsgraphdirectedGraphN, f : Double) -> DsgraphdirectedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_graphn_add(a : DsgraphdirectedGraphN, b : DsgraphdirectedGraphN) -> DsgraphdirectedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_graphn_copy(s : DsgraphdirectedGraphN) -> DsgraphdirectedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_graphn_fill(s : DsgraphdirectedGraphN, v : Double) -> DsgraphdirectedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_graphn_min(s : DsgraphdirectedGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_graphn_max(s : DsgraphdirectedGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_graphn_to_string(s : DsgraphdirectedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_node_make(size : Int) -> DsgraphdirectedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_node_len(s : DsgraphdirectedNode) -> Int { s.size }

pub fn ds_graph_directed_node_get(s : DsgraphdirectedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_node_set(s : DsgraphdirectedNode, i : Int, v : Double) -> DsgraphdirectedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_node_sum(s : DsgraphdirectedNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_node_mean(s : DsgraphdirectedNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_node_scale(s : DsgraphdirectedNode, f : Double) -> DsgraphdirectedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_node_add(a : DsgraphdirectedNode, b : DsgraphdirectedNode) -> DsgraphdirectedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_node_copy(s : DsgraphdirectedNode) -> DsgraphdirectedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_node_fill(s : DsgraphdirectedNode, v : Double) -> DsgraphdirectedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_node_min(s : DsgraphdirectedNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_node_max(s : DsgraphdirectedNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_node_to_string(s : DsgraphdirectedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_edge_make(size : Int) -> DsgraphdirectedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_edge_len(s : DsgraphdirectedEdge) -> Int { s.size }

pub fn ds_graph_directed_edge_get(s : DsgraphdirectedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_edge_set(s : DsgraphdirectedEdge, i : Int, v : Double) -> DsgraphdirectedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_edge_sum(s : DsgraphdirectedEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_edge_mean(s : DsgraphdirectedEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_edge_scale(s : DsgraphdirectedEdge, f : Double) -> DsgraphdirectedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_edge_add(a : DsgraphdirectedEdge, b : DsgraphdirectedEdge) -> DsgraphdirectedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_edge_copy(s : DsgraphdirectedEdge) -> DsgraphdirectedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_edge_fill(s : DsgraphdirectedEdge, v : Double) -> DsgraphdirectedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_edge_min(s : DsgraphdirectedEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_edge_max(s : DsgraphdirectedEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_edge_to_string(s : DsgraphdirectedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_path_make(size : Int) -> DsgraphdirectedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_path_len(s : DsgraphdirectedPath) -> Int { s.size }

pub fn ds_graph_directed_path_get(s : DsgraphdirectedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_path_set(s : DsgraphdirectedPath, i : Int, v : Double) -> DsgraphdirectedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_path_sum(s : DsgraphdirectedPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_path_mean(s : DsgraphdirectedPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_path_scale(s : DsgraphdirectedPath, f : Double) -> DsgraphdirectedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_path_add(a : DsgraphdirectedPath, b : DsgraphdirectedPath) -> DsgraphdirectedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_path_copy(s : DsgraphdirectedPath) -> DsgraphdirectedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_path_fill(s : DsgraphdirectedPath, v : Double) -> DsgraphdirectedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_path_min(s : DsgraphdirectedPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_path_max(s : DsgraphdirectedPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_path_to_string(s : DsgraphdirectedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_cluster_make(size : Int) -> DsgraphdirectedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_cluster_len(s : DsgraphdirectedCluster) -> Int { s.size }

pub fn ds_graph_directed_cluster_get(s : DsgraphdirectedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_cluster_set(s : DsgraphdirectedCluster, i : Int, v : Double) -> DsgraphdirectedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_cluster_sum(s : DsgraphdirectedCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_cluster_mean(s : DsgraphdirectedCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_cluster_scale(s : DsgraphdirectedCluster, f : Double) -> DsgraphdirectedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_cluster_add(a : DsgraphdirectedCluster, b : DsgraphdirectedCluster) -> DsgraphdirectedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_cluster_copy(s : DsgraphdirectedCluster) -> DsgraphdirectedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_cluster_fill(s : DsgraphdirectedCluster, v : Double) -> DsgraphdirectedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_cluster_min(s : DsgraphdirectedCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_cluster_max(s : DsgraphdirectedCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_cluster_to_string(s : DsgraphdirectedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_model_make(size : Int) -> DsgraphdirectedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_model_len(s : DsgraphdirectedModel) -> Int { s.size }

pub fn ds_graph_directed_model_get(s : DsgraphdirectedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_model_set(s : DsgraphdirectedModel, i : Int, v : Double) -> DsgraphdirectedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_model_sum(s : DsgraphdirectedModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_model_mean(s : DsgraphdirectedModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_model_scale(s : DsgraphdirectedModel, f : Double) -> DsgraphdirectedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_model_add(a : DsgraphdirectedModel, b : DsgraphdirectedModel) -> DsgraphdirectedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_model_copy(s : DsgraphdirectedModel) -> DsgraphdirectedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_model_fill(s : DsgraphdirectedModel, v : Double) -> DsgraphdirectedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_model_min(s : DsgraphdirectedModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_model_max(s : DsgraphdirectedModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_model_to_string(s : DsgraphdirectedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_layer_make(size : Int) -> DsgraphdirectedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_layer_len(s : DsgraphdirectedLayer) -> Int { s.size }

pub fn ds_graph_directed_layer_get(s : DsgraphdirectedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_layer_set(s : DsgraphdirectedLayer, i : Int, v : Double) -> DsgraphdirectedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_layer_sum(s : DsgraphdirectedLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_layer_mean(s : DsgraphdirectedLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_layer_scale(s : DsgraphdirectedLayer, f : Double) -> DsgraphdirectedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_layer_add(a : DsgraphdirectedLayer, b : DsgraphdirectedLayer) -> DsgraphdirectedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_layer_copy(s : DsgraphdirectedLayer) -> DsgraphdirectedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_layer_fill(s : DsgraphdirectedLayer, v : Double) -> DsgraphdirectedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_layer_min(s : DsgraphdirectedLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_layer_max(s : DsgraphdirectedLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_layer_to_string(s : DsgraphdirectedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_buffer_make(size : Int) -> DsgraphdirectedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_buffer_len(s : DsgraphdirectedBuffer) -> Int { s.size }

pub fn ds_graph_directed_buffer_get(s : DsgraphdirectedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_buffer_set(s : DsgraphdirectedBuffer, i : Int, v : Double) -> DsgraphdirectedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_buffer_sum(s : DsgraphdirectedBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_buffer_mean(s : DsgraphdirectedBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_buffer_scale(s : DsgraphdirectedBuffer, f : Double) -> DsgraphdirectedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_buffer_add(a : DsgraphdirectedBuffer, b : DsgraphdirectedBuffer) -> DsgraphdirectedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_buffer_copy(s : DsgraphdirectedBuffer) -> DsgraphdirectedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_buffer_fill(s : DsgraphdirectedBuffer, v : Double) -> DsgraphdirectedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_buffer_min(s : DsgraphdirectedBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_buffer_max(s : DsgraphdirectedBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_buffer_to_string(s : DsgraphdirectedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_cursor_make(size : Int) -> DsgraphdirectedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_cursor_len(s : DsgraphdirectedCursor) -> Int { s.size }

pub fn ds_graph_directed_cursor_get(s : DsgraphdirectedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_cursor_set(s : DsgraphdirectedCursor, i : Int, v : Double) -> DsgraphdirectedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_cursor_sum(s : DsgraphdirectedCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_cursor_mean(s : DsgraphdirectedCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_cursor_scale(s : DsgraphdirectedCursor, f : Double) -> DsgraphdirectedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_cursor_add(a : DsgraphdirectedCursor, b : DsgraphdirectedCursor) -> DsgraphdirectedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_cursor_copy(s : DsgraphdirectedCursor) -> DsgraphdirectedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_cursor_fill(s : DsgraphdirectedCursor, v : Double) -> DsgraphdirectedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_cursor_min(s : DsgraphdirectedCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_cursor_max(s : DsgraphdirectedCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_cursor_to_string(s : DsgraphdirectedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_view_make(size : Int) -> DsgraphdirectedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_view_len(s : DsgraphdirectedView) -> Int { s.size }

pub fn ds_graph_directed_view_get(s : DsgraphdirectedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_view_set(s : DsgraphdirectedView, i : Int, v : Double) -> DsgraphdirectedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_view_sum(s : DsgraphdirectedView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_view_mean(s : DsgraphdirectedView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_view_scale(s : DsgraphdirectedView, f : Double) -> DsgraphdirectedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_view_add(a : DsgraphdirectedView, b : DsgraphdirectedView) -> DsgraphdirectedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_view_copy(s : DsgraphdirectedView) -> DsgraphdirectedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_view_fill(s : DsgraphdirectedView, v : Double) -> DsgraphdirectedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_view_min(s : DsgraphdirectedView) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_view_max(s : DsgraphdirectedView) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_view_to_string(s : DsgraphdirectedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_range_make(size : Int) -> DsgraphdirectedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_range_len(s : DsgraphdirectedRange) -> Int { s.size }

pub fn ds_graph_directed_range_get(s : DsgraphdirectedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_range_set(s : DsgraphdirectedRange, i : Int, v : Double) -> DsgraphdirectedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_range_sum(s : DsgraphdirectedRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_range_mean(s : DsgraphdirectedRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_range_scale(s : DsgraphdirectedRange, f : Double) -> DsgraphdirectedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_range_add(a : DsgraphdirectedRange, b : DsgraphdirectedRange) -> DsgraphdirectedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_range_copy(s : DsgraphdirectedRange) -> DsgraphdirectedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_range_fill(s : DsgraphdirectedRange, v : Double) -> DsgraphdirectedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_range_min(s : DsgraphdirectedRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_range_max(s : DsgraphdirectedRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_range_to_string(s : DsgraphdirectedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphdirectedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_directed_slice_make(size : Int) -> DsgraphdirectedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_directed_slice_len(s : DsgraphdirectedSlice) -> Int { s.size }

pub fn ds_graph_directed_slice_get(s : DsgraphdirectedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_directed_slice_set(s : DsgraphdirectedSlice, i : Int, v : Double) -> DsgraphdirectedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_slice_sum(s : DsgraphdirectedSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_directed_slice_mean(s : DsgraphdirectedSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_directed_slice_scale(s : DsgraphdirectedSlice, f : Double) -> DsgraphdirectedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_slice_add(a : DsgraphdirectedSlice, b : DsgraphdirectedSlice) -> DsgraphdirectedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_directed_slice_copy(s : DsgraphdirectedSlice) -> DsgraphdirectedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_slice_fill(s : DsgraphdirectedSlice, v : Double) -> DsgraphdirectedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_directed_slice_min(s : DsgraphdirectedSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_directed_slice_max(s : DsgraphdirectedSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_directed_slice_to_string(s : DsgraphdirectedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

