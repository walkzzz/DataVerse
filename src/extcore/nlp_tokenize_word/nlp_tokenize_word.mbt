///===
/// extcore/nlp_tokenize_word

pub(all) struct NlptokenizewordPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_word_make_point(x : Double, y : Double) -> NlptokenizewordPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_word_make_point3(x : Double, y : Double, z : Double) -> NlptokenizewordPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_word_point_x(pt : NlptokenizewordPoint) -> Double { pt.x }

pub fn nlp_tokenize_word_point_y(pt : NlptokenizewordPoint) -> Double { pt.y }

pub fn nlp_tokenize_word_point_z(pt : NlptokenizewordPoint) -> Double { pt.z }

pub fn nlp_tokenize_word_point_label(pt : NlptokenizewordPoint) -> Int { pt.label }

pub fn nlp_tokenize_word_point_dist(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_word_point_add(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_word_point_sub(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_word_point_scale(pt : NlptokenizewordPoint, s : Double) -> NlptokenizewordPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_word_point_dot(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_word_point_cross(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_word_point_norm(pt : NlptokenizewordPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_word_point_normalize(pt : NlptokenizewordPoint) -> NlptokenizewordPoint {
  let n = nlp_tokenize_word_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_word_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_word_point_negate(pt : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_word_point_mid(a : NlptokenizewordPoint, b : NlptokenizewordPoint) -> NlptokenizewordPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_word_point_lerp(a : NlptokenizewordPoint, b : NlptokenizewordPoint, t : Double) -> NlptokenizewordPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_word_point_to_string(pt : NlptokenizewordPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizewordSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_word_make_series(vals : Array[Double], name : String) -> NlptokenizewordSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_word_series_len(s : NlptokenizewordSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_word_series_sum(s : NlptokenizewordSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_tokenize_word_series_mean(s : NlptokenizewordSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_word_series_min(s : NlptokenizewordSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_word_series_max(s : NlptokenizewordSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_word_series_range(s : NlptokenizewordSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_word_series_var(s : NlptokenizewordSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_word_series_std(s : NlptokenizewordSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_word_series_median(s : NlptokenizewordSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_word_series_scale(s : NlptokenizewordSeries, f : Double) -> NlptokenizewordSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_word_series_add(a : NlptokenizewordSeries, b : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_word_series_sub(a : NlptokenizewordSeries, b : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_word_series_normalize(s : NlptokenizewordSeries) -> NlptokenizewordSeries {
  let mn = nlp_tokenize_word_series_min(s)
  let mx = nlp_tokenize_word_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_word_series_cumsum(s : NlptokenizewordSeries) -> NlptokenizewordSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_word_series_to_string(s : NlptokenizewordSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizewordMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_word_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizewordMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_word_matrix_identity(n : Int) -> NlptokenizewordMatrix {
  let m = nlp_tokenize_word_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_word_matrix_get(m : NlptokenizewordMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_word_matrix_transpose(m : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  let result = nlp_tokenize_word_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_word_matrix_add(a : NlptokenizewordMatrix, b : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_word_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_word_matrix_scale(m : NlptokenizewordMatrix, s : Double) -> NlptokenizewordMatrix {
  let result = nlp_tokenize_word_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_word_matrix_multiply(a : NlptokenizewordMatrix, b : NlptokenizewordMatrix) -> NlptokenizewordMatrix {
  if a.cols != b.rows { return nlp_tokenize_word_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_word_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_word_matrix_trace(m : NlptokenizewordMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_word_matrix_det(m : NlptokenizewordMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_word_matrix_norm(m : NlptokenizewordMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_word_matrix_to_string(m : NlptokenizewordMatrix) -> String {
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

pub(all) struct NlptokenizewordVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_word_make_vector(comps : Array[Double]) -> NlptokenizewordVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_word_vector_zero(dim : Int) -> NlptokenizewordVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_word_vector_add(a : NlptokenizewordVector, b : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_word_vector_sub(a : NlptokenizewordVector, b : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_word_vector_scale(v : NlptokenizewordVector, s : Double) -> NlptokenizewordVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_word_vector_dot(a : NlptokenizewordVector, b : NlptokenizewordVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_word_vector_norm(v : NlptokenizewordVector) -> Double { @_common.sqrt(nlp_tokenize_word_vector_dot(v, v)) }

pub fn nlp_tokenize_word_vector_normalize(v : NlptokenizewordVector) -> NlptokenizewordVector {
  let n = nlp_tokenize_word_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_word_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_word_vector_dist(a : NlptokenizewordVector, b : NlptokenizewordVector) -> Double {
  nlp_tokenize_word_vector_norm(nlp_tokenize_word_vector_sub(a, b))
}

pub fn nlp_tokenize_word_vector_to_string(v : NlptokenizewordVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_word_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_word_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_word_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_word_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_word_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_word_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_word_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_word_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_word_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_word_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_word_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_word_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_word_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_word_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_word_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_word_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_word_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_word_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_word_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_word_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_word_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_word_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_word_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_word_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_word_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_word_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_word_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_word_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_word_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizewordFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_frame_make(size : Int) -> NlptokenizewordFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_frame_len(s : NlptokenizewordFrame) -> Int { s.size }

pub fn nlp_tokenize_word_frame_get(s : NlptokenizewordFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_frame_set(s : NlptokenizewordFrame, i : Int, v : Double) -> NlptokenizewordFrame {
  let result = nlp_tokenize_word_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_frame_sum(s : NlptokenizewordFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_frame_mean(s : NlptokenizewordFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_frame_scale(s : NlptokenizewordFrame, f : Double) -> NlptokenizewordFrame {
  let result = nlp_tokenize_word_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_frame_add(a : NlptokenizewordFrame, b : NlptokenizewordFrame) -> NlptokenizewordFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_frame_copy(s : NlptokenizewordFrame) -> NlptokenizewordFrame {
  let result = nlp_tokenize_word_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_frame_fill(s : NlptokenizewordFrame, v : Double) -> NlptokenizewordFrame {
  let result = nlp_tokenize_word_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_frame_min(s : NlptokenizewordFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_frame_max(s : NlptokenizewordFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_frame_to_string(s : NlptokenizewordFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_table_make(size : Int) -> NlptokenizewordTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_table_len(s : NlptokenizewordTable) -> Int { s.size }

pub fn nlp_tokenize_word_table_get(s : NlptokenizewordTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_table_set(s : NlptokenizewordTable, i : Int, v : Double) -> NlptokenizewordTable {
  let result = nlp_tokenize_word_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_table_sum(s : NlptokenizewordTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_table_mean(s : NlptokenizewordTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_table_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_table_scale(s : NlptokenizewordTable, f : Double) -> NlptokenizewordTable {
  let result = nlp_tokenize_word_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_table_add(a : NlptokenizewordTable, b : NlptokenizewordTable) -> NlptokenizewordTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_table_copy(s : NlptokenizewordTable) -> NlptokenizewordTable {
  let result = nlp_tokenize_word_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_table_fill(s : NlptokenizewordTable, v : Double) -> NlptokenizewordTable {
  let result = nlp_tokenize_word_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_table_min(s : NlptokenizewordTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_table_max(s : NlptokenizewordTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_table_to_string(s : NlptokenizewordTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_graphn_make(size : Int) -> NlptokenizewordGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_graphn_len(s : NlptokenizewordGraphN) -> Int { s.size }

pub fn nlp_tokenize_word_graphn_get(s : NlptokenizewordGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_graphn_set(s : NlptokenizewordGraphN, i : Int, v : Double) -> NlptokenizewordGraphN {
  let result = nlp_tokenize_word_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_graphn_sum(s : NlptokenizewordGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_graphn_mean(s : NlptokenizewordGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_graphn_scale(s : NlptokenizewordGraphN, f : Double) -> NlptokenizewordGraphN {
  let result = nlp_tokenize_word_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_graphn_add(a : NlptokenizewordGraphN, b : NlptokenizewordGraphN) -> NlptokenizewordGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_graphn_copy(s : NlptokenizewordGraphN) -> NlptokenizewordGraphN {
  let result = nlp_tokenize_word_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_graphn_fill(s : NlptokenizewordGraphN, v : Double) -> NlptokenizewordGraphN {
  let result = nlp_tokenize_word_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_graphn_min(s : NlptokenizewordGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_graphn_max(s : NlptokenizewordGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_graphn_to_string(s : NlptokenizewordGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_node_make(size : Int) -> NlptokenizewordNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_node_len(s : NlptokenizewordNode) -> Int { s.size }

pub fn nlp_tokenize_word_node_get(s : NlptokenizewordNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_node_set(s : NlptokenizewordNode, i : Int, v : Double) -> NlptokenizewordNode {
  let result = nlp_tokenize_word_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_node_sum(s : NlptokenizewordNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_node_mean(s : NlptokenizewordNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_node_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_node_scale(s : NlptokenizewordNode, f : Double) -> NlptokenizewordNode {
  let result = nlp_tokenize_word_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_node_add(a : NlptokenizewordNode, b : NlptokenizewordNode) -> NlptokenizewordNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_node_copy(s : NlptokenizewordNode) -> NlptokenizewordNode {
  let result = nlp_tokenize_word_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_node_fill(s : NlptokenizewordNode, v : Double) -> NlptokenizewordNode {
  let result = nlp_tokenize_word_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_node_min(s : NlptokenizewordNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_node_max(s : NlptokenizewordNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_node_to_string(s : NlptokenizewordNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_edge_make(size : Int) -> NlptokenizewordEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_edge_len(s : NlptokenizewordEdge) -> Int { s.size }

pub fn nlp_tokenize_word_edge_get(s : NlptokenizewordEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_edge_set(s : NlptokenizewordEdge, i : Int, v : Double) -> NlptokenizewordEdge {
  let result = nlp_tokenize_word_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_edge_sum(s : NlptokenizewordEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_edge_mean(s : NlptokenizewordEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_edge_scale(s : NlptokenizewordEdge, f : Double) -> NlptokenizewordEdge {
  let result = nlp_tokenize_word_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_edge_add(a : NlptokenizewordEdge, b : NlptokenizewordEdge) -> NlptokenizewordEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_edge_copy(s : NlptokenizewordEdge) -> NlptokenizewordEdge {
  let result = nlp_tokenize_word_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_edge_fill(s : NlptokenizewordEdge, v : Double) -> NlptokenizewordEdge {
  let result = nlp_tokenize_word_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_edge_min(s : NlptokenizewordEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_edge_max(s : NlptokenizewordEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_edge_to_string(s : NlptokenizewordEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_path_make(size : Int) -> NlptokenizewordPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_path_len(s : NlptokenizewordPath) -> Int { s.size }

pub fn nlp_tokenize_word_path_get(s : NlptokenizewordPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_path_set(s : NlptokenizewordPath, i : Int, v : Double) -> NlptokenizewordPath {
  let result = nlp_tokenize_word_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_path_sum(s : NlptokenizewordPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_path_mean(s : NlptokenizewordPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_path_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_path_scale(s : NlptokenizewordPath, f : Double) -> NlptokenizewordPath {
  let result = nlp_tokenize_word_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_path_add(a : NlptokenizewordPath, b : NlptokenizewordPath) -> NlptokenizewordPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_path_copy(s : NlptokenizewordPath) -> NlptokenizewordPath {
  let result = nlp_tokenize_word_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_path_fill(s : NlptokenizewordPath, v : Double) -> NlptokenizewordPath {
  let result = nlp_tokenize_word_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_path_min(s : NlptokenizewordPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_path_max(s : NlptokenizewordPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_path_to_string(s : NlptokenizewordPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_cluster_make(size : Int) -> NlptokenizewordCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_cluster_len(s : NlptokenizewordCluster) -> Int { s.size }

pub fn nlp_tokenize_word_cluster_get(s : NlptokenizewordCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_cluster_set(s : NlptokenizewordCluster, i : Int, v : Double) -> NlptokenizewordCluster {
  let result = nlp_tokenize_word_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_cluster_sum(s : NlptokenizewordCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_cluster_mean(s : NlptokenizewordCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_cluster_scale(s : NlptokenizewordCluster, f : Double) -> NlptokenizewordCluster {
  let result = nlp_tokenize_word_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_cluster_add(a : NlptokenizewordCluster, b : NlptokenizewordCluster) -> NlptokenizewordCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_cluster_copy(s : NlptokenizewordCluster) -> NlptokenizewordCluster {
  let result = nlp_tokenize_word_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_cluster_fill(s : NlptokenizewordCluster, v : Double) -> NlptokenizewordCluster {
  let result = nlp_tokenize_word_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_cluster_min(s : NlptokenizewordCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cluster_max(s : NlptokenizewordCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cluster_to_string(s : NlptokenizewordCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_model_make(size : Int) -> NlptokenizewordModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_model_len(s : NlptokenizewordModel) -> Int { s.size }

pub fn nlp_tokenize_word_model_get(s : NlptokenizewordModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_model_set(s : NlptokenizewordModel, i : Int, v : Double) -> NlptokenizewordModel {
  let result = nlp_tokenize_word_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_model_sum(s : NlptokenizewordModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_model_mean(s : NlptokenizewordModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_model_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_model_scale(s : NlptokenizewordModel, f : Double) -> NlptokenizewordModel {
  let result = nlp_tokenize_word_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_model_add(a : NlptokenizewordModel, b : NlptokenizewordModel) -> NlptokenizewordModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_model_copy(s : NlptokenizewordModel) -> NlptokenizewordModel {
  let result = nlp_tokenize_word_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_model_fill(s : NlptokenizewordModel, v : Double) -> NlptokenizewordModel {
  let result = nlp_tokenize_word_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_model_min(s : NlptokenizewordModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_model_max(s : NlptokenizewordModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_model_to_string(s : NlptokenizewordModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_layer_make(size : Int) -> NlptokenizewordLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_layer_len(s : NlptokenizewordLayer) -> Int { s.size }

pub fn nlp_tokenize_word_layer_get(s : NlptokenizewordLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_layer_set(s : NlptokenizewordLayer, i : Int, v : Double) -> NlptokenizewordLayer {
  let result = nlp_tokenize_word_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_layer_sum(s : NlptokenizewordLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_layer_mean(s : NlptokenizewordLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_layer_scale(s : NlptokenizewordLayer, f : Double) -> NlptokenizewordLayer {
  let result = nlp_tokenize_word_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_layer_add(a : NlptokenizewordLayer, b : NlptokenizewordLayer) -> NlptokenizewordLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_layer_copy(s : NlptokenizewordLayer) -> NlptokenizewordLayer {
  let result = nlp_tokenize_word_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_layer_fill(s : NlptokenizewordLayer, v : Double) -> NlptokenizewordLayer {
  let result = nlp_tokenize_word_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_layer_min(s : NlptokenizewordLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_layer_max(s : NlptokenizewordLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_layer_to_string(s : NlptokenizewordLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_buffer_make(size : Int) -> NlptokenizewordBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_buffer_len(s : NlptokenizewordBuffer) -> Int { s.size }

pub fn nlp_tokenize_word_buffer_get(s : NlptokenizewordBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_buffer_set(s : NlptokenizewordBuffer, i : Int, v : Double) -> NlptokenizewordBuffer {
  let result = nlp_tokenize_word_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_buffer_sum(s : NlptokenizewordBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_buffer_mean(s : NlptokenizewordBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_buffer_scale(s : NlptokenizewordBuffer, f : Double) -> NlptokenizewordBuffer {
  let result = nlp_tokenize_word_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_buffer_add(a : NlptokenizewordBuffer, b : NlptokenizewordBuffer) -> NlptokenizewordBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_buffer_copy(s : NlptokenizewordBuffer) -> NlptokenizewordBuffer {
  let result = nlp_tokenize_word_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_buffer_fill(s : NlptokenizewordBuffer, v : Double) -> NlptokenizewordBuffer {
  let result = nlp_tokenize_word_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_buffer_min(s : NlptokenizewordBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_buffer_max(s : NlptokenizewordBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_buffer_to_string(s : NlptokenizewordBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_cursor_make(size : Int) -> NlptokenizewordCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_cursor_len(s : NlptokenizewordCursor) -> Int { s.size }

pub fn nlp_tokenize_word_cursor_get(s : NlptokenizewordCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_cursor_set(s : NlptokenizewordCursor, i : Int, v : Double) -> NlptokenizewordCursor {
  let result = nlp_tokenize_word_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_cursor_sum(s : NlptokenizewordCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_cursor_mean(s : NlptokenizewordCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_cursor_scale(s : NlptokenizewordCursor, f : Double) -> NlptokenizewordCursor {
  let result = nlp_tokenize_word_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_cursor_add(a : NlptokenizewordCursor, b : NlptokenizewordCursor) -> NlptokenizewordCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_cursor_copy(s : NlptokenizewordCursor) -> NlptokenizewordCursor {
  let result = nlp_tokenize_word_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_cursor_fill(s : NlptokenizewordCursor, v : Double) -> NlptokenizewordCursor {
  let result = nlp_tokenize_word_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_cursor_min(s : NlptokenizewordCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cursor_max(s : NlptokenizewordCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_cursor_to_string(s : NlptokenizewordCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_view_make(size : Int) -> NlptokenizewordView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_view_len(s : NlptokenizewordView) -> Int { s.size }

pub fn nlp_tokenize_word_view_get(s : NlptokenizewordView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_view_set(s : NlptokenizewordView, i : Int, v : Double) -> NlptokenizewordView {
  let result = nlp_tokenize_word_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_view_sum(s : NlptokenizewordView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_view_mean(s : NlptokenizewordView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_view_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_view_scale(s : NlptokenizewordView, f : Double) -> NlptokenizewordView {
  let result = nlp_tokenize_word_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_view_add(a : NlptokenizewordView, b : NlptokenizewordView) -> NlptokenizewordView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_view_copy(s : NlptokenizewordView) -> NlptokenizewordView {
  let result = nlp_tokenize_word_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_view_fill(s : NlptokenizewordView, v : Double) -> NlptokenizewordView {
  let result = nlp_tokenize_word_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_view_min(s : NlptokenizewordView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_view_max(s : NlptokenizewordView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_view_to_string(s : NlptokenizewordView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_range_make(size : Int) -> NlptokenizewordRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_range_len(s : NlptokenizewordRange) -> Int { s.size }

pub fn nlp_tokenize_word_range_get(s : NlptokenizewordRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_range_set(s : NlptokenizewordRange, i : Int, v : Double) -> NlptokenizewordRange {
  let result = nlp_tokenize_word_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_range_sum(s : NlptokenizewordRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_range_mean(s : NlptokenizewordRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_range_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_range_scale(s : NlptokenizewordRange, f : Double) -> NlptokenizewordRange {
  let result = nlp_tokenize_word_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_range_add(a : NlptokenizewordRange, b : NlptokenizewordRange) -> NlptokenizewordRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_range_copy(s : NlptokenizewordRange) -> NlptokenizewordRange {
  let result = nlp_tokenize_word_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_range_fill(s : NlptokenizewordRange, v : Double) -> NlptokenizewordRange {
  let result = nlp_tokenize_word_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_range_min(s : NlptokenizewordRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_range_max(s : NlptokenizewordRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_range_to_string(s : NlptokenizewordRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizewordSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_word_slice_make(size : Int) -> NlptokenizewordSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_word_slice_len(s : NlptokenizewordSlice) -> Int { s.size }

pub fn nlp_tokenize_word_slice_get(s : NlptokenizewordSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_word_slice_set(s : NlptokenizewordSlice, i : Int, v : Double) -> NlptokenizewordSlice {
  let result = nlp_tokenize_word_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_slice_sum(s : NlptokenizewordSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_word_slice_mean(s : NlptokenizewordSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_word_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_word_slice_scale(s : NlptokenizewordSlice, f : Double) -> NlptokenizewordSlice {
  let result = nlp_tokenize_word_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_word_slice_add(a : NlptokenizewordSlice, b : NlptokenizewordSlice) -> NlptokenizewordSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_word_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_word_slice_copy(s : NlptokenizewordSlice) -> NlptokenizewordSlice {
  let result = nlp_tokenize_word_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_word_slice_fill(s : NlptokenizewordSlice, v : Double) -> NlptokenizewordSlice {
  let result = nlp_tokenize_word_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_word_slice_min(s : NlptokenizewordSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_slice_max(s : NlptokenizewordSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_word_slice_to_string(s : NlptokenizewordSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

