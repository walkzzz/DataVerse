///===
/// extcore/nlp_parse_malt

pub(all) struct NlpparsemaltPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_malt_make_point(x : Double, y : Double) -> NlpparsemaltPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_malt_make_point3(x : Double, y : Double, z : Double) -> NlpparsemaltPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_malt_point_x(pt : NlpparsemaltPoint) -> Double { pt.x }

pub fn nlp_parse_malt_point_y(pt : NlpparsemaltPoint) -> Double { pt.y }

pub fn nlp_parse_malt_point_z(pt : NlpparsemaltPoint) -> Double { pt.z }

pub fn nlp_parse_malt_point_label(pt : NlpparsemaltPoint) -> Int { pt.label }

pub fn nlp_parse_malt_point_dist(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_malt_point_add(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_malt_point_sub(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_malt_point_scale(pt : NlpparsemaltPoint, s : Double) -> NlpparsemaltPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_malt_point_dot(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_malt_point_cross(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_malt_point_norm(pt : NlpparsemaltPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_malt_point_normalize(pt : NlpparsemaltPoint) -> NlpparsemaltPoint {
  let n = nlp_parse_malt_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_malt_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_malt_point_negate(pt : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_malt_point_mid(a : NlpparsemaltPoint, b : NlpparsemaltPoint) -> NlpparsemaltPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_malt_point_lerp(a : NlpparsemaltPoint, b : NlpparsemaltPoint, t : Double) -> NlpparsemaltPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_malt_point_to_string(pt : NlpparsemaltPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsemaltSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_malt_make_series(vals : Array[Double], name : String) -> NlpparsemaltSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_malt_series_len(s : NlpparsemaltSeries) -> Int { s.vals.length() }

pub fn nlp_parse_malt_series_sum(s : NlpparsemaltSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_parse_malt_series_mean(s : NlpparsemaltSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_parse_malt_series_min(s : NlpparsemaltSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_parse_malt_series_max(s : NlpparsemaltSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_parse_malt_series_range(s : NlpparsemaltSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_parse_malt_series_var(s : NlpparsemaltSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_parse_malt_series_std(s : NlpparsemaltSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_parse_malt_series_median(s : NlpparsemaltSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_parse_malt_series_scale(s : NlpparsemaltSeries, f : Double) -> NlpparsemaltSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_malt_series_add(a : NlpparsemaltSeries, b : NlpparsemaltSeries) -> NlpparsemaltSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_malt_series_sub(a : NlpparsemaltSeries, b : NlpparsemaltSeries) -> NlpparsemaltSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_malt_series_normalize(s : NlpparsemaltSeries) -> NlpparsemaltSeries {
  let mn = nlp_parse_malt_series_min(s)
  let mx = nlp_parse_malt_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_malt_series_cumsum(s : NlpparsemaltSeries) -> NlpparsemaltSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_malt_series_to_string(s : NlpparsemaltSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsemaltMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_malt_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsemaltMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_malt_matrix_identity(n : Int) -> NlpparsemaltMatrix {
  let m = nlp_parse_malt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_malt_matrix_get(m : NlpparsemaltMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_malt_matrix_transpose(m : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  let result = nlp_parse_malt_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_malt_matrix_add(a : NlpparsemaltMatrix, b : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_malt_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_malt_matrix_scale(m : NlpparsemaltMatrix, s : Double) -> NlpparsemaltMatrix {
  let result = nlp_parse_malt_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_malt_matrix_multiply(a : NlpparsemaltMatrix, b : NlpparsemaltMatrix) -> NlpparsemaltMatrix {
  if a.cols != b.rows { return nlp_parse_malt_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_malt_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_malt_matrix_trace(m : NlpparsemaltMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_malt_matrix_det(m : NlpparsemaltMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_malt_matrix_norm(m : NlpparsemaltMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_malt_matrix_to_string(m : NlpparsemaltMatrix) -> String {
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

pub(all) struct NlpparsemaltVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_malt_make_vector(comps : Array[Double]) -> NlpparsemaltVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_malt_vector_zero(dim : Int) -> NlpparsemaltVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_malt_vector_add(a : NlpparsemaltVector, b : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_malt_vector_sub(a : NlpparsemaltVector, b : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_malt_vector_scale(v : NlpparsemaltVector, s : Double) -> NlpparsemaltVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_malt_vector_dot(a : NlpparsemaltVector, b : NlpparsemaltVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_malt_vector_norm(v : NlpparsemaltVector) -> Double { @_common.sqrt(nlp_parse_malt_vector_dot(v, v)) }

pub fn nlp_parse_malt_vector_normalize(v : NlpparsemaltVector) -> NlpparsemaltVector {
  let n = nlp_parse_malt_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_malt_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_malt_vector_dist(a : NlpparsemaltVector, b : NlpparsemaltVector) -> Double {
  nlp_parse_malt_vector_norm(nlp_parse_malt_vector_sub(a, b))
}

pub fn nlp_parse_malt_vector_to_string(v : NlpparsemaltVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_malt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_parse_malt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_parse_malt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_parse_malt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_parse_malt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_parse_malt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_parse_malt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_parse_malt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_parse_malt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_parse_malt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_parse_malt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_parse_malt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_parse_malt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_parse_malt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_parse_malt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_parse_malt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_parse_malt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_parse_malt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_parse_malt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_parse_malt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_parse_malt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_parse_malt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_parse_malt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_parse_malt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_parse_malt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_parse_malt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_parse_malt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_parse_malt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_parse_malt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpparsemaltFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_frame_make(size : Int) -> NlpparsemaltFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_frame_len(s : NlpparsemaltFrame) -> Int { s.size }

pub fn nlp_parse_malt_frame_get(s : NlpparsemaltFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_frame_set(s : NlpparsemaltFrame, i : Int, v : Double) -> NlpparsemaltFrame {
  let result = nlp_parse_malt_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_frame_sum(s : NlpparsemaltFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_frame_mean(s : NlpparsemaltFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_frame_scale(s : NlpparsemaltFrame, f : Double) -> NlpparsemaltFrame {
  let result = nlp_parse_malt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_frame_add(a : NlpparsemaltFrame, b : NlpparsemaltFrame) -> NlpparsemaltFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_frame_copy(s : NlpparsemaltFrame) -> NlpparsemaltFrame {
  let result = nlp_parse_malt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_frame_fill(s : NlpparsemaltFrame, v : Double) -> NlpparsemaltFrame {
  let result = nlp_parse_malt_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_frame_min(s : NlpparsemaltFrame) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_frame_max(s : NlpparsemaltFrame) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_frame_to_string(s : NlpparsemaltFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_table_make(size : Int) -> NlpparsemaltTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_table_len(s : NlpparsemaltTable) -> Int { s.size }

pub fn nlp_parse_malt_table_get(s : NlpparsemaltTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_table_set(s : NlpparsemaltTable, i : Int, v : Double) -> NlpparsemaltTable {
  let result = nlp_parse_malt_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_table_sum(s : NlpparsemaltTable) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_table_mean(s : NlpparsemaltTable) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_table_scale(s : NlpparsemaltTable, f : Double) -> NlpparsemaltTable {
  let result = nlp_parse_malt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_table_add(a : NlpparsemaltTable, b : NlpparsemaltTable) -> NlpparsemaltTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_table_copy(s : NlpparsemaltTable) -> NlpparsemaltTable {
  let result = nlp_parse_malt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_table_fill(s : NlpparsemaltTable, v : Double) -> NlpparsemaltTable {
  let result = nlp_parse_malt_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_table_min(s : NlpparsemaltTable) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_table_max(s : NlpparsemaltTable) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_table_to_string(s : NlpparsemaltTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_graphn_make(size : Int) -> NlpparsemaltGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_graphn_len(s : NlpparsemaltGraphN) -> Int { s.size }

pub fn nlp_parse_malt_graphn_get(s : NlpparsemaltGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_graphn_set(s : NlpparsemaltGraphN, i : Int, v : Double) -> NlpparsemaltGraphN {
  let result = nlp_parse_malt_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_graphn_sum(s : NlpparsemaltGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_graphn_mean(s : NlpparsemaltGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_graphn_scale(s : NlpparsemaltGraphN, f : Double) -> NlpparsemaltGraphN {
  let result = nlp_parse_malt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_graphn_add(a : NlpparsemaltGraphN, b : NlpparsemaltGraphN) -> NlpparsemaltGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_graphn_copy(s : NlpparsemaltGraphN) -> NlpparsemaltGraphN {
  let result = nlp_parse_malt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_graphn_fill(s : NlpparsemaltGraphN, v : Double) -> NlpparsemaltGraphN {
  let result = nlp_parse_malt_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_graphn_min(s : NlpparsemaltGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_graphn_max(s : NlpparsemaltGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_graphn_to_string(s : NlpparsemaltGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_node_make(size : Int) -> NlpparsemaltNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_node_len(s : NlpparsemaltNode) -> Int { s.size }

pub fn nlp_parse_malt_node_get(s : NlpparsemaltNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_node_set(s : NlpparsemaltNode, i : Int, v : Double) -> NlpparsemaltNode {
  let result = nlp_parse_malt_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_node_sum(s : NlpparsemaltNode) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_node_mean(s : NlpparsemaltNode) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_node_scale(s : NlpparsemaltNode, f : Double) -> NlpparsemaltNode {
  let result = nlp_parse_malt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_node_add(a : NlpparsemaltNode, b : NlpparsemaltNode) -> NlpparsemaltNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_node_copy(s : NlpparsemaltNode) -> NlpparsemaltNode {
  let result = nlp_parse_malt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_node_fill(s : NlpparsemaltNode, v : Double) -> NlpparsemaltNode {
  let result = nlp_parse_malt_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_node_min(s : NlpparsemaltNode) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_node_max(s : NlpparsemaltNode) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_node_to_string(s : NlpparsemaltNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_edge_make(size : Int) -> NlpparsemaltEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_edge_len(s : NlpparsemaltEdge) -> Int { s.size }

pub fn nlp_parse_malt_edge_get(s : NlpparsemaltEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_edge_set(s : NlpparsemaltEdge, i : Int, v : Double) -> NlpparsemaltEdge {
  let result = nlp_parse_malt_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_edge_sum(s : NlpparsemaltEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_edge_mean(s : NlpparsemaltEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_edge_scale(s : NlpparsemaltEdge, f : Double) -> NlpparsemaltEdge {
  let result = nlp_parse_malt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_edge_add(a : NlpparsemaltEdge, b : NlpparsemaltEdge) -> NlpparsemaltEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_edge_copy(s : NlpparsemaltEdge) -> NlpparsemaltEdge {
  let result = nlp_parse_malt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_edge_fill(s : NlpparsemaltEdge, v : Double) -> NlpparsemaltEdge {
  let result = nlp_parse_malt_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_edge_min(s : NlpparsemaltEdge) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_edge_max(s : NlpparsemaltEdge) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_edge_to_string(s : NlpparsemaltEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_path_make(size : Int) -> NlpparsemaltPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_path_len(s : NlpparsemaltPath) -> Int { s.size }

pub fn nlp_parse_malt_path_get(s : NlpparsemaltPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_path_set(s : NlpparsemaltPath, i : Int, v : Double) -> NlpparsemaltPath {
  let result = nlp_parse_malt_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_path_sum(s : NlpparsemaltPath) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_path_mean(s : NlpparsemaltPath) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_path_scale(s : NlpparsemaltPath, f : Double) -> NlpparsemaltPath {
  let result = nlp_parse_malt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_path_add(a : NlpparsemaltPath, b : NlpparsemaltPath) -> NlpparsemaltPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_path_copy(s : NlpparsemaltPath) -> NlpparsemaltPath {
  let result = nlp_parse_malt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_path_fill(s : NlpparsemaltPath, v : Double) -> NlpparsemaltPath {
  let result = nlp_parse_malt_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_path_min(s : NlpparsemaltPath) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_path_max(s : NlpparsemaltPath) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_path_to_string(s : NlpparsemaltPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_cluster_make(size : Int) -> NlpparsemaltCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_cluster_len(s : NlpparsemaltCluster) -> Int { s.size }

pub fn nlp_parse_malt_cluster_get(s : NlpparsemaltCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_cluster_set(s : NlpparsemaltCluster, i : Int, v : Double) -> NlpparsemaltCluster {
  let result = nlp_parse_malt_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_cluster_sum(s : NlpparsemaltCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_cluster_mean(s : NlpparsemaltCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_cluster_scale(s : NlpparsemaltCluster, f : Double) -> NlpparsemaltCluster {
  let result = nlp_parse_malt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_cluster_add(a : NlpparsemaltCluster, b : NlpparsemaltCluster) -> NlpparsemaltCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_cluster_copy(s : NlpparsemaltCluster) -> NlpparsemaltCluster {
  let result = nlp_parse_malt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_cluster_fill(s : NlpparsemaltCluster, v : Double) -> NlpparsemaltCluster {
  let result = nlp_parse_malt_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_cluster_min(s : NlpparsemaltCluster) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_cluster_max(s : NlpparsemaltCluster) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_cluster_to_string(s : NlpparsemaltCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_model_make(size : Int) -> NlpparsemaltModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_model_len(s : NlpparsemaltModel) -> Int { s.size }

pub fn nlp_parse_malt_model_get(s : NlpparsemaltModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_model_set(s : NlpparsemaltModel, i : Int, v : Double) -> NlpparsemaltModel {
  let result = nlp_parse_malt_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_model_sum(s : NlpparsemaltModel) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_model_mean(s : NlpparsemaltModel) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_model_scale(s : NlpparsemaltModel, f : Double) -> NlpparsemaltModel {
  let result = nlp_parse_malt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_model_add(a : NlpparsemaltModel, b : NlpparsemaltModel) -> NlpparsemaltModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_model_copy(s : NlpparsemaltModel) -> NlpparsemaltModel {
  let result = nlp_parse_malt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_model_fill(s : NlpparsemaltModel, v : Double) -> NlpparsemaltModel {
  let result = nlp_parse_malt_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_model_min(s : NlpparsemaltModel) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_model_max(s : NlpparsemaltModel) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_model_to_string(s : NlpparsemaltModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_layer_make(size : Int) -> NlpparsemaltLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_layer_len(s : NlpparsemaltLayer) -> Int { s.size }

pub fn nlp_parse_malt_layer_get(s : NlpparsemaltLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_layer_set(s : NlpparsemaltLayer, i : Int, v : Double) -> NlpparsemaltLayer {
  let result = nlp_parse_malt_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_layer_sum(s : NlpparsemaltLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_layer_mean(s : NlpparsemaltLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_layer_scale(s : NlpparsemaltLayer, f : Double) -> NlpparsemaltLayer {
  let result = nlp_parse_malt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_layer_add(a : NlpparsemaltLayer, b : NlpparsemaltLayer) -> NlpparsemaltLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_layer_copy(s : NlpparsemaltLayer) -> NlpparsemaltLayer {
  let result = nlp_parse_malt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_layer_fill(s : NlpparsemaltLayer, v : Double) -> NlpparsemaltLayer {
  let result = nlp_parse_malt_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_layer_min(s : NlpparsemaltLayer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_layer_max(s : NlpparsemaltLayer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_layer_to_string(s : NlpparsemaltLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_buffer_make(size : Int) -> NlpparsemaltBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_buffer_len(s : NlpparsemaltBuffer) -> Int { s.size }

pub fn nlp_parse_malt_buffer_get(s : NlpparsemaltBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_buffer_set(s : NlpparsemaltBuffer, i : Int, v : Double) -> NlpparsemaltBuffer {
  let result = nlp_parse_malt_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_buffer_sum(s : NlpparsemaltBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_buffer_mean(s : NlpparsemaltBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_buffer_scale(s : NlpparsemaltBuffer, f : Double) -> NlpparsemaltBuffer {
  let result = nlp_parse_malt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_buffer_add(a : NlpparsemaltBuffer, b : NlpparsemaltBuffer) -> NlpparsemaltBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_buffer_copy(s : NlpparsemaltBuffer) -> NlpparsemaltBuffer {
  let result = nlp_parse_malt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_buffer_fill(s : NlpparsemaltBuffer, v : Double) -> NlpparsemaltBuffer {
  let result = nlp_parse_malt_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_buffer_min(s : NlpparsemaltBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_buffer_max(s : NlpparsemaltBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_buffer_to_string(s : NlpparsemaltBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_cursor_make(size : Int) -> NlpparsemaltCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_cursor_len(s : NlpparsemaltCursor) -> Int { s.size }

pub fn nlp_parse_malt_cursor_get(s : NlpparsemaltCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_cursor_set(s : NlpparsemaltCursor, i : Int, v : Double) -> NlpparsemaltCursor {
  let result = nlp_parse_malt_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_cursor_sum(s : NlpparsemaltCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_cursor_mean(s : NlpparsemaltCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_cursor_scale(s : NlpparsemaltCursor, f : Double) -> NlpparsemaltCursor {
  let result = nlp_parse_malt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_cursor_add(a : NlpparsemaltCursor, b : NlpparsemaltCursor) -> NlpparsemaltCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_cursor_copy(s : NlpparsemaltCursor) -> NlpparsemaltCursor {
  let result = nlp_parse_malt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_cursor_fill(s : NlpparsemaltCursor, v : Double) -> NlpparsemaltCursor {
  let result = nlp_parse_malt_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_cursor_min(s : NlpparsemaltCursor) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_cursor_max(s : NlpparsemaltCursor) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_cursor_to_string(s : NlpparsemaltCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_view_make(size : Int) -> NlpparsemaltView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_view_len(s : NlpparsemaltView) -> Int { s.size }

pub fn nlp_parse_malt_view_get(s : NlpparsemaltView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_view_set(s : NlpparsemaltView, i : Int, v : Double) -> NlpparsemaltView {
  let result = nlp_parse_malt_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_view_sum(s : NlpparsemaltView) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_view_mean(s : NlpparsemaltView) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_view_scale(s : NlpparsemaltView, f : Double) -> NlpparsemaltView {
  let result = nlp_parse_malt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_view_add(a : NlpparsemaltView, b : NlpparsemaltView) -> NlpparsemaltView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_view_copy(s : NlpparsemaltView) -> NlpparsemaltView {
  let result = nlp_parse_malt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_view_fill(s : NlpparsemaltView, v : Double) -> NlpparsemaltView {
  let result = nlp_parse_malt_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_view_min(s : NlpparsemaltView) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_view_max(s : NlpparsemaltView) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_view_to_string(s : NlpparsemaltView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_range_make(size : Int) -> NlpparsemaltRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_range_len(s : NlpparsemaltRange) -> Int { s.size }

pub fn nlp_parse_malt_range_get(s : NlpparsemaltRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_range_set(s : NlpparsemaltRange, i : Int, v : Double) -> NlpparsemaltRange {
  let result = nlp_parse_malt_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_range_sum(s : NlpparsemaltRange) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_range_mean(s : NlpparsemaltRange) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_range_scale(s : NlpparsemaltRange, f : Double) -> NlpparsemaltRange {
  let result = nlp_parse_malt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_range_add(a : NlpparsemaltRange, b : NlpparsemaltRange) -> NlpparsemaltRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_range_copy(s : NlpparsemaltRange) -> NlpparsemaltRange {
  let result = nlp_parse_malt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_range_fill(s : NlpparsemaltRange, v : Double) -> NlpparsemaltRange {
  let result = nlp_parse_malt_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_range_min(s : NlpparsemaltRange) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_range_max(s : NlpparsemaltRange) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_range_to_string(s : NlpparsemaltRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsemaltSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_malt_slice_make(size : Int) -> NlpparsemaltSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_malt_slice_len(s : NlpparsemaltSlice) -> Int { s.size }

pub fn nlp_parse_malt_slice_get(s : NlpparsemaltSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_malt_slice_set(s : NlpparsemaltSlice, i : Int, v : Double) -> NlpparsemaltSlice {
  let result = nlp_parse_malt_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_slice_sum(s : NlpparsemaltSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_parse_malt_slice_mean(s : NlpparsemaltSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_parse_malt_slice_scale(s : NlpparsemaltSlice, f : Double) -> NlpparsemaltSlice {
  let result = nlp_parse_malt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_malt_slice_add(a : NlpparsemaltSlice, b : NlpparsemaltSlice) -> NlpparsemaltSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_malt_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_malt_slice_copy(s : NlpparsemaltSlice) -> NlpparsemaltSlice {
  let result = nlp_parse_malt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_malt_slice_fill(s : NlpparsemaltSlice, v : Double) -> NlpparsemaltSlice {
  let result = nlp_parse_malt_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_malt_slice_min(s : NlpparsemaltSlice) -> Double { @_common.min(s.data) }

pub fn nlp_parse_malt_slice_max(s : NlpparsemaltSlice) -> Double { @_common.max(s.data) }

pub fn nlp_parse_malt_slice_to_string(s : NlpparsemaltSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

