///===
/// extcore/nlp_parse_dependency

pub(all) struct NlpparsedependencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_dependency_make_point(x : Double, y : Double) -> NlpparsedependencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_dependency_make_point3(x : Double, y : Double, z : Double) -> NlpparsedependencyPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_dependency_point_x(pt : NlpparsedependencyPoint) -> Double { pt.x }

pub fn nlp_parse_dependency_point_y(pt : NlpparsedependencyPoint) -> Double { pt.y }

pub fn nlp_parse_dependency_point_z(pt : NlpparsedependencyPoint) -> Double { pt.z }

pub fn nlp_parse_dependency_point_label(pt : NlpparsedependencyPoint) -> Int { pt.label }

pub fn nlp_parse_dependency_point_dist(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_dependency_point_add(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_dependency_point_sub(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_dependency_point_scale(pt : NlpparsedependencyPoint, s : Double) -> NlpparsedependencyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_dependency_point_dot(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_dependency_point_cross(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_dependency_point_norm(pt : NlpparsedependencyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_dependency_point_normalize(pt : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  let n = nlp_parse_dependency_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_dependency_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_dependency_point_negate(pt : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_dependency_point_mid(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint) -> NlpparsedependencyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_dependency_point_lerp(a : NlpparsedependencyPoint, b : NlpparsedependencyPoint, t : Double) -> NlpparsedependencyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_dependency_point_to_string(pt : NlpparsedependencyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsedependencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_dependency_make_series(vals : Array[Double], name : String) -> NlpparsedependencySeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_dependency_series_len(s : NlpparsedependencySeries) -> Int { s.vals.length() }

pub fn nlp_parse_dependency_series_sum(s : NlpparsedependencySeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_parse_dependency_series_mean(s : NlpparsedependencySeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_parse_dependency_series_min(s : NlpparsedependencySeries) -> Double { @_common.min(s.vals) }

pub fn nlp_parse_dependency_series_max(s : NlpparsedependencySeries) -> Double { @_common.max(s.vals) }

pub fn nlp_parse_dependency_series_range(s : NlpparsedependencySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_parse_dependency_series_var(s : NlpparsedependencySeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_parse_dependency_series_std(s : NlpparsedependencySeries) -> Double { @_common.std(s.vals) }

pub fn nlp_parse_dependency_series_median(s : NlpparsedependencySeries) -> Double { @_common.median(s.vals) }

pub fn nlp_parse_dependency_series_scale(s : NlpparsedependencySeries, f : Double) -> NlpparsedependencySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_dependency_series_add(a : NlpparsedependencySeries, b : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_dependency_series_sub(a : NlpparsedependencySeries, b : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_dependency_series_normalize(s : NlpparsedependencySeries) -> NlpparsedependencySeries {
  let mn = nlp_parse_dependency_series_min(s)
  let mx = nlp_parse_dependency_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_dependency_series_cumsum(s : NlpparsedependencySeries) -> NlpparsedependencySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_dependency_series_to_string(s : NlpparsedependencySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsedependencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_dependency_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsedependencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_dependency_matrix_identity(n : Int) -> NlpparsedependencyMatrix {
  let m = nlp_parse_dependency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_dependency_matrix_get(m : NlpparsedependencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_dependency_matrix_transpose(m : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  let result = nlp_parse_dependency_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_dependency_matrix_add(a : NlpparsedependencyMatrix, b : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_dependency_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_dependency_matrix_scale(m : NlpparsedependencyMatrix, s : Double) -> NlpparsedependencyMatrix {
  let result = nlp_parse_dependency_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_dependency_matrix_multiply(a : NlpparsedependencyMatrix, b : NlpparsedependencyMatrix) -> NlpparsedependencyMatrix {
  if a.cols != b.rows { return nlp_parse_dependency_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_dependency_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_dependency_matrix_trace(m : NlpparsedependencyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_dependency_matrix_det(m : NlpparsedependencyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_dependency_matrix_norm(m : NlpparsedependencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_dependency_matrix_to_string(m : NlpparsedependencyMatrix) -> String {
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

pub(all) struct NlpparsedependencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_dependency_make_vector(comps : Array[Double]) -> NlpparsedependencyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_dependency_vector_zero(dim : Int) -> NlpparsedependencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_dependency_vector_add(a : NlpparsedependencyVector, b : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_dependency_vector_sub(a : NlpparsedependencyVector, b : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_dependency_vector_scale(v : NlpparsedependencyVector, s : Double) -> NlpparsedependencyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_dependency_vector_dot(a : NlpparsedependencyVector, b : NlpparsedependencyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_dependency_vector_norm(v : NlpparsedependencyVector) -> Double { @_common.sqrt(nlp_parse_dependency_vector_dot(v, v)) }

pub fn nlp_parse_dependency_vector_normalize(v : NlpparsedependencyVector) -> NlpparsedependencyVector {
  let n = nlp_parse_dependency_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_dependency_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_dependency_vector_dist(a : NlpparsedependencyVector, b : NlpparsedependencyVector) -> Double {
  nlp_parse_dependency_vector_norm(nlp_parse_dependency_vector_sub(a, b))
}

pub fn nlp_parse_dependency_vector_to_string(v : NlpparsedependencyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_dependency_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_dependency_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_dependency_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_dependency_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_dependency_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_dependency_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_dependency_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_dependency_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_dependency_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_dependency_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_dependency_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_dependency_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_dependency_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_dependency_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_dependency_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_dependency_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_dependency_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_dependency_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_dependency_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_dependency_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_dependency_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_dependency_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_dependency_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_dependency_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_dependency_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_dependency_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_dependency_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_dependency_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_dependency_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsedependencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_frame_make(size : Int) -> NlpparsedependencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_frame_len(s : NlpparsedependencyFrame) -> Int { s.size }

pub fn nlp_parse_dependency_frame_get(s : NlpparsedependencyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_frame_set(s : NlpparsedependencyFrame, i : Int, v : Double) -> NlpparsedependencyFrame {
  let result = nlp_parse_dependency_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_frame_sum(s : NlpparsedependencyFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_frame_mean(s : NlpparsedependencyFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_frame_scale(s : NlpparsedependencyFrame, f : Double) -> NlpparsedependencyFrame {
  let result = nlp_parse_dependency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_frame_add(a : NlpparsedependencyFrame, b : NlpparsedependencyFrame) -> NlpparsedependencyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_frame_copy(s : NlpparsedependencyFrame) -> NlpparsedependencyFrame {
  let result = nlp_parse_dependency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_frame_fill(s : NlpparsedependencyFrame, v : Double) -> NlpparsedependencyFrame {
  let result = nlp_parse_dependency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_frame_min(s : NlpparsedependencyFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_frame_max(s : NlpparsedependencyFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_frame_to_string(s : NlpparsedependencyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_table_make(size : Int) -> NlpparsedependencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_table_len(s : NlpparsedependencyTable) -> Int { s.size }

pub fn nlp_parse_dependency_table_get(s : NlpparsedependencyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_table_set(s : NlpparsedependencyTable, i : Int, v : Double) -> NlpparsedependencyTable {
  let result = nlp_parse_dependency_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_table_sum(s : NlpparsedependencyTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_table_mean(s : NlpparsedependencyTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_table_scale(s : NlpparsedependencyTable, f : Double) -> NlpparsedependencyTable {
  let result = nlp_parse_dependency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_table_add(a : NlpparsedependencyTable, b : NlpparsedependencyTable) -> NlpparsedependencyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_table_copy(s : NlpparsedependencyTable) -> NlpparsedependencyTable {
  let result = nlp_parse_dependency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_table_fill(s : NlpparsedependencyTable, v : Double) -> NlpparsedependencyTable {
  let result = nlp_parse_dependency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_table_min(s : NlpparsedependencyTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_table_max(s : NlpparsedependencyTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_table_to_string(s : NlpparsedependencyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_graphn_make(size : Int) -> NlpparsedependencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_graphn_len(s : NlpparsedependencyGraphN) -> Int { s.size }

pub fn nlp_parse_dependency_graphn_get(s : NlpparsedependencyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_graphn_set(s : NlpparsedependencyGraphN, i : Int, v : Double) -> NlpparsedependencyGraphN {
  let result = nlp_parse_dependency_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_graphn_sum(s : NlpparsedependencyGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_graphn_mean(s : NlpparsedependencyGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_graphn_scale(s : NlpparsedependencyGraphN, f : Double) -> NlpparsedependencyGraphN {
  let result = nlp_parse_dependency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_graphn_add(a : NlpparsedependencyGraphN, b : NlpparsedependencyGraphN) -> NlpparsedependencyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_graphn_copy(s : NlpparsedependencyGraphN) -> NlpparsedependencyGraphN {
  let result = nlp_parse_dependency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_graphn_fill(s : NlpparsedependencyGraphN, v : Double) -> NlpparsedependencyGraphN {
  let result = nlp_parse_dependency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_graphn_min(s : NlpparsedependencyGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_graphn_max(s : NlpparsedependencyGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_graphn_to_string(s : NlpparsedependencyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_node_make(size : Int) -> NlpparsedependencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_node_len(s : NlpparsedependencyNode) -> Int { s.size }

pub fn nlp_parse_dependency_node_get(s : NlpparsedependencyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_node_set(s : NlpparsedependencyNode, i : Int, v : Double) -> NlpparsedependencyNode {
  let result = nlp_parse_dependency_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_node_sum(s : NlpparsedependencyNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_node_mean(s : NlpparsedependencyNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_node_scale(s : NlpparsedependencyNode, f : Double) -> NlpparsedependencyNode {
  let result = nlp_parse_dependency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_node_add(a : NlpparsedependencyNode, b : NlpparsedependencyNode) -> NlpparsedependencyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_node_copy(s : NlpparsedependencyNode) -> NlpparsedependencyNode {
  let result = nlp_parse_dependency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_node_fill(s : NlpparsedependencyNode, v : Double) -> NlpparsedependencyNode {
  let result = nlp_parse_dependency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_node_min(s : NlpparsedependencyNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_node_max(s : NlpparsedependencyNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_node_to_string(s : NlpparsedependencyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_edge_make(size : Int) -> NlpparsedependencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_edge_len(s : NlpparsedependencyEdge) -> Int { s.size }

pub fn nlp_parse_dependency_edge_get(s : NlpparsedependencyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_edge_set(s : NlpparsedependencyEdge, i : Int, v : Double) -> NlpparsedependencyEdge {
  let result = nlp_parse_dependency_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_edge_sum(s : NlpparsedependencyEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_edge_mean(s : NlpparsedependencyEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_edge_scale(s : NlpparsedependencyEdge, f : Double) -> NlpparsedependencyEdge {
  let result = nlp_parse_dependency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_edge_add(a : NlpparsedependencyEdge, b : NlpparsedependencyEdge) -> NlpparsedependencyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_edge_copy(s : NlpparsedependencyEdge) -> NlpparsedependencyEdge {
  let result = nlp_parse_dependency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_edge_fill(s : NlpparsedependencyEdge, v : Double) -> NlpparsedependencyEdge {
  let result = nlp_parse_dependency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_edge_min(s : NlpparsedependencyEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_edge_max(s : NlpparsedependencyEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_edge_to_string(s : NlpparsedependencyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_path_make(size : Int) -> NlpparsedependencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_path_len(s : NlpparsedependencyPath) -> Int { s.size }

pub fn nlp_parse_dependency_path_get(s : NlpparsedependencyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_path_set(s : NlpparsedependencyPath, i : Int, v : Double) -> NlpparsedependencyPath {
  let result = nlp_parse_dependency_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_path_sum(s : NlpparsedependencyPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_path_mean(s : NlpparsedependencyPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_path_scale(s : NlpparsedependencyPath, f : Double) -> NlpparsedependencyPath {
  let result = nlp_parse_dependency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_path_add(a : NlpparsedependencyPath, b : NlpparsedependencyPath) -> NlpparsedependencyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_path_copy(s : NlpparsedependencyPath) -> NlpparsedependencyPath {
  let result = nlp_parse_dependency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_path_fill(s : NlpparsedependencyPath, v : Double) -> NlpparsedependencyPath {
  let result = nlp_parse_dependency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_path_min(s : NlpparsedependencyPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_path_max(s : NlpparsedependencyPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_path_to_string(s : NlpparsedependencyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_cluster_make(size : Int) -> NlpparsedependencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_cluster_len(s : NlpparsedependencyCluster) -> Int { s.size }

pub fn nlp_parse_dependency_cluster_get(s : NlpparsedependencyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_cluster_set(s : NlpparsedependencyCluster, i : Int, v : Double) -> NlpparsedependencyCluster {
  let result = nlp_parse_dependency_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_cluster_sum(s : NlpparsedependencyCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_cluster_mean(s : NlpparsedependencyCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_cluster_scale(s : NlpparsedependencyCluster, f : Double) -> NlpparsedependencyCluster {
  let result = nlp_parse_dependency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_cluster_add(a : NlpparsedependencyCluster, b : NlpparsedependencyCluster) -> NlpparsedependencyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_cluster_copy(s : NlpparsedependencyCluster) -> NlpparsedependencyCluster {
  let result = nlp_parse_dependency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_cluster_fill(s : NlpparsedependencyCluster, v : Double) -> NlpparsedependencyCluster {
  let result = nlp_parse_dependency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_cluster_min(s : NlpparsedependencyCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_cluster_max(s : NlpparsedependencyCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_cluster_to_string(s : NlpparsedependencyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_model_make(size : Int) -> NlpparsedependencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_model_len(s : NlpparsedependencyModel) -> Int { s.size }

pub fn nlp_parse_dependency_model_get(s : NlpparsedependencyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_model_set(s : NlpparsedependencyModel, i : Int, v : Double) -> NlpparsedependencyModel {
  let result = nlp_parse_dependency_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_model_sum(s : NlpparsedependencyModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_model_mean(s : NlpparsedependencyModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_model_scale(s : NlpparsedependencyModel, f : Double) -> NlpparsedependencyModel {
  let result = nlp_parse_dependency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_model_add(a : NlpparsedependencyModel, b : NlpparsedependencyModel) -> NlpparsedependencyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_model_copy(s : NlpparsedependencyModel) -> NlpparsedependencyModel {
  let result = nlp_parse_dependency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_model_fill(s : NlpparsedependencyModel, v : Double) -> NlpparsedependencyModel {
  let result = nlp_parse_dependency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_model_min(s : NlpparsedependencyModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_model_max(s : NlpparsedependencyModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_model_to_string(s : NlpparsedependencyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_layer_make(size : Int) -> NlpparsedependencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_layer_len(s : NlpparsedependencyLayer) -> Int { s.size }

pub fn nlp_parse_dependency_layer_get(s : NlpparsedependencyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_layer_set(s : NlpparsedependencyLayer, i : Int, v : Double) -> NlpparsedependencyLayer {
  let result = nlp_parse_dependency_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_layer_sum(s : NlpparsedependencyLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_layer_mean(s : NlpparsedependencyLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_layer_scale(s : NlpparsedependencyLayer, f : Double) -> NlpparsedependencyLayer {
  let result = nlp_parse_dependency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_layer_add(a : NlpparsedependencyLayer, b : NlpparsedependencyLayer) -> NlpparsedependencyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_layer_copy(s : NlpparsedependencyLayer) -> NlpparsedependencyLayer {
  let result = nlp_parse_dependency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_layer_fill(s : NlpparsedependencyLayer, v : Double) -> NlpparsedependencyLayer {
  let result = nlp_parse_dependency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_layer_min(s : NlpparsedependencyLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_layer_max(s : NlpparsedependencyLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_layer_to_string(s : NlpparsedependencyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_buffer_make(size : Int) -> NlpparsedependencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_buffer_len(s : NlpparsedependencyBuffer) -> Int { s.size }

pub fn nlp_parse_dependency_buffer_get(s : NlpparsedependencyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_buffer_set(s : NlpparsedependencyBuffer, i : Int, v : Double) -> NlpparsedependencyBuffer {
  let result = nlp_parse_dependency_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_buffer_sum(s : NlpparsedependencyBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_buffer_mean(s : NlpparsedependencyBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_buffer_scale(s : NlpparsedependencyBuffer, f : Double) -> NlpparsedependencyBuffer {
  let result = nlp_parse_dependency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_buffer_add(a : NlpparsedependencyBuffer, b : NlpparsedependencyBuffer) -> NlpparsedependencyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_buffer_copy(s : NlpparsedependencyBuffer) -> NlpparsedependencyBuffer {
  let result = nlp_parse_dependency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_buffer_fill(s : NlpparsedependencyBuffer, v : Double) -> NlpparsedependencyBuffer {
  let result = nlp_parse_dependency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_buffer_min(s : NlpparsedependencyBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_buffer_max(s : NlpparsedependencyBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_buffer_to_string(s : NlpparsedependencyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_cursor_make(size : Int) -> NlpparsedependencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_cursor_len(s : NlpparsedependencyCursor) -> Int { s.size }

pub fn nlp_parse_dependency_cursor_get(s : NlpparsedependencyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_cursor_set(s : NlpparsedependencyCursor, i : Int, v : Double) -> NlpparsedependencyCursor {
  let result = nlp_parse_dependency_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_cursor_sum(s : NlpparsedependencyCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_cursor_mean(s : NlpparsedependencyCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_cursor_scale(s : NlpparsedependencyCursor, f : Double) -> NlpparsedependencyCursor {
  let result = nlp_parse_dependency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_cursor_add(a : NlpparsedependencyCursor, b : NlpparsedependencyCursor) -> NlpparsedependencyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_cursor_copy(s : NlpparsedependencyCursor) -> NlpparsedependencyCursor {
  let result = nlp_parse_dependency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_cursor_fill(s : NlpparsedependencyCursor, v : Double) -> NlpparsedependencyCursor {
  let result = nlp_parse_dependency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_cursor_min(s : NlpparsedependencyCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_cursor_max(s : NlpparsedependencyCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_cursor_to_string(s : NlpparsedependencyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_view_make(size : Int) -> NlpparsedependencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_view_len(s : NlpparsedependencyView) -> Int { s.size }

pub fn nlp_parse_dependency_view_get(s : NlpparsedependencyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_view_set(s : NlpparsedependencyView, i : Int, v : Double) -> NlpparsedependencyView {
  let result = nlp_parse_dependency_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_view_sum(s : NlpparsedependencyView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_view_mean(s : NlpparsedependencyView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_view_scale(s : NlpparsedependencyView, f : Double) -> NlpparsedependencyView {
  let result = nlp_parse_dependency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_view_add(a : NlpparsedependencyView, b : NlpparsedependencyView) -> NlpparsedependencyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_view_copy(s : NlpparsedependencyView) -> NlpparsedependencyView {
  let result = nlp_parse_dependency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_view_fill(s : NlpparsedependencyView, v : Double) -> NlpparsedependencyView {
  let result = nlp_parse_dependency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_view_min(s : NlpparsedependencyView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_view_max(s : NlpparsedependencyView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_view_to_string(s : NlpparsedependencyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_range_make(size : Int) -> NlpparsedependencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_range_len(s : NlpparsedependencyRange) -> Int { s.size }

pub fn nlp_parse_dependency_range_get(s : NlpparsedependencyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_range_set(s : NlpparsedependencyRange, i : Int, v : Double) -> NlpparsedependencyRange {
  let result = nlp_parse_dependency_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_range_sum(s : NlpparsedependencyRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_range_mean(s : NlpparsedependencyRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_range_scale(s : NlpparsedependencyRange, f : Double) -> NlpparsedependencyRange {
  let result = nlp_parse_dependency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_range_add(a : NlpparsedependencyRange, b : NlpparsedependencyRange) -> NlpparsedependencyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_range_copy(s : NlpparsedependencyRange) -> NlpparsedependencyRange {
  let result = nlp_parse_dependency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_range_fill(s : NlpparsedependencyRange, v : Double) -> NlpparsedependencyRange {
  let result = nlp_parse_dependency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_range_min(s : NlpparsedependencyRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_range_max(s : NlpparsedependencyRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_range_to_string(s : NlpparsedependencyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsedependencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_dependency_slice_make(size : Int) -> NlpparsedependencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_dependency_slice_len(s : NlpparsedependencySlice) -> Int { s.size }

pub fn nlp_parse_dependency_slice_get(s : NlpparsedependencySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_dependency_slice_set(s : NlpparsedependencySlice, i : Int, v : Double) -> NlpparsedependencySlice {
  let result = nlp_parse_dependency_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_slice_sum(s : NlpparsedependencySlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_dependency_slice_mean(s : NlpparsedependencySlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_dependency_slice_scale(s : NlpparsedependencySlice, f : Double) -> NlpparsedependencySlice {
  let result = nlp_parse_dependency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_dependency_slice_add(a : NlpparsedependencySlice, b : NlpparsedependencySlice) -> NlpparsedependencySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_dependency_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_dependency_slice_copy(s : NlpparsedependencySlice) -> NlpparsedependencySlice {
  let result = nlp_parse_dependency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_dependency_slice_fill(s : NlpparsedependencySlice, v : Double) -> NlpparsedependencySlice {
  let result = nlp_parse_dependency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_dependency_slice_min(s : NlpparsedependencySlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_dependency_slice_max(s : NlpparsedependencySlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_dependency_slice_to_string(s : NlpparsedependencySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

