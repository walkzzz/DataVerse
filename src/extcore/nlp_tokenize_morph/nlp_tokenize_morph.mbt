///===
/// extcore/nlp_tokenize_morph

pub(all) struct NlptokenizemorphPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_morph_make_point(x : Double, y : Double) -> NlptokenizemorphPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_morph_make_point3(x : Double, y : Double, z : Double) -> NlptokenizemorphPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_morph_point_x(pt : NlptokenizemorphPoint) -> Double { pt.x }

pub fn nlp_tokenize_morph_point_y(pt : NlptokenizemorphPoint) -> Double { pt.y }

pub fn nlp_tokenize_morph_point_z(pt : NlptokenizemorphPoint) -> Double { pt.z }

pub fn nlp_tokenize_morph_point_label(pt : NlptokenizemorphPoint) -> Int { pt.label }

pub fn nlp_tokenize_morph_point_dist(a : NlptokenizemorphPoint, b : NlptokenizemorphPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_morph_point_add(a : NlptokenizemorphPoint, b : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_morph_point_sub(a : NlptokenizemorphPoint, b : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_morph_point_scale(pt : NlptokenizemorphPoint, s : Double) -> NlptokenizemorphPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_morph_point_dot(a : NlptokenizemorphPoint, b : NlptokenizemorphPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_morph_point_cross(a : NlptokenizemorphPoint, b : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_morph_point_norm(pt : NlptokenizemorphPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_morph_point_normalize(pt : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  let n = nlp_tokenize_morph_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_morph_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_morph_point_negate(pt : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_morph_point_mid(a : NlptokenizemorphPoint, b : NlptokenizemorphPoint) -> NlptokenizemorphPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_morph_point_lerp(a : NlptokenizemorphPoint, b : NlptokenizemorphPoint, t : Double) -> NlptokenizemorphPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_morph_point_to_string(pt : NlptokenizemorphPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizemorphSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_morph_make_series(vals : Array[Double], name : String) -> NlptokenizemorphSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_morph_series_len(s : NlptokenizemorphSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_morph_series_sum(s : NlptokenizemorphSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_tokenize_morph_series_mean(s : NlptokenizemorphSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_morph_series_min(s : NlptokenizemorphSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_morph_series_max(s : NlptokenizemorphSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_morph_series_range(s : NlptokenizemorphSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_morph_series_var(s : NlptokenizemorphSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_morph_series_std(s : NlptokenizemorphSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_morph_series_median(s : NlptokenizemorphSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_morph_series_scale(s : NlptokenizemorphSeries, f : Double) -> NlptokenizemorphSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_morph_series_add(a : NlptokenizemorphSeries, b : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_morph_series_sub(a : NlptokenizemorphSeries, b : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_morph_series_normalize(s : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  let mn = nlp_tokenize_morph_series_min(s)
  let mx = nlp_tokenize_morph_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_morph_series_cumsum(s : NlptokenizemorphSeries) -> NlptokenizemorphSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_morph_series_to_string(s : NlptokenizemorphSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizemorphMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_morph_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizemorphMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_morph_matrix_identity(n : Int) -> NlptokenizemorphMatrix {
  let m = nlp_tokenize_morph_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_morph_matrix_get(m : NlptokenizemorphMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_morph_matrix_transpose(m : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  let result = nlp_tokenize_morph_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_morph_matrix_add(a : NlptokenizemorphMatrix, b : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_morph_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_morph_matrix_scale(m : NlptokenizemorphMatrix, s : Double) -> NlptokenizemorphMatrix {
  let result = nlp_tokenize_morph_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_morph_matrix_multiply(a : NlptokenizemorphMatrix, b : NlptokenizemorphMatrix) -> NlptokenizemorphMatrix {
  if a.cols != b.rows { return nlp_tokenize_morph_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_morph_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_morph_matrix_trace(m : NlptokenizemorphMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_morph_matrix_det(m : NlptokenizemorphMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_morph_matrix_norm(m : NlptokenizemorphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_morph_matrix_to_string(m : NlptokenizemorphMatrix) -> String {
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

pub(all) struct NlptokenizemorphVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_morph_make_vector(comps : Array[Double]) -> NlptokenizemorphVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_morph_vector_zero(dim : Int) -> NlptokenizemorphVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_morph_vector_add(a : NlptokenizemorphVector, b : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_morph_vector_sub(a : NlptokenizemorphVector, b : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_morph_vector_scale(v : NlptokenizemorphVector, s : Double) -> NlptokenizemorphVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_morph_vector_dot(a : NlptokenizemorphVector, b : NlptokenizemorphVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_morph_vector_norm(v : NlptokenizemorphVector) -> Double { @_common.sqrt(nlp_tokenize_morph_vector_dot(v, v)) }

pub fn nlp_tokenize_morph_vector_normalize(v : NlptokenizemorphVector) -> NlptokenizemorphVector {
  let n = nlp_tokenize_morph_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_morph_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_morph_vector_dist(a : NlptokenizemorphVector, b : NlptokenizemorphVector) -> Double {
  nlp_tokenize_morph_vector_norm(nlp_tokenize_morph_vector_sub(a, b))
}

pub fn nlp_tokenize_morph_vector_to_string(v : NlptokenizemorphVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_morph_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_morph_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_morph_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_morph_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_morph_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_morph_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_morph_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_morph_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_morph_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_morph_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_morph_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_morph_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_morph_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_morph_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_morph_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_morph_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_morph_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_morph_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_morph_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_morph_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_morph_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_morph_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_morph_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_morph_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_morph_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_morph_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_morph_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_morph_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_morph_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizemorphFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_frame_make(size : Int) -> NlptokenizemorphFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_frame_len(s : NlptokenizemorphFrame) -> Int { s.size }

pub fn nlp_tokenize_morph_frame_get(s : NlptokenizemorphFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_frame_set(s : NlptokenizemorphFrame, i : Int, v : Double) -> NlptokenizemorphFrame {
  let result = nlp_tokenize_morph_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_frame_sum(s : NlptokenizemorphFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_frame_mean(s : NlptokenizemorphFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_frame_scale(s : NlptokenizemorphFrame, f : Double) -> NlptokenizemorphFrame {
  let result = nlp_tokenize_morph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_frame_add(a : NlptokenizemorphFrame, b : NlptokenizemorphFrame) -> NlptokenizemorphFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_frame_copy(s : NlptokenizemorphFrame) -> NlptokenizemorphFrame {
  let result = nlp_tokenize_morph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_frame_fill(s : NlptokenizemorphFrame, v : Double) -> NlptokenizemorphFrame {
  let result = nlp_tokenize_morph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_frame_min(s : NlptokenizemorphFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_frame_max(s : NlptokenizemorphFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_frame_to_string(s : NlptokenizemorphFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_table_make(size : Int) -> NlptokenizemorphTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_table_len(s : NlptokenizemorphTable) -> Int { s.size }

pub fn nlp_tokenize_morph_table_get(s : NlptokenizemorphTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_table_set(s : NlptokenizemorphTable, i : Int, v : Double) -> NlptokenizemorphTable {
  let result = nlp_tokenize_morph_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_table_sum(s : NlptokenizemorphTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_table_mean(s : NlptokenizemorphTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_table_scale(s : NlptokenizemorphTable, f : Double) -> NlptokenizemorphTable {
  let result = nlp_tokenize_morph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_table_add(a : NlptokenizemorphTable, b : NlptokenizemorphTable) -> NlptokenizemorphTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_table_copy(s : NlptokenizemorphTable) -> NlptokenizemorphTable {
  let result = nlp_tokenize_morph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_table_fill(s : NlptokenizemorphTable, v : Double) -> NlptokenizemorphTable {
  let result = nlp_tokenize_morph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_table_min(s : NlptokenizemorphTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_table_max(s : NlptokenizemorphTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_table_to_string(s : NlptokenizemorphTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_graphn_make(size : Int) -> NlptokenizemorphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_graphn_len(s : NlptokenizemorphGraphN) -> Int { s.size }

pub fn nlp_tokenize_morph_graphn_get(s : NlptokenizemorphGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_graphn_set(s : NlptokenizemorphGraphN, i : Int, v : Double) -> NlptokenizemorphGraphN {
  let result = nlp_tokenize_morph_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_graphn_sum(s : NlptokenizemorphGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_graphn_mean(s : NlptokenizemorphGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_graphn_scale(s : NlptokenizemorphGraphN, f : Double) -> NlptokenizemorphGraphN {
  let result = nlp_tokenize_morph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_graphn_add(a : NlptokenizemorphGraphN, b : NlptokenizemorphGraphN) -> NlptokenizemorphGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_graphn_copy(s : NlptokenizemorphGraphN) -> NlptokenizemorphGraphN {
  let result = nlp_tokenize_morph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_graphn_fill(s : NlptokenizemorphGraphN, v : Double) -> NlptokenizemorphGraphN {
  let result = nlp_tokenize_morph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_graphn_min(s : NlptokenizemorphGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_graphn_max(s : NlptokenizemorphGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_graphn_to_string(s : NlptokenizemorphGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_node_make(size : Int) -> NlptokenizemorphNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_node_len(s : NlptokenizemorphNode) -> Int { s.size }

pub fn nlp_tokenize_morph_node_get(s : NlptokenizemorphNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_node_set(s : NlptokenizemorphNode, i : Int, v : Double) -> NlptokenizemorphNode {
  let result = nlp_tokenize_morph_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_node_sum(s : NlptokenizemorphNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_node_mean(s : NlptokenizemorphNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_node_scale(s : NlptokenizemorphNode, f : Double) -> NlptokenizemorphNode {
  let result = nlp_tokenize_morph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_node_add(a : NlptokenizemorphNode, b : NlptokenizemorphNode) -> NlptokenizemorphNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_node_copy(s : NlptokenizemorphNode) -> NlptokenizemorphNode {
  let result = nlp_tokenize_morph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_node_fill(s : NlptokenizemorphNode, v : Double) -> NlptokenizemorphNode {
  let result = nlp_tokenize_morph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_node_min(s : NlptokenizemorphNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_node_max(s : NlptokenizemorphNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_node_to_string(s : NlptokenizemorphNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_edge_make(size : Int) -> NlptokenizemorphEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_edge_len(s : NlptokenizemorphEdge) -> Int { s.size }

pub fn nlp_tokenize_morph_edge_get(s : NlptokenizemorphEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_edge_set(s : NlptokenizemorphEdge, i : Int, v : Double) -> NlptokenizemorphEdge {
  let result = nlp_tokenize_morph_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_edge_sum(s : NlptokenizemorphEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_edge_mean(s : NlptokenizemorphEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_edge_scale(s : NlptokenizemorphEdge, f : Double) -> NlptokenizemorphEdge {
  let result = nlp_tokenize_morph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_edge_add(a : NlptokenizemorphEdge, b : NlptokenizemorphEdge) -> NlptokenizemorphEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_edge_copy(s : NlptokenizemorphEdge) -> NlptokenizemorphEdge {
  let result = nlp_tokenize_morph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_edge_fill(s : NlptokenizemorphEdge, v : Double) -> NlptokenizemorphEdge {
  let result = nlp_tokenize_morph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_edge_min(s : NlptokenizemorphEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_edge_max(s : NlptokenizemorphEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_edge_to_string(s : NlptokenizemorphEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_path_make(size : Int) -> NlptokenizemorphPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_path_len(s : NlptokenizemorphPath) -> Int { s.size }

pub fn nlp_tokenize_morph_path_get(s : NlptokenizemorphPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_path_set(s : NlptokenizemorphPath, i : Int, v : Double) -> NlptokenizemorphPath {
  let result = nlp_tokenize_morph_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_path_sum(s : NlptokenizemorphPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_path_mean(s : NlptokenizemorphPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_path_scale(s : NlptokenizemorphPath, f : Double) -> NlptokenizemorphPath {
  let result = nlp_tokenize_morph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_path_add(a : NlptokenizemorphPath, b : NlptokenizemorphPath) -> NlptokenizemorphPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_path_copy(s : NlptokenizemorphPath) -> NlptokenizemorphPath {
  let result = nlp_tokenize_morph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_path_fill(s : NlptokenizemorphPath, v : Double) -> NlptokenizemorphPath {
  let result = nlp_tokenize_morph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_path_min(s : NlptokenizemorphPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_path_max(s : NlptokenizemorphPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_path_to_string(s : NlptokenizemorphPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_cluster_make(size : Int) -> NlptokenizemorphCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_cluster_len(s : NlptokenizemorphCluster) -> Int { s.size }

pub fn nlp_tokenize_morph_cluster_get(s : NlptokenizemorphCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_cluster_set(s : NlptokenizemorphCluster, i : Int, v : Double) -> NlptokenizemorphCluster {
  let result = nlp_tokenize_morph_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_cluster_sum(s : NlptokenizemorphCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_cluster_mean(s : NlptokenizemorphCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_cluster_scale(s : NlptokenizemorphCluster, f : Double) -> NlptokenizemorphCluster {
  let result = nlp_tokenize_morph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_cluster_add(a : NlptokenizemorphCluster, b : NlptokenizemorphCluster) -> NlptokenizemorphCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_cluster_copy(s : NlptokenizemorphCluster) -> NlptokenizemorphCluster {
  let result = nlp_tokenize_morph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_cluster_fill(s : NlptokenizemorphCluster, v : Double) -> NlptokenizemorphCluster {
  let result = nlp_tokenize_morph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_cluster_min(s : NlptokenizemorphCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_cluster_max(s : NlptokenizemorphCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_cluster_to_string(s : NlptokenizemorphCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_model_make(size : Int) -> NlptokenizemorphModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_model_len(s : NlptokenizemorphModel) -> Int { s.size }

pub fn nlp_tokenize_morph_model_get(s : NlptokenizemorphModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_model_set(s : NlptokenizemorphModel, i : Int, v : Double) -> NlptokenizemorphModel {
  let result = nlp_tokenize_morph_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_model_sum(s : NlptokenizemorphModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_model_mean(s : NlptokenizemorphModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_model_scale(s : NlptokenizemorphModel, f : Double) -> NlptokenizemorphModel {
  let result = nlp_tokenize_morph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_model_add(a : NlptokenizemorphModel, b : NlptokenizemorphModel) -> NlptokenizemorphModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_model_copy(s : NlptokenizemorphModel) -> NlptokenizemorphModel {
  let result = nlp_tokenize_morph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_model_fill(s : NlptokenizemorphModel, v : Double) -> NlptokenizemorphModel {
  let result = nlp_tokenize_morph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_model_min(s : NlptokenizemorphModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_model_max(s : NlptokenizemorphModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_model_to_string(s : NlptokenizemorphModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_layer_make(size : Int) -> NlptokenizemorphLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_layer_len(s : NlptokenizemorphLayer) -> Int { s.size }

pub fn nlp_tokenize_morph_layer_get(s : NlptokenizemorphLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_layer_set(s : NlptokenizemorphLayer, i : Int, v : Double) -> NlptokenizemorphLayer {
  let result = nlp_tokenize_morph_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_layer_sum(s : NlptokenizemorphLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_layer_mean(s : NlptokenizemorphLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_layer_scale(s : NlptokenizemorphLayer, f : Double) -> NlptokenizemorphLayer {
  let result = nlp_tokenize_morph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_layer_add(a : NlptokenizemorphLayer, b : NlptokenizemorphLayer) -> NlptokenizemorphLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_layer_copy(s : NlptokenizemorphLayer) -> NlptokenizemorphLayer {
  let result = nlp_tokenize_morph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_layer_fill(s : NlptokenizemorphLayer, v : Double) -> NlptokenizemorphLayer {
  let result = nlp_tokenize_morph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_layer_min(s : NlptokenizemorphLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_layer_max(s : NlptokenizemorphLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_layer_to_string(s : NlptokenizemorphLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_buffer_make(size : Int) -> NlptokenizemorphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_buffer_len(s : NlptokenizemorphBuffer) -> Int { s.size }

pub fn nlp_tokenize_morph_buffer_get(s : NlptokenizemorphBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_buffer_set(s : NlptokenizemorphBuffer, i : Int, v : Double) -> NlptokenizemorphBuffer {
  let result = nlp_tokenize_morph_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_buffer_sum(s : NlptokenizemorphBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_buffer_mean(s : NlptokenizemorphBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_buffer_scale(s : NlptokenizemorphBuffer, f : Double) -> NlptokenizemorphBuffer {
  let result = nlp_tokenize_morph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_buffer_add(a : NlptokenizemorphBuffer, b : NlptokenizemorphBuffer) -> NlptokenizemorphBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_buffer_copy(s : NlptokenizemorphBuffer) -> NlptokenizemorphBuffer {
  let result = nlp_tokenize_morph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_buffer_fill(s : NlptokenizemorphBuffer, v : Double) -> NlptokenizemorphBuffer {
  let result = nlp_tokenize_morph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_buffer_min(s : NlptokenizemorphBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_buffer_max(s : NlptokenizemorphBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_buffer_to_string(s : NlptokenizemorphBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_cursor_make(size : Int) -> NlptokenizemorphCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_cursor_len(s : NlptokenizemorphCursor) -> Int { s.size }

pub fn nlp_tokenize_morph_cursor_get(s : NlptokenizemorphCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_cursor_set(s : NlptokenizemorphCursor, i : Int, v : Double) -> NlptokenizemorphCursor {
  let result = nlp_tokenize_morph_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_cursor_sum(s : NlptokenizemorphCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_cursor_mean(s : NlptokenizemorphCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_cursor_scale(s : NlptokenizemorphCursor, f : Double) -> NlptokenizemorphCursor {
  let result = nlp_tokenize_morph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_cursor_add(a : NlptokenizemorphCursor, b : NlptokenizemorphCursor) -> NlptokenizemorphCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_cursor_copy(s : NlptokenizemorphCursor) -> NlptokenizemorphCursor {
  let result = nlp_tokenize_morph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_cursor_fill(s : NlptokenizemorphCursor, v : Double) -> NlptokenizemorphCursor {
  let result = nlp_tokenize_morph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_cursor_min(s : NlptokenizemorphCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_cursor_max(s : NlptokenizemorphCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_cursor_to_string(s : NlptokenizemorphCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_view_make(size : Int) -> NlptokenizemorphView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_view_len(s : NlptokenizemorphView) -> Int { s.size }

pub fn nlp_tokenize_morph_view_get(s : NlptokenizemorphView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_view_set(s : NlptokenizemorphView, i : Int, v : Double) -> NlptokenizemorphView {
  let result = nlp_tokenize_morph_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_view_sum(s : NlptokenizemorphView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_view_mean(s : NlptokenizemorphView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_view_scale(s : NlptokenizemorphView, f : Double) -> NlptokenizemorphView {
  let result = nlp_tokenize_morph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_view_add(a : NlptokenizemorphView, b : NlptokenizemorphView) -> NlptokenizemorphView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_view_copy(s : NlptokenizemorphView) -> NlptokenizemorphView {
  let result = nlp_tokenize_morph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_view_fill(s : NlptokenizemorphView, v : Double) -> NlptokenizemorphView {
  let result = nlp_tokenize_morph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_view_min(s : NlptokenizemorphView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_view_max(s : NlptokenizemorphView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_view_to_string(s : NlptokenizemorphView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_range_make(size : Int) -> NlptokenizemorphRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_range_len(s : NlptokenizemorphRange) -> Int { s.size }

pub fn nlp_tokenize_morph_range_get(s : NlptokenizemorphRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_range_set(s : NlptokenizemorphRange, i : Int, v : Double) -> NlptokenizemorphRange {
  let result = nlp_tokenize_morph_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_range_sum(s : NlptokenizemorphRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_range_mean(s : NlptokenizemorphRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_range_scale(s : NlptokenizemorphRange, f : Double) -> NlptokenizemorphRange {
  let result = nlp_tokenize_morph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_range_add(a : NlptokenizemorphRange, b : NlptokenizemorphRange) -> NlptokenizemorphRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_range_copy(s : NlptokenizemorphRange) -> NlptokenizemorphRange {
  let result = nlp_tokenize_morph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_range_fill(s : NlptokenizemorphRange, v : Double) -> NlptokenizemorphRange {
  let result = nlp_tokenize_morph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_range_min(s : NlptokenizemorphRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_range_max(s : NlptokenizemorphRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_range_to_string(s : NlptokenizemorphRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizemorphSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_morph_slice_make(size : Int) -> NlptokenizemorphSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_morph_slice_len(s : NlptokenizemorphSlice) -> Int { s.size }

pub fn nlp_tokenize_morph_slice_get(s : NlptokenizemorphSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_morph_slice_set(s : NlptokenizemorphSlice, i : Int, v : Double) -> NlptokenizemorphSlice {
  let result = nlp_tokenize_morph_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_slice_sum(s : NlptokenizemorphSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_morph_slice_mean(s : NlptokenizemorphSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_morph_slice_scale(s : NlptokenizemorphSlice, f : Double) -> NlptokenizemorphSlice {
  let result = nlp_tokenize_morph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_morph_slice_add(a : NlptokenizemorphSlice, b : NlptokenizemorphSlice) -> NlptokenizemorphSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_morph_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_morph_slice_copy(s : NlptokenizemorphSlice) -> NlptokenizemorphSlice {
  let result = nlp_tokenize_morph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_morph_slice_fill(s : NlptokenizemorphSlice, v : Double) -> NlptokenizemorphSlice {
  let result = nlp_tokenize_morph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_morph_slice_min(s : NlptokenizemorphSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_morph_slice_max(s : NlptokenizemorphSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_morph_slice_to_string(s : NlptokenizemorphSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

