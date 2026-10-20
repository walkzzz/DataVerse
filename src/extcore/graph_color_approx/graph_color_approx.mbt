///===
/// extcore/graph_color_approx

pub(all) struct GraphcolorapproxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_approx_make_point(x : Double, y : Double) -> GraphcolorapproxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_approx_make_point3(x : Double, y : Double, z : Double) -> GraphcolorapproxPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_approx_point_x(pt : GraphcolorapproxPoint) -> Double { pt.x }

pub fn graph_color_approx_point_y(pt : GraphcolorapproxPoint) -> Double { pt.y }

pub fn graph_color_approx_point_z(pt : GraphcolorapproxPoint) -> Double { pt.z }

pub fn graph_color_approx_point_label(pt : GraphcolorapproxPoint) -> Int { pt.label }

pub fn graph_color_approx_point_dist(a : GraphcolorapproxPoint, b : GraphcolorapproxPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_approx_point_add(a : GraphcolorapproxPoint, b : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_approx_point_sub(a : GraphcolorapproxPoint, b : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_approx_point_scale(pt : GraphcolorapproxPoint, s : Double) -> GraphcolorapproxPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_approx_point_dot(a : GraphcolorapproxPoint, b : GraphcolorapproxPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_approx_point_cross(a : GraphcolorapproxPoint, b : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_approx_point_norm(pt : GraphcolorapproxPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_approx_point_normalize(pt : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  let n = graph_color_approx_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_approx_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_approx_point_negate(pt : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_approx_point_mid(a : GraphcolorapproxPoint, b : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_approx_point_lerp(a : GraphcolorapproxPoint, b : GraphcolorapproxPoint, t : Double) -> GraphcolorapproxPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_approx_point_to_string(pt : GraphcolorapproxPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorapproxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_approx_make_series(vals : Array[Double], name : String) -> GraphcolorapproxSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_approx_series_len(s : GraphcolorapproxSeries) -> Int { s.vals.length() }

pub fn graph_color_approx_series_sum(s : GraphcolorapproxSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_color_approx_series_mean(s : GraphcolorapproxSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_color_approx_series_min(s : GraphcolorapproxSeries) -> Double { @_common.min(s.vals) }

pub fn graph_color_approx_series_max(s : GraphcolorapproxSeries) -> Double { @_common.max(s.vals) }

pub fn graph_color_approx_series_range(s : GraphcolorapproxSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_color_approx_series_var(s : GraphcolorapproxSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_color_approx_series_std(s : GraphcolorapproxSeries) -> Double { @_common.std(s.vals) }

pub fn graph_color_approx_series_median(s : GraphcolorapproxSeries) -> Double { @_common.median(s.vals) }

pub fn graph_color_approx_series_scale(s : GraphcolorapproxSeries, f : Double) -> GraphcolorapproxSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn graph_color_approx_series_add(a : GraphcolorapproxSeries, b : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_approx_series_sub(a : GraphcolorapproxSeries, b : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_approx_series_normalize(s : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  let mn = graph_color_approx_series_min(s)
  let mx = graph_color_approx_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_approx_series_cumsum(s : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_approx_series_to_string(s : GraphcolorapproxSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorapproxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_approx_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorapproxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_approx_matrix_identity(n : Int) -> GraphcolorapproxMatrix {
  let m = graph_color_approx_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_approx_matrix_get(m : GraphcolorapproxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_approx_matrix_transpose(m : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  let result = graph_color_approx_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_approx_matrix_add(a : GraphcolorapproxMatrix, b : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_approx_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_approx_matrix_scale(m : GraphcolorapproxMatrix, s : Double) -> GraphcolorapproxMatrix {
  let result = graph_color_approx_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_approx_matrix_multiply(a : GraphcolorapproxMatrix, b : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  if a.cols != b.rows { return graph_color_approx_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_approx_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_approx_matrix_trace(m : GraphcolorapproxMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_approx_matrix_det(m : GraphcolorapproxMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_approx_matrix_norm(m : GraphcolorapproxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_approx_matrix_to_string(m : GraphcolorapproxMatrix) -> String {
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

pub(all) struct GraphcolorapproxVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_approx_make_vector(comps : Array[Double]) -> GraphcolorapproxVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_approx_vector_zero(dim : Int) -> GraphcolorapproxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_approx_vector_add(a : GraphcolorapproxVector, b : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn graph_color_approx_vector_sub(a : GraphcolorapproxVector, b : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn graph_color_approx_vector_scale(v : GraphcolorapproxVector, s : Double) -> GraphcolorapproxVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn graph_color_approx_vector_dot(a : GraphcolorapproxVector, b : GraphcolorapproxVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_approx_vector_norm(v : GraphcolorapproxVector) -> Double { @_common.sqrt(graph_color_approx_vector_dot(v, v)) }

pub fn graph_color_approx_vector_normalize(v : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = graph_color_approx_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_approx_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_approx_vector_dist(a : GraphcolorapproxVector, b : GraphcolorapproxVector) -> Double {
  graph_color_approx_vector_norm(graph_color_approx_vector_sub(a, b))
}

pub fn graph_color_approx_vector_to_string(v : GraphcolorapproxVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_approx_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_approx_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_approx_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_approx_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_approx_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_approx_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_approx_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_approx_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_approx_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_approx_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_approx_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_approx_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_approx_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_approx_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_approx_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_approx_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_approx_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_approx_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_approx_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_approx_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_approx_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_approx_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_approx_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_approx_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_approx_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_approx_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_approx_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_approx_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_approx_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorapproxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_frame_make(size : Int) -> GraphcolorapproxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_frame_len(s : GraphcolorapproxFrame) -> Int { s.size }

pub fn graph_color_approx_frame_get(s : GraphcolorapproxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_frame_set(s : GraphcolorapproxFrame, i : Int, v : Double) -> GraphcolorapproxFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_frame_sum(s : GraphcolorapproxFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_frame_mean(s : GraphcolorapproxFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_frame_scale(s : GraphcolorapproxFrame, f : Double) -> GraphcolorapproxFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_frame_add(a : GraphcolorapproxFrame, b : GraphcolorapproxFrame) -> GraphcolorapproxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_frame_copy(s : GraphcolorapproxFrame) -> GraphcolorapproxFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_frame_fill(s : GraphcolorapproxFrame, v : Double) -> GraphcolorapproxFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_frame_min(s : GraphcolorapproxFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_frame_max(s : GraphcolorapproxFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_frame_to_string(s : GraphcolorapproxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_table_make(size : Int) -> GraphcolorapproxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_table_len(s : GraphcolorapproxTable) -> Int { s.size }

pub fn graph_color_approx_table_get(s : GraphcolorapproxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_table_set(s : GraphcolorapproxTable, i : Int, v : Double) -> GraphcolorapproxTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_table_sum(s : GraphcolorapproxTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_table_mean(s : GraphcolorapproxTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_table_scale(s : GraphcolorapproxTable, f : Double) -> GraphcolorapproxTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_table_add(a : GraphcolorapproxTable, b : GraphcolorapproxTable) -> GraphcolorapproxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_table_copy(s : GraphcolorapproxTable) -> GraphcolorapproxTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_table_fill(s : GraphcolorapproxTable, v : Double) -> GraphcolorapproxTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_table_min(s : GraphcolorapproxTable) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_table_max(s : GraphcolorapproxTable) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_table_to_string(s : GraphcolorapproxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_graphn_make(size : Int) -> GraphcolorapproxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_graphn_len(s : GraphcolorapproxGraphN) -> Int { s.size }

pub fn graph_color_approx_graphn_get(s : GraphcolorapproxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_graphn_set(s : GraphcolorapproxGraphN, i : Int, v : Double) -> GraphcolorapproxGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_graphn_sum(s : GraphcolorapproxGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_graphn_mean(s : GraphcolorapproxGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_graphn_scale(s : GraphcolorapproxGraphN, f : Double) -> GraphcolorapproxGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_graphn_add(a : GraphcolorapproxGraphN, b : GraphcolorapproxGraphN) -> GraphcolorapproxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_graphn_copy(s : GraphcolorapproxGraphN) -> GraphcolorapproxGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_graphn_fill(s : GraphcolorapproxGraphN, v : Double) -> GraphcolorapproxGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_graphn_min(s : GraphcolorapproxGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_graphn_max(s : GraphcolorapproxGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_graphn_to_string(s : GraphcolorapproxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_node_make(size : Int) -> GraphcolorapproxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_node_len(s : GraphcolorapproxNode) -> Int { s.size }

pub fn graph_color_approx_node_get(s : GraphcolorapproxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_node_set(s : GraphcolorapproxNode, i : Int, v : Double) -> GraphcolorapproxNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_node_sum(s : GraphcolorapproxNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_node_mean(s : GraphcolorapproxNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_node_scale(s : GraphcolorapproxNode, f : Double) -> GraphcolorapproxNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_node_add(a : GraphcolorapproxNode, b : GraphcolorapproxNode) -> GraphcolorapproxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_node_copy(s : GraphcolorapproxNode) -> GraphcolorapproxNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_node_fill(s : GraphcolorapproxNode, v : Double) -> GraphcolorapproxNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_node_min(s : GraphcolorapproxNode) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_node_max(s : GraphcolorapproxNode) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_node_to_string(s : GraphcolorapproxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_edge_make(size : Int) -> GraphcolorapproxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_edge_len(s : GraphcolorapproxEdge) -> Int { s.size }

pub fn graph_color_approx_edge_get(s : GraphcolorapproxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_edge_set(s : GraphcolorapproxEdge, i : Int, v : Double) -> GraphcolorapproxEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_edge_sum(s : GraphcolorapproxEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_edge_mean(s : GraphcolorapproxEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_edge_scale(s : GraphcolorapproxEdge, f : Double) -> GraphcolorapproxEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_edge_add(a : GraphcolorapproxEdge, b : GraphcolorapproxEdge) -> GraphcolorapproxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_edge_copy(s : GraphcolorapproxEdge) -> GraphcolorapproxEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_edge_fill(s : GraphcolorapproxEdge, v : Double) -> GraphcolorapproxEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_edge_min(s : GraphcolorapproxEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_edge_max(s : GraphcolorapproxEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_edge_to_string(s : GraphcolorapproxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_path_make(size : Int) -> GraphcolorapproxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_path_len(s : GraphcolorapproxPath) -> Int { s.size }

pub fn graph_color_approx_path_get(s : GraphcolorapproxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_path_set(s : GraphcolorapproxPath, i : Int, v : Double) -> GraphcolorapproxPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_path_sum(s : GraphcolorapproxPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_path_mean(s : GraphcolorapproxPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_path_scale(s : GraphcolorapproxPath, f : Double) -> GraphcolorapproxPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_path_add(a : GraphcolorapproxPath, b : GraphcolorapproxPath) -> GraphcolorapproxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_path_copy(s : GraphcolorapproxPath) -> GraphcolorapproxPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_path_fill(s : GraphcolorapproxPath, v : Double) -> GraphcolorapproxPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_path_min(s : GraphcolorapproxPath) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_path_max(s : GraphcolorapproxPath) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_path_to_string(s : GraphcolorapproxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_cluster_make(size : Int) -> GraphcolorapproxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_cluster_len(s : GraphcolorapproxCluster) -> Int { s.size }

pub fn graph_color_approx_cluster_get(s : GraphcolorapproxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_cluster_set(s : GraphcolorapproxCluster, i : Int, v : Double) -> GraphcolorapproxCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cluster_sum(s : GraphcolorapproxCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_cluster_mean(s : GraphcolorapproxCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_cluster_scale(s : GraphcolorapproxCluster, f : Double) -> GraphcolorapproxCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cluster_add(a : GraphcolorapproxCluster, b : GraphcolorapproxCluster) -> GraphcolorapproxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_cluster_copy(s : GraphcolorapproxCluster) -> GraphcolorapproxCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cluster_fill(s : GraphcolorapproxCluster, v : Double) -> GraphcolorapproxCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cluster_min(s : GraphcolorapproxCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_cluster_max(s : GraphcolorapproxCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_cluster_to_string(s : GraphcolorapproxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_model_make(size : Int) -> GraphcolorapproxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_model_len(s : GraphcolorapproxModel) -> Int { s.size }

pub fn graph_color_approx_model_get(s : GraphcolorapproxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_model_set(s : GraphcolorapproxModel, i : Int, v : Double) -> GraphcolorapproxModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_model_sum(s : GraphcolorapproxModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_model_mean(s : GraphcolorapproxModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_model_scale(s : GraphcolorapproxModel, f : Double) -> GraphcolorapproxModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_model_add(a : GraphcolorapproxModel, b : GraphcolorapproxModel) -> GraphcolorapproxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_model_copy(s : GraphcolorapproxModel) -> GraphcolorapproxModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_model_fill(s : GraphcolorapproxModel, v : Double) -> GraphcolorapproxModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_model_min(s : GraphcolorapproxModel) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_model_max(s : GraphcolorapproxModel) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_model_to_string(s : GraphcolorapproxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_layer_make(size : Int) -> GraphcolorapproxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_layer_len(s : GraphcolorapproxLayer) -> Int { s.size }

pub fn graph_color_approx_layer_get(s : GraphcolorapproxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_layer_set(s : GraphcolorapproxLayer, i : Int, v : Double) -> GraphcolorapproxLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_layer_sum(s : GraphcolorapproxLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_layer_mean(s : GraphcolorapproxLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_layer_scale(s : GraphcolorapproxLayer, f : Double) -> GraphcolorapproxLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_layer_add(a : GraphcolorapproxLayer, b : GraphcolorapproxLayer) -> GraphcolorapproxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_layer_copy(s : GraphcolorapproxLayer) -> GraphcolorapproxLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_layer_fill(s : GraphcolorapproxLayer, v : Double) -> GraphcolorapproxLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_layer_min(s : GraphcolorapproxLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_layer_max(s : GraphcolorapproxLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_layer_to_string(s : GraphcolorapproxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_buffer_make(size : Int) -> GraphcolorapproxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_buffer_len(s : GraphcolorapproxBuffer) -> Int { s.size }

pub fn graph_color_approx_buffer_get(s : GraphcolorapproxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_buffer_set(s : GraphcolorapproxBuffer, i : Int, v : Double) -> GraphcolorapproxBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_buffer_sum(s : GraphcolorapproxBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_buffer_mean(s : GraphcolorapproxBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_buffer_scale(s : GraphcolorapproxBuffer, f : Double) -> GraphcolorapproxBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_buffer_add(a : GraphcolorapproxBuffer, b : GraphcolorapproxBuffer) -> GraphcolorapproxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_buffer_copy(s : GraphcolorapproxBuffer) -> GraphcolorapproxBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_buffer_fill(s : GraphcolorapproxBuffer, v : Double) -> GraphcolorapproxBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_buffer_min(s : GraphcolorapproxBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_buffer_max(s : GraphcolorapproxBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_buffer_to_string(s : GraphcolorapproxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_cursor_make(size : Int) -> GraphcolorapproxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_cursor_len(s : GraphcolorapproxCursor) -> Int { s.size }

pub fn graph_color_approx_cursor_get(s : GraphcolorapproxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_cursor_set(s : GraphcolorapproxCursor, i : Int, v : Double) -> GraphcolorapproxCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cursor_sum(s : GraphcolorapproxCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_cursor_mean(s : GraphcolorapproxCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_cursor_scale(s : GraphcolorapproxCursor, f : Double) -> GraphcolorapproxCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cursor_add(a : GraphcolorapproxCursor, b : GraphcolorapproxCursor) -> GraphcolorapproxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_cursor_copy(s : GraphcolorapproxCursor) -> GraphcolorapproxCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cursor_fill(s : GraphcolorapproxCursor, v : Double) -> GraphcolorapproxCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cursor_min(s : GraphcolorapproxCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_cursor_max(s : GraphcolorapproxCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_cursor_to_string(s : GraphcolorapproxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_view_make(size : Int) -> GraphcolorapproxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_view_len(s : GraphcolorapproxView) -> Int { s.size }

pub fn graph_color_approx_view_get(s : GraphcolorapproxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_view_set(s : GraphcolorapproxView, i : Int, v : Double) -> GraphcolorapproxView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_view_sum(s : GraphcolorapproxView) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_view_mean(s : GraphcolorapproxView) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_view_scale(s : GraphcolorapproxView, f : Double) -> GraphcolorapproxView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_view_add(a : GraphcolorapproxView, b : GraphcolorapproxView) -> GraphcolorapproxView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_view_copy(s : GraphcolorapproxView) -> GraphcolorapproxView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_view_fill(s : GraphcolorapproxView, v : Double) -> GraphcolorapproxView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_view_min(s : GraphcolorapproxView) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_view_max(s : GraphcolorapproxView) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_view_to_string(s : GraphcolorapproxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_range_make(size : Int) -> GraphcolorapproxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_range_len(s : GraphcolorapproxRange) -> Int { s.size }

pub fn graph_color_approx_range_get(s : GraphcolorapproxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_range_set(s : GraphcolorapproxRange, i : Int, v : Double) -> GraphcolorapproxRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_range_sum(s : GraphcolorapproxRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_range_mean(s : GraphcolorapproxRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_range_scale(s : GraphcolorapproxRange, f : Double) -> GraphcolorapproxRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_range_add(a : GraphcolorapproxRange, b : GraphcolorapproxRange) -> GraphcolorapproxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_range_copy(s : GraphcolorapproxRange) -> GraphcolorapproxRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_range_fill(s : GraphcolorapproxRange, v : Double) -> GraphcolorapproxRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_range_min(s : GraphcolorapproxRange) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_range_max(s : GraphcolorapproxRange) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_range_to_string(s : GraphcolorapproxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_slice_make(size : Int) -> GraphcolorapproxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_slice_len(s : GraphcolorapproxSlice) -> Int { s.size }

pub fn graph_color_approx_slice_get(s : GraphcolorapproxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_slice_set(s : GraphcolorapproxSlice, i : Int, v : Double) -> GraphcolorapproxSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_slice_sum(s : GraphcolorapproxSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_slice_mean(s : GraphcolorapproxSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_slice_scale(s : GraphcolorapproxSlice, f : Double) -> GraphcolorapproxSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_slice_add(a : GraphcolorapproxSlice, b : GraphcolorapproxSlice) -> GraphcolorapproxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_slice_copy(s : GraphcolorapproxSlice) -> GraphcolorapproxSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_slice_fill(s : GraphcolorapproxSlice, v : Double) -> GraphcolorapproxSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_slice_min(s : GraphcolorapproxSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_slice_max(s : GraphcolorapproxSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_slice_to_string(s : GraphcolorapproxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

