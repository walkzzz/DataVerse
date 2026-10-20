///===
/// extcore/graph_connect_weak

pub(all) struct GraphconnectweakPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_weak_make_point(x : Double, y : Double) -> GraphconnectweakPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_weak_make_point3(x : Double, y : Double, z : Double) -> GraphconnectweakPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_weak_point_x(pt : GraphconnectweakPoint) -> Double { pt.x }

pub fn graph_connect_weak_point_y(pt : GraphconnectweakPoint) -> Double { pt.y }

pub fn graph_connect_weak_point_z(pt : GraphconnectweakPoint) -> Double { pt.z }

pub fn graph_connect_weak_point_label(pt : GraphconnectweakPoint) -> Int { pt.label }

pub fn graph_connect_weak_point_dist(a : GraphconnectweakPoint, b : GraphconnectweakPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_weak_point_add(a : GraphconnectweakPoint, b : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_weak_point_sub(a : GraphconnectweakPoint, b : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_weak_point_scale(pt : GraphconnectweakPoint, s : Double) -> GraphconnectweakPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_weak_point_dot(a : GraphconnectweakPoint, b : GraphconnectweakPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_weak_point_cross(a : GraphconnectweakPoint, b : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_weak_point_norm(pt : GraphconnectweakPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_weak_point_normalize(pt : GraphconnectweakPoint) -> GraphconnectweakPoint {
  let n = graph_connect_weak_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_weak_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_weak_point_negate(pt : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_weak_point_mid(a : GraphconnectweakPoint, b : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_weak_point_lerp(a : GraphconnectweakPoint, b : GraphconnectweakPoint, t : Double) -> GraphconnectweakPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_weak_point_to_string(pt : GraphconnectweakPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectweakSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_weak_make_series(vals : Array[Double], name : String) -> GraphconnectweakSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_weak_series_len(s : GraphconnectweakSeries) -> Int { s.vals.length() }

pub fn graph_connect_weak_series_sum(s : GraphconnectweakSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_connect_weak_series_mean(s : GraphconnectweakSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_connect_weak_series_min(s : GraphconnectweakSeries) -> Double { @_common.min(s.vals) }

pub fn graph_connect_weak_series_max(s : GraphconnectweakSeries) -> Double { @_common.max(s.vals) }

pub fn graph_connect_weak_series_range(s : GraphconnectweakSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_connect_weak_series_var(s : GraphconnectweakSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_connect_weak_series_std(s : GraphconnectweakSeries) -> Double { @_common.std(s.vals) }

pub fn graph_connect_weak_series_median(s : GraphconnectweakSeries) -> Double { @_common.median(s.vals) }

pub fn graph_connect_weak_series_scale(s : GraphconnectweakSeries, f : Double) -> GraphconnectweakSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_weak_series_add(a : GraphconnectweakSeries, b : GraphconnectweakSeries) -> GraphconnectweakSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_weak_series_sub(a : GraphconnectweakSeries, b : GraphconnectweakSeries) -> GraphconnectweakSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_weak_series_normalize(s : GraphconnectweakSeries) -> GraphconnectweakSeries {
  let mn = graph_connect_weak_series_min(s)
  let mx = graph_connect_weak_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_weak_series_cumsum(s : GraphconnectweakSeries) -> GraphconnectweakSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_weak_series_to_string(s : GraphconnectweakSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectweakMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_weak_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectweakMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_weak_matrix_identity(n : Int) -> GraphconnectweakMatrix {
  let m = graph_connect_weak_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_weak_matrix_get(m : GraphconnectweakMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_weak_matrix_transpose(m : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  let result = graph_connect_weak_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_weak_matrix_add(a : GraphconnectweakMatrix, b : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_weak_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_weak_matrix_scale(m : GraphconnectweakMatrix, s : Double) -> GraphconnectweakMatrix {
  let result = graph_connect_weak_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_weak_matrix_multiply(a : GraphconnectweakMatrix, b : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  if a.cols != b.rows { return graph_connect_weak_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_weak_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_weak_matrix_trace(m : GraphconnectweakMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_weak_matrix_det(m : GraphconnectweakMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_weak_matrix_norm(m : GraphconnectweakMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_weak_matrix_to_string(m : GraphconnectweakMatrix) -> String {
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

pub(all) struct GraphconnectweakVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_weak_make_vector(comps : Array[Double]) -> GraphconnectweakVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_weak_vector_zero(dim : Int) -> GraphconnectweakVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_weak_vector_add(a : GraphconnectweakVector, b : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_weak_vector_sub(a : GraphconnectweakVector, b : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_weak_vector_scale(v : GraphconnectweakVector, s : Double) -> GraphconnectweakVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_weak_vector_dot(a : GraphconnectweakVector, b : GraphconnectweakVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_weak_vector_norm(v : GraphconnectweakVector) -> Double { @_common.sqrt(graph_connect_weak_vector_dot(v, v)) }

pub fn graph_connect_weak_vector_normalize(v : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = graph_connect_weak_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_weak_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_weak_vector_dist(a : GraphconnectweakVector, b : GraphconnectweakVector) -> Double {
  graph_connect_weak_vector_norm(graph_connect_weak_vector_sub(a, b))
}

pub fn graph_connect_weak_vector_to_string(v : GraphconnectweakVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_weak_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_weak_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_weak_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_weak_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_weak_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_weak_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_weak_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_weak_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_weak_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_weak_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_weak_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_weak_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_weak_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_weak_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_weak_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_weak_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_weak_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_weak_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_weak_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_weak_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_weak_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_weak_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_weak_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_weak_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_weak_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_weak_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_weak_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_weak_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_weak_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectweakFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_frame_make(size : Int) -> GraphconnectweakFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_frame_len(s : GraphconnectweakFrame) -> Int { s.size }

pub fn graph_connect_weak_frame_get(s : GraphconnectweakFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_frame_set(s : GraphconnectweakFrame, i : Int, v : Double) -> GraphconnectweakFrame {
  let result = graph_connect_weak_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_frame_sum(s : GraphconnectweakFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_frame_mean(s : GraphconnectweakFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_frame_scale(s : GraphconnectweakFrame, f : Double) -> GraphconnectweakFrame {
  let result = graph_connect_weak_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_frame_add(a : GraphconnectweakFrame, b : GraphconnectweakFrame) -> GraphconnectweakFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_frame_copy(s : GraphconnectweakFrame) -> GraphconnectweakFrame {
  let result = graph_connect_weak_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_frame_fill(s : GraphconnectweakFrame, v : Double) -> GraphconnectweakFrame {
  let result = graph_connect_weak_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_frame_min(s : GraphconnectweakFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_frame_max(s : GraphconnectweakFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_frame_to_string(s : GraphconnectweakFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_table_make(size : Int) -> GraphconnectweakTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_table_len(s : GraphconnectweakTable) -> Int { s.size }

pub fn graph_connect_weak_table_get(s : GraphconnectweakTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_table_set(s : GraphconnectweakTable, i : Int, v : Double) -> GraphconnectweakTable {
  let result = graph_connect_weak_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_table_sum(s : GraphconnectweakTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_table_mean(s : GraphconnectweakTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_table_scale(s : GraphconnectweakTable, f : Double) -> GraphconnectweakTable {
  let result = graph_connect_weak_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_table_add(a : GraphconnectweakTable, b : GraphconnectweakTable) -> GraphconnectweakTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_table_copy(s : GraphconnectweakTable) -> GraphconnectweakTable {
  let result = graph_connect_weak_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_table_fill(s : GraphconnectweakTable, v : Double) -> GraphconnectweakTable {
  let result = graph_connect_weak_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_table_min(s : GraphconnectweakTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_table_max(s : GraphconnectweakTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_table_to_string(s : GraphconnectweakTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_graphn_make(size : Int) -> GraphconnectweakGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_graphn_len(s : GraphconnectweakGraphN) -> Int { s.size }

pub fn graph_connect_weak_graphn_get(s : GraphconnectweakGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_graphn_set(s : GraphconnectweakGraphN, i : Int, v : Double) -> GraphconnectweakGraphN {
  let result = graph_connect_weak_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_graphn_sum(s : GraphconnectweakGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_graphn_mean(s : GraphconnectweakGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_graphn_scale(s : GraphconnectweakGraphN, f : Double) -> GraphconnectweakGraphN {
  let result = graph_connect_weak_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_graphn_add(a : GraphconnectweakGraphN, b : GraphconnectweakGraphN) -> GraphconnectweakGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_graphn_copy(s : GraphconnectweakGraphN) -> GraphconnectweakGraphN {
  let result = graph_connect_weak_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_graphn_fill(s : GraphconnectweakGraphN, v : Double) -> GraphconnectweakGraphN {
  let result = graph_connect_weak_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_graphn_min(s : GraphconnectweakGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_graphn_max(s : GraphconnectweakGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_graphn_to_string(s : GraphconnectweakGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_node_make(size : Int) -> GraphconnectweakNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_node_len(s : GraphconnectweakNode) -> Int { s.size }

pub fn graph_connect_weak_node_get(s : GraphconnectweakNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_node_set(s : GraphconnectweakNode, i : Int, v : Double) -> GraphconnectweakNode {
  let result = graph_connect_weak_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_node_sum(s : GraphconnectweakNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_node_mean(s : GraphconnectweakNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_node_scale(s : GraphconnectweakNode, f : Double) -> GraphconnectweakNode {
  let result = graph_connect_weak_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_node_add(a : GraphconnectweakNode, b : GraphconnectweakNode) -> GraphconnectweakNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_node_copy(s : GraphconnectweakNode) -> GraphconnectweakNode {
  let result = graph_connect_weak_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_node_fill(s : GraphconnectweakNode, v : Double) -> GraphconnectweakNode {
  let result = graph_connect_weak_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_node_min(s : GraphconnectweakNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_node_max(s : GraphconnectweakNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_node_to_string(s : GraphconnectweakNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_edge_make(size : Int) -> GraphconnectweakEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_edge_len(s : GraphconnectweakEdge) -> Int { s.size }

pub fn graph_connect_weak_edge_get(s : GraphconnectweakEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_edge_set(s : GraphconnectweakEdge, i : Int, v : Double) -> GraphconnectweakEdge {
  let result = graph_connect_weak_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_edge_sum(s : GraphconnectweakEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_edge_mean(s : GraphconnectweakEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_edge_scale(s : GraphconnectweakEdge, f : Double) -> GraphconnectweakEdge {
  let result = graph_connect_weak_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_edge_add(a : GraphconnectweakEdge, b : GraphconnectweakEdge) -> GraphconnectweakEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_edge_copy(s : GraphconnectweakEdge) -> GraphconnectweakEdge {
  let result = graph_connect_weak_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_edge_fill(s : GraphconnectweakEdge, v : Double) -> GraphconnectweakEdge {
  let result = graph_connect_weak_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_edge_min(s : GraphconnectweakEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_edge_max(s : GraphconnectweakEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_edge_to_string(s : GraphconnectweakEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_path_make(size : Int) -> GraphconnectweakPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_path_len(s : GraphconnectweakPath) -> Int { s.size }

pub fn graph_connect_weak_path_get(s : GraphconnectweakPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_path_set(s : GraphconnectweakPath, i : Int, v : Double) -> GraphconnectweakPath {
  let result = graph_connect_weak_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_path_sum(s : GraphconnectweakPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_path_mean(s : GraphconnectweakPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_path_scale(s : GraphconnectweakPath, f : Double) -> GraphconnectweakPath {
  let result = graph_connect_weak_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_path_add(a : GraphconnectweakPath, b : GraphconnectweakPath) -> GraphconnectweakPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_path_copy(s : GraphconnectweakPath) -> GraphconnectweakPath {
  let result = graph_connect_weak_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_path_fill(s : GraphconnectweakPath, v : Double) -> GraphconnectweakPath {
  let result = graph_connect_weak_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_path_min(s : GraphconnectweakPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_path_max(s : GraphconnectweakPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_path_to_string(s : GraphconnectweakPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_cluster_make(size : Int) -> GraphconnectweakCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_cluster_len(s : GraphconnectweakCluster) -> Int { s.size }

pub fn graph_connect_weak_cluster_get(s : GraphconnectweakCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_cluster_set(s : GraphconnectweakCluster, i : Int, v : Double) -> GraphconnectweakCluster {
  let result = graph_connect_weak_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_cluster_sum(s : GraphconnectweakCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_cluster_mean(s : GraphconnectweakCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_cluster_scale(s : GraphconnectweakCluster, f : Double) -> GraphconnectweakCluster {
  let result = graph_connect_weak_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_cluster_add(a : GraphconnectweakCluster, b : GraphconnectweakCluster) -> GraphconnectweakCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_cluster_copy(s : GraphconnectweakCluster) -> GraphconnectweakCluster {
  let result = graph_connect_weak_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_cluster_fill(s : GraphconnectweakCluster, v : Double) -> GraphconnectweakCluster {
  let result = graph_connect_weak_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_cluster_min(s : GraphconnectweakCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_cluster_max(s : GraphconnectweakCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_cluster_to_string(s : GraphconnectweakCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_model_make(size : Int) -> GraphconnectweakModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_model_len(s : GraphconnectweakModel) -> Int { s.size }

pub fn graph_connect_weak_model_get(s : GraphconnectweakModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_model_set(s : GraphconnectweakModel, i : Int, v : Double) -> GraphconnectweakModel {
  let result = graph_connect_weak_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_model_sum(s : GraphconnectweakModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_model_mean(s : GraphconnectweakModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_model_scale(s : GraphconnectweakModel, f : Double) -> GraphconnectweakModel {
  let result = graph_connect_weak_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_model_add(a : GraphconnectweakModel, b : GraphconnectweakModel) -> GraphconnectweakModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_model_copy(s : GraphconnectweakModel) -> GraphconnectweakModel {
  let result = graph_connect_weak_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_model_fill(s : GraphconnectweakModel, v : Double) -> GraphconnectweakModel {
  let result = graph_connect_weak_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_model_min(s : GraphconnectweakModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_model_max(s : GraphconnectweakModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_model_to_string(s : GraphconnectweakModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_layer_make(size : Int) -> GraphconnectweakLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_layer_len(s : GraphconnectweakLayer) -> Int { s.size }

pub fn graph_connect_weak_layer_get(s : GraphconnectweakLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_layer_set(s : GraphconnectweakLayer, i : Int, v : Double) -> GraphconnectweakLayer {
  let result = graph_connect_weak_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_layer_sum(s : GraphconnectweakLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_layer_mean(s : GraphconnectweakLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_layer_scale(s : GraphconnectweakLayer, f : Double) -> GraphconnectweakLayer {
  let result = graph_connect_weak_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_layer_add(a : GraphconnectweakLayer, b : GraphconnectweakLayer) -> GraphconnectweakLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_layer_copy(s : GraphconnectweakLayer) -> GraphconnectweakLayer {
  let result = graph_connect_weak_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_layer_fill(s : GraphconnectweakLayer, v : Double) -> GraphconnectweakLayer {
  let result = graph_connect_weak_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_layer_min(s : GraphconnectweakLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_layer_max(s : GraphconnectweakLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_layer_to_string(s : GraphconnectweakLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_buffer_make(size : Int) -> GraphconnectweakBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_buffer_len(s : GraphconnectweakBuffer) -> Int { s.size }

pub fn graph_connect_weak_buffer_get(s : GraphconnectweakBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_buffer_set(s : GraphconnectweakBuffer, i : Int, v : Double) -> GraphconnectweakBuffer {
  let result = graph_connect_weak_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_buffer_sum(s : GraphconnectweakBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_buffer_mean(s : GraphconnectweakBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_buffer_scale(s : GraphconnectweakBuffer, f : Double) -> GraphconnectweakBuffer {
  let result = graph_connect_weak_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_buffer_add(a : GraphconnectweakBuffer, b : GraphconnectweakBuffer) -> GraphconnectweakBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_buffer_copy(s : GraphconnectweakBuffer) -> GraphconnectweakBuffer {
  let result = graph_connect_weak_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_buffer_fill(s : GraphconnectweakBuffer, v : Double) -> GraphconnectweakBuffer {
  let result = graph_connect_weak_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_buffer_min(s : GraphconnectweakBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_buffer_max(s : GraphconnectweakBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_buffer_to_string(s : GraphconnectweakBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_cursor_make(size : Int) -> GraphconnectweakCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_cursor_len(s : GraphconnectweakCursor) -> Int { s.size }

pub fn graph_connect_weak_cursor_get(s : GraphconnectweakCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_cursor_set(s : GraphconnectweakCursor, i : Int, v : Double) -> GraphconnectweakCursor {
  let result = graph_connect_weak_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_cursor_sum(s : GraphconnectweakCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_cursor_mean(s : GraphconnectweakCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_cursor_scale(s : GraphconnectweakCursor, f : Double) -> GraphconnectweakCursor {
  let result = graph_connect_weak_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_cursor_add(a : GraphconnectweakCursor, b : GraphconnectweakCursor) -> GraphconnectweakCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_cursor_copy(s : GraphconnectweakCursor) -> GraphconnectweakCursor {
  let result = graph_connect_weak_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_cursor_fill(s : GraphconnectweakCursor, v : Double) -> GraphconnectweakCursor {
  let result = graph_connect_weak_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_cursor_min(s : GraphconnectweakCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_cursor_max(s : GraphconnectweakCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_cursor_to_string(s : GraphconnectweakCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_view_make(size : Int) -> GraphconnectweakView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_view_len(s : GraphconnectweakView) -> Int { s.size }

pub fn graph_connect_weak_view_get(s : GraphconnectweakView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_view_set(s : GraphconnectweakView, i : Int, v : Double) -> GraphconnectweakView {
  let result = graph_connect_weak_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_view_sum(s : GraphconnectweakView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_view_mean(s : GraphconnectweakView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_view_scale(s : GraphconnectweakView, f : Double) -> GraphconnectweakView {
  let result = graph_connect_weak_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_view_add(a : GraphconnectweakView, b : GraphconnectweakView) -> GraphconnectweakView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_view_copy(s : GraphconnectweakView) -> GraphconnectweakView {
  let result = graph_connect_weak_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_view_fill(s : GraphconnectweakView, v : Double) -> GraphconnectweakView {
  let result = graph_connect_weak_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_view_min(s : GraphconnectweakView) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_view_max(s : GraphconnectweakView) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_view_to_string(s : GraphconnectweakView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_range_make(size : Int) -> GraphconnectweakRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_range_len(s : GraphconnectweakRange) -> Int { s.size }

pub fn graph_connect_weak_range_get(s : GraphconnectweakRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_range_set(s : GraphconnectweakRange, i : Int, v : Double) -> GraphconnectweakRange {
  let result = graph_connect_weak_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_range_sum(s : GraphconnectweakRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_range_mean(s : GraphconnectweakRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_range_scale(s : GraphconnectweakRange, f : Double) -> GraphconnectweakRange {
  let result = graph_connect_weak_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_range_add(a : GraphconnectweakRange, b : GraphconnectweakRange) -> GraphconnectweakRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_range_copy(s : GraphconnectweakRange) -> GraphconnectweakRange {
  let result = graph_connect_weak_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_range_fill(s : GraphconnectweakRange, v : Double) -> GraphconnectweakRange {
  let result = graph_connect_weak_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_range_min(s : GraphconnectweakRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_range_max(s : GraphconnectweakRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_range_to_string(s : GraphconnectweakRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_slice_make(size : Int) -> GraphconnectweakSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_slice_len(s : GraphconnectweakSlice) -> Int { s.size }

pub fn graph_connect_weak_slice_get(s : GraphconnectweakSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_slice_set(s : GraphconnectweakSlice, i : Int, v : Double) -> GraphconnectweakSlice {
  let result = graph_connect_weak_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_slice_sum(s : GraphconnectweakSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_slice_mean(s : GraphconnectweakSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_slice_scale(s : GraphconnectweakSlice, f : Double) -> GraphconnectweakSlice {
  let result = graph_connect_weak_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_weak_slice_add(a : GraphconnectweakSlice, b : GraphconnectweakSlice) -> GraphconnectweakSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_weak_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_weak_slice_copy(s : GraphconnectweakSlice) -> GraphconnectweakSlice {
  let result = graph_connect_weak_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_weak_slice_fill(s : GraphconnectweakSlice, v : Double) -> GraphconnectweakSlice {
  let result = graph_connect_weak_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_weak_slice_min(s : GraphconnectweakSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_slice_max(s : GraphconnectweakSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_slice_to_string(s : GraphconnectweakSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

