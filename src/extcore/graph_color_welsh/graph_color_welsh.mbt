///===
/// extcore/graph_color_welsh

pub(all) struct GraphcolorwelshPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_welsh_make_point(x : Double, y : Double) -> GraphcolorwelshPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_welsh_make_point3(x : Double, y : Double, z : Double) -> GraphcolorwelshPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_welsh_point_x(pt : GraphcolorwelshPoint) -> Double { pt.x }

pub fn graph_color_welsh_point_y(pt : GraphcolorwelshPoint) -> Double { pt.y }

pub fn graph_color_welsh_point_z(pt : GraphcolorwelshPoint) -> Double { pt.z }

pub fn graph_color_welsh_point_label(pt : GraphcolorwelshPoint) -> Int { pt.label }

pub fn graph_color_welsh_point_dist(a : GraphcolorwelshPoint, b : GraphcolorwelshPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_welsh_point_add(a : GraphcolorwelshPoint, b : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_welsh_point_sub(a : GraphcolorwelshPoint, b : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_welsh_point_scale(pt : GraphcolorwelshPoint, s : Double) -> GraphcolorwelshPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_welsh_point_dot(a : GraphcolorwelshPoint, b : GraphcolorwelshPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_welsh_point_cross(a : GraphcolorwelshPoint, b : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_welsh_point_norm(pt : GraphcolorwelshPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_welsh_point_normalize(pt : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  let n = graph_color_welsh_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_welsh_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_welsh_point_negate(pt : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_welsh_point_mid(a : GraphcolorwelshPoint, b : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_welsh_point_lerp(a : GraphcolorwelshPoint, b : GraphcolorwelshPoint, t : Double) -> GraphcolorwelshPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_welsh_point_to_string(pt : GraphcolorwelshPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorwelshSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_welsh_make_series(vals : Array[Double], name : String) -> GraphcolorwelshSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_welsh_series_len(s : GraphcolorwelshSeries) -> Int { s.vals.length() }

pub fn graph_color_welsh_series_sum(s : GraphcolorwelshSeries) -> Double { @_common.sum(s.vals) }

pub fn graph_color_welsh_series_mean(s : GraphcolorwelshSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_color_welsh_series_min(s : GraphcolorwelshSeries) -> Double { @_common.min(s.vals) }

pub fn graph_color_welsh_series_max(s : GraphcolorwelshSeries) -> Double { @_common.max(s.vals) }

pub fn graph_color_welsh_series_range(s : GraphcolorwelshSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_color_welsh_series_var(s : GraphcolorwelshSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_color_welsh_series_std(s : GraphcolorwelshSeries) -> Double { @_common.std(s.vals) }

pub fn graph_color_welsh_series_median(s : GraphcolorwelshSeries) -> Double { @_common.median(s.vals) }

pub fn graph_color_welsh_series_scale(s : GraphcolorwelshSeries, f : Double) -> GraphcolorwelshSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_welsh_series_add(a : GraphcolorwelshSeries, b : GraphcolorwelshSeries) -> GraphcolorwelshSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_welsh_series_sub(a : GraphcolorwelshSeries, b : GraphcolorwelshSeries) -> GraphcolorwelshSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_welsh_series_normalize(s : GraphcolorwelshSeries) -> GraphcolorwelshSeries {
  let mn = graph_color_welsh_series_min(s)
  let mx = graph_color_welsh_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_welsh_series_cumsum(s : GraphcolorwelshSeries) -> GraphcolorwelshSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_welsh_series_to_string(s : GraphcolorwelshSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorwelshMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_welsh_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorwelshMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_welsh_matrix_identity(n : Int) -> GraphcolorwelshMatrix {
  let m = graph_color_welsh_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_welsh_matrix_get(m : GraphcolorwelshMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_welsh_matrix_transpose(m : GraphcolorwelshMatrix) -> GraphcolorwelshMatrix {
  let result = graph_color_welsh_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_welsh_matrix_add(a : GraphcolorwelshMatrix, b : GraphcolorwelshMatrix) -> GraphcolorwelshMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_welsh_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_welsh_matrix_scale(m : GraphcolorwelshMatrix, s : Double) -> GraphcolorwelshMatrix {
  let result = graph_color_welsh_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_welsh_matrix_multiply(a : GraphcolorwelshMatrix, b : GraphcolorwelshMatrix) -> GraphcolorwelshMatrix {
  if a.cols != b.rows { return graph_color_welsh_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_welsh_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_welsh_matrix_trace(m : GraphcolorwelshMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_welsh_matrix_det(m : GraphcolorwelshMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_welsh_matrix_norm(m : GraphcolorwelshMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_welsh_matrix_to_string(m : GraphcolorwelshMatrix) -> String {
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

pub(all) struct GraphcolorwelshVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_welsh_make_vector(comps : Array[Double]) -> GraphcolorwelshVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_welsh_vector_zero(dim : Int) -> GraphcolorwelshVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_welsh_vector_add(a : GraphcolorwelshVector, b : GraphcolorwelshVector) -> GraphcolorwelshVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_welsh_vector_sub(a : GraphcolorwelshVector, b : GraphcolorwelshVector) -> GraphcolorwelshVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_welsh_vector_scale(v : GraphcolorwelshVector, s : Double) -> GraphcolorwelshVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_welsh_vector_dot(a : GraphcolorwelshVector, b : GraphcolorwelshVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_welsh_vector_norm(v : GraphcolorwelshVector) -> Double { @_common.sqrt(graph_color_welsh_vector_dot(v, v)) }

pub fn graph_color_welsh_vector_normalize(v : GraphcolorwelshVector) -> GraphcolorwelshVector {
  let n = graph_color_welsh_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_welsh_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_welsh_vector_dist(a : GraphcolorwelshVector, b : GraphcolorwelshVector) -> Double {
  graph_color_welsh_vector_norm(graph_color_welsh_vector_sub(a, b))
}

pub fn graph_color_welsh_vector_to_string(v : GraphcolorwelshVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_welsh_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_welsh_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_welsh_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_welsh_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_welsh_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_welsh_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_welsh_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_welsh_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_welsh_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_welsh_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_welsh_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_welsh_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_welsh_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_welsh_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_welsh_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_welsh_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_welsh_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_welsh_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_welsh_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_welsh_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_welsh_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_welsh_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_welsh_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_welsh_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_welsh_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_welsh_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_welsh_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_welsh_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_welsh_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorwelshFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_frame_make(size : Int) -> GraphcolorwelshFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_frame_len(s : GraphcolorwelshFrame) -> Int { s.size }

pub fn graph_color_welsh_frame_get(s : GraphcolorwelshFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_frame_set(s : GraphcolorwelshFrame, i : Int, v : Double) -> GraphcolorwelshFrame {
  let result = graph_color_welsh_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_frame_sum(s : GraphcolorwelshFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_frame_mean(s : GraphcolorwelshFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_frame_scale(s : GraphcolorwelshFrame, f : Double) -> GraphcolorwelshFrame {
  let result = graph_color_welsh_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_frame_add(a : GraphcolorwelshFrame, b : GraphcolorwelshFrame) -> GraphcolorwelshFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_frame_copy(s : GraphcolorwelshFrame) -> GraphcolorwelshFrame {
  let result = graph_color_welsh_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_frame_fill(s : GraphcolorwelshFrame, v : Double) -> GraphcolorwelshFrame {
  let result = graph_color_welsh_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_frame_min(s : GraphcolorwelshFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_frame_max(s : GraphcolorwelshFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_frame_to_string(s : GraphcolorwelshFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_table_make(size : Int) -> GraphcolorwelshTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_table_len(s : GraphcolorwelshTable) -> Int { s.size }

pub fn graph_color_welsh_table_get(s : GraphcolorwelshTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_table_set(s : GraphcolorwelshTable, i : Int, v : Double) -> GraphcolorwelshTable {
  let result = graph_color_welsh_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_table_sum(s : GraphcolorwelshTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_table_mean(s : GraphcolorwelshTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_table_scale(s : GraphcolorwelshTable, f : Double) -> GraphcolorwelshTable {
  let result = graph_color_welsh_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_table_add(a : GraphcolorwelshTable, b : GraphcolorwelshTable) -> GraphcolorwelshTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_table_copy(s : GraphcolorwelshTable) -> GraphcolorwelshTable {
  let result = graph_color_welsh_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_table_fill(s : GraphcolorwelshTable, v : Double) -> GraphcolorwelshTable {
  let result = graph_color_welsh_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_table_min(s : GraphcolorwelshTable) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_table_max(s : GraphcolorwelshTable) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_table_to_string(s : GraphcolorwelshTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_graphn_make(size : Int) -> GraphcolorwelshGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_graphn_len(s : GraphcolorwelshGraphN) -> Int { s.size }

pub fn graph_color_welsh_graphn_get(s : GraphcolorwelshGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_graphn_set(s : GraphcolorwelshGraphN, i : Int, v : Double) -> GraphcolorwelshGraphN {
  let result = graph_color_welsh_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_graphn_sum(s : GraphcolorwelshGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_graphn_mean(s : GraphcolorwelshGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_graphn_scale(s : GraphcolorwelshGraphN, f : Double) -> GraphcolorwelshGraphN {
  let result = graph_color_welsh_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_graphn_add(a : GraphcolorwelshGraphN, b : GraphcolorwelshGraphN) -> GraphcolorwelshGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_graphn_copy(s : GraphcolorwelshGraphN) -> GraphcolorwelshGraphN {
  let result = graph_color_welsh_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_graphn_fill(s : GraphcolorwelshGraphN, v : Double) -> GraphcolorwelshGraphN {
  let result = graph_color_welsh_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_graphn_min(s : GraphcolorwelshGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_graphn_max(s : GraphcolorwelshGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_graphn_to_string(s : GraphcolorwelshGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_node_make(size : Int) -> GraphcolorwelshNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_node_len(s : GraphcolorwelshNode) -> Int { s.size }

pub fn graph_color_welsh_node_get(s : GraphcolorwelshNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_node_set(s : GraphcolorwelshNode, i : Int, v : Double) -> GraphcolorwelshNode {
  let result = graph_color_welsh_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_node_sum(s : GraphcolorwelshNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_node_mean(s : GraphcolorwelshNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_node_scale(s : GraphcolorwelshNode, f : Double) -> GraphcolorwelshNode {
  let result = graph_color_welsh_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_node_add(a : GraphcolorwelshNode, b : GraphcolorwelshNode) -> GraphcolorwelshNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_node_copy(s : GraphcolorwelshNode) -> GraphcolorwelshNode {
  let result = graph_color_welsh_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_node_fill(s : GraphcolorwelshNode, v : Double) -> GraphcolorwelshNode {
  let result = graph_color_welsh_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_node_min(s : GraphcolorwelshNode) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_node_max(s : GraphcolorwelshNode) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_node_to_string(s : GraphcolorwelshNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_edge_make(size : Int) -> GraphcolorwelshEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_edge_len(s : GraphcolorwelshEdge) -> Int { s.size }

pub fn graph_color_welsh_edge_get(s : GraphcolorwelshEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_edge_set(s : GraphcolorwelshEdge, i : Int, v : Double) -> GraphcolorwelshEdge {
  let result = graph_color_welsh_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_edge_sum(s : GraphcolorwelshEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_edge_mean(s : GraphcolorwelshEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_edge_scale(s : GraphcolorwelshEdge, f : Double) -> GraphcolorwelshEdge {
  let result = graph_color_welsh_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_edge_add(a : GraphcolorwelshEdge, b : GraphcolorwelshEdge) -> GraphcolorwelshEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_edge_copy(s : GraphcolorwelshEdge) -> GraphcolorwelshEdge {
  let result = graph_color_welsh_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_edge_fill(s : GraphcolorwelshEdge, v : Double) -> GraphcolorwelshEdge {
  let result = graph_color_welsh_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_edge_min(s : GraphcolorwelshEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_edge_max(s : GraphcolorwelshEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_edge_to_string(s : GraphcolorwelshEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_path_make(size : Int) -> GraphcolorwelshPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_path_len(s : GraphcolorwelshPath) -> Int { s.size }

pub fn graph_color_welsh_path_get(s : GraphcolorwelshPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_path_set(s : GraphcolorwelshPath, i : Int, v : Double) -> GraphcolorwelshPath {
  let result = graph_color_welsh_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_path_sum(s : GraphcolorwelshPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_path_mean(s : GraphcolorwelshPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_path_scale(s : GraphcolorwelshPath, f : Double) -> GraphcolorwelshPath {
  let result = graph_color_welsh_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_path_add(a : GraphcolorwelshPath, b : GraphcolorwelshPath) -> GraphcolorwelshPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_path_copy(s : GraphcolorwelshPath) -> GraphcolorwelshPath {
  let result = graph_color_welsh_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_path_fill(s : GraphcolorwelshPath, v : Double) -> GraphcolorwelshPath {
  let result = graph_color_welsh_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_path_min(s : GraphcolorwelshPath) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_path_max(s : GraphcolorwelshPath) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_path_to_string(s : GraphcolorwelshPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_cluster_make(size : Int) -> GraphcolorwelshCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_cluster_len(s : GraphcolorwelshCluster) -> Int { s.size }

pub fn graph_color_welsh_cluster_get(s : GraphcolorwelshCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_cluster_set(s : GraphcolorwelshCluster, i : Int, v : Double) -> GraphcolorwelshCluster {
  let result = graph_color_welsh_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_cluster_sum(s : GraphcolorwelshCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_cluster_mean(s : GraphcolorwelshCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_cluster_scale(s : GraphcolorwelshCluster, f : Double) -> GraphcolorwelshCluster {
  let result = graph_color_welsh_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_cluster_add(a : GraphcolorwelshCluster, b : GraphcolorwelshCluster) -> GraphcolorwelshCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_cluster_copy(s : GraphcolorwelshCluster) -> GraphcolorwelshCluster {
  let result = graph_color_welsh_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_cluster_fill(s : GraphcolorwelshCluster, v : Double) -> GraphcolorwelshCluster {
  let result = graph_color_welsh_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_cluster_min(s : GraphcolorwelshCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_cluster_max(s : GraphcolorwelshCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_cluster_to_string(s : GraphcolorwelshCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_model_make(size : Int) -> GraphcolorwelshModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_model_len(s : GraphcolorwelshModel) -> Int { s.size }

pub fn graph_color_welsh_model_get(s : GraphcolorwelshModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_model_set(s : GraphcolorwelshModel, i : Int, v : Double) -> GraphcolorwelshModel {
  let result = graph_color_welsh_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_model_sum(s : GraphcolorwelshModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_model_mean(s : GraphcolorwelshModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_model_scale(s : GraphcolorwelshModel, f : Double) -> GraphcolorwelshModel {
  let result = graph_color_welsh_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_model_add(a : GraphcolorwelshModel, b : GraphcolorwelshModel) -> GraphcolorwelshModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_model_copy(s : GraphcolorwelshModel) -> GraphcolorwelshModel {
  let result = graph_color_welsh_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_model_fill(s : GraphcolorwelshModel, v : Double) -> GraphcolorwelshModel {
  let result = graph_color_welsh_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_model_min(s : GraphcolorwelshModel) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_model_max(s : GraphcolorwelshModel) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_model_to_string(s : GraphcolorwelshModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_layer_make(size : Int) -> GraphcolorwelshLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_layer_len(s : GraphcolorwelshLayer) -> Int { s.size }

pub fn graph_color_welsh_layer_get(s : GraphcolorwelshLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_layer_set(s : GraphcolorwelshLayer, i : Int, v : Double) -> GraphcolorwelshLayer {
  let result = graph_color_welsh_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_layer_sum(s : GraphcolorwelshLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_layer_mean(s : GraphcolorwelshLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_layer_scale(s : GraphcolorwelshLayer, f : Double) -> GraphcolorwelshLayer {
  let result = graph_color_welsh_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_layer_add(a : GraphcolorwelshLayer, b : GraphcolorwelshLayer) -> GraphcolorwelshLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_layer_copy(s : GraphcolorwelshLayer) -> GraphcolorwelshLayer {
  let result = graph_color_welsh_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_layer_fill(s : GraphcolorwelshLayer, v : Double) -> GraphcolorwelshLayer {
  let result = graph_color_welsh_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_layer_min(s : GraphcolorwelshLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_layer_max(s : GraphcolorwelshLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_layer_to_string(s : GraphcolorwelshLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_buffer_make(size : Int) -> GraphcolorwelshBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_buffer_len(s : GraphcolorwelshBuffer) -> Int { s.size }

pub fn graph_color_welsh_buffer_get(s : GraphcolorwelshBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_buffer_set(s : GraphcolorwelshBuffer, i : Int, v : Double) -> GraphcolorwelshBuffer {
  let result = graph_color_welsh_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_buffer_sum(s : GraphcolorwelshBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_buffer_mean(s : GraphcolorwelshBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_buffer_scale(s : GraphcolorwelshBuffer, f : Double) -> GraphcolorwelshBuffer {
  let result = graph_color_welsh_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_buffer_add(a : GraphcolorwelshBuffer, b : GraphcolorwelshBuffer) -> GraphcolorwelshBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_buffer_copy(s : GraphcolorwelshBuffer) -> GraphcolorwelshBuffer {
  let result = graph_color_welsh_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_buffer_fill(s : GraphcolorwelshBuffer, v : Double) -> GraphcolorwelshBuffer {
  let result = graph_color_welsh_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_buffer_min(s : GraphcolorwelshBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_buffer_max(s : GraphcolorwelshBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_buffer_to_string(s : GraphcolorwelshBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_cursor_make(size : Int) -> GraphcolorwelshCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_cursor_len(s : GraphcolorwelshCursor) -> Int { s.size }

pub fn graph_color_welsh_cursor_get(s : GraphcolorwelshCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_cursor_set(s : GraphcolorwelshCursor, i : Int, v : Double) -> GraphcolorwelshCursor {
  let result = graph_color_welsh_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_cursor_sum(s : GraphcolorwelshCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_cursor_mean(s : GraphcolorwelshCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_cursor_scale(s : GraphcolorwelshCursor, f : Double) -> GraphcolorwelshCursor {
  let result = graph_color_welsh_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_cursor_add(a : GraphcolorwelshCursor, b : GraphcolorwelshCursor) -> GraphcolorwelshCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_cursor_copy(s : GraphcolorwelshCursor) -> GraphcolorwelshCursor {
  let result = graph_color_welsh_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_cursor_fill(s : GraphcolorwelshCursor, v : Double) -> GraphcolorwelshCursor {
  let result = graph_color_welsh_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_cursor_min(s : GraphcolorwelshCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_cursor_max(s : GraphcolorwelshCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_cursor_to_string(s : GraphcolorwelshCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_view_make(size : Int) -> GraphcolorwelshView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_view_len(s : GraphcolorwelshView) -> Int { s.size }

pub fn graph_color_welsh_view_get(s : GraphcolorwelshView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_view_set(s : GraphcolorwelshView, i : Int, v : Double) -> GraphcolorwelshView {
  let result = graph_color_welsh_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_view_sum(s : GraphcolorwelshView) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_view_mean(s : GraphcolorwelshView) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_view_scale(s : GraphcolorwelshView, f : Double) -> GraphcolorwelshView {
  let result = graph_color_welsh_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_view_add(a : GraphcolorwelshView, b : GraphcolorwelshView) -> GraphcolorwelshView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_view_copy(s : GraphcolorwelshView) -> GraphcolorwelshView {
  let result = graph_color_welsh_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_view_fill(s : GraphcolorwelshView, v : Double) -> GraphcolorwelshView {
  let result = graph_color_welsh_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_view_min(s : GraphcolorwelshView) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_view_max(s : GraphcolorwelshView) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_view_to_string(s : GraphcolorwelshView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_range_make(size : Int) -> GraphcolorwelshRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_range_len(s : GraphcolorwelshRange) -> Int { s.size }

pub fn graph_color_welsh_range_get(s : GraphcolorwelshRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_range_set(s : GraphcolorwelshRange, i : Int, v : Double) -> GraphcolorwelshRange {
  let result = graph_color_welsh_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_range_sum(s : GraphcolorwelshRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_range_mean(s : GraphcolorwelshRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_range_scale(s : GraphcolorwelshRange, f : Double) -> GraphcolorwelshRange {
  let result = graph_color_welsh_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_range_add(a : GraphcolorwelshRange, b : GraphcolorwelshRange) -> GraphcolorwelshRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_range_copy(s : GraphcolorwelshRange) -> GraphcolorwelshRange {
  let result = graph_color_welsh_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_range_fill(s : GraphcolorwelshRange, v : Double) -> GraphcolorwelshRange {
  let result = graph_color_welsh_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_range_min(s : GraphcolorwelshRange) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_range_max(s : GraphcolorwelshRange) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_range_to_string(s : GraphcolorwelshRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_slice_make(size : Int) -> GraphcolorwelshSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_slice_len(s : GraphcolorwelshSlice) -> Int { s.size }

pub fn graph_color_welsh_slice_get(s : GraphcolorwelshSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_slice_set(s : GraphcolorwelshSlice, i : Int, v : Double) -> GraphcolorwelshSlice {
  let result = graph_color_welsh_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_slice_sum(s : GraphcolorwelshSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_slice_mean(s : GraphcolorwelshSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_slice_scale(s : GraphcolorwelshSlice, f : Double) -> GraphcolorwelshSlice {
  let result = graph_color_welsh_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_welsh_slice_add(a : GraphcolorwelshSlice, b : GraphcolorwelshSlice) -> GraphcolorwelshSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_welsh_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_welsh_slice_copy(s : GraphcolorwelshSlice) -> GraphcolorwelshSlice {
  let result = graph_color_welsh_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_welsh_slice_fill(s : GraphcolorwelshSlice, v : Double) -> GraphcolorwelshSlice {
  let result = graph_color_welsh_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_welsh_slice_min(s : GraphcolorwelshSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_slice_max(s : GraphcolorwelshSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_slice_to_string(s : GraphcolorwelshSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

