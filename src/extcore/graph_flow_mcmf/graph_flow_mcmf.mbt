///===
/// extcore/graph_flow_mcmf

pub(all) struct GraphflowmcmfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_mcmf_make_point(x : Double, y : Double) -> GraphflowmcmfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_mcmf_make_point3(x : Double, y : Double, z : Double) -> GraphflowmcmfPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_mcmf_point_x(pt : GraphflowmcmfPoint) -> Double { pt.x }

pub fn graph_flow_mcmf_point_y(pt : GraphflowmcmfPoint) -> Double { pt.y }

pub fn graph_flow_mcmf_point_z(pt : GraphflowmcmfPoint) -> Double { pt.z }

pub fn graph_flow_mcmf_point_label(pt : GraphflowmcmfPoint) -> Int { pt.label }

pub fn graph_flow_mcmf_point_dist(a : GraphflowmcmfPoint, b : GraphflowmcmfPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_mcmf_point_add(a : GraphflowmcmfPoint, b : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_mcmf_point_sub(a : GraphflowmcmfPoint, b : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_mcmf_point_scale(pt : GraphflowmcmfPoint, s : Double) -> GraphflowmcmfPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_mcmf_point_dot(a : GraphflowmcmfPoint, b : GraphflowmcmfPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_mcmf_point_cross(a : GraphflowmcmfPoint, b : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_mcmf_point_norm(pt : GraphflowmcmfPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_mcmf_point_normalize(pt : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  let n = graph_flow_mcmf_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_mcmf_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_mcmf_point_negate(pt : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_mcmf_point_mid(a : GraphflowmcmfPoint, b : GraphflowmcmfPoint) -> GraphflowmcmfPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_mcmf_point_lerp(a : GraphflowmcmfPoint, b : GraphflowmcmfPoint, t : Double) -> GraphflowmcmfPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_mcmf_point_to_string(pt : GraphflowmcmfPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowmcmfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_mcmf_make_series(vals : Array[Double], name : String) -> GraphflowmcmfSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_mcmf_series_len(s : GraphflowmcmfSeries) -> Int { s.vals.length() }

pub fn graph_flow_mcmf_series_sum(s : GraphflowmcmfSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_flow_mcmf_series_mean(s : GraphflowmcmfSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_flow_mcmf_series_min(s : GraphflowmcmfSeries) -> Double { @_common.min(s.vals) }

pub fn graph_flow_mcmf_series_max(s : GraphflowmcmfSeries) -> Double { @_common.max(s.vals) }

pub fn graph_flow_mcmf_series_range(s : GraphflowmcmfSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_flow_mcmf_series_var(s : GraphflowmcmfSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_flow_mcmf_series_std(s : GraphflowmcmfSeries) -> Double { @_common.std(s.vals) }

pub fn graph_flow_mcmf_series_median(s : GraphflowmcmfSeries) -> Double { @_common.median(s.vals) }

pub fn graph_flow_mcmf_series_scale(s : GraphflowmcmfSeries, f : Double) -> GraphflowmcmfSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_mcmf_series_add(a : GraphflowmcmfSeries, b : GraphflowmcmfSeries) -> GraphflowmcmfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_mcmf_series_sub(a : GraphflowmcmfSeries, b : GraphflowmcmfSeries) -> GraphflowmcmfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_mcmf_series_normalize(s : GraphflowmcmfSeries) -> GraphflowmcmfSeries {
  let mn = graph_flow_mcmf_series_min(s)
  let mx = graph_flow_mcmf_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_mcmf_series_cumsum(s : GraphflowmcmfSeries) -> GraphflowmcmfSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_mcmf_series_to_string(s : GraphflowmcmfSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmcmfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_mcmf_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmcmfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_mcmf_matrix_identity(n : Int) -> GraphflowmcmfMatrix {
  let m = graph_flow_mcmf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_mcmf_matrix_get(m : GraphflowmcmfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_mcmf_matrix_transpose(m : GraphflowmcmfMatrix) -> GraphflowmcmfMatrix {
  let result = graph_flow_mcmf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_mcmf_matrix_add(a : GraphflowmcmfMatrix, b : GraphflowmcmfMatrix) -> GraphflowmcmfMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_mcmf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_mcmf_matrix_scale(m : GraphflowmcmfMatrix, s : Double) -> GraphflowmcmfMatrix {
  let result = graph_flow_mcmf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_mcmf_matrix_multiply(a : GraphflowmcmfMatrix, b : GraphflowmcmfMatrix) -> GraphflowmcmfMatrix {
  if a.cols != b.rows { return graph_flow_mcmf_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_mcmf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_mcmf_matrix_trace(m : GraphflowmcmfMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_mcmf_matrix_det(m : GraphflowmcmfMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_mcmf_matrix_norm(m : GraphflowmcmfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_flow_mcmf_matrix_to_string(m : GraphflowmcmfMatrix) -> String {
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

pub(all) struct GraphflowmcmfVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_mcmf_make_vector(comps : Array[Double]) -> GraphflowmcmfVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_mcmf_vector_zero(dim : Int) -> GraphflowmcmfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_mcmf_vector_add(a : GraphflowmcmfVector, b : GraphflowmcmfVector) -> GraphflowmcmfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_mcmf_vector_sub(a : GraphflowmcmfVector, b : GraphflowmcmfVector) -> GraphflowmcmfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_mcmf_vector_scale(v : GraphflowmcmfVector, s : Double) -> GraphflowmcmfVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_mcmf_vector_dot(a : GraphflowmcmfVector, b : GraphflowmcmfVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_mcmf_vector_norm(v : GraphflowmcmfVector) -> Double { @_common.sqrt(graph_flow_mcmf_vector_dot(v, v)) }

pub fn graph_flow_mcmf_vector_normalize(v : GraphflowmcmfVector) -> GraphflowmcmfVector {
  let n = graph_flow_mcmf_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_mcmf_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_mcmf_vector_dist(a : GraphflowmcmfVector, b : GraphflowmcmfVector) -> Double {
  graph_flow_mcmf_vector_norm(graph_flow_mcmf_vector_sub(a, b))
}

pub fn graph_flow_mcmf_vector_to_string(v : GraphflowmcmfVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_mcmf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_mcmf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_mcmf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_mcmf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_mcmf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_mcmf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_mcmf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_mcmf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_mcmf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_mcmf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_mcmf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_mcmf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_mcmf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_mcmf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_mcmf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_mcmf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_mcmf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_mcmf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_mcmf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_mcmf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_mcmf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_mcmf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_mcmf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_mcmf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_mcmf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_mcmf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_mcmf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_mcmf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_mcmf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowmcmfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_frame_make(size : Int) -> GraphflowmcmfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_frame_len(s : GraphflowmcmfFrame) -> Int { s.size }

pub fn graph_flow_mcmf_frame_get(s : GraphflowmcmfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_frame_set(s : GraphflowmcmfFrame, i : Int, v : Double) -> GraphflowmcmfFrame {
  let result = graph_flow_mcmf_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_frame_sum(s : GraphflowmcmfFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_frame_mean(s : GraphflowmcmfFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_frame_scale(s : GraphflowmcmfFrame, f : Double) -> GraphflowmcmfFrame {
  let result = graph_flow_mcmf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_frame_add(a : GraphflowmcmfFrame, b : GraphflowmcmfFrame) -> GraphflowmcmfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_frame_copy(s : GraphflowmcmfFrame) -> GraphflowmcmfFrame {
  let result = graph_flow_mcmf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_frame_fill(s : GraphflowmcmfFrame, v : Double) -> GraphflowmcmfFrame {
  let result = graph_flow_mcmf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_frame_min(s : GraphflowmcmfFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_frame_max(s : GraphflowmcmfFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_frame_to_string(s : GraphflowmcmfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_table_make(size : Int) -> GraphflowmcmfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_table_len(s : GraphflowmcmfTable) -> Int { s.size }

pub fn graph_flow_mcmf_table_get(s : GraphflowmcmfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_table_set(s : GraphflowmcmfTable, i : Int, v : Double) -> GraphflowmcmfTable {
  let result = graph_flow_mcmf_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_table_sum(s : GraphflowmcmfTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_table_mean(s : GraphflowmcmfTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_table_scale(s : GraphflowmcmfTable, f : Double) -> GraphflowmcmfTable {
  let result = graph_flow_mcmf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_table_add(a : GraphflowmcmfTable, b : GraphflowmcmfTable) -> GraphflowmcmfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_table_copy(s : GraphflowmcmfTable) -> GraphflowmcmfTable {
  let result = graph_flow_mcmf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_table_fill(s : GraphflowmcmfTable, v : Double) -> GraphflowmcmfTable {
  let result = graph_flow_mcmf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_table_min(s : GraphflowmcmfTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_table_max(s : GraphflowmcmfTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_table_to_string(s : GraphflowmcmfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_graphn_make(size : Int) -> GraphflowmcmfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_graphn_len(s : GraphflowmcmfGraphN) -> Int { s.size }

pub fn graph_flow_mcmf_graphn_get(s : GraphflowmcmfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_graphn_set(s : GraphflowmcmfGraphN, i : Int, v : Double) -> GraphflowmcmfGraphN {
  let result = graph_flow_mcmf_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_graphn_sum(s : GraphflowmcmfGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_graphn_mean(s : GraphflowmcmfGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_graphn_scale(s : GraphflowmcmfGraphN, f : Double) -> GraphflowmcmfGraphN {
  let result = graph_flow_mcmf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_graphn_add(a : GraphflowmcmfGraphN, b : GraphflowmcmfGraphN) -> GraphflowmcmfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_graphn_copy(s : GraphflowmcmfGraphN) -> GraphflowmcmfGraphN {
  let result = graph_flow_mcmf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_graphn_fill(s : GraphflowmcmfGraphN, v : Double) -> GraphflowmcmfGraphN {
  let result = graph_flow_mcmf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_graphn_min(s : GraphflowmcmfGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_graphn_max(s : GraphflowmcmfGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_graphn_to_string(s : GraphflowmcmfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_node_make(size : Int) -> GraphflowmcmfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_node_len(s : GraphflowmcmfNode) -> Int { s.size }

pub fn graph_flow_mcmf_node_get(s : GraphflowmcmfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_node_set(s : GraphflowmcmfNode, i : Int, v : Double) -> GraphflowmcmfNode {
  let result = graph_flow_mcmf_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_node_sum(s : GraphflowmcmfNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_node_mean(s : GraphflowmcmfNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_node_scale(s : GraphflowmcmfNode, f : Double) -> GraphflowmcmfNode {
  let result = graph_flow_mcmf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_node_add(a : GraphflowmcmfNode, b : GraphflowmcmfNode) -> GraphflowmcmfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_node_copy(s : GraphflowmcmfNode) -> GraphflowmcmfNode {
  let result = graph_flow_mcmf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_node_fill(s : GraphflowmcmfNode, v : Double) -> GraphflowmcmfNode {
  let result = graph_flow_mcmf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_node_min(s : GraphflowmcmfNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_node_max(s : GraphflowmcmfNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_node_to_string(s : GraphflowmcmfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_edge_make(size : Int) -> GraphflowmcmfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_edge_len(s : GraphflowmcmfEdge) -> Int { s.size }

pub fn graph_flow_mcmf_edge_get(s : GraphflowmcmfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_edge_set(s : GraphflowmcmfEdge, i : Int, v : Double) -> GraphflowmcmfEdge {
  let result = graph_flow_mcmf_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_edge_sum(s : GraphflowmcmfEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_edge_mean(s : GraphflowmcmfEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_edge_scale(s : GraphflowmcmfEdge, f : Double) -> GraphflowmcmfEdge {
  let result = graph_flow_mcmf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_edge_add(a : GraphflowmcmfEdge, b : GraphflowmcmfEdge) -> GraphflowmcmfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_edge_copy(s : GraphflowmcmfEdge) -> GraphflowmcmfEdge {
  let result = graph_flow_mcmf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_edge_fill(s : GraphflowmcmfEdge, v : Double) -> GraphflowmcmfEdge {
  let result = graph_flow_mcmf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_edge_min(s : GraphflowmcmfEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_edge_max(s : GraphflowmcmfEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_edge_to_string(s : GraphflowmcmfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_path_make(size : Int) -> GraphflowmcmfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_path_len(s : GraphflowmcmfPath) -> Int { s.size }

pub fn graph_flow_mcmf_path_get(s : GraphflowmcmfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_path_set(s : GraphflowmcmfPath, i : Int, v : Double) -> GraphflowmcmfPath {
  let result = graph_flow_mcmf_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_path_sum(s : GraphflowmcmfPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_path_mean(s : GraphflowmcmfPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_path_scale(s : GraphflowmcmfPath, f : Double) -> GraphflowmcmfPath {
  let result = graph_flow_mcmf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_path_add(a : GraphflowmcmfPath, b : GraphflowmcmfPath) -> GraphflowmcmfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_path_copy(s : GraphflowmcmfPath) -> GraphflowmcmfPath {
  let result = graph_flow_mcmf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_path_fill(s : GraphflowmcmfPath, v : Double) -> GraphflowmcmfPath {
  let result = graph_flow_mcmf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_path_min(s : GraphflowmcmfPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_path_max(s : GraphflowmcmfPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_path_to_string(s : GraphflowmcmfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_cluster_make(size : Int) -> GraphflowmcmfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_cluster_len(s : GraphflowmcmfCluster) -> Int { s.size }

pub fn graph_flow_mcmf_cluster_get(s : GraphflowmcmfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_cluster_set(s : GraphflowmcmfCluster, i : Int, v : Double) -> GraphflowmcmfCluster {
  let result = graph_flow_mcmf_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_cluster_sum(s : GraphflowmcmfCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_cluster_mean(s : GraphflowmcmfCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_cluster_scale(s : GraphflowmcmfCluster, f : Double) -> GraphflowmcmfCluster {
  let result = graph_flow_mcmf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_cluster_add(a : GraphflowmcmfCluster, b : GraphflowmcmfCluster) -> GraphflowmcmfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_cluster_copy(s : GraphflowmcmfCluster) -> GraphflowmcmfCluster {
  let result = graph_flow_mcmf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_cluster_fill(s : GraphflowmcmfCluster, v : Double) -> GraphflowmcmfCluster {
  let result = graph_flow_mcmf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_cluster_min(s : GraphflowmcmfCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_cluster_max(s : GraphflowmcmfCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_cluster_to_string(s : GraphflowmcmfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_model_make(size : Int) -> GraphflowmcmfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_model_len(s : GraphflowmcmfModel) -> Int { s.size }

pub fn graph_flow_mcmf_model_get(s : GraphflowmcmfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_model_set(s : GraphflowmcmfModel, i : Int, v : Double) -> GraphflowmcmfModel {
  let result = graph_flow_mcmf_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_model_sum(s : GraphflowmcmfModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_model_mean(s : GraphflowmcmfModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_model_scale(s : GraphflowmcmfModel, f : Double) -> GraphflowmcmfModel {
  let result = graph_flow_mcmf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_model_add(a : GraphflowmcmfModel, b : GraphflowmcmfModel) -> GraphflowmcmfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_model_copy(s : GraphflowmcmfModel) -> GraphflowmcmfModel {
  let result = graph_flow_mcmf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_model_fill(s : GraphflowmcmfModel, v : Double) -> GraphflowmcmfModel {
  let result = graph_flow_mcmf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_model_min(s : GraphflowmcmfModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_model_max(s : GraphflowmcmfModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_model_to_string(s : GraphflowmcmfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_layer_make(size : Int) -> GraphflowmcmfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_layer_len(s : GraphflowmcmfLayer) -> Int { s.size }

pub fn graph_flow_mcmf_layer_get(s : GraphflowmcmfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_layer_set(s : GraphflowmcmfLayer, i : Int, v : Double) -> GraphflowmcmfLayer {
  let result = graph_flow_mcmf_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_layer_sum(s : GraphflowmcmfLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_layer_mean(s : GraphflowmcmfLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_layer_scale(s : GraphflowmcmfLayer, f : Double) -> GraphflowmcmfLayer {
  let result = graph_flow_mcmf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_layer_add(a : GraphflowmcmfLayer, b : GraphflowmcmfLayer) -> GraphflowmcmfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_layer_copy(s : GraphflowmcmfLayer) -> GraphflowmcmfLayer {
  let result = graph_flow_mcmf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_layer_fill(s : GraphflowmcmfLayer, v : Double) -> GraphflowmcmfLayer {
  let result = graph_flow_mcmf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_layer_min(s : GraphflowmcmfLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_layer_max(s : GraphflowmcmfLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_layer_to_string(s : GraphflowmcmfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_buffer_make(size : Int) -> GraphflowmcmfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_buffer_len(s : GraphflowmcmfBuffer) -> Int { s.size }

pub fn graph_flow_mcmf_buffer_get(s : GraphflowmcmfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_buffer_set(s : GraphflowmcmfBuffer, i : Int, v : Double) -> GraphflowmcmfBuffer {
  let result = graph_flow_mcmf_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_buffer_sum(s : GraphflowmcmfBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_buffer_mean(s : GraphflowmcmfBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_buffer_scale(s : GraphflowmcmfBuffer, f : Double) -> GraphflowmcmfBuffer {
  let result = graph_flow_mcmf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_buffer_add(a : GraphflowmcmfBuffer, b : GraphflowmcmfBuffer) -> GraphflowmcmfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_buffer_copy(s : GraphflowmcmfBuffer) -> GraphflowmcmfBuffer {
  let result = graph_flow_mcmf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_buffer_fill(s : GraphflowmcmfBuffer, v : Double) -> GraphflowmcmfBuffer {
  let result = graph_flow_mcmf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_buffer_min(s : GraphflowmcmfBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_buffer_max(s : GraphflowmcmfBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_buffer_to_string(s : GraphflowmcmfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_cursor_make(size : Int) -> GraphflowmcmfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_cursor_len(s : GraphflowmcmfCursor) -> Int { s.size }

pub fn graph_flow_mcmf_cursor_get(s : GraphflowmcmfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_cursor_set(s : GraphflowmcmfCursor, i : Int, v : Double) -> GraphflowmcmfCursor {
  let result = graph_flow_mcmf_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_cursor_sum(s : GraphflowmcmfCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_cursor_mean(s : GraphflowmcmfCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_cursor_scale(s : GraphflowmcmfCursor, f : Double) -> GraphflowmcmfCursor {
  let result = graph_flow_mcmf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_cursor_add(a : GraphflowmcmfCursor, b : GraphflowmcmfCursor) -> GraphflowmcmfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_cursor_copy(s : GraphflowmcmfCursor) -> GraphflowmcmfCursor {
  let result = graph_flow_mcmf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_cursor_fill(s : GraphflowmcmfCursor, v : Double) -> GraphflowmcmfCursor {
  let result = graph_flow_mcmf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_cursor_min(s : GraphflowmcmfCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_cursor_max(s : GraphflowmcmfCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_cursor_to_string(s : GraphflowmcmfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_view_make(size : Int) -> GraphflowmcmfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_view_len(s : GraphflowmcmfView) -> Int { s.size }

pub fn graph_flow_mcmf_view_get(s : GraphflowmcmfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_view_set(s : GraphflowmcmfView, i : Int, v : Double) -> GraphflowmcmfView {
  let result = graph_flow_mcmf_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_view_sum(s : GraphflowmcmfView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_view_mean(s : GraphflowmcmfView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_view_scale(s : GraphflowmcmfView, f : Double) -> GraphflowmcmfView {
  let result = graph_flow_mcmf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_view_add(a : GraphflowmcmfView, b : GraphflowmcmfView) -> GraphflowmcmfView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_view_copy(s : GraphflowmcmfView) -> GraphflowmcmfView {
  let result = graph_flow_mcmf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_view_fill(s : GraphflowmcmfView, v : Double) -> GraphflowmcmfView {
  let result = graph_flow_mcmf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_view_min(s : GraphflowmcmfView) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_view_max(s : GraphflowmcmfView) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_view_to_string(s : GraphflowmcmfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_range_make(size : Int) -> GraphflowmcmfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_range_len(s : GraphflowmcmfRange) -> Int { s.size }

pub fn graph_flow_mcmf_range_get(s : GraphflowmcmfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_range_set(s : GraphflowmcmfRange, i : Int, v : Double) -> GraphflowmcmfRange {
  let result = graph_flow_mcmf_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_range_sum(s : GraphflowmcmfRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_range_mean(s : GraphflowmcmfRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_range_scale(s : GraphflowmcmfRange, f : Double) -> GraphflowmcmfRange {
  let result = graph_flow_mcmf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_range_add(a : GraphflowmcmfRange, b : GraphflowmcmfRange) -> GraphflowmcmfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_range_copy(s : GraphflowmcmfRange) -> GraphflowmcmfRange {
  let result = graph_flow_mcmf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_range_fill(s : GraphflowmcmfRange, v : Double) -> GraphflowmcmfRange {
  let result = graph_flow_mcmf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_range_min(s : GraphflowmcmfRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_range_max(s : GraphflowmcmfRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_range_to_string(s : GraphflowmcmfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmcmfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mcmf_slice_make(size : Int) -> GraphflowmcmfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mcmf_slice_len(s : GraphflowmcmfSlice) -> Int { s.size }

pub fn graph_flow_mcmf_slice_get(s : GraphflowmcmfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mcmf_slice_set(s : GraphflowmcmfSlice, i : Int, v : Double) -> GraphflowmcmfSlice {
  let result = graph_flow_mcmf_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_slice_sum(s : GraphflowmcmfSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mcmf_slice_mean(s : GraphflowmcmfSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mcmf_slice_scale(s : GraphflowmcmfSlice, f : Double) -> GraphflowmcmfSlice {
  let result = graph_flow_mcmf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_mcmf_slice_add(a : GraphflowmcmfSlice, b : GraphflowmcmfSlice) -> GraphflowmcmfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_mcmf_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_mcmf_slice_copy(s : GraphflowmcmfSlice) -> GraphflowmcmfSlice {
  let result = graph_flow_mcmf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_mcmf_slice_fill(s : GraphflowmcmfSlice, v : Double) -> GraphflowmcmfSlice {
  let result = graph_flow_mcmf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_mcmf_slice_min(s : GraphflowmcmfSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_mcmf_slice_max(s : GraphflowmcmfSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_mcmf_slice_to_string(s : GraphflowmcmfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

