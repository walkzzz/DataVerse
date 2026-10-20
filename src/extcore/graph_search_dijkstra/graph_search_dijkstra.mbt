///===
/// extcore/graph_search_dijkstra

pub(all) struct GraphsearchdijkstraPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_dijkstra_make_point(x : Double, y : Double) -> GraphsearchdijkstraPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_dijkstra_make_point3(x : Double, y : Double, z : Double) -> GraphsearchdijkstraPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_dijkstra_point_x(pt : GraphsearchdijkstraPoint) -> Double { pt.x }

pub fn graph_search_dijkstra_point_y(pt : GraphsearchdijkstraPoint) -> Double { pt.y }

pub fn graph_search_dijkstra_point_z(pt : GraphsearchdijkstraPoint) -> Double { pt.z }

pub fn graph_search_dijkstra_point_label(pt : GraphsearchdijkstraPoint) -> Int { pt.label }

pub fn graph_search_dijkstra_point_dist(a : GraphsearchdijkstraPoint, b : GraphsearchdijkstraPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_dijkstra_point_add(a : GraphsearchdijkstraPoint, b : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_dijkstra_point_sub(a : GraphsearchdijkstraPoint, b : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_dijkstra_point_scale(pt : GraphsearchdijkstraPoint, s : Double) -> GraphsearchdijkstraPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_dijkstra_point_dot(a : GraphsearchdijkstraPoint, b : GraphsearchdijkstraPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_dijkstra_point_cross(a : GraphsearchdijkstraPoint, b : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_dijkstra_point_norm(pt : GraphsearchdijkstraPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_dijkstra_point_normalize(pt : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  let n = graph_search_dijkstra_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_dijkstra_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_dijkstra_point_negate(pt : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_dijkstra_point_mid(a : GraphsearchdijkstraPoint, b : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_dijkstra_point_lerp(a : GraphsearchdijkstraPoint, b : GraphsearchdijkstraPoint, t : Double) -> GraphsearchdijkstraPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_dijkstra_point_to_string(pt : GraphsearchdijkstraPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_dijkstra_make_series(vals : Array[Double], name : String) -> GraphsearchdijkstraSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_dijkstra_series_len(s : GraphsearchdijkstraSeries) -> Int { s.vals.length() }

pub fn graph_search_dijkstra_series_sum(s : GraphsearchdijkstraSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_search_dijkstra_series_mean(s : GraphsearchdijkstraSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_search_dijkstra_series_min(s : GraphsearchdijkstraSeries) -> Double { @_common.min(s.vals) }

pub fn graph_search_dijkstra_series_max(s : GraphsearchdijkstraSeries) -> Double { @_common.max(s.vals) }

pub fn graph_search_dijkstra_series_range(s : GraphsearchdijkstraSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_search_dijkstra_series_var(s : GraphsearchdijkstraSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_search_dijkstra_series_std(s : GraphsearchdijkstraSeries) -> Double { @_common.std(s.vals) }

pub fn graph_search_dijkstra_series_median(s : GraphsearchdijkstraSeries) -> Double { @_common.median(s.vals) }

pub fn graph_search_dijkstra_series_scale(s : GraphsearchdijkstraSeries, f : Double) -> GraphsearchdijkstraSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_dijkstra_series_add(a : GraphsearchdijkstraSeries, b : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_dijkstra_series_sub(a : GraphsearchdijkstraSeries, b : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_dijkstra_series_normalize(s : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  let mn = graph_search_dijkstra_series_min(s)
  let mx = graph_search_dijkstra_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_dijkstra_series_cumsum(s : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_dijkstra_series_to_string(s : GraphsearchdijkstraSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchdijkstraMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_dijkstra_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchdijkstraMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_dijkstra_matrix_identity(n : Int) -> GraphsearchdijkstraMatrix {
  let m = graph_search_dijkstra_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_dijkstra_matrix_get(m : GraphsearchdijkstraMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_dijkstra_matrix_transpose(m : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  let result = graph_search_dijkstra_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_dijkstra_matrix_add(a : GraphsearchdijkstraMatrix, b : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_dijkstra_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_dijkstra_matrix_scale(m : GraphsearchdijkstraMatrix, s : Double) -> GraphsearchdijkstraMatrix {
  let result = graph_search_dijkstra_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_dijkstra_matrix_multiply(a : GraphsearchdijkstraMatrix, b : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  if a.cols != b.rows { return graph_search_dijkstra_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_dijkstra_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_dijkstra_matrix_trace(m : GraphsearchdijkstraMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_dijkstra_matrix_det(m : GraphsearchdijkstraMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_dijkstra_matrix_norm(m : GraphsearchdijkstraMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_dijkstra_matrix_to_string(m : GraphsearchdijkstraMatrix) -> String {
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

pub(all) struct GraphsearchdijkstraVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_dijkstra_make_vector(comps : Array[Double]) -> GraphsearchdijkstraVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_dijkstra_vector_zero(dim : Int) -> GraphsearchdijkstraVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_dijkstra_vector_add(a : GraphsearchdijkstraVector, b : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_dijkstra_vector_sub(a : GraphsearchdijkstraVector, b : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_dijkstra_vector_scale(v : GraphsearchdijkstraVector, s : Double) -> GraphsearchdijkstraVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_dijkstra_vector_dot(a : GraphsearchdijkstraVector, b : GraphsearchdijkstraVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_dijkstra_vector_norm(v : GraphsearchdijkstraVector) -> Double { @_common.sqrt(graph_search_dijkstra_vector_dot(v, v)) }

pub fn graph_search_dijkstra_vector_normalize(v : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = graph_search_dijkstra_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_dijkstra_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_dijkstra_vector_dist(a : GraphsearchdijkstraVector, b : GraphsearchdijkstraVector) -> Double {
  graph_search_dijkstra_vector_norm(graph_search_dijkstra_vector_sub(a, b))
}

pub fn graph_search_dijkstra_vector_to_string(v : GraphsearchdijkstraVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_dijkstra_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_dijkstra_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_dijkstra_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_dijkstra_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_dijkstra_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_dijkstra_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_dijkstra_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_dijkstra_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_dijkstra_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_dijkstra_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_dijkstra_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_dijkstra_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_dijkstra_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_dijkstra_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_dijkstra_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_dijkstra_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_dijkstra_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_dijkstra_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_dijkstra_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_dijkstra_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_dijkstra_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_dijkstra_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_dijkstra_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_dijkstra_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_dijkstra_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_dijkstra_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_dijkstra_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_dijkstra_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_dijkstra_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchdijkstraFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_frame_make(size : Int) -> GraphsearchdijkstraFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_frame_len(s : GraphsearchdijkstraFrame) -> Int { s.size }

pub fn graph_search_dijkstra_frame_get(s : GraphsearchdijkstraFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_frame_set(s : GraphsearchdijkstraFrame, i : Int, v : Double) -> GraphsearchdijkstraFrame {
  let result = graph_search_dijkstra_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_frame_sum(s : GraphsearchdijkstraFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_frame_mean(s : GraphsearchdijkstraFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_frame_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_frame_scale(s : GraphsearchdijkstraFrame, f : Double) -> GraphsearchdijkstraFrame {
  let result = graph_search_dijkstra_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_frame_add(a : GraphsearchdijkstraFrame, b : GraphsearchdijkstraFrame) -> GraphsearchdijkstraFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_frame_copy(s : GraphsearchdijkstraFrame) -> GraphsearchdijkstraFrame {
  let result = graph_search_dijkstra_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_frame_fill(s : GraphsearchdijkstraFrame, v : Double) -> GraphsearchdijkstraFrame {
  let result = graph_search_dijkstra_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_frame_min(s : GraphsearchdijkstraFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_frame_max(s : GraphsearchdijkstraFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_frame_to_string(s : GraphsearchdijkstraFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_table_make(size : Int) -> GraphsearchdijkstraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_table_len(s : GraphsearchdijkstraTable) -> Int { s.size }

pub fn graph_search_dijkstra_table_get(s : GraphsearchdijkstraTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_table_set(s : GraphsearchdijkstraTable, i : Int, v : Double) -> GraphsearchdijkstraTable {
  let result = graph_search_dijkstra_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_table_sum(s : GraphsearchdijkstraTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_table_mean(s : GraphsearchdijkstraTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_table_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_table_scale(s : GraphsearchdijkstraTable, f : Double) -> GraphsearchdijkstraTable {
  let result = graph_search_dijkstra_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_table_add(a : GraphsearchdijkstraTable, b : GraphsearchdijkstraTable) -> GraphsearchdijkstraTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_table_copy(s : GraphsearchdijkstraTable) -> GraphsearchdijkstraTable {
  let result = graph_search_dijkstra_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_table_fill(s : GraphsearchdijkstraTable, v : Double) -> GraphsearchdijkstraTable {
  let result = graph_search_dijkstra_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_table_min(s : GraphsearchdijkstraTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_table_max(s : GraphsearchdijkstraTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_table_to_string(s : GraphsearchdijkstraTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_graphn_make(size : Int) -> GraphsearchdijkstraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_graphn_len(s : GraphsearchdijkstraGraphN) -> Int { s.size }

pub fn graph_search_dijkstra_graphn_get(s : GraphsearchdijkstraGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_graphn_set(s : GraphsearchdijkstraGraphN, i : Int, v : Double) -> GraphsearchdijkstraGraphN {
  let result = graph_search_dijkstra_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_graphn_sum(s : GraphsearchdijkstraGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_graphn_mean(s : GraphsearchdijkstraGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_graphn_scale(s : GraphsearchdijkstraGraphN, f : Double) -> GraphsearchdijkstraGraphN {
  let result = graph_search_dijkstra_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_graphn_add(a : GraphsearchdijkstraGraphN, b : GraphsearchdijkstraGraphN) -> GraphsearchdijkstraGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_graphn_copy(s : GraphsearchdijkstraGraphN) -> GraphsearchdijkstraGraphN {
  let result = graph_search_dijkstra_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_graphn_fill(s : GraphsearchdijkstraGraphN, v : Double) -> GraphsearchdijkstraGraphN {
  let result = graph_search_dijkstra_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_graphn_min(s : GraphsearchdijkstraGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_graphn_max(s : GraphsearchdijkstraGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_graphn_to_string(s : GraphsearchdijkstraGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_node_make(size : Int) -> GraphsearchdijkstraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_node_len(s : GraphsearchdijkstraNode) -> Int { s.size }

pub fn graph_search_dijkstra_node_get(s : GraphsearchdijkstraNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_node_set(s : GraphsearchdijkstraNode, i : Int, v : Double) -> GraphsearchdijkstraNode {
  let result = graph_search_dijkstra_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_node_sum(s : GraphsearchdijkstraNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_node_mean(s : GraphsearchdijkstraNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_node_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_node_scale(s : GraphsearchdijkstraNode, f : Double) -> GraphsearchdijkstraNode {
  let result = graph_search_dijkstra_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_node_add(a : GraphsearchdijkstraNode, b : GraphsearchdijkstraNode) -> GraphsearchdijkstraNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_node_copy(s : GraphsearchdijkstraNode) -> GraphsearchdijkstraNode {
  let result = graph_search_dijkstra_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_node_fill(s : GraphsearchdijkstraNode, v : Double) -> GraphsearchdijkstraNode {
  let result = graph_search_dijkstra_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_node_min(s : GraphsearchdijkstraNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_node_max(s : GraphsearchdijkstraNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_node_to_string(s : GraphsearchdijkstraNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_edge_make(size : Int) -> GraphsearchdijkstraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_edge_len(s : GraphsearchdijkstraEdge) -> Int { s.size }

pub fn graph_search_dijkstra_edge_get(s : GraphsearchdijkstraEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_edge_set(s : GraphsearchdijkstraEdge, i : Int, v : Double) -> GraphsearchdijkstraEdge {
  let result = graph_search_dijkstra_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_edge_sum(s : GraphsearchdijkstraEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_edge_mean(s : GraphsearchdijkstraEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_edge_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_edge_scale(s : GraphsearchdijkstraEdge, f : Double) -> GraphsearchdijkstraEdge {
  let result = graph_search_dijkstra_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_edge_add(a : GraphsearchdijkstraEdge, b : GraphsearchdijkstraEdge) -> GraphsearchdijkstraEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_edge_copy(s : GraphsearchdijkstraEdge) -> GraphsearchdijkstraEdge {
  let result = graph_search_dijkstra_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_edge_fill(s : GraphsearchdijkstraEdge, v : Double) -> GraphsearchdijkstraEdge {
  let result = graph_search_dijkstra_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_edge_min(s : GraphsearchdijkstraEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_edge_max(s : GraphsearchdijkstraEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_edge_to_string(s : GraphsearchdijkstraEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_path_make(size : Int) -> GraphsearchdijkstraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_path_len(s : GraphsearchdijkstraPath) -> Int { s.size }

pub fn graph_search_dijkstra_path_get(s : GraphsearchdijkstraPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_path_set(s : GraphsearchdijkstraPath, i : Int, v : Double) -> GraphsearchdijkstraPath {
  let result = graph_search_dijkstra_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_path_sum(s : GraphsearchdijkstraPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_path_mean(s : GraphsearchdijkstraPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_path_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_path_scale(s : GraphsearchdijkstraPath, f : Double) -> GraphsearchdijkstraPath {
  let result = graph_search_dijkstra_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_path_add(a : GraphsearchdijkstraPath, b : GraphsearchdijkstraPath) -> GraphsearchdijkstraPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_path_copy(s : GraphsearchdijkstraPath) -> GraphsearchdijkstraPath {
  let result = graph_search_dijkstra_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_path_fill(s : GraphsearchdijkstraPath, v : Double) -> GraphsearchdijkstraPath {
  let result = graph_search_dijkstra_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_path_min(s : GraphsearchdijkstraPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_path_max(s : GraphsearchdijkstraPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_path_to_string(s : GraphsearchdijkstraPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_cluster_make(size : Int) -> GraphsearchdijkstraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_cluster_len(s : GraphsearchdijkstraCluster) -> Int { s.size }

pub fn graph_search_dijkstra_cluster_get(s : GraphsearchdijkstraCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_cluster_set(s : GraphsearchdijkstraCluster, i : Int, v : Double) -> GraphsearchdijkstraCluster {
  let result = graph_search_dijkstra_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_cluster_sum(s : GraphsearchdijkstraCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_cluster_mean(s : GraphsearchdijkstraCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_cluster_scale(s : GraphsearchdijkstraCluster, f : Double) -> GraphsearchdijkstraCluster {
  let result = graph_search_dijkstra_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_cluster_add(a : GraphsearchdijkstraCluster, b : GraphsearchdijkstraCluster) -> GraphsearchdijkstraCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_cluster_copy(s : GraphsearchdijkstraCluster) -> GraphsearchdijkstraCluster {
  let result = graph_search_dijkstra_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_cluster_fill(s : GraphsearchdijkstraCluster, v : Double) -> GraphsearchdijkstraCluster {
  let result = graph_search_dijkstra_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_cluster_min(s : GraphsearchdijkstraCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_cluster_max(s : GraphsearchdijkstraCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_cluster_to_string(s : GraphsearchdijkstraCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_model_make(size : Int) -> GraphsearchdijkstraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_model_len(s : GraphsearchdijkstraModel) -> Int { s.size }

pub fn graph_search_dijkstra_model_get(s : GraphsearchdijkstraModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_model_set(s : GraphsearchdijkstraModel, i : Int, v : Double) -> GraphsearchdijkstraModel {
  let result = graph_search_dijkstra_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_model_sum(s : GraphsearchdijkstraModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_model_mean(s : GraphsearchdijkstraModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_model_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_model_scale(s : GraphsearchdijkstraModel, f : Double) -> GraphsearchdijkstraModel {
  let result = graph_search_dijkstra_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_model_add(a : GraphsearchdijkstraModel, b : GraphsearchdijkstraModel) -> GraphsearchdijkstraModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_model_copy(s : GraphsearchdijkstraModel) -> GraphsearchdijkstraModel {
  let result = graph_search_dijkstra_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_model_fill(s : GraphsearchdijkstraModel, v : Double) -> GraphsearchdijkstraModel {
  let result = graph_search_dijkstra_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_model_min(s : GraphsearchdijkstraModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_model_max(s : GraphsearchdijkstraModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_model_to_string(s : GraphsearchdijkstraModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_layer_make(size : Int) -> GraphsearchdijkstraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_layer_len(s : GraphsearchdijkstraLayer) -> Int { s.size }

pub fn graph_search_dijkstra_layer_get(s : GraphsearchdijkstraLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_layer_set(s : GraphsearchdijkstraLayer, i : Int, v : Double) -> GraphsearchdijkstraLayer {
  let result = graph_search_dijkstra_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_layer_sum(s : GraphsearchdijkstraLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_layer_mean(s : GraphsearchdijkstraLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_layer_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_layer_scale(s : GraphsearchdijkstraLayer, f : Double) -> GraphsearchdijkstraLayer {
  let result = graph_search_dijkstra_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_layer_add(a : GraphsearchdijkstraLayer, b : GraphsearchdijkstraLayer) -> GraphsearchdijkstraLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_layer_copy(s : GraphsearchdijkstraLayer) -> GraphsearchdijkstraLayer {
  let result = graph_search_dijkstra_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_layer_fill(s : GraphsearchdijkstraLayer, v : Double) -> GraphsearchdijkstraLayer {
  let result = graph_search_dijkstra_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_layer_min(s : GraphsearchdijkstraLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_layer_max(s : GraphsearchdijkstraLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_layer_to_string(s : GraphsearchdijkstraLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_buffer_make(size : Int) -> GraphsearchdijkstraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_buffer_len(s : GraphsearchdijkstraBuffer) -> Int { s.size }

pub fn graph_search_dijkstra_buffer_get(s : GraphsearchdijkstraBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_buffer_set(s : GraphsearchdijkstraBuffer, i : Int, v : Double) -> GraphsearchdijkstraBuffer {
  let result = graph_search_dijkstra_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_buffer_sum(s : GraphsearchdijkstraBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_buffer_mean(s : GraphsearchdijkstraBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_buffer_scale(s : GraphsearchdijkstraBuffer, f : Double) -> GraphsearchdijkstraBuffer {
  let result = graph_search_dijkstra_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_buffer_add(a : GraphsearchdijkstraBuffer, b : GraphsearchdijkstraBuffer) -> GraphsearchdijkstraBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_buffer_copy(s : GraphsearchdijkstraBuffer) -> GraphsearchdijkstraBuffer {
  let result = graph_search_dijkstra_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_buffer_fill(s : GraphsearchdijkstraBuffer, v : Double) -> GraphsearchdijkstraBuffer {
  let result = graph_search_dijkstra_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_buffer_min(s : GraphsearchdijkstraBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_buffer_max(s : GraphsearchdijkstraBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_buffer_to_string(s : GraphsearchdijkstraBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_cursor_make(size : Int) -> GraphsearchdijkstraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_cursor_len(s : GraphsearchdijkstraCursor) -> Int { s.size }

pub fn graph_search_dijkstra_cursor_get(s : GraphsearchdijkstraCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_cursor_set(s : GraphsearchdijkstraCursor, i : Int, v : Double) -> GraphsearchdijkstraCursor {
  let result = graph_search_dijkstra_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_cursor_sum(s : GraphsearchdijkstraCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_cursor_mean(s : GraphsearchdijkstraCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_cursor_scale(s : GraphsearchdijkstraCursor, f : Double) -> GraphsearchdijkstraCursor {
  let result = graph_search_dijkstra_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_cursor_add(a : GraphsearchdijkstraCursor, b : GraphsearchdijkstraCursor) -> GraphsearchdijkstraCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_cursor_copy(s : GraphsearchdijkstraCursor) -> GraphsearchdijkstraCursor {
  let result = graph_search_dijkstra_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_cursor_fill(s : GraphsearchdijkstraCursor, v : Double) -> GraphsearchdijkstraCursor {
  let result = graph_search_dijkstra_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_cursor_min(s : GraphsearchdijkstraCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_cursor_max(s : GraphsearchdijkstraCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_cursor_to_string(s : GraphsearchdijkstraCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_view_make(size : Int) -> GraphsearchdijkstraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_view_len(s : GraphsearchdijkstraView) -> Int { s.size }

pub fn graph_search_dijkstra_view_get(s : GraphsearchdijkstraView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_view_set(s : GraphsearchdijkstraView, i : Int, v : Double) -> GraphsearchdijkstraView {
  let result = graph_search_dijkstra_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_view_sum(s : GraphsearchdijkstraView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_view_mean(s : GraphsearchdijkstraView) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_view_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_view_scale(s : GraphsearchdijkstraView, f : Double) -> GraphsearchdijkstraView {
  let result = graph_search_dijkstra_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_view_add(a : GraphsearchdijkstraView, b : GraphsearchdijkstraView) -> GraphsearchdijkstraView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_view_copy(s : GraphsearchdijkstraView) -> GraphsearchdijkstraView {
  let result = graph_search_dijkstra_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_view_fill(s : GraphsearchdijkstraView, v : Double) -> GraphsearchdijkstraView {
  let result = graph_search_dijkstra_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_view_min(s : GraphsearchdijkstraView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_view_max(s : GraphsearchdijkstraView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_view_to_string(s : GraphsearchdijkstraView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_range_make(size : Int) -> GraphsearchdijkstraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_range_len(s : GraphsearchdijkstraRange) -> Int { s.size }

pub fn graph_search_dijkstra_range_get(s : GraphsearchdijkstraRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_range_set(s : GraphsearchdijkstraRange, i : Int, v : Double) -> GraphsearchdijkstraRange {
  let result = graph_search_dijkstra_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_range_sum(s : GraphsearchdijkstraRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_range_mean(s : GraphsearchdijkstraRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_range_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_range_scale(s : GraphsearchdijkstraRange, f : Double) -> GraphsearchdijkstraRange {
  let result = graph_search_dijkstra_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_range_add(a : GraphsearchdijkstraRange, b : GraphsearchdijkstraRange) -> GraphsearchdijkstraRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_range_copy(s : GraphsearchdijkstraRange) -> GraphsearchdijkstraRange {
  let result = graph_search_dijkstra_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_range_fill(s : GraphsearchdijkstraRange, v : Double) -> GraphsearchdijkstraRange {
  let result = graph_search_dijkstra_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_range_min(s : GraphsearchdijkstraRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_range_max(s : GraphsearchdijkstraRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_range_to_string(s : GraphsearchdijkstraRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_slice_make(size : Int) -> GraphsearchdijkstraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_slice_len(s : GraphsearchdijkstraSlice) -> Int { s.size }

pub fn graph_search_dijkstra_slice_get(s : GraphsearchdijkstraSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_slice_set(s : GraphsearchdijkstraSlice, i : Int, v : Double) -> GraphsearchdijkstraSlice {
  let result = graph_search_dijkstra_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_slice_sum(s : GraphsearchdijkstraSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dijkstra_slice_mean(s : GraphsearchdijkstraSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dijkstra_slice_sum(s) / s.size.to_double() }
}

pub fn graph_search_dijkstra_slice_scale(s : GraphsearchdijkstraSlice, f : Double) -> GraphsearchdijkstraSlice {
  let result = graph_search_dijkstra_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dijkstra_slice_add(a : GraphsearchdijkstraSlice, b : GraphsearchdijkstraSlice) -> GraphsearchdijkstraSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dijkstra_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dijkstra_slice_copy(s : GraphsearchdijkstraSlice) -> GraphsearchdijkstraSlice {
  let result = graph_search_dijkstra_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dijkstra_slice_fill(s : GraphsearchdijkstraSlice, v : Double) -> GraphsearchdijkstraSlice {
  let result = graph_search_dijkstra_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dijkstra_slice_min(s : GraphsearchdijkstraSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_slice_max(s : GraphsearchdijkstraSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dijkstra_slice_to_string(s : GraphsearchdijkstraSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

