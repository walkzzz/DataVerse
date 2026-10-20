///===
/// extcore/graph_search_floyd

pub(all) struct GraphsearchfloydPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_floyd_make_point(x : Double, y : Double) -> GraphsearchfloydPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_floyd_make_point3(x : Double, y : Double, z : Double) -> GraphsearchfloydPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_floyd_point_x(pt : GraphsearchfloydPoint) -> Double { pt.x }

pub fn graph_search_floyd_point_y(pt : GraphsearchfloydPoint) -> Double { pt.y }

pub fn graph_search_floyd_point_z(pt : GraphsearchfloydPoint) -> Double { pt.z }

pub fn graph_search_floyd_point_label(pt : GraphsearchfloydPoint) -> Int { pt.label }

pub fn graph_search_floyd_point_dist(a : GraphsearchfloydPoint, b : GraphsearchfloydPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_floyd_point_add(a : GraphsearchfloydPoint, b : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_floyd_point_sub(a : GraphsearchfloydPoint, b : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_floyd_point_scale(pt : GraphsearchfloydPoint, s : Double) -> GraphsearchfloydPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_floyd_point_dot(a : GraphsearchfloydPoint, b : GraphsearchfloydPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_floyd_point_cross(a : GraphsearchfloydPoint, b : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_floyd_point_norm(pt : GraphsearchfloydPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_floyd_point_normalize(pt : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  let n = graph_search_floyd_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_floyd_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_floyd_point_negate(pt : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_floyd_point_mid(a : GraphsearchfloydPoint, b : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_floyd_point_lerp(a : GraphsearchfloydPoint, b : GraphsearchfloydPoint, t : Double) -> GraphsearchfloydPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_floyd_point_to_string(pt : GraphsearchfloydPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchfloydSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_floyd_make_series(vals : Array[Double], name : String) -> GraphsearchfloydSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_floyd_series_len(s : GraphsearchfloydSeries) -> Int { s.vals.length() }

pub fn graph_search_floyd_series_sum(s : GraphsearchfloydSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_search_floyd_series_mean(s : GraphsearchfloydSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_search_floyd_series_min(s : GraphsearchfloydSeries) -> Double { @_common.min(s.vals) }

pub fn graph_search_floyd_series_max(s : GraphsearchfloydSeries) -> Double { @_common.max(s.vals) }

pub fn graph_search_floyd_series_range(s : GraphsearchfloydSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_search_floyd_series_var(s : GraphsearchfloydSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_search_floyd_series_std(s : GraphsearchfloydSeries) -> Double { @_common.std(s.vals) }

pub fn graph_search_floyd_series_median(s : GraphsearchfloydSeries) -> Double { @_common.median(s.vals) }

pub fn graph_search_floyd_series_scale(s : GraphsearchfloydSeries, f : Double) -> GraphsearchfloydSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_floyd_series_add(a : GraphsearchfloydSeries, b : GraphsearchfloydSeries) -> GraphsearchfloydSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_floyd_series_sub(a : GraphsearchfloydSeries, b : GraphsearchfloydSeries) -> GraphsearchfloydSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_floyd_series_normalize(s : GraphsearchfloydSeries) -> GraphsearchfloydSeries {
  let mn = graph_search_floyd_series_min(s)
  let mx = graph_search_floyd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_floyd_series_cumsum(s : GraphsearchfloydSeries) -> GraphsearchfloydSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_floyd_series_to_string(s : GraphsearchfloydSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchfloydMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_floyd_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchfloydMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_floyd_matrix_identity(n : Int) -> GraphsearchfloydMatrix {
  let m = graph_search_floyd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_floyd_matrix_get(m : GraphsearchfloydMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_floyd_matrix_transpose(m : GraphsearchfloydMatrix) -> GraphsearchfloydMatrix {
  let result = graph_search_floyd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_floyd_matrix_add(a : GraphsearchfloydMatrix, b : GraphsearchfloydMatrix) -> GraphsearchfloydMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_floyd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_floyd_matrix_scale(m : GraphsearchfloydMatrix, s : Double) -> GraphsearchfloydMatrix {
  let result = graph_search_floyd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_floyd_matrix_multiply(a : GraphsearchfloydMatrix, b : GraphsearchfloydMatrix) -> GraphsearchfloydMatrix {
  if a.cols != b.rows { return graph_search_floyd_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_floyd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_floyd_matrix_trace(m : GraphsearchfloydMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_floyd_matrix_det(m : GraphsearchfloydMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_floyd_matrix_norm(m : GraphsearchfloydMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_floyd_matrix_to_string(m : GraphsearchfloydMatrix) -> String {
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

pub(all) struct GraphsearchfloydVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_floyd_make_vector(comps : Array[Double]) -> GraphsearchfloydVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_floyd_vector_zero(dim : Int) -> GraphsearchfloydVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_floyd_vector_add(a : GraphsearchfloydVector, b : GraphsearchfloydVector) -> GraphsearchfloydVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_floyd_vector_sub(a : GraphsearchfloydVector, b : GraphsearchfloydVector) -> GraphsearchfloydVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_floyd_vector_scale(v : GraphsearchfloydVector, s : Double) -> GraphsearchfloydVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_floyd_vector_dot(a : GraphsearchfloydVector, b : GraphsearchfloydVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_floyd_vector_norm(v : GraphsearchfloydVector) -> Double { @_common.sqrt(graph_search_floyd_vector_dot(v, v)) }

pub fn graph_search_floyd_vector_normalize(v : GraphsearchfloydVector) -> GraphsearchfloydVector {
  let n = graph_search_floyd_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_floyd_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_floyd_vector_dist(a : GraphsearchfloydVector, b : GraphsearchfloydVector) -> Double {
  graph_search_floyd_vector_norm(graph_search_floyd_vector_sub(a, b))
}

pub fn graph_search_floyd_vector_to_string(v : GraphsearchfloydVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_floyd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_floyd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_floyd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_floyd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_floyd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_floyd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_floyd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_floyd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_floyd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_floyd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_floyd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_floyd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_floyd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_floyd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_floyd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_floyd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_floyd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_floyd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_floyd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_floyd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_floyd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_floyd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_floyd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_floyd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_floyd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_floyd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_floyd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_floyd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_floyd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchfloydFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_frame_make(size : Int) -> GraphsearchfloydFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_frame_len(s : GraphsearchfloydFrame) -> Int { s.size }

pub fn graph_search_floyd_frame_get(s : GraphsearchfloydFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_frame_set(s : GraphsearchfloydFrame, i : Int, v : Double) -> GraphsearchfloydFrame {
  let result = graph_search_floyd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_frame_sum(s : GraphsearchfloydFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_frame_mean(s : GraphsearchfloydFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_frame_scale(s : GraphsearchfloydFrame, f : Double) -> GraphsearchfloydFrame {
  let result = graph_search_floyd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_frame_add(a : GraphsearchfloydFrame, b : GraphsearchfloydFrame) -> GraphsearchfloydFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_frame_copy(s : GraphsearchfloydFrame) -> GraphsearchfloydFrame {
  let result = graph_search_floyd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_frame_fill(s : GraphsearchfloydFrame, v : Double) -> GraphsearchfloydFrame {
  let result = graph_search_floyd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_frame_min(s : GraphsearchfloydFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_frame_max(s : GraphsearchfloydFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_frame_to_string(s : GraphsearchfloydFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_table_make(size : Int) -> GraphsearchfloydTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_table_len(s : GraphsearchfloydTable) -> Int { s.size }

pub fn graph_search_floyd_table_get(s : GraphsearchfloydTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_table_set(s : GraphsearchfloydTable, i : Int, v : Double) -> GraphsearchfloydTable {
  let result = graph_search_floyd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_table_sum(s : GraphsearchfloydTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_table_mean(s : GraphsearchfloydTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_table_scale(s : GraphsearchfloydTable, f : Double) -> GraphsearchfloydTable {
  let result = graph_search_floyd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_table_add(a : GraphsearchfloydTable, b : GraphsearchfloydTable) -> GraphsearchfloydTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_table_copy(s : GraphsearchfloydTable) -> GraphsearchfloydTable {
  let result = graph_search_floyd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_table_fill(s : GraphsearchfloydTable, v : Double) -> GraphsearchfloydTable {
  let result = graph_search_floyd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_table_min(s : GraphsearchfloydTable) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_table_max(s : GraphsearchfloydTable) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_table_to_string(s : GraphsearchfloydTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_graphn_make(size : Int) -> GraphsearchfloydGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_graphn_len(s : GraphsearchfloydGraphN) -> Int { s.size }

pub fn graph_search_floyd_graphn_get(s : GraphsearchfloydGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_graphn_set(s : GraphsearchfloydGraphN, i : Int, v : Double) -> GraphsearchfloydGraphN {
  let result = graph_search_floyd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_graphn_sum(s : GraphsearchfloydGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_graphn_mean(s : GraphsearchfloydGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_graphn_scale(s : GraphsearchfloydGraphN, f : Double) -> GraphsearchfloydGraphN {
  let result = graph_search_floyd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_graphn_add(a : GraphsearchfloydGraphN, b : GraphsearchfloydGraphN) -> GraphsearchfloydGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_graphn_copy(s : GraphsearchfloydGraphN) -> GraphsearchfloydGraphN {
  let result = graph_search_floyd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_graphn_fill(s : GraphsearchfloydGraphN, v : Double) -> GraphsearchfloydGraphN {
  let result = graph_search_floyd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_graphn_min(s : GraphsearchfloydGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_graphn_max(s : GraphsearchfloydGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_graphn_to_string(s : GraphsearchfloydGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_node_make(size : Int) -> GraphsearchfloydNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_node_len(s : GraphsearchfloydNode) -> Int { s.size }

pub fn graph_search_floyd_node_get(s : GraphsearchfloydNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_node_set(s : GraphsearchfloydNode, i : Int, v : Double) -> GraphsearchfloydNode {
  let result = graph_search_floyd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_node_sum(s : GraphsearchfloydNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_node_mean(s : GraphsearchfloydNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_node_scale(s : GraphsearchfloydNode, f : Double) -> GraphsearchfloydNode {
  let result = graph_search_floyd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_node_add(a : GraphsearchfloydNode, b : GraphsearchfloydNode) -> GraphsearchfloydNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_node_copy(s : GraphsearchfloydNode) -> GraphsearchfloydNode {
  let result = graph_search_floyd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_node_fill(s : GraphsearchfloydNode, v : Double) -> GraphsearchfloydNode {
  let result = graph_search_floyd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_node_min(s : GraphsearchfloydNode) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_node_max(s : GraphsearchfloydNode) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_node_to_string(s : GraphsearchfloydNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_edge_make(size : Int) -> GraphsearchfloydEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_edge_len(s : GraphsearchfloydEdge) -> Int { s.size }

pub fn graph_search_floyd_edge_get(s : GraphsearchfloydEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_edge_set(s : GraphsearchfloydEdge, i : Int, v : Double) -> GraphsearchfloydEdge {
  let result = graph_search_floyd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_edge_sum(s : GraphsearchfloydEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_edge_mean(s : GraphsearchfloydEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_edge_scale(s : GraphsearchfloydEdge, f : Double) -> GraphsearchfloydEdge {
  let result = graph_search_floyd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_edge_add(a : GraphsearchfloydEdge, b : GraphsearchfloydEdge) -> GraphsearchfloydEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_edge_copy(s : GraphsearchfloydEdge) -> GraphsearchfloydEdge {
  let result = graph_search_floyd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_edge_fill(s : GraphsearchfloydEdge, v : Double) -> GraphsearchfloydEdge {
  let result = graph_search_floyd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_edge_min(s : GraphsearchfloydEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_edge_max(s : GraphsearchfloydEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_edge_to_string(s : GraphsearchfloydEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_path_make(size : Int) -> GraphsearchfloydPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_path_len(s : GraphsearchfloydPath) -> Int { s.size }

pub fn graph_search_floyd_path_get(s : GraphsearchfloydPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_path_set(s : GraphsearchfloydPath, i : Int, v : Double) -> GraphsearchfloydPath {
  let result = graph_search_floyd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_path_sum(s : GraphsearchfloydPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_path_mean(s : GraphsearchfloydPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_path_scale(s : GraphsearchfloydPath, f : Double) -> GraphsearchfloydPath {
  let result = graph_search_floyd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_path_add(a : GraphsearchfloydPath, b : GraphsearchfloydPath) -> GraphsearchfloydPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_path_copy(s : GraphsearchfloydPath) -> GraphsearchfloydPath {
  let result = graph_search_floyd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_path_fill(s : GraphsearchfloydPath, v : Double) -> GraphsearchfloydPath {
  let result = graph_search_floyd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_path_min(s : GraphsearchfloydPath) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_path_max(s : GraphsearchfloydPath) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_path_to_string(s : GraphsearchfloydPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_cluster_make(size : Int) -> GraphsearchfloydCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_cluster_len(s : GraphsearchfloydCluster) -> Int { s.size }

pub fn graph_search_floyd_cluster_get(s : GraphsearchfloydCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_cluster_set(s : GraphsearchfloydCluster, i : Int, v : Double) -> GraphsearchfloydCluster {
  let result = graph_search_floyd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_cluster_sum(s : GraphsearchfloydCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_cluster_mean(s : GraphsearchfloydCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_cluster_scale(s : GraphsearchfloydCluster, f : Double) -> GraphsearchfloydCluster {
  let result = graph_search_floyd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_cluster_add(a : GraphsearchfloydCluster, b : GraphsearchfloydCluster) -> GraphsearchfloydCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_cluster_copy(s : GraphsearchfloydCluster) -> GraphsearchfloydCluster {
  let result = graph_search_floyd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_cluster_fill(s : GraphsearchfloydCluster, v : Double) -> GraphsearchfloydCluster {
  let result = graph_search_floyd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_cluster_min(s : GraphsearchfloydCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_cluster_max(s : GraphsearchfloydCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_cluster_to_string(s : GraphsearchfloydCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_model_make(size : Int) -> GraphsearchfloydModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_model_len(s : GraphsearchfloydModel) -> Int { s.size }

pub fn graph_search_floyd_model_get(s : GraphsearchfloydModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_model_set(s : GraphsearchfloydModel, i : Int, v : Double) -> GraphsearchfloydModel {
  let result = graph_search_floyd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_model_sum(s : GraphsearchfloydModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_model_mean(s : GraphsearchfloydModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_model_scale(s : GraphsearchfloydModel, f : Double) -> GraphsearchfloydModel {
  let result = graph_search_floyd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_model_add(a : GraphsearchfloydModel, b : GraphsearchfloydModel) -> GraphsearchfloydModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_model_copy(s : GraphsearchfloydModel) -> GraphsearchfloydModel {
  let result = graph_search_floyd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_model_fill(s : GraphsearchfloydModel, v : Double) -> GraphsearchfloydModel {
  let result = graph_search_floyd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_model_min(s : GraphsearchfloydModel) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_model_max(s : GraphsearchfloydModel) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_model_to_string(s : GraphsearchfloydModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_layer_make(size : Int) -> GraphsearchfloydLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_layer_len(s : GraphsearchfloydLayer) -> Int { s.size }

pub fn graph_search_floyd_layer_get(s : GraphsearchfloydLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_layer_set(s : GraphsearchfloydLayer, i : Int, v : Double) -> GraphsearchfloydLayer {
  let result = graph_search_floyd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_layer_sum(s : GraphsearchfloydLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_layer_mean(s : GraphsearchfloydLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_layer_scale(s : GraphsearchfloydLayer, f : Double) -> GraphsearchfloydLayer {
  let result = graph_search_floyd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_layer_add(a : GraphsearchfloydLayer, b : GraphsearchfloydLayer) -> GraphsearchfloydLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_layer_copy(s : GraphsearchfloydLayer) -> GraphsearchfloydLayer {
  let result = graph_search_floyd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_layer_fill(s : GraphsearchfloydLayer, v : Double) -> GraphsearchfloydLayer {
  let result = graph_search_floyd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_layer_min(s : GraphsearchfloydLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_layer_max(s : GraphsearchfloydLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_layer_to_string(s : GraphsearchfloydLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_buffer_make(size : Int) -> GraphsearchfloydBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_buffer_len(s : GraphsearchfloydBuffer) -> Int { s.size }

pub fn graph_search_floyd_buffer_get(s : GraphsearchfloydBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_buffer_set(s : GraphsearchfloydBuffer, i : Int, v : Double) -> GraphsearchfloydBuffer {
  let result = graph_search_floyd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_buffer_sum(s : GraphsearchfloydBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_buffer_mean(s : GraphsearchfloydBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_buffer_scale(s : GraphsearchfloydBuffer, f : Double) -> GraphsearchfloydBuffer {
  let result = graph_search_floyd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_buffer_add(a : GraphsearchfloydBuffer, b : GraphsearchfloydBuffer) -> GraphsearchfloydBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_buffer_copy(s : GraphsearchfloydBuffer) -> GraphsearchfloydBuffer {
  let result = graph_search_floyd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_buffer_fill(s : GraphsearchfloydBuffer, v : Double) -> GraphsearchfloydBuffer {
  let result = graph_search_floyd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_buffer_min(s : GraphsearchfloydBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_buffer_max(s : GraphsearchfloydBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_buffer_to_string(s : GraphsearchfloydBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_cursor_make(size : Int) -> GraphsearchfloydCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_cursor_len(s : GraphsearchfloydCursor) -> Int { s.size }

pub fn graph_search_floyd_cursor_get(s : GraphsearchfloydCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_cursor_set(s : GraphsearchfloydCursor, i : Int, v : Double) -> GraphsearchfloydCursor {
  let result = graph_search_floyd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_cursor_sum(s : GraphsearchfloydCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_cursor_mean(s : GraphsearchfloydCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_cursor_scale(s : GraphsearchfloydCursor, f : Double) -> GraphsearchfloydCursor {
  let result = graph_search_floyd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_cursor_add(a : GraphsearchfloydCursor, b : GraphsearchfloydCursor) -> GraphsearchfloydCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_cursor_copy(s : GraphsearchfloydCursor) -> GraphsearchfloydCursor {
  let result = graph_search_floyd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_cursor_fill(s : GraphsearchfloydCursor, v : Double) -> GraphsearchfloydCursor {
  let result = graph_search_floyd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_cursor_min(s : GraphsearchfloydCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_cursor_max(s : GraphsearchfloydCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_cursor_to_string(s : GraphsearchfloydCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_view_make(size : Int) -> GraphsearchfloydView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_view_len(s : GraphsearchfloydView) -> Int { s.size }

pub fn graph_search_floyd_view_get(s : GraphsearchfloydView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_view_set(s : GraphsearchfloydView, i : Int, v : Double) -> GraphsearchfloydView {
  let result = graph_search_floyd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_view_sum(s : GraphsearchfloydView) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_view_mean(s : GraphsearchfloydView) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_view_scale(s : GraphsearchfloydView, f : Double) -> GraphsearchfloydView {
  let result = graph_search_floyd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_view_add(a : GraphsearchfloydView, b : GraphsearchfloydView) -> GraphsearchfloydView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_view_copy(s : GraphsearchfloydView) -> GraphsearchfloydView {
  let result = graph_search_floyd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_view_fill(s : GraphsearchfloydView, v : Double) -> GraphsearchfloydView {
  let result = graph_search_floyd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_view_min(s : GraphsearchfloydView) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_view_max(s : GraphsearchfloydView) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_view_to_string(s : GraphsearchfloydView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_range_make(size : Int) -> GraphsearchfloydRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_range_len(s : GraphsearchfloydRange) -> Int { s.size }

pub fn graph_search_floyd_range_get(s : GraphsearchfloydRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_range_set(s : GraphsearchfloydRange, i : Int, v : Double) -> GraphsearchfloydRange {
  let result = graph_search_floyd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_range_sum(s : GraphsearchfloydRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_range_mean(s : GraphsearchfloydRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_range_scale(s : GraphsearchfloydRange, f : Double) -> GraphsearchfloydRange {
  let result = graph_search_floyd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_range_add(a : GraphsearchfloydRange, b : GraphsearchfloydRange) -> GraphsearchfloydRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_range_copy(s : GraphsearchfloydRange) -> GraphsearchfloydRange {
  let result = graph_search_floyd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_range_fill(s : GraphsearchfloydRange, v : Double) -> GraphsearchfloydRange {
  let result = graph_search_floyd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_range_min(s : GraphsearchfloydRange) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_range_max(s : GraphsearchfloydRange) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_range_to_string(s : GraphsearchfloydRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_slice_make(size : Int) -> GraphsearchfloydSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_slice_len(s : GraphsearchfloydSlice) -> Int { s.size }

pub fn graph_search_floyd_slice_get(s : GraphsearchfloydSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_slice_set(s : GraphsearchfloydSlice, i : Int, v : Double) -> GraphsearchfloydSlice {
  let result = graph_search_floyd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_slice_sum(s : GraphsearchfloydSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_slice_mean(s : GraphsearchfloydSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_slice_scale(s : GraphsearchfloydSlice, f : Double) -> GraphsearchfloydSlice {
  let result = graph_search_floyd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_floyd_slice_add(a : GraphsearchfloydSlice, b : GraphsearchfloydSlice) -> GraphsearchfloydSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_floyd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_floyd_slice_copy(s : GraphsearchfloydSlice) -> GraphsearchfloydSlice {
  let result = graph_search_floyd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_floyd_slice_fill(s : GraphsearchfloydSlice, v : Double) -> GraphsearchfloydSlice {
  let result = graph_search_floyd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_floyd_slice_min(s : GraphsearchfloydSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_slice_max(s : GraphsearchfloydSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_slice_to_string(s : GraphsearchfloydSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

