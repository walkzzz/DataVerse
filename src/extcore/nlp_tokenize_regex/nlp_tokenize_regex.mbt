///===
/// extcore/nlp_tokenize_regex

pub(all) struct NlptokenizeregexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_regex_make_point(x : Double, y : Double) -> NlptokenizeregexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_regex_make_point3(x : Double, y : Double, z : Double) -> NlptokenizeregexPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_regex_point_x(pt : NlptokenizeregexPoint) -> Double { pt.x }

pub fn nlp_tokenize_regex_point_y(pt : NlptokenizeregexPoint) -> Double { pt.y }

pub fn nlp_tokenize_regex_point_z(pt : NlptokenizeregexPoint) -> Double { pt.z }

pub fn nlp_tokenize_regex_point_label(pt : NlptokenizeregexPoint) -> Int { pt.label }

pub fn nlp_tokenize_regex_point_dist(a : NlptokenizeregexPoint, b : NlptokenizeregexPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_regex_point_add(a : NlptokenizeregexPoint, b : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_regex_point_sub(a : NlptokenizeregexPoint, b : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_regex_point_scale(pt : NlptokenizeregexPoint, s : Double) -> NlptokenizeregexPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_regex_point_dot(a : NlptokenizeregexPoint, b : NlptokenizeregexPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_regex_point_cross(a : NlptokenizeregexPoint, b : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_regex_point_norm(pt : NlptokenizeregexPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_regex_point_normalize(pt : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  let n = nlp_tokenize_regex_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_regex_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_regex_point_negate(pt : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_regex_point_mid(a : NlptokenizeregexPoint, b : NlptokenizeregexPoint) -> NlptokenizeregexPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_regex_point_lerp(a : NlptokenizeregexPoint, b : NlptokenizeregexPoint, t : Double) -> NlptokenizeregexPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_regex_point_to_string(pt : NlptokenizeregexPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizeregexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_regex_make_series(vals : Array[Double], name : String) -> NlptokenizeregexSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_regex_series_len(s : NlptokenizeregexSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_regex_series_sum(s : NlptokenizeregexSeries) -> Double { @_common.sum(s.vals) }

pub fn nlp_tokenize_regex_series_mean(s : NlptokenizeregexSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_regex_series_min(s : NlptokenizeregexSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_regex_series_max(s : NlptokenizeregexSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_regex_series_range(s : NlptokenizeregexSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_regex_series_var(s : NlptokenizeregexSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_regex_series_std(s : NlptokenizeregexSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_regex_series_median(s : NlptokenizeregexSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_regex_series_scale(s : NlptokenizeregexSeries, f : Double) -> NlptokenizeregexSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_regex_series_add(a : NlptokenizeregexSeries, b : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_regex_series_sub(a : NlptokenizeregexSeries, b : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_regex_series_normalize(s : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  let mn = nlp_tokenize_regex_series_min(s)
  let mx = nlp_tokenize_regex_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_regex_series_cumsum(s : NlptokenizeregexSeries) -> NlptokenizeregexSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_regex_series_to_string(s : NlptokenizeregexSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeregexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_regex_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizeregexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_regex_matrix_identity(n : Int) -> NlptokenizeregexMatrix {
  let m = nlp_tokenize_regex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_regex_matrix_get(m : NlptokenizeregexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_regex_matrix_transpose(m : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  let result = nlp_tokenize_regex_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_regex_matrix_add(a : NlptokenizeregexMatrix, b : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_regex_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_regex_matrix_scale(m : NlptokenizeregexMatrix, s : Double) -> NlptokenizeregexMatrix {
  let result = nlp_tokenize_regex_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_regex_matrix_multiply(a : NlptokenizeregexMatrix, b : NlptokenizeregexMatrix) -> NlptokenizeregexMatrix {
  if a.cols != b.rows { return nlp_tokenize_regex_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_regex_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_regex_matrix_trace(m : NlptokenizeregexMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_regex_matrix_det(m : NlptokenizeregexMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_regex_matrix_norm(m : NlptokenizeregexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_regex_matrix_to_string(m : NlptokenizeregexMatrix) -> String {
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

pub(all) struct NlptokenizeregexVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_regex_make_vector(comps : Array[Double]) -> NlptokenizeregexVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_regex_vector_zero(dim : Int) -> NlptokenizeregexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_regex_vector_add(a : NlptokenizeregexVector, b : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_regex_vector_sub(a : NlptokenizeregexVector, b : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_regex_vector_scale(v : NlptokenizeregexVector, s : Double) -> NlptokenizeregexVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_regex_vector_dot(a : NlptokenizeregexVector, b : NlptokenizeregexVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_regex_vector_norm(v : NlptokenizeregexVector) -> Double { @_common.sqrt(nlp_tokenize_regex_vector_dot(v, v)) }

pub fn nlp_tokenize_regex_vector_normalize(v : NlptokenizeregexVector) -> NlptokenizeregexVector {
  let n = nlp_tokenize_regex_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_regex_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_regex_vector_dist(a : NlptokenizeregexVector, b : NlptokenizeregexVector) -> Double {
  nlp_tokenize_regex_vector_norm(nlp_tokenize_regex_vector_sub(a, b))
}

pub fn nlp_tokenize_regex_vector_to_string(v : NlptokenizeregexVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_regex_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_regex_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_regex_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_regex_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_regex_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_regex_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_regex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_regex_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_regex_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_regex_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_regex_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_regex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_regex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_regex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_regex_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_regex_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_regex_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_regex_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_regex_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_regex_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_regex_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_regex_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_regex_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_regex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_regex_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_regex_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_regex_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_regex_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_regex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizeregexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_frame_make(size : Int) -> NlptokenizeregexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_frame_len(s : NlptokenizeregexFrame) -> Int { s.size }

pub fn nlp_tokenize_regex_frame_get(s : NlptokenizeregexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_frame_set(s : NlptokenizeregexFrame, i : Int, v : Double) -> NlptokenizeregexFrame {
  let result = nlp_tokenize_regex_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_frame_sum(s : NlptokenizeregexFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_frame_mean(s : NlptokenizeregexFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_frame_scale(s : NlptokenizeregexFrame, f : Double) -> NlptokenizeregexFrame {
  let result = nlp_tokenize_regex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_frame_add(a : NlptokenizeregexFrame, b : NlptokenizeregexFrame) -> NlptokenizeregexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_frame_copy(s : NlptokenizeregexFrame) -> NlptokenizeregexFrame {
  let result = nlp_tokenize_regex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_frame_fill(s : NlptokenizeregexFrame, v : Double) -> NlptokenizeregexFrame {
  let result = nlp_tokenize_regex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_frame_min(s : NlptokenizeregexFrame) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_frame_max(s : NlptokenizeregexFrame) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_frame_to_string(s : NlptokenizeregexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_table_make(size : Int) -> NlptokenizeregexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_table_len(s : NlptokenizeregexTable) -> Int { s.size }

pub fn nlp_tokenize_regex_table_get(s : NlptokenizeregexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_table_set(s : NlptokenizeregexTable, i : Int, v : Double) -> NlptokenizeregexTable {
  let result = nlp_tokenize_regex_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_table_sum(s : NlptokenizeregexTable) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_table_mean(s : NlptokenizeregexTable) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_table_scale(s : NlptokenizeregexTable, f : Double) -> NlptokenizeregexTable {
  let result = nlp_tokenize_regex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_table_add(a : NlptokenizeregexTable, b : NlptokenizeregexTable) -> NlptokenizeregexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_table_copy(s : NlptokenizeregexTable) -> NlptokenizeregexTable {
  let result = nlp_tokenize_regex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_table_fill(s : NlptokenizeregexTable, v : Double) -> NlptokenizeregexTable {
  let result = nlp_tokenize_regex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_table_min(s : NlptokenizeregexTable) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_table_max(s : NlptokenizeregexTable) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_table_to_string(s : NlptokenizeregexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_graphn_make(size : Int) -> NlptokenizeregexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_graphn_len(s : NlptokenizeregexGraphN) -> Int { s.size }

pub fn nlp_tokenize_regex_graphn_get(s : NlptokenizeregexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_graphn_set(s : NlptokenizeregexGraphN, i : Int, v : Double) -> NlptokenizeregexGraphN {
  let result = nlp_tokenize_regex_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_graphn_sum(s : NlptokenizeregexGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_graphn_mean(s : NlptokenizeregexGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_graphn_scale(s : NlptokenizeregexGraphN, f : Double) -> NlptokenizeregexGraphN {
  let result = nlp_tokenize_regex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_graphn_add(a : NlptokenizeregexGraphN, b : NlptokenizeregexGraphN) -> NlptokenizeregexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_graphn_copy(s : NlptokenizeregexGraphN) -> NlptokenizeregexGraphN {
  let result = nlp_tokenize_regex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_graphn_fill(s : NlptokenizeregexGraphN, v : Double) -> NlptokenizeregexGraphN {
  let result = nlp_tokenize_regex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_graphn_min(s : NlptokenizeregexGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_graphn_max(s : NlptokenizeregexGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_graphn_to_string(s : NlptokenizeregexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_node_make(size : Int) -> NlptokenizeregexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_node_len(s : NlptokenizeregexNode) -> Int { s.size }

pub fn nlp_tokenize_regex_node_get(s : NlptokenizeregexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_node_set(s : NlptokenizeregexNode, i : Int, v : Double) -> NlptokenizeregexNode {
  let result = nlp_tokenize_regex_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_node_sum(s : NlptokenizeregexNode) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_node_mean(s : NlptokenizeregexNode) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_node_scale(s : NlptokenizeregexNode, f : Double) -> NlptokenizeregexNode {
  let result = nlp_tokenize_regex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_node_add(a : NlptokenizeregexNode, b : NlptokenizeregexNode) -> NlptokenizeregexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_node_copy(s : NlptokenizeregexNode) -> NlptokenizeregexNode {
  let result = nlp_tokenize_regex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_node_fill(s : NlptokenizeregexNode, v : Double) -> NlptokenizeregexNode {
  let result = nlp_tokenize_regex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_node_min(s : NlptokenizeregexNode) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_node_max(s : NlptokenizeregexNode) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_node_to_string(s : NlptokenizeregexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_edge_make(size : Int) -> NlptokenizeregexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_edge_len(s : NlptokenizeregexEdge) -> Int { s.size }

pub fn nlp_tokenize_regex_edge_get(s : NlptokenizeregexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_edge_set(s : NlptokenizeregexEdge, i : Int, v : Double) -> NlptokenizeregexEdge {
  let result = nlp_tokenize_regex_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_edge_sum(s : NlptokenizeregexEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_edge_mean(s : NlptokenizeregexEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_edge_scale(s : NlptokenizeregexEdge, f : Double) -> NlptokenizeregexEdge {
  let result = nlp_tokenize_regex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_edge_add(a : NlptokenizeregexEdge, b : NlptokenizeregexEdge) -> NlptokenizeregexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_edge_copy(s : NlptokenizeregexEdge) -> NlptokenizeregexEdge {
  let result = nlp_tokenize_regex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_edge_fill(s : NlptokenizeregexEdge, v : Double) -> NlptokenizeregexEdge {
  let result = nlp_tokenize_regex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_edge_min(s : NlptokenizeregexEdge) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_edge_max(s : NlptokenizeregexEdge) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_edge_to_string(s : NlptokenizeregexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_path_make(size : Int) -> NlptokenizeregexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_path_len(s : NlptokenizeregexPath) -> Int { s.size }

pub fn nlp_tokenize_regex_path_get(s : NlptokenizeregexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_path_set(s : NlptokenizeregexPath, i : Int, v : Double) -> NlptokenizeregexPath {
  let result = nlp_tokenize_regex_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_path_sum(s : NlptokenizeregexPath) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_path_mean(s : NlptokenizeregexPath) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_path_scale(s : NlptokenizeregexPath, f : Double) -> NlptokenizeregexPath {
  let result = nlp_tokenize_regex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_path_add(a : NlptokenizeregexPath, b : NlptokenizeregexPath) -> NlptokenizeregexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_path_copy(s : NlptokenizeregexPath) -> NlptokenizeregexPath {
  let result = nlp_tokenize_regex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_path_fill(s : NlptokenizeregexPath, v : Double) -> NlptokenizeregexPath {
  let result = nlp_tokenize_regex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_path_min(s : NlptokenizeregexPath) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_path_max(s : NlptokenizeregexPath) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_path_to_string(s : NlptokenizeregexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_cluster_make(size : Int) -> NlptokenizeregexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_cluster_len(s : NlptokenizeregexCluster) -> Int { s.size }

pub fn nlp_tokenize_regex_cluster_get(s : NlptokenizeregexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_cluster_set(s : NlptokenizeregexCluster, i : Int, v : Double) -> NlptokenizeregexCluster {
  let result = nlp_tokenize_regex_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_cluster_sum(s : NlptokenizeregexCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_cluster_mean(s : NlptokenizeregexCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_cluster_scale(s : NlptokenizeregexCluster, f : Double) -> NlptokenizeregexCluster {
  let result = nlp_tokenize_regex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_cluster_add(a : NlptokenizeregexCluster, b : NlptokenizeregexCluster) -> NlptokenizeregexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_cluster_copy(s : NlptokenizeregexCluster) -> NlptokenizeregexCluster {
  let result = nlp_tokenize_regex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_cluster_fill(s : NlptokenizeregexCluster, v : Double) -> NlptokenizeregexCluster {
  let result = nlp_tokenize_regex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_cluster_min(s : NlptokenizeregexCluster) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_cluster_max(s : NlptokenizeregexCluster) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_cluster_to_string(s : NlptokenizeregexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_model_make(size : Int) -> NlptokenizeregexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_model_len(s : NlptokenizeregexModel) -> Int { s.size }

pub fn nlp_tokenize_regex_model_get(s : NlptokenizeregexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_model_set(s : NlptokenizeregexModel, i : Int, v : Double) -> NlptokenizeregexModel {
  let result = nlp_tokenize_regex_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_model_sum(s : NlptokenizeregexModel) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_model_mean(s : NlptokenizeregexModel) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_model_scale(s : NlptokenizeregexModel, f : Double) -> NlptokenizeregexModel {
  let result = nlp_tokenize_regex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_model_add(a : NlptokenizeregexModel, b : NlptokenizeregexModel) -> NlptokenizeregexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_model_copy(s : NlptokenizeregexModel) -> NlptokenizeregexModel {
  let result = nlp_tokenize_regex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_model_fill(s : NlptokenizeregexModel, v : Double) -> NlptokenizeregexModel {
  let result = nlp_tokenize_regex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_model_min(s : NlptokenizeregexModel) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_model_max(s : NlptokenizeregexModel) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_model_to_string(s : NlptokenizeregexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_layer_make(size : Int) -> NlptokenizeregexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_layer_len(s : NlptokenizeregexLayer) -> Int { s.size }

pub fn nlp_tokenize_regex_layer_get(s : NlptokenizeregexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_layer_set(s : NlptokenizeregexLayer, i : Int, v : Double) -> NlptokenizeregexLayer {
  let result = nlp_tokenize_regex_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_layer_sum(s : NlptokenizeregexLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_layer_mean(s : NlptokenizeregexLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_layer_scale(s : NlptokenizeregexLayer, f : Double) -> NlptokenizeregexLayer {
  let result = nlp_tokenize_regex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_layer_add(a : NlptokenizeregexLayer, b : NlptokenizeregexLayer) -> NlptokenizeregexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_layer_copy(s : NlptokenizeregexLayer) -> NlptokenizeregexLayer {
  let result = nlp_tokenize_regex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_layer_fill(s : NlptokenizeregexLayer, v : Double) -> NlptokenizeregexLayer {
  let result = nlp_tokenize_regex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_layer_min(s : NlptokenizeregexLayer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_layer_max(s : NlptokenizeregexLayer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_layer_to_string(s : NlptokenizeregexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_buffer_make(size : Int) -> NlptokenizeregexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_buffer_len(s : NlptokenizeregexBuffer) -> Int { s.size }

pub fn nlp_tokenize_regex_buffer_get(s : NlptokenizeregexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_buffer_set(s : NlptokenizeregexBuffer, i : Int, v : Double) -> NlptokenizeregexBuffer {
  let result = nlp_tokenize_regex_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_buffer_sum(s : NlptokenizeregexBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_buffer_mean(s : NlptokenizeregexBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_buffer_scale(s : NlptokenizeregexBuffer, f : Double) -> NlptokenizeregexBuffer {
  let result = nlp_tokenize_regex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_buffer_add(a : NlptokenizeregexBuffer, b : NlptokenizeregexBuffer) -> NlptokenizeregexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_buffer_copy(s : NlptokenizeregexBuffer) -> NlptokenizeregexBuffer {
  let result = nlp_tokenize_regex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_buffer_fill(s : NlptokenizeregexBuffer, v : Double) -> NlptokenizeregexBuffer {
  let result = nlp_tokenize_regex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_buffer_min(s : NlptokenizeregexBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_buffer_max(s : NlptokenizeregexBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_buffer_to_string(s : NlptokenizeregexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_cursor_make(size : Int) -> NlptokenizeregexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_cursor_len(s : NlptokenizeregexCursor) -> Int { s.size }

pub fn nlp_tokenize_regex_cursor_get(s : NlptokenizeregexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_cursor_set(s : NlptokenizeregexCursor, i : Int, v : Double) -> NlptokenizeregexCursor {
  let result = nlp_tokenize_regex_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_cursor_sum(s : NlptokenizeregexCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_cursor_mean(s : NlptokenizeregexCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_cursor_scale(s : NlptokenizeregexCursor, f : Double) -> NlptokenizeregexCursor {
  let result = nlp_tokenize_regex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_cursor_add(a : NlptokenizeregexCursor, b : NlptokenizeregexCursor) -> NlptokenizeregexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_cursor_copy(s : NlptokenizeregexCursor) -> NlptokenizeregexCursor {
  let result = nlp_tokenize_regex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_cursor_fill(s : NlptokenizeregexCursor, v : Double) -> NlptokenizeregexCursor {
  let result = nlp_tokenize_regex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_cursor_min(s : NlptokenizeregexCursor) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_cursor_max(s : NlptokenizeregexCursor) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_cursor_to_string(s : NlptokenizeregexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_view_make(size : Int) -> NlptokenizeregexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_view_len(s : NlptokenizeregexView) -> Int { s.size }

pub fn nlp_tokenize_regex_view_get(s : NlptokenizeregexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_view_set(s : NlptokenizeregexView, i : Int, v : Double) -> NlptokenizeregexView {
  let result = nlp_tokenize_regex_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_view_sum(s : NlptokenizeregexView) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_view_mean(s : NlptokenizeregexView) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_view_scale(s : NlptokenizeregexView, f : Double) -> NlptokenizeregexView {
  let result = nlp_tokenize_regex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_view_add(a : NlptokenizeregexView, b : NlptokenizeregexView) -> NlptokenizeregexView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_view_copy(s : NlptokenizeregexView) -> NlptokenizeregexView {
  let result = nlp_tokenize_regex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_view_fill(s : NlptokenizeregexView, v : Double) -> NlptokenizeregexView {
  let result = nlp_tokenize_regex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_view_min(s : NlptokenizeregexView) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_view_max(s : NlptokenizeregexView) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_view_to_string(s : NlptokenizeregexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_range_make(size : Int) -> NlptokenizeregexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_range_len(s : NlptokenizeregexRange) -> Int { s.size }

pub fn nlp_tokenize_regex_range_get(s : NlptokenizeregexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_range_set(s : NlptokenizeregexRange, i : Int, v : Double) -> NlptokenizeregexRange {
  let result = nlp_tokenize_regex_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_range_sum(s : NlptokenizeregexRange) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_range_mean(s : NlptokenizeregexRange) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_range_scale(s : NlptokenizeregexRange, f : Double) -> NlptokenizeregexRange {
  let result = nlp_tokenize_regex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_range_add(a : NlptokenizeregexRange, b : NlptokenizeregexRange) -> NlptokenizeregexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_range_copy(s : NlptokenizeregexRange) -> NlptokenizeregexRange {
  let result = nlp_tokenize_regex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_range_fill(s : NlptokenizeregexRange, v : Double) -> NlptokenizeregexRange {
  let result = nlp_tokenize_regex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_range_min(s : NlptokenizeregexRange) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_range_max(s : NlptokenizeregexRange) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_range_to_string(s : NlptokenizeregexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeregexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_regex_slice_make(size : Int) -> NlptokenizeregexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_regex_slice_len(s : NlptokenizeregexSlice) -> Int { s.size }

pub fn nlp_tokenize_regex_slice_get(s : NlptokenizeregexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_regex_slice_set(s : NlptokenizeregexSlice, i : Int, v : Double) -> NlptokenizeregexSlice {
  let result = nlp_tokenize_regex_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_slice_sum(s : NlptokenizeregexSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_tokenize_regex_slice_mean(s : NlptokenizeregexSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_tokenize_regex_slice_scale(s : NlptokenizeregexSlice, f : Double) -> NlptokenizeregexSlice {
  let result = nlp_tokenize_regex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_regex_slice_add(a : NlptokenizeregexSlice, b : NlptokenizeregexSlice) -> NlptokenizeregexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_regex_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_regex_slice_copy(s : NlptokenizeregexSlice) -> NlptokenizeregexSlice {
  let result = nlp_tokenize_regex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_regex_slice_fill(s : NlptokenizeregexSlice, v : Double) -> NlptokenizeregexSlice {
  let result = nlp_tokenize_regex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_regex_slice_min(s : NlptokenizeregexSlice) -> Double { @_common.min(s.data) }

pub fn nlp_tokenize_regex_slice_max(s : NlptokenizeregexSlice) -> Double { @_common.max(s.data) }

pub fn nlp_tokenize_regex_slice_to_string(s : NlptokenizeregexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

