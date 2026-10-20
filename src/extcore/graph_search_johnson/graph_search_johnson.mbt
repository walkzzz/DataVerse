///===
/// extcore/graph_search_johnson

pub(all) struct GraphsearchjohnsonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_johnson_make_point(x : Double, y : Double) -> GraphsearchjohnsonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_johnson_make_point3(x : Double, y : Double, z : Double) -> GraphsearchjohnsonPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_johnson_point_x(pt : GraphsearchjohnsonPoint) -> Double { pt.x }

pub fn graph_search_johnson_point_y(pt : GraphsearchjohnsonPoint) -> Double { pt.y }

pub fn graph_search_johnson_point_z(pt : GraphsearchjohnsonPoint) -> Double { pt.z }

pub fn graph_search_johnson_point_label(pt : GraphsearchjohnsonPoint) -> Int { pt.label }

pub fn graph_search_johnson_point_dist(a : GraphsearchjohnsonPoint, b : GraphsearchjohnsonPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_johnson_point_add(a : GraphsearchjohnsonPoint, b : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_johnson_point_sub(a : GraphsearchjohnsonPoint, b : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_johnson_point_scale(pt : GraphsearchjohnsonPoint, s : Double) -> GraphsearchjohnsonPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_johnson_point_dot(a : GraphsearchjohnsonPoint, b : GraphsearchjohnsonPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_johnson_point_cross(a : GraphsearchjohnsonPoint, b : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_johnson_point_norm(pt : GraphsearchjohnsonPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_johnson_point_normalize(pt : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  let n = graph_search_johnson_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_johnson_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_johnson_point_negate(pt : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_johnson_point_mid(a : GraphsearchjohnsonPoint, b : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_johnson_point_lerp(a : GraphsearchjohnsonPoint, b : GraphsearchjohnsonPoint, t : Double) -> GraphsearchjohnsonPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_johnson_point_to_string(pt : GraphsearchjohnsonPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_johnson_make_series(vals : Array[Double], name : String) -> GraphsearchjohnsonSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_johnson_series_len(s : GraphsearchjohnsonSeries) -> Int { s.vals.length() }

pub fn graph_search_johnson_series_sum(s : GraphsearchjohnsonSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_search_johnson_series_mean(s : GraphsearchjohnsonSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_search_johnson_series_min(s : GraphsearchjohnsonSeries) -> Double { @_common.min(s.vals) }

pub fn graph_search_johnson_series_max(s : GraphsearchjohnsonSeries) -> Double { @_common.max(s.vals) }

pub fn graph_search_johnson_series_range(s : GraphsearchjohnsonSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_search_johnson_series_var(s : GraphsearchjohnsonSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_search_johnson_series_std(s : GraphsearchjohnsonSeries) -> Double { @_common.std(s.vals) }

pub fn graph_search_johnson_series_median(s : GraphsearchjohnsonSeries) -> Double { @_common.median(s.vals) }

pub fn graph_search_johnson_series_scale(s : GraphsearchjohnsonSeries, f : Double) -> GraphsearchjohnsonSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_johnson_series_add(a : GraphsearchjohnsonSeries, b : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_johnson_series_sub(a : GraphsearchjohnsonSeries, b : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_johnson_series_normalize(s : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  let mn = graph_search_johnson_series_min(s)
  let mx = graph_search_johnson_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_johnson_series_cumsum(s : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_johnson_series_to_string(s : GraphsearchjohnsonSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchjohnsonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_johnson_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchjohnsonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_johnson_matrix_identity(n : Int) -> GraphsearchjohnsonMatrix {
  let m = graph_search_johnson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_johnson_matrix_get(m : GraphsearchjohnsonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_johnson_matrix_transpose(m : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  let result = graph_search_johnson_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_johnson_matrix_add(a : GraphsearchjohnsonMatrix, b : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_johnson_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_johnson_matrix_scale(m : GraphsearchjohnsonMatrix, s : Double) -> GraphsearchjohnsonMatrix {
  let result = graph_search_johnson_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_johnson_matrix_multiply(a : GraphsearchjohnsonMatrix, b : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  if a.cols != b.rows { return graph_search_johnson_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_johnson_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_johnson_matrix_trace(m : GraphsearchjohnsonMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_johnson_matrix_det(m : GraphsearchjohnsonMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_johnson_matrix_norm(m : GraphsearchjohnsonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_johnson_matrix_to_string(m : GraphsearchjohnsonMatrix) -> String {
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

pub(all) struct GraphsearchjohnsonVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_johnson_make_vector(comps : Array[Double]) -> GraphsearchjohnsonVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_johnson_vector_zero(dim : Int) -> GraphsearchjohnsonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_johnson_vector_add(a : GraphsearchjohnsonVector, b : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_johnson_vector_sub(a : GraphsearchjohnsonVector, b : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_johnson_vector_scale(v : GraphsearchjohnsonVector, s : Double) -> GraphsearchjohnsonVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_johnson_vector_dot(a : GraphsearchjohnsonVector, b : GraphsearchjohnsonVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_johnson_vector_norm(v : GraphsearchjohnsonVector) -> Double { @_common.sqrt(graph_search_johnson_vector_dot(v, v)) }

pub fn graph_search_johnson_vector_normalize(v : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = graph_search_johnson_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_johnson_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_johnson_vector_dist(a : GraphsearchjohnsonVector, b : GraphsearchjohnsonVector) -> Double {
  graph_search_johnson_vector_norm(graph_search_johnson_vector_sub(a, b))
}

pub fn graph_search_johnson_vector_to_string(v : GraphsearchjohnsonVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_johnson_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_johnson_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_johnson_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_johnson_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_johnson_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_johnson_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_johnson_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_johnson_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_johnson_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_johnson_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_johnson_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_johnson_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_johnson_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_johnson_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_johnson_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_johnson_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_johnson_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_johnson_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_johnson_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_johnson_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_johnson_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_johnson_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_johnson_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_johnson_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_johnson_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_johnson_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_johnson_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_johnson_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_johnson_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchjohnsonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_frame_make(size : Int) -> GraphsearchjohnsonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_frame_len(s : GraphsearchjohnsonFrame) -> Int { s.size }

pub fn graph_search_johnson_frame_get(s : GraphsearchjohnsonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_frame_set(s : GraphsearchjohnsonFrame, i : Int, v : Double) -> GraphsearchjohnsonFrame {
  let result = graph_search_johnson_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_frame_sum(s : GraphsearchjohnsonFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_frame_mean(s : GraphsearchjohnsonFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_frame_scale(s : GraphsearchjohnsonFrame, f : Double) -> GraphsearchjohnsonFrame {
  let result = graph_search_johnson_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_frame_add(a : GraphsearchjohnsonFrame, b : GraphsearchjohnsonFrame) -> GraphsearchjohnsonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_frame_copy(s : GraphsearchjohnsonFrame) -> GraphsearchjohnsonFrame {
  let result = graph_search_johnson_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_frame_fill(s : GraphsearchjohnsonFrame, v : Double) -> GraphsearchjohnsonFrame {
  let result = graph_search_johnson_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_frame_min(s : GraphsearchjohnsonFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_frame_max(s : GraphsearchjohnsonFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_frame_to_string(s : GraphsearchjohnsonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_table_make(size : Int) -> GraphsearchjohnsonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_table_len(s : GraphsearchjohnsonTable) -> Int { s.size }

pub fn graph_search_johnson_table_get(s : GraphsearchjohnsonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_table_set(s : GraphsearchjohnsonTable, i : Int, v : Double) -> GraphsearchjohnsonTable {
  let result = graph_search_johnson_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_table_sum(s : GraphsearchjohnsonTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_table_mean(s : GraphsearchjohnsonTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_table_scale(s : GraphsearchjohnsonTable, f : Double) -> GraphsearchjohnsonTable {
  let result = graph_search_johnson_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_table_add(a : GraphsearchjohnsonTable, b : GraphsearchjohnsonTable) -> GraphsearchjohnsonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_table_copy(s : GraphsearchjohnsonTable) -> GraphsearchjohnsonTable {
  let result = graph_search_johnson_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_table_fill(s : GraphsearchjohnsonTable, v : Double) -> GraphsearchjohnsonTable {
  let result = graph_search_johnson_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_table_min(s : GraphsearchjohnsonTable) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_table_max(s : GraphsearchjohnsonTable) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_table_to_string(s : GraphsearchjohnsonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_graphn_make(size : Int) -> GraphsearchjohnsonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_graphn_len(s : GraphsearchjohnsonGraphN) -> Int { s.size }

pub fn graph_search_johnson_graphn_get(s : GraphsearchjohnsonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_graphn_set(s : GraphsearchjohnsonGraphN, i : Int, v : Double) -> GraphsearchjohnsonGraphN {
  let result = graph_search_johnson_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_graphn_sum(s : GraphsearchjohnsonGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_graphn_mean(s : GraphsearchjohnsonGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_graphn_scale(s : GraphsearchjohnsonGraphN, f : Double) -> GraphsearchjohnsonGraphN {
  let result = graph_search_johnson_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_graphn_add(a : GraphsearchjohnsonGraphN, b : GraphsearchjohnsonGraphN) -> GraphsearchjohnsonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_graphn_copy(s : GraphsearchjohnsonGraphN) -> GraphsearchjohnsonGraphN {
  let result = graph_search_johnson_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_graphn_fill(s : GraphsearchjohnsonGraphN, v : Double) -> GraphsearchjohnsonGraphN {
  let result = graph_search_johnson_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_graphn_min(s : GraphsearchjohnsonGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_graphn_max(s : GraphsearchjohnsonGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_graphn_to_string(s : GraphsearchjohnsonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_node_make(size : Int) -> GraphsearchjohnsonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_node_len(s : GraphsearchjohnsonNode) -> Int { s.size }

pub fn graph_search_johnson_node_get(s : GraphsearchjohnsonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_node_set(s : GraphsearchjohnsonNode, i : Int, v : Double) -> GraphsearchjohnsonNode {
  let result = graph_search_johnson_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_node_sum(s : GraphsearchjohnsonNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_node_mean(s : GraphsearchjohnsonNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_node_scale(s : GraphsearchjohnsonNode, f : Double) -> GraphsearchjohnsonNode {
  let result = graph_search_johnson_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_node_add(a : GraphsearchjohnsonNode, b : GraphsearchjohnsonNode) -> GraphsearchjohnsonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_node_copy(s : GraphsearchjohnsonNode) -> GraphsearchjohnsonNode {
  let result = graph_search_johnson_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_node_fill(s : GraphsearchjohnsonNode, v : Double) -> GraphsearchjohnsonNode {
  let result = graph_search_johnson_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_node_min(s : GraphsearchjohnsonNode) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_node_max(s : GraphsearchjohnsonNode) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_node_to_string(s : GraphsearchjohnsonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_edge_make(size : Int) -> GraphsearchjohnsonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_edge_len(s : GraphsearchjohnsonEdge) -> Int { s.size }

pub fn graph_search_johnson_edge_get(s : GraphsearchjohnsonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_edge_set(s : GraphsearchjohnsonEdge, i : Int, v : Double) -> GraphsearchjohnsonEdge {
  let result = graph_search_johnson_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_edge_sum(s : GraphsearchjohnsonEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_edge_mean(s : GraphsearchjohnsonEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_edge_scale(s : GraphsearchjohnsonEdge, f : Double) -> GraphsearchjohnsonEdge {
  let result = graph_search_johnson_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_edge_add(a : GraphsearchjohnsonEdge, b : GraphsearchjohnsonEdge) -> GraphsearchjohnsonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_edge_copy(s : GraphsearchjohnsonEdge) -> GraphsearchjohnsonEdge {
  let result = graph_search_johnson_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_edge_fill(s : GraphsearchjohnsonEdge, v : Double) -> GraphsearchjohnsonEdge {
  let result = graph_search_johnson_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_edge_min(s : GraphsearchjohnsonEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_edge_max(s : GraphsearchjohnsonEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_edge_to_string(s : GraphsearchjohnsonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_path_make(size : Int) -> GraphsearchjohnsonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_path_len(s : GraphsearchjohnsonPath) -> Int { s.size }

pub fn graph_search_johnson_path_get(s : GraphsearchjohnsonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_path_set(s : GraphsearchjohnsonPath, i : Int, v : Double) -> GraphsearchjohnsonPath {
  let result = graph_search_johnson_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_path_sum(s : GraphsearchjohnsonPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_path_mean(s : GraphsearchjohnsonPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_path_scale(s : GraphsearchjohnsonPath, f : Double) -> GraphsearchjohnsonPath {
  let result = graph_search_johnson_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_path_add(a : GraphsearchjohnsonPath, b : GraphsearchjohnsonPath) -> GraphsearchjohnsonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_path_copy(s : GraphsearchjohnsonPath) -> GraphsearchjohnsonPath {
  let result = graph_search_johnson_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_path_fill(s : GraphsearchjohnsonPath, v : Double) -> GraphsearchjohnsonPath {
  let result = graph_search_johnson_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_path_min(s : GraphsearchjohnsonPath) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_path_max(s : GraphsearchjohnsonPath) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_path_to_string(s : GraphsearchjohnsonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_cluster_make(size : Int) -> GraphsearchjohnsonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_cluster_len(s : GraphsearchjohnsonCluster) -> Int { s.size }

pub fn graph_search_johnson_cluster_get(s : GraphsearchjohnsonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_cluster_set(s : GraphsearchjohnsonCluster, i : Int, v : Double) -> GraphsearchjohnsonCluster {
  let result = graph_search_johnson_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_cluster_sum(s : GraphsearchjohnsonCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_cluster_mean(s : GraphsearchjohnsonCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_cluster_scale(s : GraphsearchjohnsonCluster, f : Double) -> GraphsearchjohnsonCluster {
  let result = graph_search_johnson_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_cluster_add(a : GraphsearchjohnsonCluster, b : GraphsearchjohnsonCluster) -> GraphsearchjohnsonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_cluster_copy(s : GraphsearchjohnsonCluster) -> GraphsearchjohnsonCluster {
  let result = graph_search_johnson_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_cluster_fill(s : GraphsearchjohnsonCluster, v : Double) -> GraphsearchjohnsonCluster {
  let result = graph_search_johnson_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_cluster_min(s : GraphsearchjohnsonCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_cluster_max(s : GraphsearchjohnsonCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_cluster_to_string(s : GraphsearchjohnsonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_model_make(size : Int) -> GraphsearchjohnsonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_model_len(s : GraphsearchjohnsonModel) -> Int { s.size }

pub fn graph_search_johnson_model_get(s : GraphsearchjohnsonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_model_set(s : GraphsearchjohnsonModel, i : Int, v : Double) -> GraphsearchjohnsonModel {
  let result = graph_search_johnson_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_model_sum(s : GraphsearchjohnsonModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_model_mean(s : GraphsearchjohnsonModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_model_scale(s : GraphsearchjohnsonModel, f : Double) -> GraphsearchjohnsonModel {
  let result = graph_search_johnson_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_model_add(a : GraphsearchjohnsonModel, b : GraphsearchjohnsonModel) -> GraphsearchjohnsonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_model_copy(s : GraphsearchjohnsonModel) -> GraphsearchjohnsonModel {
  let result = graph_search_johnson_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_model_fill(s : GraphsearchjohnsonModel, v : Double) -> GraphsearchjohnsonModel {
  let result = graph_search_johnson_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_model_min(s : GraphsearchjohnsonModel) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_model_max(s : GraphsearchjohnsonModel) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_model_to_string(s : GraphsearchjohnsonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_layer_make(size : Int) -> GraphsearchjohnsonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_layer_len(s : GraphsearchjohnsonLayer) -> Int { s.size }

pub fn graph_search_johnson_layer_get(s : GraphsearchjohnsonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_layer_set(s : GraphsearchjohnsonLayer, i : Int, v : Double) -> GraphsearchjohnsonLayer {
  let result = graph_search_johnson_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_layer_sum(s : GraphsearchjohnsonLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_layer_mean(s : GraphsearchjohnsonLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_layer_scale(s : GraphsearchjohnsonLayer, f : Double) -> GraphsearchjohnsonLayer {
  let result = graph_search_johnson_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_layer_add(a : GraphsearchjohnsonLayer, b : GraphsearchjohnsonLayer) -> GraphsearchjohnsonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_layer_copy(s : GraphsearchjohnsonLayer) -> GraphsearchjohnsonLayer {
  let result = graph_search_johnson_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_layer_fill(s : GraphsearchjohnsonLayer, v : Double) -> GraphsearchjohnsonLayer {
  let result = graph_search_johnson_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_layer_min(s : GraphsearchjohnsonLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_layer_max(s : GraphsearchjohnsonLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_layer_to_string(s : GraphsearchjohnsonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_buffer_make(size : Int) -> GraphsearchjohnsonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_buffer_len(s : GraphsearchjohnsonBuffer) -> Int { s.size }

pub fn graph_search_johnson_buffer_get(s : GraphsearchjohnsonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_buffer_set(s : GraphsearchjohnsonBuffer, i : Int, v : Double) -> GraphsearchjohnsonBuffer {
  let result = graph_search_johnson_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_buffer_sum(s : GraphsearchjohnsonBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_buffer_mean(s : GraphsearchjohnsonBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_buffer_scale(s : GraphsearchjohnsonBuffer, f : Double) -> GraphsearchjohnsonBuffer {
  let result = graph_search_johnson_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_buffer_add(a : GraphsearchjohnsonBuffer, b : GraphsearchjohnsonBuffer) -> GraphsearchjohnsonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_buffer_copy(s : GraphsearchjohnsonBuffer) -> GraphsearchjohnsonBuffer {
  let result = graph_search_johnson_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_buffer_fill(s : GraphsearchjohnsonBuffer, v : Double) -> GraphsearchjohnsonBuffer {
  let result = graph_search_johnson_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_buffer_min(s : GraphsearchjohnsonBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_buffer_max(s : GraphsearchjohnsonBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_buffer_to_string(s : GraphsearchjohnsonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_cursor_make(size : Int) -> GraphsearchjohnsonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_cursor_len(s : GraphsearchjohnsonCursor) -> Int { s.size }

pub fn graph_search_johnson_cursor_get(s : GraphsearchjohnsonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_cursor_set(s : GraphsearchjohnsonCursor, i : Int, v : Double) -> GraphsearchjohnsonCursor {
  let result = graph_search_johnson_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_cursor_sum(s : GraphsearchjohnsonCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_cursor_mean(s : GraphsearchjohnsonCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_cursor_scale(s : GraphsearchjohnsonCursor, f : Double) -> GraphsearchjohnsonCursor {
  let result = graph_search_johnson_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_cursor_add(a : GraphsearchjohnsonCursor, b : GraphsearchjohnsonCursor) -> GraphsearchjohnsonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_cursor_copy(s : GraphsearchjohnsonCursor) -> GraphsearchjohnsonCursor {
  let result = graph_search_johnson_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_cursor_fill(s : GraphsearchjohnsonCursor, v : Double) -> GraphsearchjohnsonCursor {
  let result = graph_search_johnson_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_cursor_min(s : GraphsearchjohnsonCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_cursor_max(s : GraphsearchjohnsonCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_cursor_to_string(s : GraphsearchjohnsonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_view_make(size : Int) -> GraphsearchjohnsonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_view_len(s : GraphsearchjohnsonView) -> Int { s.size }

pub fn graph_search_johnson_view_get(s : GraphsearchjohnsonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_view_set(s : GraphsearchjohnsonView, i : Int, v : Double) -> GraphsearchjohnsonView {
  let result = graph_search_johnson_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_view_sum(s : GraphsearchjohnsonView) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_view_mean(s : GraphsearchjohnsonView) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_view_scale(s : GraphsearchjohnsonView, f : Double) -> GraphsearchjohnsonView {
  let result = graph_search_johnson_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_view_add(a : GraphsearchjohnsonView, b : GraphsearchjohnsonView) -> GraphsearchjohnsonView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_view_copy(s : GraphsearchjohnsonView) -> GraphsearchjohnsonView {
  let result = graph_search_johnson_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_view_fill(s : GraphsearchjohnsonView, v : Double) -> GraphsearchjohnsonView {
  let result = graph_search_johnson_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_view_min(s : GraphsearchjohnsonView) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_view_max(s : GraphsearchjohnsonView) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_view_to_string(s : GraphsearchjohnsonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_range_make(size : Int) -> GraphsearchjohnsonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_range_len(s : GraphsearchjohnsonRange) -> Int { s.size }

pub fn graph_search_johnson_range_get(s : GraphsearchjohnsonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_range_set(s : GraphsearchjohnsonRange, i : Int, v : Double) -> GraphsearchjohnsonRange {
  let result = graph_search_johnson_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_range_sum(s : GraphsearchjohnsonRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_range_mean(s : GraphsearchjohnsonRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_range_scale(s : GraphsearchjohnsonRange, f : Double) -> GraphsearchjohnsonRange {
  let result = graph_search_johnson_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_range_add(a : GraphsearchjohnsonRange, b : GraphsearchjohnsonRange) -> GraphsearchjohnsonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_range_copy(s : GraphsearchjohnsonRange) -> GraphsearchjohnsonRange {
  let result = graph_search_johnson_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_range_fill(s : GraphsearchjohnsonRange, v : Double) -> GraphsearchjohnsonRange {
  let result = graph_search_johnson_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_range_min(s : GraphsearchjohnsonRange) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_range_max(s : GraphsearchjohnsonRange) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_range_to_string(s : GraphsearchjohnsonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_slice_make(size : Int) -> GraphsearchjohnsonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_slice_len(s : GraphsearchjohnsonSlice) -> Int { s.size }

pub fn graph_search_johnson_slice_get(s : GraphsearchjohnsonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_slice_set(s : GraphsearchjohnsonSlice, i : Int, v : Double) -> GraphsearchjohnsonSlice {
  let result = graph_search_johnson_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_slice_sum(s : GraphsearchjohnsonSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_slice_mean(s : GraphsearchjohnsonSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_slice_scale(s : GraphsearchjohnsonSlice, f : Double) -> GraphsearchjohnsonSlice {
  let result = graph_search_johnson_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_johnson_slice_add(a : GraphsearchjohnsonSlice, b : GraphsearchjohnsonSlice) -> GraphsearchjohnsonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_johnson_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_johnson_slice_copy(s : GraphsearchjohnsonSlice) -> GraphsearchjohnsonSlice {
  let result = graph_search_johnson_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_johnson_slice_fill(s : GraphsearchjohnsonSlice, v : Double) -> GraphsearchjohnsonSlice {
  let result = graph_search_johnson_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_johnson_slice_min(s : GraphsearchjohnsonSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_slice_max(s : GraphsearchjohnsonSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_slice_to_string(s : GraphsearchjohnsonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

