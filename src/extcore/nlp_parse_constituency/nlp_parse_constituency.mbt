///===
/// extcore/nlp_parse_constituency

pub(all) struct NlpparseconstituencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_constituency_make_point(x : Double, y : Double) -> NlpparseconstituencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_constituency_make_point3(x : Double, y : Double, z : Double) -> NlpparseconstituencyPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_constituency_point_x(pt : NlpparseconstituencyPoint) -> Double { pt.x }

pub fn nlp_parse_constituency_point_y(pt : NlpparseconstituencyPoint) -> Double { pt.y }

pub fn nlp_parse_constituency_point_z(pt : NlpparseconstituencyPoint) -> Double { pt.z }

pub fn nlp_parse_constituency_point_label(pt : NlpparseconstituencyPoint) -> Int { pt.label }

pub fn nlp_parse_constituency_point_dist(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_constituency_point_add(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_constituency_point_sub(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_constituency_point_scale(pt : NlpparseconstituencyPoint, s : Double) -> NlpparseconstituencyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_constituency_point_dot(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_constituency_point_cross(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_constituency_point_norm(pt : NlpparseconstituencyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_constituency_point_normalize(pt : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  let n = nlp_parse_constituency_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_constituency_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_constituency_point_negate(pt : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_constituency_point_mid(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint) -> NlpparseconstituencyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_constituency_point_lerp(a : NlpparseconstituencyPoint, b : NlpparseconstituencyPoint, t : Double) -> NlpparseconstituencyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_constituency_point_to_string(pt : NlpparseconstituencyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparseconstituencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_constituency_make_series(vals : Array[Double], name : String) -> NlpparseconstituencySeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_constituency_series_len(s : NlpparseconstituencySeries) -> Int { s.vals.length() }

pub fn nlp_parse_constituency_series_sum(s : NlpparseconstituencySeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_parse_constituency_series_mean(s : NlpparseconstituencySeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_parse_constituency_series_min(s : NlpparseconstituencySeries) -> Double { @_common.min(s.vals) }

pub fn nlp_parse_constituency_series_max(s : NlpparseconstituencySeries) -> Double { @_common.max(s.vals) }

pub fn nlp_parse_constituency_series_range(s : NlpparseconstituencySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_parse_constituency_series_var(s : NlpparseconstituencySeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_parse_constituency_series_std(s : NlpparseconstituencySeries) -> Double { @_common.std(s.vals) }

pub fn nlp_parse_constituency_series_median(s : NlpparseconstituencySeries) -> Double { @_common.median(s.vals) }

pub fn nlp_parse_constituency_series_scale(s : NlpparseconstituencySeries, f : Double) -> NlpparseconstituencySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_constituency_series_add(a : NlpparseconstituencySeries, b : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_constituency_series_sub(a : NlpparseconstituencySeries, b : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_constituency_series_normalize(s : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  let mn = nlp_parse_constituency_series_min(s)
  let mx = nlp_parse_constituency_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_constituency_series_cumsum(s : NlpparseconstituencySeries) -> NlpparseconstituencySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_constituency_series_to_string(s : NlpparseconstituencySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparseconstituencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_constituency_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparseconstituencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_constituency_matrix_identity(n : Int) -> NlpparseconstituencyMatrix {
  let m = nlp_parse_constituency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_constituency_matrix_get(m : NlpparseconstituencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_constituency_matrix_transpose(m : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  let result = nlp_parse_constituency_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_constituency_matrix_add(a : NlpparseconstituencyMatrix, b : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_constituency_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_constituency_matrix_scale(m : NlpparseconstituencyMatrix, s : Double) -> NlpparseconstituencyMatrix {
  let result = nlp_parse_constituency_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_constituency_matrix_multiply(a : NlpparseconstituencyMatrix, b : NlpparseconstituencyMatrix) -> NlpparseconstituencyMatrix {
  if a.cols != b.rows { return nlp_parse_constituency_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_constituency_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_constituency_matrix_trace(m : NlpparseconstituencyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_constituency_matrix_det(m : NlpparseconstituencyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_constituency_matrix_norm(m : NlpparseconstituencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_constituency_matrix_to_string(m : NlpparseconstituencyMatrix) -> String {
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

pub(all) struct NlpparseconstituencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_constituency_make_vector(comps : Array[Double]) -> NlpparseconstituencyVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_constituency_vector_zero(dim : Int) -> NlpparseconstituencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_constituency_vector_add(a : NlpparseconstituencyVector, b : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_constituency_vector_sub(a : NlpparseconstituencyVector, b : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_constituency_vector_scale(v : NlpparseconstituencyVector, s : Double) -> NlpparseconstituencyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_constituency_vector_dot(a : NlpparseconstituencyVector, b : NlpparseconstituencyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_constituency_vector_norm(v : NlpparseconstituencyVector) -> Double { @_common.sqrt(nlp_parse_constituency_vector_dot(v, v)) }

pub fn nlp_parse_constituency_vector_normalize(v : NlpparseconstituencyVector) -> NlpparseconstituencyVector {
  let n = nlp_parse_constituency_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_constituency_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_constituency_vector_dist(a : NlpparseconstituencyVector, b : NlpparseconstituencyVector) -> Double {
  nlp_parse_constituency_vector_norm(nlp_parse_constituency_vector_sub(a, b))
}

pub fn nlp_parse_constituency_vector_to_string(v : NlpparseconstituencyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_constituency_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_constituency_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_constituency_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_constituency_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_constituency_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_constituency_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_constituency_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_constituency_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_constituency_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_constituency_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_constituency_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_constituency_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_constituency_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_constituency_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_constituency_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_constituency_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_constituency_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_constituency_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_constituency_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_constituency_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_constituency_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_constituency_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_constituency_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_constituency_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_constituency_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_constituency_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_constituency_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_constituency_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_constituency_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparseconstituencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_frame_make(size : Int) -> NlpparseconstituencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_frame_len(s : NlpparseconstituencyFrame) -> Int { s.size }

pub fn nlp_parse_constituency_frame_get(s : NlpparseconstituencyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_frame_set(s : NlpparseconstituencyFrame, i : Int, v : Double) -> NlpparseconstituencyFrame {
  let result = nlp_parse_constituency_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_frame_sum(s : NlpparseconstituencyFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_frame_mean(s : NlpparseconstituencyFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_frame_scale(s : NlpparseconstituencyFrame, f : Double) -> NlpparseconstituencyFrame {
  let result = nlp_parse_constituency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_frame_add(a : NlpparseconstituencyFrame, b : NlpparseconstituencyFrame) -> NlpparseconstituencyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_frame_copy(s : NlpparseconstituencyFrame) -> NlpparseconstituencyFrame {
  let result = nlp_parse_constituency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_frame_fill(s : NlpparseconstituencyFrame, v : Double) -> NlpparseconstituencyFrame {
  let result = nlp_parse_constituency_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_frame_min(s : NlpparseconstituencyFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_frame_max(s : NlpparseconstituencyFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_frame_to_string(s : NlpparseconstituencyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_table_make(size : Int) -> NlpparseconstituencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_table_len(s : NlpparseconstituencyTable) -> Int { s.size }

pub fn nlp_parse_constituency_table_get(s : NlpparseconstituencyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_table_set(s : NlpparseconstituencyTable, i : Int, v : Double) -> NlpparseconstituencyTable {
  let result = nlp_parse_constituency_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_table_sum(s : NlpparseconstituencyTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_table_mean(s : NlpparseconstituencyTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_table_scale(s : NlpparseconstituencyTable, f : Double) -> NlpparseconstituencyTable {
  let result = nlp_parse_constituency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_table_add(a : NlpparseconstituencyTable, b : NlpparseconstituencyTable) -> NlpparseconstituencyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_table_copy(s : NlpparseconstituencyTable) -> NlpparseconstituencyTable {
  let result = nlp_parse_constituency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_table_fill(s : NlpparseconstituencyTable, v : Double) -> NlpparseconstituencyTable {
  let result = nlp_parse_constituency_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_table_min(s : NlpparseconstituencyTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_table_max(s : NlpparseconstituencyTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_table_to_string(s : NlpparseconstituencyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_graphn_make(size : Int) -> NlpparseconstituencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_graphn_len(s : NlpparseconstituencyGraphN) -> Int { s.size }

pub fn nlp_parse_constituency_graphn_get(s : NlpparseconstituencyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_graphn_set(s : NlpparseconstituencyGraphN, i : Int, v : Double) -> NlpparseconstituencyGraphN {
  let result = nlp_parse_constituency_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_graphn_sum(s : NlpparseconstituencyGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_graphn_mean(s : NlpparseconstituencyGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_graphn_scale(s : NlpparseconstituencyGraphN, f : Double) -> NlpparseconstituencyGraphN {
  let result = nlp_parse_constituency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_graphn_add(a : NlpparseconstituencyGraphN, b : NlpparseconstituencyGraphN) -> NlpparseconstituencyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_graphn_copy(s : NlpparseconstituencyGraphN) -> NlpparseconstituencyGraphN {
  let result = nlp_parse_constituency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_graphn_fill(s : NlpparseconstituencyGraphN, v : Double) -> NlpparseconstituencyGraphN {
  let result = nlp_parse_constituency_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_graphn_min(s : NlpparseconstituencyGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_graphn_max(s : NlpparseconstituencyGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_graphn_to_string(s : NlpparseconstituencyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_node_make(size : Int) -> NlpparseconstituencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_node_len(s : NlpparseconstituencyNode) -> Int { s.size }

pub fn nlp_parse_constituency_node_get(s : NlpparseconstituencyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_node_set(s : NlpparseconstituencyNode, i : Int, v : Double) -> NlpparseconstituencyNode {
  let result = nlp_parse_constituency_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_node_sum(s : NlpparseconstituencyNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_node_mean(s : NlpparseconstituencyNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_node_scale(s : NlpparseconstituencyNode, f : Double) -> NlpparseconstituencyNode {
  let result = nlp_parse_constituency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_node_add(a : NlpparseconstituencyNode, b : NlpparseconstituencyNode) -> NlpparseconstituencyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_node_copy(s : NlpparseconstituencyNode) -> NlpparseconstituencyNode {
  let result = nlp_parse_constituency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_node_fill(s : NlpparseconstituencyNode, v : Double) -> NlpparseconstituencyNode {
  let result = nlp_parse_constituency_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_node_min(s : NlpparseconstituencyNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_node_max(s : NlpparseconstituencyNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_node_to_string(s : NlpparseconstituencyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_edge_make(size : Int) -> NlpparseconstituencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_edge_len(s : NlpparseconstituencyEdge) -> Int { s.size }

pub fn nlp_parse_constituency_edge_get(s : NlpparseconstituencyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_edge_set(s : NlpparseconstituencyEdge, i : Int, v : Double) -> NlpparseconstituencyEdge {
  let result = nlp_parse_constituency_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_edge_sum(s : NlpparseconstituencyEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_edge_mean(s : NlpparseconstituencyEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_edge_scale(s : NlpparseconstituencyEdge, f : Double) -> NlpparseconstituencyEdge {
  let result = nlp_parse_constituency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_edge_add(a : NlpparseconstituencyEdge, b : NlpparseconstituencyEdge) -> NlpparseconstituencyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_edge_copy(s : NlpparseconstituencyEdge) -> NlpparseconstituencyEdge {
  let result = nlp_parse_constituency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_edge_fill(s : NlpparseconstituencyEdge, v : Double) -> NlpparseconstituencyEdge {
  let result = nlp_parse_constituency_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_edge_min(s : NlpparseconstituencyEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_edge_max(s : NlpparseconstituencyEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_edge_to_string(s : NlpparseconstituencyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_path_make(size : Int) -> NlpparseconstituencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_path_len(s : NlpparseconstituencyPath) -> Int { s.size }

pub fn nlp_parse_constituency_path_get(s : NlpparseconstituencyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_path_set(s : NlpparseconstituencyPath, i : Int, v : Double) -> NlpparseconstituencyPath {
  let result = nlp_parse_constituency_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_path_sum(s : NlpparseconstituencyPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_path_mean(s : NlpparseconstituencyPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_path_scale(s : NlpparseconstituencyPath, f : Double) -> NlpparseconstituencyPath {
  let result = nlp_parse_constituency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_path_add(a : NlpparseconstituencyPath, b : NlpparseconstituencyPath) -> NlpparseconstituencyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_path_copy(s : NlpparseconstituencyPath) -> NlpparseconstituencyPath {
  let result = nlp_parse_constituency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_path_fill(s : NlpparseconstituencyPath, v : Double) -> NlpparseconstituencyPath {
  let result = nlp_parse_constituency_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_path_min(s : NlpparseconstituencyPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_path_max(s : NlpparseconstituencyPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_path_to_string(s : NlpparseconstituencyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_cluster_make(size : Int) -> NlpparseconstituencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_cluster_len(s : NlpparseconstituencyCluster) -> Int { s.size }

pub fn nlp_parse_constituency_cluster_get(s : NlpparseconstituencyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_cluster_set(s : NlpparseconstituencyCluster, i : Int, v : Double) -> NlpparseconstituencyCluster {
  let result = nlp_parse_constituency_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_cluster_sum(s : NlpparseconstituencyCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_cluster_mean(s : NlpparseconstituencyCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_cluster_scale(s : NlpparseconstituencyCluster, f : Double) -> NlpparseconstituencyCluster {
  let result = nlp_parse_constituency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_cluster_add(a : NlpparseconstituencyCluster, b : NlpparseconstituencyCluster) -> NlpparseconstituencyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_cluster_copy(s : NlpparseconstituencyCluster) -> NlpparseconstituencyCluster {
  let result = nlp_parse_constituency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_cluster_fill(s : NlpparseconstituencyCluster, v : Double) -> NlpparseconstituencyCluster {
  let result = nlp_parse_constituency_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_cluster_min(s : NlpparseconstituencyCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_cluster_max(s : NlpparseconstituencyCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_cluster_to_string(s : NlpparseconstituencyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_model_make(size : Int) -> NlpparseconstituencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_model_len(s : NlpparseconstituencyModel) -> Int { s.size }

pub fn nlp_parse_constituency_model_get(s : NlpparseconstituencyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_model_set(s : NlpparseconstituencyModel, i : Int, v : Double) -> NlpparseconstituencyModel {
  let result = nlp_parse_constituency_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_model_sum(s : NlpparseconstituencyModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_model_mean(s : NlpparseconstituencyModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_model_scale(s : NlpparseconstituencyModel, f : Double) -> NlpparseconstituencyModel {
  let result = nlp_parse_constituency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_model_add(a : NlpparseconstituencyModel, b : NlpparseconstituencyModel) -> NlpparseconstituencyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_model_copy(s : NlpparseconstituencyModel) -> NlpparseconstituencyModel {
  let result = nlp_parse_constituency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_model_fill(s : NlpparseconstituencyModel, v : Double) -> NlpparseconstituencyModel {
  let result = nlp_parse_constituency_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_model_min(s : NlpparseconstituencyModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_model_max(s : NlpparseconstituencyModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_model_to_string(s : NlpparseconstituencyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_layer_make(size : Int) -> NlpparseconstituencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_layer_len(s : NlpparseconstituencyLayer) -> Int { s.size }

pub fn nlp_parse_constituency_layer_get(s : NlpparseconstituencyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_layer_set(s : NlpparseconstituencyLayer, i : Int, v : Double) -> NlpparseconstituencyLayer {
  let result = nlp_parse_constituency_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_layer_sum(s : NlpparseconstituencyLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_layer_mean(s : NlpparseconstituencyLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_layer_scale(s : NlpparseconstituencyLayer, f : Double) -> NlpparseconstituencyLayer {
  let result = nlp_parse_constituency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_layer_add(a : NlpparseconstituencyLayer, b : NlpparseconstituencyLayer) -> NlpparseconstituencyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_layer_copy(s : NlpparseconstituencyLayer) -> NlpparseconstituencyLayer {
  let result = nlp_parse_constituency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_layer_fill(s : NlpparseconstituencyLayer, v : Double) -> NlpparseconstituencyLayer {
  let result = nlp_parse_constituency_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_layer_min(s : NlpparseconstituencyLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_layer_max(s : NlpparseconstituencyLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_layer_to_string(s : NlpparseconstituencyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_buffer_make(size : Int) -> NlpparseconstituencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_buffer_len(s : NlpparseconstituencyBuffer) -> Int { s.size }

pub fn nlp_parse_constituency_buffer_get(s : NlpparseconstituencyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_buffer_set(s : NlpparseconstituencyBuffer, i : Int, v : Double) -> NlpparseconstituencyBuffer {
  let result = nlp_parse_constituency_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_buffer_sum(s : NlpparseconstituencyBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_buffer_mean(s : NlpparseconstituencyBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_buffer_scale(s : NlpparseconstituencyBuffer, f : Double) -> NlpparseconstituencyBuffer {
  let result = nlp_parse_constituency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_buffer_add(a : NlpparseconstituencyBuffer, b : NlpparseconstituencyBuffer) -> NlpparseconstituencyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_buffer_copy(s : NlpparseconstituencyBuffer) -> NlpparseconstituencyBuffer {
  let result = nlp_parse_constituency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_buffer_fill(s : NlpparseconstituencyBuffer, v : Double) -> NlpparseconstituencyBuffer {
  let result = nlp_parse_constituency_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_buffer_min(s : NlpparseconstituencyBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_buffer_max(s : NlpparseconstituencyBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_buffer_to_string(s : NlpparseconstituencyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_cursor_make(size : Int) -> NlpparseconstituencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_cursor_len(s : NlpparseconstituencyCursor) -> Int { s.size }

pub fn nlp_parse_constituency_cursor_get(s : NlpparseconstituencyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_cursor_set(s : NlpparseconstituencyCursor, i : Int, v : Double) -> NlpparseconstituencyCursor {
  let result = nlp_parse_constituency_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_cursor_sum(s : NlpparseconstituencyCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_cursor_mean(s : NlpparseconstituencyCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_cursor_scale(s : NlpparseconstituencyCursor, f : Double) -> NlpparseconstituencyCursor {
  let result = nlp_parse_constituency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_cursor_add(a : NlpparseconstituencyCursor, b : NlpparseconstituencyCursor) -> NlpparseconstituencyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_cursor_copy(s : NlpparseconstituencyCursor) -> NlpparseconstituencyCursor {
  let result = nlp_parse_constituency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_cursor_fill(s : NlpparseconstituencyCursor, v : Double) -> NlpparseconstituencyCursor {
  let result = nlp_parse_constituency_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_cursor_min(s : NlpparseconstituencyCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_cursor_max(s : NlpparseconstituencyCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_cursor_to_string(s : NlpparseconstituencyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_view_make(size : Int) -> NlpparseconstituencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_view_len(s : NlpparseconstituencyView) -> Int { s.size }

pub fn nlp_parse_constituency_view_get(s : NlpparseconstituencyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_view_set(s : NlpparseconstituencyView, i : Int, v : Double) -> NlpparseconstituencyView {
  let result = nlp_parse_constituency_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_view_sum(s : NlpparseconstituencyView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_view_mean(s : NlpparseconstituencyView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_view_scale(s : NlpparseconstituencyView, f : Double) -> NlpparseconstituencyView {
  let result = nlp_parse_constituency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_view_add(a : NlpparseconstituencyView, b : NlpparseconstituencyView) -> NlpparseconstituencyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_view_copy(s : NlpparseconstituencyView) -> NlpparseconstituencyView {
  let result = nlp_parse_constituency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_view_fill(s : NlpparseconstituencyView, v : Double) -> NlpparseconstituencyView {
  let result = nlp_parse_constituency_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_view_min(s : NlpparseconstituencyView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_view_max(s : NlpparseconstituencyView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_view_to_string(s : NlpparseconstituencyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_range_make(size : Int) -> NlpparseconstituencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_range_len(s : NlpparseconstituencyRange) -> Int { s.size }

pub fn nlp_parse_constituency_range_get(s : NlpparseconstituencyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_range_set(s : NlpparseconstituencyRange, i : Int, v : Double) -> NlpparseconstituencyRange {
  let result = nlp_parse_constituency_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_range_sum(s : NlpparseconstituencyRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_range_mean(s : NlpparseconstituencyRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_range_scale(s : NlpparseconstituencyRange, f : Double) -> NlpparseconstituencyRange {
  let result = nlp_parse_constituency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_range_add(a : NlpparseconstituencyRange, b : NlpparseconstituencyRange) -> NlpparseconstituencyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_range_copy(s : NlpparseconstituencyRange) -> NlpparseconstituencyRange {
  let result = nlp_parse_constituency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_range_fill(s : NlpparseconstituencyRange, v : Double) -> NlpparseconstituencyRange {
  let result = nlp_parse_constituency_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_range_min(s : NlpparseconstituencyRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_range_max(s : NlpparseconstituencyRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_range_to_string(s : NlpparseconstituencyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparseconstituencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_constituency_slice_make(size : Int) -> NlpparseconstituencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_constituency_slice_len(s : NlpparseconstituencySlice) -> Int { s.size }

pub fn nlp_parse_constituency_slice_get(s : NlpparseconstituencySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_constituency_slice_set(s : NlpparseconstituencySlice, i : Int, v : Double) -> NlpparseconstituencySlice {
  let result = nlp_parse_constituency_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_slice_sum(s : NlpparseconstituencySlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_constituency_slice_mean(s : NlpparseconstituencySlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_constituency_slice_scale(s : NlpparseconstituencySlice, f : Double) -> NlpparseconstituencySlice {
  let result = nlp_parse_constituency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_constituency_slice_add(a : NlpparseconstituencySlice, b : NlpparseconstituencySlice) -> NlpparseconstituencySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_constituency_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_constituency_slice_copy(s : NlpparseconstituencySlice) -> NlpparseconstituencySlice {
  let result = nlp_parse_constituency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_constituency_slice_fill(s : NlpparseconstituencySlice, v : Double) -> NlpparseconstituencySlice {
  let result = nlp_parse_constituency_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_constituency_slice_min(s : NlpparseconstituencySlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_constituency_slice_max(s : NlpparseconstituencySlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_constituency_slice_to_string(s : NlpparseconstituencySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

