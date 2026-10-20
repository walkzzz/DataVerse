///===
/// extcore/nlp_tokenize_char

pub(all) struct NlptokenizecharPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_char_make_point(x : Double, y : Double) -> NlptokenizecharPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_char_make_point3(x : Double, y : Double, z : Double) -> NlptokenizecharPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_char_point_x(pt : NlptokenizecharPoint) -> Double { pt.x }

pub fn nlp_tokenize_char_point_y(pt : NlptokenizecharPoint) -> Double { pt.y }

pub fn nlp_tokenize_char_point_z(pt : NlptokenizecharPoint) -> Double { pt.z }

pub fn nlp_tokenize_char_point_label(pt : NlptokenizecharPoint) -> Int { pt.label }

pub fn nlp_tokenize_char_point_dist(a : NlptokenizecharPoint, b : NlptokenizecharPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_char_point_add(a : NlptokenizecharPoint, b : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_char_point_sub(a : NlptokenizecharPoint, b : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_char_point_scale(pt : NlptokenizecharPoint, s : Double) -> NlptokenizecharPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_char_point_dot(a : NlptokenizecharPoint, b : NlptokenizecharPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_char_point_cross(a : NlptokenizecharPoint, b : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_char_point_norm(pt : NlptokenizecharPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_char_point_normalize(pt : NlptokenizecharPoint) -> NlptokenizecharPoint {
  let n = nlp_tokenize_char_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_char_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_char_point_negate(pt : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_char_point_mid(a : NlptokenizecharPoint, b : NlptokenizecharPoint) -> NlptokenizecharPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_char_point_lerp(a : NlptokenizecharPoint, b : NlptokenizecharPoint, t : Double) -> NlptokenizecharPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_char_point_to_string(pt : NlptokenizecharPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizecharSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_char_make_series(vals : Array[Double], name : String) -> NlptokenizecharSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_char_series_len(s : NlptokenizecharSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_char_series_sum(s : NlptokenizecharSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_tokenize_char_series_mean(s : NlptokenizecharSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_char_series_min(s : NlptokenizecharSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_char_series_max(s : NlptokenizecharSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_char_series_range(s : NlptokenizecharSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_char_series_var(s : NlptokenizecharSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_char_series_std(s : NlptokenizecharSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_char_series_median(s : NlptokenizecharSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_char_series_scale(s : NlptokenizecharSeries, f : Double) -> NlptokenizecharSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_char_series_add(a : NlptokenizecharSeries, b : NlptokenizecharSeries) -> NlptokenizecharSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_char_series_sub(a : NlptokenizecharSeries, b : NlptokenizecharSeries) -> NlptokenizecharSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_char_series_normalize(s : NlptokenizecharSeries) -> NlptokenizecharSeries {
  let mn = nlp_tokenize_char_series_min(s)
  let mx = nlp_tokenize_char_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_char_series_cumsum(s : NlptokenizecharSeries) -> NlptokenizecharSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_char_series_to_string(s : NlptokenizecharSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizecharMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_char_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizecharMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_char_matrix_identity(n : Int) -> NlptokenizecharMatrix {
  let m = nlp_tokenize_char_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_char_matrix_get(m : NlptokenizecharMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_char_matrix_transpose(m : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  let result = nlp_tokenize_char_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_char_matrix_add(a : NlptokenizecharMatrix, b : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_char_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_char_matrix_scale(m : NlptokenizecharMatrix, s : Double) -> NlptokenizecharMatrix {
  let result = nlp_tokenize_char_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_char_matrix_multiply(a : NlptokenizecharMatrix, b : NlptokenizecharMatrix) -> NlptokenizecharMatrix {
  if a.cols != b.rows { return nlp_tokenize_char_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_char_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_char_matrix_trace(m : NlptokenizecharMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_char_matrix_det(m : NlptokenizecharMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_char_matrix_norm(m : NlptokenizecharMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_char_matrix_to_string(m : NlptokenizecharMatrix) -> String {
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

pub(all) struct NlptokenizecharVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_char_make_vector(comps : Array[Double]) -> NlptokenizecharVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_char_vector_zero(dim : Int) -> NlptokenizecharVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_char_vector_add(a : NlptokenizecharVector, b : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_char_vector_sub(a : NlptokenizecharVector, b : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_char_vector_scale(v : NlptokenizecharVector, s : Double) -> NlptokenizecharVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_char_vector_dot(a : NlptokenizecharVector, b : NlptokenizecharVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_char_vector_norm(v : NlptokenizecharVector) -> Double { @_common.sqrt(nlp_tokenize_char_vector_dot(v, v)) }

pub fn nlp_tokenize_char_vector_normalize(v : NlptokenizecharVector) -> NlptokenizecharVector {
  let n = nlp_tokenize_char_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_char_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_char_vector_dist(a : NlptokenizecharVector, b : NlptokenizecharVector) -> Double {
  nlp_tokenize_char_vector_norm(nlp_tokenize_char_vector_sub(a, b))
}

pub fn nlp_tokenize_char_vector_to_string(v : NlptokenizecharVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_char_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_char_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_char_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_char_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_char_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_char_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_char_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_char_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_char_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_char_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_char_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_char_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_char_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_char_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_char_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_char_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_char_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_char_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_char_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_char_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_char_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_char_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_char_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_char_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_char_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_char_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_char_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_char_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_char_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizecharFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_frame_make(size : Int) -> NlptokenizecharFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_frame_len(s : NlptokenizecharFrame) -> Int { s.size }

pub fn nlp_tokenize_char_frame_get(s : NlptokenizecharFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_frame_set(s : NlptokenizecharFrame, i : Int, v : Double) -> NlptokenizecharFrame {
  let result = nlp_tokenize_char_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_frame_sum(s : NlptokenizecharFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_frame_mean(s : NlptokenizecharFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_frame_scale(s : NlptokenizecharFrame, f : Double) -> NlptokenizecharFrame {
  let result = nlp_tokenize_char_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_frame_add(a : NlptokenizecharFrame, b : NlptokenizecharFrame) -> NlptokenizecharFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_frame_copy(s : NlptokenizecharFrame) -> NlptokenizecharFrame {
  let result = nlp_tokenize_char_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_frame_fill(s : NlptokenizecharFrame, v : Double) -> NlptokenizecharFrame {
  let result = nlp_tokenize_char_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_frame_min(s : NlptokenizecharFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_frame_max(s : NlptokenizecharFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_frame_to_string(s : NlptokenizecharFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_table_make(size : Int) -> NlptokenizecharTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_table_len(s : NlptokenizecharTable) -> Int { s.size }

pub fn nlp_tokenize_char_table_get(s : NlptokenizecharTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_table_set(s : NlptokenizecharTable, i : Int, v : Double) -> NlptokenizecharTable {
  let result = nlp_tokenize_char_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_table_sum(s : NlptokenizecharTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_table_mean(s : NlptokenizecharTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_table_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_table_scale(s : NlptokenizecharTable, f : Double) -> NlptokenizecharTable {
  let result = nlp_tokenize_char_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_table_add(a : NlptokenizecharTable, b : NlptokenizecharTable) -> NlptokenizecharTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_table_copy(s : NlptokenizecharTable) -> NlptokenizecharTable {
  let result = nlp_tokenize_char_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_table_fill(s : NlptokenizecharTable, v : Double) -> NlptokenizecharTable {
  let result = nlp_tokenize_char_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_table_min(s : NlptokenizecharTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_table_max(s : NlptokenizecharTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_table_to_string(s : NlptokenizecharTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_graphn_make(size : Int) -> NlptokenizecharGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_graphn_len(s : NlptokenizecharGraphN) -> Int { s.size }

pub fn nlp_tokenize_char_graphn_get(s : NlptokenizecharGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_graphn_set(s : NlptokenizecharGraphN, i : Int, v : Double) -> NlptokenizecharGraphN {
  let result = nlp_tokenize_char_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_graphn_sum(s : NlptokenizecharGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_graphn_mean(s : NlptokenizecharGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_graphn_scale(s : NlptokenizecharGraphN, f : Double) -> NlptokenizecharGraphN {
  let result = nlp_tokenize_char_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_graphn_add(a : NlptokenizecharGraphN, b : NlptokenizecharGraphN) -> NlptokenizecharGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_graphn_copy(s : NlptokenizecharGraphN) -> NlptokenizecharGraphN {
  let result = nlp_tokenize_char_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_graphn_fill(s : NlptokenizecharGraphN, v : Double) -> NlptokenizecharGraphN {
  let result = nlp_tokenize_char_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_graphn_min(s : NlptokenizecharGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_graphn_max(s : NlptokenizecharGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_graphn_to_string(s : NlptokenizecharGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_node_make(size : Int) -> NlptokenizecharNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_node_len(s : NlptokenizecharNode) -> Int { s.size }

pub fn nlp_tokenize_char_node_get(s : NlptokenizecharNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_node_set(s : NlptokenizecharNode, i : Int, v : Double) -> NlptokenizecharNode {
  let result = nlp_tokenize_char_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_node_sum(s : NlptokenizecharNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_node_mean(s : NlptokenizecharNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_node_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_node_scale(s : NlptokenizecharNode, f : Double) -> NlptokenizecharNode {
  let result = nlp_tokenize_char_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_node_add(a : NlptokenizecharNode, b : NlptokenizecharNode) -> NlptokenizecharNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_node_copy(s : NlptokenizecharNode) -> NlptokenizecharNode {
  let result = nlp_tokenize_char_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_node_fill(s : NlptokenizecharNode, v : Double) -> NlptokenizecharNode {
  let result = nlp_tokenize_char_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_node_min(s : NlptokenizecharNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_node_max(s : NlptokenizecharNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_node_to_string(s : NlptokenizecharNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_edge_make(size : Int) -> NlptokenizecharEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_edge_len(s : NlptokenizecharEdge) -> Int { s.size }

pub fn nlp_tokenize_char_edge_get(s : NlptokenizecharEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_edge_set(s : NlptokenizecharEdge, i : Int, v : Double) -> NlptokenizecharEdge {
  let result = nlp_tokenize_char_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_edge_sum(s : NlptokenizecharEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_edge_mean(s : NlptokenizecharEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_edge_scale(s : NlptokenizecharEdge, f : Double) -> NlptokenizecharEdge {
  let result = nlp_tokenize_char_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_edge_add(a : NlptokenizecharEdge, b : NlptokenizecharEdge) -> NlptokenizecharEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_edge_copy(s : NlptokenizecharEdge) -> NlptokenizecharEdge {
  let result = nlp_tokenize_char_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_edge_fill(s : NlptokenizecharEdge, v : Double) -> NlptokenizecharEdge {
  let result = nlp_tokenize_char_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_edge_min(s : NlptokenizecharEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_edge_max(s : NlptokenizecharEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_edge_to_string(s : NlptokenizecharEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_path_make(size : Int) -> NlptokenizecharPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_path_len(s : NlptokenizecharPath) -> Int { s.size }

pub fn nlp_tokenize_char_path_get(s : NlptokenizecharPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_path_set(s : NlptokenizecharPath, i : Int, v : Double) -> NlptokenizecharPath {
  let result = nlp_tokenize_char_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_path_sum(s : NlptokenizecharPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_path_mean(s : NlptokenizecharPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_path_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_path_scale(s : NlptokenizecharPath, f : Double) -> NlptokenizecharPath {
  let result = nlp_tokenize_char_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_path_add(a : NlptokenizecharPath, b : NlptokenizecharPath) -> NlptokenizecharPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_path_copy(s : NlptokenizecharPath) -> NlptokenizecharPath {
  let result = nlp_tokenize_char_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_path_fill(s : NlptokenizecharPath, v : Double) -> NlptokenizecharPath {
  let result = nlp_tokenize_char_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_path_min(s : NlptokenizecharPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_path_max(s : NlptokenizecharPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_path_to_string(s : NlptokenizecharPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_cluster_make(size : Int) -> NlptokenizecharCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_cluster_len(s : NlptokenizecharCluster) -> Int { s.size }

pub fn nlp_tokenize_char_cluster_get(s : NlptokenizecharCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_cluster_set(s : NlptokenizecharCluster, i : Int, v : Double) -> NlptokenizecharCluster {
  let result = nlp_tokenize_char_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_cluster_sum(s : NlptokenizecharCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_cluster_mean(s : NlptokenizecharCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_cluster_scale(s : NlptokenizecharCluster, f : Double) -> NlptokenizecharCluster {
  let result = nlp_tokenize_char_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_cluster_add(a : NlptokenizecharCluster, b : NlptokenizecharCluster) -> NlptokenizecharCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_cluster_copy(s : NlptokenizecharCluster) -> NlptokenizecharCluster {
  let result = nlp_tokenize_char_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_cluster_fill(s : NlptokenizecharCluster, v : Double) -> NlptokenizecharCluster {
  let result = nlp_tokenize_char_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_cluster_min(s : NlptokenizecharCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_cluster_max(s : NlptokenizecharCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_cluster_to_string(s : NlptokenizecharCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_model_make(size : Int) -> NlptokenizecharModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_model_len(s : NlptokenizecharModel) -> Int { s.size }

pub fn nlp_tokenize_char_model_get(s : NlptokenizecharModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_model_set(s : NlptokenizecharModel, i : Int, v : Double) -> NlptokenizecharModel {
  let result = nlp_tokenize_char_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_model_sum(s : NlptokenizecharModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_model_mean(s : NlptokenizecharModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_model_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_model_scale(s : NlptokenizecharModel, f : Double) -> NlptokenizecharModel {
  let result = nlp_tokenize_char_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_model_add(a : NlptokenizecharModel, b : NlptokenizecharModel) -> NlptokenizecharModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_model_copy(s : NlptokenizecharModel) -> NlptokenizecharModel {
  let result = nlp_tokenize_char_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_model_fill(s : NlptokenizecharModel, v : Double) -> NlptokenizecharModel {
  let result = nlp_tokenize_char_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_model_min(s : NlptokenizecharModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_model_max(s : NlptokenizecharModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_model_to_string(s : NlptokenizecharModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_layer_make(size : Int) -> NlptokenizecharLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_layer_len(s : NlptokenizecharLayer) -> Int { s.size }

pub fn nlp_tokenize_char_layer_get(s : NlptokenizecharLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_layer_set(s : NlptokenizecharLayer, i : Int, v : Double) -> NlptokenizecharLayer {
  let result = nlp_tokenize_char_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_layer_sum(s : NlptokenizecharLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_layer_mean(s : NlptokenizecharLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_layer_scale(s : NlptokenizecharLayer, f : Double) -> NlptokenizecharLayer {
  let result = nlp_tokenize_char_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_layer_add(a : NlptokenizecharLayer, b : NlptokenizecharLayer) -> NlptokenizecharLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_layer_copy(s : NlptokenizecharLayer) -> NlptokenizecharLayer {
  let result = nlp_tokenize_char_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_layer_fill(s : NlptokenizecharLayer, v : Double) -> NlptokenizecharLayer {
  let result = nlp_tokenize_char_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_layer_min(s : NlptokenizecharLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_layer_max(s : NlptokenizecharLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_layer_to_string(s : NlptokenizecharLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_buffer_make(size : Int) -> NlptokenizecharBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_buffer_len(s : NlptokenizecharBuffer) -> Int { s.size }

pub fn nlp_tokenize_char_buffer_get(s : NlptokenizecharBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_buffer_set(s : NlptokenizecharBuffer, i : Int, v : Double) -> NlptokenizecharBuffer {
  let result = nlp_tokenize_char_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_buffer_sum(s : NlptokenizecharBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_buffer_mean(s : NlptokenizecharBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_buffer_scale(s : NlptokenizecharBuffer, f : Double) -> NlptokenizecharBuffer {
  let result = nlp_tokenize_char_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_buffer_add(a : NlptokenizecharBuffer, b : NlptokenizecharBuffer) -> NlptokenizecharBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_buffer_copy(s : NlptokenizecharBuffer) -> NlptokenizecharBuffer {
  let result = nlp_tokenize_char_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_buffer_fill(s : NlptokenizecharBuffer, v : Double) -> NlptokenizecharBuffer {
  let result = nlp_tokenize_char_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_buffer_min(s : NlptokenizecharBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_buffer_max(s : NlptokenizecharBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_buffer_to_string(s : NlptokenizecharBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_cursor_make(size : Int) -> NlptokenizecharCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_cursor_len(s : NlptokenizecharCursor) -> Int { s.size }

pub fn nlp_tokenize_char_cursor_get(s : NlptokenizecharCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_cursor_set(s : NlptokenizecharCursor, i : Int, v : Double) -> NlptokenizecharCursor {
  let result = nlp_tokenize_char_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_cursor_sum(s : NlptokenizecharCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_cursor_mean(s : NlptokenizecharCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_cursor_scale(s : NlptokenizecharCursor, f : Double) -> NlptokenizecharCursor {
  let result = nlp_tokenize_char_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_cursor_add(a : NlptokenizecharCursor, b : NlptokenizecharCursor) -> NlptokenizecharCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_cursor_copy(s : NlptokenizecharCursor) -> NlptokenizecharCursor {
  let result = nlp_tokenize_char_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_cursor_fill(s : NlptokenizecharCursor, v : Double) -> NlptokenizecharCursor {
  let result = nlp_tokenize_char_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_cursor_min(s : NlptokenizecharCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_cursor_max(s : NlptokenizecharCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_cursor_to_string(s : NlptokenizecharCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_view_make(size : Int) -> NlptokenizecharView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_view_len(s : NlptokenizecharView) -> Int { s.size }

pub fn nlp_tokenize_char_view_get(s : NlptokenizecharView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_view_set(s : NlptokenizecharView, i : Int, v : Double) -> NlptokenizecharView {
  let result = nlp_tokenize_char_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_view_sum(s : NlptokenizecharView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_view_mean(s : NlptokenizecharView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_view_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_view_scale(s : NlptokenizecharView, f : Double) -> NlptokenizecharView {
  let result = nlp_tokenize_char_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_view_add(a : NlptokenizecharView, b : NlptokenizecharView) -> NlptokenizecharView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_view_copy(s : NlptokenizecharView) -> NlptokenizecharView {
  let result = nlp_tokenize_char_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_view_fill(s : NlptokenizecharView, v : Double) -> NlptokenizecharView {
  let result = nlp_tokenize_char_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_view_min(s : NlptokenizecharView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_view_max(s : NlptokenizecharView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_view_to_string(s : NlptokenizecharView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_range_make(size : Int) -> NlptokenizecharRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_range_len(s : NlptokenizecharRange) -> Int { s.size }

pub fn nlp_tokenize_char_range_get(s : NlptokenizecharRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_range_set(s : NlptokenizecharRange, i : Int, v : Double) -> NlptokenizecharRange {
  let result = nlp_tokenize_char_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_range_sum(s : NlptokenizecharRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_range_mean(s : NlptokenizecharRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_range_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_range_scale(s : NlptokenizecharRange, f : Double) -> NlptokenizecharRange {
  let result = nlp_tokenize_char_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_range_add(a : NlptokenizecharRange, b : NlptokenizecharRange) -> NlptokenizecharRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_range_copy(s : NlptokenizecharRange) -> NlptokenizecharRange {
  let result = nlp_tokenize_char_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_range_fill(s : NlptokenizecharRange, v : Double) -> NlptokenizecharRange {
  let result = nlp_tokenize_char_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_range_min(s : NlptokenizecharRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_range_max(s : NlptokenizecharRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_range_to_string(s : NlptokenizecharRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizecharSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_char_slice_make(size : Int) -> NlptokenizecharSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_char_slice_len(s : NlptokenizecharSlice) -> Int { s.size }

pub fn nlp_tokenize_char_slice_get(s : NlptokenizecharSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_char_slice_set(s : NlptokenizecharSlice, i : Int, v : Double) -> NlptokenizecharSlice {
  let result = nlp_tokenize_char_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_slice_sum(s : NlptokenizecharSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_char_slice_mean(s : NlptokenizecharSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_char_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_char_slice_scale(s : NlptokenizecharSlice, f : Double) -> NlptokenizecharSlice {
  let result = nlp_tokenize_char_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_char_slice_add(a : NlptokenizecharSlice, b : NlptokenizecharSlice) -> NlptokenizecharSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_char_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_char_slice_copy(s : NlptokenizecharSlice) -> NlptokenizecharSlice {
  let result = nlp_tokenize_char_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_char_slice_fill(s : NlptokenizecharSlice, v : Double) -> NlptokenizecharSlice {
  let result = nlp_tokenize_char_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_char_slice_min(s : NlptokenizecharSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_slice_max(s : NlptokenizecharSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_char_slice_to_string(s : NlptokenizecharSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

