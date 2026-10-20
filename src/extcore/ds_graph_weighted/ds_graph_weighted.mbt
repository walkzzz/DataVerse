///===
/// extcore/ds_graph_weighted

pub(all) struct DsgraphweightedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_weighted_make_point(x : Double, y : Double) -> DsgraphweightedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_weighted_make_point3(x : Double, y : Double, z : Double) -> DsgraphweightedPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_weighted_point_x(pt : DsgraphweightedPoint) -> Double { pt.x }

pub fn ds_graph_weighted_point_y(pt : DsgraphweightedPoint) -> Double { pt.y }

pub fn ds_graph_weighted_point_z(pt : DsgraphweightedPoint) -> Double { pt.z }

pub fn ds_graph_weighted_point_label(pt : DsgraphweightedPoint) -> Int { pt.label }

pub fn ds_graph_weighted_point_dist(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_weighted_point_add(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_weighted_point_sub(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_weighted_point_scale(pt : DsgraphweightedPoint, s : Double) -> DsgraphweightedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_weighted_point_dot(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_weighted_point_cross(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_weighted_point_norm(pt : DsgraphweightedPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_weighted_point_normalize(pt : DsgraphweightedPoint) -> DsgraphweightedPoint {
  let n = ds_graph_weighted_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_weighted_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_weighted_point_negate(pt : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_weighted_point_mid(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_weighted_point_lerp(a : DsgraphweightedPoint, b : DsgraphweightedPoint, t : Double) -> DsgraphweightedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_weighted_point_to_string(pt : DsgraphweightedPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphweightedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_weighted_make_series(vals : Array[Double], name : String) -> DsgraphweightedSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_weighted_series_len(s : DsgraphweightedSeries) -> Int { s.vals.length() }

pub fn ds_graph_weighted_series_sum(s : DsgraphweightedSeries) -> Double { @_common.sum(s.vals) }

pub fn ds_graph_weighted_series_mean(s : DsgraphweightedSeries) -> Double { @_common.mean(s.vals) }

pub fn ds_graph_weighted_series_min(s : DsgraphweightedSeries) -> Double { @_common.min(s.vals) }

pub fn ds_graph_weighted_series_max(s : DsgraphweightedSeries) -> Double { @_common.max(s.vals) }

pub fn ds_graph_weighted_series_range(s : DsgraphweightedSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ds_graph_weighted_series_var(s : DsgraphweightedSeries) -> Double { @_common.variance(s.vals) }

pub fn ds_graph_weighted_series_std(s : DsgraphweightedSeries) -> Double { @_common.std(s.vals) }

pub fn ds_graph_weighted_series_median(s : DsgraphweightedSeries) -> Double { @_common.median(s.vals) }

pub fn ds_graph_weighted_series_scale(s : DsgraphweightedSeries, f : Double) -> DsgraphweightedSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn ds_graph_weighted_series_add(a : DsgraphweightedSeries, b : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_weighted_series_sub(a : DsgraphweightedSeries, b : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_weighted_series_normalize(s : DsgraphweightedSeries) -> DsgraphweightedSeries {
  let mn = ds_graph_weighted_series_min(s)
  let mx = ds_graph_weighted_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_weighted_series_cumsum(s : DsgraphweightedSeries) -> DsgraphweightedSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_weighted_series_to_string(s : DsgraphweightedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphweightedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_weighted_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphweightedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_weighted_matrix_identity(n : Int) -> DsgraphweightedMatrix {
  let m = ds_graph_weighted_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_weighted_matrix_get(m : DsgraphweightedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_weighted_matrix_transpose(m : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  let result = ds_graph_weighted_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_weighted_matrix_add(a : DsgraphweightedMatrix, b : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_weighted_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_weighted_matrix_scale(m : DsgraphweightedMatrix, s : Double) -> DsgraphweightedMatrix {
  let result = ds_graph_weighted_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_weighted_matrix_multiply(a : DsgraphweightedMatrix, b : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  if a.cols != b.rows { return ds_graph_weighted_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_weighted_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_weighted_matrix_trace(m : DsgraphweightedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_weighted_matrix_det(m : DsgraphweightedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_weighted_matrix_norm(m : DsgraphweightedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_weighted_matrix_to_string(m : DsgraphweightedMatrix) -> String {
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

pub(all) struct DsgraphweightedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_weighted_make_vector(comps : Array[Double]) -> DsgraphweightedVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_weighted_vector_zero(dim : Int) -> DsgraphweightedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_weighted_vector_add(a : DsgraphweightedVector, b : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn ds_graph_weighted_vector_sub(a : DsgraphweightedVector, b : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn ds_graph_weighted_vector_scale(v : DsgraphweightedVector, s : Double) -> DsgraphweightedVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn ds_graph_weighted_vector_dot(a : DsgraphweightedVector, b : DsgraphweightedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_weighted_vector_norm(v : DsgraphweightedVector) -> Double { @_common.sqrt(ds_graph_weighted_vector_dot(v, v)) }

pub fn ds_graph_weighted_vector_normalize(v : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = ds_graph_weighted_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_weighted_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_weighted_vector_dist(a : DsgraphweightedVector, b : DsgraphweightedVector) -> Double {
  ds_graph_weighted_vector_norm(ds_graph_weighted_vector_sub(a, b))
}

pub fn ds_graph_weighted_vector_to_string(v : DsgraphweightedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_weighted_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_weighted_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_weighted_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_weighted_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_weighted_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_weighted_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_weighted_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_weighted_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_weighted_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_weighted_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_weighted_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_weighted_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_weighted_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_weighted_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_weighted_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_weighted_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_weighted_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_weighted_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_weighted_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_weighted_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_weighted_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_weighted_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_weighted_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_weighted_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_weighted_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_weighted_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_weighted_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_weighted_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_weighted_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphweightedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_frame_make(size : Int) -> DsgraphweightedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_frame_len(s : DsgraphweightedFrame) -> Int { s.size }

pub fn ds_graph_weighted_frame_get(s : DsgraphweightedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_frame_set(s : DsgraphweightedFrame, i : Int, v : Double) -> DsgraphweightedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_frame_sum(s : DsgraphweightedFrame) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_frame_mean(s : DsgraphweightedFrame) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_frame_scale(s : DsgraphweightedFrame, f : Double) -> DsgraphweightedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_frame_add(a : DsgraphweightedFrame, b : DsgraphweightedFrame) -> DsgraphweightedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_frame_copy(s : DsgraphweightedFrame) -> DsgraphweightedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_frame_fill(s : DsgraphweightedFrame, v : Double) -> DsgraphweightedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_frame_min(s : DsgraphweightedFrame) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_frame_max(s : DsgraphweightedFrame) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_frame_to_string(s : DsgraphweightedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_table_make(size : Int) -> DsgraphweightedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_table_len(s : DsgraphweightedTable) -> Int { s.size }

pub fn ds_graph_weighted_table_get(s : DsgraphweightedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_table_set(s : DsgraphweightedTable, i : Int, v : Double) -> DsgraphweightedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_table_sum(s : DsgraphweightedTable) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_table_mean(s : DsgraphweightedTable) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_table_scale(s : DsgraphweightedTable, f : Double) -> DsgraphweightedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_table_add(a : DsgraphweightedTable, b : DsgraphweightedTable) -> DsgraphweightedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_table_copy(s : DsgraphweightedTable) -> DsgraphweightedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_table_fill(s : DsgraphweightedTable, v : Double) -> DsgraphweightedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_table_min(s : DsgraphweightedTable) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_table_max(s : DsgraphweightedTable) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_table_to_string(s : DsgraphweightedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_graphn_make(size : Int) -> DsgraphweightedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_graphn_len(s : DsgraphweightedGraphN) -> Int { s.size }

pub fn ds_graph_weighted_graphn_get(s : DsgraphweightedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_graphn_set(s : DsgraphweightedGraphN, i : Int, v : Double) -> DsgraphweightedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_graphn_sum(s : DsgraphweightedGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_graphn_mean(s : DsgraphweightedGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_graphn_scale(s : DsgraphweightedGraphN, f : Double) -> DsgraphweightedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_graphn_add(a : DsgraphweightedGraphN, b : DsgraphweightedGraphN) -> DsgraphweightedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_graphn_copy(s : DsgraphweightedGraphN) -> DsgraphweightedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_graphn_fill(s : DsgraphweightedGraphN, v : Double) -> DsgraphweightedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_graphn_min(s : DsgraphweightedGraphN) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_graphn_max(s : DsgraphweightedGraphN) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_graphn_to_string(s : DsgraphweightedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_node_make(size : Int) -> DsgraphweightedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_node_len(s : DsgraphweightedNode) -> Int { s.size }

pub fn ds_graph_weighted_node_get(s : DsgraphweightedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_node_set(s : DsgraphweightedNode, i : Int, v : Double) -> DsgraphweightedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_node_sum(s : DsgraphweightedNode) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_node_mean(s : DsgraphweightedNode) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_node_scale(s : DsgraphweightedNode, f : Double) -> DsgraphweightedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_node_add(a : DsgraphweightedNode, b : DsgraphweightedNode) -> DsgraphweightedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_node_copy(s : DsgraphweightedNode) -> DsgraphweightedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_node_fill(s : DsgraphweightedNode, v : Double) -> DsgraphweightedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_node_min(s : DsgraphweightedNode) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_node_max(s : DsgraphweightedNode) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_node_to_string(s : DsgraphweightedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_edge_make(size : Int) -> DsgraphweightedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_edge_len(s : DsgraphweightedEdge) -> Int { s.size }

pub fn ds_graph_weighted_edge_get(s : DsgraphweightedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_edge_set(s : DsgraphweightedEdge, i : Int, v : Double) -> DsgraphweightedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_edge_sum(s : DsgraphweightedEdge) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_edge_mean(s : DsgraphweightedEdge) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_edge_scale(s : DsgraphweightedEdge, f : Double) -> DsgraphweightedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_edge_add(a : DsgraphweightedEdge, b : DsgraphweightedEdge) -> DsgraphweightedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_edge_copy(s : DsgraphweightedEdge) -> DsgraphweightedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_edge_fill(s : DsgraphweightedEdge, v : Double) -> DsgraphweightedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_edge_min(s : DsgraphweightedEdge) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_edge_max(s : DsgraphweightedEdge) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_edge_to_string(s : DsgraphweightedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_path_make(size : Int) -> DsgraphweightedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_path_len(s : DsgraphweightedPath) -> Int { s.size }

pub fn ds_graph_weighted_path_get(s : DsgraphweightedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_path_set(s : DsgraphweightedPath, i : Int, v : Double) -> DsgraphweightedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_path_sum(s : DsgraphweightedPath) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_path_mean(s : DsgraphweightedPath) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_path_scale(s : DsgraphweightedPath, f : Double) -> DsgraphweightedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_path_add(a : DsgraphweightedPath, b : DsgraphweightedPath) -> DsgraphweightedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_path_copy(s : DsgraphweightedPath) -> DsgraphweightedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_path_fill(s : DsgraphweightedPath, v : Double) -> DsgraphweightedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_path_min(s : DsgraphweightedPath) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_path_max(s : DsgraphweightedPath) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_path_to_string(s : DsgraphweightedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_cluster_make(size : Int) -> DsgraphweightedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_cluster_len(s : DsgraphweightedCluster) -> Int { s.size }

pub fn ds_graph_weighted_cluster_get(s : DsgraphweightedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_cluster_set(s : DsgraphweightedCluster, i : Int, v : Double) -> DsgraphweightedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cluster_sum(s : DsgraphweightedCluster) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_cluster_mean(s : DsgraphweightedCluster) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_cluster_scale(s : DsgraphweightedCluster, f : Double) -> DsgraphweightedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cluster_add(a : DsgraphweightedCluster, b : DsgraphweightedCluster) -> DsgraphweightedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_cluster_copy(s : DsgraphweightedCluster) -> DsgraphweightedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cluster_fill(s : DsgraphweightedCluster, v : Double) -> DsgraphweightedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cluster_min(s : DsgraphweightedCluster) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_cluster_max(s : DsgraphweightedCluster) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_cluster_to_string(s : DsgraphweightedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_model_make(size : Int) -> DsgraphweightedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_model_len(s : DsgraphweightedModel) -> Int { s.size }

pub fn ds_graph_weighted_model_get(s : DsgraphweightedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_model_set(s : DsgraphweightedModel, i : Int, v : Double) -> DsgraphweightedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_model_sum(s : DsgraphweightedModel) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_model_mean(s : DsgraphweightedModel) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_model_scale(s : DsgraphweightedModel, f : Double) -> DsgraphweightedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_model_add(a : DsgraphweightedModel, b : DsgraphweightedModel) -> DsgraphweightedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_model_copy(s : DsgraphweightedModel) -> DsgraphweightedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_model_fill(s : DsgraphweightedModel, v : Double) -> DsgraphweightedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_model_min(s : DsgraphweightedModel) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_model_max(s : DsgraphweightedModel) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_model_to_string(s : DsgraphweightedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_layer_make(size : Int) -> DsgraphweightedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_layer_len(s : DsgraphweightedLayer) -> Int { s.size }

pub fn ds_graph_weighted_layer_get(s : DsgraphweightedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_layer_set(s : DsgraphweightedLayer, i : Int, v : Double) -> DsgraphweightedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_layer_sum(s : DsgraphweightedLayer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_layer_mean(s : DsgraphweightedLayer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_layer_scale(s : DsgraphweightedLayer, f : Double) -> DsgraphweightedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_layer_add(a : DsgraphweightedLayer, b : DsgraphweightedLayer) -> DsgraphweightedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_layer_copy(s : DsgraphweightedLayer) -> DsgraphweightedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_layer_fill(s : DsgraphweightedLayer, v : Double) -> DsgraphweightedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_layer_min(s : DsgraphweightedLayer) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_layer_max(s : DsgraphweightedLayer) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_layer_to_string(s : DsgraphweightedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_buffer_make(size : Int) -> DsgraphweightedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_buffer_len(s : DsgraphweightedBuffer) -> Int { s.size }

pub fn ds_graph_weighted_buffer_get(s : DsgraphweightedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_buffer_set(s : DsgraphweightedBuffer, i : Int, v : Double) -> DsgraphweightedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_buffer_sum(s : DsgraphweightedBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_buffer_mean(s : DsgraphweightedBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_buffer_scale(s : DsgraphweightedBuffer, f : Double) -> DsgraphweightedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_buffer_add(a : DsgraphweightedBuffer, b : DsgraphweightedBuffer) -> DsgraphweightedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_buffer_copy(s : DsgraphweightedBuffer) -> DsgraphweightedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_buffer_fill(s : DsgraphweightedBuffer, v : Double) -> DsgraphweightedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_buffer_min(s : DsgraphweightedBuffer) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_buffer_max(s : DsgraphweightedBuffer) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_buffer_to_string(s : DsgraphweightedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_cursor_make(size : Int) -> DsgraphweightedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_cursor_len(s : DsgraphweightedCursor) -> Int { s.size }

pub fn ds_graph_weighted_cursor_get(s : DsgraphweightedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_cursor_set(s : DsgraphweightedCursor, i : Int, v : Double) -> DsgraphweightedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cursor_sum(s : DsgraphweightedCursor) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_cursor_mean(s : DsgraphweightedCursor) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_cursor_scale(s : DsgraphweightedCursor, f : Double) -> DsgraphweightedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cursor_add(a : DsgraphweightedCursor, b : DsgraphweightedCursor) -> DsgraphweightedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_cursor_copy(s : DsgraphweightedCursor) -> DsgraphweightedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cursor_fill(s : DsgraphweightedCursor, v : Double) -> DsgraphweightedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_cursor_min(s : DsgraphweightedCursor) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_cursor_max(s : DsgraphweightedCursor) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_cursor_to_string(s : DsgraphweightedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_view_make(size : Int) -> DsgraphweightedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_view_len(s : DsgraphweightedView) -> Int { s.size }

pub fn ds_graph_weighted_view_get(s : DsgraphweightedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_view_set(s : DsgraphweightedView, i : Int, v : Double) -> DsgraphweightedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_view_sum(s : DsgraphweightedView) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_view_mean(s : DsgraphweightedView) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_view_scale(s : DsgraphweightedView, f : Double) -> DsgraphweightedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_view_add(a : DsgraphweightedView, b : DsgraphweightedView) -> DsgraphweightedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_view_copy(s : DsgraphweightedView) -> DsgraphweightedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_view_fill(s : DsgraphweightedView, v : Double) -> DsgraphweightedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_view_min(s : DsgraphweightedView) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_view_max(s : DsgraphweightedView) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_view_to_string(s : DsgraphweightedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_range_make(size : Int) -> DsgraphweightedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_range_len(s : DsgraphweightedRange) -> Int { s.size }

pub fn ds_graph_weighted_range_get(s : DsgraphweightedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_range_set(s : DsgraphweightedRange, i : Int, v : Double) -> DsgraphweightedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_range_sum(s : DsgraphweightedRange) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_range_mean(s : DsgraphweightedRange) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_range_scale(s : DsgraphweightedRange, f : Double) -> DsgraphweightedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_range_add(a : DsgraphweightedRange, b : DsgraphweightedRange) -> DsgraphweightedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_range_copy(s : DsgraphweightedRange) -> DsgraphweightedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_range_fill(s : DsgraphweightedRange, v : Double) -> DsgraphweightedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_range_min(s : DsgraphweightedRange) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_range_max(s : DsgraphweightedRange) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_range_to_string(s : DsgraphweightedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_slice_make(size : Int) -> DsgraphweightedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_slice_len(s : DsgraphweightedSlice) -> Int { s.size }

pub fn ds_graph_weighted_slice_get(s : DsgraphweightedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_slice_set(s : DsgraphweightedSlice, i : Int, v : Double) -> DsgraphweightedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_slice_sum(s : DsgraphweightedSlice) -> Double { @_common.sum(s.data) }

pub fn ds_graph_weighted_slice_mean(s : DsgraphweightedSlice) -> Double { @_common.mean(s.data) }

pub fn ds_graph_weighted_slice_scale(s : DsgraphweightedSlice, f : Double) -> DsgraphweightedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_slice_add(a : DsgraphweightedSlice, b : DsgraphweightedSlice) -> DsgraphweightedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_graph_weighted_slice_copy(s : DsgraphweightedSlice) -> DsgraphweightedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_slice_fill(s : DsgraphweightedSlice, v : Double) -> DsgraphweightedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_graph_weighted_slice_min(s : DsgraphweightedSlice) -> Double { @_common.min(s.data) }

pub fn ds_graph_weighted_slice_max(s : DsgraphweightedSlice) -> Double { @_common.max(s.data) }

pub fn ds_graph_weighted_slice_to_string(s : DsgraphweightedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

