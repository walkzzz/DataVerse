///===
/// extcore/net_route_dijkstra

pub(all) struct NetroutedijkstraPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_dijkstra_make_point(x : Double, y : Double) -> NetroutedijkstraPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_dijkstra_make_point3(x : Double, y : Double, z : Double) -> NetroutedijkstraPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_dijkstra_point_x(pt : NetroutedijkstraPoint) -> Double { pt.x }

pub fn net_route_dijkstra_point_y(pt : NetroutedijkstraPoint) -> Double { pt.y }

pub fn net_route_dijkstra_point_z(pt : NetroutedijkstraPoint) -> Double { pt.z }

pub fn net_route_dijkstra_point_label(pt : NetroutedijkstraPoint) -> Int { pt.label }

pub fn net_route_dijkstra_point_dist(a : NetroutedijkstraPoint, b : NetroutedijkstraPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_dijkstra_point_add(a : NetroutedijkstraPoint, b : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_dijkstra_point_sub(a : NetroutedijkstraPoint, b : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_dijkstra_point_scale(pt : NetroutedijkstraPoint, s : Double) -> NetroutedijkstraPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_dijkstra_point_dot(a : NetroutedijkstraPoint, b : NetroutedijkstraPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_dijkstra_point_cross(a : NetroutedijkstraPoint, b : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_dijkstra_point_norm(pt : NetroutedijkstraPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_dijkstra_point_normalize(pt : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  let n = net_route_dijkstra_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_dijkstra_point_scale(pt, 1.0 / n) }
}

pub fn net_route_dijkstra_point_negate(pt : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_dijkstra_point_mid(a : NetroutedijkstraPoint, b : NetroutedijkstraPoint) -> NetroutedijkstraPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_dijkstra_point_lerp(a : NetroutedijkstraPoint, b : NetroutedijkstraPoint, t : Double) -> NetroutedijkstraPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_dijkstra_point_to_string(pt : NetroutedijkstraPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetroutedijkstraSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_dijkstra_make_series(vals : Array[Double], name : String) -> NetroutedijkstraSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_dijkstra_series_len(s : NetroutedijkstraSeries) -> Int { s.vals.length() }

pub fn net_route_dijkstra_series_sum(s : NetroutedijkstraSeries) -> Double { @_common.sum(s.vals) }

pub fn net_route_dijkstra_series_mean(s : NetroutedijkstraSeries) -> Double { @_common.mean(s.vals) }

pub fn net_route_dijkstra_series_min(s : NetroutedijkstraSeries) -> Double { @_common.min(s.vals) }

pub fn net_route_dijkstra_series_max(s : NetroutedijkstraSeries) -> Double { @_common.max(s.vals) }

pub fn net_route_dijkstra_series_range(s : NetroutedijkstraSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_route_dijkstra_series_var(s : NetroutedijkstraSeries) -> Double { @_common.variance(s.vals) }

pub fn net_route_dijkstra_series_std(s : NetroutedijkstraSeries) -> Double { @_common.std(s.vals) }

pub fn net_route_dijkstra_series_median(s : NetroutedijkstraSeries) -> Double { @_common.median(s.vals) }

pub fn net_route_dijkstra_series_scale(s : NetroutedijkstraSeries, f : Double) -> NetroutedijkstraSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_dijkstra_series_add(a : NetroutedijkstraSeries, b : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_dijkstra_series_sub(a : NetroutedijkstraSeries, b : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_dijkstra_series_normalize(s : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  let mn = net_route_dijkstra_series_min(s)
  let mx = net_route_dijkstra_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_dijkstra_series_cumsum(s : NetroutedijkstraSeries) -> NetroutedijkstraSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_dijkstra_series_to_string(s : NetroutedijkstraSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutedijkstraMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_dijkstra_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutedijkstraMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_dijkstra_matrix_identity(n : Int) -> NetroutedijkstraMatrix {
  let m = net_route_dijkstra_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_dijkstra_matrix_get(m : NetroutedijkstraMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_dijkstra_matrix_transpose(m : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  let result = net_route_dijkstra_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_dijkstra_matrix_add(a : NetroutedijkstraMatrix, b : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_dijkstra_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_dijkstra_matrix_scale(m : NetroutedijkstraMatrix, s : Double) -> NetroutedijkstraMatrix {
  let result = net_route_dijkstra_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_dijkstra_matrix_multiply(a : NetroutedijkstraMatrix, b : NetroutedijkstraMatrix) -> NetroutedijkstraMatrix {
  if a.cols != b.rows { return net_route_dijkstra_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_dijkstra_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_dijkstra_matrix_trace(m : NetroutedijkstraMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_dijkstra_matrix_det(m : NetroutedijkstraMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_dijkstra_matrix_norm(m : NetroutedijkstraMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_route_dijkstra_matrix_to_string(m : NetroutedijkstraMatrix) -> String {
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

pub(all) struct NetroutedijkstraVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_dijkstra_make_vector(comps : Array[Double]) -> NetroutedijkstraVector {
  { comps, dim: comps.length() }
}

pub fn net_route_dijkstra_vector_zero(dim : Int) -> NetroutedijkstraVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_dijkstra_vector_add(a : NetroutedijkstraVector, b : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_dijkstra_vector_sub(a : NetroutedijkstraVector, b : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_dijkstra_vector_scale(v : NetroutedijkstraVector, s : Double) -> NetroutedijkstraVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_dijkstra_vector_dot(a : NetroutedijkstraVector, b : NetroutedijkstraVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_dijkstra_vector_norm(v : NetroutedijkstraVector) -> Double { @_common.sqrt(net_route_dijkstra_vector_dot(v, v)) }

pub fn net_route_dijkstra_vector_normalize(v : NetroutedijkstraVector) -> NetroutedijkstraVector {
  let n = net_route_dijkstra_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_dijkstra_vector_scale(v, 1.0 / n) }
}

pub fn net_route_dijkstra_vector_dist(a : NetroutedijkstraVector, b : NetroutedijkstraVector) -> Double {
  net_route_dijkstra_vector_norm(net_route_dijkstra_vector_sub(a, b))
}

pub fn net_route_dijkstra_vector_to_string(v : NetroutedijkstraVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_dijkstra_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_dijkstra_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_dijkstra_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_dijkstra_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_dijkstra_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_dijkstra_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_dijkstra_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_dijkstra_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_dijkstra_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_dijkstra_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_dijkstra_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_dijkstra_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_dijkstra_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_dijkstra_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_dijkstra_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_dijkstra_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_dijkstra_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_dijkstra_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_dijkstra_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_dijkstra_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_dijkstra_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_dijkstra_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_dijkstra_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_dijkstra_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_dijkstra_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_dijkstra_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_dijkstra_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_dijkstra_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_dijkstra_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutedijkstraFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_frame_make(size : Int) -> NetroutedijkstraFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_frame_len(s : NetroutedijkstraFrame) -> Int { s.size }

pub fn net_route_dijkstra_frame_get(s : NetroutedijkstraFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_frame_set(s : NetroutedijkstraFrame, i : Int, v : Double) -> NetroutedijkstraFrame {
  let result = net_route_dijkstra_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_frame_sum(s : NetroutedijkstraFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_frame_mean(s : NetroutedijkstraFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_frame_scale(s : NetroutedijkstraFrame, f : Double) -> NetroutedijkstraFrame {
  let result = net_route_dijkstra_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_frame_add(a : NetroutedijkstraFrame, b : NetroutedijkstraFrame) -> NetroutedijkstraFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_frame_copy(s : NetroutedijkstraFrame) -> NetroutedijkstraFrame {
  let result = net_route_dijkstra_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_frame_fill(s : NetroutedijkstraFrame, v : Double) -> NetroutedijkstraFrame {
  let result = net_route_dijkstra_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_frame_min(s : NetroutedijkstraFrame) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_frame_max(s : NetroutedijkstraFrame) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_frame_to_string(s : NetroutedijkstraFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_table_make(size : Int) -> NetroutedijkstraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_table_len(s : NetroutedijkstraTable) -> Int { s.size }

pub fn net_route_dijkstra_table_get(s : NetroutedijkstraTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_table_set(s : NetroutedijkstraTable, i : Int, v : Double) -> NetroutedijkstraTable {
  let result = net_route_dijkstra_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_table_sum(s : NetroutedijkstraTable) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_table_mean(s : NetroutedijkstraTable) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_table_scale(s : NetroutedijkstraTable, f : Double) -> NetroutedijkstraTable {
  let result = net_route_dijkstra_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_table_add(a : NetroutedijkstraTable, b : NetroutedijkstraTable) -> NetroutedijkstraTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_table_copy(s : NetroutedijkstraTable) -> NetroutedijkstraTable {
  let result = net_route_dijkstra_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_table_fill(s : NetroutedijkstraTable, v : Double) -> NetroutedijkstraTable {
  let result = net_route_dijkstra_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_table_min(s : NetroutedijkstraTable) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_table_max(s : NetroutedijkstraTable) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_table_to_string(s : NetroutedijkstraTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_graphn_make(size : Int) -> NetroutedijkstraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_graphn_len(s : NetroutedijkstraGraphN) -> Int { s.size }

pub fn net_route_dijkstra_graphn_get(s : NetroutedijkstraGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_graphn_set(s : NetroutedijkstraGraphN, i : Int, v : Double) -> NetroutedijkstraGraphN {
  let result = net_route_dijkstra_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_graphn_sum(s : NetroutedijkstraGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_graphn_mean(s : NetroutedijkstraGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_graphn_scale(s : NetroutedijkstraGraphN, f : Double) -> NetroutedijkstraGraphN {
  let result = net_route_dijkstra_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_graphn_add(a : NetroutedijkstraGraphN, b : NetroutedijkstraGraphN) -> NetroutedijkstraGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_graphn_copy(s : NetroutedijkstraGraphN) -> NetroutedijkstraGraphN {
  let result = net_route_dijkstra_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_graphn_fill(s : NetroutedijkstraGraphN, v : Double) -> NetroutedijkstraGraphN {
  let result = net_route_dijkstra_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_graphn_min(s : NetroutedijkstraGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_graphn_max(s : NetroutedijkstraGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_graphn_to_string(s : NetroutedijkstraGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_node_make(size : Int) -> NetroutedijkstraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_node_len(s : NetroutedijkstraNode) -> Int { s.size }

pub fn net_route_dijkstra_node_get(s : NetroutedijkstraNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_node_set(s : NetroutedijkstraNode, i : Int, v : Double) -> NetroutedijkstraNode {
  let result = net_route_dijkstra_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_node_sum(s : NetroutedijkstraNode) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_node_mean(s : NetroutedijkstraNode) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_node_scale(s : NetroutedijkstraNode, f : Double) -> NetroutedijkstraNode {
  let result = net_route_dijkstra_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_node_add(a : NetroutedijkstraNode, b : NetroutedijkstraNode) -> NetroutedijkstraNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_node_copy(s : NetroutedijkstraNode) -> NetroutedijkstraNode {
  let result = net_route_dijkstra_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_node_fill(s : NetroutedijkstraNode, v : Double) -> NetroutedijkstraNode {
  let result = net_route_dijkstra_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_node_min(s : NetroutedijkstraNode) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_node_max(s : NetroutedijkstraNode) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_node_to_string(s : NetroutedijkstraNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_edge_make(size : Int) -> NetroutedijkstraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_edge_len(s : NetroutedijkstraEdge) -> Int { s.size }

pub fn net_route_dijkstra_edge_get(s : NetroutedijkstraEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_edge_set(s : NetroutedijkstraEdge, i : Int, v : Double) -> NetroutedijkstraEdge {
  let result = net_route_dijkstra_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_edge_sum(s : NetroutedijkstraEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_edge_mean(s : NetroutedijkstraEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_edge_scale(s : NetroutedijkstraEdge, f : Double) -> NetroutedijkstraEdge {
  let result = net_route_dijkstra_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_edge_add(a : NetroutedijkstraEdge, b : NetroutedijkstraEdge) -> NetroutedijkstraEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_edge_copy(s : NetroutedijkstraEdge) -> NetroutedijkstraEdge {
  let result = net_route_dijkstra_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_edge_fill(s : NetroutedijkstraEdge, v : Double) -> NetroutedijkstraEdge {
  let result = net_route_dijkstra_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_edge_min(s : NetroutedijkstraEdge) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_edge_max(s : NetroutedijkstraEdge) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_edge_to_string(s : NetroutedijkstraEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_path_make(size : Int) -> NetroutedijkstraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_path_len(s : NetroutedijkstraPath) -> Int { s.size }

pub fn net_route_dijkstra_path_get(s : NetroutedijkstraPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_path_set(s : NetroutedijkstraPath, i : Int, v : Double) -> NetroutedijkstraPath {
  let result = net_route_dijkstra_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_path_sum(s : NetroutedijkstraPath) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_path_mean(s : NetroutedijkstraPath) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_path_scale(s : NetroutedijkstraPath, f : Double) -> NetroutedijkstraPath {
  let result = net_route_dijkstra_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_path_add(a : NetroutedijkstraPath, b : NetroutedijkstraPath) -> NetroutedijkstraPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_path_copy(s : NetroutedijkstraPath) -> NetroutedijkstraPath {
  let result = net_route_dijkstra_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_path_fill(s : NetroutedijkstraPath, v : Double) -> NetroutedijkstraPath {
  let result = net_route_dijkstra_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_path_min(s : NetroutedijkstraPath) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_path_max(s : NetroutedijkstraPath) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_path_to_string(s : NetroutedijkstraPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_cluster_make(size : Int) -> NetroutedijkstraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_cluster_len(s : NetroutedijkstraCluster) -> Int { s.size }

pub fn net_route_dijkstra_cluster_get(s : NetroutedijkstraCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_cluster_set(s : NetroutedijkstraCluster, i : Int, v : Double) -> NetroutedijkstraCluster {
  let result = net_route_dijkstra_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_cluster_sum(s : NetroutedijkstraCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_cluster_mean(s : NetroutedijkstraCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_cluster_scale(s : NetroutedijkstraCluster, f : Double) -> NetroutedijkstraCluster {
  let result = net_route_dijkstra_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_cluster_add(a : NetroutedijkstraCluster, b : NetroutedijkstraCluster) -> NetroutedijkstraCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_cluster_copy(s : NetroutedijkstraCluster) -> NetroutedijkstraCluster {
  let result = net_route_dijkstra_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_cluster_fill(s : NetroutedijkstraCluster, v : Double) -> NetroutedijkstraCluster {
  let result = net_route_dijkstra_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_cluster_min(s : NetroutedijkstraCluster) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_cluster_max(s : NetroutedijkstraCluster) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_cluster_to_string(s : NetroutedijkstraCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_model_make(size : Int) -> NetroutedijkstraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_model_len(s : NetroutedijkstraModel) -> Int { s.size }

pub fn net_route_dijkstra_model_get(s : NetroutedijkstraModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_model_set(s : NetroutedijkstraModel, i : Int, v : Double) -> NetroutedijkstraModel {
  let result = net_route_dijkstra_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_model_sum(s : NetroutedijkstraModel) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_model_mean(s : NetroutedijkstraModel) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_model_scale(s : NetroutedijkstraModel, f : Double) -> NetroutedijkstraModel {
  let result = net_route_dijkstra_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_model_add(a : NetroutedijkstraModel, b : NetroutedijkstraModel) -> NetroutedijkstraModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_model_copy(s : NetroutedijkstraModel) -> NetroutedijkstraModel {
  let result = net_route_dijkstra_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_model_fill(s : NetroutedijkstraModel, v : Double) -> NetroutedijkstraModel {
  let result = net_route_dijkstra_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_model_min(s : NetroutedijkstraModel) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_model_max(s : NetroutedijkstraModel) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_model_to_string(s : NetroutedijkstraModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_layer_make(size : Int) -> NetroutedijkstraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_layer_len(s : NetroutedijkstraLayer) -> Int { s.size }

pub fn net_route_dijkstra_layer_get(s : NetroutedijkstraLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_layer_set(s : NetroutedijkstraLayer, i : Int, v : Double) -> NetroutedijkstraLayer {
  let result = net_route_dijkstra_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_layer_sum(s : NetroutedijkstraLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_layer_mean(s : NetroutedijkstraLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_layer_scale(s : NetroutedijkstraLayer, f : Double) -> NetroutedijkstraLayer {
  let result = net_route_dijkstra_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_layer_add(a : NetroutedijkstraLayer, b : NetroutedijkstraLayer) -> NetroutedijkstraLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_layer_copy(s : NetroutedijkstraLayer) -> NetroutedijkstraLayer {
  let result = net_route_dijkstra_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_layer_fill(s : NetroutedijkstraLayer, v : Double) -> NetroutedijkstraLayer {
  let result = net_route_dijkstra_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_layer_min(s : NetroutedijkstraLayer) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_layer_max(s : NetroutedijkstraLayer) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_layer_to_string(s : NetroutedijkstraLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_buffer_make(size : Int) -> NetroutedijkstraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_buffer_len(s : NetroutedijkstraBuffer) -> Int { s.size }

pub fn net_route_dijkstra_buffer_get(s : NetroutedijkstraBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_buffer_set(s : NetroutedijkstraBuffer, i : Int, v : Double) -> NetroutedijkstraBuffer {
  let result = net_route_dijkstra_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_buffer_sum(s : NetroutedijkstraBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_buffer_mean(s : NetroutedijkstraBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_buffer_scale(s : NetroutedijkstraBuffer, f : Double) -> NetroutedijkstraBuffer {
  let result = net_route_dijkstra_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_buffer_add(a : NetroutedijkstraBuffer, b : NetroutedijkstraBuffer) -> NetroutedijkstraBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_buffer_copy(s : NetroutedijkstraBuffer) -> NetroutedijkstraBuffer {
  let result = net_route_dijkstra_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_buffer_fill(s : NetroutedijkstraBuffer, v : Double) -> NetroutedijkstraBuffer {
  let result = net_route_dijkstra_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_buffer_min(s : NetroutedijkstraBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_buffer_max(s : NetroutedijkstraBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_buffer_to_string(s : NetroutedijkstraBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_cursor_make(size : Int) -> NetroutedijkstraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_cursor_len(s : NetroutedijkstraCursor) -> Int { s.size }

pub fn net_route_dijkstra_cursor_get(s : NetroutedijkstraCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_cursor_set(s : NetroutedijkstraCursor, i : Int, v : Double) -> NetroutedijkstraCursor {
  let result = net_route_dijkstra_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_cursor_sum(s : NetroutedijkstraCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_cursor_mean(s : NetroutedijkstraCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_cursor_scale(s : NetroutedijkstraCursor, f : Double) -> NetroutedijkstraCursor {
  let result = net_route_dijkstra_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_cursor_add(a : NetroutedijkstraCursor, b : NetroutedijkstraCursor) -> NetroutedijkstraCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_cursor_copy(s : NetroutedijkstraCursor) -> NetroutedijkstraCursor {
  let result = net_route_dijkstra_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_cursor_fill(s : NetroutedijkstraCursor, v : Double) -> NetroutedijkstraCursor {
  let result = net_route_dijkstra_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_cursor_min(s : NetroutedijkstraCursor) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_cursor_max(s : NetroutedijkstraCursor) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_cursor_to_string(s : NetroutedijkstraCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_view_make(size : Int) -> NetroutedijkstraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_view_len(s : NetroutedijkstraView) -> Int { s.size }

pub fn net_route_dijkstra_view_get(s : NetroutedijkstraView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_view_set(s : NetroutedijkstraView, i : Int, v : Double) -> NetroutedijkstraView {
  let result = net_route_dijkstra_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_view_sum(s : NetroutedijkstraView) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_view_mean(s : NetroutedijkstraView) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_view_scale(s : NetroutedijkstraView, f : Double) -> NetroutedijkstraView {
  let result = net_route_dijkstra_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_view_add(a : NetroutedijkstraView, b : NetroutedijkstraView) -> NetroutedijkstraView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_view_copy(s : NetroutedijkstraView) -> NetroutedijkstraView {
  let result = net_route_dijkstra_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_view_fill(s : NetroutedijkstraView, v : Double) -> NetroutedijkstraView {
  let result = net_route_dijkstra_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_view_min(s : NetroutedijkstraView) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_view_max(s : NetroutedijkstraView) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_view_to_string(s : NetroutedijkstraView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_range_make(size : Int) -> NetroutedijkstraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_range_len(s : NetroutedijkstraRange) -> Int { s.size }

pub fn net_route_dijkstra_range_get(s : NetroutedijkstraRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_range_set(s : NetroutedijkstraRange, i : Int, v : Double) -> NetroutedijkstraRange {
  let result = net_route_dijkstra_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_range_sum(s : NetroutedijkstraRange) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_range_mean(s : NetroutedijkstraRange) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_range_scale(s : NetroutedijkstraRange, f : Double) -> NetroutedijkstraRange {
  let result = net_route_dijkstra_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_range_add(a : NetroutedijkstraRange, b : NetroutedijkstraRange) -> NetroutedijkstraRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_range_copy(s : NetroutedijkstraRange) -> NetroutedijkstraRange {
  let result = net_route_dijkstra_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_range_fill(s : NetroutedijkstraRange, v : Double) -> NetroutedijkstraRange {
  let result = net_route_dijkstra_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_range_min(s : NetroutedijkstraRange) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_range_max(s : NetroutedijkstraRange) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_range_to_string(s : NetroutedijkstraRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutedijkstraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_dijkstra_slice_make(size : Int) -> NetroutedijkstraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_dijkstra_slice_len(s : NetroutedijkstraSlice) -> Int { s.size }

pub fn net_route_dijkstra_slice_get(s : NetroutedijkstraSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_dijkstra_slice_set(s : NetroutedijkstraSlice, i : Int, v : Double) -> NetroutedijkstraSlice {
  let result = net_route_dijkstra_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_slice_sum(s : NetroutedijkstraSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_dijkstra_slice_mean(s : NetroutedijkstraSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_dijkstra_slice_scale(s : NetroutedijkstraSlice, f : Double) -> NetroutedijkstraSlice {
  let result = net_route_dijkstra_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_dijkstra_slice_add(a : NetroutedijkstraSlice, b : NetroutedijkstraSlice) -> NetroutedijkstraSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_dijkstra_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_dijkstra_slice_copy(s : NetroutedijkstraSlice) -> NetroutedijkstraSlice {
  let result = net_route_dijkstra_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_dijkstra_slice_fill(s : NetroutedijkstraSlice, v : Double) -> NetroutedijkstraSlice {
  let result = net_route_dijkstra_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_dijkstra_slice_min(s : NetroutedijkstraSlice) -> Double { @_common.min(s.data) }

pub fn net_route_dijkstra_slice_max(s : NetroutedijkstraSlice) -> Double { @_common.max(s.data) }

pub fn net_route_dijkstra_slice_to_string(s : NetroutedijkstraSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

