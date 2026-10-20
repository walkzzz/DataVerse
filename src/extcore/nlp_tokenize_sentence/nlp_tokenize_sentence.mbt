///===
/// extcore/nlp_tokenize_sentence

pub(all) struct NlptokenizesentencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_sentence_make_point(x : Double, y : Double) -> NlptokenizesentencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_sentence_make_point3(x : Double, y : Double, z : Double) -> NlptokenizesentencePoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_sentence_point_x(pt : NlptokenizesentencePoint) -> Double { pt.x }

pub fn nlp_tokenize_sentence_point_y(pt : NlptokenizesentencePoint) -> Double { pt.y }

pub fn nlp_tokenize_sentence_point_z(pt : NlptokenizesentencePoint) -> Double { pt.z }

pub fn nlp_tokenize_sentence_point_label(pt : NlptokenizesentencePoint) -> Int { pt.label }

pub fn nlp_tokenize_sentence_point_dist(a : NlptokenizesentencePoint, b : NlptokenizesentencePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_sentence_point_add(a : NlptokenizesentencePoint, b : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_sentence_point_sub(a : NlptokenizesentencePoint, b : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_sentence_point_scale(pt : NlptokenizesentencePoint, s : Double) -> NlptokenizesentencePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_sentence_point_dot(a : NlptokenizesentencePoint, b : NlptokenizesentencePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_sentence_point_cross(a : NlptokenizesentencePoint, b : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_sentence_point_norm(pt : NlptokenizesentencePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_sentence_point_normalize(pt : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  let n = nlp_tokenize_sentence_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_sentence_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_sentence_point_negate(pt : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_sentence_point_mid(a : NlptokenizesentencePoint, b : NlptokenizesentencePoint) -> NlptokenizesentencePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_sentence_point_lerp(a : NlptokenizesentencePoint, b : NlptokenizesentencePoint, t : Double) -> NlptokenizesentencePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_sentence_point_to_string(pt : NlptokenizesentencePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizesentenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_sentence_make_series(vals : Array[Double], name : String) -> NlptokenizesentenceSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_sentence_series_len(s : NlptokenizesentenceSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_sentence_series_sum(s : NlptokenizesentenceSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_tokenize_sentence_series_mean(s : NlptokenizesentenceSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_sentence_series_min(s : NlptokenizesentenceSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_sentence_series_max(s : NlptokenizesentenceSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_sentence_series_range(s : NlptokenizesentenceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_sentence_series_var(s : NlptokenizesentenceSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_sentence_series_std(s : NlptokenizesentenceSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_sentence_series_median(s : NlptokenizesentenceSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_sentence_series_scale(s : NlptokenizesentenceSeries, f : Double) -> NlptokenizesentenceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_sentence_series_add(a : NlptokenizesentenceSeries, b : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_sentence_series_sub(a : NlptokenizesentenceSeries, b : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_sentence_series_normalize(s : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  let mn = nlp_tokenize_sentence_series_min(s)
  let mx = nlp_tokenize_sentence_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_sentence_series_cumsum(s : NlptokenizesentenceSeries) -> NlptokenizesentenceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_sentence_series_to_string(s : NlptokenizesentenceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesentenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_sentence_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizesentenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_sentence_matrix_identity(n : Int) -> NlptokenizesentenceMatrix {
  let m = nlp_tokenize_sentence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_sentence_matrix_get(m : NlptokenizesentenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_sentence_matrix_transpose(m : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  let result = nlp_tokenize_sentence_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_sentence_matrix_add(a : NlptokenizesentenceMatrix, b : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_sentence_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_sentence_matrix_scale(m : NlptokenizesentenceMatrix, s : Double) -> NlptokenizesentenceMatrix {
  let result = nlp_tokenize_sentence_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_sentence_matrix_multiply(a : NlptokenizesentenceMatrix, b : NlptokenizesentenceMatrix) -> NlptokenizesentenceMatrix {
  if a.cols != b.rows { return nlp_tokenize_sentence_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_sentence_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_sentence_matrix_trace(m : NlptokenizesentenceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_sentence_matrix_det(m : NlptokenizesentenceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_sentence_matrix_norm(m : NlptokenizesentenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_sentence_matrix_to_string(m : NlptokenizesentenceMatrix) -> String {
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

pub(all) struct NlptokenizesentenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_sentence_make_vector(comps : Array[Double]) -> NlptokenizesentenceVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_sentence_vector_zero(dim : Int) -> NlptokenizesentenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_sentence_vector_add(a : NlptokenizesentenceVector, b : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_sentence_vector_sub(a : NlptokenizesentenceVector, b : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_sentence_vector_scale(v : NlptokenizesentenceVector, s : Double) -> NlptokenizesentenceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_sentence_vector_dot(a : NlptokenizesentenceVector, b : NlptokenizesentenceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_sentence_vector_norm(v : NlptokenizesentenceVector) -> Double { @_common.sqrt(nlp_tokenize_sentence_vector_dot(v, v)) }

pub fn nlp_tokenize_sentence_vector_normalize(v : NlptokenizesentenceVector) -> NlptokenizesentenceVector {
  let n = nlp_tokenize_sentence_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_sentence_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_sentence_vector_dist(a : NlptokenizesentenceVector, b : NlptokenizesentenceVector) -> Double {
  nlp_tokenize_sentence_vector_norm(nlp_tokenize_sentence_vector_sub(a, b))
}

pub fn nlp_tokenize_sentence_vector_to_string(v : NlptokenizesentenceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_sentence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_sentence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_sentence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_sentence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_sentence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_sentence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_sentence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_sentence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_sentence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_sentence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_sentence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_sentence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_sentence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_sentence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_sentence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_sentence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_sentence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_sentence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_sentence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_sentence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_sentence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_sentence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_sentence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_sentence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_sentence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_sentence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_sentence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_sentence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_sentence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizesentenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_frame_make(size : Int) -> NlptokenizesentenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_frame_len(s : NlptokenizesentenceFrame) -> Int { s.size }

pub fn nlp_tokenize_sentence_frame_get(s : NlptokenizesentenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_frame_set(s : NlptokenizesentenceFrame, i : Int, v : Double) -> NlptokenizesentenceFrame {
  let result = nlp_tokenize_sentence_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_frame_sum(s : NlptokenizesentenceFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_frame_mean(s : NlptokenizesentenceFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_frame_scale(s : NlptokenizesentenceFrame, f : Double) -> NlptokenizesentenceFrame {
  let result = nlp_tokenize_sentence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_frame_add(a : NlptokenizesentenceFrame, b : NlptokenizesentenceFrame) -> NlptokenizesentenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_frame_copy(s : NlptokenizesentenceFrame) -> NlptokenizesentenceFrame {
  let result = nlp_tokenize_sentence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_frame_fill(s : NlptokenizesentenceFrame, v : Double) -> NlptokenizesentenceFrame {
  let result = nlp_tokenize_sentence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_frame_min(s : NlptokenizesentenceFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_frame_max(s : NlptokenizesentenceFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_frame_to_string(s : NlptokenizesentenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_table_make(size : Int) -> NlptokenizesentenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_table_len(s : NlptokenizesentenceTable) -> Int { s.size }

pub fn nlp_tokenize_sentence_table_get(s : NlptokenizesentenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_table_set(s : NlptokenizesentenceTable, i : Int, v : Double) -> NlptokenizesentenceTable {
  let result = nlp_tokenize_sentence_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_table_sum(s : NlptokenizesentenceTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_table_mean(s : NlptokenizesentenceTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_table_scale(s : NlptokenizesentenceTable, f : Double) -> NlptokenizesentenceTable {
  let result = nlp_tokenize_sentence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_table_add(a : NlptokenizesentenceTable, b : NlptokenizesentenceTable) -> NlptokenizesentenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_table_copy(s : NlptokenizesentenceTable) -> NlptokenizesentenceTable {
  let result = nlp_tokenize_sentence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_table_fill(s : NlptokenizesentenceTable, v : Double) -> NlptokenizesentenceTable {
  let result = nlp_tokenize_sentence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_table_min(s : NlptokenizesentenceTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_table_max(s : NlptokenizesentenceTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_table_to_string(s : NlptokenizesentenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_graphn_make(size : Int) -> NlptokenizesentenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_graphn_len(s : NlptokenizesentenceGraphN) -> Int { s.size }

pub fn nlp_tokenize_sentence_graphn_get(s : NlptokenizesentenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_graphn_set(s : NlptokenizesentenceGraphN, i : Int, v : Double) -> NlptokenizesentenceGraphN {
  let result = nlp_tokenize_sentence_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_graphn_sum(s : NlptokenizesentenceGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_graphn_mean(s : NlptokenizesentenceGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_graphn_scale(s : NlptokenizesentenceGraphN, f : Double) -> NlptokenizesentenceGraphN {
  let result = nlp_tokenize_sentence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_graphn_add(a : NlptokenizesentenceGraphN, b : NlptokenizesentenceGraphN) -> NlptokenizesentenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_graphn_copy(s : NlptokenizesentenceGraphN) -> NlptokenizesentenceGraphN {
  let result = nlp_tokenize_sentence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_graphn_fill(s : NlptokenizesentenceGraphN, v : Double) -> NlptokenizesentenceGraphN {
  let result = nlp_tokenize_sentence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_graphn_min(s : NlptokenizesentenceGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_graphn_max(s : NlptokenizesentenceGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_graphn_to_string(s : NlptokenizesentenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_node_make(size : Int) -> NlptokenizesentenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_node_len(s : NlptokenizesentenceNode) -> Int { s.size }

pub fn nlp_tokenize_sentence_node_get(s : NlptokenizesentenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_node_set(s : NlptokenizesentenceNode, i : Int, v : Double) -> NlptokenizesentenceNode {
  let result = nlp_tokenize_sentence_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_node_sum(s : NlptokenizesentenceNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_node_mean(s : NlptokenizesentenceNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_node_scale(s : NlptokenizesentenceNode, f : Double) -> NlptokenizesentenceNode {
  let result = nlp_tokenize_sentence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_node_add(a : NlptokenizesentenceNode, b : NlptokenizesentenceNode) -> NlptokenizesentenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_node_copy(s : NlptokenizesentenceNode) -> NlptokenizesentenceNode {
  let result = nlp_tokenize_sentence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_node_fill(s : NlptokenizesentenceNode, v : Double) -> NlptokenizesentenceNode {
  let result = nlp_tokenize_sentence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_node_min(s : NlptokenizesentenceNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_node_max(s : NlptokenizesentenceNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_node_to_string(s : NlptokenizesentenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_edge_make(size : Int) -> NlptokenizesentenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_edge_len(s : NlptokenizesentenceEdge) -> Int { s.size }

pub fn nlp_tokenize_sentence_edge_get(s : NlptokenizesentenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_edge_set(s : NlptokenizesentenceEdge, i : Int, v : Double) -> NlptokenizesentenceEdge {
  let result = nlp_tokenize_sentence_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_edge_sum(s : NlptokenizesentenceEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_edge_mean(s : NlptokenizesentenceEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_edge_scale(s : NlptokenizesentenceEdge, f : Double) -> NlptokenizesentenceEdge {
  let result = nlp_tokenize_sentence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_edge_add(a : NlptokenizesentenceEdge, b : NlptokenizesentenceEdge) -> NlptokenizesentenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_edge_copy(s : NlptokenizesentenceEdge) -> NlptokenizesentenceEdge {
  let result = nlp_tokenize_sentence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_edge_fill(s : NlptokenizesentenceEdge, v : Double) -> NlptokenizesentenceEdge {
  let result = nlp_tokenize_sentence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_edge_min(s : NlptokenizesentenceEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_edge_max(s : NlptokenizesentenceEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_edge_to_string(s : NlptokenizesentenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_path_make(size : Int) -> NlptokenizesentencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_path_len(s : NlptokenizesentencePath) -> Int { s.size }

pub fn nlp_tokenize_sentence_path_get(s : NlptokenizesentencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_path_set(s : NlptokenizesentencePath, i : Int, v : Double) -> NlptokenizesentencePath {
  let result = nlp_tokenize_sentence_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_path_sum(s : NlptokenizesentencePath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_path_mean(s : NlptokenizesentencePath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_path_scale(s : NlptokenizesentencePath, f : Double) -> NlptokenizesentencePath {
  let result = nlp_tokenize_sentence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_path_add(a : NlptokenizesentencePath, b : NlptokenizesentencePath) -> NlptokenizesentencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_path_copy(s : NlptokenizesentencePath) -> NlptokenizesentencePath {
  let result = nlp_tokenize_sentence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_path_fill(s : NlptokenizesentencePath, v : Double) -> NlptokenizesentencePath {
  let result = nlp_tokenize_sentence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_path_min(s : NlptokenizesentencePath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_path_max(s : NlptokenizesentencePath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_path_to_string(s : NlptokenizesentencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_cluster_make(size : Int) -> NlptokenizesentenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_cluster_len(s : NlptokenizesentenceCluster) -> Int { s.size }

pub fn nlp_tokenize_sentence_cluster_get(s : NlptokenizesentenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_cluster_set(s : NlptokenizesentenceCluster, i : Int, v : Double) -> NlptokenizesentenceCluster {
  let result = nlp_tokenize_sentence_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_cluster_sum(s : NlptokenizesentenceCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_cluster_mean(s : NlptokenizesentenceCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_cluster_scale(s : NlptokenizesentenceCluster, f : Double) -> NlptokenizesentenceCluster {
  let result = nlp_tokenize_sentence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_cluster_add(a : NlptokenizesentenceCluster, b : NlptokenizesentenceCluster) -> NlptokenizesentenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_cluster_copy(s : NlptokenizesentenceCluster) -> NlptokenizesentenceCluster {
  let result = nlp_tokenize_sentence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_cluster_fill(s : NlptokenizesentenceCluster, v : Double) -> NlptokenizesentenceCluster {
  let result = nlp_tokenize_sentence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_cluster_min(s : NlptokenizesentenceCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_cluster_max(s : NlptokenizesentenceCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_cluster_to_string(s : NlptokenizesentenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_model_make(size : Int) -> NlptokenizesentenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_model_len(s : NlptokenizesentenceModel) -> Int { s.size }

pub fn nlp_tokenize_sentence_model_get(s : NlptokenizesentenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_model_set(s : NlptokenizesentenceModel, i : Int, v : Double) -> NlptokenizesentenceModel {
  let result = nlp_tokenize_sentence_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_model_sum(s : NlptokenizesentenceModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_model_mean(s : NlptokenizesentenceModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_model_scale(s : NlptokenizesentenceModel, f : Double) -> NlptokenizesentenceModel {
  let result = nlp_tokenize_sentence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_model_add(a : NlptokenizesentenceModel, b : NlptokenizesentenceModel) -> NlptokenizesentenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_model_copy(s : NlptokenizesentenceModel) -> NlptokenizesentenceModel {
  let result = nlp_tokenize_sentence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_model_fill(s : NlptokenizesentenceModel, v : Double) -> NlptokenizesentenceModel {
  let result = nlp_tokenize_sentence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_model_min(s : NlptokenizesentenceModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_model_max(s : NlptokenizesentenceModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_model_to_string(s : NlptokenizesentenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_layer_make(size : Int) -> NlptokenizesentenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_layer_len(s : NlptokenizesentenceLayer) -> Int { s.size }

pub fn nlp_tokenize_sentence_layer_get(s : NlptokenizesentenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_layer_set(s : NlptokenizesentenceLayer, i : Int, v : Double) -> NlptokenizesentenceLayer {
  let result = nlp_tokenize_sentence_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_layer_sum(s : NlptokenizesentenceLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_layer_mean(s : NlptokenizesentenceLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_layer_scale(s : NlptokenizesentenceLayer, f : Double) -> NlptokenizesentenceLayer {
  let result = nlp_tokenize_sentence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_layer_add(a : NlptokenizesentenceLayer, b : NlptokenizesentenceLayer) -> NlptokenizesentenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_layer_copy(s : NlptokenizesentenceLayer) -> NlptokenizesentenceLayer {
  let result = nlp_tokenize_sentence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_layer_fill(s : NlptokenizesentenceLayer, v : Double) -> NlptokenizesentenceLayer {
  let result = nlp_tokenize_sentence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_layer_min(s : NlptokenizesentenceLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_layer_max(s : NlptokenizesentenceLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_layer_to_string(s : NlptokenizesentenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_buffer_make(size : Int) -> NlptokenizesentenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_buffer_len(s : NlptokenizesentenceBuffer) -> Int { s.size }

pub fn nlp_tokenize_sentence_buffer_get(s : NlptokenizesentenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_buffer_set(s : NlptokenizesentenceBuffer, i : Int, v : Double) -> NlptokenizesentenceBuffer {
  let result = nlp_tokenize_sentence_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_buffer_sum(s : NlptokenizesentenceBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_buffer_mean(s : NlptokenizesentenceBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_buffer_scale(s : NlptokenizesentenceBuffer, f : Double) -> NlptokenizesentenceBuffer {
  let result = nlp_tokenize_sentence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_buffer_add(a : NlptokenizesentenceBuffer, b : NlptokenizesentenceBuffer) -> NlptokenizesentenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_buffer_copy(s : NlptokenizesentenceBuffer) -> NlptokenizesentenceBuffer {
  let result = nlp_tokenize_sentence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_buffer_fill(s : NlptokenizesentenceBuffer, v : Double) -> NlptokenizesentenceBuffer {
  let result = nlp_tokenize_sentence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_buffer_min(s : NlptokenizesentenceBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_buffer_max(s : NlptokenizesentenceBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_buffer_to_string(s : NlptokenizesentenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_cursor_make(size : Int) -> NlptokenizesentenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_cursor_len(s : NlptokenizesentenceCursor) -> Int { s.size }

pub fn nlp_tokenize_sentence_cursor_get(s : NlptokenizesentenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_cursor_set(s : NlptokenizesentenceCursor, i : Int, v : Double) -> NlptokenizesentenceCursor {
  let result = nlp_tokenize_sentence_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_cursor_sum(s : NlptokenizesentenceCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_cursor_mean(s : NlptokenizesentenceCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_cursor_scale(s : NlptokenizesentenceCursor, f : Double) -> NlptokenizesentenceCursor {
  let result = nlp_tokenize_sentence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_cursor_add(a : NlptokenizesentenceCursor, b : NlptokenizesentenceCursor) -> NlptokenizesentenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_cursor_copy(s : NlptokenizesentenceCursor) -> NlptokenizesentenceCursor {
  let result = nlp_tokenize_sentence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_cursor_fill(s : NlptokenizesentenceCursor, v : Double) -> NlptokenizesentenceCursor {
  let result = nlp_tokenize_sentence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_cursor_min(s : NlptokenizesentenceCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_cursor_max(s : NlptokenizesentenceCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_cursor_to_string(s : NlptokenizesentenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_view_make(size : Int) -> NlptokenizesentenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_view_len(s : NlptokenizesentenceView) -> Int { s.size }

pub fn nlp_tokenize_sentence_view_get(s : NlptokenizesentenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_view_set(s : NlptokenizesentenceView, i : Int, v : Double) -> NlptokenizesentenceView {
  let result = nlp_tokenize_sentence_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_view_sum(s : NlptokenizesentenceView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_view_mean(s : NlptokenizesentenceView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_view_scale(s : NlptokenizesentenceView, f : Double) -> NlptokenizesentenceView {
  let result = nlp_tokenize_sentence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_view_add(a : NlptokenizesentenceView, b : NlptokenizesentenceView) -> NlptokenizesentenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_view_copy(s : NlptokenizesentenceView) -> NlptokenizesentenceView {
  let result = nlp_tokenize_sentence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_view_fill(s : NlptokenizesentenceView, v : Double) -> NlptokenizesentenceView {
  let result = nlp_tokenize_sentence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_view_min(s : NlptokenizesentenceView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_view_max(s : NlptokenizesentenceView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_view_to_string(s : NlptokenizesentenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_range_make(size : Int) -> NlptokenizesentenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_range_len(s : NlptokenizesentenceRange) -> Int { s.size }

pub fn nlp_tokenize_sentence_range_get(s : NlptokenizesentenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_range_set(s : NlptokenizesentenceRange, i : Int, v : Double) -> NlptokenizesentenceRange {
  let result = nlp_tokenize_sentence_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_range_sum(s : NlptokenizesentenceRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_range_mean(s : NlptokenizesentenceRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_range_scale(s : NlptokenizesentenceRange, f : Double) -> NlptokenizesentenceRange {
  let result = nlp_tokenize_sentence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_range_add(a : NlptokenizesentenceRange, b : NlptokenizesentenceRange) -> NlptokenizesentenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_range_copy(s : NlptokenizesentenceRange) -> NlptokenizesentenceRange {
  let result = nlp_tokenize_sentence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_range_fill(s : NlptokenizesentenceRange, v : Double) -> NlptokenizesentenceRange {
  let result = nlp_tokenize_sentence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_range_min(s : NlptokenizesentenceRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_range_max(s : NlptokenizesentenceRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_range_to_string(s : NlptokenizesentenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesentenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_sentence_slice_make(size : Int) -> NlptokenizesentenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_sentence_slice_len(s : NlptokenizesentenceSlice) -> Int { s.size }

pub fn nlp_tokenize_sentence_slice_get(s : NlptokenizesentenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_sentence_slice_set(s : NlptokenizesentenceSlice, i : Int, v : Double) -> NlptokenizesentenceSlice {
  let result = nlp_tokenize_sentence_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_slice_sum(s : NlptokenizesentenceSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_sentence_slice_mean(s : NlptokenizesentenceSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_sentence_slice_scale(s : NlptokenizesentenceSlice, f : Double) -> NlptokenizesentenceSlice {
  let result = nlp_tokenize_sentence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_sentence_slice_add(a : NlptokenizesentenceSlice, b : NlptokenizesentenceSlice) -> NlptokenizesentenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_sentence_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_sentence_slice_copy(s : NlptokenizesentenceSlice) -> NlptokenizesentenceSlice {
  let result = nlp_tokenize_sentence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_sentence_slice_fill(s : NlptokenizesentenceSlice, v : Double) -> NlptokenizesentenceSlice {
  let result = nlp_tokenize_sentence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_sentence_slice_min(s : NlptokenizesentenceSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_sentence_slice_max(s : NlptokenizesentenceSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_sentence_slice_to_string(s : NlptokenizesentenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

