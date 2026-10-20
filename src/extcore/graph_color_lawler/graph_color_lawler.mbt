///===
/// extcore/graph_color_lawler

pub(all) struct GraphcolorlawlerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_lawler_make_point(x : Double, y : Double) -> GraphcolorlawlerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_lawler_make_point3(x : Double, y : Double, z : Double) -> GraphcolorlawlerPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_lawler_point_x(pt : GraphcolorlawlerPoint) -> Double { pt.x }

pub fn graph_color_lawler_point_y(pt : GraphcolorlawlerPoint) -> Double { pt.y }

pub fn graph_color_lawler_point_z(pt : GraphcolorlawlerPoint) -> Double { pt.z }

pub fn graph_color_lawler_point_label(pt : GraphcolorlawlerPoint) -> Int { pt.label }

pub fn graph_color_lawler_point_dist(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_lawler_point_add(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_lawler_point_sub(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_lawler_point_scale(pt : GraphcolorlawlerPoint, s : Double) -> GraphcolorlawlerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_lawler_point_dot(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_lawler_point_cross(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_lawler_point_norm(pt : GraphcolorlawlerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_lawler_point_normalize(pt : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  let n = graph_color_lawler_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_lawler_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_lawler_point_negate(pt : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_lawler_point_mid(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_lawler_point_lerp(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint, t : Double) -> GraphcolorlawlerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_lawler_point_to_string(pt : GraphcolorlawlerPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorlawlerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_lawler_make_series(vals : Array[Double], name : String) -> GraphcolorlawlerSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_lawler_series_len(s : GraphcolorlawlerSeries) -> Int { s.vals.length() }

pub fn graph_color_lawler_series_sum(s : GraphcolorlawlerSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_color_lawler_series_mean(s : GraphcolorlawlerSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_color_lawler_series_min(s : GraphcolorlawlerSeries) -> Double { @_common.min(s.vals) }

pub fn graph_color_lawler_series_max(s : GraphcolorlawlerSeries) -> Double { @_common.max(s.vals) }

pub fn graph_color_lawler_series_range(s : GraphcolorlawlerSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_color_lawler_series_var(s : GraphcolorlawlerSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_color_lawler_series_std(s : GraphcolorlawlerSeries) -> Double { @_common.std(s.vals) }

pub fn graph_color_lawler_series_median(s : GraphcolorlawlerSeries) -> Double { @_common.median(s.vals) }

pub fn graph_color_lawler_series_scale(s : GraphcolorlawlerSeries, f : Double) -> GraphcolorlawlerSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_lawler_series_add(a : GraphcolorlawlerSeries, b : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_lawler_series_sub(a : GraphcolorlawlerSeries, b : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_lawler_series_normalize(s : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let mn = graph_color_lawler_series_min(s)
  let mx = graph_color_lawler_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_lawler_series_cumsum(s : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_lawler_series_to_string(s : GraphcolorlawlerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlawlerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_lawler_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorlawlerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_lawler_matrix_identity(n : Int) -> GraphcolorlawlerMatrix {
  let m = graph_color_lawler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_lawler_matrix_get(m : GraphcolorlawlerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_lawler_matrix_transpose(m : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  let result = graph_color_lawler_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_lawler_matrix_add(a : GraphcolorlawlerMatrix, b : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_lawler_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_lawler_matrix_scale(m : GraphcolorlawlerMatrix, s : Double) -> GraphcolorlawlerMatrix {
  let result = graph_color_lawler_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_lawler_matrix_multiply(a : GraphcolorlawlerMatrix, b : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  if a.cols != b.rows { return graph_color_lawler_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_lawler_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_lawler_matrix_trace(m : GraphcolorlawlerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_lawler_matrix_det(m : GraphcolorlawlerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_lawler_matrix_norm(m : GraphcolorlawlerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_lawler_matrix_to_string(m : GraphcolorlawlerMatrix) -> String {
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

pub(all) struct GraphcolorlawlerVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_lawler_make_vector(comps : Array[Double]) -> GraphcolorlawlerVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_lawler_vector_zero(dim : Int) -> GraphcolorlawlerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_lawler_vector_add(a : GraphcolorlawlerVector, b : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_lawler_vector_sub(a : GraphcolorlawlerVector, b : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_lawler_vector_scale(v : GraphcolorlawlerVector, s : Double) -> GraphcolorlawlerVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_lawler_vector_dot(a : GraphcolorlawlerVector, b : GraphcolorlawlerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_lawler_vector_norm(v : GraphcolorlawlerVector) -> Double { @_common.sqrt(graph_color_lawler_vector_dot(v, v)) }

pub fn graph_color_lawler_vector_normalize(v : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = graph_color_lawler_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_lawler_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_lawler_vector_dist(a : GraphcolorlawlerVector, b : GraphcolorlawlerVector) -> Double {
  graph_color_lawler_vector_norm(graph_color_lawler_vector_sub(a, b))
}

pub fn graph_color_lawler_vector_to_string(v : GraphcolorlawlerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_lawler_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_lawler_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_lawler_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_lawler_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_lawler_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_lawler_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_lawler_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_lawler_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_lawler_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_lawler_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_lawler_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_lawler_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_lawler_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_lawler_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_lawler_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_lawler_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_lawler_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_lawler_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_lawler_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_lawler_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_lawler_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_lawler_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_lawler_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_lawler_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_lawler_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_lawler_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_lawler_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_lawler_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_lawler_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorlawlerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_frame_make(size : Int) -> GraphcolorlawlerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_frame_len(s : GraphcolorlawlerFrame) -> Int { s.size }

pub fn graph_color_lawler_frame_get(s : GraphcolorlawlerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_frame_set(s : GraphcolorlawlerFrame, i : Int, v : Double) -> GraphcolorlawlerFrame {
  let result = graph_color_lawler_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_frame_sum(s : GraphcolorlawlerFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_frame_mean(s : GraphcolorlawlerFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_frame_scale(s : GraphcolorlawlerFrame, f : Double) -> GraphcolorlawlerFrame {
  let result = graph_color_lawler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_frame_add(a : GraphcolorlawlerFrame, b : GraphcolorlawlerFrame) -> GraphcolorlawlerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_frame_copy(s : GraphcolorlawlerFrame) -> GraphcolorlawlerFrame {
  let result = graph_color_lawler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_frame_fill(s : GraphcolorlawlerFrame, v : Double) -> GraphcolorlawlerFrame {
  let result = graph_color_lawler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_frame_min(s : GraphcolorlawlerFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_frame_max(s : GraphcolorlawlerFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_frame_to_string(s : GraphcolorlawlerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_table_make(size : Int) -> GraphcolorlawlerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_table_len(s : GraphcolorlawlerTable) -> Int { s.size }

pub fn graph_color_lawler_table_get(s : GraphcolorlawlerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_table_set(s : GraphcolorlawlerTable, i : Int, v : Double) -> GraphcolorlawlerTable {
  let result = graph_color_lawler_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_table_sum(s : GraphcolorlawlerTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_table_mean(s : GraphcolorlawlerTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_table_scale(s : GraphcolorlawlerTable, f : Double) -> GraphcolorlawlerTable {
  let result = graph_color_lawler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_table_add(a : GraphcolorlawlerTable, b : GraphcolorlawlerTable) -> GraphcolorlawlerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_table_copy(s : GraphcolorlawlerTable) -> GraphcolorlawlerTable {
  let result = graph_color_lawler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_table_fill(s : GraphcolorlawlerTable, v : Double) -> GraphcolorlawlerTable {
  let result = graph_color_lawler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_table_min(s : GraphcolorlawlerTable) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_table_max(s : GraphcolorlawlerTable) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_table_to_string(s : GraphcolorlawlerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_graphn_make(size : Int) -> GraphcolorlawlerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_graphn_len(s : GraphcolorlawlerGraphN) -> Int { s.size }

pub fn graph_color_lawler_graphn_get(s : GraphcolorlawlerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_graphn_set(s : GraphcolorlawlerGraphN, i : Int, v : Double) -> GraphcolorlawlerGraphN {
  let result = graph_color_lawler_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_graphn_sum(s : GraphcolorlawlerGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_graphn_mean(s : GraphcolorlawlerGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_graphn_scale(s : GraphcolorlawlerGraphN, f : Double) -> GraphcolorlawlerGraphN {
  let result = graph_color_lawler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_graphn_add(a : GraphcolorlawlerGraphN, b : GraphcolorlawlerGraphN) -> GraphcolorlawlerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_graphn_copy(s : GraphcolorlawlerGraphN) -> GraphcolorlawlerGraphN {
  let result = graph_color_lawler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_graphn_fill(s : GraphcolorlawlerGraphN, v : Double) -> GraphcolorlawlerGraphN {
  let result = graph_color_lawler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_graphn_min(s : GraphcolorlawlerGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_graphn_max(s : GraphcolorlawlerGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_graphn_to_string(s : GraphcolorlawlerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_node_make(size : Int) -> GraphcolorlawlerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_node_len(s : GraphcolorlawlerNode) -> Int { s.size }

pub fn graph_color_lawler_node_get(s : GraphcolorlawlerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_node_set(s : GraphcolorlawlerNode, i : Int, v : Double) -> GraphcolorlawlerNode {
  let result = graph_color_lawler_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_node_sum(s : GraphcolorlawlerNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_node_mean(s : GraphcolorlawlerNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_node_scale(s : GraphcolorlawlerNode, f : Double) -> GraphcolorlawlerNode {
  let result = graph_color_lawler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_node_add(a : GraphcolorlawlerNode, b : GraphcolorlawlerNode) -> GraphcolorlawlerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_node_copy(s : GraphcolorlawlerNode) -> GraphcolorlawlerNode {
  let result = graph_color_lawler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_node_fill(s : GraphcolorlawlerNode, v : Double) -> GraphcolorlawlerNode {
  let result = graph_color_lawler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_node_min(s : GraphcolorlawlerNode) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_node_max(s : GraphcolorlawlerNode) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_node_to_string(s : GraphcolorlawlerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_edge_make(size : Int) -> GraphcolorlawlerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_edge_len(s : GraphcolorlawlerEdge) -> Int { s.size }

pub fn graph_color_lawler_edge_get(s : GraphcolorlawlerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_edge_set(s : GraphcolorlawlerEdge, i : Int, v : Double) -> GraphcolorlawlerEdge {
  let result = graph_color_lawler_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_edge_sum(s : GraphcolorlawlerEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_edge_mean(s : GraphcolorlawlerEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_edge_scale(s : GraphcolorlawlerEdge, f : Double) -> GraphcolorlawlerEdge {
  let result = graph_color_lawler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_edge_add(a : GraphcolorlawlerEdge, b : GraphcolorlawlerEdge) -> GraphcolorlawlerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_edge_copy(s : GraphcolorlawlerEdge) -> GraphcolorlawlerEdge {
  let result = graph_color_lawler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_edge_fill(s : GraphcolorlawlerEdge, v : Double) -> GraphcolorlawlerEdge {
  let result = graph_color_lawler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_edge_min(s : GraphcolorlawlerEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_edge_max(s : GraphcolorlawlerEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_edge_to_string(s : GraphcolorlawlerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_path_make(size : Int) -> GraphcolorlawlerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_path_len(s : GraphcolorlawlerPath) -> Int { s.size }

pub fn graph_color_lawler_path_get(s : GraphcolorlawlerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_path_set(s : GraphcolorlawlerPath, i : Int, v : Double) -> GraphcolorlawlerPath {
  let result = graph_color_lawler_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_path_sum(s : GraphcolorlawlerPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_path_mean(s : GraphcolorlawlerPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_path_scale(s : GraphcolorlawlerPath, f : Double) -> GraphcolorlawlerPath {
  let result = graph_color_lawler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_path_add(a : GraphcolorlawlerPath, b : GraphcolorlawlerPath) -> GraphcolorlawlerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_path_copy(s : GraphcolorlawlerPath) -> GraphcolorlawlerPath {
  let result = graph_color_lawler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_path_fill(s : GraphcolorlawlerPath, v : Double) -> GraphcolorlawlerPath {
  let result = graph_color_lawler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_path_min(s : GraphcolorlawlerPath) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_path_max(s : GraphcolorlawlerPath) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_path_to_string(s : GraphcolorlawlerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_cluster_make(size : Int) -> GraphcolorlawlerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_cluster_len(s : GraphcolorlawlerCluster) -> Int { s.size }

pub fn graph_color_lawler_cluster_get(s : GraphcolorlawlerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_cluster_set(s : GraphcolorlawlerCluster, i : Int, v : Double) -> GraphcolorlawlerCluster {
  let result = graph_color_lawler_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_cluster_sum(s : GraphcolorlawlerCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_cluster_mean(s : GraphcolorlawlerCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_cluster_scale(s : GraphcolorlawlerCluster, f : Double) -> GraphcolorlawlerCluster {
  let result = graph_color_lawler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_cluster_add(a : GraphcolorlawlerCluster, b : GraphcolorlawlerCluster) -> GraphcolorlawlerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_cluster_copy(s : GraphcolorlawlerCluster) -> GraphcolorlawlerCluster {
  let result = graph_color_lawler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_cluster_fill(s : GraphcolorlawlerCluster, v : Double) -> GraphcolorlawlerCluster {
  let result = graph_color_lawler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_cluster_min(s : GraphcolorlawlerCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_cluster_max(s : GraphcolorlawlerCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_cluster_to_string(s : GraphcolorlawlerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_model_make(size : Int) -> GraphcolorlawlerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_model_len(s : GraphcolorlawlerModel) -> Int { s.size }

pub fn graph_color_lawler_model_get(s : GraphcolorlawlerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_model_set(s : GraphcolorlawlerModel, i : Int, v : Double) -> GraphcolorlawlerModel {
  let result = graph_color_lawler_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_model_sum(s : GraphcolorlawlerModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_model_mean(s : GraphcolorlawlerModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_model_scale(s : GraphcolorlawlerModel, f : Double) -> GraphcolorlawlerModel {
  let result = graph_color_lawler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_model_add(a : GraphcolorlawlerModel, b : GraphcolorlawlerModel) -> GraphcolorlawlerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_model_copy(s : GraphcolorlawlerModel) -> GraphcolorlawlerModel {
  let result = graph_color_lawler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_model_fill(s : GraphcolorlawlerModel, v : Double) -> GraphcolorlawlerModel {
  let result = graph_color_lawler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_model_min(s : GraphcolorlawlerModel) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_model_max(s : GraphcolorlawlerModel) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_model_to_string(s : GraphcolorlawlerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_layer_make(size : Int) -> GraphcolorlawlerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_layer_len(s : GraphcolorlawlerLayer) -> Int { s.size }

pub fn graph_color_lawler_layer_get(s : GraphcolorlawlerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_layer_set(s : GraphcolorlawlerLayer, i : Int, v : Double) -> GraphcolorlawlerLayer {
  let result = graph_color_lawler_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_layer_sum(s : GraphcolorlawlerLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_layer_mean(s : GraphcolorlawlerLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_layer_scale(s : GraphcolorlawlerLayer, f : Double) -> GraphcolorlawlerLayer {
  let result = graph_color_lawler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_layer_add(a : GraphcolorlawlerLayer, b : GraphcolorlawlerLayer) -> GraphcolorlawlerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_layer_copy(s : GraphcolorlawlerLayer) -> GraphcolorlawlerLayer {
  let result = graph_color_lawler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_layer_fill(s : GraphcolorlawlerLayer, v : Double) -> GraphcolorlawlerLayer {
  let result = graph_color_lawler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_layer_min(s : GraphcolorlawlerLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_layer_max(s : GraphcolorlawlerLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_layer_to_string(s : GraphcolorlawlerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_buffer_make(size : Int) -> GraphcolorlawlerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_buffer_len(s : GraphcolorlawlerBuffer) -> Int { s.size }

pub fn graph_color_lawler_buffer_get(s : GraphcolorlawlerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_buffer_set(s : GraphcolorlawlerBuffer, i : Int, v : Double) -> GraphcolorlawlerBuffer {
  let result = graph_color_lawler_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_buffer_sum(s : GraphcolorlawlerBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_buffer_mean(s : GraphcolorlawlerBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_buffer_scale(s : GraphcolorlawlerBuffer, f : Double) -> GraphcolorlawlerBuffer {
  let result = graph_color_lawler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_buffer_add(a : GraphcolorlawlerBuffer, b : GraphcolorlawlerBuffer) -> GraphcolorlawlerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_buffer_copy(s : GraphcolorlawlerBuffer) -> GraphcolorlawlerBuffer {
  let result = graph_color_lawler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_buffer_fill(s : GraphcolorlawlerBuffer, v : Double) -> GraphcolorlawlerBuffer {
  let result = graph_color_lawler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_buffer_min(s : GraphcolorlawlerBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_buffer_max(s : GraphcolorlawlerBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_buffer_to_string(s : GraphcolorlawlerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_cursor_make(size : Int) -> GraphcolorlawlerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_cursor_len(s : GraphcolorlawlerCursor) -> Int { s.size }

pub fn graph_color_lawler_cursor_get(s : GraphcolorlawlerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_cursor_set(s : GraphcolorlawlerCursor, i : Int, v : Double) -> GraphcolorlawlerCursor {
  let result = graph_color_lawler_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_cursor_sum(s : GraphcolorlawlerCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_cursor_mean(s : GraphcolorlawlerCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_cursor_scale(s : GraphcolorlawlerCursor, f : Double) -> GraphcolorlawlerCursor {
  let result = graph_color_lawler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_cursor_add(a : GraphcolorlawlerCursor, b : GraphcolorlawlerCursor) -> GraphcolorlawlerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_cursor_copy(s : GraphcolorlawlerCursor) -> GraphcolorlawlerCursor {
  let result = graph_color_lawler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_cursor_fill(s : GraphcolorlawlerCursor, v : Double) -> GraphcolorlawlerCursor {
  let result = graph_color_lawler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_cursor_min(s : GraphcolorlawlerCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_cursor_max(s : GraphcolorlawlerCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_cursor_to_string(s : GraphcolorlawlerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_view_make(size : Int) -> GraphcolorlawlerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_view_len(s : GraphcolorlawlerView) -> Int { s.size }

pub fn graph_color_lawler_view_get(s : GraphcolorlawlerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_view_set(s : GraphcolorlawlerView, i : Int, v : Double) -> GraphcolorlawlerView {
  let result = graph_color_lawler_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_view_sum(s : GraphcolorlawlerView) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_view_mean(s : GraphcolorlawlerView) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_view_scale(s : GraphcolorlawlerView, f : Double) -> GraphcolorlawlerView {
  let result = graph_color_lawler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_view_add(a : GraphcolorlawlerView, b : GraphcolorlawlerView) -> GraphcolorlawlerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_view_copy(s : GraphcolorlawlerView) -> GraphcolorlawlerView {
  let result = graph_color_lawler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_view_fill(s : GraphcolorlawlerView, v : Double) -> GraphcolorlawlerView {
  let result = graph_color_lawler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_view_min(s : GraphcolorlawlerView) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_view_max(s : GraphcolorlawlerView) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_view_to_string(s : GraphcolorlawlerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_range_make(size : Int) -> GraphcolorlawlerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_range_len(s : GraphcolorlawlerRange) -> Int { s.size }

pub fn graph_color_lawler_range_get(s : GraphcolorlawlerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_range_set(s : GraphcolorlawlerRange, i : Int, v : Double) -> GraphcolorlawlerRange {
  let result = graph_color_lawler_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_range_sum(s : GraphcolorlawlerRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_range_mean(s : GraphcolorlawlerRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_range_scale(s : GraphcolorlawlerRange, f : Double) -> GraphcolorlawlerRange {
  let result = graph_color_lawler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_range_add(a : GraphcolorlawlerRange, b : GraphcolorlawlerRange) -> GraphcolorlawlerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_range_copy(s : GraphcolorlawlerRange) -> GraphcolorlawlerRange {
  let result = graph_color_lawler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_range_fill(s : GraphcolorlawlerRange, v : Double) -> GraphcolorlawlerRange {
  let result = graph_color_lawler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_range_min(s : GraphcolorlawlerRange) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_range_max(s : GraphcolorlawlerRange) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_range_to_string(s : GraphcolorlawlerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_slice_make(size : Int) -> GraphcolorlawlerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_slice_len(s : GraphcolorlawlerSlice) -> Int { s.size }

pub fn graph_color_lawler_slice_get(s : GraphcolorlawlerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_slice_set(s : GraphcolorlawlerSlice, i : Int, v : Double) -> GraphcolorlawlerSlice {
  let result = graph_color_lawler_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_slice_sum(s : GraphcolorlawlerSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_slice_mean(s : GraphcolorlawlerSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_slice_scale(s : GraphcolorlawlerSlice, f : Double) -> GraphcolorlawlerSlice {
  let result = graph_color_lawler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_slice_add(a : GraphcolorlawlerSlice, b : GraphcolorlawlerSlice) -> GraphcolorlawlerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_slice_copy(s : GraphcolorlawlerSlice) -> GraphcolorlawlerSlice {
  let result = graph_color_lawler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_slice_fill(s : GraphcolorlawlerSlice, v : Double) -> GraphcolorlawlerSlice {
  let result = graph_color_lawler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_slice_min(s : GraphcolorlawlerSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_slice_max(s : GraphcolorlawlerSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_slice_to_string(s : GraphcolorlawlerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

