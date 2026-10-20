///===
/// extcore/graph_tree_mst_boruvka

pub(all) struct GraphtreemstboruvkaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_boruvka_make_point(x : Double, y : Double) -> GraphtreemstboruvkaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_boruvka_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstboruvkaPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_mst_boruvka_point_x(pt : GraphtreemstboruvkaPoint) -> Double { pt.x }

pub fn graph_tree_mst_boruvka_point_y(pt : GraphtreemstboruvkaPoint) -> Double { pt.y }

pub fn graph_tree_mst_boruvka_point_z(pt : GraphtreemstboruvkaPoint) -> Double { pt.z }

pub fn graph_tree_mst_boruvka_point_label(pt : GraphtreemstboruvkaPoint) -> Int { pt.label }

pub fn graph_tree_mst_boruvka_point_dist(a : GraphtreemstboruvkaPoint, b : GraphtreemstboruvkaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_mst_boruvka_point_add(a : GraphtreemstboruvkaPoint, b : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_mst_boruvka_point_sub(a : GraphtreemstboruvkaPoint, b : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_mst_boruvka_point_scale(pt : GraphtreemstboruvkaPoint, s : Double) -> GraphtreemstboruvkaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_mst_boruvka_point_dot(a : GraphtreemstboruvkaPoint, b : GraphtreemstboruvkaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_mst_boruvka_point_cross(a : GraphtreemstboruvkaPoint, b : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_mst_boruvka_point_norm(pt : GraphtreemstboruvkaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_mst_boruvka_point_normalize(pt : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  let n = graph_tree_mst_boruvka_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_mst_boruvka_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_mst_boruvka_point_negate(pt : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_mst_boruvka_point_mid(a : GraphtreemstboruvkaPoint, b : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_mst_boruvka_point_lerp(a : GraphtreemstboruvkaPoint, b : GraphtreemstboruvkaPoint, t : Double) -> GraphtreemstboruvkaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_mst_boruvka_point_to_string(pt : GraphtreemstboruvkaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_boruvka_make_series(vals : Array[Double], name : String) -> GraphtreemstboruvkaSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_mst_boruvka_series_len(s : GraphtreemstboruvkaSeries) -> Int { s.vals.length() }

pub fn graph_tree_mst_boruvka_series_sum(s : GraphtreemstboruvkaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_tree_mst_boruvka_series_mean(s : GraphtreemstboruvkaSeries) -> Double { @_common.mean(s.vals) }

pub fn graph_tree_mst_boruvka_series_min(s : GraphtreemstboruvkaSeries) -> Double { @_common.min(s.vals) }

pub fn graph_tree_mst_boruvka_series_max(s : GraphtreemstboruvkaSeries) -> Double { @_common.max(s.vals) }

pub fn graph_tree_mst_boruvka_series_range(s : GraphtreemstboruvkaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn graph_tree_mst_boruvka_series_var(s : GraphtreemstboruvkaSeries) -> Double { @_common.variance(s.vals) }

pub fn graph_tree_mst_boruvka_series_std(s : GraphtreemstboruvkaSeries) -> Double { @_common.std(s.vals) }

pub fn graph_tree_mst_boruvka_series_median(s : GraphtreemstboruvkaSeries) -> Double { @_common.median(s.vals) }

pub fn graph_tree_mst_boruvka_series_scale(s : GraphtreemstboruvkaSeries, f : Double) -> GraphtreemstboruvkaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_tree_mst_boruvka_series_add(a : GraphtreemstboruvkaSeries, b : GraphtreemstboruvkaSeries) -> GraphtreemstboruvkaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_mst_boruvka_series_sub(a : GraphtreemstboruvkaSeries, b : GraphtreemstboruvkaSeries) -> GraphtreemstboruvkaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_mst_boruvka_series_normalize(s : GraphtreemstboruvkaSeries) -> GraphtreemstboruvkaSeries {
  let mn = graph_tree_mst_boruvka_series_min(s)
  let mx = graph_tree_mst_boruvka_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_mst_boruvka_series_cumsum(s : GraphtreemstboruvkaSeries) -> GraphtreemstboruvkaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_mst_boruvka_series_to_string(s : GraphtreemstboruvkaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstboruvkaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_boruvka_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstboruvkaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_mst_boruvka_matrix_identity(n : Int) -> GraphtreemstboruvkaMatrix {
  let m = graph_tree_mst_boruvka_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_mst_boruvka_matrix_get(m : GraphtreemstboruvkaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_mst_boruvka_matrix_transpose(m : GraphtreemstboruvkaMatrix) -> GraphtreemstboruvkaMatrix {
  let result = graph_tree_mst_boruvka_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_mst_boruvka_matrix_add(a : GraphtreemstboruvkaMatrix, b : GraphtreemstboruvkaMatrix) -> GraphtreemstboruvkaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_mst_boruvka_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_mst_boruvka_matrix_scale(m : GraphtreemstboruvkaMatrix, s : Double) -> GraphtreemstboruvkaMatrix {
  let result = graph_tree_mst_boruvka_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_mst_boruvka_matrix_multiply(a : GraphtreemstboruvkaMatrix, b : GraphtreemstboruvkaMatrix) -> GraphtreemstboruvkaMatrix {
  if a.cols != b.rows { return graph_tree_mst_boruvka_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_mst_boruvka_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_mst_boruvka_matrix_trace(m : GraphtreemstboruvkaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_mst_boruvka_matrix_det(m : GraphtreemstboruvkaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_mst_boruvka_matrix_norm(m : GraphtreemstboruvkaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_tree_mst_boruvka_matrix_to_string(m : GraphtreemstboruvkaMatrix) -> String {
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

pub(all) struct GraphtreemstboruvkaVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_boruvka_make_vector(comps : Array[Double]) -> GraphtreemstboruvkaVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_boruvka_vector_zero(dim : Int) -> GraphtreemstboruvkaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_mst_boruvka_vector_add(a : GraphtreemstboruvkaVector, b : GraphtreemstboruvkaVector) -> GraphtreemstboruvkaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_mst_boruvka_vector_sub(a : GraphtreemstboruvkaVector, b : GraphtreemstboruvkaVector) -> GraphtreemstboruvkaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_mst_boruvka_vector_scale(v : GraphtreemstboruvkaVector, s : Double) -> GraphtreemstboruvkaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_tree_mst_boruvka_vector_dot(a : GraphtreemstboruvkaVector, b : GraphtreemstboruvkaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_mst_boruvka_vector_norm(v : GraphtreemstboruvkaVector) -> Double { @_common.sqrt(graph_tree_mst_boruvka_vector_dot(v, v)) }

pub fn graph_tree_mst_boruvka_vector_normalize(v : GraphtreemstboruvkaVector) -> GraphtreemstboruvkaVector {
  let n = graph_tree_mst_boruvka_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_mst_boruvka_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_mst_boruvka_vector_dist(a : GraphtreemstboruvkaVector, b : GraphtreemstboruvkaVector) -> Double {
  graph_tree_mst_boruvka_vector_norm(graph_tree_mst_boruvka_vector_sub(a, b))
}

pub fn graph_tree_mst_boruvka_vector_to_string(v : GraphtreemstboruvkaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_mst_boruvka_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_mst_boruvka_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_mst_boruvka_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_mst_boruvka_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_mst_boruvka_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_mst_boruvka_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_mst_boruvka_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_mst_boruvka_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_mst_boruvka_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_mst_boruvka_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_mst_boruvka_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_mst_boruvka_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_mst_boruvka_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_mst_boruvka_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_mst_boruvka_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_mst_boruvka_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_mst_boruvka_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_mst_boruvka_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_mst_boruvka_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_mst_boruvka_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_mst_boruvka_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_mst_boruvka_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_mst_boruvka_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_mst_boruvka_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_mst_boruvka_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_mst_boruvka_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_mst_boruvka_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_mst_boruvka_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_mst_boruvka_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreemstboruvkaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_frame_make(size : Int) -> GraphtreemstboruvkaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_frame_len(s : GraphtreemstboruvkaFrame) -> Int { s.size }

pub fn graph_tree_mst_boruvka_frame_get(s : GraphtreemstboruvkaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_frame_set(s : GraphtreemstboruvkaFrame, i : Int, v : Double) -> GraphtreemstboruvkaFrame {
  let result = graph_tree_mst_boruvka_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_frame_sum(s : GraphtreemstboruvkaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_frame_mean(s : GraphtreemstboruvkaFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_frame_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_frame_scale(s : GraphtreemstboruvkaFrame, f : Double) -> GraphtreemstboruvkaFrame {
  let result = graph_tree_mst_boruvka_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_frame_add(a : GraphtreemstboruvkaFrame, b : GraphtreemstboruvkaFrame) -> GraphtreemstboruvkaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_frame_copy(s : GraphtreemstboruvkaFrame) -> GraphtreemstboruvkaFrame {
  let result = graph_tree_mst_boruvka_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_frame_fill(s : GraphtreemstboruvkaFrame, v : Double) -> GraphtreemstboruvkaFrame {
  let result = graph_tree_mst_boruvka_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_frame_min(s : GraphtreemstboruvkaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_frame_max(s : GraphtreemstboruvkaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_frame_to_string(s : GraphtreemstboruvkaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_table_make(size : Int) -> GraphtreemstboruvkaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_table_len(s : GraphtreemstboruvkaTable) -> Int { s.size }

pub fn graph_tree_mst_boruvka_table_get(s : GraphtreemstboruvkaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_table_set(s : GraphtreemstboruvkaTable, i : Int, v : Double) -> GraphtreemstboruvkaTable {
  let result = graph_tree_mst_boruvka_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_table_sum(s : GraphtreemstboruvkaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_table_mean(s : GraphtreemstboruvkaTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_table_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_table_scale(s : GraphtreemstboruvkaTable, f : Double) -> GraphtreemstboruvkaTable {
  let result = graph_tree_mst_boruvka_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_table_add(a : GraphtreemstboruvkaTable, b : GraphtreemstboruvkaTable) -> GraphtreemstboruvkaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_table_copy(s : GraphtreemstboruvkaTable) -> GraphtreemstboruvkaTable {
  let result = graph_tree_mst_boruvka_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_table_fill(s : GraphtreemstboruvkaTable, v : Double) -> GraphtreemstboruvkaTable {
  let result = graph_tree_mst_boruvka_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_table_min(s : GraphtreemstboruvkaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_table_max(s : GraphtreemstboruvkaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_table_to_string(s : GraphtreemstboruvkaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_graphn_make(size : Int) -> GraphtreemstboruvkaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_graphn_len(s : GraphtreemstboruvkaGraphN) -> Int { s.size }

pub fn graph_tree_mst_boruvka_graphn_get(s : GraphtreemstboruvkaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_graphn_set(s : GraphtreemstboruvkaGraphN, i : Int, v : Double) -> GraphtreemstboruvkaGraphN {
  let result = graph_tree_mst_boruvka_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_graphn_sum(s : GraphtreemstboruvkaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_graphn_mean(s : GraphtreemstboruvkaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_graphn_scale(s : GraphtreemstboruvkaGraphN, f : Double) -> GraphtreemstboruvkaGraphN {
  let result = graph_tree_mst_boruvka_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_graphn_add(a : GraphtreemstboruvkaGraphN, b : GraphtreemstboruvkaGraphN) -> GraphtreemstboruvkaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_graphn_copy(s : GraphtreemstboruvkaGraphN) -> GraphtreemstboruvkaGraphN {
  let result = graph_tree_mst_boruvka_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_graphn_fill(s : GraphtreemstboruvkaGraphN, v : Double) -> GraphtreemstboruvkaGraphN {
  let result = graph_tree_mst_boruvka_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_graphn_min(s : GraphtreemstboruvkaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_graphn_max(s : GraphtreemstboruvkaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_graphn_to_string(s : GraphtreemstboruvkaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_node_make(size : Int) -> GraphtreemstboruvkaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_node_len(s : GraphtreemstboruvkaNode) -> Int { s.size }

pub fn graph_tree_mst_boruvka_node_get(s : GraphtreemstboruvkaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_node_set(s : GraphtreemstboruvkaNode, i : Int, v : Double) -> GraphtreemstboruvkaNode {
  let result = graph_tree_mst_boruvka_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_node_sum(s : GraphtreemstboruvkaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_node_mean(s : GraphtreemstboruvkaNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_node_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_node_scale(s : GraphtreemstboruvkaNode, f : Double) -> GraphtreemstboruvkaNode {
  let result = graph_tree_mst_boruvka_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_node_add(a : GraphtreemstboruvkaNode, b : GraphtreemstboruvkaNode) -> GraphtreemstboruvkaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_node_copy(s : GraphtreemstboruvkaNode) -> GraphtreemstboruvkaNode {
  let result = graph_tree_mst_boruvka_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_node_fill(s : GraphtreemstboruvkaNode, v : Double) -> GraphtreemstboruvkaNode {
  let result = graph_tree_mst_boruvka_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_node_min(s : GraphtreemstboruvkaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_node_max(s : GraphtreemstboruvkaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_node_to_string(s : GraphtreemstboruvkaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_edge_make(size : Int) -> GraphtreemstboruvkaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_edge_len(s : GraphtreemstboruvkaEdge) -> Int { s.size }

pub fn graph_tree_mst_boruvka_edge_get(s : GraphtreemstboruvkaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_edge_set(s : GraphtreemstboruvkaEdge, i : Int, v : Double) -> GraphtreemstboruvkaEdge {
  let result = graph_tree_mst_boruvka_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_edge_sum(s : GraphtreemstboruvkaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_edge_mean(s : GraphtreemstboruvkaEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_edge_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_edge_scale(s : GraphtreemstboruvkaEdge, f : Double) -> GraphtreemstboruvkaEdge {
  let result = graph_tree_mst_boruvka_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_edge_add(a : GraphtreemstboruvkaEdge, b : GraphtreemstboruvkaEdge) -> GraphtreemstboruvkaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_edge_copy(s : GraphtreemstboruvkaEdge) -> GraphtreemstboruvkaEdge {
  let result = graph_tree_mst_boruvka_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_edge_fill(s : GraphtreemstboruvkaEdge, v : Double) -> GraphtreemstboruvkaEdge {
  let result = graph_tree_mst_boruvka_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_edge_min(s : GraphtreemstboruvkaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_edge_max(s : GraphtreemstboruvkaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_edge_to_string(s : GraphtreemstboruvkaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_path_make(size : Int) -> GraphtreemstboruvkaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_path_len(s : GraphtreemstboruvkaPath) -> Int { s.size }

pub fn graph_tree_mst_boruvka_path_get(s : GraphtreemstboruvkaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_path_set(s : GraphtreemstboruvkaPath, i : Int, v : Double) -> GraphtreemstboruvkaPath {
  let result = graph_tree_mst_boruvka_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_path_sum(s : GraphtreemstboruvkaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_path_mean(s : GraphtreemstboruvkaPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_path_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_path_scale(s : GraphtreemstboruvkaPath, f : Double) -> GraphtreemstboruvkaPath {
  let result = graph_tree_mst_boruvka_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_path_add(a : GraphtreemstboruvkaPath, b : GraphtreemstboruvkaPath) -> GraphtreemstboruvkaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_path_copy(s : GraphtreemstboruvkaPath) -> GraphtreemstboruvkaPath {
  let result = graph_tree_mst_boruvka_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_path_fill(s : GraphtreemstboruvkaPath, v : Double) -> GraphtreemstboruvkaPath {
  let result = graph_tree_mst_boruvka_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_path_min(s : GraphtreemstboruvkaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_path_max(s : GraphtreemstboruvkaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_path_to_string(s : GraphtreemstboruvkaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_cluster_make(size : Int) -> GraphtreemstboruvkaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_cluster_len(s : GraphtreemstboruvkaCluster) -> Int { s.size }

pub fn graph_tree_mst_boruvka_cluster_get(s : GraphtreemstboruvkaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_cluster_set(s : GraphtreemstboruvkaCluster, i : Int, v : Double) -> GraphtreemstboruvkaCluster {
  let result = graph_tree_mst_boruvka_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_cluster_sum(s : GraphtreemstboruvkaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_cluster_mean(s : GraphtreemstboruvkaCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_cluster_scale(s : GraphtreemstboruvkaCluster, f : Double) -> GraphtreemstboruvkaCluster {
  let result = graph_tree_mst_boruvka_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_cluster_add(a : GraphtreemstboruvkaCluster, b : GraphtreemstboruvkaCluster) -> GraphtreemstboruvkaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_cluster_copy(s : GraphtreemstboruvkaCluster) -> GraphtreemstboruvkaCluster {
  let result = graph_tree_mst_boruvka_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_cluster_fill(s : GraphtreemstboruvkaCluster, v : Double) -> GraphtreemstboruvkaCluster {
  let result = graph_tree_mst_boruvka_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_cluster_min(s : GraphtreemstboruvkaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_cluster_max(s : GraphtreemstboruvkaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_cluster_to_string(s : GraphtreemstboruvkaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_model_make(size : Int) -> GraphtreemstboruvkaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_model_len(s : GraphtreemstboruvkaModel) -> Int { s.size }

pub fn graph_tree_mst_boruvka_model_get(s : GraphtreemstboruvkaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_model_set(s : GraphtreemstboruvkaModel, i : Int, v : Double) -> GraphtreemstboruvkaModel {
  let result = graph_tree_mst_boruvka_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_model_sum(s : GraphtreemstboruvkaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_model_mean(s : GraphtreemstboruvkaModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_model_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_model_scale(s : GraphtreemstboruvkaModel, f : Double) -> GraphtreemstboruvkaModel {
  let result = graph_tree_mst_boruvka_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_model_add(a : GraphtreemstboruvkaModel, b : GraphtreemstboruvkaModel) -> GraphtreemstboruvkaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_model_copy(s : GraphtreemstboruvkaModel) -> GraphtreemstboruvkaModel {
  let result = graph_tree_mst_boruvka_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_model_fill(s : GraphtreemstboruvkaModel, v : Double) -> GraphtreemstboruvkaModel {
  let result = graph_tree_mst_boruvka_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_model_min(s : GraphtreemstboruvkaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_model_max(s : GraphtreemstboruvkaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_model_to_string(s : GraphtreemstboruvkaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_layer_make(size : Int) -> GraphtreemstboruvkaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_layer_len(s : GraphtreemstboruvkaLayer) -> Int { s.size }

pub fn graph_tree_mst_boruvka_layer_get(s : GraphtreemstboruvkaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_layer_set(s : GraphtreemstboruvkaLayer, i : Int, v : Double) -> GraphtreemstboruvkaLayer {
  let result = graph_tree_mst_boruvka_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_layer_sum(s : GraphtreemstboruvkaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_layer_mean(s : GraphtreemstboruvkaLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_layer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_layer_scale(s : GraphtreemstboruvkaLayer, f : Double) -> GraphtreemstboruvkaLayer {
  let result = graph_tree_mst_boruvka_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_layer_add(a : GraphtreemstboruvkaLayer, b : GraphtreemstboruvkaLayer) -> GraphtreemstboruvkaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_layer_copy(s : GraphtreemstboruvkaLayer) -> GraphtreemstboruvkaLayer {
  let result = graph_tree_mst_boruvka_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_layer_fill(s : GraphtreemstboruvkaLayer, v : Double) -> GraphtreemstboruvkaLayer {
  let result = graph_tree_mst_boruvka_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_layer_min(s : GraphtreemstboruvkaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_layer_max(s : GraphtreemstboruvkaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_layer_to_string(s : GraphtreemstboruvkaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_buffer_make(size : Int) -> GraphtreemstboruvkaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_buffer_len(s : GraphtreemstboruvkaBuffer) -> Int { s.size }

pub fn graph_tree_mst_boruvka_buffer_get(s : GraphtreemstboruvkaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_buffer_set(s : GraphtreemstboruvkaBuffer, i : Int, v : Double) -> GraphtreemstboruvkaBuffer {
  let result = graph_tree_mst_boruvka_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_buffer_sum(s : GraphtreemstboruvkaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_buffer_mean(s : GraphtreemstboruvkaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_buffer_scale(s : GraphtreemstboruvkaBuffer, f : Double) -> GraphtreemstboruvkaBuffer {
  let result = graph_tree_mst_boruvka_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_buffer_add(a : GraphtreemstboruvkaBuffer, b : GraphtreemstboruvkaBuffer) -> GraphtreemstboruvkaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_buffer_copy(s : GraphtreemstboruvkaBuffer) -> GraphtreemstboruvkaBuffer {
  let result = graph_tree_mst_boruvka_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_buffer_fill(s : GraphtreemstboruvkaBuffer, v : Double) -> GraphtreemstboruvkaBuffer {
  let result = graph_tree_mst_boruvka_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_buffer_min(s : GraphtreemstboruvkaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_buffer_max(s : GraphtreemstboruvkaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_buffer_to_string(s : GraphtreemstboruvkaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_cursor_make(size : Int) -> GraphtreemstboruvkaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_cursor_len(s : GraphtreemstboruvkaCursor) -> Int { s.size }

pub fn graph_tree_mst_boruvka_cursor_get(s : GraphtreemstboruvkaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_cursor_set(s : GraphtreemstboruvkaCursor, i : Int, v : Double) -> GraphtreemstboruvkaCursor {
  let result = graph_tree_mst_boruvka_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_cursor_sum(s : GraphtreemstboruvkaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_cursor_mean(s : GraphtreemstboruvkaCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_cursor_scale(s : GraphtreemstboruvkaCursor, f : Double) -> GraphtreemstboruvkaCursor {
  let result = graph_tree_mst_boruvka_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_cursor_add(a : GraphtreemstboruvkaCursor, b : GraphtreemstboruvkaCursor) -> GraphtreemstboruvkaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_cursor_copy(s : GraphtreemstboruvkaCursor) -> GraphtreemstboruvkaCursor {
  let result = graph_tree_mst_boruvka_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_cursor_fill(s : GraphtreemstboruvkaCursor, v : Double) -> GraphtreemstboruvkaCursor {
  let result = graph_tree_mst_boruvka_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_cursor_min(s : GraphtreemstboruvkaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_cursor_max(s : GraphtreemstboruvkaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_cursor_to_string(s : GraphtreemstboruvkaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_view_make(size : Int) -> GraphtreemstboruvkaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_view_len(s : GraphtreemstboruvkaView) -> Int { s.size }

pub fn graph_tree_mst_boruvka_view_get(s : GraphtreemstboruvkaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_view_set(s : GraphtreemstboruvkaView, i : Int, v : Double) -> GraphtreemstboruvkaView {
  let result = graph_tree_mst_boruvka_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_view_sum(s : GraphtreemstboruvkaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_view_mean(s : GraphtreemstboruvkaView) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_view_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_view_scale(s : GraphtreemstboruvkaView, f : Double) -> GraphtreemstboruvkaView {
  let result = graph_tree_mst_boruvka_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_view_add(a : GraphtreemstboruvkaView, b : GraphtreemstboruvkaView) -> GraphtreemstboruvkaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_view_copy(s : GraphtreemstboruvkaView) -> GraphtreemstboruvkaView {
  let result = graph_tree_mst_boruvka_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_view_fill(s : GraphtreemstboruvkaView, v : Double) -> GraphtreemstboruvkaView {
  let result = graph_tree_mst_boruvka_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_view_min(s : GraphtreemstboruvkaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_view_max(s : GraphtreemstboruvkaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_view_to_string(s : GraphtreemstboruvkaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_range_make(size : Int) -> GraphtreemstboruvkaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_range_len(s : GraphtreemstboruvkaRange) -> Int { s.size }

pub fn graph_tree_mst_boruvka_range_get(s : GraphtreemstboruvkaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_range_set(s : GraphtreemstboruvkaRange, i : Int, v : Double) -> GraphtreemstboruvkaRange {
  let result = graph_tree_mst_boruvka_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_range_sum(s : GraphtreemstboruvkaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_range_mean(s : GraphtreemstboruvkaRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_range_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_range_scale(s : GraphtreemstboruvkaRange, f : Double) -> GraphtreemstboruvkaRange {
  let result = graph_tree_mst_boruvka_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_range_add(a : GraphtreemstboruvkaRange, b : GraphtreemstboruvkaRange) -> GraphtreemstboruvkaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_range_copy(s : GraphtreemstboruvkaRange) -> GraphtreemstboruvkaRange {
  let result = graph_tree_mst_boruvka_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_range_fill(s : GraphtreemstboruvkaRange, v : Double) -> GraphtreemstboruvkaRange {
  let result = graph_tree_mst_boruvka_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_range_min(s : GraphtreemstboruvkaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_range_max(s : GraphtreemstboruvkaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_range_to_string(s : GraphtreemstboruvkaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_slice_make(size : Int) -> GraphtreemstboruvkaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_slice_len(s : GraphtreemstboruvkaSlice) -> Int { s.size }

pub fn graph_tree_mst_boruvka_slice_get(s : GraphtreemstboruvkaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_slice_set(s : GraphtreemstboruvkaSlice, i : Int, v : Double) -> GraphtreemstboruvkaSlice {
  let result = graph_tree_mst_boruvka_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_slice_sum(s : GraphtreemstboruvkaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_boruvka_slice_mean(s : GraphtreemstboruvkaSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_boruvka_slice_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_boruvka_slice_scale(s : GraphtreemstboruvkaSlice, f : Double) -> GraphtreemstboruvkaSlice {
  let result = graph_tree_mst_boruvka_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_boruvka_slice_add(a : GraphtreemstboruvkaSlice, b : GraphtreemstboruvkaSlice) -> GraphtreemstboruvkaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_boruvka_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_slice_copy(s : GraphtreemstboruvkaSlice) -> GraphtreemstboruvkaSlice {
  let result = graph_tree_mst_boruvka_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_boruvka_slice_fill(s : GraphtreemstboruvkaSlice, v : Double) -> GraphtreemstboruvkaSlice {
  let result = graph_tree_mst_boruvka_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_boruvka_slice_min(s : GraphtreemstboruvkaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_slice_max(s : GraphtreemstboruvkaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_boruvka_slice_to_string(s : GraphtreemstboruvkaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

