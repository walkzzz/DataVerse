///===
/// extcore/graph_connect_biconnect

pub(all) struct GraphconnectbiconnectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_biconnect_make_point(x : Double, y : Double) -> GraphconnectbiconnectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_biconnect_make_point3(x : Double, y : Double, z : Double) -> GraphconnectbiconnectPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_biconnect_point_x(pt : GraphconnectbiconnectPoint) -> Double { pt.x }

pub fn graph_connect_biconnect_point_y(pt : GraphconnectbiconnectPoint) -> Double { pt.y }

pub fn graph_connect_biconnect_point_z(pt : GraphconnectbiconnectPoint) -> Double { pt.z }

pub fn graph_connect_biconnect_point_label(pt : GraphconnectbiconnectPoint) -> Int { pt.label }

pub fn graph_connect_biconnect_point_dist(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_biconnect_point_add(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_biconnect_point_sub(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_biconnect_point_scale(pt : GraphconnectbiconnectPoint, s : Double) -> GraphconnectbiconnectPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_biconnect_point_dot(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_biconnect_point_cross(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_biconnect_point_norm(pt : GraphconnectbiconnectPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_biconnect_point_normalize(pt : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  let n = graph_connect_biconnect_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_biconnect_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_biconnect_point_negate(pt : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_biconnect_point_mid(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_biconnect_point_lerp(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint, t : Double) -> GraphconnectbiconnectPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_biconnect_point_to_string(pt : GraphconnectbiconnectPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_biconnect_make_series(vals : Array[Double], name : String) -> GraphconnectbiconnectSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_biconnect_series_len(s : GraphconnectbiconnectSeries) -> Int { s.vals.length() }

pub fn graph_connect_biconnect_series_sum(s : GraphconnectbiconnectSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_connect_biconnect_series_mean(s : GraphconnectbiconnectSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_connect_biconnect_series_min(s : GraphconnectbiconnectSeries) -> Double { @_common.min(s.vals) }

pub fn graph_connect_biconnect_series_max(s : GraphconnectbiconnectSeries) -> Double { @_common.max(s.vals) }

pub fn graph_connect_biconnect_series_range(s : GraphconnectbiconnectSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_connect_biconnect_series_var(s : GraphconnectbiconnectSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_connect_biconnect_series_std(s : GraphconnectbiconnectSeries) -> Double { @_common.std(s.vals) }

pub fn graph_connect_biconnect_series_median(s : GraphconnectbiconnectSeries) -> Double { @_common.median(s.vals) }

pub fn graph_connect_biconnect_series_scale(s : GraphconnectbiconnectSeries, f : Double) -> GraphconnectbiconnectSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_biconnect_series_add(a : GraphconnectbiconnectSeries, b : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_biconnect_series_sub(a : GraphconnectbiconnectSeries, b : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_biconnect_series_normalize(s : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  let mn = graph_connect_biconnect_series_min(s)
  let mx = graph_connect_biconnect_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_biconnect_series_cumsum(s : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_biconnect_series_to_string(s : GraphconnectbiconnectSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectbiconnectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_biconnect_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectbiconnectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_biconnect_matrix_identity(n : Int) -> GraphconnectbiconnectMatrix {
  let m = graph_connect_biconnect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_biconnect_matrix_get(m : GraphconnectbiconnectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_biconnect_matrix_transpose(m : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  let result = graph_connect_biconnect_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_biconnect_matrix_add(a : GraphconnectbiconnectMatrix, b : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_biconnect_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_biconnect_matrix_scale(m : GraphconnectbiconnectMatrix, s : Double) -> GraphconnectbiconnectMatrix {
  let result = graph_connect_biconnect_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_biconnect_matrix_multiply(a : GraphconnectbiconnectMatrix, b : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  if a.cols != b.rows { return graph_connect_biconnect_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_biconnect_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_biconnect_matrix_trace(m : GraphconnectbiconnectMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_biconnect_matrix_det(m : GraphconnectbiconnectMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_biconnect_matrix_norm(m : GraphconnectbiconnectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_biconnect_matrix_to_string(m : GraphconnectbiconnectMatrix) -> String {
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

pub(all) struct GraphconnectbiconnectVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_biconnect_make_vector(comps : Array[Double]) -> GraphconnectbiconnectVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_biconnect_vector_zero(dim : Int) -> GraphconnectbiconnectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_biconnect_vector_add(a : GraphconnectbiconnectVector, b : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_biconnect_vector_sub(a : GraphconnectbiconnectVector, b : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_biconnect_vector_scale(v : GraphconnectbiconnectVector, s : Double) -> GraphconnectbiconnectVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_biconnect_vector_dot(a : GraphconnectbiconnectVector, b : GraphconnectbiconnectVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_biconnect_vector_norm(v : GraphconnectbiconnectVector) -> Double { @_common.sqrt(graph_connect_biconnect_vector_dot(v, v)) }

pub fn graph_connect_biconnect_vector_normalize(v : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = graph_connect_biconnect_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_biconnect_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_biconnect_vector_dist(a : GraphconnectbiconnectVector, b : GraphconnectbiconnectVector) -> Double {
  graph_connect_biconnect_vector_norm(graph_connect_biconnect_vector_sub(a, b))
}

pub fn graph_connect_biconnect_vector_to_string(v : GraphconnectbiconnectVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_biconnect_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_biconnect_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_biconnect_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_biconnect_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_biconnect_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_biconnect_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_biconnect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_biconnect_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_biconnect_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_biconnect_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_biconnect_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_biconnect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_biconnect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_biconnect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_biconnect_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_biconnect_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_biconnect_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_biconnect_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_biconnect_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_biconnect_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_biconnect_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_biconnect_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_biconnect_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_biconnect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_biconnect_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_biconnect_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_biconnect_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_biconnect_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_biconnect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectbiconnectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_frame_make(size : Int) -> GraphconnectbiconnectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_frame_len(s : GraphconnectbiconnectFrame) -> Int { s.size }

pub fn graph_connect_biconnect_frame_get(s : GraphconnectbiconnectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_frame_set(s : GraphconnectbiconnectFrame, i : Int, v : Double) -> GraphconnectbiconnectFrame {
  let result = graph_connect_biconnect_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_frame_sum(s : GraphconnectbiconnectFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_frame_mean(s : GraphconnectbiconnectFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_frame_scale(s : GraphconnectbiconnectFrame, f : Double) -> GraphconnectbiconnectFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_frame_add(a : GraphconnectbiconnectFrame, b : GraphconnectbiconnectFrame) -> GraphconnectbiconnectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_frame_copy(s : GraphconnectbiconnectFrame) -> GraphconnectbiconnectFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_frame_fill(s : GraphconnectbiconnectFrame, v : Double) -> GraphconnectbiconnectFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_frame_min(s : GraphconnectbiconnectFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_frame_max(s : GraphconnectbiconnectFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_frame_to_string(s : GraphconnectbiconnectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_table_make(size : Int) -> GraphconnectbiconnectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_table_len(s : GraphconnectbiconnectTable) -> Int { s.size }

pub fn graph_connect_biconnect_table_get(s : GraphconnectbiconnectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_table_set(s : GraphconnectbiconnectTable, i : Int, v : Double) -> GraphconnectbiconnectTable {
  let result = graph_connect_biconnect_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_table_sum(s : GraphconnectbiconnectTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_table_mean(s : GraphconnectbiconnectTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_table_scale(s : GraphconnectbiconnectTable, f : Double) -> GraphconnectbiconnectTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_table_add(a : GraphconnectbiconnectTable, b : GraphconnectbiconnectTable) -> GraphconnectbiconnectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_table_copy(s : GraphconnectbiconnectTable) -> GraphconnectbiconnectTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_table_fill(s : GraphconnectbiconnectTable, v : Double) -> GraphconnectbiconnectTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_table_min(s : GraphconnectbiconnectTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_table_max(s : GraphconnectbiconnectTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_table_to_string(s : GraphconnectbiconnectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_graphn_make(size : Int) -> GraphconnectbiconnectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_graphn_len(s : GraphconnectbiconnectGraphN) -> Int { s.size }

pub fn graph_connect_biconnect_graphn_get(s : GraphconnectbiconnectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_graphn_set(s : GraphconnectbiconnectGraphN, i : Int, v : Double) -> GraphconnectbiconnectGraphN {
  let result = graph_connect_biconnect_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_graphn_sum(s : GraphconnectbiconnectGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_graphn_mean(s : GraphconnectbiconnectGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_graphn_scale(s : GraphconnectbiconnectGraphN, f : Double) -> GraphconnectbiconnectGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_graphn_add(a : GraphconnectbiconnectGraphN, b : GraphconnectbiconnectGraphN) -> GraphconnectbiconnectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_graphn_copy(s : GraphconnectbiconnectGraphN) -> GraphconnectbiconnectGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_graphn_fill(s : GraphconnectbiconnectGraphN, v : Double) -> GraphconnectbiconnectGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_graphn_min(s : GraphconnectbiconnectGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_graphn_max(s : GraphconnectbiconnectGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_graphn_to_string(s : GraphconnectbiconnectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_node_make(size : Int) -> GraphconnectbiconnectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_node_len(s : GraphconnectbiconnectNode) -> Int { s.size }

pub fn graph_connect_biconnect_node_get(s : GraphconnectbiconnectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_node_set(s : GraphconnectbiconnectNode, i : Int, v : Double) -> GraphconnectbiconnectNode {
  let result = graph_connect_biconnect_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_node_sum(s : GraphconnectbiconnectNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_node_mean(s : GraphconnectbiconnectNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_node_scale(s : GraphconnectbiconnectNode, f : Double) -> GraphconnectbiconnectNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_node_add(a : GraphconnectbiconnectNode, b : GraphconnectbiconnectNode) -> GraphconnectbiconnectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_node_copy(s : GraphconnectbiconnectNode) -> GraphconnectbiconnectNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_node_fill(s : GraphconnectbiconnectNode, v : Double) -> GraphconnectbiconnectNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_node_min(s : GraphconnectbiconnectNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_node_max(s : GraphconnectbiconnectNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_node_to_string(s : GraphconnectbiconnectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_edge_make(size : Int) -> GraphconnectbiconnectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_edge_len(s : GraphconnectbiconnectEdge) -> Int { s.size }

pub fn graph_connect_biconnect_edge_get(s : GraphconnectbiconnectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_edge_set(s : GraphconnectbiconnectEdge, i : Int, v : Double) -> GraphconnectbiconnectEdge {
  let result = graph_connect_biconnect_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_edge_sum(s : GraphconnectbiconnectEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_edge_mean(s : GraphconnectbiconnectEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_edge_scale(s : GraphconnectbiconnectEdge, f : Double) -> GraphconnectbiconnectEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_edge_add(a : GraphconnectbiconnectEdge, b : GraphconnectbiconnectEdge) -> GraphconnectbiconnectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_edge_copy(s : GraphconnectbiconnectEdge) -> GraphconnectbiconnectEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_edge_fill(s : GraphconnectbiconnectEdge, v : Double) -> GraphconnectbiconnectEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_edge_min(s : GraphconnectbiconnectEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_edge_max(s : GraphconnectbiconnectEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_edge_to_string(s : GraphconnectbiconnectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_path_make(size : Int) -> GraphconnectbiconnectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_path_len(s : GraphconnectbiconnectPath) -> Int { s.size }

pub fn graph_connect_biconnect_path_get(s : GraphconnectbiconnectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_path_set(s : GraphconnectbiconnectPath, i : Int, v : Double) -> GraphconnectbiconnectPath {
  let result = graph_connect_biconnect_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_path_sum(s : GraphconnectbiconnectPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_path_mean(s : GraphconnectbiconnectPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_path_scale(s : GraphconnectbiconnectPath, f : Double) -> GraphconnectbiconnectPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_path_add(a : GraphconnectbiconnectPath, b : GraphconnectbiconnectPath) -> GraphconnectbiconnectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_path_copy(s : GraphconnectbiconnectPath) -> GraphconnectbiconnectPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_path_fill(s : GraphconnectbiconnectPath, v : Double) -> GraphconnectbiconnectPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_path_min(s : GraphconnectbiconnectPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_path_max(s : GraphconnectbiconnectPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_path_to_string(s : GraphconnectbiconnectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_cluster_make(size : Int) -> GraphconnectbiconnectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_cluster_len(s : GraphconnectbiconnectCluster) -> Int { s.size }

pub fn graph_connect_biconnect_cluster_get(s : GraphconnectbiconnectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_cluster_set(s : GraphconnectbiconnectCluster, i : Int, v : Double) -> GraphconnectbiconnectCluster {
  let result = graph_connect_biconnect_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_cluster_sum(s : GraphconnectbiconnectCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_cluster_mean(s : GraphconnectbiconnectCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_cluster_scale(s : GraphconnectbiconnectCluster, f : Double) -> GraphconnectbiconnectCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cluster_add(a : GraphconnectbiconnectCluster, b : GraphconnectbiconnectCluster) -> GraphconnectbiconnectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_cluster_copy(s : GraphconnectbiconnectCluster) -> GraphconnectbiconnectCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cluster_fill(s : GraphconnectbiconnectCluster, v : Double) -> GraphconnectbiconnectCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cluster_min(s : GraphconnectbiconnectCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_cluster_max(s : GraphconnectbiconnectCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_cluster_to_string(s : GraphconnectbiconnectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_model_make(size : Int) -> GraphconnectbiconnectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_model_len(s : GraphconnectbiconnectModel) -> Int { s.size }

pub fn graph_connect_biconnect_model_get(s : GraphconnectbiconnectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_model_set(s : GraphconnectbiconnectModel, i : Int, v : Double) -> GraphconnectbiconnectModel {
  let result = graph_connect_biconnect_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_model_sum(s : GraphconnectbiconnectModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_model_mean(s : GraphconnectbiconnectModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_model_scale(s : GraphconnectbiconnectModel, f : Double) -> GraphconnectbiconnectModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_model_add(a : GraphconnectbiconnectModel, b : GraphconnectbiconnectModel) -> GraphconnectbiconnectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_model_copy(s : GraphconnectbiconnectModel) -> GraphconnectbiconnectModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_model_fill(s : GraphconnectbiconnectModel, v : Double) -> GraphconnectbiconnectModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_model_min(s : GraphconnectbiconnectModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_model_max(s : GraphconnectbiconnectModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_model_to_string(s : GraphconnectbiconnectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_layer_make(size : Int) -> GraphconnectbiconnectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_layer_len(s : GraphconnectbiconnectLayer) -> Int { s.size }

pub fn graph_connect_biconnect_layer_get(s : GraphconnectbiconnectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_layer_set(s : GraphconnectbiconnectLayer, i : Int, v : Double) -> GraphconnectbiconnectLayer {
  let result = graph_connect_biconnect_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_layer_sum(s : GraphconnectbiconnectLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_layer_mean(s : GraphconnectbiconnectLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_layer_scale(s : GraphconnectbiconnectLayer, f : Double) -> GraphconnectbiconnectLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_layer_add(a : GraphconnectbiconnectLayer, b : GraphconnectbiconnectLayer) -> GraphconnectbiconnectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_layer_copy(s : GraphconnectbiconnectLayer) -> GraphconnectbiconnectLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_layer_fill(s : GraphconnectbiconnectLayer, v : Double) -> GraphconnectbiconnectLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_layer_min(s : GraphconnectbiconnectLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_layer_max(s : GraphconnectbiconnectLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_layer_to_string(s : GraphconnectbiconnectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_buffer_make(size : Int) -> GraphconnectbiconnectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_buffer_len(s : GraphconnectbiconnectBuffer) -> Int { s.size }

pub fn graph_connect_biconnect_buffer_get(s : GraphconnectbiconnectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_buffer_set(s : GraphconnectbiconnectBuffer, i : Int, v : Double) -> GraphconnectbiconnectBuffer {
  let result = graph_connect_biconnect_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_buffer_sum(s : GraphconnectbiconnectBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_buffer_mean(s : GraphconnectbiconnectBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_buffer_scale(s : GraphconnectbiconnectBuffer, f : Double) -> GraphconnectbiconnectBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_buffer_add(a : GraphconnectbiconnectBuffer, b : GraphconnectbiconnectBuffer) -> GraphconnectbiconnectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_buffer_copy(s : GraphconnectbiconnectBuffer) -> GraphconnectbiconnectBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_buffer_fill(s : GraphconnectbiconnectBuffer, v : Double) -> GraphconnectbiconnectBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_buffer_min(s : GraphconnectbiconnectBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_buffer_max(s : GraphconnectbiconnectBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_buffer_to_string(s : GraphconnectbiconnectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_cursor_make(size : Int) -> GraphconnectbiconnectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_cursor_len(s : GraphconnectbiconnectCursor) -> Int { s.size }

pub fn graph_connect_biconnect_cursor_get(s : GraphconnectbiconnectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_cursor_set(s : GraphconnectbiconnectCursor, i : Int, v : Double) -> GraphconnectbiconnectCursor {
  let result = graph_connect_biconnect_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_cursor_sum(s : GraphconnectbiconnectCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_cursor_mean(s : GraphconnectbiconnectCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_cursor_scale(s : GraphconnectbiconnectCursor, f : Double) -> GraphconnectbiconnectCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cursor_add(a : GraphconnectbiconnectCursor, b : GraphconnectbiconnectCursor) -> GraphconnectbiconnectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_cursor_copy(s : GraphconnectbiconnectCursor) -> GraphconnectbiconnectCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cursor_fill(s : GraphconnectbiconnectCursor, v : Double) -> GraphconnectbiconnectCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_cursor_min(s : GraphconnectbiconnectCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_cursor_max(s : GraphconnectbiconnectCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_cursor_to_string(s : GraphconnectbiconnectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_view_make(size : Int) -> GraphconnectbiconnectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_view_len(s : GraphconnectbiconnectView) -> Int { s.size }

pub fn graph_connect_biconnect_view_get(s : GraphconnectbiconnectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_view_set(s : GraphconnectbiconnectView, i : Int, v : Double) -> GraphconnectbiconnectView {
  let result = graph_connect_biconnect_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_view_sum(s : GraphconnectbiconnectView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_view_mean(s : GraphconnectbiconnectView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_view_scale(s : GraphconnectbiconnectView, f : Double) -> GraphconnectbiconnectView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_view_add(a : GraphconnectbiconnectView, b : GraphconnectbiconnectView) -> GraphconnectbiconnectView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_view_copy(s : GraphconnectbiconnectView) -> GraphconnectbiconnectView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_view_fill(s : GraphconnectbiconnectView, v : Double) -> GraphconnectbiconnectView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_view_min(s : GraphconnectbiconnectView) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_view_max(s : GraphconnectbiconnectView) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_view_to_string(s : GraphconnectbiconnectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_range_make(size : Int) -> GraphconnectbiconnectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_range_len(s : GraphconnectbiconnectRange) -> Int { s.size }

pub fn graph_connect_biconnect_range_get(s : GraphconnectbiconnectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_range_set(s : GraphconnectbiconnectRange, i : Int, v : Double) -> GraphconnectbiconnectRange {
  let result = graph_connect_biconnect_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_range_sum(s : GraphconnectbiconnectRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_range_mean(s : GraphconnectbiconnectRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_range_scale(s : GraphconnectbiconnectRange, f : Double) -> GraphconnectbiconnectRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_range_add(a : GraphconnectbiconnectRange, b : GraphconnectbiconnectRange) -> GraphconnectbiconnectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_range_copy(s : GraphconnectbiconnectRange) -> GraphconnectbiconnectRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_range_fill(s : GraphconnectbiconnectRange, v : Double) -> GraphconnectbiconnectRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_range_min(s : GraphconnectbiconnectRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_range_max(s : GraphconnectbiconnectRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_range_to_string(s : GraphconnectbiconnectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_slice_make(size : Int) -> GraphconnectbiconnectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_slice_len(s : GraphconnectbiconnectSlice) -> Int { s.size }

pub fn graph_connect_biconnect_slice_get(s : GraphconnectbiconnectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_slice_set(s : GraphconnectbiconnectSlice, i : Int, v : Double) -> GraphconnectbiconnectSlice {
  let result = graph_connect_biconnect_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_slice_sum(s : GraphconnectbiconnectSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_biconnect_slice_mean(s : GraphconnectbiconnectSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_biconnect_slice_scale(s : GraphconnectbiconnectSlice, f : Double) -> GraphconnectbiconnectSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_slice_add(a : GraphconnectbiconnectSlice, b : GraphconnectbiconnectSlice) -> GraphconnectbiconnectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_biconnect_slice_copy(s : GraphconnectbiconnectSlice) -> GraphconnectbiconnectSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_slice_fill(s : GraphconnectbiconnectSlice, v : Double) -> GraphconnectbiconnectSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_biconnect_slice_min(s : GraphconnectbiconnectSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_biconnect_slice_max(s : GraphconnectbiconnectSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_biconnect_slice_to_string(s : GraphconnectbiconnectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

