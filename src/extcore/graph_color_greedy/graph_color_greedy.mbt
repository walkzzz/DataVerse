///===
/// extcore/graph_color_greedy

pub(all) struct GraphcolorgreedyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_greedy_make_point(x : Double, y : Double) -> GraphcolorgreedyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_greedy_make_point3(x : Double, y : Double, z : Double) -> GraphcolorgreedyPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_greedy_point_x(pt : GraphcolorgreedyPoint) -> Double { pt.x }

pub fn graph_color_greedy_point_y(pt : GraphcolorgreedyPoint) -> Double { pt.y }

pub fn graph_color_greedy_point_z(pt : GraphcolorgreedyPoint) -> Double { pt.z }

pub fn graph_color_greedy_point_label(pt : GraphcolorgreedyPoint) -> Int { pt.label }

pub fn graph_color_greedy_point_dist(a : GraphcolorgreedyPoint, b : GraphcolorgreedyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_greedy_point_add(a : GraphcolorgreedyPoint, b : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_greedy_point_sub(a : GraphcolorgreedyPoint, b : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_greedy_point_scale(pt : GraphcolorgreedyPoint, s : Double) -> GraphcolorgreedyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_greedy_point_dot(a : GraphcolorgreedyPoint, b : GraphcolorgreedyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_greedy_point_cross(a : GraphcolorgreedyPoint, b : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_greedy_point_norm(pt : GraphcolorgreedyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_greedy_point_normalize(pt : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  let n = graph_color_greedy_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_greedy_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_greedy_point_negate(pt : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_greedy_point_mid(a : GraphcolorgreedyPoint, b : GraphcolorgreedyPoint) -> GraphcolorgreedyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_greedy_point_lerp(a : GraphcolorgreedyPoint, b : GraphcolorgreedyPoint, t : Double) -> GraphcolorgreedyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_greedy_point_to_string(pt : GraphcolorgreedyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorgreedySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_greedy_make_series(vals : Array[Double], name : String) -> GraphcolorgreedySeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_greedy_series_len(s : GraphcolorgreedySeries) -> Int { s.vals.length() }

pub fn graph_color_greedy_series_sum(s : GraphcolorgreedySeries) -> Double { @_common.sum(s.vals) }

pub fn graph_color_greedy_series_mean(s : GraphcolorgreedySeries) -> Double { @_common.mean(s.vals) }

pub fn graph_color_greedy_series_min(s : GraphcolorgreedySeries) -> Double { @_common.min(s.vals) }

pub fn graph_color_greedy_series_max(s : GraphcolorgreedySeries) -> Double { @_common.max(s.vals) }

pub fn graph_color_greedy_series_range(s : GraphcolorgreedySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_color_greedy_series_var(s : GraphcolorgreedySeries) -> Double { @_common.variance(s.vals) }

pub fn graph_color_greedy_series_std(s : GraphcolorgreedySeries) -> Double { @_common.std(s.vals) }

pub fn graph_color_greedy_series_median(s : GraphcolorgreedySeries) -> Double { @_common.median(s.vals) }

pub fn graph_color_greedy_series_scale(s : GraphcolorgreedySeries, f : Double) -> GraphcolorgreedySeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_color_greedy_series_add(a : GraphcolorgreedySeries, b : GraphcolorgreedySeries) -> GraphcolorgreedySeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_greedy_series_sub(a : GraphcolorgreedySeries, b : GraphcolorgreedySeries) -> GraphcolorgreedySeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_greedy_series_normalize(s : GraphcolorgreedySeries) -> GraphcolorgreedySeries {
  let mn = graph_color_greedy_series_min(s)
  let mx = graph_color_greedy_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_greedy_series_cumsum(s : GraphcolorgreedySeries) -> GraphcolorgreedySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_greedy_series_to_string(s : GraphcolorgreedySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorgreedyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_greedy_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorgreedyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_greedy_matrix_identity(n : Int) -> GraphcolorgreedyMatrix {
  let m = graph_color_greedy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_greedy_matrix_get(m : GraphcolorgreedyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_greedy_matrix_transpose(m : GraphcolorgreedyMatrix) -> GraphcolorgreedyMatrix {
  let result = graph_color_greedy_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_greedy_matrix_add(a : GraphcolorgreedyMatrix, b : GraphcolorgreedyMatrix) -> GraphcolorgreedyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_greedy_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_greedy_matrix_scale(m : GraphcolorgreedyMatrix, s : Double) -> GraphcolorgreedyMatrix {
  let result = graph_color_greedy_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_greedy_matrix_multiply(a : GraphcolorgreedyMatrix, b : GraphcolorgreedyMatrix) -> GraphcolorgreedyMatrix {
  if a.cols != b.rows { return graph_color_greedy_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_greedy_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_greedy_matrix_trace(m : GraphcolorgreedyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_greedy_matrix_det(m : GraphcolorgreedyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_greedy_matrix_norm(m : GraphcolorgreedyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_greedy_matrix_to_string(m : GraphcolorgreedyMatrix) -> String {
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

pub(all) struct GraphcolorgreedyVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_greedy_make_vector(comps : Array[Double]) -> GraphcolorgreedyVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_greedy_vector_zero(dim : Int) -> GraphcolorgreedyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_greedy_vector_add(a : GraphcolorgreedyVector, b : GraphcolorgreedyVector) -> GraphcolorgreedyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_color_greedy_vector_sub(a : GraphcolorgreedyVector, b : GraphcolorgreedyVector) -> GraphcolorgreedyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_color_greedy_vector_scale(v : GraphcolorgreedyVector, s : Double) -> GraphcolorgreedyVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_color_greedy_vector_dot(a : GraphcolorgreedyVector, b : GraphcolorgreedyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_greedy_vector_norm(v : GraphcolorgreedyVector) -> Double { @_common.sqrt(graph_color_greedy_vector_dot(v, v)) }

pub fn graph_color_greedy_vector_normalize(v : GraphcolorgreedyVector) -> GraphcolorgreedyVector {
  let n = graph_color_greedy_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_greedy_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_greedy_vector_dist(a : GraphcolorgreedyVector, b : GraphcolorgreedyVector) -> Double {
  graph_color_greedy_vector_norm(graph_color_greedy_vector_sub(a, b))
}

pub fn graph_color_greedy_vector_to_string(v : GraphcolorgreedyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_greedy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_greedy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_greedy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_greedy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_greedy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_greedy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_greedy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_greedy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_greedy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_greedy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_greedy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_greedy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_greedy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_greedy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_greedy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_greedy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_greedy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_greedy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_greedy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_greedy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_greedy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_greedy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_greedy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_greedy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_greedy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_greedy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_greedy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_greedy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_greedy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorgreedyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_frame_make(size : Int) -> GraphcolorgreedyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_frame_len(s : GraphcolorgreedyFrame) -> Int { s.size }

pub fn graph_color_greedy_frame_get(s : GraphcolorgreedyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_frame_set(s : GraphcolorgreedyFrame, i : Int, v : Double) -> GraphcolorgreedyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_frame_sum(s : GraphcolorgreedyFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_frame_mean(s : GraphcolorgreedyFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_frame_scale(s : GraphcolorgreedyFrame, f : Double) -> GraphcolorgreedyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_frame_add(a : GraphcolorgreedyFrame, b : GraphcolorgreedyFrame) -> GraphcolorgreedyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_frame_copy(s : GraphcolorgreedyFrame) -> GraphcolorgreedyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_frame_fill(s : GraphcolorgreedyFrame, v : Double) -> GraphcolorgreedyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_frame_min(s : GraphcolorgreedyFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_frame_max(s : GraphcolorgreedyFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_frame_to_string(s : GraphcolorgreedyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_table_make(size : Int) -> GraphcolorgreedyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_table_len(s : GraphcolorgreedyTable) -> Int { s.size }

pub fn graph_color_greedy_table_get(s : GraphcolorgreedyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_table_set(s : GraphcolorgreedyTable, i : Int, v : Double) -> GraphcolorgreedyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_table_sum(s : GraphcolorgreedyTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_table_mean(s : GraphcolorgreedyTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_table_scale(s : GraphcolorgreedyTable, f : Double) -> GraphcolorgreedyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_table_add(a : GraphcolorgreedyTable, b : GraphcolorgreedyTable) -> GraphcolorgreedyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_table_copy(s : GraphcolorgreedyTable) -> GraphcolorgreedyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_table_fill(s : GraphcolorgreedyTable, v : Double) -> GraphcolorgreedyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_table_min(s : GraphcolorgreedyTable) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_table_max(s : GraphcolorgreedyTable) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_table_to_string(s : GraphcolorgreedyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_graphn_make(size : Int) -> GraphcolorgreedyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_graphn_len(s : GraphcolorgreedyGraphN) -> Int { s.size }

pub fn graph_color_greedy_graphn_get(s : GraphcolorgreedyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_graphn_set(s : GraphcolorgreedyGraphN, i : Int, v : Double) -> GraphcolorgreedyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_graphn_sum(s : GraphcolorgreedyGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_graphn_mean(s : GraphcolorgreedyGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_graphn_scale(s : GraphcolorgreedyGraphN, f : Double) -> GraphcolorgreedyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_graphn_add(a : GraphcolorgreedyGraphN, b : GraphcolorgreedyGraphN) -> GraphcolorgreedyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_graphn_copy(s : GraphcolorgreedyGraphN) -> GraphcolorgreedyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_graphn_fill(s : GraphcolorgreedyGraphN, v : Double) -> GraphcolorgreedyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_graphn_min(s : GraphcolorgreedyGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_graphn_max(s : GraphcolorgreedyGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_graphn_to_string(s : GraphcolorgreedyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_node_make(size : Int) -> GraphcolorgreedyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_node_len(s : GraphcolorgreedyNode) -> Int { s.size }

pub fn graph_color_greedy_node_get(s : GraphcolorgreedyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_node_set(s : GraphcolorgreedyNode, i : Int, v : Double) -> GraphcolorgreedyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_node_sum(s : GraphcolorgreedyNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_node_mean(s : GraphcolorgreedyNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_node_scale(s : GraphcolorgreedyNode, f : Double) -> GraphcolorgreedyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_node_add(a : GraphcolorgreedyNode, b : GraphcolorgreedyNode) -> GraphcolorgreedyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_node_copy(s : GraphcolorgreedyNode) -> GraphcolorgreedyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_node_fill(s : GraphcolorgreedyNode, v : Double) -> GraphcolorgreedyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_node_min(s : GraphcolorgreedyNode) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_node_max(s : GraphcolorgreedyNode) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_node_to_string(s : GraphcolorgreedyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_edge_make(size : Int) -> GraphcolorgreedyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_edge_len(s : GraphcolorgreedyEdge) -> Int { s.size }

pub fn graph_color_greedy_edge_get(s : GraphcolorgreedyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_edge_set(s : GraphcolorgreedyEdge, i : Int, v : Double) -> GraphcolorgreedyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_edge_sum(s : GraphcolorgreedyEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_edge_mean(s : GraphcolorgreedyEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_edge_scale(s : GraphcolorgreedyEdge, f : Double) -> GraphcolorgreedyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_edge_add(a : GraphcolorgreedyEdge, b : GraphcolorgreedyEdge) -> GraphcolorgreedyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_edge_copy(s : GraphcolorgreedyEdge) -> GraphcolorgreedyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_edge_fill(s : GraphcolorgreedyEdge, v : Double) -> GraphcolorgreedyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_edge_min(s : GraphcolorgreedyEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_edge_max(s : GraphcolorgreedyEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_edge_to_string(s : GraphcolorgreedyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_path_make(size : Int) -> GraphcolorgreedyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_path_len(s : GraphcolorgreedyPath) -> Int { s.size }

pub fn graph_color_greedy_path_get(s : GraphcolorgreedyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_path_set(s : GraphcolorgreedyPath, i : Int, v : Double) -> GraphcolorgreedyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_path_sum(s : GraphcolorgreedyPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_path_mean(s : GraphcolorgreedyPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_path_scale(s : GraphcolorgreedyPath, f : Double) -> GraphcolorgreedyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_path_add(a : GraphcolorgreedyPath, b : GraphcolorgreedyPath) -> GraphcolorgreedyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_path_copy(s : GraphcolorgreedyPath) -> GraphcolorgreedyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_path_fill(s : GraphcolorgreedyPath, v : Double) -> GraphcolorgreedyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_path_min(s : GraphcolorgreedyPath) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_path_max(s : GraphcolorgreedyPath) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_path_to_string(s : GraphcolorgreedyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_cluster_make(size : Int) -> GraphcolorgreedyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_cluster_len(s : GraphcolorgreedyCluster) -> Int { s.size }

pub fn graph_color_greedy_cluster_get(s : GraphcolorgreedyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_cluster_set(s : GraphcolorgreedyCluster, i : Int, v : Double) -> GraphcolorgreedyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_cluster_sum(s : GraphcolorgreedyCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_cluster_mean(s : GraphcolorgreedyCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_cluster_scale(s : GraphcolorgreedyCluster, f : Double) -> GraphcolorgreedyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_cluster_add(a : GraphcolorgreedyCluster, b : GraphcolorgreedyCluster) -> GraphcolorgreedyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_cluster_copy(s : GraphcolorgreedyCluster) -> GraphcolorgreedyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_cluster_fill(s : GraphcolorgreedyCluster, v : Double) -> GraphcolorgreedyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_cluster_min(s : GraphcolorgreedyCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_cluster_max(s : GraphcolorgreedyCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_cluster_to_string(s : GraphcolorgreedyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_model_make(size : Int) -> GraphcolorgreedyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_model_len(s : GraphcolorgreedyModel) -> Int { s.size }

pub fn graph_color_greedy_model_get(s : GraphcolorgreedyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_model_set(s : GraphcolorgreedyModel, i : Int, v : Double) -> GraphcolorgreedyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_model_sum(s : GraphcolorgreedyModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_model_mean(s : GraphcolorgreedyModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_model_scale(s : GraphcolorgreedyModel, f : Double) -> GraphcolorgreedyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_model_add(a : GraphcolorgreedyModel, b : GraphcolorgreedyModel) -> GraphcolorgreedyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_model_copy(s : GraphcolorgreedyModel) -> GraphcolorgreedyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_model_fill(s : GraphcolorgreedyModel, v : Double) -> GraphcolorgreedyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_model_min(s : GraphcolorgreedyModel) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_model_max(s : GraphcolorgreedyModel) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_model_to_string(s : GraphcolorgreedyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_layer_make(size : Int) -> GraphcolorgreedyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_layer_len(s : GraphcolorgreedyLayer) -> Int { s.size }

pub fn graph_color_greedy_layer_get(s : GraphcolorgreedyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_layer_set(s : GraphcolorgreedyLayer, i : Int, v : Double) -> GraphcolorgreedyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_layer_sum(s : GraphcolorgreedyLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_layer_mean(s : GraphcolorgreedyLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_layer_scale(s : GraphcolorgreedyLayer, f : Double) -> GraphcolorgreedyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_layer_add(a : GraphcolorgreedyLayer, b : GraphcolorgreedyLayer) -> GraphcolorgreedyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_layer_copy(s : GraphcolorgreedyLayer) -> GraphcolorgreedyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_layer_fill(s : GraphcolorgreedyLayer, v : Double) -> GraphcolorgreedyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_layer_min(s : GraphcolorgreedyLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_layer_max(s : GraphcolorgreedyLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_layer_to_string(s : GraphcolorgreedyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_buffer_make(size : Int) -> GraphcolorgreedyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_buffer_len(s : GraphcolorgreedyBuffer) -> Int { s.size }

pub fn graph_color_greedy_buffer_get(s : GraphcolorgreedyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_buffer_set(s : GraphcolorgreedyBuffer, i : Int, v : Double) -> GraphcolorgreedyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_buffer_sum(s : GraphcolorgreedyBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_buffer_mean(s : GraphcolorgreedyBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_buffer_scale(s : GraphcolorgreedyBuffer, f : Double) -> GraphcolorgreedyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_buffer_add(a : GraphcolorgreedyBuffer, b : GraphcolorgreedyBuffer) -> GraphcolorgreedyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_buffer_copy(s : GraphcolorgreedyBuffer) -> GraphcolorgreedyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_buffer_fill(s : GraphcolorgreedyBuffer, v : Double) -> GraphcolorgreedyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_buffer_min(s : GraphcolorgreedyBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_buffer_max(s : GraphcolorgreedyBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_buffer_to_string(s : GraphcolorgreedyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_cursor_make(size : Int) -> GraphcolorgreedyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_cursor_len(s : GraphcolorgreedyCursor) -> Int { s.size }

pub fn graph_color_greedy_cursor_get(s : GraphcolorgreedyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_cursor_set(s : GraphcolorgreedyCursor, i : Int, v : Double) -> GraphcolorgreedyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_cursor_sum(s : GraphcolorgreedyCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_cursor_mean(s : GraphcolorgreedyCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_cursor_scale(s : GraphcolorgreedyCursor, f : Double) -> GraphcolorgreedyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_cursor_add(a : GraphcolorgreedyCursor, b : GraphcolorgreedyCursor) -> GraphcolorgreedyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_cursor_copy(s : GraphcolorgreedyCursor) -> GraphcolorgreedyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_cursor_fill(s : GraphcolorgreedyCursor, v : Double) -> GraphcolorgreedyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_cursor_min(s : GraphcolorgreedyCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_cursor_max(s : GraphcolorgreedyCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_cursor_to_string(s : GraphcolorgreedyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_view_make(size : Int) -> GraphcolorgreedyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_view_len(s : GraphcolorgreedyView) -> Int { s.size }

pub fn graph_color_greedy_view_get(s : GraphcolorgreedyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_view_set(s : GraphcolorgreedyView, i : Int, v : Double) -> GraphcolorgreedyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_view_sum(s : GraphcolorgreedyView) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_view_mean(s : GraphcolorgreedyView) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_view_scale(s : GraphcolorgreedyView, f : Double) -> GraphcolorgreedyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_view_add(a : GraphcolorgreedyView, b : GraphcolorgreedyView) -> GraphcolorgreedyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_view_copy(s : GraphcolorgreedyView) -> GraphcolorgreedyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_view_fill(s : GraphcolorgreedyView, v : Double) -> GraphcolorgreedyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_view_min(s : GraphcolorgreedyView) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_view_max(s : GraphcolorgreedyView) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_view_to_string(s : GraphcolorgreedyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_range_make(size : Int) -> GraphcolorgreedyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_range_len(s : GraphcolorgreedyRange) -> Int { s.size }

pub fn graph_color_greedy_range_get(s : GraphcolorgreedyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_range_set(s : GraphcolorgreedyRange, i : Int, v : Double) -> GraphcolorgreedyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_range_sum(s : GraphcolorgreedyRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_range_mean(s : GraphcolorgreedyRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_range_scale(s : GraphcolorgreedyRange, f : Double) -> GraphcolorgreedyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_range_add(a : GraphcolorgreedyRange, b : GraphcolorgreedyRange) -> GraphcolorgreedyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_range_copy(s : GraphcolorgreedyRange) -> GraphcolorgreedyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_range_fill(s : GraphcolorgreedyRange, v : Double) -> GraphcolorgreedyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_range_min(s : GraphcolorgreedyRange) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_range_max(s : GraphcolorgreedyRange) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_range_to_string(s : GraphcolorgreedyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorgreedySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_greedy_slice_make(size : Int) -> GraphcolorgreedySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_greedy_slice_len(s : GraphcolorgreedySlice) -> Int { s.size }

pub fn graph_color_greedy_slice_get(s : GraphcolorgreedySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_greedy_slice_set(s : GraphcolorgreedySlice, i : Int, v : Double) -> GraphcolorgreedySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_slice_sum(s : GraphcolorgreedySlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_greedy_slice_mean(s : GraphcolorgreedySlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_greedy_slice_scale(s : GraphcolorgreedySlice, f : Double) -> GraphcolorgreedySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_slice_add(a : GraphcolorgreedySlice, b : GraphcolorgreedySlice) -> GraphcolorgreedySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_greedy_slice_copy(s : GraphcolorgreedySlice) -> GraphcolorgreedySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_slice_fill(s : GraphcolorgreedySlice, v : Double) -> GraphcolorgreedySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_greedy_slice_min(s : GraphcolorgreedySlice) -> Double { @_common.min(s.data) }

pub fn graph_color_greedy_slice_max(s : GraphcolorgreedySlice) -> Double { @_common.max(s.data) }

pub fn graph_color_greedy_slice_to_string(s : GraphcolorgreedySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

